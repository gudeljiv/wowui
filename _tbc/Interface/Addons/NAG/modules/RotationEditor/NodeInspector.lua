--- @module "RotationEditor.NodeInspector"
--- Node inspection tool for debugging and analyzing AST nodes
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Module references
local EditorUtils = ns.RotationEditorUtils

-- Localizations
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local NodeInspector = {}
ns.RotationEditorNodeInspector = NodeInspector

-- Internal state for tracking multiple inspector instances
NodeInspector.activeFrames = NodeInspector.activeFrames or {}

-- AST module localizations (used throughout file)
local ASTCore = ns.ASTCore
local ASTValue = ns.ASTValue
local ASTAction = ns.ASTAction

-- ~~~~~~~~~~ HELPER FUNCTIONS ~~~~~~~~--

--- Ensure activeFrames table exists
--- @param inspectorModule table NodeInspector module instance
local function EnsureActiveFramesTable(inspectorModule)
    if not inspectorModule.activeFrames then
        inspectorModule.activeFrames = {}
    end
end

--- Get editorData for a clause index (handles group actions, variables, and regular clauses)
--- @param editorState table Editor state
--- @param clauseIdx number Clause index
--- @return table|nil EditorData or nil if not found

--- Serialize a node for display
--- Uses ASTSchemaEmitter to produce raw APL syntax (not UI-formatted)
--- @param node table AST node
--- @param nodeId string Node ID for context
--- @param operation string Operation context for logging
--- @return string Serialized node or "N/A" on failure
local function SerializeNodeForDisplay(node, nodeId, operation)
    local ASTSchemaEmitter = ns.ASTSchemaEmitter
    if not ASTSchemaEmitter then
        NAG:Warn("[NodeInspector] ASTSchemaEmitter unavailable (source=%s)", operation)
        return "N/A"
    end

    local nodeType = node.type
    if nodeType == ASTCore.NodeType.ACTION then
        -- Use ASTSchemaEmitter directly for raw APL syntax (not UI-formatted)
        return ASTSchemaEmitter.EmitActionNode(node) or "N/A"
    elseif nodeType == ASTCore.NodeType.VALUE then
        -- Use ASTSchemaEmitter directly for raw APL syntax (not UI-formatted)
        return ASTSchemaEmitter.EmitValueNode(node) or "N/A"
    else
        NAG:Warn("[NodeInspector] Invalid node type (source=%s; nodeType=%s; nodeId=%s)",
            operation, tostring(nodeType), tostring(nodeId))
        return "N/A"
    end
end

--- Validate action node and get action type
--- @param node table AST action node
--- @param context string Context for logging
--- @return string|nil Action type or nil if invalid
local function ValidateActionNode(node, context)
    local actionType = ASTAction.GetActionType(node)
    if not actionType then
        NAG:Warn("[NodeInspector] GetActionType returned nil for action node - proto structure invalid (context=%s)", context)
        return nil
    end
    return actionType
end

--- Detect if node is legacy format
--- @param node table AST node
--- @param context string Context for logging
--- @return boolean True if legacy format detected
local function DetectLegacyFormat(node, context)
    local isLegacy = (node.type == "function" or node.type == "comparison" or
                     node.type == "math" or node.type == "logical" or
                     (node.type == "action" and (not node.action or node.arguments)))
    if isLegacy then
        NAG:Warn("[NodeInspector] Legacy clause format detected: type='%s' - should be proto AST (context=%s)",
            tostring(node.type), context)
        return true
    end
    return false
end

--- Serialize a value for display with color coding
--- @param value any Value to serialize
--- @param indent number Indentation level
--- @param maxDepth number Maximum recursion depth (default: 10)
--- @return string Formatted and color-coded string
local function SerializeValue(value, indent, maxDepth)
    indent = indent or 0
    maxDepth = maxDepth or 10

    if maxDepth <= 0 then
        return "|cFFFF8800[max depth reached]|r"
    end

    local valueType = type(value)
    local indentStr = string.rep("  ", indent)

    if valueType == "nil" then
        return "|cFF888888nil|r"
    elseif valueType == "boolean" then
        return format("|cFF00FF00%s|r", tostring(value))
    elseif valueType == "number" then
        return format("|cFFFFFF00%s|r", tostring(value))
    elseif valueType == "string" then
        -- Escape color codes for display
        local escaped = value:gsub("|", "||")
        return format("|cFF00FFFF\"%s\"|r", escaped)
    elseif valueType == "table" then
        local lines = {"|cFFFF00FF{|r"}
        local count = 0
        for k, v in pairs(value) do
            count = count + 1
            if count > 20 then
                tinsert(lines, indentStr .. "  |cFF888888... (" .. (count - 20) .. " more items)|r")
                break
            end
            local keyStr
            if type(k) == "string" then
                keyStr = format("|cFF00FFFF\"%s\"|r", k)
            else
                keyStr = format("|cFFFFFF00%s|r", tostring(k))
            end
            local valueStr = SerializeValue(v, indent + 1, maxDepth - 1)
            tinsert(lines, indentStr .. "  " .. keyStr .. " = " .. valueStr)
        end
        tinsert(lines, indentStr .. "|cFFFF00FF}|r")
        return table.concat(lines, "\n")
    else
        return format("|cFF888888<%s>|r", valueType)
    end
end

--- Format a table into readable key-value pairs
--- @param data table Data to format
--- @param indent number Indentation level
--- @param maxDepth number Maximum recursion depth (default: 10)
--- @return string Formatted string
local function FormatTableData(data, indent, maxDepth)
    indent = indent or 0
    maxDepth = maxDepth or 10
    local lines = {}
    local indentStr = string.rep("  ", indent)

    if not data or type(data) ~= "table" then
        return indentStr .. SerializeValue(data, indent, maxDepth)
    end

    -- Sort keys for consistent display
    local keys = {}
    for k in pairs(data) do
        tinsert(keys, k)
    end
    table.sort(keys, function(a, b)
        -- Sort strings alphabetically, numbers numerically
        if type(a) == type(b) then
            return tostring(a) < tostring(b)
        else
            return type(a) < type(b)
        end
    end)

    for _, k in ipairs(keys) do
        local v = data[k]
        local keyStr = format("|cFFCCCCCC%s:|r", tostring(k))
        local valueStr = SerializeValue(v, indent, maxDepth - 1)
        tinsert(lines, indentStr .. keyStr .. " " .. valueStr)
    end

    return table.concat(lines, "\n")
end

--- Detect fallback patterns in node data
--- @param nodeData table Node data from tree
--- @param node table AST node
--- @return table {hasFallback: boolean, patterns: table, severity: string}
local function DetectFallbackPatterns(nodeData, node)
    local patterns = {}
    local severity = "none" -- none, info, warning, error

    if not node then
        return {hasFallback = false, patterns = {}, severity = "none"}
    end

    -- Check for invalid action types (proto AST)
    if node.type == ASTCore.NodeType.ACTION then
        local actionType = ValidateActionNode(node, "DetectFallbackPatterns")
        if not actionType then
            tinsert(patterns, {
                type = "invalid_action",
                message = "Invalid action node: GetActionType returned nil (proto structure missing or invalid)",
                severity = "error",
                fix = "Action node must have valid proto structure"
            })
        end
    end

    -- Check for empty function names (proto AST value nodes)
    if node.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        if valueType and valueType ~= ASTValue.ValueType.CONST and
           valueType ~= ASTValue.ValueType.AND and valueType ~= ASTValue.ValueType.OR and
           valueType ~= ASTValue.ValueType.NOT and valueType ~= ASTValue.ValueType.CMP and
           valueType ~= ASTValue.ValueType.MATH then
            -- Function call value node
            if not valueType or valueType == "" then
                tinsert(patterns, {
                    type = "empty_function",
                    message = "Empty function name - no APLValue selected",
                    severity = "error",
                    fix = "Select APLValue from dropdown"
                })
                severity = "error"
            else
                -- Check for missing schema metadata
                local SchemaAccessor = NAG:GetModule("SchemaAccessor")
                local found = false
                if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
                    if valueType:match("^[a-z][a-z0-9_]*$") then
                        found = SchemaAccessor:GetMetadataByIdentifier(valueType, nil) ~= nil
                    end
                end
                if not found then
                    tinsert(patterns, {
                        type = "missing_schema",
                        message = "Function not found in SchemaAccessor",
                        severity = "warning",
                        fix = "Check function name spelling or update schema"
                    })
                    if severity == "none" then severity = "warning" end
                end
            end
        end

        -- Check for fallback operators (comparison and math)
        local valueData = ASTValue.GetValueData(node)
        if ASTValue.IsComparison(node) or ASTValue.IsMathOp(node) then
            if not valueData or not valueData.op then
                tinsert(patterns, {
                    type = "missing_operator",
                    message = "Missing operator (using fallback)",
                    severity = "warning",
                    fix = "Set operator explicitly"
                })
                if severity == "none" then severity = "warning" end
            end
        end
    end

    -- Check for cast_spell usage (should use specific action, but cast_spell is valid if metadata exists)
    if node.type == ASTCore.NodeType.ACTION then
        local actionType = ValidateActionNode(node, "DetectFallbackPatterns.cast_spell")
        if not actionType then
            return {hasFallback = false, patterns = {}, severity = "none"}
        end
        if actionType == "cast_spell" then
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            local hasMetadata = false
            if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
                if actionType and actionType ~= "" then
                    if actionType:match("^[a-z][a-z0-9_]*$") then
                        hasMetadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil) ~= nil
                    end
                end
            end
            if not hasMetadata then
                tinsert(patterns, {
                    type = "cast_spell_no_metadata",
                    message = "cast_spell action has no metadata - schema may be incomplete",
                    severity = "error",
                    fix = "Check schema for missing cast_spell metadata or use specific action type"
                })
                severity = "error"
            end
        end
    end

    -- Legacy clause format nodes should not exist - detect using helper
    if DetectLegacyFormat(node, "DetectFallbackPatterns") then
        -- Try to detect fallbacks for backward compatibility during migration
        local legacyActionType = nil
        if node.type == "action" then
            -- Try to get action type from proto structure if it exists
            if node.action and type(node.action) == "table" then
                legacyActionType = ValidateActionNode(node, "DetectFallbackPatterns.legacy") or node.actionType
            else
                legacyActionType = node.actionType
            end
        end
        if node.type == "action" and not legacyActionType then
            tinsert(patterns, {
                type = "invalid_action",
                message = "Invalid action node: action type cannot be determined (legacy format)",
                severity = "error",
                fix = "Action node must have valid action type"
            })
        end
        if node.type == "function" then
            -- Legacy format function node detected
            tinsert(patterns, {
                type = "legacy_function",
                message = "Legacy format function node detected - should be proto AST",
                severity = "error",
                fix = "Select APLValue from dropdown"
            })
            severity = "error"
        end
        if (node.type == "comparison" and not node.operator) or
           (node.type == "math" and not node.operator) then
            tinsert(patterns, {
                type = "missing_operator",
                message = "Missing operator (using fallback) (legacy)",
                severity = "warning",
                fix = "Set operator explicitly"
            })
            if severity == "none" then severity = "warning" end
        end
    end

    return {
        hasFallback = #patterns > 0,
        patterns = patterns,
        severity = severity
    }
end

--- Generate unique key for inspector instance
--- @param nodeId string Node ID
--- @param clauseIdx number Clause index
--- @return string Unique key
local function GenerateInspectorKey(nodeId, clauseIdx)
    return format("%s_%d", nodeId or "unknown", clauseIdx or 0)
end

--- Fetch fresh nodeData from editorState
--- @param editorState table Editor state
--- @param clauseIdx number Clause index
--- @param nodeId string Node ID
--- @return table|nil Fresh nodeData or nil if not found
local function FetchFreshNodeData(editorState, clauseIdx, nodeId)
    -- DEPRECATED: Use EditorUtils.FindNodeDetail instead
    local EditorUtils = ns.RotationEditorUtils
    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if not editorData then
        return nil
    end
    return EditorUtils.FindNodeDetail(editorData, nodeId)
end

-- ~~~~~~~~~~ DATA COLLECTION ~~~~~~~~~~

--- Build comprehensive inspector data
--- @param nodeData table Node data from tree
--- @param nodeId string Node ID
--- @param clauseIdx number Clause index (or fake index)
--- @param editorState table Editor state
--- @return table Inspector data
function NodeInspector:BuildInspectorData(nodeData, nodeId, clauseIdx, editorState)
    -- Handle different node types:
    -- 1. Variables: wrapper objects with {name, value} where value is the APLValue AST node
    -- 2. Groups: wrapper objects with {name, actions, variables} - inspect the group structure
    -- 3. List items (clauses): have action but no type field - inspect the action node
    local actualNode = nodeData and nodeData.node
    local isListItem = false
    local isVariable = false
    local isGroup = false

    -- Check if this is a variable wrapper (nodeType == "variable")
    local originalVariableString = nil  -- Store original string for serialization
    if nodeData and nodeData.nodeType == "variable" and actualNode then
        isVariable = true

        -- Store original string value for serialization (before replacing with parsed AST)
        if actualNode.value and type(actualNode.value) == "string" then
            originalVariableString = actualNode.value
        end

        -- CRITICAL: Variable wrapper has .value as a STRING, not AST node
        -- We need to get the parsed AST from one of these sources:
        -- 1. aplProto.value_variables[varIdx].value (parsed AST from SyncGroupsVariablesTextToVisual)
        -- 2. editorState.variableEditors[varIdx].fakeClause.action.condition (parsed AST when editing)
        -- 3. Parse the string if neither is available

        local varIdx = nil
        if clauseIdx then
            local EditorUtils = ns.RotationEditorUtils
            if EditorUtils and EditorUtils.IsVariableIndex and EditorUtils.IsVariableIndex(clauseIdx) then
                varIdx = EditorUtils.DecodeVariableIndex(clauseIdx)
            end
        end

        -- Try to get parsed AST from aplProto first (most authoritative)
        local parsedAST = nil
        if varIdx and editorState and editorState.workingConfig then
            local aplProto = editorState.workingConfig.aplProto
            if aplProto and aplProto.value_variables and aplProto.value_variables[varIdx] then
                parsedAST = aplProto.value_variables[varIdx].value
            end
        end

        -- Fallback: Try to get parsed AST from variableEditors (when actively editing)
        if not parsedAST and varIdx and editorState and editorState.variableEditors then
            local varEditor = editorState.variableEditors[varIdx]
            if varEditor and varEditor.fakeClause and varEditor.fakeClause.action then
                local ASTAction = ns.ASTAction
                if ASTAction then
                    parsedAST = ASTAction.GetCondition(varEditor.fakeClause.action)
                end
            end
        end

        -- Last resort: Parse the string value to AST using ParseClause for consistency with actual parser
        if not parsedAST and actualNode.value and type(actualNode.value) == "string" then
            local NAGStringParser = NAG:GetModule("NAGStringParser")
            if NAGStringParser then
                local clauseResult = NAGStringParser:ParseClause(actualNode.value, nil, nil)
                if clauseResult then
                    -- Extract value from clause result (could be in value or condition field)
                    parsedAST = clauseResult.value or clauseResult.condition
                end
                if not parsedAST then
                    -- Fallback to constant if parsing fails
                    local ASTValue = ns.ASTValue
                    if ASTValue then
                        parsedAST = ASTValue.CreateConst(actualNode.value or "")
                    end
                end
            end
        end

        -- Use parsed AST if available, otherwise fall back to the value (which might be AST or string)
        if parsedAST then
            actualNode = parsedAST
            NAG:Trace(format("[NodeInspector] Detected variable wrapper, using parsed AST from aplProto/editorState"))
        elseif actualNode.value then
            actualNode = actualNode.value
            NAG:Trace(format("[NodeInspector] Detected variable wrapper, inspecting value (may be string or AST)"))
        else
            -- No value at all - create empty constant
            local ASTValue = ns.ASTValue
            if ASTValue then
                actualNode = ASTValue.CreateConst("")
                NAG:Trace(format("[NodeInspector] Detected variable wrapper with no value, created empty constant"))
            end
        end
    -- Check if this is a group wrapper (nodeType == "group")
    elseif nodeData and nodeData.nodeType == "group" and actualNode then
        -- Group wrapper: keep the group structure (groups contain multiple actions/variables)
        isGroup = true
        -- Note: Groups are containers, not proto AST nodes themselves
        -- We'll display the group structure in the inspector
        NAG:Trace(format("[NodeInspector] Detected group wrapper, inspecting group structure"))
    end

    -- Check if this is a list item (clause) - has action but no type field
    local originalListItem = nil
    if actualNode and not actualNode.type and actualNode.action then
        -- This is a list item (APLListItem) - store original list item before extracting action
        isListItem = true
        originalListItem = actualNode  -- Store original list item to access notes and hide
        actualNode = actualNode.action
        NAG:Trace(format("[NodeInspector] Detected list item, inspecting action node instead"))
    end

    local data = {
        nodeId = nodeId,
        clauseIdx = clauseIdx,
        nodeData = nodeData,
        node = actualNode,
        originalListItem = originalListItem,  -- Store original list item for notes/hide access
        originalVariableString = originalVariableString,  -- Store original variable string for serialization
        isListItem = isListItem,
        isVariable = isVariable,
        isGroup = isGroup,
        currentState = {},
        fallbacks = {},
        snapshots = {},
        schema = {},
        relationships = {}
    }

    -- Collect current node state
    if data.node then
        -- For groups, the node is the group structure itself (not a proto AST node)
        -- For variables, the node is the value AST node (extracted from variable.value)
        -- For other nodes, it's a proto AST node
        local serialized = nil
        if isGroup then
            -- Groups are containers - show all action strings (full clause format)
            local segments = {}
            segments[#segments + 1] = format("Group: %s", tostring(data.node.name or "Unnamed"))
            if data.node.actions and #data.node.actions > 0 then
                for i, actionString in ipairs(data.node.actions) do
                    if actionString and actionString ~= "" then
                        segments[#segments + 1] = format("  Action %d: %s", i, actionString)
                    end
                end
            end
            if data.node.variables and #data.node.variables > 0 then
                for i, variable in ipairs(data.node.variables) do
                    if variable and variable.value and variable.value ~= "" then
                        segments[#segments + 1] = format("  Variable %d (%s): %s", i, variable.name or "Unnamed", variable.value)
                    end
                end
            end
            serialized = table.concat(segments, "\n")
        elseif isListItem and originalListItem then
            -- List item (clause) - serialize action, condition, notes, and hide
            -- Format matches EmitClause: notes first (as comment), then "NAG:Hidden() and (condition) and action"
            local segments = {}

            -- Add notes as comment line (if present)
            if originalListItem.notes and originalListItem.notes ~= "" then
                local noteText = originalListItem.notes
                if not noteText:match("^%-%-") then
                    noteText = "-- " .. noteText
                end
                segments[#segments + 1] = noteText
            end

            -- Build main clause line
            local lineParts = {}

            -- Add NAG:Hidden() prefix if hidden
            if originalListItem.hide then
                lineParts[#lineParts + 1] = "NAG:Hidden() and "
            end

            -- Serialize condition if present (stored on action.condition)
            local conditionSerialized = nil
            local ASTAction = ns.ASTAction
            if ASTAction and ASTAction.HasCondition and ASTAction.HasCondition(data.node) then
                local conditionAST = ASTAction.GetCondition(data.node)
                if conditionAST then
                    conditionSerialized = SerializeNodeForDisplay(conditionAST, nodeId .. "_condition", "NodeInspector.BuildInspectorData")
                end
            end

            -- Add condition if present
            if conditionSerialized and conditionSerialized ~= "N/A" then
                lineParts[#lineParts + 1] = conditionSerialized
                lineParts[#lineParts + 1] = " and "
            end

            -- Serialize action
            local actionSerialized = SerializeNodeForDisplay(data.node, nodeId, "NodeInspector.BuildInspectorData")
            lineParts[#lineParts + 1] = actionSerialized or "N/A"

            -- Add main clause line
            segments[#segments + 1] = table.concat(lineParts)

            -- Combine all segments (notes + main line)
            serialized = table.concat(segments, "\n")
        elseif isVariable and data.originalVariableString then
            -- Variables: Show the original string value (full clause format), not the parsed AST
            serialized = data.originalVariableString
        else
            -- For proto AST nodes (actions, values, etc.), use the standard serialization
            serialized = SerializeNodeForDisplay(data.node, nodeId, "NodeInspector.BuildInspectorData")
        end

        if serialized and serialized ~= "N/A" then
            NAG:Trace("[NodeInspector] Node serialized successfully (nodeId=%s; nodeType=%s; isGroup=%s; isVariable=%s; isListItem=%s)",
                tostring(nodeId), tostring(data.node.type), tostring(isGroup), tostring(isVariable), tostring(isListItem))
        end

        data.currentState = {
            type = data.node.type,  -- nil for groups, actual type for proto AST nodes
            allFields = data.node,
            serialized = serialized or "N/A"
        }
    end

    -- Detect fallback patterns
    data.fallbacks = DetectFallbackPatterns(nodeData, data.node)

    -- Collect schema metadata (for functions and actions) - proto AST
    if data.node and data.node.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(data.node)
        if valueType and valueType ~= ASTValue.ValueType.CONST and
           valueType ~= ASTValue.ValueType.AND and valueType ~= ASTValue.ValueType.OR and
           valueType ~= ASTValue.ValueType.NOT and valueType ~= ASTValue.ValueType.CMP and
           valueType ~= ASTValue.ValueType.MATH then
            -- Function call value node
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
                if valueType:match("^[a-z][a-z0-9_]*$") then
                    local metadata = SchemaAccessor:GetMetadataByIdentifier(valueType, nil)
                    data.schema.value = metadata
                end
            end
        end
    elseif data.node and data.node.type == ASTCore.NodeType.ACTION then
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
            local actionType = ValidateActionNode(data.node, "BuildInspectorData.schema")
            if actionType and actionType:match("^[a-z][a-z0-9_]*$") then
                data.schema.action = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
            end
        end
    elseif data.node and DetectLegacyFormat(data.node, "BuildInspectorData") then
        -- Legacy format detected - fail fast
        data.hasError = true
        data.errorMessage = format("Legacy format detected: %s (should be proto AST)", tostring(data.node.type))
    end

    -- Collect parent/child relationships
    if nodeData then
        -- Note: nodeType from nodeData may be legacy format ("clause", "action", etc.)
        -- Only use it for display/error detection, not for processing
        local relationshipsNodeType = nodeData.nodeType
        if relationshipsNodeType == "clause" then
            -- "clause" is legacy - list items don't have a type, they're just tables
            relationshipsNodeType = "list_item (legacy nodeType field)"
        elseif relationshipsNodeType == "variable" then
            -- Variable wrapper - show that we're inspecting the value node
            relationshipsNodeType = "VARIABLE (inspecting value node)"
        elseif relationshipsNodeType == "group" then
            -- Group wrapper - show that we're inspecting the group structure
            relationshipsNodeType = "GROUP (inspecting group structure)"
        elseif relationshipsNodeType == "action" and actualNode and actualNode.type == ASTCore.NodeType.ACTION then
            -- If we have proto AST, use that instead
            relationshipsNodeType = "ACTION (proto AST)"
        end

        data.relationships = {
            parentNode = nodeData.parentNode,
            parentId = nodeData.parentId,
            parentField = nodeData.parentField,
            parentIndex = nodeData.parentIndex,
            context = nodeData.context,
            nodeType = relationshipsNodeType,  -- Legacy format for display/error detection only
            isListItem = isListItem,
            isVariable = isVariable,
            isGroup = isGroup
        }
    end

    return data
end

--- Compare with snapshots
--- @param nodeData table Node data
--- @param clauseIdx number Clause index
--- @param editorState table Editor state
--- @return table {clause: table|nil, rotation: table|nil}
function NodeInspector:CompareWithSnapshots(nodeData, clauseIdx, editorState)
    local comparisons = {
        clause = nil,
        rotation = nil
    }

    -- Clause snapshot comparison
    if editorState.clauseSnapshots and editorState.clauseSnapshots[clauseIdx] then
        comparisons.clause = {
            exists = true,
            snapshot = editorState.clauseSnapshots[clauseIdx],
            differences = {}
        }

        -- Find differences (simplified - just check if node exists in snapshot)
        if nodeData and nodeData.node then
            -- This is a basic comparison - could be enhanced
            local serialized = SerializeNodeForDisplay(nodeData.node, "snapshot", "NodeInspector.CompareWithSnapshots")
            if serialized ~= "N/A" then
                NAG:Trace("[NodeInspector] Node serialized for snapshot comparison (nodeType=%s)", tostring(nodeData.node.type))
            end
            comparisons.clause.currentSerialized = serialized
        end
    end

    -- Rotation snapshot comparison
    if editorState.rotationSnapshot and editorState.rotationSnapshot[clauseIdx] then
        comparisons.rotation = {
            exists = true,
            snapshot = editorState.rotationSnapshot[clauseIdx],
            differences = {}
        }
    end

    return comparisons
end

-- ~~~~~~~~~~ GUI RENDERING ~~~~~~~~~~

--- Create depth control widget group
--- @param scroll table ScrollFrame container
--- @param maxDepth number Current max depth value
--- @param key string Unique key for this inspector instance
--- @param inspectorModule table NodeInspector module instance
--- @param onDepthChanged function Callback when depth changes (receives new depth)
--- @return number Current max depth value
local function CreateDepthControl(scroll, maxDepth, key, inspectorModule, onDepthChanged)
    maxDepth = maxDepth or 10
    local depthGroup = AceGUI:Create("InlineGroup")
    depthGroup:SetTitle("Display Depth")
    depthGroup:SetLayout("Flow")
    depthGroup:SetFullWidth(true)
    scroll:AddChild(depthGroup)

    local depthLabel = AceGUI:Create("Label")
    depthLabel:SetText("Max Depth:")
    depthLabel:SetWidth(80)
    depthGroup:AddChild(depthLabel)

    local depthSlider = AceGUI:Create("Slider")
    depthSlider:SetLabel(format("%d", maxDepth))
    depthSlider:SetSliderValues(1, 20, 1)  -- min, max, step
    depthSlider:SetValue(maxDepth)
    depthSlider:SetWidth(200)
    depthSlider:SetCallback("OnValueChanged", function(widget, event, value)
        if not widget or not value then
            return
        end

        widget:SetLabel(format("%d", value))
        -- Update maxDepth in activeFrames entry
        if inspectorModule and inspectorModule.activeFrames and inspectorModule.activeFrames[key] then
            inspectorModule.activeFrames[key].maxDepth = value
        end
        -- Call the provided callback to re-render
        if onDepthChanged then
            onDepthChanged(value)
        end
    end)
    depthGroup:AddChild(depthSlider)

    local depthInfo = AceGUI:Create("Label")
    depthInfo:SetText("|cFF888888Adjust to see deeper nested structures (1-20 levels)|r")
    depthInfo:SetFullWidth(true)
    depthGroup:AddChild(depthInfo)

    return maxDepth
end

--- Render Current Data tab
--- @param container table Container widget
--- @param inspectorData table Inspector data
--- @param maxDepth number Maximum recursion depth for serialization
--- @param key string Unique key for this inspector instance
--- @param inspectorModule table NodeInspector module instance
local function RenderCurrentDataTab(container, inspectorData, maxDepth, key, inspectorModule)
    maxDepth = maxDepth or 10  -- Default to 10 levels for better visibility
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    -- Depth control
    CreateDepthControl(scroll, maxDepth, key, inspectorModule, function(newDepth)
        -- Re-render the entire tab with new depth
        if scroll then
            scroll:ReleaseChildren()
            RenderCurrentDataTab(scroll, inspectorData, newDepth, key, inspectorModule)
        end
    end)

    -- Node ID and Type
    local header = AceGUI:Create("Heading")
    header:SetText("Node Information")
    header:SetFullWidth(true)
    scroll:AddChild(header)

    local nodeIdLabel = AceGUI:Create("Label")
    nodeIdLabel:SetText(format("|cFFCCCCCCNode ID:|r %s", inspectorData.nodeId or "N/A"))
    nodeIdLabel:SetFullWidth(true)
    scroll:AddChild(nodeIdLabel)

    if inspectorData.node then
        -- Display proper node type (proto AST or legacy detection)
        local nodeTypeDisplay = "unknown"
        local nodeTypeColor = "|cFFFF0000"  -- Red for unknown/error

        if inspectorData.node.type == ASTCore.NodeType.ACTION then
            nodeTypeDisplay = "ACTION (proto AST)"
            nodeTypeColor = "|cFF00FF00"  -- Green for valid proto AST
            local actionType = ASTAction.GetActionType(inspectorData.node)
            if actionType then
                nodeTypeDisplay = format("ACTION (proto AST) - %s", actionType)
            elseif inspectorData.node.__invalid and inspectorData.node.__invalid.missingActionType then
                nodeTypeDisplay = "ACTION (proto AST) - [Select Action Type]"
                nodeTypeColor = "|cFFFFAA00"  -- Yellow for missing action type
            else
                nodeTypeDisplay = "ACTION (proto AST) - [Invalid: missing action type]"
            end
        elseif inspectorData.node.type == ASTCore.NodeType.VALUE then
            nodeTypeDisplay = "VALUE (proto AST)"
            nodeTypeColor = "|cFF00FF00"  -- Green for valid proto AST
            local valueType = ASTValue.GetValueType(inspectorData.node)
            if valueType then
                nodeTypeDisplay = format("VALUE (proto AST) - %s", tostring(valueType))
            elseif inspectorData.node.__invalid and inspectorData.node.__invalid.missingValueType then
                nodeTypeDisplay = "VALUE (proto AST) - [Select Value Type]"
                nodeTypeColor = "|cFFFFAA00"  -- Yellow for missing value type
            else
                nodeTypeDisplay = "VALUE (proto AST) - [Invalid: missing value type]"
            end
        elseif inspectorData.node.type == "action" or inspectorData.node.type == "function" or
               inspectorData.node.type == "comparison" or inspectorData.node.type == "math" or
               inspectorData.node.type == "logical" then
            -- Legacy format - show as error
            nodeTypeDisplay = format("LEGACY FORMAT: %s (should be proto AST)", tostring(inspectorData.node.type))
            nodeTypeColor = "|cFFFF0000"  -- Red for legacy/error
        elseif inspectorData.isListItem then
            -- List item (clause) - show that we're inspecting the action
            nodeTypeDisplay = "LIST ITEM (inspecting action node)"
            nodeTypeColor = "|cFF00CCFF"  -- Cyan for list item
        elseif inspectorData.isVariable then
            -- Variable wrapper - show that we're inspecting the value node
            nodeTypeDisplay = "VARIABLE (inspecting value node)"
            nodeTypeColor = "|cFF00CCFF"  -- Cyan for variable
            if inspectorData.node and inspectorData.node.type then
                nodeTypeDisplay = format("VARIABLE (inspecting value node: %s)", tostring(inspectorData.node.type))
            end
        elseif inspectorData.isGroup then
            -- Group wrapper - show that we're inspecting the group structure
            nodeTypeDisplay = "GROUP (inspecting group structure)"
            nodeTypeColor = "|cFF00CCFF"  -- Cyan for group
        elseif inspectorData.node and inspectorData.node.type then
            -- Other proto AST types
            nodeTypeDisplay = format("%s (proto AST)", tostring(inspectorData.node.type))
            nodeTypeColor = "|cFF00FF00"  -- Green for valid proto AST
        end

        local typeLabel = AceGUI:Create("Label")
        typeLabel:SetText(format("|cFFCCCCCCNode Type:|r %s%s|r", nodeTypeColor, nodeTypeDisplay))
        typeLabel:SetFullWidth(true)
        scroll:AddChild(typeLabel)
    end

    -- Serialized form
    if inspectorData.currentState.serialized then
        local serHeader = AceGUI:Create("Heading")
        serHeader:SetText("Serialized Form")
        serHeader:SetFullWidth(true)
        scroll:AddChild(serHeader)

        local serLabel = AceGUI:Create("Label")
        serLabel:SetText(format("|cFF00FFFF%s|r", inspectorData.currentState.serialized))
        serLabel:SetFullWidth(true)
        scroll:AddChild(serLabel)
    end

    -- All fields
    if inspectorData.node then
        local fieldsHeader = AceGUI:Create("Heading")
        fieldsHeader:SetText("All Node Fields")
        fieldsHeader:SetFullWidth(true)
        scroll:AddChild(fieldsHeader)

        local fieldsText = FormatTableData(inspectorData.node, 0, maxDepth)
        local fieldsLabel = AceGUI:Create("Label")
        fieldsLabel:SetText(fieldsText)
        fieldsLabel:SetFullWidth(true)
        scroll:AddChild(fieldsLabel)
    end

    -- Relationships
    if inspectorData.relationships and next(inspectorData.relationships) then
        local relHeader = AceGUI:Create("Heading")
        relHeader:SetText("Relationships")
        relHeader:SetFullWidth(true)
        scroll:AddChild(relHeader)

        local relText = FormatTableData(inspectorData.relationships, 0, maxDepth)
        local relLabel = AceGUI:Create("Label")
        relLabel:SetText(relText)
        relLabel:SetFullWidth(true)
        scroll:AddChild(relLabel)
    end
end

--- Render Clause Snapshot tab
--- @param container table Container widget
--- @param inspectorData table Inspector data
--- @param comparisons table Snapshot comparisons
--- @param maxDepth number Maximum recursion depth for serialization
--- @param key string Unique key for this inspector instance
--- @param inspectorModule table NodeInspector module instance
local function RenderClauseSnapshotTab(container, inspectorData, comparisons, maxDepth, key, inspectorModule)
    maxDepth = maxDepth or 10
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    if not comparisons.clause or not comparisons.clause.exists then
        local noSnapshot = AceGUI:Create("Label")
        noSnapshot:SetText("|cFFFF8800No clause snapshot available|r\n\nClause snapshots are created when you first open a clause for editing.")
        noSnapshot:SetFullWidth(true)
        scroll:AddChild(noSnapshot)
        return
    end

    -- Depth control
    CreateDepthControl(scroll, maxDepth, key, inspectorModule, function(newDepth)
        -- Re-render the entire tab with new depth
        if scroll then
            scroll:ReleaseChildren()
            RenderClauseSnapshotTab(scroll, inspectorData, comparisons, newDepth, key, inspectorModule)
        end
    end)

    local header = AceGUI:Create("Heading")
    header:SetText("Clause Snapshot Comparison")
    header:SetFullWidth(true)
    scroll:AddChild(header)

    -- Current state
    local currentHeader = AceGUI:Create("Heading")
    currentHeader:SetText("Current State")
    currentHeader:SetFullWidth(true)
    scroll:AddChild(currentHeader)

    if comparisons.clause.currentSerialized then
        local currentLabel = AceGUI:Create("Label")
        currentLabel:SetText(format("|cFF00FF00%s|r", comparisons.clause.currentSerialized))
        currentLabel:SetFullWidth(true)
        scroll:AddChild(currentLabel)
    end

    -- Snapshot state
    local snapshotHeader = AceGUI:Create("Heading")
    snapshotHeader:SetText("Snapshot State")
    snapshotHeader:SetFullWidth(true)
    scroll:AddChild(snapshotHeader)

    local snapshotText = FormatTableData(comparisons.clause.snapshot, 0, maxDepth)
    local snapshotLabel = AceGUI:Create("Label")
    snapshotLabel:SetText(snapshotText)
    snapshotLabel:SetFullWidth(true)
    scroll:AddChild(snapshotLabel)
end

--- Render Rotation Snapshot tab
--- @param container table Container widget
--- @param inspectorData table Inspector data
--- @param comparisons table Snapshot comparisons
--- @param maxDepth number Maximum recursion depth for serialization
--- @param key string Unique key for this inspector instance
--- @param inspectorModule table NodeInspector module instance
local function RenderRotationSnapshotTab(container, inspectorData, comparisons, maxDepth, key, inspectorModule)
    maxDepth = maxDepth or 10
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    if not comparisons.rotation or not comparisons.rotation.exists then
        local noSnapshot = AceGUI:Create("Label")
        noSnapshot:SetText("|cFFFF8800No rotation snapshot available|r\n\nRotation snapshots are created when you first open the visual editor.")
        noSnapshot:SetFullWidth(true)
        scroll:AddChild(noSnapshot)
        return
    end

    -- Depth control
    CreateDepthControl(scroll, maxDepth, key, inspectorModule, function(newDepth)
        -- Re-render the entire tab with new depth
        if scroll then
            scroll:ReleaseChildren()
            RenderRotationSnapshotTab(scroll, inspectorData, comparisons, newDepth, key, inspectorModule)
        end
    end)

    local header = AceGUI:Create("Heading")
    header:SetText("Rotation Snapshot Comparison")
    header:SetFullWidth(true)
    scroll:AddChild(header)

    local snapshotText = FormatTableData(comparisons.rotation.snapshot, 0, maxDepth)
    local snapshotLabel = AceGUI:Create("Label")
    snapshotLabel:SetText(snapshotText)
    snapshotLabel:SetFullWidth(true)
    scroll:AddChild(snapshotLabel)
end

--- Render Diagnostics tab
--- @param container table Container widget
--- @param inspectorData table Inspector data
--- @param maxDepth number Maximum recursion depth for serialization
--- @param key string Unique key for this inspector instance
--- @param inspectorModule table NodeInspector module instance
local function RenderDiagnosticsTab(container, inspectorData, maxDepth, key, inspectorModule)
    maxDepth = maxDepth or 10
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    -- Depth control (only show if there's schema data to display)
    local hasSchemaData = inspectorData.schema.value or inspectorData.schema.action
    if hasSchemaData then
        CreateDepthControl(scroll, maxDepth, key, inspectorModule, function(newDepth)
            -- Re-render the entire tab with new depth
            if scroll then
                scroll:ReleaseChildren()
                RenderDiagnosticsTab(scroll, inspectorData, newDepth, key, inspectorModule)
            end
        end)
    end

    -- Fallback patterns
    local fallbackHeader = AceGUI:Create("Heading")
    fallbackHeader:SetText("Fallback Pattern Detection")
    fallbackHeader:SetFullWidth(true)
    scroll:AddChild(fallbackHeader)

    if inspectorData.fallbacks.hasFallback then
        local severityColor = inspectorData.fallbacks.severity == "error" and "|cFFFF0000" or
                              inspectorData.fallbacks.severity == "warning" and "|cFFFFAA00" or "|cFF00FF00"

        local statusLabel = AceGUI:Create("Label")
        statusLabel:SetText(format("%sSeverity: %s|r\n|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:16:16:0:0|t %d pattern(s) detected",
            severityColor, inspectorData.fallbacks.severity:upper(), #inspectorData.fallbacks.patterns))
        statusLabel:SetFullWidth(true)
        scroll:AddChild(statusLabel)

        for i, pattern in ipairs(inspectorData.fallbacks.patterns) do
            local patternGroup = AceGUI:Create("InlineGroup")
            patternGroup:SetTitle(format("Pattern %d: %s", i, pattern.type))
            patternGroup:SetLayout("List")
            patternGroup:SetFullWidth(true)
            scroll:AddChild(patternGroup)

            local patternColor = pattern.severity == "error" and "|cFFFF0000" or
                                pattern.severity == "warning" and "|cFFFFAA00" or "|cFF00FFFF"

            local messageLabel = AceGUI:Create("Label")
            messageLabel:SetText(format("%s%s|r", patternColor, pattern.message))
            messageLabel:SetFullWidth(true)
            patternGroup:AddChild(messageLabel)

            local fixLabel = AceGUI:Create("Label")
            fixLabel:SetText(format("|cFF00FF00Suggested fix:|r %s", pattern.fix))
            fixLabel:SetFullWidth(true)
            patternGroup:AddChild(fixLabel)
        end
    else
        local okLabel = AceGUI:Create("Label")
        okLabel:SetText("|cFF00FF00No fallback patterns detected - node looks good! ✓|r")
        okLabel:SetFullWidth(true)
        scroll:AddChild(okLabel)
    end

    -- Schema information
    if inspectorData.schema.value or inspectorData.schema.action then
        local schemaHeader = AceGUI:Create("Heading")
        schemaHeader:SetText("Schema Metadata")
        schemaHeader:SetFullWidth(true)
        scroll:AddChild(schemaHeader)

        local schemaData = inspectorData.schema.value or inspectorData.schema.action
        local schemaText = FormatTableData(schemaData, 0, maxDepth)
        local schemaLabel = AceGUI:Create("Label")
        schemaLabel:SetText(schemaText)
        schemaLabel:SetFullWidth(true)
        scroll:AddChild(schemaLabel)
    else
        if inspectorData.node and (inspectorData.node.type == ASTCore.NodeType.VALUE or inspectorData.node.type == ASTCore.NodeType.ACTION or
            inspectorData.node.type == "function" or inspectorData.node.type == "action") then
            local noSchemaHeader = AceGUI:Create("Heading")
            noSchemaHeader:SetText("Schema Metadata")
            noSchemaHeader:SetFullWidth(true)
            scroll:AddChild(noSchemaHeader)

            local noSchemaLabel = AceGUI:Create("Label")
            noSchemaLabel:SetText("|cFFFF8800No schema metadata found|r")
            noSchemaLabel:SetFullWidth(true)
            scroll:AddChild(noSchemaLabel)
        end
    end
end

--- Create and show inspector GUI
--- @param key string Unique key for this inspector instance
--- @param inspectorData table Inspector data
--- @param comparisons table Snapshot comparisons
function NodeInspector:CreateInspectorGUI(key, inspectorData, comparisons)
    -- Validate inputs
    if not key then
        NAG:Debug("[NodeInspector] CreateInspectorGUI called without key")
        return
    end

    -- Ensure activeFrames table exists
    EnsureActiveFramesTable(self)

    local frame = AceGUI:Create("Frame")
    if not frame then
        NAG:Error("[NodeInspector] Failed to create AceGUI Frame")
        return
    end

    NAG:Info("[NodeInspector] Created inspector GUI for node %s (clause %s)", tostring(inspectorData.nodeId or "Unknown"), tostring(inspectorData.clauseIdx or "Unknown"))
    frame:SetTitle(format("Node Inspector - %s", inspectorData.nodeId or "Unknown"))
    frame:SetLayout("Fill")
    frame:SetWidth(700)
    frame:SetHeight(500)
    frame:EnableResize(true)

    -- Store inspector instance data in activeFrames table
    self.activeFrames[key] = {
        frame = frame,
        inspectorData = inspectorData,
        comparisons = comparisons,
        maxDepth = 10  -- Default max depth per inspector instance
    }

    frame:SetCallback("OnClose", function(widget)
        -- Remove from activeFrames table
        if self.activeFrames and key then
            self.activeFrames[key] = nil
        end
        -- Release widget with nil check
        if widget then
            AceGUI:Release(widget)
        end
    end)

    -- Create tab group
    local tabs = AceGUI:Create("TabGroup")
    tabs:SetLayout("Fill")
    tabs:SetFullWidth(true)
    tabs:SetFullHeight(true)
    tabs:SetTabs({
        {text="Current Data", value="current"},
        {text="Clause Snapshot", value="clause_snapshot"},
        {text="Rotation Snapshot", value="rotation_snapshot"},
        {text="Diagnostics", value="diagnostics"}
    })

    tabs:SetCallback("OnGroupSelected", function(container, event, group)
        if not container then
            return
        end

        container:ReleaseChildren()

        -- Get per-inspector maxDepth from activeFrames
        local inspectorState = self.activeFrames and self.activeFrames[key]
        local maxDepth = inspectorState and inspectorState.maxDepth or 10

        if group == "current" then
            RenderCurrentDataTab(container, inspectorData, maxDepth, key, self)
        elseif group == "clause_snapshot" then
            RenderClauseSnapshotTab(container, inspectorData, comparisons, maxDepth, key, self)
        elseif group == "rotation_snapshot" then
            RenderRotationSnapshotTab(container, inspectorData, comparisons, maxDepth, key, self)
        elseif group == "diagnostics" then
            RenderDiagnosticsTab(container, inspectorData, maxDepth, key, self)
        end
    end)

    frame:AddChild(tabs)

    -- Select first tab by default
    tabs:SelectTab("current")
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~

--- Refresh a specific inspector by key
--- @param key string Unique key for inspector instance
--- @param editorState table Editor state
--- @return boolean True if refresh succeeded, false otherwise
function NodeInspector:RefreshInspectorByKey(key, editorState)
    if not key or not editorState or not self.activeFrames then
        return false
    end

    local inspectorState = self.activeFrames[key]
    if not inspectorState or not inspectorState.inspectorData then
        return false
    end

    local inspectorData = inspectorState.inspectorData
    local nodeId = inspectorData.nodeId
    local clauseIdx = inspectorData.clauseIdx

    if not nodeId or not clauseIdx then
        return false
    end

    -- Fetch fresh nodeData
    local freshNodeData = FetchFreshNodeData(editorState, clauseIdx, nodeId)
    if not freshNodeData then
        -- Node may have been deleted or nodeId changed - gracefully handle
        -- Leave inspector as-is (user can close it manually if needed)
        return false
    end

    -- Validate fresh nodeData has required fields
    if not freshNodeData.node then
        return false
    end

    -- Rebuild inspector data with fresh nodeData
    local success, newInspectorData = pcall(self.BuildInspectorData, self, freshNodeData, nodeId, clauseIdx, editorState)
    if not success or not newInspectorData then
        NAG:Debug(format("[NodeInspector] Failed to rebuild inspector data for key: %s", tostring(key)))
        return false
    end

    local success2, newComparisons = pcall(self.CompareWithSnapshots, self, freshNodeData, clauseIdx, editorState)
    if not success2 or not newComparisons then
        NAG:Debug(format("[NodeInspector] Failed to rebuild comparisons for key: %s", tostring(key)))
        -- Continue with refresh even if comparisons fail
        newComparisons = {}
    end

    -- Update stored data
    inspectorState.inspectorData = newInspectorData
    inspectorState.comparisons = newComparisons

    -- Refresh the GUI by reselecting current tab
    if inspectorState.frame and inspectorState.frame.frame then
        local tabs = nil
        -- Find TabGroup widget in frame children
        if inspectorState.frame.children then
            for _, child in ipairs(inspectorState.frame.children) do
                if child.type == "TabGroup" then
                    tabs = child
                    break
                end
            end
        end

        if tabs and tabs.selected then
            -- Trigger refresh by reselecting current tab
            -- Use pcall to handle any errors during tab refresh
            local success3 = pcall(tabs.SelectTab, tabs, tabs.selected)
            if not success3 then
                NAG:Debug(format("[NodeInspector] Failed to refresh tab for key: %s", tostring(key)))
            end
        end
    end

    NAG:Info("[NodeInspector] Refreshed inspector [%s]", tostring(key))
    return true
end

--- Refresh all open inspectors for a given clause
--- @param clauseIdx number Clause index
--- @param editorState table Editor state
--- @return number Number of inspectors refreshed
function NodeInspector:RefreshInspectorsForClause(clauseIdx, editorState)
    if not clauseIdx or not editorState or not self.activeFrames then
        return 0
    end

    local refreshedCount = 0

    -- Iterate through all active inspectors
    -- Use pairs safely in case activeFrames structure changes during iteration
    local keysToRefresh = {}
    for key, inspectorState in pairs(self.activeFrames) do
        if inspectorState and inspectorState.inspectorData then
            local inspectorClauseIdx = inspectorState.inspectorData.clauseIdx
            -- Match clause index (handles regular clauses, group actions, and variables)
            if inspectorClauseIdx == clauseIdx then
                tinsert(keysToRefresh, key)
            end
        end
    end

    -- Refresh each matching inspector
    for _, key in ipairs(keysToRefresh) do
        if self:RefreshInspectorByKey(key, editorState) then
            refreshedCount = refreshedCount + 1
        end
    end

    if refreshedCount > 0 then
        NAG:Info("[NodeInspector] Refreshed %d inspector(s) for clause %s", refreshedCount, tostring(clauseIdx))
    end
    return refreshedCount
end

--- Show inspector for a node
--- @param nodeData table Node data from tree
--- @param nodeId string Node ID
--- @param clauseIdx number Clause index (or fake index)
--- @param editorState table Editor state
function NodeInspector:ShowInspector(nodeData, nodeId, clauseIdx, editorState)
    -- Validate inputs
    if not nodeId then
        NAG:Debug("[NodeInspector] ShowInspector called without nodeId")
        return
    end

    -- Ensure activeFrames table exists
    EnsureActiveFramesTable(self)

    NAG:Info("[NodeInspector] Opening inspector for node %s (clause %s)", tostring(nodeId), tostring(clauseIdx or "Unknown"))

    -- Generate unique key for this inspector instance
    local key = GenerateInspectorKey(nodeId, clauseIdx)

    -- Check if inspector already exists for this key
    if self.activeFrames[key] and self.activeFrames[key].frame then
        local existingFrame = self.activeFrames[key].frame
        -- Validate frame still exists before showing
        if existingFrame and existingFrame.frame then
            -- Refresh inspector data before showing to ensure it's current
            self:RefreshInspectorByKey(key, editorState)
            existingFrame:Show()
            return
        else
            -- Frame was released but entry still exists - clean it up
            self.activeFrames[key] = nil
        end
    end

    -- Build inspector data
    local inspectorData = self:BuildInspectorData(nodeData, nodeId, clauseIdx, editorState)

    -- Compare with snapshots
    local comparisons = self:CompareWithSnapshots(nodeData, clauseIdx, editorState)

    -- Create and show GUI
    self:CreateInspectorGUI(key, inspectorData, comparisons)
end

return NodeInspector

