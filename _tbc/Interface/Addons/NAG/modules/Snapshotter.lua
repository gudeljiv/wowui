--- @module "NAG.Snapshotter"
--- Snapshotter module for automatic real-time snapshot recording of player stats
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
---
---    PURPOSE: Provides fully automatic real-time snapshot recording of player stats during
---    spell casts and debuff applications. Snapshots are temporary and exist only during combat.
---
---    USAGE:
---    The Snapshotter module automatically records snapshots for:
---    - Every successful spell cast by the player
---    - Every buff applied to the player
---    - Every debuff applied by the player to the target (stored by debuff spellID + target GUID)
---
---    To query stored snapshots:
---    NAG:Snapshot(arguments, spellID)
---    - arguments: string or table of stat names ("str", "agi", "int", "crit", "haste", "mastery", "ap")
---    - spellID: number of the spell to check
---    - Returns:
---      * For active DoTs: snapshot value (the stat value when the DoT was applied)
---      * For expired DoTs: current live stat values
---      * For spells without snapshots: 0
---      * For live stats only: sum of current stat values
---
---    To query percentage differences:
---    NAG:SnapshotPercent(spellID, stat1, stat2, ...)
---    - spellID: number of the spell to check (required) - will also search by spell name if no direct match
---    - stat1, stat2, ...: stat names to compare
---    - Returns: percentage difference as decimal (0.2 = 20% increase, -0.1 = 10% decrease)
---      * Formula: (current_total / snapshot_total) - 1
---      * Returns 0 if no snapshot exists or snapshot total is 0
---      * If spellID not found, searches snapshots by matching spell names
---
---    To query DoT damage increase based on attack power:
---    NAG:DotPercentIncrease(spellID)
---    - spellID: number of the DoT spell to check (required) - will also search by spell name if no direct match
---    - Returns: attack power percentage difference (0.15 = 15% damage increase)
---      * Specialized function for DoT effects that snapshot attack power
---      * Works with any spell ID that has the same name as the applied DoT
---
---    EXAMPLES:
---    - NAG:Snapshot("ap", 59921) - Get AP snapshot for Frost Fever (works in all locales)
---    - NAG:Snapshot("ap", 55078) - Get AP snapshot for Blood Plague (works in all locales)
---    - NAG:Snapshot("str", "agi") - Get current strength + agility (no spellID)
---    - NAG:Snapshot(12345, "crit", "haste") - Get crit+haste snapshot for spell 12345
---    - NAG:SnapshotPercent(59879, "ap") - Get AP percentage change for spell 59879
---    - NAG:SnapshotPercent(12345, "crit", "haste") - Get combined crit+haste percentage change
---    - NAG:DotPercentIncrease(1079) - Get damage increase for Rip DoT based on AP change
---    - NAG:DotPercentIncrease(59879) - Works even if 59879 applies "Blood Plague" but 55078 is the actual debuff
---
---    DEBUG COMMANDS:
---    - /nagsnapshot - List all stored spellIDs with spell names and active buffs/debuffs
---    - /nagsnapshot <spellID> - Show detailed stored stats for specific spellID
---    - /nagsnapshot debug on - Enable debug output for snapshotter events
---    - /nagsnapshot debug off - Disable debug output for snapshotter events
---
---    DEBUG CONTROL:
---    Debug output is controlled by Snapshotter.enableDebugOutput (default: false)
---    Change this manually or use the debug commands above to toggle debug logging

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
--Addon
local _, ns = ...
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitName = _G.UnitName
local Version = ns.Version
local UnitStat = _G.UnitStat
local UnitSpellHaste = _G.UnitSpellHaste
local UnitDamage = _G.UnitDamage
local GetMasteryEffect = _G.GetMasteryEffect
local GetCritChance = _G.GetCritChance
local UnitLevel = _G.UnitLevel
local GetComboPoints = _G.GetComboPoints
local GetHaste = _G.GetHaste
local GetMeleeHaste = _G.GetMeleeHaste
local UnitAttackPower = _G.UnitAttackPower
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetSpellCritChance = _G.GetSpellCritChance
local GetSpellBonusDamage = _G.GetSpellBonusDamage
local CreateFrame = _G.CreateFrame
local WoWAPI = ns.WoWAPI
local IsInInstance = _G.IsInInstance
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @type DataManager
local DataManager

--- @type SpecCompat
local SpecCompat

local L = ns.AceLocale:GetLocale("NAG", true)



-- Compatibility functions for stats that might not exist in all versions
local function GetCritChanceCompat()
    if GetCritChance then
        return GetCritChance()
    elseif GetCritChanceFrom and GetCritChanceFrom(2) then -- 2 = melee crit
        return GetCritChanceFrom(2)
    else
        return 0
    end
end

local function GetHasteCompat()
    return GetHaste() or GetMeleeHaste() or 0
end

local function GetSpellCritChanceCompat(school)
    if GetSpellCritChance then
        local crit = GetSpellCritChance(school or 6)
        if type(crit) == "number" then
            return crit > 100 and 100 or crit
        end
    end
    return GetCritChanceCompat()
end

local function ResolveActionIdentity(id, context, opts)
    if DataManager and DataManager.GetIdentity then
        return DataManager:GetIdentity(id, context, opts)
    end
    return nil
end

local function GetCachedSpellInfo(spellID)
    if DataManager and DataManager.GetCachedSpellInfo then
        return DataManager:GetCachedSpellInfo(spellID)
    end
    return WoWAPI.GetSpellInfo(spellID)
end

-- ============================ AURA SAFETY HELPERS ============================
-- Snapshotter runs across multiple expansions, but some multiplier auras only exist in later versions.
-- Guard AuraIsActive calls so missing IDs in DataManager don't spam errors (especially on Classic/TBC).
local function SafeAuraIsActive(spellId, sourceUnit)
    if not spellId then return false end
    if not NAG or not NAG.AuraIsActive then return false end
    if not DataManager or not DataManager.Get or not DataManager.EntityTypes then return false end

    local identity = ResolveActionIdentity(spellId, "snapshot_aura")
    local entity = identity and identity.entity or (DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
        DataManager:Get(spellId, DataManager.EntityTypes.ITEM))

    if not entity then
        return false
    end

    return NAG:AuraIsActive(spellId, sourceUnit)
end

-- Dream of Cenarius detection: use direct unit buff checks to avoid DataManager gaps
local function IsDreamOfCenariusActive()
    if NAG and NAG.UnitBuff then
        if NAG:UnitBuff("player", 145152) then
            return true
        end
        if NAG:UnitBuff("player", 108373) then
            return true
        end
    end
    return SafeAuraIsActive(145152) or SafeAuraIsActive(108373)
end

local function GetSpellHastePercentCompat()
    if UnitSpellHaste then
        local v = UnitSpellHaste("player")
        if type(v) == "number" then return v end
    end
    return GetHasteCompat()
end

local function GetMasteryEffectCompat()
    if GetMasteryEffect then
        return GetMasteryEffect()
    elseif GetMastery then
        return GetMastery()
    else
        return 0
    end
end

-- External damage percent modifier (flat multiplier)
local function GetDamagePercentModCompat()
    local percent = select(7, UnitDamage("player"))
    if type(percent) == "number" and percent > 0 then
        return percent
    end
    return 1
end

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local wipe = wipe
local tinsert = tinsert
local unpack = unpack
local ceil = ceil
local floor = math.floor

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Constants
local CONSTANTS = {
    VALID_STATS = {
        str = true,
        agi = true,
        int = true,
        crit = true,
        haste = true,
        mastery = true,
        ap = true,
        sp = true
    },
    STAT_INDICES = {
        str = 1,
        agi = 2,
        int = 4
    }
}

-- Monk: Tigereye Brew tracking
local TEB_BUFF_ID = 1247275
local TEB_STACK_ID = 1247279

-- Preferred snapshot comparison stats for specific spells (by spellID)
-- Used by DotPercentIncrease to choose the best stat(s) before falling back to AP.
local PREFERRED_STATS_BY_SPELL = {
    [1079] = {"ap"},    -- Rip (Feral Druid)
}

-- Classes that are always treated as pure physical for fallback purposes
local PURE_PHYSICAL_CLASS = {
    WARRIOR = true,
    DEATHKNIGHT = true,
    ROGUE = true,
    HUNTER = true,
}

-- Feral bleed spell IDs (MoP/Mists)
local FERAL_BLEED_SPELLS = {
    [1079] = true,   -- Rip
    [1822] = true,   -- Rake
    [106830] = true, -- Thrash (Cat)
}

local FERAL_PENDING_EXPIRE_SECONDS = 3.0

-- Death Knight: Pestilence cast ID (track target to exclude from snapshot on spread)
local DK_PESTILENCE = 50842
local DK_BLOOD_PLAGUE = 55078
local FOF_STACK_AURA_ID = 138758

-- Snapshot overlay profiles: id -> { spellIDs, tickIntervalSeconds, computePredictedFn, messageName, classTag }
-- Used by generic getters and CLEU to send per-profile update messages. DisplayManager uses these for overlay UI.
local SNAPSHOT_OVERLAY_PROFILES = {
    dk_disease = {
        id = "dk_disease",
        spellIDs = { 55095, 55078 }, -- Frost Fever, Blood Plague
        tickIntervalSeconds = 3,
        computePredictedFn = "ComputeDKDoTPredicted",
        messageName = "NAG_SNAPSHOT_OVERLAY_UPDATED",
        classTag = "DEATHKNIGHT",
    },
    feral_bleed = {
        id = "feral_bleed",
        spellIDs = { 1079, 1822, 106830 }, -- Rip, Rake, Thrash (Cat)
        tickIntervalSeconds = 24,          -- Rip duration; DPS = total/24
        computePredictedFn = "ComputeFeralDoTPredicted",
        messageName = "NAG_SNAPSHOT_OVERLAY_UPDATED",
        classTag = "DRUID",
    },
}

-- Canonical spellIDs used when forcing on-demand snapshots to align with stored debuff keys
local CANONICAL_SNAPSHOT_IDS = {
    172,     -- Corruption
    146739,  -- Corruption (Aura)
    980,     -- Agony
    30108,   -- Unstable Affliction
    348,     -- Immolate
    108686,  -- Immolate (Fire and Brimstone)
    603,     -- Doom
    1120,    -- Drain Soul
    103103,  -- Malefic Grasp
    1079,    -- Rip
    1822,    -- Rake
    106830,  -- Thrash (Cat)
    55095,   -- Frost Fever
    55078    -- Blood Plague
}


-- Default settings (minimal since this is a backend module)
local defaults = {
    global = {
        version = 1,
    }
}

--- @class Snapshotter : CoreModule
local Snapshotter = NAG:CreateModule("Snapshotter", defaults, {

    -- Event handlers using eventHandlers table
    eventHandlers = {
        UNIT_SPELLCAST_SUCCEEDED = true,
        PLAYER_REGEN_ENABLED = true,
        PLAYER_REGEN_DISABLED = true,
        UNIT_SPELLCAST_START = true,
        UNIT_SPELLCAST_CHANNEL_START = true,
        UNIT_SPELLCAST_SENT = true,
    },
    cleuHandlers = {
        SPELL_AURA_APPLIED = "HandleAuraAppliedOrRefresh",
        SPELL_AURA_REFRESH = "HandleAuraAppliedOrRefresh",
        SPELL_AURA_REMOVED = "HandleAuraRemoved",
    },

    -- Message handlers for cross-module messages
    messageHandlers = {
        NAG_SPEC_UPDATED = true,
    },

    -- Default state
    defaultState = {
        -- snapshots[spellID][destGUID] -> snapshot table
        -- destGUID may be "*" for non-targeted snapshots (e.g., buffs, channels, casts)
        snapshots = {},
        -- snapshotsByTargetName[spellID][destName] -> last snapshot table (fallback for boss GUID swaps)
        -- Note: name is not unique, but this fallback is only used when GUID swaps mid-encounter.
        snapshotsByTargetName = {},
        -- activeBuffs[spellID] -> true (player buffs)
        activeBuffs = {},
        -- activeDebuffs[spellID][destGUID] -> true
        activeDebuffs = {},
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["snapshot_debug"] = {
            handler = "HandleSnapshotSlashCommand",
            help = "Debug and inspect spell snapshots. Usage: /nagdebug snapshot debug [spellID|debug on|debug off]",
            root = "nagdebug",
            path = {"snapshot", "debug"},
            category = "Debug"
        }
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.TRACKERS
    }
})
local module = Snapshotter
ns.Snapshotter = Snapshotter

-- Debug control - set to true to enable debug output, false to disable
Snapshotter.enableDebugOutput = false

--- Conditional debug output - only prints if debug is enabled
function Snapshotter:DebugPrint(message, ...)
    if self.enableDebugOutput then
        self:Debug(message, ...)
    end
end

--- Normalize spellID for snapshot storage/lookup.
--- Some spells have cast IDs that differ from the applied debuff ID (e.g., DK diseases),
--- and some expansions have variant spellIDs with identical names (canonicalization).
--- @param spellID number
--- @return number
function Snapshotter:NormalizeSnapshotSpellID(spellID)
    if not spellID then
        return spellID
    end
    local identity = ResolveActionIdentity(spellID, "snapshot_normalize")
    if identity and identity.spellId then
        spellID = identity.spellId
    end
    -- Important: some spells share the same localized name but are distinct auras and must NOT be canonicalized.
    -- Example: Thrash has separate Cat (106830) and Bear (77758) debuffs with identical name/icon in some clients.
    if spellID == 106830 or spellID == 77758 then
        return spellID
    end
    -- DK: cast IDs -> debuff IDs
    if spellID == 45477 then return 55095 end -- Icy Touch -> Frost Fever
    if spellID == 45462 then return 55078 end -- Plague Strike -> Blood Plague
    return self:ResolveCanonicalSnapshotSpellID(spellID) or spellID
end

local function GetSpellPowerCompat(school)
    if GetSpellBonusDamage then
        return GetSpellBonusDamage(school or 6) or 0
    end
    return 0
end

-- Extract the first numeric total damage value from a spell tooltip by ID
-- Returns number or nil
function Snapshotter:GetSpellTooltipDamage(spellID)
    if not spellID or not self.scanningSpellTooltip or not self.scanningSpellTooltip.SetSpellByID then
        return nil
    end
    local tt = self.scanningSpellTooltip
    tt:ClearLines()
    tt:SetSpellByID(spellID)
    local num = tt:NumLines() or 0
    local rangeAvg, dotTotal = nil, nil
    for i = 2, math.min(num, 12) do
        local lineObj = _G[tt:GetName() .. "TextLeft" .. i]
        if lineObj then
            local text = lineObj:GetText()
            if text and text ~= "" then
                -- Skip resource/cost lines
                if not text:find("Mana") and not text:find("Focus") and not text:find("Energy") then
                    -- Prefer direct damage range: "5,275 to 5,444 ... damage"
                    local minStr, maxStr = text:match("([%d,]+)%s*[Tt][Oo]%s*([%d,]+).-[Dd]amage")
                    if minStr and maxStr then
                        local minV = tonumber((minStr:gsub(",", "")), 10)
                        local maxV = tonumber((maxStr:gsub(",", "")), 10)
                        if minV and maxV and minV > 0 and maxV > 0 then
                            rangeAvg = (minV + maxV) * 0.5
                            if spellID == 8921 or spellID == 93402 then
                                -- print("TooltipDamage range: spellID=" .. tostring(spellID) .. " line=" .. tostring(i) .. " min=" .. tostring(minV) .. " max=" .. tostring(maxV) .. " avg=" .. tostring(rangeAvg) .. " text='" .. tostring(text) .. "'")
                            end
                        end
                    end

                    -- Capture DoT total if present: "additional 38,965 ... damage over"
                    if not dotTotal then
                        local dotStr = text:match("[Aa]dditional%s+([%d,]+).-[Dd]amage%s+[Oo]ver")
                        if dotStr then
                            local dotV = tonumber((dotStr:gsub(",", "")), 10)
                            if dotV and dotV > 0 then
                                dotTotal = dotV
                                if spellID == 8921 or spellID == 93402 then
                                    -- print("TooltipDamage dot: spellID=" .. tostring(spellID) .. " line=" .. tostring(i) .. " total=" .. tostring(dotTotal) .. " text='" .. tostring(text) .. "'")
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local chosen = rangeAvg or dotTotal
    if spellID == 8921 or spellID == 93402 then
        -- print("TooltipDamage extract: spellID=" .. tostring(spellID) .. " chosen=" .. tostring(chosen) .. " (rangeAvg=" .. tostring(rangeAvg) .. ", dotTotal=" .. tostring(dotTotal) .. ")")
    end
    return chosen
end

local function GetAfflictionMasteryMultiplierCompat()
    -- Prefer GetMastery points if available to apply 3.1% per point
    if GetMastery then
        local masteryPoints = GetMastery()
        if type(masteryPoints) == "number" then
            return 1 + ((masteryPoints * 3.1) / 100)
        end
    end
    -- Fallback to effect percent from compat (already includes spec scaling)
    local effectPercent = GetMasteryEffectCompat() or 0
    return 1 + (effectPercent / 100)
end

-- Debug helpers to limit prints to Corruption only
local function GetRipName()
    local spellInfo = GetCachedSpellInfo(1079)
    return spellInfo and spellInfo.name or "Rip"
end

local function IsRipByID(spellID)
    local spellInfo = spellID and GetCachedSpellInfo(spellID)
    local name = spellInfo and spellInfo.name
    local rip = GetRipName()
    return type(name) == "string" and name:lower() == rip:lower()
end

local function IsRipByName(name)
    local rip = GetRipName()
    return type(name) == "string" and name:lower() == rip:lower()
end

local function PrintIfRipByID(spellID, message)
    if IsRipByID(spellID) then
        -- print(message)
    end
end

local function PrintIfRipByName(name, message)
    if IsRipByName(name) then
        -- print(message)
    end
end

local function PrintIfRipEither(spellID, referenceID, message)
    if IsRipByID(spellID) or IsRipByID(referenceID) then
        -- print(message)
    end
end

-- ============================ SNAPSHOT RESOLUTION HELPERS ============================

--- Resolve a canonical spellID for snapshot storage to keep key names stable
--- @param spellID number
--- @return number|nil
function Snapshotter:ResolveCanonicalSnapshotSpellID(spellID)
    if not spellID then
        return nil
    end
    for _, canonicalID in ipairs(CANONICAL_SNAPSHOT_IDS) do
        if self:SpellMatchesByName(spellID, canonicalID) then
            return canonicalID
        end
    end
    return spellID
end

--- Ensure a snapshot exists for an active DoT by capturing it on demand when missing
--- @param spellID number
--- @param targetUnit string|nil
--- @param reasonSuffix string|nil
--- @return table|nil snapshot
--- @return number|nil resolvedSnapshotSpellID
function Snapshotter:EnsureSnapshotForSpell(spellID, targetUnit, reasonSuffix)
    if not spellID then
        return nil
    end

    local unit = targetUnit
    if not unit or unit == "" then
        unit = "target"
    end
    if unit == "*" then
        return nil
    end

    if not UnitExists(unit) then
        if unit ~= "target" and UnitExists("target") then
            unit = "target"
        else
            return nil
        end
    end

    local guid = UnitGUID(unit)
    if not guid then
        return nil
    end

    local normalizedID = self:NormalizeSnapshotSpellID(spellID) or spellID
    local map = self.state and self.state.snapshots and self.state.snapshots[normalizedID]
    if type(map) == "table" then
        local existing = map[guid] or map["*"]
        if existing then
            return existing, normalizedID
        end
    end

    if not (NAG and NAG.DotIsActiveByPlayer and NAG:DotIsActiveByPlayer(spellID, unit, false)) then
        return nil
    end

    -- CaptureSnapshot will normalize spellID for storage internally
    self:CaptureSnapshot({ spellID = spellID, destGUID = guid }, reasonSuffix or "ensure snapshot")

    local newMap = self.state and self.state.snapshots and self.state.snapshots[normalizedID]
    if type(newMap) == "table" then
        local created = newMap[guid] or newMap["*"]
        if created then
            return created, normalizedID
        end
    end

    return nil
end

local function GetDestructionMasteryMultiplierCompat()
    -- Destro formula provided: 1 + (1 + GetMastery()) / 100
    if GetMastery then
        local masteryPoints = GetMastery()
        if type(masteryPoints) == "number" then
            return 1 + ((1 + masteryPoints) / 100)
        end
    end
    -- Approximate using effect percent
    local effectPercent = GetMasteryEffectCompat() or 0
    return 1 + ((1 + effectPercent) / 100)
end

--- Refresh cached player class and spec info for fast-path decisions
function Snapshotter:RefreshClassSpecCache()
    -- Cache class tag
    local classTag = NAG.CLASS_FILENAME
    self.cachedClassTag = classTag
    self.cachedIsPurePhysical = PURE_PHYSICAL_CLASS[classTag] == true

    -- Cache role, primary stat, and spec index via SpecCompat (handles version differences)
    local role, primaryUpper = nil, nil
    if SpecCompat then
        local specInfo = SpecCompat:GetSpecInfo()
        if specInfo then
            role = specInfo.role
            if type(specInfo.primaryStat) == "string" then
                primaryUpper = specInfo.primaryStat:upper()
            end
        end
        local specIndex = SpecCompat:GetCurrentSpecIndex()
        self.cachedSpecIndex = specIndex
    else
        self.cachedSpecIndex = nil
    end
    self.cachedSpecRole = role
    self.cachedPrimaryStatUpper = primaryUpper
end

--- Message: NAG_SPEC_UPDATED - recache on spec changes
function Snapshotter:NAG_SPEC_UPDATED(...)
    self:RefreshClassSpecCache()
end

--- Get class/spec-based fallback stats using cached values
function Snapshotter:GetClassSpecFallbackStatsCached()
    if self.cachedIsPurePhysical then
        return {"ap"}
    end
    if self.cachedSpecRole == "HEALER" then
        return {"int"}
    end
    if self.cachedPrimaryStatUpper == "INTELLECT" then
        return {"int"}
    end
    if self.cachedClassTag == "MAGE" or self.cachedClassTag == "WARLOCK" or self.cachedClassTag == "PRIEST" then
        return {"int"}
    end
    return {"ap"}
end

--- Get debuff name from spellID, handling localization
function Snapshotter:GetDebuffName(spellID)
    if not spellID then
        return nil
    end

    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local debuffName = spellInfo and spellInfo.name
    if not debuffName or debuffName == "" then
        self:DebugPrint(format("Could not resolve debuff name for spellID %d", spellID))
        return nil
    end

    return debuffName
end

--- Check if a spellID matches a reference spell by localized name equality
--- This guards math application against variant IDs by ensuring names align
--- @param spellID number
--- @param referenceID number
--- @return boolean
function Snapshotter:SpellMatchesByName(spellID, referenceID)
    if not spellID or not referenceID then return false end
    local spellInfoA = WoWAPI.GetSpellInfo(spellID)
    local spellInfoB = WoWAPI.GetSpellInfo(referenceID)
    local nameA = spellInfoA and spellInfoA.name
    local nameB = spellInfoB and spellInfoB.name
    if not nameA or not nameB or nameA == "" or nameB == "" then
        -- print("SpellMatchesByName debug: missing names for A=" .. tostring(spellID) .. "->" .. tostring(nameA) .. ", B=" .. tostring(referenceID) .. "->" .. tostring(nameB))
        return false
    end
    if nameA == nameB then
        -- print("SpellMatchesByName debug: exact match '" .. nameA .. "'")
        return true
    end
    local eq = (nameA:lower() == nameB:lower())
    -- print("SpellMatchesByName debug: lower match? " .. tostring(eq) .. " '" .. nameA .. "' vs '" .. nameB .. "'")
    return eq
end

--- Check if a debuff is currently active on the target
function Snapshotter:IsDebuffActive(spellID, destGUID)
    if not spellID then
        return false
    end

    if destGUID then
        local map = self.state.activeDebuffs[spellID]
        return map and map[destGUID] == true or false
    end
    -- Any GUID active for that debuff spellID
    local map = self.state.activeDebuffs[spellID]
    if not map then return false end
    for _, v in pairs(map) do if v then return true end end
    return false
end

--- Check if we should store a new snapshot for a debuff
function Snapshotter:ShouldStoreSnapshot(snapshotSpellID, debuffNameForLog, eventType, rawSpellID, destGUID)
    if not snapshotSpellID then
        return false
    end
    -- Frost DK: never store Frost Fever (Howling Blast constantly refreshes it; only Blood Plague is tracked)
    if snapshotSpellID == 55095 and self.cachedClassTag == "DEATHKNIGHT" and self.cachedSpecIndex == 2 then
        return false
    end
    local debuffName = debuffNameForLog or tostring(snapshotSpellID)

    -- Resolve existing snapshot (GUID-scoped)
    local existingMap = self.state.snapshots[snapshotSpellID]
    local existingSnapshot = nil
    if type(existingMap) == "table" then
        existingSnapshot = (destGUID and existingMap[destGUID]) or existingMap["*"] or nil
    end

    -- Always store if no previous snapshot exists for this debuff/GUID
    if not existingMap or not existingSnapshot then
        self:DebugPrint(format("No previous snapshot for %s (guid=%s), storing new one", debuffName, tostring(destGUID)))
        return true
    end

    -- For SPELL_AURA_APPLIED, always store (new application)
    if eventType == "SPELL_AURA_APPLIED" then
        self:DebugPrint(format("New application of %s, storing snapshot", debuffName))
        return true
    end

    -- For SPELL_AURA_REFRESH, update only if this looks like a manual re-apply (recent cast)
    if eventType == "SPELL_AURA_REFRESH" then
        local now = GetTime()
        self.lastCastTimestamps = self.lastCastTimestamps or {}
        local lastCast = self.lastCastTimestamps[rawSpellID]
        local isManualReapply = lastCast and ((now - lastCast) <= 0.6)

        -- DK: Treat disease refreshes (e.g., Outbreak/Pestilence) as manual re-apply so snapshots update
        do
            local spellInfoFF = WoWAPI.GetSpellInfo(55095)
            local spellInfoBP = WoWAPI.GetSpellInfo(55078)
            local dkFF = spellInfoFF and spellInfoFF.name or "Frost Fever"
            local dkBP = spellInfoBP and spellInfoBP.name or "Blood Plague"
            if debuffName == dkFF or debuffName == dkBP then
                isManualReapply = true
            end
        end
        -- DK: Do not snapshot the Pestilence cast target (Pestilence spreads from that target; it does not refresh the target's diseases)
        if isManualReapply and destGUID and (snapshotSpellID == 55095 or snapshotSpellID == 55078) then
            local lastPest = self.lastCastTimestamps and self.lastCastTimestamps[DK_PESTILENCE]
            if lastPest and (now - lastPest) <= 2 and self.pestilenceTargetGUID == destGUID then
                self:DebugPrint(format("DK: Skipping snapshot for Pestilence target (guid=%s)", tostring(destGUID)))
                return false
            end
        end

        -- Warlock: Treat Soulburned Soul Swap refreshes as manual re-apply so we update snapshots
        -- Applies to Corruption (172/146739), Agony (980), Unstable Affliction (30108)
        if not isManualReapply then
            local isWarlockDot = (rawSpellID == 172) or (rawSpellID == 146739) or (rawSpellID == 980) or (rawSpellID == 30108)
            if isWarlockDot then
                -- Consider recent Soul Swap cast with Soulburn active as a manual refresh trigger
                local recentSS = self.lastSoulSwapCastAt and ((now - self.lastSoulSwapCastAt) <= 2.0)
                local hadSoulburn = self.lastSoulSwapWasSoulburned or (NAG and NAG.AuraIsActive and NAG:AuraIsActive(74434))
                if recentSS and hadSoulburn then
                    isManualReapply = true
                end
            end
        end

        -- Explicit logging for Balance MF/SF to verify extension vs manual recast
        if rawSpellID == 8921 or rawSpellID == 93402 then
            if isManualReapply then
                -- print("MF/SF refresh: manual re-apply detected for '" .. tostring(debuffName) .. "' (spellID=" .. tostring(spellID) .. ") guid=" .. tostring(destGUID))
            else
                -- print("MF/SF refresh: extension detected for '" .. tostring(debuffName) .. "' (spellID=" .. tostring(spellID) .. ") guid=" .. tostring(destGUID) .. " -> preserving snapshot")
            end
        end

        if isManualReapply then
            -- Druid-specific protection: only overwrite if refresh is from the same spell that applied it
            local classTag = NAG.CLASS_FILENAME
            if classTag == "DRUID" and existingSnapshot then
                local allowOverwrite = true
                local existingID = existingSnapshot.sourceSpellID
                if existingID and rawSpellID then
                    local existingNorm = self:NormalizeSnapshotSpellID(existingID)
                    local refreshNorm = self:NormalizeSnapshotSpellID(rawSpellID)
                    if existingNorm ~= refreshNorm then
                    allowOverwrite = false
                    end
                elseif not existingID then
                    -- Fallback to name comparison when legacy snapshot lacks sourceSpellID
                    local existingName = existingSnapshot.sourceSpellName or nil
                    local spellInfo = rawSpellID and WoWAPI.GetSpellInfo(rawSpellID)
                    local currentName = spellInfo and spellInfo.name
                    if existingName and currentName and existingName:lower() ~= currentName:lower() then
                        allowOverwrite = false
                    end
                end

                if not allowOverwrite then
                    self:DebugPrint(string.format(
                        "DRUID: preserving snapshot on refresh of %s (guid=%s) (applied by %s, refreshed by %s)",
                        tostring(debuffName), tostring(destGUID), tostring(existingID or existingSnapshot.sourceSpellName or "?"), tostring(rawSpellID)))
                    return false
                end
            end
            if existingSnapshot and existingSnapshot.sourceSpellID then
                local existingNorm = self:NormalizeSnapshotSpellID(existingSnapshot.sourceSpellID)
                local refreshNorm = self:NormalizeSnapshotSpellID(rawSpellID)
                if existingNorm == refreshNorm then
                    self:DebugPrint(format("Manual re-apply detected for %s (guid=%s) via spell %d - updating snapshot", debuffName, tostring(destGUID), spellID))
                else
                    self:DebugPrint(format("Manual re-apply detected for %s (guid=%s) (refresh %d over %d) - updating snapshot", debuffName, tostring(destGUID), spellID, existingSnapshot.sourceSpellID))
                end
            else
                self:DebugPrint(format("Creating snapshot for %s (guid=%s) on manual re-apply (spellID %d)", debuffName, tostring(destGUID), rawSpellID))
            end
            return true
        else
            self:DebugPrint(format("Non-manual refresh for %s (guid=%s) - preserving existing snapshot", debuffName, tostring(destGUID)))
            return false
        end
    end

    return false
end

do -- Ace3 lifecyle methods
    --- Initialize the module
    function Snapshotter:ModuleInitialize()
        -- Initialize state from defaultState
        self.state = CopyTable(self.defaultState)

        -- Initialize cached class/spec
        self:RefreshClassSpecCache()

        -- Initialize transient caches
        self.lastCastTimestamps = {}
        self.lastComboAtCast = {}
        self.tooltipCache = {}
        self.pendingFeralPredicted = {}

        -- Create a reusable scanning tooltip for spell tooltip reads (Moonfire/Sunfire math)
        if not self.scanningSpellTooltip then
            self.scanningSpellTooltip = CreateFrame("GameTooltip", "NAGSnapshotterSpellTooltip", nil, "GameTooltipTemplate")
            self.scanningSpellTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        end

        -- Slash commands are now handled via zero-boilerplate slashCommands table
    end

    --- Handler for /nagsnapshot slash command
    function Snapshotter:HandleSnapshotSlashCommand(input)
        if input and input ~= "" then
            local normalized = input:lower()
            if normalized == "debug on" or normalized == "on" then
                self.enableDebugOutput = true
                self:Print("Snapshotter debug output enabled")
            elseif normalized == "debug off" or normalized == "off" then
                self.enableDebugOutput = false
                self:Print("Snapshotter debug output disabled")
            else
                -- Try to convert input to number for spell ID
                local spellID = tonumber(input)
                if spellID then
                    self:DebugSnapshot(spellID)
                else
                    self:Print("Please provide a valid spell ID, 'debug on', or 'debug off'")
                end
            end
        else
            -- Show summary of all snapshots and active buffs
            self:DebugSnapshotSummary()
            self:DebugActiveBuffs()
            -- Show warnings (tracked errors)
            self:DebugWarnings()
        end
    end

    --- Enable the module
    function Snapshotter:ModuleEnable()
        DataManager = NAG:GetModule("DataManager")
        SpecCompat = NAG:GetModule("SpecCompat")
        -- Clear any existing snapshots when enabling
        self:ClearAllSnapshots()
        -- Ensure cache is fresh at enable
        self:RefreshClassSpecCache()
        self.pendingFeralPredicted = {}
    end

    --- Disable the module
    function Snapshotter:ModuleDisable()
        -- Clear snapshots when disabling
        self:ClearAllSnapshots()
        DataManager = nil
        self.pendingFeralPredicted = {}
    end
end

--- Event handler for UNIT_SPELLCAST_SUCCEEDED
function Snapshotter:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellID)
    if unit ~= "player" then return end
    if self.debug then
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        self:DebugPrint(format("Spell cast succeeded: %s (ID: %d)", spellInfo and spellInfo.name or "Unknown", spellID))
    end

    -- WA-aligned: cache predicted totals at cast time for Feral bleeds
    if FERAL_BLEED_SPELLS[spellID] then
        local guid = UnitGUID("target")
        local cpOverride = nil
        if spellID == 1079 then
            local preCP = self.lastComboAtCast and self.lastComboAtCast[1079]
            if type(preCP) == "number" and preCP > 0 then
                cpOverride = preCP
            end
        end
        local predicted = self:ComputeFeralDoTPredicted(spellID, cpOverride)
        if type(predicted) == "number" then
            self.pendingFeralPredicted = self.pendingFeralPredicted or {}
            local map = self.pendingFeralPredicted[spellID] or {}
            self.pendingFeralPredicted[spellID] = map
            local key = guid or "*"
            map[key] = { value = predicted, time = GetTime() }
            -- print(format("Snapshotter: Feral pending predicted stored: spellID=%d, guid=%s, value=%d", spellID, tostring(key), predicted))
        end
    end

    -- For Rip, capture a GUID-scoped snapshot on cast success (some clients may not emit aura applied for it)
    if spellID == 1079 then
        local guid = UnitGUID("target")
        -- Capture Rip snapshot strictly by target GUID at cast time
        self:CaptureSnapshot({ spellID = spellID, destGUID = guid }, "rip cast")
        self.lastRipGUID = guid
    end

    -- Track Soul Swap casts and whether Soulburn was active to handle Warlock DoT refresh logic
    -- Base: 86121 (generic), 86211 (Inhale), 86213 (Exhale); Soulburned: 119678
    -- self:DebugPrint(string.format("UNIT_SPELLCAST_SUCCEEDED: spell id=%d", spellID))
    if spellID == 86121 or spellID == 86211 or spellID == 86213 or spellID == 119678 then
        local now = GetTime()
        self.lastSoulSwapCastAt = now
        -- self:DebugPrint(string.format("SoulSwap cast at %.3f (id=%d)", now, spellID))
        if spellID == 119678 then
            -- The spellID itself implies Soulburned variant; mark as such even if the buff is consumed immediately
            self.lastSoulSwapWasSoulburned = true
            -- Do not build a pending transfer payload for Soulburned variant; we will rebuild snapshots from current stats
            self.soulSwapPending = nil
            -- self:DebugPrint("SoulSwap marked as Soulburned; pending cleared")
        elseif spellID == 86213 then
            -- Explicit EXHALE: keep any existing pending for CLEU copy
            if self.soulSwapPending and self.soulSwapPending.expireAt and (now <= self.soulSwapPending.expireAt) then
                -- self:DebugPrint("SoulSwap EXHALE (86213) detected; pending exists and will be applied on CLEU")
            else
                -- self:DebugPrint("SoulSwap EXHALE (86213) detected but no pending payload exists")
            end
        else
            -- INHALE: 86211 (explicit) or 86121 (generic when no pending exists)
            local hasPending = self.soulSwapPending and self.soulSwapPending.expireAt and (now <= self.soulSwapPending.expireAt)
            if spellID == 86121 and hasPending and self.soulSwapPending.wasSoulburned == false then
                -- self:DebugPrint("SoulSwap EXHALE detected via 86121 (pending exists); keeping payload for CLEU")
            else
                -- Build pending transfer from current target
                self.lastSoulSwapWasSoulburned = (NAG and NAG.AuraIsActive and NAG:AuraIsActive(74434)) or false
                local sourceGUID = UnitGUID("target")
                if sourceGUID and UnitExists("target") then
                    local pending = { expireAt = now + 3.0, wasSoulburned = false, sourceGUID = sourceGUID, perDebuff = {} }
                    local candidateIds = {172, 146739, 980, 30108}
                    for _, sid in ipairs(candidateIds) do
                        local spellInfo = WoWAPI.GetSpellInfo(sid)
                        local name = spellInfo and spellInfo.name
                        if name and NAG and NAG.AuraByNameAndCasterIsPlayer and NAG:AuraByNameAndCasterIsPlayer(name, "target") then
                            local snapId = self:NormalizeSnapshotSpellID(sid) or sid
                            local map = self.state and self.state.snapshots and self.state.snapshots[snapId]
                            local snap = map and (map[sourceGUID] or map["*"])
                            if snap then
                                pending.perDebuff[snapId] = CopyTable(snap)
                            end
                        end
                    end
                    if next(pending.perDebuff) ~= nil then
                        self.soulSwapPending = pending
                        local keys = {}
                        for k in pairs(pending.perDebuff) do table.insert(keys, k) end
                        -- self:DebugPrint("SoulSwap INHALE captured payload for GUID=" .. tostring(sourceGUID) .. " keys=" .. table.concat(keys, ","))
                    else
                        self.soulSwapPending = nil
                        -- self:DebugPrint("SoulSwap INHALE found no transferable debuffs (no payload)")
                    end
                else
                    -- self:DebugPrint("SoulSwap INHALE: no target GUID; cannot capture payload")
                end
            end
        end
    end


    -- DK: Track Pestilence target so we skip snapshotting that target (spread does not refresh the cast target)
    if spellID == DK_PESTILENCE then
        self.pestilenceTargetGUID = UnitGUID("target")
    end

    -- Record cast time for manual re-apply detection
    self.lastCastTimestamps = self.lastCastTimestamps or {}
    self.lastCastTimestamps[spellID] = GetTime()
end

--- Event handler to capture snapshot at spell start (for channels like Drain Soul)
function Snapshotter:UNIT_SPELLCAST_START(event, unit, castGUID, spellID)
    if unit ~= "player" then return end
    -- Do NOT store an early snapshot into the per-target map; only record pre-cast data (e.g., combo points)
    -- Record pre-spend combo points for Rip (1079) before they are consumed
    if spellID == 1079 then
        local cp = 0
        if NAG and NAG.CurrentComboPoints then
            cp = NAG:CurrentComboPoints() or 0
        elseif GetComboPoints then
            cp = GetComboPoints("player", "target") or 0
        end
        self.lastComboAtCast[1079] = cp
    end
end

function Snapshotter:UNIT_SPELLCAST_CHANNEL_START(event, unit, castGUID, spellID)
    if unit ~= "player" then return end
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local name = spellInfo and spellInfo.name
    if name then
        self:CaptureSnapshot(spellID, "channel start")
    end
end

function Snapshotter:UNIT_SPELLCAST_SENT(event, unit, target, castGUID, spellID)
    if unit ~= "player" then return end
    -- Do NOT store pre-cast snapshot here; we rely on CLEU applied/refresh with destGUID
    if spellID == 1079 then
        local cp = 0
        if NAG and NAG.CurrentComboPoints then
            cp = NAG:CurrentComboPoints() or 0
        elseif GetComboPoints then
            cp = GetComboPoints("player", "target") or 0
        end
        self.lastComboAtCast[1079] = cp
    end

    if spellID == TEB_BUFF_ID then
        local stacks = 0
        if NAG and NAG.AuraNumStacks then
            stacks = NAG:AuraNumStacks(TEB_STACK_ID, "player", true) or 0
        end
        self.lastTebStacksAtCast = stacks
        self.lastTebStacksAtCastTime = GetTime()
    end

    -- removed early SENT capture; handled via on-demand fallback inside DPI
end

--- Handle CLEU aura applications and refreshes
    function Snapshotter:HandleAuraAppliedOrRefresh(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
        destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType)

        if subEvent ~= "SPELL_AURA_APPLIED" and subEvent ~= "SPELL_AURA_REFRESH" then
            return
        end

        local playerGUID = NAG.state.player.guid
        local isPlayerSource = sourceGUID == playerGUID
        local isPlayerTarget = destGUID == playerGUID

        if auraType == "BUFF" and isPlayerTarget and spellID == 86211 then
            local now = GetTime()
            self.lastSoulSwapCastAt = now
            self.lastSoulSwapWasSoulburned = false
            local targetGUID = UnitGUID("target")
            if targetGUID and UnitExists("target") then
                local pending = { expireAt = now + 3.0, wasSoulburned = false, sourceGUID = targetGUID, perDebuff = {} }
                local candidateIds = {172, 146739, 980, 30108}
                for _, sid in ipairs(candidateIds) do
                    local spellInfo = WoWAPI.GetSpellInfo(sid)
                    local name = spellInfo and spellInfo.name or nil
                    if name and NAG and NAG.AuraByNameAndCasterIsPlayer and NAG:AuraByNameAndCasterIsPlayer(name, "target") then
                        local snapId = self:NormalizeSnapshotSpellID(sid) or sid
                        local map = self.state and self.state.snapshots and self.state.snapshots[snapId]
                        local snap = map and (map[targetGUID] or map["*"])
                        if snap then
                            pending.perDebuff[snapId] = CopyTable(snap)
                        end
                    end
                end
                if next(pending.perDebuff) ~= nil then
                    self.soulSwapPending = pending
                    local keys = {}
                    for k in pairs(pending.perDebuff) do table.insert(keys, k) end
                    -- self:DebugPrint("SoulSwap INHALE (buff) captured payload for GUID=" .. tostring(sourceGUID) .. " keys=" .. table.concat(keys, ","))
                else
                    self.soulSwapPending = nil
                    -- self:DebugPrint("SoulSwap INHALE (buff) found no transferable debuffs (no payload)")
                end
            else
                -- self:DebugPrint("SoulSwap INHALE (buff): no target GUID; cannot capture payload")
            end
        end

        if not isPlayerSource and not isPlayerTarget then
            return
        end

        self:DebugPrint(format("Player Combat Log Event: %s | SourceGUID: %s | DestGUID: %s | Spell: %s (ID: %d) | Type: %s | isSrc=%s isDst=%s",
            subEvent, tostring(sourceGUID), tostring(destGUID), spellName or "Unknown", spellID or 0, auraType or "nil", tostring(isPlayerSource), tostring(isPlayerTarget)))

        if (auraType == "BUFF" and isPlayerTarget) or (auraType == "DEBUFF" and isPlayerSource) then
            if auraType == "BUFF" then
                self.state.activeBuffs[spellID] = true
                local actionType = subEvent == "SPELL_AURA_REFRESH" and "refreshed" or "applied/reapplied"
                self:DebugPrint(format("Buff %s: %s (ID: %d) - Type: %s | PlayerSource: %s | PlayerTarget: %s",
                    actionType, spellName or "Unknown", spellID, auraType, tostring(isPlayerSource),
                    tostring(isPlayerTarget)))
                local extraPerSpell = nil
                if spellID == TEB_BUFF_ID then
                    local preStacks = self.lastTebStacksAtCast
                    local now = GetTime()
                    if not preStacks or (self.lastTebStacksAtCastTime and (now - self.lastTebStacksAtCastTime) > 1.5) then
                        preStacks = nil
                    end
                    local remainingStacks = 0
                    if NAG and NAG.AuraNumStacks then
                        remainingStacks = NAG:AuraNumStacks(TEB_STACK_ID, "player", true) or 0
                    end
                    extraPerSpell = {
                        tebPreCastStacks = preStacks,
                        tebConsumedStacks = preStacks and math.min(10, preStacks) or nil,
                        tebStacksRemaining = remainingStacks,
                        tebRoroActive = NAG.AuraIsActive and NAG:AuraIsActive(139120, "player", true) or false
                    }
                end
                if extraPerSpell then
                    self:CaptureSnapshot({ spellID = spellID, destGUID = "*", perSpell = extraPerSpell },
                        format("buff %s", actionType), subEvent)
                else
                    self:CaptureSnapshot(spellID, format("buff %s", actionType), subEvent)
                end
            else
                local debuffName = self:GetDebuffName(spellID)
                if debuffName then
                    local snapshotSpellID = self:NormalizeSnapshotSpellID(spellID) or spellID
                    local actionType = subEvent == "SPELL_AURA_REFRESH" and "refreshed" or "applied/reapplied"
                    self:DebugPrint(format("Debuff %s: %s (ID: %d) - Type: %s | PlayerSource: %s | PlayerTarget: %s",
                        actionType, debuffName, spellID, auraType, tostring(isPlayerSource), tostring(isPlayerTarget)))

                    if subEvent == "SPELL_AURA_REFRESH" then
                        local existingMap = self.state.snapshots[snapshotSpellID]
                        local existingSnapshot = nil
                        if type(existingMap) == "table" and destGUID then
                            existingSnapshot = existingMap[destGUID]
                        end
                        if existingSnapshot then
                            if existingSnapshot.sourceSpellID then
                                if existingSnapshot.sourceSpellID == spellID then
                                    self:DebugPrint(format(
                                        "Updating snapshot: %s from spellID %d (manual reapplication)", debuffName,
                                        spellID))
                                else
                                    self:DebugPrint(format(
                                        "Updating snapshot: %s (refresh from different spell %d, but updating anyway)",
                                        debuffName, spellID))
                                end
                            else
                                self:DebugPrint(format("Legacy snapshot for %s, will update to add sourceSpellID %d",
                                    debuffName, spellID))
                            end
                        end
                    end

                    local handledBySoulSwap = false
                    do
                        local pend = self.soulSwapPending
                        if pend then
                            local now2 = GetTime()
                            if pend.expireAt and now2 <= pend.expireAt and pend.wasSoulburned == false then
                                local srcMap = pend.perDebuff
                                if srcMap and srcMap[snapshotSpellID] then
                                    self.state.snapshots[snapshotSpellID] = self.state.snapshots[snapshotSpellID] or {}
                                    local copy = CopyTable(srcMap[snapshotSpellID])
                                    copy.time = now2
                                    if destGUID then
                                        self.state.snapshots[snapshotSpellID][destGUID] = copy
                                        self.state.activeDebuffs[snapshotSpellID] = self.state.activeDebuffs[snapshotSpellID] or {}
                                        self.state.activeDebuffs[snapshotSpellID][destGUID] = true
                                    end
                                    srcMap[snapshotSpellID] = nil
                                    if next(srcMap) == nil then
        -- pending fully consumed, clear handled in place
                                        self.soulSwapPending = nil
                                    end
                                    handledBySoulSwap = true
                                end
                            else
                                if self.soulSwapPending then
                                    self.soulSwapPending = nil
                                end
                            end
                        end
                    end

                    if not handledBySoulSwap then
                        self:CaptureSnapshot({ spellID = spellID, destGUID = destGUID }, format("debuff %s", actionType), subEvent)
                        self:SendSnapshotOverlayUpdateForSpell(spellID)
                        if FERAL_BLEED_SPELLS[spellID] then
                            local pendingMap = self.pendingFeralPredicted and self.pendingFeralPredicted[spellID]
                            if pendingMap then
                                local now2 = GetTime()
                                local entry = nil
                                if destGUID and pendingMap[destGUID] then
                                    entry = pendingMap[destGUID]
                                elseif pendingMap["*"] then
                                    entry = pendingMap["*"]
                                end
                                if entry and entry.time and (now2 - entry.time) <= FERAL_PENDING_EXPIRE_SECONDS then
                                    local snapMap = self.state.snapshots[snapshotSpellID]
                                    local snap = snapMap and destGUID and snapMap[destGUID]
                                    if snap then
                                        snap.perSpell = snap.perSpell or {}
                                        snap.perSpell.predictedTotal = entry.value
                                        if spellID == 1079 then
                                            snap.perSpell.predictedTotalRip5 = entry.value
                                        end
                                        -- print(format(
                                        --     "Snapshotter: Feral pending applied: spellID=%d guid=%s predicted=%d",
                                        --     spellID, tostring(destGUID), entry.value))
                                    end
                                    if destGUID then
                                        pendingMap[destGUID] = nil
                                    end
                                    pendingMap["*"] = nil
                                end
                            end
                        end
                    end
                else
                    self:DebugPrint(format("Could not resolve debuff name for spellID %d", spellID))
                end
            end
        else
            self:DebugPrint(format(
                "Skipping aura - not tracking this combination: %s on %s (PlayerSource: %s, PlayerTarget: %s)",
                auraType, isPlayerTarget and "player" or destName or "unknown", tostring(isPlayerSource),
                tostring(isPlayerTarget)))
        end
    end

--- Handle CLEU aura removals
    function Snapshotter:HandleAuraRemoved(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
        destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType)

        if subEvent ~= "SPELL_AURA_REMOVED" then
            return
        end

        if self.state.activeBuffs[spellID] then
            self.state.activeBuffs[spellID] = nil
            self:DebugPrint(format("Buff removed: %s (ID: %d) - Type: %s", spellName or "Unknown", spellID, auraType))
        end

        local debuffName = self:GetDebuffName(spellID)
        local snapshotSpellID = self:NormalizeSnapshotSpellID(spellID) or spellID
        if debuffName and self.state.activeDebuffs[snapshotSpellID] then
            local map = self.state.activeDebuffs[snapshotSpellID]
            if destGUID and map[destGUID] then map[destGUID] = nil end
            if self.state.snapshots[snapshotSpellID] then
                if destGUID then
                    local sMap = self.state.snapshots[snapshotSpellID]
                    if sMap and sMap[destGUID] then sMap[destGUID] = nil end
                else
                    self.state.snapshots[snapshotSpellID] = nil
                end
                self:DebugPrint(format("Snapshot removed: %s (ID: %d) - Type: %s (GUID-scoped)", debuffName, spellID, auraType))
            else
                self:DebugPrint(format("Debuff removed: %s (ID: %d) - Type: %s", debuffName, spellID, auraType))
            end
            self:SendSnapshotOverlayUpdateForSpell(spellID)
        end
    end

--- Event handler for PLAYER_REGEN_ENABLED (combat end, migrated from StateManager)
function Snapshotter:PLAYER_REGEN_ENABLED(event)
    self:DebugPrint("Combat ended - clearing all snapshots")
    self:ClearAllSnapshots()
    self.pestilenceTargetGUID = nil
end

--- On combat start, proactively snapshot any player-cast DoTs currently active on target
function Snapshotter:PLAYER_REGEN_DISABLED(event)
    local targetGUID = UnitGUID("target")
    if not targetGUID or not UnitExists("target") then return end

    -- Check a small set of known DoTs; extendable
    local candidateIds = {172, 980, 30108, 146739, 348, 1079, 8921, 93402, 1822, 106830, 55095, 55078}
    for _, sid in ipairs(candidateIds) do
        local spellInfo = WoWAPI.GetSpellInfo(sid)
        local name = spellInfo and spellInfo.name or nil
        if name then
            local aura = NAG:UnitAura("target", name, "HARMFUL")
            if aura and aura.sourceUnit == "player" then
                -- Only store if not already present for this guid/id
                local snapId = self:NormalizeSnapshotSpellID(sid) or sid
                local map = self.state and self.state.snapshots and self.state.snapshots[snapId]
                local hasForGuid = type(map) == "table" and map[targetGUID] ~= nil
                if not hasForGuid then
                    self:CaptureSnapshot({ spellID = sid, destGUID = targetGUID }, "combat start dot present")
                    self:DebugPrint(string.format("Combat start snapshot: %s (ID: %d) guid=%s", name, sid, tostring(targetGUID)))
                end
            end
        end
    end
end

--- Clear all stored snapshots
function Snapshotter:ClearAllSnapshots()
    wipe(self.state.snapshots)
    wipe(self.state.snapshotsByTargetName)
    wipe(self.state.activeBuffs)
    wipe(self.state.activeDebuffs)
    self:DebugPrint("All snapshots and active buffs/debuffs cleared")
end

--- Capture a complete snapshot of all supported stats
function Snapshotter:CaptureSnapshot(identifier, reason, eventType)
    if not identifier then
        self:DebugPrint("No identifier provided to CaptureSnapshot")
        return
    end

    -- Determine if this is a spellID or a structured identifier
    local isSpellID = type(identifier) == "number"
    local isTable = type(identifier) == "table"
    local displayName = nil
    local rawSpellID = nil
    local storageSpellID = nil
    local destGUID = nil

    if isSpellID then
        rawSpellID = identifier
        storageSpellID = self:NormalizeSnapshotSpellID(rawSpellID) or rawSpellID
        destGUID = "*"
        local spellInfo = WoWAPI.GetSpellInfo(rawSpellID)
        displayName = (spellInfo and spellInfo.name) or tostring(rawSpellID)
    elseif isTable then
        rawSpellID = identifier.spellID
        storageSpellID = self:NormalizeSnapshotSpellID(rawSpellID) or rawSpellID
        destGUID = identifier.destGUID or "*"
        local debuffName = self:GetDebuffName(rawSpellID)
        if debuffName then
            displayName = debuffName
        else
            local spellInfo = rawSpellID and WoWAPI.GetSpellInfo(rawSpellID)
            displayName = (spellInfo and spellInfo.name) or tostring(rawSpellID)
        end
    else
        self:DebugPrint("Invalid identifier type provided to CaptureSnapshot: " .. type(identifier))
        return
    end

    -- Check if we should store this snapshot
    if eventType and not self:ShouldStoreSnapshot(storageSpellID, displayName, eventType, rawSpellID, destGUID) then
        self:DebugPrint(format("Skipping snapshot for %s (event: %s)", tostring(displayName), tostring(eventType)))
        return
    end

    -- Capture all supported stats
    local snapshot = {
        str = UnitStat("player", CONSTANTS.STAT_INDICES.str) or 0,
        agi = UnitStat("player", CONSTANTS.STAT_INDICES.agi) or 0,
        int = UnitStat("player", CONSTANTS.STAT_INDICES.int) or 0,
        crit = GetCritChanceCompat(),
        haste = GetHasteCompat(),
        mastery = GetMasteryEffectCompat(),
        ap = 0,                                   -- Will be calculated below
        sp = 0,                                   -- Will be calculated below (shadow school for warlock math)
        sp_fire = 0,                              -- Fire school SP for Destruction formulas
        time = GetTime(),                         -- Add timestamp
        sourceSpellID = rawSpellID,               -- Track which spell created this snapshot (raw, pre-normalization)
        sourceSpellName = nil,                    -- Will be set below
        percentMod = GetDamagePercentModCompat(), -- External damage multiplier at snapshot time
    }

    -- Set source spell name
    local spellInfo = rawSpellID and WoWAPI.GetSpellInfo(rawSpellID)
    snapshot.sourceSpellName = spellInfo and spellInfo.name

    -- Calculate attack power (base + positive buffs + negative buffs)
    local base, posBuff, negBuff = UnitAttackPower("player")
    snapshot.ap = (base or 0) + (posBuff or 0) + (negBuff or 0)

    -- Calculate spell power for shadow (school=6) for warlock math
    snapshot.sp = GetSpellPowerCompat(6)
    snapshot.sp_fire = GetSpellPowerCompat(3)

    -- Capture bleed-specific multipliers for physical DoTs like Rip
    -- Mastery effect as a generic percentage multiplier
    snapshot.bleedMasteryMul = 1 + ((GetMasteryEffectCompat() or 0) / 100)

    -- Druid-specific snapshot multipliers (only check if player is Druid)
    if NAG.CLASS_FILENAME == "DRUID" then
        -- Tiger's Fury (5217) provides 15% physical damage; snapshot explicitly to avoid double-counting via UnitDamage
        local tfActive = SafeAuraIsActive(5217)
        snapshot.tigerFuryMul = tfActive and 1.15 or 1.0

        -- Snapshot Dream of Cenarius (145152 in MoP, 108373 in some data sets) multiplier (1.3 when active, else 1)
        local docActive = IsDreamOfCenariusActive()
        snapshot.docMul = docActive and 1.3 or 1.0
    else
        snapshot.tigerFuryMul = 1.0
        snapshot.docMul = 1.0
    end

    -- Snapshot crit chance (as simple EV multiplier -> 1 + critChance)
    snapshot.critChance = GetCritChanceCompat() or 0

    -- Attach per-spell snapshot details when possible (e.g., combo points for Rip)
    if rawSpellID then
        local perSpell = self:BuildPerSpellSnapshot(rawSpellID, displayName)
        -- Ensure accurate combo points at Rip application: prefer pre-cast recorded CP if available
        if rawSpellID == 1079 and perSpell then
            local preCP = self.lastComboAtCast and self.lastComboAtCast[1079]
            if type(preCP) == "number" and preCP > 0 then
                perSpell.comboPoints = preCP
            end
        end
        if perSpell and next(perSpell) ~= nil then
            snapshot.perSpell = perSpell
        end
        -- For Balance DoTs (Moonfire/Sunfire), store formula-based predicted total at snapshot time
        if rawSpellID == 8921 or rawSpellID == 93402 then
            snapshot.perSpell = snapshot.perSpell or {}
            snapshot.perSpell.predictedTotal = self:ComputeBalanceDoTPredicted(rawSpellID)
        end
        -- For Feral DoTs (Rip/Rake/Thrash), store formula-based predicted total at snapshot time
        if rawSpellID == 1079 or rawSpellID == 1822 or rawSpellID == 106830 then
            snapshot.perSpell = snapshot.perSpell or {}
            local cpForRip = snapshot.perSpell and snapshot.perSpell.comboPoints or nil
            snapshot.perSpell.predictedTotal = self:ComputeFeralDoTPredicted(rawSpellID, cpForRip)
            if rawSpellID == 1079 and type(cpForRip) == "number" then
                snapshot.perSpell.predictedTotalRip5 = self:ComputeFeralDoTPredicted(1079, 5)
            end
        end
        -- For DK diseases, store formula-based predicted total at snapshot time
        if rawSpellID == 55095 or rawSpellID == 55078 then
            snapshot.perSpell = snapshot.perSpell or {}
            snapshot.perSpell.predictedTotal = self:ComputeDKDoTPredicted(rawSpellID)
            if rawSpellID == DK_BLOOD_PLAGUE then
                local fofStacks = (NAG and NAG.AuraNumStacks and NAG:AuraNumStacks(FOF_STACK_AURA_ID, "player", true)) or 0
                fofStacks = math.max(0, math.min(10, tonumber(fofStacks) or 0))
                snapshot.perSpell.snapStacksFoF = fofStacks
            end
        end
        if isTable and identifier.perSpell then
            snapshot.perSpell = snapshot.perSpell or {}
            for key, value in pairs(identifier.perSpell) do
                if snapshot.perSpell[key] == nil then
                    snapshot.perSpell[key] = value
                end
            end
        end
    end

    -- Warlock snapshot fields (used by DPS-based math)
    if rawSpellID == 146739 or rawSpellID == 172 or rawSpellID == 980 or rawSpellID == 30108 or rawSpellID == 348 or rawSpellID == 108686 or rawSpellID == 603 or rawSpellID == 103103 or rawSpellID == 1120 then
        snapshot.wlk = {
            hastePct = GetSpellHastePercentCompat(),
            critPct = GetSpellCritChanceCompat(6),
            spShadow = GetSpellPowerCompat(6),
            spFire = GetSpellPowerCompat(3),
            masteryPts = (GetMastery and GetMastery()) or GetMasteryEffectCompat() or 0,
            damageMultiplier = GetDamagePercentModCompat(),
            metaActive = NAG:UnitBuff("player", 103958) and true or false,
            spec = (function()
                -- Prefer class specialization API when available
                if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
                    local sid = C_SpecializationInfo.GetSpecialization(false)
                    return sid -- 1 Affliction, 2 Demo, 3 Destro
                end
                return nil
            end)()
        }
    end

    -- Capture tooltip baseline for Moonfire/Sunfire (damage per tick total approximation)
    -- if spellID == 8921 or spellID == 93402 then
    --     snapshot.perSpell = snapshot.perSpell or {}
    --     snapshot.perSpell.tooltipDamage = self:GetSpellTooltipDamage(spellID)
    --     -- Snapshot MF/SF tooltip disabled (using formula-based prediction instead)
    -- end

    -- Store the snapshot by spellID + destGUID
    if not self.state.snapshots[storageSpellID] then
        self.state.snapshots[storageSpellID] = {}
    end
    local sMap = self.state.snapshots[storageSpellID]
    sMap[destGUID or "*"] = snapshot

    -- Also store by destName for boss fallback when GUIDs change mid-encounter
    if destGUID and destGUID ~= "*" then
        local destNameEff = UnitName("target") -- only meaningful for current target
        if destNameEff and destNameEff ~= "" then
            if not self.state.snapshotsByTargetName[storageSpellID] then
                self.state.snapshotsByTargetName[storageSpellID] = {}
            end
            self.state.snapshotsByTargetName[storageSpellID][destNameEff] = {
                snapshot = snapshot,
                time = GetTime(),
            }
        end
    end

    -- Mark this debuff as active
    if destGUID and destGUID ~= "*" then
        if not self.state.activeDebuffs[storageSpellID] then
            self.state.activeDebuffs[storageSpellID] = {}
        end
        local aMap = self.state.activeDebuffs[storageSpellID]
        aMap[destGUID] = true
    end

    --self:DebugPrint(format("Captured snapshot for %s - Reason: %s", debuffName, reason))
    -- print("Snapshot store: key=\"" .. tostring(debuffName) .. "\" guid=\"" .. tostring(destGUID or "*") .. "\" reason=\"" .. tostring(reason) .. "\" sourceSpellID=" .. tostring(spellID or 0)
    --    .. " sp=" .. tostring(snapshot.sp) .. " sp_fire=" .. tostring(snapshot.sp_fire) .. " ap=" .. tostring(snapshot.ap)
    --    .. " mod=" .. tostring(snapshot.percentMod)
    --    .. (spellID == 1079 and (" cp=" .. tostring(snapshot.perSpell and snapshot.perSpell.comboPoints or nil)) or ""))
    local cpDebug = (snapshot.perSpell and snapshot.perSpell.comboPoints) and
        (", cp=" .. tostring(snapshot.perSpell.comboPoints)) or ""
    local predDebug = (snapshot.perSpell and snapshot.perSpell.predictedTotal) and
        (", predicted=" .. tostring(snapshot.perSpell.predictedTotal)) or ""
    -- print(format(
    --     "Snapshotter: Stats: str=%d, agi=%d, int=%d, crit=%.1f, haste=%.1f, mastery=%.1f, ap=%d, time=%.2f, sourceSpellID=%d, percentMod=%.3f%s%s",
    --     snapshot.str, snapshot.agi, snapshot.int, snapshot.crit, snapshot.haste, snapshot.mastery, snapshot.ap,
    --     snapshot.time, snapshot.sourceSpellID or 0, snapshot.percentMod or 1, cpDebug, predDebug))
end

--- Build per-spell snapshot details (e.g., combo points for finishing moves like Rip)
--- @param spellID number
--- @param debuffName string
--- @return table|nil
function Snapshotter:BuildPerSpellSnapshot(spellID, debuffName)
    local per = {}

    -- Normalize debuff name for comparisons
    local debuffLower = type(debuffName) == "string" and debuffName:lower() or ""

    -- Rip (Feral) specific handling: ID 1079 applies the debuff "Rip"
    local ripInfo = WoWAPI.GetSpellInfo(1079)
    local ripName = (ripInfo and ripInfo.name or ""):lower()
    if spellID == 1079 or debuffLower == ripName then
        -- Capture combo points at application time
        local cp = 0
        if NAG and NAG.CurrentComboPoints then
            cp = NAG:CurrentComboPoints() or 0
        elseif GetComboPoints then
            cp = GetComboPoints("player", "target") or 0
        end

        per.comboPoints = cp
        -- Encode known coefficients from tooltip math for future calculations
        per.apCoefficientPerPoint = 0.0484
        per.baseAdditive = 113
        per.extendsOnCatBuilders = true
        per.maxExtensionSeconds = 6
        -- Preferred stat(s) for percent comparison for this spell
        per.preferredStats = {"ap"}

        -- Optional: stash basic spell data for debugging/reference
        if DataManager.Get then
            local spellEntity = DataManager:Get(spellID, DataManager.EntityTypes.SPELL)
            if spellEntity then
                per.school = spellEntity.school or nil
                per.flags = spellEntity.flags or nil
            end
        end
    end

    return per
end

--- Compute predicted total damage for Balance DoTs using current live stats
--- Returns number or nil when not applicable
function Snapshotter:ComputeBalanceDoTPredicted(spellID)
    if spellID ~= 8921 and spellID ~= 93402 then return nil end

    -- Schools: Moonfire (Arcane=7), Sunfire (Nature=4)
    local function GetSpellPowerCompatSchool(school)
        if GetSpellBonusDamage then
            return GetSpellBonusDamage(school) or 0
        end
        return 0
    end
    local spArcane = GetSpellPowerCompatSchool(7)
    local spNature = GetSpellPowerCompatSchool(4)
    local masteryEffect = 1 + ((GetMasteryEffectCompat() or 0) / 100)
    -- Use melee crit for physical bleeds
    local critChance = (GetCritChance and GetCritChance() or GetCritChanceCompat() or 0) / 100
    if critChance > 1 then critChance = 1 end
    local haste = GetSpellHastePercentCompat() or 0
    local critEffMult = 1 + (2 - 1) * critChance

    local damageMultMoonfire, damageMultSunfire = 1, 1
    if NAG and NAG.AuraIsActive and NAG:AuraIsActive(24858) then
        damageMultMoonfire = damageMultMoonfire * 1.1
        damageMultSunfire = damageMultSunfire * 1.1
    end

local isCA = false
if Version and Version.GetGameType and Version.GAME_TYPES then
    if Version:GetGameType() == Version.GAME_TYPES.CLASSIC_MISTS then
        if NAG and NAG.AuraIsActive and DataManager and DataManager.Get then
            local caSpell = DataManager:Get(112071, DataManager.EntityTypes.SPELL)
            if caSpell then
                isCA = NAG:AuraIsActive(112071)
            end
        end
    end
end
    local lunarBonus, solarBonus = nil, nil
    if isCA then
        lunarBonus, solarBonus = 35, 35
    else
        -- Try to read bonus percent from Eclipse auras if available
        local lunarAura = NAG:UnitAura("player", 48518) -- Lunar
        local solarAura = NAG:UnitAura("player", 48517) -- Solar
        local lb = lunarAura and lunarAura.points and lunarAura.points[1]
        local sb = solarAura and solarAura.points and solarAura.points[1]
        lunarBonus = tonumber(lb)
        solarBonus = tonumber(sb)
    end
    if lunarBonus then damageMultMoonfire = damageMultMoonfire * (1 + lunarBonus / 100) end
    if solarBonus then damageMultSunfire = damageMultSunfire * (1 + solarBonus / 100) end

    local function total(spSchool, dmgMult)
        local duration, baseTick = 14, 2
        local tickEvery = baseTick / (1 + (haste / 100))
        local ticks = math.ceil(duration / tickEvery)
        local initialCoeff, dotCoeff
        if spellID == 8921 then
            initialCoeff, dotCoeff = 0.5709, 0.2399
        else
            initialCoeff, dotCoeff = 0.57099997997, 0.23999999464
        end
        local baseInitial = spSchool * initialCoeff
        local dotPerTick = spSchool * dotCoeff
        local totalDot = dotPerTick * ticks
        local totalDamage = (baseInitial + totalDot) * masteryEffect * dmgMult * critEffMult
        return math.floor(totalDamage + 0.5)
    end

    if spellID == 8921 then
        return total(spArcane, damageMultMoonfire)
    else
        return total(spNature, damageMultSunfire)
    end
end

--- Attempt math-based percent increase computation for spells with known formulas
--- Returns number on success, or nil if no math-based handler applies
--- @param spellID number
--- @param snapshot table
--- @return number|nil
function Snapshotter:CalculatePercentIncreaseWithMath(spellID, snapshot)
    if not snapshot or type(snapshot) ~= "table" then
        return nil
    end
    local per = snapshot.perSpell or {}
    -- print("Math router: spellID=" .. tostring(spellID) .. " perSpellPresent=" .. tostring(type(snapshot.perSpell) == "table"))

    -- Rip (Feral Druid) - uses AP, combo points, and fixed coefficients
    if spellID == 1079 or self:SpellMatchesByName(spellID, 1079) or (snapshot.sourceSpellID == 1079) then
        local snapshotCP = tonumber(per.comboPoints) or 0
        local apCoefficientPerPoint = tonumber(per.apCoefficientPerPoint)
        local baseAdditive = tonumber(per.baseAdditive) or 0
        if snapshotCP <= 0 or not apCoefficientPerPoint or apCoefficientPerPoint <= 0 then
            -- print("Rip math: missing inputs -> snapshotCP=" .. tostring(snapshotCP) .. ", apCoeffPerCP=" .. tostring(apCoefficientPerPoint) .. ", base=" .. tostring(baseAdditive))
            return nil
        end

        -- Effective AP coefficient scales with number of combo points
        local snapshotApCoeff = apCoefficientPerPoint * snapshotCP
        local currentCP = 0
        if NAG and NAG.CurrentComboPoints then
            currentCP = NAG:CurrentComboPoints() or 0
        elseif GetComboPoints then
            currentCP = GetComboPoints("player", "target") or 0
        end
        if currentCP <= 0 then
            -- Fallback to snapshot CP when current CP cannot be read (no target or consumed)
            currentCP = snapshotCP
        end
        local currentApCoeff = apCoefficientPerPoint * currentCP

        -- Snapshot and current AP
        local snapshotAP = tonumber(snapshot.ap) or 0
        local currentAP = self:GetCurrentStat("ap") or 0

        -- Damage percent modifiers
        local currentMod = GetDamagePercentModCompat()
        local snapshotMod = snapshot.percentMod or 1
        -- Bleed-specific multipliers (mastery, tiger's fury) captured at snapshot and computed live for current
        local snapshotBleedMul = (snapshot.bleedMasteryMul or 1.0) * (snapshot.tigerFuryMul or 1.0)
        local tfActive = SafeAuraIsActive(5217)
        local currentBleedMul = (1 + ((GetMasteryEffectCompat() or 0) / 100)) * (tfActive and 1.15 or 1.0)
        -- Crit expected value multipliers (simple EV: 1 + critChance)
        local snapshotCritEV = 1 + ((snapshot.critChance or 0) / 100)
        local currentCritEV = 1 + ((GetCritChanceCompat() or 0) / 100)
        -- Dream of Cenarius multiplier (145152 in MoP, 108373 in some data sets): 1.3 when active, else 1.0
        local snapshotDocMul = snapshot.docMul or 1.0
        local docActive = IsDreamOfCenariusActive()
        local currentDocMul = docActive and 1.3 or 1.0

        -- Simple tick/base representation for ratio: base + AP * coeff
        local snapshotValue = (baseAdditive + (snapshotAP * snapshotApCoeff)) * snapshotBleedMul * snapshotCritEV * snapshotDocMul
        local currentValue = (baseAdditive + (currentAP * currentApCoeff)) * currentBleedMul * currentCritEV * currentDocMul

        if snapshotValue <= 0 then
            return nil
        end

        local percentDiff = ((currentValue * currentMod) / (snapshotValue * snapshotMod)) - 1

        self:DebugPrint(format(
            "Math-based percent for spell %d: current=%.3f x mod %.3f, snapshot=%.3f x mod %.3f => diff=%.3f (%.1f%%)",
            spellID, currentValue, currentMod, snapshotValue, snapshotMod, percentDiff, percentDiff * 100))
        return percentDiff
    end

    -- Warlock DPS-based formulas (Affliction/Demonology/Destruction)
    local function Round(num)
        return floor(num + 0.5)
    end

    local function computeWarlockStats(isSnapshot)
        local s = isSnapshot and snapshot or nil
        local w = s and s.wlk or nil
        local haste = w and w.hastePct or GetSpellHastePercentCompat()
        local crit = w and w.critPct or GetSpellCritChanceCompat(6)
        local spd6 = w and w.spShadow or GetSpellPowerCompat(6)
        local spd3 = w and w.spFire or GetSpellPowerCompat(3)
        local damageMult = w and w.damageMultiplier or GetDamagePercentModCompat()
        local masteryPts = w and w.masteryPts or (GetMastery and GetMastery()) or GetMasteryEffectCompat() or 0
        local spec = w and w.spec or (C_SpecializationInfo and C_SpecializationInfo.GetSpecialization and C_SpecializationInfo.GetSpecialization(false)) or nil
        local metaActive = w and w.metaActive or (NAG:UnitBuff("player", 103958) and true or false)

        local masteryBonus, doomBonus, FABBonus
        if spec == 1 then -- Affliction
            masteryBonus = 1 + ((masteryPts * 3.1) / 100)
        elseif spec == 2 then -- Demonology
            masteryBonus = 1 + (masteryPts / 100)
            doomBonus = 1 + ((3 * masteryPts) / 100)
            if metaActive then
                damageMult = damageMult / doomBonus
            else
                damageMult = damageMult / masteryBonus
            end
        elseif spec == 3 then -- Destruction
            masteryBonus = 1 + ((masteryPts + 1) / 100)
            FABBonus = ((100 + masteryPts * 3) * 0.35) / 100
        else
            masteryBonus = 1
        end

        return {
            haste = haste,
            critBonus = 1 + (crit / 100),
            sp6 = spd6,
            sp3 = spd3,
            damageMultiplier = damageMult,
            masteryBonus = masteryBonus or 1,
            doomBonus = doomBonus or 1,
            FABBonus = FABBonus or 1,
        }
    end

    local function wlkTickCadence(baseTick, totalDur, haste)
        local tickEvery = baseTick / (1 + (haste / 100))
        local ticks = Round(totalDur / tickEvery)
        local duration = ticks * tickEvery
        return tickEvery, ticks, duration
    end

    local function computeWlkDPS(id, st)
        if id == 146739 or id == 172 then -- Corruption
            local tickEvery, ticks, duration = wlkTickCadence(2, 18, st.haste)
            local tickDmg = (234 + st.sp6 * 0.219497) * st.masteryBonus * st.damageMultiplier * st.critBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 980 then -- Agony (assume 10 stacks)
            local tickEvery, ticks, duration = wlkTickCadence(2, 24, st.haste)
            local tickDmg = (28 + st.sp6 * 0.026769) * 10 * st.masteryBonus * st.damageMultiplier * st.critBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 30108 then -- UA
            local tickEvery, ticks, duration = wlkTickCadence(2, 14, st.haste)
            local tickDmg = (310 + st.sp6 * 0.29) * st.masteryBonus * st.damageMultiplier * st.critBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 348 then -- Immolate
            local tickEvery, ticks, duration = wlkTickCadence(3, 15, st.haste)
            local tickDmg = (625 + st.sp3 * 0.611) * st.masteryBonus * st.damageMultiplier * st.critBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 108686 then -- Immolate_FAB (Fire and Brimstone)
            local tickEvery, ticks, duration = wlkTickCadence(3, 15, st.haste)
            local tickDmg = (625 + st.sp3 * 0.611) * st.masteryBonus * st.damageMultiplier * st.critBonus * st.FABBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 603 then -- Doom (Demo)
            local tickEvery, ticks, duration = wlkTickCadence(15, 60, st.haste)
            local tickDmg = (1331 + st.sp6 * 1.24689) * st.doomBonus * st.damageMultiplier * st.critBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 1120 then -- Drain Soul
            local tickEvery, ticks, duration = wlkTickCadence(2, 6, st.haste)
            local tickDmg = (ceil(274.5274) + st.sp6 * 0.257) * st.damageMultiplier * st.critBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 103103 then -- Malefic Grasp
            local tickEvery, ticks, duration = wlkTickCadence(1, 4, st.haste)
            local tickDmg = (211 + st.sp6 * 0.19813) * st.damageMultiplier * st.critBonus
            return Round((tickDmg * ticks) / duration)
        elseif id == 48181 then -- Haunt DPS baseline (optional)
            -- Not in provided table; skip or implement if needed
            return nil
        end
        return nil
    end

    local function warlockPercentDiff(id)
        local snapSt = computeWarlockStats(true)
        local curSt = computeWarlockStats(false)
        local dpsSnap = computeWlkDPS(id, snapSt)
        local dpsNow = computeWlkDPS(id, curSt)
        if not dpsSnap or not dpsNow or dpsSnap <= 0 then return nil end
        return (dpsNow / dpsSnap) - 1
    end

    if spellID == 146739 or spellID == 172 or spellID == 980 or spellID == 30108 or spellID == 348 or spellID == 108686 or spellID == 603 or spellID == 103103 or spellID == 1120 then
        local p = warlockPercentDiff(spellID)
        if type(p) == "number" then return p end
    end

    -- Moonfire (8921) and Sunfire (93402) - tooltip-driven ratio
    if spellID == 8921 or spellID == 93402 or self:SpellMatchesByName(spellID, 8921) or self:SpellMatchesByName(spellID, 93402) or (snapshot.sourceSpellID == 8921) or (snapshot.sourceSpellID == 93402) then
        local snapTooltip = snapshot.perSpell and snapshot.perSpell.tooltipDamage or nil
        local curTooltip = self:GetSpellTooltipDamage(spellID)
        -- print("MF/SF math: spellID=" .. tostring(spellID) .. " snapTooltip=" .. tostring(snapTooltip) .. " curTooltip=" .. tostring(curTooltip))
        if not snapTooltip or not curTooltip or snapTooltip <= 0 then
            return nil
        end
        local percent = (curTooltip / snapTooltip) - 1
        -- print("MF/SF math: percent=" .. tostring(percent))
        return percent
    end

    -- ============================ FERAl BLEEDS (MULTIPLIER-ONLY APPROX) ============================
    -- Rake (Cat) ID 1822 - treat like Rip for multiplier comparison (no CP/AP terms here)
    if spellID == 1822 or self:SpellMatchesByName(spellID, 1822) or (snapshot.sourceSpellID == 1822) then
        local snapshotBleedMul = (snapshot.bleedMasteryMul or 1.0) * (snapshot.tigerFuryMul or 1.0)
        local tfActive = SafeAuraIsActive(5217)
        local currentBleedMul = (1 + ((GetMasteryEffectCompat() or 0) / 100)) * (tfActive and 1.15 or 1.0)

        local snapshotDocMul = snapshot.docMul or 1.0
        local docActive = IsDreamOfCenariusActive()
        local currentDocMul = docActive and 1.3 or 1.0

        local snapshotCritEV = 1 + ((snapshot.critChance or 0) / 100)
        local currentCritEV = 1 + ((GetCritChanceCompat() or 0) / 100)

        local currentMod = GetDamagePercentModCompat()
        local snapshotMod = snapshot.percentMod or 1

        local snapshotValue = snapshotBleedMul * snapshotDocMul * snapshotCritEV * snapshotMod
        local currentValue = currentBleedMul * currentDocMul * currentCritEV * currentMod

        if snapshotValue <= 0 then return nil end
        return (currentValue / snapshotValue) - 1
    end

    -- Thrash (Cat) ID 106830 - same name as bear thrash; enforce ID-only
    if spellID == 106830 or (snapshot.sourceSpellID == 106830) then
        local snapshotBleedMul = (snapshot.bleedMasteryMul or 1.0) * (snapshot.tigerFuryMul or 1.0)
        local tfActive = SafeAuraIsActive(5217)
        local currentBleedMul = (1 + ((GetMasteryEffectCompat() or 0) / 100)) * (tfActive and 1.15 or 1.0)

        local snapshotDocMul = snapshot.docMul or 1.0
        local docActive = IsDreamOfCenariusActive()
        local currentDocMul = docActive and 1.3 or 1.0

        local snapshotCritEV = 1 + ((snapshot.critChance or 0) / 100)
        local currentCritEV = 1 + ((GetCritChanceCompat() or 0) / 100)

        local currentMod = GetDamagePercentModCompat()
        local snapshotMod = snapshot.percentMod or 1

        local snapshotValue = snapshotBleedMul * snapshotDocMul * snapshotCritEV * snapshotMod
        local currentValue = currentBleedMul * currentDocMul * currentCritEV * currentMod

        if snapshotValue <= 0 then return nil end
        return (currentValue / snapshotValue) - 1
    end

    -- Lacerate (Bear) ID 33745 - bear: no TF/DoC; use phys mod and crit EV only
    if spellID == 33745 or (snapshot.sourceSpellID == 33745) then
        local snapshotCritEV = 1 + ((snapshot.critChance or 0) / 100)
        local currentCritEV = 1 + ((GetCritChanceCompat() or 0) / 100)

        local currentMod = GetDamagePercentModCompat()
        local snapshotMod = snapshot.percentMod or 1

        local snapshotValue = snapshotCritEV * snapshotMod
        local currentValue = currentCritEV * currentMod

        if snapshotValue <= 0 then return nil end
        return (currentValue / snapshotValue) - 1
    end

    -- Thrash (Bear) ID 77758 - ID-only
    if spellID == 77758 or (snapshot.sourceSpellID == 77758) then
        local snapshotCritEV = 1 + ((snapshot.critChance or 0) / 100)
        local currentCritEV = 1 + ((GetCritChanceCompat() or 0) / 100)

        local currentMod = GetDamagePercentModCompat()
        local snapshotMod = snapshot.percentMod or 1

        local snapshotValue = snapshotCritEV * snapshotMod
        local currentValue = currentCritEV * currentMod

        if snapshotValue <= 0 then return nil end
        return (currentValue / snapshotValue) - 1
    end

    return nil
end

--- Compute predicted total damage for Feral DoTs using current live stats
--- Supports Rip (1079), Rake (1822), Thrash (106830)
--- Returns number or nil when not applicable
function Snapshotter:ComputeFeralDoTPredicted(spellID, overrideComboPoints)
    if spellID ~= 1079 and spellID ~= 1822 and spellID ~= 106830 then return nil end

    local function getAP()
        local base, pos, neg = UnitAttackPower("player")
        return (base or 0) + (pos or 0) + (neg or 0)
    end
    local ap = getAP()
    local masteryEffect = 1 + ((GetMasteryEffectCompat() or 0) / 100)
    local critChance = (GetCritChanceCompat() or 0) / 100
    if critChance > 1 then critChance = 1 end
    local damageMult = GetDamagePercentModCompat() or 1
    local docActive = IsDreamOfCenariusActive()
    if docActive then
        damageMult = damageMult * 1.3
    end
    local critEffMult = 1 + (2 - 1) * critChance

    -- print(format(
    --     "Snapshotter: Feral predicted inputs (spellID=%d): ap=%d, mastery=%.3f, crit=%.3f, dmgMult=%.3f, doc=%s",
    --     spellID, ap, masteryEffect, critChance, damageMult, tostring(docActive)))

    if spellID == 1079 then
        local cp = overrideComboPoints
        if not cp then
            if NAG and NAG.CurrentComboPoints then
                cp = NAG:CurrentComboPoints() or 0
            elseif GetComboPoints then
                cp = GetComboPoints("player", "target") or 0
            end
        end
        cp = tonumber(cp) or 0
        -- inside = ((4 + 0.0484 * ap) * cp) * multipliers + 113; total = floor(inside * 8)
        local multipliers = (masteryEffect or 1) * (damageMult or 1) * (critEffMult or 1)
        local inside = ((4 + 0.0484 * ap) * cp) * multipliers + 113
        local total = math.floor(inside * 8)
        -- print(format("Snapshotter: Feral predicted Rip: cp=%d, inside=%.3f, total=%d", cp, inside, total))
        return total
    elseif spellID == 1822 then
        -- Rake: base = 99 + 0.3 * ap; initialExp = base * damageMult * critEff; tickExp = base * mastery * damageMult * critEff; total = floor(initial + 5*tick)
        local baseVal = 99 + 0.3 * ap
        local initialExp = baseVal * damageMult * critEffMult
        local tickExp = baseVal * masteryEffect * damageMult * critEffMult
        local total = math.floor(initialExp + 5 * tickExp)
        -- print(format(
        --     "Snapshotter: Feral predicted Rake: base=%.3f, initial=%.3f, tick=%.3f, total=%d",
        --     baseVal, initialExp, tickExp, total))
        return total
    elseif spellID == 106830 then
        -- Thrash: base = 686 + 0.141 * ap; total = Round(base * mastery * damageMult * critEff)
        local baseVal = 686 + 0.141 * ap
        local total = math.floor((baseVal * masteryEffect * damageMult * critEffMult) + 0.5)
        -- print(format("Snapshotter: Feral predicted Thrash: base=%.3f, total=%d", baseVal, total))
        return total
    end
    return nil
end

--- Compute predicted total damage for DK diseases (Unholy formulas reference)
--- Supports Frost Fever (55095) and Blood Plague (55078)
--- Returns number or nil when not applicable
function Snapshotter:ComputeDKDoTPredicted(spellID)
    -- Map common cast IDs to debuff IDs
    local function normalize(id)
        if id == 45477 then return 55095 end -- Icy Touch -> Frost Fever
        if id == 45462 then return 55078 end -- Plague Strike -> Blood Plague
        return id
    end
    local id = normalize(spellID)
    if id ~= 55095 and id ~= 55078 then return nil end

    local function getAP()
        local base, pos, neg = UnitAttackPower("player")
        return (base or 0) + (pos or 0) + (neg or 0)
    end
    local ap = getAP()
    local percentmod = GetDamagePercentModCompat() or 1
    -- Reference uses 1 + (1.03 * critChance)
    local meleeCrit = (GetCritChance and GetCritChance() or GetCritChanceCompat() or 0) / 100
    local headLink = GetInventoryItemLink and GetInventoryItemLink("player", 1)
    local hasMetaGem = headLink and headLink:find(":76885:") and true or false
    local critmod = 1 + (meleeCrit * (hasMetaGem and 1.03 or 1.0))
    local mastery = GetMasteryEffectCompat and (GetMasteryEffectCompat() or 0) or 0
    local masteryMod = 1
    if id == 55078 then
        masteryMod = 1.2 + (mastery / 100)
    end
    -- Formulas: dmg = Round(ap * 0.158 * percentmod * critmod * [masteryMod] * 1.6 / 3)
    local scalar = ap * 0.158 * percentmod * critmod
    if id == 55078 then
        scalar = scalar * masteryMod
    end
    local total = scalar * (1.6 / 3)
    return math.floor(total + 0.5)
end

--- Validate stat arguments
function Snapshotter:ValidateStatArgs(arguments)
    if not arguments then
        self:DebugPrint("No arguments provided to ValidateStatArgs")
        return {}
    end

    -- Convert single string to table
    local statList = {}
    if type(arguments) == "string" then
        tinsert(statList, arguments)
    elseif type(arguments) == "table" then
        for _, stat in ipairs(arguments) do
            if type(stat) == "string" then
                tinsert(statList, stat)
            end
        end
    else
        self:DebugPrint("Invalid arguments type: " .. type(arguments))
        return {}
    end

    -- Validate each stat
    local validStats = {}
    for _, stat in ipairs(statList) do
        if CONSTANTS.VALID_STATS[stat] then
            tinsert(validStats, stat)
        else
            self:DebugPrint(format("Invalid stat: %s", stat))
        end
    end

    self:DebugPrint(format("ValidateStatArgs: %d valid stats found", #validStats))
    return validStats
end

--- Check stored snapshot for a spell
function Snapshotter:SnapshotCheck(arguments, spellID)
    -- Validate inputs
    if not spellID or type(spellID) ~= "number" then
        -- self:Debug("Invalid spellID provided to SnapshotCheck")
        return 0
    end

    local validStats = self:ValidateStatArgs(arguments)
    if #validStats == 0 then
        -- self:Debug("No valid stats provided to SnapshotCheck")
        return 0
    end

    local snapshotSpellID = self:NormalizeSnapshotSpellID(spellID) or spellID
    local map = self.state.snapshots[snapshotSpellID]
    if type(map) ~= "table" then
        return 0
    end
    local guid = UnitGUID("target") or "*"
    local snapshot = map[guid] or map["*"]
    if not snapshot then
        return 0
    end

    -- Calculate sum of requested stats
    local total = 0
    for _, statName in ipairs(validStats) do
        local value = snapshot[statName] or 0
        total = total + value
        -- if self.debug then self:Debug("Stat %s: %d", statName, value) end
    end

    -- Apply stored percentMod if present (legacy compatibility)
    local mod = snapshot.percentMod or 1
    local scaled = total * mod
    -- if self.debug then self:Debug("SnapshotCheck total for spellID %d: %d x mod %.3f => %d", spellID, total, mod, scaled) end
    return scaled
end

--- Get Feathers of Fury stacks captured at the last Blood Plague snapshot for a target.
--- @param unit? string Optional unit token (defaults to "target")
--- @return number Stacks clamped to 0-10
function Snapshotter:GetSnapStacksFoF(unit)
    local targetUnit = unit or "target"
    local guid = UnitGUID(targetUnit)
    if not guid or guid == "" then
        return 0
    end

    local map = self.state and self.state.snapshots and self.state.snapshots[DK_BLOOD_PLAGUE]
    local snapshot = type(map) == "table" and map[guid] or nil
    if snapshot and snapshot.perSpell and type(snapshot.perSpell.snapStacksFoF) == "number" then
        return math.max(0, math.min(10, snapshot.perSpell.snapStacksFoF))
    end

    local inInstance, instanceType = IsInInstance()
    local bossLevel = UnitLevel and UnitLevel(targetUnit) or 0
    local isBoss = bossLevel and bossLevel < 0
    if inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario") and isBoss then
        local tName = UnitName(targetUnit)
        local byNameMap = self.state and self.state.snapshotsByTargetName and self.state.snapshotsByTargetName[DK_BLOOD_PLAGUE]
        local rec = byNameMap and tName and byNameMap[tName] or nil
        local bossSnapshot = rec and type(rec) == "table" and rec.snapshot or nil
        if bossSnapshot and bossSnapshot.perSpell and type(bossSnapshot.perSpell.snapStacksFoF) == "number" then
            return math.max(0, math.min(10, bossSnapshot.perSpell.snapStacksFoF))
        end
    end

    return 0
end

-- ============================ SNAPSHOT OVERLAY PROFILES (GENERIC API) ============================

--- Return the snapshot overlay profile for a given profile id.
--- @param profileId string
--- @return table|nil
function Snapshotter:GetSnapshotOverlayProfile(profileId)
    if not profileId or type(profileId) ~= "string" then return nil end
    return SNAPSHOT_OVERLAY_PROFILES[profileId]
end

--- Return list of registered snapshot overlay profile ids (for DisplayManager options/overlays).
--- @return string[]
function Snapshotter:GetSnapshotOverlayProfileIds()
    local out = {}
    for id in pairs(SNAPSHOT_OVERLAY_PROFILES) do
        tinsert(out, id)
    end
    return out
end

--- Get combined snapshot group DPS for current target from stored predictedTotal per spell.
--- @param profileId string
--- @return number|nil DPS or nil if no snapshot for target
function Snapshotter:GetSnapshotGroupSnapshotDPS(profileId)
    local profile = self:GetSnapshotOverlayProfile(profileId)
    if not profile or not profile.spellIDs or profile.tickIntervalSeconds <= 0 then return nil end
    local guid = UnitGUID("target")
    if not guid then return nil end
    local total = 0
    for _, spellID in ipairs(profile.spellIDs) do
        local map = self.state and self.state.snapshots and self.state.snapshots[spellID]
        if type(map) == "table" then
            local snapshot = map[guid] or map["*"]
            if snapshot and snapshot.perSpell and type(snapshot.perSpell.predictedTotal) == "number" then
                total = total + snapshot.perSpell.predictedTotal
            end
        end
    end
    if total <= 0 then return nil end
    return total / profile.tickIntervalSeconds
end

--- Get the DPS the current player stats would deal for the snapshot group on target.
--- @param profileId string
--- @return number|nil current predicted DPS, or nil if no snapshot/can't compute
function Snapshotter:GetSnapshotGroupCurrentDPS(profileId)
    local profile = self:GetSnapshotOverlayProfile(profileId)
    if not profile or not profile.spellIDs or profile.tickIntervalSeconds <= 0 then return nil end
    local guid = UnitGUID("target")
    if not guid then return nil end
    local computeFn = profile.computePredictedFn and self[profile.computePredictedFn]
    if type(computeFn) ~= "function" then return nil end
    local currentTotal = 0
    local hasAny = false
    for _, spellID in ipairs(profile.spellIDs) do
        local map = self.state and self.state.snapshots and self.state.snapshots[spellID]
        if type(map) == "table" and (map[guid] or map["*"]) then
            hasAny = true
            local predicted = computeFn(self, spellID)
            if type(predicted) == "number" then
                currentTotal = currentTotal + predicted
            end
        end
    end
    if not hasAny or currentTotal <= 0 then return nil end
    return currentTotal / profile.tickIntervalSeconds
end

--- Get the percentage of current-stats predicted vs snapshotted predicted for a snapshot group.
--- @param profileId string
--- @return number|nil percentage (e.g. 110), or nil if no snapshot/can't compute
function Snapshotter:GetSnapshotGroupSnapshotPercent(profileId)
    local profile = self:GetSnapshotOverlayProfile(profileId)
    if not profile or not profile.spellIDs then return nil end
    local guid = UnitGUID("target")
    if not guid then return nil end
    local computeFn = profile.computePredictedFn and self[profile.computePredictedFn]
    if type(computeFn) ~= "function" then return nil end
    local snappedTotal = 0
    for _, spellID in ipairs(profile.spellIDs) do
        local map = self.state and self.state.snapshots and self.state.snapshots[spellID]
        if type(map) == "table" then
            local snapshot = map[guid] or map["*"]
            if snapshot and snapshot.perSpell and type(snapshot.perSpell.predictedTotal) == "number" then
                snappedTotal = snappedTotal + snapshot.perSpell.predictedTotal
            end
        end
    end
    if snappedTotal <= 0 then return nil end
    local currentTotal = 0
    for _, spellID in ipairs(profile.spellIDs) do
        local map = self.state and self.state.snapshots and self.state.snapshots[spellID]
        local hasSnap = type(map) == "table" and (map[guid] or map["*"]) ~= nil
        if hasSnap then
            local predicted = computeFn(self, spellID)
            if type(predicted) == "number" then
                currentTotal = currentTotal + predicted
            end
        end
    end
    if currentTotal <= 0 then return nil end
    return (currentTotal / snappedTotal) * 100
end

--- Check if current target has any snapshot from the given profile.
--- @param profileId string
--- @return boolean
function Snapshotter:HasSnapshotGroupOnTarget(profileId)
    local profile = self:GetSnapshotOverlayProfile(profileId)
    if not profile or not profile.spellIDs then return false end
    local guid = UnitGUID("target")
    if not guid then return false end
    for _, spellID in ipairs(profile.spellIDs) do
        local map = self.state and self.state.snapshots and self.state.snapshots[spellID]
        if type(map) == "table" and (map[guid] or map["*"]) then
            return true
        end
    end
    return false
end

--- Send overlay-update message for any profile that includes this spellID.
--- @param spellID number
function Snapshotter:SendSnapshotOverlayUpdateForSpell(spellID)
    for profileId, profile in pairs(SNAPSHOT_OVERLAY_PROFILES) do
        if profile.spellIDs then
            for _, sid in ipairs(profile.spellIDs) do
                if sid == spellID then
                    if profile.messageName then
                        self:SendMessage(profile.messageName, profileId)
                    end
                    break
                end
            end
        end
    end
end

--- Get combined DK disease snapshot DPS for current target (Frost Fever + Blood Plague).
--- @return number|nil DPS or nil if no snapshot for target
function Snapshotter:GetDKDiseaseSnapshotDPS()
    return self:GetSnapshotGroupSnapshotDPS("dk_disease")
end

--- Get the DPS the current player stats would deal with active DK disease snapshots.
--- @return number|nil
function Snapshotter:GetDKDiseaseCurrentDPS()
    return self:GetSnapshotGroupCurrentDPS("dk_disease")
end

--- Get the percentage of current-stats predicted vs snapshotted predicted for DK diseases.
--- @return number|nil percentage (e.g. 110), or nil if no snapshot/can't compute
function Snapshotter:GetDKDiseaseSnapshotPercent()
    return self:GetSnapshotGroupSnapshotPercent("dk_disease")
end

--- Check if current target has any DK disease snapshot (Frost Fever or Blood Plague).
--- @return boolean
function Snapshotter:HasDKDiseaseOnTarget()
    return self:HasSnapshotGroupOnTarget("dk_disease")
end

--- Debug function to show snapshot for a specific spell
function Snapshotter:DebugSnapshot(spellID)
    local snapshotSpellID = self:NormalizeSnapshotSpellID(spellID) or spellID
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local displayName = self:GetDebuffName(spellID) or (spellInfo and spellInfo.name) or tostring(spellID)

    local map = self.state.snapshots[snapshotSpellID]
    if type(map) ~= "table" then
        self:DebugPrint(format("No snapshot found for %s (spellID: %d)", tostring(displayName), spellID))
        return
    end
    local guid = UnitGUID("target") or "*"
    local snapshot = map[guid] or map["*"]
    if not snapshot then
        -- fall back to any entry
        for _, v in pairs(map) do
            if type(v) == "table" then
                snapshot = v
                break
            end
        end
    end
    if not snapshot then
        self:DebugPrint(format("No snapshot entries found for %s (spellID: %d)", tostring(displayName), spellID))
        return
    end

    self:DebugPrint(format("=== Snapshot for %s (ID: %d) ===", tostring(displayName), spellID))

    for statName, value in pairs(snapshot) do
        if statName == "time" then
            self:DebugPrint(format("  %s: %.2f", statName, value))
        elseif statName == "sourceSpellID" then
            local spellInfo = WoWAPI.GetSpellInfo(value)
            local sourceSpellName = spellInfo and spellInfo.name or "Unknown"
            self:DebugPrint(format("  %s: %d (%s)", statName, value, sourceSpellName))
        elseif statName == "percentMod" then
            self:DebugPrint(format("  %s: %.3f", statName, value))
        else
            self:DebugPrint(format("  %s: %d", statName, value))
        end
    end

    self:DebugPrint("========================")
end

--- Debug function to show summary of all snapshots
function Snapshotter:DebugSnapshotSummary()
    local count = 0
    for _, _ in pairs(self.state.snapshots) do
        count = count + 1
    end

    if count == 0 then
        self:DebugPrint("No snapshots stored")
        return
    end

    self:DebugPrint(format("=== Snapshot Summary (%d spellIDs) ===", count))

    for sid, map in pairs(self.state.snapshots) do
        local spellInfo = WoWAPI.GetSpellInfo(sid)
        local spellName = spellInfo and spellInfo.name or tostring(sid)

        local entryCount = 0
        local anySnapshot = nil
        if type(map) == "table" then
            for _, v in pairs(map) do
                entryCount = entryCount + 1
                if not anySnapshot and type(v) == "table" then
                    anySnapshot = v
                end
            end
        end

        local statCount = 0
        if anySnapshot then
            for statName, _ in pairs(anySnapshot) do
                if statName ~= "time" and statName ~= "sourceSpellID" then
                    statCount = statCount + 1
                end
            end
        end

        local isActive = self.state.activeDebuffs[sid] and "ACTIVE" or "EXPIRED"
        self:DebugPrint(format("  %s (ID: %d): %d entries, %d stats (%s)", spellName, sid, entryCount, statCount, isActive))
    end

    self:DebugPrint("================================")
end

--- Debug function to show active buffs/debuffs
function Snapshotter:DebugActiveBuffs()
    local buffCount = 0
    for spellID, _ in pairs(self.state.activeBuffs) do
        buffCount = buffCount + 1
    end

    local debuffCount = 0
    for _, _ in pairs(self.state.activeDebuffs) do
        debuffCount = debuffCount + 1
    end

    if buffCount == 0 and debuffCount == 0 then
        self:DebugPrint("No active buffs/debuffs tracked")
        return
    end

    self:DebugPrint(format("=== Active Buffs (%d) ===", buffCount))
    for spellID, _ in pairs(self.state.activeBuffs) do
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        local spellName = spellInfo and spellInfo.name or "Unknown"
        self:DebugPrint(format("  %s (ID: %d)", spellName, spellID))
    end

    self:DebugPrint(format("=== Active Debuffs (%d) ===", debuffCount))
    for sid, _ in pairs(self.state.activeDebuffs) do
        local spellInfo = WoWAPI.GetSpellInfo(sid)
        local spellName = spellInfo and spellInfo.name or tostring(sid)
        self:DebugPrint(format("  %s (ID: %d)", spellName, sid))
    end

    self:DebugPrint("================================")
end

--- Debug function to show warnings (tracked errors)
function Snapshotter:DebugWarnings()
    if not ns.GetTrackedErrors then
        return
    end

    local trackedErrors = ns.GetTrackedErrors()
    if not trackedErrors or #trackedErrors == 0 then
        return
    end

    self:Print("|cFFFFAA00=== WARNINGS ===|r")
    self:Print("|cFFFFAA00The following errors were detected during gameplay:|r")
    self:Print()

    -- Group errors by type for better organization
    local errorsByType = {}
    for _, errorEntry in ipairs(trackedErrors) do
        local errorType = errorEntry.type or "Unknown"
        if not errorsByType[errorType] then
            errorsByType[errorType] = {}
        end
        tinsert(errorsByType[errorType], errorEntry)
    end

    -- Display errors grouped by type
    for errorType, errors in pairs(errorsByType) do
        local typeLabel = errorType == "LuaError" and "Lua Errors" or
                         errorType == "RotationError" and "Rotation String Errors" or
                         errorType == "InternalError" and "Internal Errors" or
                         errorType
        self:Print("|cFFFF8800" .. typeLabel .. " (" .. #errors .. "):|r")
        for i, errorEntry in ipairs(errors) do
            -- Limit to last 10 errors per type to avoid spam
            if i <= 10 then
                local timestamp = errorEntry.timestamp and format("[%.1f] ", errorEntry.timestamp) or ""
                local message = errorEntry.message or "Unknown error"
                self:Print("  " .. timestamp .. message)

                -- Show context if available
                if errorEntry.context then
                    if errorEntry.context.rotationName then
                        self:Print("    Rotation: " .. tostring(errorEntry.context.rotationName))
                    end
                    if errorEntry.context.validator then
                        self:Print("    Validator: " .. tostring(errorEntry.context.validator))
                    end
                end
            elseif i == 11 then
                self:Print("  ... (" .. (#errors - 10) .. " more errors)")
                break
            end
        end
        self:Print()
    end
end

--- Get current live stat value for a given stat name
function Snapshotter:GetCurrentStat(statName)
    if not statName or not CONSTANTS.VALID_STATS[statName] then
        -- if self.debug then self:Debug("Invalid stat name: %s", statName or "nil") end
        return 0
    end

    local value = 0

    if statName == "str" then
        value = UnitStat("player", CONSTANTS.STAT_INDICES.str) or 0
    elseif statName == "agi" then
        value = UnitStat("player", CONSTANTS.STAT_INDICES.agi) or 0
    elseif statName == "int" then
        value = UnitStat("player", CONSTANTS.STAT_INDICES.int) or 0
    elseif statName == "crit" then
        value = GetCritChanceCompat()
    elseif statName == "haste" then
        value = GetHasteCompat()
    elseif statName == "mastery" then
        value = GetMasteryEffectCompat()
    elseif statName == "ap" then
        local base, posBuff, negBuff = UnitAttackPower("player")
        value = (base or 0) + (posBuff or 0) + (negBuff or 0)
    end

    return value
end

--- Check if a buff/debuff is still active
function Snapshotter:IsAuraActive(spellID)
    return self.state.activeBuffs[spellID] == true
end

-- Add global API function to NAG namespace
do
    --- Query and compare stat snapshots with current values

    --- This function provides a flexible way to:
    --- 1. Get snapshot values for DoT effects that are still active
    --- 2. Get raw current stat values without comparison
    ---
    --- For active DoTs, returns the snapshot value (the stat value when the DoT was applied):
    --- - This represents the stat value at the time the DoT was cast
    --- - Useful for determining the "snapshot" value that affects DoT damage
    ---
    --- For expired DoTs, returns the current stat value.
    ---
    --- @param ... any Variable number of arguments:
    ---   - number: spellID to check snapshot for
    ---   - string: stat name(s) to check. Valid stats: "str", "agi", "int", "crit", "haste", "mastery", "ap"
    --- @return number The snapshot value or current value:
    ---   - With spellID (active DoT): snapshot_stat value
    ---   - With spellID (expired DoT): current_stat value
    ---   - Without spellID: sum of current stats
    ---
    --- @usage
    --- -- Get attack power snapshot for a DoT
    --- local snapshotAP = NAG:Snapshot("ap", 55095)  -- Returns: AP value when Frost Fever was applied
    ---
    --- -- Get current strength + agility (no comparison)
    --- local total = NAG:Snapshot("str", "agi")  -- Returns: current_str + current_agi
    ---
    --- -- Get multiple stats from snapshot
    --- local snapshotStats = NAG:Snapshot(12345, "crit", "haste")  -- Returns: (snapshot_crit + snapshot_haste)
    ---
    --- -- Arguments can be in any order
    --- local snapshotStats = NAG:Snapshot("ap", 67890, "mastery")  -- Returns: (snapshot_ap + snapshot_mastery)
    function Snapshotter:Snapshot(...)

        local args = { ... }
        local spellID = nil
        local statNames = {}

        -- Parse arguments
        for _, arg in ipairs(args) do
            if type(arg) == "number" then
                spellID = arg
            elseif type(arg) == "string" then
                tinsert(statNames, arg)
            end
        end

        -- Validate stat names
        local validStats = self:ValidateStatArgs(statNames)
        if #validStats == 0 then
            self:DebugPrint("No valid stat arguments provided")
            return 0
        end

        -- If no spellID provided, return live current stat sum (apply current percent mod)
        if not spellID then
            local total = 0
            for _, statName in ipairs(validStats) do
                local value = self:GetCurrentStat(statName)
                total = total + value
            end
            local currentMod = GetDamagePercentModCompat()
            local scaled = total * currentMod
            self:DebugPrint(format("Live stat sum: %d x mod %.3f => %d", total, currentMod, scaled))
            return scaled
        end

        local snapshotSpellID = self:NormalizeSnapshotSpellID(spellID) or spellID
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        local displayName = self:GetDebuffName(spellID) or (spellInfo and spellInfo.name) or tostring(spellID)

        -- Check if snapshot exists (spellID + target GUID)
        local map = self.state.snapshots[snapshotSpellID]
        local guid = UnitGUID("target") or "*"
        local snapshot = nil
        if type(map) == "table" then
            snapshot = map[guid] or map["*"]
            if not snapshot then
                -- Try to find any entry with perSpell (prefer real debuff snapshots over baselines)
                for k, v in pairs(map) do
                    if type(v) == "table" and v.perSpell then
                        snapshot = v
                        guid = k
                        break
                    end
                end
            end
        end

        if not snapshot then
            local ensuredSnapshot = self:EnsureSnapshotForSpell(spellID, "target", "snapshot ensure")
            if ensuredSnapshot then
                snapshot = ensuredSnapshot
            else
                self:DebugPrint(format("No snapshot found for %s (spellID: %d)", tostring(displayName), spellID))
                return 0
            end
        end

        -- Check if this debuff is still active on the target
        local isDoTActive = NAG:DotRemainingTime(spellID) > 0

        if isDoTActive then
            -- DoT is still active - return the snapshot value
            local total = 0
            for _, statName in ipairs(validStats) do
                local snapshotValue = snapshot[statName] or 0
                total = total + snapshotValue
                self:DebugPrint(format("Active DoT %s - stat %s: snapshot=%d", tostring(displayName), statName, snapshotValue))
            end
            local mod = snapshot.percentMod or 1
            local scaled = total * mod
            self:DebugPrint(format("Active DoT %s (ID: %d) - snapshot total %d x mod %.3f => %d", tostring(displayName),
                spellID, total, mod, scaled))
            return scaled
        else
            -- DoT has expired - return current live values
            local total = 0
            for _, statName in ipairs(validStats) do
                local currentValue = Snapshotter:GetCurrentStat(statName)
                total = total + currentValue
                self:DebugPrint(format("Expired DoT %s - stat %s: current=%d", tostring(displayName), statName, currentValue))
            end
            local currentMod = GetDamagePercentModCompat()
            local scaled = total * currentMod
            self:DebugPrint(format("Expired DoT %s (ID: %d) - current total %d x mod %.3f => %d", tostring(displayName),
                spellID, total, currentMod, scaled))
            return scaled
        end
    end

    --- Calculate percentage difference between current stats and snapshot values
    ---
    --- This function calculates the percentage change from snapshot to current values:
    --- - Positive values indicate stat gains (e.g., 0.2 = 20% increase)
    --- - Negative values indicate stat losses (e.g., -0.1 = 10% decrease)
    --- - Zero indicates no change
    ---
    --- @param spellID number The spell ID to compare snapshot against
    --- @param ... string Variable number of stat names to compare ("str", "agi", "int", "crit", "haste", "mastery", "ap")
    --- @return number The percentage difference: (current_total / snapshot_total) - 1
    ---   - Returns 0 if no snapshot exists or snapshot total is 0
    ---   - Returns 0 if no valid stats provided
    ---
    --- @usage
    --- -- Check AP percentage difference for a buff
    --- local apPercent = NAG:SnapshotPercent(59879, "ap")  -- Returns: (current_ap / snapshot_ap) - 1
    ---
    --- -- Check combined crit + haste percentage difference
    --- local combinedPercent = NAG:SnapshotPercent(12345, "crit", "haste")  -- Returns: ((current_crit + current_haste) / (snapshot_crit + snapshot_haste)) - 1
    ---
    --- -- Example usage in conditions:
    --- -- if NAG:SnapshotPercent(59879, "ap") > 0.1 then  -- If AP increased by more than 10%
    function Snapshotter:SnapshotPercent(spellID, ...)

        -- Validate spellID
        if not spellID or type(spellID) ~= "number" then
            self:DebugPrint("Invalid spellID provided to SnapshotPercent")
            return 0
        end

        -- Parse stat arguments
        local args = { ... }
        local statNames = {}
        for _, arg in ipairs(args) do
            if type(arg) == "string" then
                tinsert(statNames, arg)
            end
        end

        -- Validate stat names
        local validStats = self:ValidateStatArgs(statNames)
        if #validStats == 0 then
            self:DebugPrint("No valid stat arguments provided to SnapshotPercent")
            return 0
        end

        local snapshotSpellID = self:NormalizeSnapshotSpellID(spellID) or spellID
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        local displayName = self:GetDebuffName(spellID) or (spellInfo and spellInfo.name) or tostring(spellID)

        -- Check if snapshot exists for this spellID, scoped by target GUID
        local map = self.state.snapshots[snapshotSpellID]
        local guid = UnitGUID("target") or "*"
        local snapshot = nil

        if type(map) == "table" then
            snapshot = map[guid] or map["*"]
            if not snapshot then
                -- Try to find any entry with perSpell (prefer real debuff snapshots over baselines)
                for k, v in pairs(map) do
                    if type(v) == "table" and v.perSpell then
                        snapshot = v
                        guid = k
                        break
                    end
                end
            end
        end

        if not snapshot then
            self:DebugPrint(format("No snapshot found for %s (spellID: %d)", tostring(displayName), spellID))
            return 0
        end

        -- Check if this debuff is still active on the target
        local isDoTActive = NAG:DotRemainingTime(spellID) > 0

        if not isDoTActive then
            self:DebugPrint(format("Dot expired, returning 0 for %s (ID: %d)", tostring(displayName), spellID))
            return 0
        end

        -- Calculate snapshot total
        local snapshotTotal = 0
        for _, statName in ipairs(validStats) do
            local value = snapshot[statName] or 0
            snapshotTotal = snapshotTotal + value
        end

        -- Avoid division by zero
        if snapshotTotal == 0 then
            self:DebugPrint(format("Snapshot total is 0 for debuff %s (spellID: %d), cannot calculate percentage",
                debuffName, spellID))
            return 0
        end

        -- Calculate current total
        local currentTotal = 0
        for _, statName in ipairs(validStats) do
            local value = self:GetCurrentStat(statName)
            currentTotal = currentTotal + value
        end

        -- Apply damage multipliers to both numerator and denominator
        local currentMod = GetDamagePercentModCompat()
        local snapshotMod = snapshot.percentMod or 1
        local scaledCurrent = currentTotal * currentMod
        local scaledSnapshot = snapshotTotal * snapshotMod

        -- Calculate percentage difference: (scaled current / scaled snapshot) - 1
        local percentDiff = (scaledCurrent / scaledSnapshot) - 1

        self:DebugPrint(format(
            "SnapshotPercent for %s (ID: %d): current=%d x mod %.3f => %d, snapshot=%d x mod %.3f => %d, diff=%.3f (%.1f%%)",
            tostring(displayName), spellID, currentTotal, currentMod, scaledCurrent, snapshotTotal, snapshotMod, scaledSnapshot,
            percentDiff, percentDiff * 100))

        return percentDiff
    end

    --- Calculate DoT damage increase percentage based on attack power changes
    ---
    --- This is a specialized function for DoT (Damage over Time) effects that snapshot
    --- attack power when applied. It calculates how much the DoT damage has increased
    --- since the spell was cast based on current vs snapshot attack power.
    ---
    --- @param spellID number The spell ID of the DoT to check
    --- @return number The attack power percentage difference: (current_ap / snapshot_ap) - 1
    ---   - Positive values indicate damage increase (e.g., 0.15 = 15% more damage)
    ---   - Negative values indicate damage decrease (e.g., -0.1 = 10% less damage)
    ---   - Returns 0 if no snapshot exists or snapshot AP is 0
    ---
    --- @usage
    --- -- Check how much a DoT's damage has increased since application
    --- local damageIncrease = NAG:DotPercentIncrease(59879)
    ---
    --- -- Example usage in conditions:
    --- -- if NAG:DotPercentIncrease(rip_spellid) > 0.2 then  -- If damage increased by 20%+
    --- --     -- Consider refreshing the DoT for higher damage
    --- -- end --NAG:DotPercentIncrease(59879)
    --- @TODO Add targetUnit 2nd parameter
    function Snapshotter:DotPercentIncrease(spellID, targetUnit, useBaseValue)
        -- Check if second parameter is a stat name (for simple stat comparison)
        if type(targetUnit) == "string" and CONSTANTS.VALID_STATS[targetUnit] then
            -- Simple stat-based comparison: NAG:DotPercentIncrease(980, "sp")
            -- Special case: Soul Swap returns sum of all three DoTs
            if spellID == 86121 then
                local uaIncrease = self:SnapshotPercent(30108, targetUnit) or 0
                local corruptionIncrease = self:SnapshotPercent(172, targetUnit) or 0
                local agonyIncrease = self:SnapshotPercent(980, targetUnit) or 0
                return uaIncrease + corruptionIncrease + agonyIncrease
            end
            return self:SnapshotPercent(spellID, targetUnit)
        end

        -- Special case: Soul Swap (86121) returns (sum of new DPS) / (sum of old DPS) - 1
        if spellID == 86121 then
            local dotIds = {30108, 172, 980} -- UA, Corruption, Agony
            local resolvedUnit = targetUnit or "target"
            local guid = (resolvedUnit == "*") and "*" or (UnitGUID(resolvedUnit) or UnitGUID("target"))

            -- Helper functions (duplicated from CalculatePercentIncreaseWithMath scope)
            local function Round(num)
                return math.floor(num + 0.5)
            end

            local function wlkTickCadence(baseTick, totalDur, haste)
                local tickEvery = baseTick / (1 + (haste / 100))
                local ticks = Round(totalDur / tickEvery)
                local duration = ticks * tickEvery
                return tickEvery, ticks, duration
            end

            local function computeWlkDPS(id, st)
                if id == 146739 or id == 172 then -- Corruption
                    local tickEvery, ticks, duration = wlkTickCadence(2, 18, st.haste)
                    local tickDmg = (234 + st.sp6 * 0.219497) * st.masteryBonus * st.damageMultiplier * st.critBonus
                    return Round((tickDmg * ticks) / duration)
                elseif id == 980 then -- Agony (assume 10 stacks)
                    local tickEvery, ticks, duration = wlkTickCadence(2, 24, st.haste)
                    local tickDmg = (28 + st.sp6 * 0.026769) * 10 * st.masteryBonus * st.damageMultiplier * st.critBonus
                    return Round((tickDmg * ticks) / duration)
                elseif id == 30108 then -- UA
                    local tickEvery, ticks, duration = wlkTickCadence(2, 14, st.haste)
                    local tickDmg = (310 + st.sp6 * 0.29) * st.masteryBonus * st.damageMultiplier * st.critBonus
                    return Round((tickDmg * ticks) / duration)
                end
                return nil
            end

            -- Helper to compute warlock stats from a snapshot
            local function computeWarlockStatsFromSnapshot(snap)
                if not snap or not snap.wlk then
                    -- Fallback to current stats
                    local haste = GetSpellHastePercentCompat()
                    local crit = GetSpellCritChanceCompat(6)
                    local spd6 = GetSpellPowerCompat(6)
                    local spd3 = GetSpellPowerCompat(3)
                    local damageMult = GetDamagePercentModCompat()
                    local masteryPts = (GetMastery and GetMastery()) or GetMasteryEffectCompat() or 0
                    local spec = (C_SpecializationInfo and C_SpecializationInfo.GetSpecialization and C_SpecializationInfo.GetSpecialization(false)) or nil
                    local metaActive = (NAG:UnitBuff("player", 103958) and true or false)

                    local masteryBonus, doomBonus, FABBonus
                    if spec == 1 then -- Affliction
                        masteryBonus = 1 + ((masteryPts * 3.1) / 100)
                    elseif spec == 2 then -- Demonology
                        masteryBonus = 1 + (masteryPts / 100)
                        doomBonus = 1 + ((3 * masteryPts) / 100)
                        if metaActive then
                            damageMult = damageMult / doomBonus
                        else
                            damageMult = damageMult / masteryBonus
                        end
                    elseif spec == 3 then -- Destruction
                        masteryBonus = 1 + ((masteryPts + 1) / 100)
                        FABBonus = ((100 + masteryPts * 3) * 0.35) / 100
                    else
                        masteryBonus = 1
                    end

                    return {
                        haste = haste,
                        critBonus = 1 + (crit / 100),
                        sp6 = spd6,
                        sp3 = spd3,
                        damageMultiplier = damageMult,
                        masteryBonus = masteryBonus or 1,
                        doomBonus = doomBonus or 1,
                        FABBonus = FABBonus or 1,
                    }
                end

                local w = snap.wlk
                local haste = w.hastePct or GetSpellHastePercentCompat()
                local crit = w.critPct or GetSpellCritChanceCompat(6)
                local spd6 = w.spShadow or GetSpellPowerCompat(6)
                local spd3 = w.spFire or GetSpellPowerCompat(3)
                local damageMult = w.damageMultiplier or GetDamagePercentModCompat()
                local masteryPts = w.masteryPts or (GetMastery and GetMastery()) or GetMasteryEffectCompat() or 0
                local spec = w.spec or (C_SpecializationInfo and C_SpecializationInfo.GetSpecialization and C_SpecializationInfo.GetSpecialization(false)) or nil
                local metaActive = w.metaActive or (NAG:UnitBuff("player", 103958) and true or false)

                local masteryBonus, doomBonus, FABBonus
                if spec == 1 then -- Affliction
                    masteryBonus = 1 + ((masteryPts * 3.1) / 100)
                elseif spec == 2 then -- Demonology
                    masteryBonus = 1 + (masteryPts / 100)
                    doomBonus = 1 + ((3 * masteryPts) / 100)
                    if metaActive then
                        damageMult = damageMult / doomBonus
                    else
                        damageMult = damageMult / masteryBonus
                    end
                elseif spec == 3 then -- Destruction
                    masteryBonus = 1 + ((masteryPts + 1) / 100)
                    FABBonus = ((100 + masteryPts * 3) * 0.35) / 100
                else
                    masteryBonus = 1
                end

                return {
                    haste = haste,
                    critBonus = 1 + (crit / 100),
                    sp6 = spd6,
                    sp3 = spd3,
                    damageMultiplier = damageMult,
                    masteryBonus = masteryBonus or 1,
                    doomBonus = doomBonus or 1,
                    FABBonus = FABBonus or 1,
                }
            end

            -- Helper to compute current warlock stats
            local function computeWarlockStatsCurrent()
                local haste = GetSpellHastePercentCompat()
                local crit = GetSpellCritChanceCompat(6)
                local spd6 = GetSpellPowerCompat(6)
                local spd3 = GetSpellPowerCompat(3)
                local damageMult = GetDamagePercentModCompat()
                local masteryPts = (GetMastery and GetMastery()) or GetMasteryEffectCompat() or 0
                local spec = (C_SpecializationInfo and C_SpecializationInfo.GetSpecialization and C_SpecializationInfo.GetSpecialization(false)) or nil
                local metaActive = (NAG:UnitBuff("player", 103958) and true or false)

                local masteryBonus, doomBonus, FABBonus
                if spec == 1 then -- Affliction
                    masteryBonus = 1 + ((masteryPts * 3.1) / 100)
                elseif spec == 2 then -- Demonology
                    masteryBonus = 1 + (masteryPts / 100)
                    doomBonus = 1 + ((3 * masteryPts) / 100)
                    if metaActive then
                        damageMult = damageMult / doomBonus
                    else
                        damageMult = damageMult / masteryBonus
                    end
                elseif spec == 3 then -- Destruction
                    masteryBonus = 1 + ((masteryPts + 1) / 100)
                    FABBonus = ((100 + masteryPts * 3) * 0.35) / 100
                else
                    masteryBonus = 1
                end

                return {
                    haste = haste,
                    critBonus = 1 + (crit / 100),
                    sp6 = spd6,
                    sp3 = spd3,
                    damageMultiplier = damageMult,
                    masteryBonus = masteryBonus or 1,
                    doomBonus = doomBonus or 1,
                    FABBonus = FABBonus or 1,
                }
            end

            local sumDpsSnap = 0
            local sumDpsNow = 0

            -- Get current stats once (used for all DoTs)
            local curSt = computeWarlockStatsCurrent()

            -- For each DoT, get snapshot and calculate DPS
            for _, dotId in ipairs(dotIds) do
                local snap = nil
                local snapId = self:NormalizeSnapshotSpellID(dotId) or dotId
                local map = self.state and self.state.snapshots and self.state.snapshots[snapId]
                if type(map) == "table" then
                    snap = (guid and map[guid]) or map["*"]
                    -- Fallback: try any entry if still nil
                    if not snap then
                        for _, v in pairs(map) do
                            if type(v) == "table" and v.wlk then
                                snap = v
                                break
                            end
                        end
                    end
                end

                if not snap then
                    snap = self:EnsureSnapshotForSpell(dotId, resolvedUnit, "soul swap ensure snapshot")
                end

                -- Calculate DPS: snapshot vs current
                if snap and snap.wlk then
                    -- DoT is present - calculate snapshot and current DPS
                    local snapSt = computeWarlockStatsFromSnapshot(snap)
                    local dpsSnap = computeWlkDPS(dotId, snapSt)
                    local dpsNow = computeWlkDPS(dotId, curSt)
                    if dpsSnap and dpsNow and dpsSnap > 0 then
                        sumDpsSnap = sumDpsSnap + dpsSnap
                        sumDpsNow = sumDpsNow + dpsNow
                    end
                else
                    -- DoT is NOT present - use 0 for both (doesn't contribute to calculation)
                    -- This allows calculation to proceed with only 1 or 2 DoTs present
                end
            end

            if sumDpsSnap <= 0 then
                self:DebugPrint("Soul Swap (86121): no valid snapshots found, returning 0")
                return 0
            end

            local percentDiff = (sumDpsNow / sumDpsSnap) - 1
            self:DebugPrint(format("Soul Swap (86121) DPS sum: current=%.1f, snapshot=%.1f, diff=%.3f (%.1f%%)",
                sumDpsNow, sumDpsSnap, percentDiff, percentDiff * 100))
            return percentDiff
        end

        -- print("DotPercentIncrease: spellID=" .. tostring(spellID))
        -- self:DebugPrint(string.format("DPI start spellID=%d", spellID))
        self:DebugPrint(format("DotPercentIncrease snapshot keys available: %s",
            (function()
                local t = {}
                local snaps = self.state and self.state.snapshots or {}
                local c = 0
                for k, _ in pairs(snaps) do
                    c = c + 1
                    if c <= 5 then table.insert(t, tostring(k)) end
                end
                return table.concat(t, ", ")
            end)()))
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        local spellName = spellInfo and spellInfo.name or "Unknown"
        local resolvedUnit = targetUnit or "target"

        local snapshotSpellID = self:NormalizeSnapshotSpellID(spellID) or spellID
        local resolvedSnapshot = nil
        local map = self.state and self.state.snapshots and self.state.snapshots[snapshotSpellID]

        -- Resolve GUID-scoped snapshot
        local guid
        if resolvedUnit == "*" then
            guid = "*"
        else
            guid = UnitGUID(resolvedUnit)
        end
        if (not guid or guid == "") and spellID == 1079 then
            guid = self.lastRipGUID
        end
        if not guid then
            guid = UnitGUID("target")
        end

        local usedWildcard = false
        if type(map) == "table" then
            resolvedSnapshot = (guid and map[guid]) or nil
            if not resolvedSnapshot and map["*"] then
                resolvedSnapshot = map["*"]
                usedWildcard = true
            end
            -- As a debugging fallback, if still nil, try any entry in the map
            if not resolvedSnapshot then
                for _, v in pairs(map) do
                    if type(v) == "table" then
                        resolvedSnapshot = v
                        break
                    end
                end
            end

            -- Require the debuff to be active to use snapshot
            local isActiveOnTarget = false
            if usedWildcard then
                isActiveOnTarget = self:IsDebuffActive(snapshotSpellID)
            elseif guid then
                isActiveOnTarget = self:IsDebuffActive(snapshotSpellID, guid)
            end
            if not isActiveOnTarget then
                resolvedSnapshot = nil
            end

            -- DK disease safeguard: if consumed, clear stale snapshot records
            if snapshotSpellID == 55095 or snapshotSpellID == 55078 then
                local stillActive = NAG and NAG.DotIsActive and NAG:DotIsActive(snapshotSpellID, resolvedUnit)
                if not stillActive then
                    if guid and map[guid] then
                        map[guid] = nil
                    end
                    resolvedSnapshot = nil
                end
            end
        end

        -- Boss fallback: if GUID changes mid-encounter, use last snapshot by target name
        if not resolvedSnapshot then
            local inInstance, instanceType = IsInInstance()
            local bossLevel = UnitLevel and UnitLevel("target") or 0
            local isBoss = bossLevel and bossLevel < 0
            if (inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario")) and isBoss then
                local debuffActive = (NAG and NAG.DotIsActiveByPlayer and NAG:DotIsActiveByPlayer(spellID, "target", false)) == true
                if debuffActive then
                    local tName = UnitName("target")
                    local byNameMap = self.state.snapshotsByTargetName and self.state.snapshotsByTargetName[snapshotSpellID]
                    local rec = byNameMap and tName and byNameMap[tName]
                    if rec and type(rec) == "table" and rec.snapshot then
                        resolvedSnapshot = rec.snapshot
                    end
                end
            end
        end

        -- For target-specific resolution: if no valid snapshot for current target, do NOT synthesize baseline; return 0
        if not resolvedSnapshot then
            resolvedSnapshot = self:EnsureSnapshotForSpell(spellID, resolvedUnit, "dpi ensure snapshot")
            if not resolvedSnapshot then
                return 0
            end
        end

        -- Balance Druid path: use predicted-total ratio for Moonfire/Sunfire
        if (spellID == 8921 or spellID == 93402) and resolvedSnapshot and type(resolvedSnapshot.perSpell) == "table" then
            local basePredicted = tonumber(resolvedSnapshot.perSpell.predictedTotal)
            local currentPredicted = self:ComputeBalanceDoTPredicted(spellID)
            if basePredicted and basePredicted > 0 and type(currentPredicted) == "number" then
                local diff = (currentPredicted / basePredicted) - 1
                -- self:Print(string.format("DPI: Balance predicted path spellID=%d current=%d base=%d -> diff=%.4f", spellID, currentPredicted, basePredicted, diff))
                return diff
            end
        end

        -- Prefer predicted totals for Feral bleeds (WA-aligned) before math-based shortcuts
        if FERAL_BLEED_SPELLS[spellID] then
            local base = resolvedSnapshot and resolvedSnapshot.perSpell and resolvedSnapshot.perSpell.predictedTotal
            local current = self:ComputeFeralDoTPredicted(spellID)
            if type(base) == "number" and base > 0 and type(current) == "number" then
                local diff = (current / base) - 1
                -- print(format(
                --     "Snapshotter: DPI Feral predicted (preferred): spellID=%d current=%d base=%d diff=%.4f",
                --     spellID, current, base, diff))
                return diff
            end
        end

        -- Try math with existing snapshot; if none, synthesize a baseline snapshot so math still runs (returns 0)
        if not resolvedSnapshot then
            resolvedSnapshot = {
                -- minimal fields needed for math handlers
                ap = self:GetCurrentStat("ap"),
                sp = GetSpellPowerCompat(6),
                sp_fire = GetSpellPowerCompat(3),
                percentMod = GetDamagePercentModCompat(),
                sourceSpellID = spellID,
            }
            if spellID == 8921 or spellID == 93402 then
                -- print("MF/SF DPR: synthesized baseline snapshot; math will likely return nil without snapTooltip")
            end
            PrintIfRipByID(spellID, "DotPercentIncrease debug: synthesized baseline snapshot for spellID=" .. tostring(spellID))
        end

        local mathPercent = nil
        if not FERAL_BLEED_SPELLS[spellID] then
            mathPercent = self:CalculatePercentIncreaseWithMath(spellID, resolvedSnapshot)
            if spellID == 8921 or spellID == 93402 then
                -- print("MF/SF DPR: mathPercent type=" .. tostring(type(mathPercent)) .. " value=" .. tostring(mathPercent))
            end
            PrintIfRipByID(spellID, "DotPercentIncrease debug: mathPercent type=" .. tostring(type(mathPercent)) .. " value=" .. tostring(mathPercent))
            if type(mathPercent) == "number" then
                -- self:Print(format("DPI: using math path, result=%.4f", mathPercent))
                PrintIfRipByID(spellID, "DotPercentIncrease path: math-based formula for spellID=" .. tostring(spellID) .. " (" .. spellName .. ")")
                return mathPercent
            end
        end

        -- Prefer per-spell declared stats captured at snapshot time
        local preferredStats = nil
        if resolvedSnapshot and type(resolvedSnapshot.perSpell) == "table" and type(resolvedSnapshot.perSpell.preferredStats) == "table" and #resolvedSnapshot.perSpell.preferredStats > 0 then
            preferredStats = resolvedSnapshot.perSpell.preferredStats
        end

        -- For Feral, Balance, and DK diseases we prefer predicted totals over raw stat comparisons
        if spellID == 1079 or spellID == 1822 or spellID == 106830 then
            local base = resolvedSnapshot and resolvedSnapshot.perSpell and resolvedSnapshot.perSpell.predictedTotal
            local current = self:ComputeFeralDoTPredicted(spellID)
            if type(base) == "number" and base > 0 and type(current) == "number" then
                local diff = (current / base) - 1
                -- print(format(
                --     "Snapshotter: DPI Feral predicted (fallback): spellID=%d current=%d base=%d diff=%.4f",
                --     spellID, current, base, diff))
                return diff
            end
        end
        if spellID == 55095 or spellID == 55078 then
            local base = resolvedSnapshot and resolvedSnapshot.perSpell and resolvedSnapshot.perSpell.predictedTotal
            local current = self:ComputeDKDoTPredicted(spellID)
            if type(base) == "number" and base > 0 and type(current) == "number" then
                local diff = (current / base) - 1
                -- self:Print(string.format("DPI: DK predicted path spellID=%d current=%d base=%d -> diff=%.4f", spellID, current, base, diff))
                return diff
            end
        end

        -- Fall back to static registry for hardcoded spells
        if not preferredStats then
            preferredStats = PREFERRED_STATS_BY_SPELL[spellID]
        end

        -- Use preferred stats when available, otherwise use class/spec-based fallback
        if type(preferredStats) == "table" and #preferredStats > 0 then
            -- self:Print(format("DPI: using preferred stats path: %s", table.concat(preferredStats, ",")))
            PrintIfRipByID(spellID, "DotPercentIncrease path: raw stats (preferred) for spellID=" .. tostring(spellID) .. " (" .. spellName .. "): " .. table.concat(preferredStats, ","))
            return self:SnapshotPercent(spellID, unpack(preferredStats))
        end

        local fallbackStats = self:GetClassSpecFallbackStatsCached()
        if type(fallbackStats) == "table" and #fallbackStats > 0 then
            -- self:Print(format("DPI: using class/spec fallback path: %s", table.concat(fallbackStats, ",")))
            PrintIfRipByID(spellID, "DotPercentIncrease path: raw stats (class/spec fallback) for spellID=" .. tostring(spellID) .. " (" .. spellName .. "): " .. table.concat(fallbackStats, ","))
            return self:SnapshotPercent(spellID, unpack(fallbackStats))
        end

        -- Final safety fallback
        -- self:Print("DPI: default path: ap")
        PrintIfRipByID(spellID, "DotPercentIncrease path: raw stats (default) for spellID=" .. tostring(spellID) .. " (" .. spellName .. "): ap")
        return self:SnapshotPercent(spellID, "ap")
    end

    -- Public alias used throughout the codebase
    function Snapshotter:DotCritPercentIncrease(spellID, targetUnit, useBaseValue)
        return self:SnapshotPercent(spellID, "crit")
    end

    function Snapshotter:DotTickRatePercentIncrease(spellID, targetUnit, useBaseValue)
        return self:SnapshotPercent(spellID, "haste")
    end
end
