--- @module "NAG.DataWalker"
--- Walks and processes hierarchical data structures for NAG modules, providing flexible processors for different entity types.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ============================
local addonName, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")


--WoW API
local UnitClass = _G.UnitClass

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local min = math.min

local tinsert = tinsert
local tremove = tremove
local wipe = wipe

local concat = table.concat
local tostring = tostring

-- Enhanced error handling
local pcall = ns.pcall

-- ~~~~~~~~~~ CONTENT ============================

-- Use TableUtils for table operations
local TableUtils = ns.TableUtils

--- @class DataWalker: CoreModule, AceConsole-3.0
local DataWalker = NAG:CreateModule("DataWalker", nil, {
    messageHandlers = {},
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.UTILITIES
    }
})
local module = DataWalker
ns.DataWalker = DataWalker


-- ~~~~~~~~~~ ACE3 LIFECYCLE ============================
do
    function DataWalker:ModuleInitialize()
        -- Core properties
        self.maxDepth = 250
        self.skipPaths = {}
        -- Performance optimizations
        self.processorCache = {}
        self.cachedPathString = nil
        self.pathChanged = false
        -- Error reporting
        self.errorReportTimer = nil
        -- Chunked processing queue system
        self.processingQueue = {}
        self.isProcessing = false
        self.batchSize = 200  -- Process 200 nodes before yielding
        self.continueTimer = nil
    end

    --- Called when the module is disabled
    --- Cleans up any resources after data processing is complete
    function DataWalker:ModuleDisable()
        -- Clear any cached data or state
        self.processors = nil
        self.context = nil
        -- Reset configuration values to defaults
        self.maxDepth = 250
        -- Skip paths can be cleared since they're not needed after processing
        self:ClearSkipPaths()
        -- Clear performance caches
        wipe(self.processorCache)
        self.cachedPathString = nil
        self.pathChanged = false
        -- Cancel error report timer
        if self.errorReportTimer then
            self:CancelTimer(self.errorReportTimer)
            self.errorReportTimer = nil
        end
        -- Cancel processing continuation timer
        if self.continueTimer then
            self:CancelTimer(self.continueTimer)
            self.continueTimer = nil
        end
        -- Clear processing queue
        wipe(self.processingQueue)
        self.isProcessing = false
        -- Clear chunk timing tracking
        self.chunkNumber = nil
        self.chunkStartTime = nil
        self.totalChunkTime = nil
        -- Clear any other references that might be held
        self:Info("DataWalker: All processing state cleared, configuration reset to defaults")
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ============================

-- Core walker implementation
function DataWalker:Walk(data, processors, options)
    if not data then
        return false
    end
    if not processors then
        self:Error("No processors provided to DataWalker")
        return false
    end
    self.processors = processors
    -- Clear processor cache for new walk
    wipe(self.processorCache)

    options = options or {}
    self.context = {
        path = options.path or {},
        depth = options.depth or 0,
        stats = {
            processed = 0,
            skipped = {
                count = 0,
                paths = {}
            },
            errors = {
                count = 0,
                details = {}
            },
            reprocessAttempts = {
                count = 0,
                details = {}
            },
            entities = {}
        }
    }
    -- Reset path caching
    self.cachedPathString = nil
    self.pathChanged = false

    -- Pre-allocate path array for reuse
    self.pathArray = self.pathArray or {}
    wipe(self.pathArray)
    for i, v in ipairs(self.context.path) do
        self.pathArray[i] = v
    end

    -- Store completion callback if provided
    self.onComplete = options and options.onComplete or nil

    -- Clear processing queue and start chunked processing
    wipe(self.processingQueue)
    self.isProcessing = true

    -- Initialize chunk timing tracking
    self.chunkNumber = 0
    self.chunkStartTime = debugprofilestop()
    self.totalChunkTime = 0

    -- Queue the root node
    tinsert(self.processingQueue, { node = data, pathArray = {}, depth = 0 })

    -- Start chunked processing
    self:ProcessChunk()

    -- Note: Walk now returns immediately, processing continues asynchronously
    -- Completion callback (onComplete) will be called when processing finishes
    return true
end

-- Process a chunk of nodes from the queue, then yield if needed
function DataWalker:ProcessChunk()
    if not self.isProcessing then
        return
    end

    -- Increment chunk counter and start timing
    self.chunkNumber = (self.chunkNumber or 0) + 1
    local chunkStartTime = debugprofilestop()
    local processedBeforeChunk = self.context.stats.processed

    local processedThisChunk = 0
    local startTime = debugprofilestop()

    while #self.processingQueue > 0 and processedThisChunk < self.batchSize do
        -- Pop from queue (FIFO order)
        local workItem = tremove(self.processingQueue, 1)
        if not workItem then
            break
        end

        -- Restore path state for this node
        local savedPathString = self.cachedPathString
        local savedPathArrayLen = #self.pathArray

        -- Restore path array
        wipe(self.pathArray)
        for i, v in ipairs(workItem.pathArray) do
            self.pathArray[i] = v
        end
        -- Rebuild path string from array
        if #self.pathArray > 0 then
            self.cachedPathString = concat(self.pathArray, ".")
        else
            self.cachedPathString = ""
        end

        -- Process the node (non-recursive, queues children)
        local success = self:ProcessNode(workItem.node, workItem.depth)

        if not success and self.debug then
            self:Debug("ProcessChunk: Failed to process node at depth %d", workItem.depth)
        end

        processedThisChunk = processedThisChunk + 1

        -- Check execution time - yield if we've been running too long
        local elapsed = debugprofilestop() - startTime
        if elapsed > 50 then  -- 50ms execution time limit (WoW limit is ~50-100ms per frame)
            break
        end
    end

    -- Calculate chunk timing
    local chunkEndTime = debugprofilestop()
    local chunkTimeMs = chunkEndTime - chunkStartTime
    local totalElapsedMs = chunkEndTime - (self.chunkStartTime or chunkStartTime)
    self.totalChunkTime = (self.totalChunkTime or 0) + chunkTimeMs

    -- Calculate entities processed in this chunk
    local entitiesProcessedThisChunk = self.context.stats.processed - processedBeforeChunk
    local queueRemaining = #self.processingQueue

    -- Log chunk timing information
    local timeStr
    if chunkTimeMs < 1000 then
        timeStr = format("%.2fms", chunkTimeMs)
    else
        timeStr = format("%.2fs", chunkTimeMs / 1000)
    end

    local totalTimeStr
    if totalElapsedMs < 1000 then
        totalTimeStr = format("%.2fms", totalElapsedMs)
    else
        totalTimeStr = format("%.2fs", totalElapsedMs / 1000)
    end

    local avgTimeStr
    local avgTimeMs = self.totalChunkTime / self.chunkNumber
    if avgTimeMs < 1000 then
        avgTimeStr = format("%.2fms", avgTimeMs)
    else
        avgTimeStr = format("%.2fs", avgTimeMs / 1000)
    end

    self:Debug(format(
        "DataWalker Chunk #%d: %s (entities: %d, queue: %d) | Total: %s | Avg: %s/chunk",
        self.chunkNumber,
        timeStr,
        entitiesProcessedThisChunk,
        queueRemaining,
        totalTimeStr,
        avgTimeStr
    ))

    -- If queue is empty, processing is complete
    if #self.processingQueue == 0 then
        self.isProcessing = false
        local finalTotalTime = debugprofilestop() - (self.chunkStartTime or chunkStartTime)
        local finalTimeStr
        if finalTotalTime < 1000 then
            finalTimeStr = format("%.2fms", finalTotalTime)
        else
            finalTimeStr = format("%.2fs", finalTotalTime / 1000)
        end

        if self.debug then
            self:Debug("Data walk complete, processed %d entities in %d chunks (total: %s)",
                self.context.stats.processed, self.chunkNumber, finalTimeStr)
        end

        -- Schedule error reporting if dev mode is enabled
        if NAG:IsDevModeEnabled() then
            self:ScheduleErrorReport()
        end

        -- Call completion callback if provided
        if self.onComplete then
            local callback = self.onComplete
            self.onComplete = nil  -- Clear callback
            callback(self.context.stats)
        end
    else
        -- Queue next chunk processing using timer (yields to WoW's frame cycle)
        self.continueTimer = C_Timer.After(0, function()
            self.continueTimer = nil
            self:ProcessChunk()
        end)
    end
end

-- Process a single node (non-recursive, queues children instead of recursing)
function DataWalker:ProcessNode(node, depth)
    -- Check depth limit
    if depth >= self.maxDepth then
        self:Warn("ProcessNode: Maximum depth %d reached, skipping node", self.maxDepth)
        return true
    end

    -- Wrap node processing in pcall for safety
    local success, result = pcall(function()
        -- Skip invalid nodes
        if type(node) ~= "table" then
            return true
        end

        -- Get current path string for logging and checks
        local currentPath = self:GetCachedPathString()
        if self:ShouldSkipPath(currentPath) then
            return true
        end

        -- Handle different node types using optimized detection
        local nodeType = self:GetNodeType(node)

        -- Enhanced debugging for empty nodes
        if nodeType == "empty" then
            if self.debug then self:Info("ProcessNode: Empty node at path: %s (depth: %d)", currentPath, depth) end
            return true
        elseif nodeType == "id_array" then
            return self:ProcessIdArray(node)
        elseif nodeType == "key_value_id" then
            return self:ProcessKeyValueIdTable(node)
        elseif nodeType == "regular_table" then
            return self:ProcessTableQueued(node, depth)
        else
            -- Log unexpected node types for debugging
            if self.debug then self:Debug("ProcessNode: Unknown node type '%s' at path: %s (depth: %d)", tostring(nodeType),
                    currentPath, depth) end
            return self:ProcessTableQueued(node, depth) -- Fallback to regular table processing
        end
    end)

    if not success then
        -- Log the error and increment error count
        local stats = self.context.stats
        stats.errors.count = stats.errors.count + 1

        local currentPath = self:GetCachedPathString()
        local errorMsg = format("ProcessNode: Failed to process node at path: %s (depth: %d) - %s",
            currentPath, depth, tostring(result))
        self:Error(errorMsg)

        -- Store error details for debugging
        table.insert(stats.errors.details, {
            path = currentPath,
            depth = depth,
            error = tostring(result),
            nodeType = type(node)
        })

        -- Return true to continue processing other nodes instead of crashing
        return true
    end

    return result
end

-- Legacy WalkNode for backward compatibility (now just queues the node)
function DataWalker:WalkNode(node)
    if self.isProcessing then
        -- If chunked processing is active, queue the node
        local currentPathArray = {}
        for i, v in ipairs(self.pathArray) do
            currentPathArray[i] = v
        end
        tinsert(self.processingQueue, {
            node = node,
            pathArray = currentPathArray,
            depth = (self.context and self.context.depth or 0) + 1
        })
        return true
    else
        -- Fallback to old synchronous processing (shouldn't happen, but safe)
        return self:ProcessNode(node, (self.context and self.context.depth or 0) + 1)
    end
end

-- Optimized single-pass node type detection
-- Performance: Minimize table iterations to avoid execution timeouts
function DataWalker:GetNodeType(node)
    if type(node) ~= "table" then
        return "empty"
    end

    if not next(node) then
        return "empty"
    end

    local firstKey = next(node)

    if type(firstKey) == "number" then
        -- Optimized check: if first key is 1 and we have at least a few elements,
        -- it's likely an id_array. Do minimal verification.
        local n = #node
        if firstKey == 1 and n > 0 then
            -- Quick check: verify first few elements exist (fast path)
            local hasGap = false
            local checkCount = min(5, n)  -- Only check first 5 elements
            for i = 1, checkCount do
                if node[i] == nil then
                    hasGap = true
                    break
                end
            end

            -- If no gaps in first few elements, assume id_array (most common case)
            -- Only do full verification if we suspect sparse keys
            if not hasGap then
                -- Single pass verification:
                -- - arrays must have ONLY numeric keys
                -- - numeric keys must be within [1..#node] (prevents sparse maps like TierSets from being misclassified)
                local hasNonNumeric = false
                local hasOutOfRangeNumeric = false
                for key, _ in pairs(node) do
                    if type(key) ~= "number" then
                        hasNonNumeric = true
                        break
                    end
                    if key < 1 or key > n or (key % 1) ~= 0 then
                        hasOutOfRangeNumeric = true
                        break
                    end
                end

                if not hasNonNumeric and not hasOutOfRangeNumeric then
                    return "id_array"
                end
            end
        end

        -- If first key is numeric but not a clean array, it's a sparse ID table
        return "key_value_id"
    else
        -- Non-numeric keys = regular table
        return "regular_table"
    end
end

-- Optimized path manipulation with incremental string building
-- Performance: Avoids full table.concat on every path change
function DataWalker:PushPath(key)
    local pathArray = self.pathArray
    local len = #pathArray
    pathArray[len + 1] = key

    -- Incrementally build path string (avoids full concat)
    if self.cachedPathString == nil or self.cachedPathString == "" then
        self.cachedPathString = tostring(key)
    else
        self.cachedPathString = self.cachedPathString .. "." .. tostring(key)
    end
end

function DataWalker:PopPath()
    local pathArray = self.pathArray
    local len = #pathArray
    if len > 0 then
        pathArray[len] = nil

        -- Rebuild path string only when popping (less frequent than push)
        if len > 1 then
            self.cachedPathString = concat(pathArray, ".")
        else
            self.cachedPathString = ""
        end
    end
end

function DataWalker:GetCurrentPath()
    return self.pathArray
end

-- Cached path string generation (now maintained incrementally)
function DataWalker:GetCachedPathString()
    return self.cachedPathString or ""
end

-- Mark path as changed when modifying path array (kept for compatibility)
function DataWalker:MarkPathChanged()
    -- No-op: path string is now maintained incrementally
end

-- Processing methods for different types of nodes
function DataWalker:ProcessIdArray(node)
    local entryType = self:DetermineEntryType(self:GetCurrentPath())
    if not entryType then
        if self.debug then self:Debug("ProcessIdArray: Could not determine entry type for path: %s",
                table.concat(self:GetCurrentPath(), ".")) end
        return false
    end

    local processor = self:GetCachedProcessor(entryType)
    if not processor then
        self:Warn("ProcessIdArray: No processor found for entryType '%s'", entryType)
        return false
    end

    local pathArray = self:GetCurrentPath()
    -- Process all entries - ProcessChunk will handle yielding via execution time limit
    for _, id in ipairs(node) do
        self:ProcessEntry(id, nil, pathArray, entryType)
    end
    return true
end

function DataWalker:ProcessKeyValueIdTable(node)
    local entryType = self:DetermineEntryType(self:GetCurrentPath())
    if not entryType then
        if self.debug then self:Debug("ProcessKeyValueIdTable: Could not determine entry type for path: %s",
                table.concat(self:GetCurrentPath(), ".")) end
        return false
    end

    local processor = self:GetCachedProcessor(entryType)
    if not processor then
        self:Warn("ProcessKeyValueIdTable: No processor found for entryType '%s'", entryType)
        return false
    end

    local pathArray = self:GetCurrentPath()
    for id, rawData in pairs(node) do
        self:ProcessEntry(id, rawData, pathArray, entryType)
    end
    return true
end

function DataWalker:ProcessTable(node)
    -- Legacy synchronous version - queues children for chunked processing
    return self:ProcessTableQueued(node, (self.context and self.context.depth or 0))
end

-- Queue-based table processing (non-recursive)
function DataWalker:ProcessTableQueued(node, depth)
    for key, value in pairs(node) do
        -- Build path for child node
        local childPathArray = {}
        for i, v in ipairs(self.pathArray) do
            childPathArray[i] = v
        end
        tinsert(childPathArray, key)

        -- Queue child for processing
        tinsert(self.processingQueue, {
            node = value,
            pathArray = childPathArray,
            depth = depth + 1
        })
    end
    return true
end

-- Cached processor lookup
function DataWalker:GetCachedProcessor(entryType)
    local processor = self.processorCache[entryType]
    if not processor then
        processor = self.processors[entryType]
        if processor then
            self.processorCache[entryType] = processor
        else
            self:Warn("ProcessEntry: No processor found for type '%s'", entryType)
            return nil
        end
    end
    return processor
end

-- Core processing function that all handlers will use
function DataWalker:ProcessEntry(id, rawData, pathArray, entryType)
    local processor = self:GetCachedProcessor(entryType)
    if not processor then
        return false
    end

    local stats = self.context.stats
    stats.processed = stats.processed + 1

    -- Process new entry with error handling
    local success, result = pcall(function()
        return processor:process(id, pathArray, rawData)
    end)

    if success then
        local entry = result
        if entry then
            return true
        else
            self:Info("ProcessEntry: Processor returned nil for %s ID %s", entryType, tostring(id))
            return false
        end
    else
        -- Log the error and increment error count
        local errors = stats.errors
        errors.count = errors.count + 1
        local errorMsg = format("ProcessEntry: Failed to process %s ID %s - %s", entryType, tostring(id),
            tostring(result))
        self:Warn(errorMsg)

        -- Store error details for debugging
        table.insert(errors.details, {
            type = entryType,
            id = id,
            error = tostring(result),
            path = table.concat(pathArray, ".")
        })

        return false
    end
end

-- Path handling methods
function DataWalker:ShouldSkipPath(path)
    -- Skip other classes' data
    if path:find("%.Class%.") then
        local playerClass = NAG.CLASS_FILENAME
        local classInPath = path:match("%.Class%.([^%.]+)")
        -- Only skip if we found a class in the path AND it's not our class
        if classInPath and classInPath ~= playerClass then
            return true
        end
        return false -- Explicitly keep our class's data
    end
    -- Skip explicitly configured paths
    return self.skipPaths[path]
end

function DataWalker:DetermineEntryType(path)
    if not path then
        return nil
    end

    -- Map of path markers to entity types
    local typeMarkers = {
        ["Spells"] = "spell",
        ["Items"] = "item",
        ["Trinkets"] = "item", -- Trinkets are items with trinket flag
        ["TierSets"] = "tierset",
        ["Enchants"] = "enchant",
        ["Buffs"] = "spell",             -- Buffs are actually spells
        ["Talents"] = "talent",
        ["SpellRequirements"] = "spell", -- SpellRequirements contain spell requirement data
        ["BattlePets"] = "battlepet"     -- BattlePets contain battle pet data
    }

    -- Walk path in reverse for explicit type markers
    for i = #path, 1, -1 do
        local entityType = typeMarkers[path[i]]
        if entityType then
            return entityType
        end
    end

    -- Check first component as fallback
    local entityType = typeMarkers[path[1]]
    if entityType then
        return entityType
    end

    -- Log warning if we couldn't determine type
    self:Warn(
        "DetermineEntryType: Could not determine entity type from path: %s (available markers: %s)",
            table.concat(path, "."), table.concat(TableUtils.Keys(typeMarkers), ", "))
    return nil
end

-- Add methods to configure the walker
function DataWalker:SetMaxDepth(depth)
    self.maxDepth = depth
end

function DataWalker:AddSkipPath(path)
    self.skipPaths[path] = true
end

function DataWalker:RemoveSkipPath(path)
    self.skipPaths[path] = nil
end

function DataWalker:ClearSkipPaths()
    wipe(self.skipPaths)
end

-- ~~~~~~~~~~ ERROR REPORTING ============================

--- Schedule error reporting with a 5-second delay
function DataWalker:ScheduleErrorReport()
    -- Cancel any existing timer
    if self.errorReportTimer then
        self:CancelTimer(self.errorReportTimer)
    end

    -- Schedule error report in 5 seconds
    self.errorReportTimer = self:ScheduleTimer(function()
        self:ReportErrors()
        self.errorReportTimer = nil
    end, 5)

    self:Debug("Error reporting scheduled for 5 seconds from now")
end

--- Report processing errors and statistics
function DataWalker:ReportErrors()
    if not self.context or not self.context.stats then
        return
    end

    local stats = self.context.stats
    local errors = stats.errors

    -- Only report if there are actual errors
    if errors.count == 0 then
        self:Info("DataWalker: No errors encountered during processing")
        return
    end

    -- Print error summary header
    self:Info("=== DataWalker Error Report ===")
    self:Info(format("Total Errors: %d", errors.count))
    self:Info(format("Total Processed: %d", stats.processed))
    self:Info(format("Success Rate: %.2f%%", ((stats.processed - errors.count) / stats.processed) * 100))

    -- Group errors by type for better analysis
    local errorTypes = {}
    for _, errorDetail in ipairs(errors.details) do
        local errorType = errorDetail.error:match("^([^:]+)") or "Unknown"
        errorTypes[errorType] = errorTypes[errorType] or { count = 0, examples = {} }
        errorTypes[errorType].count = errorTypes[errorType].count + 1

        -- Store a few examples of each error type
        if #errorTypes[errorType].examples < 3 then
            table.insert(errorTypes[errorType].examples, errorDetail)
        end
    end

    -- Report error types
    self:Info("Error Breakdown:")
    for errorType, data in pairs(errorTypes) do
        self:Info(format("  %s: %d occurrences", errorType, data.count))

        -- Show examples of this error type
        for i, example in ipairs(data.examples) do
            local pathStr = example.path and example.path or "unknown"
            local context = format("Path: %s", pathStr)
            if example.depth then
                context = context .. format(", Depth: %d", example.depth)
            end
            if example.nodeType then
                context = context .. format(", NodeType: %s", example.nodeType)
            end
            if example.type then
                context = context .. format(", EntityType: %s", example.type)
            end
            if example.id then
                context = context .. format(", ID: %s", tostring(example.id))
            end

            self:Info(format("    Example %d: %s", i, context))
            self:Info(format("    Error: %s", example.error))
        end
    end

    -- Report skipped paths if any
    if stats.skipped.count > 0 then
        self:Info(format("Skipped Paths: %d", stats.skipped.count))
        if #stats.skipped.paths > 0 then
            self:Info("Sample skipped paths:")
            for i = 1, math.min(5, #stats.skipped.paths) do
                self:Info(format("  %s", stats.skipped.paths[i]))
            end
            if #stats.skipped.paths > 5 then
                self:Info(format("  ... and %d more", #stats.skipped.paths - 5))
            end
        end
    end

    -- Report reprocess attempts if any
    if stats.reprocessAttempts.count > 0 then
        self:Info(format("Reprocess Attempts: %d", stats.reprocessAttempts.count))
        if #stats.reprocessAttempts.details > 0 then
            self:Info("Sample reprocess details:")
            for i = 1, math.min(3, #stats.reprocessAttempts.details) do
                local detail = stats.reprocessAttempts.details[i]
                self:Info(format("  %s ID %s: %s", detail.type, tostring(detail.id), detail.reason))
            end
            if #stats.reprocessAttempts.details > 3 then
                self:Info(format("  ... and %d more", #stats.reprocessAttempts.details - 3))
            end
        end
    end

    self:Info("=== End Error Report ===")
end

--- Get error statistics for external access
function DataWalker:GetErrorStats()
    if not self.context or not self.context.stats then
        return {
            processed = 0,
            errors = { count = 0, details = {} },
            skipped = { count = 0, paths = {} },
            reprocessAttempts = { count = 0, details = {} }
        }
    end

    return self.context.stats
end

--- Check if there were any errors during processing
function DataWalker:HasErrors()
    if not self.context or not self.context.stats then
        return false
    end

    return self.context.stats.errors.count > 0
end

--- Get error count
function DataWalker:GetErrorCount()
    if not self.context or not self.context.stats then
        return 0
    end

    return self.context.stats.errors.count
end

--- Manually trigger error report (useful for debugging)
function DataWalker:TriggerErrorReport()
    if NAG:IsDevModeEnabled() then
        self:Info("Manual error report triggered")
        self:ReportErrors()
    else
        self:Info("Error reporting only available in dev mode")
    end
end

--- Get processing statistics summary
function DataWalker:GetProcessingStats()
    if not self.context or not self.context.stats then
        return {
            processed = 0,
            errors = 0,
            skipped = 0,
            reprocessAttempts = 0
        }
    end

    local stats = self.context.stats
    return {
        processed = stats.processed,
        errors = stats.errors.count,
        skipped = stats.skipped.count,
        reprocessAttempts = stats.reprocessAttempts.count
    }
end
