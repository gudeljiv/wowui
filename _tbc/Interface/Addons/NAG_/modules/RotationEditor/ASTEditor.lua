--- @module "RotationEditor.ASTEditor"
--- AST tree visualization and editing for RotationEditor
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)
local APLAutocomplete = ns.APLAutocomplete
local LibUIDropDownMenu = ns.LibUIDropDownMenu
local EditorUtils = ns.RotationEditorUtils

-- Proto AST modules
local ASTCore = ns.ASTCore
local ASTValue = ns.ASTValue
local ASTAction = ns.ASTAction
local ASTSchemaEmitter = ns.ASTSchemaEmitter

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tremove = tremove
local tostring = tostring
local tonumber = tonumber
local type = type
local pairs = pairs
local ipairs = ipairs
local GetCursorPosition = _G.GetCursorPosition
local IsShiftKeyDown = _G.IsShiftKeyDown
local CreateFrame = _G.CreateFrame

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local ASTEditor = {}
ns.RotationEditorAST = ASTEditor

-- ~~~~~~~~~~ HELPER FUNCTIONS ~~~~~~~~~~

local SchemaUtilsModule

local function GetSchemaUtils()
    if SchemaUtilsModule == nil then
        SchemaUtilsModule = NAG:GetModule("SchemaUtils")
    end
    return SchemaUtilsModule
end

--- Helper to safely get priority_list from editor state
--- @param editorState table The editor state
--- @param ensureExists boolean If true, create priority_list if it doesn't exist
--- @return table|nil Priority list or nil
local function GetPriorityList(editorState, ensureExists)
    if not editorState or not editorState.workingConfig then
        return nil
    end
    if not editorState.workingConfig.aplProto then
        if ensureExists then
            editorState.workingConfig.aplProto = {}
        else
            return nil
        end
    end
    if not editorState.workingConfig.aplProto.priority_list then
        if ensureExists then
            editorState.workingConfig.aplProto.priority_list = {}
        else
            return nil
        end
    end
    return editorState.workingConfig.aplProto.priority_list
end

--- Helper to safely get clause by index
--- @param editorState table The editor state
--- @param clauseIdx number The clause index (1-based)
--- @return table|nil Clause or nil
local function GetClause(editorState, clauseIdx)
    local priorityList = GetPriorityList(editorState)
    return priorityList and priorityList[clauseIdx]
end

--- Generic RefreshTree hook pattern to avoid code duplication
--- Stores original method so it can be restored on cleanup
--- @param treeGroup table TreeGroup widget
--- @param hookName string Unique hook name (e.g., "NodeContextMenu")
--- @param callback function Callback function(obj) to execute after refresh
local function HookRefreshTree(treeGroup, hookName, callback)
    if not treeGroup then
        return
    end
    local hookKey = "_nag" .. hookName .. "Hooked"
    if treeGroup[hookKey] then
        return
    end
    treeGroup[hookKey] = true

    -- Mark this widget as owned by the rotation editor
    treeGroup._nagEditorOwned = true

    if treeGroup.RefreshTree then
        -- Store the ORIGINAL RefreshTree (or already hooked version) for restoration
        local originalKey = "_nagOriginalRefreshTree_" .. hookName
        if not treeGroup[originalKey] then
            treeGroup[originalKey] = treeGroup.RefreshTree
        end

        local originalRefresh = treeGroup.RefreshTree
        treeGroup.RefreshTree = function(obj, ...)
            originalRefresh(obj, ...)

            -- Only execute callback if this widget is still owned by the editor
            if not obj._nagEditorOwned then
                return
            end

            if obj.buttons and next(obj.buttons) then
                callback(obj)
            else
                C_Timer.After(0, function()
                    -- Check ownership again after delay
                    if obj._nagEditorOwned and obj.buttons and next(obj.buttons) then
                        callback(obj)
                    end
                end)
            end
        end
    end
end



--- Recursively collect all node values from tree structure with hierarchical paths
--- @param treeNode table TreeGroup node structure
--- @param nodeValues table Accumulator for node values
--- @param parentPath string|nil Parent path for building hierarchical uniquevalue
local function CollectAllNodeValues(treeNode, nodeValues, parentPath)
    if treeNode.value then
        -- Build hierarchical uniquevalue like TreeGroup does (using \001 separator)
        local uniquevalue = parentPath and (parentPath .. "\001" .. treeNode.value) or treeNode.value
        tinsert(nodeValues, uniquevalue)

        -- Recursively collect children with this node as parent
        if treeNode.children then
            for _, child in ipairs(treeNode.children) do
                CollectAllNodeValues(child, nodeValues, uniquevalue)
            end
        end
    end
end

--- Collect only comparison node values from tree
--- @param treeNode table Tree node to traverse
--- @param nodeDetailsByUniqueValue table Lookup table for node details
--- @param nodeValues table Array to collect unique values into
--- @param parentPath string|nil Parent path for building hierarchical uniquevalue
local function CollectComparisonNodeValues(treeNode, nodeDetailsByUniqueValue, nodeValues, parentPath)
    if treeNode.value then
        local uniquevalue = parentPath and (parentPath .. "\001" .. treeNode.value) or treeNode.value

        -- Check if this node is a comparison node (has lhs/rhs children)
        local nodeDetail = nodeDetailsByUniqueValue[uniquevalue]
        if nodeDetail and nodeDetail.node and ASTValue.IsComparison(nodeDetail.node) then
            tinsert(nodeValues, uniquevalue)
        end

        -- Recurse into children
        if treeNode.children then
            for _, child in ipairs(treeNode.children) do
                CollectComparisonNodeValues(child, nodeDetailsByUniqueValue, nodeValues, uniquevalue)
            end
        end
    end
end

--- Expand all nodes in the AST tree
--- @param treeGroup table TreeGroup widget
--- @param treeData table Tree structure
--- @param editorState table The editor state
local function ExpandAllNodes(treeGroup, treeData, editorState, clauseIdx)
    -- Use per-clause status table
    if not editorState.clauseTreeStatus then
        editorState.clauseTreeStatus = {}
    end
    if not editorState.clauseTreeStatus[clauseIdx] then
        editorState.clauseTreeStatus[clauseIdx] = { groups = {} }
    end

    -- Collect all hierarchical node values (uniquevalues)
    local nodeValues = {}
    for _, rootNode in ipairs(treeData) do
        CollectAllNodeValues(rootNode, nodeValues, nil) -- Start with no parent path
    end

    -- Set all to expanded
    for _, nodeValue in ipairs(nodeValues) do
        editorState.clauseTreeStatus[clauseIdx].groups[nodeValue] = true
    end

    -- Refresh tree display
    treeGroup:RefreshTree()
end

--- Collapse all nodes in the AST tree
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state
--- @param clauseIdx number The clause index
local function CollapseAllNodes(treeGroup, editorState, clauseIdx)
    -- Use per-clause status table
    if editorState.clauseTreeStatus and editorState.clauseTreeStatus[clauseIdx] then
        editorState.clauseTreeStatus[clauseIdx].groups = {}
    end

    -- Refresh tree display
    treeGroup:RefreshTree()
end

--- Toggle comparison nodes in the AST tree
--- @param treeGroup table TreeGroup widget
--- @param treeData table Tree structure
--- @param nodeDetailsByUniqueValue table Lookup table for node details
--- @param editorState table The editor state
--- @param clauseIdx number The clause index
--- @return boolean New state (true = expanded, false = collapsed)
local function ToggleComparisonNodes(treeGroup, treeData, nodeDetailsByUniqueValue, editorState, clauseIdx)
    if not editorState.clauseTreeStatus then
        editorState.clauseTreeStatus = {}
    end
    if not editorState.clauseTreeStatus[clauseIdx] then
        editorState.clauseTreeStatus[clauseIdx] = { groups = {} }
    end

    -- Collect all comparison node uniquevalues
    local comparisonNodes = {}
    for _, rootNode in ipairs(treeData) do
        CollectComparisonNodeValues(rootNode, nodeDetailsByUniqueValue, comparisonNodes, nil)
    end

    -- Check if any comparison nodes are currently expanded
    local hasExpanded = false
    for _, nodeValue in ipairs(comparisonNodes) do
        if editorState.clauseTreeStatus[clauseIdx].groups[nodeValue] then
            hasExpanded = true
            break
        end
    end

    -- Toggle: if any are expanded, collapse all; otherwise expand all
    local newState = not hasExpanded
    for _, nodeValue in ipairs(comparisonNodes) do
        editorState.clauseTreeStatus[clauseIdx].groups[nodeValue] = newState
    end

    treeGroup:RefreshTree()
    return newState
end

-- ============================ TELEMETRY HELPERS ============================

local function EmitASTFallbackTelemetry(clause, clauseIdx, editorState, nodeId, uniqueValue, node, nodeType, fallbackReason, fallbackLevel, extraDetail)
    local level = fallbackLevel or "Warn"
    local detailPayload

    if type(extraDetail) == "table" then
        detailPayload = {}
        for key, value in pairs(extraDetail) do
            detailPayload[key] = value
        end
    elseif extraDetail ~= nil then
        detailPayload = { message = tostring(extraDetail) }
    else
        detailPayload = {}
    end

    detailPayload.fallbackReason = detailPayload.fallbackReason or fallbackReason
    detailPayload.uniqueValue = detailPayload.uniqueValue or uniqueValue
    detailPayload.nodeType = detailPayload.nodeType or nodeType

    if node then
        -- Derive function name from proto AST structure for telemetry
        if detailPayload.functionName == nil then
            local ASTAction = ns.ASTAction
            local ASTValue = ns.ASTValue
            local ASTCore = ns.ASTCore
            local functionName = nil
            if node.type == ASTCore.NodeType.ACTION then
                local actionType = ASTAction.GetActionType(node)
                if actionType then
                    local SchemaUtils = ns.SchemaUtils
                    functionName = SchemaUtils and SchemaUtils:SnakeToPascal(actionType) or actionType
                end
            elseif node.type == ASTCore.NodeType.VALUE then
                local valueType = ASTValue.GetValueType(node)
                if valueType then
                    local SchemaUtils = ns.SchemaUtils
                    functionName = SchemaUtils and SchemaUtils:SnakeToPascal(valueType) or valueType
                end
            end
            if functionName then
                detailPayload.functionName = functionName
            end
        end
        -- Get operator from proto AST
        if detailPayload.operator == nil then
            if node.type == ASTCore.NodeType.VALUE then
                local valueData = ASTValue.GetValueData(node)
                if valueData and valueData.op then
                    -- Convert proto operator to symbol for telemetry
                    if ASTValue.IsComparison(node) then
                        detailPayload.operator = ASTValue.ComparisonOpToSymbol(valueData.op)
                    elseif ASTValue.IsMathOp(node) then
                        detailPayload.operator = ASTValue.MathOpToSymbol(valueData.op)
                    else
                        detailPayload.operator = valueData.op
                    end
                end
            elseif node.operator then
                -- Legacy format detected - should not happen in production code
                NAG:Warn(format("[ASTEditor] Legacy format operator detected - should be proto AST"))
                detailPayload.operator = node.operator
            end
        end
    end

    if clause then
        -- Priority is the array index (clauseIdx)
        if clauseIdx and detailPayload.clausePriority == nil then
            detailPayload.clausePriority = clauseIdx
        end
        -- Proto AST list items don't have uuid/id/nodeId - they're just {action, notes, hide}
        if clause.name and detailPayload.clauseName == nil then
            detailPayload.clauseName = clause.name
        end
    end

    local reasonText = fallbackReason or format("Fallback detected for %s node", tostring(nodeType or "unknown"))

    local logFn = NAG and NAG[level]
    if type(logFn) == "function" then
        local rotationName = editorState and editorState.rotationName or "unknown"
        local message = format(
            "[ASTEditor] %s (rotation=%s; clausePriority=%s; node=%s; detail=%s)",
            reasonText,
            tostring(rotationName),
            clauseIdx and tostring(clauseIdx) or "?",
            tostring(nodeId or "?"),
            tostring(detailPayload.fallbackReason or "")
        )
        logFn(NAG, message)
    end
end

-- ~~~~~~~~~~ AST TREE BUILDING ~~~~~~~~~~

--- Build AST tree structure for a clause (condition + action)
--- @param listItem table The list item (APLListItem) to build tree for
--- @param editorState table The editor state for this instance
--- @param clauseIdx number The clause index (array position, 1-based)
--- @return table tree
--- @return table nodeDetails keyed by nodeId
--- @return table nodeDetailsByUniqueValue
function ASTEditor:BuildClauseASTTree(listItem, editorState, clauseIdx)
    local nodeDetails = {}
    local nodeDetailsByUniqueValue = {}
    local nodeCounter = 0
    local convertNodeCallCount = 0 -- DEBUG: Track how many times convertNode is called

    -- listItem is an APLListItem from proto AST priority_list
    -- It has: action (proto AST action node), notes, hide
    local actionNode = listItem and listItem.action
    if not actionNode then
        return {}, nodeDetails, nodeDetailsByUniqueValue
    end

    -- Get condition from action node (proto AST structure)
    local conditionAST = nil
    local ASTAction = ns.ASTAction
    if ASTAction and ASTAction.HasCondition and ASTAction.HasCondition(actionNode) then
        conditionAST = ASTAction.GetCondition(actionNode)
    end

    -- Action is proto AST node
    local actionAST = actionNode

    -- Build root node
    -- Priority is the array index (clauseIdx)
    local displayPriority = clauseIdx
    local rootDetails = {
        format("|cFFFFFF00Clause Priority: %d|r", displayPriority)
    }
    if listItem and listItem.notes then
        tinsert(rootDetails, format("|cFFCCCCCCNotes:|r %s", listItem.notes))
    end
    nodeDetails["root"] = {
        details = rootDetails,
        node = nil,
        nodeType = "root",
        uniqueValue = "root"
    }
    nodeDetailsByUniqueValue["root"] = nodeDetails["root"]

    -- Convert AST node to TreeGroup format recursively
    -- path is the semantic path (e.g., "root_cond_1_lhs_arg1")
    -- useCounter: if true, append global counter for uniqueness; if false, use path as-is for structural children
    local function convertNode(node, path, nodeType, useCounter, parentMeta)
        useCounter = (useCounter == nil) and true or useCounter -- Default to true for backward compatibility
        local nodeId
        if useCounter then
            nodeCounter = nodeCounter + 1
            nodeId = path .. "_" .. nodeCounter
        else
            -- For structural children (lhs, rhs, arg1, arg2), use semantic path directly
            nodeId = path
        end
        local ASTValue = ns.ASTValue
        local ASTAction = ns.ASTAction
        local ASTCore = ns.ASTCore

        -- CRITICAL: Check if node is in proto structure format (e.g., { dot_remaining_time = { spell_id = 980 } })
        -- This happens when nodes are stored in arrays like vals for min/max/and/or
        if node and type(node) == "table" and not node.type then
            -- Proto structure detected - reconstruct wrapper node
            for valueTypeKey, valueData in pairs(node) do
                if ASTValue and ASTValue.Create then
                    node = ASTValue.Create(valueTypeKey, valueData)
                    break
                end
            end
        end

        local ntype = node and node.type or "unknown"

        -- Detect proto AST node types
        local valueType = nil
        local actionType = nil
        if ntype == ASTCore.NodeType.VALUE then
            valueType = ASTValue and ASTValue.GetValueType(node)
        elseif ntype == ASTCore.NodeType.ACTION then
            actionType = ASTAction and ASTAction.GetActionType(node)
        end

        local currentContext = parentMeta and parentMeta.context or nil

        local treeNode = {
            value = nodeId,
            text = "",
            children = {}
        }

        -- Build hierarchical uniqueValue AFTER treeNode.value is set
        -- Use treeNode.value (which TreeGroup uses) for the path segment, not nodeId
        local parentUniqueValue = parentMeta and parentMeta.uniqueValue or nil
        local uniqueValue = parentUniqueValue and (parentUniqueValue .. "\001" .. treeNode.value) or treeNode.value

        local details = {}

        local resolvedActionMetadata = EditorUtils.ResolveNodeActionMetadata(node, ntype)

        -- Handle proto AST value nodes (logical, comparison, math, function calls)
        if ntype == ASTCore.NodeType.VALUE and valueType then
            if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR then
                -- Logical operation (AND/OR)
                local op = (valueType == ASTValue.ValueType.AND) and "AND" or "OR"
                local opColor = op == "AND" and "|cFF00FF00" or "|cFFFFAA00"
                treeNode.text = format("%s%s|r", opColor, op)

                tinsert(details, format("%sLogical Operation: %s|r", opColor, op))
                local valueData = ASTValue.GetValueData(node)
                local vals = valueData and valueData.vals or {}
                tinsert(details, format("Children: %d", #vals))

                -- Add logical children
                if vals then
                    for i, child in ipairs(vals) do
                        tinsert(treeNode.children, convertNode(child, nodeId, "child", true, {
                            node = node,
                            nodeId = nodeId,
                            field = "vals",
                            index = i,
                            context = currentContext,
                            uniqueValue = uniqueValue
                        }))
                    end
                end
            elseif valueType == ASTValue.ValueType.MIN or valueType == ASTValue.ValueType.MAX then
                -- Math function (MIN/MAX) - similar to logical operators, uses vals array
                local funcName = (valueType == ASTValue.ValueType.MIN) and "Min" or "Max"
                local funcColor = "|cFF00AAFF"
                local valueData = ASTValue.GetValueData(node)
                local vals = valueData and valueData.vals or {}
                local argCount = #vals

                -- Display function name with argument count
                if argCount > 0 then
                    treeNode.text = format("%s%s(%d)|r", funcColor, funcName, argCount)
                else
                    treeNode.text = format("%s%s()|r", funcColor, funcName)
                end

                tinsert(details, format("%sMath Function: %s|r", funcColor, funcName))
                tinsert(details, format("Arguments: %d", argCount))

                -- Add children from vals array
                if vals then
                    for i, child in ipairs(vals) do
                        tinsert(treeNode.children, convertNode(child, nodeId, "child", true, {
                            node = node,
                            nodeId = nodeId,
                            field = "vals",
                            index = i,
                            context = currentContext,
                            uniqueValue = uniqueValue
                        }))
                    end
                end
            elseif valueType == ASTValue.ValueType.NOT then
                -- NOT operation
                treeNode.text = "|cFFFF0000NOT|r"
                tinsert(details, "|cFFFF0000Logical Operation: NOT|r")
                local valueData = ASTValue.GetValueData(node)
                local val = valueData and valueData.val
                if val then
                    tinsert(treeNode.children, convertNode(val, nodeId, "child", true, {
                        node = node,
                        nodeId = nodeId,
                        field = "val",
                        context = currentContext,
                        uniqueValue = uniqueValue
                    }))
                end
            elseif valueType == ASTValue.ValueType.CMP then
                -- Comparison
                local valueData = ASTValue.GetValueData(node)
                local op = valueData and valueData.op or "OpEq"
                local opSymbol = ASTValue.ComparisonOpToSymbol(op)
                local lhs = valueData and valueData.lhs
                local rhs = valueData and valueData.rhs
                local lhsStr = lhs and EditorUtils.FormatValueNode(lhs) or "?"
                local rhsStr = rhs and EditorUtils.FormatValueNode(rhs) or "?"
                treeNode.text = format("|cFF00FFFF%s %s %s|r", lhsStr, opSymbol, rhsStr)

                tinsert(details, "|cFF00FFFFComparison|r")
                tinsert(details, format("Operator: %s", opSymbol))
                tinsert(details, format("Left: %s", lhsStr))
                tinsert(details, format("Right: %s", rhsStr))

                if lhs then
                    tinsert(treeNode.children, convertNode(lhs, nodeId .. "_lhs", "comparison_side", false, {
                        node = node,
                        nodeId = nodeId,
                        field = "lhs",
                        context = currentContext,
                        uniqueValue = uniqueValue
                    }))
                end
                if rhs then
                    tinsert(treeNode.children, convertNode(rhs, nodeId .. "_rhs", "comparison_side", false, {
                        node = node,
                        nodeId = nodeId,
                        field = "rhs",
                        context = currentContext,
                        uniqueValue = uniqueValue
                    }))
                end
            elseif valueType == ASTValue.ValueType.MATH then
                -- Math operation
                local valueData = ASTValue.GetValueData(node)
                local op = valueData and valueData.op or "OpAdd"
                local opSymbol = ASTValue.MathOpToSymbol(op)
                local lhs = valueData and valueData.lhs
                local rhs = valueData and valueData.rhs
                local lhsStr = lhs and EditorUtils.FormatValueNode(lhs) or "?"
                local rhsStr = rhs and EditorUtils.FormatValueNode(rhs) or "?"
                treeNode.text = format("|cFFFF8800Math %s:|r (%s %s %s)", opSymbol, lhsStr, opSymbol, rhsStr)

                tinsert(details, "|cFFFF8800Math Operation|r")
                tinsert(details, format("Operator: %s", opSymbol))
                tinsert(details, format("Left: %s", lhsStr))
                tinsert(details, format("Right: %s", rhsStr))

                if lhs then
                    tinsert(treeNode.children, convertNode(lhs, nodeId .. "_lhs", "math_side", false, {
                        node = node,
                        nodeId = nodeId,
                        field = "lhs",
                        context = currentContext,
                        uniqueValue = uniqueValue
                    }))
                end
                if rhs then
                    tinsert(treeNode.children, convertNode(rhs, nodeId .. "_rhs", "math_side", false, {
                        node = node,
                        nodeId = nodeId,
                        field = "rhs",
                        context = currentContext,
                        uniqueValue = uniqueValue
                    }))
                end
            elseif valueType == ASTValue.ValueType.CONST then
                -- Constant
                local valueData = ASTValue.GetValueData(node)
                local constVal = valueData and valueData.val or "?"
                treeNode.text = format("|cFFFFFFFF%s|r", tostring(constVal))
                tinsert(details, format("Constant: %s", tostring(constVal)))
            elseif valueType == ASTValue.ValueType.VARIABLE_REF then
                -- Variable reference - display as "VariableRef: variable-name"
                local valueData = ASTValue.GetValueData(node)
                local varName = valueData and valueData.name
                if varName then
                    -- Extract from const value if nested (shouldn't happen but handle gracefully)
                    if type(varName) == "table" then
                        if varName.type == ASTCore.NodeType.VALUE then
                            varName = ASTValue.GetConstValue(varName)
                        elseif varName.value then
                            -- Might be wrapped in { value = "name" } structure
                            varName = varName.value
                        end
                    end
                    if varName and varName ~= "" then
                        treeNode.text = format("|cFFFF00FFVariableRef:|r %s", tostring(varName))
                        tinsert(details, "|cFFFF00FFVariable Reference|r")
                        tinsert(details, format("Variable Name: %s", tostring(varName)))
                    else
                        treeNode.text = "|cFFFF00FFVariableRef:|r (empty)"
                        tinsert(details, "|cFFFF00FFVariable Reference|r")
                        tinsert(details, "Variable Name: (empty)")
                    end
                else
                    treeNode.text = "|cFFFF00FFVariableRef:|r (unknown)"
                    tinsert(details, "|cFFFF00FFVariable Reference|r")
                    tinsert(details, "Variable Name: (unknown)")
                end
            else
                -- Function call value node (valueType is function name like "aura_is_active")
                local valueData = ASTValue.GetValueData(node)
                local SchemaUtils = ns.SchemaUtils
                local functionName = valueType or ""
                local displayName = SchemaUtils and SchemaUtils:SnakeToPascal(functionName) or functionName

                if functionName == "" then
                    treeNode.text = "|cFFFF00FF[Select Function]()|r"
                else
                    -- Try to extract spell ID from first argument for display
                    local spellId = nil
                    if valueData then
                        local FieldFormatConverter = ns.FieldFormatConverter
                        if FieldFormatConverter then
                            -- Use FieldFormatConverter for consistent extraction
                            if valueData.spell_id then
                                spellId = FieldFormatConverter:ExtractActionID(valueData.spell_id)
                            elseif valueData.aura_id then
                                spellId = FieldFormatConverter:ExtractActionID(valueData.aura_id)
                            end
                        else
                            -- Fallback to manual extraction if FieldFormatConverter unavailable
                            NAG:Warn("[ASTEditor] FALLBACK TRACKING: Using manual extraction fallback in GetSpellIdFromValueNode() (FieldFormatConverter unavailable)")
                            if valueData.spell_id then
                                spellId = valueData.spell_id.spell_id or valueData.spell_id.id or valueData.spell_id
                            elseif valueData.aura_id then
                                spellId = valueData.aura_id.spell_id or valueData.aura_id.id or valueData.aura_id
                            end
                        end
                    end

                    local SchemaValidator = NAG:GetModule("SchemaValidator")
                    if spellId and tonumber(spellId) and SchemaValidator and SchemaValidator:IsArgumentIDType(functionName, 1) then
                        local displayText = EditorUtils.FormatSpellOrItemDisplay(spellId)
                        treeNode.text = format("|cFFFF00FF%s:|r %s", displayName, displayText)
                    else
                        treeNode.text = format("|cFFFF00FF%s()|r", displayName)
                    end
                end

                tinsert(details, "|cFFFF00FFFunction Call|r")
                tinsert(details, format("Name: %s (%s)", displayName, functionName))

                -- Extract arguments from valueData for display
                if valueData then
                    local argCount = 0
                    for _ in pairs(valueData) do
                        argCount = argCount + 1
                    end
                    if argCount > 0 then
                        tinsert(details, format("Arguments: %d", argCount))
                    end
                end

                -- Add complex argument children (if any are value nodes)
                if valueData then
                    local argIndex = 0
                    for fieldName, fieldValue in pairs(valueData) do
                        if fieldValue and type(fieldValue) == "table" and fieldValue.type then
                            argIndex = argIndex + 1
                            tinsert(treeNode.children, convertNode(fieldValue, nodeId .. "_arg" .. argIndex, "function_arg", false, {
                                node = node,
                                nodeId = nodeId,
                                field = fieldName,
                                index = argIndex,
                                context = currentContext,
                                uniqueValue = uniqueValue
                            }))
                        end
                    end
                end
            end
        -- Legacy clause format nodes should not exist
        elseif ntype == "logical" or ntype == "comparison" or ntype == "math" or ntype == "function" then
            NAG:Warn(format("[ASTEditor] Legacy clause format node detected: type='%s' - should be proto AST", tostring(ntype)))
            treeNode.text = format("|cFFFF0000[ERROR: Legacy Format] %s|r", tostring(ntype))
            tinsert(details, "|cFFFF0000ERROR: Legacy clause format node detected|r")
            tinsert(details, "This node should have been converted to proto AST")
        elseif ntype == "math" then
            local op = node.operator or "?"
            local lhsStr = EditorUtils.FormatValueNode(node.lhs)
            local rhsStr = EditorUtils.FormatValueNode(node.rhs)
            treeNode.text = format("|cFFFF8800Math %s:|r (%s %s %s)", op, lhsStr, op, rhsStr)

            tinsert(details, "|cFFFF8800Math Operation|r")
            tinsert(details, format("Operator: %s", op))
            tinsert(details, format("Left: %s", lhsStr))
            tinsert(details, format("Right: %s", rhsStr))

            -- Add lhs and rhs as child nodes for full recursive-descent display
            -- Use semantic paths without counter for structural children
            if node.lhs then
                tinsert(treeNode.children, convertNode(node.lhs, nodeId .. "_lhs", "math_side", false, {
                    node = node,
                    nodeId = nodeId,
                    field = "lhs",
                    context = currentContext,
                    uniqueValue = uniqueValue
                }))
            end
            if node.rhs then
                tinsert(treeNode.children, convertNode(node.rhs, nodeId .. "_rhs", "math_side", false, {
                    node = node,
                    nodeId = nodeId,
                    field = "rhs",
                    context = currentContext,
                    uniqueValue = uniqueValue
                }))
            end
        -- Handle proto AST action nodes
        elseif ntype == ASTCore.NodeType.ACTION and actionType then
            -- Proto AST action node
            local SchemaUtils = ns.SchemaUtils
            local displayName = SchemaUtils and SchemaUtils:SnakeToPascal(actionType) or actionType

            -- Extract spell/item ID for display using shared helper
            local argId = EditorUtils.GetActionFirstArgID(node, actionType)

            local SchemaValidator = NAG:GetModule("SchemaValidator")
            -- Special handling for OverlayText - use FormatActionNode for consistent display
            if actionType == "overlay_text" then
                local formattedAction = EditorUtils.FormatActionNode(node)
                treeNode.text = format("|cFFFFFF00%s|r", formattedAction)
            elseif argId and tonumber(argId) and SchemaValidator and SchemaValidator:IsArgumentIDType(actionType, 1) then
                local displayText = EditorUtils.FormatSpellOrItemDisplay(argId)
                treeNode.text = format("|cFFFFFF00%s:|r %s", displayName, displayText)
            else
                -- Use FormatActionNode for other actions to get consistent formatting
                local formattedAction = EditorUtils.FormatActionNode(node)
                treeNode.text = format("|cFFFFFF00%s|r", formattedAction)
            end

            -- Use FormatActionNode to get formatted display (e.g., "OverlayText: SBSS" instead of just "OverlayText()")
            local formattedAction = EditorUtils.FormatActionNode(node)
            tinsert(details, format("|cFFFFFF00Action: %s|r", formattedAction))
            tinsert(details, format("Action Type: %s", actionType))
            if argId and SchemaValidator and SchemaValidator:IsArgumentIDType(actionType, 1) then
                tinsert(details, format("Spell/Item ID: %s", tostring(argId)))
            end
        -- Handle legacy clause format action nodes
        elseif ntype == "action" then
            -- Legacy format action nodes - should not exist
            NAG:Warn(format("[ASTEditor] Legacy clause format action node detected - should be proto AST"))
            treeNode.text = "|cFFFF0000[ERROR: Legacy Format Action]|r"
            tinsert(details, "|cFFFF0000ERROR: Legacy clause format action node detected|r")
            tinsert(details, "This node should have been converted to proto AST") -- Close else block for non-empty action nodes
        elseif ntype == "constant" then
            local constValue = node.value
            local valueStr = tostring(constValue or "")
            treeNode.text = format("|cFFFFAA00[constant]|r %s", valueStr)

            tinsert(details, "|cFFFFAA00Constant Value|r")
            tinsert(details, format("Value: %s", valueStr))
            tinsert(details, format("Type: %s", type(constValue)))
        else
            -- Legacy format processing removed
            -- Check if this is a parse failure (has parseError field)
            if node.parseError then
                    -- Parse failed - show error prominently
                    local errorIcon = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14:14:0:0|t"
                    local displayText = node.text or "Parse Failed"
                    -- Try to format from proto AST if available (for display)
                    if not displayText or displayText == "Parse Failed" then
                        local ASTCore = ns.ASTCore
                        if node.type == ASTCore.NodeType.ACTION then
                            displayText = EditorUtils.FormatActionNode(node) or "Parse Failed"
                        elseif node.type == ASTCore.NodeType.VALUE then
                            displayText = EditorUtils.FormatValueNode(node) or "Parse Failed"
                        end
                    end
                    if #displayText > 40 then
                        displayText = displayText:sub(1, 37) .. "..."
                    end
                    treeNode.text = format("%s |cFFFF4444PARSE FAILED:|r |cFFAAAAAA%s|r", errorIcon, displayText)
                    tinsert(details, "|cFFFF4444PARSE ERROR|r")
                    tinsert(details, format("Error: %s", node.parseError))
                    -- Debug: Try to format text for display
                    local debugText = "N/A"
                    local ASTCore = ns.ASTCore
                    if node.type == ASTCore.NodeType.ACTION then
                        debugText = EditorUtils.FormatActionNode(node) or "N/A"
                    elseif node.type == ASTCore.NodeType.VALUE then
                        debugText = EditorUtils.FormatValueNode(node) or "N/A"
                    end
                    tinsert(details, format("Formatted Text: %s", debugText))
                else
                    -- Generic node without parse error
                    treeNode.text = format("|cFFAAAAAA[%s]|r", ntype)
                    tinsert(details, format("Node Type: %s", ntype))
                end
        end

        -- Detect fallback patterns and add warning icon
        local hasFallback = false
        local fallbackReason = nil
        local fallbackLevel = "Warn"

        -- Check for empty function name in proto AST function call value nodes
        if ntype == ASTCore.NodeType.VALUE then
            local valueType = ASTValue.GetValueType(node)
            -- Function call if valueType is not a known operator/constant
            if valueType and valueType ~= ASTValue.ValueType.CONST and
               valueType ~= ASTValue.ValueType.AND and valueType ~= ASTValue.ValueType.OR and
               valueType ~= ASTValue.ValueType.NOT and valueType ~= ASTValue.ValueType.CMP and
               valueType ~= ASTValue.ValueType.MATH and
               valueType ~= ASTValue.ValueType.MIN and valueType ~= ASTValue.ValueType.MAX then
                -- This is a function call - check if it's valid
                if not valueType or valueType == "" then
                    hasFallback = true
                    fallbackReason = "Empty function name - no APLValue selected"
                    treeNode.text = "|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:14:14:0:0|t " .. treeNode.text
                    tinsert(details, "|cFFFF0000WARNING: " .. fallbackReason .. "|r")
                end
            end
        elseif ntype == "generic" and node.parseError then
            -- Parse error - already has error icon from above, add detailed error info
            hasFallback = true
            fallbackReason = "Parse error: " .. (node.parseError or "Unknown")
            tinsert(details, "|cFFFF4444SUGGESTED FIX:|r Check syntax, ensure proper NAG:FunctionName(args) format")
        elseif ntype == ASTCore.NodeType.ACTION then
            local actualActionType = ASTAction.GetActionType(node)
            if not actualActionType then
                -- Proto AST should always have valid action types - nil indicates invalid structure
                hasFallback = true
                fallbackReason = "Invalid action node: GetActionType returned nil (proto structure missing or invalid)"
                treeNode.text = "|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:14:14:0:0|t " .. treeNode.text
                tinsert(details, "|cFFFF0000ERROR: " .. fallbackReason .. "|r")
                fallbackLevel = "Error"
                -- Log error for debugging
                local actionKeys = {}
                if node.action then
                    for k in pairs(node.action) do
                        tinsert(actionKeys, tostring(k))
                    end
                end
                NAG:Error(format("[ASTEditor] Invalid action node: GetActionType returned nil (action keys=[%s]) - proto structure may be missing or invalid",
                    table.concat(actionKeys, ", ")))
            elseif actualActionType and not resolvedActionMetadata then
                -- Missing schema metadata for action - this is an error, not a fallback pattern
                -- Check if GetActionType returns a valid action type
                local actionKeys = {}
                if node.action then
                    for k in pairs(node.action) do
                        tinsert(actionKeys, tostring(k))
                    end
                end
                -- Use ASTSchemaEmitter for text synthesis
                NAG:Warn(format("[Action Metadata Error] No metadata found for actionType='%s' (GetActionType=%s, action keys=[%s]) - schema may be incomplete or proto structure missing",
                    tostring(actualActionType),
                    tostring(actualActionType), table.concat(actionKeys, ", ")))
                hasFallback = true
                fallbackReason = format("Missing schema metadata for action '%s'", tostring(actualActionType))
                treeNode.text = "|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:14:14:0:0|t " .. treeNode.text
                tinsert(details, "|cFFFF0000ERROR: " .. fallbackReason .. "|r")
                fallbackLevel = "Error"
            end
        -- Check for missing operator in proto AST comparison/math nodes
        elseif ntype == ASTCore.NodeType.VALUE then
            local valueType = ASTValue.GetValueType(node)
            if (valueType == ASTValue.ValueType.CMP or valueType == ASTValue.ValueType.MATH) then
                local valueData = ASTValue.GetValueData(node)
                if not valueData or not valueData.op then
                    hasFallback = true
                    fallbackReason = "Missing operator in proto AST node"
                    treeNode.text = "|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:14:14:0:0|t " .. treeNode.text
                    tinsert(details, "|cFFFFAA00WARNING: " .. fallbackReason .. "|r")
                end
            end
        end

        if hasFallback and fallbackReason then
            local extraDetail = {}
            if node.parseError then
                extraDetail.parseError = node.parseError
            end
            if parentMeta and parentMeta.context then
                extraDetail.parentContext = parentMeta.context
            end
            EmitASTFallbackTelemetry(
                clause,
                clauseIdx,
                editorState,
                nodeId,
                uniqueValue,
                node,
                ntype,
                fallbackReason,
                fallbackLevel,
                extraDetail
            )
        end

        -- Store node reference for editing
        convertNodeCallCount = convertNodeCallCount + 1
        local detail = {
            details = details,
            node = node,
            nodeType = nodeType,
            parentNode = parentMeta and parentMeta.node or nil,
            parentId = parentMeta and parentMeta.nodeId or nil,
            parentField = parentMeta and parentMeta.field or nil,
            parentIndex = parentMeta and parentMeta.index or nil,
            context = parentMeta and parentMeta.context or currentContext,
            uniqueValue = uniqueValue,
            hasFallback = hasFallback,
            fallbackReason = fallbackReason
        }
        nodeDetails[nodeId] = detail
        nodeDetailsByUniqueValue[uniqueValue] = detail

        return treeNode
    end

    -- Build tree structure
    -- Priority is the array index (clauseIdx)
    local displayPriority = clauseIdx
    local tree = { {
        value = "root",
        text = format("Priority %d", displayPriority),
        children = {}
    } }

    -- Add condition node if present
    if conditionAST then
        local condNode = convertNode(conditionAST, "root_cond", "condition", true, {
            node = listItem,
            nodeId = "root",
            field = "condition",
            context = "condition",
            uniqueValue = "root"
        })
        condNode.text = "|cFFCCCCCCCondition:|r " .. condNode.text
        tinsert(tree[1].children, condNode)
    end

    -- Add action node (skip for variables - they only have values, not actions)
    -- Check if this is a variable by checking if clauseIdx is a variable index
    local isVariable = clauseIdx and EditorUtils and EditorUtils.IsVariableIndex and EditorUtils.IsVariableIndex(clauseIdx)

    if actionAST and not isVariable then
        -- Verify proto structure before convertNode
        local actionType = ASTAction.GetActionType(actionAST)

        local actNode = convertNode(actionAST, "root_act", "action", true, {
            node = listItem,
            nodeId = "root",
            field = "action",
            context = "action",
            uniqueValue = "root"
        })
        actNode.text = "|cFFCCCCCCAction:|r " .. actNode.text
        tinsert(tree[1].children, actNode)

        -- Verification removed - too verbose for hot path
    end

    return tree, nodeDetails, nodeDetailsByUniqueValue
end

-- ============================ CONTEXT MENU HOOKS ============================

local function GetWidgetName(widget)
    if not widget then
        return "<nil>"
    end

    if type(widget) == "table" then
        if widget.GetName then
            local ok, result = pcall(widget.GetName, widget)
            if ok and result and result ~= "" then
                return result
            end
        end

        local frame = widget.frame
        if frame and frame.GetName then
            local ok, result = pcall(frame.GetName, frame)
            if ok and result and result ~= "" then
                return result
            end
        end
    elseif type(widget) == "userdata" and widget.GetName then
        local ok, result = pcall(widget.GetName, widget)
        if ok and result and result ~= "" then
            return result
        end
    end

    return tostring(widget)
end

function ASTEditor:SetupNodeContextMenu(treeGroup, clauseIdx, editorState)
    if not treeGroup then
        return
    end

    NAG:Debug("[ASTEditor] SetupNodeContextMenu: Setting up context menu hook (clauseIdx=%s)", tostring(clauseIdx))

    -- Store clauseIdx and editorState on the treeGroup so the hook can access the current values
    treeGroup._nagClauseIdx = clauseIdx
    treeGroup._nagEditorState = editorState

    HookRefreshTree(treeGroup, "ContextMenuRefresh", function(obj)
        -- Read clauseIdx dynamically from the treeGroup instead of closure
        local currentClauseIdx = obj._nagClauseIdx
        local currentEditorState = obj._nagEditorState
        NAG:Debug("[ASTEditor] HookRefreshTree callback triggered (clauseIdx=%s, buttons=%s)",
            tostring(currentClauseIdx), obj.buttons and next(obj.buttons) and "exists" or "none")
        self:SetupNodeContextMenuButtons(obj, currentClauseIdx, currentEditorState)
    end)

    self:SetupNodeContextMenuButtons(treeGroup, clauseIdx, editorState)
end

--- CRITICAL: TreeGroup Button Frame Hook Management
---
--- TreeGroup button frames persist forever (global names: AceGUI30TreeButton1, etc.)
--- and are never destroyed. We use raw frame:HookScript() (NOT AceHook) because:
--- 1. Buttons are persistent frames that survive RefreshTree - hooks must survive too
--- 2. AceHook throws errors when re-hooking already hooked frames
--- 3. HookScript allows multiple hooks on same frame/script without errors
--- 4. We make hooks harmless by clearing _nagEditorOwned and other data they check
---
--- This is the correct pattern for mass-hooking persistent UI frames that refresh often.
---
--- @param treeGroup table TreeGroup widget
--- @param clauseIdx number Clause index
--- @param editorState table Editor state
function ASTEditor:SetupNodeContextMenuButtons(treeGroup, clauseIdx, editorState)
    if not treeGroup then
        NAG:Debug("[ASTEditor] SetupNodeContextMenuButtons: treeGroup is nil")
        return
    end

    local buttons = treeGroup.buttons
    if not buttons or not next(buttons) then
        NAG:Debug("[ASTEditor] SetupNodeContextMenuButtons: No buttons found (clauseIdx=%s)", tostring(clauseIdx))
        return
    end

    local NodeEditors = ns.RotationEditorNodeEditors
    if not NodeEditors or not NodeEditors.ShowNodeContextMenu then
        NAG:Debug("[ASTEditor] SetupNodeContextMenuButtons: NodeEditors.ShowNodeContextMenu not available")
        return
    end

    local buttonCount = 0
    local hookedCount = 0
    local skippedCount = 0

    for idx, rawButton in pairs(buttons) do
        buttonCount = buttonCount + 1
        local button = rawButton
        local frame = button and (button.frame or button)
        local hasHookScript = frame and frame.HookScript
        local hasRegister = frame and frame.RegisterForClicks

        -- Skip navigation tree nodes (clause_X, group_X, variable_X, etc.)
        -- These are handled by SetupUnifiedTreeContextMenu, not SetupNodeContextMenu
        -- SetupNodeContextMenu is ONLY for AST nodes inside the editors (root_cond, root_act, etc.)
        if button.value and (button.value:match("^clause_%d+$") or button.value:match("^group_%d+") or button.value:match("^variable_%d+$") or button.value:match("^groups_root$") or button.value:match("^clauses_root$")) then
            -- Don't hook navigation nodes - they have their own context menu
            skippedCount = skippedCount + 1
        elseif frame and hasHookScript then
            -- Always update clauseIdx and editorState on button (even if already hooked)
            rawButton._nagClauseIdx = clauseIdx
            rawButton._nagEditorState = editorState

            if not rawButton._nagContextMenuHooked then
                rawButton._nagContextMenuHooked = true
                hookedCount = hookedCount + 1
                if hasRegister then
                    frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                end
                frame:HookScript("OnMouseUp", function(btn, mouseButton)
                    -- Read clauseIdx dynamically from button instead of closure
                    local currentClauseIdx = rawButton._nagClauseIdx
                    local currentEditorState = rawButton._nagEditorState
                    if mouseButton == "RightButton" then
                        NAG:Debug("[ASTEditor] OnMouseUp RightButton: button.value=%s, clauseIdx=%s",
                            tostring(button.value), tostring(currentClauseIdx))
                        NodeEditors:ShowNodeContextMenu(btn, button.value, currentClauseIdx, currentEditorState)
                    end
                end)
                NAG:Debug("[ASTEditor] SetupNodeContextMenuButtons: Hooked button (value=%s, clauseIdx=%s)",
                    tostring(button.value), tostring(clauseIdx))
            end
        else
            NAG:Debug("[ASTEditor] SetupNodeContextMenuButtons: Skipped button (value=%s, hasFrame=%s, hasHookScript=%s)",
                tostring(button.value), tostring(frame ~= nil), tostring(hasHookScript))
        end
    end

    NAG:Debug("[ASTEditor] SetupNodeContextMenuButtons: Complete (clauseIdx=%s, total=%d, hooked=%d, skipped=%d)",
        tostring(clauseIdx), buttonCount, hookedCount, skippedCount)
end

--- Setup context menu for clause tree (left side rotation clauses)
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state
function ASTEditor:SetupClauseTreeContextMenu(treeGroup, editorState)
    if not treeGroup then
        return
    end

    -- Hook RefreshTree to ensure context menu handlers are applied after refresh
    HookRefreshTree(treeGroup, "ClauseContextMenuRefresh", function(obj)
        self:SetupClauseTreeContextMenuButtons(obj, editorState)
    end)

    self:SetupClauseTreeContextMenuButtons(treeGroup, editorState)
end

--- Setup context menu buttons for clause tree
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state
function ASTEditor:SetupClauseTreeContextMenuButtons(treeGroup, editorState)
    if not treeGroup then
        return
    end

    local buttons = treeGroup.buttons
    if not buttons or not next(buttons) then
        return
    end

    for idx, rawButton in pairs(buttons) do
        local button = rawButton
        local frame = button and (button.frame or button)
        local hasHookScript = frame and frame.HookScript
        local hasRegister = frame and frame.RegisterForClicks

        if frame and hasHookScript and button.value then
            -- Parse clause index from button value
            local clauseIdx = tonumber(button.value:match("clause_(%d+)"))

            -- ONLY hook clause nodes (not groups/variables nodes)
            if clauseIdx and not rawButton._nagClauseContextMenuHooked then
                rawButton._nagClauseContextMenuHooked = true
                if hasRegister then
                    frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                end
                frame:HookScript("OnMouseUp", function(btn, mouseButton)
                    -- Double-check we're still on a clause node before showing menu
                    if mouseButton == "RightButton" and button.value and button.value:match("clause_(%d+)") then
                        self:ShowClauseContextMenu(btn, clauseIdx, editorState)
                    end
                end)
            end
        end
    end
end

--- Show context menu for a clause
--- @param anchorFrame table The frame to anchor the menu to
--- @param clauseIdx number The clause index
--- @param editorState table The editor state
function ASTEditor:ShowClauseContextMenu(anchorFrame, clauseIdx, editorState)
    local clause = GetClause(editorState, clauseIdx)
    if not clause then
        return
    end

    -- Create context menu frame
    local menuFrame = CreateFrame("Frame", "NAG_ClauseContextMenu", UIParent, "UIDropDownMenuTemplate")
    local menuList = {}

    -- Insert Clause Above
    tinsert(menuList, {
        text = L["insertClauseAbove"] or "Insert Clause Above",
        notCheckable = true,
        func = function()
            -- Create new clause (proto AST list item)
            -- Priority is the array index, not a stored field
            -- Create empty action node (user will select action type)
            local ASTAction = ns.ASTAction
            local newClause = {
                action = ASTAction and ASTAction.Create(nil, nil, nil) or nil,  -- Empty action, user selects type
                notes = nil,
                hide = false
            }
            local priorityList = GetPriorityList(editorState, true)
            tinsert(priorityList, clauseIdx, newClause)

            EditorUtils.MarkDirty(editorState)
            self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
            editorState.visualEditor.treeGroup:SelectByValue("clause_" .. clauseIdx)
        end
    })

    -- Insert Clause Below
    tinsert(menuList, {
        text = L["insertClauseBelow"] or "Insert Clause Below",
        notCheckable = true,
        func = function()
            -- Create new clause (proto AST list item)
            -- Priority is the array index, not a stored field
            -- Create empty action node (user will select action type)
            local ASTAction = ns.ASTAction
            local newClause = {
                action = ASTAction and ASTAction.Create(nil, nil, nil) or nil,  -- Empty action, user selects type
                notes = nil,
                hide = false
            }
            local priorityList = GetPriorityList(editorState, true)
            tinsert(priorityList, clauseIdx + 1, newClause)

            EditorUtils.MarkDirty(editorState)
            self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
            editorState.visualEditor.treeGroup:SelectByValue("clause_" .. (clauseIdx + 1))
        end
    })

    tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator

    -- Duplicate Clause
    tinsert(menuList, {
        text = L["duplicateClause"] or "Duplicate Clause",
        notCheckable = true,
        func = function()
            -- Deep copy the clause (proto AST list item)
            local duplicateClause = EditorUtils.CopyTable(clause)
            -- Priority is the array index, not a stored field - remove if present
            duplicateClause.priority = nil
            -- Remove any legacy fields
            -- Note: originalText removed - legacy field cleanup
            duplicateClause.type = nil
            duplicateClause.condition = nil
            local priorityList = GetPriorityList(editorState, true)
            tinsert(priorityList, clauseIdx + 1, duplicateClause)

            EditorUtils.MarkDirty(editorState)
            self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
            editorState.visualEditor.treeGroup:SelectByValue("clause_" .. (clauseIdx + 1))
        end
    })

    tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator

    -- Move Up
    if clauseIdx > 1 then
        tinsert(menuList, {
            text = L["moveUp"] or "Move Up",
            notCheckable = true,
            func = function()
                self:MoveClause(clauseIdx, clauseIdx - 1, editorState)
            end
        })
    end

    -- Move Down
    local priorityList = GetPriorityList(editorState)
    if priorityList and clauseIdx < #priorityList then
        tinsert(menuList, {
            text = L["moveDown"] or "Move Down",
            notCheckable = true,
            func = function()
                self:MoveClause(clauseIdx, clauseIdx + 1, editorState)
            end
        })
    end

    tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator

    -- Enable/Disable
    -- Proto AST uses 'hide' instead of 'hidden'
    -- clause IS the listItem (from aplProto.priority_list)
    local isHidden = clause and clause.hide or false
    if isHidden then
        tinsert(menuList, {
            text = L["enable"] or "Enable",
            notCheckable = true,
            func = function()
                -- Proto AST uses 'hide' instead of 'hidden'
                clause.hide = false
                EditorUtils.MarkDirty(editorState)
                self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                EditorUtils.RefreshCurrentTab(self, editorState)
            end
        })
    else
        tinsert(menuList, {
            text = L["disable"] or "Disable",
            notCheckable = true,
            func = function()
                -- Proto AST uses 'hide' instead of 'hidden'
                clause.hide = true
                EditorUtils.MarkDirty(editorState)
                self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                EditorUtils.RefreshCurrentTab(self, editorState)
            end
        })
    end

    tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator

    -- Delete
    tinsert(menuList, {
        text = L["delete"] or "Delete",
        notCheckable = true,
        func = function()
            self:ConfirmDeleteClause(clauseIdx, editorState)
        end
    })

    tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator

    -- Reset Rotation Clauses (rotation-level undo)
    if editorState.rotationSnapshot then
        tinsert(menuList, {
            text = "|cFFFF4444" .. (L["resetRotationClauses"] or "Reset Rotation Clauses") .. "|r",
            notCheckable = true,
            func = function()
                self:UndoAllRotationChanges(editorState)
            end
        })
    end

    tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator

    -- Node Inspector
    tinsert(menuList, {
        text = "|cFF00CCFFInspect Clause|r",
        notCheckable = true,
        func = function()
            local NodeInspector = ns.RotationEditorNodeInspector
            if NodeInspector then
                -- Create node data for clause inspection
                -- Pass the full list item (clause) so NodeInspector can detect it and show notes/hide
                -- The clause tree shows action nodes, but the inspector should show the full clause structure
                local nodeData = {
                    node = clause,  -- Pass the full list item, not just clause.action
                    nodeType = "list_item",  -- Indicate this is a list item for proper detection
                    details = {
                        format("Clause %d", clauseIdx),
                        format("Priority: %d", clauseIdx)
                    }
                }
                NodeInspector:ShowInspector(nodeData, "clause_" .. clauseIdx, clauseIdx, editorState)
            end
        end
    })

    -- Show the menu
    ns.LibUIDropDownMenu:EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
end

--- Show the clause editor with AST tree visualization
--- @param container table Container widget
--- @param clauseIdx number Index of the clause to edit
--- @param editorState table The editor state for this instance
function ASTEditor:ShowClauseEditorAST(container, clauseIdx, editorState)
    local priorityList = GetPriorityList(editorState)
    NAG:Debug(format("[ShowClauseEditorAST] Called with clauseIdx=%s, priority_list count=%d",
        tostring(clauseIdx), priorityList and #priorityList or 0))
    local clause = GetClause(editorState, clauseIdx)
    if not clause then
        NAG:Warn(format("[ShowClauseEditorAST] Clause not found at index %s - structural validation issue", tostring(clauseIdx)))
        return
    end
    NAG:Debug(format("[ShowClauseEditorAST] Found clause: clauseIdx=%s (priority=%s)",
        tostring(clauseIdx), tostring(clauseIdx)))

    -- Take a snapshot of the clause for undo functionality (deep copy)
    if not editorState.clauseSnapshots then
        editorState.clauseSnapshots = {}
    end
    editorState.clauseSnapshots[clauseIdx] = EditorUtils.CopyTable(clause)

    -- TreeGroup content container uses Fill layout - it must have ONE child
    -- That child (mainContainer) uses Fill layout to fill the TreeGroup content area
    local mainContainer = AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Fill")
    mainContainer:SetFullWidth(true)
    mainContainer:SetFullHeight(true)
    container:AddChild(mainContainer)

    -- Inner container for vertical stacking of fixed elements + astContainer
    -- Uses Flow layout because it supports SetFullHeight (List layout does NOT support SetFullHeight)
    local innerContainer = AceGUI:Create("SimpleGroup")
    innerContainer:SetLayout("Flow")
    innerContainer:SetFullWidth(true)
    mainContainer:AddChild(innerContainer)

    -- Node-specific control buttons (always visible in both modes)
    -- CRITICAL: Ensure editorData exists and preserve stringEditMode state
    if not editorState.clauseEditors then
        editorState.clauseEditors = {}
    end
    if not editorState.clauseEditors[clauseIdx] then
        editorState.clauseEditors[clauseIdx] = {}
    end
    local editorData = editorState.clauseEditors[clauseIdx]
    local isStringMode = editorData.stringEditMode or false

    local nodeControlsGroup = AceGUI:Create("InlineGroup")
    nodeControlsGroup:SetLayout("Flow")
    nodeControlsGroup:SetFullWidth(true)
    nodeControlsGroup:SetTitle(L["clauseControls"] or "Clause Controls")
    innerContainer:AddChild(nodeControlsGroup)

    -- Undo Clause button (icon only)
    local undoBtn = AceGUI:Create("Icon")
    undoBtn:SetImage("Interface\\Buttons\\UI-RefreshButton")
    undoBtn:SetImageSize(24, 24)
    undoBtn:SetWidth(32)
    undoBtn:SetHeight(32)
    undoBtn:SetCallback("OnClick", function()
        self:UndoClauseChanges(clauseIdx, editorState)
    end)
    undoBtn:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["undoClauseChanges"] or "Undo Changes to This Clause", 1, 1, 1)
        GameTooltip:AddLine("Reverts this clause to when you first opened it", 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    undoBtn:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)
    nodeControlsGroup:AddChild(undoBtn)

    -- Move Up button (icon only)
    local upBtn = AceGUI:Create("Icon")
    upBtn:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")
    upBtn:SetImageSize(24, 24)
    upBtn:SetWidth(32)
    upBtn:SetHeight(32)
    if clauseIdx == 1 then
        upBtn.image:SetDesaturated(true)
        upBtn.image:SetAlpha(0.5)
        upBtn:SetDisabled(true)
    else
        upBtn.frame:HookScript("OnMouseDown", function()
            upBtn:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down")
        end)
        upBtn:SetCallback("OnClick", function()
            upBtn:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")
            self:MoveClause(clauseIdx, clauseIdx - 1, editorState)
        end)
        upBtn:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["moveUp"] or "Move Up", 1, 1, 1)
            GameTooltip:Show()
        end)
        upBtn:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
    nodeControlsGroup:AddChild(upBtn)

    -- Move Down button (icon only)
    local downBtn = AceGUI:Create("Icon")
    downBtn:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
    downBtn:SetImageSize(24, 24)
    downBtn:SetWidth(32)
    downBtn:SetHeight(32)
    local priorityList = GetPriorityList(editorState)
    if priorityList and clauseIdx == #priorityList then
        downBtn.image:SetDesaturated(true)
        downBtn.image:SetAlpha(0.5)
        downBtn:SetDisabled(true)
    else
        downBtn.frame:HookScript("OnMouseDown", function()
            downBtn:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down")
        end)
        downBtn:SetCallback("OnClick", function()
            downBtn:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
            self:MoveClause(clauseIdx, clauseIdx + 1, editorState)
        end)
        downBtn:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["moveDown"] or "Move Down", 1, 1, 1)
            GameTooltip:Show()
        end)
        downBtn:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
    nodeControlsGroup:AddChild(downBtn)

    -- Delete button (icon only)
    local deleteBtn = AceGUI:Create("Icon")
    deleteBtn:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
    deleteBtn:SetImageSize(24, 24)
    deleteBtn:SetWidth(32)
    deleteBtn:SetHeight(32)
    deleteBtn:SetCallback("OnClick", function()
        self:DeleteClause(clauseIdx, editorState)
    end)
    deleteBtn:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["delete"] or "Delete", 1, 1, 1)
        GameTooltip:Show()
    end)
    deleteBtn:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)
    nodeControlsGroup:AddChild(deleteBtn)

    -- Disable/Enable button (icon only)
    local toggleHiddenBtn = AceGUI:Create("Icon")
    -- Proto AST uses 'hide' instead of 'hidden'
    -- clause IS the listItem (from aplProto.priority_list)
    local isHidden = clause and clause.hide or false
    if isHidden then
        toggleHiddenBtn:SetImage("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
    else
        toggleHiddenBtn:SetImage("Interface\\Buttons\\UI-GuildButton-PublicNote-Disabled")
    end
    toggleHiddenBtn:SetImageSize(24, 24)
    toggleHiddenBtn:SetWidth(32)
    toggleHiddenBtn:SetHeight(32)
    toggleHiddenBtn:SetCallback("OnClick", function()
        -- Proto AST uses 'hide' instead of 'hidden'
        clause.hide = not clause.hide
        EditorUtils.MarkDirty(editorState)
        self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
        EditorUtils.RefreshCurrentTab(ASTEditor, editorState)
    end)
    toggleHiddenBtn:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
        -- Proto AST uses 'hide' instead of 'hidden'
        local isHidden = clause and clause.hide or false
        if isHidden then
            GameTooltip:SetText(L["enable"] or "Enable", 1, 1, 1)
        else
            GameTooltip:SetText(L["disable"] or "Disable", 1, 1, 1)
        end
        GameTooltip:Show()
    end)
    toggleHiddenBtn:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)
    nodeControlsGroup:AddChild(toggleHiddenBtn)

    -- Expand All button (icon only, disabled in string mode)
    local expandAllBtn = AceGUI:Create("Icon")
    expandAllBtn:SetImage("Interface\\Buttons\\UI-PlusButton-Up")
    expandAllBtn:SetImageSize(24, 24)
    expandAllBtn:SetWidth(32)
    expandAllBtn:SetHeight(32)
    if isStringMode then
        expandAllBtn.image:SetDesaturated(true)
        expandAllBtn.image:SetAlpha(0.5)
        expandAllBtn:SetDisabled(true)
    else
        expandAllBtn:SetCallback("OnClick", function()
            local editorData = editorState.clauseEditors[clauseIdx]
            if editorData and editorData.astTreeGroup and editorData.treeData then
                ExpandAllNodes(editorData.astTreeGroup, editorData.treeData, editorState, clauseIdx)
            end
        end)
        expandAllBtn:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["expandAll"] or "Expand All", 1, 1, 1)
            GameTooltip:Show()
        end)
        expandAllBtn:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
    nodeControlsGroup:AddChild(expandAllBtn)

    -- Collapse All button (icon only, disabled in string mode)
    local collapseAllBtn = AceGUI:Create("Icon")
    collapseAllBtn:SetImage("Interface\\Buttons\\UI-MinusButton-Up")
    collapseAllBtn:SetImageSize(24, 24)
    collapseAllBtn:SetWidth(32)
    collapseAllBtn:SetHeight(32)
    if isStringMode then
        collapseAllBtn.image:SetDesaturated(true)
        collapseAllBtn.image:SetAlpha(0.5)
        collapseAllBtn:SetDisabled(true)
    else
        collapseAllBtn:SetCallback("OnClick", function()
            local editorData = editorState.clauseEditors[clauseIdx]
            if editorData and editorData.astTreeGroup then
                CollapseAllNodes(editorData.astTreeGroup, editorState, clauseIdx)
            end
        end)
        collapseAllBtn:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["collapseAll"] or "Collapse All", 1, 1, 1)
            GameTooltip:Show()
        end)
        collapseAllBtn:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
    nodeControlsGroup:AddChild(collapseAllBtn)

    -- Toggle Comparison Nodes button (icon only, disabled in string mode)
    local toggleCompBtn = AceGUI:Create("Icon")
    toggleCompBtn:SetImage("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
    toggleCompBtn:SetImageSize(24, 24)
    toggleCompBtn:SetWidth(32)
    toggleCompBtn:SetHeight(32)
    if isStringMode then
        toggleCompBtn.image:SetDesaturated(true)
        toggleCompBtn.image:SetAlpha(0.5)
        toggleCompBtn:SetDisabled(true)
    else
        toggleCompBtn:SetCallback("OnClick", function()
            local editorData = editorState.clauseEditors[clauseIdx]
            if editorData and editorData.astTreeGroup and editorData.treeData and editorData.nodeDetailsByUniqueValue then
                ToggleComparisonNodes(
                    editorData.astTreeGroup,
                    editorData.treeData,
                    editorData.nodeDetailsByUniqueValue,
                    editorState,
                    clauseIdx
                )
            end
        end)
        toggleCompBtn:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["toggleComparisons"] or "Toggle Comparisons", 1, 1, 1)
            GameTooltip:AddLine("Collapse/expand comparison lhs/rhs to shrink tree", 0.8, 0.8, 0.8, true)
            GameTooltip:Show()
        end)
        toggleCompBtn:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
    nodeControlsGroup:AddChild(toggleCompBtn)

    -- String Edit Toggle button (icon only, always enabled)
    local stringEditToggleBtn = AceGUI:Create("Icon")
    if isStringMode then
        stringEditToggleBtn:SetImage("Interface\\Icons\\INV_Misc_Book_09")
    else
        stringEditToggleBtn:SetImage("Interface\\Icons\\INV_Misc_Note_01")
    end
    stringEditToggleBtn:SetImageSize(24, 24)
    stringEditToggleBtn:SetWidth(32)
    stringEditToggleBtn:SetHeight(32)
    stringEditToggleBtn:SetCallback("OnClick", function()
        local editorData = editorState.clauseEditors[clauseIdx]
        if not editorData then
            if not editorState.clauseEditors then
                editorState.clauseEditors = {}
            end
            editorState.clauseEditors[clauseIdx] = {}
            editorData = editorState.clauseEditors[clauseIdx]
        end

        editorData.stringEditMode = not editorData.stringEditMode

        if editorState.visualEditor and editorState.visualEditor.treeGroup then
            local treeGroup = editorState.visualEditor.treeGroup
            treeGroup:Fire("OnGroupSelected", "clause_" .. clauseIdx)
        end
    end)
    stringEditToggleBtn:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
        if isStringMode then
            GameTooltip:SetText(L["treeEdit"] or "Tree Edit Mode", 1, 1, 1)
        else
            GameTooltip:SetText(L["stringEdit"] or "String Edit Mode", 1, 1, 1)
        end
        GameTooltip:Show()
    end)
    stringEditToggleBtn:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)
    nodeControlsGroup:AddChild(stringEditToggleBtn)

    -- Notes/Comment editor (optional)
    local notesGroup = AceGUI:Create("InlineGroup")
    notesGroup:SetTitle(L["notesOptional"] or "Notes/Comment (optional)")
    notesGroup:SetLayout("Flow")
    notesGroup:SetFullWidth(true)
    innerContainer:AddChild(notesGroup)

    -- Notes field (consolidates old block/inline comments)
    local notesEdit = AceGUI:Create("EditBox")
    notesEdit:SetLabel(L["notes"] or "Notes (appears before action)")
    notesEdit:SetFullWidth(true)
    local notesText = clause.notes or ""
    -- Strip leading -- for display, will add back on conversion
    local displayText = notesText:match("^%-%-%s*(.*)") or notesText
    notesEdit:SetText(displayText)
    notesEdit:SetCallback("OnTextChanged", function(widget, event, text)
        if text and text ~= "" then
            -- Store without -- prefix, conversion will add it
            clause.notes = text
        else
            clause.notes = nil
        end
        EditorUtils.MarkDirty(editorState)
    end)
    notesGroup:AddChild(notesEdit)

    -- Check if we should show string editors or AST tree
    if isStringMode then
        -- Show string editors for condition and action
        self:ShowStringEditors(innerContainer, clause, clauseIdx, editorState)
    else
        -- AST Tree View and Editor
        -- astContainer uses Fill layout for its child (TreeGroup) to fill available space
        -- Added to innerContainer - will fill remaining space (List layout handles this naturally via SetFullHeight)
        local astContainer = AceGUI:Create("SimpleGroup")
        astContainer:SetLayout("Fill")   -- Fill layout for TreeGroup child to fill astContainer
        astContainer:SetFullWidth(true)
        astContainer:SetFullHeight(true) -- Fill remaining space in List layout parent
        innerContainer:AddChild(astContainer)

        -- CRITICAL: Check if tree data already exists and clause hasn't changed
        -- This prevents unnecessary convertNode calls when just switching between clauses
        local clauseEditorData = editorState.clauseEditors and editorState.clauseEditors[clauseIdx]
        local tree, nodeDetails, nodeDetailsByUniqueValue

        if clauseEditorData and clauseEditorData.treeData and clauseEditorData.clause == clause then
            -- Reuse existing tree data - clause hasn't changed, no need to rebuild
            NAG:Debug(format("[ShowClauseEditorAST] Reusing cached tree data for clause %d", clauseIdx))
            tree = clauseEditorData.treeData
            nodeDetails = clauseEditorData.nodeDetails
            nodeDetailsByUniqueValue = clauseEditorData.nodeDetailsByUniqueValue
        else
            -- Build AST tree for this clause (clause is now a list item from proto AST)
            NAG:Debug(format("[ShowClauseEditorAST] Building new tree for clause %d (clause changed or no cache)", clauseIdx))
            local listItem = clause  -- aplProto.priority_list contains list items
            tree, nodeDetails, nodeDetailsByUniqueValue = self:BuildClauseASTTree(listItem, editorState, clauseIdx)
        end

        -- CRITICAL: Condition is part of clause.action.condition in proto AST, not stored separately

        -- Create TreeGroup for AST visualization
        local treeGroup = ns.CreateTreeGroup()
        treeGroup:SetFullWidth(true)
        treeGroup:SetFullHeight(true)
        treeGroup:SetLayout("Fill")
        treeGroup.noAutoHeight = true -- Prevent auto-sizing - let parent container control height

        -- Set tree width to ~60% (350 pixels, leaving ~40% for edit panel on right)
        -- CRITICAL: Each clause needs its own status table to avoid widget reuse
        if not editorState.clauseTreeStatus then
            editorState.clauseTreeStatus = {}
        end
        if not editorState.clauseTreeStatus[clauseIdx] then
            editorState.clauseTreeStatus[clauseIdx] = {
                groups = {},
                treewidth = 350,
                treesizable = true,
                scrollvalue = 0
            }
        end
        treeGroup:SetStatusTable(editorState.clauseTreeStatus[clauseIdx])
        local persistedWidth = editorState.clauseTreeStatus[clauseIdx].treewidth or 350
        treeGroup:SetTreeWidth(persistedWidth, true)

        treeGroup:SetTree(tree)
        astContainer:AddChild(treeGroup)

        self:SetupNodeContextMenu(treeGroup, clauseIdx, editorState)

        -- Store for later use (AFTER creating treeGroup so we can reference it)
        if not editorState.clauseEditors then
            editorState.clauseEditors = {}
        end
        editorState.clauseEditors[clauseIdx] = editorState.clauseEditors[clauseIdx] or {}
        local clauseEditorData = editorState.clauseEditors[clauseIdx]
        clauseEditorData.clause = clause
        clauseEditorData.clauseIdx = clauseIdx -- Store clauseIdx for verification
        clauseEditorData.nodeDetails = nodeDetails
        clauseEditorData.nodeDetailsByUniqueValue = nodeDetailsByUniqueValue
        clauseEditorData.treeData = tree
        clauseEditorData.astTreeGroup = treeGroup -- Store reference for RefreshASTTree and button operations
        -- Condition is part of clause.action.condition in proto AST, not stored separately

        -- Handle node selection - show edit panel
        treeGroup:SetCallback("OnGroupSelected", function(treeContainer, event, group)
            treeContainer:ReleaseChildren()

            local editorData = editorState.clauseEditors and editorState.clauseEditors[clauseIdx]
            if editorData then
                editorData.lastSelection = group
            end

            -- Ensure TreeGroup content container uses Fill layout for ScrollFrame
            if treeContainer.SetLayout then
                treeContainer:SetLayout("Fill")

                -- CRITICAL: Ensure TreeGroup is sized before adding children
                -- TreeGroup's OnWidthSet sizes content frame, but it may not have been called yet
                -- Trigger layout to ensure sizing propagates through hierarchy
                if treeContainer.frame and treeContainer.frame:GetWidth() and treeContainer.frame:GetWidth() > 0 then
                    -- TreeGroup is sized - ensure OnWidthSet has been called to size content
                    if treeContainer.OnWidthSet then
                        treeContainer:OnWidthSet(treeContainer.frame:GetWidth())
                    end
                else
                    NAG:Warn("TreeGroup not sized yet! Adding children may cause layout issues.")
                end
            else
                NAG:Warn("TreeGroup.SetLayout is nil - layout may not function correctly")
            end

            -- Update the left-side Rotation Clauses tree to reflect any changes made to the clause
            -- CRITICAL: Only update if not already refreshing to prevent loops
            -- UpdateClauseTree emits all action nodes, so we should only call it when necessary
            if editorState.visualEditor and editorState.visualEditor.treeGroup then
                -- Guard: Don't update if we're in the middle of a refresh cycle
                if not editorState._updatingClauseTree then
                    editorState._updatingClauseTree = true
                    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                    editorState._updatingClauseTree = nil
                end
            end

            -- Extract node ID from tree path (TreeGroup uses \001 as separator)
            local nodeID = group
            if group and group:find("\001") then
                nodeID = group:match("[^\001]+$")
            end

            -- Always render the edit panel if the node exists in the latest lookup tables
            NAG:Debug(format("[OnGroupSelected] Looking for node: nodeID=%s, group=%s (clauseIdx=%s)",
                tostring(nodeID), tostring(group):gsub("\001", " → "), tostring(clauseIdx)))

            local nodeData, lookupMethod = EditorUtils.FindNodeDetail(editorData, nodeID, group, true)
            local nodeExists = nodeData ~= nil

            -- Fallback: check local nodeDetails (from BuildClauseASTTree return)
            if not nodeExists and nodeDetails and nodeDetails[nodeID] then
                nodeExists = true
                nodeData = nodeDetails[nodeID]
                lookupMethod = "local nodeDetails[nodeID]"
            end

            if nodeExists and nodeData then
                NAG:Debug(format("[OnGroupSelected] Node found via %s: nodeID=%s, nodeType=%s",
                    lookupMethod, tostring(nodeID), tostring(nodeData.nodeType)))
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors then
                    NodeEditors:RenderNodeEditPanel(treeContainer, nodeID, clause, clauseIdx, editorState)
                end
            else
                -- Debug: Log when node is not found to help diagnose issues
                local nodeDetailsCount = editorData and editorData.nodeDetails and (ns.TableUtils and ns.TableUtils.Size(editorData.nodeDetails) or "unknown") or "0"
                local uniqueValueCount = editorData and editorData.nodeDetailsByUniqueValue and (ns.TableUtils and ns.TableUtils.Size(editorData.nodeDetailsByUniqueValue) or "unknown") or "0"
                NAG:Debug(format("[OnGroupSelected] Node not found: nodeID=%s, group=%s, hasEditorData=%s, hasNodeDetails=%s, hasNodeDetailsByUniqueValue=%s, nodeDetailsCount=%s, uniqueValueCount=%s",
                    tostring(nodeID), tostring(group):gsub("\001", " → "),
                    tostring(editorData ~= nil),
                    tostring(editorData and editorData.nodeDetails ~= nil),
                    tostring(editorData and editorData.nodeDetailsByUniqueValue ~= nil),
                    nodeDetailsCount, uniqueValueCount))

                -- Show sample keys from nodeDetails and nodeDetailsByUniqueValue
                if editorData and editorData.nodeDetails then
                    local sampleKeys = {}
                    local keyCount = 0
                    for key in pairs(editorData.nodeDetails) do
                        keyCount = keyCount + 1
                        if keyCount <= 5 then
                            table.insert(sampleKeys, tostring(key))
                        end
                    end
                    if #sampleKeys > 0 then
                        NAG:Debug(format("[OnGroupSelected] Sample nodeDetails keys (first 5): %s", table.concat(sampleKeys, ", ")))
                    end
                end
                if editorData and editorData.nodeDetailsByUniqueValue then
                    local sampleKeys = {}
                    local keyCount = 0
                    for key in pairs(editorData.nodeDetailsByUniqueValue) do
                        keyCount = keyCount + 1
                        if keyCount <= 5 then
                            -- CRITICAL: Ensure key is converted to string and sampleKeys is a table
                            if type(sampleKeys) == "table" and key then
                                local keyStr = tostring(key)
                                if keyStr and keyStr ~= "" then
                                    tinsert(sampleKeys, keyStr:gsub("\001", " → "))
                                end
                            end
                        end
                    end
                    if #sampleKeys > 0 then
                        NAG:Debug(format("[OnGroupSelected] Sample uniqueValue keys (first 5): %s", table.concat(sampleKeys, ", ")))
                    end
                end
            end
        end)

        -- Select root by default
        treeGroup:SelectByPath("root")
    end -- end of else (AST tree mode)
end

--- Show string editors for condition and action with APL autocomplete
--- @param container table Container widget
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function ASTEditor:ShowStringEditors(container, clause, clauseIdx, editorState)
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")

    -- Container for both editors
    local editorsContainer = AceGUI:Create("SimpleGroup")
    editorsContainer:SetLayout("Flow")
    editorsContainer:SetFullWidth(true)
    editorsContainer:SetFullHeight(true)
    container:AddChild(editorsContainer)

    -- Condition Editor
    local conditionGroup = AceGUI:Create("InlineGroup")
    conditionGroup:SetTitle("Condition")
    conditionGroup:SetLayout("Flow")
    conditionGroup:SetFullWidth(true)
    conditionGroup:SetHeight(250)
    editorsContainer:AddChild(conditionGroup)

    local conditionEditor = AceGUI:Create("MultiLineEditBox")
    conditionEditor:SetLabel("Edit condition string")
    conditionEditor:SetFullWidth(true)
    conditionEditor:SetNumLines(8)

    -- Enable syntax highlighting
    local SyntaxHL = ns.RotationEditorSyntaxHighlighting
    if SyntaxHL and conditionEditor.editBox then
        SyntaxHL.EnableAPLSyntaxHighlighting(conditionEditor.editBox, 4, {
            preserveExistingIndent = true
        })
    end

    -- Set current condition text from proto AST (condition is on action, not clause)
    local conditionAST = clause.action and clause.action.condition
    local conditionText = ""
    if conditionAST then
        -- Use ASTSchemaEmitter to get text from proto AST
        local ASTSchemaEmitter = ns.ASTSchemaEmitter
        if ASTSchemaEmitter then
            conditionText = ASTSchemaEmitter.EmitValueNode(conditionAST) or ""
        end
    end
    conditionEditor:SetText(conditionText)

    conditionGroup:AddChild(conditionEditor)

    -- Add APL autocomplete for conditions (Values)
    local valuesData = SchemaAccessor and SchemaAccessor:GetAutocompleteData("Values")
    if valuesData and APLAutocomplete then
        APLAutocomplete:AddToEditBox(conditionEditor, valuesData, "Values", function(entry, widget)
            -- Insert selected entry at cursor
            local text = widget:GetText() or ""
            local cursorPos = widget.editBox:GetCursorPosition()
            local beforeCursor = text:sub(1, cursorPos)
            local afterCursor = text:sub(cursorPos + 1)

            -- Replace word at cursor with entry name
            local newBefore = beforeCursor:gsub("[%w_:]+$", entry.name)
            widget:SetText(newBefore .. afterCursor)
            widget.editBox:SetCursorPosition(#newBefore)
        end)
    end

    -- OnEnterPressed callback to sync condition changes
    conditionEditor:SetCallback("OnEnterPressed", function(widget, event, text)
        -- Parse condition text to proto AST and store on action.condition
        -- Use ParseClause for consistency with actual parser behavior
        if text and text ~= "" then
            local NAGStringParser = NAG:GetModule("NAGStringParser")
            if NAGStringParser then
                local clauseResult = NAGStringParser:ParseClause(text, nil, nil)
                local conditionAST = nil
                if clauseResult then
                    -- Extract value from clause result (could be in value or condition field)
                    conditionAST = clauseResult.value or clauseResult.condition
                end
                if conditionAST then
                    if not clause.action then
                        -- Create empty action if missing
                        clause.action = ASTAction.CreateFromFields("cast_spell", {}, nil)
                    end
                    clause.action.condition = conditionAST
                end
            end
        else
            -- Empty condition - set to nil
            if clause.action then
                clause.action.condition = nil
            end
        end

        EditorUtils.MarkDirty(editorState)
        self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)

        NAG:Print("|cFF00FF00Condition updated! Click main Save to commit.|r")
    end)

    -- Action Editor
    local actionGroup = AceGUI:Create("InlineGroup")
    actionGroup:SetTitle("Action")
    actionGroup:SetLayout("Flow")
    actionGroup:SetFullWidth(true)
    actionGroup:SetHeight(250)
    editorsContainer:AddChild(actionGroup)

    local actionEditor = AceGUI:Create("MultiLineEditBox")
    actionEditor:SetLabel("Edit action string")
    actionEditor:SetFullWidth(true)
    actionEditor:SetNumLines(8)

    -- Enable syntax highlighting
    if SyntaxHL and actionEditor.editBox then
        SyntaxHL.EnableAPLSyntaxHighlighting(actionEditor.editBox, 4, {
            preserveExistingIndent = true
        })
    end

    -- Set current action text - synthesize from proto AST
    local actionText = ""
    if clause.action then
        local ASTSchemaEmitter = ns.ASTSchemaEmitter
        local ASTCore = ns.ASTCore
        if ASTSchemaEmitter and clause.action.type == ASTCore.NodeType.ACTION then
            actionText = ASTSchemaEmitter.EmitActionNode(clause.action) or ""
        end
    end
    actionEditor:SetText(actionText)

    actionGroup:AddChild(actionEditor)

    -- Add APL autocomplete for actions (Actions)
    local actionsData = SchemaAccessor and SchemaAccessor:GetAutocompleteData("Actions")
    if actionsData and APLAutocomplete then
        APLAutocomplete:AddToEditBox(actionEditor, actionsData, "Actions", function(entry, widget)
            -- Insert selected entry at cursor
            local text = widget:GetText() or ""
            local cursorPos = widget.editBox:GetCursorPosition()
            local beforeCursor = text:sub(1, cursorPos)
            local afterCursor = text:sub(cursorPos + 1)

            -- Replace word at cursor with entry name
            local newBefore = beforeCursor:gsub("[%w_:]+$", entry.name)
            widget:SetText(newBefore .. afterCursor)
            widget.editBox:SetCursorPosition(#newBefore)
        end)
    end

    -- OnEnterPressed callback to sync action changes
    actionEditor:SetCallback("OnEnterPressed", function(widget, event, text)
        if text and text ~= "" then
            if not clause.action then
                clause.action = {}
            end
            -- Store text for text editor mode (not originalText - that's deprecated)
            clause.action.text = text
        end

        EditorUtils.MarkDirty(editorState)
        self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)

        NAG:Print("|cFF00FF00Action updated! Click main Save to commit.|r")
    end)
end

--- Refresh the AST tree visualization after modifications
--- @param clause table The clause being edited (or fakeClause for group actions)
--- @param clauseIdx number The clause index (or fake index for group actions)
--- @param editorState table The editor state
function ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
    local ASTAction = ns.ASTAction
    -- Handle group actions
    local isGroupAction = EditorUtils.IsGroupActionIndex(clauseIdx)
    local editorData

    if isGroupAction then
        local groupIdx, actionIdx = EditorUtils.DecodeGroupActionIndex(clauseIdx)
        local actionKey = "group_" .. groupIdx .. "_action_" .. actionIdx
        editorData = editorState.groupActionEditors and editorState.groupActionEditors[actionKey]
    else
        editorData = editorState.clauseEditors and editorState.clauseEditors[clauseIdx]
    end

    if not editorData or not editorData.astTreeGroup then
        return
    end

    -- Guard against infinite recursion
    if editorData._refreshing then
        return
    end
    editorData._refreshing = true

    -- Invalidate tooltip cache when tree is refreshed (data has changed)
    if editorState.tooltipCache then
        editorState.tooltipCache = {}
    end

    local astTreeGroup = editorData.astTreeGroup

    -- Store current selection to restore after refresh. NodeEditors may set a pendingSelection override.
    local currentSelection = editorData.pendingSelection or astTreeGroup.selected

    local tree, nodeDetails, nodeDetailsByUniqueValue

    if isGroupAction then
        -- Group actions: Use stored actionAST and sync to canonical storage
        local actionAST = editorData.actionAST

        if actionAST and not skipRebuild then
            -- Sync action AST to canonical storage (config.groups[x].actions[y])
            local NodeEditors = ns.RotationEditorNodeEditors
            if NodeEditors and NodeEditors.SyncActionToCanonicalStorage then
                NodeEditors:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
            end
        end

        -- Rebuild tree from clause (which has the action AST) - clause is now a list item
        local listItem = clause
        tree, nodeDetails, nodeDetailsByUniqueValue = self:BuildClauseASTTree(listItem, editorState, clauseIdx)
        editorData.actionAST = clause.action
    else
        -- Regular clauses: Always use BuildClauseASTTree which reads condition from action.condition
        -- Condition is part of action.condition in proto AST, not stored separately
        local listItem = clause
        -- CRITICAL: Verify proto structure before rebuilding tree
        -- Verification removed - too verbose for hot path
        tree, nodeDetails, nodeDetailsByUniqueValue = self:BuildClauseASTTree(listItem, editorState, clauseIdx)
        -- CRITICAL: Verify proto structure after rebuilding tree
        -- Verification removed - too verbose for hot path
    end

    -- Update stored data
    editorData.treeData = tree
    editorData.nodeDetails = nodeDetails
    editorData.nodeDetailsByUniqueValue = nodeDetailsByUniqueValue

    -- Clear refresh guard
    editorData._refreshing = nil

    -- Update the tree display
    astTreeGroup:SetTree(tree)
    self:SetupNodeContextMenu(astTreeGroup, clauseIdx, editorState)

    -- Refresh any open Node Inspector windows for this clause
    -- CRITICAL: SetTree is synchronous, so we can refresh immediately
    local NodeInspector = ns.RotationEditorNodeInspector
    if NodeInspector and NodeInspector.RefreshInspectorsForClause then
        NodeInspector:RefreshInspectorsForClause(clauseIdx, editorState)
    end

    -- Restore selection (or select root if selection no longer exists)
    -- CRITICAL: SetTree is synchronous, so we can select immediately
    if astTreeGroup and astTreeGroup.SelectByValue then
        -- Try to reselect the same node
        if currentSelection then
            astTreeGroup:SelectByValue(currentSelection)
            -- Get the correct editorData based on type
            local finalEditorData
            if isGroupAction then
                local groupIdx, actionIdx = EditorUtils.DecodeGroupActionIndex(clauseIdx)
                local actionKey = "group_" .. groupIdx .. "_action_" .. actionIdx
                finalEditorData = editorState.groupActionEditors and editorState.groupActionEditors[actionKey]
            else
                finalEditorData = editorState.clauseEditors and editorState.clauseEditors[clauseIdx]
            end
            if finalEditorData then
                finalEditorData.lastSelection = astTreeGroup.selected
            end
        else
            astTreeGroup:SelectByValue("root")
            -- Get the correct editorData based on type
            local finalEditorData
            if isGroupAction then
                local groupIdx, actionIdx = EditorUtils.DecodeGroupActionIndex(clauseIdx)
                local actionKey = "group_" .. groupIdx .. "_action_" .. actionIdx
                finalEditorData = editorState.groupActionEditors and editorState.groupActionEditors[actionKey]
            else
                finalEditorData = editorState.clauseEditors and editorState.clauseEditors[clauseIdx]
            end
            if finalEditorData then
                finalEditorData.lastSelection = astTreeGroup.selected
            end
        end
    end
end

-- ~~~~~~~~~~ CLAUSE TREE MANAGEMENT ~~~~~~~~~~

--- Create the clause tree on the left side
--- @param parent table Parent container
--- @param editorState table The editor state for this instance
--- @return table TreeGroup widget
function ASTEditor:CreateClauseTree(parent, editorState)
    local treeGroup = ns.CreateTreeGroup()
    treeGroup:SetLayout("Fill")
    treeGroup:SetFullWidth(true)  -- TreeGroup creates its own internal two-column layout
    treeGroup:SetFullHeight(true)
    treeGroup.noAutoHeight = true -- Prevent auto-sizing - let parent container control height

    -- Disable AceGUI's built-in tooltips (we use our own custom tooltips)
    if treeGroup.EnableButtonTooltips then
        treeGroup:EnableButtonTooltips(false)
    end

    -- Set up status table for persisting tree state (BEFORE adding to parent)
    if not editorState.treeStatus then
        editorState.treeStatus = {
            groups = { ["root"] = true }, -- Root expanded by default
            treewidth = 260,
            treesizable = true,
            scrollvalue = 0
        }
    end
    treeGroup:SetStatusTable(editorState.treeStatus)

    -- Enable resizable divider with persisted width (BEFORE adding to parent)
    local persistedWidth = editorState.treeStatus.treewidth or 260
    treeGroup:SetTreeWidth(persistedWidth, true)

    -- Add to parent after configuration
    parent:AddChild(treeGroup)

    -- Setup drag handlers hook (must be done before UpdateClauseTree)
    self:SetupDragHandlers(treeGroup, editorState)

    -- Setup tooltips hook (must be done before UpdateClauseTree)
    -- Note: Tooltips will be set up via RefreshTree hook, but we also call it here
    -- in case buttons already exist after UpdateClauseTree
    self:SetupClauseTooltips(treeGroup, editorState)

    -- Setup unified context menu for all tree nodes
    self:SetupUnifiedTreeContextMenu(treeGroup, editorState)

    -- Build tree structure
    self:UpdateClauseTree(treeGroup, editorState)

    -- Selection callback
    treeGroup:SetCallback("OnGroupSelected", function(container, event, group)
        -- Extract the actual node ID from hierarchical path FIRST (AceGUI uses \001 as separator)
        -- e.g., "groups_root\001group_1" -> "group_1"
        local nodeId = group
        local readablePath = group
        if group and group:find("\001") then
            nodeId = group:match("[^\001]+$") or group
            -- Replace \001 with " → " for readable debug output
            readablePath = group:gsub("\001", " → ")
        end

        NAG:Debug(format("[OnGroupSelected] Node clicked: %s (extracted: %s)", readablePath, tostring(nodeId)))

        if editorState then
            editorState.lastSelectedNode = group
        end
        container:ReleaseChildren()

        -- Check if this is a groups/variables node
        if nodeId == "groups_root" or nodeId:match("^group_") or nodeId:match("^variable_") then
            NAG:Debug(format("[OnGroupSelected] Routing to NodeEditors for: %s", tostring(nodeId)))
            local NodeEditors = ns.RotationEditorNodeEditors
            if NodeEditors then
                NodeEditors:RenderNodeEditPanel(container, nodeId, nil, nil, editorState)
            else
                NAG:Warn("[OnGroupSelected] NodeEditors module not found!")
            end
            return
        end

        -- Parse clause index from node ID (e.g., "clause_1" -> 1)
        local clauseIdx = tonumber(nodeId:match("clause_(%d+)"))
        if clauseIdx then
            NAG:Debug(format("[OnGroupSelected] Routing to clause editor for clause: %d", clauseIdx))
            self:ShowClauseEditorAST(container, clauseIdx, editorState)
        else
            NAG:Debug("[OnGroupSelected] No match, showing root editor")
            self:ShowRootEditor(container, editorState)
        end
    end)

    return treeGroup
end

--- Update the clause tree with current clauses
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state for this instance
function ASTEditor:UpdateClauseTree(treeGroup, editorState)
    -- Guard: Prevent recursive calls
    if editorState._updatingClauseTree then
        return
    end
    editorState._updatingClauseTree = true

    -- Invalidate tooltip cache when clause tree is updated (data has changed)
    -- This ensures tooltips show correct data after reordering, adding, or deleting clauses
    if editorState.tooltipCache then
        editorState.tooltipCache = {}
    end

    local config = editorState.workingConfig

    local tree = {
        -- Root 1: Rotation Clauses
        {
            value = "clauses_root",
            text = "Rotation Clauses (" .. (#(GetPriorityList(editorState) or {})) .. ")",
            children = {}
        },
        -- Root 2: Groups & Variables
        {
            value = "groups_root",
            text = "Groups & Variables",
            children = {}
        }
    }

    -- Build clause nodes (existing logic)
    local priorityList = GetPriorityList(editorState) or {}
    for i, clause in ipairs(priorityList) do
        local actionText = EditorUtils.GetClauseActionSummary(clause)

        -- Dim text if hidden
        local nodeText
        -- Proto AST uses 'hide' instead of 'hidden'
        -- clause IS the listItem (from aplProto.priority_list)
        local isHidden = clause and clause.hide or false
        if isHidden then
            nodeText = format("|cFF666666%d. %s|r", i, actionText) -- Grey text for hidden clauses
        else
            nodeText = format("%d. %s", i, actionText)
        end

        tinsert(tree[1].children, {
            value = "clause_" .. i,
            text = nodeText
        })
    end

    -- Build groups nodes (NEW)
    for i, group in ipairs(config.groups or {}) do
        local groupNode = {
            value = "group_" .. i,
            text = format("|cFF00FF00%s|r (%d actions)", group.name or "Unnamed", #(group.actions or {})),
            children = {}
        }

        -- Add action children
        for j, action in ipairs(group.actions or {}) do
            local preview = tostring(action):sub(1, 40)
            if #tostring(action) > 40 then preview = preview .. "..." end
            tinsert(groupNode.children, {
                value = "group_" .. i .. "_action_" .. j,
                text = format("|cFFFFAA00Action %d:|r %s", j, preview)
            })
        end

        tinsert(tree[2].children, groupNode)
    end

    -- Build variables nodes (NEW)
    for i, variable in ipairs(config.variables or {}) do
        tinsert(tree[2].children, {
            value = "variable_" .. i,
            text = format("|cFF00CCFF%s|r", variable.name or "Unnamed")
        })
    end

    treeGroup:SetTree(tree)

    -- CRITICAL: Explicitly refresh tree display to ensure visual updates
    -- SetTree should trigger refresh automatically, but explicit call ensures it happens
    if treeGroup.RefreshTree then
        -- Force full refresh with filter parameter
        treeGroup:RefreshTree(nil, true)
    end

    -- Drag handlers are setup automatically via RefreshTree hook

    -- Clear guard
    editorState._updatingClauseTree = nil
end

-- ~~~~~~~~~~ CLAUSE OPERATIONS ~~~~~~~~~~

--- Show the root editor (for adding new clauses)
--- @param container table Container widget
--- @param editorState table The editor state for this instance
function ASTEditor:ShowRootEditor(container, editorState)
    local group = AceGUI:Create("SimpleGroup")
    group:SetLayout("Flow")
    group:SetFullWidth(true)
    group:SetFullHeight(true)
    container:AddChild(group)

    local heading = AceGUI:Create("Heading")
    heading:SetText(L["rotationClauses"] or "Rotation Clauses")
    heading:SetFullWidth(true)
    group:AddChild(heading)

    local desc = AceGUI:Create("Label")
    desc:SetText(L["clauseEditDesc"] or "Select a clause from the tree to edit it, or add a new clause below.")
    desc:SetFullWidth(true)
    group:AddChild(desc)

    -- Rotation-level undo button (reset all clauses)
    if editorState.rotationSnapshot then
        local undoAllBtn = AceGUI:Create("Button")
        undoAllBtn:SetText("|TInterface\\Buttons\\UI-RefreshButton:16:16|t |cFFFF4444" ..
        (L["resetRotationClauses"] or "Reset Rotation Clauses") .. "|r")
        undoAllBtn:SetWidth(200)
        undoAllBtn:SetCallback("OnClick", function()
            self:UndoAllRotationChanges(editorState)
        end)
        group:AddChild(undoAllBtn)
    end

    local addBtn = AceGUI:Create("Button")
    addBtn:SetText(L["addNewClause"] or "Add New Clause")
    addBtn:SetWidth(150)
    addBtn:SetCallback("OnClick", function()
        self:AddClause(editorState)
    end)
    group:AddChild(addBtn)
end

--- Add a new clause to the rotation
--- @param editorState table The editor state for this instance
function ASTEditor:AddClause(editorState)
    NAG:Trace("[ROT-SYNC] AddClause: ENTRY")
    -- Create new clause (proto AST list item)
    -- CRITICAL: Priority is the array index, not a stored field
    -- Create empty action node (user will select action type)
    local ASTAction = ns.ASTAction
    local newClause = {
        action = ASTAction and ASTAction.Create(nil, nil, nil) or nil,  -- Empty action, user selects type
        notes = nil,
        hide = false
    }

    local priorityList = GetPriorityList(editorState, true)
    local oldCount = #priorityList
    tinsert(priorityList, newClause)
    local newCount = #priorityList
    NAG:Info("[ROT-SYNC] AddClause: Clause added | old count=%d | new count=%d", oldCount, newCount)

    EditorUtils.MarkDirty(editorState)

    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    local priorityList = GetPriorityList(editorState)
    editorState.visualEditor.treeGroup:SelectByValue("clause_" .. (priorityList and #priorityList or 0))
    NAG:Trace("[ROT-SYNC] AddClause: EXIT")
end

--- Move a clause to a different position
--- @param fromIdx number Current index
--- @param toIdx number Target index
--- @param editorState table The editor state for this instance
function ASTEditor:MoveClause(fromIdx, toIdx, editorState)
    NAG:Trace("[ROT-SYNC] MoveClause: ENTRY | fromIdx=%d | toIdx=%d", fromIdx, toIdx)
    local priorityList = GetPriorityList(editorState)
    if not priorityList then
        NAG:Error("[ROT-SYNC] MoveClause: aplProto or priority_list missing")
        return
    end
    local clause = tremove(priorityList, fromIdx)
    tinsert(priorityList, toIdx, clause)
    NAG:Info("[ROT-SYNC] MoveClause: Clause moved | fromIdx=%d | toIdx=%d", fromIdx, toIdx)

    -- CRITICAL: Priority is the array index, not a stored field - no need to update

    EditorUtils.MarkDirty(editorState)

    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("clause_" .. toIdx)
    NAG:Trace("[ROT-SYNC] MoveClause: EXIT")
end

--- Delete a clause from the rotation
--- @param clauseIdx number Index of the clause to delete
--- @param editorState table The editor state for this instance
function ASTEditor:DeleteClause(clauseIdx, editorState)
    NAG:Trace("[ROT-SYNC] DeleteClause: ENTRY | clauseIdx=%d", clauseIdx)
    local priorityList = GetPriorityList(editorState)
    if not priorityList then
        NAG:Error("[ROT-SYNC] DeleteClause: aplProto or priority_list missing")
        return
    end

    local oldCount = #priorityList
    NAG:Debug("[ROT-SYNC] DeleteClause: Before deletion | priority_list count=%d", oldCount)

    tremove(priorityList, clauseIdx)

    local newCount = #priorityList
    NAG:Info("[ROT-SYNC] DeleteClause: Clause removed | old count=%d | new count=%d", oldCount, newCount)

    -- CRITICAL: Priority is the array index, not a stored field - no need to update

    EditorUtils.MarkDirty(editorState)

    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)

    -- Select previous clause or root
    if clauseIdx > 1 then
        editorState.visualEditor.treeGroup:SelectByValue("clause_" .. (clauseIdx - 1))
    else
        editorState.visualEditor.treeGroup:SelectByValue("root")
    end

    NAG:Trace("[ROT-SYNC] DeleteClause: EXIT")
end

--- Reset rotation clauses to original state (restore from snapshot)
--- Note: This only resets the rotation clauses, not other tabs like properties/prepull/etc
--- @param editorState table The editor state for this instance
function ASTEditor:UndoAllRotationChanges(editorState)
    local snapshot = editorState.rotationSnapshot
    if not snapshot then
        NAG:Print("|cFFFF8800No rotation undo snapshot available|r")
        return
    end

    -- Restore priority_list from snapshot (deep copy to avoid reference issues)
    -- CRITICAL: Priority is the array index - no need to store it separately
    if not editorState.workingConfig.aplProto then
        NAG:Error("UndoAllRotationChanges: aplProto not available")
        return
    end
    if not snapshot or not snapshot.priority_list then
        NAG:Error("UndoAllRotationChanges: snapshot.priority_list not available")
        return
    end
    local priorityList = GetPriorityList(editorState, true)
    -- Clear and restore from snapshot
    for i = #priorityList, 1, -1 do
        tremove(priorityList, i)
    end
    for i, clause in ipairs(snapshot.priority_list) do
        tinsert(priorityList, EditorUtils.CopyTable(clause))
    end

    -- Clear clause snapshots since we've restored everything
    editorState.clauseSnapshots = {}

    -- CLEAR dirty flag since we're reverting to original state
    editorState.isDirty = false

    -- Update the clause list tree on the left
    if editorState.visualEditor and editorState.visualEditor.treeGroup then
        self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    end

    -- Select root or first clause
    if editorState.visualEditor and editorState.visualEditor.treeGroup then
            local priorityList = GetPriorityList(editorState)
            if priorityList and #priorityList > 0 then
            editorState.visualEditor.treeGroup:SelectByValue("clause_1")
        else
            editorState.visualEditor.treeGroup:SelectByValue("root")
        end
    end

    NAG:Print("|cFF00FF00Rotation clauses reset to original!|r")
end

--- Undo all changes to the current clause (restore from snapshot)
--- @param clauseIdx number Index of the clause to restore
--- @param editorState table The editor state for this instance
function ASTEditor:UndoClauseChanges(clauseIdx, editorState)
    local snapshot = editorState.clauseSnapshots and editorState.clauseSnapshots[clauseIdx]
    if not snapshot then
        NAG:Print("|cFFFF8800No undo snapshot available for this clause|r")
        return
    end

    -- Restore the clause from snapshot (deep copy to avoid reference issues)
    local priorityList = GetPriorityList(editorState)
    if not priorityList then
        NAG:Error("UndoClauseChanges: aplProto.priority_list not available")
        return
    end
    local restoredClause = EditorUtils.CopyTable(snapshot)
    local priorityList = GetPriorityList(editorState, true)
    priorityList[clauseIdx] = restoredClause

    -- Mark as dirty since we're changing the working config
    EditorUtils.MarkDirty(editorState)

    -- Update the clause list tree on the left
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)

    -- Refresh the current clause editor view
    EditorUtils.RefreshCurrentTab(ASTEditor, editorState)

    NAG:Print("|cFF00FF00Clause restored to original state!|r")
end

--- Sync visual editor changes back to text format
--- @param editorState table The editor state for this instance
--- @param format boolean|nil If true, apply pretty formatting to the output
function ASTEditor:SyncVisualToText(editorState, format)
    NAG:Trace("[ROT-SYNC] SyncVisualToText: ENTRY | format=%s", tostring(format))
    if not editorState.workingConfig.aplProto then
        NAG:Error("[ROT-SYNC] SyncVisualToText: aplProto is nil")
        return
    end

    -- aplProto.priority_list is the canonical storage - no syncing needed
    -- Use ASTSchemaEmitter to synthesize rotation string from proto AST
    local ASTSchemaEmitter = ns.ASTSchemaEmitter
    if not ASTSchemaEmitter or not ASTSchemaEmitter.EmitRotationString then
        NAG:Error("[ROT-SYNC] SyncVisualToText: ASTSchemaEmitter not available")
        return
    end

    NAG:Debug("[ROT-SYNC] SyncVisualToText: Emitting rotationString from aplProto")
    local rotationString, emitErr = ASTSchemaEmitter.EmitRotationString(editorState.workingConfig.aplProto, {
        format = format
    })

    if not rotationString then
        NAG:Error("[ROT-SYNC] SyncVisualToText: Failed to emit rotation string: " .. tostring(emitErr))
        return
    end
    NAG:Debug("[ROT-SYNC] SyncVisualToText: Emitted rotationString length=%d", #rotationString)

    -- NEW: Apply formatting if requested
    if format then
        local LuaFormatter = ns.LuaFormatter
        if LuaFormatter then
            local formattedString, err = LuaFormatter.FormatRotationString(rotationString,
                { indentSize = 4, maxLineLength = 100 })
            if formattedString then
                rotationString = formattedString
            else
                NAG:Debug("Format failed: " .. tostring(err))
            end
        else
            NAG:Debug("LuaFormatter not available")
        end
    end

    -- DEVELOPMENT MODE: Only update rotationString if sync is enabled
    local shouldSync = ns.USE_SYNC_ROTATION_STRING

    NAG:Debug("[ROT-SYNC] SyncVisualToText: USE_SYNC_ROTATION_STRING=%s | shouldSync=%s",
        tostring(ns.USE_SYNC_ROTATION_STRING), tostring(shouldSync))

    if shouldSync then
        local previousString = editorState.workingConfig.rotationString or ""
        if rotationString ~= previousString then
            NAG:Info("[ROT-SYNC] SyncVisualToText: UPDATING rotationString | old length=%d | new length=%d",
                #previousString, #rotationString)
            editorState.workingConfig.rotationString = rotationString
            EditorUtils.MarkDirty(editorState)
        else
            NAG:Debug("[ROT-SYNC] SyncVisualToText: rotationString unchanged (length=%d)", #rotationString)
        end
    else
        -- Development mode: Don't update rotationString, but still mark dirty for aplProto changes
        NAG:Debug("[ROT-SYNC] SyncVisualToText: SKIPPING rotationString update (dev mode) | existing length=%d | new length=%d",
            #(editorState.workingConfig.rotationString or ""), #rotationString)
        EditorUtils.MarkDirty(editorState)
    end

    -- Sync groups and variables from AST to strings
    self:SyncGroupsVariablesVisualToText(editorState)

    NAG:Trace("[ROT-SYNC] SyncVisualToText: EXIT")
end

--- Sync text editor changes to aplProto
--- @param editorState table The editor state for this instance
--- @return boolean success True if parsing succeeded
function ASTEditor:SyncTextToVisual(editorState)
    NAG:Trace("[ROT-SYNC] SyncTextToVisual: ENTRY")
    local rotationString = editorState.workingConfig.rotationString
    if not rotationString or rotationString == "" then
        NAG:Trace("[ROT-SYNC] SyncTextToVisual: EXIT - rotationString is empty")
        return false
    end

    NAG:Debug("[ROT-SYNC] SyncTextToVisual: rotationString length=%d", #rotationString)

    local conversionService = NAG:GetModule("RotationConversionService")
    if not conversionService then
        NAG:Error("[ROT-SYNC] SyncTextToVisual: RotationConversionService not available")
        return false
    end

    NAG:Debug("[ROT-SYNC] SyncTextToVisual: Parsing rotationString to aplProto")
    local protoAST, diagnostics = conversionService:ParseToProtoAST(rotationString, {
        useCache = true,
        validate = false  -- Don't validate on every keystroke
    })

    if protoAST then
        NAG:Info("[ROT-SYNC] SyncTextToVisual: Parse SUCCESS - updating workingConfig.aplProto")
        editorState.workingConfig.aplProto = protoAST
        EditorUtils.MarkDirty(editorState)

        -- Sync groups and variables from strings to AST
        self:SyncGroupsVariablesTextToVisual(editorState)

        NAG:Trace("[ROT-SYNC] SyncTextToVisual: EXIT - SUCCESS")
        return true
    else
        local parseErr = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "unknown error"
        NAG:Error("[ROT-SYNC] SyncTextToVisual: Parse failed: " .. tostring(parseErr))
        return false
    end
end

-- ~~~~~~~~~~ GROUPS & VARIABLES OPERATIONS ~~~~~~~~~~

--- Sync groups and variables from strings to AST (like SyncTextToVisual for rotationString)
--- @param editorState table The editor state for this instance
--- @return boolean success True if parsing succeeded
function ASTEditor:SyncGroupsVariablesTextToVisual(editorState)
    NAG:Trace("[ROT-SYNC] SyncGroupsVariablesTextToVisual: ENTRY")

    if not editorState.workingConfig then
        NAG:Error("[ROT-SYNC] SyncGroupsVariablesTextToVisual: workingConfig is nil")
        return false
    end

    -- Ensure aplProto exists
    if not editorState.workingConfig.aplProto then
        NAG:Debug("[ROT-SYNC] SyncGroupsVariablesTextToVisual: Creating empty aplProto")
        local ASTCore = ns.ASTCore
        editorState.workingConfig.aplProto = {
            type = ASTCore.NodeType.ROTATION,
            priority_list = {},
            groups = {},
            value_variables = {}
        }
    end

    local config = editorState.workingConfig
    local aplProto = editorState.workingConfig.aplProto
    local NAGStringParser = NAG:GetModule("NAGStringParser")
    local ASTCore = ns.ASTCore
    local ASTAction = ns.ASTAction

    if not NAGStringParser then
        NAG:Error("[ROT-SYNC] SyncGroupsVariablesTextToVisual: NAGStringParser not available")
        return false
    end

    -- Initialize groups and variables arrays in aplProto if missing
    if not aplProto.groups then
        aplProto.groups = {}
    end
    if not aplProto.value_variables then
        aplProto.value_variables = {}
    end

    -- Parse groups from strings to AST
    local groups = config.groups or {}
    NAG:Info("[ROT-SYNC] SyncGroupsVariablesTextToVisual: Parsing %d groups", #groups)

    aplProto.groups = {}
    for i, group in ipairs(groups) do
        local protoGroup = {
            type = ASTCore.NodeType.GROUP,
            name = group.name or "",
            description = group.description,
            hide = group.hide or false,
            actions = {},
            variables = {}
        }

        -- Parse each action string to AST
        for j, actionString in ipairs(group.actions or {}) do
            if actionString and actionString ~= "" then
                -- Use ParseClause to support conditions, NAG:Hidden(), and notes
                local clauseResult = NAGStringParser:ParseClause(actionString, nil, nil)
                if clauseResult and clauseResult.action then
                    -- Set condition on action if present
                    if clauseResult.condition and ASTAction then
                        ASTAction.SetCondition(clauseResult.action, clauseResult.condition)
                    end

                    tinsert(protoGroup.actions, {
                        type = ASTCore.NodeType.LIST_ITEM,
                        hide = clauseResult.hidden or false,  -- Support NAG:Hidden()
                        notes = clauseResult.notes or nil,     -- Support notes from comments
                        action = clauseResult.action,
                        -- condition is on action.condition, not here (proto structure)
                    })
                else
                    NAG:Warn("[ROT-SYNC] SyncGroupsVariablesTextToVisual: Failed to parse group %d action %d", i, j)
                    -- Create empty action as fallback
                    if ASTAction then
                        local emptyAction = ASTAction.CreateFromFields("cast_spell", {}, nil)
                        tinsert(protoGroup.actions, {
                            type = ASTCore.NodeType.LIST_ITEM,
                            hide = false,
                            notes = nil,
                            action = emptyAction,
                            condition = nil
                        })
                    end
                end
            end
        end

        tinsert(aplProto.groups, protoGroup)
    end

    -- Parse variables from strings to AST
    local variables = config.variables or {}
    NAG:Info("[ROT-SYNC] SyncGroupsVariablesTextToVisual: Parsing %d variables", #variables)

    aplProto.value_variables = {}
    for i, variable in ipairs(variables) do
        local valueAST = nil
        if variable.value and variable.value ~= "" then
            -- Use ParseClause to handle value-only parsing (automatically routes to ParseValue/ParseCondition)
            local clauseResult = NAGStringParser:ParseClause(variable.value, nil, nil)
            if clauseResult then
                -- Extract value from clause result (could be in value or condition field)
                valueAST = clauseResult.value or clauseResult.condition
            end
        end

        -- Fallback to empty constant if parsing fails
        if not valueAST then
            local ASTValue = ns.ASTValue
            if ASTValue then
                valueAST = ASTValue.CreateConst("")
            end
        end

        tinsert(aplProto.value_variables, {
            name = variable.name or "",
            hide = variable.hide or false,
            value = valueAST
        })
    end

    EditorUtils.MarkDirty(editorState)
    NAG:Trace("[ROT-SYNC] SyncGroupsVariablesTextToVisual: EXIT - SUCCESS | groups=%d | variables=%d",
        #aplProto.groups, #aplProto.value_variables)
    return true
end

--- Sync groups and variables from AST to strings (like SyncVisualToText for rotationString)
--- @param editorState table The editor state for this instance
function ASTEditor:SyncGroupsVariablesVisualToText(editorState)
    NAG:Trace("[ROT-SYNC] SyncGroupsVariablesVisualToText: ENTRY")

    if not editorState.workingConfig or not editorState.workingConfig.aplProto then
        NAG:Error("[ROT-SYNC] SyncGroupsVariablesVisualToText: aplProto is nil")
        return
    end

    local aplProto = editorState.workingConfig.aplProto
    local ASTSchemaEmitter = ns.ASTSchemaEmitter
    local ASTCore = ns.ASTCore

    if not ASTSchemaEmitter then
        NAG:Error("[ROT-SYNC] SyncGroupsVariablesVisualToText: ASTSchemaEmitter not available")
        return
    end

    -- Check sync flag (same as rotationString) - controls ALL string sync
    local shouldSync = ns.USE_SYNC_ROTATION_STRING

    NAG:Debug("[ROT-SYNC] SyncGroupsVariablesVisualToText: USE_SYNC_ROTATION_STRING=%s | shouldSync=%s",
        tostring(ns.USE_SYNC_ROTATION_STRING), tostring(shouldSync))

    -- Sync groups from AST to strings
    local groups = aplProto.groups or {}
    NAG:Info("[ROT-SYNC] SyncGroupsVariablesVisualToText: Emitting %d groups", #groups)

    if not editorState.workingConfig.groups then
        editorState.workingConfig.groups = {}
    end

    -- Ensure groups array is the right size
    while #editorState.workingConfig.groups < #groups do
        tinsert(editorState.workingConfig.groups, { name = "", actions = {} })
    end
    while #editorState.workingConfig.groups > #groups do
        tremove(editorState.workingConfig.groups)
    end

    for i, protoGroup in ipairs(groups) do
        if shouldSync then
            local group = editorState.workingConfig.groups[i]
            if not group then
                group = { name = "", actions = {} }
                editorState.workingConfig.groups[i] = group
            end

            -- Update name
            group.name = protoGroup.name or ""

            -- Emit actions from AST
            local actions = protoGroup.actions or {}
            if not group.actions then
                group.actions = {}
            end

            -- Ensure actions array is the right size
            while #group.actions < #actions do
                tinsert(group.actions, "")
            end
            while #group.actions > #actions do
                tremove(group.actions)
            end

            for j, actionItem in ipairs(actions) do
                if actionItem.action then
                    -- Emit full clause (list item) format including notes, hide, condition, and action
                    -- Group actions are sequential (not priority-based), so don't add "or " prefix
                    local actionString = ASTSchemaEmitter.EmitClause(actionItem, j, false)
                    if actionString and actionString ~= "" then
                        local previousString = group.actions[j] or ""
                        if actionString ~= previousString then
                            NAG:Info("[ROT-SYNC] SyncGroupsVariablesVisualToText: Updating group %d action %d", i, j)
                            group.actions[j] = actionString
                        end
                    else
                        NAG:Warn("[ROT-SYNC] SyncGroupsVariablesVisualToText: Failed to emit group %d action %d", i, j)
                    end
                end
            end
        end
    end

    -- Sync variables from AST to strings
    local variables = aplProto.value_variables or {}
    NAG:Info("[ROT-SYNC] SyncGroupsVariablesVisualToText: Emitting %d variables", #variables)

    if not editorState.workingConfig.variables then
        editorState.workingConfig.variables = {}
    end

    -- Ensure variables array is the right size
    while #editorState.workingConfig.variables < #variables do
        tinsert(editorState.workingConfig.variables, { name = "", value = "" })
    end
    while #editorState.workingConfig.variables > #variables do
        tremove(editorState.workingConfig.variables)
    end

    for i, protoVar in ipairs(variables) do
        if shouldSync then
            local variable = editorState.workingConfig.variables[i]
            if not variable then
                variable = { name = "", value = "" }
                editorState.workingConfig.variables[i] = variable
            end

            -- Update name
            variable.name = protoVar.name or ""

            -- Emit value from AST
            if protoVar.value then
                local valueString = ASTSchemaEmitter.EmitValueNode(protoVar.value)
                if valueString then
                    local previousString = variable.value or ""
                    if valueString ~= previousString then
                        NAG:Info("[ROT-SYNC] SyncGroupsVariablesVisualToText: Updating variable %d", i)
                        variable.value = valueString
                    end
                else
                    NAG:Warn("[ROT-SYNC] SyncGroupsVariablesVisualToText: Failed to emit variable %d", i)
                end
            else
                variable.value = ""
            end
        end
    end

    if shouldSync then
        EditorUtils.MarkDirty(editorState)
    end

    NAG:Trace("[ROT-SYNC] SyncGroupsVariablesVisualToText: EXIT | shouldSync=%s", tostring(shouldSync))
end

--- Parse node type from groups/variables node value
--- @param nodeValue string The node value
--- @return string|nil Node type or nil
function ASTEditor:ParseGroupsVariablesNodeType(nodeValue)
    if nodeValue == "groups_root" then return "groups_root" end
    if nodeValue:match("^group_%d+_action_%d+$") then return "action" end
    if nodeValue:match("^group_%d+$") then return "group" end
    if nodeValue:match("^variable_%d+$") then return "variable" end
    return nil
end

--- Add a new group
--- @param editorState table The editor state
--- @param groupData table Group data
function ASTEditor:AddGroup(editorState, groupData)
    local config = editorState.workingConfig
    config.groups = config.groups or {}
    tinsert(config.groups, groupData)

    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("group_" .. #config.groups)
end

--- Add a new variable
--- @param editorState table The editor state
--- @param variableData table Variable data
function ASTEditor:AddVariable(editorState, variableData)
    local config = editorState.workingConfig
    config.variables = config.variables or {}
    tinsert(config.variables, variableData)

    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("variable_" .. #config.variables)
end

--- Delete a group
--- @param editorState table The editor state
--- @param groupIdx number Group index
function ASTEditor:DeleteGroup(editorState, groupIdx)
    tremove(editorState.workingConfig.groups, groupIdx)
    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("groups_root")
end

--- Delete a variable
--- @param editorState table The editor state
--- @param varIdx number Variable index
function ASTEditor:DeleteVariable(editorState, varIdx)
    tremove(editorState.workingConfig.variables, varIdx)
    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("groups_root")
end

--- Duplicate a group
--- @param editorState table The editor state
--- @param groupIdx number Group index
function ASTEditor:DuplicateGroup(editorState, groupIdx)
    local original = editorState.workingConfig.groups[groupIdx]
    local duplicate = EditorUtils.CopyTable(original)
    duplicate.name = (duplicate.name or "Group") .. " (Copy)"
    tinsert(editorState.workingConfig.groups, groupIdx + 1, duplicate)

    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("group_" .. (groupIdx + 1))
end

--- Duplicate a variable
--- @param editorState table The editor state
--- @param varIdx number Variable index
function ASTEditor:DuplicateVariable(editorState, varIdx)
    local original = editorState.workingConfig.variables[varIdx]
    local duplicate = EditorUtils.CopyTable(original)
    duplicate.name = (duplicate.name or "Variable") .. " (Copy)"
    tinsert(editorState.workingConfig.variables, varIdx + 1, duplicate)

    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("variable_" .. (varIdx + 1))
end

--- Move a group
--- @param editorState table The editor state
--- @param fromIdx number From index
--- @param toIdx number To index
function ASTEditor:MoveGroup(editorState, fromIdx, toIdx)
    local group = tremove(editorState.workingConfig.groups, fromIdx)
    tinsert(editorState.workingConfig.groups, toIdx, group)

    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("group_" .. toIdx)
end

--- Move a variable
--- @param editorState table The editor state
--- @param fromIdx number From index
--- @param toIdx number To index
function ASTEditor:MoveVariable(editorState, fromIdx, toIdx)
    local variable = tremove(editorState.workingConfig.variables, fromIdx)
    tinsert(editorState.workingConfig.variables, toIdx, variable)

    EditorUtils.MarkDirty(editorState)
    self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    editorState.visualEditor.treeGroup:SelectByValue("variable_" .. toIdx)
end

-- ============================ AUTO-FIND DUPLICATE EXPRESSIONS ============================

--- Recursively collect all expressions from an AST tree
--- @param astNode table AST node to collect from
--- @param expressionMap table Map of expression -> occurrence data
--- @param clauseIdx number Current clause index
--- @param depth number Recursion depth
local function CollectAllExpressions(astNode, expressionMap, clauseIdx, depth)
    if not astNode or not astNode.type then return end

    depth = depth or 0

    -- Skip VariableRef nodes (already extracted)
    if astNode.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(astNode)
        if valueType then
            local valueData = ASTValue.GetValueData(astNode)
            if valueData and valueData.function_name == "VariableRef" then
                return
            end
        end
    end

    -- Skip simple constants (not worth extracting)
    if astNode.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(astNode)
        if valueType == ASTValue.ValueType.CONST then
            return
        end
    end

    -- Serialize this node using ASTSchemaEmitter
    local expression = ""
    if not ASTSchemaEmitter then
        NAG:Error("[ASTEditor] ASTSchemaEmitter not available (source=ASTEditor.CollectAllExpressions)")
        return
    end

    local nodeType = astNode.type
    if nodeType == ASTCore.NodeType.ACTION then
        expression = ASTSchemaEmitter.EmitActionNode(astNode) or ""
    elseif nodeType == ASTCore.NodeType.VALUE then
        expression = ASTSchemaEmitter.EmitValueNode(astNode) or ""
    else
        NAG:Error("[ASTEditor] Invalid node type: %s (source=ASTEditor.CollectAllExpressions)", tostring(nodeType))
        return
    end

    NAG:Debug("[ASTEditor] ASTEditorEmission (operation=CollectAllExpressions; nodeType=%s; success=%s)", tostring(nodeType), tostring(expression ~= ""))

    -- CRITICAL: Only track COMPLETE expressions that are meaningful to extract as variables
    -- Track: logical operators, comparisons, math operations
    -- SKIP: individual function calls (they're usually part of larger expressions)
    -- SKIP: function arguments, comparison sides (lhs/rhs), etc.
    local shouldTrack = false

    if nodeType == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(astNode)
        if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR or valueType == ASTValue.ValueType.NOT then
            -- Always track logical operators (AND/OR/NOT) - these are complete logical units
            shouldTrack = true
        elseif valueType == ASTValue.ValueType.CMP then
            -- Always track comparisons (A < B, A == B) - these are complete conditional units
            shouldTrack = true
        elseif valueType == ASTValue.ValueType.MATH then
            -- Always track math operations (A + B, A * B) - these are complete value expressions
            shouldTrack = true
        elseif depth == 0 then
            -- ONLY track function calls if they're at root level (not part of comparison/math)
            -- Example: Root-level NAG:SpellIsReady(123) is trackable
            -- Example: NAG:AuraNumStacks(44544) inside "NAG:AuraNumStacks(44544) == 2" is NOT trackable
            shouldTrack = true
        end
    elseif nodeType == ASTCore.NodeType.ACTION and depth == 0 then
        -- Root-level actions are trackable
        shouldTrack = true
    end

    if shouldTrack then
        if not expressionMap[expression] then
            expressionMap[expression] = {
                expression = expression,
                count = 0,
                clauseIndices = {},
                nodes = {}
            }
        end

        -- Track occurrence
        expressionMap[expression].count = expressionMap[expression].count + 1
        tinsert(expressionMap[expression].clauseIndices, clauseIdx)
        tinsert(expressionMap[expression].nodes, astNode)
    end

    -- Recurse into children (proto AST structure)
    if nodeType == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(astNode)
        local valueData = ASTValue.GetValueData(astNode)

        if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR then
            -- Logical operation (AND/OR) - recurse into children array
            if valueData and valueData.vals then
                for _, child in ipairs(valueData.vals) do
                    CollectAllExpressions(child, expressionMap, clauseIdx, depth + 1)
                end
            end
        elseif valueType == ASTValue.ValueType.NOT then
            -- NOT operation - recurse into single child
            if valueData and valueData.val then
                CollectAllExpressions(valueData.val, expressionMap, clauseIdx, depth + 1)
            end
        elseif valueType == ASTValue.ValueType.CMP then
            -- Comparison - recurse into lhs and rhs
            if valueData then
                if valueData.lhs then
                    CollectAllExpressions(valueData.lhs, expressionMap, clauseIdx, depth + 1)
                end
                if valueData.rhs then
                    CollectAllExpressions(valueData.rhs, expressionMap, clauseIdx, depth + 1)
                end
            end
        elseif valueType == ASTValue.ValueType.MATH then
            -- Math operation - recurse into lhs and rhs
            if valueData then
                if valueData.lhs then
                    CollectAllExpressions(valueData.lhs, expressionMap, clauseIdx, depth + 1)
                end
                if valueData.rhs then
                    CollectAllExpressions(valueData.rhs, expressionMap, clauseIdx, depth + 1)
                end
            end
        elseif valueType and valueType ~= ASTValue.ValueType.CONST then
            -- Function call - recurse into valueData fields that are AST nodes
            if valueData then
                for _, fieldValue in pairs(valueData) do
                    if fieldValue and type(fieldValue) == "table" and fieldValue.type then
                        CollectAllExpressions(fieldValue, expressionMap, clauseIdx, depth + 1)
                    end
                end
            end
        end
    elseif nodeType == ASTCore.NodeType.ACTION then
        -- Action nodes - recurse into action data fields that are AST nodes
        local actionData = ASTAction.GetActionData(astNode)
        if actionData then
            for _, fieldValue in pairs(actionData) do
                if fieldValue and type(fieldValue) == "table" and fieldValue.type then
                    CollectAllExpressions(fieldValue, expressionMap, clauseIdx, depth + 1)
                end
            end
        end
    end
end

--- Generate a readable variable name from an expression
--- @param expression string Serialized expression
--- @return string Generated variable name
local function GenerateVariableNameFromExpression(expression)
    -- Extract meaningful parts from expression
    local name = expression

    -- Extract function names (e.g., "NAG:Health()" -> "health")
    if name:match("NAG:(%w+)%(") then
        name = name:match("NAG:(%w+)%("):lower()
    end

    -- Handle comparisons (e.g., "NAG:Health() < 50" -> "health_lt_50")
    if expression:match("[<>=~]+") then
        local lhs = expression:match("^(.-)%s*[<>=~]+")
        local op = expression:match("%s*([<>=~]+)%s*")
        local rhs = expression:match("[<>=~]+%s*(.+)$")

        -- Simplify operator
        local opName = op == "<" and "lt" or op == "<=" and "lte" or
            op == ">" and "gt" or op == ">=" and "gte" or
            op == "==" and "eq" or "neq"

        -- Extract function from lhs
        if lhs and lhs:match("NAG:(%w+)%(") then
            local funcName = lhs:match("NAG:(%w+)%("):lower()
            local value = rhs and rhs:match("%d+") or "val"
            name = funcName .. "_" .. opName .. "_" .. value
        end
    end

    -- Handle logical (e.g., "A and B" -> "condition_check")
    if expression:match(" and ") or expression:match(" or ") then
        name = "condition_check"
    end

    -- Sanitize (max 30 chars, snake_case)
    name = name:gsub("[^%w_]", "_"):gsub("__+", "_"):sub(1, 30)

    return name
end

--- Analyze rotation for duplicate expressions
--- @param editorState table Editor state
--- @param minOccurrences number Minimum occurrences to consider duplicate (default 2)
--- @return table Array of duplicate data sorted by count
function ASTEditor:AnalyzeDuplicateExpressions(editorState, minOccurrences)
    minOccurrences = minOccurrences or 2

    -- Map: serialized expression -> { expression, count, clauseIndices[], nodes[] }
    local expressionMap = {}

    -- Scan all clauses
    local priorityList = GetPriorityList(editorState) or {}
    for clauseIdx, clause in ipairs(priorityList) do
        -- In proto AST, condition is in clause.action.condition
        local ASTAction = ns.ASTAction
        local conditionAST = nil
        if clause.action and ASTAction then
            conditionAST = ASTAction.GetCondition(clause.action)
        end
        if conditionAST then
            -- Recursively collect all sub-expressions
            CollectAllExpressions(conditionAST, expressionMap, clauseIdx)
        end
    end

    -- Filter for duplicates (>= minOccurrences)
    local duplicates = {}
    for expression, data in pairs(expressionMap) do
        if data.count >= minOccurrences then
            tinsert(duplicates, data)
        end
    end

    -- Sort by count (descending)
    table.sort(duplicates, function(a, b) return a.count > b.count end)

    return duplicates
end

--- Show dialog for finding and extracting duplicate expressions
--- @param editorState table Editor state
function ASTEditor:ShowDuplicateExpressionsDialog(editorState)
    local module = self    -- Capture module reference for callbacks
    local minThreshold = 2 -- Default threshold

    local function rebuildDialog(threshold)
        local duplicates = module:AnalyzeDuplicateExpressions(editorState, threshold)

        if #duplicates == 0 then
            NAG:Print(format("|cFFFF8800No duplicate expressions found with threshold %d|r", threshold))
            return nil
        end

        return duplicates
    end

    local duplicates = rebuildDialog(minThreshold)
    if not duplicates then
        return
    end

    -- Create dialog frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle(format("Find Duplicates - Found %d duplicate expression(s)", #duplicates))
    frame:SetLayout("Fill")
    frame:SetWidth(750)
    frame:SetHeight(550)

    -- Main container
    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("Fill")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    frame:AddChild(container)

    -- Inner container for threshold + scroll
    local innerContainer = AceGUI:Create("SimpleGroup")
    innerContainer:SetLayout("List")
    innerContainer:SetFullWidth(true)
    innerContainer:SetFullHeight(true)
    container:AddChild(innerContainer)

    -- Threshold control
    local thresholdGroup = AceGUI:Create("InlineGroup")
    thresholdGroup:SetTitle("Settings")
    thresholdGroup:SetLayout("Flow")
    thresholdGroup:SetFullWidth(true)
    innerContainer:AddChild(thresholdGroup)

    local thresholdEdit = AceGUI:Create("EditBox")
    thresholdEdit:SetLabel("Minimum Occurrences")
    thresholdEdit:SetText(tostring(minThreshold))
    thresholdEdit:SetWidth(150)
    thresholdEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        local newThreshold = tonumber(text)
        if newThreshold and newThreshold >= 2 then
            minThreshold = newThreshold
            frame:Hide()
            module:ShowDuplicateExpressionsDialog(editorState)
        else
            NAG:Print("|cFFFF8800Threshold must be 2 or greater|r")
        end
    end)
    thresholdGroup:AddChild(thresholdEdit)

    local thresholdHint = AceGUI:Create("Label")
    thresholdHint:SetText("|cFF888888Press Enter to update|r")
    thresholdHint:SetWidth(150)
    thresholdGroup:AddChild(thresholdHint)

    -- ScrollFrame for duplicate list
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    innerContainer:AddChild(scroll)

    -- Track selections and name edits
    local selections = {}
    local nameEdits = {}

    -- Render each duplicate
    for idx, dupData in ipairs(duplicates) do
        local dupGroup = AceGUI:Create("InlineGroup")
        dupGroup:SetLayout("Flow")
        dupGroup:SetFullWidth(true)
        dupGroup:SetTitle(format("Duplicate #%d - %d occurrence(s) in clauses: %s",
            idx,
            dupData.count,
            table.concat(dupData.clauseIndices, ", ")))
        scroll:AddChild(dupGroup)

        -- Checkbox to select for extraction
        local checkbox = AceGUI:Create("CheckBox")
        checkbox:SetLabel("")
        checkbox:SetValue(true) -- Selected by default
        checkbox:SetCallback("OnValueChanged", function(widget, event, value)
            selections[idx] = value
        end)
        selections[idx] = true
        dupGroup:AddChild(checkbox)

        -- Expression preview (truncated if too long)
        local preview = dupData.expression
        if #preview > 60 then
            preview = preview:sub(1, 57) .. "..."
        end
        local exprLabel = AceGUI:Create("Label")
        exprLabel:SetText(preview)
        exprLabel:SetRelativeWidth(0.5)
        dupGroup:AddChild(exprLabel)

        -- Variable name editor
        local autoName = GenerateVariableNameFromExpression(dupData.expression)
        local nameEdit = AceGUI:Create("EditBox")
        nameEdit:SetLabel("Variable Name")
        nameEdit:SetText(autoName)
        nameEdit:SetRelativeWidth(0.45)
        dupGroup:AddChild(nameEdit)
        nameEdits[idx] = nameEdit

        -- Full expression (expandable)
        local fullExpr = AceGUI:Create("Label")
        fullExpr:SetText("|cFF888888" .. dupData.expression .. "|r")
        fullExpr:SetFullWidth(true)
        dupGroup:AddChild(fullExpr)
    end

    -- Bottom buttons
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    scroll:AddChild(buttonGroup)

    -- Extract Selected button
    local extractBtn = AceGUI:Create("Button")
    extractBtn:SetText("Extract Selected")
    extractBtn:SetWidth(150)
    extractBtn:SetCallback("OnClick", function()
        module:BulkExtractDuplicates(duplicates, selections, nameEdits, editorState)
        frame:Hide()
    end)
    buttonGroup:AddChild(extractBtn)

    -- Cancel button
    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText("Cancel")
    cancelBtn:SetWidth(100)
    cancelBtn:SetCallback("OnClick", function()
        frame:Hide()
    end)
    buttonGroup:AddChild(cancelBtn)
end

--- Bulk extract selected duplicates into variables
--- @param duplicates table Array of duplicate data
--- @param selections table Map of idx -> selected boolean
--- @param nameEdits table Map of idx -> EditBox widget
--- @param editorState table Editor state
function ASTEditor:BulkExtractDuplicates(duplicates, selections, nameEdits, editorState)
    local extractedCount = 0
    local replacedCount = 0
    local config = editorState.workingConfig

    config.variables = config.variables or {}

    -- Extract each selected duplicate
    for idx, dupData in ipairs(duplicates) do
        if selections[idx] then
            local varName = nameEdits[idx]:GetText()

            -- Validate name
            if not varName or varName == "" then
                NAG:Print(format("|cFFFF8800Skipping duplicate #%d - empty name|r", idx))
            else
                -- Check for duplicate name
                local nameExists = false
                for _, existingVar in ipairs(config.variables) do
                    if existingVar.name == varName then
                        nameExists = true
                        break
                    end
                end

                if nameExists then
                    NAG:Print(format("|cFFFF8800Skipping - variable '%s' already exists|r", varName))
                else
                    -- Create variable
                    tinsert(config.variables, {
                        name = varName,
                        value = dupData.expression
                    })
                    extractedCount = extractedCount + 1

                    -- Replace all occurrences using refactored replacement logic
                    local replaced = self:ReplaceExpressionsWithVariableRef(dupData.expression, varName, editorState)
                    replacedCount = replacedCount + replaced
                end
            end
        end
    end

    -- Sync and refresh
    if extractedCount > 0 then
        EditorUtils.MarkDirty(editorState)
        self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)

        if EditorUtils.RefreshCurrentTab then
            EditorUtils.RefreshCurrentTab(self, editorState)
        end

        NAG:Print(format("|cFF00FF00Created %d variable(s) and replaced %d expression(s)|r",
            extractedCount, replacedCount))
    else
        NAG:Print("|cFFFF8800No variables were created|r")
    end
end

-- ============================ FIND & REPLACE VARIABLE ============================

--- Recursively walk AST tree and find matching nodes
--- @param astNode table AST node to search
--- @param targetExpression string Serialized expression to match
--- @param matches table Accumulator for matches
--- @param parentInfo table Parent node information for replacement
local function FindMatchingNodesInAST(astNode, targetExpression, matches, parentInfo)
    if not astNode then return end

    -- Serialize current node to compare using ASTSchemaEmitter
    local currentExpression = ""
    if not ASTSchemaEmitter then
        NAG:Error("[ASTEditor] ASTSchemaEmitter not available (source=ASTEditor.FindMatchingNodesInAST)")
        return
    end

    local nodeType = astNode.type
    if nodeType == ASTCore.NodeType.ACTION then
        currentExpression = ASTSchemaEmitter.EmitActionNode(astNode) or ""
    elseif nodeType == ASTCore.NodeType.VALUE then
        currentExpression = ASTSchemaEmitter.EmitValueNode(astNode) or ""
    else
        NAG:Error("[ASTEditor] Invalid node type: %s (source=ASTEditor.FindMatchingNodesInAST)", tostring(nodeType))
        return
    end

    NAG:Debug("[ASTEditor] ASTEditorEmission (operation=FindMatchingNodesInAST; nodeType=%s; success=%s)", tostring(nodeType), tostring(currentExpression ~= ""))

    -- Try matching with and without outer parentheses (handles serialization differences)
    local isMatch = currentExpression == targetExpression

    if not isMatch and currentExpression:match("^%((.+)%)$") then
        -- Current has outer parens, try stripping them
        local stripped = currentExpression:match("^%((.+)%)$")
        if stripped == targetExpression then
            isMatch = true
        end
    end

    if not isMatch and targetExpression:match("^%((.+)%)$") then
        -- Target has outer parens, try stripping them
        local stripped = targetExpression:match("^%((.+)%)$")
        if stripped == currentExpression then
            isMatch = true
        end
    end

    -- If match found, record it with parent info for replacement
    if isMatch then
        tinsert(matches, {
            node = astNode,
            parent = parentInfo.parent,
            field = parentInfo.field,
            index = parentInfo.index
        })
        return -- Don't recurse into children of matched node
    end

    -- Recurse into children based on node type (proto AST)
    if nodeType == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(astNode)
        local valueData = ASTValue.GetValueData(astNode)

        if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR then
            -- Logical operators have children in .vals
            if valueData and valueData.vals then
                for i, child in ipairs(valueData.vals) do
                    FindMatchingNodesInAST(child, targetExpression, matches, {
                        parent = astNode,
                        field = "vals",
                        index = i
                    })
                end
            end
        elseif valueType == ASTValue.ValueType.NOT then
            -- NOT has single child in .val
            if valueData and valueData.val then
                FindMatchingNodesInAST(valueData.val, targetExpression, matches, {
                    parent = astNode,
                    field = "val"
                })
            end
        elseif valueType == ASTValue.ValueType.CMP then
            -- Comparison has lhs and rhs
            if valueData and valueData.lhs then
                FindMatchingNodesInAST(valueData.lhs, targetExpression, matches, {
                    parent = astNode,
                    field = "lhs"
                })
            end
            if valueData and valueData.rhs then
                FindMatchingNodesInAST(valueData.rhs, targetExpression, matches, {
                    parent = astNode,
                    field = "rhs"
                })
            end
        elseif valueType == ASTValue.ValueType.MATH then
            -- Math operations have lhs and rhs
            if valueData and valueData.lhs then
                FindMatchingNodesInAST(valueData.lhs, targetExpression, matches, {
                    parent = astNode,
                    field = "lhs"
                })
            end
            if valueData and valueData.rhs then
                FindMatchingNodesInAST(valueData.rhs, targetExpression, matches, {
                    parent = astNode,
                    field = "rhs"
                })
            end
        elseif valueType then
            -- Function value nodes - check for VariableRef and recurse into arguments
            if valueData and valueData.function_name == "VariableRef" then
                return -- Skip VariableRef to avoid replacing references with more references
            end

            -- Recurse into function arguments using fieldOrder
            -- Get metadata to determine which fields are APLValue arguments
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            if valueData and SchemaAccessor then
                local messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(valueType, "APLValue")
                if not messageSchema then
                    messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(valueType, "APLAction")
                end
                if messageSchema and messageSchema.field_order and messageSchema.fields then
                    for i, fieldName in ipairs(messageSchema.field_order) do
                        local fieldInfo = messageSchema.fields[fieldName]
                        local fieldValue = valueData[fieldName]
                        -- Only recurse into APLValue message fields (complex arguments)
                        if fieldValue and fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "APLValue" then
                            FindMatchingNodesInAST(fieldValue, targetExpression, matches, {
                                parent = astNode,
                                field = fieldName,
                                index = i
                            })
                        end
                    end
                end
            end

            -- Note: valueData.arguments is legacy field - removed legacy field access
        end
    elseif nodeType == ASTCore.NodeType.ACTION then
        -- Action nodes - recurse into condition if present
        local actionData = ASTAction.GetActionData(astNode)
        if actionData and actionData.condition then
            FindMatchingNodesInAST(actionData.condition, targetExpression, matches, {
                parent = astNode,
                field = "condition"
            })
        end
    end
end

--- Replace a node with a VariableRef function call (proto AST)
--- @param matchInfo table Match information with parent, field, index
--- @param variableName string Variable name to reference
local function ReplaceNodeWithVariableRef(matchInfo, variableName)
    local parent = matchInfo.parent
    local field = matchInfo.field
    local index = matchInfo.index

    -- Create VariableRef node (proto AST)
    local ASTValue = ns.ASTValue
    local varRefNode = ASTValue and ASTValue.CreateVariableRef(variableName)

    if not varRefNode then
        NAG:Warn(format("[ReplaceNodeWithVariableRef] Failed to create VariableRef node for variable '%s'", variableName))
        return
    end

    -- Replace at parent location based on field type
    local ASTCore = ns.ASTCore
    local ASTAction = ns.ASTAction

    if field == "condition" then
        -- Parent is an action node, set condition
        if ASTAction and parent then
            ASTAction.SetCondition(parent, varRefNode)
        end
    else
        -- Parent is a value node, need to access valueData
        local valueData = parent and ASTValue and ASTValue.GetValueData(parent)
        if valueData then
            if index then
                -- Array field (vals) or field name from fieldOrder
                if field == "vals" then
                    valueData.vals = valueData.vals or {}
                    valueData.vals[index] = varRefNode
                -- Note: field == "arguments" removed - legacy field access not supported
                elseif field and field ~= "" then
                    -- Field name from fieldOrder (e.g., "swap_set")
                    -- This is for function value nodes where arguments are stored as individual fields
                    valueData[field] = varRefNode
                else
                    NAG:Warn(format("[ReplaceNodeWithVariableRef] Unknown indexed field '%s'", tostring(field)))
                end
            else
                -- Direct field (lhs, rhs, val)
                if field == "lhs" then
                    valueData.lhs = varRefNode
                elseif field == "rhs" then
                    valueData.rhs = varRefNode
                elseif field == "val" then
                    valueData.val = varRefNode
                else
                    NAG:Warn(format("[ReplaceNodeWithVariableRef] Unknown field '%s'", tostring(field)))
                end
            end
        else
            NAG:Warn(format("[ReplaceNodeWithVariableRef] Failed to get valueData from parent node"))
        end
    end
end

--- Replace all occurrences of an expression with VariableRef (refactored for reuse)
--- @param targetExpression string Expression to search for
--- @param variableName string Variable name to replace with
--- @param editorState table Editor state
--- @return number Count of replacements made
function ASTEditor:ReplaceExpressionsWithVariableRef(targetExpression, variableName, editorState)
    -- Track matches by clause index
    local matchesByClause = {}
    local totalMatches = 0

    -- Search through all clauses
    local priorityList = GetPriorityList(editorState) or {}
    for clauseIdx, clause in ipairs(priorityList) do
        -- In proto AST, condition is in clause.action.condition
        local ASTAction = ns.ASTAction
        local conditionAST = nil
        if clause.action and ASTAction then
            conditionAST = ASTAction.GetCondition(clause.action)
        end

        if conditionAST and conditionAST.type then
            local matches = {}

            -- Search for matches in condition AST
            local wholeConditionExpression = ""
            if not ASTSchemaEmitter then
                NAG:Error("[ASTEditor] ASTSchemaEmitter not available (source=ASTEditor.ReplaceVariableExpression)")
            else
                local nodeType = conditionAST.type
                if nodeType == ASTCore.NodeType.VALUE then
                    wholeConditionExpression = ASTSchemaEmitter.EmitValueNode(conditionAST) or ""
                    NAG:Debug("[ASTEditor] ASTEditorEmission (operation=ReplaceVariableExpression; nodeType=value; success=%s)", tostring(wholeConditionExpression ~= ""))
                else
                    NAG:Error("[ASTEditor] Invalid condition node type: %s (source=ASTEditor.ReplaceVariableExpression)", tostring(nodeType))
                end
            end

            if wholeConditionExpression == targetExpression then
                -- Replace entire condition with VariableRef
                -- In proto AST, condition is in clause.action.condition
                tinsert(matches, {
                    node = conditionAST,
                    parent = clause.action,  -- Parent is action node in proto AST
                    field = "condition",
                    index = nil,
                    isWholeCondition = true
                })
            else
                -- Search within the condition tree
                -- In proto AST, condition is in clause.action.condition
                FindMatchingNodesInAST(conditionAST, targetExpression, matches, {
                    parent = clause.action,  -- Parent is action node in proto AST
                    field = "condition",
                    index = nil
                })
            end

            if #matches > 0 then
                matchesByClause[clauseIdx] = matches
                totalMatches = totalMatches + #matches
            end
        end
    end

    if totalMatches == 0 then
        return 0
    end

    -- Perform replacements
    local replacedCount = 0
    local modifiedClauses = {}

    for clauseIdx, matches in pairs(matchesByClause) do
        for _, matchInfo in ipairs(matches) do
            -- Check if this match IS the condition itself
            -- In proto AST, condition is in action.condition, so parent is action node
            local isRootCondition = matchInfo.parent and matchInfo.field == "condition" and not matchInfo.index

            if matchInfo.isWholeCondition or isRootCondition then
                -- Replace entire condition with VariableRef (proto AST)
                local ASTValue = ns.ASTValue
                local ASTAction = ns.ASTAction
                local varRefNode = ASTValue and ASTValue.CreateVariableRef(variableName)

                -- Parent is the action node in proto AST
                local actionNode = matchInfo.parent
                if varRefNode and actionNode and ASTAction then
                    -- Set VariableRef in action.condition (proto AST structure)
                    ASTAction.SetCondition(actionNode, varRefNode)
                else
                    NAG:Warn(format("[ReplaceExpressionsWithVariableRef] Failed to create VariableRef node or action missing for clause %d", clauseIdx))
                end
            else
                ReplaceNodeWithVariableRef(matchInfo, variableName)
            end
            replacedCount = replacedCount + 1
        end
        modifiedClauses[clauseIdx] = true
    end

    -- Rebuild all modified clauses
    local NodeEditors = ns.RotationEditorNodeEditors
    if NodeEditors then
        for clauseIdx in pairs(modifiedClauses) do
            local clause = GetClause(editorState, clauseIdx)
            if clause and clause.action then
                -- CRITICAL: ReplaceNodeWithVariableRef modifies nodes in-place
                -- Condition is part of clause.action.condition in proto AST, not stored separately
                -- Rebuild condition from AST (will serialize the modified AST)
                NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
            end
        end
    end

    -- Mark dirty
    EditorUtils.MarkDirty(editorState)

    return replacedCount
end

--- Find and replace all matching expressions in rotation with VariableRef
--- @param varIdx number Variable index
--- @param editorState table Editor state
function ASTEditor:FindAndReplaceVariableExpression(varIdx, editorState)
    local config = editorState.workingConfig

    if not config.variables or not config.variables[varIdx] then
        NAG:Warn("Variable not found")
        return
    end

    local variable = config.variables[varIdx]
    local variableName = variable.name
    local variableValue = variable.value

    if not variableValue or variableValue == "" then
        NAG:Print("|cFFFF8800Variable has no value to search for|r")
        return
    end

    -- Count matches first (using the refactored function with dry-run)
    local totalMatches = self:CountMatchingExpressions(variableValue, editorState)

    if totalMatches == 0 then
        NAG:Print("|cFFFF8800No matching expressions found in rotation|r")
        return
    end

    -- Show confirmation dialog
    StaticPopupDialogs["NAG_VARIABLE_REPLACE_CONFIRM"] = {
        text = format(
            "Found %d matching expression(s).\n\n|cFFFFD100Replace:|r\n    %s\n\n|cFFFFD100With:|r\n    NAG:VariableRef(\"%s\")",
            totalMatches,
            variableValue,
            variableName),
        button1 = "Replace All",
        button2 = "Cancel",
        OnShow = function(dialog)
            dialog:SetFrameStrata("FULLSCREEN_DIALOG")
            dialog:SetFrameLevel(200)
        end,
        OnAccept = function()
            -- Perform replacements using shared function
            local replacedCount = self:ReplaceExpressionsWithVariableRef(variableValue, variableName, editorState)

            -- Update tree
            self:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)

            -- Show success message
            NAG:Print(format("|cFF00FF00Replaced %d matching expression(s) with NAG:VariableRef(\"%s\")|r", replacedCount,
                variableName))
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    StaticPopup_Show("NAG_VARIABLE_REPLACE_CONFIRM")
end

--- Count matching expressions without replacing (for preview)
--- @param targetExpression string Expression to search for
--- @param editorState table Editor state
--- @return number Count of matches
function ASTEditor:CountMatchingExpressions(targetExpression, editorState)
    local totalMatches = 0

    -- Search through all clauses
    local priorityList = GetPriorityList(editorState) or {}
    for clauseIdx, clause in ipairs(priorityList) do
        -- In proto AST, condition is in clause.action.condition
        local ASTAction = ns.ASTAction
        local conditionAST = nil
        if clause.action and ASTAction then
            conditionAST = ASTAction.GetCondition(clause.action)
        end

        if conditionAST and conditionAST.type then
            local matches = {}

            -- Check if entire condition matches
            local wholeConditionExpression = ""
            if not ASTSchemaEmitter then
                NAG:Error("[ASTEditor] ASTSchemaEmitter not available (source=ASTEditor.CountMatchingExpressions)")
            else
                local nodeType = conditionAST.type
                if nodeType == ASTCore.NodeType.VALUE then
                    wholeConditionExpression = ASTSchemaEmitter.EmitValueNode(conditionAST) or ""
                    NAG:Debug("[ASTEditor] ASTEditorEmission (operation=CountMatchingExpressions; nodeType=value; success=%s)", tostring(wholeConditionExpression ~= ""))
                else
                    NAG:Error("[ASTEditor] Invalid condition node type: %s (source=ASTEditor.CountMatchingExpressions)", tostring(nodeType))
                end
            end
            if wholeConditionExpression == targetExpression then
                totalMatches = totalMatches + 1
            else
                -- Search within the condition tree
                -- In proto AST, condition is in clause.action.condition
                FindMatchingNodesInAST(conditionAST, targetExpression, matches, {
                    parent = clause.action,  -- Parent is action node in proto AST
                    field = "condition",
                    index = nil
                })
                totalMatches = totalMatches + #matches
            end
        end
    end

    return totalMatches
end

--- Setup context menu for groups/variables tree nodes
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state
function ASTEditor:SetupGroupsVariablesContextMenu(treeGroup, editorState)
    if not treeGroup then
        return
    end

    -- Hook RefreshTree to ensure context menu handlers are applied after refresh
    HookRefreshTree(treeGroup, "GroupsVarsContextMenuRefresh", function(obj)
        self:SetupGroupsVariablesContextMenuButtons(obj, editorState)
    end)

    self:SetupGroupsVariablesContextMenuButtons(treeGroup, editorState)
end

--- Setup context menu buttons for groups/variables nodes
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state
function ASTEditor:SetupGroupsVariablesContextMenuButtons(treeGroup, editorState)
    if not treeGroup then
        return
    end

    local buttons = treeGroup.buttons
    if not buttons or not next(buttons) then
        return
    end

    for idx, rawButton in pairs(buttons) do
        local button = rawButton
        local frame = button and (button.frame or button)
        local hasHookScript = frame and frame.HookScript
        local hasRegister = frame and frame.RegisterForClicks

        if frame and hasHookScript and button.value then
            -- Parse node type from button value
            local nodeType = self:ParseGroupsVariablesNodeType(button.value)

            -- ONLY hook groups/variables nodes (not clause nodes)
            if nodeType and not rawButton._nagGroupsVarsContextMenuHooked then
                rawButton._nagGroupsVarsContextMenuHooked = true
                if hasRegister then
                    frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                end
                frame:HookScript("OnMouseUp", function(btn, mouseButton)
                    -- Double-check we're still on a groups/variables node before showing menu
                    if mouseButton == "RightButton" and button.value then
                        -- CRITICAL: Extract node ID from hierarchical path (AceGUI uses \001 as separator)
                        local nodeId = button.value
                        if button.value:find("\001") then
                            nodeId = button.value:match("[^\001]+$") or button.value
                        end
                        local currentNodeType = self:ParseGroupsVariablesNodeType(nodeId)
                        if currentNodeType then
                            NAG:Debug(format(
                                "[SetupGroupsVariablesContextMenuButtons] Right-click on %s (extracted: %s), showing menu",
                                button.value:gsub("\001", " → "), tostring(nodeId)))
                            self:ShowGroupsVariablesContextMenu(btn, nodeId, editorState)
                        end
                    end
                end)
            end
        end
    end
end

--- Show context menu for groups/variables node
--- @param anchorFrame table The frame to anchor the menu to
--- @param nodeValue string The node value
--- @param editorState table The editor state
function ASTEditor:ShowGroupsVariablesContextMenu(anchorFrame, nodeValue, editorState)
    NAG:Debug(format("[ShowGroupsVariablesContextMenu] Called with nodeValue: %s", tostring(nodeValue)))

    local menuList = {}
    local nodeType = self:ParseGroupsVariablesNodeType(nodeValue)

    NAG:Debug(format("[ShowGroupsVariablesContextMenu] Parsed nodeType: %s", tostring(nodeType)))

    if nodeType == "groups_root" then
        -- Root node menu: Add operations
        tinsert(menuList, {
            text = L["Add Empty Group"] or "Add Empty Group",
            notCheckable = true,
            func = function()
                self:AddGroup(editorState, { name = "New Group", actions = {} })
            end
        })
        tinsert(menuList, {
            text = L["Add Group with Action"] or "Add Group with Action",
            notCheckable = true,
            func = function()
                self:AddGroup(editorState, { name = "New Group", actions = { "" } })
            end
        })
        tinsert(menuList, {
            text = L["Add Variable"] or "Add Variable",
            notCheckable = true,
            func = function()
                self:AddVariable(editorState, { name = "New Variable", value = "" })
            end
        })
        tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator
        tinsert(menuList, {
            text = L["findDuplicateExpressions"] or "Find Duplicate Expressions",
            notCheckable = true,
            func = function()
                self:ShowDuplicateExpressionsDialog(editorState)
            end
        })
    elseif nodeType == "group" then
        local groupIdx = tonumber(nodeValue:match("^group_(%d+)$"))
        tinsert(menuList, {
            text = L["Duplicate Group"] or "Duplicate Group",
            notCheckable = true,
            func = function()
                self:DuplicateGroup(editorState, groupIdx)
            end
        })
        tinsert(menuList, {
            text = L["Delete Group"] or "Delete Group",
            notCheckable = true,
            func = function()
                self:DeleteGroup(editorState, groupIdx)
            end
        })
        if groupIdx > 1 then
            tinsert(menuList, {
                text = L["Move Up"] or "Move Up",
                notCheckable = true,
                func = function()
                    self:MoveGroup(editorState, groupIdx, groupIdx - 1)
                end
            })
        end
        if groupIdx < #(editorState.workingConfig.groups or {}) then
            tinsert(menuList, {
                text = L["Move Down"] or "Move Down",
                notCheckable = true,
                func = function()
                    self:MoveGroup(editorState, groupIdx, groupIdx + 1)
                end
            })
        end
    elseif nodeType == "variable" then
        local varIdx = tonumber(nodeValue:match("^variable_(%d+)$"))
        tinsert(menuList, {
            text = L["Duplicate Variable"] or "Duplicate Variable",
            notCheckable = true,
            func = function()
                self:DuplicateVariable(editorState, varIdx)
            end
        })
        tinsert(menuList, {
            text = L["findReplaceInRotation"] or "Find & Replace in Rotation",
            notCheckable = true,
            func = function()
                self:FindAndReplaceVariableExpression(varIdx, editorState)
            end
        })
        tinsert(menuList, {
            text = L["Delete Variable"] or "Delete Variable",
            notCheckable = true,
            func = function()
                self:DeleteVariable(editorState, varIdx)
            end
        })
        if varIdx > 1 then
            tinsert(menuList, {
                text = L["Move Up"] or "Move Up",
                notCheckable = true,
                func = function()
                    self:MoveVariable(editorState, varIdx, varIdx - 1)
                end
            })
        end
        if varIdx < #(editorState.workingConfig.variables or {}) then
            tinsert(menuList, {
                text = L["Move Down"] or "Move Down",
                notCheckable = true,
                func = function()
                    self:MoveVariable(editorState, varIdx, varIdx + 1)
                end
            })
        end
    elseif nodeType == "action" then
        local groupIdx, actionIdx = nodeValue:match("^group_(%d+)_action_(%d+)$")
        groupIdx, actionIdx = tonumber(groupIdx), tonumber(actionIdx)
        -- Action-specific context menu not needed - actions use parent group menu
    end

    -- Node Inspector (universal - available for all node types)
    if #menuList > 0 then
        tinsert(menuList, { text = "", notClickable = true, notCheckable = true }) -- Separator
    end

    tinsert(menuList, {
        text = "|cFF00CCFFInspect Node|r",
        notCheckable = true,
        func = function()
            local NodeInspector = ns.RotationEditorNodeInspector
            if NodeInspector then
                -- Get node data based on type
                local nodeData = nil
                local actualClauseIdx = nil

                if nodeType == "group" then
                    local groupIdx = tonumber(nodeValue:match("^group_(%d+)$"))
                    local group = editorState.workingConfig.groups[groupIdx]
                    nodeData = {
                        node = group,
                        nodeType = "group",
                        details = { format("Group %d: %s", groupIdx, group.name or "Unnamed") }
                    }
                    actualClauseIdx = groupIdx
                elseif nodeType == "variable" then
                    local varIdx = tonumber(nodeValue:match("^variable_(%d+)$"))
                    local variable = editorState.workingConfig.variables[varIdx]
                    nodeData = {
                        node = variable,
                        nodeType = "variable",
                        details = { format("Variable %d: %s", varIdx, variable.name or "Unnamed") }
                    }
                    actualClauseIdx = EditorUtils.CreateVariableIndex(varIdx)
                elseif nodeType == "action" then
                    local groupIdx, actionIdx = nodeValue:match("^group_(%d+)_action_(%d+)$")
                    groupIdx, actionIdx = tonumber(groupIdx), tonumber(actionIdx)
                    local group = editorState.workingConfig.groups[groupIdx]
                    local action = group and group.actions[actionIdx]
                    nodeData = {
                        node = action,
                        nodeType = "action",
                        details = { format("Group %d Action %d", groupIdx, actionIdx) }
                    }
                    actualClauseIdx = EditorUtils.CreateGroupActionIndex(groupIdx, actionIdx)
                else
                    -- groups_root or unknown
                    nodeData = {
                        node = editorState.workingConfig,
                        nodeType = nodeType or "unknown",
                        details = { "Groups & Variables Root" }
                    }
                    actualClauseIdx = 0
                end

                NodeInspector:ShowInspector(nodeData, nodeValue, actualClauseIdx, editorState)
            end
        end
    })

    -- Show menu
    NAG:Debug(format("[ShowGroupsVariablesContextMenu] Menu list has %d items", #menuList))

    if #menuList == 0 then
        NAG:Warn(format("[ShowGroupsVariablesContextMenu] No menu items for nodeType: %s, nodeValue: %s",
            tostring(nodeType), tostring(nodeValue)))
        return
    end

    NAG:Debug("[ShowGroupsVariablesContextMenu] Displaying context menu with LibUIDropDownMenu")
    local menuFrame = CreateFrame("Frame", "NAG_GroupsVarsContextMenu", UIParent, "UIDropDownMenuTemplate")
    ns.LibUIDropDownMenu:EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
    NAG:Debug("[ShowGroupsVariablesContextMenu] EasyMenu called successfully")
end

-- ~~~~~~~~~~ UNIFIED CONTEXT MENU SYSTEM ~~~~~~~~~~

--- Setup unified context menu for all tree nodes (clauses and groups/variables)
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state
function ASTEditor:SetupUnifiedTreeContextMenu(treeGroup, editorState)
    if not treeGroup then
        return
    end

    -- Hook RefreshTree to ensure context menu handlers are applied after refresh
    HookRefreshTree(treeGroup, "UnifiedContextMenuRefresh", function(obj)
        self:SetupUnifiedTreeContextMenuButtons(obj, editorState)
    end)

    self:SetupUnifiedTreeContextMenuButtons(treeGroup, editorState)
end

--- Setup unified context menu buttons for all tree nodes
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state
function ASTEditor:SetupUnifiedTreeContextMenuButtons(treeGroup, editorState)
    if not treeGroup then
        return
    end

    local buttons = treeGroup.buttons
    if not buttons or not next(buttons) then
        return
    end

    for idx, rawButton in pairs(buttons) do
        local button = rawButton
        local frame = button and (button.frame or button)
        local hasHookScript = frame and frame.HookScript
        local hasRegister = frame and frame.RegisterForClicks

        if frame and hasHookScript and button.value then
            -- Only hook once per button frame
            if not rawButton._nagUnifiedContextMenuHooked then
                rawButton._nagUnifiedContextMenuHooked = true
                -- Replace \001 with " → " for readable debug output
                local readableValue = button.value and button.value:gsub("\001", " → ") or tostring(button.value)
                NAG:Debug(format("Hooking context menu for button with value: %s", readableValue))
                if hasRegister then
                    frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                end
                frame:HookScript("OnMouseUp", function(btn, mouseButton)
                    if mouseButton == "RightButton" and button.value then
                        -- Replace \001 with " → " for readable debug output
                        local readableValue = button.value and button.value:gsub("\001", " → ") or tostring(button.value)
                        NAG:Debug(format("Right-click detected on button with value: %s", readableValue))
                        -- Route to appropriate context menu based on CURRENT node type
                        self:ShowUnifiedContextMenu(btn, button.value, editorState)
                    end
                end)
            end
        end
    end
end

--- Show appropriate context menu based on node type
--- @param anchorFrame table The frame to anchor the menu to
--- @param nodeValue string The node value (may include hierarchical path with \001 separators)
--- @param editorState table The editor state
function ASTEditor:ShowUnifiedContextMenu(anchorFrame, nodeValue, editorState)
    -- CRITICAL: Extract actual node ID from hierarchical path (AceGUI uses \001 as separator)
    -- e.g., "groups_root\001group_1" -> "group_1"
    local nodeId = nodeValue
    local readablePath = nodeValue
    if nodeValue and nodeValue:find("\001") then
        nodeId = nodeValue:match("[^\001]+$") or nodeValue
        -- Replace \001 with " → " for readable debug output
        readablePath = nodeValue:gsub("\001", " → ")
    end

    -- Debug: Log what node we're trying to show menu for (with readable path)
    NAG:Debug(format("ShowUnifiedContextMenu called with nodeValue: %s (extracted: %s)", readablePath, tostring(nodeId)))

    -- Check if this is a clause node
    local clauseIdx = tonumber(nodeId:match("clause_(%d+)"))
    if clauseIdx then
        NAG:Debug(format("Showing clause context menu for clause %d", clauseIdx))
        self:ShowClauseContextMenu(anchorFrame, clauseIdx, editorState)
        return
    end

    -- Check if this is a groups/variables node
    local nodeType = self:ParseGroupsVariablesNodeType(nodeId)
    if nodeType then
        NAG:Debug(format("Showing groups/variables context menu for nodeType: %s (nodeId: %s)", tostring(nodeType),
            tostring(nodeId)))
        self:ShowGroupsVariablesContextMenu(anchorFrame, nodeId, editorState)
        return
    end

    -- No context menu for other nodes (like root nodes)
    NAG:Debug(format("No context menu for node: %s", tostring(nodeId)))
end

-- ~~~~~~~~~~ DRAG-AND-DROP HANDLERS ~~~~~~~~~~

--- Setup drag-and-drop handlers for tree buttons using NAG:HookScript for proper cleanup
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state for this instance
function ASTEditor:SetupDragHandlers(treeGroup, editorState)
    if not treeGroup then return end

    -- Initialize hook tracking for clause tree (main left tree)
    if not editorState.clauseTreeHooks then
        editorState.clauseTreeHooks = {}
    end

    -- Hook RefreshTree to ensure our handlers are always applied after refresh
    HookRefreshTree(treeGroup, "RefreshTree", function(obj)
        -- CRITICAL: Setup handlers after tree refresh
        -- Buttons are persistent frames, so hooks persist too - only hook once
        self:SetupDragHandlers(obj, editorState)
        self:SetupClauseTooltips(obj, editorState)
        -- Apply current scale to buttons
        if editorState.treeScale then
            local scale = editorState.treeScale
            for _, button in pairs(obj.buttons) do
                if button.icon then
                    button.icon:SetSize(14 * scale, 14 * scale)
                end
                if button.text then
                    local baseFontSize = button.level == 1 and 12 or 11
                    button.text:SetFont("Fonts\\FRIZQT__.TTF", baseFontSize * scale)
                end
            end
        end
    end)

    -- If buttons don't exist yet, they'll be setup on next RefreshTree call
    if not treeGroup.buttons or next(treeGroup.buttons) == nil then
        return
    end

    -- Use AceHook if available for secure hooking
    local AceHook = ns.AceHook

    -- Iterate through tree buttons and add drag handlers
    for _, button in pairs(treeGroup.buttons) do
        if button and button.value and button.value:match("^clause_(%d+)$") and not button.nagDragHooked then
            -- Mark as hooked to prevent duplicate hooks
            button.nagDragHooked = true

            -- Manual drag tracking state
            button.dragStartX = nil
            button.dragStartY = nil
            button.isDragging = false

            -- Store original handlers
            local originalOnClick = button:GetScript("OnClick")
            local originalOnEnter = button:GetScript("OnEnter")
            local originalOnLeave = button:GetScript("OnLeave")

            -- Hook OnMouseDown to start drag tracking
            -- Use raw HookScript (not AceHook) - these frames refresh constantly
            button:HookScript("OnMouseDown", function(btn, mouseButton)
                local editorState = btn._nagEditorState
                local treeGroup = btn._nagTreeGroup
                if not editorState or not treeGroup then return end

                if mouseButton == "LeftButton" then
                    local x, y = GetCursorPosition()
                    btn.dragStartX = x
                    btn.dragStartY = y
                    btn.isDragging = false
                    -- Enable OnUpdate to track movement
                    btn:SetScript("OnUpdate", function(b, elapsed)
                        b._nagDragAccum = (b._nagDragAccum or 0) + (elapsed or 0)
                        if b._nagDragAccum < 0.016 then
                            return
                        end
                        b._nagDragAccum = 0

                        if b.dragStartX and not b.isDragging then
                            local cx, cy = GetCursorPosition()
                            local dx = cx - b.dragStartX
                            local dy = cy - b.dragStartY
                            local distance = (dx * dx + dy * dy) ^ 0.5

                            -- Start drag if moved > 5 pixels
                            if distance > 5 then
                                b.isDragging = true
                                local editorState = b._nagEditorState
                                local treeGroup = b._nagTreeGroup
                                if editorState and treeGroup then
                                    local ASTEditor = ns.RotationEditorAST
                                    if ASTEditor then
                                        ASTEditor:OnClauseDragStart(b, treeGroup, editorState)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)

            -- Hook OnMouseUp to handle click or drop
            -- Use raw HookScript (not AceHook) - these frames refresh constantly
            button:HookScript("OnMouseUp", function(btn, mouseButton)
                local editorState = btn._nagEditorState
                local treeGroup = btn._nagTreeGroup
                if not editorState or not treeGroup then return end

                if mouseButton == "LeftButton" then
                    -- Stop OnUpdate tracking
                    btn:SetScript("OnUpdate", nil)

                    if btn.isDragging then
                        -- This was a drag - find the frame under the cursor
                        local dropTarget = nil

                        -- Check all clause buttons to see which one the cursor is over
                        for _, checkButton in pairs(treeGroup.buttons) do
                            if checkButton and checkButton.value and checkButton.value:match("^clause_(%d+)$") then
                                if MouseIsOver(checkButton) then
                                    dropTarget = checkButton
                                    break
                                end
                            end
                        end

                        if dropTarget then
                            local ASTEditor = ns.RotationEditorAST
                            if ASTEditor then
                                ASTEditor:OnClauseReceiveDrag(dropTarget, treeGroup, editorState)
                            end
                        else
                            local ASTEditor = ns.RotationEditorAST
                            if ASTEditor then
                                ASTEditor:OnClauseDragStop(btn, treeGroup, editorState)
                            end
                        end

                        -- Reset drag state
                        btn.isDragging = false
                        btn.dragStartX = nil
                        btn.dragStartY = nil

                        -- Return true to prevent OnClick from firing
                        return true
                    else
                        -- Not dragging - let original click handler run
                        btn.dragStartX = nil
                        btn.dragStartY = nil
                    end
                end
            end)

            -- Hook OnEnter to show drag hint
            -- Store the drag handler on the button so tooltips can access it
            local dragOnEnter = function(btn)
                local editorState = btn._nagEditorState
                if not editorState then return end

                if editorState.dragSourceIdx then
                    -- Currently dragging - brighten drop indicator if hovering over a target
                    if btn.dropIndicator and editorState.dragSourceIdx ~= tonumber(btn.value:match("^clause_(%d+)$")) then
                        btn.dropIndicator:SetColorTexture(0, 1, 0, 0.4)
                    end
                else
                    -- Not dragging - show drag hint
                    SetCursor("Interface\\CURSOR\\UI-Cursor-Move.crosshair")

                    if not btn.dragHint then
                        btn.dragHint = btn:CreateTexture(nil, "OVERLAY")
                        btn.dragHint:SetTexture("Interface\\CURSOR\\UI-Cursor-Move")
                        btn.dragHint:SetSize(12, 12)
                        btn.dragHint:SetPoint("RIGHT", btn, "RIGHT", -2, 0)
                        btn.dragHint:SetAlpha(0.6)
                    end
                    btn.dragHint:Show()
                end
            end

            -- Store drag handler on button for tooltip to access
            button._nagDragOnEnter = dragOnEnter
            button:HookScript("OnEnter", dragOnEnter)

            -- Hook OnLeave to hide drag hint
            button:HookScript("OnLeave", function(btn)
                local editorState = btn._nagEditorState

                -- Always reset cursor on leave
                ResetCursor()
                if btn.dragHint then
                    btn.dragHint:Hide()
                end

                if editorState and editorState.dragSourceIdx then
                    -- Restore drop indicator to subtle glow
                    if btn.dropIndicator then
                        btn.dropIndicator:SetColorTexture(0, 1, 0, 0.2)
                    end
                end
            end)
        end
    end
end

--- Setup tooltips for clause buttons showing SchemaEmitter output
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state for this instance
function ASTEditor:SetupClauseTooltips(treeGroup, editorState)
    if not treeGroup or not editorState then
        return
    end

    -- If buttons don't exist yet, they'll be setup on next RefreshTree call
    if not treeGroup.buttons or next(treeGroup.buttons) == nil then
        return
    end

    local EditorUtils = ns.RotationEditorUtils
    if not EditorUtils then
        return
    end

    -- Get priority list and variables from working config
    local aplProto = editorState.workingConfig and editorState.workingConfig.aplProto
    local config = editorState.workingConfig

    -- Iterate through tree buttons and add tooltip handlers
    for _, button in pairs(treeGroup.buttons) do
        local isClause = button and button.value and button.value:match("^clause_(%d+)$")
        local isVariable = button and button.value and button.value:match("^variable_(%d+)$")
        local isGroup = button and button.value and button.value:match("^group_(%d+)$")
        local isGroupAction = button and button.value and button.value:match("^group_(%d+)_action_(%d+)$")

        if (isClause or isVariable or isGroup or isGroupAction) then
            -- Always update editor state and treeGroup references (buttons may be recycled across editor instances)
            button._nagEditorState = editorState
            button._nagTreeGroup = treeGroup

            if not button.nagTooltipHooked then
                -- Mark as hooked to prevent duplicate hooks
                button.nagTooltipHooked = true

            -- Helper function to update tooltip based on current Shift state
            local function UpdateTooltip(btn)
                local editorState = btn._nagEditorState
                if not editorState then return end

                -- Check if Shift is held for verbose mode (with name + ID)
                local isShiftDown = false
                if IsShiftKeyDown then
                    if type(IsShiftKeyDown) == "function" then
                        isShiftDown = IsShiftKeyDown()
                    end
                end
                -- Default to icon mode, name_id (with colorized name + ID) when Shift held
                local formatMode = isShiftDown and "name_id" or "icon"

                -- Cache key based on button value and format mode
                local cacheKey = (btn.value or "") .. "_" .. formatMode
                if not editorState.tooltipCache then
                    editorState.tooltipCache = {}
                end

                -- Return cached tooltip if available
                if editorState.tooltipCache[cacheKey] then
                    local cached = editorState.tooltipCache[cacheKey]
                    if cached.emitted and cached.title then
                        GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
                        GameTooltip:SetMinimumWidth(400)
                        GameTooltip:SetText(cached.title, 1, 1, 1)
                        GameTooltip:AddLine(cached.emitted, 1, 1, 1, true)
                        GameTooltip:Show()
                    end
                    return
                end

                local emitted = nil
                local tooltipTitle = nil

                -- Handle clause nodes
                local clauseIdx = tonumber(btn.value and btn.value:match("^clause_(%d+)$"))
                if clauseIdx then
                    local priorityList = GetPriorityList(editorState)
                    if priorityList and clauseIdx > 0 and clauseIdx <= #priorityList then
                        local clause = GetClause(editorState, clauseIdx)
                        if clause then
                            -- Use format mode: name_id when Shift held, icon otherwise
                            emitted = EditorUtils.GetClauseSchemaEmitterOutput(clause, formatMode)
                            tooltipTitle = format("Clause %d APL Syntax", clauseIdx)
                        end
                    end
                end

                -- Handle variable nodes
                local varIdx = tonumber(btn.value and btn.value:match("^variable_(%d+)$"))
                if varIdx then
                    local config = editorState.workingConfig
                    if config and config.variables and varIdx > 0 and varIdx <= #config.variables then
                        local variable = config.variables[varIdx]
                        -- Use format mode: name_id when Shift held, icon otherwise
                        emitted = EditorUtils.GetClauseSchemaEmitterOutput(variable, formatMode)
                        tooltipTitle = format("Variable: %s", variable.name or "Unnamed")
                    end
                end

                -- Handle group nodes
                local groupIdx = tonumber(btn.value and btn.value:match("^group_(%d+)$"))
                if groupIdx and not btn.value:match("_action_") then
                    local config = editorState.workingConfig
                    if config and config.groups and groupIdx > 0 and groupIdx <= #config.groups then
                        local group = config.groups[groupIdx]
                        local parts = {}
                        if group.actions and #group.actions > 0 then
                            for i, actionStr in ipairs(group.actions) do
                                -- Parse action string to get AST using ParseClause to support conditions
                                local NAGStringParser = NAG:GetModule("NAGStringParser")
                                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                                if NAGStringParser and ASTSchemaEmitter then
                                    local clauseResult = NAGStringParser:ParseClause(actionStr, nil, nil)
                                    local actionAST = clauseResult and clauseResult.action
                                    if actionAST then
                                        local actionText = ASTSchemaEmitter.EmitActionNode(actionAST) or actionStr
                                        actionText = EditorUtils.FormatSchemaEmitterOutput(actionText, formatMode)
                                        tinsert(parts, format("Action %d: %s", i, actionText))
                                    else
                                        tinsert(parts, format("Action %d: %s", i, actionStr))
                                    end
                                else
                                    tinsert(parts, format("Action %d: %s", i, actionStr))
                                end
                            end
                        end
                        if #parts > 0 then
                            emitted = table.concat(parts, "\n")
                            tooltipTitle = format("Group: %s", group.name or "Unnamed")
                        end
                    end
                end

                -- Handle group action nodes
                local gIdx, aIdx = btn.value and btn.value:match("^group_(%d+)_action_(%d+)$")
                if gIdx and aIdx then
                    gIdx = tonumber(gIdx)
                    aIdx = tonumber(aIdx)
                    local config = editorState.workingConfig
                    if config and config.groups and gIdx > 0 and gIdx <= #config.groups then
                        local group = config.groups[gIdx]
                        if group.actions and aIdx > 0 and aIdx <= #group.actions then
                            local actionStr = group.actions[aIdx]
                            -- Parse action string to get AST using ParseClause to support conditions
                            local NAGStringParser = NAG:GetModule("NAGStringParser")
                            local ASTSchemaEmitter = ns.ASTSchemaEmitter
                            if NAGStringParser and ASTSchemaEmitter then
                                local clauseResult = NAGStringParser:ParseClause(actionStr, nil, nil)
                                local actionAST = clauseResult and clauseResult.action
                                if actionAST then
                                    local actionText = ASTSchemaEmitter.EmitActionNode(actionAST) or actionStr
                                    actionText = EditorUtils.FormatSchemaEmitterOutput(actionText, formatMode)
                                    emitted = format("Action: %s", actionText)
                                    tooltipTitle = format("Group: %s - Action %d", group.name or "Unnamed", aIdx)
                                else
                                    emitted = format("Action: %s", actionStr)
                                    tooltipTitle = format("Group: %s - Action %d", group.name or "Unnamed", aIdx)
                                end
                            else
                                emitted = format("Action: %s", actionStr)
                                tooltipTitle = format("Group: %s - Action %d", group.name or "Unnamed", aIdx)
                            end
                        end
                    end
                end

                if emitted and tooltipTitle then
                    -- Cache the tooltip content to avoid re-parsing on every hover
                    if not editorState.tooltipCache then
                        editorState.tooltipCache = {}
                    end
                    editorState.tooltipCache[cacheKey] = {
                        emitted = emitted,
                        title = tooltipTitle
                    }

                    GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
                    -- Make tooltip wider by setting a minimum width
                    GameTooltip:SetMinimumWidth(400)
                    GameTooltip:SetText(tooltipTitle, 1, 1, 1)
                    GameTooltip:AddLine(emitted, 1, 1, 1, true)
                    GameTooltip:Show()
                end
            end

            -- Hook OnEnter to show tooltip
            -- Note: Using HookScript (adds to chain), so drag handler already ran
            -- We just need to show the tooltip, not manually call other handlers
            local tooltipOnEnter = function(btn)
                local editorState = btn._nagEditorState
                if not editorState then return end

                -- Suppress tooltip if currently dragging
                if editorState.dragSourceIdx then
                    return
                end

                -- Initial tooltip update
                UpdateTooltip(btn)

                -- Set up OnUpdate to refresh tooltip when Shift state changes
                if not btn._nagTooltipUpdateHooked then
                    btn._nagTooltipUpdateHooked = true
                    btn._lastShiftState = false
                    btn:SetScript("OnUpdate", function(self, elapsed)
                        self._nagTooltipAccum = (self._nagTooltipAccum or 0) + (elapsed or 0)
                        if self._nagTooltipAccum < 0.05 then
                            return
                        end
                        self._nagTooltipAccum = 0
                        if not MouseIsOver(self) then
                            -- Stop updating when mouse leaves
                            self:SetScript("OnUpdate", nil)
                            self._lastShiftState = nil
                            return
                        end


                        -- Check current Shift state
                        local isShiftDown = false
                        if IsShiftKeyDown then
                            if type(IsShiftKeyDown) == "function" then
                                isShiftDown = IsShiftKeyDown()
                            end
                        end

                        -- Update tooltip if Shift state changed
                        if isShiftDown ~= self._lastShiftState then
                            self._lastShiftState = isShiftDown
                            UpdateTooltip(self)
                        end
                    end)
                end
            end

            -- Use raw HookScript (not AceHook) - these persistent frames refresh constantly
            -- HookScript adds to chain, allowing multiple hooks without errors
            button:HookScript("OnEnter", tooltipOnEnter)

            -- Hook OnLeave to hide tooltip
            button:HookScript("OnLeave", function(btn)
                -- Stop OnUpdate when mouse leaves
                if btn._nagTooltipUpdateHooked then
                    btn:SetScript("OnUpdate", nil)
                    btn._lastShiftState = nil
                end

                -- Hide tooltip
                GameTooltip:Hide()
            end)
            end -- Close the nagTooltipHooked check
        end
    end
end

--- Handle drag start for a clause button
--- @param button table The button being dragged
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state for this instance
function ASTEditor:OnClauseDragStart(button, treeGroup, editorState)
    if not button or not button.value then return end

    local clauseIdx = tonumber(button.value:match("^clause_(%d+)$"))
    if not clauseIdx then return end

    -- Store drag source
    editorState.dragSourceIdx = clauseIdx
    editorState.dragSourceButton = button

    -- Visual feedback - dim the button being dragged
    if button.text then
        button.text:SetAlpha(0.5)
    end

    -- Hide drag hint icon during drag
    if button.dragHint then
        button.dragHint:Hide()
    end

    -- Highlight valid drop targets (all other clause buttons)
    if treeGroup.buttons then
        for _, btn in pairs(treeGroup.buttons) do
            if btn and btn.value and btn.value:match("^clause_(%d+)$") and btn ~= button then
                -- Create drop indicator if it doesn't exist
                if not btn.dropIndicator then
                    btn.dropIndicator = btn:CreateTexture(nil, "BACKGROUND")
                    btn.dropIndicator:SetColorTexture(0, 1, 0, 0.2) -- Green glow
                    btn.dropIndicator:SetAllPoints(btn)
                end
                btn.dropIndicator:Show()
            end
        end
    end
end

--- Handle drag stop for a clause button
--- @param button table The button being dragged
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state for this instance
function ASTEditor:OnClauseDragStop(button, treeGroup, editorState)
    -- Restore visual feedback
    if editorState.dragSourceButton and editorState.dragSourceButton.text then
        editorState.dragSourceButton.text:SetAlpha(1.0)
    end

    -- Hide all drop indicators
    if treeGroup and treeGroup.buttons then
        for _, btn in pairs(treeGroup.buttons) do
            if btn and btn.dropIndicator then
                btn.dropIndicator:Hide()
            end
        end
    end

    -- Clear drag state
    editorState.dragSourceIdx = nil
    editorState.dragSourceButton = nil

    ResetCursor()
end

--- Handle drop on a clause button
--- @param button table The button receiving the drop
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state for this instance
function ASTEditor:OnClauseReceiveDrag(button, treeGroup, editorState)
    if not button or not button.value then return end
    if not editorState.dragSourceIdx then return end

    local targetIdx = tonumber(button.value:match("^clause_(%d+)$"))
    if not targetIdx then return end

    local sourceIdx = editorState.dragSourceIdx

    -- Don't drop on self
    if sourceIdx == targetIdx then
        self:OnClauseDragStop(button, treeGroup, editorState)
        return
    end

    -- Get action summaries for confirmation
    local sourceClause = GetClause(editorState, sourceIdx)
    local targetClause = GetClause(editorState, targetIdx)

    if not sourceClause or not targetClause then
        self:OnClauseDragStop(button, treeGroup, editorState)
        return
    end

    local sourceText = EditorUtils.GetClauseActionSummary(sourceClause)
    local targetText = EditorUtils.GetClauseActionSummary(targetClause)

    -- Show confirmation dialog
    StaticPopupDialogs["NAG_ROTATION_CLAUSE_MOVE"] = {
        text = format(
            "Move clause #%d to position #%d?\n\n|cFFFFD100From:|r\n%s\n\n|cFFFFD100To:|r\n%s",
            sourceIdx,
            targetIdx,
            sourceText:gsub("|T.-|t ", ""), -- Strip icons for dialog
            targetText:gsub("|T.-|t ", "")
        ),
        button1 = YES,
        button2 = NO,
        OnShow = function(dialog)
            dialog:SetFrameStrata("FULLSCREEN_DIALOG")
            dialog:SetFrameLevel(200)
        end,
        OnAccept = function()
            -- Hide dialog immediately
            StaticPopup_Hide("NAG_ROTATION_CLAUSE_MOVE")
            self:PerformClauseMove(sourceIdx, targetIdx, treeGroup, editorState)
        end,
        OnCancel = function()
            self:OnClauseDragStop(button, treeGroup, editorState)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    StaticPopup_Show("NAG_ROTATION_CLAUSE_MOVE")
end

--- Perform the actual clause move
--- @param fromIdx number Source clause index
--- @param toIdx number Target clause index
--- @param treeGroup table TreeGroup widget
--- @param editorState table The editor state for this instance
function ASTEditor:PerformClauseMove(fromIdx, toIdx, treeGroup, editorState)
    local priorityList = GetPriorityList(editorState)
    if not priorityList or fromIdx == toIdx then
        self:OnClauseDragStop(editorState.dragSourceButton or {}, treeGroup, editorState)
        return
    end

    -- Remove from source position
    local clause = tremove(priorityList, fromIdx)
    if not clause then
        self:OnClauseDragStop(editorState.dragSourceButton or {}, treeGroup, editorState)
        return
    end

    -- Insert at target position
    tinsert(priorityList, toIdx, clause)

    -- CRITICAL: Priority is the array index, not a stored field - no need to update

    EditorUtils.MarkDirty(editorState)

    -- Refresh tree (this will call SetupDragHandlers again)
    self:UpdateClauseTree(treeGroup, editorState)

    -- Reselect the moved clause at its new position
    treeGroup:SelectByValue("clause_" .. toIdx)

    -- Clear drag state (after tree refresh)
    self:OnClauseDragStop(editorState.dragSourceButton or {}, treeGroup, editorState)

    NAG:Print(format("|cFF00FF00Moved clause from position %d to %d|r", fromIdx, toIdx))
end

--- Show confirmation dialog before deleting a clause
--- @param clauseIdx number Index of the clause to delete
--- @param editorState table The editor state for this instance
function ASTEditor:ConfirmDeleteClause(clauseIdx, editorState)
    local clause = GetClause(editorState, clauseIdx)
    if not clause then return end

    local actionText = EditorUtils.GetClauseActionSummary(clause)

    StaticPopupDialogs["NAG_CONFIRM_DELETE_CLAUSE"] = {
        text = format(
            "Delete clause #%d?\n\n|cFFFFD100Clause:|r\n%s",
            clauseIdx,
            actionText:gsub("|T.-|t ", "") -- Strip icons for dialog
        ),
        button1 = DELETE,
        button2 = CANCEL,
        OnShow = function(dialog)
            dialog:SetFrameStrata("FULLSCREEN_DIALOG")
            dialog:SetFrameLevel(200)
        end,
        OnAccept = function()
            ASTEditor:DeleteClause(clauseIdx, editorState)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    StaticPopup_Show("NAG_CONFIRM_DELETE_CLAUSE")
end

--- Cleanup editor-owned TreeGroup widgets when editor closes
--- CRITICAL: Restore original RefreshTree methods AND unhook button frames to prevent
--- pollution of shared AceGUI widget pool. TreeGroup button frames persist across widget
--- releases, so HookScript hooks must be explicitly removed.
--- @param editorState table The editor state for this instance
function ASTEditor:CleanupEditorWidgets(editorState)
    if not editorState then
        return
    end

    local function CleanupTreeGroup(treeGroup)
        if not treeGroup then
            return
        end

        -- Clear ownership markers
        treeGroup._nagEditorOwned = nil
        treeGroup._nagClauseIdx = nil
        treeGroup._nagEditorState = nil

        -- CRITICAL: Restore original RefreshTree methods
        -- This prevents our hooks from affecting other addons or other parts of NAG
        -- when this widget is recycled from the AceGUI pool
        local hookNames = {"ContextMenuRefresh", "UnifiedContextMenuRefresh", "RefreshTree"}
        for _, hookName in ipairs(hookNames) do
            local hookKey = "_nag" .. hookName .. "Hooked"
            local originalKey = "_nagOriginalRefreshTree_" .. hookName

            if treeGroup[hookKey] and treeGroup[originalKey] then
                -- Restore the original method
                treeGroup.RefreshTree = treeGroup[originalKey]
                treeGroup[originalKey] = nil
                treeGroup[hookKey] = nil
            end
        end

        -- CRITICAL: Clean up button frame hooks and data
        -- TreeGroup button FRAMES persist across widget releases (they're not destroyed on OnRelease)
        -- Raw HookScript hooks can't be unhooked directly, so we clear data they depend on
        if treeGroup.buttons then
            for _, button in pairs(treeGroup.buttons) do
                if button then
                    -- Clear OnUpdate script that was set dynamically during drag
                    button:SetScript("OnUpdate", nil)
                    button._nagTooltipUpdateHooked = nil
                    button._lastShiftState = nil

                    -- Clear NAG-specific data that hooks rely on
                    button._nagClauseIdx = nil
                    button._nagEditorState = nil
                    button._nagTreeGroup = nil
                    button._nagUnifiedContextMenuHooked = nil
                    button._nagDragOnEnter = nil
                    button._nagTooltipHooked = nil
                    button.nagTooltipHooked = nil
                    button.nagDragHooked = nil

                    -- Clear drag state
                    button._dragStarted = nil
                    button._dragStartX = nil
                    button._dragStartY = nil
                    button.dragHint = nil
                    button.dragStartX = nil
                    button.dragStartY = nil
                    button.isDragging = nil


                    -- Clear tooltip cache
                    button._nagTooltipCache = nil
                end
            end
        end
    end

    -- Clean up clause editor TreeGroups
    if editorState.clauseEditors then
        for _, editorData in pairs(editorState.clauseEditors) do
            CleanupTreeGroup(editorData.astTreeGroup)
        end
    end

    -- Clean up group action editor TreeGroups
    if editorState.groupActionEditors then
        for _, editorData in pairs(editorState.groupActionEditors) do
            CleanupTreeGroup(editorData.astTreeGroup)
        end
    end

    -- Clean up groups/variables TreeGroup (if any)
    CleanupTreeGroup(editorState.groupsVariablesTreeGroup)
end

return ASTEditor
