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
local ChatCommandUtils = ns.ChatCommandUtils
local AceConfig = ns.AceConfig
local AceConfigDialog = ns.AceConfigDialog

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        hideOutOfCombat = false,

        -- Positioning
        autoAnchor = true,
        lockToNagAnchor = true,
        point = "CENTER",
        x = 120,
        y = 30,

        -- Dimensions
        width = 180,
        height = 6,
        barHeight = 1,
        barOffsetY = -1,
        alpha = 1.0,

        -- Visual toggles
        showBackground = true,
        showTimelineBar = false,
        showBgArt = true,
        showNowMarker = false,
        showDebugSwingBar = false,
        showDebugSwingText = false,
        showSwingBars = true,
        showSwingSpark = false,
        showSteadySpark = false,
        showSegmentDividers = false,
        showSegmentDebugLogs = false,

        -- Visual tuning
        sparkSmoothing = 0.3,
        sparkScale = 1.6,
        sparkOffsetY = 0,
        forceSegmentCount = 0, -- 0 = auto
        maxDynamicSegments = 4,
        -- NOW marker edges (both relative to the frame RIGHT edge)
        -- This allows tuning left/right sides independently (instead of width-only).
        nowMarkerOuterLeftOffsetX = -3,
        nowMarkerOuterRightOffsetX = 0,
        nowMarkerInnerLeftOffsetX = -1,
        nowMarkerInnerRightOffsetX = 0,
        nowMarkerOffsetY = -9,
        bgArtWidth = 207,
        bgArtHeight = 20,
        bgArtAlpha = 1,
        bgArtOffsetX = -7,
        bgArtOffsetY = 5,
        debugSwingBarHeight = 10,
        debugSwingBarOffsetY = -14,
        debugSwingFontSize = 10,
        showTargetMarker = true,
        targetMarkerSeconds = 0.5,
        targetMarkerSize = 31,
        targetMarkerOffsetX = -1,
        targetMarkerOffsetY = 0,
        forceShowEarlyGapForTesting = false,

        -- Colors
        swingColor = { r = 0.30, g = 0.75, b = 0.30, a = 0.0 },
        gcdColor = { r = 0.40, g = 0.40, b = 0.40, a = 0.95 },
        backgroundColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.35 },
        sparkColor = { r = 0.9, g = 0.9, b = 0.9, a = 0.9 },
        debugSwingBarColor = { r = 0.15, g = 0.15, b = 0.15, a = 0.85 },
        debugSwingTextColor = { r = 1.0, g = 1.0, b = 1.0, a = 0.9 },
        windupHighlightColor = { r = 0.75, g = 0.98, b = 0.75, a = 0.35 },
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
local DEFAULT_EFFECTIVE_GCD = 1.5
local MIN_SEGMENT_COUNT = 2
local FILLER_MIN_SWING_SECONDS = 1.7
local SEGMENT_DEBUG_PRINT_INTERVAL = 0.02
local LEFT_OF_GCD_SPARK_ALPHA = 0.30

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
    if not frame or not swingSpark then
        self:CreateFrameUI()
        if not frame or not swingSpark then
            return
        end
    end

    local db = self.db.class
    -- In edit mode: force visible for positioning - check FIRST so bars stay visible when unlocked
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:Show()
        frame:EnableMouse(true)
        self:UpdateFrameAnchor()
        local baseAlpha = db.alpha or 1.0
        frame:SetAlpha(baseAlpha)
        frame:SetScript("OnUpdate", function(_, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                self:UpdateDisplay()
                lastUpdate = 0
            end
        end)
        return
    end

    -- Only show the bar when the rotation explicitly enables it (gate).
    if NAG.IsTBCHunterSteadyBarsEnabled and not NAG:IsTBCHunterSteadyBarsEnabled() then
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end

    if db.hideOutOfCombat and not UnitAffectingCombat("player") then
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
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
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
    if not frame or not swingSpark then
        self:CreateFrameUI()
        if not frame or not swingSpark then
            return
        end
    end
    -- In edit mode, visibility is managed by UpdateVisibility - never hide so user can position
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        return
    end
    local db = self.db.class
    if NAG.IsTBCHunterSteadyBarsEnabled and not NAG:IsTBCHunterSteadyBarsEnabled() then
        frame:Hide()
        return
    end
    if db.hideOutOfCombat and not UnitAffectingCombat("player") then return end

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
            gcdLandingFillerIcon.icon:SetDesaturated(true)
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

function module:HandleEarlyGapSlashCommand()
    if not (self.db and self.db.class) then
        return
    end
    local enabled = self.db.class.forceShowEarlyGapForTesting and true or false
    enabled = not enabled
    self.db.class.forceShowEarlyGapForTesting = enabled
    if self.Print and IsDevModeEnabled() then
        self:Print(string.format("Hunter early-gap force-visibility: %s", enabled and "ON" or "OFF"))
    end
    if frame then
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
    frame:Hide()
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
    frame:SetScript("OnDragStart", function()
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if not canDrag or (UnitAffectingCombat and UnitAffectingCombat("player")) then
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
    gcdLandingFillerIcon.icon:SetDesaturated(true)
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
function module:ModuleInitialize()
    self:RegisterSteadyOptions()
    if ChatCommandUtils then
        ChatCommandUtils.RegisterCommand(self, "naghuntersteady", "HandleSteadySlashCommand", "Open Hunter Steady Weave bar tuning window.")
        ChatCommandUtils.RegisterCommand(self, "naghunter", "HandleSteadySlashCommand", "Open Hunter Steady Weave bar tuning window.")
        ChatCommandUtils.RegisterCommand(self, "naghunterearlygap", "HandleEarlyGapSlashCommand", "Toggle force-visibility for Hunter early-gap segment.")
        ChatCommandUtils.RegisterCommand(self, "nagearlygap", "HandleEarlyGapSlashCommand", "Toggle force-visibility for Hunter early-gap segment.")
    end
    if swingTimerLib and swingTimerLib.RegisterCallback then
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_START", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" and hand == "ranged" and self.UpdateDisplay then
                if speed and speed > 0 then
                    lastKnownRangedSwingSpeed = speed
                end
                self:UpdateDisplay()
            end
        end)
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_STOP", function(_, unitId, hand)
            if unitId == "player" and hand == "ranged" and self.UpdateDisplay then
                lockedSegmentCount = nil
                self:UpdateDisplay()
            end
        end)
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_UPDATE", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" and hand == "ranged" and speed and speed > 0 and self.UpdateDisplay then
                lastKnownRangedSwingSpeed = speed
                self:RefreshLockedSegmentCount()
                self:UpdateDisplay()
            end
        end)
    end
end

function module:ModuleEnable()
    if UnitClassBase("player") ~= "HUNTER" then
        self:SetEnabledState(false)
        return
    end
    self:CreateFrameUI()
    self:UpdateVisibility()
end

function module:ModuleDisable()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
    lockedSegmentCount = nil
    lastKnownRangedSwingSpeed = nil
end

module.eventHandlers = {
    PLAYER_ENTERING_WORLD = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
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
    self:UpdateDisplay()
end

function module:UNIT_SPELLCAST_START(event, unit, castGUID, spellId)
    if unit ~= "player" then
        return
    end
    if spellId ~= STEADY_SHOT_ID then
        return
    end
    self:RefreshLockedSegmentCount()
    self:UpdateDisplay()
end

-- ============================ OPTIONS ============================
function module:GetOptions()
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
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
