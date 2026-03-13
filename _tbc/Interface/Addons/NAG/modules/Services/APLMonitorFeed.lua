--- @module "NAG.APLMonitorFeed"
--- Central instrumentation service for APL Monitor
---
--- Hooks into both compiled rotation and tree-based evaluation paths to capture
--- real-time AST node evaluation data. Provides foundation for debugging and
--- visualization of rotation logic execution.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS ~~~~~~~~~~
local TableUtils = ns.TableUtils
local ASTCore = ns.ASTCore
local ASTValue = ns.ASTValue
local ASTAction = ns.ASTAction
local SpecCompat

-- Lua APIs (WoW optimized where available)
local format = string.format
local type = type
local tostring = tostring
local tinsert = tinsert
local wipe = wipe
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitPowerType = _G.UnitPowerType
local debugprofilestop = debugprofilestop

-- ~~~~~~~~~~ MODULE DEFAULTS ~~~~~~~~~~
local defaults = {
    global = {
        enabled = false, -- Disabled by default (very heavy per-tick; enable only when actively debugging)
        evaluationMode = "compiled", -- "compiled" or "tree"

        -- Performance settings
        enableProfiling = true,
        throttleMessages = true, -- Batch node evaluations per frame
         maxNodesPerFrame = 100, -- Limit nodes recorded per frame
    }
}

--- @class APLMonitorFeed: CoreModule
local APLMonitorFeed = NAG:CreateModule("APLMonitorFeed", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,

    defaultState = {
        -- Active instrumentation state
        active = false,
        evaluationMode = "compiled",

        -- Current evaluation tick
        currentTick = {
            tickId = 0,
            startTime = 0,
            nodes = {},
            nodeCount = 0,
            context = {},
            firstTrueAction = nil,
            currentActionList = "default",
            currentDepth = 0,
        },

        -- Node ID mapping cache
        nodeIdCache = {}, -- rotationHash -> { nodeId -> nodeInfo }
        currentRotationHash = nil,

        -- Handler call tracking (compiled mode)
        handlerCallStack = {},
        handlerCallSequence = {},

        -- Performance tracking
        totalEvaluations = 0,
        totalNodes = 0,
        totalDuration = 0,

        -- Message throttling
        pendingMessages = {},
        lastMessageTime = 0,
    },

    -- Debug categories
    debugCategories = {
        ns.DEBUG_CATEGORIES.DEBUG,
        ns.DEBUG_CATEGORIES.FEATURES
    }
})
local module = APLMonitorFeed
ns.APLMonitorFeed = APLMonitorFeed

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~

function APLMonitorFeed:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Initialize state
    self:Trace("APLMonitorFeed: Initialized")
end

function APLMonitorFeed:ModuleEnable()
    -- Register for rotation change events to invalidate cache
    self:RegisterMessage("NAG_ROTATION_CHANGED", "OnRotationChanged")

    -- Only start instrumentation if explicitly enabled.
    -- Otherwise this service should remain inert (it can allocate heavily per tick: snapshot tables, TableUtils.Copy, etc).
    self.state.active = false
    if self.db and self.db.global and self.db.global.enabled then
        self:StartInstrumentation(self.db.global.evaluationMode)
    end

    self:Debug("APLMonitorFeed: Enabled")
end

function APLMonitorFeed:ModuleDisable()
    -- Clean up state
    self:StopInstrumentation()
    wipe(self.state.nodeIdCache)
    wipe(self.state.handlerCallStack)
    wipe(self.state.handlerCallSequence)

    self:Debug("APLMonitorFeed: Disabled")
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~

--- Start instrumentation for evaluation tracking
--- @param evaluationMode string "compiled" or "tree"
function APLMonitorFeed:StartInstrumentation(evaluationMode)
    if not self:IsEnabled() then
        self:Warn("StartInstrumentation: Module not enabled")
        return
    end

    self.state.active = true
    self.state.evaluationMode = evaluationMode or "compiled"

    -- For compiled mode, ensure APLEvaluationCache handlers are wrapped
    if self.state.evaluationMode == "compiled" then
        local APLEvaluationCache = NAG:GetModule("APLEvaluationCache", true)
        if APLEvaluationCache then
            -- Force handler wrapping even if cache is disabled
            if not APLEvaluationCache.state.wrappingComplete then
                self:Debug("StartInstrumentation: Wrapping handlers for monitoring")
                APLEvaluationCache:WrapValueHandlers()
            end
        else
            self:Warn("StartInstrumentation: APLEvaluationCache not available for compiled mode")
        end
    end

    -- Reset tick state
    self:BeginTick()

    self:Debug("StartInstrumentation: Started in %s mode", self.state.evaluationMode)
end

--- Stop instrumentation
function APLMonitorFeed:StopInstrumentation()
    if not self.state.active then
        return
    end

    self.state.active = false

    -- Complete any pending tick
    if self.state.currentTick.tickId > 0 then
        self:EndTick()
    end

    self:Debug("StopInstrumentation: Stopped")
end

--- Check if instrumentation is currently active
--- @return boolean active True if instrumentation is running
function APLMonitorFeed:IsInstrumentationActive()
    return self.state.active
end

--- Get current evaluation mode
--- @return string mode "compiled" or "tree"
function APLMonitorFeed:GetEvaluationMode()
    return self.state.evaluationMode
end

-- ~~~~~~~~~~ TICK MANAGEMENT ~~~~~~~~~~

--- Begin a new evaluation tick
function APLMonitorFeed:BeginTick()
    local tick = self.state.currentTick

    -- Complete previous tick if needed
    if tick.tickId > 0 then
        self:EndTick()
    end

    -- Initialize new tick
    tick.tickId = self.state.totalEvaluations + 1
    tick.startTime = debugprofilestop()
    wipe(tick.nodes)
    tick.nodeCount = 0
    wipe(tick.context)
    tick.firstTrueAction = nil
    tick.currentActionList = "default"
    tick.currentDepth = 0

    -- Capture context
    self:CaptureEvaluationContext(tick.context)

    -- Reset handler tracking for compiled mode
    wipe(self.state.handlerCallStack)
    wipe(self.state.handlerCallSequence)

    self:Trace("BeginTick: Started tick %d", tick.tickId)
end

--- End the current evaluation tick and emit messages
function APLMonitorFeed:EndTick()
    local tick = self.state.currentTick

    if tick.tickId == 0 then
        return -- No active tick
    end

    -- Calculate total duration
    local duration = debugprofilestop() - tick.startTime
    tick.totalDuration = duration

    -- Update statistics
    self.state.totalEvaluations = self.state.totalEvaluations + 1
    self.state.totalNodes = self.state.totalNodes + tick.nodeCount
    self.state.totalDuration = self.state.totalDuration + duration

    -- Create snapshot for message
    local snapshot = {
        tickId = tick.tickId,
        timestamp = GetTime(),
        evaluationMode = self.state.evaluationMode,
        context = TableUtils.Copy(tick.context),
        nodes = TableUtils.Copy(tick.nodes),
        firstTrueAction = tick.firstTrueAction,
        totalDuration = duration,
        nodeCount = tick.nodeCount,
    }

    -- Emit tick complete message
    self:FireMessage("APLMonitor_TickComplete", snapshot)

    self:Trace("EndTick: Completed tick %d (%.3fms, %d nodes)",
        tick.tickId, duration, tick.nodeCount)

    -- Reset tick ID to indicate completion
    tick.tickId = 0
end

--- Capture current game context for evaluation snapshot
--- @param context table Table to populate with context data
function APLMonitorFeed:CaptureEvaluationContext(context)
    -- Target information
    if UnitExists("target") then
        context.targetGUID = UnitGUID("target")
        context.targetName = UnitName("target")
        context.targetHealth = UnitHealth("target")
        context.targetHealthMax = UnitHealthMax("target")
        context.targetHealthPercent = (context.targetHealth / context.targetHealthMax) * 100
    else
        context.targetGUID = nil
        context.targetName = nil
        context.targetHealth = 0
        context.targetHealthMax = 0
        context.targetHealthPercent = 0
    end

    -- Player information
    context.playerHealth = UnitHealth("player")
    context.playerHealthMax = UnitHealthMax("player")
    context.playerHealthPercent = (context.playerHealth / context.playerHealthMax) * 100

    -- Power information (class-specific resource)
    local powerType = UnitPowerType("player")
    context.playerPower = UnitPower("player", powerType)
    context.playerPowerMax = UnitPowerMax("player", powerType)
    context.playerPowerType = powerType

    -- Combat state
    context.inCombat = UnitAffectingCombat("player")

    -- Time
    context.gameTime = GetTime()

    -- Spec
    context.specIndex = SpecCompat:GetCurrentSpecIndex()
end

-- ~~~~~~~~~~ COMPILED MODE INSTRUMENTATION ~~~~~~~~~~

--- Record a handler function call (compiled rotation mode)
--- @param funcName string Handler function name (e.g., "Cast", "AuraIsActive")
--- @param args table Function arguments
--- @param result any Function return value
--- @param duration number Execution time in milliseconds
function APLMonitorFeed:RecordHandlerCall(funcName, args, result, duration)
    if not self.state.active or self.state.evaluationMode ~= "compiled" then
        return
    end

    local tick = self.state.currentTick

    -- Check node limit per frame
    if tick.nodeCount >= self.db.global.maxNodesPerFrame then
        return
    end

    -- Record call in sequence
    local callRecord = {
        funcName = funcName,
        args = TableUtils.Copy(args),
        result = result,
        duration = duration,
        timestamp = debugprofilestop(),
    }

    tinsert(self.state.handlerCallSequence, callRecord)

    -- Try to infer node ID from call pattern
    local nodeId = self:InferNodeIdFromHandlerCall(funcName, args)

    if nodeId then
        -- Record as node evaluation
        self:RecordNodeEvaluation(nodeId, "HANDLER", result, duration, {
            funcName = funcName,
            args = args,
        })
    end

    self:Trace("RecordHandlerCall: %s(%s) -> %s (%.3fms)", funcName, tostring(args[1]), tostring(result), duration)
end

--- Infer AST node ID from handler call pattern
--- @param funcName string Handler function name
--- @param args table Function arguments
--- @return string|nil nodeId Inferred node ID or nil
function APLMonitorFeed:InferNodeIdFromHandlerCall(funcName, args)
    -- This is a simplified inference - in practice, we'd need more sophisticated
    -- call stack analysis to map handler calls to specific AST nodes

    -- For now, use handler name + primary argument as pseudo-node ID
    if not args or #args == 0 then
        return nil
    end

    local primaryArg = args[1]
    if type(primaryArg) == "number" then
        -- Likely a spell/item ID
        return format("handler_%s_%d", funcName, primaryArg)
    end

    return nil
end

-- ~~~~~~~~~~ TREE MODE INSTRUMENTATION ~~~~~~~~~~

--- Begin tracking a node evaluation (tree-based mode)
--- @param nodeId string Stable node identifier
--- @param nodeType string Node type ("ACTION", "VALUE", etc.)
--- @param nodeData table AST node data
function APLMonitorFeed:BeginNodeEvaluation(nodeId, nodeType, nodeData)
    if not self.state.active or self.state.evaluationMode ~= "tree" then
        return
    end

    -- Push to call stack
    tinsert(self.state.handlerCallStack, {
        nodeId = nodeId,
        nodeType = nodeType,
        nodeData = nodeData,
        startTime = debugprofilestop(),
    })

    self:Trace("BeginNodeEvaluation: %s (%s)", nodeId, nodeType)
end

--- End tracking a node evaluation (tree-based mode)
--- @param nodeId string Stable node identifier
--- @param result any Evaluation result
--- @param duration number Execution time in milliseconds
function APLMonitorFeed:EndNodeEvaluation(nodeId, result, duration)
    if not self.state.active or self.state.evaluationMode ~= "tree" then
        return
    end

    -- Pop from call stack and verify
    local stackEntry = #self.state.handlerCallStack > 0
        and self.state.handlerCallStack[#self.state.handlerCallStack]
        or nil

    if stackEntry and stackEntry.nodeId == nodeId then
        table.remove(self.state.handlerCallStack)

        -- Record node evaluation
        self:RecordNodeEvaluation(
            nodeId,
            stackEntry.nodeType,
            result,
            duration,
            stackEntry.nodeData
        )
    else
        self:Warn("EndNodeEvaluation: Stack mismatch for %s", nodeId)
    end

    self:Trace("EndNodeEvaluation: %s -> %s (%.3fms)", nodeId, tostring(result), duration)
end

-- ~~~~~~~~~~ ACTION LIST DEPTH TRACKING ~~~~~~~~~~

--- Enter an action list (increases depth)
--- @param actionListName string Name of the action list being entered
function APLMonitorFeed:EnterActionList(actionListName)
    if not self.state.active then return end

    local tick = self.state.currentTick
    tick.currentDepth = (tick.currentDepth or 0) + 1
    tick.currentActionList = actionListName or "unnamed"

    self:Trace("EnterActionList: %s (depth=%d)", tick.currentActionList, tick.currentDepth)
end

--- Exit an action list (decreases depth)
--- @param actionListName string|nil Name of the action list being exited
function APLMonitorFeed:ExitActionList(actionListName)
    if not self.state.active then return end

    local tick = self.state.currentTick
    tick.currentDepth = max(0, (tick.currentDepth or 1) - 1)

    -- Reset to default if back at root level
    if tick.currentDepth == 0 then
        tick.currentActionList = "default"
    end

    self:Trace("ExitActionList: %s (depth=%d)", actionListName or "unnamed", tick.currentDepth)
end

--- Get current action list depth
--- @return number depth Current nesting depth
function APLMonitorFeed:GetCurrentDepth()
    return self.state.currentTick.currentDepth or 0
end

--- Get current action list name
--- @return string actionList Current action list name
function APLMonitorFeed:GetCurrentActionList()
    return self.state.currentTick.currentActionList or "default"
end

-- ~~~~~~~~~~ NODE RECORDING ~~~~~~~~~~

--- Record a completed node evaluation
--- @param nodeId string Stable node identifier
--- @param nodeType string Node type
--- @param result any Evaluation result
--- @param duration number Execution time in milliseconds
--- @param nodeData table Additional node data
function APLMonitorFeed:RecordNodeEvaluation(nodeId, nodeType, result, duration, nodeData)
    local tick = self.state.currentTick

    -- Check node limit
    if tick.nodeCount >= self.db.global.maxNodesPerFrame then
        self:Warn("RecordNodeEvaluation: Node limit reached for tick %d", tick.tickId)
        return
    end

    -- Create node record with depth and action list info
    local nodeRecord = {
        nodeId = nodeId,
        nodeType = nodeType,
        result = result,
        duration = duration,
        timestamp = debugprofilestop(),
        data = nodeData,
        depth = tick.currentDepth or 0,
        actionList = tick.currentActionList or "default",
    }

    -- Add to tick nodes
    tinsert(tick.nodes, nodeRecord)
    tick.nodeCount = tick.nodeCount + 1

    -- Track first true action
    if result == true and nodeType == "ACTION" and not tick.firstTrueAction then
        tick.firstTrueAction = nodeId
    end

    -- Emit individual node message if not throttling
    if not self.db.global.throttleMessages then
        self:FireMessage("APLMonitor_NodeEvaluated", {
            tickId = tick.tickId,
            node = nodeRecord,
        })
    end
end

-- ~~~~~~~~~~ NODE ID GENERATION ~~~~~~~~~~

--- Generate stable node IDs from AST structure
--- @param ast table AST root node
--- @param rotationString string Rotation string for cache key
--- @return table nodeMap Map of nodeId -> nodeInfo
function APLMonitorFeed:GenerateNodeIds(ast, rotationString)
    -- Generate cache key from rotation string
    local rotationHash = self:HashRotationString(rotationString)

    -- Check cache
    if self.state.nodeIdCache[rotationHash] then
        self:Debug("GenerateNodeIds: Using cached node IDs for rotation")
        return self.state.nodeIdCache[rotationHash]
    end

    -- Generate new node ID map
    local nodeMap = {}
    self:WalkASTForNodeIds(ast, nodeMap, "root", nil)

    -- Cache result
    self.state.nodeIdCache[rotationHash] = nodeMap
    self.state.currentRotationHash = rotationHash

    self:Debug("GenerateNodeIds: Generated %d node IDs", TableUtils.Size(nodeMap))

    return nodeMap
end

--- Walk AST tree and assign stable node IDs
--- @param node table AST node
--- @param nodeMap table Map to populate with node IDs
--- @param path string Current path in tree
--- @param parentId string|nil Parent node ID
function APLMonitorFeed:WalkASTForNodeIds(node, nodeMap, path, parentId)
    if not node or type(node) ~= "table" then
        return
    end

    local nodeId = path

    -- Store node info
    nodeMap[nodeId] = {
        nodeId = nodeId,
        nodeType = node.type,
        path = path,
        parentId = parentId,
        children = {},
        astNode = node,
    }

    -- Add to parent's children list
    if parentId and nodeMap[parentId] then
        tinsert(nodeMap[parentId].children, nodeId)
    end

    -- Walk children based on node type
    if node.type == ASTCore.NodeType.ACTION then
        -- Walk condition
        if node.condition then
            self:WalkASTForNodeIds(node.condition, nodeMap, path .. "_cond", nodeId)
        end

        -- Walk nested actions (for sequences)
        local actionData = ASTAction.GetActionData(node)
        if actionData then
            if actionData.actions then
                for i, action in ipairs(actionData.actions) do
                    self:WalkASTForNodeIds(action, nodeMap, format("%s_act_%d", path, i), nodeId)
                end
            end
            if actionData.inner_action then
                self:WalkASTForNodeIds(actionData.inner_action, nodeMap, path .. "_inner", nodeId)
            end
        end

    elseif node.type == ASTCore.NodeType.VALUE then
        local valueData = ASTValue.GetValueData(node)
        if valueData then
            -- Logical operators: and, or
            if valueData.vals then
                for i, val in ipairs(valueData.vals) do
                    self:WalkASTForNodeIds(val, nodeMap, format("%s_val_%d", path, i), nodeId)
                end
            end

            -- NOT operator
            if valueData.val then
                self:WalkASTForNodeIds(valueData.val, nodeMap, path .. "_not", nodeId)
            end

            -- Binary operators: cmp, math
            if valueData.lhs then
                self:WalkASTForNodeIds(valueData.lhs, nodeMap, path .. "_lhs", nodeId)
            end
            if valueData.rhs then
                self:WalkASTForNodeIds(valueData.rhs, nodeMap, path .. "_rhs", nodeId)
            end
        end

    elseif node.type == ASTCore.NodeType.ROTATION then
        -- Walk priority list
        if node.priority_list then
            for i, action in ipairs(node.priority_list) do
                self:WalkASTForNodeIds(action, nodeMap, format("clause_%d", i), nodeId)
            end
        end
    end
end

--- Generate hash for rotation string (for caching)
--- @param rotationString string Rotation string
--- @return string hash Simple hash
function APLMonitorFeed:HashRotationString(rotationString)
    -- Simple hash: length + first 100 chars + last 100 chars
    local len = #rotationString
    local start = rotationString:sub(1, 100)
    local ending = len > 100 and rotationString:sub(-100) or ""
    return format("%d_%s_%s", len, start:gsub("%W", ""), ending:gsub("%W", ""))
end

-- ~~~~~~~~~~ MESSAGE HANDLING ~~~~~~~~~~

--- Fire a message (with optional throttling)
--- @param messageName string Message name
--- @param payload table Message payload
function APLMonitorFeed:FireMessage(messageName, payload)
    if self.db.global.throttleMessages and messageName == "APLMonitor_NodeEvaluated" then
        -- Queue for batch delivery
        tinsert(self.state.pendingMessages, {
            message = messageName,
            payload = payload,
        })
    else
        -- Immediate delivery
        self:SendMessage(messageName, payload)
    end
end

--- Flush pending messages (called at end of frame)
function APLMonitorFeed:FlushMessages()
    if #self.state.pendingMessages == 0 then
        return
    end

    -- Send all pending messages
    for _, msg in ipairs(self.state.pendingMessages) do
        self:SendMessage(msg.message, msg.payload)
    end

    wipe(self.state.pendingMessages)
end

--- Handle rotation change event
--- @param message string The message name
--- @param payload table|nil Optional payload with rotation details
function APLMonitorFeed:OnRotationChanged(message, payload)
    -- Invalidate node ID cache
    wipe(self.state.nodeIdCache)
    self.state.currentRotationHash = nil

    self:Debug("OnRotationChanged: Node ID cache invalidated (action: %s, dataChanged: %s, selectionChanged: %s)",
        payload and payload.action or "unknown",
        payload and tostring(payload.dataChanged) or "unknown",
        payload and tostring(payload.selectionChanged) or "unknown")
end

-- ~~~~~~~~~~ STATISTICS ~~~~~~~~~~

--- Get instrumentation statistics
--- @return table stats Statistics summary
function APLMonitorFeed:GetStatistics()
    return {
        totalEvaluations = self.state.totalEvaluations,
        totalNodes = self.state.totalNodes,
        totalDuration = self.state.totalDuration,
        averageDuration = self.state.totalEvaluations > 0
            and (self.state.totalDuration / self.state.totalEvaluations)
            or 0,
        averageNodesPerTick = self.state.totalEvaluations > 0
            and (self.state.totalNodes / self.state.totalEvaluations)
            or 0,
        cacheSize = TableUtils.Size(self.state.nodeIdCache),
    }
end

--- Reset statistics
function APLMonitorFeed:ResetStatistics()
    self.state.totalEvaluations = 0
    self.state.totalNodes = 0
    self.state.totalDuration = 0

    self:Debug("ResetStatistics: Statistics reset")
end

