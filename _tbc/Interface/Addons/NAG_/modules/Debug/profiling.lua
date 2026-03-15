--- @module "NAG.ProfilingUtility"
--- Provides a module for measuring and reporting code performance in NAG.
---
--- # NAG Profiling System Documentation
---
--- ## Overview
--- The NAG profiling system enables dynamic, low-boilerplate performance measurement for all Ace3-based modules. Profiling can be toggled at runtime for individual modules or all modules, with no need to manually instrument each function.
---
--- ## How to Enable Profiling
--- - **Via Slash Command:**
---   - `/nagdebug profile <ModuleName>`: Enable profiling for a specific module
---   - `/nagdebug profile off <ModuleName>`: Disable profiling for a specific module
---   - `/nagdebug profile all`: Enable profiling for all modules
---   - `/nagdebug profile off all`: Disable profiling for all modules
--- - **Programmatically:**
---   - `MyModule:EnableProfiling()`
---   - `MyModule:DisableProfiling()`
---
--- ## How It Works
--- - All public methods of a module (excluding Ace3 and core methods) are dynamically wrapped with profiling hooks.
--- - Profiling data is collected per-method and per-module, supporting nested and concurrent calls.
--- - ProfilingUtility itself is never profiled to avoid recursion.
---
--- ## Reporting & Analysis
---
--- ## Best Practices for Module Authors
--- - Use the dynamic system (`EnableProfiling`/`DisableProfiling`) for most use cases.
--- - Only use `ProfileFunction` or `WithProfiling` for advanced/manual profiling of specific code blocks.
--- - Exclude Ace3 and core methods from profiling (handled automatically).
--- - Use profiling during development or debugging; disable in production for best performance.
--- - **Statistical Cleanup**: The system automatically handles warmup calls and outliers, but you can configure the cleanup parameters in the options.
---
--- ## Troubleshooting
--- - If you see stack overflows, ensure ProfilingUtility and Ace3 methods are excluded (handled by default).
--- - If profiling data seems missing, check that profiling is enabled for the target module.
--- - Use the report functions to identify slow or frequently-called methods.
---
--- ## Statistical Cleanup Benefits
--- - **Warmup Call Removal**: Automatically skips the first N calls that are inherently slower due to JIT compilation, first-time memory allocation, and initialization overhead.
--- - **Optional Outlier Detection**: Enable/disable IQR or percentile-based outlier detection independently of warmup removal.
--- - **Intelligent Outlier Detection**: Uses improved IQR method with adaptive thresholds that automatically adjust based on data variance.
--- - **Over-Aggressive Prevention**: Limits outlier removal to prevent removing too much data (configurable max removal percentage).
--- - **More Accurate Metrics**: Provides cleaner, more representative performance data by focusing on steady-state performance rather than initialization artifacts.
--- - **Configurable**: Adjust warmup call count, outlier detection method, thresholds, and adaptive behavior through the options panel.
---
--- ## Further Reading
--- - See in-code comments for advanced usage and API details.
--- - For test coverage, see `tests/Debug/ProfilingUtility.Tests.lua`.
---
--- ---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local L = ns.AceLocale:GetLocale("NAG", true)
local AceGUI = ns.AceGUI

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format -- WoW's optimized version if available

local strlower = strlower
local wipe = wipe


-- Enhanced error handling
local pcall = ns.pcall

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
local defaults = {
    char = {
        autoProfiling = false,
        defaultSortField = "max",
        highlightTopN = 3,
        showSummary = true,
        profiledModules = {},
        -- Statistical cleanup settings
        statisticalCleanup = {
            enabled = true,
            warmupCalls = 3,               -- Number of calls to skip for warmup
            outlierDetection = false,      -- Enable/disable outlier detection (IQR or percentile)
            outlierMethod = "iqr",         -- "iqr" or "percentile"
            outlierThreshold = 1.5,        -- IQR multiplier or percentile threshold
            minSampleSize = 10,            -- Minimum samples before outlier detection
            removeOutliers = true,         -- Whether to actually remove outliers or just flag them
            maxOutlierRemovalPercent = 30, -- Maximum percentage of data that can be removed
            adaptiveThresholds = true,     -- Automatically adjust thresholds based on data variance
        }
    }
}

---@class ProfilingUtility : CoreModule
local ProfilingUtility = NAG:CreateModule("ProfilingUtility", defaults, {
    moduleType = ns.MODULE_TYPES.DEBUG,
    hidden = function() return not NAG:IsDevModeEnabled() end,
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DEBUG
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["debug_profile"] = {
            handler = "HandleProfileSlashCommand",
            help = "Performance profiling commands. Usage: /nagdebug debug profile [start|stop|report]",
            root = "nagdebug",
            path = {"debug", "profile"},
            category = "Debug"
        }
    }
})
local module = ProfilingUtility
ns.ProfilingUtility = ProfilingUtility

-- Initialize module state
ProfilingUtility.timings = {}
ProfilingUtility.callTimestamps = {}
ProfilingUtility.profilingStack = {}

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    --- Called when the module is initialized

    --- @param self ProfilingUtility
    function ProfilingUtility:ModuleInitialize()
        self:Reset()
    end

    --- @param self ProfilingUtility
    function ProfilingUtility:ModuleEnable()
        -- Module enabled
    end

    --- @param self ProfilingUtility
    function ProfilingUtility:ModuleDisable()
        self:Cleanup()
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
do
    -- No event handlers defined for this module
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

--- Performs a complete cleanup of the profiling module
--- @param self ProfilingUtility
function ProfilingUtility:Cleanup()
    -- Check for any active profiling sessions and warn about them
    if next(self.profilingStack) then
        self:Warn("Cleaning up with active profiling sessions")
        for _, session in ipairs(self.profilingStack) do
            self:Warn(format("Unclosed profiling session: %s", session.label))
        end
    end

    -- Clear all data structures
    self:Reset()

    -- Clear any references
    self.activeSession = nil

    -- Run garbage collection to clean up any lingering references
    collectgarbage("collect")
end

--- Resets the profiling data, clearing all stored timings and call timestamps.
--- @param self ProfilingUtility
--- @usage ProfilingUtility:Reset()
function ProfilingUtility:Reset()
    -- Store the debug state before clearing
    local wasDebug = self.debug

    -- Clear all data structures
    wipe(self.timings)
    wipe(self.callTimestamps)
    wipe(self.profilingStack)

    -- Restore debug state
    self.debug = wasDebug
end

--- Starts profiling for a given label.
--- @param self ProfilingUtility
--- @param label string The label to identify the profiling session.
function ProfilingUtility:StartProfiling(label)
    if type(label) ~= "string" then
        error("StartProfiling requires a string label, got: " .. type(label))
    end

    local profilingData = {
        label = label,
        startTime = debugprofilestop()
    }
    table.insert(self.profilingStack, profilingData)

    if not self.callTimestamps[label] then
        self.callTimestamps[label] = {}
    end
    table.insert(self.callTimestamps[label], GetTime())
end

--- Enhanced stop function with error checking.
-- Stops profiling but ensures that it was started.
--- @param self ProfilingUtility
function ProfilingUtility:StopProfiling()
    local currentProfiling = table.remove(self.profilingStack)
    if not currentProfiling then
        error("StopProfiling called without matching StartProfiling")
        return
    end

    local pStop = debugprofilestop()
    local elapsed = pStop - currentProfiling.startTime

    if not self.timings[currentProfiling.label] then
        self.timings[currentProfiling.label] = { total = 0, count = 0, max = 0, min = math.huge, times = {} }
    end

    local timing = self.timings[currentProfiling.label]
    timing.total = timing.total + elapsed
    timing.count = timing.count + 1
    timing.max = math.max(timing.max, elapsed)
    timing.min = math.min(timing.min, elapsed)
    table.insert(timing.times, elapsed)
end

--- Starts cumulative timing for a label, tracking time between calls.
--- @param self ProfilingUtility
--- @param label string The label to track cumulative time for.
function ProfilingUtility:StartCumulativeTiming(label)
    if type(label) ~= "string" then
        error("StartCumulativeTiming requires a string label, got: " .. type(label))
    end

    self.callTimestamps[label] = self.callTimestamps[label] or {}
    table.insert(self.callTimestamps[label], GetTime())
end

--- Gets cumulative time between all calls for a label.
--- @param self ProfilingUtility
--- @param label string The label to calculate cumulative time for.
--- @return number Total cumulative time in seconds between all calls.
function ProfilingUtility:GetCumulativeTiming(label)
    if type(label) ~= "string" then
        error("GetCumulativeTiming requires a string label, got: " .. type(label))
    end

    local timestamps = self.callTimestamps[label]
    if not timestamps then
        error("No timing data found for label: " .. label)
        return 0
    end

    local total = 0
    for i = 2, #timestamps do
        total = total + (timestamps[i] - timestamps[i - 1])
    end
    return total
end

--- Automatically profiles the execution of a specific function.
--- @param self ProfilingUtility
--- @param func function The function to profile.
--- @param label string The label for profiling.
--- @return function A wrapped function that profiles each call.
--- @note Advanced/manual use only. For module-wide profiling, use EnableProfiling/DisableProfiling on your module instead.
function ProfilingUtility:ProfileFunction(func, label)
    if type(func) ~= "function" then
        error("ProfileFunction requires a function as first argument, got: " .. type(func))
    end
    if type(label) ~= "string" then
        error("ProfileFunction requires a string label, got: " .. type(label))
    end

    return function(...)
        local success, result
        self:StartProfiling(label)
        success, result = pcall(func, ...)
        self:StopProfiling()

        if not success then
            error("Error in profiled function: " .. tostring(result))
        end
        return unpack(result)
    end
end

--- Wraps a function with profiling if enabled in settings
--- @param self ProfilingUtility
--- @param name string The name/label to use for this profiling session
--- @param func function The function to profile
--- @return any The return value from the wrapped function
--- @note Advanced/manual use only. For module-wide profiling, use EnableProfiling/DisableProfiling on your module instead.
function ProfilingUtility:WithProfiling(name, func)
    if not self:IsEnabled() then
        return func()
    end

    self:StartProfiling(name)
    local success, result = pcall(func)
    self:StopProfiling()

    if not success then
        error(result, 2)
    end
    return result
end

--- Generates a report of the profiling data, with optional filtering and minCount.
--- @param self ProfilingUtility
--- @param opts table|nil Options: filter (string/pattern), minCount (number), useCleanup (boolean)
--- @return table A table containing the profiling report.
function ProfilingUtility:GetReport(opts)
    opts = opts or {}
    local useCleanup = opts.useCleanup ~= false -- Default to true for cleanup

    -- Use the new cleaned report system by default
    return self:GetCleanedReport({
        filter = opts.filter,
        minCount = opts.minCount,
        useCleanup = useCleanup
    })
end

--- Prints the profiling report, with advanced options for filtering, highlighting, summary, and CSV export.
--- @param self ProfilingUtility
--- @param opts string|table|nil If string, treated as sortField. If table, supports: sortField, filter, minCount, highlightTopN, summary, asCSV
function ProfilingUtility:PrintReport(opts)
    opts = opts or {}
    local sortField, filter, minCount, highlightTopN, summary, asCSV
    if type(opts) == "string" then
        if opts:match("^filter=") then
            filter = opts:match("^filter=(.*)")
        else
            sortField = opts
        end
    elseif type(opts) == "table" then
        sortField = opts.sortField
        filter = opts.filter
        minCount = opts.minCount
        highlightTopN = opts.highlightTopN or 3
        summary = opts.summary
        asCSV = opts.asCSV
    end
    if type(sortField) ~= "string" or not sortField then
        sortField = "max"
    end
    local report = self:GetReport({ filter = filter, minCount = minCount })
    if not report or #report == 0 then
        print("|cffff0000PROFILE:|cffffff00 No profiling data available|r")
        return
    end
    if report[1][sortField] == nil then
        error("Invalid sort field: " .. tostring(sortField))
    end
    table.sort(report, function(a, b)
        return a[sortField] > b[sortField]
    end)
    if asCSV then
        local csv = "Label,Average,Max,Min,StdDev,Count,CallsPerMin"
        for _, entry in ipairs(report) do
            csv = csv ..
                format("\n%s,%.4f,%.4f,%.4f,%.4f,%d,%.4f", entry.label, entry.average, entry.max, entry.min,
                    entry.standardDeviation, entry.count, entry.callsPerMinute)
        end
        print(csv)
        return
    end
    -- Highlight top N
    highlightTopN = math.min(highlightTopN or 3, #report)
    local colors = { "|cffff2222", "|cffffff00", "|cff00ff00" } -- red, yellow, green
    for i, entry in ipairs(report) do
        local color = (i <= highlightTopN) and colors[i] or "|cffffff00"
        local cleanupInfo = ""
        if entry.cleanupApplied then
            cleanupInfo = format(" (cleaned: %d→%d, -%d outliers, -%d warmup)",
                entry.originalCount, entry.count, entry.removedOutliers, entry.warmupCalls)
        end
        print(format(
            color ..
            "PROFILE: %s - Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, StdDev: %.4f ms, Count: %d, Calls/Min: %.4f%s|r",
            entry.label, entry.average, entry.max, entry.min, entry.standardDeviation, entry.count, entry.callsPerMinute,
            cleanupInfo))
    end
    if summary then
        local totalCalls, totalTime, maxVal, minVal, sumSq, count = 0, 0, 0, math.huge, 0, 0
        for _, entry in ipairs(report) do
            totalCalls = totalCalls + entry.count
            totalTime = totalTime + entry.average * entry.count
            maxVal = math.max(maxVal, entry.max)
            minVal = math.min(minVal, entry.min)
            sumSq = sumSq + (entry.standardDeviation ^ 2 * entry.count)
            count = count + entry.count
        end
        local overallAvg = totalTime / totalCalls
        local overallStd = math.sqrt(sumSq / count)
        print(format(
            "|cff00ffffPROFILE SUMMARY: Total Calls: %d, Overall Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, Overall StdDev: %.4f ms|r",
            totalCalls, overallAvg, maxVal, minVal, overallStd))
    end
end

--- Prints the profiling report with memory usage and other advanced debugging data. Accepts same options as PrintReport.
--- @param self ProfilingUtility
--- @param opts string|table|nil If string, treated as sortField. If table, supports: sortField, filter, minCount, highlightTopN, summary, asCSV
function ProfilingUtility:PrintAdvancedReport(opts)
    local sortField, filter, minCount, highlightTopN, summary, asCSV
    if type(opts) == "string" then
        if opts:match("^filter=") then
            filter = opts:match("^filter=(.*)")
        else
            sortField = opts
        end
    elseif type(opts) == "table" then
        sortField = opts.sortField
        filter = opts.filter
        minCount = opts.minCount
        highlightTopN = opts.highlightTopN or 3
        summary = opts.summary
        asCSV = opts.asCSV
    end
    if type(sortField) ~= "string" or not sortField then
        sortField = "max"
    end
    local report = self:GetReport({ filter = filter, minCount = minCount })
    if not report or #report == 0 then
        print("|cffff0000ADVANCED PROFILE:|cffffff00 No profiling data available|r")
        return
    end
    if report[1][sortField] == nil then
        error("Invalid sort field: " .. tostring(sortField))
    end
    table.sort(report, function(a, b)
        return a[sortField] > b[sortField]
    end)
    if asCSV then
        local csv = "Label,Average,Max,Min,StdDev,Count,CallsPerMin,MemUsageKB"
        for _, entry in ipairs(report) do
            local memUsage = collectgarbage("count")
            csv = csv ..
                format("\n%s,%.4f,%.4f,%.4f,%.4f,%d,%.4f,%.2f", entry.label, entry.average, entry.max, entry.min,
                    entry.standardDeviation, entry.count, entry.callsPerMinute, memUsage)
        end
        print(csv)
        return
    end
    highlightTopN = math.min(highlightTopN or 3, #report)
    local colors = { "|cffff2222", "|cffffff00", "|cff00ff00" }
    for i, entry in ipairs(report) do
        local memUsage = collectgarbage("count")
        local color = (i <= highlightTopN) and colors[i] or "|cffffff00"
        local cleanupInfo = ""
        if entry.cleanupApplied then
            cleanupInfo = format(" (cleaned: %d→%d, -%d outliers, -%d warmup)",
                entry.originalCount, entry.count, entry.removedOutliers, entry.warmupCalls)
        end
        print(format(
            color ..
            "ADVANCED PROFILE: %s - Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, StdDev: %.4f ms, MemUsage: %.2f KB, Count: %d, Calls/Min: %.4f%s|r",
            entry.label, entry.average, entry.max, entry.min, entry.standardDeviation, memUsage, entry.count,
            entry.callsPerMinute, cleanupInfo))
    end
    if summary then
        local totalCalls, totalTime, maxVal, minVal, sumSq, count = 0, 0, 0, math.huge, 0, 0
        for _, entry in ipairs(report) do
            totalCalls = totalCalls + entry.count
            totalTime = totalTime + entry.average * entry.count
            maxVal = math.max(maxVal, entry.max)
            minVal = math.min(minVal, entry.min)
            sumSq = sumSq + (entry.standardDeviation ^ 2 * entry.count)
            count = count + entry.count
        end
        local overallAvg = totalTime / totalCalls
        local overallStd = math.sqrt(sumSq / count)
        print(format(
            "|cff00ffffADVANCED PROFILE SUMMARY: Total Calls: %d, Overall Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, Overall StdDev: %.4f ms|r",
            totalCalls, overallAvg, maxVal, minVal, overallStd))
    end
end

--- Prints the profiling report to an Ace3 modernized frame, with interactive filter/sort, CSV, summary, and UI controls.
--- @param self ProfilingUtility
--- @param opts string|table|nil If string, treated as sortField. If table, supports: sortField, filter, minCount, asCSV, summary
function ProfilingUtility:PrintReportToFrame(opts)
    opts = opts or {}
    local sortField, filter, minCount, asCSV, summary
    if type(opts) == "string" then
        if opts:match("^filter=") then
            filter = opts:match("^filter=(.*)")
        else
            sortField = opts
        end
    elseif type(opts) == "table" then
        sortField = opts.sortField
        filter = opts.filter
        minCount = opts.minCount
        asCSV = opts.asCSV
        summary = opts.summary
    end
    if type(sortField) ~= "string" or not sortField then
        sortField = "max"
    end
    filter = filter or ""
    local availableSortFields = {
        { key = "max",               label = "Max",       width = 90 },
        { key = "average",           label = "Average",   width = 90 },
        { key = "min",               label = "Min",       width = 90 },
        { key = "count",             label = "Count",     width = 70 },
        { key = "callsPerMinute",    label = "Calls/Min", width = 90 },
        { key = "standardDeviation", label = "StdDev",    width = 90 },
    }
    local columns = {
        { key = "label",             label = "Label",     width = 220 },
        { key = "average",           label = "Average",   width = 90 },
        { key = "max",               label = "Max",       width = 90 },
        { key = "min",               label = "Min",       width = 90 },
        { key = "standardDeviation", label = "StdDev",    width = 90 },
        { key = "count",             label = "Count",     width = 70 },
        { key = "callsPerMinute",    label = "Calls/Min", width = 90 },
    }
    -- Controls for sort, filter, output mode, copy
    local currentSortField = sortField
    local currentFilter = filter
    local currentOutputMode = asCSV and "csv" or "pretty"
    local function getReportRows()
        local report = self:GetReport({ filter = currentFilter ~= "" and currentFilter or nil, minCount = minCount })
        if not report or #report == 0 then return {} end
        table.sort(report, function(a, b)
            return a[currentSortField] > b[currentSortField]
        end)
        return report
    end
    local function summaryFn()
        local rep = getReportRows()
        if not rep or #rep == 0 then return "" end
        local totalCalls, totalTime, maxVal, minVal, sumSq, count = 0, 0, 0, math.huge, 0, 0
        for _, entry in ipairs(rep) do
            totalCalls = totalCalls + entry.count
            totalTime = totalTime + entry.average * entry.count
            maxVal = math.max(maxVal, entry.max)
            minVal = math.min(minVal, entry.min)
            sumSq = sumSq + (entry.standardDeviation ^ 2 * entry.count)
            count = count + entry.count
        end
        local overallAvg = totalTime / totalCalls
        local overallStd = math.sqrt(sumSq / count)
        return string.format(
            "|cff00ffffPROFILE SUMMARY: Total Calls: %d, Overall Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, Overall StdDev: %.4f ms|r",
            totalCalls, overallAvg, maxVal, minVal, overallStd)
    end
    local function makeCSV(rep)
        rep = rep or getReportRows()
        local csv = "Label,Average,Max,Min,StdDev,Count,CallsPerMin"
        for _, entry in ipairs(rep) do
            csv = csv ..
                string.format("\n%s,%.4f,%.4f,%.4f,%.4f,%d,%.4f", entry.label, entry.average, entry.max, entry.min,
                    entry.standardDeviation, entry.count, entry.callsPerMinute)
        end
        return csv
    end
    local function makePretty(rep)
        rep = rep or getReportRows()
        local txt = ""
        for _, entry in ipairs(rep) do
            txt = txt ..
                string.format(
                    "%s - Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, StdDev: %.4f ms, Count: %d, Calls/Min: %.4f\n",
                    entry.label, entry.average, entry.max, entry.min, entry.standardDeviation, entry.count,
                    entry.callsPerMinute)
        end
        return txt
    end

    -- TableSection for profiling report
    local function rowsFn()
        local rows = getReportRows()
        for _, row in ipairs(rows) do
            row.average = string.format("%.4f", row.average)
            row.max = string.format("%.4f", row.max)
            row.min = string.format("%.4f", row.min)
            row.standardDeviation = string.format("%.4f", row.standardDeviation)
            row.callsPerMinute = string.format("%.4f", row.callsPerMinute)
        end
        return rows
    end

    -- Controls
    local controls = {
        function(_, frame)
            local filterBox = AceGUI:Create("EditBox")
            filterBox:SetLabel("Filter")
            filterBox:SetWidth(120)
            filterBox:SetText(currentFilter)
            filterBox:SetCallback("OnEnterPressed", function(widget, evt, val)
                currentFilter = val or ""
                if frame and frame.UpdateDebugFrame then frame:UpdateDebugFrame() end
            end)
            filterBox:SetCallback("OnEditFocusLost", function(widget, evt, val)
                currentFilter = val or ""
                if frame and frame.UpdateDebugFrame then frame:UpdateDebugFrame() end
            end)
            return filterBox
        end,
        function(_, frame)
            local sortDropdown = AceGUI:Create("Dropdown")
            local sortList = {}
            for _, col in ipairs(availableSortFields) do sortList[col.key] = col.label end
            sortDropdown:SetList(sortList)
            sortDropdown:SetValue(currentSortField)
            sortDropdown:SetLabel("Sort By")
            sortDropdown:SetWidth(120)
            sortDropdown:SetCallback("OnValueChanged", function(widget, evt, val)
                currentSortField = val
                if frame and frame.UpdateDebugFrame then frame:UpdateDebugFrame() end
            end)
            return sortDropdown
        end,
        function(_, frame)
            local outputMode = AceGUI:Create("Dropdown")
            outputMode:SetList({ pretty = "Pretty", csv = "CSV" })
            outputMode:SetValue(currentOutputMode)
            outputMode:SetLabel("Output Mode")
            outputMode:SetWidth(100)
            outputMode:SetCallback("OnValueChanged", function(widget, evt, val)
                currentOutputMode = val
                if frame and frame.UpdateDebugFrame then frame:UpdateDebugFrame() end
            end)
            return outputMode
        end,
        function(_, frame)
            local copyBtn = AceGUI:Create("Button")
            copyBtn:SetText("Copy All")
            copyBtn:SetWidth(90)
            copyBtn:SetCallback("OnClick", function()
                local rep = getReportRows()
                local text = (currentOutputMode == "csv") and makeCSV(rep) or makePretty(rep)
                if frame and frame.SetClipboardText then
                    frame:SetClipboardText(text)
                end
            end)
            return copyBtn
        end,
    }

    -- Show debug frame
    ns.DebugFrameUtil:ShowDebugFrame(self, {
        title = "Profiling Report",
        sections = function()
            if currentOutputMode == "csv" then
                return {
                    {
                        header = "Profiling Report (CSV)",
                        dataFn = function()
                            return { makeCSV(getReportRows()) }
                        end
                    }
                }
            else
                return {
                    {
                        type = "table",
                        header = "Profiling Report",
                        columns = columns,
                        rowsFn = rowsFn,
                        sortField = currentSortField,
                        filterFn = currentFilter ~= "" and function(row)
                            return tostring(row.label):find(currentFilter)
                        end or nil,
                    }
                }
            end
        end,
        controls = controls,
        summaryFn = summary and summaryFn or nil,
        refreshInterval = 1.0,
    })
end

--- Performs statistical cleanup on timing data to remove outliers and warmup calls
--- @param self ProfilingUtility
--- @param timing table The timing data to clean
--- @param label string The label for this timing data
--- @return table Cleaned timing data
function ProfilingUtility:CleanTimingData(timing, label)
    if not timing or not timing.times or #timing.times < 2 then
        return timing
    end

    local config = self.db.char.statisticalCleanup
    if not config.enabled then
        return timing
    end

    local warmupCalls = config.warmupCalls or 3
    local minSampleSize = config.minSampleSize or 10
    local outlierMethod = config.outlierMethod or "iqr"
    local outlierThreshold = config.outlierThreshold or 1.5
    local removeOutliers = config.removeOutliers ~= false

    -- Skip cleanup if not enough samples
    if #timing.times < minSampleSize then
        return timing
    end

    -- Create a copy of times for processing
    local times = {}
    for i, time in ipairs(timing.times) do
        times[i] = time
    end

    -- Sort times for statistical analysis
    table.sort(times)

    -- Remove warmup calls (first N calls)
    local startIndex = warmupCalls + 1
    if startIndex > #times then
        startIndex = #times
    end

    local cleanedTimes = {}
    for i = startIndex, #times do
        table.insert(cleanedTimes, times[i])
    end

    -- Detect and remove outliers with improved logic (only if enabled)
    local outliers = {}
    if config.outlierDetection and #cleanedTimes >= 4 then -- Need at least 4 samples for outlier detection
        if outlierMethod == "iqr" then
            -- Improved IQR method with adaptive thresholds
            local q1Index = math.floor(#cleanedTimes * 0.25)
            local q3Index = math.floor(#cleanedTimes * 0.75)
            local q1 = cleanedTimes[q1Index]
            local q3 = cleanedTimes[q3Index]
            local iqr = q3 - q1

            -- Adaptive threshold: be more lenient for high-variance data
            local adaptiveThreshold = outlierThreshold
            local useAdaptiveThresholds = config.adaptiveThresholds ~= false

            if useAdaptiveThresholds then
                local coefficientOfVariation = iqr / ((q1 + q3) / 2)

                -- If data has high variance, use more lenient threshold
                if coefficientOfVariation > 0.5 then
                    adaptiveThreshold = math.min(3.0, outlierThreshold * 1.5)
                elseif coefficientOfVariation > 0.3 then
                    adaptiveThreshold = math.min(2.5, outlierThreshold * 1.25)
                end
            end

            local lowerBound = q1 - (iqr * adaptiveThreshold)
            local upperBound = q3 + (iqr * adaptiveThreshold)

            -- Limit outlier removal to prevent over-aggressive cleaning
            local maxOutlierRemovalPercent = config.maxOutlierRemovalPercent or 30
            local maxOutliersToRemove = math.floor(#cleanedTimes * maxOutlierRemovalPercent / 100)

            for i, time in ipairs(cleanedTimes) do
                if time < lowerBound or time > upperBound then
                    table.insert(outliers, { index = i, value = time, reason = "IQR outlier" })
                end
            end

            -- If too many outliers detected, be more conservative
            if #outliers > maxOutliersToRemove then
                -- Sort outliers by how extreme they are
                table.sort(outliers, function(a, b)
                    local aExtreme = math.abs(a.value - (q1 + q3) / 2) / iqr
                    local bExtreme = math.abs(b.value - (q1 + q3) / 2) / iqr
                    return aExtreme > bExtreme
                end)

                -- Keep only the most extreme outliers
                outliers = { unpack(outliers, 1, maxOutliersToRemove) }
            end
        elseif outlierMethod == "percentile" then
            -- Percentile-based method
            local lowerPercentile = (100 - outlierThreshold) / 2
            local upperPercentile = 100 - lowerPercentile
            local lowerIndex = math.floor(#cleanedTimes * lowerPercentile / 100)
            local upperIndex = math.floor(#cleanedTimes * upperPercentile / 100)
            local lowerBound = cleanedTimes[lowerIndex]
            local upperBound = cleanedTimes[upperIndex]

            for i, time in ipairs(cleanedTimes) do
                if time < lowerBound or time > upperBound then
                    table.insert(outliers, { index = i, value = time, reason = "Percentile outlier" })
                end
            end
        end

        -- Remove outliers if configured to do so
        if removeOutliers and #outliers > 0 then
            -- Sort outliers by index in descending order to avoid index shifting
            table.sort(outliers, function(a, b) return a.index > b.index end)

            for _, outlier in ipairs(outliers) do
                table.remove(cleanedTimes, outlier.index)
            end
        end
    end

    -- Recalculate statistics with cleaned data
    if #cleanedTimes > 0 then
        local total = 0
        local min = math.huge
        local max = 0
        local count = #cleanedTimes

        for _, time in ipairs(cleanedTimes) do
            total = total + time
            min = math.min(min, time)
            max = math.max(max, time)
        end

        local average = total / count

        -- Calculate standard deviation
        local sumOfSquares = 0
        for _, time in ipairs(cleanedTimes) do
            sumOfSquares = sumOfSquares + (time - average) ^ 2
        end
        local standardDeviation = math.sqrt(sumOfSquares / count)

        -- Return cleaned timing data
        return {
            total = total,
            count = count,
            max = max,
            min = min,
            times = cleanedTimes,
            average = average,
            standardDeviation = standardDeviation,
            originalCount = #timing.times,
            removedOutliers = #timing.times - count,
            warmupCalls = warmupCalls
        }
    end

    return timing
end

--- Gets cleaned profiling report with statistical cleanup applied
--- @param self ProfilingUtility
--- @param opts table|nil Options: filter (string/pattern), minCount (number), useCleanup (boolean)
--- @return table A table containing the cleaned profiling report
function ProfilingUtility:GetCleanedReport(opts)
    opts = opts or {}
    local filter = opts.filter
    local minCount = opts.minCount or 0
    local useCleanup = opts.useCleanup ~= false

    if not next(self.timings) then
        return {}
    end

    local report = {}
    for label, timing in pairs(self.timings) do
        if timing.count > 0 and timing.count >= minCount and (not filter or tostring(label):find(filter)) then
            local cleanedTiming = useCleanup and self:CleanTimingData(timing, label) or timing
            local timestamps = self.callTimestamps[label] or {}
            local callsPerMinute = 0

            if #timestamps > 1 then
                local timeDiff = timestamps[#timestamps] - timestamps[1]
                if timeDiff > 0 then
                    callsPerMinute = #timestamps / (timeDiff / 60)
                end
            end

            -- Use cleaned data if available, fall back to original
            local average = cleanedTiming.average or (timing.total / timing.count)
            local max = cleanedTiming.max or timing.max
            local min = cleanedTiming.min or timing.min
            local count = cleanedTiming.count or timing.count
            local standardDeviation = cleanedTiming.standardDeviation or 0

            -- Calculate standard deviation if not provided by cleanup
            if not cleanedTiming.standardDeviation and timing.times then
                local sumOfSquares = 0
                for _, time in ipairs(timing.times) do
                    sumOfSquares = sumOfSquares + (time - average) ^ 2
                end
                standardDeviation = math.sqrt(sumOfSquares / timing.count)
            end

            table.insert(report, {
                label = label,
                average = average,
                max = max,
                min = min,
                count = count,
                callsPerMinute = callsPerMinute,
                standardDeviation = standardDeviation,
                -- Additional cleanup information
                originalCount = cleanedTiming.originalCount or timing.count,
                removedOutliers = cleanedTiming.removedOutliers or 0,
                warmupCalls = cleanedTiming.warmupCalls or 0,
                cleanupApplied = useCleanup and cleanedTiming.originalCount ~= nil
            })
        end
    end

    return report
end

-- ~~~~~~~~~~ SLASH COMMAND HANDLER ~~~~~~~~~~

--- Handler for /nagprofile slash command
--- @param self ProfilingUtility
--- @param input string
function ProfilingUtility:HandleProfileSlashCommand(input)
    input = input and strtrim(input) or ""
    local cmd, arg = input:match("^(%S+)%s*(.*)$")
    cmd = cmd and strlower(cmd) or ""
    arg = arg and strtrim(arg) or ""
    local function printHelp()
        print(
            "|cff00bfff[NAG] Usage:|r /nagdebug profile <ModuleName> | /nagdebug profile off <ModuleName> | /nagdebug profile all | /nagdebug profile off all")
        print("|cff00bfff[NAG] Reports:|r /nagdebug profile report [frame|advanced|raw|clean|compare]")
    end
    if cmd == "" then
        printHelp()
        return
    end
    if cmd == "report" then
        if self then
            if arg == "frame" then
                self:PrintReportToFrame()
            elseif arg == "advanced" then
                self:PrintAdvancedReport()
            elseif arg == "raw" then
                self:PrintReport({ useCleanup = false })
            elseif arg == "clean" then
                self:PrintReport({ useCleanup = true })
            elseif arg == "compare" then
                print("|cff00bfff[NAG] Raw Profiling Report (No Cleanup):|r")
                self:PrintReport({ useCleanup = false })
                print("|cff00bfff[NAG] Cleaned Profiling Report (With Statistical Cleanup):|r")
                self:PrintReport({ useCleanup = true })
            else
                self:PrintReport()
            end
        end
        return
    end
    if cmd == "all" then
        -- Enable profiling for all modules
        local count = 0
        for name, mod in pairs(NAG.modules) do
            if mod and mod.EnableProfiling then
                mod:EnableProfiling()
                count = count + 1
            end
        end
        print("|cff00ff00[NAG] Profiling enabled for " .. count .. " modules.|r")
        if self and self.PrintReport then
            self:PrintReport()
        end
        return
    elseif cmd == "off" and arg == "all" then
        -- Disable profiling for all modules
        local count = 0
        for name, mod in pairs(NAG.modules) do
            if mod and mod.DisableProfiling then
                mod:DisableProfiling()
                count = count + 1
            end
        end
        print("|cff00ff00[NAG] Profiling disabled for " .. count .. " modules.|r")
        if self and self.PrintReport then
            self:PrintReport()
        end
        return
    elseif cmd == "off" and arg ~= "" then
        -- Disable profiling for a specific module
        local mod = NAG:GetModule(arg, true)
        if mod and mod.DisableProfiling then
            mod:DisableProfiling()
            print("|cff00ff00[NAG] Profiling disabled for module: " .. arg .. "|r")
        else
            print("|cffff0000[NAG] Module not found or does not support profiling: " .. arg .. "|r")
        end
        if self and self.PrintReport then
            self:PrintReport()
        end
        return
    elseif cmd ~= "off" then
        -- Enable profiling for a specific module
        local mod = NAG:GetModule(cmd, true)
        if mod and mod.EnableProfiling then
            mod:EnableProfiling()
            print("|cff00ff00[NAG] Profiling enabled for module: " .. cmd .. "|r")
        else
            print("|cffff0000[NAG] Module not found or does not support profiling: " .. cmd .. "|r")
        end
        if self and self.PrintReport then
            self:PrintReport()
        end
        return
    end
    printHelp()
end

-- ~~~~~~~~~~ OPTIONS MANAGEMENT ============================

--- Provides options configuration for the ProfilingUtility module
--- @param self ProfilingUtility
--- @return table Options configuration table
function ProfilingUtility:GetOptions()
    return {
        type = "group",
        name = L["Profiling Utility"] or "Profiling Utility",
        desc = L["Configure profiling and performance monitoring settings"] or "Configure profiling and performance monitoring settings",
        args = {
            enabled = {
                type = "toggle",
                name = L["enabled"] or "Enabled",
                desc = L["enabledDesc"] or "Enable or disable this module/feature",
                get = function() return self:IsEnabled() end,
                set = function(_, value)
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end
            },
            autoProfiling = {
                type = "toggle",
                name = L["autoProfiling"] or "Auto-Enable Profiling",
                desc = L["autoProfilingDesc"] or "Automatically enable profiling for new modules when they load",
                get = function() return self:GetSetting("char", "autoProfiling", false) end,
                set = function(_, value)
                    self:SetSetting("char", "autoProfiling", value)
                end
            },
            profilingModules = {
                type = "multiselect",
                name = L["profilingModules"] or "Profiled Modules",
                desc = L["profilingModulesDesc"] or "Select which modules should have profiling enabled",
                values = function()
                    local modules = {}
                    for name, mod in pairs(NAG.modules) do
                        if mod and mod.EnableProfiling then
                            modules[name] = name
                        end
                    end
                    return modules
                end,
                get = function(_, key)
                    return self:GetSetting("char", "profiledModules", {})[key] or false
                end,
                set = function(_, key, value)
                    local profiledModules = self:GetSetting("char", "profiledModules", {})
                    profiledModules[key] = value
                    self:SetSetting("char", "profiledModules", profiledModules)

                    -- Apply the setting immediately
                    local mod = NAG:GetModule(key, true)
                    if mod then
                        if value then
                            mod:EnableProfiling()
                        else
                            mod:DisableProfiling()
                        end
                    end
                end
            },
            reportSettings = {
                type = "group",
                name = L["reportSettings"] or "Report Settings",
                inline = true,
                args = {
                    defaultSortField = {
                        type = "select",
                        name = L["defaultSortField"] or "Default Sort Field",
                        desc = L["defaultSortFieldDesc"] or "Default field to sort profiling reports by",
                        values = {
                            max = "Maximum Time",
                            average = "Average Time",
                            count = "Call Count",
                            callsPerMinute = "Calls Per Minute",
                            standardDeviation = "Standard Deviation"
                        },
                        get = function() return self:GetSetting("char", "defaultSortField", "max") end,
                        set = function(_, value)
                            self:SetSetting("char", "defaultSortField", value)
                        end
                    },
                    highlightTopN = {
                        type = "range",
                        name = L["highlightTopN"] or "Highlight Top N",
                        desc = L["highlightTopNDesc"] or "Number of top performers to highlight in reports",
                        min = 1,
                        max = 10,
                        step = 1,
                        get = function() return self:GetSetting("char", "highlightTopN", 3) end,
                        set = function(_, value)
                            self:SetSetting("char", "highlightTopN", value)
                        end
                    },
                    showSummary = {
                        type = "toggle",
                        name = L["showSummary"] or "Show Summary",
                        desc = L["showSummaryDesc"] or "Include summary statistics in profiling reports",
                        get = function() return self:GetSetting("char", "showSummary", true) end,
                        set = function(_, value)
                            self:SetSetting("char", "showSummary", value)
                        end
                    }
                }
            },
            statisticalCleanup = {
                type = "group",
                name = L["statisticalCleanup"] or "Statistical Cleanup",
                desc = L["statisticalCleanupDesc"] or "Configure outlier detection and warmup call handling",
                args = {
                    enabled = {
                        type = "toggle",
                        name = L["Enable Statistical Cleanup"] or "Enable Statistical Cleanup",
                        desc = L["Enable outlier detection and warmup call removal"] or "Enable outlier detection and warmup call removal",
                        get = function() return self:GetSetting("char", "statisticalCleanup", {}).enabled ~= false end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.enabled = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    outlierDetection = {
                        type = "toggle",
                        name = L["outlierDetection"] or "Enable Outlier Detection",
                        desc = L["outlierDetectionDesc"] or "Enable IQR or percentile-based outlier detection (disable to only remove warmup calls)",
                        get = function()
                            return self:GetSetting("char", "statisticalCleanup", {}).outlierDetection ~=
                                false
                        end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.outlierDetection = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    warmupCalls = {
                        type = "range",
                        name = L["warmupCalls"] or "Warmup Calls to Skip",
                        desc = L["warmupCallsDesc"] or "Number of initial calls to skip (helps with JIT compilation, first-time allocation)",
                        min = 0,
                        max = 10,
                        step = 1,
                        get = function() return self:GetSetting("char", "statisticalCleanup", {}).warmupCalls or 3 end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.warmupCalls = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    outlierMethod = {
                        type = "select",
                        name = L["outlierMethod"] or "Outlier Detection Method",
                        desc = L["outlierMethodDesc"] or "Method for detecting statistical outliers",
                        values = {
                            iqr = "Interquartile Range (IQR)",
                            percentile = "Percentile-based"
                        },
                        get = function() return self:GetSetting("char", "statisticalCleanup", {}).outlierMethod or "iqr" end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.outlierMethod = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    outlierThreshold = {
                        type = "range",
                        name = L["outlierThreshold"] or "Outlier Threshold",
                        desc = L["outlierThresholdDesc"] or "IQR multiplier or percentile threshold for outlier detection",
                        min = 0.5,
                        max = 3.0,
                        step = 0.1,
                        get = function() return self:GetSetting("char", "statisticalCleanup", {}).outlierThreshold or 1.5 end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.outlierThreshold = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    minSampleSize = {
                        type = "range",
                        name = L["minSampleSize"] or "Minimum Sample Size",
                        desc = L["minSampleSizeDesc"] or "Minimum number of samples before applying statistical cleanup",
                        min = 5,
                        max = 50,
                        step = 1,
                        get = function() return self:GetSetting("char", "statisticalCleanup", {}).minSampleSize or 10 end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.minSampleSize = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    removeOutliers = {
                        type = "toggle",
                        name = L["removeOutliers"] or "Remove Outliers",
                        desc = L["removeOutliersDesc"] or "Actually remove outliers from calculations (vs. just flagging them)",
                        get = function() return self:GetSetting("char", "statisticalCleanup", {}).removeOutliers ~= false end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.removeOutliers = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    maxOutlierRemovalPercent = {
                        type = "range",
                        name = L["maxOutlierRemovalPercent"] or "Max Outlier Removal %",
                        desc =
                        "Maximum percentage of data that can be removed as outliers (prevents over-aggressive cleaning)",
                        min = 10,
                        max = 50,
                        step = 5,
                        get = function() return (self:GetSetting("char", "statisticalCleanup", {}).maxOutlierRemovalPercent or 30) end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.maxOutlierRemovalPercent = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    },
                    adaptiveThresholds = {
                        type = "toggle",
                        name = L["adaptiveThresholds"] or "Adaptive Thresholds",
                        desc =
                        "Automatically adjust outlier detection thresholds based on data variance (more lenient for high-variance data)",
                        get = function()
                            return self:GetSetting("char", "statisticalCleanup", {}).adaptiveThresholds ~=
                                false
                        end,
                        set = function(_, value)
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            config.adaptiveThresholds = value
                            self:SetSetting("char", "statisticalCleanup", config)
                        end
                    }
                }
            },
            actions = {
                type = "group",
                name = L["actions"] or "Actions",
                inline = true,
                args = {
                    enableAllModules = {
                        type = "execute",
                        name = L["enableAllModules"] or "Enable All Modules",
                        desc = L["enableAllModulesDesc"] or "Enable profiling for all modules that support it",
                        func = function()
                            local count = 0
                            for name, mod in pairs(NAG.modules) do
                                if mod and mod.EnableProfiling then
                                    mod:EnableProfiling()
                                    count = count + 1
                                end
                            end
                            print("|cff00ff00[NAG] Profiling enabled for " .. count .. " modules.|r")
                        end
                    },
                    disableAllModules = {
                        type = "execute",
                        name = L["disableAllModules"] or "Disable All Modules",
                        desc = L["disableAllModulesDesc"] or "Disable profiling for all modules",
                        func = function()
                            local count = 0
                            for name, mod in pairs(NAG.modules) do
                                if mod and mod.DisableProfiling then
                                    mod:DisableProfiling()
                                    count = count + 1
                                end
                            end
                            print("|cff00ff00[NAG] Profiling disabled for " .. count .. " modules.|r")
                        end
                    },
                    showReport = {
                        type = "execute",
                        name = L["showReport"] or "Show Report",
                        desc = L["showReportDesc"] or "Display the current profiling report",
                        func = function()
                            self:PrintReport({
                                sortField = self:GetSetting("char", "defaultSortField", "max"),
                                highlightTopN = self:GetSetting("char", "highlightTopN", 3),
                                summary = self:GetSetting("char", "showSummary", true)
                            })
                        end
                    },
                    showAdvancedReport = {
                        type = "execute",
                        name = L["showAdvancedReport"] or "Show Advanced Report",
                        desc = L["showAdvancedReportDesc"] or "Display the advanced profiling report with memory usage",
                        func = function()
                            self:PrintAdvancedReport({
                                sortField = self:GetSetting("char", "defaultSortField", "max"),
                                highlightTopN = self:GetSetting("char", "highlightTopN", 3),
                                summary = self:GetSetting("char", "showSummary", true)
                            })
                        end
                    },
                    showReportFrame = {
                        type = "execute",
                        name = L["showReportFrame"] or "Show Report Frame",
                        desc = L["showReportFrameDesc"] or "Display the interactive profiling report frame",
                        func = function()
                            self:PrintReportToFrame({
                                sortField = self:GetSetting("char", "defaultSortField", "max"),
                                highlightTopN = self:GetSetting("char", "highlightTopN", 3),
                                summary = self:GetSetting("char", "showSummary", true)
                            })
                        end
                    },
                    compareRawVsClean = {
                        type = "execute",
                        name = L["compareRawVsClean"] or "Compare Raw vs Cleaned",
                        desc = L["compareRawVsCleanDesc"] or "Show both raw and statistically cleaned reports for comparison",
                        func = function()
                            print("|cff00bfff[NAG] Raw Report (No Cleanup):|r")
                            self:PrintReport({
                                sortField = self:GetSetting("char", "defaultSortField", "max"),
                                highlightTopN = self:GetSetting("char", "highlightTopN", 3),
                                summary = self:GetSetting("char", "showSummary", true),
                                useCleanup = false
                            })
                            print("|cff00bfff[NAG] Cleaned Report (With Cleanup):|r")
                            self:PrintReport({
                                sortField = self:GetSetting("char", "defaultSortField", "max"),
                                highlightTopN = self:GetSetting("char", "highlightTopN", 3),
                                summary = self:GetSetting("char", "showSummary", true),
                                useCleanup = true
                            })
                        end
                    },
                    showCleanupStats = {
                        type = "execute",
                        name = L["showCleanupStats"] or "Show Cleanup Statistics",
                        desc = L["showCleanupStatsDesc"] or "Display current cleanup configuration and impact summary",
                        func = function()
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            print("|cff00bfff[NAG] Cleanup Config:|r")
                            print("Enabled:", config.enabled and "Yes" or "No")
                            print("Outlier Detection:", config.outlierDetection ~= false and "Yes" or "No")
                            print("Warmup Calls:", config.warmupCalls or 3)

                            if config.outlierDetection then
                                print("Method:", config.outlierMethod or "iqr", "Threshold:",
                                    config.outlierThreshold or 1.5)
                                print("Max Removal:", config.maxOutlierRemovalPercent or 30, "%", "Adaptive:",
                                    config.adaptiveThresholds ~= false and "Yes" or "No")
                            end

                            -- Show cleanup impact summary
                            local cleanedReport = self:GetCleanedReport({ useCleanup = true })
                            if #cleanedReport > 0 then
                                local totalOriginalCalls = 0
                                local totalCleanedCalls = 0
                                local totalOutliersRemoved = 0
                                local totalWarmupRemoved = 0

                                for _, entry in ipairs(cleanedReport) do
                                    if entry.cleanupApplied then
                                        totalOriginalCalls = totalOriginalCalls + (entry.originalCount or entry.count)
                                        totalCleanedCalls = totalCleanedCalls + entry.count
                                        totalOutliersRemoved = totalOutliersRemoved + (entry.removedOutliers or 0)
                                        totalWarmupRemoved = totalWarmupRemoved + (entry.warmupCalls or 0)
                                    end
                                end

                                if totalOriginalCalls > 0 then
                                    print("\n|cff00bfff[NAG] Cleanup Summary:|r")
                                    print("Calls:", totalOriginalCalls, "→", totalCleanedCalls,
                                        string.format("(%.1f%% reduction)",
                                            ((totalOriginalCalls - totalCleanedCalls) / totalOriginalCalls) * 100))
                                    print("Removed:", totalWarmupRemoved, "warmup,", totalOutliersRemoved, "outliers")
                                end
                            end
                        end
                    },
                    warmupOnlyCleanup = {
                        type = "execute",
                        name = L["warmupOnlyCleanup"] or "Warmup-Only Cleanup Demo",
                        desc = L["warmupOnlyCleanupDesc"] or "Temporarily disable outlier detection to show warmup-only cleanup",
                        func = function()
                            local config = self:GetSetting("char", "statisticalCleanup", {})
                            local originalOutlierDetection = config.outlierDetection

                            -- Temporarily disable outlier detection
                            config.outlierDetection = false
                            self:SetSetting("char", "statisticalCleanup", config)

                            print("|cff00bfff[NAG] Warmup-Only Cleanup Demo:|r")
                            self:PrintReport({
                                sortField = self:GetSetting("char", "defaultSortField", "max"),
                                highlightTopN = self:GetSetting("char", "highlightTopN", 3),
                                summary = self:GetSetting("char", "showSummary", true),
                                useCleanup = true
                            })

                            -- Restore original setting
                            config.outlierDetection = originalOutlierDetection
                            self:SetSetting("char", "statisticalCleanup", config)

                            print("|cff00bfff[NAG] Outlier detection restored to:",
                                originalOutlierDetection and "Enabled" or "Disabled")
                        end
                    },
                    resetData = {
                        type = "execute",
                        name = L["resetData"] or "Reset Data",
                        desc = L["resetDataDesc"] or "Clear all profiling data",
                        func = function()
                            self:Reset()
                            print("|cff00ff00[NAG] Profiling data reset.|r")
                        end
                    }
                }
            }
        }
    }
end
