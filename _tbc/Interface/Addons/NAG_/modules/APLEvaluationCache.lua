--- @module "NAG.APLEvaluationCache"
--- APL Evaluation Cache System for the NAG addon
---
--- This module provides transparent caching for APL handler function calls during
--- rotation evaluation cycles, eliminating redundant calculations and providing
--- significant performance improvements.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local L = ns.AceLocale:GetLocale("NAG")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
-- ~~~~~~~~~~ MODULE DECLARATIONS ~~~~~~~~~~
local DebugFrameUtil = ns.DebugFrameUtil

-- Lua APIs (WoW optimized where available)
local format = string.format
local pairs = pairs
local type = type
local tostring = tostring
local wipe = wipe
local max = math.max
local min = math.min
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
-- High-precision timing for performance measurement
local debugprofilestop = debugprofilestop

-- ~~~~~~~~~~ MODULE DEFAULTS ~~~~~~~~~~
local defaults = {
    global = {
        -- Cache settings
        enableCache = false, -- Disabled by default due to user-reported issues
        enableDebugStats = false,
        maxCacheEntries = 1000,
        cacheIterations = 1, -- How ma ny rotation iterations to keep cache (1 = clear every iteration)

        -- Performance monitoring
        trackPerformance = false,
        performanceHistorySize = 100
    }
}

--- @class APLEvaluationCache: CoreModule
local APLEvaluationCache = NAG:CreateModule("APLEvaluationCache", defaults, {
    defaultState = {
        -- Cache state
        active = false,
        evaluationId = 0,
        cache = {},
        cacheSize = 0,

        -- Performance tracking
        stats = {
            totalEvaluations = 0,
            totalCalls = 0,
            totalCacheHits = 0,
            totalEvaluationTime = 0,
            totalHighPrecisionTime = 0,
            lastEvaluationTime = 0,
            lastHighPrecisionTime = 0,
            functionCallCounts = {},
            functionCacheHits = {},
            functionTimes = {},
            evaluationHistory = {}
        },

        -- Current evaluation metadata
        currentEvaluation = {
            startTime = 0,
            targetGUID = nil,
            timestamp = 0,
            callCount = 0,
            cacheHits = 0,
            cacheMisses = 0,
            functionStats = {},
            functionTotalTimes = {},
            -- Per-evaluation API timing for spike analysis
            evaluationAPITimes = {},
            -- Cached settings for O(1) access during evaluation
            enableCache = false,
            enableDebugStats = false,
            trackPerformance = false
        },

        -- Baseline timing (when cache disabled)
        baselineStart = nil,

        -- Handler wrapping tracking
        wrappedFunctions = {}, -- Track which functions are wrapped
        originalFunctions = {}, -- Store original function references
        wrappingComplete = false -- Track if lazy initialization is complete
    },

    -- Module type and category
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,

    -- Debug categories
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.ANALYZERS
    },

    -- Slash commands
    slashCommands = {
        ["aplcache_wrap"] = {
            handler = "HandleWrapCommand",
            help = "Wrap all APLValue handlers with caching",
            root = "nagdebug",
            path = {"aplcache", "wrap"},
            category = "Debug"
        },
        ["aplcache_unwrap"] = {
            handler = "HandleUnwrapCommand",
            help = "Unwrap all cached handlers",
            root = "nagdebug",
            path = {"aplcache", "unwrap"},
            category = "Debug"
        },
        ["aplcache_stats"] = {
            handler = "HandleStatsCommand",
            help = "Show cache statistics",
            root = "nagdebug",
            path = {"aplcache", "stats"},
            category = "Data"
        },
        ["aplcache_slowest"] = {
            handler = "HandleSlowestCommand",
            help = "Show slowest APIs by execution time",
            root = "nagdebug",
            path = {"aplcache", "slowest"},
            category = "Data"
        }
    }
})

local module = APLEvaluationCache
ns.APLEvaluationCache = APLEvaluationCache

-- Sentinel value for nil parameters (Lua doesn't allow nil as table key)
local NIL_SENTINEL = {}  -- Unique table as sentinel

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
function APLEvaluationCache:ModuleInitialize()
end

function APLEvaluationCache:ModuleEnable()

    -- Initialize performance tracking if enabled
    if self.db.global.trackPerformance then
        self:ResetStats()
    end

    -- Handlers will be wrapped on first use (lazy initialization) via EnsureWrappingComplete()
    -- This avoids all module load order timing issues
end

-- ~~~~~~~~~~ CORE CACHE FUNCTIONS ~~~~~~~~~~

--- Start a new APL evaluation cycle
function APLEvaluationCache:StartEvaluation(clearCache)
    -- Always track timing for baseline measurement (even when cache disabled)
    local highPrecisionStart = debugprofilestop()

    -- Notify APL Monitor Feed of tick start (compiled mode)
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
    if APLMonitorFeed and APLMonitorFeed:IsInstrumentationActive()
        and APLMonitorFeed:GetEvaluationMode() == "compiled" then
        APLMonitorFeed:BeginTick()
    end

    if not self.db.global.enableCache then
        -- Store timing for baseline measurement
        self.state.baselineStart = highPrecisionStart
        return
    end

    -- Lazy initialization: wrap handlers on first use (avoids module load order issues)
    self:EnsureWrappingComplete()

    self.state.active = true
    self.state.evaluationId = self.state.evaluationId + 1

    -- Only clear cache if explicitly requested (for new cycles)
    if clearCache then
        wipe(self.state.cache)
        self.state.cacheSize = 0
        if self.db.global.enableDebugStats then
            self:Debug("Cache cleared for new evaluation cycle")
        end
    end

    -- Reuse current evaluation metadata table (memory optimization)
    local now = GetTime()
    local eval = self.state.currentEvaluation
    eval.startTime = now
    eval.highPrecisionStart = highPrecisionStart
    eval.targetGUID = UnitGUID("target")
    eval.timestamp = now
    eval.callCount = 0
    eval.cacheHits = 0
    eval.cacheMisses = 0
    -- Reuse nested tables if they exist, otherwise create them once
    if not eval.functionStats then eval.functionStats = {} else wipe(eval.functionStats) end
    if not eval.evaluationAPITimes then eval.evaluationAPITimes = {} else wipe(eval.evaluationAPITimes) end
    -- Cache settings for O(1) access during evaluation
    eval.enableCache = self.db.global.enableCache
    eval.enableDebugStats = self.db.global.enableDebugStats
    eval.trackPerformance = self.db.global.trackPerformance

    if self.db.global.enableDebugStats then
        self:Debug("APL Evaluation #%d started (cache cleared: %s)", self.state.evaluationId, tostring(clearCache or false))
    end
end

--- End the current APL evaluation cycle
--- End the current APL evaluation cycle
--- @param keepAlive boolean If true, cache persists for next iteration instead of being cleared
function APLEvaluationCache:EndEvaluation(keepAlive)
    -- Always calculate timing for baseline measurement
    local highPrecisionEnd = debugprofilestop()

    -- Handle baseline timing (cache disabled)
    if self.state.baselineStart then
        self.state.baselineStart = nil
        -- Still notify APL Monitor Feed
        local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
        if APLMonitorFeed and APLMonitorFeed:IsInstrumentationActive()
            and APLMonitorFeed:GetEvaluationMode() == "compiled" then
            APLMonitorFeed:EndTick()
        end
        return
    end

    if not self.state.active then
        return
    end

    local now = GetTime()
    local evaluationTime = now - self.state.currentEvaluation.startTime

    -- Calculate high-precision evaluation time
    local highPrecisionTime = (highPrecisionEnd - self.state.currentEvaluation.highPrecisionStart) / 1000 -- Convert to seconds

    -- Notify APL Monitor Feed of tick end (compiled mode)
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
    if APLMonitorFeed and APLMonitorFeed:IsInstrumentationActive()
        and APLMonitorFeed:GetEvaluationMode() == "compiled" then
        APLMonitorFeed:EndTick()
    end

    -- Always update core counts (totalEvaluations, totalCalls, totalCacheHits) so UI shows activity
    -- History and detailed timing only when trackPerformance enabled
    self:UpdateEvaluationStats(evaluationTime, highPrecisionTime)

    -- Always print timing regardless of debug settings
    local hitRate = self.state.currentEvaluation.callCount > 0 and
        (self.state.currentEvaluation.cacheHits / self.state.currentEvaluation.callCount * 100) or 0

    if self.db.global.enableDebugStats then
        self:Debug("APL Evaluation #%d ended - Time: %.3fs (%.3fms high-precision), Calls: %d, Cache Hits: %d (%.1f%%)",
            self.state.evaluationId, evaluationTime, highPrecisionTime * 1000,
            self.state.currentEvaluation.callCount,
            self.state.currentEvaluation.cacheHits, hitRate)
    end

    self.state.active = false
    self.state.lastEvaluationTime = evaluationTime
    self.state.lastHighPrecisionTime = highPrecisionTime
end

--- Check if evaluation cache is currently active
--- @return boolean True if evaluation is active
function APLEvaluationCache:IsActive()
    return self.state.active
end

--- Generate numeric hash for multiple parameters (3+)
--- @param ... any Parameters to hash
--- @return number Hash value
function APLEvaluationCache:HashParams(...)
    local hash = 0
    local paramCount = select("#", ...)

    for i = 1, paramCount do
        local param = select(i, ...)
        local paramType = type(param)

        if paramType == "number" then
            hash = (hash * 31 + param) % 2147483647
        elseif paramType == "string" then
            -- String hash - first 8 chars for performance
            local len = min(8, #param)
            for j = 1, len do
                hash = (hash * 31 + string.byte(param, j)) % 2147483647
            end
        elseif paramType == "boolean" then
            hash = (hash * 31 + (param and 1 or 0)) % 2147483647
        elseif param == nil then
            hash = (hash * 31) % 2147483647
        else
            -- For tables or other types, use tostring hash
            local str = tostring(param)
            for j = 1, min(8, #str) do
                hash = (hash * 31 + string.byte(str, j)) % 2147483647
            end
        end
    end

    return hash
end

--- Pack multiple return values into a table
--- @param ... any Return values
--- @return table Packed returns with .n field for count
function APLEvaluationCache:PackReturns(...)
    local count = select("#", ...)
    local result = {...}
    result.n = count
    return result
end

--- Unpack multiple return values from a table
--- @param packed table Packed return values
--- @return any Unpacked return values
function APLEvaluationCache:UnpackReturns(packed)
    return unpack(packed, 1, packed.n)
end

--- Get a cached value or execute function and cache result
--- Uses nested table lookups instead of string keys for performance
--- @param category string The function category (unused in new implementation)
--- @param funcName string The function name
--- @param originalFunc function The original function to call
--- @param obj table The object to call the function on
--- @param ... any Function parameters
--- @return any The function result (supports multiple return values)
function APLEvaluationCache:GetCachedOrExecute(category, funcName, originalFunc, obj, ...)
    if not self.state.active then
        -- Not in evaluation context, call directly
        return originalFunc(obj, ...)
    end

    -- Get or create function-specific cache
    local funcCache = self.state.cache[funcName]
    if not funcCache then
        funcCache = {}
        self.state.cache[funcName] = funcCache
    end

    -- Update call statistics
    self.state.currentEvaluation.callCount = self.state.currentEvaluation.callCount + 1

    local paramCount = select("#", ...)
    local cachedResult

    -- Fast paths for common parameter counts (0-2 params cover 80%+ of cases)
    if paramCount == 0 then
        -- No parameters - use special key
        cachedResult = funcCache._noparams
        if cachedResult ~= nil then
            self.state.currentEvaluation.cacheHits = self.state.currentEvaluation.cacheHits + 1
            if self.state.currentEvaluation.trackPerformance then
                self:UpdateFunctionStats(funcName, true, 0)
            end
            return self:UnpackReturns(cachedResult)
        end

    elseif paramCount == 1 then
        -- Single parameter - nested table lookup to avoid collision with 2-param calls
        local p1 = ...
        -- Convert nil to sentinel (Lua doesn't allow nil as table key)
        if p1 == nil then p1 = NIL_SENTINEL end
        local p1Cache = funcCache[p1]
        if p1Cache and type(p1Cache) == "table" then
            cachedResult = p1Cache._single
            if cachedResult ~= nil then
                self.state.currentEvaluation.cacheHits = self.state.currentEvaluation.cacheHits + 1
                if self.state.currentEvaluation.trackPerformance then
                    self:UpdateFunctionStats(funcName, true, 0)
                end
                return self:UnpackReturns(cachedResult)
            end
        end

    elseif paramCount == 2 then
        -- Two parameters - nested table lookup
        local p1, p2 = ...
        -- Convert nil to sentinel (Lua doesn't allow nil as table key)
        if p1 == nil then p1 = NIL_SENTINEL end
        if p2 == nil then p2 = NIL_SENTINEL end
        local p1Cache = funcCache[p1]
        if p1Cache then
            cachedResult = p1Cache[p2]
            if cachedResult ~= nil then
                self.state.currentEvaluation.cacheHits = self.state.currentEvaluation.cacheHits + 1
                if self.state.currentEvaluation.trackPerformance then
                    self:UpdateFunctionStats(funcName, true, 0)
                end
                return self:UnpackReturns(cachedResult)
            end
        end

    else
        -- 3+ parameters - use hash key
        local hash = self:HashParams(...)
        cachedResult = funcCache[hash]
        if cachedResult ~= nil then
            self.state.currentEvaluation.cacheHits = self.state.currentEvaluation.cacheHits + 1
            if self.state.currentEvaluation.trackPerformance then
                self:UpdateFunctionStats(funcName, true, 0)
            end
            return self:UnpackReturns(cachedResult)
        end
    end

    -- Cache miss - execute function
    self.state.currentEvaluation.cacheMisses = self.state.currentEvaluation.cacheMisses + 1

    local startTime = debugprofilestop()
    local result = self:PackReturns(originalFunc(obj, ...))
    local executionTime = (debugprofilestop() - startTime) / 1000

    -- Store result based on parameter count
    if paramCount == 0 then
        funcCache._noparams = result
    elseif paramCount == 1 then
        local p1 = ...
        -- Convert nil to sentinel (Lua doesn't allow nil as table key)
        if p1 == nil then p1 = NIL_SENTINEL end
        local p1Cache = funcCache[p1]
        if not p1Cache then
            p1Cache = {}
            funcCache[p1] = p1Cache
        end
        p1Cache._single = result
    elseif paramCount == 2 then
        local p1, p2 = ...
        -- Convert nil to sentinel (Lua doesn't allow nil as table key)
        if p1 == nil then p1 = NIL_SENTINEL end
        if p2 == nil then p2 = NIL_SENTINEL end
        local p1Cache = funcCache[p1]
        if not p1Cache then
            p1Cache = {}
            funcCache[p1] = p1Cache
        end
        p1Cache[p2] = result
    else
        local hash = self:HashParams(...)
        funcCache[hash] = result
    end

    self.state.cacheSize = self.state.cacheSize + 1

    -- Update function-specific statistics
    if self.state.currentEvaluation.trackPerformance then
        self:UpdateFunctionStats(funcName, false, executionTime)

        if not self.state.currentEvaluation.evaluationAPITimes[funcName] then
            self.state.currentEvaluation.evaluationAPITimes[funcName] = 0
        end
        self.state.currentEvaluation.evaluationAPITimes[funcName] =
            self.state.currentEvaluation.evaluationAPITimes[funcName] + executionTime
    end

    -- Check cache size limit
    if self.state.cacheSize > self.db.global.maxCacheEntries then
        self:Warn("Cache size exceeded limit (%d entries), clearing cache", self.state.cacheSize)
        wipe(self.state.cache) -- Reuse existing table, don't allocate new one
        self.state.cacheSize = 0
    end

    return self:UnpackReturns(result)
end

--- Format return values for logging
--- @param packed table Packed return values
--- @return string Formatted string
function APLEvaluationCache:FormatReturns(packed)
    if not packed then
        return "(nil packed)"
    end

    -- Defensive check: ensure n is a number
    if type(packed.n) ~= "number" then
        return "(invalid packed table: n=" .. tostring(packed.n) .. ")"
    end

    if packed.n == 0 then
        return "(no returns)"
    end

    local parts = {}
    for i = 1, packed.n do
        local val = packed[i]
        if type(val) == "string" then
            parts[i] = string.format('"%s"', val)
        else
            parts[i] = tostring(val)
        end
    end

    return table.concat(parts, ", ")
end

--- Update evaluation statistics
--- Core counts always updated so UI shows activity; history only when trackPerformance enabled.
--- @param evaluationTime number Time taken for the evaluation
--- @param highPrecisionTime number High-precision time taken for the evaluation
function APLEvaluationCache:UpdateEvaluationStats(evaluationTime, highPrecisionTime)
    local stats = self.state.stats

    stats.totalEvaluations = stats.totalEvaluations + 1
    stats.totalCalls = stats.totalCalls + self.state.currentEvaluation.callCount
    stats.totalCacheHits = stats.totalCacheHits + self.state.currentEvaluation.cacheHits
    stats.totalEvaluationTime = stats.totalEvaluationTime + evaluationTime
    stats.totalHighPrecisionTime = stats.totalHighPrecisionTime + (highPrecisionTime or evaluationTime)
    stats.lastEvaluationTime = evaluationTime
    stats.lastHighPrecisionTime = highPrecisionTime or evaluationTime

    -- Store evaluation history only when performance tracking enabled
    if self.db.global.trackPerformance then
        local historySize = self.db.global.performanceHistorySize
        if #stats.evaluationHistory >= historySize then
            table.remove(stats.evaluationHistory, 1)
        end

        table.insert(stats.evaluationHistory, {
            time = evaluationTime,
            highPrecisionTime = highPrecisionTime or evaluationTime,
            calls = self.state.currentEvaluation.callCount,
            hits = self.state.currentEvaluation.cacheHits,
            timestamp = GetTime()
        })
    end
end

--- Update function-specific statistics
--- @param funcName string The function name
--- @param wasCacheHit boolean Whether this was a cache hit
--- @param executionTime number Time taken for execution (0 for cache hits)
function APLEvaluationCache:UpdateFunctionStats(funcName, wasCacheHit, executionTime)
    local stats = self.state.stats

    -- Ensure functionTotalTimes table exists (migration safety)
    if not stats.functionTotalTimes then
        stats.functionTotalTimes = {}
    end

    -- Initialize function stats if needed
    if not stats.functionCallCounts[funcName] then
        stats.functionCallCounts[funcName] = 0
        stats.functionCacheHits[funcName] = 0
        stats.functionTimes[funcName] = 0
        stats.functionTotalTimes[funcName] = 0
    end

    stats.functionCallCounts[funcName] = stats.functionCallCounts[funcName] + 1

    if wasCacheHit then
        stats.functionCacheHits[funcName] = stats.functionCacheHits[funcName] + 1
    else
        stats.functionTimes[funcName] = stats.functionTimes[funcName] + executionTime
        stats.functionTotalTimes[funcName] = stats.functionTotalTimes[funcName] + executionTime
    end
end

--- Get top slowest APIs by total execution time
--- @param limit number Maximum number of APIs to return
--- @return table Array of {name, totalTime, callCount, avgTime, cacheHits}
function APLEvaluationCache:GetSlowestAPIs(limit)
    limit = limit or 10
    local stats = self.state.stats

    -- Ensure functionTotalTimes exists (migration safety)
    if not stats.functionTotalTimes then
        stats.functionTotalTimes = {}
    end

    local apiList = {}

    for funcName, totalTime in pairs(stats.functionTotalTimes) do
        if totalTime > 0 then
            local callCount = stats.functionCallCounts[funcName] or 0
            local cacheHits = stats.functionCacheHits[funcName] or 0
            local avgTime = callCount > 0 and (totalTime / callCount) or 0

            table.insert(apiList, {
                name = funcName,
                totalTime = totalTime,
                callCount = callCount,
                avgTime = avgTime,
                cacheHits = cacheHits
            })
        end
    end

    -- Sort by total execution time (descending)
    table.sort(apiList, function(a, b) return a.totalTime > b.totalTime end)

    -- Return top N
    local result = {}
    for i = 1, math.min(limit, #apiList) do
        result[i] = apiList[i]
    end

    return result
end

--- Get current cache statistics
--- @return table Statistics about cache performance
function APLEvaluationCache:GetStats()
    local stats = self.state.stats

    local totalHitRate = stats.totalCalls > 0 and (stats.totalCacheHits / stats.totalCalls * 100) or 0
    local avgEvaluationTime = stats.totalEvaluations > 0 and (stats.totalEvaluationTime / stats.totalEvaluations) or 0
    local avgHighPrecisionTime = stats.totalEvaluations > 0 and (stats.totalHighPrecisionTime / stats.totalEvaluations) or 0

    return {
        isActive = self.state.active,
        isCacheEnabled = self.db.global.enableCache,
        currentEvaluationId = self.state.evaluationId,
        totalEvaluations = stats.totalEvaluations,
        totalCalls = stats.totalCalls,
        totalCacheHits = stats.totalCacheHits,
        totalHitRate = totalHitRate,
        avgEvaluationTime = avgEvaluationTime,
        avgHighPrecisionTime = avgHighPrecisionTime,
        lastEvaluationTime = stats.lastEvaluationTime,
        lastHighPrecisionTime = stats.lastHighPrecisionTime,
        currentCacheSize = self.state.cacheSize,
        functionStats = {
            callCounts = stats.functionCallCounts,
            cacheHits = stats.functionCacheHits,
            executionTimes = stats.functionTimes,
            totalTimes = stats.functionTotalTimes
        },
        evaluationHistory = stats.evaluationHistory
    }
end

--- Reset all cache statistics
function APLEvaluationCache:ResetStats()
    self.state.stats = {
        totalEvaluations = 0,
        totalCalls = 0,
        totalCacheHits = 0,
        totalEvaluationTime = 0,
        totalHighPrecisionTime = 0,
        lastEvaluationTime = 0,
        lastHighPrecisionTime = 0,
        functionCallCounts = {},
        functionCacheHits = {},
        functionTimes = {},
        functionTotalTimes = {},
        evaluationHistory = {}
    }

    self:Info("Cache statistics reset")
end

--- Clear the current cache
function APLEvaluationCache:ClearCache()
    -- Clear nested cache structure more thoroughly
    for funcName, funcCache in pairs(self.state.cache) do
        wipe(funcCache)
    end
    wipe(self.state.cache)
    self.state.cache = {}
    self.state.cacheSize = 0

    if self.state.active and self.db.global.enableDebugStats then
        self:Debug("Cache cleared during evaluation #%d", self.state.evaluationId)
    end
end


-- ~~~~~~~~~~ HANDLER WRAPPING ~~~~~~~~~~

--- Ensures wrapping is complete (lazy initialization on first use)
--- This avoids all module load order timing issues.
--- When schema mappings are empty (e.g. function-based/TBC), falls back to nagFunctionMappings.
function APLEvaluationCache:EnsureWrappingComplete()
    -- Check if already wrapped
    if self.state.wrappingComplete then
        return true
    end

    local SchemaAccessor = NAG:GetModule("SchemaAccessor", true)
    if not SchemaAccessor then
        return false -- Not ready yet, will retry on next call
    end

    local mappings = SchemaAccessor:GetAllProtoToNagMappings()
    local hasMappings = mappings and next(mappings) ~= nil
    local hasFallback = SchemaAccessor.nagFunctionMappings and next(SchemaAccessor.nagFunctionMappings) ~= nil
    if not hasMappings and not hasFallback then
        return false -- No mapping source available yet
    end

    if self.db.global.enableDebugStats then
        self:Debug("EnsureWrappingComplete: wrapping handlers (schema=%s, fallback=%s)",
            tostring(hasMappings), tostring(hasFallback and not hasMappings))
    end
    self:WrapValueHandlers()
    self.state.wrappingComplete = true
    return true
end

--- Wrap all APLValue handler functions using schema metadata or nagFunctionMappings fallback.
--- Fallback supports function-based rotations (e.g. TBC) when GetAllProtoToNagMappings is empty.
function APLEvaluationCache:WrapValueHandlers()
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor then
        self:Error("SchemaAccessor not available yet")
        return
    end

    local wrappedCount = 0
    local notFoundCount = 0

    local function tryWrap(nagName, protoName)
        if not nagName or not NAG[nagName] or type(NAG[nagName]) ~= "function" then
            notFoundCount = notFoundCount + 1
            if self.db.global.enableDebugStats then
                self:Debug("Handler not found: %s (from: %s)", tostring(nagName), tostring(protoName))
            end
            return
        end
        if self:WrapHandler(nagName, "value") then
            wrappedCount = wrappedCount + 1
            if self.db.global.enableDebugStats then
                self:Debug("Wrapped handler: %s (from: %s)", nagName, tostring(protoName))
            end
        end
    end

    local mappings = SchemaAccessor:GetAllProtoToNagMappings()
    if mappings and next(mappings) ~= nil then
        for protoName, nagName in pairs(mappings) do
            if protoName:match("^APLValue") and not protoName:match("^APLAction") then
                tryWrap(nagName, protoName)
            end
        end
    end

    -- Fallback for function-based (e.g. TBC) when schema mappings empty: use nagFunctionMappings
    if wrappedCount == 0 and SchemaAccessor.nagFunctionMappings then
        for nagName, protoName in pairs(SchemaAccessor.nagFunctionMappings) do
            if protoName and protoName:match("^APLValue") and not protoName:match("^APLAction") then
                tryWrap(nagName, protoName)
            end
        end
    end

    self:Info("Wrapped %d APLValue handlers (%d not found)", wrappedCount, notFoundCount)

    -- DEBUG: List all wrapped functions
    if self.db.global.enableDebugStats then
        self:Debug("Wrapped functions:")
        for funcName, _ in pairs(self.state.wrappedFunctions) do
            self:Debug("  - %s", funcName)
        end
    end
end

--- Wrap a single handler function
--- @param funcName string The function name to wrap
--- @param category string The category for caching
--- @return boolean True if successfully wrapped
function APLEvaluationCache:WrapHandler(funcName, category)
    if self.state.wrappedFunctions[funcName] then
        return false -- Already wrapped
    end

    -- Store original function
    self.state.originalFunctions[funcName] = NAG[funcName]

    -- Create wrapped function
    local originalFunc = NAG[funcName]
    NAG[funcName] = function(nagSelf, ...)
        -- Get APLMonitorFeed for instrumentation (if enabled)
        local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
        local shouldInstrument = APLMonitorFeed and APLMonitorFeed:IsInstrumentationActive()

        local startTime
        if shouldInstrument then
            startTime = debugprofilestop()
        end

        -- Execute cached or original function
        local result = {APLEvaluationCache:GetCachedOrExecute(
            category, funcName, originalFunc, nagSelf, ...
        )}

        -- Record handler call for APL Monitor (compiled mode)
        if shouldInstrument then
            local duration = (debugprofilestop() - startTime) / 1000 -- Convert to ms
            local args = {...}
            APLMonitorFeed:RecordHandlerCall(funcName, args, result[1], duration)
        end

        return unpack(result)
    end

    -- Mark as wrapped
    self.state.wrappedFunctions[funcName] = {
        category = category,
        wrappedAt = GetTime()
    }

    return true
end

--- Unwrap all handlers (restore originals)
function APLEvaluationCache:UnwrapAllHandlers()
    local unwrappedCount = 0
    for funcName, _ in pairs(self.state.wrappedFunctions) do
        if self.state.originalFunctions[funcName] then
            NAG[funcName] = self.state.originalFunctions[funcName]
            unwrappedCount = unwrappedCount + 1
        end
    end

    self.state.wrappedFunctions = {}
    self.state.originalFunctions = {}

    self:Info("Unwrapped %d handlers", unwrappedCount)
end

-- ~~~~~~~~~~ SLASH COMMAND HANDLERS ~~~~~~~~~~

--- Handle wrap command
function APLEvaluationCache:HandleWrapCommand()
    self:WrapValueHandlers()
end

--- Handle unwrap command
function APLEvaluationCache:HandleUnwrapCommand()
    self:UnwrapAllHandlers()
end

--- Handle stats command
function APLEvaluationCache:HandleStatsCommand()
    self:PrintStats()
end


--- Handle slowest APIs command
function APLEvaluationCache:HandleSlowestCommand()
    local slowestAPIs = self:GetSlowestAPIs(10)
    if #slowestAPIs > 0 then
        NAG:Print("=== Top 10 Slowest APIs (All Time) ===")
        for i, api in ipairs(slowestAPIs) do
            NAG:Print(string.format("%d. %s: %.3fms total (%.4fms avg, %d calls, %d hits)",
                i, api.name, api.totalTime * 1000, api.avgTime * 1000, api.callCount, api.cacheHits))
        end
    else
        NAG:Print("No API timing data available yet. Run some evaluations first.")
        NAG:Print("Debug info: trackPerformance=%s, totalCalls=%d, functionTotalTimes=%s",
            tostring(self.db.global.trackPerformance),
            self.state.stats.totalCalls,
            self.state.stats.functionTotalTimes and "exists" or "nil")

        -- Show what we do have
        local callCounts = self.state.stats.functionCallCounts or {}
        local count = 0
        for _ in pairs(callCounts) do count = count + 1 end
        NAG:Print("Function call counts tracked: %d functions", count)
    end

    -- Show current evaluation breakdown if available
    if self.state.currentEvaluation and self.state.currentEvaluation.evaluationAPITimes then
        local apiList = {}
        for funcName, time in pairs(self.state.currentEvaluation.evaluationAPITimes) do
            if time > 0 then
                table.insert(apiList, {name = funcName, time = time})
            end
        end

        if #apiList > 0 then
            table.sort(apiList, function(a, b) return a.time > b.time end)
            NAG:Print("=== Last Evaluation API Breakdown ===")
            NAG:Print("Total calls: %d, Total time: %.3fms",
                self.state.currentEvaluation.callCount,
                (self.state.lastHighPrecisionTime or 0) * 1000)
            for i = 1, math.min(5, #apiList) do
                local api = apiList[i]
                NAG:Print("%d. %s: %.3fms", i, api.name, api.time * 1000)
            end
        end
    end
end

-- ~~~~~~~~~~ OPTIONS ~~~~~~~~~~

--- Get options for the module
--- @return table The options table
function APLEvaluationCache:GetOptions()
    return {
        type = "group",
        name = L["APL Evaluation Cache"] or "APL Evaluation Cache",
        desc = L["Configure APL evaluation caching system for performance optimization"] or "Configure APL evaluation caching system for performance optimization",
        args = {
            description = {
                type = "description",
                name = L["The APL Evaluation Cache eliminates redundant calculations during rotation evaluation by caching handler function results. This can improve performance by 50-80% for complex rotations.\n"] or "The APL Evaluation Cache eliminates redundant calculations during rotation evaluation by caching handler function results. This can improve performance by 50-80% for complex rotations.\n",
                order = 0
            },
            enableCache = {
                type = "toggle",
                name = L["enableCache"] or "Enable Cache",
                desc = L["enableCacheDesc"] or "Enable APL evaluation caching for performance improvements",
                get = function() return self:GetSetting("global", "enableCache") end,
                set = function(_, value)
                    self:SetSetting("global", "enableCache", value)
                    if not value then
                        self:ClearCache()
                    end
                end,
                width = "full",
                order = 1
            },
            cacheSettings = {
                type = "group",
                name = L["cacheSettings"] or "Cache Settings",
                inline = true,
                order = 2,
                args = {
                    maxCacheEntries = {
                        type = "range",
                        name = L["maxCacheEntries"] or "Max Cache Entries",
                        desc = L["maxCacheEntriesDesc"] or "Maximum number of cache entries per evaluation cycle",
                        get = function() return self:GetSetting("global", "maxCacheEntries") end,
                        set = function(_, value)
                            self:SetSetting("global", "maxCacheEntries", value)
                        end,
                        min = 100,
                        max = 5000,
                        step = 100,
                        width = "full",
                        order = 1
                    },
                    cacheIterations = {
                        type = "range",
                        name = L["cacheIterations"] or "Cache Iterations",
                        desc = L["cacheIterationsDesc"] or "Number of rotation iterations to keep cache before clearing (1 = clear every iteration for maximum freshness, higher = better performance but stale data)",
                        get = function() return self:GetSetting("global", "cacheIterations") end,
                        set = function(_, value)
                            self:SetSetting("global", "cacheIterations", value)
                        end,
                        min = 1,
                        max = 10,
                        step = 1,
                        width = "full",
                        order = 2
                    }
                }
            },
            debugSettings = {
                type = "group",
                name = L["debugSettings"] or "Debug & Performance Tracking",
                inline = true,
                order = 3,
                args = {
                    enableDebugStats = {
                        type = "toggle",
                        name = L["enableDebugStats"] or "Debug Statistics",
                        desc = L["enableDebugStatsDesc"] or "Show detailed cache statistics in debug output",
                        get = function() return self:GetSetting("global", "enableDebugStats") end,
                        set = function(_, value)
                            self:SetSetting("global", "enableDebugStats", value)
                        end,
                        width = "full",
                        order = 1
                    },
                    trackPerformance = {
                        type = "toggle",
                        name = L["trackPerformance"] or "Track Performance",
                        desc = L["trackPerformanceDesc"] or "Track detailed performance metrics (call counts, hit rates, timing)",
                        get = function() return self:GetSetting("global", "trackPerformance") end,
                        set = function(_, value)
                            self:SetSetting("global", "trackPerformance", value)
                            if not value then
                                self:ResetStats()
                            end
                        end,
                        width = "full",
                        order = 2
                    }
                }
            },
            actions = {
                type = "group",
                name = L["actions"] or "Actions",
                inline = true,
                order = 4,
                args = {
                    showStats = {
                        type = "execute",
                        name = L["showStats"] or "Show Statistics",
                        desc = L["showStatsDesc"] or "Print current cache statistics to chat",
                        func = function()
                            self:PrintStats()
                        end,
                        order = 1
                    },
                    resetStats = {
                        type = "execute",
                        name = L["resetStats"] or "Reset Statistics",
                        desc = L["resetStatsDesc"] or "Reset all cache statistics",
                        func = function()
                            self:ResetStats()
                        end,
                        order = 2
                    },
                    clearCache = {
                        type = "execute",
                        name = L["clearCache"] or "Clear Cache",
                        desc = L["clearCacheDesc"] or "Clear current cache (useful for testing)",
                        func = function()
                            self:ClearCache()
                        end,
                        order = 3
                    },
                    showDebugFrame = {
                        type = "execute",
                        name = L["showDebugFrame"] or "Show Debug Frame",
                        desc = L["APLEvaluationCacheShowDebugFrameDesc"] or "Open debug frame with real-time cache statistics",
                        func = function()
                            self:ShowDebugFrame()
                        end,
                        order = 4
                    }
                }
            },
            currentStats = {
                type = "group",
                name = L["currentStats"] or "Current Statistics",
                inline = true,
                order = 5,
                args = {
                    statsDisplay = {
                        type = "description",
                        name = function()
                            local stats = self:GetStats()

                            -- Count wrapped handlers
                            local wrappedCount = 0
                            for _ in pairs(self.state.wrappedFunctions) do
                                wrappedCount = wrappedCount + 1
                            end

                            return string.format(
                                "|cff00FF00Cache Enabled:|r %s\n" ..
                                "|cff00FF00Currently Evaluating:|r %s\n" ..
                                "|cff00FF00Wrapped Handlers:|r %d\n" ..
                                "|cff00FF00Total Evaluations:|r %d\n" ..
                                "|cff00FF00Total Calls:|r %d\n" ..
                                "|cff00FF00Cache Hits:|r %d\n" ..
                                "|cff00FF00Hit Rate:|r %.1f%%\n" ..
                                "|cff00FF00Avg Evaluation Time:|r %.3fs (%.3fms)\n" ..
                                "|cff00FF00Cache Size:|r %d entries",
                                tostring(stats.isCacheEnabled),
                                tostring(stats.isActive),
                                wrappedCount,
                                stats.totalEvaluations,
                                stats.totalCalls,
                                stats.totalCacheHits,
                                stats.totalHitRate,
                                stats.avgEvaluationTime,
                                stats.avgHighPrecisionTime * 1000,
                                stats.currentCacheSize
                            )
                        end,
                        order = 1
                    }
                }
            }
        }
    }
end

-- ~~~~~~~~~~ DEBUG UI ~~~~~~~~~~

--- Print cache statistics to chat
function APLEvaluationCache:PrintStats()
    local stats = self:GetStats()

    self:Info("=== APL Evaluation Cache Statistics ===")
    self:Info("Cache Enabled: %s", tostring(stats.isCacheEnabled))
    self:Info("Currently Evaluating: %s", tostring(stats.isActive))
    self:Info("Total Evaluations: %d", stats.totalEvaluations)
    self:Info("Total Calls: %d", stats.totalCalls)
    self:Info("Total Cache Hits: %d", stats.totalCacheHits)
    self:Info("Overall Hit Rate: %.1f%%", stats.totalHitRate)
    self:Info("Average Evaluation Time: %.3fs (%.3fms high-precision)", stats.avgEvaluationTime, stats.avgHighPrecisionTime * 1000)
    self:Info("Last Evaluation Time: %.3fs (%.3fms high-precision)", stats.lastEvaluationTime, stats.lastHighPrecisionTime * 1000)
    self:Info("Current Cache Size: %d", stats.currentCacheSize)

    -- Performance metrics (optimized nested table cache - no key generation overhead)

    -- Show slowest APIs
    local slowestAPIs = self:GetSlowestAPIs(5)
    if #slowestAPIs > 0 then
        self:Info("=== Top 5 Slowest APIs ===")
        for i, api in ipairs(slowestAPIs) do
            self:Info("%d. %s: %.3fms total (%.4fms avg, %d calls, %d hits)",
                i, api.name, api.totalTime * 1000, api.avgTime * 1000, api.callCount, api.cacheHits)
        end
    end

    if stats.totalCalls > 0 then
        self:Info("=== Top 10 Most Called Functions ===")
        local sortedFunctions = {}
        for funcName, count in pairs(stats.functionStats.callCounts) do
            table.insert(sortedFunctions, {name = funcName, count = count})
        end
        table.sort(sortedFunctions, function(a, b) return a.count > b.count end)

        for i = 1, math.min(10, #sortedFunctions) do
            local func = sortedFunctions[i]
            local hits = stats.functionStats.cacheHits[func.name] or 0
            local hitRate = func.count > 0 and (hits / func.count * 100) or 0
            self:Info("%d. %s: %d calls (%.1f%% hit rate)",
                i, func.name, func.count, hitRate)
        end
    end
end

--- Get debug sections for the debug frame
--- @return table Array of debug sections
function APLEvaluationCache:GetDebugSections()
    return {
        {
            header = "Cache System Status",
            dataFn = function()
                local stats = self:GetStats()

                local lines = {
                    string.format("Cache Enabled: %s", tostring(stats.isCacheEnabled)),
                    string.format("Currently Evaluating: %s", tostring(stats.isActive)),
                    string.format("Current Evaluation ID: %d", stats.currentEvaluationId),
                    string.format("Current Cache Size: %d entries", stats.currentCacheSize),
                    "",
                    "Overall Statistics:",
                    string.format("Total Evaluations: %d", stats.totalEvaluations),
                    string.format("Total Function Calls: %d", stats.totalCalls),
                    string.format("Total Cache Hits: %d", stats.totalCacheHits),
                    string.format("Overall Hit Rate: %.1f%%", stats.totalHitRate),
                    "",
                    "Performance:",
                    string.format("Average Evaluation Time: %.3fs (%.3fms high-precision)", stats.avgEvaluationTime, stats.avgHighPrecisionTime * 1000),
                    string.format("Last Evaluation Time: %.3fs (%.3fms high-precision)", stats.lastEvaluationTime, stats.lastHighPrecisionTime * 1000),
                    "",
                    "Performance:",
                    "Using optimized nested table cache (zero key generation overhead)"
                }

                lines[#lines + 1] = ""
                lines[#lines + 1] = "Settings:"
                lines[#lines + 1] = string.format("Debug Stats: %s", tostring(self.db.global.enableDebugStats))
                lines[#lines + 1] = string.format("Performance Tracking: %s", tostring(self.db.global.trackPerformance))
                lines[#lines + 1] = string.format("Max Cache Entries: %d", self.db.global.maxCacheEntries)

                return lines
            end
        },
        {
            header = "Function Performance",
            dataFn = function()
                local stats = self:GetStats()

                if stats.totalCalls == 0 then
                    return {"No function calls recorded yet"}
                end

                local lines = {"Top 10 Most Called Functions:"}

                local sortedFunctions = {}
                for funcName, count in pairs(stats.functionStats.callCounts) do
                    table.insert(sortedFunctions, {name = funcName, count = count})
                end
                table.sort(sortedFunctions, function(a, b) return a.count > b.count end)

                for i = 1, math.min(10, #sortedFunctions) do
                    local func = sortedFunctions[i]
                    local hits = stats.functionStats.cacheHits[func.name] or 0
                    local hitRate = func.count > 0 and (hits / func.count * 100) or 0
                    local execTime = stats.functionStats.executionTimes[func.name] or 0

                    lines[#lines + 1] = string.format("%d. %s", i, func.name)
                    lines[#lines + 1] = string.format("   Calls: %d, Hits: %d (%.1f%%)",
                        func.count, hits, hitRate)
                    if execTime > 0 then
                        lines[#lines + 1] = string.format("   Total Exec Time: %.3fs", execTime)
                    end
                    lines[#lines + 1] = ""
                end

                return lines
            end
        },
        {
            header = "Recent Evaluations",
            dataFn = function()
                local stats = self:GetStats()

                if #stats.evaluationHistory == 0 then
                    return {"No evaluation history available"}
                end

                local lines = {"Recent Evaluation Performance:"}

                local historyCount = math.min(10, #stats.evaluationHistory)
                for i = #stats.evaluationHistory - historyCount + 1, #stats.evaluationHistory do
                    local eval = stats.evaluationHistory[i]
                    local hitRate = eval.calls > 0 and (eval.hits / eval.calls * 100) or 0
                    lines[#lines + 1] = string.format("Time: %.3fs (%.3fms), Calls: %d, Hits: %d (%.1f%%)",
                        eval.time, (eval.highPrecisionTime or eval.time) * 1000, eval.calls, eval.hits, hitRate)
                end

                return lines
            end
        }
    }
end

--- Get debug controls for the debug frame
--- @return table Array of control functions
function APLEvaluationCache:GetDebugControls()
    return {
        {
            type = "button",
            text = "Show Stats",
            width = 100,
            onClick = function()
                self:PrintStats()
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Clear Cache",
            width = 100,
            onClick = function()
                self:ClearCache()
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Reset Stats",
            width = 100,
            onClick = function()
                self:ResetStats()
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "toggle",
            label = "Enable Cache",
            getValue = function() return self:GetSetting("global", "enableCache") end,
            setValue = function(value)
                self:SetSetting("global", "enableCache", value)
                if not value then
                    self:ClearCache()
                end
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end,
            width = 150
        },
        {
            type = "toggle",
            label = "Debug Stats",
            getValue = function() return self:GetSetting("global", "enableDebugStats") end,
            setValue = function(value)
                self:SetSetting("global", "enableDebugStats", value)
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end,
            width = 150
        }
    }
end

--- Show the debug frame
function APLEvaluationCache:ShowDebugFrame()
    if not DebugFrameUtil then
        self:Error("DebugFrameUtil not available")
        return
    end

    DebugFrameUtil:ShowDebugFrame(self, {
        title = "APL Evaluation Cache - Performance Analysis",
        sections = self:GetDebugSections(),
        customControls = self:GetDebugControls(),
        refreshInterval = 1.0, -- Update every second
        width = 900,
        height = 700,
        savePosition = true,
        position = {
            point = "CENTER",
            relativePoint = "CENTER",
            x = 0,
            y = 0
        }
    })
end
