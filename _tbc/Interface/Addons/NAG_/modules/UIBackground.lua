--- @module "NAG.UIBackground"
--- Handles UI background management and customization for NAG.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DisplayManager
--- @type OptionsFactory
--- @type TimerManager
local DisplayManager, OptionsFactory, TimerManager


local L = ns.AceLocale:GetLocale("NAG", true)
local LSM = ns.LibSharedMedia
local AceConfigRegistry = ns.AceConfigRegistry

-- Lua APIs

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Constants
local CONSTANTS = {
    DEFAULT_SCALE = 1.0,
    MIN_SCALE = 0.5,
    MAX_SCALE = 2.0,
    DEFAULT_ALPHA = 0.5,
    BACKGROUND_PATH = "Interface\\AddOns\\NAG\\Media\\bgIcons\\",
    BG_SCALE = 5.8,
}

-- Default settings
local defaults = {
    char = {
        enabled = false,                    -- Disabled by default (users enable when they want a background)
        selectedBackground = "none",        -- Default to none when disabled
        scale = CONSTANTS.DEFAULT_SCALE,
        color = { 1, 1, 1, 1 },
    }
}

--- @class UIBackground: CoreModule
local UIBackground = NAG:CreateModule("UIBackground", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    name = function() return L["Background"] or "Background" end,
    desc = function() return L["BackgroundDesc"] or "Configure the background line" end,
    libs = { "AceHook-3.0" },

    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DISPLAY,
        ns.DEBUG_CATEGORIES.UTILITIES
    }
})
local module = UIBackground
ns.UIBackground = UIBackground

local function HasValidClassKey()
    if ns.checkLicenseOnly then
        return ns.checkLicenseOnly() == true
    end
    if ns.checkBase then
        local _, licenseValid = ns.checkBase()
        return licenseValid == true
    end
    return false
end

-- Helper to get the active display frame (legacy or group)
local function GetActiveDisplayFrame()
    if not DisplayManager then
        return nil
    end

    if DisplayManager:IsGroupDisplayMode() and NAG.GroupDisplayFrame then
        return NAG.GroupDisplayFrame
    end

    if DisplayManager:IsLegacyFrameEnabled() and NAG.Frame then
        return NAG.Frame
    end

    return nil
end

-- Attach or update the background texture on a specific frame
local function AttachBackgroundToFrame(frame, selectedBackground, color, userScale)
    if not frame then return end

    -- If 'none' is selected, hide any existing background and return
    if selectedBackground == "none" then
        if frame.bgTexture then
            frame.bgTexture:Hide()
        end
        return
    end

    if not frame.bgTexture then
        frame.bgTexture = frame:CreateTexture(nil, "BACKGROUND")
    end

    local w, h = frame:GetWidth(), frame:GetHeight()
    local scale = CONSTANTS.BG_SCALE * (userScale or CONSTANTS.DEFAULT_SCALE)
    local insetW = (w * scale * 0.9 - w) / 2
    local insetH = (h * scale - h) / 2
    frame.bgTexture:ClearAllPoints()
    frame.bgTexture:SetPoint("TOPLEFT", frame, "TOPLEFT", -insetW, -insetH)
    frame.bgTexture:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insetW, insetH)

    local bgPath = CONSTANTS.BACKGROUND_PATH .. (selectedBackground or "default.png")
    frame.bgTexture:SetTexture(bgPath)
    frame.bgTexture:SetVertexColor(unpack(color))
    frame:SetFrameStrata("BACKGROUND")
    frame.bgTexture:SetDrawLayer("BACKGROUND", -7)
    frame.bgTexture:Show()
end

-- Attach or update the background texture on the active display frame
function UIBackground:AttachBackgroundToDisplay()
    -- Don't attach if module is disabled
    if not self.db.char.enabled then
        self:HideBackgroundOnDisplay()
        return
    end

    local selectedBackground = self.db.char.selectedBackground
    local color = self.db.char.color
    local userScale = self.db.char.scale
    local frame = GetActiveDisplayFrame()

    if not frame then
        self:HideBackgroundOnDisplay()
        return
    end

    if self.backgroundFrame and self.backgroundFrame ~= frame then
        if self.backgroundFrame.bgTexture then
            self.backgroundFrame.bgTexture:Hide()
        end
    end

    AttachBackgroundToFrame(frame, selectedBackground, color, userScale)
    self.backgroundFrame = frame
end

function UIBackground:HideBackgroundOnDisplay()
    if self.backgroundFrame and self.backgroundFrame.bgTexture then
        self.backgroundFrame.bgTexture:Hide()
    end
end

function UIBackground:UpdateBackground()
    self:AttachBackgroundToDisplay()
end

function UIBackground:UpdateLockState()
    -- Hide backgrounds if module is disabled
    if not self.db.char.enabled then
        self:HideBackgroundOnDisplay()
        return
    end

    local selectedBackground = self.db.char.selectedBackground
    -- Skip processing if 'none' is selected
    if selectedBackground == "none" then
        self:HideBackgroundOnDisplay()
        return
    end
    if not HasValidClassKey() then
        self:HideBackgroundOnDisplay()
        return
    end
    if NAG.IsUIElementsEnabled and not NAG:IsUIElementsEnabled() then
        self:HideBackgroundOnDisplay()
        return
    end
    if DisplayManager and not DisplayManager:ShouldShowDisplay() and not NAG:IsAnyEditMode() then
        self:HideBackgroundOnDisplay()
        return
    end

    self:AttachBackgroundToDisplay()
end

function UIBackground:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    DisplayManager = NAG:GetModule("DisplayManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = NAG:GetModule("TimerManager")

    self:UpdateLockState()
end

function UIBackground:ModuleEnable()

    -- ============================ MODULE INITIALIZATION ============================
    if self.SetSetting then
        self:SetSetting("char", "enabled", true)
    elseif self.db and self.db.char then
        self.db.char.enabled = true
    end
    self:UpdateLockState()
    if TimerManager and TimerManager.Create then
        TimerManager:Create(TimerManager.Categories.UI_NOTIFICATION, "ui_background_visibility", function()
            self:UpdateLockState()
        end, 0.5, true)
    end
end

function UIBackground:ModuleDisable()
    self:HideBackgroundOnDisplay()
    self:UnhookAll()
    if self.SetSetting then
        self:SetSetting("char", "enabled", false)
    elseif self.db and self.db.char then
        self.db.char.enabled = false
    end
    if TimerManager and TimerManager.Cancel then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "ui_background_visibility")
    end
end

-- Get available background icons
function UIBackground:GetBackgroundList()
    local backgrounds = {
        ["none"] = "None",
        ["aim.png"] = "Aim",
        ["aim2.png"] = "Aim 2",
        ["arrow.png"] = "Arrow",
        ["arrowFlame.png"] = "Arrow Flame",
        ["arrowFlame2.png"] = "Arrow Flame 2",
        ["arrowStone.png"] = "Arrow Stone",
        ["blueFlame.png"] = "Blue Flame",
        ["fire.png"] = "Fire",
        ["frostArrow.png"] = "Frost Arrow",
        ["frostSides.png"] = "Frost Sides",
        ["lightning.png"] = "Lightning",
        ["lightning4.png"] = "Lightning 4",
        ["lightningArrow.png"] = "Lightning Arrow",
        ["ligtningSides.png"] = "Lightning Sides",
        ["ligtning2.png"] = "Lightning 2",
        ["shadow.png"] = "Shadow",
        ["shadow2.png"] = "Shadow 2",
        ["shadow3.png"] = "Shadow 3",
        ["shadow4.png"] = "Shadow 4",
        ["shadow5.png"] = "Shadow 5",
        ["shadow6.png"] = "Shadow 6",
        ["stone3.png"] = "Stone 3",
        ["stoneArrow2.png"] = "Stone Arrow 2",
        ["stoneFlame.png"] = "Stone Flame",
        ["stoneFlame2.png"] = "Stone Flame 2",
        ["whiteFlame.png"] = "White Flame",
        ["whiteFlame2.png"] = "White Flame 2"
    }
    return backgrounds
end

function UIBackground:GetOptions()
    -- Ensure locale is available, with fallbacks
    local L = ns.AceLocale:GetLocale("NAG", true) or {}

    return {
        type = "group",
        name = L["UI Background"] or "UI Background",
        order = 111,
        args = {
            enabled = OptionsFactory:CreateToggle(
                L["enabled"] or "Enabled",
                L["enabledDesc"] or "Enable or disable this module/feature",
                function() return self:GetSetting("char", "enabled") end,
                function(_, value)
                    self:SetSetting("char", "enabled", value)
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                    -- Immediately update display state
                    self:UpdateLockState()
                end,
                { order = 1 }
            ),
            background = OptionsFactory:CreateSelect(
                L["background"] or "Background",
                L["backgroundDesc"] or "Select background texture",
                function() return self:GetSetting("char", "selectedBackground") end,
                function(_, value)
                    self:SetSetting("char", "selectedBackground", value)
                    self:UpdateBackground()
                end,
                {
                    order = 2,
                    values = self:GetBackgroundList()
                }
            ),
            color = OptionsFactory:CreateColor(
                L["color"] or "Color",
                L["colorDesc"] or "Set background color and transparency",
                function()
                    return unpack(self:GetSetting("char", "color"))
                end,
                function(_, r, g, b, a)
                    self:SetSetting("char", "color", { r, g, b, a })
                    self:UpdateBackground()
                end,
                {
                    order = 3,
                    hasAlpha = true
                }
            ),
            scale = OptionsFactory:CreateRange(
                L["scale"] or "Scale",
                L["scaleDesc"] or "Adjust background scale",
                function() return self:GetSetting("char", "scale") end,
                function(_, value)
                    self:SetSetting("char", "scale", value)
                    self:UpdateBackground()
                end,
                {
                    order = 4,
                    min = CONSTANTS.MIN_SCALE,
                    max = CONSTANTS.MAX_SCALE,
                    step = 0.05
                }
            ),
        }
    }
end

