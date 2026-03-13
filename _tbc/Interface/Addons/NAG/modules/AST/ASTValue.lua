--- @module "ASTValue"
--- Value node types matching APLValue message from apl.proto
--- Handles operators, comparisons, and all value types
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

--- @class ASTValue
local ASTValue = {}
ns.ASTValue = ASTValue

-- ============================ VALUE TYPES ============================

--- Proto value types matching APLValue oneof
ASTValue.ValueType = {
    -- Operators
    CONST = "const",
    AND = "and",
    OR = "or",
    NOT = "not",
    CMP = "cmp",
    MATH = "math",
    MAX = "max",
    MIN = "min",


    -- Variable
    VARIABLE_REF = "variable_ref",
    VARIABLE_PLACEHOLDER = "variable_placeholder",
}

--- Comparison operators matching APLValueCompare.ComparisonOperator
ASTValue.ComparisonOperator = {
    UNKNOWN = "OpUnknown",
    EQ = "OpEq",  -- ==
    NE = "OpNe",  -- !=
    LT = "OpLt",  -- <
    LE = "OpLe",  -- <=
    GT = "OpGt",  -- >
    GE = "OpGe",  -- >=
}

--- Math operators matching APLValueMath.MathOperator
ASTValue.MathOperator = {
    UNKNOWN = "OpUnknown",
    ADD = "OpAdd",  -- +
    SUB = "OpSub",  -- -
    MUL = "OpMul",  -- *
    DIV = "OpDiv",  -- /
}

-- ============================ FACTORY FUNCTIONS ============================

--- Create a value node
--- @param valueType string|nil The value type
--- @param valueData table Value-specific data
--- @return ASTNode
function ASTValue.Create(valueType, valueData)
    if NAG.debug then
        NAG:Info("[ASTValue] Create: Creating value node (valueType='%s')", valueType or "nil")
    end

    if not valueType then
        NAG:Warn("[ASTValue] Create: valueType is nil - creating invalid value node")
    end

    local node = ASTCore.CreateNode(ASTCore.NodeType.VALUE)
    if valueType then
        node.value[valueType] = valueData or {}
    else
        node.__invalid = node.__invalid or {}
        node.__invalid.missingValueType = true
    end

    if NAG.debug then
        NAG:Info("[ASTValue] Create: Successfully created value node (valueType='%s')", valueType or "nil")
    end
    return node
end

--- Create a constant value
--- @param val string|number The constant value
--- @return ASTNode
function ASTValue.CreateConst(val)
    return ASTValue.Create(ASTValue.ValueType.CONST, { val = tostring(val) })
end

--- Create an AND logical operation
--- @param vals table[] Array of APLValue nodes
--- @return ASTNode
function ASTValue.CreateAnd(vals)
    return ASTValue.Create(ASTValue.ValueType.AND, { vals = vals or {} })
end

--- Create an OR logical operation
--- @param vals table[] Array of APLValue nodes
--- @return ASTNode
function ASTValue.CreateOr(vals)
    return ASTValue.Create(ASTValue.ValueType.OR, { vals = vals or {} })
end

--- Create a NOT logical operation
--- @param val table APLValue node
--- @return ASTNode
function ASTValue.CreateNot(val)
    return ASTValue.Create(ASTValue.ValueType.NOT, { val = val })
end

--- Create a comparison operation
--- @param op string Comparison operator (from ComparisonOperator)
--- @param lhs table Left-hand side APLValue
--- @param rhs table Right-hand side APLValue
--- @return ASTNode
function ASTValue.CreateCmp(op, lhs, rhs)
    return ASTValue.Create(ASTValue.ValueType.CMP, {
        op = op,
        lhs = lhs,
        rhs = rhs
    })
end

--- Normalize operator operand to proto AST node
--- Ensures operands are always proto AST nodes, wrapping strings/numbers in const nodes
--- @param operand any String, number, or proto AST node
--- @return table Proto AST value node
function ASTValue.NormalizeOperand(operand)
    if not operand then
        NAG:Warn("ASTValue.NormalizeOperand: nil operand provided, creating default const(0)")
        return ASTValue.CreateConst(0)
    end

    if type(operand) == "table" and operand.type == ASTCore.NodeType.VALUE then
        return operand  -- Already a proto AST node
    elseif type(operand) == "string" or type(operand) == "number" then
        return ASTValue.CreateConst(operand)  -- Wrap in const node
    else
        NAG:Warn("ASTValue.NormalizeOperand: Invalid operand type: %s, creating default const(0)", type(operand))
        NAG:Warn("[ASTValue] FALLBACK TRACKING: Using default const(0) fallback in NormalizeOperand() for invalid operand type='%s'", type(operand))
        return ASTValue.CreateConst(0)  -- Default fallback
    end
end

--- Create a math operation
--- @param op string Math operator (from MathOperator)
--- @param lhs table Left-hand side APLValue
--- @param rhs table Right-hand side APLValue
--- @return ASTNode
function ASTValue.CreateMath(op, lhs, rhs)
    return ASTValue.Create(ASTValue.ValueType.MATH, {
        op = op,
        lhs = lhs,
        rhs = rhs
    })
end

--- Create a variable reference
--- @param varName string Variable name
--- @return ASTNode
function ASTValue.CreateVariableRef(varName)
    return ASTValue.Create(ASTValue.ValueType.VARIABLE_REF, {
        name = varName
    })
end

--- Create a value node from fields using schema metadata and FieldFormatConverter
--- @param valueType string The value type identifier (snake_case, e.g., "spell_is_ready")
--- @param fields table|nil Field values (keyed by schema field names in snake_case)
--- @return ASTNode
function ASTValue.CreateFromFields(valueType, fields)
    EnsureSchemaModules()

    if not valueType then
        NAG:Warn("[ASTValue] CreateFromFields: valueType is nil - falling back to Create with nil valueType")
        return ASTValue.Create(nil, nil)
    end

    -- Get schema metadata for this value type
    local metadata
    if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
        metadata = SchemaAccessor:GetMetadataByIdentifier(valueType, nil)
    end

    if not metadata or not metadata.messageSchema then
        NAG:Warn("[ASTValue] CreateFromFields: Schema metadata not found for valueType='%s' - using raw fields",
            valueType)
        -- Fallback: create with raw fields if schema not available
        NAG:Warn("[ASTValue] FALLBACK TRACKING: Using raw fields fallback in CreateFromFields() for valueType='%s' (schema metadata unavailable)", tostring(valueType))
        return ASTValue.Create(valueType, fields or {})
    end

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

    return ASTValue.Create(valueType, normalizedFields)
end

-- ============================ QUERY FUNCTIONS ============================

--- Get the value type from a value node
--- @param node ASTNode Value node
--- @return string|nil Value type
function ASTValue.GetValueType(node)
    if not node or node.type ~= ASTCore.NodeType.VALUE then
        return nil
    end

    for valueType, data in pairs(node.value or {}) do
        if data then
            return valueType
        end
    end

    return nil
end

--- Get the value data from a value node
--- @param node ASTNode Value node
--- @return table|nil Value data
function ASTValue.GetValueData(node)
    if not node or node.type ~= ASTCore.NodeType.VALUE then
        return nil
    end

    local valueType = ASTValue.GetValueType(node)
    if valueType then
        return node.value[valueType]
    end

    return nil
end

--- Check if value is a constant
--- @param node ASTNode Value node
--- @return boolean
function ASTValue.IsConst(node)
    return ASTValue.GetValueType(node) == ASTValue.ValueType.CONST
end

--- Check if value is a logical operator
--- @param node ASTNode Value node
--- @return boolean
function ASTValue.IsLogicalOp(node)
    local valueType = ASTValue.GetValueType(node)
    return valueType == ASTValue.ValueType.AND
        or valueType == ASTValue.ValueType.OR
        or valueType == ASTValue.ValueType.NOT
end

--- Check if value is a comparison
--- @param node ASTNode Value node
--- @return boolean
function ASTValue.IsComparison(node)
    return ASTValue.GetValueType(node) == ASTValue.ValueType.CMP
end

--- Check if value is a math operation
--- @param node ASTNode Value node
--- @return boolean
function ASTValue.IsMathOp(node)
    return ASTValue.GetValueType(node) == ASTValue.ValueType.MATH
end

--- Check if value is a spell check
--- @param node ASTNode Value node
--- @return boolean
function ASTValue.IsSpellCheck(node)
    local valueType = ASTValue.GetValueType(node)
    return valueType and valueType:match("^spell_") ~= nil or false
end

--- Check if value is an aura check
--- @param node ASTNode Value node
--- @return boolean
function ASTValue.IsAuraCheck(node)
    local valueType = ASTValue.GetValueType(node)
    return valueType and (valueType:match("^aura_") ~= nil or valueType:match("^dot_") ~= nil) or false
end

--- Get constant value
--- @param node ASTNode Constant value node
--- @return string|nil
function ASTValue.GetConstValue(node)
    if not ASTValue.IsConst(node) then
        return nil
    end

    local data = ASTValue.GetValueData(node)
    return data and data.val
end

--- Convert comparison operator to symbol
--- @param op string Operator (OpEq, OpLt, etc.)
--- @return string Symbol (==, <, etc.)
function ASTValue.ComparisonOpToSymbol(op)
    local map = {
        OpEq = "==",
        OpNe = "~=",
        OpLt = "<",
        OpLe = "<=",
        OpGt = ">",
        OpGe = ">=",
    }
    return map[op] or op
end

--- Convert symbol to comparison operator
--- @param symbol string Symbol (==, <, etc.)
--- @return string Operator (OpEq, OpLt, etc.)
function ASTValue.SymbolToComparisonOp(symbol)
    local map = {
        ["=="] = "OpEq",
        ["!="] = "OpNe",
        ["~="] = "OpNe",
        ["<"] = "OpLt",
        ["<="] = "OpLe",
        [">"] = "OpGt",
        [">="] = "OpGe",
    }
    return map[symbol] or "OpUnknown"
end

--- Convert math operator to symbol
--- @param op string Operator (OpAdd, OpMul, etc.)
--- @return string Symbol (+, *, etc.)
function ASTValue.MathOpToSymbol(op)
    local map = {
        OpAdd = "+",
        OpSub = "-",
        OpMul = "*",
        OpDiv = "/",
    }
    return map[op] or op
end

--- Convert symbol to math operator
--- @param symbol string Symbol (+, *, etc.)
--- @return string Operator (OpAdd, OpMul, etc.)
function ASTValue.SymbolToMathOp(symbol)
    local map = {
        ["+"] = "OpAdd",
        ["-"] = "OpSub",
        ["*"] = "OpMul",
        ["/"] = "OpDiv",
    }
    return map[symbol] or "OpUnknown"
end

-- ============================ VALIDATION FUNCTIONS ============================

--- Validate value node fields against proto schema
--- Uses SchemaValidator's protobuf methodology: identifier → metadata → protoName → schema validation
--- @param node ASTNode Value node to validate
--- @return boolean valid Whether fields are valid
--- @return string|nil error Error message if validation failed
--- @return table|nil validationInfo Additional validation information from SchemaValidator
function ASTValue.ValidateFields(node)
    if not node or node.type ~= ASTCore.NodeType.VALUE then
        return false, "Invalid value node"
    end

    local valueType = ASTValue.GetValueType(node)
    if not valueType then
        return false, "Value node has no value type set"
    end

    -- Skip validation for operators (handled structurally)
    if valueType == ASTValue.ValueType.CONST or
       valueType == ASTValue.ValueType.AND or
       valueType == ASTValue.ValueType.OR or
       valueType == ASTValue.ValueType.NOT or
       valueType == ASTValue.ValueType.CMP or
       valueType == ASTValue.ValueType.MATH then
        return true, nil  -- Operators validated structurally, not by schema
    end

    local valueData = ASTValue.GetValueData(node)
    if not valueData then
        return true, nil  -- No fields to validate
    end

    -- Get metadata using protobuf methodology
    EnsureSchemaModules()
    if not SchemaAccessor then
        return false, "SchemaAccessor not available"
    end

    local metadata = SchemaAccessor:GetMetadataByIdentifier(valueType, nil)
    if not metadata or not metadata.protoName then
        NAG:Warn("[ASTValue] ValidateFields: Unknown value type '%s' (metadata missing)", valueType)
        return false, string.format("Unknown value type: %s (metadata missing)", valueType)
    end

    local protoName = metadata.protoName
    if NAG.debug then
        NAG:Trace("[ASTValue] ValidateFields: valueType='%s', protoName='%s'", valueType, protoName)
    end

    -- Use SchemaValidator for field-level validation (protobuf methodology)
    local SchemaValidator = NAG:GetModule("SchemaValidator")
    if not SchemaValidator then
        if NAG.debug then
            NAG:Trace("[ASTValue] ValidateFields: SchemaValidator not available, skipping field validation for '%s'", valueType)
        end
        return true, nil  -- SchemaValidator not available
    end

    -- Validate by field names using proto schema
    local valid, error, validationInfo = SchemaValidator:ValidateByFieldNames(protoName, valueData)
    if not valid then
        NAG:Warn("[ASTValue] ValidateFields failed: valueType='%s', protoName='%s', error='%s'", valueType, protoName, error or "unknown")
    else
        if NAG.debug then
            NAG:Info("[ASTValue] ValidateFields: valueType='%s' validated successfully", valueType)
        end
    end
    return valid, error, validationInfo
end

return ASTValue

