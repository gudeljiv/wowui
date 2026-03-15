--- @module "NAG.HunterStateMachineBar"
--- Guitar-hero style action bar driven by TBCHunterAPI state timeline.
---
--- Shows predicted action icons (SS/MS/AR) scrolling right-to-left toward a hit zone at the left edge.
--- Timeline is fully state-machine-driven and includes state0 (NOW) recommendations.
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
local Version = ns.Version

-- ============================ CONSTANTS ============================
local UPDATE_INTERVAL = 0.016
local DEFAULT_HORIZON_SECONDS = 10.0
local DEFAULT_SNAPSHOT_INTERVAL_SECONDS = 0.1
local PAST_TOLERANCE_SECONDS = 0.2
local MAX_ACTION_ICONS = 18
-- Only show actions from state 0 (NOW) plus the next 2 predicted states.
local MAX_STATES_FOR_BAR = 3
local ACTION_SS = "SS"
local ACTION_MS = "MS"
local ACTION_AR = "AR"
local STEADY_SHOT_ID = 34120
local MULTI_SHOT_ID = 27021
local ARCANE_SHOT_ID = 27019

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        hideOutOfCombat = false,

        autoAnchor = true,
        lockToNagAnchor = true,
        point = "CENTER",
        x = 210,
        y = 58,

        width = 240,
        height = 24,
        alpha = 1.0,
        horizonSeconds = DEFAULT_HORIZON_SECONDS,
        snapshotIntervalSeconds = 0.1,
        iconSize = 18,
        sparkSmoothing = 0.30,

        showBackground = true,
        showHitZone = true,
        backgroundColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.45 },
        hitZoneColor = { r = 1.0, g = 1.0, b = 1.0, a = 0.85 },
    }
}

--- @class HunterStateMachineBar:CoreModule
local HunterStateMachineBar = NAG:CreateModule("HunterStateMachineBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    messageHandlers = {
        NAG_FRAME_UPDATED = true,
    },
    hidden = function()
        return not (Version and Version:IsTBC()) or UnitClassBase("player") ~= "HUNTER"
    end,
})

ns.HunterStateMachineBar = HunterStateMachineBar
local module = HunterStateMachineBar

-- ============================ LOCALS ============================
local frame
local background
local hitZone
local lastUpdate = 0
local lastSnapshotAt = 0
local cachedActions = {}

-- ============================ HELPERS ============================
--- @param v number
--- @param minV number
--- @param maxV number
--- @return number
local function Clamp(v, minV, maxV)
    if v < minV then
        return minV
    end
    if v > maxV then
        return maxV
    end
    return v
end

--- @param spellId number
--- @return string
local function GetSpellIcon(spellId)
    if NAG and NAG.Spell and NAG.Spell[spellId] and NAG.Spell[spellId].icon then
        return NAG.Spell[spellId].icon
    end
    return GetSpellTexture(spellId) or "Interface\\Icons\\INV_Misc_QuestionMark"
end

--- @param action string|nil
--- @return number
local function ActionToSpellId(action)
    if action == ACTION_SS then
        return STEADY_SHOT_ID
    end
    if action == ACTION_MS then
        return MULTI_SHOT_ID
    end
    if action == ACTION_AR then
        return ARCANE_SHOT_ID
    end
    return 0
end

--- @param db table|nil
--- @return number
local function ResolveHorizonSeconds(db)
    local horizon = tonumber(db and db.horizonSeconds or DEFAULT_HORIZON_SECONDS) or DEFAULT_HORIZON_SECONDS
    if horizon <= 0 then
        horizon = DEFAULT_HORIZON_SECONDS
    end
    return horizon
end

--- @param db table|nil
--- @return number
local function ResolveSnapshotInterval(db)
    local interval = tonumber(db and db.snapshotIntervalSeconds or DEFAULT_SNAPSHOT_INTERVAL_SECONDS)
        or DEFAULT_SNAPSHOT_INTERVAL_SECONDS
    if interval < 0 then
        interval = 0
    end
    return interval
end

--- @param actions table
--- @param at number|nil
--- @param spellId number
--- @param slot number
--- @param stateIndex number
local function PushAction(actions, at, spellId, slot, stateIndex)
    local ts = tonumber(at or 0) or 0
    if ts <= 0 or spellId <= 0 then
        return
    end
    actions[#actions + 1] = {
        at = ts,
        spellId = spellId,
        slot = slot or 1,
        stateIndex = tonumber(stateIndex) or 0,
    }
end

--- @param state table|nil
--- @param actions table
--- @param stateIndex number
local function CollectStateActions(state, actions, stateIndex)
    if not state then
        return
    end

    local chosen1 = tostring(state.chosenAction or "none")
    local chosen2 = tostring(state.chosenAction2 or "none")
    local filler1 = tostring(state.fillerSpell or "none")
    local filler2 = tostring(state.fillerSpell2 or "none")

    local sidx = tonumber(stateIndex) or 0
    if chosen1 == ACTION_SS then
        PushAction(actions, state.ssPressAt, STEADY_SHOT_ID, 1, sidx)
    elseif filler1 ~= ACTION_MS and filler1 ~= ACTION_AR then
        PushAction(actions, state.fillerCastAt, ActionToSpellId(chosen1), 1, sidx)
    end

    if filler1 == ACTION_MS or filler1 == ACTION_AR then
        PushAction(actions, state.fillerCastAt, ActionToSpellId(filler1), 1, sidx)
    end

    if chosen2 == ACTION_SS then
        PushAction(actions, state.ssPressAt2, STEADY_SHOT_ID, 2, sidx)
    elseif filler2 ~= ACTION_MS and filler2 ~= ACTION_AR then
        PushAction(actions, state.fillerCastAt2, ActionToSpellId(chosen2), 2, sidx)
    end

    if filler2 == ACTION_MS or filler2 == ACTION_AR then
        PushAction(actions, state.fillerCastAt2, ActionToSpellId(filler2), 2, sidx)
    end
end

--- @param timeline table|nil
--- @param now number
--- @param horizonSeconds number
--- @return table
local function CollectActionMoments(timeline, now, horizonSeconds)
    if not timeline or timeline.ok ~= true then
        return {}
    end

    local actions = {}
    CollectStateActions(timeline.state0, actions, 0)

    local states = timeline.states
    if type(states) == "table" then
        local limit = math.min(MAX_STATES_FOR_BAR - 1, #states)
        for i = 1, limit do
            CollectStateActions(states[i], actions, i)
        end
    end

    local horizonAt = now + horizonSeconds
    local pastCut = now - PAST_TOLERANCE_SECONDS
    local filtered = {}
    for i = 1, #actions do
        local e = actions[i]
        if e and e.at >= pastCut and e.at <= horizonAt then
            filtered[#filtered + 1] = e
        end
    end

    table.sort(filtered, function(a, b)
        if a.at == b.at then
            return (a.spellId or 0) < (b.spellId or 0)
        end
        return a.at < b.at
    end)
    for i = 1, #filtered do
        if not filtered[i].stateIndex then
            filtered[i].stateIndex = 0
        end
    end

    return filtered
end

local function PredictTimeline(horizonSeconds)
    if NAG and NAG.TBCHunterPredictStateTimelineLive then
        return NAG:TBCHunterPredictStateTimelineLive(horizonSeconds)
    end
    local hunterAPI = NAG:GetModule("TBCHunterAPI", true)
    if hunterAPI and hunterAPI.PredictStateTimelineLive then
        return hunterAPI:PredictStateTimelineLive(horizonSeconds)
    end
    return nil
end

-- ============================ FRAME/ICONS ============================
local function HideAllIcons()
    if not frame or not frame.actionIcons then
        return
    end
    for i = 1, #frame.actionIcons do
        local iconFrame = frame.actionIcons[i]
        if iconFrame then
            iconFrame:Hide()
        end
    end
end

function module:UpdateFrameAnchor()
    if not frame then
        return
    end
    local db = self.db and self.db.class
    if not db then
        return
    end

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

function module:CreateFrameUI()
    if frame then
        return
    end

    local db = self.db.class
    frame = CreateFrame("Frame", "NAGHunterStateMachineBar", _G.UIParent, "BackdropTemplate")
    frame:SetSize(db.width, db.height)
    frame:SetPoint(db.point, db.x, db.y)
    frame:SetAlpha(db.alpha or 1.0)
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
    frame:Hide()

    background = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    background:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    background:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)

    hitZone = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    hitZone:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    hitZone:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
    hitZone:SetWidth(3)

    frame.actionIcons = {}
    for i = 1, MAX_ACTION_ICONS do
        local iconFrame = CreateFrame("Frame", nil, frame)
        iconFrame:SetSize(db.iconSize, db.iconSize)
        iconFrame:SetFrameLevel(frame:GetFrameLevel() + 10)
        iconFrame.icon = iconFrame:CreateTexture(nil, "ARTWORK", nil, 0)
        iconFrame.icon:SetAllPoints()
        iconFrame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        iconFrame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        iconFrame.stateText = iconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        iconFrame.stateText:SetPoint("BOTTOM", iconFrame, "TOP", 0, 2)
        iconFrame.stateText:SetJustifyH("CENTER")
        iconFrame.stateText:SetText("")
        iconFrame.currentX = nil
        iconFrame:Hide()
        frame.actionIcons[i] = iconFrame
    end
end

-- ============================ RENDERING ============================
function module:RefreshSnapshot(now)
    if not frame then
        return
    end
    local db = self.db.class
    local horizonSeconds = ResolveHorizonSeconds(db)
    local snapshotInterval = ResolveSnapshotInterval(db)

    if lastSnapshotAt > 0 and (now - lastSnapshotAt) < snapshotInterval then
        return
    end

    local timeline = PredictTimeline(horizonSeconds)
    if timeline and timeline.ok == true then
        cachedActions = CollectActionMoments(timeline, now, horizonSeconds)
    else
        cachedActions = {}
    end
    lastSnapshotAt = now
end

function module:RenderActions(now)
    if not frame then
        return
    end

    local db = self.db.class
    local width = tonumber(db.width or frame:GetWidth() or 0) or 0
    local horizonSeconds = ResolveHorizonSeconds(db)
    local iconSize = tonumber(db.iconSize or 18) or 18
    local smoothing = Clamp(tonumber(db.sparkSmoothing or 0.30) or 0.30, 0, 1)
    local actions = cachedActions or {}
    local iconCount = #frame.actionIcons
    local drawCount = math.min(#actions, iconCount)

    for i = 1, drawCount do
        local entry = actions[i]
        local iconFrame = frame.actionIcons[i]
        local secondsFromNow = (tonumber(entry.at or 0) or 0) - now
        local targetX = (secondsFromNow / horizonSeconds) * width

        if targetX < -iconSize then
            if iconFrame.stateText then
                iconFrame.stateText:Hide()
            end
            iconFrame:Hide()
        else
            if iconFrame.currentX == nil or targetX >= iconFrame.currentX then
                iconFrame.currentX = targetX
            else
                iconFrame.currentX = iconFrame.currentX + ((targetX - iconFrame.currentX) * smoothing)
            end

            iconFrame:SetSize(iconSize, iconSize)
            iconFrame.icon:SetTexture(GetSpellIcon(tonumber(entry.spellId or 0) or 0))
            iconFrame:ClearAllPoints()
            local yOffset = (entry.slot == 2) and 6 or 0
            iconFrame:SetPoint("CENTER", frame, "LEFT", iconFrame.currentX, yOffset)
            if iconFrame.stateText then
                iconFrame.stateText:SetText(tostring(entry.stateIndex or 0))
                iconFrame.stateText:Show()
            end
            iconFrame:Show()
        end
    end

    for i = drawCount + 1, iconCount do
        local iconFrame = frame.actionIcons[i]
        iconFrame.currentX = nil
        if iconFrame.stateText then
            iconFrame.stateText:Hide()
        end
        iconFrame:Hide()
    end
end

function module:UpdateDisplay()
    if not frame then
        self:CreateFrameUI()
        if not frame then
            return
        end
    end

    local db = self.db.class
    frame:SetSize(db.width, db.height)
    frame:SetAlpha(db.alpha or 1.0)

    if background then
        if db.showBackground then
            local c = db.backgroundColor
            background:SetColorTexture(c.r, c.g, c.b, c.a)
            background:Show()
        else
            background:Hide()
        end
    end

    if hitZone then
        if db.showHitZone then
            local c = db.hitZoneColor
            hitZone:SetColorTexture(c.r, c.g, c.b, c.a)
            hitZone:Show()
        else
            hitZone:Hide()
        end
    end

    local now = GetTime()
    self:RefreshSnapshot(now)
    self:RenderActions(now)
end

-- ============================ VISIBILITY ============================
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
    if not db.enabled then
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end

    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:Show()
        frame:EnableMouse(true)
        self:UpdateFrameAnchor()
        frame:SetScript("OnUpdate", function(_, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                module:UpdateDisplay()
                lastUpdate = 0
            end
        end)
        return
    end

    if db.hideOutOfCombat and not UnitAffectingCombat("player") then
        frame:Hide()
        frame:SetScript("OnUpdate", nil)
        return
    end

    frame:Show()
    frame:EnableMouse(false)
    self:UpdateFrameAnchor()
    frame:SetScript("OnUpdate", function(_, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            module:UpdateDisplay()
            lastUpdate = 0
        end
    end)
end

-- ============================ LIFECYCLE ============================
function module:ModuleInitialize()
    self:CreateFrameUI()
end

function module:ModuleEnable()
    lastUpdate = 0
    lastSnapshotAt = 0
    cachedActions = {}
    self:UpdateVisibility()
end

function module:ModuleDisable()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
    HideAllIcons()
end
