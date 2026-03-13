--- @module "DevDebugUtils"
--- Shared utility for developer debugging functionality across all modules and services
---
--- Provides unified developer debugging functionality that can be used by:
--- - CoreModule (regular modules)
--- - NAG (main addon) - via ns.DevDebugUtils functions
--- - Service modules (non-CoreModule) - via ns.DevDebugUtils functions
--- - Any other module or service
---
--- This ensures consistent behavior and interface across the entire codebase
--- while avoiding code duplication and implementation drift.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

local tinsert = tinsert

-- ============================ CONTENT ============================

-- Global registry for dev debug modules (loaded early, before database)
ns.devDebugModules = {}

--- DevDebugUtils: Provides unified developer debugging functionality
local DevDebugUtils = {}

-- Debug flag to control logging (set to false to disable debug output)
local DEBUG_DEV_DEBUG_UTILS = false

-- Debug: Track loading order
if DEBUG_DEV_DEBUG_UTILS then
    print("|cff00ff00[NAG DevDebugUtils] DevDebugUtils module loading...|r")
    print("|cff00ff00[NAG DevDebugUtils] Current stack:|r")
    print(debugstack(1, 3, 0))
end

--- Loads developer debug settings from database early in initialization
--- @param self NAG The addon object
function DevDebugUtils.LoadDevDebugSettings(self)
    -- Try to load from database if available
    if self.db and self.db.global then
        local devDebugModules = self.db.global.devDebugModules or {}
        ns.devDebugModules = devDebugModules
        self:Debug("Loaded dev debug settings for %d modules", self:CountTableKeys(devDebugModules))
    else
        -- Database not ready yet, use empty table
        ns.devDebugModules = {}
        self:Debug("Database not ready, using empty dev debug settings")
    end
end

--- Saves developer debug settings to database
--- @param self NAG The addon object
function DevDebugUtils.SaveDevDebugSettings(self)
    if self.db and self.db.global then
        self.db.global.devDebugModules = ns.devDebugModules
        self:Debug("Saved dev debug settings for %d modules", self:CountTableKeys(ns.devDebugModules))
    end
end

--- Enables debugging for a specific module
--- @param self NAG The addon object
--- @param moduleName string The module name to enable debug for
function DevDebugUtils.EnableDebug(self, moduleName)
    ns.devDebugModules[moduleName] = true
    DevDebugUtils.SaveDevDebugSettings(self)
    self:Info("Debug enabled for module: %s", moduleName)
end

--- Disables debugging for a specific module
--- @param self NAG The addon object
--- @param moduleName string The module name to disable debug for
function DevDebugUtils.DisableDebug(self, moduleName)
    ns.devDebugModules[moduleName] = false
    DevDebugUtils.SaveDevDebugSettings(self)
    self:Info("Debug disabled for module: %s", moduleName)
end

--- Checks if debugging is enabled for a specific module
--- @param self NAG The addon object
--- @param moduleName string The module name to check
--- @return boolean Whether debug is enabled for this module
function DevDebugUtils.IsDebugEnabled(self, moduleName)
    return ns.devDebugModules[moduleName] == true
end

--- Gets all modules with debugging enabled
--- @param self NAG The addon object
--- @return table Array of module names with debug enabled
function DevDebugUtils.GetModulesWithDebug(self)
    local modulesWithDebug = {}

    for moduleName, enabled in pairs(ns.devDebugModules) do
        if enabled then
            tinsert(modulesWithDebug, moduleName)
        end
    end

    return modulesWithDebug
end

--- Shows a summary of modules with debugging enabled
--- @param self NAG The addon object
--- @param showDetails boolean Whether to show individual module names
function DevDebugUtils.ShowDebugSummary(self, showDetails)
    local modulesWithDebug = DevDebugUtils.GetModulesWithDebug(self)

    if #modulesWithDebug == 0 then
        self:Info("No modules have debugging enabled")
        return
    end

    if showDetails then
        self:Info("Modules with debugging enabled (%d):", #modulesWithDebug)
        for _, moduleName in ipairs(modulesWithDebug) do
            self:Info("  - %s", moduleName)
        end
    else
        self:Info("Debug enabled for %d modules", #modulesWithDebug)
    end
end

--- Shows a login alert for modules with debugging enabled
--- Called automatically during addon initialization
--- @param self NAG The addon object
function DevDebugUtils.ShowDebugLoginAlert(self)
    local modulesWithDebug = DevDebugUtils.GetModulesWithDebug(self)

    if #modulesWithDebug == 0 then
        return
    end

    self:Info("Debug enabled for %d modules", #modulesWithDebug)
    DevDebugUtils.ShowDebugSummary(self, true)
end

-- Note: RegisterDevDebugCommands is handled directly in NAG.lua since slash commands
-- are addon-level functionality, not module-level

-- ============================ EXPORTS ============================

-- Export the utility functions
ns.DevDebugUtils = DevDebugUtils

-- Debug: Log that DevDebugUtils has been loaded
if DEBUG_DEV_DEBUG_UTILS then
    print("|cff00ff00[NAG DevDebugUtils] DevDebugUtils loaded successfully|r")
    print("|cff00ff00[NAG DevDebugUtils] Available functions: LoadDevDebugSettings, SaveDevDebugSettings, EnableDebug, DisableDebug, IsDebugEnabled, GetModulesWithDebug, ShowDebugSummary, ShowDebugLoginAlert, RegisterDevDebugCommands|r")
end

--[[
USAGE EXAMPLES:

1. CoreModule-inheriting module (RECOMMENDED - automatic via prototype):
function MyModule:OnInitialize()
    -- Use simple debug flag for developer debug logging
    if self.debug then
        self:Debug("Module initialized")  -- Properly labeled with module name
        self:Trace("Detailed initialization steps...")
    end
end

2. Service module (non-CoreModule):
function MyServiceModule:OnInitialize()
    -- Use DevDebugUtils directly for management functions only
    if ns.DevDebugUtils.IsDebugEnabled(ns.NAG, "MyServiceModule") then
        print("MyServiceModule debug mode enabled")
    end

    -- For actual debug logging, use DebugManager directly with module name
    if ns.DevDebugUtils.IsDebugEnabled(ns.NAG, "MyServiceModule") then
        ns.DebugManager:debug("MyServiceModule", "Module initialized")
    end
end

3. Main addon registration:
ns.DevDebugUtils.LoadDevDebugSettings(ns.NAG)
ns.DevDebugUtils.RegisterDevDebugCommands(ns.NAG)
ns.DevDebugUtils.ShowDebugLoginAlert(ns.NAG)

4. Module creation (in CoreModule.lua):
module.debug = ns.DevDebugUtils.IsDebugEnabled(ns.NAG, name)

IMPORTANT: For actual debug logging, use simple debug flag checks:
- if self.debug then self:Debug(msg, ...) end     -- Wrap with debug check
- if self.debug then self:Info(msg, ...) end      -- Wrap with debug check
- if self.debug then self:Trace(msg, ...) end     -- Wrap with debug check

NOTE: Warn/Error should NOT be debug-gated unless for diagnostic iteration:
- self:Warn(msg, ...)  -- Always visible - use for legitimate warnings
- self:Error(msg, ...) -- Always visible - use for legitimate errors

These methods automatically check self.debug and use the correct module context
for proper labeling in the DebugManager.
]]
