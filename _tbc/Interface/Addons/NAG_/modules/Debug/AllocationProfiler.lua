--- @module "AllocationProfiler"
--- Detailed allocation profiling using luac memory snapshots
--- License: CC BY-NC 4.0

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local AllocationProfiler = {}
ns.AllocationProfiler = AllocationProfiler

local format = string.format
local collectgarbage = collectgarbage
local GetTime = _G.GetTime
local wipe = wipe

local hookState = {
    installed = false,
    originals = setmetatable({}, {__mode = "k"}),
    hookedCount = 0,
}

-- ============================ TABLE POOL ============================
-- Table pool for reusing result tables in wrapped functions
-- This eliminates allocations from the profiler wrapper itself
local tablePool = {
    pool = {},
    poolSize = 0,
    maxPoolSize = 50,  -- Maximum tables to keep in pool
    totalAllocated = 0,
    totalReused = 0,
}

--- Get a table from the pool (or create a new one if pool is empty)
--- @return table A cleared table ready for use
local function GetPooledTable()
    local tbl = tablePool.pool[tablePool.poolSize]
    if tbl then
        tablePool.pool[tablePool.poolSize] = nil
        tablePool.poolSize = tablePool.poolSize - 1
        tablePool.totalReused = tablePool.totalReused + 1
        wipe(tbl)  -- Clear any previous data
        return tbl
    else
        tablePool.totalAllocated = tablePool.totalAllocated + 1
        return {}
    end
end

--- Return a table to the pool for reuse
--- @param tbl table The table to return to the pool
local function ReturnPooledTable(tbl)
    if not tbl then return end

    -- Limit pool size to prevent unbounded growth
    if tablePool.poolSize < tablePool.maxPoolSize then
        wipe(tbl)  -- Clear the table before returning
        tablePool.poolSize = tablePool.poolSize + 1
        tablePool.pool[tablePool.poolSize] = tbl
    end
end

--- Profiling state
local profiling = {
    enabled = false,
    functionStats = {},
    totalSamples = 0,
}

local function recordOriginal(obj, funcName, original)
    local objOriginals = hookState.originals[obj]
    if not objOriginals then
        objOriginals = {}
        hookState.originals[obj] = objOriginals
    end

    if not objOriginals[funcName] then
        objOriginals[funcName] = original
        hookState.hookedCount = hookState.hookedCount + 1
    end
end

local function restoreOriginals()
    for obj, objOriginals in pairs(hookState.originals) do
        for funcName, original in pairs(objOriginals) do
            obj[funcName] = original
        end
    end

    hookState.originals = setmetatable({}, {__mode = "k"})
    hookState.hookedCount = 0
    hookState.installed = false
end

--- Track function call and memory allocation
--- @param funcName string Function name
--- @param alloc number Memory allocated (KB)
local function TrackAllocation(funcName, alloc)
    if not profiling.enabled then return end

    local stats = profiling.functionStats[funcName]
    if not stats then
        stats = {
            calls = 0,
            totalAlloc = 0,
            maxAlloc = 0,
            minAlloc = math.huge,
        }
        profiling.functionStats[funcName] = stats
    end

    stats.calls = stats.calls + 1
    stats.totalAlloc = stats.totalAlloc + alloc
    stats.maxAlloc = math.max(stats.maxAlloc, alloc)
    stats.minAlloc = math.min(stats.minAlloc, alloc)
end

--- Wrap a function to track its allocations
--- @param obj table Object containing the function
--- @param funcName string Function name
--- @return function|nil Wrapped function or nil if function not found
local function WrapFunction(obj, funcName)
    local original = obj[funcName]
    if not original then
        print("|cffff0000Cannot wrap " .. funcName .. " - not found|r")
        return nil
    end

    return function(...)
        if not profiling.enabled then
            return original(...)
        end

        -- Measure memory before call
        local memBefore = collectgarbage("count")

        -- Call original function and capture all return values
        -- Note: {original(...)} creates a new table - this is unavoidable in Lua
        -- when capturing multiple return values. We'll reuse this table via the pool.
        local result = {original(...)}
        local retCount = #result

        -- Measure memory after call
        local memAfter = collectgarbage("count")

        local alloc = memAfter - memBefore
        if alloc > -10 then  -- Filter small GC
            TrackAllocation(funcName, alloc)
        end

        -- Extract return values before returning table to pool
        -- For common cases (0-5 returns), extract directly for efficiency
        local ret1, ret2, ret3, ret4, ret5
        if retCount > 0 then
            ret1 = result[1]
            if retCount > 1 then
                ret2 = result[2]
                if retCount > 2 then
                    ret3 = result[3]
                    if retCount > 3 then
                        ret4 = result[4]
                        if retCount > 4 then
                            ret5 = result[5]
                        end
                    end
                end
            end
        end

        -- For 6+ returns, extract all values before returning table to pool
        local manyValues
        if retCount > 5 then
            manyValues = {}
            for i = 1, retCount do
                manyValues[i] = result[i]
            end
        end

        -- Return table to pool for reuse (must do this before returning values)
        ReturnPooledTable(result)

        -- Return all captured values
        if retCount == 0 then
            return
        elseif retCount == 1 then
            return ret1
        elseif retCount == 2 then
            return ret1, ret2
        elseif retCount == 3 then
            return ret1, ret2, ret3
        elseif retCount == 4 then
            return ret1, ret2, ret3, ret4
        elseif retCount == 5 then
            return ret1, ret2, ret3, ret4, ret5
        else
            -- For 6+ returns, unpack from extracted values
            return unpack(manyValues)
        end
    end
end

-- ============================ HOOK MANAGEMENT ============================

--- Install hooks for all functions on NAG object
--- This hooks ALL functions defined on NAG, not just schema functions
function AllocationProfiler.InstallHooks()
    if hookState.installed then
        print("|cffff8000Allocation profiling hooks already installed|r")
        return hookState.hookedCount
    end

    print("|cff00ff00Installing allocation profiling hooks for all NAG functions...|r")

    hookState.hookedCount = 0

    -- Hook ALL functions on NAG object (not just schema functions)
    -- This includes schema functions, helper functions, aliases, and class-specific functions
    for funcName, func in pairs(NAG) do
        -- Only hook functions (not tables, strings, numbers, etc.)
        if type(func) == "function" then
            -- Skip internal/private functions that start with underscore
            if not funcName:match("^_") then
                recordOriginal(NAG, funcName, func)
                NAG[funcName] = WrapFunction(NAG, funcName)
            end
        end
    end

    -- Hook module-specific functions
    local TTDManager = NAG:GetModule("TTDManager", true)
    if TTDManager and TTDManager.GetTTD then
        recordOriginal(TTDManager, "GetTTD", TTDManager.GetTTD)
        TTDManager.GetTTD = WrapFunction(TTDManager, "GetTTD")
    end

    hookState.installed = true

    print(format("|cff00ff00Allocation profiling hooks installed: %d functions hooked|r", hookState.hookedCount))

    return hookState.hookedCount
end

function AllocationProfiler.UninstallHooks()
    if not hookState.installed then
        print("|cffff8000Allocation profiling hooks are not installed|r")
        return
    end

    restoreOriginals()
    print("|cff00ff00Allocation profiling hooks removed|r")
end

-- ============================ PROFILING CONTROL ============================

--- Start profiling
function AllocationProfiler.Start()
    AllocationProfiler.InstallHooks()

    profiling.enabled = true
    profiling.functionStats = {}
    profiling.totalSamples = 0

    print("|cff00ff00Allocation profiler started|r")
    print("|cff808080Profiling individual function allocations...|r")
end

--- Stop profiling
function AllocationProfiler.Stop()
    profiling.enabled = false
    AllocationProfiler.UninstallHooks()
    print("|cff00ff00Allocation profiler stopped|r")
end

--- Print report
function AllocationProfiler.Report()
    if profiling.totalSamples == 0 and next(profiling.functionStats) == nil then
        print("|cffff0000No profiling data. Use '/nagalloc start' first.|r")
        return
    end

    print("|cffff8000=== ALLOCATION PROFILE BY FUNCTION ===|r")
    print("")

    -- Sort by total allocation
    local sorted = {}
    for funcName, stats in pairs(profiling.functionStats) do
        table.insert(sorted, {name = funcName, stats = stats})
    end
    table.sort(sorted, function(a, b) return a.stats.totalAlloc > b.stats.totalAlloc end)

    -- Show top 20 functions
    print(format("%-30s %10s %12s %10s %10s",
        "Function", "Calls", "Total KB", "Avg KB", "Max KB"))
    print(string.rep("-", 80))

    for i = 1, math.min(30, #sorted) do
        local entry = sorted[i]
        local stats = entry.stats

        -- Color code
        local color = "|cffffffff"
        if stats.totalAlloc > 1000 then
            color = "|cffff0000"  -- Red
        elseif stats.totalAlloc > 500 then
            color = "|cffff8000"  -- Orange
        elseif stats.totalAlloc > 100 then
            color = "|cffffff00"  -- Yellow
        end

        print(format("%s%-30s %10d %12.2f %10.3f %10.3f|r",
            color,
            entry.name,
            stats.calls,
            stats.totalAlloc,
            stats.totalAlloc / stats.calls,
            stats.maxAlloc))
    end

    print("")
    print("|cffff8000Summary:|r")

    local totalCalls = 0
    local totalAlloc = 0
    for _, entry in ipairs(sorted) do
        totalCalls = totalCalls + entry.stats.calls
        totalAlloc = totalAlloc + entry.stats.totalAlloc
    end

    print(format("  Total function calls: %d", totalCalls))
    print(format("  Total allocations: %.2f KB (%.2f MB)", totalAlloc, totalAlloc / 1024))
    print(format("  Average per call: %.3f KB", totalAlloc / totalCalls))
end

--- Slash command handler
local function HandleSlashCommand(args)
    args = args and args:lower() or ""

    if args == "start" then
        AllocationProfiler.Start()
    elseif args == "stop" then
        AllocationProfiler.Stop()
        AllocationProfiler.Report()
    elseif args == "report" then
        AllocationProfiler.Report()
    elseif args == "hooks" then
        AllocationProfiler.InstallHooks()
    elseif args == "help" then
        print("|cffff8000NAG Allocation Profiler:|r")
        print("  /nagalloc hooks - Install profiling hooks")
        print("  /nagalloc start - Start profiling")
        print("  /nagalloc stop - Stop and show report")
        print("  /nagalloc report - Show current report")
        print("  /nagalloc help - Show this help")
    else
        print("|cffff0000Unknown command. Use '/nagalloc help'|r")
    end
end

-- Register slash command
SLASH_NAGALLOC1 = "/nagalloc"
SlashCmdList["NAGALLOC"] = HandleSlashCommand

return AllocationProfiler
