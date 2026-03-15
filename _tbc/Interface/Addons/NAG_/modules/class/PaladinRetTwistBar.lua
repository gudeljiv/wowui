--- @module "NAG.PaladinRetTwistBar"
--- Visual swing + GCD timing bar for validating Ret seal twisting math against SwedgeTimer.
---
--- Phase 1 (current): show only
--- - Swing bar (time to next mainhand swing)
--- - GCD bar (time to GCD ready)
---
--- Phase 2 (later): add twist window overlays (last ~0.4s + delay buffers) and "can twist" highlight.
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
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local EasyMenu = _G.EasyMenu
local CloseDropDownMenus = _G.CloseDropDownMenus
local ToggleDropDownMenu = _G.ToggleDropDownMenu
local UIDropDownMenu_Initialize = _G.UIDropDownMenu_Initialize
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton
local StaticPopup_Show = _G.StaticPopup_Show
local StaticPopupDialogs = _G.StaticPopupDialogs
local InCombatLockdown = _G.InCombatLockdown
local ReloadUI = _G.ReloadUI
local pi = math.pi

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local swingTimerLib = ns.LibClassicSwingTimerAPI
local OptionsFactory

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        showBar = true,
        hideOutOfCombat = false,
        -- Debug prints are intentionally always-on (throttled) while we validate math vs SwedgeTimer.
        debugThrottleSeconds = 0.25,

        -- Positioning
        autoAnchor = true, -- Anchor relative to NAG primary frame when available
        anchorSide = "bottom", -- "bottom" = below NAG frame, "right" = to the right of NAG frame
        point = "CENTER",
        x = 140,
        y = 33,

        -- Dimensions
        width = 220,
        height = 6,
        alpha = 1.0,
        -- Bar fill direction: "rightToLeft" = countdown (current), "leftToRight" = classic swing-timer fill.
        barFillDirection = "rightToLeft",
        showGCDBar = true,
        showGCDSparks = true,
        gcdLaneHeight = 2,
        gcdLaneGap = 6,
        gcdSparkHeight = 5,
        showSwingIconSpark = true,
        userPositioned = false,
        predictionIconSize = 16,
        predictionTopLaneOffsetY = 12,
        predictionBottomLaneOffsetY = -12,
        predictionCSSplitExtraOffsetY = -14,
        showSocIcon = true,
        showJudgeIcon = true,
        showCSIcon = true,
        csLaneMode = "auto", -- auto (top in sideBySide, bottom in split), top, bottom
        fillerLaneMode = "bottom", -- bottom (reverted judge lane), top
        judgeBackgroundInverted = false,
        judgeSocLayoutMode = "sideBySide", -- "split" (SoC top, Judge bottom) or "sideBySide" (both top)
        socSideBySideOffsetX = 4,
        judgeSideBySideOffsetX = -4,
        judgeSocSideBySideOffsetY = 0,
        socBackgroundRotationSideBySideDeg = -15,
        judgeBackgroundRotationSideBySideDeg = 15,
        socBackgroundOffsetX = 0,
        socBackgroundOffsetY = 0,
        judgeBackgroundOffsetX = 0,
        judgeBackgroundOffsetY = 0,
        showFillerIconSpark = true,
        showKeybindOnBar = false,
        fillerSourcePosition = "left1", -- left1/right1 source from secondary suggestions
        fillerOffsetX = 0,
        fillerOffsetY = 0,

        -- Twist window visualization
        showTwistWindow = true,
        twistWindowSeconds = 0.4,   -- The classic SoC twist window (~0.4s before swing)
        -- NOTE: We intentionally do not show a separate "GCD end marker" line for now.
        -- The GCD overlay bar already provides this information visually.
        --
        -- SwedgeTimer-style "div" boundary marker:
        -- A moving tick that sits left of the swing marker by (twistWindow + lastGcdDuration),
        -- showing the last point where a fresh GCD would still end before the twist window opens.
        showDivBoundaryMarker = false,

        -- Appearance
        -- Swing bar itself is intentionally invisible; we show only the spark line (ShamanWeaveBar-style).
        swingColor = { r = 0.30, g = 0.75, b = 0.30, a = 0.0 },
        -- Slightly brighter to be easy to see over the background (matches ShamanWeaveBar vibe).
        gcdColor = { r = 0.40, g = 0.40, b = 0.40, a = 0.95 },
        backgroundColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.35 },
        sparkColor = { r = 0.9, g = 0.9, b = 0.9, a = 0.9 },

        -- Twist window colors
        twistWindowColor = { r = 0.90, g = 0.90, b = 0.90, a = 0.18 },     -- full 0.4s window
        divMarkerColor = { r = 0.95, g = 0.75, b = 0.10, a = 0.95 },       -- yellow/orange boundary tick
    }
}

--- @class PaladinRetTwistBar:CoreModule
local PaladinRetTwistBar = NAG:CreateModule("PaladinRetTwistBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "PALADIN",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function()
        return UnitClassBase("player") ~= "PALADIN"
    end,
    messageHandlers = {
        NAG_FRAME_UPDATED = true,
        NAG_PALADIN_BAR_SCALE_UPDATED = true,
    },
})

ns.PaladinRetTwistBar = PaladinRetTwistBar
local module = PaladinRetTwistBar

-- ============================ LOCALS ============================
local frame
local background
local swingBar
local gcdBar
local swingSpark
local pastSwingSpark
local swingIconSparkFrame
local swingIconSparkBackground
local swingIconSparkIcon
local swingIconSparkMask
local lastSwingIconTexture
local socIconSparkFrame
local socIconSparkBackground
local socIconSparkIcon
local socIconSparkMask
local lastSoCIconTexture
local judgeIconSparkFrame
local judgeIconSparkBackground
local judgeIconSparkIcon
local judgeIconSparkMask
local lastJudgeIconTexture
local fillerIconSparkFrame
local fillerIconSparkBackground
local fillerIconSparkIcon
local fillerIconSparkMask
local lastFillerIconTexture
local csIconSparkFrame
local csIconSparkBackground
local csIconSparkIcon
local csIconSparkMask
local lastCSIconTexture
local gcdSpark
local gcdSparkLeft
local twistWindowBar
local twistZeroSpark
local divBoundaryMarker
local twistOutcomeText
local clickCatcher

local UPDATE_INTERVAL = 0.016 -- ~60fps
local lastUpdate = 0
local SECONDS_EPSILON = 0.0001
local HOLD_SMOOTH_REFRESH_INTERVAL = 0.10
local HOLD_SMOOTH_SNAP_THRESHOLD = 0.20
local TIMELINE_SMOOTH_STALE_THRESHOLD = 0.002
local TIMELINE_SMOOTH_RESYNC_AHEAD_THRESHOLD = 0.08
local TIMELINE_SMOOTH_RESYNC_BEHIND_THRESHOLD = 0.18
local ICON_GCD_SUPPRESS_SECONDS = 0.12
local ICON_SIGNIFICANT_RIGHT_JUMP_SECONDS = 0.35
local ICON_NEAR_ZERO_WINDOW_SECONDS = 0.30
local PREDICTION_FADE_TOTAL_SECONDS = 0.30
local PREDICTION_FADE_HOLD_TRANSPARENT_SECONDS = 0.10
local ZERO_STICK_REFRESH_MAX_SECONDS = 1.0
local CS_SMOOTH_STATE_GRACE_SECONDS = 0.35
local CS_TRANSIENT_ZERO_HOLD_SECONDS = 0.25
local CS_TRANSIENT_ZERO_MIN_READY = 0.50
-- CS-specific: trust predictive decay for fluid countdown; only resync when clearly off.
local CS_HOLD_REFRESH_INTERVAL = 0.35
local CS_HOLD_SNAP_THRESHOLD = 0.60
-- Soften the jump when we do resync: backdate sample so predicted is closer to raw.
local CS_HOLD_RESYNC_BLEND_SECONDS = 0.08
local holdSmoothState = {}
local timelineSmoothState = {}

local function GetZeroStickStableDelay(self, stateKey, delay, isDisplayed)
    self._zeroStickState = self._zeroStickState or {}

    if not isDisplayed or delay == nil then
        self._zeroStickState[stateKey] = nil
        return delay
    end

    local normalized = delay
    if normalized < 0 then
        normalized = 0
    end

    if normalized <= SECONDS_EPSILON then
        self._zeroStickState[stateKey] = true
        return 0
    end

    if self._zeroStickState[stateKey] and normalized < ZERO_STICK_REFRESH_MAX_SECONDS then
        return 0
    end

    if normalized >= ZERO_STICK_REFRESH_MAX_SECONDS then
        self._zeroStickState[stateKey] = nil
    end

    return normalized
end

local function GetPredictionIconFadeAlpha(self, stateKey, shouldBeVisible, now)
    self._predictionIconFadeState = self._predictionIconFadeState or {}

    if not shouldBeVisible then
        self._predictionIconFadeState[stateKey] = nil
        return 1
    end

    local state = self._predictionIconFadeState[stateKey]
    if not state then
        state = { shownAt = now }
        self._predictionIconFadeState[stateKey] = state
    end

    local elapsed = now - (state.shownAt or now)
    if elapsed < 0 then
        elapsed = 0
    end

    if elapsed <= PREDICTION_FADE_HOLD_TRANSPARENT_SECONDS then
        return 0
    end

    if elapsed >= PREDICTION_FADE_TOTAL_SECONDS then
        return 1
    end

    local fadeWindow = PREDICTION_FADE_TOTAL_SECONDS - PREDICTION_FADE_HOLD_TRANSPARENT_SECONDS
    if fadeWindow <= 0 then
        return 1
    end

    local t = (elapsed - PREDICTION_FADE_HOLD_TRANSPARENT_SECONDS) / fadeWindow
    if t < 0 then
        t = 0
    elseif t > 1 then
        t = 1
    end
    return t
end

-- ============================ POPUPS ============================
-- Avoid re-registering popups on reloads.
if StaticPopupDialogs and not StaticPopupDialogs.NAG_RET_TWIST_BAR_DISABLE_CONFIRM then
    StaticPopupDialogs.NAG_RET_TWIST_BAR_DISABLE_CONFIRM = {
        text = "Disable Ret Twist Bar?",
        button1 = "Disable",
        button2 = "Cancel",
        OnAccept = function(dialog, data)
            local payload = data or (dialog and dialog.data) or nil
            if not payload or not payload.module then
                return
            end
            local m = payload.module
            if m.db and m.db.class then
                m.db.class.enabled = false
            end
            m:Disable()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
end

if StaticPopupDialogs and not StaticPopupDialogs.NAG_RET_TWIST_BAR_RESET_CONFIRM then
    StaticPopupDialogs.NAG_RET_TWIST_BAR_RESET_CONFIRM = {
        text = "Restore Ret Twist Bar defaults?",
        button1 = "Restore",
        button2 = "Cancel",
        OnAccept = function(dialog, data)
            local payload = data or (dialog and dialog.data) or nil
            if not payload or not payload.module then
                return
            end
            local m = payload.module
            if not (m.db and m.db.class) then
                return
            end

            -- Clear current settings and re-apply defaults (copy tables so we don't share refs).
            for k in pairs(m.db.class) do
                m.db.class[k] = nil
            end
            for k, v in pairs(defaults.class) do
                if type(v) == "table" and v.r ~= nil and v.g ~= nil and v.b ~= nil then
                    m.db.class[k] = { r = v.r, g = v.g, b = v.b, a = v.a or 1 }
                else
                    m.db.class[k] = v
                end
            end

            -- Ensure the bar comes back visible after reset (matches defaults).
            if m.UpdateVisibility then
                m:UpdateVisibility()
            end
            if m.UpdateDisplay then
                m:UpdateDisplay()
            end

            -- Auto reload to ensure all UI state reflects the restored defaults.
            if InCombatLockdown and InCombatLockdown() then
                m._pendingReloadUI = true
                if m.Print then
                    m:Print("Ret Twist Bar defaults restored. UI will reload after combat.")
                end
                return
            end
            if ReloadUI then
                ReloadUI()
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
end

-- ============================ HELPERS ============================
local function Clamp01(x)
    if x < 0 then return 0 end
    if x > 1 then return 1 end
    return x
end

--- Timeline geometry: fixed 0.4s history + full swing future.
--- The left side reserves exactly 0.4 seconds worth of space before the twist-zero/swing boundary.
--- @param width number
--- @param swingSpeed number
--- @return number historyPx
--- @return number futurePx
local function GetTimelineGeometry(width, swingSpeed)
    if not width or width <= 0 or not swingSpeed or swingSpeed <= 0 then
        return 0, width or 0
    end

    local historySeconds = 0.4
    local totalSeconds = swingSpeed + historySeconds
    local historyPx = width * (historySeconds / totalSeconds)
    local futurePx = width - historyPx
    if futurePx < 0 then futurePx = 0 end
    return historyPx, futurePx
end

--- Convert seconds-before-swing to X offset within the bar.
--- 0 seconds maps to the swing boundary at x=historyPx.
--- Positive seconds map into the future region to the right.
--- Negative seconds map into the fixed 0.4s history region.
--- @param secondsBeforeSwing number
--- @param width number
--- @param swingSpeed number
--- @return number xPx
local function SecondsBeforeSwingToX(secondsBeforeSwing, width, swingSpeed)
    local historyPx, futurePx = GetTimelineGeometry(width, swingSpeed)
    if not swingSpeed or swingSpeed <= 0 or not width or width <= 0 or futurePx <= 0 then
        return historyPx
    end

    local s = secondsBeforeSwing or 0
    local minS = -0.4
    if s < minS then s = minS end
    if s > swingSpeed then s = swingSpeed end

    local x = historyPx + (s / swingSpeed) * futurePx
    if x < 0 then x = 0 end
    if x > width then x = width end
    return x
end

local function GetIconTintByActionRemaining(actionRemaining)
    local remaining = actionRemaining or 0
    if remaining < 0 then
        remaining = 0
    end
    if remaining <= 0.05 then
        return 0.08, 0.26, 0.10, 1.0 -- dark green
    end
    if remaining < 1.0 then
        return 0.55, 0.45, 0.05, 1.0 -- dark yellow
    end
    return 0.0, 0.0, 0.0, 1.0 -- black
end

local function ParseHoldSecondsFromOverlayText(text)
    if type(text) ~= "string" then
        return nil
    end
    local value = string.match(text, "([%d%.]+)s")
    if not value then
        return nil
    end
    local seconds = tonumber(value)
    if not seconds then
        return nil
    end
    if seconds < 0 then
        seconds = 0
    end
    return seconds
end

local function GetSpellTimeToReadyUnified(spellId)
    if not spellId then
        return nil
    end
    if NAG.SpellTimeToReadyResolved then
        return NAG:SpellTimeToReadyResolved(spellId)
    end
    if NAG.SpellTimeToReady then
        return NAG:SpellTimeToReady(spellId)
    end
    return nil
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

--- Return real usable time-to-ready for a spell on the timeline.
--- SpellTimeToReady is GCD-oriented in NAG timing, so we add current GCD left
--- to get the full remaining time until the spell is actually usable.
--- @param spellId number
--- @param gcdLeft number|nil
--- @return number
local function GetSpellTimelineReadySeconds(spellId, gcdLeft)
    local gcd = gcdLeft or 0
    if gcd < 0 then
        gcd = 0
    end

    local spellReady = GetSpellTimeToReadyUnified(spellId)
    if spellReady == nil then
        spellReady = 0
    end
    if spellReady < 0 then
        spellReady = 0
    end

    if spellReady <= SECONDS_EPSILON then
        return gcd
    end
    return gcd + spellReady
end

--- Return smoothed timeline seconds for cached timer sources.
--- Keeps scrolling down from last sampled value when raw reads are stale.
--- Resyncs when fresh raw data clearly diverges from prediction.
--- @param stateKey string
--- @param rawSeconds number|nil
--- @param now number|nil
--- @param maxSeconds number|nil
--- @return number
local function GetSmoothedTimelineSeconds(stateKey, rawSeconds, now, maxSeconds)
    local currentTime = now or (GetTime and GetTime()) or 0
    local raw = rawSeconds or 0
    if raw < 0 then
        raw = 0
    end
    if maxSeconds and maxSeconds > 0 and raw > maxSeconds then
        raw = maxSeconds
    end

    local state = timelineSmoothState[stateKey]
    if not state then
        timelineSmoothState[stateKey] = {
            sampledSeconds = raw,
            sampledAt = currentTime,
            lastRaw = raw,
        }
        return raw
    end

    local predicted = state.sampledSeconds - (currentTime - state.sampledAt)
    if predicted < 0 then
        predicted = 0
    end
    if maxSeconds and maxSeconds > 0 and predicted > maxSeconds then
        predicted = maxSeconds
    end

    local lastRaw = state.lastRaw or raw
    local staleRead = math.abs(raw - lastRaw) <= TIMELINE_SMOOTH_STALE_THRESHOLD
    local shouldResync = false

    if raw < (predicted - TIMELINE_SMOOTH_RESYNC_BEHIND_THRESHOLD) then
        shouldResync = true
    elseif raw > (predicted + TIMELINE_SMOOTH_RESYNC_AHEAD_THRESHOLD) and not staleRead then
        shouldResync = true
    elseif predicted <= SECONDS_EPSILON and raw > TIMELINE_SMOOTH_RESYNC_AHEAD_THRESHOLD and not staleRead then
        shouldResync = true
    end

    if shouldResync then
        state.sampledSeconds = raw
        state.sampledAt = currentTime
        predicted = raw
    end

    state.lastRaw = raw
    return predicted
end

local function DegreesToRadians(degrees)
    local deg = tonumber(degrees) or 0
    return deg * (pi / 180)
end

local function ClampActionSecondsForTimeline(secondsToCast, swingSpeed)
    local seconds = secondsToCast or 0
    if seconds < 0 then
        seconds = 0
    end
    if swingSpeed and swingSpeed > 0 and seconds > swingSpeed then
        seconds = swingSpeed
    end
    return seconds
end

local function ProjectActionSecondsBeforeSwing(rawSwingLeft, swingSpeed, holdRemaining)
    if not swingSpeed or swingSpeed <= 0 then
        return 0
    end
    local hold = holdRemaining or 0
    if hold < 0 then
        hold = 0
    end
    local swingLeft = rawSwingLeft or 0
    if hold <= swingLeft then
        return swingLeft - hold
    end
    local remainingAfterSwing = hold - swingLeft
    local projected = swingSpeed - remainingAfterSwing
    if projected < 0 then
        projected = 0
    end
    if projected > swingSpeed then
        projected = swingSpeed
    end
    return projected
end

local function IsSameSpellId(candidate, a, b)
    if not candidate then
        return false
    end
    return candidate == a or (b and candidate == b)
end

local function IsFillerSpellId(spellId)
    local id = tonumber(spellId)
    return id == 26573 or id == 879 -- Consecration / Exorcism
end

local function IsPositionMatch(positionValue, expectedValue)
    if expectedValue == nil then
        return false
    end
    local positionText = string.lower(tostring(positionValue or ""))
    local expectedText = string.lower(tostring(expectedValue))
    if positionText == expectedText then
        return true
    end
    if expectedText == "left1" and positionValue == ns.SPELL_POSITIONS.LEFT then
        return true
    end
    if expectedText == "right1" and positionValue == ns.SPELL_POSITIONS.RIGHT then
        return true
    end
    return false
end

local function buildSuccessToast(twistSpellId)
    local label = "SoB/SoM"
    if twistSpellId == 31892 or twistSpellId == 31893 then
        label = "SoB"
    elseif twistSpellId == 348700 or twistSpellId == 348701 then
        label = "SoM"
    end

    return {
        text = string.format("Successful Twist"),
        r = 0.20,
        g = 0.85,
        b = 0.35,
    }
end

local function ClearParryHasteOverride()
    if not NAG then
        return
    end
    NAG._autoParryHasteNextSwingAt = nil
    NAG._autoParryHasteAppliedAt = nil
    NAG._autoParryHasteWeaponSpeed = nil
end

local function GetMainhandSwing()
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        local speed, expiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
        if speed and expiration then
            local now = GetTime()
            local remaining = math.max(0, expiration - now)

            -- Local parry-haste override (no lib edits):
            -- Defensive parry haste shortens only the current swing deadline.
            -- Weapon speed is unchanged for future cycle projections.
            local overrideAt = NAG and NAG._autoParryHasteNextSwingAt or nil
            if overrideAt then
                local overrideRemaining = overrideAt - now
                if overrideRemaining <= 0 then
                    ClearParryHasteOverride()
                elseif overrideRemaining < remaining then
                    remaining = overrideRemaining
                end
            end

            return remaining, speed
        end
    end
    return 0, 0
end

local function To01(b)
    return b and 1 or 0
end

--- Effective scale for Paladin bar frames: NAG display scale * universal Paladin bar scale.
local function GetPaladinBarEffectiveScale()
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local nagScale = (anchor and anchor ~= _G.UIParent and anchor:GetScale()) or 1
    local pm = NAG:GetModule("PaladinRetTwistModule", true)
    local barScale = (pm and pm.GetPaladinBarScale and pm:GetPaladinBarScale()) or 1
    return nagScale * barScale
end

function PaladinRetTwistBar:UpdateFrameAnchor()
    if not frame then
        return
    end

    local db = self.db.class
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local anchorValid = anchor and anchor ~= _G.UIParent

    -- When autoAnchor is true but anchor is temporarily invalid (e.g. during lock transition),
    -- db.x/db.y hold anchor-relative offsets, not UIParent coords. Do NOT apply the fallback
    -- or we would misplace the bar. Leave the frame where it is (position from last OnDragStop).
    if db.autoAnchor and not anchorValid then
        return
    end

    if not db.autoAnchor then
        frame:SetParent(_G.UIParent)
        frame:ClearAllPoints()
        frame:SetPoint(db.point, _G.UIParent, db.point, db.x, db.y)
        frame:SetScale(GetPaladinBarEffectiveScale())
        return
    end

    -- Keep on UIParent so we don't affect the main frame (e.g. floating selector position)
    frame:SetParent(_G.UIParent)
    frame:ClearAllPoints()
    if db.anchorSide == "right" then
        local dm = NAG:GetModule("DisplayManager", true)
        if dm and dm.AnchorFrameToRightOfDisplay then
            dm:AnchorFrameToRightOfDisplay(frame, "BOTTOMLEFT", db.x or 8, db.y or 0)
        else
            frame:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", db.x or 8, db.y or 0)
        end
    else
        frame:SetPoint("TOP", anchor, "BOTTOM", db.x, db.y)
    end
    frame:SetScale(GetPaladinBarEffectiveScale())
end

function PaladinRetTwistBar:UpdateVisibility()
    if not frame then
        return
    end

    local db = self.db.class
    -- In edit mode: force visible for positioning - check FIRST so bars stay visible when unlocked
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:EnableMouse(true)
        frame:Show()
        frame:SetScript("OnUpdate", function(_, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                self:UpdateDisplay()
                lastUpdate = 0
            end
        end)
        if clickCatcher then
            clickCatcher:EnableMouse(true)
        end
        return
    end

    if not db.showBar then
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end

    if NAG.IsTBCRetBarsEnabled and not NAG:IsTBCRetBarsEnabled() then
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
    frame:EnableMouse(false)
    frame:Show()
    if clickCatcher then
        clickCatcher:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
    end
    -- Alpha will be dynamically adjusted in UpdateDisplay based on SoC + twist readiness
    self:UpdateFrameAnchor()
    frame:SetScript("OnUpdate", function(_, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            self:UpdateDisplay()
            lastUpdate = 0
        end
    end)
end

function PaladinRetTwistBar:ResolveSoCIds()
    local soCId = NAG.RetTwistGetSoCSealId and NAG:RetTwistGetSoCSealId() or nil
    local resolvedSoCId = soCId
    if soCId and NAG.ResolveEffectiveSpellId then
        resolvedSoCId = NAG:ResolveEffectiveSpellId(soCId) or soCId
    end
    return soCId, resolvedSoCId
end

function PaladinRetTwistBar:IsSoCRecommended(soCId, resolvedSoCId)
    local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local nextSpell = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
    if IsSameSpellId(nextSpell, soCId, resolvedSoCId) then
        return true
    end

    local secondary = NAG.secondarySpells
    if type(secondary) ~= "table" then
        return false
    end
    for i = 1, #secondary do
        local entry = secondary[i]
        local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
        if norm then
            local entryId = norm.spellId or norm.itemId
            local position = norm.position
            local isAoe = (position == ns.SPELL_POSITIONS.AOE) or (type(position) == "string" and string.lower(position) == "aoe")
            if isAoe and entryId and IsSameSpellId(entryId, soCId, resolvedSoCId) then
                return true
            end
        end
    end
    return false
end

function PaladinRetTwistBar:GetHoldRemainingForSpell(spellId, resolvedSpellId, positions)
    local dm = NAG:GetModule("DisplayManager", true)
    if dm and dm.GetCustomHoldSwipe then
        for i = 1, #positions do
            local pos = positions[i]
            local state = dm:GetCustomHoldSwipe(spellId, pos)
            if (not state) and resolvedSpellId and resolvedSpellId ~= spellId then
                state = dm:GetCustomHoldSwipe(resolvedSpellId, pos)
            end
            if state and state.endAt then
                local remaining = state.endAt - GetTime()
                if remaining > 0 then
                    return remaining
                end
            end
        end
    end

    if NAG.castOverlayTexts then
        local text = NAG.castOverlayTexts[spellId]
        if (not text) and resolvedSpellId and resolvedSpellId ~= spellId then
            text = NAG.castOverlayTexts[resolvedSpellId]
        end
        local parsed = ParseHoldSecondsFromOverlayText(text)
        if parsed and parsed > 0 then
            return parsed
        end
    end
    return nil
end

--- Resolve action delay for an icon lane.
--- Modes:
--- - Default mode (legacy): hold -> cooldown readiness, gated by GCD.
--- - Hold-prediction mode (visual lane): hold only, fallback to 0 (fixed zero marker).
--- @param spellId number
--- @param resolvedSpellId number|nil
--- @param positions table
--- @param gcdLeft number
--- @param options table|nil
--- @return number
function PaladinRetTwistBar:GetActionDelayForSpell(spellId, resolvedSpellId, positions, gcdLeft, options)
    local holdPredictionOnly = options and options.holdPredictionOnly == true
    local gcd = gcdLeft or 0
    if gcd < 0 then
        gcd = 0
    end

    local holdRemaining = self:GetHoldRemainingForSpell(spellId, resolvedSpellId, positions)
    if holdRemaining and holdRemaining > SECONDS_EPSILON then
        if holdPredictionOnly then
            return holdRemaining
        end
        return math.max(gcd, holdRemaining)
    end

    if holdPredictionOnly then
        -- For visual HOLD prediction lanes, missing hold means "cast at swing moment".
        return 0
    end

    local queryId = resolvedSpellId or spellId
    local readyIn = GetSpellTimeToReadyUnified(queryId)
    if readyIn == nil then
        readyIn = 0
    end
    if readyIn < 0 then
        readyIn = 0
    end

    if readyIn < SECONDS_EPSILON then
        readyIn = 0
    end
    return math.max(gcd, readyIn)
end

function PaladinRetTwistBar:ClearSmoothedHoldState(stateKey)
    holdSmoothState[stateKey] = nil
end

--- Return smoothed hold delay for visual bar motion.
--- Uses sampled-refresh + predictive decay to avoid per-frame jitter.
--- @param stateKey string
--- @param rawDelay number
--- @param now number
--- @return number
function PaladinRetTwistBar:GetSmoothedHoldDelay(stateKey, rawDelay, now)
    local currentTime = now or (GetTime and GetTime()) or 0
    local raw = rawDelay or 0
    if raw < 0 then
        raw = 0
    end

    local refreshInterval = HOLD_SMOOTH_REFRESH_INTERVAL
    local snapThreshold = HOLD_SMOOTH_SNAP_THRESHOLD
    if stateKey == "cs" then
        refreshInterval = CS_HOLD_REFRESH_INTERVAL
        snapThreshold = CS_HOLD_SNAP_THRESHOLD
    end

    local state = holdSmoothState[stateKey]
    if not state then
        holdSmoothState[stateKey] = {
            sampledDelay = raw,
            sampledAt = currentTime,
            nextRefreshAt = currentTime + refreshInterval,
        }
        return raw
    end

    local predicted = state.sampledDelay - (currentTime - state.sampledAt)
    if predicted < 0 then
        predicted = 0
    end

    local shouldRefresh = false
    if currentTime >= (state.nextRefreshAt or 0) then
        shouldRefresh = true
    end
    if math.abs(raw - predicted) > snapThreshold then
        shouldRefresh = true
    end
    if predicted <= 0 and raw > 0 then
        shouldRefresh = true
    end

    if shouldRefresh then
        state.sampledDelay = raw
        state.sampledAt = currentTime
        state.nextRefreshAt = currentTime + refreshInterval
        if stateKey == "cs" and CS_HOLD_RESYNC_BLEND_SECONDS > 0 then
            local blend = (raw - predicted) * 0.25
            if blend > 0 then
                return predicted + blend
            end
        end
        return raw
    end

    return predicted
end

--- Return visual hold-prediction delay for icon lanes (smoothed).
--- Missing hold resolves to 0 so icons pin to the static zero marker.
--- Final result is clamped to GCD floor for Weave-like minimum behavior.
--- @param stateKey string
--- @param spellId number
--- @param resolvedSpellId number|nil
--- @param positions table
--- @param now number
--- @param gcdFloor number|nil
--- @return number smoothedDelay
--- @return number rawDelay
function PaladinRetTwistBar:GetVisualHoldPredictionDelay(stateKey, spellId, resolvedSpellId, positions, now, gcdFloor)
    local holdRemaining = self:GetHoldRemainingForSpell(spellId, resolvedSpellId, positions)
    local rawDelay = 0
    if holdRemaining and holdRemaining > SECONDS_EPSILON then
        rawDelay = holdRemaining
    end
    local smoothed = self:GetSmoothedHoldDelay(stateKey, rawDelay, now)
    local floor = gcdFloor or 0
    if floor < 0 then
        floor = 0
    end
    if smoothed < floor then
        smoothed = floor
    end
    return smoothed, rawDelay
end

function PaladinRetTwistBar:GetJudgeSocLayoutMode()
    local mode = self.db and self.db.class and self.db.class.judgeSocLayoutMode or "sideBySide"
    if mode ~= "sideBySide" then
        mode = "split"
    end
    return mode
end

function PaladinRetTwistBar:ApplyJudgeSocBackgroundTransforms(judgeCalled)
    if not frame or not self.db or not self.db.class then
        return
    end

    local db = self.db.class
    local mode = self:GetJudgeSocLayoutMode()
    local sideBySide = mode == "sideBySide"
    local sideBySideWithJudge = sideBySide and (judgeCalled == true)
    local judgeInverted = db.judgeBackgroundInverted == true

    if socIconSparkBackground and socIconSparkFrame then
        socIconSparkBackground:ClearAllPoints()
        socIconSparkBackground:SetPoint(
            "CENTER",
            socIconSparkFrame,
            "CENTER",
            db.socBackgroundOffsetX or 0,
            db.socBackgroundOffsetY or 0
        )
        local socRotationDeg = sideBySideWithJudge and (db.socBackgroundRotationSideBySideDeg or 0) or 0
        socIconSparkBackground:SetRotation(DegreesToRadians(socRotationDeg))
        socIconSparkBackground:SetTexCoord(0, 1, 0, 1)
    end

    if judgeIconSparkBackground and judgeIconSparkFrame then
        judgeIconSparkBackground:ClearAllPoints()
        judgeIconSparkBackground:SetPoint(
            "CENTER",
            judgeIconSparkFrame,
            "CENTER",
            db.judgeBackgroundOffsetX or 0,
            db.judgeBackgroundOffsetY or 0
        )
        local judgeRotationDeg = sideBySideWithJudge and (db.judgeBackgroundRotationSideBySideDeg or 0) or 0
        judgeIconSparkBackground:SetRotation(DegreesToRadians(judgeRotationDeg))
        if judgeInverted then
            judgeIconSparkBackground:SetTexCoord(0, 1, 1, 0)
        else
            judgeIconSparkBackground:SetTexCoord(0, 1, 0, 1)
        end
    end
end

--- Applies shared prediction icon sizing for all action icon lanes.
function PaladinRetTwistBar:ApplyPredictionIconSizing()
    if not self.db or not self.db.class then
        return
    end

    local db = self.db.class
    local iconSize = math.floor(db.predictionIconSize or 16)
    if iconSize < 8 then iconSize = 8 end
    if iconSize > 48 then iconSize = 48 end
    local ringSize = iconSize + 21

    if socIconSparkFrame then socIconSparkFrame:SetSize(iconSize, iconSize) end
    if judgeIconSparkFrame then judgeIconSparkFrame:SetSize(iconSize, iconSize) end
    if csIconSparkFrame then csIconSparkFrame:SetSize(iconSize, iconSize) end
    if fillerIconSparkFrame then fillerIconSparkFrame:SetSize(iconSize, iconSize) end

    if socIconSparkBackground then socIconSparkBackground:SetSize(ringSize, ringSize) end
    if judgeIconSparkBackground then judgeIconSparkBackground:SetSize(ringSize, ringSize) end
    if csIconSparkBackground then csIconSparkBackground:SetSize(ringSize, ringSize) end
    if fillerIconSparkBackground then fillerIconSparkBackground:SetSize(ringSize, ringSize) end
end

function PaladinRetTwistBar:IsJudgeParallelActive(soCRecommended)
    if not soCRecommended then
        return false
    end

    -- Only show Judgement lane when Judgement is explicitly recommended right now.
    -- Do not revive it from stale HOLD cache state alone.
    local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local nextSpell = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
    if nextSpell == 20271 then
        return true
    end

    local secondary = NAG.secondarySpells
    if type(secondary) == "table" then
        for i = 1, #secondary do
            local entry = secondary[i]
            local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
            if norm then
                local entryId = norm.spellId or norm.itemId
                if entryId == 20271 then
                    return true
                end
            end
        end
    end

    return false
end

function PaladinRetTwistBar:IsCSRecommended()
    local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local nextSpell = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
    if nextSpell == 35395 then
        return true
    end
    local secondary = NAG.secondarySpells
    if type(secondary) ~= "table" then
        return false
    end
    for i = 1, #secondary do
        local entry = secondary[i]
        local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
        if norm then
            local entryId = norm.spellId or norm.itemId
            if entryId == 35395 then
                return true
            end
        end
    end
    return false
end

--- Returns a recommended filler spell ID (Consecration/Exorcism) or nil.
--- Mirrors WeaveBar filler sourcing: uses configured secondary source slot.
--- @return number|nil
function PaladinRetTwistBar:GetRecommendedFillerSpellId()
    local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local nextSpell = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
    if IsFillerSpellId(nextSpell) then
        return nextSpell
    end

    local db = self.db and self.db.class or nil
    local fillerSource = (db and db.fillerSourcePosition) or "left1"
    local secondary = NAG.secondarySpells
    if type(secondary) ~= "table" then
        return nil
    end

    for i = 1, #secondary do
        local entry = secondary[i]
        local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
        if norm then
            local entryId = norm.spellId or norm.itemId
            if IsPositionMatch(norm.position, fillerSource) and entryId and IsFillerSpellId(entryId) then
                return entryId
            end
        end
    end

    return nil
end

function PaladinRetTwistBar:UpdateDisplay()
    if not frame then return end

    -- In edit mode, visibility is managed by UpdateVisibility - never hide so user can position
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        return
    end

    local db = self.db.class
    local judgeSocLayoutMode = self:GetJudgeSocLayoutMode()
    local sideBySideJudgeSoc = judgeSocLayoutMode == "sideBySide"
    local now = (GetTime and GetTime()) or 0
    if not db.showBar then return end
    if NAG.IsTBCRetBarsEnabled and not NAG:IsTBCRetBarsEnabled() then
        frame:Hide()
        return
    end
    if db.hideOutOfCombat and not UnitAffectingCombat("player") then return end

    -- Seal state (used for gating some visuals like the weapon spark / twist window overlay).
    local soCActive = NAG.RetTwistIsSoCActive and NAG:RetTwistIsSoCActive() or false
    -- When CS override is active, CS is the only action; block SoB/SoM and twist-related icons.
    local csOverrideActive = NAG.RetTwistShouldForceCrusaderStrike and NAG:RetTwistShouldForceCrusaderStrike(1.9, 0.1, 0.4) or false
    local twistGapGate = (not csOverrideActive) and (db.showTwistWindow and db.showSwingIconSpark and soCActive) or false

    -- Keep the entire module alpha stable (no shifting based on seals).
    local targetAlpha = (db.alpha or 1.0)
    frame:SetAlpha(targetAlpha)

    local rawSwingLeft, swingSpeed = GetMainhandSwing()
    if not swingSpeed or swingSpeed <= 0 then
        -- Fallback to NAG helper if swingTimerLib isn't reporting yet.
        local _, raw = NAG:AutoTimeToNext()
        rawSwingLeft = raw or 0
        swingSpeed = NAG:AutoSwingTime() or 0
    end

    if not swingSpeed or swingSpeed <= 0 then
        frame:Hide()
        return
    end

    if rawSwingLeft < 0 then
        rawSwingLeft = 0
    end
    local swingLeft = GetSmoothedTimelineSeconds("swing", rawSwingLeft, now, swingSpeed)

    local rawGcdLeft = NAG:GCDTimeToReady() or 0
    if rawGcdLeft < 0 then
        rawGcdLeft = 0
    end
    local gcdLeft = GetSmoothedTimelineSeconds("gcd", rawGcdLeft, now, nil)

    local width = db.width
    local baseHeight = db.height
    local swingHeight = baseHeight + 5
    local gcdHeight = db.gcdLaneHeight or 2
    local gcdGap = db.gcdLaneGap or 6
    local gcdSparkHeight = db.gcdSparkHeight or 5
    if gcdHeight < 1 then gcdHeight = 1 end
    if gcdGap < 0 then gcdGap = 0 end
    if gcdSparkHeight < 2 then gcdSparkHeight = 2 end
    local showGCDLane = db.showGCDBar ~= false

    -- Total frame height must fit swing lane + gap + gcd lane (including spark protrusion).
    local totalHeight = swingHeight
    if showGCDLane then
        totalHeight = totalHeight + gcdGap + gcdSparkHeight
    end
    frame:SetSize(width, totalHeight)
    self:ApplyPredictionIconSizing()

    -- ============================ TIMELINE (0.4s HISTORY) ============================
    -- The "swing moment" (0s before swing) is at x=historyPx, with a fixed 0.4s history region on the left.
    local historyPx, futurePx = GetTimelineGeometry(width, swingSpeed)
    local swingCenterY = (totalHeight / 2) - (swingHeight / 2)
    local gcdCenterY = swingCenterY - (swingHeight / 2) - gcdGap - (gcdHeight / 2)

    local leftToRight = (db.barFillDirection == "leftToRight")
    local function toVisualX(x)
        if leftToRight then return width - x else return x end
    end

    -- Background should ONLY cover the swing lane (GCD lane intentionally sits outside the background borders).
    if background then
        background:ClearAllPoints()
        background:SetPoint("LEFT", frame, "LEFT", 0, swingCenterY)
        background:SetSize(width, swingHeight)
        background:Show()
    end

    -- Swing bar: remaining time (shrinks right -> left) or left-to-right fill; anchored per barFillDirection.
    swingBar:ClearAllPoints()
    local swingProgress = Clamp01((swingLeft or 0) / swingSpeed)
    if leftToRight then
        swingBar:SetPoint("LEFT", frame, "LEFT", toVisualX(historyPx + futurePx * (1 - swingProgress)), swingCenterY)
        swingBar:SetWidth(futurePx * (1 - swingProgress))
    else
        swingBar:SetPoint("LEFT", frame, "LEFT", historyPx, swingCenterY)
        swingBar:SetWidth(futurePx * swingProgress)
    end
    swingBar:SetHeight(swingHeight)
    swingBar:Show()

    -- Swing spark: vertical line at the swing moment (fixed when leftToRight, at bar end when rightToLeft).
    swingSpark:SetSize(2, swingHeight)
    swingSpark:ClearAllPoints()
    if leftToRight then
        swingSpark:SetPoint("CENTER", frame, "LEFT", toVisualX(historyPx), swingCenterY)
    else
        swingSpark:SetPoint("CENTER", swingBar, "RIGHT", 0, 0)
    end
    if twistGapGate then
        swingSpark:Show()
    else
        swingSpark:Hide()
    end
    if twistGapGate then
        swingSpark:Show()
    else
        swingSpark:Hide()
    end

    -- Optional weapon icon spark (circular) positioned above the swing marker to avoid blocking the bar.
    local autoSparkVisible = false
    if swingIconSparkFrame then
        -- Only show this spark when SoC is active (otherwise it should be fully transparent).
        if db.showSwingIconSpark and soCActive then
            local soCId = NAG.RetTwistGetSoCSealId and NAG:RetTwistGetSoCSealId() or nil
            local twistSealId = NAG.RetTwistGetTwistSealId and NAG:RetTwistGetTwistSealId() or nil -- SoB/SoM
            local displaySpellId = twistSealId or soCId
            if NAG.ResolveEffectiveSpellId and displaySpellId then
                displaySpellId = NAG:ResolveEffectiveSpellId(displaySpellId) or displaySpellId
            end

            local iconTexture = (displaySpellId and NAG.Spell and NAG.Spell[displaySpellId] and NAG.Spell[displaySpellId].icon)
                or (displaySpellId and _G.GetSpellTexture and _G.GetSpellTexture(displaySpellId))
                or "Interface\\Icons\\INV_Misc_QuestionMark"

            if iconTexture and iconTexture ~= lastSwingIconTexture then
                lastSwingIconTexture = iconTexture
                if swingIconSparkIcon then
                    swingIconSparkIcon:SetTexture(iconTexture)
                end
            end

            -- Position the icon at the middle of the moving twist gap, shifted left by ~0.2s.
            local window = db.twistWindowSeconds or 0.4
            if window < 0 then window = 0 end
            if window > swingSpeed then window = swingSpeed end

            local startSeconds = (swingLeft or 0) - window
            local endSeconds = (swingLeft or 0)
            local iconSeconds = (swingLeft or 0) - (window * 0.5) - 0.2
            -- Never allow the icon to go left of the fixed zero mark (0s before swing).
            -- If calculations would put it into negative time (history), pin it at 0.
            if iconSeconds < 0 then iconSeconds = 0 end
            if iconSeconds < startSeconds then iconSeconds = startSeconds end
            if iconSeconds > endSeconds then iconSeconds = endSeconds end

            local iconX = SecondsBeforeSwingToX(iconSeconds, width, swingSpeed)
            local iconSize = swingIconSparkFrame:GetWidth() or 16
            local y = swingCenterY + (swingHeight / 2) + (iconSize / 2) + 1 + 12
            swingIconSparkFrame:ClearAllPoints()
            swingIconSparkFrame:SetPoint("CENTER", frame, "LEFT", toVisualX(iconX), y)
            if swingIconSparkBackground then
                -- Tint the background art when we're approaching the twist moment,
                -- matching the moving twist gap bar thresholds.
                local timeToZero = (swingLeft or 0) - window
                if timeToZero < 0 then timeToZero = 0 end
                if timeToZero <= 0.05 then
                    swingIconSparkBackground:SetVertexColor(0.08, 0.26, 0.10, 1.0) -- dark green
                elseif timeToZero < 1.0 then
                    swingIconSparkBackground:SetVertexColor(0.55, 0.45, 0.05, 1.0) -- dark yellow
                else
                    swingIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0) -- black
                end
                swingIconSparkBackground:Show()
            end
            swingIconSparkFrame:Show()
            SetSparkKeybind(swingIconSparkFrame, false)
            autoSparkVisible = true
        else
            SetSparkKeybind(swingIconSparkFrame, false)
            swingIconSparkFrame:Hide()
            if swingIconSparkBackground then
                -- Reset tint when hidden so it doesn't carry across states.
                swingIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                swingIconSparkBackground:Hide()
            end
        end
    end

    local soCId, resolvedSoCId = self:ResolveSoCIds()
    local soCRecommended = self:IsSoCRecommended(soCId, resolvedSoCId)
    local judgeParallelActive = self:IsJudgeParallelActive(soCRecommended)
    local socShouldShow = soCRecommended or judgeParallelActive

    local soCVisualDelay = nil
    local judgeVisualDelay = nil
    local csVisualDelay = nil
    local fillerVisualDelay = nil
    local soCRawDelay = nil
    local judgeRawDelay = nil
    local csRawReady = nil
    local fillerRawReady = nil

    if socShouldShow and soCId then
        soCVisualDelay, soCRawDelay = self:GetVisualHoldPredictionDelay(
            "soc",
            soCId,
            resolvedSoCId,
            { ns.SPELL_POSITIONS.PRIMARY, ns.SPELL_POSITIONS.AOE },
            now,
            gcdLeft
        )
    else
        self:ClearSmoothedHoldState("soc")
    end

    if judgeParallelActive then
        judgeVisualDelay, judgeRawDelay = self:GetVisualHoldPredictionDelay(
            "judge",
            20271,
            20271,
            { ns.SPELL_POSITIONS.PRIMARY },
            now,
            gcdLeft
        )
    else
        self:ClearSmoothedHoldState("judge")
    end

    local csRecommended = self:IsCSRecommended()
    local csJustBecameRecommended = false
    local csRawReadyNow = GetSpellTimelineReadySeconds(35395, gcdLeft)

    -- Stabilize occasional transient zero reads while CS is clearly still cooling down.
    if csRawReadyNow <= SECONDS_EPSILON then
        local lastRaw = self._csLastRawReady
        local lastRawAt = self._csLastRawReadyAt or 0
        if lastRaw and lastRaw > CS_TRANSIENT_ZERO_MIN_READY and (now - lastRawAt) <= CS_TRANSIENT_ZERO_HOLD_SECONDS then
            csRawReadyNow = lastRaw
        end
    else
        self._csLastRawReady = csRawReadyNow
        self._csLastRawReadyAt = now
    end

    if csRecommended then
        -- On the exact frame CS transitions from not-recommended to recommended,
        -- force-seed the smoother with real rawReady so there is no stale-low first frame.
        csJustBecameRecommended = not self._csWasRecommended
        self._csWasRecommended = true
        self._csLastRecommendedAt = now
        csRawReady = csRawReadyNow

        if csJustBecameRecommended then
            self:ClearSmoothedHoldState("cs")
        end

        local csSmoothed = self:GetSmoothedHoldDelay("cs", csRawReadyNow, now)
        csVisualDelay = math.max(gcdLeft, csSmoothed)
    else
        self._csWasRecommended = false
        -- Keep CS smoothing warm briefly to avoid jumpy re-entry when recommendations flap.
        local keepCSWarm = self._csLastRecommendedAt and ((now - self._csLastRecommendedAt) <= CS_SMOOTH_STATE_GRACE_SECONDS)
        if keepCSWarm then
            self:GetSmoothedHoldDelay("cs", csRawReadyNow, now)
        else
            self:ClearSmoothedHoldState("cs")
        end
    end

    local fillerSpellId = nil
    local fillerRecommended = db.showFillerIconSpark and self:GetRecommendedFillerSpellId() or nil
    if fillerRecommended then
        fillerSpellId = fillerRecommended
        local rawReady = GetSpellTimeToReadyUnified(fillerSpellId) or 0
        if rawReady < 0 then
            rawReady = 0
        end
        -- Match Weave filler behavior: only display if filler is ready by GCD release.
        if rawReady > (gcdLeft + SECONDS_EPSILON) then
            fillerSpellId = nil
            if self._lastFillerSmoothKey then
                self:ClearSmoothedHoldState(self._lastFillerSmoothKey)
                self._lastFillerSmoothKey = nil
            end
        else
        fillerRawReady = rawReady
        local fillerKey = "filler_" .. tostring(fillerSpellId)
        if self._lastFillerSmoothKey and self._lastFillerSmoothKey ~= fillerKey then
            self:ClearSmoothedHoldState(self._lastFillerSmoothKey)
        end
        self._lastFillerSmoothKey = fillerKey
        local fillerSmoothed = self:GetSmoothedHoldDelay(fillerKey, rawReady, now)
        fillerVisualDelay = math.max(gcdLeft, fillerSmoothed)
        end
    else
        if self._lastFillerSmoothKey then
            self:ClearSmoothedHoldState(self._lastFillerSmoothKey)
            self._lastFillerSmoothKey = nil
        end
    end

    -- Keep both icons grouped in side-by-side mode when Judgement is active:
    -- they share one HOLD-based base time, then only X offsets separate them.
    if sideBySideJudgeSoc and judgeParallelActive and socShouldShow then
        local sharedDelay = math.max(soCVisualDelay or 0, judgeVisualDelay or 0)
        soCVisualDelay = sharedDelay
        judgeVisualDelay = sharedDelay
    end

    local socDisplayed = (not csOverrideActive) and db.showSwingIconSpark and db.showSocIcon ~= false and socShouldShow and soCId ~= nil
    local judgeDisplayed = (not csOverrideActive) and db.showSwingIconSpark and db.showJudgeIcon ~= false and judgeParallelActive
    local csDisplayed = db.showSwingIconSpark and db.showCSIcon ~= false and csRecommended
    local fillerDisplayed = (not csOverrideActive) and db.showSwingIconSpark and db.showFillerIconSpark and fillerSpellId ~= nil

    soCVisualDelay = GetZeroStickStableDelay(self, "soc", soCVisualDelay, socDisplayed)
    judgeVisualDelay = GetZeroStickStableDelay(self, "judge", judgeVisualDelay, judgeDisplayed)
    csVisualDelay = GetZeroStickStableDelay(self, "cs", csVisualDelay, csDisplayed)
    fillerVisualDelay = GetZeroStickStableDelay(self, "filler", fillerVisualDelay, fillerDisplayed)

    local prevDelays = self._iconPrevDelays or {}
    local socPrev = prevDelays.soc
    local judgePrev = prevDelays.judge
    local csPrev = prevDelays.cs
    local fillerPrev = prevDelays.filler
    local socDelta = (socDisplayed and socPrev ~= nil and soCVisualDelay ~= nil) and ((soCVisualDelay or 0) - socPrev) or 0
    local judgeDelta = (judgeDisplayed and judgePrev ~= nil and judgeVisualDelay ~= nil) and ((judgeVisualDelay or 0) - judgePrev) or 0
    local csDelta = (csDisplayed and csPrev ~= nil and csVisualDelay ~= nil) and ((csVisualDelay or 0) - csPrev) or 0
    local fillerDelta = (fillerDisplayed and fillerPrev ~= nil and fillerVisualDelay ~= nil) and ((fillerVisualDelay or 0) - fillerPrev) or 0

    local significantRightJump = false
    if socDisplayed and socPrev ~= nil and soCVisualDelay ~= nil then
        if socDelta > ICON_SIGNIFICANT_RIGHT_JUMP_SECONDS and socPrev <= ICON_NEAR_ZERO_WINDOW_SECONDS then
            significantRightJump = true
        end
    end
    if judgeDisplayed and judgePrev ~= nil and judgeVisualDelay ~= nil then
        if judgeDelta > ICON_SIGNIFICANT_RIGHT_JUMP_SECONDS and judgePrev <= ICON_NEAR_ZERO_WINDOW_SECONDS then
            significantRightJump = true
        end
    end
    if csDisplayed and csPrev ~= nil and csVisualDelay ~= nil then
        if csDelta > ICON_SIGNIFICANT_RIGHT_JUMP_SECONDS and csPrev <= ICON_NEAR_ZERO_WINDOW_SECONDS then
            significantRightJump = true
        end
    end
    if fillerDisplayed and fillerPrev ~= nil and fillerVisualDelay ~= nil then
        if fillerDelta > ICON_SIGNIFICANT_RIGHT_JUMP_SECONDS and fillerPrev <= ICON_NEAR_ZERO_WINDOW_SECONDS then
            significantRightJump = true
        end
    end

    if significantRightJump then
        self._iconSuppressUntil = now + ICON_GCD_SUPPRESS_SECONDS
    end
    local iconsSuppressed = (self._iconSuppressUntil or 0) > now

    self._iconPrevDelays = self._iconPrevDelays or {}
    self._iconPrevDelays.soc = socDisplayed and (soCVisualDelay or 0) or nil
    self._iconPrevDelays.judge = judgeDisplayed and (judgeVisualDelay or 0) or nil
    self._iconPrevDelays.cs = csDisplayed and (csVisualDelay or 0) or nil
    self._iconPrevDelays.filler = fillerDisplayed and (fillerVisualDelay or 0) or nil

    if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and false then
        local sharedGrouped = sideBySideJudgeSoc and judgeParallelActive and socShouldShow
        print(string.format(
            "[TWIST_BAR_DEBUG] swingLeft=%.3f speed=%.3f gcdLeft=%.3f socRec=%s judgeRec=%s csRec=%s socRawHold=%.3f judgeRawHold=%.3f csRawReady=%.3f socDelay=%.3f judgeDelay=%.3f csDelay=%.3f grouped=%s",
            swingLeft or 0,
            swingSpeed or 0,
            gcdLeft or 0,
            tostring(soCRecommended),
            tostring(judgeParallelActive),
            tostring(csRecommended),
            soCRawDelay or 0,
            judgeRawDelay or 0,
            csRawReady or 0,
            soCVisualDelay or 0,
            judgeVisualDelay or 0,
            csVisualDelay or 0,
            tostring(sharedGrouped)
        ))
        print(string.format(
            "[TWIST_BAR_FILLER] rec=%s spell=%s rawReady=%.3f delay=%.3f source=%s",
            tostring(fillerDisplayed),
            tostring(fillerSpellId),
            fillerRawReady or 0,
            fillerVisualDelay or 0,
            tostring(db.fillerSourcePosition or "left1")
        ))
        print(string.format(
            "[TWIST_BAR_GCD_SUPPRESS] gcdLeft=%.3f sigRightJump=%s active=%s remaining=%.3f socPrev=%.3f socDelta=%.3f judgePrev=%.3f judgeDelta=%.3f csPrev=%.3f csDelta=%.3f fillerPrev=%.3f fillerDelta=%.3f",
            gcdLeft or 0,
            tostring(significantRightJump),
            tostring(iconsSuppressed),
            math.max(0, (self._iconSuppressUntil or 0) - now),
            socPrev or -1,
            socDelta or 0,
            judgePrev or -1,
            judgeDelta or 0,
            csPrev or -1,
            csDelta or 0,
            fillerPrev or -1,
            fillerDelta or 0
        ))
    end

    self:ApplyJudgeSocBackgroundTransforms(judgeParallelActive)

    local socActionSecondsDebug = nil
    local judgeActionSecondsDebug = nil
    local csActionSecondsDebug = nil
    local fillerActionSecondsDebug = nil
    local socXDebug = nil
    local judgeXDebug = nil
    local csXDebug = nil
    local csYDebug = nil
    local fillerXDebug = nil
    local fillerYDebug = nil
    local csFadeAlphaDebug = nil
    local predictionTopLaneOffsetY = db.predictionTopLaneOffsetY or 12
    local predictionBottomLaneOffsetY = db.predictionBottomLaneOffsetY or -12
    local predictionCSSplitExtraOffsetY = db.predictionCSSplitExtraOffsetY or -14

    -- SoC icon lane: shown whenever SoC is recommended (PRIMARY or AOE).
    if socIconSparkFrame then
        if iconsSuppressed then
            GetPredictionIconFadeAlpha(self, "soc", false, now)
            SetSparkKeybind(socIconSparkFrame, false)
            socIconSparkFrame:Hide()
            socIconSparkFrame:SetAlpha(1)
            if socIconSparkBackground then
                socIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                socIconSparkBackground:Hide()
            end
        elseif db.showSwingIconSpark and db.showSocIcon ~= false and socShouldShow and soCId then
            local displaySoCId = resolvedSoCId or soCId
            local socTexture = (displaySoCId and NAG.Spell and NAG.Spell[displaySoCId] and NAG.Spell[displaySoCId].icon)
                or (displaySoCId and _G.GetSpellTexture and _G.GetSpellTexture(displaySoCId))
                or "Interface\\Icons\\INV_Misc_QuestionMark"
            if socTexture ~= lastSoCIconTexture then
                lastSoCIconTexture = socTexture
                if socIconSparkIcon then
                    socIconSparkIcon:SetTexture(socTexture)
                end
            end

            local soCActionDelay = soCVisualDelay or 0
            -- Icon timing convention:
            -- - SoB/SoM weapon icon follows the moving swing timeline (handled in the weapon spark lane).
            -- - SoC/Judge "cast now" (delay == 0) should sit on the fixed zero marker (swing moment),
            --   not on the moving swing spark.
            local socActionSeconds
            if (soCActionDelay or 0) <= SECONDS_EPSILON then
                socActionSeconds = 0
            else
                -- Weave-style visualization: map HOLD countdown directly to timeline distance
                -- from the fixed zero marker so it moves smoothly each frame.
                socActionSeconds = ClampActionSecondsForTimeline(soCActionDelay, swingSpeed)
            end
            if socActionSeconds < 0 then
                socActionSeconds = 0
            end
            socActionSecondsDebug = socActionSeconds
            local socX = SecondsBeforeSwingToX(socActionSeconds, width, swingSpeed)
            local socIconSize = socIconSparkFrame:GetWidth() or 16
            local topY = swingCenterY + (swingHeight / 2) + (socIconSize / 2) + 1 + predictionTopLaneOffsetY
            if sideBySideJudgeSoc and judgeParallelActive then
                socX = socX + (db.socSideBySideOffsetX or 0)
                topY = topY + (db.judgeSocSideBySideOffsetY or 0)
            end
            socXDebug = socX
            socIconSparkFrame:ClearAllPoints()
            socIconSparkFrame:SetPoint("CENTER", frame, "LEFT", toVisualX(socX), topY)

            if socIconSparkBackground then
                local r, g, b, a = GetIconTintByActionRemaining(soCActionDelay or 0)
                socIconSparkBackground:SetVertexColor(r, g, b, a)
                socIconSparkBackground:Show()
            end
            socIconSparkFrame.spellId = soCId
            socIconSparkFrame:SetAlpha(GetPredictionIconFadeAlpha(self, "soc", true, now))
            socIconSparkFrame:Show()
            SetSparkKeybind(socIconSparkFrame, self.db.class.showKeybindOnBar)
        else
            GetPredictionIconFadeAlpha(self, "soc", false, now)
            SetSparkKeybind(socIconSparkFrame, false)
            socIconSparkFrame:Hide()
            socIconSparkFrame:SetAlpha(1)
            if socIconSparkBackground then
                socIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                socIconSparkBackground:Hide()
            end
        end
    end

    -- Judgement parallel lane: shown with SoC split recommendations, rendered below the bar.
    if judgeIconSparkFrame then
        local judgeActive = judgeParallelActive
        if iconsSuppressed then
            GetPredictionIconFadeAlpha(self, "judge", false, now)
            SetSparkKeybind(judgeIconSparkFrame, false)
            judgeIconSparkFrame:Hide()
            judgeIconSparkFrame:SetAlpha(1)
            if judgeIconSparkBackground then
                judgeIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                judgeIconSparkBackground:Hide()
            end
        elseif db.showSwingIconSpark and db.showJudgeIcon ~= false and judgeActive then
            local judgeTexture = (NAG.Spell and NAG.Spell[20271] and NAG.Spell[20271].icon)
                or (_G.GetSpellTexture and _G.GetSpellTexture(20271))
                or "Interface\\Icons\\INV_Misc_QuestionMark"
            if judgeTexture ~= lastJudgeIconTexture then
                lastJudgeIconTexture = judgeTexture
                if judgeIconSparkIcon then
                    judgeIconSparkIcon:SetTexture(judgeTexture)
                end
            end

            local judgeActionDelay = judgeVisualDelay or 0
            local judgeActionSeconds
            if (judgeActionDelay or 0) <= SECONDS_EPSILON then
                judgeActionSeconds = 0
            else
                -- Weave-style visualization: map HOLD countdown directly to timeline distance
                -- from the fixed zero marker so it moves smoothly each frame.
                judgeActionSeconds = ClampActionSecondsForTimeline(judgeActionDelay, swingSpeed)
            end
            if judgeActionSeconds < 0 then
                judgeActionSeconds = 0
            end
            judgeActionSecondsDebug = judgeActionSeconds
            local judgeX = SecondsBeforeSwingToX(judgeActionSeconds, width, swingSpeed)
            local judgeIconSize = judgeIconSparkFrame:GetWidth() or 16
            local judgeY
            if sideBySideJudgeSoc then
                judgeY = swingCenterY + (swingHeight / 2) + (judgeIconSize / 2) + 1 + predictionTopLaneOffsetY + (db.judgeSocSideBySideOffsetY or 0)
                judgeX = judgeX + (db.judgeSideBySideOffsetX or 0)
            else
                judgeY = swingCenterY - (swingHeight / 2) - (judgeIconSize / 2) - 1 + predictionBottomLaneOffsetY
            end
            judgeXDebug = judgeX
            judgeIconSparkFrame:ClearAllPoints()
            judgeIconSparkFrame:SetPoint("CENTER", frame, "LEFT", toVisualX(judgeX), judgeY)

            if judgeIconSparkBackground then
                local r, g, b, a = GetIconTintByActionRemaining(judgeActionDelay or 0)
                judgeIconSparkBackground:SetVertexColor(r, g, b, a)
                judgeIconSparkBackground:Show()
            end
            judgeIconSparkFrame:SetAlpha(GetPredictionIconFadeAlpha(self, "judge", true, now))
            judgeIconSparkFrame:Show()
            SetSparkKeybind(judgeIconSparkFrame, self.db.class.showKeybindOnBar)
        else
            GetPredictionIconFadeAlpha(self, "judge", false, now)
            SetSparkKeybind(judgeIconSparkFrame, false)
            judgeIconSparkFrame:Hide()
            judgeIconSparkFrame:SetAlpha(1)
            if judgeIconSparkBackground then
                judgeIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                judgeIconSparkBackground:Hide()
            end
        end
    end

    -- CS icon lane: shown when Crusader Strike is currently recommended.
    if csIconSparkFrame then
        if iconsSuppressed then
            GetPredictionIconFadeAlpha(self, "cs", false, now)
            SetSparkKeybind(csIconSparkFrame, false)
            csIconSparkFrame:Hide()
            csIconSparkFrame:SetAlpha(1)
            if csIconSparkBackground then
                csIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                csIconSparkBackground:Hide()
            end
        elseif db.showSwingIconSpark and db.showCSIcon ~= false and csRecommended then
            local csTexture = (NAG.Spell and NAG.Spell[35395] and NAG.Spell[35395].icon)
                or (_G.GetSpellTexture and _G.GetSpellTexture(35395))
                or "Interface\\Icons\\INV_Misc_QuestionMark"
            if csTexture ~= lastCSIconTexture then
                lastCSIconTexture = csTexture
                if csIconSparkIcon then
                    csIconSparkIcon:SetTexture(csTexture)
                end
            end

            local csActionDelay = csVisualDelay or 0
            local csActionSeconds
            if (csActionDelay or 0) <= SECONDS_EPSILON then
                csActionSeconds = 0
            else
                csActionSeconds = ClampActionSecondsForTimeline(csActionDelay, swingSpeed)
            end
            csActionSecondsDebug = csActionSeconds

            local csX = SecondsBeforeSwingToX(csActionSeconds, width, swingSpeed)
            local csIconSize = csIconSparkFrame:GetWidth() or 16
            local csY
            local csLaneMode = db.csLaneMode or "auto"
            local csUseTopLane = sideBySideJudgeSoc
            if csLaneMode == "top" then
                csUseTopLane = true
            elseif csLaneMode == "bottom" then
                csUseTopLane = false
            end
            if csUseTopLane then
                -- Top-group alignment: same vertical baseline as SoC/Judgement top cluster.
                csY = swingCenterY + (swingHeight / 2) + (csIconSize / 2) + 1 + predictionTopLaneOffsetY + (db.judgeSocSideBySideOffsetY or 0)
            else
                -- Dedicated lower lane in split mode (or forced bottom mode).
                csY = swingCenterY - (swingHeight / 2) - (csIconSize / 2) - 1 + predictionBottomLaneOffsetY + predictionCSSplitExtraOffsetY
            end
            csXDebug = csX
            csYDebug = csY
            csIconSparkFrame:ClearAllPoints()
            csIconSparkFrame:SetPoint("CENTER", frame, "LEFT", toVisualX(csX), csY)

            if csIconSparkBackground then
                local r, g, b, a = GetIconTintByActionRemaining(csActionDelay or 0)
                csIconSparkBackground:SetVertexColor(r, g, b, a)
                csIconSparkBackground:Show()
            end
            csFadeAlphaDebug = GetPredictionIconFadeAlpha(self, "cs", true, now)
            csIconSparkFrame:SetAlpha(csFadeAlphaDebug)
            csIconSparkFrame:Show()
            SetSparkKeybind(csIconSparkFrame, self.db.class.showKeybindOnBar)
        else
            GetPredictionIconFadeAlpha(self, "cs", false, now)
            SetSparkKeybind(csIconSparkFrame, false)
            csIconSparkFrame:Hide()
            csIconSparkFrame:SetAlpha(1)
            if csIconSparkBackground then
                csIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                csIconSparkBackground:Hide()
            end
        end
    end

    if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and false then
        local csSmooth = holdSmoothState and holdSmoothState["cs"] or nil
        local csSmoothRaw = csSmooth and csSmooth.raw or nil
        local csSmoothPredicted = csSmooth and csSmooth.predicted or nil
        local csSmoothLastSample = csSmooth and csSmooth.lastSampleAt or nil
        local zeroStickActive = self._zeroStickState and self._zeroStickState.cs and true or false
        if csRecommended or csDisplayed then
            print(string.format(
                "[TWIST_BAR_CS_DEBUG] show=%s rec=%s rawReady=%.3f visDelay=%.3f actionSec=%.3f x=%.1f y=%.1f fade=%.2f gcdLeft=%.3f prev=%.3f delta=%.3f suppress=%s suppressLeft=%.3f zeroStick=%s smoothRaw=%.3f smoothPred=%.3f smoothAge=%.3f laneMode=%s iconSize=%.1f",
                tostring(csDisplayed),
                tostring(csRecommended),
                csRawReady or -1,
                csVisualDelay or -1,
                csActionSecondsDebug or -1,
                csXDebug or -1,
                csYDebug or -1,
                csFadeAlphaDebug or -1,
                gcdLeft or 0,
                csPrev or -1,
                csDelta or 0,
                tostring(iconsSuppressed),
                math.max(0, (self._iconSuppressUntil or 0) - now),
                tostring(zeroStickActive),
                csSmoothRaw or -1,
                csSmoothPredicted or -1,
                (csSmoothLastSample and (now - csSmoothLastSample)) or -1,
                tostring(db.csLaneMode or "auto"),
                (csIconSparkFrame and csIconSparkFrame:GetWidth()) or -1
            ))
        end
    end

    -- Filler icon lane: Consecration/Exorcism on reverted Judgement lane.
    if fillerIconSparkFrame then
        if iconsSuppressed then
            GetPredictionIconFadeAlpha(self, "filler", false, now)
            SetSparkKeybind(fillerIconSparkFrame, false)
            fillerIconSparkFrame:Hide()
            fillerIconSparkFrame:SetAlpha(1)
            if fillerIconSparkBackground then
                fillerIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                fillerIconSparkBackground:Hide()
            end
        elseif db.showSwingIconSpark and db.showFillerIconSpark and fillerSpellId then
            local fillerTexture = (NAG.Spell and NAG.Spell[fillerSpellId] and NAG.Spell[fillerSpellId].icon)
                or (_G.GetSpellTexture and _G.GetSpellTexture(fillerSpellId))
                or "Interface\\Icons\\INV_Misc_QuestionMark"
            if fillerTexture ~= lastFillerIconTexture then
                lastFillerIconTexture = fillerTexture
                if fillerIconSparkIcon then
                    fillerIconSparkIcon:SetTexture(fillerTexture)
                end
            end

            local fillerActionDelay = fillerVisualDelay or 0
            local fillerActionSeconds
            if (fillerActionDelay or 0) <= SECONDS_EPSILON then
                fillerActionSeconds = 0
            else
                fillerActionSeconds = ClampActionSecondsForTimeline(fillerActionDelay, swingSpeed)
            end
            fillerActionSecondsDebug = fillerActionSeconds

            local fillerX = SecondsBeforeSwingToX(fillerActionSeconds, width, swingSpeed) + (db.fillerOffsetX or 0)
            local fillerIconSize = fillerIconSparkFrame:GetWidth() or 16
            local fillerLaneMode = db.fillerLaneMode or "bottom"
            local fillerY
            if fillerLaneMode == "top" then
                fillerY = swingCenterY + (swingHeight / 2) + (fillerIconSize / 2) + 1 + predictionTopLaneOffsetY + (db.fillerOffsetY or 0)
            else
                fillerY = swingCenterY - (swingHeight / 2) - (fillerIconSize / 2) - 1 + predictionBottomLaneOffsetY + (db.fillerOffsetY or 0)
            end
            fillerXDebug = fillerX
            fillerYDebug = fillerY
            fillerIconSparkFrame.spellId = fillerSpellId
            fillerIconSparkFrame:ClearAllPoints()
            fillerIconSparkFrame:SetPoint("CENTER", frame, "LEFT", toVisualX(fillerX), fillerY)

            if fillerIconSparkBackground then
                local r, g, b, a = GetIconTintByActionRemaining(fillerActionDelay or 0)
                fillerIconSparkBackground:SetVertexColor(r, g, b, a)
                fillerIconSparkBackground:Show()
            end
            fillerIconSparkFrame:SetAlpha(GetPredictionIconFadeAlpha(self, "filler", true, now))
            fillerIconSparkFrame:Show()
            SetSparkKeybind(fillerIconSparkFrame, self.db.class.showKeybindOnBar)
        else
            GetPredictionIconFadeAlpha(self, "filler", false, now)
            SetSparkKeybind(fillerIconSparkFrame, false)
            fillerIconSparkFrame:Hide()
            fillerIconSparkFrame:SetAlpha(1)
            if fillerIconSparkBackground then
                fillerIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
                fillerIconSparkBackground:Hide()
            end
        end
    end

    if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and false then
        print(string.format(
            "[TWIST_BAR_POS] socSeconds=%.3f judgeSeconds=%.3f csSeconds=%.3f fillerSeconds=%.3f socX=%.1f judgeX=%.1f csX=%.1f csY=%.1f fillerX=%.1f fillerY=%.1f",
            socActionSecondsDebug or -1,
            judgeActionSecondsDebug or -1,
            csActionSecondsDebug or -1,
            fillerActionSecondsDebug or -1,
            socXDebug or -1,
            judgeXDebug or -1
            ,
            csXDebug or -1,
            csYDebug or -1,
            fillerXDebug or -1,
            fillerYDebug or -1
        ))
    end

    -- Past swing spark: show the most recent swing in the fixed 0.4s history region.
    if pastSwingSpark and historyPx and historyPx > 0 and swingSpeed and swingSpeed > 0 then
        local timeSinceSwing = swingSpeed - (swingLeft or 0)
        local historySeconds = 0.4
        if timeSinceSwing < 0 then timeSinceSwing = 0 end

        if historySeconds > 0 and timeSinceSwing <= historySeconds then
            local t = Clamp01(timeSinceSwing / historySeconds)
            local x = historyPx * (1 - t)
            pastSwingSpark:SetSize(2, swingHeight)
            pastSwingSpark:ClearAllPoints()
            pastSwingSpark:SetPoint("CENTER", frame, "LEFT", toVisualX(x), swingCenterY)
            pastSwingSpark:Show()
        else
            pastSwingSpark:Hide()
        end
    else
        pastSwingSpark:Hide()
    end

    -- ============================ GCD LANE (separate, below swing lane) ============================
    -- GCD bar: 2px height, positioned 6px below the swing lane so it doesn't block the view.
    local gcd = gcdLeft
    local clampedGcd = gcd
    if clampedGcd < 0 then clampedGcd = 0 end
    if clampedGcd > swingSpeed then clampedGcd = swingSpeed end
    if showGCDLane then
        gcdBar:ClearAllPoints()
        local gcdProgress = Clamp01(clampedGcd / swingSpeed)
        gcdBar:SetWidth(futurePx * gcdProgress)
        gcdBar:SetHeight(gcdHeight)
        if leftToRight then
            -- Fill left-to-right: anchor right edge at swing moment, bar extends leftward.
            gcdBar:SetPoint("RIGHT", frame, "LEFT", toVisualX(historyPx), gcdCenterY)
        else
            gcdBar:SetPoint("LEFT", frame, "LEFT", toVisualX(historyPx), gcdCenterY)
        end
    end
    if showGCDLane and gcd > 0 then
        gcdBar:Show()
        if db.showGCDSparks ~= false then
            -- Right spark: bottom-aligned to the GCD bar.
            gcdSpark:SetSize(2, gcdSparkHeight)
            gcdSpark:ClearAllPoints()
            gcdSpark:SetPoint("BOTTOM", gcdBar, "BOTTOMRIGHT", 0, 0)
            gcdSpark:Show()

            -- Left spark: bottom-aligned to the GCD bar.
            if gcdSparkLeft then
                gcdSparkLeft:SetSize(2, gcdSparkHeight)
                gcdSparkLeft:ClearAllPoints()
                gcdSparkLeft:SetPoint("BOTTOM", gcdBar, "BOTTOMLEFT", 0, 0)
                gcdSparkLeft:Show()
            end
        else
            gcdSpark:Hide()
            if gcdSparkLeft then
                gcdSparkLeft:Hide()
            end
        end
    else
        gcdBar:Hide()
        gcdSpark:Hide()
        if gcdSparkLeft then
            gcdSparkLeft:Hide()
        end
    end

    -- ============================ TWIST WINDOW VISUALIZATION ============================
    -- Twist window bar only shows when SoC is the active seal, but the "zero spark" stays visible
    -- whenever the option is enabled (acts as a fixed reference mark).
    if db.showTwistWindow and twistWindowBar then
        local window = db.twistWindowSeconds or 0.4
        if window < 0 then window = 0 end
        if window > swingSpeed then window = swingSpeed end

        -- Zero mark spark: fixed reference tick at the swing boundary (where the twist gap used to be static).
        -- This should always be visible when the twist window feature is enabled, even if the moving gap hides.
        if twistZeroSpark then
            twistZeroSpark:SetSize(2, swingHeight)
            twistZeroSpark:ClearAllPoints()
            twistZeroSpark:SetPoint("CENTER", frame, "LEFT", toVisualX(historyPx), swingCenterY)
            twistZeroSpark:Show()
        end

        -- Moving twist gap: [spark-window, spark] where spark is the current swing marker position.
        -- Visibility is tied to the auto spark/icon gate (same as swingIconSparkFrame visibility).
        if autoSparkVisible then
            local startSeconds = (swingLeft or 0) - window
            local endSeconds = (swingLeft or 0)
            local startX = SecondsBeforeSwingToX(startSeconds, width, swingSpeed)
            local endX = SecondsBeforeSwingToX(endSeconds, width, swingSpeed)
            local barWidth = endX - startX

            if barWidth > 0 then
                -- Dynamic twist gap color:
                -- - keep configured alpha
                -- - yellow when left edge is < 1.0s from fixed zero mark
                -- - green when left edge is < 0.05s from fixed zero mark
                local base = db.twistWindowColor or defaults.class.twistWindowColor
                local a = (base and base.a) or 0.18
                local timeToZero = (swingLeft or 0) - window -- when this hits 0, left edge reaches fixed zero mark
                if timeToZero < 0 then timeToZero = 0 end
                if timeToZero <= 0.05 then
                    twistWindowBar:SetColorTexture(0.20, 0.95, 0.35, a)
                elseif timeToZero < 1.0 then
                    twistWindowBar:SetColorTexture(1.0, 1.0, 0.0, a)
                else
                    twistWindowBar:SetColorTexture(base.r or 0.90, base.g or 0.90, base.b or 0.90, a)
                end

                twistWindowBar:SetHeight(swingHeight)
                twistWindowBar:SetWidth(barWidth)
                twistWindowBar:ClearAllPoints()
                twistWindowBar:SetPoint("LEFT", frame, "LEFT", leftToRight and toVisualX(endX) or toVisualX(startX), swingCenterY)
                twistWindowBar:Show()
            else
                twistWindowBar:Hide()
            end

        else
            twistWindowBar:Hide()
        end

        -- Optional div boundary marker:
        -- fixed reference where a fresh GCD can still finish before the twist window opens.
        if divBoundaryMarker then
            if db.showDivBoundaryMarker and autoSparkVisible then
                local lastGCDValue = NAG.GCDTimeValue and NAG:GCDTimeValue() or 0
                if lastGCDValue < 0 then lastGCDValue = 0 end
                local markerSecondsBeforeSwing = (swingLeft or 0) - window - lastGCDValue
                local markerX = SecondsBeforeSwingToX(markerSecondsBeforeSwing, width, swingSpeed)
                if markerX >= 0 and markerX <= width then
                    divBoundaryMarker:SetSize(2, swingHeight)
                    divBoundaryMarker:ClearAllPoints()
                    divBoundaryMarker:SetPoint("CENTER", frame, "LEFT", toVisualX(markerX), swingCenterY)
                    divBoundaryMarker:Show()
                else
                    divBoundaryMarker:Hide()
                end
            else
                divBoundaryMarker:Hide()
            end
        end
    else
        if twistWindowBar then twistWindowBar:Hide() end
        if twistZeroSpark then twistZeroSpark:Hide() end
        if divBoundaryMarker then divBoundaryMarker:Hide() end
    end

    -- Debug prints (always-on, throttled): verify all geometry inputs live.
    local throttle = db.debugThrottleSeconds or 0.25
    if throttle < 0 then throttle = 0 end

    local gcdShown = gcdBar:IsShown()
    local gcdW = gcdBar:GetWidth() or 0
    local swingW = swingBar:GetWidth() or 0
    local twistShown = twistWindowBar and twistWindowBar:IsShown() or false
    local feasibleShown = false
    local divShown = divBoundaryMarker and divBoundaryMarker:IsShown() or false

    -- Calculate markerX for debug output only
    local markerX = swingW or 0

    self:ThrottledInfo(
        "RetTwistBar: combat=%d gcd=%.3f swingLeft=%.3f speed=%.3f swingProg=%.3f markerX=%.1f gcdW=%.1f twistShown=%d feasibleShown=%d divShown=%d",
        "retTwistBar_debug_core",
        throttle,
        To01(UnitAffectingCombat("player")),
        gcd,
        swingLeft,
        swingSpeed,
        swingProgress,
        markerX,
        gcdW,
        To01(twistShown),
        To01(feasibleShown),
        To01(divShown)
    )

    -- ============================ TWIST SUCCESS TOAST (SUCCESS-ONLY) ============================
    -- Triggered by `PaladinRetTwistModule` on swing impact via raw aura scanning.
    if twistOutcomeText and NAG.RetTwistGetLastSuccess then
        local lastSuccessTime, _, twistId = NAG:RetTwistGetLastSuccess()
        if lastSuccessTime and lastSuccessTime > 0 and self._retTwistToastLastSuccessTime ~= lastSuccessTime then
            self._retTwistToastLastSuccessTime = lastSuccessTime
            self._retTwistToastStartTime = GetTime()
            local toast = buildSuccessToast(twistId)
            self._retTwistToastText = toast.text
            self._retTwistToastColor = { toast.r, toast.g, toast.b }
        end
    end

    -- Render the toast:
    -- - Solid for 1.0s
    -- - Fade out over the next 1.0s (total lifetime 2.0s)
    -- - While fading, slide up by 30px
    if twistOutcomeText and self._retTwistToastStartTime and self._retTwistToastText then
        local now = GetTime()
        local age = now - (self._retTwistToastStartTime or now)
        if age < 0 then age = 0 end

        if age >= 2.0 then
            twistOutcomeText:Hide()
            self._retTwistToastStartTime = nil
            self._retTwistToastText = nil
            self._retTwistToastColor = nil
        else
            local a = 1.0
            local slideUp = 0
            if age > 1.0 then
                local t = (age - 1.0) / 1.0 -- 0..1 over the fade window
                if t < 0 then t = 0 end
                if t > 1 then t = 1 end
                a = 1.0 - t
                slideUp = 30 * t
            end

            -- Position centered above the swing lane.
            twistOutcomeText:ClearAllPoints()
            twistOutcomeText:SetPoint("BOTTOM", frame, "LEFT", width * 0.5, swingCenterY + (swingHeight / 2) + 2 + slideUp)

            twistOutcomeText:SetText(self._retTwistToastText)
            local c = self._retTwistToastColor
            local effectiveAlpha = a * (targetAlpha or 1.0)
            if c then
                twistOutcomeText:SetTextColor(c[1], c[2], c[3], effectiveAlpha)
            else
                twistOutcomeText:SetTextColor(1, 1, 1, effectiveAlpha)
            end
            twistOutcomeText:Show()
        end
    elseif twistOutcomeText then
        twistOutcomeText:Hide()
    end
end

-- ============================ UI BUILD ============================
function PaladinRetTwistBar:CreateFrameUI()
    if frame then return end

    OptionsFactory = NAG:GetModule("OptionsFactory")
    local db = self.db.class
    local predictionIconSize = math.floor(db.predictionIconSize or 16)
    if predictionIconSize < 8 then predictionIconSize = 8 end
    if predictionIconSize > 48 then predictionIconSize = 48 end
    local predictionRingSize = predictionIconSize + 21

    frame = CreateFrame("Frame", "NAGPaladinRetTwistBar", _G.UIParent)
    -- Initial size (UpdateDisplay will recompute precisely)
    frame:SetSize(db.width, (db.height + 5) + 6 + 5)
    frame:SetPoint(db.point, db.x, db.y)
    frame:SetAlpha(db.alpha or 1.0)
    frame:Hide()
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
    frame:SetScript("OnDragStart", function()
        if InCombatLockdown and InCombatLockdown() then
            return
        end
        if not (moduleSelf and moduleSelf.db and moduleSelf.db.class) then
            return
        end
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if not canDrag then
            return
        end
        frame:StartMoving()
    end)

    -- Right-click context menu (disable/toggle off entirely).
    frame.contextMenu = frame.contextMenu or CreateFrame("Frame", "NAGPaladinRetTwistBarContextMenu", frame,
        "UIDropDownMenuTemplate")
    local moduleSelf = self

    -- Use an invisible Button overlay as the click target:
    -- - Larger hitbox than the visible bar
    -- - Higher frame level so it receives mouse clicks reliably
    clickCatcher = CreateFrame("Button", nil, frame)
    clickCatcher:SetPoint("TOPLEFT", frame, "TOPLEFT", -6, 6)
    clickCatcher:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 6, -6)
    clickCatcher:SetFrameLevel((frame:GetFrameLevel() or 0) + 50)
    clickCatcher:EnableMouse(true)
    clickCatcher:RegisterForClicks("RightButtonUp")
    -- Forward drag to frame so frame receives OnDragStop (frame has the position/save logic)
    clickCatcher:RegisterForDrag("LeftButton")
    clickCatcher:SetScript("OnDragStart", function()
        if frame and frame.StartMoving then
            frame:StartMoving()
        end
    end)
    clickCatcher:SetScript("OnDragStop", function()
        if not frame or not frame.StopMovingOrSizing then return end
        frame:StopMovingOrSizing()
        if not (moduleSelf and moduleSelf.db and moduleSelf.db.class) then return end
        local db = moduleSelf.db.class
        local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
        if anchor and anchor ~= _G.UIParent and db.autoAnchor then
            -- Read positions first while frame is still where the user dropped it (match Hunter bar).
            local saved = false
            local offsetX, offsetY
            if db.anchorSide == "right" then
                local barLeft, barBottom = frame:GetLeft(), frame:GetBottom()
                local anchorRight, anchorBottom = anchor:GetRight(), anchor:GetBottom()
                if barLeft and barBottom and anchorRight and anchorBottom then
                    offsetX = barLeft - anchorRight
                    offsetY = barBottom - anchorBottom
                    saved = true
                end
            else
                local barCenterX = select(1, frame:GetCenter())
                local barTop = frame:GetTop()
                local anchorCenterX = select(1, anchor:GetCenter())
                local anchorBottom = anchor:GetBottom()
                if barCenterX and barTop and anchorCenterX and anchorBottom then
                    offsetX = barCenterX - anchorCenterX
                    offsetY = barTop - anchorBottom
                    saved = true
                end
            end
            -- Save to db FIRST so any re-entrant UpdateFrameAnchor uses the new position (prevents snap-left).
            if saved then
                if db.anchorSide == "right" then
                    db.point = "BOTTOMLEFT"
                    db.x = offsetX
                    db.y = offsetY
                else
                    db.point = "TOP"
                    db.x = offsetX
                    db.y = offsetY
                end
            end
            -- Then clear and re-anchor using saved or existing offsets.
            frame:SetParent(_G.UIParent)
            frame:ClearAllPoints()
            if saved then
                if db.anchorSide == "right" then
                    frame:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", offsetX, offsetY)
                else
                    frame:SetPoint("TOP", anchor, "BOTTOM", offsetX, offsetY)
                end
            else
                -- Offset calc failed; keep autoAnchor and re-apply with existing db so bar stays attached.
                if db.anchorSide == "right" then
                    frame:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", db.x or 8, db.y or 0)
                else
                    frame:SetPoint("TOP", anchor, "BOTTOM", db.x, db.y)
                end
            end
        else
            local left, bottom = frame:GetLeft(), frame:GetBottom()
            if left and bottom then
                -- Save to db FIRST so any re-entrant UpdateFrameAnchor uses the new position (prevents snap-left).
                db.point = "BOTTOMLEFT"
                db.x = left
                db.y = bottom
                db.userPositioned = true
                db.autoAnchor = false
                -- Then re-anchor in UIParent space.
                frame:SetParent(_G.UIParent)
                frame:ClearAllPoints()
                frame:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", left, bottom)
            else
                local point, _, _, x, y = frame:GetPoint(1)
                if point then db.point = point end
                db.x = x or db.x or 0
                db.y = y or db.y or 0
                db.userPositioned = true
                db.autoAnchor = false
            end
        end
    end)

    local function showContextMenu()
        local function isAutoAttackImageEnabled()
            return moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.showSwingIconSpark
        end

        local function toggleAutoAttackImage()
            if not (moduleSelf and moduleSelf.db and moduleSelf.db.class) then
                return
            end
            moduleSelf.db.class.showSwingIconSpark = not moduleSelf.db.class.showSwingIconSpark
            if moduleSelf.UpdateDisplay and frame then
                moduleSelf:UpdateDisplay()
            end
        end

        local function isLocked()
            local dm = NAG:GetModule("DisplayManager")
            return not (dm and dm.classHelperEditMode)
        end

        local function toggleLocked()
            local dm = NAG:GetModule("DisplayManager")
            if not dm then return end
            local wasLocked = not dm.classHelperEditMode
            local newLocked = not wasLocked
            dm.classHelperEditMode = not newLocked
            NAG:SendMessage("NAG_FRAME_UPDATED")

            -- When unlocking: do NOT clear autoAnchor - let user drag and save offset so bar stays attached.
            -- When locking: if user manual-positioned during this session, keep autoAnchor off.
            if not newLocked and moduleSelf and moduleSelf.db and moduleSelf.db.class then
                if moduleSelf.UpdateVisibility then
                    moduleSelf:UpdateVisibility()
                end
                if CloseDropDownMenus then
                    CloseDropDownMenus()
                end
            else
                if moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.userPositioned then
                    moduleSelf.db.class.autoAnchor = false
                end
                -- Defer UpdateVisibility when locking so the display/anchor has settled before we re-apply anchor+offset.
                if moduleSelf and moduleSelf.UpdateVisibility then
                    local doUpdate = function()
                        if moduleSelf and moduleSelf.UpdateVisibility then
                            moduleSelf:UpdateVisibility()
                        end
                    end
                    if C_Timer and C_Timer.After then
                        C_Timer.After(0, doUpdate)
                    else
                        doUpdate()
                    end
                end
            end
        end

        local function isAnchored()
            return moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.autoAnchor ~= false
        end

        local function toggleAnchored()
            if not (moduleSelf and moduleSelf.db and moduleSelf.db.class) then
                return
            end
            local newAnchored = not (moduleSelf.db.class.autoAnchor ~= false)
            moduleSelf.db.class.autoAnchor = newAnchored
            if newAnchored then
                moduleSelf.db.class.userPositioned = false
                -- Snap back to the original anchored defaults.
                moduleSelf.db.class.point = defaults.class.point
                moduleSelf.db.class.x = defaults.class.x
                moduleSelf.db.class.y = defaults.class.y
            end
            if moduleSelf.UpdateVisibility then
                moduleSelf:UpdateVisibility()
            end
        end

        local function confirmDisable()
            if StaticPopup_Show then
                StaticPopup_Show("NAG_RET_TWIST_BAR_DISABLE_CONFIRM", nil, nil, { module = moduleSelf })
            end
        end

        local function confirmReset()
            if StaticPopup_Show then
                StaticPopup_Show("NAG_RET_TWIST_BAR_RESET_CONFIRM", nil, nil, { module = moduleSelf })
            end
        end

        local menu = {
            { text = "Ret Twist Bar", isTitle = true, notCheckable = true },
            {
                text = "Auto Attack image",
                isNotRadio = true,
                keepShownOnClick = true,
                checked = isAutoAttackImageEnabled,
                func = toggleAutoAttackImage,
            },
            {
                text = "Locked",
                isNotRadio = true,
                keepShownOnClick = true,
                checked = isLocked,
                func = toggleLocked,
            },
            {
                text = "Anchor to NAG",
                isNotRadio = true,
                keepShownOnClick = true,
                checked = isAnchored,
                func = toggleAnchored,
            },
            {
                text = "Restore Defaults",
                notCheckable = true,
                func = confirmReset,
            },
            {
                text = "Disable Bar",
                notCheckable = true,
                func = confirmDisable,
            },
            {
                text = "Cancel",
                notCheckable = true,
                func = function()
                    if CloseDropDownMenus then
                        CloseDropDownMenus()
                    end
                end
            },
        }

        if EasyMenu then
            EasyMenu(menu, frame.contextMenu, "cursor", 0, 0, "MENU")
            return
        end

        -- Fallback for clients without EasyMenu: use UIDropDownMenu_Initialize + ToggleDropDownMenu.
        if UIDropDownMenu_Initialize and UIDropDownMenu_AddButton and ToggleDropDownMenu then
            UIDropDownMenu_Initialize(frame.contextMenu, function(_, level)
                for i = 1, #menu do
                    UIDropDownMenu_AddButton(menu[i], level)
                end
            end, "MENU")
            ToggleDropDownMenu(1, nil, frame.contextMenu, "cursor", 0, 0)
        end
    end

    clickCatcher:SetScript("OnClick", function(_, button)
        if button ~= "RightButton" then
            return
        end
        showContextMenu()
    end)

    -- Background (lowest) - sized/positioned dynamically in UpdateDisplay so it only covers the swing lane.
    background = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    background:SetColorTexture(db.backgroundColor.r, db.backgroundColor.g, db.backgroundColor.b, db.backgroundColor.a)

    -- Outcome toast text (appears above the swing lane, fades out automatically).
    twistOutcomeText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    twistOutcomeText:SetJustifyH("CENTER")
    twistOutcomeText:SetJustifyV("MIDDLE")
    twistOutcomeText:SetText("")
    -- Make toast text 100% bigger (2x).
    local fontPath, fontSize, fontFlags = twistOutcomeText:GetFont()
    if fontPath and fontSize then
        twistOutcomeText:SetFont(fontPath, fontSize * 2, fontFlags)
    end
    twistOutcomeText:Hide()

    -- Swing timer "bar" is a hidden positioning surface; only the spark line is meant to be visible.
    -- Keep it low in ARTWORK; it is fully transparent anyway.
    swingBar = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    swingBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    swingBar:SetWidth(0)
    -- Swing bar is a hidden "positioning bar" (transparent). The visible indicator is swingSpark.
    swingBar:SetColorTexture(db.swingColor.r, db.swingColor.g, db.swingColor.b, db.swingColor.a)

    -- GCD overlay bar: use a HIGH sublevel just like ShamanWeaveBar so it is unmistakably on top.
    gcdBar = frame:CreateTexture(nil, "ARTWORK", nil, 6)
    gcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    gcdBar:SetWidth(0)
    gcdBar:SetColorTexture(db.gcdColor.r, db.gcdColor.g, db.gcdColor.b, db.gcdColor.a)
    gcdBar:Hide()

    -- Twist window overlay bars: below GCD overlay, above background.
    twistWindowBar = frame:CreateTexture(nil, "ARTWORK", nil, 4)
    twistWindowBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    twistWindowBar:SetWidth(0)
    twistWindowBar:SetColorTexture(db.twistWindowColor.r, db.twistWindowColor.g, db.twistWindowColor.b, db.twistWindowColor.a)
    twistWindowBar:Hide()

    -- Zero spark: vertical tick at the left border of the twist window (0.4 marker boundary).
    twistZeroSpark = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    twistZeroSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    twistZeroSpark:Hide()

    -- Put swing spark above the GCD overlay (so you always see the actual swing moment line).
    -- Texture sublevels are limited to [-8, 7].
    swingSpark = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    swingSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    swingSpark:Hide()

    -- Past swing spark: same style as swingSpark, but rendered slightly dimmer.
    pastSwingSpark = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    pastSwingSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, (db.sparkColor.a or 0.9) * 0.55)
    pastSwingSpark:Hide()

    -- Mainhand weapon icon spark (circular), positioned above the swing marker.
    swingIconSparkFrame = CreateFrame("Frame", nil, frame)
    swingIconSparkFrame:SetSize(16, 16)
    swingIconSparkFrame:Hide()

    -- Background art for the weapon spark (sits behind the circular icon).
    -- File: NAG/media/extras/iconBar.png
    -- Use a low sublevel to guarantee this stays behind the masked weapon icon.
    swingIconSparkBackground = swingIconSparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
    swingIconSparkBackground:SetTexture("Interface\\AddOns\\NAG\\media\\extras\\iconBar3Inverted.png")
    swingIconSparkBackground:SetPoint("CENTER", swingIconSparkFrame, "CENTER", 0, 0)
    swingIconSparkBackground:SetSize(37, 37)
    swingIconSparkBackground:SetAlpha(0.95)
    swingIconSparkBackground:Hide()

    swingIconSparkIcon = swingIconSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    swingIconSparkIcon:SetAllPoints()
    swingIconSparkIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    swingIconSparkIcon:SetTexCoord(0.15, 0.85, 0.15, 0.85) -- crop for a clean look

    swingIconSparkMask = swingIconSparkFrame:CreateMaskTexture()
    swingIconSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    swingIconSparkMask:SetAllPoints()
    swingIconSparkIcon:AddMaskTexture(swingIconSparkMask)
    local swingKeybindText = swingIconSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    swingKeybindText:SetPoint("BOTTOM", swingIconSparkFrame, "TOP", 0, 2)
    swingKeybindText:SetJustifyH("CENTER")
    swingKeybindText:SetTextColor(1, 1, 0)
    swingKeybindText:SetText("")
    swingKeybindText:Hide()
    swingIconSparkFrame.keybindText = swingKeybindText

    -- SoC icon spark (mirrors SoB icon styling, independent from twist gap bar).
    socIconSparkFrame = CreateFrame("Frame", nil, frame)
    socIconSparkFrame:SetSize(predictionIconSize, predictionIconSize)
    socIconSparkFrame:Hide()

    socIconSparkBackground = socIconSparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
    socIconSparkBackground:SetTexture("Interface\\AddOns\\NAG\\media\\extras\\iconBar3Inverted.png")
    socIconSparkBackground:SetPoint("CENTER", socIconSparkFrame, "CENTER", 0, 0)
    socIconSparkBackground:SetSize(predictionRingSize, predictionRingSize)
    socIconSparkBackground:SetAlpha(0.95)
    socIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
    socIconSparkBackground:Hide()

    socIconSparkIcon = socIconSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    socIconSparkIcon:SetAllPoints()
    socIconSparkIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    socIconSparkIcon:SetTexCoord(0.15, 0.85, 0.15, 0.85)

    socIconSparkMask = socIconSparkFrame:CreateMaskTexture()
    socIconSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    socIconSparkMask:SetAllPoints()
    socIconSparkIcon:AddMaskTexture(socIconSparkMask)
    local socKeybindText = socIconSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    socKeybindText:SetPoint("BOTTOM", socIconSparkFrame, "TOP", 0, 2)
    socKeybindText:SetJustifyH("CENTER")
    socKeybindText:SetTextColor(1, 1, 0)
    socKeybindText:SetText("")
    socKeybindText:Hide()
    socIconSparkFrame.keybindText = socKeybindText

    -- Judgement icon spark (parallel lane below, background flipped to point up).
    judgeIconSparkFrame = CreateFrame("Frame", nil, frame)
    judgeIconSparkFrame:SetSize(predictionIconSize, predictionIconSize)
    judgeIconSparkFrame:Hide()

    judgeIconSparkBackground = judgeIconSparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
    judgeIconSparkBackground:SetTexture("Interface\\AddOns\\NAG\\media\\extras\\iconBar3Inverted.png")
    judgeIconSparkBackground:SetPoint("CENTER", judgeIconSparkFrame, "CENTER", 0, 0)
    judgeIconSparkBackground:SetSize(predictionRingSize, predictionRingSize)
    judgeIconSparkBackground:SetAlpha(0.95)
    judgeIconSparkBackground:SetTexCoord(0, 1, 0, 1)
    judgeIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
    judgeIconSparkBackground:Hide()

    judgeIconSparkIcon = judgeIconSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    judgeIconSparkIcon:SetAllPoints()
    judgeIconSparkIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    judgeIconSparkIcon:SetTexCoord(0.15, 0.85, 0.15, 0.85)

    judgeIconSparkMask = judgeIconSparkFrame:CreateMaskTexture()
    judgeIconSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    judgeIconSparkMask:SetAllPoints()
    judgeIconSparkIcon:AddMaskTexture(judgeIconSparkMask)
    local judgeKeybindText = judgeIconSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    judgeKeybindText:SetPoint("BOTTOM", judgeIconSparkFrame, "TOP", 0, 2)
    judgeKeybindText:SetJustifyH("CENTER")
    judgeKeybindText:SetTextColor(1, 1, 0)
    judgeKeybindText:SetText("")
    judgeKeybindText:Hide()
    judgeIconSparkFrame.keybindText = judgeKeybindText
    judgeIconSparkFrame.spellId = 20271

    -- Filler icon spark (Consecration/Exorcism) on reverted Judgement lane.
    fillerIconSparkFrame = CreateFrame("Frame", nil, frame)
    fillerIconSparkFrame:SetSize(predictionIconSize, predictionIconSize)
    fillerIconSparkFrame:Hide()

    fillerIconSparkBackground = fillerIconSparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
    fillerIconSparkBackground:SetTexture("Interface\\AddOns\\NAG\\media\\extras\\iconBar3Inverted.png")
    fillerIconSparkBackground:SetPoint("CENTER", fillerIconSparkFrame, "CENTER", 0, 0)
    fillerIconSparkBackground:SetSize(predictionRingSize, predictionRingSize)
    fillerIconSparkBackground:SetAlpha(0.95)
    fillerIconSparkBackground:SetTexCoord(0, 1, 1, 0) -- reverted lane marker
    fillerIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
    fillerIconSparkBackground:Hide()

    fillerIconSparkIcon = fillerIconSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    fillerIconSparkIcon:SetAllPoints()
    fillerIconSparkIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    fillerIconSparkIcon:SetTexCoord(0.15, 0.85, 0.15, 0.85)

    fillerIconSparkMask = fillerIconSparkFrame:CreateMaskTexture()
    fillerIconSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    fillerIconSparkMask:SetAllPoints()
    fillerIconSparkIcon:AddMaskTexture(fillerIconSparkMask)
    local fillerKeybindText = fillerIconSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fillerKeybindText:SetPoint("BOTTOM", fillerIconSparkFrame, "TOP", 0, 2)
    fillerKeybindText:SetJustifyH("CENTER")
    fillerKeybindText:SetTextColor(1, 1, 0)
    fillerKeybindText:SetText("")
    fillerKeybindText:Hide()
    fillerIconSparkFrame.keybindText = fillerKeybindText

    -- Crusader Strike icon spark (extra lane below Judgement).
    csIconSparkFrame = CreateFrame("Frame", nil, frame)
    csIconSparkFrame:SetSize(predictionIconSize, predictionIconSize)
    csIconSparkFrame:Hide()

    csIconSparkBackground = csIconSparkFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
    csIconSparkBackground:SetTexture("Interface\\AddOns\\NAG\\media\\extras\\iconBar3Inverted.png")
    csIconSparkBackground:SetPoint("CENTER", csIconSparkFrame, "CENTER", 0, 0)
    csIconSparkBackground:SetSize(predictionRingSize, predictionRingSize)
    csIconSparkBackground:SetAlpha(0.95)
    csIconSparkBackground:SetVertexColor(0.0, 0.0, 0.0, 1.0)
    csIconSparkBackground:Hide()

    csIconSparkIcon = csIconSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    csIconSparkIcon:SetAllPoints()
    csIconSparkIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    csIconSparkIcon:SetTexCoord(0.15, 0.85, 0.15, 0.85)

    csIconSparkMask = csIconSparkFrame:CreateMaskTexture()
    csIconSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    csIconSparkMask:SetAllPoints()
    csIconSparkIcon:AddMaskTexture(csIconSparkMask)
    local csKeybindText = csIconSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    csKeybindText:SetPoint("BOTTOM", csIconSparkFrame, "TOP", 0, 2)
    csKeybindText:SetJustifyH("CENTER")
    csKeybindText:SetTextColor(1, 1, 0)
    csKeybindText:SetText("")
    csKeybindText:Hide()
    csIconSparkFrame.keybindText = csKeybindText
    csIconSparkFrame.spellId = 35395

    -- GCD spark: above the GCD bar, below the swing spark.
    gcdSpark = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    gcdSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    gcdSpark:Hide()

    -- GCD left spark: same style as gcdSpark.
    gcdSparkLeft = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    gcdSparkLeft:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    gcdSparkLeft:Hide()

    -- Div boundary marker: a moving tick line for "swing - 0.4 - gcdDurationValue".
    divBoundaryMarker = frame:CreateTexture(nil, "OVERLAY", nil, 5)
    divBoundaryMarker:SetColorTexture(db.divMarkerColor.r, db.divMarkerColor.g, db.divMarkerColor.b, db.divMarkerColor.a)
    divBoundaryMarker:Hide()

    self:ApplyPredictionIconSizing()
    self:ApplyJudgeSocBackgroundTransforms()
end

-- ============================ BAR COLORS (OPTIONS APPLY) ============================
--- Applies current db.class color settings to all bar textures. Safe to call when frame not yet created.
function PaladinRetTwistBar:ApplyBarColors()
    if not frame then
        return
    end
    local db = self.db.class
    if not db then
        return
    end

    if background and db.backgroundColor then
        background:SetColorTexture(db.backgroundColor.r, db.backgroundColor.g, db.backgroundColor.b, db.backgroundColor.a)
    end
    if swingBar and db.swingColor then
        swingBar:SetColorTexture(db.swingColor.r, db.swingColor.g, db.swingColor.b, db.swingColor.a)
    end
    if gcdBar and db.gcdColor then
        gcdBar:SetColorTexture(db.gcdColor.r, db.gcdColor.g, db.gcdColor.b, db.gcdColor.a)
    end
    if twistWindowBar and db.twistWindowColor then
        twistWindowBar:SetColorTexture(db.twistWindowColor.r, db.twistWindowColor.g, db.twistWindowColor.b, db.twistWindowColor.a)
    end
    if twistZeroSpark and db.sparkColor then
        twistZeroSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    end
    if swingSpark and db.sparkColor then
        swingSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    end
    if pastSwingSpark and db.sparkColor then
        pastSwingSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, (db.sparkColor.a or 0.9) * 0.55)
    end
    if gcdSpark and db.sparkColor then
        gcdSpark:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    end
    if gcdSparkLeft and db.sparkColor then
        gcdSparkLeft:SetColorTexture(db.sparkColor.r, db.sparkColor.g, db.sparkColor.b, db.sparkColor.a)
    end
    if divBoundaryMarker and db.divMarkerColor then
        divBoundaryMarker:SetColorTexture(db.divMarkerColor.r, db.divMarkerColor.g, db.divMarkerColor.b, db.divMarkerColor.a)
    end

    self:ApplyJudgeSocBackgroundTransforms()
end

-- ============================ LIFECYCLE ============================
function PaladinRetTwistBar:ModuleInitialize()
    -- One-time position tweak: move the bar 5px down for existing users.
    -- (WoW UI Y grows upward, so "down" means subtracting.)
    if self.db and self.db.class and not self.db.class._migratedDown5 then
        self.db.class.y = (self.db.class.y or defaults.class.y or 0) - 5
        self.db.class._migratedDown5 = true
    end

    if self.db and self.db.class then
        local db = self.db.class
        if db.judgeBackgroundInverted == nil then db.judgeBackgroundInverted = defaults.class.judgeBackgroundInverted end
        if db.judgeSocLayoutMode == nil then db.judgeSocLayoutMode = defaults.class.judgeSocLayoutMode end
        if not db._migratedJudgeSocLayoutDefaultV2 then
            if db.judgeSocLayoutMode == nil or db.judgeSocLayoutMode == "split" then
                db.judgeSocLayoutMode = "sideBySide"
            end
            db._migratedJudgeSocLayoutDefaultV2 = true
        end
        if db.socSideBySideOffsetX == nil then db.socSideBySideOffsetX = defaults.class.socSideBySideOffsetX end
        if db.judgeSideBySideOffsetX == nil then db.judgeSideBySideOffsetX = defaults.class.judgeSideBySideOffsetX end
        if db.judgeSocSideBySideOffsetY == nil then db.judgeSocSideBySideOffsetY = defaults.class.judgeSocSideBySideOffsetY end
        if db.socBackgroundRotationSideBySideDeg == nil then
            db.socBackgroundRotationSideBySideDeg = defaults.class.socBackgroundRotationSideBySideDeg
        end
        if db.judgeBackgroundRotationSideBySideDeg == nil then
            db.judgeBackgroundRotationSideBySideDeg = defaults.class.judgeBackgroundRotationSideBySideDeg
        end
        if db.socBackgroundOffsetX == nil then db.socBackgroundOffsetX = defaults.class.socBackgroundOffsetX end
        if db.socBackgroundOffsetY == nil then db.socBackgroundOffsetY = defaults.class.socBackgroundOffsetY end
        if db.judgeBackgroundOffsetX == nil then db.judgeBackgroundOffsetX = defaults.class.judgeBackgroundOffsetX end
        if db.judgeBackgroundOffsetY == nil then db.judgeBackgroundOffsetY = defaults.class.judgeBackgroundOffsetY end
        if db.showFillerIconSpark == nil then db.showFillerIconSpark = defaults.class.showFillerIconSpark end
        if db.fillerSourcePosition == nil then db.fillerSourcePosition = defaults.class.fillerSourcePosition end
        if db.fillerOffsetX == nil then db.fillerOffsetX = defaults.class.fillerOffsetX end
        if db.fillerOffsetY == nil then db.fillerOffsetY = defaults.class.fillerOffsetY end
        if db.showTwistWindow == nil then db.showTwistWindow = defaults.class.showTwistWindow end
        if db.twistWindowSeconds == nil then db.twistWindowSeconds = defaults.class.twistWindowSeconds end
        if db.showDivBoundaryMarker == nil then db.showDivBoundaryMarker = defaults.class.showDivBoundaryMarker end
        if not db._migratedDivBoundaryDefaultOffV1 then
            db.showDivBoundaryMarker = false
            db._migratedDivBoundaryDefaultOffV1 = true
        end
        if db.showGCDBar == nil then db.showGCDBar = defaults.class.showGCDBar end
        if db.showGCDSparks == nil then db.showGCDSparks = defaults.class.showGCDSparks end
        if db.gcdLaneHeight == nil then db.gcdLaneHeight = defaults.class.gcdLaneHeight end
        if db.gcdLaneGap == nil then db.gcdLaneGap = defaults.class.gcdLaneGap end
        if db.gcdSparkHeight == nil then db.gcdSparkHeight = defaults.class.gcdSparkHeight end
        if db.predictionIconSize == nil then db.predictionIconSize = defaults.class.predictionIconSize end
        if db.predictionTopLaneOffsetY == nil then db.predictionTopLaneOffsetY = defaults.class.predictionTopLaneOffsetY end
        if db.predictionBottomLaneOffsetY == nil then
            db.predictionBottomLaneOffsetY = defaults.class.predictionBottomLaneOffsetY
        end
        if db.predictionCSSplitExtraOffsetY == nil then
            db.predictionCSSplitExtraOffsetY = defaults.class.predictionCSSplitExtraOffsetY
        end
        if db.showSocIcon == nil then db.showSocIcon = defaults.class.showSocIcon end
        if db.showJudgeIcon == nil then db.showJudgeIcon = defaults.class.showJudgeIcon end
        if db.showCSIcon == nil then db.showCSIcon = defaults.class.showCSIcon end
        if db.csLaneMode == nil then db.csLaneMode = defaults.class.csLaneMode end
        if db.fillerLaneMode == nil then db.fillerLaneMode = defaults.class.fillerLaneMode end
        if db.barFillDirection == nil then db.barFillDirection = defaults.class.barFillDirection end
    end

    -- No heavy work; UI built lazily.
    -- Register swing timer callbacks to force instant refresh at swing boundaries.
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
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_UPDATE", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" and hand == "mainhand" and self.UpdateDisplay then
                self:UpdateDisplay()
            end
        end)
    end
end

function PaladinRetTwistBar:ModuleEnable()
    if UnitClassBase("player") ~= "PALADIN" then
        self:SetEnabledState(false)
        return
    end

    -- Delay frame creation by 7 seconds to allow addon/spell data to fully load
    local TimerManager = ns.TimerManager
    if TimerManager then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "retTwistBarDelayedInit")
        TimerManager:Create(
            TimerManager.Categories.UI_NOTIFICATION,
            "retTwistBarDelayedInit",
            function()
                self:CreateFrameUI()
                self:UpdateVisibility()
            end,
            7.0,  -- 7 second delay
            false -- Don't repeat
        )
    else
        -- Fallback: create immediately if TimerManager not available
        self:CreateFrameUI()
        self:UpdateVisibility()
    end
end

function PaladinRetTwistBar:ModuleDisable()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
    timelineSmoothState = {}
end

-- ============================ EVENTS ============================
function PaladinRetTwistBar:PLAYER_REGEN_DISABLED()
    self:UpdateVisibility()
end

function PaladinRetTwistBar:PLAYER_REGEN_ENABLED()
    self:UpdateVisibility()
    -- Clear twist success toast state so we do not carry over or re-show from previous combat.
    self._retTwistToastLastSuccessTime = nil
    self._retTwistToastStartTime = nil
    self._retTwistToastText = nil
    self._retTwistToastColor = nil
    if twistOutcomeText then
        twistOutcomeText:Hide()
    end
    if self._pendingReloadUI and ReloadUI and (not (InCombatLockdown and InCombatLockdown())) then
        self._pendingReloadUI = false
        ReloadUI()
    end
end

function PaladinRetTwistBar:PLAYER_ENTERING_WORLD()
    self:UpdateVisibility()
end

function PaladinRetTwistBar:PLAYER_TARGET_CHANGED()
    -- Target affects swing state (auto-attack start/stop). Refresh quickly.
    self.forceInstantUpdate = true
    self:UpdateDisplay()
    self.forceInstantUpdate = false
end

function PaladinRetTwistBar:NAG_FRAME_UPDATED()
    if self.db.class.autoAnchor then
        self:UpdateFrameAnchor()
    end
    if frame then
        self:UpdateVisibility()
    end
end

function PaladinRetTwistBar:NAG_PALADIN_BAR_SCALE_UPDATED()
    self:UpdateFrameAnchor()
end

-- Declarative event registration
PaladinRetTwistBar.eventHandlers = {
    PLAYER_ENTERING_WORLD = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
}

-- ============================ OPTIONS ============================
function PaladinRetTwistBar:GetOptions()
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end

    -- Ensure color tables exist (e.g. for older saved profiles).
    local colorKeys = { "backgroundColor", "swingColor", "gcdColor", "sparkColor", "twistWindowColor", "divMarkerColor" }
    for _, key in ipairs(colorKeys) do
        if not self.db.class[key] and defaults.class[key] then
            local d = defaults.class[key]
            self.db.class[key] = { r = d.r, g = d.g, b = d.b, a = d.a or 1 }
        end
    end

    local function colorGetter(color)
        return function()
            if not color then return 0.3, 0.75, 0.3, 0 end
            return color.r, color.g, color.b, color.a
        end
    end

    local function colorSetter(color)
        return function(_, r, g, b, a)
            if not color then return end
            color.r, color.g, color.b, color.a = r, g, b, a
            self:ApplyBarColors()
        end
    end

    return {
        type = "group",
        name = "Ret Twist Bar",
        order = 26,
        childGroups = "tab",
        width = "full",
        args = {
            general = {
                type = "group",
                name = "General",
                order = 1,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        "Enabled",
                        "Enable or disable the Ret Twist Bar module.",
                        function() return self:GetSetting("class", "enabled") end,
                        function(_, value)
                            self:SetSetting("class", "enabled", value)
                            if value then self:Enable() else self:Disable() end
                        end,
                        { order = 1 }
                    ),
                    showBar = OptionsFactory:CreateToggle(
                        "Show Bar",
                        "Show or hide the frame.",
                        function() return self:GetSetting("class", "showBar") end,
                        function(_, value)
                            self:SetSetting("class", "showBar", value)
                            self:UpdateVisibility()
                        end,
                        { order = 2 }
                    ),
                    hideOutOfCombat = OptionsFactory:CreateToggle(
                        "Hide Out of Combat",
                        "Hide the bar while out of combat.",
                        function() return self:GetSetting("class", "hideOutOfCombat") end,
                        function(_, value)
                            self:SetSetting("class", "hideOutOfCombat", value)
                            self:UpdateVisibility()
                        end,
                        { order = 3 }
                    ),
                    showKeybindOnBar = OptionsFactory:CreateToggle(
                        "Show Keybind Above Bar Icons",
                        "Display the keybind above the icons on the bar.",
                        function() return self:GetSetting("class", "showKeybindOnBar") end,
                        function(_, value)
                            self:SetSetting("class", "showKeybindOnBar", value)
                            self:UpdateDisplay()
                        end,
                        { order = 4 }
                    ),
                    anchorHeader = OptionsFactory:CreateHeader("Anchor", { order = 10 }),
                    autoAnchor = OptionsFactory:CreateToggle(
                        "Auto Anchor to NAG",
                        "Anchor relative to NAG's primary display frame when available.",
                        function() return self:GetSetting("class", "autoAnchor") end,
                        function(_, value)
                            self:SetSetting("class", "autoAnchor", value)
                            self:UpdateVisibility()
                        end,
                        { order = 11 }
                    ),
                    anchorSide = OptionsFactory:CreateSelect(
                        "Anchor Side",
                        "When auto-anchored: place below NAG or to the right.",
                        function() return self:GetSetting("class", "anchorSide") or "bottom" end,
                        function(_, value)
                            self:SetSetting("class", "anchorSide", value)
                            self:UpdateVisibility()
                        end,
                        { order = 12, values = { bottom = "Below NAG frame", right = "Right of NAG frame" } }
                    ),
                    sizeHeader = OptionsFactory:CreateHeader("Frame Size and Position", { order = 20 }),
                    width = OptionsFactory:CreateRange(
                        "Width",
                        "Bar width.",
                        function() return self:GetSetting("class", "width") end,
                        function(_, value)
                            self:SetSetting("class", "width", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = 80, max = 600, step = 1, order = 21 }
                    ),
                    height = OptionsFactory:CreateRange(
                        "Height",
                        "Bar height.",
                        function() return self:GetSetting("class", "height") end,
                        function(_, value)
                            self:SetSetting("class", "height", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = 1, max = 60, step = 1, order = 22 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        "Alpha",
                        "Frame alpha.",
                        function() return self:GetSetting("class", "alpha") end,
                        function(_, value)
                            self:SetSetting("class", "alpha", value)
                            if frame then frame:SetAlpha(value) end
                        end,
                        { min = 0.1, max = 1.0, step = 0.05, order = 23 }
                    ),
                    x = OptionsFactory:CreateRange(
                        "X Offset",
                        "Horizontal offset.",
                        function() return self:GetSetting("class", "x") end,
                        function(_, value)
                            self:SetSetting("class", "x", value)
                            self:UpdateVisibility()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 24 }
                    ),
                    y = OptionsFactory:CreateRange(
                        "Y Offset",
                        "Vertical offset.",
                        function() return self:GetSetting("class", "y") end,
                        function(_, value)
                            self:SetSetting("class", "y", value)
                            self:UpdateVisibility()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 25 }
                    ),
                    barFillDirection = OptionsFactory:CreateSelect(
                        "Bar Fill Direction",
                        "Direction the swing bar fills: right-to-left countdown (default) or left-to-right like a classic swing timer.",
                        function() return self:GetSetting("class", "barFillDirection") or "rightToLeft" end,
                        function(_, value)
                            self:SetSetting("class", "barFillDirection", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 26, values = { rightToLeft = "Right to left (countdown)", leftToRight = "Left to right (fill)" } }
                    ),
                }
            },
            predictionIcons = {
                type = "group",
                name = "Prediction Icons",
                order = 2,
                args = {
                    iconVisibilityHeader = OptionsFactory:CreateHeader("Visibility", { order = 1 }),
                    showSwingIconSpark = OptionsFactory:CreateToggle(
                        "Show Weapon Spark",
                        "Show your mainhand weapon icon on the swing marker.",
                        function() return self:GetSetting("class", "showSwingIconSpark") end,
                        function(_, value)
                            self:SetSetting("class", "showSwingIconSpark", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 2 }
                    ),
                    showSocIcon = OptionsFactory:CreateToggle(
                        "Show SoC Icon",
                        "Show Seal of Command action icon lane.",
                        function() return self:GetSetting("class", "showSocIcon", true) end,
                        function(_, value)
                            self:SetSetting("class", "showSocIcon", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 3, disabled = function() return not self:GetSetting("class", "showSwingIconSpark", true) end }
                    ),
                    showJudgeIcon = OptionsFactory:CreateToggle(
                        "Show Judgement Icon",
                        "Show Judgement action icon lane when recommended.",
                        function() return self:GetSetting("class", "showJudgeIcon", true) end,
                        function(_, value)
                            self:SetSetting("class", "showJudgeIcon", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 4, disabled = function() return not self:GetSetting("class", "showSwingIconSpark", true) end }
                    ),
                    showCSIcon = OptionsFactory:CreateToggle(
                        "Show Crusader Strike Icon",
                        "Show Crusader Strike action icon lane when recommended.",
                        function() return self:GetSetting("class", "showCSIcon", true) end,
                        function(_, value)
                            self:SetSetting("class", "showCSIcon", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 5, disabled = function() return not self:GetSetting("class", "showSwingIconSpark", true) end }
                    ),
                    showFillerIconSpark = OptionsFactory:CreateToggle(
                        "Show Filler Icon",
                        "Show Consecration/Exorcism filler icon lane.",
                        function() return self:GetSetting("class", "showFillerIconSpark", true) end,
                        function(_, value)
                            self:SetSetting("class", "showFillerIconSpark", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 6, disabled = function() return not self:GetSetting("class", "showSwingIconSpark", true) end }
                    ),
                    iconGeometryHeader = OptionsFactory:CreateHeader("Shared Icon Geometry", { order = 10 }),
                    predictionIconSize = OptionsFactory:CreateRange(
                        "Prediction Icon Size",
                        "Shared size for SoC/Judgement/CS/Filler icon masks.",
                        function() return self:GetSetting("class", "predictionIconSize", 16) end,
                        function(_, value)
                            self:SetSetting("class", "predictionIconSize", value)
                            self:ApplyPredictionIconSizing()
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = 8, max = 48, step = 1, order = 11 }
                    ),
                    predictionTopLaneOffsetY = OptionsFactory:CreateRange(
                        "Top Lane Offset Y",
                        "Vertical offset for top prediction lane icons.",
                        function() return self:GetSetting("class", "predictionTopLaneOffsetY", 12) end,
                        function(_, value)
                            self:SetSetting("class", "predictionTopLaneOffsetY", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -60, max = 80, step = 1, order = 12 }
                    ),
                    predictionBottomLaneOffsetY = OptionsFactory:CreateRange(
                        "Bottom Lane Offset Y",
                        "Vertical offset for bottom prediction lane icons.",
                        function() return self:GetSetting("class", "predictionBottomLaneOffsetY", -12) end,
                        function(_, value)
                            self:SetSetting("class", "predictionBottomLaneOffsetY", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -80, max = 60, step = 1, order = 13 }
                    ),
                    predictionCSSplitExtraOffsetY = OptionsFactory:CreateRange(
                        "CS Split Extra Offset Y",
                        "Additional vertical shift for CS while using bottom split lane.",
                        function() return self:GetSetting("class", "predictionCSSplitExtraOffsetY", -14) end,
                        function(_, value)
                            self:SetSetting("class", "predictionCSSplitExtraOffsetY", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -80, max = 40, step = 1, order = 14 }
                    ),
                    csLaneMode = OptionsFactory:CreateSelect(
                        "Crusader Strike Lane",
                        "Choose whether CS uses top, bottom, or automatic lane behavior.",
                        function() return self:GetSetting("class", "csLaneMode", "auto") end,
                        function(_, value)
                            self:SetSetting("class", "csLaneMode", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 15, values = { auto = "Auto", top = "Top lane", bottom = "Bottom lane" } }
                    ),
                    layoutHeader = OptionsFactory:CreateHeader("SoC and Judgement Layout", { order = 30 }),
                    judgeSocLayoutMode = OptionsFactory:CreateSelect(
                        "SoC/Judgement Layout",
                        "Choose how SoC and Judgement icons are arranged.",
                        function() return self:GetSetting("class", "judgeSocLayoutMode") or "sideBySide" end,
                        function(_, value)
                            self:SetSetting("class", "judgeSocLayoutMode", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 31, values = { split = "Split (SoC top, Judge bottom)", sideBySide = "Side by side (both top)" } }
                    ),
                    judgeBackgroundInverted = OptionsFactory:CreateToggle(
                        "Invert Judgement Background",
                        "Flip Judgement icon background vertically.",
                        function() return self:GetSetting("class", "judgeBackgroundInverted", false) end,
                        function(_, value)
                            self:SetSetting("class", "judgeBackgroundInverted", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 32 }
                    ),
                    sideBySideHeader = OptionsFactory:CreateHeader("Side-by-Side Tuning", { order = 33 }),
                    socSideBySideOffsetX = OptionsFactory:CreateRange(
                        "SoC X Offset",
                        "Horizontal offset for SoC icon when side-by-side is active.",
                        function() return self:GetSetting("class", "socSideBySideOffsetX", 4) end,
                        function(_, value)
                            self:SetSetting("class", "socSideBySideOffsetX", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -60, max = 60, step = 1, order = 34, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    judgeSideBySideOffsetX = OptionsFactory:CreateRange(
                        "Judgement X Offset",
                        "Horizontal offset for Judgement icon when side-by-side is active.",
                        function() return self:GetSetting("class", "judgeSideBySideOffsetX", -4) end,
                        function(_, value)
                            self:SetSetting("class", "judgeSideBySideOffsetX", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -60, max = 60, step = 1, order = 35, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    judgeSocSideBySideOffsetY = OptionsFactory:CreateRange(
                        "Shared Y Offset",
                        "Vertical offset applied to SoC/Judgement top group when side-by-side is active.",
                        function() return self:GetSetting("class", "judgeSocSideBySideOffsetY", 0) end,
                        function(_, value)
                            self:SetSetting("class", "judgeSocSideBySideOffsetY", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -60, max = 60, step = 1, order = 36, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    backgroundHeader = OptionsFactory:CreateHeader("Background Transform", { order = 40 }),
                    socBackgroundRotationSideBySideDeg = OptionsFactory:CreateRange(
                        "SoC Background Rotation",
                        "Background rotation in degrees for SoC while side-by-side is active.",
                        function() return self:GetSetting("class", "socBackgroundRotationSideBySideDeg", -15) end,
                        function(_, value)
                            self:SetSetting("class", "socBackgroundRotationSideBySideDeg", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -180, max = 180, step = 1, order = 41, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    judgeBackgroundRotationSideBySideDeg = OptionsFactory:CreateRange(
                        "Judgement Background Rotation",
                        "Background rotation in degrees for Judgement while side-by-side is active.",
                        function() return self:GetSetting("class", "judgeBackgroundRotationSideBySideDeg", 15) end,
                        function(_, value)
                            self:SetSetting("class", "judgeBackgroundRotationSideBySideDeg", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -180, max = 180, step = 1, order = 42, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    socBackgroundOffsetX = OptionsFactory:CreateRange(
                        "SoC Background X",
                        "Horizontal offset for SoC background art.",
                        function() return self:GetSetting("class", "socBackgroundOffsetX", 0) end,
                        function(_, value)
                            self:SetSetting("class", "socBackgroundOffsetX", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -30, max = 30, step = 1, order = 43, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    socBackgroundOffsetY = OptionsFactory:CreateRange(
                        "SoC Background Y",
                        "Vertical offset for SoC background art.",
                        function() return self:GetSetting("class", "socBackgroundOffsetY", 0) end,
                        function(_, value)
                            self:SetSetting("class", "socBackgroundOffsetY", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -30, max = 30, step = 1, order = 44, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    judgeBackgroundOffsetX = OptionsFactory:CreateRange(
                        "Judgement Background X",
                        "Horizontal offset for Judgement background art.",
                        function() return self:GetSetting("class", "judgeBackgroundOffsetX", 0) end,
                        function(_, value)
                            self:SetSetting("class", "judgeBackgroundOffsetX", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -30, max = 30, step = 1, order = 45, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                    judgeBackgroundOffsetY = OptionsFactory:CreateRange(
                        "Judgement Background Y",
                        "Vertical offset for Judgement background art.",
                        function() return self:GetSetting("class", "judgeBackgroundOffsetY", 0) end,
                        function(_, value)
                            self:SetSetting("class", "judgeBackgroundOffsetY", value)
                            self:ApplyJudgeSocBackgroundTransforms()
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -30, max = 30, step = 1, order = 46, hidden = function() return self:GetJudgeSocLayoutMode() ~= "sideBySide" end }
                    ),
                }
            },
            gcdBar = {
                type = "group",
                name = "GCD Bar",
                order = 3,
                args = {
                    showGCDBar = OptionsFactory:CreateToggle(
                        "Show GCD Bar",
                        "Show or hide the GCD lane under the swing timeline.",
                        function() return self:GetSetting("class", "showGCDBar", true) end,
                        function(_, value)
                            self:SetSetting("class", "showGCDBar", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 1 }
                    ),
                    showGCDSparks = OptionsFactory:CreateToggle(
                        "Show GCD Lane Sparks",
                        "Show start and end spark markers on the GCD lane.",
                        function() return self:GetSetting("class", "showGCDSparks", true) end,
                        function(_, value)
                            self:SetSetting("class", "showGCDSparks", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 2, disabled = function() return not self:GetSetting("class", "showGCDBar", true) end }
                    ),
                    gcdLaneHeight = OptionsFactory:CreateRange(
                        "GCD Lane Height",
                        "Height of the GCD lane bar.",
                        function() return self:GetSetting("class", "gcdLaneHeight", 2) end,
                        function(_, value)
                            self:SetSetting("class", "gcdLaneHeight", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = 1, max = 10, step = 1, order = 3, disabled = function() return not self:GetSetting("class", "showGCDBar", true) end }
                    ),
                    gcdLaneGap = OptionsFactory:CreateRange(
                        "GCD Lane Gap",
                        "Vertical gap between swing lane and GCD lane.",
                        function() return self:GetSetting("class", "gcdLaneGap", 6) end,
                        function(_, value)
                            self:SetSetting("class", "gcdLaneGap", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = 0, max = 20, step = 1, order = 4, disabled = function() return not self:GetSetting("class", "showGCDBar", true) end }
                    ),
                    gcdSparkHeight = OptionsFactory:CreateRange(
                        "GCD Spark Height",
                        "Height of the GCD lane spark markers.",
                        function() return self:GetSetting("class", "gcdSparkHeight", 5) end,
                        function(_, value)
                            self:SetSetting("class", "gcdSparkHeight", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = 2, max = 16, step = 1, order = 5, disabled = function() return not self:GetSetting("class", "showGCDBar", true) end }
                    ),
                }
            },
            twistBar = {
                type = "group",
                name = "Twist Bar",
                order = 4,
                args = {
                    showTwistWindow = OptionsFactory:CreateToggle(
                        "Show Twist Window",
                        "Show the moving twist window overlay near swing.",
                        function() return self:GetSetting("class", "showTwistWindow", true) end,
                        function(_, value)
                            self:SetSetting("class", "showTwistWindow", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 1 }
                    ),
                    twistWindowSeconds = OptionsFactory:CreateRange(
                        "Twist Window Seconds",
                        "Duration of the twist window before swing.",
                        function() return self:GetSetting("class", "twistWindowSeconds", 0.4) end,
                        function(_, value)
                            self:SetSetting("class", "twistWindowSeconds", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 2, disabled = function() return not self:GetSetting("class", "showTwistWindow", true) end }
                    ),
                    showDivBoundaryMarker = OptionsFactory:CreateToggle(
                        "Show Div Boundary Marker",
                        "Show marker for the latest safe cast point before twist window opens.",
                        function() return self:GetSetting("class", "showDivBoundaryMarker", true) end,
                        function(_, value)
                            self:SetSetting("class", "showDivBoundaryMarker", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { order = 3, disabled = function() return not self:GetSetting("class", "showTwistWindow", true) end }
                    ),
                }
            },
            colors = {
                type = "group",
                name = "Colors",
                order = 5,
                args = {
                    barsHeader = OptionsFactory:CreateHeader("Bars", { order = 1 }),
                    backgroundColor = OptionsFactory:CreateColor(
                        "Background",
                        "Color of the swing lane background.",
                        colorGetter(self.db.class.backgroundColor),
                        colorSetter(self.db.class.backgroundColor),
                        { hasAlpha = true, order = 2 }
                    ),
                    swingColor = OptionsFactory:CreateColor(
                        "Swing Bar",
                        "Color of the swing timeline bar (typically transparent).",
                        colorGetter(self.db.class.swingColor),
                        colorSetter(self.db.class.swingColor),
                        { hasAlpha = true, order = 3 }
                    ),
                    gcdColor = OptionsFactory:CreateColor(
                        "GCD Bar",
                        "Color of the GCD lane bar.",
                        colorGetter(self.db.class.gcdColor),
                        colorSetter(self.db.class.gcdColor),
                        { hasAlpha = true, order = 4 }
                    ),
                    overlaysHeader = OptionsFactory:CreateHeader("Overlays", { order = 10 }),
                    twistWindowColor = OptionsFactory:CreateColor(
                        "Twist Window",
                        "Base color of the twist window overlay.",
                        colorGetter(self.db.class.twistWindowColor),
                        colorSetter(self.db.class.twistWindowColor),
                        { hasAlpha = true, order = 11 }
                    ),
                    markersHeader = OptionsFactory:CreateHeader("Markers", { order = 20 }),
                    sparkColor = OptionsFactory:CreateColor(
                        "Spark and Marker Color",
                        "Color used by swing spark and related markers.",
                        colorGetter(self.db.class.sparkColor),
                        colorSetter(self.db.class.sparkColor),
                        { hasAlpha = true, order = 21 }
                    ),
                    divMarkerColor = OptionsFactory:CreateColor(
                        "Div Boundary Marker",
                        "Color of the div boundary marker.",
                        colorGetter(self.db.class.divMarkerColor),
                        colorSetter(self.db.class.divMarkerColor),
                        { hasAlpha = true, order = 22 }
                    ),
                }
            },
            advanced = {
                type = "group",
                name = "Advanced",
                order = 6,
                args = {
                    fillerHeader = OptionsFactory:CreateHeader("Filler", { order = 1 }),
                    fillerLaneMode = OptionsFactory:CreateSelect(
                        "Filler Lane",
                        "Choose whether filler icons are placed on top or bottom lane.",
                        function() return self:GetSetting("class", "fillerLaneMode", "bottom") end,
                        function(_, value)
                            self:SetSetting("class", "fillerLaneMode", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        {
                            order = 2,
                            values = { bottom = "Bottom lane (reverted)", top = "Top lane" },
                            disabled = function() return not self:GetSetting("class", "showFillerIconSpark", true) end
                        }
                    ),
                    fillerSourcePosition = OptionsFactory:CreateSelect(
                        "Filler Source",
                        "Secondary suggestion slot used to source filler actions (Left 1 or Right 1).",
                        function() return self:GetSetting("class", "fillerSourcePosition", "left1") end,
                        function(_, value)
                            self:SetSetting("class", "fillerSourcePosition", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        {
                            order = 3,
                            values = { left1 = "Left 1", right1 = "Right 1" },
                            disabled = function() return not self:GetSetting("class", "showFillerIconSpark", true) end
                        }
                    ),
                    fillerOffsetX = OptionsFactory:CreateRange(
                        "Filler Offset X",
                        "Horizontal filler icon lane adjustment.",
                        function() return self:GetSetting("class", "fillerOffsetX", 0) end,
                        function(_, value)
                            self:SetSetting("class", "fillerOffsetX", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -60, max = 60, step = 1, order = 4, disabled = function() return not self:GetSetting("class", "showFillerIconSpark", true) end }
                    ),
                    fillerOffsetY = OptionsFactory:CreateRange(
                        "Filler Offset Y",
                        "Vertical filler icon lane adjustment.",
                        function() return self:GetSetting("class", "fillerOffsetY", 0) end,
                        function(_, value)
                            self:SetSetting("class", "fillerOffsetY", value)
                            if frame then self:UpdateDisplay() end
                        end,
                        { min = -60, max = 60, step = 1, order = 5, disabled = function() return not self:GetSetting("class", "showFillerIconSpark", true) end }
                    ),
                    debugThrottleSeconds = OptionsFactory:CreateRange(
                        "Debug Throttle (seconds)",
                        "Throttle interval for development debug logging.",
                        function() return self:GetSetting("class", "debugThrottleSeconds", 0.25) end,
                        function(_, value)
                            self:SetSetting("class", "debugThrottleSeconds", value)
                        end,
                        { min = 0, max = 2.0, step = 0.01, order = 10 }
                    ),
                    resetHeader = OptionsFactory:CreateHeader("Reset", { order = 20 }),
                    resetBarToDefaults = OptionsFactory:CreateExecute(
                        "Reset Bar to Defaults",
                        "Restore all Ret Twist Bar settings to defaults.",
                        function()
                            if StaticPopup_Show then
                                StaticPopup_Show("NAG_RET_TWIST_BAR_RESET_CONFIRM", nil, nil, { module = self })
                            end
                        end,
                        { order = 21 }
                    ),
                }
            },
        }
    }
end


