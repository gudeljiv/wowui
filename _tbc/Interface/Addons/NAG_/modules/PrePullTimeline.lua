--- @module "NAG.PrePullTimeline"
--- ShamanWeave-style pre-pull timeline with circular spark icons converging on NOW (right edge)
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
--- @type OptionsFactory
--- @type StateManager
local OptionsFactory, StateManager
--- @type PullTimerManager
local PullTimerManager
--- @type SpecCompat
local SpecCompat
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateFrame = _G.CreateFrame
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon

local L = LibStub("AceLocale-3.0"):GetLocale("NAG")

-- Lua helpers
local min = math.min
local max = math.max
local abs = math.abs
local tinsert = table.insert

-- ============================ CONSTANTS ============================
local UPDATE_INTERVAL = 0.033 -- ~30 FPS (timeline polling only)
local DEFAULT_ICON_SIZE = 16
local MAX_SPARKS = 16

-- Potion normalization
local POTION_ITEM_ID = 40211 -- Potion of Speed (standard item icon for potions)

-- ============================ BACKGROUND ART SETTINGS ============================
-- Tweak these values to adjust the background art in one place
local BG_ART_TEXTURE = "Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarCD.png"
local BG_ART_WIDTH = 260
local BG_ART_HEIGHT = 71
local BG_ART_ALPHA = 1
local BG_ART_Y_OFFSET = 0
local BG_ART_X_OFFSET = -15

-- Moving pull marker tuning
local PULL_MARKER_Y_OFFSET = -8
local SPARK_EMBLEM_Y_OFFSET = 7

-- Zero-cross glow effect settings
local GLOW_TEXTURE = "Interface\\Cooldown\\star4"
local GLOW_DURATION = 0.65
local GLOW_ALPHA_PEAK = 0.9
local GLOW_SIZE_MULT = 1.4

-- ============================ DEFAULTS ============================
local defaults = {
    char = {
        enabled = true,
        showBar = true,
        hideOutOfCombat = true,
        showKeybindOnBar = true,
        bar = {
            width = 200,
            height = 20,
            alpha = 1,
            point = "CENTER",
            x = 0,
			y = 160,
            locked = false,
            iconSize = DEFAULT_ICON_SIZE,
            colors = {
                background = { r = 0.2, g = 0.2, b = 0.2, a = 0.8 },
                timeline = { r = 0.3, g = 0.7, b = 1.0, a = 0.9 },
                spark = { r = 1, g = 1, b = 1, a = 1 },
                now = { r = 0, g = 0, b = 0, a = 1 },
            },
        },
        presetLayout = {
            enabled = true,
            width = 120,
            height = 18,
            alpha = 1.0,
            x = 0,
			y = 294,
            iconSize = 16,
            colors = {
                background = { r = 0.2, g = 0.2, b = 0.2, a = 0.8 },
                timeline = { r = 0.4, g = 0.7, b = 1.0, a = 0.95 },
                spark = { r = 1, g = 1, b = 1, a = 1 },
                now = { r = 0, g = 0, b = 0, a = 1 },
            },
        },
    }
}

-- ============================ MODULE ============================
--- @class PrePullTimeline:CoreModule
local PrePullTimeline = NAG:CreateModule("PrePullTimeline", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    debug = true,
    debugCategories = { ns.DEBUG_CATEGORIES.UI, ns.DEBUG_CATEGORIES.FEATURES },
    eventHandlers = {
        START_PLAYER_COUNTDOWN = true,
        CANCEL_PLAYER_COUNTDOWN = true,
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = "PLAYER_REGEN_DISABLED",
    },
    messageHandlers = {
        NAG_FRAME_UPDATED = true,
    },
    defaultState = {
        frame = nil,
        isDragging = false,
        active = false,           -- internal fallback if PTM unavailable
        pullStartTime = nil,      -- fallback
        pullDuration = nil,       -- fallback
        _lastDebugSecond = nil,
        _lastActionCount = nil,
    }
})
ns.PrePullTimeline = PrePullTimeline

-- ============================ LOCAL STATE ============================
local frame
local isDragging = false
local lastUpdate = 0
local autoAnchorEnabled = true

-- ============================ LIFECYCLE ============================
function PrePullTimeline:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    StateManager = NAG:GetModule("StateManager")
    PullTimerManager = NAG:GetModule("PullTimerManager")
    SpecCompat = NAG:GetModule("SpecCompat")
end

function PrePullTimeline:ModuleEnable()
    if not frame then
        self:CreateFrames()
    end
    self:UpdateFrameSettings()
    self:UpdateVisibility()

    frame:SetScript("OnUpdate", function(_, elapsed)
        if not frame:IsShown() then
            return
        end
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            PrePullTimeline:UpdateDisplay()
            lastUpdate = 0
        end
    end)
end

function PrePullTimeline:ModuleDisable()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
end

-- ============================ EVENTS & MESSAGES ============================
function PrePullTimeline:START_PLAYER_COUNTDOWN(event, initiatedBy, timeRemaining, duration)
    self.state.active = true
    self.state.pullStartTime = GetTime()
    self.state.pullDuration = (type(timeRemaining) == "number" and timeRemaining)
        or (type(duration) == "number" and duration) or 10
    self.state._lastDebugSecond = nil
    self.state._lastActionCount = nil
    if frame then
        self:UpdateVisibility()
    end
end

function PrePullTimeline:CANCEL_PLAYER_COUNTDOWN()
    self.state.active = false
    self.state.pullStartTime = nil
    self.state.pullDuration = nil
    self.state._lastDebugSecond = nil
    self.state._lastActionCount = nil
    self:UpdateVisibility()
    self:ClearSparks()
end

function PrePullTimeline:NAG_FRAME_UPDATED()
    if self.db.char.presetLayout.enabled and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    end
end

function PrePullTimeline:PLAYER_REGEN_DISABLED()
    self:UpdateVisibility()
end

-- ============================ FRAME SETUP ============================
function PrePullTimeline:CreateFrames()
    frame = CreateFrame("Frame", "NAGPrePullTimeline", UIParent)
    frame:SetSize(self.db.char.bar.width, self.db.char.bar.height)
    frame:SetPoint(self.db.char.bar.point, self.db.char.bar.x, self.db.char.bar.y)
    frame:SetAlpha(1)

    -- Background
    local bg = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bg:SetAllPoints()
    frame.bg = bg

    -- Timeline (fill full width)
    local timeline = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    timeline:SetPoint("LEFT", frame, "LEFT", 0, 0)
    timeline:SetSize(frame:GetWidth(), frame:GetHeight())
    frame.timeline = timeline

    -- Inner (white) timeline line, 1px thinner, on top
    local timelineInner = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    timelineInner:SetPoint("CENTER", timeline, "CENTER")
    timelineInner:SetSize(200, 1)
    timelineInner:SetColorTexture(1, 1, 1, 0.6)
    frame.timelineInner = timelineInner

    -- Background art behind the bar for readability
    local bgArt = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    bgArt:SetPoint("CENTER", frame, "CENTER", BG_ART_X_OFFSET, BG_ART_Y_OFFSET)
    bgArt:SetTexture(BG_ART_TEXTURE)
    bgArt:SetSize(BG_ART_WIDTH, BG_ART_HEIGHT)
    bgArt:SetAlpha(BG_ART_ALPHA)
    frame.bgArt = bgArt

    -- Click hitbox matching background art area (captures drag and right-click menu)
    local bgHitbox = CreateFrame("Frame", nil, frame)
    bgHitbox:SetFrameStrata("BACKGROUND")
    bgHitbox:SetPoint("CENTER", frame, "CENTER", BG_ART_X_OFFSET, BG_ART_Y_OFFSET)
    bgHitbox:SetSize(BG_ART_WIDTH, BG_ART_HEIGHT)
    bgHitbox:EnableMouse(true)
    bgHitbox:RegisterForDrag("LeftButton")
    -- Forward drag behavior
    bgHitbox:SetScript("OnDragStart", function()
        if self.db.char.presetLayout.enabled or autoAnchorEnabled then
            self.db.char.presetLayout.enabled = false
            autoAnchorEnabled = false
            self:UpdateFrameSettings()
        end
        if not self.db.char.bar.locked and not UnitAffectingCombat("player") then
            frame:StartMoving()
            isDragging = true
        end
    end)
    bgHitbox:SetScript("OnDragStop", function()
        if isDragging then
            frame:StopMovingOrSizing()
            isDragging = false
            local point, _, _, x, y = frame:GetPoint()
            self.db.char.bar.point = point
            self.db.char.bar.x = x
            self.db.char.bar.y = y
        end
    end)
    -- Right-click context menu
    bgHitbox:SetScript("OnMouseUp", function(_, button)
        if button == "RightButton" then
            local menu = {
                { text = "Edit", notCheckable = true, func = function()
                    local classModule = NAG:GetClassModule()
                    if not classModule then return end
                    local rotation, name = classModule:GetCurrentRotation()
                    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or nil
                    if rotation and ns.RotationEditor and specIndex and name then
                        ns.RotationEditor:ShowEditor(specIndex, { name = name, config = rotation }, classModule, "prepull")
                    end
                end },
                { text = "Close", notCheckable = true, func = function()
                    frame:Hide()
                end },
                { text = "Hide forever", notCheckable = true, func = function()
                    PrePullTimeline.db.char.showBar = false
                    frame:Hide()
                end },
            }
            ns.LibUIDropDownMenu:EasyMenu(menu, frame.menuFrame, "cursor", 0, 0, "MENU", 2)
        end
    end)
    frame.bgHitbox = bgHitbox

    -- NOW marker (right edge)
    local now = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    now:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    now:SetWidth(2)
    now:SetColorTexture(0, 0, 0, 0.7)
    frame.now = now

    -- Inner (white) NOW marker, 1px thinner, on top
    local nowInner = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    nowInner:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    nowInner:SetWidth(1)
    nowInner:SetColorTexture(1, 1, 1, 0.6)
    frame.nowInner = nowInner

    -- Zero-second arrow (downwards) at 0s mark (40px from left on 200px bar)
    local zeroArrow = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    zeroArrow:SetTexture("Interface\\Buttons\\Arrow-Down-Up")
    zeroArrow:SetSize(20, 20)
    zeroArrow:SetPoint("BOTTOM", frame, "LEFT", 42, 8)
    zeroArrow:SetVertexColor(1, 1, 1, 0.7)
    frame.zeroArrow = zeroArrow

    -- Additional emblem at zero: centered on the bar using custom art
    local zeroEmblem = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    zeroEmblem:SetTexture("Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrow.png")
    zeroEmblem:SetSize(40, 40)
    zeroEmblem:SetPoint("CENTER", frame, "LEFT", 40, 0)
    frame.zeroEmblem = zeroEmblem

    -- Moving pull marker (spark): use the same emblem as zero mark (centered), keep as an "up" marker
    -- Note: Created before spark frames so it renders below them in the same frameLevel
    local pullMarker = CreateFrame("Frame", nil, frame)
    pullMarker:SetSize(25, 25)
    -- Arrow textures at lower draw layers so they render below spark icons (strata 1-2 vs sparks' 3-4)
    local pullArrow = pullMarker:CreateTexture(nil, "OVERLAY", nil, 2)
    pullArrow:ClearAllPoints()
    pullArrow:SetPoint("CENTER", pullMarker, "CENTER", 0, SPARK_EMBLEM_Y_OFFSET)
    pullArrow:SetSize(30, 30)  -- Reduced by 20% from 38x38 (38 * 0.8 = 30.4, rounded to 30)
    pullArrow:SetTexture("Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarArrowCenter.png")
    pullArrow:SetVertexColor(1, 1, 1, 0.9)
    pullMarker.arrow = pullArrow
    -- Add Arrow-Down-Up overlay effect (pointing up) that moves with the spark
    local pullArrowFX = pullMarker:CreateTexture(nil, "OVERLAY", nil, 1)
    pullArrowFX:ClearAllPoints()
    pullArrowFX:SetPoint("CENTER", pullMarker, "CENTER", 0, PULL_MARKER_Y_OFFSET)
    pullArrowFX:SetSize(16, 16)  -- Reduced by 20% from 20x20 (20 * 0.8 = 16)
    pullArrowFX:SetTexture("Interface\\Buttons\\Arrow-Down-Up")
    pullArrowFX:SetTexCoord(0, 1, 1, 0)
    pullArrowFX:SetVertexColor(1, 1, 1, 0.7)
    pullMarker.arrowFX = pullArrowFX
    -- Timer text overlay (keep at higher layer so it's visible above everything)
    local timerText = pullMarker:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    timerText:SetPoint("CENTER", pullMarker, "CENTER", 0, 0)
    timerText:SetTextColor(1, 1, 1, 0.9)
    pullMarker.text = timerText
    pullMarker:Hide()
    frame.pullMarker = pullMarker

    -- Tick markers: 6 vertical lines at 0,20,40,60,80,100 (3px wide, 10px tall)
    frame.ticks = {}
    frame.tickOverlays = {}
    for i = 0, 5 do
        local x = i * 40
        local tick = frame:CreateTexture(nil, "OVERLAY", nil, 6)
        tick:SetSize(2, 10)
        tick:SetPoint("CENTER", frame, "LEFT", x, 0)
        tick:SetColorTexture(0, 0, 0, 0.7)
        frame.ticks[i + 1] = tick

        -- Inner (white) tick line, 1px thinner, on top
        local tickInner = frame:CreateTexture(nil, "OVERLAY", nil, 7)
        tickInner:SetSize(1, 10)
        tickInner:SetPoint("CENTER", frame, "LEFT", x, 0)
        tickInner:SetColorTexture(1, 1, 1, 0.6)
        frame.tickOverlays[i + 1] = tickInner
    end

    -- Sparks (circular icon frames)
    frame.sparks = {}
    for i = 1, MAX_SPARKS do
        local sFrame = CreateFrame("Frame", nil, frame)
        sFrame:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
        local s = sFrame:CreateTexture(nil, "OVERLAY", nil, 3)
        s:SetAllPoints()
        local mask = sFrame:CreateMaskTexture()
        mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
        mask:SetAllPoints()
        s:AddMaskTexture(mask)
        s:Hide()
        sFrame:Hide()
        sFrame.icon = s

        -- Additive glow overlay (hidden by default)
        local glow = sFrame:CreateTexture(nil, "OVERLAY", nil, 4)
        glow:SetTexture(GLOW_TEXTURE)
        glow:SetBlendMode("ADD")
        glow:SetPoint("CENTER", sFrame, "CENTER", 0, 0)
        glow:Hide()
        sFrame.glow = glow

        -- Animation group for 0.3s punch (scale + alpha)
        local glowAnim = glow:CreateAnimationGroup()
        -- OnPlay/OnFinished handlers
        glowAnim:SetScript("OnPlay", function()
            glow:Show()
        end)
        glowAnim:SetScript("OnFinished", function()
            glow:Hide()
            glow:SetAlpha(0)
            glow:SetScale(1, 1)
        end)

        -- Order 1: scale up and alpha in (0.15s)
        local scaleUp = glowAnim:CreateAnimation("Scale")
        scaleUp:SetOrder(1)
        scaleUp:SetDuration(GLOW_DURATION * 0.5)
        scaleUp:SetScale(1.15, 1.15)
        scaleUp:SetOrigin("CENTER", 0, 0)

        local alphaIn = glowAnim:CreateAnimation("Alpha")
        alphaIn:SetOrder(1)
        alphaIn:SetDuration(GLOW_DURATION * 0.5)
        alphaIn:SetFromAlpha(0.0)
        alphaIn:SetToAlpha(GLOW_ALPHA_PEAK)

        -- Order 2: scale down and alpha out (0.15s)
        local scaleDown = glowAnim:CreateAnimation("Scale")
        scaleDown:SetOrder(2)
        scaleDown:SetDuration(GLOW_DURATION * 0.5)
        scaleDown:SetScale(1/1.15, 1/1.15)
        scaleDown:SetOrigin("CENTER", 0, 0)

        local alphaOut = glowAnim:CreateAnimation("Alpha")
        alphaOut:SetOrder(2)
        alphaOut:SetDuration(GLOW_DURATION * 0.5)
        alphaOut:SetFromAlpha(GLOW_ALPHA_PEAK)
        alphaOut:SetToAlpha(0.0)

        sFrame.glowAnim = glowAnim
        sFrame.prevTimeUntilCast = nil
        sFrame.didZeroGlow = false

        -- Keybind text above icon (optional, default off)
        local keybindText = sFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        keybindText:SetPoint("BOTTOM", sFrame, "TOP", 0, 2)
        keybindText:SetJustifyH("CENTER")
        keybindText:SetTextColor(1, 1, 0)
        keybindText:SetText("")
        keybindText:Hide()
        sFrame.keybindText = keybindText

        frame.sparks[i] = sFrame
    end

    -- Dragging
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function()
        -- Switch to manual positioning if user drags
        if self.db.char.presetLayout.enabled or autoAnchorEnabled then
            self.db.char.presetLayout.enabled = false
            autoAnchorEnabled = false
            self:UpdateFrameSettings()
        end
        if not self.db.char.bar.locked and not UnitAffectingCombat("player") then
            frame:StartMoving()
            isDragging = true
        end
    end)
    frame:SetScript("OnDragStop", function()
        if isDragging then
            frame:StopMovingOrSizing()
            isDragging = false
            local point, _, _, x, y = frame:GetPoint()
            self.db.char.bar.point = point
            self.db.char.bar.x = x
            self.db.char.bar.y = y
        end
    end)

    -- Make spark frames draggable as well (forward drag to parent)
    local function makeFrameDraggable(childFrame)
        childFrame:EnableMouse(true)
        childFrame:RegisterForDrag("LeftButton")
        childFrame:SetScript("OnDragStart", function()
            if self.db.char.presetLayout.enabled or autoAnchorEnabled then
                self.db.char.presetLayout.enabled = false
                autoAnchorEnabled = false
                self:UpdateFrameSettings()
            end
            if not self.db.char.bar.locked and not UnitAffectingCombat("player") then
                frame:StartMoving()
                isDragging = true
            end
        end)
        childFrame:SetScript("OnDragStop", function()
            if isDragging then
                frame:StopMovingOrSizing()
                isDragging = false
                local point, _, _, x, y = frame:GetPoint()
                self.db.char.bar.point = point
                self.db.char.bar.x = x
                self.db.char.bar.y = y
            end
        end)
    end
    for _, sFrame in ipairs(frame.sparks) do
        makeFrameDraggable(sFrame)
    end

    -- Context menu (Right-click)
    frame.menuFrame = CreateFrame("Frame", "NAGPrePullTimelineMenu", frame, "UIDropDownMenuTemplate")
    frame:SetScript("OnMouseUp", function(_, button)
        if button == "RightButton" then
            local menu = {
                { text = "Edit", notCheckable = true, func = function()
                    local classModule = NAG:GetClassModule()
                    if not classModule then return end
                    local rotation, name = classModule:GetCurrentRotation()
                    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or nil
                    if rotation and ns.RotationEditor and specIndex and name then
                        ns.RotationEditor:ShowEditor(specIndex, { name = name, config = rotation }, classModule, "prepull")
                    end
                end },
                { text = "Close", notCheckable = true, func = function()
                    frame:Hide()
                end },
                { text = "Hide forever", notCheckable = true, func = function()
                    PrePullTimeline.db.char.showBar = false
                    frame:Hide()
                end },
            }
            ns.LibUIDropDownMenu:EasyMenu(menu, frame.menuFrame, "cursor", 0, 0, "MENU", 2)
        end
    end)

    self:UpdateFrameSettings()
end

function PrePullTimeline:UpdateFrameAnchor()
    if not frame or not autoAnchorEnabled then return end
    local nagFrame = NAG:GetDisplayAnchor()
    if not nagFrame or nagFrame == UIParent then
        return
    end
    local nagScale = nagFrame:GetScale() or 1
    local preset = self.db.char.presetLayout
    local offX = preset.x or 0
    local offY = preset.y or 0
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOMLEFT", nagFrame, "TOPRIGHT", offX, offY)
    frame:SetScale(nagScale)
end

function PrePullTimeline:UpdateFrameSettings()
    if not frame then return end
    local usePreset = self.db.char.presetLayout.enabled
    local settings = usePreset and self.db.char.presetLayout or self.db.char.bar

    -- Enforce fixed size: width=200px, height=2px
    frame:SetSize(200, 2)
    if usePreset and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    else
        frame:ClearAllPoints()
        frame:SetPoint(self.db.char.bar.point, self.db.char.bar.x, self.db.char.bar.y)
        local nagFrame = NAG:GetDisplayAnchor()
        if nagFrame and nagFrame ~= UIParent then
            frame:SetScale(nagFrame:GetScale() or 1)
        end
    end
    frame:SetAlpha(settings.alpha)

    local colors = settings.colors
    -- Fixed visual style: gray background, black/gray bar with 70% visibility
    frame.bg:SetColorTexture(0.2, 0.2, 0.2, 0.7)
    frame.timeline:SetColorTexture(0.0, 0.0, 0.0, 0.7)
    frame.timeline:SetSize(200, 3)
    if frame.timelineInner then
        frame.timelineInner:ClearAllPoints()
        frame.timelineInner:SetPoint("CENTER", frame.timeline, "CENTER")
        frame.timelineInner:SetSize(200, 1)
        frame.timelineInner:SetColorTexture(1, 1, 1, 0.6)
    end
    frame.now:SetColorTexture(0, 0, 0, 0.7)
    if frame.nowInner then
        frame.nowInner:ClearAllPoints()
        frame.nowInner:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
        frame.nowInner:SetWidth(1)
        frame.nowInner:SetColorTexture(1, 1, 1, 0.6)
    end
    if frame.bgArt then
        frame.bgArt:SetTexture(BG_ART_TEXTURE)
        frame.bgArt:SetSize(BG_ART_WIDTH, BG_ART_HEIGHT)
        frame.bgArt:SetAlpha(BG_ART_ALPHA)
        frame.bgArt:ClearAllPoints()
        frame.bgArt:SetPoint("CENTER", frame, "CENTER", BG_ART_X_OFFSET, BG_ART_Y_OFFSET)
    end
    if frame.bgHitbox then
        frame.bgHitbox:ClearAllPoints()
        frame.bgHitbox:SetPoint("CENTER", frame, "CENTER", BG_ART_X_OFFSET, BG_ART_Y_OFFSET)
        frame.bgHitbox:SetSize(BG_ART_WIDTH, BG_ART_HEIGHT)
    end

    local iconSize = max(8, (settings.iconSize or DEFAULT_ICON_SIZE))
    iconSize = math.floor(iconSize * 2.0) -- slightly more zoomed in for moving icons
    for _, sFrame in ipairs(frame.sparks) do
        sFrame:SetSize(iconSize, iconSize)
    end
end

function PrePullTimeline:UpdateVisibility()
    if not frame then return end
    if not self.db.char.showBar then
        frame:Hide()
        return
    end
    -- Show when a pull timer is active (via PullTimerManager) OR when this module has an active preview/state
    local pullActive = PullTimerManager.IsPullTimer and PullTimerManager:IsPullTimer()
    local localActive = self.state and self.state.active == true
    if not (pullActive or localActive) then
        frame:Hide()
        return
    end
    -- If we have nothing to display (rotation has no pre-pull entries), don't show the timeline.
    local actions = self:GetResolvedPrePullActions()
    if not actions or #actions == 0 then
        frame:Hide()
        return
    end
    frame:Show()
end

-- ============================ HELPERS ============================
local function normalize_time_seconds(t)
    if type(t) ~= "number" then return nil end
    if abs(t) > 1000 then return t / 1000 end
    return t
end

local function parse_action_id(actionString)
    if type(actionString) ~= "string" then return nil end
    local id = tonumber(string.match(actionString, "%((%d+)%)"))
    return id
end

-- Resolve current rotation pre-pull actions (prefer PullTimerManager when available)
function PrePullTimeline:GetResolvedPrePullActions()
    if PullTimerManager.GetCurrentPrePullSettings then
        local settings = PullTimerManager:GetCurrentPrePullSettings()
        if settings and type(settings) == "table" then
            local list = {}
            for _, entry in ipairs(settings) do
                local time = entry.time or (entry[2])
                if type(time) == "number" then
                    local id = entry.spellId
                    local isPotion = false
                    if not id and entry.action then
                        if entry.action:find("NAG:GetBattlePotion", 1, true) then
                            isPotion = true
                            id = POTION_ITEM_ID
                        else
                            id = parse_action_id(entry.action)
                        end
                    end
                    if not id then
                        local a = entry[1]
                        if a == "defaultBattlePotion" then
                            isPotion = true
                            id = POTION_ITEM_ID
                        end
                    end
                    -- Dynamic check: if parsed id equals player's selected battle potion, treat as potion
                    if not isPotion and id and NAG and NAG.GetBattlePotion then
                        local selected = NAG:GetBattlePotion() or 0
                        if id == selected then
                            isPotion = true
                        end
                    end
                    if type(id) == "number" then
                        -- Check blacklist (skip if blacklisted, unless it's a potion)
                        if not isPotion and NAG.IsSpellBlacklisted and NAG:IsSpellBlacklisted(id) then
                            -- Skip blacklisted spells
                        else
                            if isPotion then
                                tinsert(list, { id, time, true })
                            else
                                tinsert(list, { id, time })
                            end
                        end
                    end
                end
            end
            if #list > 0 then return list end
        end
    end

    -- Fallback to rotation (and class default if rotation has no prePull)
    local classModule = NAG:GetClassModule()
    local rotation = classModule and select(1, classModule:GetCurrentRotation()) or nil
    if not rotation then return nil end
    local source = rotation.prePull or rotation.prepull or rotation.prepull_entries or rotation.prePullEntries
    if (not source or type(source) ~= "table" or #source == 0) and classModule.defaults and classModule.defaults.class and classModule.defaults.class.rotations then
        local specIndex = SpecCompat and SpecCompat.GetCurrentSpecIndex and SpecCompat:GetCurrentSpecIndex()
        local rotName = rotation.name or (select(2, classModule:GetCurrentRotation()))
        if specIndex and rotName then
            local specRots = classModule.defaults.class.rotations[specIndex]
            local defaultRot = specRots and specRots[rotName]
            if defaultRot and defaultRot.prePull and type(defaultRot.prePull) == "table" and #defaultRot.prePull > 0 then
                source = defaultRot.prePull
            end
        end
    end
    if not source or type(source) ~= "table" or #source == 0 then return nil end

    local resolved = {}
    for _, entry in ipairs(source) do
        local t = entry.time or entry[2]
        local a = entry[1]
        if type(t) == "number" then
            local id = entry.spellId
            local isPotion = false
            if not id and entry.action then
                if entry.action:find("NAG:GetBattlePotion", 1, true) then
                    isPotion = true
                    id = POTION_ITEM_ID
                else
                    id = parse_action_id(entry.action)
                end
            end
            if not id then
                if a == "defaultBattlePotion" then
                    isPotion = true
                    id = POTION_ITEM_ID
                elseif type(a) == "number" then
                    id = a
                    if NAG and NAG.GetBattlePotion then
                        local selected = NAG:GetBattlePotion() or 0
                        if a == selected then isPotion = true end
                    end
                end
            end
            if type(id) == "number" then
                if not isPotion and NAG.IsSpellBlacklisted and NAG:IsSpellBlacklisted(id) then
                    -- skip
                else
                    tinsert(resolved, isPotion and { id, t, true } or { id, t })
                end
            end
        end
    end
    return resolved
end

local function SetSparkKeybind(sFrame, showKeybind)
    if not sFrame or not sFrame.keybindText then return end
    if showKeybind and sFrame.spellId then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind then
            kb = KeybindManager:GetSpellKeybind(sFrame.spellId) or ""
        end
        sFrame.keybindText:SetText(kb)
        if kb and kb ~= "" then
            sFrame.keybindText:Show()
        else
            sFrame.keybindText:Hide()
        end
    else
        sFrame.keybindText:SetText("")
        sFrame.keybindText:Hide()
    end
end

function PrePullTimeline:ClearSparks()
    if not frame or not frame.sparks then return end
    for _, sFrame in ipairs(frame.sparks) do
        SetSparkKeybind(sFrame, false)
        sFrame.spellId = nil
        sFrame:Hide()
        if sFrame.icon then sFrame.icon:Hide() end
        if sFrame.glow then sFrame.glow:Hide(); sFrame.glow:SetAlpha(0) end
        if sFrame.glowAnim and sFrame.glowAnim:IsPlaying() then sFrame.glowAnim:Stop() end
        sFrame.currentX = nil
        sFrame.prevTimeUntilCast = nil
        sFrame.didZeroGlow = false
    end
end

-- ============================ RENDERING ============================
function PrePullTimeline:UpdateDisplay()
    if not frame or isDragging or not self.db.char.showBar then return end

    local pullActive = PullTimerManager:IsPullTimer()
    if not self.state.active and not pullActive then
        self:ClearSparks()
        self:UpdateVisibility()
        return
    end

    local usePreset = self.db.char.presetLayout.enabled
    local settings = usePreset and self.db.char.presetLayout or self.db.char.bar
    local width = 200 -- fixed width mapping (200px = 10 seconds window)
    local windowSeconds = 10
    local windowOffset = -2 -- shift window +2s to the right: visible range is [+2 .. -8]
    local smoothing = 0.3

    local usePTM = false
    local timeToZero = nil
    if pullActive and PullTimerManager.GetTimeToZero then
        timeToZero = PullTimerManager:GetTimeToZero()
        if type(timeToZero) == "number" then usePTM = true end
    end

    local now = GetTime()
    local pullDuration = (type(self.state.pullDuration) == "number" and self.state.pullDuration) or 10
    local elapsed = 0
    if type(self.state.pullStartTime) == "number" then
        elapsed = max(0, now - self.state.pullStartTime)
        if elapsed > pullDuration then elapsed = pullDuration end
    end

    local actions = self:GetResolvedPrePullActions()
    if not actions or #actions == 0 then
        self:ClearSparks()
        local s = math.floor(usePTM and abs(timeToZero or 0) or elapsed)
        if self.state._lastDebugSecond ~= s then
            self.state._lastDebugSecond = s
        end
        -- Hide moving pull marker
        if frame.pullMarker then frame.pullMarker:Hide() end
        return
    end

    -- Re-apply visibility every tick when we have actions (ensures bar shows even if event handler missed or ran early)
    self:UpdateVisibility()

    table.sort(actions, function(a, b)
        local ta = normalize_time_seconds(a[2]); local tb = normalize_time_seconds(b[2])
        return abs(ta) > abs(tb)
    end)

    local sparkIndex = 0
    local secondsPerPixel = width / windowSeconds -- 20 px per second
    -- Fixed window mapping of 10 seconds across 200px (shifted by +2s)

    for i = 1, min(#actions, MAX_SPARKS) do
        local entry = actions[i]
        local id = entry[1]
        local t = normalize_time_seconds(entry[2])
        if type(id) == "number" and t then
            if t > 0 then t = -t end
            local absT = abs(t)
            local currentAbs
            if usePTM then
                currentAbs = abs(timeToZero)
            else
                currentAbs = max(0, (pullDuration or 0) - elapsed)
            end
            -- Time until we reach the scheduled moment from current countdown value (can be negative)
            local timeUntilCast = (currentAbs - absT)
            -- Direct mapping: arrow (0s) at x=40, 20px per second to the right, clamp to [0, 200]
            local targetX = 40 + (secondsPerPixel * timeUntilCast)
            if targetX < 0 then targetX = 0 elseif targetX > width then targetX = width end

            sparkIndex = sparkIndex + 1
            local sFrame = frame.sparks[sparkIndex]
            if sFrame then
                local icon
                local entryIsPotion = (entry[3] == true)
                if entryIsPotion then
                    if NAG.Item and NAG.Item[POTION_ITEM_ID] and NAG.Item[POTION_ITEM_ID].icon then
                        icon = NAG.Item[POTION_ITEM_ID].icon
                    else
                        icon = GetItemIcon(POTION_ITEM_ID)
                    end
                else
                    -- Spells first, then items (exception already handled for potions)
                    if NAG.Spell and NAG.Spell[id] and NAG.Spell[id].icon then
                        icon = NAG.Spell[id].icon
                    elseif NAG.Item and NAG.Item[id] and NAG.Item[id].icon then
                        icon = NAG.Item[id].icon
                    else
                        icon = GetSpellTexture(id) or GetItemIcon(id)
                    end
                end
                icon = icon or "Interface\\Icons\\INV_Misc_QuestionMark"
                sFrame.spellId = id
                SetSparkKeybind(sFrame, self.db.char.showKeybindOnBar)
                sFrame.icon:SetTexture(icon)
                sFrame.icon:Show()

                -- Visual tweak for left-of-zero: desaturate (simulated) and shrink 50%
                local baseIconSize = max(8, (settings.iconSize or DEFAULT_ICON_SIZE))
                local fullSize = math.floor(baseIconSize * 1.8)
                if timeUntilCast < 0 then
                    sFrame.icon:SetVertexColor(0.6, 0.6, 0.6, 1.0)
                    sFrame:SetSize(math.floor(fullSize * 0.75), math.floor(fullSize * 0.75))
                else
                    sFrame.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0)
                    sFrame:SetSize(fullSize, fullSize)
                end

                -- Zero-cross glow trigger (play once when crossing from >=0 to <0)
                if sFrame.prevTimeUntilCast ~= nil then
                    if sFrame.prevTimeUntilCast >= 0 and timeUntilCast < 0 and not sFrame.didZeroGlow then
                        -- Size glow relative to current icon size
                        local gSize = math.floor((sFrame:GetWidth() or fullSize) * GLOW_SIZE_MULT)
                        sFrame.glow:SetSize(gSize, gSize)
                        sFrame.glowAnim:Play()
                        sFrame.didZeroGlow = true
                    elseif timeUntilCast >= 0 then
                        -- Reset so it can trigger again if it re-enters >=0
                        sFrame.didZeroGlow = false
                    end
                end
                sFrame.prevTimeUntilCast = timeUntilCast

                if not sFrame.currentX or math.abs(sFrame.currentX - targetX) > width then
                    sFrame.currentX = targetX
                else
                    sFrame.currentX = sFrame.currentX + (targetX - sFrame.currentX) * smoothing
                end

                sFrame:ClearAllPoints()
                sFrame:SetPoint("CENTER", frame, "LEFT", sFrame.currentX, 0)
                -- Only show when within -2..8s window (full bar range)
                if timeUntilCast >= -2 and timeUntilCast <= 8 then
                    sFrame:Show()
                else
                    SetSparkKeybind(sFrame, false)
                    sFrame:Hide()
                end
            end
        end
    end

    for j = sparkIndex + 1, #frame.sparks do
        local sFrame = frame.sparks[j]
        SetSparkKeybind(sFrame, false)
        sFrame:Hide()
        if sFrame.icon then sFrame.icon:Hide(); sFrame.icon:SetAlpha(1.0) end
        sFrame.currentX = nil
    end

    local s = math.floor(usePTM and abs(timeToZero or 0) or elapsed)
    if self.state._lastDebugSecond ~= s or self.state._lastActionCount ~= #actions then
        self.state._lastDebugSecond = s
        self.state._lastActionCount = #actions
    end

    -- Update moving pull marker to meet zero at arrow
    if frame.pullMarker then
        local curAbs = usePTM and abs(timeToZero or 0) or max(0, (pullDuration or 0) - elapsed)
        local targetX = 40 + (secondsPerPixel * curAbs)
        if targetX < 0 then targetX = 0 elseif targetX > width then targetX = width end

        -- Smooth X toward target (same smoothing factor as sparks)
        if not frame.pullMarker.currentX or math.abs(frame.pullMarker.currentX - targetX) > width then
            frame.pullMarker.currentX = targetX
        else
            frame.pullMarker.currentX = frame.pullMarker.currentX + (targetX - frame.pullMarker.currentX) * smoothing
        end

        frame.pullMarker:ClearAllPoints()
        frame.pullMarker:SetPoint("CENTER", frame, "LEFT", frame.pullMarker.currentX, PULL_MARKER_Y_OFFSET)

        -- Only show when within 0..8s window to the right
        if curAbs <= 8 then
            frame.pullMarker:Show()
        else
            frame.pullMarker:Hide()
        end
        frame.pullMarker.text:SetFormattedText("%d", math.floor(curAbs + 0.5))
    end

    if usePTM and (timeToZero == nil or timeToZero >= 0) then
        self.state.active = false
        self.state.pullStartTime = nil
        self.state.pullDuration = nil
        self:ClearSparks()
        if frame.pullMarker then frame.pullMarker:Hide() end
        self:UpdateVisibility()
    elseif not usePTM and elapsed >= pullDuration then
        self.state.active = false
        self.state.pullStartTime = nil
        self.state.pullDuration = nil
        self:ClearSparks()
        if frame.pullMarker then frame.pullMarker:Hide() end
        self:UpdateVisibility()
    end
end

-- ============================ OPTIONS ============================
function PrePullTimeline:GetOptions()
    return {
        type = "group",
        name = L["Pre-Pull Timeline"] or "Pre-Pull Timeline",
        order = 35,
        args = {
            showBar = OptionsFactory:CreateToggle(
                L["Show Bar"] or "Show Bar",
                L["Toggle the visibility of the pre-pull timeline bar"] or "Toggle the visibility of the pre-pull timeline bar",
                function() return self.db.char.showBar end,
                function(_, value) self.db.char.showBar = value; self:UpdateVisibility() end,
                { width = "full", order = 0 }
            ),
            showKeybindOnBar = OptionsFactory:CreateToggle(
                L["Show Keybind Above Bar Icons"] or "Show Keybind Above Bar Icons",
                L["Display the keybind above the icons on the pull timer bar"] or "Display the keybind above the icons on the pull timer bar",
                function() return self.db.char.showKeybindOnBar end,
                function(_, value)
                    self.db.char.showKeybindOnBar = value
                    if frame then self:UpdateDisplay() end
                end,
                { width = "full", order = 2 }
            ),
            scale = OptionsFactory:CreateRange(
                L["Scale"] or "Scale",
                L["Scale"] or "Scale",
                function() return (NAG:GetDisplayAnchor() and (NAG:GetDisplayAnchor():GetScale() or 1)) or 1 end,
                function(_, v)
                    local nagFrame = NAG:GetDisplayAnchor()
                    if nagFrame then
                        frame:SetScale(v)
                    end
                end,
                { min = 0.5, max = 2.0, step = 0.05, order = 3 }
            ),
        }
    }
end


