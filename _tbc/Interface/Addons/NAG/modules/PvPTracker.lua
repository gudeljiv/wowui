--- @module "NAG.PvPTracker"
--- Optional PvP module for enemy cooldown tracking, DR display, and PvP-aware rotations.
---
--- Tracks enemy cooldowns via CLEU, diminishing returns on CC, and provides APL value
--- functions for PvP-specific rotation conditions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local L = ns.AceLocale:GetLocale("NAG", true)

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs
local format = string.format
local strmatch = string.match
local wipe = wipe
local type = type
local tostring = tostring

-- WoW APIs
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local UnitExists = _G.UnitExists
local CreateFrame = _G.CreateFrame
local GetSpellTexture = (C_Spell and C_Spell.GetSpellTexture) or _G.GetSpellTexture

local WoWAPI = ns.WoWAPI

-- ============================ DEFAULTS ============================

-- Category colors for borders (RGBA 0-1)
local DEFAULT_CATEGORY_COLORS = {
    interrupt = { 1, 0.3, 0.3, 1 },
    defensive = { 0.3, 1, 0.3, 1 },
    cc = { 0.3, 0.5, 1, 1 },
}

-- Order for category sort: interrupt first, then defensive, then cc
local CATEGORY_SORT_ORDER = { interrupt = 1, defensive = 2, cc = 3 }

local defaults = {
    char = {
        enabled = false,
        displaySettings = {
            position = {
                point = "CENTER",
                relativePoint = "CENTER",
                x = 0,
                y = 150,
            },
            scale = 1.0,
            iconSize = 32,
            layoutDirection = "horizontal",
            showCooldowns = true,
            showDR = true,
            showInterrupts = true,
            showDefensives = true,
            showCC = true,
            maxDisplayIcons = 12,
            advancedSettings = false,
            enableCooldownSwipes = true,
            showCategoryBorders = true,
            showTooltips = true,
            showArenaBadge = true,
            iconSort = "time",
            showDROverlay = true,
            showBurstIndicator = false,
            showVulnerableHighlight = true,
            showImmunityWarning = true,
            showSafeToCast = false,
            showDampening = false,
            categoryColors = DEFAULT_CATEGORY_COLORS,
            interruptSoundEnabled = true,
            interruptSoundKit = "RaidWarning",
            enableInDuels = true,
        },
    },
    global = {
        trackedSpells = {},
    },
}

-- ============================ MODULE CREATION ============================

--- @class PvPTracker : CoreModule
local PvPTracker = NAG:CreateModule("PvPTracker", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,

    eventHandlers = {
        PLAYER_ENTERING_WORLD = true,
        ZONE_CHANGED_NEW_AREA = true,
        PLAYER_TARGET_CHANGED = true,
        PLAYER_FOCUS_CHANGED = true,
        DUEL_REQUESTED = true,
        DUEL_FINISHED = true,
        MODIFIER_STATE_CHANGED = "OnModifierStateChanged",
    },

    messageHandlers = {
        NAG_FRAME_UPDATED = true,
    },

    cleuHandlers = {
        SPELL_CAST_START = "HandleCLEUSpellCastStart",
        SPELL_CAST_SUCCESS = "HandleCLEUSpellCastSuccess",
        SPELL_INTERRUPT = "HandleCLEUSpellInterrupt",
        SPELL_AURA_APPLIED = "HandleCLEUAuraApplied",
        SPELL_AURA_REFRESH = "HandleCLEUAuraApplied",
        SPELL_AURA_REMOVED = "HandleCLEUAuraRemoved",
    },


    slashCommands = {
        ["pvp"] = {
            handler = "HandlePvPSlashCommand",
            help = "Toggle PvP Tracker or open options. Usage: /nag pvp [on|off|toggle|options]",
            root = "nag",
        },
    },

    preservationGroups = {
        ["pvpTrackerSettings"] = {
            name = L["PvP Tracker Settings"] or "PvP Tracker Settings",
            description = L["Preserve PvP tracker display and tracking preferences during resets"] or "Preserve PvP tracker display and tracking preferences during resets",
            settings = {
                char = { "enabled", "displaySettings" },
                global = { "trackedSpells" },
            },
            alwaysPreserve = false,
        },
    },

    debugCategories = { ns.DEBUG_CATEGORIES.TRACKERS, ns.DEBUG_CATEGORIES.FEATURES },

    defaultState = {
        enemyCooldowns = {},
        drState = {},
        arenaUnitToGUID = {},
        guidToArenaUnit = {},
        enemyCasting = nil,
        duelActive = false,
        duelOpponentGUID = nil,
        duelOpponentName = nil,
    },
})

ns.PvPTracker = PvPTracker

-- ============================ LIFECYCLE ============================

function PvPTracker:ModuleInitialize()
    -- Placeholder for initialization
end

function PvPTracker:ModuleEnable()
    self:RefreshArenaMapping()
    self:ClearStaleData()
    self:CreateDisplayFrame()
    self:StartDisplayUpdate()
end

function PvPTracker:ModuleDisable()
    self:StopDisplayUpdate()
    self:ClearStaleData()
    if self.displayFrame and self.displayFrame.Hide then
        self.displayFrame:Hide()
    end
end

-- ============================ EVENT HANDLERS ============================

--- Returns true if duel tracking is active and enabled in settings.
--- @return boolean
function PvPTracker:IsDuelTrackingActive()
    local ds = self.db and self.db.char and self.db.char.displaySettings or {}
    return ds.enableInDuels ~= false and self.state and self.state.duelActive == true
end

--- Returns true if tracker should run updates in current context.
--- @return boolean
function PvPTracker:IsTrackingContextActive()
    if ns.IsInPvP and ns.IsInPvP() then
        return true
    end
    return self:IsDuelTrackingActive()
end

--- Resolve duel opponent from target/focus when available.
function PvPTracker:RefreshDuelOpponentFromUnits()
    if not self.state then return end
    local playerGUID = NAG.state and NAG.state.player and NAG.state.player.guid
    local targetGUID = UnitExists("target") and UnitGUID("target") or nil
    if targetGUID and targetGUID ~= playerGUID then
        self.state.duelOpponentGUID = targetGUID
        return
    end
    local focusGUID = UnitExists("focus") and UnitGUID("focus") or nil
    if focusGUID and focusGUID ~= playerGUID then
        self.state.duelOpponentGUID = focusGUID
    end
end

--- Track duel lifecycle.
--- @param event string
--- @param challengerName string|nil
function PvPTracker:DUEL_REQUESTED(event, challengerName)
    if not self.state then return end
    self.state.duelActive = true
    self.state.duelOpponentName = type(challengerName) == "string" and challengerName or nil
    self:RefreshDuelOpponentFromUnits()
    self:ClearStaleData()
end

--- @param event string
--- @param winner number|string|nil
function PvPTracker:DUEL_FINISHED(event, winner)
    if not self.state then return end
    self.state.duelActive = false
    self.state.duelOpponentGUID = nil
    self.state.duelOpponentName = nil
    self.state.enemyCasting = nil
    self.state.enemyCooldowns = {}
    self.state.drState = {}
    if self.displayFrame and not (ns.IsInPvP and ns.IsInPvP()) then
        self.displayFrame:Hide()
    end
end

function PvPTracker:PLAYER_TARGET_CHANGED(event)
    if self:IsDuelTrackingActive() then
        self:RefreshDuelOpponentFromUnits()
        self:ClearStaleData()
    end
end

function PvPTracker:PLAYER_FOCUS_CHANGED(event)
    if self:IsDuelTrackingActive() then
        self:RefreshDuelOpponentFromUnits()
        self:ClearStaleData()
    end
end

function PvPTracker:PLAYER_ENTERING_WORLD(event)
    self:RefreshArenaMapping()
    self:ClearStaleData()
    if not (ns.IsInPvP and ns.IsInPvP()) then
        self.state.duelActive = false
        self.state.duelOpponentGUID = nil
        self.state.duelOpponentName = nil
    end
end

function PvPTracker:ZONE_CHANGED_NEW_AREA(event)
    self:RefreshArenaMapping()
    self:ClearStaleData()
end

function PvPTracker:NAG_FRAME_UPDATED()
    if not self:IsEnabled() then return end
    self:UpdatePvPFrameEditState()
end

function PvPTracker:OnModifierStateChanged(event)
    self:UpdatePvPIconMouseState()
end

--- Returns true if icons should have mouse enabled for tooltips (uses same modifier key as main NAG frame)
--- @return boolean
function PvPTracker:ShouldEnableIconMouseForTooltips()
    local ds = self.db.char.displaySettings or {}
    if ds.showTooltips == false then return false end
    local dm = NAG:GetModule("DisplayManager", true)
    if not dm or not dm.GetMouseInteractionKey then return true end
    local key = dm:GetMouseInteractionKey()
    if key == "NONE" then return true end
    if key == "ALT" then return IsAltKeyDown and IsAltKeyDown() end
    if key == "SHIFT" then return IsShiftKeyDown and IsShiftKeyDown() end
    if key == "CONTROL" then return IsControlKeyDown and IsControlKeyDown() end
    return false
end

--- Updates mouse state on all PvP display icons (for modifier-key tooltips)
function PvPTracker:UpdatePvPIconMouseState()
    if not self.displayFrame or not self.displayFrame.iconFrames then return end
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then return end
    local wantMouse = self:ShouldEnableIconMouseForTooltips()
    for _, icon in ipairs(self.displayFrame.iconFrames) do
        if icon:IsShown() then
            icon:EnableMouse(wantMouse)
        end
    end
end

-- ============================ CATEGORY HELPERS ============================

-- Maps PvPSpellData category to displaySettings key
local CATEGORY_TO_SETTING = {
    interrupt = "showInterrupts",
    defensive = "showDefensives",
    cc = "showCC",
}

--- Whether we should track/display cooldowns for this category
--- @param category string "interrupt"|"defensive"|"cc"
--- @return boolean
function PvPTracker:IsCategoryEnabled(category)
    if not category then return false end
    local key = CATEGORY_TO_SETTING[category]
    if not key then return false end
    local ds = self.db.char.displaySettings or {}
    return ds[key] ~= false
end

--- Whether DR tracking is enabled (for APL values)
function PvPTracker:IsDREnabled()
    local ds = self.db.char.displaySettings or {}
    return ds.showDR ~= false
end

--- Get cooldown data for spell (built-in + custom). Custom spells override built-in.
--- @param spellId number
--- @return table|nil { duration, category }
function PvPTracker:GetCooldownDataForSpell(spellId)
    if not spellId then return nil end
    local custom = self.db.global.trackedSpells
    if custom and custom[spellId] and custom[spellId].duration then
        return custom[spellId]
    end
    local PvPSpellData = ns.PvPSpellData
    if PvPSpellData and PvPSpellData.GetCooldownData then
        return PvPSpellData.GetCooldownData(spellId)
    end
    return nil
end

--- Get display name for spell ID
--- @param spellId number
--- @return string
function PvPTracker:GetSpellDisplayName(spellId)
    if not spellId then return tostring(spellId) end
    local name
    if WoWAPI and WoWAPI.GetSpellInfo then
        local info = WoWAPI.GetSpellInfo(spellId)
        if type(info) == "table" and info.name then
            name = info.name
        elseif type(info) == "string" then
            name = info
        end
    end
    if not name and GetSpellInfo then
        name = GetSpellInfo(spellId)
    end
    return name or format("Spell %d", spellId)
end

--- Get all tracked spell IDs (built-in + custom) for display
--- @return table list of { spellId, duration, category, custom }
function PvPTracker:GetAllTrackedSpells()
    local result = {}
    local seen = {}
    local PvPSpellData = ns.PvPSpellData
    if PvPSpellData and PvPSpellData.TRACKED_COOLDOWNS then
        for spellId, data in pairs(PvPSpellData.TRACKED_COOLDOWNS) do
            if data and data.duration and not seen[spellId] then
                seen[spellId] = true
                result[#result + 1] = { spellId = spellId, duration = data.duration, category = data.category or "interrupt", custom = false }
            end
        end
    end
    local custom = self.db.global.trackedSpells
    if custom then
        for spellId, data in pairs(custom) do
            if data and data.duration and not seen[spellId] then
                seen[spellId] = true
                result[#result + 1] = { spellId = spellId, duration = data.duration, category = data.category or "interrupt", custom = true }
            end
        end
    end
    table.sort(result, function(a, b) return a.spellId < b.spellId end)
    return result
end

--- Add a custom spell to track
--- @param spellId number
--- @param duration number Cooldown duration in seconds
--- @param category string "interrupt"|"defensive"|"cc"
--- @return boolean success
function PvPTracker:AddCustomSpell(spellId, duration, category)
    spellId = tonumber(spellId)
    if not spellId or spellId < 1 then return false end
    duration = tonumber(duration) or 24
    duration = math.max(1, math.min(600, duration))
    category = category or "interrupt"
    if category ~= "interrupt" and category ~= "defensive" and category ~= "cc" then
        category = "interrupt"
    end
    local tracked = self.db.global.trackedSpells
    if not tracked then
        self.db.global.trackedSpells = {}
        tracked = self.db.global.trackedSpells
    end
    tracked[spellId] = { duration = duration, category = category }
    self:UpdateDisplay()
    return true
end

--- Remove a custom spell from tracking
--- @param spellId number
function PvPTracker:RemoveCustomSpell(spellId)
    spellId = tonumber(spellId)
    if not spellId then return end
    local tracked = self.db.global.trackedSpells
    if tracked and tracked[spellId] then
        tracked[spellId] = nil
        self:UpdateDisplay()
    end
end

--- Refresh options dialog (call after add/remove to update list)
function PvPTracker:RefreshOptions()
    local AceConfigDialog = LibStub("AceConfigDialog-3.0", true)
    if AceConfigDialog and AceConfigDialog.SelectGroup then
        AceConfigDialog:SelectGroup("NAG", "features", "PvPTracker", "advanced")
    end
end

-- ============================ CLEU HANDLERS ============================

local PlaySound = _G.PlaySound
local SOUNDKIT = _G.SOUNDKIT

function PvPTracker:HandleCLEUSpellCastStart(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, arg16, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self:IsEnabled() then return end
    if not self:IsTrackingContextActive() then return end

    local playerGUID = NAG.state and NAG.state.player and NAG.state.player.guid
    if not playerGUID or sourceGUID == playerGUID then return end

    local PvPSpellData = ns.PvPSpellData
    if self:IsDuelTrackingActive() then
        local duelGUID = self.state and self.state.duelOpponentGUID
        if duelGUID and sourceGUID ~= duelGUID then
            return
        end
    elseif PvPSpellData and PvPSpellData.IsEnemySource and not PvPSpellData.IsEnemySource(sourceFlags) then
        return
    end

    local castingUnit
    if UnitGUID("target") == sourceGUID then
        castingUnit = "target"
    elseif UnitGUID("focus") == sourceGUID then
        castingUnit = "focus"
    elseif self:IsDuelTrackingActive() and self.state.duelOpponentGUID == sourceGUID then
        castingUnit = "duel"
    else
        for i = 1, 5 do
            local unit = "arena" .. i
            if UnitExists(unit) and UnitGUID(unit) == sourceGUID then
                castingUnit = unit
                break
            end
        end
    end

    if not castingUnit then return end

    self.state.enemyCasting = {
        unit = castingUnit,
        sourceGUID = sourceGUID,
        spellId = spellId,
        spellName = spellName,
        startTime = GetTime(),
    }

    local ds = self.db.char.displaySettings
    if ds and ds.showInterrupts and ds.interruptSoundEnabled ~= false then
        local soundKit = (ds.interruptSoundKit == "RaidBossEmote" and SOUNDKIT and SOUNDKIT.RaidBossEmote)
            or (ds.interruptSoundKit == "RaidWarning" and SOUNDKIT and SOUNDKIT.RaidWarning)
            or (SOUNDKIT and SOUNDKIT.RaidWarning)
        if PlaySound and soundKit then
            PlaySound(soundKit)
        end
    end
end

function PvPTracker:HandleCLEUSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, arg16, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self:IsEnabled() then return end
    if not self:IsTrackingContextActive() then return end

    local playerGUID = NAG.state and NAG.state.player and NAG.state.player.guid
    if not playerGUID then return end
    if sourceGUID == playerGUID then return end

    local PvPSpellData = ns.PvPSpellData
    if not PvPSpellData then return end

    if self:IsDuelTrackingActive() then
        local duelGUID = self.state and self.state.duelOpponentGUID
        if duelGUID and sourceGUID ~= duelGUID then
            return
        end
    elseif PvPSpellData.IsEnemySource and not PvPSpellData.IsEnemySource(sourceFlags) then
        return
    end

    if ns.IsInArena() then
        local isArenaEnemy = false
        for i = 1, 5 do
            local unit = "arena" .. i
            if UnitExists(unit) and UnitGUID(unit) == sourceGUID then
                isArenaEnemy = true
                self.state.guidToArenaUnit = self.state.guidToArenaUnit or {}
                self.state.guidToArenaUnit[sourceGUID] = unit
                self.state.arenaUnitToGUID = self.state.arenaUnitToGUID or {}
                self.state.arenaUnitToGUID[unit] = sourceGUID
                break
            end
        end
        if not isArenaEnemy then
            return
        end
    elseif self:IsDuelTrackingActive() then
        local duelGUID = self.state and self.state.duelOpponentGUID
        if duelGUID and sourceGUID ~= duelGUID then
            return
        end
        if not duelGUID and sourceGUID then
            self.state.duelOpponentGUID = sourceGUID
        end
    end

    local cooldownData = self:GetCooldownDataForSpell(spellId)
    if not cooldownData or not cooldownData.duration then
        return
    end
    if not self:IsCategoryEnabled(cooldownData.category) then
        return
    end

    self.state.enemyCooldowns = self.state.enemyCooldowns or {}
    self.state.enemyCooldowns[sourceGUID] = self.state.enemyCooldowns[sourceGUID] or {}
    self.state.enemyCooldowns[sourceGUID][spellId] = {
        expiresAt = GetTime() + cooldownData.duration,
        category = cooldownData.category,
    }

    if self.state.enemyCasting and self.state.enemyCasting.sourceGUID == sourceGUID then
        self.state.enemyCasting = nil
    end

    if self.debug then
        self:Debug("Tracked enemy CD: %s spell %d for %.1fs", tostring(sourceName or sourceGUID), spellId, cooldownData.duration)
    end
end

function PvPTracker:HandleCLEUSpellInterrupt(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, extraSpellId,
    arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if self.state.enemyCasting and self.state.enemyCasting.sourceGUID == destGUID then
        self.state.enemyCasting = nil
    end
end

function PvPTracker:HandleCLEUAuraApplied(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self:IsEnabled() then return end
    if not self:IsDREnabled() then return end
    if not self:IsTrackingContextActive() then return end
    if auraType ~= "DEBUFF" then return end

    local playerGUID = NAG.state and NAG.state.player and NAG.state.player.guid
    if not playerGUID or destGUID == playerGUID then return end

    local PvPDRData = ns.PvPDRData
    if not PvPDRData or not PvPDRData.GetCategory then return end

    local category = PvPDRData.GetCategory(spellId)
    if not category then return end

    local PvPSpellData = ns.PvPSpellData
    if self:IsDuelTrackingActive() then
        local duelGUID = self.state and self.state.duelOpponentGUID
        if duelGUID and destGUID ~= duelGUID then
            return
        end
    elseif PvPSpellData and PvPSpellData.IsEnemySource then
        if PvPSpellData.IsEnemySource(destFlags) == false then
            return
        end
    end

    if ns.IsInArena() and self.state.guidToArenaUnit then
        local isArenaEnemy = self.state.guidToArenaUnit[destGUID]
        if not isArenaEnemy then
            for i = 1, 5 do
                local unit = "arena" .. i
                if UnitExists(unit) and UnitGUID(unit) == destGUID then
                    self.state.guidToArenaUnit = self.state.guidToArenaUnit or {}
                    self.state.guidToArenaUnit[destGUID] = unit
                    self.state.arenaUnitToGUID = self.state.arenaUnitToGUID or {}
                    self.state.arenaUnitToGUID[unit] = destGUID
                    break
                end
            end
        end
    elseif self:IsDuelTrackingActive() then
        local duelGUID = self.state and self.state.duelOpponentGUID
        if duelGUID and destGUID ~= duelGUID then
            return
        end
        if not duelGUID and destGUID then
            self.state.duelOpponentGUID = destGUID
        end
    end

    self.state.drState = self.state.drState or {}
    self.state.drState[destGUID] = self.state.drState[destGUID] or {}

    local drResetSeconds = PvPDRData.DR_RESET_SECONDS or 18
    local now = GetTime()
    local entry = self.state.drState[destGUID][category]

    if entry and (now - entry.lastApply) < drResetSeconds then
        entry.drLevel = math.min((entry.drLevel or 1) + 1, 3)
    else
        entry = { drLevel = 1 }
    end
    entry.lastApply = now
    entry.resetAt = now + drResetSeconds
    self.state.drState[destGUID][category] = entry

    if self.debug then
        self:Debug("DR: %s %s on %s level %d", category, tostring(spellId), tostring(destName or destGUID), entry.drLevel)
    end
end

function PvPTracker:HandleCLEUAuraRemoved(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if auraType ~= "DEBUFF" then return end

    local PvPDRData = ns.PvPDRData
    if not PvPDRData or not PvPDRData.GetCategory then return end

    local category = PvPDRData.GetCategory(spellId)
    if not category then return end

    if self.state.drState and self.state.drState[destGUID] then
        self.state.drState[destGUID][category] = nil
    end
end

-- ============================ ARENA HELPERS ============================

function PvPTracker:RefreshArenaMapping()
    wipe(self.state.arenaUnitToGUID or {})
    wipe(self.state.guidToArenaUnit or {})
    self.state.arenaUnitToGUID = self.state.arenaUnitToGUID or {}
    self.state.guidToArenaUnit = self.state.guidToArenaUnit or {}

    if not ns.IsInArena then
        return
    end

    for i = 1, 5 do
        local unit = "arena" .. i
        if UnitExists(unit) then
            local guid = UnitGUID(unit)
            if guid then
                self.state.arenaUnitToGUID[unit] = guid
                self.state.guidToArenaUnit[guid] = unit
            end
        end
    end
end

function PvPTracker:ClearStaleData()
    if not self.state.enemyCooldowns then
        self.state.enemyCooldowns = {}
    end
    if not self.state.drState then
        self.state.drState = {}
    end

    local now = GetTime()

    -- Generic cleanup for all PvP modes (arena and battlegrounds):
    -- prune expired cooldowns and expired DR entries to prevent stale buildup.
    for guid, spells in pairs(self.state.enemyCooldowns) do
        local hasActive = false
        if type(spells) == "table" then
            for spellId, cd in pairs(spells) do
                local expiresAt = cd and cd.expiresAt
                if not expiresAt or expiresAt <= now then
                    spells[spellId] = nil
                else
                    hasActive = true
                end
            end
        end
        if not hasActive then
            self.state.enemyCooldowns[guid] = nil
        end
    end

    for guid, categories in pairs(self.state.drState) do
        local hasActive = false
        if type(categories) == "table" then
            for category, entry in pairs(categories) do
                local resetAt = entry and entry.resetAt
                if not resetAt or resetAt <= now then
                    categories[category] = nil
                else
                    hasActive = true
                end
            end
        end
        if not hasActive then
            self.state.drState[guid] = nil
        end
    end

    -- Arena-specific cleanup: remove anything that no longer maps to active arena units.
    if ns.IsInArena and self.state.guidToArenaUnit then
        local validGuids = {}
        for guid in pairs(self.state.guidToArenaUnit) do
            validGuids[guid] = true
        end
        for guid in pairs(self.state.enemyCooldowns) do
            if not validGuids[guid] then
                self.state.enemyCooldowns[guid] = nil
            end
        end
        for guid in pairs(self.state.drState) do
            if not validGuids[guid] then
                self.state.drState[guid] = nil
            end
        end
    end
end

-- ============================ PUBLIC API ============================

local function ResolveGUID(moduleRef, unitOrGUID)
    if not unitOrGUID then return nil end
    if type(unitOrGUID) == "string" and unitOrGUID:match("^0x") then
        return unitOrGUID
    end
    if type(unitOrGUID) == "string" and (unitOrGUID == "target" or unitOrGUID == "focus") then
        if UnitExists(unitOrGUID) then
            return UnitGUID(unitOrGUID)
        end
        return nil
    end
    if type(unitOrGUID) == "string" and unitOrGUID:match("^arena%d$") then
        if UnitExists(unitOrGUID) then
            return UnitGUID(unitOrGUID)
        end
        if moduleRef.state and moduleRef.state.guidToArenaUnit then
            for guid, unit in pairs(moduleRef.state.guidToArenaUnit) do
                if unit == unitOrGUID then return guid end
            end
        end
        return nil
    end
    if unitOrGUID == "duel" and moduleRef and moduleRef.state then
        if moduleRef.state.duelOpponentGUID then
            return moduleRef.state.duelOpponentGUID
        end
        local targetGUID = UnitExists("target") and UnitGUID("target") or nil
        if targetGUID then
            return targetGUID
        end
        local focusGUID = UnitExists("focus") and UnitGUID("focus") or nil
        if focusGUID then
            return focusGUID
        end
        return nil
    end
    return unitOrGUID
end

function PvPTracker:GetEnemyCooldownRemaining(unitOrGUID, spellId)
    if not spellId then return nil end
    local guid = ResolveGUID(self, unitOrGUID)
    if not guid then return nil end

    local cd = self.state.enemyCooldowns and self.state.enemyCooldowns[guid] and self.state.enemyCooldowns[guid][spellId]
    if not cd or not cd.expiresAt then return nil end

    local remaining = cd.expiresAt - GetTime()
    if remaining <= 0 then
        self.state.enemyCooldowns[guid][spellId] = nil
        return nil
    end
    return remaining
end

function PvPTracker:IsEnemyCooldownDown(unitOrGUID, spellId)
    local remaining = self:GetEnemyCooldownRemaining(unitOrGUID, spellId)
    return remaining == nil or remaining <= 0
end

function PvPTracker:GetDRRemaining(unitOrGUID, category)
    if not category then return nil end
    local guid = ResolveGUID(self, unitOrGUID)
    if not guid then return nil end

    local entry = self.state.drState and self.state.drState[guid] and self.state.drState[guid][category]
    if not entry or not entry.resetAt then return nil end

    local remaining = entry.resetAt - GetTime()
    if remaining <= 0 then
        self.state.drState[guid][category] = nil
        return nil
    end
    return remaining
end

function PvPTracker:IsDRReady(unitOrGUID, category)
    local remaining = self:GetDRRemaining(unitOrGUID, category)
    return remaining == nil or remaining <= 0
end

--- Returns true if it is safe to cast (all known interrupts for the unit are on cooldown)
--- Class-agnostic: checks all tracked interrupt IDs for the unit's GUID.
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean True when no enemy interrupt is available
function PvPTracker:IsSafeToCast(unit)
    if not unit then return true end
    local interruptIds = ns.PvPSpellData and ns.PvPSpellData.GetInterruptSpellIds and ns.PvPSpellData.GetInterruptSpellIds()
    if not interruptIds then return true end

    for spellId in pairs(interruptIds) do
        if self:IsEnemyCooldownDown(unit, spellId) then
            return false
        end
    end
    return true
end

--- Returns true if the unit has at least one tracked defensive available (not on cooldown)
--- Uses cooldown data only; without data we assume defensives may exist.
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean
function PvPTracker:HasDefensivesRemaining(unit)
    if not unit then return true end
    local defensiveIds = ns.PvPSpellData and ns.PvPSpellData.GetDefensiveSpellIds and ns.PvPSpellData.GetDefensiveSpellIds()
    if not defensiveIds then return true end

    for spellId in pairs(defensiveIds) do
        if self:IsEnemyCooldownDown(unit, spellId) then
            return true
        end
    end
    return false
end

--- Returns the arena unit (arena1-5) with no defensives remaining, or lowest defensive coverage
--- @return string|nil Unit ID e.g. "arena2", or nil if none found
function PvPTracker:GetVulnerableArenaUnit()
    local bestUnit
    local bestReadyCount = 999
    local defensiveIds = ns.PvPSpellData and ns.PvPSpellData.GetDefensiveSpellIds and ns.PvPSpellData.GetDefensiveSpellIds()

    for i = 1, 5 do
        local unit = "arena" .. i
        if UnitExists(unit) then
            local readyCount = 0
            if defensiveIds then
                for spellId in pairs(defensiveIds) do
                    if self:IsEnemyCooldownDown(unit, spellId) then
                        readyCount = readyCount + 1
                    end
                end
            end
            if readyCount == 0 then
                return unit
            end
            if readyCount < bestReadyCount then
                bestReadyCount = readyCount
                bestUnit = unit
            end
        end
    end

    return bestUnit
end

--- Whether the enemy unit has an immunity buff (Ice Block, Divine Shield, etc.)
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean
function PvPTracker:IsEnemyImmune(unit)
    if not unit or not UnitExists(unit) then return false end
    local immunityIds = ns.PvPSpellData and ns.PvPSpellData.IMMUNITY_SPELL_IDS
    if not immunityIds then return false end

    for spellId in pairs(immunityIds) do
        local aura = NAG.UnitBuff and NAG:UnitBuff(unit, spellId, "HELPFUL", true)
        if aura and type(aura) == "table" then
            return true
        end
    end
    return false
end

--- Get remaining immunity duration in seconds, or nil if not immune
--- @param unit string Unit ID
--- @return number|nil Seconds until immunity ends
function PvPTracker:GetEnemyImmunityRemaining(unit)
    if not unit or not UnitExists(unit) then return nil end
    local immunityIds = ns.PvPSpellData and ns.PvPSpellData.IMMUNITY_SPELL_IDS
    if not immunityIds then return nil end

    local now = GetTime()
    local maxExpiry = 0

    for spellId in pairs(immunityIds) do
        local aura = NAG.UnitBuff and NAG:UnitBuff(unit, spellId, "HELPFUL", true)
        if aura and type(aura) == "table" and aura.expirationTime then
            if aura.expirationTime > maxExpiry then
                maxExpiry = aura.expirationTime
            end
        end
    end

    if maxExpiry > now then
        return maxExpiry - now
    end
    return nil
end

function PvPTracker:GetDRLevel(unitOrGUID, category)
    if not category then return nil end
    local guid = ResolveGUID(self, unitOrGUID)
    if not guid then return nil end

    local entry = self.state.drState and self.state.drState[guid] and self.state.drState[guid][category]
    if not entry then return nil end

    local remaining = entry.resetAt and (entry.resetAt - GetTime()) or 0
    if remaining <= 0 then
        return nil
    end
    return entry.drLevel or 1
end

function PvPTracker:IsEnabled()
    return self.db and self.db.char and self.db.char.enabled == true
end

--- Returns the party healer unit if detected (party1, party2, etc.)
--- Uses UnitGroupRolesAssigned when available (MoP+). 2s has no healer.
--- @return string|nil Unit ID e.g. "party1", or nil
function PvPTracker:GetHealerUnit()
    local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned
    local maxParty = 4

    -- Preferred path on versions that support role assignment.
    if UnitGroupRolesAssigned then
        for i = 1, maxParty do
            local unit = "party" .. i
            if UnitExists(unit) then
                local role = UnitGroupRolesAssigned(unit)
                if role == "HEALER" then
                    return unit
                end
            end
        end
    end

    -- Classic fallback: pick likely healer classes when explicit role APIs are unavailable.
    local likelyHealerClass = {
        PRIEST = true,
        PALADIN = true,
        SHAMAN = true,
        DRUID = true,
        MONK = true,
    }
    for i = 1, maxParty do
        local unit = "party" .. i
        if UnitExists(unit) then
            local _, classToken = UnitClass(unit)
            if classToken and likelyHealerClass[classToken] then
                return unit
            end
        end
    end
    return nil
end

--- Returns true if the party healer has a CC debuff (stun, incapacitate, fear, etc.)
--- @return boolean
function PvPTracker:IsHealerInCC()
    local healerUnit = self:GetHealerUnit()
    if not healerUnit then return false end

    local drSpells = ns.PvPDRData and ns.PvPDRData.SPELL_TO_DR_CATEGORY
    if not drSpells then return false end

    for spellId in pairs(drSpells) do
        local aura = NAG.UnitDebuffGlobal and NAG:UnitDebuffGlobal(healerUnit, spellId)
        if aura and type(aura) == "table" then
            return true
        end
    end
    return false
end

--- Returns true if the enemy has PvP trinket ready (not on cooldown)
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean
function PvPTracker:EnemyTrinketReady(unit)
    if not unit then return true end
    local trinketIds = ns.PvPSpellData and ns.PvPSpellData.GetPVPTrinketSpellIds and ns.PvPSpellData.GetPVPTrinketSpellIds()
    if not trinketIds then return true end

    for spellId in pairs(trinketIds) do
        if self:IsEnemyCooldownDown(unit, spellId) then
            return true
        end
    end
    return false
end

--- Returns true if the player's PvP trinket is ready (either trinket slot)
--- @return boolean
function PvPTracker:PlayerTrinketReady()
    local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
    local GetInventoryItemID = _G.GetInventoryItemID
    if not GetInventoryItemCooldown then return false end

    local now = GetTime()
    for slot = 13, 14 do
        if GetInventoryItemID and not GetInventoryItemID("player", slot) then
            -- Empty slot, skip
        else
            local start, duration = GetInventoryItemCooldown("player", slot)
            if not start or not duration then
                return true
            end
            if duration == 0 or (start + duration) <= now then
                return true
            end
        end
    end
    return false
end

--- Returns true if the player has the given PvP talent selected (Retail/BfA+)
--- @param talentId number PvP talent spell ID
--- @return boolean
function PvPTracker:HasPVPTalent(talentId)
    if not talentId or type(talentId) ~= "number" then return false end
    local C_SpecializationInfo = _G.C_SpecializationInfo
    if not C_SpecializationInfo or type(C_SpecializationInfo.GetPvpTalentSlotInfo) ~= "function" then
        return false
    end

    for slotIndex = 1, 3 do
        local ok, slotInfo = pcall(function()
            return C_SpecializationInfo.GetPvpTalentSlotInfo(slotIndex)
        end)
        if ok and slotInfo and slotInfo.selectedTalentID == talentId then
            return true
        end
    end
    return false
end

--- Returns current arena dampening percentage, or nil if API unavailable (TBC/Classic)
--- @return number|nil Dampening 0-100, or nil
function PvPTracker:GetDampeningPercent()
    local C_PvP = _G.C_PvP
    if not C_PvP or type(C_PvP.GetArenaDampening) ~= "function" then
        return nil
    end
    local ok, result = pcall(function()
        return C_PvP.GetArenaDampening()
    end)
    if ok and type(result) == "number" then
        return result
    end
    return nil
end

--- Returns true when burst window is open: healer CC'd (or 2s), target out of defensives,
--- target DR ready, and interrupts on CD.
--- @param targetUnit string Unit ID e.g. "target", "arena1"
--- @return boolean
function PvPTracker:IsBurstWindowOpen(targetUnit)
    if not targetUnit then return false end
    if self:IsEnemyImmune(targetUnit) then return false end
    if self:HasDefensivesRemaining(targetUnit) then return false end
    if not self:IsSafeToCast(targetUnit) then return false end

    local healerInCC = self:IsHealerInCC()
    local hasHealer = self:GetHealerUnit() ~= nil
    if hasHealer and not healerInCC then return false end

    local primaryCategories = { "stun", "incapacitate" }
    local drReady = false
    for _, cat in ipairs(primaryCategories) do
        if self:IsDRReady(targetUnit, cat) then
            drReady = true
            break
        end
    end
    if not drReady then return false end

    return true
end

-- ============================ DISPLAY ============================

local DISPLAY_UPDATE_INTERVAL = 0.5
local MAX_DISPLAY_ICONS = 12

--- Show tooltip for PvP icon on hover
--- @param icon table The icon frame with _lastEntry
function PvPTracker:ShowIconTooltip(icon)
    if not icon or not icon._lastEntry then return end
    local entry = icon._lastEntry
    if not GameTooltip or not GameTooltip.SetOwner then return end

    local ds = self.db.char.displaySettings or {}
    if ds.showTooltips == false then return end

    GameTooltip:SetOwner(icon, "ANCHOR_RIGHT")
    local spellName = self:GetSpellDisplayName(entry.spellId)
    GameTooltip:AddLine(spellName, 1, 1, 1)
    GameTooltip:AddLine(format("%.1fs remaining", entry.remaining or 0), 0.8, 0.8, 0.8)
    if entry.arenaUnit then
        GameTooltip:AddLine(entry.arenaUnit, 0.6, 0.8, 1)
    end
    if entry.drLevel and entry.drLevel >= 1 then
        GameTooltip:AddLine(format("DR: %d (%.0f%%)", entry.drLevel, entry.drLevel == 1 and 100 or (entry.drLevel == 2 and 50 or 25)), 1, 1, 0)
    end
    GameTooltip:Show()
end

--- Applies layout direction to frame size
--- @param frame Frame
--- @param iconSize number
--- @param layoutDirection string "horizontal" or "vertical"
--- @param maxIcons number
function PvPTracker:ApplyIconLayout(frame, iconSize, layoutDirection, maxIcons)
    maxIcons = maxIcons or MAX_DISPLAY_ICONS
    local spacing = iconSize + 2
    local pad = 10
    if layoutDirection == "vertical" then
        frame:SetSize(iconSize + pad, spacing * maxIcons - 2 + pad)
    else
        frame:SetSize(spacing * maxIcons - 2 + pad, iconSize + pad)
    end
end

--- Sets a single icon's position based on layout direction
--- @param icon Frame
--- @param parent Frame
--- @param index number 1-based icon index
--- @param iconSize number
--- @param layoutDirection string "horizontal" or "vertical"
function PvPTracker:SetIconPosition(icon, parent, index, iconSize, layoutDirection)
    icon:ClearAllPoints()
    local spacing = iconSize + 2
    local offset = (index - 1) * spacing
    if layoutDirection == "vertical" then
        -- WoW coords: (0,0) bottom-left, Y increases up. Stack icons downward from parent top.
        icon:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -offset)
    else
        -- Horizontal: icons in a row left to right
        icon:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", offset, 0)
    end
end

function PvPTracker:CreateDisplayFrame()
    if self.displayFrame then return end
    if not self:IsEnabled() then return end

    local parent = UIParent
    local DisplayManager = NAG:GetModule("DisplayManager", true)
    if DisplayManager and DisplayManager.GetAnchorParent then
        parent = DisplayManager:GetAnchorParent()
    end

    local ds = self.db.char.displaySettings or {}
    local pos = ds.position or {}
    local iconSize = ds.iconSize or 32
    local scale = ds.scale or 1.0
    local layoutDir = ds.layoutDirection or "horizontal"
    local maxIcons = math.min(ds.maxDisplayIcons or MAX_DISPLAY_ICONS, MAX_DISPLAY_ICONS)

    local frame = CreateFrame("Frame", "NAGPvPTrackerFrame", parent)
    self:ApplyIconLayout(frame, iconSize, layoutDir, maxIcons)
    frame:SetPoint(pos.point or "CENTER", parent, pos.relativePoint or "CENTER", pos.x or 0, pos.y or 150)
    frame:SetScale(scale)
    frame:SetFrameStrata("LOW")
    frame:EnableMouse(false)
    frame.iconFrames = {}

    for i = 1, MAX_DISPLAY_ICONS do
        local icon = CreateFrame("Frame", nil, frame)
        icon:SetSize(iconSize, iconSize)
        self:SetIconPosition(icon, frame, i, iconSize, layoutDir)
        icon:EnableMouse(false)

        local tex = icon:CreateTexture(nil, "BACKGROUND")
        tex:SetAllPoints()
        icon.texture = tex

        icon.cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
        if icon.cooldown then
            icon.cooldown:SetAllPoints()
            icon.cooldown:Hide()
            if icon.cooldown.SetHideCountdownNumbers then
                icon.cooldown:SetHideCountdownNumbers(true)
            end
        end

        local cdText = icon:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
        cdText:SetPoint("CENTER")
        cdText:SetTextColor(1, 1, 1, 1)
        icon.cdText = cdText

        local dm = NAG:GetModule("DisplayManager", true)
        if dm and dm.AddColoredBorder then
            dm:AddColoredBorder(icon, 1, 1, 1, 1, { thickness = 1, inset = 0, fullyInset = true })
        else
            icon.borders = {}
            for j = 1, 4 do
                local line = icon:CreateLine(nil, "OVERLAY", nil, 0)
                if line then
                    line:SetThickness(1)
                    line:SetColorTexture(1, 1, 1, 1)
                    local inset = 0
                    if j == 1 then
                        line:SetStartPoint("TOPLEFT", inset, inset)
                        line:SetEndPoint("TOPRIGHT", -inset, inset)
                    elseif j == 2 then
                        line:SetStartPoint("TOPRIGHT", -inset, inset)
                        line:SetEndPoint("BOTTOMRIGHT", -inset, -inset)
                    elseif j == 3 then
                        line:SetStartPoint("BOTTOMRIGHT", -inset, -inset)
                        line:SetEndPoint("BOTTOMLEFT", inset, -inset)
                    else
                        line:SetStartPoint("BOTTOMLEFT", inset, -inset)
                        line:SetEndPoint("TOPLEFT", inset, inset)
                    end
                    line:Hide()
                    icon.borders[j] = line
                end
            end
        end

        local badge = icon:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall")
        badge:SetPoint("TOPLEFT", 5, -5)
        badge:SetTextColor(1, 1, 1, 1)
        if badge:GetFont() then
            badge:SetFont(badge:GetFont(), 12, "OUTLINE")
        end
        badge:SetText("")
        badge:Hide()
        icon.badge = badge

        local drOverlay = icon:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall")
        drOverlay:SetPoint("BOTTOMRIGHT", -2, 2)
        drOverlay:SetTextColor(1, 1, 1, 1)
        if drOverlay:GetFont() then
            drOverlay:SetFont(drOverlay:GetFont(), 11, "OUTLINE")
        end
        drOverlay:SetText("")
        drOverlay:Hide()
        icon.drOverlay = drOverlay

        icon:SetScript("OnEnter", function(ic)
            PvPTracker:ShowIconTooltip(ic)
        end)
        icon:SetScript("OnLeave", function()
            if GameTooltip and GameTooltip.Hide then
                GameTooltip:Hide()
            end
        end)

        icon:Hide()
        frame.iconFrames[i] = icon
    end

    -- Status indicator overlays (Phase E)
    local burstIndicator = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    burstIndicator:SetPoint("BOTTOM", frame, "TOP", 0, 4)
    burstIndicator:SetText("GO")
    burstIndicator:SetTextColor(1, 0.8, 0.2, 1)
    burstIndicator:Hide()
    frame.burstIndicator = burstIndicator

    local immunityWarning = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    immunityWarning:SetPoint("RIGHT", frame, "LEFT", -4, 0)
    immunityWarning:SetText("IMMUNE")
    immunityWarning:SetTextColor(1, 0.3, 0.3, 1)
    immunityWarning:Hide()
    frame.immunityWarning = immunityWarning

    local safeToCast = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    safeToCast:SetPoint("LEFT", frame, "RIGHT", 4, 0)
    safeToCast:SetText("OK")
    safeToCast:SetTextColor(0.3, 1, 0.3, 1)
    safeToCast:Hide()
    frame.safeToCast = safeToCast

    local dampeningText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    dampeningText:SetPoint("TOP", frame, "BOTTOM", 0, -4)
    dampeningText:SetTextColor(0.8, 0.8, 0.8, 1)
    dampeningText:Hide()
    frame.dampeningText = dampeningText

    frame:Hide()
    self.displayFrame = frame
end

function PvPTracker:StartDisplayUpdate()
    self:StopDisplayUpdate()
    local TimerManager = NAG:GetModule("TimerManager", true)
    if not TimerManager then return end

    self._pvpDisplayTimer = TimerManager:Create(
        TimerManager.Categories.COMBAT or "combat",
        "PvPTracker_DisplayUpdate",
        function() self:UpdateDisplay() end,
        DISPLAY_UPDATE_INTERVAL,
        true
    )
end

function PvPTracker:StopDisplayUpdate()
    local TimerManager = NAG:GetModule("TimerManager", true)
    if TimerManager and self._pvpDisplayTimer then
        TimerManager:Cancel(TimerManager.Categories.COMBAT or "combat", "PvPTracker_DisplayUpdate")
        self._pvpDisplayTimer = nil
    end
end

function PvPTracker:UpdateDisplay()
    if not self.displayFrame or not self:IsEnabled() then return end
    -- In edit mode, UpdatePvPFrameEditState owns visibility (shows samples); do not override
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then return end
    if not self:IsTrackingContextActive() then
        self.displayFrame:Hide()
        return
    end

    local ds = self.db.char.displaySettings or {}
    if not ds.showCooldowns then
        self.displayFrame:Hide()
        return
    end

    self._displayEntries = self._displayEntries or {}
    local entries = self._displayEntries
    wipe(entries)
    local now = GetTime()
    local guidToArena = self.state.guidToArenaUnit or {}
    local vulnerableUnit = (ds.showVulnerableHighlight and self:GetVulnerableArenaUnit()) or nil
    local vulnerableGUID = (vulnerableUnit and self.state.arenaUnitToGUID and self.state.arenaUnitToGUID[vulnerableUnit]) or nil
    local PvPDRData = ns.PvPDRData

    for guid, spells in pairs(self.state.enemyCooldowns or {}) do
        for spellId, data in pairs(spells) do
            if self:IsCategoryEnabled(data.category) then
                local remaining = data.expiresAt and (data.expiresAt - now) or 0
                if remaining > 0 then
                    local arenaUnit = guidToArena[guid]
                    local drLevel, drRemaining
                    if PvPDRData and PvPDRData.GetCategory then
                        local cat = PvPDRData.GetCategory(spellId)
                        if cat then
                            drLevel = self:GetDRLevel(guid, cat)
                            drRemaining = self:GetDRRemaining(guid, cat)
                        end
                    end
                    entries[#entries + 1] = {
                        guid = guid,
                        spellId = spellId,
                        remaining = remaining,
                        category = data.category,
                        expiresAt = data.expiresAt,
                        arenaUnit = arenaUnit,
                        drLevel = drLevel,
                        drRemaining = drRemaining,
                    }
                end
            end
        end
    end

    local iconSort = ds.iconSort or "time"
    if iconSort == "category" then
        table.sort(entries, function(a, b)
            local orderA = CATEGORY_SORT_ORDER[a.category] or 99
            local orderB = CATEGORY_SORT_ORDER[b.category] or 99
            if orderA ~= orderB then return orderA < orderB end
            return a.remaining < b.remaining
        end)
    else
        table.sort(entries, function(a, b) return a.remaining < b.remaining end)
    end

    local maxIcons = math.min((ds.maxDisplayIcons or MAX_DISPLAY_ICONS), MAX_DISPLAY_ICONS)
    local iconFrames = self.displayFrame.iconFrames or {}
    local enableSwipes = ds.enableCooldownSwipes ~= false
    local showBorders = ds.showCategoryBorders ~= false
    local showBadge = ds.showArenaBadge ~= false
    local showDR = ds.showDROverlay ~= false and self:IsDREnabled()
    local categoryColors = ds.categoryColors or DEFAULT_CATEGORY_COLORS

    for i = 1, MAX_DISPLAY_ICONS do
        local icon = iconFrames[i]
        if not icon then break end

        local entry = (i <= maxIcons) and entries[i] or nil
        if entry then
            local cdData = self:GetCooldownDataForSpell(entry.spellId)
            local duration = (cdData and cdData.duration) or 24

            local iconTexture
            if WoWAPI and WoWAPI.GetSpellInfo then
                local spellInfo = WoWAPI.GetSpellInfo(entry.spellId)
                if type(spellInfo) == "table" then
                    iconTexture = spellInfo.icon or spellInfo[2]
                end
            end
            if not iconTexture and GetSpellTexture then
                iconTexture = GetSpellTexture(entry.spellId)
            end
            if iconTexture and icon.texture and icon._lastTexture ~= iconTexture then
                icon.texture:SetTexture(iconTexture)
                icon._lastTexture = iconTexture
            end

            if enableSwipes and icon.cooldown then
                local startTime = (entry.expiresAt or (now + duration)) - duration
                icon.cooldown:SetCooldown(startTime, duration)
                icon.cooldown:Show()
            elseif icon.cooldown then
                icon.cooldown:Hide()
            end
            if icon.cdText then
                if enableSwipes then
                    icon.cdText:Hide()
                else
                    local cdText = format("%.1f", entry.remaining)
                    if icon._lastCdText ~= cdText then
                        icon.cdText:SetText(cdText)
                        icon._lastCdText = cdText
                    end
                    icon.cdText:Show()
                end
            end

            if showBorders and icon.borders then
                local r, g, b, a = 1, 1, 1, 1
                if entry.guid == vulnerableGUID then
                    r, g, b, a = 1, 0.84, 0, 1
                else
                    local colors = categoryColors[entry.category] or { 1, 1, 1, 1 }
                    r, g, b, a = colors[1], colors[2], colors[3], colors[4] or 1
                end
                if icon.SetBorderColor then
                    icon:SetBorderColor(r, g, b, a)
                else
                    for _, line in ipairs(icon.borders) do
                        line:SetColorTexture(r, g, b, a)
                    end
                end
                for _, line in ipairs(icon.borders) do
                    line:Show()
                end
            elseif icon.borders then
                for _, line in ipairs(icon.borders) do
                    line:Hide()
                end
            end

            if showBadge and icon.badge and entry.arenaUnit then
                local idx = strmatch(entry.arenaUnit, "^arena(%d)$")
                icon.badge:SetText(idx or "")
                icon.badge:Show()
            elseif icon.badge then
                icon.badge:Hide()
            end

            if showDR and icon.drOverlay and entry.drLevel then
                icon.drOverlay:SetText(tostring(entry.drLevel))
                icon.drOverlay:Show()
            elseif icon.drOverlay then
                icon.drOverlay:Hide()
            end

            icon._lastEntry = entry
            icon:Show()
        else
            icon._lastEntry = nil
            if icon.cooldown then icon.cooldown:Hide() end
            if icon.borders then
                for _, line in ipairs(icon.borders) do line:Hide() end
            end
            if icon.badge then icon.badge:Hide() end
            if icon.drOverlay then icon.drOverlay:Hide() end
            icon:Hide()
        end
    end

    if #entries > 0 then
        self.displayFrame:EnableMouse(false)
        self.displayFrame:Show()
        self:UpdatePvPIconMouseState()

        -- Phase E: Status indicators
        if ds.showBurstIndicator and self.displayFrame.burstIndicator then
            if self:IsBurstWindowOpen("target") then
                self.displayFrame.burstIndicator:Show()
            else
                self.displayFrame.burstIndicator:Hide()
            end
        elseif self.displayFrame.burstIndicator then
            self.displayFrame.burstIndicator:Hide()
        end

        if ds.showImmunityWarning and self.displayFrame.immunityWarning then
            if self:IsEnemyImmune("target") then
                self.displayFrame.immunityWarning:Show()
            else
                self.displayFrame.immunityWarning:Hide()
            end
        elseif self.displayFrame.immunityWarning then
            self.displayFrame.immunityWarning:Hide()
        end

        if ds.showSafeToCast and self.displayFrame.safeToCast then
            if self:IsSafeToCast("target") and UnitExists("target") then
                self.displayFrame.safeToCast:Show()
            else
                self.displayFrame.safeToCast:Hide()
            end
        elseif self.displayFrame.safeToCast then
            self.displayFrame.safeToCast:Hide()
        end

        if ds.showDampening and self.displayFrame.dampeningText then
            local pct = self:GetDampeningPercent()
            if pct and type(pct) == "number" then
                if self.displayFrame._lastDampeningPct ~= pct then
                    self.displayFrame.dampeningText:SetText(format("Damp: %d%%", pct))
                    self.displayFrame._lastDampeningPct = pct
                end
                self.displayFrame.dampeningText:Show()
            else
                self.displayFrame.dampeningText:Hide()
            end
        elseif self.displayFrame.dampeningText then
            self.displayFrame.dampeningText:Hide()
        end
    else
        if self.displayFrame.burstIndicator then self.displayFrame.burstIndicator:Hide() end
        if self.displayFrame.immunityWarning then self.displayFrame.immunityWarning:Hide() end
        if self.displayFrame.safeToCast then self.displayFrame.safeToCast:Hide() end
        if self.displayFrame.dampeningText then self.displayFrame.dampeningText:Hide() end
        self.displayFrame:Hide()
    end
end

-- Sample spell IDs for test display (common PvP - exist in most expansions)
local TEST_DISPLAY_SAMPLES = {
    { spellId = 2139, remaining = 24, category = "interrupt", arenaUnit = "arena1" },   -- Counterspell
    { spellId = 1766, remaining = 15, category = "interrupt", arenaUnit = "arena2" },   -- Kick
    { spellId = 118, remaining = 8, category = "cc", arenaUnit = "arena2", drLevel = 1 }, -- Polymorph
    { spellId = 871, remaining = 12, category = "defensive", arenaUnit = "arena1" },    -- Shield Wall
    { spellId = 19647, remaining = 4, category = "interrupt", arenaUnit = "arena3" },   -- Spell Lock (Felhunter)
}
local FALLBACK_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

--- Reapplies icon positions and frame size from current display settings
function PvPTracker:RefreshIconLayout()
    if not self.displayFrame then return end
    local ds = self.db.char.displaySettings or {}
    local iconSize = ds.iconSize or 32
    local layoutDir = ds.layoutDirection or "horizontal"
    local maxIcons = math.min(ds.maxDisplayIcons or MAX_DISPLAY_ICONS, MAX_DISPLAY_ICONS)
    self:ApplyIconLayout(self.displayFrame, iconSize, layoutDir, maxIcons)
    for i, icon in ipairs(self.displayFrame.iconFrames or {}) do
        icon:SetSize(iconSize, iconSize)
        self:SetIconPosition(icon, self.displayFrame, i, iconSize, layoutDir)
    end
end

--- Shows a preview of the PvP tracker display with sample cooldowns for 5 seconds
function PvPTracker:ShowTestDisplay()
    self:CreateDisplayFrame()
    if not self.displayFrame then return end

    local ds = self.db.char.displaySettings or {}
    local pos = ds.position or {}
    local iconSize = ds.iconSize or 32
    local scale = ds.scale or 1.0

    self:RefreshIconLayout()
    self.displayFrame:SetScale(scale)
    self.displayFrame:ClearAllPoints()
    local parent = self.displayFrame:GetParent()
    self.displayFrame:SetPoint(pos.point or "CENTER", parent, pos.relativePoint or "CENTER", pos.x or 0, pos.y or 150)

    self:PopulateFrameWithSamples(self.displayFrame)
    self.displayFrame:Show()
    self.displayFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    NAG:Print("PvP Tracker: Test display shown for 5 seconds. This is where cooldown icons appear in PvP.")

    local hideTest = function()
        if self.displayFrame then
            self.displayFrame:SetFrameStrata("LOW")
            if not self:IsEnabled() or not ns.IsInPvP() then
                self.displayFrame:Hide()
            else
                self:UpdateDisplay()
            end
        end
    end

    if C_Timer and C_Timer.After then
        C_Timer.After(5, hideTest)
    elseif NAG and NAG.ScheduleTimer then
        NAG:ScheduleTimer(hideTest, 5)
    end
end

--- Updates PvP frame visibility and draggability when /nag unlock is used
function PvPTracker:UpdatePvPFrameEditState()
    if not self:IsEnabled() then return end
    self:CreateDisplayFrame()
    local frame = self.displayFrame
    if not frame then return end

    local inEditMode = NAG.IsAnyEditMode and NAG:IsAnyEditMode()

    if inEditMode then
        local ds = self.db.char.displaySettings or {}
        frame:SetScale(ds.scale or 1.0)
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:Show()
        frame:EnableMouse(true)
        frame:EnableMouseWheel(true)
        frame:SetMovable(true)
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnMouseWheel", function(f, delta)
            if not (NAG.IsAnyEditMode and NAG:IsAnyEditMode()) then return end
            local ds = self.db.char.displaySettings or {}
            local scale = (ds.scale or 1.0) + (delta > 0 and 0.1 or -0.1)
            scale = math.max(0.5, math.min(2, scale))
            ds.scale = scale
            f:SetScale(scale)
        end)
        frame:SetScript("OnDragStart", function(f)
            if not (NAG.IsAnyEditMode and NAG:IsAnyEditMode()) then return end
            if UnitAffectingCombat and UnitAffectingCombat("player") then return end
            f:StartMoving()
        end)
        frame:SetScript("OnDragStop", function(f)
            f:StopMovingOrSizing()
            local point, _, relPoint, x, y = f:GetPoint()
            local ds = self.db.char.displaySettings or {}
            ds.position = ds.position or {}
            ds.position.point = point
            ds.position.relativePoint = relPoint or point
            ds.position.x = x
            ds.position.y = y
        end)
        -- Show sample icons so user can see what they're positioning
        self:PopulateFrameWithSamples(frame)
        for _, icon in ipairs(frame.iconFrames or {}) do
            icon:EnableMouse(false)
        end
    else
        frame:SetFrameStrata("LOW")
        frame:EnableMouse(false)
        frame:EnableMouseWheel(false)
        frame:SetMovable(false)
        frame:RegisterForDrag()
        frame:SetScript("OnDragStart", nil)
        frame:SetScript("OnDragStop", nil)
        frame:SetScript("OnMouseWheel", nil)
        if self:IsEnabled() and ns.IsInPvP() then
            self:UpdateDisplay()
        else
            frame:Hide()
        end
    end
end

--- Fills the display frame with sample cooldown icons (for edit mode / test display)
function PvPTracker:PopulateFrameWithSamples(frame)
    if not frame or not frame.iconFrames then return end
    local ds = self.db.char.displaySettings or {}
    local iconSize = ds.iconSize or 32
    local layoutDir = ds.layoutDirection or "horizontal"
    local maxIcons = math.min(ds.maxDisplayIcons or MAX_DISPLAY_ICONS, MAX_DISPLAY_ICONS)
    local enableSwipes = ds.enableCooldownSwipes ~= false
    local showBorders = ds.showCategoryBorders ~= false
    local showBadge = ds.showArenaBadge ~= false
    local showDR = ds.showDROverlay ~= false and self:IsDREnabled()
    local categoryColors = ds.categoryColors or DEFAULT_CATEGORY_COLORS
    local now = GetTime()

    self:ApplyIconLayout(frame, iconSize, layoutDir, maxIcons)
    for i, icon in ipairs(frame.iconFrames) do
        icon:SetSize(iconSize, iconSize)
        self:SetIconPosition(icon, frame, i, iconSize, layoutDir)
        local sample = TEST_DISPLAY_SAMPLES[i]
        if sample then
            local iconTexture
            if WoWAPI and WoWAPI.GetSpellInfo then
                local spellInfo = WoWAPI.GetSpellInfo(sample.spellId)
                if type(spellInfo) == "table" then iconTexture = spellInfo.icon or spellInfo[2] end
            end
            if not iconTexture and GetSpellTexture then
                iconTexture = GetSpellTexture(sample.spellId)
            end
            if icon.texture then
                icon.texture:SetTexture(iconTexture or FALLBACK_ICON)
            end

            if enableSwipes and icon.cooldown then
                local cdData = self:GetCooldownDataForSpell(sample.spellId)
                local duration = (cdData and cdData.duration) or sample.remaining
                local startTime = now - (duration - sample.remaining)
                icon.cooldown:SetCooldown(startTime, duration)
                icon.cooldown:Show()
            elseif icon.cooldown then
                icon.cooldown:Hide()
            end
            if icon.cdText then
                if enableSwipes then
                    icon.cdText:Hide()
                else
                    icon.cdText:SetText(format("%.1f", sample.remaining))
                    icon.cdText:Show()
                end
            end

            if showBorders and icon.borders and sample.category then
                local colors = categoryColors[sample.category] or { 1, 1, 1, 1 }
                local r, g, b, a = colors[1], colors[2], colors[3], colors[4] or 1
                if icon.SetBorderColor then
                    icon:SetBorderColor(r, g, b, a)
                else
                    for _, line in ipairs(icon.borders) do
                        line:SetColorTexture(r, g, b, a)
                    end
                end
                for _, line in ipairs(icon.borders) do
                    line:Show()
                end
            elseif icon.borders then
                for _, line in ipairs(icon.borders) do
                    line:Hide()
                end
            end

            if showBadge and icon.badge and sample.arenaUnit then
                local idx = strmatch(sample.arenaUnit, "^arena(%d)$")
                icon.badge:SetText(idx or "")
                icon.badge:Show()
            elseif icon.badge then
                icon.badge:Hide()
            end

            if showDR and icon.drOverlay and sample.drLevel then
                icon.drOverlay:SetText(tostring(sample.drLevel))
                icon.drOverlay:Show()
            elseif icon.drOverlay then
                icon.drOverlay:Hide()
            end

            icon:EnableMouse(self:ShouldEnableIconMouseForTooltips())
            icon:Show()
        else
            if icon.cooldown then icon.cooldown:Hide() end
            if icon.borders then
                for _, line in ipairs(icon.borders) do line:Hide() end
            end
            if icon.badge then icon.badge:Hide() end
            if icon.drOverlay then icon.drOverlay:Hide() end
            icon:Hide()
        end
    end
end

-- ============================ OPTIONS COMPOSER ============================

function PvPTracker:HandlePvPSlashCommand(input)
    input = (input and strtrim and strtrim(input)) or (input and input:match("^%s*(.-)%s*$")) or input or ""
    local cmd = (input == "" and "toggle") or input

    if cmd == "on" or cmd == "1" or cmd == "enable" then
        self:SetSetting("char", "enabled", true)
        self:Enable()
        NAG:Print("PvP Tracker enabled.")
    elseif cmd == "off" or cmd == "0" or cmd == "disable" then
        self:SetSetting("char", "enabled", false)
        self:Disable()
        NAG:Print("PvP Tracker disabled.")
    elseif cmd == "toggle" then
        local enabled = not self:GetSetting("char", "enabled", false)
        self:SetSetting("char", "enabled", enabled)
        if enabled then self:Enable() else self:Disable() end
        NAG:Print("PvP Tracker " .. (enabled and "enabled" or "disabled") .. ".")
    elseif cmd == "options" or cmd == "config" or cmd == "settings" then
        self:OpenOptions()
    else
        NAG:Print("PvP Tracker: Use |cff00ff00/nag pvptracker on|r, |cff00ff00off|r, |cff00ff00toggle|r, or |cff00ff00options|r to open settings.")
    end
end

--- Opens the PvP Tracker options panel
--- @param defer boolean If true, defers the open to next frame (use when called from Execute button to avoid AceConfigDialog rootframe nil)
function PvPTracker:OpenOptions(defer)
    local function doOpen()
        local AceConfigDialog = ns.AceConfigDialog
        if AceConfigDialog then
            if AceConfigDialog.SelectGroup and type(AceConfigDialog.SelectGroup) == "function" then
                AceConfigDialog:SelectGroup("NAG", "features", "PvPTracker")
            end
            if AceConfigDialog.Open and type(AceConfigDialog.Open) == "function" then
                AceConfigDialog:Open("NAG")
            end
        end
    end

    if defer then
        if C_Timer and C_Timer.After then
            C_Timer.After(0, doOpen)
        elseif NAG and NAG.ScheduleTimer then
            NAG:ScheduleTimer(doOpen, 0)
        else
            doOpen()
        end
    else
        doOpen()
    end
end

function PvPTracker:GetOptions()
    local OptionsFactory = NAG:GetModule("OptionsFactory", true)
    if not OptionsFactory then
        return { type = "group", args = {} }
    end

    return {
        type = "group",
        name = L["PvP Tracker"] or "PvP Tracker",
        desc = L["PvP Tracker Settings"] or "PvP Tracker Settings",
        order = 50,
        childGroups = "tab",
        args = {
            general = {
                type = "group",
                name = L["General"] or "General",
                order = 1,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        L["Enabled"] or "Enabled",
                        L["Track enemy cooldowns and DR in PvP"] or "Track enemy cooldowns and DR in PvP",
                        function() return self:GetSetting("char", "enabled", false) end,
                        function(_, v)
                            self:SetSetting("char", "enabled", v)
                            if v then self:Enable() else self:Disable() end
                        end,
                        { order = 1 }
                    ),
                    enableInDuels = OptionsFactory:CreateToggle(
                        L["PvP Enable In Duels"] or "Enable in Duels",
                        L["PvP Enable In Duels Desc"] or "Track duel opponent cooldowns/DR outside battlegrounds and arena.",
                        function() return self:GetSetting("char", "displaySettings.enableInDuels", true) end,
                        function(_, v)
                            self:SetSetting("char", "displaySettings.enableInDuels", v)
                            if not v and self.state then
                                self.state.duelActive = false
                                self.state.duelOpponentGUID = nil
                                self.state.duelOpponentName = nil
                            end
                            self:UpdateDisplay()
                        end,
                        {
                            order = 2,
                            disabled = function()
                                return not self:GetSetting("char", "enabled", false)
                            end
                        }
                    ),
                },
            },
            trackedCategories = {
                type = "group",
                name = L["PvP Tracked Categories"] or "Tracked Categories",
                order = 2,
                args = {
                    categoriesDesc = OptionsFactory:CreateDescription(
                        L["PvP Categories Desc"] or "Choose which enemy abilities to track and display. Disabled categories are neither recorded nor shown.",
                        nil,
                        { order = 0 }
                    ),
                    showInterrupts = OptionsFactory:CreateToggle(
                        L["PvP Track Interrupts"] or "Interrupts",
                        L["PvP Track Interrupts Desc"] or "Track interrupt cooldowns (Counterspell, Kick, etc.) and play sound when target/focus/arena enemy starts casting",
                        function() return self:GetSetting("char", "displaySettings.showInterrupts", true) end,
                        function(_, v)
                            self:SetSetting("char", "displaySettings.showInterrupts", v)
                            self:UpdateDisplay()
                        end,
                        { order = 1 }
                    ),
                    showDefensives = OptionsFactory:CreateToggle(
                        L["PvP Track Defensives"] or "Defensives",
                        L["PvP Track Defensives Desc"] or "Track defensive cooldowns (Ice Block, Shield Wall, Divine Shield, etc.)",
                        function() return self:GetSetting("char", "displaySettings.showDefensives", true) end,
                        function(_, v)
                            self:SetSetting("char", "displaySettings.showDefensives", v)
                            self:UpdateDisplay()
                        end,
                        { order = 2 }
                    ),
                    showCC = OptionsFactory:CreateToggle(
                        L["PvP Track CC"] or "Crowd Control",
                        L["PvP Track CC Desc"] or "Track CC ability cooldowns",
                        function() return self:GetSetting("char", "displaySettings.showCC", true) end,
                        function(_, v)
                            self:SetSetting("char", "displaySettings.showCC", v)
                            self:UpdateDisplay()
                        end,
                        { order = 3 }
                    ),
                    showDR = OptionsFactory:CreateToggle(
                        L["PvP Track DR"] or "Diminishing Returns",
                        L["PvP Track DR Desc"] or "Track diminishing returns on CC. Enables APL conditions like TargetDRReady, UnitDRRemaining",
                        function() return self:GetSetting("char", "displaySettings.showDR", true) end,
                        function(_, v) self:SetSetting("char", "displaySettings.showDR", v) end,
                        { order = 4 }
                    ),
                    alertsHeader = {
                        type = "header",
                        name = L["PvP Interrupt Alerts"] or "Interrupt Alerts",
                        order = 10,
                    },
                    interruptSoundEnabled = OptionsFactory:CreateToggle(
                        L["PvP Interrupt Sound Enabled"] or "Play Interrupt Sound",
                        L["PvP Interrupt Sound Enabled Desc"] or "Play a sound when an enemy starts casting (interrupt alert)",
                        function() return self:GetSetting("char", "displaySettings.interruptSoundEnabled", true) end,
                        function(_, v) self:SetSetting("char", "displaySettings.interruptSoundEnabled", v) end,
                        { order = 11 }
                    ),
                    interruptSoundKit = {
                        type = "select",
                        name = L["PvP Interrupt Sound"] or "Interrupt Sound",
                        desc = L["PvP Interrupt Sound Desc"] or "Sound to play when enemy starts casting",
                        values = {
                            RaidWarning = L["PvP Sound RaidWarning"] or "Raid Warning",
                            RaidBossEmote = L["PvP Sound RaidBossEmote"] or "Raid Boss Emote",
                        },
                        get = function() return self:GetSetting("char", "displaySettings.interruptSoundKit", "RaidWarning") end,
                        set = function(_, v) self:SetSetting("char", "displaySettings.interruptSoundKit", v) end,
                        order = 12,
                        disabled = function() return not self:GetSetting("char", "displaySettings.interruptSoundEnabled", true) end,
                    },
                },
            },
            display = {
                type = "group",
                name = L["Display"] or "Display",
                order = 3,
                childGroups = "tab",
                args = {
                    guide = {
                        type = "group",
                        name = L["PvP Display Guide"] or "Guide",
                        order = 0,
                        args = {
                            quickLegend = OptionsFactory:CreateDescription(
                                L["PvP Guide Quick Legend"] or
                                "Icon = enemy spell used.\n"
                                    .. "Sweep/number = cooldown remaining.\n"
                                    .. "Border colors: red=interrupt, green=defensive, blue=CC, gold=vulnerable target.\n"
                                    .. "Top-left number = arena enemy (1-3).\n"
                                    .. "Bottom-right number = DR level when available.",
                                nil,
                                { order = 1 }
                            ),
                            apiAvailability = OptionsFactory:CreateDescription(
                                L["PvP Guide API Availability"] or
                                "Usage tips:\n"
                                    .. "- Use Test Display to verify spacing and readability.\n"
                                    .. "- Unlock the frame to drag it, then lock it to prevent accidental moves.\n"
                                    .. "- Use mouse wheel while unlocked to fine-tune scale quickly.\n"
                                    .. "- Keep icon size and max icons balanced so the bar stays readable in combat.\n"
                                    .. "- Tooltips follow your configured modifier key (same as main display).",
                                nil,
                                { order = 2 }
                            ),
                        },
                    },
                    barLegend = OptionsFactory:CreateDescription(
                        L["PvP Bar Legend"] or "Bar Legend: Icon = spell used. Sweep = cooldown. Red = interrupt, Green = defensive, Blue = CC. Gold = vulnerable target. Top-left = arena enemy. Bottom-right = DR level (CC). Hold modifier key and hover for details.",
                        nil,
                        { order = 0.5 }
                    ),
                    layout = {
                        type = "group",
                        name = L["PvP Display Layout"] or "Layout",
                        order = 1,
                        args = {
                            displayPreset = {
                                type = "select",
                                name = L["PvP Display Preset"] or "Display Preset",
                                desc = L["PvP Display Preset Desc"] or "Apply a preset configuration for display options",
                                values = {
                                    custom = L["PvP Preset Custom"] or "Custom",
                                    minimal = L["PvP Preset Minimal"] or "Minimal",
                                    standard = L["PvP Preset Standard"] or "Standard",
                                    full = L["PvP Preset Full"] or "Full",
                                },
                                get = function()
                                    return self:GetSetting("char", "displaySettings._preset", "custom") or "custom"
                                end,
                                set = function(_, v)
                                    self:SetSetting("char", "displaySettings._preset", v)
                                    local ds = self.db.char.displaySettings or {}
                                    if v == "minimal" then
                                        ds.enableCooldownSwipes = true
                                        ds.showCategoryBorders = false
                                        ds.showTooltips = true
                                        ds.showArenaBadge = false
                                        ds.showDROverlay = false
                                        ds.showBurstIndicator = false
                                        ds.showVulnerableHighlight = false
                                        ds.showImmunityWarning = false
                                        ds.showSafeToCast = false
                                        ds.showDampening = false
                                    elseif v == "standard" then
                                        ds.enableCooldownSwipes = true
                                        ds.showCategoryBorders = true
                                        ds.showTooltips = true
                                        ds.showArenaBadge = true
                                        ds.showDROverlay = true
                                        ds.showBurstIndicator = false
                                        ds.showVulnerableHighlight = true
                                        ds.showImmunityWarning = true
                                        ds.showSafeToCast = false
                                        ds.showDampening = false
                                    elseif v == "full" then
                                        ds.enableCooldownSwipes = true
                                        ds.showCategoryBorders = true
                                        ds.showTooltips = true
                                        ds.showArenaBadge = true
                                        ds.showDROverlay = true
                                        ds.showBurstIndicator = true
                                        ds.showVulnerableHighlight = true
                                        ds.showImmunityWarning = true
                                        ds.showSafeToCast = true
                                        ds.showDampening = true
                                    end
                                    self:UpdateDisplay()
                                    self:RefreshOptions()
                                end,
                                order = 0,
                            },
                            layoutDirection = {
                                type = "select",
                                name = L["PvP Layout Direction"] or "Layout Direction",
                                desc = L["PvP Layout Direction Desc"] or "Arrange cooldown icons horizontally or vertically",
                                values = {
                                    horizontal = L["PvP Layout Horizontal"] or "Horizontal",
                                    vertical = L["PvP Layout Vertical"] or "Vertical",
                                },
                                get = function() return self:GetSetting("char", "displaySettings.layoutDirection", "horizontal") end,
                                set = function(_, v)
                                    self:SetSetting("char", "displaySettings.layoutDirection", v)
                                    self:RefreshIconLayout()
                                    self:UpdateDisplay()
                                end,
                                order = 0.5,
                            },
                            showArenaBadge = OptionsFactory:CreateToggle(
                                L["PvP Show Arena Badge"] or "Show Arena Badge",
                                L["PvP Show Arena Badge Desc"] or "Show arena number (1-3) on each cooldown icon",
                                function() return self:GetSetting("char", "displaySettings.showArenaBadge", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showArenaBadge", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 1 }
                            ),
                            iconSort = {
                                type = "select",
                                name = L["PvP Icon Sort"] or "Icon Sort",
                                desc = L["PvP Icon Sort Desc"] or "Sort icons by remaining time or by category (interrupt, defensive, cc)",
                                values = {
                                    time = L["PvP Sort Time"] or "Time",
                                    category = L["PvP Sort Category"] or "Category",
                                },
                                get = function() return self:GetSetting("char", "displaySettings.iconSort", "time") end,
                                set = function(_, v)
                                    self:SetSetting("char", "displaySettings.iconSort", v)
                                    self:UpdateDisplay()
                                end,
                                order = 2,
                            },
                        },
                    },
                    visuals = {
                        type = "group",
                        name = L["PvP Display Visuals"] or "Visuals",
                        order = 2,
                        args = {
                            showCooldowns = OptionsFactory:CreateToggle(
                                L["Show Cooldowns"] or "Show Cooldown Icons",
                                L["PvP Show Cooldowns Desc"] or "Display enemy cooldown icons on screen (master toggle for icon bar)",
                                function() return self:GetSetting("char", "displaySettings.showCooldowns", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showCooldowns", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 1 }
                            ),
                            enableCooldownSwipes = OptionsFactory:CreateToggle(
                                L["PvP Enable Cooldown Swipes"] or "Cooldown Swipes",
                                L["PvP Enable Cooldown Swipes Desc"] or "Show circular cooldown swipe on icons instead of numeric countdown",
                                function() return self:GetSetting("char", "displaySettings.enableCooldownSwipes", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.enableCooldownSwipes", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 2 }
                            ),
                            showCategoryBorders = OptionsFactory:CreateToggle(
                                L["PvP Show Category Borders"] or "Category Borders",
                                L["PvP Show Category Borders Desc"] or "Color icon borders by category (interrupt=red, defensive=green, cc=blue)",
                                function() return self:GetSetting("char", "displaySettings.showCategoryBorders", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showCategoryBorders", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 3 }
                            ),
                            showTooltips = OptionsFactory:CreateToggle(
                                L["PvP Show Tooltips"] or "Tooltips",
                                L["PvP Show Tooltips Desc"] or "Show spell name and remaining time on icon hover",
                                function() return self:GetSetting("char", "displaySettings.showTooltips", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showTooltips", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 4 }
                            ),
                            showDROverlay = OptionsFactory:CreateToggle(
                                L["PvP Show DR Overlay"] or "DR Overlay",
                                L["PvP Show DR Overlay Desc"] or "Show diminishing return level (1-3) on CC icons",
                                function() return self:GetSetting("char", "displaySettings.showDROverlay", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showDROverlay", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 5 }
                            ),
                            iconSize = OptionsFactory:CreateRange(
                                L["Icon Size"] or "Icon Size",
                                L["Size of PvP tracker icons"] or "Size of PvP tracker icons",
                                function() return self:GetSetting("char", "displaySettings.iconSize", 32) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.iconSize", math.max(16, math.min(64, v)))
                                    if self.displayFrame then
                                        self:RefreshIconLayout()
                                        self:UpdateDisplay()
                                    end
                                end,
                                { order = 6, min = 16, max = 64, step = 4 }
                            ),
                            scale = OptionsFactory:CreateRange(
                                L["Scale"] or "Scale",
                                L["Scale of the PvP tracker frame"] or "Scale of the PvP tracker frame",
                                function() return self:GetSetting("char", "displaySettings.scale", 1.0) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.scale", math.max(0.5, math.min(2, v)))
                                    if self.displayFrame then
                                        self.displayFrame:SetScale(v)
                                    end
                                end,
                                { order = 7, min = 0.5, max = 2, step = 0.1 }
                            ),
                        },
                    },
                    indicators = {
                        type = "group",
                        name = L["PvP Display Indicators"] or "Indicators",
                        order = 3,
                        args = {
                            showBurstIndicator = OptionsFactory:CreateToggle(
                                L["PvP Show Burst Indicator"] or "Burst Window",
                                L["PvP Show Burst Indicator Desc"] or "Show indicator when enemy burst window is open",
                                function() return self:GetSetting("char", "displaySettings.showBurstIndicator", false) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showBurstIndicator", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 1 }
                            ),
                            showVulnerableHighlight = OptionsFactory:CreateToggle(
                                L["PvP Show Vulnerable Highlight"] or "Vulnerable Target",
                                L["PvP Show Vulnerable Highlight Desc"] or "Highlight icons for targets with no defensives remaining",
                                function() return self:GetSetting("char", "displaySettings.showVulnerableHighlight", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showVulnerableHighlight", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 2 }
                            ),
                            showImmunityWarning = OptionsFactory:CreateToggle(
                                L["PvP Show Immunity Warning"] or "Immunity Warning",
                                L["PvP Show Immunity Warning Desc"] or "Show when target has immunity (Ice Block, Divine Shield, etc.)",
                                function() return self:GetSetting("char", "displaySettings.showImmunityWarning", true) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showImmunityWarning", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 3 }
                            ),
                            showSafeToCast = OptionsFactory:CreateToggle(
                                L["PvP Show Safe To Cast"] or "Safe to Cast",
                                L["PvP Show Safe To Cast Desc"] or "Show green check when target is safe to CC",
                                function() return self:GetSetting("char", "displaySettings.showSafeToCast", false) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showSafeToCast", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 4 }
                            ),
                            showDampening = OptionsFactory:CreateToggle(
                                L["PvP Show Dampening"] or "Dampening",
                                L["PvP Show Dampening Desc"] or "Show current dampening percent when in arena",
                                function() return self:GetSetting("char", "displaySettings.showDampening", false) end,
                                function(_, v)
                                    self:SetSetting("char", "displaySettings.showDampening", v)
                                    self:UpdateDisplay()
                                end,
                                { order = 5 }
                            ),
                        },
                    },
                    testPosition = {
                        type = "group",
                        name = L["PvP Test Position"] or "Test / Position",
                        order = 4,
                        args = {
                            testDisplay = OptionsFactory:CreateExecute(
                                L["Test Display"] or "Test Display",
                                L["PvP Test Display Desc"] or "Show a 5-second preview of where cooldown icons will appear",
                                function()
                                    self:ShowTestDisplay()
                                end,
                                { order = 1 }
                            ),
                            unlockToReposition = {
                                type = "execute",
                                name = function()
                                    return (NAG:IsAnyEditMode() and (L["PvP Lock Frame"] or "Lock Frame Position")) or (L["PvP Unlock To Reposition"] or "Unlock to Reposition")
                                end,
                                desc = L["PvP Unlock To Reposition Desc"] or "Unlock frame to drag and reposition the cooldown bar",
                                order = 2,
                                width = "double",
                                func = function()
                                    local dm = NAG:GetModule("DisplayManager", true)
                                    if NAG:IsAnyEditMode() then
                                        if dm and dm.IsGroupDisplayMode and dm:IsGroupDisplayMode() then
                                            dm:DisableEditMode()
                                        end
                                        if dm and dm.IsLegacyFrameEnabled and dm:IsLegacyFrameEnabled() then
                                            dm:ToggleFrameEditMode(false)
                                        end
                                        if dm then dm.classHelperEditMode = false end
                                        NAG:SendMessage("NAG_FRAME_UPDATED")
                                    else
                                        local didUnlock = false
                                        if dm and dm.IsGroupDisplayMode and dm:IsGroupDisplayMode() then
                                            dm:EnableEditMode()
                                            didUnlock = true
                                        end
                                        if dm and dm.IsLegacyFrameEnabled and dm:IsLegacyFrameEnabled() then
                                            dm:ToggleFrameEditMode(true)
                                            didUnlock = true
                                        end
                                        if not didUnlock and dm then
                                            dm.classHelperEditMode = true
                                            NAG:SendMessage("NAG_FRAME_UPDATED")
                                        end
                                    end
                                    local pvpMod = NAG:GetModule("PvPTracker", true)
                                    if pvpMod and pvpMod.UpdatePvPFrameEditState then
                                        pvpMod:UpdatePvPFrameEditState()
                                    end
                                    self:RefreshOptions()
                                end,
                            },
                        },
                    },
                },
            },
            advanced = {
                type = "group",
                name = L["Advanced"] or "Advanced",
                order = 4,
                args = {
                    advancedSettings = OptionsFactory:CreateToggle(
                        L["PvP Advanced Settings"] or "Show Advanced Options",
                        L["PvP Advanced Settings Desc"] or "Show additional configuration options for power users",
                        function() return self:GetSetting("char", "displaySettings.advancedSettings", false) end,
                        function(_, v) self:SetSetting("char", "displaySettings.advancedSettings", v) end,
                        { order = 0 }
                    ),
                    maxDisplayIcons = {
                        type = "range",
                        name = L["PvP Max Icons"] or "Max Icons",
                        desc = L["PvP Max Icons Desc"] or "Maximum number of cooldown icons to display (1-12)",
                        get = function() return self:GetSetting("char", "displaySettings.maxDisplayIcons", 12) end,
                        set = function(_, v)
                            self:SetSetting("char", "displaySettings.maxDisplayIcons", math.max(1, math.min(12, v)))
                            self:RefreshIconLayout()
                            self:UpdateDisplay()
                        end,
                        min = 1,
                        max = 12,
                        step = 1,
                        order = 1,
                        hidden = function() return not self:GetSetting("char", "displaySettings.advancedSettings", false) end,
                    },
                    customSpellsHeader = {
                        type = "header",
                        name = L["PvP Custom Spells"] or "Custom Tracked Spells",
                        order = 10,
                        hidden = function() return not self:GetSetting("char", "displaySettings.advancedSettings", false) end,
                    },
                    trackedSpellsDesc = {
                        type = "description",
                        name = function()
                            local mod = NAG:GetModule("PvPTracker", true)
                            if not mod then return "" end
                            local all = mod:GetAllTrackedSpells()
                            local builtIn, custom = 0, 0
                            for _, e in ipairs(all) do
                                if e.custom then custom = custom + 1 else builtIn = builtIn + 1 end
                            end
                            return format(
                                (L["PvP Tracked Spells Desc"] or "Built-in: %d spells. Custom: %d. Add below.\nFormat: spellId or spellId,duration,category (e.g. 871,480,defensive)"),
                                builtIn,
                                custom
                            )
                        end,
                        order = 11,
                        hidden = function() return not self:GetSetting("char", "displaySettings.advancedSettings", false) end,
                    },
                    printTrackedSpells = OptionsFactory:CreateExecute(
                        L["PvP Print Tracked Spells"] or "Print Tracked Spells to Chat",
                        L["PvP Print Tracked Spells Desc"] or "List all tracked spells (built-in + custom) in chat",
                        function()
                            local all = self:GetAllTrackedSpells()
                            NAG:Print(format("PvP Tracker: %d total spells", #all))
                            for _, e in ipairs(all) do
                                NAG:Print(format("  %s (%d) - %ds [%s]%s", self:GetSpellDisplayName(e.spellId), e.spellId, e.duration, e.category, e.custom and " |cff888888(custom)|r" or ""))
                            end
                        end,
                        { order = 11.5, hidden = function() return not self:GetSetting("char", "displaySettings.advancedSettings", false) end }
                    ),
                    addCustomSpell = OptionsFactory:CreateInput(
                        L["PvP Add Custom Spell"] or "Add Spell (ID or ID,duration,category)",
                        L["PvP Add Custom Spell Desc"] or "Enter spell ID, or 'id,duration,category'. Examples: 2139 | 871,480,defensive | Spell Name",
                        function() return "" end,
                        function(_, value)
                            if not value or value == "" then return end
                            local spellId, duration, category
                            local parts = { strmatch(value, "^%s*(%d+)%s*,%s*(%d+)%s*,%s*(%w+)%s*$") }
                            if parts[1] then
                                spellId, duration, category = tonumber(parts[1]), tonumber(parts[2]), parts[3]
                            else
                                local num = tonumber(value)
                                if num then
                                    spellId, duration, category = num, 24, "interrupt"
                                else
                                    if WoWAPI and WoWAPI.GetSpellInfo then
                                        local info = WoWAPI.GetSpellInfo(value)
                                        if type(info) == "table" and info.spellID then
                                            spellId = info.spellID
                                        elseif type(info) == "number" then
                                            spellId = info
                                        end
                                    end
                                    if not spellId and GetSpellInfo then
                                        local a, b, c, d, e, f, sid = GetSpellInfo(value)
                                        spellId = sid or (type(a) == "number" and a)
                                    end
                                    duration, category = 24, "interrupt"
                                end
                            end
                            if spellId and self:AddCustomSpell(spellId, duration, category) then
                                NAG:Print(format((L["PvP Spell Added"] or "PvP Tracker: Added %s (%d), %ds, %s"), self:GetSpellDisplayName(spellId), spellId, duration or 24, category or "interrupt"))
                                self:RefreshOptions()
                            elseif not spellId then
                                NAG:Print(L["PvP Invalid Spell"] or "PvP Tracker: Invalid spell ID or name.")
                            end
                        end,
                        { order = 12, hidden = function() return not self:GetSetting("char", "displaySettings.advancedSettings", false) end }
                    ),
                    customSpellsList = {
                        type = "group",
                        inline = true,
                        name = L["PvP Custom Spells List"] or "Your Custom Spells",
                        order = 13,
                        hidden = function() return not self:GetSetting("char", "displaySettings.advancedSettings", false) end,
                        args = (function()
                            local mod = NAG:GetModule("PvPTracker", true)
                            if not mod then return {} end
                            local args = {}
                            local custom = mod.db.global.trackedSpells
                            if custom then
                                local order = 1
                                for spellId, data in pairs(custom) do
                                    if data and data.duration then
                                        local key = "remove_" .. spellId
                                        local sid, dur, cat = spellId, data.duration, data.category or "interrupt"
                                        args[key] = {
                                            type = "execute",
                                            name = format("|cffff6666×|r %s (%d) - %ds [%s]", mod:GetSpellDisplayName(spellId), spellId, dur, cat),
                                            desc = L["PvP Remove Spell Desc"] or "Click to remove this spell from tracking",
                                            func = function()
                                                mod:RemoveCustomSpell(sid)
                                                mod:RefreshOptions()
                                            end,
                                            order = order,
                                        }
                                        order = order + 1
                                    end
                                end
                            end
                            if not next(args or {}) then
                                args.empty = {
                                    type = "description",
                                    name = L["PvP No Custom Spells"] or "No custom spells. Add one above.",
                                    order = 1,
                                }
                            end
                            return args
                        end)(),
                    },
                },
            },
        },
    }
end
