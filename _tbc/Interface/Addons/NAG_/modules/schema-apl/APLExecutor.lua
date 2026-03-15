--- @module "NAG.APLExecutor"
--- Executes the parsed APL AST for tree-based rotation evaluation.
--- This module provides tree-based execution for both APL format and NAG rotation strings.
---
local _, ns = ...
local GetTime = _G.GetTime
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitStat = _G.UnitStat
local UnitLevel = _G.UnitLevel
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type Types
local Types

--- @type SchemaAccessor
local SchemaAccessor


local TableUtils = ns.TableUtils

-- Proto-compatible AST system
local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local ASTVisitor = ns.ASTVisitor
local tinsert = tinsert
local wipe = wipe
local concat = concat

--- @class APLExecutor
local APLExecutor = NAG:CreateModule("APLExecutor", nil, {
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.PROCESSORS
    }
})
local module = APLExecutor
ns.APLExecutor = APLExecutor

--[[ Dynamically generate Evaluate handlers for all APLValue types using SchemaAccessor metadata
if SchemaAccessor and SchemaAccessor.GetAllValuesWithMetadata then
    local valueTypes = SchemaAccessor:GetAllValuesWithMetadata()
    for _, valueMeta in ipairs(valueTypes) do
        local snakeName = valueMeta.name -- e.g., "all_trinket_stat_procs_active"
        local handlerName = "Evaluate" .. snakeName:gsub("_(%w)", function(c) return c:upper() end):gsub("^%l", string.upper)
        if not APLExecutor[handlerName] then
            APLExecutor[handlerName] = function(self, valueNode)
                self:Warn("[AUTO-GEN] Handler '%s' not implemented. Metadata: %s", handlerName, TableUtils and TableUtils.ToString(valueMeta) or "(no TableUtils)")
                -- Return a safe default based on metadata (if possible)
                if valueMeta.defaults then
                    for k, v in pairs(valueMeta.defaults) do
                        return v -- Return the first default value found
                    end
                end
                NAG:Warn("[APLExecutor] FALLBACK TRACKING: Using safe default fallback (false) for unimplemented handler '%s' (no defaults found in metadata)", handlerName)
                return false -- Fallback safe default
            end
        end
    end
end
]]

function APLExecutor:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    Types = NAG:GetModule("Types")
    SchemaAccessor = NAG:GetModule("SchemaAccessor")

    -- Initialization logic (none needed yet)
end

function APLExecutor:ModuleEnable()
end

function APLExecutor:ModuleDisable()
end

-- ============================ SCHEMA AVAILABILITY DETECTION ============================

--- Check if schema-aware execution is available
--- @return boolean True if SchemaAccessor exists and is loaded
function APLExecutor:IsSchemaAvailable()
    if not SchemaAccessor then
        return false
    end
    -- Check if schema is loaded (SchemaAccessor.loaded indicates successful initialization)
    return SchemaAccessor.loaded == true
end

--- Determine if visitor pattern execution should be used
--- Checks global toggle first, then schema availability, then falls back to version detection
--- @return boolean True if visitor pattern should be used, false for function-based execution
function APLExecutor:ShouldUseVisitorPattern()
    -- Check global toggle first (allows disabling until implementation is complete)
    if not ns.USE_VISITOR_PATTERN then
        return false
    end

    -- Primary check: schema availability (most reliable)
    if self:IsSchemaAvailable() then
        return true
    end

    -- Fallback: check version (only TBC doesn't have schema)
    local Version = NAG:GetModule("Version", true)
    if Version then
        local expansion = Version:GetExpansion()
        -- Only TBC doesn't have schema - use function-based execution
        if expansion == Version.EXPANSIONS.TBC then
            return false
        end
    end

    -- Default: try schema-aware if available (may be nil/not loaded yet)
    return self:IsSchemaAvailable()
end

-- ============================ VISITOR-BASED EXECUTION ============================

--- Extract spellId from an executed action node
--- @param actionNode table Proto AST action node
--- @return number|nil spellId The spell ID if found, nil otherwise
local function ExtractSpellIdFromAction(actionNode)
    if not actionNode or type(actionNode) ~= "table" then
        return nil
    end

    local actionData = ASTAction.GetActionData(actionNode)
    if not actionData then
        return nil
    end

    local FieldFormatConverter = ns.FieldFormatConverter
    if not FieldFormatConverter then
        return nil
    end

    -- Try to extract spell_id or item_id from action data
    if actionData.spell_id then
        return FieldFormatConverter:ExtractActionID(actionData.spell_id)
    elseif actionData.item_id then
        return FieldFormatConverter:ExtractActionID(actionData.item_id)
    end

    return nil
end

--- Create an execution visitor for AST traversal
--- @param callbacks table|nil Optional callbacks: onActionExecuted(spellId, result)
--- @return table Visitor instance for ASTVisitor.Walk
function APLExecutor:CreateExecutionVisitor(callbacks)
    callbacks = callbacks or {}
    local selfRef = self
    local executedSpellId = nil -- Track spellId of executed action

    return ASTVisitor.Create({
        visitRotation = function(self, rotationNode, context)
            -- Delegate to ExecutePriorityList for consistent behavior
            -- ExecutePriorityList handles StrictSequence checks and priority list execution
            local priorityList = rotationNode.priority_list or {}
            local result = selfRef:ExecutePriorityList(priorityList)

            -- Notify callback if an action succeeded
            if result and executedSpellId and callbacks.onActionExecuted then
                callbacks.onActionExecuted(executedSpellId, result)
            end

            return result
        end,

        visitAction = function(self, actionNode, context)
            -- Delegate to existing ExecuteProtoNode
            local result = selfRef:ExecuteProtoNode(actionNode)

            -- Track spellId if action succeeded
            if result then
                local spellId = ExtractSpellIdFromAction(actionNode)
                if spellId then
                    executedSpellId = spellId
                end
            end

            return result
        end,

        visitValue = function(self, valueNode, context)
            -- Delegate to existing EvaluateProtoValue
            return selfRef:EvaluateProtoValue(valueNode)
        end,

        -- Default handlers for other node types (no-op)
        visitListItem = function(self, listItem, context) end,
        visitGroup = function(self, group, context) end,
        visitPrepullAction = function(self, prepullAction, context) end,
        visitNode = function(self, node, context) end,
    })
end

-- ============================ PRIORITY LIST EXECUTION ============================

function APLExecutor:ExecutePriorityList(aplList)
    self:Info("ExecutePriorityList: Executing priority list (%d actions)", aplList and #aplList or 0)
    if not aplList or type(aplList) ~= "table" then
        self:Error("ExecutePriorityList: Invalid APL list provided.")
        return
    end

    -- CRITICAL: Check for active StrictSequence first - if one is active, block ALL other actions
    if NAG.RightSlots and NAG.RightSlots.activeSequence then
        local activeSequenceName = NAG.RightSlots.activeSequence
        local sequenceType = NAG.RightSlots.sequenceType or "unknown"

        if self.debug then
            self:Debug(
                "🔍 ExecutePriorityList: Active sequence detected - name='%s', type='%s', forceMainActive=%s",
                activeSequenceName, sequenceType, tostring(NAG.RightSlots.forceMainActive))
        end

        -- Check if this is a StrictSequence (not a regular sequence)
        if NAG.strictSequenceSpells and NAG.strictSequenceSpells[activeSequenceName] then
            -- Check if this sequence is set to forceMain (blocking) or not (visual only)
            local forceMainActive = NAG.RightSlots.forceMainActive
            if forceMainActive then
                self:Info("Active StrictSequence '%s' detected with forceMain=true, blocking all other actions",
                    activeSequenceName)
                return true -- Block all other actions
            else
                self:Info(
                    "Active StrictSequence '%s' detected with forceMain=false (visual only), allowing other actions",
                    activeSequenceName)
                -- Continue with APL execution
            end
        else
            -- For regular sequences, check if it's blocking (forceMain == true) or just visual (forceMain == false)
            local forceMainActive = NAG.RightSlots.forceMainActive
            if forceMainActive then
                self:Info("Active regular sequence '%s' detected with forceMain=true, blocking all other actions",
                    activeSequenceName)
                return true -- Block all other actions
            else
                self:Info(
                    "Active regular sequence '%s' detected with forceMain=false (visual only), allowing other actions",
                    activeSequenceName)
                -- Continue with APL execution
            end
        end
    end

    if self.debug then self:Info("Starting APL execution with %d actions.", #aplList) end
    for i, listItem in ipairs(aplList) do
        -- listItem is a plain table with .action field containing the proto AST action node
        -- We need to pass listItem.action to ExecuteNode, not listItem itself
        if listItem.action then
            local result = self:ExecuteNode(listItem.action)
            -- If an action returns true, it was successful and should block lower priority actions
            if result then
                self:Info("Action %d succeeded, blocking remaining %d actions.", i, #aplList - i)
                return true
            end
        else
            self:Warn("ExecutePriorityList: listItem %d has no action field", i)
        end
    end
    if self.debug then self:Info("Completed APL execution of %d actions, none succeeded.", #aplList) end
    return false
end

local CACHED_ACTION_KEYS = {}
local CACHED_ACTION_COPY = {}

--- Executes a single AST node, handling conditions and dynamic dispatch.
--- Supports both legacy AST and proto-compatible AST formats.
--- @param node table The AST node to execute (legacy or proto)
--- @return boolean True if the action was successful and should block lower priority actions
function APLExecutor:ExecuteNode(node)
    if not node or type(node) ~= "table" then
        self:Error("ExecuteNode: Invalid node provided.")
        return false
    end

    -- Detect and route to appropriate execution path
    if node._protoAST then
        -- Legacy-wrapped proto AST
        return self:ExecuteProtoNode(node._protoAST)
    elseif node.type == ASTCore.NodeType.ACTION and node.action then
        -- Direct proto AST node (plain table with type="action" and action field)
        return self:ExecuteProtoNode(node)
    elseif node.action then
        -- Legacy AST format detected - should not happen in production code
        self:Error(format("ExecuteNode: Legacy format detected - should be proto AST. Node has .action field but is not proto AST. Context: ExecuteNode"))
        return false
    else
        self:Error("ExecuteNode: Unknown node format (no .action field and not proto AST).")
        return false
    end
end

--- Execute a legacy AST node (original implementation)
--- @param node table Legacy AST node
--- @return boolean True if successful
function APLExecutor:ExecuteLegacyNode(node)
    if not node or type(node) ~= "table" or not node.action then
        self:Error("ExecuteLegacyNode: Invalid node provided.")
        return false
    end

    -- PERFORMANCE: Reuse cached table instead of creating new one
    wipe(CACHED_ACTION_KEYS)
    for k in pairs(node.action) do
        tinsert(CACHED_ACTION_KEYS, k)
    end
    if self.debug then self:Info("Executing node actions: %s", concat(CACHED_ACTION_KEYS, ", ")) end

    -- Handle condition logic
    if node.action.condition then
        local conditionResult = self:EvaluateCondition(node.action.condition)
        if conditionResult then
            -- PERFORMANCE: Reuse cached table instead of creating new one
            wipe(CACHED_ACTION_COPY)
            for k, v in pairs(node.action) do
                if k ~= "condition" then CACHED_ACTION_COPY[k] = v end
            end
            for actionKey, actionValue in pairs(CACHED_ACTION_COPY) do
                if actionValue then
                    local handlerName = actionKey:gsub("^%l", string.upper)
                    if NAG[handlerName] then
                        local result = NAG[handlerName](NAG, actionValue)
                        self:Trace("Action %s returned: %s", handlerName, tostring(result))
                        return result and true or false
                    else
                        self:Error(format("No handler for action: %s", handlerName))
                        return false
                    end
                end
            end
        end
        return false
    end
    -- Normal dynamic dispatch for non-condition actions
    for actionKey, actionValue in pairs(node.action) do
        if actionValue then
            local handlerName = actionKey:gsub("^%l", string.upper)
            if NAG[handlerName] then
                local result = NAG[handlerName](NAG, actionValue)
                self:Trace("Action %s returned: %s", handlerName, tostring(result))
                return result and true or false
            else
                self:Error(format("No handler for action: %s", handlerName))
                return false
            end
        end
    end
    self:Info("ExecuteLegacyNode: Unhandled action type")
    return false
end

-- ============================ PROTO AST EXECUTION ============================

--- Execute a proto AST node
--- @param protoNode ASTNode Proto AST node
--- @return boolean True if successful
function APLExecutor:ExecuteProtoNode(protoNode)
    if not protoNode or type(protoNode) ~= "table" then
        self:Warn("ExecuteProtoNode: Invalid proto node provided (type=%s)",
            type(protoNode))
        self:Error("ExecuteProtoNode: Invalid proto node provided.")
        return false
    end

    -- Validate proto AST structure: should have type="action" and action field
    -- Proto AST nodes from RotationConversionService are plain tables (no metatable)
    -- so we check structure instead of using ASTCore.IsNode()
    if protoNode.type ~= ASTCore.NodeType.ACTION then
        -- Check if it's a wrapped legacy node
        if protoNode._protoAST then
            return self:ExecuteProtoNode(protoNode._protoAST)
        end
        self:Warn("ExecuteProtoNode: Node is not an ACTION node (type=%s)",
            protoNode.type or "nil")
        return false
    end

    if not protoNode.action or type(protoNode.action) ~= "table" then
        self:Warn("ExecuteProtoNode: Missing or invalid action field in proto AST node")
        return false
    end

    -- Only handle ACTION nodes in execution
    if protoNode.type ~= ASTCore.NodeType.ACTION then
        self:Warn("ExecuteProtoNode: Node is not an ACTION node (type: %s, expected: %s) - cannot execute",
            protoNode.type, ASTCore.NodeType.ACTION)
        return false
    end

    local actionType = ASTAction.GetActionType(protoNode) or "unknown"
    self:Info("ExecuteProtoNode: Executing proto action node (actionType='%s')", actionType)

    -- APL Monitor Feed instrumentation (tree mode)
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
    local shouldInstrument = APLMonitorFeed and APLMonitorFeed:IsInstrumentationActive()
        and APLMonitorFeed:GetEvaluationMode() == "tree"

    -- Generate node ID for instrumentation
    local nodeId
    if shouldInstrument then
        -- For now, use a simple counter-based ID - proper AST-based IDs would be better
        nodeId = format("action_%d", protoNode.__nodeIndex or 0)
        APLMonitorFeed:BeginNodeEvaluation(nodeId, "ACTION", protoNode)
    end

    local startTime = shouldInstrument and debugprofilestop() or nil

    -- Check condition first
    if protoNode.condition then
        local conditionResult = self:EvaluateProtoCondition(protoNode.condition)
        if not conditionResult then
            -- Record failed action
            if shouldInstrument then
                local duration = (debugprofilestop() - startTime) / 1000
                APLMonitorFeed:EndNodeEvaluation(nodeId, false, duration)
            end
            return false
        end
    end

    -- Get action type and data
    local actionType = ASTAction.GetActionType(protoNode)
    local actionData = ASTAction.GetActionData(protoNode)

    if not actionType or not actionData then
        self:Warn("ExecuteProtoNode: Missing action data in proto node (actionType=%s, actionData=%s)",
            actionType and tostring(actionType) or "nil", actionData and "present" or "nil")
        self:Error("ExecuteProtoNode: No action data in proto node")
        return false
    end

    self:Info("ExecuteProtoNode: Executing action (actionType='%s')", actionType)

    -- Use schema-aware routing for all action types
    local actionResult = false
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")

    if SchemaAccessor then
        -- Get metadata to find proto name (e.g., "cast_spell" -> "APLActionCastSpell")
        local metadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
        if metadata and metadata.protoName then
            -- Use CallHandlerWithMapping for automatic argument extraction and handler routing
            local result = self:CallHandlerWithMapping(metadata.protoName, actionData)
            if result ~= nil then
                actionResult = result and true or false
                self:Trace("ExecuteProtoNode: %s returned: %s", actionType, tostring(actionResult))
            else
                self:Warn("ExecuteProtoNode: CallHandlerWithMapping returned nil for action type: %s", actionType)
            end
        else
            self:Warn("ExecuteProtoNode: No metadata found for action type: %s", actionType)
        end
    else
        self:Error("ExecuteProtoNode: SchemaAccessor not available")
    end

    -- Record action result for APL Monitor
    if shouldInstrument then
        local duration = (debugprofilestop() - startTime) / 1000
        APLMonitorFeed:EndNodeEvaluation(nodeId, actionResult, duration)
    end

    return actionResult
end

--- Evaluate a proto condition (APLValue)
--- @param protoValue ASTNode Proto value node
--- @return boolean Condition result
function APLExecutor:EvaluateProtoCondition(protoValue)
    -- Validate proto AST structure: should have type="value"
    -- Proto AST nodes from RotationConversionService are plain tables (no metatable)
    if not protoValue or type(protoValue) ~= "table" or protoValue.type ~= ASTCore.NodeType.VALUE then
        -- Might be a legacy condition, delegate to legacy evaluator
        return self:EvaluateCondition(protoValue)
    end

    if protoValue.type ~= ASTCore.NodeType.VALUE then
        self:Warn("EvaluateProtoCondition: Node is not a VALUE node")
        return false
    end

    -- APL Monitor Feed instrumentation (tree mode)
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
    local shouldInstrument = APLMonitorFeed and APLMonitorFeed:IsInstrumentationActive()
        and APLMonitorFeed:GetEvaluationMode() == "tree"

    local nodeId
    if shouldInstrument then
        nodeId = format("value_%d", protoValue.__nodeIndex or 0)
        APLMonitorFeed:BeginNodeEvaluation(nodeId, "VALUE", protoValue)
    end

    local startTime = shouldInstrument and debugprofilestop() or nil

    local valueType = ASTValue.GetValueType(protoValue)
    local valueData = ASTValue.GetValueData(protoValue)

    if not valueType or not valueData then
        if shouldInstrument then
            local duration = (debugprofilestop() - startTime) / 1000
            APLMonitorFeed:EndNodeEvaluation(nodeId, false, duration)
        end
        return false
    end

    local result

    -- Handle logical operators
    if valueType == "and" then
        result = true
        for _, val in ipairs(valueData.vals or {}) do
            if not self:EvaluateProtoCondition(val) then
                result = false
                break
            end
        end

    elseif valueType == "or" then
        result = false
        for _, val in ipairs(valueData.vals or {}) do
            if self:EvaluateProtoCondition(val) then
                result = true
                break
            end
        end

    elseif valueType == "not" then
        result = not self:EvaluateProtoCondition(valueData.val)

    elseif valueType == "cmp" then
        local lhs = self:EvaluateProtoValue(valueData.lhs)
        local rhs = self:EvaluateProtoValue(valueData.rhs)
        result = self:CompareValues(lhs, valueData.op, rhs)

    else
        -- For other value types, evaluate and treat as boolean
        result = self:EvaluateProtoValue(protoValue)
        result = result and true or false
    end

    -- Record condition result for APL Monitor
    if shouldInstrument then
        local duration = (debugprofilestop() - startTime) / 1000
        APLMonitorFeed:EndNodeEvaluation(nodeId, result, duration)
    end

    return result
end

--- Evaluate a proto value node to get its actual value
--- @param protoValue ASTNode Proto value node
--- @return any The evaluated value
function APLExecutor:EvaluateProtoValue(protoValue)
    if not protoValue or type(protoValue) ~= "table" then
        self:Warn("EvaluateProtoValue: Invalid proto value provided (type=%s)",
            type(protoValue))
        return nil
    end

    -- Validate proto AST structure: should have type="value" and value field
    -- Proto AST nodes from RotationConversionService are plain tables (no metatable)
    -- so we check structure instead of using ASTCore.IsNode()
    if protoValue.type ~= ASTCore.NodeType.VALUE then
        -- Check if it's a wrapped legacy node
        if protoValue._protoAST then
            return self:EvaluateProtoValue(protoValue._protoAST)
        end
        self:Warn("EvaluateProtoValue: Node is not a VALUE node (type=%s)",
            protoValue.type or "nil")
        return nil
    end

    if not protoValue.value or type(protoValue.value) ~= "table" then
        self:Warn("EvaluateProtoValue: Missing or invalid value field in proto AST node")
        return nil
    end

    local valueType = ASTValue.GetValueType(protoValue)
    local valueData = ASTValue.GetValueData(protoValue)
    self:Info("EvaluateProtoValue: Evaluating proto value (valueType='%s')", valueType or "unknown")

    if not valueType or not valueData then
        self:Warn("EvaluateProtoValue: Missing value type or data (valueType=%s, valueData=%s)",
            valueType and tostring(valueType) or "nil", valueData and "present" or "nil")
        return nil
    end

    -- Handle special value types that need custom logic
    if valueType == "const" then
        local val = valueData.val

        -- Check if it's a WoW API call (custom property on node)
        if protoValue.isWoWAPICall and protoValue.funcName then
            self:Trace("EvaluateProtoValue: Detected WoW API call: %s", protoValue.funcName)
            return self:ExecuteWoWAPICall(protoValue.funcName, protoValue.parsedArgs)
        end

        -- Check if it's an inline function (starts with "function(")
        if type(val) == "string" and val:match("^%s*function%s*%(") then
            self:Trace("EvaluateProtoValue: Detected inline function")
            return self:ExecuteInlineFunction(val)
        end

        -- Try to convert to number
        local num = tonumber(val)
        return num or val
    end

    -- Handle math operations
    if valueType == "math" then
        return self:EvaluateMath(valueData)
    end

    -- Handle comparison operations
    if valueType == "cmp" then
        local lhs = self:EvaluateProtoValue(valueData.lhs)
        local rhs = self:EvaluateProtoValue(valueData.rhs)
        return self:CompareValues(lhs, valueData.op, rhs)
    end

    -- All other value types require schema-aware routing
    if not self:IsSchemaAvailable() then
        self:Error("EvaluateProtoValue: SchemaAccessor not available - cannot evaluate value type: %s", valueType)
        return nil
    end

    -- Get metadata to find proto name (e.g., "spell_is_ready" -> "APLValueSpellIsReady")
    local metadata = SchemaAccessor:GetMetadataByIdentifier(valueType, nil)
    if not metadata or not metadata.protoName then
        self:Warn("EvaluateProtoValue: No metadata found for value type: %s", valueType)
        return nil
    end

    -- Use CallHandlerWithMapping for automatic argument extraction and handler routing
    local result = self:CallHandlerWithMapping(metadata.protoName, valueData)
    if result ~= nil then
        self:Trace("EvaluateProtoValue: %s returned: %s", valueType, tostring(result))
        return result
    else
        self:Warn("EvaluateProtoValue: CallHandlerWithMapping returned nil for value type: %s", valueType)
        return nil
    end
end

--- Execute a WoW API function call
--- @param funcName string The WoW API function name (e.g., "UnitHealth", "UnitAttackPower")
--- @param parsedArgs table[] Array of parsed argument AST nodes
--- @return any The function result or nil on error
function APLExecutor:ExecuteWoWAPICall(funcName, parsedArgs)
    if not funcName then
        self:Error("ExecuteWoWAPICall: funcName is required")
        return nil
    end

    -- Resolve WoW API function from global namespace or ns.WoWAPI
    local func = _G[funcName]
    if not func and ns.WoWAPI then
        func = ns.WoWAPI[funcName]
    end

    if not func or type(func) ~= "function" then
        self:Warn("ExecuteWoWAPICall: Unknown WoW API function: %s", funcName)
        return nil
    end

    -- Evaluate arguments recursively
    local evaluatedArgs = {}
    if parsedArgs and #parsedArgs > 0 then
        for i, arg in ipairs(parsedArgs) do
            local evaluatedArg = self:EvaluateProtoValue(arg)
            evaluatedArgs[i] = evaluatedArg
        end
    end

    -- Execute function with pcall for safety
    local success, result = pcall(func, unpack(evaluatedArgs))
    if not success then
        self:Error("ExecuteWoWAPICall: Error executing %s: %s", funcName, tostring(result))
        return nil
    end

    self:Trace("ExecuteWoWAPICall: %s(%s) => %s", funcName,
        table.concat(evaluatedArgs, ", "), tostring(result))
    return result
end

--- Execute an inline Lua function
--- @param funcString string The function string (e.g., "function() return ... end()" or "(function() return ... end)()")
--- @return any The function result or nil on error
function APLExecutor:ExecuteInlineFunction(funcString)
    if not funcString or type(funcString) ~= "string" then
        self:Error("ExecuteInlineFunction: funcString must be a string")
        return nil
    end

    -- Create safe environment with commonly used WoW APIs and NAG functions
    local WoWAPI = ns.WoWAPI or {}
    local env = setmetatable({
        NAG = NAG,
        select = select,
        -- WoW API functions (prefer ns.WoWAPI if available, fallback to _G)
        UnitHealth = UnitHealth or _G.UnitHealth,
        UnitHealthMax = UnitHealthMax or _G.UnitHealthMax,
        UnitAttackPower = UnitAttackPower or _G.UnitAttackPower,
        UnitLevel = UnitLevel or _G.UnitLevel,
        UnitStat = UnitStat or _G.UnitStat,
        GetTime = GetTime or _G.GetTime,
        -- Add other commonly used WoW APIs as needed
    }, { __index = _G })

    -- The function string may already include () at the end (e.g., "function() return ... end()")
    -- or be wrapped in parentheses with call (e.g., "(function() return ... end)()")
    -- In both cases, we can execute it directly with "return " prefix
    local func, err = loadstring("return " .. funcString)
    if not func then
        self:Error("ExecuteInlineFunction: Error parsing function: %s", tostring(err))
        return nil
    end

    setfenv(func, env)
    local success, result = pcall(func)
    if not success then
        self:Error("ExecuteInlineFunction: Error executing function: %s", tostring(result))
        return nil
    end

    self:Trace("ExecuteInlineFunction: result => %s", tostring(result))
    return result
end

--- Compare two values using a proto comparison operator
--- @param lhs any Left-hand side value
--- @param op string Comparison operator (OpEq, OpLt, etc.)
--- @param rhs any Right-hand side value
--- @return boolean Comparison result
function APLExecutor:CompareValues(lhs, op, rhs)
    -- Convert to numbers if possible
    local lhsNum = tonumber(lhs)
    local rhsNum = tonumber(rhs)

    if lhsNum and rhsNum then
        lhs = lhsNum
        rhs = rhsNum
    end

    if op == "OpEq" then
        return lhs == rhs
    elseif op == "OpNe" then
        return lhs ~= rhs
    elseif op == "OpLt" then
        return lhs < rhs
    elseif op == "OpLe" then
        return lhs <= rhs
    elseif op == "OpGt" then
        return lhs > rhs
    elseif op == "OpGe" then
        return lhs >= rhs
    end

    return false
end

-- ============================ LEGACY AST EXECUTION ============================

--- Handler for 'and' logic node.
function APLExecutor:ExecuteAnd(andNode)
    if not andNode or type(andNode) ~= "table" or not andNode.vals then return false end
    for _, subNode in ipairs(andNode.vals) do
        if not self:EvaluateCondition(subNode) then
            return false
        end
    end
    return true
end

--- Handler for 'or' logic node.
function APLExecutor:ExecuteOr(orNode)
    if not orNode or type(orNode) ~= "table" or not orNode.vals then return false end
    for _, subNode in ipairs(orNode.vals) do
        if self:EvaluateCondition(subNode) then
            return true
        end
    end
    return false
end

--- Handler for 'not' logic node.
function APLExecutor:ExecuteNot(notNode)
    if not notNode or type(notNode) ~= "table" or not notNode.val then return false end
    return not self:EvaluateCondition(notNode.val)
end

--- Handler for 'cmp' (comparison) node.
function APLExecutor:ExecuteCmp(cmpNode)
    if not cmpNode or type(cmpNode) ~= "table" then
        self:Error("ExecuteCmp: Invalid cmp node")
        return false
    end
    local op = cmpNode.op
    local lhs = cmpNode.lhs and self:EvaluateCondition(cmpNode.lhs)
    local rhs = cmpNode.rhs and self:EvaluateCondition(cmpNode.rhs)
    if self.debug then
        self:Debug("ExecuteCmp op=%s lhs=%s (%s) rhs=%s (%s)", tostring(op), tostring(lhs), type(lhs),
            tostring(rhs), type(rhs))
    end
    -- NOTE: Type checking for debugging; may be removed for performance later
    if type(lhs) ~= "number" or type(rhs) ~= "number" then
        self:Error(format("ExecuteCmp: Non-numeric comparison (lhs=%s [%s], rhs=%s [%s])", tostring(lhs), type(lhs),
            tostring(rhs), type(rhs)))
        return false
    end
    if op == "OpGt" then
        return lhs > rhs
    elseif op == "OpLt" then
        return lhs < rhs
    elseif op == "OpEq" then
        return lhs == rhs
    elseif op == "OpLe" then
        return lhs <= rhs
    elseif op == "OpGe" then
        return lhs >= rhs
    elseif op == "OpNe" then
        return lhs ~= rhs
    else
        self:Error(format("ExecuteCmp: Unknown op '%s'", tostring(op)))
        return false
    end
end

function APLExecutor:SerializeNode(node)
    if type(node) == "table" then
        local parts = {}
        for k, v in pairs(node) do
            table.insert(parts, tostring(k) .. "=" .. (type(v) == "table" and self:SerializeNode(v) or tostring(v)))
        end
        return "{" .. table.concat(parts, ", ") .. "}"
    else
        return tostring(node)
    end
end

-- ============================ HANDLER CALLING ============================

--- Call NAG handler with arguments extracted from proto value node
--- Arguments are extracted in field_order (which matches NAG handler signature via schema modifications)
--- @param protoName string The proto message name
--- @param valueNode table The value node from proto AST
--- @return any The result from the NAG handler
function APLExecutor:CallHandlerWithMapping(protoName, valueNode)
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    -- Get NAG handler name
    local nagName = SchemaAccessor:GetNagNameFromProtoName(protoName)
    if not nagName then
        self:Error("CallHandlerWithMapping: No handler alias for %s", protoName)
        return nil
    end

    -- Extract arguments from proto node in field_order (already matches NAG handler signature)
    local protoArgs = self:ExtractProtoArguments(protoName, valueNode)

    -- Call NAG handler with arguments (field_order modifications ensure correct order)
    if NAG[nagName] then
        return NAG[nagName](NAG, unpack(protoArgs))
    else
        self:Error("CallHandlerWithMapping: NAG handler '%s' not found", nagName)
        return nil
    end
end

--- Extract arguments from proto value node based on schema field order
--- @param protoName string The proto message name
--- @param valueNode table The value node from proto AST
--- @return table Array of argument values in proto field order
function APLExecutor:ExtractProtoArguments(protoName, valueNode)
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local FieldFormatConverter = ns.FieldFormatConverter
    local fields, fieldOrder = SchemaAccessor:GetFields(protoName)
    if not fieldOrder or #fieldOrder == 0 then
        return {}
    end

    local args = {}
    for i, fieldName in ipairs(fieldOrder) do
        local fieldValue = valueNode[fieldName]
        local fieldInfo = fields[fieldName]

        -- Debug: Log fieldInfo structure for message types to detect missing message_type
        if fieldInfo and fieldInfo.type == "message" then
            if not fieldInfo.message_type then
                local fieldInfoKeys = {}
                for k, v in pairs(fieldInfo) do
                    if k ~= "_metadata" then
                        table.insert(fieldInfoKeys, string.format("%s=%s", k, tostring(v)))
                    end
                end
                self:Warn("[APLExecutor] ExtractProtoArguments: fieldType='message' but message_type is nil! protoName=%s, fieldName=%s, fieldInfo keys: %s",
                    protoName, fieldName, table.concat(fieldInfoKeys, ", "))
            else
                self:Info("[APLExecutor] ExtractProtoArguments: protoName=%s, fieldName=%s, fieldType=%s, message_type=%s",
                    protoName, fieldName, fieldInfo.type, fieldInfo.message_type)
            end
        end

        -- Use FieldFormatConverter for consistent extraction
        if fieldInfo then
            local extracted = FieldFormatConverter:ExtractValue(fieldValue, fieldInfo)

            -- If field is APLValue message type and extracted value is still an AST node, evaluate it
            if fieldInfo.type == "message" and fieldInfo.message_type and
               (fieldInfo.message_type == "APLValue" or fieldInfo.message_type:find("^APLValue")) then
                -- Check if extracted value is still an AST node that needs evaluation
                if extracted and type(extracted) == "table" and ASTCore and ASTCore.IsNode and ASTCore.IsNode(extracted) then
                    extracted = self:EvaluateProtoValue(extracted)
                end
            end

            args[i] = extracted
        else
            args[i] = fieldValue  -- No field info available, pass raw value
        end
    end

    return args
end


-- ============================ CONDITION EVALUATION ============================

--- Recursively evaluates a condition node (logic/value).
--- @param condNode table The condition node
--- @return boolean The result of the condition
function APLExecutor:EvaluateCondition(condNode)
    if self.debug then self:Debug("EvaluateCondition entry: %s", type(condNode)) end
    if self.debug then self:Trace("EvaluateCondition node: %s", self:SerializeNode(condNode)) end
    if not condNode or type(condNode) ~= "table" then
        self:Error("EvaluateCondition: Invalid condition node")
        return false
    end
    for key, value in pairs(condNode) do
        if key == "and" then
            local result = self:ExecuteAnd(value)
            if self.debug then self:Trace("ExecuteAnd result: %s", tostring(result)) end
            return result
        elseif key == "or" then
            local result = self:ExecuteOr(value)
            if self.debug then self:Trace("ExecuteOr result: %s", tostring(result)) end
            return result
        elseif key == "not" then
            local result = self:ExecuteNot(value)
            if self.debug then self:Trace("ExecuteNot result: %s", tostring(result)) end
            return result
        elseif key == "cmp" then
            local result = self:ExecuteCmp(value)
            self:Trace("ExecuteCmp result: %s", tostring(result))
            return result
        else
            local handlerName = key:gsub("^%l", string.upper)
            if self["Evaluate" .. handlerName] then
                local result = self["Evaluate" .. handlerName](self, value)
                self:Trace("Evaluate%s result: %s", handlerName, tostring(result))
                return result
            else
                self:Error("No handler for condition/value: " .. handlerName)
                return false
            end
        end
    end
    return false
end

function APLExecutor:EvaluateConst(valueNode)
    self:Debug("EvaluateConst entry")
    self:Trace("EvaluateConst: %s", self:SerializeNode(valueNode))
    if not valueNode or valueNode.val == nil then
        self:Error("EvaluateConst: Invalid value node.")
        return false
    end
    local val = valueNode.val
    if type(val) == "number" then
        self:Trace("Const number: %s", tostring(val))
        return val
    elseif type(val) == "string" then
        -- Handle symbolic execute phase thresholds like 'E35'
        local execNum = val:match("^E(%d+)$")
        if execNum then
            local num = tonumber(execNum)
            self:Trace("Const symbolic execute threshold: %s -> %d", val, num)
            return num
        end
        local num = tonumber(val)
        if num then
            self:Trace("Const string->number: %s", tostring(num)); return num
        end
        local s = val:match("^(%-?%d+%.?%d*)s$")
        if s then
            self:Trace("Const duration: %s", tostring(s)); return tonumber(s)
        end
        local pct = val:match("^(%-?%d+%.?%d*)%%$")
        if pct then
            self:Trace("Const percent: %s", tostring(pct)); return tonumber(pct) / 100
        end
        self:Trace("Const fallback string: %s", val)
        return val
    else
        self:Trace("Const fallback type: %s", type(val))
        return val
    end
end

---
--- Evaluates a logical AND over all subnodes in the 'vals' array.
--- @param valueNode table The value node containing 'vals' (array of APLValue)
--- @return boolean True if all subnodes evaluate to true, false otherwise
function APLExecutor:EvaluateAnd(valueNode)
    self:Debug("EvaluateAnd entry")
    self:Trace("EvaluateAnd: %s", self:SerializeNode(valueNode))
    if not valueNode or type(valueNode.vals) ~= "table" then
        self:Error("EvaluateAnd: Invalid value node or missing 'vals'.")
        return false
    end
    for _, subNode in ipairs(valueNode.vals) do
        if not self:EvaluateCondition(subNode) then
            return false
        end
    end
    return true
end

-- ============================ REMOVED DEAD CODE ============================
-- All hardcoded EvaluateX functions have been removed - they are now handled
-- automatically via CallHandlerWithMapping in EvaluateProtoValue when schema is available.
-- Only special operators (const, math, and/or/not/cmp) remain as they require custom logic.
-- ============================================================================

-- ============================ REMOVED DEAD CODE ============================
-- The following Execute* functions (ExecuteActivateAura, ExecuteCastSpell, etc.)
-- were removed because they are dead code - not called by either execution path:
-- - Legacy path uses NAG[handlerName] directly (line 198, 215)
-- - Proto path uses CallHandlerWithMapping (schema-aware routing, line 291)
-- All action execution now goes through CallHandlerWithMapping in ExecuteProtoNode
-- ============================================================================

-- Note: ExecuteAnd, ExecuteOr, ExecuteNot, ExecuteCmp are still needed for logical operators
-- Note: ExecuteWoWAPICall, ExecuteInlineFunction are still needed for const value evaluation
-- Note: EvaluateMath is still needed for math operations

---
--- Evaluates a math operation (add, sub, mul, div) on two values.
--- @param valueNode table The value node containing op, lhs, rhs
--- @return number The result of the math operation
function APLExecutor:EvaluateMath(valueNode)
    self:Debug("EvaluateMath entry")
    self:Trace("EvaluateMath: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.op or not valueNode.lhs or not valueNode.rhs then
        self:Error("EvaluateMath: Invalid value node (missing op/lhs/rhs)")
        return 0
    end
    -- Map proto op to Lua symbol
    local opMap = {
        OpAdd = "+",
        OpSub = "-",
        OpMul = "*",
        OpDiv = "/",
    }
    local op = opMap[valueNode.op] or valueNode.op
    local lhs = self:EvaluateCondition(valueNode.lhs)
    local rhs = self:EvaluateCondition(valueNode.rhs)
    if type(lhs) ~= "number" or type(rhs) ~= "number" then
        self:Error("EvaluateMath: Non-numeric operands (lhs=%s [%s], rhs=%s [%s])", tostring(lhs), type(lhs),
            tostring(rhs), type(rhs))
        return 0
    end
    if NAG.Math then
        local result = NAG:Math(lhs, op, rhs)
        self:Trace("NAG:Math(%s, %s, %s) => %s", tostring(lhs), tostring(op), tostring(rhs), tostring(result))
        return result
    else
        self:Error("NAG:Math not implemented.")
        return 0
    end
end
