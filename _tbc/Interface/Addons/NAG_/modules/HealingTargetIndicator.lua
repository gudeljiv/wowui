--- @module "NAG.HealingTargetIndicator"
--- Draws glow on unit frames for prioritized healing targets (LibCustomGlow).
--- Supports ElvUI, Healbot, Blizzard raid/party and PlayerFrame fallback.
---
--- License: CC BY-NC 4.0
--- Authors: NAG Team

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitExists = _G.UnitExists
local UnitName = _G.UnitName
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local GetNumGroupMembers = _G.GetNumGroupMembers
local GetTime = _G.GetTime

local LCG = ns.LibCustomGlow
local TimerManager = ns.TimerManager
local UnitClass = _G.UnitClass
local GLOW_KEY = "NAG_Healing"
local TEST_GLOW_KEY = "NAG_Test"

-- nil = use spec-based default (enabled on healing specs only)
local defaults = {
    char = {
        enabled = nil,
        healthThreshold = 80,
        showTestGlow = false
    }
}

local HealingTargetIndicator = NAG:CreateModule("HealingTargetIndicator", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "features",
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
    eventHandlers = {
        GROUP_ROSTER_UPDATE = true,
        PLAYER_ENTERING_WORLD = true
    }
})

-- ============================ HEALING ACTIVE GATE ============================

--- Healer spec indices per class (MoP/TBC). Monk Mistweaver uses a different system and is not gated here.
local HEALER_SPEC_BY_CLASS = {
    PRIEST = { [1] = true, [2] = true },
    DRUID = { [4] = true },
    PALADIN = { [1] = true },
    SHAMAN = { [3] = true },
}

function HealingTargetIndicator:IsHealingSpec()
    local _, class = UnitClass("player")
    if not class or not HEALER_SPEC_BY_CLASS[class] then return false end
    local SpecCompat = NAG:GetModule("SpecCompat", true)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    return specIndex and HEALER_SPEC_BY_CLASS[class][specIndex] or false
end

function HealingTargetIndicator:IsEnabled()
    if self.db.char.enabled ~= nil then return self.db.char.enabled end
    return self:IsHealingSpec()
end

--- True if glow should run (enabled; no longer requires Developer Mode so glow works for all Resto players)
local function isHealingActive(module)
    return module:IsEnabled()
end

-- ============================ FRAME RESOLUTION ============================

--- Resolve unit to a frame for glow.
--- Supported: ElvUI, Healbot, Blizzard raid/party, PlayerFrame; Grid2 (native); Grid2/VuhDo via LibGetFrame-1.0 when present.
--- @param unit string e.g. "player", "party1", "raid5", "mouseover"
--- @return table|nil Frame or nil
function HealingTargetIndicator:GetUnitFrame(unit)
    if not unit or unit == "" then return nil end
    local name = UnitName(unit)
    if not name then return nil end

    -- LibGetFrame-1.0: used by Grid2, VuhDo, Healium when the library is embedded
    local LGF = LibStub("LibGetFrame-1.0", true)
    if LGF and LGF.GetUnitFrame then
        local frame = LGF.GetUnitFrame(unit)
        if frame and frame.GetSize then
            return frame
        end
    end

    -- Grid2 native: frames live under layout; each unit frame has .unit set (Grid2 does not embed LibGetFrame by default)
    local loaded = _G.IsAddOnLoaded and _G.IsAddOnLoaded("Grid2")
    if loaded then
        local layout = _G.Grid2LayoutFrame or _G.Grid2Frame
        if layout then
            local function findUnitFrame(parent)
                if not parent or not parent.GetChildren then return nil end
                for _, child in ipairs({ parent:GetChildren() }) do
                    if child and child.unit == unit then
                        return child
                    end
                    local found = findUnitFrame(child)
                    if found then return found end
                end
                return nil
            end
            local frame = findUnitFrame(layout)
            if frame then return frame end
        end
    end

    if unit == "player" then
        local elv = _G.ElvUF_Player
        if elv and elv.Health then
            return elv
        end
        local hb = _G.HealBot_Unit_Button
        if hb and hb[1] then
            for i = 1, 40 do
                local f = hb[i]
                if f and f.unit and UnitExists(f.unit) and UnitName(f.unit) == name then
                    return f
                end
            end
        end
        return _G.PlayerFrame
    end

    if unit == "mouseover" then
        local elv = _G.ElvUF_Target
        if elv and elv.unit and UnitExists(elv.unit) and UnitName(elv.unit) == name then
            return elv
        end
        local hb = _G.HealBot_Unit_Button
        if hb then
            for i = 1, 40 do
                local f = hb[i]
                if f and f.unit and UnitExists(f.unit) and UnitName(f.unit) == name then
                    return f
                end
            end
        end
        return nil
    end

    local party = unit:match("^party(%d+)$")
    if party then
        local idx = tonumber(party)
        local elv = _G["ElvUF_PartyUnit" .. idx]
        if elv and elv.Health then return elv end
        local bliz = _G["PartyMemberFrame" .. idx]
        if bliz then return bliz end
    end

    local raid = unit:match("^raid(%d+)$")
    if raid then
        local idx = tonumber(raid)
        local elv = _G["ElvUF_RaidUnit" .. idx]
        if elv and (elv.Health or elv.GetSize) then return elv end
        local bliz = _G["CompactRaidFrameContainer"]
        if bliz and bliz.GetChildren then
            for _, group in ipairs({ bliz:GetChildren() }) do
                if group and group.GetChildren then
                    for _, member in ipairs({ group:GetChildren() }) do
                        if member and member.unit and UnitExists(member.unit) and UnitName(member.unit) == name then
                            return member
                        end
                    end
                end
            end
        end
    end

    return nil
end

--- Return the frame to apply glow to (use .Health if main frame has no size).
--- @param frame table Frame from GetUnitFrame
--- @return table Frame to glow
function HealingTargetIndicator:GetBestGlowFrame(frame)
    if not frame then return nil end
    local w, h = frame:GetSize()
    if w and h and w > 0 and h > 0 then
        return frame
    end
    if frame.Health and frame.Health.GetSize then
        local w2, h2 = frame.Health:GetSize()
        if w2 and h2 and w2 > 0 and h2 > 0 then
            return frame.Health
        end
    end
    return frame
end

-- ============================ GLOW ============================

-- Glow style: stor scale, många linjer; färg efter HP (röd = panik, gul = kritiskt, grön = lägre prioritet)
local GLOW_LINES = 12
local GLOW_FREQUENCY = 0.06
local GLOW_SCALE = 2.2

-- Health breakpoints for color (0-1): below CRITICAL = red, below LOW = yellow, green = från LOW upp till threshold (där första healen rekommenderas)
local CRITICAL_HP_PCT = 0.25
local LOW_HP_PCT = 0.50

local GLOW_COLOR_GREEN = { 0.2, 1.0, 0.25, 1.0 }
local GLOW_COLOR_YELLOW = { 1.0, 0.95, 0.2, 1.0 }
local GLOW_COLOR_RED = { 1.0, 0.2, 0.2, 1.0 }

--- Return glow color by health pct (0-1) and heal threshold (0-1). Grön = från LOW_HP_PCT upp till threshold (där första healen rekommenderas), gul = kritiskt, röd = panik.
--- @param healthPct number 0-1 health fraction, or nil for default green
--- @param thresholdPct number 0-1 same as healthThreshold/100 (där första healen rekommenderas)
--- @return table r,g,b,a
local function getGlowColorForHealthPct(healthPct, thresholdPct)
    if healthPct == nil then
        return GLOW_COLOR_GREEN
    end
    if healthPct < CRITICAL_HP_PCT then
        return GLOW_COLOR_RED
    end
    if healthPct < LOW_HP_PCT then
        return GLOW_COLOR_YELLOW
    end
    -- Grön: från LOW_HP_PCT (50%) upp till threshold (t.ex. 80%) = "behöver heal men inte panik"
    return GLOW_COLOR_GREEN
end

local function applyGlow(frame, glowKey, frameLevel, healthPct, thresholdPct)
    if not LCG or not frame then return end
    frameLevel = frameLevel or 6
    local color = getGlowColorForHealthPct(healthPct, thresholdPct)
    if LCG.AutoCastGlow_Start then
        LCG.AutoCastGlow_Start(frame, color, GLOW_LINES, GLOW_FREQUENCY, GLOW_SCALE, 0, 0, glowKey, frameLevel)
    end
end

local function removeGlow(frame, glowKey)
    if not LCG or not frame then return end
    if LCG.AutoCastGlow_Stop then
        LCG.AutoCastGlow_Stop(frame, glowKey)
    end
end

--- Update glow on prioritized targets; skip overwrite/remove for units with test glow.
function HealingTargetIndicator:UpdateIndicators()
    if not LCG then return end
    if not isHealingActive(self) then
        self:ClearAllGlows()
        return
    end
    local priorityMod = NAG:GetModule("HealingPriorityManager", true)
    if not priorityMod or not priorityMod.GetPrioritizedTargets then return end

    local threshold = self.db.char.healthThreshold or 80
    local targets = priorityMod:GetPrioritizedTargets(10, threshold)
    local shown = {}

    for _, unit in ipairs(targets) do
        if self.testGlowUnit ~= unit then
            shown[unit] = true
            local frame = self:GetUnitFrame(unit)
            local glowFrame = self:GetBestGlowFrame(frame)
            if glowFrame then
                local maxH = UnitHealthMax(unit)
                local healthPct = (maxH and maxH > 0) and ((UnitHealth(unit) or 0) / maxH) or nil
                local thresholdPct = (threshold or 80) / 100
                removeGlow(glowFrame, GLOW_KEY)
                applyGlow(glowFrame, GLOW_KEY, 6, healthPct, thresholdPct)
            end
        end
    end

    if self.lastGlowUnits then
        for unit, _ in pairs(self.lastGlowUnits) do
            if not shown[unit] and self.testGlowUnit ~= unit then
                local frame = self:GetUnitFrame(unit)
                local glowFrame = self:GetBestGlowFrame(frame)
                if glowFrame then
                    removeGlow(glowFrame, GLOW_KEY)
                end
            end
        end
    end
    self.lastGlowUnits = shown
end

--- Remove all healing glows (used when healing active becomes false).
function HealingTargetIndicator:ClearAllGlows()
    if not self.lastGlowUnits then return end
    for unit, _ in pairs(self.lastGlowUnits) do
        if self.testGlowUnit ~= unit then
            local frame = self:GetUnitFrame(unit)
            local glowFrame = self:GetBestGlowFrame(frame)
            if glowFrame and LCG and LCG.AutoCastGlow_Stop then
                LCG.AutoCastGlow_Stop(glowFrame, GLOW_KEY)
            end
        end
    end
    self.lastGlowUnits = nil
end

--- Apply test glow on player frame.
function HealingTargetIndicator:ApplyTestGlow()
    if not LCG then return end
    self:RemoveTestGlow()
    local frame = self:GetUnitFrame("player")
    local glowFrame = self:GetBestGlowFrame(frame)
    if glowFrame then
        applyGlow(glowFrame, TEST_GLOW_KEY, 8)
        self.testGlowUnit = "player"
    end
end

--- Remove test glow.
function HealingTargetIndicator:RemoveTestGlow()
    if not LCG then return end
    local frame = self:GetUnitFrame("player")
    local glowFrame = self:GetBestGlowFrame(frame)
    if glowFrame then
        removeGlow(glowFrame, TEST_GLOW_KEY)
    end
    self.testGlowUnit = nil
end

-- ============================ TIMER ============================

function HealingTargetIndicator:StartUpdateTimer()
    if not isHealingActive(self) then return end
    local TimerManager = ns.TimerManager
    if not TimerManager or not TimerManager.Create then return end
    local category = TimerManager.Categories and TimerManager.Categories.UI_NOTIFICATION or "ui_notification"
    TimerManager:Cancel(category, "HealingTargetIndicator")
    TimerManager:Create(category, "HealingTargetIndicator", function()
        self:UpdateIndicators()
    end, 0.5, true)
end

function HealingTargetIndicator:StopUpdateTimer()
    local TimerManager = ns.TimerManager
    if not TimerManager or not TimerManager.Cancel then return end
    local category = TimerManager.Categories and TimerManager.Categories.UI_NOTIFICATION or "ui_notification"
    TimerManager:Cancel(category, "HealingTargetIndicator")
end

-- ============================ EVENTS ============================

function HealingTargetIndicator:GROUP_ROSTER_UPDATE()
    if isHealingActive(self) then
        self:StartUpdateTimer()
    else
        self:StopUpdateTimer()
        self:ClearAllGlows()
    end
end

function HealingTargetIndicator:PLAYER_ENTERING_WORLD()
    if isHealingActive(self) then
        self:StartUpdateTimer()
    else
        self:StopUpdateTimer()
        self:ClearAllGlows()
    end
end

-- ============================ LIFECYCLE ============================

function HealingTargetIndicator:ModuleInitialize()
    self.lastGlowUnits = nil
    self.testGlowUnit = nil
end

function HealingTargetIndicator:ModuleEnable()
    if isHealingActive(self) then
        self:StartUpdateTimer()
    end
end

function HealingTargetIndicator:ModuleDisable()
    self:StopUpdateTimer()
    self:RemoveTestGlow()
    if self.lastGlowUnits then
        for unit, _ in pairs(self.lastGlowUnits) do
            local frame = self:GetUnitFrame(unit)
            local glowFrame = self:GetBestGlowFrame(frame)
            if glowFrame then
                removeGlow(glowFrame, GLOW_KEY)
            end
        end
        self.lastGlowUnits = nil
    end
end

-- ============================ OPTIONS ============================

function HealingTargetIndicator:GetOptions()
    local OptionsFactory = ns.OptionsFactory
    if not OptionsFactory then
        return { type = "group", name = "Healing Target Indicator", args = {} }
    end
    local getThreshold = function()
        local v = self:GetSetting("char", "healthThreshold")
        if v == nil then return 80 end
        return v
    end
    local setThreshold = function(_, v)
        self:SetSetting("char", "healthThreshold", v)
    end
    return {
        type = "group",
        name = "Healing Target Indicator",
        desc = "Glow on unit frames for healing targets. Only active when Developer Mode is enabled.",
        hidden = function() return not (NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end,
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enable",
                "Show glow on prioritized healing targets (healer specs: on by default)",
                function() return self:IsEnabled() end,
                function(_, v)
                    self:SetSetting("char", "enabled", v)
                    if isHealingActive(self) then self:StartUpdateTimer() else self:StopUpdateTimer(); self:ClearAllGlows() end
                end,
                { order = 1 }
            ),
            healthThreshold = OptionsFactory:CreateRange(
                "Health threshold (%)",
                "Show glow on units below this %",
                getThreshold,
                setThreshold,
                { order = 2, min = 50, max = 100, step = 5 }
            ),
            testGlow = OptionsFactory:CreateExecute(
                "Test glow",
                "Show glow on player frame",
                function()
                    self:ApplyTestGlow()
                    if ns.TimerManager and ns.TimerManager.Create then
                        ns.TimerManager:Cancel(ns.TimerManager.Categories.UI_NOTIFICATION or "ui_notification", "NAG_TestGlowClear")
                        ns.TimerManager:Create(ns.TimerManager.Categories.UI_NOTIFICATION or "ui_notification", "NAG_TestGlowClear", function()
                            self:RemoveTestGlow()
                        end, 3, false)
                    end
                end,
                { order = 3 }
            )
        }
    }
end

return HealingTargetIndicator
