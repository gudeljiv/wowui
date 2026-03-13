--- @module "NAG.FloatingSelector"
--- Floating rotation selector icon anchored to the active NAG display frame
--- License: CC BY-NC 4.0
--- Authors: @Rakizi, @Fonsas

-- ============================ LOCALIZE ============================
local _, ns = ...
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local InCombatLockdown = _G.InCombatLockdown
local IsAltKeyDown = _G.IsAltKeyDown
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsControlKeyDown = _G.IsControlKeyDown
local CreateFrame = _G.CreateFrame
local ReloadUI = _G.ReloadUI
local IsInGroup = _G.IsInGroup
local GetTime = _G.GetTime
local StaticPopup_Show = _G.StaticPopup_Show
local StaticPopupDialogs = _G.StaticPopupDialogs
local CloseDropDownMenus = _G.CloseDropDownMenus
local UnitClassBase = _G.UnitClassBase
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local WoWAPI = ns.WoWAPI
local Version = ns.Version

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
--- @type OptionsFactory
local OptionsFactory

--- @type OptionsManager
local OptionsManager

--- @type DisplayManager
local DisplayManager

--- @type TimerManager
local TimerManager

--- @type SpecCompat
local SpecCompat

local L = ns.AceLocale:GetLocale("NAG", true)
local AceConfigDialog = ns.AceConfigDialog
local AceConfigRegistry = ns.AceConfigRegistry
local AceGUI = ns.AceGUI
local LUIDropDownMenu = LibStub("LibUIDropDownMenu-4.0")

local time = _G.time

local ASSIGNMENT_REMINDER_SHOW_SECONDS = 4
local ASSIGNMENT_REMINDER_FADE_IN_SECONDS = 1
local ASSIGNMENT_REMINDER_FADE_OUT_SECONDS = 1
local ASSIGNMENT_REMINDER_COOLDOWN_SECONDS = 60 * 60 * 24 * 2
local TICKET_REMINDER_SHOW_SECONDS = 4
local TICKET_REMINDER_FADE_IN_SECONDS = 1
local TICKET_REMINDER_FADE_OUT_SECONDS = 1
local TICKET_REMINDER_COOLDOWN_SECONDS = 60 * 60 * 72
local mathRandom = math.random
local mathCeil = math.ceil
local tinsert = table.insert
local tsort = table.sort
local pairs = pairs
local type = type

local ASSIGNMENT_HINT_ICON_SIZE = 14
local ASSIGNMENT_HINT_RING_SIZE = 16
local ASSIGNMENT_HINT_GAP = 1
local ASSIGNMENT_HINT_CONTAINER_OFFSET_X = 0
local ASSIGNMENT_HINT_CONTAINER_OFFSET_Y = 0
local ASSIGNMENT_HINT_CIRCLE_MASK = "Interface/CHARACTERFRAME/TempPortraitAlphaMask"
local CURSE_OF_DOOM_BASE_SPELL_ID = 603
local DOOM_TRACKER_TIMER_NAME = "floating_selector_doom_tracker"
local DRUID_FERAL_SPEC_INDEX = 2
local SHRED_SPELL_ID = 5221
local FERAL_SHRED_ASSIGNMENT_KEY = "feralShredAssignmentEnabled"
local FESTERING_STRIKE_SPELL_ID = 85948
local DEATHKNIGHT_UNHOLY_SPEC_INDEX = 3

local HELPER_DOWNLOAD_URL = "https://github.com/afonsohfontes/NAGHelperApp/releases/"
local HELPER_DISCORD_URL = "discord.gg/EbonHold"

-- ============================ DEFAULTS ============================
local defaults = {
    global = {
        floatingSelector = {
            enabled = true,
            size = 34,
            leftClickAction = "frame_position",
            rightClickAction = "context_menu",
            dragFramesUnlocked = false,
            autoRotationSpam = {
                enabled = false,
                rotationName = "",
                intervalSeconds = 0.75
            },
            iconColor = { 1, 1, 1, 1 },
            defaultAnchor = "top_right",
            assignmentHintPosition = "left",
            modifierKey = "NONE",
            position = {
                point = "TOPLEFT",
                relativePoint = "TOPRIGHT",
                x = -16,
                y = 17
            }
        },
    },
    char = {},
}

local CLICK_ACTIONS = {
    rotation_menu = "Rotation Menu",
    frame_position = "Frame Position",
    nag_options = "NAG Options",
    context_menu = "Menu",
    none = "No Action",
}

local FLOATING_POSITION_ANCHORS = {
    top_right = { point = "TOPLEFT", relativePoint = "TOPRIGHT", label = "Top Right", defaultX = -16, defaultY = 17 },
    top_left = { point = "TOPRIGHT", relativePoint = "TOPLEFT", label = "Top Left", defaultX = 16, defaultY = 17 },
}

local FLOATING_MODIFIER_KEYS = {
    display = "Use Display Setting",
    NONE = "None",
    ALT = "Alt",
    SHIFT = "Shift",
    CONTROL = "Control",
}

-- WoW SetPoint: framePoint at (relativePoint on relativeTo) + (xOfs, yOfs)
-- WoW coords: +x = right, -x = left; +y = up, -y = down
local ASSIGNMENT_HINT_POSITIONS = {
    -- Left: icons extend LEFTWARD (away from N). First at container RIGHT, next stack LEFT
    left = {
        containerPoint = "RIGHT",
        containerRelativePoint = "LEFT",
        offsetX = 0,
        offsetY = 0,
        firstFramePoint = "CENTER",
        firstFrameRelative = "CENTER",
        nextFramePoint = "RIGHT",
        nextFrameRelative = "LEFT",
        nextFrameOffsetX = -ASSIGNMENT_HINT_GAP,
        nextFrameOffsetY = 0,
        label = "Left (W)",
    },
    -- Right: icons extend RIGHTWARD (away from N). First at container LEFT, next stack RIGHT
    right = {
        containerPoint = "LEFT",
        containerRelativePoint = "RIGHT",
        offsetX = 0,
        offsetY = 0,
        firstFramePoint = "CENTER",
        firstFrameRelative = "CENTER",
        nextFramePoint = "LEFT",
        nextFrameRelative = "RIGHT",
        nextFrameOffsetX = ASSIGNMENT_HINT_GAP,
        nextFrameOffsetY = 0,
        label = "Right (E)",
    },
    above = {
        containerPoint = "BOTTOM",
        containerRelativePoint = "TOP",
        offsetX = 0,
        offsetY = -5,
        firstFramePoint = "CENTER",
        firstFrameRelative = "CENTER",
        nextFramePoint = "BOTTOM",
        nextFrameRelative = "TOP",
        nextFrameOffsetX = 0,
        nextFrameOffsetY = ASSIGNMENT_HINT_GAP,
        label = "Above (N)",
    },
    below = {
        containerPoint = "TOP",
        containerRelativePoint = "BOTTOM",
        offsetX = 0,
        offsetY = 10,
        firstFramePoint = "CENTER",
        firstFrameRelative = "CENTER",
        nextFramePoint = "TOP",
        nextFrameRelative = "BOTTOM",
        nextFrameOffsetX = 0,
        nextFrameOffsetY = -ASSIGNMENT_HINT_GAP,
        label = "Below (S)",
    },
}

local function getRetTwistModule()
    if not NAG or not NAG.GetModule then
        return nil
    end
    return NAG:GetModule("PaladinRetTwistModule", true)
end

--- Add a hold cue sound entry only when the soundKit value is valid.
--- @param values table
--- @param label string
--- @param soundKitValue number|nil
local function addRetTwistHoldSoundValue(values, label, soundKitValue)
    if type(soundKitValue) == "number" and soundKitValue > 0 then
        values[label] = soundKitValue
    end
end

local RET_TWIST_HOLD_SOUND_PRIORITY = {
    "Tell Message",
    "Tutorial Popup",
    "Loot Coin",
    "Checkbox On",
    "Checkbox Off",
    "Backpack Open",
}

local function buildRetTwistHoldSoundValues()
    local values = {}
    local soundKit = _G.SOUNDKIT
    if soundKit then
        -- Keep this list intentionally small and short to avoid noisy/long cues.
        addRetTwistHoldSoundValue(values, "Tell Message", soundKit.TELL_MESSAGE)
        addRetTwistHoldSoundValue(values, "Tutorial Popup", soundKit.TUTORIAL_POPUP)
        addRetTwistHoldSoundValue(values, "Loot Coin", soundKit.LOOT_WINDOW_COIN_SOUND)
        addRetTwistHoldSoundValue(values, "Checkbox On", soundKit.IG_MAINMENU_OPTION_CHECKBOX_ON)
        addRetTwistHoldSoundValue(values, "Checkbox Off", soundKit.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        addRetTwistHoldSoundValue(values, "Backpack Open", soundKit.IG_BACKPACK_OPEN)
    end

    return values
end

--- Return first valid curated hold cue sound label.
--- @param values table
--- @return string|nil
local function getDefaultRetTwistHoldSoundName(values)
    for i = 1, #RET_TWIST_HOLD_SOUND_PRIORITY do
        local name = RET_TWIST_HOLD_SOUND_PRIORITY[i]
        if values[name] ~= nil then
            return name
        end
    end
    for name in pairs(values) do
        return name
    end
    return nil
end

--- Normalize persisted hold cue selection to a valid single-choice sound.
--- @param selectedSound any
--- @param values table
--- @return string|nil
local function normalizeRetTwistHoldSoundName(selectedSound, values)
    if type(selectedSound) == "string" and values and values[selectedSound] ~= nil then
        return selectedSound
    end
    return getDefaultRetTwistHoldSoundName(values or {})
end

local HOLD_CUE_SHINE_TYPES = {
    ["Autocast Shine"] = "Autocast Shine",
    ["Pixel Glow"] = "Pixel Glow",
    ["Button Glow"] = "Button Glow",
    ["Proc Glow"] = "Proc Glow",
}

local function isRetTwistContextAvailable()
    return Version and Version.IsTBC and Version:IsTBC()
        and UnitClassBase("player") == "PALADIN"
        and SpecCompat and SpecCompat.GetCurrentSpecIndex
        and SpecCompat:GetCurrentSpecIndex() == 3
end

local function getRetTwistSetting(retTwistModule, key, fallback)
    if retTwistModule and retTwistModule.GetSetting then
        local value = retTwistModule:GetSetting("class", key)
        if value ~= nil then
            return value
        end
    end
    if retTwistModule and retTwistModule.db and retTwistModule.db.class then
        local value = retTwistModule.db.class[key]
        if value ~= nil then
            return value
        end
    end
    return fallback
end

local function setRetTwistSetting(retTwistModule, key, value)
    if not retTwistModule then
        return
    end
    if retTwistModule.SetSetting then
        retTwistModule:SetSetting("class", key, value)
    elseif retTwistModule.db and retTwistModule.db.class then
        retTwistModule.db.class[key] = value
    end
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

--- @class FloatingSelector : CoreModule
local FloatingSelector = NAG:CreateModule("FloatingSelector", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    optionsOrder = 21,
    eventHandlers = {
        MODIFIER_STATE_CHANGED = "OnModifierStateChanged",
        PLAYER_REGEN_ENABLED = "OnCombatEnded",
        ENCOUNTER_START = "OnEncounterStart",
        ENCOUNTER_END = "OnEncounterEnd",
    },
    messageHandlers = {
        NAG_FRAME_UPDATED = true,
        NAG_SETTING_CHANGED = "OnSettingChanged",
        NAG_ROTATION_SELECTION_CHANGED = "OnRotationSelectionChanged",
    },
    debugCategories = {
        ns.DEBUG_CATEGORIES.DISPLAY,
        ns.DEBUG_CATEGORIES.UTILITIES
    }
})
local module = FloatingSelector
ns.FloatingSelector = FloatingSelector

-- ============================ LIFECYCLE ============================
function FloatingSelector:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    OptionsManager = NAG:GetModule("OptionsManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    TimerManager = NAG:GetModule("TimerManager")
    SpecCompat = NAG:GetModule("SpecCompat")
end

function FloatingSelector:ModuleEnable()
    if not self.db then
        self:Warn("ModuleEnable called but database not ready - skipping setup")
        return
    end

    self:InitializeFloatingDefaults()
    self:CreateFloatingFrame()
    self:UpdateFloatingIcon()
    self:UpdateAutoRotationSpamTimer()
end

function FloatingSelector:ModuleDisable()
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "floating_selector_rotation_spam")
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, DOOM_TRACKER_TIMER_NAME)
    if self.floatingFrame then
        self.floatingFrame:Hide()
    end
    self:HideAssignmentHintIcons()
end

function FloatingSelector:NAG_FRAME_UPDATED()
    self:UpdateFloatingIcon()
end

function FloatingSelector:OnSettingChanged(message, namespace, ...)
    if namespace ~= "global" then
        return
    end
    local firstKey = select(1, ...)
    if type(firstKey) == "string" and firstKey:match("^floatingSelector") then
        self:UpdateFloatingIcon()
    end
end

function FloatingSelector:OnRotationSelectionChanged()
    self:UpdateAssignmentHintIcons()
end

-- ============================ INTERNAL HELPERS ============================
function FloatingSelector:InitializeFloatingDefaults()
    if not self.db then
        self:Warn("InitializeFloatingDefaults called but database not ready")
        return
    end

    local settings = self.db.global.floatingSelector
    if not settings or type(settings) ~= "table" then
        self.db.global.floatingSelector = {
            enabled = true,
            size = 34,
            leftClickAction = "frame_position",
            rightClickAction = "context_menu",
            dragFramesUnlocked = false,
            autoRotationSpam = {
                enabled = false,
                rotationName = "",
                intervalSeconds = 0.75
            },
            iconColor = { 1, 1, 1, 1 },
            defaultAnchor = "top_right",
            assignmentHintPosition = "left",
            modifierKey = "NONE",
            position = {
                point = "TOPLEFT",
                relativePoint = "TOPRIGHT",
                x = -15,
                y = 19
            }
        }
        return
    end

    if settings.defaultAnchor == nil or not FLOATING_POSITION_ANCHORS[settings.defaultAnchor] then
        settings.defaultAnchor = "top_right"
    end

    if not settings.assignmentHintPosition or not ASSIGNMENT_HINT_POSITIONS[settings.assignmentHintPosition] then
        settings.assignmentHintPosition = "left"
    end

    if not settings.modifierKey or not FLOATING_MODIFIER_KEYS[settings.modifierKey] then
        settings.modifierKey = "NONE"
    end

    if settings.enabled == nil then
        settings.enabled = true
    end

    if not settings.size or type(settings.size) ~= "number" then
        settings.size = 34
    end

    if not settings.leftClickAction or not CLICK_ACTIONS[settings.leftClickAction] then
        settings.leftClickAction = "frame_position"
    end

    if not settings.rightClickAction or not CLICK_ACTIONS[settings.rightClickAction] then
        settings.rightClickAction = "context_menu"
    end

    if settings.dragFramesUnlocked == nil then
        settings.dragFramesUnlocked = false
    end

    if not settings.autoRotationSpam or type(settings.autoRotationSpam) ~= "table" then
        settings.autoRotationSpam = {
            enabled = false,
            rotationName = "",
            intervalSeconds = 0.75
        }
    end

    if not settings.iconColor or type(settings.iconColor) ~= "table" then
        settings.iconColor = { 1, 1, 1, 1 }
    end

    if settings.autoRotationSpam.enabled == nil then
        settings.autoRotationSpam.enabled = false
    end

    if type(settings.autoRotationSpam.rotationName) ~= "string" then
        settings.autoRotationSpam.rotationName = ""
    end

    if type(settings.autoRotationSpam.intervalSeconds) ~= "number" or settings.autoRotationSpam.intervalSeconds <= 0 then
        settings.autoRotationSpam.intervalSeconds = 0.75
    end

    if not settings.position or type(settings.position) ~= "table" then
        settings.position = {
            point = "TOPLEFT",
            relativePoint = "TOPRIGHT",
            x = -15,
            y = 19
        }
    end

    local position = settings.position
    if not position.point or not position.relativePoint or
        type(position.x) ~= "number" or type(position.y) ~= "number" then
        local anchorKey = settings.defaultAnchor or "top_right"
        local anchor = FLOATING_POSITION_ANCHORS[anchorKey] or FLOATING_POSITION_ANCHORS.top_right
        settings.position = {
            point = anchor.point,
            relativePoint = anchor.relativePoint,
            x = anchor.defaultX or 5,
            y = anchor.defaultY or 0
        }
    end
end

function FloatingSelector:IsGcdSwipeOverlayHidden()
    if not DisplayManager or not DisplayManager.AreCooldownSwipesEnabled then
        return false
    end
    return DisplayManager:AreCooldownSwipesEnabled() ~= true
end

function FloatingSelector:SetCooldownSwipesEnabled(enabled)
    if not DisplayManager then
        self:Warn("SetCooldownSwipesEnabled: DisplayManager not available")
        return
    end
    if DisplayManager.SetCooldownSwipesEnabled then
        DisplayManager:SetCooldownSwipesEnabled(enabled == true)
    elseif DisplayManager.SetSetting then
        DisplayManager:SetSetting("char", "enableCooldownSwipes", enabled == true)
        DisplayManager:RefreshAllCooldownDisplays()
    end
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:GetActiveAnchorFrame()
    if not DisplayManager then
        return nil
    end

    -- Prefer content-based anchor: group mode uses MAIN group frame (icon row), not the outer drag frame
    if DisplayManager.GetFloatingSelectorAnchorFrame and DisplayManager:GetFloatingSelectorAnchorFrame() then
        return DisplayManager:GetFloatingSelectorAnchorFrame()
    end

    if DisplayManager:IsGroupDisplayMode() and NAG.GroupDisplayFrame then
        return NAG.GroupDisplayFrame
    end

    if DisplayManager:IsLegacyFrameEnabled() and NAG.Frame then
        return NAG.Frame
    end

    return nil
end

function FloatingSelector:SetFramePosition(frame, anchor, position)
    if not frame or not anchor or not position then
        self:Warn("SetFramePosition: Invalid parameters")
        return false
    end

    if not position.point or not position.relativePoint or
        type(position.x) ~= "number" or type(position.y) ~= "number" then
        self:Warn("SetFramePosition: Invalid position structure")
        return false
    end

    frame:ClearAllPoints()
    frame:SetPoint(position.point, anchor, position.relativePoint, position.x, position.y)
    return true
end

local function addUniqueSpellId(target, seen, spellId)
    if type(spellId) ~= "number" or spellId <= 0 then
        return
    end
    if seen[spellId] then
        return
    end
    seen[spellId] = true
    tinsert(target, spellId)
end

-- ============================ ASSIGNMENT HINT ICONS ============================
function FloatingSelector:EnsureAssignmentHintContainer()
    if self.assignmentHintContainer or not self.floatingFrame then
        return
    end

    local container = CreateFrame("Frame", nil, self.floatingFrame)
    container:SetFrameStrata(self.floatingFrame:GetFrameStrata())
    container:SetFrameLevel(self.floatingFrame:GetFrameLevel())
    container:SetSize(1, ASSIGNMENT_HINT_RING_SIZE)
    container:SetPoint("RIGHT", self.floatingFrame, "LEFT", ASSIGNMENT_HINT_CONTAINER_OFFSET_X, ASSIGNMENT_HINT_CONTAINER_OFFSET_Y)
    container:Hide()

    self.assignmentHintContainer = container
    self.assignmentHintFrames = {}
end

function FloatingSelector:AcquireAssignmentHintFrame(index)
    self:EnsureAssignmentHintContainer()
    if not self.assignmentHintContainer then
        return nil
    end

    if self.assignmentHintFrames and self.assignmentHintFrames[index] then
        return self.assignmentHintFrames[index]
    end

    local frame = CreateFrame("Frame", nil, self.assignmentHintContainer)
    frame:SetSize(ASSIGNMENT_HINT_RING_SIZE, ASSIGNMENT_HINT_RING_SIZE)

    local ring = frame:CreateTexture(nil, "OVERLAY", nil, 1)
    ring:SetAllPoints(frame)
    ring:SetColorTexture(0.1, 0.6, 0.1, 0.9)
    local ringMask = frame:CreateMaskTexture()
    ringMask:SetTexture(ASSIGNMENT_HINT_CIRCLE_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    ringMask:SetAllPoints(ring)
    ring:AddMaskTexture(ringMask)

    local icon = frame:CreateTexture(nil, "OVERLAY", nil, 3)
    icon:SetSize(ASSIGNMENT_HINT_ICON_SIZE, ASSIGNMENT_HINT_ICON_SIZE)
    icon:SetPoint("CENTER", frame, "CENTER", 0, 0)
    icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    local iconMask = frame:CreateMaskTexture()
    iconMask:SetTexture(ASSIGNMENT_HINT_CIRCLE_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    iconMask:SetAllPoints(icon)
    icon:AddMaskTexture(iconMask)

    frame.ring = ring
    frame.icon = icon

    self.assignmentHintFrames[index] = frame
    return frame
end

function FloatingSelector:HideAssignmentHintIcons()
    if self.assignmentHintFrames then
        for _, frame in ipairs(self.assignmentHintFrames) do
            if frame then
                frame:Hide()
            end
        end
    end
    if self.doomHintFrame then
        self.doomHintFrame:Hide()
    end
    if self.festerblightHintFrame then
        self.festerblightHintFrame:Hide()
    end
    if self.festerblightHintContainer then
        self.festerblightHintContainer:Hide()
    end
    if TimerManager and TimerManager.Cancel then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, DOOM_TRACKER_TIMER_NAME)
    end
    if self.assignmentHintContainer then
        self.assignmentHintContainer:Hide()
    end
end

function FloatingSelector:EnsureFesterblightHintContainer()
    if self.festerblightHintContainer or not self.floatingFrame then
        return
    end

    local container = CreateFrame("Frame", nil, self.floatingFrame)
    container:SetFrameStrata(self.floatingFrame:GetFrameStrata())
    container:SetFrameLevel(self.floatingFrame:GetFrameLevel())
    container:SetSize(ASSIGNMENT_HINT_RING_SIZE, ASSIGNMENT_HINT_RING_SIZE)
    local posConfig = ASSIGNMENT_HINT_POSITIONS.below
    container:SetPoint(posConfig.containerPoint, self.floatingFrame, posConfig.containerRelativePoint, posConfig.offsetX or 0, posConfig.offsetY or 0)
    container:Hide()

    local frame = CreateFrame("Frame", nil, container)
    frame:SetSize(ASSIGNMENT_HINT_RING_SIZE, ASSIGNMENT_HINT_RING_SIZE)

    local ring = frame:CreateTexture(nil, "OVERLAY", nil, 1)
    ring:SetAllPoints(frame)
    ring:SetColorTexture(0.1, 0.6, 0.1, 0.9)
    local ringMask = frame:CreateMaskTexture()
    ringMask:SetTexture(ASSIGNMENT_HINT_CIRCLE_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    ringMask:SetAllPoints(ring)
    ring:AddMaskTexture(ringMask)

    local icon = frame:CreateTexture(nil, "OVERLAY", nil, 3)
    icon:SetSize(ASSIGNMENT_HINT_ICON_SIZE, ASSIGNMENT_HINT_ICON_SIZE)
    icon:SetPoint("CENTER", frame, "CENTER", 0, 0)
    -- 35% zoom: show center 1/1.35 of texture (0.24..0.76)
    icon:SetTexCoord(0.24, 0.76, 0.24, 0.76)
    local iconMask = frame:CreateMaskTexture()
    iconMask:SetTexture(ASSIGNMENT_HINT_CIRCLE_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    iconMask:SetAllPoints(icon)
    icon:AddMaskTexture(iconMask)

    frame.ring = ring
    frame.icon = icon
    frame:SetPoint("CENTER", container, "CENTER", 0, 0)

    self.festerblightHintContainer = container
    self.festerblightHintFrame = frame
end

function FloatingSelector:GetFesterblightHintSpellId(classModule)
    if not classModule or not classModule.GetName or classModule:GetName() ~= "DEATHKNIGHT" then
        return nil
    end
    if not Version or not Version.IsMists or not Version:IsMists() then
        return nil
    end
    if not SpecCompat or not SpecCompat.GetCurrentSpecIndex or SpecCompat:GetCurrentSpecIndex() ~= DEATHKNIGHT_UNHOLY_SPEC_INDEX then
        return nil
    end
    local selected = classModule.GetSelectedRotation and classModule:GetSelectedRotation(DEATHKNIGHT_UNHOLY_SPEC_INDEX)
    if selected == "Festerblight" then
        return FESTERING_STRIKE_SPELL_ID
    end
    return nil
end

function FloatingSelector:AcquireDoomHintFrame()
    self:EnsureAssignmentHintContainer()
    if not self.assignmentHintContainer then
        return nil
    end

    if self.doomHintFrame then
        return self.doomHintFrame
    end

    local frame = CreateFrame("Frame", nil, self.assignmentHintContainer)
    frame:SetSize(ASSIGNMENT_HINT_RING_SIZE, ASSIGNMENT_HINT_RING_SIZE)

    local ring = frame:CreateTexture(nil, "OVERLAY", nil, 1)
    ring:SetAllPoints(frame)
    ring:SetColorTexture(0.75, 0.15, 0.75, 0.9)
    local ringMask = frame:CreateMaskTexture()
    ringMask:SetTexture(ASSIGNMENT_HINT_CIRCLE_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    ringMask:SetAllPoints(ring)
    ring:AddMaskTexture(ringMask)

    local icon = frame:CreateTexture(nil, "OVERLAY", nil, 3)
    icon:SetSize(ASSIGNMENT_HINT_ICON_SIZE, ASSIGNMENT_HINT_ICON_SIZE)
    icon:SetPoint("CENTER", frame, "CENTER", 0, 0)
    icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    local iconMask = frame:CreateMaskTexture()
    iconMask:SetTexture(ASSIGNMENT_HINT_CIRCLE_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    iconMask:SetAllPoints(icon)
    icon:AddMaskTexture(iconMask)

    local timerText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    timerText:SetPoint("CENTER", frame, "CENTER", 0, 0)
    timerText:SetTextColor(1, 1, 1, 1)
    timerText:SetJustifyH("CENTER")
    timerText:SetJustifyV("MIDDLE")

    frame.ring = ring
    frame.icon = icon
    frame.timerText = timerText
    self.doomHintFrame = frame
    return frame
end

function FloatingSelector:GetWarlockDoomTrackerState(classModule)
    if not Version or not Version.IsTBC or not Version:IsTBC() then
        return nil
    end
    if UnitClassBase("player") ~= "WARLOCK" then
        return nil
    end
    if not classModule or not classModule.GetDoomTrackerState then
        return nil
    end
    return classModule:GetDoomTrackerState()
end

function FloatingSelector:UpdateDoomHintTimerState(isActive)
    if not TimerManager or not TimerManager.Create or not TimerManager.Cancel then
        return
    end

    if not isActive then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, DOOM_TRACKER_TIMER_NAME)
        return
    end

    if TimerManager.IsTimerActive and TimerManager:IsTimerActive(TimerManager.Categories.UI_NOTIFICATION, DOOM_TRACKER_TIMER_NAME) then
        return
    end

    TimerManager:Create(TimerManager.Categories.UI_NOTIFICATION, DOOM_TRACKER_TIMER_NAME, function()
        self:UpdateAssignmentHintIcons()
    end, 1, true)
end

function FloatingSelector:GetAssignmentHintSpellIds(classModule)
    if not Version or not Version.IsTBC or not Version:IsTBC() then
        return {}
    end
    if not classModule or not classModule.GetName then
        return {}
    end

    local className = classModule:GetName()
    local hintSpellIds = {}
    local seen = {}
    local states = classModule.GetAssignmentStates and classModule:GetAssignmentStates() or {}
    local assignments = classModule.defaults and classModule.defaults.class and classModule.defaults.class.classAssignments or {}

    for _, assignment in ipairs(assignments) do
        if states[assignment.id] == true and assignment.spellIds and assignment.spellIds[1] then
            addUniqueSpellId(hintSpellIds, seen, assignment.spellIds[1])
        end
    end

    if className == "ROGUE" then
        local saveKickEnabled = classModule.GetSetting and classModule:GetSetting("char", "saveEnergyForKicks", false) == true
        if saveKickEnabled then
            addUniqueSpellId(hintSpellIds, seen, 1766) -- Kick
        end
    end

    if className == "PALADIN" and SpecCompat and SpecCompat.GetCurrentSpecIndex and SpecCompat:GetCurrentSpecIndex() == 3 then
        local retTwistModule = getRetTwistModule()
        local selfApplyActive = NAG.RetTwistShouldSelfApplyImpSoC and NAG:RetTwistShouldSelfApplyImpSoC() or false
        if selfApplyActive then
            addUniqueSpellId(hintSpellIds, seen, 21183) -- Same icon; deduped by spell id
        end
    end

    if className == "DRUID" and SpecCompat and SpecCompat.GetCurrentSpecIndex
        and SpecCompat:GetCurrentSpecIndex() == DRUID_FERAL_SPEC_INDEX then
        local shredAssignmentEnabled = NAG.IsFeralShredAssignmentEnabled and NAG:IsFeralShredAssignmentEnabled() or false
        if shredAssignmentEnabled then
            addUniqueSpellId(hintSpellIds, seen, SHRED_SPELL_ID) -- Shred
        end
    end

    if className == "HUNTER" then
        local manageViperEnabled = classModule.GetSetting and classModule:GetSetting("class", "recommendAspects", true) == true
        if manageViperEnabled and NAG.SpellIsKnown and NAG:SpellIsKnown(34074) then
            addUniqueSpellId(hintSpellIds, seen, 34074) -- Aspect of the Viper
        end
    end

    return hintSpellIds
end

function FloatingSelector:UpdateAssignmentHintIcons()
    if not self.floatingFrame or not self.floatingFrame:IsShown() then
        self:HideAssignmentHintIcons()
        return
    end

    local classModule = NAG.GetClassModule and NAG:GetClassModule() or nil
    local hintSpellIds = self:GetAssignmentHintSpellIds(classModule)
    local doomState = self:GetWarlockDoomTrackerState(classModule)
    local hasDoomHint = doomState ~= nil
    local festerblightSpellId = self:GetFesterblightHintSpellId(classModule)
    local hasFesterblightHint = festerblightSpellId ~= nil
    if (not hintSpellIds or #hintSpellIds == 0) and not hasDoomHint and not hasFesterblightHint then
        self:HideAssignmentHintIcons()
        return
    end

    self:EnsureAssignmentHintContainer()
    if not self.assignmentHintContainer then
        return
    end

    local posKey = self:GetSetting("global", "floatingSelector.assignmentHintPosition") or "left"
    local posConfig = ASSIGNMENT_HINT_POSITIONS[posKey] or ASSIGNMENT_HINT_POSITIONS.left
    local cp, crp = posConfig.containerPoint, posConfig.containerRelativePoint
    local ox, oy = posConfig.offsetX or 0, posConfig.offsetY or 0
    self.assignmentHintContainer:ClearAllPoints()
    self.assignmentHintContainer:SetPoint(cp, self.floatingFrame, crp, ox, oy)
    self.assignmentHintContainer:SetFrameStrata(self.floatingFrame:GetFrameStrata())
    self.assignmentHintContainer:SetFrameLevel(self.floatingFrame:GetFrameLevel())

    local fPoint, fRel = posConfig.firstFramePoint, posConfig.firstFrameRelative
    local nPoint, nRel = posConfig.nextFramePoint, posConfig.nextFrameRelative
    local nOffX = posConfig.nextFrameOffsetX or -ASSIGNMENT_HINT_GAP
    local nOffY = posConfig.nextFrameOffsetY or 0

    local previousFrame = nil
    for index, spellId in ipairs(hintSpellIds) do
        local frame = self:AcquireAssignmentHintFrame(index)
        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local iconID = spellInfo and spellInfo.iconID
        if frame and iconID then
            frame:ClearAllPoints()
            if not previousFrame then
                frame:SetPoint(fPoint, self.assignmentHintContainer, fRel, 0, 0)
            else
                frame:SetPoint(nPoint, previousFrame, nRel, nOffX, nOffY)
            end
            frame.icon:SetTexture(iconID)
            frame:Show()
            previousFrame = frame
        elseif frame then
            frame:Hide()
        end
    end

    if self.assignmentHintFrames then
        for index = #hintSpellIds + 1, #self.assignmentHintFrames do
            if self.assignmentHintFrames[index] then
                self.assignmentHintFrames[index]:Hide()
            end
        end
    end

    local doomFrame = self:AcquireDoomHintFrame()
    if doomFrame and hasDoomHint then
        local doomSpellInfo = WoWAPI.GetSpellInfo(CURSE_OF_DOOM_BASE_SPELL_ID)
        local iconID = doomSpellInfo and doomSpellInfo.iconID
        local remaining = doomState.remainingSeconds or 0
        if iconID and remaining > 0 then
            doomFrame:ClearAllPoints()
            if not previousFrame then
                doomFrame:SetPoint(fPoint, self.assignmentHintContainer, fRel, 0, 0)
            else
                doomFrame:SetPoint(nPoint, previousFrame, nRel, nOffX, nOffY)
            end
            doomFrame.icon:SetTexture(iconID)
            doomFrame.timerText:SetText(tostring(mathCeil(remaining)))
            doomFrame:Show()
            previousFrame = doomFrame
            self:UpdateDoomHintTimerState(true)
        else
            doomFrame:Hide()
            self:UpdateDoomHintTimerState(false)
        end
    elseif doomFrame then
        doomFrame:Hide()
        self:UpdateDoomHintTimerState(false)
    end

    self:EnsureFesterblightHintContainer()
    if self.festerblightHintContainer and self.festerblightHintFrame and hasFesterblightHint then
        local spellInfo = WoWAPI.GetSpellInfo(festerblightSpellId)
        local iconID = spellInfo and spellInfo.iconID
        if iconID then
            self.festerblightHintFrame.icon:SetTexture(iconID)
            self.festerblightHintFrame:Show()
            self.festerblightHintContainer:SetFrameStrata(self.floatingFrame:GetFrameStrata())
            self.festerblightHintContainer:SetFrameLevel(self.floatingFrame:GetFrameLevel())
            self.festerblightHintContainer:Show()
        else
            self.festerblightHintFrame:Hide()
            self.festerblightHintContainer:Hide()
        end
    elseif self.festerblightHintContainer then
        self.festerblightHintContainer:Hide()
        if self.festerblightHintFrame then
            self.festerblightHintFrame:Hide()
        end
    end

    if previousFrame then
        self.assignmentHintContainer:Show()
    else
        self.assignmentHintContainer:Hide()
    end
end

function FloatingSelector:UpdateFloatingIcon()
    if not self.db or not self.floatingFrame then
        return
    end

    if InCombatLockdown() then
        self.pendingVisibilityUpdate = true
        return
    end

    self.pendingVisibilityUpdate = false

    local settings = self.db.global.floatingSelector
    if not settings or settings.enabled == false then
        self.floatingFrame:Hide()
        self:HideAssignmentHintIcons()
        return
    end

    if NAG.IsUIElementsEnabled and not NAG:IsUIElementsEnabled() then
        self.floatingFrame:Hide()
        self:HideAssignmentHintIcons()
        return
    end

    -- Use the same gate as Common.lua: only show when we would be updating icon frames.
    -- Common early-returns and clears icons when !ShouldShowDisplay (and never updates);
    -- we hide the floating icon in that state so it does not show when no icons are displayed.
    if DisplayManager and not DisplayManager:IsDisplaySuppressed() and not DisplayManager:ShouldShowDisplay() and
        not NAG:IsAnyEditMode() then
        self.floatingFrame:Hide()
        self:HideAssignmentHintIcons()
        return
    end

    local anchor = self:GetActiveAnchorFrame()
    if not anchor or not anchor:IsShown() then
        self.floatingFrame:Hide()
        self:HideAssignmentHintIcons()
        return
    end

    self.floatingFrame:SetParent(anchor)
    local maxLevel = anchor:GetFrameLevel()
    if anchor.iconFrames then
        for _, fr in pairs(anchor.iconFrames) do
            if fr and fr.GetFrameLevel then
                local l = fr:GetFrameLevel()
                if l > maxLevel then maxLevel = l end
            end
        end
    end
    self.floatingFrame:SetFrameLevel(maxLevel + 1)
    self.floatingFrame:SetSize(settings.size * 0.9, settings.size * 0.9)
    if settings.iconColor then
        local r = settings.iconColor[1] or 1
        local g = settings.iconColor[2] or 1
        local b = settings.iconColor[3] or 1
        local a = settings.iconColor[4] or 1
        self.floatingFrame:GetNormalTexture():SetVertexColor(r, g, b, a)
        self.floatingFrame:GetHighlightTexture():SetVertexColor(r, g, b, a * 0.7)
    end
    local pos = settings.position
    self:SetFramePosition(self.floatingFrame, anchor, { point = pos.point, relativePoint = pos.relativePoint, x = pos.x + 1, y = pos.y + 1 })
    self.floatingFrame:Show()
    self:UpdateAssignmentHintIcons()
    self:UpdateFloatingSelectorMouseState()
end

-- ============================ ASSIGNMENT REMINDER ============================
function FloatingSelector:EnsureAssignmentReminderFrame()
    if self.assignmentReminderFrame then
        return
    end

    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetFrameStrata("HIGH")
    frame:Hide()

    local texture = frame:CreateTexture(nil, "ARTWORK")
    texture:SetAllPoints(frame)
    texture:SetTexture("Interface\\AddOns\\NAG\\media\\classWarning.png")

    frame.texture = texture
    self.assignmentReminderFrame = frame
end

function FloatingSelector:EnsureTicketReminderFrame()
    if self.ticketReminderFrame then
        return
    end

    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetFrameStrata("HIGH")
    frame:Hide()

    local texture = frame:CreateTexture(nil, "ARTWORK")
    texture:SetAllPoints(frame)
    texture:SetTexture("Interface\\AddOns\\NAG\\media\\ticket.png")

    frame.texture = texture
    self.ticketReminderFrame = frame
end

function FloatingSelector:StartAssignmentReminderFade()
    if not self.assignmentReminderFrame then
        return
    end

    local startTime = GetTime()
    self.assignmentReminderFrame:SetScript("OnUpdate", function(frame)
        local lastTick = frame._nagLastFadeUpdate or 0
        local now = GetTime()
        if (now - lastTick) < 0.016 then
            return
        end
        frame._nagLastFadeUpdate = now
        local elapsed = GetTime() - startTime
        if elapsed >= ASSIGNMENT_REMINDER_FADE_OUT_SECONDS then
            frame:SetAlpha(1)
            frame:SetScript("OnUpdate", nil)
            frame:Hide()
            return
        end
        local alpha = 1 - (elapsed / ASSIGNMENT_REMINDER_FADE_OUT_SECONDS)
        frame:SetAlpha(alpha)
    end)
end

function FloatingSelector:StartTicketReminderFade()
    if not self.ticketReminderFrame then
        return
    end

    local startTime = GetTime()
    self.ticketReminderFrame:SetScript("OnUpdate", function(frame)
        local lastTick = frame._nagLastFadeUpdate or 0
        local now = GetTime()
        if (now - lastTick) < 0.016 then
            return
        end
        frame._nagLastFadeUpdate = now
        local elapsed = GetTime() - startTime
        if elapsed >= TICKET_REMINDER_FADE_OUT_SECONDS then
            frame:SetAlpha(1)
            frame:SetScript("OnUpdate", nil)
            frame:Hide()
            return
        end
        local alpha = 1 - (elapsed / TICKET_REMINDER_FADE_OUT_SECONDS)
        frame:SetAlpha(alpha)
    end)
end

function FloatingSelector:StartAssignmentReminderFadeIn()
    if not self.assignmentReminderFrame then
        return
    end

    local startTime = GetTime()
    self.assignmentReminderFrame:SetScript("OnUpdate", function(frame)
        local lastTick = frame._nagLastFadeUpdate or 0
        local now = GetTime()
        if (now - lastTick) < 0.016 then
            return
        end
        frame._nagLastFadeUpdate = now
        local elapsed = GetTime() - startTime
        if elapsed >= ASSIGNMENT_REMINDER_FADE_IN_SECONDS then
            frame:SetAlpha(1)
            frame:SetScript("OnUpdate", nil)
            TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "assignment_reminder_fade_out")
            TimerManager:Create(
                TimerManager.Categories.UI_NOTIFICATION,
                "assignment_reminder_fade_out",
                function()
                    self:StartAssignmentReminderFade()
                end,
                ASSIGNMENT_REMINDER_SHOW_SECONDS,
                false
            )
            return
        end
        frame:SetAlpha(elapsed / ASSIGNMENT_REMINDER_FADE_IN_SECONDS)
    end)
end

function FloatingSelector:StartTicketReminderFadeIn()
    if not self.ticketReminderFrame then
        return
    end

    local startTime = GetTime()
    self.ticketReminderFrame:SetScript("OnUpdate", function(frame)
        local lastTick = frame._nagLastFadeUpdate or 0
        local now = GetTime()
        if (now - lastTick) < 0.016 then
            return
        end
        frame._nagLastFadeUpdate = now
        local elapsed = GetTime() - startTime
        if elapsed >= TICKET_REMINDER_FADE_IN_SECONDS then
            frame:SetAlpha(1)
            frame:SetScript("OnUpdate", nil)
            TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "ticket_reminder_fade_out")
            TimerManager:Create(
                TimerManager.Categories.UI_NOTIFICATION,
                "ticket_reminder_fade_out",
                function()
                    self:StartTicketReminderFade()
                end,
                TICKET_REMINDER_SHOW_SECONDS,
                false
            )
            return
        end
        frame:SetAlpha(elapsed / TICKET_REMINDER_FADE_IN_SECONDS)
    end)
end

function FloatingSelector:ShowAssignmentReminder()
    if not self.floatingFrame or not self.floatingFrame:IsShown() then
        return
    end
    if not TimerManager or not TimerManager.Create then
        return
    end
    local classModule = NAG:GetClassModule()
    if classModule and classModule.db and classModule.db.char and classModule.db.char.ignoreAssignmentReminder then
        return
    end
    if classModule and classModule.db and classModule.db.char then
        local lastShown = classModule.db.char.assignmentReminderLastShown or 0
        local now = time()
        if lastShown > 0 and (now - lastShown) < ASSIGNMENT_REMINDER_COOLDOWN_SECONDS then
            return
        end
        classModule.db.char.assignmentReminderLastShown = now
    end

    self:EnsureAssignmentReminderFrame()
    local frame = self.assignmentReminderFrame
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOM", self.floatingFrame, "TOP", 0, -4)
    frame:SetSize(76, 48)
    frame:SetAlpha(0)
    frame:SetScript("OnUpdate", nil)
    frame:Show()

    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "assignment_reminder_fade_out")
    self:StartAssignmentReminderFadeIn()
end

function FloatingSelector:ShowTicketReminder()
    if not self.floatingFrame or not self.floatingFrame:IsShown() then
        return
    end
    if not TimerManager or not TimerManager.Create then
        return
    end

    local classModule = NAG:GetClassModule()
    if classModule and classModule.db and classModule.db.char then
        local lastShown = classModule.db.char.ticketReminderLastShown or 0
        local now = time()
        if lastShown > 0 and (now - lastShown) < TICKET_REMINDER_COOLDOWN_SECONDS then
            return
        end
        classModule.db.char.ticketReminderLastShown = now
    end

    self:EnsureTicketReminderFrame()
    local frame = self.ticketReminderFrame
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOM", self.floatingFrame, "TOP", 0, -4)
    frame:SetSize(76, 48)
    frame:SetAlpha(0)
    frame:SetScript("OnUpdate", nil)
    frame:Show()

    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "ticket_reminder_fade_out")
    self:StartTicketReminderFadeIn()
end

function FloatingSelector:OnCombatEnded()
    if self.pendingVisibilityUpdate then
        self:UpdateFloatingIcon()
    end
end

function FloatingSelector:OnEncounterStart()
    if not self.floatingFrame or not self.floatingFrame:IsShown() then
        self.encounterWithFloating = false
        return
    end
    local classModule = NAG:GetClassModule()
    if not classModule or not classModule.GetCurrentRotation then
        self.encounterWithFloating = false
        return
    end
    local rotation = select(1, classModule:GetCurrentRotation())
    self.encounterWithFloating = rotation ~= nil
end

function FloatingSelector:OnEncounterEnd()
    if not self.encounterWithFloating then
        return
    end
    self.encounterWithFloating = false
    self:ShowTicketReminder()
end

function FloatingSelector:ResetFloatingPosition()
    if not self.db then
        self:Warn("ResetFloatingPosition called but database not ready")
        return
    end

    local settings = self.db.global.floatingSelector
    if not settings then
        return
    end

    -- Reset all floating selector settings to defaults
    local anchor = FLOATING_POSITION_ANCHORS.top_right
    settings.enabled = true
    settings.size = 34
    settings.leftClickAction = "frame_position"
    settings.rightClickAction = "context_menu"
    settings.dragFramesUnlocked = false
    settings.iconColor = { 1, 1, 1, 1 }
    settings.defaultAnchor = "top_right"
    settings.assignmentHintPosition = "left"
    settings.modifierKey = "NONE"

    if not settings.autoRotationSpam then
        settings.autoRotationSpam = {}
    end
    settings.autoRotationSpam.enabled = false
    settings.autoRotationSpam.rotationName = ""
    settings.autoRotationSpam.intervalSeconds = 0.75

    if not settings.position then
        settings.position = {}
    end
    settings.position.point = anchor.point
    settings.position.relativePoint = anchor.relativePoint
    settings.position.x = anchor.defaultX or 5
    settings.position.y = anchor.defaultY or 0

    self:UpdateFloatingIcon()
    self:UpdateFloatingSelectorMouseState()
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:GetUIBackgroundModule()
    return NAG:GetModule("UIBackground", true)
end

function FloatingSelector:SetBackgroundScale(uiBackground, scale)
    if not uiBackground or not uiBackground.db then
        return
    end

    if uiBackground.SetSetting then
        uiBackground:SetSetting("char", "scale", scale)
    else
        uiBackground.db.char.scale = scale
    end
    uiBackground:UpdateBackground()
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:GetModuleEnabledNamespace(module)
    if module.defaults and module.defaults.class and module.defaults.class.enabled ~= nil then
        return "class"
    end
    if module.defaults and module.defaults.char and module.defaults.char.enabled ~= nil then
        return "char"
    end
    if module.defaults and module.defaults.global and module.defaults.global.enabled ~= nil then
        return "global"
    end
    if module.db then
        if module.db.class and module.db.class.enabled ~= nil then
            return "class"
        end
        if module.db.char and module.db.char.enabled ~= nil then
            return "char"
        end
        if module.db.global and module.db.global.enabled ~= nil then
            return "global"
        end
    end
    return nil
end

function FloatingSelector:GetModuleDisplayName(module)
    local name = module.GetName and module:GetName() or "Unknown"
    if module.GetOptions then
        local success, options = pcall(function() return module:GetOptions() end)
        if success and options and type(options.name) == "string" then
            name = options.name
        end
    end
    return name
end

function FloatingSelector:IsModuleHidden(module)
    if module.hidden and type(module.hidden) == "function" then
        local success, shouldHide = pcall(function() return module:hidden() end)
        if success and shouldHide then
            return true
        end
    end
    return false
end

function FloatingSelector:GetModuleEnabledValue(module, namespace)
    if module.GetSetting then
        return module:GetSetting(namespace, "enabled")
    end
    if module.db and module.db[namespace] then
        return module.db[namespace].enabled == true
    end
    return false
end

function FloatingSelector:SetModuleEnabledValue(module, namespace, value)
    if module.SetSetting then
        module:SetSetting(namespace, "enabled", value)
    elseif module.db and module.db[namespace] then
        module.db[namespace].enabled = value == true
    end

    if value then
        if module.Enable then
            module:Enable()
        elseif module.SetEnabledState then
            module:SetEnabledState(true)
        end
    else
        if module.Disable then
            module:Disable()
        elseif module.SetEnabledState then
            module:SetEnabledState(false)
        end
    end
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:ToggleFrameEditMode(enable)
    if not DisplayManager then
        self:Warn("ToggleFrameEditMode: DisplayManager not available")
        return
    end

    if enable then
        if DisplayManager:IsGroupDisplayMode() then
            DisplayManager:EnableEditMode()
        end
        if DisplayManager:IsLegacyFrameEnabled() then
            DisplayManager:ToggleFrameEditMode(true)
        end
    else
        if DisplayManager:IsGroupDisplayMode() then
            DisplayManager:DisableEditMode()
        end
        if DisplayManager:IsLegacyFrameEnabled() then
            DisplayManager:ToggleFrameEditMode(false)
        end
    end
end

function FloatingSelector:SetDragFramesEnabled(enable)
    if not self.db then
        return
    end

    self.db.global.floatingSelector.dragFramesUnlocked = enable == true
    self:ToggleFrameEditMode(enable == true)
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:SetAutoRotationSwitchingEnabled(enabled)
    local classModule = NAG:GetClassModule()
    if not classModule then
        return
    end

    classModule:SetSetting("char", "enableAutomaticRotationSwitching", enabled == true)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    local rotationName = nil
    if specIndex then
        local currentRotation = select(1, classModule:GetCurrentRotation(specIndex))
        rotationName = currentRotation and currentRotation.name
    end
    NAG:SendMessage(ns.Messages.ROTATION_CHANGED, {
        specIndex = specIndex,
        rotationName = rotationName,
        dataChanged = false,
        selectionChanged = true,
        autoRotationToggled = true,
        action = "auto_rotation_toggle"
    })
end

function FloatingSelector:SetAutoRotationSpamEnabled(enabled)
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    if not settings or not settings.autoRotationSpam then
        return
    end

    settings.autoRotationSpam.enabled = enabled == true
    if enabled then
        self:SetAutoRotationSwitchingEnabled(false)
        if settings.autoRotationSpam.rotationName == "" then
            local classModule = NAG:GetClassModule()
            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            if classModule and specIndex then
                local currentRotation = select(1, classModule:GetCurrentRotation(specIndex))
                if currentRotation and currentRotation.name then
                    settings.autoRotationSpam.rotationName = currentRotation.name
                end
            end
        end
    else
        self:SetAutoRotationSwitchingEnabled(false)
    end
    self:UpdateAutoRotationSpamTimer()
    if enabled then
        self:AutoRotationSpamTick()
    end
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:SetAutoRotationSpamInterval(intervalSeconds)
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    if not settings or not settings.autoRotationSpam then
        return
    end

    settings.autoRotationSpam.intervalSeconds = intervalSeconds
    self:UpdateAutoRotationSpamTimer()
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:UpdateAutoRotationSpamTimer()
    if not TimerManager or not TimerManager.Create then
        return
    end

    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "floating_selector_rotation_spam")

    local settings = self.db and self.db.global and self.db.global.floatingSelector
    if not settings or not settings.autoRotationSpam or settings.autoRotationSpam.enabled ~= true then
        return
    end

    local interval = settings.autoRotationSpam.intervalSeconds or 0.75
    TimerManager:Create(TimerManager.Categories.UI_NOTIFICATION, "floating_selector_rotation_spam", function()
        self:AutoRotationSpamTick()
    end, interval, true)
end

function FloatingSelector:AutoRotationSpamTick()
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    if not settings or not settings.autoRotationSpam or settings.autoRotationSpam.enabled ~= true then
        return
    end

    local rotationName = settings.autoRotationSpam.rotationName
    if not rotationName or rotationName == "" then
        return
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        return
    end
    if classModule.IsAutomaticRotationSwitchingEnabled and classModule:IsAutomaticRotationSwitchingEnabled() then
        self:SetAutoRotationSpamEnabled(false)
        return
    end

    local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0
    local rotations = classModule:GetAvailableRotations(specIndex)
    local config = rotations and rotations[rotationName]
    if not config then
        return
    end

    classModule:SelectRotation(specIndex, rotationName)
end

function FloatingSelector:SaveAnchorPosition(anchor)
    if not DisplayManager or not anchor then
        return
    end

    local point, relativeTo, relativePoint, x, y = anchor:GetPoint()
    if not point or not relativePoint then
        return
    end

    if anchor == NAG.GroupDisplayFrame then
        local gdf = DisplayManager.db.char.groupDisplayFrame
        gdf.point = point or "CENTER"
        gdf.relativePoint = relativePoint or "CENTER"
        gdf.offsetX = x or 0
        gdf.offsetY = y or 0
    elseif anchor == NAG.Frame then
        local fs = DisplayManager.db.char.frameSettings
        fs.point = point or "CENTER"
        fs.relativePoint = relativePoint or "CENTER"
        fs.offsetX = x or 0
        fs.offsetY = y or 0
        DisplayManager:UpdateFramePosition()
    end
end

function FloatingSelector:ShowBackgroundColorPicker(uiBackground)
    if not uiBackground or not uiBackground.db then
        return
    end

    local color = uiBackground.db.char.color or { 1, 1, 1, 1 }

    local function getAlphaFromPicker()
        if ColorPickerFrame and ColorPickerFrame.GetColorAlpha then
            return ColorPickerFrame:GetColorAlpha()
        end

        local opacity = ColorPickerFrame and ColorPickerFrame.opacity
        if _G.OpacitySliderFrame and _G.OpacitySliderFrame.GetValue then
            opacity = _G.OpacitySliderFrame:GetValue()
        end
        if opacity == nil then
            return color[4] or 1
        end
        return 1 - opacity
    end

        local function applyColor(r, g, b, a)
        local newColor = { r, g, b, a }
        if uiBackground.SetSetting then
            uiBackground:SetSetting("char", "color", newColor)
        else
            uiBackground.db.char.color = newColor
        end
            uiBackground:UpdateBackground()
            uiBackground:UpdateLockState()
        if AceConfigRegistry then
            AceConfigRegistry:NotifyChange("NAG")
        end
    end

    local info = {
        r = color[1],
        g = color[2],
        b = color[3],
        opacity = 1 - (color[4] or 1),
        hasOpacity = true,
        swatchFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = getAlphaFromPicker()
            applyColor(r, g, b, a)
        end,
        opacityFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = getAlphaFromPicker()
            applyColor(r, g, b, a)
        end,
        cancelFunc = function(previousValues)
            if not previousValues then
                return
            end
            local a = previousValues.a
            if a == nil then
                a = 1 - (previousValues.opacity or 0)
            end
            applyColor(previousValues.r, previousValues.g, previousValues.b, a)
        end,
    }

    LUIDropDownMenu:OpenColorPicker(info)
end

function FloatingSelector:ShowBackgroundScaleMenu(uiBackground)
    if not uiBackground or not uiBackground.db then
        return
    end

    if self.backgroundScaleMenu and self.backgroundScaleMenu:IsShown() then
        AceGUI:Release(self.backgroundScaleMenu)
        self.backgroundScaleMenu = nil
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["scale"] or "Scale")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(360)
    menu:SetHeight(140)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.backgroundScaleMenu == widget then
            self.backgroundScaleMenu = nil
        end
    end)
    self.backgroundScaleMenu = menu

    local scaleSlider = AceGUI:Create("Slider")
    scaleSlider:SetLabel(L["scale"] or "Scale")
    scaleSlider:SetSliderValues(0.5, 2.0, 0.01)
    scaleSlider:SetValue(uiBackground.db.char.scale or 1.0)
    scaleSlider:SetFullWidth(true)
    scaleSlider:SetCallback("OnValueChanged", function(_, _, value)
        self:SetBackgroundScale(uiBackground, value)
    end)
    menu:AddChild(scaleSlider)
end

function FloatingSelector:ShowAutoRotationSpamIntervalMenu()
    if self.autoRotationSpamIntervalMenu and self.autoRotationSpamIntervalMenu:IsShown() then
        AceGUI:Release(self.autoRotationSpamIntervalMenu)
        self.autoRotationSpamIntervalMenu = nil
        return
    end

    local settings = self.db and self.db.global and self.db.global.floatingSelector
    local spamSettings = settings and settings.autoRotationSpam
    if not spamSettings then
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["autoRotationSpamInterval"] or "Interval (s)")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(360)
    menu:SetHeight(140)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.autoRotationSpamIntervalMenu == widget then
            self.autoRotationSpamIntervalMenu = nil
        end
    end)
    self.autoRotationSpamIntervalMenu = menu

    local intervalSlider = AceGUI:Create("Slider")
    intervalSlider:SetLabel(L["autoRotationSpamInterval"] or "Interval (s)")
    intervalSlider:SetSliderValues(0.25, 5.0, 0.05)
    intervalSlider:SetValue(spamSettings.intervalSeconds or 0.75)
    intervalSlider:SetFullWidth(true)
    intervalSlider:SetCallback("OnValueChanged", function(_, _, value)
        self:SetAutoRotationSpamInterval(value)
    end)
    menu:AddChild(intervalSlider)
end

function FloatingSelector:ShowRetTwistHoldLeadTimeMenu(retTwistModule)
    if self.retTwistHoldLeadTimeMenu and self.retTwistHoldLeadTimeMenu:IsShown() then
        AceGUI:Release(self.retTwistHoldLeadTimeMenu)
        self.retTwistHoldLeadTimeMenu = nil
        return
    end

    if not retTwistModule then
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle("HOLD Lead Time (seconds)")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(360)
    menu:SetHeight(140)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.retTwistHoldLeadTimeMenu == widget then
            self.retTwistHoldLeadTimeMenu = nil
        end
    end)
    self.retTwistHoldLeadTimeMenu = menu

    local leadTimeSlider = AceGUI:Create("Slider")
    leadTimeSlider:SetLabel("HOLD Lead Time (seconds)")
    leadTimeSlider:SetSliderValues(0.0, 0.4, 0.01)
    leadTimeSlider:SetValue(getRetTwistSetting(retTwistModule, "holdCueLeadTimeSeconds", 0.1))
    leadTimeSlider:SetFullWidth(true)
    leadTimeSlider:SetCallback("OnValueChanged", function(_, _, value)
        setRetTwistSetting(retTwistModule, "holdCueLeadTimeSeconds", value)
    end)
    menu:AddChild(leadTimeSlider)
end

-- ============================ HUNTER ASPECT MANA THRESHOLDS ============================

--- Shows a popup with a Recommend Aspects checkbox and dual sliders for Viper/Hawk mana thresholds
--- @param classModule table The Hunter class module
function FloatingSelector:ShowHunterViperHawkMenu(classModule)
    if self.hunterViperHawkMenu and self.hunterViperHawkMenu:IsShown() then
        AceGUI:Release(self.hunterViperHawkMenu)
        self.hunterViperHawkMenu = nil
        return
    end

    if not classModule or not classModule.db or not classModule.db.class then
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle("Aspect Mana Thresholds")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(360)
    menu:SetHeight(220)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.hunterViperHawkMenu == widget then
            self.hunterViperHawkMenu = nil
        end
    end)
    self.hunterViperHawkMenu = menu

    local viperSlider, hawkSlider

    -- Hunter opt-in/out for automatic Viper management
    local recommendCheckbox = AceGUI:Create("CheckBox")
    recommendCheckbox:SetLabel("Manage Viper on low mana")
    recommendCheckbox:SetValue(classModule:GetSetting("class", "recommendAspects", true))
    recommendCheckbox:SetFullWidth(true)
    recommendCheckbox:SetCallback("OnValueChanged", function(_, _, value)
        classModule:SetSetting("class", "recommendAspects", value)
        if viperSlider then viperSlider:SetDisabled(not value) end
        if hawkSlider then hawkSlider:SetDisabled(not value) end
        self:UpdateAssignmentHintIcons()
    end)
    menu:AddChild(recommendCheckbox)

    local aspectsEnabled = classModule:GetSetting("class", "recommendAspects", true)

    -- Viper start slider (display as 5-50%, store as 0.05-0.50)
    viperSlider = AceGUI:Create("Slider")
    viperSlider:SetLabel("Switch to Viper at (% mana)")
    viperSlider:SetSliderValues(5, 50, 1)
    viperSlider:SetValue(math.floor((classModule:GetSetting("class", "viperStartManaPercent", 0.20) or 0.20) * 100 + 0.5))
    viperSlider:SetFullWidth(true)
    viperSlider:SetDisabled(not aspectsEnabled)
    viperSlider:SetCallback("OnValueChanged", function(_, _, value)
        local hawkValue = math.floor((classModule:GetSetting("class", "viperStopManaPercent", 0.40) or 0.40) * 100 + 0.5)
        if value >= hawkValue - 4 then
            value = hawkValue - 5
            if value < 5 then value = 5 end
            viperSlider:SetValue(value)
        end
        classModule:SetSetting("class", "viperStartManaPercent", value / 100)
    end)
    menu:AddChild(viperSlider)

    -- Hawk restart slider (display as 10-80%, store as 0.10-0.80)
    hawkSlider = AceGUI:Create("Slider")
    hawkSlider:SetLabel("Switch back to Hawk at (% mana)")
    hawkSlider:SetSliderValues(10, 80, 1)
    hawkSlider:SetValue(math.floor((classModule:GetSetting("class", "viperStopManaPercent", 0.40) or 0.40) * 100 + 0.5))
    hawkSlider:SetFullWidth(true)
    hawkSlider:SetDisabled(not aspectsEnabled)
    hawkSlider:SetCallback("OnValueChanged", function(_, _, value)
        local viperValue = math.floor((classModule:GetSetting("class", "viperStartManaPercent", 0.20) or 0.20) * 100 + 0.5)
        if value <= viperValue + 4 then
            value = viperValue + 5
            if value > 80 then value = 80 end
            hawkSlider:SetValue(value)
        end
        classModule:SetSetting("class", "viperStopManaPercent", value / 100)
    end)
    menu:AddChild(hawkSlider)
end

-- ============================ HUNTER FILLER CLIP TOLERANCE ============================

--- Shows a popup with a slider for filler clip tolerance (0-0.5s). Stored in TBCHunterAPI.
--- @param classModule table The Hunter class module (unused; setting lives in TBCHunterAPI)
function FloatingSelector:ShowHunterFillerClipToleranceMenu(classModule)
    if self.hunterFillerClipMenu and self.hunterFillerClipMenu:IsShown() then
        AceGUI:Release(self.hunterFillerClipMenu)
        self.hunterFillerClipMenu = nil
        return
    end

    local api = NAG:GetModule("TBCHunterAPI", true)
    if not api or not api.db or not api.db.class then
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle("Filler Clip Tolerance")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(320)
    menu:SetHeight(120)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.hunterFillerClipMenu == widget then
            self.hunterFillerClipMenu = nil
        end
    end)
    self.hunterFillerClipMenu = menu

    local current = api.db.class.fillerClipToleranceSeconds
    if type(current) ~= "number" or current < 0 or current > 0.5 then
        current = 0.2
    end

    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Allowed clip (seconds): 0 = strict, 0.5 = relaxed")
    slider:SetSliderValues(0, 0.5, 0.05)
    slider:SetValue(current)
    slider:SetFullWidth(true)
    slider:SetCallback("OnValueChanged", function(_, _, value)
        api.db.class.fillerClipToleranceSeconds = value
    end)
    menu:AddChild(slider)
end

function FloatingSelector:ShowRetTwistHoldShineScaleMenu(retTwistModule)
    if self.retTwistHoldShineScaleMenu and self.retTwistHoldShineScaleMenu:IsShown() then
        AceGUI:Release(self.retTwistHoldShineScaleMenu)
        self.retTwistHoldShineScaleMenu = nil
        return
    end

    if not retTwistModule then
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle("HOLD Shine Size")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(360)
    menu:SetHeight(140)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.retTwistHoldShineScaleMenu == widget then
            self.retTwistHoldShineScaleMenu = nil
        end
    end)
    self.retTwistHoldShineScaleMenu = menu

    local shineScaleSlider = AceGUI:Create("Slider")
    shineScaleSlider:SetLabel("HOLD Shine Size")
    shineScaleSlider:SetSliderValues(0.5, 2.5, 0.05)
    shineScaleSlider:SetValue(getRetTwistSetting(retTwistModule, "holdCueShineScale", 1.0))
    shineScaleSlider:SetFullWidth(true)
    shineScaleSlider:SetCallback("OnValueChanged", function(_, _, value)
        setRetTwistSetting(retTwistModule, "holdCueShineScale", value)
    end)
    menu:AddChild(shineScaleSlider)
end

function FloatingSelector:ShowFloatingIconColorPicker()
    if not self.db or not self.db.global or not self.db.global.floatingSelector then
        return
    end

    local settings = self.db.global.floatingSelector
    local color = settings.iconColor or { 1, 1, 1, 1 }

    -- WoW Color Picker alpha slider: top (+) = 1, bottom (-) = 0. We want top = visible (alpha 1), bottom = invisible (alpha 0).
    -- So we invert: stored alpha = 1 - picker value; pass to picker opacity = 1 - alpha.
    local function getAlphaFromPicker()
        local raw
        if ColorPickerFrame and ColorPickerFrame.GetColorAlpha then
            raw = ColorPickerFrame:GetColorAlpha()
        else
            raw = ColorPickerFrame and ColorPickerFrame.opacity or (color[4] or 1)
        end
        return 1 - (raw or 0)
    end

    local function applyColor(r, g, b, a)
        settings.iconColor = { r, g, b, a }
        self:UpdateFloatingIcon()
        if AceConfigRegistry then
            AceConfigRegistry:NotifyChange("NAG")
        end
    end

    local info = {
        r = color[1],
        g = color[2],
        b = color[3],
        opacity = 1 - (color[4] or 1),
        hasOpacity = true,
        swatchFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            applyColor(r, g, b, getAlphaFromPicker())
        end,
        opacityFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            applyColor(r, g, b, getAlphaFromPicker())
        end,
        cancelFunc = function(previousValues)
            if not previousValues then
                return
            end
            local a = previousValues.a
            if a == nil then
                a = 1 - (previousValues.opacity or 0)
            end
            applyColor(previousValues.r, previousValues.g, previousValues.b, a)
        end,
    }

    LUIDropDownMenu:OpenColorPicker(info)
end

function FloatingSelector:EnsureDisableConfirmDialog()
    if not StaticPopupDialogs or StaticPopupDialogs.NAG_DISABLE_ADDON_CONFIRM then
        return
    end

    StaticPopupDialogs.NAG_DISABLE_ADDON_CONFIRM = {
        text = L["disableNagConfirm"] or
            "Hide the NAG frames and background? The floating icon will remain visible. Re-enable with /nag enable.",
        button1 = L["disable"] or "Disable",
        button2 = L["cancel"] or "Cancel",
        OnAccept = function()
            self:SetDisplaySuppressed(true)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
end

function FloatingSelector:EnsureHideGcdSwipeConfirmDialog()
    if not StaticPopupDialogs or StaticPopupDialogs.NAG_HIDE_GCD_SWIPE_CONFIRM then
        return
    end

    local moduleRef = self
    StaticPopupDialogs.NAG_HIDE_GCD_SWIPE_CONFIRM = {
        text = L["hideGcdSwipeConfirm"] or
            "Hide the GCD swipe overlay? This disables cooldown swipe animations on the suggestion icons.",
        button1 = L["confirm"] or "Hide",
        button2 = L["cancel"] or "Cancel",
        OnAccept = function()
            moduleRef:SetCooldownSwipesEnabled(false)
        end,
        OnCancel = function()
            if AceConfigRegistry then
                AceConfigRegistry:NotifyChange("NAG")
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
end

function FloatingSelector:ShowHideGcdSwipeConfirm()
    self:EnsureHideGcdSwipeConfirmDialog()
    StaticPopup_Show("NAG_HIDE_GCD_SWIPE_CONFIRM")
end

function FloatingSelector:ShowDisableConfirm()
    self:EnsureDisableConfirmDialog()
    StaticPopup_Show("NAG_DISABLE_ADDON_CONFIRM")
end

function FloatingSelector:CloseAssignmentDropdowns()
    if LUIDropDownMenu and LUIDropDownMenu.CloseDropDownMenus then
        LUIDropDownMenu:CloseDropDownMenus()
        return
    end
    if CloseDropDownMenus then
        CloseDropDownMenus()
    end
end

function FloatingSelector:EnsureTotemTwistNeverConfirmDialog()
    if not StaticPopupDialogs or StaticPopupDialogs.NAG_TOTEM_TWIST_NEVER_CONFIRM then
        return
    end

    local moduleRef = self
    StaticPopupDialogs.NAG_TOTEM_TWIST_NEVER_CONFIRM = {
        text = L["totemTwistNeverConfirm"] or
            "Totem twisting is important for your melee group.\n\n" ..
            "If done correctly (often during downtime), it will not hurt your DPS.\n\n" ..
            "Are you sure you want to disable totem twisting?",
        button1 = L["confirm"] or "Confirm",
        button2 = L["cancel"] or "Cancel",
        OnAccept = function(_, data)
            if data and data.classModule and data.assignmentIds and data.selectedId then
                moduleRef:SetAssignmentRadioSelection(data.classModule, data.assignmentIds, data.selectedId)
            end
        end,
        OnCancel = function()
            if AceConfigRegistry then
                AceConfigRegistry:NotifyChange("NAG")
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
end

function FloatingSelector:ShowTotemTwistNeverConfirm(classModule, assignmentIds, selectedId)
    self:EnsureTotemTwistNeverConfirmDialog()
    StaticPopup_Show("NAG_TOTEM_TWIST_NEVER_CONFIRM", nil, nil, {
        classModule = classModule,
        assignmentIds = assignmentIds,
        selectedId = selectedId,
    })
end

function FloatingSelector:SetAssignmentRadioSelection(classModule, assignmentIds, selectedId)
    if not classModule or not assignmentIds then
        return
    end
    for _, assignmentId in ipairs(assignmentIds) do
        classModule:ToggleAssignment(assignmentId, assignmentId == selectedId)
    end
    self:CloseAssignmentDropdowns()
end

function FloatingSelector:SetDisplaySuppressed(suppressed)
    if not DisplayManager or not DisplayManager.SetDisplaySuppressed then
        self:Warn("SetDisplaySuppressed: DisplayManager not available")
        return
    end

    DisplayManager:SetDisplaySuppressed(suppressed == true)
    local uiBackground = self:GetUIBackgroundModule()
    if uiBackground and uiBackground.UpdateLockState then
        uiBackground:UpdateLockState()
    end
end

function FloatingSelector:GetDisplayScale()
    if not DisplayManager or not DisplayManager.db then
        return 1
    end

    if DisplayManager:IsGroupDisplayMode() then
        return DisplayManager:GetSetting("char", "groupDisplayFrame.masterScale") or 1
    end

    return DisplayManager:GetSetting("char", "frameSettings.scale") or 1
end

function FloatingSelector:SetDisplayScale(scale)
    if not DisplayManager then
        self:Warn("SetDisplayScale: DisplayManager not available")
        return
    end

    if DisplayManager:IsGroupDisplayMode() then
        DisplayManager:SetSetting("char", "groupDisplayFrame.masterScale", scale)
        if NAG.GroupDisplayFrame then
            NAG.GroupDisplayFrame:SetScale(scale)
        end
        DisplayManager:SendMessage("NAG_FRAME_UPDATED")
        return
    end

    DisplayManager:SetSetting("char", "frameSettings.scale", scale)
    DisplayManager:UpdateFrameScale()
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

function FloatingSelector:ShowThrottleSettingsMenu()
    if self.throttleSettingsMenu and self.throttleSettingsMenu:IsShown() then
        AceGUI:Release(self.throttleSettingsMenu)
        self.throttleSettingsMenu = nil
        return
    end

    if not OptionsManager then
        self:Warn("ShowThrottleSettingsMenu: OptionsManager not available")
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["addonSettings"] or "Addon Settings")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(360)
    menu:SetHeight(140)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.throttleSettingsMenu == widget then
            self.throttleSettingsMenu = nil
        end
    end)
    self.throttleSettingsMenu = menu

    local throttleSlider = AceGUI:Create("Slider")
    throttleSlider:SetLabel(L["throttleInterval"] or "Throttle Interval")
    throttleSlider:SetSliderValues(0.01, 1.0, 0.01)
    throttleSlider:SetValue(OptionsManager:GetSetting("global", "throttleInterval", 0.1))
    throttleSlider:SetFullWidth(true)
    throttleSlider:SetCallback("OnValueChanged", function(_, _, value)
        OptionsManager:SetSetting("global", "throttleInterval", value)
    end)
    menu:AddChild(throttleSlider)
end

function FloatingSelector:ShowFrameScaleMenu()
    if self.frameScaleMenu and self.frameScaleMenu:IsShown() then
        AceGUI:Release(self.frameScaleMenu)
        self.frameScaleMenu = nil
        return
    end

    if not DisplayManager then
        self:Warn("ShowFrameScaleMenu: DisplayManager not available")
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["frameScale"] or "Frame Scale")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(360)
    menu:SetHeight(140)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.frameScaleMenu == widget then
            self.frameScaleMenu = nil
        end
    end)
    self.frameScaleMenu = menu

    local scaleSlider = AceGUI:Create("Slider")
    scaleSlider:SetLabel(L["scale"] or "Scale")
    scaleSlider:SetSliderValues(0.5, 2.0, 0.01)
    scaleSlider:SetValue(self:GetDisplayScale())
    scaleSlider:SetFullWidth(true)
    scaleSlider:SetCallback("OnValueChanged", function(_, _, value)
        self:SetDisplayScale(value)
    end)
    menu:AddChild(scaleSlider)
end

function FloatingSelector:OpenKeybindManagerOptions()
    local dialog = AceConfigDialog
    if not dialog then
        return
    end

    dialog:SelectGroup("NAG", "ui", "KeybindManager")
    dialog:Open("NAG")
end

function FloatingSelector:OpenSpellPositionsOptions()
    local dialog = AceConfigDialog
    if not dialog then
        return
    end

    dialog:SelectGroup("NAG", "ui", "DisplayManager", "groupControl", "mappingOptions")
    dialog:Open("NAG")
end

function FloatingSelector:OpenRotationManager()
    local RotationManager = NAG:GetModule("RotationManager")
    if RotationManager and RotationManager.Toggle then
        RotationManager:Toggle()
    end
end

function FloatingSelector:QueueFeedbackTicket(categoryKey, categoryLabel, description)
    if not NAG or not NAG.db or not NAG.db.global then
        self:Warn("QueueFeedbackTicket: NAG database not ready")
        return false
    end

    local queue = NAG.db.global.feedbackQueue
    if type(queue) ~= "table" then
        queue = {}
    end

    local createdAt = time and time() or 0
    local ticketId = tostring(createdAt) .. "-" .. tostring(mathRandom(1000, 9999))
    local addonVersion = NAG.GetCurrentVersion and NAG:GetCurrentVersion() or "?"
    local clientFlavor = Version and Version.GetExpansion and Version:GetExpansion() or "unknown"

    tinsert(queue, {
        id = ticketId,
        category = categoryKey,
        categoryLabel = categoryLabel,
        description = description,
        createdAt = createdAt,
        addonVersion = addonVersion,
        clientFlavor = clientFlavor,
    })

    NAG.db.global.feedbackQueue = queue
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
    return true
end

function FloatingSelector:ShowFeedbackMenu()
    if self.feedbackMenu and self.feedbackMenu:IsShown() then
        AceGUI:Release(self.feedbackMenu)
        self.feedbackMenu = nil
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["helpImproveTitle"] or "Help Improve")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(520)
    menu:SetHeight(420)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.feedbackMenu == widget then
            self.feedbackMenu = nil
        end
    end)
    self.feedbackMenu = menu

    local step1Group = AceGUI:Create("InlineGroup")
    step1Group:SetTitle(L["feedbackStep1Title"] or "Step 1: Choose a category")
    step1Group:SetLayout("List")
    step1Group:SetFullWidth(true)
    menu:AddChild(step1Group)

    local noticeLabel = AceGUI:Create("Label")
    noticeLabel:SetText(L["feedbackRequiresHelper"] or
        ("Tickets require the NAGHelper app from " .. HELPER_DISCORD_URL .. " or " .. HELPER_DOWNLOAD_URL))
    noticeLabel:SetFullWidth(true)
    step1Group:AddChild(noticeLabel)

    local linkLabel = AceGUI:Create("Label")
    linkLabel:SetText(L["feedbackDownloadLink"] or "Download Link")
    linkLabel:SetFullWidth(true)
    step1Group:AddChild(linkLabel)

    local linkInput = AceGUI:Create("EditBox")
    linkInput:SetText(HELPER_DOWNLOAD_URL)
    linkInput:SetFullWidth(true)
    local linkLock = false
    linkInput:SetCallback("OnTextChanged", function(widget, _, text)
        if linkLock then
            return
        end
        if text ~= HELPER_DOWNLOAD_URL then
            linkLock = true
            widget:SetText(HELPER_DOWNLOAD_URL)
            linkLock = false
        end
    end)
    step1Group:AddChild(linkInput)

    local categoryLabel = AceGUI:Create("Label")
    categoryLabel:SetText(L["feedbackCategoryLabel"] or "Category")
    categoryLabel:SetFullWidth(true)
    step1Group:AddChild(categoryLabel)

    local categoryList = {
        bug = L["feedbackCategoryBug"] or "Bug report",
        rotation = L["feedbackCategoryRotation"] or "Rotation suggestion/issue",
        ui = L["feedbackCategoryUI"] or "UI/UX feedback",
        feature = L["feedbackCategoryFeature"] or "Feature request",
        performance = L["feedbackCategoryPerformance"] or "Performance issue",
    }

    local state = { categoryKey = nil, description = "" }

    local categoryDropdown = AceGUI:Create("Dropdown")
    categoryDropdown:SetList(categoryList)
    categoryDropdown:SetFullWidth(true)
    categoryDropdown:SetCallback("OnValueChanged", function(_, _, value)
        state.categoryKey = value
    end)
    step1Group:AddChild(categoryDropdown)

    local step2Group = AceGUI:Create("InlineGroup")
    step2Group:SetTitle(L["feedbackStep2Title"] or "Step 2: Describe")
    step2Group:SetLayout("List")
    step2Group:SetFullWidth(true)
    menu:AddChild(step2Group)

    local descriptionInput = AceGUI:Create("MultiLineEditBox")
    descriptionInput:SetLabel(L["feedbackDescriptionLabel"] or "Description")
    descriptionInput:SetText("")
    descriptionInput:SetNumLines(8)
    descriptionInput:SetFullWidth(true)
    descriptionInput:SetCallback("OnTextChanged", function(_, _, text)
        state.description = text or ""
    end)
    step2Group:AddChild(descriptionInput)

    local buttonsGroup = AceGUI:Create("SimpleGroup")
    buttonsGroup:SetLayout("Flow")
    buttonsGroup:SetFullWidth(true)
    step2Group:AddChild(buttonsGroup)

    local submitButton = AceGUI:Create("Button")
    submitButton:SetText(L["feedbackSubmit"] or "Submit")
    submitButton:SetCallback("OnClick", function()
        if not state.categoryKey then
            NAG:Print(L["feedbackMissingCategory"] or "Please select a category.")
            return
        end
        if not state.description or state.description:gsub("%s+", "") == "" then
            NAG:Print(L["feedbackMissingDescription"] or "Please enter a description.")
            return
        end

        local categoryLabelText = categoryList[state.categoryKey] or state.categoryKey
        if self:QueueFeedbackTicket(state.categoryKey, categoryLabelText, state.description) then
            NAG:Print(L["feedbackSubmitted"] or "Feedback ticket queued.")
            AceGUI:Release(menu)
            self.feedbackMenu = nil
        end
    end)
    buttonsGroup:AddChild(submitButton)

    local cancelButton = AceGUI:Create("Button")
    cancelButton:SetText(L["feedbackCancel"] or "Cancel")
    cancelButton:SetCallback("OnClick", function()
        AceGUI:Release(menu)
        self.feedbackMenu = nil
    end)
    buttonsGroup:AddChild(cancelButton)

end

function FloatingSelector:BuildRotationMenuList()
    local classModule = NAG:GetClassModule()
    if not classModule then
        return nil
    end

    local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0
    local rotations, displayNames = classModule:GetAvailableRotations(specIndex)
    local currentRotationName = select(2, classModule:GetCurrentRotation())

    local rotationListForSorting = {}
    for name in pairs(rotations) do
        tinsert(rotationListForSorting, {
            name = name,
            displayName = displayNames[name] or name,
            isSelected = (name == currentRotationName)
        })
    end

    if #rotationListForSorting == 0 then
        return nil
    end

    tsort(rotationListForSorting, function(a, b) return a.displayName < b.displayName end)

    local menuList = {}
    for _, rotInfo in ipairs(rotationListForSorting) do
        tinsert(menuList, {
            text = rotInfo.isSelected and ("|cff00ff00" .. rotInfo.displayName .. "|r") or rotInfo.displayName,
            value = rotInfo.name,
            func = function()
                classModule:SelectRotation(specIndex, rotInfo.name)
            end,
            checked = rotInfo.isSelected,
        })
    end

    return menuList
end

function FloatingSelector:BuildAutoRotationSpamMenuList()
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    local spamSettings = settings and settings.autoRotationSpam or {}
    local enabled = spamSettings.enabled == true
    local selectedRotation = spamSettings.rotationName
    local classModule = NAG:GetClassModule()

    local rotationMenuList = {}
    if classModule then
        local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0
        local rotations, displayNames = classModule:GetAvailableRotations(specIndex)
    local rotationListForSorting = {}
    for name in pairs(rotations or {}) do
        tinsert(rotationListForSorting, {
            name = name,
            displayName = displayNames[name] or name,
        })
    end
        tsort(rotationListForSorting, function(a, b) return a.displayName < b.displayName end)
        for _, rotInfo in ipairs(rotationListForSorting) do
            tinsert(rotationMenuList, {
                text = rotInfo.displayName,
                checked = rotInfo.name == selectedRotation,
                isNotRadio = false,
                keepShownOnClick = true,
                func = function()
                    spamSettings.rotationName = rotInfo.name
                    settings.autoRotationSpam = spamSettings
                    if AceConfigRegistry then
                        AceConfigRegistry:NotifyChange("NAG")
                    end
                end
            })
        end
    end

    if #rotationMenuList == 0 then
        rotationMenuList = {
            { text = L["disabled"] or "No rotations available", notCheckable = true }
        }
    end

    return {
        text = L["autoRotationSpam"] or "Auto Rotation Spam",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = enabled and "Enabled" or "Enable",
                checked = enabled,
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    self:SetAutoRotationSpamEnabled(not enabled)
                end
            },
            {
                text = L["autoRotationSpamSelectRotation"] or "Select Rotation",
                hasArrow = true,
                notCheckable = true,
                menuList = rotationMenuList
            },
            {
                text = L["autoRotationSpamInterval"] or "Interval (s)",
                notCheckable = true,
                func = function()
                    self:ShowAutoRotationSpamIntervalMenu()
                end
            },
        }
    }
end

function FloatingSelector:BuildBackgroundMenuList()
    local uiBackground = self:GetUIBackgroundModule()
    if not uiBackground or not uiBackground.db then
        return {
            text = L["background"] or "Background",
            hasArrow = true,
            notCheckable = true,
            menuList = {
                { text = L["disabled"] or "Disabled", notCheckable = true }
            }
        }
    end

    local selectedBackground = uiBackground.db.char.selectedBackground
    local backgrounds = uiBackground:GetBackgroundList()
    local entries = {}

    for key, label in pairs(backgrounds or {}) do
        tinsert(entries, { key = key, label = label })
    end
    tsort(entries, function(a, b) return a.label < b.label end)

    local selectMenuList = {}
    for _, entry in ipairs(entries) do
        tinsert(selectMenuList, {
            text = entry.label,
            checked = entry.key == selectedBackground,
            isNotRadio = false,
            keepShownOnClick = true,
            func = function()
                if uiBackground.SetSetting then
                    uiBackground:SetSetting("char", "selectedBackground", entry.key)
                else
                    uiBackground.db.char.selectedBackground = entry.key
                end
                uiBackground:UpdateBackground()
                if AceConfigRegistry then
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end
        })
    end

    local backgroundMenuList = {
        {
            text = L["select"] or "Select",
            hasArrow = true,
            notCheckable = true,
            menuList = selectMenuList
        },
        {
            text = L["colorTransparency"] or "Color/Transparency",
            notCheckable = true,
            func = function()
                self:ShowBackgroundColorPicker(uiBackground)
            end
        },
        {
            text = L["scale"] or "Scale",
            notCheckable = true,
            func = function()
                self:ShowBackgroundScaleMenu(uiBackground)
            end
        },
        {
            text = L["settings"] or "Settings",
            notCheckable = true,
            func = function()
                local dialog = AceConfigDialog
                if dialog.OpenFrames and dialog.OpenFrames["NAG"] then
                    dialog:Close("NAG")
                else
                    dialog:Open("NAG")
                end
            end
        },
        {
            text = L["backgroundEnabled"] or "Background Enabled",
            checked = uiBackground.db.char.enabled == true,
            isNotRadio = true,
            keepShownOnClick = true,
            func = function()
                local newState = uiBackground.db.char.enabled ~= true
                if uiBackground.SetSetting then
                    uiBackground:SetSetting("char", "enabled", newState)
                else
                    uiBackground.db.char.enabled = newState
                end
                if newState then
                    uiBackground:Enable()
                else
                    uiBackground:Disable()
                end
                uiBackground:UpdateLockState()
                if AceConfigRegistry then
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end
        },
    }

    return {
        text = L["background"] or "Background",
        hasArrow = true,
        notCheckable = true,
        menuList = backgroundMenuList
    }
end

function FloatingSelector:BuildAssignmentsSubmenu(classModule)
    if not classModule or not classModule.defaults or not classModule.defaults.class then
        return nil
    end
    if classModule.IsClassAssignmentsEnabled and not classModule:IsClassAssignmentsEnabled() then
        return nil
    end

    local assignments = classModule.defaults.class.classAssignments or {}

    -- Check for class-specific options that should show even without classAssignments
    local isPaladin = classModule.GetName and classModule:GetName() == "PALADIN"
    local isRogue = classModule.GetName and classModule:GetName() == "ROGUE"
    local isDruid = classModule.GetName and classModule:GetName() == "DRUID"
    local isProtection = isPaladin and SpecCompat and SpecCompat.GetCurrentSpecIndex
        and SpecCompat:GetCurrentSpecIndex() == 2
    local isRetribution = isPaladin and SpecCompat and SpecCompat.GetCurrentSpecIndex
        and SpecCompat:GetCurrentSpecIndex() == 3
    local isFeralDruid = isDruid and SpecCompat and SpecCompat.GetCurrentSpecIndex
        and SpecCompat:GetCurrentSpecIndex() == DRUID_FERAL_SPEC_INDEX
    local isHunter = classModule.GetName and classModule:GetName() == "HUNTER"
    local hasRetTwistOptions = isRetribution and ns.PaladinRetTwistModule and ns.PaladinRetTwistModule.db
    local hasProtOptions = isProtection and classModule.db and classModule.db.char
    local hasRogueOptions = isRogue and classModule.db and classModule.db.char
    local hasFeralDruidOptions = isFeralDruid and classModule.db and classModule.db.char
    local hasHunterOptions = isHunter and classModule.db and classModule.db.class

    -- Return nil only if no assignments AND no class-specific options
    if (not assignments or #assignments == 0)
        and (not hasRetTwistOptions)
        and (not hasProtOptions)
        and (not hasRogueOptions)
        and (not hasFeralDruidOptions)
        and (not hasHunterOptions) then
        return nil
    end

    local allowMultiple = classModule.AllowsMultipleAssignments and classModule:AllowsMultipleAssignments() or false
    local selectedId = classModule.GetSelectedAssignmentId and classModule:GetSelectedAssignmentId() or nil
    local states = classModule.GetAssignmentStates and classModule:GetAssignmentStates() or {}
    local isShaman = classModule.GetName and classModule:GetName() == "SHAMAN"
    local isEnhancement = isShaman and SpecCompat and SpecCompat.GetCurrentSpecIndex
        and SpecCompat:GetCurrentSpecIndex() == 2
    local hasEnabled = false
    for _, assignment in ipairs(assignments) do
        local enabled = states[assignment.id] == true
        if enabled then
            if not (isShaman and assignment.category == "config") then
                hasEnabled = true
                break
            end
        end
    end
    local menuList = {
        {
            text = L["assignmentNone"] or "None",
            checked = allowMultiple and (not hasEnabled) or selectedId == nil,
            isNotRadio = allowMultiple,
            keepShownOnClick = allowMultiple,
            func = function()
                if isShaman then
                    for _, assignment in ipairs(assignments) do
                        if assignment.category ~= "config" then
                            classModule:ToggleAssignment(assignment.id, false)
                        end
                    end
                    return
                end
                classModule:SetSelectedAssignmentId(nil)
            end
        }
    }

    -- Paladin Protection: Seal twist toggle (stored as `protNeverSealTwist`, but shown as "enabled")
    if isProtection and classModule.db and classModule.db.char then
        tinsert(menuList, {
            text = "Enable seal twisting as Prot",
            checked = classModule.db.char.protNeverSealTwist ~= true,
            isNotRadio = true,
            keepShownOnClick = true,
            func = function()
                local currentEnabled = classModule.db.char.protNeverSealTwist ~= true
                local newEnabled = not currentEnabled
                classModule.db.char.protNeverSealTwist = not newEnabled
                if AceConfigRegistry then
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end
        })
    end

    if isRogue and classModule.db and classModule.db.char then
        tinsert(menuList, {
            text = "Save energy for kicks",
            checked = classModule.db.char.saveEnergyForKicks == true,
            isNotRadio = true,
            keepShownOnClick = true,
            func = function()
                local current = classModule.db and classModule.db.char and classModule.db.char.saveEnergyForKicks == true
                classModule:SetSetting("char", "saveEnergyForKicks", not current)
            end
        })
    end

    if isFeralDruid and classModule.db and classModule.db.char then
        local shredSpellIcon = ""
        local shredInfo = WoWAPI.GetSpellInfo(SHRED_SPELL_ID)
        if shredInfo and shredInfo.iconID then
            shredSpellIcon = string.format("|T%s:16:16:0:0|t ", shredInfo.iconID)
        end

        tinsert(menuList, {
            text = shredSpellIcon .. "Shred Assignment",
            checked = NAG.IsFeralShredAssignmentEnabled and NAG:IsFeralShredAssignmentEnabled() or false,
            isNotRadio = true,
            keepShownOnClick = true,
            func = function()
                local currentlyEnabled = NAG.IsFeralShredAssignmentEnabled and NAG:IsFeralShredAssignmentEnabled() or false
                local newState = not currentlyEnabled
                if classModule.SetSetting then
                    classModule:SetSetting("char", FERAL_SHRED_ASSIGNMENT_KEY, newState)
                else
                    classModule.db.char[FERAL_SHRED_ASSIGNMENT_KEY] = newState
                end
            end
        })
    end

    -- Hunter: Viper mana management controls
    if isHunter and classModule.db and classModule.db.class then
        local manageViperEnabled = classModule.GetSetting and classModule:GetSetting("class", "recommendAspects", true) == true
        local viperInPercent = math.floor(((classModule.GetSetting and classModule:GetSetting("class", "viperStartManaPercent", 0.20)) or 0.20) * 100 + 0.5)
        local hawkOutPercent = math.floor(((classModule.GetSetting and classModule:GetSetting("class", "viperStopManaPercent", 0.40)) or 0.40) * 100 + 0.5)

        tinsert(menuList, {
            text = "Manage Viper on low mana",
            checked = manageViperEnabled,
            isNotRadio = true,
            keepShownOnClick = true,
            func = function()
                local current = classModule.GetSetting and classModule:GetSetting("class", "recommendAspects", true) == true
                local newValue = not current
                if classModule.SetSetting then
                    classModule:SetSetting("class", "recommendAspects", newValue)
                else
                    classModule.db.class.recommendAspects = newValue
                end
                self:UpdateAssignmentHintIcons()
            end
        })

        tinsert(menuList, {
            text = string.format("Aspect Mana Thresholds (%d%% in / %d%% out)", viperInPercent, hawkOutPercent),
            notCheckable = true,
            disabled = not manageViperEnabled,
            func = function()
                self:ShowHunterViperHawkMenu(classModule)
            end
        })

        -- TBC Hunter: filler clip tolerance (MS/AR safety formula)
        local hunterAPI = NAG:GetModule("TBCHunterAPI", true)
        if hunterAPI and hunterAPI.db and hunterAPI.db.class then
            local clipVal = hunterAPI.db.class.fillerClipToleranceSeconds
            if type(clipVal) ~= "number" or clipVal < 0 or clipVal > 0.5 then
                clipVal = 0.2
            end
            tinsert(menuList, {
                text = string.format("Filler clip tolerance (%.2fs)", clipVal),
                notCheckable = true,
                func = function()
                    self:ShowHunterFillerClipToleranceMenu(classModule)
                end
            })
        end
    end

    if isEnhancement then
        local totemTwistAssignments = {
            "shaman_totem_twist_group_only",
            "shaman_totem_twist_force",
            "shaman_totem_twist_never",
        }
        local magmaStAssignments = {
            "shaman_magma_st_always",
            "shaman_magma_st_encounter_only",
            "shaman_magma_st_never",
        }
        tinsert(menuList, {
            text = L["totemTwist"] or "Totem Twist",
            hasArrow = true,
            notCheckable = true,
            menuList = {
                {
                    text = L["totemTwistGroupOnly"] or "Totem Twist only when melees in group",
                    checked = states.shaman_totem_twist_group_only == true,
                    isNotRadio = false,
                    keepShownOnClick = false,
                    func = function()
                        self:SetAssignmentRadioSelection(classModule, totemTwistAssignments, "shaman_totem_twist_group_only")
                    end
                },
                {
                    text = L["totemTwistForce"] or "Force totem twist on",
                    checked = states.shaman_totem_twist_force == true,
                    isNotRadio = false,
                    keepShownOnClick = false,
                    func = function()
                        self:SetAssignmentRadioSelection(classModule, totemTwistAssignments, "shaman_totem_twist_force")
                    end
                },
                {
                    text = L["totemTwistNever"] or "Never Totem Twist",
                    checked = states.shaman_totem_twist_never == true,
                    isNotRadio = false,
                    keepShownOnClick = false,
                    func = function()
                        self:CloseAssignmentDropdowns()
                        self:ShowTotemTwistNeverConfirm(classModule, totemTwistAssignments,
                            "shaman_totem_twist_never")
                    end
                },
            }
        })
        tinsert(menuList, {
            text = L["magmaTotemSingleTarget"] or "Magma Totem (Single Target)",
            hasArrow = true,
            notCheckable = true,
            menuList = {
                {
                    text = L["magmaTotemSingleTargetAlways"] or "Always use Magma Totem on single target",
                    checked = states.shaman_magma_st_always == true,
                    isNotRadio = false,
                    keepShownOnClick = false,
                    func = function()
                        self:SetAssignmentRadioSelection(classModule, magmaStAssignments, "shaman_magma_st_always")
                    end
                },
                {
                    text = L["magmaTotemSingleTargetEncounterOnly"] or
                        "Use Magma Totem on single target only when in encounters",
                    checked = states.shaman_magma_st_encounter_only == true,
                    isNotRadio = false,
                    keepShownOnClick = false,
                    func = function()
                        self:SetAssignmentRadioSelection(classModule, magmaStAssignments,
                            "shaman_magma_st_encounter_only")
                    end
                },
                {
                    text = L["magmaTotemSingleTargetNever"] or "Never use Magma Totem on single targets",
                    checked = states.shaman_magma_st_never == true,
                    isNotRadio = false,
                    keepShownOnClick = false,
                    func = function()
                        self:SetAssignmentRadioSelection(classModule, magmaStAssignments, "shaman_magma_st_never")
                    end
                },
            }
        })
    end

    -- Paladin Retribution: Self-Apply Judgement of the Crusader options
    if isRetribution then
        local retTwistModule = ns.PaladinRetTwistModule
        if retTwistModule and retTwistModule.db and retTwistModule.db.class then
            local selfApplyEnabled = retTwistModule.db.class.selfApplyJudgementOfCrusader == true
            local selfApplyForced = retTwistModule.db.class.selfApplyJudgementOfCrusaderForced == true
            local selfApplySoloForced = retTwistModule.db.class.selfApplyJudgementOfCrusaderSoloForced == true
            tinsert(menuList, {
                text = L["selfApplyImpSoC"] or "Judgement of the Crusader",
                hasArrow = true,
                notCheckable = true,
                tooltipTitle = L["selfApplyImpSoCTooltipTitle"] or "Self-Apply Judgement of the Crusader",
                tooltipText = L["selfApplyImpSoCTooltipText"] or "Configure whether NAG guides you to apply the Judgement of the Crusader debuff yourself during the pull phase (from range).",
                tooltipOnButton = true,
                menuList = {
                    {
                        text = L["selfApplyImpSoCEnabled"] or "Auto-Apply (2 or fewer Paladins)",
                        checked = selfApplyEnabled,
                        isNotRadio = true,
                        keepShownOnClick = true,
                        tooltipTitle = L["selfApplyImpSoCEnabledTooltipTitle"] or "Enable Auto-Apply",
                        tooltipText = L["selfApplyImpSoCEnabledTooltipText"] or "When enabled, NAG will guide you to apply Seal of the Crusader and Judge it from range when there are 2 or fewer Paladins in your group.\n\nThis ensures the +3% crit debuff is on the target before you engage.",
                        tooltipOnButton = true,
                        func = function()
                            retTwistModule:SetSetting("class", "selfApplyJudgementOfCrusader", not selfApplyEnabled)
                        end
                    },
                    {
                        text = L["selfApplyImpSoCForced"] or "Always Apply (Assigned)",
                        checked = selfApplyForced,
                        isNotRadio = true,
                        keepShownOnClick = true,
                        disabled = not selfApplyEnabled,
                        tooltipTitle = L["selfApplyImpSoCForcedTooltipTitle"] or "Force Self-Apply (Assignment)",
                        tooltipText = L["selfApplyImpSoCForcedTooltipText"] or "Enable this if you are assigned to apply Judgement of the Crusader regardless of how many Paladins are in your group.\n\nUseful in raids where you are specifically assigned this duty.",
                        tooltipOnButton = true,
                        func = function()
                            if selfApplyEnabled then
                                retTwistModule:SetSetting("class", "selfApplyJudgementOfCrusaderForced", not selfApplyForced)
                            end
                        end
                    },
                    {
                        text = L["selfApplyImpSoCSoloForced"] or "Force While Solo",
                        checked = selfApplySoloForced,
                        isNotRadio = true,
                        keepShownOnClick = true,
                        disabled = not selfApplyEnabled,
                        tooltipTitle = L["selfApplyImpSoCSoloForcedTooltipTitle"] or "Force While Solo",
                        tooltipText = L["selfApplyImpSoCSoloForcedTooltipText"] or "Enable this to allow Judgement of the Crusader self-apply guidance while solo.\n\nDefault is OFF.",
                        tooltipOnButton = true,
                        func = function()
                            if selfApplyEnabled then
                                retTwistModule:SetSetting("class", "selfApplyJudgementOfCrusaderSoloForced", not selfApplySoloForced)
                            end
                        end
                    },
                }
            })
        end
    end

    for _, assignment in ipairs(assignments) do
        if assignment.category ~= "config" then
        local spellIcon = ""
        if assignment.spellIds and #assignment.spellIds > 0 then
            local spellInfo = WoWAPI.GetSpellInfo(assignment.spellIds[1])
            if spellInfo and spellInfo.iconID then
                spellIcon = string.format("|T%s:16:16:0:0|t ", spellInfo.iconID)
            end
        end
        tinsert(menuList, {
            text = spellIcon .. assignment.name,
            checked = allowMultiple and states[assignment.id] == true or selectedId == assignment.id,
            isNotRadio = allowMultiple,
            keepShownOnClick = allowMultiple,
            func = function()
                if allowMultiple and classModule.ToggleAssignment then
                    classModule:ToggleAssignment(assignment.id, not (states[assignment.id] == true))
                else
                    classModule:SetSelectedAssignmentId(assignment.id)
                end
            end
        })
        end
    end

    tinsert(menuList, {
        text = L["assignmentIgnoreReminder"] or "Ignore reminder image",
        checked = classModule.db and classModule.db.char and classModule.db.char.ignoreAssignmentReminder == true,
        isNotRadio = true,
        keepShownOnClick = true,
        func = function()
            local current = classModule.db and classModule.db.char and classModule.db.char.ignoreAssignmentReminder == true
            classModule:SetSetting("char", "ignoreAssignmentReminder", not current)
        end
    })

    return {
        text = L["classAssignments"] or "Class Assignments",
        hasArrow = true,
        notCheckable = true,
        menuList = menuList
    }
end

function FloatingSelector:BuildRetTwistHoldCueMenuList()
    if not isRetTwistContextAvailable() then
        return nil
    end

    local retTwistModule = getRetTwistModule()
    if not retTwistModule then
        return nil
    end

    local soundValues = buildRetTwistHoldSoundValues()
    local soundEntries = {}
    for name in pairs(soundValues) do
        tinsert(soundEntries, { name = name })
    end
    tsort(soundEntries, function(a, b) return a.name < b.name end)

    local soundMenuList = {}
    local soundEnabled = getRetTwistSetting(retTwistModule, "holdCueSoundEnabled", false) == true
    local selectedSound = getRetTwistSetting(retTwistModule, "holdCueSound", nil)
    local normalizedSelectedSound = normalizeRetTwistHoldSoundName(selectedSound, soundValues)
    if soundEnabled and normalizedSelectedSound and normalizedSelectedSound ~= selectedSound then
        setRetTwistSetting(retTwistModule, "holdCueSound", normalizedSelectedSound)
    end
    selectedSound = normalizedSelectedSound or selectedSound

    local function refreshContextMenuSelectionState()
        if LUIDropDownMenu and LUIDropDownMenu.UIDropDownMenu_RefreshAll and self.contextMenuFrame then
            LUIDropDownMenu:UIDropDownMenu_RefreshAll(self.contextMenuFrame)
        end
    end

    for _, entry in ipairs(soundEntries) do
        tinsert(soundMenuList, {
            text = entry.name,
            checked = function()
                local currentSound = getRetTwistSetting(retTwistModule, "holdCueSound", nil)
                currentSound = normalizeRetTwistHoldSoundName(currentSound, soundValues)
                return entry.name == currentSound
            end,
            isNotRadio = false,
            keepShownOnClick = true,
            disabled = not soundEnabled,
            func = function()
                setRetTwistSetting(retTwistModule, "holdCueSound", entry.name)
                if retTwistModule.PlayHoldCueSoundPreview then
                    retTwistModule:PlayHoldCueSoundPreview(entry.name)
                end
                refreshContextMenuSelectionState()
            end,
        })
    end
    if #soundMenuList == 0 then
        soundMenuList = { { text = L["disabled"] or "Disabled", notCheckable = true } }
    end

    local shineEnabled = getRetTwistSetting(retTwistModule, "holdCueShineEnabled", false) == true
    local selectedShineType = getRetTwistSetting(retTwistModule, "holdCueShineType", "Autocast Shine")
    local shineTypeMenuList = {}
    for name in pairs(HOLD_CUE_SHINE_TYPES) do
        tinsert(shineTypeMenuList, {
            text = name,
            checked = name == selectedShineType,
            isNotRadio = false,
            keepShownOnClick = true,
            disabled = not shineEnabled,
            func = function()
                setRetTwistSetting(retTwistModule, "holdCueShineType", name)
            end,
        })
    end
    tsort(shineTypeMenuList, function(a, b) return a.text < b.text end)

    return {
        text = "Ret Twist HOLD Cues",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = "Enable HOLD Sound Cue",
                checked = function()
                    return getRetTwistSetting(retTwistModule, "holdCueSoundEnabled", false) == true
                end,
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    local nextEnabled = not getRetTwistSetting(retTwistModule, "holdCueSoundEnabled", false)
                    setRetTwistSetting(retTwistModule, "holdCueSoundEnabled", nextEnabled)
                    if nextEnabled then
                        local ensuredSound = nil
                        if retTwistModule.EnsureHoldCueSoundSelection then
                            ensuredSound = retTwistModule:EnsureHoldCueSoundSelection()
                        end
                        if not ensuredSound then
                            local currentSound = getRetTwistSetting(retTwistModule, "holdCueSound", nil)
                            ensuredSound = normalizeRetTwistHoldSoundName(currentSound, soundValues)
                            if ensuredSound then
                                setRetTwistSetting(retTwistModule, "holdCueSound", ensuredSound)
                            end
                        end
                    end
                    refreshContextMenuSelectionState()
                end
            },
            {
                text = "HOLD Sound",
                hasArrow = true,
                notCheckable = true,
                disabled = not soundEnabled,
                menuList = soundMenuList
            },
            {
                text = "Play HOLD Sound",
                notCheckable = true,
                disabled = not soundEnabled,
                func = function()
                    local currentSound = getRetTwistSetting(retTwistModule, "holdCueSound", nil)
                    currentSound = normalizeRetTwistHoldSoundName(currentSound, soundValues)
                    if retTwistModule.PlayHoldCueSoundPreview then
                        retTwistModule:PlayHoldCueSoundPreview(currentSound, "button")
                    end
                end
            },
            {
                text = "HOLD Lead Time (seconds)",
                notCheckable = true,
                func = function()
                    self:ShowRetTwistHoldLeadTimeMenu(retTwistModule)
                end
            },
            {
                text = "Enable HOLD Shine Cue",
                checked = shineEnabled,
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    setRetTwistSetting(retTwistModule, "holdCueShineEnabled", not shineEnabled)
                end
            },
            {
                text = "HOLD Shine Type",
                hasArrow = true,
                notCheckable = true,
                disabled = not shineEnabled,
                menuList = shineTypeMenuList
            },
            {
                text = "HOLD Shine Size",
                notCheckable = true,
                disabled = not shineEnabled,
                func = function()
                    self:ShowRetTwistHoldShineScaleMenu(retTwistModule)
                end
            },
        }
    }
end

function FloatingSelector:BuildFloatingSelectorMenuList()
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    local enabled = settings and settings.enabled == true
    local anchorKey = settings and (settings.defaultAnchor or "top_right")
    local modifierKey = settings and (settings.modifierKey or "NONE")

    return {
        text = L["floatingSelector"] or "Floating Selector",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = (L["floatingSelectorEnabled"] or "Enable Floating Selector") .. (enabled and " |cff00ff00" .. (L["on"] or "On") .. "|r" or " |cffff0000" .. (L["off"] or "Off") .. "|r"),
                checked = enabled,
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    self:SetSetting("global", "floatingSelector.enabled", not enabled)
                    self:UpdateFloatingIcon()
                end
            },
            {
                text = L["floatingSelectorDefaultAnchor"] or "Default Position",
                hasArrow = true,
                notCheckable = true,
                menuList = {
                    {
                        text = "Top Right",
                        checked = anchorKey == "top_right",
                        keepShownOnClick = true,
                        func = function()
                            self:SetSetting("global", "floatingSelector.defaultAnchor", "top_right")
                            local anchor = FLOATING_POSITION_ANCHORS.top_right
                            local pos = self.db.global.floatingSelector.position
                            if pos and anchor then
                                pos.point = anchor.point
                                pos.relativePoint = anchor.relativePoint
                                pos.x = anchor.defaultX or 5
                                pos.y = anchor.defaultY or 0
                            end
                            self:UpdateFloatingIcon()
                        end
                    },
                    {
                        text = "Top Left",
                        checked = anchorKey == "top_left",
                        keepShownOnClick = true,
                        func = function()
                            self:SetSetting("global", "floatingSelector.defaultAnchor", "top_left")
                            local anchor = FLOATING_POSITION_ANCHORS.top_left
                            local pos = self.db.global.floatingSelector.position
                            if pos and anchor then
                                pos.point = anchor.point
                                pos.relativePoint = anchor.relativePoint
                                pos.x = anchor.defaultX or 5
                                pos.y = anchor.defaultY or 0
                            end
                            self:UpdateFloatingIcon()
                        end
                    },
                }
            },
            {
                text = L["assignmentHintIconPosition"] or "Assignments Icon Position",
                hasArrow = true,
                notCheckable = true,
                menuList = (function()
                    local currentPos = self:GetSetting("global", "floatingSelector.assignmentHintPosition") or "left"
                    local items = {}
                    local order = { "left", "right", "above", "below" }
                    for _, key in ipairs(order) do
                        local config = ASSIGNMENT_HINT_POSITIONS[key]
                        if config then
                            tinsert(items, {
                                text = config.label,
                                checked = currentPos == key,
                                keepShownOnClick = true,
                                func = function()
                                    self:SetSetting("global", "floatingSelector.assignmentHintPosition", key)
                                    self:UpdateAssignmentHintIcons()
                                end
                            })
                        end
                    end
                    return items
                end)(),
            },
            {
                text = L["floatingSelectorModifierKey"] or "Modifier to Interact",
                hasArrow = true,
                notCheckable = true,
                menuList = {
                    {
                        text = FLOATING_MODIFIER_KEYS.display or "Use Display Setting",
                        checked = modifierKey == "display",
                        keepShownOnClick = true,
                        func = function()
                            self:SetSetting("global", "floatingSelector.modifierKey", "display")
                            self:UpdateFloatingSelectorMouseState()
                        end
                    },
                    {
                        text = "None",
                        checked = modifierKey == "NONE",
                        keepShownOnClick = true,
                        func = function()
                            self:SetSetting("global", "floatingSelector.modifierKey", "NONE")
                            self:UpdateFloatingSelectorMouseState()
                        end
                    },
                    {
                        text = "Alt",
                        checked = modifierKey == "ALT",
                        keepShownOnClick = true,
                        func = function()
                            self:SetSetting("global", "floatingSelector.modifierKey", "ALT")
                            self:UpdateFloatingSelectorMouseState()
                        end
                    },
                    {
                        text = "Shift",
                        checked = modifierKey == "SHIFT",
                        keepShownOnClick = true,
                        func = function()
                            self:SetSetting("global", "floatingSelector.modifierKey", "SHIFT")
                            self:UpdateFloatingSelectorMouseState()
                        end
                    },
                    {
                        text = "Control",
                        checked = modifierKey == "CONTROL",
                        keepShownOnClick = true,
                        func = function()
                            self:SetSetting("global", "floatingSelector.modifierKey", "CONTROL")
                            self:UpdateFloatingSelectorMouseState()
                        end
                    },
                }
            },
            {
                text = L["floatingIconColor"] or "Floating Icon Color",
                notCheckable = true,
                func = function()
                    self:ShowFloatingIconColorPicker()
                end
            },
            {
                text = L["floatingSelectorReset"] or "Reset Floating Position",
                notCheckable = true,
                func = function()
                    self:ResetFloatingPosition()
                end
            },
        }
    }
end

function FloatingSelector:BuildAddonSettingsMenuList()
    local isSuppressed = DisplayManager and DisplayManager.IsDisplaySuppressed and DisplayManager:IsDisplaySuppressed()
    local unlocked = self.db and self.db.global and self.db.global.floatingSelector and
        self.db.global.floatingSelector.dragFramesUnlocked == true
    local cooldownFramesEnabled = DisplayManager and DisplayManager.IsLeftFramesEnabled and DisplayManager:IsLeftFramesEnabled()
    local aoeFrameEnabled = DisplayManager and DisplayManager.IsAoeFrameEnabled and DisplayManager:IsAoeFrameEnabled()
    local roundMaskEnabled = DisplayManager and DisplayManager.GetSetting
        and (DisplayManager:GetSetting("char", "showRoundMaskPreview") == true)
    local roundMaskToggleEnabled = DisplayManager and DisplayManager.IsGroupDisplayMode and DisplayManager.IsLegacyFrameEnabled
        and (DisplayManager:IsGroupDisplayMode() or DisplayManager:IsLegacyFrameEnabled())
    local floatingSelectorMenu = self:BuildFloatingSelectorMenuList()

    -- Snapshot overlay lock (same as "Lock snapshot overlay" in class options): only relevant when class has an enabled overlay
    local hasSnapshotOverlayForClass = false
    local snapshotOverlayUnlocked = false
    local Snapshotter = NAG:GetModule("Snapshotter", true)
    if Snapshotter and DisplayManager and Snapshotter.GetSnapshotOverlayProfileIds and Snapshotter.GetSnapshotOverlayProfile then
        local profileIds = Snapshotter:GetSnapshotOverlayProfileIds()
        local classTag = NAG.CLASS_FILENAME
        if classTag and profileIds then
            for _, profileId in ipairs(profileIds) do
                local profile = Snapshotter:GetSnapshotOverlayProfile(profileId)
                if profile and profile.classTag == classTag and DisplayManager:GetSnapshotOverlayEnabled(profileId) then
                    hasSnapshotOverlayForClass = true
                    snapshotOverlayUnlocked = not DisplayManager:GetSnapshotOverlayLocked(profileId)
                    break
                end
            end
        end
    end

    return {
        text = L["addonSettings"] or "Addon Settings",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = isSuppressed and (L["enableNag"] or "Show NAG Frames") or (L["disableNag"] or "Hide NAG Frames"),
                notCheckable = true,
                func = function()
                    if isSuppressed then
                        self:SetDisplaySuppressed(false)
                    else
                        self:ShowDisableConfirm()
                    end
                end
            },
            {
                text = L["frameScale"] or "Frame Scale",
                notCheckable = true,
                func = function()
                    self:ShowFrameScaleMenu()
                end
            },
            {
                text = L["lockFrame"] or "Lock Frames",
                checked = not unlocked,
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    local settings = self.db and self.db.global and self.db.global.floatingSelector
                    local currentlyUnlocked = settings and settings.dragFramesUnlocked == true
                    self:SetDragFramesEnabled(not currentlyUnlocked)
                end
            },
            {
                text = L["dkDiseaseOverlayLocked"] or "Lock Snapshot Overlay",
                checked = not snapshotOverlayUnlocked,
                isNotRadio = true,
                keepShownOnClick = true,
                disabled = not hasSnapshotOverlayForClass,
                func = function()
                    local Snapshotter = NAG:GetModule("Snapshotter", true)
                    if not Snapshotter or not DisplayManager or not Snapshotter.GetSnapshotOverlayProfileIds or not Snapshotter.GetSnapshotOverlayProfile then
                        return
                    end
                    local profileIds = Snapshotter:GetSnapshotOverlayProfileIds()
                    local classTag = NAG.CLASS_FILENAME
                    if not classTag or not profileIds then return end
                    for _, profileId in ipairs(profileIds) do
                        local profile = Snapshotter:GetSnapshotOverlayProfile(profileId)
                        if profile and profile.classTag == classTag and DisplayManager:GetSnapshotOverlayEnabled(profileId) then
                            local locked = DisplayManager:GetSnapshotOverlayLocked(profileId)
                            DisplayManager:SetSnapshotOverlayLocked(profileId, not locked)
                        end
                    end
                    if DisplayManager.UpdateAllSnapshotOverlays then
                        DisplayManager:UpdateAllSnapshotOverlays()
                    end
                end
            },
            {
                text = L["showCooldownFrames"] or "Show Cooldowns Frames",
                checked = cooldownFramesEnabled,
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    if DisplayManager and DisplayManager.SetLeftFramesEnabled and DisplayManager.IsLeftFramesEnabled then
                        local current = DisplayManager:IsLeftFramesEnabled()
                        DisplayManager:SetLeftFramesEnabled(not current)
                    end
                end
            },
            {
                text = L["showAoeFrame"] or "Show AoE Frame",
                checked = aoeFrameEnabled,
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    if DisplayManager and DisplayManager.SetAoeFrameEnabled and DisplayManager.IsAoeFrameEnabled then
                        local current = DisplayManager:IsAoeFrameEnabled()
                        DisplayManager:SetAoeFrameEnabled(not current)
                    end
                end
            },
            {
                text = L["throttleInterval"] or "Throttle Interval",
                notCheckable = true,
                func = function()
                    self:ShowThrottleSettingsMenu()
                end
            },
            {
                text = L["hideGcdSwipeOverlay"] or "Hide GCD Swipe Overlay",
                checked = self:IsGcdSwipeOverlayHidden(),
                isNotRadio = true,
                keepShownOnClick = true,
                func = function()
                    if self:IsGcdSwipeOverlayHidden() then
                        self:SetCooldownSwipesEnabled(true)
                    else
                        self:ShowHideGcdSwipeConfirm()
                    end
                end
            },
            {
                text = L["showRoundMaskPreview"] or "Round Icon Mask (Preview)",
                checked = roundMaskEnabled,
                isNotRadio = true,
                keepShownOnClick = true,
                disabled = not roundMaskToggleEnabled,
                func = function()
                    if DisplayManager and DisplayManager.GetSetting and DisplayManager.SetSetting then
                        local current = DisplayManager:GetSetting("char", "showRoundMaskPreview") == true
                        local nextValue = not current
                        DisplayManager:SetSetting("char", "showRoundMaskPreview", nextValue)
                        if DisplayManager.ApplyRoundMaskPreviewVisibilityAll then
                            DisplayManager:ApplyRoundMaskPreviewVisibilityAll()
                        end
                        if DisplayManager.ApplyRoundMaskToLegacyFrames then
                            DisplayManager:ApplyRoundMaskToLegacyFrames()
                        end
                    end
                end
            },
            {
                text = L["editKeybinds"] or "Edit Keybinds",
                notCheckable = true,
                func = function()
                    self:OpenKeybindManagerOptions()
                end
            },
            floatingSelectorMenu,
        }
    }
end

function FloatingSelector:BuildRotationRootMenuList()
    local rotationMenuList = self:BuildRotationMenuList()
    local autoRotationSpamMenu = self:BuildAutoRotationSpamMenuList()

    return {
        text = L["rotation"] or "Rotation",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = L["selectRotation"] or "Select Rotation",
                hasArrow = true,
                notCheckable = true,
                menuList = rotationMenuList or {
                    { text = L["disabled"] or "No rotations available", notCheckable = true }
                }
            },
            autoRotationSpamMenu,
            {
                text = L["rotationManager"] or "Rotation Manager",
                notCheckable = true,
                func = function()
                    self:OpenRotationManager()
                end
            },
        }
    }
end

function FloatingSelector:ShowContextMenu()
    if not self.contextMenuFrame then
        self.contextMenuFrame = LUIDropDownMenu:Create_UIDropDownMenu("NAGFloatingSelectorContextMenu", UIParent)
    end

    local rotationMenu = self:BuildRotationRootMenuList()
    local backgroundMenu = self:BuildBackgroundMenuList()
    local addonSettingsMenu = self:BuildAddonSettingsMenuList()
    local classModule = NAG:GetClassModule()
    local assignmentsMenu = self:BuildAssignmentsSubmenu(classModule)
    local retTwistHoldMenu = self:BuildRetTwistHoldCueMenuList()

    local menu = {
        { text = L["floatingManager"] or "Floating Manager", isTitle = true, notCheckable = true },
        {
            text = L["helpImprove"] or "Help Improve",
            notCheckable = true,
            func = function()
                self:ShowFeedbackMenu()
            end
        },
    }
    if assignmentsMenu then
        tinsert(menu, assignmentsMenu)
    end
    tinsert(menu, rotationMenu)
    if retTwistHoldMenu then
        tinsert(menu, retTwistHoldMenu)
    end
    tinsert(menu, backgroundMenu)
    tinsert(menu, addonSettingsMenu)
    tinsert(menu, { text = L["close"] or "Close", notCheckable = true, func = function() end })

    LUIDropDownMenu:EasyMenu(menu, self.contextMenuFrame, "cursor", 0, 0, "MENU")
end

function FloatingSelector:GetClickActionLabel(action)
    return CLICK_ACTIONS[action] or (L["none"] or "None")
end

function FloatingSelector:ExecuteClickAction(action)
    if action == "rotation_menu" then
        self:ShowRotationMenu()
    elseif action == "frame_position" then
        self:ShowFramePositionMenu()
    elseif action == "nag_options" then
        local dialog = AceConfigDialog
        if dialog.OpenFrames and dialog.OpenFrames["NAG"] then
            dialog:Close("NAG")
        else
            dialog:Open("NAG")
        end
    elseif action == "context_menu" then
        self:ShowContextMenu()
    end
end

function FloatingSelector:HandleClick(button)
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    if not settings then
        return
    end

    if button == "RightButton" then
        self:ExecuteClickAction(settings.rightClickAction)
        return
    end

    if button ~= "LeftButton" then
        return
    end

    if settings.dragFramesUnlocked ~= true then
        return
    end

    if self.suppressClick then
        self.suppressClick = false
        return
    end

    self:ExecuteClickAction(settings.leftClickAction)
end

function FloatingSelector:ShowFramePositionMenu()
    if self.framePositionMenu and self.framePositionMenu:IsShown() then
        AceGUI:Release(self.framePositionMenu)
        self.framePositionMenu = nil
        return
    end

    local settings = self.db and self.db.global and self.db.global.floatingSelector
    if not settings then
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["framePosition"] or "Frame Position")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(320)
    menu:SetHeight(240)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.framePositionMenu == widget then
            self.framePositionMenu = nil
        end
    end)
    self.framePositionMenu = menu

    local unlockToggle = AceGUI:Create("CheckBox")
    unlockToggle:SetLabel(L["unlockFrame"] or "Unlock Frames")
    unlockToggle:SetDescription(L["unlockFrameDescription"] or "Enable drag and mouse controls for positioning")
    unlockToggle:SetValue(settings.dragFramesUnlocked == true)
    unlockToggle:SetFullWidth(true)
    unlockToggle:SetCallback("OnValueChanged", function(_, _, value)
        self:SetDragFramesEnabled(value)
    end)
    menu:AddChild(unlockToggle)

    local offsetXInput = AceGUI:Create("EditBox")
    offsetXInput:SetLabel(L["offsetX"] or "Offset X")
    offsetXInput:SetText(tostring(settings.position and settings.position.x or 0))
    offsetXInput:SetFullWidth(true)
    menu:AddChild(offsetXInput)

    local offsetYInput = AceGUI:Create("EditBox")
    offsetYInput:SetLabel(L["offsetY"] or "Offset Y")
    offsetYInput:SetText(tostring(settings.position and settings.position.y or 0))
    offsetYInput:SetFullWidth(true)
    menu:AddChild(offsetYInput)

    local applyButton = AceGUI:Create("Button")
    applyButton:SetText(L["apply"] or "Apply")
    applyButton:SetFullWidth(true)
    applyButton:SetCallback("OnClick", function()
        local xValue = tonumber(offsetXInput:GetText())
        local yValue = tonumber(offsetYInput:GetText())
        if xValue == nil or yValue == nil then
            self:Warn("Invalid coordinates. Please enter numeric values.")
            return
        end
        settings.position.x = xValue
        settings.position.y = yValue
        self:UpdateFloatingIcon()
        if AceConfigRegistry then
            AceConfigRegistry:NotifyChange("NAG")
        end
    end)
    menu:AddChild(applyButton)
end

function FloatingSelector:ShowRotationMenu()
    local classModule = NAG:GetClassModule()
    if not classModule then return end

    local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0

    local rotations, displayNames = classModule:GetAvailableRotations(specIndex)
    local currentRotationName = select(2, classModule:GetCurrentRotation())

    local rotationListForSorting = {}

    for name in pairs(rotations) do
        tinsert(rotationListForSorting, {
            name = name,
            displayName = displayNames[name] or name,
            isSelected = (name == currentRotationName)
        })
    end

    if #rotationListForSorting == 0 then return end

    tsort(rotationListForSorting, function(a, b) return a.displayName < b.displayName end)

    local menuList = {}

    for _, rotInfo in ipairs(rotationListForSorting) do
        tinsert(menuList, {
            text = rotInfo.isSelected and ("|cff00ff00" .. rotInfo.displayName .. "|r") or rotInfo.displayName,
            value = rotInfo.name,
            func = function()
                classModule:SelectRotation(specIndex, rotInfo.name)
            end,
            checked = rotInfo.isSelected,
        })
    end

    local assignmentsSubmenu = self:BuildAssignmentsSubmenu(classModule)
    if assignmentsSubmenu then
        tinsert(menuList, {
            text = "",
            isTitle = true,
            notCheckable = true,
        })

        tinsert(menuList, assignmentsSubmenu)
    end

    tinsert(menuList, {
        text = "",
        isTitle = true,
        notCheckable = true,
    })

    tinsert(menuList, {
        text = L["close"] or "Close",
        func = function() end,
        notCheckable = true
    })

    if not self.rotationDropdownFrame then
        self.rotationDropdownFrame = LUIDropDownMenu:Create_UIDropDownMenu("NAGFloatingSelectorRotationMenu", UIParent)
    end
    LUIDropDownMenu:EasyMenu(menuList, self.rotationDropdownFrame, "cursor", 0, 0, "MENU")
end

function FloatingSelector:ShowTooltip(frame)
    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["floatingSelector"] or "Floating Selector")
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    if settings and settings.autoRotationSpam then
        local enabled = settings.autoRotationSpam.enabled == true
        local rotationName = settings.autoRotationSpam.rotationName or ""
        local label = enabled and "Enabled" or "Enable"
        if rotationName ~= "" then
            GameTooltip:AddLine(string.format("Auto Rotation Spam: %s (%s)", label, rotationName))
        else
            GameTooltip:AddLine(string.format("Auto Rotation Spam: %s", label))
        end
    end
    GameTooltip:AddLine("Right-click: Options Menu")
    GameTooltip:Show()
end
--- Get the modifier key used for floating selector interaction (click-through unless held)
--- @return string "ALT"|"SHIFT"|"CONTROL"|nil
function FloatingSelector:GetFloatingSelectorModifierKey()
    local settings = self.db and self.db.global and self.db.global.floatingSelector
    local key = settings and settings.modifierKey
    if key == "display" then
        if DisplayManager then
            return DisplayManager:GetMouseInteractionKey()
        end
        return "ALT"
    end
    return (key == "NONE" or key == "ALT" or key == "SHIFT" or key == "CONTROL") and key or "NONE"
end

--- Update floating selector mouse state based on modifier key (click-through unless modifier held)
function FloatingSelector:UpdateFloatingSelectorMouseState()
    local f = self.floatingFrame
    if not f or not f:IsShown() then
        return
    end

    local key = self:GetFloatingSelectorModifierKey()
    local wantMouse = false
    if key == "NONE" then
        wantMouse = true
    elseif key == "ALT" then
        wantMouse = IsAltKeyDown()
    elseif key == "SHIFT" then
        wantMouse = IsShiftKeyDown()
    elseif key == "CONTROL" then
        wantMouse = IsControlKeyDown()
    end

    f:EnableMouse(wantMouse)
end

function FloatingSelector:OnModifierStateChanged(event)
    self:UpdateFloatingSelectorMouseState()
end

function FloatingSelector:CreateFloatingFrame()
    if self.floatingFrame then
        return
    end

    local f = CreateFrame("Button", "NAGFloatingSelector", UIParent)
    f:SetFrameStrata("TOOLTIP")
    f:SetMovable(true)
    f:SetClampedToScreen(true)
    f:EnableMouse(false)
    f:RegisterForClicks("AnyUp")

    f:SetNormalTexture("Interface\\AddOns\\NAG\\Media\\nagN.png")
    f:SetHighlightTexture("Interface\\AddOns\\NAG\\Media\\nagN.png")
    f:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.7)
    self:UpdateFloatingIcon()

    local moduleRef = self

    f:SetScript("OnMouseDown", function(_, button)
        if button ~= "LeftButton" then
            return
        end

        local settings = moduleRef.db and moduleRef.db.global and moduleRef.db.global.floatingSelector
        if not settings or settings.dragFramesUnlocked ~= true then
            return
        end

        if InCombatLockdown() or UnitIsDeadOrGhost("player") then
            moduleRef:Warn("Cannot move frames during combat or while dead")
            return
        end

        local anchor = moduleRef:GetActiveAnchorFrame()
        if not anchor then
            return
        end

        moduleRef.suppressClick = true
        moduleRef.draggingAnchor = anchor
        anchor:SetMovable(true)
        anchor:StartMoving()
    end)

    f:SetScript("OnMouseUp", function(_, button)
        if button ~= "LeftButton" then
            return
        end

        if moduleRef.draggingAnchor then
            moduleRef.draggingAnchor:StopMovingOrSizing()
            moduleRef:SaveAnchorPosition(moduleRef.draggingAnchor)
            moduleRef.draggingAnchor = nil
            moduleRef.suppressClick = true
        end
    end)

    f:SetScript("OnClick", function(_, button)
        moduleRef:HandleClick(button)
    end)

    f:SetScript("OnEnter", function(frameSelf)
        moduleRef:ShowTooltip(frameSelf)
    end)

    f:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    self.floatingFrame = f
end

-- ============================ OPTIONS ============================
function FloatingSelector:GetOptions()
    return {
        type = "group",
        name = L["floatingSelector"] or "Floating Selector",
        order = self.optionsOrder or 21,
        childGroups = "tab",
        args = {
            general = {
                type = "group",
                name = "General",
                order = 1,
                args = {
                    floatingEnabled = OptionsFactory:CreateToggle(
                        L["floatingSelectorEnabled"] or "Enable Floating Selector",
                        L["floatingSelectorEnabledDesc"] or "Show the selector icon anchored to the NAG display frame",
                        function() return self:GetSetting("global", "floatingSelector.enabled") end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.enabled", value)
                            self:UpdateFloatingIcon()
                        end,
                        { order = 1 }
                    ),
                    leftClickAction = OptionsFactory:CreateSelect(
                        L["leftClickAction"] or "Left Click Action",
                        L["leftClickActionDesc"] or "Choose what the left click does for the floating selector",
                        function() return self:GetSetting("global", "floatingSelector.leftClickAction") end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.leftClickAction", value)
                        end,
                        { order = 1.5, values = CLICK_ACTIONS }
                    ),
                    rightClickAction = OptionsFactory:CreateSelect(
                        L["rightClickAction"] or "Right Click Action",
                        L["rightClickActionDesc"] or "Choose what the right click does for the floating selector",
                        function() return self:GetSetting("global", "floatingSelector.rightClickAction") end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.rightClickAction", value)
                        end,
                        { order = 1.6, values = CLICK_ACTIONS }
                    ),
                    floatingSize = OptionsFactory:CreateRange(
                        L["floatingSelectorSize"] or "Size",
                        L["floatingSelectorSizeDesc"] or "Adjust the floating selector size",
                        function() return self:GetSetting("global", "floatingSelector.size") end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.size", value)
                            self:UpdateFloatingIcon()
                        end,
                        { order = 2, min = 10, max = 100, step = 1 }
                    ),
                    defaultAnchor = OptionsFactory:CreateSelect(
                        L["floatingSelectorDefaultAnchor"] or "Default Position",
                        L["floatingSelectorDefaultAnchorDesc"] or "Side of the NAG display where the floating selector appears (Top Right or Top Left)",
                        function() return self:GetSetting("global", "floatingSelector.defaultAnchor") or "top_right" end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.defaultAnchor", value)
                            local anchor = FLOATING_POSITION_ANCHORS[value]
                            if anchor then
                                local pos = self.db.global.floatingSelector.position
                                if pos then
                                    pos.point = anchor.point
                                    pos.relativePoint = anchor.relativePoint
                                    pos.x = anchor.defaultX or 5
                                    pos.y = anchor.defaultY or 0
                                end
                            end
                            self:UpdateFloatingIcon()
                        end,
                        { order = 2.5, values = { top_right = "Top Right", top_left = "Top Left" } }
                    ),
                    assignmentHintPosition = OptionsFactory:CreateSelect(
                        L["assignmentHintIconPosition"] or "Assignments Icon Position",
                        L["assignmentHintIconPositionDesc"] or "Where assignment hint icons appear relative to the floating selector (Left, Right, Above, Below)",
                        function() return self:GetSetting("global", "floatingSelector.assignmentHintPosition") or "left" end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.assignmentHintPosition", value)
                            self:UpdateAssignmentHintIcons()
                        end,
                        {
                            order = 2.55,
                            values = {
                                left = ASSIGNMENT_HINT_POSITIONS.left.label,
                                right = ASSIGNMENT_HINT_POSITIONS.right.label,
                                above = ASSIGNMENT_HINT_POSITIONS.above.label,
                                below = ASSIGNMENT_HINT_POSITIONS.below.label
                            }
                        }
                    ),
                    modifierKey = OptionsFactory:CreateSelect(
                        L["floatingSelectorModifierKey"] or "Modifier to Interact",
                        L["floatingSelectorModifierKeyDesc"] or "Hold this key to show tooltip and click the floating selector. Use Display Setting follows the main NAG tooltip key.",
                        function() return self:GetSetting("global", "floatingSelector.modifierKey") or "NONE" end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.modifierKey", value)
                            self:UpdateFloatingSelectorMouseState()
                        end,
                        { order = 2.6, values = FLOATING_MODIFIER_KEYS }
                    ),
                    floatingOffsetX = OptionsFactory:CreateRange(
                        L["floatingSelectorOffsetX"] or "Offset X",
                        L["floatingSelectorOffsetXDesc"] or "Horizontal offset from the NAG display frame",
                        function() return self:GetSetting("global", "floatingSelector.position.x") end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.position.x", value)
                            self:UpdateFloatingIcon()
                        end,
                        { order = 3, min = -500, max = 500, step = 1 }
                    ),
                    floatingOffsetY = OptionsFactory:CreateRange(
                        L["floatingSelectorOffsetY"] or "Offset Y",
                        L["floatingSelectorOffsetYDesc"] or "Vertical offset from the NAG display frame",
                        function() return self:GetSetting("global", "floatingSelector.position.y") end,
                        function(_, value)
                            self:SetSetting("global", "floatingSelector.position.y", value)
                            self:UpdateFloatingIcon()
                        end,
                        { order = 4, min = -500, max = 500, step = 1 }
                    ),
                    resetFloatingPosition = OptionsFactory:CreateExecute(
                        L["floatingSelectorReset"] or "Reset Floating Position",
                        L["floatingSelectorResetDesc"] or "Reset the floating selector position to the default anchor",
                        function()
                            self:ResetFloatingPosition()
                        end,
                        { order = 5 }
                    ),
                    hideGcdSwipeOverlay = OptionsFactory:CreateToggle(
                        L["hideGcdSwipeOverlay"] or "Hide GCD Swipe Overlay",
                        L["hideGcdSwipeOverlayDesc"] or "Hide the GCD swipe overlay on suggestion icons",
                        function() return self:IsGcdSwipeOverlayHidden() end,
                        function(_, value)
                            if value == true then
                                self:ShowHideGcdSwipeConfirm()
                                return
                            end
                            self:SetCooldownSwipesEnabled(true)
                        end,
                        { order = 6 }
                    ),
                }
            },
        },
    }
end

