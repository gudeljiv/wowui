--- @module "NAG.CoreModule"
--- Core base class for all modules in NAG
---
--- ZERO-BOILERPLATE SYSTEM INTEGRATION:
--- =====================================
--- This module implements zero-boilerplate system integration. Modules automatically
--- integrate with all systems through declarative configuration, not manual code.
---
--- AUTOMATIC INTEGRATION POINTS:
--- - Database: Automatic namespace registration with defaults
--- - Options: Automatic registration via optionsComposers table in mixins (preferred) or GetOptions()
--- - Events: Automatic registration via events table in mixins
--- - Messages: Automatic registration via messageHandlers table in mixins
--- - Reset Preservation: Automatic registration via preservationGroups table in mixins
--- - Debug: Automatic category assignment based on module type
--- - Lifecycle: Automatic enable/disable based on module type and saved state
---
--- DECLARATIVE CONFIGURATION EXAMPLE:
--- ```lua
--- local MyModule = NAG:CreateModule("MyModule", defaults, {
---     -- Automatic event registration
---     eventHandlers = {
---         ["COMBAT_LOG_EVENT_UNFILTERED"] = true,
---         ["UNIT_AURA"] = "OnUnitAuraChanged",
---         ["PLAYER_REGEN_DISABLED"] = true,   -- If same logic, don't duplicate just call instead of true the 'extra'
---         ["PLAYER_REGEN_ENABLED"] = "PLAYER_REGEN_DISABLED",
---     },
---     -- Automatic message registration as needed
---     messageHandlers = {
---         ["NAG_ROTATION_CHANGED"] = true,
---         ["NAG_SPEC_UPDATED"] = true,
---         ["NAG_SETTING_CHANGED"] = true,
---

---     },
---     -- Automatic options registration (preferred mixin approach)
---     optionsComposers = {
---         ["splash"] = true,  -- Calls MyModule:splash(options, context)
---     },
---     -- Automatic reset preservation registration
---     preservationGroups = {
---         ["myModuleData"] = {
---             name = "My Module Data",
---             description = "Preserve important module data during resets",
---             settings = {
---                 char = {"moduleSettings", "userPreferences"},
---                 class = {"classSpecificData"}
---             },
---             alwaysPreserve = false
---         }
---     },
---     optionsCategory = ns.MODULE_CATEGORIES.FEATURE, -- From core.lua ns.MODULE_CATEGORIES.FEATURE
---     -- Automatic debug category assignment
---     debugCategories = {ns.DEBUG_CATEGORIES.FEATURES},
--- })
---
--- -- Everything happens automatically:
--- -- ✅ EventManager integration
--- -- ✅ Options registration (via mixins)
--- -- ✅ Database setup
--- -- ✅ Event registration
--- -- ✅ Message registration
--- -- ✅ Reset preservation registration
--- -- ✅ Debug category assignment
--- -- ✅ Lifecycle management
--- ```
---
--- OPTIONAL CUSTOM LIFECYCLE:
--- - ModuleInitialize(): Only implement if custom initialization needed
--- - ModuleEnable(): Only implement if custom enabling logic needed
--- - ModuleDisable(): Only implement if custom cleanup needed
--- - Most modules don't need these methods - everything is automatic
---
--- Provides essential functionality shared by all module types:
--- - Logging methods
--- - Database access methods (unified setting access with dot notation)
--- - Slash command registration
--- - Utility methods
--- - Basic lifecycle management
---
--- Database Access Methods:
--- - Primary: GetSetting(namespace, key) and SetSetting(namespace, key, value)
--- - Supports dot notation for nested access (e.g., "overlayConfigs.cancel.texture")
--- - Namespaces: "global", "char", "class"
--- - Each module gets its own namespace within the shared database (proper Ace3 pattern)
--- - Bulk operations: GetAllSettings(namespace) for iteration, GetNamespace(namespace) for debugging
---
--- Database Namespace System:
--- - ALL modules automatically register their own namespace with the main database during OnInitialize()
--- - This provides proper isolation while maintaining a shared database structure
--- - Module namespaces are registered using NAG.db:RegisterNamespace(moduleName, defaults)
--- - All database access methods work with the module's registered namespace
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local L = ns.AceLocale:GetLocale("NAG")
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

-- Enhanced error handling
local pcall = ns.pcall
---@type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- These will be assigned in OnEnable to avoid expensive metatable access
-- Using module-level variables so they're accessible to inheriting modules

--- @type ProfilingUtility
--- @type OptionsManager
--- @type ResetManager
--- @type EventManager
local ProfilingUtility, OptionsManager, ResetManager, EventManager

--- @type DebugManager
local DebugManager = ns.DebugManager

local TableUtils = ns.TableUtils
local DatabaseUtils = ns.DatabaseUtils
-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring

-- Ace3 APIs
local AceConfigRegistry = ns.AceConfigRegistry

local tinsert = tinsert
local wipe = wipe

local function trackMessageSent(module, messageName)
    if type(messageName) ~= "string" then
        return
    end
    local manager = EventManager or NAG:GetModule("EventManager", true)
    if manager and manager.TrackMessageSent then
        local moduleName = (module and module.GetName and module:GetName()) or "unknown"
        manager:TrackMessageSent(messageName, moduleName)
    end
end

local function trackMessageReceived(module, messageName)
    if type(messageName) ~= "string" then
        return
    end
    local manager = EventManager or NAG:GetModule("EventManager", true)
    if manager and manager.TrackMessageReceived then
        local moduleName = (module and module.GetName and module:GetName()) or "unknown"
        manager:TrackMessageReceived(messageName, moduleName)
    end
end

-- ============================ CONTENT ============================

--- @class CoreModule : AceAddon, AceModule, AceEvent-3.0
--- @field defaults? table Module-specific database defaults
--- @field ModuleInitialize? function Called after OnInitialize for module-specific initialization
--- @field ModuleEnable? function Called after OnEnable for module-specific enabling
--- @field ModuleDisable? function Called after OnDisable for module-specific cleanup
local CoreModule = {}

-- ============================ LOGGING METHODS ============================

--- Override Print function to use unified logging with aliases
--- @param self CoreModule
--- @param ... any Variable arguments to print
function CoreModule:Print(...)
    ns.UnifiedPrint(self, ...)
end

--- Debug logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function CoreModule:Debug(msg, ...)
    DebugManager:debug(self, msg, ...)
end

--- Info logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function CoreModule:Info(msg, ...)
    DebugManager:info(self, msg, ...)
end

--- Warning logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function CoreModule:Warn(msg, ...)
    DebugManager:warn(self, msg, ...)
end

--- Error logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function CoreModule:Error(msg, ...)
    DebugManager:error(self, msg, ...)
end

--- Trace logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function CoreModule:Trace(msg, ...)
    DebugManager:trace(self, msg, ...)
end

-- ============================ DEVELOPER DEBUG METHODS ============================














-- ============================ STANDARD THROTTLED METHODS ============================

--- Throttled debug logging (reduces spam in update-heavy modules)
--- @param self CoreModule
--- @param msg string The message to log
--- @param throttleKey string Unique identifier for this message
--- @param throttleInterval number Minimum seconds between logs (default: 1.0)
--- @param ... any Additional arguments to format
function CoreModule:ThrottledDebug(msg, throttleKey, throttleInterval, ...)
    DebugManager:throttled_debug(self, msg, throttleKey, throttleInterval, ...)
end

--- Throttled info logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param throttleKey string Unique identifier for this message
--- @param throttleInterval number Minimum seconds between logs (default: 1.0)
--- @param ... any Additional arguments to format
function CoreModule:ThrottledInfo(msg, throttleKey, throttleInterval, ...)
    DebugManager:throttled_info(self, msg, throttleKey, throttleInterval, ...)
end

--- Throttled warning logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param throttleKey string Unique identifier for this message
--- @param throttleInterval number Minimum seconds between logs (default: 1.0)
--- @param ... any Additional arguments to format
function CoreModule:ThrottledWarn(msg, throttleKey, throttleInterval, ...)
    DebugManager:throttled_warn(self, msg, throttleKey, throttleInterval, ...)
end

--- Throttled error logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param throttleKey string Unique identifier for this message
--- @param throttleInterval number Minimum seconds between logs (default: 1.0)
--- @param ... any Additional arguments to format
function CoreModule:ThrottledError(msg, throttleKey, throttleInterval, ...)
    DebugManager:throttled_error(self, msg, throttleKey, throttleInterval, ...)
end

--- Throttled trace logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param throttleKey string Unique identifier for this message
--- @param throttleInterval number Minimum seconds between logs (default: 1.0)
--- @param ... any Additional arguments to format
function CoreModule:ThrottledTrace(msg, throttleKey, throttleInterval, ...)
    DebugManager:throttled_trace(self, msg, throttleKey, throttleInterval, ...)
end

--- General logging
--- @param self CoreModule
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function CoreModule:Log(msg, ...)
    DebugManager:log(self, msg, ...)
end

--- Debug logging (direct to DebugManager)
--- @param self CoreModule
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function CoreModule:DebugLog(msg, ...)
    NAG.DebugLog(self, msg, ...)
end

-- ============================ BASIC LIFECYCLE METHODS ============================

--- Called when the module is initialized
--- @param self CoreModule
function CoreModule:OnInitialize()
    --self:Info("Initializing core module: " .. self:GetName())
    -- Assign module references for performance (accessible to inheriting modules)
    ProfilingUtility = NAG:GetModule("ProfilingUtility")
    OptionsManager = NAG:GetModule("OptionsManager")
    ResetManager = NAG:GetModule("ResetManager")
    EventManager = NAG:GetModule("EventManager")

    if not self.__registeredEvents then
        self.__registeredEvents = {}
    end
    if not self.__registeredMessages then
        self.__registeredMessages = {}
    end

    -- ✅ PRE-DATABASE: Allow modules to modify defaults before registration
    if self.PreDatabaseRegistration then
        self:PreDatabaseRegistration()
    end

    -- Initialize database and register for reset events
    local dbRoot = NAG.db
    if self.databaseRoot == "leaderboard" then
        dbRoot = NAG.leaderboardDbRoot
    end
    if type(dbRoot) ~= "table" or type(dbRoot.RegisterNamespace) ~= "function" then
        error("OnInitialize: missing database root for module '" .. tostring(self:GetName()) ..
            "' (databaseRoot=" .. tostring(self.databaseRoot or "default") .. ")", 2)
    end
    self.db = dbRoot:RegisterNamespace(self:GetName(), self.defaults or {})

    -- Only log warnings if database types are wrong (actual problems)
    if not self.db then
        self:Warn("OnInitialize: Failed to register namespace for " .. self:GetName() .. " - database is nil")
    elseif type(self.db) ~= "table" then
        self:Warn("OnInitialize: Database type mismatch for " ..
            self:GetName() .. " - expected table, got " .. type(self.db))
    end

    self:RegisterMessage("NAG_DB_RESET", "OnDatabaseReset")

    -- Process options composers AFTER ModuleInitialize (prefer mixin approach, function-based is deprecated)
    -- This ensures all module methods are defined before registration
    self:RegisterOptionsComposers()

    -- ZERO-BOILERPLATE: Register preservation groups (automatic reset preservation registration)
    self:RegisterPreservationGroups()

    if self.ModuleInitialize then
        self:ModuleInitialize()
    end


    -- Skip initialization for class modules if not the right class
    if self.moduleType == ns.MODULE_TYPES.CLASS and select(2, UnitClass("player")) ~= self.className then
        self:Debug("Skipping OnInitialize for module " ..
            self:GetName() ..
            " (required class: " .. self.className .. ", player class: " .. select(2, UnitClass("player")) .. ")")
        return
    end

    -- For CORE and FEATURE modules, use database value with fallback through namespaces
    if (self.moduleType == ns.MODULE_TYPES.CORE or self.moduleType == ns.MODULE_TYPES.FEATURE) and self.db then
        local enabled = self:GetSettingWithFallback("enabled", self.defaults.global.enabled)
        self:SetEnabledState(enabled)
    end

    -- DEBUG modules should always start disabled and not save their enabled state
    if self.moduleType == ns.MODULE_TYPES.DEBUG then
        self:SetEnabledState(false) -- Always disabled on reload for performance
    end

    self:InitializeState()
    self:RegisterMessageHandlers()
    self:RegisterSlashCommands()

    -- LIFECYCLE: Slash commands and message handlers are registered in OnInitialize so they
    -- exist even when the module is disabled (e.g. /nag pvptracker can enable the module).
    -- Events and frame creation belong in OnEnable so they only run when the module is enabled.
    -- Message handlers that create/update UI should guard with self:IsEnabled() and return if disabled.
end

--- Called when the module is enabled
--- @param self CoreModule
function CoreModule:OnEnable()
    self:Info("Enabling core module: " .. self:GetName())

    -- Check for debug mode and alert if enabled (independent of dev mode)
    if self.debug then
        self:Info("Module '%s' has debugging enabled", self:GetName())
    end

    self:InitializeState()

    self:RegisterEventHandlers()

    if self.ModuleEnable then
        self:ModuleEnable()
    end
end

--- Called when the module is disabled
--- @param self CoreModule
function CoreModule:OnDisable()
    self:Info("Disabling core module: " .. self:GetName())


    -- Reset state when disabled
    self:ResetState()

    -- ZERO-BOILERPLATE: Unregister events when module is disabled
    -- Events should not be active when the module is disabled
    self:UnregisterEventHandlers()

    -- ZERO-BOILERPLATE: Keep messages registered (for internal communication)
    -- Messages are internal addon communication and may be needed for enable/disable requests
    -- self:UnregisterMessageHandlers() -- REMOVED: Keep messages active

    -- ZERO-BOILERPLATE: Call module-specific cleanup only if needed
    -- Most modules don't need custom cleanup - everything is automatic
    if self.ModuleDisable then
        self:ModuleDisable()
    end
end

-- ============================ DATABASE METHODS ============================

--- Gets the database
--- @param self CoreModule
--- @return AceDBObject-3.0|nil The database
function CoreModule:GetDB()
    if not NAG or not NAG.db then
        self:Error("GetDB called before database is initialized")
        return nil
    end
    return NAG.db
end

--- Reattaches module defaults to the DB (AceDB RegisterDefaults wrapper)
--- Use this after wiping a subtree so defaults are re-applied non-destructively
--- @param self CoreModule
function CoreModule:ReattachDefaults()
    if not self.db then return end
    if not self.defaults then return end
    self.db:RegisterDefaults(self.defaults)
end

--- Gets all settings for a namespace (for iteration/bulk operations)
--- @param self CoreModule
--- @param namespace string The database namespace ("global", "char", "class")
--- @return table All settings in the namespace
function CoreModule:GetAllSettings(namespace)
    if not self.db then
        self:Debug("GetAllSettings called before database is initialized: " .. tostring(namespace))
        return {}
    end
    return DatabaseUtils.GetAllSettings(self.db, namespace)
end

--- Gets the raw namespace table (for debugging/inspection)
--- @param self CoreModule
--- @param namespace string The database namespace ("global", "char", "class")
--- @return table The raw namespace table
function CoreModule:GetNamespace(namespace)
    if not self.db then
        self:Debug("GetNamespace called before database is initialized: " .. tostring(namespace))
        return {}
    end
    return DatabaseUtils.GetNamespace(self.db, namespace)
end

-- ============================ DIRECT SETTING ACCESS METHODS ============================

--- Gets a setting value using dot notation (e.g., "char.appearance.iconSize")
--- @param self CoreModule
--- @param namespace string The database namespace ("global", "char", "class")
--- @param ... string|any Variable arguments: either (key, defaultValue) for old pattern or (key1, key2, ..., value) for new pattern
--- @return any The setting value
function CoreModule:GetSetting(namespace, ...)
    -- Check if database is initialized
    if not self.db then
        local moduleName = self.GetName and self:GetName() or tostring(self)
        -- Use debug logging instead of print to avoid spam
        if self.Debug then
            self:Debug("GetSetting called before database initialization - returning default value")
        else
            -- Fallback to print if Debug method not available
            print("|cffff0000[NAG] GetSetting - Database not initialized for module: " .. moduleName .. "|r")
        end
        return select(-1, ...) -- Return the last argument as default
    end

    -- Use consolidated smart utility that automatically resolves defaults
    return ns.DatabaseUtils.GetSetting(self.db, namespace, ...)
end

--- Sets a setting value using dot notation (e.g., "char.appearance.iconSize")
--- @param self CoreModule
--- @param namespace string The database namespace ("global", "char", "class")
--- @param ... string|any Variable arguments: either (key, value) for old pattern or (key1, key2, ..., value) for new pattern
function CoreModule:SetSetting(namespace, ...)
    -- Check if database is initialized
    if not self.db then
        local moduleName = self.GetName and self:GetName() or tostring(self)
        -- Use debug logging instead of print to avoid spam
        if self.Debug then
            self:Debug("SetSetting called before database initialization - ignoring")
        else
            -- Fallback to print if Debug method not available
            print("|cffff0000[NAG] SetSetting - Database not initialized for module: " .. moduleName .. "|r")
        end
        return
    end

    -- Use shared utility for consistent setting access
    return ns.DatabaseUtils.SetSetting(self.db, namespace, ...)
end

--- Gets a setting value with fallback through multiple namespaces
--- @param self CoreModule
--- @param key string The setting key to get
--- @param defaultValue any The default value if not found in any namespace
--- @param namespaces? table Array of namespaces to check in order (default: {"char", "class", "global"})
--- @return any The setting value from the first namespace that has it, or defaultValue
function CoreModule:GetSettingWithFallback(key, defaultValue, namespaces)
    -- Check if database is initialized
    if not self.db then
        local moduleName = self.GetName and self:GetName() or tostring(self)
        if self.Debug then
            self:Debug("GetSettingWithFallback called before database initialization - returning default value")
        else
            print("|cffff0000[NAG] GetSettingWithFallback - Database not initialized for module: " .. moduleName .. "|r")
        end
        return defaultValue
    end

    -- Use shared utility for consistent fallback behavior
    return ns.DatabaseUtils.GetSettingWithFallback(self.db, key, defaultValue, namespaces)
end

-- ============================ SLASH COMMAND REGISTRATION ============================

--- Registers a standalone slash command for the module and adds it to the central help registry
--- Prefer declarative `slashCommands` + `root` for routed subcommands under /nag or /nagdebug.
--- @param self CoreModule
--- @param cmd string The slash command (without leading slash)
--- @param handler function|string The function to handle the command, or the name of a method on the module
--- @param help string|nil Optional help/usage string
--- @param context table|nil Optional context object (defaults to self if not specified)
function CoreModule:RegisterSlashCommand(cmd, handler, help, context)
    context = context or self
    return ns.ChatCommandUtils.RegisterCommand(context, cmd, handler, help)
end

--- Unified chat command registration for multiple commands
--- @param self CoreModule
--- @param commands table Table of command definitions: {{command, handler, help}, ...}
function CoreModule:RegisterCommands(commands)
    return ns.ChatCommandUtils.RegisterCommands(self, commands)
end

-- ============================ INITIALIZATION HELPER FUNCTIONS ============================

--- Initialize options composers (prefer mixin approach, function-based is deprecated)
function CoreModule:RegisterOptionsComposers()
    if self.optionsComposers and type(self.optionsComposers) == "table" then
        -- OptionsManager is guaranteed to be available due to TOC load order
        for targetPath, composer in pairs(self.optionsComposers) do
            if composer == true then
                -- If composer is true, use the targetPath as the method name
                if self[targetPath] then
                    local order = self.optionsComposerOrder or 100
                    -- Store method name for internal method binding (like Ace3 does)
                    OptionsManager:RegisterOptionsComposer(targetPath, targetPath, self, order)
                    self:Debug("Registered composer for path: " .. targetPath .. " using method: " .. targetPath)
                else
                    self:Error("Options composer method '%s' not found for path '%s'", targetPath, targetPath)
                end
            elseif type(composer) == "string" and self[composer] then
                -- If composer is a string, use the corresponding method
                local order = self.optionsComposerOrder or 100
                -- Store method name for internal method binding (like Ace3 does)
                OptionsManager:RegisterOptionsComposer(targetPath, composer, self, order)
                self:Debug("Registered composer for path: " .. targetPath .. " using method: " .. composer)
            elseif type(composer) == "function" then
                -- If composer is a function, register it directly
                local order = self.optionsComposerOrder or 100
                OptionsManager:RegisterOptionsComposer(targetPath, composer, self, order)
                self:Debug("Registered composer for path: " .. targetPath)
            end
        end
    end
end

--- Register preservation groups (automatic reset preservation registration)
function CoreModule:RegisterPreservationGroups()
    -- ZERO-BOILERPLATE: Register preservation groups via preservationGroups table in mixins
    if self.preservationGroups and type(self.preservationGroups) == "table" then
        if ResetManager then
            for groupName, groupConfig in pairs(self.preservationGroups) do
                if type(groupConfig) == "table" and groupConfig.name and groupConfig.description and groupConfig.settings then
                    ResetManager:RegisterPreservationGroup(groupName, groupConfig, self:GetName())
                    self:Debug("Registered preservation group: " .. groupName)
                else
                    self:Error("Invalid preservation group configuration for: " .. tostring(groupName))
                end
            end
        else
            self:Debug("ResetManager not available - skipping preservation group registration")
        end
    end
end

-- ============================ PROFILING SUPPORT ============================

--- Dynamically wraps all public methods of the module with profiling hooks.
--- @param self CoreModule
--- @param opts? table Options: { include = {"Method1", ...}, exclude = {"Method2", ...} }
function CoreModule:EnableProfiling(opts)
    -- Prevent profiling the ProfilingUtility module itself
    if self.GetName and self:GetName() == "ProfilingUtility" then
        return
    end
    if self.__profiled_methods then return end -- Already enabled
    self.__profiled_methods = {}

    opts = opts or {}
    local include = opts.include
    -- Always exclude these core methods
    local default_exclude = {
        -- Core module methods
        GetName = true,
        EnableProfiling = true,
        DisableProfiling = true,
        -- Ace3/AceAddon-3.0 methods
        Enable = true,
        Disable = true,
        EnableModule = true,
        DisableModule = true,
        GetModule = true,
        IsEnabled = true,
        SetDefaultModuleLibraries = true,
        SetDefaultModuleState = true,
        SetDefaultModulePrototype = true,
        SetEnabledState = true,
        IterateModules = true,
        IterateEmbeds = true,
    }
    local exclude = {}
    if opts.exclude then
        for _, name in ipairs(opts.exclude) do exclude[name] = true end
    end
    for k, v in pairs(self) do
        if type(v) == "function"
            and not k:match("^_")
            and not default_exclude[k]
            and (not include or tContains(include, k))
            and not exclude[k]
        then
            self.__profiled_methods[k] = v
            self[k] = function(self, ...)
                ProfilingUtility:StartProfiling((self.GetName and self:GetName() or tostring(self)) .. ":" .. k)
                local results = { pcall(v, self, ...) }
                ProfilingUtility:StopProfiling()
                if not results[1] then error(results[2]) end
                table.remove(results, 1)
                return unpack(results)
            end
        end
    end
end

--- Restores all methods wrapped by EnableProfiling to their original versions.
--- @param self CoreModule
function CoreModule:DisableProfiling()
    if not self.__profiled_methods then return end
    for k, v in pairs(self.__profiled_methods) do
        self[k] = v
    end
    self.__profiled_methods = nil
end

-- ============================ UTILITY METHODS ============================

local function GetTimerManager()
    return ns.TimerManager or NAG:GetModule("TimerManager", true)
end

local function BuildTimerCallback(self, funcOrMethod)
    if type(funcOrMethod) == "function" then
        return funcOrMethod
    end
    if type(funcOrMethod) == "string" then
        local method = funcOrMethod
        return function(...)
            if self and self[method] then
                return self[method](self, ...)
            end
        end
    end
    return nil
end

function CoreModule:_TrackTimerHandle(handle)
    if not handle then
        return
    end
    self._nagTimerHandles = self._nagTimerHandles or {}
    self._nagTimerHandles[handle] = true
end

function CoreModule:_UntrackTimerHandle(handle)
    if not handle or not self._nagTimerHandles then
        return
    end
    self._nagTimerHandles[handle] = nil
end

--- Schedule a one-shot timer (AceTimer-compatible).
--- Uses `TimerManager` as the shared scheduler so modules don't need to embed AceTimer.
--- @param self CoreModule
--- @param funcOrMethod function|string Callback or method name on self
--- @param delay number Delay in seconds
--- @param ... any Optional callback args
--- @return any timerHandle Timer handle (cancel with `:CancelTimer(handle)`)
function CoreModule:ScheduleTimer(funcOrMethod, delay, ...)
    local TimerManager = GetTimerManager()
    if not TimerManager then
        return nil
    end
    local cb = BuildTimerCallback(self, funcOrMethod)
    if not cb then
        return nil
    end
    local handle = TimerManager:ScheduleTimer(cb, delay, ...)
    self:_TrackTimerHandle(handle)
    return handle
end

--- Schedule a repeating timer (AceTimer-compatible).
--- @param self CoreModule
--- @param funcOrMethod function|string Callback or method name on self
--- @param delay number Delay/interval in seconds
--- @param ... any Optional callback args
--- @return any timerHandle Timer handle (cancel with `:CancelTimer(handle)`)
function CoreModule:ScheduleRepeatingTimer(funcOrMethod, delay, ...)
    local TimerManager = GetTimerManager()
    if not TimerManager then
        return nil
    end
    local cb = BuildTimerCallback(self, funcOrMethod)
    if not cb then
        return nil
    end
    local handle = TimerManager:ScheduleRepeatingTimer(cb, delay, ...)
    self:_TrackTimerHandle(handle)
    return handle
end

--- Cancel a timer by handle (AceTimer-compatible).
--- @param self CoreModule
--- @param handle any
function CoreModule:CancelTimer(handle)
    if not handle then
        return false
    end
    local TimerManager = GetTimerManager()
    if not TimerManager then
        return false
    end
    self:_UntrackTimerHandle(handle)
    return TimerManager:CancelTimer(handle)
end

--- Cancel all timers scheduled via CoreModule timer wrappers.
--- @param self CoreModule
function CoreModule:CancelAllTimers()
    if not self._nagTimerHandles then
        return
    end
    local TimerManager = GetTimerManager()
    if not TimerManager then
        self._nagTimerHandles = nil
        return
    end
    for handle in pairs(self._nagTimerHandles) do
        TimerManager:CancelTimer(handle)
    end
    self._nagTimerHandles = nil
end

--- Get time left for a timer handle.
--- @param self CoreModule
--- @param handle any
--- @return number
function CoreModule:TimeLeft(handle)
    local TimerManager = GetTimerManager()
    if not TimerManager then
        return 0
    end
    return TimerManager:TimeLeft(handle)
end

--- Counts keys in a table (wrapper around TableUtils.Size)
--- @param self CoreModule
--- @param tbl table The table to count
--- @return number Number of keys
function CoreModule:CountTableKeys(tbl)
    return TableUtils.Size(tbl)
end

--- Safely gets a nested table value
--- @param self CoreModule
--- @param tbl table The table to search
--- @param ... string The path to the value
--- @return any The value at the path, or nil if not found
function CoreModule:GetNestedValue(tbl, ...)
    local current = tbl
    for _, key in ipairs({ ... }) do
        if type(current) == "table" and current[key] ~= nil then
            current = current[key]
        else
            return nil
        end
    end
    return current
end

--- Safely sets a nested table value
--- @param self CoreModule
--- @param tbl table The table to modify
--- @param value any The value to set
--- @param ... string The path to the value
function CoreModule:SetNestedValue(tbl, value, ...)
    local keys = { ... }
    local current = tbl

    -- Navigate to the parent of the target key
    for i = 1, #keys - 1 do
        local key = keys[i]
        if type(current[key]) ~= "table" then
            current[key] = {}
        end
        current = current[key]
    end

    -- Set the final value
    if #keys > 0 then
        current[keys[#keys]] = value
    end
end

-- ============================ DEBUG CATEGORY MANAGEMENT ============================

--- Gets the debug categories for this module
--- @param self CoreModule
--- @return table Array of debug category strings
function CoreModule:GetDebugCategories()
    if self.debugCategories then
        return self.debugCategories
    end

    -- Return default category based on module type
    local defaultCategory = ns.DEFAULT_DEBUG_CATEGORY_BY_TYPE[self.moduleType] or ns.DEBUG_CATEGORIES.GENERAL
    return { defaultCategory }
end

--- Checks if debug is enabled for any of this module's debug categories
--- @param self CoreModule
--- @return boolean Whether debug is enabled for this module's categories
function CoreModule:IsDebugEnabledForCategories()
    local categories = self:GetDebugCategories()

    -- Check if any of the module's categories are enabled
    for _, category in ipairs(categories) do
        local categoryEnabled = DatabaseUtils.GetSetting(OptionsManager.db, "global", "debugCategories." .. category)
        if categoryEnabled then
            return true
        end
    end

    return false
end

--- Checks if debug is enabled for a specific category
--- @param self CoreModule
--- @param category string The debug category to check
--- @return boolean Whether debug is enabled for this category
function CoreModule:IsDebugEnabledForCategory(category)
    return DatabaseUtils.GetSetting(OptionsManager.db, "global", "debugCategories." .. category)
end

--- Enables debug for a specific category
--- @param self CoreModule
--- @param category string The debug category to enable
function CoreModule:EnableDebugForCategory(category)
    DatabaseUtils.SetSetting(OptionsManager.db, "global", "debugCategories." .. category, true)
    self:Info("Debug enabled for category: %s", category)
end

--- Disables debug for a specific category
--- @param self CoreModule
--- @param category string The debug category to disable
function CoreModule:DisableDebugForCategory(category)
    DatabaseUtils.SetSetting(OptionsManager.db, "global", "debugCategories." .. category, false)
    self:Info("Debug disabled for category: %s", category)
end

--- Gets all available debug categories
--- @param self CoreModule
--- @return table Array of all debug category strings
function CoreModule:GetAllDebugCategories()
    local categories = {}
    for _, category in pairs(ns.DEBUG_CATEGORIES) do
        tinsert(categories, category)
    end
    return categories
end

--- Gets modules that belong to a specific debug category
--- @param self CoreModule
--- @param category string The debug category to search
--- @return table Array of module names that belong to this category
function CoreModule:GetModulesInCategory(category)
    local modules = {}

    if not NAG or not NAG.modules then
        return modules
    end

    for moduleName, module in pairs(NAG.modules) do
        if module.GetDebugCategories then
            local moduleCategories = module:GetDebugCategories()
            for _, moduleCategory in ipairs(moduleCategories) do
                if moduleCategory == category then
                    tinsert(modules, moduleName)
                    break
                end
            end
        end
    end

    return modules
end

-- ============================ OPTIONS REGISTRATION ============================

--- Creates unified developer options for this module (only shown when dev mode is enabled)
--- @param self CoreModule
--- @return table|nil Developer options table, or nil if not applicable
function CoreModule:CreateDeveloperOptions()
    -- Only create developer options if dev mode is enabled
    if not NAG:IsDevModeEnabled() then
        return nil
    end

    local options = {
        developerHeader = {
            type = "header",
            name = L["developerHeader"] or "Developer Options",
            order = 999990,
        },
        developerDesc = {
            type = "description",
            name = L["developerDesc"] or "Developer controls for this module. These options are only visible when developer mode is enabled.",
            order = 999991,
            fontSize = "medium",
            width = "full",
        },
        developerGroup = {
            type = "group",
            name = "",
            order = 999992,
            inline = true,
            args = {}
        }
    }

    local currentOrder = 1

    -- Add debug options if this module supports it (or opt-in via mixin flag)
    local moduleName = self:GetName()

    -- Add debug options if this module supports it
    -- Show debug controls for any module that could support it (not explicitly disabled)
    local hasDebugSupport = (self.debug ~= false) -- Show if not explicitly disabled

    if hasDebugSupport then
        -- Check if any other module has debug enabled (for focus mode)
        local anyModuleEnabled = false
        local enabledModules = {}
        for modName, enabled in pairs(ns.devDebugModules or {}) do
            if enabled and modName ~= moduleName then
                anyModuleEnabled = true
                table.insert(enabledModules, modName)
            end
        end
        options.developerGroup.args.enableDebug = {
            type = "toggle",
            name = L["enableDebug"] or "Enable Debug",
            desc =
            "Enable detailed debugging for this module. This will show verbose debug output including trace messages.",
            order = currentOrder,
            width = "default",
            get = function()
                return ns.DevDebugUtils.IsDebugEnabled(NAG, self:GetName())
            end,
            set = function(_, value)
                if value then
                    ns.DevDebugUtils.EnableDebug(NAG, self:GetName())
                else
                    ns.DevDebugUtils.DisableDebug(NAG, self:GetName())
                end
                -- Update the module's debug flag
                self.debug = value
                -- Notify options UI of the change
                if AceConfigRegistry then
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end
        }
        currentOrder = currentOrder + 1

        options.developerGroup.args.debugStatus = {
            type = "description",
            name = function()
                local isEnabled = ns.DevDebugUtils.IsDebugEnabled(NAG, self:GetName())
                local status = isEnabled and "|cff00ff00Enabled|r" or "|cffff0000Disabled|r"

                -- Add focus mode info if other modules are enabled
                local anyModuleEnabled = false
                local enabledModules = {}
                for modName, enabled in pairs(ns.devDebugModules or {}) do
                    if enabled and modName ~= self:GetName() then
                        anyModuleEnabled = true
                        table.insert(enabledModules, modName)
                    end
                end

                if anyModuleEnabled then
                    status = status .. " |cffff9900(Focus Mode: " .. table.concat(enabledModules, ", ") .. " enabled)|r"
                end

                return format("Status: %s", status)
            end,
            order = currentOrder,
            width = "default",
            fontSize = "medium",
        }
        currentOrder = currentOrder + 1

        -- Add focus mode toggle if other modules are enabled
        if anyModuleEnabled then
            options.developerGroup.args.focusMode = {
                type = "toggle",
                name = L["focusMode"] or "Focus Mode",
                desc = format("Enable debug for this module (other modules enabled: %s)",
                    table.concat(enabledModules, ", ")),
                order = currentOrder,
                width = "default",
                get = function()
                    return ns.DevDebugUtils.IsDebugEnabled(NAG, self:GetName())
                end,
                set = function(_, value)
                    if value then
                        ns.DevDebugUtils.EnableDebug(NAG, self:GetName())
                    else
                        ns.DevDebugUtils.DisableDebug(NAG, self:GetName())
                    end
                    -- Update the module's debug flag
                    self.debug = value
                    -- Notify options UI of the change
                    if AceConfigRegistry then
                        AceConfigRegistry:NotifyChange("NAG")
                    end
                end
            }
            currentOrder = currentOrder + 1
        end
    end

    -- Add reset options
    options.developerGroup.args.resetModule = {
        type = "execute",
        name = format("Reset %s to Defaults", self:GetName()),
        desc = format("Reset all settings for %s to their default values. This action cannot be undone.", self:GetName()),
        order = currentOrder,
        width = "default",
        confirm = true,
        confirmText = format("Are you sure you want to reset all %s settings to defaults? This action cannot be undone.",
            self:GetName()),
        func = function()
            self:ResetModuleToDefaults()
        end
    }



    return options
end

--- Resets this module's settings to their default values
--- @param self CoreModule
function CoreModule:ResetModuleToDefaults()
    if not self.db then
        self:Error("Cannot reset module settings - database not initialized")
        return
    end

    self:Info("Resetting %s settings to defaults", self:GetName())

    -- Reset all namespaces for this module
    local moduleName = self:GetName()

    -- Get the module's namespace from the main database
    local moduleDB = NAG.db:GetNamespace(moduleName, true)
    if moduleDB then
        -- Reset each namespace
        if moduleDB.global then wipe(moduleDB.global) end
        if moduleDB.char then wipe(moduleDB.char) end
        if moduleDB.profile then wipe(moduleDB.profile) end
        if moduleDB.class then wipe(moduleDB.class) end

        -- Re-register defaults if the module has them
        if self.defaults then
            moduleDB:RegisterDefaults(self.defaults)
            self:Debug("Re-registered defaults for %s", moduleName)
        end
    else
        self:Error("Could not find database namespace for module %s", moduleName)
    end

    -- Call module-specific reset handler if it exists
    if self.ModuleResetToDefaults then
        self:ModuleResetToDefaults()
    end

    -- Notify options UI of the change
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end

    self:Info("Successfully reset %s settings to defaults", moduleName)
end

-- ============================ STATE MANAGEMENT ============================

--- Initializes the module's state
--- @param self CoreModule
function CoreModule:InitializeState()
    -- If module already has state, skip
    if self.state then return end

    -- Create state table
    self.state = {}

    -- If module has default state, copy it
    if self.defaultState then
        for k, v in pairs(self.defaultState) do
            if type(v) == "table" then
                self.state[k] = CopyTable(v)
            else
                self.state[k] = v
            end
        end
    end

    -- If module has custom init logic, call it
    if self.ModuleInitializeState then
        self:ModuleInitializeState()
    end
end

--- Resets the module's state to its initial values
--- @param self CoreModule
function CoreModule:ResetState()
    if not self.state then
        return
    end

    -- If module has custom reset logic, use it
    if self.ModuleResetState then
        self:ModuleResetState()
        return
    end

    -- Default reset - wipe all values
    wipe(self.state)

    -- If module has default state, restore it
    if self.defaultState then
        for k, v in pairs(self.defaultState) do
            if type(v) == "table" then
                self.state[k] = CopyTable(v)
            else
                self.state[k] = v
            end
        end
    end
end

--- Gets a value from the module's state
--- @param self CoreModule
--- @param key string The key to get
--- @return any The value, or nil if not found
function CoreModule:GetState(key)
    if not self.state then
        return nil
    end
    return self.state[key]
end

--- Sets a value in the module's state
--- @param self CoreModule
--- @param key string The key to set
--- @param value any The value to set
function CoreModule:SetState(key, value)
    if not self.state then
        self:InitializeState()
    end
    self.state[key] = value
end

-- ============================ EVENT MANAGEMENT ============================

--- Registers module event handlers from the eventHandlers table
--- @param self CoreModule
function CoreModule:RegisterEventHandlers()
    local hasEvents = self.eventHandlers ~= nil
    if hasEvents and type(self.eventHandlers) ~= "table" then
        local moduleName = (self.GetName and self:GetName()) or "unknown"
        self:Error("Invalid eventHandlers definition for module '%s' (expected table, got %s)",
            tostring(moduleName), type(self.eventHandlers))
        hasEvents = false
    end

    -- Prefer centralized EventManager when available; fall back to direct AceEvent registration
    if EventManager.RegisterModuleEvents then
        if hasEvents then
            -- Register through EventManager (centralized, deduped, batched)
            EventManager:RegisterModuleEvents(self)
            -- Track managed events for clean unregistration
            self.__registeredEventsManaged = true
            self.__managedEvents = {}
            for event, _ in pairs(self.eventHandlers) do
                self.__managedEvents[event] = true
            end
        end
    else
        -- Fallback: direct registration via AceEvent
        if hasEvents then
            for event, handler in pairs(self.eventHandlers) do
                if handler == true then
                    -- If handler is true, use the event name as the method name
                    if self[event] then
                        self:RegisterEvent(event)
                        -- Track this registration
                        self.__registeredEvents[event] = { type = "method", handler = event }
                    else
                        self:Error("Event handler method '%s' not found for event '%s'", event, event)
                    end
                elseif type(handler) == "string" and self[handler] then
                    -- If handler is a string, use the corresponding method
                    self:RegisterEvent(event, handler)
                    -- Track this registration
                    self.__registeredEvents[event] = { type = "method", handler = handler }
                elseif type(handler) == "function" then
                    -- If handler is a function, register it directly
                    self:RegisterEvent(event, function(evt, ...)
                        -- Normalize to (self, event, ...) to match centralized EventManager signature
                        handler(self, evt or event, ...)
                    end)
                    -- Track this registration
                    self.__registeredEvents[event] = { type = "function", handler = handler }
                end
            end
        end
    end

    -- CLEU handlers (centralized only)
    if EventManager.RegisterModuleCLEUHandlers then
        -- Allow modules to build/augment cleuHandlers if they expose a builder
        if self.BuildCleuHandlers then
            self:BuildCleuHandlers()
        end

        if self.cleuHandlers and type(self.cleuHandlers) ~= "table" then
            local moduleName = (self.GetName and self:GetName()) or "unknown"
            self:Error("Invalid cleuHandlers definition for module '%s' (expected table, got %s)",
                tostring(moduleName), type(self.cleuHandlers))
        elseif self.cleuHandlers then
            EventManager:RegisterModuleCLEUHandlers(self)
            self.__registeredCLEUManaged = true
        end
    end
end

--- Registers module message handlers from the messageHandlers table
--- @param self CoreModule
function CoreModule:RegisterMessageHandlers()
    if not self.messageHandlers then
        return
    end

    if not self.__messageSendTrackingHooked and hooksecurefunc and type(self.SendMessage) == "function" then
        hooksecurefunc(self, "SendMessage", function(module, messageName)
            trackMessageSent(module, messageName)
        end)
        self.__messageSendTrackingHooked = true
    end

    for message, handler in pairs(self.messageHandlers) do
        if handler == true then
            -- If handler is true, use the message name as the method name
            if self[message] then
                self:RegisterMessage(message, function(receivedMessage, ...)
                    local normalizedMessage = receivedMessage or message
                    trackMessageReceived(self, normalizedMessage)
                    self[message](self, normalizedMessage, ...)
                end)
                -- Track this registration
                self.__registeredMessages[message] = { type = "method", handler = message }
            else
                self:Error(format("Message handler method '%s' not found for message '%s'", message, message))
            end
        elseif type(handler) == "string" and self[handler] then
            -- If handler is a string, use the corresponding method
            self:RegisterMessage(message, function(receivedMessage, ...)
                local normalizedMessage = receivedMessage or message
                trackMessageReceived(self, normalizedMessage)
                self[handler](self, normalizedMessage, ...)
            end)
            -- Track this registration
            self.__registeredMessages[message] = { type = "method", handler = handler }
        elseif type(handler) == "function" then
            -- If handler is a function, register it directly
            self:RegisterMessage(message, function(receivedMessage, ...)
                local normalizedMessage = receivedMessage or message
                trackMessageReceived(self, normalizedMessage)
                handler(self, normalizedMessage, ...)
            end)
            -- Track this registration
            self.__registeredMessages[message] = { type = "function", handler = handler }
        end
    end
end

--- Registers module slash commands from the slashCommands table in mixins
--- Rooted commands are routed through SlashCommandHandler (`/nag` or `/nagdebug`)
--- and are NOT registered as standalone slash commands unless `standalone = true`.
--- @param self CoreModule
function CoreModule:RegisterSlashCommands()
    if not self.slashCommands then
        return
    end

    for commandKey, config in pairs(self.slashCommands) do
        local handler = config.handler
        local help = config.help
        local context = config.context or self
        local aliases = config.aliases
        local category = config.category  -- Read category from config
        local commandName, rootCommand, pathArray
        local hasExplicitRoot = config.root ~= nil and config.root ~= ""
        local standaloneEnabled = config.standalone == true or not hasExplicitRoot

        -- Check if this is a hierarchical command (has path/paths properties)
        local pathsArray = nil  -- Array of paths for multiple hierarchical paths

        if config.path or config.paths then
            -- Hierarchical: has path/paths properties
            rootCommand = config.root or "nagdebug"  -- Default to nagdebug if root not specified

            -- Support both single path and multiple paths
            if config.paths then
                -- Multiple paths: paths = {{"display", "share"}, {"display", "sharedisplay"}}
                pathsArray = config.paths
                pathArray = config.paths[1]  -- Use first path for primary registration
                commandName = table.concat(pathArray, "_")  -- Internal registry name
            else
                -- Single path: path = {"display", "share"}
                pathArray = config.path
                commandName = table.concat(pathArray, "_")  -- Internal registry name
            end
        else
            -- Flat: ["groupoverride"] = {...}
            commandName = commandKey
            rootCommand = config.root or "nagdebug"  -- Use explicit root or default to nagdebug
            pathArray = nil
        end

        -- Store in ns.SlashCommands with path metadata
        if not ns.SlashCommands then ns.SlashCommands = {} end

        -- Register primary path
        ns.SlashCommands[commandName] = {
            handler = handler,
            help = help,
            aliases = aliases,
            category = category,  -- Store category for use in command discovery
            module = self:GetName(),
            root = rootCommand,
            path = pathArray,
            isHierarchical = pathArray ~= nil
        }

        -- If multiple paths were specified, register additional paths
        if pathsArray and #pathsArray > 1 then
            for i = 2, #pathsArray do
                local additionalPath = pathsArray[i]
                local additionalCommandName = table.concat(additionalPath, "_")

                -- Register as a separate command with the same handler
                ns.SlashCommands[additionalCommandName] = {
                    handler = handler,
                    help = help .. " (alternate path)",
                    aliases = nil,  -- Only primary path gets aliases
                    category = category,  -- Store category for alternate paths too
                    module = self:GetName(),
                    root = rootCommand,
                    path = additionalPath,
                    isHierarchical = true
                }

                self:Debug("Registered alternate hierarchical path #%d: /%s %s (commandName: %s)",
                    i, rootCommand, table.concat(additionalPath, " "), additionalCommandName)
            end

            self:Debug("Total paths registered for '%s': %d (primary + %d alternates)",
                commandKey, #pathsArray, #pathsArray - 1)
        end

        -- Register actual standalone slash command (flat commands only)
        -- Rooted commands should resolve via SlashCommandHandler discovery.
        if not pathArray then
            if standaloneEnabled then
                -- Register the primary command
                if handler == true then
                    -- If handler is true, use the command name as the method name
                    if self[commandKey] then
                        self:RegisterSlashCommand(commandKey, commandKey, help, context)
                    else
                        self:Error("Slash command handler method '%s' not found for command '%s'", commandKey, commandKey)
                    end
                elseif type(handler) == "string" and self[handler] then
                    -- If handler is a string, use the corresponding method
                    self:RegisterSlashCommand(commandKey, handler, help, context)
                elseif type(handler) == "function" then
                    -- If handler is a function, register it directly
                    self:RegisterSlashCommand(commandKey, handler, help, context)
                end
            else
                self:Debug("Skipping standalone slash registration for rooted command: %s (root=%s)",
                    commandKey, tostring(rootCommand))
            end
        end

        -- Register aliases if specified
        if aliases and type(aliases) == "table" then
            for _, alias in ipairs(aliases) do
                if type(alias) == "string" then
                    -- Create alias handler that delegates to the primary command
                    local aliasHandler = function(input)
                        -- Delegate to the primary command handler
                        if handler == true then
                            if self[commandKey] then
                                self[commandKey](self, input)
                            end
                        elseif type(handler) == "string" and self[handler] then
                            self[handler](self, input)
                        elseif type(handler) == "function" then
                            handler(input)
                        end
                    end

                    -- Register the alias with descriptive help
                    local aliasHelp = help and (help .. " (alias for /" .. commandKey .. ")") or ("Alias for /" .. commandKey)
                    if standaloneEnabled then
                        self:RegisterSlashCommand(alias, aliasHandler, aliasHelp, context)
                    end

                    -- Also add alias to ns.SlashCommands with proper metadata (including root field)
                    -- This ensures aliases are discovered properly by SlashCommandHandler
                    if not ns.SlashCommands then ns.SlashCommands = {} end
                    ns.SlashCommands[alias] = {
                        handler = type(handler) == "string" and handler or "inline_function",
                        help = aliasHelp,
                        aliases = nil,  -- Aliases don't have sub-aliases
                        category = category,
                        module = self:GetName(),
                        root = rootCommand,
                        path = pathArray,
                        isHierarchical = pathArray ~= nil
                    }
                end
            end
        end
    end
end

--- Smart unregistration of tracked events (WoW events only)
--- @param self CoreModule
function CoreModule:UnregisterEventHandlers()
    -- If events were managed centrally, unregister via EventManager
    if self.__registeredEventsManaged and self.__managedEvents then
        if EventManager.UnregisterModuleFromEvent then
            for event, _ in pairs(self.__managedEvents) do
                EventManager:UnregisterModuleFromEvent(self:GetName(), event)
                self:Debug("Unregistered managed event via EventManager: %s", event)
            end
        end
        self.__managedEvents = nil
        self.__registeredEventsManaged = nil
    else
        if self.__registeredEvents then
            for event, registration in pairs(self.__registeredEvents) do
                -- Safely unregister event (may not exist in current WoW version)
                local success, err = pcall(function()
                    self:UnregisterEvent(event)
                end)
                if success then
                    self:Debug("Unregistered event: %s (type: %s)", event, registration.type)
                else
                    -- Event doesn't exist in current version, log but don't error
                    self:Debug("Failed to unregister event '%s' (may not exist in current version): %s",
                        event, tostring(err))
                end
            end
            -- Clear the tracking table
            wipe(self.__registeredEvents)
        end
    end

    -- CLEU unregistration
    if self.__registeredCLEUManaged and EventManager.UnregisterModuleCLEUHandlers then
        EventManager:UnregisterModuleCLEUHandlers(self:GetName())
        self.__registeredCLEUManaged = nil
    end
end

--- Smart unregistration of tracked messages
--- @param self CoreModule
function CoreModule:UnregisterMessageHandlers()
    if not self.__registeredMessages then
        return
    end

    for message, registration in pairs(self.__registeredMessages) do
        self:UnregisterMessage(message)
        self:Debug("Unregistered message: %s (type: %s)", message, registration.type)
    end

    -- Clear the tracking table
    wipe(self.__registeredMessages)
end

--- Gets information about currently registered events (for debugging)
--- @param self CoreModule
--- @return table Information about registered events
function CoreModule:GetRegisteredEventsInfo()
    if not self.__registeredEvents then
        return {}
    end

    local info = {}
    for event, registration in pairs(self.__registeredEvents) do
        tinsert(info, {
            event = event,
            type = registration.type,
            handler = registration.handler
        })
    end

    return info
end

--- Gets information about currently registered messages (for debugging)
--- @param self CoreModule
--- @return table Information about registered messages
function CoreModule:GetRegisteredMessagesInfo()
    if not self.__registeredMessages then
        return {}
    end

    local info = {}
    for message, registration in pairs(self.__registeredMessages) do
        tinsert(info, {
            message = message,
            type = registration.type,
            handler = registration.handler
        })
    end

    return info
end

--- Debug method to show all registered events and messages
--- @param self CoreModule
function CoreModule:DebugRegisteredEvents()
    local events = self:GetRegisteredEventsInfo()
    local messages = self:GetRegisteredMessagesInfo()

    self:Debug("=== Registered Events (%d) ===", #events)
    for _, eventInfo in ipairs(events) do
        self:Debug("  Event: %s (Type: %s, Handler: %s)",
            eventInfo.event,
            eventInfo.type,
            tostring(eventInfo.handler))
    end

    self:Debug("=== Registered Messages (%d) ===", #messages)
    for _, messageInfo in ipairs(messages) do
        self:Debug("  Message: %s (Type: %s, Handler: %s)",
            messageInfo.message,
            messageInfo.type,
            tostring(messageInfo.handler))
    end
end

-- ============================ TOGGLE FUNCTIONALITY ============================

--- Toggles the module's enabled state
--- @param self CoreModule
--- @return boolean The new enabled state
function CoreModule:Toggle()
    -- TODO Does this need a SetEnabledState()
    self:Debug("Toggling module: " .. self:GetName())

    if self:IsEnabled() then
        self:Disable()
        if self.frame then
            self.frame:Hide()
        end
        self:Debug("Toggling module: " .. self:GetName() .. " to " .. tostring(self:IsEnabled()))
    else
        self:Enable()
        if self.frame then
            self.frame:Show()
        end
        self:Debug("Toggling module: " .. self:GetName() .. " to " .. tostring(self:IsEnabled()))
    end

    if self.CreateFrame and not self.frame then
        self:Debug("Creating frame for module: " .. self:GetName())
        self:CreateFrame()
    end

    -- If we have character settings, update them
    if not self.moduleType == ns.MODULE_TYPES.DEBUG and self.db then
        self:Debug("Setting enabled state for module: " .. self:GetName() .. " to " .. tostring(self:IsEnabled()))
        self:SetSetting("char", "enabled", self:IsEnabled())
    end

    -- Notify options UI of the change
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("NAG")
    end

    return self:IsEnabled()
end

-- ============================ DATABASE RESET METHODS (OPTIONAL) ============================

--- Default handler for database reset events
--- @param self CoreModule
--- @param event string The event name
--- @param resetType string The type of reset being performed ("all", "global", "char", "class")
function CoreModule:OnDatabaseReset(event, resetType)
    self:Debug("Database reset event received: " .. tostring(resetType))

    -- Always do base reset functionality
    self:BaseModuleResetDB(resetType)

    -- Call module-specific reset handler if it exists
    if self.ModuleResetDB then
        self:ModuleResetDB(resetType)
    end
end

--- Base implementation for resetting module database
--- @param self CoreModule
--- @param resetType string The type of reset being performed ("all", "global", "char", "class")
function CoreModule:BaseModuleResetDB(resetType)
    --TODO Add smart reset logic
    -- Only process if we have a valid DB
    if not self.db then
        self:Debug("BaseModuleResetDB: No DB found, skipping")
        return
    end

    -- Handle different reset types
    if resetType == "all" then
        -- For a complete reset, we:
        -- 1. Remove all current defaults
        self.db:RegisterDefaults(nil)
        -- 2. Clear all sections
        if self.db.global then wipe(self.db.global) end
        if self.db.char then wipe(self.db.char) end
        if self.db.class then wipe(self.db.class) end
        if self.db.profile then wipe(self.db.profile) end
        -- 3. Re-register defaults
        if self.defaults then
            self.db:RegisterDefaults(self.defaults)
        end
    elseif resetType == "global" and self.db.global then
        wipe(self.db.global)
        if self.defaults then
            self.db:RegisterDefaults(self.defaults)
        end
    elseif resetType == "char" and self.db.char then
        wipe(self.db.char)
        if self.defaults then
            self.db:RegisterDefaults(self.defaults)
        end
    elseif resetType == "class" and self.db.class then
        wipe(self.db.class)
        if self.defaults then
            self.db:RegisterDefaults(self.defaults)
        end
    elseif resetType == "profile" and self.db.profile then
        wipe(self.db.profile)
        if self.defaults then
            self.db:RegisterDefaults(self.defaults)
        end
    end

    self:Debug("BaseModuleResetDB: Reset complete for type: " .. tostring(resetType))
end

-- ============================ OPTIONS UI ENHANCEMENTS (OPTIONAL) ============================

--- Default handler for setting changes
--- @param self CoreModule
--- @param key string The setting key that changed
--- @param value any The new value
function CoreModule:OnSettingChanged(key, value)
    -- TODO  Get this to only get called per module not all
    -- Default handler: modules can override this to react to settings changes
    --self:Debug("OnSettingChanged called for key '%s' with value '%s' (override in your module to handle)", tostring(key), tostring(value))
end

-- ============================ MODULE CREATION FUNCTIONS ============================

--- Creates a dummy module that does nothing (for class restriction)
--- @param name string The module name
--- @return table The dummy module
local function CreateDummyModule(name)
    return {
        GetName = function() return name end,
        IsEnabled = function() return false end,
        SetEnabledState = function() end,
        Enable = function() end,
        Disable = function() end,
        Debug = function() end,
        Info = function() end,
        Warn = function() end,
        Error = function() end,
        Trace = function() end,
        Log = function() end,
        RegisterEvent = function() end,
        UnregisterEvent = function() end,
        RegisterMessage = function() end,
        UnregisterMessage = function() end,
        SendMessage = function() end,
        ScheduleTimer = function() end,
        CancelTimer = function() end,
        OnInitialize = function() end,
        OnEnable = function() end,
        OnDisable = function() end,
        ModuleInitialize = function() end,
        ModuleEnable = function() end,
        ModuleDisable = function() end,
        GetOptions = function() return {} end,
        defaults = { global = {}, char = {}, class = {} },
        db = { global = {}, char = {}, class = {} }
    }
end

--- Gets the module alias, checking mixins first, then falling back to centralized list
--- @param moduleName string The module name
--- @param mixins table|nil The module mixins
--- @return string The module alias
local function GetModuleAlias(moduleName, mixins)
    -- Check if alias is specified in mixins (highest priority)
    if mixins and mixins.moduleAlias then
        return mixins.moduleAlias
    end

    -- Fall back to centralized alias list
    if ns.MODULE_ALIASES and ns.MODULE_ALIASES[moduleName] then
        return ns.MODULE_ALIASES[moduleName]
    end

    -- Default to module name if no alias found
    return moduleName
end

--- Creates a new module with the CoreModule prototype (unified function for all module types)
---
--- ZERO-BOILERPLATE INTEGRATION:
--- This function implements zero-boilerplate system integration. Modules automatically
--- integrate with all systems through declarative configuration in mixins.
---
--- @param self NAG The addon object
--- @param name string The name of the module
--- @param defaults? table|nil The module defaults
--- @param mixins? table|nil The module mixins (declarative configuration)
--- @return CoreModule The new module
function NAG:CreateModule(name, defaults, mixins)
    -- Check class restriction if specified in mixins
    if mixins and mixins.className then
        local playerClass = select(2, UnitClass("player"))
        if mixins.className ~= playerClass then
            NAG:Debug("CreateModule: Skipping " ..
                name .. " - player is " .. playerClass .. ", module requires " .. mixins.className)
            return CreateDummyModule(name)
        end
    end

    -- Ensure defaults exists
    defaults = defaults or {}
    defaults.global = defaults.global or {}
    -- For FEATURE modules, also ensure char namespace exists
    if (mixins and mixins.moduleType == ns.MODULE_TYPES.FEATURE) then
        defaults.char = defaults.char or {}
    end

    -- Inject debug toggle by default unless explicitly set or opted out
    if defaults.global.debugLevel == nil then
        defaults.global.debugLevel = ns.DEBUG_LEVELS.ERROR
    end

    -- LEGACY DEFAULTS: Ensure enabled value exists in defaults for backward compatibility
    -- Check if enabled exists in any namespace level before setting default
    local enabledExists = defaults.global and defaults.global.enabled ~= nil or
        defaults.char and defaults.char.enabled ~= nil or
        defaults.class and defaults.class.enabled ~= nil

    if not enabledExists then
        -- Determine module type (will be set later, but we need it now for defaults)
        local moduleType = (mixins and mixins.moduleType) or ns.MODULE_TYPES.CORE
        defaults.global.enabled = ns.DEFAULT_ENABLED_BY_TYPE[moduleType]
    end

    -- Create module with CoreModule as prototype
    local module = self:NewModule(name, ns.CoreModule)

    -- Store defaults if provided
    if defaults then
        module.defaults = defaults
    end

    -- Set module type from mixins or default to CORE
    module.moduleType = (mixins and mixins.moduleType) or ns.MODULE_TYPES.CORE

    -- Mix in any additional functions
    if mixins then
        -- Store mixins for feature checking
        module.mixins = mixins

        -- Handle additional Ace3 libraries if specified
        if mixins.libs then
            for _, lib in ipairs(mixins.libs) do
                LibStub(lib):Embed(module)
            end
            mixins.libs = nil -- Remove from mixins after processing
        end

        -- Set options category if specified, otherwise use default
        module.optionsCategory = mixins.optionsCategory or ns.DEFAULT_CATEGORY_BY_TYPE[module.moduleType]

        -- Set module alias if specified in mixins, otherwise use centralized list
        module.moduleAlias = GetModuleAlias(name, mixins)

        -- Set debug categories if specified in mixins, otherwise use default
        if mixins.debugCategories then
            module.debugCategories = mixins.debugCategories
        else
            -- Set default debug category based on module type
            local defaultCategory = ns.DEFAULT_DEBUG_CATEGORY_BY_TYPE[module.moduleType] or ns.DEBUG_CATEGORIES.GENERAL
            module.debugCategories = { defaultCategory }
        end

        -- Set debug mode from global registry; allow global force-on flag for development
        if ns.FORCE_MODULE_DEBUG_ON_CREATE then
            module.debug = true
        else
            module.debug = ns.DevDebugUtils.IsDebugEnabled(NAG, name)
        end

        -- Mix in remaining properties
        for k, v in pairs(mixins) do
            module[k] = v
        end
    else
        -- Set default options category if no mixins provided
        module.optionsCategory = ns.DEFAULT_CATEGORY_BY_TYPE[module.moduleType]
        -- Set module alias from centralized list
        module.moduleAlias = GetModuleAlias(name, nil)
        -- Set default debug category
        local defaultCategory = ns.DEFAULT_DEBUG_CATEGORY_BY_TYPE[module.moduleType] or ns.DEBUG_CATEGORIES.GENERAL
        module.debugCategories = { defaultCategory }
        -- Set debug mode per global force flag or developer registry
        if ns.FORCE_MODULE_DEBUG_ON_CREATE then
            module.debug = true
        else
            module.debug = ns.DevDebugUtils.IsDebugEnabled(NAG, name)
        end
    end

    -- Initialize state immediately if module has defaultState (needed for early access)
    if module.defaultState then
        module:InitializeState()
    end

    return module
end

-- ============================ EXPORT ============================

ns.CoreModule = CoreModule

-- ============================ USAGE EXAMPLES ============================
--[[
EXAMPLE: How to use debug categories and developer debugging in your modules

1. Basic module with single debug category:
```lua
local MyModule = NAG:CreateModule("MyModule", {
    global = {
        debugLevel = ns.DEBUG_LEVELS.WARN
    }
}, {
    debugCategories = {ns.DEBUG_CATEGORIES.DISPLAY}, -- Single category
    optionsCategory = ns.MODULE_CATEGORIES.UI
})
```

2. Module with developer debugging (controlled via database):
```lua
local DevModule = NAG:CreateModule("DevModule", {
    global = {
        debugLevel = ns.DEBUG_LEVELS.WARN
    }
}, {
    debugCategories = {ns.DEBUG_CATEGORIES.DISPLAY},
    optionsCategory = ns.MODULE_CATEGORIES.UI
})

-- In the module code:
function DevModule:SomeFunction()
    if self.debug then
        self:Trace("Detailed processing steps...") -- Only logs if debug is enabled
    end

    -- Standard debug (user-controlled)
    self:Debug("User-visible debug info")
end
```

3. Enabling debugging for a module:
```lua
-- Enable debug for a specific module
NAG:EnableDebug("DevModule")

-- Disable debug for a specific module
NAG:DisableDebug("DevModule")

-- Check if debug is enabled
if NAG:IsDebugEnabled("DevModule") then
    -- Do something
end
```

DEVELOPER DEBUG METHODS:
------------------------
- Use standard methods with debug checks:
  - if self.debug then self:Info(msg, ...) end      -- Developer info logging
  - if self.debug then self:Debug(msg, ...) end     -- Developer debug logging
  - if self.debug then self:Trace(msg, ...) end     -- Developer trace logging

- Warn/Error should NOT be debug-gated unless for diagnostic iteration:
  - self:Warn(msg, ...)  -- Always visible warnings
  - self:Error(msg, ...) -- Always visible errors

DEVELOPER DEBUG FEATURES:
-------------------------
- Zero performance impact when disabled (just boolean check)
- Database-persisted settings (survives across sessions)
- Per-developer control (each developer can enable different modules)
- Works alongside standard debug system
- Perfect for verbose debugging during development
- Excludes Utils from automatic enabling (Utils debug is very verbose)

LOGIN ALERTS:
-------------
- Shows summary of modules with dev debug enabled on login
- Use NAG:ShowDebugLoginAlert() to show summary of all modules with debug
- Use NAG:GetModulesWithDebug() to get list of modules with debug enabled

SLASH COMMANDS:
---------------
- /nag devdebug help                    -- Show help
- /nag devdebug list                    -- List modules with debug enabled
- /nag devdebug enable <module>         -- Enable debug for a module
- /nag devdebug disable <module>        -- Disable debug for a module
- /nag devdebug toggle <module>         -- Toggle debug for a module
- /nag devdebug clear                   -- Disable debug for all modules

USAGE COMMANDS:
---------------
- /nagdebug category list                    -- List all debug categories
- /nagdebug category listmodules display     -- List modules in display category
- /nagdebug category enableall               -- Enable all debug categories
- /nagdebug category disableall              -- Disable all debug categories
- /nagdebug group display on                 -- Enable debug for display category
- /nagdebug group events off                 -- Disable debug for events category
- /nagdebug group services toggle            -- Toggle debug for services category

DEFAULT CATEGORIES BY MODULE TYPE:
----------------------------------
- CORE modules: "services"
- CLASS modules: "class"
- FEATURE modules: "features"
- DEBUG modules: "debug"
- All others: "general"

AVAILABLE DEBUG CATEGORIES:
---------------------------
- general: General modules (default)
- display: Display/UI related modules
- combat: Combat-related modules
- data: Data management modules
- events: Event handling modules
- state: State management modules
- options: Options/configuration modules
- services: Service modules
- debug: Debug/development modules
- class: Class-specific modules
- features: Feature modules
- utilities: Utility modules
- handlers: Event/action handlers
- managers: Manager modules
- processors: Data processors
- validators: Validation modules
- renderers: Rendering modules
- trackers: Tracking modules
- analyzers: Analysis modules

BACKWARDS COMPATIBILITY:
------------------------
- Existing modules without debugCategories will default to "general"
- All existing functionality continues to work
- Module-specific debug settings still work alongside category settings
- Category debug takes precedence over module-specific debug when enabled
]]
