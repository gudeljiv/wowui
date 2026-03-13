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

        -- Visual tuning
        sparkSmoothing = 0.3,
        sparkScale = 1.6,
        sparkOffsetY = 0,
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
        windupHighlightColor = { r = 0.20, g = 0.85, b = 0.35, a = 0.35 },
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
local windupHighlight
local earlyGapHighlight
local earlyGapHighlightWrap
local earlyGapMarkerLeft
local earlyGapMarkerRight
local gcdLandingMarker
local gcdLandingText
local gcdLandingFillerIcon
local steadyShotText

local UPDATE_INTERVAL = 0.016
local lastUpdate = 0

local DEFAULT_ICON_SIZE = 16
local MAX_SWING_SPARKS = 3

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
    if not swingSpeed or swingSpeed <= 0 then
        frame:Hide()
        return
    end

    local baseAlpha = db.alpha or 1.0
    frame:SetAlpha(baseAlpha)

    local nextIdentity = NAG and NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local nextSpellId = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
    local isRelevantNext = (nextSpellId == STEADY_SHOT_ID) or IsAimedShotSpellId(nextSpellId)
    local inCombat = UnitAffectingCombat("player")

    local width = db.width
    local autoX = width * AUTO_POSITION_RATIO
    local baseHeight = db.height
    local swingHeight = baseHeight + 5
    local barHeight = db.barHeight or 3
    local gcdGap = 6
    local gcdSparkHeight = 5

    local totalHeight = swingHeight + gcdGap + gcdSparkHeight
    frame:SetSize(width, totalHeight)

    local swingCenterY = (totalHeight / 2) - (swingHeight / 2)
    local barCenterY = swingCenterY + (db.barOffsetY or 0)

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
    if swingSpeed > 0 then
        segmentLeftXEarly = autoX + (thresholdSeconds / swingSpeed) * width
        if segmentLeftXEarly > width then
            segmentLeftXEarly = segmentLeftXEarly - width
        end
    end
    local earlyGapArcWidth = 0
    if swingSpeed > 0 then
        earlyGapArcWidth = width * ((swingSpeed - thresholdSeconds) / swingSpeed)
    end
    local earlyGapPossible = steadyKnown
        and swingSpeed > 0
        and thresholdSeconds < swingSpeed
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

    -- Wind-up zone: Auto at autoX; wind-up is [autoX, autoX + zoneWidth]. When early gap visible, show only right marker (complementary).
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
        local zoneWidth = (swingSpeed > 0) and ((windupSeconds / swingSpeed) * width) or 0
        if zoneWidth < 0 then zoneWidth = 0 end
        if zoneWidth > width then zoneWidth = width end
        local leftX = autoX
        local rightX = autoX + zoneWidth
        windupRightX = rightX
        local markerSize = db.targetMarkerSize or 20
        local markerOffsetX = db.targetMarkerOffsetX or 0
        local markerOffsetY = db.targetMarkerOffsetY or 0

        if not earlyGapVisible then
            windupMarkerLeft:SetSize(markerSize, markerSize)
            windupMarkerLeft:SetPoint(
                "LEFT",
                frame,
                "LEFT",
                leftX + markerOffsetX,
                barCenterY + markerOffsetY
            )
            windupMarkerLeft:Show()
        else
            windupMarkerLeft:Hide()
        end

        windupMarkerRight:SetSize(markerSize, markerSize)
        windupMarkerRight:SetPoint(
            "RIGHT",
            frame,
            "LEFT",
            rightX + markerOffsetX,
            barCenterY + markerOffsetY
        )
        windupMarkerRight:Show()

        windupHighlight:ClearAllPoints()
        windupHighlight:SetPoint("LEFT", frame, "LEFT", leftX, barCenterY)
        windupHighlight:SetSize(math.max(0, rightX - leftX), barHeight)
        windupHighlight:Show()
    else
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
                local segmentWidth = autoX - segmentLeftXEarly
                earlyGapHighlight:SetPoint("LEFT", frame, "LEFT", segmentLeftXEarly, barCenterY)
                earlyGapHighlight:SetSize(segmentWidth, barHeight)
                earlyGapHighlight:Show()
                if earlyGapHighlightWrap then
                    earlyGapHighlightWrap:Hide()
                end
            else
                local segmentWidth = width - segmentLeftXEarly
                earlyGapHighlight:SetPoint("LEFT", frame, "LEFT", segmentLeftXEarly, barCenterY)
                earlyGapHighlight:SetSize(segmentWidth, barHeight)
                earlyGapHighlight:Show()
                if earlyGapHighlightWrap then
                    earlyGapHighlightWrap:ClearAllPoints()
                    earlyGapHighlightWrap:SetPoint("LEFT", frame, "LEFT", 0, barCenterY)
                    earlyGapHighlightWrap:SetSize(autoX, barHeight)
                    earlyGapHighlightWrap:Show()
                end
            end

            local markerSize = db.targetMarkerSize or 20
            local markerOffsetX = db.targetMarkerOffsetX or 0
            local markerOffsetY = db.targetMarkerOffsetY or 0

            if earlyGapMarkerLeft then
                earlyGapMarkerLeft:SetSize(markerSize, markerSize)
                earlyGapMarkerLeft:SetPoint(
                    "LEFT",
                    frame,
                    "LEFT",
                    segmentLeftXEarly + markerOffsetX,
                    barCenterY + markerOffsetY
                )
                earlyGapMarkerLeft:Show()
            end
            if earlyGapMarkerRight then
                earlyGapMarkerRight:Hide()
            end
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
            xB = xB + width
        end
        local midX = (xA + xB) * 0.5
        if midX > width then
            midX = midX - width
        end
        steadyShotText:ClearAllPoints()
        steadyShotText:SetPoint("CENTER", frame, "LEFT", midX, barCenterY + markerOffsetY)
        steadyShotText:SetText("")--Steady\nShot
        steadyShotText:SetTextColor(0.05, 0.35, 0.05, 0.8)
        steadyShotText:Show()
    elseif steadyShotText then
        steadyShotText:Hide()
    end

    -- Swing bars: countdown (autoX=Auto, right=NOW).
    local timeToSwing = rawSwingLeft or 0
    if timeToSwing < 0 then timeToSwing = 0 end
    if timeToSwing > swingSpeed then timeToSwing = swingSpeed end

    local sparkTargetX = width
    if swingSpeed > 0 then
        sparkTargetX = ((AUTO_POSITION_RATIO + (timeToSwing / swingSpeed)) % 1) * width
    end
    if sparkTargetX < 0 then sparkTargetX = 0 end
    if sparkTargetX > width then sparkTargetX = width end

    -- Independent GCD/SS-cast landing marker:
    -- place a small downward arrow above the bar where lockout ends, using:
    -- lockoutRemaining = max(gcdRemaining, steadyCastRemainingIfCastingSS).
    local gcdLandingX = nil
    if gcdLandingMarker then
        local gcdRemaining = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
        if gcdRemaining < 0 then gcdRemaining = 0 end

        local ssCastRemaining = 0
        local _, _, _, _, endTimeMS, _, _, _, castingSpellId = UnitCastingInfo("player")
        if castingSpellId == STEADY_SHOT_ID and endTimeMS then
            ssCastRemaining = (endTimeMS / 1000) - GetTime()
            if ssCastRemaining < 0 then ssCastRemaining = 0 end
        end

        local lockoutRemaining = gcdRemaining
        if ssCastRemaining > lockoutRemaining then
            lockoutRemaining = ssCastRemaining
        end

        if lockoutRemaining > 0 and swingSpeed > 0 then
            local landingTtn = timeToSwing - lockoutRemaining
            -- If lockout ends after the current swing boundary, wrap into next swing cycle(s)
            -- so the marker shows the actual future landing position instead of clamping left.
            while landingTtn < 0 do
                landingTtn = landingTtn + swingSpeed
            end
            local landingX = ((AUTO_POSITION_RATIO + Clamp01(landingTtn / swingSpeed)) % 1) * width
            gcdLandingX = landingX
            local sparkHeight = math.max(3, math.floor((db.targetMarkerSize or 20) * 0.275))
            local sparkHeightDoubled = sparkHeight * 2
            local sparkTopY = barCenterY + (sparkHeight / 2)
            -- Ret-style spark: simple vertical line (no custom image), aligned with the bar lane.
            gcdLandingMarker:SetSize(2, sparkHeightDoubled)
            gcdLandingMarker:ClearAllPoints()
            gcdLandingMarker:SetPoint("TOP", frame, "LEFT", landingX, sparkTopY)
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
    local elapsedWidth = width - sparkTargetX

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
    -- - If `showSteadySpark` is enabled: show both Steady + Aimed icons as a pure timing aid.
    -- - If disabled: hide icons until Steady/Aimed is the next recommended spell, then show ONLY that one.
    if not inCombat then
        if frame.sparks then
            if frame.sparks[1] then frame.sparks[1]:Hide() end
            if frame.sparks[2] then frame.sparks[2]:Hide() end
            if frame.sparks[3] then frame.sparks[3]:Hide() end
        end
        if gcdLandingFillerIcon then
            gcdLandingFillerIcon:Hide()
        end
    elseif frame.sparks and #frame.sparks > 0 then
        local targetX = sparkTargetX or width
        local sparkScale = db.sparkScale or 1.6
        local iconSize = math.floor(DEFAULT_ICON_SIZE * sparkScale)
        local sep = math.floor(iconSize * 0.55)

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

        local function updateSpark(idx, iconTexture, yOffset, shouldShow)
            local sFrame = frame.sparks[idx]
            if not sFrame then
                return
            end
            if not shouldShow then
                sFrame:Hide()
                return
            end
            if not sFrame.currentX or targetX >= sFrame.currentX then
                sFrame.currentX = targetX
            else
                sFrame.currentX = sFrame.currentX + (targetX - sFrame.currentX) * (db.sparkSmoothing or 0.3)
            end
            sFrame.icon:SetTexture(iconTexture)
            sFrame:SetSize(iconSize, iconSize)
            sFrame:ClearAllPoints()
            sFrame:SetPoint("CENTER", frame, "LEFT", sFrame.currentX, swingCenterY + (db.sparkOffsetY or 0) + yOffset)
            sFrame:Show()
        end

        local fillerIconTexture = nil
        if db.showSteadySpark then
            updateSpark(1, steadyIcon, sep, NAG.SpellIsKnown and NAG:SpellIsKnown(STEADY_SHOT_ID))
            updateSpark(2, aimedIcon, -sep, NAG.SpellIsKnown and NAG:SpellIsKnown(AIMED_SHOT_ID))
            updateSpark(3, multiIcon, 0, false)
        else
            local showSteady = isRelevantNext and nextSpellId == STEADY_SHOT_ID and (NAG.SpellIsKnown and NAG:SpellIsKnown(STEADY_SHOT_ID))
            local showAimed = isRelevantNext and IsAimedShotSpellId(nextSpellId) and (NAG.SpellIsKnown and NAG:SpellIsKnown(AIMED_SHOT_ID))
            local showMulti = IsMultiShotSpellId(nextSpellId) and (NAG.SpellIsKnown and NAG:SpellIsKnown(MULTI_SHOT_ID))
            local showArcane = IsArcaneShotSpellId(nextSpellId) and (NAG.SpellIsKnown and NAG:SpellIsKnown(ARCANE_SHOT_ID))
            if showSteady then
                updateSpark(1, steadyIcon, 0, true)
                updateSpark(2, aimedIcon, 0, false)
                updateSpark(3, multiIcon, 0, false)
            elseif showAimed then
                updateSpark(1, aimedIcon, 0, true)
                updateSpark(2, aimedIcon, 0, false)
                updateSpark(3, multiIcon, 0, false)
            elseif showMulti then
                updateSpark(1, steadyIcon, 0, false)
                updateSpark(2, aimedIcon, 0, false)
                updateSpark(3, multiIcon, 0, true)
                fillerIconTexture = multiIcon
            elseif showArcane then
                updateSpark(1, steadyIcon, 0, false)
                updateSpark(2, aimedIcon, 0, false)
                updateSpark(3, arcaneIcon, 0, true)
                fillerIconTexture = arcaneIcon
            else
                updateSpark(1, steadyIcon, 0, false)
                updateSpark(2, aimedIcon, 0, false)
                updateSpark(3, multiIcon, 0, false)
            end
        end

        -- Filler target icon: gray 60% round icon at GCD tick marker when MS/AR spark is active.
        if gcdLandingFillerIcon then
            if fillerIconTexture and gcdLandingX then
                gcdLandingFillerIcon.icon:SetTexture(fillerIconTexture)
                gcdLandingFillerIcon.icon:SetDesaturated(true)
                gcdLandingFillerIcon.icon:SetAlpha(0.6)
                gcdLandingFillerIcon:SetSize(iconSize, iconSize)
                gcdLandingFillerIcon:ClearAllPoints()
                gcdLandingFillerIcon:SetPoint("CENTER", frame, "LEFT", gcdLandingX, barCenterY)
                gcdLandingFillerIcon:Show()
            else
                gcdLandingFillerIcon:Hide()
            end
        end
    else
        if frame.sparks then
            if frame.sparks[1] then frame.sparks[1]:Hide() end
            if frame.sparks[2] then frame.sparks[2]:Hide() end
            if frame.sparks[3] then frame.sparks[3]:Hide() end
        end
        if gcdLandingFillerIcon then
            gcdLandingFillerIcon:Hide()
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
    if self.Print then
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
    earlyGapMarkerLeft:SetTexture("Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrowL.png")
    earlyGapMarkerLeft:SetSize(db.targetMarkerSize or 20, db.targetMarkerSize or 20)
    earlyGapMarkerLeft:Hide()

    earlyGapMarkerRight = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    earlyGapMarkerRight:SetTexture("Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrowR.png")
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
    gcdLandingFillerIcon:Hide()

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

    windupMarkerLeft = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    windupMarkerLeft:SetTexture("Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrowL.png")
    windupMarkerLeft:SetSize(db.targetMarkerSize or 20, db.targetMarkerSize or 20)
    windupMarkerLeft:Hide()

    windupMarkerRight = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    windupMarkerRight:SetTexture("Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrowR.png")
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
            sparkFrame:Hide()
            frame.sparks[i] = sparkFrame
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
                self:UpdateDisplay()
            end
        end)
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_STOP", function(_, unitId, hand)
            if unitId == "player" and hand == "ranged" and self.UpdateDisplay then
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
end

module.eventHandlers = {
    PLAYER_ENTERING_WORLD = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
}

function module:PLAYER_ENTERING_WORLD()
    self:UpdateVisibility()
end

function module:PLAYER_REGEN_DISABLED()
    self:UpdateVisibility()
end

function module:PLAYER_REGEN_ENABLED()
    self:UpdateVisibility()
end

function module:PLAYER_TARGET_CHANGED()
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
