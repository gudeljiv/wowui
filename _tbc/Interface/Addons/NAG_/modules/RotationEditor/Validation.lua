--- @module "RotationEditor.Validation"
--- Validation functions for RotationEditor
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Module references
local EditorUtils = ns.RotationEditorUtils

-- AST modules (moved from function bodies for DRY)
local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue

-- Lua APIs
local format = string.format
local tinsert = tinsert
local type = type
local tostring = tostring
local loadstring = loadstring

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local Validation = {}
ns.RotationEditorValidation = Validation

-- Condition type aliases for case-insensitive matching
local CONDITION_TYPE_ALIASES = {}
do
    for _, value in pairs(ns.CUSTOM_CONDITION_TYPES) do
        if type(value) == "string" then
            CONDITION_TYPE_ALIASES[value:lower()] = value
        end
    end
end

-- ~~~~~~~~~~ HELPER FUNCTIONS ~~~~~~~~~~

--- Extract and normalize condition value from condition table
--- @param condition table The condition table
--- @param requireTable boolean If true, fall back to condition itself if value is not a table
--- @return table|any The extracted value
local function ExtractConditionValue(condition, requireTable)
    local value = condition.value
    if type(value) ~= "table" and requireTable then
        value = condition
    end
    return value
end

--- Add validation error with consistent formatting
--- @param editorState table The editor state
--- @param formatString string Format string for the error message
--- @param ... any Arguments for format string
local function AddValidationError(editorState, formatString, ...)
    tinsert(editorState.validationErrors, format(formatString, ...))
end

--- Detect legacy format node and log appropriate warnings
--- @param node table The AST node to check
--- @param nodeType string The node type
--- @param context string The validation context
--- @return boolean True if legacy format detected
--- @return string|nil Error message if legacy format detected
local function DetectAndLogLegacyFormat(node, nodeType, context)
    local isLegacyFormat = false

    if nodeType == "function" or nodeType == "logical" or nodeType == "comparison" or nodeType == "math" then
        -- These types are always legacy (not proto AST node types)
        isLegacyFormat = true
        NAG:Warn("[Validation] Legacy node type detected at %s: type='%s' (function/logical/comparison/math are always legacy)",
            context or "unknown", nodeType)
    elseif nodeType == "action" then
        -- Check for legacy format: missing proto structure (node.action) or presence of legacy fields (arguments)
        if not node.action or type(node.action) ~= "table" then
            isLegacyFormat = true
            local functionName = node.functionName or node.actionType or "unknown"
            NAG:Warn("[Validation] Legacy action format detected at %s: missing node.action proto structure (functionName='%s') - should be proto AST",
                context or "unknown", functionName)
        elseif node.arguments then
            isLegacyFormat = true
            local functionName = node.functionName or node.actionType or "unknown"
            NAG:Warn("[Validation] Legacy action format detected at %s: has 'arguments' field (functionName='%s') - should be proto AST",
                context or "unknown", functionName)
        end
    end

    if isLegacyFormat then
        -- Collect node structure for debugging
        local nodeKeys = {}
        if node then
            for k, v in pairs(node) do
                if k ~= "type" then
                    local valueType = type(v)
                    if valueType == "table" then
                        local hasKeys = next(v) ~= nil
                        nodeKeys[k] = format("table (%s)", hasKeys and "has keys" or "empty")
                    elseif valueType == "string" or valueType == "number" or valueType == "boolean" then
                        local str = tostring(v)
                        if #str > 50 then
                            str = str:sub(1, 47) .. "..."
                        end
                        nodeKeys[k] = str
                    else
                        nodeKeys[k] = valueType
                    end
                end
            end
        end

        -- Log legacy format details for developer attention
        local keyList = {}
        for k, v in pairs(nodeKeys) do
            table.insert(keyList, format("%s=%s", tostring(k), tostring(v)))
        end

        NAG:Warn("[Validation] Legacy clause format node detected: type='%s', context='%s' - should be proto AST",
            tostring(nodeType), tostring(context))
        NAG:Warn("[Validation] Legacy node structure: keys=[%s]", table.concat(keyList, ", "))
        NAG:Debug("[Validation] Node type check: nodeType='%s' (type: %s), node.type='%s' (type: %s), ASTCore.NodeType.ACTION='%s', has node.action=%s, has functionName=%s",
            tostring(nodeType), type(nodeType),
            tostring(node and node.type), type(node and node.type),
            tostring(ns.ASTCore and ns.ASTCore.NodeType and ns.ASTCore.NodeType.ACTION),
            tostring(node and node.action ~= nil),
            tostring(node and node.functionName ~= nil))

        return true, format("Legacy clause format node detected: type='%s' - proto AST required", tostring(nodeType))
    end

    return false, nil
end

-- ~~~~~~~~~~ VALIDATION ~~~~~~~~~~

--- Validate all fields in the working config
--- @param editorState table The editor state for this instance
--- @return boolean True if valid
function Validation:ValidateAllFields(editorState)
    if not editorState or not editorState.workingConfig then
        NAG:Debug("[Validation] ValidateAllFields called without editor state or working config")
        return false
    end

    editorState.validationErrors = {}

    -- Validate rotation name
    local rotationName = editorState.workingConfig.name
    local rotationNameValid = type(rotationName) == "string" and rotationName:trim() ~= ""

    NAG:Info("[Validation] Validating rotation: %s", rotationNameValid and rotationName or "unnamed")

    if not rotationNameValid then
        AddValidationError(editorState, "Rotation name is required")
    end

    -- Validate rotation string
    local rotationString = editorState.workingConfig.rotationString
    local rotationStringValid = rotationString and rotationString:trim() ~= ""

    if not rotationStringValid then
        AddValidationError(editorState, "Rotation string is required")
    else
        local rotationManager = EditorUtils.GetRotationManager()
        if rotationManager then
            local valid, err = rotationManager:ValidateRotation(editorState.workingConfig, true)
            rotationStringValid = valid
            if not valid then
                AddValidationError(editorState, "Rotation validation failed: %s", tostring(err))
            end
        end
    end

    NAG:Info("[Validation] Rotation string validation: %s", rotationStringValid and "passed" or "failed")

    -- Validate individual priority_list clauses (if in visual mode)
    local clauseCount = 0
    if editorState.workingConfig.aplProto and editorState.workingConfig.aplProto.priority_list then
        local ASTSchemaEmitter = ns.ASTSchemaEmitter
        clauseCount = #editorState.workingConfig.aplProto.priority_list

        for i, clause in ipairs(editorState.workingConfig.aplProto.priority_list) do
            -- Validate clause condition syntax (synthesize from proto AST)
            if clause.action then
                local condition = ASTAction and ASTAction.GetCondition(clause.action)
                if condition then
                    local conditionText = ASTSchemaEmitter and ASTSchemaEmitter.EmitValueNode(condition) or ""
                    if conditionText and conditionText ~= "" then
                        local valid, err = Validation.ValidateLuaSyntax(conditionText, "Condition")
                        if not valid then
                            AddValidationError(editorState, "Clause #%d condition: %s", i, err)
                        end
                    end
                end
            end

            -- Validate clause action syntax (synthesize from proto AST)
            if clause.action and clause.action.type == ASTCore.NodeType.ACTION then
                local actionText = ASTSchemaEmitter and ASTSchemaEmitter.EmitActionNode(clause.action) or ""
                if actionText and actionText ~= "" then
                    local valid, err = Validation.ValidateLuaSyntax(actionText, "Action")
                    if not valid then
                        AddValidationError(editorState, "Clause #%d action: %s", i, err)
                    end
                end
            end
        end
    end

    if clauseCount > 0 then
        NAG:Info("[Validation] Validated %d clauses", clauseCount)
    end

    -- Validate custom conditions
    local conditionCount = 0
    if editorState.workingConfig.customConditions then
        conditionCount = #editorState.workingConfig.customConditions
        for i, condition in ipairs(editorState.workingConfig.customConditions) do
            local valid, err = self:ValidateCondition(condition)
            if not valid then
                AddValidationError(editorState, "Smart Switching Condition #%d: %s", i, err)
            end
        end
    end

    if conditionCount > 0 then
        NAG:Info("[Validation] Validated %d custom conditions", conditionCount)
    end

    -- Show results
    local errorCount = #editorState.validationErrors
    NAG:Info("[Validation] Validation complete: %d error(s) found", errorCount)

    if errorCount > 0 then
        local errorMsg = "Validation errors:\n" .. table.concat(editorState.validationErrors, "\n")
        NAG:Error("[Validation] %s", errorMsg)
        return false
    else
        NAG:Info("[Validation] Rotation validation passed!")
        return true
    end
end

--- Validate Lua code syntax
--- @param code string The Lua code to validate
--- @param codeType string Type of code ("condition" or "action") for error messages
--- @return boolean True if valid
--- @return string|nil Error message if invalid
function Validation.ValidateLuaSyntax(code, codeType)
    if not code or code == "" then
        return true -- Empty is valid (optional)
    end

    if code:match("^%s*function%s*%b()") then
        return false, format("%s syntax error: function definitions are not allowed", codeType or "Code")
    end

    -- Try to compile the code using loadstring
    local compiled, compileError = loadstring("return " .. code)

    if not compiled then
        -- Try without "return" prefix (for statements vs expressions)
        compiled, compileError = loadstring(code)

        if not compiled then
            return false, format("%s syntax error: %s", codeType or "Code", tostring(compileError))
        end
    end

    return true
end

--- Validate a condition
--- @param condition table The condition to validate
--- @return boolean True if valid
--- @return string|nil Error message if invalid
function Validation:ValidateCondition(condition)
    if not condition or not condition.type then
        return false, "Missing condition type"
    end

    local conditionType = condition.type
    if type(conditionType) == "string" and not ns.VALID_CUSTOM_CONDITION_TYPES[conditionType] then
        local alias = CONDITION_TYPE_ALIASES[conditionType:lower()]
        if alias then
            conditionType = alias
            condition.type = alias
        end
    end

    if not ns.VALID_CUSTOM_CONDITION_TYPES[conditionType] then
        return false, "Invalid condition type: " .. tostring(condition.type)
    end

    if conditionType == ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT then
        local value = ExtractConditionValue(condition, true)
        if type(value) ~= "table" then
            return false, "TARGET_COUNT requires table value"
        end
        if not value.operator then
            return false, "TARGET_COUNT missing operator"
        end
        if value.operator == "range" then
            if value.min == nil or value.max == nil then
                return false, "TARGET_COUNT range requires min and max"
            end
            if tonumber(value.min) and tonumber(value.max) and tonumber(value.min) > tonumber(value.max) then
                return false, "TARGET_COUNT range min cannot be greater than max"
            end
        else
            local targetValue = value.value or value.count
            if targetValue == nil then
                return false, "TARGET_COUNT requires value"
            end
            value.value = targetValue
        end
        condition.value = value
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE then
        local value = condition.value or condition.weaponType
        if value == nil or value == "" then
            return false, "WEAPON_TYPE requires value"
        end
        condition.value = value
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.AURA_ACTIVE then
        local value = ExtractConditionValue(condition, true)
        if type(value) ~= "table" then
            return false, "AURA_ACTIVE requires table value"
        end
        if not value.spellId and not value.spellID then
            return false, "AURA_ACTIVE requires spellId"
        end
        condition.value = value
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.GROUP_CONTEXT then
        if type(condition.value) ~= "table" and type(condition.value) ~= "string" then
            return false, "GROUP_CONTEXT requires table or string value"
        end
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.ASSIGNMENT then
        if type(condition.value) ~= "table" and type(condition.value) ~= "string" then
            return false, "ASSIGNMENT requires table or string value"
        end
        -- Validate that assignment IDs exist in class assignments
        local classModule = NAG:GetClassModule()
        if classModule then
            local assignments = classModule.defaults.class.classAssignments or {}
            local assignmentIds = {}
            for _, assignment in ipairs(assignments) do
                assignmentIds[assignment.id] = true
            end
            local value = condition.value
            if type(value) == "table" then
                for _, assignmentId in ipairs(value) do
                    if not assignmentIds[assignmentId] then
                        return false, "ASSIGNMENT contains invalid assignment ID: " .. tostring(assignmentId)
                    end
                end
            elseif type(value) == "string" then
                if not assignmentIds[value] then
                    return false, "ASSIGNMENT contains invalid assignment ID: " .. tostring(value)
                end
            end
        end
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.CUSTOM_FUNCTION then
        local code = condition.value or condition.luaCode
        if not code then
            return false, "CUSTOM_FUNCTION requires value"
        end
        -- Validate custom function syntax
        local valid, err = Validation.ValidateLuaSyntax(code, "Custom function")
        if not valid then
            return false, err
        end
        condition.value = code
    end

    return true
end

-- ============================ SCHEMA-BASED VALIDATION ============================

--- Validate a NAG function node against APL schema
--- @param node table AST node (type="function" or type="action")
--- @param context string "condition" or "action"
--- @return boolean True if valid
--- @return string|nil Error message if invalid
function Validation:ValidateNAGFunction(node, context)
    if not node then
        return true, nil
    end

    NAG:Debug("[Validation] ValidateNAGFunction: nodeType='%s', context='%s'", node.type or "nil", context or "nil")

    -- Delegate to AST modules for validation (uses protobuf methodology)
    if node.type == ASTCore.NodeType.ACTION then
        local valid, error = ASTAction.ValidateFields(node)
        if not valid then
            NAG:Debug("[Validation] ValidateNAGFunction: ASTAction.ValidateFields failed: %s", error or "unknown error")
        end
        return valid, error
    elseif node.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        -- Skip operators (validated structurally)
        if valueType and valueType ~= ASTValue.ValueType.CONST and
           valueType ~= ASTValue.ValueType.AND and valueType ~= ASTValue.ValueType.OR and
           valueType ~= ASTValue.ValueType.NOT and valueType ~= ASTValue.ValueType.CMP and
           valueType ~= ASTValue.ValueType.MATH then
            -- Function call value node
            local valid, error = ASTValue.ValidateFields(node)
            if not valid then
                NAG:Debug("[Validation] ValidateNAGFunction: ASTValue.ValidateFields failed: %s", error or "unknown error")
            end
            return valid, error
        end
    else
        -- Non-proto AST node type (developer code issue)
        NAG:Warn("[Validation] Invalid node type: %s - expected proto AST", tostring(node.type))
        return false, format("Invalid node type: %s - expected proto AST", tostring(node.type))
    end

    return true, nil
end

--- Walk AST tree and validate all NAG functions
--- @param node table AST node to validate
--- @param context string "condition" or "action"
--- @return boolean True if all nodes valid
--- @return string|nil First error message encountered
function Validation:ValidateASTNode(node, context)
    if not node then
        return true, nil
    end

    -- Validate this node if it's a function or action (proto AST)
    local nodeType = node.type
    if nodeType == ASTCore.NodeType.VALUE then
        -- Value node - could be function call, logical, comparison, math, or constant
        local valueType = ASTValue.GetValueType(node)
        if valueType and valueType ~= ASTValue.ValueType.CONST and
           valueType ~= ASTValue.ValueType.AND and valueType ~= ASTValue.ValueType.OR and
           valueType ~= ASTValue.ValueType.NOT and valueType ~= ASTValue.ValueType.CMP and
           valueType ~= ASTValue.ValueType.MATH then
            -- Function call value node
            local valid, err = self:ValidateNAGFunction(node, context)
            if not valid then
                return false, err
            end
        end
    elseif nodeType == ASTCore.NodeType.ACTION then
        -- Action node
        local valid, err = self:ValidateNAGFunction(node, context)
        if not valid then
            return false, err
        end
    end

    -- Recursively validate children (proto AST structure)
    if nodeType == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        local valueData = ASTValue.GetValueData(node)

        if ASTValue.IsLogicalOp(node) then
            -- Logical operation - validate children
            local children = {}
            if valueType == ASTValue.ValueType.NOT then
                if valueData and valueData.val then
                    children = { valueData.val }
                end
            else
                children = valueData and valueData.vals or {}
            end
            for _, child in ipairs(children) do
                local valid, err = self:ValidateASTNode(child, context)
                if not valid then
                    return false, err
                end
            end
        elseif ASTValue.IsComparison(node) or ASTValue.IsMathOp(node) then
            -- Comparison or math - validate lhs and rhs
            if valueData then
                if valueData.lhs then
                    local valid, err = self:ValidateASTNode(valueData.lhs, context)
                    if not valid then
                        return false, err
                    end
                end
                if valueData.rhs then
                    local valid, err = self:ValidateASTNode(valueData.rhs, context)
                    if not valid then
                        return false, err
                    end
                end
            end
        elseif valueType and valueType ~= ASTValue.ValueType.CONST then
            -- Function call - validate arguments from valueData
            if valueData then
                for fieldName, fieldValue in pairs(valueData) do
                    if type(fieldValue) == "table" and fieldValue.type then
                        -- Complex argument (value node)
                        local valid, err = self:ValidateASTNode(fieldValue, context)
                        if not valid then
                            return false, err
                        end
                    end
                end
            end
        end
    end

    -- Check for legacy format nodes (should not exist - proto AST required)
    local isLegacy, legacyError = DetectAndLogLegacyFormat(node, nodeType, context)
    if isLegacy then
        return false, legacyError
    end

    return true, nil
end

--- Validate a parsed clause AST with schema checking
--- @param clause table Parsed clause AST
--- @return boolean True if valid
--- @return string|nil Error message if invalid
function Validation:ValidateClauseAST(clause)
    if not clause then
        return false, "No clause provided"
    end

    -- Validate condition (if present)
    if clause.condition then
        local valid, err = self:ValidateASTNode(clause.condition, "condition")
        if not valid then
            return false, "Condition: " .. err
        end
    end

    -- Validate action (required)
    if not clause.action then
        return false, "Clause has no action"
    end

    local valid, err = self:ValidateASTNode(clause.action, "action")
    if not valid then
        return false, "Action: " .. err
    end

    return true, nil
end

return Validation

