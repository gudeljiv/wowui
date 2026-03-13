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

local ceil = math.ceil
local floor = math.floor
local max = math.max
local min = math.min

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local swingTimerLib = ns.LibClassicSwingTimerAPI
local OptionsFactory
local TimerManager = ns.TimerManager
local ChatCommandUtils = ns.ChatCommandUtils
local AceConfig = ns.AceConfig
local AceConfigDialog = ns.AceConfigDialog

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        draggable = true,
        autoAnchor = true,
        lockToNagAnchor = true,
        point = "CENTER",
        x = 120,
        y = 30,
        width = 180,
        height = 63,
        barHeight = 1,
        barOffsetY = -1,
        alpha = 1.0,
        backgroundOffsetX = 0,
        backgroundOffsetY = 0,
        holdBarOffsetX = 0,
        holdBarOffsetY = 0,
        showBackground = true,
        backgroundScale = 1.0,
        showBgArt = true,
        bgArtScale = 1.0,
        useDebugSnapshotWhenAvailable = true,
        predictionCooldownSeconds = 1.5,
        visibleWindowSeconds = 4,
        laneConfiguration = "only_fillers_bottom", -- all_top, all_bottom, only_fillers_bottom, only_fillers_top
        fillerLaneMode = "bottom", -- legacy: bottom, top
        showGreenCircle = true,
        greenCircleSize = 20,
        greenCircleScale = 1.0,
        greenCircleOffsetX = 0,
        greenCircleOffsetY = 0,
        greenCircleAlpha = 0.9,
        greenCircleColor = { r = 0.2, g = 0.9, b = 0.2, a = 0.9 },
        snapshotSparkScale = 1.0,
        holdBarScale = 1.0,
        showAutoshotTicks = false,
        showAutoshotTicksInEmptyState = false,
        sparkLabelMode = "none", -- none, spell, time, hold
        predictionTopLaneOffsetY = 12,
        predictionBottomLaneOffsetY = -12,
        predictionTopLaneOffsetX = 0,
        predictionBottomLaneOffsetX = 0,
        bgArtWidth = 207,
        bgArtHeight = 20,
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
        return true
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

local DEFAULT_ICON_SIZE = 16
local MAX_SWING_SPARKS = 3
local SEGMENT_SPARK_OFFSET_Y = 20
local SEGMENT_SPARK_BG_PATH = "Interface\\AddOns\\NAG\\media\\extras\\iconBar3Inverted.png"
local MAX_DYNAMIC_SEGMENTS = 8
local MAX_SNAPSHOT_SEGMENTS = 16
local DEFAULT_EFFECTIVE_GCD = 1.5
local MIN_SEGMENT_COUNT = 2
local FILLER_MIN_SWING_SECONDS = 1.7
local SEGMENT_DEBUG_PRINT_INTERVAL = 0.02
local LEFT_OF_GCD_SPARK_ALPHA = 0.30
local DEFAULT_SNAPSHOT_HORIZON_SECONDS = 15
local SNAPSHOT_REFRESH_INTERVAL_SECONDS = 0.5
local SNAPSHOT_TIMER_NAME = "HunterSteadyWeaveBarSnapshot"

local STEADY_SHOT_ID = 34120
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

--- @param holdSeconds number
--- @param instantCast boolean
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

    if value <= 0.05 then
        return green[1], green[2], green[3], green[4]
    end
    if value < 0.15 then
        local t = Clamp01((value - 0.05) / 0.10)
        return Lerp(green[1], yellow[1], t), Lerp(green[2], yellow[2], t), Lerp(green[3], yellow[3], t), 0.95
    end
    if value <= 0.55 then
        return yellow[1], yellow[2], yellow[3], yellow[4]
    end
    if value < 0.65 then
        local t = Clamp01((value - 0.55) / 0.10)
        return Lerp(yellow[1], red[1], t), Lerp(yellow[2], red[2], t), Lerp(yellow[3], red[3], t), 0.95
    end
    return red[1], red[2], red[3], red[4]
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

--- Resolve snapshot elapsed time.
--- When autoshot moments are present, elapsed advances only per observed ranged swing start.
--- @param self HunterSteadyWeaveBar
--- @param snapshot table
--- @return number
local function GetSnapshotElapsedSeconds(self, snapshot)
    local autoshotMoments = snapshot and snapshot.autoshotMoments
    if type(autoshotMoments) == "table" and #autoshotMoments > 0 then
        local state = self.state or {}
        local observedAutoshots = tonumber(state.autoshotsSinceSnapshot or 0) or 0
        if observedAutoshots <= 0 then
            return 0
        end
        if observedAutoshots > #autoshotMoments then
            observedAutoshots = #autoshotMoments
        end
        return tonumber(autoshotMoments[observedAutoshots] or 0) or 0
    end
    local snapshotAt = tonumber(snapshot and snapshot.snapshotAt or 0) or 0
    return max(0, (GetTime() - snapshotAt))
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

    local holdIdx = 1
    local actionIdx = 1
    local tickIdx = 1
    local pendingHoldDuration = 0
    local tickDedup = {}
    local autoshotMoments = snapshot.autoshotMoments
    local hasAutoshotMoments = type(autoshotMoments) == "table" and #autoshotMoments > 0
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
        tick:SetPoint("CENTER", frame, "LEFT", tickX, barCenterY)
        tick:SetSize(3, 8)
        if tick.marker then
            tick.marker:SetSize(3, 8)
            tick.marker:SetColorTexture(1, 1, 1, 0.90)
        end
        if tick.label then
            tick.label:SetText(string.format("%.1f", tickRemaining))
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
            if remaining >= 0 and remaining <= visibleWindowSeconds and actionIdx <= MAX_SNAPSHOT_SEGMENTS then
                local sparkFrame = frame.snapshotActionSparks[actionIdx]
                if sparkFrame then
                    local x = SnapshotSecondsToX(remaining, visibleWindowSeconds, width)
                    local useTopLane, rotateBg = ResolveSnapshotLanePlacement(actionName, laneConfiguration)
                    local laneY = useTopLane and (swingCenterY + laneTopOffset) or (swingCenterY + laneBottomOffset)
                    local laneXOffset = useTopLane and topLaneOffsetX or bottomLaneOffsetX
                    local spellId = GetActionSpellIdForSnapshot(actionName)
                    local iconTexture = (spellId and GetSpellTexture(spellId)) or "Interface\\Icons\\INV_Misc_QuestionMark"
                    local bgR, bgG, bgB, bgA = GetHoldColor(actionHoldDuration, actionHoldDuration <= 0)

                    sparkFrame.icon:SetTexture(iconTexture)
                    sparkFrame.icon:SetDesaturated(false)
                    sparkFrame.icon:SetAlpha(1.0)
                    sparkFrame.bg:SetVertexColor(bgR, bgG, bgB, bgA)
                    sparkFrame.bg:SetAlpha(0.95)
                    sparkFrame.bg:SetSize(ringSize, ringSize)
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
                            sparkFrame.label:SetText(string.format("%.1f", holdLabelValue))
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
                end
                actionIdx = actionIdx + 1
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

    -- Keep frame on UIParent so we don't affect the main frame (e.g. floating selector position)
    frame:SetParent(_G.UIParent)
    frame:ClearAllPoints()
    frame:SetPoint("TOP", anchor, "BOTTOM", db.x, db.y)
end

function module:NAG_FRAME_UPDATED()
    if frame then
        self:UpdateVisibility()
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

    local dm = NAG:GetModule("DisplayManager", true)
    local level = dm and dm.GetRecommendedClassBarFrameLevel and dm:GetRecommendedClassBarFrameLevel() or 50
    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel(level)
    frame:Show()
    self:UpdateFrameAnchor()
    frame:EnableMouse(db.draggable == true)
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

    local db = self.db.class
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
    local steadyKnown = NAG.SpellIsKnown and NAG:SpellIsKnown(STEADY_SHOT_ID) or false
    local forceShowEarlyGap = db.forceShowEarlyGapForTesting and true or false
    local steadyCast = tonumber(NAG.SpellCastTime and NAG:SpellCastTime(STEADY_SHOT_ID) or 0) or 0
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
    self:RegisterSteadyOptions()
    if not AceConfigDialog then
        return
    end
    if AceConfigDialog.OpenFrames and AceConfigDialog.OpenFrames[STEADY_OPTIONS_NAME] then
        AceConfigDialog:Close(STEADY_OPTIONS_NAME)
    else
        AceConfigDialog:Open(STEADY_OPTIONS_NAME)
    end
end

function module:HandleSteadySlashCommand()
    self:ToggleSteadyOptions()
end

--- Receive a debug snapshot produced by HunterStateTimelineDebug and drive snapshot-mode rendering.
--- @param snapshotAt number
--- @param segments table
--- @param horizonSeconds number|nil
--- @param autoshotMoments table|nil
function module:SetDebugSnapshot(snapshotAt, segments, horizonSeconds, autoshotMoments)
    self.state = self.state or {}

    if type(segments) ~= "table" or #segments == 0 then
        self.state.debugSnapshot = nil
        self.state.lastSnapshotSetAt = nil
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
    }
    self.state.autoshotsSinceSnapshot = 0
    self.state.lastSnapshotSetAt = GetTime()

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
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:EnableMouse(db.draggable == true)
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

    background = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    background:SetColorTexture(db.backgroundColor.r, db.backgroundColor.g, db.backgroundColor.b, db.backgroundColor.a)

    timelineBar = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    timelineBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    timelineBar:SetSize(frame:GetWidth(), frame:GetHeight())

    bgArt = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    bgArt:SetPoint("CENTER", frame, "CENTER")
    bgArt:SetTexture(BG_ART_TEXTURE)
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

--- Advance snapshot elapsed on real ranged swing start (Auto Shot).
--- @param eventName string
--- @param unitId string
--- @param speed number
--- @param expirationTime number
--- @param hand string
function module:HandleAutoshotSwingStart(eventName, unitId, speed, expirationTime, hand)
    if unitId ~= "player" or hand ~= "ranged" then
        return
    end
    self.state = self.state or {}
    local snapshot = self.state.debugSnapshot
    if type(snapshot) ~= "table" then
        return
    end
    if type(snapshot.autoshotMoments) ~= "table" or #snapshot.autoshotMoments == 0 then
        return
    end
    self.state.autoshotsSinceSnapshot = (tonumber(self.state.autoshotsSinceSnapshot or 0) or 0) + 1
    if frame and self:IsEnabled() then
        self:UpdateDisplay()
    end
end

--- Request a silent snapshot refresh from HunterStateTimelineDebug.
--- @param forceRefresh boolean|nil Force refresh even when cooldown is active.
function module:RefreshPredictionSnapshot(forceRefresh)
    local db = self.db and self.db.class
    if not db or db.useDebugSnapshotWhenAvailable ~= true then
        return
    end
    local shouldForce = forceRefresh == true
    if not shouldForce then
        local cooldownSeconds = tonumber(db.predictionCooldownSeconds or 0) or 0
        if cooldownSeconds > 0 then
            self.state = self.state or {}
            local snapshot = self.state.debugSnapshot
            local lastSnapshotSetAt = tonumber(self.state.lastSnapshotSetAt or 0) or 0
            if type(snapshot) == "table" and lastSnapshotSetAt > 0 then
                local elapsedSinceSet = GetTime() - lastSnapshotSetAt
                if elapsedSinceSet < cooldownSeconds then
                    return
                end
            end
        end
    end
    local stateDebug = NAG:GetModule("HunterStateTimelineDebug", true)
    if stateDebug and stateDebug.RefreshBarSnapshot then
        stateDebug:RefreshBarSnapshot()
    end
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
                self:RefreshPredictionSnapshot()
            end
        end,
        SNAPSHOT_REFRESH_INTERVAL_SECONDS,
        true
    )

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
    self:RefreshPredictionSnapshot(true)
    self:UpdateDisplay()
end

function module:UNIT_AURA(unitId)
    if unitId ~= "player" then
        return
    end
    self:RefreshPredictionSnapshot(true)
end

function module:UNIT_SPELLCAST_SENT(eventName, unitId, targetName, castGUID, spellIdOrName)
    if unitId ~= "player" then
        return
    end
    local spellId = tonumber(spellIdOrName)
    if not spellId then
        return
    end
    if STEADY_SHOT_ID_SET[spellId]
        or MULTI_SHOT_ID_SET[spellId]
        or ARCANE_SHOT_ID_SET[spellId]
        or AIMED_SHOT_ID_SET[spellId] then
        self:RefreshPredictionSnapshot(true)
    end
end

-- ============================ OPTIONS ============================
function module:GetOptions()
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end
    if true then
        return {
            type = "group",
            name = "Hunter Steady Weave Bar",
            order = 28,
            width = "full",
            args = {
                enabled = OptionsFactory:CreateToggle("Enabled", "Enable the snapshot bar.",
                    function() return self:GetSetting("class", "enabled") end,
                    function(_, value)
                        self:SetSetting("class", "enabled", value)
                        if value then self:Enable() else self:Disable() end
                    end, { order = 1 }),
                useDebugSnapshotWhenAvailable = OptionsFactory:CreateToggle("Use Debug Snapshot",
                    "Use debug snapshot data when available.", function() return self:GetSetting("class", "useDebugSnapshotWhenAvailable") end,
                    function(_, value)
                        self:SetSetting("class", "useDebugSnapshotWhenAvailable", value)
                        if value == true then
                            self:StartSnapshotRefreshTimer()
                        else
                            self:StopSnapshotRefreshTimer()
                        end
                        if frame then self:UpdateDisplay() end
                    end,
                    { order = 2 }),
                predictionCooldownSeconds = OptionsFactory:CreateRange("Prediction Cooldown (seconds)",
                    "Minimum time between prediction updates (0 = always update). Reduces bar flicker.",
                    function() return self:GetSetting("class", "predictionCooldownSeconds", 1.5) end,
                    function(_, value)
                        self:SetSetting("class", "predictionCooldownSeconds", value)
                    end,
                    { min = 0, max = 5, step = 0.25, order = 2.5 }),
                draggable = OptionsFactory:CreateToggle("Draggable", "Allow dragging without edit mode.",
                    function() return self:GetSetting("class", "draggable") end,
                    function(_, value) self:SetSetting("class", "draggable", value); if frame then frame:EnableMouse(value == true) end end,
                    { order = 3 }),
                width = OptionsFactory:CreateRange("Width", "Bar width.", function() return self:GetSetting("class", "width") end,
                    function(_, value) self:SetSetting("class", "width", value); if frame then self:UpdateDisplay() end end,
                    { min = 80, max = 600, step = 1, order = 4 }),
                height = OptionsFactory:CreateRange("Height", "Frame height.", function() return self:GetSetting("class", "height") end,
                    function(_, value) self:SetSetting("class", "height", value); if frame then self:UpdateDisplay() end end,
                    { min = 20, max = 200, step = 1, order = 5 }),
                alpha = OptionsFactory:CreateRange("Alpha", "Frame alpha.", function() return self:GetSetting("class", "alpha") end,
                    function(_, value) self:SetSetting("class", "alpha", value); if frame then frame:SetAlpha(value) end end,
                    { min = 0.1, max = 1.0, step = 0.05, order = 6 }),
                visibleWindowSeconds = OptionsFactory:CreateRange("Visible Window Seconds", "Draw only this many upcoming seconds.",
                    function() return self:GetSetting("class", "visibleWindowSeconds") end,
                    function(_, value)
                        self:SetSetting("class", "visibleWindowSeconds", value)
                        self:RefreshPredictionSnapshot(true)
                        if frame then self:UpdateDisplay() end
                    end,
                    { min = 1, max = 15, step = 0.1, order = 7 }),
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
                        if frame then self:UpdateDisplay() end
                    end,
                    {
                        order = 8,
                        values = {
                            all_top = "All top",
                            all_bottom = "All bottom",
                            only_fillers_bottom = "Only fillers bottom",
                            only_fillers_top = "Only fillers top",
                        }
                    }
                ),
                sparkLabelMode = OptionsFactory:CreateSelect(
                    "Spark Label",
                    "Choose what to show above action icons.",
                    function() return self:GetSetting("class", "sparkLabelMode", "none") end,
                    function(_, value)
                        self:SetSetting("class", "sparkLabelMode", value)
                        if frame then self:UpdateDisplay() end
                    end,
                    { order = 9, values = { none = "None", spell = "Spell abbreviation", time = "Time remaining", hold = "HOLD time" } }
                ),
                showAutoshotTicks = OptionsFactory:CreateToggle(
                    "Show Autoshot Ticks",
                    "Show 3x8 white tick marks at autoshot moments.",
                    function() return self:GetSetting("class", "showAutoshotTicks", false) end,
                    function(_, value)
                        self:SetSetting("class", "showAutoshotTicks", value)
                        if frame then self:UpdateDisplay() end
                    end,
                    { order = 10 }
                ),
                showBackground = OptionsFactory:CreateToggle("Show Background", "Show the timeline strip background.",
                    function() return self:GetSetting("class", "showBackground") end,
                    function(_, value) self:SetSetting("class", "showBackground", value); if frame then self:UpdateDisplay() end end,
                    { order = 11 }),
                backgroundOffsetX = OptionsFactory:CreateRange("Background Offset X", "Horizontal background offset.",
                    function() return self:GetSetting("class", "backgroundOffsetX", 0) end,
                    function(_, value) self:SetSetting("class", "backgroundOffsetX", value); if frame then self:UpdateDisplay() end end,
                    { min = -200, max = 200, step = 1, order = 12 }),
                backgroundOffsetY = OptionsFactory:CreateRange("Background Offset Y", "Vertical background offset.",
                    function() return self:GetSetting("class", "backgroundOffsetY", 0) end,
                    function(_, value) self:SetSetting("class", "backgroundOffsetY", value); if frame then self:UpdateDisplay() end end,
                    { min = -200, max = 200, step = 1, order = 13 }),
                backgroundScale = OptionsFactory:CreateRange("Background Scale", "Background bar scale.",
                    function() return self:GetSetting("class", "backgroundScale", 1.0) end,
                    function(_, value) self:SetSetting("class", "backgroundScale", value); if frame then self:UpdateDisplay() end end,
                    { min = 0.25, max = 3.0, step = 0.05, order = 14 }),
                showBgArt = OptionsFactory:CreateToggle("Show Background Art", "Show the background art texture.",
                    function() return self:GetSetting("class", "showBgArt") end,
                    function(_, value) self:SetSetting("class", "showBgArt", value); if frame then self:UpdateDisplay() end end,
                    { order = 15 }),
                bgArtScale = OptionsFactory:CreateRange("BG Art Scale", "Background art scale.",
                    function() return self:GetSetting("class", "bgArtScale", 1.0) end,
                    function(_, value) self:SetSetting("class", "bgArtScale", value); if frame then self:UpdateDisplay() end end,
                    { min = 0.25, max = 3.0, step = 0.05, order = 16 }),
                bgArtWidth = OptionsFactory:CreateRange("BG Art Width", "Background art width.", function() return self:GetSetting("class", "bgArtWidth") end,
                    function(_, value) self:SetSetting("class", "bgArtWidth", value); if frame then self:UpdateDisplay() end end,
                    { min = 40, max = 1000, step = 1, order = 17 }),
                bgArtHeight = OptionsFactory:CreateRange("BG Art Height", "Background art height.", function() return self:GetSetting("class", "bgArtHeight") end,
                    function(_, value) self:SetSetting("class", "bgArtHeight", value); if frame then self:UpdateDisplay() end end,
                    { min = 20, max = 200, step = 1, order = 18 }),
                showGreenCircle = OptionsFactory:CreateToggle("Show Zero Marker", "Show the left zero marker.",
                    function() return self:GetSetting("class", "showGreenCircle") end,
                    function(_, value) self:SetSetting("class", "showGreenCircle", value); if frame then self:UpdateDisplay() end end,
                    { order = 19 }),
                greenCircleSize = OptionsFactory:CreateRange("Zero Marker Size", "Zero marker size in pixels.",
                    function() return self:GetSetting("class", "greenCircleSize") end,
                    function(_, value) self:SetSetting("class", "greenCircleSize", value); if frame then self:UpdateDisplay() end end,
                    { min = 8, max = 64, step = 1, order = 20 }),
                greenCircleScale = OptionsFactory:CreateRange("Zero Marker Scale", "Zero marker scale.",
                    function() return self:GetSetting("class", "greenCircleScale", 1.0) end,
                    function(_, value) self:SetSetting("class", "greenCircleScale", value); if frame then self:UpdateDisplay() end end,
                    { min = 0.25, max = 3.0, step = 0.05, order = 21 }),
                greenCircleOffsetX = OptionsFactory:CreateRange("Zero Marker Offset X", "Horizontal zero marker offset.",
                    function() return self:GetSetting("class", "greenCircleOffsetX", 0) end,
                    function(_, value) self:SetSetting("class", "greenCircleOffsetX", value); if frame then self:UpdateDisplay() end end,
                    { min = -200, max = 200, step = 1, order = 22 }),
                greenCircleOffsetY = OptionsFactory:CreateRange("Zero Marker Offset Y", "Vertical zero marker offset.",
                    function() return self:GetSetting("class", "greenCircleOffsetY", 0) end,
                    function(_, value) self:SetSetting("class", "greenCircleOffsetY", value); if frame then self:UpdateDisplay() end end,
                    { min = -200, max = 200, step = 1, order = 23 }),
                holdBarOffsetX = OptionsFactory:CreateRange("HOLD Bar Offset X", "Horizontal HOLD bar offset.",
                    function() return self:GetSetting("class", "holdBarOffsetX", 0) end,
                    function(_, value) self:SetSetting("class", "holdBarOffsetX", value); if frame then self:UpdateDisplay() end end,
                    { min = -200, max = 200, step = 1, order = 24 }),
                holdBarOffsetY = OptionsFactory:CreateRange("HOLD Bar Offset Y", "Vertical HOLD bar offset.",
                    function() return self:GetSetting("class", "holdBarOffsetY", 0) end,
                    function(_, value) self:SetSetting("class", "holdBarOffsetY", value); if frame then self:UpdateDisplay() end end,
                    { min = -200, max = 200, step = 1, order = 25 }),
                predictionTopLaneOffsetY = OptionsFactory:CreateRange("Top Lane Offset Y", "Top lane vertical offset.",
                    function() return self:GetSetting("class", "predictionTopLaneOffsetY") end,
                    function(_, value) self:SetSetting("class", "predictionTopLaneOffsetY", value); if frame then self:UpdateDisplay() end end,
                    { min = -80, max = 80, step = 1, order = 26 }),
                predictionBottomLaneOffsetY = OptionsFactory:CreateRange("Bottom Lane Offset Y", "Bottom lane vertical offset.",
                    function() return self:GetSetting("class", "predictionBottomLaneOffsetY") end,
                    function(_, value) self:SetSetting("class", "predictionBottomLaneOffsetY", value); if frame then self:UpdateDisplay() end end,
                    { min = -80, max = 80, step = 1, order = 27 }),
                snapshotSparkScale = OptionsFactory:CreateRange("Spark Scale", "Scale for action spark icons and lane distance.",
                    function() return self:GetSetting("class", "snapshotSparkScale", 1.0) end,
                    function(_, value) self:SetSetting("class", "snapshotSparkScale", value); if frame then self:UpdateDisplay() end end,
                    { min = 0.25, max = 3.0, step = 0.05, order = 28 }),
                holdBarScale = OptionsFactory:CreateRange("HOLD Bar Scale", "Scale for HOLD base and color bars.",
                    function() return self:GetSetting("class", "holdBarScale", 1.0) end,
                    function(_, value) self:SetSetting("class", "holdBarScale", value); if frame then self:UpdateDisplay() end end,
                    { min = 0.25, max = 3.0, step = 0.05, order = 29 }),
                predictionTopLaneOffsetX = OptionsFactory:CreateRange("Top Lane Offset X", "Top lane horizontal offset.",
                    function() return self:GetSetting("class", "predictionTopLaneOffsetX", 0) end,
                    function(_, value) self:SetSetting("class", "predictionTopLaneOffsetX", value); if frame then self:UpdateDisplay() end end,
                    { min = -80, max = 80, step = 1, order = 30 }),
                predictionBottomLaneOffsetX = OptionsFactory:CreateRange("Bottom Lane Offset X", "Bottom lane horizontal offset.",
                    function() return self:GetSetting("class", "predictionBottomLaneOffsetX", 0) end,
                    function(_, value) self:SetSetting("class", "predictionBottomLaneOffsetX", value); if frame then self:UpdateDisplay() end end,
                    { min = -80, max = 80, step = 1, order = 31 }),
                autoAnchor = OptionsFactory:CreateToggle("Auto Anchor", "Automatically anchor below NAG display.",
                    function() return self:GetSetting("class", "autoAnchor") end,
                    function(_, value) self:SetSetting("class", "autoAnchor", value); self:UpdateFrameAnchor() end,
                    { order = 32 }),
                lockToNagAnchor = OptionsFactory:CreateToggle("Lock To NAG Anchor", "Lock when auto anchor is enabled.",
                    function() return self:GetSetting("class", "lockToNagAnchor") end,
                    function(_, value) self:SetSetting("class", "lockToNagAnchor", value); self:UpdateFrameAnchor() end,
                    { order = 33 }),
                anchorOffsetX = OptionsFactory:CreateRange("Anchor Offset X", "Horizontal offset from anchor.",
                    function() return self:GetSetting("class", "x") end,
                    function(_, value) self:SetSetting("class", "x", value); self:UpdateFrameAnchor() end,
                    { min = -400, max = 400, step = 1, order = 34 }),
                anchorOffsetY = OptionsFactory:CreateRange("Anchor Offset Y", "Vertical offset from anchor.",
                    function() return self:GetSetting("class", "y") end,
                    function(_, value) self:SetSetting("class", "y", value); self:UpdateFrameAnchor() end,
                    { min = -400, max = 400, step = 1, order = 35 }),
            }
        }
    end

    local function colorGetter(color)
        return function()
            return color.r, color.g, color.b, color.a
        end
    end

    local function colorSetter(color)
        return function(_, r, g, b, a)
            color.r, color.g, color.b, color.a = r, g, b, a
            if frame then self:UpdateDisplay() end
        end
    end

    return {
        type = "group",
        name = "Hunter Steady Weave Bar",
        order = 28,
        childGroups = "tab",
        width = "full",
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enabled",
                "Enable/disable the Hunter Steady Weave Bar module.",
                function() return self:GetSetting("class", "enabled") end,
                function(_, value)
                    self:SetSetting("class", "enabled", value)
                    if value then self:Enable() else self:Disable() end
                end,
                { order = 1 }
            ),
            hideOutOfCombat = OptionsFactory:CreateToggle(
                "Hide Out of Combat",
                "Hide the bar when out of combat.",
                function() return self:GetSetting("class", "hideOutOfCombat") end,
                function(_, value)
                    self:SetSetting("class", "hideOutOfCombat", value)
                    self:UpdateVisibility()
                end,
                { order = 2 }
            ),
            showKeybindOnBar = OptionsFactory:CreateToggle(
                "Show Keybind Above Bar Icons",
                "Display the keybind above the icons on the bar.",
                function() return self:GetSetting("class", "showKeybindOnBar") end,
                function(_, value)
                    self:SetSetting("class", "showKeybindOnBar", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 3 }
            ),
            width = OptionsFactory:CreateRange(
                "Width",
                "Bar width.",
                function() return self:GetSetting("class", "width") end,
                function(_, value)
                    self:SetSetting("class", "width", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 80, max = 600, step = 1, order = 20 }
            ),
            height = OptionsFactory:CreateRange(
                "Height",
                "Bar height.",
                function() return self:GetSetting("class", "height") end,
                function(_, value)
                    self:SetSetting("class", "height", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 1, max = 60, step = 1, order = 21 }
            ),
            alpha = OptionsFactory:CreateRange(
                "Alpha",
                "Frame alpha.",
                function() return self:GetSetting("class", "alpha") end,
                function(_, value)
                    self:SetSetting("class", "alpha", value)
                    if frame then frame:SetAlpha(value) end
                end,
                { min = 0.1, max = 1.0, step = 0.05, order = 22 }
            ),
            autoAnchor = OptionsFactory:CreateToggle(
                "Auto Anchor",
                "Automatically anchor below the main display.",
                function() return self:GetSetting("class", "autoAnchor") end,
                function(_, value)
                    self:SetSetting("class", "autoAnchor", value)
                    self:UpdateFrameAnchor()
                end,
                { order = 24 }
            ),
            lockToNagAnchor = OptionsFactory:CreateToggle(
                "Lock To NAG Anchor",
                "Lock the bar to the NAG display anchor (when auto anchor is enabled).",
                function() return self:GetSetting("class", "lockToNagAnchor") end,
                function(_, value)
                    self:SetSetting("class", "lockToNagAnchor", value)
                    self:UpdateFrameAnchor()
                end,
                { order = 25 }
            ),
            anchorOffsetX = OptionsFactory:CreateRange(
                "Anchor Offset X",
                "Horizontal offset from the anchor (pixels).",
                function() return self:GetSetting("class", "x") end,
                function(_, value)
                    self:SetSetting("class", "x", value)
                    self:UpdateFrameAnchor()
                end,
                { min = -400, max = 400, step = 1, order = 26 }
            ),
            anchorOffsetY = OptionsFactory:CreateRange(
                "Anchor Offset Y",
                "Vertical offset from the anchor (pixels).",
                function() return self:GetSetting("class", "y") end,
                function(_, value)
                    self:SetSetting("class", "y", value)
                    self:UpdateFrameAnchor()
                end,
                { min = -400, max = 400, step = 1, order = 27 }
            ),
            layoutHeader = OptionsFactory:CreateHeader("Layout", { order = 30 }),
            barHeight = OptionsFactory:CreateRange(
                "Bar Height",
                "Height of the timeline bar (pixels).",
                function() return self:GetSetting("class", "barHeight") end,
                function(_, value)
                    self:SetSetting("class", "barHeight", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 1, max = 12, step = 1, order = 31 }
            ),
            barOffsetY = OptionsFactory:CreateRange(
                "Bar Offset Y",
                "Vertical offset of the timeline bar (pixels).",
                function() return self:GetSetting("class", "barOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "barOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -20, max = 20, step = 1, order = 32 }
            ),
            visualsHeader = OptionsFactory:CreateHeader("Visual Toggles", { order = 40 }),
            showBackground = OptionsFactory:CreateToggle(
                "Show Background",
                "Show the background bar.",
                function() return self:GetSetting("class", "showBackground") end,
                function(_, value)
                    self:SetSetting("class", "showBackground", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 41 }
            ),
            showTimelineBar = OptionsFactory:CreateToggle(
                "Show Timeline Bar",
                "Show the thin timeline bar.",
                function() return self:GetSetting("class", "showTimelineBar") end,
                function(_, value)
                    self:SetSetting("class", "showTimelineBar", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 42 }
            ),
            showBgArt = OptionsFactory:CreateToggle(
                "Show Background Art",
                "Show the NAGbarCD background art.",
                function() return self:GetSetting("class", "showBgArt") end,
                function(_, value)
                    self:SetSetting("class", "showBgArt", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 43 }
            ),
            showNowMarker = OptionsFactory:CreateToggle(
                "Show NOW Marker",
                "Show the right-edge NOW marker.",
                function() return self:GetSetting("class", "showNowMarker") end,
                function(_, value)
                    self:SetSetting("class", "showNowMarker", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 44 }
            ),
            showDebugSwingBar = OptionsFactory:CreateToggle(
                "Show Debug Swing Bar",
                "Show the debug swing timer bar with time text.",
                function() return self:GetSetting("class", "showDebugSwingBar") end,
                function(_, value)
                    self:SetSetting("class", "showDebugSwingBar", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 45 }
            ),
            showDebugSwingText = OptionsFactory:CreateToggle(
                "Show Debug Swing Text",
                "Show the debug swing timer text.",
                function() return self:GetSetting("class", "showDebugSwingText") end,
                function(_, value)
                    self:SetSetting("class", "showDebugSwingText", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 46 }
            ),
            showTargetMarker = OptionsFactory:CreateToggle(
                "Show Target Marker",
                "Show the wind-up zone target marker (when to press Steady/Aimed).",
                function() return self:GetSetting("class", "showTargetMarker") end,
                function(_, value)
                    self:SetSetting("class", "showTargetMarker", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 47 }
            ),
            showSwingBars = OptionsFactory:CreateToggle(
                "Show Swing Bars",
                "Show the swing timeline bars (past + future).",
                function() return self:GetSetting("class", "showSwingBars") end,
                function(_, value)
                    self:SetSetting("class", "showSwingBars", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 48 }
            ),
            showSwingSpark = OptionsFactory:CreateToggle(
                "Show Swing Spark",
                "Show the swing timing spark.",
                function() return self:GetSetting("class", "showSwingSpark") end,
                function(_, value)
                    self:SetSetting("class", "showSwingSpark", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 49 }
            ),
            showSteadySpark = OptionsFactory:CreateToggle(
                "Show Steady/Aimed Spark",
                "Show the Steady Shot or Aimed Shot icon spark.",
                function() return self:GetSetting("class", "showSteadySpark") end,
                function(_, value)
                    self:SetSetting("class", "showSteadySpark", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 50 }
            ),
            showSegmentDividers = OptionsFactory:CreateToggle(
                "Show Segment Dividers",
                "Draw thin vertical dividers between dynamic auto-shot segments.",
                function() return self:GetSetting("class", "showSegmentDividers") end,
                function(_, value)
                    self:SetSetting("class", "showSegmentDividers", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 51 }
            ),
            showSegmentDebugLogs = OptionsFactory:CreateToggle(
                "Show Segment Debug Logs",
                "Print segment count / lockout details periodically while in combat.",
                function() return self:GetSetting("class", "showSegmentDebugLogs") end,
                function(_, value)
                    self:SetSetting("class", "showSegmentDebugLogs", value)
                    self._lastSegmentDebugLogAt = nil
                    if frame then self:UpdateDisplay() end
                end,
                { order = 52 }
            ),
            bgArtHeader = OptionsFactory:CreateHeader("Background Art", { order = 60 }),
            bgArtWidth = OptionsFactory:CreateRange(
                "BG Art Width",
                "Background art width (pixels).",
                function() return self:GetSetting("class", "bgArtWidth") end,
                function(_, value)
                    self:SetSetting("class", "bgArtWidth", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 40, max = 1000, step = 1, order = 61 }
            ),
            bgArtHeight = OptionsFactory:CreateRange(
                "BG Art Height",
                "Background art height (pixels).",
                function() return self:GetSetting("class", "bgArtHeight") end,
                function(_, value)
                    self:SetSetting("class", "bgArtHeight", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 20, max = 200, step = 1, order = 62 }
            ),
            bgArtAlpha = OptionsFactory:CreateRange(
                "BG Art Alpha",
                "Background art alpha.",
                function() return self:GetSetting("class", "bgArtAlpha") end,
                function(_, value)
                    self:SetSetting("class", "bgArtAlpha", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.0, max = 1.0, step = 0.05, order = 63 }
            ),
            bgArtOffsetX = OptionsFactory:CreateRange(
                "BG Art Offset X",
                "Background art X offset (pixels).",
                function() return self:GetSetting("class", "bgArtOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "bgArtOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -300, max = 300, step = 1, order = 64 }
            ),
            bgArtOffsetY = OptionsFactory:CreateRange(
                "BG Art Offset Y",
                "Background art Y offset (pixels).",
                function() return self:GetSetting("class", "bgArtOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "bgArtOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -100, max = 100, step = 1, order = 65 }
            ),
            markerHeader = OptionsFactory:CreateHeader("Markers", { order = 70 }),
            nowMarkerOuterLeftOffsetX = OptionsFactory:CreateRange(
                "NOW Marker Outer Left X",
                "Outer NOW marker left edge offset from frame RIGHT (pixels). Negative moves left.",
                function() return self:GetSetting("class", "nowMarkerOuterLeftOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerOuterLeftOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 71 }
            ),
            nowMarkerOuterRightOffsetX = OptionsFactory:CreateRange(
                "NOW Marker Outer Right X",
                "Outer NOW marker right edge offset from frame RIGHT (pixels).",
                function() return self:GetSetting("class", "nowMarkerOuterRightOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerOuterRightOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 72 }
            ),
            nowMarkerInnerLeftOffsetX = OptionsFactory:CreateRange(
                "NOW Marker Inner Left X",
                "Inner NOW marker left edge offset from frame RIGHT (pixels). Negative moves left.",
                function() return self:GetSetting("class", "nowMarkerInnerLeftOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerInnerLeftOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 73 }
            ),
            nowMarkerInnerRightOffsetX = OptionsFactory:CreateRange(
                "NOW Marker Inner Right X",
                "Inner NOW marker right edge offset from frame RIGHT (pixels).",
                function() return self:GetSetting("class", "nowMarkerInnerRightOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerInnerRightOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 74 }
            ),
            nowMarkerOffsetY = OptionsFactory:CreateRange(
                "NOW Marker Offset Y",
                "Vertical offset for the NOW marker (pixels).",
                function() return self:GetSetting("class", "nowMarkerOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -20, max = 20, step = 1, order = 75 }
            ),
            targetMarkerSeconds = OptionsFactory:CreateRange(
                "Target Marker Seconds",
                "Seconds before next Auto Shot (wind-up zone).",
                function() return self:GetSetting("class", "targetMarkerSeconds") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerSeconds", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.0, max = 1.0, step = 0.01, order = 74 }
            ),
            targetMarkerSize = OptionsFactory:CreateRange(
                "Target Marker Size",
                "Size of the target marker (pixels).",
                function() return self:GetSetting("class", "targetMarkerSize") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerSize", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 6, max = 80, step = 1, order = 75 }
            ),
            targetMarkerOffsetX = OptionsFactory:CreateRange(
                "Target Marker Offset X",
                "Horizontal offset of the target marker (pixels).",
                function() return self:GetSetting("class", "targetMarkerOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 76 }
            ),
            targetMarkerOffsetY = OptionsFactory:CreateRange(
                "Target Marker Offset Y",
                "Vertical offset of the target marker (pixels).",
                function() return self:GetSetting("class", "targetMarkerOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 77 }
            ),
            debugSwingBarHeight = OptionsFactory:CreateRange(
                "Debug Swing Bar Height",
                "Height of the debug swing timer bar (pixels).",
                function() return self:GetSetting("class", "debugSwingBarHeight") end,
                function(_, value)
                    self:SetSetting("class", "debugSwingBarHeight", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 4, max = 40, step = 1, order = 78 }
            ),
            debugSwingBarOffsetY = OptionsFactory:CreateRange(
                "Debug Swing Bar Offset Y",
                "Vertical offset of the debug swing timer bar (pixels).",
                function() return self:GetSetting("class", "debugSwingBarOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "debugSwingBarOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -40, max = 40, step = 1, order = 79 }
            ),
            debugSwingFontSize = OptionsFactory:CreateRange(
                "Debug Swing Font Size",
                "Font size for the debug swing timer text.",
                function() return self:GetSetting("class", "debugSwingFontSize") end,
                function(_, value)
                    self:SetSetting("class", "debugSwingFontSize", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 6, max = 24, step = 1, order = 80 }
            ),
            sparksHeader = OptionsFactory:CreateHeader("Spark Icons", { order = 90 }),
            sparkScale = OptionsFactory:CreateRange(
                "Spark Scale",
                "Scale of the Steady/Aimed spark icon.",
                function() return self:GetSetting("class", "sparkScale") end,
                function(_, value)
                    self:SetSetting("class", "sparkScale", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.5, max = 3.0, step = 0.05, order = 91 }
            ),
            sparkOffsetY = OptionsFactory:CreateRange(
                "Spark Offset Y",
                "Vertical offset of the spark icon (pixels).",
                function() return self:GetSetting("class", "sparkOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "sparkOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -30, max = 30, step = 1, order = 92 }
            ),
            sparkSmoothing = OptionsFactory:CreateRange(
                "Spark Smoothing",
                "Smoothing factor for spark movement.",
                function() return self:GetSetting("class", "sparkSmoothing") end,
                function(_, value)
                    self:SetSetting("class", "sparkSmoothing", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.0, max = 1.0, step = 0.05, order = 93 }
            ),
            forceSegmentCount = OptionsFactory:CreateRange(
                "Force Segment Count",
                "0 = Auto. Otherwise force visible auto-shot segments (2-4).",
                function() return self:GetSetting("class", "forceSegmentCount") end,
                function(_, value)
                    self:SetSetting("class", "forceSegmentCount", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0, max = 4, step = 1, order = 94 }
            ),
            maxDynamicSegments = OptionsFactory:CreateRange(
                "Max Dynamic Segments",
                "Maximum auto-shot segments allowed in dynamic mode (minimum baseline is 2).",
                function() return self:GetSetting("class", "maxDynamicSegments") end,
                function(_, value)
                    self:SetSetting("class", "maxDynamicSegments", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 2, max = 8, step = 1, order = 95 }
            ),
            colorsHeader = OptionsFactory:CreateHeader("Colors", { order = 100 }),
            backgroundColor = OptionsFactory:CreateColor(
                "Background Color",
                "Background bar color.",
                colorGetter(self.db.class.backgroundColor),
                colorSetter(self.db.class.backgroundColor),
                { hasAlpha = true, order = 81 }
            ),
            timelineColor = OptionsFactory:CreateColor(
                "Timeline Color",
                "Timeline bar color.",
                colorGetter(self.db.class.gcdColor),
                colorSetter(self.db.class.gcdColor),
                { hasAlpha = true, order = 83 }
            ),
            sparkColor = OptionsFactory:CreateColor(
                "Spark Color",
                "Spark color for line markers.",
                colorGetter(self.db.class.sparkColor),
                colorSetter(self.db.class.sparkColor),
                { hasAlpha = true, order = 84 }
            ),
            debugSwingBarColor = OptionsFactory:CreateColor(
                "Debug Swing Bar Color",
                "Debug swing bar color.",
                colorGetter(self.db.class.debugSwingBarColor),
                colorSetter(self.db.class.debugSwingBarColor),
                { hasAlpha = true, order = 85 }
            ),
            debugSwingTextColor = OptionsFactory:CreateColor(
                "Debug Swing Text Color",
                "Debug swing text color.",
                colorGetter(self.db.class.debugSwingTextColor),
                colorSetter(self.db.class.debugSwingTextColor),
                { hasAlpha = true, order = 86 }
            ),
        }
    }
end
