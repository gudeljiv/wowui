--- @module "ChatCommandUtils"
--- Shared utility for consistent chat command registration across all modules and services
---
--- Provides unified RegisterCommand functionality that can be used by:
--- - CoreModule (regular modules) - automatically available via self:RegisterCommand()
--- - NAG (main addon) - via ns.ChatCommandUtils.RegisterCommand()
--- - Service modules (non-CoreModule) - via ns.ChatCommandUtils.RegisterCommand()
--- - Any other module or service
---
--- All modules use the underlying Ace3 RegisterChatCommand method directly,
--- ensuring consistent behavior and avoiding circular dependencies.
---
--- Output channels:
--- - ns.UnifiedPrint (and DEFAULT_CHAT_FRAME) always target the default chat tab.
--- - Debug log output is routed by DebugManager to the channel set in options
---   (Interface -> Addons -> NAG -> Debug -> "Debug Output Channel").
---   To send debug-related text to that same channel, use
---   ns.DebugManager:GetDebugOutputFrame() and frame:AddMessage(text).
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

-- ============================ CONTENT ============================

--- ChatCommandUtils: Provides unified chat command registration
local ChatCommandUtils = {}

-- Unified Print function with module detection and aliases
function ns.UnifiedPrint(self, ...)
    local moduleName = self.GetName and self:GetName() or tostring(self)
    local alias = ns.MODULE_ALIASES[moduleName] or moduleName

    -- Get module type color using the centralized helper function
    local color = ns.GetModuleTypeColor and ns.GetModuleTypeColor(self) or "|cff33ff99"

    -- Format the message
    local prefix = color .. alias .. "|r: "
    local message = table.concat({...}, " ")

    -- Use Ace3's Print function for consistency
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. message)
end

-- Add Print function for unified logging
function ChatCommandUtils:Print(...)
    ns.UnifiedPrint(self, ...)
end

-- Debug flag to control logging (set to false to disable debug output)
local DEBUG_CHAT_COMMAND_UTILS = false

-- Debug: Track loading order
if DEBUG_CHAT_COMMAND_UTILS then
    print("|cff00ff00[NAG ChatCommandUtils] ChatCommandUtils module loading...|r")
    print("|cff00ff00[NAG ChatCommandUtils] Current stack:|r")
    print(debugstack(1, 3, 0))
end

--- Registers a chat command with unified interface
--- @param context table|string The context (module instance, "NAG", or command name)
--- @param command string|function The command name or handler function
--- @param handler function|string|nil The handler function, method name, or nil if command is the handler
--- @param help string|nil Optional help text for the command
function ChatCommandUtils.RegisterCommand(context, command, handler, help)
    -- Debug: Log the call
    if DEBUG_CHAT_COMMAND_UTILS then
        print("|cffffff00[NAG ChatCommandUtils] RegisterCommand called:|r")
        print("  |cff00ff00Context type:|r " .. type(context))
        print("  |cff00ff00Command:|r " .. tostring(command))
        print("  |cff00ff00Handler type:|r " .. type(handler))
        print("  |cff00ff00Help:|r " .. tostring(help))
    end

    -- Determine the registration context and method
    local registrationTarget
    local registrationMethod

    if type(context) == "table" then
        -- Context is a module instance
        if context.RegisterChatCommand then
            -- All modules (CoreModule, service modules, main addon) have RegisterChatCommand
            registrationTarget = context
            registrationMethod = "RegisterChatCommand"
        else
            error("ChatCommandUtils:RegisterCommand - Invalid context table (no RegisterChatCommand method)", 2)
        end
    elseif type(context) == "string" then
        -- Context is a string identifier (like "NAG")
        if context == "NAG" then
            registrationTarget = LibStub("AceAddon-3.0"):GetAddon("NAG")
            if not registrationTarget then
                error("ChatCommandUtils:RegisterCommand - Could not get NAG addon from AceAddon", 2)
            end
            registrationMethod = "RegisterChatCommand"
        else
            error("ChatCommandUtils:RegisterCommand - Unknown string context: " .. context, 2)
        end
    else
        error("ChatCommandUtils:RegisterCommand - Invalid context type: " .. type(context), 2)
    end

    -- Validate command parameter
    if type(command) ~= "string" then
        error("ChatCommandUtils:RegisterCommand - Command must be string, got " .. type(command), 2)
    end

    -- Handle different parameter patterns
    if type(handler) == "function" or type(handler) == "string" then
        -- Pattern: RegisterCommand(context, "command", function, "help")
        -- Or: RegisterCommand(context, "command", "methodName", "help")
        registrationTarget[registrationMethod](registrationTarget, command, handler)
    elseif handler == nil then
        -- Pattern: RegisterCommand(context, "command", nil, "help") - command is the handler
        error("ChatCommandUtils:RegisterCommand - Handler cannot be nil", 2)
    else
        error("ChatCommandUtils:RegisterCommand - Invalid handler type: " .. type(handler), 2)
    end

    -- Add to central command registry in namespace (for discovery and dynamic module additions)
    ns.SlashCommands = ns.SlashCommands or {}
    ns.SlashCommands[command] = {
        module = registrationTarget.GetName and registrationTarget:GetName() or tostring(registrationTarget),
        handler = type(handler) == "string" and handler or "inline_function",
        help = help or "No description provided",
        root = "nagdebug"  -- Default root for commands registered via old-style RegisterCommand
    }

    -- Debug: Log successful registration
    if DEBUG_CHAT_COMMAND_UTILS then
        print("|cff00ff00[NAG ChatCommandUtils] Successfully registered command:|r " .. command)
        print("  |cff00ff00Target:|r " .. tostring(registrationTarget.GetName and registrationTarget:GetName() or registrationTarget))
        print("  |cff00ff00Method:|r " .. registrationMethod)
    end
end

--- Registers multiple commands at once
--- @param context table|string The context (module instance, "NAG", or command name)
--- @param commands table Table of command definitions: {{command, handler, help}, ...}
function ChatCommandUtils.RegisterCommands(context, commands)
    if type(commands) ~= "table" then
        error("ChatCommandUtils:RegisterCommands - Commands must be table", 2)
    end

    for _, commandDef in ipairs(commands) do
        if type(commandDef) == "table" and #commandDef >= 2 then
            local command = commandDef[1]
            local handler = commandDef[2]
            local help = commandDef[3]
            ChatCommandUtils.RegisterCommand(context, command, handler, help)
        else
            error("ChatCommandUtils:RegisterCommands - Invalid command definition: " .. tostring(commandDef), 2)
        end
    end
end

--- Unregisters a chat command
--- @param context table|string The context (module instance, "NAG", or command name)
--- @param command string The command name to unregister
function ChatCommandUtils.UnregisterCommand(context, command)
    -- Determine the registration context and method
    local registrationTarget

    if type(context) == "table" then
        if context.UnregisterChatCommand then
            registrationTarget = context
        else
            error("ChatCommandUtils:UnregisterCommand - Context table has no UnregisterChatCommand method", 2)
        end
    elseif type(context) == "string" then
        if context == "NAG" then
            registrationTarget = LibStub("AceAddon-3.0"):GetAddon("NAG")
        else
            error("ChatCommandUtils:UnregisterCommand - Unknown string context: " .. context, 2)
        end
    else
        error("ChatCommandUtils:UnregisterCommand - Invalid context type: " .. type(context), 2)
    end

    if type(command) ~= "string" then
        error("ChatCommandUtils:UnregisterCommand - Command must be string, got " .. type(command), 2)
    end

    registrationTarget:UnregisterChatCommand(command)

    -- Debug: Log successful unregistration
    if DEBUG_CHAT_COMMAND_UTILS then
        print("|cff00ff00[NAG ChatCommandUtils] Successfully unregistered command:|r " .. command)
    end
end

--- Gets information about registered commands
--- @param context table|string The context (module instance, "NAG", or command name)
--- @return table Information about registered commands
function ChatCommandUtils.GetCommandInfo(context)
    -- Return the central command registry from namespace
    return ns.SlashCommands or {}
end

-- ============================ EXPORTS ============================

-- Export the utility functions
ns.ChatCommandUtils = ChatCommandUtils

-- Debug: Log that ChatCommandUtils has been loaded
if DEBUG_CHAT_COMMAND_UTILS then
    print("|cff00ff00[NAG ChatCommandUtils] ChatCommandUtils loaded successfully|r")
    print("|cff00ff00[NAG ChatCommandUtils] Available functions: RegisterCommand, RegisterCommands, UnregisterCommand, GetCommandInfo|r")
end

--[[
USAGE EXAMPLES:

1. CoreModule-inheriting module (automatic via prototype):
function MyModule:OnInitialize()
    -- Register with method name
    self:RegisterCommand("mytest", "HandleTest", "Test my module")

    -- Register with inline function
    self:RegisterCommand("mydebug", function(input)
        self:Print("Debug: " .. tostring(input))
    end, "Debug my module")
end

function MyModule:HandleTest(input)
    self:Print("Test command executed with: " .. tostring(input))
end

2. Service module (non-CoreModule):
function MyServiceModule:OnInitialize()
    -- Register with method name
    ns.ChatCommandUtils.RegisterCommand(self, "myservice", "HandleService", "Service command")

    -- Register with inline function
    ns.ChatCommandUtils.RegisterCommand(self, "myservicedebug", function(input)
        print("Service debug: " .. tostring(input))
    end, "Debug service")
end

function MyServiceModule:HandleService(input)
    print("Service command executed with: " .. tostring(input))
end

3. Main addon registration:
ns.ChatCommandUtils.RegisterCommand("NAG", "nagmain", function(input)
    print("Main addon command: " .. tostring(input))
end, "Main addon command")

4. Multiple commands at once:
ns.ChatCommandUtils.RegisterCommands(self, {
    {"command1", "HandleCommand1", "First command"},
    {"command2", "HandleCommand2", "Second command"},
    {"command3", function(input) print("Inline: " .. input) end, "Third command"}
})

]]
