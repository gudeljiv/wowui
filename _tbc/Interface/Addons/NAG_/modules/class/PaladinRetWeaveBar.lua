--- @module "NAG.PaladinRetWeaveBar"
--- Single-lane stacked weave timeline for TBC Retribution Paladin.
---
--- This module runs in parallel with PaladinRetTwistBar and provides:
--- - Base lane visuals (background + GCD)
--- - Guiders group (swing/twist/pre-GCD current + upcoming)
--- - Spell icons group (circular icon sparks with dynamic border ring)
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
local InCombatLockdown = _G.InCombatLockdown
local strlower = _G.strlower
local strtrim = _G.strtrim
local tinsert = _G.table.insert
local tremove = _G.table.remove
local tostring = _G.tostring
local tonumber = _G.tonumber
local floor = _G.math.floor
local max = _G.math.max
local min = _G.math.min
local abs = _G.math.abs
local stringMatch = _G.string.match

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local swingTimerLib = ns.LibClassicSwingTimerAPI
local OptionsFactory
local AceConfigDialog = ns.AceConfigDialog
local LSM = ns.LibSharedMedia

local DEFAULT_STATUSBAR_TEXTURE = "Interface\\TargetingFrame\\UI-StatusBar"
local DEFAULT_ICON_TEXTURE = "Interface\\Icons\\INV_Misc_QuestionMark"
local CIRCLE_MASK_TEXTURE = "Interface/CHARACTERFRAME/TempPortraitAlphaMask"

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        showBar = true,
        hideOutOfCombat = false,
        showOutOfCombatForDebug = false,
        showKeybindOnBar = false,

        -- Positioning
        autoAnchor = true,
        anchorSide = "bottom",
        point = "CENTER",
        x = 140,
        y = 20,
        userPositioned = false,

        -- Global timeline settings
        width = 220,
        alpha = 1.0,

        -- Base layer
        background = {
            enabled = true,
            color = { r = 0.0, g = 0.0, b = 0.0, a = 0.45 },
        },
        gcd = {
            enabled = true,
            height = 8,
            alpha = 1.0,
            sparkWidth = 2,
            color = { r = 0.40, g = 0.40, b = 0.40, a = 0.95 },
            sparkColor = { r = 0.0, g = 0.0, b = 0.0, a = 1.0 },
        },

        -- Guiders group (non-GCD/non-background bars)
        guiders = {
            enabled = true,
            baseHeight = 8,
            alpha = 1.0,
            sparkWidth = 2,
            layout = {
                style = "flat",
                texture = "Blizzard",
                blendMode = "BLEND",
            },
            colors = {
                retSwingBaseColor = { r = 0.08, g = 0.26, b = 0.10, a = 0.85 },
                retSwingBaseSparkColor = { r = 1.0, g = 1.0, b = 1.0, a = 0.95 },
                retTwistWindowColor = { r = 0.95, g = 0.45, b = 0.45, a = 0.58 },
                retTwistWindowSparkColor = { r = 0.60, g = 1.0, b = 0.60, a = 0.95 },
                retPreGCDWindowColor = { r = 0.45, g = 0.72, b = 1.0, a = 0.55 },
                retPreGCDWindowSparkColor = { r = 1.0, g = 0.55, b = 0.55, a = 0.95 },
                retSwingBaseUpcomingColor = { r = 0.06, g = 0.20, b = 0.08, a = 0.55 },
                retTwistWindowUpcomingColor = { r = 0.85, g = 0.35, b = 0.35, a = 0.42 },
                retPreGCDWindowUpcomingColor = { r = 0.35, g = 0.58, b = 0.85, a = 0.40 },
                retSwingBaseUpcomingSparkColor = { r = 0.85, g = 0.85, b = 0.85, a = 0.75 },
                retTwistWindowUpcomingSparkColor = { r = 0.45, g = 1.0, b = 0.45, a = 0.85 },
                retPreGCDWindowUpcomingSparkColor = { r = 1.0, g = 0.45, b = 0.45, a = 0.85 },
            },
        },

        -- Spell icons group
        spellIcons = {
            enabled = true,
            iconSize = 16,
            alpha = 1.0,
            ringScale = 1.2,
            showPreview = false,
            primaryLaneEnabled = true,
            fillerLaneEnabled = true,
            fillerSourcePosition = "left1",
            primaryOffsetX = 0,
            fillerOffsetX = 0,
            ringDefaultColor = { r = 0.0, g = 0.0, b = 0.0, a = 1.0 },
            ringOrangeColor = { r = 1.0, g = 0.55, b = 0.0, a = 1.0 },
            ringYellowColor = { r = 1.0, g = 1.0, b = 0.0, a = 1.0 },
            ringGreenColor = { r = 0.0, g = 1.0, b = 0.0, a = 1.0 },
            orangeThreshold = 3.0,
            yellowThreshold = 1.5,
            greenThreshold = 0.2,
        },

        -- Basis for future icon spell/timer definitions.
        -- Rule shape: { key = "ruleName", spellId = 20271, timerSource = "timeToReady", offsetSeconds = 0, enabled = true }
        iconRules = {},
    }
}

--- @class PaladinRetWeaveBar:CoreModule
local PaladinRetWeaveBar = NAG:CreateModule("PaladinRetWeaveBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "PALADIN",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    slashCommands = {
        ["nagret"] = {
            handler = "HandleNagRetCommand",
            help = "Open Ret bar options (/nagret [weave|twist|help])",
        },
    },
    hidden = function()
        return UnitClassBase("player") ~= "PALADIN"
    end,
    messageHandlers = {
        NAG_FRAME_UPDATED = true,
        NAG_PALADIN_BAR_SCALE_UPDATED = true,
    },
})

ns.PaladinRetWeaveBar = PaladinRetWeaveBar

-- ============================ LOCALS ============================
local frame
local clickCatcher
local guidersFrame
local spellIconsFrame

local lastUpdate = 0
local UPDATE_INTERVAL = 0.016

local retBackgroundBar
local retGCDBar
local retGCDSpark

local retSwingBaseBar
local retSwingBaseSpark
local retTwistWindowBar
local retTwistWindowSpark
local retPreGCDWindowBar
local retPreGCDWindowSpark
local retSwingBaseUpcomingBar
local retSwingBaseUpcomingSpark
local retTwistWindowUpcomingBar
local retTwistWindowUpcomingSpark
local retPreGCDWindowUpcomingBar
local retPreGCDWindowUpcomingSpark

local spellIconSlots = {}

-- Temporary option draft values for icon rule creation UI.
local iconRuleDraft = {
    key = "newRule",
    spellId = "20271",
    timerSource = "timeToReady",
    offsetSeconds = "0",
    enabled = true,
}
local selectedRuleIndex = 1
local SECONDS_EPSILON = 0.0001
local cooldownSmoothState = {}

-- ============================ HELPERS ============================
local function clamp01(value)
    if not value or value ~= value then
        return 0
    end
    if value < 0 then
        return 0
    end
    if value > 1 then
        return 1
    end
    return value
end

local function cloneColor(color, fallback)
    local source = color or fallback or { r = 1, g = 1, b = 1, a = 1 }
    return {
        r = source.r or 1,
        g = source.g or 1,
        b = source.b or 1,
        a = source.a or 1,
    }
end

local function colorWithAlpha(color, alphaMultiplier)
    local c = cloneColor(color)
    c.a = (c.a or 1) * (alphaMultiplier or 1)
    return c
end

local function setTextureColor(texture, color)
    if not texture or not color then
        return
    end
    texture:SetColorTexture(color.r or 1, color.g or 1, color.b or 1, color.a or 1)
end

local function setTextureVertexColor(texture, color)
    if not texture or not color then
        return
    end
    texture:SetVertexColor(color.r or 1, color.g or 1, color.b or 1, color.a or 1)
end

local function getStatusbarTextureValues()
    local values = { Blizzard = "Blizzard" }
    if LSM and LSM.HashTable then
        local statusbars = LSM:HashTable("statusbar")
        if statusbars then
            for name in pairs(statusbars) do
                if values[name] == nil then
                    values[name] = name
                end
            end
        end
    end
    return values
end

local function resolveStatusbarTexturePath(textureName)
    if textureName == "Blizzard" or textureName == nil then
        return DEFAULT_STATUSBAR_TEXTURE
    end
    if LSM and LSM.Fetch then
        local path = LSM:Fetch("statusbar", textureName, true)
        if path and path ~= "" then
            return path
        end
    end
    return DEFAULT_STATUSBAR_TEXTURE
end

local function applyBarLayerAppearance(texture, color, layout)
    if not texture or not color then
        return
    end
    local style = layout and layout.style or "flat"
    if style == "textured" then
        local texturePath = resolveStatusbarTexturePath(layout.texture)
        texture:SetTexture(texturePath)
        setTextureVertexColor(texture, color)
        texture:SetBlendMode(layout.blendMode or "BLEND")
        return
    end
    setTextureColor(texture, color)
    texture:SetBlendMode("BLEND")
end

local function setBarWidth(texture, width)
    if not texture then
        return
    end
    if not width or width <= 0 then
        texture:SetWidth(0)
        texture:Hide()
        return
    end
    texture:SetWidth(width)
    texture:Show()
end

local function clearParryHasteOverride()
    if not NAG then
        return
    end
    NAG._autoParryHasteNextSwingAt = nil
    NAG._autoParryHasteAppliedAt = nil
    NAG._autoParryHasteWeaponSpeed = nil
end

local function getMainhandSwing()
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        local speed, expiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
        if speed and expiration then
            local now = GetTime()
            local remaining = max(0, expiration - now)

            -- Local parry-haste override (no lib edits):
            -- Defensive parry haste shortens only the current swing deadline.
            -- Weapon speed is unchanged for future cycle projections.
            local overrideAt = NAG and NAG._autoParryHasteNextSwingAt or nil
            if overrideAt then
                local overrideRemaining = overrideAt - now
                if overrideRemaining <= 0 then
                    clearParryHasteOverride()
                elseif overrideRemaining < remaining then
                    remaining = overrideRemaining
                end
            end

            return remaining, speed
        end
    end
    local _, rawSwingLeft = NAG:AutoTimeToNext()
    return rawSwingLeft or 0, NAG:AutoSwingTime() or 0
end

local function getGCDDuration()
    if NAG.GCDTimeValue then
        local gcdDuration = NAG:GCDTimeValue()
        if gcdDuration and gcdDuration > 0 then
            return gcdDuration
        end
    end
    return 1.5
end

local function ensureLayout(layoutTable, fallback)
    if type(layoutTable) ~= "table" then
        layoutTable = {}
    end
    layoutTable.style = layoutTable.style or fallback.style
    layoutTable.texture = layoutTable.texture or fallback.texture
    layoutTable.blendMode = layoutTable.blendMode or fallback.blendMode
    return layoutTable
end

local function ensureColor(colorTable, fallback)
    if type(colorTable) ~= "table" then
        return cloneColor(fallback)
    end
    if colorTable.r == nil then colorTable.r = fallback.r end
    if colorTable.g == nil then colorTable.g = fallback.g end
    if colorTable.b == nil then colorTable.b = fallback.b end
    if colorTable.a == nil then colorTable.a = fallback.a end
    return colorTable
end

-- ============================ DATA NORMALIZATION ============================
--- Ensure grouped defaults are present for upgraded installs.
function PaladinRetWeaveBar:EnsureDefaults()
    local db = self.db.class
    local classDefaults = defaults.class

    db.background = db.background or {}
    db.background.enabled = db.background.enabled ~= false
    db.background.color = ensureColor(db.background.color, classDefaults.background.color)

    db.gcd = db.gcd or {}
    db.gcd.enabled = db.gcd.enabled ~= false
    db.gcd.height = db.gcd.height or classDefaults.gcd.height
    db.gcd.alpha = db.gcd.alpha or classDefaults.gcd.alpha
    db.gcd.sparkWidth = db.gcd.sparkWidth or classDefaults.gcd.sparkWidth
    db.gcd.color = ensureColor(db.gcd.color, classDefaults.gcd.color)
    db.gcd.sparkColor = ensureColor(db.gcd.sparkColor, classDefaults.gcd.sparkColor)

    db.guiders = db.guiders or {}
    db.guiders.enabled = db.guiders.enabled ~= false
    db.guiders.baseHeight = db.guiders.baseHeight or classDefaults.guiders.baseHeight
    db.guiders.alpha = db.guiders.alpha or classDefaults.guiders.alpha
    db.guiders.sparkWidth = db.guiders.sparkWidth or classDefaults.guiders.sparkWidth
    db.guiders.layout = ensureLayout(db.guiders.layout, classDefaults.guiders.layout)
    db.guiders.colors = db.guiders.colors or {}
    for key, color in pairs(classDefaults.guiders.colors) do
        db.guiders.colors[key] = ensureColor(db.guiders.colors[key], color)
    end

    db.spellIcons = db.spellIcons or {}
    db.spellIcons.enabled = db.spellIcons.enabled ~= false
    db.spellIcons.iconSize = db.spellIcons.iconSize or classDefaults.spellIcons.iconSize
    db.spellIcons.alpha = db.spellIcons.alpha or classDefaults.spellIcons.alpha
    db.spellIcons.ringScale = db.spellIcons.ringScale or classDefaults.spellIcons.ringScale
    if db.spellIcons.showPreview == nil then
        db.spellIcons.showPreview = classDefaults.spellIcons.showPreview
    end
    if db.spellIcons.primaryLaneEnabled == nil then
        db.spellIcons.primaryLaneEnabled = classDefaults.spellIcons.primaryLaneEnabled
    end
    if db.spellIcons.fillerLaneEnabled == nil then
        db.spellIcons.fillerLaneEnabled = classDefaults.spellIcons.fillerLaneEnabled
    end
    db.spellIcons.fillerSourcePosition = db.spellIcons.fillerSourcePosition or classDefaults.spellIcons.fillerSourcePosition
    db.spellIcons.primaryOffsetX = db.spellIcons.primaryOffsetX or classDefaults.spellIcons.primaryOffsetX
    db.spellIcons.fillerOffsetX = db.spellIcons.fillerOffsetX or classDefaults.spellIcons.fillerOffsetX
    db.spellIcons.orangeThreshold = db.spellIcons.orangeThreshold or classDefaults.spellIcons.orangeThreshold
    db.spellIcons.yellowThreshold = db.spellIcons.yellowThreshold or classDefaults.spellIcons.yellowThreshold
    db.spellIcons.greenThreshold = db.spellIcons.greenThreshold or classDefaults.spellIcons.greenThreshold
    db.spellIcons.ringDefaultColor = ensureColor(db.spellIcons.ringDefaultColor, classDefaults.spellIcons.ringDefaultColor)
    db.spellIcons.ringOrangeColor = ensureColor(db.spellIcons.ringOrangeColor, classDefaults.spellIcons.ringOrangeColor)
    db.spellIcons.ringYellowColor = ensureColor(db.spellIcons.ringYellowColor, classDefaults.spellIcons.ringYellowColor)
    db.spellIcons.ringGreenColor = ensureColor(db.spellIcons.ringGreenColor, classDefaults.spellIcons.ringGreenColor)

    if type(db.iconRules) ~= "table" then
        db.iconRules = {}
    end
end

-- ============================ FRAME POSITIONING ============================
--- Effective scale for Paladin bar frames: NAG display scale * universal Paladin bar scale.
local function GetPaladinBarEffectiveScale()
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local nagScale = (anchor and anchor ~= _G.UIParent and anchor:GetScale()) or 1
    local pm = NAG:GetModule("PaladinRetTwistModule", true)
    local barScale = (pm and pm.GetPaladinBarScale and pm:GetPaladinBarScale()) or 1
    return nagScale * barScale
end

function PaladinRetWeaveBar:UpdateFrameAnchor()
    if not frame then
        return
    end

    local db = self.db.class
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local anchorValid = anchor and anchor ~= _G.UIParent

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

    frame:SetParent(_G.UIParent)
    frame:ClearAllPoints()
    if db.anchorSide == "right" then
        local displayManager = NAG:GetModule("DisplayManager", true)
        if displayManager and displayManager.AnchorFrameToRightOfDisplay then
            displayManager:AnchorFrameToRightOfDisplay(frame, "BOTTOMLEFT", db.x or 8, db.y or 0)
        else
            frame:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", db.x or 8, db.y or 0)
        end
    else
        frame:SetPoint("TOP", anchor, "BOTTOM", db.x, db.y)
    end
    frame:SetScale(GetPaladinBarEffectiveScale())
end

function PaladinRetWeaveBar:UpdateVisibility()
    if not frame then
        return
    end

    local db = self.db.class
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:EnableMouse(true)
        frame:Show()
        if clickCatcher then
            clickCatcher:EnableMouse(true)
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

    if not db.showBar then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
        return
    end

    if NAG.IsTBCRetBarsEnabled and not NAG:IsTBCRetBarsEnabled() then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
        return
    end

    if db.hideOutOfCombat and not db.showOutOfCombatForDebug and not UnitAffectingCombat("player") then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
        return
    end

    local displayManager = NAG:GetModule("DisplayManager", true)
    local level = displayManager and displayManager.GetRecommendedClassBarFrameLevel
        and displayManager:GetRecommendedClassBarFrameLevel() or 50
    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel(level)
    frame:EnableMouse(false)
    frame:Show()
    if clickCatcher then
        clickCatcher:EnableMouse(false)
        clickCatcher:SetFrameLevel(level + 40)
    end
    if guidersFrame then
        guidersFrame:SetFrameStrata("MEDIUM")
        guidersFrame:SetFrameLevel(level + 4)
    end
    if spellIconsFrame then
        spellIconsFrame:SetFrameStrata("HIGH")
        spellIconsFrame:SetFrameLevel(level + 20)
    end

    self:UpdateFrameAnchor()
    frame:SetScript("OnUpdate", function(_, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            self:UpdateDisplay()
            lastUpdate = 0
        end
    end)
end

-- ============================ ICON SLOTS ============================
function PaladinRetWeaveBar:CreateSpellIconSlot()
    if not spellIconsFrame then
        return nil
    end

    local slot = CreateFrame("Frame", nil, spellIconsFrame)
    slot:SetSize(16, 16)
    slot:SetPoint("CENTER", spellIconsFrame, "LEFT", 0, 0)
    slot:Hide()

    slot.ring = slot:CreateTexture(nil, "ARTWORK", nil, 1)
    slot.ring:SetAllPoints()
    slot.ring:SetColorTexture(0, 0, 0, 1)
    local ringMask = slot:CreateMaskTexture()
    ringMask:SetTexture(CIRCLE_MASK_TEXTURE, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    ringMask:SetAllPoints()
    slot.ring:AddMaskTexture(ringMask)
    slot.ringMask = ringMask

    slot.icon = slot:CreateTexture(nil, "OVERLAY", nil, 2)
    slot.icon:SetPoint("CENTER", slot, "CENTER", 0, 0)
    slot.icon:SetSize(16, 16)
    slot.icon:SetTexture(DEFAULT_ICON_TEXTURE)
    slot.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    local iconMask = slot:CreateMaskTexture()
    iconMask:SetTexture(CIRCLE_MASK_TEXTURE, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    iconMask:SetAllPoints(slot.icon)
    slot.icon:AddMaskTexture(iconMask)
    slot.iconMask = iconMask

    local keybindText = slot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    keybindText:SetPoint("BOTTOM", slot, "TOP", 0, 2)
    keybindText:SetJustifyH("CENTER")
    keybindText:SetTextColor(1, 1, 0)
    keybindText:SetText("")
    keybindText:Hide()
    slot.keybindText = keybindText

    tinsert(spellIconSlots, slot)
    return slot
end

local function SetSparkKeybind(slot, showKeybind)
    if not slot or not slot.keybindText then return end
    if showKeybind and slot.spellId then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind then
            kb = KeybindManager:GetSpellKeybind(slot.spellId) or ""
        end
        slot.keybindText:SetText(kb)
        if kb ~= "" then
            slot.keybindText:Show()
        else
            slot.keybindText:Hide()
        end
    else
        slot.keybindText:SetText("")
        slot.keybindText:Hide()
    end
end

function PaladinRetWeaveBar:GetSpellIconSlot(index)
    if spellIconSlots[index] then
        return spellIconSlots[index]
    end
    return self:CreateSpellIconSlot()
end

function PaladinRetWeaveBar:HideAllSpellIconSlots()
    for i = 1, #spellIconSlots do
        SetSparkKeybind(spellIconSlots[i], false)
        spellIconSlots[i]:Hide()
    end
end

-- ============================ COLORS ============================
function PaladinRetWeaveBar:GetRingColor(secondsToCast)
    local spellIcons = self.db.class.spellIcons
    if not secondsToCast then
        return spellIcons.ringDefaultColor
    end
    if secondsToCast <= (spellIcons.greenThreshold or 0.2) then
        return spellIcons.ringGreenColor
    end
    if secondsToCast <= (spellIcons.yellowThreshold or 1.5) and secondsToCast > (spellIcons.greenThreshold or 0.2) then
        return spellIcons.ringYellowColor
    end
    if secondsToCast < (spellIcons.orangeThreshold or 3.0) and secondsToCast > (spellIcons.yellowThreshold or 1.5) then
        return spellIcons.ringOrangeColor
    end
    return spellIcons.ringDefaultColor
end

function PaladinRetWeaveBar:ApplyBarColors()
    self:EnsureDefaults()

    local db = self.db.class
    local guiders = db.guiders
    local guiderColors = guiders.colors
    local guiderLayout = guiders.layout
    local guiderAlpha = guiders.alpha or 1
    local gcdAlpha = (db.gcd and db.gcd.alpha) or 1

    if retBackgroundBar and db.background and db.background.enabled then
        setTextureColor(retBackgroundBar, db.background.color)
    end

    applyBarLayerAppearance(retGCDBar, colorWithAlpha(db.gcd.color, gcdAlpha), guiderLayout)
    setTextureColor(retGCDSpark, colorWithAlpha(db.gcd.sparkColor, gcdAlpha))

    applyBarLayerAppearance(retSwingBaseBar, colorWithAlpha(guiderColors.retSwingBaseColor, guiderAlpha), guiderLayout)
    setTextureColor(retSwingBaseSpark, colorWithAlpha(guiderColors.retSwingBaseSparkColor, guiderAlpha))
    applyBarLayerAppearance(retTwistWindowBar, colorWithAlpha(guiderColors.retTwistWindowColor, guiderAlpha), guiderLayout)
    setTextureColor(retTwistWindowSpark, colorWithAlpha(guiderColors.retTwistWindowSparkColor, guiderAlpha))
    applyBarLayerAppearance(retPreGCDWindowBar, colorWithAlpha(guiderColors.retPreGCDWindowColor, guiderAlpha), guiderLayout)
    setTextureColor(retPreGCDWindowSpark, colorWithAlpha(guiderColors.retPreGCDWindowSparkColor, guiderAlpha))

    applyBarLayerAppearance(retSwingBaseUpcomingBar, colorWithAlpha(guiderColors.retSwingBaseUpcomingColor, guiderAlpha), guiderLayout)
    setTextureColor(retSwingBaseUpcomingSpark, colorWithAlpha(guiderColors.retSwingBaseUpcomingSparkColor, guiderAlpha))
    applyBarLayerAppearance(retTwistWindowUpcomingBar, colorWithAlpha(guiderColors.retTwistWindowUpcomingColor, guiderAlpha), guiderLayout)
    setTextureColor(retTwistWindowUpcomingSpark, colorWithAlpha(guiderColors.retTwistWindowUpcomingSparkColor, guiderAlpha))
    applyBarLayerAppearance(retPreGCDWindowUpcomingBar, colorWithAlpha(guiderColors.retPreGCDWindowUpcomingColor, guiderAlpha), guiderLayout)
    setTextureColor(retPreGCDWindowUpcomingSpark, colorWithAlpha(guiderColors.retPreGCDWindowUpcomingSparkColor, guiderAlpha))
end

-- ============================ ICON RULE ENGINE ============================
function PaladinRetWeaveBar:GetRuleTimerSeconds(rule, snapshot)
    if not rule then
        return nil
    end

    local timerSource = rule.timerSource
    local spellId = tonumber(rule.spellId)
    local value

    if timerSource == "timeToSwing" then
        value = snapshot.rawSwingLeft
    elseif timerSource == "timeToTwistWindow" then
        value = snapshot.rawSwingLeft - 0.4
    elseif timerSource == "timeToPreGcdWindow" then
        value = snapshot.rawSwingLeft - 0.4 - snapshot.gcdDuration
    elseif timerSource == "timeToReady" then
        if spellId and NAG.SpellTimeToReady then
            value = NAG:SpellTimeToReady(spellId)
        end
    else
        return nil
    end

    if value == nil then
        return nil
    end
    if value < 0 then
        value = 0
    end
    value = value + (tonumber(rule.offsetSeconds) or 0)
    return value
end

function PaladinRetWeaveBar:ResolveRuleIconTexture(rule)
    local spellId = tonumber(rule.spellId)
    if spellId and NAG.Spell and NAG.Spell[spellId] and NAG.Spell[spellId].icon then
        return NAG.Spell[spellId].icon
    end
    return DEFAULT_ICON_TEXTURE
end

function PaladinRetWeaveBar:EvaluateIconRules(snapshot)
    local placements = {}
    local rules = self.db.class.iconRules
    local width = self.db.class.width or 220
    if type(rules) ~= "table" then
        return placements
    end
    if not snapshot.swingSpeed or snapshot.swingSpeed <= 0 then
        return placements
    end

    for i = 1, #rules do
        local rule = rules[i]
        if type(rule) == "table" and rule.enabled ~= false then
            local secondsToCast = self:GetRuleTimerSeconds(rule, snapshot)
            if secondsToCast and secondsToCast >= 0 then
                local progress = clamp01(secondsToCast / snapshot.swingSpeed)
                local xPosition = width * progress
                tinsert(placements, {
                    key = rule.key or ("rule" .. tostring(i)),
                    spellId = tonumber(rule.spellId),
                    secondsToCast = secondsToCast,
                    x = xPosition,
                    iconTexture = self:ResolveRuleIconTexture(rule),
                })
            end
        end
    end

    if #placements == 0 and self.db.class.spellIcons.showPreview then
        tinsert(placements, {
            key = "preview",
            spellId = 20271,
            secondsToCast = 1.2,
            x = width * clamp01(1.2 / max(snapshot.swingSpeed, 0.1)),
            iconTexture = (NAG.Spell and NAG.Spell[20271] and NAG.Spell[20271].icon) or DEFAULT_ICON_TEXTURE,
        })
    end

    return placements
end

-- ============================ PRIMARY/FILLER RESOLVERS ============================
local function getSpellTimeToReadyUnified(spellId)
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

local function clearSmoothedCooldown(stateKey)
    cooldownSmoothState[stateKey] = nil
end

function PaladinRetWeaveBar:GetSmoothedCooldown(stateKey, spellId, rawReadySeconds)
    local now = GetTime()
    local refreshInterval = 0.12
    local snapThreshold = 0.30
    local rawReady = max(0, rawReadySeconds or 0)

    local state = cooldownSmoothState[stateKey]
    if not state or state.spellId ~= spellId then
        cooldownSmoothState[stateKey] = {
            spellId = spellId,
            sampledReady = rawReady,
            sampledAt = now,
            nextRefreshAt = now + refreshInterval,
        }
        return rawReady
    end

    local predicted = max(0, state.sampledReady - (now - state.sampledAt))
    local shouldRefresh = false
    if now >= (state.nextRefreshAt or 0) then
        shouldRefresh = true
    end
    if abs(rawReady - predicted) > snapThreshold then
        shouldRefresh = true
    end
    if predicted <= 0 and rawReady > 0 then
        shouldRefresh = true
    end

    if shouldRefresh then
        state.sampledReady = rawReady
        state.sampledAt = now
        state.nextRefreshAt = now + refreshInterval
        return rawReady
    end

    return predicted
end

local function isPositionMatch(positionValue, expectedValue)
    if expectedValue == nil then
        return false
    end
    local positionText = strlower(tostring(positionValue or ""))
    local expectedText = strlower(tostring(expectedValue))
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

local function resolveIconTextureFromSpell(spellId)
    local numericId = tonumber(spellId)
    if numericId and NAG.Spell and NAG.Spell[numericId] and NAG.Spell[numericId].icon then
        return NAG.Spell[numericId].icon
    end
    if numericId and NAG.ResolveEffectiveSpellId then
        local resolvedId = NAG:ResolveEffectiveSpellId(numericId)
        if resolvedId and NAG.Spell and NAG.Spell[resolvedId] and NAG.Spell[resolvedId].icon then
            return NAG.Spell[resolvedId].icon
        end
    end
    if numericId and DataManager and DataManager.Get and DataManager.EntityTypes then
        local entry = DataManager:Get(numericId, DataManager.EntityTypes.SPELL)
        if entry and entry.icon then
            return entry.icon
        end
    end
    if numericId and _G.GetSpellTexture then
        local texture = _G.GetSpellTexture(numericId)
        if texture then
            return texture
        end
    end
    return DEFAULT_ICON_TEXTURE
end

local function getCustomHoldRemainingSeconds(spellId, position)
    local numericId = tonumber(spellId)
    if not numericId then
        return nil
    end
    local displayManager = NAG.GetModule and NAG:GetModule("DisplayManager", true) or nil
    if not displayManager or not displayManager.GetCustomHoldSwipe then
        return nil
    end
    local holdState = displayManager:GetCustomHoldSwipe(numericId, position or ns.SPELL_POSITIONS.PRIMARY)
    if not holdState or not holdState.endAt then
        return nil
    end
    return max(0, holdState.endAt - GetTime())
end

local function parseHoldSecondsFromOverlayText(spellId)
    local numericId = tonumber(spellId)
    if not numericId or not NAG.castOverlayTexts then
        return nil
    end
    local text = NAG.castOverlayTexts[numericId]
    if type(text) ~= "string" then
        return nil
    end
    local seconds = tonumber(stringMatch(text, "([%d%.]+)s"))
    if seconds and seconds >= 0 then
        return seconds
    end
    return nil
end

function PaladinRetWeaveBar:IsPrimarySealOrJudgeSpell(spellId)
    local id = tonumber(spellId)
    if not id then
        return false
    end

    if id == 20271 then
        return true
    end

    local soCId = NAG.RetTwistGetSoCSealId and NAG:RetTwistGetSoCSealId() or nil
    local twistSealId = NAG.RetTwistGetTwistSealId and NAG:RetTwistGetTwistSealId() or nil
    local soCrusaderId = NAG.RetTwistGetSoCrusaderSealId and NAG:RetTwistGetSoCrusaderSealId() or nil

    if soCId and id == soCId then
        return true
    end
    if twistSealId and id == twistSealId then
        return true
    end
    if soCrusaderId and id == soCrusaderId then
        return true
    end

    -- Common seal IDs used by ret/prot fallback logic.
    if id == 20166 or id == 21084 or id == 20154 then
        return true
    end
    return false
end

function PaladinRetWeaveBar:BuildLanePlacement(slotIndex, spellId, secondsToCast, snapshot, xOffset)
    if not snapshot.swingSpeed or snapshot.swingSpeed <= 0 then
        return nil
    end
    local timeToCast = max(0, secondsToCast or 0)
    local width = self.db.class.width or 220
    local progress = clamp01(timeToCast / snapshot.swingSpeed)
    return {
        slotIndex = slotIndex,
        spellId = spellId,
        secondsToCast = timeToCast,
        x = (width * progress) + (xOffset or 0),
        iconTexture = resolveIconTextureFromSpell(spellId),
    }
end

function PaladinRetWeaveBar:ResolvePrimaryActionPlacement(snapshot)
    local spellIcons = self.db.class.spellIcons
    if not spellIcons.primaryLaneEnabled then
        return nil
    end

    local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local nextSpellId = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
    if not nextSpellId then
        clearSmoothedCooldown("primary")
        return nil
    end

    local gcdLeft = max(0, NAG:GCDTimeToReady() or 0)
    local secondsToCast = gcdLeft
    local customHoldRemaining = getCustomHoldRemainingSeconds(nextSpellId, ns.SPELL_POSITIONS.PRIMARY)
    local overlayHoldRemaining = parseHoldSecondsFromOverlayText(nextSpellId)

    if customHoldRemaining and customHoldRemaining > SECONDS_EPSILON then
        secondsToCast = max(gcdLeft, customHoldRemaining)
    elseif overlayHoldRemaining and overlayHoldRemaining > SECONDS_EPSILON then
        secondsToCast = max(gcdLeft, overlayHoldRemaining)
    elseif nextSpellId == 35395 then
        -- Crusader Strike: respect both GCD gate and its own cooldown.
        local csReadyIn = getSpellTimeToReadyUnified(nextSpellId) or 0
        if csReadyIn < 0 then
            csReadyIn = 0
        end
        csReadyIn = self:GetSmoothedCooldown("primary", nextSpellId, csReadyIn)
        secondsToCast = max(gcdLeft, csReadyIn)
    elseif self:IsPrimarySealOrJudgeSpell(nextSpellId) then
        local readyIn = getSpellTimeToReadyUnified(nextSpellId) or 0
        readyIn = self:GetSmoothedCooldown("primary", nextSpellId, readyIn)
        secondsToCast = max(gcdLeft, readyIn)
    else
        local readyIn = getSpellTimeToReadyUnified(nextSpellId)
        if readyIn and readyIn >= 0 then
            readyIn = self:GetSmoothedCooldown("primary", nextSpellId, readyIn)
            secondsToCast = max(gcdLeft, readyIn)
        end
    end

    if abs(secondsToCast) < SECONDS_EPSILON then
        secondsToCast = 0
    end
    if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and false then
        print(string.format(
            "[WEAVE_BAR_PRIMARY] spell=%s gcdLeft=%.3f customHold=%.3f overlayHold=%.3f secondsToCast=%.3f swing=%.3f speed=%.3f",
            tostring(nextSpellId),
            gcdLeft or 0,
            customHoldRemaining or 0,
            overlayHoldRemaining or 0,
            secondsToCast or 0,
            snapshot.rawSwingLeft or 0,
            snapshot.swingSpeed or 0
        ))
    end
    return self:BuildLanePlacement(1, nextSpellId, secondsToCast, snapshot, spellIcons.primaryOffsetX)
end

function PaladinRetWeaveBar:ResolveFillerActionPlacement(snapshot)
    local spellIcons = self.db.class.spellIcons
    if not spellIcons.fillerLaneEnabled then
        return nil
    end

    local secondarySpells = NAG.secondarySpells
    if type(secondarySpells) ~= "table" then
        return nil
    end

    local fillerSource = spellIcons.fillerSourcePosition or "left1"
    local chosenSpellId
    for i = 1, #secondarySpells do
        local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(secondarySpells[i]) or nil
        if not norm then
            -- skip invalid or malformed entry
        elseif isPositionMatch(norm.position, fillerSource) then
            local spellId = norm.spellId and tonumber(norm.spellId)
            if spellId == 26573 or spellId == 879 then
                chosenSpellId = spellId
                break
            end
        end
    end

    if not chosenSpellId then
        clearSmoothedCooldown("filler")
        return nil
    end

    local gcdLeft = max(0, NAG:GCDTimeToReady() or 0)
    local readyIn = getSpellTimeToReadyUnified(chosenSpellId)
    if not readyIn or readyIn < 0 then
        readyIn = 0
    end
    readyIn = self:GetSmoothedCooldown("filler", chosenSpellId, readyIn)

    -- Fillers are gap actions; do not show if not ready by GCD release.
    if readyIn > (gcdLeft + SECONDS_EPSILON) then
        return nil
    end
    local secondsToCast = gcdLeft
    if abs(secondsToCast) < SECONDS_EPSILON then
        secondsToCast = 0
    end

    return self:BuildLanePlacement(2, chosenSpellId, secondsToCast, snapshot, spellIcons.fillerOffsetX)
end

-- ============================ DISPLAY UPDATE ============================
function PaladinRetWeaveBar:HideGuiders()
    setBarWidth(retSwingBaseBar, 0)
    setBarWidth(retTwistWindowBar, 0)
    setBarWidth(retPreGCDWindowBar, 0)
    setBarWidth(retSwingBaseUpcomingBar, 0)
    setBarWidth(retTwistWindowUpcomingBar, 0)
    setBarWidth(retPreGCDWindowUpcomingBar, 0)
    retSwingBaseSpark:Hide()
    retTwistWindowSpark:Hide()
    retPreGCDWindowSpark:Hide()
    retSwingBaseUpcomingSpark:Hide()
    retTwistWindowUpcomingSpark:Hide()
    retPreGCDWindowUpcomingSpark:Hide()
end

function PaladinRetWeaveBar:HideGcd()
    setBarWidth(retGCDBar, 0)
    retGCDSpark:Hide()
end

function PaladinRetWeaveBar:UpdateSpellIconDisplay(snapshot)
    local spellIcons = self.db.class.spellIcons
    self:HideAllSpellIconSlots()
    if not spellIcons.enabled then
        return
    end

    local placements = {}
    local primaryPlacement = self:ResolvePrimaryActionPlacement(snapshot)
    if primaryPlacement then
        placements[#placements + 1] = primaryPlacement
    end

    local fillerPlacement = self:ResolveFillerActionPlacement(snapshot)
    if fillerPlacement then
        placements[#placements + 1] = fillerPlacement
    end

    if #placements == 0 and spellIcons.showPreview then
        local previewPlacement = self:BuildLanePlacement(1, 20271, 1.2, snapshot, spellIcons.primaryOffsetX)
        if previewPlacement then
            placements[#placements + 1] = previewPlacement
        end
    end

    local iconSize = max(8, floor(spellIcons.iconSize or 16))
    local ringSize = max(iconSize, floor(iconSize * (spellIcons.ringScale or 1.2)))
    local iconAlpha = spellIcons.alpha or 1

    for i = 1, #placements do
        local placement = placements[i]
        local slot = self:GetSpellIconSlot(placement.slotIndex or i)
        if slot then
            local ringColor = colorWithAlpha(self:GetRingColor(placement.secondsToCast), iconAlpha)
            slot:SetSize(ringSize, ringSize)
            slot:ClearAllPoints()
            slot:SetPoint("CENTER", spellIconsFrame, "LEFT", placement.x, 0)

            slot.ring:SetAllPoints(slot)
            setTextureColor(slot.ring, ringColor)

            slot.icon:SetTexture(placement.iconTexture or DEFAULT_ICON_TEXTURE)
            slot.icon:SetSize(iconSize, iconSize)
            slot.icon:ClearAllPoints()
            slot.icon:SetPoint("CENTER", slot, "CENTER", 0, 0)
            setTextureVertexColor(slot.icon, { r = 1, g = 1, b = 1, a = iconAlpha })
            slot.spellId = placement.spellId
            slot:Show()
            SetSparkKeybind(slot, self.db.class.showKeybindOnBar)
            if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and false then
                print(string.format(
                    "[WEAVE_BAR_ICON] slot=%s spell=%s secondsToCast=%.3f x=%.1f",
                    tostring(placement.slotIndex or i),
                    tostring(placement.spellId),
                    placement.secondsToCast or 0,
                    placement.x or 0
                ))
            end
        end
    end
end

function PaladinRetWeaveBar:UpdateDisplay()
    if not frame then
        return
    end

    self:EnsureDefaults()

    local db = self.db.class
    local guiders = db.guiders
    local gcd = db.gcd
    local spellIcons = db.spellIcons

    local width = db.width or 220
    local guiderHeight = guiders.baseHeight or 8
    local gcdHeight = gcd.height or guiderHeight
    local ringSize = floor((spellIcons.iconSize or 16) * (spellIcons.ringScale or 1.2))
    local frameHeight = max(guiderHeight, gcdHeight, ringSize)

    frame:SetSize(width, frameHeight)
    frame:SetAlpha(db.alpha or 1.0)
    if guidersFrame then
        guidersFrame:SetAllPoints(frame)
    end
    if spellIconsFrame then
        spellIconsFrame:SetAllPoints(frame)
    end

    if retBackgroundBar then
        if db.background.enabled then
            retBackgroundBar:SetAllPoints(frame)
            setTextureColor(retBackgroundBar, db.background.color)
            retBackgroundBar:Show()
        else
            retBackgroundBar:Hide()
        end
    end

    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        self:ApplyBarColors()
        return
    end

    if not db.showBar then
        return
    end
    if NAG.IsTBCRetBarsEnabled and not NAG:IsTBCRetBarsEnabled() then
        frame:Hide()
        return
    end
    if db.hideOutOfCombat and not db.showOutOfCombatForDebug and not UnitAffectingCombat("player") then
        return
    end

    local rawSwingLeft, swingSpeed = getMainhandSwing()
    local gcdDuration = getGCDDuration()

    local snapshot = {
        rawSwingLeft = rawSwingLeft or 0,
        swingSpeed = swingSpeed or 0,
        gcdDuration = gcdDuration,
    }

    if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and false then
        local gcdLeft = max(0, NAG:GCDTimeToReady() or 0)
        print(string.format(
            "[WEAVE_BAR_DEBUG] swingLeft=%.3f speed=%.3f gcdDuration=%.3f gcdLeft=%.3f",
            snapshot.rawSwingLeft or 0,
            snapshot.swingSpeed or 0,
            snapshot.gcdDuration or 0,
            gcdLeft or 0
        ))
    end

    if not snapshot.swingSpeed or snapshot.swingSpeed <= 0 then
        self:HideGuiders()
        self:HideGcd()
        self:HideAllSpellIconSlots()
        return
    end

    local sparkWidth = max(1, floor(guiders.sparkWidth or 2))
    local gcdSparkWidth = max(1, floor(gcd.sparkWidth or 2))
    local swingProgress = clamp01(snapshot.rawSwingLeft / snapshot.swingSpeed)

    local function setCurrentBar(bar, spark, secondsToEvent, height, localSparkWidth)
        local laneWidth = width * clamp01(secondsToEvent / snapshot.swingSpeed)
        bar:SetHeight(height)
        bar:ClearAllPoints()
        bar:SetPoint("LEFT", guidersFrame, "LEFT", 0, 0)
        setBarWidth(bar, laneWidth)

        spark:SetSize(localSparkWidth, height)
        spark:ClearAllPoints()
        spark:SetPoint("CENTER", bar, "RIGHT", 0, 0)
        if laneWidth > 0 then
            spark:Show()
        else
            spark:Hide()
        end
        return laneWidth
    end

    local function setRangeBar(bar, spark, startSecondsBeforeSwing, endSecondsBeforeSwing, height, localSparkWidth, showLane)
        if not showLane then
            setBarWidth(bar, 0)
            spark:Hide()
            return
        end

        local startSeconds = max(0, startSecondsBeforeSwing or 0)
        local endSeconds = max(0, endSecondsBeforeSwing or 0)
        if endSeconds <= startSeconds then
            setBarWidth(bar, 0)
            spark:Hide()
            return
        end

        local startPoint = width * clamp01(startSeconds / snapshot.swingSpeed)
        local endPoint = width * clamp01(endSeconds / snapshot.swingSpeed)
        local laneWidth = endPoint - startPoint
        if laneWidth <= 0 then
            setBarWidth(bar, 0)
            spark:Hide()
            return
        end

        bar:SetHeight(height)
        bar:ClearAllPoints()
        bar:SetPoint("LEFT", guidersFrame, "LEFT", startPoint, 0)
        setBarWidth(bar, laneWidth)

        spark:SetSize(localSparkWidth, height)
        spark:ClearAllPoints()
        spark:SetPoint("CENTER", bar, "RIGHT", 0, 0)
        spark:Show()
    end

    local function setUpcomingBar(bar, spark, durationSeconds, height, localSparkWidth)
        if durationSeconds <= 0 then
            setBarWidth(bar, 0)
            spark:Hide()
            return
        end
        local startProgress = swingProgress
        local safeOffset = 0.02
        if startProgress < (1 - safeOffset) then
            startProgress = startProgress + safeOffset
        end
        local startPoint = width * startProgress
        local endTime = min(snapshot.rawSwingLeft + durationSeconds, snapshot.swingSpeed)
        local endPoint = width * clamp01(endTime / snapshot.swingSpeed)
        local upcomingWidth = endPoint - startPoint
        if upcomingWidth <= 0 then
            setBarWidth(bar, 0)
            spark:Hide()
            return
        end

        bar:SetHeight(height)
        bar:ClearAllPoints()
        bar:SetPoint("LEFT", guidersFrame, "LEFT", startPoint, 0)
        setBarWidth(bar, upcomingWidth)

        spark:SetSize(localSparkWidth, height)
        spark:ClearAllPoints()
        spark:SetPoint("CENTER", bar, "RIGHT", 0, 0)
        spark:Show()
    end

    if guiders.enabled then
        local swingLaneWidth = setCurrentBar(retSwingBaseBar, retSwingBaseSpark, snapshot.rawSwingLeft, guiderHeight, sparkWidth)
        local autoSparkVisible = swingLaneWidth and swingLaneWidth > 0
        -- Twist gap window: [swing-0.4, swing], moving with the swing spark.
        setRangeBar(
            retTwistWindowBar,
            retTwistWindowSpark,
            snapshot.rawSwingLeft - 0.4,
            snapshot.rawSwingLeft,
            guiderHeight,
            sparkWidth,
            autoSparkVisible
        )
        setCurrentBar(retPreGCDWindowBar, retPreGCDWindowSpark, snapshot.rawSwingLeft - 0.4 - snapshot.gcdDuration, guiderHeight, sparkWidth)

        setUpcomingBar(retSwingBaseUpcomingBar, retSwingBaseUpcomingSpark, snapshot.swingSpeed, guiderHeight, sparkWidth)
        setUpcomingBar(retTwistWindowUpcomingBar, retTwistWindowUpcomingSpark, snapshot.swingSpeed - 0.4, guiderHeight, sparkWidth)
        setUpcomingBar(retPreGCDWindowUpcomingBar, retPreGCDWindowUpcomingSpark, snapshot.swingSpeed - 0.4 - snapshot.gcdDuration, guiderHeight, sparkWidth)
    else
        self:HideGuiders()
    end

    if gcd.enabled then
        local gcdTimeToReady = NAG:GCDTimeToReady() or 0
        local gcdWidth = width * clamp01(gcdTimeToReady / snapshot.swingSpeed)
        retGCDBar:SetHeight(gcdHeight)
        retGCDBar:ClearAllPoints()
        retGCDBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
        setBarWidth(retGCDBar, gcdWidth)
        retGCDSpark:SetSize(gcdSparkWidth, gcdHeight)
        retGCDSpark:ClearAllPoints()
        retGCDSpark:SetPoint("CENTER", retGCDBar, "RIGHT", 0, 0)
        if gcdWidth > 0 then
            retGCDSpark:Show()
        else
            retGCDSpark:Hide()
        end
    else
        self:HideGcd()
    end

    self:UpdateSpellIconDisplay(snapshot)
end

-- ============================ UI BUILD ============================
function PaladinRetWeaveBar:CreateFrameUI()
    if frame then
        return
    end

    self:EnsureDefaults()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    local db = self.db.class

    frame = CreateFrame("Frame", "NAGPaladinRetWeaveBar", _G.UIParent)
    frame:SetSize(db.width or 220, db.guiders.baseHeight or 8)
    frame:SetPoint(db.point, _G.UIParent, db.point, db.x, db.y)
    frame:SetAlpha(db.alpha or 1.0)
    frame:Hide()
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())

    local moduleSelf = self
    frame:SetScript("OnDragStart", function()
        if InCombatLockdown and InCombatLockdown() then
            return
        end
        if not (NAG.IsAnyEditMode and NAG:IsAnyEditMode()) then
            return
        end
        frame:StartMoving()
    end)
    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        if not (moduleSelf and moduleSelf.db and moduleSelf.db.class) then
            return
        end
        local localDb = moduleSelf.db.class
        local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
        local anchorValid = anchor and anchor ~= _G.UIParent
        if anchorValid and localDb.autoAnchor then
            -- Anchor-relative: compute offset, save to db first (prevents snap-left), then re-anchor.
            local saved = false
            local offsetX, offsetY
            if localDb.anchorSide == "right" then
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
            if saved then
                if localDb.anchorSide == "right" then
                    localDb.point = "BOTTOMLEFT"
                    localDb.x = offsetX
                    localDb.y = offsetY
                else
                    localDb.point = "TOP"
                    localDb.x = offsetX
                    localDb.y = offsetY
                end
            end
            frame:SetParent(_G.UIParent)
            frame:ClearAllPoints()
            if saved then
                if localDb.anchorSide == "right" then
                    frame:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", offsetX, offsetY)
                else
                    frame:SetPoint("TOP", anchor, "BOTTOM", offsetX, offsetY)
                end
            else
                if localDb.anchorSide == "right" then
                    frame:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", localDb.x or 8, localDb.y or 0)
                else
                    frame:SetPoint("TOP", anchor, "BOTTOM", localDb.x, localDb.y)
                end
            end
        else
            -- Manual: save to db first (prevents snap-left), then leave frame where WoW put it.
            local point, _, _, x, y = frame:GetPoint(1)
            if point then
                localDb.point = point
            end
            localDb.x = x or localDb.x or 0
            localDb.y = y or localDb.y or 0
            localDb.userPositioned = true
            localDb.autoAnchor = false
        end
    end)

    clickCatcher = CreateFrame("Button", nil, frame)
    clickCatcher:SetPoint("TOPLEFT", frame, "TOPLEFT", -6, 6)
    clickCatcher:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 6, -6)
    clickCatcher:SetFrameLevel((frame:GetFrameLevel() or 0) + 20)
    clickCatcher:EnableMouse(true)
    clickCatcher:RegisterForDrag("LeftButton")
    clickCatcher:SetScript("OnDragStart", function()
        if frame and frame.StartMoving then
            frame:StartMoving()
        end
    end)
    clickCatcher:SetScript("OnDragStop", function()
        if frame and frame.StopMovingOrSizing then
            frame:StopMovingOrSizing()
            frame:GetScript("OnDragStop")(frame)
        end
    end)

    retBackgroundBar = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    retBackgroundBar:SetAllPoints(frame)
    retBackgroundBar:SetColorTexture(0, 0, 0, 0.45)

    guidersFrame = CreateFrame("Frame", nil, frame)
    guidersFrame:SetAllPoints(frame)

    spellIconsFrame = CreateFrame("Frame", nil, frame)
    spellIconsFrame:SetAllPoints(frame)

    retSwingBaseBar = guidersFrame:CreateTexture(nil, "ARTWORK", nil, -8)
    retSwingBaseBar:SetPoint("LEFT", guidersFrame, "LEFT", 0, 0)
    retSwingBaseBar:SetWidth(0)
    retSwingBaseSpark = guidersFrame:CreateTexture(nil, "OVERLAY", nil, -8)
    retSwingBaseSpark:SetTexture(nil)
    retSwingBaseSpark:SetBlendMode("BLEND")

    retTwistWindowBar = guidersFrame:CreateTexture(nil, "ARTWORK", nil, -7)
    retTwistWindowBar:SetPoint("LEFT", guidersFrame, "LEFT", 0, 0)
    retTwistWindowBar:SetWidth(0)
    retTwistWindowSpark = guidersFrame:CreateTexture(nil, "OVERLAY", nil, -7)
    retTwistWindowSpark:SetTexture(nil)
    retTwistWindowSpark:SetBlendMode("BLEND")

    retPreGCDWindowBar = guidersFrame:CreateTexture(nil, "ARTWORK", nil, -6)
    retPreGCDWindowBar:SetPoint("LEFT", guidersFrame, "LEFT", 0, 0)
    retPreGCDWindowBar:SetWidth(0)
    retPreGCDWindowSpark = guidersFrame:CreateTexture(nil, "OVERLAY", nil, -6)
    retPreGCDWindowSpark:SetTexture(nil)
    retPreGCDWindowSpark:SetBlendMode("BLEND")

    retSwingBaseUpcomingBar = guidersFrame:CreateTexture(nil, "ARTWORK", nil, -8)
    retSwingBaseUpcomingBar:SetPoint("LEFT", guidersFrame, "LEFT", 0, 0)
    retSwingBaseUpcomingBar:SetWidth(0)
    retSwingBaseUpcomingSpark = guidersFrame:CreateTexture(nil, "OVERLAY", nil, -8)
    retSwingBaseUpcomingSpark:SetTexture(nil)
    retSwingBaseUpcomingSpark:SetBlendMode("BLEND")

    retTwistWindowUpcomingBar = guidersFrame:CreateTexture(nil, "ARTWORK", nil, -7)
    retTwistWindowUpcomingBar:SetPoint("LEFT", guidersFrame, "LEFT", 0, 0)
    retTwistWindowUpcomingBar:SetWidth(0)
    retTwistWindowUpcomingSpark = guidersFrame:CreateTexture(nil, "OVERLAY", nil, -7)
    retTwistWindowUpcomingSpark:SetTexture(nil)
    retTwistWindowUpcomingSpark:SetBlendMode("BLEND")

    retPreGCDWindowUpcomingBar = guidersFrame:CreateTexture(nil, "ARTWORK", nil, -6)
    retPreGCDWindowUpcomingBar:SetPoint("LEFT", guidersFrame, "LEFT", 0, 0)
    retPreGCDWindowUpcomingBar:SetWidth(0)
    retPreGCDWindowUpcomingSpark = guidersFrame:CreateTexture(nil, "OVERLAY", nil, -6)
    retPreGCDWindowUpcomingSpark:SetTexture(nil)
    retPreGCDWindowUpcomingSpark:SetBlendMode("BLEND")

    retGCDBar = frame:CreateTexture(nil, "ARTWORK", nil, 6)
    retGCDBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    retGCDBar:SetWidth(0)
    retGCDSpark = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    retGCDSpark:SetTexture(nil)
    retGCDSpark:SetBlendMode("BLEND")

    self:ApplyBarColors()
end

-- ============================ LIFECYCLE ============================
function PaladinRetWeaveBar:ModuleInitialize()
    -- Keep init minimal; UI/runtime starts in ModuleEnable.
end

function PaladinRetWeaveBar:ModuleEnable()
    if UnitClassBase("player") ~= "PALADIN" then
        self:SetEnabledState(false)
        return
    end

    self:EnsureDefaults()
    if not frame then
        self:CreateFrameUI()
    end
    self:ApplyBarColors()
    self:UpdateVisibility()
    self:UpdateDisplay()
end

function PaladinRetWeaveBar:ModuleDisable()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
end

-- ============================ SLASH COMMANDS ============================
function PaladinRetWeaveBar:HandleNagRetCommand(input)
    local arg = strtrim(strlower(tostring(input or "")))
    if arg == "help" then
        self:Print("Ret options: /nagret, /nagret weave, /nagret twist")
        return
    end

    if not AceConfigDialog then
        self:Warn("Options dialog is unavailable")
        return
    end

    if arg == "twist" then
        AceConfigDialog:SelectGroup("NAG", "class", "PaladinRetTwistBar")
        AceConfigDialog:Open("NAG")
        return
    end

    AceConfigDialog:SelectGroup("NAG", "class", "PaladinRetWeaveBar")
    AceConfigDialog:Open("NAG")
end

-- ============================ EVENTS / MESSAGES ============================
function PaladinRetWeaveBar:PLAYER_ENTERING_WORLD()
    self:UpdateVisibility()
end

function PaladinRetWeaveBar:PLAYER_REGEN_DISABLED()
    self:UpdateVisibility()
end

function PaladinRetWeaveBar:PLAYER_REGEN_ENABLED()
    self:UpdateVisibility()
end

function PaladinRetWeaveBar:PLAYER_TARGET_CHANGED()
    self:UpdateDisplay()
end

function PaladinRetWeaveBar:NAG_FRAME_UPDATED()
    if self.db.class.autoAnchor then
        self:UpdateFrameAnchor()
    end
    self:UpdateVisibility()
end

function PaladinRetWeaveBar:NAG_PALADIN_BAR_SCALE_UPDATED()
    self:UpdateFrameAnchor()
end

PaladinRetWeaveBar.eventHandlers = {
    PLAYER_ENTERING_WORLD = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
}

-- ============================ ICON RULE OPTIONS HELPERS ============================
function PaladinRetWeaveBar:GetIconRuleValues()
    local values = {}
    local rules = self.db.class.iconRules or {}
    for i = 1, #rules do
        local rule = rules[i]
        if type(rule) == "table" then
            local key = rule.key or ("rule" .. tostring(i))
            local spellId = tostring(rule.spellId or "?")
            local timerSource = rule.timerSource or "timeToReady"
            local offset = tostring(rule.offsetSeconds or 0)
            local enabledLabel = rule.enabled == false and "off" or "on"
            values[i] = key .. " | spell:" .. spellId .. " | " .. timerSource .. " | offset:" .. offset .. " | " .. enabledLabel
        end
    end
    return values
end

function PaladinRetWeaveBar:GetIconRulesDescriptionText()
    local rules = self.db.class.iconRules or {}
    if #rules == 0 then
        return "No icon rules configured yet.\nUse the draft controls below to add rule basis entries."
    end
    local lines = {}
    for i = 1, #rules do
        local rule = rules[i]
        if type(rule) == "table" then
            local line = string.format(
                "%d) key=%s spellId=%s timerSource=%s offsetSeconds=%s enabled=%s",
                i,
                tostring(rule.key or "rule"),
                tostring(rule.spellId or "?"),
                tostring(rule.timerSource or "timeToReady"),
                tostring(rule.offsetSeconds or 0),
                tostring(rule.enabled ~= false)
            )
            tinsert(lines, line)
        end
    end
    return table.concat(lines, "\n")
end

function PaladinRetWeaveBar:AddDraftIconRule()
    local key = strtrim(tostring(iconRuleDraft.key or ""))
    if key == "" then
        self:Warn("Icon rule key is required")
        return
    end
    local spellId = tonumber(iconRuleDraft.spellId)
    if not spellId then
        self:Warn("Icon rule spellId must be numeric")
        return
    end
    local timerSource = tostring(iconRuleDraft.timerSource or "timeToReady")
    local offsetSeconds = tonumber(iconRuleDraft.offsetSeconds) or 0

    local rules = self.db.class.iconRules
    for i = 1, #rules do
        if rules[i].key == key then
            self:Warn("Icon rule key already exists: " .. key)
            return
        end
    end

    tinsert(rules, {
        key = key,
        spellId = spellId,
        timerSource = timerSource,
        offsetSeconds = offsetSeconds,
        enabled = iconRuleDraft.enabled ~= false,
    })
    selectedRuleIndex = #rules
    self:UpdateDisplay()
end

function PaladinRetWeaveBar:RemoveSelectedIconRule()
    local rules = self.db.class.iconRules
    if #rules == 0 then
        return
    end
    local index = tonumber(selectedRuleIndex) or 1
    if index < 1 or index > #rules then
        index = #rules
    end
    tremove(rules, index)
    selectedRuleIndex = min(index, max(1, #rules))
    self:UpdateDisplay()
end

-- ============================ OPTIONS ============================
function PaladinRetWeaveBar:GetOptions()
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end
    self:EnsureDefaults()

    local db = self.db.class

    local function colorGetter(color)
        return function()
            local c = color or { r = 1, g = 1, b = 1, a = 1 }
            return c.r or 1, c.g or 1, c.b or 1, c.a or 1
        end
    end

    local function colorSetter(color, refresh)
        return function(_, r, g, b, a)
            if not color then
                return
            end
            color.r, color.g, color.b, color.a = r, g, b, a
            self:ApplyBarColors()
            if refresh ~= false then
                self:UpdateDisplay()
            end
        end
    end

    local timerSourceValues = {
        timeToSwing = "timeToSwing",
        timeToTwistWindow = "timeToTwistWindow",
        timeToPreGcdWindow = "timeToPreGcdWindow",
        timeToReady = "timeToReady(spellId)",
    }

    return {
        type = "group",
        name = "Ret Weave Bar",
        order = 27,
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
                        "Enable/disable the Ret Weave bar.",
                        function() return self:GetSetting("class", "enabled") end,
                        function(_, value)
                            self:SetSetting("class", "enabled", value)
                            if value then
                                self:Enable()
                            else
                                self:Disable()
                            end
                        end,
                        { order = 1 }
                    ),
                    showBar = OptionsFactory:CreateToggle(
                        "Show Bar",
                        "Show or hide the Ret Weave bar.",
                        function() return self:GetSetting("class", "showBar") end,
                        function(_, value)
                            self:SetSetting("class", "showBar", value)
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
                            self:UpdateDisplay()
                        end,
                        { order = 3 }
                    ),
                    hideOutOfCombat = OptionsFactory:CreateToggle(
                        "Hide Out of Combat",
                        "Hide bar while out of combat.",
                        function() return self:GetSetting("class", "hideOutOfCombat") end,
                        function(_, value)
                            self:SetSetting("class", "hideOutOfCombat", value)
                            self:UpdateVisibility()
                        end,
                        { order = 3 }
                    ),
                    showOutOfCombatForDebug = OptionsFactory:CreateToggle(
                        "Show Out of Combat (Debug)",
                        "Keep bar visible out of combat for debugging.",
                        function() return self:GetSetting("class", "showOutOfCombatForDebug") end,
                        function(_, value)
                            self:SetSetting("class", "showOutOfCombatForDebug", value)
                            self:UpdateVisibility()
                        end,
                        { order = 4 }
                    ),
                    autoAnchor = OptionsFactory:CreateToggle(
                        "Auto Anchor to NAG",
                        "Anchor relative to NAG main display frame.",
                        function() return self:GetSetting("class", "autoAnchor") end,
                        function(_, value)
                            self:SetSetting("class", "autoAnchor", value)
                            self:UpdateVisibility()
                        end,
                        { order = 5 }
                    ),
                    anchorSide = OptionsFactory:CreateSelect(
                        "Anchor Side",
                        "When auto-anchored: below NAG frame or to the right.",
                        function() return self:GetSetting("class", "anchorSide") or "bottom" end,
                        function(_, value)
                            self:SetSetting("class", "anchorSide", value)
                            self:UpdateVisibility()
                        end,
                        { order = 6, values = { bottom = "Below NAG frame", right = "Right of NAG frame" } }
                    ),
                    width = OptionsFactory:CreateRange(
                        "Timeline Width",
                        "Shared width used by all groups and icon placements.",
                        function() return self:GetSetting("class", "width") end,
                        function(_, value)
                            self:SetSetting("class", "width", value)
                            self:UpdateDisplay()
                        end,
                        { min = 80, max = 600, step = 1, order = 7 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        "Global Alpha",
                        "Master alpha for the full timeline frame.",
                        function() return self:GetSetting("class", "alpha") end,
                        function(_, value)
                            self:SetSetting("class", "alpha", value)
                            self:UpdateDisplay()
                        end,
                        { min = 0.1, max = 1.0, step = 0.05, order = 8 }
                    ),
                    x = OptionsFactory:CreateRange(
                        "X Offset",
                        "Horizontal offset.",
                        function() return self:GetSetting("class", "x") end,
                        function(_, value)
                            self:SetSetting("class", "x", value)
                            self:UpdateVisibility()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 9 }
                    ),
                    y = OptionsFactory:CreateRange(
                        "Y Offset",
                        "Vertical offset.",
                        function() return self:GetSetting("class", "y") end,
                        function(_, value)
                            self:SetSetting("class", "y", value)
                            self:UpdateVisibility()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 10 }
                    ),
                },
            },

            background = {
                type = "group",
                name = "Background",
                order = 2,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        "Show Background",
                        "Show full-width background lane.",
                        function() return db.background.enabled end,
                        function(_, value)
                            db.background.enabled = value
                            self:UpdateDisplay()
                        end,
                        { order = 1 }
                    ),
                    color = OptionsFactory:CreateColor(
                        "Background Color",
                        "Color of the full-width background lane.",
                        colorGetter(db.background.color),
                        colorSetter(db.background.color),
                        { hasAlpha = true, order = 2 }
                    ),
                },
            },

            gcd = {
                type = "group",
                name = "GCD",
                order = 3,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        "Enable GCD Lane",
                        "Show/hide the top-level GCD lane.",
                        function() return db.gcd.enabled end,
                        function(_, value)
                            db.gcd.enabled = value
                            self:UpdateDisplay()
                        end,
                        { order = 1 }
                    ),
                    height = OptionsFactory:CreateRange(
                        "GCD Height",
                        "Height of the GCD lane.",
                        function() return db.gcd.height end,
                        function(_, value)
                            db.gcd.height = value
                            self:UpdateDisplay()
                        end,
                        { min = 2, max = 40, step = 1, order = 2 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        "GCD Alpha",
                        "Alpha multiplier for GCD lane and spark.",
                        function() return db.gcd.alpha end,
                        function(_, value)
                            db.gcd.alpha = value
                            self:ApplyBarColors()
                            self:UpdateDisplay()
                        end,
                        { min = 0.1, max = 1.0, step = 0.05, order = 3 }
                    ),
                    sparkWidth = OptionsFactory:CreateRange(
                        "GCD Spark Width",
                        "Width of the GCD spark marker.",
                        function() return db.gcd.sparkWidth end,
                        function(_, value)
                            db.gcd.sparkWidth = value
                            self:UpdateDisplay()
                        end,
                        { min = 1, max = 8, step = 1, order = 4 }
                    ),
                    color = OptionsFactory:CreateColor(
                        "GCD Color",
                        "Color of the GCD lane.",
                        colorGetter(db.gcd.color),
                        colorSetter(db.gcd.color),
                        { hasAlpha = true, order = 5 }
                    ),
                    sparkColor = OptionsFactory:CreateColor(
                        "GCD Spark Color",
                        "Color of the GCD spark marker.",
                        colorGetter(db.gcd.sparkColor),
                        colorSetter(db.gcd.sparkColor),
                        { hasAlpha = true, order = 6 }
                    ),
                },
            },

            guiders = {
                type = "group",
                name = "Guiders",
                order = 4,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        "Enable Guiders Group",
                        "Toggle all non-GCD/non-background guide lanes.",
                        function() return db.guiders.enabled end,
                        function(_, value)
                            db.guiders.enabled = value
                            self:UpdateDisplay()
                        end,
                        { order = 1 }
                    ),
                    baseHeight = OptionsFactory:CreateRange(
                        "Base Height",
                        "Shared bar height for guider lanes.",
                        function() return db.guiders.baseHeight end,
                        function(_, value)
                            db.guiders.baseHeight = value
                            self:UpdateDisplay()
                        end,
                        { min = 2, max = 40, step = 1, order = 2 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        "Guiders Alpha",
                        "Alpha multiplier for guider bars and sparks.",
                        function() return db.guiders.alpha end,
                        function(_, value)
                            db.guiders.alpha = value
                            self:ApplyBarColors()
                            self:UpdateDisplay()
                        end,
                        { min = 0.1, max = 1.0, step = 0.05, order = 3 }
                    ),
                    sparkWidth = OptionsFactory:CreateRange(
                        "Guiders Spark Width",
                        "Shared spark width for guider lanes.",
                        function() return db.guiders.sparkWidth end,
                        function(_, value)
                            db.guiders.sparkWidth = value
                            self:UpdateDisplay()
                        end,
                        { min = 1, max = 8, step = 1, order = 4 }
                    ),
                    layoutStyle = OptionsFactory:CreateSelect(
                        "Layout Style",
                        "Choose flat or textured rendering for guider bars.",
                        function() return db.guiders.layout.style end,
                        function(_, value)
                            db.guiders.layout.style = value
                            self:ApplyBarColors()
                            self:UpdateDisplay()
                        end,
                        { order = 5, values = { flat = "Flat Color", textured = "Textured (Statusbar)" } }
                    ),
                    layoutTexture = OptionsFactory:CreateSelect(
                        "Layout Texture",
                        "Statusbar texture used when layout is textured.",
                        function() return db.guiders.layout.texture end,
                        function(_, value)
                            db.guiders.layout.texture = value
                            self:ApplyBarColors()
                            self:UpdateDisplay()
                        end,
                        {
                            order = 6,
                            dialogControl = "LSM30_Statusbar",
                            values = getStatusbarTextureValues,
                            disabled = function()
                                return db.guiders.layout.style ~= "textured"
                            end,
                        }
                    ),
                    layoutBlendMode = OptionsFactory:CreateSelect(
                        "Layout Blend Mode",
                        "Blend mode for textured guider bars.",
                        function() return db.guiders.layout.blendMode end,
                        function(_, value)
                            db.guiders.layout.blendMode = value
                            self:ApplyBarColors()
                            self:UpdateDisplay()
                        end,
                        {
                            order = 7,
                            values = { BLEND = "BLEND", ADD = "ADD", MOD = "MOD", ALPHAKEY = "ALPHAKEY" },
                            disabled = function()
                                return db.guiders.layout.style ~= "textured"
                            end,
                        }
                    ),

                    colorsHeader = OptionsFactory:CreateHeader("Current Window Colors", { order = 20 }),
                    retSwingBaseColor = OptionsFactory:CreateColor(
                        "retSwingBaseBar",
                        "Color for swing base lane.",
                        colorGetter(db.guiders.colors.retSwingBaseColor),
                        colorSetter(db.guiders.colors.retSwingBaseColor),
                        { hasAlpha = true, order = 21 }
                    ),
                    retSwingBaseSparkColor = OptionsFactory:CreateColor(
                        "retSwingBaseSpark",
                        "Color for swing base spark.",
                        colorGetter(db.guiders.colors.retSwingBaseSparkColor),
                        colorSetter(db.guiders.colors.retSwingBaseSparkColor),
                        { hasAlpha = true, order = 22 }
                    ),
                    retTwistWindowColor = OptionsFactory:CreateColor(
                        "retTwistWindowBar",
                        "Color for twist window lane.",
                        colorGetter(db.guiders.colors.retTwistWindowColor),
                        colorSetter(db.guiders.colors.retTwistWindowColor),
                        { hasAlpha = true, order = 23 }
                    ),
                    retTwistWindowSparkColor = OptionsFactory:CreateColor(
                        "retTwistWindowSpark",
                        "Color for twist window spark.",
                        colorGetter(db.guiders.colors.retTwistWindowSparkColor),
                        colorSetter(db.guiders.colors.retTwistWindowSparkColor),
                        { hasAlpha = true, order = 24 }
                    ),
                    retPreGCDWindowColor = OptionsFactory:CreateColor(
                        "retPreGCDWindowBar",
                        "Color for pre-GCD window lane.",
                        colorGetter(db.guiders.colors.retPreGCDWindowColor),
                        colorSetter(db.guiders.colors.retPreGCDWindowColor),
                        { hasAlpha = true, order = 25 }
                    ),
                    retPreGCDWindowSparkColor = OptionsFactory:CreateColor(
                        "retPreGCDWindowSpark",
                        "Color for pre-GCD window spark.",
                        colorGetter(db.guiders.colors.retPreGCDWindowSparkColor),
                        colorSetter(db.guiders.colors.retPreGCDWindowSparkColor),
                        { hasAlpha = true, order = 26 }
                    ),

                    upcomingHeader = OptionsFactory:CreateHeader("Upcoming (Next Swing) Colors", { order = 30 }),
                    retSwingBaseUpcomingColor = OptionsFactory:CreateColor(
                        "retSwingBaseUpcomingBar",
                        "Color for upcoming swing base bar.",
                        colorGetter(db.guiders.colors.retSwingBaseUpcomingColor),
                        colorSetter(db.guiders.colors.retSwingBaseUpcomingColor),
                        { hasAlpha = true, order = 31 }
                    ),
                    retSwingBaseUpcomingSparkColor = OptionsFactory:CreateColor(
                        "retSwingBaseUpcomingSpark",
                        "Color for upcoming swing base spark.",
                        colorGetter(db.guiders.colors.retSwingBaseUpcomingSparkColor),
                        colorSetter(db.guiders.colors.retSwingBaseUpcomingSparkColor),
                        { hasAlpha = true, order = 32 }
                    ),
                    retTwistWindowUpcomingColor = OptionsFactory:CreateColor(
                        "retTwistWindowUpcomingBar",
                        "Color for upcoming twist window bar.",
                        colorGetter(db.guiders.colors.retTwistWindowUpcomingColor),
                        colorSetter(db.guiders.colors.retTwistWindowUpcomingColor),
                        { hasAlpha = true, order = 33 }
                    ),
                    retTwistWindowUpcomingSparkColor = OptionsFactory:CreateColor(
                        "retTwistWindowUpcomingSpark",
                        "Color for upcoming twist window spark.",
                        colorGetter(db.guiders.colors.retTwistWindowUpcomingSparkColor),
                        colorSetter(db.guiders.colors.retTwistWindowUpcomingSparkColor),
                        { hasAlpha = true, order = 34 }
                    ),
                    retPreGCDWindowUpcomingColor = OptionsFactory:CreateColor(
                        "retPreGCDWindowUpcomingBar",
                        "Color for upcoming pre-GCD window bar.",
                        colorGetter(db.guiders.colors.retPreGCDWindowUpcomingColor),
                        colorSetter(db.guiders.colors.retPreGCDWindowUpcomingColor),
                        { hasAlpha = true, order = 35 }
                    ),
                    retPreGCDWindowUpcomingSparkColor = OptionsFactory:CreateColor(
                        "retPreGCDWindowUpcomingSpark",
                        "Color for upcoming pre-GCD window spark.",
                        colorGetter(db.guiders.colors.retPreGCDWindowUpcomingSparkColor),
                        colorSetter(db.guiders.colors.retPreGCDWindowUpcomingSparkColor),
                        { hasAlpha = true, order = 36 }
                    ),
                },
            },

            spellIcons = {
                type = "group",
                name = "Spell Icons",
                order = 5,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        "Enable Spell Icons Group",
                        "Show/hide all icon sparks and rings.",
                        function() return db.spellIcons.enabled end,
                        function(_, value)
                            db.spellIcons.enabled = value
                            self:UpdateDisplay()
                        end,
                        { order = 1 }
                    ),
                    primaryLaneEnabled = OptionsFactory:CreateToggle(
                        "Primary Action Lane",
                        "Show primary icon spark from NAG.nextSpell.",
                        function() return db.spellIcons.primaryLaneEnabled end,
                        function(_, value)
                            db.spellIcons.primaryLaneEnabled = value
                            self:UpdateDisplay()
                        end,
                        { order = 1.1 }
                    ),
                    fillerLaneEnabled = OptionsFactory:CreateToggle(
                        "Filler Action Lane",
                        "Show parallel filler icon spark from secondary placeholder suggestions.",
                        function() return db.spellIcons.fillerLaneEnabled end,
                        function(_, value)
                            db.spellIcons.fillerLaneEnabled = value
                            self:UpdateDisplay()
                        end,
                        { order = 1.2 }
                    ),
                    fillerSourcePosition = OptionsFactory:CreateSelect(
                        "Filler Source Position",
                        "Secondary slot source used to track fillers.",
                        function() return db.spellIcons.fillerSourcePosition end,
                        function(_, value)
                            db.spellIcons.fillerSourcePosition = value
                            self:UpdateDisplay()
                        end,
                        {
                            order = 1.3,
                            values = {
                                left1 = "left1",
                                right1 = "right1",
                            },
                        }
                    ),
                    iconSize = OptionsFactory:CreateRange(
                        "Icon Size",
                        "Shared icon spark size.",
                        function() return db.spellIcons.iconSize end,
                        function(_, value)
                            db.spellIcons.iconSize = value
                            self:UpdateDisplay()
                        end,
                        { min = 8, max = 48, step = 1, order = 2 }
                    ),
                    primaryOffsetX = OptionsFactory:CreateRange(
                        "Primary X Offset",
                        "Horizontal offset for the primary action icon lane.",
                        function() return db.spellIcons.primaryOffsetX end,
                        function(_, value)
                            db.spellIcons.primaryOffsetX = value
                            self:UpdateDisplay()
                        end,
                        { min = -80, max = 80, step = 1, order = 2.1 }
                    ),
                    fillerOffsetX = OptionsFactory:CreateRange(
                        "Filler X Offset",
                        "Horizontal offset for the filler action icon lane.",
                        function() return db.spellIcons.fillerOffsetX end,
                        function(_, value)
                            db.spellIcons.fillerOffsetX = value
                            self:UpdateDisplay()
                        end,
                        { min = -80, max = 80, step = 1, order = 2.2 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        "Icon Group Alpha",
                        "Alpha multiplier for icon sparks and rings.",
                        function() return db.spellIcons.alpha end,
                        function(_, value)
                            db.spellIcons.alpha = value
                            self:UpdateDisplay()
                        end,
                        { min = 0.1, max = 1.0, step = 0.05, order = 3 }
                    ),
                    ringScale = OptionsFactory:CreateRange(
                        "Ring Scale",
                        "Ring size multiplier relative to icon size.",
                        function() return db.spellIcons.ringScale end,
                        function(_, value)
                            db.spellIcons.ringScale = value
                            self:UpdateDisplay()
                        end,
                        { min = 1.0, max = 2.0, step = 0.05, order = 4 }
                    ),
                    showPreview = OptionsFactory:CreateToggle(
                        "Preview/Test Icon",
                        "Show a preview icon when no rules are configured.",
                        function() return db.spellIcons.showPreview end,
                        function(_, value)
                            db.spellIcons.showPreview = value
                            self:UpdateDisplay()
                        end,
                        { order = 5 }
                    ),
                    thresholdHeader = OptionsFactory:CreateHeader("Ring Thresholds", { order = 10 }),
                    orangeThreshold = OptionsFactory:CreateRange(
                        "Orange Threshold",
                        "Ring turns orange when secondsToCast is less than this and above yellow threshold.",
                        function() return db.spellIcons.orangeThreshold end,
                        function(_, value)
                            db.spellIcons.orangeThreshold = value
                            self:UpdateDisplay()
                        end,
                        { min = 0.3, max = 10.0, step = 0.1, order = 11 }
                    ),
                    yellowThreshold = OptionsFactory:CreateRange(
                        "Yellow Threshold",
                        "Ring turns yellow when secondsToCast is at or below this and above green threshold.",
                        function() return db.spellIcons.yellowThreshold end,
                        function(_, value)
                            db.spellIcons.yellowThreshold = value
                            self:UpdateDisplay()
                        end,
                        { min = 0.2, max = 10.0, step = 0.1, order = 12 }
                    ),
                    greenThreshold = OptionsFactory:CreateRange(
                        "Green Threshold",
                        "Ring turns green when secondsToCast is at or below this.",
                        function() return db.spellIcons.greenThreshold end,
                        function(_, value)
                            db.spellIcons.greenThreshold = value
                            self:UpdateDisplay()
                        end,
                        { min = 0.0, max = 5.0, step = 0.05, order = 13 }
                    ),
                    ringDefaultColor = OptionsFactory:CreateColor(
                        "Default Ring Color",
                        "Ring color when outside threshold windows.",
                        colorGetter(db.spellIcons.ringDefaultColor),
                        colorSetter(db.spellIcons.ringDefaultColor),
                        { hasAlpha = true, order = 14 }
                    ),
                    ringOrangeColor = OptionsFactory:CreateColor(
                        "Orange Ring Color",
                        "Ring color when < orange and > yellow thresholds.",
                        colorGetter(db.spellIcons.ringOrangeColor),
                        colorSetter(db.spellIcons.ringOrangeColor),
                        { hasAlpha = true, order = 15 }
                    ),
                    ringYellowColor = OptionsFactory:CreateColor(
                        "Yellow Ring Color",
                        "Ring color when <= yellow and > green thresholds.",
                        colorGetter(db.spellIcons.ringYellowColor),
                        colorSetter(db.spellIcons.ringYellowColor),
                        { hasAlpha = true, order = 16 }
                    ),
                    ringGreenColor = OptionsFactory:CreateColor(
                        "Green Ring Color",
                        "Ring color when <= green threshold.",
                        colorGetter(db.spellIcons.ringGreenColor),
                        colorSetter(db.spellIcons.ringGreenColor),
                        { hasAlpha = true, order = 17 }
                    ),
                },
            },

            iconRules = {
                type = "group",
                name = "Icon Rules",
                order = 6,
                args = {
                    description = OptionsFactory:CreateDescription(
                        "Configured Rules",
                        function()
                            return self:GetIconRulesDescriptionText()
                        end,
                        { order = 1, fontSize = "medium" }
                    ),
                    listHeader = OptionsFactory:CreateHeader("Manage Existing Rule", { order = 2 }),
                    selectedRule = OptionsFactory:CreateSelect(
                        "Selected Rule",
                        "Choose an existing rule for removal.",
                        function()
                            return selectedRuleIndex
                        end,
                        function(_, value)
                            selectedRuleIndex = value
                        end,
                        {
                            order = 3,
                            values = function()
                                return self:GetIconRuleValues()
                            end,
                            disabled = function()
                                return #(self.db.class.iconRules or {}) == 0
                            end,
                        }
                    ),
                    removeRule = OptionsFactory:CreateExecute(
                        "Remove Selected Rule",
                        "Remove the currently selected icon rule.",
                        function()
                            self:RemoveSelectedIconRule()
                        end,
                        {
                            order = 4,
                            disabled = function()
                                return #(self.db.class.iconRules or {}) == 0
                            end,
                        }
                    ),

                    draftHeader = OptionsFactory:CreateHeader("Add Rule Draft", { order = 10 }),
                    draftKey = OptionsFactory:CreateInput(
                        "Rule Key",
                        "Unique key for this rule entry.",
                        function()
                            return iconRuleDraft.key
                        end,
                        function(_, value)
                            iconRuleDraft.key = value
                        end,
                        { order = 11 }
                    ),
                    draftSpellId = OptionsFactory:CreateInput(
                        "Spell ID",
                        "Spell ID used for icon lookup and timeToReady source.",
                        function()
                            return iconRuleDraft.spellId
                        end,
                        function(_, value)
                            iconRuleDraft.spellId = value
                        end,
                        { order = 12 }
                    ),
                    draftTimerSource = OptionsFactory:CreateSelect(
                        "Timer Source",
                        "Timing source used by this rule.",
                        function()
                            return iconRuleDraft.timerSource
                        end,
                        function(_, value)
                            iconRuleDraft.timerSource = value
                        end,
                        { order = 13, values = timerSourceValues }
                    ),
                    draftOffset = OptionsFactory:CreateInput(
                        "Offset Seconds",
                        "Additional seconds applied to the timer source result.",
                        function()
                            return iconRuleDraft.offsetSeconds
                        end,
                        function(_, value)
                            iconRuleDraft.offsetSeconds = value
                        end,
                        { order = 14 }
                    ),
                    draftEnabled = OptionsFactory:CreateToggle(
                        "Enabled",
                        "Whether the new draft rule starts enabled.",
                        function()
                            return iconRuleDraft.enabled ~= false
                        end,
                        function(_, value)
                            iconRuleDraft.enabled = value
                        end,
                        { order = 15 }
                    ),
                    addDraftRule = OptionsFactory:CreateExecute(
                        "Add Draft Rule",
                        "Append the draft as an icon rule entry.",
                        function()
                            self:AddDraftIconRule()
                        end,
                        { order = 16 }
                    ),
                },
            },
        },
    }
end

