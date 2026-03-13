--- @module "NAG.HunterSteadyWeaveBar"
--- Visual ranged Auto Shot timing bar for TBC Hunter Steady Shot / Aimed Shot (pre-62) weaving.
---
--- Shows only when the rotation recommends Steady Shot, Steady HOLD, or Aimed Shot (prepatch).
--- Same layout as Warrior Slam Weave Bar: swing timeline, spark, target marker (wind-up zone).
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

local GetTime = _G.GetTime
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateFrame = _G.CreateFrame
local GetSpellTexture = _G.GetSpellTexture
local UnitCastingInfo = _G.UnitCastingInfo
local UnitRangedDamage = _G.UnitRangedDamage

local ceil = math.ceil
local floor = math.floor
local max = math.max
local min = math.min
local pi = math.pi

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local swingTimerLib = ns.LibClassicSwingTimerAPI
local WoWAPI = ns.WoWAPI
local OptionsFactory
local TimerManager = ns.TimerManager
local ChatCommandUtils = ns.ChatCommandUtils
local AceConfig = ns.AceConfig
local AceConfigDialog = ns.AceConfigDialog

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        showOnlyInCombat = true,
        draggable = false,
        autoAnchor = true,
        lockToNagAnchor = true,
        point = "CENTER",
        x = 136.3,
        y = 99.74,
        width = 180,
        height = 77,
        barHeight = 1,
        barOffsetY = -1,
        alpha = 1.0,
        backgroundOffsetX = 0,
        backgroundOffsetY = 0,
        holdBarOffsetX = 0,
        holdBarOffsetY = 6,
        showBackground = false,
        backgroundScale = 1.0,
        showBgArt = true,
        bgArtScale = 1.0,
        useDebugSnapshotWhenAvailable = true,
        userInputDelayMs = 25,
        showGcdBar = true,
        gcdBarHeight = 3,
        gcdBarOffsetY = 6,
        gcdBarColor = { r = 0.40, g = 0.40, b = 0.40, a = 0.95 },
        visibleWindowSeconds = 4.1,
        laneConfiguration = "only_fillers_bottom", -- all_top, all_bottom, only_fillers_bottom, only_fillers_top
        fillerLaneMode = "bottom", -- legacy: bottom, top
        showGreenCircle = true,
        greenCircleSize = 15,
        greenCircleScale = 2.1,
        greenCircleOffsetX = -16,
        greenCircleOffsetY = 5,
        greenCircleAlpha = 0.9,
        greenCircleColor = { r = 0.2, g = 0.9, b = 0.2, a = 0.9 },
        snapshotSparkScale = 1.15,
        holdBarScale = 1.45,
        showAutoshotTicks = true,
        showAutoshotTicksInEmptyState = false,
        autoshotTickWidth = 2,
        autoshotTickHeight = 5,
        autoshotTickColor = { r = 0.75, g = 0.75, b = 0.75, a = 0.7 },
        autoshotTickOffsetX = 0,
        autoshotTickOffsetY = 6,
        showAutoshotTickLabels = false,
        sparkLabelMode = "hold", -- none, spell, time, hold
        predictionTopLaneOffsetY = 26,
        predictionBottomLaneOffsetY = -15,
        predictionTopLaneOffsetX = 0,
        predictionBottomLaneOffsetX = 0,
        bgArtWidth = 233,
        bgArtHeight = 28,
        bgArtAlpha = 1,
        bgArtOffsetX = -7,
        bgArtOffsetY = 5,
        backgroundColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.35 },
    }
}

--- @class HunterSteadyWeaveBar:CoreModule
local HunterSteadyWeaveBar = NAG:CreateModule("HunterSteadyWeaveBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    messageHandlers = { NAG_FRAME_UPDATED = true },
    hidden = function()
        return UnitClassBase("player") ~= "HUNTER"
    end,
})

ns.HunterSteadyWeaveBar = HunterSteadyWeaveBar
local module = HunterSteadyWeaveBar
local STEADY_OPTIONS_NAME = "NAGHunterSteadyWeave"

-- ============================ LOCALS ============================
local frame
local background
local swingBar
local pastSwingBar
local gcdBar
local swingSpark
local gcdSpark
local gcdSparkLeft
local timelineBar
local bgArt
local greenCircle
local nowMarker
local nowMarkerInner
local debugSwingBar
local debugSwingText
local windupMarkerLeft
local windupMarkerRight
local windupMarkerLeftBg
local windupMarkerRightBg
local windupHighlight
local earlyGapHighlight
local earlyGapHighlightWrap
local earlyGapMarkerLeft
local earlyGapMarkerRight
local gcdLandingMarker
local gcdLandingText
local gcdLandingFillerIcon
local gcdMovingFillerIcon
local steadyShotText
local segmentDividerLines
local lockedSegmentCount
local lastKnownRangedSwingSpeed

local UPDATE_INTERVAL = 0.016
local lastUpdate = 0

--- Delay before anchoring to main display so layout is ready after /reload.
local ANCHOR_DEFER_DELAY = 0.5
local ANCHOR_DEFER_TIMER = "HunterSteadyBarAnchorDefer"

local DEFAULT_ICON_SIZE = 16
local MAX_SWING_SPARKS = 3
local SEGMENT_SPARK_OFFSET_Y = 20
local SEGMENT_SPARK_BG_PATH = "Interface\\AddOns\\NAG\\media\\extras\\iconBar3Inverted.png"
local MAX_DYNAMIC_SEGMENTS = 8
local MAX_SNAPSHOT_SEGMENTS = 16
--- Keep spell sparks visible at zero marker this long past due (seconds).
local SPELL_VISIBLE_PAST_ZERO_SECONDS = 0.15
local DEFAULT_EFFECTIVE_GCD = 1.5
local MIN_SEGMENT_COUNT = 2
local FILLER_MIN_SWING_SECONDS = 1.7
local SEGMENT_DEBUG_PRINT_INTERVAL = 0.02
local LEFT_OF_GCD_SPARK_ALPHA = 0.30
local DEFAULT_SNAPSHOT_HORIZON_SECONDS = 15
local SNAPSHOT_REFRESH_INTERVAL_SECONDS = 2.5
local SNAPSHOT_TIMER_NAME = "HunterSteadyWeaveBarSnapshot"
local TIMER_COOLDOWN_SECONDS = 2.5
local AUTOSHOT_COOLDOWN_SECONDS = 1.5
local DELAYED_COMPUTE_MS = 200
local SPELL_START_SS_DELAY_MS = 300
local AURA_SPEED_CHECK_DELAY_MS = 50
local RANGED_SPEED_EPSILON = 0.001
local DELAYED_COMPUTE_TIMER = "HunterSteadyBarDelayedCompute"
local MS_ZERO_BACKUP_TIMER = "HunterSteadyBarMsZeroBackup"
local FILLER_BACKUP_TIMER_PREFIX = "HunterSteadyBarFillerBackup_"
local MAX_FILLER_BACKUP_TIMERS = 5
local MS_ZERO_BACKUP_DELAY_SECONDS = 0.1   -- Always fire 100ms after we missed a filler gap
local MS_ZERO_BACKUP_ACTIVE_WINDOW_SECONDS = 0.5  -- Skip if any compute in last 500ms (e.g. we cast MS/AR)
local AURA_SPEED_CHECK_TIMER = "HunterSteadyBarAuraSpeedCheck"

-- Forward declarations (Lua 5.1: must be declared before use in closures).
local CancelFillerBackups
local ScheduleFillerBackups

local STEADY_SHOT_ID = 34120
local STEADY_SHOT_ID_SET = { [34120] = true }
local AIMED_SHOT_ID = 27065
local MULTI_SHOT_ID = 27021
local ARCANE_SHOT_ID = 27019
-- Aimed Shot has multiple ranks pre-70; `NAG.nextSpell` may resolve to a lower-rank ID.
local AIMED_SHOT_ID_SET = {
    [19434] = true, -- Aimed Shot (Rank 1)
    [20900] = true, -- Aimed Shot (Rank 2)
    [20901] = true, -- Aimed Shot (Rank 3)
    [20902] = true, -- Aimed Shot (Rank 4)
    [20903] = true, -- Aimed Shot (Rank 5)
    [20904] = true, -- Aimed Shot (Rank 6)
    [27065] = true, -- Aimed Shot (Rank 7)
}
local MULTI_SHOT_ID_SET = {
    [2643] = true,  -- Multi-Shot (Rank 1)
    [14288] = true, -- Multi-Shot (Rank 2)
    [14289] = true, -- Multi-Shot (Rank 3)
    [14290] = true, -- Multi-Shot (Rank 4)
    [25294] = true, -- Multi-Shot (Rank 5)
    [27021] = true, -- Multi-Shot (Rank 6)
}
local ARCANE_SHOT_ID_SET = {
    [3044] = true,  -- Arcane Shot (Rank 1)
    [14281] = true, -- Arcane Shot (Rank 2)
    [14282] = true, -- Arcane Shot (Rank 3)
    [14283] = true, -- Arcane Shot (Rank 4)
    [14284] = true, -- Arcane Shot (Rank 5)
    [14285] = true, -- Arcane Shot (Rank 6)
    [14286] = true, -- Arcane Shot (Rank 7)
    [14287] = true, -- Arcane Shot (Rank 8)
    [27019] = true, -- Arcane Shot (Rank 9)
}

local BG_ART_TEXTURE = "Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarCD2.png"
local ZERO_MARKER_TEXTURE = "Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrowCenter.png"
local MASK_4_AOE_PATH = "Interface\\AddOns\\NAG\\media\\mask4AOE.png"

-- ============================ HELPERS ============================
local AUTO_POSITION_RATIO = 0.35 -- Auto Shot moment at 30% from left

local function Clamp01(x)
    if x < 0 then return 0 end
    if x > 1 then return 1 end
    return x
end

--- Linear interpolation helper.
--- @param a number
--- @param b number
--- @param t number
--- @return number
local function Lerp(a, b, t)
    return a + ((b - a) * t)
end

--- Smooth background tint based on per-spark time to gap:
--- far = black, mid = dark yellow, near gap = dark green.
--- Transition profile:
--- - 0.2s black->yellow blend
--- - ~1.0s yellow hold window
--- - 0.2s yellow->green blend at the border hit.
--- @param actionRemaining number|nil
--- @return number, number, number, number
local function GetSparkBackgroundTint(actionRemaining)
    local remaining = actionRemaining or 0
    if remaining < 0 then
        remaining = 0
    end

    local blackR, blackG, blackB = 0.0, 0.0, 0.0
    local yellowR, yellowG, yellowB = 0.55, 0.45, 0.05
    local greenR, greenG, greenB = 0.08, 0.26, 0.10
    local blendWindowSeconds = 0.2
    local yellowHoldSeconds = 1.0

    local blackToYellowStart = yellowHoldSeconds + blendWindowSeconds -- 1.2
    local blackToYellowEnd = yellowHoldSeconds -- 1.0
    local yellowToGreenStart = blendWindowSeconds -- 0.2

    if remaining >= blackToYellowStart then
        return blackR, blackG, blackB, 1.0
    end
    if remaining >= blackToYellowEnd then
        local t = Clamp01((blackToYellowStart - remaining) / blendWindowSeconds)
        return Lerp(blackR, yellowR, t), Lerp(blackG, yellowG, t), Lerp(blackB, yellowB, t), 1.0
    end
    if remaining > yellowToGreenStart then
        return yellowR, yellowG, yellowB, 1.0
    end

    local t = Clamp01((yellowToGreenStart - remaining) / blendWindowSeconds)
    return Lerp(yellowR, greenR, t), Lerp(yellowG, greenG, t), Lerp(yellowB, greenB, t), 1.0
end

--- Ranged swing: time until next Auto Shot, swing speed.
--- @return number timeToNext
--- @return number speed
local function GetRangedSwing()
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        local speed, expiration = swingTimerLib:UnitSwingTimerInfo("player", "ranged")
        if speed and expiration and speed > 0 then
            local now = GetTime()
            local timeToNext = expiration - now
            if timeToNext < 0 then
                timeToNext = 0
            end
            return timeToNext, speed
        end
    end
    return 0, 0
end

--- @param actionName string
--- @return number|nil
local function GetActionSpellIdForSnapshot(actionName)
    if actionName == "SS" then
        return STEADY_SHOT_ID
    end
    if actionName == "MS" then
        return MULTI_SHOT_ID
    end
    if actionName == "AR" then
        return ARCANE_SHOT_ID
    end
    return nil
end

--- @param db table
--- @return string
local function ResolveLaneConfiguration(db)
    local laneConfiguration = tostring(db and db.laneConfiguration or "")
    if laneConfiguration == "" then
        local legacyMode = tostring(db and db.fillerLaneMode or "bottom")
        laneConfiguration = (legacyMode == "top") and "only_fillers_top" or "only_fillers_bottom"
    end
    if laneConfiguration ~= "all_top"
        and laneConfiguration ~= "all_bottom"
        and laneConfiguration ~= "only_fillers_top"
        and laneConfiguration ~= "only_fillers_bottom" then
        laneConfiguration = "only_fillers_bottom"
    end
    return laneConfiguration
end

--- @param actionName string
--- @param laneConfiguration string
--- @return boolean useTopLane
--- @return boolean rotateBackground
local function ResolveSnapshotLanePlacement(actionName, laneConfiguration)
    local isFiller = actionName == "MS" or actionName == "AR"
    if laneConfiguration == "all_top" then
        return true, false
    end
    if laneConfiguration == "all_bottom" then
        return false, true
    end
    if laneConfiguration == "only_fillers_top" then
        if isFiller then
            return true, false
        end
        return false, true
    end

    -- Default: only fillers bottom.
    if isFiller then
        return false, true
    end
    return true, false
end

--- @param seconds number
--- @param horizon number
--- @param width number
--- @return number
local function SnapshotSecondsToX(seconds, horizon, width)
    local s = tonumber(seconds or 0) or 0
    local h = tonumber(horizon or 0) or 0
    local w = tonumber(width or 0) or 0
    if h <= 0 or w <= 0 then
        return 0
    end
    if s < 0 then
        s = 0
    elseif s > h then
        s = h
    end
    return (s / h) * w
end

--- Hold color with 50ms smooth transitions: red -> yellow -> green as we approach zero.
--- @param holdSeconds number Time until press (remaining). As it decreases, color goes red->yellow->green.
--- @param instantCast boolean If true, always return green.
--- @return number, number, number, number
local function GetHoldColor(holdSeconds, instantCast)
    local green = { 0.12, 0.45, 0.18, 0.95 }
    local yellow = { 0.95, 0.85, 0.20, 0.95 }
    local red = { 0.95, 0.20, 0.20, 0.95 }
    if instantCast then
        return green[1], green[2], green[3], green[4]
    end

    local value = tonumber(holdSeconds or 0) or 0
    if value <= 0 then
        return green[1], green[2], green[3], green[4]
    end

    local RED_YELLOW_TRANSITION = 0.05
    local YELLOW_GREEN_TRANSITION_END = 0.15
    if value <= YELLOW_GREEN_TRANSITION_END then
        local t = Clamp01(1 - (value / YELLOW_GREEN_TRANSITION_END))
        return Lerp(yellow[1], green[1], t), Lerp(yellow[2], green[2], t), Lerp(yellow[3], green[3], t), 0.95
    end
    if value <= 0.50 then
        return yellow[1], yellow[2], yellow[3], yellow[4]
    end
    if value <= 0.50 + RED_YELLOW_TRANSITION then
        local t = Clamp01((value - 0.50) / RED_YELLOW_TRANSITION)
        return Lerp(yellow[1], red[1], t), Lerp(yellow[2], red[2], t), Lerp(yellow[3], red[3], t), 0.95
    end
    return red[1], red[2], red[3], red[4]
end

--- @param degrees number
--- @return number radians
local function DegreesToRadians(degrees)
    local deg = tonumber(degrees) or 0
    return deg * (pi / 180)
end

--- @param actionName string
--- @return string
local function GetActionAbbreviation(actionName)
    if actionName == "SS" then return "SS" end
    if actionName == "AR" then return "AR" end
    if actionName == "MS" then return "MS" end
    if actionName == "MW" then return "MW" end
    return tostring(actionName or "")
end

--- True if Arcane Shot is off cooldown and known. Used to show MS+AR dual spark when both are available.
--- Must be defined before RenderDebugSnapshotTimeline (Lua 5.1 forward reference).
--- @return boolean
local function IsArcaneShotOffCooldown()
    if not (NAG.SpellIsKnown and NAG:SpellIsKnown(ARCANE_SHOT_ID)) then
        return false
    end
    if NAG.SpellTimeToReady then
        local ttr = tonumber(NAG:SpellTimeToReady(ARCANE_SHOT_ID) or -1)
        if ttr and ttr <= 0 then
            return true
        end
        if ttr and ttr > 0 then
            return false
        end
    end
    if WoWAPI and WoWAPI.GetSpellCooldown then
        local a, b, c = WoWAPI.GetSpellCooldown(ARCANE_SHOT_ID)
        local startTime, duration
        if type(a) == "table" then
            startTime = tonumber(a.startTime) or 0
            duration = tonumber(a.duration) or 0
        else
            startTime = tonumber(a) or 0
            duration = tonumber(b) or 0
        end
        local now = GetTime()
        return (startTime + duration) <= now
    end
    return false
end

--- @param self HunterSteadyWeaveBar
--- @return boolean
local function ShouldUseDebugSnapshot(self)
    if not (self and self.db and self.db.class and self.db.class.useDebugSnapshotWhenAvailable) then
        return false
    end
    local snapshot = self.state and self.state.debugSnapshot
    return snapshot and snapshot.segments and #snapshot.segments > 0
end

--- @param self HunterSteadyWeaveBar
local function EnsureSnapshotVisualPools(self)
    if not frame then
        return
    end
    frame.snapshotActionSparks = frame.snapshotActionSparks or {}
    frame.snapshotMsSsgapGhostSparks = frame.snapshotMsSsgapGhostSparks or {}
    frame.snapshotMsArcaneSemiCircleFrames = frame.snapshotMsArcaneSemiCircleFrames or {}
    frame.snapshotMsArcaneCompanionSparks = frame.snapshotMsArcaneCompanionSparks or {}
    frame.snapshotHoldBars = frame.snapshotHoldBars or {}
    frame.snapshotAutoshotTicks = frame.snapshotAutoshotTicks or {}

    for i = 1, MAX_SNAPSHOT_SEGMENTS do
        local sparkFrame = frame.snapshotActionSparks[i]
        if not sparkFrame then
            sparkFrame = CreateFrame("Frame", nil, frame)
            sparkFrame:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
            sparkFrame.bg = sparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
            sparkFrame.bg:SetTexture(SEGMENT_SPARK_BG_PATH)
            sparkFrame.bg:SetPoint("CENTER", sparkFrame, "CENTER", 0, 0)
            sparkFrame.bg:SetSize(37, 37)
            sparkFrame.bg:SetAlpha(0.95)
            sparkFrame.icon = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 7)
            sparkFrame.icon:SetAllPoints()
            sparkFrame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            sparkFrame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            local mask = sparkFrame:CreateMaskTexture()
            mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
                "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints()
            sparkFrame.icon:AddMaskTexture(mask)
            sparkFrame.label = sparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            sparkFrame.label:SetPoint("BOTTOM", sparkFrame, "TOP", 0, 2)
            sparkFrame.label:SetJustifyH("CENTER")
            sparkFrame.label:SetTextColor(1, 1, 1, 0.9)
            sparkFrame.label:SetText("")
            sparkFrame:Hide()
            frame.snapshotActionSparks[i] = sparkFrame
        end
        if sparkFrame and not sparkFrame.msCircleBorder then
            sparkFrame.msCircleBorder = sparkFrame:CreateTexture(nil, "BORDER", nil, 0)
            sparkFrame.msCircleBorder:SetColorTexture(0, 0, 0, 1)
            sparkFrame.msCircleBorder:SetPoint("CENTER", sparkFrame, "CENTER", 0, 0)
            sparkFrame.msCircleBorder:SetSize(floor(DEFAULT_ICON_SIZE * 1.30 + 0.5), floor(DEFAULT_ICON_SIZE * 1.30 + 0.5))
            local circleMask = sparkFrame:CreateMaskTexture()
            circleMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
                "CLAMPTOBLACKADDITIVE")
            circleMask:SetAllPoints(sparkFrame.msCircleBorder)
            sparkFrame.msCircleBorder:AddMaskTexture(circleMask)
            sparkFrame.msCircleBorder:Hide()
        end

        local ghostSpark = frame.snapshotMsSsgapGhostSparks[i]
        if not ghostSpark then
            ghostSpark = CreateFrame("Frame", nil, frame)
            ghostSpark:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
            ghostSpark.bg = ghostSpark:CreateTexture(nil, "BACKGROUND", nil, -8)
            ghostSpark.bg:SetTexture(SEGMENT_SPARK_BG_PATH)
            ghostSpark.bg:SetPoint("CENTER", ghostSpark, "CENTER", 0, 0)
            ghostSpark.bg:SetSize(37, 37)
            ghostSpark.icon = ghostSpark:CreateTexture(nil, "OVERLAY", nil, 7)
            ghostSpark.icon:SetAllPoints()
            ghostSpark.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            ghostSpark.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            local mask = ghostSpark:CreateMaskTexture()
            mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
                "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints()
            ghostSpark.icon:AddMaskTexture(mask)
            ghostSpark:Hide()
            frame.snapshotMsSsgapGhostSparks[i] = ghostSpark
        end

        local semiCircleFrame = frame.snapshotMsArcaneSemiCircleFrames[i]
        if not semiCircleFrame then
            semiCircleFrame = CreateFrame("Frame", nil, frame)
            semiCircleFrame:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
            semiCircleFrame:SetFrameLevel(frame:GetFrameLevel() + 5)
            semiCircleFrame.texture = semiCircleFrame:CreateTexture(nil, "ARTWORK", nil, 0)
            semiCircleFrame.texture:SetColorTexture(0, 0, 0, 1)
            semiCircleFrame.texture:SetPoint("CENTER", semiCircleFrame, "CENTER", 0, 0)
            semiCircleFrame.texture:SetSize(floor(DEFAULT_ICON_SIZE * 1.30 + 0.5), floor(DEFAULT_ICON_SIZE * 1.30 + 0.5))
            local semiMask = semiCircleFrame:CreateMaskTexture()
            semiMask:SetTexture(MASK_4_AOE_PATH, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            semiMask:SetAllPoints(semiCircleFrame.texture)
            semiCircleFrame.texture:AddMaskTexture(semiMask)
            semiCircleFrame:Hide()
            frame.snapshotMsArcaneSemiCircleFrames[i] = semiCircleFrame
        end

        local companionSpark = frame.snapshotMsArcaneCompanionSparks[i]
        if not companionSpark then
            companionSpark = CreateFrame("Frame", nil, frame)
            companionSpark:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
            companionSpark:SetFrameLevel(frame:GetFrameLevel() + 10)
            companionSpark.icon = companionSpark:CreateTexture(nil, "OVERLAY", nil, 7)
            companionSpark.icon:SetAllPoints()
            companionSpark.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            companionSpark.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            local mask = companionSpark:CreateMaskTexture()
            mask:SetTexture(MASK_4_AOE_PATH, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints()
            companionSpark.icon:AddMaskTexture(mask)
            companionSpark:Hide()
            frame.snapshotMsArcaneCompanionSparks[i] = companionSpark
        end

        local holdBar = frame.snapshotHoldBars[i]
        if not holdBar then
            holdBar = {
                base = frame:CreateTexture(nil, "ARTWORK", nil, -5),
                red = frame:CreateTexture(nil, "ARTWORK", nil, -4),
                yellow = frame:CreateTexture(nil, "ARTWORK", nil, -4),
                green = frame:CreateTexture(nil, "ARTWORK", nil, -4),
            }
            holdBar.base:SetColorTexture(0, 0, 0, 0.95)
            holdBar.red:SetColorTexture(0.95, 0.20, 0.20, 0.95)
            holdBar.yellow:SetColorTexture(0.95, 0.85, 0.20, 0.95)
            holdBar.green:SetColorTexture(0.12, 0.45, 0.18, 0.95)
            holdBar.base:Hide()
            holdBar.red:Hide()
            holdBar.yellow:Hide()
            holdBar.green:Hide()
            frame.snapshotHoldBars[i] = holdBar
        end

    end
    for i = 1, MAX_SNAPSHOT_SEGMENTS do
        local tick = frame.snapshotAutoshotTicks[i]
        if not tick then
            tick = CreateFrame("Frame", nil, frame)
            tick:SetSize(3, 8)
            tick.marker = tick:CreateTexture(nil, "OVERLAY", nil, 7)
            tick.marker:SetAllPoints()
            tick.marker:SetColorTexture(1, 1, 1, 0.90)
            tick.label = tick:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            tick.label:SetPoint("TOP", tick, "BOTTOM", 0, -1)
            tick.label:SetJustifyH("CENTER")
            tick.label:SetTextColor(1, 1, 1, 0.9)
            tick.label:SetText("")
            tick:Hide()
            frame.snapshotAutoshotTicks[i] = tick
        end
    end

    if not frame.snapshotGcdBar then
        frame.snapshotGcdBar = frame:CreateTexture(nil, "ARTWORK", nil, 6)
        frame.snapshotGcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
        frame.snapshotGcdBar:SetSize(0, tonumber(self.db.class.gcdBarHeight or 8) or 8)
        local gcdBarColor = self.db.class.gcdBarColor or defaults.class.gcdBarColor
        frame.snapshotGcdBar:SetColorTexture(
            tonumber(gcdBarColor.r or 0.40) or 0.40,
            tonumber(gcdBarColor.g or 0.40) or 0.40,
            tonumber(gcdBarColor.b or 0.40) or 0.40,
            tonumber(gcdBarColor.a or 0.95) or 0.95
        )
        frame.snapshotGcdBar:Hide()
    end
end

--- @param self HunterSteadyWeaveBar
local function HideSnapshotVisualPools(self)
    if not frame then
        return
    end
    if frame.snapshotActionSparks then
        for i = 1, #frame.snapshotActionSparks do
            local sparkFrame = frame.snapshotActionSparks[i]
            if sparkFrame then
                sparkFrame:Hide()
            end
        end
    end
    if frame.snapshotMsSsgapGhostSparks then
        for i = 1, #frame.snapshotMsSsgapGhostSparks do
            local g = frame.snapshotMsSsgapGhostSparks[i]
            if g then
                g:Hide()
            end
        end
    end
    if frame.snapshotMsArcaneSemiCircleFrames then
        for i = 1, #frame.snapshotMsArcaneSemiCircleFrames do
            local semi = frame.snapshotMsArcaneSemiCircleFrames[i]
            if semi then
                semi:Hide()
            end
        end
    end
    if frame.snapshotMsArcaneCompanionSparks then
        for i = 1, #frame.snapshotMsArcaneCompanionSparks do
            local companion = frame.snapshotMsArcaneCompanionSparks[i]
            if companion then
                companion:Hide()
            end
        end
    end
    if frame.snapshotHoldBars then
        for i = 1, #frame.snapshotHoldBars do
            local holdBar = frame.snapshotHoldBars[i]
            if holdBar then
                if holdBar.base then holdBar.base:Hide() end
                if holdBar.red then holdBar.red:Hide() end
                if holdBar.yellow then holdBar.yellow:Hide() end
                if holdBar.green then holdBar.green:Hide() end
            end
        end
    end
    if frame.snapshotAutoshotTicks then
        for i = 1, #frame.snapshotAutoshotTicks do
            local tick = frame.snapshotAutoshotTicks[i]
            if tick then
                if tick.label then
                    tick.label:SetText("")
                end
                tick:Hide()
            end
        end
    end
    if frame.snapshotGcdBar then
        frame.snapshotGcdBar:Hide()
    end
end

--- @param self HunterSteadyWeaveBar
--- @param barCenterY number
--- @param barHeight number
--- @param swingCenterY number
local function HideLiveVisualsForSnapshot(self, barCenterY, barHeight, swingCenterY)
    if not frame then
        return
    end

    if background and self.db.class.showBackground then
        local bgScale = tonumber(self.db.class.backgroundScale or 1.0) or 1.0
        local scaledBarHeight = max(1, barHeight * bgScale)
        background:ClearAllPoints()
        background:SetPoint(
            "LEFT",
            frame,
            "LEFT",
            tonumber(self.db.class.backgroundOffsetX or 0) or 0,
            barCenterY + (tonumber(self.db.class.backgroundOffsetY or 0) or 0)
        )
        background:SetSize(self.db.class.width, scaledBarHeight)
        background:Show()
    elseif background then
        background:Hide()
    end

    if timelineBar then timelineBar:Hide() end
    if bgArt and self.db.class.showBgArt then
        local bgArtScale = tonumber(self.db.class.bgArtScale or 1.0) or 1.0
        bgArt:ClearAllPoints()
        bgArt:SetPoint("CENTER", frame, "CENTER", self.db.class.bgArtOffsetX or 0, self.db.class.bgArtOffsetY or 0)
        bgArt:SetSize((self.db.class.bgArtWidth or 207) * bgArtScale, (self.db.class.bgArtHeight or 20) * bgArtScale)
        bgArt:SetAlpha(self.db.class.bgArtAlpha or 1)
        bgArt:Show()
    elseif bgArt then
        bgArt:Hide()
    end
    if greenCircle and self.db.class.showGreenCircle then
        local color = self.db.class.greenCircleColor or defaults.class.greenCircleColor
        local greenScale = tonumber(self.db.class.greenCircleScale or 1.0) or 1.0
        local size = (tonumber(self.db.class.greenCircleSize or 20) or 20) * greenScale
        local alpha = tonumber(self.db.class.greenCircleAlpha or color.a or 0.9) or 0.9
        greenCircle:SetTexture(ZERO_MARKER_TEXTURE)
        greenCircle:SetTexCoord(0, 1, 0, 1)
        greenCircle:SetVertexColor(1, 1, 1, 1)
        greenCircle:SetAlpha(alpha)
        greenCircle:ClearAllPoints()
        greenCircle:SetPoint(
            "LEFT",
            frame,
            "LEFT",
            tonumber(self.db.class.greenCircleOffsetX or 0) or 0,
            tonumber(self.db.class.greenCircleOffsetY or 0) or 0
        )
        greenCircle:SetSize(size, size)
        greenCircle:Show()
    elseif greenCircle then
        greenCircle:Hide()
    end

    if swingBar then swingBar:Hide() end
    if pastSwingBar then pastSwingBar:Hide() end
    if gcdBar then gcdBar:Hide() end
    if swingSpark then swingSpark:Hide() end
    if gcdSpark then gcdSpark:Hide() end
    if gcdSparkLeft then gcdSparkLeft:Hide() end
    if windupMarkerLeft then windupMarkerLeft:Hide() end
    if windupMarkerRight then windupMarkerRight:Hide() end
    if windupMarkerLeftBg then windupMarkerLeftBg:Hide() end
    if windupMarkerRightBg then windupMarkerRightBg:Hide() end
    if windupHighlight then windupHighlight:Hide() end
    if earlyGapHighlight then earlyGapHighlight:Hide() end
    if earlyGapHighlightWrap then earlyGapHighlightWrap:Hide() end
    if earlyGapMarkerLeft then earlyGapMarkerLeft:Hide() end
    if earlyGapMarkerRight then earlyGapMarkerRight:Hide() end
    if gcdLandingMarker then gcdLandingMarker:Hide() end
    if gcdLandingText then gcdLandingText:Hide() end
    if gcdLandingFillerIcon then gcdLandingFillerIcon:Hide() end
    if gcdMovingFillerIcon then gcdMovingFillerIcon:Hide() end
    if steadyShotText then steadyShotText:Hide() end

    if nowMarker then
        nowMarker:ClearAllPoints()
        nowMarker:SetPoint("TOP", frame, "LEFT", 0, swingCenterY + 12)
        nowMarker:SetPoint("BOTTOM", frame, "LEFT", 0, swingCenterY - 12)
        nowMarker:Show()
    end
    if nowMarkerInner then
        nowMarkerInner:ClearAllPoints()
        nowMarkerInner:SetPoint("TOP", frame, "LEFT", 0, swingCenterY + 12)
        nowMarkerInner:SetPoint("BOTTOM", frame, "LEFT", 0, swingCenterY - 12)
        nowMarkerInner:Show()
    end

    if frame.sparks then
        for i = 1, #frame.sparks do
            if frame.sparks[i] then
                frame.sparks[i]:Hide()
            end
        end
    end
    if frame.segmentSparks then
        for i = 1, #frame.segmentSparks do
            if frame.segmentSparks[i] then
                frame.segmentSparks[i]:Hide()
            end
        end
    end
    if segmentDividerLines then
        for i = 1, #segmentDividerLines do
            if segmentDividerLines[i] then
                segmentDividerLines[i]:Hide()
            end
        end
    end
end

--- @param self HunterSteadyWeaveBar
local function RenderSnapshotEmptyState(self)
    if not frame then
        return
    end
    local db = self.db.class
    frame:SetSize(tonumber(db.width or 180) or 180, tonumber(db.height or 63) or 63)
    frame:SetAlpha(db.alpha or 1.0)
    HideSnapshotVisualPools(self)
    HideLiveVisualsForSnapshot(self, db.barOffsetY or -1, tonumber(db.barHeight or 1) or 1, 0)
end

--- Resolve snapshot elapsed time for countdown display.
--- Uses wall-clock elapsed; freezes at 0 only when idleAtWindup override is active.
--- Previously froze when HunterIsAutoShooting() was false (past first autoshot), which caused
--- stuttering: IsAutoRepeatSpell can return false during casts/GCD, freezing the bar until next auto.
--- @param self HunterSteadyWeaveBar
--- @param snapshot table
--- @return number
local function GetSnapshotElapsedSeconds(self, snapshot)
    local snapshotAt = tonumber(snapshot and snapshot.snapshotAt or 0) or 0
    local wallElapsed = max(0, (GetTime() - snapshotAt))

    if not snapshot then
        return wallElapsed
    end

    if snapshot.idleAtWindup == true then
        return 0
    end

    return wallElapsed
end

--- @param self HunterSteadyWeaveBar
--- @param snapshot table
--- @return boolean
local function RenderDebugSnapshotTimeline(self, snapshot)
    if not frame then
        return false
    end
    EnsureSnapshotVisualPools(self)
    HideSnapshotVisualPools(self)

    local db = self.db.class
    local width = tonumber(db.width or 0) or 0
    local baseHeight = tonumber(db.height or 0) or 0
    local barHeight = tonumber(db.barHeight or 3) or 3
    local swingHeight = baseHeight + 5
    local sparkScale = tonumber(db.snapshotSparkScale or 1.0) or 1.0
    local baseLaneTopOffset = tonumber(db.predictionTopLaneOffsetY or 12) or 12
    local baseLaneBottomOffset = tonumber(db.predictionBottomLaneOffsetY or -12) or -12
    local laneTopOffset = baseLaneTopOffset * sparkScale
    local laneBottomOffset = baseLaneBottomOffset * sparkScale

    local topLanePad = max(12, math.abs(laneTopOffset) + 14)
    local bottomLanePad = max(12, math.abs(laneBottomOffset) + 14)
    local totalHeight = swingHeight + topLanePad + bottomLanePad
    frame:SetSize(width, totalHeight)
    local swingCenterY = 0
    local barCenterY = swingCenterY + (db.barOffsetY or -1)
    frame:SetAlpha(db.alpha or 1.0)

    HideLiveVisualsForSnapshot(self, barCenterY, barHeight, swingCenterY)

    local elapsed = GetSnapshotElapsedSeconds(self, snapshot)
    local horizon = tonumber(snapshot.horizonSeconds or 0) or 0
    if horizon <= 0 then
        horizon = DEFAULT_SNAPSHOT_HORIZON_SECONDS
    end
    local visibleWindowSeconds = tonumber(db.visibleWindowSeconds or 4) or 4
    if visibleWindowSeconds < 1 then
        visibleWindowSeconds = 1
    end
    if visibleWindowSeconds > horizon then
        visibleWindowSeconds = horizon
    end

    local laneConfiguration = ResolveLaneConfiguration(db)
    local sparkSize = max(8, DEFAULT_ICON_SIZE * sparkScale)
    local ringSize = max(10, 37 * sparkScale)
    local holdBarScale = tonumber(db.holdBarScale or 1.0) or 1.0
    local holdBaseHeight = max(1, 7 * holdBarScale)
    local holdColorHeight = max(1, 5 * holdBarScale)
    local holdXOffset = tonumber(db.holdBarOffsetX or 0) or 0
    local holdYOffset = tonumber(db.holdBarOffsetY or 0) or 0
    local topLaneOffsetX = tonumber(db.predictionTopLaneOffsetX or 0) or 0
    local bottomLaneOffsetX = tonumber(db.predictionBottomLaneOffsetX or 0) or 0
    local labelMode = tostring(db.sparkLabelMode or "none")
    local showAutoshotTicks = db.showAutoshotTicks and true or false
    local showGcdBar = db.showGcdBar and true or false

    local holdIdx = 1
    local actionIdx = 1
    local tickIdx = 1
    local pendingHoldDuration = 0
    local tickDedup = {}
    local autoshotMoments = snapshot.autoshotMoments
    local hasAutoshotMoments = type(autoshotMoments) == "table" and #autoshotMoments > 0

    if frame.snapshotGcdBar then
        if showGcdBar then
            local gcdRemaining = (NAG and NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
            gcdRemaining = tonumber(gcdRemaining or 0) or 0
            if gcdRemaining < 0 then
                gcdRemaining = 0
            end
            if gcdRemaining > 0 and gcdRemaining <= visibleWindowSeconds then
                local gcdWidth = SnapshotSecondsToX(gcdRemaining, visibleWindowSeconds, width)
                local gcdBarHeight = max(1, tonumber(db.gcdBarHeight or 8) or 8)
                local gcdBarOffsetY = tonumber(db.gcdBarOffsetY or 0) or 0
                local gcdBarColor = db.gcdBarColor or defaults.class.gcdBarColor
                frame.snapshotGcdBar:ClearAllPoints()
                frame.snapshotGcdBar:SetPoint("LEFT", frame, "LEFT", 0, barCenterY + gcdBarOffsetY)
                frame.snapshotGcdBar:SetSize(max(0, gcdWidth), gcdBarHeight)
                frame.snapshotGcdBar:SetColorTexture(
                    tonumber(gcdBarColor.r or 0.40) or 0.40,
                    tonumber(gcdBarColor.g or 0.40) or 0.40,
                    tonumber(gcdBarColor.b or 0.40) or 0.40,
                    tonumber(gcdBarColor.a or 0.95) or 0.95
                )
                frame.snapshotGcdBar:Show()
            else
                frame.snapshotGcdBar:Hide()
            end
        else
            frame.snapshotGcdBar:Hide()
        end
    end

    local tickWidth = max(1, tonumber(db.autoshotTickWidth or 2) or 2)
    local tickHeight = max(2, tonumber(db.autoshotTickHeight or 5) or 5)
    local tickColor = db.autoshotTickColor or defaults.class.autoshotTickColor
    local tickOffsetX = tonumber(db.autoshotTickOffsetX or 0) or 0
    local tickOffsetY = tonumber(db.autoshotTickOffsetY or 6) or 6
    local tickR = tonumber(tickColor.r or 1) or 1
    local tickG = tonumber(tickColor.g or 1) or 1
    local tickB = tonumber(tickColor.b or 1) or 1
    local tickA = tonumber(tickColor.a or 0.9) or 0.9

    local function ShowAutoshotTick(remaining)
        if not showAutoshotTicks or tickIdx > MAX_SNAPSHOT_SEGMENTS then
            return
        end
        local tickRemaining = tonumber(remaining or 0) or 0
        if tickRemaining < 0 or tickRemaining > visibleWindowSeconds then
            return
        end
        local tickKey = string.format("%.3f", tickRemaining)
        if tickDedup[tickKey] then
            return
        end
        tickDedup[tickKey] = true
        local tick = frame.snapshotAutoshotTicks and frame.snapshotAutoshotTicks[tickIdx]
        if not tick then
            return
        end
        local tickX = SnapshotSecondsToX(tickRemaining, visibleWindowSeconds, width)
        tick:ClearAllPoints()
        tick:SetPoint("CENTER", frame, "LEFT", tickX + tickOffsetX, barCenterY + tickOffsetY)
        tick:SetSize(tickWidth, tickHeight)
        if tick.marker then
            tick.marker:SetSize(tickWidth, tickHeight)
            tick.marker:SetColorTexture(tickR, tickG, tickB, tickA)
        end
        if tick.label then
            if db.showAutoshotTickLabels then
                tick.label:SetText(string.format("%.1f", tickRemaining))
                tick.label:Show()
            else
                tick.label:SetText("")
                tick.label:Hide()
            end
        end
        tick:Show()
        tickIdx = tickIdx + 1
    end
    local segments = snapshot.segments or {}
    for i = 1, #segments do
        local segment = segments[i]
        local actionName = tostring(segment and segment[1] or "")
        local t1 = tonumber(segment and segment[2] or 0) or 0
        local t2 = tonumber(segment and segment[3] or 0) or 0

        if actionName == "HOLD" then
            local holdDuration = max(0, t2 - t1)
            pendingHoldDuration = holdDuration
            local holdStartRaw = t1 - elapsed
            local holdEndRaw = t2 - elapsed
            local holdStart = max(0, min(visibleWindowSeconds, holdStartRaw))
            local holdEnd = max(0, min(visibleWindowSeconds, holdEndRaw))
            if holdEnd > holdStart and holdIdx <= MAX_SNAPSHOT_SEGMENTS then
                local x1 = SnapshotSecondsToX(holdStart, visibleWindowSeconds, width)
                local x2 = SnapshotSecondsToX(holdEnd, visibleWindowSeconds, width)
                local holdBar = frame.snapshotHoldBars[holdIdx]
                if holdBar and holdBar.base then
                    local holdY = barCenterY + holdYOffset
                    local holdWidth = x2 - x1
                    holdBar.base:ClearAllPoints()
                    holdBar.base:SetPoint("LEFT", frame, "LEFT", x1 + holdXOffset, holdY)
                    holdBar.base:SetSize(holdWidth, holdBaseHeight)
                    holdBar.base:Show()

                    local redStart = holdStart
                    local redEnd = min(holdEnd, holdEndRaw - 0.6)
                    local yellowStart = max(holdStart, holdEndRaw - 0.6)
                    local yellowEnd = min(holdEnd, holdEndRaw - 0.1)
                    local greenStart = max(holdStart, holdEndRaw - 0.1)
                    local greenEnd = holdEnd

                    if holdBar.red and redEnd > redStart then
                        local redX1 = SnapshotSecondsToX(redStart, visibleWindowSeconds, width)
                        local redX2 = SnapshotSecondsToX(redEnd, visibleWindowSeconds, width)
                        holdBar.red:ClearAllPoints()
                        holdBar.red:SetPoint("LEFT", frame, "LEFT", redX1 + holdXOffset, holdY)
                        holdBar.red:SetSize(max(0, redX2 - redX1), holdColorHeight)
                        holdBar.red:Show()
                    end
                    if holdBar.yellow and yellowEnd > yellowStart then
                        local yellowX1 = SnapshotSecondsToX(yellowStart, visibleWindowSeconds, width)
                        local yellowX2 = SnapshotSecondsToX(yellowEnd, visibleWindowSeconds, width)
                        holdBar.yellow:ClearAllPoints()
                        holdBar.yellow:SetPoint("LEFT", frame, "LEFT", yellowX1 + holdXOffset, holdY)
                        holdBar.yellow:SetSize(max(0, yellowX2 - yellowX1), holdColorHeight)
                        holdBar.yellow:Show()
                    end
                    if holdBar.green and greenEnd > greenStart then
                        local greenX1 = SnapshotSecondsToX(greenStart, visibleWindowSeconds, width)
                        local greenX2 = SnapshotSecondsToX(greenEnd, visibleWindowSeconds, width)
                        holdBar.green:ClearAllPoints()
                        holdBar.green:SetPoint("LEFT", frame, "LEFT", greenX1 + holdXOffset, holdY)
                        holdBar.green:SetSize(max(0, greenX2 - greenX1), holdColorHeight)
                        holdBar.green:Show()
                    end
                end
                holdIdx = holdIdx + 1
            end
        elseif actionName == "SS" or actionName == "MS" or actionName == "AR" then
            local remaining = t1 - elapsed
            local actionHoldDuration = pendingHoldDuration
            pendingHoldDuration = 0
            local displayRemaining = remaining
            -- Show spark from in-window until 150ms past zero so the flow stays visible.
            if remaining >= -SPELL_VISIBLE_PAST_ZERO_SECONDS and remaining <= visibleWindowSeconds and actionIdx <= MAX_SNAPSHOT_SEGMENTS then
                local sparkFrame = frame.snapshotActionSparks[actionIdx]
                if sparkFrame then
                    -- Negative remaining: pin to zero marker (SnapshotSecondsToX clamps to 0).
                    local x = SnapshotSecondsToX(displayRemaining, visibleWindowSeconds, width)
                    local useTopLane, rotateBg = ResolveSnapshotLanePlacement(actionName, laneConfiguration)
                    local laneY = useTopLane and (swingCenterY + laneTopOffset) or (swingCenterY + laneBottomOffset)
                    local laneXOffset = useTopLane and topLaneOffsetX or bottomLaneOffsetX
                    local spellId = GetActionSpellIdForSnapshot(actionName)
                    local iconTexture = (spellId and GetSpellTexture(spellId)) or "Interface\\Icons\\INV_Misc_QuestionMark"
                    -- Color driven by HOLD duration when short: if HOLD was close to zero, SS is green all the way.
                    -- Otherwise remaining drives red->yellow->green. Use monotonic so it never regresses.
                    local SHORT_HOLD_GREEN_BOUNDARY = 0.15
                    local rawHoldForColor = max(0, remaining)
                    if actionHoldDuration and actionHoldDuration <= SHORT_HOLD_GREEN_BOUNDARY then
                        rawHoldForColor = min(rawHoldForColor, actionHoldDuration)
                    end
                    local lastHold = sparkFrame._lastHoldForColor
                    local effectiveHoldForColor
                    if lastHold == nil or rawHoldForColor > lastHold + 0.05 then
                        effectiveHoldForColor = rawHoldForColor
                    else
                        effectiveHoldForColor = min(lastHold, rawHoldForColor)
                    end
                    sparkFrame._lastHoldForColor = effectiveHoldForColor
                    local instantCast = (actionName == "AR" or actionHoldDuration <= 0)
                    local bgR, bgG, bgB, bgA = GetHoldColor(effectiveHoldForColor, instantCast)

                    -- MS+AR dual display: when MS is predicted and AR is off CD, show AR icon overlaying MS (same position).
                    local msWithArCompanion = (actionName == "MS") and IsArcaneShotOffCooldown()

                    sparkFrame.icon:SetTexture(iconTexture)
                    sparkFrame.icon:SetDesaturated(false)
                    sparkFrame.icon:SetAlpha(1.0)
                    sparkFrame.bg:SetVertexColor(bgR, bgG, bgB, bgA)
                    sparkFrame.bg:SetAlpha(0.95)
                    sparkFrame.bg:SetSize(ringSize, ringSize)
                    sparkFrame.bg:SetRotation(0)
                    if rotateBg then
                        sparkFrame.bg:SetTexCoord(0, 1, 1, 0)
                    else
                        sparkFrame.bg:SetTexCoord(0, 1, 0, 1)
                    end
                    sparkFrame:SetSize(sparkSize, sparkSize)
                    sparkFrame:ClearAllPoints()
                    sparkFrame:SetPoint("CENTER", frame, "LEFT", x + laneXOffset, laneY)
                    if labelMode == "spell" then
                        sparkFrame.label:SetText(GetActionAbbreviation(actionName))
                    elseif labelMode == "time" then
                        sparkFrame.label:SetText(string.format("%.1f", remaining))
                    elseif labelMode == "hold" then
                        if actionHoldDuration > 0 then
                            local holdLabelValue = (remaining <= actionHoldDuration) and max(0, remaining) or actionHoldDuration
                            -- Don't show HOLD text when truncated to 0.0 (%.1f rounds < 0.05 to 0.0)
                            if holdLabelValue >= 0.05 then
                                sparkFrame.label:SetText(string.format("%.1f", holdLabelValue))
                            else
                                sparkFrame.label:SetText("")
                            end
                        else
                            sparkFrame.label:SetText("")
                        end
                    else
                        sparkFrame.label:SetText("")
                    end
                    sparkFrame.label:ClearAllPoints()
                    if useTopLane then
                        sparkFrame.label:SetPoint("BOTTOM", sparkFrame, "TOP", 0, 2)
                    else
                        sparkFrame.label:SetPoint("TOP", sparkFrame, "BOTTOM", 0, -2)
                    end
                    if labelMode == "hold" then
                        sparkFrame.label:SetTextColor(bgR, bgG, bgB, bgA)
                    else
                        sparkFrame.label:SetTextColor((actionName == "SS") and 0.55 or 0.95, 0.95, 0.55, 0.95)
                    end
                    sparkFrame.spellId = spellId
                    sparkFrame:Show()

                    -- MS black circle border (15% larger) when MS+AR dual display.
                    local circleBorderSize = floor(sparkSize * 1.15 + 0.5)
                    local borderSize = floor(sparkSize * 1.30 + 0.5)
                    if sparkFrame.msCircleBorder then
                        if msWithArCompanion then
                            sparkFrame.msCircleBorder:SetSize(circleBorderSize, circleBorderSize)
                            sparkFrame.msCircleBorder:Show()
                        else
                            sparkFrame.msCircleBorder:Hide()
                        end
                    end

                    -- Black semicircle border (strata between MS and AR) when MS+AR dual display.
                    local semiCircleFrame = frame.snapshotMsArcaneSemiCircleFrames and frame.snapshotMsArcaneSemiCircleFrames[actionIdx]
                    if msWithArCompanion and semiCircleFrame then
                        local semiCircleHeight = max(1, borderSize - 2)
                        semiCircleFrame:SetSize(borderSize, semiCircleHeight)
                        semiCircleFrame.texture:SetSize(borderSize, semiCircleHeight)
                        semiCircleFrame:ClearAllPoints()
                        semiCircleFrame:SetPoint("CENTER", frame, "LEFT", x + laneXOffset - 1, laneY)
                        semiCircleFrame:Show()
                    elseif semiCircleFrame then
                        semiCircleFrame:Hide()
                    end

                    -- AR companion spark when MS is predicted and AR is off CD (plan B for CC situations).
                    local companionSpark = frame.snapshotMsArcaneCompanionSparks and frame.snapshotMsArcaneCompanionSparks[actionIdx]
                    if msWithArCompanion and companionSpark then
                        local arSpellId = ARCANE_SHOT_ID
                        local arIconTexture = (arSpellId and GetSpellTexture(arSpellId)) or "Interface\\Icons\\INV_Misc_QuestionMark"
                        companionSpark.icon:SetTexture(arIconTexture)
                        companionSpark.icon:SetDesaturated(false)
                        companionSpark.icon:SetAlpha(1.0)
                        companionSpark:SetSize(sparkSize, sparkSize)
                        companionSpark:ClearAllPoints()
                        companionSpark:SetPoint("CENTER", frame, "LEFT", x + laneXOffset, laneY)
                        companionSpark:Show()
                    elseif companionSpark then
                        companionSpark:Hide()
                    end

                end
                actionIdx = actionIdx + 1
            end

            -- Ghost SS at next wind-up gap after every filler (MS or AR): black desaturated SS cue.
            if actionName == "MS" or actionName == "AR" then
                local windupSeconds = tonumber(snapshot.windupSeconds or 0) or 0
                if windupSeconds > 0 and hasAutoshotMoments then
                    local nextAutoshot = nil
                    for j = 1, #autoshotMoments do
                        local ao = tonumber(autoshotMoments[j] or 0) or 0
                        if ao > t1 then
                            nextAutoshot = ao
                            break
                        end
                    end
                    if nextAutoshot then
                        local nextSSGap = nextAutoshot - windupSeconds
                        local ghostRemaining = nextSSGap - elapsed
                        local ghostIdx = (remaining >= -SPELL_VISIBLE_PAST_ZERO_SECONDS and remaining <= visibleWindowSeconds) and (actionIdx - 1) or actionIdx
                        if ghostRemaining > 0 and ghostRemaining <= visibleWindowSeconds then
                            local ghostSpark = frame.snapshotMsSsgapGhostSparks and frame.snapshotMsSsgapGhostSparks[ghostIdx]
                                if ghostSpark then
                                    local useTopLaneGhost = ResolveSnapshotLanePlacement("SS", laneConfiguration)
                                    local ghostLaneY = useTopLaneGhost and (swingCenterY + laneTopOffset) or (swingCenterY + laneBottomOffset)
                                    local ghostLaneXOffset = useTopLaneGhost and topLaneOffsetX or bottomLaneOffsetX
                                    local ghostX = SnapshotSecondsToX(ghostRemaining, visibleWindowSeconds, width)
                                    local ssSpellId = GetActionSpellIdForSnapshot("SS")
                                    local ssIconTexture = (ssSpellId and GetSpellTexture(ssSpellId)) or "Interface\\Icons\\INV_Misc_QuestionMark"
                                    ghostSpark.icon:SetTexture(ssIconTexture)
                                    ghostSpark.icon:SetDesaturated(true)
                                    ghostSpark.icon:SetAlpha(0.45)
                                    ghostSpark.bg:SetVertexColor(0, 0, 0, 0.45)
                                    ghostSpark.bg:SetAlpha(0.45)
                                    ghostSpark.bg:SetSize(ringSize, ringSize)
                                    ghostSpark.bg:SetTexCoord(0, 1, 0, 1)
                                    ghostSpark:SetSize(sparkSize, sparkSize)
                                    ghostSpark:ClearAllPoints()
                                    ghostSpark:SetPoint("CENTER", frame, "LEFT", ghostX + ghostLaneXOffset, ghostLaneY)
                                    ghostSpark:Show()
                                end
                        end
                    end
                end
            end

            if (not hasAutoshotMoments) and actionName == "SS" and t2 > t1 then
                ShowAutoshotTick(t2 - elapsed)
            end
        end
    end
    if hasAutoshotMoments then
        for i = 1, #autoshotMoments do
            ShowAutoshotTick((tonumber(autoshotMoments[i] or 0) or 0) - elapsed)
            if tickIdx > MAX_SNAPSHOT_SEGMENTS then
                break
            end
        end
    end

    return true
end

--- Icon spell ID: Steady Shot if known, else Aimed Shot (pre-62).
--- @return number spellId
local function GetSteadyBarSpellId()
    if NAG.SpellIsKnown and NAG:SpellIsKnown(STEADY_SHOT_ID) then
        return STEADY_SHOT_ID
    end
    return AIMED_SHOT_ID
end

--- True if the spellId represents any Aimed Shot rank.
--- @param spellId number|nil
--- @return boolean
local function IsAimedShotSpellId(spellId)
    if type(spellId) ~= "number" then
        return false
    end
    return AIMED_SHOT_ID_SET[spellId] == true
end

--- True if the spellId represents any Multi-Shot rank.
--- @param spellId number|nil
--- @return boolean
local function IsMultiShotSpellId(spellId)
    if type(spellId) ~= "number" then
        return false
    end
    return MULTI_SHOT_ID_SET[spellId] == true
end

--- True if the spellId represents any Arcane Shot rank.
--- @param spellId number|nil
--- @return boolean
local function IsArcaneShotSpellId(spellId)
    if type(spellId) ~= "number" then
        return false
    end
    return ARCANE_SHOT_ID_SET[spellId] == true
end

local function SetSparkKeybind(spark, showKeybind)
    if not spark or not spark.keybindText then return end
    if showKeybind and spark.spellId then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind then
            kb = KeybindManager:GetSpellKeybind(spark.spellId) or ""
        end
        spark.keybindText:SetText(kb)
        if kb ~= "" then
            spark.keybindText:Show()
        else
            spark.keybindText:Hide()
        end
    else
        spark.keybindText:SetText("")
        spark.keybindText:Hide()
    end
end

--- True if the player is in melee range of the target.
--- @return boolean
local function IsInMeleeRange()
    if not NAG or not NAG.UnitExists or not NAG:UnitExists("target") then
        return false
    end
    if NAG.HunterInMelee and NAG:HunterInMelee("target") then
        return true
    end
    if NAG.TargetInMeleeRange and NAG:TargetInMeleeRange(5) then
        return true
    end
    return false
end

--- Returns true when global developer mode is enabled.
--- @return boolean
local function IsDevModeEnabled()
    return NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() or false
end

--- Resolve runtime swing speed for layout calculations.
--- Always returns a positive value so segment math remains valid while idle.
--- @param currentSwingSpeed number|nil
--- @return number
local function ResolveRuntimeSwingSpeed(currentSwingSpeed)
    if currentSwingSpeed and currentSwingSpeed > 0 then
        lastKnownRangedSwingSpeed = currentSwingSpeed
        return currentSwingSpeed
    end
    if lastKnownRangedSwingSpeed and lastKnownRangedSwingSpeed > 0 then
        return lastKnownRangedSwingSpeed
    end
    return DEFAULT_EFFECTIVE_GCD
end

--- Clamp dynamic segment cap with hard minimum of 2.
--- @param configuredMax number|nil
--- @return number
local function ResolveMaxSegments(configuredMax)
    local maxSegments = tonumber(configuredMax) or 4
    return max(MIN_SEGMENT_COUNT, min(MAX_DYNAMIC_SEGMENTS, floor(maxSegments)))
end

--- Resolve flat GCD duration used for segment-count math.
--- This is duration (GCD length), not remaining time to ready.
--- @return number
local function GetEffectiveGCDForSegments()
    local effectiveGCD = DEFAULT_EFFECTIVE_GCD
    if NAG and NAG.GCDTimeValue then
        local gcdValue = NAG:GCDTimeValue()
        if type(gcdValue) == "number" and gcdValue > 0 then
            effectiveGCD = gcdValue
        end
    end
    return effectiveGCD
end

--- Compute segment count with hard minimum of 2 in all modes.
--- @param maxSegments number
--- @param forcedSegmentCount number|nil
--- @param effectiveGCD number
--- @param swingSpeed number
--- @param lockedCount number|nil
--- @return number
local function ResolveSegmentCount(maxSegments, forcedSegmentCount, effectiveGCD, swingSpeed, lockedCount)
    if forcedSegmentCount and forcedSegmentCount > 0 then
        return min(maxSegments, max(MIN_SEGMENT_COUNT, floor(forcedSegmentCount)))
    end
    if lockedCount and lockedCount >= MIN_SEGMENT_COUNT and lockedCount <= maxSegments then
        return lockedCount
    end
    return min(maxSegments, max(MIN_SEGMENT_COUNT, ceil(effectiveGCD / swingSpeed)))
end

--- Recompute lock from current timing state.
--- @param db table|nil
function module:RefreshLockedSegmentCount(db)
    local classDb = db or (self.db and self.db.class)
    if not classDb then
        return
    end
    local _, swingSpeed = GetRangedSwing()
    local runtimeSwingSpeed = ResolveRuntimeSwingSpeed(swingSpeed)
    local effectiveGCD = GetEffectiveGCDForSegments()
    local maxSegments = ResolveMaxSegments(classDb.maxDynamicSegments)
    lockedSegmentCount = min(maxSegments, max(MIN_SEGMENT_COUNT, ceil(effectiveGCD / runtimeSwingSpeed)))
end

--- @param self HunterSteadyWeaveBar
local function ScheduleDeferredAnchorUpdate(self)
    if not (TimerManager and TimerManager.Categories and TimerManager.Create) then
        return
    end
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, ANCHOR_DEFER_TIMER)
    TimerManager:Create(
        TimerManager.Categories.UI_NOTIFICATION,
        ANCHOR_DEFER_TIMER,
        function()
            if self and frame and self.UpdateFrameAnchor then
                self:UpdateFrameAnchor()
            end
            local stateDebug = NAG:GetModule("HunterStateTimelineDebug", true)
            if stateDebug and stateDebug.RefreshBarSnapshot then
                stateDebug:RefreshBarSnapshot()
            end
        end,
        ANCHOR_DEFER_DELAY,
        false
    )
end

--- @param self HunterSteadyWeaveBar
local function CancelDeferredAnchorUpdate(self)
    if TimerManager and TimerManager.Cancel then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, ANCHOR_DEFER_TIMER)
    end
end

function module:UpdateFrameAnchor()
    if not frame then
        return
    end

    local db = self.db.class
    if not db.autoAnchor or not db.lockToNagAnchor then
        frame:SetParent(_G.UIParent)
        frame:ClearAllPoints()
        frame:SetPoint(db.point, db.x, db.y)
        return
    end

    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    if not anchor or anchor == _G.UIParent then
        frame:SetParent(_G.UIParent)
        frame:ClearAllPoints()
        frame:SetPoint(db.point, db.x, db.y)
        return
    end

    -- When the main display is hidden or has no size (e.g. before first combat), it may not have valid layout yet.
    -- Use a safe fallback (below center) and defer anchor capture until layout is ready.
    local anchorW, anchorH = anchor:GetSize()
    if not anchor:IsShown() or not (anchorW and anchorH and anchorW > 0 and anchorH > 0) then
        frame:SetParent(_G.UIParent)
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", _G.UIParent, "CENTER", 0, -80)
        ScheduleDeferredAnchorUpdate(self)
        return
    end

    CancelDeferredAnchorUpdate(self)

    -- Keep frame on UIParent so we don't affect the main frame (e.g. floating selector position)
    frame:SetParent(_G.UIParent)
    frame:ClearAllPoints()
    frame:SetPoint("TOP", anchor, "BOTTOM", db.x, db.y)

    -- Do NOT call RefreshBarSnapshot here: it would recurse via SetDebugSnapshot -> UpdateVisibility -> UpdateFrameAnchor.
    -- Predictions are filled by DoPredictionCompute (triggers) and the deferred anchor callback.
end

function module:NAG_FRAME_UPDATED()
    if frame then
        self:UpdateVisibility()
    end
end

--- Updates frame mouse/drag interaction based on draggable setting.
--- When draggable=false: click-through (EnableMouse false, SetMovable false).
--- When draggable=true: frame is movable and receives mouse input.
function module:UpdateFrameInteraction()
    if not frame then return end
    local db = self.db.class
    local canDrag = db.draggable == true
    frame:SetMovable(canDrag)
    frame:EnableMouse(canDrag)
    if frame.SetClickThrough and type(frame.SetClickThrough) == "function" then
        frame:SetClickThrough(not canDrag)
    end
end

function module:UpdateVisibility()
    if not frame then
        self:CreateFrameUI()
        if not frame then
            return
        end
    end

    local db = self.db.class

    -- Only show the bar when the rotation explicitly enables it via NAG:EnableTBCHunterSteadyBars().
    -- The gate expires after 5s if the rotation stops calling it.
    if NAG.IsTBCHunterSteadyBarsEnabled and not NAG:IsTBCHunterSteadyBarsEnabled() then
        CancelDeferredAnchorUpdate(self)
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end

    -- When showOnlyInCombat is true (default), hide the bar when not in combat.
    if db.showOnlyInCombat ~= false and not UnitAffectingCombat("player") then
        CancelDeferredAnchorUpdate(self)
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end

    local dm = NAG:GetModule("DisplayManager", true)
    local level = dm and dm.GetRecommendedClassBarFrameLevel and dm:GetRecommendedClassBarFrameLevel() or 50
    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel(level)
    frame:Show()
    self:UpdateFrameAnchor()
    self:UpdateFrameInteraction()
    local baseAlpha = db.alpha or 1.0
    frame:SetAlpha(baseAlpha)
    frame:SetScript("OnUpdate", function(_, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            self:UpdateDisplay()
            lastUpdate = 0
        end
    end)
end

function module:UpdateDisplay()
    if not frame then
        self:CreateFrameUI()
        if not frame then
            return
        end
    end

    -- Gate expired: hide and stop updating.
    if NAG.IsTBCHunterSteadyBarsEnabled and not NAG:IsTBCHunterSteadyBarsEnabled() then
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end

    -- When showOnlyInCombat is true (default), hide when not in combat.
    local db = self.db.class
    if db.showOnlyInCombat ~= false and not UnitAffectingCombat("player") then
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end
    local useDebugSnapshot = ShouldUseDebugSnapshot(self)

    if useDebugSnapshot then
        local snapshot = self.state and self.state.debugSnapshot
        if snapshot and RenderDebugSnapshotTimeline(self, snapshot) then
            return
        end
    end
    if true then
        RenderSnapshotEmptyState(self)
        return
    end

    local rawSwingLeft, swingSpeed = GetRangedSwing()
    local runtimeSwingSpeed = ResolveRuntimeSwingSpeed(swingSpeed)

    local baseAlpha = db.alpha or 1.0
    frame:SetAlpha(baseAlpha)

    local nextSpellId = tonumber(NAG and NAG.nextSpell) or nil
    local isRelevantNext = (nextSpellId == STEADY_SHOT_ID) or IsAimedShotSpellId(nextSpellId)
    local inCombat = UnitAffectingCombat("player")

    -- Flat GCD duration drives segment count (how many bars fit).
    -- Time-until-ready is only used later for lockout/landing marker logic.
    local width = db.width
    local effectiveGCD = GetEffectiveGCDForSegments()
    local maxSegments = ResolveMaxSegments(db.maxDynamicSegments)
    local forcedSegmentCount = tonumber(db.forceSegmentCount) or 0
    local segmentCount = ResolveSegmentCount(
        maxSegments,
        forcedSegmentCount,
        effectiveGCD,
        runtimeSwingSpeed,
        lockedSegmentCount
    )
    if not lockedSegmentCount and (not forcedSegmentCount or forcedSegmentCount <= 0) then
        lockedSegmentCount = segmentCount
    end
    local segmentWidth = width / segmentCount
    local autoX = segmentWidth * AUTO_POSITION_RATIO
    local baseHeight = db.height
    local swingHeight = baseHeight + 5
    local barHeight = db.barHeight or 3
    local gcdGap = 6
    local gcdSparkHeight = 5

    local totalHeight = swingHeight + gcdGap + gcdSparkHeight
    frame:SetSize(width, totalHeight)

    local swingCenterY = (totalHeight / 2) - (swingHeight / 2)
    local barCenterY = swingCenterY + (db.barOffsetY or 0)

    local timeToSwing = rawSwingLeft or 0
    if timeToSwing < 0 then timeToSwing = 0 end
    if timeToSwing > runtimeSwingSpeed then timeToSwing = runtimeSwingSpeed end

    local cyclePhase = 1
    if runtimeSwingSpeed > 0 then
        cyclePhase = (AUTO_POSITION_RATIO + (timeToSwing / runtimeSwingSpeed)) % 1
    end
    local sparkTargetX = cyclePhase * segmentWidth
    if sparkTargetX < 0 then sparkTargetX = 0 end
    if sparkTargetX > segmentWidth then sparkTargetX = segmentWidth end

    local gcdRemaining = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdRemaining < 0 then gcdRemaining = 0 end

    local ssCastRemaining = 0
    local _, _, _, _, endTimeMS, _, _, _, castingSpellId = UnitCastingInfo("player")
    if castingSpellId == STEADY_SHOT_ID and endTimeMS then
        ssCastRemaining = (endTimeMS / 1000) - GetTime()
        if ssCastRemaining < 0 then ssCastRemaining = 0 end
    end

    -- Single lockout source of truth for marker placement and spark visibility.
    -- We only consider actions available after BOTH GCD and current SS cast (if any) are finished.
    local lockoutRemaining = gcdRemaining
    if ssCastRemaining > lockoutRemaining then
        lockoutRemaining = ssCastRemaining
    end

    if background and db.showBackground then
        background:ClearAllPoints()
        background:SetPoint("LEFT", frame, "LEFT", 0, barCenterY)
        background:SetSize(width, barHeight)
        background:Show()
    elseif background then
        background:Hide()
    end

    if timelineBar and db.showTimelineBar then
        timelineBar:SetPoint("LEFT", frame, "LEFT", 0, barCenterY)
        timelineBar:SetSize(width, barHeight)
        timelineBar:SetColorTexture(db.gcdColor.r, db.gcdColor.g, db.gcdColor.b, 0.45)
        timelineBar:Show()
    elseif timelineBar then
        timelineBar:Hide()
    end

    if bgArt and db.showBgArt then
        bgArt:SetPoint("CENTER", frame, "CENTER", db.bgArtOffsetX or 0, db.bgArtOffsetY or 0)
        bgArt:SetSize(db.bgArtWidth or 260, db.bgArtHeight or 71)
        bgArt:SetAlpha(db.bgArtAlpha or 1)
        bgArt:Show()
    elseif bgArt then
        bgArt:Hide()
    end

    if nowMarker and db.showNowMarker then
        local y = barCenterY + (db.nowMarkerOffsetY or 0)
        local leftX = tonumber(db.nowMarkerOuterLeftOffsetX)
        local rightX = tonumber(db.nowMarkerOuterRightOffsetX)
        -- Back-compat fallback (older profiles used width-only).
        if leftX == nil then
            leftX = -tonumber(db.nowMarkerWidth or 2) or -2
        end
        if rightX == nil then
            rightX = 0
        end
        if leftX > rightX then
            leftX, rightX = rightX, leftX
        end
        nowMarker:ClearAllPoints()
        nowMarker:SetPoint("LEFT", frame, "RIGHT", leftX, y)
        nowMarker:SetPoint("RIGHT", frame, "RIGHT", rightX, y)
        nowMarker:SetHeight(barHeight)
        nowMarker:Show()
    elseif nowMarker then
        nowMarker:Hide()
    end

    if nowMarkerInner and db.showNowMarker then
        local y = barCenterY + (db.nowMarkerOffsetY or 0)
        local leftX = tonumber(db.nowMarkerInnerLeftOffsetX)
        local rightX = tonumber(db.nowMarkerInnerRightOffsetX)
        -- Back-compat fallback (older profiles used width-only).
        if leftX == nil then
            leftX = -tonumber(db.nowMarkerInnerWidth or 1) or -1
        end
        if rightX == nil then
            rightX = 0
        end
        if leftX > rightX then
            leftX, rightX = rightX, leftX
        end
        nowMarkerInner:ClearAllPoints()
        nowMarkerInner:SetPoint("LEFT", frame, "RIGHT", leftX, y)
        nowMarkerInner:SetPoint("RIGHT", frame, "RIGHT", rightX, y)
        nowMarkerInner:SetHeight(barHeight)
        nowMarkerInner:Show()
    elseif nowMarkerInner then
        nowMarkerInner:Hide()
    end

    if segmentDividerLines then
        local showDividers = db.showSegmentDividers and segmentCount > 1
        for i = 1, #segmentDividerLines do
            local divider = segmentDividerLines[i]
            if divider and showDividers and i < segmentCount then
                divider:ClearAllPoints()
                divider:SetPoint("LEFT", frame, "LEFT", i * segmentWidth, barCenterY)
                divider:SetSize(1, barHeight)
                divider:Show()
            elseif divider then
                divider:Hide()
            end
        end
    end

    -- Bar layout (shifted cyclic timeline):
    -- - autoX (30%) = upcoming Auto Shot moment (timeToSwing == 0)
    -- - Full bar still represents exactly one Auto Shot cycle
    -- - Spark wraps across edges (continues left after fire, then reappears right).

    -- Compute early-gap visibility and segment for marker polish (wind-up hides left marker when early gap visible).
    -- In cyclic mode, early gap starts at swing-start (ttn=swingSpeed -> autoX) and ends at threshold (ttn=steadyCast+0.1).
    -- Use snapshot steadyCast (cast bar only, haste-adjusted) when available; else spell data base. Do NOT add wind-up.
    local steadyKnown = NAG.SpellIsKnown and NAG:SpellIsKnown(STEADY_SHOT_ID) or false
    local forceShowEarlyGap = db.forceShowEarlyGapForTesting and true or false
    local steadyCast = 0
    if NAG and NAG.HunterWeaveSnapshot then
        local snap = NAG:HunterWeaveSnapshot()
        if snap and snap.ok and snap.steadyCast then
            steadyCast = tonumber(snap.steadyCast) or 0
        end
    end
    if steadyCast <= 0 then
        steadyCast = tonumber(NAG.SpellCastTime and NAG:SpellCastTime(STEADY_SHOT_ID) or 0) or 0
    end
    local thresholdSeconds = steadyCast + 0.1
    local segmentLeftXEarly = autoX -- threshold edge in shifted cycle mapping
    if runtimeSwingSpeed > 0 then
        segmentLeftXEarly = autoX + (thresholdSeconds / runtimeSwingSpeed) * segmentWidth
        if segmentLeftXEarly > segmentWidth then
            segmentLeftXEarly = segmentLeftXEarly - segmentWidth
        end
    end
    local earlyGapArcWidth = 0
    if runtimeSwingSpeed > 0 then
        earlyGapArcWidth = segmentWidth * ((runtimeSwingSpeed - thresholdSeconds) / runtimeSwingSpeed)
    end
    local earlyGapPossible = steadyKnown
        and runtimeSwingSpeed > 0
        and thresholdSeconds < runtimeSwingSpeed
        and earlyGapArcWidth > 1
    local earlyGapVisible = forceShowEarlyGap or earlyGapPossible

    if debugSwingBar and db.showDebugSwingBar then
        debugSwingBar:SetPoint("LEFT", frame, "LEFT", 0, barCenterY + (db.debugSwingBarOffsetY or -14))
        debugSwingBar:SetSize(width, db.debugSwingBarHeight or 10)
        debugSwingBar:SetColorTexture(
            db.debugSwingBarColor.r,
            db.debugSwingBarColor.g,
            db.debugSwingBarColor.b,
            db.debugSwingBarColor.a
        )
        debugSwingBar:Show()
        if debugSwingText and db.showDebugSwingText then
            debugSwingText:ClearAllPoints()
            debugSwingText:SetPoint("CENTER", debugSwingBar, "CENTER", 0, 0)
            debugSwingText:SetText(string.format("%.2fs", rawSwingLeft or 0))
            debugSwingText:SetTextColor(
                db.debugSwingTextColor.r,
                db.debugSwingTextColor.g,
                db.debugSwingTextColor.b,
                db.debugSwingTextColor.a
            )
            debugSwingText:Show()
        elseif debugSwingText then
            debugSwingText:Hide()
        end
    else
        if debugSwingBar then debugSwingBar:Hide() end
        if debugSwingText then debugSwingText:Hide() end
    end

    -- Wind-up zone: Auto at autoX; wind-up is [autoX, autoX + zoneWidth].
    -- Gap boundaries are rendered as vertical line markers:
    -- left boundary (orange) and right boundary (dark green).
    local windupRightX = nil
    if windupMarkerLeft and windupMarkerRight and windupHighlight and db.showTargetMarker then
        local windupSeconds = db.targetMarkerSeconds or 0.5
        if NAG and NAG.HunterWeaveSnapshot then
            local snap = NAG:HunterWeaveSnapshot()
            if snap and snap.ok then
                local snapWindup = tonumber(snap.rangedWindupSeconds or 0) or 0
                if snapWindup > 0 then
                    windupSeconds = snapWindup
                end
            end
        end
        local zoneWidth = (runtimeSwingSpeed > 0) and ((windupSeconds / runtimeSwingSpeed) * segmentWidth) or 0
        if zoneWidth < 0 then zoneWidth = 0 end
        if zoneWidth > segmentWidth then zoneWidth = segmentWidth end
        local leftX = autoX
        local rightX = min(segmentWidth, autoX + zoneWidth)
        windupRightX = rightX
        local leftBoundaryX = earlyGapVisible and segmentLeftXEarly or leftX
        local boundaryLineWidth = 2
        local boundaryLineHeight = 15
        local boundaryBgWidth = boundaryLineWidth + 2
        local boundaryBgHeight = boundaryLineHeight + 3

        if windupMarkerLeftBg then
            windupMarkerLeftBg:SetSize(boundaryBgWidth, boundaryBgHeight)
            windupMarkerLeftBg:SetPoint("CENTER", frame, "LEFT", leftBoundaryX, barCenterY)
            windupMarkerLeftBg:Show()
        end
        windupMarkerLeft:SetSize(boundaryLineWidth, boundaryLineHeight)
        windupMarkerLeft:SetPoint("CENTER", frame, "LEFT", leftBoundaryX, barCenterY)
        windupMarkerLeft:Show()

        if windupMarkerRightBg then
            windupMarkerRightBg:SetSize(boundaryBgWidth, boundaryBgHeight)
            windupMarkerRightBg:SetPoint("CENTER", frame, "LEFT", rightX, barCenterY)
            windupMarkerRightBg:Show()
        end
        windupMarkerRight:SetSize(boundaryLineWidth, boundaryLineHeight)
        windupMarkerRight:SetPoint("CENTER", frame, "LEFT", rightX, barCenterY)
        windupMarkerRight:Show()

        windupHighlight:SetColorTexture(0.75, 0.98, 0.75, 0.35)
        windupHighlight:ClearAllPoints()
        windupHighlight:SetPoint("LEFT", frame, "LEFT", leftX, barCenterY)
        windupHighlight:SetSize(math.max(0, rightX - leftX), barHeight)
        windupHighlight:Show()
    else
        if windupMarkerLeftBg then windupMarkerLeftBg:Hide() end
        if windupMarkerRightBg then windupMarkerRightBg:Hide() end
        if windupMarkerLeft then windupMarkerLeft:Hide() end
        if windupMarkerRight then windupMarkerRight:Hide() end
        if windupHighlight then windupHighlight:Hide() end
    end

    -- Early Steady segment (secondary gap): starts at swing-start (autoX) and runs to threshold edge (segmentLeftXEarly).
    -- Draw as a wrapped segment when it crosses the frame edge.
    if earlyGapHighlight then
        if earlyGapVisible then
            earlyGapHighlight:ClearAllPoints()
            if segmentLeftXEarly <= autoX then
                local earlySegmentWidth = autoX - segmentLeftXEarly
                earlyGapHighlight:SetPoint("LEFT", frame, "LEFT", segmentLeftXEarly, barCenterY)
                earlyGapHighlight:SetSize(earlySegmentWidth, barHeight)
                earlyGapHighlight:Show()
                if earlyGapHighlightWrap then
                    earlyGapHighlightWrap:Hide()
                end
            else
                local earlySegmentWidth = segmentWidth - segmentLeftXEarly
                earlyGapHighlight:SetPoint("LEFT", frame, "LEFT", segmentLeftXEarly, barCenterY)
                earlyGapHighlight:SetSize(earlySegmentWidth, barHeight)
                earlyGapHighlight:Show()
                if earlyGapHighlightWrap then
                    earlyGapHighlightWrap:ClearAllPoints()
                    earlyGapHighlightWrap:SetPoint("LEFT", frame, "LEFT", 0, barCenterY)
                    earlyGapHighlightWrap:SetSize(autoX, barHeight)
                    earlyGapHighlightWrap:Show()
                end
            end

            if earlyGapMarkerLeft then earlyGapMarkerLeft:Hide() end
            if earlyGapMarkerRight then earlyGapMarkerRight:Hide() end
        else
            earlyGapHighlight:Hide()
            if earlyGapHighlightWrap then earlyGapHighlightWrap:Hide() end
            if earlyGapMarkerLeft then earlyGapMarkerLeft:Hide() end
            if earlyGapMarkerRight then earlyGapMarkerRight:Hide() end
        end
    end

    -- Label between target markers when early-gap pair is active.
    if steadyShotText and db.showTargetMarker and earlyGapVisible and windupRightX then
        local markerOffsetX = db.targetMarkerOffsetX or 0
        local markerOffsetY = db.targetMarkerOffsetY or 0
        local xA = windupRightX + markerOffsetX
        local xB = segmentLeftXEarly + markerOffsetX
        -- Handle cyclic wrap so "between" remains visually centered on the marker pair.
        if xB < xA then
            xB = xB + segmentWidth
        end
        local midX = (xA + xB) * 0.5
        if midX > segmentWidth then
            midX = midX - segmentWidth
        end
        steadyShotText:ClearAllPoints()
        steadyShotText:SetPoint("CENTER", frame, "LEFT", midX, barCenterY + markerOffsetY)
        steadyShotText:SetText("")--Steady\nShot
        steadyShotText:SetTextColor(0.05, 0.35, 0.05, 0.8)
        steadyShotText:Show()
    elseif steadyShotText then
        steadyShotText:Hide()
    end

    -- SS-gap visibility cutoff:
    -- while in combat, hide spark effects after they pass the active gap start boundary.
    -- If early gap is visible, use early-gap start; otherwise use SS-gap start (autoX).
    local ssGapEndX = nil
    if inCombat then
        if earlyGapVisible then
            ssGapEndX = segmentLeftXEarly
        else
            ssGapEndX = autoX
        end
    end

    -- GCD marker model:
    -- gcdZeroX is fixed at the leftmost segment's Auto Shot anchor.
    -- gcdMovingX starts to the right based on lockout proportion over total timeline time,
    -- then moves left as lockoutRemaining counts down to zero.
    local gcdZeroX = autoX
    if earlyGapVisible then
        -- Anchor GCD zero at the left-most gap boundary when early gap exists.
        if segmentLeftXEarly and segmentLeftXEarly < gcdZeroX then
            gcdZeroX = segmentLeftXEarly
        end
    end
    local totalTimelineSeconds = segmentCount * runtimeSwingSpeed
    local lockoutRatio = 0
    local gcdMovingRawX = nil
    local gcdMovingX = nil
    if lockoutRemaining > 0 and totalTimelineSeconds > 0 then
        lockoutRatio = lockoutRemaining / totalTimelineSeconds
        if lockoutRatio < 0 then
            lockoutRatio = 0
        end
        local rawMovingX = gcdZeroX + (lockoutRatio * width)
        gcdMovingRawX = rawMovingX
        gcdMovingX = rawMovingX
        if gcdMovingX < 0 then
            gcdMovingX = 0
        elseif gcdMovingX > width then
            gcdMovingX = width
        end
    end

    -- Independent GCD/SS-cast moving marker.
    if gcdLandingMarker then
        if gcdMovingX then
            local sparkHeight = math.max(3, math.floor((db.targetMarkerSize or 20) * 0.275))
            local sparkHeightDoubled = sparkHeight * 2
            local sparkTopY = barCenterY + (sparkHeight / 2)
            -- Ret-style spark: simple vertical line (no custom image), aligned with the bar lane.
            gcdLandingMarker:SetSize(2, sparkHeightDoubled)
            gcdLandingMarker:ClearAllPoints()
            gcdLandingMarker:SetPoint("TOP", frame, "LEFT", gcdMovingX, sparkTopY)
            gcdLandingMarker:Show()
            if gcdLandingText then
                gcdLandingText:ClearAllPoints()
                gcdLandingText:SetPoint("TOP", gcdLandingMarker, "BOTTOM", 0, -2)
                gcdLandingText:SetText("GCD")
                gcdLandingText:SetTextColor(0.8, 0.8, 0.8, 0.8)
                gcdLandingText:Show()
            end
        else
            gcdLandingMarker:Hide()
            if gcdLandingText then
                gcdLandingText:Hide()
            end
            if gcdLandingFillerIcon then
                gcdLandingFillerIcon:Hide()
            end
        end
    end

    local remainingWidth = sparkTargetX - autoX
    if remainingWidth < 0 then remainingWidth = 0 end
    local elapsedWidth = segmentWidth - sparkTargetX

    if db.showSwingBars then
        swingBar:ClearAllPoints()
        swingBar:SetPoint("LEFT", frame, "LEFT", autoX, swingCenterY)
        local currentWidth = swingBar:GetWidth()
        if remainingWidth < currentWidth then
            swingBar:SetWidth(currentWidth + (remainingWidth - currentWidth) * 0.3)
        else
            swingBar:SetWidth(remainingWidth)
        end
        swingBar:SetHeight(swingHeight)
        swingBar:Show()

        if pastSwingBar then
            pastSwingBar:ClearAllPoints()
            pastSwingBar:SetPoint("LEFT", frame, "LEFT", sparkTargetX, swingCenterY)
            local pastCurrentWidth = pastSwingBar:GetWidth()
            if elapsedWidth < pastCurrentWidth then
                pastSwingBar:SetWidth(pastCurrentWidth + (elapsedWidth - pastCurrentWidth) * 0.3)
            else
                pastSwingBar:SetWidth(elapsedWidth)
            end
            pastSwingBar:SetHeight(swingHeight)
            pastSwingBar:Show()
        end
    else
        if swingBar then swingBar:Hide() end
        if pastSwingBar then pastSwingBar:Hide() end
    end

    if db.showSwingSpark then
        swingSpark:SetSize(2, swingHeight)
        swingSpark:ClearAllPoints()
        swingSpark:SetPoint("CENTER", frame, "LEFT", sparkTargetX, swingCenterY)
        swingSpark:Show()
    else
        swingSpark:Hide()
    end

    gcdBar:Hide()
    gcdSpark:Hide()
    if gcdSparkLeft then
        gcdSparkLeft:Hide()
    end

    -- Shot spark icons:
    -- Segment sparks represent chained SS/Aimed timing for each visible auto segment.
    -- During lockout, only show sparks that are strictly to the right of the GCD/lockout marker.
    local sparkScale = db.sparkScale or 1.6
    local iconSize = math.floor(DEFAULT_ICON_SIZE * sparkScale * 0.85 * 0.85)
    local sparkOffsetY = (db.sparkOffsetY or 0) + SEGMENT_SPARK_OFFSET_Y

    local steadyIcon = (NAG.Spell and NAG.Spell[STEADY_SHOT_ID] and NAG.Spell[STEADY_SHOT_ID].icon)
        or (GetSpellTexture and GetSpellTexture(STEADY_SHOT_ID))
        or "Interface\\Icons\\INV_Misc_QuestionMark"
    local aimedIcon = (NAG.Spell and NAG.Spell[AIMED_SHOT_ID] and NAG.Spell[AIMED_SHOT_ID].icon)
        or (GetSpellTexture and GetSpellTexture(AIMED_SHOT_ID))
        or "Interface\\Icons\\INV_Misc_QuestionMark"
    local multiIcon = (NAG.Spell and NAG.Spell[MULTI_SHOT_ID] and NAG.Spell[MULTI_SHOT_ID].icon)
        or (GetSpellTexture and GetSpellTexture(MULTI_SHOT_ID))
        or "Interface\\Icons\\INV_Misc_QuestionMark"
    local arcaneIcon = (NAG.Spell and NAG.Spell[ARCANE_SHOT_ID] and NAG.Spell[ARCANE_SHOT_ID].icon)
        or (GetSpellTexture and GetSpellTexture(ARCANE_SHOT_ID))
        or "Interface\\Icons\\INV_Misc_QuestionMark"

    local canShowSteady = NAG.SpellIsKnown and NAG:SpellIsKnown(STEADY_SHOT_ID)
    local canShowAimed = NAG.SpellIsKnown and NAG:SpellIsKnown(AIMED_SHOT_ID)
    local showSteady = isRelevantNext and nextSpellId == STEADY_SHOT_ID and canShowSteady
    local showAimed = isRelevantNext and IsAimedShotSpellId(nextSpellId) and canShowAimed
    local fillerSpeedOk = runtimeSwingSpeed > FILLER_MIN_SWING_SECONDS
    local showMulti = fillerSpeedOk and IsMultiShotSpellId(nextSpellId) and (NAG.SpellIsKnown and NAG:SpellIsKnown(MULTI_SHOT_ID))
    local showArcane = fillerSpeedOk and IsArcaneShotSpellId(nextSpellId) and (NAG.SpellIsKnown and NAG:SpellIsKnown(ARCANE_SHOT_ID))

    local baseSegmentSparkIcon = nil
    local showSegmentSparks = false
    local fillerIconTexture = nil

    if db.showSteadySpark then
        if canShowSteady then
            baseSegmentSparkIcon = steadyIcon
        elseif canShowAimed then
            baseSegmentSparkIcon = aimedIcon
        end
    else
        if showSteady then
            baseSegmentSparkIcon = steadyIcon
        elseif showAimed then
            baseSegmentSparkIcon = aimedIcon
        elseif showMulti then
            fillerIconTexture = multiIcon
        elseif showArcane then
            fillerIconTexture = arcaneIcon
        end
        -- Keep SS/Aimed flow visible even when filler is the current primary recommendation.
        if not baseSegmentSparkIcon then
            if canShowSteady then
                baseSegmentSparkIcon = steadyIcon
            elseif canShowAimed then
                baseSegmentSparkIcon = aimedIcon
            end
        end
    end
    showSegmentSparks = inCombat and (baseSegmentSparkIcon ~= nil)
    local gcdMinSpacingPx = 0
    if runtimeSwingSpeed > 0 then
        gcdMinSpacingPx = effectiveGCD * (segmentWidth / runtimeSwingSpeed)
    end

    local nearestVisibleSegmentIndex = nil
    local nearestVisibleTargetX = nil
    if frame.segmentSparks then
        for i = 1, #frame.segmentSparks do
            if i <= segmentCount then
                local targetX = ((i - 1) * segmentWidth) + (cyclePhase * segmentWidth)
                local rightOfGcd = (not gcdMovingX) or (targetX >= gcdMovingX)
                local rightOfSsGapEnd = (not ssGapEndX) or (targetX >= ssGapEndX)
                local canShowAtPosition = rightOfGcd and rightOfSsGapEnd
                if showSegmentSparks and canShowAtPosition then
                    if not nearestVisibleTargetX or targetX < nearestVisibleTargetX then
                        nearestVisibleTargetX = targetX
                        nearestVisibleSegmentIndex = i
                    end
                end
            end
        end
    end

    local ssShiftApplied = false
    local ssShiftIndex = nil
    local ssShiftFromX = nil
    local ssShiftToX = nil
    if fillerIconTexture and gcdMovingX and nearestVisibleSegmentIndex and nearestVisibleTargetX then
        local minSsX = gcdMovingX + gcdMinSpacingPx
        if nearestVisibleTargetX < minSsX then
            ssShiftApplied = true
            ssShiftIndex = nearestVisibleSegmentIndex
            ssShiftFromX = nearestVisibleTargetX
            ssShiftToX = minSsX
        end
    end

    -- Segment debug prints: when Dev Mode is on and in combat. No bar option needed; use /naghuntersteady and "Show Segment Debug Logs" to turn off.
    if inCombat and self.Print and IsDevModeEnabled() then
        local now = GetTime()
        if not self._lastSegmentDebugLogAt or (now - self._lastSegmentDebugLogAt) >= SEGMENT_DEBUG_PRINT_INTERVAL then
            self._lastSegmentDebugLogAt = now

            local hiddenSegments = {}
            local visibleSegments = {}
            for c = 0, (segmentCount - 1) do
                local sparkX = (c * segmentWidth) + (cyclePhase * segmentWidth)
                local rightOfGcd = (not gcdMovingX) or (sparkX >= gcdMovingX)
                local rightOfSsGapEnd = (not ssGapEndX) or (sparkX >= ssGapEndX)
                local isVisible = showSegmentSparks and rightOfGcd and rightOfSsGapEnd
                if isVisible then
                    visibleSegments[#visibleSegments + 1] = tostring(c)
                else
                    hiddenSegments[#hiddenSegments + 1] = tostring(c)
                end
            end

            local iconLabel = "none"
            if baseSegmentSparkIcon == steadyIcon then
                iconLabel = "steady"
            elseif baseSegmentSparkIcon == aimedIcon then
                iconLabel = "aimed"
            end
            if fillerIconTexture then
                iconLabel = iconLabel .. "+filler"
            end

            local hiddenLabel = (#hiddenSegments > 0) and table.concat(hiddenSegments, ",") or "-"
            local visibleLabel = (#visibleSegments > 0) and table.concat(visibleSegments, ",") or "-"
            local gcdMovingLabel = gcdMovingX and string.format("%.1f", gcdMovingX) or "-"
            local ssGapEndLabel = ssGapEndX and string.format("%.1f", ssGapEndX) or "-"
            local visibilityRule = "sparkX>=gcdX && sparkX>=gapEndX"
            local gcdFlat = (NAG and NAG.GCDTimeValue and NAG:GCDTimeValue()) or DEFAULT_EFFECTIVE_GCD
            local rawGcdXStr = (gcdMovingRawX ~= nil) and string.format("%.1f", gcdMovingRawX) or "-"
            local gcdZeroLabel = string.format("%.1f", gcdZeroX)
            local totalTimelineLabel = string.format("%.2f", totalTimelineSeconds)
            local lockoutRatioLabel = string.format("%.3f", lockoutRatio)
            local gcdMinSpacingLabel = string.format("%.1f", gcdMinSpacingPx)
            local nearestIdxLabel = nearestVisibleSegmentIndex and tostring(nearestVisibleSegmentIndex - 1) or "-"
            local ssShiftLabel = ssShiftApplied and "1" or "0"
            local ssShiftIdxLabel = ssShiftIndex and tostring(ssShiftIndex - 1) or "-"
            local ssShiftFromLabel = ssShiftFromX and string.format("%.1f", ssShiftFromX) or "-"
            local ssShiftToLabel = ssShiftToX and string.format("%.1f", ssShiftToX) or "-"

            -- self:Print(string.format(
            --     "SteadyBar dbg seg=%d w=%.0f segW=%.1f rule=%s shown=[%s] hidden=[%s] icon=%s speed=%.2f gcdFlat=%.2f gcdRem=%.2f ssCastRem=%.2f lockout=%.2f lockoutRatio=%s totalSec=%s ttn=%.2f phase=%.3f sparkX=%.1f autoX=%.1f gapEndX=%s gcdZeroX=%s gcdMoveX=%s rawGcdX=%s gcdMinPx=%s nearestSS=%s ssShift=%s ssShiftIdx=%s ssFrom=%s ssTo=%s",
            --     segmentCount,
            --     width,
            --     segmentWidth,
            --     visibilityRule,
            --     visibleLabel,
            --     hiddenLabel,
            --     iconLabel,
            --     runtimeSwingSpeed,
            --     gcdFlat,
            --     gcdRemaining,
            --     ssCastRemaining,
            --     lockoutRemaining,
            --     lockoutRatioLabel,
            --     totalTimelineLabel,
            --     timeToSwing,
            --     cyclePhase,
            --     sparkTargetX,
            --     autoX,
            --     ssGapEndLabel,
            --     gcdZeroLabel,
            --     gcdMovingLabel,
            --     rawGcdXStr,
            --     gcdMinSpacingLabel,
            --     nearestIdxLabel,
            --     ssShiftLabel,
            --     ssShiftIdxLabel,
            --     ssShiftFromLabel,
            --     ssShiftToLabel
            -- ))
        end
    end

    if frame.sparks then
        for i = 1, #frame.sparks do
            if frame.sparks[i] then
                frame.sparks[i]:Hide()
            end
        end
    end

    if frame.segmentSparks then
        for i = 1, #frame.segmentSparks do
            local sparkFrame = frame.segmentSparks[i]
            if sparkFrame and i <= segmentCount then
                local targetX = ((i - 1) * segmentWidth) + (cyclePhase * segmentWidth)
                local rightOfGcd = (not gcdMovingX) or (targetX >= gcdMovingX)
                local rightOfSsGapEnd = (not ssGapEndX) or (targetX >= ssGapEndX)
                local canShowAtPosition = rightOfGcd and rightOfSsGapEnd
                local showLeftOfGcdDebug = showSegmentSparks and rightOfSsGapEnd and (not rightOfGcd) and IsDevModeEnabled()
                if showSegmentSparks and (canShowAtPosition or showLeftOfGcdDebug) then
                    local renderX = targetX
                    if ssShiftApplied and ssShiftIndex == i and ssShiftToX then
                        renderX = ssShiftToX
                    end
                    if renderX <= width then
                        if not sparkFrame.currentX or renderX >= sparkFrame.currentX then
                            sparkFrame.currentX = renderX
                        else
                            sparkFrame.currentX = sparkFrame.currentX + (renderX - sparkFrame.currentX) * (db.sparkSmoothing or 0.3)
                        end
                        local renderedRightOfGcd = (not gcdMovingX) or (sparkFrame.currentX >= (gcdMovingX - 0.5))
                        showLeftOfGcdDebug = showSegmentSparks and rightOfSsGapEnd and (not renderedRightOfGcd) and IsDevModeEnabled()
                        sparkFrame.icon:SetTexture(baseSegmentSparkIcon)
                        sparkFrame.icon:SetDesaturated(showLeftOfGcdDebug)
                        sparkFrame.icon:SetAlpha(showLeftOfGcdDebug and LEFT_OF_GCD_SPARK_ALPHA or 1.0)
                        sparkFrame:SetSize(iconSize, iconSize)
                        local effectiveRemaining = nil
                        if not showLeftOfGcdDebug then
                            local gapReferenceX = windupRightX or ssGapEndX or autoX
                            local pixelDistanceToGap = renderX - gapReferenceX
                            local timeRemainingToGap = 0
                            if runtimeSwingSpeed > 0 and segmentWidth > 0 and pixelDistanceToGap > 0 then
                                timeRemainingToGap = (pixelDistanceToGap / segmentWidth) * runtimeSwingSpeed
                            end
                            effectiveRemaining = timeRemainingToGap - gcdRemaining
                            if effectiveRemaining < 0 then
                                effectiveRemaining = 0
                            end
                        end
                        if sparkFrame.bg then
                            if showLeftOfGcdDebug then
                                sparkFrame.bg:SetVertexColor(0.78, 0.78, 0.78, 1.0)
                                sparkFrame.bg:SetAlpha(LEFT_OF_GCD_SPARK_ALPHA)
                            else
                                local bgR, bgG, bgB, bgA = GetSparkBackgroundTint(effectiveRemaining)
                                sparkFrame.bg:SetVertexColor(bgR, bgG, bgB, bgA)
                                sparkFrame.bg:SetAlpha(0.95)
                            end
                            sparkFrame.bg:SetSize(iconSize + 21, iconSize + 21)
                            sparkFrame.bg:Show()
                        end
                        if sparkFrame.spamText then
                            local timeDistToGcd = 0
                            if (not showLeftOfGcdDebug) and gcdMovingX and segmentWidth > 0 and runtimeSwingSpeed > 0 and renderX > gcdMovingX then
                                timeDistToGcd = ((renderX - gcdMovingX) / segmentWidth) * runtimeSwingSpeed
                            end
                            if (not showLeftOfGcdDebug) and gcdRemaining > 0 and timeDistToGcd > 0 and timeDistToGcd < 0.5 then
                                sparkFrame.spamText:SetText("SPAM")
                                sparkFrame.spamText:Show()
                            else
                                sparkFrame.spamText:Hide()
                            end
                        end
                        sparkFrame:ClearAllPoints()
                        sparkFrame:SetPoint("CENTER", frame, "LEFT", sparkFrame.currentX, swingCenterY + sparkOffsetY)
                        sparkFrame:Show()
                    else
                        sparkFrame.icon:SetDesaturated(false)
                        sparkFrame.icon:SetAlpha(1.0)
                        if sparkFrame.spamText then
                            sparkFrame.spamText:Hide()
                        end
                        if sparkFrame.bg then
                            sparkFrame.bg:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                            sparkFrame.bg:SetAlpha(0.95)
                            sparkFrame.bg:Hide()
                        end
                        sparkFrame:Hide()
                    end
                else
                    sparkFrame.icon:SetDesaturated(false)
                    sparkFrame.icon:SetAlpha(1.0)
                    if sparkFrame.spamText then
                        sparkFrame.spamText:Hide()
                    end
                    if sparkFrame.bg then
                        sparkFrame.bg:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                        sparkFrame.bg:SetAlpha(0.95)
                        sparkFrame.bg:Hide()
                    end
                    sparkFrame:Hide()
                end
            elseif sparkFrame then
                sparkFrame.icon:SetDesaturated(false)
                sparkFrame.icon:SetAlpha(1.0)
                if sparkFrame.spamText then
                    sparkFrame.spamText:Hide()
                end
                if sparkFrame.bg then
                    sparkFrame.bg:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                    sparkFrame.bg:SetAlpha(0.95)
                    sparkFrame.bg:Hide()
                end
                sparkFrame:Hide()
            end
        end
    end

    -- Filler target icon:
    -- gray 60% round icon at fixed GCD zero anchor when MS/AR is active.
    if gcdLandingFillerIcon then
        if inCombat and fillerIconTexture then
            gcdLandingFillerIcon.icon:SetTexture(fillerIconTexture)
            gcdLandingFillerIcon.icon:SetDesaturated(false)
            gcdLandingFillerIcon.icon:SetAlpha(0.6)
            gcdLandingFillerIcon:SetSize(iconSize, iconSize)
            gcdLandingFillerIcon:ClearAllPoints()
            gcdLandingFillerIcon:SetPoint("CENTER", frame, "LEFT", gcdZeroX, barCenterY)
            gcdLandingFillerIcon:Show()
        else
            gcdLandingFillerIcon:Hide()
        end
    end

    -- Colored moving filler icon: tracks moving GCD marker while filler recommendation is active.
    if gcdMovingFillerIcon then
        local movingFillerAllowedByGap = (not ssGapEndX) or (gcdMovingX and gcdMovingX >= ssGapEndX)
        if inCombat and fillerIconTexture and gcdMovingX and movingFillerAllowedByGap then
            gcdMovingFillerIcon.icon:SetTexture(fillerIconTexture)
            gcdMovingFillerIcon.icon:SetDesaturated(false)
            gcdMovingFillerIcon.icon:SetAlpha(1.0)
            gcdMovingFillerIcon:SetSize(iconSize, iconSize)
            if gcdMovingFillerIcon.bg then
                gcdMovingFillerIcon.bg:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                gcdMovingFillerIcon.bg:SetSize(iconSize + 21, iconSize + 21)
                gcdMovingFillerIcon.bg:Show()
            end
            gcdMovingFillerIcon:ClearAllPoints()
            gcdMovingFillerIcon:SetPoint("CENTER", frame, "LEFT", gcdMovingX, swingCenterY + sparkOffsetY)
            gcdMovingFillerIcon:Show()
        else
            if gcdMovingFillerIcon.bg then
                gcdMovingFillerIcon.bg:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                gcdMovingFillerIcon.bg:Hide()
            end
            gcdMovingFillerIcon:Hide()
        end
    end

end

-- ============================ OPTIONS REGISTRATION ============================
function module:RegisterSteadyOptions()
    if self._steadyOptionsRegistered then
        return
    end
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end
    if not AceConfig or not AceConfigDialog then
        return
    end
    local options = self:GetOptions()
    if options and type(options) == "table" then
        AceConfig:RegisterOptionsTable(STEADY_OPTIONS_NAME, options)
        AceConfigDialog:SetDefaultSize(STEADY_OPTIONS_NAME, 720, 780)
        self._steadyOptionsRegistered = true
    end
end

function module:ToggleSteadyOptions()
    if not AceConfigDialog then
        return
    end
    -- Open NAG options at class > Hunter weave > HunterSteadyWeaveBar
    AceConfigDialog:Open("NAG", nil, "class", "HunterWeave", "HunterSteadyWeaveBar")
end

function module:HandleSteadySlashCommand()
    self:ToggleSteadyOptions()
end

--- Receive a debug snapshot produced by HunterStateTimelineDebug and drive snapshot-mode rendering.
--- @param snapshotAt number
--- @param segments table
--- @param horizonSeconds number|nil
--- @param autoshotMoments table|nil
--- @param options table|nil
function module:SetDebugSnapshot(snapshotAt, segments, horizonSeconds, autoshotMoments, options)
    self.state = self.state or {}

    if type(segments) ~= "table" or #segments == 0 then
        self.state.debugSnapshot = nil
        self.state.lastSnapshotSetAt = nil
        CancelFillerBackups()
        if frame then
            HideSnapshotVisualPools(self)
            self:UpdateVisibility()
        end
        return
    end

    local normalizedSegments = {}
    local maxTime = 0
    for i = 1, #segments do
        local segment = segments[i]
        local actionName = tostring(segment and segment[1] or "")
        local t1 = tonumber(segment and segment[2] or 0) or 0
        local t2 = tonumber(segment and segment[3] or 0) or 0
        if t1 < 0 then
            t1 = 0
        end
        if t2 < 0 then
            t2 = 0
        end
        if actionName ~= "" then
            normalizedSegments[#normalizedSegments + 1] = { actionName, t1, t2 }
            maxTime = max(maxTime, t1, t2)
        end
    end

    if #normalizedSegments == 0 then
        self.state.debugSnapshot = nil
        self.state.lastSnapshotSetAt = nil
        CancelFillerBackups()
        if frame then
            HideSnapshotVisualPools(self)
            self:UpdateVisibility()
        end
        return
    end

    local normalizedHorizon = tonumber(horizonSeconds or 0) or 0
    local normalizedAutoshotMoments = nil
    if type(autoshotMoments) == "table" then
        normalizedAutoshotMoments = {}
        local dedup = {}
        for i = 1, #autoshotMoments do
            local fromNow = tonumber(autoshotMoments[i] or 0) or 0
            if fromNow >= 0 then
                local key = string.format("%.3f", fromNow)
                if not dedup[key] then
                    dedup[key] = true
                    normalizedAutoshotMoments[#normalizedAutoshotMoments + 1] = fromNow
                    maxTime = max(maxTime, fromNow)
                end
            end
        end
        table.sort(normalizedAutoshotMoments)
        if #normalizedAutoshotMoments == 0 then
            normalizedAutoshotMoments = nil
        end
    end
    if normalizedHorizon <= 0 then
        normalizedHorizon = max(DEFAULT_SNAPSHOT_HORIZON_SECONDS, maxTime + 0.75)
    end
    if normalizedHorizon < 3.0 then
        normalizedHorizon = 3.0
    elseif normalizedHorizon > 30.0 then
        normalizedHorizon = 30.0
    end

    self.state.debugSnapshot = {
        snapshotAt = tonumber(snapshotAt or GetTime()) or GetTime(),
        segments = normalizedSegments,
        autoshotMoments = normalizedAutoshotMoments,
        horizonSeconds = normalizedHorizon,
        idleAtWindup = options and options.idleAtWindup == true or false,
        windupSeconds = tonumber(options and options.windupSeconds or 0) or 0,
        rangedSpeed = tonumber(options and options.rangedSpeed or 0) or 0,
    }
    self.state.autoshotsSinceSnapshot = 0
    self.state.lastSnapshotSetAt = GetTime()

    -- Schedule backup compute for each filler (MS/AR) gap. When we were supposed to cast but didn't, backup refreshes.
    -- Covers all gaps: MS-only, AR-only, MS+AR in same state, fillers in slot1 or slot2.
    ScheduleFillerBackups(self, normalizedSegments)

    if frame then
        self:UpdateVisibility()
        self:UpdateDisplay()
    end
end

-- ============================ UI BUILD ============================
function module:CreateFrameUI()
    if frame then return end

    OptionsFactory = NAG:GetModule("OptionsFactory")
    local db = self.db.class

    frame = CreateFrame("Frame", "NAGHunterSteadyWeaveBar", _G.UIParent)
    frame:SetSize(db.width, (db.height + 5) + 6 + 5)
    frame:SetPoint(db.point, db.x, db.y)
    frame:SetAlpha(db.alpha or 1.0)
    frame:Show()
    frame:RegisterForDrag("LeftButton")
    self:UpdateFrameInteraction()
    frame:SetScript("OnDragStart", function()
        if not (db.draggable == true) then
            return
        end
        frame:StartMoving()
    end)
    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
        if anchor and anchor ~= _G.UIParent and db.autoAnchor and db.lockToNagAnchor then
            -- Stay on UIParent; position relative to anchor so bar stays attached without affecting main frame (floating selector)
            local barCenterX, barCenterY = frame:GetCenter()
            local barTop = frame:GetTop()
            local anchorCenterX, anchorCenterY = anchor:GetCenter()
            local anchorBottom = anchor:GetBottom()
            if barCenterX and barTop and anchorCenterX and anchorBottom then
                local offsetX = barCenterX - anchorCenterX
                local offsetY = barTop - anchorBottom
                frame:SetParent(_G.UIParent)
                frame:ClearAllPoints()
                frame:SetPoint("TOP", anchor, "BOTTOM", offsetX, offsetY)
                db.point = "TOP"
                db.x = offsetX
                db.y = offsetY
            end
        else
            -- Manual or no anchor: save in UIParent space
            local left, bottom = frame:GetLeft(), frame:GetBottom()
            if left and bottom then
                frame:SetParent(_G.UIParent)
                frame:ClearAllPoints()
                frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
            end
            local point, _, _, x, y = frame:GetPoint(1)
            db.point = point
            db.x = x
            db.y = y
        end
    end)

    bgArt = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bgArt:SetPoint("CENTER", frame, "CENTER")
    bgArt:SetTexture(BG_ART_TEXTURE)

    background = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
    background:SetColorTexture(db.backgroundColor.r, db.backgroundColor.g, db.backgroundColor.b, db.backgroundColor.a)

    timelineBar = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    timelineBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    timelineBar:SetSize(frame:GetWidth(), frame:GetHeight())

    greenCircle = frame:CreateTexture(nil, "OVERLAY", nil, 0)
    greenCircle:SetPoint("LEFT", frame, "LEFT", 0, 0)
    greenCircle:SetSize(db.greenCircleSize or 20, db.greenCircleSize or 20)
    local c = db.greenCircleColor or defaults.class.greenCircleColor
    local a = tonumber(db.greenCircleAlpha or c.a or 0.9) or 0.9
    greenCircle:SetTexture(ZERO_MARKER_TEXTURE)
    greenCircle:SetTexCoord(0, 1, 0, 1)
    greenCircle:SetVertexColor(1, 1, 1, 1)
    greenCircle:SetAlpha(a)
    frame.snapshotActionSparks = {}
    frame.snapshotHoldBars = {}
    frame.snapshotAutoshotTicks = {}
    if true then
        return
    end

    nowMarker = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    nowMarker:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    nowMarker:SetWidth(2)
    nowMarker:SetColorTexture(0, 0, 0, 0.7)

    nowMarkerInner = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    nowMarkerInner:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    nowMarkerInner:SetWidth(1)
    nowMarkerInner:SetColorTexture(1, 1, 1, 0.6)

    debugSwingBar = frame:CreateTexture(nil, "ARTWORK", nil, -4)
    debugSwingBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    debugSwingBar:SetSize(frame:GetWidth(), db.debugSwingBarHeight or 10)
    debugSwingBar:SetColorTexture(
        db.debugSwingBarColor.r,
        db.debugSwingBarColor.g,
        db.debugSwingBarColor.b,
        db.debugSwingBarColor.a
    )
    debugSwingBar:Hide()

    debugSwingText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    debugSwingText:SetJustifyH("CENTER")
    debugSwingText:SetJustifyV("MIDDLE")
    debugSwingText:SetText("")
    local debugFontPath, debugFontSize, debugFontFlags = debugSwingText:GetFont()
    if debugFontPath and debugFontSize then
        debugSwingText:SetFont(debugFontPath, db.debugSwingFontSize or debugFontSize, debugFontFlags)
    end
    debugSwingText:Hide()

    windupHighlight = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    windupHighlight:SetColorTexture(
        db.windupHighlightColor.r,
        db.windupHighlightColor.g,
        db.windupHighlightColor.b,
        db.windupHighlightColor.a
    )
    windupHighlight:Hide()

    earlyGapHighlight = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    earlyGapHighlight:SetColorTexture(0.35, 0.75, 1.00, 0.28)
    earlyGapHighlight:Hide()

    earlyGapHighlightWrap = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    earlyGapHighlightWrap:SetColorTexture(0.35, 0.75, 1.00, 0.28)
    earlyGapHighlightWrap:Hide()

    earlyGapMarkerLeft = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    earlyGapMarkerLeft:SetColorTexture(0.05, 0.35, 0.05, 0.95)
    earlyGapMarkerLeft:SetSize(20, db.targetMarkerSize or 20)
    earlyGapMarkerLeft:Hide()

    earlyGapMarkerRight = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    earlyGapMarkerRight:SetColorTexture(0.55, 0.9, 0.55, 0.95)
    earlyGapMarkerRight:SetSize(db.targetMarkerSize or 20, db.targetMarkerSize or 20)
    earlyGapMarkerRight:Hide()

    gcdLandingMarker = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    gcdLandingMarker:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    gcdLandingMarker:SetSize(2, 8)
    gcdLandingMarker:Hide()

    gcdLandingText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    gcdLandingText:SetJustifyH("CENTER")
    gcdLandingText:SetJustifyV("TOP")
    gcdLandingText:SetText("")
    local gcdFontPath, gcdFontSize, gcdFontFlags = gcdLandingText:GetFont()
    if gcdFontPath and gcdFontSize then
        gcdLandingText:SetFont(gcdFontPath, math.max(6, math.floor(gcdFontSize * 0.7)), gcdFontFlags)
    end
    gcdLandingText:Hide()

    gcdLandingFillerIcon = CreateFrame("Frame", nil, frame)
    gcdLandingFillerIcon:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
    gcdLandingFillerIcon.icon = gcdLandingFillerIcon:CreateTexture(nil, "OVERLAY", nil, 7)
    gcdLandingFillerIcon.icon:SetAllPoints()
    gcdLandingFillerIcon.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    gcdLandingFillerIcon.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    gcdLandingFillerIcon.icon:SetDesaturated(false)
    gcdLandingFillerIcon.icon:SetAlpha(0.6)
    local gcdFillerMask = gcdLandingFillerIcon:CreateMaskTexture()
    gcdFillerMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    gcdFillerMask:SetAllPoints()
    gcdLandingFillerIcon.icon:AddMaskTexture(gcdFillerMask)
    local gcdFillerKeybindText = gcdLandingFillerIcon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    gcdFillerKeybindText:SetPoint("BOTTOM", gcdLandingFillerIcon, "TOP", 0, 2)
    gcdFillerKeybindText:SetJustifyH("CENTER")
    gcdFillerKeybindText:SetTextColor(1, 1, 0)
    gcdFillerKeybindText:SetText("")
    gcdFillerKeybindText:Hide()
    gcdLandingFillerIcon.keybindText = gcdFillerKeybindText
    gcdLandingFillerIcon:Hide()

    gcdMovingFillerIcon = CreateFrame("Frame", nil, frame)
    gcdMovingFillerIcon:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
    gcdMovingFillerIcon.bg = gcdMovingFillerIcon:CreateTexture(nil, "BACKGROUND", nil, -8)
    gcdMovingFillerIcon.bg:SetTexture(SEGMENT_SPARK_BG_PATH)
    gcdMovingFillerIcon.bg:SetPoint("CENTER", gcdMovingFillerIcon, "CENTER", 0, 0)
    gcdMovingFillerIcon.bg:SetSize(37, 37)
    gcdMovingFillerIcon.bg:SetAlpha(0.95)
    gcdMovingFillerIcon.icon = gcdMovingFillerIcon:CreateTexture(nil, "OVERLAY", nil, 7)
    gcdMovingFillerIcon.icon:SetAllPoints()
    gcdMovingFillerIcon.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    gcdMovingFillerIcon.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    gcdMovingFillerIcon.icon:SetDesaturated(false)
    gcdMovingFillerIcon.icon:SetAlpha(1.0)
    local gcdMovingMask = gcdMovingFillerIcon:CreateMaskTexture()
    gcdMovingMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    gcdMovingMask:SetAllPoints()
    gcdMovingFillerIcon.icon:AddMaskTexture(gcdMovingMask)
    gcdMovingFillerIcon:Hide()

    steadyShotText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    steadyShotText:SetJustifyH("CENTER")
    steadyShotText:SetJustifyV("MIDDLE")
    steadyShotText:SetText("")
    local steadyFontPath, steadyFontSize, steadyFontFlags = steadyShotText:GetFont()
    if steadyFontPath and steadyFontSize then
        steadyShotText:SetFont(steadyFontPath, math.max(6, math.floor(steadyFontSize * 0.8)), steadyFontFlags)
    end
    steadyShotText:SetTextColor(0.05, 0.35, 0.05, 0.8)
    steadyShotText:Hide()

    windupMarkerLeftBg = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    windupMarkerLeftBg:SetColorTexture(0, 0, 0, 0.95)
    windupMarkerLeftBg:Hide()

    windupMarkerRightBg = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    windupMarkerRightBg:SetColorTexture(0, 0, 0, 0.95)
    windupMarkerRightBg:Hide()

    windupMarkerLeft = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    windupMarkerLeft:SetColorTexture(0.05, 0.35, 0.05, 0.95)
    windupMarkerLeft:SetSize(db.targetMarkerSize or 20, db.targetMarkerSize or 20)
    windupMarkerLeft:Hide()

    windupMarkerRight = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    windupMarkerRight:SetColorTexture(0.55, 0.9, 0.55, 0.95)
    windupMarkerRight:SetSize(db.targetMarkerSize or 20, db.targetMarkerSize or 20)
    windupMarkerRight:Hide()

    swingBar = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    swingBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    swingBar:SetWidth(0)
    swingBar:SetColorTexture(db.swingColor.r, db.swingColor.g, db.swingColor.b, db.swingColor.a)

    pastSwingBar = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    pastSwingBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    pastSwingBar:SetWidth(0)
    pastSwingBar:SetColorTexture(db.swingColor.r, db.swingColor.g, db.swingColor.b, db.swingColor.a)

    gcdBar = frame:CreateTexture(nil, "ARTWORK", nil, 6)
    gcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    gcdBar:SetWidth(0)
    gcdBar:SetColorTexture(db.gcdColor.r, db.gcdColor.g, db.gcdColor.b, db.gcdColor.a)
    gcdBar:Hide()

    swingSpark = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    swingSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    swingSpark:Hide()

    gcdSpark = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    gcdSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    gcdSpark:Hide()

    gcdSparkLeft = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    gcdSparkLeft:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    gcdSparkLeft:Hide()

    frame.sparks = frame.sparks or {}
    for i = 1, MAX_SWING_SPARKS do
        local sparkFrame = frame.sparks[i]
        if not sparkFrame then
            sparkFrame = CreateFrame("Frame", nil, frame)
            sparkFrame:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
            sparkFrame.icon = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 7)
            sparkFrame.icon:SetAllPoints()
            sparkFrame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            sparkFrame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            local mask = sparkFrame:CreateMaskTexture()
            mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
                "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints()
            sparkFrame.icon:AddMaskTexture(mask)
            sparkFrame.icon:Show()
            local keybindText = sparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            keybindText:SetPoint("BOTTOM", sparkFrame, "TOP", 0, 2)
            keybindText:SetJustifyH("CENTER")
            keybindText:SetTextColor(1, 1, 0)
            keybindText:SetText("")
            keybindText:Hide()
            sparkFrame.keybindText = keybindText
            sparkFrame:Hide()
            frame.sparks[i] = sparkFrame
        end
    end

    frame.segmentSparks = frame.segmentSparks or {}
    for i = 1, MAX_DYNAMIC_SEGMENTS do
        local sparkFrame = frame.segmentSparks[i]
        if not sparkFrame then
            sparkFrame = CreateFrame("Frame", nil, frame)
            sparkFrame:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
            sparkFrame.bg = sparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
            sparkFrame.bg:SetTexture(SEGMENT_SPARK_BG_PATH)
            sparkFrame.bg:SetPoint("CENTER", sparkFrame, "CENTER", 0, 0)
            sparkFrame.bg:SetSize(37, 37)
            sparkFrame.bg:SetAlpha(0.95)
            sparkFrame.icon = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 7)
            sparkFrame.icon:SetAllPoints()
            sparkFrame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            sparkFrame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            local mask = sparkFrame:CreateMaskTexture()
            mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
                "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints()
            sparkFrame.icon:AddMaskTexture(mask)
            sparkFrame.icon:Show()
            local spamText = sparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            spamText:SetPoint("BOTTOM", sparkFrame, "TOP", 0, 4)
            spamText:SetJustifyH("CENTER")
            spamText:SetTextColor(1, 1, 1, 0.8)
            spamText:SetText("SPAM")
            spamText:Hide()
            sparkFrame.spamText = spamText
            sparkFrame:Hide()
            frame.segmentSparks[i] = sparkFrame
        end
        if sparkFrame and not sparkFrame.bg then
            sparkFrame.bg = sparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
            sparkFrame.bg:SetTexture(SEGMENT_SPARK_BG_PATH)
            sparkFrame.bg:SetPoint("CENTER", sparkFrame, "CENTER", 0, 0)
            sparkFrame.bg:SetSize(37, 37)
            sparkFrame.bg:SetAlpha(0.95)
        end
        if sparkFrame and not sparkFrame.spamText then
            local spamText = sparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            spamText:SetPoint("BOTTOM", sparkFrame, "TOP", 0, 4)
            spamText:SetJustifyH("CENTER")
            spamText:SetTextColor(1, 1, 1, 0.8)
            spamText:SetText("SPAM")
            spamText:Hide()
            sparkFrame.spamText = spamText
        end
    end

    segmentDividerLines = segmentDividerLines or {}
    for i = 1, (MAX_DYNAMIC_SEGMENTS - 1) do
        local divider = segmentDividerLines[i]
        if not divider then
            divider = frame:CreateTexture(nil, "ARTWORK", nil, 3)
            divider:SetColorTexture(0.8, 0.8, 0.8, 0.25)
            divider:Hide()
            segmentDividerLines[i] = divider
        end
    end
end

-- ============================ LIFECYCLE ============================
--- Register autoshot swing callback used by snapshot elapsed tracking.
function module:RegisterAutoshotSwingCallback()
    self.state = self.state or {}
    if self.state.autoshotSwingCallbackRegistered == true then
        return
    end
    if not (swingTimerLib and swingTimerLib.RegisterCallback) then
        return
    end
    swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_START", "HandleAutoshotSwingStart")
    self.state.autoshotSwingCallbackRegistered = true
end

--- Unregister autoshot swing callback.
function module:UnregisterAutoshotSwingCallback()
    if not (self.state and self.state.autoshotSwingCallbackRegistered == true) then
        return
    end
    if swingTimerLib and swingTimerLib.UnregisterCallback then
        swingTimerLib.UnregisterCallback(self, "UNIT_SWING_TIMER_START")
    end
    self.state.autoshotSwingCallbackRegistered = false
end

--- Get current ranged weapon speed for UNIT_AURA speed-change detection.
--- @return number speed seconds, or 0 if unavailable
local function GetCurrentRangedSpeed()
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        local speed = select(1, swingTimerLib:UnitSwingTimerInfo("player", "ranged"))
        if speed and speed > 0 then
            return speed
        end
    end
    if UnitRangedDamage then
        local speed = select(1, UnitRangedDamage("player"))
        return tonumber(speed or 0) or 0
    end
    return 0
end

--- Run prediction compute and update lastComputationAt, lastKnownRangedSpeed.
--- All triggers funnel through this.
--- @param triggerSource string|nil Source that triggered the compute (e.g. "periodic", "autoshot", "spell_sent_ms").
function module:DoPredictionCompute(triggerSource)
    local db = self.db and self.db.class
    if not db or db.useDebugSnapshotWhenAvailable ~= true then
        return
    end
    if frame and frame.snapshotMsSsgapGhostSparks then
        for i = 1, #frame.snapshotMsSsgapGhostSparks do
            local g = frame.snapshotMsSsgapGhostSparks[i]
            if g then
                g:Hide()
            end
        end
    end
    local stateDebug = NAG:GetModule("HunterStateTimelineDebug", true)
    if stateDebug and stateDebug.RefreshBarSnapshot then
        stateDebug:RefreshBarSnapshot(nil, triggerSource or "unknown")
    end
    self.state = self.state or {}
    self.state.lastComputationAt = GetTime()
    local speed = GetCurrentRangedSpeed()
    if speed > 0 then
        lastKnownRangedSwingSpeed = speed
    end
end

--- Schedule a delayed compute; cancels any pending one.
--- @param delayMs number
--- @param triggerSource string|nil Source that triggered (e.g. "autoshot", "spell_start_ss").
local function ScheduleDelayedCompute(self, delayMs, triggerSource)
    if not (TimerManager and TimerManager.Categories and TimerManager.Create and TimerManager.Cancel) then
        return
    end
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, DELAYED_COMPUTE_TIMER)
    local delaySec = (tonumber(delayMs or 0) or 200) / 1000
    local trigger = triggerSource or "delayed"
    TimerManager:Create(
        TimerManager.Categories.UI_NOTIFICATION,
        DELAYED_COMPUTE_TIMER,
        function()
            if self and self.DoPredictionCompute then
                self:DoPredictionCompute(trigger)
            end
        end,
        delaySec,
        false
    )
end

--- Cancel any pending delayed compute.
local function CancelDelayedCompute()
    if TimerManager and TimerManager.Cancel then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, DELAYED_COMPUTE_TIMER)
    end
end

--- Cancel any pending filler backup computes (MS/AR "we were supposed to cast but didn't").
CancelFillerBackups = function()
    if not (TimerManager and TimerManager.Cancel) then
        return
    end
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, MS_ZERO_BACKUP_TIMER)
    for i = 1, MAX_FILLER_BACKUP_TIMERS do
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, FILLER_BACKUP_TIMER_PREFIX .. i)
    end
end

--- Schedule backup compute for each filler (MS/AR) gap. Fires shortly after we were supposed to cast.
--- Covers all gaps: MS-only, AR-only, MS+AR in same state, fillers in slot1 or slot2.
--- @param self HunterSteadyWeaveBar
--- @param segments table Normalized segments from SetDebugSnapshot
ScheduleFillerBackups = function(self, segments)
    if not (TimerManager and TimerManager.Categories and TimerManager.Create and TimerManager.Cancel) then
        return
    end
    CancelFillerBackups()
    if type(segments) ~= "table" then
        return
    end
    local timerIndex = 0
    for i = 1, #segments do
        if timerIndex >= MAX_FILLER_BACKUP_TIMERS then
            break
        end
        local seg = segments[i]
        local actionName = tostring(seg and seg[1] or "")
        local t1 = tonumber(seg and seg[2] or 0) or 0
        if (actionName == "MS" or actionName == "AR") and t1 > 0 then
            local delay = t1 + MS_ZERO_BACKUP_DELAY_SECONDS
            if delay >= 0.05 then
                timerIndex = timerIndex + 1
                local timerName = FILLER_BACKUP_TIMER_PREFIX .. timerIndex
                TimerManager:Create(
                    TimerManager.Categories.UI_NOTIFICATION,
                    timerName,
                    function()
                        if not self or not self.DoPredictionCompute then
                            return
                        end
                        -- Skip if we recently computed (e.g. spell_sent_ms/ar fired because we cast)
                        local lastAt = tonumber((self.state or {}).lastComputationAt or 0) or 0
                        if lastAt <= 0 or (GetTime() - lastAt) >= MS_ZERO_BACKUP_ACTIVE_WINDOW_SECONDS then
                            self:DoPredictionCompute("ms_zero_backup")
                        end
                    end,
                    delay,
                    false
                )
            end
        end
    end
end

--- Schedule aura speed check; cancels any pending one.
local function ScheduleAuraSpeedCheck(self)
    if not (TimerManager and TimerManager.Categories and TimerManager.Create and TimerManager.Cancel) then
        return
    end
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, AURA_SPEED_CHECK_TIMER)
    local delaySec = AURA_SPEED_CHECK_DELAY_MS / 1000
    TimerManager:Create(
        TimerManager.Categories.UI_NOTIFICATION,
        AURA_SPEED_CHECK_TIMER,
        function()
            if not self or not self.DoPredictionCompute then
                return
            end
            local lastSpeed = lastKnownRangedSwingSpeed
            if lastSpeed == nil then
                return
            end
            local currentSpeed = GetCurrentRangedSpeed()
            if math.abs(currentSpeed - lastSpeed) > RANGED_SPEED_EPSILON then
                self:DoPredictionCompute("aura_speed")
            end
        end,
        delaySec,
        false
    )
end

--- Cancel any pending aura speed check.
local function CancelAuraSpeedCheck()
    if TimerManager and TimerManager.Cancel then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, AURA_SPEED_CHECK_TIMER)
    end
end

--- Advance snapshot elapsed on real ranged swing start (Auto Shot).
--- EXPERIMENT: every auto triggers compute immediately (no cooldown, no delay).
--- @param eventName string
--- @param unitId string
--- @param speed number
--- @param expirationTime number
--- @param hand string
function module:HandleAutoshotSwingStart(eventName, unitId, speed, expirationTime, hand)
    if unitId ~= "player" or hand ~= "ranged" then
        return
    end
    local db = self.db and self.db.class
    if not db or db.useDebugSnapshotWhenAvailable ~= true then
        return
    end
    self.state = self.state or {}
    self.state.autoshotsSinceSnapshot = (tonumber(self.state.autoshotsSinceSnapshot or 0) or 0) + 1
    self:DoPredictionCompute("autoshot")
    if frame and self:IsEnabled() then
        self:UpdateDisplay()
    end
end

--- Request a prediction compute. When forceRefresh=true, runs immediately. Otherwise respects timer cooldown (2.5s).
--- @param forceRefresh boolean|nil When true, bypasses cooldown (startup, target change, etc.).
--- @param triggerSource string|nil Source for debug logging (e.g. "startup", "options").
function module:RefreshPredictionSnapshot(forceRefresh, triggerSource)
    local db = self.db and self.db.class
    if not db or db.useDebugSnapshotWhenAvailable ~= true then
        return
    end
    if forceRefresh ~= true then
        self.state = self.state or {}
        local lastAt = tonumber(self.state.lastComputationAt or 0) or 0
        if lastAt > 0 and (GetTime() - lastAt) < TIMER_COOLDOWN_SECONDS then
            return
        end
    end
    local trigger = triggerSource or (forceRefresh == true and self.state and self.state._lastComputeTrigger) or "refresh"
    self:DoPredictionCompute(trigger)
end

--- Cancel the periodic snapshot refresh timer.
function module:StopSnapshotRefreshTimer()
    if not TimerManager then
        TimerManager = NAG:GetModule("TimerManager", true) or ns.TimerManager
    end
    if not (TimerManager and TimerManager.Categories and TimerManager.Cancel) then
        return
    end
    TimerManager:Cancel(TimerManager.Categories.ROTATION, SNAPSHOT_TIMER_NAME)
    CancelDelayedCompute()
    CancelAuraSpeedCheck()
    CancelFillerBackups()
end

--- Start the periodic snapshot refresh timer and trigger one immediate refresh.
function module:StartSnapshotRefreshTimer()
    local db = self.db and self.db.class
    self:StopSnapshotRefreshTimer()
    if not db or db.enabled ~= true or db.useDebugSnapshotWhenAvailable ~= true then
        return
    end

    if not TimerManager then
        TimerManager = NAG:GetModule("TimerManager", true) or ns.TimerManager
    end
    if not (TimerManager and TimerManager.Categories and TimerManager.Create) then
        return
    end

    TimerManager:Create(
        TimerManager.Categories.ROTATION,
        SNAPSHOT_TIMER_NAME,
        function()
            if self:IsEnabled() then
                self:RefreshPredictionSnapshot(nil, "periodic")
            end
        end,
        SNAPSHOT_REFRESH_INTERVAL_SECONDS,
        true
    )

    self.state = self.state or {}
    self.state._lastComputeTrigger = "startup"
    self:RefreshPredictionSnapshot(true)
end

function module:ModuleInitialize()
    self:RegisterSteadyOptions()
    if ChatCommandUtils then
        ChatCommandUtils.RegisterCommand(self, "naghuntersteady", "HandleSteadySlashCommand", "Open Hunter Steady Weave bar tuning window.")
        ChatCommandUtils.RegisterCommand(self, "naghunter", "HandleSteadySlashCommand", "Open Hunter Steady Weave bar tuning window.")
    end
end

function module:ModuleEnable()
    if UnitClassBase("player") ~= "HUNTER" then
        self:SetEnabledState(false)
        return
    end
    self:RegisterAutoshotSwingCallback()
    self:CreateFrameUI()
    self:UpdateVisibility()
    self:StartSnapshotRefreshTimer()
end

function module:ModuleDisable()
    self:StopSnapshotRefreshTimer()
    self:UnregisterAutoshotSwingCallback()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
    self.state = self.state or {}
    self.state.debugSnapshot = nil
    self.state.autoshotsSinceSnapshot = 0
    self.state.lastSnapshotSetAt = nil
    self.state.lastComputationAt = nil
    lockedSegmentCount = nil
    lastKnownRangedSwingSpeed = nil
end

module.eventHandlers = {
    PLAYER_ENTERING_WORLD = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
    UNIT_AURA = true,
    UNIT_SPELLCAST_SENT = true,
    UNIT_SPELLCAST_START = true,
}

function module:PLAYER_ENTERING_WORLD()
    self:UpdateVisibility()
end

function module:PLAYER_REGEN_DISABLED()
    self:UpdateVisibility()
end

function module:PLAYER_REGEN_ENABLED()
    lockedSegmentCount = nil
    self:UpdateVisibility()
end

function module:PLAYER_TARGET_CHANGED()
    self:DoPredictionCompute("target_change")
    self:UpdateDisplay()
end

function module:UNIT_AURA(unitId)
    if unitId ~= "player" then
        return
    end
    ScheduleAuraSpeedCheck(self)
end

--- Force calculation on MS or AR spell sent (fillers only).
function module:UNIT_SPELLCAST_SENT(eventName, unitId, targetName, castGUID, spellIdOrName)
    if unitId ~= "player" then
        return
    end
    if NAG.IsTBCHunterSteadyBarsEnabled and not NAG:IsTBCHunterSteadyBarsEnabled() then
        return
    end
    local spellId = tonumber(spellIdOrName)
    if not spellId then
        return
    end
    if MULTI_SHOT_ID_SET[spellId] then
        self:DoPredictionCompute("spell_sent_ms")
    elseif ARCANE_SHOT_ID_SET[spellId] then
        self:DoPredictionCompute("spell_sent_ar")
    end
end

--- EXPERIMENT: SS casts do NOT trigger computations. Only MS/AR do (via UNIT_SPELLCAST_SENT).
function module:UNIT_SPELLCAST_START(eventName, unitId, castGUID, spellId)
    -- SS: no-op for experiment
end

-- ============================ OPTIONS ============================
function module:GetOptions()
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end

    local function updateDisplay()
        if frame then self:UpdateDisplay() end
    end

    return {
        type = "group",
        name = "Hunter Steady Weave Bar",
        order = 28,
        childGroups = "tab",
        width = "full",
        args = {
            general = {
                type = "group",
                name = "General",
                order = 1,
                args = {
                    enabled = OptionsFactory:CreateToggle("Enabled", "Enable the snapshot bar.",
                        function() return self:GetSetting("class", "enabled") end,
                        function(_, value)
                            self:SetSetting("class", "enabled", value)
                            if value then self:Enable() else self:Disable() end
                        end, { order = 1 }),
                    showOnlyInCombat = OptionsFactory:CreateToggle("Show Only In Combat",
                        "Only show the bar when in combat. When off, the bar is visible whenever the rotation enables it.",
                        function() return self:GetSetting("class", "showOnlyInCombat", true) end,
                        function(_, value)
                            self:SetSetting("class", "showOnlyInCombat", value)
                            self:UpdateVisibility()
                        end,
                        { order = 2 }),
                    useDebugSnapshotWhenAvailable = OptionsFactory:CreateToggle("Use Debug Snapshot",
                        "Use debug snapshot data when available.", function() return self:GetSetting("class", "useDebugSnapshotWhenAvailable") end,
                        function(_, value)
                            self:SetSetting("class", "useDebugSnapshotWhenAvailable", value)
                            if value == true then
                                self:StartSnapshotRefreshTimer()
                            else
                                self:StopSnapshotRefreshTimer()
                            end
                            updateDisplay()
                        end,
                        { order = 3 }),
                    draggable = OptionsFactory:CreateToggle("Draggable", "Allow dragging without edit mode.",
                        function() return self:GetSetting("class", "draggable") end,
                        function(_, value) self:SetSetting("class", "draggable", value); self:UpdateFrameInteraction() end,
                        { order = 4 }),
                    userInputDelayMs = OptionsFactory:CreateRange("User Input Delay (ms)",
                        "Shift predicted action timings by your real input delay.",
                        function() return self:GetSetting("class", "userInputDelayMs", 25) end,
                        function(_, value)
                            self:SetSetting("class", "userInputDelayMs", value)
                            self:RefreshPredictionSnapshot(true, "options")
                            updateDisplay()
                        end,
                        { min = 0, max = 500, step = 5, order = 5 }),
                    alpha = OptionsFactory:CreateRange("Alpha", "Frame alpha.", function() return self:GetSetting("class", "alpha") end,
                        function(_, value) self:SetSetting("class", "alpha", value); if frame then frame:SetAlpha(value) end end,
                        { min = 0.1, max = 1.0, step = 0.05, order = 6 }),
                }
            },
            autoshotTicks = {
                type = "group",
                name = "Autoshot Tick Markers",
                order = 2,
                args = {
                    showAutoshotTicks = OptionsFactory:CreateToggle(
                        "Show Autoshot Ticks",
                        "Show tick marks at autoshot moments on the timeline.",
                        function() return self:GetSetting("class", "showAutoshotTicks", false) end,
                        function(_, value)
                            self:SetSetting("class", "showAutoshotTicks", value)
                            updateDisplay()
                        end,
                        { order = 1 }
                    ),
                    showAutoshotTicksInEmptyState = OptionsFactory:CreateToggle(
                        "Show in Empty State",
                        "Show autoshot ticks when the bar has no segment data.",
                        function() return self:GetSetting("class", "showAutoshotTicksInEmptyState", false) end,
                        function(_, value)
                            self:SetSetting("class", "showAutoshotTicksInEmptyState", value)
                            updateDisplay()
                        end,
                        { order = 2 }
                    ),
                    autoshotTickWidth = OptionsFactory:CreateRange(
                        "Tick Width",
                        "Width of each autoshot tick marker in pixels.",
                        function() return self:GetSetting("class", "autoshotTickWidth", 2) end,
                        function(_, value)
                            self:SetSetting("class", "autoshotTickWidth", value)
                            updateDisplay()
                        end,
                        { min = 1, max = 24, step = 1, order = 3 }
                    ),
                    autoshotTickHeight = OptionsFactory:CreateRange(
                        "Tick Height",
                        "Height of each autoshot tick marker in pixels.",
                        function() return self:GetSetting("class", "autoshotTickHeight", 5) end,
                        function(_, value)
                            self:SetSetting("class", "autoshotTickHeight", value)
                            updateDisplay()
                        end,
                        { min = 2, max = 48, step = 1, order = 4 }
                    ),
                    autoshotTickColor = OptionsFactory:CreateColor(
                        "Tick Color",
                        "Color of the autoshot tick markers.",
                        function()
                            local c = self.db.class.autoshotTickColor or defaults.class.autoshotTickColor
                            return c.r, c.g, c.b, c.a
                        end,
                        function(_, r, g, b, a)
                            self.db.class.autoshotTickColor = self.db.class.autoshotTickColor or {}
                            self.db.class.autoshotTickColor.r = r
                            self.db.class.autoshotTickColor.g = g
                            self.db.class.autoshotTickColor.b = b
                            self.db.class.autoshotTickColor.a = a
                            updateDisplay()
                        end,
                        { hasAlpha = true, order = 5 }
                    ),
                    autoshotTickOffsetX = OptionsFactory:CreateRange(
                        "Offset X",
                        "Horizontal offset for autoshot tick markers.",
                        function() return self:GetSetting("class", "autoshotTickOffsetX", 0) end,
                        function(_, value)
                            self:SetSetting("class", "autoshotTickOffsetX", value)
                            updateDisplay()
                        end,
                        { min = -50, max = 50, step = 1, order = 6 }
                    ),
                    autoshotTickOffsetY = OptionsFactory:CreateRange(
                        "Offset Y",
                        "Vertical offset for autoshot tick markers.",
                        function() return self:GetSetting("class", "autoshotTickOffsetY", 6) end,
                        function(_, value)
                            self:SetSetting("class", "autoshotTickOffsetY", value)
                            updateDisplay()
                        end,
                        { min = -50, max = 50, step = 1, order = 7 }
                    ),
                    showAutoshotTickLabels = OptionsFactory:CreateToggle(
                        "Show Time Labels",
                        "Show the remaining seconds on each tick marker.",
                        function() return self:GetSetting("class", "showAutoshotTickLabels", false) end,
                        function(_, value)
                            self:SetSetting("class", "showAutoshotTickLabels", value)
                            updateDisplay()
                        end,
                        { order = 8 }
                    ),
                }
            },
            dimensionsPosition = {
                type = "group",
                name = "Dimensions & Position",
                order = 3,
                args = {
                    width = OptionsFactory:CreateRange("Width", "Bar width.", function() return self:GetSetting("class", "width") end,
                        function(_, value) self:SetSetting("class", "width", value); updateDisplay() end,
                        { min = 80, max = 600, step = 1, order = 1 }),
                    height = OptionsFactory:CreateRange("Height", "Frame height.", function() return self:GetSetting("class", "height") end,
                        function(_, value) self:SetSetting("class", "height", value); updateDisplay() end,
                        { min = 20, max = 200, step = 1, order = 2 }),
                    visibleWindowSeconds = OptionsFactory:CreateRange("Visible Window Seconds", "Draw only this many upcoming seconds.",
                        function() return self:GetSetting("class", "visibleWindowSeconds") end,
                        function(_, value)
                            self:SetSetting("class", "visibleWindowSeconds", value)
                            self:RefreshPredictionSnapshot(true, "options")
                            updateDisplay()
                        end,
                        { min = 1, max = 15, step = 0.1, order = 3 }),
                    autoAnchor = OptionsFactory:CreateToggle("Auto Anchor", "Automatically anchor below NAG display.",
                        function() return self:GetSetting("class", "autoAnchor") end,
                        function(_, value) self:SetSetting("class", "autoAnchor", value); self:UpdateFrameAnchor() end,
                        { order = 4 }),
                    lockToNagAnchor = OptionsFactory:CreateToggle("Lock To NAG Anchor", "Lock when auto anchor is enabled.",
                        function() return self:GetSetting("class", "lockToNagAnchor") end,
                        function(_, value) self:SetSetting("class", "lockToNagAnchor", value); self:UpdateFrameAnchor() end,
                        { order = 5 }),
                    anchorOffsetX = OptionsFactory:CreateRange("Anchor Offset X", "Horizontal offset from anchor.",
                        function() return self:GetSetting("class", "x") end,
                        function(_, value) self:SetSetting("class", "x", value); self:UpdateFrameAnchor() end,
                        { min = -400, max = 400, step = 1, order = 6 }),
                    anchorOffsetY = OptionsFactory:CreateRange("Anchor Offset Y", "Vertical offset from anchor.",
                        function() return self:GetSetting("class", "y") end,
                        function(_, value) self:SetSetting("class", "y", value); self:UpdateFrameAnchor() end,
                        { min = -400, max = 400, step = 1, order = 7 }),
                }
            },
            gcdBar = {
                type = "group",
                name = "GCD Bar",
                order = 4,
                args = {
                    showGcdBar = OptionsFactory:CreateToggle(
                        "Show GCD Bar",
                        "Show a thick bar for GCD remaining (counts down to zero).",
                        function() return self:GetSetting("class", "showGcdBar", true) end,
                        function(_, value)
                            self:SetSetting("class", "showGcdBar", value)
                            updateDisplay()
                        end,
                        { order = 1 }
                    ),
                    gcdBarHeight = OptionsFactory:CreateRange(
                        "GCD Bar Height",
                        "Height of the GCD countdown bar.",
                        function() return self:GetSetting("class", "gcdBarHeight", 8) end,
                        function(_, value)
                            self:SetSetting("class", "gcdBarHeight", value)
                            updateDisplay()
                        end,
                        { min = 2, max = 24, step = 1, order = 2 }
                    ),
                    gcdBarOffsetY = OptionsFactory:CreateRange(
                        "GCD Bar Offset Y",
                        "Vertical offset for the GCD countdown bar.",
                        function() return self:GetSetting("class", "gcdBarOffsetY", 0) end,
                        function(_, value)
                            self:SetSetting("class", "gcdBarOffsetY", value)
                            updateDisplay()
                        end,
                        { min = -20, max = 20, step = 1, order = 3 }
                    ),
                    gcdBarColor = OptionsFactory:CreateColor(
                        "GCD Bar Color",
                        "Color of the GCD countdown bar.",
                        function()
                            local c = self.db.class.gcdBarColor or defaults.class.gcdBarColor
                            return c.r, c.g, c.b, c.a
                        end,
                        function(_, r, g, b, a)
                            self.db.class.gcdBarColor = self.db.class.gcdBarColor or {}
                            self.db.class.gcdBarColor.r = r
                            self.db.class.gcdBarColor.g = g
                            self.db.class.gcdBarColor.b = b
                            self.db.class.gcdBarColor.a = a
                            updateDisplay()
                        end,
                        { hasAlpha = true, order = 4 }
                    ),
                }
            },
            background = {
                type = "group",
                name = "Background",
                order = 5,
                args = {
                    showBackground = OptionsFactory:CreateToggle("Show Background", "Show the timeline strip background.",
                        function() return self:GetSetting("class", "showBackground") end,
                        function(_, value) self:SetSetting("class", "showBackground", value); updateDisplay() end,
                        { order = 1 }),
                    backgroundOffsetX = OptionsFactory:CreateRange("Background Offset X", "Horizontal background offset.",
                        function() return self:GetSetting("class", "backgroundOffsetX", 0) end,
                        function(_, value) self:SetSetting("class", "backgroundOffsetX", value); updateDisplay() end,
                        { min = -200, max = 200, step = 1, order = 2 }),
                    backgroundOffsetY = OptionsFactory:CreateRange("Background Offset Y", "Vertical background offset.",
                        function() return self:GetSetting("class", "backgroundOffsetY", 0) end,
                        function(_, value) self:SetSetting("class", "backgroundOffsetY", value); updateDisplay() end,
                        { min = -200, max = 200, step = 1, order = 3 }),
                    backgroundScale = OptionsFactory:CreateRange("Background Scale", "Background bar scale.",
                        function() return self:GetSetting("class", "backgroundScale", 1.0) end,
                        function(_, value) self:SetSetting("class", "backgroundScale", value); updateDisplay() end,
                        { min = 0.25, max = 3.0, step = 0.05, order = 4 }),
                    showBgArt = OptionsFactory:CreateToggle("Show Background Art", "Show the background art texture.",
                        function() return self:GetSetting("class", "showBgArt") end,
                        function(_, value) self:SetSetting("class", "showBgArt", value); updateDisplay() end,
                        { order = 5 }),
                    bgArtScale = OptionsFactory:CreateRange("BG Art Scale", "Background art scale.",
                        function() return self:GetSetting("class", "bgArtScale", 1.0) end,
                        function(_, value) self:SetSetting("class", "bgArtScale", value); updateDisplay() end,
                        { min = 0.25, max = 3.0, step = 0.05, order = 6 }),
                    bgArtWidth = OptionsFactory:CreateRange("BG Art Width", "Background art width.", function() return self:GetSetting("class", "bgArtWidth") end,
                        function(_, value) self:SetSetting("class", "bgArtWidth", value); updateDisplay() end,
                        { min = 40, max = 1000, step = 1, order = 7 }),
                    bgArtHeight = OptionsFactory:CreateRange("BG Art Height", "Background art height.", function() return self:GetSetting("class", "bgArtHeight") end,
                        function(_, value) self:SetSetting("class", "bgArtHeight", value); updateDisplay() end,
                        { min = 20, max = 200, step = 1, order = 8 }),
                }
            },
            markersLanes = {
                type = "group",
                name = "Markers & Lanes",
                order = 6,
                args = {
                    showGreenCircle = OptionsFactory:CreateToggle("Show Zero Marker", "Show the left zero marker.",
                        function() return self:GetSetting("class", "showGreenCircle") end,
                        function(_, value) self:SetSetting("class", "showGreenCircle", value); updateDisplay() end,
                        { order = 1 }),
                    greenCircleSize = OptionsFactory:CreateRange("Zero Marker Size", "Zero marker size in pixels.",
                        function() return self:GetSetting("class", "greenCircleSize") end,
                        function(_, value) self:SetSetting("class", "greenCircleSize", value); updateDisplay() end,
                        { min = 8, max = 64, step = 1, order = 2 }),
                    greenCircleScale = OptionsFactory:CreateRange("Zero Marker Scale", "Zero marker scale.",
                        function() return self:GetSetting("class", "greenCircleScale", 1.0) end,
                        function(_, value) self:SetSetting("class", "greenCircleScale", value); updateDisplay() end,
                        { min = 0.25, max = 3.0, step = 0.05, order = 3 }),
                    greenCircleOffsetX = OptionsFactory:CreateRange("Zero Marker Offset X", "Horizontal zero marker offset.",
                        function() return self:GetSetting("class", "greenCircleOffsetX", 0) end,
                        function(_, value) self:SetSetting("class", "greenCircleOffsetX", value); updateDisplay() end,
                        { min = -200, max = 200, step = 1, order = 4 }),
                    greenCircleOffsetY = OptionsFactory:CreateRange("Zero Marker Offset Y", "Vertical zero marker offset.",
                        function() return self:GetSetting("class", "greenCircleOffsetY", 0) end,
                        function(_, value) self:SetSetting("class", "greenCircleOffsetY", value); updateDisplay() end,
                        { min = -200, max = 200, step = 1, order = 5 }),
                    predictionTopLaneOffsetY = OptionsFactory:CreateRange("Top Lane Offset Y", "Top lane vertical offset.",
                        function() return self:GetSetting("class", "predictionTopLaneOffsetY") end,
                        function(_, value) self:SetSetting("class", "predictionTopLaneOffsetY", value); updateDisplay() end,
                        { min = -80, max = 80, step = 1, order = 6 }),
                    predictionBottomLaneOffsetY = OptionsFactory:CreateRange("Bottom Lane Offset Y", "Bottom lane vertical offset.",
                        function() return self:GetSetting("class", "predictionBottomLaneOffsetY") end,
                        function(_, value) self:SetSetting("class", "predictionBottomLaneOffsetY", value); updateDisplay() end,
                        { min = -80, max = 80, step = 1, order = 7 }),
                    predictionTopLaneOffsetX = OptionsFactory:CreateRange("Top Lane Offset X", "Top lane horizontal offset.",
                        function() return self:GetSetting("class", "predictionTopLaneOffsetX", 0) end,
                        function(_, value) self:SetSetting("class", "predictionTopLaneOffsetX", value); updateDisplay() end,
                        { min = -80, max = 80, step = 1, order = 8 }),
                    predictionBottomLaneOffsetX = OptionsFactory:CreateRange("Bottom Lane Offset X", "Bottom lane horizontal offset.",
                        function() return self:GetSetting("class", "predictionBottomLaneOffsetX", 0) end,
                        function(_, value) self:SetSetting("class", "predictionBottomLaneOffsetX", value); updateDisplay() end,
                        { min = -80, max = 80, step = 1, order = 9 }),
                    snapshotSparkScale = OptionsFactory:CreateRange("Spark Scale", "Scale for action spark icons and lane distance.",
                        function() return self:GetSetting("class", "snapshotSparkScale", 1.0) end,
                        function(_, value) self:SetSetting("class", "snapshotSparkScale", value); updateDisplay() end,
                        { min = 0.25, max = 3.0, step = 0.05, order = 10 }),
                    sparkLabelMode = OptionsFactory:CreateSelect(
                        "Spark Label",
                        "Choose what to show above action icons.",
                        function() return self:GetSetting("class", "sparkLabelMode", "none") end,
                        function(_, value)
                            self:SetSetting("class", "sparkLabelMode", value)
                            updateDisplay()
                        end,
                        { order = 11, values = { none = "None", spell = "Spell abbreviation", time = "Time remaining", hold = "HOLD time" } }
                    ),
                    laneConfiguration = OptionsFactory:CreateSelect(
                        "Lane Configuration",
                        "Choose which actions use top/bottom lanes and which icon backgrounds are rotated.",
                        function()
                            local configured = self:GetSetting("class", "laneConfiguration", nil)
                            if type(configured) == "string" and configured ~= "" then
                                return configured
                            end
                            local legacy = self:GetSetting("class", "fillerLaneMode", "bottom")
                            return (legacy == "top") and "only_fillers_top" or "only_fillers_bottom"
                        end,
                        function(_, value)
                            self:SetSetting("class", "laneConfiguration", value)
                            if value == "only_fillers_top" then
                                self:SetSetting("class", "fillerLaneMode", "top")
                            elseif value == "only_fillers_bottom" then
                                self:SetSetting("class", "fillerLaneMode", "bottom")
                            end
                            updateDisplay()
                        end,
                        {
                            order = 12,
                            values = {
                                all_top = "All top",
                                all_bottom = "All bottom",
                                only_fillers_bottom = "Only fillers bottom",
                                only_fillers_top = "Only fillers top",
                            }
                        }
                    ),
                    holdBarOffsetX = OptionsFactory:CreateRange("HOLD Bar Offset X", "Horizontal HOLD bar offset.",
                        function() return self:GetSetting("class", "holdBarOffsetX", 0) end,
                        function(_, value) self:SetSetting("class", "holdBarOffsetX", value); updateDisplay() end,
                        { min = -200, max = 200, step = 1, order = 13 }),
                    holdBarOffsetY = OptionsFactory:CreateRange("HOLD Bar Offset Y", "Vertical HOLD bar offset.",
                        function() return self:GetSetting("class", "holdBarOffsetY", 0) end,
                        function(_, value) self:SetSetting("class", "holdBarOffsetY", value); updateDisplay() end,
                        { min = -200, max = 200, step = 1, order = 14 }),
                    holdBarScale = OptionsFactory:CreateRange("HOLD Bar Scale", "Scale for HOLD base and color bars.",
                        function() return self:GetSetting("class", "holdBarScale", 1.0) end,
                        function(_, value) self:SetSetting("class", "holdBarScale", value); updateDisplay() end,
                        { min = 0.25, max = 3.0, step = 0.05, order = 15 }),
                }
            },
        }
    }
end

-- ============================ OPTIONS REGISTRATION ============================
-- NOTE: /naghunter and /naghuntersteady open NAG options at class > Hunter weave > HunterSteadyWeaveBar.
-- RegisterSteadyOptions/ToggleSteadyOptions are used when opening via slash commands.
