--- @module "ASTAction"
--- Action node types matching APLAction message from apl.proto
--- Handles all action types: cast_spell, sequence, wait, etc.
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local ASTCore = ns.ASTCore
local TableUtils = ns.TableUtils

-- Lazy-load schema modules
local SchemaAccessor
local FieldFormatConverter

local function EnsureSchemaModules()
    if not SchemaAccessor then
        SchemaAccessor = NAG:GetModule("SchemaAccessor", true)
    end
    if not FieldFormatConverter then
        FieldFormatConverter = ns.FieldFormatConverter
    end
end

--- @class ASTAction
local ASTAction = {}
ns.ASTAction = ASTAction

-- ============================ FACTORY FUNCTIONS ===========================
--- Create an action node
--- @param actionType string|nil The action type
--- @param actionData table Action-specific data
--- @param condition table|nil Optional condition (APLValue)
--- @return ASTNode
function ASTAction.Create(actionType, actionData, condition)
    if NAG.debug then NAG:Debug("[ASTAction] Create: Creating action node (actionType='%s')", actionType or "nil") end

    if not actionType then
        NAG:Warn("[ASTAction] Create: actionType is nil - creating invalid action node")
    end

    local node = ASTCore.CreateNode(ASTCore.NodeType.ACTION)

    -- Set action type
    if actionType then
        node.action[actionType] = actionData or {}
    else
        node.__invalid = node.__invalid or {}
        node.__invalid.missingActionType = true
    end

    -- Set condition if provided
    if condition then
        node.condition = condition
    end

    if NAG.debug then NAG:Debug("[ASTAction] Create: Successfully created action node (actionType='%s')", actionType or "nil") end
    return node
end

--- Create an action node from fields using schema metadata and FieldFormatConverter
--- @param actionType string The action type identifier (snake_case, e.g., "cast_spell")
--- @param fields table|nil Field values (keyed by schema field names in snake_case)
--- @param condition table|nil Optional condition (APLValue)
--- @return ASTNode
function ASTAction.CreateFromFields(actionType, fields, condition)
    if NAG.debug then NAG:Debug("[ASTAction] CreateFromFields: Creating action from fields (actionType='%s', fieldCount=%d)",
        actionType or "nil", fields and (function() local count = 0; for _ in pairs(fields) do count = count + 1 end; return count end)() or 0) end

    EnsureSchemaModules()

    if not actionType then
        NAG:Warn("[ASTAction] CreateFromFields: actionType is nil - falling back to Create with nil actionType")
        return ASTAction.Create(nil, nil, condition)
    end

    -- Get schema metadata for this action type
    local metadata
    if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
        metadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
    end

    if not metadata or not metadata.messageSchema then
        NAG:Warn("[ASTAction] CreateFromFields: Schema metadata not found for actionType='%s' - using raw fields",
            actionType)
        -- Fallback: create with raw fields if schema not available
        NAG:Warn("[ASTAction] FALLBACK TRACKING: Using raw fields fallback in CreateFromFields() for actionType='%s' (schema metadata unavailable)", tostring(actionType))
        return ASTAction.Create(actionType, fields or {}, condition)
    end

    NAG:Info("[ASTAction] CreateFromFields: Using schema metadata for actionType='%s'", actionType)

    local messageSchema = metadata.messageSchema
    local normalizedFields = {}

    -- Normalize each field using FieldFormatConverter
    if fields then
        for fieldName, fieldValue in pairs(fields) do
            -- Skip nil values
            if fieldValue ~= nil then
                local fieldInfo = messageSchema.fields and messageSchema.fields[fieldName]
                if fieldInfo and FieldFormatConverter then
                    -- Use FieldFormatConverter to normalize the field value
                    normalizedFields[fieldName] = FieldFormatConverter:NormalizeToProto(fieldValue, fieldInfo)
                else
                    -- No field info or FieldFormatConverter, use value as-is
                    normalizedFields[fieldName] = fieldValue
                end
            end
        end
    end

    return ASTAction.Create(actionType, normalizedFields, condition)
end

-- ============================ QUERY FUNCTIONS ============================

--- Get the action type from an action node
--- @param node ASTNode Action node
--- @return string|nil Action type
function ASTAction.GetActionType(node)
    if not node or node.type ~= ASTCore.NodeType.ACTION then
        return nil
    end

    for actionType, data in pairs(node.action or {}) do
        if data and actionType ~= "condition" then
            return actionType
        end
    end

    return nil
end

--- Get the action data from an action node
--- @param node ASTNode Action node
--- @return table|nil Action data
function ASTAction.GetActionData(node)
    if not node or node.type ~= ASTCore.NodeType.ACTION then
        return nil
    end

    local actionType = ASTAction.GetActionType(node)
    if actionType then
        return node.action[actionType]
    end

    return nil
end

--- Set the action data for an action node
--- @param node ASTNode Action node
--- @param actionData table Action data to set
--- @return boolean Success
function ASTAction.SetActionData(node, actionData)
    if not node or node.type ~= ASTCore.NodeType.ACTION then
        NAG:Warn("[ASTAction] SetActionData: Invalid node (type=%s)", node and tostring(node.type) or "nil")
        return false
    end

    local actionType = ASTAction.GetActionType(node)
    if not actionType then
        NAG:Warn("[ASTAction] SetActionData: Cannot set action data - no action type found")
        return false
    end

    -- DEBUG: Log for OverlayText to catch font_color at wrong level
    if actionType == "overlay_text" and actionData then
        if actionData.font_color then
            NAG:Error("[ASTAction] SetActionData: CRITICAL - font_color found at action level! Should only be in options!")
        end
        if actionData.options and actionData.options.font_color then
            NAG:Debug("[ASTAction] SetActionData: ✓ font_color correctly inside options")
        end
    end

    node.action[actionType] = actionData
    return true
end

--- Check if action has a condition
--- @param node ASTNode Action node
--- @return boolean
function ASTAction.HasCondition(node)
    return node and node.type == ASTCore.NodeType.ACTION and node.condition ~= nil
end

--- Get the condition from an action node
--- @param node ASTNode Action node
--- @return table|nil Condition
function ASTAction.GetCondition(node)
    if not node or node.type ~= ASTCore.NodeType.ACTION then
        return nil
    end

    return node.condition
end

--- Set the condition on an action node
--- @param node ASTNode Action node
--- @param condition table|nil Condition (APLValue)
function ASTAction.SetCondition(node, condition)
    if node and node.type == ASTCore.NodeType.ACTION then
        node.condition = condition
    end
end

-- ============================ VALIDATION FUNCTIONS ============================

--- Validate action node fields against proto schema
--- Uses SchemaValidator's protobuf methodology: identifier → metadata → protoName → schema validation
--- @param node ASTNode Action node to validate
--- @return boolean valid Whether fields are valid
--- @return string|nil error Error message if validation failed
--- @return table|nil validationInfo Additional validation information from SchemaValidator
function ASTAction.ValidateFields(node)
    if not node or node.type ~= ASTCore.NodeType.ACTION then
        return false, "Invalid action node"
    end

    local actionType = ASTAction.GetActionType(node)
    if not actionType then
        -- Empty action is valid (pending user selection)
        return true, nil
    end

    -- compound_expression has no schema metadata; it stores raw RHS text for round-trip
    if actionType == "compound_expression" then
        return true, nil
    end

    local actionData = ASTAction.GetActionData(node)
    if not actionData then
        -- No fields to validate
        return true, nil
    end

    -- Get metadata using protobuf methodology
    EnsureSchemaModules()
    if not SchemaAccessor then
        return false, "SchemaAccessor not available"
    end

    local metadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
    if not metadata or not metadata.protoName then
        NAG:Warn("[ASTAction] ValidateFields: Unknown action type '%s' (metadata missing)", actionType)
        return false, string.format("Unknown action type: %s (metadata missing)", actionType)
    end

    local protoName = metadata.protoName
    NAG:Trace("[ASTAction] ValidateFields: actionType='%s', protoName='%s'", actionType, protoName)

    -- Use SchemaValidator for field-level validation (protobuf methodology)
    local SchemaValidator = NAG:GetModule("SchemaValidator")
    if not SchemaValidator then
        -- SchemaValidator not available - can't do field validation
        NAG:Trace("[ASTAction] ValidateFields: SchemaValidator not available, skipping field validation for '%s'", actionType)
        return true, nil
    end

    -- Validate by field names using proto schema
    local valid, error, validationInfo = SchemaValidator:ValidateByFieldNames(protoName, actionData)
    if not valid then
        NAG:Warn("[ASTAction] ValidateFields failed: actionType='%s', protoName='%s', error='%s'", actionType, protoName, error or "unknown")
    else
        NAG:Info("[ASTAction] ValidateFields: actionType='%s' validated successfully", actionType)
    end
    return valid, error, validationInfo
end

