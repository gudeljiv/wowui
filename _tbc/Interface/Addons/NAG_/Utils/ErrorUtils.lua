--- @module 'ErrorUtils'
--- Enhanced error handling and pcall utilities for NAG addon
---
--- ✅ RECURSION ISSUE FIXED: Enhanced pcall system now properly caches debug mode checks
--- The infinite recursion was caused by multiple calls to ShouldShowVerboseOutput() during error reporting.
--- Fixed by caching the debug mode check result and avoiding redundant calls.
---
--- This module provides enhanced pcall functionality with better error reporting,
--- stack traces, and debugging information to help identify issues that are
--- currently being hidden by basic pcall usage.
---
--- SMART PCALL BEHAVIOR:
--- - ns.pcall automatically chooses between fast and enhanced versions
--- - Fast path: Standard Lua pcall when verbose is disabled (production)
--- - Enhanced path: Rich debugging when verbose is enabled (development)
--- - Zero configuration needed - just use ns.pcall normally
---
--- VERBOSE OUTPUT CONTROL:
--- - Automatically uses NAG:IsDevModeEnabled() when available
--- - Uses NAG:IsDevModeEnabled() as the single source of truth
--- - Use /nag debug to toggle debug mode on/off
--- - Enhanced error reporting only when debug mode is enabled
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

--- ============================ LOCALIZE ============================
local _, ns = ...
local GetTime = _G.GetTime

-- Addon reference for debug mode checking
local NAG = LibStub and LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strjoin = strjoin
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

local type = type
local tostring = tostring
local pairs = pairs
local ipairs = ipairs

local debugstack = debugstack


--- ============================ STACK TRACE HELPERS ============================

--- Prints a stack trace starting from the caller of this function
--- @param title string The title to display before the stack trace
--- @param skipLevels number How many levels to skip (default: 2 to skip this function)
--- @param maxLevels number Maximum levels to show (default: 8)
--- @param color string The color to use for the stack trace (default: "FFFF8000")
function ns.PrintStackTrace(title, skipLevels, maxLevels, color)
    title = title or "[STACK TRACE]"
    skipLevels = skipLevels or 2
    maxLevels = maxLevels or 8
    color = color or "FFFF8000"

    local stackTrace = debugstack(skipLevels, maxLevels, 1)
    NAG:Print("|cFFFF0000" .. title .. "|r")
    NAG:Print("|c" .. color .. stackTrace .. "|r")
end

--- Prints a stack trace for a specific function call
--- @param functionName string The name of the function being traced
--- @param skipLevels number How many levels to skip (default: 2 to skip this function)
--- @param maxLevels number Maximum levels to show (default: 8)
function ns.PrintFunctionStackTrace(functionName, skipLevels, maxLevels)
    local title = "[STACK TRACE] " .. (functionName or "Unknown Function") .. " called from:"
    ns.PrintStackTrace(title, skipLevels, maxLevels)
end

--- ============================ PRIVATE HELPER FUNCTIONS ============================

--- Check if verbose error output should be shown
--- @return boolean True if verbose output is enabled
local function ShouldShowVerboseOutput()
    -- Check if NAG addon is available and debug mode is enabled
    -- Avoid recursive calls by checking the database directly
    if NAG and NAG.db and NAG.db.global then
        return NAG.db.global.enableDevMode == true
    end
    -- Default to false if NAG addon not available (shouldn't happen in normal operation)
    return false
end

--- Extract function name from a function reference or string
--- @param func function|string The function to extract name from
--- @return string The function name or description
local function ExtractFunctionName(func)
    if type(func) == "string" then
        return func
    elseif type(func) == "function" then
        local funcStr = tostring(func)
        -- Try to extract function name from tostring output
        local name = strmatch(funcStr, "function: ([^%s]+)")
        if name then
            return name
        end
        -- Try to extract from debug info if available
        local info = debug.getinfo(func, "n")
        if info and info.name and info.name ~= "" then
            return info.name
        end
        return "anonymous function"
    else
        return tostring(func)
    end
end

--- Format arguments for logging
--- @param ... any The arguments to format
--- @return string Formatted arguments string
local function FormatArguments(...)
    local args = {...}
    if #args == 0 then
        return "no arguments"
    end

    local formatted = {}
    for i, arg in ipairs(args) do
        local argType = type(arg)
        if argType == "string" then
            -- Truncate long strings
            if #arg > 100 then
                tinsert(formatted, format('arg%d: "%s..." (string, %d chars)', i, strsub(arg, 1, 100), #arg))
            else
                tinsert(formatted, format('arg%d: "%s" (string)', i, arg))
            end
        elseif argType == "number" then
            tinsert(formatted, format('arg%d: %s (number)', i, tostring(arg)))
        elseif argType == "boolean" then
            tinsert(formatted, format('arg%d: %s (boolean)', i, tostring(arg)))
        elseif argType == "table" then
            -- Count table size
            local count = 0
            for _ in pairs(arg) do count = count + 1 end
            tinsert(formatted, format('arg%d: table with %d entries', i, count))
        elseif argType == "function" then
            local funcName = ExtractFunctionName(arg)
            tinsert(formatted, format('arg%d: %s (function)', i, funcName))
        else
            tinsert(formatted, format('arg%d: %s (%s)', i, tostring(arg), argType))
        end
    end

    return strjoin(", ", unpack(formatted))
end

--- Get a clean stack trace for error reporting
--- @param level number The stack level to start from (default: 3)
--- @param maxLevels number Maximum number of stack levels to include (default: 10)
--- @return string Clean stack trace
local function GetCleanStack(level, maxLevels)
    level = level or 3
    maxLevels = maxLevels or 10

    local stack = debugstack(level, maxLevels, 0)
    if not stack then
        return "No stack trace available"
    end

    -- Clean up the stack trace to remove WoW addon noise
    local lines = {}
    for line in stack:gmatch("[^\r\n]+") do
        -- Skip WoW internal frames and addon loader noise
        if not strfind(line, "%.lua:") and
           not strfind(line, "Interface\\AddOns") and
           not strfind(line, "C_Timer") and
           not strfind(line, "AceTimer") then
            tinsert(lines, line)
        end
    end

    if #lines == 0 then
        return "Stack trace filtered (WoW internal frames)"
    end

    return strjoin("\n", unpack(lines))
end

--- ============================ ENHANCED PCALL UTILITIES ============================

--- Enhanced pcall with detailed error reporting
--- @param func function The function to call
--- @param ... any Arguments to pass to the function
--- @return boolean success Whether the call succeeded
--- @return any result The result or error information
function ns.EnhancedPCall(func, ...)
    if type(func) ~= "function" then
        local errorMsg = format("EnhancedPCall: First argument must be a function, got %s", type(func))
        -- Cache debug mode check to prevent recursion
        local isVerbose = ShouldShowVerboseOutput()
        if isVerbose then
            print("|cFFFF0000[ERROR]|r " .. errorMsg)
        end
        return false, errorMsg
    end

    local args = {...}
    local funcName = ExtractFunctionName(func)
    local argString = FormatArguments(...)

    -- Execute with pcall
    local results = {pcall(func, ...)}
    local success = results[1]

    if success then
        -- Preserve ALL return values from the called function (pcall semantics)
        return unpack(results)
    else
        -- Enhanced error reporting
        local errorInfo = {
            funcName = funcName,
            arguments = argString,
            error = tostring(results[2]),
            stack = GetCleanStack(3, 8),
            timestamp = GetTime() or 0
        }

        local errorMsg = format("EnhancedPCall: %s failed - %s", funcName, tostring(results[2]))

        -- Cache debug mode check to prevent recursion - only check once
        local isVerbose = ShouldShowVerboseOutput()
        if isVerbose then
            print("|cFFFF0000[ERROR]|r " .. errorMsg)
            print("|cFFFF0000[ERROR]|r Arguments: " .. argString)
            print("|cFFFF0000[ERROR]|r Stack trace:\n" .. errorInfo.stack)
        end

        return false, errorInfo
    end
end

--- Enhanced pcall that returns detailed error information
--- @param func function The function to call
--- @param ... any Arguments to pass to the function
--- @return boolean success Whether the call succeeded
--- @return any result The result or detailed error information
function ns.SafeCall(func, ...)
    if type(func) ~= "function" then
        return false, {
            type = "INVALID_FUNCTION",
            message = format("SafeCall: First argument must be a function, got %s", type(func)),
            funcName = tostring(func),
            arguments = FormatArguments(...)
        }
    end

    local args = {...}
    local funcName = ExtractFunctionName(func)

    -- Execute with pcall
    local success, result = pcall(func, ...)

    if success then
        return true, result
    else
        -- Return detailed error information
        return false, {
            type = "EXECUTION_ERROR",
            message = tostring(result),
            funcName = funcName,
            arguments = FormatArguments(...),
            stack = GetCleanStack(3, 6),
            timestamp = GetTime() or 0
        }
    end
end

--- Enhanced pcall with custom error handler
--- @param func function The function to call
--- @param errorHandler function Custom error handler function(errorInfo)
--- @param ... any Arguments to pass to the function
--- @return boolean success Whether the call succeeded
--- @return any result The result or error handler result
function ns.PCallWithHandler(func, errorHandler, ...)
    if type(func) ~= "function" then
        local errorMsg = format("PCallWithHandler: First argument must be a function, got %s", type(func))
        -- Cache debug mode check to prevent recursion
        local isVerbose = ShouldShowVerboseOutput()
        if isVerbose then
            print("|cFFFF0000[ERROR]|r " .. errorMsg)
        end
        return false, errorMsg
    end

    if type(errorHandler) ~= "function" then
        local errorMsg = format("PCallWithHandler: Second argument must be a function, got %s", type(errorHandler))
        -- Cache debug mode check to prevent recursion
        local isVerbose = ShouldShowVerboseOutput()
        if isVerbose then
            print("|cFFFF0000[ERROR]|r " .. errorMsg)
        end
        return false, errorMsg
    end

    local args = {...}
    local funcName = ExtractFunctionName(func)

    -- Execute with pcall
    local success, result = pcall(func, ...)

    if success then
        return true, result
    else
        -- Create error info and call handler
        local errorInfo = {
            type = "EXECUTION_ERROR",
            message = tostring(result),
            funcName = funcName,
            arguments = FormatArguments(...),
            stack = GetCleanStack(3, 6),
            timestamp = GetTime() or 0
        }

        -- Call error handler
        local handlerSuccess, handlerResult = pcall(errorHandler, errorInfo)
        if not handlerSuccess then
            -- Cache debug mode check to prevent recursion
            local isVerbose = ShouldShowVerboseOutput()
            if isVerbose then
                print("|cFFFF0000[ERROR]|r " .. format("PCallWithHandler: Error handler failed - %s", tostring(handlerResult)))
            end
            return false, errorInfo
        end

        return false, handlerResult
    end
end

--- Batch pcall for multiple functions with error aggregation
--- @param functions table Table of functions to execute
--- @param stopOnFirstError boolean Whether to stop on first error (default: false)
--- @return table results Table of results {success = bool, result = any, error = string}
function ns.BatchPCall(functions, stopOnFirstError)
    if type(functions) ~= "table" then
        return {{success = false, error = "BatchPCall: functions must be a table"}}
    end

    local results = {}
    stopOnFirstError = stopOnFirstError or false

    for i, func in ipairs(functions) do
        if type(func) ~= "function" then
            tinsert(results, {
                index = i,
                success = false,
                error = format("Invalid function at index %d (got %s)", i, type(func))
            })
            if stopOnFirstError then
                break
            end
        else
            local success, result = pcall(func)
            tinsert(results, {
                index = i,
                success = success,
                result = result,
                error = not success and tostring(result) or nil
            })

            if stopOnFirstError and not success then
                break
            end
        end
    end

    return results
end

--- ============================ ERROR ANALYSIS UTILITIES ============================

--- Analyze error patterns from multiple pcall results
--- @param results table Table of pcall results from BatchPCall
--- @return table Analysis results
function ns.AnalyzeErrors(results)
    if type(results) ~= "table" then
        return {error = "AnalyzeErrors: results must be a table"}
    end

    local analysis = {
        total = #results,
        successful = 0,
        failed = 0,
        errorTypes = {},
        commonErrors = {},
        successRate = 0
    }

    for _, result in ipairs(results) do
        if result.success then
            analysis.successful = analysis.successful + 1
        else
            analysis.failed = analysis.failed + 1

            -- Categorize errors
            local errorType = "UNKNOWN"
            if result.error then
                if strfind(result.error, "attempt to call") then
                    errorType = "INVALID_FUNCTION"
                elseif strfind(result.error, "attempt to index") then
                    errorType = "NIL_INDEX"
                elseif strfind(result.error, "bad argument") then
                    errorType = "BAD_ARGUMENT"
                elseif strfind(result.error, "syntax error") then
                    errorType = "SYNTAX_ERROR"
                else
                    errorType = "RUNTIME_ERROR"
                end
            end

            analysis.errorTypes[errorType] = (analysis.errorTypes[errorType] or 0) + 1

            -- Track common error messages
            if result.error then
                analysis.commonErrors[result.error] = (analysis.commonErrors[result.error] or 0) + 1
            end
        end
    end

    analysis.successRate = analysis.total > 0 and (analysis.successful / analysis.total) * 100 or 0

    return analysis
end


-- Testing utilities removed (not needed in production)

--- ============================ ERROR TRACKING ============================

-- Error tracking for SystemDiagnostics warnings
local trackedErrors = {}
local MAX_TRACKED_ERRORS = 50 -- Maximum number of errors to track
local MAX_ERROR_MESSAGE_LENGTH = 500 -- Maximum length of error message to store

--- Track a NAG-related error for later display in diagnostics
--- @param errorType string Type of error (e.g., "LuaError", "RotationError", "InternalError")
--- @param errorMessage string Error message
--- @param context table|nil Optional context information
local function TrackError(errorType, errorMessage, context)
    if not errorType or not errorMessage then return end

    -- Truncate error message if too long
    local truncatedMessage = errorMessage
    if #truncatedMessage > MAX_ERROR_MESSAGE_LENGTH then
        truncatedMessage = strsub(truncatedMessage, 1, MAX_ERROR_MESSAGE_LENGTH) .. "... (truncated)"
    end

    local errorEntry = {
        type = errorType,
        message = truncatedMessage,
        timestamp = GetTime() or 0,
        context = context or {}
    }

    -- Add to tracked errors, removing oldest if we exceed limit
    tinsert(trackedErrors, errorEntry)
    if #trackedErrors > MAX_TRACKED_ERRORS then
        tremove(trackedErrors, 1)
    end
end

--- Get all tracked errors (for SystemDiagnostics)
--- @return table Array of tracked errors
function ns.GetTrackedErrors()
    return trackedErrors
end

--- Clear all tracked errors
function ns.ClearTrackedErrors()
    wipe(trackedErrors)
end

--- Track a rotation string parsing/validation error
--- @param rotationName string Name of the rotation
--- @param errorMessage string Error message
--- @param errorDetails table|nil Optional error details
function ns.TrackRotationError(rotationName, errorMessage, errorDetails)
    local context = {
        rotationName = rotationName,
        details = errorDetails
    }
    TrackError("RotationError", format("Rotation '%s': %s", tostring(rotationName), tostring(errorMessage)), context)
end

--- Track an internal NAG error
--- @param errorMessage string Error message
--- @param context table|nil Optional context information
function ns.TrackInternalError(errorMessage, context)
    TrackError("InternalError", tostring(errorMessage), context)
end

--- ============================ EXPORT ============================

-- Session state for one-time user guidance (not stored in DB)
local hasShownErrorGuidance = false

-- Function to show one-time user guidance for errors
local function ShowErrorGuidanceMessage()
    -- Only show guidance when debug mode is OFF
    if ShouldShowVerboseOutput() then
        return -- Debug mode is ON, no guidance needed
    end

    -- Check if we've already shown guidance
    if hasShownErrorGuidance then
        return -- Already shown guidance
    end

    -- Show bright red message to user
    local message = "|cffff0000[NAG] An error occurred!|r"
    local guidance = "|cffff9900Enable debug mode with |cffffffff/nag debug on|r |cffff9900for detailed error information.|r"

    -- Print to chat
    print(message)
    print(guidance)

    -- Mark as shown
            hasShownErrorGuidance = true

    -- Also show a UI notification if possible
    if NAG and NAG.ShowUserMessage then
        NAG:ShowUserMessage(message .. " " .. guidance, "error")
    end
end

-- Smart pcall that automatically chooses between fast and enhanced versions
-- Fast path: Uses standard Lua pcall when verbose is disabled (production)
-- Enhanced path: Rich debugging when verbose is enabled (development)
-- PERFORMANCE: Production code gets full Lua pcall speed, debug mode gets rich debugging
-- CRITICAL: This function itself is protected - helper functions use safe wrappers to prevent errors in ns.pcall from breaking execution
function ns.pcall(func, ...)
    -- Protect against errors in debug mode check - fallback to false if check fails
    local shouldShowVerbose = false
    local ok, checkResult = pcall(ShouldShowVerboseOutput)
    if ok then
        shouldShowVerbose = checkResult
    end
    -- If ShouldShowVerboseOutput errors, silently fall back to fast path

    if shouldShowVerbose then
        -- Debug mode is ON: Use enhanced pcall with rich error details
        local results = {ns.EnhancedPCall(func, ...)}
        local success = results[1]
        local result = results[2]

        -- Track errors even in verbose mode for diagnostics (protected - don't let tracking errors break execution)
        if not success then
            local okTrack, _ = pcall(function()
                local errorMsg = type(result) == "table" and (result.message or result.error or tostring(result)) or tostring(result)
                TrackError("LuaError", errorMsg, {
                    funcName = type(result) == "table" and result.funcName or nil,
                    stack = type(result) == "table" and result.stack or nil
                })
            end)
            -- Silently ignore tracking errors - don't let them break rotation execution
        end

        -- Preserve ALL return values (pcall semantics) in verbose mode
        return unpack(results)
    else
        -- Debug mode is OFF: Use fast pcall + show one-time guidance if error occurs
        local results = {pcall(func, ...)}
        local success = results[1]

        -- If error occurred, show guidance (if not shown before) and track the error (protected)
        if not success then
            -- Protect ShowErrorGuidanceMessage - don't let it break execution
            local okGuidance, _ = pcall(ShowErrorGuidanceMessage)
            -- Silently ignore guidance errors

            -- Protect TrackError - don't let tracking errors break execution
            local okTrack, _ = pcall(function()
                local errorMsg = tostring(results[2])
                -- Only track NAG-related errors (errors in NAG code, not other addons)
                if strfind(errorMsg, "NAG") or strfind(errorMsg, "Interface\\AddOns\\NAG") then
                    TrackError("LuaError", errorMsg, {})
                end
            end)
            -- Silently ignore tracking errors
        end

        return unpack(results)
    end
end

--- Extract error message from pcall result (handles both string and table formats)
--- This is the recommended way to extract error messages from ns.pcall results
--- @param err any The error result from pcall (can be string or table)
--- @return string The error message
function ns.ExtractErrorMessage(err)
    if type(err) == "table" then
        -- Enhanced error format (from ns.EnhancedPCall or ns.SafeCall)
        if err.error then
            return tostring(err.error)
        elseif err.message then
            return tostring(err.message)
        else
            -- Fallback: try to stringify the table
            return tostring(err)
        end
    else
        -- Standard error format (string)
        return tostring(err)
    end
end

-- Export safe versions for common use cases
ns.safeCall = ns.SafeCall
ns.pcallWithHandler = ns.PCallWithHandler
ns.batchPCall = ns.BatchPCall
ns.analyzeErrors = ns.AnalyzeErrors

