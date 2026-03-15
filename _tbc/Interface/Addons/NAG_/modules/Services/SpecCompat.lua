--- @module "NAG.SpecCompat"
--- Centralized specialization and talent API compatibility layer
---
--- Provides version-agnostic APIs that abstract differences between:
--- - Classic Era/SOD/TBC/Wrath (talent tabs)
--- - Cata/Mists/Retail (specializations)
---
--- All APIs return normalized table structures for consistent usage across versions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
--

-- ============================ LOCALIZE ============================

local _, ns = ...

-- ============================ ADDON ACCESS ============================

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ UTILITY MODULE ACCESS ============================

--- @type Version
local Version = ns.Version

-- ============================ LUA API LOCALIZATION ============================

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local ceil = ceil
local pairs = pairs
local type = type
local select = select
local tinsert = tinsert
local wipe = wipe
local sort = table.sort

-- Standard Lua functions
local GetTime = _G.GetTime

-- ============================ WOW API LOCALIZATION ============================

-- WoW APIs
local UnitClass = _G.UnitClass
local UnitLevel = _G.UnitLevel

-- Specialization/Talent APIs (direct access, no WoWAPI dependency)
local GetTalentTabInfo = _G.GetTalentTabInfo
local GetTalentInfo = _G.GetTalentInfo
local GetNumTalents = _G.GetNumTalents
local GetSpecializationInfoForClassID = _G.GetSpecializationInfoForClassID
local GetNumSpecializationsForClassID = _G.GetNumSpecializationsForClassID

-- ============================ CONSTANTS ============================

local REQUIRED_LEVEL_FOR_SPECS = 10

-- ============================ UNIFIED SPECID LOOKUP TABLE ============================
--- Unified lookup table: specID -> {class, specIndex}
--- Used for database migration and specID to specIndex conversion
--- Format: [specID] = {class = "CLASSNAME", specIndex = 1|2|3|4}
local SPECID_LOOKUP = {
    -- TBC / Wrath specIDs
    [161] = {class = "WARRIOR", specIndex = 1},  -- Arms
    [164] = {class = "WARRIOR", specIndex = 2},  -- Fury
    [163] = {class = "WARRIOR", specIndex = 3},  -- Protection
    [382] = {class = "PALADIN", specIndex = 1},  -- Holy
    [383] = {class = "PALADIN", specIndex = 2},  -- Protection
    [381] = {class = "PALADIN", specIndex = 3},  -- Retribution
    [361] = {class = "HUNTER", specIndex = 1},   -- Beast Mastery
    [363] = {class = "HUNTER", specIndex = 2},   -- Marksmanship
    [362] = {class = "HUNTER", specIndex = 3},   -- Survival
    [182] = {class = "ROGUE", specIndex = 1},    -- Assassination
    [181] = {class = "ROGUE", specIndex = 2},    -- Combat
    [183] = {class = "ROGUE", specIndex = 3},    -- Subtlety
    [201] = {class = "PRIEST", specIndex = 1},   -- Discipline
    [202] = {class = "PRIEST", specIndex = 2},   -- Holy
    [203] = {class = "PRIEST", specIndex = 3},   -- Shadow
    -- TBC/Wrath Shaman (261 conflicts with Mists Rogue, using Mists mapping below)
    [263] = {class = "SHAMAN", specIndex = 2},   -- Enhancement (same in all versions)
    [81] = {class = "MAGE", specIndex = 1},      -- Arcane
    [41] = {class = "MAGE", specIndex = 2},      -- Fire
    [61] = {class = "MAGE", specIndex = 3},      -- Frost
    [302] = {class = "WARLOCK", specIndex = 1},   -- Affliction
    [303] = {class = "WARLOCK", specIndex = 2},  -- Demonology
    [301] = {class = "WARLOCK", specIndex = 3},  -- Destruction
    [283] = {class = "DRUID", specIndex = 1},    -- Balance
    [281] = {class = "DRUID", specIndex = 2},    -- Feral (also used for index 3)
    [282] = {class = "DRUID", specIndex = 4},    -- Restoration
    -- Wrath Death Knight
    [398] = {class = "DEATHKNIGHT", specIndex = 1},  -- Blood
    [399] = {class = "DEATHKNIGHT", specIndex = 2},  -- Frost
    [400] = {class = "DEATHKNIGHT", specIndex = 3},  -- Unholy
    -- Cataclysm specIDs
    [746] = {class = "WARRIOR", specIndex = 1},   -- Arms
    [8115] = {class = "WARRIOR", specIndex = 2},  -- Fury
    [845] = {class = "WARRIOR", specIndex = 3},   -- Protection
    [831] = {class = "PALADIN", specIndex = 1},   -- Holy
    [839] = {class = "PALADIN", specIndex = 2},   -- Protection
    [855] = {class = "PALADIN", specIndex = 3},   -- Retribution
    [811] = {class = "HUNTER", specIndex = 1},    -- Beast Mastery
    [807] = {class = "HUNTER", specIndex = 2},    -- Marksmanship
    [809] = {class = "HUNTER", specIndex = 3},    -- Survival
    [760] = {class = "PRIEST", specIndex = 1},    -- Discipline
    [813] = {class = "PRIEST", specIndex = 2},    -- Holy
    [795] = {class = "PRIEST", specIndex = 3},    -- Shadow
    [2612] = {class = "SHAMAN", specIndex = 3},   -- Restoration
    [799] = {class = "MAGE", specIndex = 1},      -- Arcane
    [851] = {class = "MAGE", specIndex = 2},      -- Fire
    [823] = {class = "MAGE", specIndex = 3},      -- Frost
    [871] = {class = "WARLOCK", specIndex = 1},    -- Affliction
    [867] = {class = "WARLOCK", specIndex = 2},   -- Demonology
    [865] = {class = "WARLOCK", specIndex = 3},   -- Destruction
    [752] = {class = "DRUID", specIndex = 1},     -- Balance
    [750] = {class = "DRUID", specIndex = 2},     -- Feral (also used for index 3)
    [748] = {class = "DRUID", specIndex = 4},     -- Restoration
    -- Mists / Retail specIDs
    [71] = {class = "WARRIOR", specIndex = 1},    -- Arms
    [72] = {class = "WARRIOR", specIndex = 2},    -- Fury
    [73] = {class = "WARRIOR", specIndex = 3},    -- Protection
    [65] = {class = "PALADIN", specIndex = 1},    -- Holy
    [66] = {class = "PALADIN", specIndex = 2},    -- Protection
    [70] = {class = "PALADIN", specIndex = 3},    -- Retribution
    [253] = {class = "HUNTER", specIndex = 1},    -- Beast Mastery
    [254] = {class = "HUNTER", specIndex = 2},   -- Marksmanship
    [255] = {class = "HUNTER", specIndex = 3},   -- Survival
    [259] = {class = "ROGUE", specIndex = 1},     -- Assassination
    [260] = {class = "ROGUE", specIndex = 2},     -- Combat
    [261] = {class = "ROGUE", specIndex = 3},     -- Subtlety (Mists/Retail, conflicts with TBC Shaman Elemental)
    [256] = {class = "PRIEST", specIndex = 1},   -- Discipline
    [257] = {class = "PRIEST", specIndex = 2},   -- Holy
    [258] = {class = "PRIEST", specIndex = 3},   -- Shadow
    -- Mists/Retail Shaman (262=Elemental conflicts with TBC 262=Restoration, using Mists mapping)
    [262] = {class = "SHAMAN", specIndex = 1},    -- Elemental (Mists/Retail)
    [264] = {class = "SHAMAN", specIndex = 3},    -- Restoration (Mists/Retail)
    [62] = {class = "MAGE", specIndex = 1},      -- Arcane
    [63] = {class = "MAGE", specIndex = 2},      -- Fire
    [64] = {class = "MAGE", specIndex = 3},       -- Frost
    [265] = {class = "WARLOCK", specIndex = 1},   -- Affliction
    [266] = {class = "WARLOCK", specIndex = 2},  -- Demonology
    [267] = {class = "WARLOCK", specIndex = 3},   -- Destruction
    [102] = {class = "DRUID", specIndex = 1},    -- Balance
    [103] = {class = "DRUID", specIndex = 2},     -- Feral
    [104] = {class = "DRUID", specIndex = 3},    -- Guardian
    [105] = {class = "DRUID", specIndex = 4},     -- Restoration
    [250] = {class = "DEATHKNIGHT", specIndex = 1},  -- Blood
    [251] = {class = "DEATHKNIGHT", specIndex = 2},  -- Frost
    [252] = {class = "DEATHKNIGHT", specIndex = 3}, -- Unholy
    [268] = {class = "MONK", specIndex = 1},     -- Brewmaster
    [270] = {class = "MONK", specIndex = 2},      -- Mistweaver
    [269] = {class = "MONK", specIndex = 3},     -- Windwalker
    -- Retail-only classes
    [577] = {class = "DEMONHUNTER", specIndex = 1},  -- Havoc
    [581] = {class = "DEMONHUNTER", specIndex = 2},  -- Vengeance
    [1467] = {class = "EVOKER", specIndex = 1},      -- Devastation
    [1468] = {class = "EVOKER", specIndex = 2},      -- Preservation
    [1473] = {class = "EVOKER", specIndex = 3},      -- Augmentation
}

-- ============================ MODULE DEFAULTS ============================

local defaults = {
    global = {},
    char = {},
}

-- ============================ MODULE CREATION ============================

--- @class SpecCompat : CoreModule
local SpecCompat = NAG:CreateModule("SpecCompat", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,

    -- Event handlers for cache invalidation
    eventHandlers = {
        ACTIVE_TALENT_GROUP_CHANGED = "OnSpecChange",
        PLAYER_LEVEL_UP = "OnLevelUp",
        PLAYER_SPECIALIZATION_CHANGED = "OnSpecChange",
        -- Classic/TBC/Wrath: Talents changed may affect which tab has most points (spec detection)
        PLAYER_TALENT_UPDATE = "OnTalentUpdate",
        -- Classic/TBC/Wrath: Spending talent points may affect spec detection
        CHARACTER_POINTS_CHANGED = "OnTalentUpdate",
        -- Initial spec detection when entering world
        PLAYER_ENTERING_WORLD = "OnPlayerEnteringWorld",
    },
})

ns.SpecCompat = SpecCompat

-- ============================ MODULE VARIABLES ============================

-- Cache for current spec index
SpecCompat.cachedSpecIndex = nil
SpecCompat.cachedSpecIndexTime = 0

-- Cache for spec info per specIndex
SpecCompat.specInfoCache = {}

-- Last check time for availability
SpecCompat.lastAvailabilityCheck = 0
SpecCompat.cachedAvailability = nil

-- Debounced broadcast timer for NAG_SPEC_UPDATED
SpecCompat.specUpdatedBroadcastTimer = nil
-- Store trigger event for payload (captured at schedule time, payload captured at fire time)
SpecCompat.pendingSpecTriggerEvent = nil

-- Debounced broadcast timer for NAG_TALENTS_UPDATED
SpecCompat.talentsUpdatedBroadcastTimer = nil

-- ============================ LIFECYCLE METHODS ============================

function SpecCompat:ModuleInitialize()
    -- Initialize caches
    self.cachedSpecIndex = nil
    self.cachedSpecIndexTime = 0
    self.specInfoCache = {}
    self.lastAvailabilityCheck = 0
    self.cachedAvailability = nil
    self.specUpdatedBroadcastTimer = nil
    self.talentsUpdatedBroadcastTimer = nil
end

function SpecCompat:ModuleEnable()
    -- Invalidate cache on enable to ensure fresh data
    self:InvalidateCache()
end

function SpecCompat:ModuleDisable()
    -- Clear caches on disable
    self:InvalidateCache()

    -- Cancel any pending broadcast timers
    if self.specUpdatedBroadcastTimer then
        self:CancelTimer(self.specUpdatedBroadcastTimer)
        self.specUpdatedBroadcastTimer = nil
    end
    if self.talentsUpdatedBroadcastTimer then
        self:CancelTimer(self.talentsUpdatedBroadcastTimer)
        self.talentsUpdatedBroadcastTimer = nil
    end
    self.pendingSpecTriggerEvent = nil
end

-- ============================ EVENT HANDLERS ============================

--- Handle specialization change events
--- @param event string The event name
--- @param ... any Event arguments
function SpecCompat:OnSpecChange(event, ...)
    self:Debug("OnSpecChange: %s - invalidating cache", event)
    self:InvalidateCache()

    -- Broadcast spec update (debounced to avoid rapid re-broadcasts)
    self:ScheduleSpecUpdatedBroadcast(event)
end

--- Handle level up events
--- @param event string The event name
--- @param newLevel number The new player level
function SpecCompat:OnLevelUp(event, newLevel)
    self:Debug("OnLevelUp: Player reached level %d", newLevel)

    -- Invalidate availability cache if level crossed threshold
    if newLevel == REQUIRED_LEVEL_FOR_SPECS then
        self.cachedAvailability = nil
        self.lastAvailabilityCheck = 0
        -- Specs just became available - broadcast spec update
        self:InvalidateCache()
        self:ScheduleSpecUpdatedBroadcast(event)
    else
        -- Invalidate spec cache as specs may have become available
        self:InvalidateCache()
    end
end

--- Handle talent update events
--- Talent changes (PLAYER_TALENT_UPDATE, CHARACTER_POINTS_CHANGED) may affect:
--- - Spec detection (Classic/TBC/Wrath: which tab has most points)
--- - Talent state (all versions: which talents are active)
--- @param event string The event name
--- @param ... any Event arguments
function SpecCompat:OnTalentUpdate(event, ...)
    self:Debug("OnTalentUpdate: %s - processing talent update", event)

    -- For Classic/TBC/Wrath: talent changes may affect spec detection
    if Version and (Version:IsClassicEra() or Version:IsSoD() or Version:IsTBC() or Version:IsWrath()) then
        self:Debug("OnTalentUpdate: Invalidating cache (may affect spec detection)")
        self:InvalidateCache()

        -- Broadcast spec update (debounced to avoid rapid re-broadcasts)
        self:ScheduleSpecUpdatedBroadcast(event)
    end

    -- For all versions: broadcast talent update message (debounced)
    -- This allows StateManager and other modules to update talent state
    self:ScheduleTalentsUpdatedBroadcast(event)
end

--- Handle player entering world (initial spec detection)
--- @param event string The event name
--- @param isLogin boolean Whether this is a login
--- @param isReload boolean Whether this is a reload
function SpecCompat:OnPlayerEnteringWorld(event, isLogin, isReload)
    self:Debug("OnPlayerEnteringWorld: Player entered world - checking initial spec")

    -- Invalidate cache to ensure fresh detection
    self:InvalidateCache()

    -- Broadcast initial spec state (debounced)
    self:ScheduleSpecUpdatedBroadcast(event)
end

-- ============================ CACHE MANAGEMENT ============================

--- Invalidate all caches
function SpecCompat:InvalidateCache()
    self.cachedSpecIndex = nil
    self.cachedSpecIndexTime = 0
    wipe(self.specInfoCache)
end

--- Invalidate spec index cache only
function SpecCompat:InvalidateSpecIndexCache()
    self.cachedSpecIndex = nil
    self.cachedSpecIndexTime = 0
end

--- Debounced broadcast of NAG_SPEC_UPDATED to ensure consumers receive finalized spec state
--- Captures payload when timer fires (not when scheduled) to ensure final settled state
--- Typical WoW spec changes fire multiple events (exiting one spec, entering another) within 0.1-0.5 seconds
--- Delay of 1.0-1.5 seconds allows all events to settle before broadcasting final state
--- @param triggerEvent string|nil The triggering event (for payload diagnostics)
function SpecCompat:ScheduleSpecUpdatedBroadcast(triggerEvent)
    -- Cancel any pending broadcast timer
    if self.specUpdatedBroadcastTimer then
        self:CancelTimer(self.specUpdatedBroadcastTimer)
        self.specUpdatedBroadcastTimer = nil
    end

    -- Store trigger event (for payload diagnostics)
    -- Use most recent trigger event if multiple events fire in quick succession
    self.pendingSpecTriggerEvent = triggerEvent

    -- Delay of 1.5 seconds allows spec change events to settle
    -- Spec changes often fire multiple events: ACTIVE_TALENT_GROUP_CHANGED, PLAYER_SPECIALIZATION_CHANGED
    -- These typically fire within 0.1-0.5 seconds of each other
    -- 1.5 seconds ensures we capture the final settled state after all events have fired
    local delaySeconds = 1.5

    -- Schedule the broadcast - payload will be captured when timer fires
    self.specUpdatedBroadcastTimer = self:ScheduleTimer(function()
        self.specUpdatedBroadcastTimer = nil

        -- CRITICAL: Capture payload when timer fires (not when scheduled)
        -- This ensures we get the final settled spec state after all events have fired
        local specIndex = self:GetCurrentSpecIndex()
        local specInfo = specIndex and self:GetSpecInfo(specIndex)

        local payload = {
            triggerEvent = self.pendingSpecTriggerEvent,
            specName = specInfo and specInfo.name or nil,
            specIndex = specIndex,
            specRole = specInfo and specInfo.role or nil,
            specDescription = specInfo and specInfo.description or nil,
            specIcon = specInfo and specInfo.icon or nil,
            specPrimaryStat = specInfo and specInfo.primaryStat or nil,
            available = self:AreSpecsAvailable(),
            timestamp = GetTime()
        }

        -- Clear pending trigger event
        self.pendingSpecTriggerEvent = nil

        -- Broadcast the message with final settled state
        self:SendMessage("NAG_SPEC_UPDATED", payload)
    end, delaySeconds)
end

--- Debounced broadcast of NAG_TALENTS_UPDATED to ensure consumers receive finalized talent state
--- Captures payload when timer fires (not when scheduled) to ensure final settled state
--- Talent updates typically fire single events or rapid sequences within 0.1-0.3 seconds
--- Delay of 0.5 seconds allows talent APIs to stabilize (faster than spec APIs)
--- @param triggerEvent string|nil The triggering event (for payload diagnostics)
function SpecCompat:ScheduleTalentsUpdatedBroadcast(triggerEvent)
    -- Cancel any pending broadcast timer
    if self.talentsUpdatedBroadcastTimer then
        self:CancelTimer(self.talentsUpdatedBroadcastTimer)
        self.talentsUpdatedBroadcastTimer = nil
    end

    -- Delay of 0.5 seconds allows talent update events to settle
    -- Talent changes typically fire PLAYER_TALENT_UPDATE or CHARACTER_POINTS_CHANGED
    -- These APIs stabilize faster than spec APIs, so shorter delay is sufficient
    local delaySeconds = 0.5

    -- Schedule the broadcast - payload captured when timer fires
    -- triggerEvent is captured in closure (last event wins if multiple fire, which is fine for talents)
    self.talentsUpdatedBroadcastTimer = self:ScheduleTimer(function()
        self.talentsUpdatedBroadcastTimer = nil
        self:SendMessage("NAG_TALENTS_UPDATED", {
            triggerEvent = triggerEvent,
            timestamp = GetTime()
        })
    end, delaySeconds)
end

-- ============================ INTERNAL HELPER FUNCTIONS ============================

--- Get total talent points spent across all tabs (Classic Era/SOD/TBC/Wrath)
--- Used to detect 0-talent state for generic rotation (specIndex 0)
--- @return number Total points spent, or 0 if API unavailable
function SpecCompat:GetTotalTalentPointsSpent()
    local numTabs = MAX_TALENT_TABS or 3
    if not numTabs or numTabs < 1 then
        return 0
    end

    local total = 0

    if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo then
        local inspectTarget = nil
        local sex = nil
        local isInspect = false
        local isPet = false
        local groupIndex = nil

        for tabIndex = 1, numTabs do
            local specId, name, description, icon, role, primaryStat, pointsSpent = C_SpecializationInfo.GetSpecializationInfo(tabIndex, isInspect, isPet, inspectTarget, sex, groupIndex)
            if pointsSpent and pointsSpent > 0 then
                total = total + pointsSpent
            end
        end
    elseif _G.GetTalentTabInfo then
        for tabIndex = 1, numTabs do
            local id, name, description, icon, pointsSpent = _G.GetTalentTabInfo(tabIndex)
            if pointsSpent and pointsSpent > 0 then
                total = total + pointsSpent
            end
        end
    end

    return total
end

--- Detect active talent tab for Classic Era/SOD/TBC/Wrath
--- Prefers C_SpecializationInfo.GetSpecializationInfo when available (Cata+)
--- Falls back to _G.GetTalentTabInfo for Classic Era if C_SpecializationInfo unavailable
--- @return number|nil The talent tab index (1-3) or nil if unavailable
function SpecCompat:DetectTalentTab()
    local numTabs = MAX_TALENT_TABS or 3

    -- Validate numTabs before iterating (may be nil if API unavailable)
    if not numTabs or numTabs < 1 then
        return 1  -- Default to first spec if talent tabs unavailable
    end

    local maxPoints = 0
    local activeTab = 1

    -- Prefer C_SpecializationInfo.GetSpecializationInfo when available (Cata+)
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo then
        local inspectTarget = nil
        local sex = nil
        local isInspect = false
        local isPet = false
        local groupIndex = nil

        for tabIndex = 1, numTabs do
            -- Cata/TBC/Vanilla/Wrath: groupIndex supported, pointsSpent available
            -- Note: This function is only called for Classic Era/SOD/TBC/Wrath, so MoP+ won't reach here
            local specId, name, description, icon, role, primaryStat, pointsSpent = C_SpecializationInfo.GetSpecializationInfo(tabIndex, isInspect, isPet, inspectTarget, sex, groupIndex)
            if pointsSpent and pointsSpent > maxPoints then
                maxPoints = pointsSpent
                activeTab = tabIndex
            end
        end
    elseif _G.GetTalentTabInfo then
        -- Classic Era fallback: Use deprecated GetTalentTabInfo
        for tabIndex = 1, numTabs do
            -- GetTalentTabInfo returns: (id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked)
            local id, name, description, icon, pointsSpent = _G.GetTalentTabInfo(tabIndex)
            if pointsSpent and pointsSpent > maxPoints then
                maxPoints = pointsSpent
                activeTab = tabIndex
            end
        end
    else
        return 1  -- Default to first spec if no API available
    end

    return activeTab
end

--- Get specialization index using version-specific logic
--- Returns 0 when no talent points spent (TBC/Wrath) or no spec selected (MoP/Cata) for generic rotation.
--- @return number|nil The specialization index (0 = generic), or nil if unavailable
function SpecCompat:GetCurrentSpecIndexInternal()
    -- Classic Era/SOD/TBC/Wrath: Use talent tab detection; return 0 when no points spent
    if Version and (Version:IsClassicEra() or Version:IsSoD() or Version:IsTBC() or Version:IsWrath()) then
        local totalPoints = self:GetTotalTalentPointsSpent()
        if totalPoints == 0 then
            return 0  -- Generic / no talents
        end
        return self:DetectTalentTab()
    end

    -- Cata/Mists/Retail: Use specialization API; return 0 when no spec selected
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
        local spec = C_SpecializationInfo.GetSpecialization()
        if spec and spec > 0 then
            -- Some versions/states can return stale or non-spec indices (e.g. starter characters).
            -- Normalize out-of-range values to Generic (0) so selection logic remains stable.
            local maxSpecs = self:GetNumSpecsForClass()
            if maxSpecs and spec > maxSpecs then
                self:Debug("GetCurrentSpecIndexInternal: Normalizing out-of-range spec index %s to 0 (max=%s)",
                    tostring(spec), tostring(maxSpecs))
                return 0
            end
            return spec
        end
        return 0  -- No spec selected -> generic
    elseif _G.GetSpecialization then
        local spec = _G.GetSpecialization()
        if spec and spec > 0 then
            -- Some versions/states can return stale or non-spec indices (e.g. starter characters).
            -- Normalize out-of-range values to Generic (0) so selection logic remains stable.
            local maxSpecs = self:GetNumSpecsForClass()
            if maxSpecs and spec > maxSpecs then
                self:Debug("GetCurrentSpecIndexInternal: Normalizing out-of-range spec index %s to 0 (max=%s)",
                    tostring(spec), tostring(maxSpecs))
                return 0
            end
            return spec
        end
        return 0  -- No spec selected -> generic
    end

    return 0
end

--- Get talent tab info for Classic Era/SOD/TBC/Wrath
--- Prefers C_SpecializationInfo.GetSpecializationInfo when available (Cata+)
--- Falls back to _G.GetTalentTabInfo for Classic Era if C_SpecializationInfo unavailable
--- @param tabIndex number The talent tab index (1-3) or specialization index
--- @return table|nil SpecInfo table or nil if not found
function SpecCompat:GetTalentTabInfo(tabIndex)
    if not tabIndex or tabIndex < 1 then
        return nil
    end

    local id, name, description, icon, role, primaryStat

    -- Prefer C_SpecializationInfo.GetSpecializationInfo when available (Cata+)
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo then
        local inspectTarget = nil
        local sex = nil
        local isInspect = false
        local isPet = false
        local groupIndex = nil

        -- Cata: groupIndex is supported
        -- MoP+: groupIndex is not supported
        local specId, specName, specDesc, specIcon, specRole, specPrimaryStat, pointsSpent, background, previewPointsSpent, isUnlocked
        if Version and Version:IsMists() then
            -- MoP+: groupIndex not supported
            specId, specName, specDesc, specIcon, specRole, specPrimaryStat, pointsSpent, background, previewPointsSpent, isUnlocked = C_SpecializationInfo.GetSpecializationInfo(tabIndex, isInspect, isPet, inspectTarget, sex)
        else
            -- Cata/TBC/Vanilla/Wrath: groupIndex supported
            specId, specName, specDesc, specIcon, specRole, specPrimaryStat, pointsSpent, background, previewPointsSpent, isUnlocked = C_SpecializationInfo.GetSpecializationInfo(tabIndex, isInspect, isPet, inspectTarget, sex, groupIndex)
        end

        if not specName then
            return nil
        end

        id = specId
        name = specName
        description = specDesc
        icon = specIcon
        role = specRole or "DPS"  -- Use role from API if available
        primaryStat = specPrimaryStat
    elseif _G.GetTalentTabInfo then
        -- Classic Era fallback: Use deprecated GetTalentTabInfo
        -- Returns: (id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked)
        id, name, description, icon = _G.GetTalentTabInfo(tabIndex)
        if not name then
            return nil
        end

        -- Map talent tab to a role (heuristic based on tab name/description)
        role = "DPS"  -- Default role
        if name and description then
            local nameLower = name:lower()
            local descLower = description:lower()
            if nameLower:find("tank") or descLower:find("tank") or nameLower:find("protection") or descLower:find("protection") then
                role = "TANK"
            elseif nameLower:find("heal") or descLower:find("heal") or nameLower:find("holy") or descLower:find("holy") or nameLower:find("restoration") or descLower:find("restoration") then
                role = "HEALER"
            end
        end
        primaryStat = nil  -- Not available for Classic Era talent tabs
    else
        return nil
    end

    return {
        index = tabIndex,
        name = name,
        description = description or "",
        icon = icon or 0,
        role = role or "DPS",
        primaryStat = primaryStat,  -- Available in Cata+ via C_SpecializationInfo
        specID = id,
    }
end

--- Get modern specialization info for Cata/Mists/Retail
--- Uses GetSpecializationInfoForClassID (global function, available in Cata/Mists/Retail)
--- Handles both table returns (Retail) and positional returns (Cata/Mists)
--- @param classID number The class ID
--- @param specIndex number The specialization index (1-based)
--- @return table|nil SpecInfo table or nil if not found
function SpecCompat:GetModernSpecInfo(classID, specIndex)
    if not classID or not specIndex then
        return nil
    end

    local name, description, icon, role, primaryStat, specID

    -- GetSpecializationInfoForClassID is a global function (not in C_SpecializationInfo)
    -- Available in Cata/Mists/Retail, returns table in Retail, positional in Cata/Mists
    if GetSpecializationInfoForClassID then
        local specInfo = GetSpecializationInfoForClassID(classID, specIndex)
        if not specInfo then
            return nil
        end

        -- Handle both table and positional returns
        if type(specInfo) == "table" then
            -- Modern API (Retail): Returns table
            name = specInfo.specName or specInfo.name
            description = specInfo.description
            icon = specInfo.iconTexture or specInfo.icon
            role = specInfo.role
            primaryStat = specInfo.primaryStat
            specID = specInfo.id or specInfo.specID
        else
            -- Cata/Mists: Positional returns: (id, name, description, icon, role, recommended, allowedForBoost, masterySpell1, masterySpell2)
            -- specInfo is the first return value (id), need to get all values
            local results = { GetSpecializationInfoForClassID(classID, specIndex) }
            specID = results[1]
            name = results[2]
            description = results[3]
            icon = results[4]
            role = results[5]
            primaryStat = nil  -- Not in positional returns for older APIs
        end
    else
        return nil
    end

    if not name then
        return nil
    end

    return {
        index = specIndex,
        name = name,
        description = description or "",
        icon = icon or 0,
        role = role or "DPS",
        primaryStat = primaryStat,
        specID = specID,
    }
end

-- ============================ PUBLIC API ============================

--- Get the current active specialization index
--- Returns current spec index (1-4) or talent tab index (1-3) depending on version
--- @return number|nil The current specialization index or nil if unavailable
function SpecCompat:GetCurrentSpecIndex()
    -- Check cache first
    if self.cachedSpecIndex ~= nil then
        return self.cachedSpecIndex
    end

    -- Get fresh value
    local specIndex = self:GetCurrentSpecIndexInternal()

    -- Cache the result
    self.cachedSpecIndex = specIndex
    self.cachedSpecIndexTime = GetTime()

    return specIndex
end

--- Synthetic spec info for specIndex 0 (Generic / no talents)
--- Used when no talent points are spent or no spec is selected.
local GENERIC_SPEC_INFO = {
    index = 0,
    name = "Generic",
    description = "Low-level abilities before choosing a specialization",
    icon = 0,
    role = "DPS",
    primaryStat = nil,
    specID = 0,
}

--- Get specialization information for a given spec index
--- @param specIndex number|nil The specialization index (optional, uses current if nil)
--- @return table|nil SpecInfo table with fields: index, name, description, icon, role, primaryStat, specID
function SpecCompat:GetSpecInfo(specIndex)
    specIndex = specIndex or self:GetCurrentSpecIndex()
    if specIndex == nil then
        return nil
    end

    -- specIndex 0: Generic / no talents (synthetic, no WoW tab)
    if specIndex == 0 then
        return GENERIC_SPEC_INFO
    end

    -- Check cache first
    if self.specInfoCache[specIndex] then
        return self.specInfoCache[specIndex]
    end

    local specInfo = nil
    local classID = select(3, UnitClass("player"))

    -- Version-specific routing
    if Version and (Version:IsClassicEra() or Version:IsSoD() or Version:IsTBC() or Version:IsWrath()) then
        specInfo = self:GetTalentTabInfo(specIndex)
    else
        -- Cata, Mists, and Retail all use the same API
        specInfo = self:GetModernSpecInfo(classID, specIndex)
    end

    -- Cache the result
    if specInfo then
        self.specInfoCache[specIndex] = specInfo
    end

    return specInfo
end

--- Get specialization name for a given spec index
--- @param specIndex number|nil The specialization index (optional, uses current if nil)
--- @return string|nil The specialization name or nil if not found
function SpecCompat:GetSpecName(specIndex)
    local specInfo = self:GetSpecInfo(specIndex)
    return specInfo and specInfo.name or nil
end

--- Get specialization role for a given spec index
--- @param specIndex number|nil The specialization index (optional, uses current if nil)
--- @return string|nil The specialization role ("TANK", "DPS", "HEALER") or nil if not found
function SpecCompat:GetSpecRole(specIndex)
    local specInfo = self:GetSpecInfo(specIndex)
    return specInfo and specInfo.role or nil
end

--- Get the number of specializations for a given class
--- @param classID number|nil The class ID (optional, uses player's class if nil)
--- @return number|nil The number of specializations or nil if unavailable
function SpecCompat:GetNumSpecsForClass(classID)
    classID = classID or select(3, UnitClass("player"))
    if not classID then
        return nil
    end

    -- Classic Era/SOD/TBC/Wrath: Always 3 talent tabs
    if Version and (Version:IsClassicEra() or Version:IsSoD() or Version:IsTBC() or Version:IsWrath()) then
        return 3
    end

    -- Cata/Mists/Retail: Use API
    if C_SpecializationInfo and C_SpecializationInfo.GetNumSpecializationsForClassID then
        return C_SpecializationInfo.GetNumSpecializationsForClassID(classID)
    elseif GetNumSpecializationsForClassID then
        return GetNumSpecializationsForClassID(classID)
    end
    return nil
end

--- Check if specializations are available
--- @return boolean True if specializations are available, false otherwise
function SpecCompat:AreSpecsAvailable()
    local now = GetTime()

    -- Check cache (valid for 5 seconds)
    if self.cachedAvailability ~= nil and (now - self.lastAvailabilityCheck) < 5.0 then
        return self.cachedAvailability
    end

    local playerLevel = UnitLevel("player")
    local canHaveSpecs = playerLevel >= REQUIRED_LEVEL_FOR_SPECS

    local specAvailable = false
    if canHaveSpecs then
        local versionInfo = Version and Version:GetVersionInfo()
        if versionInfo and not (versionInfo.isClassicEra or versionInfo.isTBC or versionInfo.isWrath) then
            -- Retail/Mists/Cata have specializations
            specAvailable = true
        elseif versionInfo and (versionInfo.isClassicEra or versionInfo.isTBC or versionInfo.isWrath) then
            -- Classic/TBC/Wrath: check if we can detect talent tab
            local currentSpec = self:GetCurrentSpecIndexInternal()
            specAvailable = currentSpec ~= nil
        end
    end

    -- Cache the result
    self.cachedAvailability = specAvailable
    self.lastAvailabilityCheck = now

    return specAvailable
end

--- Get talent information
--- Uses C_SpecializationInfo.GetTalentInfo when available (all modern versions)
--- Falls back to _G.GetTalentInfo only for Classic Era if C_SpecializationInfo unavailable
--- @param tabIndex number|nil The talent tab index (specializationIndex for Cata+, ignored for MoP+)
--- @param talentIndex number The talent index
--- @param isInspect boolean|nil Whether to get for inspect target
--- @param isPet boolean|nil Whether it's a pet talent (not supported in MoP+)
--- @param groupIndex number|nil The spec group index
--- @return table|nil TalentInfo table or nil if not found
function SpecCompat:GetTalentInfo(tabIndex, talentIndex, isInspect, isPet, groupIndex)
    if not talentIndex then
        return nil
    end

    -- Always prefer C_SpecializationInfo.GetTalentInfo when available (Cata/Mists/Retail)
    if C_SpecializationInfo and C_SpecializationInfo.GetTalentInfo then
        local talentInfoQuery = {}
        local talentInfo

        -- MoP+ (5.5.x+): Use tier/column (tabIndex, talentIndex, isPet not supported)
        if Version and Version:IsMists() then
            local numColumns = 3
            talentInfoQuery.tier = ceil(talentIndex / numColumns)
            talentInfoQuery.column = (talentIndex - 1) % numColumns + 1 -- Ensure column is 1, 2, or 3
            talentInfoQuery.groupIndex = groupIndex
            talentInfoQuery.isInspect = isInspect
            talentInfoQuery.target = nil
        else
            -- Cata/TBC/Vanilla/Wrath: Use specializationIndex/talentIndex
            talentInfoQuery.specializationIndex = tabIndex
            talentInfoQuery.talentIndex = talentIndex
            talentInfoQuery.isInspect = isInspect
            talentInfoQuery.isPet = isPet
            talentInfoQuery.groupIndex = groupIndex
        end

        talentInfo = C_SpecializationInfo.GetTalentInfo(talentInfoQuery)
        if not talentInfo then
            return nil
        end

        -- Return normalized table structure matching TalentInfoResult
        -- Note: In MoP+, some fields (rank, maxRank, etc.) may have default values
        return {
            talentID = talentInfo.talentID,
            name = talentInfo.name,
            icon = talentInfo.icon,
            tier = talentInfo.tier,
            column = talentInfo.column,
            selected = talentInfo.selected,
            available = talentInfo.available,
            spellID = talentInfo.spellID,
            isPVPTalentUnlocked = talentInfo.isPVPTalentUnlocked,
            known = talentInfo.known,
            grantedByAura = talentInfo.grantedByAura,
            rank = talentInfo.rank,
            maxRank = talentInfo.maxRank,
            meetsPrereq = talentInfo.meetsPrereq,
            previewRank = talentInfo.previewRank,
            meetsPreviewPrereq = talentInfo.meetsPreviewPrereq,
            isExceptional = talentInfo.isExceptional,
            hasGoldBorder = talentInfo.hasGoldBorder
        }
    elseif GetTalentInfo then
        -- Classic Era only: Fall back to _G.GetTalentInfo if C_SpecializationInfo unavailable
        -- Classic API returns: name, icon, tier, column, rank, maxRank, meetsPrereq, previewRank, meetsPreviewPrereq, isExceptional, hasGoldBorder, talentID
        local name, icon, tier, column, rank, maxRank, meetsPrereq, previewRank, meetsPreviewPrereq, isExceptional, hasGoldBorder, talentID = GetTalentInfo(tabIndex, talentIndex, isInspect, isPet, groupIndex)
        if not name then
            return nil
        end
        -- Return normalized structure matching TalentInfoResult (with defaults for Classic-only fields)
        return {
            talentID = talentID or 0,
            name = name,
            icon = icon or 0,
            tier = tier or 0,
            column = column or 0,
            selected = false,  -- Not available in Classic API
            available = false,  -- Not available in Classic API
            spellID = 0,  -- Not available in Classic API
            isPVPTalentUnlocked = false,  -- Not available in Classic API
            known = false,  -- Not available in Classic API
            grantedByAura = false,  -- Not available in Classic API
            rank = rank or 0,
            maxRank = maxRank or 0,
            meetsPrereq = meetsPrereq or false,
            previewRank = previewRank or 0,
            meetsPreviewPrereq = meetsPreviewPrereq or false,
            isExceptional = isExceptional or false,
            hasGoldBorder = hasGoldBorder or false
        }
    else
        return nil
    end
end

--- Get the number of talents in a talent tab
--- @param tabIndex number|nil The talent tab index (optional)
--- @param isInspect boolean|nil Whether to get for inspect target (optional, defaults to false)
--- @return number The number of talents
function SpecCompat:GetNumTalents(tabIndex, isInspect)
    -- MoP: 6 tiers * 3 columns = 18 talents total
    if Version and Version:IsMists() then
        return 18
    end

    -- Classic/TBC/Wrath: per-tab talent count
    -- TBC requires isInspect parameter (defaults to false for player talents)
    if GetNumTalents then
        return GetNumTalents(tabIndex, isInspect or false)
    end

    return 0
end

--- Get the number of talent tabs
--- @return number The number of talent tabs (3 for Classic Era/SOD/TBC/Wrath, 0 for others)
function SpecCompat:GetNumTalentTabs()
    -- Classic Era/SOD/TBC/Wrath only
    if Version and (Version:IsClassicEra() or Version:IsSoD() or Version:IsTBC() or Version:IsWrath()) then
        return MAX_TALENT_TABS or 3
    end
    return 0
end

--- Get comprehensive specialization status information
--- @return table SpecializationStatus table with fields: available, canHaveSpecs, playerLevel, requiredLevel, specIndex, specName, lastCheck
function SpecCompat:GetSpecializationStatus()
    local playerLevel = UnitLevel("player")
    local canHaveSpecs = playerLevel >= REQUIRED_LEVEL_FOR_SPECS
    local specIndex = self:GetCurrentSpecIndex()
    local specName = specIndex and self:GetSpecName(specIndex) or nil

    return {
        available = self:AreSpecsAvailable(),
        canHaveSpecs = canHaveSpecs,
        playerLevel = playerLevel,
        requiredLevel = REQUIRED_LEVEL_FOR_SPECS,
        specIndex = specIndex,
        specName = specName,
        lastCheck = self.lastAvailabilityCheck,
    }
end

--- Convert specID to specIndex for a given class
--- Uses unified lookup table that includes all specIDs from all game versions
--- @param specID number The specialization ID
--- @param className string The class name (e.g., "WARRIOR")
--- @return number|nil The specIndex (1-4) or nil if conversion failed
function SpecCompat:ConvertSpecIDToSpecIndex(specID, className)
    if not specID or not className then
        return nil
    end

    local mapping = SPECID_LOOKUP[specID]
    if mapping and mapping.class == className:upper() then
        return mapping.specIndex
    end

    return nil
end

--- Convert specIndex to specID for a given class
--- Uses unified lookup table that includes all specIDs from all game versions
--- Note: Returns the first matching specID if multiple exist (e.g., different game versions)
--- @param specIndex number The specialization index (1-4)
--- @param className string The class name (e.g., "WARRIOR")
--- @return number|nil The specID or nil if conversion failed
function SpecCompat:ConvertSpecIndexToSpecID(specIndex, className)
    if not specIndex or not className then
        return nil
    end

    className = className:upper()

    -- Iterate through lookup table to find matching specIndex and class
    -- Note: Multiple specIDs may map to same specIndex (different game versions)
    -- We return the highest specID, prioritizing more recent versions (higher specIDs typically)
    local bestSpecID = nil

    for specID, mapping in pairs(SPECID_LOOKUP) do
        if mapping.class == className and mapping.specIndex == specIndex then
            -- Prefer higher specIDs (typically more recent versions)
            if not bestSpecID or specID > bestSpecID then
                bestSpecID = specID
            end
        end
    end

    return bestSpecID
end

--- Get all specIDs for a given specIndex and class
--- Useful when multiple specIDs map to the same specIndex (different game versions)
--- @param specIndex number The specialization index (1-4)
--- @param className string The class name (e.g., "WARRIOR")
--- @return table|nil Array of specIDs or nil if none found
function SpecCompat:GetAllSpecIDsForSpecIndex(specIndex, className)
    if not specIndex or not className then
        return nil
    end

    className = className:upper()
    local specIDs = {}

    for specID, mapping in pairs(SPECID_LOOKUP) do
        if mapping.class == className and mapping.specIndex == specIndex then
            tinsert(specIDs, specID)
        end
    end

    if #specIDs > 0 then
        -- Sort by specID (typically higher = more recent)
        sort(specIDs)
        return specIDs
    end

    return nil
end

--- Get the specID lookup table (for migration and other uses)
--- @return table The specID lookup table: [specID] = {class = "CLASSNAME", specIndex = 1|2|3|4}
function SpecCompat:GetSpecIDLookup()
    return SPECID_LOOKUP
end

