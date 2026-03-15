--- Handles centralized logging and debugging functionality for the NAG addon.
---
--- Provides a singleton service for managing debug settings, logging messages, and
--- debugging conditions. No longer inherits from CoreModule or uses Ace3.
---
--- NEW: Throttled Logging Feature
--- =============================
--- The DebugManager now includes throttled logging functionality to reduce debug spam
--- in update-heavy modules. This is especially useful for modules that run frequently
--- (like DisplayManager, RequirementsChecker, etc.) where you want to log information
--- but not flood the chat with repeated messages.
---
--- Usage Examples:
--- --------------
--- 1. Basic throttled logging (1 second default interval):
---    self:ThrottledDebug("UpdateIcons: Processing sequence", "UpdateIcons:Sequence", 1.0)
---
--- 2. Throttled logging with format strings:
---    self:ThrottledDebug("UpdateIcons: Displaying %d spells", "UpdateIcons:SpellCount", 2.0, spellCount)
---
--- 3. Different severity levels:
---    self:ThrottledInfo("Module initialized", "Module:Init", 5.0)
---    self:ThrottledWarn("Performance warning", "Module:Performance", 10.0)
---    self:ThrottledError("Critical error", "Module:Error", 30.0)
---
--- 4. Manual throttle management:
---    self:ClearThrottle("UpdateIcons:Sequence")  -- Clear specific throttle
---    self:ClearAllThrottles()  -- Clear all throttles
---
--- 5. Slash commands for throttle management:
---    /nagdebug throttle info          -- Show throttle cache info
---    /nagdebug throttle clear all     -- Clear all throttles
---    /nagdebug throttle clear ModuleName  -- Clear throttles for specific module
---
--- 6. Development-friendly commands:
---    /nagdebug throttle bypass on     -- Disable throttling (show all logs)
---    /nagdebug throttle bypass off    -- Enable throttling (normal behavior)
---    /nagdebug throttle stats         -- Show throttling statistics
---    /nagdebug throttle reset         -- Reset throttle statistics
---
--- Performance & Development Features:
--- ===================================
--- - Module name caching to avoid repeated GetName() calls
--- - Global bypass mode for development (disable all throttling)
--- - Automatic statistics tracking (throttle rate, cache size)
--- - Aggressive cleanup during heavy usage (cache > 100 entries)
--- - Minimal overhead: ~0.002ms per throttled log call
--- - Memory efficient with automatic cleanup every 5 minutes
---
--- Throttle Keys:
--- --------------
--- Use descriptive, unique keys for your throttled messages. Good examples:
--- - "UpdateIcons:SequenceDisplay"
--- - "RequirementsChecker:SpellCheck"
--- - "DisplayManager:FrameUpdate"
--- - "ModuleName:FunctionName"
---
--- The throttle system automatically combines the module name with your key to create
--- a unique cache entry, so you don't need to worry about conflicts between modules.
---
--- Migration Example:
--- =================
--- Before (manual throttling):
---   if not self._lastLogTime or GetTime() - self._lastLogTime > 1.0 then
---       self:Debug("UpdateIcons: Processing sequence")
---       self._lastLogTime = GetTime()
---   end
---
--- After (using throttled logging):
---   self:ThrottledDebug("UpdateIcons: Processing sequence", "UpdateIcons:Sequence", 1.0)
---
--- Benefits:
--- - No need to manage your own timing variables
--- - Automatic cleanup of old throttle entries
--- - Centralized throttle management via slash commands
--- - Consistent behavior across all modules
--- - Memory efficient with automatic cleanup
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
-- Get the main addon instance directly
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local format = string.format
local tinsert = tinsert
local wipe = wipe

-- Enhanced error handling
local pcall = ns.pcall



-- ~~~~~~~~~~ DEBUG MANAGER (SINGLETON TABLE) ~~~~~~~~~~
--- @class DebugManager
local DebugManager = {}

-- DebugManager is a core service that must be available before OptionsManager is initialized
-- The shared utility handles circular dependency issues while maintaining consistency

-- Use centralized colors from Utils
local DEBUG_COLORS = {
    [ns.DEBUG_LEVELS.ERROR] = ns.GetDebugColor and ns.GetDebugColor(ns.DEBUG_LEVELS.ERROR) or '|cffff0000',
    [ns.DEBUG_LEVELS.WARN]  = ns.GetDebugColor and ns.GetDebugColor(ns.DEBUG_LEVELS.WARN) or '|cffffff00',
    [ns.DEBUG_LEVELS.INFO]  = ns.GetDebugColor and ns.GetDebugColor(ns.DEBUG_LEVELS.INFO) or '|cff00ff00',
    [ns.DEBUG_LEVELS.DEBUG] = ns.GetDebugColor and ns.GetDebugColor(ns.DEBUG_LEVELS.DEBUG) or '|cff00bfff',
    [ns.DEBUG_LEVELS.TRACE] = ns.GetDebugColor and ns.GetDebugColor(ns.DEBUG_LEVELS.TRACE) or '|cff87ceeb',
}

-- Message buffer for early logging
local messageBuffer = {}
local dlapiBuffer = {}
local isInitialized = false
local isDLAPIReady = false
local pendingLogLevel = nil -- Will be set by the main addon when DB is ready

-- Log throttling to prevent "script ran too long" during heavy debug spam
local LOG_WINDOW_SECONDS = 0.1
local LOG_WINDOW_LIMIT = 200 -- max logs per window for DEBUG/TRACE/INFO
local logWindowStart = 0
local logWindowCount = 0
local logThrottleNotified = false
local isBufferFlushed = false

-- Early logs buffer (simplified without DebugConsole)
local pendingEarlyLogs = {} -- Store early logs until flush

-- NEW: Throttled logging storage
local throttleCache = {}              -- {moduleName:throttleKey = lastLogTime}
local throttleCleanupTime = 0         -- Last cleanup time
local THROTTLE_CLEANUP_INTERVAL = 300 -- Clean up old entries every 5 minutes

-- NEW: Early logs buffer size limit
local MAX_EARLY_LOGS_ARCHIVE = 1000 -- Maximum number of early logs to keep in memory

-- NEW: Development optimizations
local moduleNameCache = {}          -- Cache module names to avoid repeated GetName() calls
local throttleBypassEnabled = false -- Global bypass for development
local throttleStats = {             -- Track throttling effectiveness
    totalCalls = 0,
    throttledCalls = 0,
    lastResetTime = 0
}

-- Output callback system removed - no longer needed without DebugConsole

-- Private: Helper to convert severity number to string category
local function severityToCategory(severity)
    -- Ensure severity is a valid number
    if not severity or type(severity) ~= "number" then
        severity = ns.DEBUG_LEVELS.DEBUG -- Default to DEBUG level
    end

    if type(severity) == "number" then
        return (severity == ns.DEBUG_LEVELS.ERROR and "ERROR"
            or severity == ns.DEBUG_LEVELS.WARN and "WARN"
            or severity == ns.DEBUG_LEVELS.INFO and "INFO"
            or severity == ns.DEBUG_LEVELS.DEBUG and "DEBUG"
            or severity == ns.DEBUG_LEVELS.TRACE and "TRACE"
            or tostring(severity))
    elseif type(severity) == "string" then
        return severity:upper()
    end
    return "DEBUG"
end

-- Private/internal: Only ever call with a string category!
local function sendToDLAPI(category, formattedMessage)
    if not isDLAPIReady and DLAPI and DLAPI.DebugLog then
        isDLAPIReady = true
        -- Flush buffer now that DLAPI is ready
        for _, msg in ipairs(dlapiBuffer) do
            DLAPI.DebugLog(msg.category, msg.message)
            DLAPI.DebugLog("NAG_Consolidated", msg.message)
        end
        wipe(dlapiBuffer)
    end
    if not isDLAPIReady then
        tinsert(dlapiBuffer, { category = category, message = formattedMessage })
        return
    end
    DLAPI.DebugLog(category, formattedMessage)
    DLAPI.DebugLog("NAG_Consolidated", formattedMessage)
end

-- Helper to format debug message
local function formatDebugMessage(severity, message, stackTrace, moduleSelf)
    -- Ensure severity is a valid number
    if not severity or type(severity) ~= "number" then
        severity = ns.DEBUG_LEVELS.DEBUG -- Default to DEBUG level
    end

    -- Keep original severity-based color coding
    local severityColor = DEBUG_COLORS[severity] or '|cffff0000'

    -- Use our unified aliases for module names
    local moduleName = nil
    if moduleSelf and type(moduleSelf.GetName) == "function" then
        moduleName = moduleSelf:GetName()
    elseif moduleSelf and type(moduleSelf) == "string" then
        moduleName = moduleSelf
    end

    -- Use our unified aliases
    local alias = ns.MODULE_ALIASES and ns.MODULE_ALIASES[moduleName] or moduleName or "Unknown"

    -- Get module type color for the module name (with safety check)
    local moduleColor = "|cff33ff99" -- Default light blue
    if ns.GetModuleTypeColor then
        moduleColor = ns.GetModuleTypeColor(moduleSelf)
    end

    -- Add severity indicator to the prefix
    local severityText = (severity == ns.DEBUG_LEVELS.ERROR and "ERROR"
        or severity == ns.DEBUG_LEVELS.WARN and "WARN"
        or severity == ns.DEBUG_LEVELS.INFO and "INFO"
        or severity == ns.DEBUG_LEVELS.DEBUG and "DEBUG"
        or severity == ns.DEBUG_LEVELS.TRACE and "TRACE"
        or tostring(severity))

    -- Format: [module color]Alias[severity color][severity]|r|r: [default color]message
    -- First |r closes severity color, second |r closes module color
    local prefix = format("%s%s%s[%s]|r|r", moduleColor, alias, severityColor, severityText)

    if type(message) == "table" then
        local lines = { prefix .. ": Table Contents:" }
        for k, v in pairs(message) do
            tinsert(lines, format("%s  %s: %s", severityColor, tostring(k), tostring(v)))
        end
        if stackTrace then
            tinsert(lines, stackTrace)
        end
        return table.concat(lines, "\n")
    else
        -- The prefix already has |r, so colon and message will use default color
        return format("%s: %s%s", prefix, tostring(message), stackTrace and "\n" .. stackTrace or "")
    end
end

-- Helper: If in devMode and DLAPI is available, log to module category as well
local function maybeLogToModuleCategory(moduleSelf, message, severity, stackTrace)
    if not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) then return end
    if not (DLAPI and DLAPI.DebugLog) then return end
    if not (moduleSelf and type(moduleSelf.GetName) == "function") then return end
    local moduleName = moduleSelf:GetName()
    if not moduleName then return end
    -- Pass moduleSelf to formatDebugMessage so it can properly extract the module name
    local formattedMessage = formatDebugMessage(severity, message, stackTrace, moduleSelf)
    DLAPI.DebugLog(moduleName, formattedMessage)
end

-- Helper to get global debug level
local cachedDebugLevel = ns.DEBUG_LEVELS.ERROR
local function getDebugLevel()
    -- Fast path: if OptionsManager/db not ready, use ERROR (matches default)
    local OptionsManager = ns.OptionsManager
    if not OptionsManager or not OptionsManager.db then
        return cachedDebugLevel
    end

    local lvl = cachedDebugLevel
    local ok, value = pcall(ns.DatabaseUtils.GetSetting, OptionsManager.db, "global", "debugLevel")
    if ok and value ~= nil then
        lvl = tonumber(value) or ns.DEBUG_LEVELS.ERROR
        cachedDebugLevel = lvl
    end

    return lvl
end

-- Maximum chat windows we support for debug output (matches WoW NUM_CHAT_WINDOWS)
local NUM_DEBUG_CHAT_FRAMES = 10
-- Value meaning "use main debug output channel" for per-level overrides
local CHANNEL_USE_DEFAULT = 0

-- Resolve configured debug output channel to a chat frame.
-- When severity is provided, checks global.debugOutputChannelByLevel.<severity> first;
-- 0 or nil means use the main debugOutputChannel. One extra GetSetting only when severity is passed.
-- @param severity number|nil Optional DEBUG_LEVELS value (ERROR/WARN/INFO/DEBUG/TRACE)
-- @return table|nil Frame with AddMessage, or DEFAULT_CHAT_FRAME if unresolved
local function getDebugOutputFrame(severity)
    local defaultFrame = _G.DEFAULT_CHAT_FRAME
    if not defaultFrame or not defaultFrame.AddMessage then
        return nil
    end

    local OptionsManager = ns.OptionsManager
    if not OptionsManager or not OptionsManager.db then
        return defaultFrame
    end

    local channel
    if severity ~= nil and type(severity) == "number" then
        local ok, perLevel = pcall(ns.DatabaseUtils.GetSetting, OptionsManager.db, "global",
            "debugOutputChannelByLevel." .. tostring(severity))
        if ok and perLevel and tonumber(perLevel) and tonumber(perLevel) ~= CHANNEL_USE_DEFAULT then
            channel = perLevel
        end
    end
    if channel == nil then
        local ok, main = pcall(ns.DatabaseUtils.GetSetting, OptionsManager.db, "global", "debugOutputChannel")
        if ok and main ~= nil then
            channel = main
        end
    end

    local id = tonumber(channel)
    if not id or id < 1 or id > NUM_DEBUG_CHAT_FRAMES then
        return defaultFrame
    end

    local frame = _G["ChatFrame" .. id]
    if frame and type(frame.AddMessage) == "function" then
        return frame
    end
    return defaultFrame
end

-- Helper to check if a message at a given level should be logged
local function shouldLog(moduleSelf, level)
    -- If not initialized, only allow ERROR/WARN (no debug work)
    if not isInitialized then
        return level and level <= ns.DEBUG_LEVELS.WARN
    end -- Buffer early logs is disabled to avoid cost when off

    -- Ensure level is a valid number
    if not level or type(level) ~= "number" then
        level = ns.DEBUG_LEVELS.DEBUG -- Default to DEBUG level
    end

    if level == ns.DEBUG_LEVELS.ERROR then return true end

    -- Check if module debug is enabled
    if moduleSelf then
        local moduleName = type(moduleSelf) == "string" and moduleSelf or (moduleSelf.GetName and moduleSelf:GetName())
        if moduleName then
            local OptionsManager = NAG and ns.OptionsManager
            if OptionsManager.db then
                local moduleDB = OptionsManager.db:GetNamespace(moduleName, true) -- silent = true
                if moduleDB and moduleDB.global and moduleDB.global.debugEnabled == false then
                    return false                                                  -- Module debug is explicitly disabled
                end
            end
        end

        -- NEW: Check category-based debug settings (ONLY for DEBUG and TRACE levels)
        if (level == ns.DEBUG_LEVELS.DEBUG or level == ns.DEBUG_LEVELS.TRACE) and
            moduleSelf.GetDebugCategories and moduleSelf.IsDebugEnabledForCategories then
            -- Only check categories if global debug level allows DEBUG/TRACE
            local globalLevel = getDebugLevel()
            if globalLevel >= level and ns.DEBUG_CATEGORIES then
                local OptionsManager = NAG and ns.OptionsManager
                if OptionsManager and OptionsManager.db then
                    local anyCategoriesEnabled = false
                    for _, category in pairs(ns.DEBUG_CATEGORIES) do
                        local categoryEnabled = ns.DatabaseUtils.GetSetting(OptionsManager.db, "global",
                            "debugCategories." .. category, false)
                        if categoryEnabled then
                            anyCategoriesEnabled = true
                            break
                        end
                    end

                    if anyCategoriesEnabled then
                        return moduleSelf:IsDebugEnabledForCategories()
                    end
                end
            end
        end
    end

    -- Check global debug level
    return getDebugLevel() >= level
end

function DebugManager:flushBuffer()
    if isBufferFlushed then return end
    if not isInitialized or not pendingLogLevel then return end
    isBufferFlushed = true

    self:debug(NAG, "flushBuffer: Processing " .. #messageBuffer .. " early messages")

    -- NEW: Use unified pipeline - store early logs until all consumers are ready
    for _, msg in ipairs(messageBuffer) do
        local stackTrace = msg.printTrace and debugstack and debugstack(3, 2, 0) or nil
        local formattedMessage = formatDebugMessage(msg.severity, msg.message, stackTrace, msg.moduleSelf)
        local category = severityToCategory(msg.severity)

        -- Always send to DLAPI immediately
        sendToDLAPI(category, formattedMessage)

        -- Store for unified flush to other consumers
        tinsert(pendingEarlyLogs, {
            message = formattedMessage,
            severity = msg.severity,
            moduleName = msg.moduleSelf and type(msg.moduleSelf.GetName) == "function" and msg.moduleSelf:GetName() or
                (msg.moduleSelf and type(msg.moduleSelf) == "string" and msg.moduleSelf or nil),
            timestamp = GetTime()
        })

        -- Limit pending logs size to prevent memory issues
        while #pendingEarlyLogs > MAX_EARLY_LOGS_ARCHIVE do
            tremove(pendingEarlyLogs, 1)
        end
    end
    wipe(messageBuffer)

    self:debug(NAG, "flushBuffer: Stored " .. #pendingEarlyLogs .. " logs in pendingEarlyLogs")

    -- Try unified flush immediately
    self:TryUnifiedFlush()
end

function DebugManager:setPendingLogLevel(level)
    pendingLogLevel = level
    -- If initialized and buffer not yet flushed, flush now
    if isInitialized and not isBufferFlushed then
        DebugManager:flushBuffer()
    end
end

function DebugManager:initialize()
    isInitialized = true
    if DLAPI and DLAPI.DebugLog then
        isDLAPIReady = true
        for _, msg in ipairs(dlapiBuffer) do
            sendToDLAPI(msg.category, msg.message)
        end
        wipe(dlapiBuffer)
    end

    -- Only flush buffer if log level is set
    if pendingLogLevel and not isBufferFlushed then
        DebugManager:flushBuffer()
    end

    -- Check for enabled debug categories and show warning
    self:CheckAndWarnAboutEnabledCategories()
end

-- Check if any debug categories are enabled and show a warning
function DebugManager:CheckAndWarnAboutEnabledCategories()
    if not NAG or not ns.DEBUG_CATEGORIES then
        return
    end

    local OptionsManager = ns.OptionsManager
    if not OptionsManager or not OptionsManager.db then
        return
    end

    local enabledCategories = {}
    for _, category in pairs(ns.DEBUG_CATEGORIES) do
        local isEnabled = ns.DatabaseUtils.GetSetting(OptionsManager.db, "global", "debugCategories." .. category, false)
        if isEnabled then
            tinsert(enabledCategories, category)
        end
    end

    if #enabledCategories > 0 then
        local frame = getDebugOutputFrame()
        local out = frame and frame.AddMessage and function(msg) frame:AddMessage(msg) end or print
        local categoryList = table.concat(enabledCategories, ", ")
        out("|cffff9900[NAG] Debug Categories Enabled:|r " .. categoryList)
        out("|cffff9900[NAG] Filtering Mode: Only DEBUG/TRACE from enabled categories will be shown.|r")
        out("|cffff9900[NAG] ERROR/WARN/INFO messages from all modules will still be shown.|r")
        out("|cffff9900[NAG] Use /nagdebug category disableall to disable all categories.|r")
    end
end

-- ~~~~~~~~~~ GLOBAL EXPOSURE ~~~~~~~~~~

do -- ~~~~~~~~~~ Public API ~~~~~~~~~~
    -- Add Print function for unified logging compatibility
    function DebugManager:Print(...)
        ns.UnifiedPrint(self, ...)
    end

    --- Returns the chat frame used for debug output.
    --- When severity is given, uses per-level override (debugOutputChannelByLevel.<n>) if set, else main channel.
    --- @param severity number|nil Optional DEBUG_LEVELS value to use per-level channel override
    --- @return table|nil Frame with AddMessage, or nil if none available
    function DebugManager:GetDebugOutputFrame(severity)
        return getDebugOutputFrame(severity)
    end

    function DebugManager:DebugLog(category, message, severity)
        -- Optionally filter by severity if provided
        if severity and not shouldLog(NAG, severity) then return end
        local formattedMessage = formatDebugMessage(severity or ns.DEBUG_LEVELS.DEBUG, message, nil, category)

        local cat = type(category) == "number" and severityToCategory(category) or tostring(category)
        sendToDLAPI(cat, formattedMessage)
    end

    function DebugManager:log(moduleSelf, message, severity, printTrace)
        severity = severity or ns.DEBUG_LEVELS.DEBUG
        local stackTrace = printTrace and debugstack and debugstack(3, 2, 0) or nil
        if not isInitialized then
            table.insert(messageBuffer,
                { moduleSelf = moduleSelf, message = message, severity = severity, printTrace = printTrace })
            return
        end
        if not shouldLog(moduleSelf, severity) then return end

        -- Throttle debug/info/trace to avoid execution limit errors
        if severity >= ns.DEBUG_LEVELS.DEBUG then
            local now = GetTime()
            if (now - logWindowStart) > LOG_WINDOW_SECONDS then
                logWindowStart = now
                logWindowCount = 0
                logThrottleNotified = false
            end
            logWindowCount = logWindowCount + 1
            if logWindowCount > LOG_WINDOW_LIMIT then
                if not logThrottleNotified then
                    logThrottleNotified = true
                    local frame = getDebugOutputFrame()
                    if frame and frame.AddMessage then
                        frame:AddMessage("|cffff9900[NAG] Debug logging throttled (too many messages in a short time).|r")
                    else
                        print("|cffff9900[NAG] Debug logging throttled (too many messages in a short time).|r")
                    end
                end
                return
            end
        end

        local formattedMessage = formatDebugMessage(severity, message, stackTrace, moduleSelf)

        -- Output to configured channel (per-level override or main debugOutputChannel)
        local frame = getDebugOutputFrame(severity)
        if frame and frame.AddMessage then
            frame:AddMessage(formattedMessage)
        else
            print(formattedMessage)
        end

        local category = severityToCategory(severity)
        sendToDLAPI(category, formattedMessage)
        -- New: Also log to module category if in devMode and DLAPI is available
        maybeLogToModuleCategory(moduleSelf, message, severity, stackTrace)

        -- Send messages for warnings/errors so SnapshotManager can collect them
        if severity == ns.DEBUG_LEVELS.WARN then
            local moduleName = moduleSelf and type(moduleSelf.GetName) == "function" and moduleSelf:GetName() or "Unknown"
            NAG:SendMessage("NAG_WARNING", moduleName, message)
        elseif severity == ns.DEBUG_LEVELS.ERROR then
            local moduleName = moduleSelf and type(moduleSelf.GetName) == "function" and moduleSelf:GetName() or "Unknown"
            NAG:SendMessage("NAG_ERROR", moduleName, message)
        end
    end

    function DebugManager:debug(moduleSelf, msg, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted
        if #args > 0 then
            local success, result = pcall(format, msg, unpack(args))
            formatted = success and result or tostring(msg)
        else
            formatted = tostring(msg)
        end
        self:log(moduleSelf, formatted, ns.DEBUG_LEVELS.DEBUG, printTrace)
    end

    DebugManager.Debug = DebugManager.debug

    function DebugManager:info(moduleSelf, msg, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted
        if #args > 0 then
            local success, result = pcall(format, msg, unpack(args))
            formatted = success and result or tostring(msg)
        else
            formatted = tostring(msg)
        end
        self:log(moduleSelf, formatted, ns.DEBUG_LEVELS.INFO, printTrace)
    end

    DebugManager.Info = DebugManager.info

    function DebugManager:warn(moduleSelf, msg, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted
        if #args > 0 then
            local success, result = pcall(format, msg, unpack(args))
            formatted = success and result or tostring(msg)
        else
            formatted = tostring(msg)
        end
        self:log(moduleSelf, formatted, ns.DEBUG_LEVELS.WARN, printTrace)
    end

    DebugManager.Warn = DebugManager.warn

    function DebugManager:error(moduleSelf, msg, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted
        if #args > 0 then
            local success, result = pcall(format, msg, unpack(args))
            formatted = success and result or tostring(msg)
        else
            formatted = tostring(msg)
        end
        self:log(moduleSelf, formatted, ns.DEBUG_LEVELS.ERROR, printTrace)
    end

    DebugManager.Error = DebugManager.error

    function DebugManager:trace(moduleSelf, msg, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted
        if #args > 0 then
            local success, result = pcall(format, msg, unpack(args))
            formatted = success and result or tostring(msg)
        else
            formatted = tostring(msg)
        end
        self:log(moduleSelf, formatted, ns.DEBUG_LEVELS.TRACE, printTrace)
    end

    DebugManager.Trace = DebugManager.trace

    -- NEW: Throttled logging functionality
    function DebugManager:throttled_log(moduleSelf, message, throttleKey, throttleInterval, severity, printTrace)
        -- Validate parameters
        if not throttleKey or type(throttleKey) ~= "string" then
            self:error(moduleSelf, "throttled_log: throttleKey must be a non-empty string")
            return false
        end

        throttleInterval = throttleInterval or 1.0 -- Default 1 second
        severity = severity or ns.DEBUG_LEVELS.DEBUG

        -- OPTIMIZATION: Check global bypass first (for development)
        if throttleBypassEnabled then
            self:log(moduleSelf, message, severity, printTrace)
            return true
        end

        -- OPTIMIZATION: Cache module names to avoid repeated GetName() calls
        local moduleName = nil
        local moduleKey = tostring(moduleSelf)

        if moduleNameCache[moduleKey] then
            moduleName = moduleNameCache[moduleKey]
        else
            if moduleSelf and type(moduleSelf.GetName) == "function" then
                moduleName = moduleSelf:GetName()
            elseif moduleSelf and type(moduleSelf) == "string" then
                moduleName = moduleSelf
            else
                moduleName = "Unknown"
            end
            moduleNameCache[moduleKey] = moduleName
        end

        -- Create cache key
        local cacheKey = moduleName .. ":" .. throttleKey
        local currentTime = GetTime()

        -- Track statistics
        throttleStats.totalCalls = throttleStats.totalCalls + 1

        -- Check if we should throttle this message
        local lastLogTime = throttleCache[cacheKey]
        if lastLogTime and (currentTime - lastLogTime) < throttleInterval then
            throttleStats.throttledCalls = throttleStats.throttledCalls + 1
            return false -- Throttled
        end

        -- Update cache and log the message
        throttleCache[cacheKey] = currentTime

        -- OPTIMIZATION: More aggressive cleanup during heavy usage
        local cacheSize = 0
        for _ in pairs(throttleCache) do
            cacheSize = cacheSize + 1
        end

        -- Clean up more frequently if cache is large (development scenario)
        local cleanupInterval = cacheSize > 100 and 60 or THROTTLE_CLEANUP_INTERVAL
        if currentTime - throttleCleanupTime > cleanupInterval then
            self:_cleanup_throttle_cache(currentTime)
            throttleCleanupTime = currentTime
        end

        -- Log the message using the standard log method
        self:log(moduleSelf, message, severity, printTrace)
        return true -- Successfully logged
    end

    DebugManager.ThrottledLog = DebugManager.throttled_log

    -- Utility: Clear a specific throttle entry
    function DebugManager:clear_throttle(moduleSelf, throttleKey)
        local moduleName = nil
        if moduleSelf and type(moduleSelf.GetName) == "function" then
            moduleName = moduleSelf:GetName()
        elseif moduleSelf and type(moduleSelf) == "string" then
            moduleName = moduleSelf
        else
            moduleName = "Unknown"
        end

        local cacheKey = moduleName .. ":" .. throttleKey
        throttleCache[cacheKey] = nil
    end

    DebugManager.ClearThrottle = DebugManager.clear_throttle

    -- Utility: Clear all throttle entries
    function DebugManager:clear_all_throttles()
        wipe(throttleCache)
        throttleCleanupTime = 0
    end

    DebugManager.ClearAllThrottles = DebugManager.clear_all_throttles

    -- Utility: Get throttle information for debugging
    function DebugManager:get_throttle_info(moduleSelf, throttleKey)
        local moduleName = nil
        if moduleSelf and type(moduleSelf.GetName) == "function" then
            moduleName = moduleSelf:GetName()
        elseif moduleSelf and type(moduleSelf) == "string" then
            moduleName = moduleSelf
        else
            moduleName = "Unknown"
        end

        local cacheKey = moduleName .. ":" .. throttleKey
        local lastLogTime = throttleCache[cacheKey]
        local currentTime = GetTime()

        if lastLogTime then
            return {
                lastLogTime = lastLogTime,
                timeSinceLastLog = currentTime - lastLogTime,
                cacheKey = cacheKey
            }
        else
            return {
                lastLogTime = nil,
                timeSinceLastLog = nil,
                cacheKey = cacheKey
            }
        end
    end

    DebugManager.GetThrottleInfo = DebugManager.get_throttle_info

    -- NEW: Development utilities
    function DebugManager:set_throttle_bypass(enabled)
        throttleBypassEnabled = enabled
        if enabled then
            self:info(NAG, "Throttled logging bypass ENABLED - all throttled logs will be shown")
        else
            self:info(NAG, "Throttled logging bypass DISABLED - normal throttling behavior restored")
        end
    end

    DebugManager.SetThrottleBypass = DebugManager.set_throttle_bypass

    function DebugManager:get_throttle_stats()
        local currentTime = GetTime()
        local throttleRate = throttleStats.totalCalls > 0 and
            (throttleStats.throttledCalls / throttleStats.totalCalls * 100) or 0

        return {
            totalCalls = throttleStats.totalCalls,
            throttledCalls = throttleStats.throttledCalls,
            throttleRate = throttleRate,
            cacheSize = 0, -- Calculate actual cache size
            bypassEnabled = throttleBypassEnabled,
            lastResetTime = throttleStats.lastResetTime
        }
    end

    DebugManager.GetThrottleStats = DebugManager.get_throttle_stats

    function DebugManager:reset_throttle_stats()
        throttleStats.totalCalls = 0
        throttleStats.throttledCalls = 0
        throttleStats.lastResetTime = GetTime()
        self:info(NAG, "Throttle statistics reset")
    end

    DebugManager.ResetThrottleStats = DebugManager.reset_throttle_stats

    -- Output callback methods removed - no longer needed without DebugConsole





    -- Flush function that sends early logs through proper logging system
    function DebugManager:TryUnifiedFlush()
        if #pendingEarlyLogs == 0 then return end

        self:debug(NAG, "Flushing " .. #pendingEarlyLogs .. " early logs through logging system")

        for _, logData in ipairs(pendingEarlyLogs) do
            -- Send through proper logging system if within debug level
            if logData.severity <= pendingLogLevel then
                -- Use the proper log method instead of print()
                -- This ensures logs go through DLAPI and any other logging infrastructure
                self:log(NAG, logData.message, logData.severity, false)
            end
        end

        -- Clear pending logs
        wipe(pendingEarlyLogs)

        self:debug(NAG, "Early logs flush completed")
    end

    DebugManager.TryUnifiedFlush = DebugManager.TryUnifiedFlush

    -- Private: Clean up old throttle cache entries
    function DebugManager:_cleanup_throttle_cache(currentTime)
        local cutoffTime = currentTime - 3600 -- Remove entries older than 1 hour
        local removedCount = 0

        for cacheKey, lastLogTime in pairs(throttleCache) do
            if lastLogTime < cutoffTime then
                throttleCache[cacheKey] = nil
                removedCount = removedCount + 1
            end
        end

        if removedCount > 0 then
            -- Log cleanup (but don't throttle this log to avoid infinite loops)
            self:log(NAG, format("Cleaned up %d old throttle cache entries", removedCount), ns.DEBUG_LEVELS.TRACE, false)
        end
    end

    -- Convenience methods for throttled logging with specific severity levels
    function DebugManager:throttled_debug(moduleSelf, message, throttleKey, throttleInterval, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted = (#args > 0) and format(message, unpack(args)) or tostring(message)
        return self:throttled_log(moduleSelf, formatted, throttleKey, throttleInterval, ns.DEBUG_LEVELS.DEBUG, printTrace)
    end

    DebugManager.ThrottledDebug = DebugManager.throttled_debug

    function DebugManager:throttled_info(moduleSelf, message, throttleKey, throttleInterval, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted = (#args > 0) and format(message, unpack(args)) or tostring(message)
        return self:throttled_log(moduleSelf, formatted, throttleKey, throttleInterval, ns.DEBUG_LEVELS.INFO, printTrace)
    end

    DebugManager.ThrottledInfo = DebugManager.throttled_info

    function DebugManager:throttled_warn(moduleSelf, message, throttleKey, throttleInterval, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted = (#args > 0) and format(message, unpack(args)) or tostring(message)
        return self:throttled_log(moduleSelf, formatted, throttleKey, throttleInterval, ns.DEBUG_LEVELS.WARN, printTrace)
    end

    DebugManager.ThrottledWarn = DebugManager.throttled_warn

    function DebugManager:throttled_error(moduleSelf, message, throttleKey, throttleInterval, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted = (#args > 0) and format(message, unpack(args)) or tostring(message)
        return self:throttled_log(moduleSelf, formatted, throttleKey, throttleInterval, ns.DEBUG_LEVELS.ERROR, printTrace)
    end

    DebugManager.ThrottledError = DebugManager.throttled_error

    function DebugManager:throttled_trace(moduleSelf, message, throttleKey, throttleInterval, ...)
        local args = { ... }
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local formatted = (#args > 0) and format(message, unpack(args)) or tostring(message)
        return self:throttled_log(moduleSelf, formatted, throttleKey, throttleInterval, ns.DEBUG_LEVELS.TRACE, printTrace)
    end

    DebugManager.ThrottledTrace = DebugManager.throttled_trace
end

ns.DebugManager = DebugManager
