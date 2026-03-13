--- @module 'NAG.OptionsFactory'
--- Factory for creating Ace3 options with automatic namespace indicators
---
--- This module provides a comprehensive factory for creating all types of Ace3 options
--- with automatic namespace detection and indicator addition. It follows the NewModule
--- pattern for early loading and service module functionality.
---
--- Features:
--- - Automatic namespace detection from getter/setter functions
--- - Namespace indicators: (g) for global, (c) for char, (l) for class
--- - Full Ace3 API coverage: toggle, range, input, select, multiselect, color, keybinding
--- - Consistent API pattern for all option types
--- - All methods are Smart by default with automatic namespace detection
--- - Automatic reload requirement handling with description indicators
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local L = ns.AceLocale:GetLocale("NAG")
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs (using WoW's optimized versions where available)
local strfind = strfind
local tostring = tostring
local type = type
local pairs = pairs
local pcall = ns.pcall

-- WoW API
local ReloadUI = _G.ReloadUI
-- ============================ MODULE CREATION ============================

-- Create as a plain Ace3 module (not CoreModule) for early loading
--- @class OptionsFactory
local OptionsFactory = NAG:NewModule("OptionsFactory", {})
local module = OptionsFactory
ns.OptionsFactory = OptionsFactory


-- ============================ PRIVATE HELPER FUNCTIONS ============================

--- Adds namespace indicators to option names
--- @param originalName string|function The original name (string or function)
--- @param namespace string The namespace this option belongs to
--- @return string|function The modified name with namespace indicator
local function AddNamespaceIndicator(originalName, namespace)
    if not originalName then
        return originalName
    end

    -- Determine the indicator based on namespace
    local indicator = ""
    -- Disabled namespace indicators per user request
    -- if namespace == "global" then
    --     indicator = " (g)"
    -- elseif namespace == "char" then
    --     indicator = " (c)"
    -- elseif namespace == "class" then
    --     indicator = " (l)"
    -- end

    -- If no indicator needed, return original
    if indicator == "" then
        return originalName
    end

    -- If it's already a function, wrap it
    if type(originalName) == "function" then
        return function(info)
            local baseName = originalName(info)
            if type(baseName) == "string" then
                return baseName .. indicator
            end
            return baseName
        end
    end

    -- If it's a string, append the indicator
    if type(originalName) == "string" then
        return originalName .. indicator
    end

    -- Fallback for other types
    return originalName
end

--- Detects the namespace from a getter function by analyzing its content
--- @param getter function The getter function to analyze
--- @return string The detected namespace or "global" as default
local function DetectNamespaceFromFunction(getter)
    if not getter or type(getter) ~= "function" then
        return "global"
    end

    -- Convert function to string for analysis
    local funcStr = tostring(getter)

    -- Look for namespace patterns in the function string
    if strfind(funcStr, "GetSetting%(.*[\"']global[\"']") then
        return "global"
    elseif strfind(funcStr, "GetSetting%(.*[\"']char[\"']") then
        return "char"
    elseif strfind(funcStr, "GetSetting%(.*[\"']class[\"']") then
        return "class"
    elseif strfind(funcStr, "GetSetting%(.*[\"']profile[\"']") then
        return "profile"
    end

    -- Default to global if no pattern found
    return "global"
end

--- Creates a base option table with common properties
--- @param optionType string The type of option (toggle, range, input, etc.)
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param namespace string The namespace this option belongs to
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete option table
---
--- @usage
--- -- Basic usage:
--- local option = OptionsFactory:CreateToggle(L["option"] or "My Option", L["optionDesc"] or "Description", getter, setter, { order = 1 })
---
--- -- With reload requirement:
--- local option = OptionsFactory:CreateToggle(L["option"] or "My Option", L["optionDesc"] or "Description", getter, setter, {
---     order = 1,
---     requiresReload = true
--- })
--- -- This automatically adds "(Requires reload)" to the description and shows reload dialog
local function CreateBaseOption(optionType, optionName, optionDesc, namespace, getter, setter, additionalProps)
    local option = {
        type = optionType,
        name = AddNamespaceIndicator(optionName, namespace),
        desc = optionDesc,
        get = getter,
        set = setter,
    }

    -- Handle reload requirements automatically
    if additionalProps and additionalProps.requiresReload then
        -- Add reload indicator to description
        local reloadText = " (Requires reload)"
        if option.desc then
            if type(option.desc) == "function" then
                local originalDesc = option.desc
                option.desc = function(info)
                    local baseDesc = originalDesc(info)
                    if type(baseDesc) == "string" then
                        return baseDesc .. reloadText
                    end
                    return baseDesc
                end
            else
                option.desc = option.desc .. reloadText
            end
        else
            option.desc = reloadText
        end

        -- Wrap the setter to automatically show reload dialog
        if option.set then
            local originalSetter = option.set
            option.set = function(info, value, ...)
                -- Call the original setter first
                local result = originalSetter(info, value, ...)

                -- Show reload dialog after the setting is changed
                local ResetManager = NAG:GetModule("ResetManager", true)
                if ResetManager and ResetManager.ShowReloadDialog then
                    ResetManager:ShowReloadDialog("This option requires a UI reload to take effect. Reload now?")
                else
                    ReloadUI()
                end

                return result
            end
        end

        -- Remove the custom property so it doesn't interfere with Ace3
        additionalProps.requiresReload = nil
    end

    -- Merge additional properties
    if additionalProps then
        for key, value in pairs(additionalProps) do
            option[key] = value
        end
    end

    return option
end

-- ============================ CORE FACTORY METHODS ============================

--- Creates an option with explicit configuration
--- @param optionType string The type of option
--- @param config table Configuration table with name, desc, namespace, get, set, additional
--- @return table The complete option table
function OptionsFactory:CreateOption(optionType, config)
    return CreateBaseOption(
        optionType,
        config.name,
        config.desc,
        config.namespace,
        config.get,
        config.set,
        config.additional
    )
end

--- Creates an option with explicit namespace specification
--- @param optionType string The type of option
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param namespace string The namespace this option belongs to
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete option table
function OptionsFactory:CreateNamespaceOption(optionType, optionName, optionDesc, namespace, getter, setter,
                                              additionalProps)
    return CreateBaseOption(optionType, optionName, optionDesc, namespace, getter, setter, additionalProps)
end

--- Creates a smart option with automatic namespace detection
--- @param optionType string The type of option
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete option table
function OptionsFactory:CreateSmartOption(optionType, optionName, optionDesc, getter, setter, additionalProps)
    local namespace = DetectNamespaceFromFunction(getter)
    return CreateBaseOption(optionType, optionName, optionDesc, namespace, getter, setter, additionalProps)
end

-- ============================ SPECIALIZED FACTORY METHODS ============================

--- Creates a toggle option with automatic namespace detection
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete toggle option table
function OptionsFactory:CreateToggle(optionName, optionDesc, getter, setter, additionalProps)
    return self:CreateSmartOption("toggle", optionName, optionDesc, getter, setter, additionalProps)
end

--- Creates a range option with automatic namespace detection
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete range option table
function OptionsFactory:CreateRange(optionName, optionDesc, getter, setter, additionalProps)
    return self:CreateSmartOption("range", optionName, optionDesc, getter, setter, additionalProps)
end

--- Creates an input option with automatic namespace detection
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete input option table
function OptionsFactory:CreateInput(optionName, optionDesc, getter, setter, additionalProps)
    return self:CreateSmartOption("input", optionName, optionDesc, getter, setter, additionalProps)
end

--- Creates a select option with automatic namespace detection
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete select option table
function OptionsFactory:CreateSelect(optionName, optionDesc, getter, setter, additionalProps)
    return self:CreateSmartOption("select", optionName, optionDesc, getter, setter, additionalProps)
end

--- Creates a multiselect option with automatic namespace detection
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete multiselect option table
function OptionsFactory:CreateMultiSelect(optionName, optionDesc, getter, setter, additionalProps)
    return self:CreateSmartOption("multiselect", optionName, optionDesc, getter, setter, additionalProps)
end

--- Creates a color option with automatic namespace detection
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete color option table
function OptionsFactory:CreateColor(optionName, optionDesc, getter, setter, additionalProps)
    return self:CreateSmartOption("color", optionName, optionDesc, getter, setter, additionalProps)
end

--- Creates a keybinding option with automatic namespace detection
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param getter function The getter function
--- @param setter function The setter function
--- @param additionalProps table Additional properties for the option
--- @return table The complete keybinding option table
function OptionsFactory:CreateKeybinding(optionName, optionDesc, getter, setter, additionalProps)
    return self:CreateSmartOption("keybinding", optionName, optionDesc, getter, setter, additionalProps)
end

--- Creates an execute option (no namespace detection needed)
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param func function The execute function
--- @param additionalProps table Additional properties for the option
--- @return table The complete execute option table
function OptionsFactory:CreateExecute(optionName, optionDesc, func, additionalProps)
    -- Execute options don't have getters/setters, so we create them directly
    local option = {
        type = "execute",
        name = optionName,
        desc = optionDesc,
        func = func,
    }
    if additionalProps then
        for key, value in pairs(additionalProps) do
            option[key] = value
        end
    end
    return option
end

--- Creates a description option (read-only text)
--- @param optionName string|function The option name
--- @param optionDesc string|function The option description
--- @param additionalProps table Additional properties for the option
--- @return table The complete description option table
function OptionsFactory:CreateDescription(optionName, optionDesc, additionalProps)
    local option = {
        type = "description",
        name = optionName,
        desc = optionDesc,
    }

    -- Merge additional properties
    if additionalProps then
        for key, value in pairs(additionalProps) do
            option[key] = value
        end
    end

    return option
end

--- Creates a header option (section header)
--- @param optionName string|function The option name
--- @param additionalProps table Additional properties for the option
--- @return table The complete header option table
function OptionsFactory:CreateHeader(optionName, additionalProps)
    local option = {
        type = "header",
        name = optionName,
    }

    -- Merge additional properties
    if additionalProps then
        for key, value in pairs(additionalProps) do
            option[key] = value
        end
    end

    return option
end

--- Creates a spacer option (empty space)
--- @param additionalProps table Additional properties for the option
--- @return table The complete spacer option table
function OptionsFactory:CreateSpacer(additionalProps)
    local option = {
        type = "description",
        name = "",
        desc = "",
    }

    -- Merge additional properties
    if additionalProps then
        for key, value in pairs(additionalProps) do
            option[key] = value
        end
    end

    return option
end

-- ============================ UTILITY METHODS ============================



--- Gets the namespace indicator for a given namespace
--- @param namespace string The namespace ("global", "char", "class")
--- @return string The namespace indicator (disabled per user request)
function OptionsFactory:GetNamespaceIndicator(namespace)
    -- Namespace indicators disabled per user request
    -- if namespace == "global" then
    --     return " (g)"
    -- elseif namespace == "char" then
    --     return " (c)"
    -- elseif namespace == "class" then
    --     return " (l)"
    -- end
    return ""
end

--- Checks if an option requires a reload
--- @param option table The option table to check
--- @return boolean True if the option requires a reload
function OptionsFactory:RequiresReload(option)
    return option and option.requiresReload == true
end

--- Adds reload requirement to an existing option
--- @param option table The option table to modify
--- @return table The modified option table
function OptionsFactory:AddReloadRequirement(option)
    if option then
        option.requiresReload = true
        -- Update description to include reload indicator
        if option.desc then
            if type(option.desc) == "function" then
                local originalDesc = option.desc
                option.desc = function(info)
                    local baseDesc = originalDesc(info)
                    if type(baseDesc) == "string" then
                        return baseDesc .. " (Requires reload)"
                    end
                    return baseDesc
                end
            else
                option.desc = option.desc .. " (Requires reload)"
            end
        else
            option.desc = "(Requires reload)"
        end
    end
    return option
end

-- ============================ BACKWARDS COMPATIBILITY ALIASES ============================

-- Aliases for old CreateSmart* method names (all methods are now Smart by default)
OptionsFactory.CreateSmartToggle = OptionsFactory.CreateToggle
OptionsFactory.CreateSmartRange = OptionsFactory.CreateRange
OptionsFactory.CreateSmartInput = OptionsFactory.CreateInput
OptionsFactory.CreateSmartSelect = OptionsFactory.CreateSelect
OptionsFactory.CreateSmartMultiSelect = OptionsFactory.CreateMultiSelect
OptionsFactory.CreateSmartColor = OptionsFactory.CreateColor
OptionsFactory.CreateSmartKeybinding = OptionsFactory.CreateKeybinding
OptionsFactory.CreateSmartExecute = OptionsFactory.CreateExecute
