--- @module "RotationEditor.ArgumentRenderer"
--- Schema-driven argument field rendering for RotationEditor
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local Libs = ns.Libs
local WoWAPI = ns.WoWAPI
local TableUtils = ns.TableUtils
local EditorUtils = ns.RotationEditorUtils

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tostring = tostring
local tonumber = tonumber
local type = type
local pairs = pairs
local ipairs = ipairs
local next = next
local sort = table.sort
local strlower = strlower
local strmatch = strmatch

-- Cached module references
local FieldFormatConverter = ns.FieldFormatConverter
local TypesModule

local function GetTypesModule()
    if not TypesModule then
        TypesModule = NAG:GetModule("Types")
    end
    return TypesModule
end

-- ============================ ENUM NORMALIZATION ============================

local function ExtractEnumScalar(rawValue)
    if rawValue == nil then
        return nil
    end

    if type(rawValue) ~= "table" then
        return rawValue
    end

    if rawValue.value ~= nil then
        return rawValue.value
    end

    for fieldKey, fieldValue in pairs(rawValue) do
        if type(fieldValue) == "table" and fieldValue[fieldKey] ~= nil then
            return fieldValue[fieldKey]
        elseif type(fieldValue) ~= "table" then
            return fieldValue
        end
    end

    return nil
end

local function BuildEnumCandidates(rawString, enumType)
    local candidates = {}
    local seen = {}

    local function addCandidate(candidate)
        if candidate and candidate ~= "" and not seen[candidate] then
            seen[candidate] = true
            candidates[#candidates + 1] = candidate
        end
    end

    if not rawString or rawString == "" then
        return candidates
    end

    local trimmed = rawString:gsub("%s+", "")
    addCandidate(trimmed)

    local colonNormalized = trimmed:gsub("::", ".")
    addCandidate(colonNormalized)

    addCandidate(trimmed:gsub("^NAG%.Types%.", ""))
    addCandidate(trimmed:gsub("^Types%.", ""))

    local typeName = enumType and enumType.GetName and enumType:GetName()
    if typeName then
        local pattern = "^" .. typeName .. "[%.:_]*"
        addCandidate(trimmed:gsub(pattern, ""))
        addCandidate(colonNormalized:gsub(pattern, ""))
    end

    local lastSegment = trimmed:match("([%w_]+)$")
    addCandidate(lastSegment)
    if lastSegment and typeName then
        addCandidate(lastSegment:gsub("^" .. typeName, ""))
    end

    return candidates
end

local function NormalizeEnumArgument(fieldName, fieldDef, enumValues, rawValue)
    local scalar = ExtractEnumScalar(rawValue)
    if scalar == nil then
        return nil, nil
    end

    local Types = GetTypesModule()
    local enumTypeName = fieldDef and (fieldDef.enum_type or fieldDef.enumType or fieldDef.enumTypeName)
    local enumType = nil
    if Types and enumTypeName then
        enumType = Types:GetType(enumTypeName)
        if not enumType and Types.GetEnumShortName then
            local shortName = Types:GetEnumShortName(enumTypeName)
            if shortName then
                enumType = Types:GetType(shortName)
            end
        end
    end

    local valuesByName = enumValues or (enumType and enumType.GetValues and enumType:GetValues()) or nil
    local prefixedValues = enumType and enumType.GetPrefixedValues and enumType:GetPrefixedValues() or nil

    if type(scalar) == "number" then
        local key
        if enumType and enumType.GetNameByValue then
            key = enumType:GetNameByValue(scalar)
        end
        if not key and valuesByName then
            for name, valueId in pairs(valuesByName) do
                if valueId == scalar then
                    key = name
                    break
                end
            end
        end
        return scalar, key
    end

    if type(scalar) == "string" then
        local candidates = BuildEnumCandidates(scalar, enumType)
        local lowerLookup = {}
        if valuesByName then
            for name, valueId in pairs(valuesByName) do
                lowerLookup[name:lower()] = { name = name, id = valueId }
            end
        end

        for _, candidate in ipairs(candidates) do
            if valuesByName and valuesByName[candidate] ~= nil then
                return valuesByName[candidate], candidate
            end

            if prefixedValues and prefixedValues[candidate] ~= nil then
                local enumID = prefixedValues[candidate]
                local resolvedKey = (enumType and enumType.GetNameByValue) and enumType:GetNameByValue(enumID) or candidate
                return enumID, resolvedKey
            end

            local lowerCandidate = candidate:lower()
            local match = lowerLookup[lowerCandidate]
            if match then
                return match.id, match.name
            end
        end

        if enumType and enumType.GetValues then
            for name, valueId in pairs(enumType:GetValues()) do
                if name:upper() == scalar:upper() then
                    return valueId, name
                end
            end
        end

        local numeric = tonumber(scalar)
        if numeric then
            local key
            if enumType and enumType.GetNameByValue then
                key = enumType:GetNameByValue(numeric)
            end
            if not key and valuesByName then
                for name, valueId in pairs(valuesByName) do
                    if valueId == numeric then
                        key = name
                        break
                    end
                end
            end
            return numeric, key
        end

        NAG:Trace(("[Enum Normalize] Unable to resolve enum value '%s' for field '%s'"):format(tostring(scalar), tostring(fieldName)))
        return scalar, nil
    end

    return scalar, nil
end

local function ShouldUseStatAnyOption(fieldName, fieldDef)
    if not fieldName then
        return false
    end

    if fieldDef then
        local enumTypeName = fieldDef.enum_type or fieldDef.enumType or fieldDef.enumTypeName
        if enumTypeName == "Stat" then
            return true
        end
    end

    local lowerName = strlower(fieldName)
    if lowerName == "stat_type" or lowerName == "stattype" then
        return true
    end

    if strmatch(lowerName, "^stat_type%d+$") or strmatch(lowerName, "^stattype%d+$") then
        return true
    end

    return false
end

-- ============================ HELPER FUNCTIONS ============================

--- Get schema field information from messageSchema
--- @param messageSchema table|nil Full message schema with _metadata
--- @param fieldName string Field name
--- @return table|nil Field info with fieldType, enumTypeName, enumValues, enumType, messageType, fieldMetadata
local function GetSchemaFieldInfo(messageSchema, fieldName)
    if not messageSchema or not fieldName then
        return nil
    end

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor then
        return nil
    end

    local fieldInfo = {
        fieldType = SchemaAccessor:GetFieldType(messageSchema, fieldName),
        enumTypeName = SchemaAccessor:GetFieldEnumType(messageSchema, fieldName),
        messageType = SchemaAccessor:GetFieldMessageType(messageSchema, fieldName),
        fieldMetadata = SchemaAccessor:GetFieldMetadata(messageSchema, fieldName)
    }

    -- Get enum values if enum type exists
    if fieldInfo.enumTypeName then
        fieldInfo.enumValues, fieldInfo.enumType = SchemaAccessor:GetFieldEnumValues(messageSchema, fieldName)
    end

    return fieldInfo
end

--- Get effective default value from schema, normalized by field type
--- @param messageSchema table|nil Full message schema with _metadata
--- @param fieldName string Field name
--- @param fieldType string|nil Field type (for normalization)
--- @return any Normalized default value
local function GetEffectiveDefaultValue(messageSchema, fieldName, fieldType)
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor or not messageSchema then
        return nil
    end

    local effectiveDefault = SchemaAccessor:GetEffectiveDefault(messageSchema, fieldName)
    if effectiveDefault == nil then
        return nil
    end

    -- Normalize based on field type
    if fieldType == "number" or fieldType == "integer" or fieldType == "int32" or fieldType == "int64" or fieldType == "float" or fieldType == "double" then
        return tonumber(effectiveDefault) or 0
    elseif fieldType == "string" then
        return tostring(effectiveDefault)
    elseif fieldType == "boolean" or fieldType == "bool" then
        return effectiveDefault == true
    elseif fieldType == "enum" then
        if type(effectiveDefault) == "number" then
            return effectiveDefault
        elseif type(effectiveDefault) == "string" then
            return effectiveDefault
        end
        return 0  -- Proto3 default for enums
    end

    return effectiveDefault
end

--- Get proto data structure from node
--- @param node table AST node
--- @param nodeCategory string "value" or "action"
--- @return table|nil protoData The proto data structure
--- @return string|nil nodeType The value type or action type
local function GetProtoData(node, nodeCategory)
    if not node then
        return nil, nil
    end

    local ASTAction = ns.ASTAction
    local ASTValue = ns.ASTValue
    local ASTCore = ns.ASTCore

    if nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        local protoData = ASTValue.GetValueData(node)
        return protoData, valueType
    elseif nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
        local actionType = ASTAction.GetActionType(node)
        local protoData = ASTAction.GetActionData(node)
        return protoData, actionType
    end

    return nil, nil
end

--- Ensure proto data structure exists, initializing if needed
--- @param node table AST node
--- @param nodeCategory string "value" or "action"
--- @return table protoData The proto data structure (guaranteed to exist)
--- @return string|nil nodeType The value type or action type
local function EnsureProtoData(node, nodeCategory)
    if not node then
        return nil, nil
    end

    local ASTAction = ns.ASTAction
    local ASTValue = ns.ASTValue
    local ASTCore = ns.ASTCore

    if nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        local protoData = ASTValue.GetValueData(node)
        if not protoData then
            if not node.value then
                node.value = {}
            end
            if not node.value[valueType] then
                node.value[valueType] = {}
            end
            protoData = node.value[valueType]
        end
        return protoData, valueType
    elseif nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
        local actionType = ASTAction.GetActionType(node)
        local protoData = ASTAction.GetActionData(node)
        if not protoData then
            if not node.action then
                node.action = {}
            end
            if not node.action[actionType] then
                node.action[actionType] = {}
            end
            protoData = node.action[actionType]
        end
        return protoData, actionType
    end

    return nil, nil
end

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local ArgumentRenderer = {}
ns.RotationEditorArgumentRenderer = ArgumentRenderer

-- ~~~~~~~~~~ ARGUMENT RENDERING ~~~~~~~~~~

--- Create argument accessor functions for a node
--- @param node table AST node
--- @param nodeCategory string "value" or "action"
--- @param schema table Schema with fields and field_order
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
--- @return function getArgValue Getter function for argument values
--- @return function setArgValue Setter function for argument values
--- @return function getArgNode Getter function for argument nodes
--- @return function setArgNode Setter function for argument nodes
--- @return function rebuildNode Rebuild function for node updates
function ArgumentRenderer:CreateArgumentAccessors(node, nodeCategory, schema, clause, clauseIdx, editorState)
    local ASTAction = ns.ASTAction
    local ASTValue = ns.ASTValue
    local ASTCore = ns.ASTCore

    -- Helper: Get full argument node by index (field_order position)
    local function getArgNode(index)
        if not schema or not schema.field_order or not schema.field_order[index] then
            return nil
        end

        local fieldName = schema.field_order[index]
        local fieldInfo = schema.fields[fieldName]

        -- Get proto data structure
        local protoData = GetProtoData(node, nodeCategory)
        if not protoData then
            return nil
        end

        local fieldValue = protoData[fieldName]

        -- For complex types (APLValue message fields), handle proto structure or full wrapper
        if fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "APLValue" then
            -- fieldValue might be proto structure { [valueType] = valueData } or full wrapper
            if type(fieldValue) == "table" and fieldValue.type == ASTCore.NodeType.VALUE then
                -- Already a full wrapper, return as-is
                return fieldValue
            elseif type(fieldValue) == "table" then
                -- Proto structure - reconstruct wrapper node
                for valueType, valueData in pairs(fieldValue) do
                    return ASTValue.Create(valueType, valueData)
                end
            end
            return fieldValue
        end

        -- For simple types, wrap in proto AST constant node if needed
        if fieldValue ~= nil then
            -- If it's already a proto AST node, return it
            if type(fieldValue) == "table" and fieldValue.type == ASTCore.NodeType.VALUE then
                return fieldValue
            end
            -- Otherwise, wrap raw value in const node
            return ASTValue.CreateConst(fieldValue)
        end

        return nil
    end

    -- Helper: Get argument value by index (field_order position)
    local function getArgValue(index)
        if not schema or not schema.field_order or not schema.field_order[index] then
            NAG:Trace(format("[getArgValue] No field_order[%d], returning nil", index))
            return nil
        end

        local fieldName = schema.field_order[index]
        local fieldInfo = schema.fields[fieldName]

        -- Get proto data structure
        local protoData = GetProtoData(node, nodeCategory)
        if not protoData then
            NAG:Trace(format("[getArgValue] Invalid node type or category, returning nil"))
            return nil
        end

        local fieldValue = protoData[fieldName]

        if fieldValue == nil then
            return nil
        end

        -- Handle repeated fields - return array directly
        if fieldInfo and fieldInfo.label == "repeated" then
            -- For repeated fields, fieldValue should be an array
            if type(fieldValue) == "table" then
                -- Check if it's an array (ipairs-able)
                local isArray = false
                for _ in ipairs(fieldValue) do
                    isArray = true
                    break
                end
                if isArray then
                    return fieldValue
                else
                    -- Single value, convert to array
                    return {fieldValue}
                end
            else
                -- Single value, convert to array
                return {fieldValue}
            end
        end

        -- For complex types (APLValue message fields), handle proto structure or full wrapper
        if fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "APLValue" then
            -- fieldValue might be proto structure or full wrapper
            local valueNode = nil
            if type(fieldValue) == "table" and fieldValue.type == ASTCore.NodeType.VALUE then
                -- Full wrapper
                valueNode = fieldValue
            elseif type(fieldValue) == "table" then
                -- Proto structure - reconstruct wrapper
                for valueType, valueData in pairs(fieldValue) do
                    valueNode = ASTValue.Create(valueType, valueData)
                    break
                end
            end

            if valueNode then
                if ASTValue.IsConst(valueNode) then
                    local constValue = ASTValue.GetConstValue(valueNode)
                    return constValue
                else
                    -- Complex APLValue node - return the node itself (caller will handle)
                    return valueNode
                end
            end
        end

        -- Handle ActionID/SpellReference message types - extract the actual ID
        if fieldInfo and fieldInfo.type == "message" and (fieldInfo.message_type == "ActionID" or fieldInfo.message_type == "SpellReference") then
            local extractedID = FieldFormatConverter:ExtractActionID(fieldValue)
            return extractedID
        end

        -- Handle UnitReference message types - extract the unit string or enum
        if fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "UnitReference" then
            local extractedUnit = FieldFormatConverter:ExtractUnitReferenceForDisplay(fieldValue)
            return extractedUnit
        end

        -- For simple types (enum, number, string, boolean), return raw value
        -- fieldValue should be the raw value, but handle edge case where const node was stored directly
        if type(fieldValue) == "table" and fieldValue.type == ASTCore.NodeType.VALUE and ASTValue.IsConst(fieldValue) then
            -- Const node stored directly - extract value
            return ASTValue.GetConstValue(fieldValue)
        end
        -- fieldValue is already the raw value (e.g., 2 for enum, string for variable_ref)
        return fieldValue
    end

    local function rebuildNode(metadata)
        if metadata and metadata.skipRebuild then
            return
        end
        if nodeCategory == "value" and not clause.condition then
            NAG:Trace("[Args Debug] Argument updated for comparison side node")
            return
        end

        -- Emit node text using ASTSchemaEmitter
        local ASTSchemaEmitter = ns.ASTSchemaEmitter
        local ASTCore = ns.ASTCore

        if not ASTSchemaEmitter then
            NAG:Warn("[ArgumentRenderer] ASTSchemaEmitter not available")
            return
        end

        local nodeType = node and node.type
        local emittedText = ""
        if nodeType == ASTCore.NodeType.ACTION then
            emittedText = ASTSchemaEmitter.EmitActionNode(node) or ""
            NAG:Trace("[ArgumentRenderer] ArgumentRendererEmission (nodeCategory=%s; nodeType=action; success=%s)", nodeCategory, tostring(emittedText ~= ""))
        elseif nodeType == ASTCore.NodeType.VALUE then
            emittedText = ASTSchemaEmitter.EmitValueNode(node) or ""
            NAG:Trace("[ArgumentRenderer] ArgumentRendererEmission (nodeCategory=%s; nodeType=value; success=%s)", nodeCategory, tostring(emittedText ~= ""))
        else
            NAG:Warn("[ArgumentRenderer] Invalid node type: %s (nodeCategory=%s)", tostring(nodeType), nodeCategory)
            return
        end

        -- Update argumentsText for display if needed
        if node.argumentsText and emittedText ~= "" then
            local argsMatch = emittedText:match("%((.*)%)")
            node.argumentsText = argsMatch or ""
        end
    end

    -- Helper: Set full argument node (message/complex values)
    local function setArgNode(index, valueNode, metadata)
        if not schema or not schema.field_order or not schema.field_order[index] then
            NAG:Warn(format("[setArgNode] No field_order[%d] in schema", index))
            return
        end

        local fieldName = schema.field_order[index]
        local fieldInfo = schema.fields[fieldName]

        -- Get or ensure proto data structure exists
        local protoData, nodeType = EnsureProtoData(node, nodeCategory)
        if not protoData then
            NAG:Warn(format("[setArgNode] Failed to get protoData for field %s (nodeCategory=%s)", fieldName, nodeCategory))
            return
        end

        -- Handle repeated fields - store array directly
        if fieldInfo and fieldInfo.label == "repeated" then
            -- For repeated fields, valueNode might be an array or a single const node
            -- If it's a table (array), store it directly
            if type(valueNode) == "table" then
                -- Check if it's an array (ipairs-able)
                local isArray = false
                for _ in ipairs(valueNode) do
                    isArray = true
                    break
                end
                if isArray then
                    -- It's an array, store directly
                    protoData[fieldName] = valueNode
                elseif valueNode.type == ASTCore.NodeType.VALUE and ASTValue.IsConst(valueNode) then
                    -- Single const node, extract value and store as single-element array
                    local rawValue = ASTValue.GetConstValue(valueNode)
                    protoData[fieldName] = {rawValue}
                else
                    -- Single value, store as single-element array
                    protoData[fieldName] = {valueNode}
                end
            elseif valueNode == nil then
                protoData[fieldName] = {}
            else
                -- Single value, store as single-element array
                protoData[fieldName] = {valueNode}
            end

            -- Trigger rebuild for repeated fields
            if not (metadata and metadata.skipRebuild) then
                rebuildNode(metadata)
                local EditorUtils = ns.RotationEditorEditorUtils
                if EditorUtils then
                    EditorUtils.MarkDirty(editorState)
                end
            end
            return
        end

        if valueNode == nil then
            protoData[fieldName] = nil
        else
            -- Determine if this is a complex type (APLValue) or simple type (enum/primitive)
            local isComplexType = fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "APLValue"

            if isComplexType then
                -- Convert full AST wrapper to proto-compatible structure
                local valueType = ASTValue.GetValueType(valueNode)
                local valueData = ASTValue.GetValueData(valueNode)
                if valueType and valueData then
                    local protoStructure = {}
                    protoStructure[valueType] = valueData
                    protoData[fieldName] = protoStructure
                else
                    -- Fallback: store full node if conversion fails
                    protoData[fieldName] = valueNode
                end
            else
                -- For simple types, extract raw value from proto AST const node
                local rawValue = nil
                if valueNode.type == ASTCore.NodeType.VALUE and ASTValue.IsConst(valueNode) then
                    rawValue = ASTValue.GetConstValue(valueNode)
                elseif type(valueNode) == "number" or type(valueNode) == "string" or type(valueNode) == "boolean" then
                    rawValue = valueNode
                else
                    NAG:Debug(format("[setArgNode] Unexpected valueNode type for simple field %s, attempting to extract value", fieldName))
                    rawValue = valueNode
                end

                -- Use FieldFormatConverter:ToProto() for schema-aware normalization
                local FieldFormatConverter = ns.FieldFormatConverter
                if FieldFormatConverter and fieldInfo then
                    protoData[fieldName] = FieldFormatConverter:ToProto(rawValue, fieldInfo)
                else
                    protoData[fieldName] = rawValue
                end
            end
        end

        if metadata and metadata.skipRebuild then
            return
        end

        local NodeEditors = ns.RotationEditorNodeEditors
        if NodeEditors and NodeEditors.ClearCachedNodeDetails and clauseIdx then
            NodeEditors:ClearCachedNodeDetails(editorState, clauseIdx)
        end

        rebuildNode(metadata)
        EditorUtils.MarkDirty(editorState)

        -- Rebuild condition from AST to persist changes to stored AST
        if nodeCategory == "value" and clause and clause.condition then
            if NodeEditors and NodeEditors.RebuildConditionFromAST and clauseIdx then
                NodeEditors:RebuildConditionFromAST(clause, clauseIdx, editorState)
            end
        elseif nodeCategory == "action" then
            -- For actions, sync to canonical storage
            if NodeEditors and NodeEditors.SyncActionToCanonicalStorage and clauseIdx then
                NodeEditors:SyncActionToCanonicalStorage(clause, clauseIdx, editorState)
            end
        end

        -- Preserve current selection BEFORE RefreshASTTree (which may clear it)
        local GetClauseEditorData = function(editorState, clauseIdx)
            return EditorUtils.GetClauseEditorData(editorState, clauseIdx)
        end

        local PreserveCurrentSelection = function(editorState, clauseIdx)
            local editorData = GetClauseEditorData(editorState, clauseIdx)
            if not editorData or not editorData.astTreeGroup then
                return nil
            end
            local astTreeGroup = editorData.astTreeGroup
            return astTreeGroup.selected or editorData.lastSelection
        end

        local currentSelection = PreserveCurrentSelection(editorState, clauseIdx)

        -- Store as pendingSelection so RefreshASTTree can use it
        local editorData = GetClauseEditorData(editorState, clauseIdx)
        if editorData then
            -- Guard: Skip refresh if already refreshing to prevent cascading updates
            if editorData._refreshing then
                return
            end
            if currentSelection then
                editorData.pendingSelection = currentSelection
            end
        end

        -- Refresh the AST tree to show updated values
        -- RefreshASTTree already handles reselection internally, so we don't need to call ReselectNode again
        -- Calling ReselectNode here causes a loop: RefreshASTTree -> ReselectNode -> OnGroupSelected -> RenderNodeEditPanel -> RefreshASTTree
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor and editorData and not editorData._refreshing then
            ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
        end
    end

    -- Helper: Set argument value by index
    local function setArgValue(index, value, fieldName)
        local fieldInfo = schema and schema.fields and schema.field_order and schema.fields[schema.field_order[index]]

        -- Handle repeated fields - store array directly
        if fieldInfo and fieldInfo.label == "repeated" then
            -- For repeated fields, value should be an array
            if type(value) == "table" then
                -- Check if it's an array (ipairs-able)
                local isArray = false
                for _ in ipairs(value) do
                    isArray = true
                    break
                end
                if isArray then
                    -- It's an array, store directly via setArgNode
                    setArgNode(index, value, { skipRebuild = false })
                    return
                end
            end
            -- Single value, convert to array
            setArgNode(index, {value}, { skipRebuild = false })
            return
        end

        -- For non-repeated fields, create proto AST constant node
        local ASTValue = ns.ASTValue
        local newConstNode = ASTValue.CreateConst(value)

        setArgNode(index, newConstNode, { skipRebuild = false })
    end

    return getArgValue, setArgValue, getArgNode, setArgNode, rebuildNode
end

--- Create nested argument accessors for nested message types
--- @param parentGetArgValue function Parent getter function
--- @param parentSetArgValue function Parent setter function
--- @param parentGetArgNode function Parent node getter function
--- @param parentSetArgNode function Parent node setter function
--- @param parentRebuildNode function Parent rebuild function
--- @param fieldName string The nested field name
--- @param nestedSchema table The schema for the nested message type
--- @param node table The AST node
--- @param nodeCategory string "value" or "action"
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state
--- @return function Getter function for nested field values
--- @return function Setter function for nested field values
--- @return function Getter function for nested field nodes
--- @return function Setter function for nested field nodes
--- @return function Rebuild function
function ArgumentRenderer:CreateNestedArgumentAccessors(parentGetArgValue, parentSetArgValue, parentGetArgNode, parentSetArgNode, parentRebuildNode, fieldName, nestedSchema, node, nodeCategory, clause, clauseIdx, editorState)

    -- Helper: Get nested field value by index
    local function getNestedArgValue(index)
        -- parentGetArgValue() already returns the nested table (e.g., protoData["options"])
        -- So we read directly from it, not from parentValue[fieldName]
        local nestedValue = parentGetArgValue()
        if not nestedValue or type(nestedValue) ~= "table" then
            NAG:Debug(format("[getNestedArgValue] parentGetArgValue returned nil or non-table for field '%s'", fieldName))
            return nil
        end
        local nestedFieldName = nestedSchema.field_order and nestedSchema.field_order[index]
        if nestedFieldName then
            local value = nestedValue[nestedFieldName]
            NAG:Debug(format("[getNestedArgValue] Retrieved field '%s.%s' = %s (type=%s)", fieldName, nestedFieldName, tostring(value), type(value)))
            return value
        end
        return nil
    end

    -- Helper: Set nested field value by index
    local function setNestedArgValue(index, value, nestedFieldName)
        -- parentGetArgValue() already returns the nested table (e.g., protoData["options"])
        -- So we modify it directly, not through parentValue[fieldName]
        local nestedValue = parentGetArgValue()
        if not nestedValue or type(nestedValue) ~= "table" then
            nestedValue = {}
            parentSetArgValue(nestedValue)
        end
        local fieldToSet = nestedFieldName or (nestedSchema.field_order and nestedSchema.field_order[index])
        if fieldToSet then
            nestedValue[fieldToSet] = value
            parentSetArgValue(nestedValue)
            NAG:Debug(format("[setNestedArgValue] Set field '%s.%s' = %s (type=%s)", fieldName, fieldToSet, tostring(value), type(value)))
        end
    end

    -- Helper: Get nested field node by index
    local function getNestedArgNode(index)
        local parentNode = parentGetArgNode()
        if not parentNode then
            return nil
        end
        -- For nested messages, we work with the table structure directly
        -- The node structure may have the nested data in protoData format
        local ASTCore = ns.ASTCore
        local ASTAction = ns.ASTAction
        local ASTValue = ns.ASTValue

        local protoData = nil
        if nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
            protoData = ASTAction.GetActionData(node)
        elseif nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
            protoData = ASTValue.GetValueData(node)
        end

        if protoData and protoData[fieldName] then
            local nestedData = protoData[fieldName]
            local nestedFieldName = nestedSchema.field_order and nestedSchema.field_order[index]
            if nestedFieldName and nestedData[nestedFieldName] ~= nil then
                -- Create a constant node for the nested field value
                local ASTValue = ns.ASTValue
                return ASTValue.CreateConst(nestedData[nestedFieldName])
            end
        end
        return nil
    end

    -- Helper: Set nested field node by index
    local function setNestedArgNode(index, valueNode, metadata)
        local ASTCore = ns.ASTCore
        local ASTValue = ns.ASTValue

        -- Get or ensure proto data structure exists
        local protoData = nil
        if nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
            local ASTAction = ns.ASTAction
            protoData = ASTAction.GetActionData(node)
            if not protoData then
                protoData = {}
                ASTAction.SetActionData(node, protoData)
            end
        elseif nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
            protoData = ASTValue.GetValueData(node)
            if not protoData then
                protoData = {}
                ASTValue.SetValueData(node, protoData)
            end
        end

        if not protoData then
            NAG:Warn(format("[setNestedArgNode] Failed to get protoData for nested field %s.%s", fieldName, tostring(nestedSchema.field_order and nestedSchema.field_order[index])))
            return
        end

        -- Ensure nested structure exists
        if not protoData[fieldName] or type(protoData[fieldName]) ~= "table" then
            protoData[fieldName] = {}
        end

        local nestedData = protoData[fieldName]
        local nestedFieldName = nestedSchema.field_order and nestedSchema.field_order[index]

        if valueNode == nil then
            if nestedFieldName then
                nestedData[nestedFieldName] = nil
            end
        else
            -- Extract raw value from node
            local rawValue = nil
            if valueNode.type == ASTCore.NodeType.VALUE and ASTValue.IsConst(valueNode) then
                rawValue = ASTValue.GetConstValue(valueNode)
            elseif type(valueNode) == "number" or type(valueNode) == "string" or type(valueNode) == "boolean" then
                rawValue = valueNode
            elseif type(valueNode) == "table" then
                -- For nested message types, store the table structure directly
                rawValue = valueNode
            else
                NAG:Debug(format("[setNestedArgNode] Unexpected valueNode type for nested field %s.%s", fieldName, tostring(nestedFieldName)))
                rawValue = valueNode
            end

            if nestedFieldName then
                nestedData[nestedFieldName] = rawValue
            end
        end

        -- If we used parent getter, update via parent setter
        if parentGetArgValue and type(parentGetArgValue) == "function" and parentSetArgValue and type(parentSetArgValue) == "function" then
            parentSetArgValue(nestedData)
        end

        if not (metadata and metadata.skipRebuild) then
            parentRebuildNode(metadata)
            local EditorUtils = ns.RotationEditorEditorUtils
            if EditorUtils then
                EditorUtils.MarkDirty(editorState)
            end
        end
    end

    return getNestedArgValue, setNestedArgValue, getNestedArgNode, setNestedArgNode, parentRebuildNode
end

--- Render argument fields based on schema
--- @param container table Container widget
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
--- @param nodeCategory string "value" or "action"
function ArgumentRenderer:RenderArgumentFields(container, node, clause, clauseIdx, editorState, nodeCategory)
    local SchemaValidator = NAG:GetModule("SchemaValidator")
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    -- Determine identifier candidates
    -- Use proto AST structure directly - no fallbacks needed
    local identifiers = {}
    local ASTAction = ns.ASTAction
    local ASTValue = ns.ASTValue
    local ASTCore = ns.ASTCore

    if nodeCategory == "action" then
        -- Use GetActionType for proto AST action nodes
        if node.type == ASTCore.NodeType.ACTION then
            local actionType = ASTAction.GetActionType(node)
            if actionType then
                identifiers[#identifiers + 1] = actionType
            end
        end
    else
        -- Value nodes: use GetValueType for proto AST value nodes
        if node.type == ASTCore.NodeType.VALUE then
            local valueType = ASTValue.GetValueType(node)
            if valueType then
                identifiers[#identifiers + 1] = valueType
            end
        end
    end

    local schema
    local metadata
    local schemaName
    local normalizedName
    for _, candidate in ipairs(identifiers) do
        if candidate and candidate ~= "" then
            schemaName = candidate
            -- Normalize to snake_case (schema format)
            local SchemaUtils = NAG:GetModule("SchemaUtils")
            local snakeName = SchemaUtils and SchemaUtils:CamelToSnake(candidate) or candidate
            -- Validate snake_case format
            if not snakeName:match("^[a-z][a-z0-9_]*$") then
                -- Try additional normalization
                if candidate:match("^APLAction(.+)$") or candidate:match("^APLValue(.+)$") then
                    local suffix = candidate:match("^APL(?:Action|Value)(.+)$")
                    snakeName = SchemaUtils and SchemaUtils:CamelToSnake(suffix) or suffix
                end
            end

            if nodeCategory == "action" then
                -- Use SchemaAccessor with strict snake_case lookup
                if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier and snakeName:match("^[a-z][a-z0-9_]*$") then
                    metadata = SchemaAccessor:GetMetadataByIdentifier(snakeName, nil)
                    if metadata then
                        -- Use metadata.messageSchema directly (already provided by GetMetadataByIdentifier)
                        if metadata and not metadata.messageSchema then
                            SchemaAccessor:Warn("[RenderArgumentFields] messageSchema missing in metadata for protoName '%s' (identifier: %s) - schema may be incomplete",
                                metadata.protoName, snakeName)
                        end
                        schema = {
                            fields = metadata.messageSchema and metadata.messageSchema.fields or {},
                            field_order = metadata.messageSchema and metadata.messageSchema.field_order or {},
                            label = metadata.label
                        }
                        normalizedName = metadata.actionType
                        break
                    end
                end
            elseif nodeCategory ~= "action" then
                -- Use SchemaAccessor with strict snake_case lookup
                if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier and snakeName:match("^[a-z][a-z0-9_]*$") then
                    metadata = SchemaAccessor:GetMetadataByIdentifier(snakeName, nil)
                    if metadata then
                        -- Use metadata.messageSchema directly (already provided by GetMetadataByIdentifier)
                        if metadata and not metadata.messageSchema then
                            SchemaAccessor:Warn("[RenderArgumentFields] messageSchema missing in metadata for protoName '%s' (identifier: %s) - schema may be incomplete",
                                metadata.protoName, snakeName)
                        end
                        schema = {
                            fields = metadata.messageSchema and metadata.messageSchema.fields or {},
                            field_order = metadata.messageSchema and metadata.messageSchema.field_order or {},
                            label = metadata.label
                        }
                        normalizedName = metadata.valueType
                        break
                    end
                end
            end
        end
    end

    -- Schema metadata is required - fail fast if missing
    if not schema then
        local actionType = nodeCategory == "action" and (ASTAction.GetActionType(node) or (node and node.actionType)) or nil
        local valueType = nodeCategory ~= "action" and ASTValue.GetValueType(node) or nil
        local identifier = actionType or valueType
        NAG:Error(format("[ArgumentRenderer] Schema metadata required but missing (nodeCategory=%s; identifier=%s; nodeType=%s)",
            nodeCategory, tostring(identifier), tostring(node and node.type)))
        return
    end

    if not schema.fields or not next(schema.fields) then
        -- No fields - show info
        NAG:Info("[ArgumentRenderer] Schema metadata missing editable fields (nodeCategory=%s; normalizedName=%s; schemaName=%s)", nodeCategory, tostring(normalizedName), tostring(schemaName))
        local noFieldsLabel = Libs.AceGUI:Create("Label")
        noFieldsLabel:SetText("|cFF888888No editable arguments for this " .. nodeCategory .. "|r")
        noFieldsLabel:SetFullWidth(true)
        container:AddChild(noFieldsLabel)
        return
    end

    -- Arguments section header
    local argsHeader = Libs.AceGUI:Create("Heading")
    argsHeader:SetText("Arguments")
    argsHeader:SetFullWidth(true)
    container:AddChild(argsHeader)

    -- Note: Parser issue check removed - protoData is not in scope here

    -- Create argument accessors using factory function
    local getArgValue, setArgValue, getArgNode, setArgNode, rebuildNode =
        self:CreateArgumentAccessors(node, nodeCategory, schema, clause, clauseIdx, editorState)

    -- Render field for each schema field in order
    local fieldOrder = schema.field_order or {}

    for argIndex, fieldName in ipairs(fieldOrder) do
        if fieldName ~= "field_order" then
            local fieldDef = schema.fields[fieldName]
            if fieldDef then
                self:RenderArgumentField(container, node, clause, clauseIdx, editorState, fieldName, fieldDef, argIndex,
                    setArgValue, getArgValue, setArgNode, getArgNode, 0, nodeCategory, metadata and metadata.messageSchema or nil)
            else
                NAG:Warn("[ArgumentRenderer] Schema field definition missing (fieldName=%s; nodeCategory=%s; schemaName=%s)", fieldName, nodeCategory, tostring(schemaName))
            end
        end
    end
end

--- Render a single argument field based on its schema definition
--- @param container table Container widget
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
--- @param fieldName string Field name
--- @param fieldDef table Field definition from schema
--- @param argIndex number Argument index (1-based)
--- @param setArgValue function Setter function
--- @param getArgValue function Getter function
--- @param setArgNode function Setter function for nodes
--- @param getArgNode function Getter function for nodes
--- @param depth number|nil Recursion depth (to prevent infinite loops)
--- @param nodeCategory string "value" or "action"
--- @param messageSchema table|nil Full message schema with _metadata (for accessing defaults)
function ArgumentRenderer:RenderArgumentField(container, node, clause, clauseIdx, editorState, fieldName, fieldDef,
                                              argIndex, setArgValue, getArgValue, setArgNode, getArgNode, depth,
                                              nodeCategory, messageSchema)
    if not fieldName or not fieldDef then
        return
    end

    container = container or { AddChild = function() end }
    node = node or {}
    clause = clause or {}
    editorState = editorState or {}
    setArgValue = type(setArgValue) == "function" and setArgValue or function() end
    getArgValue = type(getArgValue) == "function" and getArgValue or function() return nil end
    local hasSetArgNode = type(setArgNode) == "function"
    local hasGetArgNode = type(getArgNode) == "function"
    if not hasSetArgNode then
        setArgNode = nil
    end
    if not hasGetArgNode then
        getArgNode = nil
    end

    if fieldDef == nil and type(node) == "table" and node.name and node.type and type(clauseIdx) == "function" then
        -- Legacy format detection - fail fast
        NAG:Warn(format("[ArgumentRenderer] Legacy format detected - proto AST required. Node has legacy structure (name=%s, type=%s)",
            tostring(node.name), tostring(node.type)))
        return
    end

    depth = depth or 0
    nodeCategory = nodeCategory or "value"

    -- Prevent infinite recursion
    -- Allow depth up to 4 to handle deeply nested message types
    if depth > 4 then
        NAG:Warn("[ArgumentRenderer] Argument renderer recursion depth exceeded (fieldName=%s; depth=%d; fieldType=%s)", fieldName, depth, tostring(fieldDef.type))
        return
    end

    -- Get field information from schema
    local fieldInfo = GetSchemaFieldInfo(messageSchema, fieldName)
    local fieldType = (fieldInfo and fieldInfo.fieldType) or fieldDef.type
    local enumTypeName = (fieldInfo and fieldInfo.enumTypeName) or (fieldDef.enum_type or fieldDef.enumType or fieldDef.enumTypeName)
    local hasEnum = enumTypeName ~= nil or (fieldDef.enum ~= nil)
    local messageType = (fieldInfo and fieldInfo.messageType) or fieldDef.message_type
    local fieldLabel = (fieldInfo and fieldInfo.fieldLabel) or fieldDef.label

    local currentValue = getArgValue(argIndex)

    -- Handle repeated fields (arrays/lists) - must check before message type handling
    if fieldLabel == "repeated" then
        self:RenderRepeatedField(container, fieldName, fieldDef, currentValue, argIndex, setArgValue, getArgValue, setArgNode, getArgNode, node, clause, clauseIdx, editorState, nodeCategory, messageSchema, fieldInfo)
        return
    end

    -- Handle message type fields with special editors (prevent infinite recursion)
    if fieldType == "message" then

        -- Handle ActionID message type (spell/item ID)
        if messageType == "ActionID" or messageType == "SpellReference" then
            self:RenderSpellField(container, fieldName, currentValue, argIndex, setArgValue, node, clause, clauseIdx, editorState, messageType or nodeCategory, fieldDef, messageSchema)
            return

            -- Handle UnitReference message type (unit dropdown)
        elseif messageType == "UnitReference" then
            -- Get UnitReference message schema to access the 'type' field definition
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            local unitRefSchema = nil
            if SchemaAccessor then
                unitRefSchema = SchemaAccessor:GetMessageSchema("UnitReference")
            end

            -- Get enum values from schema
            local enumValues, enumType = nil, nil
            if unitRefSchema then
                local typeFieldInfo = GetSchemaFieldInfo(unitRefSchema, "type")
                if typeFieldInfo then
                    enumValues = typeFieldInfo.enumValues
                    enumType = typeFieldInfo.enumType
                end
            end

            if enumValues and next(enumValues) and enumType then
                -- Render as dropdown
                local dropdown = Libs.AceGUI:Create("Dropdown")
                dropdown:SetLabel(fieldName .. " (Unit)")
                dropdown:SetFullWidth(true)

                -- Build dropdown list
                local enumList = {}
                local enumOrder = {}
                for enumKey, enumValue in pairs(enumValues) do
                    tinsert(enumOrder, enumKey)
                    -- Display the enum key name (e.g., "Self", "Player", "Target")
                    enumList[enumKey] = enumKey
                end
                sort(enumOrder)
                dropdown:SetList(enumList, enumOrder)

                -- Get current value and find matching enum key
                local selectedKey = nil
                local currentEnumValue = nil

                if currentValue then
                    -- Extract enum value from currentValue (could be string, number, or UnitReference structure)
                    local extractedUnit = FieldFormatConverter:ExtractUnitReference(currentValue)
                    -- If it's a string enum name, convert to number for dropdown
                    if type(extractedUnit) == "string" and enumType and enumType.GetValues then
                        currentEnumValue = enumType:GetValues()[extractedUnit]
                    else
                        currentEnumValue = extractedUnit
                    end

                    -- Find matching enum key using enumType
                    if currentEnumValue ~= nil then
                        if enumType and enumType.GetNameByValue then
                            selectedKey = enumType:GetNameByValue(currentEnumValue)
                        end
                        if not selectedKey then
                            for key, val in pairs(enumValues) do
                                if val == currentEnumValue then
                                    selectedKey = key
                                    break
                                end
                            end
                        end
                    end
                end

                -- Get effective default value from schema
                local effectiveDefault = GetEffectiveDefaultValue(messageSchema, fieldName, "enum")
                local defaultValue = 0  -- Proto3 default (Unknown)
                local defaultKey = nil
                if effectiveDefault then
                    if type(effectiveDefault) == "table" and effectiveDefault.type then
                        defaultValue = effectiveDefault.type
                    elseif type(effectiveDefault) == "number" then
                        defaultValue = effectiveDefault
                    end
                end

                -- Find default key using enumType
                if not selectedKey and defaultValue ~= 0 then
                    if enumType and enumType.GetNameByValue then
                        defaultKey = enumType:GetNameByValue(defaultValue)
                    end
                    if not defaultKey then
                        for key, val in pairs(enumValues) do
                            if val == defaultValue then
                                defaultKey = key
                                break
                            end
                        end
                    end
                end

                -- Set dropdown value (only if not Unknown/default)
                if selectedKey then
                    dropdown:SetValue(selectedKey)
                elseif defaultKey then
                    dropdown:SetValue(defaultKey)
                end

                -- Handle selection change
                dropdown:SetCallback("OnValueChanged", function(widget, event, key)
                    local enumID = enumValues[key]
                    if enumID ~= nil then
                        -- Create UnitReference structure
                        local unitRef = { type = enumID }
                        setArgValue(argIndex, unitRef, fieldName)
                    else
                        NAG:Debug(format("[UnitReference Dropdown] Enum value missing for key: %s", tostring(key)))
                    end
                end)

                container:AddChild(dropdown)
            else
                -- Fallback to EditBox if enum values not available
                local unitEdit = Libs.AceGUI:Create("EditBox")
                unitEdit:SetLabel(fieldName .. " (Unit)")
                unitEdit:SetFullWidth(true)

                local displayValue = ""
                if currentValue then
                    displayValue = tostring(currentValue)
                end

                unitEdit:SetText(displayValue)
                unitEdit:SetCallback("OnEnterPressed", function(widget, event, text)
                    -- Normalize the text to UnitReference structure using schema-aware conversion
                    local unitRef = nil
                    if FieldFormatConverter then
                        -- Use ToProto() if fieldInfo is available, otherwise use NormalizeUnitReference
                        if fieldInfo then
                            unitRef = FieldFormatConverter:ToProto(text, fieldInfo)
                        else
                            -- FALLBACK TRACKING: Using deprecated NormalizeUnitReference() - fieldInfo should be available
                            NAG:Error("[ArgumentRenderer] FALLBACK PATTERN DETECTED: Using NormalizeUnitReference() fallback (fieldInfo unavailable). Location: RenderUnitReferenceField fallback EditBox. fieldName=%s, argIndex=%d", tostring(fieldName), tostring(argIndex))
                            unitRef = FieldFormatConverter:NormalizeUnitReference(text)
                        end
                    end
                    if unitRef then
                        setArgValue(argIndex, unitRef, fieldName)
                    else
                        -- NormalizeUnitReference returns nil for invalid input - use default
                        setArgValue(argIndex, { type = 0 }, fieldName)
                    end
                end)
                container:AddChild(unitEdit)
            end
            return

        elseif messageType == "APLValue" or (type(messageType) == "string" and messageType:find("^APLValue")) then
            if hasSetArgNode and hasGetArgNode then
                self:RenderAPLValueMessageField(container, node, clause, clauseIdx, editorState, fieldName, argIndex, setArgNode, getArgNode)
            else
                NAG:Warn("[ArgumentRenderer] APLValue field cannot be rendered without accessors (fieldName=%s; messageType=%s)", fieldName, tostring(messageType))
            end
            return

        -- Handle nested message types (recursive rendering)
        else
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            if SchemaAccessor then
                local nestedSchema = SchemaAccessor:GetMessageSchema(messageType)
                if nestedSchema and nestedSchema.fields and next(nestedSchema.fields) then
                    -- Check depth limit to prevent infinite recursion
                    -- Allow depth up to 4 to handle: OverlayText -> options -> background -> color
                    if depth >= 4 then
                        NAG:Warn("[ArgumentRenderer] Nested message type depth limit reached (fieldName=%s; messageType=%s; depth=%d)", fieldName, tostring(messageType), depth)
                        return
                    end

                    -- Create collapsible group for nested message
                    local nestedGroup = Libs.AceGUI:Create("InlineGroup")
                    nestedGroup:SetTitle(fieldName .. " (" .. (nestedSchema._metadata and nestedSchema._metadata.ui_label or messageType) .. ")")
                    nestedGroup:SetFullWidth(true)
                    nestedGroup:SetLayout("List")
                    container:AddChild(nestedGroup)

                    -- Get current nested value from node structure
                    local ASTCore = ns.ASTCore
                    local ASTAction = ns.ASTAction
                    local ASTValue = ns.ASTValue

                    -- CRITICAL: Always read directly from protoData to avoid calling getArgValue which causes recursion
                    -- Don't call getArgValue(argIndex) here - it triggers infinite recursion
                    local currentNestedValue = nil
                    do
                        -- Top-level field - read directly from protoData
                        local protoData = nil
                        if nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
                            protoData = ASTAction.GetActionData(node)
                        elseif nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
                            protoData = ASTValue.GetValueData(node)
                        end

                        -- DEBUG: Log protoData structure for OverlayText
                        if fieldName == "options" and messageType == "OverlayTextOptions" then
                            NAG:Warn("[ArgumentRenderer] Rendering 'options' field - protoData keys: %s",
                                protoData and table.concat(TableUtils.Keys(protoData or {}), ", ") or "nil")
                            if protoData and protoData.font_color then
                                NAG:Error("[ArgumentRenderer] CRITICAL - font_color found at action level in protoData! Should only be in options!")
                            end
                            if protoData and protoData.options then
                                NAG:Debug("[ArgumentRenderer] protoData.options keys: %s",
                                    table.concat(TableUtils.Keys(protoData.options or {}), ", "))
                            end
                        end

                        -- Initialize nested value if nil (only for top-level fields)
                        if not protoData then
                            protoData = {}
                            if nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
                                ASTAction.SetActionData(node, protoData)
                            elseif nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
                                ASTValue.SetValueData(node, protoData)
                            end
                        end

                        if not protoData[fieldName] or type(protoData[fieldName]) ~= "table" then
                            protoData[fieldName] = {}
                        end

                        currentNestedValue = protoData[fieldName]
                    end

                    -- Create nested argument accessors
                    -- parentGetArgValue should return the nested table (e.g., protoData["options"])
                    -- If we're already in a nested context (getArgValue is provided), use it to get the nested table
                    -- Otherwise, read directly from protoData[fieldName]
                    -- CRITICAL: Cache the parentGetArgValue result to prevent infinite recursion
                    -- Read directly from protoData first, only use getArgValue as fallback
                    local cachedParentValue = nil
                    local parentGetArgValueCached = function()
                        if cachedParentValue == nil then
                            -- Always read directly from protoData first to avoid triggering getArgValue
                            local pd = nil
                            if nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
                                pd = ASTAction.GetActionData(node)
                            elseif nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
                                pd = ASTValue.GetValueData(node)
                            end
                            cachedParentValue = pd and pd[fieldName]

                            -- If field doesn't exist in protoData, create empty table (don't call getArgValue to avoid recursion)
                            if not cachedParentValue or type(cachedParentValue) ~= "table" then
                                cachedParentValue = {}
                            end
                        end
                        return cachedParentValue
                    end

                    local getNestedArgValue, setNestedArgValue, getNestedArgNode, setNestedArgNode, rebuildNestedNode =
                        self:CreateNestedArgumentAccessors(
                            parentGetArgValueCached,
                            function(val)
                                -- Update cached value when setting
                                cachedParentValue = val

                                -- If we have a parent setArgValue (we're in a nested context), use it to set the current field's value
                                -- Otherwise, write directly to protoData
                                if setArgValue and type(setArgValue) == "function" then
                                    -- We're in a nested context - setArgValue(argIndex, val) sets the nested table for this field
                                    NAG:Debug(format("[CreateNestedArgumentAccessors] Using parent setArgValue for field '%s'", fieldName))
                                    setArgValue(argIndex, val)
                                else
                                    -- Top-level field - write directly to protoData
                                    local pd = nil
                                    if nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
                                        pd = ASTAction.GetActionData(node)
                                        if not pd then
                                            pd = {}
                                            ASTAction.SetActionData(node, pd)
                                        end
                                    elseif nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
                                        pd = ASTValue.GetValueData(node)
                                        if not pd then
                                            pd = {}
                                            ASTValue.SetValueData(node, pd)
                                        end
                                    end
                                    if pd then
                                        pd[fieldName] = val
                                        -- Update via setArgNode to ensure proper proto structure
                                        -- This ensures the nested message is stored correctly
                                        if hasSetArgNode then
                                            setArgNode(argIndex, pd[fieldName], { skipRebuild = false })
                                        end
                                    end
                                end
                            end,
                            getArgNode,
                            setArgNode,
                            function(metadata)
                                -- Trigger parent rebuild
                                if hasSetArgNode then
                                    local pd = nil
                                    if nodeCategory == "action" and node.type == ASTCore.NodeType.ACTION then
                                        pd = ASTAction.GetActionData(node)
                                    elseif nodeCategory == "value" and node.type == ASTCore.NodeType.VALUE then
                                        pd = ASTValue.GetValueData(node)
                                    end
                                    if pd and pd[fieldName] then
                                        setArgNode(argIndex, pd[fieldName], metadata)
                                    end
                                end
                            end,
                            fieldName,
                            nestedSchema,
                            node,
                            nodeCategory,
                            clause,
                            clauseIdx,
                            editorState
                        )

                    -- Render each nested field
                    -- CRITICAL: Use nestedSchema as messageSchema to ensure GetFieldMetadata uses correct schema
                    local nestedFieldOrder = nestedSchema.field_order or {}
                    for nestedArgIndex, nestedFieldName in ipairs(nestedFieldOrder) do
                        if nestedFieldName ~= "field_order" then
                            local nestedFieldDef = nestedSchema.fields[nestedFieldName]
                            if nestedFieldDef then
                                -- Pass nestedSchema as messageSchema to ensure GetFieldMetadata uses correct schema
                                -- nestedSchema should have _metadata structure from GetMessageSchema
                                self:RenderArgumentField(
                                    nestedGroup,
                                    node,
                                    clause,
                                    clauseIdx,
                                    editorState,
                                    nestedFieldName,
                                    nestedFieldDef,
                                    nestedArgIndex,
                                    setNestedArgValue,
                                    getNestedArgValue,
                                    setNestedArgNode,
                                    getNestedArgNode,
                                    depth + 1,
                                    nodeCategory,
                                    nestedSchema  -- This should be the full message schema with _metadata
                                )
                            end
                        end
                    end

                    return
                end
            end

            -- Fallback: unhandled message type
            NAG:Warn("[ArgumentRenderer] Unhandled message type in argument renderer (fieldName=%s; messageType=%s)", fieldName, tostring(messageType))
            return
        end
    end

    -- Check if this is an enum field
    local isEnumField = (fieldType == "enum") or hasEnum

    if isEnumField then
        self:RenderEnumField(container, fieldName, fieldDef, currentValue, argIndex, setArgValue, node, clauseIdx, editorState, nodeCategory, messageSchema)
    elseif fieldType == "number" or fieldType == "integer" or fieldType == "int32" or fieldType == "int64" or fieldType == "float" or fieldType == "double" then
        -- Check if this is a spell ID field using schema metadata (schema-driven)
        local isSpellField = false
        if fieldInfo and fieldInfo.fieldMetadata then
            if fieldInfo.fieldMetadata.spell and next(fieldInfo.fieldMetadata.spell) then
                isSpellField = true
            end
        end

        -- Fallback: heuristic check for legacy support (only if no schema metadata)
        if not isSpellField then
            isSpellField = fieldName:lower():find("spell") or fieldName:lower():find("id")
        end

        if isSpellField then
            self:RenderSpellField(container, fieldName, currentValue, argIndex, setArgValue, node, clause, clauseIdx, editorState, nodeCategory, fieldDef, messageSchema)
        else
            -- Regular number field
            self:RenderNumberField(container, fieldName, currentValue, argIndex, setArgValue, fieldDef, fieldType, messageSchema)
        end
    elseif fieldType == "boolean" or fieldType == "bool" then
        self:RenderBooleanField(container, fieldName, currentValue, argIndex, setArgValue, fieldDef, fieldType, messageSchema)
    elseif fieldType == "string" then
        self:RenderStringField(container, fieldName, currentValue, argIndex, setArgValue, fieldDef, fieldType, messageSchema)
    else
        -- Complex type or unknown - render as string for now
        self:RenderComplexField(container, fieldName, fieldType, currentValue, argIndex, setArgValue, fieldDef, messageSchema)
    end
end

--- Render message field for APLValue payloads
--- @param container table
--- @param node table
--- @param clause table
--- @param clauseIdx number
--- @param editorState table
--- @param fieldName string
--- @param argIndex number
--- @param setArgNode function
--- @param getArgNode function
function ArgumentRenderer:RenderAPLValueMessageField(container, node, clause, clauseIdx, editorState, fieldName,
                                                     argIndex, setArgNode, getArgNode)
    local SchemaValidator = NAG:GetModule("SchemaValidator")
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local ASTCore = ns.ASTCore
    local ASTValue = ns.ASTValue

    -- Convert getArgNode result to proto AST value node
    local rawArg = getArgNode(argIndex)
    local valueNode
    if rawArg == nil then
        valueNode = ASTValue.CreateConst(0)
    elseif type(rawArg) == "table" and rawArg.type == ASTCore.NodeType.VALUE then
        -- Already proto AST value node
        valueNode = rawArg
    elseif type(rawArg) == "table" and ASTCore.IsNode and ASTCore.IsNode(rawArg) then
        -- Proto AST node (any type)
        valueNode = rawArg
    elseif type(rawArg) == "number" or type(rawArg) == "string" or type(rawArg) == "boolean" then
        -- Primitive - convert to proto AST constant
        valueNode = ASTValue.CreateConst(rawArg)
    elseif type(rawArg) == "table" and (rawArg.type == "constant" or rawArg.type == "function" or rawArg.type == "logical" or rawArg.type == "comparison" or rawArg.type == "math") then
        -- Legacy format detected - should not happen in production code
        NAG:Warn(format("[ArgumentRenderer] Legacy format node detected - should be proto AST. Type: %s", tostring(rawArg.type)))
        -- Fail fast: create error constant instead of attempting fallback conversion
        valueNode = ASTValue.CreateConst(0)
    else
        -- Unknown format - create default constant
        valueNode = ASTValue.CreateConst(0)
    end

    -- Helper: Check if valueNode is a constant in proto AST
    local function isConstant(node)
        if not node or not ASTValue then return false end
        if node.type == ASTCore.NodeType.VALUE then
            return ASTValue.GetValueType(node) == ASTValue.ValueType.CONST
        end
        -- Legacy format detected - should not happen in production code
        if node.type == "constant" then
            NAG:Warn(format("[ArgumentRenderer] Legacy format detected in isConstant: node.type == 'constant'. Node should be proto AST with type == ASTCore.NodeType.VALUE. Node: %s", tostring(node)))
            -- Fail fast: return false for legacy format instead of attempting fallback
            return false
        end
        return false
    end

    -- Helper: Get constant value from proto AST or legacy format
    local function getConstantValue(node)
        if not node then return 0 end
        if node.type == ASTCore.NodeType.VALUE and ASTValue then
            local valueType = ASTValue.GetValueType(node)
            if valueType == ASTValue.ValueType.CONST then
                local valueData = ASTValue.GetValueData(node)
                if valueData and valueData.val then
                    local num = tonumber(valueData.val)
                    return num or valueData.val
                end
            end
        end
        -- Legacy format detected - should not happen in production code
        if node.value ~= nil then
            NAG:Warn(format("[ArgumentRenderer] Legacy format detected in getConstantValue: accessing node.value directly. Node should be proto AST with type == ASTCore.NodeType.VALUE. Node: %s", tostring(node)))
            -- Fail fast: return 0 for legacy format instead of attempting fallback
        end
        return 0
    end

    local valueMetadata = {}
    local valueOrder = {}
    local allValues
    if SchemaAccessor and SchemaAccessor.GetAllValuesWithMetadata then
        allValues = SchemaAccessor:GetAllValuesWithMetadata()
    else
        allValues = {}
    end

    for _, valueData in ipairs(allValues or {}) do
        -- GetAllValuesWithMetadata returns both 'name' and 'valueType' fields
        local key = valueData.name
        if not key then
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            if SchemaAccessor then
                SchemaAccessor:Warn("RenderValueDropdown: Missing required field 'name' for value - schema may be incomplete")
            end
        end
        if key and key ~= "" then
            local display = valueData.ui_label
            if not display then
                display = valueData.nagFunctionName or valueData.nagName
                if not display then
                    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
                    if SchemaAccessor then
                        SchemaAccessor:Warn("RenderValueDropdown: Missing ui_label, nagFunctionName, and nagName for value '%s' - schema may be incomplete", tostring(key))
                    end
                end
            end
            if (not display or display == "") then
                local SchemaUtils = NAG:GetModule("SchemaUtils")
                display = SchemaUtils and SchemaUtils:SnakeToPascal(key) or nil
            end
            display = display or key
            valueMetadata[key] = {
                display = display,
                data = valueData
            }
            valueOrder[#valueOrder + 1] = key
        end
    end
    table.sort(valueOrder, function(a, b)
        local displayA = valueMetadata[a].display:lower()
        local displayB = valueMetadata[b].display:lower()
        if displayA == displayB then
            return a < b
        end
        return displayA < displayB
    end)

    local function applyValueNode(newNode, skipRebuild)
        valueNode = newNode
        -- For proto AST function values, ensure arguments exist
        if valueNode.type == ASTCore.NodeType.VALUE and ASTValue then
            local valueType = ASTValue.GetValueType(valueNode)
            if valueType and valueType ~= ASTValue.ValueType.CONST then
                -- Function value - ensure value data exists
                local valueData = ASTValue.GetValueData(valueNode)
                if not valueData then
                    valueNode.value[valueType] = {}
                end
            end
        elseif valueNode.type == "function" then
            -- Legacy format detected - should not exist in proto AST
            self:Error("Legacy format detected in setArgNode: valueNode.type == 'function'. Node should be proto AST with type == ASTCore.NodeType.VALUE. valueNode: %s", tostring(valueNode))
            return
        end
        setArgNode(argIndex, valueNode, { skipRebuild = skipRebuild })
    end

    applyValueNode(valueNode, true)

    local group = Libs.AceGUI:Create("InlineGroup")
    group:SetTitle(fieldName .. " (APLValue)")
    group:SetFullWidth(true)
    group:SetLayout("List")
    container:AddChild(group)

    local function rebuild()
        group:ReleaseChildren()

        local summary = Libs.AceGUI:Create("Label")
        summary:SetFullWidth(true)
        -- Format value node using ASTSchemaEmitter
        local ASTSchemaEmitter = ns.ASTSchemaEmitter
        local formattedText = "nil"
        if valueNode and ASTSchemaEmitter then
            if valueNode.type == ASTCore.NodeType.VALUE then
                formattedText = ASTSchemaEmitter.EmitValueNode(valueNode) or "nil"
            else
                formattedText = tostring(valueNode) or "nil"
            end
        end
        summary:SetText(string.format("|cFFFFD100Current Value:|r %s", formattedText))
        group:AddChild(summary)

        local typeDropdown = Libs.AceGUI:Create("Dropdown")
        typeDropdown:SetLabel("Value Type")
        typeDropdown:SetList({
            constant = "Constant",
            ["function"] = "|cFFFF00FFFunction|r"
        })
        local isConst = isConstant(valueNode)
        typeDropdown:SetValue(isConst and "constant" or "function")
        typeDropdown:SetCallback("OnValueChanged", function(_, _, choice)
            if choice == "constant" and not isConstant(valueNode) then
                -- Create proto AST constant node
                if not ASTValue or not ASTValue.CreateConst then
                    NAG:Warn(format("[ArgumentRenderer] ASTValue not available when switching to constant type - this should never happen"))
                    return
                end
                local newNode = ASTValue.CreateConst(0)
                applyValueNode(newNode, false)
                rebuild()
            elseif choice == "function" and isConstant(valueNode) then
                -- Create proto AST function value node (default to first available function)
                local defaultKey = valueOrder[1]
                local newNode
                if defaultKey and ASTValue and ASTValue.Create then
                    -- Create function value node with default function
                    newNode = ASTValue.Create(defaultKey, {})
                else
                    -- ASTValue must be available
                    if not ASTValue or not ASTValue.CreateConst then
                        NAG:Warn("[ArgumentRenderer] ASTValue not available - required for creating constant node")
                        return
                    end
                    newNode = ASTValue.CreateConst(0)
                end
                applyValueNode(newNode, false)
                rebuild()
            end
        end)
        group:AddChild(typeDropdown)

        if isConstant(valueNode) then
            local editBox = Libs.AceGUI:Create("EditBox")
            editBox:SetLabel("Constant Value")
            editBox:SetFullWidth(true)
            local constValue = getConstantValue(valueNode)
            editBox:SetText(tostring(constValue))
            editBox:SetCallback("OnEnterPressed", function(_, _, text)
                local asNumber = tonumber(text)
                local newValue = asNumber or text
                -- Update proto AST constant node
                if valueNode.type == ASTCore.NodeType.VALUE and ASTValue then
                    local valueData = ASTValue.GetValueData(valueNode)
                    if valueData then
                        -- Create const node instead of direct string assignment
                        valueData.val = ASTValue.CreateConst(newValue)
                    else
                        -- Recreate constant node with new value
                        local newNode = ASTValue.CreateConst(newValue)
                        applyValueNode(newNode, false)
                        rebuild()
                        return
                    end
                else
                    -- Legacy format detected - should not happen in production code
                    NAG:Warn(format("[ArgumentRenderer] Legacy format detected: attempting to set valueNode.value directly. valueNode should be proto AST with type == ASTCore.NodeType.VALUE. valueNode: %s, newValue: %s", tostring(valueNode), tostring(newValue)))
                    return
                end
                applyValueNode(valueNode, false)
                -- Format value node using ASTSchemaEmitter
                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                local formattedText = "nil"
                if valueNode and ASTSchemaEmitter then
                    if valueNode.type == ASTCore.NodeType.VALUE then
                        formattedText = ASTSchemaEmitter.EmitValueNode(valueNode) or "nil"
                    else
                        formattedText = tostring(valueNode) or "nil"
                    end
                end
                summary:SetText(string.format("|cFFFFD100Current Value:|r %s", formattedText))
            end)
            group:AddChild(editBox)
            return
        end

        if #valueOrder == 0 then
            local warning = Libs.AceGUI:Create("Label")
            warning:SetFullWidth(true)
            warning:SetText("|cFFFF0000No APLValue metadata available.|r")
            group:AddChild(warning)
            return
        end

        local functionDropdown = Libs.AceGUI:Create("Dropdown")
        functionDropdown:SetLabel("APLValue Function")
        functionDropdown:SetFullWidth(true)

        local valueList = {}
        for _, key in ipairs(valueOrder) do
            valueList[key] = valueMetadata[key].display
        end
        functionDropdown:SetList(valueList, valueOrder)

        local currentKey
        -- Get current function name from proto AST structure
        if valueNode.type == ASTCore.NodeType.VALUE and ASTValue then
            local valueType = ASTValue.GetValueType(valueNode)
            if valueType and valueType ~= ASTValue.ValueType.CONST then
                currentKey = valueType
            end
        else
            -- Legacy format detected - fail fast
            NAG:Warn(format("[ArgumentRenderer] Legacy format valueNode detected - should be proto AST. Node type: %s, Context: RenderFunctionDropdown", tostring(valueNode.type)))
        end
        if not currentKey or not valueList[currentKey] then
            currentKey = valueOrder[1]
            if currentKey then
                -- Create proto AST function value node
                if ASTValue and ASTValue.Create then
                    local newNode = ASTValue.Create(currentKey, {})
                    applyValueNode(newNode, true)
                else
                    -- Legacy format detected - should not exist in proto AST
                    self:Error("Legacy format detected in applyValueNode: valueNode is not proto AST. valueNode.type: %s, currentKey: %s", tostring(valueNode.type), tostring(currentKey))
                    return
                end
            end
        end
        if currentKey then
            functionDropdown:SetValue(currentKey)
        end

        functionDropdown:SetCallback("OnValueChanged", function(_, _, selectedKey)
            -- Create proto AST function value node
            if ASTValue and ASTValue.Create then
                local newNode = ASTValue.Create(selectedKey, {})
                applyValueNode(newNode, false)
            else
                -- Legacy format creation detected - should not create legacy format nodes
                self:Error("Legacy format creation detected in applyValueNode: Attempted to create legacy format node with type='function'. selectedKey: %s. Should create proto AST node instead.", tostring(selectedKey))
                return
            end
            rebuild()
        end)
        group:AddChild(functionDropdown)

        local argsHeading = Libs.AceGUI:Create("Heading")
        argsHeading:SetText("Function Arguments")
        argsHeading:SetFullWidth(true)
        group:AddChild(argsHeading)

        local argsContainer = Libs.AceGUI:Create("SimpleGroup")
        argsContainer:SetFullWidth(true)
        argsContainer:SetLayout("List")
        group:AddChild(argsContainer)

        self:RenderArgumentFields(argsContainer, valueNode, clause, clauseIdx, editorState, "value")
    end

    rebuild()
end

--- Render spell field with autocomplete and icon
--- @param container table Container widget
--- @param fieldName string Field name
--- @param currentValue any Current value
--- @param argIndex number Argument index
--- @param setArgValue function Setter function
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state
--- @param nodeCategory string "value" or "action"
--- @param fieldDef table|nil Field definition from schema
--- @param messageSchema table|nil Full message schema with _metadata
function ArgumentRenderer:RenderSpellField(container, fieldName, currentValue, argIndex, setArgValue, node, clause, clauseIdx, editorState, nodeCategory, fieldDef, messageSchema)

    -- Add spell icon with tooltip (if current value exists)
    local iconGroup = Libs.AceGUI:Create("SimpleGroup")
    iconGroup:SetLayout("Flow")
    iconGroup:SetFullWidth(true)

    local iconWidget = Libs.AceGUI:Create("Icon")
    if iconWidget.SetImageSize then
        iconWidget:SetImageSize(24, 24)
    end
    if iconWidget.SetWidth then
        iconWidget:SetWidth(28)
    end
    if iconWidget.SetHeight then
        iconWidget:SetHeight(28)
    end

    -- Helper to update icon display
    local function updateIcon(spellID)
        if spellID and tonumber(spellID) then
            local spellInfo = WoWAPI.GetSpellInfo(spellID)
            if spellInfo and spellInfo.iconID then
                iconWidget:SetImage(spellInfo.iconID)
                iconWidget.currentSpellID = spellID
                return
            end
        end
        -- No valid spell - show question mark
        iconWidget:SetImage("Interface\\Icons\\INV_Misc_QuestionMark")
        iconWidget.currentSpellID = nil
    end

    -- Get default value from schema (empty ActionID is default)
    local effectiveDefault = GetEffectiveDefaultValue(messageSchema, fieldName, "number")
    local defaultValue = nil  -- Empty ActionID is proto3 default for message types
    if effectiveDefault ~= nil then
        -- Empty ActionID message {} is the default
        if type(effectiveDefault) == "table" and next(effectiveDefault) == nil then
            defaultValue = nil  -- Empty ActionID
        elseif type(effectiveDefault) == "number" then
            defaultValue = effectiveDefault
        end
    end

    -- Only show value if different from default (empty ActionID)
    local displayValue = currentValue
    if currentValue == defaultValue or (currentValue == nil and defaultValue == nil) or
       (currentValue == 0 and defaultValue == nil) or (currentValue == nil and defaultValue == 0) then
        displayValue = nil  -- Don't display default value
    end

    updateIcon(displayValue)

    -- Add tooltip that updates based on current spell
    iconWidget:SetCallback("OnEnter", function(widget)
        if widget.currentSpellID then
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetSpellByID(widget.currentSpellID)
            GameTooltip:Show()
        end
    end)
    iconWidget:SetCallback("OnLeave", function(widget)
        GameTooltip:Hide()
    end)

    iconGroup:AddChild(iconWidget)

    local iconLabel = Libs.AceGUI:Create("Label")
    iconLabel:SetText(format("|cFFFFD100%s (Spell/Item ID)|r", fieldName))
    iconLabel:SetRelativeWidth(0.8)
    iconGroup:AddChild(iconLabel)

    container:AddChild(iconGroup)

    local spellWidget = Libs.AceGUI:Create("NAG_SpellAutocomplete")
    if not spellWidget then
        NAG:Warn("[ArgumentRenderer] Spell autocomplete widget unavailable, using basic edit box (fieldName=%s; nodeCategory=%s)", fieldName, nodeCategory)
        -- Fallback to simple EditBox
        local fallbackEdit = Libs.AceGUI:Create("EditBox")
        fallbackEdit:SetLabel(fieldName .. " (Spell/Item ID)")
        fallbackEdit:SetFullWidth(true)

        -- Only show value if different from default (empty ActionID)
        local fallbackDisplayValue = ""
        if currentValue and currentValue ~= defaultValue and
           not (currentValue == nil and defaultValue == nil) and
           not (currentValue == 0 and defaultValue == nil) and
           not (currentValue == nil and defaultValue == 0) then
            fallbackDisplayValue = tostring(currentValue)
        end

        fallbackEdit:SetText(fallbackDisplayValue)
        fallbackEdit:SetCallback("OnEnterPressed", function(widget, event, text)
            local numValue = tonumber(text)
            if numValue or text == "" then
                setArgValue(argIndex, numValue, fieldName)
            end
        end)
        container:AddChild(fallbackEdit)
        return
    end

    spellWidget:SetLabel("") -- No label since we show it above with icon
    spellWidget:SetFullWidth(true)

    -- Build spell list from SpellbookManager
    local SpellbookManager = NAG:GetModule("SpellbookManager")
    if SpellbookManager then
        local allSpells = SpellbookManager:GetAllSpells()

        local spellList = {}
        for spellID, spellData in pairs(allSpells or {}) do
            -- Filter: has name, has id, and is not a guild perk
            if spellData.name and spellData.id and not (spellData.type and spellData.type:find("Perk")) then
                local displayText = format("|T%s:16:16|t %s",
                    spellData.icon or "Interface\\Icons\\INV_Misc_QuestionMark",
                    spellData.name)
                tinsert(spellList, {
                    value = spellID,
                    name = spellData.name,
                    displayText = displayText
                })
            end
        end
        spellWidget:SetSpells(spellList)
    else
        NAG:Warn("[ArgumentRenderer] SpellbookManager unavailable for spell autocomplete (fieldName=%s; nodeCategory=%s)", fieldName, nodeCategory)
    end

    -- Set current value
    if currentValue then
        local spellInfo = WoWAPI.GetSpellInfo(currentValue)
        if spellInfo and spellInfo.name then
            spellWidget:SetText(spellInfo.name)
        else
            spellWidget:SetText(tostring(currentValue))
        end
    end

    spellWidget:SetCallback(function(spellID)
        updateIcon(spellID) -- Update icon when spell changes
        setArgValue(argIndex, spellID, fieldName)
        NAG:Info("Spell ID updated: " .. tostring(spellID))
    end)
    container:AddChild(spellWidget)

    -- Note: Dropdown reparenting is now handled automatically by the widget

end

--- Render enum field with dropdown
--- @param container table Container widget
--- @param fieldName string Field name
--- @param fieldDef table Field definition
--- @param currentValue any Current value
--- @param argIndex number Argument index
--- @param setArgValue function Setter function
function ArgumentRenderer:RenderEnumField(container, fieldName, fieldDef, currentValue, argIndex, setArgValue, node, clauseIdx, editorState, nodeCategory, messageSchema)
    -- Get enum values from schema via SchemaAccessor
    local enumValues
    local enumType
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")

    -- Get enum type name using SchemaAccessor (standardized access) - store for use in callbacks
    local enumTypeName = nil
    if SchemaAccessor and messageSchema then
        enumTypeName = SchemaAccessor:GetFieldEnumType(messageSchema, fieldName)
    end
    -- Fallback to direct fieldDef access if SchemaAccessor unavailable
    if not enumTypeName then
        enumTypeName = fieldDef.enum_type or fieldDef.enumType or fieldDef.enumTypeName
    end

    if SchemaAccessor and messageSchema then
        -- Use SchemaAccessor to get enum values (schema-driven)
        enumValues, enumType = SchemaAccessor:GetFieldEnumValues(messageSchema, fieldName)
    end

    -- Fallback: if SchemaAccessor didn't provide values, try direct Types access (for legacy support)
    if not enumValues or not next(enumValues) then
        if enumTypeName then
            local Types = GetTypesModule()
            if Types then
                enumType = Types:GetType(enumTypeName)
                if not enumType and Types.GetEnumShortName then
                    local shortName = Types:GetEnumShortName(enumTypeName)
                    if shortName then
                        enumType = Types:GetType(shortName)
                    end
                end

                if enumType then
                    enumValues = enumType:GetValues()
                else
                    NAG:Warn("[ArgumentRenderer] Enum type metadata not found (fieldName=%s; enumType=%s; nodeCategory=%s)", fieldName, tostring(enumTypeName), nodeCategory)
                end
            end
        elseif fieldDef.enum then
            -- Legacy format - enum values provided directly
            enumValues = fieldDef.enum
        end
    end

    if enumValues and next(enumValues) then
        local dropdown = Libs.AceGUI:Create("Dropdown")
        dropdown:SetLabel(fieldName)
        dropdown:SetFullWidth(true)

        local enumList = {}
        local enumOrder = {}
        for enumKey, enumValue in pairs(enumValues) do
            -- enumKey is the name (e.g., "PLAYER", "TARGET")
            -- enumValue is the numeric ID
            tinsert(enumOrder, enumKey)
            enumList[enumKey] = enumKey -- Display the name
        end
        sort(enumOrder)

        local includeStatAny = ShouldUseStatAnyOption(fieldName, fieldDef)
        local statAnyKey = "__NEGATIVE_ONE__"
        if includeStatAny then
            enumList[statAnyKey] = "-1"
            tinsert(enumOrder, 1, statAnyKey)
        end

        dropdown:SetList(enumList, enumOrder)

        local normalizedValue, normalizedKey = NormalizeEnumArgument(fieldName, fieldDef, enumValues, currentValue)

        -- Get effective default value from schema
        local effectiveDefault = GetEffectiveDefaultValue(messageSchema, fieldName, "enum")
        local defaultValue = 0  -- Proto3 default for enums (first value, typically Unknown)
        local defaultKey = nil
        if effectiveDefault ~= nil then
            if type(effectiveDefault) == "number" then
                defaultValue = effectiveDefault
            elseif type(effectiveDefault) == "string" then
                defaultKey = effectiveDefault
            end

            -- Find the key for the default value if it's a number
            if defaultKey == nil and defaultValue ~= nil then
                for key, val in pairs(enumValues) do
                    if val == defaultValue then
                        defaultKey = key
                        break
                    end
                end
            end
        end

        -- Try to find current value by ID (reverse lookup)
        local selectedKey = normalizedKey
        if not selectedKey and normalizedValue ~= nil then
            for key, val in pairs(enumValues) do
                if val == normalizedValue then
                    selectedKey = key
                    break
                end
            end
        end

        -- Check if current value equals default - if so, don't show it
        if selectedKey and normalizedValue == defaultValue then
            selectedKey = nil
        elseif not selectedKey and defaultKey then
            -- No current value, but schema has explicit default - only use if not Unknown (0)
            if defaultValue ~= 0 then
                selectedKey = defaultKey
            end
        end

        if includeStatAny then
            if normalizedValue == -1 then
                selectedKey = statAnyKey
            elseif not selectedKey and normalizedValue == nil and fieldDef.default == nil then
                selectedKey = statAnyKey
            end
        end

        -- Only auto-select first enum if there's an actual value but no matching key
        -- If field is nil/not set and no default, leave dropdown unset (don't show any value)
        if not selectedKey and normalizedValue ~= nil and #enumOrder > 0 then
            -- Value exists but couldn't find matching key - use first as fallback
            selectedKey = enumOrder[1]
        end
        -- Note: If normalizedValue is nil and no default, selectedKey remains nil and dropdown shows no selection

        if selectedKey then
            dropdown:SetValue(selectedKey)
        end

        dropdown:SetCallback("OnValueChanged", function(widget, event, key)
            -- Store the enum ID value, not the name
            if includeStatAny and key == statAnyKey then
                setArgValue(argIndex, -1, fieldName)
                return
            end

            local enumID = enumValues[key]
            if enumID == nil then
                NAG:Warn(format("[Enum Dropdown] Enum value missing for selection: fieldName=%s, key=%s, enumType=%s",
                    fieldName, tostring(key), tostring(enumTypeName)))
                return
            end

            setArgValue(argIndex, enumID, fieldName)
        end)
        container:AddChild(dropdown)
    else
        -- Enum values are required for enum fields - fail fast if missing
        NAG:Error(format("[ArgumentRenderer] Enum values required but unavailable (fieldName=%s; enumType=%s; nodeCategory=%s)", fieldName, tostring(enumTypeName), nodeCategory))
        return
    end
end

--- Render number field
--- @param container table Container widget
--- @param fieldName string Field name
--- @param currentValue any Current value
--- @param argIndex number Argument index
--- @param setArgValue function Setter function
--- @param fieldDef table|nil Field definition from schema
--- @param fieldType string Field type
--- @param messageSchema table|nil Full message schema with _metadata
function ArgumentRenderer:RenderNumberField(container, fieldName, currentValue, argIndex, setArgValue, fieldDef, fieldType, messageSchema)
    local numberEdit = Libs.AceGUI:Create("EditBox")
    numberEdit:SetLabel(fieldName)
    numberEdit:SetFullWidth(true)

    -- Get effective default value from schema
    local defaultValue = GetEffectiveDefaultValue(messageSchema, fieldName, fieldType) or 0

    -- Only show value if different from default
    local displayValue = ""
    if currentValue ~= nil and currentValue ~= defaultValue then
        displayValue = tostring(currentValue)
    end

    numberEdit:SetText(displayValue)
    numberEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        local numValue = tonumber(text)
        if numValue or text == "" then
            setArgValue(argIndex, numValue, fieldName)
        else
            NAG:Debug("Invalid number value: " .. tostring(text))
        end
    end)
    container:AddChild(numberEdit)
end

--- Render boolean field
--- @param container table Container widget
--- @param fieldName string Field name
--- @param currentValue any Current value
--- @param argIndex number Argument index
--- @param setArgValue function Setter function
--- @param fieldDef table|nil Field definition from schema
--- @param fieldType string Field type
--- @param messageSchema table|nil Full message schema with _metadata
function ArgumentRenderer:RenderBooleanField(container, fieldName, currentValue, argIndex, setArgValue, fieldDef, fieldType, messageSchema)
    local checkbox = Libs.AceGUI:Create("CheckBox")
    checkbox:SetLabel(fieldName)
    checkbox:SetFullWidth(true)

    -- Get effective default value from schema
    local defaultValue = GetEffectiveDefaultValue(messageSchema, fieldName, fieldType)
    if defaultValue == nil then
        defaultValue = false  -- Proto3 default for booleans
    end

    -- Only set checked if explicitly true and different from default
    local isChecked = false
    if currentValue == true or currentValue == "true" then
        if currentValue ~= defaultValue then
            isChecked = true
        end
    end

    checkbox:SetValue(isChecked)
    checkbox:SetCallback("OnValueChanged", function(widget, event, value)
        setArgValue(argIndex, value, fieldName)
    end)
    container:AddChild(checkbox)
end

--- Render repeated field (array/list)
--- @param container table Container widget
--- @param fieldName string Field name
--- @param fieldDef table Field definition from schema
--- @param currentValue any Current value (should be array/table)
--- @param argIndex number Argument index
--- @param setArgValue function Setter function
--- @param getArgValue function Getter function
--- @param setArgNode function Setter function for nodes
--- @param getArgNode function Getter function for nodes
--- @param node table AST node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state
--- @param nodeCategory string "value" or "action"
--- @param messageSchema table|nil Full message schema with _metadata
--- @param fieldInfo table|nil Field info from schema
function ArgumentRenderer:RenderRepeatedField(container, fieldName, fieldDef, currentValue, argIndex, setArgValue, getArgValue, setArgNode, getArgNode, node, clause, clauseIdx, editorState, nodeCategory, messageSchema, fieldInfo)
    local fieldType = (fieldInfo and fieldInfo.fieldType) or fieldDef.type
    local messageType = (fieldInfo and fieldInfo.messageType) or fieldDef.message_type

    -- Ensure currentValue is an array
    local values = {}
    if currentValue and type(currentValue) == "table" then
        -- Check if it's an array (ipairs-able) or a table
        local isArray = false
        local count = 0
        for _ in ipairs(currentValue) do
            count = count + 1
            isArray = true
        end
        if isArray then
            values = currentValue
        elseif count == 0 then
            -- Empty table, treat as empty array
            values = {}
        else
            -- Single value in table, convert to array
            values = {currentValue}
        end
    end

    -- For ActionID repeated fields, use list with dropdown for adding
    if messageType == "ActionID" or messageType == "SpellReference" then
        local FieldFormatConverter = ns.FieldFormatConverter
        local WoWAPI = ns.WoWAPI

        -- Create container for the list
        local listGroup = Libs.AceGUI:Create("InlineGroup")
        listGroup:SetTitle(fieldName .. " (Spell/Item IDs)")
        listGroup:SetFullWidth(true)
        listGroup:SetLayout("List")
        container:AddChild(listGroup)

        -- Helper to refresh the list display
        local function refreshList()
            listGroup:ReleaseChildren()

            -- Display current items
            local currentValues = getArgValue(argIndex) or {}
            if type(currentValues) ~= "table" then
                currentValues = {}
            end

            -- Ensure it's an array (ipairs-able)
            local valuesArray = {}
            local hasArrayElements = false
            for i, v in ipairs(currentValues) do
                valuesArray[i] = v
                hasArrayElements = true
            end
            if not hasArrayElements and type(currentValues) == "table" and next(currentValues) then
                -- Single value in table, convert to array
                valuesArray = {currentValues}
            end

            -- Render each item in the list
            for i, value in ipairs(valuesArray) do
                local itemGroup = Libs.AceGUI:Create("SimpleGroup")
                itemGroup:SetLayout("Flow")
                itemGroup:SetFullWidth(true)

                -- Extract spell ID for display
                local spellID = FieldFormatConverter and FieldFormatConverter:ExtractActionID(value) or value
                local spellInfo = spellID and WoWAPI.GetSpellInfo(spellID)

                -- Icon
                local iconWidget = Libs.AceGUI:Create("Icon")
                if iconWidget.SetImageSize then
                    iconWidget:SetImageSize(20, 20)
                end
                if iconWidget.SetWidth then
                    iconWidget:SetWidth(24)
                end
                if iconWidget.SetHeight then
                    iconWidget:SetHeight(24)
                end

                if spellInfo and spellInfo.iconID then
                    iconWidget:SetImage(spellInfo.iconID)
                    iconWidget.currentSpellID = spellID
                else
                    iconWidget:SetImage("Interface\\Icons\\INV_Misc_QuestionMark")
                    iconWidget.currentSpellID = nil
                end

                -- Add tooltip for spell icon
                iconWidget:SetCallback("OnEnter", function(widget)
                    if widget.currentSpellID then
                        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                        GameTooltip:SetSpellByID(widget.currentSpellID)
                        GameTooltip:Show()
                    end
                end)
                iconWidget:SetCallback("OnLeave", function(widget)
                    GameTooltip:Hide()
                end)

                itemGroup:AddChild(iconWidget)

                -- Spell name/ID label
                local spellLabel = Libs.AceGUI:Create("Label")
                local displayText = ""
                if spellInfo and spellInfo.name then
                    displayText = format("|T%s:16:16|t %s", spellInfo.iconID or "Interface\\Icons\\INV_Misc_QuestionMark", spellInfo.name)
                else
                    displayText = tostring(spellID or value)
                end
                spellLabel:SetText(displayText)
                spellLabel:SetRelativeWidth(0.6)
                itemGroup:AddChild(spellLabel)

                -- Move up button (if not first)
                if i > 1 then
                    local upButton = Libs.AceGUI:Create("Icon")
                    upButton:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")
                    upButton:SetImageSize(16, 16)
                    upButton:SetWidth(24)
                    upButton:SetHeight(24)
                    upButton:SetCallback("OnClick", function()
                        local currentVals = getArgValue(argIndex) or {}
                        if type(currentVals) ~= "table" then
                            currentVals = {currentVals}
                        end
                        -- Ensure it's an array (ipairs-able)
                        local valuesArray = {}
                        local hasArrayElements = false
                        for idx, v in ipairs(currentVals) do
                            valuesArray[idx] = v
                            hasArrayElements = true
                        end
                        if not hasArrayElements and type(currentVals) == "table" and next(currentVals) then
                            valuesArray = {currentVals}
                        end
                        -- Swap with previous
                        valuesArray[i], valuesArray[i - 1] = valuesArray[i - 1], valuesArray[i]
                        setArgValue(argIndex, valuesArray, fieldName)
                        refreshList()
                    end)
                    upButton:SetCallback("OnEnter", function(widget)
                        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                        GameTooltip:SetText("Move Up", 1, 1, 1)
                        GameTooltip:Show()
                    end)
                    upButton:SetCallback("OnLeave", function()
                        GameTooltip:Hide()
                    end)
                    itemGroup:AddChild(upButton)
                else
                    -- Spacer for alignment
                    local spacer = Libs.AceGUI:Create("Label")
                    spacer:SetText("")
                    spacer:SetWidth(24)
                    itemGroup:AddChild(spacer)
                end

                -- Move down button (if not last)
                if i < #valuesArray then
                    local downButton = Libs.AceGUI:Create("Icon")
                    downButton:SetImage("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
                    downButton:SetImageSize(16, 16)
                    downButton:SetWidth(24)
                    downButton:SetHeight(24)
                    downButton:SetCallback("OnClick", function()
                        local currentVals = getArgValue(argIndex) or {}
                        if type(currentVals) ~= "table" then
                            currentVals = {currentVals}
                        end
                        -- Ensure it's an array (ipairs-able)
                        local valuesArray = {}
                        local hasArrayElements = false
                        for idx, v in ipairs(currentVals) do
                            valuesArray[idx] = v
                            hasArrayElements = true
                        end
                        if not hasArrayElements and type(currentVals) == "table" and next(currentVals) then
                            valuesArray = {currentVals}
                        end
                        -- Swap with next
                        valuesArray[i], valuesArray[i + 1] = valuesArray[i + 1], valuesArray[i]
                        setArgValue(argIndex, valuesArray, fieldName)
                        refreshList()
                    end)
                    downButton:SetCallback("OnEnter", function(widget)
                        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                        GameTooltip:SetText("Move Down", 1, 1, 1)
                        GameTooltip:Show()
                    end)
                    downButton:SetCallback("OnLeave", function()
                        GameTooltip:Hide()
                    end)
                    itemGroup:AddChild(downButton)
                else
                    -- Spacer for alignment
                    local spacer = Libs.AceGUI:Create("Label")
                    spacer:SetText("")
                    spacer:SetWidth(24)
                    itemGroup:AddChild(spacer)
                end

                -- Delete button
                local deleteButton = Libs.AceGUI:Create("Icon")
                deleteButton:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
                deleteButton:SetImageSize(16, 16)
                deleteButton:SetWidth(24)
                deleteButton:SetHeight(24)
                deleteButton:SetCallback("OnClick", function()
                    local currentVals = getArgValue(argIndex) or {}
                    if type(currentVals) ~= "table" then
                        currentVals = {currentVals}
                    end
                    -- Ensure it's an array (ipairs-able)
                    local valuesArray = {}
                    local hasArrayElements = false
                    for idx, v in ipairs(currentVals) do
                        valuesArray[idx] = v
                        hasArrayElements = true
                    end
                    if not hasArrayElements and type(currentVals) == "table" and next(currentVals) then
                        valuesArray = {currentVals}
                    end
                    -- Remove item at index i
                    table.remove(valuesArray, i)
                    setArgValue(argIndex, valuesArray, fieldName)
                    refreshList()
                end)
                deleteButton:SetCallback("OnEnter", function(widget)
                    GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                    GameTooltip:SetText("Delete", 1, 1, 1)
                    GameTooltip:Show()
                end)
                deleteButton:SetCallback("OnLeave", function()
                    GameTooltip:Hide()
                end)
                itemGroup:AddChild(deleteButton)

                listGroup:AddChild(itemGroup)
            end

            -- Add new item section
            local addSection = Libs.AceGUI:Create("Heading")
            addSection:SetText("Add New")
            addSection:SetFullWidth(true)
            listGroup:AddChild(addSection)

            -- Spell autocomplete widget for adding
            local spellWidget = Libs.AceGUI:Create("NAG_SpellAutocomplete")
            if spellWidget then
                spellWidget:SetLabel("")
                spellWidget:SetFullWidth(true)

                -- Build spell list from SpellbookManager
                local SpellbookManager = NAG:GetModule("SpellbookManager")
                if SpellbookManager then
                    local allSpells = SpellbookManager:GetAllSpells()

                    local spellList = {}
                    for spellID, spellData in pairs(allSpells or {}) do
                        if spellData.name and spellData.id and not (spellData.type and spellData.type:find("Perk")) then
                            local displayText = format("|T%s:16:16|t %s",
                                spellData.icon or "Interface\\Icons\\INV_Misc_QuestionMark",
                                spellData.name)
                            tinsert(spellList, {
                                value = spellID,
                                name = spellData.name,
                                displayText = displayText
                            })
                        end
                    end
                    spellWidget:SetSpells(spellList)
                end

                spellWidget:SetCallback(function(spellID)
                    if spellID then
                        local currentVals = getArgValue(argIndex) or {}
                        if type(currentVals) ~= "table" then
                            currentVals = {}
                        end
                        -- Ensure it's an array (ipairs-able)
                        local valuesArray = {}
                        local hasArrayElements = false
                        for i, v in ipairs(currentVals) do
                            valuesArray[i] = v
                            hasArrayElements = true
                        end
                        if not hasArrayElements and type(currentVals) == "table" and next(currentVals) then
                            -- Single value in table, convert to array
                            valuesArray = {currentVals}
                        end

                        -- Normalize ActionID using FieldFormatConverter
                        local actionID = spellID
                        if FieldFormatConverter then
                            -- Use ToProto() if fieldInfo is available, otherwise use NormalizeActionID
                            if fieldInfo then
                                actionID = FieldFormatConverter:ToProto(spellID, fieldInfo)
                            else
                                -- FALLBACK TRACKING: Using deprecated NormalizeActionID() - fieldInfo should be available
                                NAG:Error("[ArgumentRenderer] FALLBACK PATTERN DETECTED: Using NormalizeActionID() fallback (fieldInfo unavailable). Location: RenderRepeatedField ActionID list with autocomplete. fieldName=%s, argIndex=%d, spellID=%s", tostring(fieldName), tostring(argIndex), tostring(spellID))
                                actionID = FieldFormatConverter:NormalizeActionID(spellID)
                            end
                        end

                        -- Add to array
                        table.insert(valuesArray, actionID)
                        setArgValue(argIndex, valuesArray, fieldName)

                        -- Clear the input
                        spellWidget:SetText("")

                        -- Refresh list
                        refreshList()
                    end
                end)
                listGroup:AddChild(spellWidget)
            else
                -- Fallback to simple EditBox if autocomplete unavailable
                local fallbackEdit = Libs.AceGUI:Create("EditBox")
                fallbackEdit:SetLabel("Add Spell/Item ID")
                fallbackEdit:SetFullWidth(true)
                fallbackEdit:SetCallback("OnEnterPressed", function(widget, event, text)
                    local numValue = tonumber(text)
                    if numValue then
                        local currentVals = getArgValue(argIndex) or {}
                        if type(currentVals) ~= "table" then
                            currentVals = {}
                        end
                        -- Ensure it's an array (ipairs-able)
                        local valuesArray = {}
                        local hasArrayElements = false
                        for i, v in ipairs(currentVals) do
                            valuesArray[i] = v
                            hasArrayElements = true
                        end
                        if not hasArrayElements and type(currentVals) == "table" and next(currentVals) then
                            -- Single value in table, convert to array
                            valuesArray = {currentVals}
                        end

                        local actionID = numValue
                        if FieldFormatConverter then
                            -- Use ToProto() if fieldInfo is available, otherwise use NormalizeActionID
                            if fieldInfo then
                                actionID = FieldFormatConverter:ToProto(numValue, fieldInfo)
                            else
                                -- FALLBACK TRACKING: Using deprecated NormalizeActionID() - fieldInfo should be available
                                NAG:Error("[ArgumentRenderer] FALLBACK PATTERN DETECTED: Using NormalizeActionID() fallback (fieldInfo unavailable). Location: RenderRepeatedField ActionID list fallback EditBox. fieldName=%s, argIndex=%d, numValue=%s", tostring(fieldName), tostring(argIndex), tostring(numValue))
                                actionID = FieldFormatConverter:NormalizeActionID(numValue)
                            end
                        end

                        table.insert(valuesArray, actionID)
                        setArgValue(argIndex, valuesArray, fieldName)
                        widget:SetText("")
                        refreshList()
                    end
                end)
                listGroup:AddChild(fallbackEdit)
            end
        end

        -- Initial render
        refreshList()
        return
    end

    -- For repeated APLValue fields (like vals in min/max), render as list of APLValue editors
    if messageType == "APLValue" or (type(messageType) == "string" and messageType:find("^APLValue")) then
        if not hasSetArgNode or not hasGetArgNode then
            NAG:Warn("[ArgumentRenderer] Repeated APLValue field cannot be rendered without accessors (fieldName=%s)", fieldName)
            return
        end

        -- Create container for the list
        local listGroup = Libs.AceGUI:Create("InlineGroup")
        listGroup:SetTitle(fieldName .. " (Values)")
        listGroup:SetFullWidth(true)
        listGroup:SetLayout("List")
        container:AddChild(listGroup)

        -- Helper to get current values array
        local function getCurrentValues()
            local currentValues = getArgValue(argIndex) or {}
            if type(currentValues) ~= "table" then
                return {}
            end
            -- Ensure it's an array
            local valuesArray = {}
            for i, v in ipairs(currentValues) do
                valuesArray[i] = v
            end
            if #valuesArray == 0 and type(currentValues) == "table" and next(currentValues) then
                -- Single value in table, convert to array
                return {currentValues}
            end
            return valuesArray
        end

        -- Helper to refresh the list display
        local function refreshList()
            listGroup:ReleaseChildren()

            local valuesArray = getCurrentValues()

            -- Render each value in the list
            for i, valueItem in ipairs(valuesArray) do
                local itemGroup = Libs.AceGUI:Create("InlineGroup")
                itemGroup:SetTitle(format("Value %d", i))
                itemGroup:SetFullWidth(true)
                itemGroup:SetLayout("List")
                listGroup:AddChild(itemGroup)

                -- Create accessors for this specific index
                local function getSingleArgNode()
                    local allValues = getCurrentValues()
                    if allValues[i] then
                        -- Convert proto structure to full wrapper if needed
                        local itemValue = allValues[i]
                        local ASTCore = ns.ASTCore
                        local ASTValue = ns.ASTValue
                        if type(itemValue) == "table" and itemValue.type == ASTCore.NodeType.VALUE then
                            return itemValue
                        elseif type(itemValue) == "table" then
                            -- Proto structure - reconstruct wrapper
                            for valueType, valueData in pairs(itemValue) do
                                return ASTValue.Create(valueType, valueData)
                            end
                        end
                        return itemValue
                    end
                    return nil
                end

                local function setSingleArgNode(valueNode)
                    local allValues = getCurrentValues()
                    if not allValues[i] then
                        allValues[i] = {}
                    end
                    -- Convert to proto structure
                    if valueNode and type(valueNode) == "table" and valueNode.type == ASTCore.NodeType.VALUE then
                        local valueType = ASTValue.GetValueType(valueNode)
                        local valueData = ASTValue.GetValueData(valueNode)
                        if valueType and valueData then
                            local protoStructure = {}
                            protoStructure[valueType] = valueData
                            allValues[i] = protoStructure
                        else
                            allValues[i] = valueNode
                        end
                    else
                        allValues[i] = valueNode
                    end
                    -- Update the entire array
                    setArgNode(argIndex, allValues, { skipRebuild = false })
                    refreshList()
                end

                -- Create wrapper accessors that work with the array index
                -- RenderAPLValueMessageField calls getArgNode(argIndex), so we need to accept the parameter
                local function getValueArgNode(ignoredIndex)
                    return getSingleArgNode()
                end

                local function setValueArgNode(ignoredIndex, valueNode, metadata)
                    setSingleArgNode(valueNode)
                end

                -- Render APLValue editor for this item
                self:RenderAPLValueMessageField(itemGroup, node, clause, clauseIdx, editorState, format("%s[%d]", fieldName, i), 1, setValueArgNode, getValueArgNode)

                -- Delete button
                local deleteButton = Libs.AceGUI:Create("Icon")
                deleteButton:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
                deleteButton:SetImageSize(16, 16)
                deleteButton:SetWidth(24)
                deleteButton:SetHeight(24)
                deleteButton:SetCallback("OnClick", function()
                    local allValues = getCurrentValues()
                    table.remove(allValues, i)
                    setArgNode(argIndex, allValues, { skipRebuild = false })
                    refreshList()
                end)
                deleteButton:SetCallback("OnEnter", function(widget)
                    GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                    GameTooltip:SetText("Delete Value", 1, 1, 1)
                    GameTooltip:Show()
                end)
                deleteButton:SetCallback("OnLeave", function()
                    GameTooltip:Hide()
                end)
                itemGroup:AddChild(deleteButton)
            end

            -- Add new value button
            local addButton = Libs.AceGUI:Create("Button")
            addButton:SetText("Add Value")
            addButton:SetFullWidth(true)
            addButton:SetCallback("OnClick", function()
                local allValues = getCurrentValues()
                -- Add default constant value
                local ASTValue = ns.ASTValue
                local defaultNode = ASTValue and ASTValue.CreateConst(0) or nil
                if defaultNode then
                    local valueType = ASTValue.GetValueType(defaultNode)
                    local valueData = ASTValue.GetValueData(defaultNode)
                    if valueType and valueData then
                        local protoStructure = {}
                        protoStructure[valueType] = valueData
                        table.insert(allValues, protoStructure)
                    else
                        table.insert(allValues, defaultNode)
                    end
                else
                    table.insert(allValues, { const = { val = "0" } })
                end
                setArgNode(argIndex, allValues, { skipRebuild = false })
                refreshList()
            end)
            listGroup:AddChild(addButton)
        end

        -- Initial render
        refreshList()
        return
    end

    -- For other repeated field types, use a simple list display with add/remove
    -- For now, fall back to MultiLineEditBox for simplicity
    local editBox = Libs.AceGUI:Create("MultiLineEditBox")
    editBox:SetLabel(fieldName .. " (List)")
    editBox:SetFullWidth(true)
    editBox:SetNumLines(5)
    editBox:DisableButton(true)

    -- Format values for display
    local displayText = ""
    if #values > 0 then
        local displayValues = {}
        for i, value in ipairs(values) do
            table.insert(displayValues, tostring(value))
        end
        displayText = table.concat(displayValues, "\n")
    end

    editBox:SetText(displayText)
    editBox:SetCallback("OnTextChanged", function(widget, event, text)
        -- Parse text into array of values
        local parsedValues = {}
        if text and text ~= "" then
            for line in text:gmatch("[^\n]+") do
                line = line:match("^%s*(.-)%s*$") -- Trim whitespace
                if line ~= "" then
                    -- Try to parse based on field type
                    if fieldType == "int32" or fieldType == "int64" or fieldType == "number" then
                        local numValue = tonumber(line)
                        if numValue then
                            table.insert(parsedValues, numValue)
                        end
                    elseif fieldType == "double" or fieldType == "float" then
                        local numValue = tonumber(line)
                        if numValue then
                            table.insert(parsedValues, numValue)
                        end
                    elseif fieldType == "bool" or fieldType == "boolean" then
                        local boolValue = (line:lower() == "true" or line == "1")
                        table.insert(parsedValues, boolValue)
                    else
                        -- String or other types
                        table.insert(parsedValues, line)
                    end
                end
            end
        end
        setArgValue(argIndex, parsedValues, fieldName)
    end)
    container:AddChild(editBox)
end

--- Render string field
--- @param container table Container widget
--- @param fieldName string Field name
--- @param currentValue any Current value
--- @param argIndex number Argument index
--- @param setArgValue function Setter function
--- @param fieldDef table|nil Field definition from schema
--- @param fieldType string Field type
--- @param messageSchema table|nil Full message schema with _metadata
function ArgumentRenderer:RenderStringField(container, fieldName, currentValue, argIndex, setArgValue, fieldDef, fieldType, messageSchema)
    local stringEdit = Libs.AceGUI:Create("EditBox")
    stringEdit:SetLabel(fieldName)
    stringEdit:SetFullWidth(true)

    -- Get effective default value from schema
    local defaultValue = GetEffectiveDefaultValue(messageSchema, fieldName, fieldType) or ""

    -- Only show value if different from default
    local displayValue = ""
    if currentValue and tostring(currentValue) ~= defaultValue then
        displayValue = tostring(currentValue)
    end

    stringEdit:SetText(displayValue)
    stringEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        setArgValue(argIndex, text, fieldName)
    end)
    container:AddChild(stringEdit)
end

--- Render complex/unknown field as string
--- @param container table Container widget
--- @param fieldName string Field name
--- @param fieldType string Field type
--- @param currentValue any Current value
--- @param argIndex number Argument index
--- @param setArgValue function Setter function
--- @param fieldDef table|nil Field definition from schema
--- @param messageSchema table|nil Full message schema with _metadata
function ArgumentRenderer:RenderComplexField(container, fieldName, fieldType, currentValue, argIndex, setArgValue, fieldDef, messageSchema)
    local complexEdit = Libs.AceGUI:Create("EditBox")
    complexEdit:SetLabel(fieldName .. " (" .. (fieldType or "unknown") .. ")")
    complexEdit:SetFullWidth(true)

    -- Get effective default value from schema
    local defaultValue = GetEffectiveDefaultValue(messageSchema, fieldName, fieldType) or ""

    -- Only show value if different from default
    local displayValue = ""
    if currentValue and tostring(currentValue) ~= defaultValue then
        displayValue = tostring(currentValue)
    end

    complexEdit:SetText(displayValue)
    complexEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        setArgValue(argIndex, text, fieldName)
    end)
    container:AddChild(complexEdit)
end

--- Render argument fields for a comparison side (lhs/rhs function)
--- @param container table Container widget
--- @param sideNode table The side node (function node)
--- @param comparisonNode table The parent comparison node
--- @param clause table The clause being edited
--- @param clauseIdx number The clause index
--- @param editorState table The editor state for this instance
function ArgumentRenderer:RenderComparisonSideArguments(container, sideNode, comparisonNode, clause, clauseIdx,
                                                        editorState)
    local SchemaValidator = NAG:GetModule("SchemaValidator")
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    -- Get function name
    local funcName = sideNode.functionName or ""
    if funcName == "" then return end

    -- Extract and normalize
    funcName = funcName:match("^NAG:([%w_]+)") or funcName:match("^([%w_]+)%(") or funcName:match("^([%w_]+)$") or
    funcName
    -- Use SchemaUtils for consistent conversion (handles acronyms properly)
    local SchemaUtils = NAG:GetModule("SchemaUtils")
    funcName = SchemaUtils and SchemaUtils:CamelToSnake(funcName) or funcName:lower()

    -- Normalize to snake_case and use SchemaAccessor
    local snakeName = funcName
    if not snakeName:match("^[a-z][a-z0-9_]*$") then
        local SchemaUtils = NAG:GetModule("SchemaUtils")
        snakeName = SchemaUtils and SchemaUtils:CamelToSnake(funcName) or funcName:lower()
    end

    -- Find schema using strict snake_case lookup
    local schema
    if snakeName:match("^[a-z][a-z0-9_]*$") and SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
        local metadata = SchemaAccessor:GetMetadataByIdentifier(snakeName, nil)
        if metadata then
            -- Use metadata.messageSchema directly (already provided by GetMetadataByIdentifier)
            schema = {
                fields = metadata.messageSchema and metadata.messageSchema.fields or {},
                field_order = metadata.messageSchema and metadata.messageSchema.field_order or {},
                label = metadata.label
            }
        end
    end

    if not schema or not schema.fields or not next(schema.fields) then
        return
    end

    -- Arguments section header
    local argsHeader = Libs.AceGUI:Create("Heading")
    argsHeader:SetText("Arguments")
    argsHeader:SetFullWidth(true)
    container:AddChild(argsHeader)

    -- Show proto structure info instead of sideNode.arguments
    local sideProtoData = GetProtoData(sideNode, "value") or {}

    -- Check for parser issues
    -- Check if schema has fields but sideProtoData has no values
    local hasArguments = false
    if schema and schema.field_order and sideProtoData then
        for _, fieldName in ipairs(schema.field_order) do
            if sideProtoData[fieldName] ~= nil then
                hasArguments = true
                break
            end
        end
    end
    if not hasArguments and sideNode.functionName then
        if sideNode.functionName:find("%(") then
            NAG:Warn("[ArgumentRenderer] Comparison function node missing parsed arguments (functionName=%s; clausePriority=%s)", tostring(sideNode.functionName), tostring(clauseIdx))
        end
    end

    -- Helper: Get argument value by index (index is field_order position, matches NAG handler signature)
    -- Reads from proto structure: valueData[fieldOrder[index]]
    local function getArgValue(index)
        if not schema or not schema.field_order or not schema.field_order[index] then
            NAG:Trace(format("[getArgValue Comparison Debug] No field_order[%d], returning nil", index))
            return nil
        end

        local fieldName = schema.field_order[index]
        local fieldInfo = schema.fields[fieldName]

        -- Get proto data structure from sideNode
        local protoData = GetProtoData(sideNode, "value")
        if not protoData then
            NAG:Trace(format("[getArgValue Comparison Debug] Invalid sideNode type, returning nil"))
            return nil
        end

        local fieldValue = protoData[fieldName]

        if fieldValue == nil then
            return nil
        end

        -- For complex types (APLValue message fields), extract value from proto AST node
        if fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "APLValue" then
            -- fieldValue is a proto AST node, extract const value if it's a const
            if type(fieldValue) == "table" and fieldValue.type == ASTCore.NodeType.VALUE then
                if ASTValue.IsConst(fieldValue) then
                    return ASTValue.GetConstValue(fieldValue)
                else
                    -- Complex APLValue node - return the node itself (caller will handle)
                    return fieldValue
                end
            end
        end

        -- Handle ActionID/SpellReference message types - extract the actual ID
        if fieldInfo and fieldInfo.type == "message" and (fieldInfo.message_type == "ActionID" or fieldInfo.message_type == "SpellReference") then
            local FieldFormatConverter = ns.FieldFormatConverter
            if FieldFormatConverter then
                return FieldFormatConverter:ExtractActionID(fieldValue)
            end
        end

        -- Handle UnitReference message types - extract the unit string or enum
        if fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "UnitReference" then
            local FieldFormatConverter = ns.FieldFormatConverter
            if FieldFormatConverter then
                return FieldFormatConverter:ExtractUnitReferenceForDisplay(fieldValue)
            end
        end

        -- For simple types (enum, number, string, boolean), return raw value
        return fieldValue
    end

    -- Helper: Set argument value and rebuild comparison
    local function setArgValue(index, value, fieldName)
        if not schema or not schema.field_order or not schema.field_order[index] then
            NAG:Warn(format("[setArgValue Comparison Debug] No field_order[%d] in schema", index))
            return
        end

        local actualFieldName = schema.field_order[index]
        local fieldInfo = schema.fields[actualFieldName]

        -- Get or ensure proto data structure exists
        local protoData, valueType = EnsureProtoData(sideNode, "value")
        if not protoData then
            NAG:Warn(format("[setArgValue Comparison Debug] Failed to get protoData for field %s", actualFieldName))
            return
        end

        -- Determine if this is a complex type (APLValue) or simple type (enum/primitive)
        local isComplexType = fieldInfo and fieldInfo.type == "message" and fieldInfo.message_type == "APLValue"

        if isComplexType then
            -- Create const node and convert to proto structure
            local valueNode = ASTValue.CreateConst(value)
            local valueType = ASTValue.GetValueType(valueNode)
            local valueData = ASTValue.GetValueData(valueNode)
            if valueType and valueData then
                local protoStructure = {}
                protoStructure[valueType] = valueData
                protoData[actualFieldName] = protoStructure
            else
                protoData[actualFieldName] = valueNode
            end
        else
            -- For simple types, store raw value
            protoData[actualFieldName] = value
        end

        -- Rebuild the parent comparison node text
        -- Get clauseIdx and editorState from context if available
        local effectiveClauseIdx = clauseIdx
        if clause and clause._clauseIdx ~= nil then
            effectiveClauseIdx = clause._clauseIdx
        end

        local effectiveEditorState = editorState
        if clause and clause._editorState ~= nil then
            effectiveEditorState = clause._editorState
        end

        -- Emit comparison node text using ASTSchemaEmitter
        local ASTSchemaEmitter = ns.ASTSchemaEmitter

        if not ASTSchemaEmitter then
            NAG:Warn("[ArgumentRenderer] ASTSchemaEmitter not available (source=ArgumentRenderer.SetComparisonArgument)")
        else
            local emittedText = ASTSchemaEmitter.EmitValueNode(comparisonNode) or ""
            NAG:Trace("[ArgumentRenderer] ArgumentRendererComparisonEmission (clauseIdx=%s; success=%s)", tostring(effectiveClauseIdx), tostring(emittedText ~= ""))

            -- Trigger refresh if needed
            if effectiveEditorState then
                local NodeEditors = ns.RotationEditorNodeEditors
                if NodeEditors and NodeEditors.RebuildConditionFromAST and effectiveClauseIdx and effectiveEditorState then
                    NodeEditors:RebuildConditionFromAST(clause, effectiveClauseIdx, effectiveEditorState)
                end
            end
        end

        if effectiveEditorState then
            EditorUtils.MarkDirty(effectiveEditorState)

            local NodeEditors = ns.RotationEditorNodeEditors
            if NodeEditors and NodeEditors.ReselectNode and effectiveClauseIdx then
                -- RefreshASTTree is synchronous, so we can reselect immediately (delay parameter is deprecated)
                NodeEditors:ReselectNode(effectiveEditorState, effectiveClauseIdx, nil)  -- No delay needed - operations are synchronous
            end
        else
            NAG:Warn("[RotationEditor] setArgValue called without editor state (comparison side update)")
        end

        -- Refresh the AST tree to show updated values
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor and editorState and clauseIdx then
            local editorData = editorState.clauseEditors and editorState.clauseEditors[clauseIdx]
            -- Guard: Skip refresh if already refreshing to prevent cascading updates
            if not editorData or not editorData._refreshing then
                ASTEditor:RefreshASTTree(clause, clauseIdx, editorState)
            end
        end
    end

    -- Render fields
    local fieldOrder = schema.field_order or {}
    for argIndex, fieldName in ipairs(fieldOrder) do
        if fieldName ~= "field_order" then
            local fieldDef = schema.fields[fieldName]
            if fieldDef then
                self:RenderArgumentField(container, sideNode, clause, clauseIdx, editorState, fieldName, fieldDef,
                    argIndex, setArgValue, getArgValue, nil, nil, 0, "comparison_side")
            end
        end
    end
end


return ArgumentRenderer
