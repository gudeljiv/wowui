--- @module "NAG.WarriorSlamWeaveBar"
--- Visual swing + GCD + Slam-weave timing bar for validating Arms Slam weaving.
---
--- Shows:
--- - Swing timeline (spark) + short history region
--- - GCD overlay lane
--- - Pre-swing HOLD region (where spending a full GCD would overlap the next swing)
--- - Post-swing Slam-now region (first X seconds after last swing)
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
local UnitCastingInfo = _G.UnitCastingInfo

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
        x = 103,
        y = 30,

        -- Dimensions
        width = 220,
        height = 6,
        barHeight = 1,
        barOffsetY = 0,
        alpha = 1.0,

        -- Visual toggles
        showBackground = true,
        showTimelineBar = false,
        showBgArt = true,
        showNowMarker = false,
        showDebugSwingBar = false,
        showDebugSwingText = true,
        showSwingBars = true,
        showSwingSpark = true,
        showSlamSpark = true,
        showKeybindOnBar = false,

        -- Visual tuning
        sparkSmoothing = 0.3,
        sparkScale = 1.6,
        sparkOffsetY = 0,
        nowMarkerWidth = 3,
        nowMarkerInnerWidth = 1,
        nowMarkerOffsetY = 0,
        bgArtWidth = 224,
        bgArtHeight = 33,
        bgArtAlpha = 1,
        bgArtOffsetX = -25,
        bgArtOffsetY = 6,
        debugSwingBarHeight = 10,
        debugSwingBarOffsetY = -14,
        debugSwingFontSize = 10,
        showTargetMarker = true,
        targetMarkerSeconds = 0.25,
        targetMarkerSize = 35,
        targetMarkerOffsetX = 0,
        targetMarkerOffsetY = 0,

        -- Colors
        swingColor = { r = 0.30, g = 0.75, b = 0.30, a = 0.0 }, -- invisible positioning bar
        gcdColor = { r = 0.40, g = 0.40, b = 0.40, a = 0.95 },
        backgroundColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.35 },
        sparkColor = { r = 0.9, g = 0.9, b = 0.9, a = 0.9 },
        debugSwingBarColor = { r = 0.15, g = 0.15, b = 0.15, a = 0.85 },
        debugSwingTextColor = { r = 1.0, g = 1.0, b = 1.0, a = 0.9 },
    }
}

--- @class WarriorSlamWeaveBar:CoreModule
local WarriorSlamWeaveBar = NAG:CreateModule("WarriorSlamWeaveBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "WARRIOR",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    messageHandlers = { NAG_FRAME_UPDATED = true, NAG_WARRIOR_BAR_SCALE_UPDATED = true },
    hidden = function()
        return UnitClassBase("player") ~= "WARRIOR"
    end,
})

ns.WarriorSlamWeaveBar = WarriorSlamWeaveBar
local module = WarriorSlamWeaveBar
local SLAM_OPTIONS_NAME = "NAGSlamWeave"

-- ============================ LOCALS ============================
local frame
local background
local swingBar
local pastSwingBar
local gcdBar
local swingSpark
local gcdSpark
local gcdSparkLeft
local slamPressMarker
local slamOutcomeText
local timelineBar
local bgArt
local nowMarker
local nowMarkerInner
local debugSwingBar
local debugSwingText
local targetMarker

local UPDATE_INTERVAL = 0.016 -- ~60fps
local lastUpdate = 0

local DEFAULT_ICON_SIZE = 16
local MAX_SWING_SPARKS = 1
local SLAM_PRESS_SECONDS = 0.20

-- Background art (PrePull-style)
local BG_ART_TEXTURE = "Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarCD.png"

-- ============================ HELPERS ============================
local function Clamp01(x)
    if x < 0 then return 0 end
    if x > 1 then return 1 end
    return x
end

--- Smooth toward target without snapping.
--- @param currentX number|nil
--- @param targetX number
--- @param smoothing number
--- @return number
local function SmoothToward(currentX, targetX, smoothing)
    if not currentX then
        return targetX
    end
    return currentX + (targetX - currentX) * smoothing
end

local function GetMainhandSwing()
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        local speed, expiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
        if speed and expiration then
            return math.max(0, expiration - GetTime()), speed
        end
    end
    return 0, 0
end

local function IsSlamSpellId(spellId)
    if not spellId then
        return false
    end
    if NAG and NAG.WarriorSlamWeaveIsSlamSpellId then
        return NAG:WarriorSlamWeaveIsSlamSpellId(spellId)
    end
    local slamId = NAG and NAG.WarriorSlamWeaveGetSlamId and NAG:WarriorSlamWeaveGetSlamId() or nil
    return slamId and spellId == slamId or false
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

--- Adjust swing timers while Slam is casting (swing reset happens at cast end).
--- @param swingSpeed number
--- @param rawSwingLeft number
--- @param slamId number|nil
--- @param slamCastEndTime number|nil
--- @param now number
--- @param graceSeconds number
--- @return number, number
local function GetAdjustedSwingTimes(swingSpeed, rawSwingLeft, slamId, slamCastEndTime, now, graceSeconds)
    local timeToNext = rawSwingLeft or 0
    local timeToSecond = timeToNext + (swingSpeed or 0)
    if not slamId or not UnitCastingInfo then
        return timeToNext, timeToSecond
    end

    local _, _, _, _, endTimeMs, _, _, _, castingSpellId = UnitCastingInfo("player")
    if castingSpellId and castingSpellId == slamId and endTimeMs then
        local remaining = (endTimeMs / 1000) - now
        if remaining < 0 then remaining = 0 end
        timeToNext = remaining + (swingSpeed or 0)
        timeToSecond = timeToNext + (swingSpeed or 0)
        return timeToNext, timeToSecond
    end

    if slamCastEndTime and graceSeconds and now <= (slamCastEndTime + graceSeconds) then
        local predicted = (slamCastEndTime + (swingSpeed or 0)) - now
        if predicted > timeToNext then
            timeToNext = predicted
            timeToSecond = timeToNext + (swingSpeed or 0)
            return timeToNext, timeToSecond
        end
    end

    return timeToNext, timeToSecond
end

--- Effective scale for Warrior bar frame: NAG display scale * universal Warrior bar scale.
local function GetWarriorBarEffectiveScale()
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local nagScale = (anchor and anchor ~= _G.UIParent and anchor:GetScale()) or 1
    local wm = NAG:GetModule("WarriorSlamWeaveModule", true)
    local barScale = (wm and wm.GetWarriorBarScale and wm:GetWarriorBarScale()) or 1
    return nagScale * barScale
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
        frame:SetScale(GetWarriorBarEffectiveScale())
        return
    end

    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    if not anchor or anchor == _G.UIParent then
        frame:SetParent(_G.UIParent)
        frame:ClearAllPoints()
        frame:SetPoint(db.point, db.x, db.y)
        frame:SetScale(GetWarriorBarEffectiveScale())
        return
    end

    -- Keep frame on UIParent so we don't affect the main frame (e.g. floating selector position)
    frame:SetParent(_G.UIParent)
    frame:ClearAllPoints()
    frame:SetPoint("TOP", anchor, "BOTTOM", db.x, db.y)
    frame:SetScale(GetWarriorBarEffectiveScale())
end

function module:NAG_FRAME_UPDATED()
    if frame then
        self:UpdateVisibility()
    end
end

function module:NAG_WARRIOR_BAR_SCALE_UPDATED()
    self:UpdateFrameAnchor()
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
        if self._barDimmed then
            frame:SetAlpha(baseAlpha * 0.5)
        else
            frame:SetAlpha(baseAlpha)
        end
        frame:SetScript("OnUpdate", function(_, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                self:UpdateDisplay()
                lastUpdate = 0
            end
        end)
        return
    end

    if NAG.IsTBCWarriorBarsEnabled and not NAG:IsTBCWarriorBarsEnabled() then
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
    frame:EnableMouse(false)
    self:UpdateFrameAnchor()
    local baseAlpha = db.alpha or 1.0
    if self._barDimmed then
        frame:SetAlpha(baseAlpha * 0.5)
    else
        frame:SetAlpha(baseAlpha)
    end
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
    local isDimmed = self._barDimmed == true
    if NAG.IsTBCWarriorBarsEnabled and not NAG:IsTBCWarriorBarsEnabled() then return end
    if db.hideOutOfCombat and not UnitAffectingCombat("player") then return end

    local rawSwingLeft, swingSpeed = GetMainhandSwing()
    if not swingSpeed or swingSpeed <= 0 then
        local _, raw = NAG:AutoTimeToNext()
        rawSwingLeft = raw or 0
        swingSpeed = NAG:AutoSwingTime() or 0
    end
    if not swingSpeed or swingSpeed <= 0 then
        frame:Hide()
        return
    end

    local now = GetTime()
    local slamId = NAG.WarriorSlamWeaveGetSlamId and NAG:WarriorSlamWeaveGetSlamId() or nil
    local graceSeconds = SLAM_PRESS_SECONDS
    local adjustedTimeToNext = GetAdjustedSwingTimes(
        swingSpeed,
        rawSwingLeft,
        slamId,
        self._slamCastEndTime,
        now,
        graceSeconds
    )
    rawSwingLeft = adjustedTimeToNext

    local width = db.width
    local baseHeight = db.height
    local swingHeight = baseHeight + 5
    local barHeight = db.barHeight or 3
    local gcdHeight = 2
    local gcdGap = 6
    local gcdSparkHeight = 5

    local totalHeight = swingHeight + gcdGap + gcdSparkHeight
    frame:SetSize(width, totalHeight)

    local pixelsPerSecond = 0
    if width > 0 and swingSpeed > 0 then
        pixelsPerSecond = width / swingSpeed
    end
    local swingCenterY = (totalHeight / 2) - (swingHeight / 2)
    local barCenterY = swingCenterY + (db.barOffsetY or 0)
    local gcdCenterY = swingCenterY - (swingHeight / 2) - gcdGap - (gcdHeight / 2)

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
        nowMarker:SetPoint("RIGHT", frame, "RIGHT", 0, barCenterY + (db.nowMarkerOffsetY or 0))
        nowMarker:SetWidth(db.nowMarkerWidth or 2)
        nowMarker:SetHeight(barHeight)
        nowMarker:Show()
    elseif nowMarker then
        nowMarker:Hide()
    end

    if nowMarkerInner and db.showNowMarker then
        nowMarkerInner:SetPoint("RIGHT", frame, "RIGHT", 0, barCenterY + (db.nowMarkerOffsetY or 0))
        nowMarkerInner:SetWidth(db.nowMarkerInnerWidth or 1)
        nowMarkerInner:SetHeight(barHeight)
        nowMarkerInner:Show()
    elseif nowMarkerInner then
        nowMarkerInner:Hide()
    end

    local halfWidth = width * 0.5
    local halfSwing = swingSpeed * 0.5

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

    if targetMarker and db.showTargetMarker then
        local targetSeconds = db.targetMarkerSeconds or 0.20
        local targetX = halfWidth - (halfWidth * (halfSwing > 0 and (targetSeconds / halfSwing) or 0))
        targetMarker:SetSize(db.targetMarkerSize or 20, db.targetMarkerSize or 20)
        targetMarker:SetPoint(
            "CENTER",
            frame,
            "LEFT",
            targetX + (db.targetMarkerOffsetX or 0),
            barCenterY + (db.targetMarkerOffsetY or 0)
        )
        targetMarker:Show()
    elseif targetMarker then
        targetMarker:Hide()
    end

    -- Swing bars: future (right) + past (left) halves around center.
    local timeToSwing = rawSwingLeft or 0
    if timeToSwing < 0 then timeToSwing = 0 end
    if timeToSwing > swingSpeed then timeToSwing = swingSpeed end
    local timeSinceSwing = swingSpeed - timeToSwing
    if timeSinceSwing < 0 then timeSinceSwing = 0 end

    local futureSeconds = math.min(timeToSwing, halfSwing)
    local pastSeconds = math.min(timeSinceSwing, halfSwing)
    local futureWidth = (halfSwing > 0) and (halfWidth * (futureSeconds / halfSwing)) or 0
    local pastWidth = (halfSwing > 0) and (halfWidth * (pastSeconds / halfSwing)) or 0

    if db.showSwingBars then
        swingBar:ClearAllPoints()
        swingBar:SetPoint("LEFT", frame, "LEFT", halfWidth, swingCenterY)
        local currentWidth = swingBar:GetWidth()
        if futureWidth < currentWidth then
            swingBar:SetWidth(currentWidth + (futureWidth - currentWidth) * 0.3)
        else
            swingBar:SetWidth(futureWidth)
        end
        swingBar:SetHeight(swingHeight)
        swingBar:Show()

        if pastSwingBar then
            pastSwingBar:ClearAllPoints()
            pastSwingBar:SetPoint("RIGHT", frame, "LEFT", halfWidth, swingCenterY)
            local pastCurrentWidth = pastSwingBar:GetWidth()
            if pastWidth < pastCurrentWidth then
                pastSwingBar:SetWidth(pastCurrentWidth + (pastWidth - pastCurrentWidth) * 0.3)
            else
                pastSwingBar:SetWidth(pastWidth)
            end
            pastSwingBar:SetHeight(swingHeight)
            pastSwingBar:Show()
        end
    else
        if swingBar then swingBar:Hide() end
        if pastSwingBar then pastSwingBar:Hide() end
    end

    -- Swing spark: right-to-left on past half, then instant jump to future half.
    local sparkTargetX
    if timeSinceSwing <= halfSwing then
        sparkTargetX = halfWidth - (halfWidth * (halfSwing > 0 and (pastSeconds / halfSwing) or 0))
    else
        sparkTargetX = halfWidth + (halfWidth * (halfSwing > 0 and (futureSeconds / halfSwing) or 0))
    end
    if db.showSwingSpark then
        swingSpark:SetSize(2, swingHeight)
        swingSpark:ClearAllPoints()
        swingSpark:SetPoint("CENTER", frame, "LEFT", sparkTargetX, swingCenterY)
        if isDimmed then
            swingSpark:Hide()
        else
            swingSpark:Show()
        end
    else
        swingSpark:Hide()
    end

    -- GCD lane (hidden by request)
    gcdBar:Hide()
    gcdSpark:Hide()
    if gcdSparkLeft then
        gcdSparkLeft:Hide()
    end

    -- Slam press marker + toast removed (core elements only)

    -- Slam spark icon (shaman-style: follow swing spark)
    if frame.sparks and #frame.sparks > 0 and db.showSlamSpark then
        local slamId = NAG.WarriorSlamWeaveGetSlamId and NAG:WarriorSlamWeaveGetSlamId() or nil
        local iconTexture = (slamId and NAG.Spell and NAG.Spell[slamId] and NAG.Spell[slamId].icon)
            or (slamId and GetSpellTexture and GetSpellTexture(slamId))
            or "Interface\\Icons\\INV_Misc_QuestionMark"

        local sFrame = frame.sparks[1]
        if sFrame then
            if isDimmed then
                SetSparkKeybind(sFrame, false)
                sFrame:Hide()
            else
            sFrame.spellId = slamId
            local targetX = sparkTargetX or (width * 0.5)
            if not sFrame.currentX or targetX >= sFrame.currentX then
                sFrame.currentX = targetX
            else
                sFrame.currentX = sFrame.currentX + (targetX - sFrame.currentX) * (db.sparkSmoothing or 0.3)
            end
            sFrame.icon:SetTexture(iconTexture)
            local sparkScale = db.sparkScale or 1.6
            sFrame:SetSize(math.floor(DEFAULT_ICON_SIZE * sparkScale), math.floor(DEFAULT_ICON_SIZE * sparkScale))
            sFrame:ClearAllPoints()
            sFrame:SetPoint("CENTER", frame, "LEFT", sFrame.currentX, swingCenterY + (db.sparkOffsetY or 0))
            sFrame:Show()
            SetSparkKeybind(sFrame, db.showKeybindOnBar)
            end
        end
    else
        if frame.sparks and frame.sparks[1] then
            SetSparkKeybind(frame.sparks[1], false)
            frame.sparks[1]:Hide()
        end
    end
end

-- ============================ SLASH OPTIONS ============================
function module:RegisterSlamOptions()
    if self._slamOptionsRegistered then
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
        AceConfig:RegisterOptionsTable(SLAM_OPTIONS_NAME, options)
        AceConfigDialog:SetDefaultSize(SLAM_OPTIONS_NAME, 720, 780)
        self._slamOptionsRegistered = true
    end
end

function module:ToggleSlamOptions()
    self:RegisterSlamOptions()
    if not AceConfigDialog then
        return
    end
    if AceConfigDialog.OpenFrames and AceConfigDialog.OpenFrames[SLAM_OPTIONS_NAME] then
        AceConfigDialog:Close(SLAM_OPTIONS_NAME)
    else
        AceConfigDialog:Open(SLAM_OPTIONS_NAME)
    end
end

function module:HandleSlamSlashCommand()
    self:ToggleSlamOptions()
end

-- ============================ UI BUILD ============================
function module:CreateFrameUI()
    if frame then return end

    OptionsFactory = NAG:GetModule("OptionsFactory")
    local db = self.db.class

    frame = CreateFrame("Frame", "NAGWarriorSlamWeaveBar", _G.UIParent)
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
            -- Stay on UIParent; position relative to anchor
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
                frame:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", left, bottom)
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

    targetMarker = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    targetMarker:SetTexture("Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrow.png")
    targetMarker:SetSize(db.targetMarkerSize or 20, db.targetMarkerSize or 20)
    targetMarker:Hide()

    swingBar = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    swingBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    swingBar:SetWidth(0)
    swingBar:SetColorTexture(db.swingColor.r, db.swingColor.g, db.swingColor.b, db.swingColor.a)

    pastSwingBar = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    pastSwingBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    pastSwingBar:SetWidth(0)
    pastSwingBar:SetColorTexture(db.swingColor.r, db.swingColor.g, db.swingColor.b, db.swingColor.a)

    slamPressMarker = nil
    slamOutcomeText = nil

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

end

-- ============================ LIFECYCLE ============================
function module:ModuleInitialize()
    -- No heavy work; UI built lazily.
    self:RegisterSlamOptions()
    if ChatCommandUtils then
        ChatCommandUtils.RegisterCommand(self, "nagslam", "HandleSlamSlashCommand", "Open Slam Weave tuning window.")
    end
    if swingTimerLib and swingTimerLib.RegisterCallback then
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_START", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" and hand == "mainhand" and self.UpdateDisplay then
                self:UpdateDisplay()
            end
        end)
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_STOP", function(_, unitId, hand)
            if unitId == "player" and hand == "mainhand" and self.UpdateDisplay then
                self:UpdateDisplay()
            end
        end)
    end
end

function module:ModuleEnable()
    if UnitClassBase("player") ~= "WARRIOR" then
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

-- Declarative event registration (visibility refresh)
module.eventHandlers = {
    PLAYER_ENTERING_WORLD = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
    UNIT_SPELLCAST_START = true,
    UNIT_SPELLCAST_SUCCEEDED = true,
    UNIT_SPELLCAST_INTERRUPTED = true,
    UNIT_SPELLCAST_STOP = true,
    UNIT_SPELLCAST_FAILED = true,
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

function module:UNIT_SPELLCAST_START(event, unit, castGUID, spellId)
    if unit ~= "player" then
        return
    end
    local isSlam = IsSlamSpellId(spellId)
    if UnitCastingInfo then
        local _, _, _, startTimeMs, endTimeMs, _, _, _, castSpellId = UnitCastingInfo("player")
        if not isSlam and castSpellId then
            isSlam = IsSlamSpellId(castSpellId)
        end
        if isSlam then
            self._slamCastDetectedTime = GetTime()
            if startTimeMs then
                self._slamCastStartTime = startTimeMs / 1000
            else
                self._slamCastStartTime = self._slamCastDetectedTime
            end
            if endTimeMs then
                self._slamCastEndTime = endTimeMs / 1000
            end
        end
    end
    if frame then
        self:UpdateDisplay()
    end
end

function module:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellId)
    if unit ~= "player" then
        return
    end
    if IsSlamSpellId(spellId) then
        self._slamCastEndTime = nil
        self._slamCastFinishTime = GetTime()
        if not self._slamCastDetectedTime or self._slamCastDetectedTime <= 0 then
            self._slamCastDetectedTime = GetTime()
        end
        if not self._slamCastStartTime or self._slamCastStartTime <= 0 then
            self._slamCastStartTime = self._slamCastDetectedTime
        end
    end
    if frame then
        self:UpdateDisplay()
    end
end

function module:UNIT_SPELLCAST_INTERRUPTED(event, unit, castGUID, spellId)
    if unit ~= "player" then
        return
    end
    if IsSlamSpellId(spellId) then
        self._slamCastEndTime = nil
    end
end

function module:UNIT_SPELLCAST_STOP(event, unit, castGUID, spellId)
    if unit ~= "player" then
        return
    end
    if IsSlamSpellId(spellId) then
        self._slamCastEndTime = nil
        if not self._slamCastDetectedTime or self._slamCastDetectedTime <= 0 then
            self._slamCastDetectedTime = GetTime()
        end
        if not self._slamCastStartTime or self._slamCastStartTime <= 0 then
            self._slamCastStartTime = self._slamCastDetectedTime
        end
    end
end

function module:UNIT_SPELLCAST_FAILED(event, unit, castGUID, spellId)
    if unit ~= "player" then
        return
    end
    if IsSlamSpellId(spellId) then
        self._slamCastEndTime = nil
    end
end

--- Set the slam weave bar to a dimmed state.
--- @param isDimmed boolean
function NAG:WarriorSlamWeaveSetBarDimmed(isDimmed)
    local bar = ns.WarriorSlamWeaveBar
    if not bar then
        return false
    end
    bar._barDimmed = isDimmed == true
    if bar.UpdateVisibility then
        bar:UpdateVisibility()
    end
    if bar.UpdateDisplay then
        bar:UpdateDisplay()
    end
    return false
end

--- Dim the bar with debug prints for each active reason.
--- Always returns false to avoid APL short-circuiting.
--- @return boolean
function NAG:WarriorSlamWeaveSetBarDimmedWithDebug()
    local bar = ns.WarriorSlamWeaveBar
    if not bar then
        return false
    end

    local now = GetTime()
    local slamId = self.WarriorSlamWeaveGetSlamId and self:WarriorSlamWeaveGetSlamId() or nil
    local castingSpellId = nil
    local startTimeMs = nil
    local endTimeMs = nil
    if UnitCastingInfo then
        local _, _, _, castStartMs, castEndMs, _, _, _, castSpellId = UnitCastingInfo("player")
        startTimeMs = castStartMs
        endTimeMs = castEndMs
        castingSpellId = castSpellId
        if castSpellId then
            bar._lastCastingSpellId = castSpellId
        end
    end
    local isCastingSlam = IsSlamSpellId(castingSpellId)
        or (slamId and self.SpellIsCasting and self:SpellIsCasting(slamId))
        or (self.SpellIsCasting and self:SpellIsCasting(bar._lastCastingSpellId))
    if isCastingSlam then
        bar._slamCastDetectedTime = now
        if startTimeMs then
            bar._slamCastStartTime = startTimeMs / 1000
        elseif not bar._slamCastStartTime or bar._slamCastStartTime <= 0 then
            bar._slamCastStartTime = now
        end
        if endTimeMs then
            bar._slamCastEndTime = endTimeMs / 1000
        end
    end
    local _, rawSwingLeft = self:AutoTimeToNext()
    local swingSpeed = self:AutoSwingTime() or 0
    local timeSinceSwing
    if swingSpeed > 0 and rawSwingLeft and rawSwingLeft >= 0 then
        timeSinceSwing = swingSpeed - rawSwingLeft
    else
        timeSinceSwing = math.huge
    end
    local gcdLeft = self:GCDTimeToReady() or 0
    local slamCastStart = bar._slamCastStartTime or bar._slamCastDetectedTime or 0
    local slamFinishAt = 0
    if self.GetLastPlayerSpellSucceededInfo then
        local lastSpellId, secondsAgo = self:GetLastPlayerSpellSucceededInfo()
        if lastSpellId and secondsAgo and secondsAgo >= 0 and (IsSlamSpellId(lastSpellId) or lastSpellId == bar._lastCastingSpellId) then
            slamFinishAt = now - secondsAgo
        end
    end
    local moduleSlamFinish = (self.WarriorSlamWeaveGetLastSlamSuccessTime and self:WarriorSlamWeaveGetLastSlamSuccessTime()) or 0
    if moduleSlamFinish > slamFinishAt then
        slamFinishAt = moduleSlamFinish
    end
    if bar._slamCastFinishTime and bar._slamCastFinishTime > slamFinishAt then
        slamFinishAt = bar._slamCastFinishTime
    end

    local isCasting = self:IsCasting()
    local inExecute = self.IsExecutePhase and self:IsExecutePhase(20) or false
    local inCombat = self:InCombat()
    local outCombat = not inCombat
    if inCombat and not bar._wasInCombat then
        bar._combatEnterTime = now
    end
    bar._wasInCombat = inCombat
    local hasSwingTime = timeSinceSwing ~= math.huge
    local timeToSwing = rawSwingLeft or 0
    if timeToSwing < 0 then timeToSwing = 0 end
    local gcdEndsAfterSwing = hasSwingTime and (gcdLeft > timeToSwing)
    local gcdEndDelta = gcdEndsAfterSwing and (gcdLeft - timeToSwing) or 0
    local gcdEndsPostGap = gcdEndsAfterSwing and gcdEndDelta >= 0.50
    local slamRecent = ((slamCastStart > 0) and ((now - slamCastStart) <= 2.10))
        or ((slamFinishAt > 0) and ((now - slamFinishAt) <= 0.60))
    local slamBlockUntil = 0
    if slamCastStart > 0 then
        slamBlockUntil = math.max(slamBlockUntil, slamCastStart + 2.10)
    end
    if slamFinishAt > 0 then
        slamBlockUntil = math.max(slamBlockUntil, slamFinishAt + 0.60)
    end
    bar._slamHardBlockUntil = slamBlockUntil
    local slamHardBlock = slamBlockUntil > 0 and now < slamBlockUntil
    local forceShowActive = bar._forceShowUntil and now < bar._forceShowUntil
    local ttx20 = self.TimeToPercent and self:TimeToPercent(20) or 8888
    local ttxBlock = hasSwingTime and ttx20 >= 0 and ttx20 < timeToSwing
    local combatEnterBlock = inCombat and bar._combatEnterTime and (now - bar._combatEnterTime) <= 2.0
    local targetHealth = self.CurrentHealth and self:CurrentHealth("target") or 0
    local noTargetOrDead = targetHealth <= 0

    if isCasting then
        bar._dimHoldChecks = 2
    elseif bar._dimHoldChecks and bar._dimHoldChecks > 0 then
        bar._dimHoldChecks = bar._dimHoldChecks - 1
    end
    local castHold = (bar._dimHoldChecks or 0) > 0

    local shouldDim = isCasting or castHold or outCombat or inExecute or ((not forceShowActive) and gcdEndsPostGap)
        or slamRecent or slamHardBlock or ttxBlock or combatEnterBlock or noTargetOrDead

    self:WarriorSlamWeaveSetBarDimmed(shouldDim)
    return false
end

--- Returns true when the Slam bar is visible and not dimmed.
--- @return boolean
function NAG:WarriorSlamWeaveIsBarVisible()
    local bar = ns.WarriorSlamWeaveBar
    if not bar or not bar.db or not bar.db.class then
        return false
    end
    if bar.db.class.enabled == false then
        return false
    end
    if NAG.IsTBCWarriorBarsEnabled and not NAG:IsTBCWarriorBarsEnabled() then
        return false
    end
    return bar._barDimmed ~= true
end

--- Force the Slam bar visible for a short window (does not bypass other hide rules).
--- @param seconds number|nil
--- @return boolean Always false for APL chaining
function NAG:WarriorSlamWeaveForceShow(seconds)
    local bar = ns.WarriorSlamWeaveBar
    if not bar then
        return false
    end
    local now = GetTime()
    local duration = tonumber(seconds) or 0.50
    if duration < 0.05 then
        duration = 0.05
    end
    bar._forceShowUntil = now + duration
    return false
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

    local function advancedHidden()
        return not self.debug
    end

    return {
        type = "group",
        name = "Warrior Slam Weave Bar",
        order = 27,
        childGroups = "tab",
        width = "full",
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enabled",
                "Enable/disable the Warrior Slam Weave Bar module.",
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
                "Display the keybind above the Slam icon on the bar.",
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
            locked = OptionsFactory:CreateToggle(
                "Lock Bar",
                "Lock or unlock the bar for dragging.",
                function() return self:GetSetting("class", "locked") end,
                function(_, value)
                    self:SetSetting("class", "locked", value)
                end,
                { order = 23 }
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
            visualsHeader = OptionsFactory:CreateHeader("Visual Toggles", { order = 40, hidden = advancedHidden }),
            showBackground = OptionsFactory:CreateToggle(
                "Show Background",
                "Show the background bar.",
                function() return self:GetSetting("class", "showBackground") end,
                function(_, value)
                    self:SetSetting("class", "showBackground", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 41, hidden = advancedHidden }
            ),
            showTimelineBar = OptionsFactory:CreateToggle(
                "Show Timeline Bar",
                "Show the thin timeline bar.",
                function() return self:GetSetting("class", "showTimelineBar") end,
                function(_, value)
                    self:SetSetting("class", "showTimelineBar", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 42, hidden = advancedHidden }
            ),
            showBgArt = OptionsFactory:CreateToggle(
                "Show Background Art",
                "Show the NAGbarCD background art.",
                function() return self:GetSetting("class", "showBgArt") end,
                function(_, value)
                    self:SetSetting("class", "showBgArt", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 43, hidden = advancedHidden }
            ),
            showNowMarker = OptionsFactory:CreateToggle(
                "Show NOW Marker",
                "Show the right-edge NOW marker.",
                function() return self:GetSetting("class", "showNowMarker") end,
                function(_, value)
                    self:SetSetting("class", "showNowMarker", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 44, hidden = advancedHidden }
            ),
            showDebugSwingBar = OptionsFactory:CreateToggle(
                "Show Debug Swing Bar",
                "Show the debug swing timer bar with time text.",
                function() return self:GetSetting("class", "showDebugSwingBar") end,
                function(_, value)
                    self:SetSetting("class", "showDebugSwingBar", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 45, hidden = advancedHidden }
            ),
            showDebugSwingText = OptionsFactory:CreateToggle(
                "Show Debug Swing Text",
                "Show the debug swing timer text.",
                function() return self:GetSetting("class", "showDebugSwingText") end,
                function(_, value)
                    self:SetSetting("class", "showDebugSwingText", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 46, hidden = advancedHidden }
            ),
            showTargetMarker = OptionsFactory:CreateToggle(
                "Show Target Marker",
                "Show the post-swing target marker.",
                function() return self:GetSetting("class", "showTargetMarker") end,
                function(_, value)
                    self:SetSetting("class", "showTargetMarker", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 47, hidden = advancedHidden }
            ),
            showSwingBars = OptionsFactory:CreateToggle(
                "Show Swing Bars",
                "Show the swing timeline bars (past + future).",
                function() return self:GetSetting("class", "showSwingBars") end,
                function(_, value)
                    self:SetSetting("class", "showSwingBars", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 48, hidden = advancedHidden }
            ),
            showSwingSpark = OptionsFactory:CreateToggle(
                "Show Swing Spark",
                "Show the swing timing spark.",
                function() return self:GetSetting("class", "showSwingSpark") end,
                function(_, value)
                    self:SetSetting("class", "showSwingSpark", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 49, hidden = advancedHidden }
            ),
            showSlamSpark = OptionsFactory:CreateToggle(
                "Show Slam Spark",
                "Show the Slam icon spark.",
                function() return self:GetSetting("class", "showSlamSpark") end,
                function(_, value)
                    self:SetSetting("class", "showSlamSpark", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 50, hidden = advancedHidden }
            ),
            bgArtHeader = OptionsFactory:CreateHeader("Background Art", { order = 60, hidden = advancedHidden }),
            bgArtWidth = OptionsFactory:CreateRange(
                "BG Art Width",
                "Background art width (pixels).",
                function() return self:GetSetting("class", "bgArtWidth") end,
                function(_, value)
                    self:SetSetting("class", "bgArtWidth", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 40, max = 400, step = 1, order = 61, hidden = advancedHidden }
            ),
            bgArtHeight = OptionsFactory:CreateRange(
                "BG Art Height",
                "Background art height (pixels).",
                function() return self:GetSetting("class", "bgArtHeight") end,
                function(_, value)
                    self:SetSetting("class", "bgArtHeight", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 20, max = 200, step = 1, order = 62, hidden = advancedHidden }
            ),
            bgArtAlpha = OptionsFactory:CreateRange(
                "BG Art Alpha",
                "Background art alpha.",
                function() return self:GetSetting("class", "bgArtAlpha") end,
                function(_, value)
                    self:SetSetting("class", "bgArtAlpha", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.0, max = 1.0, step = 0.05, order = 63, hidden = advancedHidden }
            ),
            bgArtOffsetX = OptionsFactory:CreateRange(
                "BG Art Offset X",
                "Background art X offset (pixels).",
                function() return self:GetSetting("class", "bgArtOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "bgArtOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -100, max = 100, step = 1, order = 64, hidden = advancedHidden }
            ),
            bgArtOffsetY = OptionsFactory:CreateRange(
                "BG Art Offset Y",
                "Background art Y offset (pixels).",
                function() return self:GetSetting("class", "bgArtOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "bgArtOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -100, max = 100, step = 1, order = 65, hidden = advancedHidden }
            ),
            markerHeader = OptionsFactory:CreateHeader("Markers", { order = 70, hidden = advancedHidden }),
            nowMarkerWidth = OptionsFactory:CreateRange(
                "NOW Marker Width",
                "Width of the outer NOW marker (pixels).",
                function() return self:GetSetting("class", "nowMarkerWidth") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerWidth", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 1, max = 6, step = 1, order = 71, hidden = advancedHidden }
            ),
            nowMarkerInnerWidth = OptionsFactory:CreateRange(
                "NOW Marker Inner Width",
                "Width of the inner NOW marker (pixels).",
                function() return self:GetSetting("class", "nowMarkerInnerWidth") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerInnerWidth", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 1, max = 6, step = 1, order = 72, hidden = advancedHidden }
            ),
            nowMarkerOffsetY = OptionsFactory:CreateRange(
                "NOW Marker Offset Y",
                "Vertical offset for the NOW marker (pixels).",
                function() return self:GetSetting("class", "nowMarkerOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "nowMarkerOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -20, max = 20, step = 1, order = 73, hidden = advancedHidden }
            ),
            targetMarkerSeconds = OptionsFactory:CreateRange(
                "Target Marker Seconds",
                "Seconds after swing for the target marker.",
                function() return self:GetSetting("class", "targetMarkerSeconds") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerSeconds", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.0, max = 1.0, step = 0.01, order = 74, hidden = advancedHidden }
            ),
            targetMarkerSize = OptionsFactory:CreateRange(
                "Target Marker Size",
                "Size of the target marker (pixels).",
                function() return self:GetSetting("class", "targetMarkerSize") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerSize", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 6, max = 80, step = 1, order = 75, hidden = advancedHidden }
            ),
            targetMarkerOffsetX = OptionsFactory:CreateRange(
                "Target Marker Offset X",
                "Horizontal offset of the target marker (pixels).",
                function() return self:GetSetting("class", "targetMarkerOffsetX") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerOffsetX", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 76, hidden = advancedHidden }
            ),
            targetMarkerOffsetY = OptionsFactory:CreateRange(
                "Target Marker Offset Y",
                "Vertical offset of the target marker (pixels).",
                function() return self:GetSetting("class", "targetMarkerOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "targetMarkerOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -50, max = 50, step = 1, order = 77, hidden = advancedHidden }
            ),
            debugSwingBarHeight = OptionsFactory:CreateRange(
                "Debug Swing Bar Height",
                "Height of the debug swing timer bar (pixels).",
                function() return self:GetSetting("class", "debugSwingBarHeight") end,
                function(_, value)
                    self:SetSetting("class", "debugSwingBarHeight", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 4, max = 40, step = 1, order = 78, hidden = advancedHidden }
            ),
            debugSwingBarOffsetY = OptionsFactory:CreateRange(
                "Debug Swing Bar Offset Y",
                "Vertical offset of the debug swing timer bar (pixels).",
                function() return self:GetSetting("class", "debugSwingBarOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "debugSwingBarOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -40, max = 40, step = 1, order = 79, hidden = advancedHidden }
            ),
            debugSwingFontSize = OptionsFactory:CreateRange(
                "Debug Swing Font Size",
                "Font size for the debug swing timer text.",
                function() return self:GetSetting("class", "debugSwingFontSize") end,
                function(_, value)
                    self:SetSetting("class", "debugSwingFontSize", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 6, max = 24, step = 1, order = 80, hidden = advancedHidden }
            ),
            sparksHeader = OptionsFactory:CreateHeader("Spark Icons", { order = 90, hidden = advancedHidden }),
            sparkScale = OptionsFactory:CreateRange(
                "Spark Scale",
                "Scale of the slam spark icons.",
                function() return self:GetSetting("class", "sparkScale") end,
                function(_, value)
                    self:SetSetting("class", "sparkScale", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.5, max = 3.0, step = 0.05, order = 91, hidden = advancedHidden }
            ),
            sparkOffsetY = OptionsFactory:CreateRange(
                "Spark Offset Y",
                "Vertical offset of the slam spark icons (pixels).",
                function() return self:GetSetting("class", "sparkOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "sparkOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -30, max = 30, step = 1, order = 92, hidden = advancedHidden }
            ),
            sparkSmoothing = OptionsFactory:CreateRange(
                "Spark Smoothing",
                "Smoothing factor for spark movement.",
                function() return self:GetSetting("class", "sparkSmoothing") end,
                function(_, value)
                    self:SetSetting("class", "sparkSmoothing", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.0, max = 1.0, step = 0.05, order = 93, hidden = advancedHidden }
            ),
            colorsHeader = OptionsFactory:CreateHeader("Colors", { order = 100, hidden = advancedHidden }),
            backgroundColor = OptionsFactory:CreateColor(
                "Background Color",
                "Background bar color.",
                colorGetter(self.db.class.backgroundColor),
                colorSetter(self.db.class.backgroundColor),
                { hasAlpha = true, order = 81, hidden = advancedHidden }
            ),
            timelineColor = OptionsFactory:CreateColor(
                "Timeline Color",
                "Timeline bar color.",
                colorGetter(self.db.class.gcdColor),
                colorSetter(self.db.class.gcdColor),
                { hasAlpha = true, order = 83, hidden = advancedHidden }
            ),
            sparkColor = OptionsFactory:CreateColor(
                "Spark Color",
                "Spark color for line markers.",
                colorGetter(self.db.class.sparkColor),
                colorSetter(self.db.class.sparkColor),
                { hasAlpha = true, order = 84, hidden = advancedHidden }
            ),
            debugSwingBarColor = OptionsFactory:CreateColor(
                "Debug Swing Bar Color",
                "Debug swing bar color.",
                colorGetter(self.db.class.debugSwingBarColor),
                colorSetter(self.db.class.debugSwingBarColor),
                { hasAlpha = true, order = 85, hidden = advancedHidden }
            ),
            debugSwingTextColor = OptionsFactory:CreateColor(
                "Debug Swing Text Color",
                "Debug swing text color.",
                colorGetter(self.db.class.debugSwingTextColor),
                colorSetter(self.db.class.debugSwingTextColor),
                { hasAlpha = true, order = 86, hidden = advancedHidden }
            ),
        }
    }
end

