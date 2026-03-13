--- @module "NAG.HunterAPITimelineBar"
--- Independent Hunter prediction timeline bar driven only by TBCHunterAPI outputs.
---
--- Displays a fixed 3-state forecast with:
--- - NOW pinned to the left edge at current-state start
--- - Current state + next 2 states as contiguous segments
--- - Action/consequence markers (press, queue, cast, gcd-ready)
---
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ============================ LOCALIZE ============================
local _, ns = ...

local GetTime = _G.GetTime
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateFrame = _G.CreateFrame
local GetSpellTexture = _G.GetSpellTexture

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local OptionsFactory

-- ============================ CONSTANTS ============================
local DEFAULT_HORIZON_SECONDS = 6.0
local UPDATE_INTERVAL = 0.016
local SNAPSHOT_UPDATE_INTERVAL_SECONDS = 0.05
local BAR_DEBUG_PRINT_INTERVAL_SECONDS = 0.2
local BAR_DEBUG_PRINT_VERSION = "2026.02.22-3"
local MAX_SNAPSHOT_STATES = 3
local MAX_SS_WINDOWS = MAX_SNAPSHOT_STATES
local MAX_SS_MARKERS = 12
local MAX_STATE_TICKS = 6
local MAX_EVENT_TICKS = 48
local MAX_WINDUP_BOUNDARY_TICKS = 8
local TIMELINE_STRIP_HEIGHT = 18
-- Reserve space below the strip for lanes (state boundary labels). Strip sits above this.
local LANE_BELOW_STRIP_HEIGHT = 22
-- State labels: negative = below strip bottom (e.g. -10 = 10px under strip).
local DEFAULT_STATE_LANE_OFFSET_Y = -10
-- Lanes above strip: offset from strip top (more spacing to avoid overlap).
local DEFAULT_HEADER_LANE_OFFSET_Y = 20
local DEFAULT_EVENT_LANE_OFFSET_Y = 38
local DEFAULT_EVENT_LANE_2_OFFSET_Y = 56

local STEADY_SHOT_ID = 34120
local MULTI_SHOT_ID = 27021
local ARCANE_SHOT_ID = 27019
-- Used to derive slot-1 GCD end when state has two actions (state only stores final gcdEndAt).
local GCD_SECONDS = 1.5
local WINDUP_ICON_POSITION_RATIO = 0.70

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        hideOutOfCombat = false,

        autoAnchor = true,
        lockToNagAnchor = true,
        point = "CENTER",
        x = 210,
        y = 31,

        width = 360, -- Double legacy 180 width, to show 6s horizon cleanly.
        height = 52,
        alpha = 1.0,
        horizonSeconds = DEFAULT_HORIZON_SECONDS,
        snapshotIntervalSeconds = SNAPSHOT_UPDATE_INTERVAL_SECONDS,

        showBackground = true,
        showTimelineLine = true,
        showNowMarker = true,
        showSSWindows = true,
        showSSIcons = true,
        showMSMarker = true,
        showARMarker = true,
        showDebugText = false,
        showKeybindOnBar = false,
        showTieLines = false,
        showSegmentDividers = true,
        showWindupMarkers = true,
        showDetailedEvents = false,
        equalSegmentWidths = false,

        iconSize = 16,
        markerLaneOffsetY = 0,
        msOverlapOffsetY = 6,
        arOverlapOffsetY = -6,
        stateLaneOffsetY = DEFAULT_STATE_LANE_OFFSET_Y,
        headerLaneOffsetY = DEFAULT_HEADER_LANE_OFFSET_Y,
        eventLaneOffsetY = DEFAULT_EVENT_LANE_OFFSET_Y,
        eventLane2OffsetY = DEFAULT_EVENT_LANE_2_OFFSET_Y,

        backgroundColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.35 },
        timelineColor = { r = 0.85, g = 0.85, b = 0.85, a = 0.35 },
        nowMarkerColor = { r = 1.0, g = 1.0, b = 1.0, a = 0.85 },
        ssWindowColor = { r = 0.20, g = 0.75, b = 0.35, a = 0.35 },
        ssMarkerColor = { r = 0.90, g = 0.90, b = 0.90, a = 0.95 },
    }
}

--- @class HunterAPITimelineBar:CoreModule
local HunterAPITimelineBar = NAG:CreateModule("HunterAPITimelineBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    messageHandlers = {
        NAG_FRAME_UPDATED = true,
        NAG_HUNTER_BAR_SCALE_UPDATED = true,
    },
    hidden = function()
        return UnitClassBase("player") ~= "HUNTER"
    end,
})

ns.HunterAPITimelineBar = HunterAPITimelineBar
local module = HunterAPITimelineBar

-- ============================ LOCALS ============================
local frame
local background
local timelineLine
local nowMarker
local debugText
local lastUpdate = 0
local lastBarDebugPrintAt = 0
local lastStateShiftKey = nil
local lastSnapshotAt = 0
local cachedModel = nil

-- ============================ DEBUG LEGEND ============================
-- TIMELINE_DEBUG fields:
-- modelNow/modelTotal = first-state start and full modeled duration.
-- s1/s2/s3 = state identity and chosen actions in the 3-state snapshot.
-- reason = timeline validity reason from API model (ok/invalid_inputs/etc).
--
-- State/action debug lines:
-- GCDs = timestamp when action triggers GCD.
-- GCDe = timestamp when GCD ends.
-- Cs = timestamp when cast starts (0 for instant fillers).
-- Ce = timestamp when cast ends.
--
-- Bar elements:
-- - Segment 1 = current state, segment 2/3 = next two upcoming states.
-- - Segments are static per cached snapshot interval (default 0.05s).
-- - NOW spark moves only inside segment 1 (state 1).
-- - Wind-up zones are highlighted per segment from (stateEnd - windupSeconds) to stateEnd.
-- - Action icons are API-driven only (chosenAction/chosenAction2): SS, MS, AR.
-- - Dense event ticks (GCDs/GCDe/Cs/Ce) are optional via showDetailedEvents.

-- ============================ HELPERS ============================
local function Clamp(v, minV, maxV)
    if v < minV then
        return minV
    end
    if v > maxV then
        return maxV
    end
    return v
end

local function GetSpellIcon(spellId)
    if NAG and NAG.Spell and NAG.Spell[spellId] and NAG.Spell[spellId].icon then
        return NAG.Spell[spellId].icon
    end
    return GetSpellTexture(spellId) or "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function IsDevModeEnabled()
    return NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() or false
end

local function GetEventDisplayLabel(kind, fallbackLabel)
    if kind == "press" then
        return "GCDs"
    end
    if kind == "gcd_ready" then
        return "GCDe"
    end
    if kind == "cast_start" then
        return "Cs"
    end
    if kind == "cast_end" then
        return "Ce"
    end
    if kind == "actionable" then
        return "A"
    end
    if kind == "queued" then
        return "Q"
    end
    return tostring(fallbackLabel or kind or "")
end

--- Maps an absolute timestamp to bar X using fixed NOW-at-left model.
--- @param model table
--- @param timestamp number
--- @param width number
--- @return number
local function TimeToModelX(model, timestamp, width)
    local nowAt = tonumber(model and model.nowAt or 0) or 0
    local totalDuration = tonumber(model and model.totalDuration or 0) or 0
    if width <= 0 or totalDuration <= 0 then
        return 0
    end
    local ratio = (timestamp - nowAt) / totalDuration
    return Clamp(ratio, 0, 1) * width
end

--- Build 3-state segment layout used by the simplified timeline renderer.
--- @param model table
--- @param width number
--- @param equalSegmentWidths boolean
--- @return table
local function BuildSegmentLayout(model, width, equalSegmentWidths)
    local segments = {}
    if not model or type(model.states) ~= "table" or #model.states == 0 or width <= 0 then
        return segments
    end

    local stateCount = math.min(MAX_SNAPSHOT_STATES, #model.states)
    local totalDuration = tonumber(model.totalDuration or 0) or 0
    local cursorX = 0

    for i = 1, stateCount do
        local state = model.states[i]
        local stateStartAt = tonumber(state and state.startAt or 0) or 0
        local stateEndAt = tonumber(state and state.endAt or 0) or 0
        local stateDuration = stateEndAt - stateStartAt
        if stateDuration <= 0 then
            stateDuration = 0.001
        end

        local segmentWidth = width / stateCount
        if not equalSegmentWidths and totalDuration > 0 then
            segmentWidth = (stateDuration / totalDuration) * width
        end

        local segmentStartX = cursorX
        local segmentEndX = cursorX + segmentWidth
        if i == stateCount then
            segmentEndX = width
        end

        segments[#segments + 1] = {
            stateIndex = i,
            stateId = tonumber(state and state.stateId or 0) or 0,
            startAt = stateStartAt,
            endAt = stateEndAt,
            duration = stateDuration,
            startX = segmentStartX,
            endX = segmentEndX,
            width = segmentEndX - segmentStartX,
            state = state,
        }

        cursorX = segmentEndX
    end

    return segments
end

--- Maps a timestamp to X coordinate within one timeline segment.
--- @param segment table|nil
--- @param timestamp number
--- @return number
local function TimeToSegmentX(segment, timestamp)
    if not segment then
        return 0
    end
    local duration = tonumber(segment.duration or 0) or 0
    if duration <= 0 then
        return tonumber(segment.startX or 0) or 0
    end
    local startAt = tonumber(segment.startAt or 0) or 0
    local ratio = (tonumber(timestamp or startAt) - startAt) / duration
    return (tonumber(segment.startX or 0) or 0) + (Clamp(ratio, 0, 1) * (tonumber(segment.width or 0) or 0))
end

--- Select a timestamp for action icon placement from API state data.
--- @param source table
--- @param actionName string
--- @param actionIndex number
--- @param windupStartAt number
--- @param windupSeconds number
--- @return number
local function ResolveActionIconAt(source, actionName, actionIndex, windupStartAt, windupSeconds)
    local fallbackSSAt = windupStartAt + (windupSeconds * WINDUP_ICON_POSITION_RATIO)
    if actionName == "SS" then
        if actionIndex == 2 then
            local pressAt2 = tonumber(source.ssPressAt2 or 0) or 0
            if pressAt2 > 0 then
                return pressAt2
            end
        else
            local pressAt = tonumber(source.ssPressAt or 0) or 0
            if pressAt > 0 then
                return pressAt
            end
        end
        return fallbackSSAt
    end

    if actionName == "MS" or actionName == "AR" then
        if actionIndex == 2 then
            local fillerAt2 = tonumber(source.fillerCastAt2 or 0) or 0
            if fillerAt2 > 0 then
                return fillerAt2
            end
        else
            local fillerAt = tonumber(source.fillerCastAt or 0) or 0
            if fillerAt > 0 then
                return fillerAt
            end
        end
    end

    return 0
end

local function HidePredictionOverlays()
    if not frame then
        return
    end

    if frame.ssWindows then
        for i = 1, #frame.ssWindows do
            frame.ssWindows[i]:Hide()
        end
    end
    if frame.ssMarkers then
        for i = 1, #frame.ssMarkers do
            -- SetSparkKeybind(frame.ssMarkers[i], false) -- local defined below; would need forward-decl to use here
            frame.ssMarkers[i]:Hide()
        end
    end
    if frame.msMarker then
        -- SetSparkKeybind(frame.msMarker, false)
        frame.msMarker:Hide()
    end
    if frame.arMarker then
        -- SetSparkKeybind(frame.arMarker, false)
        frame.arMarker:Hide()
    end
    if frame.stateTicks then
        for i = 1, #frame.stateTicks do
            frame.stateTicks[i]:Hide()
        end
    end
    if frame.windupBoundaryTicks then
        for i = 1, #frame.windupBoundaryTicks do
            frame.windupBoundaryTicks[i]:Hide()
        end
    end
    if frame.stateLabels then
        for i = 1, #frame.stateLabels do
            frame.stateLabels[i]:Hide()
        end
    end
    if frame.stateTieLines then
        for i = 1, #frame.stateTieLines do
            frame.stateTieLines[i]:Hide()
        end
    end
    if frame.eventTicks then
        for i = 1, #frame.eventTicks do
            frame.eventTicks[i]:Hide()
        end
    end
    if frame.eventLabels then
        for i = 1, #frame.eventLabels do
            frame.eventLabels[i]:Hide()
        end
    end
    if frame.eventTieLines then
        for i = 1, #frame.eventTieLines do
            frame.eventTieLines[i]:Hide()
        end
    end
    if frame.snapshotHeaders then
        for i = 1, #frame.snapshotHeaders do
            frame.snapshotHeaders[i]:Hide()
        end
    end
    if frame.snapshotTieLines then
        for i = 1, #frame.snapshotTieLines do
            frame.snapshotTieLines[i]:Hide()
        end
    end
end

local function SetSparkKeybind(iconFrame, showKeybind)
    if not iconFrame or not iconFrame.keybindText then return end
    if showKeybind and iconFrame.spellId then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind then
            kb = KeybindManager:GetSpellKeybind(iconFrame.spellId) or ""
        end
        iconFrame.keybindText:SetText(kb)
        if kb ~= "" then
            iconFrame.keybindText:Show()
        else
            iconFrame.keybindText:Hide()
        end
    else
        iconFrame.keybindText:SetText("")
        iconFrame.keybindText:Hide()
    end
end

local function CreateMaskedIcon(parent, size)
    local iconFrame = CreateFrame("Frame", nil, parent)
    iconFrame:SetSize(size, size)
    iconFrame.icon = iconFrame:CreateTexture(nil, "OVERLAY", nil, 7)
    iconFrame.icon:SetAllPoints()
    iconFrame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    iconFrame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    local mask = iconFrame:CreateMaskTexture()
    mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetAllPoints()
    iconFrame.icon:AddMaskTexture(mask)
    iconFrame.stateLabel = iconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    iconFrame.stateLabel:SetPoint("BOTTOM", iconFrame, "TOP", 0, 1)
    iconFrame.stateLabel:SetTextColor(1.0, 0.95, 0.35, 1.0)
    iconFrame.stateLabel:SetText("")
    iconFrame.stateLabel:Hide()
    local keybindText = iconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    keybindText:SetPoint("BOTTOM", iconFrame, "TOP", 0, 2)
    keybindText:SetJustifyH("CENTER")
    keybindText:SetTextColor(1, 1, 0)
    keybindText:SetText("")
    keybindText:Hide()
    iconFrame.keybindText = keybindText
    iconFrame:Hide()
    return iconFrame
end

local function EnsureVisualPools()
    if not frame then
        return
    end

    frame.ssWindows = frame.ssWindows or {}
    frame.ssMarkers = frame.ssMarkers or {}
    frame.stateTicks = frame.stateTicks or {}
    frame.windupBoundaryTicks = frame.windupBoundaryTicks or {}
    frame.stateLabels = frame.stateLabels or {}
    frame.stateTieLines = frame.stateTieLines or {}
    frame.eventTicks = frame.eventTicks or {}
    frame.eventLabels = frame.eventLabels or {}
    frame.eventTieLines = frame.eventTieLines or {}
    frame.snapshotHeaders = frame.snapshotHeaders or {}
    frame.snapshotTieLines = frame.snapshotTieLines or {}

    for i = 1, MAX_SS_WINDOWS do
        if not frame.ssWindows[i] then
            local tex = frame:CreateTexture(nil, "ARTWORK", nil, -2)
            tex:Hide()
            frame.ssWindows[i] = tex
        end
    end

    for i = 1, MAX_SS_MARKERS do
        if not frame.ssMarkers[i] then
            frame.ssMarkers[i] = CreateMaskedIcon(frame, module.db.class.iconSize or 16)
        end
    end

    for i = 1, MAX_STATE_TICKS do
        if not frame.stateTicks[i] then
            local tick = frame:CreateTexture(nil, "OVERLAY", nil, 6)
            tick:SetColorTexture(1.0, 0.90, 0.25, 0.80)
            tick:SetSize(1, 14)
            tick:Hide()
            frame.stateTicks[i] = tick
        end
        if not frame.stateLabels[i] then
            local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            label:SetTextColor(1.0, 0.95, 0.35, 1.0)
            label:SetJustifyH("CENTER")
            label:SetText("")
            label:Hide()
            frame.stateLabels[i] = label
        end
        if not frame.stateTieLines[i] then
            local line = frame:CreateTexture(nil, "ARTWORK", nil, -3)
            line:SetColorTexture(1.0, 0.90, 0.25, 0.45)
            line:SetSize(1, 8)
            line:Hide()
            frame.stateTieLines[i] = line
        end
    end

    for i = 1, MAX_WINDUP_BOUNDARY_TICKS do
        if not frame.windupBoundaryTicks[i] then
            local tick = frame:CreateTexture(nil, "OVERLAY", nil, 6)
            tick:SetColorTexture(0.92, 1.00, 0.92, 0.85)
            tick:SetSize(1, 10)
            tick:Hide()
            frame.windupBoundaryTicks[i] = tick
        end
    end

    for i = 1, MAX_EVENT_TICKS do
        if not frame.eventTicks[i] then
            local tick = frame:CreateTexture(nil, "OVERLAY", nil, 5)
            tick:SetColorTexture(0.9, 0.9, 0.9, 0.9)
            tick:SetSize(1, 8)
            tick:Hide()
            frame.eventTicks[i] = tick
        end
        if not frame.eventLabels[i] then
            local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            label:SetTextColor(1.0, 1.0, 1.0, 0.85)
            label:SetJustifyH("CENTER")
            label:SetText("")
            label:Hide()
            frame.eventLabels[i] = label
        end
        if not frame.eventTieLines[i] then
            local line = frame:CreateTexture(nil, "ARTWORK", nil, -3)
            line:SetColorTexture(0.85, 0.85, 0.85, 0.40)
            line:SetSize(1, 8)
            line:Hide()
            frame.eventTieLines[i] = line
        end
    end

    for i = 1, MAX_SNAPSHOT_STATES do
        if not frame.snapshotHeaders[i] then
            local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            label:SetTextColor(1.0, 0.95, 0.35, 1.0)
            label:SetJustifyH("CENTER")
            label:SetText("")
            label:Hide()
            frame.snapshotHeaders[i] = label
        end
        if not frame.snapshotTieLines[i] then
            local line = frame:CreateTexture(nil, "ARTWORK", nil, -3)
            line:SetColorTexture(1.0, 0.95, 0.35, 0.40)
            line:SetSize(1, 8)
            line:Hide()
            frame.snapshotTieLines[i] = line
        end
    end

    if not frame.msMarker then
        frame.msMarker = CreateMaskedIcon(frame, module.db.class.iconSize or 16)
        frame.msMarker.spellId = MULTI_SHOT_ID
    end
    if not frame.arMarker then
        frame.arMarker = CreateMaskedIcon(frame, module.db.class.iconSize or 16)
        frame.arMarker.spellId = ARCANE_SHOT_ID
    end
end

local function BuildViewModel()
    local db = module.db.class
    local horizonSeconds = tonumber(db.horizonSeconds or DEFAULT_HORIZON_SECONDS) or DEFAULT_HORIZON_SECONDS
    if horizonSeconds <= 0 then
        horizonSeconds = DEFAULT_HORIZON_SECONDS
    end

    local nowAt = GetTime()
    local timeline = nil
    if NAG and NAG.TBCHunterPredictStateTimelineLive then
        timeline = NAG:TBCHunterPredictStateTimelineLive(horizonSeconds)
    elseif NAG and NAG.TBCHunterPredictStateTimeline then
        timeline = NAG:TBCHunterPredictStateTimeline(nil, horizonSeconds)
    end

    local model = {
        ok = false,
        nowAt = nowAt,
        horizonSeconds = horizonSeconds,
        totalDuration = 0,
        states = {},
        windows = {},
        events = {},
        stateBoundaries = {},
        activeStateId = 0,
        activeCycleIndex = 0,
        timelineReason = timeline and timeline.reason or "timeline_unavailable",
        windupSeconds = tonumber(timeline and timeline.windupSeconds or 0.5) or 0.5,
    }

    if not timeline or timeline.ok ~= true or type(timeline.states) ~= "table" or #timeline.states == 0 then
        return model
    end

    model.activeStateId = tonumber(timeline.activeStateId or 0) or 0
    model.activeCycleIndex = tonumber(timeline.activeCycleIndex or 0) or 0

    local stateCount = math.min(MAX_SNAPSHOT_STATES, #timeline.states)
    for i = 1, stateCount do
        local src = timeline.states[i] or {}
        local stateStartAt = tonumber(src.stateStartAt or 0) or 0
        local stateEndAt = tonumber(src.stateEndAtAdjusted or src.stateEndAt or 0) or 0
        if stateEndAt <= stateStartAt then
            local fallbackSpeed = tonumber(timeline.rangedSpeed or 0) or 0
            if fallbackSpeed <= 0 then
                fallbackSpeed = 0.001
            end
            stateEndAt = stateStartAt + fallbackSpeed
        end
        model.states[#model.states + 1] = {
            index = i,
            stateId = tonumber(src.stateId or 0) or 0,
            cycleIndex = tonumber(src.cycleIndex or i) or i,
            absoluteCycleIndex = tonumber(src.absoluteCycleIndex or 0) or 0,
            startAt = stateStartAt,
            endAt = stateEndAt,
            source = src,
            chosenAction = tostring(src.chosenAction or "none"),
            chosenAction2 = tostring(src.chosenAction2 or "none"),
            stateReason = tostring(src.stateReason or "none"),
            stateReason2 = tostring(src.stateReason2 or "none"),
        }
    end

    if #model.states == 0 then
        return model
    end

    model.nowAt = tonumber(model.states[1].startAt or nowAt) or nowAt
    local modelEndAt = tonumber(model.states[#model.states].endAt or model.nowAt) or model.nowAt
    model.totalDuration = modelEndAt - model.nowAt
    if model.totalDuration <= 0 then
        model.totalDuration = 0.001
    end

    local function PushEvent(stateIndex, kind, at, spellId, label, actionIndex)
        local timestamp = tonumber(at or 0) or 0
        if timestamp <= 0 then
            return
        end
        if timestamp < model.nowAt or timestamp > modelEndAt then
            return
        end
        model.events[#model.events + 1] = {
            stateIndex = stateIndex,
            kind = kind,
            at = timestamp,
            spellId = tonumber(spellId or 0) or 0,
            label = label,
            actionIndex = actionIndex or 1,
        }
    end

    for i = 1, #model.states do
        local state = model.states[i]
        local src = state.source
        local windupStartAt = state.endAt - model.windupSeconds
        if windupStartAt < state.startAt then
            windupStartAt = state.startAt
        end

        model.windows[#model.windows + 1] = {
            stateIndex = i,
            startAt = windupStartAt,
            endAt = state.endAt,
        }

        if i < #model.states then
            model.stateBoundaries[#model.stateBoundaries + 1] = {
                stateIndex = i,
                at = state.endAt,
                stateId = state.stateId,
                absoluteCycleIndex = state.absoluteCycleIndex,
            }
        end

        PushEvent(i, "actionable", src.actionableAt, 0, "A", 0)

        local action1 = tostring(src.chosenAction or "none")
        local action2Present = tostring(src.chosenAction2 or "none") ~= "none"
        if action1 == "SS" then
            PushEvent(i, "press", src.ssPressAt, STEADY_SHOT_ID, "P1", 1)
            if src.ssQueuedThisState == true then
                PushEvent(i, "queued", src.ssPressAt, STEADY_SHOT_ID, "Q", 1)
            end
            PushEvent(i, "cast_start", src.ssCastStartAt, STEADY_SHOT_ID, "CS1", 1)
            PushEvent(i, "cast_end", src.ssCastEndAt, STEADY_SHOT_ID, "CE1", 1)
            local gcd1End = action2Present and (tonumber(src.ssPressAt or 0) or 0) + GCD_SECONDS or tonumber(src.gcdEndAt or 0) or 0
            PushEvent(i, "gcd_ready", gcd1End, 0, "G1", 1)
        elseif action1 == "MS" or action1 == "AR" then
            local spellId = tonumber(src.fillerSpellId or 0) or 0
            if spellId <= 0 then
                spellId = action1 == "MS" and MULTI_SHOT_ID or ARCANE_SHOT_ID
            end
            PushEvent(i, "press", src.fillerCastAt, spellId, "P1", 1)
            PushEvent(i, "cast_end", src.fillerCastEndAt, spellId, "CE1", 1)
            PushEvent(i, "gcd_ready", src.fillerGcdEndAt > 0 and src.fillerGcdEndAt or src.gcdEndAt, 0, "G1", 1)
        end

        local action2 = tostring(src.chosenAction2 or "none")
        if action2 == "SS" then
            PushEvent(i, "press", src.ssPressAt2, STEADY_SHOT_ID, "P2", 2)
            PushEvent(i, "cast_start", src.ssCastStartAt2, STEADY_SHOT_ID, "CS2", 2)
            PushEvent(i, "cast_end", src.ssCastEndAt2, STEADY_SHOT_ID, "CE2", 2)
            PushEvent(i, "gcd_ready", src.gcdEndAt2, 0, "G2", 2)
        elseif action2 == "MS" or action2 == "AR" then
            local spellId = tonumber(src.fillerSpellId2 or 0) or 0
            if spellId <= 0 then
                spellId = action2 == "MS" and MULTI_SHOT_ID or ARCANE_SHOT_ID
            end
            PushEvent(i, "press", src.fillerCastAt2, spellId, "P2", 2)
            PushEvent(i, "cast_end", src.fillerCastEndAt2, spellId, "CE2", 2)
            PushEvent(i, "gcd_ready", src.fillerGcdEndAt2 > 0 and src.fillerGcdEndAt2 or src.gcdEndAt2, 0, "G2", 2)
        end
    end

    model.ok = true
    return model
end

local function PrintBarDebugThrottled(model)
    if not IsDevModeEnabled() then
        return
    end
    if not model then
        return
    end
    -- Do not spam when timeline is unavailable (e.g. out of combat, invalid inputs)
    if not model.ok or model.timelineReason == "invalid_inputs" then
        return
    end

    local nowRealtime = GetTime()
    if nowRealtime - lastBarDebugPrintAt < BAR_DEBUG_PRINT_INTERVAL_SECONDS then
        return
    end
    lastBarDebugPrintAt = nowRealtime

    local nowAt = tonumber(model.nowAt or 0) or 0
    local states = model.states or {}
    local s1 = states[1] or {}
    local s2 = states[2] or {}
    local s3 = states[3] or {}

    local function SafeRel(at)
        local v = tonumber(at or 0) - nowAt
        if v < 0 then
            return 0
        end
        return v
    end

    local stateShifted = false
    local currentShiftKey = string.format(
        "%d:%d",
        tonumber(s1.stateId or 0) or 0,
        tonumber(s1.absoluteCycleIndex or s1.cycleIndex or 0) or 0
    )
    if lastStateShiftKey and lastStateShiftKey ~= currentShiftKey then
        stateShifted = true
    end
    lastStateShiftKey = currentShiftKey

    print(string.format(
        "[TBCHUNTER_BAR][TIMELINE_DEBUG][v=%s] meaning=\"fixed now-at-left 3-state timeline with action consequence markers\" modelNow=%.3f modelTotal=%.3f stateShifted=%s activeState=%d activeCycle=%d events=%d s1=id:%d cyc:%d startIn:%.3f endIn:%.3f a1:%s a2:%s s2=id:%d cyc:%d startIn:%.3f endIn:%.3f a1:%s a2:%s s3=id:%d cyc:%d startIn:%.3f endIn:%.3f a1:%s a2:%s reason=%s",
        BAR_DEBUG_PRINT_VERSION,
        nowAt,
        tonumber(model.totalDuration or 0) or 0,
        tostring(stateShifted),
        tonumber(model.activeStateId or 0) or 0,
        tonumber(model.activeCycleIndex or 0) or 0,
        #(model.events or {}),
        tonumber(s1.stateId or 0) or 0,
        tonumber(s1.absoluteCycleIndex or s1.cycleIndex or 0) or 0,
        SafeRel(s1.startAt),
        SafeRel(s1.endAt),
        tostring(s1.chosenAction or "none"),
        tostring(s1.chosenAction2 or "none"),
        tonumber(s2.stateId or 0) or 0,
        tonumber(s2.absoluteCycleIndex or s2.cycleIndex or 0) or 0,
        SafeRel(s2.startAt),
        SafeRel(s2.endAt),
        tostring(s2.chosenAction or "none"),
        tostring(s2.chosenAction2 or "none"),
        tonumber(s3.stateId or 0) or 0,
        tonumber(s3.absoluteCycleIndex or s3.cycleIndex or 0) or 0,
        SafeRel(s3.startAt),
        SafeRel(s3.endAt),
        tostring(s3.chosenAction or "none"),
        tostring(s3.chosenAction2 or "none"),
        tostring(model.timelineReason or "none")
    ))

    -- When a state has two actions, the API only stores the final gcdEndAt; slot 1's GCD end
    -- must be derived so the debug print shows correct values (GCDs + 1.5s for SS, fillerGcdEndAt for filler).
    local function ResolveActionTiming(source, actionName, actionIndex, stateForTwoActionFix)
        local gcdStartAt = 0
        local gcdEndAt = 0
        local castStartAt = 0
        local castEndAt = 0
        if actionIndex == 1 then
            if actionName == "SS" then
                gcdStartAt = tonumber(source.ssPressAt or 0) or 0
                gcdEndAt = tonumber(source.gcdEndAt or 0) or 0
                if stateForTwoActionFix and tostring(stateForTwoActionFix.chosenAction2 or "none") ~= "none" then
                    gcdEndAt = gcdStartAt + GCD_SECONDS
                end
                castStartAt = tonumber(source.ssCastStartAt or 0) or 0
                castEndAt = tonumber(source.ssCastEndAt or 0) or 0
            elseif actionName == "MS" or actionName == "AR" then
                gcdStartAt = tonumber(source.fillerCastAt or 0) or 0
                local fillerGcdEndAt = tonumber(source.fillerGcdEndAt or 0) or 0
                if fillerGcdEndAt > 0 then
                    gcdEndAt = fillerGcdEndAt
                else
                    gcdEndAt = tonumber(source.gcdEndAt or 0) or 0
                end
                castEndAt = tonumber(source.fillerCastEndAt or 0) or 0
            end
        elseif actionIndex == 2 then
            if actionName == "SS" then
                gcdStartAt = tonumber(source.ssPressAt2 or 0) or 0
                gcdEndAt = tonumber(source.gcdEndAt2 or 0) or 0
                castStartAt = tonumber(source.ssCastStartAt2 or 0) or 0
                castEndAt = tonumber(source.ssCastEndAt2 or 0) or 0
            elseif actionName == "MS" or actionName == "AR" then
                gcdStartAt = tonumber(source.fillerCastAt2 or 0) or 0
                local fillerGcdEndAt = tonumber(source.fillerGcdEndAt2 or 0) or 0
                if fillerGcdEndAt > 0 then
                    gcdEndAt = fillerGcdEndAt
                else
                    gcdEndAt = tonumber(source.gcdEndAt2 or 0) or 0
                end
                castEndAt = tonumber(source.fillerCastEndAt2 or 0) or 0
            end
        end
        return gcdStartAt, gcdEndAt, castStartAt, castEndAt
    end

    local function PrintStateAction(stateIndex, slotIndex, actionName, source, stateForTwoActionFix)
        if actionName == "none" then
            return
        end
        local gcdStartAt, gcdEndAt, castStartAt, castEndAt = ResolveActionTiming(source, actionName, slotIndex, stateForTwoActionFix)
        print(string.format(
            "[TBCHUNTER_BAR][TIMELINE_ACTION][v=%s] state=%d slot=%d action=%s GCDs=%.3f GCDsIn=%.3f GCDe=%.3f GCDeIn=%.3f Cs=%.3f CsIn=%.3f Ce=%.3f CeIn=%.3f",
            BAR_DEBUG_PRINT_VERSION,
            tonumber(stateIndex or 0) or 0,
            tonumber(slotIndex or 0) or 0,
            tostring(actionName or "none"),
            gcdStartAt, SafeRel(gcdStartAt),
            gcdEndAt, SafeRel(gcdEndAt),
            castStartAt, SafeRel(castStartAt),
            castEndAt, SafeRel(castEndAt)
        ))
    end

    for i = 1, MAX_SNAPSHOT_STATES do
        local state = states[i] or {}
        local source = state.source or {}
        local stateStartAt = tonumber(source.stateStartAt or state.startAt or 0) or 0
        local stateEndAt = tonumber(source.stateEndAtAdjusted or source.stateEndAt or state.endAt or 0) or 0
        local action1 = tostring(state.chosenAction or "none")
        local action2 = tostring(state.chosenAction2 or "none")
        print(string.format(
            "[TBCHUNTER_BAR][TIMELINE_STATE][v=%s] state=%d id=%d cyc=%d startAt=%.3f startIn=%.3f endAt=%.3f endIn=%.3f a1=%s a2=%s",
            BAR_DEBUG_PRINT_VERSION,
            tonumber(i or 0) or 0,
            tonumber(state.stateId or 0) or 0,
            tonumber(state.absoluteCycleIndex or state.cycleIndex or 0) or 0,
            stateStartAt, SafeRel(stateStartAt),
            stateEndAt, SafeRel(stateEndAt),
            action1,
            action2
        ))
        PrintStateAction(i, 1, action1, source, state)
        PrintStateAction(i, 2, action2, source, state)
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

    frame:SetParent(_G.UIParent)
    frame:ClearAllPoints()
    frame:SetPoint("TOP", anchor, "BOTTOM", db.x, db.y)
end

function module:NAG_FRAME_UPDATED()
    self:UpdateVisibility()
end

function module:NAG_HUNTER_BAR_SCALE_UPDATED()
    self:UpdateDisplay()
end

function module:UpdateVisibility()
    if not frame then
        self:CreateFrameUI()
        if not frame then
            return
        end
    end

    local db = self.db.class
    local isEditMode = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
    if isEditMode then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:Show()
        frame:SetScript("OnUpdate", function(_, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                lastUpdate = 0
                self:UpdateDisplay()
            end
        end)
        return
    end

    local show = db.enabled and true or false
    if show and db.hideOutOfCombat and not UnitAffectingCombat("player") then
        show = false
    end

    if show then
        local dm = NAG.GetModule and NAG:GetModule("DisplayManager", true)
        local level = dm and dm.GetRecommendedClassBarFrameLevel and dm:GetRecommendedClassBarFrameLevel() or 50
        frame:SetFrameStrata("MEDIUM")
        frame:SetFrameLevel(level)
        frame:Show()
        frame:SetScript("OnUpdate", function(_, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                lastUpdate = 0
                self:UpdateDisplay()
            end
        end)
    else
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
end

function module:UpdateDisplay()
    if not frame then
        return
    end
    -- Guard against partial UI init if frame creation failed earlier.
    if not background or not timelineLine or not nowMarker or not debugText then
        return
    end

    local db = self.db.class
    frame:SetSize(db.width, db.height)
    frame:SetAlpha(db.alpha or 1.0)
    local hm = NAG:GetModule("HunterWeaveModule", true)
    local barScale = (hm and hm.GetHunterBarScale and hm:GetHunterBarScale()) or 1
    frame:SetScale(barScale)
    self:UpdateFrameAnchor()

    background:SetShown(db.showBackground == true)
    background:SetColorTexture(
        db.backgroundColor.r,
        db.backgroundColor.g,
        db.backgroundColor.b,
        db.backgroundColor.a
    )
    background:ClearAllPoints()
    background:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    background:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)

    timelineLine:SetShown(db.showTimelineLine == true)
    timelineLine:SetColorTexture(
        db.timelineColor.r,
        db.timelineColor.g,
        db.timelineColor.b,
        db.timelineColor.a
    )
    timelineLine:SetHeight(2)
    timelineLine:ClearAllPoints()
    local frameHeight = frame:GetHeight()
    local belowStrip = Clamp(LANE_BELOW_STRIP_HEIGHT, 0, math.max(0, frameHeight - 20))
    local stripHeight = Clamp(TIMELINE_STRIP_HEIGHT, 8, frameHeight - belowStrip)
    local barBottom = belowStrip
    local stripCenterY = barBottom + stripHeight * 0.5
    timelineLine:SetPoint("LEFT", frame, "BOTTOMLEFT", 0, stripCenterY)
    timelineLine:SetPoint("RIGHT", frame, "BOTTOMLEFT", frame:GetWidth(), stripCenterY)

    nowMarker:SetShown(db.showNowMarker == true)
    nowMarker:SetColorTexture(
        db.nowMarkerColor.r,
        db.nowMarkerColor.g,
        db.nowMarkerColor.b,
        db.nowMarkerColor.a
    )
    nowMarker:SetWidth(4)

    EnsureVisualPools()
    HidePredictionOverlays()

    local nowRealtime = GetTime()
    local snapshotInterval = tonumber(db.snapshotIntervalSeconds or SNAPSHOT_UPDATE_INTERVAL_SECONDS) or SNAPSHOT_UPDATE_INTERVAL_SECONDS
    if snapshotInterval < 0 then
        snapshotInterval = 0
    end

    -- If current time already crossed cached state-0 end, force a full rebuild so
    -- state-0 rollover immediately propagates into state-1/state-2 predictions.
    if cachedModel and cachedModel.ok == true and type(cachedModel.states) == "table" then
        local cachedState0 = cachedModel.states[1]
        local state0EndAt = tonumber(cachedState0 and cachedState0.endAt or 0) or 0
        if state0EndAt > 0 and nowRealtime >= state0EndAt then
            cachedModel = nil
            lastSnapshotAt = 0
        end
    end

    local shouldRebuild = not cachedModel
    if not shouldRebuild then
        if snapshotInterval <= 0 then
            shouldRebuild = true
        elseif (nowRealtime - lastSnapshotAt) >= snapshotInterval then
            shouldRebuild = true
        end
    end

    if shouldRebuild then
        cachedModel = BuildViewModel()
        lastSnapshotAt = nowRealtime
    end
    local model = cachedModel or BuildViewModel()
    PrintBarDebugThrottled(model)

    local width = frame:GetWidth()
    local height = frame:GetHeight()
    local belowStrip = Clamp(LANE_BELOW_STRIP_HEIGHT, 0, math.max(0, height - 20))
    local stripH = Clamp(TIMELINE_STRIP_HEIGHT, 8, height - belowStrip)
    local barBottom = belowStrip
    local barTop = barBottom + stripH
    local laneY = tonumber(db.markerLaneOffsetY or 0) or 0
    local stateOffY = tonumber(db.stateLaneOffsetY or DEFAULT_STATE_LANE_OFFSET_Y) or DEFAULT_STATE_LANE_OFFSET_Y
    -- State lane: negative offset = below strip; positive = above strip.
    local stateLaneY
    if stateOffY < 0 then
        stateLaneY = Clamp(barBottom + stateOffY, 2, math.max(2, barBottom - 2))
    else
        stateLaneY = Clamp(barTop + stateOffY, barTop + 2, math.max(barTop + 2, height - 2))
    end
    local eventLaneY = Clamp(
        barTop + (tonumber(db.eventLaneOffsetY or DEFAULT_EVENT_LANE_OFFSET_Y) or DEFAULT_EVENT_LANE_OFFSET_Y),
        barTop + 2,
        math.max(barTop + 2, height - 2)
    )
    local eventLane2Y = Clamp(
        barTop + (tonumber(db.eventLane2OffsetY or DEFAULT_EVENT_LANE_2_OFFSET_Y) or DEFAULT_EVENT_LANE_2_OFFSET_Y),
        barTop + 2,
        math.max(barTop + 2, height - 2)
    )
    local showTieLines = db.showTieLines == true

    if not model.ok then
        nowMarker:ClearAllPoints()
        nowMarker:SetPoint("TOP", frame, "BOTTOMLEFT", 0, barTop)
        nowMarker:SetPoint("BOTTOM", frame, "BOTTOMLEFT", 0, barBottom)
        debugText:SetShown(db.showDebugText == true)
        if db.showDebugText then
            debugText:ClearAllPoints()
            debugText:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, -2)
            debugText:SetText(string.format("timeline unavailable reason=%s", tostring(model.timelineReason or "none")))
        end
        return
    end

    local segments = BuildSegmentLayout(model, width, db.equalSegmentWidths == true)
    if #segments == 0 then
        return
    end

    local devLabels = IsDevModeEnabled()
    local shownActionIcons = 0
    local shownDividers = 0
    local shownWindupBoundaries = 0

    if db.showSSWindows then
        local shownWindows = 0
        for i = 1, #segments do
            if shownWindows >= MAX_SS_WINDOWS then
                break
            end
            local segment = segments[i]
            local state = segment.state or {}
            local windupSeconds = tonumber(model.windupSeconds or 0.5) or 0.5
            local windupStartAt = (tonumber(state.endAt or segment.endAt or 0) or 0) - windupSeconds
            if windupStartAt < (tonumber(state.startAt or segment.startAt or 0) or 0) then
                windupStartAt = tonumber(state.startAt or segment.startAt or 0) or 0
            end
            local x1 = TimeToSegmentX(segment, windupStartAt)
            local x2 = TimeToSegmentX(segment, tonumber(state.endAt or segment.endAt or 0) or 0)
            if x2 > x1 then
                shownWindows = shownWindows + 1
                local tex = frame.ssWindows[shownWindows]
                tex:SetColorTexture(db.ssWindowColor.r, db.ssWindowColor.g, db.ssWindowColor.b, db.ssWindowColor.a)
                tex:ClearAllPoints()
                tex:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", x1, barBottom - 1)
                tex:SetSize(x2 - x1, stripH + 2)
                tex:Show()

                if db.showWindupMarkers and frame.windupBoundaryTicks and shownWindupBoundaries < MAX_WINDUP_BOUNDARY_TICKS then
                    shownWindupBoundaries = shownWindupBoundaries + 1
                    local leftTick = frame.windupBoundaryTicks[shownWindupBoundaries]
                    leftTick:SetColorTexture(0.85, 1.00, 0.85, 0.90)
                    leftTick:ClearAllPoints()
                    leftTick:SetPoint("BOTTOM", frame, "BOTTOMLEFT", x1, barBottom)
                    leftTick:SetPoint("TOP", frame, "BOTTOMLEFT", x1, barTop)
                    leftTick:Show()
                end
                if db.showWindupMarkers and frame.windupBoundaryTicks and shownWindupBoundaries < MAX_WINDUP_BOUNDARY_TICKS then
                    shownWindupBoundaries = shownWindupBoundaries + 1
                    local rightTick = frame.windupBoundaryTicks[shownWindupBoundaries]
                    rightTick:SetColorTexture(0.85, 1.00, 0.85, 0.90)
                    rightTick:ClearAllPoints()
                    rightTick:SetPoint("BOTTOM", frame, "BOTTOMLEFT", x2, barBottom)
                    rightTick:SetPoint("TOP", frame, "BOTTOMLEFT", x2, barTop)
                    rightTick:Show()
                end
            end
        end
    end

    if db.showSegmentDividers then
        for i = 1, (#segments - 1) do
            if shownDividers >= MAX_STATE_TICKS then
                break
            end
            shownDividers = shownDividers + 1
            local dividerX = tonumber(segments[i].endX or 0) or 0
            local tick = frame.stateTicks[shownDividers]
            tick:SetColorTexture(1.0, 0.9, 0.25, 0.85)
            tick:ClearAllPoints()
            tick:SetPoint("BOTTOM", frame, "BOTTOMLEFT", dividerX, barBottom)
            tick:SetPoint("TOP", frame, "BOTTOMLEFT", dividerX, barTop)
            tick:Show()

            if frame.stateLabels[shownDividers] then
                local label = frame.stateLabels[shownDividers]
                label:ClearAllPoints()
                label:SetPoint("BOTTOM", frame, "BOTTOMLEFT", dividerX, stateLaneY)
                label:SetText(string.format("|cffffdd77S%d|r", tonumber(i + 1) or 0))
                label:SetShown(devLabels)
            end
            if frame.stateTieLines[shownDividers] then
                local line = frame.stateTieLines[shownDividers]
                line:ClearAllPoints()
                if stateLaneY < barBottom then
                    line:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", dividerX, stateLaneY)
                    line:SetSize(1, math.max(1, barBottom - stateLaneY))
                else
                    line:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", dividerX, barTop)
                    line:SetSize(1, math.max(1, stateLaneY - barTop))
                end
                line:SetShown(devLabels and showTieLines)
            end
        end
    end

    if db.showSSIcons then
        for i = 1, #segments do
            if shownActionIcons >= MAX_SS_MARKERS then
                break
            end
            local segment = segments[i]
            local state = segment.state or {}
            local source = state.source or {}
            local windupSeconds = tonumber(model.windupSeconds or 0.5) or 0.5
            local windupStartAt = (tonumber(segment.endAt or 0) or 0) - windupSeconds
            if windupStartAt < (tonumber(segment.startAt or 0) or 0) then
                windupStartAt = tonumber(segment.startAt or 0) or 0
            end

            local function RenderActionIcon(actionName, actionIndex)
                if shownActionIcons >= MAX_SS_MARKERS or actionName == "none" then
                    return
                end
                if actionName == "MS" and db.showMSMarker ~= true then
                    return
                end
                if actionName == "AR" and db.showARMarker ~= true then
                    return
                end

                local spellId = STEADY_SHOT_ID
                if actionName == "MS" then
                    spellId = MULTI_SHOT_ID
                elseif actionName == "AR" then
                    spellId = ARCANE_SHOT_ID
                end

                local iconAt = ResolveActionIconAt(source, actionName, actionIndex, windupStartAt, windupSeconds)
                if iconAt <= 0 then
                    return
                end

                local iconX = TimeToSegmentX(segment, iconAt)
                local laneOffset = (actionIndex == 2) and 15 or 8
                local iconY = Clamp(barTop + laneOffset + laneY, barTop + 6, height - 6)

                shownActionIcons = shownActionIcons + 1
                local icon = frame.ssMarkers[shownActionIcons]
                icon:SetSize(db.iconSize, db.iconSize)
                icon.icon:SetTexture(GetSpellIcon(spellId))
                icon.icon:SetVertexColor(db.ssMarkerColor.r, db.ssMarkerColor.g, db.ssMarkerColor.b, db.ssMarkerColor.a)
                icon:SetAlpha(1.0)
                icon:ClearAllPoints()
                icon:SetPoint("CENTER", frame, "BOTTOMLEFT", iconX, iconY)
                icon.spellId = spellId
                SetSparkKeybind(icon, db.showKeybindOnBar)
                if icon.stateLabel then
                    if devLabels then
                        icon.stateLabel:SetText(string.format("S%d.%d", i, actionIndex))
                        icon.stateLabel:Show()
                    else
                        icon.stateLabel:SetText("")
                        icon.stateLabel:Hide()
                    end
                end
                icon:Show()
            end

            RenderActionIcon(tostring(state.chosenAction or "none"), 1)
            RenderActionIcon(tostring(state.chosenAction2 or "none"), 2)
        end
    end

    if db.showDetailedEvents == true then
        local shownEventTicks = 0
        for i = 1, #model.events do
            if shownEventTicks >= MAX_EVENT_TICKS then
                break
            end
            local e = model.events[i]
            local stateIndex = tonumber(e.stateIndex or 0) or 0
            local segment = segments[stateIndex]
            if segment then
                shownEventTicks = shownEventTicks + 1
                local x = TimeToSegmentX(segment, e.at)
                local tick = frame.eventTicks[shownEventTicks]
                local r, g, b, a = 0.92, 0.92, 0.92, 0.85
                if e.kind == "queued" then
                    r, g, b, a = 1.0, 0.82, 0.18, 0.95
                elseif e.kind == "cast_start" then
                    r, g, b, a = 0.40, 0.80, 1.0, 0.95
                elseif e.kind == "cast_end" then
                    r, g, b, a = 0.15, 1.0, 0.35, 0.95
                elseif e.kind == "gcd_ready" then
                    r, g, b, a = 0.90, 0.45, 1.0, 0.95
                elseif e.kind == "actionable" then
                    r, g, b, a = 0.65, 0.65, 0.65, 0.65
                end
                tick:SetColorTexture(r, g, b, a)
                tick:ClearAllPoints()
                tick:SetPoint("BOTTOM", frame, "BOTTOMLEFT", x, barBottom)
                tick:SetPoint("TOP", frame, "BOTTOMLEFT", x, barTop)
                tick:Show()

                if devLabels and frame.eventLabels[shownEventTicks] then
                    local label = frame.eventLabels[shownEventTicks]
                    label:SetText(GetEventDisplayLabel(e.kind, e.label))
                    label:ClearAllPoints()
                    local isSlot2 = (tonumber(e.actionIndex or 1) == 2)
                    local labelY = isSlot2 and eventLane2Y or eventLaneY
                    labelY = Clamp(labelY, barTop + 2, height - 2)
                    label:SetPoint("BOTTOM", frame, "BOTTOMLEFT", x, labelY)
                    label:Show()
                    if frame.eventTieLines[shownEventTicks] then
                        local line = frame.eventTieLines[shownEventTicks]
                        line:ClearAllPoints()
                        line:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", x, barTop)
                        line:SetSize(1, math.max(1, labelY - barTop))
                        line:SetShown(showTieLines)
                    end
                end
            end
        end
    end

    local segment1 = segments[1]
    local nowMarkerX = tonumber(segment1 and segment1.startX or 0) or 0
    if segment1 then
        nowMarkerX = TimeToSegmentX(segment1, nowRealtime)
    end
    nowMarker:ClearAllPoints()
    nowMarker:SetPoint("TOP", frame, "BOTTOMLEFT", nowMarkerX, barTop)
    nowMarker:SetPoint("BOTTOM", frame, "BOTTOMLEFT", nowMarkerX, barBottom)

    if db.showMSMarker and frame.msMarker then
        frame.msMarker:Hide()
    end
    if db.showARMarker and frame.arMarker then
        frame.arMarker:Hide()
    end

    debugText:SetShown(db.showDebugText == true)
    if db.showDebugText then
        local s1 = model.states[1] or {}
        local s2 = model.states[2] or {}
        local s3 = model.states[3] or {}
        debugText:ClearAllPoints()
        debugText:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, -2)
        debugText:SetText(string.format(
            "now=%.3f dur=%.3f states=%d events=%d s1:%s/%s s2:%s/%s s3:%s/%s reason=%s",
            tonumber(model.nowAt or 0) or 0,
            tonumber(model.totalDuration or 0) or 0,
            #model.states,
            #model.events,
            tostring(s1.chosenAction or "none"),
            tostring(s1.chosenAction2 or "none"),
            tostring(s2.chosenAction or "none"),
            tostring(s2.chosenAction2 or "none"),
            tostring(s3.chosenAction or "none"),
            tostring(s3.chosenAction2 or "none"),
            tostring(model.timelineReason or "none")
        ))
    end
end

-- ============================ UI BUILD ============================
function module:CreateFrameUI()
    if frame then
        return
    end

    OptionsFactory = NAG:GetModule("OptionsFactory")
    local db = self.db.class

    frame = CreateFrame("Frame", "NAGHunterAPITimelineBar", _G.UIParent)
    frame:SetSize(db.width, db.height)
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
        local point, _, _, x, y = frame:GetPoint(1)
        db.point = point
        db.x = x
        db.y = y
    end)

    background = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    timelineLine = frame:CreateTexture(nil, "ARTWORK", nil, -4)
    nowMarker = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    debugText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    debugText:SetJustifyH("LEFT")
    debugText:SetText("")
    debugText:Hide()

    EnsureVisualPools()
end

-- ============================ EVENTS ============================
module.eventHandlers = {
    PLAYER_ENTERING_WORLD = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
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

-- ============================ LIFECYCLE ============================
function module:ModuleInitialize()
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

-- ============================ OPTIONS ============================
function module:GetOptions()
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end

    return {
        type = "group",
        name = "Hunter API Timeline Bar",
        order = 29,
        width = "full",
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enabled",
                "Enable/disable the Hunter API timeline bar.",
                function() return self:GetSetting("class", "enabled") end,
                function(_, value)
                    self:SetSetting("class", "enabled", value)
                    if value then self:Enable() else self:Disable() end
                end,
                { order = 1 }
            ),
            hideOutOfCombat = OptionsFactory:CreateToggle(
                "Hide Out of Combat",
                "Hide this bar when out of combat.",
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
            autoAnchor = OptionsFactory:CreateToggle(
                "Auto Anchor",
                "Anchor this bar relative to NAG display anchor when available.",
                function() return self:GetSetting("class", "autoAnchor") end,
                function(_, value)
                    self:SetSetting("class", "autoAnchor", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 4 }
            ),
            lockToNagAnchor = OptionsFactory:CreateToggle(
                "Lock To NAG Anchor",
                "When auto anchor is enabled, lock this bar to NAG anchor.",
                function() return self:GetSetting("class", "lockToNagAnchor") end,
                function(_, value)
                    self:SetSetting("class", "lockToNagAnchor", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 5 }
            ),
            anchorOffsetX = OptionsFactory:CreateRange(
                "Anchor Offset X",
                "Horizontal anchor offset.",
                function() return self:GetSetting("class", "x") end,
                function(_, value)
                    self:SetSetting("class", "x", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -600, max = 600, step = 1, order = 6 }
            ),
            anchorOffsetY = OptionsFactory:CreateRange(
                "Anchor Offset Y",
                "Vertical anchor offset.",
                function() return self:GetSetting("class", "y") end,
                function(_, value)
                    self:SetSetting("class", "y", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -600, max = 600, step = 1, order = 7 }
            ),
            width = OptionsFactory:CreateRange(
                "Width",
                "Bar width.",
                function() return self:GetSetting("class", "width") end,
                function(_, value)
                    self:SetSetting("class", "width", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 120, max = 720, step = 1, order = 10 }
            ),
            height = OptionsFactory:CreateRange(
                "Height",
                "Bar height.",
                function() return self:GetSetting("class", "height") end,
                function(_, value)
                    self:SetSetting("class", "height", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 8, max = 60, step = 1, order = 11 }
            ),
            alpha = OptionsFactory:CreateRange(
                "Alpha",
                "Bar transparency.",
                function() return self:GetSetting("class", "alpha") end,
                function(_, value)
                    self:SetSetting("class", "alpha", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.05, max = 1.0, step = 0.01, order = 12 }
            ),
            horizonSeconds = OptionsFactory:CreateRange(
                "Horizon Seconds",
                "API prediction horizon used to fetch enough upcoming states.",
                function() return self:GetSetting("class", "horizonSeconds") end,
                function(_, value)
                    self:SetSetting("class", "horizonSeconds", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 3.0, max = 10.0, step = 0.1, order = 13 }
            ),
            snapshotIntervalSeconds = OptionsFactory:CreateRange(
                "Snapshot Interval (s)",
                "How often to rebuild the 3-state model. 0 = every frame (most fluid).",
                function() return self:GetSetting("class", "snapshotIntervalSeconds") end,
                function(_, value)
                    self:SetSetting("class", "snapshotIntervalSeconds", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 0.0, max = 0.2, step = 0.01, order = 13.5 }
            ),
            iconSize = OptionsFactory:CreateRange(
                "Icon Size",
                "Prediction icon size.",
                function() return self:GetSetting("class", "iconSize") end,
                function(_, value)
                    self:SetSetting("class", "iconSize", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 10, max = 40, step = 1, order = 14 }
            ),
            markerLaneOffsetY = OptionsFactory:CreateRange(
                "Marker Lane Y Offset",
                "Vertical offset for press icons inside the timeline strip.",
                function() return self:GetSetting("class", "markerLaneOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "markerLaneOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -40, max = 40, step = 1, order = 15 }
            ),
            stateLaneOffsetY = OptionsFactory:CreateRange(
                "State Lane Offset Y",
                "Vertical offset for state boundary labels. Negative = below strip, positive = above strip.",
                function() return self:GetSetting("class", "stateLaneOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "stateLaneOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -24, max = 60, step = 1, order = 16 }
            ),
            headerLaneOffsetY = OptionsFactory:CreateRange(
                "Header Lane Offset Y",
                "Vertical offset (from strip top) for snapshot headers.",
                function() return self:GetSetting("class", "headerLaneOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "headerLaneOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 4, max = 60, step = 1, order = 17 }
            ),
            eventLaneOffsetY = OptionsFactory:CreateRange(
                "Event Lane 1 Offset Y",
                "Vertical offset (from strip top) for first row of event labels (slot 1).",
                function() return self:GetSetting("class", "eventLaneOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "eventLaneOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 6, max = 80, step = 1, order = 18 }
            ),
            eventLane2OffsetY = OptionsFactory:CreateRange(
                "Event Lane 2 Offset Y",
                "Vertical offset (from strip top) for second row of event labels (slot 2).",
                function() return self:GetSetting("class", "eventLane2OffsetY") end,
                function(_, value)
                    self:SetSetting("class", "eventLane2OffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = 10, max = 80, step = 1, order = 19 }
            ),
            showTieLines = OptionsFactory:CreateToggle(
                "Show Vertical Tie-Lines",
                "Draw vertical lines from timeline timestamps to text lanes.",
                function() return self:GetSetting("class", "showTieLines") end,
                function(_, value)
                    self:SetSetting("class", "showTieLines", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 20 }
            ),
            showSegmentDividers = OptionsFactory:CreateToggle(
                "Show Segment Dividers",
                "Show divider lines between state 1->2 and 2->3.",
                function() return self:GetSetting("class", "showSegmentDividers") end,
                function(_, value)
                    self:SetSetting("class", "showSegmentDividers", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 20.5 }
            ),
            showWindupMarkers = OptionsFactory:CreateToggle(
                "Show Wind-up Boundaries",
                "Draw left/right boundary lines for each state wind-up zone.",
                function() return self:GetSetting("class", "showWindupMarkers") end,
                function(_, value)
                    self:SetSetting("class", "showWindupMarkers", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 20.6 }
            ),
            equalSegmentWidths = OptionsFactory:CreateToggle(
                "Equal Segment Widths",
                "Use equal-width blocks for state 1/2/3 instead of duration-proportional widths.",
                function() return self:GetSetting("class", "equalSegmentWidths") end,
                function(_, value)
                    self:SetSetting("class", "equalSegmentWidths", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 20.7 }
            ),
            msOverlapOffsetY = OptionsFactory:CreateRange(
                "MS Overlap Y",
                "MS vertical offset when overlaid in the same lane.",
                function() return self:GetSetting("class", "msOverlapOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "msOverlapOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -40, max = 40, step = 1, order = 21 }
            ),
            arOverlapOffsetY = OptionsFactory:CreateRange(
                "AR Overlap Y",
                "AR vertical offset when overlaid in the same lane.",
                function() return self:GetSetting("class", "arOverlapOffsetY") end,
                function(_, value)
                    self:SetSetting("class", "arOverlapOffsetY", value)
                    if frame then self:UpdateDisplay() end
                end,
                { min = -40, max = 40, step = 1, order = 22 }
            ),
            showSSWindows = OptionsFactory:CreateToggle(
                "Show Wind-up Zones",
                "Render per-state wind-up zones (0.5s base, haste-scaled per state).",
                function() return self:GetSetting("class", "showSSWindows") end,
                function(_, value)
                    self:SetSetting("class", "showSSWindows", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 30 }
            ),
            showSSIcons = OptionsFactory:CreateToggle(
                "Show Action Press Icons",
                "Render API-predicted action icons (SS/MS/AR) on the 3-state timeline.",
                function() return self:GetSetting("class", "showSSIcons") end,
                function(_, value)
                    self:SetSetting("class", "showSSIcons", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 31 }
            ),
            showMSMarker = OptionsFactory:CreateToggle(
                "Show Multi-Shot Icons",
                "Allow Multi-Shot action icons when API predicts MS in a state.",
                function() return self:GetSetting("class", "showMSMarker") end,
                function(_, value)
                    self:SetSetting("class", "showMSMarker", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 32 }
            ),
            showARMarker = OptionsFactory:CreateToggle(
                "Show Arcane Shot Icons",
                "Allow Arcane Shot action icons when API predicts AR in a state.",
                function() return self:GetSetting("class", "showARMarker") end,
                function(_, value)
                    self:SetSetting("class", "showARMarker", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 33 }
            ),
            showDetailedEvents = OptionsFactory:CreateToggle(
                "Show Detailed Event Ticks",
                "Show dense event ticks/labels (GCDs, GCDe, Cs, Ce). Keep off for simplified SteadyWeave-style view.",
                function() return self:GetSetting("class", "showDetailedEvents") end,
                function(_, value)
                    self:SetSetting("class", "showDetailedEvents", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 33.5 }
            ),
            showDebugText = OptionsFactory:CreateToggle(
                "Show Debug Text",
                "Show concise API-chain debug text below bar.",
                function() return self:GetSetting("class", "showDebugText") end,
                function(_, value)
                    self:SetSetting("class", "showDebugText", value)
                    if frame then self:UpdateDisplay() end
                end,
                { order = 34 }
            ),
        }
    }
end

return HunterAPITimelineBar
