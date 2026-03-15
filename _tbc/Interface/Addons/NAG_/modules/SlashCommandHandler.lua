--- @module "NAG.SlashCommandHandler"
--- Centralized slash command handling for NAG addon
---
--- This module manages all `/nag` and `/nagdebug` commands with proper categorization,
--- aliasing for backward compatibility, and comprehensive tab completion support.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local WoWAPI = ns.WoWAPI

-- ============================ ADDON ACCESS ============================

--- @type NAG|AceAddon Main addon reference
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ MODULE ACCESS ============================

local RotationManager, DisplayManager, OptionsManager, ResetManager, StateManager, DataManager, SpecCompat, LeaderboardService

-- ============================ LIBRARY ACCESS ============================

local AceTab = ns.AceTab
local AceConfigDialog = ns.AceConfigDialog
local L = ns.AceLocale:GetLocale("NAG", true)

-- ============================ LUA API LOCALIZATION ============================

local format = string.format
local strlower = strlower
local strtrim = strtrim
local strsub = strsub or string.sub
local tinsert = tinsert
local pairs = pairs
local type = type
local tostring = tostring

-- ============================ WOW API LOCALIZATION ============================

local GetTime = _G.GetTime
local ReloadUI = _G.ReloadUI

-- ============================ MODULE DEFAULTS ============================

local defaults = {
    global = {},
    char = {},
    class = {}
}

-- ============================ MODULE CREATION ============================

local SlashCommandHandler = NAG:CreateModule("SlashCommandHandler", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    debugCategories = { ns.DEBUG_CATEGORIES.SYSTEM },

    -- Automatic slash command registration
    slashCommands = {
        ["nag"] = {
            handler = "HandleMainCommand",
            help = "Main NAG command. Use '/nag help' for subcommands"
        },
        ["nagdebug"] = {
            handler = "HandleDebugCommand",
            help = "NAG debug commands. Use '/nagdebug help' for options"
        },
        ["nagburst"] = {
            handler = "HandleBurstCommand",
            help = "Toggle visibility of LEFT frames (/nagburst on|off|toggle|status)"
        },
        ["nagattack"] = {
            handler = "HandleAttackCommand",
            help = "Macro hook for weapon-sync: call this from your /startattack macro to signal press cadence"
        }
    }
})

-- ============================ MODULE INITIALIZATION ============================

--- Initialize the module
function SlashCommandHandler:ModuleInitialize()
    -- Unified command registry structure
    self.commands = {
        nag = {
            flat = {},          -- Flat commands for /nag (e.g., /nag next, /nag help)
            hierarchical = {}   -- Hierarchical tree for /nag (for organization only - commands are flattened)
        },
        nagdebug = {
            flat = {},          -- Flat commands for /nagdebug (e.g., /nagdebug level)
            hierarchical = {}   -- Hierarchical tree for /nagdebug (e.g., /nagdebug ast validate)
        },
        nagburst = {
            flat = {},          -- Standalone toggle for left frames (/nagburst)
            hierarchical = {}
        }
    }

    self.aliases = {}
end

--- Enable the module
function SlashCommandHandler:ModuleEnable()
    -- Get module dependencies
    RotationManager = NAG:GetModule("RotationManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    OptionsManager = NAG:GetModule("OptionsManager")
    ResetManager = NAG:GetModule("ResetManager")
    StateManager = NAG:GetModule("StateManager")
    DataManager = NAG:GetModule("DataManager")
    SpecCompat = NAG:GetModule("SpecCompat")
    LeaderboardService = NAG:GetModule("LeaderboardService", true)

    -- Build command registry
    self:BuildCommandRegistry()

    -- Build flat command list for tab completion
    self:BuildFlatCommandList()

    -- Build alias mappings
    self:BuildAliases()

    -- Auto-discover module commands from ns.SlashCommands registry
    self:DiscoverModuleCommands()

    -- Register root slash commands for aliases (e.g. /nagaoe → /nag aoe)
    self:RegisterRootAliasCommands()

    -- Register tab completion
    self:RegisterTabCompletion()

    self:Debug("SlashCommandHandler initialized with " .. self:CountCommands() .. " commands")
end

-- ============================ COMMAND REGISTRY ============================

--- Build the command registry from NAG.lua handlers
---
--- Command Registry Structure:
--- - The hierarchical structure (core.help, rotation.next, data.cache) is for CODE ORGANIZATION ONLY
---   * Commands are stored hierarchically in the registry for grouping related functionality
---   * BUT: All commands are FLATTENED into flat registry for actual execution
---   * Example: `core.help` in registry → `/nag help` as flat command (not `/nag core help`)
---   * This allows code organization while maintaining simple flat command syntax
---
--- - Categories (core, rotation, system, data, debug, combat) are used for:
---   * Code organization (grouping related commands in registry)
---   * Help output grouping (ShowMainHelp)
---   * Search result grouping (SearchCommands)
---
--- - Flat commands are for quick access (e.g., /nag next, /nag prev, /nag help)
--- - Hierarchical commands (from modules) are for organized categories (e.g., /nagdebug ast validate)
--- - Module commands are auto-discovered and added to appropriate registries
--- - Hierarchical paths merge correctly (e.g., monitor ast + monitor string = monitor{ast, string})
--- - Conflicts (same path from different modules) will warn and last registration wins
---
--- Category Support:
--- - Modules can specify `category` field in slashCommands config (e.g., category = "Data")
--- - If category is not specified, it will be inferred from context:
---   * Hierarchical commands: Use first path segment (e.g., data.debug → "Data")
---   * Command name patterns: "tt*" → "Data", "debug/test/diag" → "Debug", "cache/stats" → "Data"
---   * Default: "Module Debug" (preserves backward compatibility)
--- - Categories are used for grouping in help output and search results
---
--- Registration Methods:
--- 1. CoreModule slashCommands table (automatic, recommended for modules)
--- 2. SlashCommandHandler:RegisterCommandDirect() (for non-CoreModule code, full functionality)
--- 3. ChatCommandUtils.RegisterCommand() (basic, no category/hierarchical support)
function SlashCommandHandler:BuildCommandRegistry()
    -- Build hierarchical structure for /nag commands (for organization only - all commands are flattened)
    -- This structure is used for code organization and help display, but commands execute as flat commands
    local nagHierarchical = {
        -- Core addon controls
        core = {
            help = {
                handler = function(input) self:ShowMainHelp() end,
                help = "Show NAG command help",
                category = "Core",
                module = "SlashCommandHandler"
            },
            enable = {
                handler = function(input) self:EnableAddon(input) end,
                help = "Enable the NAG addon",
                category = "Core",
                module = "SlashCommandHandler"
            },
            disable = {
                handler = function(input) self:DisableAddon(input) end,
                help = "Disable the NAG addon",
                category = "Core",
                module = "SlashCommandHandler"
            },
            lock = {
                handler = function(input) self:LockFrames(input) end,
                help = "Lock all NAG frames",
                category = "Core",
                module = "SlashCommandHandler"
            },
            unlock = {
                handler = function(input) self:UnlockFrames(input) end,
                help = "Unlock all NAG frames for editing",
                category = "Core",
                module = "SlashCommandHandler"
            },
            reload = {
                handler = function(input) self:ReloadUI(input) end,
                help = "Reload the UI",
                category = "Core",
                module = "SlashCommandHandler"
            },
            search = {
                handler = function(input) self:SearchCommands(input, false) end,
                help = "Search for commands by keyword",
                category = "Core",
                module = "SlashCommandHandler"
            }
        },

        -- Rotation management
        rotation = {
            next = {
                handler = function(input) self:NextRotation(input) end,
                help = "Switch to next rotation",
                category = "Rotation",
                module = "SlashCommandHandler"
            },
            prev = {
                handler = function(input) self:PrevRotation(input) end,
                help = "Switch to previous rotation",
                category = "Rotation",
                module = "SlashCommandHandler"
            },
            previous = {
                handler = function(input) self:PrevRotation(input) end,
                help = "Switch to previous rotation (alias for prev)",
                category = "Rotation",
                module = "SlashCommandHandler"
            },
            rot = {
                handler = function(input) self:HandleRotationCommand(input) end,
                help = "Rotation commands (next, prev, or rotation name)",
                category = "Rotation",
                module = "SlashCommandHandler"
            }
        },

        -- System commands
        system = {
            reset = {
                handler = function(input) self:HandleReset(input) end,
                help = "Reset NAG settings",
                category = "System",
                module = "SlashCommandHandler"
            },
            cooldowns = {
                handler = function(input) self:HandleCooldownsCommand(input) end,
                help = "Toggle visibility of cooldown/left frames. Usage: /nag cooldowns [on|off|toggle|status]",
                category = "System",
                module = "SlashCommandHandler",
                args = {"on", "off", "toggle", "status"}
            },
            aoeframe = {
                handler = function(input) self:HandleAoeFrameCommand(input) end,
                help = "Toggle visibility of AoE frame. Usage: /nag aoeframe [on|off|toggle|status]",
                category = "System",
                module = "SlashCommandHandler",
                args = {"on", "off", "toggle", "status"}
            }
        },

        -- Data commands
        data = {
            cache = {
                handler = function(input) self:HandleCache(input) end,
                help = "Cache management",
                category = "Data",
                module = "SlashCommandHandler"
            },
            leaderboard = {
                handler = function(input) self:HandleLeaderboard(input) end,
                help = "Leaderboard commands (reset)",
                category = "Data",
                module = "SlashCommandHandler",
                args = {"reset"}
            },
            sd = {
                handler = function(input) self:HandleSpellDump(input) end,
                help = "Dump spell/item data (requires DevTools)",
                category = "Data",
                module = "SlashCommandHandler"
            }
        },

        -- Configuration commands
        config = {
            blacklist = {
                handler = function(input) self:HandleBlacklist(input) end,
                help = "Manage spell blacklist (add/remove/list/clear)",
                category = "Configuration",
                module = "SlashCommandHandler"
            }
        },

        -- Debug commands (simple ones for /nag)
        debug = {
            debug = {
                handler = function(input) self:HandleDebugMode(input) end,
                help = "Toggle debug mode",
                category = "Debug",
                module = "SlashCommandHandler"
            },
            feraldebug = {
                handler = function(input) self:HandleFeralDebug(input) end,
                help = "Print feral powershift/rip/bite gate diagnostics",
                category = "Debug",
                module = "SlashCommandHandler"
            },
            stresstest = {
                handler = function(input)
                    local rotationManager = NAG:GetModule("RotationManager", true)
                    if not rotationManager or not rotationManager.RunStressTest then
                        NAG:Print("|cffff0000[NAG] Stress test is unavailable (RotationManager not ready)|r")
                        return
                    end
                    rotationManager:RunStressTest(input)
                end,
                help = "Run a controlled stress test. Usage: /nag stresstest [iterations=N] [time=S]",
                category = "Debug",
                module = "SlashCommandHandler"
            }
        },

        -- Note: AoE command is handled by TTDManager module directly
        -- It registers both /nag aoe and /nagdebug ttd aoe
    }

    -- Store hierarchical structure (for organization/help display)
    self.commands.nag.hierarchical = nagHierarchical

    -- Debug-specific commands for /nagdebug (flat commands)
    local nagdebugFlat = {
        help = {
            handler = function(input) self:ShowDebugHelp() end,
            help = "Show NAG debug command help",
            category = "Debug"
        },
        level = {
            handler = function(input) self:HandleDebugLevel(input) end,
            help = "Set debug level (0-5)",
            category = "Debug",
            args = {"0", "1", "2", "3", "4", "5"}
        },
        module = {
            handler = function(input) self:HandleDebugModule(input) end,
            help = "Set debug level for specific module",
            category = "Debug"
        },
        devmode = {
            handler = function(input) self:HandleDevMode(input) end,
            help = "Toggle developer mode",
            category = "Debug",
            args = {"on", "off", "toggle"}
        },
        throttle = {
            handler = function(input) self:HandleDebugThrottle(input) end,
            help = "Throttle debug commands",
            category = "Debug",
            args = {"clear", "info", "bypass", "stats", "reset"}
        },
        category = {
            handler = function(input) self:HandleDebugCategory(input) end,
            help = "Manage debug categories",
            category = "Debug",
            args = {"list", "listmodules", "enableall", "disableall", "toggleall"}
        },
        group = {
            handler = function(input) self:HandleDebugGroup(input) end,
            help = "Manage debug groups",
            category = "Debug"
        },
        system = {
            handler = function(input) self:HandleDebugSystem(input) end,
            help = "System diagnostics",
            category = "Debug",
            args = {"system", "modules", "lifecycle", "database", "spellcache", "rotations", "config", "init", "initverbose", "zero", "zeroverbose", "health", "healthverbose", "patterns", "patternsverbose", "issues", "issuesverbose", "fix", "fixverbose", "full", "fullverbose"}
        },
        search = {
            handler = function(input) self:SearchCommands(input, true) end,
            help = "Search for debug commands by keyword",
            category = "Debug"
        }
    }

    -- Store flat commands directly in unified structure
    self.commands.nagdebug.flat = nagdebugFlat
end

-- ============================ DEBUG COMMAND HELPER FUNCTIONS ============================

-- Helper to set global debug level
local function SetGlobalDebugLevel(level)
    local numLevel = tonumber(level)
    if not numLevel then
        NAG:Print("|cffff0000[NAG] Invalid debug level: " .. tostring(level) .. "|r")
        return
    end

    local OptionsManager = NAG and ns.OptionsManager
    if OptionsManager and OptionsManager.db then
        ns.DatabaseUtils.SetSetting(OptionsManager.db, "global", "debugLevel", numLevel)
        NAG:Print("|cff00ff00[NAG] Global debug level set to " .. numLevel .. "|r")
    end
end

-- Helper to set dev mode
local function SetDevMode(enabled)
    local OptionsManager = NAG and ns.OptionsManager
    if OptionsManager and OptionsManager.db then
        ns.DatabaseUtils.SetSetting(OptionsManager.db, "global", "enableDevMode", enabled)
        NAG:Print("|cff00ff00[NAG] Dev mode " .. (enabled and "enabled" or "disabled") .. "|r")
    end
end

-- Helper to get dev mode status
local function GetDevMode()
    if NAG and NAG.IsDevModeEnabled then
        return NAG:IsDevModeEnabled()
    end
    return false
end

-- Helper to toggle debug for a specific module
local function ToggleModuleDebug(moduleName)
    local module = NAG and NAG.modules and NAG.modules[moduleName]
    if not module then
        NAG:Print("|cffff0000[NAG] Module not found: " .. tostring(moduleName) .. "|r")
        return
    end

    local OptionsManager = NAG and ns.OptionsManager
    if OptionsManager and OptionsManager.db then
        local moduleDB = OptionsManager.db:GetNamespace(moduleName, true) -- silent = true
        if moduleDB and moduleDB.global then
            local currentState = moduleDB.global.debugEnabled
            local newState = currentState == false and true or false
            moduleDB.global.debugEnabled = newState
            NAG:Print("|cff00ff00[NAG] Debug for module '" ..
                moduleName .. "' " .. (newState and "enabled" or "disabled") .. "|r")
        else
            NAG:Print("|cffff0000[NAG] Module '" .. moduleName .. "' has no database access|r")
        end
    end
end

-- Helper to manage category-based debug
local function ManageCategoryDebug(category, action)
    if not category or category == "" then
        NAG:Print("|cffff0000[NAG] Category name required|r")
        return
    end

    local OptionsManager = NAG and ns.OptionsManager
    if not OptionsManager or not OptionsManager.db then
        NAG:Print("|cffff0000[NAG] OptionsManager not available|r")
        return
    end

    local settingKey = "debugCategories." .. category
    local currentState = ns.DatabaseUtils.GetSetting(OptionsManager.db, "global", settingKey, false)
    local newState = currentState

    if action == "on" or action == "enable" then
        newState = true
    elseif action == "off" or action == "disable" then
        newState = false
    elseif action == "toggle" then
        newState = not currentState
    else
        NAG:Print("|cffff0000[NAG] Invalid action. Use 'on', 'off', or 'toggle'|r")
        return
    end

    ns.DatabaseUtils.SetSetting(OptionsManager.db, "global", settingKey, newState)
    NAG:Print("|cff00ff00[NAG] Debug for category '" ..
        category .. "' " .. (newState and "enabled" or "disabled") .. "|r")

    -- Show which modules are affected
    if NAG and NAG.modules then
        local affectedModules = {}
        for moduleName, module in pairs(NAG.modules) do
            if module.GetDebugCategories then
                local moduleCategories = module:GetDebugCategories()
                for _, moduleCategory in ipairs(moduleCategories) do
                    if moduleCategory == category then
                        tinsert(affectedModules, moduleName)
                        break
                    end
                end
            end
        end

        if #affectedModules > 0 then
            NAG:Print("|cff00bfff[NAG] Affected modules: " .. table.concat(affectedModules, ", ") .. "|r")
        else
            NAG:Print("|cffff0000[NAG] No modules found in category '" .. category .. "'|r")
        end
    end
end

-- Helper to list all debug categories
local function ListDebugCategories()
    if not ns.DEBUG_CATEGORIES then
        NAG:Print("|cffff0000[NAG] Debug categories not available|r")
        return
    end

    NAG:Print("|cff00bfff[NAG] Available debug categories:|r")
    local categories = {}
    for _, category in pairs(ns.DEBUG_CATEGORIES) do
        tinsert(categories, category)
    end
    table.sort(categories)

    local OptionsManager = NAG and ns.OptionsManager
    for _, category in ipairs(categories) do
        local enabled = false
        if OptionsManager and OptionsManager.db then
            enabled = ns.DatabaseUtils.GetSetting(OptionsManager.db, "global", "debugCategories." .. category, false)
        end
        local status = enabled and "|cff00ff00[ENABLED]|r" or "|cffff0000[DISABLED]|r"
        NAG:Print("  " .. category .. " " .. status)
    end
end

-- Helper to list modules in a category
local function ListModulesInCategory(category)
    if not category or category == "" then
        NAG:Print("|cffff0000[NAG] Category name required|r")
        return
    end

    if not NAG or not NAG.modules then
        NAG:Print("|cffff0000[NAG] No modules available|r")
        return
    end

    local modules = {}
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

    if #modules > 0 then
        table.sort(modules)
        NAG:Print("|cff00bfff[NAG] Modules in category '" .. category .. "':|r")
        for _, moduleName in ipairs(modules) do
            NAG:Print("  " .. moduleName)
        end
    else
        NAG:Print("|cffff0000[NAG] No modules found in category '" .. category .. "'|r")
    end
end

-- Helper to enable/disable all debug categories
local function ManageAllCategories(action)
    if not ns.DEBUG_CATEGORIES then
        NAG:Print("|cffff0000[NAG] Debug categories not available|r")
        return
    end

    local OptionsManager = NAG and ns.OptionsManager
    if not OptionsManager or not OptionsManager.db then
        NAG:Print("|cffff0000[NAG] OptionsManager not available|r")
        return
    end

    local newState = (action == "on" or action == "enable")
    local count = 0

    for _, category in pairs(ns.DEBUG_CATEGORIES) do
        ns.DatabaseUtils.SetSetting(OptionsManager.db, "global", "debugCategories." .. category, newState)
        count = count + 1
    end

    NAG:Print("|cff00ff00[NAG] " .. count .. " debug categories " .. (newState and "enabled" or "disabled") .. "|r")
end

-- Helper to manage throttled logging
local function ManageThrottledLogging(cmd, arg)
    if not ns.DebugManager then
        NAG:Print("|cffff0000[NAG] DebugManager not available|r")
        return
    end

    if cmd == "clear" then
        if arg == "all" then
            ns.DebugManager:clear_all_throttles()
            NAG:Print("|cff00ff00[NAG] All throttle cache entries cleared|r")
        elseif arg ~= "" then
            -- Clear specific module throttle
            ns.DebugManager:clear_throttle(arg, "*") -- Clear all throttles for this module
            NAG:Print("|cff00ff00[NAG] Throttle cache cleared for module '" .. arg .. "'|r")
        else
            NAG:Print("|cffff0000[NAG] Usage: /nagdebug throttle clear <moduleName|all>|r")
        end
    elseif cmd == "info" then
        if arg ~= "" then
            -- Show throttle info for specific module
            local info = ns.DebugManager:get_throttle_info(arg, "*")
            NAG:Print("|cff00bfff[NAG] Throttle info for module '" .. arg .. "':|r")
            NAG:Print("  Cache key: " .. tostring(info.cacheKey))
            if info.lastLogTime then
                NAG:Print("  Last log time: " .. tostring(info.lastLogTime))
                NAG:Print("  Time since last log: " .. tostring(info.timeSinceLastLog) .. " seconds")
            else
                NAG:Print("  No throttle entries found")
            end
        else
            -- Show general throttle info - use stats to get cache size
            local stats = ns.DebugManager:get_throttle_stats()
            NAG:Print("|cff00bfff[NAG] Throttle cache info:|r")
            NAG:Print("  Total entries: " .. tostring(stats.cacheSize or 0))
        end
    elseif cmd == "bypass" then
        local argLower = strlower(arg)
        if argLower == "on" then
            ns.DebugManager:set_throttle_bypass(true)
        elseif argLower == "off" then
            ns.DebugManager:set_throttle_bypass(false)
        elseif argLower == "toggle" then
            local stats = ns.DebugManager:get_throttle_stats()
            ns.DebugManager:set_throttle_bypass(not stats.bypassEnabled)
        else
            NAG:Print("|cffff0000[NAG] Usage: /nagdebug throttle bypass <on|off|toggle>|r")
        end
    elseif cmd == "stats" then
        local stats = ns.DebugManager:get_throttle_stats()
        NAG:Print("|cff00bfff[NAG] Throttle Statistics:|r")
        NAG:Print("  Total calls: " .. stats.totalCalls)
        NAG:Print("  Throttled calls: " .. stats.throttledCalls)
        NAG:Print("  Throttle rate: " .. string.format("%.1f%%", stats.throttleRate))
        NAG:Print("  Bypass enabled: " .. tostring(stats.bypassEnabled))
        NAG:Print("  Last reset: " .. tostring(stats.lastResetTime))
    elseif cmd == "reset" then
        ns.DebugManager:reset_throttle_stats()
    else
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug throttle <clear|info|bypass|stats|reset> [moduleName|all|on|off|toggle]|r")
    end
end

--- Build flat command list for easy lookup
--- Flattens hierarchical structure (for organization) into flat commands (for execution)
--- Also ensures all hierarchical commands have fullPath set for consistency
function SlashCommandHandler:BuildFlatCommandList()
    -- Flatten hierarchical structure for /nag commands
    -- Commands stored hierarchically (core.help, rotation.next) are flattened to flat commands (help, next)
    -- Also adds fullPath to commands that don't have it (for consistency with module-registered commands)
    local function flattenTree(tree, flatCommands, currentPath)
        currentPath = currentPath or {}
        for category, commands in pairs(tree) do
            if type(commands) == "table" then
                for cmd, info in pairs(commands) do
                    if info.handler then
                        -- This is a command, ensure it has fullPath
                        if not info.fullPath then
                            -- Build fullPath from current path + this command
                            local fullPath = {}
                            for _, segment in ipairs(currentPath) do
                                tinsert(fullPath, segment)
                            end
                            tinsert(fullPath, cmd)
                            info.fullPath = fullPath
                        end
                        -- Add to flat list
                        flatCommands[cmd] = info
                    else
                        -- This is a nested category, recurse with updated path
                        local newPath = {}
                        for _, segment in ipairs(currentPath) do
                            tinsert(newPath, segment)
                        end
                        tinsert(newPath, cmd)
                        flattenTree({[cmd] = info}, flatCommands, newPath)
                    end
                end
            end
        end
    end

    -- Flatten /nag hierarchical structure
    flattenTree(self.commands.nag.hierarchical, self.commands.nag.flat)
end

--- Build alias mappings for backward compatibility
--- Aliases are populated by DiscoverModuleCommands(); root slash registration happens in RegisterRootAliasCommands().
function SlashCommandHandler:BuildAliases()
    self.aliases = {}
end

--- Register each tracked alias as a root slash command (e.g. /nagaoe) so it forwards to the canonical command.
--- Must be called after DiscoverModuleCommands() so self.aliases is populated.
function SlashCommandHandler:RegisterRootAliasCommands()
    for alias, mapping in pairs(self.aliases) do
        local targetDisplay = mapping.isDebugCommand and ("/nagdebug " .. mapping.command) or ("/nag " .. mapping.command)
        local helpText = format("Alias for %s. Usage: /%s [args]", targetDisplay, alias)
        NAG:RegisterChatCommand(alias, function(input)
            self:HandleAlias(alias, input)
        end, false)
        self:Debug("Registered root alias: /%s → %s", alias, targetDisplay)
    end
end

--- Handle alias command
--- @param alias string The alias command
--- @param input string The input arguments
function SlashCommandHandler:HandleAlias(alias, input)
    local mapping = self.aliases[alias]
    if not mapping then
        self:Error("Unknown alias: " .. alias)
        return
    end

    -- Build the full command with default args if provided
    local fullInput = input
    if mapping.args and (not input or input == "") then
        fullInput = mapping.args
    end

    -- Route to appropriate handler
    if mapping.isDebugCommand then
        self:HandleDebugCommand(mapping.command .. " " .. (fullInput or ""))
    else
        -- Find the command in the unified registry
        local root = mapping.isDebugCommand and "nagdebug" or "nag"
        local cmdInfo = self:FindFlatCommand(root, mapping.command)
        if cmdInfo and cmdInfo.handler then
            cmdInfo.handler(fullInput or "")
        else
            self:Error("Alias target not found: " .. mapping.command)
        end
    end
end

--- Infer category for a command based on context when not explicitly specified
--- @param command string Command name
--- @param info table Command info from ns.SlashCommands
--- @return string Inferred category
local function InferCategory(command, info)
    -- If category is explicitly set, use it
    if info.category then
        return info.category
    end

    -- For hierarchical commands, use first path segment as hint
    if info.isHierarchical and info.path and #info.path > 0 then
        local firstSegment = info.path[1]
        -- Capitalize first letter
        return firstSegment:sub(1, 1):upper() .. firstSegment:sub(2):lower()
    end

    -- Command name patterns
    local cmdLower = strlower(command)

    -- TooltipParser commands (tt*)
    if cmdLower:match("^tt") then
        return "Data"
    end

    -- Debug/test/diagnostic patterns
    if cmdLower:match("debug") or cmdLower:match("test") or cmdLower:match("diag") then
        return "Debug"
    end

    -- Cache/stats patterns
    if cmdLower:match("cache") or cmdLower:match("stats") then
        return "Data"
    end

    -- Default: Module Debug (preserves current behavior)
    return "Module Debug"
end

--- This integrates all module-registered commands into the unified command structure
---
--- Category handling:
--- - Uses explicit category from info.category if available
--- - Otherwise infers category using InferCategory() function
--- - Categories are stored in both hierarchical and flat command info for grouping
--- - Routes commands to correct root (nag or nagdebug) based on info.root
function SlashCommandHandler:DiscoverModuleCommands()
    if not ns.SlashCommands then
        self:Debug("No module commands to discover (ns.SlashCommands is nil)")
        return
    end

    local discoveredCount = 0

    for command, info in pairs(ns.SlashCommands) do
        -- Skip root commands (nag and nagdebug are handled separately)
        if command == "nag" or command == "nagdebug" then
            self:Debug("Skipping root command: " .. command)
        else
            -- Determine root command (should always be set after standardization)
            local root = info.root
            if not root then
                self:Warn("DiscoverModuleCommands: Command '%s' from module '%s' missing root field - defaulting to nagdebug", command, info.module or "Unknown")
                root = "nagdebug"
            end

            -- Check if we already have this command in our unified registries
            local alreadyExists = false
            if info.isHierarchical then
                -- Check hierarchical structure
                local tree = self.commands[root].hierarchical
                local current = tree
                for _, segment in ipairs(info.path) do
                    if current[segment] then
                        if current[segment].handler then
                            alreadyExists = true
                            break
                        else
                            current = current[segment]
                        end
                    else
                        break
                    end
                end
            else
                -- Check flat structure
                alreadyExists = self.commands[root].flat[command] ~= nil
            end

            if alreadyExists then
                self:Debug("Skipping already registered command: " .. command)
            else
                if info.isHierarchical then
                    -- Build hierarchical tree structure in unified structure
                    local unifiedTree = self.commands[root].hierarchical
                    local current = unifiedTree

                    for i, segment in ipairs(info.path) do
                        if i == #info.path then
                            -- Leaf node: store command info
                            local cmdInfo = {
                                handler = info.handler,
                                help = info.help,
                                module = info.module,
                                fullPath = info.path,
                                category = InferCategory(command, info)  -- Store inferred or explicit category
                            }

                            -- Check for conflicts (same path registered by different modules)
                            if current[segment] and current[segment].handler then
                                self:Warn("Command conflict detected: /%s %s already registered by module '%s', overwriting with module '%s'",
                                    root, table.concat(info.path, " "),
                                    current[segment].module or "Unknown",
                                    info.module or "Unknown")
                            end

                            -- Store in unified structure
                            current[segment] = cmdInfo
                        else
                            -- Branch node: create subtree (or reuse existing)
                            -- Multiple modules can share the same branch (e.g., monitor ast + monitor string)
                            current[segment] = current[segment] or {}
                            current = current[segment]
                        end
                    end

                    discoveredCount = discoveredCount + 1
                    self:Trace("Discovered hierarchical command: /%s %s (from %s)",
                        root, table.concat(info.path, " "), info.module)
                else
                    -- Flat command: route to correct root based on info.root
                    local cleanCommand = command

                    -- Get module name for categorization
                    local moduleName = info.module or "Unknown"

                    -- Get the actual module to call its handler
                    local module = NAG:GetModule(moduleName, true) -- true = silent if not found

                    -- Create command info
                    local cmdInfo = {
                        handler = function(input)
                            -- Delegate to the module's handler method
                            if module then
                                local handlerName = info.handler

                                -- If handler is a function (inline handler), call it directly
                                if type(handlerName) == "function" then
                                    handlerName(input)
                                -- If handler is a method name string, call it
                                elseif type(handlerName) == "string" and handlerName ~= "inline_function" and module[handlerName] then
                                    module[handlerName](module, input)
                                elseif type(module[command]) == "function" then
                                    -- Try using the command name as the method name
                                    module[command](module, input)
                                else
                                    -- Command was registered with inline function via ChatCommandUtils
                                    -- We can't call it directly, but the original /command still works
                                    self:Warn("Use /%s instead - command uses inline handler", command)
                                end
                            else
                                self:Warn("Module '%s' not found for command: %s", moduleName, command)
                            end
                        end,
                        help = info.help or format("%s command", moduleName),
                        module = moduleName,
                        originalCommand = command,
                        category = InferCategory(cleanCommand, info)  -- Use explicit category or infer from context
                    }

                    -- Store in unified structure (route to correct root)
                    self.commands[root].flat[cleanCommand] = cmdInfo

                    -- Register aliases if specified in the command info
                    -- Aliases (e.g. nagaoe) are tracked here; RegisterRootAliasCommands() registers them as root slash commands
                    if info.aliases and type(info.aliases) == "table" then
                        for _, alias in ipairs(info.aliases) do
                            if not self.aliases[alias] then
                                self.aliases[alias] = {
                                    command = cleanCommand,
                                    category = "Combat",
                                    isDebugCommand = (root == "nagdebug"),
                                    args = nil,
                                    module = moduleName
                                }
                                self:Debug("Tracked alias: /%s → /%s %s", alias, root, cleanCommand)
                            end
                        end
                    end

                    discoveredCount = discoveredCount + 1
                    --self:Debug("Discovered flat module command: /%s → /%s %s (from %s)",
                    --    command, root, cleanCommand, moduleName)
                end
            end
        end
    end

    self:Debug("Auto-discovered %d module commands", discoveredCount)

    -- Debug: Show what hierarchical commands were found
    for root, rootData in pairs(self.commands) do
        if rootData.hierarchical then
            local count = 0
            for _ in pairs(rootData.hierarchical) do count = count + 1 end
            if count > 0 then
                self:Debug("Hierarchical commands for /%s: %d top-level categories", root, count)
                self:Debug("Tree structure: %s", self:DebugTreeStructure(rootData.hierarchical))
            end
        end
    end
end

-- ============================ UNIFIED COMMAND LOOKUP FUNCTIONS ============================

--- Find flat command in the unified command registry
--- @param root string The root command (nag or nagdebug)
--- @param command string The command name (lowercase)
--- @return table|nil Command info if found
function SlashCommandHandler:FindFlatCommand(root, command)
    if not self.commands[root] or not self.commands[root].flat then
        return nil
    end
    return self.commands[root].flat[command]
end

--- Find hierarchical command in the unified command tree
--- @param root string The root command (nag or nagdebug)
--- @param segments table Array of path segments (lowercase)
--- @return table|nil Command info if found (leaf node with handler)
--- @return table|nil Category tree if found (branch node without handler)
function SlashCommandHandler:FindHierarchicalCommand(root, segments)
    local rootData = self.commands[root]
    if not rootData or not rootData.hierarchical then return nil, nil end
    local tree = rootData.hierarchical

    local current = tree
    for i, segment in ipairs(segments) do
        if type(current[segment]) == "table" then
            if current[segment].handler then
                -- Found command (leaf node)
                -- Ensure fullPath is set (should be set by BuildFlatCommandList, but ensure it here too)
                if not current[segment].fullPath then
                    -- Build fullPath from segments consumed so far
                    local fullPath = {}
                    for j = 1, i do
                        tinsert(fullPath, segments[j])
                    end
                    current[segment].fullPath = fullPath
                end
                return current[segment], nil
            else
                -- Continue down tree
                current = current[segment]
            end
        else
            return nil, nil
        end
    end

    -- If we've navigated through all segments but current has no handler,
    -- we're at a category (branch node), not a command
    if current and type(current) == "table" and not current.handler then
        return nil, current
    end

    return nil, nil
end

--- Unified command lookup - tries hierarchical first, then flat
--- @param root string The root command (nag or nagdebug)
--- @param input string The full command input
--- @return table|nil Command info if found (hierarchical or flat)
--- @return string|nil Remaining arguments after command
--- @return string|nil Command type: "hierarchical", "flat", or "category"
--- @return table|nil Category tree if input matches a category (branch node)
function SlashCommandHandler:FindCommand(root, input)
    if not input or input == "" then
        return nil, nil, nil, nil
    end

    -- Parse input into segments
    local originalSegments = {}
    local lowerSegments = {}
    for segment in input:gmatch("%S+") do
        tinsert(originalSegments, segment)
        tinsert(lowerSegments, strlower(segment))
    end

    -- Try hierarchical first
    local cmdInfo, categoryTree = self:FindHierarchicalCommand(root, lowerSegments)
    if cmdInfo then
        -- fullPath should always be set now (by BuildFlatCommandList or FindHierarchicalCommand)
        if not cmdInfo.fullPath then
            self:Warn("FindCommand: Command found without fullPath - this should not happen")
        end
        local pathLength = cmdInfo.fullPath and #cmdInfo.fullPath or #lowerSegments
        local remainingArgs = table.concat(originalSegments, " ", pathLength + 1)
        return cmdInfo, remainingArgs, "hierarchical", nil
    elseif categoryTree then
        -- Found a category (branch node), not a command
        return nil, nil, "category", categoryTree
    end

    -- Try flat command
    local command = lowerSegments[1]
    if command then
        local flatCmdInfo = self:FindFlatCommand(root, command)
        if flatCmdInfo then
            local remainingArgs = table.concat(originalSegments, " ", 2)
            return flatCmdInfo, remainingArgs, "flat", nil
        end
    end

    return nil, nil, nil, nil
end

--- Execute a command with the given info
--- @param cmdInfo table Command information
--- @param args string Remaining arguments
function SlashCommandHandler:ExecuteCommand(cmdInfo, args)
    local module = NAG:GetModule(cmdInfo.module, true)
    if not module then
        self:Warn("Module '%s' not found for command", cmdInfo.module)
        return
    end

    local handlerName = cmdInfo.handler
    if type(handlerName) == "function" then
        handlerName(args)
    elseif type(handlerName) == "string" and module[handlerName] then
        module[handlerName](module, args)
    elseif handlerName == true then
        -- handler = true means use command name as method name
        -- For hierarchical commands, construct method name from fullPath
        local methodName = nil
        if cmdInfo.fullPath and type(cmdInfo.fullPath) == "table" then
            methodName = table.concat(cmdInfo.fullPath, "_")
        elseif cmdInfo.originalCommand then
            -- Fallback to originalCommand if fullPath not available (shouldn't happen)
            methodName = cmdInfo.originalCommand
        end

        if methodName and module[methodName] then
            module[methodName](module, args)
        else
            self:Warn("Handler not found for command (tried method: %s)", methodName or "unknown")
        end
    else
        self:Warn("Handler not found for command")
    end
end

--- Show help for a category (branch node) when user types partial hierarchical path
--- @param root string The root command (nag or nagdebug)
--- @param input string The input that matched a category
--- @param categoryTree table The category tree (branch node)
function SlashCommandHandler:ShowCategoryHelp(root, input, categoryTree)
    local rootDisplay = "/" .. root
    local fullPath = rootDisplay .. " " .. input

    NAG:Print(format("|cff00bfff%s|r is a category, not a command.", fullPath))
    NAG:Print("Available subcommands:")
    NAG:Print(" ")

    -- Collect all subcommands (both leaf commands and nested categories)
    local subcommands = {}
    for key, value in pairs(categoryTree) do
        if value.handler then
            -- Leaf command
            tinsert(subcommands, {
                name = key,
                help = value.help or "No description",
                isCommand = true,
                fullPath = value.fullPath
            })
        else
            -- Nested category
            tinsert(subcommands, {
                name = key,
                help = "Category",
                isCommand = false
            })
        end
    end

    -- Sort by name
    table.sort(subcommands, function(a, b) return a.name < b.name end)

    -- Display commands first, then categories
    for _, subcmd in ipairs(subcommands) do
        if subcmd.isCommand then
            local cmdPath = fullPath .. " " .. subcmd.name
            if subcmd.fullPath then
                cmdPath = rootDisplay .. " " .. table.concat(subcmd.fullPath, " ")
            end
            NAG:Print(format("  |cffffaa00%s|r - %s", cmdPath, subcmd.help))
        else
            NAG:Print(format("  |cff00bfff%s %s|r - Category (use: /%s %s %s <subcommand>)",
                fullPath, subcmd.name, root, input, subcmd.name))
        end
    end

    NAG:Print(" ")
    NAG:Print(format("Type |cff00ff00/%s help|r for full command list", root))
end

--- Print hierarchical command tree
--- @param tree table Command tree
--- @param rootDisplay string Root display (e.g., "/nag") - used for fullPath commands
--- @param currentPath table Current path segments in tree (for building paths when fullPath missing)
--- @param depth number Current depth
function SlashCommandHandler:PrintCommandTree(tree, rootDisplay, currentPath, depth)
    currentPath = currentPath or {}
    local indent = string.rep("  ", depth)

    for key, value in pairs(tree) do
        if value.handler then
            -- Leaf node: actual command
            -- If fullPath exists, use it directly (it's the complete path from root)
            -- Otherwise, build from current path context (for commands stored hierarchically for organization)
            local cmdPath
            if value.fullPath and type(value.fullPath) == "table" then
                -- Real hierarchical command: fullPath is complete from root, use it directly
                cmdPath = rootDisplay .. " " .. table.concat(value.fullPath, " ")
            else
                -- Flat command stored in hierarchical structure for organization: build from current path
                -- This shouldn't happen after BuildFlatCommandList, but handle it gracefully
                local pathSegments = {}
                for _, segment in ipairs(currentPath) do
                    tinsert(pathSegments, segment)
                end
                tinsert(pathSegments, key)
                cmdPath = rootDisplay .. " " .. table.concat(pathSegments, " ")
            end
            NAG:Print(format("%s|cffffaa00%s|r - %s |cff888888(%s)|r",
                indent, cmdPath, value.help or "No description", value.module or "SlashCommandHandler"))
        else
            -- Branch node: category - show example subcommands for clarity
            local subcommands = {}
            for subkey, subvalue in pairs(value) do
                if subvalue.handler then
                    tinsert(subcommands, subkey)
                else
                    -- Nested category, just show the name
                    tinsert(subcommands, subkey)
                end
            end

            -- Show category with example subcommands
            if #subcommands > 0 then
                table.sort(subcommands)
                local examples = {}
                for i = 1, math.min(3, #subcommands) do
                    tinsert(examples, subcommands[i])
                end
                local exampleText = table.concat(examples, ", ")
                if #subcommands > 3 then
                    exampleText = exampleText .. ", ..."
                end
                NAG:Print(format("%s|cff00bfff%s:|r |cff888888(category - subcommands: %s)|r",
                    indent, key, exampleText))
            else
                NAG:Print(format("%s|cff00bfff%s:|r", indent, key))
            end
            -- Recurse with updated current path
            local newPath = {}
            for _, segment in ipairs(currentPath) do
                tinsert(newPath, segment)
            end
            tinsert(newPath, key)
            self:PrintCommandTree(value, rootDisplay, newPath, depth + 1)
        end
    end
end

--- Add hierarchical command usage for tab completion
--- @param candUsage table Usage table to populate
--- @param tree table Command tree
--- @param prefix string Current prefix
function SlashCommandHandler:AddHierarchicalUsage(candUsage, tree, prefix, rootCommand)
    rootCommand = rootCommand or "nagdebug"  -- Default to nagdebug for backward compatibility
    for key, value in pairs(tree) do
        local fullKey = prefix == "" and key or prefix .. " " .. key

        if value.handler then
            -- Leaf node: actual command
            candUsage[fullKey] = value.help or "No description"
        else
            -- Branch node: category - collect example subcommands for better clarity
            local subcommands = {}
            for subkey, subvalue in pairs(value) do
                if subvalue.handler then
                    -- This is a leaf command under this category
                    tinsert(subcommands, subkey)
                else
                    -- This is a nested category, just show the category name
                    tinsert(subcommands, subkey)
                end
            end

            -- Limit to 3 examples to keep it concise
            local exampleText = ""
            if #subcommands > 0 then
                table.sort(subcommands)
                local examples = {}
                for i = 1, math.min(3, #subcommands) do
                    tinsert(examples, subcommands[i])
                end
                exampleText = " (e.g., " .. table.concat(examples, ", ") .. (#subcommands > 3 and ", ..." or "") .. ")"
            end

            candUsage[fullKey] = "Category" .. exampleText .. " - use: /" .. rootCommand .. " " .. fullKey .. " <subcommand>"
            -- Recursively add sub-commands
            self:AddHierarchicalUsage(candUsage, value, fullKey, rootCommand)
        end
    end
end

--- Debug helper to show tree structure
--- @param tree table Command tree
--- @return string Debug representation
function SlashCommandHandler:DebugTreeStructure(tree)
    if not tree then return "nil" end
    if type(tree) ~= "table" then return tostring(tree) end

    local parts = {}
    for root, subtree in pairs(tree) do
        if type(subtree) == "table" then
            tinsert(parts, root .. "=" .. self:DebugTreeStructure(subtree))
        else
            tinsert(parts, root .. "=" .. tostring(subtree))
        end
    end
    return "{" .. table.concat(parts, ",") .. "}"
end

--- Count total commands
--- @return number Total command count
function SlashCommandHandler:CountCommands()
    local count = 0
    -- Count from unified structure
    for root, rootData in pairs(self.commands) do
        if rootData.flat then
            for _ in pairs(rootData.flat) do
                count = count + 1
            end
        end
        -- Note: Hierarchical commands are counted as part of their tree structure
        -- We don't double-count them here
    end
    return count
end

-- ============================ DIRECT COMMAND REGISTRATION API ============================

--- Direct registration API for commands outside of CoreModule slashCommands system
--- This provides full functionality: hierarchical paths, categories, help text, etc.
---
--- Usage examples:
---   -- Flat command
---   SlashCommandHandler:RegisterCommandDirect("nagdebug", "mytest", function(input) print("Test") end, "Test command", "Debug")
---
---   -- Hierarchical command
---   SlashCommandHandler:RegisterCommandDirect("nagdebug", {"ast", "validate"}, function(input) print("Validate") end, "Validate AST", "Debug")
---
--- @param root string The root command ("nag" or "nagdebug")
--- @param command string|table Command name (flat) or path array (hierarchical)
--- @param handler function|string Handler function or method name
--- @param help string Help text for the command
--- @param category string|nil Optional category (will be inferred if not provided)
--- @param module string|nil Optional module name (for tracking)
--- @return boolean True if registration succeeded
function SlashCommandHandler:RegisterCommandDirect(root, command, handler, help, category, module)
    if not root or (root ~= "nag" and root ~= "nagdebug") then
        self:Error("RegisterCommandDirect: root must be 'nag' or 'nagdebug', got: " .. tostring(root))
        return false
    end

    if not command then
        self:Error("RegisterCommandDirect: command is required")
        return false
    end

    if not handler then
        self:Error("RegisterCommandDirect: handler is required")
        return false
    end

    help = help or "No description"
    module = module or "DirectRegistration"

    local isHierarchical = type(command) == "table"
    local pathArray = isHierarchical and command or nil
    local commandName = isHierarchical and table.concat(command, "_") or command

    -- Create command info
    local cmdInfo = {
        handler = handler,
        help = help,
        module = module,
        category = category,
        fullPath = pathArray
    }

    if isHierarchical then
        -- Hierarchical command: build tree structure
        local tree = self.commands[root].hierarchical
        local current = tree

        for i, segment in ipairs(pathArray) do
            if i == #pathArray then
                -- Leaf node: store command info
                if current[segment] and current[segment].handler then
                    self:Warn("RegisterCommandDirect: Command conflict - /%s %s already registered, overwriting",
                        root, table.concat(pathArray, " "))
                end
                current[segment] = cmdInfo
            else
                -- Branch node: create or reuse subtree
                current[segment] = current[segment] or {}
                current = current[segment]
            end
        end


        self:Debug("Registered hierarchical command directly: /%s %s", root, table.concat(pathArray, " "))
    else
        -- Flat command: add to flat registry
        if self.commands[root].flat[command] then
            self:Warn("RegisterCommandDirect: Flat command /%s %s already registered, overwriting", root, command)
        end

        self.commands[root].flat[command] = cmdInfo

        self:Debug("Registered flat command directly: /%s %s", root, command)
    end

    -- Infer category if not provided (use the same inference logic as DiscoverModuleCommands)
    if not category then
        -- Use the same inference logic
        if isHierarchical and pathArray and #pathArray > 0 then
            local firstSegment = pathArray[1]
            category = firstSegment:sub(1, 1):upper() .. firstSegment:sub(2):lower()
        else
            local cmdLower = strlower(commandName)
            if cmdLower:match("^tt") then
                category = "Data"
            elseif cmdLower:match("debug") or cmdLower:match("test") or cmdLower:match("diag") then
                category = "Debug"
            elseif cmdLower:match("cache") or cmdLower:match("stats") then
                category = "Data"
            else
                category = "Module Debug"
            end
        end
        cmdInfo.category = category
    end

    return true
end

-- ============================ TAB COMPLETION ============================

--- Register tab completion for all commands
function SlashCommandHandler:RegisterTabCompletion()
    if not AceTab then
        self:Error("AceTab-3.0 not available, tab completion disabled")
        return
    end

    -- Hook into AceTab to make repeated tab presses show the list again instead of cycling
    -- This allows users to re-display the completion list if chat spam covered it
    local originalOnTabPressed = AceTab.OnTabPressed
    AceTab.OnTabPressed = function(self, this)
        -- Check if we're in a cycling state (text hasn't changed since last tab)
        local text_precursor = this:GetText():sub(1, this:GetCursorPosition())

        -- If we're cycling (text hasn't changed) and this is a NAG command, force show list again
        if text_precursor == (this.at3_last_precursor or "") and this.at3curMatch and this.at3curMatch > 0 then
            local cmd = text_precursor:match("^/([%a%d_]+)")
            if cmd == "nag" or cmd == "nagdebug" then
                -- Force AceTab to think the text changed by modifying the stored precursor
                -- This will make it show the list again instead of cycling
                this.at3_last_precursor = "\0"  -- Set to invalid value to force reset
                this.at3curMatch = 0  -- Reset match index
                -- Clear matches to force re-filling
                for i in pairs(this.at3matches) do this.at3matches[i] = nil end
            end
        end

        -- Call original function
        return originalOnTabPressed(self, this)
    end

    self:Debug("Registering tab completion - nagdebug flat commands: %d entries",
        self.commands.nagdebug and self.commands.nagdebug.flat and ns.TableUtils.Size(self.commands.nagdebug.flat) or 0)
    self:Debug("Registering tab completion - nagdebug hierarchical exists: %s",
        tostring(self.commands.nagdebug and self.commands.nagdebug.hierarchical ~= nil))

    --- Get completions from a category tree (branch node)
    --- This is used by both tab completion and category help display
    --- @param categoryTree table The category tree (branch node)
    --- @param prefix string Optional prefix to prepend to completions
    --- @return table Array of completion strings
    local function GetCompletionsFromCategory(categoryTree, prefix)
        prefix = prefix or ""
        local completions = {}
        for key in pairs(categoryTree) do
            tinsert(completions, prefix .. key)
        end
        return completions
    end

    --- Shared hierarchical tab completion logic for both /nag and /nagdebug
    --- This function uses the unified FindHierarchicalCommand logic to ensure consistency
    --- between tab completion and command execution.
    --- @param rootName string The root command name ("nag" or "nagdebug")
    --- @param completions table The completions table to populate
    --- @param text string The full command text
    --- @param start number The start position after the command
    --- @param partial string The partial word being typed
    --- @return boolean True if hierarchical completion was handled (early return case)
    local function HandleHierarchicalCompletion(rootName, completions, text, start, partial)
        self:Trace("=== /%s TAB COMPLETION DEBUG ===", rootName)
        self:Trace("text: '%s', start: %s, partial: '%s'", tostring(text), tostring(start), tostring(partial))

        -- Extract the text after the command using the start position
        local afterCommand = strsub(text, start)
        self:Trace("afterCommand: '%s'", tostring(afterCommand))

        -- Build input string for unified command lookup
        -- We need to parse complete words (not including the partial word being typed)
        local inputSegments = {}
        if afterCommand and afterCommand ~= "" then
            local words = {}
            for word in afterCommand:gmatch("%S+") do
                tinsert(words, word)
            end

            -- Check if the last word is complete (followed by space) or partial
            local lastWordComplete = afterCommand:match("%s$")

            -- Special case: if partial is empty and we have words, the last word might be complete
            if not lastWordComplete and #words > 0 and (not partial or partial == "") then
                -- Check if the original text ends with a space (meaning the last word is complete)
                if text:match("%s$") then
                    lastWordComplete = true
                end
            end

            if lastWordComplete then
                -- All words are complete segments
                for i = 1, #words do
                    tinsert(inputSegments, words[i])
                end
            else
                -- All words except the last one are complete segments
                for i = 1, #words - 1 do
                    tinsert(inputSegments, words[i])
                end
            end
        end

        local inputForLookup = table.concat(inputSegments, " ")
        self:Trace("inputForLookup: '%s'", inputForLookup)

        -- Use unified command lookup to find category or command
        -- This ensures tab completion uses the exact same logic as command execution
        local cmdInfo, remainingArgs, cmdType, categoryTree = self:FindCommand(rootName, inputForLookup)

        if cmdType == "category" and categoryTree then
            -- Found a category (branch node) - add its children as completions
            self:Trace("Found category, adding children")
            local categoryCompletions = GetCompletionsFromCategory(categoryTree, partial)
            for _, completion in ipairs(categoryCompletions) do
                tinsert(completions, completion)
            end
            self:Trace("=== END /%s DEBUG (category) ===", rootName)
            return true
        elseif cmdType == "hierarchical" or cmdType == "flat" then
            -- Found an actual command - no completions needed (command is complete)
            self:Trace("Found command (type: %s), no completions", cmdType)
            return false
        end

        -- No segments - show first-level commands (flat + hierarchical categories)
        if #inputSegments == 0 then
            self:Trace("No segments, showing first-level commands")
            -- Add flat commands from unified structure
            local rootCommands = self.commands[rootName]
            if rootCommands and rootCommands.flat then
                for cmd in pairs(rootCommands.flat) do
                    tinsert(completions, cmd)
                end
            end

            -- Add hierarchical command categories from unified structure
            if rootCommands and rootCommands.hierarchical then
                for key, value in pairs(rootCommands.hierarchical) do
                    if type(value) == "table" and not value.handler then
                        tinsert(completions, key)
                        self:Trace("Added hierarchical category: '%s'", key)
                    end
                end
            end
        else
            -- Special case: if we have a partial word that's a valid category
            if partial and partial ~= "" then
                local rootCommands = self.commands[rootName]
                local hierarchicalTree = rootCommands and rootCommands.hierarchical
                if hierarchicalTree then
                    local categoryTree = hierarchicalTree[partial]
                    if categoryTree and type(categoryTree) == "table" and not categoryTree.handler then
                        local categoryCompletions = GetCompletionsFromCategory(categoryTree, "")
                        for _, completion in ipairs(categoryCompletions) do
                            tinsert(completions, completion)
                        end
                        return true
                    end
                end
            end
        end

        self:Trace("=== END /%s DEBUG ===", rootName)
        return false -- No hierarchical completion, caller can add extra items
    end

    -- Tab completion for /nag (uses shared hierarchical logic)
    AceTab:RegisterTabCompletion("NAG Main Commands", "/nag ",
        function(completions, text, start, partial)
            -- Use shared hierarchical completion logic
            local hierarchicalHandled = HandleHierarchicalCompletion("nag", completions, text, start, partial)

            -- If hierarchical completion handled it, we're done
            if hierarchicalHandled then
                return
            end

            -- Add /nag-specific options tab names for direct access (first-level only)
            if OptionsManager then
                local options = OptionsManager:GetOptions()
                if options and options.args then
                    local nagCommands = self.commands.nag
                    for tabName in pairs(options.args) do
                        local tabNameLower = strlower(tabName)
                        -- Only add if not already a command
                        if not (nagCommands and nagCommands.flat and nagCommands.flat[tabNameLower]) then
                            tinsert(completions, tabNameLower)
                        end
                    end
                end
            end
        end,
        function(candUsage)
            -- Add flat command usage from unified structure
            local nagCommands = self.commands.nag
            if nagCommands and nagCommands.flat then
                for cmd, info in pairs(nagCommands.flat) do
                    candUsage[cmd] = info.help or "No description"
                end
            end

            -- Add hierarchical command usage from unified structure
            if nagCommands and nagCommands.hierarchical then
                self:AddHierarchicalUsage(candUsage, nagCommands.hierarchical, "", "nag")
            end

            -- Add help for options tabs
            if OptionsManager then
                local options = OptionsManager:GetOptions()
                if options and options.args then
                    for tabName, tabData in pairs(options.args) do
                        local tabNameLower = strlower(tabName)
                        if not (nagCommands and nagCommands.flat and nagCommands.flat[tabNameLower]) then
                            candUsage[tabNameLower] = format("Open %s options", tabData.name or tabName)
                        end
                    end
                end
            end

            return nil
        end
    )

    -- Tab completion for /nagdebug (uses shared hierarchical logic)
    AceTab:RegisterTabCompletion("NAG Debug Commands", "/nagdebug ",
        function(completions, text, start, partial)
            -- Use shared hierarchical completion logic
            HandleHierarchicalCompletion("nagdebug", completions, text, start, partial)
            -- No additional /nagdebug-specific completions needed (unlike /nag which adds options)
        end,
        function(candUsage)
            -- Add flat command usage from unified structure
            local nagdebugCommands = self.commands.nagdebug
            if nagdebugCommands and nagdebugCommands.flat then
                for cmd, info in pairs(nagdebugCommands.flat) do
                    candUsage[cmd] = info.help or "No description"
                end
            end

            -- Add hierarchical command usage from unified structure
            if nagdebugCommands and nagdebugCommands.hierarchical then
                self:AddHierarchicalUsage(candUsage, nagdebugCommands.hierarchical, "", "nagdebug")
            end
            return nil
        end
    )

    -- Tab completion for subcommand arguments
    self:RegisterSubcommandCompletion()

    self:Debug("Tab completion registered for /nag and /nagdebug")
end

--- Register tab completion for subcommand arguments
function SlashCommandHandler:RegisterSubcommandCompletion()
    -- Reset command args
    AceTab:RegisterTabCompletion("NAG Reset Args", "/nag reset ", function(completions)
        tinsert(completions, "all")
        tinsert(completions, "global")
        tinsert(completions, "char")
        tinsert(completions, "character")
        tinsert(completions, "class")
        tinsert(completions, "position")
        tinsert(completions, "pos")
    end, function(candUsage)
        candUsage["all"] = "Reset all settings (global, char, class, profile)"
        candUsage["global"] = "Reset global settings only"
        candUsage["char"] = "Reset character settings only"
        candUsage["character"] = "Reset character settings only (alias)"
        candUsage["class"] = "Reset class-specific settings only"
        candUsage["position"] = "Reset frame position and scale only"
        candUsage["pos"] = "Reset frame position and scale only (alias)"
        return nil
    end)


    -- Cache command args
    AceTab:RegisterTabCompletion("NAG Cache Args", "/nag cache ", function(completions)
        tinsert(completions, "stats")
        tinsert(completions, "clear")
        tinsert(completions, "list")
    end, function(candUsage)
        candUsage["stats"] = "Show cache statistics"
        candUsage["clear"] = "Clear entire rotation cache"
        candUsage["list"] = "List all cached rotations"
        return nil
    end)

    AceTab:RegisterTabCompletion("NAG Leaderboard Args", "/nag leaderboard ", function(completions)
        tinsert(completions, "reset")
    end, function(candUsage)
        candUsage["reset"] = "Reset leaderboard data only"
        return nil
    end)

    -- Debug command args
    AceTab:RegisterTabCompletion("NAG Debug Args", "/nag debug ", function(completions)
        tinsert(completions, "on")
        tinsert(completions, "off")
        tinsert(completions, "enable")
        tinsert(completions, "disable")
        tinsert(completions, "toggle")
    end, function(candUsage)
        candUsage["on"] = "Enable debug mode"
        candUsage["off"] = "Disable debug mode"
        candUsage["enable"] = "Enable debug mode (alias)"
        candUsage["disable"] = "Disable debug mode (alias)"
        candUsage["toggle"] = "Toggle debug mode"
        return nil
    end)

    -- AoE command args
    AceTab:RegisterTabCompletion("NAG AoE Args", "/nag aoe ", function(completions)
        tinsert(completions, "toggle")
        tinsert(completions, "on")
        tinsert(completions, "off")
    end, function(candUsage)
        candUsage["toggle"] = "Toggle single target mode"
        candUsage["on"] = "Enable AoE mode"
        candUsage["off"] = "Disable AoE mode (single target)"
        return nil
    end)

    -- /nagaoe root alias - same args as /nag aoe
    AceTab:RegisterTabCompletion("NAG AoE Args (nagaoe)", "/nagaoe ", function(completions)
        tinsert(completions, "toggle")
        tinsert(completions, "on")
        tinsert(completions, "off")
        tinsert(completions, "status")
        tinsert(completions, "reset")
    end, function(candUsage)
        candUsage["toggle"] = "Toggle single target mode"
        candUsage["on"] = "Enable AoE mode"
        candUsage["off"] = "Disable AoE mode (single target)"
        candUsage["status"] = "Show current override status"
        candUsage["reset"] = "Reset all overrides including saved"
        return nil
    end)

    -- Search command - no args needed, but register for completion
    AceTab:RegisterTabCompletion("NAG Search", "/nag search ", function(completions)
        -- Could add common search terms here
    end, function(candUsage)
        return nil
    end)

    -- Debug search command
    AceTab:RegisterTabCompletion("NAG Debug Search", "/nagdebug search ", function(completions)
        -- Could add common search terms here
    end, function(candUsage)
        return nil
    end)
end

-- ============================ UNIFIED COMMAND HANDLER ============================

--- Root-specific behaviors configuration
local rootBehaviors = {
    nag = {
        title = "NAG Slash Commands",
        categoryOrder = {"Core", "Rotation", "Combat", "System", "Data", "Debug", "Module Debug", "Other"},
        searchDescription = "commands",
        emptyInput = function(self)
            -- Check if options are already open, close them; otherwise open options
            if AceConfigDialog and AceConfigDialog.OpenFrames and AceConfigDialog.OpenFrames["NAG"] then
                AceConfigDialog:Close("NAG")
            else
                if AceConfigDialog then
                    AceConfigDialog:Open("NAG")
                end
            end
        end,
        specialCommands = {
            rotation = function(self, args) self:HandleRotationCommand(args) end,
            rot = function(self, args) self:HandleRotationCommand(args) end
        },
        checkOptionsTabs = true,
        helpCommand = "help",
        helpSections = {
            {
                title = "Options Access",
                items = {
                    {command = "/nag", description = "Open options UI"},
                    {command = "/nag <tabname>", description = "Open options to specific tab (e.g., splash, ui, class, debug)"}
                }
            }
        }
    },
    nagdebug = {
        title = "NAG Debug Commands",
        categoryOrder = {"Debug", "Data", "System", "Rotation", "Combat", "Core", "Module Debug", "Other"},
        searchDescription = "debug commands",
        emptyInput = function(self)
            self:ShowDebugHelp()
        end,
        specialCommands = {},
        checkOptionsTabs = false,
        helpCommand = "help",
        helpSections = {}
    }
}

--- Unified command handler for both /nag and /nagdebug
--- @param root string The root command (nag or nagdebug)
--- @param input string The command input
function SlashCommandHandler:HandleCommand(root, input)
    local behavior = rootBehaviors[root]
    if not behavior then
        self:Error("Unknown root command: " .. tostring(root))
        return
    end

    -- Handle empty input
    if not input or input == "" then
        behavior.emptyInput(self)
        return
    end

    -- Use unified lookup
    local cmdInfo, remainingArgs, cmdType, categoryTree = self:FindCommand(root, input)

    if cmdInfo then
        if cmdType == "hierarchical" then
            self:ExecuteCommand(cmdInfo, remainingArgs)
            return
        elseif cmdType == "flat" then
            -- Check for special commands first (root-specific)
            local command = strlower(input:match("^(%S+)"))
            if behavior.specialCommands[command] then
                behavior.specialCommands[command](self, remainingArgs)
                return
            end

            -- Execute flat command
            if cmdInfo.handler then
                cmdInfo.handler(remainingArgs)
                return
            end
        end
    elseif cmdType == "category" and categoryTree then
        -- User pressed Enter on a category (branch node) - show same help as Tab would show
        -- This provides consistent UX: Tab shows completions, Enter shows help
        self:ShowCategoryHelp(root, input, categoryTree)
        return
    end

    -- If not found via unified lookup, try root-specific fallbacks
    local command, args = input:match("^(%S+)%s*(.*)$")
    command = command and strlower(command) or ""
    args = args and strtrim(args) or ""

    -- Check for special commands (root-specific)
    if behavior.specialCommands[command] then
        behavior.specialCommands[command](self, args)
        return
    end

    -- Check options tabs (nag only)
    if behavior.checkOptionsTabs and OptionsManager then
        local options = OptionsManager:GetOptions()
        if options and options.args then
            for tabName in pairs(options.args) do
                if strlower(tabName) == command then
                    if AceConfigDialog then
                        AceConfigDialog:SelectGroup("NAG", tabName)
                        AceConfigDialog:Open("NAG")
                    end
                    return
                end
            end
        end
    end

    -- Dynamic discovery fallback (for commands registered after initialization)
    if ns.SlashCommands then
        local slashInfo = ns.SlashCommands[command]
        if not slashInfo then
            -- Try with "nag" prefix
            slashInfo = ns.SlashCommands["nag" .. command]
        end

        if slashInfo then
            -- Check if this command belongs to this root
            local cmdRoot = slashInfo.root
            if not cmdRoot then
                self:Warn("HandleCommand: Command '%s' from ns.SlashCommands missing root field - defaulting to nagdebug", command)
                cmdRoot = "nagdebug"
            end
            if cmdRoot == root then
                local moduleName = slashInfo.module or "Unknown"
                local module = NAG:GetModule(moduleName, true)

                if module then
                    local handlerName = slashInfo.handler

                    if type(handlerName) == "function" then
                        handlerName(args)
                        return
                    elseif type(handlerName) == "string" and handlerName ~= "inline_function" and module[handlerName] then
                        module[handlerName](module, args)
                        return
                    elseif type(module[command]) == "function" then
                        module[command](module, args)
                        return
                    elseif type(module["nag" .. command]) == "function" then
                        module["nag" .. command](module, args)
                        return
                    end
                end
            end
        end
    end

    -- Unknown command
    local rootDisplay = "/" .. root
    NAG:Print(format("|cffff0000Unknown %s command:|r %s", root, command))
    NAG:Print(format("Type |cff00ff00%s %s|r for a list of available commands", rootDisplay, behavior.helpCommand))
    if root == "nag" then
        NAG:Print(format("Or use |cff00ff00%s <tabname>|r to open options (e.g., /nag splash, /nag ui, /nag class)", rootDisplay))
    end
end

-- ============================ MAIN COMMAND HANDLER ============================

--- Handle the main /nag command
--- @param input string The command input
function SlashCommandHandler:HandleMainCommand(input)
    return self:HandleCommand("nag", input)
end

-- ============================ UNIFIED HELP SYSTEM ============================

--- Group commands by category for help display
--- @param commands table Table of commands (flat or hierarchical)
--- @return table Categories table with commands grouped by category
local function GroupCommandsByCategory(commands)
    local categories = {}
    for cmd, info in pairs(commands) do
        local cat = info.category or "Other"
        if not categories[cat] then
            categories[cat] = {}
        end
        tinsert(categories[cat], {cmd = cmd, help = info.help, module = info.module})
    end
    return categories
end

--- Unified help display for both /nag and /nagdebug
--- @param root string The root command (nag or nagdebug)
function SlashCommandHandler:ShowHelp(root)
    local rootDisplay = "/" .. root
    local behavior = rootBehaviors[root]

    -- Dynamic title based on root
    local title = behavior and behavior.title or (root == "nag" and "NAG Slash Commands" or "NAG Debug Commands")

    NAG:Print(format("|cff00ff00%s|r", title))
    NAG:Print(" ")

    -- Show hierarchical commands first (if any)
    local hierarchicalTree = self.commands[root] and self.commands[root].hierarchical
    local hierarchicalCommands = {}  -- Track commands shown in hierarchical section
    if hierarchicalTree and next(hierarchicalTree) then
        NAG:Print("|cff00bfffOrganized Commands:|r")
        -- Collect all commands from hierarchical tree to filter from flat section
        -- Commands stored hierarchically are flattened to flat["commandName"], so we need to track
        -- the last segment of each hierarchical command to filter them from the flat section
        local function collectHierarchicalCommands(tree)
            for key, value in pairs(tree) do
                if value.handler then
                    -- Track by last segment (this is how it appears in flat commands after flattening)
                    if value.fullPath and type(value.fullPath) == "table" then
                        local lastSegment = value.fullPath[#value.fullPath]
                        hierarchicalCommands[lastSegment] = true
                    else
                        -- Fallback: use key directly (shouldn't happen after BuildFlatCommandList)
                        hierarchicalCommands[key] = true
                    end
                else
                    collectHierarchicalCommands(value)
                end
            end
        end
        collectHierarchicalCommands(hierarchicalTree)
        self:PrintCommandTree(hierarchicalTree, rootDisplay, {}, 0)
        NAG:Print(" ")
    end

    -- Group flat commands by category, excluding those already shown in hierarchical section
    local flatCommands = self.commands[root] and self.commands[root].flat or {}
    local filteredFlatCommands = {}
    for cmd, info in pairs(flatCommands) do
        -- Only include if not already shown in hierarchical section
        if not hierarchicalCommands[cmd] then
            filteredFlatCommands[cmd] = info
        end
    end
    local categories = GroupCommandsByCategory(filteredFlatCommands)

    -- Dynamic category order - use behavior config or default
    local categoryOrder = behavior and behavior.categoryOrder or {"Core", "Rotation", "Combat", "System", "Data", "Debug", "Module Debug", "Other"}

    -- Display by category with consistent ordering
    for _, catName in ipairs(categoryOrder) do
        local commands = categories[catName]
        if commands then
            NAG:Print(format("|cff00bfff%s Commands:|r", catName))
            for _, cmdInfo in ipairs(commands) do
                local cmdDisplay = format("%s %s", rootDisplay, cmdInfo.cmd)
                NAG:Print(format("  |cffffaa00%s|r - %s", cmdDisplay, cmdInfo.help or "No description"))
            end
            NAG:Print(" ")
        end
    end

    -- Root-specific sections - use behavior config
    if behavior and behavior.helpSections then
        for _, section in ipairs(behavior.helpSections) do
            NAG:Print(format("|cff00bfff%s:|r", section.title))
            for _, item in ipairs(section.items) do
                NAG:Print(format("  |cffffaa00%s|r - %s", item.command, item.description))
            end
            NAG:Print(" ")
        end
    end

    -- Search command info - dynamic based on root
    local searchDescription = behavior and behavior.searchDescription or (root == "nag" and "commands" or "debug commands")
    NAG:Print("|cff00bfffSearch Commands:|r")
    NAG:Print(format("  |cffffaa00%s search <keyword>|r - Search for %s by keyword", rootDisplay, searchDescription))
    NAG:Print(" ")

    NAG:Print(format("|cff888888Type %s <command> for more information|r", rootDisplay))
end

--- Show main command help
function SlashCommandHandler:ShowMainHelp()
    return self:ShowHelp("nag")
end

-- ============================ DEBUG COMMAND HANDLER ============================

--- Handle the /nagdebug command
--- @param input string The command input
function SlashCommandHandler:HandleDebugCommand(input)
    return self:HandleCommand("nagdebug", input)
end

--- Show debug command help
function SlashCommandHandler:ShowDebugHelp()
    return self:ShowHelp("nagdebug")
end

-- ============================ COMMAND IMPLEMENTATIONS ============================

-- Core commands

function SlashCommandHandler:EnableAddon(input)
    NAG:Enable()
end

function SlashCommandHandler:DisableAddon(input)
    NAG:Disable()
end

function SlashCommandHandler:LockFrames(input)
    local didLock = false
    if DisplayManager:IsGroupDisplayMode() then
        DisplayManager:DisableEditMode()
        NAG:Print("Group frames locked")
        didLock = true
    end
    if DisplayManager:IsLegacyFrameEnabled() then
        DisplayManager:ToggleFrameEditMode(false)
        NAG:Print("Frame locked")
        didLock = true
    end
    if DisplayManager.classHelperEditMode then
        DisplayManager.classHelperEditMode = false
        NAG:SendMessage("NAG_FRAME_UPDATED")
        didLock = true
    end
    local pvpMod = NAG:GetModule("PvPTracker", true)
    if pvpMod and pvpMod.UpdatePvPFrameEditState then
        pvpMod:UpdatePvPFrameEditState()
    end
    if not didLock then
        NAG:Print("No frames to lock")
    end
end

function SlashCommandHandler:UnlockFrames(input)
    local didUnlock = false
    if DisplayManager:IsGroupDisplayMode() then
        DisplayManager:EnableEditMode()
        NAG:Print("Group frames unlocked - Drag to move, wheel to scale")
        didUnlock = true
    end
    if DisplayManager:IsLegacyFrameEnabled() then
        DisplayManager:ToggleFrameEditMode(true)
        NAG:Print("Frame unlocked - Left click to drag, mousewheel to scale")
        didUnlock = true
    end
    if not didUnlock then
        DisplayManager.classHelperEditMode = true
        NAG:SendMessage("NAG_FRAME_UPDATED")
        NAG:Print("Frames unlocked - Drag to move (includes PvP Tracker if enabled)")
        didUnlock = true
    end
    -- Ensure PvP Tracker frame is included when any edit mode is active
    local pvpMod = NAG:GetModule("PvPTracker", true)
    if pvpMod and pvpMod.UpdatePvPFrameEditState then
        pvpMod:UpdatePvPFrameEditState()
    end
end

function SlashCommandHandler:ReloadUI(input)
    if ResetManager and ResetManager.ShowReloadDialog then
        ResetManager:ShowReloadDialog()
    else
        ReloadUI()
    end
end

--- Toggle LEFT-frame visibility via /nagburst
--- @param input string
function SlashCommandHandler:HandleBurstCommand(input)
    self:HandleCooldownsCommand(input)
end

--- Parse shared on/off/toggle/status toggles from slash input.
--- @param input string|nil
--- @return string normalizedAction One of: status, on, off, toggle
local function ParseToggleAction(input)
    local normalized = input and strlower(strtrim(input)) or ""
    if normalized == "status" then
        return "status"
    end
    if normalized == "on" or normalized == "enable" then
        return "on"
    end
    if normalized == "off" or normalized == "disable" then
        return "off"
    end
    if normalized == "" or normalized == "toggle" then
        return "toggle"
    end
    return "toggle"
end

--- Toggle cooldown/left-frame visibility via /nag cooldowns
--- @param input string|nil
function SlashCommandHandler:HandleCooldownsCommand(input)
    if not DisplayManager or not DisplayManager.IsLeftFramesEnabled then
        NAG:Print("|cffff0000[NAG] Display system unavailable|r")
        return
    end

    local action = ParseToggleAction(input)
    if action == "status" then
        local current = DisplayManager:IsLeftFramesEnabled()
        NAG:Print(format("|cff00ff00[NAG]|r Cooldowns frames are %s", current and "shown" or "hidden"))
        return
    end

    local newState = (action == "on") and true or (action == "off" and false or not DisplayManager:IsLeftFramesEnabled())
    DisplayManager:SetLeftFramesEnabled(newState)
    NAG:Print(format("|cff00ff00[NAG]|r Cooldowns frames %s", newState and "shown" or "hidden"))
end

--- Toggle AoE-frame visibility via /nag aoeframe
--- @param input string|nil
function SlashCommandHandler:HandleAoeFrameCommand(input)
    if not DisplayManager or not DisplayManager.IsAoeFrameEnabled or not DisplayManager.SetAoeFrameEnabled then
        NAG:Print("|cffff0000[NAG] Display system unavailable|r")
        return
    end

    local action = ParseToggleAction(input)
    if action == "status" then
        local current = DisplayManager:IsAoeFrameEnabled()
        NAG:Print(format("|cff00ff00[NAG]|r AoE frame is %s", current and "shown" or "hidden"))
        return
    end

    local newState = (action == "on") and true or (action == "off" and false or not DisplayManager:IsAoeFrameEnabled())
    DisplayManager:SetAoeFrameEnabled(newState)
    NAG:Print(format("|cff00ff00[NAG]|r AoE frame %s", newState and "shown" or "hidden"))
end

--- Macro hook for /startattack spam detection and weapon-sync SIT.
--- Intended usage: add `/nagattack` to your macro.
--- When MH is not ahead: fires DoEmote("SIT") immediately for fast stagger (one press = one swing).
--- @param input string
function SlashCommandHandler:HandleAttackCommand(input)
    local normalized = input and strlower(strtrim(input)) or ""

    if NAG and NAG.AttackPressed then
        NAG:AttackPressed()
    end

    -- Press-triggered SIT: fire immediately when MH not ahead (no 100ms OnUpdate wait)
    local wsMod = NAG and NAG.GetModule and NAG:GetModule("TBCEnhancementShamanWeaponSync", true)
    if wsMod and wsMod.TryFireSitOnPress and NAG.IsTBCEnhancementWeaponSyncEnabled and NAG:IsTBCEnhancementWeaponSyncEnabled() then
        wsMod:TryFireSitOnPress()
    end

    local attackSpamState = NAG and NAG.state and NAG.state.attackSpam or nil

    if normalized == "status" then
        if attackSpamState then
            attackSpamState.debugPrint = not attackSpamState.debugPrint
            NAG:Print(format("|cff00ff00[NAG]|r /nagattack debug prints: %s", attackSpamState.debugPrint and "on" or "off"))
        else
            NAG:Print("|cff00ff00[NAG]|r /nagattack debug prints: unavailable (no state)")
        end
        return
    end

    if attackSpamState and attackSpamState.debugPrint and NAG and NAG.GetAttackSpamStats then
        local s = NAG:GetAttackSpamStats()
        if s then
            NAG:Print(format(
                "|cff00ff00[NAG]|r attack spam: pressesLast1s=%d lastPressAgo=%.3f avgInterval=%.3f spamming=%s",
                s.pressesLast1s or 0,
                s.lastPressAgo or -1,
                s.avgInterval or -1,
                tostring((NAG.IsSpammingAttack and NAG:IsSpammingAttack()) and true or false)
            ))
        end
    end
end

-- Rotation commands

function SlashCommandHandler:NextRotation(input)
    local classModule = NAG:GetClassModule()
    if classModule then
        classModule:CycleRotation("next")
    end
end

function SlashCommandHandler:PrevRotation(input)
    local classModule = NAG:GetClassModule()
    if classModule then
        classModule:CycleRotation("prev")
    end
end

function SlashCommandHandler:HandleRotationCommand(input)
    local classModule = NAG:GetClassModule()
    if not classModule then return end

    if input == "next" then
        classModule:CycleRotation("next")
    elseif input == "prev" or input == "previous" then
        classModule:CycleRotation("prev")
    elseif input ~= "" then
        -- Try to switch to named rotation
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if not specIndex then return end

        local rotations = select(1, classModule:GetAvailableRotations(specIndex))
        for name in pairs(rotations) do
            if strlower(name) == strlower(input) then
                classModule:SelectRotation(specIndex, name)
                return
            end
        end
        NAG:Print("Rotation not found: " .. input)
    else
        -- Toggle the Rotation Manager
        if RotationManager then
            RotationManager:Toggle()
        end
    end
end

-- System commands

function SlashCommandHandler:HandleReset(input)
    if input and input ~= "" then
        local resetType = strlower(input)
        if resetType == "all" then
            ResetManager:ShowResetConfirmDialog(L["resetAllConfirm"],
                function() ResetManager:PerformSmartReset("all") end)
        elseif resetType == "global" then
            ResetManager:ShowResetConfirmDialog(L["resetGlobalConfirm"],
                function() ResetManager:PerformSmartReset("global") end)
        elseif resetType == "char" or resetType == "character" then
            ResetManager:ShowResetConfirmDialog(L["resetCharacterConfirm"],
                function() ResetManager:PerformSmartReset("char") end)
        elseif resetType == "class" then
            ResetManager:ShowResetConfirmDialog(L["resetClassConfirm"],
                function() ResetManager:PerformSmartReset("class") end)
        elseif resetType == "position" or resetType == "pos" then
            ResetManager:ShowResetConfirmDialog(L["resetPositionConfirm"],
                function() ResetManager:ResetPosition() end)
        elseif resetType == "keys" then
            ResetManager:ShowResetConfirmDialog(L["resetKeysConfirm"],
                function() ResetManager:ResetKeys() end)
        else
            ResetManager:ShowResetTypeDialog()
        end
    else
        ResetManager:ShowResetTypeDialog()
    end
end


-- Data commands

function SlashCommandHandler:HandleCache(input)
    local command = input and strlower(input) or "help"

    if command == "help" then
        NAG:Print("Rotation Cache Commands:")
        NAG:Print("  /nag cache stats                    -- Show cache statistics")
        NAG:Print("  /nag cache clear                    -- Clear entire rotation cache")
        NAG:Print("  /nag cache list                     -- List all cached rotations")
    elseif command == "stats" then
        if RotationManager then
            local stats = RotationManager:GetRotationCacheStats()
            NAG:Print("Rotation Cache Statistics:")
            NAG:Print("  Total cached rotations: " .. stats.totalCached)
            NAG:Print("  Oldest cache: " ..
                (stats.oldestCache > 0 and format("%.2f seconds ago", GetTime() - stats.oldestCache) or "N/A"))
            NAG:Print("  Newest cache: " ..
                (stats.newestCache > 0 and format("%.2f seconds ago", GetTime() - stats.newestCache) or "N/A"))
        else
            self:Error("RotationManager not available")
        end
    elseif command == "clear" then
        if RotationManager then
            RotationManager:ClearRotationCache()
            NAG:Print("Rotation cache cleared")
        else
            self:Error("RotationManager not available")
        end
    elseif command == "list" then
        if RotationManager then
            local cached = RotationManager:GetCachedRotationsList()
            if #cached > 0 then
                NAG:Print("Cached Rotations:")
                for _, info in ipairs(cached) do
                    local currentTime = GetTime()
                    local compileAge = format("%.2fs", currentTime - info.compileTime)
                    local lastUsedStr = info.lastUsed and format("%.2fs ago", currentTime - info.lastUsed) or "Never"
                    local statusStr = info.isValid and "|cff00ff00Valid|r" or "|cffff0000Invalid|r"
                    NAG:Print(format("  %s [Spec:%d] - Cached: %s | Last Used: %s | %s",
                        info.name, info.specIndex or 0, compileAge, lastUsedStr, statusStr))
                end
            else
                NAG:Print("No rotations currently cached")
            end
        else
            self:Error("RotationManager not available")
        end
    else
        NAG:Print("Unknown command. Use '/nag cache help' for usage.")
    end
end

function SlashCommandHandler:HandleLeaderboard(input)
    local command = input and strlower(strtrim(input)) or "help"
    if command == "help" or command == "" then
        NAG:Print("Leaderboard Commands:")
        NAG:Print("  /nag leaderboard reset              -- Reset leaderboard data only")
        return
    end

    if command == "reset" then
        local function doReset()
            local service = LeaderboardService or NAG:GetModule("LeaderboardService", true)
            if not service or not service.ResetLeaderboardData then
                NAG:Print("|cffff0000[NAG] Leaderboard reset unavailable|r")
                return
            end
            local ok, err = service:ResetLeaderboardData()
            if not ok then
                NAG:Print("|cffff0000[NAG] Leaderboard reset failed: " .. tostring(err) .. "|r")
                return
            end
            NAG:Print("|cff00ff00[NAG] Leaderboard data reset complete|r")
        end

        if ResetManager and ResetManager.ShowResetConfirmDialog then
            ResetManager:ShowResetConfirmDialog(
                "Reset leaderboard data only? This clears local + peer leaderboard records.",
                doReset
            )
        else
            doReset()
        end
        return
    end

    NAG:Print("Unknown leaderboard command. Use '/nag leaderboard help'.")
end

function SlashCommandHandler:HandleSpellDump(input)
    if not DevTools_Dump then
        NAG:Print(L["devToolsNotAvailable"])
        return
    end
    if input and input ~= "" then
        local id = tonumber(input)
        if id then
            local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
                DataManager:Get(id, DataManager.EntityTypes.ITEM)
            if entity then
                DevTools_Dump(entity)
            else
                NAG:Print("No spell or item found with ID: " .. id)
            end
        end
    else
        NAG:Print("Usage: /nag sd <spellID>")
    end
end

-- Configuration commands

function SlashCommandHandler:HandleBlacklist(input)
    local args = {}
    if input and input ~= "" then
        for word in input:gmatch("%S+") do
            tinsert(args, word)
        end
    end

    local subcommand = args[1] and strlower(args[1])

    if subcommand == "add" then
        local spellId = tonumber(args[2])
        if spellId then
            NAG:BlacklistSpell(spellId)
        else
            NAG:Print("Usage: /nag blacklist add <spellID>")
        end
    elseif subcommand == "remove" then
        local spellId = tonumber(args[2])
        if spellId then
            NAG:UnblacklistSpell(spellId)
        else
            NAG:Print("Usage: /nag blacklist remove <spellID>")
        end
    elseif subcommand == "list" then
        local classModule = NAG:GetClassModule()
        if classModule and classModule.db.char.blacklistedSpells then
            local count = 0
            NAG:Print("Blacklisted Spells:")
            for spellId in pairs(classModule.db.char.blacklistedSpells) do
                local spellInfo = WoWAPI.GetSpellInfo(spellId)
                local spellName = spellInfo and spellInfo.name or "Unknown"
                NAG:Print(format("  %s (%d)", spellName, spellId))
                count = count + 1
            end
            if count == 0 then
                NAG:Print("  No spells blacklisted")
            end
        end
    elseif subcommand == "clear" then
        local classModule = NAG:GetClassModule()
        if classModule and classModule.db.char.blacklistedSpells then
            wipe(classModule.db.char.blacklistedSpells)
            NAG:Print("Cleared all blacklisted spells")
        end
    else
        NAG:Print("Spell Blacklist Commands:")
        NAG:Print("  /nag blacklist add <spellID> - Blacklist a spell")
        NAG:Print("  /nag blacklist remove <spellID> - Remove from blacklist")
        NAG:Print("  /nag blacklist list - Show all blacklisted spells")
        NAG:Print("  /nag blacklist clear - Clear all blacklisted spells")
    end
end

-- Debug commands (simple version for /nag debug)

function SlashCommandHandler:HandleDebugMode(input)
    local arg = input and strlower(input) or ""

    if arg == "on" or arg == "enable" then
        NAG:SetSetting("global", "enableDevMode", true)
        NAG:Print("|cff00ff00[NAG] Debug mode ENABLED|r")
        NAG:Print("|cff00ff00[NAG] Enhanced error reporting and debug features are now active|r")
    elseif arg == "off" or arg == "disable" then
        NAG:SetSetting("global", "enableDevMode", false)
        NAG:Print("|cffff0000[NAG] Debug mode DISABLED|r")
        NAG:Print("|cffff0000[NAG] Enhanced error reporting and debug features are now inactive|r")
    elseif arg == "toggle" or arg == "" then
        local currentState = NAG:IsDevModeEnabled()
        NAG:SetSetting("global", "enableDevMode", not currentState)
        local newState = NAG:IsDevModeEnabled()
        if newState then
            NAG:Print("|cff00ff00[NAG] Debug mode ENABLED|r")
            NAG:Print("|cff00ff00[NAG] Enhanced error reporting and debug features are now active|r")
        else
            NAG:Print("|cffff0000[NAG] Debug mode DISABLED|r")
            NAG:Print("|cffff0000[NAG] Enhanced error reporting and debug features are now inactive|r")
        end
    else
        NAG:Print("|cff00bfff[NAG] Debug mode commands:|r")
        NAG:Print("  /nag debug on     - Enable debug mode")
        NAG:Print("  /nag debug off    - Disable debug mode")
        NAG:Print("  /nag debug toggle - Toggle debug mode")
        NAG:Print("  /nag debug        - Show this help")
        NAG:Print("|cff00bfff[NAG] Current debug mode: " ..
            (NAG:IsDevModeEnabled() and "ENABLED" or "DISABLED") .. "|r")
    end
end

function SlashCommandHandler:HandleStressTest(input)
    if not RotationManager or not RotationManager.RunStressTest then
        NAG:Print("|cffff0000[NAG] Stress test is unavailable (RotationManager not ready)|r")
        return
    end
    RotationManager:RunStressTest(input)
end

--- Print TBC feral diagnostics for powershift, rip, and bite gates.
--- @param input string|nil Optional flags (currently unused)
function SlashCommandHandler:HandleFeralDebug(input)
    if NAG.CLASS_FILENAME ~= "DRUID" then
        NAG:Print("|cffff0000[NAG] /nag feraldebug is only available on Druids.|r")
        return
    end

    if not NAG.GetFeralDebugSnapshot then
        NAG:Print("|cffff0000[NAG] Feral debug snapshot helper is unavailable in this class file.|r")
        return
    end

    local ok, snapshot = pcall(function()
        return NAG:GetFeralDebugSnapshot()
    end)
    if not ok or type(snapshot) ~= "table" then
        NAG:Print("|cffff0000[NAG] Failed to build feral debug snapshot: " .. tostring(snapshot) .. "|r")
        return
    end

    local p = snapshot.powershift or {}
    local r = snapshot.rip or {}
    local bMain = snapshot.biteMain or {}
    local bExec = snapshot.biteEmergency or {}

    NAG:Print("|cff00bfff[NAG] Feral Debug Snapshot|r")
    NAG:Print(format("  Powershift: pass=%s fail=%s", tostring(p.passes), tostring(p.firstFailure)))
    NAG:Print(format("    cat=%s manaBase=%.3f manaGate(>0.35)=%s energyAtGCD=%.1f tickWithGCD=%.3f energyGate=%s",
        tostring(p.inCatForm),
        tonumber(p.manaPercentBase) or 0,
        tostring(p.manaGate),
        tonumber(p.energyAtGCD) or 0,
        tonumber(p.timeToTickWithGCD) or 0,
        tostring(p.energyGate)))

    NAG:Print(format("  Rip(1079): pass=%s fail=%s", tostring(r.passes), tostring(r.firstFailure)))
    NAG:Print(format("    cp=%s cp>=5=%s ripActive=%s remaining=%.2f rem>=10=%s rem>=0.8*base(%.2f)=%s",
        tostring(r.comboPoints),
        tostring(r.comboGate),
        tostring(r.ripActive),
        tonumber(r.remainingTime) or 0,
        tostring(r.remainingAtLeast10Gate),
        tonumber(r.ripPctThreshold) or 0,
        tostring(r.remainingAtLeast80PctRipGate)))

    NAG:Print(format("  Bite(main 22568): pass=%s fail=%s cp>=5=%s ripActive=%s",
        tostring(bMain.passes),
        tostring(bMain.firstFailure),
        tostring(bMain.comboGate),
        tostring(bMain.ripActiveGate)))

    NAG:Print(format("  Bite(emergency 22568): pass=%s fail=%s cp>=1=%s rem<=3=%s (not HasEnergy(5221) or UnitIsPrimaryTarget)=%s",
        tostring(bExec.passes),
        tostring(bExec.firstFailure),
        tostring(bExec.comboGate),
        tostring(bExec.executeWindowGate),
        tostring(bExec.energyOrTankGate)))

    NAG:Print(format("  Finisher preempt check: likelyBlockedByEarlierRule=%s reason=%s",
        tostring(snapshot.likelyPreemptedByEarlierRule),
        tostring(snapshot.preemptReason)))
end

-- Note: AoE command is handled by TTDManager module directly
-- Removed HandleAoE wrapper - TTDManager registers /nag aoe directly

-- ============================ DEBUG COMMAND IMPLEMENTATIONS ============================

function SlashCommandHandler:HandleDebugLevel(input)
    if not input or input == "" then
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug level <number>|r")
        return
    end
    SetGlobalDebugLevel(input)
end

function SlashCommandHandler:HandleDebugModule(input)
    if not input or input == "" then
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug module <moduleName>|r")
        return
    end
    ToggleModuleDebug(input)
end

function SlashCommandHandler:HandleDevMode(input)
    local argLower = input and strlower(input) or ""
    if argLower == "on" then
        SetDevMode(true)
    elseif argLower == "off" then
        SetDevMode(false)
    elseif argLower == "toggle" then
        local currentState = GetDevMode()
        SetDevMode(not currentState)
    else
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug devmode <on|off|toggle>|r")
    end
end

function SlashCommandHandler:HandleDebugThrottle(input)
    if not input or input == "" then
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug throttle <clear|info|bypass|stats|reset> [moduleName|all|on|off|toggle]|r")
        return
    end
    local throttleCmd, throttleArg = input:match("^(%S+)%s*(.*)$")
    if throttleCmd then
        ManageThrottledLogging(throttleCmd, throttleArg)
    else
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug throttle <clear|info|bypass|stats|reset> [moduleName|all|on|off|toggle]|r")
    end
end

function SlashCommandHandler:HandleDebugCategory(input)
    if not input or input == "" then
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug category <list|listmodules|enableall|disableall|toggleall> [categoryName]|r")
        return
    end
    local categoryCmd, categoryArg = input:match("^(%S+)%s*(.*)$")
    if categoryCmd then
        categoryCmd = strlower(categoryCmd)
        if categoryCmd == "list" then
            ListDebugCategories()
        elseif categoryCmd == "listmodules" then
            if categoryArg ~= "" then
                ListModulesInCategory(categoryArg)
            else
                NAG:Print("|cffff0000[NAG] Usage: /nagdebug category listmodules <categoryName>|r")
            end
        elseif categoryCmd == "enableall" then
            ManageAllCategories("on")
        elseif categoryCmd == "disableall" then
            ManageAllCategories("off")
        elseif categoryCmd == "toggleall" then
            ManageAllCategories("toggle")
        else
            NAG:Print("|cffff0000[NAG] Usage: /nagdebug category <list|listmodules|enableall|disableall|toggleall> [categoryName]|r")
        end
    else
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug category <list|listmodules|enableall|disableall|toggleall> [categoryName]|r")
    end
end

function SlashCommandHandler:HandleDebugGroup(input)
    if not input or input == "" then
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug group <category> <on|off|toggle>|r")
        return
    end
    local groupCmd, groupArg = input:match("^(%S+)%s*(.*)$")
    if groupCmd and groupArg ~= "" then
        local action = groupArg:match("^(%S+)")
        if action then
            ManageCategoryDebug(groupCmd, action)
        else
            NAG:Print("|cffff0000[NAG] Usage: /nagdebug group <category> <on|off|toggle>|r")
        end
    else
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug group <category> <on|off|toggle>|r")
    end
end

function SlashCommandHandler:HandleDebugSystem(input)
    local systemCmd = input and strlower(input) or ""
    if systemCmd == "" or systemCmd == "system" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("system")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "modules" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("modules")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "lifecycle" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("lifecycle")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "database" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("database")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "spellcache" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("spellcache")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "rotations" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("rotations")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "config" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("config")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "init" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("init")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "initverbose" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("initverbose")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "zero" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("zero")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "zeroverbose" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("zeroverbose")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "health" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("health")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "healthverbose" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("healthverbose")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "patterns" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("patterns")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "patternsverbose" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("patternsverbose")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "issues" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("issues")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "issuesverbose" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("issuesverbose")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "fix" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("fix")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "fixverbose" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("fixverbose")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "full" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("full")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    elseif systemCmd == "fullverbose" then
        if ns.handleSystemDiagnostics then
            ns.handleSystemDiagnostics("fullverbose")
        else
            NAG:Print("|cffff0000[NAG] System diagnostics not available|r")
        end
    else
        NAG:Print("|cffff0000[NAG] Usage: /nagdebug system <system|modules|lifecycle|database|spellcache|rotations|config|init|initverbose|zero|zeroverbose|health|healthverbose|patterns|patternsverbose|issues|issuesverbose|fix|fixverbose|full|fullverbose>|r")
    end
end




-- ============================ SEARCH FUNCTIONALITY ============================

--- Search for commands by keyword
--- @param query string The search query
--- @param debugOnly boolean If true, search only debug commands
function SlashCommandHandler:SearchCommands(query, debugOnly)
    if not query or query == "" then
        NAG:Print("|cffff0000Please provide a search term|r")
        NAG:Print(format("Usage: /%s search <keyword>", debugOnly and "nagdebug" or "nag"))
        return
    end

    local queryLower = strlower(query)
    local results = {}

    -- Search function
    local function matchesQuery(text)
        return text and strfind(strlower(text), queryLower, 1, true)
    end

    -- Search commands from unified structure
    local rootsToSearch = debugOnly and {"nagdebug"} or {"nag", "nagdebug"}

    for _, root in ipairs(rootsToSearch) do
        local rootCommands = self.commands[root]
        if rootCommands then
            -- Search flat commands
            if rootCommands.flat then
                for cmd, info in pairs(rootCommands.flat) do
                    if matchesQuery(cmd) or matchesQuery(info.help) or matchesQuery(info.category) or matchesQuery(info.module) then
                        tinsert(results, {
                            command = format("/%s %s", root, cmd),
                            help = info.help or "No description",
                            category = info.category or info.module or (root == "nagdebug" and "Debug" or "Other"),
                            isDebug = (root == "nagdebug")
                        })
                    end
                end
            end

            -- Search hierarchical commands (flatten for search)
            if rootCommands.hierarchical then
                local function searchHierarchicalTree(tree, prefix)
                    for key, value in pairs(tree) do
                        local fullPath = prefix and (prefix .. " " .. key) or key
                        if value.handler then
                            -- Leaf node: actual command
                            if matchesQuery(key) or matchesQuery(value.help) or matchesQuery(value.category) or matchesQuery(value.module) then
                                tinsert(results, {
                                    command = format("/%s %s", root, fullPath),
                                    help = value.help or "No description",
                                    category = value.category or value.module or (root == "nagdebug" and "Debug" or "Other"),
                                    isDebug = (root == "nagdebug")
                                })
                            end
                        else
                            -- Branch node: recurse
                            searchHierarchicalTree(value, fullPath)
                        end
                    end
                end
                searchHierarchicalTree(rootCommands.hierarchical, "")
            end
        end
    end

    -- Search module aliases
    for alias, mapping in pairs(self.aliases) do
        if matchesQuery(alias) then
            local targetCmd = mapping.isDebugCommand and format("/nagdebug %s", mapping.command) or format("/nag %s", mapping.command)
            tinsert(results, {
                command = format("/%s (alias → %s)", alias, targetCmd),
                help = format("Alias for %s", mapping.command),
                category = "Alias",
                isDebug = mapping.isDebugCommand
            })
        end
    end

    -- Display results
    if #results == 0 then
        NAG:Print(format("|cffff0000No commands found matching:|r %s", query))
        return
    end

    NAG:Print(format("|cff00ff00Found %d command(s) matching:|r %s", #results, query))
    NAG:Print(" ")

    -- Sort by category, then by command
    table.sort(results, function(a, b)
        if a.category == b.category then
            return a.command < b.command
        end
        return a.category < b.category
    end)

    local lastCategory = nil
    for _, result in ipairs(results) do
        if result.category ~= lastCategory then
            if lastCategory then NAG:Print(" ") end
            NAG:Print(format("|cff00bfff%s:|r", result.category))
            lastCategory = result.category
        end
        NAG:Print(format("  |cffffaa00%s|r - %s", result.command, result.help))
    end
end

-- ============================ EXPORTS ============================

return SlashCommandHandler



