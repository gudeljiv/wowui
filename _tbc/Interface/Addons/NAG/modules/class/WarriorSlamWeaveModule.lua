--- @module "NAG.WarriorSlamWeaveModule"
--- Runtime helpers for Classic TBC Arms Warrior Slam weaving rotations.
---
--- Tracks runtime-only state needed by APL logic and visualization (no DB writes):
--- - last melee swing impact time
--- - melee swing count since combat start
--- - recent Slam cast success timing vs last swing
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        debugLoggingEnabled = false,
        debugThrottleSeconds = 0.25,
        -- Sim-inspired timing knobs (seconds)
        slamWindowSeconds = 0.40,       -- Post-swing "slam now" window
        slamLatencySeconds = 0.10,      -- Input latency before Slam starts
        slamGcdDelaySeconds = 0.40,     -- Max extra wait for GCD before skipping Slam
        slamMsWwDelaySeconds = 2.00,    -- Max allowed MS+WW delay caused by Slam
        holdReactionSeconds = 0.10,     -- Buffer used for HOLD region calculations

        barScale = 1.0,
    }
}

--- @class WarriorSlamWeaveModule:CoreModule
local WarriorSlamWeaveModule = NAG:CreateModule("WarriorSlamWeaveModule", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "WARRIOR",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    debugCategories = { ns.DEBUG_CATEGORIES.CLASS },

    eventHandlers = {
        PLAYER_REGEN_DISABLED = "OnCombatStateChanged",
        PLAYER_REGEN_ENABLED = "OnCombatStateChanged",
    },
    cleuHandlers = {
        SWING_DAMAGE = "HandleCLEUSwing",
        SWING_MISSED = "HandleCLEUSwing",
        SPELL_CAST_SUCCESS = "HandleCLEUSpellCastSuccess",
    },
    defaultState = {
        inCombat = false,
        swingCount = 0,
        lastResetTime = 0,

        lastSwingTime = 0,

        -- Success-only Slam tracking:
        lastSlamSuccessTime = 0,
        lastSlamDeltaFromSwing = 0, -- seconds (slamSuccessTime - lastSwingTime)
        lastSlamWindowX = 0,
        lastSlamQualityTime = 0,
        lastSlamQualityKey = "",
        lastSlamQualityText = "",
        lastSlamQualityColor = nil,
        lastSlamQualityDelta = 0,
    }
})

ns.WarriorSlamWeaveModule = WarriorSlamWeaveModule
local module = WarriorSlamWeaveModule

--- Returns the universal scale for Warrior bar UIs.
--- @return number Scale factor (default 1)
function WarriorSlamWeaveModule:GetWarriorBarScale()
    return self.db.class.barScale or 1
end

--- Options group for Warrior class (bar scale).
function WarriorSlamWeaveModule:GetOptions()
    local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
    return {
        type = "group",
        name = L["Warrior Slam Weave"] or "Warrior Slam Weave",
        order = 28,
        args = {
            barScale = {
                type = "range",
                name = L["Warrior bars scale"] or "Warrior bars scale",
                desc = L["Scale the Warrior Slam weave bar."] or "Scale the Warrior Slam weave bar.",
                min = 0.5,
                max = 2.0,
                step = 0.05,
                get = function() return self.db.class.barScale or 1 end,
                set = function(_, v)
                    self.db.class.barScale = v
                    NAG:SendMessage("NAG_WARRIOR_BAR_SCALE_UPDATED")
                end,
                order = 0,
            },
        },
    }
end

-- ============================ INTERNALS ============================

local function isPlayerSourceGUID(sourceGUID)
    return sourceGUID and NAG.state and NAG.state.player and sourceGUID == NAG.state.player.guid
end

-- All Slam ranks relevant to Classic/TBC (highest rank may vary by level).
local SLAM_IDS = {
    25241, -- Slam (Rank 6, TBC)
    11605, -- Slam (Rank 5)
    11604, -- Slam (Rank 4)
    8820,  -- Slam (Rank 3)
    1464,  -- Slam (Rank 1)
}

local function isSlamSpellId(spellId)
    if not spellId then return false end
    for i = 1, #SLAM_IDS do
        if spellId == SLAM_IDS[i] then
            return true
        end
    end
    return false
end

local SLAM_QUALITY_COLORS = {
    red = { 0.85, 0.20, 0.20 },
    orange = { 0.95, 0.55, 0.15 },
    green = { 0.30, 0.85, 0.35 },
    blue = { 0.20, 0.60, 0.95 },
    purple = { 0.70, 0.35, 0.95 },
}

local WARRIOR_BAR_GATE_TTL_SECONDS = 5

local function getTBCWarriorBarsGate()
    if ns.tbcWarriorBarsGateEnabled == nil then
        ns.tbcWarriorBarsGateEnabled = false
    end
    return ns.tbcWarriorBarsGateEnabled
end

local function getTBCWarriorBarsGateLastEnable()
    if ns.tbcWarriorBarsGateLastEnable == nil then
        ns.tbcWarriorBarsGateLastEnable = 0
    end
    return ns.tbcWarriorBarsGateLastEnable
end

local function updateTBCWarriorBarsGateLastEnable(timeSeconds)
    ns.tbcWarriorBarsGateLastEnable = timeSeconds or 0
end

local function isTBCWarriorBarsGateExpired(now)
    local lastEnable = getTBCWarriorBarsGateLastEnable()
    if lastEnable <= 0 then
        return true
    end
    return (now - lastEnable) > WARRIOR_BAR_GATE_TTL_SECONDS
end

local function clampNumber(value, minValue, maxValue)
    if value < minValue then
        return minValue
    end
    if value > maxValue then
        return maxValue
    end
    return value
end

local function classifySlamQuality(deltaSeconds, windowX)
    if not deltaSeconds or not windowX or windowX <= 0 then
        return "red", "Fail", SLAM_QUALITY_COLORS.red
    end

    local t = clampNumber(deltaSeconds / windowX, 0, 1)
    local b50 = 50 / 300
    local b100 = 100 / 300
    local b125 = 125 / 300
    local b175 = 175 / 300
    local b200 = 200 / 300
    local b250 = 250 / 300

    if t <= b50 then
        return "red", "Fail", SLAM_QUALITY_COLORS.red
    elseif t <= b100 then
        return "orange", "EPIC", SLAM_QUALITY_COLORS.orange
    elseif t <= b125 then
        return "green", "Ok", SLAM_QUALITY_COLORS.green
    elseif t <= b175 then
        return "orange", "EPIC", SLAM_QUALITY_COLORS.orange
    elseif t <= b200 then
        return "purple", "Great", SLAM_QUALITY_COLORS.purple
    elseif t <= b250 then
        return "blue", "Good", SLAM_QUALITY_COLORS.blue
    else
        return "green", "Ok", SLAM_QUALITY_COLORS.green
    end
end

-- ============================ LIFECYCLE ============================

function module:ModuleInitialize()
    -- No heavy work here; events are wired via declarative tables.
end

function module:OnCombatStateChanged(event)
    self:InitializeState()
    local now = GetTime()
    if event == "PLAYER_REGEN_DISABLED" then
        self.state.inCombat = true
        self.state.swingCount = 0
        self.state.lastResetTime = now
        self.state.lastSwingTime = 0
        self.state.lastSlamSuccessTime = 0
        self.state.lastSlamDeltaFromSwing = 0
        self.state.lastSlamWindowX = 0
        self.state.lastSlamQualityTime = 0
        self.state.lastSlamQualityKey = ""
        self.state.lastSlamQualityText = ""
        self.state.lastSlamQualityColor = nil
        self.state.lastSlamQualityDelta = 0
    else
        self.state.inCombat = false
        self.state.swingCount = 0
        self.state.lastResetTime = now
        self.state.lastSwingTime = 0
        self.state.lastSlamSuccessTime = 0
        self.state.lastSlamDeltaFromSwing = 0
        self.state.lastSlamWindowX = 0
        self.state.lastSlamQualityTime = 0
        self.state.lastSlamQualityKey = ""
        self.state.lastSlamQualityText = ""
        self.state.lastSlamQualityColor = nil
        self.state.lastSlamQualityDelta = 0
    end
end

-- ============================ CLEU HANDLERS ============================

--- Handle player swing events.
function module:HandleCLEUSwing(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20,
    arg21, arg22, arg23, arg24)
    self:InitializeState()
    if not self.state.inCombat then
        return
    end
    if not isPlayerSourceGUID(sourceGUID) then
        return
    end

    local now = GetTime()
    self.state.swingCount = (self.state.swingCount or 0) + 1
    self.state.lastSwingTime = now

    if self.db.class.debugLoggingEnabled then
        self:ThrottledDebug(
            "SlamWeave: %s swings=%d lastSwing=%.2f",
            "warrior_slamweave_swing",
            self.db.class.debugThrottleSeconds or 0.25,
            tostring(subEvent),
            tonumber(self.state.swingCount) or 0,
            now
        )
    end
end

--- Track Slam cast success timing.
function module:HandleCLEUSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18,
    arg19, arg20, arg21, arg22, arg23, arg24)
    self:InitializeState()
    local spellId = arg12
    if not isPlayerSourceGUID(sourceGUID) then
        return
    end
    if not isSlamSpellId(spellId) then
        return
    end

    local now = GetTime()
    self.state.lastSlamSuccessTime = now
    local lastSwing = self.state.lastSwingTime or 0
    self.state.lastSlamDeltaFromSwing = (lastSwing > 0) and (now - lastSwing) or 0

    local swingSpeed = NAG:AutoSwingTime() or 0
    local gcdValue = NAG:GCDTimeValue() or 0
    if gcdValue < 0 then gcdValue = 0 end
    local windowX
    if swingSpeed > 0 then
        if (gcdValue * 2) <= swingSpeed then
            windowX = swingSpeed - (gcdValue * 2) - 0.150
        else
            windowX = swingSpeed - gcdValue - 0.100
        end
        if windowX < 0 then windowX = 0 end
    else
        windowX = 0
    end

    self.state.lastSlamWindowX = windowX
    self.state.lastSlamQualityDelta = self.state.lastSlamDeltaFromSwing
    local qualityKey, qualityText, qualityColor = classifySlamQuality(self.state.lastSlamDeltaFromSwing, windowX)
    self.state.lastSlamQualityKey = qualityKey
    self.state.lastSlamQualityText = qualityText
    self.state.lastSlamQualityColor = qualityColor
    self.state.lastSlamQualityTime = now

    if self.db.class.debugLoggingEnabled then
        self:ThrottledDebug(
            "SlamWeave: SLAM_SUCCESS id=%d deltaFromSwing=%.3f",
            "warrior_slamweave_slam",
            self.db.class.debugThrottleSeconds or 0.25,
            tonumber(spellId) or 0,
            tonumber(self.state.lastSlamDeltaFromSwing) or 0
        )
    end
end

--- Returns the last Slam timing quality snapshot for visualization.
--- @return number timeSeconds
--- @return string qualityKey
--- @return string qualityText
--- @return table|nil color
--- @return number deltaSeconds
--- @return number windowX
function NAG:WarriorSlamWeaveGetLastSlamQuality()
    local m = ns.WarriorSlamWeaveModule
    if not m then
        return 0, "", "", nil, 0, 0
    end
    m:InitializeState()
    if not m.state then
        return 0, "", "", nil, 0, 0
    end
    return m.state.lastSlamQualityTime or 0,
        m.state.lastSlamQualityKey or "",
        m.state.lastSlamQualityText or "",
        m.state.lastSlamQualityColor,
        m.state.lastSlamQualityDelta or 0,
        m.state.lastSlamWindowX or 0
end

--- Returns the last recorded swing impact time.
--- @return number
function NAG:WarriorSlamWeaveGetLastSwingTime()
    local m = ns.WarriorSlamWeaveModule
    if not m then
        return 0
    end
    m:InitializeState()
    if not m.state then
        return 0
    end
    return m.state.lastSwingTime or 0
end

--- Returns the last recorded Slam success time.
--- @return number
function NAG:WarriorSlamWeaveGetLastSlamSuccessTime()
    local m = ns.WarriorSlamWeaveModule
    if not m then
        return 0
    end
    m:InitializeState()
    if not m.state then
        return 0
    end
    return m.state.lastSlamSuccessTime or 0
end

--- Returns true if the spellId matches a Slam rank.
--- @param spellId number|nil
--- @return boolean
function NAG:WarriorSlamWeaveIsSlamSpellId(spellId)
    return isSlamSpellId(spellId)
end

--- Returns the current Slam window X (seconds) based on swing speed and GCD.
--- @return number
function NAG:WarriorSlamWeaveGetCurrentWindowX()
    local swingSpeed = self:AutoSwingTime() or 0
    local gcdValue = self:GCDTimeValue() or 0
    if gcdValue < 0 then gcdValue = 0 end
    local windowX = 0
    if swingSpeed > 0 then
        if (gcdValue * 2) <= swingSpeed then
            windowX = swingSpeed - (gcdValue * 2) - 0.150
        else
            windowX = swingSpeed - gcdValue - 0.100
        end
        if windowX < 0 then windowX = 0 end
    end

    local m = ns.WarriorSlamWeaveModule
    if m and m.state then
        m.state.lastSlamWindowX = windowX
    end

    return windowX
end

--- Returns true when the TBC Warrior slam bars are gated on by a rotation call.
--- @return boolean
function NAG:IsTBCWarriorBarsEnabled()
    if not getTBCWarriorBarsGate() then
        return false
    end
    local now = GetTime()
    if isTBCWarriorBarsGateExpired(now) then
        ns.tbcWarriorBarsGateEnabled = false
        return false
    end
    return true
end

--- Enable the TBC Warrior slam bars gate.
--- @return boolean Always false so it never short-circuits rotation strings
function NAG:EnableTBCWarriorBars()
    local now = GetTime()
    local wasEnabled = getTBCWarriorBarsGate()
    ns.tbcWarriorBarsGateEnabled = true
    updateTBCWarriorBarsGateLastEnable(now)

    local bar = ns.WarriorSlamWeaveBar
    if bar and bar.UpdateVisibility and not wasEnabled then
        bar:UpdateVisibility()
    end

    local TimerManager = ns.TimerManager
    if TimerManager and TimerManager.Create then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "tbcWarriorBarsGateExpire")
        TimerManager:Create(
            TimerManager.Categories.UI_NOTIFICATION,
            "tbcWarriorBarsGateExpire",
            function()
                local expiredNow = GetTime()
                if isTBCWarriorBarsGateExpired(expiredNow) then
                    ns.tbcWarriorBarsGateEnabled = false
                    if bar and bar.UpdateVisibility then
                        bar:UpdateVisibility()
                    end
                end
            end,
            WARRIOR_BAR_GATE_TTL_SECONDS,
            false
        )
    end
    return false
end

