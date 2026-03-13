--- @module "ClassBase"
--- Provides a base class for all class modules in NAG.
---
--- ## Class Module Caching System
---
--- NAG implements a class module caching system for optimal performance:
---
--- ### How It Works
--- 1. **Automatic Caching**: When `CreateClassModule()` is called, the created module is automatically
---    cached on `NAG.classModule` for fast access
--- 2. **Fast Access**: Use `NAG:GetClassModule()` for optimal performance
--- 3. **Fallback Support**: If the cache is not available, `GetClassModule()` falls back to the traditional
---    `GetModule()` approach and caches the result
---
--- ### Usage Examples
--- ```lua
--- -- Standard access (recommended for most cases)
--- local classModule = NAG:GetClassModule()
--- if classModule then
---     -- Use the class module
--- end
---
--- -- Direct access (for performance-critical code only)
--- local classModule = NAG.classModule
--- if classModule then
---     -- Use the class module
--- end
--- ```
---
--- ### Performance Benefits
--- - **GetClassModule()**: 2.1x faster than traditional module lookups
--- - **Direct access**: 5.2x faster than traditional module lookups
--- - **Automatic caching**: Eliminates repeated lookups throughout the codebase
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local WoWAPI = ns.WoWAPI
local UnitGUID = _G.UnitGUID
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsInRaid = _G.IsInRaid
local IsInGroup = _G.IsInGroup
local GetTime = _G.GetTime
local GetInventoryItemID = _G.GetInventoryItemID
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @type StateManager, DisplayManager, RotationManager, DataManager, SpellbookManager, TimerManager
local StateManager, DisplayManager, RotationManager, DataManager, SpellbookManager, TimerManager

--- @type SpecCompat
local SpecCompat

--- @type Version
local Version = ns.Version
local L = ns.AceLocale:GetLocale("NAG", true)
local AceConfigRegistry = ns.AceConfigRegistry
local AceConfigDialog = ns.AceConfigDialog
local AceGUI = ns.AceGUI
local StringUtil = ns.StringUtil
local StaticPopup_OnClick = StaticPopup_OnClick
local StaticPopup_Show = _G.StaticPopup_Show
local StaticPopupDialogs = _G.StaticPopupDialogs

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format

local strlower = strlower
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

local sort = table.sort
local concat = table.concat
local pcall = ns.pcall

local ASSIGNMENT_GATE_TTL_SECONDS = 30


-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Create a logging context for namespace functions to use proper debug filtering
local loggingContext = {
    GetName = function() return "ClassBase" end,
    GetDebugCategories = function() return { "class" } end,
    IsDebugEnabledForCategories = function() return false end -- Disable debug by default
}

--- Helper function to format spell or item ID with icon and name
--- @param id number The spell or item ID
--- @param isItem boolean Whether this is an item (true) or spell (false)
--- @return string Formatted string with icon and name, or "Unknown (ID)" if not found
local function FormatWithIcon(id, isItem)
    if not id or type(id) ~= "number" then
        return "Invalid ID"
    end

    local name, icon
    if isItem then
        name = WoWAPI.GetItemInfo(id)
        icon = GetItemIcon(id)
    else
        local spellInfo = WoWAPI.GetSpellInfo(id)
        if spellInfo then
            name = spellInfo.name
            icon = spellInfo.iconID
        end
    end

    if name and icon then
        return format("|T%s:20:20|t %s", icon, name)
    end

    -- Add more debugging info for unknown items/spells
    local debugInfo = "Unknown (" .. tostring(id) .. ")"
    if isItem then
        debugInfo = debugInfo .. " [Item]"
    else
        debugInfo = debugInfo .. " [Spell]"
    end
    return debugInfo
end


function ns.AddRotationToDefaults(defaults, specIndex, config)
    if not specIndex then
        ns.DebugManager:warn(loggingContext, "AddRotationToDefaults: specIndex parameter is required!")
        return
    end

    -- Get the name from the config object
    local name = config.name
    if not name then
        ns.DebugManager:warn(loggingContext, "AddRotationToDefaults: Config missing name field!")
        return
    end

    local className = config.class or NAG.CLASS_FILENAME

    ns.DebugManager:info(loggingContext,
        "AddRotationToDefaults: Adding rotation " .. tostring(name) .. " for specIndex " .. tostring(specIndex))

    -- Ensure identification fields are embedded into the config
    config.specIndex = specIndex  -- Use specIndex only
    config.class = className

    -- Debug: Check the incoming config
    ns.DebugManager:debug(loggingContext, "AddRotationToDefaults: Config validation:")
    ns.DebugManager:debug(loggingContext, "  - name: " .. tostring(name))
    ns.DebugManager:debug(loggingContext,
        "  - rotationString: " .. tostring(config.rotationString and "present" or "missing"))
    ns.DebugManager:debug(loggingContext, "  - enabled: " .. tostring(config.enabled))
    ns.DebugManager:debug(loggingContext, "  - default: " .. tostring(config.default))
    ns.DebugManager:debug(loggingContext, "  - gameType: " .. tostring(config.gameType))
    ns.DebugManager:debug(loggingContext, "  - author: " .. tostring(config.author))
    ns.DebugManager:debug(loggingContext, "  - talentsString: " .. tostring(config.talentsString or "none"))
    ns.DebugManager:debug(loggingContext, "  - consumables: " .. tostring(config.consumables and "present" or "none"))
    ns.DebugManager:debug(loggingContext, "  - groups: " .. tostring(config.groups and #config.groups or "none"))
    ns.DebugManager:debug(loggingContext, "  - variables: " .. tostring(config.variables and #config.variables or "none"))
    ns.DebugManager:debug(loggingContext, "  - guide: " .. tostring(config.guide and "present" or "none"))

    -- Validate that required fields are present
    if not config.rotationString then
        ns.DebugManager:warn(loggingContext,
            "AddRotationToDefaults: Rotation " .. tostring(name) .. " is missing rotationString!")
    end

    -- Set default rotationType to Custom if not specified
    if not config.rotationType then
        config.rotationType = ns.ROTATION_TYPES.CUSTOM
        ns.DebugManager:debug(loggingContext,
            "AddRotationToDefaults: Set default rotationType to Custom for rotation " .. tostring(name))
    end

    -- Validate the rotationType
    if not ns.IsValidRotationType(config.rotationType) then
        ns.DebugManager:warn(loggingContext,
            "AddRotationToDefaults: Invalid rotationType " ..
            tostring(config.rotationType) .. " for rotation " .. tostring(name))
        config.rotationType = ns.ROTATION_TYPES.CUSTOM -- Fallback to Custom
    end

    -- Base rotations should be treated as addon defaults unless explicitly marked otherwise
    if config.isBaseRotation == nil then
        config.isBaseRotation = true
    end
    if config.userModified == nil then
        config.userModified = false
    end

    -- Auto-enable smart switching if conditions are present
    if config.customConditions and next(config.customConditions) then
        if config.enableSmartSwitching == nil then
            config.enableSmartSwitching = true
            ns.DebugManager:debug(loggingContext,
                "AddRotationToDefaults: Auto-enabled smart switching for rotation " .. tostring(name) ..
                " (has customConditions)")
        end
    end

    -- Initialize the class structure if needed
    defaults.class = defaults.class or {}
    defaults.class.rotations = defaults.class.rotations or {}
    defaults.class.rotations[specIndex] = defaults.class.rotations[specIndex] or {}

    -- Initialize the char structure if needed (for selectedRotations)
    defaults.char = defaults.char or {}
    defaults.char.selectedRotations = defaults.char.selectedRotations or {}

    -- Note: useCustomSpellLocations should be explicitly set in rotation config
    -- Auto-set only if not already defined and spellLocations exist
    if config.useCustomSpellLocations == nil then
        config.useCustomSpellLocations = config.spellLocations and next(config.spellLocations) ~= nil
    end

    -- Defer aplProto generation: do not parse rotationString here (PreDatabaseRegistration runs very
    -- early, before NAGStringParser/SchemaValidator/DataManager are enabled). aplProto is generated
    -- later by RotationManager during PrecompileAllRotations (migration step) or on first use (GetRotationWithProto).
    -- This keeps startup lightweight and ensures parsing runs after expansion data is loaded.

    -- Add the base rotation to class data (rotationString only; aplProto filled during precompile)
    defaults.class.rotations[specIndex][name] = CopyTable(config)

    -- Debug: Verify the rotation was saved correctly
    local savedRotation = defaults.class.rotations[specIndex][name]
    ns.DebugManager:debug(loggingContext, "AddRotationToDefaults: Saved rotation validation:")
    ns.DebugManager:debug(loggingContext,
        "  - rotationString: " .. tostring(savedRotation.rotationString and "present" or "missing"))
    ns.DebugManager:debug(loggingContext, "  - enabled: " .. tostring(savedRotation.enabled))
    ns.DebugManager:debug(loggingContext, "  - default: " .. tostring(savedRotation.default))
    ns.DebugManager:debug(loggingContext, "  - talentsString: " .. tostring(savedRotation.talentsString or "none"))
    ns.DebugManager:debug(loggingContext, "  - consumables: " .. tostring(savedRotation.consumables and "present" or "none"))
    ns.DebugManager:debug(loggingContext, "  - groups: " .. tostring(savedRotation.groups and #savedRotation.groups or "none"))
    ns.DebugManager:debug(loggingContext, "  - variables: " .. tostring(savedRotation.variables and #savedRotation.variables or "none"))
    ns.DebugManager:debug(loggingContext, "  - guide: " .. tostring(savedRotation.guide and "present" or "none"))

    -- If this is marked as default, set it as selected in char data (character-specific)
    if config.default and not defaults.char.selectedRotations[specIndex] then
        defaults.char.selectedRotations[specIndex] = name
        ns.DebugManager:info(loggingContext, "AddRotationToDefaults: Set as default rotation in char.selectedRotations")
    end
end

--- Initialize class defaults with standard structure
--- @param defaults? table The defaults table to initialize
--- @return table The initialized defaults table
function ns.InitializeClassDefaults(defaults)
    local classBase = UnitClassBase("player")
    -- Calculate the value once
    local shouldEnableStances = (classBase == "WARRIOR" or classBase == "DRUID" or
        classBase == "ROGUE" or classBase == "DEATHKNIGHT" or
        classBase == "PALADIN" or classBase == "PRIEST" or
        classBase == "HUNTER" or classBase == "MONK" or classBase == "WARLOCK")

    defaults = defaults or {}

    -- Class namespace: Class-specific data (shared across all characters of this class)
    defaults.class = defaults.class or {}
    defaults.class.rotations = defaults.class.rotations or {} -- All rotations (base + custom) in unified namespace
    defaults.class.version = defaults.class.version or nil
    defaults.class.migrations = defaults.class.migrations or {}
    defaults.class.specSpellLocations = defaults.class.specSpellLocations or {} -- Store spell locations by spec

    -- Profile namespace: REMOVED - migrated to class/char scope
    -- defaults.profile is no longer used - all data moved to class/char scopes

    -- Character namespace: Character-specific settings (per character)
    defaults.char = defaults.char or {}
    defaults.char.selectedRotations = defaults.char.selectedRotations or
        {} -- Which rotation is selected per spec (character-specific)
    defaults.char.settings = defaults.char.settings or
        {} -- Character-specific settings
    defaults.char.enableStances = defaults.char.enableStances ~= nil and defaults.char.enableStances or
        shouldEnableStances
    defaults.char.enableAutomaticRotationSwitching = defaults.char.enableAutomaticRotationSwitching ~= nil and
        defaults.char.enableAutomaticRotationSwitching or
        true -- Enable automatic rotation switching based on context

    -- Spell blacklist (character-specific)
    defaults.char.blacklistedSpells = defaults.char.blacklistedSpells or {} -- { [spellId] = true }

    -- Class assignments (character-specific) - for raid coordination
    defaults.char.assignmentToggles = defaults.char.assignmentToggles or {} -- { [assignmentId] = true/false }
    defaults.char.lastAssignmentId = defaults.char.lastAssignmentId or nil
    defaults.char.autoRestoreAssignmentsOnJoin = defaults.char.autoRestoreAssignmentsOnJoin or false
    defaults.char.ignoreAssignmentReminder = defaults.char.ignoreAssignmentReminder or false
    defaults.char.assignmentReminderLastShown = defaults.char.assignmentReminderLastShown or 0
    defaults.char.ticketReminderLastShown = defaults.char.ticketReminderLastShown or 0

    -- Autocast settings (these are used by multiple modules but defined in class options)
    defaults.char.enableAutocastOtherCooldowns = defaults.char.enableAutocastOtherCooldowns ~= nil and
        defaults.char.enableAutocastOtherCooldowns or false

    -- Enable unused major cooldowns checking in AutocastOtherCooldowns
    defaults.char.enableMajorCooldowns = defaults.char.enableMajorCooldowns ~= nil and
        defaults.char.enableMajorCooldowns or false

    -- Set smart default battle potion based on class/spec/expansion
    -- Note: We'll update this during OnInitialize when game state is available
    --defaults.char.defaultBattlePotion = defaults.char.defaultBattlePotion or nil

    defaults.char.autocastSettings = defaults.char.autocastSettings or {
        enableTrinketSlot1 = false,
        enableTrinketSlot2 = false,
        enableDefaultBattlePotion = false,
        defaultBattlePotionSpellLocation = ns.SPELL_POSITIONS.LEFT,
        blockDefaultBattlePotion = false,
        enableGloveSlot = false,
        enableBeltSlot = false,
        enableRacials = true,
    }

    -- Cooldown threshold settings for unused major cooldowns
    defaults.char.cooldownThresholds = defaults.char.cooldownThresholds or {
        survivalHealthPercent = 50,          -- Survival cooldowns only below this health %
        manaPercent = 60,                    -- Mana cooldowns only below this mana %
        dpsTargetHealthMinPercent = 20,      -- DPS/Explosive cooldowns only above this target health % (min)
        dpsTargetHealthMaxPercent = 100,     -- DPS/Explosive cooldowns only below this target health % (max)
    }

    -- Cooldown category overrides (similar to keybindOverrides)
    defaults.char.cooldownCategoryOverrides = defaults.char.cooldownCategoryOverrides or {
        Spell = {},  -- { [SpellID] = CooldownType }
    }

    -- Add class-specific settings to character namespace
    if classBase == "MAGE" then
        defaults.char.igniteMultiplier = 1.0
    elseif classBase == "PRIEST" then
        defaults.char.channelClipDelay = 0.1
    elseif classBase == "DEATHKNIGHT" then
        defaults.char.enableAMSWhen = true
    elseif classBase == "SHAMAN" then
        defaults.char.enableSnakeWhispers = true
    elseif classBase == "WARLOCK" then
        defaults.char.soulSwapExhaleWindow = 0
    end

    return defaults
end

---@class ClassBase : CoreModule, AceEvent-3.0
local ClassBase = {
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    optionsOrder = 1,
    childGroups = "tree",
    messageHandlers = {
        ["NAG_EXPANSION_DATA_LOADED"] = true, -- Expansion data loaded, can register rotation entities
        ["NAG_SPEC_UPDATED"] = true,
        -- Smart Rotation event-driven handlers (all use messages for consistency)
        ["NAG_MOB_COUNT_CHANGED"] = "OnMobCountChanged",
        ["NAG_COMBAT_STATE_CHANGED"] = "OnCombatStateChanged",
        ["NAG_GROUP_ROSTER_UPDATED"] = "OnGroupRosterUpdated",
        ["NAG_EQUIPMENT_CHANGED"] = "OnEquipmentChanged",
        ["NAG_ASSIGNMENT_CHANGED"] = "OnAssignmentChanged",
    },
    cleuHandlers = {
        SPELL_AURA_APPLIED = "HandleCLEURotationAura",
        SPELL_AURA_REFRESH = "HandleCLEURotationAura",
        SPELL_AURA_REMOVED = "HandleCLEURotationAura",
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        ["cleanspelllocations"] = {
            handler = "CleanupMalformedSpellLocations",
            help = "Clean up malformed spell location data",
            root = "nagdebug",
            category = "System"
        }
    }
}

--- Creates a new class module that inherits from CoreModule and ClassBase
--- @param name string The name of the module
--- @param classDefaults? table Optional class-specific defaults
--- @param mixins? table Optional additional functionality to mix in
--- @return ClassBase|AceModule|CoreModule? The created module
function NAG:CreateClassModule(name, classDefaults, mixins)
    -- Check if this is the player's class first
    local playerClass = select(2, UnitClass("player"))
    if name ~= playerClass then
        if self.debug then
            self:Debug("CreateClassModule: Skipping creation of %s module - player is %s", name,
                playerClass)
        end
        return nil
    end

    -- Check for WeakAura if specified in mixins
    if mixins and mixins.weakAuraName then
        local waLoaded = ns.IsWeakAuraLoaded(mixins.weakAuraName)

        -- This is a companion WeakAura - log its presence
        self:Info("Companion WeakAura " .. mixins.weakAuraName .. " is " .. (waLoaded and "loaded" or "not loaded"))
    end

    -- Ensure mixins exists
    mixins = mixins or {}

    -- Smart Rotation handlers are now part of ClassBase prototype (lines 307-315)
    -- They will be automatically inherited by all class modules

    -- Ensure classDefaults exists (fallback to base defaults if not provided)
    classDefaults = classDefaults or ns.InitializeClassDefaults()


    --- @type ClassBase|AceModule|CoreModule
    local module = self:CreateModule(name, classDefaults, mixins)

    -- Set class module flags
    module.className = name

    -- Set enabled state (will always be true since we checked class match above)
    module:SetEnabledState(true)

    -- Mix in ClassBase functionality
    for k, v in pairs(ClassBase) do
        module[k] = v
    end
    -- Cache the class module for fast access
    -- This eliminates the need for repeated GetModule(NAG.CLASS_FILENAME) calls throughout the codebase
    NAG.classModule = module
    self:Debug("CreateClassModule: Cached class module '" .. name .. "' for fast access")

    return module
end

--- Gets the cached class module for fast access
--- This eliminates the need for repeated GetModule(NAG.CLASS_FILENAME) calls throughout the codebase
--- @return ClassBase|AceModule|CoreModule|nil The cached class module, or nil if not available
function NAG:GetClassModule()
    -- Return cached class module if available
    if NAG.classModule then
        return NAG.classModule
    end

    -- Fallback to GetModule if cache is not available
    if NAG.CLASS_FILENAME then
        local module = NAG:GetModule(NAG.CLASS_FILENAME)
        if module then
            -- Cache it for future use
            NAG.classModule = module
        end
        return module
    end

    return nil
end

function ClassBase:ModuleEnable()
    RotationManager = NAG:GetModule("RotationManager")

    -- Initialize rotation switching cache flag
    self.needsRotationSwitching = false

    -- Initialize group state tracking for assignment reset detection
    self.wasInGroup = NAG:PlayerIsInGroup()

    -- RegisterSpellTracking is deferred to NAG_EXPANSION_DATA_LOADED - DataManager must be ready
    -- (RegisterTravelTime calls DataManager:Get for projectileSpeed)

    -- Clean up malformed spell location data to prevent errors
    -- This wipes old format data (LEFT = {id, id, id}) and lets the system rebuild with correct format
    if self:IsDatabaseReady() then
        self:CleanupMalformedSpellLocations()
    end

    -- Initialize rotation since database is ready at this point
    -- Gate on DataManager:IsDataReady() so we do not call EnsureRotationReady before
    -- DataWalker has finished; when not ready, NAG_EXPANSION_DATA_LOADED will run EnsureDefaultRotation.
    local rotationReady = false
    local DataManager = NAG:GetModule("DataManager", true)
    if DataManager and DataManager.IsDataReady and DataManager:IsDataReady() and RotationManager.EnsureRotationReady then
        local ok, resultOrErr = pcall(function()
            return RotationManager:EnsureRotationReady()
        end)
        if ok then
            rotationReady = resultOrErr and true or false
        else
            self:Warn("ModuleEnable: Failed to initialize rotation: " .. tostring(resultOrErr))
        end
    end

    if NAG.Frame then
        local frameEnabled = (DisplayManager.db.char.frameSettings and DisplayManager.db.char.frameSettings.enabled) ~= false
        if frameEnabled ~= false and rotationReady then
            NAG.Frame:Show()
        else
            NAG.Frame:Hide()
        end
    end

    -- Start or stop the rotation timer depending on readiness
    do
        if rotationReady then
            RotationManager:StartRotationTimer()
        else
            if RotationManager.StopRotationTimer then
                RotationManager:StopRotationTimer()
            end
        end
    end

    -- Apply class assignments to blacklist (raid coordination)
    if self:IsClassAssignmentsEnabled() then
        self:NormalizeAssignmentToggles()
        self:ApplyAssignmentToggles()
        self:EnsureAssignmentRestorePopup()
        if NAG:PlayerIsInGroup() then
            self:PromptAssignmentRestore()
        end
    end

    -- Update NAG's enabled state directly
    NAG.hasEnabledModule = true
    AceConfigRegistry:NotifyChange("NAG")

    -- Register all rotation entities after system is ready
    -- This ensures DataManager and ImportExport are available and data is loaded
    -- RegisterRotationEntities will be called from NAG_EXPANSION_DATA_LOADED handler
end

function ClassBase:ModuleDisable()
    if NAG.Frame then NAG.Frame:Hide() end

    -- Update NAG's enabled state directly
    NAG.hasEnabledModule = false
    AceConfigRegistry:NotifyChange("NAG")
end

--- Pre-database registration hook (called before database namespace registration)
--- Use this to modify self.defaults before the database is created
--- This is where class modules can inject their defaults modifications
--- @param self ClassBase
function ClassBase:PreDatabaseRegistration()
    self:Debug("PreDatabaseRegistration")
    -- ✅ MODIFY DEFAULTS: Called before database registration
    -- self.defaults is available and can be modified here

    -- Class modules can implement this method to add rotations
    -- Example: ns.AddRotationToDefaults(self.defaults, specIndex, name, config)
    if self.SetupClassDefaults then
        self:SetupClassDefaults()
    end

    -- Example: Class modules can modify defaults based on class-specific conditions
    -- self.defaults.global.someSetting = "classSpecificValue"
    -- self.defaults.class.specSpellLocations = self:GetClassSpecificSpellLocations()
end

function ClassBase:ModuleInitialize()
    self:Debug("classbase: ModuleInitializ2")
    StateManager = NAG:GetModule("StateManager")
    DataManager = NAG:GetModule("DataManager")
    RotationManager = NAG:GetModule("RotationManager")
    SpellbookManager = NAG:GetModule("SpellbookManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    TimerManager = NAG:GetModule("TimerManager")
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Register class-specific options
    DisplayManager:InitializeParentFrame()

    -- CRITICAL: Register defaults with Ace3 database system
    -- This ensures that defaults from Monk.lua (specSpellLocations, rotations, etc.) are available
    if self.defaults and self.db then
        self:Debug("ModuleInitialize: Registering defaults with Ace3 database")
        self:Debug("ModuleInitialize: Database namespaces available: " ..
            tostring(self.db.class ~= nil) .. " (class), " .. tostring(self.db.char ~= nil) .. " (char)")

        -- Update smart default battle potion based on current class/spec/expansion
        if self.defaults.char and not self.defaults.char.defaultBattlePotion then
            self:Debug("classbase: ModuleInitialize: Updating default battle potion")
            local smartPotion = ns.GetSmartDefaultBattlePotion()
            self:Debug("classbase: ModuleInitialize: smartPotion = " .. tostring(smartPotion))
            if smartPotion then
                self.defaults.char.defaultBattlePotion = smartPotion
                if self.debug then
                    self:Debug("ModuleInitialize: Updated default battle potion to %s",
                        tostring(smartPotion))
                end
            end
        end

        self.db:RegisterDefaults(self.defaults)
    else
        self:Warn("ModuleInitialize: Cannot register defaults - defaults or db not available")
        self:Debug("ModuleInitialize: self.defaults = " .. tostring(self.defaults))
        self:Debug("ModuleInitialize: self.db = " .. tostring(self.db))
    end

    -- Reconcile default rotations with saved rotations after defaults are registered
    -- This prevents base rotations from being treated as custom and keeps updated defaults in sync.
    self:ReconcileDefaultRotations()

    -- Register with ResetManager for rotation preservation during resets
    local ResetManager = NAG:GetModule("ResetManager")
    ResetManager:RegisterPreservationGroup("rotations", {
        name = L["preservationRotations"] or "Custom Rotations & APL Data",
        description = L["preservationRotationsDescription"] or "Preserve all custom rotations, spell locations, and APL data for this class",
        settings = {
            char = { "selectedRotations" },
            class = { "specSpellLocations", "rotations" }
        },
        alwaysPreserve = false
    }, self:GetName())

    self:Debug("ModuleInitialize: Completed initialization")
end

--- Reconcile addon default rotations with saved rotations
--- Ensures updated defaults are applied while preserving true user-modified rotations.
--- @param self ClassBase
function ClassBase:ReconcileDefaultRotations()
    if not self.defaults or not self.defaults.class or not self.defaults.class.rotations then
        return
    end
    if not self.db or not self.db.class or not self.db.class.rotations then
        return
    end

    local createdBase = 0
    local updatedBase = 0
    local rehomedCustom = 0

    local selectedRotations = self.db.char and self.db.char.selectedRotations or {}

    for specIndex, defaultRotations in pairs(self.defaults.class.rotations) do
        if type(defaultRotations) == "table" then
            local dbSpecRotations = self.db.class.rotations[specIndex]
            if not dbSpecRotations then
                dbSpecRotations = {}
                self.db.class.rotations[specIndex] = dbSpecRotations
            end

            for name, defaultConfig in pairs(defaultRotations) do
                if type(defaultConfig) == "table" then
                    local defaultCopy = CopyTable(defaultConfig)
                    defaultCopy.isBaseRotation = true
                    defaultCopy.userModified = false
                    defaultCopy.specIndex = specIndex
                    defaultCopy.name = name

                    local existing = dbSpecRotations[name]
                    if not existing then
                        self:SaveRotation(specIndex, name, defaultCopy)
                        createdBase = createdBase + 1
                    else
                        -- Backfill default metadata (e.g. prePull, macros) when existing was saved before these existed
                        local function mergeMissingDefaultFields(target, default)
                            if not target or not default then return false end
                            local changed = false
                            if (not target.prePull or type(target.prePull) ~= "table" or #target.prePull == 0) and
                                default.prePull and type(default.prePull) == "table" and #default.prePull > 0 then
                                target.prePull = CopyTable(default.prePull)
                                changed = true
                            end
                            if (not target.macros or type(target.macros) ~= "table" or #target.macros == 0) and
                                default.macros and type(default.macros) == "table" and #default.macros > 0 then
                                target.macros = CopyTable(default.macros)
                                changed = true
                            end
                            return changed
                        end

                        local rotationStringDiffers = defaultCopy.rotationString and existing.rotationString and
                            existing.rotationString ~= defaultCopy.rotationString
                        local hasUserFlags = existing.userModified == true or existing.isBaseRotation ~= true
                        local hasEditorSignature = existing.lastModifiedBy and tostring(existing.lastModifiedBy) ~= ""
                        local hasLastModifiedDelta = existing.lastModified and defaultCopy.lastModified and
                            tostring(existing.lastModified) ~= tostring(defaultCopy.lastModified)
                        local likelyUserModified = hasUserFlags or (rotationStringDiffers and (hasEditorSignature or hasLastModifiedDelta))

                        if likelyUserModified then
                            local sameAsDefault = defaultCopy.rotationString and
                                existing.rotationString == defaultCopy.rotationString
                            if sameAsDefault then
                                self:SaveRotation(specIndex, name, defaultCopy)
                                updatedBase = updatedBase + 1
                            elseif rotationStringDiffers then
                                local customName = self:GenerateUniqueRotationName(specIndex, name .. " (Custom)")
                                local customCopy = CopyTable(existing)
                                customCopy.name = customName
                                customCopy.isBaseRotation = false
                                customCopy.userModified = true
                                mergeMissingDefaultFields(customCopy, defaultCopy)
                                self:SaveRotation(specIndex, customName, customCopy)

                                local wasSelected = selectedRotations and selectedRotations[specIndex] == name
                                self:SaveRotation(specIndex, name, defaultCopy)
                                rehomedCustom = rehomedCustom + 1

                                if wasSelected then
                                    self:SetSelectedRotation(specIndex, customName)
                                end
                            else
                                -- No rotationString diff to preserve; keep default synced
                                self:SaveRotation(specIndex, name, defaultCopy)
                                updatedBase = updatedBase + 1
                            end
                        else
                            local shouldUpdate = false
                            if defaultCopy.rotationString and existing.rotationString ~= defaultCopy.rotationString then
                                shouldUpdate = true
                            end
                            if existing.isBaseRotation ~= true or existing.userModified ~= false then
                                shouldUpdate = true
                            end

                            if shouldUpdate then
                                if existing.enabled ~= nil then
                                    defaultCopy.enabled = existing.enabled
                                end
                                self:SaveRotation(specIndex, name, defaultCopy)
                                updatedBase = updatedBase + 1
                            else
                                -- Keep existing; backfill default fields that were added later (e.g. prePull)
                                if mergeMissingDefaultFields(existing, defaultCopy) then
                                    self:SaveRotation(specIndex, name, existing)
                                    updatedBase = updatedBase + 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if (createdBase + updatedBase + rehomedCustom) > 0 then
        self:Info("Reconciled base rotations: added=%d, updated=%d, preserved custom=%d",
            createdBase, updatedBase, rehomedCustom)
    end
end

--- Checks if the database is properly initialized
--- @param self ClassBase
--- @return boolean True if database is ready
function ClassBase:IsDatabaseReady()
    return self.db and self.db.class and self.db.char
end

--- Registers rotation entities with proper error handling
--- @param self ClassBase
function ClassBase:RegisterRotationEntities()
    local ImportExport = NAG:GetModule("ImportExport")
    local success, err = pcall(function()
        -- Register all rotations from unified namespace
        local allRotations = self.db.class.rotations
        if allRotations then
            for specIndex, rotations in pairs(allRotations) do
                for name, config in pairs(rotations) do
                    ImportExport:RegisterRotationEntities(config)
                end
            end
        end
    end)

    if not success then
        self:Warn("RegisterRotationEntities: Failed to register entities: " .. tostring(err))
    end
end

--- Called when expansion data is loaded
--- @param self ClassBase
function ClassBase:NAG_EXPANSION_DATA_LOADED(message)
    self:Info("ClassBase: NAG_EXPANSION_DATA_LOADED: Expansion data loaded, registering rotation entities")

    local profile = ns.Profile
    if profile and profile.Mem then
        profile:Mem("ClassBase:NAG_EXPANSION_DATA_LOADED:beforeRegisterRotationEntities", { minInterval = 0, force = true,
            extra = "class=" .. tostring(self.className or self:GetName()) })
    end

    -- Register spell tracking now that DataManager is ready (RegisterTravelTime needs DataManager:Get)
    self:RegisterSpellTracking()

    self:RegisterRotationEntities()

    if profile and profile.Mem then
        profile:Mem("ClassBase:NAG_EXPANSION_DATA_LOADED:afterRegisterRotationEntities", { minInterval = 0, force = true,
            extra = "class=" .. tostring(self.className or self:GetName()) })
    end
    -- Activate rotation now that DataManager is ready (deferred from ModuleEnable when data was not ready)
    self:EnsureDefaultRotation()
end

--- Registers class-specific spell tracking
--- This method should be overridden by class modules to register their specific spells
--- @param self ClassBase
function ClassBase:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    -- Example registration (should be overridden by class modules)
    -- SpellTrackingManager:RegisterPeriodicDamage({spellId}, {data})
    -- SpellTrackingManager:RegisterTravelTime({spellId}, {data})
    -- SpellTrackingManager:RegisterCastTracking({spellId}, {data})
end

--- Handles resetting the module's database based on reset type
--- @param self ClassBase
--- @param resetType string The type of reset being performed ("all", "global", "char", "class")
function ClassBase:ModuleResetDB(resetType)
    self:Debug("ModuleResetDB: Starting reset of type: " .. tostring(resetType))

    -- Only handle class-specific cleanup
    if resetType == "all" or resetType == "class" then
        -- Clear selected rotations (now in char scope)
        local selectedRotations = self.db.char.selectedRotations
        if selectedRotations then
            wipe(selectedRotations)
            self:SetSetting("char", "selectedRotations", selectedRotations)
            -- Re-register defaults to restore default values
            self.db:RegisterDefaults(self.defaults)
        end

        -- Clear rotation cache for this spec
        local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if currentSpecIndex then
            NAG:GetModule("RotationManager"):ClearRotationCache(currentSpecIndex)
        end

        -- Ensure we have a default rotation for current spec
        self:EnsureDefaultRotation()
    end
end

--- Ensures a default rotation is selected for the current spec
--- @param self ClassBase
function ClassBase:EnsureDefaultRotation()
    self:Info("EnsureDefaultRotation: Starting")
    -- Check if specialization is available using SpecCompat
    if not SpecCompat then
        self:Debug("EnsureDefaultRotation: SpecCompat not available")
        return
    end
    local specStatus = SpecCompat:GetSpecializationStatus()
    if not specStatus or not specStatus.available then
        self:Debug("EnsureDefaultRotation: Specialization not available")
        return
    end

    -- Use specIndex (1,2,3) as primary identifier from specStatus
    local specIndex = specStatus.specIndex

    if not specIndex then
        self:Debug("EnsureDefaultRotation: No specialization available")
        return
    end

    local currentSelection = self:GetSelectedRotation(specIndex)

    -- CRITICAL: If talents are available, check if current selection is Generic (specIndex 0) and switch away
    -- Generic should only be used when talents are NOT available (level < 10)
    local currentRotation = currentSelection and self:GetRotation(specIndex, currentSelection)
    local isGenericRotation = currentRotation and currentRotation.specIndex == 0
    if isGenericRotation then
        self:Info("EnsureDefaultRotation: Current rotation is Generic (specIndex 0) but talents are available - switching to spec rotation")
        self:SetSelectedRotation(specIndex, nil)
        currentSelection = nil
        currentRotation = nil
    end

    -- Validate current selection exists AND is enabled
    local isValid = false
    if currentSelection then
        -- Check if rotation exists and is enabled
        if not currentRotation then
            currentRotation = self:GetRotation(specIndex, currentSelection)
        end
        if currentRotation then
            -- Also check that it's not Generic when talents are available
            if currentRotation.specIndex == 0 then
                self:Debug("EnsureDefaultRotation: Current rotation is Generic but talents are available - invalid")
                isValid = false
            elseif currentRotation.enabled then
                isValid = true
            else
                self:Debug("EnsureDefaultRotation: Current rotation is disabled: " .. tostring(currentSelection) ..
                    " - Reason: " .. tostring(currentRotation.disabledReason or "unknown"))
            end
        else
            self:Debug("EnsureDefaultRotation: Current rotation not found: " .. tostring(currentSelection))
        end
    end

    -- If current selection is invalid, remove it and find a new one
    if not isValid then
        if currentSelection then
            self:Debug("EnsureDefaultRotation: Removing invalid rotation: " .. tostring(currentSelection))
            self:SetSelectedRotation(specIndex, nil)
        end

        -- Look for a default rotation in rotations (skip Generic when talents are available)
        local baseRotations = self:GetAllRotations(specIndex)
        for name, config in pairs(baseRotations) do
            -- Skip Generic rotations (specIndex 0) when talents are available
            if config.specIndex == 0 then
                self:Debug("EnsureDefaultRotation: Skipping Generic rotation '%s' (talents are available)", name)
            elseif config.enabled and config.default then
                self:Debug("EnsureDefaultRotation: Found default rotation: " .. tostring(name))
                -- Select this rotation
                self:SetSelectedRotation(specIndex, name)
                self:Debug("EnsureDefaultRotation: Selected default rotation: " .. tostring(name))
                break
            end
        end

        -- If still no selection, try to select first enabled rotation (skip Generic)
        if not self:GetSelectedRotation(specIndex) then
            for name, config in pairs(baseRotations) do
                -- Skip Generic rotations (specIndex 0) when talents are available
                if config.specIndex == 0 then
                    self:Debug("EnsureDefaultRotation: Skipping Generic rotation '%s' (talents are available)", name)
                elseif config.enabled then
                    self:Debug("EnsureDefaultRotation: No default found, selecting first enabled rotation: " ..
                        tostring(name))
                    self:SetSelectedRotation(specIndex, name)
                    break
                end
            end
        end

    else
        self:Debug("EnsureDefaultRotation: Current rotation is valid: " .. tostring(currentSelection))
    end

    -- CRITICAL: Check if we actually have a valid rotation for this spec
    local finalSelection = self:GetSelectedRotation(specIndex)
    if not finalSelection then
        self:Warn("EnsureDefaultRotation: No valid rotation available for spec " .. tostring(specIndex))
        -- Ensure no rotation function is cached and timer is stopped
        NAG.cachedRotationFunc = nil
        NAG:GetModule("RotationManager"):StopRotationTimer()
    end

    -- If we selected a rotation, initialize it
    if self:GetSelectedRotation(specIndex) then
        local success, err = pcall(function()
            NAG:GetModule("RotationManager"):EnsureRotationReady()
        end)
        if not success then
            self:Warn("EnsureDefaultRotation: Failed to initialize rotation: " .. tostring(err))
            -- Ensure cleanup on failure
            NAG.cachedRotationFunc = nil
            NAG:GetModule("RotationManager"):StopRotationTimer()
        end
    end

    -- Update rotation switching cache after ensuring default
    self:UpdateRotationSwitchingNeeded(specIndex)
end

function ClassBase:OnSpecChange()
    -- Use specIndex (1,2,3) as primary identifier - get from StateManager (single source of truth)
    local StateManager = NAG:GetModule("StateManager")
    local specIndex = StateManager and SpecCompat and SpecCompat:GetCurrentSpecIndex()

    if not specIndex then
        self:Debug("OnSpecChange: No specialization available")
        return
    end

    self:Debug("OnSpecChange: Ensuring default rotation for spec: " .. tostring(specIndex))

    -- Clear any previously cached rotation function and AST so the new spec activates cleanly
    NAG.cachedRotationFunc = nil
    NAG.cachedRotationAST = nil

    -- Stop any existing rotation timer to prevent errors during transition
    RotationManager:StopRotationTimer()

    -- Ensure we have a valid selection (validates/chooses default/first-enabled and initializes)
    local success, err = pcall(function()
        self:EnsureDefaultRotation()
        if StateManager.UpdateRotationState then
            StateManager:UpdateRotationState()
        end
    end)
    if not success then
        self:Warn("OnSpecChange: Failed to ensure default rotation: " .. tostring(err))
        -- Ensure cleanup on failure
        NAG.cachedRotationFunc = nil
        NAG.cachedRotationAST = nil
        RotationManager:StopRotationTimer()
    end

    -- Refresh spell location system AFTER rotation is updated
    self:RefreshSpellLocationSystem(specIndex)

    -- Update rotation switching cache after spec change
    self:UpdateRotationSwitchingNeeded(specIndex)

    AceConfigRegistry:NotifyChange("NAG")
end

--- Handle specialization changes by checking for default rotations
--- @param message string The message name
function ClassBase:NAG_SPEC_UPDATED(message)
    self:OnSpecChange()
end

function ClassBase:ResetRotation(specIndex, name)
    -- Verify we have a base rotation to reset to
    if not self:HasRotation(specIndex, name) then
        return false
    end

    -- Remove the custom rotation if it exists
    self:DeleteRotation(specIndex, name)

    -- Clear the specific rotation from cache
    NAG:GetModule("RotationManager"):ClearRotationCache(specIndex, name)

    -- Send message about rotation data change
    self:SendMessage("NAG_ROTATION_DATA_CHANGED", {
        specIndex = specIndex,
        rotationName = name,
        action = "reset"
    })

    return true
end

--- Gets all available rotations for a spec, combining base and custom rotations
--- @param self ClassBase
--- @param specIndex? number Optional specialization index (1,2,3). If not provided or 0, uses current spec
--- @param showAllSpecs? boolean Whether to show rotations from all specs
--- @return table<string, table> A table of rotation configurations keyed by name
--- @return table<string, string> A table of display names keyed by rotation name
function ClassBase:GetAvailableRotations(specIndex, showAllSpecs)
    -- If no specIndex provided or specIndex is 0, get current spec
    if not specIndex or specIndex == 0 then
        -- Check if specialization is available using SpecCompat
        if SpecCompat then
            local specStatus = SpecCompat:GetSpecializationStatus()
            if specStatus and specStatus.available then
                specIndex = specStatus.specIndex
            end
        end
        -- If still no specIndex, use 0 for spec-independent rotations
        specIndex = specIndex or 0
    end

    local rotations = {}
    local displayNames = {}

    -- Function to get spec name from our class DB
    local function getSpecName(sourceSpecID)
        -- Try to get spec name from base rotations first
        local baseRotations = self:GetAllRotations(sourceSpecID)
        for _, config in pairs(baseRotations) do
            if config.specName then
                return config.specName
            end
        end
        -- If no name found, return specIndex as string
        return tostring(sourceSpecID)
    end

    -- Check if talents are available (for filtering Generic rotations)
    local talentsAvailable = false
    if SpecCompat then
        local specStatus = SpecCompat:GetSpecializationStatus()
        talentsAvailable = specStatus and specStatus.available or false
    end

    -- Function to add rotations from a specific spec
    local function addRotationsFromSpec(sourceSpecID)
        -- Get all rotations using the unified API
        local allRotations = self:GetAllRotations(sourceSpecID)
        for name, config in pairs(allRotations) do
            -- Skip dev-only rotations when developer mode is off
            if config.devOnly and not (NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) then
                -- skip this rotation
            -- CRITICAL: Skip Generic rotations (specIndex 0) when talents are available
            elseif config.specIndex == 0 and talentsAvailable then
                -- Skip Generic rotation when talents are available
            else
            -- Backfill missing specIndex for legacy rotations (config is the live DB reference, so this persists)
            if not config.specIndex then
                config.specIndex = sourceSpecID
                self:Debug("GetAvailableRotations: Backfilled specIndex=%s for rotation '%s' (legacy data).", tostring(sourceSpecID), name)
            end

            rotations[name] = config
            local displayName = name
            if showAllSpecs and sourceSpecID > 0 then
                local specName = getSpecName(sourceSpecID)
                if specName then
                    displayName = displayName .. " (" .. specName .. ")"
                end
            end
            displayNames[name] = config.experimental and
                displayName .. " |cFFFF0000(Experimental)|r" or
                displayName
            end
        end
    end

    if showAllSpecs then
        -- Add spec-independent rotations first (specIndex 0) - but only if talents are NOT available
        if not talentsAvailable then
            addRotationsFromSpec(0)
        end

        -- Get all unique specIndexes from unified rotations namespace
        local specIndexes = {}

        -- Collect specIndexes from unified rotations
        local allRotations = self.db.class.rotations
        if allRotations then
            for sourceSpecIndex in pairs(allRotations) do
                if sourceSpecIndex > 0 then
                    specIndexes[sourceSpecIndex] = true
                end
            end
        end

        -- Add rotations for each specIndex found
        for sourceSpecIndex in pairs(specIndexes) do
            addRotationsFromSpec(sourceSpecIndex)
        end
    else
        -- Just add rotations for the current spec
        addRotationsFromSpec(specIndex)
    end

    return rotations, displayNames
end

-- Helper function to return empty rotation config
function ClassBase:GetEmptyRotation()
    local currentUser = StringUtil.GetBattleTagName(StringUtil.GetBattleTag())
    return {
        -- Core identification
        name = "",
        specIndex = 0,
        class = NAG.CLASS_FILENAME,
        rotationType = ns.ROTATION_TYPES.CUSTOM,

        -- Rotation data
        rotationString = "",

        -- Legacy APL structures
        prePull = {},
        macros = {},
        burstTrackers = {},
        resourceBar = {},

        -- Timeline and groups
        prePullActions = {},
        groups = {},
        variables = {},

        -- Tracking arrays
        spells = {},
        items = {},
        auras = {},
        runes = {},

        -- Consumables
        consumables = {},

        -- Item swap configuration
        enableItemSwap = false,
        itemSwap = {
            main = {},
            swaps = {}
        },

        -- Talents and Glyphs
        talentsString = nil,
        talents = {},
        glyphs = {major = {}, minor = {}},

        -- Smart switching
        customConditions = {},
        enableSmartSwitching = false,

        -- Metadata
        default = false,
        experimental = false,
        guide = nil,
        notes = nil,

        -- State
        enabled = true,
        userModified = false,

        -- Spell locations
        spellLocations = {},
        useCustomSpellLocations = false,

        -- Version tracking
        gameType = ns.Version:GetVersionInfo().gameType,
        addonVersion = WoWAPI.GetAddOnMetadata("NAG", "Version"),

        -- Author tracking
        authors = { currentUser },
        lastModifiedBy = currentUser,
        exportTime = time(),
        lastModified = time()
    }
end

--- Selects a rotation for a spec (SIMPLE SELECTION - no validation)
--- This method is for quickly switching between already-validated rotations
--- Use this for combat rotation changes, UI selection, etc.
---
--- For loading/importing new rotations, use the regular caching path via SetActiveRotation
---
--- @param self ClassBase
--- @param specIndex number The specialization index (1,2,3)
--- @param rotationName string The name of the rotation to select
--- @return boolean, string|nil
function ClassBase:SelectRotation(specIndex, rotationName)
    self:Debug("SelectRotation: Starting - specIndex: " .. tostring(specIndex) .. ", rotationName: " .. tostring(rotationName))
    if not specIndex or not rotationName then
        self:Debug("SelectRotation: Missing required parameters - specIndex: " ..
            tostring(specIndex) .. ", rotationName: " .. tostring(rotationName))
        return false, "Missing required parameters"
    end

    -- Validate specIndex (0 = Generic, 1-4 = spec tabs)
    if specIndex < 0 or specIndex > 4 then
        self:Debug("SelectRotation: Invalid specIndex: " .. tostring(specIndex))
        return false, "Invalid specialization index"
    end

    -- Ensure RotationManager reference is available (can be nil early in load order)
    RotationManager = RotationManager or NAG:GetModule("RotationManager", true)
    if not RotationManager then
        self:Warn("SelectRotation: RotationManager not available")
        return false, "RotationManager not available"
    end

    -- Check if rotation exists using unified API (cache the result)
    local rotation = self:GetRotation(specIndex, rotationName)
    if not rotation then
        self:Debug("SelectRotation: Rotation not found - specIndex: " ..
            tostring(specIndex) .. ", rotationName: " .. tostring(rotationName))
        return false, "Rotation not found"
    end

    -- CRITICAL: Prevent selecting Generic (specIndex 0) rotations when talents are available
    -- Generic should only be used when talents are NOT available (level < 10)
    if rotation.specIndex == 0 then
        if SpecCompat then
            local specStatus = SpecCompat:GetSpecializationStatus()
            if specStatus and specStatus.available then
                self:Warn("SelectRotation: Cannot select Generic rotation when talents are available (level >= 10)")
                return false, "Generic rotation can only be used when talents are not available (level < 10)"
            end
        end
    end

    -- If specIndex > 0, verify the spec exists
    if specIndex > 0 then
        local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if not currentSpecIndex then
            self:Debug("SelectRotation: No specialization selected")
            return false, "No specialization selected"
        end
        -- Cross-spec selection is allowed for browsing/copying, but must NOT attempt activation.
        if specIndex ~= currentSpecIndex then
            self:Debug("SelectRotation: Cross-spec selection (no activation) - currentSpecIndex: %s, specIndex: %s",
                tostring(currentSpecIndex), tostring(specIndex))

            -- Persist selection for the requested specIndex only (UI highlight / copying workflows)
            self:SetSelectedRotation(specIndex, rotationName)
            AceConfigRegistry:NotifyChange("NAG")
            self:SendMessage("NAG_ROTATION_SELECTION_CHANGED", {
                specIndex = specIndex,
                rotationName = rotationName,
                selectionOnly = true,
                dataChanged = false,
                crossSpec = true,
                activated = false,
            })
            return true
        end
    end

    -- Transactional activation: do NOT persist selection until activation succeeds.
    local previousSelection = self:GetSelectedRotation(specIndex)

    local success, err = RotationManager:SelectRotation(specIndex, rotationName)
    if not success then
        self:Warn("SelectRotation: Activation failed; preserving previous selection (prev=%s, requested=%s): %s",
            tostring(previousSelection), tostring(rotationName), tostring(err))
        return false, "Failed to activate rotation: " .. tostring(err)
    end

    -- Activation succeeded: now persist selection
    self:SetSelectedRotation(specIndex, rotationName)

    -- Selected rotation's spellLocations are now used directly by DisplayManager
    if rotation.spellLocations then
        self:Debug("SelectRotation: Rotation spellLocations ready for DisplayManager")
    end

    self:Debug("SelectRotation: Successfully activated rotation via RotationManager")

    -- Update rotation switching cache after selection
    self:UpdateRotationSwitchingNeeded(specIndex)

    -- Notify config change and send selection-state message with payload
    AceConfigRegistry:NotifyChange("NAG")
    self:SendMessage("NAG_ROTATION_SELECTION_CHANGED", {
        specIndex = specIndex,
        rotationName = rotationName,
        selectionOnly = true,  -- Just selection changed, not rotation data
        dataChanged = false,   -- No rotation data modification
        crossSpec = false,
        activated = true,
    })

    return true
end

function ClassBase:SaveUserRotation(specIndex, name, config)
    -- Use unified API internally
    return self:SaveRotation(specIndex, name, config)
end

--- Adds a rotation from an import string to defaults
--- @param self ClassBase
--- @param importString string The import string to parse and add
--- @param isUserModified? boolean Whether this is a user-modified rotation (defaults to false)
--- @return boolean success Whether the operation was successful
--- @return string? error The error message if unsuccessful
function ClassBase:AddRotationFromImportString(importString, isUserModified)
    if not importString then
        return false, "No import string provided"
    end

    -- Get the ImportExport module
    --- @type ImportExport|AceModule|CoreModule
    local ImportExport = NAG:GetModule("ImportExport")
    -- Import and deserialize the rotation
    local success, result = ImportExport:ImportRotation(importString)
    if not success then
        return false, "Failed to import rotation: " .. tostring(result)
    end

    -- Add import metadata
    result.imported = true
    result.importTime = time()
    result.userModified = isUserModified or false
    if isUserModified then
        result.isBaseRotation = false
    end

    -- Import/export uses specIndex only
    -- CRITICAL: Ensure specIndex is set - try to determine from current spec if missing
    local specIndex = result.specIndex
    if not specIndex or specIndex == 0 then
        if SpecCompat then
            local specStatus = SpecCompat:GetSpecializationStatus()
            if specStatus and specStatus.available then
                specIndex = specStatus.specIndex
                if specIndex then
                    result.specIndex = specIndex
                    self:Info("AddRotationFromImportString: Set specIndex=%s for imported rotation '%s' (from current spec)", tostring(specIndex), result.name)
                end
            end
        end
    end

    -- Ensure specIndex is set on the config before saving
    if not result.specIndex then
        result.specIndex = specIndex or 0
    end

    if isUserModified then
        -- For user-modified rotations, add to class DB (shared across profiles)
        if not specIndex or specIndex == 0 then
            return false, "Could not determine specIndex for imported rotation (no current spec available)"
        end

        -- Get the rotation tables using unified API
        local allRotations = self:GetAllRotations(specIndex)

        -- Generate unique name if needed
        local uniqueName = self:GenerateUniqueRotationName(specIndex, result.name)
        if uniqueName ~= result.name then
            result.name = uniqueName
            self:Info("Rotation name changed to avoid conflict: " .. uniqueName)
        end

        -- Save the rotation with the unique name
        success, err = self:SaveRotation(specIndex, result.name, result)
        if not success then
            return false, "Failed to save rotation: " .. tostring(err)
        end

        -- Conditionally activate only if specialization is available and matches the imported spec
        local canActivate = false
        if SpecCompat then
            local specStatus = SpecCompat:GetSpecializationStatus()
            canActivate = specStatus and specStatus.available and specStatus.specIndex == specIndex
        end
        if canActivate then
            success, err = self:SelectRotation(specIndex, result.name)
            if not success then
                return false, "Failed to select rotation: " .. tostring(err)
            end
        else
            self:Info(("Rotation '%s' imported for specIndex %d. Not activated (current spec: %s).")
                :format(result.name, specIndex, tostring(currentSpecIndex)))
        end
    else
        -- For standard rotations, add to defaults
        -- Import/export uses specIndex only
        local defaultSpecKey = specIndex or 0
        result.isBaseRotation = true
        ns.AddRotationToDefaults(self.defaults, defaultSpecKey, result)

        -- Re-register defaults to ensure they take effect
        self.db:RegisterDefaults(self.defaults)
    end

    -- Clear rotation cache for this spec using RotationManager
    -- Use specIndex for internal operations
    if specIndex then
        RotationManager:ClearRotationCache(specIndex)
    end

    -- Notify config change and refresh
    AceConfigRegistry:NotifyChange("NAG")
    self:SendMessage("NAG_ROTATION_DATA_CHANGED", {
        specIndex = specIndex,
        rotationName = result.name,
        action = "import"
    })

    return true
end

--- Exports a rotation configuration to a shareable string format
--- @param self ClassBase
--- @param specIndex number The specialization index (1,2,3)
--- @param rotationName string The name of the rotation to export
--- @return string|nil exportString The serialized rotation string, or nil if export failed
--- @return string|nil error Error message if export failed
function ClassBase:ExportRotation(specIndex, rotationName)
    self:Debug("ExportRotation: Starting export for specIndex: " ..
        tostring(specIndex) .. ", rotation: " .. tostring(rotationName))

    -- Get the ImportExport module
    --- @type ImportExport|AceModule|CoreModule
    local ImportExport = NAG:GetModule("ImportExport")
    -- Get the export string
    local exportString, err = ImportExport:ExportRotation(specIndex, rotationName)
    if not exportString then
        self:Error("Failed to export rotation: " .. tostring(err))
        return nil, err
    end

    -- Show export dialog
    StaticPopup_Show("NAG_EXPORT_ROTATION_STRING", nil, nil, exportString)

    self:Debug("ExportRotation: Export successful")
    return exportString
end

--- Imports a rotation from a serialized string
--- @param self ClassBase
--- @return boolean success Whether the import was successful
--- @return string|nil error Error message if import failed
function ClassBase:ImportRotation()
    -- Get the ImportExport module
    --- @type ImportExport|AceModule|CoreModule
    local ImportExport = NAG:GetModule("ImportExport")
    -- Show import dialog
    StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")

    return true
end

function ClassBase:CycleRotation(direction)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not specIndex then return end

    -- Get all available rotations
    local rotations, displayNames = self:GetAvailableRotations(specIndex)
    if not rotations or not next(rotations) then return end

    -- Get current rotation
    local selectedRotations = self.db.char.selectedRotations
    -- Ensure selectedRotations exists
    if not selectedRotations then
        selectedRotations = {}
        self.db.char.selectedRotations = selectedRotations
    end
    local currentRotation = selectedRotations[specIndex]

    -- Convert rotations to ordered list, but only include enabled ones
    local orderedRotations = {}
    for name, config in pairs(rotations) do
        if config.enabled then
            tinsert(orderedRotations, name)
        end
    end

    -- If no enabled rotations, return
    if #orderedRotations == 0 then
        self:Print("No enabled rotations found")
        return
    end

    -- Sort for consistent ordering
    sort(orderedRotations)

    -- Find current index
    local currentIndex = 1
    for i, name in ipairs(orderedRotations) do
        if name == currentRotation then
            currentIndex = i
            break
        end
    end

    -- Calculate next index
    local nextIndex
    if direction == "next" then
        nextIndex = currentIndex % #orderedRotations + 1
    else
        nextIndex = (currentIndex - 2) % #orderedRotations + 1
    end

    -- Select next rotation
    local nextRotation = orderedRotations[nextIndex]
    if nextRotation then
        self:SelectRotation(specIndex, nextRotation)
        -- Print rotation change message
        self:Print(format("Switched to rotation: %s", displayNames[nextRotation] or nextRotation))
    end
end

-- ============================== Options ==============================
--- Creates and returns the class options configuration group
--- @param self ClassBase
--- @return table Returns the class options configuration group
function ClassBase:GetOptions()
    self:Info("ClassBase: GetOptions: Starting")

    -- Compose the top-level group with flattened structure
    local options = {
        type = "group",
        name = L["class"] or "Class",
        order = self.optionsOrder or 100,
        childGroups = self.childGroups or "tree",
        args = {
            rotations = {
                type = "group",
                name = L["rotations"] or "Rotations",
                order = 10,
                inline = true,
                args = {
                    currentRotation = {
                        type = "description",
                        name = function()
                            local currentRotation = select(2, self:GetCurrentRotation())
                            return format("|cFFFFD100%s:|r %s",
                                L["currentRotation"] or "Current Rotation",
                                currentRotation or L["noRotationSelected"] or "No Rotation Selected"
                            )
                        end,
                        order = 1,
                        fontSize = "medium",
                        width = 4,
                    },
                    openRotationManager = {
                        type = "execute",
                        name = L["rotationManager"] or "Rotation Manager",
                        desc = L["rotationManagerDesc"] or
                            "Open the rotation manager to create, edit, or select rotations",
                        order = 2,
                        width = 1,
                        func = function()
                            --- @type RotationManager|AceModule|CoreModule
                            RotationManager:Toggle()
                        end,
                    },
                    importWeakAura = {
                        type = "execute",
                        name = L["importWeakAura"] or "Import WeakAura",
                        desc = L["importWeakAuraDesc"] or "Import the companion WeakAura for this class",
                        order = 3,
                        width = 1,
                        hidden = function()
                            -- Check if we have a WeakAura string for this class
                            local expansion = Version:GetExpansion()
                            local waStrings = ns.WeakAuras and ns.WeakAuras[expansion]
                            return not (waStrings and waStrings[self.className] and waStrings[self.className].string)
                        end,
                        func = function()
                            -- Get WeakAura string
                            local expansion = Version:GetExpansion()
                            local waStrings = ns.WeakAuras and ns.WeakAuras[expansion]
                            local waData = waStrings and waStrings[self.className]
                            if not waData or not waData.string then return end

                            -- Show import dialog
                            StaticPopupDialogs["NAG_IMPORT_WEAKAURA"] = {
                                text = format("%s\n\n%s",
                                    waData.name,
                                    waData.description or ""
                                ),
                                button1 = ACCEPT,
                                button2 = CANCEL,
                                hasEditBox = true,
                                editBoxWidth = 500,
                                maxLetters = 0,
                                enterClicksFirstButton = true,
                                OnShow = function(dialog)
                                    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                                    dialog:SetFrameLevel(200)
                                    local editBox = dialog and dialog:GetEditBox()
                                    if editBox then
                                        editBox:SetText(waData.string)
                                        editBox:HighlightText()
                                        editBox:SetFocus()
                                    end
                                end,
                                EditBoxOnEnterPressed = function(dialog)
                                    StaticPopup_OnClick(dialog:GetParent(), 1)
                                end,
                                EditBoxOnEscapePressed = function(editBox)
                                    editBox:GetParent():Hide()
                                end,
                                timeout = 0,
                                whileDead = true,
                                hideOnEscape = true,
                                preferredIndex = 3,
                            }
                            StaticPopup_Show("NAG_IMPORT_WEAKAURA")
                        end,
                    },
                },
            },
            generateMacros = self:CreateGenerateMacrosOption(),
            settings = {
                type = "group",
                inline = true,
                order = 15,
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                get = function(info) return self:GetSetting("char", info[#info]) end,
                set = function(info, value) self:SetSetting("char", info[#info], value) end,
                args = {
                    enableAutomaticRotationSwitching = {
                        type = "toggle",
                        order = 1,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    },
                    enableStances = (NAG.CLASS_FILENAME == "WARRIOR" or NAG.CLASS_FILENAME == "DRUID" or
                            NAG.CLASS_FILENAME == "ROGUE" or NAG.CLASS_FILENAME == "DEATHKNIGHT" or
                            NAG.CLASS_FILENAME == "PALADIN" or NAG.CLASS_FILENAME == "PRIEST" or
                            NAG.CLASS_FILENAME == "HUNTER" or NAG.CLASS_FILENAME == "MONK" or NAG.CLASS_FILENAME == "WARLOCK") and
                        {
                            type = "toggle",
                            order = 2,
                            name = function(info) return L[info[#info]] or info[#info] end,
                            desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        } or nil,
                    -- Add class-specific settings
                    channelClipDelay = (NAG.CLASS_FILENAME == "PRIEST") and {
                        type = "range",
                        order = 3,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        min = 0.1,
                        max = 0.4,
                        step = 0.01,
                    } or nil,
                    igniteMultiplier = (NAG.CLASS_FILENAME == "MAGE") and {
                        type = "range",
                        order = 4,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        min = 0.1,
                        max = 10,
                        step = 0.1,
                    } or nil,
                    enableAMSWhen = (NAG.CLASS_FILENAME == "DEATHKNIGHT") and {
                        type = "toggle",
                        order = 5,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    } or nil,
                    enableSnakeWhispers = (NAG.CLASS_FILENAME == "SHAMAN") and {
                        type = "toggle",
                        order = 6,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    } or nil,
                    soulSwapExhaleWindow = (NAG.CLASS_FILENAME == "WARLOCK") and {
                        type = "range",
                        order = 7,
                        name = function()
                            return L["soulSwapExhaleWindow"] or "Soul Swap Exhale Window (ms)"
                        end,
                        desc = function()
                            return L["soulSwapExhaleWindowDesc"] or
                                "How long, in milliseconds, before inhaled dots expire to exhale during multitarget encounters."
                        end,
                        min = 0,
                        max = 5000,
                        step = 50,
                        bigStep = 100,
                    } or nil,
                }
            },
            -- Range settings are automatically composed by TTDManager via OptionsManager
            -- No manual options definition needed - zero-boilerplate system integration
            cooldowns = {
                type = "group",
                name = L["cooldowns"] or "Cooldowns",
                desc = L["cooldownsDesc"] or "Configure cooldown autocast and usage thresholds",
                order = 10.5,
                args = {
                    autocastSettings = {
                        type = "group",
                        inline = true,
                        order = 1,
                        name = L["autocastSettings"] or "Suggestion Settings",
                        desc = L["autocastSettingsDesc"] or "Configure which abilities should be automatically suggested when available",
                        args = {
                            enableAutocastOtherCooldowns = {
                                type = "toggle",
                                order = 1,
                                name = function(info) return L[info[#info]] or info[#info] end,
                                desc = function(info)
                                    return L[info[#info] .. "Desc"] or
                                        "When enabled, autocast (including racials, trinkets, potions) is run every rotation update so suggestions appear even if the APL does not include AutocastOtherCooldowns.\n\n" ..
                                        "|cFFFFD100Note:|r APL-included AutocastOtherCooldowns() calls always execute regardless of this setting. TaskManager also runs an additional periodic cooldown check when this is on.\n\n" ..
                                        "Individual item enable toggles below still control which specific items (trinkets, potions, racials, etc.) are used."
                                end,
                                get = function(info) return self:GetSetting("char", info[#info]) end,
                                set = function(info, value) self:SetSetting("char", info[#info], value) end,
                            },
                            enableTrinketSlot1 = {
                                type = "toggle",
                                name = function(info) return L[info[#info]] or info[#info] end,
                                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                                order = 2,
                                get = function(info)
                                    return self:GetSetting("char", "autocastSettings." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "autocastSettings." .. info[#info], value)
                                end,
                            },
                            enableTrinketSlot2 = {
                                type = "toggle",
                                name = function(info) return L[info[#info]] or info[#info] end,
                                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                                order = 3,
                                get = function(info)
                                    return self:GetSetting("char", "autocastSettings." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "autocastSettings." .. info[#info], value)
                                end,
                            },
                            enableDefaultBattlePotion = {
                                type = "toggle",
                                name = function(info) return L[info[#info]] or info[#info] end,
                                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                                order = 4,
                                get = function(info)
                                    return self:GetSetting("char", "autocastSettings." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "autocastSettings." .. info[#info], value)
                                end,
                            },
                            enableGloveSlot = {
                                type = "toggle",
                                name = function(info) return L[info[#info]] or info[#info] end,
                                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                                order = 5,
                                get = function(info)
                                    return self:GetSetting("char", "autocastSettings." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "autocastSettings." .. info[#info], value)
                                end,
                            },
                            enableBeltSlot = {
                                type = "toggle",
                                name = function(info) return L[info[#info]] or info[#info] end,
                                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                                order = 6,
                                get = function(info)
                                    return self:GetSetting("char", "autocastSettings." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "autocastSettings." .. info[#info], value)
                                end,
                            },
                            enableRacials = {
                                type = "toggle",
                                name = function(info) return L[info[#info]] or info[#info] end,
                                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                                order = 7,
                                get = function(info)
                                    return self:GetSetting("char", "autocastSettings." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "autocastSettings." .. info[#info], value)
                                end,
                            },
                        },
                    },
                    defaultBattlePotion = {
                        type = "group",
                        order = 2,
                        name = L["defaultBattlePotion"] or "Default Battle Potion",
                        desc = L["defaultBattlePotionDesc"] or "Configure default battle potion",
                        inline = true,
                        args = {
                            -- Dropdown for preset potions
                            preset = {
                                type = "select",
                                order = 1,
                                name = L["presetPotion"] or "Preset Potion",
                                desc = L["presetPotionDesc"] or "Select from preset battle potions",
                                get = function(info)
                                    return self:GetSetting("char", "defaultBattlePotion")
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "defaultBattlePotion", value)
                                end,
                                values = function()
                                    local potions = {}

                                    -- Add preset potions
                                    local potionItems = DataManager.GetAllByFlags and
                                        DataManager:GetAllByFlags({ "potion" }, DataManager.EntityTypes.ITEM) or {}
                                    for id, item in pairs(potionItems) do
                                        local itemName = WoWAPI.GetItemInfo(id)
                                        if itemName then
                                            potions[id] = itemName
                                        end
                                    end

                                    -- Add current custom selection if it's not in presets
                                    local currentValue = self:GetSetting("char", "defaultBattlePotion")
                                    if currentValue and not potions[currentValue] then
                                        local customItemName = WoWAPI.GetItemInfo(currentValue)
                                        if customItemName then
                                            potions[currentValue] = customItemName .. " (Custom)"
                                        end
                                    end

                                    return potions
                                end
                            }, -- Edit box for custom item ID
                            custom = {
                                type = "input",
                                order = 2,
                                name = L["customItemId"] or "Custom Item ID",
                                desc = L["customItemIdDesc"] or "Enter a custom item ID for battle potion",
                                get = function(info)
                                    local currentValue = self:GetSetting("char", "defaultBattlePotion")
                                    if currentValue then
                                        return tostring(currentValue)
                                    end
                                    return ""
                                end,
                                set = function(info, value)
                                    local itemId = tonumber(value)
                                    if itemId and itemId > 0 then
                                        -- Validate the item exists
                                        local itemName = WoWAPI.GetItemInfo(itemId)
                                        if itemName then
                                            self:SetSetting("char", "defaultBattlePotion", itemId)
                                            self:Print(string.format("Set custom battle potion to: %s (ID: %d)", itemName, itemId))
                                        else
                                            self:Print(string.format("Invalid item ID: %d - item not found", itemId))
                                        end
                                    elseif value == "" then
                                        -- Clear the setting
                                        self:SetSetting("char", "defaultBattlePotion", nil)
                                        self:Print("Cleared custom battle potion")
                                    else
                                        self:Print("Please enter a valid numeric item ID")
                                    end
                                end,
                                validate = function(info, value)
                                    if value == "" then
                                        return true -- Allow empty to clear
                                    end
                                    local itemId = tonumber(value)
                                    if not itemId or itemId <= 0 then
                                        return L["invalidItemId"] or "Please enter a valid numeric item ID"
                                    end
                                    return true
                                end
                            },
                            -- Clear button
                            clear = {
                                type = "execute",
                                order = 3,
                                name = L["clearPotion"] or "Clear",
                                desc = L["clearPotionDesc"] or "Clear the current battle potion setting",
                                func = function()
                                    self:SetSetting("char", "defaultBattlePotion", nil)
                                    self:Print("Battle potion setting cleared")
                                end
                            },
                            defaultBattlePotionSpellLocation = {
                                type = "select",
                                order = 3.5,
                                name = L["defaultBattlePotionSpellLocation"] or "Battle Potion Spell Location",
                                desc = L["defaultBattlePotionSpellLocationDesc"] or "Choose where default battle potion suggestions appear.",
                                values = function()
                                    local values = self:GetSpellPositionValues() or {}
                                    values[ns.SPELL_POSITIONS.SEQUENCE] = nil
                                    return values
                                end,
                                get = function()
                                    local value = self:GetSetting("char", "autocastSettings.defaultBattlePotionSpellLocation")
                                    return value or ns.SPELL_POSITIONS.LEFT
                                end,
                                set = function(_, value)
                                    self:SetSetting("char", "autocastSettings.defaultBattlePotionSpellLocation", value)
                                end,
                            },
                            blockDefaultBattlePotion = {
                                type = "toggle",
                                order = 4,
                                name = L["blockDefaultBattlePotion"] or "Block Default Battle Potion",
                                desc = L["blockDefaultBattlePotionDesc"] or "When enabled, the default battle potion will never be suggested or shown in secondary slots (it is not in the spell blacklist dropdown).",
                                get = function(info)
                                    return self:GetSetting("char", "autocastSettings.blockDefaultBattlePotion")
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "autocastSettings.blockDefaultBattlePotion", value)
                                    AceConfigRegistry:NotifyChange("NAG")
                                end,
                            }
                        }
                    },
                    enableMajorCooldowns = {
                        type = "toggle",
                        order = 3,
                        name = L["enableMajorCooldowns"] or "Enable Major Cooldowns",
                        desc = L["enableMajorCooldownsDesc"] or "When enabled, unused major cooldowns from your rotation will be automatically suggested based on threshold settings. This controls the additional cooldown checking in AutocastOtherCooldowns.",
                        get = function(info) return self:GetSetting("char", info[#info]) end,
                        set = function(info, value)
                            self:SetSetting("char", info[#info], value)
                            AceConfigRegistry:NotifyChange("NAG")
                        end,
                    },
                    thresholds = {
                        type = "group",
                        order = 4,
                        name = L["cooldownThresholds"] or "Cooldown Thresholds",
                        desc = L["cooldownThresholdsDesc"] or "Control when unused major cooldowns are used based on health/mana/target conditions",
                        inline = true,
                        disabled = function() return not self:GetSetting("char", "enableMajorCooldowns") end,
                        args = {
                            survivalHealthPercent = {
                                type = "range",
                                name = L["survivalHealthPercent"] or "Survival Health %",
                                desc = L["survivalHealthPercentDesc"] or "Use Survival cooldowns only when health is below this percentage",
                                min = 0,
                                max = 100,
                                step = 5,
                                order = 1,
                                get = function(info)
                                    return self:GetSetting("char", "cooldownThresholds." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "cooldownThresholds." .. info[#info], value)
                                end,
                            },
                            manaPercent = {
                                type = "range",
                                name = L["manaPercent"] or "Mana %",
                                desc = L["manaPercentDesc"] or "Use Mana cooldowns only when mana is below this percentage",
                                min = 0,
                                max = 100,
                                step = 5,
                                order = 2,
                                get = function(info)
                                    return self:GetSetting("char", "cooldownThresholds." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "cooldownThresholds." .. info[#info], value)
                                end,
                            },
                            dpsTargetHealthMinPercent = {
                                type = "range",
                                name = L["dpsTargetHealthMinPercent"] or "DPS/Explosive Target Health Min %",
                                desc = L["dpsTargetHealthMinPercentDesc"] or "Use DPS/Explosive cooldowns only when target health is ABOVE this percentage (prevents waste on low-health targets)",
                                min = 0,
                                max = 100,
                                step = 5,
                                order = 3,
                                get = function(info)
                                    return self:GetSetting("char", "cooldownThresholds." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "cooldownThresholds." .. info[#info], value)
                                end,
                            },
                            dpsTargetHealthMaxPercent = {
                                type = "range",
                                name = L["dpsTargetHealthMaxPercent"] or "DPS/Explosive Target Health Max %",
                                desc = L["dpsTargetHealthMaxPercentDesc"] or "Use DPS/Explosive cooldowns only when target health is BELOW this percentage (prevents early aggro/threat issues)",
                                min = 0,
                                max = 100,
                                step = 5,
                                order = 4,
                                get = function(info)
                                    return self:GetSetting("char", "cooldownThresholds." .. info[#info])
                                end,
                                set = function(info, value)
                                    self:SetSetting("char", "cooldownThresholds." .. info[#info], value)
                                end,
                            },
                        },
                    },
                    detectedCooldowns = {
                        type = "group",
                        order = 5,
                        name = L["detectedCooldowns"] or "Detected Cooldowns",
                        desc = L["detectedCooldownsDesc"] or "Cooldowns detected from your rotation's schema",
                        inline = true,
                        disabled = function() return not self:GetSetting("char", "enableMajorCooldowns") end,
                        args = (function()
                            local args = {}
                            local orderCounter = 1
                            -- Use the same pattern as CreateSpellLocationOptions
                            local currentRotation = select(1, self:GetCurrentRotation())
                            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
                            local rotationName = currentRotation and currentRotation.name

                            if not specIndex then
                                args.noSpec = {
                                    type = "description",
                                    name = L["noRotationSelected"] or "No rotation selected. Cooldowns will be shown when a rotation is active.",
                                    order = 1,
                                }
                                return args
                            end

                            -- Build a set of unused cooldown spellIds (to determine inclusion state)
                            local unusedSet = {}
                            if currentRotation and rotationName and RotationManager.GetUnusedMajorCooldownSpellIds then
                                local unused = RotationManager:GetUnusedMajorCooldownSpellIds(specIndex, rotationName) or {}
                                for _, cd in ipairs(unused) do
                                    if cd and cd.spellId then
                                        unusedSet[cd.spellId] = true
                                    end
                                end
                            end

                            -- Fetch all major cooldowns for the player's class/spec via RotationManager helper
                            local allCooldowns = {}
                            if RotationManager and RotationManager.GetAllMajorCooldownSpellIds then
                                allCooldowns = RotationManager:GetAllMajorCooldownSpellIds() or {}
                            end

                            if not allCooldowns or #allCooldowns == 0 then
                                args.noCooldowns = {
                                    type = "description",
                                    name = L["noDetectedCooldowns"] or "No major cooldowns were detected for this class/spec.",
                                    order = 1,
                                }
                                return args
                            end

                            -- Get cooldown type names
                            local Types = NAG:GetModule("Types")
                            local CooldownType = Types and Types:GetType("CooldownType")
                            local cooldownTypeNames = {}
                            if CooldownType then
                                cooldownTypeNames[CooldownType.Unknown] = L["cooldownTypeUnknown"] or "Unknown"
                                cooldownTypeNames[CooldownType.Mana] = L["cooldownTypeMana"] or "Mana"
                                cooldownTypeNames[CooldownType.DPS] = L["cooldownTypeDPS"] or "DPS"
                                cooldownTypeNames[CooldownType.Explosive] = L["cooldownTypeExplosive"] or "Explosive"
                                cooldownTypeNames[CooldownType.Survival] = L["cooldownTypeSurvival"] or "Survival"
                            end

                            -- Build list of detected cooldowns (all), greying-out ones already included in rotation
                            local entries = {}
                            local overrides = self.db.char.cooldownCategoryOverrides
                            for _, record in ipairs(allCooldowns) do
                                local spellID = record.spellId
                                local cooldownType = record.cooldownType or 0

                                -- Check for override
                                local hasOverride = overrides and overrides.Spell and overrides.Spell[spellID]
                                if hasOverride then
                                    cooldownType = overrides.Spell[spellID]
                                end

                                local spellInfo = WoWAPI.GetSpellInfo(spellID)
                                local name = (spellInfo and spellInfo.name) or "Unknown"
                                local icon = spellInfo and spellInfo.iconID or nil

                                -- Included in rotation if NOT in unused set when a rotation is selected
                                local includedInRotation = currentRotation and rotationName and not unusedSet[spellID] or false

                                tinsert(entries, {
                                    name = name,
                                    id = spellID,
                                    cooldownType = cooldownType,
                                    icon = icon,
                                    hasOverride = hasOverride,
                                    included = includedInRotation,
                                    overrideOnly = false
                                })
                            end

                            -- Add any user overrides that aren't part of the detected list
                            local present = {}
                            for _, e in ipairs(entries) do
                                present[e.id] = true
                            end
                            if overrides and overrides.Spell then
                                for spellID, cat in pairs(overrides.Spell) do
                                    if not present[spellID] then
                                        local spellInfo = WoWAPI.GetSpellInfo(spellID)
                                        local name = (spellInfo and spellInfo.name) or tostring(spellID)
                                        local icon = spellInfo and spellInfo.iconID or nil
                                        tinsert(entries, {
                                            name = name,
                                            id = spellID,
                                            cooldownType = cat or 0,
                                            icon = icon,
                                            hasOverride = true,
                                            included = false,
                                            overrideOnly = true
                                        })
                                    end
                                end
                            end

                            sort(entries, function(a, b) return strlower(a.name) < strlower(b.name) end)

                            -- Build category values table once
                            local categoryValues = {}
                            do
                                if CooldownType then
                                    for key, value in pairs(CooldownType) do
                                        if type(value) == "number" then
                                            categoryValues[value] = cooldownTypeNames[value] or tostring(key)
                                        end
                                    end
                                end
                                -- Ensure Unknown exists at 0 if not defined in enum map
                                categoryValues[0] = categoryValues[0] or (L["cooldownTypeUnknown"] or "Unknown")
                            end

                            -- Display each cooldown as a row with: label, category dropdown, disable toggle
                            for i, e in ipairs(entries) do
                                local rowKey = "cooldown_" .. tostring(e.id)
                                local displayName = e.name
                                if e.included then
                                    displayName = "|cFF888888" .. displayName .. " (" .. (L["included"] or "Included") .. ")|r"
                                elseif e.hasOverride or e.overrideOnly then
                                    displayName = displayName .. " |cFF00FF00(" .. (L["override"] or "Override") .. ")|r"
                                end

                                -- Inline group per row
                                args[rowKey] = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = orderCounter,
                                    args = {
                                        label = {
                                            type = "description",
                                            name = format("|T%s:16:16:0:0|t %s", e.icon or "", displayName),
                                            order = 1,
                                            width = 1.45
                                        },
                                        category = {
                                            type = "select",
                                            name = L["cooldownCategory"] or "Cooldown Category",
                                            desc = L["cooldownCategoryDesc"] or "Select the cooldown category for this spell",
                                            order = 2,
                                            width = 0.8,
                                            values = categoryValues,
                                            get = function()
                                                local current = self:GetCooldownCategory(e.id)
                                                return current ~= nil and current or (e.cooldownType or 0)
                                            end,
                                            set = function(_, value)
                                                self:SetCooldownCategory(e.id, value)
                                                AceConfigRegistry:NotifyChange("NAG")
                                            end
                                        },
                                        disabledToggle = {
                                            type = "toggle",
                                            name = L["disable"] or "Disable",
                                            desc = L["disableDesc"] or "Disable this cooldown from suggestions",
                                            order = 3,
                                            width = 0.6,
                                            get = function()
                                                return self:IsCooldownDisabled(e.id)
                                            end,
                                            set = function(_, value)
                                                self:SetCooldownDisabled(e.id, value)
                                                AceConfigRegistry:NotifyChange("NAG")
                                            end
                                        }
                                    }
                                }
                                orderCounter = orderCounter + 1
                            end

                            return args
                        end)()
                    },
                    categoryOverrides = {
                        type = "group",
                        order = 6,
                        name = L["cooldownCategoryOverrides"] or "Cooldown Category Overrides",
                        desc = L["cooldownCategoryOverridesDesc"] or "Manually assign cooldown categories to spells, overriding schema defaults",
                        inline = true,
                        disabled = function() return not self:GetSetting("char", "enableMajorCooldowns") end,
                        args = {
                            info = {
                                type = "description",
                                name = L["cooldownCategoryOverridesInfo"] or "Assign spells to specific cooldown categories (Mana, DPS, Explosive, Survival) to control when they are automatically suggested based on your threshold settings.",
                                order = 0,
                                fontSize = "medium",
                            },
                            spellSelect = {
                                type = "select",
                                name = L["selectSpell"] or "Select Spell",
                                desc = L["selectSpellDesc"] or "Choose a spell from your spellbook",
                                order = 1,
                                width = "normal",
                                get = function()
                                    return self.selectedCooldownSpellID or ""
                                end,
                                set = function(_, value)
                                    self.selectedCooldownSpellID = value
                                end,
                                values = function()
                                    local spells = {}
                                    local seenNames = {}
                                    -- Use SpellbookManager for DRY and better performance
                                    local castableSpells = SpellbookManager:GetCastableSpells()
                                    for spellID, spellEntry in pairs(castableSpells) do
                                        local spellName = spellEntry.name
                                        -- Filter out Auto Attack
                                        if spellID ~= 6603 and spellID ~= 5019 and spellName then
                                            -- Only add first occurrence of each spell name (deduplicates ranks)
                                            if not seenNames[spellName] then
                                                seenNames[spellName] = true
                                                local icon = spellEntry.icon
                                                local iconTexture = icon and format("|T%s:16:16:0:0|t ", icon) or ""
                                                spells[spellID] = iconTexture .. spellName
                                            end
                                        end
                                    end
                                    return spells
                                end,
                                sorting = function()
                                    local entries = {}
                                    local seenNames = {}
                                    -- Use SpellbookManager for DRY and better performance
                                    local castableSpells = SpellbookManager:GetCastableSpells()
                                    for spellID, spellEntry in pairs(castableSpells) do
                                        local spellName = spellEntry.name
                                        -- Filter out Auto Attack
                                        if spellID ~= 6603 and spellID ~= 5019 and spellName then
                                            -- Only add first occurrence of each spell name (deduplicates ranks)
                                            if not seenNames[spellName] then
                                                seenNames[spellName] = true
                                                tinsert(entries, { id = spellID, name = spellName })
                                            end
                                        end
                                    end
                                    sort(entries, function(a, b) return strlower(a.name) < strlower(b.name) end)
                                    local order = {}
                                    for i, entry in ipairs(entries) do
                                        order[i] = entry.id
                                    end
                                    return order
                                end,
                            },
                            categorySelect = {
                                type = "select",
                                name = L["cooldownCategory"] or "Cooldown Category",
                                desc = L["cooldownCategoryDesc"] or "Select the cooldown category for this spell",
                                order = 2,
                                width = "normal",
                                get = function()
                                    return self.selectedCooldownCategory or 0
                                end,
                                set = function(_, value)
                                    self.selectedCooldownCategory = value
                                end,
                                values = function()
                                    local Types = NAG:GetModule("Types")
                                    local CooldownType = Types and Types:GetType("CooldownType")
                                    if CooldownType then
                                        return {
                                            [CooldownType.Unknown] = L["cooldownTypeUnknown"] or "Unknown",
                                            [CooldownType.Mana] = L["cooldownTypeMana"] or "Mana",
                                            [CooldownType.DPS] = L["cooldownTypeDPS"] or "DPS",
                                            [CooldownType.Explosive] = L["cooldownTypeExplosive"] or "Explosive",
                                            [CooldownType.Survival] = L["cooldownTypeSurvival"] or "Survival",
                                        }
                                    end
                                    return {}
                                end,
                            },
                            addOverride = {
                                type = "execute",
                                name = L["addCooldownOverride"] or "Add Override",
                                desc = L["addCooldownOverrideDesc"] or "Add the cooldown category override for the selected spell",
                                order = 3,
                                func = function()
                                    if self.selectedCooldownSpellID and self.selectedCooldownCategory then
                                        self:SetCooldownCategory(self.selectedCooldownSpellID, self.selectedCooldownCategory)
                                        local spellInfo = WoWAPI.GetSpellInfo(self.selectedCooldownSpellID)
                                        local spellName = spellInfo and spellInfo.name or tostring(self.selectedCooldownSpellID)
                                        self:Info(format("Added cooldown category override: %s -> %d", spellName, self.selectedCooldownCategory))
                                        self.selectedCooldownSpellID = nil
                                        self.selectedCooldownCategory = nil
                                        AceConfigRegistry:NotifyChange("NAG")
                                    else
                                        self:Error("Please select a spell and cooldown category")
                                    end
                                end,
                            },
                            deleteSelectedOverride = {
                                type = "execute",
                                name = L["deleteSelectedOverride"] or "Delete Selected Override",
                                desc = L["deleteSelectedOverrideDesc"] or "Remove the cooldown category override for the selected spell",
                                order = 4,
                                func = function()
                                    if self.selectedCooldownSpellID then
                                        self:SetCooldownCategory(self.selectedCooldownSpellID, nil)
                                        local spellInfo = WoWAPI.GetSpellInfo(self.selectedCooldownSpellID)
                                        local spellName = spellInfo and spellInfo.name or tostring(self.selectedCooldownSpellID)
                                        self:Info(format("Removed cooldown category override for: %s", spellName))
                                        self.selectedCooldownSpellID = nil
                                        self.selectedCooldownCategory = nil
                                        AceConfigRegistry:NotifyChange("NAG")
                                    else
                                        self:Error("Please select a spell to remove its override")
                                    end
                                end,
                            },
                            currentOverrides = {
                                type = "group",
                                name = L["currentCooldownOverrides"] or "Current Overrides",
                                order = 5,
                                inline = true,
                                args = (function()
                                    local args = {}
                                    local orderCounter = 1
                                    local overrides = self.db.char.cooldownCategoryOverrides

                                    if not overrides or not overrides.Spell or not next(overrides.Spell) then
                                        args.empty = {
                                            type = "description",
                                            name = L["noCooldownOverrides"] or "No cooldown category overrides set.",
                                            order = 1,
                                            width = "full",
                                        }
                                        return args
                                    end

                                    -- Build list of overrides
                                    local entries = {}
                                    for spellID, cooldownType in pairs(overrides.Spell) do
                                        local spellInfo = WoWAPI.GetSpellInfo(spellID)
                                        local name = spellInfo and spellInfo.name or "Unknown"
                                        local icon = spellInfo and spellInfo.iconID or nil
                                        tinsert(entries, { name = name, id = spellID, cooldownType = cooldownType, icon = icon })
                                    end
                                    sort(entries, function(a, b) return strlower(a.name) < strlower(b.name) end)

                                    -- Get cooldown type names
                                    local Types = NAG:GetModule("Types")
                                    local CooldownType = Types and Types:GetType("CooldownType")
                                    local cooldownTypeNames = {}
                                    if CooldownType then
                                        cooldownTypeNames[CooldownType.Unknown] = L["cooldownTypeUnknown"] or "Unknown"
                                        cooldownTypeNames[CooldownType.Mana] = L["cooldownTypeMana"] or "Mana"
                                        cooldownTypeNames[CooldownType.DPS] = L["cooldownTypeDPS"] or "DPS"
                                        cooldownTypeNames[CooldownType.Explosive] = L["cooldownTypeExplosive"] or "Explosive"
                                        cooldownTypeNames[CooldownType.Survival] = L["cooldownTypeSurvival"] or "Survival"
                                    end

                                    for i, e in ipairs(entries) do
                                        local rowKey = "spellRow_" .. tostring(e.id)
                                        local categoryName = cooldownTypeNames[e.cooldownType] or "Unknown"
                                        args[rowKey .. "_label"] = {
                                            type = "description",
                                            name = format("|T%s:16:16:0:0|t %s: %s", e.icon or "", e.name, categoryName),
                                            order = orderCounter,
                                            width = 1.9,
                                        }
                                        args[rowKey .. "_remove"] = {
                                            type = "execute",
                                            name = "",
                                            image = "Interface\\Buttons\\UI-GroupLoot-Pass-Up",
                                            imageWidth = 25,
                                            imageHeight = 25,
                                            order = orderCounter + 0.1,
                                            width = 0.1,
                                            func = function()
                                                self:SetCooldownCategory(e.id, nil)
                                                AceConfigRegistry:NotifyChange("NAG")
                                            end
                                        }
                                        orderCounter = orderCounter + 1
                                    end

                                    return args
                                end)()
                            },
                        },
                    },
                },
            },
            spellBlacklist = self:CreateSpellBlacklistOptions(),
            classAssignments = self:CreateClassAssignmentsOptions(),
            spellLocations = self:CreateSpellLocationOptions(),
            guide = self:CreateGuideOptions(),
            rotationInfo = self:CreateRotationInfoOptions(),
        }
    }
    self:Debug("GetOptions: Final options structure:")
    self:Debug("  Total args count: " .. self:CountTableKeys(options.args))
    self:Debug("  spellLocations exists: " .. tostring(options.args.spellLocations ~= nil))
    self:Debug("  guide exists: " .. tostring(options.args.guide ~= nil))
    self:Debug("  rotationInfo exists: " .. tostring(options.args.rotationInfo ~= nil))
    self:Debug("=== GetOptions END ===")
    return options
end

--- @class ClassBase
--- @field CreateGenerateMacrosOption fun(self: ClassBase): table|nil
--- @usage ClassBase:CreateGenerateMacrosOption()
function ClassBase:CreateGenerateMacrosOption()
    -- Get current rotation and its name
    local currentRotation = select(1, self:GetCurrentRotation())
    if not currentRotation or not currentRotation.macros or #currentRotation.macros == 0 then
        return nil
    end

    return {
        type = "execute",
        name = L["generateMacros"],
        order = 3,
        func = function()
            -- Get current rotation again in case it changed
            local currentRotation = select(1, self:GetCurrentRotation())
            if not currentRotation or not currentRotation.macros then return end

            for _, macro in ipairs(currentRotation.macros) do
                if not macro.name or not macro.body then break end
                local macroName = "NAG-" .. macro.name
                local macroIndex = GetMacroIndexByName(macroName)
                if macroIndex > 0 then
                    EditMacro(macroIndex, macroName, "INV_MISC_QUESTIONMARK", macro.body)
                else
                    CreateMacro(macroName, "INV_MISC_QUESTIONMARK", macro.body, nil)
                end
            end
        end
    }
end
--- Creates options for managing spell locations in the current rotation
--- @param self ClassBase
--- @return table Options table for spell locations
function ClassBase:CreateSpellLocationOptions()
    -- Early validation
    if not self:IsDatabaseReady() then
        return self:CreatePlaceholderOptions()
    end


    local currentRotation = select(1, self:GetCurrentRotation())
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()

    if not currentRotation or not specIndex then
        return self:CreateEmptyOptions()
    end

    -- Cache spell locations source data once to avoid repeated GetCurrentRotation() calls
    local useCustom = currentRotation and currentRotation.useCustomSpellLocations == true
    local source, sourceType, activeRotation
    if useCustom then
        source = currentRotation.spellLocations or {}
        sourceType = "rotation"
        activeRotation = currentRotation
    else
        source = specIndex and self.db.class.specSpellLocations[specIndex] or {}
        sourceType = "spec"
        activeRotation = nil
    end

    -- Create the main options structure with cached data
    local options = self:CreateSpellLocationOptionsStructure(currentRotation)

    -- Extract spells from rotation string
    local spellsByName = self:ExtractSpellsFromRotation(currentRotation)

    -- Add all spells to the options with cached source data
    self:AddSpellsToOptions(spellsByName, options, source, sourceType, specIndex, activeRotation)

    -- Add reset functionality
    self:AddResetToDefaultsOption(options, specIndex)

    return options
end

--- Creates placeholder options when database is not ready
--- @param self ClassBase
--- @return table Placeholder options
function ClassBase:CreatePlaceholderOptions()
    return {
        type = "group",
        name = L["spellLocations"] or "Spell Locations",
        desc = L["spellLocationsDesc"] or "Configure spell locations for the current rotation",
        order = 10,
        args = {
            placeholder = {
                type = "description",
                name = L["placeholder"] or "Database not ready yet. Please wait for addon initialization to complete.",
                order = 1
            }
        }
    }
end

--- Creates empty options when no rotation is available
--- @param self ClassBase
--- @return table Empty options structure
function ClassBase:CreateEmptyOptions()
    return {
        type = "group",
        name = L["spellLocations"] or "Spell Locations",
        order = 10,
        args = {}
    }
end

--- Creates the base spell location options structure
--- @param self ClassBase
--- @param currentRotation table Cached rotation data
--- @return table Base options structure
function ClassBase:CreateSpellLocationOptionsStructure(currentRotation)
    local args = {
        spellLocationMode = self:CreateSpellLocationModeToggle(currentRotation),
        spellLocationsInfo = self:CreateSpellLocationsInfo(currentRotation),
    }

    -- Show dropdowns when toggle is OFF (editing spec-wide defaults)
    -- Hide dropdowns when toggle is ON (use RotationEditor for rotation-specific)
    if not (currentRotation and currentRotation.useCustomSpellLocations) then
        args.spellLocationsGroup = {
            type = "group",
            name = L["specDefaultSpellLocations"] or "Spec Default Spell Locations",
            desc = L["specDefaultSpellLocationsDesc"] or "Default spell locations for all rotations of this spec",
            order = 2.2,
            inline = true,
            args = {}
        }
        args.additionalSpellLocationsGroup = {
            type = "group",
            name = L["additionalSpellLocations"] or "Additional Spell Locations",
            desc = L["additionalSpellLocationsDesc"] or "Additional castable spells from your spellbook",
            order = 2.3,
            inline = true,
            args = {}
        }
    else
        -- Show note directing to Rotation Editor when toggle is ON
        args.editorNote = {
            type = "description",
            name = "|cFFFFD100This rotation uses custom spell locations.|r\n\n" ..
                   "|cFF888888To edit rotation-specific spell locations, open:|r\n" ..
                   "|cFF00FF00Rotation Manager > Edit Rotation > Spell Locations tab|r",
            order = 2.2,
            fontSize = "medium"
        }
    end

    return {
        type = "group",
        name = L["spellLocations"] or "Spell Locations",
        order = 10,
        args = args
    }
end

--- Creates the spell location mode toggle option
--- @param self ClassBase
--- @param cachedRotation table Cached rotation data to avoid repeated GetCurrentRotation calls
--- @return table Toggle option
function ClassBase:CreateSpellLocationModeToggle(cachedRotation)
    return {
        type = "toggle",
        name = L["useCustomSpellLocations"] or "Use Rotation-Specific Spell Locations",
        desc = L["useCustomSpellLocationsDesc"] or
            "When enabled, use rotation-specific spell locations. When disabled, use default spec-based locations.",
        order = 1,
        get = function()
            -- Re-fetch current rotation to get latest value (don't use cached closure)
            local rotation = select(1, self:GetCurrentRotation())
            return rotation and rotation.useCustomSpellLocations == true
        end,
        set = function(_, value)
            self:HandleSpellLocationModeToggle(value)
        end
    }
end

--- Creates the spell locations info description
--- @param self ClassBase
--- @param cachedRotation table Cached rotation data to avoid repeated GetCurrentRotation calls
--- @return table Info description option
function ClassBase:CreateSpellLocationsInfo(cachedRotation)
    return {
        type = "description",
        name = function()
            if not cachedRotation then return "" end

            if cachedRotation.useCustomSpellLocations == true then
                return "|cFFFFD100This rotation uses custom spell locations.|r\n" ..
                       "|cFF888888Disable toggle to edit spec-wide defaults here, or use Rotation Editor to edit rotation-specific locations.|r"
            else
                return "|cFF00FF00Editing spec-wide default spell locations.|r\n" ..
                       "|cFFFFD100These settings apply to all rotations of this spec (unless they use custom locations).|r"
            end
        end,
        order = 2.1,
        fontSize = "medium"
    }
end

--- Handles the spell location mode toggle
--- @param self ClassBase
--- @param value boolean New toggle value
function ClassBase:HandleSpellLocationModeToggle(value)
    local currentRotation = select(1, self:GetCurrentRotation())
    if not currentRotation then return end

    -- Copy defaults when switching to custom mode
    if value and (not currentRotation.spellLocations or not next(currentRotation.spellLocations)) then
        self:CopySpecDefaultsToRotation(currentRotation)
    end

    currentRotation.useCustomSpellLocations = value

    -- Save immediately to ensure sync with RotationEditor
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if specIndex then
        self:SaveUserRotation(specIndex, currentRotation.name, currentRotation)
    end

    -- Refresh UI to show/hide dropdowns
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end

    self:RefreshSpellLocationSystem()
end

--- Copies spec defaults to rotation when switching to custom mode
--- @param self ClassBase
--- @param currentRotation table Current rotation
function ClassBase:CopySpecDefaultsToRotation(currentRotation)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not specIndex then return end

    local specDefaults = self.db.class.specSpellLocations and self.db.class.specSpellLocations[specIndex] or {}
    if next(specDefaults) then
        currentRotation.spellLocations = specDefaults
        currentRotation.userModified = true

        local success, err = self:SaveUserRotation(specIndex, currentRotation.name, currentRotation)
        if success then
            self:Info("Copied spec defaults to rotation for custom editing")
        else
            self:Warn("Failed to save copied spell locations: " .. tostring(err))
        end
    end
end

--- Refreshes the spell location system after mode changes
--- @param self ClassBase
--- @param specIndex number|nil Optional specIndex to use (uses current if not provided)
function ClassBase:RefreshSpellLocationSystem(specIndex)
    -- Use provided specIndex or get current one
    local targetSpecIndex = specIndex or SpecCompat and SpecCompat:GetCurrentSpecIndex()

    -- Deduplicate and clean up data
    local source, sourceType, activeRotation = self:GetActiveSpellLocationsSource()
    if source and next(source) then
        local dedupResult = SpellbookManager:DeduplicateSpellLocations(source)
        if dedupResult.duplicates and #dedupResult.duplicates > 0 then
            self:SaveDeduplicatedData(dedupResult.deduplicatedData, sourceType, targetSpecIndex, activeRotation)
        end
    end

    -- Rebuild cache with correct specIndex
    SpellbookManager:RebuildSpellPositionCache(true, targetSpecIndex)

    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

--- Saves deduplicated spell location data
--- @param self ClassBase
--- @param deduplicatedData table Cleaned data
--- @param sourceType string Data source type
--- @param specIndex number Specialization index (1,2,3)
--- @param activeRotation table|nil Active rotation
function ClassBase:SaveDeduplicatedData(deduplicatedData, sourceType, specIndex, activeRotation)
    if sourceType == "rotation" and activeRotation then
        activeRotation.spellLocations = deduplicatedData
        self:Info("Cleaned up duplicate spell entries in rotation.spellLocations")
    else
        self:SetSetting("class", "specSpellLocations." .. specIndex, deduplicatedData)
        self:Info("Cleaned up duplicate spell entries in specSpellLocations")
    end
end

--- Extracts spells from rotation string using APL patterns
--- @param self ClassBase
--- @param currentRotation table Current rotation
--- @return table Spells organized by name
function ClassBase:ExtractSpellsFromRotation(currentRotation)
    if not currentRotation.rotationString then
        return {}
    end
    if RotationManager.GetCachedSpellExtraction then
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        local rotationName = currentRotation.name
        if specIndex and rotationName then
            local cachedSpells = RotationManager:GetCachedSpellExtraction(specIndex, rotationName)
            if cachedSpells then
                self:Info("ExtractSpellsFromRotation: Using cached spell data from RotationManager")
                return cachedSpells
            end
        end
    end

    -- Fall back to local extraction if no cache available
    local spellsByName = {}
    -- Use RotationManager's extraction patterns and logic
    local spellPatterns = RotationManager:GetSpellExtractionPatterns()

    -- Scan rotation string for spell IDs using RotationManager's patterns
    for _, pattern in ipairs(spellPatterns) do
        for spellId in currentRotation.rotationString:gmatch(pattern) do
            spellId = tonumber(spellId)
            if spellId then
                local spellEntry = SpellbookManager:GetSpell(spellId)
                if spellEntry then
                    RotationManager:AddSpellToCollection(spellsByName, spellEntry, spellId)
                end
            end
        end
    end

    return spellsByName
end

--- Adds spells to the options structure
--- @param self ClassBase
--- @param spellsByName table Spells organized by name
--- @param options table Options structure to populate
--- @param source table Cached spell locations source
--- @param sourceType string Cached source type
--- @param specIndex number Cached spec index (1,2,3)
--- @param activeRotation table|nil Cached active rotation
function ClassBase:AddSpellsToOptions(spellsByName, options, source, sourceType, specIndex, activeRotation)
    -- Only add spell dropdowns if the dropdown groups exist
    if not options.args.spellLocationsGroup then
        return
    end

    -- Add rotation spells to main group
    for spellName, spellData in pairs(spellsByName) do
        local spellKey = "rotation_" .. spellName:gsub("[^%w]", "_")
        options.args.spellLocationsGroup.args[spellKey] = self:CreateSpellDropdown(spellName, spellData, source, sourceType, specIndex, activeRotation)
    end

    -- Add additional spellbook spells
    self:AddAdditionalSpellbookSpells(options, spellsByName, source, sourceType, specIndex, activeRotation)
end

--- Adds additional spellbook spells not in rotation
--- @param self ClassBase
--- @param options table Options structure
--- @param spellsByName table Spells already in rotation
--- @param source table Cached spell locations source
--- @param sourceType string Cached source type
--- @param specIndex number Cached spec index (1,2,3)
--- @param activeRotation table|nil Cached active rotation
function ClassBase:AddAdditionalSpellbookSpells(options, spellsByName, source, sourceType, specIndex, activeRotation)
    -- Only add if the additional group exists
    if not options.args.additionalSpellLocationsGroup then
        return
    end

    -- Force spellbook scan for fresh data
    if SpellbookManager.ForceScan then
        SpellbookManager:ForceScan()
    end

    local castableSpells = SpellbookManager:GetCastableSpells()
    if not castableSpells or not next(castableSpells) then
        return
    end

    -- Add spellbook spells not already in rotation
    for spellId, spellEntry in pairs(castableSpells) do
        local spellName = spellEntry.name
        if not spellsByName[spellName] then
            local spellKey = "spellbook_" .. spellId
            local spellData = {
                name = spellName,
                icon = spellEntry.icon,
                spellIds = { spellId }
            }
            options.args.additionalSpellLocationsGroup.args[spellKey] = self:CreateSpellDropdown(spellName, spellData, source, sourceType, specIndex, activeRotation)
        end
    end
end

--- Creates a spell dropdown option
--- @param self ClassBase
--- @param spellName string Spell name
--- @param spellData table Spell data
--- @param cachedSource table Cached spell locations source
--- @param cachedSourceType string Cached source type
--- @param cachedSpecIndex number Cached spec index (1,2,3)
--- @param cachedActiveRotation table|nil Cached active rotation
--- @return table Dropdown option
function ClassBase:CreateSpellDropdown(spellName, spellData, cachedSource, cachedSourceType, cachedSpecIndex, cachedActiveRotation)
    return {
        type = "select",
        name = function()
            local icon = spellData.icon and format("|T%s:16:16:0:0|t ", spellData.icon) or ""
            local displayName = spellName
            if #spellData.spellIds > 1 then
                displayName = displayName .. " (" .. #spellData.spellIds .. " " .. (L["spellRanks"] or "ranks") .. ")"
            end
            return icon .. displayName
        end,
        desc = L["spellLocationDesc"] or "Select the position for this spell",
        order = spellName:byte(1),
        values = function()
            return self:GetSpellPositionValues()
        end,
        get = function()
            return self:GetCurrentSpellPosition(spellData.spellIds, cachedSource)
        end,
        set = function(_, value)
            self:SetSpellPosition(spellData.spellIds, value)
        end
    }
end

--- Gets the available spell position values
--- @param self ClassBase
--- @return table Position values mapping
function ClassBase:GetSpellPositionValues()
    local presetText = L["preSet"] or "Pre-set"
    return {
        [""] = presetText,
        [ns.SPELL_POSITIONS.LEFT] = L["left"] or "Left",
        [ns.SPELL_POSITIONS.RIGHT] = L["right"] or "Right",
        [ns.SPELL_POSITIONS.ABOVE] = L["above"] or "Above",
        [ns.SPELL_POSITIONS.BELOW] = L["below"] or "Below",
        [ns.SPELL_POSITIONS.AOE] = L["aoe"] or "AoE",
        [ns.SPELL_POSITIONS.PRIMARY] = L["primary"] or "Primary",
        [ns.SPELL_POSITIONS.SEQUENCE] = L["sequence"] or "Sequence"
    }
end

--- Gets the current position for a set of spell IDs
--- @param self ClassBase
--- @param spellIds table Array of spell IDs
--- @param source table|nil Pre-fetched spell locations source (optional, fetches if not provided)
--- @return string Current position or empty string
function ClassBase:GetCurrentSpellPosition(spellIds, source)
    -- If source not provided, fetch it (for backward compatibility)
    if not source then
        source = select(1, self:GetActiveSpellLocationsSource())
    end

    for _, spellId in ipairs(spellIds) do
        local position = source[spellId]
        if position then
            return position
        end
    end

    return ""
end

--- Sets the position for a set of spell IDs
--- @param self ClassBase
--- @param spellIds table Array of spell IDs
--- @param value string New position value
function ClassBase:SetSpellPosition(spellIds, value)
    local source, sourceType, specIndex, activeRotation = self:GetActiveSpellLocationsSource()

    -- Update spell locations in the active source
    for _, spellId in ipairs(spellIds) do
        if value ~= "" then
            source[spellId] = value
        else
            source[spellId] = nil
        end
    end

    -- Save the changes
    if self:SaveSpellLocations(source, sourceType, specIndex, activeRotation) then
        self:RefreshSpellLocationUI()
    end
end

--- Gets the active spell locations source
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @return table source The spell locations source
--- @return string sourceType The type of source
--- @return number|nil specIndex The specialization index
--- @return table|nil activeRotation The active rotation table
function ClassBase:GetActiveSpellLocationsSource()
    local currentRotation = select(1, self:GetCurrentRotation())
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not specIndex then
        return {}, "spec", nil, nil
    end

    local useCustom = currentRotation and currentRotation.useCustomSpellLocations == true

    if useCustom then
        local source = currentRotation.spellLocations or {}
        return source, "rotation", specIndex, currentRotation
    else
        local source = specIndex and self.db.class.specSpellLocations[specIndex] or {}
        return source, "spec", specIndex, nil
    end
end

--- Saves spell locations to the appropriate source
--- @param self ClassBase
--- @param spellLocations table Spell locations to save
--- @param sourceType string Source type
--- @param specIndex number Specialization index (1,2,3)
--- @param activeRotation table|nil Active rotation
--- @return boolean Success status
function ClassBase:SaveSpellLocations(spellLocations, sourceType, specIndex, activeRotation)
    -- Clean up nil values
    local cleanedSpellLocations = {}
    for spellId, position in pairs(spellLocations) do
        if position ~= nil then
            cleanedSpellLocations[spellId] = position
        end
    end

    if sourceType == "rotation" then
        if not activeRotation then return false end

        activeRotation.spellLocations = cleanedSpellLocations
        activeRotation.userModified = true

        local success, err = self:SaveUserRotation(specIndex, activeRotation.name, activeRotation)
        if not success then
            self:Warn("Failed to save rotation after spell location change: " .. tostring(err))
            return false
        end
        return true
    else
        if not specIndex then return false end

        self:SetSetting("class", "specSpellLocations." .. specIndex, cleanedSpellLocations)
        return true
    end
end

--- Refreshes the spell location UI after changes
--- @param self ClassBase
function ClassBase:RefreshSpellLocationUI()
    if SpellbookManager and SpellbookManager.RequestSpellPositionCacheRebuild then
        SpellbookManager:RequestSpellPositionCacheRebuild(true, nil, "RefreshSpellLocationUI")
    else
        SpellbookManager:RebuildSpellPositionCache(true)
    end

    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end
end

--- Adds the reset to defaults option
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param options table Options structure
--- @param specIndex number Specialization index (1,2,3)
function ClassBase:AddResetToDefaultsOption(options, specIndex)
    options.args.resetToDefaults = {
        type = "execute",
        name = L["resetToDefaults"] or "Reset to Defaults",
        desc = L["resetSpellLocationsDesc"] or "Reset all spell locations to their default positions",
        order = 998,
        width = "default",
        func = function()
            self:HandleResetToDefaults(specIndex)
        end
    }
end

--- Handles resetting spell locations to defaults
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number Specialization index (1,2,3)
function ClassBase:HandleResetToDefaults(specIndex)
    local currentRotation, selectedName = self:GetCurrentRotation()
    if not currentRotation or not selectedName then
        return
    end

    if currentRotation.useCustomSpellLocations then
        -- Reset rotation-specific spell locations
        currentRotation.spellLocations = {}
        currentRotation.userModified = true

        local success, err = self:SaveUserRotation(specIndex, selectedName, currentRotation)
        if not success then
            self:Warn("Failed to save rotation after reset to defaults: " .. tostring(err))
        end
    else
        -- Reset class-wide spec spell locations
        if specIndex then
            self.db.class.specSpellLocations[specIndex] = {}
        end
    end

    -- Clear cache and refresh UI
    self:ClearRotationCache()
    self:RefreshFrames()

    self:Print(L["spellLocationsReset"] or "Spell locations have been reset to defaults.")
end

--- Creates spell blacklist options
--- @param self ClassBase
--- @return table Options for spell blacklist
function ClassBase:CreateSpellBlacklistOptions()
    local SpellbookManager = NAG:GetModule("SpellbookManager")
    local AceConfigRegistry = ns.AceConfigRegistry

    -- Build spell list for autocomplete (individual spells + flyouts so user can blacklist "Poison (all)")
    local spellList = {}
    local castableSpells = SpellbookManager:GetCastableSpells()
    for spellID, spellEntry in pairs(castableSpells) do
        if spellID ~= 6603 and spellID ~= 5019 then  -- Exclude Auto Attack
            local icon = spellEntry.icon
            local iconTexture = icon and format("|T%s:20:20:0:0|t ", icon) or ""
            tinsert(spellList, {
                name = spellEntry.name,
                value = spellID,
                type = "spell",
                displayText = iconTexture .. spellEntry.name
            })
        end
    end
    if SpellbookManager.GetFlyoutsForBlacklist then
        local flyoutList = SpellbookManager:GetFlyoutsForBlacklist()
        for _, entry in ipairs(flyoutList) do
            tinsert(spellList, {
                name = entry.name .. " (all)",
                value = entry.value,
                type = "flyout",
                displayText = entry.displayText
            })
        end
    end

    -- Sort spell list alphabetically by name
    sort(spellList, function(a, b) return strlower(a.name) < strlower(b.name) end)

    return {
        type = "group",
        name = L["spellBlacklist"] or "Spell Blacklist",
        desc = L["spellBlacklistDesc"] or "Prevent specific spells from being cast",
        order = 10.3,  -- Between spellLocations (10) and cooldowns (10.5)
        args = {
            description = {
                type = "description",
                name = L["spellBlacklistInfo"] or "Blacklisted spells will never be suggested, even if they appear in rotations. Useful for raid coordination (e.g., preventing Warriors from casting Sunder Armor when Rogues maintain Expose Armor).",
                order = 1,
                fontSize = "medium",
            },
            blockDefaultBattlePotion = {
                type = "toggle",
                name = L["blockDefaultBattlePotion"] or "Block Default Battle Potion",
                desc = L["blockDefaultBattlePotionDesc"] or "When enabled, the default battle potion will never be suggested or shown in secondary slots (it is not in the spell blacklist dropdown).",
                order = 2,
                get = function()
                    return self:GetSetting("char", "autocastSettings.blockDefaultBattlePotion")
                end,
                set = function(_, value)
                    self:SetSetting("char", "autocastSettings.blockDefaultBattlePotion", value)
                    AceConfigRegistry:NotifyChange("NAG")
                end,
            },
            addSpell = {
                type = "select",
                name = L["addSpellToBlacklist"] or "Add Spell",
                desc = L["addSpellToBlacklistDesc"] or "Select a spell from your spellbook to blacklist. Selection immediately adds the spell.",
                order = 3,
                width = "full",
                values = function()
                    local values = { [""] = "-- Select a spell --" }
                    for i, entry in ipairs(spellList) do
                        values[tostring(entry.value)] = entry.displayText
                    end
                    return values
                end,
                sorting = function()
                    local sorting = { "" }
                    for i, entry in ipairs(spellList) do
                        tinsert(sorting, tostring(entry.value))
                    end
                    return sorting
                end,
                get = function() return "" end,
                set = function(_, value)
                    if value ~= "" then
                        local spellID = tonumber(value)
                        if spellID then
                            NAG:BlacklistSpell(spellID)
                            AceConfigRegistry:NotifyChange("NAG")
                        end
                    end
                end,
            },
            blacklistedSpells = {
                type = "group",
                name = L["blacklistedSpells"] or "Blacklisted Spells",
                inline = true,
                order = 4,
                args = (function()
                    local args = {}
                    local blacklist = self.db.char.blacklistedSpells

                    if not blacklist or not next(blacklist) then
                        args.empty = {
                            type = "description",
                            name = L["noBlacklistedSpells"] or "No spells blacklisted.",
                            order = 1,
                        }
                        return args
                    end

                    local entries = {}
                    for spellID in pairs(blacklist) do
                        -- Check flyout first: flyout IDs can collide with spell IDs, so GetSpellInfo(flyoutID)
                        -- may return a different spell (e.g. Invisibility). We must display the flyout name/icon.
                        local flyoutName = SpellbookManager.GetFlyoutName and SpellbookManager:GetFlyoutName(spellID)
                        if flyoutName then
                            local flyoutIcon = SpellbookManager.GetFlyoutIcon and SpellbookManager:GetFlyoutIcon(spellID)
                            tinsert(entries, {
                                id = spellID,
                                name = flyoutName .. " (all)",
                                icon = flyoutIcon
                            })
                        else
                            local spellInfo = WoWAPI.GetSpellInfo(spellID)
                            if spellInfo then
                                tinsert(entries, {
                                    id = spellID,
                                    name = spellInfo.name,
                                    icon = spellInfo.iconID
                                })
                            end
                        end
                    end
                    sort(entries, function(a, b) return strlower(a.name) < strlower(b.name) end)

                    for i, entry in ipairs(entries) do
                        local key = "spell_" .. entry.id
                        args[key .. "_label"] = {
                            type = "description",
                            name = format("|T%s:20:20:0:0|t %s", entry.icon or "", entry.name),
                            order = i,
                            width = 1.8,
                        }
                        args[key .. "_remove"] = {
                            type = "execute",
                            name = "",
                            image = "Interface\\Buttons\\UI-GroupLoot-Pass-Up",
                            imageWidth = 25,
                            imageHeight = 25,
                            order = i + 0.1,
                            width = 0.2,
                            func = function()
                                NAG:UnblacklistSpell(entry.id)
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        }
                    end

                    return args
                end)()
            }
        }
    }
end

--- Creates class assignments options for raid coordination
--- @param self ClassBase
--- @return table Options for class assignments
function ClassBase:CreateClassAssignmentsOptions()
    local assignments = self.defaults.class.classAssignments or {}

    if not self:IsClassAssignmentsEnabled() then
        return {
            type = "group",
            name = L["classAssignments"] or "Class Assignments",
            desc = L["classAssignmentsDesc"] or "Configure which raid buffs/debuffs you are assigned to maintain",
            order = 10.2,
            args = {
                assignmentsUnavailable = {
                    type = "description",
                    name = L["assignmentsUnavailableMoP"] or
                        "Class assignments are only available in Classic expansions and are disabled in Mists of Pandaria.",
                    order = 1,
                    fontSize = "medium",
                }
            }
        }
    end

    -- Early check - return minimal structure if no assignments defined
    if not assignments or #assignments == 0 then
        return {
            type = "group",
            name = L["classAssignments"] or "Class Assignments",
            desc = L["classAssignmentsDesc"] or "Configure which raid buffs/debuffs you are assigned to maintain",
            order = 10.2,
            args = {
                noAssignments = {
                    type = "description",
                    name = L["noClassAssignments"] or "No class assignments are configured for this class.",
                    order = 1,
                    fontSize = "medium",
                }
            }
        }
    end

    local allowMultiple = self:AllowsMultipleAssignments()
    local descriptionText
    if allowMultiple then
        descriptionText = "Select one or more abilities you are assigned to maintain. Leave all unchecked if you are not assigned.\n\n" ..
            "|cFFFFD100By default, nothing is selected.|r Your selections are restored when you join a group.\n\n" ..
            "|cFFFF6600Note:|r These toggles only work if the spell is in your rotation APL. They modify the blacklist to prevent suggestions."
    else
        descriptionText = L["classAssignmentsInfo"] or
            "Select the single ability you are assigned to maintain. Leave it set to None if you are not assigned.\n\n" ..
            "|cFFFFD100By default, nothing is selected.|r You'll be prompted when you join a group if you previously selected an assignment.\n\n" ..
            "|cFFFF6600Note:|r These toggles only work if the spell is in your rotation APL. They modify the blacklist to prevent suggestions."
    end

    local args = {
        description = {
            type = "description",
            name = descriptionText,
            order = 1,
            fontSize = "medium",
        },
        spacer = {
            type = "header",
            name = "",
            order = 5,
        }
    }

    if allowMultiple then
        args.assignmentSelect = {
            type = "group",
            name = L["classAssignments"] or "Class Assignments",
            inline = true,
            order = 6,
            args = {}
        }

        local order = 1
        for _, assignment in ipairs(assignments) do
            local key = "assignment_" .. assignment.id
            args.assignmentSelect.args[key] = {
                type = "toggle",
                name = assignment.name,
                desc = assignment.description,
                order = order,
                width = "full",
                disabled = function()
                    return not NAG:PlayerIsInGroup()
                end,
                get = function()
                    return self.db.char.assignmentToggles
                        and self.db.char.assignmentToggles[assignment.id] == true
                        or false
                end,
                set = function(_, value)
                    self:ToggleAssignment(assignment.id, value)
                end
            }
            order = order + 1
        end

        args.clearAssignments = {
            type = "execute",
            name = L["assignmentNone"] or "None",
            order = 7,
            width = "full",
            disabled = function()
                return not NAG:PlayerIsInGroup()
            end,
            func = function()
                self:SetSelectedAssignmentId(nil)
            end
        }
    else
        args.assignmentSelect = {
            type = "select",
            name = L["assignmentSelect"] or "Assigned Ability",
            desc = L["assignmentSelectDesc"] or "Select the single ability you are assigned to maintain.",
            order = 6,
            width = "full",
            disabled = function()
                return not NAG:PlayerIsInGroup()
            end,
            values = function()
                local values = {
                    none = L["assignmentNone"] or "None",
                }
                for _, assignment in ipairs(assignments) do
                    values[assignment.id] = assignment.name
                end
                return values
            end,
            get = function()
                return self:GetSelectedAssignmentId() or "none"
            end,
            set = function(_, value)
                if value == "none" then
                    self:SetSelectedAssignmentId(nil)
                else
                    self:SetSelectedAssignmentId(value)
                end
            end,
        }
    end

    return {
        type = "group",
        name = L["classAssignments"] or "Class Assignments",
        desc = L["classAssignmentsDesc"] or "Configure which raid buffs/debuffs you are assigned to maintain",
        order = 10.2,
        args = args
    }
end

--- Creates the rotation guide options tab
--- @param self ClassBase
--- @return table Guide options structure
function ClassBase:CreateGuideOptions()
    -- Early validation
    if not self:IsDatabaseReady() then
        return {
            type = "group",
            name = L["rotationGuide"] or "Guide",
            desc = L["rotationGuideDesc"] or "Rotation guide and usage instructions",
            order = 11,
            args = {
                placeholder = {
                    type = "description",
                    name = L["placeholder"] or "Database not ready yet. Please wait for addon initialization to complete.",
                    order = 1
                }
            }
        }
    end

    local currentRotation = select(1, self:GetCurrentRotation())

    -- Check if rotation has a guide
    local hasGuide = currentRotation and currentRotation.guide and type(currentRotation.guide) == "string" and currentRotation.guide ~= ""

    return {
        type = "group",
        name = L["rotationGuide"] or "Guide",
        desc = L["rotationGuideDesc"] or "Rotation guide and usage instructions",
        order = 11,
        args = {
            guideContent = {
                type = "description",
                name = function()
                    if hasGuide then
                        return currentRotation.guide
                    else
                        return "|cFFFFD100" .. (L["noGuideAvailable"] or "No guide available for this rotation") .. "|r"
                    end
                end,
                order = 1,
                fontSize = "medium"
            }
        }
    }
end

--- Creates the rotation info options tab (displays consumables, talents, glyphs)
--- @param self ClassBase
--- @return table Rotation info options structure
function ClassBase:CreateRotationInfoOptions()
    -- Early validation
    if not self:IsDatabaseReady() then
        return {
            type = "group",
            name = L["rotationInfo"] or "Rotation Info",
            desc = L["rotationInfoDesc"] or "Rotation metadata and recommended setup",
            order = 12,
            args = {
                placeholder = {
                    type = "description",
                    name = L["placeholder"] or "Database not ready yet. Please wait for addon initialization to complete.",
                    order = 1
                }
            }
        }
    end

    local currentRotation = select(1, self:GetCurrentRotation())

    -- Check if rotation has any metadata
    local hasConsumables = currentRotation and currentRotation.consumables and type(currentRotation.consumables) == "table"
    local hasTalentsString = currentRotation and currentRotation.talentsString and type(currentRotation.talentsString) == "string"
    local hasAnyInfo = hasConsumables or hasTalentsString

    local args = {}

    if not hasAnyInfo then
        args.noInfo = {
            type = "description",
            name = "|cFFFFD100" .. (L["noRotationInfoAvailable"] or "No rotation info available for this rotation") .. "|r",
            order = 1,
            fontSize = "medium"
        }
    else
        local order = 1

        -- Consumables section
        if hasConsumables then
            args.consumablesHeader = {
                type = "header",
                name = L["consumables"] or "Consumables",
                order = order
            }
            order = order + 1

            args.consumablesContent = {
                type = "description",
                name = function()
                    local lines = {}
                    local consumables = currentRotation.consumables

                    if consumables.prepotId then
                        tinsert(lines, "|cFFFFD100Pre-Potion:|r " .. FormatWithIcon(consumables.prepotId, true))
                    end
                    if consumables.potId then
                        tinsert(lines, "|cFFFFD100Potion:|r " .. FormatWithIcon(consumables.potId, true))
                    end
                    if consumables.flaskId then
                        tinsert(lines, "|cFFFFD100Flask:|r " .. FormatWithIcon(consumables.flaskId, true))
                    end
                    if consumables.foodId then
                        tinsert(lines, "|cFFFFD100Food:|r " .. FormatWithIcon(consumables.foodId, true))
                    end

                    return #lines > 0 and concat(lines, "|n") or "No consumables specified"
                end,
                order = order,
                fontSize = "medium"
            }
            order = order + 1
        end

        -- Talents section
        if hasTalentsString then
            args.talentsHeader = {
                type = "header",
                name = L["talents"] or "Talents",
                order = order
            }
            order = order + 1

            args.talentsContent = {
                type = "description",
                name = function()
                    local lines = {}
                    local talentsString = currentRotation.talentsString

                    -- MoP talent system: each digit represents a tier choice (1-3 columns)
                    -- Use SpecCompat for talent info
                    local SpecCompat = NAG:GetModule("SpecCompat", true)
                    for i = 1, #talentsString do
                        local column = tonumber(talentsString:sub(i, i))
                        if column and column > 0 and column <= 3 then
                            -- Convert tier/column to talentIndex for MoP: talentIndex = (tier - 1) * 3 + column
                            local talentIndex = (i - 1) * 3 + column
                            local talentInfo = SpecCompat and SpecCompat:GetTalentInfo(nil, talentIndex, false, false, 1)

                            if talentInfo and talentInfo.name and talentInfo.icon then
                                tinsert(lines, format("|cFFFFD100Tier %d:|r |T%s:20:20|t %s", i, talentInfo.icon, talentInfo.name))
                            else
                                tinsert(lines, format("|cFFFFD100Tier %d:|r Column %d (talent data not available)", i, column))
                            end
                        end
                    end

                    if #lines == 0 then
                        return "|cFFFF8800Talent information not available (may require correct class/spec)|r"
                    end

                    return concat(lines, "|n")
                end,
                order = order,
                fontSize = "medium"
            }
            order = order + 1
        end

        -- Glyphs section removed - glyph API needs further research
    end

    return {
        type = "group",
        name = L["rotationInfo"] or "Rotation Info",
        desc = L["rotationInfoDesc"] or "Rotation metadata and recommended setup",
        order = 12,
        args = args
    }
end

--- Clears rotation cache using RotationManager
--- @param self ClassBase
function ClassBase:ClearRotationCache()
    RotationManager:ClearRotationCache()
end

--- Refreshes UI frames
--- @param self ClassBase
function ClassBase:RefreshFrames()
    if NAG.Frame and NAG.Frame.UpdateIcons then
        NAG.Frame:UpdateIcons(NAG.nextSpell, NAG.secondarySpells)
    end
end

--- Gets the default battle potion ID for the current spec
--- @param self ClassBase
--- @return number|nil The potion ID or nil if none is set
function ClassBase:GetDefaultBattlePotion()
    return self.db.char.defaultBattlePotion
end

-- Battle potion IDs by expansion and stat
local BATTLE_POTIONS = {
    classic = {
        MANA = nil,
        STRENGTH = 13442,  -- Mighty Rage Potion
        AGILITY = 31677,   -- Fel Mana Potion (placeholder - classic didn't have agi pots)
        INTELLECT = 17531, -- Greater Mana Potion
    },
    sod = {
        MANA = nil,
        STRENGTH = nil,  -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
        AGILITY = nil,   -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
        INTELLECT = nil, -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
    },
    tbc = {
        MANA = nil,
        STRENGTH = 22828,  -- Insane Strength Potion
        AGILITY = 22838,   -- Haste Potion (most agi users would use this)
        INTELLECT = 22832, -- Super Mana Potion
    },
    wrath = {
        MANA = nil,
        STRENGTH = 33721,  -- Endless Rage Potion
        AGILITY = 33721,   -- Endless Rage Potion (most agi users would use this)
        INTELLECT = 33726, -- Endless Mana Potion
    },
    cata = {
        MANA = nil,
        STRENGTH = 58146,  -- Golemblood Potion
        AGILITY = 58145,   -- Potion of the Tolvir
        INTELLECT = 58091, -- Volcanic Potion
    },
    mists = {
        MANA = 76098,      -- Master Mana Potion
        AGILITY = 76089,   -- Virmen's Bite
        STRENGTH = 76095,  -- Potion of Mogu Power
        INTELLECT = 76093, -- Potion of the Jade Serpent
    },
    retail = {
        MANA = nil,
        STRENGTH = 191914,  -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
        AGILITY = 191914,   -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
        INTELLECT = 191914, -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
    }
}

-- Primary stat mapping by class and spec
local CLASS_STAT_MAPPING = {
    WARRIOR = {
        [1] = "STRENGTH", -- Arms
        [2] = "STRENGTH", -- Fury
        [3] = "STRENGTH", -- Protection
        [5] = "STRENGTH", -- Initial/default
    },
    PALADIN = {
        [1] = "STRENGTH", -- Holy
        [2] = "STRENGTH", -- Protection
        [3] = "STRENGTH", -- Retribution
        [5] = "STRENGTH", -- Initial/default
    },
    HUNTER = {
        [1] = "AGILITY", -- Beast Mastery
        [2] = "AGILITY", -- Marksmanship
        [3] = "AGILITY", -- Survival
        [5] = "AGILITY", -- Initial/default
    },
    ROGUE = {
        [1] = "AGILITY", -- Assassination
        [2] = "AGILITY", -- Combat
        [3] = "AGILITY", -- Subtlety
        [5] = "AGILITY", -- Initial/default
    },
    PRIEST = {
        [1] = "INTELLECT", -- Discipline
        [2] = "INTELLECT", -- Holy
        [3] = "INTELLECT", -- Shadow
        [5] = "INTELLECT", -- Initial/default
    },
    DEATHKNIGHT = {
        [1] = "STRENGTH", -- Blood
        [2] = "STRENGTH", -- Frost
        [3] = "STRENGTH", -- Unholy
        [5] = "STRENGTH", -- Initial/default
    },
    SHAMAN = {
        [1] = "INTELLECT", -- Elemental
        [2] = "AGILITY",   -- Enhancement (special case, might want AGI)
        [3] = "INTELLECT", -- Restoration
        [5] = "INTELLECT", -- Initial/default
    },
    MAGE = {
        [1] = "INTELLECT", -- Arcane
        [2] = "INTELLECT", -- Fire
        [3] = "INTELLECT", -- Frost
        [5] = "INTELLECT", -- Initial/default
    },
    WARLOCK = {
        [1] = "INTELLECT", -- Affliction
        [2] = "INTELLECT", -- Demonology
        [3] = "INTELLECT", -- Destruction
        [5] = "INTELLECT", -- Initial/default
    },
    MONK = {
        [1] = "AGILITY",   -- Brewmaster
        [2] = "INTELLECT", -- Mistweaver
        [3] = "AGILITY",   -- Windwalker
        [5] = "AGILITY",   -- Initial/default
    },
    DRUID = {
        [1] = "INTELLECT", -- Balance
        [2] = "AGILITY",   -- Feral Combat
        [3] = "INTELLECT", -- Restoration
        [4] = "AGILITY",   -- Guardian
        [5] = "INTELLECT", -- Initial/default
    },
    DEMONHUNTER = {
        [1] = "AGILITY", -- Havoc
        [2] = "AGILITY", -- Vengeance
        [5] = "AGILITY", -- Initial/default
    },
    EVOKER = {
        [1] = "INTELLECT", -- Devastation
        [2] = "INTELLECT", -- Preservation
        [3] = "INTELLECT", -- Augmentation
        [5] = "INTELLECT", -- Initial/default
    },
}

--- Gets the smart default battle potion based on current class/spec/expansion
--- This function can be called during initialization to set smart defaults
--- @return number|nil The potion ID or nil if none is available
function ns.GetSmartDefaultBattlePotion()
    local classBase = UnitClassBase("player")
    if not classBase then
        return nil
    end

    -- Get current expansion potions
    local expansion = ns.Version:GetVersionInfo().expansion
    local expansionPotions = BATTLE_POTIONS[expansion]
    if not expansionPotions then
        return nil
    end

    -- Get class stat mapping
    local classMapping = CLASS_STAT_MAPPING[classBase]
    if not classMapping then
        return nil
    end

    -- Get current spec using cached data
    local currentSpec = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not currentSpec then
        currentSpec = 5 -- fallback to initial/default if no spec
    end

    -- Get primary stat for current spec, fallback to [5] if not found
    local primaryStat = classMapping[currentSpec] or classMapping[5]
    if not primaryStat then
        return nil
    end

    return expansionPotions[primaryStat]
end

-- ============================ ROTATION DATA APIs ============================


---
--- Gets a rotation configuration by its name (case-insensitive, across all specs)
--- @param rotationName string The name of the rotation to find
--- @return table|nil The rotation config if found, or nil if not found
function ClassBase:GetRotationByName(rotationName)
    if not rotationName or type(rotationName) ~= "string" then
        return nil
    end
    local rotations = self:GetAvailableRotations(nil, true)
    for name, config in pairs(rotations) do
        if strlower(name) == strlower(rotationName) then
            return config
        end
    end
    return nil
end

-- ============================ UNIFIED ROTATION API ============================
-- Unified API functions that consolidate rotations and customRotations namespaces
-- These functions use a single rotations namespace

--- Gets a rotation by spec index and name using the unified rotations namespace
--- This is the unified API that replaces GetBaseRotation/GetCustomRotation
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @param rotationName string The rotation name
--- @return table|nil The rotation config, or nil if not found
function ClassBase:GetRotation(specIndex, rotationName)
    if not specIndex or not rotationName then
        return nil
    end

    local rotations = self.db.class.rotations
    if not rotations then
        return nil
    end

    if rotations[specIndex] and rotations[specIndex][rotationName] then
        return rotations[specIndex][rotationName]
    end

    return nil
end

--- Gets all rotations for a spec using the unified rotations namespace
--- This is the new unified API that replaces GetAllBaseRotations/GetAllCustomRotations
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @return table Table of rotationName -> config mappings, or empty table
function ClassBase:GetAllRotations(specIndex)
    if not specIndex then
        return {}
    end

    local rotations = self.db.class.rotations
    if not rotations then
        return {}
    end

    if rotations[specIndex] then
        return rotations[specIndex]
    end

    return {}
end

--- Saves a rotation using the unified rotations namespace
--- This is the new unified API that replaces SetCustomRotation
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @param rotationName string The rotation name
--- @param config table The rotation configuration
--- @return boolean True if successful, false otherwise
function ClassBase:SaveRotation(specIndex, rotationName, config)
    self:Debug("=== SaveRotation CALLED ===")
    self:Debug("SaveRotation: specIndex = " .. tostring(specIndex))
    self:Debug("SaveRotation: rotationName = " .. tostring(rotationName))
    self:Debug("SaveRotation: config = " .. tostring(config))

    if not config or type(config) ~= "table" then
        self:Warn("SaveRotation: Invalid config provided")
        return false
    end

    self:Debug("SaveRotation: config.useCustomSpellLocations = " .. tostring(config.useCustomSpellLocations))
    self:Debug("SaveRotation: config.spellLocations = " .. tostring(config.spellLocations))
    self:Debug("SaveRotation: config.spellLocations has " ..
        (config.spellLocations and self:CountTableKeys(config.spellLocations) or "nil") .. " entries")

    -- Create a copy to avoid mutating the input object
    local configCopy = CopyTable(config)

    -- Set aplProto version when saving
    if configCopy.aplProto then
        configCopy.aplProtoVersion = ns.APL_PROTO_VERSION or 1
    end

    -- Ensure aplProto has type ROTATION when it has rotation-like structure (fixes "Emitter requires a rotation AST node"
    -- when saved config has aplProto without .type, e.g. from older format or visual editor)
    local function ensureAplProtoRotationType(aplProto)
        if not aplProto or not ns.ASTCore then return end
        if aplProto.type == ns.ASTCore.NodeType.ROTATION then return end
        if (aplProto.priority_list and #aplProto.priority_list > 0) or (aplProto.groups and #aplProto.groups > 0) then
            aplProto.type = ns.ASTCore.NodeType.ROTATION
        end
    end

    -- CONDITIONAL SYNC LOGIC BASED ON EDIT SOURCE
    local lastEditSource = configCopy._lastEditSource

    if lastEditSource == "rotationString" then
        -- Text editor: Always sync aplProto from rotationString
        if configCopy.rotationString then
            local conversionService = NAG:GetModule("RotationConversionService", true)
            if conversionService then
                local protoAST, diagnostics = conversionService:ParseToProtoAST(
                    configCopy.rotationString,
                    { useCache = true, validate = false }
                )
                if protoAST then
                    configCopy.aplProto = protoAST
                    self:Debug("SaveRotation: Regenerated aplProto from rotationString (edit source: rotationString)")
                end
            end
        end

        -- Also sync groups and variables from strings to AST (same pattern as rotationString → aplProto)
        local NAGStringParser = NAG:GetModule("NAGStringParser", true)
        local ASTCore = ns.ASTCore
        local ASTAction = ns.ASTAction

        if NAGStringParser and ASTCore and configCopy.aplProto then
            -- Initialize groups and value_variables arrays if missing
            if not configCopy.aplProto.groups then
                configCopy.aplProto.groups = {}
            end
            if not configCopy.aplProto.value_variables then
                configCopy.aplProto.value_variables = {}
            end

            -- Parse groups from strings to AST
            if configCopy.groups and #configCopy.groups > 0 then
                configCopy.aplProto.groups = {}
                for i, group in ipairs(configCopy.groups) do
                    local protoGroup = {
                        type = ASTCore.NodeType.GROUP,
                        name = group.name or "",
                        description = nil,
                        hide = false,
                        actions = {},
                        variables = {}
                    }

                    -- Parse each action string to AST
                    for j, actionString in ipairs(group.actions or {}) do
                        if actionString and actionString ~= "" then
                            -- Use ParseClause to support conditions, NAG:Hidden(), and notes
                            local clauseResult = NAGStringParser:ParseClause(actionString, nil, nil)
                            if clauseResult and clauseResult.action then
                                -- Set condition on action if present
                                if clauseResult.condition and ASTAction then
                                    ASTAction.SetCondition(clauseResult.action, clauseResult.condition)
                                end

                                tinsert(protoGroup.actions, {
                                    type = ASTCore.NodeType.LIST_ITEM,
                                    hide = clauseResult.hidden or false,  -- Support NAG:Hidden()
                                    notes = clauseResult.notes or nil,     -- Support notes from comments
                                    action = clauseResult.action,
                                    -- condition is on action.condition, not here (proto structure)
                                })
                            else
                                self:Warn("SaveRotation: Failed to parse group %d action %d (edit source: rotationString)", i, j)
                            end
                        end
                    end

                    tinsert(configCopy.aplProto.groups, protoGroup)
                end
                self:Debug("SaveRotation: Parsed groups from strings to aplProto.groups (edit source: rotationString)")
            end

            -- Parse variables from strings to AST
            if configCopy.variables and #configCopy.variables > 0 then
                configCopy.aplProto.value_variables = {}
                for i, variable in ipairs(configCopy.variables) do
                    local valueAST = nil
                    if variable.value and variable.value ~= "" then
                        -- Use ParseClause to handle value-only parsing (automatically routes to ParseValue/ParseCondition)
                        local clauseResult = NAGStringParser:ParseClause(variable.value, nil, nil)
                        if clauseResult then
                            -- Extract value from clause result (could be in value or condition field)
                            valueAST = clauseResult.value or clauseResult.condition
                        end
                    end

                    -- Fallback to empty constant if parsing fails
                    if not valueAST then
                        self:Warn("SaveRotation: Failed to parse variable %d value (edit source: rotationString), using empty constant", i)
                        local ASTValue = ns.ASTValue
                        if ASTValue then
                            valueAST = ASTValue.CreateConst("")
                        end
                    end

                    tinsert(configCopy.aplProto.value_variables, {
                        name = variable.name or "",
                        hide = false,
                        value = valueAST
                    })
                end
                self:Debug("SaveRotation: Parsed variables from strings to aplProto.value_variables (edit source: rotationString)")
            end
        end
    elseif lastEditSource == "aplProto" then
        -- Visual editor: When USE_SYNC_ROTATION_STRING=false, allow aplProto to be saved (for testing)
        -- The aplProto will be regenerated from rotationString on next load/precompile
        if not ns.USE_SYNC_ROTATION_STRING then
            -- rotationString is source of truth, but we allow aplProto to be saved for testing
            -- Only regenerate rotationString if missing (required for execution)
            if not configCopy.rotationString then
                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                if ASTSchemaEmitter and configCopy.aplProto then
                    ensureAplProtoRotationType(configCopy.aplProto)
                    local rotationString, err = ASTSchemaEmitter.EmitRotationString(configCopy.aplProto)
                    if rotationString then
                        configCopy.rotationString = rotationString
                        self:Warn("SaveRotation: Regenerated rotationString from aplProto (required for execution, but may be out of sync)")
                    else
                        self:Error("SaveRotation: rotationString missing and failed to regenerate from aplProto - rotation will not execute")
                    end
                else
                    self:Error("SaveRotation: rotationString missing and no aplProto to regenerate from - rotation will not execute")
                end
            else
                self:Debug("SaveRotation: Allowing aplProto to be saved (for testing), will regenerate from rotationString on load (USE_SYNC_ROTATION_STRING=false)")
            end
        else
            -- USE_SYNC_ROTATION_STRING=true: Auto-sync mode
            -- Only regenerate rotationString if missing (required for execution)
            if not configCopy.rotationString then
                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                if ASTSchemaEmitter and configCopy.aplProto then
                    ensureAplProtoRotationType(configCopy.aplProto)
                    local rotationString, err = ASTSchemaEmitter.EmitRotationString(configCopy.aplProto)
                    if rotationString then
                        configCopy.rotationString = rotationString
                        self:Warn("SaveRotation: Regenerated rotationString from aplProto (required for execution, but may be out of sync)")
                    else
                        self:Error("SaveRotation: rotationString missing and failed to regenerate from aplProto - rotation will not execute")
                    end
                else
                    self:Error("SaveRotation: rotationString missing and no aplProto to regenerate from - rotation will not execute")
                end
            else
                self:Debug("SaveRotation: Skipping rotationString sync (edit source: aplProto, USE_SYNC_ROTATION_STRING=true)")
            end
        end

        -- Also sync groups and variables from AST to strings (respect USE_SYNC_ROTATION_STRING toggle)
        local syncRotationString = ns.USE_SYNC_ROTATION_STRING
        local ASTSchemaEmitter = ns.ASTSchemaEmitter

        if ASTSchemaEmitter and configCopy.aplProto then
            -- Sync groups from AST to strings
            if configCopy.aplProto.groups and #configCopy.aplProto.groups > 0 then
                if syncRotationString then
                    -- Emit AST → strings when sync is enabled
                    if not configCopy.groups then
                        configCopy.groups = {}
                    end

                    -- Ensure groups array is the right size
                    while #configCopy.groups < #configCopy.aplProto.groups do
                        tinsert(configCopy.groups, { name = "", actions = {} })
                    end
                    while #configCopy.groups > #configCopy.aplProto.groups do
                        tremove(configCopy.groups)
                    end

                    for i, protoGroup in ipairs(configCopy.aplProto.groups) do
                        local group = configCopy.groups[i]
                        if not group then
                            group = { name = "", actions = {} }
                            configCopy.groups[i] = group
                        end

                        -- Update name
                        group.name = protoGroup.name or ""

                        -- Emit actions from AST
                        local actions = protoGroup.actions or {}
                        if not group.actions then
                            group.actions = {}
                        end

                        -- Ensure actions array is the right size
                        while #group.actions < #actions do
                            tinsert(group.actions, "")
                        end
                        while #group.actions > #actions do
                            tremove(group.actions)
                        end

                        for j, actionItem in ipairs(actions) do
                            if actionItem.action then
                                local actionString = ASTSchemaEmitter.EmitActionNode(actionItem.action)
                                if actionString then
                                    group.actions[j] = actionString
                                else
                                    self:Warn("SaveRotation: Failed to emit group %d action %d (edit source: aplProto, sync enabled)", i, j)
                                end
                            end
                        end
                    end
                    self:Debug("SaveRotation: Emitted groups from aplProto.groups to strings (edit source: aplProto, sync enabled)")
                else
                    -- Only regenerate if missing (for execution safety)
                    if not configCopy.groups or #configCopy.groups == 0 then
                        configCopy.groups = {}
                        for i, protoGroup in ipairs(configCopy.aplProto.groups) do
                            local group = { name = protoGroup.name or "", actions = {} }
                            for j, actionItem in ipairs(protoGroup.actions or {}) do
                                if actionItem.action then
                                    local actionString = ASTSchemaEmitter.EmitActionNode(actionItem.action)
                                    if actionString then
                                        tinsert(group.actions, actionString)
                                    else
                                        self:Warn("SaveRotation: Failed to emit group %d action %d (edit source: aplProto, sync disabled, regenerating)", i, j)
                                    end
                                end
                            end
                            tinsert(configCopy.groups, group)
                        end
                        self:Warn("SaveRotation: Regenerated groups from aplProto.groups (required for execution, but may be out of sync)")
                    else
                        self:Debug("SaveRotation: Skipping groups sync (edit source: aplProto, sync disabled)")
                    end
                end
            end

            -- Sync variables from AST to strings
            if configCopy.aplProto.value_variables and #configCopy.aplProto.value_variables > 0 then
                if syncRotationString then
                    -- Emit AST → strings when sync is enabled
                    if not configCopy.variables then
                        configCopy.variables = {}
                    end

                    -- Ensure variables array is the right size
                    while #configCopy.variables < #configCopy.aplProto.value_variables do
                        tinsert(configCopy.variables, { name = "", value = "" })
                    end
                    while #configCopy.variables > #configCopy.aplProto.value_variables do
                        tremove(configCopy.variables)
                    end

                    for i, protoVar in ipairs(configCopy.aplProto.value_variables) do
                        local variable = configCopy.variables[i]
                        if not variable then
                            variable = { name = "", value = "" }
                            configCopy.variables[i] = variable
                        end

                        -- Update name
                        variable.name = protoVar.name or ""

                        -- Emit value from AST
                        if protoVar.value then
                            local valueString = ASTSchemaEmitter.EmitValueNode(protoVar.value)
                            if valueString then
                                variable.value = valueString
                            else
                                self:Warn("SaveRotation: Failed to emit variable %d value (edit source: aplProto, sync enabled)", i)
                                variable.value = ""
                            end
                        else
                            variable.value = ""
                        end
                    end
                    self:Debug("SaveRotation: Emitted variables from aplProto.value_variables to strings (edit source: aplProto, sync enabled)")
                else
                    -- Only regenerate if missing (for execution safety)
                    if not configCopy.variables or #configCopy.variables == 0 then
                        configCopy.variables = {}
                        for i, protoVar in ipairs(configCopy.aplProto.value_variables) do
                            local variable = { name = protoVar.name or "", value = "" }
                            if protoVar.value then
                                local valueString = ASTSchemaEmitter.EmitValueNode(protoVar.value)
                                if valueString then
                                    variable.value = valueString
                                end
                            end
                            tinsert(configCopy.variables, variable)
                        end
                        self:Warn("SaveRotation: Regenerated variables from aplProto.value_variables (required for execution, but may be out of sync)")
                    else
                        self:Debug("SaveRotation: Skipping variables sync (edit source: aplProto, sync disabled)")
                    end
                end
            end
        end
    else
        -- Legacy/unknown: Default to rotationString sync behavior
        if configCopy.rotationString and not configCopy.aplProto then
            local conversionService = NAG:GetModule("RotationConversionService", true)
            if conversionService then
                local protoAST, diagnostics = conversionService:ParseToProtoAST(
                    configCopy.rotationString,
                    { useCache = true, validate = false }
                )
                if protoAST then
                    configCopy.aplProto = protoAST
                    self:Debug("SaveRotation: Regenerated aplProto from rotationString (legacy/unknown edit source)")
                end
            end
        end
        -- Also handle legacy case where aplProto exists but rotationString is missing
        if configCopy.aplProto and not configCopy.rotationString then
            local ASTSchemaEmitter = ns.ASTSchemaEmitter
            if ASTSchemaEmitter then
                ensureAplProtoRotationType(configCopy.aplProto)
                local rotationString, err = ASTSchemaEmitter.EmitRotationString(configCopy.aplProto)
                if rotationString then
                    configCopy.rotationString = rotationString
                    self:Debug("SaveRotation: Regenerated rotationString from aplProto (legacy/unknown edit source)")
                else
                    self:Warn("SaveRotation: Failed to regenerate rotationString: %s", tostring(err))
                end
            end
        end

        -- Also sync groups and variables for legacy/unknown (default to parsing strings → AST)
        local NAGStringParser = NAG:GetModule("NAGStringParser", true)
        local ASTCore = ns.ASTCore
        local ASTAction = ns.ASTAction

        if NAGStringParser and ASTCore and configCopy.aplProto then
            -- Initialize groups and value_variables arrays if missing
            if not configCopy.aplProto.groups then
                configCopy.aplProto.groups = {}
            end
            if not configCopy.aplProto.value_variables then
                configCopy.aplProto.value_variables = {}
            end

            -- Parse groups from strings to AST if AST is missing
            if configCopy.groups and #configCopy.groups > 0 and (#configCopy.aplProto.groups == 0) then
                configCopy.aplProto.groups = {}
                for i, group in ipairs(configCopy.groups) do
                    local protoGroup = {
                        type = ASTCore.NodeType.GROUP,
                        name = group.name or "",
                        description = nil,
                        hide = false,
                        actions = {},
                        variables = {}
                    }

                    -- Parse each action string to AST
                    for j, actionString in ipairs(group.actions or {}) do
                        if actionString and actionString ~= "" then
                            -- Use ParseClause to support conditions, NAG:Hidden(), and notes
                            local clauseResult = NAGStringParser:ParseClause(actionString, nil, nil)
                            if clauseResult and clauseResult.action then
                                -- Set condition on action if present
                                if clauseResult.condition and ASTAction then
                                    ASTAction.SetCondition(clauseResult.action, clauseResult.condition)
                                end

                                tinsert(protoGroup.actions, {
                                    type = ASTCore.NodeType.LIST_ITEM,
                                    hide = clauseResult.hidden or false,  -- Support NAG:Hidden()
                                    notes = clauseResult.notes or nil,     -- Support notes from comments
                                    action = clauseResult.action,
                                    -- condition is on action.condition, not here (proto structure)
                                })
                            else
                                self:Warn("SaveRotation: Failed to parse group %d action %d (legacy/unknown edit source)", i, j)
                            end
                        end
                    end

                    tinsert(configCopy.aplProto.groups, protoGroup)
                end
                self:Debug("SaveRotation: Parsed groups from strings to aplProto.groups (legacy/unknown edit source)")
            end

            -- Parse variables from strings to AST if AST is missing
            if configCopy.variables and #configCopy.variables > 0 and (#configCopy.aplProto.value_variables == 0) then
                configCopy.aplProto.value_variables = {}
                for i, variable in ipairs(configCopy.variables) do
                    local valueAST = nil
                    if variable.value and variable.value ~= "" then
                        -- Use ParseClause to handle value-only parsing (automatically routes to ParseValue/ParseCondition)
                        local clauseResult = NAGStringParser:ParseClause(variable.value, nil, nil)
                        if clauseResult then
                            -- Extract value from clause result (could be in value or condition field)
                            valueAST = clauseResult.value or clauseResult.condition
                        end
                    end

                    -- Fallback to empty constant if parsing fails
                    if not valueAST then
                        self:Warn("SaveRotation: Failed to parse variable %d value (legacy/unknown edit source), using empty constant", i)
                        local ASTValue = ns.ASTValue
                        if ASTValue then
                            valueAST = ASTValue.CreateConst("")
                        end
                    end

                    tinsert(configCopy.aplProto.value_variables, {
                        name = variable.name or "",
                        hide = false,
                        value = valueAST
                    })
                end
                self:Debug("SaveRotation: Parsed variables from strings to aplProto.value_variables (legacy/unknown edit source)")
            end

            -- Also handle legacy case where AST exists but strings are missing (regenerate for execution)
            local ASTSchemaEmitter = ns.ASTSchemaEmitter
            if ASTSchemaEmitter then
                if configCopy.aplProto.groups and #configCopy.aplProto.groups > 0 and (not configCopy.groups or #configCopy.groups == 0) then
                    configCopy.groups = {}
                    for i, protoGroup in ipairs(configCopy.aplProto.groups) do
                        local group = { name = protoGroup.name or "", actions = {} }
                        for j, actionItem in ipairs(protoGroup.actions or {}) do
                            if actionItem.action then
                                local actionString = ASTSchemaEmitter.EmitActionNode(actionItem.action)
                                if actionString then
                                    tinsert(group.actions, actionString)
                                else
                                    self:Warn("SaveRotation: Failed to emit group %d action %d (legacy/unknown edit source)", i, j)
                                end
                            end
                        end
                        tinsert(configCopy.groups, group)
                    end
                    self:Debug("SaveRotation: Regenerated groups from aplProto.groups (legacy/unknown edit source)")
                end

                if configCopy.aplProto.value_variables and #configCopy.aplProto.value_variables > 0 and (not configCopy.variables or #configCopy.variables == 0) then
                    configCopy.variables = {}
                    for i, protoVar in ipairs(configCopy.aplProto.value_variables) do
                        local variable = { name = protoVar.name or "", value = "" }
                        if protoVar.value then
                            local valueString = ASTSchemaEmitter.EmitValueNode(protoVar.value)
                            if valueString then
                                variable.value = valueString
                            else
                                self:Warn("SaveRotation: Failed to emit variable %d value (legacy/unknown edit source)", i)
                            end
                        end
                        tinsert(configCopy.variables, variable)
                    end
                    self:Debug("SaveRotation: Regenerated variables from aplProto.value_variables (legacy/unknown edit source)")
                end
            end
        end
    end

    -- EXECUTION SAFETY CHECK
    if not configCopy.rotationString then
        --self:Error("SaveRotation: rotationString is missing - rotation will not execute")
        -- Don't prevent save, but mark as disabled
        configCopy.enabled = false
        configCopy.disabledReason = "Missing rotationString (required for execution)"
    end

    -- Validate specIndex
    -- Ensure identification fields are embedded and correct
    configCopy.specIndex = specIndex  -- Use specIndex only
    configCopy.class = configCopy.class or self.className or NAG.CLASS_FILENAME
    configCopy.name = rotationName or configCopy.name

    -- Note: useCustomSpellLocations is now user-controlled via toggle
    -- Don't auto-set it based on spellLocations content

    -- Mark as user-modified if it's a custom rotation
    if not configCopy.isBaseRotation then
        configCopy.userModified = true
    end

    -- CRITICAL: Ensure specIndex is set in the config before saving
    -- This is required for import/export and when passing config without context
    if not configCopy.specIndex or configCopy.specIndex == 0 then
        configCopy.specIndex = specIndex
        self:Debug("SaveRotation: Set specIndex=%s in config (was missing or 0)", tostring(specIndex))
    end

    -- Get existing rotations and add/update the new one
    -- Store using specIndex as key
    local rotations = self.db.class.rotations
    self:Debug("SaveRotation: Existing rotations = " .. tostring(rotations))
    if not rotations[specIndex] then
        rotations[specIndex] = {}
    end

    rotations[specIndex][rotationName] = configCopy
    self:Debug("SaveRotation: About to call SetSetting")
    self:SetSetting("class", "rotations", rotations)

    -- Clear rotation cache after save to ensure updated rotation is used
    local RotationManager = NAG:GetModule("RotationManager")
    if RotationManager and RotationManager.ClearRotationCache then
        RotationManager:ClearRotationCache(specIndex, rotationName)
    end

    -- Update rotation switching cache after save
    self:UpdateRotationSwitchingNeeded(specIndex)

    self:Debug("SaveRotation: Saved rotation '" .. rotationName .. "' for specIndex " .. tostring(specIndex))
    return true
end

--- Deletes a rotation using the unified rotations namespace
--- This is the new unified API that replaces DeleteCustomRotation
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @param rotationName string The rotation name
--- @return boolean True if the rotation was deleted, false if it didn't exist
function ClassBase:DeleteRotation(specIndex, rotationName)
    -- Validate specIndex
    local rotations = self.db.class.rotations
    if rotations and
        rotations[specIndex] and
        rotations[specIndex][rotationName] then
        rotations[specIndex][rotationName] = nil

        -- Clean up empty spec table
        if not next(rotations[specIndex]) then
            rotations[specIndex] = nil
        end

        self:SetSetting("class", "rotations", rotations)

        -- If the deleted rotation is currently selected, clear active function/AST and timer, then restore default
        if self:GetSelectedRotation(specIndex) == rotationName then
            self:SetSelectedRotation(specIndex, nil)
            NAG.cachedRotationFunc = nil
            NAG.cachedRotationAST = nil
            if RotationManager.ClearRotationCache then
                RotationManager:ClearRotationCache(specIndex, rotationName)
            end
            if TimerManager.Cancel then
                TimerManager:Cancel(TimerManager.Categories.ROTATION, "rotation")
            end
            self:EnsureDefaultRotation()
        end

        -- Update rotation switching cache after deletion
        self:UpdateRotationSwitchingNeeded(specIndex)

        self:Debug("DeleteRotation: Deleted rotation '" .. rotationName .. "' for specIndex " .. tostring(specIndex))
        return true
    end

    self:Debug("DeleteRotation: Rotation '" .. rotationName .. "' not found for specIndex " .. tostring(specIndex))
    return false
end

--- Checks if a rotation exists using the unified rotations namespace
--- This is the new unified API that replaces HasBaseRotation/HasCustomRotation
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @param rotationName string The rotation name
--- @return boolean True if the rotation exists
function ClassBase:HasRotation(specIndex, rotationName)
    return self:GetRotation(specIndex, rotationName) ~= nil
end

--- Gets the current active rotation using the unified rotations namespace
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex? number The spec index (optional, uses current spec if not provided)
--- @return table|nil rotation The rotation config, or nil if not found
--- @return string|nil name The name of the rotation if found, or nil if not found
function ClassBase:GetCurrentRotation(specIndex)
    -- Check if database is ready first
    if not self:IsDatabaseReady() then
        self:Debug("GetCurrentRotation: Database not ready")
        return nil, nil
    end

    -- Get spec index if not provided
    if not specIndex then
        specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if not specIndex then
            self:Debug("GetCurrentRotation: No spec index available")
            return nil, nil
        end
    end

    -- Get selected rotation name from character settings
    local selectedRotations = self.db.char.selectedRotations
    local selectedRotationName = selectedRotations[specIndex]

    if not selectedRotationName then
        self:Debug("GetCurrentRotation: No rotation selected for specIndex " .. tostring(specIndex))
        return nil, nil
    end

    -- Get the rotation from unified namespace
    local rotation = self:GetRotation(specIndex, selectedRotationName)
    if not rotation then
        self:Debug("GetCurrentRotation: Selected rotation '" .. selectedRotationName .. "' not found")
        return nil, nil
    end

    -- CRITICAL: Don't return Generic rotations when talents are available
    -- Generic should only be used when talents are NOT available (level < 10)
    if rotation.specIndex == 0 then
        if SpecCompat then
            local specStatus = SpecCompat:GetSpecializationStatus()
            if specStatus and specStatus.available then
                self:Debug("GetCurrentRotation: Generic rotation selected but talents are available - returning nil")
                return nil, nil
            end
        end
    end

    -- Dev-only rotations are inactive when developer mode is off (no recommendations)
    if rotation.devOnly and not (NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) then
        return nil, nil
    end

    -- Debug logging removed here - this is a hotpath function called frequently
    return rotation, selectedRotationName
end

--- Sets the selected rotation for a spec using the unified namespace
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @param rotationName string|nil The rotation name to select, or nil to clear selection
--- @return boolean True if successful, false otherwise
function ClassBase:SetSelectedRotation(specIndex, rotationName)
    if not specIndex then
        self:Warn("SetSelectedRotation: Invalid parameters - specIndex is required")
        return false
    end

    -- If rotationName is nil, clear the selection
    if not rotationName then
        if UnitAffectingCombat and UnitAffectingCombat("player") then
            local RotationManager = NAG:GetModule("RotationManager", true)
            if RotationManager and RotationManager.QueueSelectionClear then
                RotationManager:QueueSelectionClear(specIndex, "combat_clear_blocked", "ClassBase:SetSelectedRotation")
            end
            self:Debug("SetSelectedRotation: Deferred clear in combat for specIndex " .. tostring(specIndex))
            return true
        end

        local selectedRotations = self.db.char.selectedRotations
        selectedRotations[specIndex] = nil
        self:SetSetting("char", "selectedRotations", selectedRotations)
        self:Debug("SetSelectedRotation: Cleared rotation selection for specIndex " .. tostring(specIndex))
        return true
    end

    -- Verify the rotation exists (only if rotationName is provided)
    if not self:HasRotation(specIndex, rotationName) then
        self:Warn("SetSelectedRotation: Rotation '" .. rotationName .. "' not found for specIndex " .. tostring(specIndex))
        return false
    end

    -- Get existing selected rotations and update
    local selectedRotations = self.db.char.selectedRotations
    selectedRotations[specIndex] = rotationName
    self:SetSetting("char", "selectedRotations", selectedRotations)

    self:Debug("SetSelectedRotation: Set rotation '" .. rotationName .. "' as selected for specIndex " .. tostring(specIndex))

    local RotationManager = NAG:GetModule("RotationManager", true)
    if RotationManager and RotationManager.RecordLastSelectedRotation then
        RotationManager:RecordLastSelectedRotation(specIndex, rotationName, "SetSelectedRotation")
    end

    -- Diagnostic logging for actual rotation changes
    if ns.RotationStuckDiag and ns.RotationStuckDiag.IsEnabled() then
        ns.RotationStuckDiag.LogRotationSelection(specIndex, rotationName, "SetSelectedRotation")
    end

    return true
end

--- Gets the selected rotation name for a spec using the unified namespace
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @return string|nil The name of the selected rotation, or nil if none selected
function ClassBase:GetSelectedRotation(specIndex)
    if not specIndex then
        return nil
    end

    -- Validate specIndex
    local selectedRotations = self.db.char.selectedRotations
    return selectedRotations[specIndex]
end

--- Generates a unique rotation name using the unified namespace
--- This is the new unified API that replaces GenerateUniqueName
--- Uses specIndex (1,2,3) as primary identifier
--- @param self ClassBase
--- @param specIndex number The spec index (1,2,3)
--- @param baseName string The base name to make unique
--- @return string The unique rotation name
function ClassBase:GenerateUniqueRotationName(specIndex, baseName)
    if not baseName or baseName == "" then
        baseName = "New Rotation"
    end

    local rotations = self:GetAllRotations(specIndex)
    local uniqueName = baseName
    local counter = 1

    while rotations[uniqueName] do
        counter = counter + 1
        uniqueName = baseName .. " (" .. counter .. ")"
    end

    return uniqueName
end

--- ============================ END UNIFIED ROTATION API ============================

--- Gets whether automatic rotation switching is enabled
--- @return boolean True if automatic rotation switching is enabled
function ClassBase:IsAutomaticRotationSwitchingEnabled()
    return self.db.char.enableAutomaticRotationSwitching
end

--- Checks if rotation switching is needed for the current spec
--- Updates the needsRotationSwitching cache flag based on available rotations
--- @param self ClassBase
--- @param specIndex? number The spec index (1,2,3) to check (uses current spec if not provided)
function ClassBase:UpdateRotationSwitchingNeeded(specIndex)
    -- Get spec index if not provided
    if not specIndex then
        specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if not specIndex then
            self.needsRotationSwitching = false
            return
        end
    end

    -- Get all rotations for this spec
    local allRotations = self:GetAllRotations(specIndex)
    if not allRotations or not next(allRotations) then
        self.needsRotationSwitching = false
        return
    end

    -- Get current rotation to check if it's opted into smart switching
    local currentRotationName = self:GetSelectedRotation(specIndex)
    local currentRotation = currentRotationName and allRotations[currentRotationName]

    -- Check if current rotation is opted into smart switching
    local currentEnabledForSwitching = currentRotation and currentRotation.enableSmartSwitching

    -- Count switchable (opted-in) enabled rotations and check for custom conditions
    local enabledCount = 0
    local switchableCount = 0
    local hasCustomConditions = false

    for name, config in pairs(allRotations) do
        if config.enabled then
            enabledCount = enabledCount + 1
            -- Only count rotations that participate in smart switching
            if config.enableSmartSwitching then
                switchableCount = switchableCount + 1
                if config.customConditions and next(config.customConditions) then
                    hasCustomConditions = true
                end
            end
        end
    end

    -- Need switching if:
    -- 1. Current rotation is opted into switching (participates in switching)
    -- 2. Multiple switchable rotations exist (2+)
    -- 3. At least one switchable rotation has conditions
    -- Note: Current rotation doesn't need conditions - rotations without conditions can be fallbacks
    -- If a rotation has opted into smart switching, it should participate even without conditions
    self.needsRotationSwitching = currentEnabledForSwitching
        and switchableCount > 1
        and hasCustomConditions

    self:Debug("UpdateRotationSwitchingNeeded: specIndex=%d, current='%s', enabledForSwitching=%s, enabled=%d, switchable=%d, hasConditions=%s, needsSwitching=%s",
        specIndex, tostring(currentRotationName), tostring(currentEnabledForSwitching), enabledCount, switchableCount,
        tostring(hasCustomConditions), tostring(self.needsRotationSwitching))
end

ns.ClassBase = ClassBase

--- Evaluates a custom condition against the current context
--- @param self ClassBase
--- @param condition table The custom condition to evaluate
--- @param context table The current context
--- @return boolean result Whether the condition is met
function ClassBase:EvaluateCustomCondition(condition, context)
    if not condition or not context then return false end

    local conditionType = condition.type

    if conditionType == ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE then
        return self:EvaluateWeaponTypeCondition(condition.value, context)
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT then
        return self:EvaluateTargetCountCondition(condition, context) -- Pass full condition for range access
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.AURA_ACTIVE then
        return self:EvaluateAuraCondition(condition.value, context)
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.GROUP_CONTEXT then
        return self:EvaluateGroupContextCondition(condition.value, context)
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.ASSIGNMENT then
        return self:EvaluateAssignmentCondition(condition.value, context)
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.CUSTOM_FUNCTION then
        return self:EvaluateCustomFunctionCondition(condition.value, context)
    end

    return false
end

--- Evaluates weapon type conditions
--- @param self ClassBase
--- @param weaponType string The weapon type to check for
--- @param context table The current context
--- @return boolean result Whether the weapon type condition is met
function ClassBase:EvaluateWeaponTypeCondition(weaponType, context)
    if weaponType == "dualWield" then
        -- Check if player has off-hand equipped
        local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
        return offhandLink ~= nil
    elseif weaponType == "twoHand" then
        -- Check if player has no off-hand equipped (2H weapon)
        local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
        return offhandLink == nil
    elseif weaponType == "oneHand" then
        -- Check if player has main hand but no off-hand
        local mainHandLink = GetInventoryItemLink("player", 16) -- INVSLOT_MAINHAND
        local offhandLink = GetInventoryItemLink("player", 17)  -- INVSLOT_OFFHAND
        return mainHandLink ~= nil and offhandLink == nil
    end

    return false
end

--- Evaluates group context conditions (solo/group/raid) with multi-select support
--- @param self ClassBase
--- @param expected any Table of allowed contexts (e.g., {"solo","group"}) or a single string
--- @param context table The current context
--- @return boolean result Whether the group context condition is met
function ClassBase:EvaluateGroupContextCondition(expected, context)
    -- Normalize expected to a set for O(1) checks
    local allowed = {}
    if type(expected) == "table" then
        for _, v in ipairs(expected) do allowed[v] = true end
    elseif type(expected) == "string" then
        allowed[expected] = true
    else
        return false
    end

    local groupType = context.groupType -- "solo" | "group" | "raid"
    if not groupType then
        if IsInRaid() then
            groupType = "raid"
        elseif IsInGroup() then
            groupType = "group"
        else
            groupType = "solo"
        end
    end
    return allowed[groupType] == true
end

--- Evaluates assignment conditions (class assignment toggles) with multi-select support
--- @param self ClassBase
--- @param expected any Table of required assignment IDs (e.g., {"assignment1","assignment2"}) or a single string
--- @param context table The current context
--- @return boolean result Whether the assignment condition is met
function ClassBase:EvaluateAssignmentCondition(expected, context)
    -- Normalize expected to a set for O(1) checks
    local required = {}
    if type(expected) == "table" then
        for _, v in ipairs(expected) do required[v] = true end
    elseif type(expected) == "string" then
        required[expected] = true
    else
        return false
    end

    -- Get assignment states from context
    local assignments = context.assignments
    if not assignments or type(assignments) ~= "table" then
        self:Warn("EvaluateAssignmentCondition: Missing assignments in context")
        return false
    end

    -- Check if all required assignments are enabled
    for assignmentId, _ in pairs(required) do
        local isEnabled = assignments[assignmentId]
        if isEnabled == nil then
            isEnabled = true -- Default: enabled (cast everything)
        end
        if not isEnabled then
            return false -- At least one required assignment is disabled
        end
    end

    return true -- All required assignments are enabled
end

--- Evaluates target count conditions
--- @param self ClassBase
--- @param condition table The full target count condition {value={min, max, operator}, range?}
--- @param context table The current context
--- @return boolean result Whether the target count condition is met
function ClassBase:EvaluateTargetCountCondition(condition, context)
    local targetCount = condition.value
    local range = condition.range -- Optional range parameter

    -- Validate targetCount structure
    if not targetCount or not targetCount.operator then
        self:Warn("EvaluateTargetCountCondition: Invalid targetCount structure - missing operator")
        return false
    end

    -- Normalize numeric fields defensively
    if targetCount.value ~= nil then
        targetCount.value = tonumber(targetCount.value)
    end
    if targetCount.min ~= nil then
        targetCount.min = tonumber(targetCount.min)
    end
    if targetCount.max ~= nil then
        targetCount.max = tonumber(targetCount.max)
    end

    -- Use specified range if provided, otherwise use smart behavior
    local currentTargets
    if range then
        currentTargets = NAG:NumberTargets(range)
    else
        currentTargets = context.targetCount or NAG:NumberTargets()
    end

    -- Ensure currentTargets is a number
    if not currentTargets or type(currentTargets) ~= "number" then
        self:Warn("EvaluateTargetCountCondition: Invalid currentTargets value: " .. tostring(currentTargets))
        currentTargets = 0
    end

    if targetCount.operator == "eq" then
        if targetCount.value == nil then
            self:Warn("EvaluateTargetCountCondition: targetCount.value is nil for eq operator")
            return false
        end
        return currentTargets == targetCount.value
    elseif targetCount.operator == "lt" then
        if targetCount.value == nil then
            self:Warn("EvaluateTargetCountCondition: targetCount.value is nil for lt operator")
            return false
        end
        return currentTargets < targetCount.value
    elseif targetCount.operator == "lte" then
        if targetCount.value == nil then
            self:Warn("EvaluateTargetCountCondition: targetCount.value is nil for lte operator")
            return false
        end
        return currentTargets <= targetCount.value
    elseif targetCount.operator == "gt" then
        if targetCount.value == nil then
            self:Warn("EvaluateTargetCountCondition: targetCount.value is nil for gt operator")
            return false
        end
        return currentTargets > targetCount.value
    elseif targetCount.operator == "gte" then
        if targetCount.value == nil then
            self:Warn("EvaluateTargetCountCondition: targetCount.value is nil for gte operator")
            return false
        end
        return currentTargets >= targetCount.value
    elseif targetCount.operator == "range" then
        if targetCount.min == nil or targetCount.max == nil then
            self:Warn("EvaluateTargetCountCondition: targetCount.min or targetCount.max is nil for range operator")
            return false
        end
        if type(targetCount.min) ~= "number" or type(targetCount.max) ~= "number" then
            self:Warn("EvaluateTargetCountCondition: targetCount.min/max not numeric for range operator")
            return false
        end
        return currentTargets >= targetCount.min and currentTargets <= targetCount.max
    end

    return false
end

--- Evaluates aura conditions
--- @param self ClassBase
--- @param auraCondition table The aura condition to check
--- @param context table The current context
--- @return boolean result Whether the aura condition is met
function ClassBase:EvaluateAuraCondition(auraCondition, context)
    local spellID = auraCondition.spellID
    local unit = auraCondition.unit or "player"
    local operator = auraCondition.operator or "active"

    if operator == "active" then
        return NAG:AuraIsActive(spellID, unit)
    elseif operator == "inactive" then
        return not NAG:AuraIsActive(spellID, unit)
    elseif operator == "stacks" then
        local stacks = NAG:AuraNumStacks(spellID, unit)
        return self:CompareValues(stacks, auraCondition.value, auraCondition.comparison)
    end

    return false
end

--- Evaluates custom function conditions
--- @param self ClassBase
--- @param customFunction function The custom function to evaluate
--- @param context table The current context
--- @return boolean result Whether the custom function condition is met
function ClassBase:EvaluateCustomFunctionCondition(customFunction, context)
    if type(customFunction) == "function" then
        local success, result = pcall(customFunction, context)
        if success then
            return result
        else
            self:Warn("Custom function condition failed: " .. tostring(result))
            return false
        end
    end

    return false
end

--- Compares two values using the specified comparison operator
--- @param self ClassBase
--- @param value1 number The first value to compare
--- @param value2 number The second value to compare
--- @param operator string The comparison operator
--- @return boolean result Whether the comparison is true
function ClassBase:CompareValues(value1, value2, operator)
    if operator == "eq" then
        return value1 == value2
    elseif operator == "lt" then
        return value1 < value2
    elseif operator == "lte" then
        return value1 <= value2
    elseif operator == "gt" then
        return value1 > value2
    elseif operator == "gte" then
        return value1 >= value2
    end

    return false
end

--- Gets the current weapon configuration (dual-wield vs two-hand)
--- @return string|nil The weapon configuration: "dualWield", "twoHand", or nil
function ClassBase:GetWeaponConfiguration()
    local mainHand = GetInventoryItemID("player", 16)
    local offHand = GetInventoryItemID("player", 17)

    if not mainHand then
        return nil -- No main hand weapon
    end

    if offHand then
        return "dualWield"
    else
        return "twoHand"
    end
end

--- Gets the optimal rotation for the current context
--- @param self ClassBase
--- @param specIndex number The specialization index (1,2,3)
--- @param context table The current context (targetCount, weaponConfig, etc.)
--- @return string|nil rotationName The name of the optimal rotation, or nil if no switch needed
function ClassBase:GetOptimalRotation(specIndex, context)
    if not specIndex or not context then
        return nil
    end

    -- Get all available rotations for this spec
    local allRotations = self:GetAllRotations(specIndex)
    if not allRotations or not next(allRotations) then
        return nil
    end

    -- Get current rotation name
    local currentRotationName = self:GetSelectedRotation(specIndex)
    if not currentRotationName then
        return nil
    end

    -- Get current rotation config
    local currentRotation = allRotations[currentRotationName]

    -- If current rotation is not opted into smart switching, NEVER switch away from it
    if currentRotation and not currentRotation.enableSmartSwitching then
        self:Debug("GetOptimalRotation: current='%s' not enabled for smart switching, no switch allowed", currentRotationName)
        return nil
    end

    -- Check if current rotation is still optimal for the context
    if currentRotation and self:IsRotationOptimalForContext(currentRotation, context) then
        self:Debug("GetOptimalRotation: current='%s' still optimal, no switch needed", currentRotationName)
        return nil -- Current rotation is still optimal
    end

    self:Debug("GetOptimalRotation: current='%s' NOT optimal (targets=%d, weaponConfig=%s), searching alternatives...",
        currentRotationName, context.targetCount or 0, tostring(context.weaponConfig))

    -- First pass: Find rotations with matching conditions (IsRotationOptimalForContext handles all condition types)
    for rotationName, rotationConfig in pairs(allRotations) do
        if rotationConfig and rotationConfig.enabled and rotationConfig.enableSmartSwitching then
            if self:IsRotationOptimalForContext(rotationConfig, context) then
                self:Debug("GetOptimalRotation: found optimal rotation='%s'", rotationName)
                return rotationName
            end
        end
    end

    -- Second pass: If no rotations with conditions matched, use rotations without conditions as fallback
    -- Check if current rotation has no conditions - if so, keep it as fallback
    local currentHasNoConditions = currentRotation and
        (not currentRotation.customConditions or not next(currentRotation.customConditions))

    if currentHasNoConditions then
        self:Debug("GetOptimalRotation: current rotation has no conditions and no rotations with conditions matched - keeping current rotation")
        return nil -- Keep current rotation (it's already the fallback)
    end

    -- Otherwise, search for other rotations without conditions as fallback
    self:Debug("GetOptimalRotation: no rotations with conditions matched, searching for rotations without conditions as fallback...")
    for rotationName, rotationConfig in pairs(allRotations) do
        if rotationName ~= currentRotationName and rotationConfig and rotationConfig.enabled and rotationConfig.enableSmartSwitching then
            -- Rotations without any conditions are valid fallback when no rotations with conditions match
            if not rotationConfig.customConditions or not next(rotationConfig.customConditions) then
                self:Debug("GetOptimalRotation: found fallback rotation='%s' (no conditions)", rotationName)
                return rotationName
            end
        end
    end

    self:Debug("GetOptimalRotation: no optimal rotation found")
    return nil -- No optimal rotation found
end

--- Checks if a rotation is optimal for the current context
--- @param self ClassBase
--- @param rotation table The rotation configuration to check
--- @param context table The current context
--- @return boolean isOptimal Whether the rotation is optimal for the context
function ClassBase:IsRotationOptimalForContext(rotation, context)
    if not rotation or not context then
        return false
    end

    -- Rotations not opted into smart switching are NEVER optimal for switching TO
    -- They can only be manually selected and will never be auto-selected
    if not rotation.enableSmartSwitching then
        return false
    end

    -- Rotations without conditions are treated as fallback/low-priority
    -- They should NOT be considered optimal - let rotations with matching conditions take priority
    if not rotation.customConditions or not next(rotation.customConditions) then
        return false
    end

    -- All custom conditions must be met for the rotation to be optimal
    for i, condition in pairs(rotation.customConditions) do
        local conditionMet = self:EvaluateCustomCondition(condition, context)
        if not conditionMet then
            self:Debug("IsRotationOptimalForContext: rotation='%s' FAILED condition #%d (type=%s)",
                rotation.name or "unknown", i, tostring(condition.type))
            return false
        end
    end

    self:Debug("IsRotationOptimalForContext: rotation='%s' is OPTIMAL (all %d conditions met)",
        rotation.name or "unknown", #rotation.customConditions)
    return true
end

--- Scores a rotation based on how well it matches the current context
--- @param self ClassBase
--- @param rotation table The rotation to score
--- @param context table The current context
--- @return number score The rotation score (higher is better)
function ClassBase:ScoreRotationForContext(rotation, context)
    if not rotation or not context then
        return 0
    end

    local score = 0

    -- Check if rotation has custom conditions
    if rotation.customConditions and next(rotation.customConditions) then
        for _, condition in pairs(rotation.customConditions) do
            if self:EvaluateCustomCondition(condition, context) then
                score = score + 1
            end
        end
    end

    return score
end

--- Smart rotation switching that replaces hardcoded SelectRotation calls
--- @param self ClassBase
--- @param specIndex? number The specialization index (1,2,3) (optional, uses current spec if not provided)
--- @return boolean switched Whether a rotation switch occurred
function ClassBase:SmartRotationSwitch(specIndex)
    -- If specIndex not provided, use current spec
    if not specIndex then
        specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if not specIndex then
            return false
        end
    end

    -- Build current context
    local context = {
        targetCount = NAG:NumberTargets(),
        meleeTargetCount = NAG:NumberTargets(),
        inCombat = UnitAffectingCombat("player"),
        weaponConfig = self:GetWeaponConfiguration(),
        -- Group context: "solo" | "group" | "raid"
        groupType = (function()
            if IsInRaid() then return "raid" end
            if IsInGroup() then return "group" end
            return "solo"
        end)(),
        -- Assignment states: { [assignmentId] = enabled }
        assignments = self:GetAssignmentStates(),
    }

    -- Get current rotation for comparison
    local currentRotation = self:GetSelectedRotation(specIndex)

    -- Get optimal rotation for current context
    local optimalRotation = self:GetOptimalRotation(specIndex, context)
    if optimalRotation then
        -- Switch to optimal rotation
        local success = self:SelectRotation(specIndex, optimalRotation)
        if success then
            self:Debug("SmartRotationSwitch: Successfully switched to '" .. optimalRotation .. "' based on context")

            -- Diagnostic logging for actual rotation switches
            if ns.RotationStuckDiag and ns.RotationStuckDiag.IsEnabled() then
                ns.RotationStuckDiag.LogRotationSwitch("SmartSwitch", currentRotation, optimalRotation, "context_change")
            end

            return true
        end
    end

    return false
end

-- ============================ SMART ROTATION EVENT HANDLERS ============================

--- Handle target count changes for automatic rotation switching
--- @param message string The message name
--- @param data table Mob count data {total, melee, oldTotal, oldMelee}
function ClassBase:OnMobCountChanged(message, data)
    -- Smart switching is normal operation, not a diagnostic issue
    -- Removed diagnostic logging to prevent log spam in raids/dungeons

    -- Early exit if rotation switching not needed for this spec
    if not self.needsRotationSwitching then
        return
    end

    if not self:IsAutomaticRotationSwitchingEnabled() then
        return
    end

    self:Debug("Target count changed (total: %d -> %d, melee: %d -> %d) - triggering rotation switch check",
        data.oldTotal or 0, data.total, data.oldMelee or 0, data.melee)

    self:SmartRotationSwitch()
end

--- Handle combat state changes for automatic rotation switching
--- @param message string The message name
--- @param data table Combat state data {inCombat, timestamp}
function ClassBase:OnCombatStateChanged(message, data)
    -- Smart switching is normal operation, not a diagnostic issue
    -- Removed diagnostic logging to prevent log spam in raids/dungeons

    -- Early exit if rotation switching not needed for this spec
    if not self.needsRotationSwitching then
        return
    end

    if not self:IsAutomaticRotationSwitchingEnabled() then
        return
    end

    -- Trigger on both entering and leaving combat
    self:Debug("Combat state changed (inCombat: %s) - triggering rotation switch check", tostring(data.inCombat))
    self:SmartRotationSwitch()
end

--- Handle group roster changes for automatic rotation switching and assignment reset
--- @param message string The message name
--- @param data table Group data {inRaid, inParty, memberCount, timestamp}
function ClassBase:OnGroupRosterUpdated(message, data)
    local currentlyInGroup = (data and (data.inRaid or data.inParty)) or NAG:PlayerIsInGroup()
    local previouslyInGroup = self.wasInGroup == true

    -- Update tracked state immediately to avoid repeated transition handling
    -- if this handler is re-entered before completing.
    self.wasInGroup = currentlyInGroup

    if self:IsClassAssignmentsEnabled() then
        -- Check for leaving group and clear assignments
        if previouslyInGroup and not currentlyInGroup then
            self:Debug("Left group - clearing class assignments")
            self:ClearAssignmentsForNoGroup()
        end

        -- Check for joining group and prompt for previous assignment
        if (not previouslyInGroup) and currentlyInGroup then
            self:PromptAssignmentRestore()
        end
    end

    -- Early exit if rotation switching not needed for this spec
    if not self.needsRotationSwitching then
        return
    end

    if not self:IsAutomaticRotationSwitchingEnabled() then
        return
    end

    self:Debug("Group roster changed (raid: %s, party: %s, members: %d) - triggering rotation switch check",
        tostring(data.inRaid), tostring(data.inParty), data.memberCount or 0)

    self:SmartRotationSwitch()
end

--- Handle equipment changes for automatic rotation switching
--- @param message string The message name
--- @param data table Equipment data {slot, hasCurrent, timestamp}
function ClassBase:OnEquipmentChanged(message, data)
    -- Smart switching is normal operation, not a diagnostic issue
    -- Removed diagnostic logging to prevent log spam in raids/dungeons

    -- Early exit if rotation switching not needed for this spec
    if not self.needsRotationSwitching then
        return
    end

    if not self:IsAutomaticRotationSwitchingEnabled() then
        return
    end

    -- Only check weapon slots (16 = INVSLOT_MAINHAND, 17 = INVSLOT_OFFHAND)
    if data.slot ~= 16 and data.slot ~= 17 then
        return
    end

    self:Debug("Weapon equipment changed (slot: %d) - triggering rotation switch check", data.slot)

    self:SmartRotationSwitch()
end

--- Direct CLEU handler for rotation switching auras (player-sourced)
function ClassBase:HandleCLEURotationAura(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    -- Match prior behavior: only act on player-sourced auras
    if sourceGUID ~= UnitGUID("player") then
        return
    end

    -- Early exit if rotation switching not needed or disabled
    if not self.needsRotationSwitching then
        return
    end

    if not self:IsAutomaticRotationSwitchingEnabled() then
        return
    end

    self:Debug("Aura changed (spellId: %s, subevent: %s) - triggering rotation switch check",
        tostring(spellId), tostring(subEvent))

    self:SmartRotationSwitch()
end


--- Handle assignment changes for automatic rotation switching
--- @param message string The message name
--- @param data table Assignment data {assignmentId, enabled}
function ClassBase:OnAssignmentChanged(message, data)
    -- Early exit if rotation switching not needed for this spec
    if not self.needsRotationSwitching then
        return
    end

    if not self:IsAutomaticRotationSwitchingEnabled() then
        return
    end

    self:Debug("Assignment changed (assignmentId: %s, enabled: %s) - triggering rotation switch check",
        tostring(data.assignmentId), tostring(data.enabled))

    self:SmartRotationSwitch()
end

-- ============================ COOLDOWN CATEGORY OVERRIDE FUNCTIONS ============================

--- Override cooldown category for a spell
--- @param self ClassBase
--- @param spellId number The spell ID to override
--- @param cooldownType number|nil The cooldown type to assign (nil to remove override)
function ClassBase:SetCooldownCategory(spellId, cooldownType)
    if not spellId then return end

    local overrides = self.db.char.cooldownCategoryOverrides
    if not overrides.Spell then
        overrides.Spell = {}
    end

    if cooldownType then
        overrides.Spell[spellId] = cooldownType
        self:Debug("SetCooldownCategory: Set spell %d to cooldown type %d", spellId, cooldownType)
    else
        overrides.Spell[spellId] = nil
        self:Debug("SetCooldownCategory: Removed cooldown type override for spell %d", spellId)
    end

    self:SetSetting("char", "cooldownCategoryOverrides", overrides)
end

--- Get cooldown category override for a spell
--- @param self ClassBase
--- @param spellId number The spell ID to check
--- @return number|nil The overridden cooldown type, or nil if no override exists
function ClassBase:GetCooldownCategory(spellId)
    local overrides = self.db.char.cooldownCategoryOverrides
    if overrides and overrides.Spell and overrides.Spell[spellId] then
        return overrides.Spell[spellId]
    end
    return nil
end

--- Set disabled state override for a spell cooldown
--- @param self ClassBase
--- @param spellId number
--- @param disabled boolean
function ClassBase:SetCooldownDisabled(spellId, disabled)
    if not spellId then return end

    local overrides = self.db.char.cooldownCategoryOverrides
    overrides.Disabled = overrides.Disabled or {}
    overrides.Disabled.Spell = overrides.Disabled.Spell or {}

    if disabled then
        overrides.Disabled.Spell[spellId] = true
        self:Debug("SetCooldownDisabled: Disabled spell %d", spellId)
    else
        overrides.Disabled.Spell[spellId] = nil
        self:Debug("SetCooldownDisabled: Enabled spell %d", spellId)
    end

    self:SetSetting("char", "cooldownCategoryOverrides", overrides)
end

--- Check if a spell cooldown is disabled via overrides
--- @param self ClassBase
--- @param spellId number
--- @return boolean
function ClassBase:IsCooldownDisabled(spellId)
    local overrides = self.db.char.cooldownCategoryOverrides
    return overrides and overrides.Disabled and overrides.Disabled.Spell and overrides.Disabled.Spell[spellId] == true or false
end

-- ============================ CLASS ASSIGNMENT FUNCTIONS ============================

local function getAssignmentsGate()
    if ns.assignmentsGateEnabled == nil then
        ns.assignmentsGateEnabled = false
    end
    return ns.assignmentsGateEnabled
end

local function getAssignmentsGateLastEnable()
    if ns.assignmentsGateLastEnable == nil then
        ns.assignmentsGateLastEnable = 0
    end
    return ns.assignmentsGateLastEnable
end

local function updateAssignmentsGateLastEnable(timeSeconds)
    ns.assignmentsGateLastEnable = timeSeconds or 0
end

local function isAssignmentsGateExpired(now)
    local lastEnable = getAssignmentsGateLastEnable()
    if lastEnable <= 0 then
        return true
    end
    return (now - lastEnable) > ASSIGNMENT_GATE_TTL_SECONDS
end

--- Returns true when assignments are gated on by a rotation call.
--- @return boolean
function NAG:IsAssignmentsGateEnabled()
    if not getAssignmentsGate() then
        return false
    end
    local now = GetTime()
    if isAssignmentsGateExpired(now) then
        ns.assignmentsGateEnabled = false
        return false
    end
    return true
end

--- Enable the assignments gate (does not affect rotation execution).
--- @return boolean Always false so it never short-circuits rotation strings
function NAG:EnableAssignmentsGate()
    local now = GetTime()
    ns.assignmentsGateEnabled = true
    updateAssignmentsGateLastEnable(now)
    return false
end

--- Checks if class assignments are enabled for the current version.
--- Assignments are classic-only and disabled for MoP.
--- @param self ClassBase
--- @return boolean
function ClassBase:IsClassAssignmentsEnabled()
    if not Version or (Version.IsMoP and Version:IsMoP()) then
        return false
    end

    return (Version.IsClassicEra and Version:IsClassicEra())
        or (Version.IsSoD and Version:IsSoD())
        or (Version.IsTBC and Version:IsTBC())
        or (Version.IsWrath and Version:IsWrath())
        or (Version.IsCata and Version:IsCata())
end

--- Get the currently selected assignment ID (single-select).
--- @param self ClassBase
--- @return boolean
function ClassBase:AllowsMultipleAssignments()
    return (self.defaults
        and self.defaults.class
        and self.defaults.class.allowMultipleAssignments == true) or false
end

--- Get the currently selected assignment IDs (multi-select).
--- @param self ClassBase
--- @return table
function ClassBase:GetSelectedAssignmentIds()
    local assignments = self.defaults.class.classAssignments or {}
    local toggles = self.db.char.assignmentToggles or {}
    local selected = {}

    for _, assignment in ipairs(assignments) do
        if toggles[assignment.id] == true then
            tinsert(selected, assignment.id)
        end
    end

    return selected
end

--- Update stored assignment IDs for multi-select classes.
--- @param self ClassBase
function ClassBase:UpdateLastAssignmentIds()
    if not self:AllowsMultipleAssignments() then
        return
    end

    local selected = self:GetSelectedAssignmentIds()
    if #selected > 0 then
        self.db.char.lastAssignmentIds = selected
    else
        self.db.char.lastAssignmentIds = nil
    end
end

--- Get the currently selected assignment ID (single-select).
--- @param self ClassBase
--- @return string|nil
function ClassBase:GetSelectedAssignmentId()
    local assignments = self.defaults.class.classAssignments or {}
    local toggles = self.db.char.assignmentToggles or {}

    for _, assignment in ipairs(assignments) do
        if toggles[assignment.id] == true then
            return assignment.id
        end
    end

    return nil
end

--- Normalize assignment toggles to a single selection.
--- @param self ClassBase
function ClassBase:NormalizeAssignmentToggles()
    if not self.db.char.assignmentToggles then
        self.db.char.assignmentToggles = {}
    end

    if self:AllowsMultipleAssignments() then
        return
    end

    local assignments = self.defaults.class.classAssignments or {}
    local toggles = self.db.char.assignmentToggles
    local selectedId

    for _, assignment in ipairs(assignments) do
        if toggles[assignment.id] == true then
            selectedId = assignment.id
            break
        end
    end

    wipe(toggles)
    if selectedId then
        toggles[selectedId] = true
        self.db.char.lastAssignmentId = selectedId
    end
end

--- Set the selected assignment ID (single-select).
--- @param self ClassBase
--- @param assignmentId string|nil
function ClassBase:SetSelectedAssignmentId(assignmentId)
    if not self.db.char.assignmentToggles then
        self.db.char.assignmentToggles = {}
    end

    if self:AllowsMultipleAssignments() then
        if assignmentId then
            self.db.char.assignmentToggles[assignmentId] = true
        else
            wipe(self.db.char.assignmentToggles)
            self.db.char.lastAssignmentIds = nil
        end

        self:ApplyAssignmentToggles()

        if AceConfigRegistry then
            AceConfigRegistry:NotifyChange("NAG")
        end

        self:Debug("SetSelectedAssignmentId: Set '%s'", tostring(assignmentId))
        if assignmentId then
            local assignmentName = tostring(assignmentId)
            local assignments = self.defaults.class.classAssignments or {}
            for _, assignment in ipairs(assignments) do
                if assignment.id == assignmentId then
                    assignmentName = assignment.name or assignmentName
                    break
                end
            end
            self:Debug(string.format("Assignment set: %s", assignmentName))
        else
            self:Print("Assignments cleared.")
        end

        self:UpdateLastAssignmentIds()

        self:SendMessage("NAG_ASSIGNMENT_CHANGED", {
            assignmentId = assignmentId,
            enabled = assignmentId ~= nil
        })
        return
    end

    wipe(self.db.char.assignmentToggles)
    if assignmentId then
        self.db.char.assignmentToggles[assignmentId] = true
        self.db.char.lastAssignmentId = assignmentId
    else
        self.db.char.lastAssignmentId = nil
    end

    self:ApplyAssignmentToggles()

    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end

    self:Debug("SetSelectedAssignmentId: Set '%s'", tostring(assignmentId))
    if assignmentId then
        local assignmentName = tostring(assignmentId)
        local assignments = self.defaults.class.classAssignments or {}
        for _, assignment in ipairs(assignments) do
            if assignment.id == assignmentId then
                assignmentName = assignment.name or assignmentName
                break
            end
        end
        self:Print(string.format("Assignment set: %s", assignmentName))
    else
        self:Print("Assignment cleared.")
    end

    self:SendMessage("NAG_ASSIGNMENT_CHANGED", {
        assignmentId = assignmentId,
        enabled = assignmentId ~= nil
    })
end

--- Clear active assignments when not in a group (preserve last assignment).
--- @param self ClassBase
function ClassBase:ClearAssignmentsForNoGroup()
    local selected
    if self:AllowsMultipleAssignments() then
        selected = self:GetSelectedAssignmentIds()
        if #selected > 0 then
            self.db.char.lastAssignmentIds = selected
        else
            self.db.char.lastAssignmentIds = nil
        end
    else
        selected = self:GetSelectedAssignmentId()
        if selected then
            self.db.char.lastAssignmentId = selected
        end
    end

    if self.db.char.assignmentToggles then
        wipe(self.db.char.assignmentToggles)
    end

    self:ApplyAssignmentToggles()

    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end

    if selected and (type(selected) == "string" or #selected > 0) then
        self:Print("Assignments cleared (left group).")
    end
end

--- Ensure the assignment restore popup is registered.
--- @param self ClassBase
function ClassBase:EnsureAssignmentRestorePopup()
    if not StaticPopupDialogs or StaticPopupDialogs.NAG_ASSIGNMENT_RESTORE_CONFIRM then
        return
    end

    StaticPopupDialogs.NAG_ASSIGNMENT_RESTORE_CONFIRM = {
        text = L["assignmentRestorePrompt"] or "Use your previous assignment: %s?",
        button1 = L["assignmentRestoreUse"] or "Use Previous",
        button2 = L["assignmentRestoreNone"] or "Select None",
        hasCheckButton = true,
        checkButtonText = L["assignmentRestoreAlways"] or "Always use previous assignment when joining groups",
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1,
        OnShow = function(self, data)
            if self.checkButton and data and data.module and data.module.db and data.module.db.char then
                self.checkButton:SetChecked(data.module.db.char.autoRestoreAssignmentsOnJoin == true)
            end
        end,
        OnAccept = function(self, data)
            if data and data.module then
                if data.module.db and data.module.db.char and (self.checkButton and self.checkButton:GetChecked()) then
                    data.module.db.char.autoRestoreAssignmentsOnJoin = true
                end
                data.module:SetSelectedAssignmentId(data.assignmentId)
            end
        end,
        OnCancel = function(_, data)
            if data and data.module then
                data.module:SetSelectedAssignmentId(nil)
            end
        end,
    }
end

--- Show assignment selection dialog on group join.
--- @param self ClassBase
--- @param assignmentId string
function ClassBase:ShowAssignmentSelectionDialog(assignmentId)
    if not AceGUI then
        return
    end

    if self:AllowsMultipleAssignments() then
        return
    end

    if self.assignmentSelectionDialog and self.assignmentSelectionDialog.frame
        and self.assignmentSelectionDialog.frame:IsShown() then
        return
    end

    local assignments = self.defaults.class.classAssignments or {}
    local assignmentName = tostring(assignmentId)
    for _, assignment in ipairs(assignments) do
        if assignment.id == assignmentId then
            assignmentName = assignment.name or assignmentName
            break
        end
    end

    local values = {
        none = L["assignmentNone"] or "None",
    }
    for _, assignment in ipairs(assignments) do
        values[assignment.id] = assignment.name
    end

    local dialog = AceGUI:Create("Frame")
    dialog:SetTitle(L["classAssignments"] or "Assignments")
    dialog:SetLayout("List")
    dialog:EnableResize(false)
    dialog:SetWidth(380)
    dialog:SetHeight(220)
    dialog:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.assignmentSelectionDialog == widget then
            self.assignmentSelectionDialog = nil
        end
    end)
    self.assignmentSelectionDialog = dialog

    local info = AceGUI:Create("Label")
    info:SetText(string.format(L["assignmentRestorePrompt"] or "Use your previous assignment: %s?", assignmentName))
    info:SetFullWidth(true)
    dialog:AddChild(info)

    local dropdown = AceGUI:Create("Dropdown")
    dropdown:SetLabel(L["assignmentSelect"] or "Assigned Ability")
    dropdown:SetList(values)
    dropdown:SetValue(assignmentId or "none")
    dropdown:SetFullWidth(true)
    dialog:AddChild(dropdown)

    local autoRestore = AceGUI:Create("CheckBox")
    autoRestore:SetLabel(L["assignmentRestoreAlways"] or "Always use previous assignment when joining groups")
    autoRestore:SetValue(self.db.char.autoRestoreAssignmentsOnJoin == true)
    autoRestore:SetFullWidth(true)
    dialog:AddChild(autoRestore)

    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetFullWidth(true)
    buttonGroup:SetLayout("Flow")
    dialog:AddChild(buttonGroup)

    local useButton = AceGUI:Create("Button")
    useButton:SetText(L["assignmentRestoreUse"] or "Use Previous")
    useButton:SetWidth(160)
    useButton:SetCallback("OnClick", function()
        local selected = dropdown:GetValue()
        if selected == "none" then
            self:SetSelectedAssignmentId(nil)
        else
            self:SetSelectedAssignmentId(selected)
        end
        self.db.char.autoRestoreAssignmentsOnJoin = autoRestore:GetValue() == true
        dialog:Hide()
    end)
    buttonGroup:AddChild(useButton)

    local noneButton = AceGUI:Create("Button")
    noneButton:SetText(L["assignmentRestoreNone"] or "Select None")
    noneButton:SetWidth(160)
    noneButton:SetCallback("OnClick", function()
        self:SetSelectedAssignmentId(nil)
        self.db.char.autoRestoreAssignmentsOnJoin = autoRestore:GetValue() == true
        dialog:Hide()
    end)
    buttonGroup:AddChild(noneButton)
end

--- Prompt the user to restore their previous assignment on group join.
--- @param self ClassBase
function ClassBase:PromptAssignmentRestore()
    if not self:IsClassAssignmentsEnabled() then
        return
    end

    if NAG.IsAssignmentsGateEnabled and not NAG:IsAssignmentsGateEnabled() then
        return
    end

    if self:AllowsMultipleAssignments() then
        local current = self:GetSelectedAssignmentIds()
        local last = self.db.char.lastAssignmentIds
        if last and #last > 0 and #current == 0 then
            if not self.db.char.assignmentToggles then
                self.db.char.assignmentToggles = {}
            end
            wipe(self.db.char.assignmentToggles)
            for _, assignmentId in ipairs(last) do
                self.db.char.assignmentToggles[assignmentId] = true
            end
            self:ApplyAssignmentToggles()
            if AceConfigRegistry then
                AceConfigRegistry:NotifyChange("NAG")
            end
        end
    else
        local assignmentId = self.db.char.lastAssignmentId
        if assignmentId and not self:GetSelectedAssignmentId() then
            self:SetSelectedAssignmentId(assignmentId)
        end
    end

    local FloatingSelector = NAG:GetModule("FloatingSelector", true)
    if FloatingSelector and FloatingSelector.ShowAssignmentReminder then
        FloatingSelector:ShowAssignmentReminder()
    end
end

--- Applies assignment toggles to blacklist system
--- When an assignment is disabled (another player is handling it), blacklist all spell IDs
--- When an assignment is enabled (this player handles it), remove from blacklist
--- @param self ClassBase
function ClassBase:ApplyAssignmentToggles()
    if not self:IsClassAssignmentsEnabled() then
        return
    end

    self:NormalizeAssignmentToggles()

    local assignments = self.defaults.class.classAssignments or {}
    for _, assignment in ipairs(assignments) do
        -- Assignments no longer control blacklisting; rotations decide.
        if assignment.spellIds then
            for _, spellId in ipairs(assignment.spellIds) do
                NAG:UnblacklistSpell(spellId)
            end
        end
    end
end

--- Toggle an assignment on/off
--- @param self ClassBase
--- @param assignmentId string The assignment ID to toggle
--- @param enabled boolean Whether the assignment is enabled
function ClassBase:ToggleAssignment(assignmentId, enabled)
    if self:AllowsMultipleAssignments() then
        if not self.db.char.assignmentToggles then
            self.db.char.assignmentToggles = {}
        end
        self.db.char.assignmentToggles[assignmentId] = enabled == true

        self:ApplyAssignmentToggles()

        if AceConfigRegistry then
            AceConfigRegistry:NotifyChange("NAG")
        end

        self:Debug("ToggleAssignment: %s = %s", tostring(assignmentId), tostring(enabled))
        local assignmentName = tostring(assignmentId)
        local assignments = self.defaults.class.classAssignments or {}
        for _, assignment in ipairs(assignments) do
            if assignment.id == assignmentId then
                assignmentName = assignment.name or assignmentName
                break
            end
        end
        if enabled then
            self:Print(string.format("Assignment set: %s", assignmentName))
        else
            self:Print(string.format("Assignment cleared: %s", assignmentName))
        end

        self:UpdateLastAssignmentIds()

        self:SendMessage("NAG_ASSIGNMENT_CHANGED", {
            assignmentId = assignmentId,
            enabled = enabled == true
        })
        return
    end

    if enabled then
        self:SetSelectedAssignmentId(assignmentId)
        return
    end

    local current = self:GetSelectedAssignmentId()
    if current == assignmentId then
        self:SetSelectedAssignmentId(nil)
    end
end


--- Gets current assignment toggle states
--- @param self ClassBase
--- @return table Assignment states { [assignmentId] = enabled }
function ClassBase:GetAssignmentStates()
    if not self:IsClassAssignmentsEnabled() then
        return {}
    end

    local assignments = self.defaults.class.classAssignments or {}
    local toggles = self.db.char.assignmentToggles or {}
    local states = {}

    for _, assignment in ipairs(assignments) do
        if assignment and assignment.id then
            local isEnabled = toggles[assignment.id]
            if isEnabled == nil then
                isEnabled = false -- Default: disabled (opt-in)
            end
            states[assignment.id] = isEnabled
        end
    end

    return states
end

-- ============================ DATA CLEANUP FUNCTIONS ============================

--- Cleans up malformed spell location data by wiping problematic tables
--- This prevents errors from old data format issues
function ClassBase:CleanupMalformedSpellLocations()
    self:Debug("=== Starting spell location data cleanup ===")

    local cleaned = 0

    -- Clean up rotation-specific spell locations
    local rotations = self.db.class.rotations
    for specIndex, specRotations in pairs(rotations) do
        if type(specRotations) == "table" then
            for rotationName, rotationConfig in pairs(specRotations) do
                if type(rotationConfig) == "table" and rotationConfig.spellLocations then
                    if self:IsSpellLocationsMalformed(rotationConfig.spellLocations) then
                        self:Warn("Found malformed spell locations in rotation '" ..
                            rotationName .. "' for spec " .. specIndex .. ", wiping data")
                        rotationConfig.spellLocations = {}
                        rotationConfig.userModified = true

                        -- Save the cleaned rotation
                        local success, err = self:SaveUserRotation(specIndex, rotationName, rotationConfig)
                        if not success then
                            self:Warn("Failed to save cleaned rotation '" .. rotationName .. "': " .. tostring(err))
                        end
                        cleaned = cleaned + 1
                    end
                end
            end
        end
    end

    -- Clean up spec-level spell locations
    local specSpellLocations = self.db.class.specSpellLocations
    for specIndex, specLocations in pairs(specSpellLocations) do
        if type(specLocations) == "table" and self:IsSpellLocationsMalformed(specLocations) then
            self:Warn("Found malformed spec spell locations for spec " .. specIndex .. ", wiping data")
            self:SetSetting("class", "specSpellLocations." .. specIndex, {})
            cleaned = cleaned + 1
        end
    end

    if cleaned > 0 then
        self:Info("Spell location cleanup completed: " .. cleaned .. " malformed tables wiped")
        self:Info("System will rebuild spell locations with correct format on next use")
    else
        self:Debug("No malformed spell location data found")
    end

    self:Debug("=== Spell location data cleanup completed ===")
    return cleaned
end

--- Checks if spell locations table has malformed data (old format)
--- @param spellLocations table The spell locations table to check
--- @return boolean True if the data is malformed
function ClassBase:IsSpellLocationsMalformed(spellLocations)
    if not spellLocations or type(spellLocations) ~= "table" then
        return false
    end

    -- Check for old format: position as key, array of spell IDs as value
    for key, value in pairs(spellLocations) do
        if type(value) == "table" and (key == "LEFT" or key == "RIGHT" or key == "ABOVE" or key == "BELOW" or key == "AOE" or key == "PRIMARY" or key == "SEQUENCE" or key == "IGNORE") then
            return true
        end
    end

    return false
end

-- ============================ MODULE INITIALIZATION ============================
