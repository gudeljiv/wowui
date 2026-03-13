--- @module "NAG.HunterWeaveBar"
--- Hunter weave window visualization for TBC BM, modeled after the MoP Shaman weave bar.
---
--- Shows:
--- - (No swing timer bar; weave gaps are the primary timing visual)
--- - Cast time bar (separate lane below weave bars, shows current spell cast time)
--- - Latency-aware Steady/Multi windows
--- - Upcoming windows (next cycle)
--- - Dedicated melee weave window
---
--- Explicitly does NOT include:
--- - background texture styles
--- - cooldown spark row
--- - GCD overlay (replaced by cast time bar)
---
--- License: CC BY-NC 4.0

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitClassBase = _G.UnitClassBase
local UnitLevel = _G.UnitLevel
local CreateFrame = _G.CreateFrame
local UnitCastingInfo = _G.UnitCastingInfo
local EasyMenu = _G.EasyMenu
local CloseDropDownMenus = _G.CloseDropDownMenus
local ToggleDropDownMenu = _G.ToggleDropDownMenu
local UIDropDownMenu_Initialize = _G.UIDropDownMenu_Initialize
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local WoWAPI = ns.WoWAPI
local Version = ns.Version
local AceConfigRegistry = ns.AceConfigRegistry

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
--- @type OptionsFactory
local OptionsFactory
--- @type SpecCompat
local SpecCompat

local L = LibStub("AceLocale-3.0"):GetLocale("NAG")

-- Spell IDs (TBC)
local STEADY_SHOT_ID = 34120 -- Steady Shot
local MULTI_SHOT_ID = 2643  -- Multi-Shot (Rank 1)
local RAPTOR_STRIKE_ID = 2973 -- Raptor Strike (Rank 1)

-- Default settings (two layout modes: manual bar vs presetLayout; no background and no CD row)
local defaults = {
    class = {
        enabled = true,
        showBar = true,
        hideOutOfCombat = false,
        actionTimeline = {
            enabled = false,
            windowGcds = 2,
            showLockout = true,
            showNowLine = true,
            showSecondary = true,
            showKeybindOnTimeline = false,
            lockoutColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.35 },
            nowLineColor = { r = 0.95, g = 0.95, b = 0.95, a = 0.9 },
        },
        steadyGapBar = {
            enabled = false,
            width = 220,
            height = 8,
            alpha = 1.0,
            point = "CENTER",
            x = 0,
            y = -160,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            colors = {
                background = { r = 0, g = 0, b = 0, a = 0.35 },
                gap1 = { r = 0.35, g = 0.75, b = 1.00, a = 0.85 },
                gap2 = { r = 0.35, g = 0.75, b = 1.00, a = 0.45 },
                now = { r = 0.95, g = 0.95, b = 0.95, a = 0.9 },
            },
        },

        -- Manual/Classic layout
        bar = {
            width = 240,
            height = 22,
            alpha = 1,
            point = "CENTER",
            x = 0,
            y = -120,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            showSparkIcons = true, -- icon sparks vs line sparks
            showKeybindOnWeaveBar = false,

            -- Individual bar heights (percentage of total height)
            steadyBarHeightPct = 0.18,
            multiBarHeightPct = 0.18,
            meleeBarHeightPct = 0.18,

            -- Cast bar settings
            castBarHeight = 2,
            castBarGap = 6,

            -- Bar colors
            colors = {
                background = { r = 0, g = 0, b = 0, a = 0.35 },
                steady = { r = 0.35, g = 0.75, b = 1.00, a = 0.85 },
                multi = { r = 0.20, g = 0.45, b = 0.95, a = 0.85 },
                melee = { r = 0.25, g = 0.90, b = 0.45, a = 0.85 },
                upcomingSteady = { r = 0.35, g = 0.75, b = 1.00, a = 0.35 },
                upcomingMulti = { r = 0.20, g = 0.45, b = 0.95, a = 0.35 },
                upcomingMelee = { r = 0.25, g = 0.90, b = 0.45, a = 0.35 },
                gcd = { r = 0.30, g = 0.30, b = 0.30, a = 0.85 },
                castBar = { r = 0.40, g = 0.40, b = 0.40, a = 0.95 },
                castSpark = { r = 0.9, g = 0.9, b = 0.9, a = 0.9 },
                spark = { r = 0.85, g = 0.85, b = 0.85, a = 1.0 },
            },

        },

        -- Preset layout settings (rich config, but without backgrounds and without CD row)
        presetLayout = {
            enabled = true,
            width = 240,
            height = 22,
            alpha = 1.0,
            point = "CENTER",
            x = 0,
            y = -120,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            showSparkIcons = true,
            showKeybindOnWeaveBar = false,

            steadyBarHeightPct = 0.18,
            multiBarHeightPct = 0.18,
            meleeBarHeightPct = 0.18,

            -- Cast bar settings
            castBarHeight = 2,
            castBarGap = 6,

            colors = {
                background = { r = 0, g = 0, b = 0, a = 0.35 },
                steady = { r = 0.35, g = 0.75, b = 1.00, a = 0.85 },
                multi = { r = 0.20, g = 0.45, b = 0.95, a = 0.85 },
                melee = { r = 0.25, g = 0.90, b = 0.45, a = 0.85 },
                upcomingSteady = { r = 0.35, g = 0.75, b = 1.00, a = 0.35 },
                upcomingMulti = { r = 0.20, g = 0.45, b = 0.95, a = 0.35 },
                upcomingMelee = { r = 0.25, g = 0.90, b = 0.45, a = 0.35 },
                gcd = { r = 0.30, g = 0.30, b = 0.30, a = 0.85 },
                castBar = { r = 0.40, g = 0.40, b = 0.40, a = 0.95 },
                castSpark = { r = 0.9, g = 0.9, b = 0.9, a = 0.9 },
                spark = { r = 0.85, g = 0.85, b = 0.85, a = 1.0 },
            },

        },

        debug = false,
    }
}

--- @class HunterWeaveBar:CoreModule
local HunterWeaveBar = NAG:CreateModule("HunterWeaveBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function() return UnitClassBase("player") ~= "HUNTER" end,
    messageHandlers = {
        NAG_SPEC_UPDATED = true,
        NAG_FRAME_UPDATED = true,
        NAG_HUNTER_BAR_SCALE_UPDATED = true,
    },
    eventHandlers = {
        UNIT_SPELLCAST_START = true,
        UNIT_SPELLCAST_STOP = true,
        UNIT_SPELLCAST_INTERRUPTED = true,
    },
})

-- Local state
local frame
local steadyGapFrame
local isDragging = false
local isPositioning = false
local lastUpdate = 0
local UPDATE_INTERVAL = 0.016 -- ~60fps
local autoAnchorEnabled = true
local lastQueuedPressAt = nil
local lastQueuedSpellId = nil

-- Cast time tracking
local currentCastSpellId = nil
local currentCastEndTime = nil
local currentCastTotalTime = nil

local function HideSparkFrame(sparkFrame)
    if not sparkFrame then return end
    if sparkFrame.icon then sparkFrame.icon:Hide() end
    if sparkFrame.line then sparkFrame.line:Hide() end
    if sparkFrame.keybindText then
        sparkFrame.keybindText:SetText("")
        sparkFrame.keybindText:Hide()
    end
    if sparkFrame.currentX then sparkFrame.currentX = nil end
    sparkFrame:Hide()
end

local function HideAllSparkFrames()
    if not frame then return end
    HideSparkFrame(frame.steadySpark)
    HideSparkFrame(frame.multiSpark)
    HideSparkFrame(frame.meleeSpark)
    HideSparkFrame(frame.upcomingSteadySpark)
    HideSparkFrame(frame.upcomingMultiSpark)
    HideSparkFrame(frame.upcomingMeleeSpark)
end

local function CreateSparkFrame(parent, spellId)
    local sparkFrame = CreateFrame("Frame", nil, parent)
    sparkFrame:SetSize(16, 16)
    sparkFrame.defaultWidth = 16
    sparkFrame.defaultHeight = 16
    sparkFrame.spellId = spellId

    local iconTexture = "Interface\\Icons\\INV_Misc_QuestionMark"
    if NAG.Spell and NAG.Spell[spellId] and NAG.Spell[spellId].icon then
        iconTexture = NAG.Spell[spellId].icon
    else
        local tex = (C_Spell and C_Spell.GetSpellTexture and C_Spell.GetSpellTexture(spellId)) or _G.GetSpellTexture and _G.GetSpellTexture(spellId)
        if tex then iconTexture = tex end
    end

    local icon = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    icon:SetAllPoints()
    icon:SetTexture(iconTexture)
    icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)

    local mask = sparkFrame:CreateMaskTexture()
    mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetAllPoints()
    icon:AddMaskTexture(mask)

    sparkFrame.icon = icon
    sparkFrame.iconMask = mask

    local line = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    line:SetColorTexture(1, 1, 1, 1)
    line:Hide()
    sparkFrame.line = line

    -- Keybind text above icon (for action timeline; shown when showKeybindOnTimeline is enabled)
    local keybindText = sparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    keybindText:SetPoint("BOTTOM", sparkFrame, "TOP", 0, 2)
    keybindText:SetJustifyH("CENTER")
    keybindText:SetTextColor(1, 1, 0)
    keybindText:SetText("")
    keybindText:Hide()
    sparkFrame.keybindText = keybindText

    sparkFrame:Hide()
    return sparkFrame
end

local function PositionBarSpark(bar, sparkFrame, sparkIconsEnabled, alignTop, alignBottom)
    if not bar or not sparkFrame then return end

    local barHeight = bar:GetHeight() or 0
    if sparkFrame.icon and sparkFrame.line then
        if sparkIconsEnabled then
            sparkFrame:SetSize(sparkFrame.defaultWidth or 16, sparkFrame.defaultHeight or 16)
            sparkFrame.icon:Show()
            sparkFrame.line:Hide()
        else
            sparkFrame:SetWidth(2)
            sparkFrame:SetHeight(barHeight)
            sparkFrame.icon:Hide()
            sparkFrame.line:SetAllPoints()
            sparkFrame.line:Show()
        end
    end

    local sparkHeight = sparkFrame:GetHeight() or 16
    local yOff = 0
    if alignTop then
        yOff = (barHeight / 2) - (sparkHeight / 2)
    elseif alignBottom then
        yOff = -((barHeight / 2) - (sparkHeight / 2))
    end

    sparkFrame:ClearAllPoints()
    sparkFrame:SetPoint("CENTER", bar, "RIGHT", 0, yOff)
    sparkFrame:Show()
end

local function IsHunterBM()
    if UnitClassBase("player") ~= "HUNTER" then return false end
    if not Version:IsTBC() then return false end
    if (UnitLevel("player") or 0) < 10 then return false end
    if not SpecCompat then return false end
    local specStatus = SpecCompat:GetSpecializationStatus()
    return specStatus and specStatus.available and specStatus.specIndex == 1
end

--- Effective scale for hunter bar frames: NAG display scale * universal hunter bar scale.
local function GetHunterBarEffectiveScale()
    local nagFrame = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local nagScale = (nagFrame and nagFrame ~= UIParent and nagFrame:GetScale()) or 1
    local hm = NAG:GetModule("HunterWeaveModule", true)
    local barScale = (hm and hm.GetHunterBarScale and hm:GetHunterBarScale()) or 1
    return nagScale * barScale
end

function HunterWeaveBar:UpdateFrameAnchor()
    if not frame or not autoAnchorEnabled then return end

    local nagFrame = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    if not nagFrame or nagFrame == UIParent then
        return
    end

    local nagScale = nagFrame:GetScale() or 1
    local preset = self.db.class.presetLayout
    local userX = preset.x or 0
    local userY = preset.y or 0

    -- Hunter bar default: sit just to the right of the NAG primary display.
    -- Keep frame on UIParent so adding it as a child doesn't affect the main frame (e.g. floating selector position).
    local offsetX = 0
    local offsetY = 8

    frame:SetParent(UIParent)
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOMLEFT", nagFrame, "BOTTOMRIGHT", offsetX + userX, offsetY + userY)
    frame:SetScale(GetHunterBarEffectiveScale())
end

function HunterWeaveBar:UpdateVisibility()
    if not frame then return end

    -- In edit mode: force visible, raise strata/level above NAG display frames
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:Show()
        frame:EnableMouse(true)
        if steadyGapFrame and self.db.class.steadyGapBar.enabled then
            steadyGapFrame:SetFrameStrata("DIALOG")
            steadyGapFrame:SetFrameLevel(201)
            steadyGapFrame:Show()
            steadyGapFrame:EnableMouse(true)
        elseif steadyGapFrame then
            steadyGapFrame:Hide()
        end
        return
    end

    local showPrimary = self.db.class.showBar or (self.db.class.actionTimeline and self.db.class.actionTimeline.enabled)
    if not showPrimary then
        frame:Hide()
    elseif self.db.class.hideOutOfCombat and not UnitAffectingCombat("player") and not isPositioning then
        frame:Hide()
    elseif not IsHunterBM() and not isPositioning then
        frame:Hide()
    else
        local dm = NAG:GetModule("DisplayManager", true)
        local level = dm and dm.GetRecommendedClassBarFrameLevel and dm:GetRecommendedClassBarFrameLevel() or 50
        frame:SetFrameStrata("MEDIUM")
        frame:SetFrameLevel(level)
        frame:Show()
        frame:EnableMouse(false)
    end

    if steadyGapFrame then
        if not self.db.class.steadyGapBar.enabled then
            steadyGapFrame:Hide()
        elseif self.db.class.hideOutOfCombat and not UnitAffectingCombat("player") and not isPositioning then
            steadyGapFrame:Hide()
        elseif not IsHunterBM() and not isPositioning then
            steadyGapFrame:Hide()
        else
            local dm = NAG:GetModule("DisplayManager", true)
            local level = dm and dm.GetRecommendedClassBarFrameLevel and dm:GetRecommendedClassBarFrameLevel() or 50
            steadyGapFrame:SetFrameStrata("MEDIUM")
            steadyGapFrame:SetFrameLevel(level)
            steadyGapFrame:Show()
            steadyGapFrame:EnableMouse(false)
        end
    end
end

function HunterWeaveBar:StartPositioning()
    if not frame then return end
    isPositioning = true
    frame:EnableMouse(true)
    frame.closeButton:Show()
    self:UpdateVisibility()
end

function HunterWeaveBar:StopPositioning()
    if not frame then return end
    isPositioning = false
    frame.closeButton:Hide()
    self:UpdateVisibility()
end

function HunterWeaveBar:NAG_FRAME_UPDATED()
    self:UpdateVisibility()
end

function HunterWeaveBar:NAG_HUNTER_BAR_SCALE_UPDATED()
    self:UpdateFrameSettings()
    self:UpdateSteadyGapFrameSettings()
end

function HunterWeaveBar:UpdateBarMouseState()
    local canDragMain = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
    if frame then
        frame:EnableMouse(canDragMain)
    end
    if steadyGapFrame then
        steadyGapFrame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
    end
end

function HunterWeaveBar:UpdateFrameSettings()
    if not frame then return end

    local usePresetLayout = self.db.class.presetLayout.enabled
    local settings = usePresetLayout and self.db.class.presetLayout or self.db.class.bar

    -- Frame size will be calculated in UpdateDisplay to account for cast bar
    -- We just store the base width/height here

    if usePresetLayout and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    else
        frame:SetParent(UIParent)
        frame:ClearAllPoints()
        frame:SetPoint(settings.point, settings.x, settings.y)

        -- Apply NAG scale and universal hunter bar scale even in manual mode.
        frame:SetScale(GetHunterBarEffectiveScale())
    end
    frame:SetAlpha(settings.alpha)
    self:UpdateBarMouseState()

    -- Background
    if frame.bgTexture and settings.colors and settings.colors.background then
        local c = settings.colors.background
        frame.bgTexture:SetColorTexture(c.r, c.g, c.b, c.a)
    end

    -- Border
    if settings.showBorder then
        frame.border:Show()
        local bc = settings.borderColor or { r = 1, g = 1, b = 1, a = 1 }
        frame.border:SetBackdropBorderColor(bc.r, bc.g, bc.b, bc.a)
        frame.border:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = settings.borderThickness or 1,
        })
    else
        frame.border:Hide()
    end

    -- Spark icon toggle
    frame.sparkIconsEnabled = settings.showSparkIcons and true or false

    -- Colors for bars
    if settings.colors then
        local colors = settings.colors

        -- Cast / GCD bar colors
        if frame.castBar and colors.castBar then
            frame.castBar:SetColorTexture(colors.castBar.r, colors.castBar.g, colors.castBar.b, colors.castBar.a)
        end
        if frame.castSpark and colors.castSpark then
            frame.castSpark:SetColorTexture(colors.castSpark.r, colors.castSpark.g, colors.castSpark.b, colors.castSpark.a)
        end
        if frame.castSparkLeft and colors.castSpark then
            frame.castSparkLeft:SetColorTexture(colors.castSpark.r, colors.castSpark.g, colors.castSpark.b, colors.castSpark.a)
        end
        if frame.gcdBar and colors.gcd then
            frame.gcdBar:SetColorTexture(colors.gcd.r, colors.gcd.g, colors.gcd.b, colors.gcd.a)
        end
        if frame.gcdSpark and colors.spark then
            frame.gcdSpark:SetColorTexture(colors.spark.r, colors.spark.g, colors.spark.b, colors.spark.a)
        end
        if frame.gcdSparkLeft and colors.spark then
            frame.gcdSparkLeft:SetColorTexture(colors.spark.r, colors.spark.g, colors.spark.b, colors.spark.a)
        end

        frame.steadyBar:SetColorTexture(colors.steady.r, colors.steady.g, colors.steady.b, colors.steady.a)
        frame.multiBar:SetColorTexture(colors.multi.r, colors.multi.g, colors.multi.b, colors.multi.a)
        frame.meleeBar:SetColorTexture(colors.melee.r, colors.melee.g, colors.melee.b, colors.melee.a)

        frame.upcomingSteadyBar:SetColorTexture(colors.upcomingSteady.r, colors.upcomingSteady.g, colors.upcomingSteady.b,
            colors.upcomingSteady.a)
        frame.upcomingMultiBar:SetColorTexture(colors.upcomingMulti.r, colors.upcomingMulti.g, colors.upcomingMulti.b,
            colors.upcomingMulti.a)
        frame.upcomingMeleeBar:SetColorTexture(colors.upcomingMelee.r, colors.upcomingMelee.g, colors.upcomingMelee.b,
            colors.upcomingMelee.a)

        -- Auto Shot tick marker
        if frame.autoTick and colors.spark then
            frame.autoTick:SetColorTexture(colors.spark.r, colors.spark.g, colors.spark.b, colors.spark.a)
        end
    end

    -- Action timeline colors (independent of layout)
    local timelineSettings = self.db.class.actionTimeline
    if timelineSettings then
        if frame.nowLine and timelineSettings.nowLineColor then
            local c = timelineSettings.nowLineColor
            frame.nowLine:SetColorTexture(c.r, c.g, c.b, c.a)
        end
        if frame.lockoutBar and timelineSettings.lockoutColor then
            local c = timelineSettings.lockoutColor
            frame.lockoutBar:SetColorTexture(c.r, c.g, c.b, c.a)
        end
    end
end

function HunterWeaveBar:UpdateSteadyGapFrameSettings()
    if not steadyGapFrame then return end
    local db = self.db.class.steadyGapBar

    steadyGapFrame:SetSize(db.width, db.height)
    steadyGapFrame:SetPoint(db.point, db.x, db.y)
    steadyGapFrame:SetAlpha(db.alpha or 1.0)
    steadyGapFrame:SetScale(GetHunterBarEffectiveScale())

    if steadyGapFrame.bgTexture and db.colors and db.colors.background then
        local c = db.colors.background
        steadyGapFrame.bgTexture:SetColorTexture(c.r, c.g, c.b, c.a)
    end

    if db.showBorder then
        steadyGapFrame.border:Show()
        local bc = db.borderColor or { r = 1, g = 1, b = 1, a = 1 }
        steadyGapFrame.border:SetBackdropBorderColor(bc.r, bc.g, bc.b, bc.a)
        steadyGapFrame.border:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = db.borderThickness or 1,
        })
    else
        steadyGapFrame.border:Hide()
    end

    if steadyGapFrame.gap1 and db.colors and db.colors.gap1 then
        local c = db.colors.gap1
        steadyGapFrame.gap1:SetColorTexture(c.r, c.g, c.b, c.a)
    end
    if steadyGapFrame.gap2 and db.colors and db.colors.gap2 then
        local c = db.colors.gap2
        steadyGapFrame.gap2:SetColorTexture(c.r, c.g, c.b, c.a)
    end
    if steadyGapFrame.nowLine and db.colors and db.colors.now then
        local c = db.colors.now
        steadyGapFrame.nowLine:SetColorTexture(c.r, c.g, c.b, c.a)
    end
end

function HunterWeaveBar:CreateFrames()
    frame = CreateFrame("Frame", "NAGHunterWeaveBar2", UIParent)
    frame:SetSize(self.db.class.bar.width, self.db.class.bar.height)
    frame:SetPoint(self.db.class.bar.point, self.db.class.bar.x, self.db.class.bar.y)
    frame:SetAlpha(self.db.class.bar.alpha)

    -- Background fill
    local bg = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bg:SetAllPoints()
    bg:SetColorTexture(0, 0, 0, 0.35)
    frame.bgTexture = bg

    -- Border frame
    local border = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    border:SetAllPoints()
    frame.border = border

    -- Bars (all start at 0 width; widths updated in UpdateDisplay)
    local function makeBar(strata, subLevel)
        local tex = frame:CreateTexture(nil, strata, nil, subLevel)
        tex:SetPoint("LEFT", frame, "LEFT", 0, 0)
        tex:SetWidth(0)
        tex:SetHeight(frame:GetHeight())
        return tex
    end

    -- Weave windows (stacked by Y offsets in UpdateDisplay)
    frame.steadyBar = makeBar("ARTWORK", 0)
    frame.multiBar = makeBar("ARTWORK", 0)
    frame.meleeBar = makeBar("ARTWORK", 0)

    frame.upcomingSteadyBar = makeBar("ARTWORK", -3)
    frame.upcomingMultiBar = makeBar("ARTWORK", -3)
    frame.upcomingMeleeBar = makeBar("ARTWORK", -3)

    -- Cast time overlay (full height, overlays weave lane)
    frame.castBar = frame:CreateTexture(nil, "ARTWORK", nil, 6)
    frame.castBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    frame.castBar:SetWidth(0)
    frame.castBar:SetHeight(frame:GetHeight())
    frame.castBar:Hide()

    -- Cast bar spark (optional marker at right edge)
    frame.castSpark = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    frame.castSpark:SetColorTexture(0.9, 0.9, 0.9, 0.9)
    frame.castSpark:Hide()

    -- GCD overlay (full height, same timespace as Auto)
    frame.gcdBar = frame:CreateTexture(nil, "ARTWORK", nil, 5)
    frame.gcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    frame.gcdBar:SetWidth(0)
    frame.gcdBar:SetHeight(frame:GetHeight())
    frame.gcdBar:Hide()

    frame.gcdSpark = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    frame.gcdSpark:SetColorTexture(0.9, 0.9, 0.9, 0.9)
    frame.gcdSpark:Hide()

    frame.gcdSparkLeft = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    frame.gcdSparkLeft:SetColorTexture(0.9, 0.9, 0.9, 0.9)
    frame.gcdSparkLeft:Hide()

    -- Auto Shot tick marker (time-to-next-auto position)
    local autoTick = frame:CreateTexture(nil, "OVERLAY", nil, 6)
    autoTick:SetTexture(nil)
    autoTick:SetBlendMode("BLEND")
    autoTick:SetColorTexture(0.85, 0.85, 0.85, 1)
    autoTick:SetWidth(2)
    autoTick:SetHeight(frame:GetHeight())
    autoTick:Hide()
    frame.autoTick = autoTick

    -- Auto Shot wind-up region marker (0.5s base, haste-scaled before auto fires).
    -- Left side of the bar is ttn=0; right side is ttn=speed.
    local windupRegion = frame:CreateTexture(nil, "ARTWORK", nil, -2)
    windupRegion:SetColorTexture(1, 1, 1, 0.08)
    windupRegion:Hide()
    frame.windupRegion = windupRegion

    -- Sparks (icons or lines) for each bar
    frame.steadySpark = CreateSparkFrame(frame, STEADY_SHOT_ID)
    frame.multiSpark = CreateSparkFrame(frame, MULTI_SHOT_ID)
    frame.meleeSpark = CreateSparkFrame(frame, RAPTOR_STRIKE_ID)
    frame.upcomingSteadySpark = CreateSparkFrame(frame, STEADY_SHOT_ID)
    frame.upcomingMultiSpark = CreateSparkFrame(frame, MULTI_SHOT_ID)
    frame.upcomingMeleeSpark = CreateSparkFrame(frame, RAPTOR_STRIKE_ID)

    -- Action-timeline elements (Guitar Hero style)
    local nowLine = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    nowLine:SetColorTexture(0.95, 0.95, 0.95, 0.9)
    nowLine:SetWidth(2)
    nowLine:SetHeight(frame:GetHeight())
    nowLine:Hide()
    frame.nowLine = nowLine

    local lockoutBar = frame:CreateTexture(nil, "ARTWORK", nil, -1)
    lockoutBar:SetColorTexture(0, 0, 0, 0.35)
    lockoutBar:SetWidth(0)
    lockoutBar:SetHeight(frame:GetHeight())
    lockoutBar:Hide()
    frame.lockoutBar = lockoutBar

    -- Close button for positioning mode
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 12, 12)
    closeButton:SetScript("OnClick", function()
        self:StopPositioning()
    end)
    closeButton:Hide()
    frame.closeButton = closeButton

    -- Dragging
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    local function hunterBarCanDrag()
        return NAG.IsAnyEditMode and NAG:IsAnyEditMode()
    end
    frame:EnableMouse(hunterBarCanDrag())
    frame:SetScript("OnDragStart", function()
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if canDrag and (not UnitAffectingCombat("player") or isPositioning) then
            frame:StartMoving()
            isDragging = true
        end
    end)
    frame:SetScript("OnDragStop", function()
        if isDragging then
            frame:StopMovingOrSizing()
            isDragging = false
            local settings = self.db.class.presetLayout.enabled and self.db.class.presetLayout or self.db.class.bar
            local nagFrame = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
            if nagFrame and nagFrame ~= UIParent and self.db.class.presetLayout.enabled and autoAnchorEnabled then
                -- Stay on UIParent; position relative to anchor so bar stays attached without affecting main frame (floating selector)
                local barLeft, barBottom = frame:GetLeft(), frame:GetBottom()
                local anchorRight = nagFrame:GetRight()
                local anchorBottom = nagFrame:GetBottom()
                if barLeft and barBottom and anchorRight and anchorBottom then
                    local offsetX = barLeft - anchorRight
                    local offsetY = barBottom - anchorBottom
                    frame:SetParent(UIParent)
                    frame:ClearAllPoints()
                    frame:SetPoint("BOTTOMLEFT", nagFrame, "BOTTOMRIGHT", offsetX, offsetY)
                    frame:SetScale(GetHunterBarEffectiveScale())
                    settings.point = "BOTTOMLEFT"
                    settings.x = offsetX
                    settings.y = offsetY
                end
            else
                -- Manual layout: save in UIParent space
                local left, bottom = frame:GetLeft(), frame:GetBottom()
                if left and bottom then
                    frame:SetParent(UIParent)
                    frame:ClearAllPoints()
                    frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
                end
                local point, _, _, x, y = frame:GetPoint(1)
                settings.point = point
                settings.x = x
                settings.y = y
            end
        end
    end)

    -- Right-click context menu (shared across bars)
    if not self._contextMenu then
        self._contextMenu = CreateFrame("Frame", "NAGHunterWeaveBarContextMenu", UIParent, "UIDropDownMenuTemplate")
    end
    -- RegisterForClicks is a Button method; plain Frame may not have it in TBC/Classic
    if frame.RegisterForClicks then
        frame:RegisterForClicks("RightButtonUp")
    end
    frame:SetScript("OnMouseUp", function(_, button)
        if button ~= "RightButton" then
            return
        end
        BuildContextMenu(self)
    end)

    self:UpdateFrameSettings()
    self:UpdateVisibility()
end

function HunterWeaveBar:CreateSteadyGapFrame()
    if steadyGapFrame then return end

    local db = self.db.class.steadyGapBar
    steadyGapFrame = CreateFrame("Frame", "NAGHunterSteadyGapBar", UIParent)
    steadyGapFrame:SetSize(db.width, db.height)
    steadyGapFrame:SetPoint(db.point, db.x, db.y)
    steadyGapFrame:SetAlpha(db.alpha or 1.0)
    steadyGapFrame:Hide()
    steadyGapFrame:SetMovable(true)
    steadyGapFrame:RegisterForDrag("LeftButton")
    steadyGapFrame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
    -- RegisterForClicks is a Button method; plain Frame may not have it in TBC/Classic
    if steadyGapFrame.RegisterForClicks then
        steadyGapFrame:RegisterForClicks("RightButtonUp")
    end

    steadyGapFrame:SetScript("OnDragStart", function()
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if not canDrag or (UnitAffectingCombat("player") and not isPositioning) then
            return
        end
        steadyGapFrame:StartMoving()
    end)
    steadyGapFrame:SetScript("OnDragStop", function()
        steadyGapFrame:StopMovingOrSizing()
        local left, bottom = steadyGapFrame:GetLeft(), steadyGapFrame:GetBottom()
        if left and bottom then
            steadyGapFrame:SetParent(UIParent)
            steadyGapFrame:ClearAllPoints()
            steadyGapFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
        end
        local point, _, _, x, y = steadyGapFrame:GetPoint(1)
        db.point = point
        db.x = x
        db.y = y
    end)

    steadyGapFrame:SetScript("OnMouseUp", function(_, button)
        if button ~= "RightButton" then
            return
        end
        if not self._contextMenu then
            self._contextMenu = CreateFrame("Frame", "NAGHunterWeaveBarContextMenu", UIParent, "UIDropDownMenuTemplate")
        end
        BuildContextMenu(self)
    end)

    local bg = steadyGapFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bg:SetAllPoints()
    bg:SetColorTexture(db.colors.background.r, db.colors.background.g, db.colors.background.b, db.colors.background.a)
    steadyGapFrame.bgTexture = bg

    local border = CreateFrame("Frame", nil, steadyGapFrame, "BackdropTemplate")
    border:SetAllPoints()
    steadyGapFrame.border = border

    local gap1 = steadyGapFrame:CreateTexture(nil, "ARTWORK", nil, 0)
    gap1:SetPoint("LEFT", steadyGapFrame, "LEFT", 0, 0)
    gap1:SetWidth(0)
    gap1:SetHeight(db.height)
    gap1:SetColorTexture(db.colors.gap1.r, db.colors.gap1.g, db.colors.gap1.b, db.colors.gap1.a)
    gap1:Hide()
    steadyGapFrame.gap1 = gap1

    local gap2 = steadyGapFrame:CreateTexture(nil, "ARTWORK", nil, -1)
    gap2:SetPoint("LEFT", steadyGapFrame, "LEFT", 0, 0)
    gap2:SetWidth(0)
    gap2:SetHeight(db.height)
    gap2:SetColorTexture(db.colors.gap2.r, db.colors.gap2.g, db.colors.gap2.b, db.colors.gap2.a)
    gap2:Hide()
    steadyGapFrame.gap2 = gap2

    local nowLine = steadyGapFrame:CreateTexture(nil, "OVERLAY", nil, 7)
    nowLine:SetColorTexture(db.colors.now.r, db.colors.now.g, db.colors.now.b, db.colors.now.a)
    nowLine:SetWidth(2)
    nowLine:SetHeight(db.height)
    nowLine:Hide()
    steadyGapFrame.nowLine = nowLine
end

local function SmoothWidth(bar, targetWidth)
    local currentWidth = bar:GetWidth()
    if targetWidth < currentWidth then
        local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
        bar:SetWidth(newWidth)
    else
        bar:SetWidth(targetWidth)
    end
end

local function clamp01(x)
    if x < 0 then return 0 end
    if x > 1 then return 1 end
    return x
end

local function PositionTimelineSpark(sparkFrame, x, y)
    if not sparkFrame or not frame then return end
    sparkFrame:ClearAllPoints()
    sparkFrame:SetPoint("CENTER", frame, "LEFT", x, y or 0)
    sparkFrame:Show()
end

local function SetTimelineSparkKeybind(sparkFrame, showKeybind)
    if not sparkFrame or not sparkFrame.keybindText then return end
    if showKeybind then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind and sparkFrame.spellId then
            kb = KeybindManager:GetSpellKeybind(sparkFrame.spellId) or ""
        end
        sparkFrame.keybindText:SetText(kb)
        if kb ~= "" then
            sparkFrame.keybindText:Show()
        else
            sparkFrame.keybindText:Hide()
        end
    else
        sparkFrame.keybindText:SetText("")
        sparkFrame.keybindText:Hide()
    end
end

local function HideAllTimelineElements()
    if not frame then return end
    if frame.nowLine then frame.nowLine:Hide() end
    if frame.lockoutBar then frame.lockoutBar:Hide() end
end

local function HideSteadyGapElements()
    if not steadyGapFrame then return end
    if steadyGapFrame.gap1 then steadyGapFrame.gap1:Hide() end
    if steadyGapFrame.gap2 then steadyGapFrame.gap2:Hide() end
    if steadyGapFrame.nowLine then steadyGapFrame.nowLine:Hide() end
end

local function HideWeaveElements()
    if not frame then return end
    frame.steadyBar:SetWidth(0); frame.steadyBar:Hide()
    frame.multiBar:SetWidth(0); frame.multiBar:Hide()
    frame.meleeBar:SetWidth(0); frame.meleeBar:Hide()
    frame.upcomingSteadyBar:SetWidth(0); frame.upcomingSteadyBar:Hide()
    frame.upcomingMultiBar:SetWidth(0); frame.upcomingMultiBar:Hide()
    frame.upcomingMeleeBar:SetWidth(0); frame.upcomingMeleeBar:Hide()
    if frame.castBar then frame.castBar:SetWidth(0); frame.castBar:Hide() end
    if frame.castSpark then frame.castSpark:Hide() end
    if frame.castSparkLeft then frame.castSparkLeft:Hide() end
    HideAllSparkFrames()
    if frame.autoTick then frame.autoTick:Hide() end
    if frame.windupRegion then frame.windupRegion:Hide() end
    if frame.gcdBar then frame.gcdBar:Hide() end
    if frame.gcdSpark then frame.gcdSpark:Hide() end
    if frame.gcdSparkLeft then frame.gcdSparkLeft:Hide() end
end

local function GetTimelineWindowSeconds(windowGcds)
    local gcdValue = (NAG.GCDTimeValue and NAG:GCDTimeValue()) or 1.5
    if type(gcdValue) ~= "number" or gcdValue <= 0 then
        gcdValue = 1.5
    end
    local gcds = windowGcds or 2
    if gcds < 0.5 then gcds = 0.5 end
    return gcdValue * gcds
end

local function GetQueuedGcdLeft(now)
    if not lastQueuedPressAt then
        return 0
    end
    local gcdDuration = (NAG.GCDTimeValue and NAG:GCDTimeValue()) or 1.5
    if type(gcdDuration) ~= "number" or gcdDuration <= 0 then
        gcdDuration = 1.5
    end
    local age = now - lastQueuedPressAt
    if age < 0 then age = 0 end
    if age > (gcdDuration + 0.25) then
        lastQueuedPressAt = nil
        lastQueuedSpellId = nil
        return 0
    end
    local left = gcdDuration - age
    if left < 0 then left = 0 end
    return left
end

function HunterWeaveBar:UpdateActionTimelineDisplay(settings, snapshot)
    if not frame then return end
    if not snapshot or not snapshot.ok then
        HideWeaveElements()
        HideAllTimelineElements()
        return
    end

    local timelineSettings = self.db.class.actionTimeline or {}
    local maxWidth = settings.width
    local height = settings.height

    frame:SetSize(maxWidth, height)

    if frame.bgTexture then
        frame.bgTexture:ClearAllPoints()
        frame.bgTexture:SetPoint("LEFT", frame, "LEFT", 0, 0)
        frame.bgTexture:SetSize(maxWidth, height)
    end
    if frame.border then
        frame.border:ClearAllPoints()
        frame.border:SetPoint("LEFT", frame, "LEFT", 0, 0)
        frame.border:SetSize(maxWidth, height)
    end

    local windowSeconds = GetTimelineWindowSeconds(timelineSettings.windowGcds or 2)
    if windowSeconds <= 0 then
        HideAllTimelineElements()
        return
    end

    local readyIn = tonumber(snapshot.nextActionDelay or 0) or 0
    if readyIn < 0 then readyIn = 0 end
    -- If a shot was queued during wind-up, assume GCD starts at press time (client behavior)
    local queuedGcdLeft = GetQueuedGcdLeft(tonumber(snapshot.now or 0) or GetTime())
    if queuedGcdLeft > readyIn then
        readyIn = queuedGcdLeft
    end

    if frame.nowLine and timelineSettings.showNowLine then
        frame.nowLine:SetHeight(height)
        frame.nowLine:ClearAllPoints()
        frame.nowLine:SetPoint("CENTER", frame, "RIGHT", 0, 0)
        frame.nowLine:Show()
    elseif frame.nowLine then
        frame.nowLine:Hide()
    end

    if frame.lockoutBar and timelineSettings.showLockout and readyIn > 0 then
        local lockoutWidth = maxWidth * clamp01(readyIn / windowSeconds)
        frame.lockoutBar:SetHeight(height)
        frame.lockoutBar:SetWidth(lockoutWidth)
        frame.lockoutBar:ClearAllPoints()
        frame.lockoutBar:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
        frame.lockoutBar:Show()
    elseif frame.lockoutBar then
        frame.lockoutBar:Hide()
    end

    local steadyHoldAfterReady = 0
    if NAG.HunterSteadyTimeToSafeStart then
        steadyHoldAfterReady = NAG:HunterSteadyTimeToSafeStart()
    end
    if steadyHoldAfterReady < 0 then steadyHoldAfterReady = 0 end

    local showSteady = not snapshot.steadyQueued and (snapshot.castingSpellId or 0) ~= STEADY_SHOT_ID
    if showSteady then
        local pressIn = readyIn
        if steadyHoldAfterReady > 0 then
            pressIn = readyIn + steadyHoldAfterReady
        end
        if pressIn <= windowSeconds then
            local x = maxWidth * clamp01(1 - (pressIn / windowSeconds))
            local y = -(height * 0.2)
            PositionTimelineSpark(frame.steadySpark, x, y)
            SetTimelineSparkKeybind(frame.steadySpark, timelineSettings.showKeybindOnTimeline)
        else
            HideSparkFrame(frame.steadySpark)
        end
    else
        HideSparkFrame(frame.steadySpark)
    end

    local showSecondary = timelineSettings.showSecondary and true or false
    if showSecondary then
        local multiReady = (NAG.SpellIsReady and NAG:SpellIsReady(MULTI_SHOT_ID)) and true or false
        local canMultiPress = snapshot.canMultiPress and (not snapshot.rangedInWindup) and (not snapshot.steadyQueued)
        if multiReady and canMultiPress then
            local multiHoldAfterReady = 0
            if NAG.HunterMSTimeToSafeStart then
                multiHoldAfterReady = NAG:HunterMSTimeToSafeStart()
            end
            if multiHoldAfterReady < 0 then multiHoldAfterReady = 0 end
            local pressIn = readyIn + multiHoldAfterReady
            if pressIn <= windowSeconds then
                local x = maxWidth * clamp01(1 - (pressIn / windowSeconds))
                local y = (height * 0.2)
                PositionTimelineSpark(frame.multiSpark, x, y)
                SetTimelineSparkKeybind(frame.multiSpark, timelineSettings.showKeybindOnTimeline)
            else
                HideSparkFrame(frame.multiSpark)
            end
        else
            HideSparkFrame(frame.multiSpark)
        end
    else
        HideSparkFrame(frame.multiSpark)
    end
end

function HunterWeaveBar:UpdateSteadyGapDisplay(snapshot)
    if not steadyGapFrame then return end
    if not snapshot or not snapshot.ok then
        HideSteadyGapElements()
        return
    end

    local db = self.db.class.steadyGapBar
    local maxWidth = db.width
    local height = db.height
    local speed = tonumber(snapshot.rangedSpeed or 0) or 0
    local ttn = tonumber(snapshot.rangedTimeToNext or 0) or 0
    local steadyWindow = tonumber(snapshot.nextSteadyWindow or 0) or 0

    steadyGapFrame:SetSize(maxWidth, height)

    if steadyGapFrame.bgTexture then
        steadyGapFrame.bgTexture:SetAllPoints()
    end

    if steadyGapFrame.nowLine then
        steadyGapFrame.nowLine:SetHeight(height)
        steadyGapFrame.nowLine:ClearAllPoints()
        steadyGapFrame.nowLine:SetPoint("CENTER", steadyGapFrame, "LEFT", 0, 0)
        steadyGapFrame.nowLine:Show()
    end

    if speed <= 0 then
        HideSteadyGapElements()
        return
    end

    local windowSeconds = speed * 2
    local function secondsToX(seconds)
        return maxWidth * clamp01(seconds / windowSeconds)
    end

    local gapStart1 = ttn
    local gapEnd1 = gapStart1 + steadyWindow
    local gapStart2 = ttn + speed
    local gapEnd2 = gapStart2 + steadyWindow

    if steadyWindow > 0 and gapEnd1 > 0 then
        local x1 = secondsToX(gapStart1)
        local x2 = secondsToX(gapEnd1)
        local w = x2 - x1
        if w > 1 then
            steadyGapFrame.gap1:SetHeight(height)
            steadyGapFrame.gap1:SetWidth(w)
            steadyGapFrame.gap1:ClearAllPoints()
            steadyGapFrame.gap1:SetPoint("LEFT", steadyGapFrame, "LEFT", x1, 0)
            steadyGapFrame.gap1:Show()
        else
            steadyGapFrame.gap1:Hide()
        end
    else
        steadyGapFrame.gap1:Hide()
    end

    if steadyWindow > 0 and gapEnd2 > 0 then
        local x1 = secondsToX(gapStart2)
        local x2 = secondsToX(gapEnd2)
        local w = x2 - x1
        if w > 1 then
            steadyGapFrame.gap2:SetHeight(height)
            steadyGapFrame.gap2:SetWidth(w)
            steadyGapFrame.gap2:ClearAllPoints()
            steadyGapFrame.gap2:SetPoint("LEFT", steadyGapFrame, "LEFT", x1, 0)
            steadyGapFrame.gap2:Show()
        else
            steadyGapFrame.gap2:Hide()
        end
    else
        steadyGapFrame.gap2:Hide()
    end
end

local function BuildContextMenu(moduleSelf)
    local function isSteadyGapEnabled()
        return moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.steadyGapBar.enabled
    end

    local function toggleSteadyGap()
        if not (moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.steadyGapBar) then
            return
        end
        moduleSelf.db.class.steadyGapBar.enabled = not moduleSelf.db.class.steadyGapBar.enabled
        moduleSelf:UpdateVisibility()
    end

    local function isActionTimelineEnabled()
        return moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.actionTimeline.enabled
    end

    local function toggleActionTimeline()
        if not (moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.actionTimeline) then
            return
        end
        moduleSelf.db.class.actionTimeline.enabled = not moduleSelf.db.class.actionTimeline.enabled
        moduleSelf:UpdateDisplay()
    end

    local function isWeaveBarEnabled()
        return moduleSelf and moduleSelf.db and moduleSelf.db.class and moduleSelf.db.class.showBar
    end

    local function toggleWeaveBar()
        if not (moduleSelf and moduleSelf.db and moduleSelf.db.class) then
            return
        end
        moduleSelf.db.class.showBar = not moduleSelf.db.class.showBar
        moduleSelf:UpdateVisibility()
    end

    local menu = {
        { text = "Hunter Weave Bars", isTitle = true, notCheckable = true },
        {
            text = "Show Weave Bar",
            isNotRadio = true,
            keepShownOnClick = true,
            checked = isWeaveBarEnabled,
            func = toggleWeaveBar,
        },
        {
            text = "Show Action Timeline",
            isNotRadio = true,
            keepShownOnClick = true,
            checked = isActionTimelineEnabled,
            func = toggleActionTimeline,
        },
        {
            text = "Show Steady Gaps Bar",
            isNotRadio = true,
            keepShownOnClick = true,
            checked = isSteadyGapEnabled,
            func = toggleSteadyGap,
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
        EasyMenu(menu, moduleSelf._contextMenu, "cursor", 0, 0, "MENU")
        return
    end

    if UIDropDownMenu_Initialize and UIDropDownMenu_AddButton and ToggleDropDownMenu then
        UIDropDownMenu_Initialize(moduleSelf._contextMenu, function(_, level)
            for i = 1, #menu do
                UIDropDownMenu_AddButton(menu[i], level)
            end
        end, "MENU")
        ToggleDropDownMenu(1, nil, moduleSelf._contextMenu, "cursor", 0, 0)
    end
end

function HunterWeaveBar:UpdateDisplay()
    if not frame or isDragging then return end
    -- In edit mode, visibility is managed by UpdateVisibility - never hide so user can position
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        return
    end
    if not self.db.class.showBar and not (self.db.class.actionTimeline and self.db.class.actionTimeline.enabled)
        and not (self.db.class.steadyGapBar and self.db.class.steadyGapBar.enabled) then
        return
    end

    local usePresetLayout = self.db.class.presetLayout.enabled
    local settings = usePresetLayout and self.db.class.presetLayout or self.db.class.bar
    local sparkIconsEnabled = frame.sparkIconsEnabled and true or false
    -- Hide out of combat unless positioning
    if self.db.class.hideOutOfCombat and not UnitAffectingCombat("player") and not isPositioning then
        frame:Hide()
        return
    end
    frame:Show()

    local snapshot = NAG.HunterWeaveSnapshot and NAG.HunterWeaveSnapshot()
    if not snapshot or not snapshot.ok or not snapshot.rangedSpeed or snapshot.rangedSpeed <= 0 then
        HideWeaveElements()
        HideAllTimelineElements()
        HideSteadyGapElements()
        return
    end

    -- Track queued press moments in wind-up to model immediate GCD start for UI predictions.
    local now = tonumber(snapshot.now or 0) or GetTime()
    if snapshot.rangedInWindup and (snapshot.steadyQueued or snapshot.multiQueued) then
        local spellId = snapshot.steadyQueued and STEADY_SHOT_ID or MULTI_SHOT_ID
        if not lastQueuedPressAt or lastQueuedSpellId ~= spellId then
            lastQueuedPressAt = now
            lastQueuedSpellId = spellId
        end
    else
        -- Clear if we are no longer queued or wind-up is over.
        if lastQueuedPressAt and (not snapshot.rangedInWindup) and (not snapshot.steadyQueued) and (not snapshot.multiQueued) then
            lastQueuedPressAt = nil
            lastQueuedSpellId = nil
        end
    end

    if steadyGapFrame then
        if self.db.class.steadyGapBar and self.db.class.steadyGapBar.enabled then
            self:UpdateSteadyGapDisplay(snapshot)
        else
            HideSteadyGapElements()
        end
    end

    if self.db.class.actionTimeline and self.db.class.actionTimeline.enabled then
        HideWeaveElements()
        self:UpdateActionTimelineDisplay(settings, snapshot)
        return
    end

    HideAllTimelineElements()

    local maxWidth = settings.width
    local weaveHeight = settings.height
    local castBarHeight = settings.castBarHeight or 2
    -- GCD lane is rendered outside/under the weave pack; cast overlays the weave lane.
    local gcdHeight = 2
    local gcdGap = 4
    local totalHeight = weaveHeight
    frame:SetSize(maxWidth, totalHeight)

    -- Weave bars use the original height
    local height = weaveHeight

    -- Compute bar heights
    local steadyH = height * (settings.steadyBarHeightPct or 0.18)
    local multiH = height * (settings.multiBarHeightPct or 0.18)
    local meleeH = height * (settings.meleeBarHeightPct or 0.18)

    -- Lay them out: steady bottom, multi middle, melee top (centered in weave lane)
    local half = height / 2
    local steadyY = -half + (steadyH / 2) + 2  -- raise ~5px vs prior (was -3)
    local multiY = 1                         -- raise ~5px vs prior (was -3)
    local meleeY = half - (meleeH / 2) - 1

    frame.steadyBar:SetHeight(steadyH); frame.steadyBar:SetPoint("LEFT", frame, "LEFT", 0, steadyY)
    frame.multiBar:SetHeight(multiH); frame.multiBar:SetPoint("LEFT", frame, "LEFT", 0, multiY)
    frame.meleeBar:SetHeight(meleeH); frame.meleeBar:SetPoint("LEFT", frame, "LEFT", 0, meleeY)

    frame.upcomingSteadyBar:SetHeight(steadyH); frame.upcomingSteadyBar:SetPoint("LEFT", frame, "LEFT", 0, steadyY)
    frame.upcomingMultiBar:SetHeight(multiH); frame.upcomingMultiBar:SetPoint("LEFT", frame, "LEFT", 0, multiY)
    frame.upcomingMeleeBar:SetHeight(meleeH); frame.upcomingMeleeBar:SetPoint("LEFT", frame, "LEFT", 0, meleeY)

    -- Background should only cover the weave bars lane
    if frame.bgTexture then
        frame.bgTexture:ClearAllPoints()
        frame.bgTexture:SetPoint("LEFT", frame, "LEFT", 0, 0)
        frame.bgTexture:SetSize(maxWidth, weaveHeight)
    end

    -- Border should also wrap only the weave lane
    if frame.border then
        frame.border:ClearAllPoints()
        frame.border:SetPoint("LEFT", frame, "LEFT", 0, 0)
        frame.border:SetSize(maxWidth, weaveHeight)
    end

    -- Time-to-next auto (used to position the moving gap segments)
    local ttn = snapshot.rangedTimeToNext or 0
    local speed = snapshot.rangedSpeed or 1

    -- Wind-up region overlay (0.5s base, haste-scaled)
    if frame.windupRegion then
        local windupSeconds = tonumber(snapshot.rangedWindupSeconds or 0) or 0
        if windupSeconds <= 0 then
            local baseSpeed = 0
            local swingLib = ns and ns.LibClassicSwingTimerAPI or nil
            if swingLib and swingLib.player and swingLib.player.rangedBaseSpeed then
                baseSpeed = tonumber(swingLib.player.rangedBaseSpeed) or 0
            end
            local computeWindup = ns and ns.HunterComputeWindupSeconds
            if type(computeWindup) == "function" then
                windupSeconds = tonumber(computeWindup(speed, baseSpeed, 0.5) or 0.5) or 0.5
            else
                windupSeconds = 0.5
            end
        end
        local windupWidth = maxWidth * clamp01(windupSeconds / speed)
        if windupWidth > 1 then
            frame.windupRegion:ClearAllPoints()
            frame.windupRegion:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
            frame.windupRegion:SetSize(windupWidth, weaveHeight)
            frame.windupRegion:Show()
        else
            frame.windupRegion:Hide()
        end
    end

    -- Auto Shot tick marker: x = ttn / speed (moves right -> left as auto approaches)
    if frame.autoTick then
        local x = maxWidth * clamp01(ttn / speed)
        frame.autoTick:SetHeight(weaveHeight)
        frame.autoTick:ClearAllPoints()
        frame.autoTick:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", x, 0)
        frame.autoTick:Show()
    end

    -- GCD overlay (normalized to swing timespace), placed below the weave pack (outside background/border)
    local gcdLeft = snapshot.gcdLeft or 0
    local gcdWidth = maxWidth * clamp01(gcdLeft / speed)
    frame.gcdBar:SetHeight(gcdHeight)
    frame.gcdBar:SetWidth(gcdWidth)
    frame.gcdBar:ClearAllPoints()
    frame.gcdBar:SetPoint("LEFT", frame, "BOTTOMLEFT", 0, -(gcdGap + gcdHeight))
    if gcdWidth > 0 then
        frame.gcdBar:Show()
        local sparkH = gcdHeight + 3
        frame.gcdSpark:SetSize(2, sparkH)
        frame.gcdSpark:ClearAllPoints()
        -- Grow upward: bottom aligned to bar, extends above
        frame.gcdSpark:SetPoint("BOTTOM", frame.gcdBar, "RIGHT", 0, 0)
        frame.gcdSpark:Show()
        if frame.gcdSparkLeft then
            frame.gcdSparkLeft:SetSize(2, sparkH)
            frame.gcdSparkLeft:ClearAllPoints()
            -- Grow upward: bottom aligned to bar, extends above
            frame.gcdSparkLeft:SetPoint("BOTTOM", frame.gcdBar, "LEFT", 0, 0)
            frame.gcdSparkLeft:Show()
        end
    else
        frame.gcdBar:Hide()
        frame.gcdSpark:Hide()
        if frame.gcdSparkLeft then frame.gcdSparkLeft:Hide() end
    end

    -- Cast time overlay (full height, overlays weave lane, left is 0, shrinks right->left)
    local castCenterY = 0

    -- Get current cast info
    local spellName, _, _, _, startTimeMS, endTimeMS, _, _, spellIdFromAPI = UnitCastingInfo("player")
    if spellName and endTimeMS and startTimeMS and currentCastSpellId then
        local nowMS = GetTime() * 1000
        local castTimeRemaining = math.max(0, (endTimeMS - nowMS) / 1000)

        -- Update tracked cast end time/total time if we got fresh data
        if spellIdFromAPI == currentCastSpellId then
            currentCastEndTime = endTimeMS / 1000
            currentCastTotalTime = (endTimeMS - startTimeMS) / 1000
        end

        -- Normalize to the Auto swing timespace: right edge = full swing length
        local castWidth = maxWidth * clamp01(castTimeRemaining / speed)

        frame.castBar:ClearAllPoints()
        frame.castBar:SetPoint("LEFT", frame, "LEFT", 0, castCenterY)
        frame.castBar:SetWidth(castWidth)
        frame.castBar:SetHeight(weaveHeight)
        frame.castBar:Show()

        frame.castSpark:SetSize(2, weaveHeight)
        frame.castSpark:ClearAllPoints()
        frame.castSpark:SetPoint("CENTER", frame.castBar, "RIGHT", 0, 0)
        frame.castSpark:Show()
    else
        -- Also check tracked state in case UnitCastingInfo is nil but we're still tracking
        if currentCastSpellId and currentCastEndTime then
            local now = GetTime()
            local castTimeRemaining = math.max(0, currentCastEndTime - now)

            if castTimeRemaining > 0 then
                local castWidth = maxWidth * clamp01(castTimeRemaining / speed)

                frame.castBar:ClearAllPoints()
                frame.castBar:SetPoint("LEFT", frame, "LEFT", 0, castCenterY)
                frame.castBar:SetWidth(castWidth)
                frame.castBar:SetHeight(weaveHeight)
                frame.castBar:Show()

                frame.castSpark:SetSize(2, weaveHeight)
                frame.castSpark:ClearAllPoints()
                frame.castSpark:SetPoint("CENTER", frame.castBar, "RIGHT", 0, 0)
                frame.castSpark:Show()
            else
                -- Cast finished, clear tracking
                frame.castBar:Hide()
                frame.castSpark:Hide()
                currentCastSpellId = nil
                currentCastEndTime = nil
                currentCastTotalTime = nil
            end
        else
            frame.castBar:Hide()
            frame.castSpark:Hide()
        end
    end

    -- Simplified, correct-for-your-mental-model bars:
    -- safeStartWindow = max(0, timeToNextAuto - castTime)
    -- This SHRINKS as the remaining usable gap gets shorter.
    local showKeybindOnWeaveBar = settings.showKeybindOnWeaveBar and true or false
    local function updateSafeStartWindow(bar, spark, remainingSeconds, yOffset, alignTop, alignBottom, show)
        if not show then
            bar:SetWidth(0)
            bar:Hide()
            HideSparkFrame(spark)
            return
        end
        local rem = remainingSeconds or 0
        if rem <= 0 or speed <= 0 then
            bar:SetWidth(0)
            bar:Hide()
            HideSparkFrame(spark)
            return
        end
        local width = maxWidth * clamp01(rem / speed)
        if width <= 1 then
            bar:SetWidth(0)
            bar:Hide()
            HideSparkFrame(spark)
            return
        end
        bar:ClearAllPoints()
        bar:SetPoint("LEFT", frame, "LEFT", 0, yOffset or 0)
        SmoothWidth(bar, width)
        bar:SetAlpha(1.0)
        bar:Show()
        PositionBarSpark(bar, spark, sparkIconsEnabled, alignTop, alignBottom)
        SetTimelineSparkKeybind(spark, showKeybindOnWeaveBar)
    end

    local steadyRem = math.max(0, ttn - (snapshot.steadyCast or 0))
    local multiRem = math.max(0, ttn - (snapshot.multiCast or 0))
    local meleeRem = math.max(0, ttn - (snapshot.meleeGapMin or 0))

    updateSafeStartWindow(frame.steadyBar, frame.steadySpark, steadyRem, steadyY, false, false, true)
    updateSafeStartWindow(frame.multiBar, frame.multiSpark, multiRem, multiY, false, false, true)
    updateSafeStartWindow(frame.meleeBar, frame.meleeSpark, meleeRem, meleeY, false, false, snapshot.inMelee == true)

    -- Next upcoming gap (after the next Auto): show as a bar that anchors at the next Auto tick
    -- and grows leftward as we approach it (mirrors Shaman weave behaviour).
    local function updateUpcomingFromRight(bar, spark, windowLenSeconds, yOffset, show)
        if not show then
            bar:SetWidth(0)
            bar:Hide()
            HideSparkFrame(spark)
            return
        end

        local win = windowLenSeconds or 0
        if win <= 0 or speed <= 0 then
            bar:SetWidth(0)
            bar:Hide()
            HideSparkFrame(spark)
            return
        end

        -- Anchor at the next Auto tick (current swing progress)
        local startPoint = maxWidth * clamp01(ttn / speed)
        -- End point: next Auto plus available window, clamped to the swing length
        local endProgress = clamp01(math.min(speed, ttn + win) / speed)
        local endPoint = maxWidth * endProgress
        local width = endPoint - startPoint
        -- If we're essentially at the Auto boundary, suppress the upcoming bar to avoid stray lines.
        local epsilonPx = 2
        if startPoint >= (maxWidth - epsilonPx) or width <= epsilonPx then
            bar:SetWidth(0)
            bar:Hide()
            HideSparkFrame(spark)
            return
        end
        if width <= 1 then
            bar:SetWidth(0)
            bar:Hide()
            HideSparkFrame(spark)
            return
        end

        bar:ClearAllPoints()
        bar:SetPoint("LEFT", frame, "LEFT", startPoint, yOffset or 0)
        SmoothWidth(bar, width)
        bar:SetAlpha(1.0)
        bar:Show()

        -- Show spark while bar is still growing; hide when effectively full
        local maxUpcomingWidth = maxWidth - startPoint
        local epsilon = 1
        if width < (maxUpcomingWidth - epsilon) then
            PositionBarSpark(bar, spark, sparkIconsEnabled, false, false)
            SetTimelineSparkKeybind(spark, showKeybindOnWeaveBar)
        else
            HideSparkFrame(spark)
        end
    end

    local steadyNextLen = math.max(0, speed - (snapshot.steadyCast or 0))
    local multiNextLen = math.max(0, speed - (snapshot.multiCast or 0))
    local meleeNextLen = math.max(0, speed - (snapshot.meleeGapMin or 0))

    updateUpcomingFromRight(frame.upcomingSteadyBar, frame.upcomingSteadySpark, steadyNextLen, steadyY, true)
    updateUpcomingFromRight(frame.upcomingMultiBar, frame.upcomingMultiSpark, multiNextLen, multiY, true)
    updateUpcomingFromRight(frame.upcomingMeleeBar, frame.upcomingMeleeSpark, meleeNextLen, meleeY, snapshot.inMelee == true)
end

-- ============================ CAST TRACKING ============================

function HunterWeaveBar:UNIT_SPELLCAST_START(event, unit, castString, spellId)
    if unit == "player" and type(spellId) == "number" then
        currentCastSpellId = spellId

        -- Use the live cast end time from the game client when available.
        -- This reflects haste and other cast-time modifiers.
        local _, _, _, startTimeMS, endTimeMS, _, _, _, spellIdFromAPI = UnitCastingInfo("player")
        if endTimeMS and startTimeMS and endTimeMS > startTimeMS and (not spellIdFromAPI or spellIdFromAPI == spellId) then
            currentCastEndTime = endTimeMS / 1000
            currentCastTotalTime = (endTimeMS - startTimeMS) / 1000
            return
        end

        -- Fallback: compute from base cast time (may be wrong for temporary cast-time modifiers).
        local castTime = nil
        if NAG.SpellCastTime then
            castTime = NAG:SpellCastTime(spellId)
        end
        if castTime and castTime > 0 then
            currentCastEndTime = GetTime() + castTime
            currentCastTotalTime = castTime
        else
            currentCastSpellId = nil
            currentCastEndTime = nil
            currentCastTotalTime = nil
        end
    end
end

function HunterWeaveBar:UNIT_SPELLCAST_STOP(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastEndTime = nil
        currentCastTotalTime = nil
    end
end

function HunterWeaveBar:UNIT_SPELLCAST_INTERRUPTED(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastEndTime = nil
        currentCastTotalTime = nil
    end
end

-- ============================ SPEC UPDATED ============================

function HunterWeaveBar:NAG_SPEC_UPDATED()
    self:UpdateVisibility()
end

-- ============================ LIFECYCLE ============================

function HunterWeaveBar:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    SpecCompat = NAG:GetModule("SpecCompat")
end

function HunterWeaveBar:ModuleEnable()
    if UnitClassBase("player") ~= "HUNTER" then
        self:SetEnabledState(false)
        return
    end
    if not Version:IsTBC() then
        -- Keep it inert outside TBC.
        self:SetEnabledState(false)
        return
    end

    if not frame then
        self:CreateFrames()
    end
    if not steadyGapFrame then
        self:CreateSteadyGapFrame()
    end

    frame:SetScript("OnUpdate", function(_, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            self:UpdateDisplay()
            lastUpdate = 0
        end
    end)

    self:UpdateFrameSettings()
    self:UpdateSteadyGapFrameSettings()
    self:UpdateVisibility()
end

function HunterWeaveBar:ModuleDisable()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
    if steadyGapFrame then
        steadyGapFrame:Hide()
    end
end

-- ============================ OPTIONS ============================

function HunterWeaveBar:GetOptions()
    local function notify()
        if AceConfigRegistry then
            AceConfigRegistry:NotifyChange("NAG")
        end
    end

    local function colorGetter(colorTable)
        return function()
            return colorTable.r, colorTable.g, colorTable.b, colorTable.a
        end
    end

    local function colorSetter(colorTable)
        return function(_, r, g, b, a)
            colorTable.r, colorTable.g, colorTable.b, colorTable.a = r, g, b, a
            self:UpdateFrameSettings()
        end
    end

    return {
        type = "group",
        name = L["Hunter Weave Bar"] or "Hunter Weave Bar",
        order = 30,
        childGroups = "tab",
        args = {
            showBar = OptionsFactory:CreateToggle(
                L["Show Weave Bar"] or "Show Weave Bar",
                L["Toggle the visibility of the Hunter weave bar"] or "Toggle the visibility of the Hunter weave bar",
                function() return self.db.class.showBar end,
                function(_, v) self.db.class.showBar = v; self:UpdateVisibility() end,
                { width = "full", order = 0 }
            ),
            hideOutOfCombat = OptionsFactory:CreateToggle(
                L["Hide Out of Combat"] or "Hide Out of Combat",
                L["Hide the weave bar when out of combat"] or "Hide the weave bar when out of combat",
                function() return self.db.class.hideOutOfCombat end,
                function(_, v) self.db.class.hideOutOfCombat = v; self:UpdateVisibility() end,
                { width = "full", order = 1 }
            ),
            positionBar = OptionsFactory:CreateExecute(
                L["Position Bar"] or "Position Bar",
                L["Drag the bar to position it, then click X when done."] or
                "Drag the bar to position it, then click X when done.",
                function() self:StartPositioning() end,
                { width = "full", order = 2 }
            ),
            actionTimeline = {
                name = L["Action Timeline"] or "Action Timeline",
                type = "group",
                order = 4,
                inline = true,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        L["Enable Action Timeline"] or "Enable Action Timeline",
                        L["Show a fixed timeline (e.g., 2 GCDs) with action cues instead of auto timing."] or
                        "Show a fixed timeline (e.g., 2 GCDs) with action cues instead of auto timing.",
                        function() return self.db.class.actionTimeline.enabled end,
                        function(_, v) self.db.class.actionTimeline.enabled = v; self:UpdateDisplay() end,
                        { width = "full", order = 0 }
                    ),
                    windowGcds = OptionsFactory:CreateRange(
                        L["Window (GCDs)"] or "Window (GCDs)",
                        L["How many GCDs ahead the timeline spans."] or "How many GCDs ahead the timeline spans.",
                        function() return self.db.class.actionTimeline.windowGcds end,
                        function(_, v) self.db.class.actionTimeline.windowGcds = v; self:UpdateDisplay() end,
                        { min = 0.5, max = 4, step = 0.5, order = 1 }
                    ),
                    showLockout = OptionsFactory:CreateToggle(
                        L["Show Lockout"] or "Show Lockout",
                        L["Show the GCD/cast lockout segment on the right side."] or
                        "Show the GCD/cast lockout segment on the right side.",
                        function() return self.db.class.actionTimeline.showLockout end,
                        function(_, v) self.db.class.actionTimeline.showLockout = v; self:UpdateDisplay() end,
                        { width = "full", order = 2 }
                    ),
                    showSecondary = OptionsFactory:CreateToggle(
                        L["Show Secondary Action"] or "Show Secondary Action",
                        L["Show Multi-Shot cues when it is the next safe filler."] or
                        "Show Multi-Shot cues when it is the next safe filler.",
                        function() return self.db.class.actionTimeline.showSecondary end,
                        function(_, v) self.db.class.actionTimeline.showSecondary = v; self:UpdateDisplay() end,
                        { width = "full", order = 3 }
                    ),
                    showKeybindOnTimeline = OptionsFactory:CreateToggle(
                        L["Show Keybind Above Timeline Icons"] or "Show Keybind Above Timeline Icons",
                        L["Display the keybind (e.g. key or button) above the icons moving down the action timeline bar."] or
                        "Display the keybind (e.g. key or button) above the icons moving down the action timeline bar.",
                        function() return self.db.class.actionTimeline.showKeybindOnTimeline end,
                        function(_, v) self.db.class.actionTimeline.showKeybindOnTimeline = v; self:UpdateDisplay() end,
                        { width = "full", order = 4 }
                    ),
                },
            },
            presetLayout = {
                name = L["Preset Layout"] or "Preset Layout",
                type = "group",
                order = 10,
                inline = false,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        L["Enable Preset Layout"] or "Enable Preset Layout",
                        L["Use the preset layout system instead of the manual layout"] or
                        "Use the preset layout system instead of the manual layout",
                        function() return self.db.class.presetLayout.enabled end,
                        function(_, v)
                            self.db.class.presetLayout.enabled = v
                            self:UpdateFrameSettings()
                            notify()
                        end,
                        { width = "full", order = 0 }
                    ),
                    -- NOTE: we keep this toggle for parity with the Shaman bar options,
                    -- but we intentionally do not implement complex anchoring behavior yet.
                    autoAnchor = OptionsFactory:CreateToggle(
                        L["Auto Anchor to NAG Frame"] or "Auto Anchor to NAG Frame",
                        L["Automatically position the weave bar relative to the NAG primary frame"] or
                        "Automatically position the weave bar relative to the NAG primary frame",
                        function() return autoAnchorEnabled end,
                        function(_, v) autoAnchorEnabled = v; self:UpdateFrameSettings(); notify() end,
                        { width = "full", order = 1 }
                    ),
                    width = OptionsFactory:CreateRange(
                        L["Width"] or "Width",
                        L["Bar width"] or "Bar width",
                        function() return self.db.class.presetLayout.width end,
                        function(_, v) self.db.class.presetLayout.width = v; self:UpdateFrameSettings() end,
                        { min = 80, max = 1000, step = 1, order = 20 }
                    ),
                    height = OptionsFactory:CreateRange(
                        L["Height"] or "Height",
                        L["Bar height"] or "Bar height",
                        function() return self.db.class.presetLayout.height end,
                        function(_, v) self.db.class.presetLayout.height = v; self:UpdateFrameSettings() end,
                        { min = 10, max = 200, step = 1, order = 30 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        L["Alpha"] or "Alpha",
                        L["Bar transparency"] or "Bar transparency",
                        function() return self.db.class.presetLayout.alpha end,
                        function(_, v) self.db.class.presetLayout.alpha = v; self:UpdateFrameSettings() end,
                        { min = 0, max = 1, step = 0.05, order = 40 }
                    ),
                    xOffset = OptionsFactory:CreateRange(
                        L["X Offset"] or "X Offset",
                        L["X Offset"] or "X Offset",
                        function() return self.db.class.presetLayout.x end,
                        function(_, v) self.db.class.presetLayout.x = v; self:UpdateFrameSettings() end,
                        { min = -2000, max = 2000, step = 1, order = 60 }
                    ),
                    yOffset = OptionsFactory:CreateRange(
                        L["Y Offset"] or "Y Offset",
                        L["Y Offset"] or "Y Offset",
                        function() return self.db.class.presetLayout.y end,
                        function(_, v) self.db.class.presetLayout.y = v; self:UpdateFrameSettings() end,
                        { min = -2000, max = 2000, step = 1, order = 70 }
                    ),
                    showBorder = OptionsFactory:CreateToggle(
                        L["Show Border"] or "Show Border",
                        L["Show border around the bar"] or "Show border around the bar",
                        function() return self.db.class.presetLayout.showBorder end,
                        function(_, v) self.db.class.presetLayout.showBorder = v; self:UpdateFrameSettings() end,
                        { width = "full", order = 81 }
                    ),
                    borderThickness = OptionsFactory:CreateRange(
                        L["Border Thickness"] or "Border Thickness",
                        L["Border thickness"] or "Border thickness",
                        function() return self.db.class.presetLayout.borderThickness end,
                        function(_, v) self.db.class.presetLayout.borderThickness = v; self:UpdateFrameSettings() end,
                        { min = 1, max = 8, step = 1, order = 82 }
                    ),
                    borderColor = OptionsFactory:CreateColor(
                        L["Border Color"] or "Border Color",
                        L["Border color"] or "Border color",
                        colorGetter(self.db.class.presetLayout.borderColor),
                        colorSetter(self.db.class.presetLayout.borderColor),
                        { order = 83 }
                    ),
                    -- Countdown text removed (per request)
                    showSparkIcons = OptionsFactory:CreateToggle(
                        L["Show Spark Icons"] or "Show Spark Icons",
                        L["Use spell icons as spark markers (instead of lines)"] or
                        "Use spell icons as spark markers (instead of lines)",
                        function() return self.db.class.presetLayout.showSparkIcons end,
                        function(_, v) self.db.class.presetLayout.showSparkIcons = v; self:UpdateFrameSettings() end,
                        { width = "full", order = 90 }
                    ),
                    showKeybindOnWeaveBar = OptionsFactory:CreateToggle(
                        L["Show Keybind Above Bar Icons"] or "Show Keybind Above Bar Icons",
                        L["Display the keybind above the icons on the weave bar"] or
                        "Display the keybind above the icons on the weave bar",
                        function() return self.db.class.presetLayout.showKeybindOnWeaveBar end,
                        function(_, v) self.db.class.presetLayout.showKeybindOnWeaveBar = v; self:UpdateFrameSettings(); self:UpdateDisplay() end,
                        { width = "full", order = 91 }
                    ),
                    barHeightsHeader = OptionsFactory:CreateHeader(L["Bar Heights"] or "Bar Heights", { order = 100 }),
                    steadyBarHeightPct = OptionsFactory:CreateRange(
                        L["Steady Bar Height"] or "Steady Bar Height",
                        L["Steady window bar height (percent of total)"] or "Steady window bar height (percent of total)",
                        function() return self.db.class.presetLayout.steadyBarHeightPct end,
                        function(_, v) self.db.class.presetLayout.steadyBarHeightPct = v; self:UpdateFrameSettings() end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 101, isPercent = true }
                    ),
                    multiBarHeightPct = OptionsFactory:CreateRange(
                        L["Multi Bar Height"] or "Multi Bar Height",
                        L["Multi window bar height (percent of total)"] or "Multi window bar height (percent of total)",
                        function() return self.db.class.presetLayout.multiBarHeightPct end,
                        function(_, v) self.db.class.presetLayout.multiBarHeightPct = v; self:UpdateFrameSettings() end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 102, isPercent = true }
                    ),
                    meleeBarHeightPct = OptionsFactory:CreateRange(
                        L["Melee Bar Height"] or "Melee Bar Height",
                        L["Melee window bar height (percent of total)"] or "Melee window bar height (percent of total)",
                        function() return self.db.class.presetLayout.meleeBarHeightPct end,
                        function(_, v) self.db.class.presetLayout.meleeBarHeightPct = v; self:UpdateFrameSettings() end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 103, isPercent = true }
                    ),
                    colorsHeader = OptionsFactory:CreateHeader(L["Colors"] or "Colors", { order = 110 }),
                    colorBackground = OptionsFactory:CreateColor(
                        L["Background"] or "Background",
                        L["Background color"] or "Background color",
                        colorGetter(self.db.class.presetLayout.colors.background),
                        colorSetter(self.db.class.presetLayout.colors.background),
                        { order = 111 }
                    ),
                    colorSteady = OptionsFactory:CreateColor(
                        L["Steady Window"] or "Steady Window",
                        L["Steady window color"] or "Steady window color",
                        colorGetter(self.db.class.presetLayout.colors.steady),
                        colorSetter(self.db.class.presetLayout.colors.steady),
                        { order = 112 }
                    ),
                    colorMulti = OptionsFactory:CreateColor(
                        L["Multi Window"] or "Multi Window",
                        L["Multi window color"] or "Multi window color",
                        colorGetter(self.db.class.presetLayout.colors.multi),
                        colorSetter(self.db.class.presetLayout.colors.multi),
                        { order = 113 }
                    ),
                    colorMelee = OptionsFactory:CreateColor(
                        L["Melee Window"] or "Melee Window",
                        L["Melee window color"] or "Melee window color",
                        colorGetter(self.db.class.presetLayout.colors.melee),
                        colorSetter(self.db.class.presetLayout.colors.melee),
                        { order = 114 }
                    ),
                    colorUpcomingSteady = OptionsFactory:CreateColor(
                        L["Upcoming Steady"] or "Upcoming Steady",
                        L["Upcoming Steady window color"] or "Upcoming Steady window color",
                        colorGetter(self.db.class.presetLayout.colors.upcomingSteady),
                        colorSetter(self.db.class.presetLayout.colors.upcomingSteady),
                        { order = 115 }
                    ),
                    colorUpcomingMulti = OptionsFactory:CreateColor(
                        L["Upcoming Multi"] or "Upcoming Multi",
                        L["Upcoming Multi window color"] or "Upcoming Multi window color",
                        colorGetter(self.db.class.presetLayout.colors.upcomingMulti),
                        colorSetter(self.db.class.presetLayout.colors.upcomingMulti),
                        { order = 116 }
                    ),
                    colorUpcomingMelee = OptionsFactory:CreateColor(
                        L["Upcoming Melee"] or "Upcoming Melee",
                        L["Upcoming Melee window color"] or "Upcoming Melee window color",
                        colorGetter(self.db.class.presetLayout.colors.upcomingMelee),
                        colorSetter(self.db.class.presetLayout.colors.upcomingMelee),
                        { order = 117 }
                    ),
                    colorCastBar = OptionsFactory:CreateColor(
                        L["Cast Bar"] or "Cast Bar",
                        L["Cast bar color"] or "Cast bar color",
                        colorGetter(self.db.class.presetLayout.colors.castBar),
                        colorSetter(self.db.class.presetLayout.colors.castBar),
                        { order = 118 }
                    ),
                    colorCastSpark = OptionsFactory:CreateColor(
                        L["Cast Spark"] or "Cast Spark",
                        L["Cast bar spark color"] or "Cast bar spark color",
                        colorGetter(self.db.class.presetLayout.colors.castSpark),
                        colorSetter(self.db.class.presetLayout.colors.castSpark),
                        { order = 119 }
                    ),
                    -- Instant-unsafe and WAIT overlays removed (per request)
                }
            },
            manualLayout = {
                name = L["Manual Layout"] or "Manual Layout",
                type = "group",
                order = 20,
                inline = false,
                args = {
                    note = OptionsFactory:CreateHeader(
                        L["These settings apply when Preset Layout is disabled."] or
                        "These settings apply when Preset Layout is disabled.",
                        { order = 0 }
                    ),
                    width = OptionsFactory:CreateRange(
                        L["Width"] or "Width",
                        L["Bar width"] or "Bar width",
                        function() return self.db.class.bar.width end,
                        function(_, v) self.db.class.bar.width = v; self:UpdateFrameSettings() end,
                        { min = 80, max = 1000, step = 1, order = 1 }
                    ),
                    height = OptionsFactory:CreateRange(
                        L["Height"] or "Height",
                        L["Bar height"] or "Bar height",
                        function() return self.db.class.bar.height end,
                        function(_, v) self.db.class.bar.height = v; self:UpdateFrameSettings() end,
                        { min = 10, max = 200, step = 1, order = 2 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        L["Alpha"] or "Alpha",
                        L["Bar transparency"] or "Bar transparency",
                        function() return self.db.class.bar.alpha end,
                        function(_, v) self.db.class.bar.alpha = v; self:UpdateFrameSettings() end,
                        { min = 0, max = 1, step = 0.05, order = 3 }
                    ),
                    xOffset = OptionsFactory:CreateRange(
                        L["X Offset"] or "X Offset",
                        L["X Offset"] or "X Offset",
                        function() return self.db.class.bar.x end,
                        function(_, v) self.db.class.bar.x = v; self:UpdateFrameSettings() end,
                        { min = -2000, max = 2000, step = 1, order = 4 }
                    ),
                    yOffset = OptionsFactory:CreateRange(
                        L["Y Offset"] or "Y Offset",
                        L["Y Offset"] or "Y Offset",
                        function() return self.db.class.bar.y end,
                        function(_, v) self.db.class.bar.y = v; self:UpdateFrameSettings() end,
                        { min = -2000, max = 2000, step = 1, order = 5 }
                    ),
                    showBorder = OptionsFactory:CreateToggle(
                        L["Show Border"] or "Show Border",
                        L["Show border around the bar"] or "Show border around the bar",
                        function() return self.db.class.bar.showBorder end,
                        function(_, v) self.db.class.bar.showBorder = v; self:UpdateFrameSettings() end,
                        { width = "full", order = 6.1 }
                    ),
                    borderThickness = OptionsFactory:CreateRange(
                        L["Border Thickness"] or "Border Thickness",
                        L["Border thickness"] or "Border thickness",
                        function() return self.db.class.bar.borderThickness end,
                        function(_, v) self.db.class.bar.borderThickness = v; self:UpdateFrameSettings() end,
                        { min = 1, max = 8, step = 1, order = 6.2 }
                    ),
                    borderColor = OptionsFactory:CreateColor(
                        L["Border Color"] or "Border Color",
                        L["Border color"] or "Border color",
                        colorGetter(self.db.class.bar.borderColor),
                        colorSetter(self.db.class.bar.borderColor),
                        { order = 6.3 }
                    ),
                    -- Countdown text removed (per request)
                    showSparkIcons = OptionsFactory:CreateToggle(
                        L["Show Spark Icons"] or "Show Spark Icons",
                        L["Use spell icons as spark markers (instead of lines)"] or
                        "Use spell icons as spark markers (instead of lines)",
                        function() return self.db.class.bar.showSparkIcons end,
                        function(_, v) self.db.class.bar.showSparkIcons = v; self:UpdateFrameSettings() end,
                        { width = "full", order = 7 }
                    ),
                    showKeybindOnWeaveBar = OptionsFactory:CreateToggle(
                        L["Show Keybind Above Bar Icons"] or "Show Keybind Above Bar Icons",
                        L["Display the keybind above the icons on the weave bar"] or
                        "Display the keybind above the icons on the weave bar",
                        function() return self.db.class.bar.showKeybindOnWeaveBar end,
                        function(_, v) self.db.class.bar.showKeybindOnWeaveBar = v; self:UpdateFrameSettings(); self:UpdateDisplay() end,
                        { width = "full", order = 8 }
                    ),
                    barHeightsHeader = OptionsFactory:CreateHeader(L["Bar Heights"] or "Bar Heights", { order = 10 }),
                    steadyBarHeightPct = OptionsFactory:CreateRange(
                        L["Steady Bar Height"] or "Steady Bar Height",
                        L["Steady window bar height (percent of total)"] or "Steady window bar height (percent of total)",
                        function() return self.db.class.bar.steadyBarHeightPct end,
                        function(_, v) self.db.class.bar.steadyBarHeightPct = v; self:UpdateFrameSettings() end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 11, isPercent = true }
                    ),
                    multiBarHeightPct = OptionsFactory:CreateRange(
                        L["Multi Bar Height"] or "Multi Bar Height",
                        L["Multi window bar height (percent of total)"] or "Multi window bar height (percent of total)",
                        function() return self.db.class.bar.multiBarHeightPct end,
                        function(_, v) self.db.class.bar.multiBarHeightPct = v; self:UpdateFrameSettings() end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 12, isPercent = true }
                    ),
                    meleeBarHeightPct = OptionsFactory:CreateRange(
                        L["Melee Bar Height"] or "Melee Bar Height",
                        L["Melee window bar height (percent of total)"] or "Melee window bar height (percent of total)",
                        function() return self.db.class.bar.meleeBarHeightPct end,
                        function(_, v) self.db.class.bar.meleeBarHeightPct = v; self:UpdateFrameSettings() end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 13, isPercent = true }
                    ),
                    colorsHeader = OptionsFactory:CreateHeader(L["Colors"] or "Colors", { order = 20 }),
                    colorBackground = OptionsFactory:CreateColor(
                        L["Background"] or "Background",
                        L["Background color"] or "Background color",
                        colorGetter(self.db.class.bar.colors.background),
                        colorSetter(self.db.class.bar.colors.background),
                        { order = 21 }
                    ),
                    colorSteady = OptionsFactory:CreateColor(
                        L["Steady Window"] or "Steady Window",
                        L["Steady window color"] or "Steady window color",
                        colorGetter(self.db.class.bar.colors.steady),
                        colorSetter(self.db.class.bar.colors.steady),
                        { order = 22 }
                    ),
                    colorMulti = OptionsFactory:CreateColor(
                        L["Multi Window"] or "Multi Window",
                        L["Multi window color"] or "Multi window color",
                        colorGetter(self.db.class.bar.colors.multi),
                        colorSetter(self.db.class.bar.colors.multi),
                        { order = 23 }
                    ),
                    colorMelee = OptionsFactory:CreateColor(
                        L["Melee Window"] or "Melee Window",
                        L["Melee window color"] or "Melee window color",
                        colorGetter(self.db.class.bar.colors.melee),
                        colorSetter(self.db.class.bar.colors.melee),
                        { order = 24 }
                    ),
                    colorUpcomingSteady = OptionsFactory:CreateColor(
                        L["Upcoming Steady"] or "Upcoming Steady",
                        L["Upcoming Steady window color"] or "Upcoming Steady window color",
                        colorGetter(self.db.class.bar.colors.upcomingSteady),
                        colorSetter(self.db.class.bar.colors.upcomingSteady),
                        { order = 25 }
                    ),
                    colorUpcomingMulti = OptionsFactory:CreateColor(
                        L["Upcoming Multi"] or "Upcoming Multi",
                        L["Upcoming Multi window color"] or "Upcoming Multi window color",
                        colorGetter(self.db.class.bar.colors.upcomingMulti),
                        colorSetter(self.db.class.bar.colors.upcomingMulti),
                        { order = 26 }
                    ),
                    colorUpcomingMelee = OptionsFactory:CreateColor(
                        L["Upcoming Melee"] or "Upcoming Melee",
                        L["Upcoming Melee window color"] or "Upcoming Melee window color",
                        colorGetter(self.db.class.bar.colors.upcomingMelee),
                        colorSetter(self.db.class.bar.colors.upcomingMelee),
                        { order = 27 }
                    ),
                    colorCastBar = OptionsFactory:CreateColor(
                        L["Cast Bar"] or "Cast Bar",
                        L["Cast bar color"] or "Cast bar color",
                        colorGetter(self.db.class.bar.colors.castBar),
                        colorSetter(self.db.class.bar.colors.castBar),
                        { order = 28 }
                    ),
                    colorCastSpark = OptionsFactory:CreateColor(
                        L["Cast Spark"] or "Cast Spark",
                        L["Cast bar spark color"] or "Cast bar spark color",
                        colorGetter(self.db.class.bar.colors.castSpark),
                        colorSetter(self.db.class.bar.colors.castSpark),
                        { order = 29 }
                    ),
                    -- Instant-unsafe and WAIT overlays removed (per request)
                }
            },
        }
    }
end

return HunterWeaveBar

