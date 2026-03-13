--- @module "RotationEditor.NodeEditors"
--- Node editing panels for RotationEditor AST tree
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local Libs = ns.Libs
local L = ns.AceLocale:GetLocale("NAG", true)
local APLAutocomplete = ns.APLAutocomplete
local WoWAPI = ns.WoWAPI
local EditorUtils = ns.RotationEditorUtils
local LibUIDropDownMenu = ns.LibUIDropDownMenu

local ASTCore = ns.ASTCore
local ASTValue = ns.ASTValue
local ASTAction = ns.ASTAction
local ASTSchemaEmitter = ns.ASTSchemaEmitter

-- Lua APIs
local format = string.format
local tinsert = tinsert
local sort = table.sort
local tostring = tostring
local tonumber = tonumber
local type = type
local ipairs = ipairs
local GetCursorPosition = _G.GetCursorPosition
local CreateFrame = _G.CreateFrame
local pairs = pairs
local wipe = wipe

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local NodeEditors = {}
ns.RotationEditorNodeEditors = NodeEditors

-- ============================ HELPERS ============================
-- Replace node structure while preserving reference (for parent structure)
--- This allows parent nodes to maintain references to the same table object
--- @param node table The existing node to replace (will be modified in place)
--- @param newNode table The new node structure to copy from
local function ReplaceNodeStructure(node, newNode)
    if not node or not newNode or type(node) ~= "table" or type(newNode) ~= "table" then
        NAG:Error("ReplaceNodeStructure: Invalid parameters (node type: %s, newNode type: %s)",
            type(node), type(newNode))
        return
    end

    -- Clear all existing fields from the old node
    for k in pairs(node) do
        node[k] = nil
    end

    -- Copy all fields from the new node
    for k, v in pairs(newNode) do
        node[k] = v
    end
end

--- Preserve compatible fields when changing action/value types
--- Compares old and new schemas and copies field values where field name, type, and message_type match
--- @param oldData table Old field data (from old action/value type)
--- @param oldSchema table|nil Old message schema (fields and field_order)
--- @param newSchema table|nil New message schema (fields and field_order)
--- @return table Preserved field data
local function PreserveCompatibleFields(oldData, oldSchema, newSchema)
    if not oldData or type(oldData) ~= "table" then
        return {}
    end

    if not oldSchema or not oldSchema.fields or not newSchema or not newSchema.fields then
        -- Can't compare schemas, return empty
        return {}
    end

    local preservedFields = {}
    local oldFields = oldSchema.fields
    local newFields = newSchema.fields

    -- Iterate through old data and check if fields are compatible
    for fieldName, fieldValue in pairs(oldData) do
        local oldFieldInfo = oldFields[fieldName]
        local newFieldInfo = newFields[fieldName]

        -- Check if field exists in both schemas
        if oldFieldInfo and newFieldInfo then
            -- Check if field types match
            local oldType = oldFieldInfo.type
            local newType = newFieldInfo.type

            if oldType == newType then
                -- Types match, check message_type for message fields
                if oldType == "message" then
                    local oldMessageType = oldFieldInfo.message_type
                    local newMessageType = newFieldInfo.message_type

                    if oldMessageType == newMessageType then
                        -- Compatible message type - preserve the value
                        preservedFields[fieldName] = fieldValue
                        NAG:Debug("[NodeEditors] PreserveCompatibleFields: Preserved field '%s' (message_type='%s')", fieldName, oldMessageType or "nil")
                    end
                elseif oldType == "enum" then
                    local oldEnumType = oldFieldInfo.enum_type
                    local newEnumType = newFieldInfo.enum_type

                    if oldEnumType == newEnumType then
                        -- Compatible enum type - preserve the value
                        preservedFields[fieldName] = fieldValue
                        NAG:Debug("[NodeEditors] PreserveCompatibleFields: Preserved field '%s' (enum_type='%s')", fieldName, oldEnumType or "nil")
                    end
                else
                    -- Primitive types (string, int32, double, bool) - preserve if types match
                    preservedFields[fieldName] = fieldValue
                    NAG:Debug("[NodeEditors] PreserveCompatibleFields: Preserved field '%s' (type='%s')", fieldName, oldType)
                end
            end
        end
    end

    return preservedFields
end

--- Emit node text using ASTSchemaEmitter
--- @param node table AST node to emit
--- @param source string Source function name for telemetry
--- @return string|nil Emitted text or nil on error
local function EmitNodeText(node, source)
    if not node then
        return nil
    end

    if not ASTSchemaEmitter then
        NAG:Warn("[NodeEditors] ASTSchemaEmitter not available (source=%s)", source or "NodeEditors.EmitNodeText")
        return nil
    end

    local nodeType = node.type
    local emittedText = ""

    if nodeType == ASTCore.NodeType.ACTION then
        emittedText = ASTSchemaEmitter.EmitActionNode(node) or ""
        NAG:Debug("[NodeEditors] EmissionSuccess (source=%s; nodeType=action; success=%s)", source or "NodeEditors.EmitNodeText", tostring(emittedText ~= ""))
    elseif nodeType == ASTCore.NodeType.VALUE then
        emittedText = ASTSchemaEmitter.EmitValueNode(node) or ""
        NAG:Debug("[NodeEditors] EmissionSuccess (source=%s; nodeType=value; success=%s)", source or "NodeEditors.EmitNodeText", tostring(emittedText ~= ""))
    else
        NAG:Warn("[NodeEditors] Invalid node type (source=%s; nodeType=%s)", source or "NodeEditors.EmitNodeText", tostring(nodeType))
        return nil
    end

    return emittedText
end

local SchemaAccessorModule

local function GetSchemaAccessor()
    if SchemaAccessorModule == nil then
        SchemaAccessorModule = NAG:GetModule("SchemaAccessor")
    end
    return SchemaAccessorModule
end





local function RefreshASTTree(clause, clauseIdx, editorState, ...)
    local ASTEditor = ns.RotationEditorAST
    if ASTEditor then
        local isVariable = EditorUtils.IsVariableIndex(clauseIdx)
        if not isVariable then
            NAG:Info("Refreshing AST tree for clause %s", tostring(clauseIdx))
        end
        ASTEditor:RefreshASTTree(clause, clauseIdx, editorState, ...)
    end
end

--- Parse action string to AST for group action editing
--- @param actionString string The action string to parse (can include conditions: "(condition) and NAG:CastSpell(123)")
--- @param editorState table The editor state
--- @return table|nil AST node for the action (proto AST) or nil if parsing fails
local function ParseGroupAction(actionString, editorState)
    if not actionString or actionString == "" then
        -- Create empty cast_spell action (proto AST)
        return ASTAction.CreateFromFields("cast_spell", {}, nil)
    end

    local NAGStringParser = NAG:GetModule("NAGStringParser")
    if NAGStringParser then
        -- Use ParseClause to support conditions, NAG:Hidden(), and notes
        local clauseResult = NAGStringParser:ParseClause(actionString, nil, nil)
        if clauseResult and clauseResult.action then
            -- Set condition on action if present
            if clauseResult.condition and ASTAction then
                ASTAction.SetCondition(clauseResult.action, clauseResult.condition)
            end
            return clauseResult.action
        end
    end

    -- Parser failed - cannot create invalid action (no fallback)
    NAG:Error("ParseGroupAction: Failed to parse action string - cannot create action without valid proto AST")
    return nil
end

--- Parse variable value to AST for variable editing
--- @param valueString string The variable value expression to parse (can include logical operators: "A and B or C")
--- @param editorState table The editor state
--- @return table AST node for the value (proto AST)
local function ParseVariableValue(valueString, editorState)
    if not valueString or valueString == "" then
        -- Return empty constant (proto AST)
        return ASTValue.CreateConst("")
    end

    local NAGStringParser = NAG:GetModule("NAGStringParser")
    if NAGStringParser then
        -- Use ParseClause to handle value-only parsing (automatically routes to ParseValue/ParseCondition)
        local clauseResult = NAGStringParser:ParseClause(valueString, nil, nil)
        if clauseResult then
            -- Extract value from clause result (could be in value or condition field)
            local valueAST = clauseResult.value or clauseResult.condition
            if valueAST then
                return valueAST
            end
        end
    end

    -- Fallback to constant (proto AST)
    return ASTValue.CreateConst(valueString)
end

local function PreserveCurrentSelection(editorState, clauseIdx)
    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if not editorData or not editorData.astTreeGroup then
        return nil
    end

    local astTreeGroup = editorData.astTreeGroup
    local currentSelection = astTreeGroup.selected or editorData.lastSelection
    editorData.pendingSelection = currentSelection
    return currentSelection
end

--- Find action node by semantic position (root_act) rather than numeric ID
--- @param editorData table Editor data with nodeDetails and nodeDetailsByUniqueValue
--- @return string|nil Node ID or uniqueValue path of action node, or nil if not found
local function FindActionNodeByPosition(editorData)
    if not editorData or not editorData.nodeDetailsByUniqueValue then
        return nil
    end

    -- Search for action node: it's always a direct child of root with path starting with "root_act"
    -- uniqueValue format: "root\001root_act_X" or just "root_act_X" if it's the first child
    for uniqueValue, nodeData in pairs(editorData.nodeDetailsByUniqueValue) do
        if nodeData and nodeData.nodeType == "action" then
            -- Check if it's a direct child of root (uniqueValue starts with "root\001root_act" or is "root_act_X")
            if uniqueValue:match("^root\001root_act") or uniqueValue:match("^root_act") then
                NAG:Debug(format("[FindActionNodeByPosition] Found action node: uniqueValue=%s, nodeId=%s",
                    uniqueValue:gsub("\001", " → "), tostring(nodeData.nodeId or "unknown")))
                return uniqueValue
            end
        end
    end

    -- Fallback: search nodeDetails for any nodeId starting with "root_act"
    if editorData.nodeDetails then
        for nodeId, nodeData in pairs(editorData.nodeDetails) do
            if nodeData and nodeData.nodeType == "action" and nodeId:match("^root_act") then
                NAG:Debug(format("[FindActionNodeByPosition] Found action node (fallback): nodeId=%s", nodeId))
                return nodeId
            end
        end
    end

    NAG:Debug("[FindActionNodeByPosition] Action node not found in editorData")
    return nil
end

local function ReselectCurrentNode(editorState, clauseIdx, selectionOverride)
    -- Note: delay parameter removed - all operations are synchronous

    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if not editorData or not editorData.astTreeGroup then
        return
    end

    local astTreeGroup = editorData.astTreeGroup
    local targetSelection = selectionOverride or editorData.pendingSelection or astTreeGroup.selected or editorData.lastSelection

    -- CRITICAL: If targetSelection looks like an action node (root_act_X), find it by position instead
    -- This handles the case where nodeCounter changed and the numeric ID is stale
    if targetSelection and (targetSelection:match("^root_act") or (targetSelection:find("\001") and targetSelection:match("root_act"))) then
        local actionNodeSelection = FindActionNodeByPosition(editorData)
        if actionNodeSelection then
            targetSelection = actionNodeSelection
        else
            NAG:Debug(format("[ReselectCurrentNode] Could not find action node by position, using original: %s",
                targetSelection:gsub("\001", " → ")))
        end
    end

    -- CRITICAL: If targetSelection is a bare nodeId (no \001 separator), resolve it to full uniqueValue path
    -- TreeGroup.SelectByValue requires the full hierarchical path (e.g., "root\001root_cond_1" not just "root_cond_1")
    if targetSelection and not targetSelection:find("\001") then
        local resolvedUniqueValue = nil

        -- First, try to find in nodeDetailsByUniqueValue (preferred - contains full paths)
        if editorData.nodeDetailsByUniqueValue then
            for uniqueValue, nodeData in pairs(editorData.nodeDetailsByUniqueValue) do
                if uniqueValue and type(uniqueValue) == "string" then
                    -- Check if this uniqueValue ends with our targetSelection (exact match or hierarchical path)
                    if uniqueValue == targetSelection or uniqueValue:match("\001" .. targetSelection:gsub("%-", "%%-") .. "$") then
                        resolvedUniqueValue = uniqueValue
                        break
                    end
                end
            end
        end

        -- Fallback: if nodeId exists in nodeDetails, try to construct the path
        -- This handles edge cases where nodeDetailsByUniqueValue might be incomplete
        if not resolvedUniqueValue and editorData.nodeDetails and editorData.nodeDetails[targetSelection] then
            -- For root nodes, the uniqueValue is just the nodeId
            if targetSelection == "root" then
                resolvedUniqueValue = "root"
            else
                -- For other nodes, try to find parent path from nodeDetailsByUniqueValue
                -- Most nodes are children of root, so try "root\001" + nodeId
                local candidatePath = "root\001" .. targetSelection
                if editorData.nodeDetailsByUniqueValue and editorData.nodeDetailsByUniqueValue[candidatePath] then
                    resolvedUniqueValue = candidatePath
                end
            end
        end

        if resolvedUniqueValue then
            targetSelection = resolvedUniqueValue
        end
    end

    if not targetSelection then
        return
    end

    local readableSelection = targetSelection:gsub("\001", " → ")
    editorData.pendingSelection = nil

    if astTreeGroup.SelectByValue then
        astTreeGroup:SelectByValue(targetSelection)
        local actualSelected = astTreeGroup.selected
        if actualSelected ~= targetSelection then
            NAG:Debug(format("[ReselectCurrentNode] SelectByValue failed: expected=%s, actual=%s",
                readableSelection, actualSelected and actualSelected:gsub("\001", " → ") or "nil"))
            if astTreeGroup.Fire then
                astTreeGroup:Fire("OnGroupSelected", targetSelection)
            end
        else
            NAG:Debug(format("[ReselectCurrentNode] Selection successful: %s", readableSelection))
        end
    elseif astTreeGroup.Fire then
        astTreeGroup:Fire("OnGroupSelected", targetSelection)
    end
end

--- Public wrapper so other modules can trigger node reselection/refresh
--- @param editorState table
--- @param clauseIdx number
--- @param delay number|nil
--- @param selectionOverride string|nil
function NodeEditors:ReselectNode(editorState, clauseIdx, delay, selectionOverride)
    ReselectCurrentNode(editorState, clauseIdx, selectionOverride)
end

--- Clear cached node details so subsequent refresh rebuilds fallback state
--- @param editorState table
--- @param clauseIdx number
function NodeEditors:ClearCachedNodeDetails(editorState, clauseIdx)
    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if not editorData then
        return
    end

    if editorData.nodeDetails then
        wipe(editorData.nodeDetails)
    end

    if editorData.nodeDetailsByUniqueValue then
        wipe(editorData.nodeDetailsByUniqueValue)
    end
end

local function GetFrameName(object)
    if not object then
        return "<nil>"
    end

    if type(object) == "table" then
        if object.GetName then
            local ok, result = pcall(object.GetName, object)
            if ok and result and result ~= "" then
                return result
            end
        end

        local frame = object.frame
        if frame and frame.GetName then
            local ok, result = pcall(frame.GetName, frame)
            if ok and result and result ~= "" then
                return result
            end
        end
    elseif type(object) == "userdata" and object.GetName then
        local ok, result = pcall(object.GetName, object)
        if ok and result and result ~= "" then
            return result
        end
    end

    return tostring(object)
end

local function ShouldShowContextMenu(nodeData, nodeId)
    if not nodeData then
        return false
    end

    if nodeData.nodeType == "root" then
        return false
    end

    return true
end

-- ============================ CONTEXT MENU HELPERS ============================

local LIST_PARENT_FIELDS = {
    children = true,
    arguments = true,
    actions = true
}


local function GetNodeData(editorState, clauseIdx, nodeId)
    -- Use GetClauseEditorData to handle regular clauses, group actions, AND variables
    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if not editorData or not editorData.nodeDetails then
        return nil
    end

    return EditorUtils.FindNodeDetail(editorData, nodeId)
end

local function GetParentList(parentNode, field)
    if not parentNode or not field then
        return nil, nil
    end

    local list = parentNode[field]
    return list, field
end

local function FindNodeIndex(list, target)
    if not list then
        return nil
    end
    for idx, value in ipairs(list) do
        if value == target then
            return idx
        end
    end
    return nil
end

local function IsNotOperator(parentNode)
    if not parentNode then return false end
    return ASTValue.IsLogicalOp(parentNode) and ASTValue.GetValueType(parentNode) == ASTValue.ValueType.NOT
end

local function CanListMutate(nodeData)
    if not nodeData or not nodeData.parentNode or not nodeData.parentField then
        return false
    end
    if not LIST_PARENT_FIELDS[nodeData.parentField] then
        return false
    end
    if IsNotOperator(nodeData.parentNode) then
        return false
    end
    return true
end

local function PrepareReselection(editorState, clauseIdx, fallback)
    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if editorData then
        editorData.pendingSelection = fallback or editorData.lastSelection
    end
end

local CONTEXT_MENU_FRAME

local function GetContextMenuFrame()
    if not CONTEXT_MENU_FRAME then
        -- UIParent is a Frame object, not a function, so access it directly from _G
        -- WoWAPI registry only handles functions, not Frame objects
        local parentFrame = UIParent
        local createFrame = WoWAPI and CreateFrame or _G.CreateFrame
        if createFrame and parentFrame then
            CONTEXT_MENU_FRAME = createFrame("Frame", "NAGRotationNodeContextMenu", parentFrame, "UIDropDownMenuTemplate")
        end
    end
    return CONTEXT_MENU_FRAME
end

local function CloseContextMenu()
    ns.LibUIDropDownMenu:CloseDropDownMenus()
end

local function IsConditionContext(nodeData, nodeId)
    if not nodeData then
        return false
    end

    if nodeData.context == "condition" then
        return true
    end

    if nodeData.context == "action" then
        return false
    end

    if nodeId and type(nodeId) == "string" then
        if nodeId:find("^root_cond") then
            return true
        end
    end

    return true
end

local function NeedsParentRefresh(nodeId)
    if not nodeId then
        return false
    end
    return nodeId:match("_arg%d+$") or nodeId:match("_lhs$") or nodeId:match("_rhs$")
end

local function BuildHierarchicalMenu(items, getCategories, createLeafEntry)
    if not items or #items == 0 then
        return nil
    end

    local root = { children = {}, entries = {} }

    local function insertNode(node, categories, entry, depth)
        depth = depth or 1
        if categories and depth <= #categories then
            local category = categories[depth]
            if category and category ~= "" then
                node.children[category] = node.children[category] or { children = {}, entries = {} }
                insertNode(node.children[category], categories, entry, depth + 1)
                return
            end
        end

        table.insert(node.entries, entry)
    end

    for _, item in ipairs(items) do
        local entry = createLeafEntry(item)
        if entry then
            entry.notCheckable = true
            local categories = getCategories(item) or {}
            if #categories == 0 then
                table.insert(root.entries, entry)
            else
                insertNode(root, categories, entry, 1)
            end
        end
    end

    local function flatten(node)
        local menu = {}

        local categoryNames = {}
        for category in pairs(node.children) do
            table.insert(categoryNames, category)
        end
        table.sort(categoryNames)

        for _, category in ipairs(categoryNames) do
            local submenu = flatten(node.children[category])
            if submenu and #submenu > 0 then
                table.insert(menu, {
                    text = category,
                    hasArrow = true,
                    notCheckable = true,
                    menuList = submenu
                })
            end
        end

        table.sort(node.entries, function(a, b)
            return (a.text or "") < (b.text or "")
        end)

        for _, entry in ipairs(node.entries) do
            table.insert(menu, entry)
        end

        return menu
    end

    local finalMenu = flatten(root)
    if finalMenu and #finalMenu > 0 then
        return finalMenu
    end

    return nil
end

function NodeEditors:ConvertNodeToNamedFunction(nodeId, nodeData, functionName, clauseIdx, editorState)
    if not nodeData or not nodeData.node or not functionName then
        return
    end

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    local node = nodeData.node

    -- Resolve function metadata to get valueType (functionName is already snake_case from dropdown)
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local valueMetadata = nil
    if functionName and SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
        -- Check nagFunctionMappings first
        local snakeIdentifier = functionName
        if SchemaAccessor.nagFunctionMappings then
            -- Convert snake_case to PascalCase to check mappings
            local pascalName = ns.SchemaUtils:SnakeToPascal(functionName)
            if pascalName and SchemaAccessor.nagFunctionMappings[pascalName] then
                local protoName = SchemaAccessor.nagFunctionMappings[pascalName]
                local valueName = protoName:match("^APLValue(.+)$")
                if valueName then
                    snakeIdentifier = ns.SchemaUtils:CamelToSnake(valueName) or functionName
                end
            end
        end

        if snakeIdentifier:match("^[a-z][a-z0-9_]*$") then
            valueMetadata = SchemaAccessor:GetMetadataByIdentifier(snakeIdentifier, nil)
        end
    end

    -- Create proto AST value node with function call
    local newNode
    if valueMetadata and valueMetadata.valueType then
        -- Create function call node with empty arguments (user will fill in)
        newNode = ASTValue.Create(valueMetadata.valueType, {})
    else
        -- Metadata not found - create constant placeholder (will show error in editor)
        NAG:Warn("ConvertNodeToNamedFunction: Could not resolve metadata for function '%s' - creating constant placeholder", tostring(functionName))
        newNode = ASTValue.CreateConst(0)
    end

    -- Replace node structure while preserving reference (for parent structure)
    ReplaceNodeStructure(node, newNode)

    NAG:Info("Converted node [%s] to function: %s", tostring(nodeId), functionName)
    EditorUtils.MarkDirty(editorState)

    self:RebuildConditionFromAST(clause, clauseIdx, editorState)

    if NeedsParentRefresh(nodeId) then
        local ArgumentRenderer = ns.RotationEditorArgumentRenderer
        if nodeId:match("_arg%d+$") then
            if nodeData.parentNode then
                EmitNodeText(nodeData.parentNode, "NodeEditors.OnArgumentChanged")
            end
        elseif nodeData.parentNode and ASTValue.IsComparison(nodeData.parentNode) then
            local emittedText = EmitNodeText(nodeData.parentNode, "NodeEditors.OnArgumentChanged")
            if emittedText and editorState then
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                    NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                end
            end
        end
    end

    ReselectCurrentNode(editorState, clauseIdx, nodeId)
end

function NodeEditors:ConvertNodeToAction(nodeId, nodeData, metadata, clauseIdx, editorState)
    if not nodeData or not nodeData.node or not metadata then
        return
    end

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    -- metadata comes from GetAllActionsWithMetadata() which has 'name', not 'actionType'
    -- Or from GetMetadataByIdentifier() which has both 'name' and 'actionType'
    local identifier = metadata.name or metadata.actionType

    local node = nodeData.node

    -- Determine canonical actionType (snake_case)
    local canonicalActionType = identifier
    if (not canonicalActionType or canonicalActionType == "") and metadata.nagName then
        local converted = ns.SchemaUtils:CamelToSnake(metadata.nagName)
        if converted then
            canonicalActionType = converted
        else
            NAG:Debug("[NodeEditors] ConvertNodeToAction: CamelToSnake conversion failed for nagName (nagName=%s)", tostring(metadata.nagName))
            canonicalActionType = metadata.nagName
        end
    end
    if (not canonicalActionType or canonicalActionType == "") and metadata.protoName then
        local suffix = metadata.protoName:match("^APLAction(.+)$")
        if suffix then
            local converted = ns.SchemaUtils:CamelToSnake(suffix)
            if converted then
                canonicalActionType = converted
            else
                NAG:Debug("[NodeEditors] ConvertNodeToAction: CamelToSnake conversion failed for protoName suffix (protoName=%s; suffix=%s)", tostring(metadata.protoName), tostring(suffix))
                canonicalActionType = suffix
            end
        end
    end
    if not canonicalActionType or canonicalActionType == "" then
        local SchemaAccessor = GetSchemaAccessor()
        if SchemaAccessor then
            SchemaAccessor:Warn("ConvertNodeToAction: Missing required field 'name' or 'actionType' for action - schema may be incomplete")
        end
        -- Cannot create action without actionType
        return
    end

    -- Preserve condition if it exists (proto AST action nodes can have conditions)
    local existingCondition = nil
    if node.type == ASTCore.NodeType.ACTION and node.condition then
        existingCondition = node.condition
    end

    -- Create proto AST action node with empty actionData (user will fill in arguments)
    local newNode = ASTAction.Create(canonicalActionType, {}, existingCondition)

    -- Store editor metadata (not part of proto AST, but needed for UI)
    newNode.actionType = canonicalActionType
    newNode.protoMessage = metadata.protoName
    -- Note: messageSchema and actionMetadata are not stored - code fetches fresh from SchemaAccessor when needed
    if not metadata.messageSchema then
        local SchemaAccessor = GetSchemaAccessor()
        if SchemaAccessor then
            SchemaAccessor:Warn("[ConvertNodeToAction] metadata.messageSchema is nil for actionType '%s' (protoName: %s) - this should not happen",
                canonicalActionType, metadata.protoName)
        end
    end

    -- Replace node structure while preserving reference (for parent structure)
    ReplaceNodeStructure(node, newNode)

    local displayName = EditorUtils.ResolveActionDisplayName(metadata)
    NAG:Info("Converted node [%s] to action: %s", tostring(nodeId), displayName)
    EditorUtils.MarkDirty(editorState)

    -- Sync action to canonical storage for group actions
    self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)

    local ASTEditor = ns.RotationEditorAST
    if ASTEditor then
        ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
    end

    if clause.action then
        -- originalText removed - use ASTSchemaEmitter for text synthesis
        -- Note: actionMetadata and messageSchema are not stored - code fetches fresh from SchemaAccessor when needed
    end

    ReselectCurrentNode(editorState, clauseIdx, nodeId)
end

local function BuildFunctionConversionMenu(self, nodeId, nodeData, clauseIdx, editorState)
    -- Use EditorUtils schema submenu builder for schema-organized submenus
    return EditorUtils:BuildSchemaSubmenuMenuAuto("Values", {
        editorState = editorState,
        onItemSelected = function(itemMetadata)
            -- itemMetadata has 'name' field (not 'valueType') from GetAllValuesWithMetadata
            local valueKey = itemMetadata.name
            if not valueKey then
                local SchemaAccessor = NAG:GetModule("SchemaAccessor")
                if SchemaAccessor then
                    SchemaAccessor:Warn("BuildFunctionConversionMenu: Missing required field 'name' for value - schema may be incomplete")
                end
                return
            end
            self:ConvertNodeToNamedFunction(nodeId, nodeData, valueKey, clauseIdx, editorState)
            CloseContextMenu()
        end
    })
end

local function BuildActionConversionMenu(self, nodeId, nodeData, clauseIdx, editorState)
    -- Use EditorUtils schema submenu builder for schema-organized submenus
    return EditorUtils:BuildSchemaSubmenuMenuAuto("Actions", {
        editorState = editorState,
        onItemSelected = function(itemMetadata)
            self:ConvertNodeToAction(nodeId, nodeData, itemMetadata, clauseIdx, editorState)
            CloseContextMenu()
        end
    })
end

function NodeEditors:CopyNodeToClipboard(nodeData, editorState)
    if not nodeData or not nodeData.node or not editorState then
        return
    end

    editorState.astClipboard = {
        node = EditorUtils.CopyTable(nodeData.node),
        nodeType = nodeData.nodeType,
        context = nodeData.context
    }
end

function NodeEditors:DeleteNode(nodeData, clauseIdx, editorState)
    if not nodeData or not nodeData.node or not nodeData.parentNode then
        return
    end

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    if not CanListMutate(nodeData) then
        return
    end

    local parentList = GetParentList(nodeData.parentNode, nodeData.parentField)
    if not parentList then
        return
    end

    local idx = nodeData.parentIndex or FindNodeIndex(parentList, nodeData.node)
    if idx then
        table.remove(parentList, idx)
    end

    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if editorData then
        editorData.pendingSelection = nodeData.parentId or "root"
    end

    EditorUtils.MarkDirty(editorState)

    if nodeData.context == "condition" then
        self:RebuildConditionFromAST(clause, clauseIdx, editorState)
    else
        -- Action context - sync to canonical storage first
        self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end
    end
end

function NodeEditors:DuplicateNode(nodeData, clauseIdx, editorState)
    if not nodeData or not nodeData.node or not nodeData.parentNode then
        return
    end

    if not CanListMutate(nodeData) then
        return
    end

    local parentList = GetParentList(nodeData.parentNode, nodeData.parentField)
    if not parentList then
        return
    end

    local idx = nodeData.parentIndex or FindNodeIndex(parentList, nodeData.node)
    if not idx then
        return
    end

    local clone = EditorUtils.CopyTable(nodeData.node)
    table.insert(parentList, idx + 1, clone)

    PrepareReselection(editorState, clauseIdx, nodeData.parentId)
    EditorUtils.MarkDirty(editorState)

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    if nodeData.context == "condition" then
        self:RebuildConditionFromAST(clause, clauseIdx, editorState)
    else
        -- Action context - sync to canonical storage first
        self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end
    end
end

function NodeEditors:PasteNodeAsSibling(nodeData, clauseIdx, editorState)
    if not nodeData or not nodeData.parentNode or not editorState then
        return
    end

    local clipboard = editorState.astClipboard
    if not clipboard or not clipboard.node then
        return
    end

    if clipboard.context and nodeData.context and clipboard.context ~= nodeData.context then
        return
    end

    if not CanListMutate(nodeData) then
        return
    end

    local parentList = GetParentList(nodeData.parentNode, nodeData.parentField)
    if not parentList then
        return
    end

    local idx = nodeData.parentIndex or FindNodeIndex(parentList, nodeData.node)
    if not idx then
        return
    end

    local clone = EditorUtils.CopyTable(clipboard.node)
    table.insert(parentList, idx + 1, clone)

    PrepareReselection(editorState, clauseIdx, nodeData.parentId)
    EditorUtils.MarkDirty(editorState)

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    if nodeData.context == "condition" then
        self:RebuildConditionFromAST(clause, clauseIdx, editorState)
    else
        -- Action context - sync to canonical storage first
        self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end
    end
end

function NodeEditors:InsertEmptyNode(nodeData, nodeType, clauseIdx, editorState)
    if not nodeData or not nodeData.parentNode or not nodeType then
        return
    end

    if not CanListMutate(nodeData) then
        return
    end

    local parentList = GetParentList(nodeData.parentNode, nodeData.parentField)
    if not parentList then
        return
    end

    local idx = nodeData.parentIndex or FindNodeIndex(parentList, nodeData.node)
    if not idx then
        return
    end

    -- Create empty node based on type
    local newNode
    if nodeType == "function" then
        -- Empty function - create constant placeholder (will be converted to function when user selects)
        newNode = ASTValue.CreateConst(0)
    elseif nodeType == "comparison" then
        -- Create comparison with constant operands
        local lhsConst = ASTValue.CreateConst(0)
        local rhsConst = ASTValue.CreateConst(0)
        newNode = ASTValue.CreateCmp(ASTValue.ComparisonOperator.LE, lhsConst, rhsConst)
    elseif nodeType == "logical" then
        -- Create AND with constant children
        local child1 = ASTValue.CreateConst(0)
        local child2 = ASTValue.CreateConst(0)
        newNode = ASTValue.CreateAnd({ child1, child2 })
    elseif nodeType == "math" then
        -- Create math with constant operands
        local lhsConst = ASTValue.CreateConst(0)
        local rhsConst = ASTValue.CreateConst(0)
        newNode = ASTValue.CreateMath(ASTValue.MathOperator.ADD, lhsConst, rhsConst)
    elseif nodeType == "constant" then
        newNode = ASTValue.CreateConst(0)
    elseif nodeType == "action" then
        -- Create empty action node (no action type - will be set when user selects)
        newNode = ASTAction.Create(nil, nil, nil)
    else
        return
    end

    table.insert(parentList, idx + 1, newNode)

    PrepareReselection(editorState, clauseIdx, nodeData.parentId)
    EditorUtils.MarkDirty(editorState)

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    if nodeData.context == "condition" then
        self:RebuildConditionFromAST(clause, clauseIdx, editorState)
    else
        -- Action context - sync to canonical storage first
        self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end
    end
end

function NodeEditors:OverwriteNode(nodeData, clauseIdx, editorState)
    if not nodeData or not nodeData.node or not editorState then
        return
    end

    local clipboard = editorState.astClipboard
    if not clipboard or not clipboard.node then
        return
    end

    -- Validate context compatibility
    if clipboard.context and nodeData.context and clipboard.context ~= nodeData.context then
        return
    end

    -- Can't overwrite root node
    if not nodeData.parentNode then
        return
    end

    local clone = EditorUtils.CopyTable(clipboard.node)

    -- Check if this is a root-level field (condition/action) or a list item
    local parentField = nodeData.parentField
    if parentField == "condition" or parentField == "action" then
        -- Root-level field: directly replace the field on parent
        nodeData.parentNode[parentField] = clone
    else
        -- List item: find and replace in parent list
        local parentList = GetParentList(nodeData.parentNode, nodeData.parentField)
        if not parentList then
            return
        end

        local idx = nodeData.parentIndex or FindNodeIndex(parentList, nodeData.node)
        if not idx then
            return
        end

        -- Replace the node at this index with clipboard contents
        parentList[idx] = clone
    end

    PrepareReselection(editorState, clauseIdx, nodeData.parentId)
    EditorUtils.MarkDirty(editorState)

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    if nodeData.context == "condition" then
        self:RebuildConditionFromAST(clause, clauseIdx, editorState)
    else
        -- Action context - sync to canonical storage first
        self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end
    end
end

function NodeEditors:ChangeLogicalOperator(node, newOp, clause, clauseIdx, editorState)
    if not node or not ASTValue.IsLogicalOp(node) then
        return
    end

    local oldOp = ASTValue.GetValueType(node)
    if oldOp == newOp then
        return
    end

    local valueData = ASTValue.GetValueData(node)
    local children = {}
    if oldOp == ASTValue.ValueType.NOT then
        -- NOT has single child in .val
        if valueData and valueData.val then
            children = { valueData.val }
        end
    else
        -- AND/OR have children in .vals
        children = valueData and valueData.vals or {}
    end
    local childCount = #children

    -- Create new logical node with appropriate structure
    local newLogicalNode
    if newOp == "not" then
        -- NOT → keep only first child
        if childCount > 1 then
            NAG:Print(format("|cFFFF8800Warning: Changing to NOT will keep only first child (losing %d children)|r", childCount - 1))
        end
        local firstChild = children[1] or ASTValue.CreateConst(true)
        newLogicalNode = ASTValue.CreateNot(firstChild)
    elseif newOp == "and" or newOp == "or" then
        -- AND/OR → ensure at least 2 children
        if oldOp == ASTValue.ValueType.NOT and childCount < 2 then
            -- Add placeholder
            table.insert(children, ASTValue.CreateConst(true))
        end
        if newOp == "and" then
            newLogicalNode = ASTValue.CreateAnd(children)
        else
            newLogicalNode = ASTValue.CreateOr(children)
        end
    else
        return -- Invalid operator
    end

    -- Copy structure into existing node to preserve references
    for k, v in pairs(newLogicalNode) do
        node[k] = v
    end

    EditorUtils.MarkDirty(editorState)
    self:RebuildConditionFromAST(clause, clauseIdx, editorState)
end


function NodeEditors:ConvertNodeToLogical(nodeId, nodeData, logicalOp, clauseIdx, editorState)
    if not nodeData or not nodeData.node or not logicalOp then
        return
    end

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    local node = nodeData.node
    -- Preserve old node
    local oldNode
    if node.type == ASTCore.NodeType.VALUE then
        -- Proto AST node - clone it
        oldNode = ASTCore.CreateNode(ASTCore.NodeType.VALUE)
        for k, v in pairs(node) do
            if k ~= "type" then
                oldNode[k] = v
            end
        end
        -- Copy value structure
        if node.value then
            oldNode.value = {}
            for k, v in pairs(node.value) do
                oldNode.value[k] = v
            end
        end
    else
        -- Legacy clause format detected - fail fast
        NAG:Error(format("[NodeEditors] Legacy clause format detected - proto AST required (node type=%s)", tostring(node and node.type)))
        return
    end

    -- Create new proto AST logical node
    local logicalOpLower = logicalOp:lower()
    local newLogicalNode
    if logicalOpLower == "not" then
        -- NOT takes single child
        newLogicalNode = ASTValue.CreateNot(oldNode)
    elseif logicalOpLower == "and" then
        -- AND takes multiple children - start with old node plus placeholder
        local placeholder = ASTValue.CreateConst(0)
        newLogicalNode = ASTValue.CreateAnd({ oldNode, placeholder })
    elseif logicalOpLower == "or" then
        -- OR takes multiple children - start with old node plus placeholder
        local placeholder = ASTValue.CreateConst(0)
        newLogicalNode = ASTValue.CreateOr({ oldNode, placeholder })
    else
        NAG:Error("ConvertNodeToLogical: Unknown logical operator '%s'", tostring(logicalOp))
        return
    end

    -- Replace node structure while preserving reference (for parent structure)
    ReplaceNodeStructure(node, newLogicalNode)

    NAG:Info("Converted node [%s] to logical operator: %s", tostring(nodeId), logicalOp:upper())
    PrepareReselection(editorState, clauseIdx, nodeId)
    EditorUtils.MarkDirty(editorState)
    self:RebuildConditionFromAST(clause, clauseIdx, editorState)
    ReselectCurrentNode(editorState, clauseIdx, nodeId)
end

function NodeEditors:ConvertNodeType(nodeId, nodeData, targetType, clauseIdx, editorState)
    if not nodeData or not nodeData.node or not targetType then
        return
    end

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        return
    end

    local node = nodeData.node
    local currentType = node.type

    if targetType == currentType then
        return
    end

    if targetType == "logical" then
        return
    end

    -- Extract current value from node
    local extractValue = function(n)
        if n.type == ASTCore.NodeType.VALUE then
            -- Proto AST - extract constant value if possible
            local valueType = ASTValue.GetValueType(n)
            if valueType == ASTValue.ValueType.CONST then
                local data = ASTValue.GetValueData(n)
                return data and data.val
            end
            -- For other types, return 0 as fallback
            return 0
        elseif n.type == "constant" then
        -- Legacy format detected - should not happen in production code
        NAG:Error(format("[NodeEditors] Legacy format constant node detected - should be proto AST. Context: GetNumericValueFromNode"))
        -- Fail fast: return 0 for legacy format instead of attempting fallback
        return 0
        elseif n.lhs and n.lhs.value ~= nil then
            return n.lhs.value
        elseif n.rhs and n.rhs.value ~= nil then
            return n.rhs.value
        else
            return 0
        end
    end

    local currentValue = extractValue(node)

    -- Create new proto AST node based on target type
    local newNode
    if targetType == "comparison" then
        -- Create comparison with constant operands
        local lhsConst = ASTValue.CreateConst(currentValue)
        local rhsConst = ASTValue.CreateConst(0)
        newNode = ASTValue.CreateCmp(ASTValue.ComparisonOperator.LT, lhsConst, rhsConst)
    elseif targetType == "function" then
        -- Create a function node with first available function as placeholder
        -- User will select the actual function from dropdown/APLAutocomplete
        -- APLValue uses oneof - we need to set a specific oneof field, can't be "empty"
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        local placeholderFunctionName = nil

        if SchemaAccessor and SchemaAccessor.GetAllValuesWithMetadata then
            local allValues = SchemaAccessor:GetAllValuesWithMetadata()
            if allValues and #allValues > 0 and allValues[1] and allValues[1].name then
                placeholderFunctionName = allValues[1].name
            end
        end

        if placeholderFunctionName then
            -- Create function node with placeholder oneof field set
            -- This creates: node.value[placeholderFunctionName] = {}
            newNode = ASTValue.Create(placeholderFunctionName, {})
        else
            -- APLValue functions are required - fail fast if missing
            NAG:Error("ConvertNodeType: No APLValue functions available - required for value node creation")
            return
        end
    elseif targetType == "math" then
        -- Create math with constant operands
        local lhsConst = ASTValue.CreateConst(currentValue)
        local rhsConst = ASTValue.CreateConst(0)
        newNode = ASTValue.CreateMath(ASTValue.MathOperator.ADD, lhsConst, rhsConst)
    elseif targetType == "constant" then
        -- Create constant with extracted value
        newNode = ASTValue.CreateConst(currentValue)
        if currentValue ~= node.value then
            NAG:Info("[NodeEditors] Coerced constant value (original=%s; value=%s)", tostring(node.value), tostring(currentValue))
        end
    else
        return
    end

    -- Replace node structure while preserving reference (for parent structure)
    ReplaceNodeStructure(node, newNode)

    NAG:Info("Converted node [%s] to type: %s", tostring(nodeId), targetType)
    EditorUtils.MarkDirty(editorState)

    if IsConditionContext(nodeData, nodeId) then
        self:RebuildConditionFromAST(clause, clauseIdx, editorState)
    else
        -- Action context - sync to canonical storage first
        self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end
    end

    if NeedsParentRefresh(nodeId) then
        local ArgumentRenderer = ns.RotationEditorArgumentRenderer
        if nodeId:match("_arg%d+$") then
            if nodeData.parentNode then
                EmitNodeText(nodeData.parentNode, "NodeEditors.OnArgumentChanged")
            end
        elseif nodeData.parentNode and ASTValue.IsComparison(nodeData.parentNode) then
            local emittedText = EmitNodeText(nodeData.parentNode, "NodeEditors.OnArgumentChanged")
            if emittedText and editorState then
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                    NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                end
            end
        end
    end

    ReselectCurrentNode(editorState, clauseIdx, nodeId)
end

-- ============================ EXTRACT TO VARIABLE ============================

--- Serialize logical node children without the wrapping operator
--- This produces the "Original Text" value shown in the UI
--- @param logicalNode table Logical AST node (AND/OR/NOT) - proto AST
--- @return string Serialized expression of children
local function SerializeLogicalChildren(logicalNode)
    if not ASTValue.IsLogicalOp(logicalNode) then
        return ""
    end

    local valueType = ASTValue.GetValueType(logicalNode)
    local valueData = ASTValue.GetValueData(logicalNode)
    if not valueData then
        return ""
    end

    local children = {}
    if valueType == ASTValue.ValueType.NOT then
        -- NOT has single child in .val
        if valueData.val then
            children = { valueData.val }
        end
    else
        -- AND/OR have children in .vals
        children = valueData.vals or {}
    end

    if #children == 0 then
        return ""
    end

    local parts = {}
    for _, child in ipairs(children) do
        local serialized = ""
        if not ASTSchemaEmitter then
            NAG:Warn("[NodeEditors] ASTSchemaEmitter not available (source=NodeEditors.SerializeLogicalNode)")
        else
            serialized = ASTSchemaEmitter.EmitValueNode(child) or ""
            NAG:Debug("[NodeEditors] EmissionSuccess (source=NodeEditors.SerializeLogicalNode; nodeType=value; success=%s)", tostring(serialized ~= ""))
        end
        if serialized and serialized ~= "" then
            tinsert(parts, serialized)
        end
    end

    if valueType == ASTValue.ValueType.NOT then
        -- NOT has single child, return it directly
        return parts[1] or ""
    else
        -- AND/OR have multiple children, join with operator
        -- Use ASTSchemaEmitter as source of truth for emission format
        if #parts > 1 then
            local opText = (valueType == ASTValue.ValueType.AND) and "and" or "or"
            return "(" .. table.concat(parts, " " .. opText .. " ") .. ")"
        else
            return parts[1] or ""
        end
    end
end

--- Extract a logical operator node's children into a variable
--- Replaces the logical node with NAG:VariableRef("variableName")
--- @param nodeData table Node data containing the logical node
--- @param clauseIdx number Clause index
--- @param editorState table Editor state
function NodeEditors:ExtractLogicalToVariable(nodeData, clauseIdx, editorState)
    if not nodeData or not nodeData.node then
        NAG:Warn("ExtractLogicalToVariable: node must be a logical operator")
        return
    end

    -- Check if node is a logical operator using proto AST helpers
    if not ASTValue.IsLogicalOp(nodeData.node) then
        NAG:Warn("ExtractLogicalToVariable: node must be a logical operator")
        return
    end

    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause then
        NAG:Warn("ExtractLogicalToVariable: clause not found")
        return
    end

    local config = editorState.workingConfig
    if not config then
        NAG:Warn("ExtractLogicalToVariable: workingConfig not found")
        return
    end

    -- Ensure variables array exists
    if not config.variables then
        config.variables = {}
    end

    local logicalNode = nodeData.node

    -- Serialize the children expression (without the wrapping logical operator)
    local childrenExpression = SerializeLogicalChildren(logicalNode)
    if not childrenExpression or childrenExpression == "" then
        NAG:Warn("ExtractLogicalToVariable: no children to extract")
        return
    end

    -- Create and show popup dialog for variable name
    StaticPopupDialogs["NAG_EXTRACT_TO_VARIABLE"] = {
        text = "Enter variable name:",
        button1 = "Create",
        button2 = "Cancel",
        hasEditBox = true,
        OnShow = function(dialog)
            dialog:SetFrameStrata("FULLSCREEN_DIALOG")
            dialog:SetFrameLevel(200)
        end,
        OnAccept = function(dialog)
            local varName = dialog.EditBox:GetText()

            -- Validate variable name
            if not varName or varName == "" then
                NAG:Print("|cFFFF0000Variable name cannot be empty|r")
                return
            end

            -- Check for duplicate variable name
            for _, existingVar in ipairs(config.variables) do
                if existingVar.name == varName then
                    NAG:Print("|cFFFF0000Variable '" .. varName .. "' already exists|r")
                    return
                end
            end

            -- Create the variable
            local newVariable = {
                name = varName,
                value = childrenExpression
            }
            tinsert(config.variables, newVariable)

            -- Replace logical node with VariableRef function call (proto AST)
            local variableRefNode = ASTValue.CreateVariableRef(varName)
            -- Copy structure into existing node to preserve references
            for k, v in pairs(variableRefNode) do
                logicalNode[k] = v
            end

            -- Mark as dirty
            EditorUtils.MarkDirty(editorState)

            -- Rebuild condition from AST
            NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)

            -- Update the clause tree to show new variable in Groups & Variables
            local ASTEditor = ns.RotationEditorAST
            if ASTEditor and editorState.visualEditor and editorState.visualEditor.treeGroup then
                ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
            end

            -- Refresh and reselect current node
            local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
            ReselectCurrentNode(editorState, clauseIdx, previousSelection)

            NAG:Info("Extracted condition to variable: '%s'", varName)
            NAG:Print("|cFF00FF00Variable '" .. varName .. "' created successfully!|r")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
        enterClicksFirstButton = true,
    }

    StaticPopup_Show("NAG_EXTRACT_TO_VARIABLE")
end

local function BuildLogicalMenu(self, nodeData, clauseIdx, editorState)
    local clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    if not clause or not nodeData or not nodeData.node then
        return nil
    end

    if not IsConditionContext(nodeData) then
        return nil
    end

    -- Get current logical operator type from proto AST
    local currentValueType = ASTValue.GetValueType(nodeData.node)

    local operatorMenu = {
        {
            text = L["and"] or "AND",
            checked = currentValueType == ASTValue.ValueType.AND,
            func = function()
                self:ChangeLogicalOperator(nodeData.node, "and", clause, clauseIdx, editorState)
            end
        },
        {
            text = L["or"] or "OR",
            checked = currentValueType == ASTValue.ValueType.OR,
            func = function()
                self:ChangeLogicalOperator(nodeData.node, "or", clause, clauseIdx, editorState)
            end
        },
        {
            text = L["not"] or "NOT",
            checked = currentValueType == ASTValue.ValueType.NOT,
            func = function()
                self:ChangeLogicalOperator(nodeData.node, "not", clause, clauseIdx, editorState)
            end
        }
    }

    for _, entry in ipairs(operatorMenu) do
        entry.notCheckable = false
    end

    return operatorMenu
end

local function BuildConversionMenu(self, nodeId, nodeData, clauseIdx, editorState)
    if not nodeData or not nodeData.node then
        return nil
    end

    if nodeData.context == "action" then
        return BuildActionConversionMenu(self, nodeId, nodeData, clauseIdx, editorState)
    end

    if not IsConditionContext(nodeData, nodeId) then
        return nil
    end

    -- Detect proto AST nodes and determine actual node type
    local nodeType = nodeData.nodeType or nodeData.node.type
    local actualNode = nodeData.node

    -- Handle proto AST value nodes
    if actualNode.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(actualNode)
        if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR or valueType == ASTValue.ValueType.NOT then
            nodeType = "logical"
        elseif valueType == ASTValue.ValueType.CMP then
            nodeType = "comparison"
        elseif valueType == ASTValue.ValueType.CONST then
            nodeType = "constant"
        elseif valueType == ASTValue.ValueType.MATH then
            nodeType = "math"
        else
            -- Function call or other value type
            nodeType = "function"
        end
    end

    if nodeType == "logical" then
        return BuildLogicalMenu(self, nodeData, clauseIdx, editorState)
    end

    local options = {}
    local targets = {}
    if nodeType == "comparison" then
        targets = { "function", "constant", "math", "logical" }
    elseif nodeType == "function" then
        targets = { "comparison", "constant", "math", "logical", "function" }
    elseif nodeType == "constant" then
        targets = { "function", "comparison", "math", "logical" }
    elseif nodeType == "math" then
        targets = { "function", "comparison", "constant", "logical" }
    end

    for _, target in ipairs(targets) do
        if target == "function" then
            local functionMenu = BuildFunctionConversionMenu(self, nodeId, nodeData, clauseIdx, editorState)
            if functionMenu and #functionMenu > 0 then
                table.insert(options, {
                    text = L["function"] or "Function",
                    hasArrow = true,
                    notCheckable = true,
                    menuList = functionMenu
                })
            else
                table.insert(options, {
                    text = L["function"] or "Function",
                    notCheckable = true,
                    func = function()
                        self:ConvertNodeType(nodeId, nodeData, "function", clauseIdx, editorState)
                        CloseContextMenu()
                    end
                })
            end
        elseif target == "logical" then
            -- Logical conversion with submenu for AND/OR/NOT
            local logicalMenu = {
                {
                    text = "AND",
                    notCheckable = true,
                    func = function()
                        self:ConvertNodeToLogical(nodeId, nodeData, "and", clauseIdx, editorState)
                        CloseContextMenu()
                    end
                },
                {
                    text = "OR",
                    notCheckable = true,
                    func = function()
                        self:ConvertNodeToLogical(nodeId, nodeData, "or", clauseIdx, editorState)
                        CloseContextMenu()
                    end
                },
                {
                    text = "NOT",
                    notCheckable = true,
                    func = function()
                        self:ConvertNodeToLogical(nodeId, nodeData, "not", clauseIdx, editorState)
                        CloseContextMenu()
                    end
                }
            }
            table.insert(options, {
                text = "Logical",
                hasArrow = true,
                notCheckable = true,
                menuList = logicalMenu
            })
        else
            table.insert(options, {
                text = target:gsub("^%l", string.upper),
                notCheckable = true,
                func = function()
                    self:ConvertNodeType(nodeId, nodeData, target, clauseIdx, editorState)
                    CloseContextMenu()
                end
            })
        end
    end

    if #options == 0 then
        return nil
    end

    return options
end

--- Show context menu for root node (Priority X)
function NodeEditors:ShowRootNodeContextMenu(button, clause, clauseIdx, editorState)
    local menu = {}

    -- Ensure clause has an action node
    if not clause.action then
        if ASTAction then
            clause.action = ASTAction.CreateFromFields("cast_spell", {}, nil)
        end
    end

    -- Check condition from action.condition (proto AST structure)
    local conditionAST = ASTAction and ASTAction.GetCondition(clause.action)
    local hasCondition = conditionAST ~= nil

    -- Add Condition (if no condition exists)
    if not hasCondition then
        table.insert(menu, {
            text = L["addCondition"] or "Add Condition",
            notCheckable = true,
            func = function()
                -- Create proto AST constant condition
                if ASTValue and clause.action then
                    local constCondition = ASTValue.CreateConst(true)
                    ASTAction.SetCondition(clause.action, constCondition)
                    EditorUtils.MarkDirty(editorState)

                    -- Rebuild AST tree and refresh
                    -- CRITICAL: RefreshASTTree is synchronous and updates nodeDetailsByUniqueValue immediately
                    local ASTEditor = ns.RotationEditorAST
                    if ASTEditor then
                        ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
                    end

                    CloseContextMenu()

                    -- Auto-select the new condition for editing
                    -- CRITICAL: RefreshASTTree is synchronous, so we can select immediately
                    -- The uniqueValue format is "root\001root_cond_X" where X is the counter
                    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
                    if editorData and editorData.astTreeGroup then
                        -- Find the condition node's uniqueValue from nodeDetailsByUniqueValue
                        if editorData.nodeDetailsByUniqueValue then
                            local conditionUniqueValue = nil
                            for uniqueValue, nodeData in pairs(editorData.nodeDetailsByUniqueValue) do
                                if uniqueValue and type(uniqueValue) == "string" then
                                    -- Match root_cond (with optional counter suffix)
                                    if uniqueValue:match("^root\001root_cond") or uniqueValue == "root_cond" then
                                        conditionUniqueValue = uniqueValue
                                        break
                                    end
                                end
                            end

                            if conditionUniqueValue then
                                if editorData.astTreeGroup.SelectByValue then
                                    editorData.astTreeGroup:SelectByValue(conditionUniqueValue)
                                end
                            else
                                -- Fallback: try SelectByPath if uniqueValue not found
                                if editorData.astTreeGroup.SelectByPath then
                                    editorData.astTreeGroup:SelectByPath("root", "root_cond")
                                end
                            end
                        else
                            -- Fallback: use SelectByPath if nodeDetailsByUniqueValue not available
                            if editorData.astTreeGroup.SelectByPath then
                                editorData.astTreeGroup:SelectByPath("root", "root_cond")
                            end
                        end
                    end
                end
            end
        })
    else
        -- Remove Condition (if condition exists)
        table.insert(menu, {
            text = L["removeCondition"] or "Remove Condition",
            notCheckable = true,
            func = function()
                if ASTAction and clause.action then
                    ASTAction.SetCondition(clause.action, nil)
                end
                EditorUtils.MarkDirty(editorState)

                -- Rebuild AST tree and refresh
                local ASTEditor = ns.RotationEditorAST
                if ASTEditor then
                    ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
                end

                CloseContextMenu()
            end
        })
    end

    -- Show the menu
    local menuFrame = GetContextMenuFrame()
    if not menuFrame then
        NAG:Warn("Unable to open root node context menu")
        return
    end

    ns.LibUIDropDownMenu:EasyMenu(menu, menuFrame, "cursor", 0, 0, "MENU", 2)
end

function NodeEditors:ShowNodeContextMenu(button, uniquevalue, clauseIdx, editorState)
    if not button or not uniquevalue then
        return
    end

    local nodeId = uniquevalue
    if nodeId:find("\001") then
        nodeId = nodeId:match("[^\001]+$")
    end

    local nodeData = GetNodeData(editorState, clauseIdx, nodeId)
    if not nodeData then
        -- attempt to resolve structural nodes that may have numeric suffixes (e.g., _lhs_1)
        for suffix = 1, 10 do
            local candidate = nodeId .. "_" .. suffix
            nodeData = GetNodeData(editorState, clauseIdx, candidate)
            if nodeData then
                nodeId = candidate
                break
            end
        end
    end

    if not nodeData and uniquevalue ~= nodeId then
        nodeData = GetNodeData(editorState, clauseIdx, uniquevalue)
        if nodeData then
            nodeId = uniquevalue
        end
    end

    -- Get clause - handle regular clauses, group actions, and variables
    local clause = nil
    if EditorUtils.IsVariableIndex(clauseIdx) then
        -- Variable editor: get fakeClause from variableEditors
        local varIdx = EditorUtils.DecodeVariableIndex(clauseIdx)
        local varEditorData = editorState.variableEditors and editorState.variableEditors[varIdx]
        if varEditorData and varEditorData.fakeClause then
            clause = varEditorData.fakeClause
        end
    elseif EditorUtils.IsGroupActionIndex(clauseIdx) then
        -- Group action editor: get fakeClause from groupActionEditors
        local groupIdx, actionIdx = EditorUtils.DecodeGroupActionIndex(clauseIdx)
        local actionKey = "group_" .. groupIdx .. "_action_" .. actionIdx
        local groupActionEditorData = editorState.groupActionEditors and editorState.groupActionEditors[actionKey]
        if groupActionEditorData and groupActionEditorData.fakeClause then
            clause = groupActionEditorData.fakeClause
        end
    else
        -- Regular clause: get from priority_list
        clause = editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list and editorState.workingConfig.aplProto.priority_list[clauseIdx]
    end

    if not clause then
        NAG:Debug("[NodeEditors] ShowNodeContextMenu: No clause found (clauseIdx=%s)", tostring(clauseIdx))
        return
    end

    -- Special handling for root node
    if nodeData and nodeData.nodeType == "root" then
        self:ShowRootNodeContextMenu(button, clause, clauseIdx, editorState)
        return
    end

    if not ShouldShowContextMenu(nodeData, nodeId) then
        return
    end

    local menu = {}

    local clipboard = editorState.astClipboard
    local canMutateList = CanListMutate(nodeData)

    table.insert(menu, {
        text = L["duplicate"] or "Duplicate",
        notCheckable = true,
        disabled = not canMutateList,
        func = function()
            self:DuplicateNode(nodeData, clauseIdx, editorState)
            CloseContextMenu()
        end
    })

    table.insert(menu, {
        text = L["copy"] or "Copy",
        notCheckable = true,
        func = function()
            self:CopyNodeToClipboard(nodeData, editorState)
            CloseContextMenu()
        end
    })

    table.insert(menu, {
        text = L["paste"] or "Paste as Sibling",
        notCheckable = true,
        disabled = not (canMutateList and clipboard and clipboard.node and (not clipboard.context or clipboard.context == nodeData.context)),
        func = function()
            self:PasteNodeAsSibling(nodeData, clauseIdx, editorState)
            CloseContextMenu()
        end
    })

    -- Overwrite: Replace current node with clipboard contents (requires parent, compatible context)
    local canOverwrite = nodeData.parentNode and clipboard and clipboard.node and (not clipboard.context or clipboard.context == nodeData.context)
    table.insert(menu, {
        text = L["overwrite"] or "Overwrite with Clipboard",
        notCheckable = true,
        disabled = not canOverwrite,
        func = function()
            self:OverwriteNode(nodeData, clauseIdx, editorState)
            CloseContextMenu()
        end
    })

    -- Add Sibling: Insert new empty node
    if canMutateList and nodeData.context == "condition" then
        local addSiblingMenu = {
            {
                text = "Function (APLValue)",
                notCheckable = true,
                func = function()
                    self:InsertEmptyNode(nodeData, "function", clauseIdx, editorState)
                    CloseContextMenu()
                end
            },
            {
                text = "Comparison (<=, >=, etc.)",
                notCheckable = true,
                func = function()
                    self:InsertEmptyNode(nodeData, "comparison", clauseIdx, editorState)
                    CloseContextMenu()
                end
            },
            {
                text = "Logical (AND/OR/NOT)",
                notCheckable = true,
                func = function()
                    self:InsertEmptyNode(nodeData, "logical", clauseIdx, editorState)
                    CloseContextMenu()
                end
            },
            {
                text = "Math (+, -, *, /)",
                notCheckable = true,
                func = function()
                    self:InsertEmptyNode(nodeData, "math", clauseIdx, editorState)
                    CloseContextMenu()
                end
            },
            {
                text = "Constant (Number/String)",
                notCheckable = true,
                func = function()
                    self:InsertEmptyNode(nodeData, "constant", clauseIdx, editorState)
                    CloseContextMenu()
                end
            }
        }
        table.insert(menu, {
            text = L["addSibling"] or "Add Sibling",
            hasArrow = true,
            notCheckable = true,
            disabled = not canMutateList,
            menuList = addSiblingMenu
        })
    end

    -- Add Sibling: Insert new empty action node
    if canMutateList and nodeData.context == "action" then
        table.insert(menu, {
            text = L["addSibling"] or "Add Sibling",
            notCheckable = true,
            disabled = not canMutateList,
            func = function()
                self:InsertEmptyNode(nodeData, "action", clauseIdx, editorState)
                CloseContextMenu()
            end
        })
    end

    table.insert(menu, {
        text = L["delete"] or "Delete",
        notCheckable = true,
        disabled = not canMutateList,
        func = function()
            self:DeleteNode(nodeData, clauseIdx, editorState)
            CloseContextMenu()
        end
    })

    -- Extract to Variable option for logical operators in condition context
    if ASTValue.IsLogicalOp(nodeData.node) and nodeData.context == "condition" then
        table.insert(menu, {
            text = L["extractToVariable"] or "Extract to Variable",
            notCheckable = true,
            func = function()
                self:ExtractLogicalToVariable(nodeData, clauseIdx, editorState)
                CloseContextMenu()
            end
        })
    end

    local conversionMenu = BuildConversionMenu(self, nodeId, nodeData, clauseIdx, editorState)
    if conversionMenu and #conversionMenu > 0 then
        table.insert(menu, {
            text = L["convert"] or "Convert",
            hasArrow = true,
            notCheckable = true,
            menuList = conversionMenu
        })
    end

    -- Node Inspector
    table.insert(menu, {
        text = "|cFF00CCFFInspect Node|r",
        notCheckable = true,
        func = function()
            local NodeInspector = ns.RotationEditorNodeInspector
            if NodeInspector then
                NodeInspector:ShowInspector(nodeData, nodeId, clauseIdx, editorState)
            end
            CloseContextMenu()
        end
    })

    local menuFrame = GetContextMenuFrame()
    if not menuFrame then
        NAG:Warn("Unable to open context menu for node")
        return
    end

    ns.LibUIDropDownMenu:EasyMenu(menu, menuFrame, "cursor", 0, 0, "MENU", 2)
end

-- ~~~~~~~~~~ NODE EDIT PANELS ~~~~~~~~~~

--- Rebuild node details dynamically from current node state
--- @param nodeData table Node data from tree
--- @param node table The actual AST node
--- @return table Array of detail strings
function NodeEditors:RebuildNodeDetails(nodeData, node)
    if not nodeData or not node then
        return { "No node data available" }
    end

    local details = {}
    local EditorUtils = ns.RotationEditorUtils
    local SchemaUtils = ns.SchemaUtils
    local ASTValue = ns.ASTValue
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

    local ntype = node.type
    local nodeType = nodeData.nodeType

    -- Handle proto AST action nodes
    if ntype == ASTCore.NodeType.ACTION then
        -- CRITICAL: Schema is definitive - GetActionType must work, no fallbacks
        local actionType = ASTAction.GetActionType(node)
        local nodeActionType = node.actionType
        NAG:Debug(format("[RebuildNodeDetails] Action node: GetActionType=%s, node.actionType=%s, node.action exists=%s",
            tostring(actionType), tostring(nodeActionType), tostring(node.action ~= nil)))

        -- Telemetry: Log if GetActionType fails
        if not actionType then
            local actionKeys = {}
            if node.action then
                for k in pairs(node.action) do
                    tinsert(actionKeys, tostring(k))
                end
            end
            NAG:Warn("[NodeEditors] GetActionType returned nil - proto message structure invalid (node.actionType=%s; node.action keys=[%s]; node.type=%s)", tostring(nodeActionType), table.concat(actionKeys, ", "), tostring(node.type))
        end

        if actionType then
            local displayName = SchemaUtils and SchemaUtils:SnakeToPascal(actionType) or actionType
            -- Use FormatActionNode to get formatted display (e.g., "OverlayText: SBSS" instead of just "OverlayText()")
            local formattedAction = EditorUtils.FormatActionNode(node)
            tinsert(details, format("|cFFFFFF00Action: %s|r", formattedAction))
            tinsert(details, format("Action Type: %s", actionType))

            -- Get action data and extract spell/item ID if available
            local actionData = ASTAction.GetActionData(node)
            local argId = nil
            if actionData then
                local FieldFormatConverter = ns.FieldFormatConverter
                if FieldFormatConverter then
                    -- Use FieldFormatConverter for consistent extraction
                    if actionData.spell_id then
                        argId = FieldFormatConverter:ExtractActionID(actionData.spell_id)
                    elseif actionData.item_id then
                        argId = FieldFormatConverter:ExtractActionID(actionData.item_id)
                    end
                else
                    -- Fallback to manual extraction if FieldFormatConverter unavailable
                    NAG:Warn("[NodeEditors] FALLBACK TRACKING: Using manual extraction fallback in RebuildNodeDetails() (FieldFormatConverter unavailable)")
                    if actionData.spell_id then
                        local spellIdData = actionData.spell_id
                        argId = spellIdData.spell_id or spellIdData.id or spellIdData
                    elseif actionData.item_id then
                        argId = actionData.item_id
                    end
                end
            end

            local SchemaValidator = NAG:GetModule("SchemaValidator")
            if argId and tonumber(argId) and SchemaValidator and SchemaValidator:IsArgumentIDType(actionType, 1) then
                tinsert(details, format("Spell/Item ID: %s", tostring(argId)))
            end
        else
            tinsert(details, "|cFFFFAA00Empty Action Node|r")
            tinsert(details, "No action type selected")
        end
    -- Handle proto AST value nodes
    elseif ntype == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR then
            local op = (valueType == ASTValue.ValueType.AND) and "AND" or "OR"
            local opColor = op == "AND" and "|cFF00FF00" or "|cFFFFAA00"
            tinsert(details, format("%sLogical Operation: %s|r", opColor, op))
            local valueData = ASTValue.GetValueData(node)
            local vals = valueData and valueData.vals or {}
            tinsert(details, format("Children: %d", #vals))
        elseif valueType == ASTValue.ValueType.NOT then
            tinsert(details, "|cFFFF0000Logical Operation: NOT|r")
        elseif valueType == ASTValue.ValueType.CMP then
            local valueData = ASTValue.GetValueData(node)
            local op = valueData and valueData.op or "OpEq"
            local opSymbol = ASTValue.ComparisonOpToSymbol(op)
            local lhs = valueData and valueData.lhs
            local rhs = valueData and valueData.rhs
            local lhsStr = lhs and EditorUtils.FormatValueNode(lhs) or "?"
            local rhsStr = rhs and EditorUtils.FormatValueNode(rhs) or "?"
            tinsert(details, "|cFF00FFFFComparison|r")
            tinsert(details, format("Operator: %s", opSymbol))
            tinsert(details, format("Left: %s", lhsStr))
            tinsert(details, format("Right: %s", rhsStr))
        elseif valueType == ASTValue.ValueType.MATH then
            local valueData = ASTValue.GetValueData(node)
            local op = valueData and valueData.op or "OpAdd"
            local opSymbol = ASTValue.MathOpToSymbol(op)
            local lhs = valueData and valueData.lhs
            local rhs = valueData and valueData.rhs
            local lhsStr = lhs and EditorUtils.FormatValueNode(lhs) or "?"
            local rhsStr = rhs and EditorUtils.FormatValueNode(rhs) or "?"
            tinsert(details, "|cFFFF8800Math Operation|r")
            tinsert(details, format("Operator: %s", opSymbol))
            tinsert(details, format("Left: %s", lhsStr))
            tinsert(details, format("Right: %s", rhsStr))
        elseif valueType == ASTValue.ValueType.MIN or valueType == ASTValue.ValueType.MAX then
            -- Math function (MIN/MAX) - similar to logical operators, uses vals array
            local funcName = (valueType == ASTValue.ValueType.MIN) and "Min" or "Max"
            local funcColor = "|cFF00AAFF"
            local valueData = ASTValue.GetValueData(node)
            local vals = valueData and valueData.vals or {}
            local argCount = #vals
            tinsert(details, format("%sMath Function: %s|r", funcColor, funcName))
            tinsert(details, format("Arguments: %d", argCount))
        elseif valueType == ASTValue.ValueType.CONST then
            local valueData = ASTValue.GetValueData(node)
            local constVal = valueData and valueData.val or "?"
            tinsert(details, format("Constant: %s", tostring(constVal)))
        else
            -- Function call
            local functionName = valueType or ""
            local displayName = SchemaUtils and SchemaUtils:SnakeToPascal(functionName) or functionName
            tinsert(details, "|cFFFF00FFFunction Call|r")
            tinsert(details, format("Name: %s (%s)", displayName, functionName))
            local valueData = ASTValue.GetValueData(node)
            if valueData then
                local argCount = 0
                for _ in pairs(valueData) do
                    argCount = argCount + 1
                end
                if argCount > 0 then
                    tinsert(details, format("Arguments: %d", argCount))
                end
            end
        end
    else
        -- Fallback: use cached details if available
        if nodeData.details and #nodeData.details > 0 then
            return nodeData.details
        else
            tinsert(details, format("Node Type: %s", tostring(nodeType)))
        end
    end

    return details
end

--- Render node edit panel based on node type
--- @param container table Container widget
--- @param nodeId string Node ID in tree
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function NodeEditors:RenderNodeEditPanel(container, nodeId, clause, clauseIdx, editorState)
    NAG:Info("Rendering node editor (nodeId=%s, clauseIdx=%s)", tostring(nodeId), tostring(clauseIdx))

    -- Check if this is a groups/variables node (not a clause node)
    if nodeId:match("^group_%d+$") then
        self:RenderGroupEditor(container, nodeId, editorState)
        return
    elseif nodeId:match("^group_%d+_action_%d+$") then
        self:RenderGroupActionEditor(container, nodeId, editorState)
        return
    elseif nodeId:match("^variable_%d+$") then
        self:RenderVariableEditor(container, nodeId, editorState)
        return
    elseif nodeId == "groups_root" then
        self:RenderGroupsVariablesRoot(container, editorState)
        return
    end

    -- Get node details
    local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if not editorData then return end

        local nodeData = EditorUtils.FindNodeDetail(editorData, nodeId)

    -- CRITICAL: If nodeId looks like an action node (root_act_X) but wasn't found,
    -- try finding it by semantic position (nodeCounter may have changed after RefreshASTTree)
    if not nodeData and nodeId and nodeId:match("^root_act") then
        local actionNodeSelection = FindActionNodeByPosition(editorData)
        if actionNodeSelection then
            -- Extract nodeId from uniqueValue if needed
            local actionNodeId = actionNodeSelection
            if actionNodeSelection:find("\001") then
                actionNodeId = actionNodeSelection:match("[^\001]+$") or actionNodeSelection
            end
            nodeData = EditorUtils.FindNodeDetail(editorData, actionNodeId)
            if nodeData then
                nodeId = actionNodeId  -- Update nodeId for rest of function
            end
        end
    end

    if not nodeData then
        return
    end

    -- CRITICAL: Get the LIVE node from clause.action, not from nodeData.node
    -- nodeData.node is a reference to the same object, but clause.action is the definitive source
    -- For action nodes, always use clause.action which is the source of truth
    local node = nodeData.node

    -- CRITICAL: Check if node is in proto structure format (e.g., { dot_remaining_time = { spell_id = 980 } })
    -- This happens when nodes are stored in arrays like vals for min/max/and/or
    if node and type(node) == "table" and not node.type then
        -- Proto structure detected - reconstruct wrapper node
        local ASTValue = ns.ASTValue
        for valueTypeKey, valueData in pairs(node) do
            if ASTValue and ASTValue.Create then
                node = ASTValue.Create(valueTypeKey, valueData)
                -- Update nodeData.node so subsequent code uses the reconstructed node
                nodeData.node = node
                break
            end
        end
    end
    if nodeData.nodeType == "action" and clause and clause.action then
        node = clause.action
        -- CRITICAL: Verify proto structure when using clause.action
        local actionType = ASTAction.GetActionType(node)

        -- CRITICAL: If proto structure is missing, try to restore it from nodeData.node
        if not actionType and nodeData.node and nodeData.node.action then
            local nodeDataActionType = ASTAction.GetActionType(nodeData.node)
            if nodeDataActionType then
                NAG:Warn(format("[RenderNodeEditPanel] clause.action.action is empty but nodeData.node.action has %s - restoring proto structure",
                    tostring(nodeDataActionType)))
                -- Restore proto structure from nodeData.node
                if not node.action then
                    node.action = {}
                end
                for actionTypeKey, actionData in pairs(nodeData.node.action) do
                    node.action[actionTypeKey] = actionData
                end
            end
        end
    end
    if node and node.type == ASTCore.NodeType.ACTION and not node.actionType then
        local actionType = ASTAction.GetActionType(node)
        if actionType then
            node.actionType = actionType
        else
            NAG:Warn(format("[RenderNodeEditPanel] ACTION node has no action type for nodeId: %s", tostring(nodeId)))
        end
    end

    -- Check for fallback patterns and log warnings
    if nodeData.hasFallback and nodeData.fallbackReason then
        NAG:Warn("[NodeEditors] Fallback pattern detected (reason=%s)", tostring(nodeData.fallbackReason))
    end

    -- CRITICAL: Rebuild details dynamically from current node state
    -- nodeData.details is built once when tree is created and may be stale after node updates
    local details = self:RebuildNodeDetails(nodeData, node)
    local nodeType = nodeData.nodeType

    -- Wrap ScrollFrame in SimpleGroup - required for TreeGroup content container (raw Frame)
    -- AceConfigDialog pattern: wrap ScrollFrame when container.type ~= "InlineGroup" and ~= "SimpleGroup"
    local scrollWrapper = Libs.AceGUI:Create("SimpleGroup")
    scrollWrapper:SetLayout("Fill")
    scrollWrapper:SetFullWidth(true)
    scrollWrapper:SetFullHeight(true)
    container:AddChild(scrollWrapper)

    -- Create ScrollFrame - AceGUI handles everything automatically
    local scroll = Libs.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scrollWrapper:AddChild(scroll)

    -- Show node details
    -- Layout: InlineGroup uses List layout for vertical stacking of labels
    -- Ensure ScrollFrame's OnWidthSet is called with correct width before adding children
    if container.content and container.content:GetWidth() and container.content:GetWidth() > 0 then
        -- Parent is sized - ensure ScrollFrame's OnWidthSet is called with correct width
        if scroll.frame and scroll.frame:GetWidth() and scroll.frame:GetWidth() > 0 then
            if scroll.content and (not scroll.content.width or scroll.content.width == 0) then
                if scroll.OnWidthSet then
                    scroll:OnWidthSet(scroll.frame:GetWidth())
                end
            end
        else
            NAG:Debug("ScrollFrame not sized yet - Fill layout may not have completed")
        end
    else
        NAG:Debug("Parent container not sized yet - layout may not function correctly")
    end

    local detailsGroup = Libs.AceGUI:Create("InlineGroup")
    detailsGroup:SetTitle("Node Details")
    detailsGroup:SetFullWidth(true)
    detailsGroup:SetLayout("List")  -- Use List for vertical stacking (not Flow)
    scroll:AddChild(detailsGroup)

    for _, line in ipairs(details) do
        local label = Libs.AceGUI:Create("Label")
        label:SetText(line)
        label:SetFullWidth(true)
        detailsGroup:AddChild(label)
    end

    -- Edit controls based on node type
    -- Layout: InlineGroup uses List layout for vertical stacking of editor controls
    local editGroup = Libs.AceGUI:Create("InlineGroup")
    editGroup:SetTitle("Edit Node")
    editGroup:SetFullWidth(true)
    editGroup:SetLayout("List")  -- Use List for vertical stacking (not Flow)
    scroll:AddChild(editGroup)

    -- Get the actual node type from the node itself
    -- Only proto AST nodes are supported
    local actualNodeType = "unknown"
    if node then
        -- Only handle proto AST nodes
        if node.type == ASTCore.NodeType.ACTION then
            actualNodeType = "action"
            -- Ensure actionType is set on the node for compatibility
            if not node.actionType then
                local actionType = ASTAction.GetActionType(node)
                if actionType then
                    node.actionType = actionType
                else
                    NAG:Error("RenderNodeEditPanel: ACTION node has no action type - schema structure is definitive")
                end
            end
        elseif node.type == ASTCore.NodeType.VALUE then
            -- Proto AST value node - determine value type
            local valueType = ASTValue.GetValueType(node)
            if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR or valueType == ASTValue.ValueType.NOT then
                actualNodeType = "logical"
            elseif valueType == ASTValue.ValueType.CMP then
                actualNodeType = "comparison"
            elseif valueType == ASTValue.ValueType.MATH then
                actualNodeType = "math"
            elseif valueType == ASTValue.ValueType.MIN or valueType == ASTValue.ValueType.MAX then
                -- Math functions (MIN/MAX) - treat as function type for editing
                actualNodeType = "function"
            elseif valueType == ASTValue.ValueType.CONST then
                actualNodeType = "constant"
            elseif valueType then
                -- Function call (e.g., "current_health", "aura_is_active")
                actualNodeType = "function"
            else
                NAG:Error("RenderNodeEditPanel: VALUE node has no value type - schema structure is definitive")
                actualNodeType = "value"  -- Will show error in string editor
            end
        else
            -- Not a proto AST node - this is an error
            NAG:Error("RenderNodeEditPanel: Node is not proto AST format (type='%s') - clause format has been eliminated. Node must be proto AST.",
                tostring(node.type))
            actualNodeType = "unknown"
        end
    end

    -- Render appropriate editor based on node type
    -- Note: comparison_side, function_arg, and math_side nodeTypes still have their original node.type
    -- so they route based on actualNodeType, not nodeType
    if actualNodeType == "logical" then
        self:RenderLogicalNodeEditor(editGroup, node, clause, clauseIdx, editorState)
    elseif actualNodeType == "comparison" then
        self:RenderComparisonNodeEditor(editGroup, node, clause, clauseIdx, editorState, nodeId)
    elseif actualNodeType == "function" then
        self:RenderFunctionNodeEditor(editGroup, node, clause, clauseIdx, editorState)
    elseif actualNodeType == "math" then
        self:RenderMathNodeEditor(editGroup, node, clause, clauseIdx, editorState)
    elseif actualNodeType == "constant" then
        -- Check if this constant is actually a function argument - if so, use schema-based editor
        if nodeId and nodeId:match("_arg%d+$") then
            -- This is a function argument - find parent function and use ArgumentRenderer
            local parentId = nodeId:match("^(.+)_arg%d+$")
            if parentId then
                local parentEditorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
                local parentData = EditorUtils.FindNodeDetail(parentEditorData, parentId)
                if parentData and parentData.node then
                    -- Check if parent is a function call value node (proto AST)
                    local parentNode = parentData.node
                    if parentNode.type == ASTCore.NodeType.VALUE then
                        local valueType = ASTValue.GetValueType(parentNode)
                        -- Function call if valueType is not a known operator/constant
                        if valueType and valueType ~= ASTValue.ValueType.CONST and
                           valueType ~= ASTValue.ValueType.AND and valueType ~= ASTValue.ValueType.OR and
                           valueType ~= ASTValue.ValueType.NOT and valueType ~= ASTValue.ValueType.CMP and
                           valueType ~= ASTValue.ValueType.MATH then
                            self:RenderFunctionArgumentEditor(editGroup, node, parentNode, clause, clauseIdx, editorState, nodeId)
                        else
                            self:RenderConstantNodeEditor(editGroup, node, clause, clauseIdx, editorState, nodeId)
                        end
                    else
                        self:RenderConstantNodeEditor(editGroup, node, clause, clauseIdx, editorState, nodeId)
                    end
                else
                    self:RenderConstantNodeEditor(editGroup, node, clause, clauseIdx, editorState, nodeId)
                end
            else
                self:RenderConstantNodeEditor(editGroup, node, clause, clauseIdx, editorState, nodeId)
            end
        else
            self:RenderConstantNodeEditor(editGroup, node, clause, clauseIdx, editorState, nodeId)
        end
    elseif actualNodeType == "action" then
        self:RenderActionNodeEditor(editGroup, node, clause, clauseIdx, editorState)
    elseif nodeId == "root" then
        -- Root node - show summary
        local info = Libs.AceGUI:Create("Label")
        info:SetText("|cFFFFD100Select a node in the tree above to edit it.\n\n" ..
            "Tree shows the structure of your condition and action.\n" ..
            "• Green = AND operators\n" ..
            "• Orange = OR operators\n" ..
            "• Red = NOT operators\n" ..
            "• Cyan = Comparisons\n" ..
            "• Purple = Functions\n" ..
            "• Yellow = Actions|r")
        info:SetFullWidth(true)
        editGroup:AddChild(info)
    else
        -- Generic or unknown - fall back to string editing
        local helpText = Libs.AceGUI:Create("Label")
        helpText:SetText(format("|cFFFFAA00Node type '%s' - showing string editor|r", actualNodeType))
        helpText:SetFullWidth(true)
        editGroup:AddChild(helpText)

        local stringEdit = Libs.AceGUI:Create("MultiLineEditBox")
        stringEdit:SetLabel("Edit as String")
        stringEdit:SetFullWidth(true)
        stringEdit:SetNumLines(6)

        -- Enable syntax highlighting
        local SyntaxHL = ns.RotationEditorSyntaxHighlighting
        if SyntaxHL and stringEdit.editBox then
            SyntaxHL.EnableAPLSyntaxHighlighting(stringEdit.editBox, 4, {
                preserveExistingIndent = true
            })
        end

        -- Determine if condition or action
        local isCondition = nodeId:match("root_cond") or nodeType == "condition"
        local isAction = nodeId:match("root_act") or nodeType == "action"

        if isCondition then
            -- Get condition from action.condition (proto AST structure)
            local ASTSchemaEmitter = ns.ASTSchemaEmitter
            local conditionAST = clause.action and ASTAction and ASTAction.GetCondition(clause.action)
            local conditionText = ""
            if conditionAST and conditionAST.type == ASTCore.NodeType.VALUE and ASTSchemaEmitter then
                conditionText = ASTSchemaEmitter.EmitValueNode(conditionAST) or ""
            end
            stringEdit:SetText(conditionText)

            -- Add APL autocomplete for conditions (Values)
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            if APLAutocomplete then
                local valuesData = SchemaAccessor and SchemaAccessor:GetAutocompleteData("Values")
                if valuesData then
                    APLAutocomplete:AddToEditBox(stringEdit, valuesData, "Values", function(entry, widget)
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
            end

            stringEdit:SetCallback("OnEnterPressed", function(widget, event, text)
                -- Ensure clause has an action node
                if not clause.action then
                    if ASTAction then
                        clause.action = ASTAction.CreateFromFields("cast_spell", {}, nil)
                    end
                end

                if text and text ~= "" then
                    -- Parse condition text to proto AST using ParseClause for consistency
                    local NAGStringParser = NAG:GetModule("NAGStringParser")
                    if NAGStringParser and ASTAction then
                        local clauseResult = NAGStringParser:ParseClause(text, nil, nil)
                        local parsedCondition = nil
                        if clauseResult then
                            -- Extract value from clause result (could be in value or condition field)
                            parsedCondition = clauseResult.value or clauseResult.condition
                        end
                        if parsedCondition then
                            ASTAction.SetCondition(clause.action, parsedCondition)
                        else
                            NAG:Warn("[NodeEditors] Failed to parse condition text")
                        end
                    end
                else
                    -- Clear condition
                    if ASTAction then
                        ASTAction.SetCondition(clause.action, nil)
                    end
                end
                EditorUtils.MarkDirty(editorState)

                local ASTEditor = ns.RotationEditorAST
                if ASTEditor then
                    ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                end
            end)
        elseif isAction then
            -- Synthesize action text from proto AST using ASTSchemaEmitter
            local actionText = ""
            if clause.action then
                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                if ASTSchemaEmitter and clause.action.type == ASTCore.NodeType.ACTION then
                    actionText = ASTSchemaEmitter.EmitActionNode(clause.action) or ""
                end
            end
            stringEdit:SetText(actionText)

            -- Add APL autocomplete for actions (Actions)
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            if APLAutocomplete then
                local actionsData = SchemaAccessor and SchemaAccessor:GetAutocompleteData("Actions")
                if actionsData then
                    APLAutocomplete:AddToEditBox(stringEdit, actionsData, "Actions", function(entry, widget)
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
            end

            stringEdit:SetCallback("OnEnterPressed", function(widget, event, text)
                if text and text ~= "" then
                    -- Parse the action string to update AST structure for proper tree icon display
                    -- Use ParseClause to support conditions, NAG:Hidden(), and notes
                    local NAGStringParser = NAG:GetModule("NAGStringParser")
                    if NAGStringParser then
                        local clauseResult = NAGStringParser:ParseClause(text, nil, nil)
                        if clauseResult and clauseResult.action then
                            -- Set condition on action if present
                            if clauseResult.condition and ASTAction then
                                ASTAction.SetCondition(clauseResult.action, clauseResult.condition)
                            end
                            clause.action = clauseResult.action
                        end
                        -- originalText removed - proto AST structure is source of truth
                    else
                        -- Fallback if parser not available - create minimal action structure
                        if ASTAction then
                            clause.action = ASTAction.CreateFromFields("cast_spell", {}, nil)
                        end
                    end

                    EditorUtils.MarkDirty(editorState)

                    local ASTEditor = ns.RotationEditorAST
                    if ASTEditor then
                        ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                    end
                end
            end)
        end

        editGroup:AddChild(stringEdit)
    end

    -- AceGUI handles all layout automatically
    -- Fill layout will set ScrollFrame size when container has height
    -- ScrollFrame's LayoutFinished will enable scrolling automatically
end

--- Render editor for logical operator nodes (AND/OR/NOT)
--- @param container table Container widget
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function NodeEditors:RenderLogicalNodeEditor(container, node, clause, clauseIdx, editorState)
    if not ASTValue.IsLogicalOp(node) then
        NAG:Error("RenderLogicalNodeEditor: node is not a logical operation")
        return
    end

    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Editing logical operator node|r")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Get current operator and children from proto AST
    local valueType = ASTValue.GetValueType(node)
    local valueData = ASTValue.GetValueData(node)
    local children = {}
    if valueType == ASTValue.ValueType.NOT then
        if valueData and valueData.val then
            children = { valueData.val }
        end
    else
        children = valueData and valueData.vals or {}
    end
    local childCount = #children

    -- Show helpful info about operator transitions
    local transitionInfo = Libs.AceGUI:Create("Label")
    transitionInfo:SetFullWidth(true)

    if valueType == ASTValue.ValueType.NOT and childCount == 1 then
        transitionInfo:SetText("|cFF888888Note: Changing to AND/OR will add a placeholder child to edit|r")
    elseif (valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR) and childCount > 1 then
        transitionInfo:SetText(format("|cFFFF8800Note: Changing to NOT will keep only first child (%d will be lost)|r", childCount - 1))
    else
        transitionInfo:SetText("")
    end
    container:AddChild(transitionInfo)

    -- Operator dropdown
    local opDropdown = Libs.AceGUI:Create("Dropdown")
    opDropdown:SetLabel("Operator Type")
    opDropdown:SetFullWidth(true)
    opDropdown:SetList({
        ["and"] = "AND (all must be true)",
        ["or"] = "OR (at least one true)",
        ["not"] = "NOT (invert condition)"
    })
    -- Convert proto AST value type to string for dropdown
    local currentOp = valueType or "and"
    opDropdown:SetValue(currentOp)
    opDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        -- Use ChangeLogicalOperator which handles proto AST structure
        self:ChangeLogicalOperator(node, value, clause, clauseIdx, editorState)
        NAG:Print("|cFF00FF00Operator changed and saved to condition! Click main Save to commit.|r")
    end)
    container:AddChild(opDropdown)

    -- Note: originalText removed - use ASTSchemaEmitter for text synthesis
    -- Deprecated field access removed
end

--- Sync action AST to canonical storage for group actions
--- Group actions use config.groups[groupIdx].actions[actionIdx] as canonical string storage
--- @param clause table The clause/fakeClause with modified action AST
--- @param clauseIdx number The clause index (or fake index for group actions 999000+)
--- @param editorState table The editor state
function NodeEditors:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
    -- Check if this is a group action
    local isGroupAction = EditorUtils.IsGroupActionIndex(clauseIdx)
    if not isGroupAction then
        -- Regular clauses: Sync rotationString and update main tree
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            -- Sync rotationString from aplProto to workingConfig
            if ns.USE_SYNC_ROTATION_STRING then
                ASTEditor:SyncVisualToText(editorState)
            end

            -- Update main rotation tree to reflect action changes
            if editorState.visualEditor and editorState.visualEditor.treeGroup then
                -- Guard: Don't update if we're in the middle of a refresh cycle
                if not editorState._updatingClauseTree then
                    editorState._updatingClauseTree = true
                    ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                    editorState._updatingClauseTree = nil
                end
            end
        end
        return
    end

    local groupIdx, actionIdx = EditorUtils.DecodeGroupActionIndex(clauseIdx)

    local config = editorState.workingConfig
    if not config or not config.groups or not config.groups[groupIdx] then
        return
    end

    local group = config.groups[groupIdx]
    if not group.actions or not group.actions[actionIdx] then
        return
    end

    -- Get the stored action AST from editorState
    local actionKey = "group_" .. groupIdx .. "_action_" .. actionIdx
    local editorData = editorState.groupActionEditors and editorState.groupActionEditors[actionKey]

    -- Get the action AST - prefer clause.action (current state) over stored
    local actionAST = clause and clause.action or (editorData and editorData.actionAST)

    if not actionAST then
        return
    end

    -- Update editorData.actionAST to keep it in sync
    if editorData then
        editorData.actionAST = actionAST
    end

    -- Serialize the action AST back to text using ASTSchemaEmitter
    local ASTSchemaEmitter = ns.ASTSchemaEmitter
    local serialized = nil

    if ASTSchemaEmitter and actionAST then
        if actionAST.type == ASTCore.NodeType.ACTION then
            serialized = ASTSchemaEmitter.EmitActionNode(actionAST)
        else
            NAG:Error("SyncActionToCanonicalStorage: actionAST is not an ACTION node (type='%s') - schema structure is definitive",
                tostring(actionAST.type))
            return
        end
    end

    if not serialized or serialized == "" then
        NAG:Warn("[NodeEditors] SyncActionToCanonicalStorage: Failed to serialize action AST - ASTSchemaEmitter returned empty")
        return
    end

    -- Update canonical storage (string)
    group.actions[actionIdx] = serialized
    EditorUtils.MarkDirty(editorState)

    -- Also update aplProto.groups (AST) to keep in sync
    local aplProto = editorState.workingConfig and editorState.workingConfig.aplProto
    if aplProto and aplProto.groups and aplProto.groups[groupIdx] then
        local protoGroup = aplProto.groups[groupIdx]
        if protoGroup.actions and protoGroup.actions[actionIdx] then
            -- Update the action AST in proto
            protoGroup.actions[actionIdx].action = actionAST
            NAG:Debug("[ROT-SYNC] SyncActionToCanonicalStorage: Updated aplProto.groups[%d].actions[%d]", groupIdx, actionIdx)
        end
    end
end

--- Rebuild clause condition from proto AST stored in action.condition
--- Also handles variable conditions (fake clauseIdx for variables)
--- @param clause table The clause with condition in action.condition
--- @param clauseIdx number The clause index (or fake index for variables)
--- @param editorState table The editor state
--- @param skipRefresh boolean|nil If true, skip refreshing the AST tree
function NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState, skipRefresh)
    -- CRITICAL: Handle case where clause has no condition (conditionAST is nil)
    -- This is valid - some clauses don't have conditions
    if not clause then
        return
    end

    -- CRITICAL: Condition is part of action, not separate
    -- Ensure clause has an action node
    if not clause.action then
        -- Create empty action if missing (shouldn't happen in proto AST)
        if ASTAction then
            clause.action = ASTAction.CreateFromFields("cast_spell", {}, nil)
        else
            NAG:Warn("[RebuildConditionFromAST] No action node and ASTAction unavailable")
            return
        end
    end

    -- Get condition directly from action (proto AST structure)
    local ASTSchemaEmitter = ns.ASTSchemaEmitter
    local conditionAST = ASTAction and ASTAction.GetCondition(clause.action)

    -- If conditionAST is nil, clear condition on action
    if not conditionAST then
        if ASTAction then
            ASTAction.SetCondition(clause.action, nil)
        end
        return
    end

    -- Verify condition is proto AST
    if conditionAST.type ~= ASTCore.NodeType.VALUE then
        NAG:Warn(format("[RebuildConditionFromAST] Condition is not proto AST VALUE node (type='%s') - legacy format detected",
            tostring(conditionAST.type)))
        return
    end

    -- Serialize condition to text using ASTSchemaEmitter
    local newText = nil

    if ASTSchemaEmitter then
        newText = ASTSchemaEmitter.EmitValueNode(conditionAST)
    end

    if not newText or newText == "" then
        NAG:Warn("[RebuildConditionFromAST] Failed to serialize condition AST")
        return
    end

    -- Note: In proto AST, we don't store originalText on the condition node itself
    -- The condition IS the proto AST node, and text is synthesized on-demand

    -- CRITICAL: Sync to canonical storage for variables
    -- Variables use config.variables[varIdx].value as canonical string (like rotation uses rotationString)
    -- Note: Individual variable edits always update strings (needed for editor display)
    -- Bulk sync operations (via SyncVisualToText) respect USE_SYNC_ROTATION_STRING flag
    local isVariable = EditorUtils.IsVariableIndex(clauseIdx)
    if isVariable then
        local varIdx = EditorUtils.DecodeVariableIndex(clauseIdx)
        local config = editorState.workingConfig
        if config and config.variables and config.variables[varIdx] then
            -- Update canonical storage (string) - always update for individual edits
            config.variables[varIdx].value = newText
            EditorUtils.MarkDirty(editorState)

            -- Also update aplProto.value_variables (AST) to keep in sync
            local aplProto = config.aplProto
            if aplProto and aplProto.value_variables and aplProto.value_variables[varIdx] then
                aplProto.value_variables[varIdx].value = conditionAST
                NAG:Debug("[ROT-SYNC] RebuildConditionFromAST: Updated aplProto.value_variables[%d]", varIdx)
            end
        end
    end

    -- CRITICAL: Refresh the AST tree visualization (unless skipRefresh is true)
    -- skipRefresh prevents infinite recursion when RefreshASTTree calls RebuildConditionFromAST
    if not skipRefresh then
        if isVariable then
            -- For variables, refresh the variable's own AST tree
            local varEditorData = editorState.variableEditors[varIdx]
            if varEditorData and varEditorData.astTreeGroup then
                local ASTEditor = ns.RotationEditorAST
                if ASTEditor then
                    -- CRITICAL: Update fakeClause.action.condition with new proto AST
                    -- The conditionAST we have is the proto AST node from the variable's value
                    -- CRITICAL: Update existing fakeClause instead of creating new one
                    -- This ensures tree selection callbacks remain in sync
                    local fakeClause = varEditorData.fakeClause
                    if fakeClause then
                        -- Ensure action exists
                        if not fakeClause.action then
                            fakeClause.action = ASTAction and ASTAction.CreateFromFields("cast_spell", {}, nil)
                        end
                        -- Update condition in action (proto AST structure)
                        if fakeClause.action and ASTAction then
                            ASTAction.SetCondition(fakeClause.action, conditionAST)
                        end
                    else
                        -- Fallback: create and store if not exists
                        local fakeAction = ASTAction and ASTAction.CreateFromFields("cast_spell", {}, nil)
                        if fakeAction and ASTAction then
                            ASTAction.SetCondition(fakeAction, conditionAST)
                        end
                        fakeClause = {
                            condition = nil,  -- Not used in proto AST
                            action = fakeAction,  -- Contains condition in action.condition
                            priority = varIdx
                        }
                        varEditorData.fakeClause = fakeClause
                    end
                    local tree, nodeDetails, nodeDetailsByUniqueValue = ASTEditor:BuildClauseASTTree(fakeClause, editorState, clauseIdx)
                    varEditorData.nodeDetails = nodeDetails
                    varEditorData.nodeDetailsByUniqueValue = nodeDetailsByUniqueValue
                    -- Condition is part of clause.action.condition in proto AST, not stored separately
                    varEditorData.treeData = tree
                    varEditorData.astTreeGroup:SetTree(tree)
                    if varEditorData.astTreeGroup.RefreshTree then
                        varEditorData.astTreeGroup:RefreshTree()
                    end
                end
            end
        else
            -- For clauses, use existing refresh logic
            local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
            RefreshASTTree(clause, clauseIdx, editorState, true)
            ReselectCurrentNode(editorState, clauseIdx, previousSelection)

            -- CRITICAL: Sync rotationString and update main tree after clause changes
            -- This ensures pending changes detection and main tree updates work correctly
            local ASTEditor = ns.RotationEditorAST
            if ASTEditor then
                -- Sync rotationString from aplProto to workingConfig
                if ns.USE_SYNC_ROTATION_STRING then
                    ASTEditor:SyncVisualToText(editorState)
                end

                -- Update main rotation tree to reflect clause changes
                if editorState.visualEditor and editorState.visualEditor.treeGroup then
                    -- Guard: Don't update if we're in the middle of a refresh cycle
                    if not editorState._updatingClauseTree then
                        editorState._updatingClauseTree = true
                        ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                        editorState._updatingClauseTree = nil
                    end
                end
            end
        end
    end
end

local COMPARISON_LAYOUT_SIDE = "side_by_side"
local COMPARISON_LAYOUT_STACKED = "stacked"

-- ============================ COMPARISON NODE HELPERS ============================

local function GetComparisonLayoutPreference(editorState, clauseIdx, nodeId)
    if not nodeId or not editorState or not editorState.clauseEditors then
        return COMPARISON_LAYOUT_SIDE
    end

    local editorData = editorState.clauseEditors[clauseIdx]
    if not editorData then
        return COMPARISON_LAYOUT_SIDE
    end

    editorData.uiPreferences = editorData.uiPreferences or {}
    editorData.uiPreferences.comparisonLayouts = editorData.uiPreferences.comparisonLayouts or {}

    local storedLayout = editorData.uiPreferences.comparisonLayouts[nodeId]
    if storedLayout == COMPARISON_LAYOUT_STACKED then
        return COMPARISON_LAYOUT_STACKED
    end

    return COMPARISON_LAYOUT_SIDE
end

local function SetComparisonLayoutPreference(editorState, clauseIdx, nodeId, layout)
    if not nodeId or not editorState or not editorState.clauseEditors then
        return
    end

    local editorData = editorState.clauseEditors[clauseIdx]
    if not editorData then
        return
    end

    editorData.uiPreferences = editorData.uiPreferences or {}
    editorData.uiPreferences.comparisonLayouts = editorData.uiPreferences.comparisonLayouts or {}
    editorData.uiPreferences.comparisonLayouts[nodeId] = layout
end

-- ============================ COMPARISON NODE EDITOR ============================

--- Render editor for comparison nodes (e.g., Health() < 30)
--- @param container table Container widget
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
--- @param nodeId string Node identifier for layout preferences
function NodeEditors:RenderComparisonNodeEditor(container, node, clause, clauseIdx, editorState, nodeId)
    if not ASTValue.IsComparison(node) then
        NAG:Error("RenderComparisonNodeEditor: node is not a comparison")
        return
    end

    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Editing comparison node|r")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Get current operator from proto AST
    local valueData = ASTValue.GetValueData(node)
    local currentOp = valueData and valueData.op or ASTValue.ComparisonOperator.LT
    local currentOpSymbol = ASTValue.ComparisonOpToSymbol(currentOp) or "<"

    -- Node type conversion dropdown - use ConvertNodeType which handles proto AST
    local typeDropdown = Libs.AceGUI:Create("Dropdown")
    typeDropdown:SetLabel("Convert Node Type")
    typeDropdown:SetList({
        ["comparison"] = "|cFF00FFFFComparison|r",
        ["constant"] = "Constant (Number/String)",
        ["function"] = "|cFFFF00FFFunction (APLValue)|r",
        ["math"] = "|cFFFF8800Math Operation|r"
    })
    typeDropdown:SetValue("comparison")
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, newType)
        if newType == "comparison" then
            return
        end

        -- Use ConvertNodeType which creates proto AST nodes
        local nodeData = EditorUtils.FindNodeDetail(EditorUtils.GetClauseEditorData(editorState, clauseIdx), nodeId or "")
        if nodeData then
            self:ConvertNodeType(nodeId or "", nodeData, newType, clauseIdx, editorState)
        end
    end)
    -- Operator dropdown
    local opDropdown = Libs.AceGUI:Create("Dropdown")
    opDropdown:SetLabel("Comparison Operator")
    opDropdown:SetList({
        ["<"] = "< (less than)",
        ["<="] = "<= (less than or equal)",
        [">"] = "> (greater than)",
        [">="] = ">= (greater than or equal)",
        ["=="] = "== (equal)",
        ["~="] = "~= (not equal)"
    })
    opDropdown:SetValue(currentOpSymbol)
    opDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        -- Convert symbol to proto operator format
        local protoOp = ASTValue.SymbolToComparisonOp(value)
        if not protoOp then
            NAG:Error("Invalid comparison operator: " .. tostring(value))
            return
        end

        -- Get current lhs/rhs
        local valueData = ASTValue.GetValueData(node)
        local lhs = valueData and valueData.lhs
        local rhs = valueData and valueData.rhs

        -- Create new comparison node with updated operator
        local newCmpNode = ASTValue.CreateCmp(protoOp, lhs, rhs)

        -- Copy structure into existing node to preserve references
        for k, v in pairs(newCmpNode) do
            node[k] = v
        end

        EditorUtils.MarkDirty(editorState)
        NAG:Print("|cFF00FF00Operator changed - remember to save!|r")

        -- Emit comparison node text and trigger refresh
        local emittedText = EmitNodeText(node, "NodeEditors.RenderComparisonNodeEditor")
        if emittedText and editorState then
            local NodeEditors = ns.RotationEditorNodeEditors
            if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
            end
        end
    end)

    -- Layout preference dropdown
    local orientation = GetComparisonLayoutPreference(editorState, clauseIdx, nodeId)

    local layoutDropdown = Libs.AceGUI:Create("Dropdown")
    layoutDropdown:SetLabel("Layout")
    layoutDropdown:SetList({
        [COMPARISON_LAYOUT_SIDE] = "Side by Side",
        [COMPARISON_LAYOUT_STACKED] = "Stacked"
    })
    layoutDropdown:SetValue(orientation)
    local editors = self
    layoutDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        local chosenLayout = value or COMPARISON_LAYOUT_SIDE
        if chosenLayout == orientation then
            return
        end
        SetComparisonLayoutPreference(editorState, clauseIdx, nodeId, chosenLayout)
        if container and container.ReleaseChildren then
            container:ReleaseChildren()
            editors:RenderComparisonNodeEditor(container, node, clause, clauseIdx, editorState, nodeId)
        end
    end)

    local isSideBySide = orientation == COMPARISON_LAYOUT_SIDE

    -- Layout: Using Table layout for side-by-side controls per acegui-layout-guide.mdc
    -- Reference: gotchas.json - acegui_parallel_panels_table_layout
    local controlsGroup = Libs.AceGUI:Create("InlineGroup")
    controlsGroup:SetTitle("Comparison Controls")
    controlsGroup:SetFullWidth(true)

    if isSideBySide then
        -- Use Table layout for side-by-side controls (not Flow with SetRelativeWidth)
        controlsGroup:SetLayout("Table")
        controlsGroup:SetUserData("table", {
            columns = {
                { weight = 1, align = "TOPLEFT" },
                { weight = 1, align = "TOPLEFT" },
                { weight = 1, align = "TOPLEFT" }
            },
            space = 8,
            align = "TOPLEFT"
        })
    else
        controlsGroup:SetLayout("List")
    end

    container:AddChild(controlsGroup)

    -- All dropdowns fill their allocated space in Table layout
    typeDropdown:SetFullWidth(true)
    opDropdown:SetFullWidth(true)
    layoutDropdown:SetFullWidth(true)

    controlsGroup:AddChild(typeDropdown)
    controlsGroup:AddChild(opDropdown)
    controlsGroup:AddChild(layoutDropdown)

    local contentGroup = Libs.AceGUI:Create("SimpleGroup")
    contentGroup:SetFullWidth(true)
    contentGroup:SetAutoAdjustHeight(true)

    if isSideBySide then
        contentGroup:SetLayout("Table")
        contentGroup:SetUserData("table", {
            columns = {
                { weight = 1, align = "TOPLEFT" },
                { weight = 1, align = "TOPLEFT" }
            },
            space = 8,
            align = "TOPLEFT"
        })
    else
        contentGroup:SetLayout("List")
        contentGroup:SetUserData("table", nil)
    end

    container:AddChild(contentGroup)

    local lhsPanel = Libs.AceGUI:Create("InlineGroup")
    lhsPanel:SetTitle("Left Side")
    lhsPanel:SetLayout("List")
    lhsPanel:SetFullWidth(true)
    lhsPanel:SetAutoAdjustHeight(true)

    local rhsPanel = Libs.AceGUI:Create("InlineGroup")
    rhsPanel:SetTitle("Right Side")
    rhsPanel:SetLayout("List")
    rhsPanel:SetFullWidth(true)
    rhsPanel:SetAutoAdjustHeight(true)

    contentGroup:AddChild(lhsPanel)
    contentGroup:AddChild(rhsPanel)

    self:RenderComparisonSide(lhsPanel, node, "lhs", clause, clauseIdx, editorState)
    self:RenderComparisonSide(rhsPanel, node, "rhs", clause, clauseIdx, editorState)
end

--- Render one side of a comparison (lhs or rhs)
--- @param container table Container widget
--- @param node table Comparison AST node
--- @param side string "lhs" or "rhs"
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function NodeEditors:RenderComparisonSide(container, node, side, clause, clauseIdx, editorState)
    -- Get side node from proto AST structure
    local valueData = ASTValue.GetValueData(node)
    if not valueData then
        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000No comparison data|r")
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    local sideNode = (side == "lhs") and valueData.lhs or valueData.rhs
    if not sideNode then
        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000No data for this side|r")
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    -- Determine side type from proto AST
    local sideType = "unknown"
    if ASTValue.IsConst(sideNode) then
        sideType = "constant"
    elseif ASTValue.IsLogicalOp(sideNode) or ASTValue.IsComparison(sideNode) or ASTValue.IsMathOp(sideNode) then
        -- These are handled by their specific editors
        if ASTValue.IsComparison(sideNode) then
            sideType = "comparison"
        elseif ASTValue.IsMathOp(sideNode) then
            sideType = "math"
        end
    elseif sideNode.type == ASTCore.NodeType.VALUE then
        -- Function call or other value type
        sideType = "function"
    end

    local ArgumentRenderer = ns.RotationEditorArgumentRenderer
    -- Type selector: function, constant, math, or comparison
    local typeDropdown = Libs.AceGUI:Create("Dropdown")
    typeDropdown:SetLabel("Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList({
        ["function"] = "|cFFFF00FFFunction (APLValue)|r",
        ["constant"] = "Constant (Number/String)",
        ["math"] = "|cFFFF8800Math Operation|r",
        ["comparison"] = "|cFF00FFFFComparison|r"
    })
    typeDropdown:SetValue(sideType)
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)

        -- Create new proto AST node based on type
        local newSideNode
        if value == "constant" then
            -- Extract current value if available
            local currentValue = 0
            if ASTValue.IsConst(sideNode) then
                currentValue = ASTValue.GetConstValue(sideNode) or 0
            end
            newSideNode = ASTValue.CreateConst(currentValue)
        elseif value == "function" then
            -- Create empty function node (user will select from dropdown)
            newSideNode = ASTValue.CreateConst(0)  -- Placeholder, will be replaced when function selected
        elseif value == "math" then
            -- Extract current value if available
            local currentValue = 0
            if ASTValue.IsConst(sideNode) then
                currentValue = ASTValue.GetConstValue(sideNode) or 0
            end
            newSideNode = ASTValue.CreateMath(ASTValue.MathOperator.OpAdd,
                ASTValue.CreateConst(currentValue),
                ASTValue.CreateConst(0))
        elseif value == "comparison" then
            -- Extract current value if available
            local currentValue = 0
            if ASTValue.IsConst(sideNode) then
                currentValue = ASTValue.GetConstValue(sideNode) or 0
            end
            newSideNode = ASTValue.CreateCmp(ASTValue.ComparisonOperator.LT,
                ASTValue.CreateConst(currentValue),
                ASTValue.CreateConst(0))
        else
            return -- Invalid type
        end

        -- Update parent comparison node's valueData
        local valueData = ASTValue.GetValueData(node)
        if valueData then
            if side == "lhs" then
                valueData.lhs = newSideNode
            else
                valueData.rhs = newSideNode
            end
        end

        EditorUtils.MarkDirty(editorState)

        -- Emit comparison node text and trigger refresh
        local emittedText = EmitNodeText(node, "NodeEditors.RenderSideNodeEditor")
        if emittedText and editorState then
            local NodeEditors = ns.RotationEditorNodeEditors
            if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
            end
        end

        -- Re-render this panel
        ReselectCurrentNode(editorState, clauseIdx, previousSelection)
    end)
    container:AddChild(typeDropdown)

    -- Render appropriate editor based on type
    if sideType == "function" then
        -- Show APLValue dropdown
        local SchemaValidator = NAG:GetModule("SchemaValidator")
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        local valueDropdown = Libs.AceGUI:Create("Dropdown")
        valueDropdown:SetLabel("|cFFFF00FFAPLValue Function|r")
        valueDropdown:SetFullWidth(true)

        -- Get all values
        local allValues
        if SchemaAccessor and SchemaAccessor.GetAllValuesWithMetadata then
            allValues = SchemaAccessor:GetAllValuesWithMetadata()
        else
            allValues = {}
        end
        local valueList = {}
        local valueOrder = {}
        for _, valueData in ipairs(allValues) do
            -- GetAllValuesWithMetadata returns both 'name' and 'valueType' fields
            local key = valueData.name
            if not key then
                local SchemaAccessor = GetSchemaAccessor()
                if SchemaAccessor then
                    SchemaAccessor:Warn("RenderComparisonSide: Missing required field 'name' for value - schema may be incomplete")
                end
            end
            local display = valueData.ui_label or key
            if key then
                tinsert(valueOrder, key)
                valueList[key] = display
            end
        end

        valueDropdown:SetList(valueList, valueOrder)

        -- Get current function name from proto AST structure (same as RenderFunctionNodeEditor)
        local currentFuncName = ""
        if sideNode.type == ASTCore.NodeType.VALUE then
            currentFuncName = ASTValue.GetValueType(sideNode) or ""
        end

        valueDropdown:SetValue(currentFuncName)
        valueDropdown:SetCallback("OnValueChanged", function(widget, event, value)
            local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
            -- Create new proto AST value node directly
            local newSideNode = ASTValue.Create(value, {})

            -- Update parent comparison node's valueData
            local valueData = ASTValue.GetValueData(node)
            if valueData then
                if side == "lhs" then
                    valueData.lhs = newSideNode
                else
                    valueData.rhs = newSideNode
                end
            end

            EditorUtils.MarkDirty(editorState)

            -- CRITICAL: Rebuild condition from AST to preserve full structure
            local NodeEditors = ns.RotationEditorNodeEditors
            if NodeEditors and NodeEditors.RebuildConditionFromAST then
                NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
            end

            -- Emit comparison node text and trigger refresh
            local emittedText = EmitNodeText(node, "NodeEditors.RenderSideNodeEditor")
            if emittedText and editorState then
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                    NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                end
            end

            -- Restore selection after re-render
            ReselectCurrentNode(editorState, clauseIdx, previousSelection)
        end)

        container:AddChild(valueDropdown)

        -- Render arguments for this function
        ArgumentRenderer:RenderComparisonSideArguments(container, sideNode, node, clause, clauseIdx, editorState)
    elseif sideType == "math" then
        -- Render math node editor inline
        local mathHint = Libs.AceGUI:Create("Label")
        mathHint:SetText("|cFF888888Click on the math node in the tree to edit LHS/RHS|r")
        mathHint:SetFullWidth(true)
        container:AddChild(mathHint)

        local opDropdown = Libs.AceGUI:Create("Dropdown")
        opDropdown:SetLabel("Math Operator")
        opDropdown:SetFullWidth(true)
        opDropdown:SetList({
            ["+"] = "+ (Addition)",
            ["-"] = "- (Subtraction)",
            ["*"] = "* (Multiplication)",
            ["/"] = "/ (Division)"
        })
        -- Get current operator from proto AST
        local mathValueData = ASTValue.GetValueData(sideNode)
        local currentOp = mathValueData and mathValueData.op or ASTValue.MathOperator.OpAdd
        local currentOpSymbol = ASTValue.MathOpToSymbol(currentOp) or "+"
        opDropdown:SetValue(currentOpSymbol)
        opDropdown:SetCallback("OnValueChanged", function(widget, event, value)
            local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
            -- Convert symbol to proto operator
            local protoOp = ASTValue.SymbolToMathOp(value)
            if not protoOp then
                NAG:Error("Invalid math operator: " .. tostring(value))
                return
            end

            -- Get current lhs/rhs
            local mathValueData = ASTValue.GetValueData(sideNode)
            local lhs = mathValueData and mathValueData.lhs
            local rhs = mathValueData and mathValueData.rhs

            -- Create new math node with updated operator
            local newMathNode = ASTValue.CreateMath(protoOp, lhs, rhs)

            -- Copy structure into existing node to preserve references
            for k, v in pairs(newMathNode) do
                sideNode[k] = v
            end

            -- Update parent comparison node's valueData
            local valueData = ASTValue.GetValueData(node)
            if valueData then
                if side == "lhs" then
                    valueData.lhs = sideNode
                else
                    valueData.rhs = sideNode
                end
            end

            EditorUtils.MarkDirty(editorState)
            local emittedText = EmitNodeText(node, "NodeEditors.RenderSideNodeEditor")
            if emittedText and editorState then
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                    NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                end
            end
            ReselectCurrentNode(editorState, clauseIdx, previousSelection)
        end)
        container:AddChild(opDropdown)
    elseif sideType == "comparison" then
        -- Render comparison node editor inline
        local compHint = Libs.AceGUI:Create("Label")
        compHint:SetText("|cFF888888Click on the comparison node in the tree to edit LHS/RHS|r")
        compHint:SetFullWidth(true)
        container:AddChild(compHint)

        local opDropdown = Libs.AceGUI:Create("Dropdown")
        opDropdown:SetLabel("Comparison Operator")
        opDropdown:SetFullWidth(true)
        opDropdown:SetList({
            ["<"] = "< (less than)",
            ["<="] = "<= (less than or equal)",
            [">"] = "> (greater than)",
            [">="] = ">= (greater than or equal)",
            ["=="] = "== (equal)",
            ["~="] = "~= (not equal)"
        })
        -- Get current operator from proto AST
        local cmpValueData = ASTValue.GetValueData(sideNode)
        local currentOp = cmpValueData and cmpValueData.op or ASTValue.ComparisonOperator.LT
        local currentOpSymbol = ASTValue.ComparisonOpToSymbol(currentOp) or "<"
        opDropdown:SetValue(currentOpSymbol)
        opDropdown:SetCallback("OnValueChanged", function(widget, event, value)
            local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
            -- Convert symbol to proto operator (handle ~= as !=)
            local normalizedValue = (value == "~=") and "!=" or value
            local protoOp = ASTValue.SymbolToComparisonOp(normalizedValue)
            if not protoOp or protoOp == "OpUnknown" then
                NAG:Error("Invalid comparison operator: " .. tostring(value))
                return
            end

            -- Get current lhs/rhs
            local cmpValueData = ASTValue.GetValueData(sideNode)
            local lhs = cmpValueData and cmpValueData.lhs
            local rhs = cmpValueData and cmpValueData.rhs

            -- Create new comparison node with updated operator
            local newCmpNode = ASTValue.CreateCmp(protoOp, lhs, rhs)

            -- Copy structure into existing node to preserve references
            for k, v in pairs(newCmpNode) do
                sideNode[k] = v
            end

            -- Update parent comparison node's valueData
            local valueData = ASTValue.GetValueData(node)
            if valueData then
                if side == "lhs" then
                    valueData.lhs = sideNode
                else
                    valueData.rhs = sideNode
                end
            end

            EditorUtils.MarkDirty(editorState)
            local emittedText = EmitNodeText(node, "NodeEditors.RenderSideNodeEditor")
            if emittedText and editorState then
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                    NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                end
            end
            ReselectCurrentNode(editorState, clauseIdx, previousSelection)
        end)
        container:AddChild(opDropdown)
    else
        -- Show constant value editor
        local constEdit = Libs.AceGUI:Create("EditBox")
        constEdit:SetLabel("Value")
        constEdit:SetFullWidth(true)
        -- Get current value from proto AST
        local currentValue = ""
        if ASTValue.IsConst(sideNode) then
            currentValue = ASTValue.GetConstValue(sideNode) or ""
        end
        constEdit:SetText(tostring(currentValue))
        constEdit:SetCallback("OnEnterPressed", function(widget, event, text)
            local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
            -- Update proto AST constant node value
            if ASTValue.IsConst(sideNode) then
                local valueData = ASTValue.GetValueData(sideNode)
                if valueData then
                    -- Create const node instead of direct string assignment
                    local newValue = tonumber(text) or text or ""
                    valueData.val = ASTValue.CreateConst(newValue)
                else
                    -- Recreate constant node with new value
                    local newValue = tonumber(text) or text or ""
                    local newConst = ASTValue.CreateConst(newValue)
                    -- Replace sideNode in parent comparison node
                    local valueData = ASTValue.GetValueData(node)
                    if valueData then
                        if side == "lhs" then
                            valueData.lhs = newConst
                        else
                            valueData.rhs = newConst
                        end
                    end
                end
            else
                -- Not a constant node - create new constant
                local newValue = tonumber(text) or text or ""
                local newConst = ASTValue.CreateConst(newValue)
                -- Replace sideNode in parent comparison node
                local valueData = ASTValue.GetValueData(node)
                if valueData then
                    if side == "lhs" then
                        valueData.lhs = newConst
                    else
                        valueData.rhs = newConst
                    end
                end
            end

            EditorUtils.MarkDirty(editorState)

            -- Emit comparison node text and trigger refresh
            local emittedText = EmitNodeText(node, "NodeEditors.RenderComparisonNodeEditor")
            if emittedText and editorState then
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                    NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                end
            end

            -- Refresh view of this panel
            ReselectCurrentNode(editorState, clauseIdx, previousSelection)

            NAG:Print("|cFF00FF00Value updated - remember to save!|r")
        end)
        container:AddChild(constEdit)
    end
end

--- Render editor for function argument nodes (schema-based)
--- @param container table Container widget
--- @param argNode table AST node (constant type, the argument)
--- @param functionNode table AST node (function type, the parent)
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
--- @param nodeId string The node ID for this argument node (e.g., "root_cond_1_lhs_3_arg1")
function NodeEditors:RenderFunctionArgumentEditor(container, argNode, functionNode, clause, clauseIdx, editorState, nodeId)
    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Editing function argument|r")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Extract argument index from nodeId (e.g., "root_cond_1_lhs_3_arg1" -> 1)
    local argIndex = tonumber(nodeId:match("_arg(%d+)$"))
    if not argIndex then
        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Could not determine argument index|r")
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    -- Use ArgumentRenderer to render this specific argument field
    -- We need to get the schema for the function to find the field definition
    local ArgumentRenderer = ns.RotationEditorArgumentRenderer

    -- Get schema for the function first (needed for argument accessors)
    local SchemaValidator = NAG:GetModule("SchemaValidator")
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    -- Find the function schema using proto AST structure
    local funcName = nil
    if functionNode.type == ASTCore.NodeType.VALUE then
        funcName = ASTValue.GetValueType(functionNode)
    end
    if not funcName then
        funcName = ""
    end

    -- GetValueType already returns snake_case, so use it directly
    local snakeName = funcName

    local schema
    if snakeName:match("^[a-z][a-z0-9_]*$") and SchemaAccessor then
        local messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(snakeName, "APLAction")
        if not messageSchema then
            messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(snakeName, "APLValue")
        end
        if messageSchema then
            schema = {
                fields = messageSchema.fields or {},
                field_order = messageSchema.field_order or {},
                label = (messageSchema._metadata and messageSchema._metadata.ui_label) or nil
            }
        end
    end

    -- Create argument accessors using factory function (replaces duplicate getArgValue/setArgValue)
    local getArgValue, setArgValue, getArgNode, setArgNode, rebuildNode =
        ArgumentRenderer:CreateArgumentAccessors(functionNode, "value", schema, clause, clauseIdx, editorState)

    -- Schema is required - fail fast if missing
    if not schema or not schema.fields or not schema.field_order then
        NAG:Error(format("[NodeEditors] Schema required but missing for function argument editor (argIndex=%d; nodeId=%s)", argIndex, tostring(nodeId)))
        return
    end

    -- Find the field definition for this argument index
    -- Note: field_order might not match argument positions - use the 'id' field instead
    -- The 'id' field in schema.fields indicates the actual argument position
    local fields = schema.fields or {}
    local fieldName = nil
    local fieldDef = nil

    -- Search for field with matching id (argument position)
    for name, def in pairs(fields) do
        if def.id == argIndex then
            fieldName = name
            fieldDef = def
            break
        end
    end

    -- Field definition is required - fail fast if missing
    if not fieldName or not fieldDef then
        NAG:Error(format("[NodeEditors] Field definition required but missing for argument (argIndex=%d; schema has %d fields; nodeId=%s)",
            argIndex, schema.field_order and #schema.field_order or 0, tostring(nodeId)))
        return
    end

    -- Render the field using ArgumentRenderer
    ArgumentRenderer:RenderArgumentField(container, functionNode, clause, clauseIdx, editorState, fieldName, fieldDef,
        argIndex, setArgValue, getArgValue, nil, nil, 0)
end

--- Render editor for constant nodes
--- @param container table Container widget
--- @param node table AST node (constant type)
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
--- @param nodeId string The node ID for this constant node
function NodeEditors:RenderConstantNodeEditor(container, node, clause, clauseIdx, editorState, nodeId)
    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Editing constant value|r")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Node type conversion dropdown
    local typeDropdown = Libs.AceGUI:Create("Dropdown")
    typeDropdown:SetLabel("Convert Node Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList({
        ["constant"] = "Constant (Number/String)",
        ["function"] = "|cFFFF00FFFunction (APLValue)|r",
        ["math"] = "|cFFFF8800Math Operation|r",
        ["comparison"] = "|cFF00FFFFComparison|r"
    })
    typeDropdown:SetValue("constant")
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, newType)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
        if newType == "constant" then
            -- Already a constant, do nothing
            return
        end

        -- Extract current value from proto AST
        local currentValue = 0
        if ASTValue.IsConst(node) then
            currentValue = ASTValue.GetConstValue(node) or 0
        elseif node.type == "constant" then
            -- Legacy format detected - should not happen in production code
            NAG:Error(format("[NodeEditors] Legacy format detected: node.type == 'constant'. Node should be proto AST with type == ASTCore.NodeType.VALUE. Context: RenderValueTypeEditor"))
            return
        else
            -- Try to extract from other formats
            local valueData = ASTValue.GetValueData(node)
            if valueData and valueData.val then
                currentValue = tonumber(valueData.val) or 0
            end
        end

        -- Create new proto AST node based on target type
        local newNode
        if newType == "function" then
            -- Create a function node with first available function as placeholder
            -- User will select the actual function from dropdown/APLAutocomplete
            -- APLValue uses oneof - we need to set a specific oneof field, can't be "empty"
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            local placeholderFunctionName = nil

            if SchemaAccessor and SchemaAccessor.GetAllValuesWithMetadata then
                local allValues = SchemaAccessor:GetAllValuesWithMetadata()
                if allValues and #allValues > 0 and allValues[1] and allValues[1].name then
                    placeholderFunctionName = allValues[1].name
                end
            end

            if placeholderFunctionName then
                -- Create function node with placeholder oneof field set
                -- This creates: node.value[placeholderFunctionName] = {}
                newNode = ASTValue.Create(placeholderFunctionName, {})
            else
                -- APLValue functions are required - fail fast if missing
                NAG:Error("RenderConstantNodeEditor: No APLValue functions available - required for value node creation")
                return
            end
        elseif newType == "math" then
            -- Create math with constant operands
            local lhsConst = ASTValue.CreateConst(currentValue)
            local rhsConst = ASTValue.CreateConst(0)
            newNode = ASTValue.CreateMath(ASTValue.MathOperator.ADD, lhsConst, rhsConst)
        elseif newType == "comparison" then
            -- Create comparison with constant operands
            local lhsConst = ASTValue.CreateConst(currentValue)
            local rhsConst = ASTValue.CreateConst(0)
            newNode = ASTValue.CreateCmp(ASTValue.ComparisonOperator.LT, lhsConst, rhsConst)
        else
            return
        end

        -- Replace node structure while preserving reference (for parent structure)
        ReplaceNodeStructure(node, newNode)

        EditorUtils.MarkDirty(editorState)

        -- Rebuild parent structures
        if nodeId then
            if nodeId:match("_arg%d+$") then
                local parentId = nodeId:match("^(.+)_arg%d+$")
                if parentId then
                    local parentEditorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
                    local parentData = EditorUtils.FindNodeDetail(parentEditorData, parentId)
                    if parentData and parentData.node then
                        EmitNodeText(parentData.node, "NodeEditors.RenderValueTypeEditor")
                    end
                end
            elseif nodeId:match("_lhs$") or nodeId:match("_rhs$") then
                local parentId = nodeId:match("^(.+)_(lhs|rhs)$")
                if parentId then
                    local parentEditorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
                    local parentData = EditorUtils.FindNodeDetail(parentEditorData, parentId)
                    if parentData and parentData.node and ASTValue.IsComparison(parentData.node) then
                        local emittedText = EmitNodeText(parentData.node, "NodeEditors.RenderValueTypeEditor")
                        if emittedText and editorState then
                            local NodeEditors = ns.RotationEditorNodeEditors
                            if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                                NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                            end
                        end
                    end
                end
            end
        end

        -- CRITICAL: Rebuild condition text from AST BEFORE refreshing tree
        -- This ensures the stored AST changes are reflected in originalText
        local NodeEditors = ns.RotationEditorNodeEditors
        if NodeEditors and NodeEditors.RebuildConditionFromAST then
            NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
        end

        -- Re-select the node to show new editor
        ReselectCurrentNode(editorState, clauseIdx, previousSelection)
    end)
    container:AddChild(typeDropdown)

    -- Determine the current value from proto AST
    local currentValue = ""
    if ASTValue.IsConst(node) then
        currentValue = ASTValue.GetConstValue(node) or ""
    end
    local valueType = type(currentValue)

    -- Value editor
    local valueEdit = Libs.AceGUI:Create("EditBox")
    valueEdit:SetLabel("Value")
    valueEdit:SetFullWidth(true)
    valueEdit:SetText(tostring(currentValue))

    valueEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
        -- Update proto AST constant node value
        if ASTValue.IsConst(node) then
            local valueData = ASTValue.GetValueData(node)
            if valueData then
                -- Create const node instead of direct string assignment
                local newValue = tonumber(text) or text or ""
                valueData.val = ASTValue.CreateConst(newValue)
            else
                -- Recreate constant node with new value
                local newValue = tonumber(text) or text or ""
                local newConst = ASTValue.CreateConst(newValue)
                -- Replace node in parent structure if nodeId is provided
                if nodeId then
                    -- The parent structure will be updated via RebuildConditionFromAST
                    -- For now, just update the node reference
                    for k, v in pairs(newConst) do
                        node[k] = v
                    end
                end
            end
        else
            -- Not a constant node - this should not happen, but create constant anyway
            NAG:Error(format("[NodeEditors] RenderConstantNodeEditor: node is not a constant proto AST node. Type: %s", tostring(node.type)))
            local newValue = tonumber(text) or text or ""
            local newConst = ASTValue.CreateConst(newValue)
            -- Replace node in parent structure if nodeId is provided
            if nodeId then
                for k, v in pairs(newConst) do
                    node[k] = v
                end
            end
        end

        -- Rebuild parent structures using the nodeId path
        if nodeId then
            -- Check if this is a function argument
            if nodeId:match("_arg%d+$") then
                -- This is a function argument - rebuild the function node
                local parentId = nodeId:match("^(.+)_arg%d+$")
                if parentId then
                    local parentEditorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
                    local parentData = EditorUtils.FindNodeDetail(parentEditorData, parentId)
                    if parentData and parentData.node then
                        EmitNodeText(parentData.node, "NodeEditors.RenderValueTypeEditor")
                    end
                end
            elseif nodeId:match("_lhs$") or nodeId:match("_rhs$") then
                -- This is a comparison side - rebuild the comparison
                local parentId = nodeId:match("^(.+)_(lhs|rhs)$")
                if parentId then
                    local parentEditorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
                    local parentData = EditorUtils.FindNodeDetail(parentEditorData, parentId)
                    if parentData and parentData.node and ASTValue.IsComparison(parentData.node) then
                        local emittedText = EmitNodeText(parentData.node, "NodeEditors.RenderValueTypeEditor")
                        if emittedText and editorState then
                            local NodeEditors = ns.RotationEditorNodeEditors
                            if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                                NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
                            end
                        end
                    end
                end
            end
        end

        EditorUtils.MarkDirty(editorState)

        -- Refresh the AST tree to show updated values
        ReselectCurrentNode(editorState, clauseIdx, previousSelection)

        NAG:Print("|cFF00FF00Constant value updated - remember to save!|r")
    end)
    container:AddChild(valueEdit)

    -- Show value type hint
    local typeHint = Libs.AceGUI:Create("Label")
    typeHint:SetText(format("|cFF888888Value type: %s|r", valueType))
    typeHint:SetFullWidth(true)
    container:AddChild(typeHint)
end

--- Render editor for math nodes
--- @param container table Container widget
--- @param node table AST node (math type)
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function NodeEditors:RenderMathNodeEditor(container, node, clause, clauseIdx, editorState)
    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Editing math operation|r")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Node type conversion dropdown
    local typeDropdown = Libs.AceGUI:Create("Dropdown")
    typeDropdown:SetLabel("Convert Node Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList({
        ["math"] = "|cFFFF8800Math Operation|r",
        ["constant"] = "Constant (Number/String)",
        ["function"] = "|cFFFF00FFFunction (APLValue)|r",
        ["comparison"] = "|cFF00FFFFComparison|r"
    })
    typeDropdown:SetValue("math")
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, newType)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
        if newType == "math" then
            return
        end

        -- Extract current value from math node
        local currentValue = 0
        local valueData = ASTValue.GetValueData(node)
        if valueData then
            -- Try to get value from lhs (preferred) or rhs
            if valueData.lhs and ASTValue.IsConst(valueData.lhs) then
                currentValue = tonumber(ASTValue.GetConstValue(valueData.lhs)) or 0
            elseif valueData.rhs and ASTValue.IsConst(valueData.rhs) then
                currentValue = tonumber(ASTValue.GetConstValue(valueData.rhs)) or 0
            end
        end

        -- Create new proto AST node based on target type
        local newNode
        if newType == "constant" then
            -- Create constant with extracted value
            newNode = ASTValue.CreateConst(currentValue)
            NAG:Info("[NodeEditors] Coerced math node to constant (value=%s)", tostring(currentValue))
        elseif newType == "function" then
            -- Empty function - create constant placeholder (will be converted when user selects function)
            newNode = ASTValue.CreateConst(0)
        elseif newType == "comparison" then
            -- Create comparison, preserving lhs/rhs from math if available
            local lhs = valueData and valueData.lhs or ASTValue.CreateConst(currentValue)
            local rhs = valueData and valueData.rhs or ASTValue.CreateConst(0)
            newNode = ASTValue.CreateCmp(ASTValue.ComparisonOperator.LT, lhs, rhs)
        else
            return
        end

        -- Replace node structure while preserving reference (for parent structure)
        ReplaceNodeStructure(node, newNode)

        EditorUtils.MarkDirty(editorState)

        -- CRITICAL: Rebuild condition text from AST BEFORE refreshing tree
        -- This ensures the stored AST changes are reflected in originalText
        local NodeEditors = ns.RotationEditorNodeEditors
        if NodeEditors and NodeEditors.RebuildConditionFromAST then
            NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
        end

        -- Refresh tree and re-select (will use stored AST with modifications)
        ReselectCurrentNode(editorState, clauseIdx, previousSelection)
    end)
    container:AddChild(typeDropdown)

    -- Operator dropdown
    local opDropdown = Libs.AceGUI:Create("Dropdown")
    opDropdown:SetLabel("Math Operator")
    opDropdown:SetFullWidth(true)
    opDropdown:SetList({
        ["+"] = "+ (Addition)",
        ["-"] = "- (Subtraction)",
        ["*"] = "* (Multiplication)",
        ["/"] = "/ (Division)"
    })
    -- Get current operator from proto AST
    local valueData = ASTValue.GetValueData(node)
    local currentOp = valueData and valueData.op or ASTValue.MathOperator.ADD
    local currentOpSymbol = ASTValue.MathOpToSymbol(currentOp) or "+"
    opDropdown:SetValue(currentOpSymbol)
    opDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
        -- Convert symbol to proto operator
        local protoOp = ASTValue.SymbolToMathOp(value)
        if not protoOp then
            NAG:Error("Invalid math operator: " .. tostring(value))
            return
        end

        -- Get current lhs/rhs
        local valueData = ASTValue.GetValueData(node)
        local lhs = valueData and valueData.lhs
        local rhs = valueData and valueData.rhs

        -- Create new math node with updated operator
        local newMathNode = ASTValue.CreateMath(protoOp, lhs, rhs)

        -- Copy structure into existing node to preserve references
        for k, v in pairs(newMathNode) do
            node[k] = v
        end

        EditorUtils.MarkDirty(editorState)

        -- Rebuild parent structures if this math node is nested
        -- Note: Math nodes can be nested in comparisons or other math nodes
        -- The tree refresh will update the display, and parent structures will be rebuilt
        -- when their children are accessed

        -- Refresh the AST tree to show updated operator
        ReselectCurrentNode(editorState, clauseIdx, previousSelection)

        NAG:Print("|cFF00FF00Math operator updated - remember to save!|r")
    end)
    container:AddChild(opDropdown)

    -- Left side display
    -- Layout: InlineGroup uses List layout for vertical stacking of labels
    local lhsGroup = Libs.AceGUI:Create("InlineGroup")
    lhsGroup:SetTitle("Left Side (LHS)")
    lhsGroup:SetFullWidth(true)
    lhsGroup:SetLayout("List")  -- Use List for vertical stacking (not Flow)
    container:AddChild(lhsGroup)

    local lhsInfo = Libs.AceGUI:Create("Label")
    local lhsStr = EditorUtils.FormatValueNode(node.lhs)
    lhsInfo:SetText(format("|cFF888888LHS: %s|r", lhsStr))
    lhsInfo:SetFullWidth(true)
    lhsGroup:AddChild(lhsInfo)

    local lhsHint = Libs.AceGUI:Create("Label")
    lhsHint:SetText("|cFF888888Click on the tree node above to edit the left side|r")
    lhsHint:SetFullWidth(true)
    lhsGroup:AddChild(lhsHint)

    -- Right side display
    -- Layout: InlineGroup uses List layout for vertical stacking of labels
    local rhsGroup = Libs.AceGUI:Create("InlineGroup")
    rhsGroup:SetTitle("Right Side (RHS)")
    rhsGroup:SetFullWidth(true)
    rhsGroup:SetLayout("List")  -- Use List for vertical stacking (not Flow)
    container:AddChild(rhsGroup)

    local rhsInfo = Libs.AceGUI:Create("Label")
    local rhsStr = EditorUtils.FormatValueNode(node.rhs)
    rhsInfo:SetText(format("|cFF888888RHS: %s|r", rhsStr))
    rhsInfo:SetFullWidth(true)
    rhsGroup:AddChild(rhsInfo)

    local rhsHint = Libs.AceGUI:Create("Label")
    rhsHint:SetText("|cFF888888Click on the tree node above to edit the right side|r")
    rhsHint:SetFullWidth(true)
    rhsGroup:AddChild(rhsHint)
end

--- Render editor for function nodes
--- @param container table Container widget
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function NodeEditors:RenderFunctionNodeEditor(container, node, clause, clauseIdx, editorState)
    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Editing function node|r")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Node type conversion dropdown
    local typeDropdown = Libs.AceGUI:Create("Dropdown")
    typeDropdown:SetLabel("Convert Node Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList({
        ["function"] = "|cFFFF00FFFunction (APLValue)|r",
        ["constant"] = "Constant (Number/String)",
        ["math"] = "|cFFFF8800Math Operation|r",
        ["comparison"] = "|cFF00FFFFComparison|r"
    })
    typeDropdown:SetValue("function")
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, newType)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)
        if newType == "function" then
            return
        end

        -- Extract current value if available
        local currentValue = 0
        if ASTValue.IsConst(node) then
            currentValue = tonumber(ASTValue.GetConstValue(node)) or 0
        end

        -- Create new proto AST node based on target type
        local newNode
        if newType == "constant" then
            -- Create constant with default value
            newNode = ASTValue.CreateConst(0)
        elseif newType == "math" then
            -- Create math with constant operands
            local lhsConst = ASTValue.CreateConst(0)
            local rhsConst = ASTValue.CreateConst(0)
            newNode = ASTValue.CreateMath(ASTValue.MathOperator.ADD, lhsConst, rhsConst)
        elseif newType == "comparison" then
            -- Create comparison with constant operands
            local lhsConst = ASTValue.CreateConst(0)
            local rhsConst = ASTValue.CreateConst(0)
            newNode = ASTValue.CreateCmp(ASTValue.ComparisonOperator.LT, lhsConst, rhsConst)
        else
            return
        end

        -- Replace node structure while preserving reference (for parent structure)
        ReplaceNodeStructure(node, newNode)

        EditorUtils.MarkDirty(editorState)

        -- CRITICAL: Rebuild condition text from AST BEFORE refreshing tree
        -- This ensures the stored AST changes are reflected in originalText
        local NodeEditors = ns.RotationEditorNodeEditors
        if NodeEditors and NodeEditors.RebuildConditionFromAST then
            NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
        end

        -- Refresh tree and re-select (will use stored AST with modifications)
        ReselectCurrentNode(editorState, clauseIdx, previousSelection)
    end)
    container:AddChild(typeDropdown)

    local SchemaValidator = NAG:GetModule("SchemaValidator")
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    -- APLValue selection dropdown
    local valueDropdown = Libs.AceGUI:Create("Dropdown")
    valueDropdown:SetLabel("APLValue Function")
    valueDropdown:SetFullWidth(true)

    -- Get all values with metadata
    local allValues
    if SchemaAccessor and SchemaAccessor.GetAllValuesWithMetadata then
        allValues = SchemaAccessor:GetAllValuesWithMetadata()
    else
        NAG:Error("RenderFunctionNodeEditor: SchemaAccessor not available or GetAllValuesWithMetadata not found")
        allValues = {}
    end

    if not allValues or #allValues == 0 then
        NAG:Error("RenderFunctionNodeEditor: GetAllValuesWithMetadata returned empty - schema may not be loaded")
        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000ERROR: No APLValue metadata available. Schema may not be loaded.|r")
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    local valueList = {}
    local valueOrder = {}
    for _, valueData in ipairs(allValues) do
        -- GetAllValuesWithMetadata returns both 'name' and 'valueType' fields
        local name = valueData.name
        if not name then
            NAG:Warn("RenderFunctionNodeEditor: Missing required field 'name' for value - schema may be incomplete")
        else
            local display = valueData.ui_label or name
            tinsert(valueOrder, name)
            valueList[name] = display
        end
    end

    if #valueOrder == 0 then
        NAG:Error("RenderFunctionNodeEditor: No valid values found in GetAllValuesWithMetadata results")
        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000ERROR: No valid APLValue functions found in schema.|r")
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    valueDropdown:SetList(valueList, valueOrder)

    -- Get current function name from proto AST structure
    local currentFuncName = ""
    if node.type == ASTCore.NodeType.VALUE then
        currentFuncName = ASTValue.GetValueType(node) or ""
    end

    -- Log warning if function name is empty
    if not currentFuncName or currentFuncName == "" then
        NAG:Warn("[Function Editor] Empty function name detected - please select a valid APLValue")
    end

    valueDropdown:SetValue(currentFuncName)

    valueDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)

        -- Extract old value data and schema before creating new node
        local oldValueData = nil
        local oldValueSchema = nil
        local oldValueType = ASTValue.GetValueType(node)
        if oldValueType and node.value and node.value[oldValueType] then
            oldValueData = node.value[oldValueType]
            -- Get old value schema for field comparison
            if SchemaAccessor then
                local oldMetadata = SchemaAccessor:GetMetadataByIdentifier(oldValueType, nil)
                if oldMetadata and oldMetadata.messageSchema then
                    oldValueSchema = oldMetadata.messageSchema
                end
            end
        end

        -- Get new value schema for field comparison
        local newValueSchema = nil
        if SchemaAccessor then
            local newMetadata = SchemaAccessor:GetMetadataByIdentifier(value, nil)
            if newMetadata and newMetadata.messageSchema then
                newValueSchema = newMetadata.messageSchema
            end
        end

        -- Preserve compatible fields from old value to new value
        local preservedFields = {}
        if oldValueData and oldValueSchema and newValueSchema then
            preservedFields = PreserveCompatibleFields(oldValueData, oldValueSchema, newValueSchema)
            if next(preservedFields) then
                local preservedCount = 0
                for _ in pairs(preservedFields) do
                    preservedCount = preservedCount + 1
                end
                NAG:Info("[NodeEditors] Preserved %d compatible field(s) when changing value type from '%s' to '%s'",
                    preservedCount, oldValueType or "unknown", value)
            end
        end

        -- Create new proto AST value node with preserved compatible fields
        local newNode = ASTValue.Create(value, preservedFields)

        -- Replace node structure while preserving reference (for parent structure)
        ReplaceNodeStructure(node, newNode)

        EditorUtils.MarkDirty(editorState)
        if next(preservedFields) then
            NAG:Print("|cFF00FF00Function changed - compatible arguments preserved. Remember to save!|r")
        else
            NAG:Print("|cFF00FF00Function changed - arguments reset. Remember to save!|r")
        end

        -- CRITICAL: Rebuild condition from AST to preserve full structure
        -- DO NOT directly modify clause.condition.originalText - it loses other parts!
        local NodeEditors = ns.RotationEditorNodeEditors
        if NodeEditors and NodeEditors.RebuildConditionFromAST then
            NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
        end

        -- Re-render this panel to show argument fields
        ReselectCurrentNode(editorState, clauseIdx, previousSelection)
    end)
    container:AddChild(valueDropdown)

    -- Render argument fields based on schema
    local ArgumentRenderer = ns.RotationEditorArgumentRenderer
    ArgumentRenderer:RenderArgumentFields(container, node, clause, clauseIdx, editorState, "value")
end

--- Render editor for action nodes (Cast, Channel, etc.)
--- @param container table Container widget
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function NodeEditors:RenderActionNodeEditor(container, node, clause, clauseIdx, editorState)
    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Editing action node|r")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Access metadata providers
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")

    local allActions
    if SchemaAccessor and SchemaAccessor.GetAllActionsWithMetadata then
        allActions = SchemaAccessor:GetAllActionsWithMetadata()
    else
        allActions = {}
    end

    -- APLAction selection dropdown
    local actionDropdown = Libs.AceGUI:Create("Dropdown")
    actionDropdown:SetLabel("APLAction Type")
    actionDropdown:SetFullWidth(true)

    local actionList = {}
    local actionOrder = {}
    for _, actionData in ipairs(allActions) do
        -- GetAllActionsWithMetadata returns both 'name' and 'actionType' fields
        local key = actionData.name
        if not key then
            local SchemaAccessor = GetSchemaAccessor()
            if SchemaAccessor then
                SchemaAccessor:Warn("RenderActionNodeEditor: Missing required field 'name' for action - schema may be incomplete")
            end
            key = actionData.protoName or actionData.nagName
        end
        if key then
            local displayName = EditorUtils.ResolveActionDisplayName(actionData)
            actionList[key] = displayName
            tinsert(actionOrder, key)
        end
    end

    sort(actionOrder, function(a, b)
        local nameA = actionList[a] or a
        local nameB = actionList[b] or b
        return nameA:lower() < nameB:lower()
    end)

    -- Normalize node type for dropdown
    local normalizedType = node.actionType
    if (not normalizedType or normalizedType == "") then
        -- Use GetActionType to get action type from proto AST structure
        if node.type == ASTCore.NodeType.ACTION then
            local actionType = ASTAction.GetActionType(node)
            if actionType then
                -- Get metadata to find actionType field
                local SchemaAccessor = NAG:GetModule("SchemaAccessor")
                if actionType:match("^[a-z][a-z0-9_]*$") and actionList[actionType] and SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
                    local metadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
                    if metadata then
                        if not metadata.actionType then
                            SchemaAccessor:Warn("RenderActionNodeEditor: Missing required field 'actionType' for action '%s' - schema may be incomplete", actionType)
                        end
                        normalizedType = metadata.actionType or actionType
                    else
                        normalizedType = actionType
                    end
                else
                    normalizedType = actionType
                end
            end
        end
    end
    if (not normalizedType or normalizedType == "") then
        -- Fallback: use actionType from node if available
        local rawType = node.actionType or ""
        rawType = rawType:match("^NAG:([%w_]+)") or rawType:match("^([%w_]+)%(") or rawType
        if rawType and rawType ~= "" then
            local converted = ns.SchemaUtils:CamelToSnake(rawType)
            if not converted then
                NAG:Debug("[NodeEditors] RenderActionEditor: CamelToSnake conversion failed for rawType (rawType=%s)", tostring(rawType))
            end
            normalizedType = converted
        end
    end
    -- Handle empty action nodes (created with ASTAction.Create(nil, nil, nil))
    -- These have __invalid.missingActionType = true and no action type set
    local isEmptyAction = false
    if not normalizedType or normalizedType == "" then
        -- Check if this is an empty action node (missingActionType)
        if node.__invalid and node.__invalid.missingActionType then
            isEmptyAction = true
            -- Use placeholder value for dropdown - user will select action type
            normalizedType = "[Select Action Type]"
        else
            -- Legacy node or corrupted node - log error but still try to render
            -- Note: node.functionName and node.actionType are legacy fields - use ASTAction.GetActionType(node) instead
            NAG:Warn("[NodeEditors] RenderActionNodeEditor: Cannot determine actionType for node (protoMessage=%s; protoName=%s; hasInvalid=%s; missingActionType=%s)", tostring(node.protoMessage), tostring(node.protoName), tostring(node.__invalid ~= nil), tostring(node.__invalid and node.__invalid.missingActionType or false))
            -- Don't return - allow user to select action type from dropdown
            normalizedType = "[Select Action Type]"
            isEmptyAction = true
        end
    end

    -- Only set node.actionType if we have a real action type (not placeholder)
    if not isEmptyAction and (not node.actionType or node.actionType == "") then
        node.actionType = normalizedType
    end

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local normalizedMetadata
    -- Get metadata for UI purposes (still needed for ResolveActionDisplayName)
    -- But use direct schema lookup instead of going through metadata.protoName
    if normalizedType and normalizedType:match("^[a-z][a-z0-9_]*$") and SchemaAccessor then
        -- Get schema directly from field name
        local messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(normalizedType, "APLAction")
        if not messageSchema then
            messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(normalizedType, "APLValue")
        end
        if messageSchema then
            -- Still get metadata for UI purposes (needed for display names)
            normalizedMetadata = SchemaAccessor:GetMetadataByIdentifier(normalizedType, nil)
        end
    end

    -- Warn about missing metadata - no fallbacks allowed
    -- Skip warnings for empty action nodes (they're expected to be empty initially)
    if not isEmptyAction then
        if normalizedType == "generic" then
            NAG:Warn("[NodeEditors] Generic action type not allowed - schema structure is definitive (functionName=%s. Use specific action type from schema.)", tostring(node.functionName))
        elseif not normalizedMetadata and normalizedType ~= "[Select Action Type]" then
            NAG:Warn("[NodeEditors] Action metadata missing - schema may be incomplete (normalizedType=%s; functionName=%s. Check schema for missing metadata.)", tostring(normalizedType), tostring(node.functionName))
        end
    end

    -- Only add to actionList if it's not the placeholder
    if normalizedType ~= "[Select Action Type]" and not actionList[normalizedType] then
        if normalizedMetadata then
            local displayName = EditorUtils.ResolveActionDisplayName(normalizedMetadata)
            actionList[normalizedType] = displayName
            tinsert(actionOrder, normalizedType)
            sort(actionOrder, function(a, b)
                local nameA = actionList[a] or a
                local nameB = actionList[b] or b
                return nameA:lower() < nameB:lower()
            end)
        else
            local displayName = ns.SchemaUtils:SnakeToPascal(normalizedType)
            if not displayName then
                NAG:Debug("[NodeEditors] RenderActionEditor: SnakeToPascal conversion failed for normalizedType (normalizedType=%s)", tostring(normalizedType))
                displayName = normalizedType
            end
            actionList[normalizedType] = displayName
            tinsert(actionOrder, normalizedType)
        end
    end

    -- Add placeholder option if node is empty (must be first in list)
    if isEmptyAction then
        actionList["[Select Action Type]"] = "|cFFFFAA00[Select Action Type]|r"
        tinsert(actionOrder, 1, "[Select Action Type]")
    end

    actionDropdown:SetList(actionList, actionOrder)
    -- Set value to placeholder if empty, otherwise use normalizedType
    local dropdownValue = isEmptyAction and "[Select Action Type]" or normalizedType
    actionDropdown:SetValue(dropdownValue)
    actionDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        -- Ignore placeholder selection - user must select a real action type
        if value == "[Select Action Type]" then
            return
        end

        NAG:Info("Changing action type to: %s", value)
        local previousSelection = PreserveCurrentSelection(editorState, clauseIdx)

        -- Update node metadata based on selection
        -- CRITICAL: node.type should already be ASTCore.NodeType.ACTION for proto AST
        -- Ensure it's set correctly if missing
        if not node.type or node.type ~= ASTCore.NodeType.ACTION then
            node.type = ASTCore.NodeType.ACTION
        end
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        local snakeName = value
        if not snakeName:match("^[a-z][a-z0-9_]*$") then
            local converted = ns.SchemaUtils:CamelToSnake(value)
            if not converted then
                NAG:Debug("[NodeEditors] RenderActionEditor: CamelToSnake conversion failed for value (value=%s)", tostring(value))
                converted = value:lower()
            end
            snakeName = converted
        end
        -- Use GetMetadataByIdentifier with auto-detection (no need to check action list - auto-detection handles it)
        local metadata
        if snakeName:match("^[a-z][a-z0-9_]*$") and SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
            metadata = SchemaAccessor:GetMetadataByIdentifier(snakeName, nil)
        end
        local canonicalActionType = value
        local fieldName = snakeName or value
        local messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(fieldName, "APLAction")
        local container = "APLAction"
        if not messageSchema then
            messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(fieldName, "APLValue")
            container = "APLValue"
        end
        if messageSchema then
            -- Get protoName from schema's field info
            local schema = SchemaAccessor:GetSchemaData()
            if schema and schema.messages and schema.messages[container] and schema.messages[container].fields[fieldName] then
                local fieldInfo = schema.messages[container].fields[fieldName]
                if fieldInfo and fieldInfo.message_type then
                    node.protoMessage = fieldInfo.message_type
                end
            end
            -- Field name is already the canonical type
            canonicalActionType = fieldName
        else
            canonicalActionType = value
            node.protoMessage = nil
        end
        --- @deprecated For debugging only. Use `ASTAction.GetActionType(node)` for action type.
        node.actionType = canonicalActionType

        -- CRITICAL: Update the proto message structure node.action[actionType]
        -- GetActionType reads from node.action, not node.actionType
        -- We must clear old action type and create new one
        local existingCondition = node.condition  -- Preserve condition
        local oldActionKeys = {}
        local newActionKeys = {}

        -- CRITICAL: Ensure node.action exists and is properly initialized
        if not node.action then
            node.action = {}
        end

        -- Extract old action data and schema before clearing
        local oldActionData = nil
        local oldActionSchema = nil
        local oldActionType = ASTAction.GetActionType(node)
        if oldActionType and node.action[oldActionType] then
            oldActionData = node.action[oldActionType]
            -- Get old action schema for field comparison (SchemaAccessor already available from earlier in function)
            if SchemaAccessor then
                local oldMetadata = SchemaAccessor:GetMetadataByIdentifier(oldActionType, nil)
                if oldMetadata and oldMetadata.messageSchema then
                    oldActionSchema = oldMetadata.messageSchema
                end
            end
        end

        -- Collect old action types for telemetry
        for oldActionTypeKey in pairs(node.action) do
            tinsert(oldActionKeys, tostring(oldActionTypeKey))
            node.action[oldActionTypeKey] = nil
        end

        -- Get new action schema for field comparison
        local newActionSchema = nil
        if metadata and metadata.messageSchema then
            newActionSchema = metadata.messageSchema
        end

        -- Preserve compatible fields from old action to new action
        local preservedFields = {}
        if oldActionData and oldActionSchema and newActionSchema then
            preservedFields = PreserveCompatibleFields(oldActionData, oldActionSchema, newActionSchema)
            if next(preservedFields) then
                local preservedCount = 0
                for _ in pairs(preservedFields) do
                    preservedCount = preservedCount + 1
                end
                NAG:Info("[NodeEditors] Preserved %d compatible field(s) when changing action type from '%s' to '%s'",
                    preservedCount, oldActionType or "unknown", canonicalActionType)
            end
        end

        -- Create new action type with preserved compatible fields
        node.action[canonicalActionType] = preservedFields

        -- CRITICAL: Verify node.type is ACTION before proceeding
        if node.type ~= ASTCore.NodeType.ACTION then
            NAG:Error(format("[RenderActionNodeEditor] CRITICAL: node.type is not ACTION (type=%s) - cannot set action type",
                tostring(node.type)))
        end

        -- Collect new keys for telemetry
        for k in pairs(node.action) do
            tinsert(newActionKeys, tostring(k))
        end

        -- Restore condition
        node.condition = existingCondition

        -- CRITICAL: If node == clause.action (same reference), node.action IS clause.action.action
        -- DO NOT clear clause.action.action - it's the same table as node.action!
        if clause.action then
            if node ~= clause.action then
                -- Different references - sync needed
                -- CRITICAL: Ensure clause.action.action exists and matches node.action
                if not clause.action.action then
                    clause.action.action = {}
                else
                    -- Clear old action types from clause.action.action
                    for oldActionType in pairs(clause.action.action) do
                        clause.action.action[oldActionType] = nil
                    end
                end
                -- Copy new action type structure to clause.action.action
                for actionType, actionData in pairs(node.action) do
                    clause.action.action[actionType] = actionData
                end
            end

            -- Sync editor metadata fields (not part of proto AST)
            -- CRITICAL: Do NOT set clause.action.type - it's already set by ASTCore.CreateNode
            -- type is a proto AST constant (ASTCore.NodeType.ACTION), not a mutable field
            -- Only sync editor metadata fields that are needed for UI
            if node.actionType then
                clause.action.actionType = node.actionType  -- Editor metadata only
            end
            if node.protoMessage then
                clause.action.protoMessage = node.protoMessage  -- Editor metadata only
            end
            -- Note: messageSchema and actionMetadata are not stored - code fetches fresh from SchemaAccessor when needed
            clause.action.condition = node.condition
        end

        -- Verify proto message structure was updated correctly
        local verifyActionType = ASTAction.GetActionType(node)
        if verifyActionType ~= canonicalActionType then
            NAG:Error("[NodeEditors] Proto message structure update failed - GetActionType mismatch (Expected=%s; Got=%s)", canonicalActionType, tostring(verifyActionType))
        end

        if clause.action then
            local verifyClauseActionType = ASTAction.GetActionType(clause.action)
            if verifyClauseActionType ~= canonicalActionType then
                NAG:Error("[NodeEditors] Proto message structure sync failed - clause.action GetActionType mismatch (Expected=%s; Got=%s)", canonicalActionType, tostring(verifyClauseActionType))
            end
        end

        -- Reset argumentsText when action changes (proto structure doesn't need explicit reset)
        node.argumentsText = ""
        node.spellId = nil

        -- Update original text with proper PascalCase
        -- Use helper for consistent conversion (handles acronyms properly)
        local pascalName = ns.SchemaUtils:SnakeToPascal(value)
        if not pascalName then
                NAG:Debug("[NodeEditors] RenderActionEditor: SnakeToPascal conversion failed for originalText (value=%s)", tostring(value))
            pascalName = value
        end

        -- originalText removed - use ASTSchemaEmitter for text synthesis

        EditorUtils.MarkDirty(editorState)

        -- Sync action to canonical storage for group actions
        self:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)

        -- CRITICAL: Update main rotation tree to reflect action type change
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor and ASTEditor.UpdateClauseTree then
            local treeGroup = editorState.visualEditor and editorState.visualEditor.treeGroup
            if treeGroup then
                ASTEditor:UpdateClauseTree(treeGroup, editorState)
            end
        end

        -- CRITICAL: Refresh AST tree to rebuild nodeDetails with updated action type
        -- RefreshASTTree is synchronous and updates editorData.nodeDetails immediately
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end

        -- CRITICAL: After RefreshASTTree, nodeCounter resets so nodeIds change (root_act_3 -> root_act_2)
        -- We must find the action node by its semantic position, not by numeric ID
        -- RefreshASTTree is synchronous, so nodeDetails are available immediately
        local editorData = EditorUtils.GetClauseEditorData(editorState, clauseIdx)
        if not editorData then
            NAG:Debug("[RenderActionNodeEditor] EditorData not available after refresh")
            return
        end

        -- Find action node by semantic position (always root_act_X where X is the counter)
        local actionNodeSelection = FindActionNodeByPosition(editorData)
        if actionNodeSelection then
            ReselectCurrentNode(editorState, clauseIdx, actionNodeSelection)
        else
            -- Fallback: try to use previousSelection if it matches root_act pattern
            if previousSelection and (previousSelection:match("^root_act") or previousSelection:match("root_act")) then
                ReselectCurrentNode(editorState, clauseIdx, previousSelection)
            end
        end
    end)
    container:AddChild(actionDropdown)

    -- Render argument fields based on schema
    local ArgumentRenderer = ns.RotationEditorArgumentRenderer
    ArgumentRenderer:RenderArgumentFields(container, node, clause, clauseIdx, editorState, "action")
end

-- ~~~~~~~~~~ GROUPS & VARIABLES EDITORS ~~~~~~~~~~

--- Render groups/variables root info panel
--- @param container table Container widget
--- @param editorState table The editor state for this instance
function NodeEditors:RenderGroupsVariablesRoot(container, editorState)
    local scroll = Libs.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    local info = Libs.AceGUI:Create("Label")
    info:SetText("|cFFFFD100Groups & Variables|r\n\nRight-click to add groups or variables.\n\nGroups contain reusable action sequences.\nVariables store expressions for conditions.")
    info:SetFullWidth(true)
    scroll:AddChild(info)

    -- Summary stats
    local config = editorState.workingConfig
    local stats = Libs.AceGUI:Create("Label")
    stats:SetText(format("\nGroups: %d\nVariables: %d",
        #(config.groups or {}),
        #(config.variables or {})))
    stats:SetFullWidth(true)
    scroll:AddChild(stats)
end

--- Render group editor panel
--- @param container table Container widget
--- @param nodeId string Node ID
--- @param editorState table The editor state for this instance
function NodeEditors:RenderGroupEditor(container, nodeId, editorState)
    local groupIdx = tonumber(nodeId:match("^group_(%d+)$"))
    local config = editorState.workingConfig
    local group = config.groups[groupIdx]

    if not group then return end

    local scroll = Libs.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    -- Group name editor
    local nameGroup = Libs.AceGUI:Create("InlineGroup")
    nameGroup:SetTitle("Group Settings")
    nameGroup:SetLayout("Flow")
    nameGroup:SetFullWidth(true)
    scroll:AddChild(nameGroup)

    local nameEdit = Libs.AceGUI:Create("EditBox")
    nameEdit:SetLabel("Group Name")
    nameEdit:SetFullWidth(true)
    nameEdit:SetText(group.name or "")
    nameEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        group.name = text
        EditorUtils.MarkDirty(editorState)
        local ASTEditor = ns.RotationEditorAST
        ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
    end)
    nameGroup:AddChild(nameEdit)

    -- Actions section
    local actionsGroup = Libs.AceGUI:Create("InlineGroup")
    actionsGroup:SetTitle(format("Actions (%d)", #(group.actions or {})))
    actionsGroup:SetLayout("List")
    actionsGroup:SetFullWidth(true)
    scroll:AddChild(actionsGroup)

    for i, action in ipairs(group.actions or {}) do
        local actionEdit = Libs.AceGUI:Create("MultiLineEditBox")
        actionEdit:SetLabel(format("Action %d", i))
        actionEdit:SetFullWidth(true)
        actionEdit:SetNumLines(3)
        actionEdit:SetText(tostring(action or ""))
        actionEdit:SetCallback("OnEnterPressed", function(widget, event, text)
            group.actions[i] = text
            EditorUtils.MarkDirty(editorState)
        end)
        actionsGroup:AddChild(actionEdit)
    end

    -- Add action button
    local addBtn = Libs.AceGUI:Create("Button")
    addBtn:SetText("Add Action")
    addBtn:SetWidth(120)
    addBtn:SetCallback("OnClick", function()
        tinsert(group.actions, "")
        EditorUtils.MarkDirty(editorState)
        local ASTEditor = ns.RotationEditorAST
        ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
        EditorUtils.RefreshCurrentTab(ASTEditor, editorState)
    end)
    actionsGroup:AddChild(addBtn)
end

--- Render group action editor panel
--- @param container table Container widget
--- @param nodeId string Node ID
--- @param editorState table The editor state for this instance
function NodeEditors:RenderGroupActionEditor(container, nodeId, editorState)
    NAG:Debug(format("[RenderGroupActionEditor] Called with nodeId: %s", tostring(nodeId)))

    local groupIdx, actionIdx = nodeId:match("^group_(%d+)_action_(%d+)$")
    groupIdx, actionIdx = tonumber(groupIdx), tonumber(actionIdx)

    NAG:Debug(format("[RenderGroupActionEditor] Parsed indices - groupIdx: %s, actionIdx: %s",
        tostring(groupIdx), tostring(actionIdx)))

    local config = editorState.workingConfig
    NAG:Debug(format("[RenderGroupActionEditor] workingConfig exists: %s, groups exists: %s, groups count: %d",
        tostring(config ~= nil),
        tostring(config.groups ~= nil),
        config.groups and #config.groups or 0))

    local group = config.groups and config.groups[groupIdx]

    if not group or not group.actions or not group.actions[actionIdx] then
        NAG:Debug(format("[RenderGroupActionEditor] Data missing - group exists: %s, actions exists: %s, action count: %d",
            tostring(group ~= nil),
            tostring(group and group.actions ~= nil or false),
            group and group.actions and #group.actions or 0))
        -- Debug: Show error instead of silently returning
        local errorGroup = Libs.AceGUI:Create("InlineGroup")
        errorGroup:SetTitle("Error Loading Action")
        errorGroup:SetLayout("List")
        errorGroup:SetFullWidth(true)
        container:AddChild(errorGroup)

        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText(format("|cFFFF0000Could not load group action|r\n\nNode ID: %s\nGroup Index: %s\nAction Index: %s\nGroups Available: %d",
            tostring(nodeId),
            tostring(groupIdx),
            tostring(actionIdx),
            config.groups and #config.groups or 0))
        errorLabel:SetFullWidth(true)
        errorGroup:AddChild(errorLabel)

        return
    end

    NAG:Debug(format("[RenderGroupActionEditor] Successfully found action, rendering editor"))

    -- Main container with Flow layout for stacking elements
    local mainContainer = Libs.AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Fill")
    mainContainer:SetFullWidth(true)
    mainContainer:SetFullHeight(true)
    container:AddChild(mainContainer)

    local innerContainer = Libs.AceGUI:Create("SimpleGroup")
    innerContainer:SetLayout("Flow")
    innerContainer:SetFullWidth(true)
    mainContainer:AddChild(innerContainer)

    -- Group context section (always visible at top)
    local contextGroup = Libs.AceGUI:Create("InlineGroup")
    contextGroup:SetTitle("Group Action")
    contextGroup:SetLayout("List")
    contextGroup:SetFullWidth(true)
    innerContainer:AddChild(contextGroup)

    local contextLabel = Libs.AceGUI:Create("Label")
    contextLabel:SetText(format("|cFFFFD100Group:|r %s\n|cFFFFD100Action Index:|r %d", group.name or "Unnamed", actionIdx))
    contextLabel:SetFullWidth(true)
    contextGroup:AddChild(contextLabel)

    -- Parse action to AST
    local actionString = group.actions[actionIdx]
    local actionAST = ParseGroupAction(actionString, editorState)

    -- Create fake clause ID for this action (so we can reuse clause infrastructure)
    local fakeClauseIdx = EditorUtils.CreateGroupActionIndex(groupIdx, actionIdx)

    -- Store AST in editorState using clause-like structure
    if not editorState.groupActionEditors then
        editorState.groupActionEditors = {}
    end

    local actionKey = "group_" .. groupIdx .. "_action_" .. actionIdx
    if not editorState.groupActionEditors[actionKey] then
        editorState.groupActionEditors[actionKey] = {
            actionAST = actionAST,
            astTreeGroup = nil,
            nodeDetails = {},
            nodeDetailsByUniqueValue = {},
            treeData = nil
        }
    else
        -- Update existing AST
        editorState.groupActionEditors[actionKey].actionAST = actionAST
    end

    -- Create fake clause for AST tree building (action-only)
    -- CRITICAL: Store fakeClause in editorState so it persists across rebuilds
    local fakeClause = editorState.groupActionEditors[actionKey].fakeClause
    if not fakeClause then
        fakeClause = {
            condition = nil,
            action = actionAST,
            priority = fakeClauseIdx
        }
        editorState.groupActionEditors[actionKey].fakeClause = fakeClause
    else
        -- Update existing fakeClause instead of creating new one
        fakeClause.condition = nil
        fakeClause.action = actionAST
        fakeClause.priority = fakeClauseIdx
    end

    -- AST Container for tree + editor
    local astContainer = Libs.AceGUI:Create("SimpleGroup")
    astContainer:SetLayout("Fill")
    astContainer:SetFullWidth(true)
    astContainer:SetFullHeight(true)
    innerContainer:AddChild(astContainer)

    -- Build AST tree for this action (reuse clause tree builder)
    local ASTEditor = ns.RotationEditorAST
    if not ASTEditor then
        NAG:Warn("ASTEditor module not found!")
        return
    end

    local tree, nodeDetails, conditionAST, nodeDetailsByUniqueValue = ASTEditor:BuildClauseASTTree(fakeClause, editorState, fakeClauseIdx)

    -- Debug: Log tree structure
    if tree and #tree > 0 then
        NAG:Debug(format("[RenderGroupActionEditor] Tree built with %d root nodes", #tree))
        if tree[1].children then
            NAG:Debug(format("[RenderGroupActionEditor] Root has %d children", #tree[1].children))
            for i, child in ipairs(tree[1].children) do
                NAG:Debug(format("[RenderGroupActionEditor] Child %d: value=%s, text=%s", i, tostring(child.value), tostring(child.text)))
            end
        end
    else
        NAG:Warn("[RenderGroupActionEditor] Tree is empty or nil!")
    end

    -- Store for later access
    editorState.groupActionEditors[actionKey].nodeDetails = nodeDetails
    editorState.groupActionEditors[actionKey].nodeDetailsByUniqueValue = nodeDetailsByUniqueValue
    editorState.groupActionEditors[actionKey].treeData = tree

    -- Create TreeGroup for AST visualization
    local treeGroup = ns.CreateTreeGroup()
    treeGroup:SetFullWidth(true)
    treeGroup:SetFullHeight(true)
    treeGroup:SetLayout("Fill")
    treeGroup.noAutoHeight = true

    -- CRITICAL: Setup context menu BEFORE SetStatusTable so the RefreshTree hook is in place
    -- when SetStatusTable calls RefreshTree() internally (line 357 in AceGUI TreeGroup)
    ASTEditor:SetupNodeContextMenu(treeGroup, fakeClauseIdx, editorState)

    -- Set tree width (similar to clause editor)
    if not editorState.groupActionTreeStatus then
        editorState.groupActionTreeStatus = {}
    end
    if not editorState.groupActionTreeStatus[actionKey] then
        editorState.groupActionTreeStatus[actionKey] = {
            groups = {},
            treewidth = 350,
            treesizable = true,
            scrollvalue = 0
        }
    end
    treeGroup:SetStatusTable(editorState.groupActionTreeStatus[actionKey])
    local persistedWidth = editorState.groupActionTreeStatus[actionKey].treewidth or 350
    treeGroup:SetTreeWidth(persistedWidth, true)

    treeGroup:SetTree(tree)
    astContainer:AddChild(treeGroup)

    -- Store tree group reference
    editorState.groupActionEditors[actionKey].astTreeGroup = treeGroup

    -- Set up selection callback for tree nodes
    treeGroup:SetCallback("OnGroupSelected", function(containerWidget, event, groupVal)
        containerWidget:ReleaseChildren()

        -- Extract node ID from hierarchical path
        local selectedNodeId = groupVal
        if groupVal and groupVal:find("\001") then
            selectedNodeId = groupVal:match("[^\001]+$") or groupVal
        end

        -- Store last selection
        if editorState.groupActionEditors[actionKey] then
            editorState.groupActionEditors[actionKey].lastSelection = selectedNodeId
        end

        -- Find node data
        local nodeData = nodeDetails[selectedNodeId] or nodeDetailsByUniqueValue[selectedNodeId]

        if not nodeData or not nodeData.node then
            -- Show info panel
            local infoLabel = Libs.AceGUI:Create("Label")
            infoLabel:SetText("|cFFFFD100Select a node in the tree to edit it|r")
            infoLabel:SetFullWidth(true)
            containerWidget:AddChild(infoLabel)
            return
        end

        -- Render node editor for selected node
        -- Use stored fakeClause to stay in sync with rebuilds
        local currentFakeClause = editorState.groupActionEditors[actionKey].fakeClause or fakeClause
        self:RenderNodeEditPanel(containerWidget, selectedNodeId, currentFakeClause, fakeClauseIdx, editorState)
    end)

    -- Auto-select the action node (root_act) to show editor immediately
    -- This avoids the "Select a node" placeholder and directly shows the editor
    if tree and #tree > 0 and tree[1].children and #tree[1].children > 0 then
        -- Find the action node (should be root_act)
        for _, child in ipairs(tree[1].children) do
            if child.value and child.value:match("root_act") then
                treeGroup:SelectByValue(child.value)
                break
            end
        end
    end

    -- Note: Group actions now sync automatically via SyncActionToCanonicalStorage
    -- No manual save button needed
end

--- Render variable editor panel with full AST tree support
--- @param container table Container widget
--- @param nodeId string Node ID
--- @param editorState table The editor state for this instance
function NodeEditors:RenderVariableEditor(container, nodeId, editorState)
    local varIdx = tonumber(nodeId:match("^variable_(%d+)$"))
    local config = editorState.workingConfig
    local variable = config.variables and config.variables[varIdx]

    if not variable then
        -- Debug: Show error instead of silently returning
        local errorGroup = Libs.AceGUI:Create("InlineGroup")
        errorGroup:SetTitle("Error Loading Variable")
        errorGroup:SetLayout("List")
        errorGroup:SetFullWidth(true)
        container:AddChild(errorGroup)

        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText(format("|cFFFF0000Could not load variable|r\n\nNode ID: %s\nVariable Index: %s\nVariables Available: %d",
            tostring(nodeId),
            tostring(varIdx),
            config.variables and #config.variables or 0))
        errorLabel:SetFullWidth(true)
        errorGroup:AddChild(errorLabel)

        return
    end

    -- Main container with Flow layout for stacking elements
    local mainContainer = Libs.AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Fill")
    mainContainer:SetFullWidth(true)
    mainContainer:SetFullHeight(true)
    container:AddChild(mainContainer)

    local innerContainer = Libs.AceGUI:Create("SimpleGroup")
    innerContainer:SetLayout("Flow")
    innerContainer:SetFullWidth(true)
    mainContainer:AddChild(innerContainer)

    -- Variable name section (always visible at top)
    local nameGroup = Libs.AceGUI:Create("InlineGroup")
    nameGroup:SetTitle("Variable Settings")
    nameGroup:SetLayout("List")
    nameGroup:SetFullWidth(true)
    innerContainer:AddChild(nameGroup)

    local nameEdit = Libs.AceGUI:Create("EditBox")
    nameEdit:SetLabel("Variable Name")
    nameEdit:SetFullWidth(true)
    nameEdit:SetText(variable.name or "")
    nameEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        variable.name = text
        EditorUtils.MarkDirty(editorState)
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor and editorState.visualEditor and editorState.visualEditor.treeGroup then
            ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
        end
    end)
    nameGroup:AddChild(nameEdit)

    -- Variable Controls section (similar to clause controls)
    -- Note: editorData will be initialized below, but we need to check stringEditMode here
    local editorData = editorState.variableEditors and editorState.variableEditors[varIdx]
    local isStringMode = (editorData and editorData.stringEditMode) or false

    local variableControlsGroup = Libs.AceGUI:Create("InlineGroup")
    variableControlsGroup:SetLayout("Flow")
    variableControlsGroup:SetFullWidth(true)
    variableControlsGroup:SetTitle(L["clauseControls"] or "Variable Controls")
    innerContainer:AddChild(variableControlsGroup)

    -- Expand All button (icon only, disabled in string mode)
    local expandAllBtn = Libs.AceGUI:Create("Icon")
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
            local varEditorData = editorState.variableEditors[varIdx]
            if varEditorData and varEditorData.astTreeGroup and varEditorData.treeData then
                -- Use variableTreeStatus instead of clauseTreeStatus
                if not editorState.variableTreeStatus then
                    editorState.variableTreeStatus = {}
                end
                if not editorState.variableTreeStatus[varIdx] then
                    editorState.variableTreeStatus[varIdx] = { groups = {} }
                end

                -- Collect all hierarchical node values
                local nodeValues = {}
                local function CollectAllNodeValues(node, values, parentPath)
                    local nodeValue = node.value or node.uniquevalue
                    if nodeValue then
                        local fullPath = parentPath and (parentPath .. "\001" .. nodeValue) or nodeValue
                        table.insert(values, fullPath)
                        if node.children then
                            for _, child in ipairs(node.children) do
                                CollectAllNodeValues(child, values, fullPath)
                            end
                        end
                    end
                end

                for _, rootNode in ipairs(varEditorData.treeData) do
                    CollectAllNodeValues(rootNode, nodeValues, nil)
                end

                -- Set all to expanded
                for _, nodeValue in ipairs(nodeValues) do
                    editorState.variableTreeStatus[varIdx].groups[nodeValue] = true
                end

                -- Refresh tree display
                varEditorData.astTreeGroup:RefreshTree()
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
    variableControlsGroup:AddChild(expandAllBtn)

    -- Collapse All button (icon only, disabled in string mode)
    local collapseAllBtn = Libs.AceGUI:Create("Icon")
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
            local varEditorData = editorState.variableEditors[varIdx]
            if varEditorData and varEditorData.astTreeGroup then
                -- Use variableTreeStatus instead of clauseTreeStatus
                if editorState.variableTreeStatus and editorState.variableTreeStatus[varIdx] then
                    editorState.variableTreeStatus[varIdx].groups = {}
                end

                -- Refresh tree display
                varEditorData.astTreeGroup:RefreshTree()
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
    variableControlsGroup:AddChild(collapseAllBtn)

    -- Toggle Comparison Nodes button (icon only, disabled in string mode)
    local toggleCompBtn = Libs.AceGUI:Create("Icon")
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
            local varEditorData = editorState.variableEditors[varIdx]
            if varEditorData and varEditorData.astTreeGroup and varEditorData.treeData and varEditorData.nodeDetailsByUniqueValue then
                -- Use variableTreeStatus instead of clauseTreeStatus
                if not editorState.variableTreeStatus then
                    editorState.variableTreeStatus = {}
                end
                if not editorState.variableTreeStatus[varIdx] then
                    editorState.variableTreeStatus[varIdx] = { groups = {} }
                end

                -- Collect all comparison node uniquevalues using ASTEditor's helper
                -- We need to access the internal CollectComparisonNodeValues function
                -- For now, we'll use a similar approach but check for comparison nodes properly
                local comparisonNodes = {}
                local ASTValue = ns.ASTValue
                local function CollectComparisonNodeValues(treeNode, nodeDetailsByUniqueValue, nodeValues, parentPath)
                    if treeNode.value then
                        local uniquevalue = parentPath and (parentPath .. "\001" .. treeNode.value) or treeNode.value

                        -- Check if this node is a comparison node
                        local nodeDetail = nodeDetailsByUniqueValue[uniquevalue]
                        if nodeDetail and nodeDetail.node and ASTValue and ASTValue.IsComparison then
                            if ASTValue.IsComparison(nodeDetail.node) then
                                table.insert(nodeValues, uniquevalue)
                            end
                        end

                        -- Recurse into children
                        if treeNode.children then
                            for _, child in ipairs(treeNode.children) do
                                CollectComparisonNodeValues(child, nodeDetailsByUniqueValue, nodeValues, uniquevalue)
                            end
                        end
                    end
                end

                for _, rootNode in ipairs(varEditorData.treeData) do
                    CollectComparisonNodeValues(rootNode, varEditorData.nodeDetailsByUniqueValue, comparisonNodes, nil)
                end

                -- Check if any comparison nodes are currently expanded
                local hasExpanded = false
                for _, nodeValue in ipairs(comparisonNodes) do
                    if editorState.variableTreeStatus[varIdx].groups[nodeValue] then
                        hasExpanded = true
                        break
                    end
                end

                -- Toggle all comparison nodes
                for _, nodeValue in ipairs(comparisonNodes) do
                    editorState.variableTreeStatus[varIdx].groups[nodeValue] = not hasExpanded
                end

                -- Refresh tree display
                varEditorData.astTreeGroup:RefreshTree()
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
    variableControlsGroup:AddChild(toggleCompBtn)

    -- String Edit Toggle button (icon only, always enabled)
    local stringEditToggleBtn = Libs.AceGUI:Create("Icon")
    if isStringMode then
        stringEditToggleBtn:SetImage("Interface\\Icons\\INV_Misc_Book_09")
    else
        stringEditToggleBtn:SetImage("Interface\\Icons\\INV_Misc_Note_01")
    end
    stringEditToggleBtn:SetImageSize(24, 24)
    stringEditToggleBtn:SetWidth(32)
    stringEditToggleBtn:SetHeight(32)
    stringEditToggleBtn:SetCallback("OnClick", function()
        -- Ensure editorData exists
        if not editorState.variableEditors then
            editorState.variableEditors = {}
        end
        if not editorState.variableEditors[varIdx] then
            editorState.variableEditors[varIdx] = {
                astTreeGroup = nil,
                nodeDetails = {},
                nodeDetailsByUniqueValue = {},
                treeData = nil
            }
        end
        local varEditorData = editorState.variableEditors[varIdx]

        varEditorData.stringEditMode = not varEditorData.stringEditMode

        -- Refresh the variable editor to show/hide string edit mode
        -- This will trigger a rebuild of the editor panel
        if editorState.visualEditor and editorState.visualEditor.treeGroup then
            local treeGroup = editorState.visualEditor.treeGroup
            treeGroup:Fire("OnGroupSelected", "variable_" .. varIdx)
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
    variableControlsGroup:AddChild(stringEditToggleBtn)

    -- Get variable value string and parse to proto AST
    -- For new/empty variables, default to a constant so there's always a node to edit
    local valueString = variable.value
    if not valueString or valueString == "" then
        valueString = '""'  -- Default to empty string constant
    end

    -- Create fake clause ID for this variable (so we can reuse clause infrastructure)
    local fakeClauseIdx = EditorUtils.CreateVariableIndex(varIdx)

    -- Store editor state for this variable
    if not editorState.variableEditors then
        editorState.variableEditors = {}
    end

    if not editorState.variableEditors[varIdx] then
        editorState.variableEditors[varIdx] = {
            astTreeGroup = nil,
            nodeDetails = {},
            nodeDetailsByUniqueValue = {},
            treeData = nil
        }
    end

    -- Parse variable value to proto AST
    local parsedValueAST = ParseVariableValue(valueString, editorState)

    -- Create fake clause for AST tree building using proto AST structure
    -- CRITICAL: BuildClauseASTTree expects listItem.action to be proto AST action node
    -- For variables, we create a dummy action with the variable value in action.condition
    -- CRITICAL: Store fakeClause in editorState so it persists across rebuilds
    -- This ensures tree selection callbacks remain in sync with RebuildConditionFromAST
    local fakeClause = editorState.variableEditors[varIdx].fakeClause
    if not fakeClause then
        -- Create dummy action node with condition set to variable value (proto AST)
        local fakeAction = ASTAction and ASTAction.CreateFromFields("cast_spell", {}, nil)
        if fakeAction and ASTAction then
            ASTAction.SetCondition(fakeAction, parsedValueAST)
        end
        fakeClause = {
            condition = nil,  -- Not used in proto AST
            action = fakeAction,  -- Contains condition in action.condition
            priority = varIdx
        }
        editorState.variableEditors[varIdx].fakeClause = fakeClause
    else
        -- Update existing fakeClause instead of creating new one
        -- Ensure action exists and update condition
        if not fakeClause.action then
            fakeClause.action = ASTAction and ASTAction.CreateFromFields("cast_spell", {}, nil)
        end
        if fakeClause.action and ASTAction then
            ASTAction.SetCondition(fakeClause.action, parsedValueAST)
        end
        fakeClause.condition = nil  -- Not used in proto AST
        fakeClause.priority = varIdx
    end

    -- Check if we should show string editor or AST tree
    if isStringMode then
        -- Show string editor for variable value
        local valueEditorGroup = Libs.AceGUI:Create("InlineGroup")
        valueEditorGroup:SetTitle("Variable Value")
        valueEditorGroup:SetLayout("Flow")
        valueEditorGroup:SetFullWidth(true)
        valueEditorGroup:SetFullHeight(true)
        innerContainer:AddChild(valueEditorGroup)

        local valueEditor = Libs.AceGUI:Create("MultiLineEditBox")
        valueEditor:SetLabel("Edit variable value string")
        valueEditor:SetFullWidth(true)
        valueEditor:SetNumLines(12)

        -- Enable syntax highlighting
        local SyntaxHL = ns.RotationEditorSyntaxHighlighting
        if SyntaxHL and valueEditor.editBox then
            SyntaxHL.EnableAPLSyntaxHighlighting(valueEditor.editBox, 4, {
                preserveExistingIndent = true
            })
        end

        -- Set current value text from proto AST
        local valueAST = fakeClause.action and fakeClause.action.condition
        local valueText = ""
        if valueAST then
            local ASTSchemaEmitter = ns.ASTSchemaEmitter
            if ASTSchemaEmitter then
                valueText = ASTSchemaEmitter.EmitValueNode(valueAST) or ""
            end
        elseif valueString and valueString ~= '""' then
            valueText = valueString
        end
        valueEditor:SetText(valueText)

        -- Add APL autocomplete for values
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        local valuesData = SchemaAccessor and SchemaAccessor:GetAutocompleteData("Values")
        local APLAutocomplete = ns.RotationEditorAPLAutocomplete
        if valuesData and APLAutocomplete then
            APLAutocomplete:AddToEditBox(valueEditor, valuesData, "Values", function(entry, widget)
                local text = widget:GetText() or ""
                local cursorPos = widget.editBox:GetCursorPosition()
                local beforeCursor = text:sub(1, cursorPos)
                local afterCursor = text:sub(cursorPos + 1)
                local newBefore = beforeCursor:gsub("[%w_:]+$", entry.name)
                widget:SetText(newBefore .. afterCursor)
                widget.editBox:SetCursorPosition(#newBefore)
            end)
        end

        -- OnEnterPressed callback to sync value changes
        valueEditor:SetCallback("OnEnterPressed", function(widget, event, text)
            if text and text ~= "" then
                -- Parse value text to proto AST using ParseClause for consistency
                local NAGStringParser = NAG:GetModule("NAGStringParser")
                if NAGStringParser then
                    local clauseResult = NAGStringParser:ParseClause(text, nil, nil)
                    local valueAST = nil
                    if clauseResult then
                        -- Extract value from clause result (could be in value or condition field)
                        valueAST = clauseResult.value or clauseResult.condition
                    end
                    if valueAST then
                        -- Update variable value in config
                        variable.value = text

                        -- Update fakeClause with new AST
                        if not fakeClause.action then
                            fakeClause.action = ASTAction and ASTAction.CreateFromFields("cast_spell", {}, nil)
                        end
                        if fakeClause.action and ASTAction then
                            ASTAction.SetCondition(fakeClause.action, valueAST)
                        end

                        EditorUtils.MarkDirty(editorState)

                        -- Refresh variable tree if in tree mode
                        if not isStringMode then
                            local ASTEditor = ns.RotationEditorAST
                            if ASTEditor and editorState.visualEditor and editorState.visualEditor.treeGroup then
                                ASTEditor:UpdateClauseTree(editorState.visualEditor.treeGroup, editorState)
                            end
                        end

                        NAG:Print("|cFF00FF00Variable value updated! Click main Save to commit.|r")
                    end
                end
            else
                -- Empty value - set to empty string constant
                variable.value = '""'
                if fakeClause.action and ASTAction then
                    ASTAction.SetCondition(fakeClause.action, ASTValue.CreateConst(""))
                end
                EditorUtils.MarkDirty(editorState)
            end
        end)

        valueEditorGroup:AddChild(valueEditor)
    else
        -- AST Container for tree + editor
        local astContainer = Libs.AceGUI:Create("SimpleGroup")
        astContainer:SetLayout("Fill")
        astContainer:SetFullWidth(true)
        astContainer:SetFullHeight(true)
        innerContainer:AddChild(astContainer)

        -- Build AST tree for this variable (reuse clause tree builder)
        local ASTEditor = ns.RotationEditorAST
        if not ASTEditor then
            NAG:Warn("ASTEditor module not found!")
            return
        end

        local tree, nodeDetails, nodeDetailsByUniqueValue = ASTEditor:BuildClauseASTTree(fakeClause, editorState, fakeClauseIdx)

        -- Debug: Log tree structure
        if tree and #tree > 0 then
            NAG:Debug(format("[RenderVariableEditor] Tree built with %d root nodes", #tree))
            if tree[1].children then
                NAG:Debug(format("[RenderVariableEditor] Root has %d children", #tree[1].children))
                for i, child in ipairs(tree[1].children) do
                    NAG:Debug(format("[RenderVariableEditor] Child %d: value=%s, text=%s", i, tostring(child.value), tostring(child.text)))
                end
            end
        else
            NAG:Warn("[RenderVariableEditor] Tree is empty or nil!")
        end

        -- Store for later access
        editorState.variableEditors[varIdx].nodeDetails = nodeDetails
        editorState.variableEditors[varIdx].nodeDetailsByUniqueValue = nodeDetailsByUniqueValue
        -- Condition is part of fakeClause.action.condition in proto AST, not stored separately
        editorState.variableEditors[varIdx].treeData = tree

        -- Create TreeGroup for AST visualization
        local treeGroup = ns.CreateTreeGroup()
        treeGroup:SetFullWidth(true)
        treeGroup:SetFullHeight(true)
        treeGroup:SetLayout("Fill")
        treeGroup.noAutoHeight = true

        -- CRITICAL: Setup context menu BEFORE SetStatusTable so the RefreshTree hook is in place
        -- when SetStatusTable calls RefreshTree() internally (line 357 in AceGUI TreeGroup)
        ASTEditor:SetupNodeContextMenu(treeGroup, fakeClauseIdx, editorState)

        -- Set tree width (similar to clause editor)
        if not editorState.variableTreeStatus then
            editorState.variableTreeStatus = {}
        end
        if not editorState.variableTreeStatus[varIdx] then
            editorState.variableTreeStatus[varIdx] = {
                groups = {},
                treewidth = 350,
                treesizable = true,
                scrollvalue = 0
            }
        end
        treeGroup:SetStatusTable(editorState.variableTreeStatus[varIdx])
        local persistedWidth = editorState.variableTreeStatus[varIdx].treewidth or 350
        treeGroup:SetTreeWidth(persistedWidth, true)

        treeGroup:SetTree(tree)
        astContainer:AddChild(treeGroup)

        -- Store tree group reference
        editorState.variableEditors[varIdx].astTreeGroup = treeGroup

        -- Set up selection callback for tree nodes
        treeGroup:SetCallback("OnGroupSelected", function(containerWidget, event, group)
            containerWidget:ReleaseChildren()

            -- Extract node ID from hierarchical path
            local selectedNodeId = group
            if group and group:find("\001") then
                selectedNodeId = group:match("[^\001]+$") or group
            end

            -- Store last selection
            if editorState.variableEditors[varIdx] then
                editorState.variableEditors[varIdx].lastSelection = selectedNodeId
            end

            -- Find node data
            local nodeData = nodeDetails[selectedNodeId] or nodeDetailsByUniqueValue[selectedNodeId]

            if not nodeData or not nodeData.node then
                -- Show info panel
                local infoLabel = Libs.AceGUI:Create("Label")
                infoLabel:SetText("|cFFFFD100Select a node in the tree to edit it|r")
                infoLabel:SetFullWidth(true)
                containerWidget:AddChild(infoLabel)
                return
            end

            -- Render node editor for selected node
            -- Use stored fakeClause to stay in sync with rebuilds
            local currentFakeClause = editorState.variableEditors[varIdx].fakeClause or fakeClause
            self:RenderNodeEditPanel(containerWidget, selectedNodeId, currentFakeClause, fakeClauseIdx, editorState)
        end)

        -- Auto-select the condition node (root_cond) to show editor immediately
        -- This avoids the "Select a node" placeholder and directly shows the editor
        if tree and #tree > 0 and tree[1].children and #tree[1].children > 0 then
            -- Find the condition node (should be root_cond)
            for _, child in ipairs(tree[1].children) do
                if child.value and child.value:match("root_cond") then
                    treeGroup:SelectByValue(child.value)
                    break
                end
            end
        end
    end

    -- Note: Variables now sync automatically via RebuildConditionFromAST
    -- No manual save button needed
end

return NodeEditors

