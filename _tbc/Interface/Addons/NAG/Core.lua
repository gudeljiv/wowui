--- @module "NAG.core"
--- This module is the core module for the Next Action Guide addon
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...

-- ============================ GLOBAL CONFIGURATION FLAGS ============================
-- Error handling configuration (now controlled by NAG:IsDevModeEnabled())
--- @class NAG : AceAddon
local NAG = LibStub("AceAddon-3.0"):NewAddon("NAG", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")

-- ============================ STARTUP TIMING / GRACE WINDOWS ============================

local GetTime = _G.GetTime

-- Record addon load time as early as possible (once per session)
-- Used to suppress noisy rotation-load error logs during early startup.
ns.addonLoadedAt = ns.addonLoadedAt or (GetTime and GetTime() or 0)

--- Returns true if we're within the startup grace window for rotation-related logs.
--- Grace window applies for 30s after addon load and also for 30s after expansion data becomes ready.
--- This intentionally suppresses only premature logging while systems are still initializing.
--- @param graceSeconds number|nil Duration in seconds (default 30)
--- @return boolean
function ns.IsRotationStartupGraceActive(graceSeconds)
    graceSeconds = graceSeconds or 30
    local now = GetTime and GetTime() or 0
    -- During very early load, GetTime() can be 0. Treat this as startup grace to avoid noisy logs.
    if now <= 0 then
        return true
    end

    -- If addonLoadedAt wasn't captured correctly (e.g., GetTime was 0 at file load),
    -- initialize it on first meaningful call.
    if not ns.addonLoadedAt or ns.addonLoadedAt <= 0 then
        ns.addonLoadedAt = now
    end

    local addonLoadedAt = ns.addonLoadedAt or 0
    if addonLoadedAt > 0 and (now - addonLoadedAt) < graceSeconds then
        return true
    end

    -- If expansionDataLoadedAt was recorded as 0 for any reason, normalize it too.
    local expansionDataLoadedAt = ns.expansionDataLoadedAt or 0
    if expansionDataLoadedAt < 0 then
        expansionDataLoadedAt = 0
    end
    if expansionDataLoadedAt > 0 and (now - expansionDataLoadedAt) < graceSeconds then
        return true
    end

    return false
end

-- Requirements checking configuration
ns.USE_REQUIREMENTS_CHECKER = false -- Toggle for RequirementsChecker functionality

-- Development configuration
-- When true, all modules created via NAG:CreateModule() will have self.debug set to true at creation time.
-- Useful during refactors to ensure debug-guarded codepaths execute without editing per-module settings.
ns.FORCE_MODULE_DEBUG_ON_CREATE, NAG.debug = false, false

-- Database reset configuration
ns.FORCE_DATABASE_RESET = false -- Toggle for forcing database reset on reload (dev use only)

-- Visitor pattern execution configuration
ns.USE_VISITOR_PATTERN = false -- Toggle for visitor pattern execution (schema-aware AST execution)

-- Rotation string synchronization configuration
ns.USE_SYNC_ROTATION_STRING = false -- Toggle for syncing rotationString from aplProto in visual editor


-- Set default module libraries (AceTimer required for ScheduleTimer/CancelTimer used by StateManager, DataManager, SpecCompat, EventManager, etc.)
NAG:SetDefaultModuleLibraries("AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")

-- Expose main addon instance on namespace for performance and consistency
ns.NAG = NAG


-- Expose Ace3 libraries on namespace immediately for performance (3-5x faster access)
-- Type definitions are in NAG/annotations.lua (@meta file for language server)

--- @type AceDB-3.0
ns.AceDB = LibStub("AceDB-3.0")

--- @type AceConfigRegistry-3.0
ns.AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

--- @type AceConfigDialog-3.0
ns.AceConfigDialog = LibStub("AceConfigDialog-3.0")

--- @type AceConfig-3.0
ns.AceConfig = LibStub("AceConfig-3.0")

--- @type AceDBOptions-3.0
ns.AceDBOptions = LibStub("AceDBOptions-3.0")

--- @type AceLocale-3.0
ns.AceLocale = LibStub("AceLocale-3.0")

--- @type AceEvent-3.0
ns.AceEvent = LibStub("AceEvent-3.0")


--- @type AceConsole-3.0
ns.AceConsole = LibStub("AceConsole-3.0")

--- @type AceTimer-3.0
ns.AceTimer = LibStub("AceTimer-3.0")

--- @type AceGUI-3.0
ns.AceGUI = LibStub("AceGUI-3.0")

--- @type AceHook-3.0
ns.AceHook = LibStub("AceHook-3.0")

--- @type AceSerializer-3.0
ns.AceSerializer = LibStub("AceSerializer-3.0")


--- @type AceTab-3.0
ns.AceTab = LibStub("AceTab-3.0")

ns.RC = LibStub("LibRangeCheck-3.0")
ns.LibClassicSwingTimerAPI = LibStub("LibClassicSwingTimerAPI")
ns.LibSharedMedia = LibStub("LibSharedMedia-3.0")
ns.LibCustomGlow = LibStub("LibCustomGlow-1.0")
ns.LibJSON = LibStub("LibJSON-1.0")
ns.LibUIDropDownMenu = LibStub("LibUIDropDownMenu-4.0")
ns.Masque = LibStub("Masque", true)
ns.LibBase64 = LibStub:GetLibrary("LibBase64-1.0")

-- Unified library facade (tests can override entries on ns.Libs)
ns.Libs = ns.Libs or {}
local Libs = ns.Libs

Libs.AceDB = ns.AceDB
Libs.AceConfigRegistry = ns.AceConfigRegistry
Libs.AceConfigDialog = ns.AceConfigDialog
Libs.AceConfig = ns.AceConfig
Libs.AceDBOptions = ns.AceDBOptions
Libs.AceLocale = ns.AceLocale
Libs.AceEvent = ns.AceEvent
Libs.AceConsole = ns.AceConsole
Libs.AceTimer = ns.AceTimer
Libs.AceGUI = ns.AceGUI
Libs.AceHook = ns.AceHook
Libs.AceSerializer = ns.AceSerializer
Libs.AceTab = ns.AceTab
Libs.RangeCheck = ns.RC
Libs.LibClassicSwingTimerAPI = ns.LibClassicSwingTimerAPI
Libs.LibSharedMedia = ns.LibSharedMedia
Libs.LibCustomGlow = ns.LibCustomGlow
Libs.LibJSON = ns.LibJSON
Libs.LibUIDropDownMenu = ns.LibUIDropDownMenu
Libs.Masque = ns.Masque
Libs.LibBase64 = ns.LibBase64

-- Module name aliases for shorter, cleaner logging
ns.MODULE_ALIASES = {
    ["NAG"] = "NAG",
    ["CoreModule"] = "Core",
    ["OptionsManager"] = "OptMgr",
    ["DisplayManager"] = "DispMgr",
    ["StateManager"] = "StateMgr",
    ["DebugManager"] = "DebugMgr",
    ["DataManager"] = "DataMgr",
    ["MigrationManager"] = "MigMgr",
    ["RotationManager"] = "RotMgr",
    ["SpellTrackingManager"] = "SpellMgr",
    ["TooltipParser"] = "TooltipParser",
    ["KeybindManager"] = "KeybindMgr",
    ["UptimeTracker"] = "Uptime",
    ["ProfilingUtility"] = "Prof",
    ["CLEUDebugger"] = "CLEU",
    ["APLTest"] = "APLTest",
    ["TrinketRegistrationManager"] = "TrinketMgr",
    ["ChatCommandUtils"] = "CmdUtils",
    ["DatabaseUtils"] = "DBUtils",
    ["EventManager"] = "EventMgr",
    ["OverlayManager"] = "OverlayMgr",
    ["FrameManager"] = "FrameMgr",
    ["GroupDisplayManager"] = "GroupMgr",
    ["LegacyFrameManager"] = "LegacyMgr",
    ["ConfigManager"] = "ConfigMgr",
    ["ProfileManager"] = "ProfileMgr",
    ["ResetManager"] = "ResetMgr",
    ["HelpManager"] = "HelpMgr",
    ["AcknowledgementsManager"] = "AckMgr",
    -- Class modules
    ["WARRIOR"] = "Warrior",
    ["PALADIN"] = "Paladin",
    ["HUNTER"] = "Hunter",
    ["ROGUE"] = "Rogue",
    ["PRIEST"] = "Priest",
    ["DEATHKNIGHT"] = "DK",
    ["SHAMAN"] = "Shaman",
    ["MAGE"] = "Mage",
    ["WARLOCK"] = "Warlock",
    ["MONK"] = "Monk",
    ["DRUID"] = "Druid",
    ["DEMONHUNTER"] = "DH",
    ["EVOKER"] = "Evoker",
}

-- ============================ MODULE SYSTEM CONSTANTS ============================

-- Module types
ns.MODULE_TYPES = {
    CORE = "core",      -- Core modules are always loaded
    CLASS = "class",    -- Class modules are loaded only for matching class
    DEBUG = "debug",    -- Debug modules are only loaded in debug mode
    FEATURE = "feature" -- Optional feature modules that can be enabled/disabled
}

-- Module categories for options UI
ns.MODULE_CATEGORIES = {
    SPLASH = "splash",                     -- Welcome/Splash options (first tab)
    UI = "ui",                             -- UI/Display options
    CLASS = "class",                       -- Class-specific options
    FEATURE = "features",                  -- Feature options
    LEADERBOARD = "leaderboard",           -- Leaderboard options
    RESET = "reset",                       -- Reset options
    DEBUG = "debug",                       -- Debug options
    ACKNOWLEDGEMENTS = "acknowledgements", -- Acknowledgements options
}
ns.OPTIONS_CATEGORIES = ns.MODULE_CATEGORIES

-- Debug levels for logging
ns.DEBUG_LEVELS = {
    NONE = 0,
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    DEBUG = 4,
    TRACE = 5
}

-- Debug categories for group-based debugging
ns.DEBUG_CATEGORIES = {
    GENERAL = "general",       -- General modules (default)
    DISPLAY = "display",       -- Display/UI related modules
    COMBAT = "combat",         -- Combat-related modules
    DATA = "data",             -- Data management modules
    EVENTS = "events",         -- Event handling modules
    STATE = "state",           -- State management modules
    OPTIONS = "options",       -- Options/configuration modules
    SERVICES = "services",     -- Service modules
    DEBUG = "debug",           -- Debug/development modules
    CLASS = "class",           -- Class-specific modules
    FEATURES = "features",     -- Feature modules
    UTILITIES = "utilities",   -- Utility modules
    HANDLERS = "handlers",     -- Event/action handlers
    MANAGERS = "managers",     -- Manager modules
    PROCESSORS = "processors", -- Data processors
    VALIDATORS = "validators", -- Validation modules
    RENDERERS = "renderers",   -- Rendering modules
    TRACKERS = "trackers",     -- Tracking modules
    ANALYZERS = "analyzers",   -- Analysis modules
    SPELLBOOK = "spellbook",   -- Spellbook management modules
}

-- ============================ APL PROTO VERSION ============================

-- Current version of the aplProto format
-- Increment this when the proto schema changes (new required fields, structural changes, etc.)
-- This enables automatic migration of saved rotation data
-- Set to 0 until rotationString generation is stable and ready for release
ns.APL_PROTO_VERSION = 0

-- Default enabled states by module type
ns.DEFAULT_ENABLED_BY_TYPE = {
    [ns.MODULE_TYPES.CORE] = true,
    [ns.MODULE_TYPES.CLASS] = true,
    [ns.MODULE_TYPES.FEATURE] = false,
    [ns.MODULE_TYPES.DEBUG] = false
}

-- Default category by module type
ns.DEFAULT_CATEGORY_BY_TYPE = {
    [ns.MODULE_TYPES.CORE] = ns.MODULE_CATEGORIES.DEBUG,     -- Core modules with specified category go to debug
    [ns.MODULE_TYPES.DEBUG] = ns.MODULE_CATEGORIES.DEBUG,    -- Debug modules go to DEBUG
    [ns.MODULE_TYPES.CLASS] = ns.MODULE_CATEGORIES.CLASS,    -- Class modules go to CLASS
    [ns.MODULE_TYPES.FEATURE] = ns.MODULE_CATEGORIES.FEATURE -- Feature modules go to FEATURE
}

-- Default debug category by module type
ns.DEFAULT_DEBUG_CATEGORY_BY_TYPE = {
    [ns.MODULE_TYPES.CORE] = ns.DEBUG_CATEGORIES.SERVICES,
    [ns.MODULE_TYPES.DEBUG] = ns.DEBUG_CATEGORIES.DEBUG,
    [ns.MODULE_TYPES.CLASS] = ns.DEBUG_CATEGORIES.CLASS,
    [ns.MODULE_TYPES.FEATURE] = ns.DEBUG_CATEGORIES.FEATURES
}

-- Category order mapping for options UI
ns.CATEGORY_ORDER = {
    [ns.MODULE_CATEGORIES.SPLASH] = 1,            -- First tab (Welcome/Splash)
    [ns.MODULE_CATEGORIES.UI] = 2,                -- Second tab
    [ns.MODULE_CATEGORIES.CLASS] = 3,             -- Third tab
    [ns.MODULE_CATEGORIES.FEATURE] = 4,           -- Fourth tab
    [ns.MODULE_CATEGORIES.LEADERBOARD] = 5,       -- Fifth tab
    [ns.MODULE_CATEGORIES.DEBUG] = 6,             -- Sixth tab
    [ns.MODULE_CATEGORIES.RESET] = 20,            -- Keep reset available but not in main order
    [ns.MODULE_CATEGORIES.ACKNOWLEDGEMENTS] = 30, -- Keep acknowledgements available but not in main order
}

-- Category layout mapping for options UI
ns.CATEGORY_LAYOUT = {
    splash = "tab",           -- Welcome/Splash as tab layout
    class = "tree",           -- Class as tree layout
    debug = "tree",           -- Debug as tree layout
    leaderboard = "tree",     -- Leaderboard as tree layout
    features = "tree",        -- Features as tree layout
    ui = "tree",              -- UI as tree layout
    reset = "tab",            -- Reset as tab layout
    acknowledgements = "tab", -- Acknowledgements as tab layout
}

-- ============================ MODULE SYSTEM HELPER FUNCTIONS ============================

--- Get the order of a category
--- @param category string The category to get the order for
--- @return number The order of the category
function ns.GetCategoryOrder(category)
    return ns.CATEGORY_ORDER[category] or 100
end

--- Get the layout type for a category
--- @param category string The category to get the layout for
--- @return string The layout type ("tab", "tree", etc.)
function ns.GetCategoryLayout(category)
    return ns.CATEGORY_LAYOUT[category] or "tree"
end

--- Get the default category for a module type
--- @param moduleType string The module type
--- @return string The default category for this module type
function ns.GetDefaultCategory(moduleType)
    return ns.DEFAULT_CATEGORY_BY_TYPE[moduleType] or ns.MODULE_CATEGORIES.DEBUG
end

--- Get the default enabled state for a module type
--- @param moduleType string The module type
--- @return boolean The default enabled state for this module type
function ns.GetDefaultEnabledState(moduleType)
    return ns.DEFAULT_ENABLED_BY_TYPE[moduleType] or false
end

--- Get the default debug category for a module type
--- @param moduleType string The module type
--- @return string The default debug category for this module type
function ns.GetDefaultDebugCategory(moduleType)
    return ns.DEFAULT_DEBUG_CATEGORY_BY_TYPE[moduleType] or ns.DEBUG_CATEGORIES.GENERAL
end

-- ============================ MODULE NAMESPACE EXPOSURE ============================

--- Exposes all modules from modules.xml on the namespace for performance
--- This function should be called in NAG:OnInitialize() after all modules are registered
--- @param self NAG The addon object
function NAG:ExposeModulesOnNamespace()
    -- Dynamic module exposure - iterate over all available modules
    if self.modules then
        for moduleName, module in pairs(self.modules) do
            -- Skip if already exposed (prevents overwriting)
            if not ns[moduleName] then
                ns[moduleName] = module
            end
        end
    end

    -- Special handling for modules that need safe loading (may not exist)
    local safeLoadModules = {
        "SpellAnalyzer",
        "SpellLearnerStateManager",
        "PredictionManager",
        "PredictionAPI",
        "SpellLearner",
        "ShamanWeaveModule",
        "ShamanWeaveBar",
        "MigrationManager",
        "EventManager"
    }

    for _, moduleName in ipairs(safeLoadModules) do
        if not ns[moduleName] then
            local module = self:GetModule(moduleName, true)
            if module then
                ns[moduleName] = module
            end
        end
    end
end

-- ============================ AUTO-LOCALE CONSTANTS REGISTRY ============================

--- Registry of constant tables that should have auto-generated locale entries
--- Each entry will generate L["constantValue"] = "Proper Display Text"
ns.AUTO_LOCALE_CONSTANTS = {
    "SPELL_POSITIONS",   -- left -> "Left", primary -> "Primary"
    "FRAME_GROUPS",      -- main -> "Main", cooldowns -> "Cooldowns"
    "DEBUG_CATEGORIES",  -- general -> "General", features -> "Features"
    "MODULE_CATEGORIES", -- ui -> "UI", data -> "Data"
    "MODULE_TYPES"       -- core -> "Core", feature -> "Feature"
}

-- ============================ SPELL POSITION CONSTANTS ============================

--- Standard spell position constants (single source of truth)
--- These define where spells appear in the display system
--- Values use lowercase to match legacy system expectations
--- NOTE: SpellPositions is now registered in Types.lua, but we maintain
--- these aliases for backward compatibility and early access (before Types loads)
--- The actual type is available via Types:GetType("SpellPositions") after Types module loads
ns.SPELL_POSITIONS = {
    LEFT = "left",                       -- Left side positions (cooldowns)
    RIGHT = "right",                     -- Right side positions (sequences)
    ABOVE = "above",                     -- Above primary (defensives)
    BELOW = "below",                     -- Below primary (interrupts)
    AOE = "aoe",                         -- AOE position
    PRIMARY = "primary",                 -- Primary/center position (main spell)
    SEQUENCE = "sequence",               -- Sequence system spells
}
NAG.SPELL_POSITIONS = ns.SPELL_POSITIONS -- create early alias for Classes loadstring

-- Validation helper for position constants
-- Uses Types system when available, falls back to direct lookup
ns.VALID_SPELL_POSITIONS = {}
for _, position in pairs(ns.SPELL_POSITIONS) do
    ns.VALID_SPELL_POSITIONS[position] = true
end

--- Validates if a position string is valid
--- @param position string The position to validate
--- @return boolean True if valid spell position
function ns.IsValidSpellPosition(position)
    -- Try Types system first (when available)
    if ns.Types then
        local spellPositionsType = ns.Types:GetType("SpellPositions")
        if spellPositionsType and spellPositionsType:IsValid(position) then
            return true
        end
    end
    -- Fallback to direct lookup (for early access before Types loads)
    return ns.VALID_SPELL_POSITIONS[position] == true
end

-- ============================ ROTATION TYPE CONSTANTS ============================

--- Rotation type constants (single source of truth)
--- These define the classification of rotations for smart switching
--- Values match WowSims proto schema enum values
ns.ROTATION_TYPES = {
    UNKNOWN_TYPE = 0,  -- Unknown or unclassified rotation type
    SINGLE_TARGET = 1, -- Single target focused rotation
    CUSTOM = 2,        -- Custom/mixed rotation type
    AOE = 3            -- Area of effect focused rotation
}

-- Early alias for Classes loadstring
NAG.ROTATION_TYPES = ns.ROTATION_TYPES

-- Validation helper for rotation type constants
ns.VALID_ROTATION_TYPES = {}
for _, value in pairs(ns.ROTATION_TYPES) do
    ns.VALID_ROTATION_TYPES[value] = true
end

--- Validates if a rotation type value is valid
--- @param rotationType number The rotation type value to validate
--- @return boolean True if valid rotation type
function ns.IsValidRotationType(rotationType)
    return ns.VALID_ROTATION_TYPES[rotationType] == true
end

--- Gets the human-readable name for a rotation type
--- @param rotationType number The rotation type value
--- @return string name The human-readable name
function ns.GetRotationTypeName(rotationType)
    if rotationType == ns.ROTATION_TYPES.UNKNOWN_TYPE then
        return "Unknown"
    elseif rotationType == ns.ROTATION_TYPES.SINGLE_TARGET then
        return "Single Target"
    elseif rotationType == ns.ROTATION_TYPES.CUSTOM then
        return "Custom"
    elseif rotationType == ns.ROTATION_TYPES.AOE then
        return "AOE"
    else
        return "Invalid"
    end
end

-- ============================ CUSTOM CONDITION TYPE CONSTANTS ============================

--- Custom condition types for rotation switching
--- These define the types of custom conditions that can be evaluated
--- for intelligent rotation switching
ns.CUSTOM_CONDITION_TYPES = {
    WEAPON_TYPE = "WeaponType",        -- Weapon type conditions (dual-wield, two-hand, etc.)
    TARGET_COUNT = "TargetCount",      -- Target count conditions (min/max targets)
    AURA_ACTIVE = "AuraActive",        -- Aura conditions (buffs, debuffs, stacks)
    GROUP_CONTEXT = "GroupContext",    -- Group context conditions (solo, group, raid)
    ASSIGNMENT = "Assignment",         -- Assignment conditions (class assignment toggles)
    CUSTOM_FUNCTION = "CustomFunction" -- Custom Lua function conditions
}

-- Early alias for Classes loadstring
NAG.CUSTOM_CONDITION_TYPES = ns.CUSTOM_CONDITION_TYPES

-- Validation helper for custom condition type constants
ns.VALID_CUSTOM_CONDITION_TYPES = {}
for _, value in pairs(ns.CUSTOM_CONDITION_TYPES) do
    ns.VALID_CUSTOM_CONDITION_TYPES[value] = true
end

--- Validates if a custom condition type is valid
--- @param conditionType string The custom condition type to validate
--- @return boolean True if valid custom condition type
function ns.IsValidCustomConditionType(conditionType)
    return ns.VALID_CUSTOM_CONDITION_TYPES[conditionType] == true
end

-- ============================ FRAME GROUP CONSTANTS ============================

--- New frame group system constants (single source of truth)
--- These define the modern group-based display system
ns.FRAME_GROUPS = {
    MAIN = "main",                 -- Main/primary spell group
    AOE = "aoe",                   -- AOE spell group
    COOLDOWNS = "cooldowns",       -- Cooldown spell group
    INTERRUPTS = "interrupts",     -- Interrupt spell group
    DEFENSIVES = "defensives",     -- Defensive spell group
    SEQUENCE = "sequence"          -- Sequence spell group
}
NAG.FRAME_GROUPS = ns.FRAME_GROUPS -- create early alias for Classes loadstring
-- Validation helper for frame group constants
ns.VALID_FRAME_GROUPS = {}
for _, group in pairs(ns.FRAME_GROUPS) do
    ns.VALID_FRAME_GROUPS[group] = true
end

--- Validates if a frame group string is valid
--- @param group string The group to validate
--- @return boolean True if valid frame group
function ns.IsValidFrameGroup(group)
    return ns.VALID_FRAME_GROUPS[group] == true
end

-- ============================ UNIT ITERATION HELPERS ============================
--- Returns a canonical list of units for iteration (player, focus, target, mouseover, nameplates)
--- @return table
function ns.GetIterableUnits()
    if not ns._iterableUnits then
        local units = { "player", "focus", "target", "mouseover" }
        for i = 1, 43 do
            units[#units + 1] = "nameplate" .. i
        end
        ns._iterableUnits = units
    end
    return ns._iterableUnits
end

-- ============================ PvP HELPERS ============================

local UnitInArena = _G.UnitInArena
local UnitInBattleground = _G.UnitInBattleground
local GetInstanceInfo = _G.GetInstanceInfo

--- Returns true if the player is in an arena
--- @return boolean
function ns.IsInArena()
    if UnitInArena and UnitInArena("player") then
        return true
    end
    local inInstance, instanceType = GetInstanceInfo and GetInstanceInfo()
    return inInstance and instanceType == "arena"
end

--- Returns true if the player is in a battleground
--- @return boolean
function ns.IsInBattleground()
    if UnitInBattleground and UnitInBattleground("player") then
        return true
    end
    local inInstance, instanceType = GetInstanceInfo and GetInstanceInfo()
    return inInstance and instanceType == "pvp"
end

--- Returns true if the player is in any PvP instance (arena or battleground)
--- @return boolean
function ns.IsInPvP()
    return ns.IsInArena() or ns.IsInBattleground()
end

--- Returns arena unit IDs (arena1 through arena5 for rated, arena1-3 for skirmish)
--- @param maxSlots number|nil Maximum slots (default 5 for rated, 3 for skirmish - uses 5)
--- @return table Array of unit strings
function ns.GetArenaUnits(maxSlots)
    maxSlots = maxSlots or 5
    local units = {}
    for i = 1, maxSlots do
        units[i] = "arena" .. i
    end
    return units
end

--- Maps a GUID to arena unit string when in arena
--- @param guid string Unit GUID
--- @return string|nil arena1, arena2, etc. or nil if not in arena or not found
function ns.GetArenaUnitForGUID(guid)
    if not guid then return nil end
    local PvPTracker = ns.PvPTracker
    if PvPTracker and PvPTracker.state and PvPTracker.state.guidToArenaUnit then
        return PvPTracker.state.guidToArenaUnit[guid]
    end
    if not ns.IsInArena() then return nil end
    local UnitGUID = _G.UnitGUID
    for i = 1, 5 do
        local unit = "arena" .. i
        if UnitGUID(unit) == guid then
            return unit
        end
    end
    return nil
end

--- Returns units for PvP iteration (includes arena units when in arena)
--- @return table
function ns.GetPvPIterableUnits()
    local units = { "player", "focus", "target", "mouseover" }
    if ns.IsInArena() then
        for i = 1, 5 do
            units[#units + 1] = "arena" .. i
        end
    end
    return units
end
