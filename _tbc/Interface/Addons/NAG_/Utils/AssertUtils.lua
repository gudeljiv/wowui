--- @module "AssertUtils"
--- Shared utility for consistent assertion functionality across all modules and services
---
--- Provides unified assertion functionality that can be used by:
--- - CoreModule (regular modules) - automatically available via self:Assert()
--- - NAG (main addon) - via ns.AssertUtils functions
--- - Service modules (non-CoreModule) - via ns.AssertUtils functions
--- - Test files - via ns.AssertUtils functions
--- - Any other module or service
---
--- This ensures consistent behavior and interface across the entire codebase
--- while avoiding code duplication and implementation drift.
---
--- ALIASES: For intuitive naming, both 'isEqual' and 'areEqual' work (same for 'isNotEqual'/'areNotEqual')
---          This maintains backward compatibility while providing familiar assertion names.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

local format = string.format
local tinsert = tinsert
local concat = table.concat

-- Standard Lua functions
local type = type
local tostring = tostring
local pairs = pairs
local ipairs = ipairs
local error = error
local pcall = ns.pcall or _G.pcall

-- ============================ CONTENT ============================

-- Debug flag to control logging (set to false to disable debug output)
local DEBUG_ASSERT_UTILS = false

-- Debug: Track loading order
if DEBUG_ASSERT_UTILS then
    print("|cff00ff00[NAG AssertUtils] AssertUtils module loading...|r")
    print("|cff00ff00[NAG AssertUtils] Current stack:|r")
    print(debugstack(1, 3, 0))
end

--- AssertUtils: Provides unified assertion functionality
local AssertUtils = {}

-- Add Print function for unified logging
function AssertUtils:Print(...)
    ns.UnifiedPrint(self, ...)
end

--- Deep comparison function for complex data structures
--- @param t1 table|any First value to compare
--- @param t2 table|any Second value to compare
--- @return boolean True if values are deeply equal
local function deepCompare(t1, t2)
    if t1 == t2 then return true end
    if type(t1) ~= "table" or type(t2) ~= "table" then return false end

    for k1, v1 in pairs(t1) do
        local v2 = t2[k1]
        if type(v1) == "table" and type(v2) == "table" then
            if not deepCompare(v1, v2) then return false end
        elseif v1 ~= v2 then
            return false
        end
    end

    for k2, _ in pairs(t2) do
        if t1[k2] == nil then return false end
    end

    return true
end

--- Formats a value for error messages
--- @param v any The value to format
--- @return string The formatted string representation
local function formatValue(v)
    if v == nil then return "nil" end
    if type(v) == "table" then
        -- Simple table representation for error messages
        local parts = {}
        for k, val in pairs(v) do tinsert(parts, tostring(k)..":"..tostring(val)) end
        return "{" .. concat(parts, ", ") .. "}"
    end
    return tostring(v)
end

-- ============================ CORE ASSERTION FUNCTIONS ============================

--- Asserts that a value is of the expected type
--- @param value any The value to check
--- @param expectedType string The expected Lua type
--- @param paramName string The parameter name for error messages
--- @usage AssertUtils.assertType(myValue, "string", "myValue")
function AssertUtils.assertType(value, expectedType, paramName)
    if type(value) ~= expectedType then
        error(format("Expected %s to be of type %s, but got %s", paramName, expectedType, type(value)), 2)
    end
end

--- Checks if an API function is available
--- @param apiFunction function The API function to check
--- @param functionName string The function name for error messages
--- @usage AssertUtils.checkAPI(GetSpellInfo, "GetSpellInfo")
function AssertUtils.checkAPI(apiFunction, functionName)
    if type(apiFunction) ~= "function" then
        error(format("API function %s is not available", functionName), 2)
    end
end

--- Fails the test/assertion with an optional message
--- @param message? string The failure message
--- @usage AssertUtils.fail("This should not happen")
function AssertUtils.fail(message)
    error("Assertion failed: " .. (message or "Manual failure"), 2)
end

--- Asserts that the condition is true
--- @param condition boolean The condition to check
--- @param message? string Optional error message
--- @usage AssertUtils.isTrue(1 == 1)
function AssertUtils.isTrue(condition, message)
    if not condition then
        error("Assertion failed: Expected true, but got false. " .. (message or ""), 2)
    end
end

--- Asserts that the condition is false
--- @param condition boolean The condition to check
--- @param message? string Optional error message
--- @usage AssertUtils.isFalse(1 == 2)
function AssertUtils.isFalse(condition, message)
    if condition then
        error("Assertion failed: Expected false, but got true. " .. (message or ""), 2)
    end
end

--- Asserts that two values are equal (deep compare)
--- @param expected any The expected value
--- @param actual any The actual value
--- @param message? string Optional error message
--- @usage AssertUtils.areEqual({a=1}, {a=1})
function AssertUtils.areEqual(expected, actual, message)
    if not deepCompare(expected, actual) then
        error(format("Assertion failed: Expected <%s>, but got <%s>. %s",
            formatValue(expected), formatValue(actual), message or ""), 2)
    end
end

--- Asserts that two values are not equal (deep compare)
--- @param expected any The first value
--- @param actual any The second value
--- @param message? string Optional error message
--- @usage AssertUtils.areNotEqual(1, 2)
function AssertUtils.areNotEqual(expected, actual, message)
    if deepCompare(expected, actual) then
        error(format("Assertion failed: Expected values to differ, but both were <%s>. %s",
            formatValue(expected), message or ""), 2)
    end
end

--- Asserts that the value is nil
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage AssertUtils.isNil(nil)
function AssertUtils.isNil(value, message)
    if value ~= nil then
        error("Assertion failed: Expected nil, but got " .. formatValue(value) .. ". " .. (message or ""), 2)
    end
end

--- Asserts that the value is not nil
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage AssertUtils.isNotNil(123)
function AssertUtils.isNotNil(value, message)
    if value == nil then
        error("Assertion failed: Expected a value, but got nil. " .. (message or ""), 2)
    end
end

--- Asserts that the value is of the expected type
--- @param value any The value to check
--- @param expectedType string The expected Lua type
--- @param message? string Optional error message
--- @usage AssertUtils.isType("foo", "string")
function AssertUtils.isType(value, expectedType, message)
    if type(value) ~= expectedType then
        error(format("Assertion failed: Expected type <%s>, but got <%s>. %s",
            expectedType, type(value), message or ""), 2)
    end
end

--- Asserts that the value is a table
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage AssertUtils.isTable({})
function AssertUtils.isTable(value, message)
    if type(value) ~= "table" then
        error("Assertion failed: Expected a table, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

--- Asserts that the value is a number
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage AssertUtils.isNumber(42)
function AssertUtils.isNumber(value, message)
    if type(value) ~= "number" then
        error("Assertion failed: Expected a number, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

--- Asserts that the value is a string
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage AssertUtils.isString("hello")
function AssertUtils.isString(value, message)
    if type(value) ~= "string" then
        error("Assertion failed: Expected a string, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

--- Asserts that the value is a boolean
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage AssertUtils.isBoolean(true)
function AssertUtils.isBoolean(value, message)
    if type(value) ~= "boolean" then
        error("Assertion failed: Expected a boolean, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

--- Asserts that the value is a function
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage AssertUtils.isFunction(function() end)
function AssertUtils.isFunction(value, message)
    if type(value) ~= "function" then
        error("Assertion failed: Expected a function, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

--- Asserts that a table is empty (no keys)
--- @param value table The table to check
--- @param message? string Optional error message
--- @usage AssertUtils.isEmpty({})
function AssertUtils.isEmpty(value, message)
    if type(value) ~= "table" then
        error("Assertion failed: Expected a table for isEmpty, got " .. type(value) .. ". " .. (message or ""), 2)
    end
    for _ in pairs(value) do
        error("Assertion failed: Expected table to be empty, but found elements. " .. (message or ""), 2)
    end
end

--- Asserts that a function call throws an error
--- @param func function The function to call
--- @param message? string Optional error message
--- @usage AssertUtils.throwsError(function() error("fail") end)
function AssertUtils.throwsError(func, message)
    local ok, _ = pcall(func)
    if ok then
        error("Assertion failed: Expected function to throw an error, but it did not. " .. (message or ""), 2)
    end
end

--- Asserts that a table contains a specific value (using ==)
--- @param tbl table The table to search
--- @param val any The value to find
--- @param message? string Optional error message
--- @usage AssertUtils.contains({1,2,3}, 2)
function AssertUtils.contains(tbl, val, message)
    for _, v in pairs(tbl) do
        if v == val then return end
    end
    error("Assertion failed: Table does not contain expected value. " .. (message or ""), 2)
end

--- Asserts that a table has a specific key
--- @param tbl table The table to check
--- @param key any The key to find
--- @param message? string Optional error message
--- @usage AssertUtils.hasKey({foo=1}, "foo")
function AssertUtils.hasKey(tbl, key, message)
    if tbl[key] == nil then
        error("Assertion failed: Table missing expected key '" .. tostring(key) .. "'. " .. (message or ""), 2)
    end
end

--- Asserts that a string matches a Lua pattern
--- @param str string The string to check
--- @param pattern string The Lua pattern
--- @param message? string Optional error message
--- @usage AssertUtils.matchesPattern("hello123", "%a+%d+")
function AssertUtils.matchesPattern(str, pattern, message)
    if type(str) ~= "string" or not str:match(pattern) then
        error("Assertion failed: String does not match pattern '" .. pattern .. "'. " .. (message or ""), 2)
    end
end

-- ============================ ALIASES FOR INTUITIVE NAMING ============================

-- Add intuitive aliases for commonly expected assertion names
-- These maintain backward compatibility while providing familiar naming

-- Equality aliases (most developers expect 'isEqual' not 'areEqual')
AssertUtils.isEqual = AssertUtils.areEqual
AssertUtils.isNotEqual = AssertUtils.areNotEqual


-- Export the utility functions
ns.AssertUtils = AssertUtils

-- Debug: Log that AssertUtils has been loaded
if DEBUG_ASSERT_UTILS then
    print("|cff00ff00[NAG AssertUtils] AssertUtils loaded successfully|r")
    print("|cff00ff00[NAG AssertUtils] Available functions: assertType, checkAPI, fail, isTrue, isFalse, areEqual, areNotEqual, isNil, isNotNil, isType, isTable, isNumber, isString, isBoolean, isFunction, isEmpty, throwsError, contains, hasKey, matchesPattern|r")
    print("|cff00ff00[NAG AssertUtils] Aliases: isEqual (areEqual), isNotEqual (areNotEqual)|r")
end

--[[
USAGE EXAMPLES:

1. CoreModule-inheriting module (automatic via prototype):
function MyModule:OnInitialize()
    -- Assert methods are automatically available via CoreModule prototype
    self:Assert().isTrue(self.db ~= nil, "Database should be initialized")
    self:Assert().isTable(self.settings, "Settings should be a table")
end

2. Service module (non-CoreModule):
function MyServiceModule:OnInitialize()
    -- Use AssertUtils directly
    ns.AssertUtils.assertType(self.name, "string", "name")
    ns.AssertUtils.isNotNil(self.handler, "Handler should be initialized")
end

3. Test files:
function TestMyFunction()
    local result = MyFunction()
    -- Both naming conventions work (aliases provide backward compatibility)
    ns.AssertUtils.isEqual(expected, result, "Function should return expected value")  -- Preferred intuitive name
    ns.AssertUtils.areEqual(expected, result, "Function should return expected value") -- Original name (still works)
    ns.AssertUtils.isString(result, "Result should be a string")
end

4. Main addon usage:
ns.AssertUtils.checkAPI(GetSpellInfo, "GetSpellInfo")
ns.AssertUtils.assertType(config, "table", "config")

NOTE: All modules now use the same underlying AssertUtils implementation,
eliminating duplication and ensuring consistent behavior.
]]
