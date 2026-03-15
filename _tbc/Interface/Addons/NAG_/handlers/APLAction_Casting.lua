--- @module "APLAction_Casting"
--- Core APL logic, utility, funnel, and casting handlers for the NAG addon
---
--- This module provides utility functions for spell casting, last cast tracking, and aura cancellation.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- luacheck: ignore GetSpellInfo
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local WoWAPI = ns.WoWAPI
local Version = ns.Version
local PaladinTwistConstants = ns.PaladinTwistConstants or {}

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC
local TablePool = ns.TablePool


local IsUsableItem = C_Item and C_Item.IsUsableItem or _G.IsUsableItem
local GetItemCooldown = C_Container and C_Container.GetItemCooldown or _G.GetItemCooldown
-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local GetTime = _G.GetTime
local GetShapeshiftFormID = _G.GetShapeshiftFormID
local UnitIsPlayer = _G.UnitIsPlayer

local format = string.format
local min = math.min

local tinsert = tinsert
local tremove = tremove
local tContains = tContains

local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

--- When an ID exists in both SPELL and ITEM tables, prefer item only if it is a consumable (e.g. potion).
--- Otherwise prefer spell so trinkets/equipment with dual entries still show as spell.
--- @param itemId number
--- @return boolean
local function isItemConsumable(itemId)
    if not itemId or not WoWAPI or not WoWAPI.GetItemInfo then
        return false
    end
    local _, _, _, _, _, itemType = WoWAPI.GetItemInfo(itemId)
    return itemType == "Consumable"
end

--- Build a cache key that preserves spell/item identity for IDs that can exist in both tables.
--- @param id number
--- @param preferItemFirst boolean
--- @return string
local function buildActionIdentityCacheKey(id, preferItemFirst)
    if DataManager and DataManager.BuildIdentityCacheKey then
        return DataManager:BuildIdentityCacheKey(id, "secondary", preferItemFirst)
    end
    return format("%s:%s", preferItemFirst and "item" or "spell", tostring(id))
end

-- ============================ CAST STATE HELPERS ============================

--- True if the player is currently casting or channeling anything.
--- @return boolean
function NAG:IsCasting()
    if UnitCastingInfo and UnitCastingInfo("player") then
        return true
    end
    if UnitChannelInfo and UnitChannelInfo("player") then
        return true
    end
    return false
end

-- ============================ QUEUE STATE HELPERS ============================

-- Hysteresis for IsQueued() to avoid 1-tick flicker when a queued spell transitions into casting.
-- Keyed by spellID; we keep returning true for a short grace window after the last seen "true".
local queuedSeenTrueAtBySpellId = {}
local QUEUED_FALSE_GRACE_SECONDS = 0.200
-- Cache spell IDs that are known to have a cooldown.
-- Seeded from live cooldown observations and schema-backed entity data.
local spellIdsWithCooldown = {}

--- True if the given spell is currently "queued"/current (e.g., on-next-swing style).
--- Primarily for debugging/testing across clients.
--- Resolves to spellbook ID so we check the spell the player actually has.
--- @param spellID number
--- @return boolean
function NAG:IsQueued(spellID)
    if type(spellID) ~= "number" then
        return false
    end
    if self.ResolveEffectiveSpellId then
        local resolved = self:ResolveEffectiveSpellId(spellID)
        if resolved then
            spellID = resolved
        end
    end
    local isCurrent = false
    if C_Spell and C_Spell.IsCurrentSpell then
        isCurrent = C_Spell.IsCurrentSpell(spellID) and true or false
    elseif _G.IsCurrentSpell then
        isCurrent = _G.IsCurrentSpell(spellID) and true or false
    else
        isCurrent = false
    end

    local now = GetTime and GetTime() or 0

    -- Casting transition guard (important for hunter testing):
    -- Some clients briefly report IsCurrentSpell(spellID)=true during the queued->casting handoff.
    -- If we're currently casting that spell and the GCD is near completion, treat it as NOT queued.
    local _, _, _, _, _, _, _, _, castingSpellId = UnitCastingInfo and UnitCastingInfo("player") or nil
    local isCastingThisSpell = (castingSpellId == spellID) and true or false
    local gcdLeft = (self.GCDTimeToReady and self:GCDTimeToReady()) or 0
    if gcdLeft < 0 then gcdLeft = 0 end
    if isCastingThisSpell and gcdLeft <= 0.500 then
        isCurrent = false
    end

    if isCurrent then
        -- Only seed hysteresis when we are NOT currently casting this spell.
        -- This avoids the cast-end flicker where we would otherwise keep returning true for 200ms.
        if not isCastingThisSpell then
            queuedSeenTrueAtBySpellId[spellID] = now
        end
        return true
    end

    local lastTrueAt = queuedSeenTrueAtBySpellId[spellID]
    if lastTrueAt and now > 0 and (now - lastTrueAt) < QUEUED_FALSE_GRACE_SECONDS then
        return true
    end

    -- Expire stale entry (keeps table small).
    if lastTrueAt and now > 0 and (now - lastTrueAt) >= (QUEUED_FALSE_GRACE_SECONDS * 2) then
        queuedSeenTrueAtBySpellId[spellID] = nil
    end

    return false
end

-- ============================ RECENT BUSY (GCD/CAST) ============================

-- Avoid end-of-window flicker: keep returning true for a short grace window after GCD/casting ends.
local lastBusyAt = nil
local lastBusyActive = false
local BUSY_FALSE_GRACE_SECONDS = 0.200

-- Track last successful spellcast (player) using UNIT_SPELLCAST_SUCCEEDED.
-- This is used to stabilize “recent busy” logic for rotations that require specific sequencing (e.g., SS between MS/AR).
local lastPlayerSpellSucceededAt = nil
local lastPlayerSpellSucceededId = nil
local SUCCESS_RECENT_MAX_AGE_SECONDS = 2.000

-- Proactive cooldown override for TBC Hunter fillers (MS/AR).
-- WoW's GetSpellCooldown can lag 1-2s after cast; we set CD immediately on UNIT_SPELLCAST_SENT.
local MULTI_SHOT_CD_SECONDS = 10
local FILLER_IDS_MS = { [27021] = true, [2643] = true }
local FILLER_IDS_AR = { [27019] = true, [3044] = true }

NAG:RegisterEvent("UNIT_SPELLCAST_SENT", function(_, unit, target, castGUID, spellIdOrName)
    if unit ~= "player" then return end
    local spellId = tonumber(spellIdOrName)
    if not spellId then return end
    local now = GetTime and GetTime() or 0
    if FILLER_IDS_MS[spellId] then
        NAG._FillerCdOverride = NAG._FillerCdOverride or {}
        NAG._FillerCdOverride[27021] = now + MULTI_SHOT_CD_SECONDS
        NAG._FillerCdOverride[2643] = now + MULTI_SHOT_CD_SECONDS
        local bar = NAG:GetModule("HunterSteadyWeaveBar", true)
        if bar and bar.RefreshPredictionSnapshot then
            bar:RefreshPredictionSnapshot(true)
        end
    elseif FILLER_IDS_AR[spellId] then
        local bar = NAG:GetModule("HunterSteadyWeaveBar", true)
        if bar and bar.RefreshPredictionSnapshot then
            bar:RefreshPredictionSnapshot(true)
        end
    end
end)

NAG:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, castGuidOrSpellId, spellIdOrExtra, ...)
    if unit ~= "player" then
        return
    end

    -- Be tolerant across client/event-arg variants: capture the first numeric spell ID.
    local spellId = nil
    if type(spellIdOrExtra) == "number" then
        spellId = spellIdOrExtra
    elseif type(castGuidOrSpellId) == "number" then
        spellId = castGuidOrSpellId
    else
        local argc = select("#", ...)
        for i = 1, argc do
            local v = select(i, ...)
            if type(v) == "number" then
                spellId = v
                break
            end
        end
    end

    if type(spellId) ~= "number" then
        return
    end
    lastPlayerSpellSucceededAt = (GetTime and GetTime()) or 0
    lastPlayerSpellSucceededId = spellId
end)

--- Returns the most recent successful player spellcast ID and how long ago it happened.
--- Intended for debugging/rotation gating (e.g., “ensure SS happened recently”).
--- @return number|nil spellId
--- @return number|nil secondsAgo
function NAG:GetLastPlayerSpellSucceededInfo()
    local now = GetTime and GetTime() or 0
    if not lastPlayerSpellSucceededId or not lastPlayerSpellSucceededAt or lastPlayerSpellSucceededAt <= 0 or now <= 0 then
        return nil, nil
    end
    local age = now - lastPlayerSpellSucceededAt
    if age < 0 then
        age = 0
    end
    return lastPlayerSpellSucceededId, age
end

--- True if the player is casting OR on GCD now, OR if that was true within the last `graceSeconds`.
--- @param graceSeconds number|nil
--- @param requireSucceededSpellId number|nil If provided, this returns true only if that spell was the last successful player spellcast recently.
--- @return boolean
function NAG:IsGCDOrCastingRecently(graceSeconds, requireSucceededSpellId)
    local window = tonumber(graceSeconds) or BUSY_FALSE_GRACE_SECONDS
    if window < 0 then window = 0 end

    local now = GetTime and GetTime() or 0

    local gcdLeft = (self.GCDTimeToReady and self:GCDTimeToReady()) or 0
    if gcdLeft < 0 then gcdLeft = 0 end
    local _, _, _, _, _, _, _, _, castingSpellId = UnitCastingInfo and UnitCastingInfo("player") or nil
    local isCastingAny = (castingSpellId ~= nil) and true or false
    local busyNow = (gcdLeft > 0) or isCastingAny

    local requireOk = true
    if type(requireSucceededSpellId) == "number" then
        requireOk = false
        if lastPlayerSpellSucceededId == requireSucceededSpellId and lastPlayerSpellSucceededAt and lastPlayerSpellSucceededAt > 0 then
            local age = now - lastPlayerSpellSucceededAt
            if age >= 0 and age <= SUCCESS_RECENT_MAX_AGE_SECONDS then
                requireOk = true
            end
        end
        -- Hunter queued-shot case: in TBC, Steady can be queued during Auto wind-up,
        -- which starts GCD before UNIT_SPELLCAST_SUCCEEDED fires. Treat queued required spell as valid sequencing.
        if (not requireOk) and self.IsQueued and self:IsQueued(requireSucceededSpellId) then
            requireOk = true
        end
        -- If the required spell is actively casting now, sequencing requirement is satisfied.
        if (not requireOk) and castingSpellId == requireSucceededSpellId then
            requireOk = true
        end
    end

    if busyNow then
        -- If we're only busy due to GCD (instant casts), enforce sequencing via last successful spell if requested.
        if (type(requireSucceededSpellId) == "number") and (not isCastingAny) and (not requireOk) then
            return false
        end
        lastBusyActive = true
        lastBusyAt = now
        return true
    end

    lastBusyActive = false

    if lastBusyAt and now > 0 and (now - lastBusyAt) < window then
        return requireOk
    end

    return false
end

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local DataManager = ns.DataManager
local StateManager = ns.StateManager
local SpellbookManager = ns.SpellbookManager
local EnhancedAuraHandlers = ns.EnhancedAuraHandlers
local TrinketTrackingManager = ns.TrinketTrackingManager
local RotationManager = ns.RotationManager
local SpecCompat = ns.SpecCompat
local Types = ns.Types
local OverlayManager = ns.OverlayManager
local RequirementsChecker = ns.RequirementsChecker

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ HELPER FUNCTIONS ============================

--- Debug function for spell casting issues
--- @param spellId number The spell ID to debug
--- @param tolerance number|nil Optional casting tolerance
local function debugSpell(spellId, tolerance)
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    print("=== CastSpell Debug for:", spellInfo and spellInfo.name or tostring(spellId), "(ID:", spellId, ") ===")

    -- Check if the spell is known
    local isKnown = NAG:IsKnownSpell(spellId)
    print("IsKnownSpell:", tostring(isKnown))
    if not isKnown then print("-> Spell is not known!") end

    -- Check if the spell can be cast
    local canCast = NAG:SpellCanCast(spellId, tolerance)
    print("SpellCanCast:", tostring(canCast))
    if not canCast then print("-> Spell cannot be cast (see SpellCanCast debug)") end

    -- Check if it's a secondary spell
    local isSecondary = NAG:IsSecondarySpell(spellId)
    print("IsSecondarySpell:", tostring(isSecondary))

    print("===============================================")
end

--- Normalize stat argument to number (supports strings like "str", "crit", etc.)
--- @param v any The stat argument to normalize
--- @return number|nil The normalized stat type number, or nil if invalid
local function normalizeStatArg(v)
    if v == nil or v == -1 then return nil end
    if type(v) == "number" then return v end
    if type(v) == "string" then
        if Types then
            local s = string.lower(v)
            local stat = Types:GetType("Stat")
            if stat then
                local map = {
                    str = stat.STRENGTH,
                    strength = stat.STRENGTH,
                    agi = stat.AGILITY,
                    agility = stat.AGILITY,
                    int = stat.INTELLECT,
                    intellect = stat.INTELLECT,
                    sta = stat.STAMINA,
                    stamina = stat.STAMINA,
                    haste = stat.HASTE,
                    crit = stat.CRIT,
                    mastery = stat.MASTERY,
                    ap = stat.ATTACK_POWER,
                    attack_power = stat.ATTACK_POWER,
                    sp = stat.SPELL_POWER,
                    spell_power = stat.SPELL_POWER,
                    hit = stat.HIT,
                    exp = stat.EXPERTISE,
                    expertise = stat.EXPERTISE
                }
                return map[s]
            end
        end
    end
    return nil
end

--- Add a stat to the requested stats table if valid
--- @param requested table The requested stats table
--- @param val any The stat value to add
local function addRequestedStat(requested, val)
    if val and val ~= -1 then requested[val] = true end
end

--- Check if trinket info matches any of the requested stats (unified stat matching)
--- @param info table The trinket info from TrinketTrackingManager
--- @param requested table Table of requested stat types (key=statType, value=true)
--- @return boolean True if trinket matches any requested stat
local function matchesRequestedStats(info, requested)
    if not requested or next(requested) == nil then return true end
    if not info then return false end
    local s1, s2, s3 = info.statType1, info.statType2, info.statType3
    -- Only check valid stat types (not -1 or nil)
    if s1 and s1 ~= -1 and requested[s1] then return true end
    if s2 and s2 ~= -1 and requested[s2] then return true end
    if s3 and s3 ~= -1 and requested[s3] then return true end
    return false
end

--- Unified stat matching function for all trinket functions
--- @param self NAG The NAG addon object
--- @param trinketId number The ID of the trinket to check
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @param minIcdSeconds? number Minimum internal cooldown required in seconds (optional)
--- @return boolean True if trinket matches any of the requested stat types
local function unifiedMatchesStatTypes(self, trinketId, statType1, statType2, statType3, minIcdSeconds)
    if not trinketId then return false end

    -- Normalize stat arguments
    local normalized1 = normalizeStatArg(statType1) or statType1
    local normalized2 = normalizeStatArg(statType2) or statType2
    local normalized3 = normalizeStatArg(statType3) or statType3

    -- Build requested stats table (use TablePool to avoid GC pressure in hot path)
    local requested = TablePool:Acquire("small")
    addRequestedStat(requested, normalized1)
    addRequestedStat(requested, normalized2)
    addRequestedStat(requested, normalized3)

    -- Get trinket info from TrinketTrackingManager first (needed for ICD check)
    local trinketInfo = TrinketTrackingManager:GetTrinketInfo(trinketId)
    if not trinketInfo then
        TablePool:Release("small", requested)
        return false
    end

    -- Check minimum ICD requirement if provided
    -- Tooltip: "filter out any procs that either lack an ICD or for which the ICD is smaller than the specified value"
    if minIcdSeconds and minIcdSeconds > 0 then
        if not trinketInfo.icd or trinketInfo.icd < minIcdSeconds then
            TablePool:Release("small", requested)
            return false -- Filter out trinkets with low or no ICD as per tooltip
        end
    end

    -- If no valid stats requested, match any trinket (after ICD filtering)
    if not next(requested) then
        TablePool:Release("small", requested)
        return true
    end

    -- Use unified stat matching
    local result = matchesRequestedStats(trinketInfo, requested)
    TablePool:Release("small", requested)
--    self:Trace(
--        "unifiedMatchesStatTypes: Trinket %d stat matching result=%s (requested stats: %s, trinket stats: %s,%s,%s)",
--        trinketId, tostring(result),
--        next(requested) and "has stats" or "no stats",
--        tostring(trinketInfo.statType1), tostring(trinketInfo.statType2), tostring(trinketInfo.statType3))
    return result
end

--- Get trinket data from StateManager (no caching needed)
--- @param self NAG The NAG addon object
--- @param statType1? any First stat type to check
--- @param statType2? any Second stat type to check
--- @param statType3? any Third stat type to check
--- @param minIcdSeconds? number Minimum ICD threshold in seconds (optional)
--- @return table Trinket data with matching results
local function getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)
    -- Get trinket data directly from StateManager
    local trinketData = StateManager:GetAllTrinketData()
    local matchingTrinkets = {}

    --self:Debug("getTrinketData: Getting trinket data from StateManager...")
    --self:Debug("getTrinketData: StateManager trinketData[13]=%s, trinketData[14]=%s",
    --trinketData[13] and "found" or "nil", trinketData[14] and "found" or "nil")

    for slot = 13, 14 do
        local data = trinketData[slot]
        if data and data.trinketInfo then
            --self:Debug("getTrinketData: Slot %d has item %d, trinketInfo=found", slot, data.itemId)
            --self:Debug("getTrinketData: Trinket %d stats: statType1=%s, statType2=%s, statType3=%s",
            --data.itemId, tostring(data.trinketInfo.statType1), tostring(data.trinketInfo.statType2), tostring(data.trinketInfo.statType3))

            -- Check if trinket matches the requested stat types
            local matches = unifiedMatchesStatTypes(self, data.itemId, statType1, statType2, statType3, minIcdSeconds)
            --self:Debug("getTrinketData: Trinket %d matches=%s (requested: %s,%s,%s)",
            --data.itemId, tostring(matches), tostring(statType1), tostring(statType2), tostring(statType3))

            if matches then
                matchingTrinkets[#matchingTrinkets + 1] = {
                    slot = slot,
                    itemId = data.itemId,
                    trinketInfo = data.trinketInfo
                }
            end
        end
    end

    --self:Debug("getTrinketData: Processed 2 slots, found %d matching trinkets", #matchingTrinkets)
    return matchingTrinkets
end

-- ============================ SPELL BLACKLIST ============================

--- @local
--- Checks if a spell is blacklisted for this character
--- Resolves the spellID to handle cases where APL uses old spellIDs but blacklist has current spellIDs
--- @param spellId number The spell ID to check (may be an old APL spellID)
--- @return boolean isBlacklisted True if the spell is blacklisted
function NAG:IsSpellBlacklisted(spellId)
    if not spellId then
        return false
    end

    local classModule = self:GetClassModule()
    if not classModule or not classModule.db or not classModule.db.char then
        return false
    end

    local blacklist = classModule.db.char.blacklistedSpells
    if not blacklist then
        return false
    end

    -- Check original spellID first (in case user blacklisted an old ID directly)
    if blacklist[spellId] == true then
        return true
    end

    -- Resolve to current spellID (handles APL old IDs -> current spellbook IDs)
    -- This is critical because users blacklist spells from their spellbook (current IDs)
    local resolvedSpellID = SpellbookManager:ResolveEffectiveSpellID(spellId)
    if resolvedSpellID and resolvedSpellID ~= spellId then
        if blacklist[resolvedSpellID] == true then
            return true
        end
    end

    -- If this spell is a flyout slot spell (e.g. Instant Poison), treat blacklisting the flyout
    -- (e.g. "Poison") as blacklisting this spell too, since the rotation uses the slot spell ID.
    if SpellbookManager and SpellbookManager.GetFlyoutIDForSpell then
        local flyoutID = SpellbookManager:GetFlyoutIDForSpell(spellId)
            or (resolvedSpellID and SpellbookManager:GetFlyoutIDForSpell(resolvedSpellID))
        if flyoutID and blacklist[flyoutID] == true then
            return true
        end
    end

    return false
end

--- @local
--- Returns true if the default battle potion is blocked (never suggested or shown).
--- Used because potions are items and do not appear in the spell blacklist dropdown.
--- @return boolean True when block default battle potion is enabled
function NAG:IsDefaultBattlePotionBlocked()
    local classModule = self:GetClassModule()
    if not classModule or not classModule.db or not classModule.db.char then
        return false
    end
    local autocastSettings = classModule.db.char.autocastSettings
    if not autocastSettings then
        return false
    end
    return autocastSettings.blockDefaultBattlePotion == true
end

--- @local
--- Returns true if id is the configured default battle potion and it is blocked.
--- @param id number Spell or item ID (default battle potion is stored as item ID)
--- @return boolean True when id is the default battle potion and block is enabled
function NAG:IsPotionBlocked(id)
    if not id or not self:IsDefaultBattlePotionBlocked() then
        return false
    end
    local potionId = self.GetBattlePotion and self:GetBattlePotion()
    if not potionId then
        return false
    end
    return id == potionId
end

--- @local
--- Adds a spell to the character blacklist
--- @param spellId number The spell ID to blacklist
--- @return boolean success True if successfully blacklisted
function NAG:BlacklistSpell(spellId)
    local classModule = self:GetClassModule()
    if not classModule or not classModule.db or not classModule.db.char then
        self:Error("Cannot blacklist spell: class module not available")
        return false
    end

    if not classModule.db.char.blacklistedSpells then
        classModule.db.char.blacklistedSpells = {}
    end

    classModule.db.char.blacklistedSpells[spellId] = true
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name or tostring(spellId)
    self:Info("Blacklisted spell: " .. spellName)
    return true
end

--- @local
--- Removes a spell from the character blacklist
--- @param spellId number The spell ID to unblacklist
--- @return boolean success True if successfully removed
function NAG:UnblacklistSpell(spellId)
    local classModule = self:GetClassModule()
    if not classModule or not classModule.db or not classModule.db.char then
        return false
    end

    if classModule.db.char.blacklistedSpells then
        classModule.db.char.blacklistedSpells[spellId] = nil
    end

    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name or tostring(spellId)
    self:Info("Unblacklisted spell: " .. spellName)
    return true
end

-- ============================ APL CASTING ACTIONS ============================
-- These functions map to the Go APL actions in apl_actions_casting.go

-- ============================ BASIC CASTING ============================

-- ============================ HOLD/WAIT HELPERS (RET TWISTING) ============================
-- NOTE: These helpers are placed in APLAction_Casting.lua (loaded early) so they are available
-- to both APL strings and later-loaded APLValues helpers without load-order issues.

-- ============================ SPELL ID RESOLUTION HELPERS (RANK-AWARE) ============================
-- Handlers that accept spell IDs from APLs (or schema/sequences) should resolve once at entry and
-- use the resolved ID for all checks and for nextSpell / AddSecondarySpell so icon and cooldown
-- match the spell the player actually has (e.g. Blood Fury 20572 vs 33697).

--- Resolves an APL spell ID (often lowest-rank) to the player's current effective spellbook ID.
--- This allows rotations to use stable/lowest-rank IDs while still matching active auras/dots/cooldowns
--- for the rank the player will actually cast.
--- @param spellId number
--- @return number resolvedSpellId
function NAG:ResolveEffectiveSpellId(spellId)
    if type(spellId) ~= "number" then
        return spellId
    end
    if SpellbookManager and SpellbookManager.ResolveEffectiveSpellID then
        return SpellbookManager:ResolveEffectiveSpellID(spellId) or spellId
    end
    return spellId
end

--- Backward-compatibility: IsTotemActive with any-rank pre-check (APLTotemTracking resolves at entry).
--- Other *Resolved aliases are defined in APL_Aliases.lua as direct references to the base functions.
--- @param spellId number
--- @return boolean
function NAG:IsTotemActiveResolved(spellId)
    if self.IsTotemActiveAnyRankForSpell then
        local anyRankResult = self:IsTotemActiveAnyRankForSpell(spellId)
        if anyRankResult ~= nil then
            return anyRankResult
        end
    end
    return self:IsTotemActive(spellId)
end

local RET_TWIST_SOC_IDS = PaladinTwistConstants.RET_TWIST_SOC_IDS or {}

local RET_TWIST_SOB_IDS = PaladinTwistConstants.RET_TWIST_SOB_IDS or {}

local RET_TWIST_SOR_IDS = PaladinTwistConstants.RET_TWIST_SOR_IDS or {}

-- Seal of the Crusader ranks (for self-apply Judgement of the Crusader feature)
-- Ordered by rank (lowest to highest) for best-rank selection
local RET_TWIST_SOCRUSADER_IDS = {
    20162, -- Seal of the Crusader (Rank 1)
    20305, -- Seal of the Crusader (Rank 2)
    20306, -- Seal of the Crusader (Rank 3)
    20307, -- Seal of the Crusader (Rank 4)
    20308, -- Seal of the Crusader (Rank 5)
    21082, -- Seal of the Crusader (Rank 6)
    27158, -- Seal of the Crusader (Rank 7, TBC max)
}

-- Judgement of the Crusader debuff IDs (applied to target)
-- All ranks apply the same core debuff effect
local JUDGEMENT_OF_CRUSADER_DEBUFF_IDS = {
    21183, -- Judgement of the Crusader (base)
    -- Additional ranks share the same debuff mechanic
}

--- @param spellIds number[]
--- @return boolean
local function retTwistHasAnyKnownSpellId(self, spellIds)
    for i = 1, #spellIds do
        if self:SpellIsKnown(spellIds[i]) then
            return true
        end
    end
    return false
end

--- Returns the Seal of Command spell ID to use for casting (highest known).
--- We keep the rank list for aura detection, but casting should prefer the best rank available.
--- @return number
function NAG:RetTwistGetSoCSealId()
    for i = #RET_TWIST_SOC_IDS, 1, -1 do
        local id = RET_TWIST_SOC_IDS[i]
        if id and self:SpellIsKnown(id) then
            return id
        end
    end
    -- Fallback to rank 1 (covers early-load / SpellIsKnown desync edge cases)
    return 20375
end

--- Returns true if *any* Seal of Command rank/variant is currently active.
--- This avoids false negatives when the player has a higher rank active (e.g. level 70 uses 27170).
--- @return boolean
function NAG:RetTwistIsSoCActive()
    for i = 1, #RET_TWIST_SOC_IDS do
        local id = RET_TWIST_SOC_IDS[i]
        if id and self:SpellIsKnown(id) and self:IsActive(id) then
            return true
        end
    end
    return false
end

--- Returns true if *any* Seal of Blood, Seal of the Martyr, or Seal of Righteousness is currently active.
--- Used for twist-state detection (the "twist seal" side of the rotation).
--- SoR is always accepted as a valid replacement: (1) leveling when SoB/SoM not learned;
--- (2) player choice (e.g. Prince boss where SoB self-damage would kill).
--- @return boolean
function NAG:RetTwistIsSoBActive()
    for i = 1, #RET_TWIST_SOB_IDS do
        local id = RET_TWIST_SOB_IDS[i]
        if id and self:SpellIsKnown(id) and self:IsActive(id) then
            return true
        end
    end

    -- SoR is a valid twist seal: leveling fallback OR player choice (e.g. Prince).
    for i = 1, #RET_TWIST_SOR_IDS do
        local id = RET_TWIST_SOR_IDS[i]
        if id and self:SpellIsKnown(id) and self:IsActive(id) then
            return true
        end
    end

    return false
end

-- ============================ SEAL OF THE CRUSADER (SELF-APPLY IMPSOC) ============================

--- Returns the highest known Seal of the Crusader spell ID for casting.
--- @return number
function NAG:RetTwistGetSoCrusaderSealId()
    for i = #RET_TWIST_SOCRUSADER_IDS, 1, -1 do
        local id = RET_TWIST_SOCRUSADER_IDS[i]
        if id and self:SpellIsKnown(id) then
            return id
        end
    end
    -- Fallback to Rank 1
    return 20162
end

--- Returns true if any Seal of the Crusader rank is currently active on the player.
--- @return boolean
function NAG:RetTwistIsSoCrusaderActive()
    for i = 1, #RET_TWIST_SOCRUSADER_IDS do
        local id = RET_TWIST_SOCRUSADER_IDS[i]
        if id and self:IsActive(id) then
            return true
        end
    end
    return false
end

--- Returns true if Judgement of the Crusader debuff is active on the target.
--- This checks for the debuff applied by judging Seal of the Crusader.
--- @return boolean
function NAG:RetTwistHasJudgementOfCrusaderDebuff()
    -- Check the primary debuff ID (21183 is the base Judgement of the Crusader)
    local debuff = self:UnitDebuff("target", 21183)
    if debuff then
        return true
    end
    return false
end

--- Returns true if the self-apply Judgement of the Crusader mode should be active.
--- Requires:
--- - setting enabled, AND
--- - if solo: explicit "force while solo" setting, OR
--- - if grouped: (≤2 paladins in group OR forced/assignment override).
--- @return boolean
function NAG:RetTwistShouldSelfApplyImpSoC()
    local module = ns.PaladinRetTwistModule
    if not module or not module.db then
        return false
    end
    if not module.db.class.selfApplyJudgementOfCrusader then
        return false
    end
    if not self:PlayerIsInGroup() then
        return module.db.class.selfApplyJudgementOfCrusaderSoloForced == true
    end
    -- Activate if forced (assignment override) OR ≤2 paladins in group
    if module.db.class.selfApplyJudgementOfCrusaderForced then
        return true
    end
    return self:GetPaladinCountInGroup() <= 2
end

--- Prints a "HOLD" indicator to chat (throttled) for rotations that want to explicitly
--- instruct the player to wait for a timing window (e.g., seal twisting gap).
--- Intended as a temporary debug/UX hook; can later be replaced by an overlay system.
--- @param message string|nil Optional message (default: "HOLD")
--- @param throttleSeconds number|nil Minimum seconds between prints (default: 1.0)
--- @return boolean Always returns true (so it can be used in `and` chains without blocking).
--- @usage (cond) and NAG:HoldForTwist() and NAG:Cast(20375) -- show HOLD + suggest Seal of Command
function NAG:HoldForTwist(message, throttleSeconds)
    local GetTime = _G.GetTime
    local now = GetTime and GetTime() or 0
    local minInterval = throttleSeconds or 1.0
    if minInterval < 0 then
        minInterval = 0
    end

    self._holdForTwistLastPrint = self._holdForTwistLastPrint or 0
    if (now - self._holdForTwistLastPrint) < minInterval then
        return true
    end
    self._holdForTwistLastPrint = now

    local text = message or "HOLD"
    if _G.DEFAULT_CHAT_FRAME and _G.DEFAULT_CHAT_FRAME.AddMessage then
        _G.DEFAULT_CHAT_FRAME:AddMessage(tostring(text))
    else
        print(tostring(text))
    end

    return true
end

--- Attempts to perform a Paladin seal twist by swapping to the "opposite" seal and marking it
--- with overlay text "TWIST".
---
--- Intended usage:
--- - During the twist window: if SoC is active, `Twist()` will recommend SoB/SoM with "TWIST".
--- - During pre-twist HOLD: `HoldForTwist()` + `Twist()` shows the upcoming twist press.
---
--- This helper is intentionally self-contained and additive (does not modify consolidated logic).
--- @return boolean True if a primary recommendation was set, false otherwise.
--- @usage (NAG:CanTwist(0.4) and NAG:IsActive(20375)) and NAG:Twist()
function NAG:Twist()
    local isSoC = self:RetTwistIsSoCActive()

    if isSoC then
        -- Twist from SoC -> twist seal (SoB/SoM, otherwise Seal of Justice while leveling).
        local twistSealId = self:RetTwistGetTwistSealId()
        return self:CastSpell(twistSealId, 3, ns.SPELL_POSITIONS.PRIMARY, nil, "TWIST")
    end

    -- Classic TBC note: the twist technique is one-way (SoC -> SoB/SoM) within the swing window.
    -- If SoC is not active, we do NOT attempt to "twist back" here; recovery/prep should be handled
    -- by normal APL clauses that maintain SoC outside the twist window.
    return false
end

--- Selects the "twist seal" to cast during a twist (SoB/SoM).
--- Prefers whichever the player actually knows.
--- Leveling fallback: if SoB/SoM are not known at all, falls back to Seal of Righteousness.
--- @return number twistSealId
function NAG:RetTwistGetTwistSealId()
    for i = 1, #RET_TWIST_SOB_IDS do
        local id = RET_TWIST_SOB_IDS[i]
        if id and self:SpellIsKnown(id) then
            return id
        end
    end

    -- Leveling fallback: if SoB/SoM are not learned yet, use Seal of Righteousness.
    for i = #RET_TWIST_SOR_IDS, 1, -1 do
        local id = RET_TWIST_SOR_IDS[i]
        if id and self:SpellIsKnown(id) then
            return id
        end
    end

    -- Fallback to SoR (covers early-load / SpellIsKnown desync edge cases)
    return RET_TWIST_SOR_IDS[#RET_TWIST_SOR_IDS] or 21084
end

local function formatRetTwistHoldOverlay(holdSeconds)
    if not holdSeconds or holdSeconds <= 0 then
        return "HOLD"
    end
    return string.format("HOLD\n%.1fs", holdSeconds)
end

local function formatRetTwistJudgeHoldOverlay(holdSeconds)
    if not holdSeconds or holdSeconds <= 0 then
        return "HOLD"
    end
    return string.format("HOLD\n%.1fs", holdSeconds)
end
local JUDGE_HOLD_LOG_VERSION = "jhfix_v2_2026-02-13"
local CUSTOM_HOLD_SWIPE_CALLER_LOG_VERSION = "1.0.0"

local function getDisplayManagerModule(self)
    if not self or not self.GetModule then
        return nil
    end
    return self:GetModule("DisplayManager", true)
end

local function registerCustomHoldSwipeFromAPL(self, spellId, position, holdSeconds, options, endAtOverride)
    if not spellId or not holdSeconds or holdSeconds <= 0 then
        return
    end
    local dm = getDisplayManagerModule(self)
    if not dm or not dm.RegisterCustomHoldSwipe then
        return
    end
    local now = (_G.GetTime and _G.GetTime()) or 0
    local endAt = endAtOverride
    if not endAt or endAt <= now then
        endAt = now + holdSeconds
    end
    dm:RegisterCustomHoldSwipe(spellId, position or ns.SPELL_POSITIONS.PRIMARY, endAt, options)
    if self.IsDevModeEnabled and self:IsDevModeEnabled() then
        -- print(string.format(
        --     "[CUSTOM_HOLD_SWIPE_CALL][ver=%s] action=register spell=%s pos=%s hold=%.3f endIn=%.3f",
        --     CUSTOM_HOLD_SWIPE_CALLER_LOG_VERSION,
        --     tostring(spellId),
        --     tostring(position or ns.SPELL_POSITIONS.PRIMARY),
        --     holdSeconds,
        --     math.max(0, endAt - now)
        -- ))
    end
end

local function clearCustomHoldSwipeFromAPL(self, spellId, position)
    if not spellId then
        return
    end
    local dm = getDisplayManagerModule(self)
    if not dm or not dm.ClearCustomHoldSwipe then
        return
    end
    dm:ClearCustomHoldSwipe(spellId, position or ns.SPELL_POSITIONS.PRIMARY)
    if self.IsDevModeEnabled and self:IsDevModeEnabled() then
        -- print(string.format(
        --     "[CUSTOM_HOLD_SWIPE_CALL][ver=%s] action=clear spell=%s pos=%s",
        --     CUSTOM_HOLD_SWIPE_CALLER_LOG_VERSION,
        --     tostring(spellId),
        --     tostring(position or ns.SPELL_POSITIONS.PRIMARY)
        -- ))
    end
end

local function clearRetTwistSoCHoldVisuals(self)
    local trackedIds = self and self._retTwistSoCHoldSwipeSpellIds or nil
    if trackedIds and type(trackedIds) == "table" then
        for id in pairs(trackedIds) do
            if id then
                clearCustomHoldSwipeFromAPL(self, id, ns.SPELL_POSITIONS.PRIMARY)
                clearCustomHoldSwipeFromAPL(self, id, ns.SPELL_POSITIONS.AOE)
                if self and self.castOverlayTexts then
                    self.castOverlayTexts[id] = nil
                end
            end
        end
        self._retTwistSoCHoldSwipeSpellIds = nil
    else
        local soCId = self and self.RetTwistGetSoCSealId and self:RetTwistGetSoCSealId() or nil
        if soCId then
            clearCustomHoldSwipeFromAPL(self, soCId, ns.SPELL_POSITIONS.PRIMARY)
            clearCustomHoldSwipeFromAPL(self, soCId, ns.SPELL_POSITIONS.AOE)
            if self and self.castOverlayTexts then
                self.castOverlayTexts[soCId] = nil
            end
            local resolvedSoCId = self.ResolveEffectiveSpellId and self:ResolveEffectiveSpellId(soCId) or soCId
            if resolvedSoCId and resolvedSoCId ~= soCId and self and self.castOverlayTexts then
                self.castOverlayTexts[resolvedSoCId] = nil
            end
        end
    end
    self._retTwistSoCHoldEndAt = nil
end

--- Clears SoC setup HOLD visuals/state.
--- Safe no-op when no SoC HOLD state exists.
--- @return boolean
function NAG:RetTwistClearSoCHoldVisuals()
    clearRetTwistSoCHoldVisuals(self)
    return true
end

local function getRetTwistSoCHoldPlannedEndAt(self, holdSeconds)
    local now = (_G.GetTime and _G.GetTime()) or 0
    local plannedEndAt = self._retTwistSoCHoldEndAt or 0
    local desiredEndAt = now + (holdSeconds or 0)
    local remaining = (plannedEndAt > now) and (plannedEndAt - now) or 0
    local significantChange = math.abs(desiredEndAt - plannedEndAt) > 0.20
    local meaningfulExtension = desiredEndAt > (plannedEndAt + 0.20)
    local meaningfulReduction = desiredEndAt < (plannedEndAt - 0.20)
    if plannedEndAt <= now then
        plannedEndAt = desiredEndAt
    elseif significantChange and (meaningfulExtension or meaningfulReduction) then
        -- Allow both extensions (normal) and reductions (e.g. parry haste) to retarget the swipe.
        plannedEndAt = desiredEndAt
    end
    self._retTwistSoCHoldEndAt = plannedEndAt
    return plannedEndAt
end

--- Register SoC HOLD swipe across all likely render keys.
--- Some moments can render SoC on AOE or with a resolved spellbook ID.
--- Registering both IDs and both slots prevents "text visible, swipe missing" mismatches.
--- @param self table
--- @param soCId number
--- @param holdSeconds number
--- @param plannedEndAt number
local function registerRetTwistSoCHoldSwipe(self, soCId, holdSeconds, plannedEndAt)
    if not soCId or not holdSeconds or holdSeconds <= 0 then
        return
    end

    local ids = { soCId }
    local resolvedSoCId = self.ResolveEffectiveSpellId and self:ResolveEffectiveSpellId(soCId) or soCId
    if resolvedSoCId and resolvedSoCId ~= soCId then
        ids[#ids + 1] = resolvedSoCId
    end

    local tracked = {}
    for i = 1, #ids do
        local id = ids[i]
        if id and (not tracked[id]) then
            tracked[id] = true
            registerCustomHoldSwipeFromAPL(self, id, ns.SPELL_POSITIONS.PRIMARY, holdSeconds, {
                alpha = 0.5,
                reverse = false,
                coverAOE = true,
                maxDuration = 1.5,
            }, plannedEndAt)
            registerCustomHoldSwipeFromAPL(self, id, ns.SPELL_POSITIONS.AOE, holdSeconds, {
                alpha = 0.5,
                reverse = false,
                coverAOE = true,
                maxDuration = 1.5,
            }, plannedEndAt)
        end
    end

    self._retTwistSoCHoldSwipeSpellIds = tracked
end

-- ============================ PROT SEAL TWISTING (SoC <-> SoR) ============================
-- Protection Paladin can use the same timing helpers as Ret twisting (CanTwist / hold region),
-- but Prot wants a deterministic twist seal: Seal of Righteousness (SoR).

--- Returns the Seal of Righteousness spell ID to use for casting (highest known).
--- @return number
function NAG:ProtTwistGetSoRSealId()
    for i = #RET_TWIST_SOR_IDS, 1, -1 do
        local id = RET_TWIST_SOR_IDS[i]
        if id and self:SpellIsKnown(id) then
            return id
        end
    end
    -- Fallback to a canonical SoR id (covers early-load / SpellIsKnown desync edge cases)
    return 21084
end

--- Returns true if any Seal of Righteousness rank/variant is currently active.
--- @return boolean
function NAG:ProtTwistIsSoRActive()
    for i = 1, #RET_TWIST_SOR_IDS do
        local id = RET_TWIST_SOR_IDS[i]
        if id and self:SpellIsKnown(id) and self:IsActive(id) then
            return true
        end
    end
    return false
end

--- NOW helper for Prot twisting: twist from SoC -> SoR (overlay "NOW").
--- Uses tolerance so the recommendation can display even if GCD is still ticking.
--- @return boolean
function NAG:ProtTwistNow()
    if not self:RetTwistIsSoCActive() then
        return false
    end
    local sorId = self:ProtTwistGetSoRSealId()
    return self:CastSpell(sorId, 3, ns.SPELL_POSITIONS.PRIMARY, nil, "NOW")
end

--- Cast Seal of Righteousness with a custom overlay text (Prot twist UX helper).
--- Useful for special UX cases (e.g. startattack macro reminders) without changing normal "NOW" behavior.
--- @param overlayText string
--- @return boolean
function NAG:ProtTwistNowWithOverlay(overlayText)
    if not self:RetTwistIsSoCActive() then
        return false
    end
    if not overlayText or overlayText == "" then
        return false
    end
    local sorId = self:ProtTwistGetSoRSealId()
    return self:CastSpell(sorId, 3, ns.SPELL_POSITIONS.PRIMARY, nil, overlayText)
end

--- HOLD helper for Prot twisting: show SoR with overlay "HOLD" during the div boundary.
--- Uses tolerance so the HOLD recommendation can display during GCD (we are "holding", not casting immediately).
--- @return boolean
function NAG:ProtTwistHold()
    if not self:RetTwistIsSoCActive() then
        return false
    end
    local sorId = self:ProtTwistGetSoRSealId()
    local holdSeconds = nil
    if self.RetTwistTimeToTwistWindow then
        holdSeconds = self:RetTwistTimeToTwistWindow(0.4)
    end
    local overlayText = formatRetTwistHoldOverlay(holdSeconds)
    return self:CastSpell(sorId, 3, ns.SPELL_POSITIONS.PRIMARY, nil, overlayText)
end

--- HOLD helper for Ret twisting: show the twist seal with overlay "HOLD".
--- This is intended to be used in the WA-style "div boundary" region where we want to avoid spending a GCD.
--- @return boolean
function NAG:RetTwistHold()
    if not self:RetTwistIsSoCActive() then
        return false
    end
    local twistSealId = self:RetTwistGetTwistSealId()
    local holdSeconds = nil
    if self.RetTwistTimeToTwistWindow then
        holdSeconds = self:RetTwistTimeToTwistWindow(0.4)
    end
    local overlayText = formatRetTwistHoldOverlay(holdSeconds)
    -- Use tolerance so the HOLD recommendation can display during GCD (we are "holding", not casting immediately).
    return self:CastSpell(twistSealId, 3, ns.SPELL_POSITIONS.PRIMARY, nil, overlayText)
end

--- HOLD helper for SoB -> SoC transitions in sensitive swing regions.
--- When we are post-div or already inside twist gap, show SoC with HOLD until current swing is sent.
--- This avoids spending the swap too late in the same swing.
--- @param windowSeconds number|nil Default 0.4
--- @return boolean
function NAG:RetTwistHoldSoBToSoCTransition(windowSeconds)
    local window = windowSeconds or 0.4
    if window < 0 then
        window = 0
    end

    if self:RetTwistIsSoCActive() then
        clearRetTwistSoCHoldVisuals(self)
        return false
    end
    if not self:RetTwistIsSoBActive() then
        clearRetTwistSoCHoldVisuals(self)
        return false
    end

    local category = self:RetTwistGetSwingTimingCategory(window)
    if category ~= "after_div_before_gap" and category ~= "in_twist" then
        clearRetTwistSoCHoldVisuals(self)
        return false
    end

    local _, rawSwingNow = self:AutoTimeToNext()
    rawSwingNow = rawSwingNow or 0
    if rawSwingNow <= 0 then
        clearRetTwistSoCHoldVisuals(self)
        return false
    end

    local holdSeconds = rawSwingNow
    if holdSeconds < 0.05 then
        holdSeconds = 0.05
    end

    local soCId = self:RetTwistGetSoCSealId()
    local plannedEndAt = getRetTwistSoCHoldPlannedEndAt(self, holdSeconds)
    registerRetTwistSoCHoldSwipe(self, soCId, holdSeconds, plannedEndAt)
    local overlayText = formatRetTwistHoldOverlay(holdSeconds)
    return self:CastSpell(soCId, holdSeconds, ns.SPELL_POSITIONS.PRIMARY, nil, overlayText)
end

--- HOLD helper for generic SoC setup when current swing pre-div is missed.
--- Shows SoC with HOLD and a next-swing countdown.
--- @param windowSeconds number|nil Default 0.4
--- @return boolean
function NAG:RetTwistSoCSetupHold(windowSeconds)
    local window = windowSeconds or 0.4
    if window < 0 then
        window = 0
    end

    if self:RetTwistIsSoCActive() then
        clearRetTwistSoCHoldVisuals(self)
        return false
    end
    -- Only skip hold when we can actually setup in current swing. When we've passed current
    -- (e.g. on GCD, blockCurrent), we need the hold for next swing - show SoC immediately.
    if self:RetTwistShouldSetupSoCInCurrentPreDiv(window) then
        local blockCurrent = self:RetTwistShouldBlockSoCSetupForCS(window, "current_pre_div")
        if not blockCurrent then
            clearRetTwistSoCHoldVisuals(self)
            return false
        end
    end

    local holdSeconds = self:RetTwistSoCSetupHoldSeconds(window) or 0
    if holdSeconds <= 0 then
        clearRetTwistSoCHoldVisuals(self)
        return false
    end

    local soCId = self:RetTwistGetSoCSealId()
    local plannedEndAt = getRetTwistSoCHoldPlannedEndAt(self, holdSeconds)
    registerRetTwistSoCHoldSwipe(self, soCId, holdSeconds, plannedEndAt)
    local overlayText = formatRetTwistHoldOverlay(holdSeconds)
    return self:CastSpell(soCId, holdSeconds, ns.SPELL_POSITIONS.PRIMARY, nil, overlayText)
end

local function clearRetTwistJudgeHoldVisuals(self)
    clearCustomHoldSwipeFromAPL(self, 20271, ns.SPELL_POSITIONS.PRIMARY)
    if self.castOverlayTexts then
        self.castOverlayTexts[20271] = nil
    end
end

--- HOLD helper for Ret Judge -> SoC setup timing.
--- Shows Judgement on PRIMARY with HOLD text and a tolerance-based wait window.
--- @param holdSeconds number Required hold duration in seconds.
--- @return boolean
function NAG:RetTwistJudgeHold(holdSeconds)
    if holdSeconds == -1 then
        -- Immediate Judge+SoC display path: no HOLD overlay, no wait tolerance.
        clearRetTwistJudgeHoldVisuals(self)
        return self:CastSpell(20271, 0, ns.SPELL_POSITIONS.PRIMARY)
    end
    if not holdSeconds or holdSeconds <= 0 then
        clearRetTwistJudgeHoldVisuals(self)
        return false
    end
    local now = (_G.GetTime and _G.GetTime()) or 0
    -- Hold phase timing is now owned by the gate transition (phase_start/phase_end).
    -- Do not re-arm from repeated cast ticks.
    local currentEndAt = self._retTwistJudgeHoldEndAt or 0

    self._retTwistJudgeHoldSeconds = holdSeconds
    self._retTwistJudgeHoldIssuedAt = now
    if false and self:IsDevModeEnabled() then
        print(string.format(
            "[JUDGE_HOLD_CAST][ver=%s] hold=%.3f remaining=%.3f endAt=%.3f token=%d",
            JUDGE_HOLD_LOG_VERSION,
            holdSeconds,
            (self._retTwistJudgeHoldEndAt and math.max(0, self._retTwistJudgeHoldEndAt - now)) or 0,
            self._retTwistJudgeHoldEndAt or 0,
            self._retTwistJudgeHoldToken or 0
        ))
    end
    local plannedEndAt = currentEndAt
    local currentRemaining = (currentEndAt > now) and (currentEndAt - now) or 0
    local desiredEndAt = now + holdSeconds
    local shouldRefreshPlannedEndAt = (plannedEndAt <= now)
        -- Significant extension (normal behavior)
        or (desiredEndAt > (plannedEndAt + 0.20))
        -- Significant reduction (e.g. parry haste) - must retarget earlier
        or (desiredEndAt < (plannedEndAt - 0.20))
    if shouldRefreshPlannedEndAt then
        plannedEndAt = desiredEndAt
    end
    -- Keep a stable absolute target in backup/non-phase paths so custom swipe does not
    -- get re-registered with tiny endAt drift every frame.
    self._retTwistJudgeHoldEndAt = plannedEndAt
    registerCustomHoldSwipeFromAPL(self, 20271, ns.SPELL_POSITIONS.PRIMARY, holdSeconds, {
        alpha = 0.5,
        reverse = false,
        coverAOE = true,
    }, plannedEndAt)
    local overlayText = formatRetTwistJudgeHoldOverlay(holdSeconds)
    return self:CastSpell(20271, holdSeconds, ns.SPELL_POSITIONS.PRIMARY, nil, overlayText)
end

--- Shared gate for displaying the Judge+SoC split recommendation.
--- Computes the effective hold seconds once per call and stores it for downstream consumers.
--- @param maxToleranceSeconds number|nil
--- @param twistWindowSeconds number|nil
--- @param hysteresisSeconds number|nil
--- @param safetySeconds number|nil
--- @param fillerBufferSeconds number|nil
--- @return boolean
function NAG:RetTwistJudgeSetupCanDisplay(maxToleranceSeconds, twistWindowSeconds, hysteresisSeconds, safetySeconds, fillerBufferSeconds)
    local now = (_G.GetTime and _G.GetTime()) or 0
    local judgeHoldDebug = false -- Temporarily muted: keep only RET_FILLER_GATE output.
    local keepFallbackHoldVisuals = (self._retTwistJudgeHoldSeconds and self._retTwistJudgeHoldSeconds > 0)
        or (self.castOverlayTexts and type(self.castOverlayTexts[20271]) == "string"
            and string.find(self.castOverlayTexts[20271], "HOLD", 1, true) ~= nil)
    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then
        gcdLeft = 0
    end
    local prevGcdLeft = self._retTwistJudgeSetupSnapshotLastGcdLeft or 0
    local gcdSnapshot = self._retTwistJudgeSetupGcdSnapshot
    local snapshotGcdEndAt = (gcdSnapshot and gcdSnapshot.gcdEndAt) or 0
    local inSameGcdBySnapshot = (snapshotGcdEndAt > 0) and (now <= (snapshotGcdEndAt + 0.05))
    local startedNewGcd = (gcdLeft > (prevGcdLeft + 0.05)) and (not inSameGcdBySnapshot)
    self._retTwistJudgeSetupSnapshotLastGcdLeft = gcdLeft
    if gcdLeft <= 0 and (not inSameGcdBySnapshot) then
        self._retTwistJudgeSetupGcdSnapshot = nil
    end

    -- Option A: Snapshot on GCD transition. When we just entered GCD (no snapshot yet) but had
    -- canDisplay=true in the previous frame when GCD was ready, create snapshot from that state
    -- so Judge+SoC displays during GCD instead of only after it ends.
    if gcdLeft > 0 and (not gcdSnapshot or not gcdSnapshot.canDisplay) then
        local lastHold = self._retTwistJudgeSetupLastDisplayableHoldState
        local transitionGraceSeconds = 0.15
        local hasValidHold = lastHold and lastHold.at and (now - lastHold.at) < transitionGraceSeconds
            and lastHold.holdSeconds and (lastHold.holdSeconds > 0 or lastHold.holdSeconds == -1)
        if hasValidHold then
            local holdEndAt = (lastHold.holdSeconds > 0) and (lastHold.holdEndAt or (lastHold.at + lastHold.holdSeconds)) or nil
            self._retTwistJudgeSetupGcdSnapshot = {
                maxToleranceSeconds = maxToleranceSeconds,
                twistWindowSeconds = twistWindowSeconds,
                hysteresisSeconds = hysteresisSeconds,
                safetySeconds = safetySeconds,
                fillerBufferSeconds = fillerBufferSeconds,
                holdSeconds = lastHold.holdSeconds,
                holdEndAt = holdEndAt,
                gcdEndAt = now + gcdLeft,
                canDisplay = true
            }
            if lastHold.holdSeconds > 0 and holdEndAt then
                self._retTwistJudgeHoldSeconds = (holdEndAt > now) and (holdEndAt - now) or 0.05
                self._retTwistJudgeHoldEndAt = holdEndAt
            else
                self._retTwistJudgeHoldSeconds = lastHold.holdSeconds
                self._retTwistJudgeHoldEndAt = nil
            end
            return true
        end
    end

    if gcdLeft > 0 and gcdSnapshot and gcdSnapshot.canDisplay
        and (not startedNewGcd)
        and gcdSnapshot.maxToleranceSeconds == maxToleranceSeconds
        and gcdSnapshot.twistWindowSeconds == twistWindowSeconds
        and gcdSnapshot.hysteresisSeconds == hysteresisSeconds
        and gcdSnapshot.safetySeconds == safetySeconds
        and gcdSnapshot.fillerBufferSeconds == fillerBufferSeconds then
        local snapHold = gcdSnapshot.holdSeconds or 0
        -- Guard against stale "immediate Judge+SoC" snapshots:
        -- if the snapshot says hold=-1 but fresh hold math is no longer immediate,
        -- do not short-circuit here; recompute planned/tolerance this frame.
        if snapHold == -1 then
            local freshHold = self:RetTwistJudgeSetupWaitTolerance(
                maxToleranceSeconds,
                twistWindowSeconds,
                hysteresisSeconds,
                safetySeconds,
                fillerBufferSeconds
            ) or 0
            if freshHold ~= -1 then
                if judgeHoldDebug and self:IsDevModeEnabled() then
                    print(string.format(
                        "[JUDGE_HOLD_GATE][ver=%s] gcd_snapshot_drop reason=stale_immediate freshHold=%.3f gcdLeft=%.3f",
                        JUDGE_HOLD_LOG_VERSION,
                        freshHold or 0,
                        gcdLeft or 0
                    ))
                end
                self._retTwistJudgeSetupGcdSnapshot = nil
            end
        end
        if self._retTwistJudgeSetupGcdSnapshot == nil then
            if judgeHoldDebug and self:IsDevModeEnabled() then
                print(string.format(
                    "[JUDGE_HOLD_GATE][ver=%s] gcd_snapshot_drop reason=snapshot_invalidated_recompute gcdLeft=%.3f",
                    JUDGE_HOLD_LOG_VERSION,
                    gcdLeft or 0
                ))
            end
        else
        -- Snapshot reuse: preserve the positive decision for the duration of the same GCD,
        -- but DO NOT freeze the HOLD countdown. Use the stored absolute endAt to recompute
        -- remaining hold seconds smoothly each frame.
            if snapHold and snapHold > 0 then
                local snapEndAt = gcdSnapshot.holdEndAt or self._retTwistJudgeHoldEndAt or (now + snapHold)
                if snapEndAt <= now then
                    self._retTwistJudgeHoldSeconds = 0.05
                else
                    self._retTwistJudgeHoldSeconds = snapEndAt - now
                end
                self._retTwistJudgeHoldEndAt = snapEndAt
            else
                self._retTwistJudgeHoldSeconds = snapHold
            end
            if judgeHoldDebug and self:IsDevModeEnabled() then
                print(string.format(
                    "[JUDGE_HOLD_GATE][ver=%s] gcd_snapshot_reuse canDisplay=true hold=%.3f gcdLeft=%.3f",
                    JUDGE_HOLD_LOG_VERSION,
                    self._retTwistJudgeHoldSeconds or 0,
                    gcdLeft or 0
                ))
            end
            return true
        end
    end
    local cache = self._retTwistJudgeSetupGateCache
    if cache and (now - (cache.at or 0)) <= 0.001
        and cache.maxToleranceSeconds == maxToleranceSeconds
        and cache.twistWindowSeconds == twistWindowSeconds
        and cache.hysteresisSeconds == hysteresisSeconds
        and cache.safetySeconds == safetySeconds
        and cache.fillerBufferSeconds == fillerBufferSeconds then
        local cachedHold = cache.holdSeconds or 0
        local cachedCanDisplay = cache.canDisplay == true
        local cachedImmediate = cachedHold == -1
        self._retTwistJudgeHoldSeconds = cachedHold

        -- Guard against stale phase timing: HOLD text can still be valid while phase endAt/token
        -- are stale, which would hide the swipe overlay. Recompute in that case.
        if cachedCanDisplay and (not cachedImmediate) and cachedHold > 0 then
            local currentEndAt = self._retTwistJudgeHoldEndAt or 0
            local currentRemaining = (currentEndAt > now) and (currentEndAt - now) or 0
            if self._retTwistJudgeHoldPhaseActive and currentRemaining > 0.05 then
                return true
            end
            if judgeHoldDebug and self:IsDevModeEnabled() then
                print(string.format(
                    "[JUDGE_HOLD_PHASE][ver=%s] phase_rearm reason=cache_stale hold=%.3f remaining=%.3f",
                    JUDGE_HOLD_LOG_VERSION,
                    cachedHold,
                    currentRemaining
                ))
            end
        else
            if not cachedCanDisplay then
                -- Only clear when this gate owns the active Judge HOLD phase.
                -- Backup paths (e.g. end-of-rotation hold for next swing) may still want the swipe.
                if self._retTwistJudgeHoldPhaseActive and (not keepFallbackHoldVisuals) then
                    clearRetTwistJudgeHoldVisuals(self)
                end
            end
            return cachedCanDisplay
        end
    end

    local planned = self:RetTwistJudgeSetupIsPlanned(maxToleranceSeconds, twistWindowSeconds, hysteresisSeconds, safetySeconds)
    if not planned then
        if judgeHoldDebug and self:IsDevModeEnabled() and self._retTwistJudgeHoldPhaseActive then
            print(string.format("[JUDGE_HOLD_PHASE][ver=%s] phase_end reason=not_planned", JUDGE_HOLD_LOG_VERSION))
        end
        if self._retTwistJudgeHoldPhaseActive and (not keepFallbackHoldVisuals) then
            clearRetTwistJudgeHoldVisuals(self)
        end
        self._retTwistJudgeHoldPhaseActive = false
        self._retTwistJudgeHoldSeconds = 0
        self._retTwistJudgeHoldEndAt = nil
        self._retTwistJudgeSetupLastDisplayableHoldState = nil
        self._retTwistJudgeSetupGateCache = {
            at = now,
            maxToleranceSeconds = maxToleranceSeconds,
            twistWindowSeconds = twistWindowSeconds,
            hysteresisSeconds = hysteresisSeconds,
            safetySeconds = safetySeconds,
            fillerBufferSeconds = fillerBufferSeconds,
            holdSeconds = 0,
            canDisplay = false
        }
        if judgeHoldDebug and self:IsDevModeEnabled() then
            print(string.format("[JUDGE_HOLD_GATE][ver=%s] planned=false canDisplay=false", JUDGE_HOLD_LOG_VERSION))
        end
        return false
    end

    local holdSeconds = self:RetTwistJudgeSetupWaitTolerance(
        maxToleranceSeconds,
        twistWindowSeconds,
        hysteresisSeconds,
        safetySeconds,
        fillerBufferSeconds
    ) or 0

    self._retTwistJudgeHoldSeconds = holdSeconds
    local isImmediateDisplay = holdSeconds == -1
    local isHoldDisplay = holdSeconds and holdSeconds > 0
    local castTolerance = isImmediateDisplay and 0 or holdSeconds
    -- Critical: hold=0 means "do not show Judge+SoC setup path" (filler allowed).
    -- Do not treat hold=0 as displayable just because Judge is currently castable.
    local canDisplay = false
    if isImmediateDisplay then
        canDisplay = self:SpellCanCast(20271, 0)
    elseif isHoldDisplay then
        canDisplay = self:SpellCanCast(20271, castTolerance)
    end
    if not canDisplay then
        -- Diagnostic: log when Judge+SoC blocked during GCD (to investigate display timing)
        if gcdLeft > 0 and self.IsDevModeEnabled and self:IsDevModeEnabled() then
            local blockReason = (holdSeconds == 0) and "hold_tol_returned_0" or "spell_can_cast_failed"
            print(string.format(
                "[JUDGE_HOLD_GATE][ver=%s] canDisplay=false gcdLeft=%.3f holdSeconds=%s reason=%s",
                JUDGE_HOLD_LOG_VERSION,
                gcdLeft or 0,
                tostring(holdSeconds),
                blockReason
            ))
        end
        if judgeHoldDebug and self:IsDevModeEnabled() and self._retTwistJudgeHoldPhaseActive then
            print(string.format("[JUDGE_HOLD_PHASE][ver=%s] phase_end reason=not_displayable", JUDGE_HOLD_LOG_VERSION))
        end
        if self._retTwistJudgeHoldPhaseActive and (not keepFallbackHoldVisuals) then
            clearRetTwistJudgeHoldVisuals(self)
        end
        self._retTwistJudgeHoldPhaseActive = false
        self._retTwistJudgeHoldEndAt = nil
    else
        if isImmediateDisplay then
            if judgeHoldDebug and self:IsDevModeEnabled() and self._retTwistJudgeHoldPhaseActive then
                print(string.format("[JUDGE_HOLD_PHASE][ver=%s] phase_end reason=immediate_display", JUDGE_HOLD_LOG_VERSION))
            end
            clearRetTwistJudgeHoldVisuals(self)
            self._retTwistJudgeHoldPhaseActive = false
            self._retTwistJudgeHoldEndAt = nil
            self._retTwistJudgeHoldToken = nil
        else
            local currentEndAt = self._retTwistJudgeHoldEndAt or 0
            local currentRemaining = (currentEndAt > now) and (currentEndAt - now) or 0
            local shouldStartOrRefresh = (not self._retTwistJudgeHoldPhaseActive)
                or (currentRemaining <= 0.05)
                or (holdSeconds > (currentRemaining + 0.20))

            if shouldStartOrRefresh then
                self._retTwistJudgeHoldPhaseActive = true
                self._retTwistJudgeHoldEndAt = now + holdSeconds
                self._retTwistJudgeHoldToken = (self._retTwistJudgeHoldToken or 0) + 1
                if judgeHoldDebug and self:IsDevModeEnabled() then
                    local reason = "phase_start"
                    if currentRemaining <= 0.05 then
                        reason = "phase_refresh_expired"
                    elseif holdSeconds > (currentRemaining + 0.20) then
                        reason = "phase_refresh_extended"
                    end
                    print(string.format(
                        "[JUDGE_HOLD_PHASE][ver=%s] %s hold=%.3f endAt=%.3f token=%d",
                        JUDGE_HOLD_LOG_VERSION,
                        reason,
                        holdSeconds,
                        self._retTwistJudgeHoldEndAt,
                        self._retTwistJudgeHoldToken
                    ))
                end
            end
        end
    end
    if judgeHoldDebug and self:IsDevModeEnabled() then
        print(string.format(
        "[JUDGE_HOLD_GATE][ver=%s] planned=true hold=%.3f immediate=%s canDisplay=%s",
        JUDGE_HOLD_LOG_VERSION,
        holdSeconds,
        tostring(isImmediateDisplay),
        tostring(canDisplay)
    ))
    end
    self._retTwistJudgeSetupGateCache = {
        at = now,
        maxToleranceSeconds = maxToleranceSeconds,
        twistWindowSeconds = twistWindowSeconds,
        hysteresisSeconds = hysteresisSeconds,
        safetySeconds = safetySeconds,
        fillerBufferSeconds = fillerBufferSeconds,
        holdSeconds = holdSeconds,
        canDisplay = canDisplay == true
    }
    if canDisplay then
        self._retTwistJudgeSetupLastDisplayableAt = now
        -- Persist hold state for Option A (snapshot on GCD transition)
        self._retTwistJudgeSetupLastDisplayableHoldState = {
            holdSeconds = holdSeconds,
            holdEndAt = (holdSeconds and holdSeconds > 0) and (self._retTwistJudgeHoldEndAt or (now + holdSeconds)) or nil,
            at = now
        }
        if gcdLeft > 0 then
            self._retTwistJudgeSetupGcdSnapshot = {
                maxToleranceSeconds = maxToleranceSeconds,
                twistWindowSeconds = twistWindowSeconds,
                hysteresisSeconds = hysteresisSeconds,
                safetySeconds = safetySeconds,
                fillerBufferSeconds = fillerBufferSeconds,
                holdSeconds = holdSeconds,
                holdEndAt = (holdSeconds and holdSeconds > 0) and (self._retTwistJudgeHoldEndAt or (now + holdSeconds)) or nil,
                gcdEndAt = now + gcdLeft,
                canDisplay = true
            }
        end
    end
    return canDisplay
end

--- Returns true if Judge+SoC setup was displayable recently.
--- Used to avoid one-tick fallback jumps into plain SoC after a valid Judge setup signal.
--- @param graceSeconds number|nil Default 0.15
--- @return boolean
function NAG:RetTwistJudgeSetupRecentlyDisplayable(graceSeconds)
    local lastAt = self._retTwistJudgeSetupLastDisplayableAt
    if not lastAt then
        return false
    end
    local now = (_G.GetTime and _G.GetTime()) or 0
    local grace = graceSeconds or 0.15
    if grace < 0 then
        grace = 0
    end
    return (now - lastAt) <= grace
end


--- @return boolean
function NAG:RetTwistHoldBURST()
    if not self:RetTwistIsSoCActive() then
        return false
    end
    local twistSealId = self:RetTwistGetTwistSealId()
    return self:IsReady(31884)
        and not(self:CastSpell(31884, 3, ns.SPELL_POSITIONS.AOE, nil, "Burst and\nTwist"))
        and self:CastSpell(twistSealId, 3, ns.SPELL_POSITIONS.PRIMARY)
end

--- @return boolean
function NAG:RetTwistNowBURST()
    if not self:RetTwistIsSoCActive() then
        return false
    end
    local twistSealId = self:RetTwistGetTwistSealId()
    -- Use tolerance so the "NOW" recommendation can display even if GCD is still ticking.
    return self:IsReady(31884)
        and not(self:CastSpell(31884, 3, ns.SPELL_POSITIONS.AOE, nil, "Burst and\nTwist"))
        and self:CastSpell(twistSealId, 0, ns.SPELL_POSITIONS.PRIMARY)
end


--- Cast the twist seal (SoB/SoM) with a custom overlay text.
--- Useful for special UX cases (e.g. out-of-combat startattack macros) without changing normal "NOW" behavior.
--- @param overlayText string
--- @return boolean
function NAG:RetTwistNowWithOverlay(overlayText)
    if not self:RetTwistIsSoCActive() then
        return false
    end
    if not overlayText or overlayText == "" then
        return false
    end
    local twistSealId = self:RetTwistGetTwistSealId()
    -- Use tolerance so the "NOW" recommendation can display even if GCD is still ticking,
    -- since CanTwist logic is evaluated at GCD end.
    return self:CastSpell(twistSealId, 3, ns.SPELL_POSITIONS.PRIMARY, nil, overlayText)
end

--- NOW helper for Ret twisting: show the twist seal with overlay "NOW".
--- This is intended to be used inside the actual twist window (last ~0.4s before swing).
--- @return boolean
function NAG:RetTwistNow()
    if not self:RetTwistIsSoCActive() then
        return false
    end
    local twistSealId = self:RetTwistGetTwistSealId()
    -- Use tolerance so the "NOW" recommendation can display even if GCD is still ticking.
    return self:CastSpell(twistSealId, 3, ns.SPELL_POSITIONS.PRIMARY, nil, "NOW")
end

-- ============================ HOLD/WAIT HELPERS (WARRIOR SLAM WEAVING) ============================
-- These helpers are placed here (loaded early) so APL strings can call them safely.


-- Slam ranks (Classic/TBC). We select the highest known at runtime.
local WARRIOR_SLAM_IDS = {
    25241, -- Slam (Rank 6, TBC)
    11605, -- Slam (Rank 5)
    11604, -- Slam (Rank 4)
    8820,  -- Slam (Rank 3)
    1464,  -- Slam (Rank 1)
}

local function isSlamSpellId(spellId)
    if not spellId then
        return false
    end
    for i = 1, #WARRIOR_SLAM_IDS do
        if spellId == WARRIOR_SLAM_IDS[i] then
            return true
        end
    end
    return false
end

local function getRageCostForSpell(spellId)
    if not spellId or type(spellId) ~= "number" then
        return 0
    end
    local costTable = NAG:GetModifiedSpellPowerCost(spellId)
    if type(costTable) ~= "table" then
        return 0
    end
    for _, v in ipairs(costTable) do
        if v.type == Enum.PowerType.Rage then
            local required = v.minCost or v.cost or 0
            return math.max(required, 0)
        end
    end
    return 0
end

--- Returns the Slam spell ID to use for weaving (highest known).
--- @return number
function NAG:WarriorSlamWeaveGetSlamId()
    for i = 1, #WARRIOR_SLAM_IDS do
        local id = WARRIOR_SLAM_IDS[i]
        if id and self:SpellIsKnown(id) then
            return id
        end
    end
    -- Fallback to max rank (covers early-load / SpellIsKnown desync edge cases)
    return 25241
end

--- Check rage after Slam will be paid while Slam is casting.
--- Falls back to HasRage when Slam is not casting.
--- @param spellId number
--- @return boolean
function NAG:WarriorSlamWeaveHasRageAfterSlam(spellId)
    if not spellId or type(spellId) ~= "number" then
        return false
    end

    local castingSpellId = nil
    if UnitCastingInfo then
        local _, _, _, _, _, _, _, _, castSpellId = UnitCastingInfo("player")
        castingSpellId = castSpellId
    end
    if not isSlamSpellId(castingSpellId) then
        return self:HasRage(spellId)
    end

    local cost = getRageCostForSpell(spellId)
    local slamId = self:WarriorSlamWeaveGetSlamId()
    local slamCost = getRageCostForSpell(slamId)
    local currentRage = self:CurrentRage()
    local projectedRage = (currentRage or 0) - slamCost
    if projectedRage < 0 then
        projectedRage = 0
    end
    return cost <= projectedRage
end

--- Slam weave helper: show Slam with a custom swipe (no overlay text).
--- Intended to be used in both HOLD and NOW windows.
--- @return boolean
function NAG:WarriorSlamWeave()
    local slamId = self:WarriorSlamWeaveGetSlamId()
    local result = self:CastSpell(slamId, 3, ns.SPELL_POSITIONS.PRIMARY)
    if self.castOverlayTexts then
        self.castOverlayTexts[slamId] = nil
    end

    return result
end

--- Slam weave wait helper: show Slam with overlay text while waiting.
--- Intended for the "nothing else to do" fallback.
--- @return boolean
function NAG:WarriorSlamWeaveWait()
    local slamId = self:WarriorSlamWeaveGetSlamId()
    local result = self:CastPlaceholder(slamId, nil, ns.SPELL_POSITIONS.PRIMARY)

    if self.ClearCustomOverlay then
        self:ClearCustomOverlay()
    end
    self.castOverlayTexts = self.castOverlayTexts or {}
    self.castOverlayTexts[slamId] = "SLAM"

    return result
end

--- Legacy alias: Slam weave HOLD (no overlay text).
--- @return boolean
function NAG:WarriorSlamWeaveHold()
    return self:WarriorSlamWeave()
end

--- Legacy alias: Slam weave NOW (no overlay text).
--- @return boolean
function NAG:WarriorSlamWeaveNow()
    return self:WarriorSlamWeave()
end

--- Internal helper function for low-level spell casting.
--- Does not map to APL proto - this is an internal implementation detail.
--- Use NAG:CastSpell() for APL actions (maps to APLActionCastSpell).
--- Handles stance and pet logic, sequence suppression checks.
--- @local
--- @param spellId number The ID of the spell.
--- @param tolerance number|nil Optional casting tolerance in seconds.
--- @param forceMain boolean|nil Optional flag to force main display even if part of sequence.
--- @return boolean True if the spell was set to cast; otherwise false.
function NAG:_CastSpell(spellId, tolerance, forceMain)
    -- Debug specific spell ID by uncommenting the line below
    -- debugSpell(spellId, tolerance)
    tolerance = tolerance or 0

    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entity or not entity.flags.spell then return false end

    -- Handle stance spells
    if entity.flags.stance and GetShapeshiftFormID() == entity.shapeshiftForm then
        return false
    end

    -- Handle pet spells
    if entity.flags.pet then
        if entity.flags.action then
            -- Only proceed if we have the correct pet active
            if StateManager:IsActivePet(entity.summonSpellId) then
                -- Bypass secondary spell check when casting from StrictSequence
                if self._castingFromStrictSequence then
                    self.nextSpell = self:NormalizePrimaryAction(spellId, { context = "castspell_pet_main" })
                    return true
                elseif self:IsSecondarySpell(spellId) then
                    self:AddSecondarySpell(spellId)
                    return false
                else
                    -- Check if this spell is part of an active sequence (unless forceMain is true)
                    if not forceMain and NAG.RightSlots.activeSequence then
                        local sequenceName = NAG.RightSlots.activeSequence
                        local expectedSpells = self.strictSequenceSpells[sequenceName]
                        if expectedSpells and tContains(expectedSpells, spellId) then
                            self:Debug(format("CastSpell: Suppressing MAIN spell %d - it's part of active sequence '%s'",
                                spellId, sequenceName))
                            return false -- Don't set as main spell if it's part of an active sequence
                        end
                    end

                    self.nextSpell = self:NormalizePrimaryAction(spellId, { context = "castspell_pet_main" })
                    return true
                end
            end
        elseif entity.id == spellId then
            if StateManager:IsActivePet(spellId) then
                return false
            end
        end
    end

    -- Check if the spell can be cast
    if not self:SpellCanCast(spellId, tolerance) then
        return false
    end

    -- Check if this spell is part of an active sequence (unless forceMain is true)
    if not forceMain and NAG.RightSlots.activeSequence then
        local sequenceName = NAG.RightSlots.activeSequence
        -- Check both old strictSequenceSpells and new RightSlots.sequence
        local isInOldSequence = self.strictSequenceSpells[sequenceName] and
            tContains(self.strictSequenceSpells[sequenceName], spellId)
        local isInNewSequence = NAG.RightSlots.sequence and tContains(NAG.RightSlots.sequence, spellId)

        if isInOldSequence or isInNewSequence then
            self:Trace(format("CastSpell: Suppressing MAIN spell %d - it's part of active sequence '%s'", spellId,
                sequenceName))
            return false -- Don't set as main spell if it's part of an active sequence
        end
    end

    -- Bypass secondary spell check when casting from StrictSequence
    if self._castingFromStrictSequence then
        self.nextSpell = self:NormalizePrimaryAction(spellId, { context = "castspell_main" })
        return true
    elseif self:IsSecondarySpell(spellId) then
        self:AddSecondarySpell(spellId)
        return false
    else
        self.nextSpell = self:NormalizePrimaryAction(spellId, { context = "castspell_main" })
        return true
    end
end

-- ============================ CHANNELING ============================

--- Attempts to cast a channeled spell if it is available and ready, with optional interrupt condition and recast flag.
--- Maps to APLActionChannelSpell in Go.
--- @param spellId number The ID of the spell.
--- @param interruptCondition function|boolean|nil Optional interrupt condition function or recast flag.
--- @param recast boolean|nil Optional flag to allow recasting on interrupt.
--- @usage NAG:ChannelSpell(73643, function() return true end, true)
--- @return boolean True if the spell was set to cast successfully.
function NAG:ChannelSpell(spellId, interruptCondition, recast)
    -- TEMPORARY: Just call Cast() directly until proper channeling logic is implemented
    if not spellId then
        self:Error("ChannelSpell: No spellId provided")
        return false
    end
    local resolvedId = self:ResolveEffectiveSpellId(spellId)
    if not resolvedId then
        return false
    end
    return self:CastSpell(resolvedId)

    --[[ ORIGINAL IMPLEMENTATION (preserved for future use):
    if not spellId then
        self:Error("ChannelSpell: No spellId provided")
        return false
    end

    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error("ChannelSpell: SpellId " .. spellId .. " not found in Spell table")
        return false
    end

    if not self:IsKnownSpell(spellId) then
        return false
    end

    -- Handle argument parsing
    if type(interruptCondition) == "boolean" then
        recast = interruptCondition
        interruptCondition = function() return false end
    end

    -- Check if spell can be cast
    if not self:SpellCanCast(spellId) then
        return false
    end

    -- Handle the actual spell cast
    -- Bypass secondary spell check when casting from StrictSequence
    if self._castingFromStrictSequence then
        self:SetMainSpell(spellId)
        return true
    end

    -- Check if this is a secondary spell (already queued)
    if self:IsSecondarySpell(spellId) then
        return false
    end

    -- Set as main spell
    self:SetMainSpell(spellId)
    return true
    --]]
end

-- ============================ MULTI-TARGET CASTING ============================

--- Attempts to cast a spell on multiple targets (multidot) if conditions are met.
--- Maps to APLActionMultidot in Go.
--- @param spellId number The ID of the spell.
--- @param maxDots number|nil Maximum number of dots to maintain (defaults to 1).
--- @param maxOverlap number|nil Maximum overlap time in seconds (defaults to 1).
--- @param position? string Optional position for display (defaults to nil).
--- @param range? number Optional additional range beyond target distance (defaults to dynamic calculation).
--- @return boolean True if the spell was cast, false otherwise.
--- @usage NAG:Multidot(8050, 2, 1.5) -- Uses dynamic range (targetDistance + 5 for ranged, 7 or targetDistance + 5 for melee)
--- @usage NAG:Multidot(8050, 2, 1.5, ns.SPELL_POSITIONS.RIGHT) -- With position, dynamic range
--- @usage NAG:Multidot(8050, 2, 1.5, ns.SPELL_POSITIONS.AOE, 10) -- With position and targetDistance + 10 yard range
function NAG:Multidot(spellId, maxDots, maxOverlap, position, range)
    -- Parameter checks
    if not spellId then
        self:Error(format("Multidot: No spellId provided (maxDots: %s, maxOverlap: %s, position: %s, range: %s)",
            tostring(maxDots), tostring(maxOverlap), tostring(position), tostring(range)))
        return false
    end

    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("Multidot: SpellId %s not found in Spell table", tostring(spellId)))
        return false
    end

    local resolvedId = self:ResolveEffectiveSpellId(spellId)
    if not resolvedId then
        return false
    end

    if not self:IsKnownSpell(resolvedId) then
        return false
    end

    -- Get current target info
    local targetGUID = UnitGUID("target")
    if not targetGUID then return false end

    -- Count targets and targets with our debuff using consistent range logic
    -- If range is provided, both functions will use targetDistance + range
    -- If range is nil, both functions will use their dynamic range calculations
    local targetCount = self:CountTargetsInRange(range)
    local debuffedTargets = self:CountTargetsWithDebuff(resolvedId, range)

    -- Check if we should cast
    if debuffedTargets < min(targetCount, maxDots or 1) then
        -- Check if we can cast on current target
        if self:SpellCanCast(resolvedId) then
            return self:CastSpell(resolvedId, nil, position)
        end
    end

    return false
end

--- Attempts to cast a spell on multiple targets with strict ordering (strict multidot).
--- Maps to APLActionStrictMultidot in Go.
--- @param spellId number The ID of the spell.
--- @param maxDots number|nil Maximum number of dots to maintain (defaults to 1).
--- @param maxOverlap number|nil Maximum overlap time in seconds (defaults to 1).
--- @param position? string Optional position for display (defaults to nil).
--- @param range? number Optional additional range beyond target distance (defaults to dynamic calculation).
--- @return boolean True if the action was successful.
--- @usage NAG:StrictMultidot(73643, 3, 2)
function NAG:StrictMultidot(spellId, maxDots, maxOverlap, position, range)
    -- One-time warning that StrictMultidot is not implemented
    if not self._strictMultidotWarningShown then
        self:Error("StrictMultidot is not yet implemented, reverting to Multidot functionality")
        self._strictMultidotWarningShown = true
    end

    -- TODO: Implement logic for strict multi-dotting.
    return self:Multidot(spellId, maxDots, maxOverlap, position, range)
end

--- Attempts to cast a shield spell on multiple friendly targets (multishield).
--- Maps to APLActionMultishield in Go.
--- @param spellId number The ID of the spell.
--- @param maxShields number|nil Maximum number of shields to maintain (defaults to 1).
--- @param maxOverlap number|nil Maximum overlap time in seconds (defaults to 1).
--- @param position? string Optional position for display (defaults to nil).
--- @param range? number Optional additional range beyond target distance (defaults to dynamic calculation).
--- @usage NAG:Multishield(73643, 3, 1) -- Uses dynamic range
--- @usage NAG:Multishield(73643, 3, 1, ns.SPELL_POSITIONS.RIGHT) -- With position, dynamic range
--- @usage NAG:Multishield(73643, 3, 1, ns.SPELL_POSITIONS.AOE, 10) -- With position and targetDistance + 10 yard range
--- @return boolean Always returns false (not yet implemented).
function NAG:Multishield(spellId, maxShields, maxOverlap, position, range)
    -- One-time warning that Multishield is not implemented
    if not self._multishieldWarningShown then
        self:Error("Multishield is not yet implemented")
        self._multishieldWarningShown = true
    end

    maxShields = maxShields or 1
    maxOverlap = maxOverlap or 1
    -- Position and range parameters are accepted for future implementation
    -- When implemented, should follow similar logic to Multidot for friendly targets
    return false
end

-- ============================ COOLDOWN CASTING ============================

--- Casts all stat buff cooldowns that match the specified stat types.
--- Maps to APLActionCastAllStatBuffCooldowns in Go.
--- @param statType1 number|string|nil First stat type to match (supports strings like "str", numbers, or nil).
--- @param statType2 number|string|nil Second stat type to match (supports strings like "crit", numbers, or nil).
--- @param statType3 number|string|nil Third stat type to match (supports strings like "haste", numbers, or nil).
--- @usage NAG:CastAllStatBuffCooldowns(-1, -1, -1)
--- @return boolean Always returns false (adds to secondary only).
function NAG:CastAllStatBuffCooldowns(statType1, statType2, statType3)
    -- Prompt equipped on-use trinkets using unified caching system

    -- Environment guards (prevent nil-call during compile/validation phases)
    if type(GetInventoryItemID) ~= "function" or type(GetTime) ~= "function" then
        return false
    end


    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, nil)

    local toPrompt = {}

    -- Process matching trinkets
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo
        local slot = trinketData.slot

        -- Only prompt USE trinkets, not PROC trinkets
        if trinketInfo and trinketInfo.procType == "use" then
            -- Check per-slot cooldown/usable state before prompting
            local cds = TrinketTrackingManager:GetUseCooldownsForEquipped()
            local slotInfo = cds and cds[slot]
            -- TODO: Might need to use IsReady?
            if slotInfo and slotInfo.ready then
                -- Add to prompt list - trinket is ready to use
                tinsert(toPrompt, {
                    itemId = itemId,
                    slot = slot,
                    trinketInfo = trinketInfo
                })
            end
            -- Skip if on cooldown or not usable (when slotInfo.ready is false)
        end
    end

    -- Add all eligible trinkets to secondary spells
    for _, promptData in ipairs(toPrompt) do
        self:AddSecondarySpell(promptData.itemId)
    end

    return false
end

-- Throughput racials: one spell ID per logical ability so only one icon shows per racial.
-- Each inner table = same ability across expansions; we add only the first known+ready so the icon that appears is the one that goes on cooldown.
local AUTOCAST_RACIAL_GROUPS = {
    { 20572, 33697, 33702 },  -- Blood Fury (Orc): TBC/Wrath, MoP+, caster variant
    { 26297 },                 -- Berserking (Troll)
    { 28734 },                 -- Mana Tap (Blood Elf)
    { 25046 },                 -- Arcane Torrent (Blood Elf)
}

--- Automatically casts other cooldowns based on settings and availability.
--- Maps to APLActionAutocastOtherCooldowns in Go.
--- When enableRacials is true, suggests throughput racials (Blood Fury, Berserking, etc.) when ready;
--- position comes from class specSpellLocations (LEFT) so APLs that call this get racials without listing them.
--- @param enableTrinketSlot1 boolean|nil Whether to use trinket slot 1 (default: from settings).
--- @param enableTrinketSlot2 boolean|nil Whether to use trinket slot 2 (default: from settings).
--- @param enableDefaultBattlePotion boolean|nil Whether to use default battle potion (default: from settings).
--- @param enableGloveSlot boolean|nil Whether to use the glove slot item (default: true)
--- @param enableBeltSlot boolean|nil Whether to use the belt slot item (default: false)
--- @usage NAG:AutocastOtherCooldowns(true, true, true, true, true)
--- @return boolean Always returns false (adds items to secondary spells list).
function NAG:AutocastOtherCooldowns(enableTrinketSlot1, enableTrinketSlot2, enableDefaultBattlePotion,
                                    enableGloveSlot, enableBeltSlot)
    local classModule = NAG:GetClassModule()
    if not classModule then
        print("ERROR: No class module found")
        return false
    end

    -- Cache autocast settings for performance
    local autocastSettings = classModule.db.char.autocastSettings or
        { enableTrinketSlot1 = false, enableTrinketSlot2 = false, enableDefaultBattlePotion = false, enableGloveSlot = false, enableBeltSlot = false, enableRacials = true }

    -- Use provided args or fall back to char settings
    enableTrinketSlot1 = enableTrinketSlot1 == nil and autocastSettings.enableTrinketSlot1 or enableTrinketSlot1
    enableTrinketSlot2 = enableTrinketSlot2 == nil and autocastSettings.enableTrinketSlot2 or enableTrinketSlot2
    enableDefaultBattlePotion = enableDefaultBattlePotion == nil and autocastSettings.enableDefaultBattlePotion or
        enableDefaultBattlePotion
    enableGloveSlot = enableGloveSlot == nil and autocastSettings.enableGloveSlot or enableGloveSlot
    enableBeltSlot = enableBeltSlot == nil and autocastSettings.enableBeltSlot or enableBeltSlot
    local enableRacials = autocastSettings.enableRacials == nil and true or autocastSettings.enableRacials


    -- Get equipped items
    local trinket1 = GetInventoryItemID("player", 13) -- Trinket slot 1
    local trinket2 = GetInventoryItemID("player", 14) -- Trinket slot 2
    local glove = GetInventoryItemID("player", 10)    -- Glove slot
    local belt = GetInventoryItemID("player", 6)      -- Belt slot

    -- Get battle potion from settings
    local battlePotion = classModule.db.char.defaultBattlePotion

    -- Track what we're trying to use
    local attemptedUses = {}

    -- Try trinket slot 1
    if enableTrinketSlot1 and trinket1 then
        if self:IsReady(trinket1) then
            self:AddSecondarySpell(trinket1)
            attemptedUses.trinket1 = trinket1
        end
    end

    -- Try trinket slot 2
    if enableTrinketSlot2 and trinket2 then
        if self:IsReady(trinket2) then
            self:AddSecondarySpell(trinket2)
            attemptedUses.trinket2 = trinket2
        end
    end

    -- Try battle potion
    if enableDefaultBattlePotion and battlePotion then
        local blockDefaultBattlePotion = autocastSettings.blockDefaultBattlePotion == true
        if not blockDefaultBattlePotion and self:IsReady(battlePotion) then
            local battlePotionPosition = autocastSettings.defaultBattlePotionSpellLocation
            if not battlePotionPosition or not ns.VALID_SPELL_POSITIONS[battlePotionPosition] then
                battlePotionPosition = ns.SPELL_POSITIONS.LEFT
            end
            self:AddSecondarySpell(battlePotion, battlePotionPosition)
            attemptedUses.battlePotion = battlePotion
        end
    end

    -- Try glove slot: add with spellId + position + itemId when item has a spell (tinker/on-use) so display and position match CastTinker.
    -- Important: for tinkers, use IsReadyTinker(spellId) so readiness is bound to the equipped slot item, not a duplicate in bags.
    if enableGloveSlot and glove then
        local GetItemSpell = C_Item and C_Item.GetItemSpell or _G.GetItemSpell
        local gloveSpellId
        if GetItemSpell then
            _, gloveSpellId = GetItemSpell(glove)
        end

        local gloveReady = false
        if gloveSpellId and gloveSpellId > 0 then
            local StateManager = NAG:GetModule("StateManager", true)
            local tinkerInfo = (StateManager and StateManager.GetTinkerInfoBySpellId) and
                StateManager:GetTinkerInfoBySpellId(gloveSpellId) or nil
            if tinkerInfo and tinkerInfo.itemId == glove then
                gloveReady = self:IsReadyTinker(gloveSpellId)
            else
                gloveReady = self:IsReady(glove)
            end
        else
            gloveReady = self:IsReady(glove)
        end

        if gloveReady then
            if gloveSpellId and gloveSpellId > 0 then
                local position = ns.SPELL_POSITIONS.LEFT
                local SpellbookManager = NAG:GetModule("SpellbookManager", true)
                if SpellbookManager and SpellbookManager.GetSpellPosition then
                    local pos = SpellbookManager:GetSpellPosition(gloveSpellId)
                    if pos and pos ~= ns.SPELL_POSITIONS.PRIMARY then
                        position = pos
                    end
                end
                self:AddSecondarySpell(gloveSpellId, position, glove)
            else
                self:AddSecondarySpell(glove)
            end
            attemptedUses.glove = glove
        end
    end

    -- Try belt slot
    if enableBeltSlot and belt then
        if self:IsReady(belt) then
            self:AddSecondarySpell(belt)
            attemptedUses.belt = belt
        end
    end

    -- Racials: suggest the resolved spellbook ID so the icon matches the spell that goes on cooldown (SpellCanCast resolves at entry).
    if enableRacials then
        local SpellbookManager = NAG:GetModule("SpellbookManager", true)
        for _, group in ipairs(AUTOCAST_RACIAL_GROUPS) do
            local resolvedId
            for _, id in ipairs(group) do
                if not id then break end
                if self:SpellCanCast(id) then
                    resolvedId = self:ResolveEffectiveSpellId(id)
                    if resolvedId then
                        break
                    end
                end
            end
            if resolvedId then
                local position = ns.SPELL_POSITIONS.LEFT
                if SpellbookManager and SpellbookManager.GetSpellPosition then
                    local pos = SpellbookManager:GetSpellPosition(resolvedId)
                    if pos and pos ~= ns.SPELL_POSITIONS.PRIMARY then
                        position = pos
                    end
                end
                self:AddSecondarySpell(resolvedId, position)
            end
        end
    end

    -- Autocast unused major cooldowns with threshold-based conditions
    -- Only execute if enableMajorCooldowns is enabled
    if RotationManager and classModule and classModule.db.char.enableMajorCooldowns then
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or nil
        local currentRotation, rotationName = classModule:GetCurrentRotation(specIndex)
        if specIndex and rotationName then
            local unusedMajorCooldowns = RotationManager:GetUnusedMajorCooldownSpellIds(specIndex, rotationName)
            if unusedMajorCooldowns and #unusedMajorCooldowns > 0 then
                -- Get threshold settings
                local thresholds = classModule.db.char.cooldownThresholds or {}
                local survivalHealthPercent = thresholds.survivalHealthPercent or 50
                local manaPercent = thresholds.manaPercent or 60
                local dpsTargetHealthMinPercent = thresholds.dpsTargetHealthMinPercent or 20
                local dpsTargetHealthMaxPercent = thresholds.dpsTargetHealthMaxPercent or 100

                -- Get current health/mana percentages
                local playerHealthMax = UnitHealthMax("player")
                local playerHealth = playerHealthMax > 0 and (UnitHealth("player") / playerHealthMax) * 100 or 100
                local playerManaMax = UnitPowerMax("player", 0)
                local playerMana = playerManaMax > 0 and (UnitPower("player", 0) / playerManaMax) * 100 or 100
                local targetHealthMax = UnitExists("target") and UnitHealthMax("target") or 1
                local targetHealth = UnitExists("target") and targetHealthMax > 0 and
                    ((UnitHealth("target") / targetHealthMax) * 100) or 100

                -- Get cooldown types
                local CooldownType = Types and Types:GetType("CooldownType")

                for _, cooldownData in ipairs(unusedMajorCooldowns) do
                    local spellId = cooldownData.spellId
                    local cooldownType = cooldownData.cooldownType or 0

                    -- Check for cooldown category override
                    local overrides = classModule.db.char.cooldownCategoryOverrides
                    if overrides and overrides.Spell and overrides.Spell[spellId] then
                        cooldownType = overrides.Spell[spellId]
                    end

                    -- Respect per-spell disabled overrides
                    local isDisabled = overrides and overrides.Disabled and overrides.Disabled.Spell and overrides.Disabled.Spell[spellId] == true

                    if Version and Version:IsWrath() and spellId == 82174 then
                        spellId = 54758 -- Hyperspeed Accelerators (Wrath)
                    end

                    local resolvedId = self:ResolveEffectiveSpellId(spellId)
                    if not resolvedId then
                        -- Skip: no spellbook ID for this cooldown
                    else
                        local spellEntity = DataManager:Get(resolvedId, DataManager.EntityTypes.SPELL)
                        if spellEntity and not isDisabled and self:IsKnown(resolvedId) and self:IsReady(resolvedId) then
                            -- Check threshold conditions based on cooldown type
                            local shouldUse = true

                            if CooldownType then
                                if cooldownType == CooldownType.Survival then
                                    shouldUse = playerHealth <= survivalHealthPercent
                                elseif cooldownType == CooldownType.Mana then
                                    shouldUse = playerMana <= manaPercent
                                elseif cooldownType == CooldownType.DPS or cooldownType == CooldownType.Explosive then
                                    -- DPS cooldowns only used when target health is within the specified range
                                    shouldUse = targetHealth >= dpsTargetHealthMinPercent and targetHealth <= dpsTargetHealthMaxPercent
                                end
                            end

                            if shouldUse then
                                self:AddSecondarySpell(resolvedId)
                            end
                        end
                    end
                end
            end
        end
    end

    return false
end

-- ======================= NAG-SPECIFIC FUNCTIONS =======================

--- Attempts to cast a debuff spell if available and ready, with optional tolerance. Checks for existing debuffs of the same type.
--- @param id number The ID of the debuff spell.
--- @param tolerance number|nil Optional casting tolerance in seconds.
--- @usage NAG:CastDebuff(7386, 0)
--- @return boolean True if the debuff was set to cast; otherwise false.
function NAG:CastDebuff(id, tolerance)
    tolerance = tolerance or 0
    if not id then
        self:Error(format("CastDebuff: Spell %d not found", id))
        return false
    end

    -- Get spell from DataManager
    local spell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("CastDebuff: Spell %d not found", id))
        return false
    end

    local resolvedId = self:ResolveEffectiveSpellId(id)
    if not resolvedId then
        return false
    end

    -- Check if spell is known
    if not self:IsKnownSpell(resolvedId) then
        return false
    end

    -- Check if it's a debuff using flags
    if not spell.flags.debuff and not spell.flags.debufftype then
        self:Error(format("CastDebuff: Spell %d is not a debuff", id))
        return false
    end

    -- Check if ready to cast
    if not self:SpellCanCast(resolvedId, tolerance) then
        return false
    end

    -- Check for existing debuffs of the same type
    if spell.types and spell.types.DebuffType then
        local debuffTypes = type(spell.types.DebuffType) == "table" and
            spell.types.DebuffType or
            { spell.types.DebuffType }

        for _, debuffType in ipairs(debuffTypes) do
            local existingDebuffs = DataManager:GetAllByType("DebuffType", debuffType)
            for debuffId in pairs(existingDebuffs) do
                if NAG:UnitDebuffGlobal("target", debuffId) then
                    return false -- Debuff of the same type exists
                end
            end
        end
    end

    -- Cast the spell
    -- Bypass secondary spell check when casting from StrictSequence
    if self._castingFromStrictSequence then
        self.nextSpell = self:NormalizePrimaryAction(resolvedId, { context = "castdebuff_main" })
        return true
    elseif self:IsSecondarySpell(resolvedId) then
        self:AddSecondarySpell(resolvedId)
        return false
    else
        -- Check if this spell is part of an active sequence
        if NAG.RightSlots.activeSequence then
            local sequenceName = NAG.RightSlots.activeSequence
            local expectedSpells = self.strictSequenceSpells[sequenceName]
            if expectedSpells and tContains(expectedSpells, resolvedId) then
                self:Debug(format("CastDebuff: Suppressing MAIN spell %d - it's part of active sequence '%s'", resolvedId,
                    sequenceName))
                return false -- Don't set as main spell if it's part of an active sequence
            end
        end

        self.nextSpell = self:NormalizePrimaryAction(resolvedId, { context = "castdebuff_main" })
        return true
    end
end

--- Attempts to cast a buff spell if available and ready, with optional tolerance. Checks for existing buffs of the same type.
--- @param id number The ID of the buff spell.
--- @param tolerance number|nil Optional casting tolerance in seconds.
--- @usage NAG:CastBuff(6673, 0)
--- @return boolean True if the buff was set to cast; otherwise false.
function NAG:CastBuff(id, tolerance)
    tolerance = tolerance or 0
    if not id then
        self:Error(format("CastBuff: Spell %d not found", id))
        return false
    end

    -- Get spell from DataManager
    local spell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("CastBuff: Spell %d not found", id))
        return false
    end

    local resolvedId = self:ResolveEffectiveSpellId(id)
    if not resolvedId then
        return false
    end

    -- Check if spell is known
    if not self:IsKnownSpell(resolvedId) then
        return false
    end

    -- Check if it's a buff using flags
    if not spell.flags.buff and not spell.flags.bufftype then
        self:Error(format("CastBuff: Spell %d is not a buff", id))
        return false
    end

    -- Check if ready to cast
    if not self:SpellCanCast(resolvedId, tolerance) then
        return false
    end

    -- Check for existing buffs of the same type
    if spell.types and spell.types.BuffType then
        local buffTypes = type(spell.types.BuffType) == "table" and
            spell.types.BuffType or
            { spell.types.BuffType }

        for _, buffType in ipairs(buffTypes) do
            local existingBuffs = DataManager:GetAllByType("BuffType", buffType)
            for buffId in pairs(existingBuffs) do
                -- Check both player and target based on buff type
                --TODO: This probably needs to be addressed
                local unit = spell.flags.bufftype and "target" or "player"
                if NAG:UnitAura(unit, buffId, "HELPFUL") then
                    return false -- Buff of the same type exists
                end
            end
        end
    end

    -- Cast the spell
    -- Bypass secondary spell check when casting from StrictSequence
    if self._castingFromStrictSequence then
        self.nextSpell = self:NormalizePrimaryAction(resolvedId, { context = "castbuff_main" })
        return true
    elseif self:IsSecondarySpell(resolvedId) then
        self:AddSecondarySpell(resolvedId)
        return false
    else
        -- Check if this spell is part of an active sequence
        if NAG.RightSlots.activeSequence then
            local sequenceName = NAG.RightSlots.activeSequence
            local expectedSpells = self.strictSequenceSpells[sequenceName]
            if expectedSpells and tContains(expectedSpells, resolvedId) then
                self:Debug(format("CastBuff: Suppressing MAIN spell %d - it's part of active sequence '%s'", resolvedId,
                    sequenceName))
                return false -- Don't set as main spell if it's part of an active sequence
            end
        end

        self.nextSpell = self:NormalizePrimaryAction(resolvedId, { context = "castbuff_main" })
        return true
    end
end

--- Determines if a spell or item is classified as a secondary action based on its position.
--- @param id number The ID of the spell or item.
--- @usage NAG:IsSecondarySpell(73643)
--- @return boolean True if the action is secondary; otherwise false.
--- @local Internal utility function for spell management
function NAG:IsSecondarySpell(id)
    if not id then
        self:Error("IsSecondarySpell: No ID provided")
        return false
    end

    -- Initialize cache if needed
    self._secondarySpellCache = self._secondarySpellCache or {}

    local normalized = self:NormalizeActionIdentity(id, { context = "is_secondary_spell" })
    local resolveId = self:GetActionResolveId(normalized) or id
    local preferItemFirst = normalized and normalized.itemId ~= nil or false
    local cacheKey = buildActionIdentityCacheKey(resolveId, preferItemFirst)

    -- Check cache first (identity-aware key)
    if self._secondarySpellCache[cacheKey] ~= nil then
        return self._secondarySpellCache[cacheKey]
    end

    -- Get effective position from SpellbookManager (guaranteed to be available due to load ordering)
    local spellPosition = SpellbookManager:GetSpellPosition(resolveId) or ns.SPELL_POSITIONS.PRIMARY

    -- A spell is secondary if it's assigned to any position other than PRIMARY
    local isSecondary = spellPosition ~= ns.SPELL_POSITIONS.PRIMARY

    -- Store result in cache
    self._secondarySpellCache[cacheKey] = isSecondary
    return isSecondary
end

--- Clears the secondary spell cache when spell locations change
--- @usage NAG:ClearSecondarySpellCache()
--- @return nil
--- @local Internal utility function for cache management
function NAG:ClearSecondarySpellCache()
    self._secondarySpellCache = {}
end

--- Clears overlay text for a specific spell ID
--- @param spellId number The spell ID to clear overlay text for
--- @local Internal utility function for overlay text cleanup
function NAG:ClearCastOverlayText(spellId)
    if not spellId or not self.castOverlayTexts then
        return
    end

    self.castOverlayTexts[spellId] = nil
    if self.castOverlaySwipes then
        self.castOverlaySwipes[spellId] = nil
    end
    if self.castOverlaySwipesExpiresAt then
        self.castOverlaySwipesExpiresAt[spellId] = nil
    end

    local overlayId = "cast_" .. tostring(spellId)
    if OverlayManager and OverlayManager.HideOverlaysBySpellId then
        OverlayManager:HideOverlaysBySpellId(nil, overlayId)
    end
end

--- Clears overlay text for all secondary spell entries using normalized display ID (spellId or itemId).
--- @param secondarySpells table|nil
function NAG:ClearSecondarySpellOverlays(secondarySpells)
    if not secondarySpells or type(secondarySpells) ~= "table" then
        return
    end
    for i = 1, #secondarySpells do
        local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(secondarySpells[i]) or nil
        if norm then
            local id = norm.itemId or norm.spellId
            if id then
                self:ClearCastOverlayText(id)
            end
        end
    end
end

-- ~~~~~~~~~~ Custom Overlay (Primary) ~~~~~~~~~~

local CUSTOM_OVERLAY_ID = "custom_primary"
local CUSTOM_OVERLAY_EXPIRE_SECONDS = 0.25
local MANA_OVERLAY_EXPIRE_SECONDS = 0.25

-- Swing overlay TTL (Auto Attack pooling placeholder only).
-- This keeps the behavior visually stable (avoids flicker on minor frame drops) while still requiring
-- rotations to keep calling CastWithSwingOverlay() to sustain the swing swipe.
local SWING_OVERLAY_TTL_SECONDS = 0.25

--- Clears the custom primary overlay text, if present.
--- @return boolean Always returns false
function NAG:ClearCustomOverlay()
    self._customOverlayText = nil
    self._customOverlayLastRefresh = nil

    if OverlayManager and OverlayManager.HideOverlaysBySpellId then
        OverlayManager:HideOverlaysBySpellId(nil, CUSTOM_OVERLAY_ID)
    end

    return false
end

--- Shows custom overlay text on the PRIMARY icon frame.
--- Intended to be called frequently; uses a stable overlay key and auto-expires if not refreshed.
--- Cast overlays (CastSpell overlayText) have priority and will clear/suppress this overlay.
--- @param text string|nil The text to display. Pass nil/empty to clear.
--- @param options table|nil Optional display config (`centered`, `textColor`, `textSize`).
--- @return boolean Always returns false
function NAG:ShowCustomOverlay(text, options)
    if not text or text == "" then
        return self:ClearCustomOverlay()
    end

    -- If a cast overlay is active for the current primary spell, do not show the custom overlay.
    local nextOverlayId = self.GetActionResolveId and self:GetActionResolveId(self.nextSpell)
        or (self.GetActionDisplayId and self:GetActionDisplayId(self.nextSpell))
    if self.castOverlayTexts and nextOverlayId and self.castOverlayTexts[nextOverlayId] then
        return false
    end

    -- Refresh timestamp for auto-expire (both legacy and group display use this).
    self._customOverlayText = text
    self._customOverlayLastRefresh = GetTime()

    if not OverlayManager then
        return false
    end

    -- Locate the PRIMARY icon frame (legacy or group display).
    local dm = getDisplayManagerModule(self)
    local primaryFrame = dm and dm:GetFrameForPosition("primary") or nil
    if not primaryFrame then
        return false
    end

    options = options or {}
    local isCentered = options.centered == true

    -- Default layout matches existing custom overlay behavior; centered mode
    -- is used for stable pooling-style overlays (e.g. shared MANA overlay).
    local fontSize = options.textSize or 12
    local point = isCentered and "CENTER" or "BOTTOM"
    local relativePoint = isCentered and "CENTER" or "TOP"
    local xOffset = 0
    local yOffset = isCentered and 0 or 10
    local fontColor = options.textColor or { 1, 1, 1, 1 }

    -- Build overlay config similar to OverlayText() baseConfig (pooling overlay supports text)
    local customConfig = {
        text = text,
        textColor = fontColor,
        textSize = fontSize,
        textFont = "Friz Quadrata TT",
        textFlags = "OUTLINE",
        textBackground = {
            enable = false
        },
        showSpellIcon = false,
        pulse = false,
        alpha = 1.0,
        -- Use stable id as overlay key component (matches HideOverlaysBySpellId usage)
        spellId = CUSTOM_OVERLAY_ID,
    }

    local function checkFunc()
        -- Stop showing if the frame disappears
        if not primaryFrame or not primaryFrame:IsShown() then
            return false
        end

        -- Suppress while a cast overlay exists for the current primary suggestion
        local currentOverlayId = self.GetActionResolveId and self:GetActionResolveId(self.nextSpell)
            or (self.GetActionDisplayId and self:GetActionDisplayId(self.nextSpell))
        if self.castOverlayTexts and currentOverlayId and self.castOverlayTexts[currentOverlayId] then
            return false
        end

        local last = self._customOverlayLastRefresh
        if not last then
            return false
        end

        return (GetTime() - last) <= CUSTOM_OVERLAY_EXPIRE_SECONDS
    end

    local overlay = OverlayManager:ShowOverlay(primaryFrame, "pooling", nil, checkFunc, customConfig)

    -- IMPORTANT: ShowOverlay() uses the base "pooling" config text by default (often "Pooling"),
    -- and it does not apply customConfig.text automatically. So we must explicitly set the text.
    if overlay then
        if not overlay.text then
            overlay.text = overlay:CreateFontString(nil, "OVERLAY")
        end

        local LSM = ns.LibSharedMedia
        local fontPath = LSM and (LSM:Fetch("font", "Friz Quadrata TT") or LSM:GetDefault("font")) or nil
        local success = fontPath and overlay.text:SetFont(fontPath, fontSize, "OUTLINE")
        if not success then
            overlay.text:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
        end

        overlay.text:SetText(text)
        overlay.text:SetTextColor(unpack(fontColor))
        overlay.text:SetAlpha(1.0)

        -- Ensure text placement matches OverlayText() default layout (above the icon)
        overlay.text:ClearAllPoints()
        overlay.text:SetPoint(point, primaryFrame, relativePoint, xOffset, yOffset)
        overlay.text:SetJustifyH("CENTER")
        overlay.text:SetJustifyV("MIDDLE")
        overlay.text:Show()
        OverlayManager:UpdateOverlayTextBackground(overlay)
    end

    return false
end

--- Shows a dedicated MANA overlay on PRIMARY, independent from cast/custom text overlays.
--- Uses OverlayManager's own "mana" overlay channel to avoid conflicts with HOLD/cast text.
--- @return boolean Always returns false.
function NAG:ShowManaOverlay()
    self._manaOverlayLastRefresh = GetTime()
    if not OverlayManager then
        return false
    end
    local dm = getDisplayManagerModule(self)
    local primaryFrame = dm and dm:GetFrameForPosition("primary") or nil
    if not primaryFrame then
        return false
    end
    if OverlayManager.ShowMana then
        OverlayManager:ShowMana(primaryFrame, function()
            local last = self._manaOverlayLastRefresh
            if not last then
                return false
            end
            return (GetTime() - last) <= MANA_OVERLAY_EXPIRE_SECONDS
        end)
    end
    return false
end

--- Hides the dedicated MANA overlay and clears its refresh marker.
--- @return boolean Always returns false.
function NAG:HideManaOverlay()
    self._manaOverlayLastRefresh = nil
    if not OverlayManager then
        return false
    end
    local dm = getDisplayManagerModule(self)
    local primaryFrame = dm and dm:GetFrameForPosition("primary") or nil
    if not primaryFrame then
        return false
    end
    if OverlayManager.HideMana then
        OverlayManager:HideMana(primaryFrame)
    end
    return false
end

--- Adds a spell or item to the secondary spells list if not already present.
--- For tinkers, pass the item ID as the third argument so display/cooldown use GetItemCooldown(itemId) unambiguously.
--- @param ID number The spell ID or item ID (primary identifier for cast/lookup).
--- @param position string|nil Position constant (e.g. ns.SPELL_POSITIONS.LEFT).
--- @param itemId number|nil Optional. When set (e.g. tinker gloves), stored as entry.itemId so display uses item cooldown.
--- @return boolean True if the spell was already present; false if added or if spell/item is not usable.
--- @local Internal utility function for spell management
function NAG:AddSecondarySpell(ID, position, itemId)
    if not ID then return false end

    -- Block default battle potion when "Block default battle potion" is enabled (not in spell blacklist dropdown)
    if self:IsPotionBlocked(ID) then
        return false
    end

    local candidate = self:NormalizeSecondaryAction(ID, position, {
        context = "secondary_add",
        itemId = itemId,
        itemOnlyWhenItem = true,
    })
    if not candidate then
        return false
    end

    local isItemOnly = candidate.itemId and not candidate.spellId
    local resolveId = self:GetActionResolveId(candidate)
    local displayId = self:GetActionDisplayId(candidate)
    if not resolveId or not displayId then
        return false
    end

    if isItemOnly then
        -- IsUsableItem does not reflect cooldown (returns same on CD or not); use GetItemCooldown for readiness
        if not IsUsableItem(displayId) then
            return false
        end
        if GetItemCooldown then
            local start, duration = GetItemCooldown(displayId)
            if start and duration and duration > 0 and GetTime then
                local nextTime = self.NextTime and self:NextTime() or GetTime()
                if (start + duration) > nextTime then
                    return false
                end
            end
        end
    else
        -- For spells, use IsKnown (not IsKnownSpell) so enchant/tinker spells (e.g. 82174 glove) pass
        if not self:IsKnown(resolveId) or not self:SpellCanCast(resolveId) then
            return false
        end
    end

    -- Check if already present (match by spellId or itemId); use pipeline normalizer
    for i = 1, #self.secondarySpells do
        local entry = self.secondarySpells[i]
        if entry == nil then
            -- skip nil hole
        else
            local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
            local match = norm and (
                (candidate.spellId and norm.spellId == candidate.spellId)
                or (candidate.itemId and norm.itemId == candidate.itemId)
                or (resolveId and (norm.spellId == resolveId or norm.itemId == resolveId))
                or (displayId and (norm.spellId == displayId or norm.itemId == displayId))
            )
            if match then
                if type(entry) == "table" then
                    if candidate.position then entry.position = candidate.position end
                    entry.spellId = candidate.spellId
                    entry.itemId = candidate.itemId
                else
                    -- Defensive: malformed entry; replace with canonical shape
                    self.secondarySpells[i] = candidate
                end
                return true
            end
        end
    end

    tinsert(self.secondarySpells, candidate)
    return false
end

--- Determines if a spell should be used for multidotting without casting it.
--- @param spellId number The ID of the spell.
--- @param maxDots number The maximum number of DoTs allowed.
--- @param maxOverlap number The maximum allowed overlap time in seconds.
--- @param range? number Optional range for target counting.
--- @return boolean True if the spell should be used for multidotting, false otherwise.
--- @usage NAG:ShouldMultidot(8050, 3, 3)
function NAG:ShouldMultidot(spellId, maxDots, maxOverlap, range)
    -- Parameter checks
    if not spellId then
        self:Error(format("ShouldMultidot: No spellId provided"))
        return false
    end

    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("ShouldMultidot: SpellId %s not found in Spell table", tostring(spellId)))
        return false
    end

    if not self:IsKnownSpell(spellId) then
        return false
    end

    -- Get current target info
    local targetGUID = UnitGUID("target")
    if not targetGUID then return false end

    -- Count targets and targets with our debuff using consistent range logic
    local totalTargets = self:NumberTargets(range)
    local targetsWithDebuff = self:NumberTargetsWithDebuff(spellId, range)
    local effectiveMaxDots = min(maxDots, totalTargets)

    -- Check current target's debuff status for casting decisions
    local targetHasDebuff, targetDebuffExpiring = false, false
    local targetDebuffRemaining = self:DotRemainingTime(spellId, "target")

    if targetDebuffRemaining > 0 then
        targetHasDebuff = true
        targetDebuffExpiring = targetDebuffRemaining < maxOverlap
    end

    -- Determine if we should suggest the spell
    local shouldSuggest = false

    if targetDebuffExpiring then
        -- Dot is about to expire, refresh it
        shouldSuggest = true
    elseif not targetHasDebuff or targetsWithDebuff < effectiveMaxDots then
        -- No dot on target and we haven't reached the limit
        -- Or current target has the debuff and it's not expiring,
        -- but check if other targets still need it
        shouldSuggest = targetsWithDebuff < effectiveMaxDots
    end

    return shouldSuggest
end

--- Attempts to cast a spell, trinket, tinker, or item.
--- This is the primary casting API and maps to APLActionCastSpell in Go.
--- @param id number|number[] The ID of the spell, trinket, tinker, or item, or an ordered list of spell IDs to try.
--- @param tolerance number|nil Optional casting tolerance in seconds (default: 0)
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @param hideWhileCasting boolean|nil Optional: if true, returns false if the spell is currently being cast or channeled.
--- @param overlayText string|nil Optional: overlay text to display with the spell cast.
--- @return boolean True if the cast was successful, false otherwise.
--- @usage NAG:CastSpell(12345) -- Normal cast
--- @usage NAG:CastSpell(12345, 0.5) -- With tolerance
--- @usage NAG:CastSpell(12345, nil, ns.SPELL_POSITIONS.RIGHT) -- With position
--- @usage NAG:CastSpell(12345, 0.5, ns.SPELL_POSITIONS.RIGHT) -- With both
--- @usage NAG:CastSpell(12345, nil, nil, nil, "TEXT") -- With overlay text
function NAG:CastSpell(id, tolerance, position, hideWhileCasting, overlayText)
    local TimerManager = ns.TimerManager

    -- Direct parameter assignment (no polymorphic parsing)
    local resetToDefault = false
    local classModule = NAG:GetClassModule()

    -- Direct parameter assignment (no polymorphic parsing)
    tolerance = tolerance or 0
    local overridePosition = position
    local wasExplicitlyOverridden = (position ~= nil)

    if not id then return false end

    -- Check if spell is blacklisted (early exit)
    if self:IsSpellBlacklisted(id) then
        return false
    end

    -- Check if this is the default battle potion and it is blocked (potions are not in spell blacklist dropdown)
    if self:IsPotionBlocked(id) then
        return false
    end

    if type(id) == "table" then
        local selectedId
        for i = 1, #id do
            local candidate = id[i]
            if type(candidate) == "number" then
                local resolvedCandidate = SpellbookManager:ResolveEffectiveSpellID(candidate) or candidate
                if self:IsReady(resolvedCandidate) then
                    selectedId = candidate
                    break
                end
            end
        end

        if not selectedId then
            return false
        end

        id = selectedId
    end

    -- CRITICAL: Check if this cast should interrupt active sequences
    -- Only allow interruption if this is a high-priority spell (cooldowns, etc.)
    -- Skip this check if we're casting from within a sequence context
    if not self._castingFromSequence and NAG.RightSlots and NAG.RightSlots.activeSequence then
        local activeSequenceName = NAG.RightSlots.activeSequence
        local sequenceType = NAG.RightSlots.sequenceType or "unknown"

        -- self:Debug(format("Cast: Checking interruption for spell %d - active sequence: '%s' (type: %s)", id, activeSequenceName, sequenceType))

        -- If this is a StrictSequence, check if it's blocking (forceMain == true) or just visual (forceMain == false)
        if sequenceType == "strict" then
            -- Check if this sequence is set to forceMain (blocking) or not (visual only)
            local forceMainActive = NAG.RightSlots.forceMainActive
            if forceMainActive then
                -- self:Debug(format("Cast: Blocking cast of %d - StrictSequence '%s' is active with forceMain=true", id, activeSequenceName))
                return false
            end
        end

        -- For regular sequences, check if it's blocking (forceMain == true) or just visual (forceMain == false)
        if sequenceType == "regular" then
            -- Check if this sequence is set to forceMain (blocking) or not (visual only)
            local forceMainActive = NAG.RightSlots.forceMainActive
            if forceMainActive then
                -- Check if this is a high-priority spell that should interrupt regular sequences
                local shouldInterrupt = self:ShouldInterruptSequence(id)
                if shouldInterrupt then
                    self:Debug(format(
                        "Cast: Interrupting regular sequence '%s' with high-priority spell %d (forceMain=true)",
                        activeSequenceName, id))

                    -- Store the interrupted sequence state for later restoration
                    self:StoreSequenceState(activeSequenceName)

                    -- Reset the sequence
                    NAG.RightSlots:resetSequence()

                    -- Continue with the cast
                else
                    self:Debug(format("Cast: Blocking cast of %d - Regular sequence '%s' is active with forceMain=true",
                        id, activeSequenceName))
                    return false
                end
            end
        end
    end

    -- Validate ID
    if not tonumber(id) then
        self:Error(format("Cast: spellId %s is not a number", tostring(id)))
        return false
    end

    -- CRITICAL FIX: Resolve APL spell ID to current spellbook ID
    -- This handles cases where APL uses old spell IDs but player has new ones
    -- Examples: Rising Sun Kick (APL: 130320, Current: 107428)
    --           Storm, Earth and Fire (APL: 138228, Current: 137639)
    local originalId = id
    local resolvedId = SpellbookManager:ResolveEffectiveSpellID(id)
    if resolvedId and resolvedId ~= id then
        -- Log the resolution once with all relevant info
        --local spellInfo = WoWAPI.GetSpellInfo(resolvedId)
        ---self:ThrottledDebug(format("Cast: Resolved APL spell %d to current spellbook spell %d ('%s')", originalId, resolvedId, spellInfo and spellInfo.name or "Unknown"), "aplcore_cast", 5)
        id = resolvedId -- Use the resolved ID for all subsequent operations
    end

    -- Auto-enable hideWhileCasting for plain Cast calls when the spell has both:
    -- 1) cast/channel time, and 2) a real base cooldown (above GCD).
    -- Skip when hideWhileCasting was explicitly provided (e.g. NotSpamCast already sets true).
    if hideWhileCasting == nil and type(id) == "number" then
        local hasCastTime = (self:SpellCastTime(id) or 0) > 0
        local baseCooldownMS = _G.GetSpellBaseCooldown and _G.GetSpellBaseCooldown(id)
        local fullCd = (type(baseCooldownMS) == "number" and baseCooldownMS > 0) and (baseCooldownMS / 1000) or 0
        local gcdVal = (self.GCDTimeValue and self:GCDTimeValue()) or 1.5
        if fullCd > gcdVal then
            spellIdsWithCooldown[id] = true
        end
        if hasCastTime and spellIdsWithCooldown[id] then
            hideWhileCasting = true
        end
    end

    -- Check if spell should be hidden while currently casting/channeling
    if hideWhileCasting then
        local spellInfo = WoWAPI.GetSpellInfo(id)
        local spellName = spellInfo and spellInfo.name or nil

        -- Check if currently casting the spell
        local cName, _, _, _, _, _, _, _, cId = UnitCastingInfo and UnitCastingInfo("player") or nil
        -- Check if currently channeling the spell
        local chName, _, _, _, _, _, _, chId = UnitChannelInfo and UnitChannelInfo("player") or nil

        -- Match by spell ID or spell name (handles edge cases)
        if (cId and cId == id) or (chId and chId == id) or
           (cName and spellName and cName == spellName) or
           (chName and spellName and chName == spellName) then
            -- Currently casting/channeling this spell, return false to hide it
            return false
        end
    end

    -- Validate position if provided (now expects NAG.SPELL_POSITIONS constants)
    if overridePosition then
        -- Position should already be a valid NAG.SPELL_POSITIONS constant value
        if not ns.IsValidSpellPosition(overridePosition) then
            self:Error(format(
                "Cast: Invalid position '%s'. Use NAG.SPELL_POSITIONS constants (LEFT, RIGHT, ABOVE, BELOW, AOE, PRIMARY, SEQUENCE)",
                tostring(overridePosition)))
            return false
        end
    end

    -- Determine final position: explicit override or cached lookup (single assignment)
    local finalPosition = overridePosition
    if not finalPosition then
        -- CRITICAL: Skip position lookup if this is a StrictSequence call
        if self._castingFromStrictSequence then
            finalPosition = nil -- Let StrictSequence handle its own positioning
        else
            -- Use centralized SpellbookManager for O(1) lookups
            finalPosition = SpellbookManager:GetSpellPosition(id)
        end
    end

    -- SEQUENCE position handling removed - sequence spells are managed exclusively through NAG.RightSlots.sequence

    -- Resolve spell ID using centralized resolution function
    id = EnhancedAuraHandlers:ResolveSpellIdForCasting(id)

    -- Execute phase gating (including special logic)
    if not NAG:CanExecuteSpell(id, "target", tolerance) then
        return false
    end

    -- PREDICTION QUEUE: Check if we're in simulation mode and this spell was already cast
    if StateManager then
        local simulatedCastedSpells = StateManager.simulatedCastedSpells
        if simulatedCastedSpells and simulatedCastedSpells[id] then
            -- This spell was already "cast" in simulation - skip it to get next spell
            return false
        end
    end

    -- Try to find entity in DataManager
    local entityItem = DataManager:Get(id, DataManager.EntityTypes.ITEM)
    local entitySpell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    local entity = (entityItem and entitySpell and isItemConsumable(id)) and entityItem or (entitySpell or entityItem)
    if not entity then
        -- If not found, try to resolve by name as a last resort
        -- Note: Spell ID resolution already happened above, so this is just a fallback

        -- Fallback to direct API lookup
        local spellInfo = WoWAPI.GetSpellInfo(id)
        if spellInfo and spellInfo.name then
            local spellInfo2 = WoWAPI.GetSpellInfo(spellInfo.name)
            if spellInfo2 and spellInfo2.name then
                local spellID = spellInfo2.spellID
                if spellID then
                    self:Info(format("Cast: Fallback resolution: spell %d resolved to %d via direct API", id, spellID))
                    -- Store overlay before returning (fallback skips normal overlay block)
                    if overlayText and overlayText ~= "" then
                        self.castOverlayTexts = self.castOverlayTexts or {}
                        self.castOverlayTexts[id] = overlayText
                        self.castOverlayTexts[spellID] = overlayText
                        if originalId and originalId ~= id and originalId ~= spellID then
                            self.castOverlayTexts[originalId] = overlayText
                        end
                    end
                    return self:_CastSpell(spellID, tolerance)
                end
            end
        end

        self:Error(format("Cast: ID %s not found in DataManager or resolvable by name", tostring(id)))
        return false
    end

    -- Seed cooldown cache from schema-backed spell data when available.
    if entity.IsSpell and entity.cooldown then
        local cooldownSeconds = (type(entity.cooldown) == "table" and entity.cooldown.seconds) or entity.cooldown
        if type(cooldownSeconds) == "number" and cooldownSeconds > 0 then
            spellIdsWithCooldown[id] = true
        end
    end

    -- self:Debug(format("🔍 SPELL_POSITION_DEBUG: Spell %d - Original position in DataManager: '%s'", id, tostring(originalPosition)))

    -- Check spell requirements using DB2-generated data (if enabled)
    if ns.USE_REQUIREMENTS_CHECKER then
        if RequirementsChecker then
            local canCast, errorMsg = RequirementsChecker:CanCastSpell(id)
            if not canCast then
                --self:Error(format("Cast: Spell %s cannot be cast: %s", tostring(id), errorMsg or "Unknown requirement"))
                return false
            end
        end
    end

    -- Block stance spells if we're already in the stance (prevent recasting)
    -- This check is independent of enableStances setting - we never want to recast a stance we're already in
    if entity.shapeshiftForm then
        local currentForm = StateManager:GetShapeshiftFormID()
        if currentForm and currentForm == entity.shapeshiftForm then
            -- We're already in this form, don't allow recasting the stance
            return false
        end
    end

    -- Only block stance spells if stances are explicitly disabled AND this is a stance-switching spell
    -- (not just a spell that happens to have a stance flag for form detection)
    if entity.flags.stance and not (classModule and classModule.db.char.enableStances) and entity.shapeshiftForm then
        -- This is a stance-switching spell and stances are disabled
        return false
    end

    -- Add spell to secondarySpells if it's a secondary position
    if finalPosition and finalPosition ~= ns.SPELL_POSITIONS.PRIMARY and not self._castingFromStrictSequence then
        -- This is a secondary position, add to secondarySpells with position
        self:AddSecondarySpell(id, finalPosition)
    end

    -- If the caller explicitly requested a secondary position (LEFT/RIGHT/ABOVE/BELOW/AOE),
    -- that override must take priority over any preselected spell-location preset.
    -- In particular, we must NOT allow _CastSpell() to set nextSpell (PRIMARY) for an explicitly-secondary action.
    local explicitSecondaryOverride = (wasExplicitlyOverridden == true)
        and finalPosition
        and (finalPosition ~= ns.SPELL_POSITIONS.PRIMARY)
        and (not self._castingFromStrictSequence)

    -- Right-side slot management logic - MOVED HERE after all validation checks
    if finalPosition == ns.SPELL_POSITIONS.RIGHT then
        -- Check if a regular RIGHT spell is already occupying the slot
        if NAG.RightSlots.regular then
            -- Slot is already occupied by a regular spell, ignore this cast
            --self:Debug(format("Cast: RIGHT slot already occupied, ignoring spell %d", id))
            return false
        end
        -- Mark the slot as occupied by a regular spell - only if we're about to actually cast
        NAG.RightSlots.regular = true
        -- self:Debug(format("Cast: Registered spell %d in RIGHT slot", id))
    end

    local result = false

    -- Handle different entity types
    if entity.IsItem then
        result = entity:CastSpell()
    elseif entity.IsSpell then
        -- Check if this is a stance spell and we're already in the required form
        if entity.flags.stance and entity.shapeshiftForm and StateManager:GetShapeshiftFormID() == entity.shapeshiftForm then
            -- We're already in the required form, so don't cast the stance spell again
            result = false
        elseif entity.flags.tinker then
            result = self:CastTinker(id)
        elseif entity.flags.battlepet then
            result = entity:CastSpell()
        else
            if explicitSecondaryOverride then
                -- Display-only action: already queued into secondarySpells with the intended position.
                -- Do not run _CastSpell() because it can promote the spell to nextSpell (PRIMARY)
                -- based on spell-location presets, which would override the explicit position.
                result = false
            else
                -- Pass forceMain parameter if position is explicitly set to PRIMARY
                local forceMain = (finalPosition == ns.SPELL_POSITIONS.PRIMARY)
                result = self:_CastSpell(id, tolerance, forceMain)
            end
        end
    else
        self:Error(format("Cast: Unknown entity type for ID %s", tostring(id)))
        result = false
    end

    -- CRITICAL FIX: Handle return value logic based on position type (but not for StrictSequences)
    -- This must happen AFTER the actual casting logic to ensure proper spell validation
    if not self._castingFromStrictSequence then
        local isPrimaryPosition = (finalPosition == ns.SPELL_POSITIONS.PRIMARY or not finalPosition)
        local isSecondaryPosition = finalPosition and finalPosition ~= ns.SPELL_POSITIONS.PRIMARY

        if isSecondaryPosition then
            -- Secondary positions always return false (they're for display only)
            -- BUT: The spell was still validated by the casting logic above
            result = false
        end
    end

    -- If the cast failed and we marked the RIGHT slot as occupied, clear it
    if not result and finalPosition == ns.SPELL_POSITIONS.RIGHT and NAG.RightSlots.regular then
        NAG.RightSlots.regular = false
        -- self:Debug(format("Cast: Cleared RIGHT slot for failed spell %d", id))
    end


    -- Handle overlay text storage and display
    if overlayText and overlayText ~= "" then
        -- Cast overlays have priority: clear any custom primary overlay to avoid overlapping text.
        self:ClearCustomOverlay()

        -- Clear overlay text for previous nextSpell if this is becoming the new nextSpell
        local previousPrimaryId = self.GetActionResolveId and self:GetActionResolveId(self.nextSpell)
            or (self.GetActionDisplayId and self:GetActionDisplayId(self.nextSpell))
        if result and previousPrimaryId and previousPrimaryId ~= id then
            self:ClearCastOverlayText(previousPrimaryId)
        end

        -- Store overlay text for this spell ID (and original if resolved, for display lookup parity)
        self.castOverlayTexts[id] = overlayText
        if originalId and originalId ~= id then
            self.castOverlayTexts[originalId] = overlayText
        end

        -- For primary actions (result == true), display overlay text immediately
        if result then
            -- Determine the position for overlay text display
            local overlayPosition = "primary"
            if finalPosition and finalPosition ~= ns.SPELL_POSITIONS.PRIMARY then
                -- Convert spell position to overlay text position format
                if finalPosition == ns.SPELL_POSITIONS.LEFT then
                    overlayPosition = "left1"
                elseif finalPosition == ns.SPELL_POSITIONS.RIGHT then
                    overlayPosition = "right1"
                elseif finalPosition == ns.SPELL_POSITIONS.ABOVE then
                    overlayPosition = "above1"
                elseif finalPosition == ns.SPELL_POSITIONS.BELOW then
                    overlayPosition = "below1"
                elseif finalPosition == ns.SPELL_POSITIONS.AOE then
                    overlayPosition = "aoe"
                else
                    overlayPosition = "primary"
                end
            end

            -- Display overlay text with a check function to hide when spell is no longer active
            self:OverlayText(overlayText, {
                position = overlayPosition,
                id = overlayPosition .. "_cast",
                spellId = id
            })
        end
        -- For secondary actions (result == false), overlay text will be displayed
        -- during UI updates when the spell is actually shown (handled in DisplayManager/Common)
    elseif overlayText == nil or overlayText == "" then
        -- Clear overlay text if explicitly set to nil/empty
        self:ClearCastOverlayText(id)
        if originalId and originalId ~= id then
            self:ClearCastOverlayText(originalId)
        end
    end

    return result
end


--- Convenience function to cast a spell with hideWhileCasting automatically enabled.
--- Prevents the spell from being displayed repeatedly while it's already casting/channeling.
--- This is equivalent to calling NAG:CastSpell(id, tolerance, position, true).
--- @param id number|number[] The ID of the spell, trinket, tinker, or item, or an ordered list of spell IDs to try.
--- @param tolerance number|nil Optional casting tolerance in seconds (default: 0)
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @return boolean True if the cast was successful, false otherwise.
--- @usage NAG:NotSpamCast(12345) -- Cast without showing if already casting
--- @usage NAG:NotSpamCast(12345, 0.5) -- With tolerance
--- @usage NAG:NotSpamCast(12345, nil, ns.SPELL_POSITIONS.RIGHT) -- With position
function NAG:NotSpamCast(id, tolerance, position)
    return self:CastSpell(id, tolerance, position, true)
end


-- ============================ ARROW OVERLAY CASTS ============================

local function NormalizeArrowOrientation(orientation)
    if type(orientation) ~= "string" then
        return "RIGHT"
    end
    local upper = string.upper(orientation)
    if upper == "LEFT" then
        return "LEFT"
    end
    return "RIGHT"
end

local function GetArrowTextureCoords(orientation)
    if orientation == "LEFT" then
        return { 1, 0, 0, 1 }
    end
    return { 0, 1, 0, 1 }
end

local function ResolveArrowAnchorConfig(orientation)
    if orientation == "LEFT" then
        return {
            point = "LEFT",
            relativePoint = "LEFT",
            xOffset = -8,
            yOffset = 0,
        }
    end
    return {
        point = "RIGHT",
        relativePoint = "RIGHT",
        xOffset = 8,
        yOffset = 0,
    }
end

local function ResolveArrowFrames(position)
    if position == nil or position == ns.SPELL_POSITIONS.PRIMARY then
        if ns.DisplayManager and ns.DisplayManager.GetActivePrimaryFrames then
            return ns.DisplayManager:GetActivePrimaryFrames()
        end
        return {}
    end

    local resolvedPosition = position
    if position == ns.SPELL_POSITIONS.LEFT then
        resolvedPosition = "left1"
    elseif position == ns.SPELL_POSITIONS.RIGHT then
        resolvedPosition = "right1"
    elseif position == ns.SPELL_POSITIONS.ABOVE then
        resolvedPosition = "above1"
    elseif position == ns.SPELL_POSITIONS.BELOW then
        resolvedPosition = "below1"
    elseif position == ns.SPELL_POSITIONS.AOE then
        resolvedPosition = "aoe"
    end

    if NAG.Frame and NAG.Frame.iconFrames then
        local frame = NAG.Frame.iconFrames[resolvedPosition]
        if frame then
            return { frame }
        end
    end

    return {}
end

--- Shows an arrow overlay on the frame where a spell is displayed.
--- @param spellId number The spell ID to match against the frame.
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @param orientation string|nil "LEFT" or "RIGHT" (default: "RIGHT")
--- @param durationSeconds number|nil Optional minimum time to keep the arrow visible.
--- @param requireSpellMatch boolean|nil If false, only checks frame visibility (default: true).
--- @return nil
function NAG:ShowArrowOverlay(spellId, position, orientation, durationSeconds, requireSpellMatch)
    if not spellId or not ns.OverlayManager then
        return
    end

    local arrowOrientation = NormalizeArrowOrientation(orientation)
    local textureCoords = GetArrowTextureCoords(arrowOrientation)
    local anchorConfig = ResolveArrowAnchorConfig(arrowOrientation)
    local frames = ResolveArrowFrames(position)
    if not frames or #frames == 0 then
        return
    end

    local shouldMatchSpell = requireSpellMatch ~= false
    local now = GetTime()
    local expiresAt = now + (durationSeconds or 0.75)

    for _, frame in ipairs(frames) do
        if frame and frame.GetName then
            local spellIdForCheck = spellId
            local function checkFunc()
                if not frame or not frame:IsShown() then
                    return false
                end
                if GetTime() >= expiresAt then
                    return false
                end
                if not shouldMatchSpell then
                    return true
                end
                if frame.spellId and frame.spellId == spellIdForCheck then
                    return true
                end
                if frame.id and frame.id == spellIdForCheck then
                    return true
                end
                return false
            end

            ns.OverlayManager:ShowOverlay(frame, "callarrow", nil, checkFunc, {
                spellId = spellId,
                texture = "Interface\\AddOns\\NAG\\Media\\Textures\\arrowSeq.png",
                textureCoords = textureCoords,
                point = anchorConfig.point,
                relativePoint = anchorConfig.relativePoint,
                xOffset = anchorConfig.xOffset,
                yOffset = anchorConfig.yOffset,
            })
        end
    end
end

--- Convenience function to cast a spell and show an arrow overlay on its icon.
--- @param id number The ID of the spell, trinket, tinker, or item.
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @param orientation string|nil "LEFT" or "RIGHT" (default: "RIGHT")
--- @param durationSeconds number|nil Optional minimum time to keep the arrow visible.
--- @return boolean True if the cast was successful, false otherwise.
--- @usage NAG:CastWithArrow(12345, ns.SPELL_POSITIONS.RIGHT, "LEFT")
function NAG:CastWithArrow(id, position, orientation, durationSeconds)
    local result = self:CastSpell(id, nil, position)
    if type(id) == "number" then
        self:ShowArrowOverlay(id, position, orientation, durationSeconds, true)
    end
    return result
end

--- Convenience function to add a placeholder spell and show an arrow overlay on its icon.
--- @param id number The ID of the spell to place.
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @param orientation string|nil "LEFT" or "RIGHT" (default: "RIGHT")
--- @param durationSeconds number|nil Optional minimum time to keep the arrow visible.
--- @return boolean True if the placeholder was applied to PRIMARY, false otherwise.
--- @usage NAG:CastPlaceholderWithArrow(6603, ns.SPELL_POSITIONS.PRIMARY, "RIGHT")
function NAG:CastPlaceholderWithArrow(id, position, orientation, durationSeconds)
    local result = self:CastPlaceholder(id, nil, position)
    if type(id) == "number" then
        self:ShowArrowOverlay(id, position, orientation, durationSeconds, false)
    end
    return result
end

--- Legacy alias for CastPlaceholderWithArrow (kept for naming consistency).
--- @param id number The ID of the spell to place.
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @param orientation string|nil "LEFT" or "RIGHT" (default: "RIGHT")
--- @param durationSeconds number|nil Optional minimum time to keep the arrow visible.
--- @return boolean True if the placeholder was applied to PRIMARY, false otherwise.
function NAG:CastPlaceHolderWithArrow(id, position, orientation, durationSeconds)
    return self:CastPlaceholderWithArrow(id, position, orientation, durationSeconds)
end

--- Convenience function to cast a spell with overlay text.
--- This is equivalent to calling NAG:CastSpell(id, nil, position, nil, text).
--- @param id number|number[] The ID of the spell, trinket, tinker, or item, or an ordered list of spell IDs to try.
--- @param text string The overlay text to display with the spell cast.
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @return boolean True if the cast was successful, false otherwise.
--- @usage NAG:CastWithOverlay(12345, "BURST") -- Cast with overlay text
--- @usage NAG:CastWithOverlay(12345, "BURST", ns.SPELL_POSITIONS.RIGHT) -- Cast with overlay text at specific position
function NAG:CastWithOverlay(id, text, position)
    if not id then
        self:Error("CastWithOverlay: id is required")
        return false
    end
    if not text or text == "" then
        self:Error("CastWithOverlay: text is required")
        return false
    end
    return self:CastSpell(id, nil, position, nil, text)
end

--- Convenience function to cast a spell with overlay text AND a swing-timer swipe overlay.
--- This is intended for "hold/pool" placeholders where the desired visualization is
--- "wait until next auto attack" rather than a spell cooldown.
--- @param id number|number[] The spell/item id (typically 6603 for Auto Attack placeholders).
--- @param text string The overlay text to display.
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @return boolean True if the cast was successful, false otherwise.
--- @usage NAG:CastWithSwingOverlay(6603, "Pooling\\nRage")
function NAG:CastWithSwingOverlay(id, text, position)
    local result = self:CastWithOverlay(id, text, position)

    if not self.castOverlaySwipes then
        self.castOverlaySwipes = {}
    end
    if not self.castOverlaySwipesExpiresAt then
        self.castOverlaySwipesExpiresAt = {}
    end

    if type(id) == "table" then
        -- If a list was passed, only mark Auto Attack (6603). (We only support swing overlay for 6603.)
        for _, sid in ipairs(id) do
            if sid == 6603 then
                self.castOverlaySwipes[sid] = "swing"
                self.castOverlaySwipesExpiresAt[sid] = GetTime() + SWING_OVERLAY_TTL_SECONDS
            end
        end
    else
        if id == 6603 then
            self.castOverlaySwipes[id] = "swing"
            self.castOverlaySwipesExpiresAt[id] = GetTime() + SWING_OVERLAY_TTL_SECONDS
        end
    end

    return result
end

--- Cast a spell and, once casting/channeling begins, immediately queue a follow-up
--- spell as the next primary action (casters only). This temporarily forces both
--- spells to display in the PRIMARY slot.
--- @param id1 number The spell ID to cast first
--- @param id2 number The spell ID to show as primary while id1 is being cast/channelled
--- @return boolean True if the first cast was accepted as main, false otherwise
function NAG:CastWithSecondary(id1, id2)
    if not id1 or not id2 then
        self:Error("CastWithSecondary: id1 and id2 are required")
        return false
    end

    local TimerManager = ns.TimerManager

    -- Force the first spell into PRIMARY
    local firstResult = self:CastSpell(id1, nil, ns.SPELL_POSITIONS.PRIMARY)

    -- If the player starts casting/channeling id1, immediately show id2 as PRIMARY
    local spellInfo = WoWAPI.GetSpellInfo(id1)
    local id1Name = spellInfo and spellInfo.name or nil
    local function showSecondIfCasting()
        local cName, _, _, _, _, _, _, _, cId = UnitCastingInfo and UnitCastingInfo("player") or nil
        local chName, _, _, _, _, _, _, chId = UnitChannelInfo and UnitChannelInfo("player") or nil
        if (cId and cId == id1) or (chId and chId == id1) or (cName and id1Name and cName == id1Name) or (chName and id1Name and chName == id1Name) then
            self:CastSpell(id2, nil, ns.SPELL_POSITIONS.PRIMARY)
        end
    end

    -- Try immediately in case we're already in casting state
    showSecondIfCasting()

    -- Also schedule a short delayed retry so the casting state is detectable
    local timerName = "CastWithSecondary_" .. tostring(id1) .. "_" .. tostring(id2)
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, timerName)
    TimerManager:Create(TimerManager.Categories.UI_NOTIFICATION, timerName, showSecondIfCasting, 0.05, false)

    return firstResult
end

--- Placeholder helper that also assigns cast overlay text.
--- Unlike CastSpell(), this bypasses readiness/validation and is safe to use for
--- out-of-combat reminders (e.g. weapon poisons) where we still want the icon +
--- overlay text to display reliably even without a target.
---
--- @param id number The spell or item ID to display.
--- @param text string The overlay text to display.
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants).
--- @return boolean True if displayed as PRIMARY, false if displayed as secondary.
--- @usage NAG:CastPlaceholderWithOverlay(22054, "OH") -- Deadly Poison VII reminder
function NAG:CastPlaceholderWithOverlay(id, text, position)
    if not id then
        self:Error("CastPlaceholderWithOverlay: id is required")
        return false
    end
    if not text or text == "" then
        self:Error("CastPlaceholderWithOverlay: text is required")
        return false
    end

    local result = self:CastPlaceholder(id, nil, position)

    -- Ensure overlay text is available for DisplayManager to render.
    self.castOverlayTexts = self.castOverlayTexts or {}

    -- Placeholders should override any custom primary overlay text (same behavior as CastSpell overlays).
    if self.ClearCustomOverlay then
        self:ClearCustomOverlay()
    end

    self.castOverlayTexts[id] = text
    -- Store under resolved id too (CastPlaceholder may resolve 6603 etc.; display uses resolved id for lookup)
    local resolvedId = SpellbookManager and SpellbookManager.ResolveEffectiveSpellID and SpellbookManager:ResolveEffectiveSpellID(id)
    if resolvedId and resolvedId ~= id then
        self.castOverlayTexts[resolvedId] = text
    end
    return result
end

--- Backward-compatible placeholder alias with extended argument support.
--- Accepts Cast-like shape:
--- `spellId, tolerance, position, overlayType, overlayText`.
--- This wrapper preserves CastPlaceholder semantics and only adds optional overlay text support.
--- @param spellId number The ID of the spell to display.
--- @param tolerance number|nil Optional casting tolerance (passed through).
--- @param position string|nil Optional position override.
--- @param overlayType string|nil Reserved for compatibility (currently ignored).
--- @param overlayText string|nil Optional overlay text to assign.
--- @return boolean
function NAG:CastPlaceHolder(spellId, tolerance, position, overlayType, overlayText)
    local result = self:CastPlaceholder(spellId, tolerance, position)
    if not result and (position and position ~= ns.SPELL_POSITIONS.PRIMARY) then
        -- Secondary placeholder insertions intentionally return false.
        -- Keep processing so overlay text can still be attached when requested.
    end

    if spellId and overlayText and overlayText ~= "" then
        self.castOverlayTexts = self.castOverlayTexts or {}
        self.castOverlayTexts[spellId] = overlayText
    end

    return result
end

--- Attempts to cast the specified spell and sets it as the next spell to cast.
--- This is a placeholder function that bypasses normal validation checks but supports position overrides.
--- @param spellId number The ID of the spell to cast.
--- @param tolerance number|nil Optional casting tolerance in seconds (default: 0)
--- @param position string|nil Optional position override (use NAG.SPELL_POSITIONS constants)
--- @return boolean True if the spell ID is valid and set, false otherwise.
function NAG:CastPlaceholder(spellId, tolerance, position)
    -- Direct parameter assignment (no polymorphic parsing)
    tolerance = tolerance or 0
    local overridePosition = position

    if not spellId then return false end

    -- Resolve APL spell ID to current spellbook ID (same as CastSpell)
    if SpellbookManager and SpellbookManager.ResolveEffectiveSpellID then
        local resolvedId = SpellbookManager:ResolveEffectiveSpellID(spellId)
        if resolvedId and resolvedId ~= spellId then
            spellId = resolvedId
        end
    end

    -- Determine final position: explicit override or cached lookup (same logic as NAG:Cast)
    local finalPosition = overridePosition
    if not finalPosition then
        -- Use centralized SpellbookManager for O(1) lookups
        finalPosition = SpellbookManager:GetSpellPosition(spellId)
    end

    -- Determine return value based on position
    local shouldReturnTrue
    if finalPosition and finalPosition ~= ns.SPELL_POSITIONS.PRIMARY then
        -- This is a secondary position, add to secondarySpells with position
        -- CastPlaceholder: Add directly to table without validation (unlike regular AddSecondarySpell)
        -- Check for duplicates first; all entries are canonical tables at runtime
        local alreadyPresent = false
        for i = 1, #self.secondarySpells do
            local entry = self.secondarySpells[i]
            if entry == nil then
                -- skip nil hole
            else
                local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
                if norm and (norm.spellId == spellId or (norm.itemId and norm.itemId == spellId)) then
                    if type(entry) == "table" then
                        entry.position = finalPosition
                    else
                        -- Defensive: malformed entry; replace with canonical shape
                        self.secondarySpells[i] = self:NormalizeSecondaryAction(spellId, finalPosition, {
                            context = "cast_placeholder_secondary",
                        })
                    end
                    alreadyPresent = true
                    break
                end
            end
        end

        if not alreadyPresent then
            local normalizedSecondary = self:NormalizeSecondaryAction(spellId, finalPosition, {
                context = "cast_placeholder_secondary",
            })
            if normalizedSecondary then
                tinsert(self.secondarySpells, normalizedSecondary)
            end
        end

        shouldReturnTrue = false
    else
        -- This is a PRIMARY position, set as nextSpell (core placeholder functionality)
        self.nextSpell = self:NormalizePrimaryAction(spellId, { context = "cast_placeholder_primary" })
        shouldReturnTrue = true
    end

    return shouldReturnTrue
end

-- Table of execute-phase spells and their thresholds (MoP+)
-- Shadow Word: Death (32379) is gated by execute only in Cata+; Classic/TBC/WotLK handle it in APL (see CanExecuteSpell).
local EXECUTE_SPELLS = {
    [5308]   = 20, -- Execute (Warrior)
    [53351]  = 20, -- Kill Shot (Hunter)
    [24275]  = 20, -- Hammer of Wrath (Paladin)
    [32379]  = 20, -- Shadow Word: Death (Priest) - execute gate applied only when not Classic/TBC/WotLK
    [17877]  = 25, -- Shadowburn (Warlock)
    -- [1120]   = 20,  -- Drain Soul (Warlock)
    [115080] = 10, -- Touch of Death (Monk) -- handled specially below
    [111240] = 35, -- Dispatch (Rogue)
    --[22568]  = 25,  -- Ferocious Bite (Druid, with Blood in the Water)
    --[114866] = 35,  -- Soul Reaper (Death Knight)
}

--- Checks if a spell can be executed on the current target, including special logic for Touch of Death/Hammer of Wrath/Dispatch
--- @param spellId number The spell ID to check.
--- @param unit string The unit to check (default: "target").
--- @param tolerance number|nil Optional tolerance in seconds to apply to readiness checks
--- @return boolean True if the spell can be executed, false otherwise.
--- @local Internal utility function for spell management
function NAG:CanExecuteSpell(spellId, unit, tolerance)
    unit = unit or "target"

    if spellId == 115080 then -- Touch of Death (Monk)
        if UnitIsPlayer(unit) then
            local healthPercent = (UnitHealth(unit) / UnitHealthMax(unit)) * 100
            return healthPercent <= 10
        else
            return UnitHealth(unit) <= UnitHealth("player")
        end
    end

    -- Paladin HoW (Retribution only) - Retribution is specIndex 3 for Paladin
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if spellId == 24275 and NAG:AuraIsActive(31884) and specIndex == 3 then
        return NAG:SpellCanCast(spellId, tolerance)
    end
    if spellId == 111240 and NAG:AuraIsActive(121153) then -- rogue dispatch
        return NAG:SpellCanCast(spellId, tolerance)
    end
    -- Shadow Word: Death (32379): not execute-gated in Classic Era, SoD, TBC, or WotLK; APL controls usage there.
    if (spellId == 32379 or spellId == 32996 or GetSpellInfo(spellId) == GetSpellInfo(32996)) and Version then
        if (Version.IsClassicEra and Version:IsClassicEra())
            or (Version.IsSoD and Version:IsSoD())
            or (Version.IsTBC and Version:IsTBC())
            or (Version.IsWrath and Version:IsWrath()) then
            return NAG:SpellCanCast(spellId, tolerance)
        end
    end
    local threshold = EXECUTE_SPELLS[spellId]
    if threshold then
        return NAG:IsExecutePhase(threshold)
    end
    return true -- Not an execute spell, always allowed
end
