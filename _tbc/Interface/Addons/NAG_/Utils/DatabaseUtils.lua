--- @module "DatabaseUtils"
--- Shared database utility functions for NAG addon
---
--- Provides centralized database access patterns and utilities used across
--- multiple modules to ensure consistency and eliminate code duplication.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

--- ============================ LOCALIZE ============================
local _, ns = ...

local strsplit = strsplit

-- Standard Lua functions
local type = type
local tostring = tostring

-- Enhanced error handling
local pcall = ns.pcall

--- ============================ CONTENT ============================

-- Debug flag to control logging (set to false to disable debug output)
local DEBUG_DATABASE_UTILS = false

-- Debug: Track loading order
if DEBUG_DATABASE_UTILS then
    print("|cff00ff00[NAG DatabaseUtils] DatabaseUtils module loading...|r")
    print("|cff00ff00[NAG DatabaseUtils] Current stack:|r")
    print(debugstack(1, 3, 0))
end

--- Simple table dump utility for debug output
--- @param t table|any The table or value to dump
--- @param maxDepth number|nil Maximum depth for nested tables (default: 2)
--- @param currentDepth number|nil Current depth (internal use)
--- @param visited table|nil Table to track visited references (internal use)
--- @return string The formatted string representation
local function tDump(t, maxDepth, currentDepth, visited)
    -- Prevent infinite recursion with circular references
    visited = visited or {}
    if type(t) == "table" then
        if visited[t] then
            return "... (circular reference)"
        end
        visited[t] = true
    end

    maxDepth = maxDepth or 2  -- Reduced default depth
    currentDepth = currentDepth or 0

    -- Safety check for excessive depth
    if currentDepth > maxDepth then
        return "... (max depth reached)"
    end

    -- Safety check for excessive recursion
    if currentDepth > 10 then
        return "... (excessive recursion)"
    end

    local indent = string.rep("  ", currentDepth)

    if type(t) == "table" then
        local result = "{\n"
        local count = 0
        local maxKeys = 20  -- Limit number of keys to prevent huge output

        for k, v in pairs(t) do
            count = count + 1
            if count > maxKeys then
                result = result .. indent .. "  ... (" .. (count - maxKeys) .. " more keys)\n"
                break
            end

            local keyStr = type(k) == "string" and k or "[" .. tostring(k) .. "]"
            local valueStr = tDump(v, maxDepth, currentDepth + 1, visited)
            result = result .. indent .. "  " .. keyStr .. " = " .. valueStr .. ",\n"
        end
        result = result .. indent .. "}"
        return result
    elseif type(t) == "string" then
        -- Limit string length to prevent huge output
        if #t > 100 then
            return '"' .. t:sub(1, 100) .. '..." (truncated)'
        end
        return '"' .. t .. '"'
    else
        return tostring(t)
    end
end

--- Parses GetSetting/SetSetting arguments to determine the key and default value
--- @param ... string|any Variable arguments from GetSetting/SetSetting call
--- @return string key The constructed key string
--- @return any defaultValue The default value (may be nil)
local function ParseGetSettingArgs(...)
    local args = {...}
    local key, defaultValue

    -- Debug: Log the arguments being parsed
    if DEBUG_DATABASE_UTILS then
        print("|cffffff00[NAG DatabaseUtils] ParseGetSettingArgs called with:|r")
        print("  |cff00ff00Args count:|r " .. #args)
        for i, arg in ipairs(args) do
            print("  |cff00ff00Arg " .. i .. ":|r " .. tostring(arg) .. " (type: " .. type(arg) .. ")")
        end
    end

    -- Simplified argument parsing - just use the first argument as key, last as default
    local rawArgCount = select("#", ...)
    if rawArgCount == 0 then
        -- ALWAYS show debug info for this error, regardless of DEBUG_DATABASE_UTILS setting
        print("|cffff0000[NAG DatabaseUtils] CRITICAL ERROR: GetSetting called with no arguments!|r")
        print("|cffff0000[NAG DatabaseUtils] This should never happen - check the call site below:|r")
        print("|cffff0000[NAG DatabaseUtils] Stack trace:|r")
        print(debugstack(2, 10, 0))
        error("DatabaseUtils:ParseGetSettingArgs - No arguments provided", 2)
    elseif rawArgCount == 1 then
        -- Single argument: key only
        local firstArg = select(1, ...)
        if type(firstArg) ~= "string" then
            error("DatabaseUtils:ParseGetSettingArgs - Key must be string, got " .. type(firstArg), 2)
        end
        key = firstArg
        defaultValue = nil
    else
        -- Multiple arguments: first is key, last is default value
        local firstArg = select(1, ...)
        local lastArg = select(rawArgCount, ...)
        if type(firstArg) ~= "string" then
            error("DatabaseUtils:ParseGetSettingArgs - Key must be string, got " .. type(firstArg), 2)
        end
        key = firstArg
        defaultValue = lastArg
    end

    -- Clean up trailing dots (common mistake)
    if key and type(key) == "string" and key:sub(-1) == "." then
        key = key:sub(1, -2) -- Remove trailing dot
    end

    -- Debug: Check for problematic key patterns
    if DEBUG_DATABASE_UTILS and key and key:find("%.%.") then
        print("NAG DatabaseUtils:ParseGetSettingArgs - Warning: Double dots detected in key:", key)
    end

    return key, defaultValue
end

--- Parses SetSetting arguments to determine the key and value
--- @param ... string|any Variable arguments from SetSetting call
--- @return string key The constructed key string
--- @return any value The value to set
local function ParseSetSettingArgs(...)
    local args = {...}
    local key, value

    -- Debug: Log the arguments being parsed
    if DEBUG_DATABASE_UTILS then
        print("|cffffff00[NAG DatabaseUtils] ParseSetSettingArgs called with:|r")
        print("  |cff00ff00Args count:|r " .. #args)
        print("  |cff00ff00Raw args count:|r " .. select("#", ...))
        for i, arg in ipairs(args) do
            print("  |cff00ff00Arg " .. i .. ":|r " .. tostring(arg) .. " (type: " .. type(arg) .. ")")
        end
        -- Also check raw args
        for i = 1, select("#", ...) do
            local arg = select(i, ...)
            print("  |cff00ff00Raw Arg " .. i .. ":|r " .. tostring(arg) .. " (type: " .. type(arg) .. ")")
        end
    end

    -- Simplified argument parsing - just use the first argument as key, last as value
    local rawArgCount = select("#", ...)
    if rawArgCount < 2 then
        if DEBUG_DATABASE_UTILS then
            print("  |cffff0000[NAG DatabaseUtils] ERROR: Insufficient arguments!|r")
            print("  |cffff0000[NAG DatabaseUtils] Args table count: " .. #args .. "|r")
            print("  |cffff0000[NAG DatabaseUtils] Raw args count: " .. rawArgCount .. "|r")
            print("  |cffff0000[NAG DatabaseUtils] Stack trace:|r")
            print(debugstack(2, 10, 0))
        end
        error("DatabaseUtils:ParseSetSettingArgs - At least 2 arguments required (key and value), got " .. rawArgCount, 2)
    end

    -- First argument is key, last argument is value
    local firstArg = select(1, ...)
    local lastArg = select(rawArgCount, ...)

    if type(firstArg) ~= "string" then
        error("DatabaseUtils:ParseSetSettingArgs - Key must be string, got " .. type(firstArg), 2)
    end
    key = firstArg
    value = lastArg

    -- Clean up trailing dots (common mistake)
    if key and type(key) == "string" and key:sub(-1) == "." then
        key = key:sub(1, -2) -- Remove trailing dot
    end

    -- Debug: Check for problematic key patterns
    if DEBUG_DATABASE_UTILS and key and key:find("%.%.") then
        print("NAG DatabaseUtils:ParseSetSettingArgs - Warning: Double dots detected in key:", key)
    end

    return key, value
end

--- Navigates through a nested database structure using dot notation
--- @param dbNamespace table The database namespace to navigate
--- @param key string The dot-notation key to navigate
--- @param defaultValue any The default value to return if key not found
--- @return any The value at the specified key, or defaultValue if not found
local function NavigateDatabase(dbNamespace, key, defaultValue)
    -- Validate inputs
    if not dbNamespace then
        return defaultValue
    end

    if type(key) ~= "string" then
        error("DatabaseUtils:NavigateDatabase - Key must be string, got " .. type(key), 2)
    end

    if key == "" then
        return defaultValue
    end

    -- Split the key by dots and navigate through the nested structure
    local keys = {strsplit(".", key)}
    local current = dbNamespace

    -- Navigate through all but the last key
    for i = 1, #keys - 1 do
        local k = keys[i]
        if k ~= "" then -- Skip empty keys (handles double dots gracefully)
            -- Convert numeric strings to numbers for proper key access
            local numericKey = tonumber(k)
            local actualKey = numericKey or k

            if type(current) == "table" and current[actualKey] ~= nil then
                current = current[actualKey]
            else
                return defaultValue
            end
        end
    end

    -- Get the final value
    local finalKey = keys[#keys]
    if finalKey == "" then
        return defaultValue
    end

    -- Convert numeric strings to numbers for the final key too
    local numericFinalKey = tonumber(finalKey)
    local actualFinalKey = numericFinalKey or finalKey

    if type(current) == "table" and current[actualFinalKey] ~= nil then
        return current[actualFinalKey]
    else
        return defaultValue
    end
end

--- Sets a value in a nested database structure using dot notation
--- @param dbNamespace table The database namespace to modify
--- @param key string The dot-notation key to set
--- @param value any The value to set
--- @return boolean True if the value was set successfully, false otherwise
local function SetDatabaseValue(dbNamespace, key, value)
    -- Validate inputs
    if not dbNamespace then
        error("DatabaseUtils:SetDatabaseValue - Database namespace is nil", 2)
    end

    if type(key) ~= "string" then
        error("DatabaseUtils:SetDatabaseValue - Key must be string, got " .. type(key), 2)
    end

    if key == "" then
        error("DatabaseUtils:SetDatabaseValue - Key cannot be empty string", 2)
    end

    -- Split the key by dots and navigate to the parent
    local keys = {strsplit(".", key)}
    local current = dbNamespace

    -- Navigate through all but the last key, creating tables as needed
    for i = 1, #keys - 1 do
        local k = keys[i]
        if k ~= "" then -- Skip empty keys (handles double dots gracefully)
            -- Convert numeric strings to numbers for proper key access
            local numericKey = tonumber(k)
            local actualKey = numericKey or k

            if type(current) ~= "table" then
                current[actualKey] = {}
            elseif current[actualKey] == nil then
                current[actualKey] = {}
            end
            current = current[actualKey]
        end
    end

    -- Set the final value
    local finalKey = keys[#keys]
    if finalKey == "" then
        error("DatabaseUtils:SetDatabaseValue - Final key cannot be empty string", 2)
    end

    -- Convert numeric strings to numbers for the final key too
    local numericFinalKey = tonumber(finalKey)
    local actualFinalKey = numericFinalKey or finalKey

    current[actualFinalKey] = value
    return true
end
--- Triggers OnSettingChanged callbacks for all modules when a setting changes
--- @param key string The setting key that changed
--- @param value any The new value
--- @param namespace string The namespace where the setting was changed
local function TriggerOnSettingChangedCallbacks(key, value, namespace)
    -- Safety check - ensure NAG and modules exist
    if not NAG or not NAG.modules then
        return
    end

    -- Trigger OnSettingChanged for all modules that have the method
    for moduleName, module in pairs(NAG.modules) do
        if module.OnSettingChanged and type(module.OnSettingChanged) == "function" then
            -- Use pcall to prevent one module's error from breaking others
            local success, err = pcall(function()
                module:OnSettingChanged(key, value, namespace)
            end)

            if not success and DEBUG_DATABASE_UTILS then
                print("|cffff0000[NAG DatabaseUtils] Error in " .. moduleName .. ":OnSettingChanged: " .. tostring(err) .. "|r")
            end
        end
    end
end

--- ============================ SETTING UTILITIES ============================

--- Gets a setting value using dot notation (e.g., "char.appearance.iconSize")
--- @param db table|nil The database object to use (AceDB namespace)
--- @param namespace string The database namespace ("global", "char", "class", "profile")
--- @param ... string|any Variable arguments: either (key, defaultValue) for old pattern or (key1, key2, ..., defaultValue) for new pattern
--- @return any The setting value
local function GetSetting(db, namespace, ...)
    -- Check if database is available
    if not db then
        -- Return the last argument as default without printing (reduces spam)
        return select(-1, ...)
    end

    -- Use shared utility function for pattern detection
    local key, defaultValue = ParseGetSettingArgs(...)

    if not key then
        return defaultValue
    end

    -- Get the appropriate database namespace
    local dbNamespace = db[namespace]
    if not dbNamespace then
        return defaultValue
    end

    -- Use shared utility function for database navigation
    -- Ace3 handles defaults automatically when database was created with defaults
    local result = NavigateDatabase(dbNamespace, key, defaultValue)

    return result
end

--- Sets a setting value using dot notation (e.g., "char.appearance.iconSize")
--- @param db table|nil The database object to use (AceDB namespace)
--- @param namespace string The database namespace ("global", "char", "class", "profile")
--- @param ... string|any Variable arguments: either (key, value) for old pattern or (key1, key2, ..., value) for new pattern
--- @return boolean success Whether the setting was successfully set
local function SetSetting(db, namespace, ...)
    -- Check if database is available
    if not db then
        -- Return false without printing (reduces spam)
        return false
    end

    -- Use shared utility function for pattern detection
    local key, value = ParseSetSettingArgs(...)

    if not key then
        return false
    end

    -- Get the appropriate database namespace
    local dbNamespace = db[namespace]
    if not dbNamespace then
        return false
    end

    -- Use shared utility function for database value setting
    local success = SetDatabaseValue(dbNamespace, key, value)

    -- If setting was successful, trigger OnSettingChanged callbacks for all modules
    if success and NAG and NAG.modules then
        TriggerOnSettingChangedCallbacks(key, value, namespace)
    end

    return success
end

--- Gets all settings for a namespace (for iteration/bulk operations)
--- @param db table|nil The database object to use (AceDB namespace)
--- @param namespace string The database namespace ("global", "char", "class", "profile")
--- @return table All settings in the namespace, or empty table if db is nil
local function GetAllSettings(db, namespace)
    if not db then
        return {}
    end
    return db[namespace] or {}
end

--- Gets the raw namespace table (for debugging/inspection)
--- @param db table|nil The database object to use (AceDB namespace)
--- @param namespace string The database namespace ("global", "char", "class", "profile")
--- @return table The raw namespace table, or empty table if db is nil
local function GetNamespace(db, namespace)
    if not db then
        return {}
    end
    return db[namespace] or {}
end

--- Gets a setting value with fallback through multiple namespaces
--- @param db table|nil The database object to use (AceDB namespace)
--- @param key string The setting key to get
--- @param defaultValue any The default value if not found in any namespace
--- @param namespaces? table Array of namespaces to check in order (default: {"char", "profile", "class", "global"})
--- @return any The setting value from the first namespace that has it, or defaultValue
local function GetSettingWithFallback(db, key, defaultValue, namespaces)
    -- Check if database is initialized
    if not db then
        return defaultValue
    end

    -- Default namespace order: char -> class -> global -> profile (most specific to least specific)
    namespaces = namespaces or {"char", "class", "global", "profile"}

    -- Check each namespace in order
    for _, namespace in ipairs(namespaces) do
        local value = GetSetting(db, namespace, key, nil)
        if value ~= nil then
            return value
        end
    end

    -- Return default if not found in any namespace
    return defaultValue
end

--- ============================ EXPORTS ============================

-- Export the utility functions
ns.DatabaseUtils = {
    -- Core database utilities
    ParseGetSettingArgs = ParseGetSettingArgs,
    ParseSetSettingArgs = ParseSetSettingArgs,
    NavigateDatabase = NavigateDatabase,
    SetDatabaseValue = SetDatabaseValue,
    tDump = tDump,

    GetSetting = GetSetting,
    SetSetting = SetSetting,
    GetAllSettings = GetAllSettings,
    GetNamespace = GetNamespace,
    GetSettingWithFallback = GetSettingWithFallback,

    -- Callback utilities
    TriggerOnSettingChangedCallbacks = TriggerOnSettingChangedCallbacks,
}

