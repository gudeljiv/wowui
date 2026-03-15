--- @module "NAG.tbc.HealingStateManager"
--- Tracks mouseover and group healing state for TBC 2.5.5 healing rotations.
--- Populates NAG.state.healing (mouseover + group); APL handlers read from state.
--- TBC has NO UnitGetTotalHealAbsorbs and NO UnitGroupRolesAssigned.
---
--- License: CC BY-NC 4.0
--- Authors: NAG Team

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitIsUnit = _G.UnitIsUnit
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsFriend = _G.UnitIsFriend
local GetNumGroupMembers = _G.GetNumGroupMembers
local GetNumRaidMembers = _G.GetNumRaidMembers or GetNumGroupMembers
local GetNumPartyMembers = _G.GetNumPartyMembers or function() return GetNumGroupMembers() end
local IsInRaid = _G.IsInRaid
local GetTime = _G.GetTime
local max = math.max

-- ============================ CONSTANTS ============================

local GROUP_UPDATE_THROTTLE = 0.3 -- Seconds between full group scans
local MAX_GROUP_SIZE = 40

-- nil = use spec-based default (enabled on healing specs only, disabled on DPS/tank)
local defaults = {
    char = {
        enabled = nil,
        healthThreshold = 80
    }
}

local HealingStateManager = NAG:CreateModule("HealingStateManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "features",
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
    eventHandlers = {
        UPDATE_MOUSEOVER_UNIT = true,
        UNIT_HEALTH = true,
        UNIT_AURA = "OnUnitAura",
        GROUP_ROSTER_UPDATE = true,
        PLAYER_ENTERING_WORLD = true
    },
    optionsComposers = {
        ["splash"] = true
    }
})

-- ============================ STATE INIT ============================

--- Reusable state tables
local healingState = {
    mouseover = {
        exists = false,
        health = { pct = 100 },
        effectiveHealth = { pct = 100 }, -- Same as health in TBC (no heal absorbs)
        is_self = false,
        isTank = false,
        role = nil,
        dispel = false,
        healAbsorb = 0
    },
    group = {
        low_health_count = 0,
        heal_needed = false,
        lastUpdate = 0,
        memberCount = 0,
        units = {}
    }
}

--- Ensure NAG.state.healing exists
local function ensureHealingState()
    if not NAG.state then return end
    if NAG.state.healing ~= healingState then
        NAG.state.healing = healingState
    end
end

-- ============================ HEALING SPEC DETECTION ============================

--- Healer spec indices per class (TBC): Priest 1,2; Druid 4; Paladin 1; Shaman 3 (no Monk)
local HEALER_SPEC_BY_CLASS = {
    PRIEST = { [1] = true, [2] = true },
    DRUID = { [4] = true },
    PALADIN = { [1] = true },
    SHAMAN = { [3] = true },
}

function HealingStateManager:IsHealingSpec()
    local _, class = UnitClass("player")
    if not class or not HEALER_SPEC_BY_CLASS[class] then return false end
    local SpecCompat = NAG:GetModule("SpecCompat", true)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    return specIndex and HEALER_SPEC_BY_CLASS[class][specIndex] or false
end

function HealingStateManager:IsEnabled()
    if self.db.char.enabled ~= nil then return self.db.char.enabled end
    return self:IsHealingSpec()
end

--- True if healing tracking should run (developer mode + enabled)
local function isHealingActive(module)
    if not NAG.IsDevModeEnabled or not NAG:IsDevModeEnabled() then return false end
    return module:IsEnabled()
end

-- ============================ UNIT HELPERS ============================

--- Build list of group units
--- TBC uses GetNumRaidMembers / GetNumPartyMembers pattern
--- @return table units Array of unit IDs
--- @return number count Number of valid units
local function getGroupUnits()
    local units = healingState.group.units
    local idx = 0

    -- Try raid first (TBC-compatible)
    local raidSize = 0
    if IsInRaid then
        if IsInRaid() then
            raidSize = GetNumGroupMembers()
        end
    elseif GetNumRaidMembers then
        raidSize = GetNumRaidMembers()
    end

    if raidSize > 0 then
        for i = 1, raidSize do
            idx = idx + 1
            units[idx] = "raid" .. i
        end
    else
        -- Party
        local partySize = 0
        if GetNumPartyMembers then
            partySize = GetNumPartyMembers()
        end

        idx = idx + 1
        units[idx] = "player"

        for i = 1, partySize do
            idx = idx + 1
            units[idx] = "party" .. i
        end
    end

    -- Clear excess entries
    for i = idx + 1, #units do
        units[i] = nil
    end

    return units, idx
end

--- Get unit health percentage (TBC: no heal absorb tracking)
--- @param unit string Unit token
--- @return number healthPct 0..1 health fraction
local function getUnitHealthPct(unit)
    local maxH = UnitHealthMax(unit)
    if not maxH or maxH <= 0 then
        return 1
    end
    return (UnitHealth(unit) or 0) / maxH
end

-- ============================ MOUSEOVER UPDATE ============================

--- Update mouseover state
function HealingStateManager:UpdateMouseoverState()
    local m = healingState.mouseover

    if not UnitExists("mouseover") or not UnitIsFriend("player", "mouseover") then
        m.exists = false
        m.health.pct = 100
        m.effectiveHealth.pct = 100
        m.is_self = false
        m.isTank = false
        m.role = nil
        m.dispel = false
        m.healAbsorb = 0
        return
    end

    m.exists = true
    m.is_self = UnitIsUnit("mouseover", "player")

    local healthPct = getUnitHealthPct("mouseover")
    m.health.pct = healthPct
    m.effectiveHealth.pct = healthPct -- No heal absorbs in TBC
    m.healAbsorb = 0

    -- TBC has no UnitGroupRolesAssigned; tank detection not available
    m.role = nil
    m.isTank = false

    local dispelMod = NAG:GetModule("HealingDispelManager", true)
    if dispelMod and dispelMod.CheckDispellable and isHealingActive(self) then
        m.dispel = dispelMod:CheckDispellable("mouseover")
    else
        m.dispel = false
    end
end

-- ============================ GROUP HEALING UPDATE ============================

--- Scan group members and count those below health threshold
function HealingStateManager:UpdateGroupHealingState()
    local g = healingState.group
    local now = GetTime()

    -- Throttle group scans
    if (now - g.lastUpdate) < GROUP_UPDATE_THROTTLE then
        return
    end

    local threshold = (self.db.char.healthThreshold or 80) / 100
    local count = 0

    local units, unitCount = getGroupUnits()
    g.memberCount = unitCount

    for i = 1, unitCount do
        local unit = units[i]
        if UnitExists(unit) and not UnitIsDeadOrGhost(unit) then
            local healthPct = getUnitHealthPct(unit)
            if healthPct < threshold then
                count = count + 1
            end
        end
    end

    g.low_health_count = count
    g.heal_needed = (count > 0)
    g.lastUpdate = now
end

-- ============================ EVENT HANDLERS ============================

function HealingStateManager:UPDATE_MOUSEOVER_UNIT()
    if not isHealingActive(self) then return end
    ensureHealingState()
    self:UpdateMouseoverState()
end

function HealingStateManager:UNIT_HEALTH(event, unit)
    if not isHealingActive(self) then return end
    ensureHealingState()
    if unit == "mouseover" then
        self:UpdateMouseoverState()
    end
    self:UpdateGroupHealingState()
end

function HealingStateManager:OnUnitAura(event, unit)
    if not isHealingActive(self) then return end
    ensureHealingState()
    if unit == "mouseover" then
        self:UpdateMouseoverState()
    end
end

function HealingStateManager:GROUP_ROSTER_UPDATE()
    if not isHealingActive(self) then return end
    ensureHealingState()
    self:UpdateGroupHealingState()
end

function HealingStateManager:PLAYER_ENTERING_WORLD()
    ensureHealingState()
    if isHealingActive(self) then
        self:UpdateMouseoverState()
        self:UpdateGroupHealingState()
    end
end

-- ============================ LIFECYCLE ============================

function HealingStateManager:ModuleInitialize()
    ensureHealingState()
end

function HealingStateManager:ModuleEnable()
    ensureHealingState()
    if isHealingActive(self) then
        self:UpdateMouseoverState()
        self:UpdateGroupHealingState()
    end
end

-- ============================ SPLASH INTEGRATION ============================

--- Inject healing toggle into splash screen control group (only when developer mode is on)
--- @param options table Splash options table
--- @param context table Composition context
--- @return table Modified options table
function HealingStateManager:splash(options, context)
    if not NAG.IsDevModeEnabled or not NAG:IsDevModeEnabled() then return options end

    local OptionsFactory = ns.OptionsFactory
    if not OptionsFactory then return options end

    if options.args and options.args.controlGroup and options.args.controlGroup.args then
        options.args.controlGroup.args.enableHealing = OptionsFactory:CreateToggle(
            "Healing Mode",
            "Enable mouseover healing state (healer specs: on by default; DPS/tank: off). Requires Developer Mode.",
            function() return self:IsEnabled() end,
            function(_, value)
                self:SetSetting("char", "enabled", value)
                if value then
                    ensureHealingState()
                    self:UpdateMouseoverState()
                    self:UpdateGroupHealingState()
                end
            end,
            { order = 25 }
        )
    end
    return options
end

-- ============================ OPTIONS ============================

function HealingStateManager:GetOptions()
    local OptionsFactory = ns.OptionsFactory
    if not OptionsFactory then
        return { type = "group", name = "Healing State", args = {} }
    end
    return {
        type = "group",
        name = "Healing State",
        desc = "Mouseover and group healing state (TBC). Only active when Developer Mode is enabled.",
        hidden = function() return not (NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end,
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enable",
                "Track mouseover and group for healing (healer specs: on by default; DPS/tank: off)",
                function() return self:IsEnabled() end,
                function(_, v) self:SetSetting("char", "enabled", v) end,
                { order = 1 }
            ),
            healthThreshold = OptionsFactory:CreateRange(
                "Group heal threshold (%)",
                "Consider unit needing heal below this %",
                function() return self:GetSetting("char", "healthThreshold") or 80 end,
                function(_, v) self:SetSetting("char", "healthThreshold", v) end,
                { order = 2, min = 50, max = 100, step = 5 }
            )
        }
    }
end

return HealingStateManager
