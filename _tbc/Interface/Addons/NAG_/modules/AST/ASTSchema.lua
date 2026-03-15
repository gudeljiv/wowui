--- @module "ASTSchema"
--- Proto schema validation for AST nodes
--- Validates AST structure against apl.proto schema definitions
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local ASTRotation = ns.ASTRotation
local ASTVisitor = ns.ASTVisitor

--- @class ASTSchema
local ASTSchema = {}
ns.ASTSchema = ASTSchema

-- ============================ SCHEMA VALIDATION ============================

local function SanitizeIssue(issue, index)
    if type(issue) ~= "table" then
        NAG:Warn("[ASTSchema] Issue #%d is not a table; substituting defaults", index or -1)
        return "UNKNOWN", "Issue metadata missing", "root"
    end

    local issueType = issue.type
    if not issueType then
        issueType = "UNKNOWN"
        NAG:Info("[ASTSchema] Issue #%d missing type; defaulting to 'UNKNOWN'", index or -1)
    end

    local issueMessage = issue.message
    if issueMessage == nil then
        issueMessage = "No message provided"
        NAG:Info("[ASTSchema] Issue #%d missing message; defaulting to placeholder text", index or -1)
    elseif type(issueMessage) ~= "string" then
        issueMessage = tostring(issueMessage)
        NAG:Info("[ASTSchema] Issue #%d message coerced to string", index or -1)
    end

    local issuePath = issue.path
    if issuePath == nil then
        issuePath = "root"
        NAG:Info("[ASTSchema] Issue #%d missing path; defaulting to 'root'", index or -1)
        issue.path = issuePath
    elseif type(issuePath) ~= "string" then
        issuePath = tostring(issuePath)
        NAG:Info("[ASTSchema] Issue #%d path coerced to string", index or -1)
        issue.path = issuePath
    end

    return issueType, issueMessage, issuePath
end

--- Validate an AST node against proto schema
--- @param node ASTNode AST node to validate
--- @return boolean success
--- @return table[]|nil issues Array of validation issues
function ASTSchema.Validate(node)
    if not node then
        NAG:Warn("[ASTSchema] Validate received nil node; returning NULL_NODE issue")
        return false, {{ type = "NULL_NODE", message = "Node is null", path = "root" }}
    end

    if type(node) ~= "table" then
        local nodeType = type(node)
        NAG:Warn("[ASTSchema] Validate fallback: expected table node but received %s", nodeType)
        return false, {{
            type = "INVALID_NODE_TYPE",
            message = string.format("Node must be a table, received %s", nodeType),
            path = "root"
        }}
    end

    if type(node.validate) ~= "function" then
        local descriptor = node.type or "unknown"
        NAG:Warn("[ASTSchema] Validate fallback: node missing validate() method (nodeType=%s)", tostring(descriptor))
        return false, {{
            type = "MISSING_VALIDATE_METHOD",
            message = "Node missing validate() method",
            path = "root"
        }}
    end

    local issues = {}

    -- Validate node structure
    local valid, err = node:validate()
    if not valid then
        NAG:Info("[ASTSchema] Structural validation failed for node type '%s': %s", tostring(node.type), tostring(err))
        table.insert(issues, {
            type = "INVALID_STRUCTURE",
            message = err or "Node validation failed",
            path = "root"
        })
    end

    -- Validate node tree
    ASTSchema.ValidateTree(node, "root", issues)

    return #issues == 0, #issues > 0 and issues or nil
end

--- Recursively validate AST tree
--- @param node table AST node
--- @param path string Current path for error reporting
--- @param issues table[] Array to collect issues
function ASTSchema.ValidateTree(node, path, issues)
    if not node or type(node) ~= "table" then
        table.insert(issues, {
            type = "INVALID_NODE",
            message = "Node is not a table",
            path = path
        })
        return
    end

    -- Validate based on node type
    if ASTCore.IsNode(node) then
        if node.type == ASTCore.NodeType.ACTION then
            ASTSchema.ValidateActionNode(node, path, issues)
        elseif node.type == ASTCore.NodeType.VALUE then
            ASTSchema.ValidateValueNode(node, path, issues)
        elseif node.type == ASTCore.NodeType.ROTATION then
            ASTSchema.ValidateRotationNode(node, path, issues)
        end
    else
        -- Legacy node - skip detailed validation
        return
    end
end

--- Validate action node
--- @param node ASTNode Action node
--- @param path string Current path
--- @param issues table[] Issues array
function ASTSchema.ValidateActionNode(node, path, issues)
    if not node.action then
        table.insert(issues, {
            type = "MISSING_ACTION",
            message = "ACTION node missing action field",
            path = path
        })
        return
    end

    -- Validate action type is set
    local actionType = ASTAction.GetActionType(node)
    if not actionType then
        table.insert(issues, {
            type = "EMPTY_ACTION",
            message = "ACTION node has no action type set (pending selection)",
            path = path,
            severity = "warning"  -- Not an error - valid for VariableRef, pending user selection
        })
        -- Still validate condition if present, then return
        if node.condition then
            ASTSchema.ValidateTree(node.condition, path .. ".condition", issues)
        end
        return
    end

    -- Validate condition if present
    if node.condition then
        ASTSchema.ValidateTree(node.condition, path .. ".condition", issues)
    end

    -- Use ASTAction.ValidateFields for schema-driven field validation
    NAG:Trace("[ASTSchema] ValidateActionNode: calling ASTAction.ValidateFields for actionType='%s' at path='%s'", actionType or "nil", path)
    local valid, error, validationInfo = ASTAction.ValidateFields(node)
    if not valid then
        NAG:Warn("[ASTSchema] ValidateActionNode: field validation failed for actionType='%s' at path='%s': %s", actionType or "nil", path, error or "unknown error")
        table.insert(issues, {
            type = "INVALID_FIELDS",
            message = error or "Field validation failed",
            path = path,
            validationInfo = validationInfo  -- Include detailed validation info
        })
    else
        NAG:Info("[ASTSchema] ValidateActionNode: field validation passed for actionType='%s' at path='%s'", actionType or "nil", path)
    end
end

--- Validate value node
--- @param node ASTNode Value node
--- @param path string Current path
--- @param issues table[] Issues array
function ASTSchema.ValidateValueNode(node, path, issues)
    if not node.value then
        table.insert(issues, {
            type = "MISSING_VALUE",
            message = "VALUE node missing value field",
            path = path
        })
        return
    end

    -- Validate value type is set
    local valueType = ASTValue.GetValueType(node)
    if not valueType then
        table.insert(issues, {
            type = "NO_VALUE_TYPE",
            message = "VALUE node has no value type set",
            path = path
        })
        return
    end

    local valueData = ASTValue.GetValueData(node)

    -- Validate operators have required fields
    if valueType == "cmp" then
        if not valueData.op then
            table.insert(issues, {
                type = "MISSING_OPERATOR",
                message = "cmp value missing op field",
                path = path
            })
        end
        if not valueData.lhs then
            table.insert(issues, {
                type = "MISSING_LHS",
                message = "cmp value missing lhs",
                path = path
            })
        else
            ASTSchema.ValidateTree(valueData.lhs, path .. ".lhs", issues)
        end
        if not valueData.rhs then
            table.insert(issues, {
                type = "MISSING_RHS",
                message = "cmp value missing rhs",
                path = path
            })
        else
            ASTSchema.ValidateTree(valueData.rhs, path .. ".rhs", issues)
        end

    elseif valueType == "and" or valueType == "or" then
        if not valueData.vals or #valueData.vals == 0 then
            table.insert(issues, {
                type = "MISSING_OPERANDS",
                message = string.format("%s operator has no operands", valueType),
                path = path
            })
        else
            for i, val in ipairs(valueData.vals) do
                ASTSchema.ValidateTree(val, string.format("%s.vals[%d]", path, i), issues)
            end
        end

    elseif valueType == "not" then
        if not valueData.val then
            table.insert(issues, {
                type = "MISSING_OPERAND",
                message = "not operator missing operand",
                path = path
            })
        else
            ASTSchema.ValidateTree(valueData.val, path .. ".val", issues)
        end
    else
        -- Function call value node - validate fields using schema
        NAG:Trace("[ASTSchema] ValidateValueNode: calling ASTValue.ValidateFields for valueType='%s' at path='%s'", valueType or "nil", path)
        local valid, error, validationInfo = ASTValue.ValidateFields(node)
        if not valid then
            NAG:Warn("[ASTSchema] ValidateValueNode: field validation failed for valueType='%s' at path='%s': %s", valueType or "nil", path, error or "unknown error")
            table.insert(issues, {
                type = "INVALID_FIELDS",
                message = error or "Field validation failed",
                path = path,
                validationInfo = validationInfo
            })
        else
            NAG:Info("[ASTSchema] ValidateValueNode: field validation passed for valueType='%s' at path='%s'", valueType or "nil", path)
        end
    end
end

--- Validate rotation node
--- @param node ASTNode Rotation node
--- @param path string Current path
--- @param issues table[] Issues array
function ASTSchema.ValidateRotationNode(node, path, issues)
    if not node.priority_list then
        table.insert(issues, {
            type = "MISSING_PRIORITY_LIST",
            message = "ROTATION node missing priority_list",
            path = path
        })
        return
    end

    -- Validate priority list items
    for i, listItem in ipairs(node.priority_list) do
        if not listItem.action then
            table.insert(issues, {
                type = "MISSING_ACTION",
                message = string.format("priority_list[%d] missing action", i),
                path = string.format("%s.priority_list[%d]", path, i)
            })
        else
            ASTSchema.ValidateTree(listItem.action, string.format("%s.priority_list[%d].action", path, i), issues)
        end
    end

    -- Validate groups
    for i, group in ipairs(node.groups or {}) do
        if not group.name or group.name == "" then
            table.insert(issues, {
                type = "MISSING_GROUP_NAME",
                message = string.format("groups[%d] missing name", i),
                path = string.format("%s.groups[%d]", path, i)
            })
        end
    end
end

--- Check if an AST is proto-compatible (can be exported to WoWSims)
--- @param node ASTNode AST node
--- @return boolean compatible
--- @return string|nil error Error message if not compatible
function ASTSchema.IsProtoCompatible(node)
    local valid, issues = ASTSchema.Validate(node)

    if not valid then
        local totalIssues = issues and #issues or 0
        NAG:Warn("[ASTSchema] Proto compatibility validation failed with %d issue(s)", totalIssues)

        local errorMsg = "Proto schema validation failed:"
        for index, issue in ipairs(issues or {}) do
            local issueType, issueMessage, issuePath = SanitizeIssue(issue, index)
            errorMsg = errorMsg .. string.format("\n  [%s] %s at %s", issueType, issueMessage, issuePath)
        end
        return false, errorMsg
    end

    return true, nil
end

return ASTSchema

