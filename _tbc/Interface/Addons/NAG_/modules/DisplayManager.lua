--- @module "NAG.DisplayManager"
--- Handles all frame creation, icon management, and border logic for NAG addon as an Ace3 module.
---
--- TODO: COMPASS_DIRECTIONS uses 0° = North (up) and increases clockwise, but WoW's SetRotation(0) points East (right) and increases counterclockwise.
--- This causes a 90° offset and direction reversal for spinner arrows. For now, we adjust spinner rotation with -math.rad(dir.angle - 90).
--- Consider refactoring COMPASS_DIRECTIONS to match WoW's system for consistency in the future.
---
--- # Display Anchor Migration Note
---
--- ## Universal Display Anchor
--- Use the public accessor `NAG:GetDisplayAnchor()` to obtain the anchor for overlays, WeakAuras, and external integrations.
---
--- ## Migration Guidance
--- All new integrations should use `NAG:GetDisplayAnchor()` for anchoring display elements.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local WoWAPI = ns.WoWAPI
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
-- TBC: UnitInVehicle and UnitHasVehicleUI don't exist (vehicles added in Wrath)
local UnitInVehicle = _G.UnitInVehicle or function() return false end
local UnitHasVehicleUI = _G.UnitHasVehicleUI or function() return false end
local GetCursorPosition = _G.GetCursorPosition
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsAltKeyDown = _G.IsAltKeyDown
local IsControlKeyDown = _G.IsControlKeyDown
local CreateFrame = _G.CreateFrame
local GetScreenWidth = _G.GetScreenWidth
local PlaySound = _G.PlaySound
local PlaySoundFile = _G.PlaySoundFile
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon
local GetItemCooldown = C_Container and C_Container.GetItemCooldown or _G.GetItemCooldown

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DataManager
--- @type OverlayManager
--- @type ShareInGame
local DataManager, OverlayManager, ShareInGame

--- @type SpellbookManager
--- @type KeybindManager
--- @type OptionsFactory
local SpellbookManager, KeybindManager, OptionsFactory


-- CacheManager functionality consolidated into SpellbookManager

local LSM = ns.LibSharedMedia
local LCG = ns.LibCustomGlow

local AceConfigRegistry = ns.AceConfigRegistry
if not LCG then error("LibCustomGlow-1.0 is required") end
local Masque = ns.Masque
local MasqueGroup = Masque and Masque:Group("NAG") or nil
local L = ns.AceLocale:GetLocale("NAG", true)

-- Custom primary overlay (ShowCustomOverlay) expire; must match APLAction_Casting.lua CUSTOM_OVERLAY_EXPIRE_SECONDS
local CUSTOM_OVERLAY_EXPIRE_SECONDS = 0.25
local FRAME_UPDATE_BROADCAST_MIN_INTERVAL_SEC = 0.016
-- Round preview masks: per-position custom masks (white = visible, black = transparent).
local CIRCLE_MASK_TEXTURE = "Interface/CHARACTERFRAME/TempPortraitAlphaMask"
local MASK_BASE = "Interface/AddOns/NAG/media/"
local MASK_LEFT = MASK_BASE .. "mask4.png"
local MASK_ABOVE = MASK_BASE .. "mask4above.png"
local MASK_AOE = MASK_BASE .. "mask4AOE.png"
local MASK_BELOW = MASK_BASE .. "mask4b.png"
local MASK_RIGHT = MASK_BASE .. "mask4r.png"
local DEFAULT_COOLDOWN_SWIPE_TEXTURE = "Interface/Cooldown/UI-CooldownFrame"
local MASK_BORDER_SCALE = 1.15 -- Black background border is 15% larger than icon
local ROUND_PREVIEW_SPACING_FACTOR = 0.87 -- Secondary groups 20% closer to center when round mask preview on
local ROUND_PREVIEW_ICON_SPACING_FACTOR = 0.80 -- Icons within secondary groups 20% closer to each other
local ROUND_PREVIEW_SECONDARY_ICON_SCALE = 1.15 -- Secondary icons 15% larger when round mask preview on
local ROUND_PREVIEW_KEYBIND_FONT_SCALE = 0.68 -- Keybind text 35% smaller when round preview on (secondary)
local ROUND_PREVIEW_PRIMARY_KEYBIND_FONT_SCALE = 0.6 -- Primary icon keybind 40% smaller when masked
local ROUND_PREVIEW_LEFT_RIGHT_WIDTH_SCALE = 1.28 -- LEFT/RIGHT secondary frames 20% wider when masked
local ROUND_PREVIEW_ABOVE_BELOW_HEIGHT_SCALE = 1.28 -- ABOVE/BELOW secondary frames 20% taller when masked
local AOE_ICON_HEIGHT_SCALE = 1.75 -- AOE icon 30% taller than base (unused for legacy: AOE is right half of primary)
-- TexCoord for AOE right-half rectangle: aspect (width/height) = 0.5 to match frame (iconWidth/2 / iconHeight), prevents stretch
local AOE_ICON_TEXCOORD_SQUARE = { 0.15, 0.85, 0.15, 0.85 }
local AOE_ICON_TEXCOORD_RIGHT_HALF_RECT = { 0.3, 0.7, 0.1, 0.9 }
local ROUND_PREVIEW_SECONDARY_ICON_IMAGE_ZOOM = 0.815 -- Secondary icon spell image 20% smaller (zoom out) within frame; applied via TexCoord padding
-- Masked swipe overlays: lower strata (below keybinds) and 20% less dark
local MASKED_SWIPE_ALPHA_MULTIPLIER = 0.8
-- Custom swipe overlays (hold timers): 20% more transparent dark swipe
local CUSTOM_SWIPE_ALPHA_MULTIPLIER = 0.8

--- Expands texCoord so the image appears zoomed out (smaller within the same frame). Mask stays full size.
--- @param l number Left
--- @param r number Right
--- @param t number Top
--- @param b number Bottom
--- @param zoom number 0-1, e.g. 0.8 = 20% smaller
--- @return number, number, number, number Expanded l, r, t, b
local function ExpandTexCoordForZoomOut(l, r, t, b, zoom)
    local pad = (1 - zoom) / 2
    local w, h = r - l, b - t
    return l - w * pad, r + w * pad, t - h * pad, b + h * pad
end

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local format = string.format
local floor = math.floor
local ceil = ceil
local min = math.min
local max = math.max
local strmatch = strmatch
local tinsert = tinsert
local wipe = wipe
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber
local unpack = unpack

-- Enhanced error handling
local pcall = ns.pcall

-- ============================ CONTENT ============================
local COMPASS_DIRECTIONS = {
    { key = "E",   label = "E",   angle = 0,     x = 1,     y = 0 },
    { key = "ENE", label = "ENE", angle = 22.5,  x = 0.92,  y = 0.38 },
    { key = "NE",  label = "NE",  angle = 45,    x = 0.71,  y = 0.71 },
    { key = "NNE", label = "NNE", angle = 67.5,  x = 0.38,  y = 0.92 },
    { key = "N",   label = "N",   angle = 90,    x = 0,     y = 1 },
    { key = "NNW", label = "NNW", angle = 112.5, x = -0.38, y = 0.92 },
    { key = "NW",  label = "NW",  angle = 135,   x = -0.71, y = 0.71 },
    { key = "WNW", label = "WNW", angle = 157.5, x = -0.92, y = 0.38 },
    { key = "W",   label = "W",   angle = 180,   x = -1,    y = 0 },
    { key = "WSW", label = "WSW", angle = 202.5, x = -0.92, y = -0.38 },
    { key = "SW",  label = "SW",  angle = 225,   x = -0.71, y = -0.71 },
    { key = "SSW", label = "SSW", angle = 247.5, x = -0.38, y = -0.92 },
    { key = "S",   label = "S",   angle = 270,   x = 0,     y = -1 },
    { key = "SSE", label = "SSE", angle = 292.5, x = 0.38,  y = -0.92 },
    { key = "SE",  label = "SE",  angle = 315,   x = 0.71,  y = -0.71 },
    { key = "ESE", label = "ESE", angle = 337.5, x = 0.92,  y = -0.38 },
}

-- New system: Each group (main, aoe, cooldowns, interrupts, defensives) has its own frame and settings
local FRAME_GROUPS = {
    [ns.FRAME_GROUPS.MAIN] = { displayName = "Main", defaultNumIcons = 5 },
    [ns.FRAME_GROUPS.AOE] = { displayName = "AOE", defaultNumIcons = 2 },
    [ns.FRAME_GROUPS.COOLDOWNS] = { displayName = "Cooldowns", defaultNumIcons = 4 },
    [ns.FRAME_GROUPS.INTERRUPTS] = { displayName = "Interrupts", defaultNumIcons = 2 },
    [ns.FRAME_GROUPS.DEFENSIVES] = { displayName = "Defensives", defaultNumIcons = 2 },
    [ns.FRAME_GROUPS.SEQUENCE] = { displayName = "Sequence", defaultNumIcons = 3 }, -- ADDED
}

-- Preset layouts for group configuration
local GROUP_PRESETS = {
    Default = {
        main = { enabled = true, numIcons = 5, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = 0 },
        aoe = { enabled = true, numIcons = 2, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 200, offsetY = 0 },
        cooldowns = { enabled = true, numIcons = 4, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = 100 },
        interrupts = { enabled = true, numIcons = 2, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = -100 },
        defensives = { enabled = true, numIcons = 2, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = -200, offsetY = 0 },
        sequence = { enabled = true, numIcons = 3, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 300, offsetY = 0 }, -- ADDED
    },
    ["Legacy (Surround Center)"] = {
        main = { enabled = true, numIcons = 1, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = 0 },
        aoe = { enabled = true, numIcons = 1, iconFlowDirection = "N", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = 39 },
        cooldowns = { enabled = true, numIcons = 5, iconFlowDirection = "W", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = -39, offsetY = 0 },
        interrupts = { enabled = true, numIcons = 1, iconFlowDirection = "S", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = -39 },
        defensives = { enabled = true, numIcons = 1, iconFlowDirection = "N", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = 39 }, -- above center (leaves right for next action/prediction queue)
        sequence = { enabled = true, numIcons = 3, iconFlowDirection = "NE", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 39, offsetY = 39 }, -- ADDED
    },
    ["4 Corners"] = {
        main = { enabled = true, numIcons = 1, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 0, offsetY = 0 },
        aoe = { enabled = true, numIcons = 1, iconFlowDirection = "SE", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 36, offsetY = -36 },
        cooldowns = { enabled = true, numIcons = 1, iconFlowDirection = "SW", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = -36, offsetY = -36 },
        interrupts = { enabled = true, numIcons = 1, iconFlowDirection = "NE", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 36, offsetY = 36 },
        defensives = { enabled = true, numIcons = 1, iconFlowDirection = "NW", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = -36, offsetY = 36 },
        sequence = { enabled = true, numIcons = 3, iconFlowDirection = "E", scale = 1, alpha = 1, point = "CENTER", relativePoint = "CENTER", offsetX = 72, offsetY = 0 }, -- ADDED
    },
}

-- Default per-group settings
local defaultGroupSettings = {
    width = 50,
    height = 50,
    point = "CENTER",
    relativePoint = "CENTER",
    offsetX = 0,
    offsetY = 0,
    scale = 1,
    alpha = 1,
    numIcons = 1,
    iconWidth = 44,
    iconHeight = 44,
    frameStrata = "MEDIUM",
    frameLevel = 100,
    enabled = true,
    iconOverlap = 0,         -- -1.0 (fully stacked) to 1.0 (very far apart)
    iconZoom = 0.5,          -- 0.0 (no zoom) to 0.5 (max zoom)
    iconFlowDirection = "E", -- Default flow direction
    iconCropStyle = "auto",  -- Default crop style
}

-- Build Ace3-compliant groupSettings defaults using the desired preset
local selectedPreset = GROUP_PRESETS["Legacy (Surround Center)"]
local groupSettingsDefaults = {}
for groupKey, group in pairs(FRAME_GROUPS) do
    groupSettingsDefaults[groupKey] = {}
    -- Start with the generic defaults
    for k, v in pairs(defaultGroupSettings) do
        groupSettingsDefaults[groupKey][k] = v
    end
    -- Override with preset values if present
    if selectedPreset[groupKey] then
        for k, v in pairs(selectedPreset[groupKey]) do
            groupSettingsDefaults[groupKey][k] = v
        end
    end
    -- Use FRAME_GROUPS defaultNumIcons if present
    if group.defaultNumIcons then
        groupSettingsDefaults[groupKey].numIcons = group.defaultNumIcons
    end
    groupSettingsDefaults[groupKey].iconFlowDirection = groupSettingsDefaults[groupKey].iconFlowDirection or "E"
    -- Ensure new fields are present
    groupSettingsDefaults[groupKey].iconOverlap = groupSettingsDefaults[groupKey].iconOverlap or 0.0
    groupSettingsDefaults[groupKey].iconZoom = groupSettingsDefaults[groupKey].iconZoom or 0.2
    -- Set iconCropStyle based on group type
    groupSettingsDefaults[groupKey].iconCropStyle = groupSettingsDefaults[groupKey].iconCropStyle or
        (groupKey == ns.FRAME_GROUPS.MAIN and "full" or "auto")
end

-- Apply wildcard defaults so any group subtable (existing or future) receives base fields
groupSettingsDefaults['*'] = defaultGroupSettings


local defaults = {
    char = {
        -- Display visibility settings
        enableAlways = true,
        enableOutOfCombat = true,
        hideDuringPetBattles = true,
        hideDuringVehicles = true,
        mouseInteractionKey = "ALT",
        useGroupDisplayMode = false,
        showRoundMaskPreview = true,
        tbcHunterRoundMaskDefaultApplied = false,
        -- Optional external parent anchor
        anchorParent = {
            enabled = false,
            frameName = "",
        },
        -- Frame and icon settings

        frameSettings = {
            width = 50,
            height = 50,
            point = "CENTER",
            relativePoint = "CENTER",
            offsetX = -75,
            offsetY = -150,
            scale = 1,
            alpha = 1,
            iconWidth = 44,
            iconHeight = 44,
            frameStrata = "MEDIUM",
            enabled = true, -- Add enabled property
        },
        groupSettings = groupSettingsDefaults,
        enableBorders = true,
        borderColor = { 0, 0, 0, 1 },
        borderThickness = 2,
        borderInset = 1,
        leftFramesEnabled = true,
        numLeftIcons = 5,
        numRightIcons = 4,
        numAboveIcons = 1,
        numBelowIcons = 1,
        iconWidth = 44,
        iconHeight = 44,
        frameWeight = 0.5,
        frameSpacing = 1,
        frameLevel = 50,
        advancedSettings = false,
        groupDisplayFrame = {
            point = "CENTER",
            relativePoint = "CENTER",
            offsetX = 0,
            offsetY = 0,
            width = 50,
            height = 50,
            masterScale = 1, -- Add master scale default
            enabled = false,
        },
        groupToPositionMapping = {
            [ns.SPELL_POSITIONS.PRIMARY] = ns.FRAME_GROUPS.MAIN,
            [ns.SPELL_POSITIONS.AOE] = ns.FRAME_GROUPS.AOE,
            [ns.SPELL_POSITIONS.LEFT] = ns.FRAME_GROUPS.COOLDOWNS,
            [ns.SPELL_POSITIONS.RIGHT] = ns.FRAME_GROUPS.SEQUENCE,
            [ns.SPELL_POSITIONS.ABOVE] = ns.FRAME_GROUPS.DEFENSIVES,
            [ns.SPELL_POSITIONS.BELOW] = ns.FRAME_GROUPS.INTERRUPTS,
        },
        -- Cooldown display settings
        enableCooldownSwipes = true,
        -- Icon overflow control
        disableIconOverflow = false, -- When true, hide overflow icons instead of showing them in left frames
        -- Screensaver settings
        screensaver = {
            enabled = true,
            idleTime = 30, -- seconds before auto-activation
            speed = 100, -- pixels per second
        },
        -- Death Knight: disease snapshot (legacy keys; see snapshotOverlays.dk_disease)
        showDKDiseaseSnapshot = true,
        showDKDiseaseSnapshotDPS = false,
        -- Generic snapshot overlay settings per overlay id
        snapshotOverlays = {
            dk_disease = { enabled = true, showDPS = false, locked = true, pos = { custom = false, point = "CENTER", relativePoint = "CENTER", x = 0, y = 0 } },
            feral_bleed = { enabled = true, showDPS = false, locked = true, pos = { custom = false, point = "CENTER", relativePoint = "CENTER", x = 0, y = 0 } },
        },
    },
    global = {
        enableTooltips = true,
    },
}

--- @class DisplayManager
local DisplayManager = NAG:CreateModule("DisplayManager", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    optionsOrder = 1,
    optionsComposers = {
        ["class"] = "class", -- Injects Snapshot overlay toggles into Class options tab
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DISPLAY,
        ns.DEBUG_CATEGORIES.MANAGERS
    },
    -- Event handlers using eventHandlers table
    eventHandlers = {
        PET_BATTLE_OPENING_START = true,
        PET_BATTLE_CLOSE = true,
        PET_BATTLE_OVER = true,
        UNIT_ENTERED_VEHICLE = true,
        UNIT_EXITED_VEHICLE = true,
        PLAYER_GAINS_VEHICLE_DATA = true,
        PLAYER_LOSES_VEHICLE_DATA = true,
        PLAYER_REGEN_DISABLED = true, -- Combat start
        PLAYER_REGEN_ENABLED = true,  -- Combat end
        PLAYER_TARGET_CHANGED = true, -- Target change
        UNIT_ATTACK_POWER = true,     -- AP changed (trinket procs, buffs, etc.) -> refresh DK disease overlay
        UNIT_STATS = true,            -- Base stats changed -> refresh DK disease overlay
        UNIT_DAMAGE = true,           -- Damage modifier changed -> refresh DK disease overlay
    },

    -- Message handlers for cross-module communication
    messageHandlers = {
        NAG_KEYBIND_SETTING_CHANGED = true, -- Update keybinds when setting changes
        NAG_STARTUP_COMPLETE = true, -- Update visibility when addon is fully loaded
        NAG_SNAPSHOT_OVERLAY_UPDATED = true, -- Refresh overlay when snapshot group data changes (payload: overlayId)
        NAG_ACTION_IDENTITY_INVALIDATED = true,
    },


    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        -- HIERARCHICAL FORMAT with multiple paths:
        ["display_share"] = {
            handler = "HandleShareDisplaySlashCommand",
            help = "Share your group display config with another player. Usage: /nagdebug display share <player>",
            root = "nagdebug",
            paths = {
                {"display", "share"},  -- /nagdebug display share
                {"sharedisplay"}       -- /nagdebug sharedisplay (shorter alternative)
            },
            category = "System"
        }
    }
})
local module = DisplayManager
ns.DisplayManager = DisplayManager



-- ============================ LEFT FRAME VISIBILITY ============================

--- Check if LEFT-position frames are enabled
--- @return boolean
function DisplayManager:IsLeftFramesEnabled()
    return self:GetSetting("char", "leftFramesEnabled", true) ~= false
end

--- Check if AOE frame is enabled
--- @return boolean
function DisplayManager:IsAoeFrameEnabled()
    return self:GetSetting("char", "groupSettings.aoe.enabled", true) ~= false
end

--- Get effective LEFT icon count (0 when disabled)
--- @return number
function DisplayManager:GetEffectiveNumLeftIcons()
    if not self:IsLeftFramesEnabled() then
        return 0
    end
    return self:GetSetting("char", "numLeftIcons", defaults.char.numLeftIcons)
end

--- Set LEFT-position frame visibility and refresh displays
--- @param enabled boolean
function DisplayManager:SetLeftFramesEnabled(enabled)
    local normalized = enabled ~= false
    if normalized == self:IsLeftFramesEnabled() then
        return normalized
    end

    self:SetSetting("char", "leftFramesEnabled", normalized)
    self:CreateOrUpdateIconFrames(NAG.Frame)
    self:UpdateFrameVisibility()
    self:ClearAllIconFrames()

    return normalized
end

--- Set AOE frame visibility and refresh displays
--- @param enabled boolean
--- @return boolean
function DisplayManager:SetAoeFrameEnabled(enabled)
    local normalized = enabled ~= false
    if normalized == self:IsAoeFrameEnabled() then
        return normalized
    end

    self:SetSetting("char", "groupSettings.aoe.enabled", normalized)
    self:CreateOrUpdateIconFrames(NAG.Frame)
    self:UpdateFrameVisibility()
    self:ClearAllIconFrames()

    return normalized
end

--- Effective group enabled check (respects left-frame disable for cooldowns group)
--- @param groupKey string
--- @return boolean
function DisplayManager:IsGroupEnabled(groupKey)
    local settings = self.db and self.db.char and self.db.char.groupSettings and self.db.char.groupSettings[groupKey]
    if not settings then
        return false
    end

    if groupKey == ns.FRAME_GROUPS.COOLDOWNS and not self:IsLeftFramesEnabled() then
        return false
    end

    return settings.enabled
end

-- Helper function to add keybind overlays
local function AddKeybindOverlayToFrame(frame)
    local KeybindManager = NAG:GetModule("KeybindManager")
    if KeybindManager then
        KeybindManager:AddKeybindToFrame(frame)
        -- Update immediately if method exists
        if frame.UpdateKeybindText then
            frame:UpdateKeybindText()
        end
    end
end


-- Module-level variable to track edit mode
DisplayManager.editMode = false
-- When true, class helper frames (twistbars, weave bars) are draggable via /nag unlock even when group/legacy are off
DisplayManager.classHelperEditMode = false

-- Display visibility state
DisplayManager.isInPetBattle = false
DisplayManager.isInVehicle = false
DisplayManager.hasVehicleUI = false



-- Frame border tracking
DisplayManager.framedBorders = DisplayManager.framedBorders or {}

-- New: Store all group frames and settings here
DisplayManager.groupFrames = DisplayManager.groupFrames or {}

-- Screensaver state tracking
DisplayManager.screensaver = {
    active = false,
    velocity = { x = 0, y = 0 },
    originalPosition = nil,
    lastInputTime = 0,
    updateAccumulator = 0,
    updateTimer = nil,
    idleCheckTimer = nil,
}
DisplayManager._lastFrameUpdateBroadcastAt = 0
DisplayManager.frameUpdateDiagnostics = {
    sent = 0,
    suppressed = 0,
    windowStartAt = 0,
}

--- Sends a throttled frame-updated message to avoid burst cascades.
--- @param reason string|nil
--- @return boolean sent
function DisplayManager:SendFrameUpdated(reason)
    local now = GetTime()
    local minInterval = FRAME_UPDATE_BROADCAST_MIN_INTERVAL_SEC
    self._lastFrameUpdateBroadcastAt = self._lastFrameUpdateBroadcastAt or 0
    self.frameUpdateDiagnostics = self.frameUpdateDiagnostics or {
        sent = 0,
        suppressed = 0,
        windowStartAt = now,
    }
    if self.frameUpdateDiagnostics.windowStartAt == 0 then
        self.frameUpdateDiagnostics.windowStartAt = now
    end

    if (now - self._lastFrameUpdateBroadcastAt) < minInterval then
        self.frameUpdateDiagnostics.suppressed = (self.frameUpdateDiagnostics.suppressed or 0) + 1
        return false
    end

    self._lastFrameUpdateBroadcastAt = now
    self.frameUpdateDiagnostics.sent = (self.frameUpdateDiagnostics.sent or 0) + 1
    self:SendMessage("NAG_FRAME_UPDATED")

    if (now - (self.frameUpdateDiagnostics.windowStartAt or now)) >= 10 then
        self:Debug(
            "NAG_FRAME_UPDATED rate: sent=%d suppressed=%d reason=%s",
            self.frameUpdateDiagnostics.sent or 0,
            self.frameUpdateDiagnostics.suppressed or 0,
            tostring(reason or "unspecified")
        )
        self.frameUpdateDiagnostics.sent = 0
        self.frameUpdateDiagnostics.suppressed = 0
        self.frameUpdateDiagnostics.windowStartAt = now
    end
    return true
end

-- Resolve the parent anchor for NAG frames
function DisplayManager:GetAnchorParent()
    local settings = self.db and self.db.char and self.db.char.anchorParent
    local parent = UIParent
    if settings and settings.enabled and settings.frameName and settings.frameName ~= "" then
        local candidate = _G[settings.frameName]
        -- Validate frame is valid and not destroyed
        if type(candidate) == "table" and candidate.GetName then
            -- Additional safety check: ensure frame hasn't been destroyed
            local success, name = pcall(candidate.GetName, candidate)
            if success and name then
                -- Verify frame can actually be used as a parent (test GetParent)
                local testSuccess = pcall(function() return candidate:GetParent() end)
                if testSuccess then
                    parent = candidate
                else
                    self:Warn("Anchor parent '%s' is invalid/destroyed. Falling back to UIParent.",
                        tostring(settings.frameName))
                end
            else
                self:Warn("Anchor parent '%s' cannot be accessed. Falling back to UIParent.",
                    tostring(settings.frameName))
            end
        else
            self:Warn("Anchor parent '%s' not found. Falling back to UIParent.",
                tostring(settings.frameName))
        end
    end
    -- Ensure we always return a valid parent
    if not parent or parent == nil then
        parent = UIParent
    end
    return parent
end

--- Anchor a frame to the right of the current NAG display (group or legacy frame).
--- Parents the frame to the display so it stays in the NAG hierarchy when dragged.
--- @param frame table WoW frame to position
--- @param point string Frame point (e.g. "BOTTOMLEFT", "LEFT")
--- @param xOffset number Horizontal offset from display's right edge (default 8)
--- @param yOffset number Vertical offset (default 0)
function DisplayManager:AnchorFrameToRightOfDisplay(frame, point, xOffset, yOffset)
    if not frame or not frame.ClearAllPoints or not frame.SetPoint then
        return false
    end
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    if not anchor or anchor == _G.UIParent then
        return false
    end
    local x = (type(xOffset) == "number") and xOffset or 8
    local y = (type(yOffset) == "number") and yOffset or 0
    local anchorPoint = (point == "BOTTOMLEFT" or point == "TOPLEFT" or point == "LEFT") and "BOTTOMRIGHT" or "RIGHT"
    if point == "TOPLEFT" then
        anchorPoint = "TOPRIGHT"
    end
    -- Don't reparent: keep frame on UIParent so the main frame's layout (e.g. floating selector) isn't affected
    frame:ClearAllPoints()
    frame:SetPoint(point or "BOTTOMLEFT", anchor, anchorPoint, x, y)
    return true
end

-- Apply current anchor parent (reparent and re-point frames)
function DisplayManager:ApplyAnchorParent()
    local parent = self:GetAnchorParent()

    -- Validate parent is actually valid before using
    if not parent then
        self:Error("ApplyAnchorParent: Invalid parent frame, aborting")
        return
    end

    -- Verify parent is accessible (not destroyed)
    local parentValid, parentName = pcall(parent.GetName, parent)
    if not parentValid then
        self:Error("ApplyAnchorParent: Parent frame is destroyed, falling back to UIParent")
        parent = UIParent
    end

    if NAG.Frame then
        local fs = self.db.char.frameSettings
        local success, err = pcall(function()
            NAG.Frame:SetParent(parent)
            NAG.Frame:ClearAllPoints()
            NAG.Frame:SetPoint(fs.point or "CENTER", parent, fs.relativePoint or "CENTER", fs.offsetX or 0, fs.offsetY or 0)
        end)
        if not success then
            self:Error("ApplyAnchorParent: Failed to reparent NAG.Frame: %s", tostring(err))
        end
    end
    if NAG.GroupDisplayFrame then
        local gdf = self.db.char.groupDisplayFrame
        local success, err = pcall(function()
            NAG.GroupDisplayFrame:SetParent(parent)
            NAG.GroupDisplayFrame:ClearAllPoints()
            NAG.GroupDisplayFrame:SetPoint(gdf.point or "CENTER", parent, gdf.relativePoint or "CENTER", gdf.offsetX or 0,
                gdf.offsetY or 0)
        end)
        if not success then
            self:Error("ApplyAnchorParent: Failed to reparent NAG.GroupDisplayFrame: %s", tostring(err))
        end
    end
end

-- Reset stored offsets to center relative to current parent (safest when toggling anchors)
function DisplayManager:ResetAnchorOffsetsToCenter()
    -- Legacy frame settings
    self.db.char.frameSettings.point = "CENTER"
    self.db.char.frameSettings.relativePoint = "CENTER"
    self.db.char.frameSettings.offsetX = 0
    self.db.char.frameSettings.offsetY = 0

    -- Group display frame settings
    self.db.char.groupDisplayFrame.point = "CENTER"
    self.db.char.groupDisplayFrame.relativePoint = "CENTER"
    self.db.char.groupDisplayFrame.offsetX = 0
    self.db.char.groupDisplayFrame.offsetY = 0

    local parent = self:GetAnchorParent()
    if not parent then
        self:Error("ResetAnchorOffsetsToCenter: Invalid parent frame, aborting")
        return
    end

    if NAG.Frame then
        local success, err = pcall(function()
            NAG.Frame:ClearAllPoints()
            NAG.Frame:SetPoint("CENTER", parent, "CENTER", 0, 0)
        end)
        if not success then
            self:Error("ResetAnchorOffsetsToCenter: Failed to reset NAG.Frame position: %s", tostring(err))
        end
    end
    if NAG.GroupDisplayFrame then
        local success, err = pcall(function()
            NAG.GroupDisplayFrame:ClearAllPoints()
            NAG.GroupDisplayFrame:SetPoint("CENTER", parent, "CENTER", 0, 0)
        end)
        if not success then
            self:Error("ResetAnchorOffsetsToCenter: Failed to reset NAG.GroupDisplayFrame position: %s", tostring(err))
        end
    end
end

function DisplayManager:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    DataManager = NAG:GetModule("DataManager")
    SpellbookManager = NAG:GetModule("SpellbookManager")
    KeybindManager = NAG:GetModule("KeybindManager")
    OverlayManager = NAG:GetModule("OverlayManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    ShareInGame = NAG:GetModule("ShareInGame")
end

-- In your Ace3 lifecycle (e.g., OnInitialize or OnEnable):
function DisplayManager:ModuleEnable()
    -- One-time migration: apply round mask as default for all chars who haven't had it applied yet
    if self.db and self.db.char and self.db.char.tbcHunterRoundMaskDefaultApplied ~= true then
        self.db.char.showRoundMaskPreview = true
        self.db.char.tbcHunterRoundMaskDefaultApplied = true
    end

    -- ============================ MODULE INITIALIZATION ============================
    self:InitializeGroupFramesAndIcons()
    -- Ensure correct parenting on enable
    self:ApplyAnchorParent()
    self:UpdateFrameVisibility()

    -- ============================ PREDICTION QUEUE INITIALIZATION ============================
    -- Initialize prediction queue frames if enabled AND legacy display is enabled
    -- GroupDisplay mode uses integrated predictions in main container, no standalone frames needed
    local predictionSettings = NAG.db.char.predictionQueue
    if predictionSettings and predictionSettings.enabled and self:IsLegacyFrameEnabled() then
        local numPredictions = predictionSettings.numPredictions or 2
        self:CreatePredictionQueue(numPredictions)
        local mainFrame = self:GetMainDisplayFrame()
        if mainFrame then
            self:PositionQueueFrame(mainFrame)
        end
    end

    -- Register for prediction queue setting changes
    self:RegisterMessage("NAG_SETTING_CHANGED", function(message, namespace, ...)
        if namespace == "char" then
            local args = {...}
            -- Support dot-notation keys from OptionsManager:SetSetting (e.g. "predictionQueue.enabled", "predictionQueue.numPredictions")
            local key = args[1]
            local value = args[2]
            if key == "predictionQueue.enabled" then
                local enabled = value
                if enabled then
                    -- Only create standalone frames if legacy display is enabled
                    -- GroupDisplay mode uses integrated predictions in main container
                    if self:IsLegacyFrameEnabled() then
                        local numPredictions = NAG.db.char.predictionQueue.numPredictions or 2
                        self:CreatePredictionQueue(numPredictions)
                        local mainFrame = self:GetMainDisplayFrame()
                        if mainFrame then
                            self:PositionQueueFrame(mainFrame)
                        end
                    end
                else
                    -- Hide prediction queue frames
                    self:HidePredictionQueue()
                end
            elseif key == "predictionQueue.numPredictions" then
                -- Recreate prediction queue with new number of predictions
                -- Only if both prediction queue and legacy display are enabled
                if NAG.db.char.predictionQueue.enabled and self:IsLegacyFrameEnabled() then
                    local numPredictions = value or 2
                    self:CreatePredictionQueue(numPredictions)
                    local mainFrame = self:GetMainDisplayFrame()
                    if mainFrame then
                        self:PositionQueueFrame(mainFrame)
                    end
                end
            end
        end
    end)

    if ShareInGame then
        ShareInGame:RegisterHandler("DisplayConfig", function(sender, data)
            if data and data.groupSettings then
                -- Optionally prompt user for confirmation here
                for group, settings in pairs(data.groupSettings) do
                    self.db.char.groupSettings[group] = settings
                    DisplayManager:CreateGroupIcons(group)
                end
                DisplayManager:UpdateFrameVisibility()
                DisplayManager:Info("Received and applied display config from " .. tostring(sender))
            end
        end)
    end
    -- Slash commands are now handled via zero-boilerplate slashCommands table



    self:UpdateClickThrough()

    -- Pet battle event registration and state
    self:InitializePetBattleState()

    -- Vehicle event registration and state
    self:InitializeVehicleState()

    -- ============================ SCREENSAVER INITIALIZATION ============================
    -- Start idle check timer for auto-activation
    if self.db.char.screensaver.enabled then
        self.screensaver.lastInputTime = GetTime()
        if not self.screensaver.idleCheckTimer then
            self.screensaver.idleCheckTimer = C_Timer.NewTicker(1, function()
                DisplayManager:CheckScreensaverIdle()
            end)
        end
    end

    -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns
end

--- Called when the module is disabled - proper cleanup for UI elements
--- @param self DisplayManager
function DisplayManager:ModuleDisable()
    self:Info("Disabling DisplayManager - cleaning up UI elements")

    -- Stop screensaver if active
    if self.screensaver.active then
        self:StopScreensaver()
    end

    -- Cancel idle check timer
    if self.screensaver.idleCheckTimer then
        self.screensaver.idleCheckTimer:Cancel()
        self.screensaver.idleCheckTimer = nil
    end

    -- Hide all group frames
    if self.groupFrames then
        for groupKey, frame in pairs(self.groupFrames) do
            if frame and frame.Hide then
                frame:Hide()
            end
        end
    end

    -- Hide main display frame
    if NAG.GroupDisplayFrame and NAG.GroupDisplayFrame.Hide then
        NAG.GroupDisplayFrame:Hide()
    end

    -- Clean up legacy frame system
    if NAG.Frame then
        -- Hide legacy frame
        NAG.Frame:Hide()

        -- Clean up legacy icon frames
        if NAG.Frame.iconFrames then
            for _, frame in pairs(NAG.Frame.iconFrames) do
                if frame and frame.RemoveTooltip then
                    frame:RemoveTooltip()
                end
                if frame and frame.RemoveBorder then
                    frame:RemoveBorder()
                end
                frame:Hide()
                frame:SetParent(nil)
            end
            NAG.Frame.iconFrames = {}
        end

        -- Clean up legacy frame event handlers
        NAG.Frame:SetScript("OnMouseDown", nil)
        NAG.Frame:SetScript("OnMouseUp", nil)
        NAG.Frame:SetScript("OnMouseWheel", nil)

        -- Clean up close button and overlay
        if NAG.Frame.closeButton then
            NAG.Frame.closeButton:Hide()
            NAG.Frame.closeButton:SetParent(nil)
            NAG.Frame.closeButton = nil
        end
        if NAG.Frame.editModeOverlay then
            NAG.Frame.editModeOverlay:Hide()
            NAG.Frame.editModeOverlay:SetParent(nil)
            NAG.Frame.editModeOverlay = nil
        end
    end

    -- Clean up pet battle state
    self.isInPetBattle = false

    -- Clean up vehicle state
    self.isInVehicle = false

    -- Clear frame references
    self.framedBorders = {}

    if ShareInGame.UnregisterHandler then
        ShareInGame:UnregisterHandler("DisplayConfig")
    end
end

do -- ~~~~~~~~~~~~~~ FRAME GROUPS CONFIG ~~~~~~~~~~~~~~
    -- Helper: Determine icon size and texcoord based on direction
    local function getIconShapeForDirection(dir, baseWidth, baseHeight)
        -- dir is a table from COMPASS_DIRECTIONS
        if dir.x ~= 0 and dir.y ~= 0 then
            -- Diagonal or secondary ordinal: crop both
            return baseWidth * 0.5, baseHeight * 0.5, { 0.25, 0.75, 0.25, 0.75 }
        elseif dir.x ~= 0 then
            -- Horizontal: crop width
            return baseWidth * 0.5, baseHeight, { 0.25, 0.75, 0.1, 0.9 }
        elseif dir.y ~= 0 then
            -- Vertical: crop height
            return baseWidth, baseHeight * 0.5, { 0.1, 0.9, 0.25, 0.75 }
        else
            -- Fallback: no crop
            return baseWidth, baseHeight, { 0.1, 0.9, 0.1, 0.9 }
        end
    end

    -- Function to create a frame for a group with drag/scale logic
    function DisplayManager:CreateGroupFrame(groupKey)
        local group = FRAME_GROUPS[groupKey]
        if not group then return end
        -- Use proper database access with defaults
        local settings = self.db.char.groupSettings[groupKey]
        -- Create the frame if it doesn't exist
        if not self.groupFrames[groupKey] then
            local frame = CreateFrame("Frame", "NAG_" .. groupKey .. "Frame", NAG.GroupDisplayFrame)
            frame:SetSize(settings.width, settings.height)
            frame:SetPoint(settings.point, NAG.GroupDisplayFrame, settings.relativePoint, settings.offsetX,
                settings.offsetY)
            frame:SetScale(settings.scale)
            frame:SetAlpha(settings.alpha)
            frame:SetFrameStrata(settings.frameStrata)
            frame:SetFrameLevel(settings.frameLevel)
            frame:EnableMouse(false)
            frame:SetMovable(false) -- Not movable by default
            -- Do NOT set drag/move/scale handlers here; only in edit mode
            frame:Hide()            -- Start hidden, show when needed
            self.groupFrames[groupKey] = frame
        end
        return self.groupFrames[groupKey]
    end

    -- New: Initialize all group frames and icons (call from OnInitialize/OnEnable)
    function DisplayManager:InitializeGroupFramesAndIcons()
        -- Create a container for all group-based frames
        if not NAG.GroupDisplayFrame then
            local parent = self:GetAnchorParent()
            NAG.GroupDisplayFrame = CreateFrame("Frame", "NAGGroupDisplayFrame", parent)
            -- Use saved position if available
            local gdfSettings = self.db.char.groupDisplayFrame
            NAG.GroupDisplayFrame:SetPoint(gdfSettings.point or "CENTER", parent, gdfSettings.relativePoint or "CENTER",
                gdfSettings.offsetX or 0, gdfSettings.offsetY or 0)
        end
        -- Set size to match main group
        self:UpdateGroupDisplayFrameSize()
        NAG.GroupDisplayFrame:Show() -- Shown/hidden by group display logic

        -- Add blue background for edit mode
        if not NAG.GroupDisplayFrame.editBg then
            local bg = NAG.GroupDisplayFrame:CreateTexture(nil, "BACKGROUND")
            bg:SetColorTexture(0, 0.4, 1, 0.25) -- semi-transparent blue
            bg:Hide()
            NAG.GroupDisplayFrame.editBg = bg
        end

        for groupKey, _ in pairs(FRAME_GROUPS) do
            self:CreateGroupFrame(groupKey)
            self:CreateGroupIcons(groupKey)
        end
        self:UpdateGroupFramePositionsForRoundPreview()
        -- After all frames/icons, ensure size is synced
        self:UpdateGroupDisplayFrameSize()
        -- Set master scale after creation
        local scale = self.db.char.groupDisplayFrame.masterScale
        NAG.GroupDisplayFrame:SetScale(scale)
        -- Create DK disease snapshot overlay above main icons (created once, shown only for DK with disease)
        self:EnsureDKDiseaseSnapshotOverlay()
    end

    --- @param icon table
    --- @param fallbackFont string
    --- @param fallbackSize number
    local function SetupRoundPreviewTextFonts(icon, fallbackFont, fallbackSize)
        if not icon then return end
        if icon.chargeText then
            local currentFont = icon.chargeText:GetFont()
            if currentFont then
                icon.chargeText:SetFont(currentFont, 14, "OUTLINE")
            else
                icon.chargeText:SetFont(fallbackFont, fallbackSize, "OUTLINE")
            end
        end
        if icon.overlayText then
            local overlayFont = icon.overlayText:GetFont()
            if overlayFont then
                icon.overlayText:SetFont(overlayFont, 12, "OUTLINE")
            else
                icon.overlayText:SetFont(fallbackFont, 12, "OUTLINE")
            end
        end
    end

    --- @param sourceIcon table
    --- @param roundIcon table
    --- @param previewEnabled boolean
    local function ApplyRoundPreviewSlotVisibility(sourceIcon, roundIcon, previewEnabled)
        if not sourceIcon or not roundIcon then return end
        local hasData = sourceIcon._hasDisplayData
        if hasData == nil then
            hasData = sourceIcon:IsShown()
        end
        if previewEnabled then
            sourceIcon:SetShown(false)
            roundIcon:SetShown(hasData == true)
        else
            sourceIcon:SetShown(hasData == true)
            roundIcon:SetShown(false)
        end
    end

    --- @param groupKey string
    --- @return boolean
    function DisplayManager:IsRoundMaskPreviewEnabled(groupKey)
        if not self.db or not self.db.char or self.db.char.showRoundMaskPreview ~= true then
            return false
        end
        if not groupKey then
            return self:IsGroupDisplayMode() or self:IsLegacyFrameEnabled()
        end
        if not self:IsGroupDisplayMode() then
            return false
        end
        if groupKey then
            return self:IsGroupEnabled(groupKey)
        end
        return true
    end

    --- Returns the mask texture path for round-preview icons by legacy position/group key.
    --- @param positionOrGroupKey string|nil
    --- @return string
    function DisplayManager:GetRoundPreviewMaskTextureForPosition(positionOrGroupKey)
        local resolvedPosition = positionOrGroupKey
        if resolvedPosition == ns.SPELL_POSITIONS.PRIMARY or not resolvedPosition then
            return CIRCLE_MASK_TEXTURE
        elseif resolvedPosition == ns.SPELL_POSITIONS.AOE then
            return MASK_AOE
        elseif resolvedPosition == ns.SPELL_POSITIONS.LEFT or strmatch(tostring(resolvedPosition or ""), "^left") then
            return MASK_LEFT
        elseif resolvedPosition == ns.SPELL_POSITIONS.ABOVE or strmatch(tostring(resolvedPosition or ""), "^above") then
            return MASK_ABOVE
        elseif resolvedPosition == ns.SPELL_POSITIONS.BELOW or strmatch(tostring(resolvedPosition or ""), "^below") then
            return MASK_BELOW
        elseif resolvedPosition == ns.SPELL_POSITIONS.RIGHT or strmatch(tostring(resolvedPosition or ""), "^right") then
            return MASK_RIGHT
        end
        return CIRCLE_MASK_TEXTURE
    end

    --- Returns the mask texture path for round-preview icons by group. Uses per-position masks from groupToPositionMapping.
    --- @param groupKey string
    --- @return string
    function DisplayManager:GetRoundPreviewMaskTextureForGroup(groupKey)
        local mapping = self.db and self.db.char and self.db.char.groupToPositionMapping
        local resolvedPosition = nil
        if type(mapping) == "table" then
            for spellPosition, mappedGroupKey in pairs(mapping) do
                if mappedGroupKey == groupKey then
                    resolvedPosition = spellPosition
                    break
                end
            end
        end

        return self:GetRoundPreviewMaskTextureForPosition(resolvedPosition)
    end

    --- Returns the resolved spell position for a group (for dimension scaling). Uses groupToPositionMapping.
    --- @param groupKey string
    --- @return string|nil Resolved position (e.g. ns.SPELL_POSITIONS.LEFT) or nil
    function DisplayManager:GetRoundPreviewResolvedPositionForGroup(groupKey)
        local mapping = self.db and self.db.char and self.db.char.groupToPositionMapping
        if type(mapping) ~= "table" then return nil end
        for spellPosition, mappedGroupKey in pairs(mapping) do
            if mappedGroupKey == groupKey then
                return spellPosition
            end
        end
        return nil
    end

    --- Returns group-style layout (offset, dimensions, texCoord) for a legacy position when round preview is on.
    --- Ensures legacy round icons match modern group display positioning, spacing, and scale.
    --- @param key string Legacy position key (primary, aoe, left1, right1, above1, below1, etc.)
    --- @return number|nil offsetX, number|nil offsetY, number|nil iconWidth, number|nil iconHeight, table|nil texCoord, string|nil resolvedPos
    function DisplayManager:GetGroupStyleRoundLayoutForLegacyPosition(key)
        local mapping = self.db and self.db.char and self.db.char.groupToPositionMapping
        if type(mapping) ~= "table" then return nil, nil, nil, nil, nil, nil end

        local positionKey, index
        if key == ns.SPELL_POSITIONS.PRIMARY then
            positionKey = ns.SPELL_POSITIONS.PRIMARY
            index = 1
        elseif key == ns.SPELL_POSITIONS.AOE then
            positionKey = ns.SPELL_POSITIONS.AOE
            index = 1
        elseif strmatch(tostring(key or ""), "^left") then
            positionKey = ns.SPELL_POSITIONS.LEFT
            index = tonumber(strmatch(tostring(key or ""), "%d+")) or 1
        elseif strmatch(tostring(key or ""), "^right") then
            positionKey = ns.SPELL_POSITIONS.RIGHT
            index = tonumber(strmatch(tostring(key or ""), "%d+")) or 1
        elseif strmatch(tostring(key or ""), "^above") then
            positionKey = ns.SPELL_POSITIONS.ABOVE
            index = tonumber(strmatch(tostring(key or ""), "%d+")) or 1
        elseif strmatch(tostring(key or ""), "^below") then
            positionKey = ns.SPELL_POSITIONS.BELOW
            index = tonumber(strmatch(tostring(key or ""), "%d+")) or 1
        else
            return nil, nil, nil, nil, nil, nil
        end

        local groupKey = mapping[positionKey]
        if not groupKey then return nil, nil, nil, nil, nil, nil end

        local settings = self.db.char.groupSettings and self.db.char.groupSettings[groupKey]
        if not settings then return nil, nil, nil, nil, nil, nil end

        -- RIGHT: use mirrored LEFT layout (same spacing, same distance, positioned to the right)
        local mirrorForRight = (positionKey == ns.SPELL_POSITIONS.RIGHT)
        local leftGroupKey = mapping[ns.SPELL_POSITIONS.LEFT]
        local leftSettings = leftGroupKey and self.db.char.groupSettings and self.db.char.groupSettings[leftGroupKey]
        if mirrorForRight and leftSettings then
            settings = leftSettings
            groupKey = leftGroupKey
        end

        local flowKey = (settings.iconFlowDirection or "E"):upper()
        local dirIdx = 1
        for i, dir in ipairs(COMPASS_DIRECTIONS) do
            if dir.key == flowKey then
                dirIdx = i
                break
            end
        end
        local dir = COMPASS_DIRECTIONS[dirIdx]
        local xMul, yMul = dir.x, dir.y
        if mirrorForRight then
            xMul = -xMul
        end
        local overlap = settings.iconOverlap or 0
        local spacingFactor = 1 - overlap
        local borderSpacing = (self.db.char.enableBorders and self.db.char.borderThickness) and (2 * self.db.char.borderThickness) or 0

        local cropStyle = settings.iconCropStyle or "auto"
        if groupKey == ns.FRAME_GROUPS.MAIN then
            cropStyle = "full"
        end
        local iconWidth, iconHeight, texCoord
        if cropStyle == "full" then
            iconWidth, iconHeight, texCoord = settings.iconWidth, settings.iconHeight, { 0.1, 0.9, 0.1, 0.9 }
        elseif cropStyle == "half" then
            if math.abs(dir.x) > math.abs(dir.y) then
                iconWidth, iconHeight, texCoord = settings.iconWidth * 0.5, settings.iconHeight, { 0.25, 0.75, 0.1, 0.9 }
            else
                iconWidth, iconHeight, texCoord = settings.iconWidth, settings.iconHeight * 0.5, { 0.1, 0.9, 0.25, 0.75 }
            end
        elseif cropStyle == "quarter" then
            iconWidth, iconHeight, texCoord = settings.iconWidth * 0.5, settings.iconHeight * 0.5, { 0.25, 0.75, 0.25, 0.75 }
        else
            if dir.x ~= 0 and dir.y ~= 0 then
                iconWidth, iconHeight, texCoord = settings.iconWidth * 0.5, settings.iconHeight * 0.5, { 0.25, 0.75, 0.25, 0.75 }
            elseif dir.x ~= 0 then
                iconWidth, iconHeight, texCoord = settings.iconWidth * 0.5, settings.iconHeight, { 0.25, 0.75, 0.1, 0.9 }
            elseif dir.y ~= 0 then
                iconWidth, iconHeight, texCoord = settings.iconWidth, settings.iconHeight * 0.5, { 0.1, 0.9, 0.25, 0.75 }
            else
                iconWidth, iconHeight, texCoord = settings.iconWidth, settings.iconHeight, { 0.1, 0.9, 0.1, 0.9 }
            end
        end

        local groupOffsetX = settings.offsetX or 0
        local groupOffsetY = settings.offsetY or 0
        if mirrorForRight then
            groupOffsetX = -groupOffsetX
        end
        local slotOffsetX = (index - 1) * ((iconWidth + 2 + borderSpacing) * xMul * spacingFactor)
        local slotOffsetY = (index - 1) * ((iconHeight + 2 + borderSpacing) * yMul * spacingFactor)
        if groupKey ~= ns.FRAME_GROUPS.MAIN then
            slotOffsetX = slotOffsetX * ROUND_PREVIEW_ICON_SPACING_FACTOR
            slotOffsetY = slotOffsetY * ROUND_PREVIEW_ICON_SPACING_FACTOR
        end
        local offsetX = groupOffsetX * ROUND_PREVIEW_SPACING_FACTOR + slotOffsetX
        local offsetY = groupOffsetY * ROUND_PREVIEW_SPACING_FACTOR + slotOffsetY
        if positionKey == ns.SPELL_POSITIONS.AOE then
            offsetX, offsetY = 0, 0
        end

        return offsetX, offsetY, iconWidth, iconHeight, texCoord, positionKey
    end

    --- @param frame Frame
    --- @param groupKey string
    --- @param index number
    --- @param iconWidth number
    --- @param iconHeight number
    --- @param offsetX number
    --- @param offsetY number
    --- @param texCoord table
    --- @return Frame|nil
    function DisplayManager:EnsureRoundPreviewIcon(frame, groupKey, index, iconWidth, iconHeight, offsetX, offsetY, texCoord)
        if not frame then return nil end
        frame.roundIconFrames = frame.roundIconFrames or {}
        local roundIcon = frame.roundIconFrames[index]
        if not roundIcon then
            local roundIconName = "NAG_" .. groupKey .. "RoundIcon" .. index
            roundIcon = CreateFrame("Frame", roundIconName, frame)
            -- Black background border: same mask, 15% larger, acts as outline. Sublevel -1 so always behind icon.
            roundIcon.bg = roundIcon:CreateTexture(nil, "BACKGROUND", nil, -1)
            roundIcon.bg:SetColorTexture(0, 0, 0, 1)
            roundIcon.bgMask = roundIcon:CreateMaskTexture()
            roundIcon.bg:AddMaskTexture(roundIcon.bgMask)

            roundIcon.texture = roundIcon:CreateTexture(nil, "BACKGROUND", nil, 0)
            roundIcon.texture:SetAllPoints()
            roundIcon.mask = roundIcon:CreateMaskTexture()
            local maskPath = self:GetRoundPreviewMaskTextureForGroup(groupKey)
            roundIcon.mask:SetTexture(maskPath, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            roundIcon.mask:SetAllPoints(roundIcon.texture)
            roundIcon.texture:AddMaskTexture(roundIcon.mask)

            -- Cooldown on primary: Blizzard Cooldown frame; use circular swipe texture (same as icon mask)
            if self:AreCooldownSwipesEnabled() and groupKey == ns.FRAME_GROUPS.MAIN then
                roundIcon.cooldown = CreateFrame("Cooldown", nil, roundIcon, "CooldownFrameTemplate")
                roundIcon.cooldown:SetAllPoints()
                local swipeMaskPath = self:GetRoundPreviewMaskTextureForGroup(groupKey)
                if roundIcon.cooldown.SetSwipeTexture then
                    roundIcon.cooldown:SetSwipeTexture(swipeMaskPath)
                end
                if roundIcon.cooldown.SetSwipeColor then
                    roundIcon.cooldown:SetSwipeColor(0, 0, 0, 0.8 * MASKED_SWIPE_ALPHA_MULTIPLIER)
                end
                if roundIcon.cooldown.SetFrameStrata then
                    roundIcon.cooldown:SetFrameStrata("MEDIUM")
                end
                roundIcon.cooldown:Hide()
            end

            roundIcon.chargeText = roundIcon:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
            roundIcon.chargeText:SetPoint("BOTTOMRIGHT", roundIcon, "BOTTOMRIGHT", -2, 2)
            roundIcon.chargeText:SetText("")
            roundIcon.chargeText:Hide()

            roundIcon.overlayText = roundIcon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            roundIcon.overlayText:SetPoint("BOTTOM", roundIcon, "TOP", 0, 10)
            roundIcon.overlayText:SetJustifyH("CENTER")
            roundIcon.overlayText:SetJustifyV("BOTTOM")
            roundIcon.overlayText:SetText("")
            roundIcon.overlayText:Hide()

            SetupRoundPreviewTextFonts(roundIcon, "Fonts\\FRIZQT__.TTF", 14)
            if groupKey == ns.FRAME_GROUPS.MAIN then
                roundIcon.keybindFontSizeScale = ROUND_PREVIEW_PRIMARY_KEYBIND_FONT_SCALE
            else
                roundIcon.keybindFontSizeScale = ROUND_PREVIEW_KEYBIND_FONT_SCALE
            end
            AddKeybindOverlayToFrame(roundIcon)
            self:AddTooltip(roundIcon)
            roundIcon:Hide()
            frame.roundIconFrames[index] = roundIcon
        end

        -- Migrate old cooldownSweep to Blizzard Cooldown frame
        if roundIcon.cooldownSweep and groupKey == ns.FRAME_GROUPS.MAIN and self:AreCooldownSwipesEnabled() then
            roundIcon.cooldownSweep:Hide()
            roundIcon.cooldownSweep:SetParent(nil)
            roundIcon.cooldownSweep = nil
            roundIcon.cooldown = CreateFrame("Cooldown", nil, roundIcon, "CooldownFrameTemplate")
            roundIcon.cooldown:SetAllPoints()
            local swipeMaskPath = self:GetRoundPreviewMaskTextureForGroup(groupKey)
            if roundIcon.cooldown.SetSwipeTexture then
                roundIcon.cooldown:SetSwipeTexture(swipeMaskPath)
            end
            if roundIcon.cooldown.SetSwipeColor then
                roundIcon.cooldown:SetSwipeColor(0, 0, 0, 0.8 * MASKED_SWIPE_ALPHA_MULTIPLIER)
            end
            if roundIcon.cooldown.SetFrameStrata then
                roundIcon.cooldown:SetFrameStrata("MEDIUM")
            end
            roundIcon.cooldown:Hide()
        end

        roundIcon.groupKey = groupKey
        local baseScale = (groupKey ~= ns.FRAME_GROUPS.MAIN) and ROUND_PREVIEW_SECONDARY_ICON_SCALE or 1
        local wScale, hScale = baseScale, baseScale
        local resolvedPos = self:GetRoundPreviewResolvedPositionForGroup(groupKey)
        if resolvedPos == ns.SPELL_POSITIONS.LEFT or resolvedPos == ns.SPELL_POSITIONS.RIGHT or strmatch(tostring(resolvedPos or ""), "^left") or strmatch(tostring(resolvedPos or ""), "^right") then
            wScale = baseScale * ROUND_PREVIEW_LEFT_RIGHT_WIDTH_SCALE
        elseif resolvedPos == ns.SPELL_POSITIONS.ABOVE or resolvedPos == ns.SPELL_POSITIONS.BELOW or strmatch(tostring(resolvedPos or ""), "^above") or strmatch(tostring(resolvedPos or ""), "^below") then
            hScale = baseScale * ROUND_PREVIEW_ABOVE_BELOW_HEIGHT_SCALE
        end
        local w, h = iconWidth * wScale, iconHeight * hScale
        roundIcon:SetSize(w, h)
        roundIcon:ClearAllPoints()
        roundIcon:SetPoint("CENTER", frame, "CENTER", offsetX, offsetY)
        if groupKey ~= ns.FRAME_GROUPS.MAIN then
            local l, r, t, b = unpack(texCoord)
            roundIcon.texture:SetTexCoord(ExpandTexCoordForZoomOut(l, r, t, b, ROUND_PREVIEW_SECONDARY_ICON_IMAGE_ZOOM))
        else
            roundIcon.texture:SetTexCoord(unpack(texCoord))
        end
        roundIcon.texture:ClearAllPoints()
        roundIcon.texture:SetAllPoints()
        local maskPath = self:GetRoundPreviewMaskTextureForGroup(groupKey)
        local bgW, bgH = w * MASK_BORDER_SCALE, h * MASK_BORDER_SCALE
        if roundIcon.bg then
            roundIcon.bg:ClearAllPoints()
            roundIcon.bg:SetPoint("CENTER", roundIcon, "CENTER", 0, 0)
            roundIcon.bg:SetSize(bgW, bgH)
        end
        if roundIcon.bgMask then
            roundIcon.bgMask:SetTexture(maskPath, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            roundIcon.bgMask:SetAllPoints(roundIcon.bg)
        end
        if roundIcon.mask then
            roundIcon.mask:SetTexture(maskPath, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            roundIcon.mask:SetAllPoints(roundIcon.texture)
        end
        return roundIcon
    end

    --- @param frame Frame
    function DisplayManager:TrimRoundPreviewIcons(frame)
        if not frame or not frame.roundIconFrames or not frame.iconFrames then return end
        for i = #frame.roundIconFrames, #frame.iconFrames + 1, -1 do
            local roundIcon = frame.roundIconFrames[i]
            if roundIcon then
                roundIcon:Hide()
                roundIcon:SetParent(nil)
                frame.roundIconFrames[i] = nil
            end
        end
    end

    --- Creates or updates a parallel round icon for a legacy position (full parity with group round preview).
    --- Uses same masks, black bg, spacing, scaling, keybind scale, and cooldown rules as group display.
    --- @param key string Legacy position key (primary, aoe, left1, right1, above1, below1, etc.)
    --- @param parent Frame Parent frame (NAG.Frame)
    --- @param primaryFrame Frame Primary icon frame (anchor for round icons)
    --- @param iconWidth number Base icon width
    --- @param iconHeight number Base icon height
    --- @param frameWeight number Frame weight for secondary sizing
    --- @param gap number Spacing between icons
    --- @param point string Anchor point
    --- @param relativePoint string Relative anchor point
    --- @param offsetX number X offset (will be scaled by round preview factors)
    --- @param offsetY number Y offset (will be scaled by round preview factors)
    --- @param texCoord table Texture coordinates
    --- @param isPrimary boolean True for primary position
    --- @return Frame|nil The round icon frame
    function DisplayManager:EnsureLegacyRoundPreviewIcon(key, parent, primaryFrame, iconWidth, iconHeight, frameWeight,
                                                       gap, point, relativePoint, offsetX, offsetY, texCoord, isPrimary)
        if not parent or not primaryFrame then return nil end
        NAG.Frame.roundIconFrames = NAG.Frame.roundIconFrames or {}
        local roundIcon = NAG.Frame.roundIconFrames[key]
        if not roundIcon then
            local roundIconName = "NAG_LegacyRoundIcon_" .. key
            roundIcon = CreateFrame("Frame", roundIconName, parent)
            roundIcon.bg = roundIcon:CreateTexture(nil, "BACKGROUND", nil, -1)
            roundIcon.bg:SetColorTexture(0, 0, 0, 1)
            roundIcon.bgMask = roundIcon:CreateMaskTexture()
            roundIcon.bg:AddMaskTexture(roundIcon.bgMask)

            roundIcon.texture = roundIcon:CreateTexture(nil, "BACKGROUND", nil, 0)
            roundIcon.texture:SetAllPoints()
            roundIcon.mask = roundIcon:CreateMaskTexture()
            local maskPath = self:GetRoundPreviewMaskTextureForPosition(key)
            roundIcon.mask:SetTexture(maskPath, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            roundIcon.mask:SetAllPoints(roundIcon.texture)
            roundIcon.texture:AddMaskTexture(roundIcon.mask)

            if self:AreCooldownSwipesEnabled() and isPrimary then
                roundIcon.cooldown = CreateFrame("Cooldown", nil, roundIcon, "CooldownFrameTemplate")
                roundIcon.cooldown:SetAllPoints()
                local swipeMaskPath = self:GetRoundPreviewMaskTextureForPosition(key)
                if roundIcon.cooldown.SetSwipeTexture then
                    roundIcon.cooldown:SetSwipeTexture(swipeMaskPath)
                end
                if roundIcon.cooldown.SetSwipeColor then
                    roundIcon.cooldown:SetSwipeColor(0, 0, 0, 0.8 * MASKED_SWIPE_ALPHA_MULTIPLIER)
                end
                if roundIcon.cooldown.SetFrameStrata then
                    roundIcon.cooldown:SetFrameStrata("MEDIUM")
                end
                roundIcon.cooldown:Hide()
            end

            roundIcon.chargeText = roundIcon:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
            roundIcon.chargeText:SetPoint("BOTTOMRIGHT", roundIcon, "BOTTOMRIGHT", -2, 2)
            roundIcon.chargeText:SetText("")
            roundIcon.chargeText:Hide()

            roundIcon.overlayText = roundIcon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            roundIcon.overlayText:SetPoint("BOTTOM", roundIcon, "TOP", 0, 10)
            roundIcon.overlayText:SetJustifyH("CENTER")
            roundIcon.overlayText:SetJustifyV("BOTTOM")
            roundIcon.overlayText:SetText("")
            roundIcon.overlayText:Hide()

            SetupRoundPreviewTextFonts(roundIcon, "Fonts\\FRIZQT__.TTF", 14)
            if isPrimary then
                roundIcon.keybindFontSizeScale = ROUND_PREVIEW_PRIMARY_KEYBIND_FONT_SCALE
            else
                roundIcon.keybindFontSizeScale = ROUND_PREVIEW_KEYBIND_FONT_SCALE
            end
            AddKeybindOverlayToFrame(roundIcon)
            self:AddTooltip(roundIcon)
            roundIcon:Hide()
            NAG.Frame.roundIconFrames[key] = roundIcon
        end

        roundIcon.groupKey = key

        local rx, ry, baseW, baseH, useTexCoord
        local gOffsetX, gOffsetY, gIconW, gIconH, gTexCoord, resolvedPos = self:GetGroupStyleRoundLayoutForLegacyPosition(key)
        if gIconW and gIconH then
            rx, ry = gOffsetX, gOffsetY
            useTexCoord = gTexCoord
            local baseScale = isPrimary and 1 or ROUND_PREVIEW_SECONDARY_ICON_SCALE
            local wScale, hScale = baseScale, baseScale
            if resolvedPos == ns.SPELL_POSITIONS.LEFT or resolvedPos == ns.SPELL_POSITIONS.RIGHT or strmatch(tostring(resolvedPos or ""), "^left") or strmatch(tostring(resolvedPos or ""), "^right") then
                wScale = baseScale * ROUND_PREVIEW_LEFT_RIGHT_WIDTH_SCALE
            elseif resolvedPos == ns.SPELL_POSITIONS.ABOVE or resolvedPos == ns.SPELL_POSITIONS.BELOW or strmatch(tostring(resolvedPos or ""), "^above") or strmatch(tostring(resolvedPos or ""), "^below") then
                hScale = baseScale * ROUND_PREVIEW_ABOVE_BELOW_HEIGHT_SCALE
            elseif resolvedPos == ns.SPELL_POSITIONS.AOE then
                hScale = baseScale * AOE_ICON_HEIGHT_SCALE
            end
            baseW, baseH = gIconW * wScale, gIconH * hScale
            -- AOE round icon: half-circle on right of primary = same size as primary, centered, mask shows right half
            if resolvedPos == ns.SPELL_POSITIONS.AOE then
                baseW, baseH = iconWidth, iconHeight
                rx, ry = 0, 0
                useTexCoord = AOE_ICON_TEXCOORD_SQUARE
            end
        else
            local baseScale = isPrimary and 1 or ROUND_PREVIEW_SECONDARY_ICON_SCALE
            local wScale, hScale = baseScale, baseScale
            if strmatch(tostring(key or ""), "^left") or strmatch(tostring(key or ""), "^right") then
                wScale = baseScale * ROUND_PREVIEW_LEFT_RIGHT_WIDTH_SCALE
            elseif strmatch(tostring(key or ""), "^above") or strmatch(tostring(key or ""), "^below") then
                hScale = baseScale * ROUND_PREVIEW_ABOVE_BELOW_HEIGHT_SCALE
            end

            baseW, baseH = iconWidth, iconHeight
            if key == ns.SPELL_POSITIONS.AOE then
                -- AOE round: half-circle on right of primary = same size as primary, centered (mask4AOE = right half-circle)
                baseW, baseH = iconWidth, iconHeight
                wScale, hScale = 1, 1
            elseif strmatch(tostring(key or ""), "^above") or strmatch(tostring(key or ""), "^below") then
                baseW, baseH = iconWidth, iconHeight * frameWeight
            elseif strmatch(tostring(key or ""), "^left") or strmatch(tostring(key or ""), "^right") then
                baseW, baseH = iconWidth * frameWeight, iconHeight
            end
            baseW, baseH = baseW * wScale, baseH * hScale

            local step = iconHeight * frameWeight + gap
            if isPrimary or key == ns.SPELL_POSITIONS.AOE then
                rx, ry = 0, 0
            else
                local num = tonumber(strmatch(tostring(key or ""), "%d+")) or 1
                local scaledStep = step * (ROUND_PREVIEW_SPACING_FACTOR + (num - 1) * ROUND_PREVIEW_ICON_SPACING_FACTOR)
                if strmatch(tostring(key or ""), "^above") then
                    rx, ry = 0, scaledStep
                elseif strmatch(tostring(key or ""), "^below") then
                    rx, ry = 0, -scaledStep
                elseif strmatch(tostring(key or ""), "^left") then
                    rx, ry = -scaledStep, 0
                elseif strmatch(tostring(key or ""), "^right") then
                    rx, ry = scaledStep, 0
                else
                    rx = offsetX * ROUND_PREVIEW_SPACING_FACTOR
                    ry = offsetY * ROUND_PREVIEW_SPACING_FACTOR
                end
            end
            useTexCoord = texCoord
        end

        roundIcon:SetSize(baseW, baseH)
        roundIcon:ClearAllPoints()
        roundIcon:SetPoint("CENTER", primaryFrame, "CENTER", rx, ry)
        local baseLevel = self.db.char.frameLevel or 50
        roundIcon:SetFrameLevel(isPrimary and (baseLevel + 1) or (baseLevel + 2))

        local l, r, t, b
        if useTexCoord then
            l, r, t, b = unpack(useTexCoord)
        else
            l, r, t, b = 0.15, 0.85, 0.15, 0.85
        end
        if isPrimary then
            roundIcon.texture:SetTexCoord(l, r, t, b)
        else
            roundIcon.texture:SetTexCoord(ExpandTexCoordForZoomOut(l, r, t, b, ROUND_PREVIEW_SECONDARY_ICON_IMAGE_ZOOM))
        end
        roundIcon.texture:ClearAllPoints()
        roundIcon.texture:SetAllPoints()

        local maskPath = self:GetRoundPreviewMaskTextureForPosition(key)
        local bgW, bgH = baseW * MASK_BORDER_SCALE, baseH * MASK_BORDER_SCALE
        if roundIcon.bg then
            roundIcon.bg:ClearAllPoints()
            roundIcon.bg:SetPoint("CENTER", roundIcon, "CENTER", 0, 0)
            roundIcon.bg:SetSize(bgW, bgH)
        end
        if roundIcon.bgMask then
            roundIcon.bgMask:SetTexture(maskPath, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            roundIcon.bgMask:SetAllPoints(roundIcon.bg)
        end
        if roundIcon.mask then
            roundIcon.mask:SetTexture(maskPath, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            roundIcon.mask:SetAllPoints(roundIcon.texture)
        end
        return roundIcon
    end

    --- Mirrors legacy icon state to its parallel round icon (texture, alpha, cooldown, charges, overlay, keybind).
    --- @param sourceFrame Frame Legacy icon frame (uses frame.icon)
    --- @param roundIcon Frame Round preview icon (uses roundIcon.texture)
    function DisplayManager:MirrorLegacyIconToRoundIcon(sourceFrame, roundIcon)
        if not sourceFrame or not roundIcon then return end

        roundIcon.spellId = sourceFrame.spellId
        roundIcon.itemId = sourceFrame.itemId
        roundIcon._hasDisplayData = not not (sourceFrame.spellId or sourceFrame.itemId or sourceFrame.id)

        local srcTex = sourceFrame.icon and sourceFrame.icon:GetTexture()
        if roundIcon._lastTexture ~= srcTex then
            roundIcon.texture:SetTexture(srcTex)
            roundIcon._lastTexture = srcTex
        end

        local iconAlpha = sourceFrame:GetAlpha()
        if roundIcon._lastAlpha ~= iconAlpha then
            roundIcon:SetAlpha(iconAlpha)
            roundIcon._lastAlpha = iconAlpha
        end

        -- When custom hold or retwist hold swipe is active, show it on round icon with circular mask
        -- (matching GCD swipe visuals) and suppress the GCD swipe to avoid overlap.
        local customHoldActive = sourceFrame._customHoldSwipeActive and sourceFrame.customHoldCooldown and sourceFrame.customHoldCooldown:IsShown()
        local retwistHoldActive = sourceFrame._retTwistHoldSweepActive and sourceFrame.retwistHoldCooldown and sourceFrame.retwistHoldCooldown:IsShown()
        local anyHoldActive = customHoldActive or retwistHoldActive

        if anyHoldActive then
            -- Hide source frame's hold cooldowns so we don't see square swipes over round icon.
            if sourceFrame.customHoldCooldown then
                sourceFrame.customHoldCooldown:Hide()
            end
            if sourceFrame.retwistHoldCooldown then
                sourceFrame.retwistHoldCooldown:Hide()
            end
            -- Suppress GCD on round icon.
            if roundIcon.cooldown then
                roundIcon.cooldown:Hide()
                roundIcon._lastCooldownStart = nil
                roundIcon._lastCooldownDuration = nil
            end
        end

        if customHoldActive and sourceFrame._customHoldCooldownStart and sourceFrame._customHoldCooldownDuration then
            local maskPath = self:GetRoundPreviewMaskTextureForPosition(roundIcon.groupKey) or CIRCLE_MASK_TEXTURE
            if not roundIcon.customHoldCooldown then
                roundIcon.customHoldCooldown = CreateFrame("Cooldown", nil, roundIcon, "CooldownFrameTemplate")
                roundIcon.customHoldCooldown:SetAllPoints()
                roundIcon.customHoldCooldown:SetDrawBling(false)
                roundIcon.customHoldCooldown:SetDrawEdge(false)
                if roundIcon.customHoldCooldown.SetHideCountdownNumbers then
                    roundIcon.customHoldCooldown:SetHideCountdownNumbers(true)
                end
                if roundIcon.customHoldCooldown.SetFrameStrata then
                    roundIcon.customHoldCooldown:SetFrameStrata("MEDIUM")
                end
            end
            if roundIcon.customHoldCooldown.SetSwipeTexture then
                roundIcon.customHoldCooldown:SetSwipeTexture(maskPath)
            end
            local alpha = (sourceFrame._customHoldSwipeAlpha or 0.8) * MASKED_SWIPE_ALPHA_MULTIPLIER
            if roundIcon.customHoldCooldown.SetSwipeColor then
                roundIcon.customHoldCooldown:SetSwipeColor(0, 0, 0, alpha)
            end
            if roundIcon.customHoldCooldown.SetDrawSwipe then
                roundIcon.customHoldCooldown:SetDrawSwipe(true)
            end
            if roundIcon.customHoldCooldown.SetReverse then
                roundIcon.customHoldCooldown:SetReverse(sourceFrame._customHoldSwipeReverse == true)
            end
            roundIcon.customHoldCooldown:SetCooldown(sourceFrame._customHoldCooldownStart, sourceFrame._customHoldCooldownDuration)
            roundIcon.customHoldCooldown:Show()
        elseif roundIcon.customHoldCooldown then
            roundIcon.customHoldCooldown:Hide()
        end

        if retwistHoldActive and sourceFrame._retTwistHoldCooldownStart and sourceFrame._retTwistHoldCooldownDuration then
            local maskPath = self:GetRoundPreviewMaskTextureForPosition(roundIcon.groupKey) or CIRCLE_MASK_TEXTURE
            if not roundIcon.retwistHoldCooldown then
                roundIcon.retwistHoldCooldown = CreateFrame("Cooldown", nil, roundIcon, "CooldownFrameTemplate")
                roundIcon.retwistHoldCooldown:SetAllPoints()
                roundIcon.retwistHoldCooldown:SetDrawBling(false)
                roundIcon.retwistHoldCooldown:SetDrawEdge(false)
                if roundIcon.retwistHoldCooldown.SetHideCountdownNumbers then
                    roundIcon.retwistHoldCooldown:SetHideCountdownNumbers(true)
                end
                if roundIcon.retwistHoldCooldown.SetFrameStrata then
                    roundIcon.retwistHoldCooldown:SetFrameStrata("MEDIUM")
                end
            end
            if roundIcon.retwistHoldCooldown.SetSwipeTexture then
                roundIcon.retwistHoldCooldown:SetSwipeTexture(maskPath)
            end
            if roundIcon.retwistHoldCooldown.SetSwipeColor then
                roundIcon.retwistHoldCooldown:SetSwipeColor(0, 0, 0, 0.5)
            end
            if roundIcon.retwistHoldCooldown.SetDrawSwipe then
                roundIcon.retwistHoldCooldown:SetDrawSwipe(true)
            end
            if roundIcon.retwistHoldCooldown.SetReverse then
                roundIcon.retwistHoldCooldown:SetReverse(sourceFrame._retTwistHoldCooldownReverse == true)
            end
            roundIcon.retwistHoldCooldown:SetCooldown(sourceFrame._retTwistHoldCooldownStart, sourceFrame._retTwistHoldCooldownDuration)
            roundIcon.retwistHoldCooldown:Show()
        elseif roundIcon.retwistHoldCooldown then
            roundIcon.retwistHoldCooldown:Hide()
        end

        if not anyHoldActive and roundIcon.cooldown then
            local cdStart = sourceFrame._lastCooldownStart
            local cdDur = sourceFrame._lastCooldownDuration
            if cdStart and cdDur and cdDur > 0 then
                if roundIcon._lastCooldownStart ~= cdStart or roundIcon._lastCooldownDuration ~= cdDur then
                    roundIcon.cooldown:SetCooldown(cdStart, cdDur)
                    roundIcon._lastCooldownStart = cdStart
                    roundIcon._lastCooldownDuration = cdDur
                end
                roundIcon.cooldown:Show()
            else
                roundIcon.cooldown:Hide()
                roundIcon._lastCooldownStart = nil
                roundIcon._lastCooldownDuration = nil
            end
        end

        if roundIcon.chargeText then
            local chargeStr = ""
            if sourceFrame.chargeText then
                chargeStr = sourceFrame.chargeText:GetText() or ""
            elseif sourceFrame.spellId then
                local chargeInfo = WoWAPI.GetSpellCharges(sourceFrame.spellId)
                if chargeInfo and chargeInfo.maxCharges and chargeInfo.maxCharges > 1 then
                    chargeStr = tostring(chargeInfo.currentCharges or 0)
                end
            end
            if roundIcon._lastChargeText ~= chargeStr then
                roundIcon.chargeText:SetText(chargeStr)
                roundIcon._lastChargeText = chargeStr
            end
            if chargeStr and chargeStr ~= "" then
                roundIcon.chargeText:Show()
            else
                roundIcon.chargeText:Hide()
            end
        end

        if roundIcon.overlayText then
            local overlayStr = sourceFrame.lastOverlayText or ""
            if roundIcon._lastOverlayText ~= overlayStr then
                roundIcon.overlayText:SetText(overlayStr)
                roundIcon._lastOverlayText = overlayStr
            end
            if overlayStr and overlayStr ~= "" then
                roundIcon.overlayText:Show()
            else
                roundIcon.overlayText:Hide()
            end
        end

        if roundIcon.keybindText then
            if roundIcon.UpdateKeybindText then
                roundIcon:UpdateKeybindText()
            elseif sourceFrame.keybindText then
                local kb = sourceFrame.keybindText:GetText() or ""
                if roundIcon._lastKeybindText ~= kb then
                    roundIcon.keybindText:SetText(kb)
                    roundIcon._lastKeybindText = kb
                end
                if sourceFrame.keybindText:IsShown() then
                    roundIcon.keybindText:Show()
                else
                    roundIcon.keybindText:Hide()
                end
            end
        end
    end

    --- @param sourceIcon Frame
    --- @param roundIcon Frame
    --- @param groupKey string|nil For group display, the group key (used for mask texture)
    --- @param previewEnabled boolean|nil When true, round icon is shown; hide source's hold cooldowns.
    function DisplayManager:MirrorRoundPreviewIconState(sourceIcon, roundIcon, groupKey, previewEnabled)
        if not sourceIcon or not roundIcon then return end

        roundIcon.spellId = sourceIcon.spellId
        roundIcon.itemId = sourceIcon.itemId
        roundIcon._hasDisplayData = sourceIcon._hasDisplayData == true

        local sourceTexture = sourceIcon._lastTexture
        if sourceTexture and roundIcon._lastTexture ~= sourceTexture then
            roundIcon.texture:SetTexture(sourceTexture)
            roundIcon._lastTexture = sourceTexture
        elseif not sourceTexture then
            roundIcon.texture:SetTexture(nil)
            roundIcon._lastTexture = nil
        end

        local iconAlpha = sourceIcon._lastAlpha or 1.0
        if roundIcon._lastAlpha ~= iconAlpha then
            roundIcon:SetAlpha(iconAlpha)
            roundIcon._lastAlpha = iconAlpha
        end

        -- When custom hold or retwist hold swipe is active and round mask is on, show it on round icon
        -- with circular mask and suppress the GCD swipe to avoid overlap.
        local customHoldActive = sourceIcon._customHoldSwipeActive and sourceIcon.customHoldCooldown and sourceIcon.customHoldCooldown:IsShown()
        local retwistHoldActive = sourceIcon._retTwistHoldSweepActive and sourceIcon.retwistHoldCooldown and sourceIcon.retwistHoldCooldown:IsShown()
        local anyHoldActive = (customHoldActive or retwistHoldActive) and previewEnabled

        if anyHoldActive then
            -- Hide source's hold cooldowns so we don't see square swipes; round icon will show them.
            if sourceIcon.customHoldCooldown then
                sourceIcon.customHoldCooldown:Hide()
            end
            if sourceIcon.retwistHoldCooldown then
                sourceIcon.retwistHoldCooldown:Hide()
            end
            if roundIcon.cooldown then
                roundIcon.cooldown:Hide()
                roundIcon._cooldownVisible = false
                roundIcon._lastCooldownStart = nil
                roundIcon._lastCooldownDuration = nil
            end
        end

        if customHoldActive and sourceIcon._customHoldCooldownStart and sourceIcon._customHoldCooldownDuration then
            local maskPath = (groupKey and self:GetRoundPreviewMaskTextureForGroup(groupKey)) or self:GetRoundPreviewMaskTextureForPosition(ns.SPELL_POSITIONS.PRIMARY) or CIRCLE_MASK_TEXTURE
            if not roundIcon.customHoldCooldown then
                roundIcon.customHoldCooldown = CreateFrame("Cooldown", nil, roundIcon, "CooldownFrameTemplate")
                roundIcon.customHoldCooldown:SetAllPoints()
                roundIcon.customHoldCooldown:SetDrawBling(false)
                roundIcon.customHoldCooldown:SetDrawEdge(false)
                if roundIcon.customHoldCooldown.SetHideCountdownNumbers then
                    roundIcon.customHoldCooldown:SetHideCountdownNumbers(true)
                end
                if roundIcon.customHoldCooldown.SetFrameStrata then
                    roundIcon.customHoldCooldown:SetFrameStrata("MEDIUM")
                end
            end
            if roundIcon.customHoldCooldown.SetSwipeTexture then
                roundIcon.customHoldCooldown:SetSwipeTexture(maskPath)
            end
            local alpha = (sourceIcon._customHoldSwipeAlpha or 0.8) * MASKED_SWIPE_ALPHA_MULTIPLIER
            if roundIcon.customHoldCooldown.SetSwipeColor then
                roundIcon.customHoldCooldown:SetSwipeColor(0, 0, 0, alpha)
            end
            if roundIcon.customHoldCooldown.SetDrawSwipe then
                roundIcon.customHoldCooldown:SetDrawSwipe(true)
            end
            if roundIcon.customHoldCooldown.SetReverse then
                roundIcon.customHoldCooldown:SetReverse(sourceIcon._customHoldSwipeReverse == true)
            end
            roundIcon.customHoldCooldown:SetCooldown(sourceIcon._customHoldCooldownStart, sourceIcon._customHoldCooldownDuration)
            roundIcon.customHoldCooldown:Show()
        elseif roundIcon.customHoldCooldown then
            roundIcon.customHoldCooldown:Hide()
        end

        if retwistHoldActive and sourceIcon._retTwistHoldCooldownStart and sourceIcon._retTwistHoldCooldownDuration then
            local maskPath = (groupKey and self:GetRoundPreviewMaskTextureForGroup(groupKey)) or self:GetRoundPreviewMaskTextureForPosition(ns.SPELL_POSITIONS.PRIMARY) or CIRCLE_MASK_TEXTURE
            if not roundIcon.retwistHoldCooldown then
                roundIcon.retwistHoldCooldown = CreateFrame("Cooldown", nil, roundIcon, "CooldownFrameTemplate")
                roundIcon.retwistHoldCooldown:SetAllPoints()
                roundIcon.retwistHoldCooldown:SetDrawBling(false)
                roundIcon.retwistHoldCooldown:SetDrawEdge(false)
                if roundIcon.retwistHoldCooldown.SetHideCountdownNumbers then
                    roundIcon.retwistHoldCooldown:SetHideCountdownNumbers(true)
                end
                if roundIcon.retwistHoldCooldown.SetFrameStrata then
                    roundIcon.retwistHoldCooldown:SetFrameStrata("MEDIUM")
                end
            end
            if roundIcon.retwistHoldCooldown.SetSwipeTexture then
                roundIcon.retwistHoldCooldown:SetSwipeTexture(maskPath)
            end
            if roundIcon.retwistHoldCooldown.SetSwipeColor then
                roundIcon.retwistHoldCooldown:SetSwipeColor(0, 0, 0, 0.5)
            end
            if roundIcon.retwistHoldCooldown.SetDrawSwipe then
                roundIcon.retwistHoldCooldown:SetDrawSwipe(true)
            end
            if roundIcon.retwistHoldCooldown.SetReverse then
                roundIcon.retwistHoldCooldown:SetReverse(sourceIcon._retTwistHoldCooldownReverse == true)
            end
            roundIcon.retwistHoldCooldown:SetCooldown(sourceIcon._retTwistHoldCooldownStart, sourceIcon._retTwistHoldCooldownDuration)
            roundIcon.retwistHoldCooldown:Show()
        elseif roundIcon.retwistHoldCooldown then
            roundIcon.retwistHoldCooldown:Hide()
        end

        if not anyHoldActive and roundIcon.cooldown then
            if sourceIcon._cooldownVisible and sourceIcon._lastCooldownStart and sourceIcon._lastCooldownDuration then
                if roundIcon._lastCooldownStart ~= sourceIcon._lastCooldownStart or roundIcon._lastCooldownDuration ~= sourceIcon._lastCooldownDuration then
                    roundIcon.cooldown:SetCooldown(sourceIcon._lastCooldownStart, sourceIcon._lastCooldownDuration)
                    roundIcon._lastCooldownStart = sourceIcon._lastCooldownStart
                    roundIcon._lastCooldownDuration = sourceIcon._lastCooldownDuration
                end
                roundIcon.cooldown:Show()
                roundIcon._cooldownVisible = true
            else
                roundIcon.cooldown:Hide()
                roundIcon._cooldownVisible = false
                roundIcon._lastCooldownStart = nil
                roundIcon._lastCooldownDuration = nil
            end
        end

        if roundIcon.chargeText then
            local chargeText = sourceIcon._lastChargeText or ""
            if roundIcon._lastChargeText ~= chargeText then
                roundIcon.chargeText:SetText(chargeText)
                roundIcon._lastChargeText = chargeText
            end
            if sourceIcon._chargeVisible then
                roundIcon.chargeText:Show()
                roundIcon._chargeVisible = true
            else
                roundIcon.chargeText:Hide()
                roundIcon._chargeVisible = false
            end
        end

        if roundIcon.overlayText then
            local overlayText = sourceIcon._lastOverlayText or ""
            if roundIcon._lastOverlayText ~= overlayText then
                roundIcon.overlayText:SetText(overlayText)
                roundIcon._lastOverlayText = overlayText
            end
            if sourceIcon._overlayTextVisible then
                roundIcon.overlayText:Show()
                roundIcon._overlayTextVisible = true
            else
                roundIcon.overlayText:Hide()
                roundIcon._overlayTextVisible = false
            end
        end

        if roundIcon.keybindText and sourceIcon.keybindText then
            local keybindText = sourceIcon.keybindText:GetText() or ""
            if roundIcon._lastKeybindText ~= keybindText then
                roundIcon.keybindText:SetText(keybindText)
                roundIcon._lastKeybindText = keybindText
            end
            if sourceIcon.keybindText:IsShown() then
                roundIcon.keybindText:Show()
            else
                roundIcon.keybindText:Hide()
            end
        end
    end

    --- @param groupKey string
    function DisplayManager:ApplyRoundMaskPreviewVisibility(groupKey)
        local frame = self.groupFrames and self.groupFrames[groupKey]
        if not frame or not frame.iconFrames or not frame.roundIconFrames then return end
        local previewEnabled = self:IsRoundMaskPreviewEnabled(groupKey)
        for i, icon in ipairs(frame.iconFrames) do
            local roundIcon = frame.roundIconFrames[i]
            if roundIcon then
                ApplyRoundPreviewSlotVisibility(icon, roundIcon, previewEnabled)
            end
        end
    end

    function DisplayManager:ApplyRoundMaskPreviewVisibilityAll()
        for groupKey, _ in pairs(FRAME_GROUPS) do
            self:ApplyRoundMaskPreviewVisibility(groupKey)
        end
        self:UpdateGroupFramePositionsForRoundPreview()
    end

    --- Updates secondary group frame positions: 35% closer to center when round mask preview on.
    function DisplayManager:UpdateGroupFramePositionsForRoundPreview()
        if not NAG.GroupDisplayFrame or not self.groupFrames then return end
        local previewOn = self.db.char.showRoundMaskPreview == true
        for groupKey, frame in pairs(self.groupFrames) do
            if frame and frame.ClearAllPoints and frame.SetPoint then
                local settings = self.db.char.groupSettings and self.db.char.groupSettings[groupKey]
                if settings then
                    local factor = (previewOn and groupKey ~= ns.FRAME_GROUPS.MAIN) and ROUND_PREVIEW_SPACING_FACTOR or 1
                    frame:ClearAllPoints()
                    frame:SetPoint(settings.point, NAG.GroupDisplayFrame, settings.relativePoint,
                        (settings.offsetX or 0) * factor, (settings.offsetY or 0) * factor)
                end
            end
        end
    end

    -- Function to create icon slots for a group frame
    function DisplayManager:CreateGroupIcons(groupKey)
        local group = FRAME_GROUPS[groupKey]
        if not group then return end
        local frame = self.groupFrames[groupKey]
        if not frame then return end

        local settings = self.db.char.groupSettings[groupKey]
        frame.iconFrames = frame.iconFrames or {}
        -- Find selected direction
        local flowKey = settings.iconFlowDirection:upper()
        local dirIdx = 1
        for i, dir in ipairs(COMPASS_DIRECTIONS) do
            if dir.key == flowKey then
                dirIdx = i
                break
            end
        end
        local dir = COMPASS_DIRECTIONS[dirIdx]
        local xMul, yMul = dir.x, dir.y
        -- Calculate overlap/spacing: -1.0 = fully stacked, 0 = default, 1.0 = far apart
        local overlap = settings.iconOverlap
        local spacingFactor = 1 - overlap -- -1: 2x overlap, 0: normal, 1: double spacing
        -- Adjust spacing for borders (like legacy)
        local borderSpacing = 0
        if self.db.char.enableBorders and self.db.char.borderThickness then
            borderSpacing = 2 * self.db.char.borderThickness
        end
        -- Remove any extra icons if settings.numIcons decreased
        for i = #frame.iconFrames, settings.numIcons + 1, -1 do
            if frame.iconFrames[i] then
                frame.iconFrames[i]:Hide()
                frame.iconFrames[i]:SetParent(nil)
                -- Cleanup handled internally
                frame.iconFrames[i] = nil
            end
            if frame.roundIconFrames and frame.roundIconFrames[i] then
                frame.roundIconFrames[i]:Hide()
                frame.roundIconFrames[i]:SetParent(nil)
                frame.roundIconFrames[i] = nil
            end
        end
        -- Create or update icon slots
        for i = 1, settings.numIcons do
            local cropStyle = settings.iconCropStyle
            -- Force main group to always use full crop style (no cropping)
            if groupKey == ns.FRAME_GROUPS.MAIN then
                cropStyle = "full"
            end
            local iconWidth, iconHeight, texCoord
            if cropStyle == "full" then
                iconWidth, iconHeight, texCoord = settings.iconWidth, settings.iconHeight, { 0.1, 0.9, 0.1, 0.9 }
            elseif cropStyle == "half" then
                -- Use direction to pick axis, but always crop one axis
                if math.abs(dir.x) > math.abs(dir.y) then
                    iconWidth, iconHeight, texCoord = settings.iconWidth * 0.5, settings.iconHeight,
                        { 0.25, 0.75, 0.1, 0.9 }
                else
                    iconWidth, iconHeight, texCoord = settings.iconWidth, settings.iconHeight * 0.5,
                        { 0.1, 0.9, 0.25, 0.75 }
                end
            elseif cropStyle == "quarter" then
                iconWidth, iconHeight, texCoord = settings.iconWidth * 0.5, settings.iconHeight * 0.5,
                    { 0.25, 0.75, 0.25, 0.75 }
            else -- auto
                iconWidth, iconHeight, texCoord = getIconShapeForDirection(dir, settings.iconWidth, settings.iconHeight)
            end
            if not frame.iconFrames[i] then
                local iconName = "NAG_" .. groupKey .. "Icon" .. i
                local icon = CreateFrame("Frame", iconName, frame)
                icon:SetSize(iconWidth, iconHeight)
                -- Assign groupKey for overlay management
                icon.groupKey = groupKey
                -- Use overlap/stacking for position, now with border spacing
                icon:SetPoint("CENTER", frame, "CENTER", (i - 1) *
                    ((iconWidth + 2 + borderSpacing) * xMul * spacingFactor),
                    (i - 1) * ((iconHeight + 2 + borderSpacing) * yMul * spacingFactor))
                icon.texture = icon:CreateTexture(nil, "BACKGROUND")
                icon.texture:SetAllPoints()
                -- Apply per-group zoom (legacy zoom logic is replaced by texCoord cropping)
                icon.texture:SetTexCoord(unpack(texCoord))
                icon:Hide()
                -- Add cooldown swipe overlay only to primary icons; secondary icons must not have it
                if self:AreCooldownSwipesEnabled() and groupKey == ns.FRAME_GROUPS.MAIN then
                    icon.cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
                    icon.cooldown:SetAllPoints()
                    icon.cooldown:Hide()
                end
                -- Add charges overlay to every icon
                icon.chargeText = icon:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
                icon.chargeText:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -2, 2)
                -- Fix font setting to avoid nil font error
                local currentFont = icon.chargeText:GetFont()
                if currentFont then
                    icon.chargeText:SetFont(currentFont, 14, "OUTLINE")
                else
                    icon.chargeText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
                end
                icon.chargeText:SetText("")
                icon.chargeText:Hide()

                -- Overlay text (CastWithOverlay / CastPlaceholderWithOverlay / ShowCustomOverlay) for group display icons.
                -- Position above the icon (BOTTOM of text to TOP of icon + 10) to match legacy ShowCustomOverlay/OverlayText.
                icon.overlayText = icon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                icon.overlayText:SetPoint("BOTTOM", icon, "TOP", 0, 10)
                icon.overlayText:SetJustifyH("CENTER")
                icon.overlayText:SetJustifyV("BOTTOM")
                local overlayFont = icon.overlayText:GetFont()
                if overlayFont then
                    icon.overlayText:SetFont(overlayFont, 12, "OUTLINE")
                else
                    icon.overlayText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
                end
                icon.overlayText:SetText("")
                icon.overlayText:Hide()

                frame.iconFrames[i] = icon
                self:AddTooltip(icon)
                self:AddBorder(icon)
                AddKeybindOverlayToFrame(icon)
            else
                frame.iconFrames[i]:SetSize(iconWidth, iconHeight)
                frame.iconFrames[i]:SetPoint("CENTER", frame, "CENTER",
                    (i - 1) * ((iconWidth + 2 + borderSpacing) * xMul * spacingFactor),
                    (i - 1) * ((iconHeight + 2 + borderSpacing) * yMul * spacingFactor))
                -- Ensure groupKey is set on reused icons
                frame.iconFrames[i].groupKey = groupKey
                -- Remove cooldown from secondary icons (they must not have swipe overlay)
                if groupKey ~= ns.FRAME_GROUPS.MAIN and frame.iconFrames[i].cooldown then
                    frame.iconFrames[i].cooldown:Hide()
                    frame.iconFrames[i].cooldown:SetParent(nil)
                    frame.iconFrames[i].cooldown = nil
                    frame.iconFrames[i]._cooldownVisible = false
                    frame.iconFrames[i]._lastCooldownStart = nil
                    frame.iconFrames[i]._lastCooldownDuration = nil
                end
                -- Update texCoord on existing icons
                frame.iconFrames[i].texture:SetTexCoord(unpack(texCoord))
                -- Refresh borders for existing icons (respects rotation readiness)
                if frame.iconFrames[i].UpdateBorder then
                    frame.iconFrames[i]:UpdateBorder()
                end
                -- ARCHITECTURAL FIX: Keybind already added during icon creation (line 746)
                -- No need to re-add on settings changes, UpdateAllKeybinds handles updates
            end
            local slotOffsetX = (i - 1) * ((iconWidth + 2 + borderSpacing) * xMul * spacingFactor)
            local slotOffsetY = (i - 1) * ((iconHeight + 2 + borderSpacing) * yMul * spacingFactor)
            if self:IsRoundMaskPreviewEnabled() and groupKey ~= ns.FRAME_GROUPS.MAIN then
                slotOffsetX = slotOffsetX * ROUND_PREVIEW_ICON_SPACING_FACTOR
                slotOffsetY = slotOffsetY * ROUND_PREVIEW_ICON_SPACING_FACTOR
            end
            self:EnsureRoundPreviewIcon(frame, groupKey, i, iconWidth, iconHeight, slotOffsetX, slotOffsetY, texCoord)
        end
        self:TrimRoundPreviewIcons(frame)
        self:ApplyRoundMaskPreviewVisibility(groupKey)

        -- Notify other modules that frame has been updated
        self:SendFrameUpdated("create_or_update_group_icons")
    end

    -- Function to update icons for a group
    function DisplayManager:UpdateGroupIcons(groupKey, iconData)
        -- iconData: array of { texture=..., spellId=..., itemId=... }
        local frame = self.groupFrames[groupKey]
        if not frame or not frame.iconFrames then return end
        local StateManager = NAG:GetModule("StateManager", true)
        local now = GetTime()
        for i, icon in ipairs(frame.iconFrames) do
            local data = iconData and iconData[i]
            if data and data.texture then
                -- Tinker cooldown fix: use item ID for cooldown so we use GetItemCooldown not GetSpellCooldown
                if data.spellId and not data.itemId and StateManager and StateManager.GetTinkerInfoBySpellId then
                    local ti = StateManager:GetTinkerInfoBySpellId(data.spellId)
                    if ti and type(ti) == "table" and ti.itemId then
                        data.itemId = ti.itemId
                        data.texture = GetItemIcon(ti.itemId) or data.texture
                    end
                end
                -- ARCHITECTURAL FIX: Track if spell changed to only update keybind when necessary
                local spellChanged = (icon.spellId ~= data.spellId or icon.itemId ~= data.itemId)

                if icon._lastTexture ~= data.texture then
                    icon.texture:SetTexture(data.texture)
                    icon._lastTexture = data.texture
                end
                local iconAlpha = data.alpha or 1.0
                if icon._lastAlpha ~= iconAlpha then
                    icon:SetAlpha(iconAlpha)
                    icon._lastAlpha = iconAlpha
                end
                if not icon:IsShown() then
                    icon:Show()
                end
                icon._hasDisplayData = true
                icon.spellId = data.spellId
                icon.itemId = data.itemId
                -- ARCHITECTURAL FIX: Border visibility managed by RefreshAllBorders (line 3591)
                -- UpdateBorder was recreating borders every tick (800 ops/sec) - removed
                -- Update cooldown overlay for each icon (only if enabled)
                if self:AreCooldownSwipesEnabled() and icon.cooldown then
                    local shouldRefreshCooldown = spellChanged
                        or not icon._lastCooldownRefreshAt
                        or (now - icon._lastCooldownRefreshAt) >= 0.05
                    if shouldRefreshCooldown then
                        local start, duration
                        if icon.itemId then
                            start, duration = GetItemCooldown(icon.itemId)
                        elseif icon.spellId then
                            local cdInfo = WoWAPI.GetSpellCooldown(icon.spellId)
                            start, duration = cdInfo and cdInfo.startTime, cdInfo and cdInfo.duration
                        end

                        if start and duration and duration > 0 then
                            if icon._lastCooldownStart ~= start or icon._lastCooldownDuration ~= duration then
                                icon.cooldown:SetCooldown(start, duration)
                                icon._lastCooldownStart = start
                                icon._lastCooldownDuration = duration
                            end
                            if not icon._cooldownVisible then
                                icon.cooldown:Show()
                                icon._cooldownVisible = true
                            end
                        else
                            if icon._cooldownVisible then
                                icon.cooldown:Hide()
                                icon._cooldownVisible = false
                            end
                            icon._lastCooldownStart = nil
                            icon._lastCooldownDuration = nil
                        end
                        icon._lastCooldownRefreshAt = now
                    end
                elseif icon.cooldown and icon._cooldownVisible then
                    icon.cooldown:Hide()
                    icon._cooldownVisible = false
                end
                -- Update charges overlay for each icon
                if icon.spellId then
                    local shouldRefreshCharges = spellChanged
                        or not icon._lastChargeRefreshAt
                        or (now - icon._lastChargeRefreshAt) >= 0.1
                    if shouldRefreshCharges then
                        local chargeInfo = WoWAPI.GetSpellCharges(icon.spellId)
                        if chargeInfo and chargeInfo.maxCharges and chargeInfo.maxCharges > 1 then
                            local chargeText = tostring(chargeInfo.currentCharges or 0)
                            if icon._lastChargeText ~= chargeText then
                                icon.chargeText:SetText(chargeText)
                                icon._lastChargeText = chargeText
                            end
                            if not icon._chargeVisible then
                                icon.chargeText:Show()
                                icon._chargeVisible = true
                            end
                        else
                            if icon._lastChargeText ~= "" then
                                icon.chargeText:SetText("")
                                icon._lastChargeText = ""
                            end
                            if icon._chargeVisible then
                                icon.chargeText:Hide()
                                icon._chargeVisible = false
                            end
                        end
                        icon._lastChargeRefreshAt = now
                    end
                else
                    if icon._lastChargeText ~= "" then
                        icon.chargeText:SetText("")
                        icon._lastChargeText = ""
                    end
                    if icon._chargeVisible then
                        icon.chargeText:Hide()
                        icon._chargeVisible = false
                    end
                end
                -- ARCHITECTURAL FIX: Only update keybind if spell changed
                -- Keybind text already created during CreateGroupIcons (line 746)
                -- Only update when spellId/itemId changes, not every tick
                if spellChanged and icon.UpdateKeybindText then
                    icon:UpdateKeybindText()
                end

                -- Ret twist HOLD swipe overlay (group display):
                -- If the APL set overlayText "HOLD" on the twist seal, show the countdown swipe directly on this icon frame.
                -- Also handle "Burst and\nTwist" on Avenging Wrath (31884) for burst variant.
                local overlayId = icon.spellId or icon.itemId
                local overlayText = overlayId and NAG.castOverlayTexts and NAG.castOverlayTexts[overlayId] or nil
                -- Fallback: CastSpell stores under resolved id; try resolve/display ids if primary lookup fails
                if (not overlayText or overlayText == "") and NAG.castOverlayTexts then
                    if data and data.overlayResolveId and NAG.castOverlayTexts[data.overlayResolveId] then
                        overlayText = NAG.castOverlayTexts[data.overlayResolveId]
                    elseif data and data.overlayDisplayId and NAG.castOverlayTexts[data.overlayDisplayId] then
                        overlayText = NAG.castOverlayTexts[data.overlayDisplayId]
                    elseif groupKey == ns.FRAME_GROUPS.MAIN and i == 1 and NAG.nextSpell then
                        -- Last resort: try nextSpell identity (handles fallback path, raw ids)
                        local nextId = type(NAG.nextSpell) == "number" and NAG.nextSpell
                            or (NAG.GetActionResolveId and NAG:GetActionResolveId(NAG.nextSpell))
                            or (NAG.GetActionDisplayId and NAG:GetActionDisplayId(NAG.nextSpell))
                        if nextId and NAG.castOverlayTexts[nextId] then
                            overlayText = NAG.castOverlayTexts[nextId]
                        end
                    end
                end
                -- Primary/main slot only: MAIN group first icon = legacy PRIMARY. Custom overlay (e.g. "Pet Not Attacking") here only.
                -- Other groups (AOE, COOLDOWNS, etc.) must not show it or the same text appears on every group's first icon.
                if groupKey == ns.FRAME_GROUPS.MAIN and i == 1 and (not overlayText or overlayText == "") and NAG._customOverlayText and NAG._customOverlayText ~= "" and NAG._customOverlayLastRefresh then
                    if (GetTime() - NAG._customOverlayLastRefresh) <= CUSTOM_OVERLAY_EXPIRE_SECONDS then
                        overlayText = NAG._customOverlayText
                    end
                end
                local soCSealId = (NAG.RetTwistGetSoCSealId and NAG:RetTwistGetSoCSealId()) or nil
                local isHoldSpell = ((icon.spellId == 31892) or (icon.spellId == 348700) or (icon.spellId == 20154) or (icon.spellId == 21084) or (icon.spellId == 20293))
                    or (soCSealId and icon.spellId == soCSealId)
                local isHold = (string.sub(overlayText or "", 1, 4) == "HOLD") and isHoldSpell
                local isBurstHold = overlayText == "Burst and\nTwist" and (icon.spellId == 31884)
                if isHold or isBurstHold then
                    self:UpdateRetTwistHoldSweep(icon.spellId, nil, overlayText, icon)
                else
                    -- Ensure it hides when not in HOLD/BURST state (prevents lingering sweep on reused frames)
                    if icon.retwistHoldCooldown then
                        icon.retwistHoldCooldown:Hide()
                    end
                    icon._retTwistHoldSweepActive = false
                    icon._retTwistHoldSweepSpellId = nil
                    icon._retTwistHoldCueTriggered = false
                    icon._retTwistHoldCueGlowUntil = nil
                    icon._retTwistHoldCueGlowActive = false
                    icon._retTwistHoldCueSpellId = nil
                    if LCG and LCG.AutoCastGlow_Stop then
                        LCG.AutoCastGlow_Stop(icon, "retTwistHoldCue")
                    end
                end

                -- Custom hold swipes, swing hold sweep, Hunter HOLD swipes (MAIN icon 1 = primary slot).
                if groupKey == ns.FRAME_GROUPS.MAIN and i == 1 and icon.spellId then
                    icon._nagPosition = ns.SPELL_POSITIONS.PRIMARY
                    self:UpdatePrimaryIconOverlays(icon)
                    self:UpdateSwingHoldSweep(icon.spellId, ns.SPELL_POSITIONS.PRIMARY, icon)
                    -- Hunter HOLD swipes (HOLD_SS on Steady 34120, HOLD_MS on Multi 27021)
                    if overlayText == "HOLD_SS" and icon.spellId == 34120 then
                        self:UpdateHunterSteadyHoldSweep(icon.spellId, ns.SPELL_POSITIONS.PRIMARY, overlayText, icon)
                    elseif overlayText == "HOLD_MS" and icon.spellId == 27021 then
                        self:UpdateHunterMultiHoldSweep(icon.spellId, ns.SPELL_POSITIONS.PRIMARY, overlayText, icon)
                    else
                        self:UpdateHunterSteadyHoldSweep(icon.spellId, ns.SPELL_POSITIONS.PRIMARY, "", icon)
                        self:UpdateHunterMultiHoldSweep(icon.spellId, ns.SPELL_POSITIONS.PRIMARY, "", icon)
                    end
                end

                -- Generic overlay text for group display (suppressed for Ret twist HOLD/BURST UX).
                -- First icon (main): show suggested heal target (P1, R5, Self) when set
                if icon.overlayText then
                    local text = overlayText or ""
                    if i == 1 and NAG.suggestedHealTargetLabel and NAG.suggestedHealTargetLabel ~= "" then
                        text = NAG.suggestedHealTargetLabel
                    end
                    if text ~= "" and not isHold and not isBurstHold then
                        if icon._lastOverlayText ~= text then
                            icon.overlayText:SetText(text)
                            icon._lastOverlayText = text
                        end
                        if not icon._overlayTextVisible then
                            icon.overlayText:Show()
                            icon._overlayTextVisible = true
                        end
                    else
                        if icon._lastOverlayText ~= "" then
                            icon.overlayText:SetText("")
                            icon._lastOverlayText = ""
                        end
                        if icon._overlayTextVisible then
                            icon.overlayText:Hide()
                            icon._overlayTextVisible = false
                        end
                    end
                end
            else
                icon:Hide()
                icon._hasDisplayData = false
                icon.spellId = nil
                icon.itemId = nil
                if icon.cooldown and icon._cooldownVisible then
                    icon.cooldown:Hide()
                    icon._cooldownVisible = false
                end
                icon.chargeText:SetText("")
                icon._lastChargeText = ""
                icon.chargeText:Hide()
                icon._chargeVisible = false
                if icon.overlayText then
                    icon.overlayText:SetText("")
                    icon._lastOverlayText = ""
                    icon.overlayText:Hide()
                    icon._overlayTextVisible = false
                end
                if icon.retwistHoldCooldown then
                    icon.retwistHoldCooldown:Hide()
                end
                icon._lastTexture = nil
                icon._lastAlpha = nil
                icon._lastCooldownStart = nil
                icon._lastCooldownDuration = nil
                icon._lastCooldownRefreshAt = nil
                icon._lastChargeRefreshAt = nil
                icon._retTwistHoldSweepActive = false
                icon._retTwistHoldSweepSpellId = nil
                icon._retTwistHoldCueTriggered = false
                icon._retTwistHoldCueGlowUntil = nil
                icon._retTwistHoldCueGlowActive = false
                icon._retTwistHoldCueSpellId = nil
            end
            local roundIcon = frame.roundIconFrames and frame.roundIconFrames[i] or nil
            if roundIcon then
                local previewEnabled = self:IsRoundMaskPreviewEnabled(groupKey)
                self:MirrorRoundPreviewIconState(icon, roundIcon, groupKey, previewEnabled)
                ApplyRoundPreviewSlotVisibility(icon, roundIcon, previewEnabled)
            end
        end
    end

    -- ============================ PREDICTION QUEUE INTEGRATION FOR GROUPDISPLAY ============================
    --- Update main group icons with current action + prediction queue
    --- @param currentSpell table|number The current recommended action identity or ID
    --- @param predictions table|nil Array of predictions from RotationManager
    function DisplayManager:UpdateMainGroupWithPredictions(currentSpell, predictions)
        local groupKey = ns.FRAME_GROUPS.MAIN
        local frame = self.groupFrames[groupKey]
        if not frame or not frame.iconFrames then return end

        local settings = self.db.char.groupSettings[groupKey]
        local numIcons = settings.numIcons

        -- Build icon data array: [1] = current, [2+] = predictions
        local iconData = {}

        -- Frame 1: Current action
        local currentIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(currentSpell, {
            context = "display_main_group",
        }) or nil
        local currentResolveId = currentIdentity and NAG.GetActionResolveId and NAG:GetActionResolveId(currentIdentity) or nil
        local currentDisplayId = currentIdentity and NAG.GetActionDisplayId and NAG:GetActionDisplayId(currentIdentity) or nil
        if currentResolveId and currentResolveId > 0 then
            -- Tinker fix: StateManager first for gloves icon
            local StateManager = NAG:GetModule("StateManager", true)
            local tinkerProbeId = currentIdentity and (currentIdentity.spellId or currentResolveId) or currentResolveId
            local tinkerInfo = (StateManager and StateManager.GetTinkerInfoBySpellId) and StateManager:GetTinkerInfoBySpellId(tinkerProbeId) or nil

            local texture, itemId
            if tinkerInfo and tinkerInfo.icon then
                texture = tinkerInfo.icon
                itemId = tinkerInfo.itemId
            else
                local identity = DataManager.GetIdentity and DataManager:GetIdentity(currentResolveId, "display_main_icon", {
                    preferItemFirst = currentIdentity and currentIdentity.itemId ~= nil,
                }) or nil
                local entity = identity and identity.entity or nil
                if entity and entity.icon then
                    texture = entity.icon
                    if entity.flags and entity.flags.tinker and entity.itemId then
                        texture = GetItemIcon(entity.itemId) or entity.icon
                        itemId = entity.itemId
                    end
                else
                    texture = GetSpellTexture(currentResolveId) or GetItemIcon(currentDisplayId or currentResolveId)
                end
            end

            if texture then
                iconData[1] = {
                    texture = texture,
                    spellId = currentIdentity and currentIdentity.spellId or currentResolveId,
                    itemId = itemId or (currentIdentity and currentIdentity.itemId or nil),
                    -- Overlay lookup fallback: CastSpell may store under resolve/display id
                    overlayResolveId = currentResolveId,
                    overlayDisplayId = currentDisplayId,
                }
            end
        end

        -- Frames 2+: Future GCD predictions
        if predictions then
            for i = 1, math.min(#predictions, numIcons - 1) do
                local prediction = predictions[i]
                if prediction and prediction.spell then
                    local predAlpha = 1.0
                    if prediction.source == "static" then
                        predAlpha = 0.6
                    elseif prediction.confidence and prediction.confidence < 0.5 then
                        predAlpha = 0.8
                    end
                    iconData[#iconData + 1] = {
                        texture = prediction.spell.icon,
                        spellId = prediction.spell.id,
                        alpha = predAlpha,
                    }
                end
            end
        end

        -- Update the group icons
        self:UpdateGroupIcons(groupKey, iconData)
    end
end

do -- ~~~~~~~~~~~~~~ Tooltip Logic ~~~~~~~~~~~~~~
    function DisplayManager:AddTooltip(frame)
        if not frame then return end
        if frame:GetObjectType() == "SpellButton" then
            self:Error("Attempted to modify protected SpellButton")
            return
        end
        -- Always attach the handlers
        frame:SetScript("OnEnter", function(frameSelf)
            if not module.db.global.enableTooltips then return end
            local key = DisplayManager:GetMouseInteractionKey()
            if key ~= "DISABLE" and
                ((key == "ALT" and not IsAltKeyDown()) or
                    (key == "SHIFT" and not IsShiftKeyDown()) or
                    (key == "CONTROL" and not IsControlKeyDown())) then
                return
            end
            -- Anchor at cursor so tooltip follows mouse
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR", 10, 10)
            if frameSelf.itemId then
                GameTooltip:SetItemByID(frameSelf.itemId)
            elseif frameSelf.spellId then
                GameTooltip:SetSpellByID(frameSelf.spellId)
            end
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        -- UpdateTooltipState only toggles mouse interaction
        function frame:UpdateTooltipState()
            -- Add error tracking to catch any errors
            local success, result = pcall(function()
                frame:EnableMouse(module.db.global.enableTooltips)
            end)

            if not success then
                self:Error("UpdateTooltipState failed: %s\n%s", tostring(result), debugstack(2, 10, 0))
            end
        end

        return frame
    end

    -- Refresh all tooltips dynamically when setting changes
    function DisplayManager:RefreshAllTooltips()
        -- Legacy icon frames
        if NAG.Frame and NAG.Frame.iconFrames then
            for _, frame in pairs(NAG.Frame.iconFrames) do
                if frame.UpdateTooltipState then
                    frame:UpdateTooltipState()
                end
            end
        end
        -- Legacy round icons (visible when masks enabled)
        if NAG.Frame and NAG.Frame.roundIconFrames then
            for _, roundIcon in pairs(NAG.Frame.roundIconFrames) do
                if roundIcon and roundIcon.UpdateTooltipState then
                    roundIcon:UpdateTooltipState()
                end
            end
        end
        -- Group display icon frames
        if self.groupFrames then
            for _, groupFrame in pairs(self.groupFrames) do
                if groupFrame.iconFrames then
                    for _, icon in ipairs(groupFrame.iconFrames) do
                        if icon.UpdateTooltipState then
                            icon:UpdateTooltipState()
                        end
                    end
                end
                -- Group display round icons (visible when masks enabled)
                if groupFrame.roundIconFrames then
                    for _, roundIcon in pairs(groupFrame.roundIconFrames) do
                        if roundIcon and roundIcon.UpdateTooltipState then
                            roundIcon:UpdateTooltipState()
                        end
                    end
                end
            end
        end
        -- Re-apply modifier-based mouse state (Alt-hover, etc.)
        self:UpdateIconMouseStateForModifier()
        self:UpdateLegacyIconMouseStateForModifier()
    end
end
---------------------------------------------------------------------
-- Border Logic
---------------------------------------------------------------------
do -- ~~~~~~~~~~~~~~ Border Logic ~~~~~~~~~~~~~~
    function DisplayManager:AddBorder(frame)
        self.framedBorders[frame] = true
        local borderThickness = self.db.char.borderThickness
        local borderColor = self.db.char.borderColor
        local borderInset = self.db.char.borderInset
        local enableBorders = self.db.char.enableBorders
        -- Support both array { 0, 0, 0, 1 } and named { r=, g=, b=, a= } (OptionsFactory CreateColor)
        local br = (borderColor and (borderColor[1] or borderColor.r)) or 0
        local bg = (borderColor and (borderColor[2] or borderColor.g)) or 0
        local bb = (borderColor and (borderColor[3] or borderColor.b)) or 0
        local ba = (borderColor and (borderColor[4] or borderColor.a)) or 1

        if frame.borders then
            for _, border in ipairs(frame.borders) do
                border:Hide()
                border:SetParent(nil)
            end
            frame.borders = {}
        else
            frame.borders = {}
        end

        -- Create single border - ALWAYS create hidden, show only when explicitly allowed
        for i = 1, 4 do
            local border = frame:CreateLine(nil, "OVERLAY", nil, 0)
            if border then
                border:SetThickness(borderThickness)
                border:SetColorTexture(br, bg, bb, ba)
                if i == 1 then
                    border:SetStartPoint("TOPLEFT", -borderThickness + borderInset, borderThickness - borderInset)
                    border:SetEndPoint("TOPRIGHT", borderThickness - borderInset, borderThickness - borderInset)
                elseif i == 2 then
                    border:SetStartPoint("TOPRIGHT", borderThickness - borderInset, borderThickness - borderInset)
                    border:SetEndPoint("BOTTOMRIGHT", borderThickness - borderInset, -borderThickness + borderInset)
                elseif i == 3 then
                    border:SetStartPoint("BOTTOMRIGHT", borderThickness - borderInset, -borderThickness + borderInset)
                    border:SetEndPoint("BOTTOMLEFT", -borderThickness + borderInset, -borderThickness + borderInset)
                else
                    border:SetStartPoint("BOTTOMLEFT", -borderThickness + borderInset, -borderThickness + borderInset)
                    border:SetEndPoint("TOPLEFT", -borderThickness + borderInset, borderThickness - borderInset)
                end
                -- Always create borders hidden - they will be shown explicitly via ShouldShowBorders() check
                border:Hide()
                tinsert(frame.borders, border)
            end
        end

        -- Only show borders if explicitly allowed (respects rotation readiness)
        for _, border in ipairs(frame.borders) do
            if self:ShouldShowBorders(frame) then
                border:Show()
            end
        end
        function frame:RemoveBorder()
            if self.borders then
                for _, border in ipairs(self.borders) do
                    border:Hide()
                    border:SetParent(nil)
                end
                self.borders = nil
            end
            DisplayManager.framedBorders[self] = nil
        end

        function frame:UpdateBorder()
            DisplayManager:AddBorder(self)
        end

        return frame.borders
    end

    function DisplayManager:RefreshAllBorders()
        for frame in pairs(self.framedBorders) do
            -- ARCHITECTURAL FIX: Just toggle visibility of EXISTING borders, don't recreate
            -- UpdateBorder() recreates borders which was wasteful
            if frame.borders then
                local shouldShow = self:ShouldShowBorders(frame)
                for _, border in ipairs(frame.borders) do
                    if shouldShow then
                        border:Show()
                    else
                        border:Hide()
                    end
                end
            end

            -- ARCHITECTURAL FIX: Keep frames in tracking even when hidden
            -- Borders need to be tracked so they can be shown when rotation becomes ready
            -- Only remove if frame no longer exists (cleanup)
            -- OLD CODE (WRONG): if not frame:IsShown() then self.framedBorders[frame] = nil end
        end
    end

    --- Recreate all borders (for settings changes like color, thickness, inset)
    function DisplayManager:RecreateAllBorders()
        -- Recreate borders for all tracked frames
        for frame in pairs(self.framedBorders) do
            if frame and frame.UpdateBorder then
                frame:UpdateBorder()  -- This calls AddBorder which recreates
            end
        end
    end

    --- Add a colored border to a frame (for use by PvPTracker, etc.). Supports dynamic color updates.
    --- @param frame Frame The frame to add the border to
    --- @param r number Red 0-1
    --- @param g number Green 0-1
    --- @param b number Blue 0-1
    --- @param a number Alpha 0-1
    --- @param opts table|nil Options: thickness (default 2), inset (default 5), fullyInset (default true). fullyInset=true draws border inside frame; false uses same formula as main NAG borders.
    --- @return table|nil Array of 4 Line regions, or nil
    function DisplayManager:AddColoredBorder(frame, r, g, b, a, opts)
        opts = opts or {}
        local thickness = opts.thickness or 2
        local inset = opts.inset or 5
        local fullyInset = opts.fullyInset ~= false

        if frame.borders then
            for _, border in ipairs(frame.borders) do
                border:Hide()
                border:SetParent(nil)
            end
            frame.borders = {}
        else
            frame.borders = {}
        end

        for i = 1, 4 do
            local line = frame:CreateLine(nil, "OVERLAY", nil, 0)
            if line then
                line:SetThickness(thickness)
                line:SetColorTexture(r or 1, g or 1, b or 1, a or 1)
                if fullyInset then
                    if i == 1 then
                        line:SetStartPoint("TOPLEFT", inset, inset)
                        line:SetEndPoint("TOPRIGHT", -inset, inset)
                    elseif i == 2 then
                        line:SetStartPoint("TOPRIGHT", -inset, inset)
                        line:SetEndPoint("BOTTOMRIGHT", -inset, -inset)
                    elseif i == 3 then
                        line:SetStartPoint("BOTTOMRIGHT", -inset, -inset)
                        line:SetEndPoint("BOTTOMLEFT", inset, -inset)
                    else
                        line:SetStartPoint("BOTTOMLEFT", inset, -inset)
                        line:SetEndPoint("TOPLEFT", inset, inset)
                    end
                else
                    if i == 1 then
                        line:SetStartPoint("TOPLEFT", -thickness + inset, thickness - inset)
                        line:SetEndPoint("TOPRIGHT", thickness - inset, thickness - inset)
                    elseif i == 2 then
                        line:SetStartPoint("TOPRIGHT", thickness - inset, thickness - inset)
                        line:SetEndPoint("BOTTOMRIGHT", thickness - inset, -thickness + inset)
                    elseif i == 3 then
                        line:SetStartPoint("BOTTOMRIGHT", thickness - inset, -thickness + inset)
                        line:SetEndPoint("BOTTOMLEFT", -thickness + inset, -thickness + inset)
                    else
                        line:SetStartPoint("BOTTOMLEFT", -thickness + inset, -thickness + inset)
                        line:SetEndPoint("TOPLEFT", -thickness + inset, thickness - inset)
                    end
                end
                line:Hide()
                tinsert(frame.borders, line)
            end
        end

        function frame:SetBorderColor(nr, ng, nb, na)
            if self.borders then
                for _, line in ipairs(self.borders) do
                    line:SetColorTexture(nr or 1, ng or 1, nb or 1, na or 1)
                end
            end
        end

        return frame.borders
    end

    --- Refresh all cooldown displays based on current settings
    --- This method recreates all icon frames to apply the current cooldown swipe setting
    function DisplayManager:RefreshAllCooldownDisplays()
        -- Refresh group frames if using group display mode
        if self:IsGroupDisplayMode() then
            for groupKey, _ in pairs(FRAME_GROUPS) do
                self:CreateGroupIcons(groupKey)
            end
        end

        -- Refresh legacy frames if using legacy mode
        if self:IsLegacyFrameEnabled() and NAG.Frame then
            self:CreateOrUpdateIconFrames(NAG.Frame)
        end

        -- Update frame visibility
        self:UpdateFrameVisibility()
    end

end

do -- ~~~~~~~~~~~~~~ Legacy FRAME CREATION AND ICON MANAGEMENT ~~~~~~~~~~~~~~
    function DisplayManager:InitializeParentFrame()
        local frameSettings = {
            width = self.db.char.frameSettings.width,
            height = self.db.char.frameSettings.height,
            point = self.db.char.frameSettings.point,
            relativePoint = self.db.char.frameSettings.relativePoint,
            offsetX = self.db.char.frameSettings.offsetX,
            offsetY = self.db.char.frameSettings.offsetY,
            scale = self.db.char.frameSettings.scale
        }
        local parent = self:GetAnchorParent()
        NAG.Frame = NAG.Frame or CreateFrame("Frame", "NAGParentFrame", parent)
        if not NAG.Frame then
            self:Error("InitializeParentFrame: Failed to create parent frame")
            return
        end
        local frame = NAG.Frame
        frame.editMode = false
        frame:SetSize(frameSettings.width, frameSettings.height)
        frame:ClearAllPoints()
        frame:SetPoint(frameSettings.point, parent, frameSettings.relativePoint, frameSettings.offsetX,
            frameSettings.offsetY)
        frame:SetScale(frameSettings.scale)
        frame:SetMovable(true)
        frame:EnableMouseWheel(false)
        frame:EnableMouse(false)
        frame:SetFrameStrata("MEDIUM")
        frame:Hide()
        frame.iconFrames = frame.iconFrames or {}
        frame.combinedIconFrames = frame.combinedIconFrames or {}
        frame.notificationFrames = frame.notificationFrames or {}
        self:CreateOrUpdateIconFrames(frame)
        local anchorFrame = CreateFrame("Frame", "NAGAnchorFrame", parent)
        if anchorFrame then
            anchorFrame:SetSize(1, 1)
            anchorFrame:SetPoint("CENTER", frame, "CENTER", 0, 0)
            anchorFrame:SetAlpha(1)
            anchorFrame:Show()
        end
    end

    ---------------------------------------------------------------------
    -- Icon Frame Creation
    ---------------------------------------------------------------------
    ---
    --- Creates an icon frame with specified properties.
    --- @param name string The name of the frame
    --- @param parent Frame The parent frame
    --- @param width number The width of the frame
    --- @param height number The height of the frame
    --- @param texCoord table|nil The texture coordinates for the frame's texture
    --- @param point string The point on the frame to anchor
    --- @param relativeTo Frame The frame to anchor to
    --- @param relativePoint string The point on the relative frame to anchor to
    --- @param offsetX number The x offset for the frame's position
    --- @param offsetY number The y offset for the frame's position
    --- @return Frame|nil The created icon frame
    function DisplayManager:CreateIconFrame(name, parent, width, height, texCoord, point, relativeTo, relativePoint,
                                            offsetX, offsetY)
        if not name or not parent then
            self:Error("CreateIconFrame: Missing required parameters name or parent")
            return nil
        end
        local frame = CreateFrame("Frame", name, parent)
        if not frame then
            self:Error(format("CreateIconFrame: Failed to create frame %s", name))
            return nil
        end
        -- Ensure parent is NAG.Frame
        if parent ~= NAG.Frame then
            self:Warn(format("CreateIconFrame: Warning - frame %s not parented to NAG.Frame", name))
            parent = NAG.Frame
        end
        frame:SetSize(width, height)
        frame:SetFrameLevel(self.db.char.frameLevel)
        frame:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
        frame.icon = frame:CreateTexture(nil, "BACKGROUND")
        frame.icon:SetAllPoints()
        if not texCoord then
            texCoord = { 0.15, 0.85, 0.15, 0.85 }
        end
        frame.icon:SetTexCoord(unpack(texCoord))
        frame.animGroup = frame:CreateAnimationGroup()
        if frame.animGroup then
            frame.fadeIn = frame.animGroup:CreateAnimation("Alpha")
            frame.fadeIn:SetFromAlpha(0)
            frame.fadeIn:SetToAlpha(1)
            frame.fadeIn:SetDuration(0.5)
            frame.fadeIn:SetOrder(1)
            frame.fadeOut = frame.animGroup:CreateAnimation("Alpha")
            frame.fadeOut:SetFromAlpha(1)
            frame.fadeOut:SetToAlpha(0)
            frame.fadeOut:SetDuration(0.5)
            frame.fadeOut:SetOrder(2)
        else
            self:Warn(format("CreateIconFrame: Failed to create animation group for %s", name))
        end
        function frame:ShowWithFade()
            self:Show()
            if self.animGroup then
                self.animGroup:Stop()
                self.fadeIn:Play()
            end
        end

        function frame:HideWithFade()
            if self.animGroup then
                self.animGroup:Stop()
                self.fadeOut:Play()
                self.fadeOut:SetScript("OnFinished", function(frameSelf) frameSelf:Hide() end)
            else
                self:Hide()
            end
        end

        DisplayManager:AddTooltip(frame)
        AddKeybindOverlayToFrame(frame)
        NAG.Frame.iconFrames[name] = frame

        -- Set groupKey for legacy frames based on position name (use same constants for consistency)
        if name == ns.SPELL_POSITIONS.PRIMARY then
            frame.groupKey = ns.SPELL_POSITIONS.PRIMARY
        elseif name == ns.SPELL_POSITIONS.AOE then
            frame.groupKey = ns.SPELL_POSITIONS.AOE
        elseif strmatch(name, "^" .. ns.SPELL_POSITIONS.LEFT) then
            frame.groupKey = ns.SPELL_POSITIONS.LEFT
        elseif strmatch(name, "^" .. ns.SPELL_POSITIONS.RIGHT) then
            frame.groupKey = ns.SPELL_POSITIONS.RIGHT
        elseif strmatch(name, "^" .. ns.SPELL_POSITIONS.ABOVE) then
            frame.groupKey = ns.SPELL_POSITIONS.ABOVE
        elseif strmatch(name, "^" .. ns.SPELL_POSITIONS.BELOW) then
            frame.groupKey = ns.SPELL_POSITIONS.BELOW
        else
            frame.groupKey = ns.SPELL_POSITIONS.PRIMARY -- fallback
        end

        if MasqueGroup then
            MasqueGroup:AddButton(frame)
        end
        return frame
    end

    ---------------------------------------------------------------------
    -- Icon Frame Management
    ---------------------------------------------------------------------
    function DisplayManager:CreateOrUpdateIconFrames(parent)
        -- Clean up any existing frames that will no longer be used
        if NAG.Frame and NAG.Frame.iconFrames then
            for key, frame in pairs(NAG.Frame.iconFrames) do
                local isNeeded = false
                local num = tonumber(strmatch(key, "%d+"))
                local numLeftIcons = self:GetEffectiveNumLeftIcons()
                local numRightIcons = self.db.char.numRightIcons
                local numAboveIcons = self.db.char.numAboveIcons
                local numBelowIcons = self.db.char.numBelowIcons
                if key == ns.SPELL_POSITIONS.PRIMARY or key == ns.SPELL_POSITIONS.AOE then
                    isNeeded = true
                elseif strmatch(key, "^" .. ns.SPELL_POSITIONS.LEFT) and num and num <= numLeftIcons then
                    isNeeded = true
                elseif strmatch(key, "^" .. ns.SPELL_POSITIONS.RIGHT) and num and num <= numRightIcons then
                    isNeeded = true
                elseif strmatch(key, "^" .. ns.SPELL_POSITIONS.ABOVE) and num and num <= numAboveIcons then
                    isNeeded = true
                elseif strmatch(key, "^" .. ns.SPELL_POSITIONS.BELOW) and num and num <= numBelowIcons then
                    isNeeded = true
                end
                if not isNeeded then
                    if frame.RemoveTooltip then frame:RemoveTooltip() end
                    -- Cleanup handled internally
                    if frame.borders then
                        for _, border in ipairs(frame.borders) do
                            border:Hide()
                            border:SetParent(nil)
                        end
                        frame.borders = nil
                    end
                    -- Clean up parallel round icon if it exists
                    if NAG.Frame.roundIconFrames and NAG.Frame.roundIconFrames[key] then
                        local roundIcon = NAG.Frame.roundIconFrames[key]
                        roundIcon:Hide()
                        roundIcon:SetParent(nil)
                        NAG.Frame.roundIconFrames[key] = nil
                    end
                    frame:Hide()
                    frame:SetParent(nil)
                    NAG.Frame.iconFrames[key] = nil
                end
            end
        end
        local maxLeftIcons = self:GetEffectiveNumLeftIcons()
        local maxRightIcons = self.db.char.numRightIcons
        local maxAboveIcons = self.db.char.numAboveIcons
        local maxBelowIcons = self.db.char.numBelowIcons
        local iconWidth = self.db.char.iconWidth
        local iconHeight = self.db.char.iconHeight
        local frameWeight = self.db.char.frameWeight
        local gap = self.db.char.frameSpacing
        local enableBorders = self.db.char.enableBorders
        local borderThickness = self.db.char.borderThickness
        if enableBorders then
            gap = gap + 2 * borderThickness
        end
        NAG.Frame = NAG.Frame or {}
        if not NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY] then
            local primaryFrame = self:CreateIconFrame(ns.SPELL_POSITIONS.PRIMARY, parent, iconWidth, iconHeight, nil,
                "CENTER", parent, "CENTER", 0, 0)
            -- Add cooldown overlay only if enabled
            if self:AreCooldownSwipesEnabled() then
                primaryFrame.cooldown = CreateFrame("Cooldown", nil, primaryFrame, "CooldownFrameTemplate")
                primaryFrame.cooldown:SetAllPoints()
            end
            primaryFrame.IsPrimary = true
            NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY] = primaryFrame
            self:AddBorder(NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY])
        end
        local primaryFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]
        self:EnsureLegacyRoundPreviewIcon(ns.SPELL_POSITIONS.PRIMARY, parent, primaryFrame, iconWidth, iconHeight,
            frameWeight, gap, "CENTER", "CENTER", 0, 0, nil, true)
        for i = 1, maxAboveIcons do
            local key = ns.SPELL_POSITIONS.ABOVE .. i
            if not NAG.Frame.iconFrames[key] then
                local aboveFrame = self:CreateIconFrame(key, parent, iconWidth, iconHeight * frameWeight,
                    { 0.1, 0.9, 0.25, 0.75 }, "TOP", primaryFrame, "TOP", 0, (iconHeight * frameWeight + gap) * i)
                NAG.Frame.iconFrames[key] = aboveFrame
                self:AddBorder(NAG.Frame.iconFrames[key])
            else
                local aboveFrame = NAG.Frame.iconFrames[key]
                aboveFrame:SetSize(iconWidth, iconHeight * frameWeight * 1.15)
                aboveFrame:ClearAllPoints()
                aboveFrame:SetPoint("TOP", primaryFrame, "TOP", 0, (iconHeight * frameWeight + gap) * i)
            end
            self:EnsureLegacyRoundPreviewIcon(key, parent, primaryFrame, iconWidth, iconHeight, frameWeight, gap,
                "TOP", "TOP", 0, (iconHeight * frameWeight + gap) * i, { 0.1, 0.9, 0.25, 0.75 }, false)
        end
        for i = 1, maxBelowIcons do
            local key = ns.SPELL_POSITIONS.BELOW .. i
            if not NAG.Frame.iconFrames[key] then
                local belowFrame = self:CreateIconFrame(key, parent, iconWidth, iconHeight * frameWeight,
                    { 0.1, 0.9, 0.25, 0.75 }, "BOTTOM", primaryFrame, "BOTTOM", 0, -(iconHeight * frameWeight + gap) * i)
                NAG.Frame.iconFrames[key] = belowFrame
                self:AddBorder(NAG.Frame.iconFrames[key])
            else
                local belowFrame = NAG.Frame.iconFrames[key]
                belowFrame:SetSize(iconWidth, iconHeight * frameWeight * 1.15)
                belowFrame:ClearAllPoints()
                belowFrame:SetPoint("BOTTOM", primaryFrame, "BOTTOM", 0, -(iconHeight * frameWeight + gap) * i)
            end
            self:EnsureLegacyRoundPreviewIcon(key, parent, primaryFrame, iconWidth, iconHeight, frameWeight, gap,
                "BOTTOM", "BOTTOM", 0, -(iconHeight * frameWeight + gap) * i, { 0.1, 0.9, 0.25, 0.75 }, false)
        end
        if not NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE] then
            -- AOE = right half of primary square (rectangle in right half of main icon)
            local aoeWidth = iconWidth * 0.5
            local aoeFrame = self:CreateIconFrame(ns.SPELL_POSITIONS.AOE, parent, aoeWidth, iconHeight,
                AOE_ICON_TEXCOORD_RIGHT_HALF_RECT, "RIGHT", primaryFrame, "RIGHT", 0, 0)
            aoeFrame:SetAlpha(1)
            aoeFrame:SetFrameLevel(self.db.char.frameLevel + 1)
            NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE] = aoeFrame
        else
            local aoeFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE]
            -- AOE = right half of primary square
            aoeFrame:SetSize(iconWidth * 0.5, iconHeight)
            aoeFrame:SetAlpha(1)
            aoeFrame:ClearAllPoints()
            aoeFrame:SetPoint("RIGHT", primaryFrame, "RIGHT", 0, 0)
            if aoeFrame.icon and aoeFrame.icon.SetTexCoord then
                aoeFrame.icon:SetTexCoord(unpack(AOE_ICON_TEXCOORD_RIGHT_HALF_RECT))
            end
        end
        self:EnsureLegacyRoundPreviewIcon(ns.SPELL_POSITIONS.AOE, parent, primaryFrame, iconWidth, iconHeight,
            frameWeight, gap, "RIGHT", "RIGHT", 0, 0, AOE_ICON_TEXCOORD_SQUARE, false)
        for i = 1, maxLeftIcons do
            local key = ns.SPELL_POSITIONS.LEFT .. i
            if not NAG.Frame.iconFrames[key] then
                local leftFrame = self:CreateIconFrame(key, parent, iconWidth * frameWeight, iconHeight,
                    { 0.25, 0.75, 0.1, 0.9 }, "LEFT", primaryFrame, "LEFT", -(iconHeight * frameWeight + gap) * i, 0)
                NAG.Frame.iconFrames[key] = leftFrame
                self:AddBorder(NAG.Frame.iconFrames[key])
            else
                local leftFrame = NAG.Frame.iconFrames[key]
                leftFrame:SetSize(iconWidth * frameWeight, iconHeight)
                leftFrame:ClearAllPoints()
                leftFrame:SetPoint("LEFT", primaryFrame, "LEFT", -(iconHeight * frameWeight + gap) * i, 0)
            end
            self:EnsureLegacyRoundPreviewIcon(key, parent, primaryFrame, iconWidth, iconHeight, frameWeight, gap,
                "LEFT", "LEFT", -(iconHeight * frameWeight + gap) * i, 0, { 0.25, 0.75, 0.1, 0.9 }, false)
        end
        for i = 1, maxRightIcons do
            local key = ns.SPELL_POSITIONS.RIGHT .. i
            if not NAG.Frame.iconFrames[key] then
                local rightFrame = self:CreateIconFrame(key, parent, iconWidth * frameWeight, iconHeight,
                    { 0.25, 0.75, 0.1, 0.9 }, "RIGHT", primaryFrame, "RIGHT", (iconHeight * frameWeight + gap) * i, 0)
                NAG.Frame.iconFrames[key] = rightFrame
                self:AddBorder(NAG.Frame.iconFrames[key])
            else
                local rightFrame = NAG.Frame.iconFrames[key]
                rightFrame:SetSize(iconWidth * frameWeight, iconHeight)
                rightFrame:ClearAllPoints()
                rightFrame:SetPoint("RIGHT", primaryFrame, "RIGHT", (iconHeight * frameWeight + gap) * i, 0)
            end
            self:EnsureLegacyRoundPreviewIcon(key, parent, primaryFrame, iconWidth, iconHeight, frameWeight, gap,
                "RIGHT", "RIGHT", (iconHeight * frameWeight + gap) * i, 0, { 0.25, 0.75, 0.1, 0.9 }, false)
        end
        -- Trim round icons that no longer have a corresponding legacy frame
        if NAG.Frame.roundIconFrames then
            for roundKey, roundIcon in pairs(NAG.Frame.roundIconFrames) do
                if not NAG.Frame.iconFrames[roundKey] then
                    roundIcon:Hide()
                    roundIcon:SetParent(nil)
                    NAG.Frame.roundIconFrames[roundKey] = nil
                end
            end
        end
        self:ApplyRoundMaskToLegacyFrames()
        -- At the end, update mouse state for all legacy frames
        self:UpdateLegacyIconMouseStateForModifier()
    end

    --- Applies/removes round icon masking for legacy frames using showRoundMaskPreview.
    --- When enabled: hides square icons, shows parallel round icons with full parity (masks, bg, spacing, scaling, etc).
    --- When disabled: shows square icons, hides round icons.
    function DisplayManager:ApplyRoundMaskToLegacyFrames()
        if not NAG.Frame or not NAG.Frame.iconFrames then return end

        local maskEnabled = self.db and self.db.char and self.db.char.showRoundMaskPreview == true
            and self:IsLegacyFrameEnabled()

        local roundIconFrames = NAG.Frame.roundIconFrames or {}
        for key, frame in pairs(NAG.Frame.iconFrames) do
            if frame and frame.icon then
                local roundIcon = roundIconFrames[key]
                local hasData = not not (frame.spellId or frame.itemId or frame.id)
                if maskEnabled then
                    if roundIcon then
                        self:MirrorLegacyIconToRoundIcon(frame, roundIcon)
                        roundIcon:SetShown(hasData)
                    end
                    frame:SetShown(false)
                else
                    frame:SetShown(hasData)
                    if roundIcon then
                        roundIcon:SetShown(false)
                    end
                end
            end
        end
    end

    ---------------------------------------------------------------------
    -- Icon Update Functions
    ---------------------------------------------------------------------
    --- Shared icon resolver used by group display (Common) and legacy path (GetCachedEntity).
    --- Single source for tinker, DataManager, and fallback texture resolution.
    --- @param id number Spell or item ID
    --- @param dataManager DataManager|nil
    --- @param preferItemFirst boolean|nil When true, prefer ITEM over SPELL for DataManager lookup (identity-aware contexts)
    --- @return number|nil texture
    --- @return boolean isItem
    --- @return number|nil cooldownItemId When set (e.g. tinker), use GetItemCooldown instead of spell cooldown
    function DisplayManager:ResolveDisplayIcon(id, dataManager, preferItemFirst)
        if not id then
            return nil, false, nil
        end
        local preferItemFirstOption = nil
        if preferItemFirst ~= nil then
            preferItemFirstOption = preferItemFirst == true
        end
        local normalized = NAG.NormalizeActionIdentity and NAG:NormalizeActionIdentity(id, {
            context = "display_resolve_icon",
            preferItemFirst = preferItemFirstOption,
            itemOnlyWhenItem = true,
        }) or nil
        local resolveId = normalized and NAG.GetActionResolveId and NAG:GetActionResolveId(normalized) or id
        local displayId = normalized and NAG.GetActionDisplayId and NAG:GetActionDisplayId(normalized) or id
        local resolvedPreferItemFirst = preferItemFirst
        if resolvedPreferItemFirst == nil then
            resolvedPreferItemFirst = normalized and normalized.itemId ~= nil or false
        end

        local StateManager = NAG:GetModule("StateManager", true)
        if StateManager and StateManager.GetTinkerInfoBySpellId then
            local tinkerProbeId = (normalized and normalized.spellId) or resolveId
            local tinkerInfo = StateManager:GetTinkerInfoBySpellId(tinkerProbeId)
            if tinkerInfo and tinkerInfo.icon then
                return tinkerInfo.icon, true, tinkerInfo.itemId
            end
        end
        local entity = nil
        if dataManager then
            local identity = dataManager.GetIdentity and dataManager:GetIdentity(resolveId, "display_resolve_icon", {
                preferItemFirst = resolvedPreferItemFirst,
                spellId = normalized and normalized.spellId or nil,
                itemId = normalized and normalized.itemId or nil,
            }) or nil
            entity = identity and identity.entity or nil
        end
        local treatAsItem = (((normalized and normalized.itemId and not normalized.spellId) and true) or false)
            or (entity and entity.IsItem) == true
        if entity and entity.flags and entity.flags.tinker and entity.itemId then
            local itemIcon = GetItemIcon(entity.itemId)
            if itemIcon then
                return itemIcon, true, entity.itemId
            end
        end
        if entity and entity.icon then
            local cooldownItemId = (entity.flags and entity.flags.tinker and entity.itemId) and entity.itemId or nil
            if not treatAsItem and not cooldownItemId then
                local spellTex = GetSpellTexture(resolveId)
                if spellTex then
                    return spellTex, false, nil
                end
            end
            return entity.icon, treatAsItem, cooldownItemId
        end
        if treatAsItem or (displayId and WoWAPI.GetItemInfo(displayId) ~= nil) then
            local icon = GetItemIcon(displayId)
            if icon then
                return icon, true, nil
            end
        end
        local texture = GetSpellTexture(resolveId)
        if texture then
            return texture, false, nil
        end
        local icon = GetItemIcon(displayId)
        if icon then
            return icon, true, nil
        end
        return nil, treatAsItem, nil
    end

    -- Cache for entity lookups to avoid repeated DataManager calls
    local entityCache = {}

    local function GetDisplayCacheKey(id, preferItemFirst)
        if DataManager and DataManager.BuildIdentityCacheKey then
            return DataManager:BuildIdentityCacheKey(id, "display", preferItemFirst == true)
        end
        return format("display:%s:%s", preferItemFirst and "item" or "spell", tostring(id))
    end

    -- Helper function to get entity with caching (uses shared ResolveDisplayIcon)
    local function GetCachedEntity(id, preferItemFirst)
        local dm = NAG:GetModule("DisplayManager")
        if not dm or not DataManager then
            return nil
        end
        local resolvedPreferItemFirst = preferItemFirst
        if resolvedPreferItemFirst == nil and NAG.NormalizeActionIdentity then
            local normalized = NAG:NormalizeActionIdentity(id, { context = "display_cache_identity" })
            resolvedPreferItemFirst = normalized and normalized.itemId ~= nil or false
        end
        local cacheKey = GetDisplayCacheKey(id, resolvedPreferItemFirst)
        if entityCache[cacheKey] ~= nil then
            return entityCache[cacheKey]
        end

        local texture, isItem, cooldownItemId = dm:ResolveDisplayIcon(id, DataManager, resolvedPreferItemFirst)
        if not texture then
            return nil
        end
        entityCache[cacheKey] = {
            icon = texture,
            IsItem = isItem,
            IsSpell = not isItem,
            itemId = cooldownItemId or (isItem and id) or nil,
            flags = (cooldownItemId and { tinker = true } or nil)
        }
        return entityCache[cacheKey]
    end

    --- Clear entity cache (e.g. when display set or rotation changes to avoid unbounded growth).
    function DisplayManager:ClearEntityCache()
        wipe(entityCache)
    end

    ---
    --- Optimized icon update function with caching and reduced API calls
    --- @param position string The position key for the icon
    --- @param id number The spell or item ID to display
    --- @param preferItemFirst boolean|nil When true, resolve id as item first (for item-only secondarySpells entries)
    --- @return boolean True if successful, false otherwise
    function DisplayManager:UpdateIcon(position, id, preferItemFirst)
        local frame = NAG.Frame.iconFrames[position]
        if not frame then
            -- CRITICAL: Frame corruption - frame missing prevents updates, causing permanent freeze
            self:Error(format("UpdateIcon: CRITICAL - No icon frame found for position: %s (id=%s) - frame corruption may cause display to become stuck",
                tostring(position), tostring(id)))
            return false
        end
        if not id then
            self:Error("UpdateIcon: No ID provided for position: " .. position)
            return false
        end
        frame._nagPosition = position

        local positionKey = tostring(position or "")
        local isAoePosition = positionKey == ns.SPELL_POSITIONS.AOE
        local isLeftPosition = positionKey == ns.SPELL_POSITIONS.LEFT or strmatch(positionKey, "^left")
        if (isAoePosition and not self:IsAoeFrameEnabled()) or (isLeftPosition and not self:IsLeftFramesEnabled()) then
            frame.spellId = nil
            frame.itemId = nil
            frame.id = nil
            frame:Hide()
            if NAG.Frame.roundIconFrames and NAG.Frame.roundIconFrames[position] then
                NAG.Frame.roundIconFrames[position]:SetShown(false)
            end
            return true
        end

        -- Early exit if same ID is already displayed
        if frame.id == id then
            -- Even when the icon doesn't change, overlays (text + ret twist HOLD swipe) may change every tick.
            -- This is required for the Ret twist HOLD swipe, which is time-based.
            local overlayId = frame.spellId or frame.itemId
            local overlayText = ""
            if overlayId then
                overlayText = NAG.castOverlayTexts and NAG.castOverlayTexts[overlayId] or ""
                if frame.lastOverlayText ~= overlayText then
                    if overlayText ~= "" then
                        self:DisplayCastOverlayText(overlayId, position, frame)
                    else
                        -- Ensure any prior HOLD sweep is hidden when not in HOLD state.
                        self:UpdateRetTwistHoldSweep(frame.spellId, position, "", frame)
                        -- Ensure Hunter HOLD sweep is hidden when not in HOLD state.
                        self:UpdateHunterSteadyHoldSweep(frame.spellId, position, "", frame)
                        self:UpdateHunterMultiHoldSweep(frame.spellId, position, "", frame)
                    end
                    frame.lastOverlayText = overlayText
                end

                -- Swing swipe overlays are independent of overlay text; update every tick.
                self:UpdateSwingHoldSweep(frame.spellId, position, frame)
            end
            -- Keep cooldown/GCD/charges overlays live even when the icon ID is unchanged.
            -- Without this refresh, tinkers on non-primary positions and classes that hold the same
            -- suggestion (e.g. TBC Hunter) can have cooldown overlays stuck or missing.
            self:UpdatePrimaryIconOverlays(frame)
            -- Ret twist HOLD sweep must be refreshed every tick and after generic overlays,
            -- otherwise cooldown refreshes can visually override the custom HOLD swipe.
            if frame.spellId and ns.Version:IsTBC() and NAG.CLASS_FILENAME == "PALADIN" then
                self:UpdateRetTwistHoldSweep(frame.spellId, position, overlayText, frame)
            end
            if self:IsRoundMaskPreviewEnabled() and self:IsLegacyFrameEnabled() and NAG.Frame.roundIconFrames and NAG.Frame.roundIconFrames[position] then
                local roundIcon = NAG.Frame.roundIconFrames[position]
                self:MirrorLegacyIconToRoundIcon(frame, roundIcon)
                frame:SetShown(false)
                roundIcon:SetShown(true)
            end
            return true
        end

        -- Clear previous state
        frame.spellId = nil
        frame.itemId = nil
        frame.id = id

        -- Tinker fix: StateManager is authoritative for tinker icon (gloves, not spell)
        local StateManager = NAG:GetModule("StateManager", true)
        local tinkerInfo = (StateManager and StateManager.GetTinkerInfoBySpellId) and StateManager:GetTinkerInfoBySpellId(id) or nil

        local iconTexture
        local useItemId, useSpellId
        if tinkerInfo and tinkerInfo.icon then
            iconTexture = tinkerInfo.icon
            useItemId = tinkerInfo.itemId
            useSpellId = id
        else
            local entity = GetCachedEntity(id, preferItemFirst)
            if not entity then
                self:Error(format("UpdateIcon: Unknown entity type for ID: %d", id))
                return false
            end
            iconTexture = entity.icon
            if entity.flags and entity.flags.tinker and entity.itemId then
                useItemId = entity.itemId
                useSpellId = id
            elseif entity.IsItem then
                useItemId = id
            else
                useSpellId = id
            end
        end

        -- Tinker cooldown fix: always use item cooldown for tinkers (spell ID cooldown is wrong).
        -- If we have spellId but no itemId, resolve tinker so we use GetItemCooldown not GetSpellCooldown.
        if useSpellId and not useItemId and StateManager and StateManager.GetTinkerInfoBySpellId then
            local ti = StateManager:GetTinkerInfoBySpellId(useSpellId)
            if ti and type(ti) == "table" and ti.itemId then
                useItemId = ti.itemId
                iconTexture = GetItemIcon(ti.itemId) or iconTexture
            end
        end

        frame.icon:SetTexture(iconTexture)
        frame._lastTexture = iconTexture
        frame:Show()
        frame.itemId = useItemId
        frame.spellId = useSpellId
        frame.lastOverlayText = ""

        -- ARCHITECTURAL FIX: Border visibility managed by RefreshAllBorders (line 3591)
        -- UpdateBorder was recreating borders every tick - removed

        -- Update keybind text if available
        if frame.UpdateKeybindText then
            frame:UpdateKeybindText()
        else
            -- Add keybind text for main display frames (similar to prediction queue)
            self:UpdateMainFrameKeybind(frame, frame.spellId or id)
        end

        -- Cooldown and charge overlays: apply for every position so tinkers on spellLocation override
        -- (e.g. LEFT) use item cooldown, not spell cooldown.
        self:UpdatePrimaryIconOverlays(frame)

        -- Overlay text + Ret twist HOLD swipe overlay.
        -- DisplayCastOverlayText() contains the Ret twist logic that replaces HOLD text with the swipe overlay.
        -- Only for TBC Paladins
        if frame.spellId and ns.Version:IsTBC() and NAG.CLASS_FILENAME == "PALADIN" then
            local overlayText = NAG.castOverlayTexts and NAG.castOverlayTexts[frame.spellId] or ""
            if overlayText ~= "" then
                self:DisplayCastOverlayText(frame.spellId, position, frame)
            else
                self:UpdateRetTwistHoldSweep(frame.spellId, position, "", frame)
            end
            frame.lastOverlayText = overlayText
        end

        -- Hunter HOLD swipe overlay: needs to be updated on the same tick the icon changes (not only on the cached/idempotent path),
        -- otherwise the Steady HOLD swipe can fail to appear.
        if frame.spellId and ns.Version:IsTBC() and NAG.CLASS_FILENAME == "HUNTER" then
            local overlayText = NAG.castOverlayTexts and NAG.castOverlayTexts[frame.spellId] or ""
            if overlayText ~= "" then
                self:DisplayCastOverlayText(frame.spellId, position, frame)
            else
                self:UpdateHunterSteadyHoldSweep(frame.spellId, position, "", frame)
            end
            frame.lastOverlayText = overlayText
        end

        -- Generic swing swipe overlays (e.g., 6603 pooling placeholders) should work for all classes/expansions.
        if frame.spellId then
            self:UpdateSwingHoldSweep(frame.spellId, position, frame)
        end

        if self:IsRoundMaskPreviewEnabled() and self:IsLegacyFrameEnabled() and NAG.Frame.roundIconFrames and NAG.Frame.roundIconFrames[position] then
            local roundIcon = NAG.Frame.roundIconFrames[position]
            self:MirrorLegacyIconToRoundIcon(frame, roundIcon)
            frame:SetShown(false)
            roundIcon:SetShown(true)
        end
        return true
    end

    local CUSTOM_HOLD_SWIPE_LOG_VERSION = "1.0.0"
    local function getCustomHoldKey(position, spellId)
        return tostring(position or ns.SPELL_POSITIONS.PRIMARY) .. ":" .. tostring(spellId or 0)
    end

    local RET_TWIST_SWIPE_SMOOTH_STALE_THRESHOLD = 0.002
    local RET_TWIST_SWIPE_SMOOTH_RESYNC_AHEAD_THRESHOLD = 0.08
    local RET_TWIST_SWIPE_SMOOTH_RESYNC_BEHIND_THRESHOLD = 0.18
    local retTwistSwipeSmoothState = {}

    --- Returns a smoothed hold-seconds value for Ret TBC swipe visuals.
    --- Uses predictive decay between stale/cached samples and resyncs when divergence is meaningful.
    --- @param stateKey string
    --- @param rawSeconds number
    --- @param now number
    --- @param maxSeconds number|nil
    --- @return number
    local function GetSmoothedRetTwistSwipeSeconds(stateKey, rawSeconds, now, maxSeconds)
        local raw = rawSeconds or 0
        if raw < 0 then
            raw = 0
        end
        if maxSeconds and maxSeconds > 0 and raw > maxSeconds then
            raw = maxSeconds
        end

        local state = retTwistSwipeSmoothState[stateKey]
        if not state then
            retTwistSwipeSmoothState[stateKey] = {
                sampledSeconds = raw,
                sampledAt = now,
                lastRaw = raw,
            }
            return raw
        end

        local predicted = state.sampledSeconds - (now - state.sampledAt)
        if predicted < 0 then
            predicted = 0
        end
        if maxSeconds and maxSeconds > 0 and predicted > maxSeconds then
            predicted = maxSeconds
        end

        local lastRaw = state.lastRaw or raw
        local staleRead = math.abs(raw - lastRaw) <= RET_TWIST_SWIPE_SMOOTH_STALE_THRESHOLD
        local shouldResync = false
        if raw < (predicted - RET_TWIST_SWIPE_SMOOTH_RESYNC_BEHIND_THRESHOLD) then
            shouldResync = true
        elseif raw > (predicted + RET_TWIST_SWIPE_SMOOTH_RESYNC_AHEAD_THRESHOLD) and not staleRead then
            shouldResync = true
        elseif predicted <= RET_TWIST_SWIPE_SMOOTH_STALE_THRESHOLD
            and raw > RET_TWIST_SWIPE_SMOOTH_RESYNC_AHEAD_THRESHOLD
            and not staleRead then
            shouldResync = true
        end

        if shouldResync then
            state.sampledSeconds = raw
            state.sampledAt = now
            predicted = raw
        end

        state.lastRaw = raw
        return predicted
    end

    --- Clears one swipe smoothing track.
    --- @param stateKey string|nil
    local function ClearRetTwistSwipeSmoothState(stateKey)
        if not stateKey then
            return
        end
        retTwistSwipeSmoothState[stateKey] = nil
    end

    --- Clears all Ret twist swipe smoothing keys tracked on a frame.
    --- @param frame Frame|nil
    local function ClearFrameRetTwistSwipeSmoothKeys(frame)
        if not frame or not frame._retTwistSwipeSmoothKeys then
            return
        end
        local keys = frame._retTwistSwipeSmoothKeys
        for _, key in ipairs(keys) do
            ClearRetTwistSwipeSmoothState(key)
        end
        frame._retTwistSwipeSmoothKeys = nil
    end

    --- Registers an explicit custom HOLD swipe state for a spell/position.
    --- @param spellId number
    --- @param position string|nil
    --- @param endAt number Absolute timestamp (GetTime-based) when hold ends.
    --- @param options table|nil Optional visual config.
    function DisplayManager:RegisterCustomHoldSwipe(spellId, position, endAt, options)
        if not spellId or not endAt then
            return
        end
        local now = (_G.GetTime and _G.GetTime()) or 0
        if endAt <= now then
            self:ClearCustomHoldSwipe(spellId, position)
            return
        end
        self._customHoldSwipes = self._customHoldSwipes or {}
        local pos = position or ns.SPELL_POSITIONS.PRIMARY
        local key = getCustomHoldKey(pos, spellId)
        self._customHoldSwipes[key] = {
            spellId = spellId,
            position = pos,
            endAt = endAt,
            options = options or {},
        }
        if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
            local dbgLastAt = self._customHoldSwipeDbgLastAt or 0
            if (now - dbgLastAt) >= 0.25 then
                -- print(string.format(
                --     "[CUSTOM_HOLD_SWIPE][ver=%s] action=register spell=%s pos=%s endIn=%.3f",
                --     CUSTOM_HOLD_SWIPE_LOG_VERSION,
                --     tostring(spellId),
                --     tostring(pos),
                --     endAt - now
                -- ))
                self._customHoldSwipeDbgLastAt = now
            end
        end
    end

    --- Clears explicit custom HOLD swipe state for a spell/position.
    --- @param spellId number
    --- @param position string|nil
    function DisplayManager:ClearCustomHoldSwipe(spellId, position)
        local pos = position or ns.SPELL_POSITIONS.PRIMARY
        local key = getCustomHoldKey(pos, spellId)
        if self._customHoldSwipes then
            self._customHoldSwipes[key] = nil
        end
        ClearRetTwistSwipeSmoothState("custom:" .. key)
        local frame = NAG and NAG.Frame and NAG.Frame.iconFrames and NAG.Frame.iconFrames[pos] or nil
        if frame and frame.customHoldCooldown then
            frame.customHoldCooldown:Hide()
            frame._customHoldSwipeActive = false
            frame._customHoldSwipeEndAt = nil
            frame._customHoldSwipeSpellId = nil
            if frame._customHoldSwipeSmoothKey then
                ClearRetTwistSwipeSmoothState(frame._customHoldSwipeSmoothKey)
                frame._customHoldSwipeSmoothKey = nil
            end
        end
        local now = (_G.GetTime and _G.GetTime()) or 0
        if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
            local dbgLastAt = self._customHoldSwipeDbgLastAt or 0
            if (now - dbgLastAt) >= 0.25 then
                -- print(string.format(
                --     "[CUSTOM_HOLD_SWIPE][ver=%s] action=clear spell=%s pos=%s",
                --     CUSTOM_HOLD_SWIPE_LOG_VERSION,
                --     tostring(spellId),
                --     tostring(pos)
                -- ))
                self._customHoldSwipeDbgLastAt = now
            end
        end
    end

    --- Gets active custom HOLD swipe state for a spell/position.
    --- Expired states are cleared automatically.
    --- @param spellId number
    --- @param position string|nil
    --- @return table|nil
    function DisplayManager:GetCustomHoldSwipe(spellId, position)
        if not self._customHoldSwipes then
            return nil
        end
        local pos = position or ns.SPELL_POSITIONS.PRIMARY
        local key = getCustomHoldKey(pos, spellId)
        local state = self._customHoldSwipes[key]
        if not state then
            return nil
        end
        local now = (_G.GetTime and _G.GetTime()) or 0
        if (state.endAt or 0) <= now then
            self._customHoldSwipes[key] = nil
            return nil
        end
        return state
    end

    --- Applies a custom HOLD swipe to a frame when active.
    --- @param frame Frame
    --- @return boolean True when a custom hold swipe is active and drawn.
    function DisplayManager:ApplyCustomHoldSwipe(frame)
        if not frame or not frame.spellId then
            return false
        end
        local position = frame._nagPosition or ns.SPELL_POSITIONS.PRIMARY
        local customSmoothKey = "custom:" .. getCustomHoldKey(position, frame.spellId)
        if frame._customHoldSwipeSmoothKey and frame._customHoldSwipeSmoothKey ~= customSmoothKey then
            ClearRetTwistSwipeSmoothState(frame._customHoldSwipeSmoothKey)
        end
        frame._customHoldSwipeSmoothKey = customSmoothKey
        local state = self:GetCustomHoldSwipe(frame.spellId, position)
        if not state then
            if frame.customHoldCooldown then
                frame.customHoldCooldown:Hide()
            end
            frame._customHoldSwipeActive = false
            frame._customHoldSwipeEndAt = nil
            frame._customHoldSwipeSpellId = nil
            ClearRetTwistSwipeSmoothState(customSmoothKey)
            frame._customHoldSwipeSmoothKey = nil
            return false
        end

        local now = (_G.GetTime and _G.GetTime()) or 0
        local rawHoldSeconds = (state.endAt or 0) - now
        local holdSeconds = GetSmoothedRetTwistSwipeSeconds(customSmoothKey, rawHoldSeconds, now, nil)
        if holdSeconds <= 0.05 then
            self:ClearCustomHoldSwipe(frame.spellId, position)
            return false
        end

        local options = state.options or {}
        -- Use explicit alpha when provided (e.g. Judge+SoC at 0.5); otherwise apply multiplier to default
        local alpha = (options.alpha ~= nil) and options.alpha or (0.9 * CUSTOM_SWIPE_ALPHA_MULTIPLIER)
        local reverse = options.reverse
        if reverse == nil then
            reverse = false
        end

        local primaryFrame = frame
        local parentFrame = primaryFrame:GetParent() or primaryFrame
        local aoeFrame = NAG and NAG.Frame and NAG.Frame.iconFrames and NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE] or nil
        local targetLevel = primaryFrame:GetFrameLevel()
        if options.coverAOE and aoeFrame and aoeFrame.GetFrameLevel then
            targetLevel = max(targetLevel, aoeFrame:GetFrameLevel())
        end

        if not frame.customHoldCooldown then
            frame.customHoldCooldown = CreateFrame("Cooldown", nil, parentFrame, "CooldownFrameTemplate")
            frame.customHoldCooldown:SetDrawBling(false)
            frame.customHoldCooldown:SetDrawEdge(false)
            if frame.customHoldCooldown.SetHideCountdownNumbers then
                frame.customHoldCooldown:SetHideCountdownNumbers(true)
            end
        elseif frame.customHoldCooldown:GetParent() ~= parentFrame then
            frame.customHoldCooldown:SetParent(parentFrame)
        end

        frame.customHoldCooldown:SetFrameLevel(targetLevel + 8)
        frame.customHoldCooldown:ClearAllPoints()
        frame.customHoldCooldown:SetAllPoints(primaryFrame)
        -- When round mask is on, use circular swipe texture (same as GCD) so custom hold matches visually
        if self:IsRoundMaskPreviewEnabled() and self:IsLegacyFrameEnabled() and frame.customHoldCooldown.SetSwipeTexture then
            local pos = frame._nagPosition or ns.SPELL_POSITIONS.PRIMARY
            local swipeMask = self:GetRoundPreviewMaskTextureForPosition(pos) or CIRCLE_MASK_TEXTURE
            frame.customHoldCooldown:SetSwipeTexture(swipeMask)
        end
        frame.customHoldCooldown:SetSwipeColor(0, 0, 0, alpha)
        if frame.customHoldCooldown.SetDrawSwipe then
            frame.customHoldCooldown:SetDrawSwipe(true)
        end
        if frame.customHoldCooldown.SetReverse then
            frame.customHoldCooldown:SetReverse(reverse)
        end

        local previousEndAt = frame._customHoldSwipeEndAt or 0
        local endAtDelta = math.abs(previousEndAt - (state.endAt or 0))
        local previousRemaining = (previousEndAt > now) and (previousEndAt - now) or 0
        local reseedReason = nil
        local shouldSeed = (not frame._customHoldSwipeActive)
            or (frame._customHoldSwipeSpellId ~= frame.spellId)
            or (not frame._customHoldSwipeEndAt)
        if shouldSeed then
            reseedReason = (not frame._customHoldSwipeActive and "inactive")
                or ((frame._customHoldSwipeSpellId ~= frame.spellId) and "spell_changed")
                or "missing_endat"
        else
            -- Ignore tiny timestamp jitter to keep the swipe continuous.
            -- Only reseed on meaningful extension/jump in the hold target.
            -- NOTE: Parry-haste and similar timing corrections can also REDUCE endAt significantly.
            -- In those cases we must reseed so the swipe aligns with the earlier deadline.
            local significantDelta = endAtDelta > 0.20
            local meaningfulExtension = (state.endAt or 0) > (previousEndAt + 0.20)
            local meaningfulReduction = (state.endAt or 0) < (previousEndAt - 0.20)
            if significantDelta and meaningfulExtension then
                shouldSeed = true
                reseedReason = "endat_extended"
            elseif significantDelta and meaningfulReduction then
                shouldSeed = true
                reseedReason = "endat_reduced"
            end
        end
        if shouldSeed then
            local cooldownStartAt = now
            local cooldownDuration = holdSeconds
            local maxDuration = tonumber(options.maxDuration) or 0
            if maxDuration > 0 then
                if holdSeconds > maxDuration then
                    -- Keep the swipe visually full for long holds; animate only in the final maxDuration window.
                    cooldownStartAt = (state.endAt or now) - maxDuration
                    cooldownDuration = maxDuration
                else
                    cooldownDuration = holdSeconds
                end
            end
            frame._customHoldSwipeActive = true
            frame._customHoldSwipeSpellId = frame.spellId
            frame._customHoldSwipeEndAt = state.endAt
            frame._customHoldCooldownStart = cooldownStartAt
            frame._customHoldCooldownDuration = cooldownDuration
            frame._customHoldSwipeAlpha = alpha
            frame._customHoldSwipeReverse = reverse
            frame.customHoldCooldown:SetCooldown(cooldownStartAt, cooldownDuration)
            if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
                local soCSealId = (NAG.RetTwistGetSoCSealId and NAG:RetTwistGetSoCSealId()) or nil
                local isJudgeOrSoC = (frame.spellId == 20271) or (soCSealId and frame.spellId == soCSealId)
                if isJudgeOrSoC then
                    local dbgReseedAt = frame._customHoldSwipeReseedDbgAt or 0
                    if (now - dbgReseedAt) >= 0.10 then
                        -- print(string.format(
                        --     "[CUSTOM_HOLD_SWIPE][ver=%s] action=reseed spell=%s pos=%s reason=%s endAtDelta=%.3f prevRemaining=%.3f newRemaining=%.3f",
                        --     CUSTOM_HOLD_SWIPE_LOG_VERSION,
                        --     tostring(frame.spellId),
                        --     tostring(position),
                        --     tostring(reseedReason or "unknown"),
                        --     endAtDelta,
                        --     previousRemaining,
                        --     holdSeconds
                        -- ))
                        frame._customHoldSwipeReseedDbgAt = now
                    end
                end
            end
        end

        frame._customHoldSwipeAlpha = alpha
        frame._customHoldSwipeReverse = reverse
        if frame.cooldown and frame.cooldown.Hide then
            frame.cooldown:Hide()
        end
        frame.customHoldCooldown:Show()
        if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
            local dbgLastAt = frame._customHoldSwipeDbgAt or 0
            if (now - dbgLastAt) >= 0.25 then
                -- print(string.format(
                --     "[CUSTOM_HOLD_SWIPE][ver=%s] action=active spell=%s pos=%s remaining=%.3f alpha=%.2f reverse=%s",
                --     CUSTOM_HOLD_SWIPE_LOG_VERSION,
                --     tostring(frame.spellId),
                --     tostring(position),
                --     holdSeconds,
                --     alpha,
                --     tostring(reverse)
                -- ))
                frame._customHoldSwipeDbgAt = now
            end
        end
        return true
    end

    --- Display overlay text for a spell/item id if it exists in castOverlayTexts.
    --- @param spellId number The spell ID (or item ID) to check for overlay text.
    --- @param position string The position where the spell is displayed
    function DisplayManager:DisplayCastOverlayText(spellId, position, frameOverride)
        if not spellId or not NAG.castOverlayTexts then
            return
        end

        local overlayText = NAG.castOverlayTexts[spellId]
        if not overlayText or overlayText == "" then
            return
        end

        -- Hunter Steady HOLD UX: suppress overlay text and rely on a cooldown-sweep countdown on Steady.
        -- The sweep is updated via UpdateHunterSteadyHoldSweep().
        local isHunterSteadyHold = (overlayText == "HOLD_SS") and (spellId == 34120)
        if isHunterSteadyHold then
            self:UpdateHunterSteadyHoldSweep(spellId, position, overlayText, frameOverride)

            if OverlayManager and OverlayManager.HideTextOverlay and NAG.Frame and NAG.Frame.iconFrames then
                local frame = frameOverride or NAG.Frame.iconFrames[position]
                if frame then OverlayManager:HideTextOverlay(frame, "cast_" .. tostring(spellId)) end
            end
            return
        end

        -- Hunter Multi HOLD UX: suppress overlay text and rely on a cooldown-sweep countdown on Multi.
        local isHunterMultiHold = (overlayText == "HOLD_MS") and (spellId == 27021)
        if isHunterMultiHold then
            self:UpdateHunterMultiHoldSweep(spellId, position, overlayText, frameOverride)

            if OverlayManager and OverlayManager.HideTextOverlay and NAG.Frame and NAG.Frame.iconFrames then
                local frame = frameOverride or NAG.Frame.iconFrames[position]
                if frame then OverlayManager:HideTextOverlay(frame, "cast_" .. tostring(spellId)) end
            end
            return
        end

        -- Ret twist BURST UX: if we're showing "Burst and\nTwist" on Avenging Wrath, suppress the text overlay
        -- and rely on the cooldown-sweep (clockwise shadow) that spans both PRIMARY and AOE frames.
        -- The sweep is updated via UpdateRetTwistHoldSweep().
        local isRetTwistHoldBurst = (overlayText == "Burst and\nTwist") and (spellId == 31884)
        if isRetTwistHoldBurst then
            self:UpdateRetTwistHoldSweep(spellId, position, overlayText, frameOverride)

            -- Ensure any prior text overlay for this cast id is hidden (prevents lingering text).
            if OverlayManager and OverlayManager.HideTextOverlay and NAG.Frame and NAG.Frame.iconFrames then
                local frame = frameOverride or NAG.Frame.iconFrames[position]
                if frame then OverlayManager:HideTextOverlay(frame, "cast_" .. tostring(spellId)) end
            end
            return
        end

        -- Convert position to overlay text position format
        local overlayPosition = "primary"
        if position then
            if position == ns.SPELL_POSITIONS.LEFT or strmatch(tostring(position), "^left") then
                overlayPosition = position -- Use position as-is (e.g., "left1", "left2")
            elseif position == ns.SPELL_POSITIONS.RIGHT or strmatch(tostring(position), "^right") then
                overlayPosition = position -- Use position as-is (e.g., "right1", "right2")
            elseif position == ns.SPELL_POSITIONS.ABOVE or strmatch(tostring(position), "^above") then
                overlayPosition = position -- Use position as-is (e.g., "above1")
            elseif position == ns.SPELL_POSITIONS.BELOW or strmatch(tostring(position), "^below") then
                overlayPosition = position -- Use position as-is (e.g., "below1")
            elseif position == ns.SPELL_POSITIONS.AOE then
                overlayPosition = "aoe"
            else
                overlayPosition = tostring(position)
            end
        end

        -- Display overlay text
        NAG:OverlayText(overlayText, {
            position = overlayPosition,
            id = (type(overlayPosition) == "string" and overlayPosition or "primary") .. "_cast",
            spellId = spellId
        })

        -- Ret twist extra UX: during HOLD, show a clockwise cooldown-sweep "shadow" that counts down
        -- how long the player should keep holding until the twist window opens.
        -- This is intentionally minimal and scoped: it only applies to the twist seal IDs we use
        -- (SoB 31892 / SoM 348700) when the overlay text is exactly "HOLD".
        self:UpdateRetTwistHoldSweep(spellId, position, overlayText, frameOverride)

        -- Generic swing-timer swipe overlay (e.g., pooling placeholders): show a swipe until next auto attack.
        self:UpdateSwingHoldSweep(spellId, position, frameOverride)
    end

    --- Show/hide a swing-timer countdown sweep on the icon frame.
    --- Uses CooldownFrameTemplate to create a clockwise swipe animation based on the player's swing timer.
    --- Triggered via NAG.castOverlaySwipes[spellId] == "swing" (set by NAG:CastWithSwingOverlay()).
    --- @param spellId number
    --- @param position string|nil
    --- @param frameOverride Frame|nil
    function DisplayManager:UpdateSwingHoldSweep(spellId, position, frameOverride)
        local swipes = NAG and NAG.castOverlaySwipes or nil
        local isSwing = swipes and (swipes[spellId] == "swing") or false

        local frame = frameOverride
        if not frame then
            if not position then return end
            if not NAG or not NAG.Frame or not NAG.Frame.iconFrames then return end
            frame = NAG.Frame.iconFrames[position]
        end
        if not frame then return end

        local now = _G.GetTime()

        -- Gate the Auto Attack (6603) swing swipe behind a short-lived marker set by NAG:CastWithSwingOverlay().
        -- If the marker isn't refreshed, let the normal cooldown/GCD swipe take over again.
        if isSwing and spellId == 6603 then
            local expiresAt = NAG and NAG.castOverlaySwipesExpiresAt and NAG.castOverlaySwipesExpiresAt[spellId] or nil
            if not expiresAt or expiresAt <= now then
                isSwing = false
                if swipes then
                    swipes[spellId] = nil
                end
                if NAG and NAG.castOverlaySwipesExpiresAt then
                    NAG.castOverlaySwipesExpiresAt[spellId] = nil
                end
            end
        end

        if not isSwing then
            -- NOTE: Commented out to avoid chat spam when Auto Attack (6603) is displayed without a swing swipe marker.
            -- if spellId == 6603 then
            --     debugPrintOncePerSecond(string.format(
            --         "[SwingSwipe] spellId=%s pos=%s isSwing=%s swipeTag=%s reason=no_marker",
            --         tostring(spellId), tostring(position), tostring(isSwing), tostring(swipes and swipes[spellId])
            --     ))
            -- end
            if frame.swingHoldCooldown then
                frame.swingHoldCooldown:Hide()
            end
            frame._swingHoldSweepActive = false
            frame._swingHoldLastSwing = nil
            frame._swingHoldLastExpiration = nil

            -- Restore normal cooldown/GCD swipe immediately when the swing overlay is not active.
            if frame._retTwistHoldSweepActive then
                return
            end
            if position == ns.SPELL_POSITIONS.PRIMARY and frame.cooldown and self.UpdatePrimaryIconOverlays then
                self:UpdatePrimaryIconOverlays(frame)
            end
            return
        end

        -- IMPORTANT: LibClassicSwingTimerAPI initializes timers on login (PLAYER_ENTERING_WORLD),
        -- even when the player is not actually auto-attacking. So we must gate the swing swipe
        -- behind "currently attacking" AND "in melee range" to avoid showing a perpetual swipe
        -- out of combat / without a target / when you have Auto Attack toggled but cannot swing.
        local isActuallyAttacking = false
        if NAG and NAG.IsAttacking then
            isActuallyAttacking = NAG:IsAttacking()
        elseif _G.IsCurrentSpell then
            isActuallyAttacking = _G.IsCurrentSpell(6603) and true or false
        end
        if _G.UnitExists and _G.UnitCanAttack then
            if not _G.UnitExists("target") or not _G.UnitCanAttack("player", "target") then
                isActuallyAttacking = false
            end
        end

        local isInMeleeRange = false
        if NAG and NAG.TargetInMeleeRange then
            -- Uses NAG's unified melee range helper (1 = melee range)
            isInMeleeRange = NAG:TargetInMeleeRange(1) and true or false
        end

        if not isInMeleeRange then
            if frame.swingHoldCooldown then
                frame.swingHoldCooldown:Hide()
            end
            frame._swingHoldSweepActive = false
            frame._swingHoldLastSwing = nil
            frame._swingHoldLastExpiration = nil
            return
        end

        if not isActuallyAttacking then
            if frame.swingHoldCooldown then
                frame.swingHoldCooldown:Hide()
            end
            frame._swingHoldSweepActive = false
            frame._swingHoldLastSwing = nil
            frame._swingHoldLastExpiration = nil
            return
        end

        local swingTimerLib = ns.LibClassicSwingTimerAPI
        if not swingTimerLib or not swingTimerLib.UnitSwingTimerInfo then
            return
        end

        -- Ensure the shared swing-timer system is initialized (registers callbacks + warms internal state).
        if NAG and NAG.AutoTimeToNext then
            NAG:AutoTimeToNext()
        end

        local now = _G.GetTime()

        -- Choose the soonest valid swing (MH/OH). Some libs report OH expiration even when OH speed is 0 (e.g., Druids).
        local mhSpeed, mhExpiration, mhLastSwing = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
        local ohSpeed, ohExpiration, ohLastSwing = swingTimerLib:UnitSwingTimerInfo("player", "offhand")

        local function ComputeTimeToNextSwing(speed, expiration, lastSwing, nowTime, allowWrap)
            speed = tonumber(speed) or 0
            expiration = tonumber(expiration)
            lastSwing = tonumber(lastSwing)
            if speed <= 0 or not expiration then
                return nil
            end

            -- IMPORTANT:
            -- LibClassicSwingTimerAPI seeds expiration on login and may leave stale values around.
            -- We should only treat the timer as "real" if it looks recent.
            if lastSwing and (nowTime - lastSwing) > (speed * 2.0 + 0.25) then
                return nil
            end

            local ttn = expiration - nowTime

            -- Allow small negative drift; but never "wrap forever" (that makes stale expirations look valid forever).
            -- If we're more than one swing behind, consider it invalid and hide the overlay.
            if ttn < -0.10 then
                if allowWrap and (-ttn) < (speed + 0.10) then
                    ttn = ttn + speed
                else
                    return nil
                end
            end

            return ttn
        end

        local allowWrap = isInMeleeRange and isActuallyAttacking
        local mhTTN = ComputeTimeToNextSwing(mhSpeed, mhExpiration, mhLastSwing, now, allowWrap)
        local ohTTN = ComputeTimeToNextSwing(ohSpeed, ohExpiration, ohLastSwing, now, allowWrap)

        local speed, expiration, lastSwing, timeToNext
        if mhTTN and ohTTN then
            if ohTTN < mhTTN then
                speed, expiration, lastSwing, timeToNext = ohSpeed, ohExpiration, ohLastSwing, ohTTN
            else
                speed, expiration, lastSwing, timeToNext = mhSpeed, mhExpiration, mhLastSwing, mhTTN
            end
        elseif mhTTN then
            speed, expiration, lastSwing, timeToNext = mhSpeed, mhExpiration, mhLastSwing, mhTTN
        elseif ohTTN then
            speed, expiration, lastSwing, timeToNext = ohSpeed, ohExpiration, ohLastSwing, ohTTN
        else
            if frame.swingHoldCooldown then
                frame.swingHoldCooldown:Hide()
            end
            frame._swingHoldSweepActive = false
            frame._swingHoldLastSwing = nil
            frame._swingHoldLastExpiration = nil
            return
        end

        if not timeToNext or timeToNext <= 0.05 then
            if frame.swingHoldCooldown then
                frame.swingHoldCooldown:Hide()
            end
            frame._swingHoldSweepActive = false
            frame._swingHoldLastSwing = nil
            frame._swingHoldLastExpiration = nil
            return
        end

        -- Ensure frame exists
        if not frame.swingHoldCooldown then
            frame.swingHoldCooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
            frame.swingHoldCooldown:SetAllPoints(frame)
            -- Temporary: crank frame level + use a loud color so it's impossible to miss while debugging.
            frame.swingHoldCooldown:SetFrameLevel(frame:GetFrameLevel() + 6)
            frame.swingHoldCooldown:SetDrawBling(false)
            frame.swingHoldCooldown:SetDrawEdge(false)
            if frame.swingHoldCooldown.SetDrawSwipe then
                frame.swingHoldCooldown:SetDrawSwipe(true)
            end
            frame.swingHoldCooldown:SetSwipeColor(1, 0, 0, 0.75 * CUSTOM_SWIPE_ALPHA_MULTIPLIER)
            if frame.swingHoldCooldown.SetReverse then
                frame.swingHoldCooldown:SetReverse(true)
            end
            if frame.swingHoldCooldown.SetHideCountdownNumbers then
                frame.swingHoldCooldown:SetHideCountdownNumbers(true)
            end
        end

        -- Only reset the swipe when the expiration changes meaningfully (i.e., a new swing starts).
        local eps = 0.02
        local lastExp = frame._swingHoldLastExpiration
        local expChanged = (not lastExp) or (math.abs(expiration - lastExp) > eps)
        if (not frame._swingHoldSweepActive) or expChanged then
            frame._swingHoldSweepActive = true
            frame._swingHoldLastSwing = lastSwing
            frame._swingHoldLastExpiration = expiration
            -- Drive the swipe as a countdown "from now until the next swing".
            frame.swingHoldCooldown:SetCooldown(now, timeToNext)
        end

        -- Suppress the normal cooldown swipe (GCD/cooldown overlay) on the same icon while swing swipe is active.
        if frame.cooldown and frame.cooldown.Hide then
            frame.cooldown:Hide()
        end

        frame.swingHoldCooldown:Show()
    end


    local RET_TWIST_HOLD_CUE_SECONDS = 0.1
    local RET_TWIST_WINDOW_SECONDS = 0.4
    local retTwistHoldCueLastSoundAt = 0

    local function getRetTwistHoldCueModule()
        local module = ns.PaladinRetTwistModule
        if not module and NAG and NAG.GetModule then
            module = NAG:GetModule("PaladinRetTwistModule", true)
        end
        return module
    end

    local function getRetTwistHoldCueSettings()
        local module = getRetTwistHoldCueModule()
        if not module or not module.db or not module.db.class then
            return nil
        end
        return module.db.class
    end

    local function stopRetTwistHoldCueGlow(frame)
        if not frame then
            return
        end
        frame._retTwistHoldCueTriggered = false
        frame._retTwistHoldCueGlowActive = false
        frame._retTwistHoldCueSpellId = nil
        local glowType = frame._retTwistHoldCueGlowType
        if frame._retTwistHoldCueGlowUntil then
            frame._retTwistHoldCueGlowUntil = nil
        end
        if LCG then
            if glowType == "Pixel Glow" and LCG.PixelGlow_Stop then
                LCG.PixelGlow_Stop(frame, "retTwistHoldCue")
            elseif glowType == "Button Glow" and LCG.ButtonGlow_Stop then
                LCG.ButtonGlow_Stop(frame)
            elseif glowType == "Proc Glow" and LCG.ProcGlow_Stop then
                LCG.ProcGlow_Stop(frame, "retTwistHoldCue")
            elseif LCG.AutoCastGlow_Stop then
                LCG.AutoCastGlow_Stop(frame, "retTwistHoldCue")
            end
        end
        frame._retTwistHoldCueGlowType = nil
    end

    local function startRetTwistHoldCueGlow(frame, glowType, scale)
        if not frame or not LCG then
            return
        end
        local color = { 0.95, 0.85, 0.30, 1.0 }
        local clampedScale = tonumber(scale) or 1.0
        if clampedScale < 0.5 then clampedScale = 0.5 end
        if clampedScale > 2.5 then clampedScale = 2.5 end

        if glowType == "Pixel Glow" and LCG.PixelGlow_Start then
            local thickness = math.max(1, math.floor(clampedScale * 2))
            LCG.PixelGlow_Start(frame, color, 8, 0.25, nil, thickness, 0, 0, nil, "retTwistHoldCue", 6)
            frame._retTwistHoldCueGlowType = "Pixel Glow"
            return
        end

        if glowType == "Button Glow" and LCG.ButtonGlow_Start then
            LCG.ButtonGlow_Start(frame, color, 0.25, 6)
            frame._retTwistHoldCueGlowType = "Button Glow"
            return
        end

        if glowType == "Proc Glow" and LCG.ProcGlow_Start then
            local width, height = frame:GetSize()
            local extra = math.max(0, clampedScale - 1) * 0.2
            local offsetX = (width or 0) * extra
            local offsetY = (height or 0) * extra
            LCG.ProcGlow_Start(frame, {
                color = color,
                frameLevel = 6,
                xOffset = offsetX,
                yOffset = offsetY,
                key = "retTwistHoldCue",
            })
            frame._retTwistHoldCueGlowType = "Proc Glow"
            return
        end

        if LCG.AutoCastGlow_Start then
            LCG.AutoCastGlow_Start(frame, color, 4, 0.12, clampedScale, 0, 0, "retTwistHoldCue", 6)
            frame._retTwistHoldCueGlowType = "Autocast Shine"
        end
    end

    local function maintainRetTwistHoldCueGlow(frame, spellId)
        if not frame then
            return
        end
        local glowUntil = frame._retTwistHoldCueGlowUntil
        if not glowUntil then
            return
        end
        if frame._retTwistHoldCueSpellId and spellId and frame._retTwistHoldCueSpellId ~= spellId then
            stopRetTwistHoldCueGlow(frame)
            return
        end
        local now = GetTime()
        if now >= glowUntil then
            stopRetTwistHoldCueGlow(frame)
        end
    end

    local function updateRetTwistHoldCue(frame, spellId, holdSeconds)
        local settings = getRetTwistHoldCueSettings()
        if not settings then
            stopRetTwistHoldCueGlow(frame)
            return
        end

        local soundEnabled = settings.holdCueSoundEnabled
        local shineEnabled = settings.holdCueShineEnabled
        if not soundEnabled and not shineEnabled then
            stopRetTwistHoldCueGlow(frame)
            return
        end

        if not holdSeconds or holdSeconds <= 0 then
            frame._retTwistHoldCueTriggered = false
            maintainRetTwistHoldCueGlow(frame, spellId)
            return
        end

        local now = GetTime()
        maintainRetTwistHoldCueGlow(frame, spellId)

        local leadSeconds = tonumber(settings.holdCueLeadTimeSeconds) or RET_TWIST_HOLD_CUE_SECONDS
        if leadSeconds < 0 then leadSeconds = 0 end
        if leadSeconds > RET_TWIST_WINDOW_SECONDS then leadSeconds = RET_TWIST_WINDOW_SECONDS end

        if holdSeconds and holdSeconds > 0 and holdSeconds <= leadSeconds then
            if not frame._retTwistHoldCueTriggered then
                frame._retTwistHoldCueTriggered = true

                if soundEnabled then
                    if (now - retTwistHoldCueLastSoundAt) >= 0.05 then
                        local module = getRetTwistHoldCueModule()
                        if module and module.PlayHoldCueSound then
                            local played = module:PlayHoldCueSound(settings.holdCueSound, "combat")
                            if played then
                                retTwistHoldCueLastSoundAt = now
                            end
                        end
                    end
                end

                if shineEnabled then
                    local glowType = settings.holdCueShineType or "Autocast Shine"
                    local glowScale = settings.holdCueShineScale or 1.0
                    startRetTwistHoldCueGlow(frame, glowType, glowScale)
                    frame._retTwistHoldCueGlowActive = true
                    frame._retTwistHoldCueSpellId = spellId
                    frame._retTwistHoldCueGlowUntil = now + math.max(0, holdSeconds + RET_TWIST_WINDOW_SECONDS)
                end
            end
        else
            if frame._retTwistHoldCueTriggered then
                frame._retTwistHoldCueTriggered = false
            end
        end
    end

    --- Show/hide a Ret twist HOLD countdown sweep on the icon frame.
    --- Uses CooldownFrameTemplate to create a clockwise swipe animation.
    --- @param spellId number
    --- @param position string
    --- @param overlayText string
    function DisplayManager:UpdateRetTwistHoldSweep(spellId, position, overlayText, frameOverride)
        if not spellId then
            return
        end

        local frame = frameOverride
        if not frame then
            if not position then return end
            if not NAG or not NAG.Frame or not NAG.Frame.iconFrames then return end
            frame = NAG.Frame.iconFrames[position]
        end
        if not frame then return end

        -- On-demand custom HOLD swipe path is authoritative for Judge/SoC setup holds.
        -- If a custom swipe is active for this frame/position, suppress the legacy RetTwist
        -- sweep path to avoid two cooldown frames competing and causing flicker/stutter.
        local resolvedPosition = position or frame._nagPosition or ns.SPELL_POSITIONS.PRIMARY
        local retSwipeSmoothBase = "retTwist:" .. tostring(resolvedPosition) .. ":" .. tostring(spellId)
        local burstSmoothKey = retSwipeSmoothBase .. ":burst"
        local judgeSmoothKey = retSwipeSmoothBase .. ":judge"
        local genericSmoothKey = retSwipeSmoothBase .. ":generic"
        local customState = self.GetCustomHoldSwipe and self:GetCustomHoldSwipe(spellId, resolvedPosition) or nil
        if frame._retTwistSwipeSmoothKeys then
            local hasCurrent = false
            for _, existingKey in ipairs(frame._retTwistSwipeSmoothKeys) do
                if existingKey == burstSmoothKey or existingKey == judgeSmoothKey or existingKey == genericSmoothKey then
                    hasCurrent = true
                    break
                end
            end
            if not hasCurrent then
                ClearFrameRetTwistSwipeSmoothKeys(frame)
            end
        end
        frame._retTwistSwipeSmoothKeys = { burstSmoothKey, judgeSmoothKey, genericSmoothKey }
        if customState then
            if frame.retwistHoldCooldown then
                frame.retwistHoldCooldown:Hide()
            end
            frame._retTwistHoldSweepActive = false
            frame._retTwistHoldSweepSpellId = nil
            frame._retTwistJudgeHoldEndAt = nil
            frame._retTwistJudgeHoldToken = nil
            ClearRetTwistSwipeSmoothState(burstSmoothKey)
            ClearRetTwistSwipeSmoothState(judgeSmoothKey)
            ClearRetTwistSwipeSmoothState(genericSmoothKey)
            frame._retTwistSwipeSmoothKeys = nil
            return
        end

        -- Check for HOLD state on twist seals OR BURST state on Avenging Wrath
        local soCSealId = (NAG.RetTwistGetSoCSealId and NAG:RetTwistGetSoCSealId()) or nil
        local isTwistSeal = (spellId == 31892) or (spellId == 348700) or (spellId == 20154) or (spellId == 21084) or (spellId == 20293)
            or (soCSealId and spellId == soCSealId)
        local isBurstHold = (overlayText == "Burst and\nTwist") and (spellId == 31884)
        local isHold = (string.sub(overlayText or "", 1, 4) == "HOLD") and isTwistSeal
        local isJudgeHold = (string.sub(overlayText or "", 1, 4) == "HOLD") and (spellId == 20271)
        local now = (_G.GetTime and _G.GetTime()) or 0
        if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and (spellId == 20271) then
            local shouldHold = (NAG._retTwistJudgeHoldEndAt and (NAG._retTwistJudgeHoldEndAt > now)) or false
            if false and shouldHold and not isJudgeHold then
                local dbgLastAt = NAG._retTwistJudgeHoldSwipeMissingLastAt or 0
                if (now - dbgLastAt) >= 0.25 then
                    print(string.format(
                        "[JUDGE_HOLD_SWIPE_GATING][ver=1.0.0] missingHoldOverlayText=true overlayText=%s holdRemaining=%.3f token=%d",
                        tostring(overlayText),
                        (NAG._retTwistJudgeHoldEndAt - now),
                        NAG._retTwistJudgeHoldToken or 0
                    ))
                    NAG._retTwistJudgeHoldSwipeMissingLastAt = now
                end
            end
        end

        -- Handle burst variant: create swipe spanning PRIMARY and AOE frames
        if isBurstHold then
            if not NAG.RetTwistTimeToTwistWindow then return end

            local rawHoldSeconds = NAG:RetTwistTimeToTwistWindow(0.4) or 0
            local holdSeconds = GetSmoothedRetTwistSwipeSeconds(burstSmoothKey, rawHoldSeconds, now, nil)
            local burstHoldSwipeAlpha = 0.5
            updateRetTwistHoldCue(frame, spellId, holdSeconds)

            if holdSeconds <= 0.05 then
                -- Hide swipe on both frames if active
                if frame.retwistHoldCooldown then
                    frame.retwistHoldCooldown:Hide()
                end
                local aoeFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE]
                if aoeFrame and aoeFrame.retwistHoldCooldown then
                    aoeFrame.retwistHoldCooldown:Hide()
                end
                frame._retTwistHoldSweepActive = false
                frame._retTwistHoldSweepSpellId = nil
                frame._retTwistHoldCueTriggered = false
                ClearRetTwistSwipeSmoothState(burstSmoothKey)
                frame._retTwistSwipeSmoothKeys = nil
                maintainRetTwistHoldCueGlow(frame, spellId)
                return
            end

            -- Get PRIMARY and AOE frames
            local primaryFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]
            local aoeFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE]
            if not primaryFrame or not aoeFrame then
                return
            end

            -- Get parent frame (both PRIMARY and AOE share the same parent)
            local parentFrame = primaryFrame:GetParent()
            if not parentFrame then
                return
            end

            -- Create or update swipe overlay as child of parent frame, sized to span both
            -- Store reference on PRIMARY frame for cleanup, but parent to shared parent
            if not frame.retwistHoldCooldown then
                frame.retwistHoldCooldown = CreateFrame("Cooldown", nil, parentFrame, "CooldownFrameTemplate")
                frame.retwistHoldCooldown:SetFrameLevel(max(primaryFrame:GetFrameLevel(), aoeFrame:GetFrameLevel()) + 6)
                frame.retwistHoldCooldown:SetDrawBling(false)
                frame.retwistHoldCooldown:SetDrawEdge(false)
                frame.retwistHoldCooldown:SetSwipeColor(0, 0, 0, burstHoldSwipeAlpha)
                if frame.retwistHoldCooldown.SetDrawSwipe then
                    frame.retwistHoldCooldown:SetDrawSwipe(true)
                end
                if frame.retwistHoldCooldown.SetReverse then
                    frame.retwistHoldCooldown:SetReverse(false) -- start dark, reveal icon as twist window approaches
                end
                if frame.retwistHoldCooldown.SetHideCountdownNumbers then
                    frame.retwistHoldCooldown:SetHideCountdownNumbers(true)
                end
            end

            -- NOTE: In the current layout, the AOE icon is right-aligned to PRIMARY's right edge
            -- and typically overlaps inside PRIMARY's bounds (AOE width is scaled by frameWeight).
            -- So the sweep should match PRIMARY's bounds to visually cover both icons.
            frame.retwistHoldCooldown:ClearAllPoints()
            frame.retwistHoldCooldown:SetAllPoints(primaryFrame)
            frame.retwistHoldCooldown:SetFrameLevel(max(primaryFrame:GetFrameLevel(), aoeFrame:GetFrameLevel()) + 6)
            frame.retwistHoldCooldown:SetSwipeColor(0, 0, 0, burstHoldSwipeAlpha)
            if frame.retwistHoldCooldown.SetDrawSwipe then
                frame.retwistHoldCooldown:SetDrawSwipe(true)
            end
            if frame.retwistHoldCooldown.SetReverse then
                frame.retwistHoldCooldown:SetReverse(false) -- start dark, reveal icon as twist window approaches
            end
            if self:IsRoundMaskPreviewEnabled() and self:IsLegacyFrameEnabled() and frame.retwistHoldCooldown.SetSwipeTexture then
                local swipeMask = self:GetRoundPreviewMaskTextureForPosition(ns.SPELL_POSITIONS.PRIMARY) or CIRCLE_MASK_TEXTURE
                frame.retwistHoldCooldown:SetSwipeTexture(swipeMask)
            end

            -- Only initialize the sweep once per HOLD phase; let it animate naturally.
            if not frame._retTwistHoldSweepActive or frame._retTwistHoldSweepSpellId ~= spellId then
                frame._retTwistHoldSweepActive = true
                frame._retTwistHoldSweepSpellId = spellId
                local cdStart, cdDur = _G.GetTime(), holdSeconds
                frame._retTwistHoldCooldownStart = cdStart
                frame._retTwistHoldCooldownDuration = cdDur
                frame._retTwistHoldCooldownReverse = false
                frame.retwistHoldCooldown:SetCooldown(cdStart, cdDur)
            end

            -- Suppress normal cooldown swipes on both frames
            if frame.cooldown and frame.cooldown.Hide then
                frame.cooldown:Hide()
            end
            if aoeFrame.cooldown and aoeFrame.cooldown.Hide then
                aoeFrame.cooldown:Hide()
            end

            frame.retwistHoldCooldown:Show()
            return
        end

        -- Judge HOLD logic: keep swipe on PRIMARY, but elevate frame level high enough
        -- to remain visible even when AOE slot is also populated.
        if isJudgeHold then
            local holdEndAt = NAG._retTwistJudgeHoldEndAt or 0
            local rawHoldSeconds = (holdEndAt > now) and (holdEndAt - now) or 0
            local holdSeconds = GetSmoothedRetTwistSwipeSeconds(judgeSmoothKey, rawHoldSeconds, now, nil)
            local holdToken = NAG._retTwistJudgeHoldToken or 0
            local judgeHoldSwipeAlpha = 0.5
            if holdSeconds <= 0.05 then
                if frame.retwistHoldCooldown then
                    frame.retwistHoldCooldown:Hide()
                end
                frame._retTwistHoldSweepActive = false
                frame._retTwistHoldSweepSpellId = nil
                frame._retTwistJudgeHoldEndAt = nil
                frame._retTwistJudgeHoldToken = nil
                frame._retTwistHoldCueTriggered = false
                ClearRetTwistSwipeSmoothState(judgeSmoothKey)
                frame._retTwistSwipeSmoothKeys = nil
                maintainRetTwistHoldCueGlow(frame, spellId)
                return
            end

            local primaryFrame = frame
            local aoeFrame = NAG.Frame and NAG.Frame.iconFrames and NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE] or nil
            local parentFrame = primaryFrame:GetParent() or primaryFrame
            local targetLevel = primaryFrame:GetFrameLevel()
            if aoeFrame and aoeFrame.GetFrameLevel then
                targetLevel = max(targetLevel, aoeFrame:GetFrameLevel())
            end

            if not frame.retwistHoldCooldown then
                frame.retwistHoldCooldown = CreateFrame("Cooldown", nil, parentFrame, "CooldownFrameTemplate")
                frame.retwistHoldCooldown:SetDrawBling(false)
                frame.retwistHoldCooldown:SetDrawEdge(false)
                if frame.retwistHoldCooldown.SetHideCountdownNumbers then
                    frame.retwistHoldCooldown:SetHideCountdownNumbers(true)
                end
            elseif frame.retwistHoldCooldown:GetParent() ~= parentFrame then
                frame.retwistHoldCooldown:SetParent(parentFrame)
            end

            -- Judge HOLD should start dark and reveal the icon as the hold counts down.
            if frame.retwistHoldCooldown.SetDrawSwipe then
                frame.retwistHoldCooldown:SetDrawSwipe(true)
            end
            frame.retwistHoldCooldown:SetSwipeColor(0, 0, 0, judgeHoldSwipeAlpha)
            if frame.retwistHoldCooldown.SetReverse then
                frame.retwistHoldCooldown:SetReverse(false)
            end

            frame.retwistHoldCooldown:SetFrameLevel(targetLevel + 6)
            frame.retwistHoldCooldown:ClearAllPoints()
            frame.retwistHoldCooldown:SetAllPoints(primaryFrame)
            if self:IsRoundMaskPreviewEnabled() and self:IsLegacyFrameEnabled() and frame.retwistHoldCooldown.SetSwipeTexture then
                local swipeMask = self:GetRoundPreviewMaskTextureForPosition(ns.SPELL_POSITIONS.PRIMARY) or CIRCLE_MASK_TEXTURE
                frame.retwistHoldCooldown:SetSwipeTexture(swipeMask)
            end

            -- Only initialize when entering a new Judge HOLD phase (token), or when spell changes.
            local shouldInitialize = (not frame._retTwistHoldSweepActive)
                or (frame._retTwistHoldSweepSpellId ~= spellId)
                or (frame._retTwistJudgeHoldToken ~= holdToken)

            if shouldInitialize then
                frame._retTwistHoldSweepActive = true
                frame._retTwistHoldSweepSpellId = spellId
                frame._retTwistJudgeHoldEndAt = holdEndAt
                frame._retTwistJudgeHoldToken = holdToken
                frame._retTwistHoldCooldownStart = now
                frame._retTwistHoldCooldownDuration = holdSeconds
                frame._retTwistHoldCooldownReverse = false
                frame.retwistHoldCooldown:SetCooldown(now, holdSeconds)
            end

            if primaryFrame.cooldown and primaryFrame.cooldown.Hide then
                primaryFrame.cooldown:Hide()
            end
            if aoeFrame and aoeFrame.cooldown and aoeFrame.cooldown.Hide then
                aoeFrame.cooldown:Hide()
            end

            frame.retwistHoldCooldown:Show()
            return
        end

        -- Original HOLD logic for twist seals
        if not isHold and not isJudgeHold then
            if frame.retwistHoldCooldown then
                frame.retwistHoldCooldown:Hide()
            end
            frame._retTwistHoldSweepActive = false
            frame._retTwistHoldSweepSpellId = nil
            frame._retTwistJudgeHoldEndAt = nil
            frame._retTwistJudgeHoldToken = nil
            frame._retTwistHoldCueTriggered = false
            ClearRetTwistSwipeSmoothState(burstSmoothKey)
            ClearRetTwistSwipeSmoothState(judgeSmoothKey)
            ClearRetTwistSwipeSmoothState(genericSmoothKey)
            frame._retTwistSwipeSmoothKeys = nil
            maintainRetTwistHoldCueGlow(frame, spellId)
            return
        end

        local holdSeconds = 0
        -- SoB/SoM HOLD should start fully dark and reveal over time.
        local genericHoldSwipeAlpha = 0.5
        -- Prefer explicit HOLD duration encoded in overlay text (e.g. "HOLD\n1.2s"),
        -- so SoB->SoC next-swing holds don't get remapped to twist-gap timing here.
        local holdSecondsFromOverlay = tonumber(string.match(overlayText or "", "^HOLD\n([%d%.]+)s$"))
        if holdSecondsFromOverlay and holdSecondsFromOverlay > 0 then
            holdSeconds = holdSecondsFromOverlay
            ClearRetTwistSwipeSmoothState(genericSmoothKey)
        elseif NAG.RetTwistTimeToTwistWindow then
            local rawHoldSeconds = NAG:RetTwistTimeToTwistWindow(0.4) or 0
            holdSeconds = GetSmoothedRetTwistSwipeSeconds(genericSmoothKey, rawHoldSeconds, now, nil)
        end
        updateRetTwistHoldCue(frame, spellId, holdSeconds)
        if holdSeconds <= 0.05 then
            if frame.retwistHoldCooldown then
                frame.retwistHoldCooldown:Hide()
            end
            frame._retTwistHoldSweepActive = false
            frame._retTwistHoldSweepSpellId = nil
            frame._retTwistHoldCueTriggered = false
            ClearRetTwistSwipeSmoothState(genericSmoothKey)
            frame._retTwistSwipeSmoothKeys = nil
            maintainRetTwistHoldCueGlow(frame, spellId)
            return
        end

        if not frame.retwistHoldCooldown then
            frame.retwistHoldCooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
            frame.retwistHoldCooldown:SetAllPoints(frame)
            frame.retwistHoldCooldown:SetFrameLevel(frame:GetFrameLevel() + 6)
            frame.retwistHoldCooldown:SetDrawBling(false)
            frame.retwistHoldCooldown:SetDrawEdge(false)
            frame.retwistHoldCooldown:SetSwipeColor(0, 0, 0, genericHoldSwipeAlpha)
            if frame.retwistHoldCooldown.SetDrawSwipe then
                frame.retwistHoldCooldown:SetDrawSwipe(true)
            end
            if frame.retwistHoldCooldown.SetReverse then
                frame.retwistHoldCooldown:SetReverse(false) -- start dark, reveal icon as HOLD counts down
            end
            if frame.retwistHoldCooldown.SetHideCountdownNumbers then
                frame.retwistHoldCooldown:SetHideCountdownNumbers(true)
            end
        end
        frame.retwistHoldCooldown:SetFrameLevel(frame:GetFrameLevel() + 6)
        frame.retwistHoldCooldown:SetSwipeColor(0, 0, 0, genericHoldSwipeAlpha)
        if frame.retwistHoldCooldown.SetDrawSwipe then
            frame.retwistHoldCooldown:SetDrawSwipe(true)
        end
        if frame.retwistHoldCooldown.SetReverse then
            frame.retwistHoldCooldown:SetReverse(false)
        end
        if self:IsRoundMaskPreviewEnabled() and self:IsLegacyFrameEnabled() and frame.retwistHoldCooldown.SetSwipeTexture then
            local pos = frame._nagPosition or ns.SPELL_POSITIONS.PRIMARY
            local swipeMask = self:GetRoundPreviewMaskTextureForPosition(pos) or CIRCLE_MASK_TEXTURE
            frame.retwistHoldCooldown:SetSwipeTexture(swipeMask)
        end

        -- Only initialize the sweep once per HOLD phase; let it animate naturally.
        if not frame._retTwistHoldSweepActive or frame._retTwistHoldSweepSpellId ~= spellId then
            frame._retTwistHoldSweepActive = true
            frame._retTwistHoldSweepSpellId = spellId
            local cdStart, cdDur = _G.GetTime(), holdSeconds
            frame._retTwistHoldCooldownStart = cdStart
            frame._retTwistHoldCooldownDuration = cdDur
            frame._retTwistHoldCooldownReverse = false
            frame.retwistHoldCooldown:SetCooldown(cdStart, cdDur)
        end

        -- If the HOLD swipe is active, suppress the normal cooldown swipe (GCD overlay) on the same icon.
        -- This keeps the HOLD visualization clean and avoids two overlapping swipes.
        if frame.cooldown and frame.cooldown.Hide then
            frame.cooldown:Hide()
        end

        frame.retwistHoldCooldown:Show()
    end

    --- Show/hide a Hunter Steady HOLD countdown sweep on the PRIMARY icon frame.
    --- Uses CooldownFrameTemplate to create a clockwise swipe animation.
    --- Triggered via CastSpell overlayText marker "HOLD_SS" for Steady Shot (34120).
    --- @param spellId number
    --- @param position string
    --- @param overlayText string
    --- @param frameOverride Frame|nil
    function DisplayManager:UpdateHunterSteadyHoldSweep(spellId, position, overlayText, frameOverride)
        if spellId ~= 34120 then
            return
        end

        -- TEMPORARY (Hunter):
        -- Disable Hunter HOLD swipes; they interfere with GCD swipe timing and feel wrong with current queue/busy logic.
        -- Keep other class HOLD systems intact (e.g., Ret twist).
        if overlayText == "HOLD_SS" then
            local frame = frameOverride
            if not frame then
                if not position then return end
                if not NAG or not NAG.Frame or not NAG.Frame.iconFrames then return end
                frame = NAG.Frame.iconFrames[position]
            end
            if not frame then return end
            if frame.hunterSteadyHoldCooldown then
                frame.hunterSteadyHoldCooldown:Hide()
            end
            frame._hunterSteadyHoldSweepActive = false
            frame._hunterSteadyHoldEndTime = nil
            return
        end

        local frame = frameOverride
        if not frame then
            if not position then return end
            if not NAG or not NAG.Frame or not NAG.Frame.iconFrames then return end
            frame = NAG.Frame.iconFrames[position]
        end
        if not frame then return end

        local isHold = (overlayText == "HOLD_SS")
        if not isHold then
            if frame.hunterSteadyHoldCooldown then
                frame.hunterSteadyHoldCooldown:Hide()
            end
            frame._hunterSteadyHoldSweepActive = false
            frame._hunterSteadyHoldEndTime = nil
            return
        end

        if not NAG.HunterSteadyTimeToSafeStart then
            return
        end

        local holdSeconds = NAG:HunterSteadyTimeToSafeStart() or 0
        if holdSeconds <= 0.05 then
            if frame.hunterSteadyHoldCooldown then
                frame.hunterSteadyHoldCooldown:Hide()
            end
            frame._hunterSteadyHoldSweepActive = false
            frame._hunterSteadyHoldEndTime = nil
            return
        end

        if not frame.hunterSteadyHoldCooldown then
            frame.hunterSteadyHoldCooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
            frame.hunterSteadyHoldCooldown:SetAllPoints(frame)
            frame.hunterSteadyHoldCooldown:SetFrameLevel(frame:GetFrameLevel() + 6)
            frame.hunterSteadyHoldCooldown:SetDrawBling(false)
            frame.hunterSteadyHoldCooldown:SetDrawEdge(false)
            frame.hunterSteadyHoldCooldown:SetSwipeColor(0, 0, 0, 0.55 * CUSTOM_SWIPE_ALPHA_MULTIPLIER)
            if frame.hunterSteadyHoldCooldown.SetReverse then
                frame.hunterSteadyHoldCooldown:SetReverse(true) -- force clockwise-style sweep
            end
            if frame.hunterSteadyHoldCooldown.SetHideCountdownNumbers then
                frame.hunterSteadyHoldCooldown:SetHideCountdownNumbers(true)
            end
        end

        -- IMPORTANT:
        -- Do NOT call SetCooldown every tick (it restarts the swipe repeatedly and looks like multiple swipes).
        -- Instead, lock onto an end time and only re-seed if that end time changes meaningfully.
        local now = _G.GetTime()
        local endTime = now + holdSeconds
        local lastEndTime = frame._hunterSteadyHoldEndTime
        local shouldSeed = (not frame._hunterSteadyHoldSweepActive) or (not lastEndTime) or (math.abs(endTime - lastEndTime) > 0.05)
        if shouldSeed then
            frame._hunterSteadyHoldSweepActive = true
            frame._hunterSteadyHoldEndTime = endTime
            frame.hunterSteadyHoldCooldown:SetCooldown(now, holdSeconds)
        end

        -- Suppress the normal cooldown swipe (GCD/cooldown overlay) on the same icon while HOLD is active.
        if frame.cooldown and frame.cooldown.Hide then
            frame.cooldown:Hide()
        end

        frame.hunterSteadyHoldCooldown:Show()
    end

    --- Show/hide a Hunter Multi HOLD countdown sweep on the icon frame.
    --- Uses CooldownFrameTemplate to create a clockwise swipe animation.
    --- Triggered via CastSpell overlayText marker "HOLD_MS" for Multi-Shot (27021).
    --- @param spellId number
    --- @param position string
    --- @param overlayText string
    --- @param frameOverride Frame|nil
    function DisplayManager:UpdateHunterMultiHoldSweep(spellId, position, overlayText, frameOverride)
        if spellId ~= 27021 then
            return
        end

        -- TEMPORARY (Hunter):
        -- Disable Hunter HOLD swipes; see UpdateHunterSteadyHoldSweep note above.
        if overlayText == "HOLD_MS" then
            local frame = frameOverride
            if not frame then
                if not position then return end
                if not NAG or not NAG.Frame or not NAG.Frame.iconFrames then return end
                frame = NAG.Frame.iconFrames[position]
            end
            if not frame then return end
            if frame.hunterMultiHoldCooldown then
                frame.hunterMultiHoldCooldown:Hide()
            end
            frame._hunterMultiHoldSweepActive = false
            frame._hunterMultiHoldEndTime = nil
            return
        end

        local frame = frameOverride
        if not frame then
            if not position then return end
            if not NAG or not NAG.Frame or not NAG.Frame.iconFrames then return end
            frame = NAG.Frame.iconFrames[position]
        end
        if not frame then return end

        local isHold = (overlayText == "HOLD_MS")
        if not isHold then
            if frame.hunterMultiHoldCooldown then
                frame.hunterMultiHoldCooldown:Hide()
            end
            frame._hunterMultiHoldSweepActive = false
            frame._hunterMultiHoldEndTime = nil
            return
        end

        if not NAG.HunterMSTimeToSafeStart then
            return
        end

        local holdSeconds = NAG:HunterMSTimeToSafeStart() or 0
        if holdSeconds <= 0.05 then
            if frame.hunterMultiHoldCooldown then
                frame.hunterMultiHoldCooldown:Hide()
            end
            frame._hunterMultiHoldSweepActive = false
            frame._hunterMultiHoldEndTime = nil
            return
        end

        if not frame.hunterMultiHoldCooldown then
            frame.hunterMultiHoldCooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
            frame.hunterMultiHoldCooldown:SetAllPoints(frame)
            frame.hunterMultiHoldCooldown:SetFrameLevel(frame:GetFrameLevel() + 6)
            frame.hunterMultiHoldCooldown:SetDrawBling(false)
            frame.hunterMultiHoldCooldown:SetDrawEdge(false)
            frame.hunterMultiHoldCooldown:SetSwipeColor(0, 0, 0, 0.55 * CUSTOM_SWIPE_ALPHA_MULTIPLIER)
            if frame.hunterMultiHoldCooldown.SetReverse then
                frame.hunterMultiHoldCooldown:SetReverse(true)
            end
            if frame.hunterMultiHoldCooldown.SetHideCountdownNumbers then
                frame.hunterMultiHoldCooldown:SetHideCountdownNumbers(true)
            end
        end

        local now = _G.GetTime()
        local endTime = now + holdSeconds
        local lastEndTime = frame._hunterMultiHoldEndTime
        local shouldSeed = (not frame._hunterMultiHoldSweepActive) or (not lastEndTime) or (math.abs(endTime - lastEndTime) > 0.05)
        if shouldSeed then
            frame._hunterMultiHoldSweepActive = true
            frame._hunterMultiHoldEndTime = endTime
            frame.hunterMultiHoldCooldown:SetCooldown(now, holdSeconds)
        end

        if frame.cooldown and frame.cooldown.Hide then
            frame.cooldown:Hide()
        end

        frame.hunterMultiHoldCooldown:Show()
    end

    --- Update cooldown and charge overlays for primary icon
    --- @param frame Frame The icon frame to update
    function DisplayManager:UpdatePrimaryIconOverlays(frame)
        local customStateBefore = nil
        if frame and frame.spellId then
            customStateBefore = self:GetCustomHoldSwipe(frame.spellId, frame._nagPosition or ns.SPELL_POSITIONS.PRIMARY)
        end
        local customHoldSwipeActive = self:ApplyCustomHoldSwipe(frame)
        if customStateBefore and (not customHoldSwipeActive) and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
            local now = (_G.GetTime and _G.GetTime()) or 0
            local dbgLastAt = frame and frame._customHoldSwipeFailDbgAt or 0
            if (now - dbgLastAt) >= 0.25 then
                -- print(string.format(
                --     "[CUSTOM_HOLD_SWIPE][ver=%s] action=inactive_with_state spell=%s pos=%s stateEndIn=%.3f",
                --     CUSTOM_HOLD_SWIPE_LOG_VERSION,
                --     tostring(frame and frame.spellId),
                --     tostring(frame and (frame._nagPosition or ns.SPELL_POSITIONS.PRIMARY)),
                --     math.max(0, (customStateBefore.endAt or now) - now)
                -- ))
                if frame then
                    frame._customHoldSwipeFailDbgAt = now
                end
            end
        end
        -- Update cooldown overlay only if enabled.
        -- TEMPORARY (Hunter):
        -- Previously, TBC Hunters hid cooldown/GCD swipes entirely in favor of custom weave visuals + HOLD swipes.
        -- Since Hunter HOLD swipes are currently disabled, we allow the normal cooldown/GCD swipe to show again.
        if customHoldSwipeActive then
            if frame.cooldown and frame.cooldown.Hide then
                frame.cooldown:Hide()
            end
        elseif self:AreCooldownSwipesEnabled() and frame.cooldown then
            local start, duration
            if frame.itemId then
                start, duration = GetItemCooldown(frame.itemId)
            elseif frame.spellId then
                local cdInfo = WoWAPI.GetSpellCooldown(frame.spellId)
                start, duration = cdInfo and cdInfo.startTime, cdInfo and cdInfo.duration
            end

            if start and duration and duration > 0 then
                frame.cooldown:SetCooldown(start, duration)
                frame.cooldown:Show()
                frame._lastCooldownStart = start
                frame._lastCooldownDuration = duration
            else
                frame.cooldown:Hide()
                frame._lastCooldownStart = nil
                frame._lastCooldownDuration = nil
            end
        end

    -- Update charges overlay
    if frame.spellId then
        local chargeInfo = WoWAPI.GetSpellCharges(frame.spellId)
        if chargeInfo and chargeInfo.maxCharges and chargeInfo.maxCharges > 1 then
            if frame.chargeText then
                frame.chargeText:SetText(chargeInfo.currentCharges or 0)
                frame.chargeText:Show()
            end
            -- Show charge cooldown if applicable
            if chargeInfo.cooldownStartTime and chargeInfo.cooldownDuration and
               (chargeInfo.currentCharges or 0) < chargeInfo.maxCharges and frame.cooldown and (not customHoldSwipeActive) then
                frame.cooldown:SetCooldown(chargeInfo.cooldownStartTime, chargeInfo.cooldownDuration)
                frame.cooldown:Show()
                frame._lastCooldownStart = chargeInfo.cooldownStartTime
                frame._lastCooldownDuration = chargeInfo.cooldownDuration
            end
        elseif frame.chargeText then
            frame.chargeText:Hide()
        end
    end
    if customHoldSwipeActive and frame.cooldown and frame.cooldown.Hide then
        frame.cooldown:Hide()
    end
    end

    --- Update keybind text for main display frames
    --- @param frame Frame The icon frame to update
    --- @param spellId number The spell ID to get keybind for
    function DisplayManager:UpdateMainFrameKeybind(frame, spellId)
        if not spellId then
            -- Hide keybind text if no spell
            if frame.keybindText then
                frame.keybindText:Hide()
            end
            return
        end

        -- Hard rule: always suppress keybinds on the AOE position/group
        -- (even if keybinds are enabled globally).
        if frame and (frame.groupKey == ns.SPELL_POSITIONS.AOE or frame._keybindGroupKey == "aoe") then
            if frame.keybindText then
                frame.keybindText:Hide()
            end
            return
        end

        -- Check if keybinds are enabled via KeybindManager
        local KeybindManager = NAG:GetModule("KeybindManager")
        local enableKeybinds = KeybindManager.db and KeybindManager.db.global.enableKeybinds
        if not enableKeybinds then
            if frame.keybindText then
                frame.keybindText:Hide()
            end
            return
        end

        -- Create keybind text element if it doesn't exist
        if not frame.keybindText then
            frame.keybindText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            frame.keybindText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
            frame.keybindText:SetJustifyH("RIGHT")
            frame.keybindText:SetTextColor(1, 1, 1)
        end

        -- Get keybind (tinkers: prefer item bind; user binds gloves, not spell)
        local KeybindManager = NAG:GetModule("KeybindManager")
        local keybind = ""
        if frame.itemId and KeybindManager.GetItemKeybind then
            keybind = KeybindManager:GetItemKeybind(frame.itemId) or ""
        end
        if keybind == "" and spellId and KeybindManager.GetSpellKeybind then
            keybind = KeybindManager:GetSpellKeybind(spellId) or ""
        end

        -- Update keybind text
        frame.keybindText:SetText(keybind)
        frame.keybindText:Show()
    end

    --- Batch clear all icon frames for better performance
    function DisplayManager:ClearAllIconFrames()
        if not NAG.Frame or not NAG.Frame.iconFrames then return end

        for position, frame in pairs(NAG.Frame.iconFrames) do
            frame.spellId = nil
            frame.itemId = nil
            frame.id = nil
            frame:Hide()
            if NAG.Frame.roundIconFrames and NAG.Frame.roundIconFrames[position] then
                NAG.Frame.roundIconFrames[position]:SetShown(false)
            end
            -- ARCHITECTURAL FIX: Don't hide borders here
            -- Border visibility managed exclusively by RefreshAllBorders()
            -- Hiding them here caused legacy borders to disappear every rotation update
        end
    end

    --- Optimized sequence cleanup processing
    function DisplayManager:ProcessSequenceCleanup()
        -- Clear sequence lock at the end of each update cycle
        if NAG.RightSlots and NAG.RightSlots._lockSequence then
            if not NAG.RightSlots.activeSequence then
                if self.debug then
                    self:Debug("UpdateIcons: Clearing sequence lock - no active sequence")
                end
                NAG.RightSlots._lockSequence = false
            end
        end

        -- Check if main frame is hidden and clear sequence state if needed
        local mainFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]
        local mainFrameHidden = not mainFrame or not mainFrame:IsVisible() or not mainFrame.spellId

        if mainFrameHidden and NAG.RightSlots and NAG.RightSlots.activeSequence and not NAG.RightSlots.forceMainActive then
            -- Only reset strict sequences if they've been empty for a long time
            if NAG.RightSlots.sequenceType == "strict" then
                NAG.RightSlots._mainFrameEmptyCount = (NAG.RightSlots._mainFrameEmptyCount or 0) + 1
                local resetThreshold = 50
                if NAG.RightSlots._mainFrameEmptyCount < resetThreshold then
                    return
                end
                if self.debug then
                    self:Debug(
                        "🔄 DisplayManager: Main frame hidden for %d frames, clearing strict sequence '%s'",
                        NAG.RightSlots._mainFrameEmptyCount, NAG.RightSlots.activeSequence)
                end
                NAG.RightSlots:resetSequence()
                NAG.RightSlots._mainFrameEmptyCount = 0
            else
                -- Existing logic for non-strict sequences
                if NAG.RightSlots.sequenceInitTime then
                    local timeSinceInit = GetTime() - NAG.RightSlots.sequenceInitTime
                    if timeSinceInit >= 0.5 then
                        if self.debug then
                            self:Debug(
                                "🔄 DisplayManager: Main frame hidden, clearing sequence '%s' (forceMain == false, active for %.2f seconds)",
                                NAG.RightSlots.activeSequence, timeSinceInit)
                        end
                        NAG.RightSlots:resetSequence()
                    end
                end
            end
        end
    end

    --- Batch update all icon states for better performance
    function DisplayManager:UpdateAllIconStates()
        if not NAG.Frame or not NAG.Frame.iconFrames then return end

        for position, frame in pairs(NAG.Frame.iconFrames) do
            if frame.UpdateTooltipState then
                frame:UpdateTooltipState()
            end
        end

        -- Update mouse state for all legacy frames
        self:UpdateLegacyIconMouseStateForModifier()
    end

    local CACHED_VISIBLE_SEQUENCE_ICONS = {}

    function DisplayManager:UpdateIcons(main, spellTable)
        local mainIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(main, {
            context = "display_legacy_main",
        }) or nil
        local mainResolveId = mainIdentity and NAG.GetActionResolveId and NAG:GetActionResolveId(mainIdentity) or nil
        local mainDisplayId = mainIdentity and NAG.GetActionDisplayId and NAG:GetActionDisplayId(mainIdentity) or nil
        local mainCacheKey = mainIdentity and format("%s:%s", tostring(mainIdentity.spellId), tostring(mainIdentity.itemId)) or "nil"

        -- Clear entity cache when display set changes to avoid unbounded growth
        local spellCount = spellTable and #spellTable or 0
        if mainCacheKey ~= self._lastUpdateIconsMain or spellCount ~= (self._lastUpdateIconsSpellCount or -1) then
            self:ClearEntityCache()
            self._lastUpdateIconsMain = mainCacheKey
            self._lastUpdateIconsSpellCount = spellCount
        end

        -- CRITICAL: Frame state validation - if frames are missing, all updates fail
        if not NAG.Frame then
            self:Error(format("UpdateIcons: CRITICAL - NAG.Frame is nil - display updates will fail and display may become stuck"))
            return
        end
        if not NAG.Frame.iconFrames then
            self:Error(format("UpdateIcons: CRITICAL - NAG.Frame.iconFrames is nil - display updates will fail and display may become stuck"))
            return
        end

        -- CRITICAL: hasEnabledModule check - if false, display freezes
        if not NAG.hasEnabledModule then
            self:Error(format("UpdateIcons: CRITICAL - hasEnabledModule is false - display will freeze (main=%s, secondarySpells count=%d)",
                tostring(main), spellTable and #spellTable or 0))
            if self.debug then
                self:Debug("[DisplayManager] UpdateIcons aborted: hasEnabledModule is false")
            end
            return
        end

        -- Check sequence reset conditions before processing
        NAG:CheckSequenceResetConditions()

        -- Reset right-side slot tracking at the start of each update cycle
        -- BUT: Don't reset if we have an active StrictSequence
        if NAG.RightSlots and NAG.RightSlots.sequenceType == "strict" and NAG.RightSlots.activeSequence then
            -- Don't reset StrictSequences during normal update cycles
            if self.debug then self:Trace("UpdateIcons: Skipping reset for active StrictSequence") end
        else
            NAG.RightSlots:reset()
        end

        -- Update active sequence display after reset but before processing
        NAG:UpdateActiveSequenceDisplay()

        -- Batch clear all frames for better performance
        self:ClearAllIconFrames()
        local aoeSpellId = nil
        local totemCount = 0
        local maxBelowFrames = self.db.char.numBelowIcons
        if mainResolveId then
            local entity = GetCachedEntity(mainResolveId, mainIdentity and mainIdentity.itemId ~= nil)
            if not entity then
                -- Entity lookup failure - skip main spell but continue processing secondarySpells
                local secondaryCount = spellTable and #spellTable or 0
                self:Warn(format("UpdateIcons: Unknown spell/item ID for main: %s (no texture available) - skipping main spell, continuing with secondarySpells (count=%d)",
                    tostring(mainResolveId), secondaryCount))
            else
                NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId = mainIdentity and mainIdentity.spellId or mainResolveId
                NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].itemId = mainIdentity and mainIdentity.itemId or nil
                local updateSuccess = self:UpdateIcon(ns.SPELL_POSITIONS.PRIMARY, mainResolveId, mainIdentity and mainIdentity.itemId ~= nil)
                if not updateSuccess then
                    self:Warn("UpdateIcons: Failed to update main icon for spell %s", tostring(mainResolveId))
                else
                    -- Ensure cast overlay text (e.g. CastPlaceholderWithOverlay poison reminders) is rendered for PRIMARY.
                    -- CastSpell(id, ..., overlayText) renders immediately, but placeholders rely on DisplayManager to paint overlays.
                    local overlaySpellId = mainIdentity and (mainIdentity.spellId or mainResolveId) or mainResolveId
                    self:DisplayCastOverlayText(overlaySpellId, ns.SPELL_POSITIONS.PRIMARY)
                end
                if Extras and Extras.SP and Extras.GC then
                    local extrasId = mainIdentity and (mainIdentity.spellId or mainDisplayId or mainResolveId) or mainResolveId
                    local r, g, b = Extras:GC(NAG.spellss, extrasId)
                    Extras:SP(1, 30, 5, r, g, b, 1, 7, extrasId)
                end
            end
        elseif Extras and not mainResolveId then
            Extras:SP(1, 30, 5, 0, 0, 0, 0, 0, nil)
        end

        local leftIndex = 1
        local rightIndex = 1
        local aboveIndex = 1
        local belowIndex = 1
        local secondaryIndex = 2
        local maxLeftFrames = self:GetEffectiveNumLeftIcons()

        local predictionSettings = NAG.db and NAG.db.char and NAG.db.char.predictionQueue
        local predictionQueueActive = predictionSettings and predictionSettings.enabled and self:IsLegacyFrameEnabled()

        -- Determine if we'll have a primary spell displayed (main spell or AOE as fallback)
        local willHavePrimarySpell = false
        if mainResolveId then
            willHavePrimarySpell = true
        else
            -- Check if we'll have an AOE spell to show as primary
            if spellTable then
                for _, entry in ipairs(spellTable) do
                    local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
                    local id = norm and (norm.itemId or norm.spellId) or nil
                    if not id then
                        -- skip invalid entry
                    else
                    local identity = DataManager.GetIdentity and DataManager:GetIdentity(id, "display_primary_probe", {
                        preferItemFirst = norm.itemId ~= nil,
                    }) or nil
                    local entity = identity and identity.entity or nil
                    if entity and entity.position == DataManager.SpellPosition.AOE then
                        willHavePrimarySpell = true
                        break
                    end
                    end
                end
            end

            -- Check if we have a sequence with forceMainActive (first spell shown in main frame)
            if NAG.RightSlots and NAG.RightSlots.forceMainActive and NAG.RightSlots.sequence and #NAG.RightSlots.sequence > 0 then
                willHavePrimarySpell = true
            end
        end

        -- Handle sequence spells from NAG.RightSlots.sequence FIRST (priority)
        -- Show sequence spells if:
        -- 1. There will be a primary spell displayed, OR
        -- 2. We have a sequence with forceMain == false (should display in right frames only)
        local shouldShowSequence = (not predictionQueueActive) and (willHavePrimarySpell or
            (NAG.RightSlots and NAG.RightSlots.sequence and #NAG.RightSlots.sequence > 0 and
                NAG.RightSlots.activeSequence and not NAG.RightSlots.forceMainActive))

        -- Use throttled logging to reduce spam
        --self:ThrottledDebug(format("🔍 UpdateIcons: Sequence display logic - willHavePrimarySpell=%s, shouldShowSequence=%s, forceMainActive=%s",
        --    tostring(willHavePrimarySpell), tostring(shouldShowSequence), tostring(NAG.RightSlots and NAG.RightSlots.forceMainActive)),
        --    "UpdateIcons:SequenceDisplay", 1.0)

        if NAG.RightSlots and NAG.RightSlots.activeSequence then
            if self.debug then
                self:ThrottledDebug(format("🔍 UpdateIcons: Active sequence '%s' with %d spells, type=%s",
                        NAG.RightSlots.activeSequence, #NAG.RightSlots.sequence, NAG.RightSlots.sequenceType or "unknown"),
                    "UpdateIcons:ActiveSequence", 1.0)
            end
        end

        -- CRITICAL FIX: When forceMainActive is true, set the main frame to show the current sequence spell
        if NAG.RightSlots and NAG.RightSlots.forceMainActive and NAG.RightSlots.sequence and
            #NAG.RightSlots.sequence > 0 and NAG.RightSlots.sequenceProgress and
            NAG.RightSlots.sequenceProgress <= #NAG.RightSlots.sequence then
            local currentSequenceSpell = NAG.RightSlots.sequence[NAG.RightSlots.sequenceProgress]
            if currentSequenceSpell and NAG:SpellCanCast(currentSequenceSpell) then
                NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId = currentSequenceSpell
                local updateSuccess = self:UpdateIcon(ns.SPELL_POSITIONS.PRIMARY, currentSequenceSpell)
                if not updateSuccess then
                    self:Warn("UpdateIcons: Failed to update main icon for sequence spell %d", currentSequenceSpell)
                end
                -- Move to Trace level to reduce spam
                if self.debug then
                    self:Trace("UpdateIcons: Set main frame to sequence spell %d (progress: %d/%d)",
                        currentSequenceSpell, NAG.RightSlots.sequenceProgress, #NAG.RightSlots.sequence)
                end
            end
        end

        if shouldShowSequence and NAG.RightSlots and NAG.RightSlots.sequence and #NAG.RightSlots.sequence > 0 then
            local displayedCount = 0
            local maxDisplay = 3
            local highestSequencePosition = 0  -- Track the highest RIGHT position actually used

            local totalDisplayedCount = 0
            -- Use throttled logging for sequence display summary
            if self.debug then
                self:ThrottledDebug(format("🔍 UpdateIcons: Displaying sequence spells - count=%d, forceMainActive=%s",
                        #NAG.RightSlots.sequence, tostring(NAG.RightSlots.forceMainActive)),
                    "UpdateIcons:SequenceDisplaySummary", 1.0)
            end

            for i, spellId in ipairs(NAG.RightSlots.sequence) do
                -- Skip the first spell if forceMainActive is true (it's already shown in middle frame)
                if not (NAG.RightSlots.forceMainActive and i == 1) then
                    if displayedCount < maxDisplay then
                        -- Check if the spell can actually be cast before displaying it
                        if NAG:SpellCanCast(spellId) then
                            -- FIX: Calculate position based on actual sequence index, accounting for forceMainActive
                            -- This prevents gaps when spells are skipped (not castable)
                            local sequencePosition = NAG.RightSlots.forceMainActive and (i - 1) or i
                            local key = ns.SPELL_POSITIONS.RIGHT .. sequencePosition

                            if NAG.Frame.iconFrames[key] then
                                local currentSpellId = NAG.Frame.iconFrames[key].spellId

                                -- Always override for sequence spells (they have priority)
                                NAG.Frame.iconFrames[key].spellId = spellId
                                local updateSuccess = self:UpdateIcon(key, spellId)
                                if not updateSuccess then
                                    self:Warn("UpdateIcons: Failed to update icon for sequence spell %d at position %s", spellId, key)
                                end

                                -- Move individual spell display to Trace level to reduce spam
                                if self.debug then
                                    self:Trace(
                                        "🔍 UpdateIcons: Displayed sequence spell %d in %s frame (sequence index %d)", spellId, key, i)
                                end

                                totalDisplayedCount = totalDisplayedCount + 1
                                displayedCount = displayedCount + 1
                                -- Track the highest position actually used
                                highestSequencePosition = math.max(highestSequencePosition, sequencePosition)
                            end
                        else
                            -- Move skipped spell logging to Trace level
                            if self.debug then
                                self:Trace("🔍 UpdateIcons: Skipped sequence spell %d at index %d - not castable",
                                    spellId, i)
                            end
                        end
                    end
                else
                    -- Move skipped spell logging to Trace level
                    if self.debug then
                        self:Trace(
                            "🔍 UpdateIcons: Skipped sequence spell %d at position %d - forceMainActive=true", spellId, i)
                    end
                end
            end

            -- Use throttled logging for sequence display completion
            if self.debug then
                self:ThrottledDebug(
                    format("🔍 UpdateIcons: Sequence display complete - displayed %d spells, highest position=%d", totalDisplayedCount, highestSequencePosition),
                    "UpdateIcons:SequenceDisplayComplete", 1.0)
            end

            -- Clear ALL sequence arrows before adding new ones

            OverlayManager:ClearAllSequenceArrows()

            -- OPTIMIZED ARROW OVERLAY LOGIC
            -- Only show arrows if we have at least 2 visible sequence icons
            -- if self.debug then self:Debug("Arrow Logic: totalDisplayedCount=%d, sequence count=%d, forceMainActive=%s", --     totalDisplayedCount, #NAG.RightSlots.sequence, tostring(NAG.RightSlots.forceMainActive)) end

            -- Calculate total visible sequence icons (including main frame if forceMainActive)
            local totalVisibleSequenceIcons = totalDisplayedCount
            if NAG.RightSlots.forceMainActive and NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY] and
                NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId and NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]:IsVisible() then
                -- Check if primary frame contains a sequence spell
                for _, sequenceSpellId in ipairs(NAG.RightSlots.sequence) do
                    if sequenceSpellId == NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId then
                        totalVisibleSequenceIcons = totalVisibleSequenceIcons + 1
                        break
                    end
                end
            end

            -- if self.debug then self:Debug("Arrow Logic: totalVisibleSequenceIcons=%d", totalVisibleSequenceIcons) end
            if totalVisibleSequenceIcons > 1 then
                OverlayManager = NAG:GetModule("OverlayManager")
                wipe(CACHED_VISIBLE_SEQUENCE_ICONS)
                local visibleSequenceIcons = CACHED_VISIBLE_SEQUENCE_ICONS

                -- Check main frame first if forceMainActive is true and it contains a sequence spell
                if NAG.RightSlots.forceMainActive and NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY] and
                    NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId and NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]:IsVisible() then
                    -- Verify the primary frame spell is actually part of the current sequence
                    local isPrimarySequenceSpell = false
                    for _, sequenceSpellId in ipairs(NAG.RightSlots.sequence) do
                        if sequenceSpellId == NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId then
                            isPrimarySequenceSpell = true
                            break
                        end
                    end

                    if isPrimarySequenceSpell then
                        tinsert(visibleSequenceIcons, {
                            frame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY],
                            spellId = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId,
                            position = ns.SPELL_POSITIONS.PRIMARY
                        })
                        -- if self.debug then self:Debug("Arrow Logic: Added primary frame with sequence spell %d", NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId) end
                    end
                end

                -- Check right frames for sequence spells
                for i = 1, 3 do
                    local key = ns.SPELL_POSITIONS.RIGHT .. i
                    local frame = NAG.Frame.iconFrames[key]
                    if frame and frame.spellId and frame:IsVisible() then
                        -- Verify this spell is actually part of the current sequence
                        local isSequenceSpell = false
                        for _, sequenceSpellId in ipairs(NAG.RightSlots.sequence) do
                            if sequenceSpellId == frame.spellId then
                                isSequenceSpell = true
                                break
                            end
                        end

                        if isSequenceSpell then
                            tinsert(visibleSequenceIcons, {
                                frame = frame,
                                spellId = frame.spellId,
                                position = key
                            })
                            -- if self.debug then self:Debug("Arrow Logic: Added %s frame with spell %d", key, frame.spellId) end
                        end
                    end
                end

                -- Apply arrows between each adjacent pair (never on the last visible icon)
                for i = 1, #visibleSequenceIcons - 1 do
                    local currentIcon = visibleSequenceIcons[i]
                    local nextIcon = visibleSequenceIcons[i + 1]

                    -- Only add arrow if both icons are valid and visible
                    if currentIcon.frame and nextIcon.frame and
                        currentIcon.frame:IsVisible() and nextIcon.frame:IsVisible() then
                        OverlayManager:ShowOverlay(currentIcon.frame, "sequencearrow", nil, nil,
                            { spellId = currentIcon.spellId })
                        --if self.debug then self:Debug("Arrow Logic: Added arrow from %s (spell %d) to %s (spell %d)", --     currentIcon.position, currentIcon.spellId, nextIcon.position, nextIcon.spellId) end
                    end
                end

                -- if self.debug then self:Debug("Arrow Logic: Total visible sequence icons: %d, arrows added: %d", --     #visibleSequenceIcons, #visibleSequenceIcons - 1) end
            end

            -- FIX: Update rightIndex based on the highest position actually used, not just displayedCount
            -- This ensures regular RIGHT spells don't conflict with sequence positions
            if highestSequencePosition > 0 then
                rightIndex = math.max(rightIndex, highestSequencePosition + 1)
            end

            -- Sequence is locked for this display cycle only
            -- if self.debug then self:Debug("UpdateIcons: Sequence displayed for this cycle, showing %d/%d ready spells", displayedCount, #NAG.RightSlots.sequence) end
        else
            if NAG.RightSlots and NAG.RightSlots.sequence and #NAG.RightSlots.sequence > 0 then
                if self.debug then
                    self:Debug(
                        "UpdateIcons: Hiding %d sequence spells - no primary spell and not forceMain == false",
                        #NAG.RightSlots.sequence)
                end

                -- Only clear sequence state if we're not in a forceMain == false scenario
                if NAG.RightSlots.activeSequence and NAG.RightSlots.forceMainActive then
                    if self.debug then
                        self:Debug("UpdateIcons: Clearing sequence '%s' due to no primary spell",
                            NAG.RightSlots.activeSequence)
                    end
                    NAG.RightSlots:resetSequence()
                end
            end
        end



        if predictionQueueActive then
            if OverlayManager then
                OverlayManager:ClearAllSequenceArrows()
            end
        end

        if spellTable then
            local seenTinkerItemIds = {}
            local StateManager = NAG:GetModule("StateManager", true)
            local isProjected = (spellTable[1] and type(spellTable[1]) == "table" and spellTable[1].resolveId ~= nil)
            for _, entry in ipairs(spellTable) do
                local normalized, spellId, displayId, spellPosition
                if isProjected and entry and type(entry) == "table" and entry.resolveId then
                    normalized = entry.norm
                    spellId = normalized and normalized.spellId
                    displayId = entry.displayId or (normalized and (normalized.itemId or normalized.spellId))
                    local posFromManager = SpellbookManager and SpellbookManager.GetSpellPosition and SpellbookManager:GetSpellPosition(entry.resolveId)
                    spellPosition = entry.position or posFromManager or ns.SPELL_POSITIONS.PRIMARY
                else
                    normalized = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
                    if not normalized then
                        -- skip invalid entry (malformed or nil)
                    else
                    spellId = normalized.spellId
                    displayId = normalized.itemId or spellId
                    spellPosition = normalized.position or SpellbookManager:GetSpellPosition(spellId or displayId) or ns.SPELL_POSITIONS.PRIMARY
                end
                end
                if not normalized or not displayId then
                    -- skip invalid entry
                else
                -- Do not show item icons when the item is on cooldown (e.g. potion just used)
                local skipItemOnCooldown = false
                if normalized.itemId and GetItemCooldown then
                    local start, duration = GetItemCooldown(normalized.itemId)
                    if start and duration and duration > 0 then
                        local now = GetTime and GetTime() or 0
                        if (start + duration) > now then
                            skipItemOnCooldown = true
                        end
                    end
                end
                if not skipItemOnCooldown then
                local preferItemFirst = (normalized.itemId ~= nil)
                local tinkerItemId = normalized.itemId or (StateManager and StateManager:GetTinkerItemIdForDisplay(spellId))
                if tinkerItemId and seenTinkerItemIds[tinkerItemId] then
                    -- skip duplicate tinker (one icon per item)
                else
                    if tinkerItemId then
                        seenTinkerItemIds[tinkerItemId] = true
                    end
                spellPosition = self:NormalizeSpellPosition(spellPosition) or spellPosition or ns.SPELL_POSITIONS.PRIMARY

                -- Use spellId for tinker entries so GetTinkerInfoBySpellId runs; otherwise displayId (entries now have correct structure from autocast/CastTinker)
                local iconId = (normalized.itemId and spellId) or displayId
                local entity = GetCachedEntity(iconId, normalized.itemId ~= nil)
                if not entity then
                    self:Warn("UpdateIcons: Unknown spell/item ID: %d - skipping this spell", iconId)
                    -- Continue to next spell instead of returning to allow other spells to display
                else

                    if spellPosition == ns.SPELL_POSITIONS.AOE then
                        aoeSpellId = spellId
                        local key = ns.SPELL_POSITIONS.AOE
                        if NAG.Frame.iconFrames[key] and not NAG.Frame.iconFrames[key].spellId then
                            -- Use AOE frame if available
                        else
                            -- Check overflow setting
                            if self:GetSetting("char", "disableIconOverflow") then
                                -- Skip this icon (hide overflow)
                                if self.debug then
                                    self:ThrottledDebug(
                                        format("Skipping AOE overflow icon %d - overflow disabled", spellId),
                                        "UpdateIcons:OverflowSkip",
                                        2.0
                                    )
                                end
                                -- Continue to next spell without displaying this one
                                key = nil
                            else
                                -- Fall back to left frame
                                if leftIndex > maxLeftFrames then
                                    -- Skip this spell and continue processing others
                                    key = nil
                                else
                                    key = ns.SPELL_POSITIONS.LEFT .. leftIndex
                                    leftIndex = leftIndex + 1
                                end
                            end
                        end
                        if key then
                            local updateSuccess = self:UpdateIcon(key, iconId, preferItemFirst)
                            if updateSuccess then
                                NAG.Frame.iconFrames[key].spellId = spellId
                                NAG.Frame.iconFrames[key].itemId = normalized.itemId
                                self:DisplayCastOverlayText(spellId or displayId, key)
                            end
                            if not updateSuccess then
                                self:Warn("UpdateIcons: Failed to update icon for AOE spell %d at position %s", displayId, key)
                            end
                        end
                    elseif spellPosition == ns.SPELL_POSITIONS.ABOVE then
                        local key = ns.SPELL_POSITIONS.ABOVE .. aboveIndex
                        if NAG.Frame.iconFrames[key] and not NAG.Frame.iconFrames[key].spellId then
                            -- Found empty above frame, use it
                        else
                            -- Check overflow setting
                            if self:GetSetting("char", "disableIconOverflow") then
                                -- Skip this icon (hide overflow)
                                if self.debug then
                                    self:ThrottledDebug(
                                        format("Skipping ABOVE overflow icon %d - overflow disabled", spellId),
                                        "UpdateIcons:OverflowSkip",
                                        2.0
                                    )
                                end
                                -- Continue to next spell without displaying this one
                                key = nil
                            else
                                -- No empty above frame, fall back to left frame
                                if leftIndex > maxLeftFrames then
                                    -- Skip this spell and continue processing others
                                    key = nil
                                else
                                    key = ns.SPELL_POSITIONS.LEFT .. leftIndex
                                    leftIndex = leftIndex + 1
                                end
                            end
                        end
                        if key then
                            local updateSuccess = self:UpdateIcon(key, iconId, preferItemFirst)
                            if updateSuccess then
                                NAG.Frame.iconFrames[key].spellId = spellId
                                NAG.Frame.iconFrames[key].itemId = normalized.itemId
                                self:DisplayCastOverlayText(spellId or displayId, key)
                            end
                            if not updateSuccess then
                                self:Warn("UpdateIcons: Failed to update icon for ABOVE spell %d at position %s", displayId, key)
                            end
                        end
                        aboveIndex = aboveIndex + 1
                    elseif spellPosition == ns.SPELL_POSITIONS.BELOW then
                        local key = ns.SPELL_POSITIONS.BELOW .. belowIndex
                        if totemCount < maxBelowFrames and NAG.Frame.iconFrames[key] and not NAG.Frame.iconFrames[key].spellId then
                            -- Found empty below frame, use it
                            totemCount = totemCount + 1
                        else
                            -- Check overflow setting
                            if self:GetSetting("char", "disableIconOverflow") then
                                -- Skip this icon (hide overflow)
                                if self.debug then
                                    self:ThrottledDebug(
                                        format("Skipping BELOW overflow icon %d - overflow disabled", spellId),
                                        "UpdateIcons:OverflowSkip",
                                        2.0
                                    )
                                end
                                -- Continue to next spell without displaying this one
                                key = nil
                            else
                                -- No empty below frame or totemCount limit reached, fall back to left frame
                                if leftIndex > maxLeftFrames then
                                    -- Skip this spell and continue processing others
                                    key = nil
                                else
                                    key = ns.SPELL_POSITIONS.LEFT .. leftIndex
                                    leftIndex = leftIndex + 1
                                end
                            end
                        end
                        if key then
                            local updateSuccess = self:UpdateIcon(key, iconId, preferItemFirst)
                            if updateSuccess then
                                NAG.Frame.iconFrames[key].spellId = spellId
                                NAG.Frame.iconFrames[key].itemId = normalized.itemId
                                self:DisplayCastOverlayText(spellId or displayId, key)
                            end
                            if not updateSuccess then
                                self:Warn("UpdateIcons: Failed to update icon for BELOW spell %d at position %s", displayId, key)
                            end
                        end
                        belowIndex = belowIndex + 1
                    elseif spellPosition == ns.SPELL_POSITIONS.RIGHT then
                        local key
                        if predictionQueueActive then
                            if leftIndex > maxLeftFrames then
                                if self.debug then
                                    self:ThrottledDebug(
                                        format("Skipping RIGHT icon %d - redirected but no left slots available", spellId),
                                        "UpdateIcons:RightRedirectSkip",
                                        2.0
                                    )
                                end
                                key = nil
                            else
                                key = ns.SPELL_POSITIONS.LEFT .. leftIndex
                                leftIndex = leftIndex + 1
                            end
                        else
                            key = ns.SPELL_POSITIONS.RIGHT .. rightIndex
                            -- Check if this position is already occupied (e.g., by a sequence spell)
                            if NAG.Frame.iconFrames[key] and NAG.Frame.iconFrames[key].spellId then
                                -- Position is occupied, try next position or overflow
                                -- Check overflow setting
                                if self:GetSetting("char", "disableIconOverflow") then
                                    -- Skip this icon (hide overflow)
                                    if self.debug then
                                        self:ThrottledDebug(
                                            format("Skipping RIGHT overflow icon %d - overflow disabled", spellId),
                                            "UpdateIcons:OverflowSkip",
                                            2.0
                                        )
                                    end
                                    -- Continue to next spell without displaying this one
                                    key = nil
                                else
                                    -- Try next RIGHT position
                                    local nextRightIndex = rightIndex + 1
                                    if nextRightIndex <= 3 and NAG.Frame.iconFrames[ns.SPELL_POSITIONS.RIGHT .. nextRightIndex] and
                                       not NAG.Frame.iconFrames[ns.SPELL_POSITIONS.RIGHT .. nextRightIndex].spellId then
                                        key = ns.SPELL_POSITIONS.RIGHT .. nextRightIndex
                                        rightIndex = nextRightIndex
                                    elseif leftIndex <= maxLeftFrames then
                                        -- Overflow to LEFT
                                        key = ns.SPELL_POSITIONS.LEFT .. leftIndex
                                        leftIndex = leftIndex + 1
                                    else
                                        -- No available positions
                                        key = nil
                                    end
                                end
                            end
                        end
                        if key and NAG.Frame.iconFrames[key] then
                            local updateSuccess = self:UpdateIcon(key, iconId, preferItemFirst)
                            if updateSuccess then
                                NAG.Frame.iconFrames[key].spellId = spellId
                                NAG.Frame.iconFrames[key].itemId = normalized.itemId
                                self:DisplayCastOverlayText(spellId or displayId, key)
                                if not predictionQueueActive and strmatch(key, "^" .. ns.SPELL_POSITIONS.RIGHT) then
                                    rightIndex = rightIndex + 1
                                end
                            end
                            if not updateSuccess then
                                self:Warn("UpdateIcons: Failed to update icon for RIGHT spell %d at position %s", displayId, key)
                            end
                        elseif key then
                            self:Warn("UpdateIcons: No icon frame found for RIGHT position: %s (spell %d)", key, displayId)
                        end
                    elseif spellPosition == ns.SPELL_POSITIONS.SEQUENCE then
                        -- Sequence spells are handled exclusively through NAG.RightSlots.sequence system
                        -- This prevents sequence spells from appearing in wrong positions
                    else
                        -- Default/PRIMARY position - add bounds check to prevent leftIndex from exceeding available frames
                        local key
                        if leftIndex > maxLeftFrames then
                            -- Skip this spell and continue processing others
                            key = nil
                        else
                            key = ns.SPELL_POSITIONS.LEFT .. leftIndex
                        end
                        if key and NAG.Frame.iconFrames[key] then
                            local updateSuccess = self:UpdateIcon(key, iconId, preferItemFirst)
                            if updateSuccess then
                                NAG.Frame.iconFrames[key].spellId = spellId
                                NAG.Frame.iconFrames[key].itemId = normalized.itemId
                                -- Display overlay text for secondary spell if available
                                self:DisplayCastOverlayText(spellId or displayId, key)
                                leftIndex = leftIndex + 1
                            end
                            if not updateSuccess then
                                self:Warn("UpdateIcons: Failed to update icon for PRIMARY spell %d at position %s", displayId, key)
                            end
                        elseif key then
                            self:Warn("UpdateIcons: No icon frame found for position: %s (spell %d)", key, displayId)
                        end
                    end
                end
                end

                -- Update Extras if available
                if Extras and Extras.SP and Extras.GC and secondaryIndex <= 5 then
                    local overlayId = spellId or displayId
                    if overlayId then
                        local r, g, b = Extras:GC(NAG.spellss, overlayId)
                        Extras:SP(secondaryIndex, 30 + (secondaryIndex - 1) * 10, 5, r, g, b, 1, 7, overlayId)
                        secondaryIndex = secondaryIndex + 1
                    end
                end
                end
                end
            end
        end
        if not main and aoeSpellId then
            --TODO Revisit this
            -- Check if the AoE spell should actually be in the primary position
            local aoeSpellPosition = SpellbookManager:GetSpellPosition(aoeSpellId) or ns.SPELL_POSITIONS.PRIMARY

            -- DEBUG: Track what's happening with AoE spell fallback
            --if self.debug then self:Debug("🔍 AOE_FALLBACK_DEBUG: main=%s, aoeSpellId=%d, aoePosition='%s', aoeSpellPosition='%s'", --    tostring(main), aoeSpellId, tostring(aoePosition), aoeSpellPosition) end

            if aoeSpellPosition == ns.SPELL_POSITIONS.AOE or aoeSpellPosition == ns.SPELL_POSITIONS.PRIMARY then
                -- AoE spell is intended for primary position or has no specific position
                --if self.debug then self:Debug("🔍 AOE_FALLBACK_DEBUG: Putting AoE spell %d in primary position", aoeSpellId) end
                NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY].spellId = aoeSpellId
                local updateSuccess = self:UpdateIcon(ns.SPELL_POSITIONS.PRIMARY, aoeSpellId)
                if not updateSuccess then
                    self:Warn("UpdateIcons: Failed to update main icon for AOE fallback spell %d", aoeSpellId)
                end
                if NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE] then
                    NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE]:Hide()
                    if NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE].borders then
                        for _, border in ipairs(NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE].borders) do
                            border:Hide()
                        end
                    end
                end
                if Extras and Extras.SP then
                    local r, g, b = Extras:GC(NAG.spellss, aoeSpellId)
                    Extras:SP(1, 30, 5, r, g, b, 1, 7, aoeSpellId)
                end
            else
                -- AoE spell has a specific position (like RIGHT, LEFT, etc.), don't put it in primary
                --if self.debug then self:Debug("🔍 AOE_FALLBACK_DEBUG: AoE spell %d has specific position '%s', NOT putting in primary", aoeSpellId, upperAoePosition) end
            end
        else
            -- DEBUG: Track when no AoE fallback is happening
            if not main then
                --if self.debug then self:Debug("🔍 AOE_FALLBACK_DEBUG: No main spell, no AoE fallback - main=%s, aoeSpellId=%s", --   tostring(main), tostring(aoeSpellId)) end
            end
        end
        if Extras and Extras.SP then
            for i = secondaryIndex, 5 do
                Extras:SP(i, 30 + (i - 1) * 10, 2, 0, 0, 0, 0, 0, nil)
            end
        end

        -- Optimized sequence cleanup and final processing
        self:ProcessSequenceCleanup()

        -- Batch update tooltip states and mouse interactions
        self:UpdateAllIconStates()

        -- TBC Hunter: melee weaving positioning indicator (2H only, opt-out supported)
        if ns.Version and ns.Version:IsTBC() and NAG.CLASS_FILENAME == "HUNTER" then
            self:UpdateHunterPositioningIndicator()
        end
    end
end

---------------------------------------------------------------------
-- TBC Hunter Melee Weaving Positioning Indicator
---------------------------------------------------------------------
-- Texture paths for arrow/minus (standard WoW UI)
local HUNTER_POSITION_TEXTURES = {
    closer = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up",
    farther = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up",
    hold = "Interface\\Buttons\\UI-MinusButton-Up",
}

function DisplayManager:UpdateHunterPositioningIndicator()
    if not NAG.Frame or not NAG.Frame.iconFrames then return end
    local primaryFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]
    if not primaryFrame then return end

    local suggestion = (NAG.HunterGetWeavePositioningSuggestion and NAG:HunterGetWeavePositioningSuggestion("target")) or nil
    if not suggestion then
        if primaryFrame.hunterPositionIndicator then
            primaryFrame.hunterPositionIndicator:Hide()
        end
        return
    end

    local texturePath = HUNTER_POSITION_TEXTURES[suggestion]
    if not texturePath then return end

    if not primaryFrame.hunterPositionIndicator then
        local indicator = primaryFrame:CreateTexture(nil, "OVERLAY")
        indicator:SetSize(20, 20)
        indicator:SetPoint("BOTTOM", primaryFrame, "TOP", 0, 4)
        indicator:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        primaryFrame.hunterPositionIndicator = indicator
    end

    primaryFrame.hunterPositionIndicator:SetTexture(texturePath)
    primaryFrame.hunterPositionIndicator:Show()
end

---------------------------------------------------------------------
-- Frame Position and Scale Update
---------------------------------------------------------------------
function DisplayManager:UpdateFramePosition()
    if not NAG.Frame then return end

    local frameSettings = {
        point = (self.db.char.frameSettings and self.db.char.frameSettings.point) or "CENTER",
        relativePoint = (self.db.char.frameSettings and self.db.char.frameSettings.relativePoint) or "CENTER",
        offsetX = (self.db.char.frameSettings and self.db.char.frameSettings.offsetX) or 0,
        offsetY = (self.db.char.frameSettings and self.db.char.frameSettings.offsetY) or 0
    }
    NAG.Frame:ClearAllPoints()
    NAG.Frame:SetPoint(
        frameSettings.point or "CENTER",
        self:GetAnchorParent(),
        frameSettings.relativePoint or "CENTER",
        frameSettings.offsetX or 0,
        frameSettings.offsetY or 0
    )

    self:Debug("[DisplayManager] Frame position updated: point=%s, relativePoint=%s, offsetX=%s, offsetY=%s",
        tostring(frameSettings.point), tostring(frameSettings.relativePoint), tostring(frameSettings.offsetX),
        tostring(frameSettings.offsetY))

    -- Notify other modules that frame has been updated
    self:SendFrameUpdated("clear_all_icon_frames")
end

function DisplayManager:UpdateFrameScale()
    local frame = NAG.Frame
    if not frame then return end
    local scale = (self.db.char and self.db.char.frameSettings and self.db.char.frameSettings.scale) or 1
    frame:SetScale(scale)
    self:Debug("[DisplayManager] Frame scale updated: scale=%s", tostring(scale))

    -- Notify other modules that frame has been updated
    self:SendFrameUpdated("update_icon_data")
end

function DisplayManager:ToggleFrameEditMode(enable)
    if not (self and NAG.Frame) then return end

    -- Update edit mode state
    NAG.Frame.editMode = enable

    if enable then
        -- Create close button if it doesn't exist
        if not NAG.Frame.closeButton then
            local closeButton = CreateFrame("Button", nil, NAG.Frame, "UIPanelCloseButton")
            NAG.Frame.closeButton = closeButton
            closeButton:SetPoint("TOPRIGHT", NAG.Frame, "TOPRIGHT", 25, 25)
            closeButton:SetSize(32, 32)
            closeButton:SetFrameLevel(200)

            -- Add a label
            local label = closeButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            label:SetPoint("LEFT", closeButton, "RIGHT", -5, 0)
            label:SetText("Drag to move, wheel to scale")
            closeButton.label = label

            -- Make the button more visible
            closeButton:SetScale(1.2)

            closeButton:SetScript("OnClick", function()
                module:ToggleFrameEditMode(false)
                closeButton:Hide()
                if closeButton.label then
                    closeButton.label:Hide()
                    closeButton.label:SetParent(nil)
                    closeButton.label = nil
                end
                closeButton:SetParent(nil)
                NAG.Frame.closeButton = nil
            end)

            -- Add hover effect to make it more noticeable
            closeButton:SetScript("OnEnter", function(selfBtn)
                selfBtn:SetScale(1.3)
                if selfBtn.label then
                    selfBtn.label:SetTextColor(1, 0.8, 0)
                end
            end)
            closeButton:SetScript("OnLeave", function(selfBtn)
                selfBtn:SetScale(1.2)
                if selfBtn.label then
                    selfBtn.label:SetTextColor(1, 1, 1)
                end
            end)
        end
        NAG.Frame.closeButton:Show()
        if NAG.Frame.closeButton.label then
            NAG.Frame.closeButton.label:Show()
        end

        -- Show edit mode overlay
        if NAG.Frame.editModeOverlay then
            NAG.Frame.editModeOverlay:Show()
            NAG.Frame.editModeOverlay:EnableMouse(false)
            -- Set overlay to a lower level than the icon frames
            NAG.Frame.editModeOverlay:SetFrameStrata("DIALOG")
            NAG.Frame.editModeOverlay:SetFrameLevel(90)
        end
        -- Set frame strata and levels
        NAG.Frame:SetFrameStrata("MEDIUM")
        NAG.Frame:SetMovable(true)
        NAG.Frame:Show() -- Make sure parent frame is shown

        -- Set icon frames to a higher level than the overlay
        if self and NAG.Frame.iconFrames then
            for position, frame in pairs(NAG.Frame.iconFrames) do
                frame:SetFrameLevel(125)
                frame:Show() -- Show all frames in edit mode

                -- Enable mouse interaction for dragging
                frame:EnableMouse(true)
                frame:RegisterForDrag("LeftButton")

                -- Set up drag functionality for each frame
                frame:SetScript("OnDragStart", function(frameSelf)
                    if NAG.Frame and NAG.Frame:IsMovable() then
                        NAG.Frame:StartMoving()
                    end
                end)
                frame:SetScript("OnDragStop", function(frameSelf)
                    if NAG.Frame then
                        NAG.Frame:StopMovingOrSizing()

                        local point, relativeFrame, relativePoint, xOffset, yOffset = NAG.Frame:GetPoint()

                        module.db.char.frameSettings.point = point or "CENTER"
                        module.db.char.frameSettings.relativePoint = relativePoint or "CENTER"
                        module.db.char.frameSettings.offsetX = xOffset or 0
                        module.db.char.frameSettings.offsetY = yOffset or 0

                        -- Notify other modules that frame has been updated
                        module:SendFrameUpdated("prediction_queue_update")
                    end
                end)

                -- Show placeholder texture if no spell is assigned
                if not frame.spellId and not frame.itemId then
                    frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                    -- Add position text overlay if it doesn't exist
                    if not frame.positionText then
                        frame.positionText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                        frame.positionText:SetPoint("CENTER")
                        frame.positionText:SetText(position)
                    end
                    frame.positionText:Show()
                end

                -- Show borders while in edit mode
                if frame.borders then
                    for _, border in ipairs(frame.borders) do
                        border:Show()
                        -- TBC: Line regions from CreateLine don't have EnableMouse
                        if border.EnableMouse then
                            border:EnableMouse(false)
                        end
                    end
                end
            end
        end
        -- Enable mouse interaction and movement for parent frame
        NAG.Frame:EnableMouse(true)
        NAG.Frame:EnableMouseWheel(true)

        -- Notify class helper bars to refresh their mouse state
        self:SendFrameUpdated("update_group_icons")

        -- Set up scaling functionality
        NAG.Frame:SetScript("OnMouseWheel", function(frameSelf, delta)
            local scale = frameSelf:GetScale() or 1
            if delta > 0 then
                scale = scale + 0.1
            else
                scale = scale - 0.1
            end
            scale = max(0.5, min(2, scale))
            frameSelf:SetScale(scale)
            module.db.char.frameSettings.scale = scale

            local point, relativeFrame, relativePoint, xOffset, yOffset = frameSelf:GetPoint()

            module.db.char.frameSettings.point = point or "CENTER"
            module.db.char.frameSettings.relativePoint = relativePoint or "CENTER"
            module.db.char.frameSettings.offsetX = xOffset or 0
            module.db.char.frameSettings.offsetY = yOffset or 0
        end)
    else
        -- Clean up close button
        if NAG.Frame.closeButton then
            NAG.Frame.closeButton:Hide()
            NAG.Frame.closeButton:SetParent(nil)
            NAG.Frame.closeButton = nil
        end

        -- Hide edit mode overlay
        if NAG.Frame.editModeOverlay then NAG.Frame.editModeOverlay:Hide() end

        -- Restore frame strata and levels
        NAG.Frame:SetFrameStrata("MEDIUM")

        if self and NAG.Frame.iconFrames then
            -- Restore icon frame levels and visibility based on spells
            for position, frame in pairs(NAG.Frame.iconFrames) do
                frame:SetFrameLevel((module.db.char.frameLevel) + 1)

                -- Disable mouse interaction and clean up drag functionality
                frame:EnableMouse(false)
                frame:RegisterForDrag()
                frame:SetScript("OnDragStart", nil)
                frame:SetScript("OnDragStop", nil)

                -- Hide frames without spells and remove placeholder elements
                if not frame.spellId and not frame.itemId then
                    frame:Hide()
                    if frame.positionText then
                        frame.positionText:Hide()
                    end
                end

                -- Restore border visibility using centralized logic (respects rotation readiness)
                if frame.UpdateBorder then
                    frame:UpdateBorder()
                end
            end
        end
        -- Disable mouse interaction
        NAG.Frame:EnableMouse(false)
        NAG.Frame:EnableMouseWheel(false)
        NAG.Frame:SetMovable(false)
        -- Notify class helper bars to refresh their mouse state
        self:SendFrameUpdated("refresh_frame_visuals")
        NAG.Frame:SetScript("OnMouseDown", nil)
        NAG.Frame:SetScript("OnMouseUp", nil)
        NAG.Frame:SetScript("OnMouseWheel", nil)
        -- Update legacy icon mouse state for modifier key
        self:UpdateLegacyIconMouseStateForModifier()
    end
end

--- Normalize position (string or constant) to spell position constant. Shared by legacy and group display.
--- @param position string|nil
--- @return string|nil
function DisplayManager:NormalizeSpellPosition(position)
    if position == nil then
        return nil
    end
    if type(position) ~= "string" then
        return position
    end
    local positionText = strlower(position)
    if strmatch(positionText, "^right") then
        return ns.SPELL_POSITIONS.RIGHT
    elseif strmatch(positionText, "^left") then
        return ns.SPELL_POSITIONS.LEFT
    elseif strmatch(positionText, "^above") then
        return ns.SPELL_POSITIONS.ABOVE
    elseif strmatch(positionText, "^below") then
        return ns.SPELL_POSITIONS.BELOW
    elseif positionText == "aoe" then
        return ns.SPELL_POSITIONS.AOE
    elseif positionText == "sequence" then
        return ns.SPELL_POSITIONS.SEQUENCE
    end
    return ns.SPELL_POSITIONS.PRIMARY
end

-- User-configurable mapping helpers
function DisplayManager:PositionToGroup(positionKey)
    local mapping = self.db.char.groupToPositionMapping
    local targetGroup = mapping[positionKey]
    if targetGroup then
        return targetGroup
    else
        -- Fallback to default mapping if no custom mapping exists
        local defaultMapping = {
            [ns.SPELL_POSITIONS.PRIMARY] = ns.FRAME_GROUPS.MAIN,
            [ns.SPELL_POSITIONS.AOE] = ns.FRAME_GROUPS.AOE,
            [ns.SPELL_POSITIONS.LEFT] = ns.FRAME_GROUPS.COOLDOWNS,
            [ns.SPELL_POSITIONS.RIGHT] = ns.FRAME_GROUPS.SEQUENCE,
            [ns.SPELL_POSITIONS.ABOVE] = ns.FRAME_GROUPS.DEFENSIVES,
            [ns.SPELL_POSITIONS.BELOW] = ns.FRAME_GROUPS.INTERRUPTS,
            [ns.SPELL_POSITIONS.SEQUENCE] = ns.FRAME_GROUPS.SEQUENCE,
        }
        return defaultMapping[positionKey] or ns.FRAME_GROUPS.COOLDOWNS
    end
end

--- Return the number of icon slots for a group (for overflow checks when building group icon data).
--- @param groupKey string
--- @return number
function DisplayManager:GetGroupNumIcons(groupKey)
    local settings = self.db and self.db.char and self.db.char.groupSettings and self.db.char.groupSettings[groupKey]
    if settings and type(settings.numIcons) == "number" then
        return settings.numIcons
    end
    local group = FRAME_GROUPS[groupKey]
    return (group and group.defaultNumIcons) or 2
end

function DisplayManager:GroupToPositions(groupKey)
    -- Returns all position keys mapped to this groupKey
    local mapping = self.db.char.groupToPositionMapping
    local result = {}
    for position, group in pairs(mapping) do
        if group == groupKey then
            table.insert(result, position)
        end
    end
    return result
end

function DisplayManager:GetOptions()
    local classModule = NAG:GetClassModule()
    local hasEnabledModule = classModule:IsEnabled()

    -- Preset dropdown UI
    local presetDropdown = {
        type = "select",
        name = L["presetDropdown"] or "Layout Preset",
        desc = L["presetDropdownDesc"] or "Quickly apply a preset layout for all groups.",
        order = 0.5,
        values = function()
            local t = {}
            for k, _ in pairs(GROUP_PRESETS) do t[k] = k end
            return t
        end,
        get = function() return self._lastPresetSelected or "Default" end,
        set = function(_, val)
            self._lastPresetSelected = val
            self:ApplyGroupPreset(val)
        end,
        width = "full",
    }

    -- Add Save Current as Preset logic
    if not self._savePresetState then
        self._savePresetState = { showInput = false, inputValue = "" }
    end
    local function showSavePresetInput()
        self._savePresetState.showInput = true
        AceConfigRegistry:NotifyChange("NAG")
    end
    local function hideSavePresetInput()
        self._savePresetState.showInput = false
        self._savePresetState.inputValue = ""
        AceConfigRegistry:NotifyChange("NAG")
    end
    local function saveCurrentAsPreset()
        local name = self._savePresetState.inputValue
        if not name or name == "" or GROUP_PRESETS[name] then
            -- Invalid or duplicate name
            return
        end
        local newPreset = {}
        local groupSettings = self.db.char.groupSettings
        for groupKey, groupSettings in pairs(groupSettings) do
            newPreset[groupKey] = {}
            for k, v in pairs(groupSettings) do
                if type(v) == "table" then
                    newPreset[groupKey][k] = CopyTable and CopyTable(v) or v
                else
                    newPreset[groupKey][k] = v
                end
            end
        end
        GROUP_PRESETS[name] = newPreset
        hideSavePresetInput()
        self._lastPresetSelected = name
        AceConfigRegistry:NotifyChange("NAG")
    end

    -- Add Save Current as Preset button and input to the options UI
    local savePresetButton = OptionsFactory:CreateExecute(L["savePresetButton"] or "Save Current as Preset", L["savePresetButtonDesc"] or "Save your current group settings as a new preset.",
        function() showSavePresetInput() end,
        { order = 0.6, width = "full" }
    )
    local savePresetInput = OptionsFactory:CreateInput(L["savePresetInput"] or "Preset Name", L["savePresetInputDesc"] or "Enter a name for your new preset.",
        function() return self._savePresetState.inputValue end,
        function(_, val) self._savePresetState.inputValue = val end,
        {
            order = 0.61,
            hidden = function() return not self._savePresetState.showInput end,
            width = "full"
        }
    )
    local savePresetConfirm = OptionsFactory:CreateExecute(L["savePresetConfirm"] or "Confirm Save", L["savePresetConfirmDesc"] or "Save the preset with the entered name.",
        function() saveCurrentAsPreset() end,
        {
            order = 0.62,
            hidden = function() return not self._savePresetState.showInput end,
            disabled = function()
                local name = self._savePresetState.inputValue
                return not name or name == "" or GROUP_PRESETS[name]
            end,
            width = "half"
        }
    )
    local savePresetCancel = OptionsFactory:CreateExecute(
        "Cancel",
        nil,
        function() hideSavePresetInput() end,
        {
            order = 0.63,
            hidden = function() return not self._savePresetState.showInput end,
            width = "half"
        }
    )

    -- New: Per-group configuration options
    local groupOptions = {
        type = "group",
        name = L["groupOptions"] or "Frame Groups (Modern)",
        order = 0,
        args = {
            masterScale = OptionsFactory:CreateRange(L["masterScale"] or "Master Scale", L["masterScaleDesc"] or "Scale the entire group display system.",
                function() return self:GetSetting("char", "groupDisplayFrame.masterScale") end,
                function(_, val)
                    self:SetSetting("char", "groupDisplayFrame.masterScale", val)
                    if NAG.GroupDisplayFrame then
                        NAG.GroupDisplayFrame:SetScale(val)
                        -- Notify other modules that frame has been updated
                        self:SendFrameUpdated("legacy_frame_position_update")
                    end
                end,
                {
                    order = 0.5,
                    min = 0.5,
                    max = 2.0,
                    step = 0.01
                }
            ),
            presetDropdown = presetDropdown,
            editMode = OptionsFactory:CreateToggle(L["editMode"] or "Edit Mode", L["editModeDesc"] or "Show all frames with placeholder icons and enable drag/move for positioning.",
                function() return DisplayManager.editMode end,
                function(_, val)
                    if val then
                        DisplayManager:EnableEditMode()
                    else
                        DisplayManager:DisableEditMode()
                    end
                end,
                { order = 1 }
            ),
            savePresetButton = savePresetButton,
            savePresetInput = savePresetInput,
            savePresetConfirm = savePresetConfirm,
            savePresetCancel = savePresetCancel,
        }
    }
    for groupKey, group in pairs(FRAME_GROUPS) do
        groupOptions.args[groupKey] = {
            type = "group",
            name = group.displayName,
            inline = false,
            order = 10 + (group.order or 0),
            args = {
                enabled = OptionsFactory:CreateToggle(
                    "Enabled",
                    nil,
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".enabled", true) end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".enabled", val)
                        DisplayManager:UpdateFrameVisibility() -- Immediately update visibility when toggled
                    end,
                    { order = 1 }
                ),
                numIcons = OptionsFactory:CreateRange(
                    "Number of Icons",
                    nil,
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".numIcons") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".numIcons", val)
                        DisplayManager:CreateGroupIcons(groupKey)
                        DisplayManager:UpdateFrameVisibility() -- Ensure visibility is correct after icon count changes
                        if DisplayManager.editMode then
                            DisplayManager:EnableEditMode()    -- Refresh edit overlay to show correct number of ? icons
                        end
                    end,
                    {
                        order = 2,
                        min = 1,
                        max = 10,
                        step = 1
                    }
                ),
                iconWidth = OptionsFactory:CreateRange(
                    "Icon Width",
                    nil,
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".iconWidth") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".iconWidth", val)
                        DisplayManager:CreateGroupIcons(groupKey)
                        if groupKey == ns.FRAME_GROUPS.MAIN then DisplayManager:UpdateGroupDisplayFrameSize() end
                        -- Notify other modules that frame has been updated
                        self:SendFrameUpdated("group_frame_position_update")
                    end,
                    {
                        order = 3,
                        min = 16,
                        max = 128,
                        step = 1
                    }
                ),
                iconHeight = OptionsFactory:CreateRange(
                    "Icon Height",
                    nil,
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".iconHeight") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".iconHeight", val)
                        DisplayManager:CreateGroupIcons(groupKey)
                        if groupKey == ns.FRAME_GROUPS.MAIN then DisplayManager:UpdateGroupDisplayFrameSize() end
                        -- Notify other modules that frame has been updated
                        self:SendFrameUpdated("group_frame_scale_update")
                    end,
                    {
                        order = 4,
                        min = 16,
                        max = 128,
                        step = 1
                    }
                ),
                iconCropStyle = OptionsFactory:CreateSelect(L["iconCropStyle"] or "Icon Crop Style", L["iconCropStyleDesc"] or "How icons are cropped in this group. 'Auto' uses direction, 'Full' shows the whole icon, 'Half' crops one axis, 'Quarter' crops both axes.",
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".iconCropStyle") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".iconCropStyle", val); DisplayManager
                            :CreateGroupIcons(groupKey)
                    end,
                    {
                        order = 4.9,
                        values = {
                            auto = "Auto (by direction)",
                            full = "Full (no crop)",
                            half = "Half (one axis)",
                            quarter = "Quarter (both axes)",
                        }
                    }
                ),
                iconFlowDirection = OptionsFactory:CreateSelect(L["iconFlowDirection"] or "Icon Flow Direction", L["iconFlowDirectionDesc"] or "Direction icons expand within this group",
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".iconFlowDirection") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".iconFlowDirection", val); DisplayManager
                            :UpdateGroupIcons(groupKey)
                    end,
                    {
                        order = 4.5,
                        values = function()
                            local t = {}
                            for _, dir in ipairs(COMPASS_DIRECTIONS) do
                                t[dir.key] = dir.label
                            end
                            return t
                        end
                    }
                ),
                scale = OptionsFactory:CreateRange(
                    "Scale",
                    nil,
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".scale") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".scale", val)
                        local frame = DisplayManager.groupFrames[groupKey]
                        if frame then frame:SetScale(val) end
                        if groupKey == ns.FRAME_GROUPS.MAIN then DisplayManager:UpdateGroupDisplayFrameSize() end
                    end,
                    {
                        order = 5,
                        min = 0.5,
                        max = 2,
                        step = 0.01
                    }
                ),
                alpha = OptionsFactory:CreateRange(
                    "Alpha",
                    nil,
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".alpha") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".alpha", val)
                        local frame = DisplayManager.groupFrames[groupKey]
                        if frame then frame:SetAlpha(val) end
                    end,
                    {
                        order = 6,
                        min = 0.1,
                        max = 1,
                        step = 0.01
                    }
                ),
                position = {
                    type = "group",
                    name = L["position"] or "Position",
                    inline = true,
                    order = 7,
                    hidden = function() return groupKey == ns.FRAME_GROUPS.MAIN end,
                    args = {
                        point = {
                            type = "select",
                            name = L["point"] or "Anchor Point",
                            values = { CENTER = "CENTER", TOP = "TOP", BOTTOM = "BOTTOM", LEFT = "LEFT", RIGHT = "RIGHT", TOPLEFT = "TOPLEFT", TOPRIGHT = "TOPRIGHT", BOTTOMLEFT = "BOTTOMLEFT", BOTTOMRIGHT = "BOTTOMRIGHT" },
                            order = 1,
                            get = function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".point") end,
                            set = function(_, val)
                                self:SetSetting("char", "groupSettings." .. groupKey .. ".point", val)
                                local frame = DisplayManager.groupFrames[groupKey]
                                if frame then
                                    local relativePoint = self:GetSetting("char",
                                        "groupSettings." .. groupKey .. ".relativePoint")
                                    local offsetX = self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetX")
                                    local offsetY = self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetY")
                                    frame:ClearAllPoints();
                                    frame:SetPoint(val, NAG.GroupDisplayFrame, relativePoint, offsetX, offsetY)
                                    -- Notify other modules that frame has been updated
                                    self:SendFrameUpdated("group_frame_main_offset_x")
                                end
                            end,
                        },
                        relativePoint = {
                            type = "select",
                            name = L["relativePoint"] or "Relative To",
                            values = { CENTER = "CENTER", TOP = "TOP", BOTTOM = "BOTTOM", LEFT = "LEFT", RIGHT = "RIGHT", TOPLEFT = "TOPLEFT", TOPRIGHT = "TOPRIGHT", BOTTOMLEFT = "BOTTOMLEFT", BOTTOMRIGHT = "BOTTOMRIGHT" },
                            order = 2,
                            get = function()
                                return self:GetSetting("char",
                                    "groupSettings." .. groupKey .. ".relativePoint")
                            end,
                            set = function(_, val)
                                self:SetSetting("char", "groupSettings." .. groupKey .. ".relativePoint", val)
                                local frame = DisplayManager.groupFrames[groupKey]
                                if frame then
                                    local point = self:GetSetting("char", "groupSettings." .. groupKey .. ".point")
                                    local offsetX = self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetX")
                                    local offsetY = self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetY")
                                    frame:ClearAllPoints();
                                    frame:SetPoint(point, NAG.GroupDisplayFrame, val, offsetX, offsetY)
                                    -- Notify other modules that frame has been updated
                                    self:SendFrameUpdated("group_frame_main_offset_y")
                                end
                            end,
                        },
                        offsetX = {
                            type = "range",
                            name = L["offsetX"] or "X Offset",
                            min = -1000,
                            max = 1000,
                            step = 1,
                            order = 3,
                            get = function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetX") end,
                            set = function(_, val)
                                self:SetSetting("char", "groupSettings." .. groupKey .. ".offsetX", val)
                                local frame = DisplayManager.groupFrames[groupKey]
                                if frame then
                                    local point = self:GetSetting("char", "groupSettings." .. groupKey .. ".point")
                                    local relativePoint = self:GetSetting("char",
                                        "groupSettings." .. groupKey .. ".relativePoint")
                                    local offsetY = self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetY")
                                    frame:ClearAllPoints();
                                    frame:SetPoint(point, NAG.GroupDisplayFrame, relativePoint, val, offsetY)
                                    -- Notify other modules that frame has been updated
                                    self:SendFrameUpdated("group_frame_main_width")
                                end
                            end,
                        },
                        offsetY = {
                            type = "range",
                            name = L["offsetY"] or "Y Offset",
                            min = -1000,
                            max = 1000,
                            step = 1,
                            order = 4,
                            get = function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetY") end,
                            set = function(_, val)
                                self:SetSetting("char", "groupSettings." .. groupKey .. ".offsetY", val)
                                local frame = DisplayManager.groupFrames[groupKey]
                                if frame then
                                    local point = self:GetSetting("char", "groupSettings." .. groupKey .. ".point")
                                    local relativePoint = self:GetSetting("char",
                                        "groupSettings." .. groupKey .. ".relativePoint")
                                    local offsetX = self:GetSetting("char", "groupSettings." .. groupKey .. ".offsetX")
                                    frame:ClearAllPoints();
                                    frame:SetPoint(point, NAG.GroupDisplayFrame, relativePoint, offsetX, val)
                                    -- Notify other modules that frame has been updated
                                    self:SendFrameUpdated("group_frame_main_height")
                                end
                            end,
                        },
                    },
                },
                iconOverlap = OptionsFactory:CreateRange(L["iconOverlap"] or "Icon Overlap/Stacking", L["iconOverlapDesc"] or "Adjust icon overlap: -1 = fully stacked, 0 = normal, 1 = far apart.",
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".iconOverlap") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".iconOverlap", val)
                        DisplayManager:CreateGroupIcons(groupKey)
                    end,
                    {
                        order = 4.7,
                        min = -1.0,
                        max = 1.0,
                        step = 0.01
                    }
                ),
                iconZoom = OptionsFactory:CreateRange(L["iconZoom"] or "Icon Zoom", L["iconZoomDesc"] or "Zoom in/out on icon: 0 = no zoom, 0.5 = max zoom.",
                    function() return self:GetSetting("char", "groupSettings." .. groupKey .. ".iconZoom") end,
                    function(_, val)
                        self:SetSetting("char", "groupSettings." .. groupKey .. ".iconZoom", val)
                        DisplayManager:CreateGroupIcons(groupKey)
                    end,
                    {
                        order = 4.8,
                        min = 0.0,
                        max = 0.5,
                        step = 0.01
                    }
                ),
            },
        }
        -- Add Reset to Defaults button at the bottom
        groupOptions.args[groupKey].args.resetDefaults = OptionsFactory:CreateExecute(L["resetDefaults"] or "Reset to Defaults", L["resetDefaultsDesc"] or "Reset all settings for this group to their default values.",
            function()
                -- Assign a fresh copy of the default settings for this group
                local defaults = groupSettingsDefaults[groupKey]
                for k, v in pairs(defaults) do
                    self:SetSetting("char", "groupSettings." .. groupKey .. "." .. k, v)
                end

                DisplayManager:CreateGroupIcons(groupKey)
                local frame = DisplayManager.groupFrames[groupKey]
                if frame then
                    frame:SetScale(defaults.scale)
                    frame:SetAlpha(defaults.alpha)
                    frame:ClearAllPoints()
                    frame:SetPoint(
                        defaults.point,
                        NAG.GroupDisplayFrame,
                        defaults.relativePoint,
                        defaults.offsetX,
                        defaults.offsetY
                    )
                end
            end,
            { order = 1000 }
        )
    end

    -- Composers for frame groups are applied automatically in unified phase

    local visibilityOptions = {
        type = "group",
        name = L["displayVisibility"] or "Display Visibility",
        order = 0.1,
        inline = true,
        args = {
            enableAlways = OptionsFactory:CreateToggle(
                L["enableAlways"],
                nil,
                function(info) return self:GetSetting("char", "enableAlways") end,
                function(info, value)
                    self:SetSetting("char", "enableAlways", value)
                    if value then
                        self:SetSetting("char", "enableOutOfCombat", true)
                    end
                end,
                { order = 1 }
            ),
            enableOutOfCombat = OptionsFactory:CreateToggle(
                L["enableOutOfCombat"],
                nil,
                function(info) return self:GetSetting("char", "enableOutOfCombat") end,
                function(info, value) self:SetSetting("char", "enableOutOfCombat", value) end,
                {
                    order = 2,
                    hidden = function() return self:GetSetting("char", "enableAlways") end,
                }
            ),
            hideDuringPetBattles = OptionsFactory:CreateToggle(
                L["hideDuringPetBattles"] or "Hide During Pet Battles",
                L["hideDuringPetBattlesDesc"] or "Hide NAG frames during pet battles",
                function(info) return self:GetSetting("char", "hideDuringPetBattles") end,
                function(info, value) self:SetSetting("char", "hideDuringPetBattles", value) end,
                { order = 3 }
            ),
            hideDuringVehicles = OptionsFactory:CreateToggle(
                L["hideDuringVehicles"] or "Hide During Vehicles",
                L["hideDuringVehiclesDesc"] or "Hide NAG frames when in a vehicle or when vehicle UI is active",
                function(info) return self:GetSetting("char", "hideDuringVehicles") end,
                function(info, value) self:SetSetting("char", "hideDuringVehicles", value) end,
                { order = 4 }
            ),
            showDKDiseaseSnapshot = OptionsFactory:CreateToggle(
                L["showDKDiseaseSnapshot"] or "Show DK Disease Snapshot",
                L["showDKDiseaseSnapshotDesc"] or "Show disease snapshot status above ability icons (Death Knight only)",
                function() return self:GetSnapshotOverlayEnabled("dk_disease") end,
                function(_, value)
                    self:SetSnapshotOverlayEnabled("dk_disease", value)
                    self:UpdateAllSnapshotOverlays()
                end,
                { order = 5, hidden = function() return NAG.CLASS_FILENAME ~= "DEATHKNIGHT" end }
            ),
            showDKDiseaseSnapshotDPS = OptionsFactory:CreateToggle(
                L["showDKDiseaseSnapshotDPS"] or "Show as DPS",
                L["showDKDiseaseSnapshotDPSDesc"] or "Show snapped disease DPS instead of snapshot percent",
                function() return self:GetSnapshotOverlayShowDPS("dk_disease") end,
                function(_, value)
                    self:SetSnapshotOverlayShowDPS("dk_disease", value)
                    self:UpdateAllSnapshotOverlays()
                end,
                {
                    order = 6,
                    hidden = function()
                        return NAG.CLASS_FILENAME ~= "DEATHKNIGHT" or not self:GetSnapshotOverlayEnabled("dk_disease")
                    end,
                }
            ),
            dkDiseaseOverlayLocked = OptionsFactory:CreateToggle(
                L["dkDiseaseOverlayLocked"] or "Lock Snapshot Overlay",
                L["dkDiseaseOverlayLockedDesc"] or "Lock the snapshot overlay position so it cannot be accidentally dragged",
                function() return self:GetSnapshotOverlayLocked("dk_disease") end,
                function(_, value)
                    self:SetSnapshotOverlayLocked("dk_disease", value)
                    self:UpdateAllSnapshotOverlays()
                end,
                {
                    order = 7,
                    hidden = function()
                        return NAG.CLASS_FILENAME ~= "DEATHKNIGHT" or not self:GetSnapshotOverlayEnabled("dk_disease")
                    end,
                }
            ),
        },
    }

    -- Screensaver Options
    local screensaverOptions = {
        type = "group",
        name = L["screensaver"] or "Screensaver",
        order = 0.25,
        inline = true,
        hidden = function() return not self:IsGroupDisplayMode() end,
        args = {
            enabled = OptionsFactory:CreateToggle(
                L["screensaverEnabled"] or "Enable Screensaver",
                L["screensaverEnabledDesc"] or "Enable automatic screensaver that bounces the display around the screen when idle",
                function() return self:GetSetting("char", "screensaver.enabled") end,
                function(_, value)
                    self:SetSetting("char", "screensaver.enabled", value)
                    if value then
                        -- Start idle check timer
                        self.screensaver.lastInputTime = GetTime()
                        if not self.screensaver.idleCheckTimer then
                            self.screensaver.idleCheckTimer = C_Timer.NewTicker(1, function()
                                DisplayManager:CheckScreensaverIdle()
                            end)
                        end
                    else
                        -- Stop screensaver and cancel timer
                        if self.screensaver.active then
                            self:StopScreensaver()
                        end
                        if self.screensaver.idleCheckTimer then
                            self.screensaver.idleCheckTimer:Cancel()
                            self.screensaver.idleCheckTimer = nil
                        end
                    end
                end,
                { order = 1 }
            ),
            idleTime = OptionsFactory:CreateRange(
                L["screensaverIdleTime"] or "Idle Time (seconds)",
                L["screensaverIdleTimeDesc"] or "Time in seconds before screensaver activates automatically",
                function() return self:GetSetting("char", "screensaver.idleTime") end,
                function(_, value) self:SetSetting("char", "screensaver.idleTime", value) end,
                {
                    order = 2,
                    min = 30,
                    max = 300,
                    step = 5,
                    disabled = function() return not self:GetSetting("char", "screensaver.enabled") end
                }
            ),
            speed = OptionsFactory:CreateRange(
                L["screensaverSpeed"] or "Speed",
                L["screensaverSpeedDesc"] or "How fast the display moves around the screen (pixels per second)",
                function() return self:GetSetting("char", "screensaver.speed") end,
                function(_, value) self:SetSetting("char", "screensaver.speed", value) end,
                {
                    order = 3,
                    min = 50,
                    max = 300,
                    step = 10,
                    disabled = function() return not self:GetSetting("char", "screensaver.enabled") end
                }
            ),
            manualToggle = OptionsFactory:CreateExecute(
                L["screensaverToggle"] or "Toggle Screensaver",
                L["screensaverToggleDesc"] or "Manually start or stop the screensaver",
                function()
                    if self.screensaver.active then
                        self:StopScreensaver()
                    else
                        self:StartScreensaver()
                    end
                end,
                {
                    order = 4,
                    disabled = function() return not self:GetSetting("char", "screensaver.enabled") or not self:IsGroupDisplayMode() end
                }
            ),
        },
    }

    -- Frame System Controls
    local frameSystemOptions = {
        type = "group",
        name = L["frameSystemOptions"] or "Frame System",
        desc = L["frameSystemOptionsDesc"] or "Control which frame display system to use",
        order = 0.2,
        inline = true,
        args = {
            useGroupDisplayMode = OptionsFactory:CreateToggle(L["useGroupDisplayMode"] or "Use New Group Display System", L["useGroupDisplayModeDesc"] or "Switch between legacy and new group-based icon display systems.",
                function() return self:GetSetting("char", "useGroupDisplayMode") end,
                function(_, val)
                    self:SetSetting("char", "useGroupDisplayMode", val)
                    self:UpdateFrameVisibility()
                end,
                { order = 1, requiresReload = true }
            ),
            legacyFrameEnabled = OptionsFactory:CreateToggle(L["legacyFrameEnabled"] or "Legacy Frame Enabled", L["legacyFrameEnabledDesc"] or "Show or hide the legacy (single-frame) display system.",
                function() return self:GetSetting("char", "frameSettings.enabled") ~= false end,
                function(_, val)
                    self:SetSetting("char", "frameSettings.enabled", val)
                    self:UpdateFrameVisibility()
                end,
                { order = 2 }
            ) or nil,
            showRoundMaskPreview = OptionsFactory:CreateToggle(
                L["showRoundMaskPreview"] or "Round Icon Mask (Preview)",
                L["showRoundMaskPreviewDesc"] or "Use round-masked icons in both group display and legacy frame systems.",
                function() return self:GetSetting("char", "showRoundMaskPreview") end,
                function(_, val)
                    self:SetSetting("char", "showRoundMaskPreview", val)
                    self:ApplyRoundMaskPreviewVisibilityAll()
                    self:ApplyRoundMaskToLegacyFrames()
                end,
                {
                    order = 3,
                    disabled = function() return not self:IsGroupDisplayMode() and not self:IsLegacyFrameEnabled() end,
                }
            ),
        },
    }

    -- Add options UI for mapping spell positions to groups
    local spellPositions = {
        ns.SPELL_POSITIONS.PRIMARY,
        ns.SPELL_POSITIONS.AOE,
        ns.SPELL_POSITIONS.LEFT,
        ns.SPELL_POSITIONS.RIGHT,
        ns.SPELL_POSITIONS.ABOVE, -- Maps to defensives in new system
        ns.SPELL_POSITIONS.BELOW  -- Maps to interrupts in new system
    }
    local groupKeys = {}
    for k in pairs(FRAME_GROUPS) do table.insert(groupKeys, k) end
    local mappingOptions = {
        type = "group",
        name = L["mappingOptions"] or "Position-to-Group Mapping",
        order = 99,
        args = {},
    }
    for _, position in ipairs(spellPositions) do
        mappingOptions.args[position] = {
            type = "select",
            name = "Map '" .. position .. "' to group",
            desc = "Choose which group receives icons from the spell position '" .. position .. "'.",
            values = function()
                local t = {}
                for _, g in ipairs(groupKeys) do t[g] = g end
                return t
            end,
            get = function()
                local mapping = self:GetSetting("char", "groupToPositionMapping")
                return mapping[position] or position
            end,
            set = function(_, val)
                local mapping = self:GetSetting("char", "groupToPositionMapping")
                mapping[position] = val
                self:SetSetting("char", "groupToPositionMapping", mapping)
            end,
            order = 10 + _,
        }
    end

    -- Create a consolidated Group Control section
    local groupControlOptions = {
        type = "group",
        name = L["groupControlOptions"] or "Group Control",
        desc = L["groupControlOptionsDesc"] or "Control frame groups and display settings",
        order = 1,
        childGroups = "tree",
        args = {
            groupFramesModern = groupOptions,
            mappingOptions = mappingOptions,
        }
    }

    -- Create frameControls as a separate section (for legacy frame system)
    local frameControlsOptions = hasEnabledModule and {
        type = "group",
        name = L["groupControlOptions"] or "Frame Controls (Legacy)",
        desc = L["groupControlOptionsDesc"] or "Settings for the legacy single-frame display system",
        order = 3, -- After Group Control
        args = {
            toggleEditMode = {
                type = "toggle",
                name = L["unlockFrame"],
                desc = L["unlockFrameDescription"],
                order = 1,
                get = function()
                    return NAG:IsAnyEditMode()
                end,
                set = function(_, value)
                    if value then
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
                end,
            },
            disableIconOverflow = OptionsFactory:CreateToggle(L["disableIconOverflow"] or "Disable Icon Overflow", L["disableIconOverflowDesc"] or "When enabled, icons that exceed their configured position slots will be hidden instead of overflowing to the left position.",
                function() return self:GetSetting("char", "disableIconOverflow") end,
                function(_, value) self:SetSetting("char", "disableIconOverflow", value) end,
                { order = 1.5 }
            ),
            frameSettings = {
                type = "group",
                name = L["framePosition"],
                order = 2,
                inline = true,
                args = {
                    offsetX = {
                        type = "range",
                        name = L["offsetX"],
                        order = 1,
                        min = floor(-GetScreenWidth() / 2),
                        max = ceil(GetScreenWidth() / 2),
                        step = 1,
                        get = function(info) return self:GetSetting("char", "frameSettings.offsetX") end,
                        set = function(info, value)
                            self:SetSetting("char", "frameSettings.offsetX", value)
                            DisplayManager:UpdateFramePosition()
                        end,
                    },
                    offsetY = {
                        type = "range",
                        name = L["offsetY"],
                        order = 2,
                        min = floor(-GetScreenHeight() / 2),
                        max = ceil(GetScreenHeight() / 2),
                        step = 1,
                        get = function(info) return self:GetSetting("char", "frameSettings.offsetY") end,
                        set = function(info, value)
                            self:SetSetting("char", "frameSettings.offsetY", value)
                            DisplayManager:UpdateFramePosition()
                        end,
                    },
                    scale = {
                        type = "range",
                        name = L["scale"],
                        order = 3,
                        min = 0.5,
                        max = 2,
                        step = 0.1,
                        get = function(info) return self:GetSetting("char", "frameSettings.scale") end,
                        set = function(info, value)
                            self:SetSetting("char", "frameSettings.scale", value)
                            DisplayManager:UpdateFrameScale()
                        end,
                    },
                },
            },
            frames = hasEnabledModule and {
                type = "group",
                name = L["frameSettings"],
                inline = true,
                order = 13,
                args = {
                    advancedSettings = {
                        type = "toggle",
                        name = L["advancedSettings"],
                        order = 1,
                        get = function(info) return self:GetSetting("char", "advancedSettings") end,
                        set = function(info, value) self:SetSetting("char", "advancedSettings", value) end,
                    },
                    advancedContainer = {
                        type = "group",
                        name = L["advancedSettings"],
                        order = 2,
                        inline = true,
                        hidden = function() return not self:GetSetting("char", "advancedSettings") end,
                        args = {
                            numLeftIcons = {
                                type = "range",
                                name = L["numberOfLeftIcons"],
                                order = 1,
                                min = 0,
                                max = 10,
                                step = 1,
                                get = function(info) return self:GetSetting("char", "numLeftIcons") end,
                                set = function(info, value)
                                    self:SetSetting("char", "numLeftIcons", value)
                                    DisplayManager:CreateOrUpdateIconFrames(NAG.Frame)
                                end,
                            },
                            numRightIcons = {
                                type = "range",
                                name = L["numberOfRightIcons"],
                                order = 2,
                                min = 0,
                                max = 10,
                                step = 1,
                                get = function(info) return self:GetSetting("char", "numRightIcons") end,
                                set = function(info, value)
                                    self:SetSetting("char", "numRightIcons", value)
                                    DisplayManager:CreateOrUpdateIconFrames(NAG.Frame)
                                end,
                            },
                            numBelowIcons = {
                                type = "range",
                                name = L["numberOfBelowIcons"],
                                order = 3,
                                min = 0,
                                max = 10,
                                step = 1,
                                get = function(info) return self:GetSetting("char", "numBelowIcons") end,
                                set = function(info, value)
                                    self:SetSetting("char", "numBelowIcons", value)
                                    DisplayManager:CreateOrUpdateIconFrames(NAG.Frame)
                                end,
                            },
                            numAboveIcons = {
                                type = "range",
                                name = L["numberOfAboveIcons"],
                                order = 4,
                                min = 0,
                                max = 10,
                                step = 1,
                                get = function(info) return self:GetSetting("char", "numAboveIcons") end,
                                set = function(info, value)
                                    self:SetSetting("char", "numAboveIcons", value)
                                    DisplayManager:CreateOrUpdateIconFrames(NAG.Frame)
                                end,
                            },
                            frameSpacing = {
                                type = "range",
                                name = L["frameSpacing"],
                                desc = L["frameSpacingDesc"],
                                order = 5,
                                min = 0,
                                max = 10,
                                step = 1,
                            },
                            frameWeight = {
                                type = "range",
                                name = L["frameWeight"],
                                order = 6,
                                min = 0.1,
                                max = 1.0,
                                step = 0.1,
                            },
                            frameLevel = {
                                type = "range",
                                name = L["frameLevel"],
                                order = 7,
                                min = 1,
                                max = 100,
                                step = 1,
                                hidden = function() return NAG:IsDevModeEnabled() end,
                                get = function() return self:GetSetting("char", "frameLevel") end,
                                set = function(_, val) self:SetSetting("char", "frameLevel", val) end,
                            },
                        },
                    },
                },
            } or nil,
        },
    } or nil

    -- Composers for legacy frame controls are applied automatically in unified phase

    local opts = {
        visibility = visibilityOptions,
        screensaver = screensaverOptions,
        anchor = {
            type = "group",
            name = L["anchor"] or "External Anchor",
            order = 0.15,
            inline = true,
            args = {
                enableAnchorParent = OptionsFactory:CreateToggle(L["enableAnchorParent"] or "Enable Parent Anchor", L["enableAnchorParentDesc"] or "Parent NAG frames to another frame (inherits fades/alpha).",
                    function() return self:GetSetting("char", "anchorParent.enabled") end,
                    function(_, val)
                        self:SetSetting("char", "anchorParent.enabled", val)
                        -- Reset to safe center when toggling to avoid off-screen offsets
                        DisplayManager:ResetAnchorOffsetsToCenter()
                        DisplayManager:ApplyAnchorParent()
                        DisplayManager:UpdateFrameVisibility()
                    end,
                    { order = 1 }
                ),
                anchorParentName = OptionsFactory:CreateInput(L["anchorParentName"] or "Parent Frame Name", L["anchorParentNameDesc"] or "Exact global frame name (e.g., 'ElvUF_Player').",
                    function() return self:GetSetting("char", "anchorParent.frameName") or "" end,
                    function(_, val)
                        self:SetSetting("char", "anchorParent.frameName", val or "")
                        -- Reset to safe center when changing target parent
                        DisplayManager:ResetAnchorOffsetsToCenter()
                        DisplayManager:ApplyAnchorParent()
                        DisplayManager:UpdateFrameVisibility()
                    end,
                    {
                        order = 2,
                        width = "full",
                        disabled = function()
                            return not self:GetSetting("char",
                                "anchorParent.enabled")
                        end
                    }
                ),
            }
        },
        frameSystem = frameSystemOptions,
        groupControl = groupControlOptions,
        frameControls = frameControlsOptions,
        suggestions = hasEnabledModule and {
            type = "group",
            name = L["suggestions"],
            order = 2,
            args = {
                enableBuffSuggestions = {
                    type = "toggle",
                    name = L["enableBuffSuggestions"],
                    order = 1,
                    width = "full",
                    get = function(info) return self.db.char.enableBuffSuggestions end,
                    set = function(info, value) self.db.char.enableBuffSuggestions = value end,
                },
                enableDebuffSuggestions = {
                    type = "toggle",
                    name = L["enableDebuffSuggestions"],
                    order = 2,
                    width = "full",
                    get = function(info) return self.db.char.enableDebuffSuggestions end,
                    set = function(info, value) self.db.char.enableDebuffSuggestions = value end,
                },
                buffSuggestionThreshold = {
                    type = "range",
                    name = L["buffSuggestionThreshold"],
                    order = 3,
                    width = "full",
                    min = 0,
                    max = 100,
                    step = 1,
                    get = function(info) return self.db.char.buffSuggestionThreshold end,
                    set = function(info, value) self.db.char.buffSuggestionThreshold = value end,
                },
            },
        } or nil,
        tooltips = hasEnabledModule and {
            type = "group",
            name = L["tooltips"],
            order = 5,
            args = {
                enableTooltips = OptionsFactory:CreateToggle(
                    L["enableTooltips"],
                    L["enableTooltipsDesc"],
                    function(info) return self.db.global.enableTooltips end,
                    function(info, value)
                        self.db.global.enableTooltips = value
                        DisplayManager:RefreshAllTooltips()
                    end,
                    { order = 1 }
                ),
                mouseInteractionKey = OptionsFactory:CreateSelect(
                    L["tooltipKey"],
                    nil,
                    function() return self:GetSetting("char", "mouseInteractionKey") end,
                    function(_, val)
                        self:SetSetting("char", "mouseInteractionKey", val); self:RefreshAllTooltips()
                    end,
                    {
                        order = 2,
                        values = {
                            ["NONE"] = "None",
                            ["ALT"] = "Alt",
                            ["SHIFT"] = "Shift",
                            ["CONTROL"] = "Control",
                        },
                        hidden = function() return not self.db.global.enableTooltips end
                    }
                ),
            },
        } or nil,
        cooldowns = hasEnabledModule and {
            type = "group",
            name = L["Cooldown Display"] or "Cooldown Display",
            order = 6,
            args = {
                enableCooldownSwipes = OptionsFactory:CreateToggle(L["enableCooldownSwipes"] or "Enable Cooldown Swipes", L["enableCooldownSwipesDesc"] or "Show cooldown swipe animations on spell and item icons",
                    function() return self:AreCooldownSwipesEnabled() end,
                    function(_, value)
                        self:SetCooldownSwipesEnabled(value)
                    end,
                    { order = 1, requiresReload = true }
                ),
            },
        } or nil,
        borders = hasEnabledModule and {
            type = "group",
            name = L["borders"],
            order = 1,
            args = {
                enableBorders =                     OptionsFactory:CreateToggle(
                    L["enableBorders"],
                    nil,
                    function(info) return self:GetSetting("char", "enableBorders") end,
                    function(info, value)
                        self:SetSetting("char", "enableBorders", value)
                        -- Just toggle visibility, don't recreate
                        self:RefreshAllBorders()
                    end,
                    { order = 1 }
                ),
                borderSettings = {
                    type = "group",
                    name = L["borderSettings"],
                    order = 2,
                    inline = true,
                    hidden = function() return not self:GetSetting("char", "enableBorders") end,
                    args = {
                        borderColor = OptionsFactory:CreateColor(
                            L["borderColor"],
                            nil,
                            function() return unpack(self:GetSetting("char", "borderColor")) end,
                            function(_, r, g, b, a)
                                self:SetSetting("char", "borderColor", { r, g, b, a })
                                -- Recreate borders to apply new color
                                self:RecreateAllBorders()
                            end,
                            {
                                order = 1,
                                hasAlpha = true
                            }
                        ),
                        borderThickness = OptionsFactory:CreateRange(
                            L["borderThickness"],
                            nil,
                            function() return self:GetSetting("char", "borderThickness") end,
                            function(_, value)
                                self:SetSetting("char", "borderThickness", value)
                                -- Recreate borders to apply new thickness
                                self:RecreateAllBorders()
                            end,
                            {
                                order = 2,
                                min = 1,
                                max = 10,
                                step = 1
                            }
                        ),
                        borderInset = OptionsFactory:CreateRange(
                            L["borderInset"],
                            nil,
                            function() return self:GetSetting("char", "borderInset") end,
                            function(_, value)
                                self:SetSetting("char", "borderInset", value)
                                -- Recreate borders to apply new inset
                                self:RecreateAllBorders()
                            end,
                            {
                                order = 3,
                                min = 0,
                                max = 10,
                                step = 1
                            }
                        ),
                    },
                },
            },
        } or nil,
    }
    return {
        type = "group",
        name = L["display"] or "Display",
        order = self.optionsOrder or 20,
        desc = L["Display and frame management settings"] or "Display and frame management settings",
        args = opts
    }
end

function DisplayManager:ResetFrameSettingsToDefault()
    -- AceDB best-practice: clear the sub-table and re-register defaults
    self.db.char.frameSettings = nil
    if self.defaults then
        self.db:RegisterDefaults(self.defaults)
    end
    -- Reset group display frame position to center
    self.db.char.groupDisplayFrame.point = "CENTER"
    self.db.char.groupDisplayFrame.relativePoint = "CENTER"
    self.db.char.groupDisplayFrame.offsetX = 0
    self.db.char.groupDisplayFrame.offsetY = 0
    local parent = self:GetAnchorParent()
    if NAG.GroupDisplayFrame and parent then
        pcall(function()
            NAG.GroupDisplayFrame:ClearAllPoints()
            NAG.GroupDisplayFrame:SetPoint("CENTER", parent, "CENTER", 0, 0)
        end)
    end
    -- Reset snapshot overlay positions to auto-anchor (above main icons)
    if self.db.char.snapshotOverlays then
        for overlayId, data in pairs(self.db.char.snapshotOverlays) do
            if data and type(data) == "table" and data.pos then
                data.pos.custom = false
                data.pos.point = "CENTER"
                data.pos.relativePoint = "CENTER"
                data.pos.x = 0
                data.pos.y = 0
            end
        end
        self:UpdateAllSnapshotOverlays()
    end
    -- Force a refresh to ensure changes are applied
    self:UpdateFramePosition()
    self:UpdateFrameScale()
end

function DisplayManager:IsGroupDisplayMode()
    return self.db.char.useGroupDisplayMode
end

function DisplayManager:IsLegacyFrameEnabled()
    return self.db.char.frameSettings.enabled ~= false
end

--- Check if the main display is temporarily suppressed
--- @return boolean True when frames should remain hidden
function DisplayManager:IsDisplaySuppressed()
    return self.displaySuppressed == true
end

--- Temporarily suppress or restore the main display frames
--- @param suppressed boolean True to hide display frames
function DisplayManager:SetDisplaySuppressed(suppressed)
    self.displaySuppressed = suppressed == true
    self:UpdateFrameVisibility()
end

local CACHED_PRIMARY_FRAMES = {}

--- Returns all active primary icon frames (legacy and/or group display)
--- This helper function enables features to work on both display systems simultaneously
--- @return table Array of frames to show features on (overlays, notifications, etc.)
--- Returns the icon frame for a position key (primary, aoe, left1, right1, etc.) for overlay targeting.
--- Resolves both legacy and group display frames.
--- @param positionKey string Normalized position (e.g. "primary", "aoe", "left1")
--- @return Frame|nil
function DisplayManager:GetFrameForPosition(positionKey)
    if not positionKey or positionKey == "" then return nil end
    local key = strlower(tostring(positionKey))
    local baseKey = key
    local iconIndex = 1
    local num = strmatch(key, "(%d+)$")
    if num then
        iconIndex = tonumber(num) or 1
        baseKey = strmatch(key, "^(%a+)") or key
    end
    -- Group display frames
    if self:IsGroupDisplayMode() and self.groupFrames then
        local groupKey = self:PositionToGroup(baseKey)
        local frame = self.groupFrames[groupKey]
        if frame and frame.iconFrames and frame.iconFrames[iconIndex] then
            local icon = frame.iconFrames[iconIndex]
            if self:IsRoundMaskPreviewEnabled(groupKey) and frame.roundIconFrames and frame.roundIconFrames[iconIndex] then
                return frame.roundIconFrames[iconIndex]
            end
            return icon
        end
    end

    -- Legacy frames (fallback only when legacy display is enabled)
    if self:IsLegacyFrameEnabled() and NAG.Frame and NAG.Frame.iconFrames then
        -- When round mask is on, we hide square icons and show round icons; overlays must attach to the visible frame.
        if self:IsRoundMaskPreviewEnabled() and NAG.Frame.roundIconFrames then
            local roundFrame = NAG.Frame.roundIconFrames[key] or NAG.Frame.roundIconFrames[baseKey]
            if not roundFrame and key == "primary" then
                roundFrame = NAG.Frame.roundIconFrames[ns.SPELL_POSITIONS.PRIMARY]
            end
            if roundFrame then return roundFrame end
        end
        local frame = NAG.Frame.iconFrames[key] or NAG.Frame.iconFrames[baseKey]
        if frame then return frame end
        if key == "primary" then
            frame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]
            if frame then return frame end
        end
    end
    return nil
end

function DisplayManager:GetActivePrimaryFrames()
    wipe(CACHED_PRIMARY_FRAMES)

    -- Add group display main frame (first icon)
    if self:IsGroupDisplayMode() then
        local mainGroupFrame = self.groupFrames and self.groupFrames[ns.FRAME_GROUPS.MAIN]
        if mainGroupFrame and mainGroupFrame.iconFrames and mainGroupFrame.iconFrames[1] then
            local primaryFrame = mainGroupFrame.iconFrames[1]
            if self:IsRoundMaskPreviewEnabled(ns.FRAME_GROUPS.MAIN) and mainGroupFrame.roundIconFrames and mainGroupFrame.roundIconFrames[1] then
                primaryFrame = mainGroupFrame.roundIconFrames[1]
            end
            tinsert(CACHED_PRIMARY_FRAMES, primaryFrame)
        end
    end

    -- Add legacy primary frame
    if self:IsLegacyFrameEnabled() and NAG.Frame and NAG.Frame.iconFrames then
        local primary = NAG.Frame.iconFrames["primary"]
        if primary then
            tinsert(CACHED_PRIMARY_FRAMES, primary)
        end
    end

    return CACHED_PRIMARY_FRAMES
end

function DisplayManager:UpdateFrameVisibility()
    local showLegacy = self:IsLegacyFrameEnabled()
    local showGroup = self:IsGroupDisplayMode()
    -- Use centralized visibility logic (same as borders)
    local allowShow = self:IsDisplayAllowed()
    if NAG.Frame then
        if showLegacy and allowShow then
            NAG.Frame:Show()
            -- CRITICAL: Hide empty legacy icon frames to prevent empty borders from showing
            -- GroupFrame handles this automatically by only showing icons with content
            if NAG.Frame.iconFrames then
                for _, iconFrame in pairs(NAG.Frame.iconFrames) do
                    if not iconFrame.spellId and not iconFrame.itemId then
                        iconFrame:Hide()
                    end
                end
                local aoeFrame = NAG.Frame.iconFrames[ns.SPELL_POSITIONS.AOE]
                if aoeFrame and not self:IsAoeFrameEnabled() then
                    aoeFrame:Hide()
                end
            end
        else
            NAG.Frame:Hide()
        end
    end
    if NAG.GroupDisplayFrame then
        if showGroup and allowShow then
            NAG.GroupDisplayFrame:Show()
        else
            NAG.GroupDisplayFrame:Hide()
        end
    end
    -- Show/hide each group frame based on its enabled setting
    for groupKey, frame in pairs(self.groupFrames) do
        local enabled = self:IsGroupEnabled(groupKey)
        if frame then
            if showGroup and enabled and allowShow then
                frame:Show()
            else
                frame:Hide()
            end
        end
    end
    self:ApplyRoundMaskPreviewVisibilityAll()

    -- Sync border visibility with frame visibility
    self:RefreshAllBorders()

    -- Update snapshot overlays (above main icons, per-profile visibility)
    self:UpdateAllSnapshotOverlays()

    -- Notify other modules that frame visibility has been updated
    self:SendFrameUpdated("update_group_frame_settings")
end

-- ============================ SNAPSHOT OVERLAY (GENERIC) ============================

--- Get enabled state for a snapshot overlay (with backward compat for dk_disease legacy keys).
--- @param overlayId string
--- @return boolean
function DisplayManager:GetSnapshotOverlayEnabled(overlayId)
    local so = self.db.char.snapshotOverlays
    if so and so[overlayId] and so[overlayId].enabled ~= nil then
        return so[overlayId].enabled
    end
    if overlayId == "dk_disease" then
        return self:GetSetting("char", "showDKDiseaseSnapshot", true)
    end
    return false
end

--- Get showDPS state for a snapshot overlay (with backward compat for dk_disease).
--- @param overlayId string
--- @return boolean
function DisplayManager:GetSnapshotOverlayShowDPS(overlayId)
    local so = self.db.char.snapshotOverlays
    if so and so[overlayId] and so[overlayId].showDPS ~= nil then
        return so[overlayId].showDPS
    end
    if overlayId == "dk_disease" then
        return self:GetSetting("char", "showDKDiseaseSnapshotDPS", false)
    end
    return false
end

--- Set enabled for a snapshot overlay (writes to snapshotOverlays; legacy dk_disease also updates showDKDiseaseSnapshot).
--- @param overlayId string
--- @param value boolean
function DisplayManager:SetSnapshotOverlayEnabled(overlayId, value)
    if not self.db.char.snapshotOverlays then
        self.db.char.snapshotOverlays = {}
    end
    if not self.db.char.snapshotOverlays[overlayId] then
        self.db.char.snapshotOverlays[overlayId] = {}
    end
    self.db.char.snapshotOverlays[overlayId].enabled = value
    if overlayId == "dk_disease" then
        self:SetSetting("char", "showDKDiseaseSnapshot", value)
    end
end

--- Set showDPS for a snapshot overlay.
--- @param overlayId string
--- @param value boolean
function DisplayManager:SetSnapshotOverlayShowDPS(overlayId, value)
    if not self.db.char.snapshotOverlays then
        self.db.char.snapshotOverlays = {}
    end
    if not self.db.char.snapshotOverlays[overlayId] then
        self.db.char.snapshotOverlays[overlayId] = {}
    end
    self.db.char.snapshotOverlays[overlayId].showDPS = value
    if overlayId == "dk_disease" then
        self:SetSetting("char", "showDKDiseaseSnapshotDPS", value)
    end
end

--- Get locked state for a snapshot overlay (default: true).
--- @param overlayId string
--- @return boolean
function DisplayManager:GetSnapshotOverlayLocked(overlayId)
    local so = self.db.char.snapshotOverlays
    if so and so[overlayId] and so[overlayId].locked ~= nil then
        return so[overlayId].locked
    end
    return true
end

--- Set locked state for a snapshot overlay.
--- @param overlayId string
--- @param value boolean
function DisplayManager:SetSnapshotOverlayLocked(overlayId, value)
    if not self.db.char.snapshotOverlays then
        self.db.char.snapshotOverlays = {}
    end
    if not self.db.char.snapshotOverlays[overlayId] then
        self.db.char.snapshotOverlays[overlayId] = {}
    end
    self.db.char.snapshotOverlays[overlayId].locked = value
end

--- Returns the frame to anchor snapshot overlays above (group or legacy primary).
--- Uses a single stable anchor so the overlay does not jump when events re-run (avoid switching between MAIN and GroupDisplayFrame).
--- @return table|nil
function DisplayManager:GetSnapshotOverlayAnchorFrame()
    if self:IsGroupDisplayMode() then
        -- Prefer GroupDisplayFrame (the outer frame that moves) so we never switch anchors and cause the overlay to jump
        if NAG.GroupDisplayFrame then
            return NAG.GroupDisplayFrame
        end
        return self.groupFrames and self.groupFrames[ns.FRAME_GROUPS.MAIN]
    end
    if self:IsLegacyFrameEnabled() and NAG.Frame then
        return NAG.Frame
    end
    return nil
end

--- Create the snapshot overlay frame for an overlay id (once per id).
--- @param overlayId string
function DisplayManager:EnsureSnapshotOverlay(overlayId)
    if not NAG.SnapshotOverlays then
        NAG.SnapshotOverlays = {}
    end
    if NAG.SnapshotOverlays[overlayId] then return end

    local frameName = "NAGSnapshotOverlay_" .. overlayId
    local overlay = CreateFrame("Frame", frameName, UIParent)
    overlay:SetSize(140, 36)
    overlay:SetFrameStrata("MEDIUM")
    overlay:SetMovable(true)
    overlay:SetClampedToScreen(true)
    overlay:EnableMouse(false)
    overlay:RegisterForDrag("LeftButton")

    local label = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOP", overlay, "TOP", 0, 0)
    label:SetJustifyH("CENTER")
    label:SetJustifyV("TOP")
    overlay.label = label

    local sublabel = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    sublabel:SetPoint("TOP", label, "BOTTOM", 0, -2)
    sublabel:SetJustifyH("CENTER")
    sublabel:SetJustifyV("TOP")
    overlay.sublabel = sublabel

    local dm = self
    overlay:SetScript("OnDragStart", function(f)
        if dm:GetSnapshotOverlayLocked(overlayId) then return end
        f.isDragging = true
        f:StartMoving()
    end)
    overlay:SetScript("OnDragStop", function(f)
        f:StopMovingOrSizing()
        f.isDragging = nil
        local anchor = dm:GetSnapshotOverlayAnchorFrame()
        if not anchor then return end
        -- WoW can reparent the frame during StartMoving(), so GetPoint() may be relative to wrong frame.
        -- Save position using screen-space centers, convert to anchor-relative (scaled) offset.
        local ox, oy = f:GetCenter()
        local ax, ay = anchor:GetCenter()
        if not ox or not oy or not ax or not ay then return end
        local scale = anchor:GetEffectiveScale()
        if not scale or scale <= 0 then scale = 1 end
        local offsetX = (ox - ax) / scale
        local offsetY = (oy - ay) / scale
        local so = dm.db.char.snapshotOverlays
        if so and so[overlayId] then
            local pos = so[overlayId].pos or {}
            so[overlayId].pos = pos
            pos.custom = true
            pos.point = "CENTER"
            pos.relativePoint = "CENTER"
            pos.x = offsetX
            pos.y = offsetY
        end
        -- Re-parent to anchor and apply the saved offset so overlay stays where user dropped it and moves with the frame
        f:ClearAllPoints()
        f:SetParent(anchor)
        f:SetPoint("CENTER", anchor, "CENTER", offsetX, offsetY)
    end)

    -- Right-click resets to auto-anchor
    overlay:SetScript("OnMouseUp", function(_, btn)
        if btn == "RightButton" then
            local so = dm.db.char.snapshotOverlays
            if so and so[overlayId] and so[overlayId].pos then
                so[overlayId].pos.custom = false
            end
            dm:UpdateSnapshotOverlay(overlayId)
        end
    end)

    overlay:Hide()
    NAG.SnapshotOverlays[overlayId] = overlay
end

--- Update a single snapshot overlay by profile id (visibility and text).
--- @param overlayId string Same as Snapshotter profile id (e.g. "dk_disease").
function DisplayManager:UpdateSnapshotOverlay(overlayId)
    local Snapshotter = NAG:GetModule("Snapshotter")
    if not Snapshotter or not Snapshotter:IsEnabled() then return end

    local profile = Snapshotter:GetSnapshotOverlayProfile(overlayId)
    if not profile then return end
    if profile.classTag and NAG.CLASS_FILENAME ~= profile.classTag then return end

    self:EnsureSnapshotOverlay(overlayId)
    if not NAG.SnapshotOverlays or not NAG.SnapshotOverlays[overlayId] then return end
    local overlay = NAG.SnapshotOverlays[overlayId]
    -- Do not reposition or hide while user is dragging the overlay
    if overlay.isDragging then return end
    local label = overlay.label
    local sublabel = overlay.sublabel

    local enabled = self:GetSnapshotOverlayEnabled(overlayId)
    if not enabled then
        overlay.isDragging = nil
        overlay:Hide()
        return
    end
    if self:IsDisplaySuppressed() then
        overlay.isDragging = nil
        overlay:Hide()
        return
    end
    local hasTarget = UnitExists("target")
    local hasSnapshot = hasTarget and Snapshotter:HasSnapshotGroupOnTarget(overlayId)
    local locked = self:GetSnapshotOverlayLocked(overlayId)
    overlay:EnableMouse(not locked)
    -- When locked, only show when we have a target with the snapshot
    if locked and (not hasTarget or not hasSnapshot) then
        overlay.isDragging = nil
        overlay:Hide()
        return
    end

    local so = self.db.char.snapshotOverlays
    local pos = so and so[overlayId] and so[overlayId].pos
    local useCustomPos = pos and pos.custom

    -- When using auto-anchor we need the anchor frame; when using custom position we do not.
    -- When unlocked with no snapshot, do not require anchor so we can show placeholder at center for dragging.
    if not useCustomPos and (locked or hasSnapshot) then
        local anchorFrame = self:GetSnapshotOverlayAnchorFrame()
        if not anchorFrame then
            self:Debug("SnapshotOverlay %s: no anchor frame", tostring(overlayId))
            overlay.isDragging = nil
            overlay:Hide()
            return
        end
    end

    -- Set label text: real data when target has snapshot, otherwise placeholder so user can drag when unlocked
    if hasSnapshot then
        local showDPS = self:GetSnapshotOverlayShowDPS(overlayId)
        if showDPS then
            local snapDPS = Snapshotter:GetSnapshotGroupSnapshotDPS(overlayId)
            local curDPS = Snapshotter:GetSnapshotGroupCurrentDPS(overlayId)
            if type(snapDPS) == "number" and snapDPS > 0 and type(curDPS) == "number" and curDPS > 0 then
                local delta = floor(curDPS + 0.5) - floor(snapDPS + 0.5)
                local color = delta >= 0 and "|cff00ff00" or "|cffff4444"
                local sign = delta >= 0 and "+" or ""
                label:SetText(format("%s%s%d|r DPS", color, sign, delta))
                sublabel:SetText(format("%d DPS", floor(snapDPS + 0.5)))
            elseif type(snapDPS) == "number" and snapDPS > 0 then
                label:SetText(format("%d DPS", floor(snapDPS + 0.5)))
                sublabel:SetText("")
            else
                label:SetText(L["snapshotOverlayLabel"] or L["Disease"] or "Snapshot")
                sublabel:SetText("")
            end
        else
            local pct = Snapshotter:GetSnapshotGroupSnapshotPercent(overlayId)
            if pct then
                local delta = pct - 100
                local color = delta >= 0 and "|cff00ff00" or "|cffff4444"
                local sign = delta >= 0 and "+" or ""
                label:SetText(format("%s%s%.0f%%|r", color, sign, delta))
            else
                label:SetText(L["snapshotOverlayLabel"] or L["Disease"] or "Snapshot")
            end
            sublabel:SetText("")
        end
    else
        -- Unlocked and no target/snapshot: show placeholder so user can drag
        label:SetText(L["snapshotOverlayLabel"] or L["Disease"] or "Snapshot")
        sublabel:SetText(L["snapshotOverlayDragHint"] or "Drag to position")
    end
    overlay:ClearAllPoints()
    local anchor = self:GetSnapshotOverlayAnchorFrame()
    local soPos = self.db.char.snapshotOverlays
    local posApply = soPos and soPos[overlayId] and soPos[overlayId].pos
    if anchor then
        -- Parent to anchor (like FloatingSelector) so overlay moves with the main display
        overlay:SetParent(anchor)
        local maxLevel = anchor:GetFrameLevel()
        if anchor.iconFrames then
            for _, fr in pairs(anchor.iconFrames) do
                if fr and fr.GetFrameLevel then
                    local l = fr:GetFrameLevel()
                    if l > maxLevel then maxLevel = l end
                end
            end
        end
        overlay:SetFrameLevel(maxLevel + 10)
        if posApply and posApply.custom then
            overlay:SetPoint(posApply.point or "BOTTOM", anchor, posApply.relativePoint or "TOP", posApply.x or 0, posApply.y or 4)
        else
            overlay:SetPoint("BOTTOM", anchor, "TOP", 0, 4)
        end
    else
        -- No anchor: show on UIParent so placeholder is visible for dragging
        overlay:SetParent(UIParent)
        overlay:SetFrameLevel(100)
        overlay:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
    overlay:Show()
end

--- Update all registered snapshot overlays (called from UpdateFrameVisibility and stat events).
function DisplayManager:UpdateAllSnapshotOverlays()
    local Snapshotter = NAG:GetModule("Snapshotter")
    if not Snapshotter or not Snapshotter:IsEnabled() then return end
    local ids = Snapshotter:GetSnapshotOverlayProfileIds()
    for _, overlayId in ipairs(ids) do
        self:UpdateSnapshotOverlay(overlayId)
    end
end

--- Legacy: Create the DK disease snapshot overlay frame (delegate to generic).
function DisplayManager:EnsureDKDiseaseSnapshotOverlay()
    self:EnsureSnapshotOverlay("dk_disease")
end

--- Legacy: Returns the frame to anchor the disease overlay above.
--- @return table|nil
function DisplayManager:GetDKDiseaseSnapshotAnchorFrame()
    return self:GetSnapshotOverlayAnchorFrame()
end

--- Legacy: Update DK disease snapshot overlay (delegate to generic).
function DisplayManager:UpdateDKDiseaseSnapshotOverlay()
    self:UpdateSnapshotOverlay("dk_disease")
end

-- ============================ CLASS OPTIONS COMPOSER (SNAPSHOT OVERLAY) ============================

--- Options composer for class tab: inject Snapshot overlay enable/showDPS toggles for current class profiles.
--- @param options table The class category table (options.class)
--- @param context table Context from OptionsManager
--- @return table|nil
function DisplayManager:class(options, context)
    if not options or not options.args or not NAG.CLASS_FILENAME then return options end
    local classArgs = options.args[NAG.CLASS_FILENAME]
    if not classArgs or not classArgs.args then return options end

    local Snapshotter = NAG:GetModule("Snapshotter")
    if not Snapshotter or not Snapshotter.GetSnapshotOverlayProfileIds or not Snapshotter.GetSnapshotOverlayProfile then return options end

    local profileIds = Snapshotter:GetSnapshotOverlayProfileIds()
    local classProfiles = {}
    for _, profileId in ipairs(profileIds) do
        local profile = Snapshotter:GetSnapshotOverlayProfile(profileId)
        if profile and profile.classTag == NAG.CLASS_FILENAME then
            tinsert(classProfiles, profileId)
        end
    end
    if #classProfiles == 0 then return options end

    local OF = NAG:GetModule("OptionsFactory")
    if not OF or not OF.CreateToggle then return options end

    local snapshotArgs = {}
    local order = 1
    for _, profileId in ipairs(classProfiles) do
        snapshotArgs[profileId .. "_enabled"] = OF:CreateToggle(
            L["showSnapshotOverlay"] or "Show snapshot overlay",
            L["showSnapshotOverlayDesc"] or "Enable the snapshot overlay for this spec",
            function() return self:GetSnapshotOverlayEnabled(profileId) end,
            function(_, value)
                self:SetSnapshotOverlayEnabled(profileId, value)
                self:UpdateAllSnapshotOverlays()
            end,
            { order = order }
        )
        order = order + 1
        snapshotArgs[profileId .. "_locked"] = OF:CreateToggle(
            L["dkDiseaseOverlayLocked"] or "Lock snapshot overlay",
            L["dkDiseaseOverlayLockedDesc"] or "Lock the snapshot overlay position so it cannot be accidentally dragged",
            function() return self:GetSnapshotOverlayLocked(profileId) end,
                function(_, value)
                    self:SetSnapshotOverlayLocked(profileId, value)
                    self:UpdateAllSnapshotOverlays()
                end,
            {
                order = order,
                hidden = function() return not self:GetSnapshotOverlayEnabled(profileId) end,
            }
        )
        order = order + 1
        snapshotArgs[profileId .. "_showDPS"] = OF:CreateToggle(
            L["showDKDiseaseSnapshotDPS"] or "Show as DPS",
            L["showDKDiseaseSnapshotDPSDesc"] or "Show snapped DPS instead of snapshot percent",
            function() return self:GetSnapshotOverlayShowDPS(profileId) end,
            function(_, value)
                self:SetSnapshotOverlayShowDPS(profileId, value)
                self:UpdateAllSnapshotOverlays()
            end,
            {
                order = order,
                hidden = function() return not self:GetSnapshotOverlayEnabled(profileId) end,
            }
        )
        order = order + 1
    end

    classArgs.args.snapshotOverlay = {
        type = "group",
        name = L["snapshotOverlay"] or "Snapshot overlay",
        desc = L["snapshotOverlayDesc"] or "Show snapshot strength above ability icons (DoT/bleed snapshot)",
        inline = true,
        order = 25,
        args = snapshotArgs,
    }
    return options
end

-- Utility: Apply a preset to all group settings
function DisplayManager:ApplyGroupPreset(presetName)
    local preset = GROUP_PRESETS[presetName]
    if not preset then return end
    for groupKey, groupSettings in pairs(preset) do
        local dbSettings = self.db.char.groupSettings[groupKey]
        for k, v in pairs(groupSettings) do
            dbSettings[k] = v
        end
        self.db.char.groupSettings[groupKey] = dbSettings
        self:CreateGroupIcons(groupKey)
        local frame = self.groupFrames[groupKey]
        if frame then
            frame:SetScale(dbSettings.scale or 1)
            frame:SetAlpha(dbSettings.alpha or 1)
            frame:ClearAllPoints()
            frame:SetPoint(dbSettings.point or "CENTER", NAG.GroupDisplayFrame, dbSettings.relativePoint or "CENTER",
                dbSettings.offsetX or 0, dbSettings.offsetY or 0)
        end
    end
    self:UpdateFrameVisibility()
    -- Notify other modules that frame has been updated
    self:SendFrameUpdated("update_group_layout")
end

function DisplayManager:ShowGroupDisplayEditBg()
    local bg = NAG.GroupDisplayFrame.editBg
    local mainSettings = self.db.char.groupSettings.main
    local w = (mainSettings.width or 50) * 2
    local h = (mainSettings.height or 50) * 2
    bg:SetSize(w, h)
    bg:ClearAllPoints()
    bg:SetPoint("CENTER", NAG.GroupDisplayFrame, "CENTER")
    bg:Show()
    -- Resize and center the GroupDisplayFrame to match (or triple) the blue area
    self:UpdateGroupDisplayFrameSize()
    NAG.GroupDisplayFrame:SetSize(w, h)
    NAG.GroupDisplayFrame:ClearAllPoints()
    local parent = self:GetAnchorParent()
    NAG.GroupDisplayFrame:SetPoint("CENTER", parent, "CENTER")
    NAG.GroupDisplayFrame:EnableMouse(true)
    NAG.GroupDisplayFrame:EnableMouseWheel(true)
    NAG.GroupDisplayFrame:SetMovable(true)
    NAG.GroupDisplayFrame:RegisterForDrag("LeftButton")
    NAG.GroupDisplayFrame:SetScript("OnDragStart", function(frameSelf) frameSelf:StartMoving() end)
    NAG.GroupDisplayFrame:SetScript("OnMouseWheel", function(frameSelf, delta)
        local scale = frameSelf:GetScale() or 1
        if delta > 0 then
            scale = scale + 0.1
        else
            scale = scale - 0.1
        end
        scale = max(0.5, min(2, scale))
        frameSelf:SetScale(scale)
        module.db.char.groupDisplayFrame.masterScale = scale
        module:UpdateEditBgSize()
    end)
    NAG.GroupDisplayFrame:SetScript("OnDragStop", function(frameSelf)
        frameSelf:StopMovingOrSizing()
        -- Use GetPoint to get the current SetPoint parameters (correct coordinate system)
        local point, relativeFrame, relativePoint, xOffset, yOffset = frameSelf:GetPoint()

        -- Save the exact SetPoint parameters (correct coordinate system)
        module.db.char.groupDisplayFrame.point = point or "CENTER"
        module.db.char.groupDisplayFrame.relativePoint = relativePoint or "CENTER"
        module.db.char.groupDisplayFrame.offsetX = xOffset or 0
        module.db.char.groupDisplayFrame.offsetY = yOffset or 0

        -- Notify other modules that frame has been updated
        module:SendFrameUpdated("toggle_group")
    end)
    self:UpdateEditBgSize()
    -- Set master scale after creation
    local scale = self.db.char.groupDisplayFrame.masterScale
    NAG.GroupDisplayFrame:SetScale(scale)
end

function DisplayManager:HideGroupDisplayEditBg()
    local bg = NAG.GroupDisplayFrame.editBg
    bg:Hide()
    NAG.GroupDisplayFrame:EnableMouse(false)
    NAG.GroupDisplayFrame:SetMovable(false)
    NAG.GroupDisplayFrame:RegisterForDrag()
    NAG.GroupDisplayFrame:SetScript("OnDragStart", nil)
    NAG.GroupDisplayFrame:SetScript("OnDragStop", nil)
    -- Restore GroupDisplayFrame to last saved position after edit mode
    NAG.GroupDisplayFrame:ClearAllPoints()
    local gdfSettings = self.db.char.groupDisplayFrame
    local parent = self:GetAnchorParent()
    NAG.GroupDisplayFrame:SetPoint(gdfSettings.point or "CENTER", parent, gdfSettings.relativePoint or "CENTER",
        gdfSettings.offsetX or 0, gdfSettings.offsetY or 0)
end

function DisplayManager:UpdateEditBgSize()
    local mainSettings = self.db.char.groupSettings.main
    local w = (mainSettings.width or 50) * (mainSettings.scale or 1) * 2
    local h = (mainSettings.height or 50) * (mainSettings.scale or 1) * 2
    local bg = NAG.GroupDisplayFrame.editBg
    if bg then
        bg:SetSize(w, h)
        bg:ClearAllPoints()
        bg:SetPoint("CENTER", NAG.GroupDisplayFrame, "CENTER")
    end
    self:UpdateGroupDisplayFrameSize()
    NAG.GroupDisplayFrame:SetSize(w, h)
    NAG.GroupDisplayFrame:ClearAllPoints()
    local gdfSettings = self.db.char.groupDisplayFrame
    local parent = self:GetAnchorParent()
    NAG.GroupDisplayFrame:SetPoint(gdfSettings.point or "CENTER", parent, gdfSettings.relativePoint or "CENTER",
        gdfSettings.offsetX or 0, gdfSettings.offsetY or 0)
    -- Set master scale after creation
    local scale = self.db.char.groupDisplayFrame.masterScale
    NAG.GroupDisplayFrame:SetScale(scale)
end

function DisplayManager:OnSettingChanged(key, value)
    -- Handle main group icon/frame settings
    if key:match("^main%.") then
        self:UpdateEditBgSize()
        if key:match("iconWidth") or key:match("iconHeight") or key:match("numIcons") then
            self:CreateGroupIcons(ns.FRAME_GROUPS.MAIN)
        end
        return
    end
    -- Handle other group settings (e.g., aoe.iconWidth, cooldowns.scale, etc.)
    local groupKey, subkey = key:match("^(%w+)%.(.+)$")
    if groupKey and self.groupFrames[groupKey] then
        if subkey:match("iconWidth") or subkey:match("iconHeight") or subkey:match("numIcons") then
            self:CreateGroupIcons(groupKey)
        end
        if groupKey == ns.FRAME_GROUPS.MAIN and (subkey:match("width") or subkey:match("height") or subkey:match("scale")) then
            self:UpdateEditBgSize()
        end
    end
end

-- Add a method to share the current group display config
function DisplayManager:ShareGroupDisplayConfig(targetPlayer)
    if not targetPlayer or targetPlayer == "" then
        self:Error("No target player specified for sharing display config.")
        return
    end
    local configCopy = {}
    for group, settings in pairs(self.db.char.groupSettings) do
        configCopy[group] = CopyTable and CopyTable(settings) or settings -- Use deep copy if available
    end
    -- Ensure required keys are present in the data table
    local data = {
        groupSettings = configCopy,
        messageType = "DisplayConfig",
        name = L["data"] or "Display Config"
    }
    ShareInGame:Send("Display Config", data, targetPlayer, "DisplayConfig")
    self:Print("Sent display config to " .. targetPlayer)
end

-- Helper: Update GroupDisplayFrame size to match main group settings
function DisplayManager:UpdateGroupDisplayFrameSize()
    local mainSettings = self.db.char.groupSettings.main
    local width = (mainSettings.width or 50) * (mainSettings.scale or 1)
    local height = (mainSettings.height or 50) * (mainSettings.scale or 1)
    if NAG.GroupDisplayFrame then
        NAG.GroupDisplayFrame:SetSize(width, height)
        -- Ensure it remains parented to resolved anchor
        if NAG.GroupDisplayFrame:GetParent() ~= self:GetAnchorParent() then
            NAG.GroupDisplayFrame:SetParent(self:GetAnchorParent())
        end
        -- Notify other modules that frame has been updated
        self:SendFrameUpdated("rebuild_group_frame")
    end
end

function DisplayManager:UpdateClickThrough()
    -- Always click-through unless in edit mode
    if not self.editMode then
        if NAG.GroupDisplayFrame then
            NAG.GroupDisplayFrame:EnableMouse(false)
        end
        for _, frame in pairs(self.groupFrames or {}) do
            frame:EnableMouse(false)
            if frame.iconFrames then
                for _, icon in ipairs(frame.iconFrames) do
                    icon:EnableMouse(false)
                end
            end
        end
        self:UpdateIconMouseStateForModifier()
    end
end

function DisplayManager:UpdateIconMouseStateForModifier()
    local key = self:GetMouseInteractionKey()
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
    -- Only update if not in edit mode
    if not self.editMode then
        for _, frame in pairs(self.groupFrames or {}) do
            if frame.iconFrames then
                for _, icon in ipairs(frame.iconFrames) do
                    icon:EnableMouse(wantMouse)
                end
            end
            -- Round icons (visible when masks enabled): same Alt-hover tooltip behavior
            if frame.roundIconFrames then
                for _, roundIcon in pairs(frame.roundIconFrames) do
                    if roundIcon and roundIcon.EnableMouse then
                        roundIcon:EnableMouse(wantMouse)
                    end
                end
            end
        end
    end
end

-- In EnableEditMode, always enable mouse for all frames and icons
function DisplayManager:EnableEditMode()
    self.editMode = true
    local testIcon = "Interface\\Icons\\INV_Misc_QuestionMark"
    if not FRAME_GROUPS then
        self:Error("FRAME_GROUPS is nil in EnableEditMode")
        return
    end
    for groupKey, _ in pairs(FRAME_GROUPS) do
        local frame = self.groupFrames and self.groupFrames[groupKey]
        if not frame then
            self:Warn("[NAG] WARNING: groupFrames[" .. tostring(groupKey) .. "] is nil")
        else
            frame:Show()
            -- Set frame strata/level for edit mode: main is always lowest
            if groupKey == ns.FRAME_GROUPS.MAIN then
                frame:SetFrameStrata("MEDIUM")
                frame:SetFrameLevel(10)
                frame:EnableMouse(true)
                frame:SetMovable(false)
                frame:RegisterForDrag() -- disables drag
                frame:SetScript("OnDragStart", nil)
                frame:SetScript("OnDragStop", nil)
                frame:ClearAllPoints()
                frame:SetPoint("CENTER", NAG.GroupDisplayFrame, "CENTER", 0, 0)
                frame:SetScript("OnMouseWheel", function(frameSelf, delta)
                    local scale = frameSelf:GetScale() or 1
                    if delta > 0 then
                        scale = scale + 0.1
                    else
                        scale = scale - 0.1
                    end
                    scale = max(0.5, min(2, scale))
                    frameSelf:SetScale(scale)
                    module.db.char.groupSettings.main.scale = scale
                    module:UpdateEditBgSize()
                end)
            else
                frame:SetFrameStrata("MEDIUM")
                frame:SetFrameLevel(20)
                frame:EnableMouse(true)
                frame:SetMovable(true)
                frame:RegisterForDrag("LeftButton")
                frame:SetScript("OnDragStart", function(frameSelf)
                    -- Store initial mouse position and frame position for relative dragging
                    local x, y = GetCursorPosition()
                    local scale = UIParent:GetScale()
                    frameSelf.dragStartX = x / scale
                    frameSelf.dragStartY = y / scale
                    frameSelf.dragStartOffsetX = frameSelf:GetPoint() and select(4, frameSelf:GetPoint()) or 0
                    frameSelf.dragStartOffsetY = frameSelf:GetPoint() and select(5, frameSelf:GetPoint()) or 0
                end)
                frame:SetScript("OnDragStop", function(frameSelf)
                    -- Calculate new position relative to parent
                    local x, y = GetCursorPosition()
                    local scale = UIParent:GetScale()
                    local deltaX = (x / scale) - frameSelf.dragStartX
                    local deltaY = (y / scale) - frameSelf.dragStartY

                    local newOffsetX = frameSelf.dragStartOffsetX + deltaX
                    local newOffsetY = frameSelf.dragStartOffsetY + deltaY

                    -- Update frame position relative to parent
                    frameSelf:ClearAllPoints()
                    frameSelf:SetPoint("CENTER", NAG.GroupDisplayFrame, "CENTER", newOffsetX, newOffsetY)

                    -- Save the new position
                    local settings = module.db.char.groupSettings[groupKey]
                    if not settings then
                        self:Warn("groupSettings[%s] is nil", tostring(groupKey))
                    else
                        -- Save the exact SetPoint parameters (correct coordinate system)
                        module.db.char.groupSettings[groupKey].point = "CENTER"
                        module.db.char.groupSettings[groupKey].relativePoint = "CENTER"
                        module.db.char.groupSettings[groupKey].offsetX = newOffsetX
                        module.db.char.groupSettings[groupKey].offsetY = newOffsetY
                    end

                    -- Clean up drag data
                    frameSelf.dragStartX = nil
                    frameSelf.dragStartY = nil
                    frameSelf.dragStartOffsetX = nil
                    frameSelf.dragStartOffsetY = nil

                    -- Notify other modules that frame has been updated
                    module:SendFrameUpdated("import_display_config")
                end)
                frame:SetScript("OnMouseWheel", function(frameSelf, delta)
                    local scale = frameSelf:GetScale() or 1
                    if delta > 0 then
                        scale = scale + 0.1
                    else
                        scale = scale - 0.1
                    end
                    scale = max(0.5, min(2, scale))
                    frameSelf:SetScale(scale)
                    module.db.char.groupSettings[groupKey].scale = scale
                end)
            end
            -- Add hover label for edit mode
            if not frame.editHoverLabel then
                local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
                label:SetPoint("TOP", frame, "TOP", 0, 18)
                local displayName = FRAME_GROUPS[groupKey] and FRAME_GROUPS[groupKey].displayName or groupKey
                label:SetText(displayName)
                label:SetAlpha(0.95)
                label:Hide()
                frame.editHoverLabel = label
            end
            frame:SetScript("OnEnter", function(frameSelf)
                if DisplayManager.editMode and frameSelf.editHoverLabel then
                    frameSelf.editHoverLabel:Show()
                end
            end)
            frame:SetScript("OnLeave", function(frameSelf)
                if frameSelf.editHoverLabel then
                    frameSelf.editHoverLabel:Hide()
                end
            end)
            -- Add rotating arrow button overlay for direction
            if not frame.directionButton then
                local btn = CreateFrame("Button", nil, frame)
                btn:SetSize(24, 24)
                btn:SetPoint("CENTER", frame, "CENTER", 0, 0)
                btn:SetFrameStrata("DIALOG")
                btn.icon = btn:CreateTexture(nil, "ARTWORK")
                btn.icon:SetAllPoints()
                btn.icon:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
                btn.icon:SetVertexColor(1, 0.9, 0.2, 1)
                local function updateIcon()
                    local dirKey = module.db.char.groupSettings[groupKey].iconFlowDirection
                    local idx = 1
                    for i, d in ipairs(COMPASS_DIRECTIONS) do
                        if d.key == dirKey then
                            idx = i
                            break
                        end
                    end
                    local dir = COMPASS_DIRECTIONS[idx]
                    btn.icon:SetRotation(math.rad(dir.angle))
                end
                btn:SetScript("OnClick", function()
                    local dirKey = module.db.char.groupSettings[groupKey].iconFlowDirection
                    local idx = 1
                    for i, d in ipairs(COMPASS_DIRECTIONS) do
                        if d.key == dirKey then
                            idx = i
                            break
                        end
                    end
                    idx = idx % #COMPASS_DIRECTIONS + 1
                    module.db.char.groupSettings[groupKey].iconFlowDirection = COMPASS_DIRECTIONS[idx].key
                    module:CreateGroupIcons(groupKey)
                    updateIcon()
                end)
                btn:SetScript("OnEnter", function(frameSelf) frameSelf.icon:SetVertexColor(1, 0.82, 0) end)
                btn:SetScript("OnLeave", function(frameSelf) frameSelf.icon:SetVertexColor(1, 1, 1) end)
                btn:Show()
                frame.directionButton = btn
                updateIcon()
            else
                frame.directionButton:Show()
            end

            -- Always use the ? icon with 0.75 alpha for all icons in edit mode
            local iconData = {}
            local numIcons
            --if groupKey == ns.FRAME_GROUPS.MAIN then
            --    numIcons = 1
            --else
            numIcons = module.db.char.groupSettings[groupKey].numIcons
            --end
            for i = 1, numIcons do
                iconData[i] = { texture = testIcon, alpha = 0.75 }
            end
            module:UpdateGroupIcons(groupKey, iconData)
            -- Set alpha for all icon frames
            if frame.iconFrames then
                for _, icon in ipairs(frame.iconFrames) do
                    icon:EnableMouse(false)
                    if icon.texture then
                        icon.texture:SetAlpha(0.75)
                        icon:SetAlpha(0.75)
                    end
                end
            end
        end
    end
    self:UpdateFrameVisibility()
    self:ShowGroupDisplayEditBg()

    -- Always enable mouse in edit mode
    if NAG.GroupDisplayFrame then NAG.GroupDisplayFrame:EnableMouse(true) end
    for _, frame in pairs(self.groupFrames or {}) do frame:EnableMouse(true) end
end

-- In DisableEditMode, call UpdateClickThrough to restore click-through/mouse state
function DisplayManager:DisableEditMode()
    self.editMode = false
    if not FRAME_GROUPS then
        self:Error("FRAME_GROUPS is nil in DisableEditMode")
        return
    end
    for groupKey, _ in pairs(FRAME_GROUPS) do
        local frame = self.groupFrames and self.groupFrames[groupKey]
        if not frame then
            self:Warn("groupFrames[" .. tostring(groupKey) .. "] is nil")
        else
            -- Restore frame strata/level after edit mode
            local settings = self.db.char.groupSettings[groupKey]
            frame:SetFrameStrata(settings.frameStrata or "MEDIUM")
            frame:SetFrameLevel(settings.frameLevel or 1)
            frame:Hide()
            frame:SetMovable(false)
            frame:RegisterForDrag() -- disables drag
            frame:SetScript("OnDragStart", nil)
            frame:SetScript("OnDragStop", nil)
            frame:SetScript("OnMouseWheel", nil)
            -- Restore mouse and alpha on all icon frames for normal tooltip/keybind behavior
            if frame.iconFrames then
                local settings = self.db.char.groupSettings[groupKey]
                for _, icon in ipairs(frame.iconFrames) do
                    icon:EnableMouse(true)
                    if icon.texture then
                        icon.texture:SetAlpha(settings.alpha or 1)
                        icon:SetAlpha(settings.alpha or 1)
                    end
                end
            end
            -- Optionally: clear icon textures
            if frame.iconFrames then
                for _, icon in ipairs(frame.iconFrames) do
                    icon:Hide()
                    icon.texture:SetTexture(nil)
                end
            end
            -- Hide and cleanup direction button
            if frame.directionButton then
                frame.directionButton:Hide()
            end
            -- Hide hover label when leaving edit mode
            if frame.editHoverLabel then
                frame.editHoverLabel:Hide()
            end
        end
    end
    self:UpdateFrameVisibility()
    self:HideGroupDisplayEditBg()
    -- Hide close button on blue edit background
    local bg = NAG.GroupDisplayFrame.editBg
    if bg and bg.closeButton then
        bg.closeButton:Hide()
    end

    self:UpdateClickThrough()
end

-- Register for modifier key changes (only once)
if not DisplayManager._modifierFrame then
    local f = CreateFrame("Frame")
    f:RegisterEvent("MODIFIER_STATE_CHANGED")
    f:SetScript("OnEvent", function()
        DisplayManager:UpdateIconMouseStateForModifier()
    end)
    DisplayManager._modifierFrame = f
end


function DisplayManager:UpdateLegacyIconMouseStateForModifier()
    -- Only update if not in edit mode
    if NAG.Frame and not (NAG.Frame.editMode or self.editMode) then
        local key = self:GetMouseInteractionKey()
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

        -- Only update icon frames - NAG.Frame itself doesn't need mouse enabled
        -- Icon frames are children of NAG.Frame and can be interactive independently
        -- The parent frame (NAG.Frame) only needs mouse enabled in edit mode (for dragging),
        -- which is handled separately in ToggleFrameEditMode()
        for _, frame in pairs(NAG.Frame.iconFrames or {}) do
            frame:EnableMouse(wantMouse)
        end
        -- Round icons (visible when masks enabled): same Alt-hover tooltip behavior
        if NAG.Frame.roundIconFrames then
            for _, roundIcon in pairs(NAG.Frame.roundIconFrames) do
                if roundIcon and roundIcon.EnableMouse then
                    roundIcon:EnableMouse(wantMouse)
                end
            end
        end
    end
end

-- Register for modifier key changes for legacy frame (only once)
if not DisplayManager._legacyModifierFrame then
    local f = CreateFrame("Frame")
    f:RegisterEvent("MODIFIER_STATE_CHANGED")
    f:SetScript("OnEvent", function()
        DisplayManager:UpdateLegacyIconMouseStateForModifier()
    end)
    DisplayManager._legacyModifierFrame = f
end

function DisplayManager:IsEnableAlways()
    return self.db.char.enableAlways
end

function DisplayManager:IsOutOfCombatEnabled()
    return self.db.char.enableOutOfCombat
end

function DisplayManager:IsHideDuringPetBattles()
    return self.db.char.hideDuringPetBattles
end

function DisplayManager:IsHideDuringVehicles()
    return self.db.char.hideDuringVehicles
end

--- Check if cooldown swipe animations are enabled
--- @return boolean True if cooldown swipes should be shown
function DisplayManager:AreCooldownSwipesEnabled()
    return self.db.char.enableCooldownSwipes
end

--- Enable or disable cooldown swipe animations
--- @param enabled boolean True to show cooldown swipes, false to hide them
function DisplayManager:SetCooldownSwipesEnabled(enabled)
    self.db.char.enableCooldownSwipes = enabled == true
    self:RefreshAllCooldownDisplays()
end

--- Check if display elements (frames/borders) should be shown
--- Centralized visibility logic used by both frames and borders
--- @return boolean True if display elements should be visible (rotation ready OR edit mode, AND display should show)
function DisplayManager:IsDisplayAllowed()
    -- When editing/positioning, always allow display so user can drag and position the frames
    if NAG:IsAnyEditMode() then
        return true
    end
    local shouldShow = self:ShouldShowDisplay()
    local rotationReady = NAG and (NAG.cachedRotationFunc ~= nil or NAG.cachedRotationAST ~= nil)
    return shouldShow and rotationReady
end

--- Check if borders should be shown for a frame
--- Uses the same visibility logic as frames: IsDisplayAllowed() AND enableBorders
--- @param frame Frame|nil The frame to check (optional, kept for consistency)
--- @return boolean True if borders should be visible
function DisplayManager:ShouldShowBorders(frame)
    -- Always show borders in edit mode
    if NAG:IsAnyEditMode() then
        return true
    end

    -- If borders are disabled, don't show them
    if not self.db.char.enableBorders then
        return false
    end

    -- Use the same visibility logic as frames
    return self:IsDisplayAllowed()
end

function DisplayManager:ShouldShowDisplay()
    if self:IsDisplaySuppressed() then
        return false
    end
    if self:IsHideDuringPetBattles() and self.isInPetBattle then
        return false
    end
    if not (UnitAffectingCombat("player")) and self:IsHideDuringVehicles() and self:IsInVehicleState() then
        return false
    end
    if self:IsEnableAlways() then
        return true
    end
    if UnitAffectingCombat("player") then
        return true
    end
    if self:IsOutOfCombatEnabled() and UnitExists("target") and UnitCanAttack("player", "target") then
        return true
    end
    return false
end

--- Returns a machine-readable reason when display output is currently blocked.
--- @return string|nil
function DisplayManager:GetDisplayBlockedReason()
    if self:IsDisplaySuppressed() then
        return "suppressed"
    end
    if NAG and NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        return "edit_mode"
    end
    if self:IsHideDuringPetBattles() and self.isInPetBattle then
        return "pet_battle"
    end
    if not (UnitAffectingCombat("player")) and self:IsHideDuringVehicles() and self:IsInVehicleState() then
        return "vehicle_hidden"
    end
    if not NAG.hasEnabledModule then
        return "class_module_disabled"
    end
    if self:IsEnableAlways() then
        return nil
    end
    if UnitAffectingCombat("player") then
        return nil
    end
    if self:IsOutOfCombatEnabled() and UnitExists("target") and UnitCanAttack("player", "target") then
        return nil
    end
    return "visibility_policy"
end

function DisplayManager:PET_BATTLE_OPENING_START()
    self.isInPetBattle = true
    self:Debug("Pet battle started - hiding display frames")
    self:UpdateFrameVisibility()
end

function DisplayManager:PET_BATTLE_CLOSE()
    self.isInPetBattle = false
    self:Debug("Pet battle ended - restoring display frame visibility")
    self:UpdateFrameVisibility()
end

function DisplayManager:PET_BATTLE_OVER()
    self.isInPetBattle = false
    self:Debug("Pet battle ended - restoring display frame visibility")
    self:UpdateFrameVisibility()
end

function DisplayManager:InitializePetBattleState()
    if C_PetBattles and C_PetBattles.IsInBattle and C_PetBattles.IsInBattle() then
        self.isInPetBattle = true
        self:Debug("Addon loaded during pet battle - hiding frames")
        self:UpdateFrameVisibility()
    else
        self.isInPetBattle = false
    end
end

function DisplayManager:GetMouseInteractionKey()
    return self.db.char.mouseInteractionKey
end

--- Get frame level for class bars so they render slightly below NAG icon frames
--- @return number Frame level to use for class helper bars (strata MEDIUM)
function DisplayManager:GetRecommendedClassBarFrameLevel()
    local maxLevel = 1
    if self:IsGroupDisplayMode() and self.groupFrames then
        for _, groupFrame in pairs(self.groupFrames) do
            if groupFrame and groupFrame.GetFrameLevel then
                local l = groupFrame:GetFrameLevel()
                if l > maxLevel then maxLevel = l end
                if groupFrame.iconFrames then
                    for _, icon in pairs(groupFrame.iconFrames) do
                        if icon and icon.GetFrameLevel then
                            local il = icon:GetFrameLevel()
                            if il > maxLevel then maxLevel = il end
                        end
                    end
                end
            end
        end
    end
    if self:IsLegacyFrameEnabled() and NAG.Frame then
        local l = NAG.Frame:GetFrameLevel()
        if l > maxLevel then maxLevel = l end
        if NAG.Frame.iconFrames then
            for _, icon in pairs(NAG.Frame.iconFrames) do
                if icon and icon.GetFrameLevel then
                    local il = icon:GetFrameLevel()
                    if il > maxLevel then maxLevel = il end
                end
            end
        end
    end
    return math.max(1, maxLevel - 10)
end

-- ============================ MESSAGE HANDLERS ============================

--- Handle startup complete message - update frame visibility when addon is fully loaded
--- @param message string The message name
function DisplayManager:NAG_STARTUP_COMPLETE(message)
    self:UpdateFrameVisibility()
end

--- Refresh the snapshot overlay whose data changed (payload: overlayId).
function DisplayManager:NAG_SNAPSHOT_OVERLAY_UPDATED(message, overlayId)
    if overlayId then
        self:UpdateSnapshotOverlay(overlayId)
    else
        self:UpdateAllSnapshotOverlays()
    end
end

--- Stat change events — refresh snapshot overlays when player AP/stats/damage modifier changes
function DisplayManager:UNIT_ATTACK_POWER(_, unit)
    if unit ~= "player" then return end
    self:UpdateAllSnapshotOverlays()
end

function DisplayManager:UNIT_STATS(_, unit)
    if unit ~= "player" then return end
    self:UpdateAllSnapshotOverlays()
end

function DisplayManager:UNIT_DAMAGE(_, unit)
    if unit ~= "player" then return end
    self:UpdateAllSnapshotOverlays()
end

--- Handle action identity invalidation and clear display entity cache.
--- @param message string
--- @param reason string|nil
function DisplayManager:NAG_ACTION_IDENTITY_INVALIDATED(message, reason)
    self:ClearEntityCache()
end

--- Handle combat start event (migrated from StateManager)
--- @param event string The event name
function DisplayManager:PLAYER_REGEN_DISABLED(event)
    -- Auto-disable edit mode on combat start so rotation doesn't stall
    if self.editMode then
        self:DisableEditMode()
    end
    if NAG.Frame and NAG.Frame.editMode then
        self:ToggleFrameEditMode(false)
    end

    self:UpdateFrameVisibility()
end

--- Handle combat end event (migrated from StateManager)
--- @param event string The event name
function DisplayManager:PLAYER_REGEN_ENABLED(event)
    self:UpdateFrameVisibility()

    -- Clear entity cache on combat end for fresh start
    if entityCache then
        wipe(entityCache)
        if self.debug then
            self:Debug("Combat ended - cleared entity cache for fresh start")
        end
    end
end
local CACHED_VISIBLE_SEQUENCE_ICONS = {}

--- Handle target change event (migrated from StateManager)
--- @param event string The event name
--- @param newGuid string The new target GUID
function DisplayManager:PLAYER_TARGET_CHANGED(event, newGuid)
    self:UpdateFrameVisibility()
    self:UpdateAllSnapshotOverlays()

    -- Stop screensaver if target selected
    if UnitExists("target") and self.screensaver.active then
        self:StopScreensaver()
    end

    -- Reset idle timer when target changes
    if self.db.char.screensaver.enabled then
        self.screensaver.lastInputTime = GetTime()
    end
end

--- Updates the 'sequence' group icons to reflect the current sequence state.
function DisplayManager:UpdateSequenceGroupIcons()
    local sequenceData = NAG:GetSequenceDisplayData()
    local groupKey = ns.FRAME_GROUPS.SEQUENCE
    local frame = self.groupFrames and self.groupFrames[groupKey]

    if not frame or not frame.iconFrames then
        return
    end

    -- If no sequence is active, hide all icons in the sequence group
    if not sequenceData or not sequenceData.steps or #sequenceData.steps == 0 then
        for _, icon in ipairs(frame.iconFrames) do
            icon:Hide()
            icon.spellId = nil
            icon.itemId = nil
        end
        OverlayManager:ClearAllSequenceArrows()
        return
    end

    local startIdx = 1
    if sequenceData.forceMainActive then
        startIdx = 2
    end
    wipe(CACHED_VISIBLE_SEQUENCE_ICONS)
    local visibleIcons = CACHED_VISIBLE_SEQUENCE_ICONS

    -- Map each sequence step to the corresponding icon frame by index
    for i = startIdx, #sequenceData.steps do
        local step = sequenceData.steps[i]
        local icon = frame.iconFrames[i - startIdx + 1]

        if icon and step.spellId and type(icon) == "table" and icon.GetName then
            -- Tinker fix: StateManager first for gloves icon
            local StateManager = NAG:GetModule("StateManager", true)
            local tinkerInfo = (StateManager and StateManager.GetTinkerInfoBySpellId) and StateManager:GetTinkerInfoBySpellId(step.spellId) or nil

            local iconTexture
            local isItem
            local itemIdForCooldown
            if tinkerInfo and tinkerInfo.icon then
                iconTexture = tinkerInfo.icon
                isItem = true
                itemIdForCooldown = tinkerInfo.itemId
            else
                local entity = DataManager:Get(step.spellId, DataManager.EntityTypes.SPELL) or
                    DataManager:Get(step.spellId, DataManager.EntityTypes.ITEM)
                if entity then
                    iconTexture = entity.icon
                    if entity.flags and entity.flags.tinker and entity.itemId then
                        iconTexture = GetItemIcon(entity.itemId) or entity.icon
                        itemIdForCooldown = entity.itemId
                    end
                    isItem = entity.IsItem or (entity.flags and entity.flags.tinker and entity.itemId)
                end
            end

            if iconTexture then
                icon.texture:SetTexture(iconTexture)
                icon:Show()
                if itemIdForCooldown then
                    icon.spellId = step.spellId
                    icon.itemId = itemIdForCooldown
                elseif isItem then
                    icon.spellId = nil
                    icon.itemId = step.spellId
                else
                    icon.spellId = step.spellId
                    icon.itemId = nil
                end
                -- Optionally highlight current step
                if step.isCurrent then
                    icon:SetAlpha(1)
                else
                    icon:SetAlpha(0.7)
                end
                table.insert(visibleIcons, { frame = icon, spellId = icon.spellId })

            else
                icon:Hide()
                icon.spellId = nil
                icon.itemId = nil
            end
        end
    end
    -- Hide any extra icons if fewer steps than icon frames
    for i = #visibleIcons + 1, #frame.iconFrames do
        local icon = frame.iconFrames[i]
        icon:Hide()
        icon.spellId = nil
        icon.itemId = nil
    end

    -- Add main frame as first if forceMainActive
    if sequenceData.forceMainActive and NAG.GroupDisplayFrame and NAG.groupFrames and NAG.groupFrames.main then
        local mainFrame = self.groupFrames.main and self.groupFrames.main.iconFrames and
            self.groupFrames.main.iconFrames[1]
        if mainFrame and type(mainFrame) == "table" and mainFrame.GetName and mainFrame:IsVisible() then
            table.insert(visibleIcons, 1, { frame = mainFrame, spellId = mainFrame.spellId })
        end
    end

    -- Add sequence arrows within the sequence container
    -- Only show arrows if we have at least 2 visible sequence icons
    if #visibleIcons > 1 then
        OverlayManager:ClearAllSequenceArrows()

        -- Add arrows between consecutive visible sequence icons
        for i = 1, #visibleIcons - 1 do
            local currentIcon = visibleIcons[i]
            local nextIcon = visibleIcons[i + 1]

            -- Only add arrow if both icons are valid and visible
            if currentIcon.frame and nextIcon.frame and
                currentIcon.frame:IsVisible() and nextIcon.frame:IsVisible() then
                OverlayManager:ShowOverlay(currentIcon.frame, "sequencearrow", nil, nil,
                    { spellId = currentIcon.spellId })
            end
        end
    else
        -- Clear arrows if we don't have enough icons
        OverlayManager:ClearAllSequenceArrows()
    end
end

function DisplayManager:HandleShareDisplaySlashCommand(input)
    local target = input:match("^%s*(%S+)")
    if not target then
        self:Print("Usage: /nagsharedisplay <player>")
        return
    end
    self:ShareGroupDisplayConfig(target)
end

--- Get the display name for a frame group
--- @param groupKey string The group key (main, aoe, cooldowns, etc.)
--- @return string The display name for the group
function DisplayManager:GetGroupDisplayName(groupKey)
    if FRAME_GROUPS[groupKey] and FRAME_GROUPS[groupKey].displayName then
        return FRAME_GROUPS[groupKey].displayName
    elseif groupKey then
        -- Fallback: capitalize the group name
        return groupKey:upper()
    else
        return "Unknown Group"
    end
end

-- ============================ VEHICLE STATE MANAGEMENT ============================

--- Check if the player is in a vehicle (either physically or has vehicle UI)
--- @return boolean True if player is in vehicle or has vehicle UI
function DisplayManager:IsInVehicleState()
    -- Check both vehicle states like WeakAuras does:
    -- 1. UnitInVehicle = player is physically in a vehicle seat
    -- 2. UnitHasVehicleUI = player has vehicle controls/UI active
    return self.isInVehicle or self.hasVehicleUI
end

function DisplayManager:UNIT_ENTERED_VEHICLE(event, unit)
    if unit == "player" then
        -- Update both vehicle states
        self.isInVehicle = UnitInVehicle("player")
        self.hasVehicleUI = UnitHasVehicleUI("player")
        self:Debug("Player entered vehicle - hiding display frames (inVehicle: " ..
            tostring(self.isInVehicle) .. ", hasVehicleUI: " .. tostring(self.hasVehicleUI) .. ")")
        self:UpdateFrameVisibility()
    end
end

function DisplayManager:UNIT_EXITED_VEHICLE(event, unit)
    if unit == "player" then
        -- Update both vehicle states
        self.isInVehicle = UnitInVehicle("player")
        self.hasVehicleUI = UnitHasVehicleUI("player")
        self:Debug("Player exited vehicle - restoring display frame visibility (inVehicle: " ..
            tostring(self.isInVehicle) .. ", hasVehicleUI: " .. tostring(self.hasVehicleUI) .. ")")
        self:UpdateFrameVisibility()
    end
end

--- Handle vehicle UI state changes (when player gains/loses vehicle controls)
function DisplayManager:PLAYER_GAINS_VEHICLE_DATA(event, unitTarget, vehicleUIIndicatorID)
    if unitTarget == "player" then
        self.hasVehicleUI = UnitHasVehicleUI("player")
        self:Debug("Player gained vehicle data - hasVehicleUI: " .. tostring(self.hasVehicleUI))
        self:UpdateFrameVisibility()
    end
end

function DisplayManager:PLAYER_LOSES_VEHICLE_DATA(event, unitTarget)
    if unitTarget == "player" then
        self.hasVehicleUI = UnitHasVehicleUI("player")
        self:Debug("Player lost vehicle data - hasVehicleUI: " .. tostring(self.hasVehicleUI))
        self:UpdateFrameVisibility()
    end
end

function DisplayManager:InitializeVehicleState()
    -- Initialize both vehicle states
    self.isInVehicle = UnitInVehicle("player")
    self.hasVehicleUI = UnitHasVehicleUI("player")

    if self.isInVehicle or self.hasVehicleUI then
        self:Debug("Addon loaded while in vehicle state - hiding frames (inVehicle: " ..
            tostring(self.isInVehicle) .. ", hasVehicleUI: " .. tostring(self.hasVehicleUI) .. ")")
        self:UpdateFrameVisibility()
    else
        self:Debug("Addon loaded - not in vehicle state")
    end
end

-- ============================ SCREENSAVER SYSTEM ============================

--- Start the screensaver - make GroupDisplayFrame bounce around the screen
function DisplayManager:StartScreensaver()
    if self.screensaver.active then
        return -- Already active
    end

    if not self:IsGroupDisplayMode() or not NAG.GroupDisplayFrame then
        return -- Only works with group display mode
    end

    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        return -- Don't start screensaver while in edit mode
    end

    self:Debug("Starting screensaver")

    -- Save current position
    local point, relativeTo, relativePoint, xOfs, yOfs = NAG.GroupDisplayFrame:GetPoint()
    self.screensaver.originalPosition = {
        point = point,
        relativeTo = relativeTo,
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs
    }

    -- Initialize random velocity (pixels per second)
    local speed = self.db.char.screensaver.speed or 100
    local angle = math.random() * math.pi * 2
    self.screensaver.velocity.x = math.cos(angle) * speed
    self.screensaver.velocity.y = math.sin(angle) * speed

    self.screensaver.active = true
    self.screensaver.updateAccumulator = 0

    -- Start OnUpdate handler
    NAG.GroupDisplayFrame:SetScript("OnUpdate", function(frame, elapsed)
        if DisplayManager.screensaver.active then
            DisplayManager.screensaver.updateAccumulator =
                (DisplayManager.screensaver.updateAccumulator or 0) + (elapsed or 0)
            if DisplayManager.screensaver.updateAccumulator < 0.016 then
                return
            end
            local updateElapsed = DisplayManager.screensaver.updateAccumulator
            DisplayManager.screensaver.updateAccumulator = 0
            DisplayManager:UpdateScreensaverPosition(updateElapsed)
        end
    end)
end

--- Stop the screensaver and restore original position
function DisplayManager:StopScreensaver()
    if not self.screensaver.active then
        return
    end

    self:Debug("Stopping screensaver")

    self.screensaver.active = false

    -- Stop OnUpdate handler
    if NAG.GroupDisplayFrame then
        NAG.GroupDisplayFrame:SetScript("OnUpdate", nil)

        -- Restore original position
        if self.screensaver.originalPosition then
            local pos = self.screensaver.originalPosition
            NAG.GroupDisplayFrame:ClearAllPoints()
            NAG.GroupDisplayFrame:SetPoint(
                pos.point or "CENTER",
                pos.relativeTo or UIParent,
                pos.relativePoint or "CENTER",
                pos.xOfs or 0,
                pos.yOfs or 0
            )
        end
    end

    self.screensaver.originalPosition = nil
    self.screensaver.updateAccumulator = 0
end

--- Update screensaver position with bounce physics
--- @param elapsed number Time since last frame
function DisplayManager:UpdateScreensaverPosition(elapsed)
    if not NAG.GroupDisplayFrame or not self.screensaver.active then
        return
    end

    local frame = NAG.GroupDisplayFrame
    local scale = frame:GetEffectiveScale()
    local frameWidth = frame:GetWidth() * scale
    local frameHeight = frame:GetHeight() * scale

    local screenWidth = UIParent:GetWidth()
    local screenHeight = UIParent:GetHeight()

    -- Get current position (center of frame)
    local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()

    -- Convert to screen coordinates (from center)
    local x = xOfs + screenWidth / 2
    local y = yOfs + screenHeight / 2

    -- Apply velocity
    x = x + (self.screensaver.velocity.x * elapsed)
    y = y + (self.screensaver.velocity.y * elapsed)

    -- Bounce off edges
    local halfWidth = frameWidth / 2
    local halfHeight = frameHeight / 2

    -- Left/Right edges
    if x - halfWidth < 0 then
        x = halfWidth
        self.screensaver.velocity.x = math.abs(self.screensaver.velocity.x)
    elseif x + halfWidth > screenWidth then
        x = screenWidth - halfWidth
        self.screensaver.velocity.x = -math.abs(self.screensaver.velocity.x)
    end

    -- Top/Bottom edges
    if y - halfHeight < 0 then
        y = halfHeight
        self.screensaver.velocity.y = math.abs(self.screensaver.velocity.y)
    elseif y + halfHeight > screenHeight then
        y = screenHeight - halfHeight
        self.screensaver.velocity.y = -math.abs(self.screensaver.velocity.y)
    end

    -- Convert back to offset from center
    xOfs = x - screenWidth / 2
    yOfs = y - screenHeight / 2

    -- Update frame position
    frame:ClearAllPoints()
    frame:SetPoint("CENTER", UIParent, "CENTER", xOfs, yOfs)
end

--- Check if screensaver should auto-activate based on idle time
function DisplayManager:CheckScreensaverIdle()
    if not self.db.char.screensaver.enabled then
        return
    end

    -- Don't activate if already active
    if self.screensaver.active then
        return
    end

    -- Don't activate if not in group display mode
    if not self:IsGroupDisplayMode() then
        return
    end

    -- Don't activate in combat
    if UnitAffectingCombat("player") then
        self.screensaver.lastInputTime = GetTime()
        return
    end

    -- Don't activate if player has a target
    if UnitExists("target") then
        self.screensaver.lastInputTime = GetTime()
        return
    end

    -- Check idle time
    local currentTime = GetTime()
    local idleTime = currentTime - self.screensaver.lastInputTime
    local requiredIdleTime = self.db.char.screensaver.idleTime or 60

    if idleTime >= requiredIdleTime then
        self:StartScreensaver()
    end
end

-- ============================ PREDICTION QUEUE SYSTEM  ============================

--- Create prediction queue frames for multi-frame spell recommendations
--- @param numPredictions number Number of prediction frames to create
--- @return table Array of prediction frames
function DisplayManager:CreatePredictionQueue(numPredictions)
    if not numPredictions or numPredictions < 1 then
        numPredictions = 2 -- Default to 2 predictions
    end

    -- Clean up any existing frames to match the new count
    if self.predictionQueue then
        for _, f in ipairs(self.predictionQueue) do
            if f and f.Hide then f:Hide() end
            if f and f.SetParent then f:SetParent(nil) end
        end
    end

    local queueFrames = {}
    local settings = NAG.db.char.predictionQueue or {}

    for i = 1, numPredictions do
        local frame = CreateFrame("Frame", "NAGPredictionFrame" .. i, UIParent)
        frame:SetSize(settings.frameWidth or 44, settings.frameHeight or 44)
        frame:SetFrameStrata("HIGH")
        frame:SetFrameLevel(100 + i) -- Higher level for each subsequent frame

        -- Create spell icon
        local icon = frame:CreateTexture(nil, "ARTWORK")
        icon:SetAllPoints()
        icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        frame.icon = icon

        -- Create cooldown frame
        local cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
        cooldown:SetAllPoints()
        cooldown:SetReverse(true)
        cooldown:SetHideCountdownNumbers(false)
        frame.cooldown = cooldown

        -- Create keybind text (check KeybindManager setting)
        local KeybindManager = NAG:GetModule("KeybindManager")
        local enableKeybinds = KeybindManager and KeybindManager.db and KeybindManager.db.global.enableKeybinds
        if enableKeybinds then
            local keybind = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            keybind:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
            keybind:SetJustifyH("RIGHT")
            keybind:SetTextColor(1, 1, 1)
            frame.keybind = keybind
        end

        -- Create border
        if settings.showBorders then
            local border = frame:CreateTexture(nil, "BORDER")
            border:SetAllPoints()
            border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
            border:SetBlendMode("ADD")
            border:SetAlpha(0.5)
            frame.border = border
        end

        -- Set alpha
        frame:SetAlpha(settings.alpha or 0.9)

        -- Start shown as placeholder until predictions update
        frame:Show()

        queueFrames[i] = frame
    end

    self.predictionQueue = queueFrames

    -- Position immediately so user sees count change without waiting for update tick
    local mainFrame = self:GetMainDisplayFrame()
    if mainFrame then
        self:PositionQueueFrame(mainFrame, settings.direction, settings.spacing)
    end

    return queueFrames
end

--- Position prediction queue frames relative to main display
--- @param mainFrame table The main display frame to position relative to
--- @param direction string Direction to place frames: "RIGHT", "LEFT", "UP", "DOWN"
--- @param spacing number Spacing between frames
function DisplayManager:PositionQueueFrame(mainFrame, direction, spacing)
    if not self.predictionQueue or not mainFrame then
        return
    end

    local settings = NAG.db.char.predictionQueue or {}
    direction = direction or settings.direction or "RIGHT"
    spacing = spacing or settings.spacing or 2

    local frameWidth = settings.frameWidth or 44
    local frameHeight = settings.frameHeight or 44

    -- If we're anchored to an icon frame inside a group, don't add mainFrame:GetWidth/Height twice
    local baseWidth = (mainFrame.GetWidth and mainFrame:GetWidth()) or frameWidth
    local baseHeight = (mainFrame.GetHeight and mainFrame:GetHeight()) or frameHeight

    for i, frame in ipairs(self.predictionQueue) do
        if frame then
            local offsetX, offsetY = 0, 0

            if direction == "RIGHT" then
                offsetX = baseWidth + spacing + (i - 1) * (frameWidth + spacing)
                offsetY = 0
            elseif direction == "LEFT" then
                offsetX = -(baseWidth + spacing + (i - 1) * (frameWidth + spacing))
                offsetY = 0
            elseif direction == "UP" then
                offsetX = 0
                offsetY = baseHeight + spacing + (i - 1) * (frameHeight + spacing)
            elseif direction == "DOWN" then
                offsetX = 0
                offsetY = -(baseHeight + spacing + (i - 1) * (frameHeight + spacing))
            end

            frame:ClearAllPoints()
            frame:SetPoint("CENTER", mainFrame, "CENTER", offsetX, offsetY)
        end
    end
end

--- Update prediction queue frames with spell recommendations
--- @param predictions table Array of spell recommendations
function DisplayManager:UpdatePredictionQueue(predictions)
    if not self.predictionQueue then
        return
    end

    local settings = NAG.db.char.predictionQueue or {}

    predictions = predictions or {}

    -- Hide all frames first (we only show as many as we have predictions)
    for _, frame in ipairs(self.predictionQueue) do
        frame:Hide()
    end

    -- Show and update only the frames we have predictions for
    local maxToShow = math.min(#predictions, #self.predictionQueue)
    for i = 1, maxToShow do
        local frame = self.predictionQueue[i]
        local prediction = predictions[i]
        if frame and prediction and prediction.spell then
            local spell = prediction.spell

            if frame.icon then
                frame.icon:SetTexture(spell.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
            end

            if frame.cooldown then
                if spell.cooldown and spell.cooldown > 0 then
                    frame.cooldown:SetCooldown(spell.cooldownStart or GetTime(), spell.cooldown)
                    frame.cooldown:Show()
                else
                    frame.cooldown:Hide()
                end
            end

            -- Update keybind text (check KeybindManager setting)
            local KeybindManager = NAG:GetModule("KeybindManager")
            local enableKeybinds = KeybindManager and KeybindManager.db and KeybindManager.db.global.enableKeybinds
            if enableKeybinds and frame.keybind then
                frame.keybind:SetText(spell.keybind or "")
            elseif frame.keybind then
                frame.keybind:SetText("")
                frame.keybind:Hide()
            end

            -- Alpha dimming based on prediction confidence/source
            local baseAlpha = settings.alpha or 0.9
            if prediction.source == "static" then
                frame:SetAlpha(baseAlpha * 0.6)
            elseif prediction.confidence and prediction.confidence < 0.5 then
                frame:SetAlpha(baseAlpha * 0.8)
            else
                frame:SetAlpha(baseAlpha)
            end
            frame:Show()
        end
    end

    -- Position frames relative to main display
    local mainFrame = self:GetMainDisplayFrame()
    if mainFrame then
        self:PositionQueueFrame(mainFrame, settings.direction, settings.spacing)
    end
end

--- Handle keybind setting changes - refresh prediction queue keybinds and re-apply overlays when re-enabled
--- @param messageName string The message name
--- @param setting string The setting that changed
--- @param value any The new value
function DisplayManager:NAG_KEYBIND_SETTING_CHANGED(messageName, setting, value)
    if setting == "enableKeybinds" then
        if value then
            -- Re-enabled: KeybindManager was just enabled and stripped overlays were on our frames.
            -- Re-apply keybind overlays to all display frames that support them.
            if NAG.Frame and NAG.Frame.iconFrames then
                for _, frame in pairs(NAG.Frame.iconFrames) do
                    if frame then
                        AddKeybindOverlayToFrame(frame)
                    end
                end
            end
            if self.groupFrames then
                for _, groupFrame in pairs(self.groupFrames) do
                    if groupFrame and groupFrame.iconFrames then
                        for _, icon in ipairs(groupFrame.iconFrames) do
                            if icon then
                                AddKeybindOverlayToFrame(icon)
                            end
                        end
                    end
                end
            end
        end

        -- Refresh prediction queue to show/hide keybinds based on new setting
        if self.predictionQueue then
            -- Get current predictions from RotationManager if available
            local RotationManager = NAG:GetModule("RotationManager")
            if RotationManager and RotationManager.GetPredictions then
                local predictions = RotationManager:GetPredictions()
                if predictions then
                    self:UpdatePredictionQueue(predictions)
                end
            else
                -- Just update existing frames to hide/show keybinds
                local KeybindManager = NAG:GetModule("KeybindManager")
                local enableKeybinds = KeybindManager and KeybindManager.db and KeybindManager.db.global.enableKeybinds
                for _, frame in ipairs(self.predictionQueue) do
                    if frame.keybind then
                        if enableKeybinds then
                            -- Keybind text will be updated on next prediction update
                            frame.keybind:Show()
                        else
                            frame.keybind:SetText("")
                            frame.keybind:Hide()
                        end
                    end
                end
            end
        end
    end
end

--- Get the main display frame for positioning reference
--- @return Frame|nil Main display frame
function DisplayManager:GetMainDisplayFrame()
    -- For standalone prediction queue frames, prefer legacy frame if enabled
    -- (standalone frames are only used with legacy display)
    if self:IsLegacyFrameEnabled() and NAG.Frame then
        -- Use legacy primary icon if available, otherwise the legacy container
        if NAG.Frame.iconFrames and NAG.Frame.iconFrames["primary"] then
            return NAG.Frame.iconFrames["primary"]
        end
        return NAG.Frame
    end

    -- Fallback to GroupDisplay if legacy is not enabled
    if self:IsGroupDisplayMode() then
        local mainGroup = self.groupFrames and self.groupFrames[ns.FRAME_GROUPS.MAIN]
        if mainGroup and mainGroup.iconFrames and mainGroup.iconFrames[1] then
            return mainGroup.iconFrames[1]
        end
        -- Fallback to overall group container if primary icon is not yet built
        if NAG.GroupDisplayFrame then
            return NAG.GroupDisplayFrame
        end
    end

    -- Generic fallbacks
    if NAG.GroupDisplayFrame then return NAG.GroupDisplayFrame end
    if NAG.Frame then return NAG.Frame end
    return UIParent
end

--- Frame the floating selector should anchor to (content bounds, not the outer drag frame)
--- In group mode returns the MAIN group frame so the selector sits at top-right of the icon row.
--- @return Frame|nil Anchor frame for the floating selector
function DisplayManager:GetFloatingSelectorAnchorFrame()
    if self:IsGroupDisplayMode() then
        local mainGroup = self.groupFrames and self.groupFrames[ns.FRAME_GROUPS.MAIN]
        if mainGroup then
            return mainGroup
        end
        if NAG.GroupDisplayFrame then
            return NAG.GroupDisplayFrame
        end
        return nil
    end

    if self:IsLegacyFrameEnabled() and NAG.Frame then
        return NAG.Frame
    end

    return nil
end

--- Hide all prediction queue frames
function DisplayManager:HidePredictionQueue()
    if self.predictionQueue then
        for _, frame in ipairs(self.predictionQueue) do
            frame:Hide()
        end
    end
end

--- Show prediction queue if enabled
function DisplayManager:ShowPredictionQueue()
    local settings = NAG.db.char.predictionQueue or {}
    if settings.enabled and self.predictionQueue then
        for _, frame in ipairs(self.predictionQueue) do
            frame:Show()
        end
    end
end
