--- @module "ASTSchemaEmitter"
--- Schema-aware emitter for generating rotation strings from proto AST nodes
--- Always synthesizes from structured AST data - no originalText fallbacks
--- Synthesis failures are logged at Warn level and return error placeholders
--- License: CC BY-NC 4.0
--- Authors: GPT-5 Codex

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue

local SchemaValidator
local SchemaAccessor
local SchemaUtils

--- @class ASTSchemaEmitter
local ASTSchemaEmitter = {}
ns.ASTSchemaEmitter = ASTSchemaEmitter

-- ============================ INTERNAL CONSTANTS ============================

local UNIT_REFERENCE_LABELS = {
    [1] = "\"player\"",
    [2] = "\"target\"",
    [3] = "\"pet\"",
    [4] = "\"self\"",
    [5] = "\"currenttarget\"",
    [6] = "\"allplayers\"",
    [7] = "\"alltargets\"",
    [8] = "\"previoustarget\"",
    [9] = "\"nexttarget\"",
}

local LOGICAL_OPERATORS = {
    [ASTValue.ValueType.AND] = "and",
    [ASTValue.ValueType.OR] = "or",
}

local MATH_FUNCTIONS = {
    [ASTValue.ValueType.MIN] = "math.min",
    [ASTValue.ValueType.MAX] = "math.max",
}

local COMPARISON_SYMBOL_DEFAULT = "=="

-- ============================ INITIALIZATION ============================

local function EnsureSchemaModules()
    if not SchemaValidator then
        SchemaValidator = NAG:GetModule("SchemaValidator", true)
    end
    if not SchemaAccessor then
        SchemaAccessor = NAG:GetModule("SchemaAccessor", true)
    end
    if not SchemaUtils then
        SchemaUtils = NAG:GetModule("SchemaUtils", true)
    end
end

-- ============================ HELPER UTILITIES ============================

local function EscapeStringLiteral(value)
    return value
        :gsub("\\", "\\\\")
        :gsub("\"", "\\\"")
        :gsub("\n", "\\n")
        :gsub("\t", "\\t")
end

local function EmitScalarLiteral(rawValue, valueNode, forceQuote)
    if rawValue == nil then
        return "nil"
    end

    local valueType = type(rawValue)
    if valueType == "boolean" or valueType == "number" then
        return tostring(rawValue)
    end

    if valueType == "string" then
        local trimmed = rawValue:match("^%s*(.-)%s*$")

        -- If value is already quoted (starts and ends with quotes), unquote it first
        -- This prevents double-escaping of quotes
        if trimmed:match('^".*"$') or trimmed:match("^'.*'$") then
            -- Remove surrounding quotes
            trimmed = trimmed:match('^["\'](.*)["\']$') or trimmed
            -- Unescape any escaped quotes inside
            trimmed = trimmed:gsub('\\"', '"'):gsub("\\'", "'")
        end

        -- If forceQuote is true, quote unless the value is code (e.g. string.format(...)) that must run at runtime
        if forceQuote then
            -- Emit unquoted if it looks like a function call so round-trip preserves expressions
            if trimmed:match("^%s*[%w_%.]+%s*%(") then
                return trimmed
            end
            return string.format("\"%s\"", EscapeStringLiteral(trimmed))
        end

        local lower = trimmed:lower()
        if lower == "true" or lower == "false" or lower == "nil" then
            return lower
        end

        local numeric = tonumber(trimmed)
        if numeric then
            return trimmed
        end

        -- Check if this looks like code (function call, enum identifier, etc.) - emit as-is without quotes
        local hasParens = trimmed:match("%(")
        local hasNAGPrefix = trimmed:match("^NAG%.")
        local isAllCapsIdentifier = trimmed:match("^[A-Z][A-Z0-9_%.]*$")
        local isFunctionExpression = (valueNode and valueNode.isFunctionExpression) or
                                     trimmed:match("^function%s*%(")
        local isWoWAPICall = valueNode and valueNode.isWoWAPICall

        -- Debug logging for function expression detection
        if isFunctionExpression then
            NAG:Debug("[ASTSchemaEmitter] EmitScalarLiteral: Detected function expression - valueNode.isFunctionExpression=%s, pattern_match=%s, rawValue='%s'",
                tostring(valueNode and valueNode.isFunctionExpression or false),
                tostring(trimmed:match("^function%s*%(") ~= nil),
                trimmed:sub(1, 100))
        end

        -- For WoW API calls, always emit unquoted (they have function call syntax)
        if isWoWAPICall then
            NAG:Debug("[ASTSchemaEmitter] EmitScalarLiteral: Detected WoW API call - funcName='%s', emitting unquoted: '%s'",
                tostring(valueNode and valueNode.funcName or "nil"),
                trimmed:sub(1, 100))
            return trimmed
        end

        if hasParens or hasNAGPrefix or isAllCapsIdentifier or isFunctionExpression then
            if isFunctionExpression then
                NAG:Debug("[ASTSchemaEmitter] EmitScalarLiteral: Emitting function expression unquoted: '%s'", trimmed:sub(1, 100))
            end
            return trimmed
        end

        -- Only log if it looks like it might be a function expression that we missed
        if trimmed:match("function") then
            NAG:Debug("[ASTSchemaEmitter] EmitScalarLiteral: Quoting value that contains 'function' (might be missed function expression): '%s'", trimmed:sub(1, 100))
            NAG:Warn("[ASTSchemaEmitter] EmitScalarLiteral: Quoting value that contains 'function' (might be missed function expression): '%s'", trimmed:sub(1, 100))
        end

        return string.format("\"%s\"", EscapeStringLiteral(trimmed))
    end

    if valueType == "table" then
        if rawValue.spell_id or rawValue.spellId then
            local idValue = rawValue.spell_id or rawValue.spellId
            return EmitScalarLiteral(idValue, nil, forceQuote)
        end
        if rawValue.id then
            return EmitScalarLiteral(rawValue.id, nil, forceQuote)
        end
    end

    return tostring(rawValue)
end

local function EmitEnumValue(enumName, enumValue)
    if enumName and enumValue ~= nil then
        EnsureSchemaModules()

        -- Use FieldFormatConverter for centralized enum-to-string conversion
        local FieldFormatConverter = ns.FieldFormatConverter
        if FieldFormatConverter and FieldFormatConverter.EnumValueToString then
            local result = FieldFormatConverter:EnumValueToString(enumValue, enumName)
            if result then
                return result
            end
        end

        -- Fallback if FieldFormatConverter not available (shouldn't happen)
        NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using SchemaAccessor fallback in EmitEnumValue() (FieldFormatConverter unavailable) for enumName='%s'", tostring(enumName))
        if SchemaAccessor then
            local label = SchemaAccessor:GetEnumLabel(enumName, enumValue)
            if label then
                return label
            end
        end
    end

    -- Fallback: if enumValue is a string identifier, emit as-is; otherwise use EmitScalarLiteral
    if type(enumValue) == "string" and (enumValue:match("^NAG%.") or enumValue:match("^[A-Z][A-Z0-9_%.]*$")) then
        return enumValue
    end

    return EmitScalarLiteral(enumValue)
end

local function EmitActionID(actionID)
    if not actionID then
        return nil
    end

    -- ActionID has a oneof: raw_id = { spell_id, item_id, other_id }
    -- Use FieldFormatConverter for consistent extraction
    local FieldFormatConverter = ns.FieldFormatConverter
    if FieldFormatConverter then
        local extractedID = FieldFormatConverter:ExtractActionID(actionID)
        if extractedID ~= nil then
            return EmitScalarLiteral(extractedID)
        end
    else
        -- Fallback to manual extraction if FieldFormatConverter unavailable
        NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using manual extraction fallback in EmitActionID() (FieldFormatConverter unavailable)")
        if actionID.spell_id ~= nil then
            -- spell_id can be a number or nested { spell_id = number } structure
            local spellId = actionID.spell_id
            if type(spellId) == "table" then
                spellId = spellId.spell_id or spellId.id or spellId
            end
            return EmitScalarLiteral(spellId)
        end
        if actionID.item_id ~= nil then
            -- item_id is an int32
            return EmitScalarLiteral(actionID.item_id)
        end
        if actionID.other_id ~= nil then
            -- other_id is an enum (OtherAction)
            -- Emit as enum value (will be handled by EmitEnumValue if needed)
            EnsureSchemaModules()
            if SchemaAccessor then
                local enumLabel = SchemaAccessor:GetEnumLabel("OtherAction", actionID.other_id)
                if enumLabel then
                    return enumLabel
                end
            end
            -- Fallback to numeric value if enum lookup fails
            NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using numeric value fallback in EmitActionID() for other_id (enum lookup failed)")
            return EmitScalarLiteral(actionID.other_id)
        end
    end

    -- tag field is optional and typically not emitted (it's metadata)
    -- But if it's the only field present, emit it
    if actionID.tag ~= nil then
        return EmitScalarLiteral(actionID.tag)
    end

    -- Fallback: try to extract from nested structures (error recovery)
    NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using nested structure extraction fallback in EmitActionID() (error recovery)")
    if type(actionID) == "table" then
        if actionID.id then
            return EmitScalarLiteral(actionID.id)
        end
        if actionID.value then
            return EmitScalarLiteral(actionID.value)
        end
    end

    -- If nothing found, return nil
    return nil
end

local function EmitUnitReference(unitRef)
    if not unitRef then
        return nil
    end

    -- Handle legacy unit string field (not in proto schema but may exist from conversion)
    if unitRef.unit and type(unitRef.unit) == "string" then
        -- Return as quoted string literal for rotation string (e.g., "player")
        return string.format("\"%s\"", EscapeStringLiteral(unitRef.unit))
    end

    local typeField = unitRef.type
    if type(typeField) == "number" then
        -- UnitReference types are small enum values (typically 1-10)
        -- Large numbers (> 20) are likely spell IDs incorrectly stored - reject them
        if typeField > 20 then
            return nil
        end

        -- Look up enum type in labels table
        if UNIT_REFERENCE_LABELS[typeField] then
            return UNIT_REFERENCE_LABELS[typeField]
        end
    end

    -- Handle nested owner reference
    if typeField == nil and unitRef.owner then
        local ownerValue = EmitUnitReference(unitRef.owner)
        if ownerValue then
            return ownerValue
        end
    end

    -- Don't emit invalid UnitReference - return nil to indicate this isn't a valid unit
    return nil
end

local function CloneArgumentsArray(value)
    local args = {}
    for index = 1, #value do
        args[index] = value[index]
    end
    return args
end

--- Emit a nested message type as a table literal (e.g., {font_size = 16, font_color = {r = 1.0, g = 0.0, b = 0.0, a = 1.0}})
--- @param messageData table The message data table
--- @param messageType string The message type name (e.g., "OverlayTextOptions")
--- @return string|nil The emitted table literal string, or nil if invalid
local function EmitMessageType(messageData, messageType)
    if not messageData or type(messageData) ~= "table" then
        return nil
    end

    EnsureSchemaModules()
    local SchemaAccessor = ns.SchemaAccessor
    if not SchemaAccessor then
        -- Fallback: emit as simple table
        NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using simple table literal fallback in EmitMessage() (SchemaAccessor unavailable)")
        return EmitTableLiteral(messageData)
    end

    local messageSchema = SchemaAccessor:GetMessageSchema(messageType)
    if not messageSchema or not messageSchema.fields or not messageSchema.field_order then
        -- No schema available - emit as simple table
        return EmitTableLiteral(messageData)
    end

    local fields = messageSchema.fields
    local fieldOrder = messageSchema.field_order
    local parts = {}

    -- Emit fields in schema order
    for _, fieldName in ipairs(fieldOrder) do
        local fieldValue = messageData[fieldName]
        if fieldValue ~= nil then
            local fieldInfo = fields[fieldName]
            if fieldInfo then
                local emittedValue = nil

                if fieldInfo.type == "message" then
                    -- Recursively emit nested message types
                    emittedValue = EmitMessageType(fieldValue, fieldInfo.message_type)
                elseif fieldInfo.type == "enum" then
                    emittedValue = EmitEnumValue(fieldInfo.enum_type, fieldValue)
                elseif fieldInfo.type == "string" then
                    emittedValue = EmitScalarLiteral(fieldValue)
                elseif fieldInfo.type == "int32" or fieldInfo.type == "int64" or fieldInfo.type == "double" or fieldInfo.type == "float" then
                    emittedValue = tostring(fieldValue)
                elseif fieldInfo.type == "bool" then
                    emittedValue = tostring(fieldValue)
                else
                    emittedValue = EmitScalarLiteral(fieldValue)
                end

                if emittedValue then
                    NAG:Debug("[ASTSchemaEmitter] EmitMessageType: Emitting field '%s' = %s", fieldName, emittedValue:sub(1, 100))
                    table.insert(parts, format("%s = %s", fieldName, emittedValue))
                end
            else
                -- Field not in schema - emit as-is (for backwards compatibility)
                local emittedValue = EmitScalarLiteral(fieldValue)
                if emittedValue then
                    NAG:Debug("[ASTSchemaEmitter] EmitMessageType: Emitting field '%s' (no schema) = %s", fieldName, emittedValue:sub(1, 100))
                    table.insert(parts, format("%s = %s", fieldName, emittedValue))
                end
            end
        end
    end

    if #parts == 0 then
        return "{}"
    end

    -- Use compact single-line format for rotation strings
    local result = format("{ %s }", table.concat(parts, ", "))
    NAG:Debug("[ASTSchemaEmitter] EmitMessageType: Emitted table literal for '%s': %s", messageType, result:sub(1, 200))
    return result
end

--- Emit a simple table as a table literal (fallback for tables without schema)
--- @param tableData table The table data
--- @return string The emitted table literal string
local function EmitTableLiteral(tableData)
    if not tableData or type(tableData) ~= "table" then
        return "{}"
    end

    local parts = {}
    for key, value in pairs(tableData) do
        local keyStr = type(key) == "string" and format("%s", key) or format("[%s]", tostring(key))
        local valueStr = nil

        if type(value) == "table" then
            valueStr = EmitTableLiteral(value)  -- Recursive for nested tables
        elseif type(value) == "string" then
            valueStr = format("\"%s\"", EscapeStringLiteral(value))
        else
            valueStr = tostring(value)
        end

        if valueStr then
            table.insert(parts, format("%s = %s", keyStr, valueStr))
        end
    end

    if #parts == 0 then
        return "{}"
    end

    -- Use compact single-line format for rotation strings
    return format("{ %s }", table.concat(parts, ", "))
end

-- ============================ VALUE EMISSION ============================

local function EmitValueNode(valueNode, context)
    if not valueNode then
        return ""
    end

    -- Default context: assume we need parentheses for operands
    context = context or {}
    local isTopLevel = context.isTopLevel or false

    -- Debug: Log node structure for troubleshooting
    if not valueNode.type then
        local keys = {}
        for k, v in pairs(valueNode) do
            keys[#keys + 1] = string.format("%s (type=%s)", tostring(k), type(v))
        end
        NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Node has no type field - checking for proto structure. Node keys: %s",
            table.concat(keys, ", "))
    else
        NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Node has type='%s' - full AST node", valueNode.type)
    end

    -- Detect proto structure { [valueType] = valueData } and reconstruct wrapper
    -- Proto structure is stored in valueData[fieldName] for APLValue fields (for validation)
    -- But EmitValueNode expects full wrapper node { type = "value", value = {...}, originalText = "..." }
    if type(valueNode) == "table" and not valueNode.type then
        -- This is proto structure, not a full wrapper - reconstruct wrapper node
        -- CRITICAL: Check for isFunctionExpression flag before reconstruction
        local hadFunctionFlag = valueNode.isFunctionExpression
        if hadFunctionFlag then
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Proto structure has isFunctionExpression flag before reconstruction")
        end
        -- Only iterate over valid value types to avoid picking up metadata keys or functions
        -- NOTE: We can't check against ASTValue.ValueType because schema-defined value types
        -- (like "dot_remaining_time", "spell_is_ready") are not in that set. Instead, we
        -- accept any string key with a table value that isn't a known metadata key.
        -- The schema will validate the value type later if needed.
        local knownMetadataKeys = {
            isFunctionExpression = true,
            isWoWAPICall = true,
            funcName = true,
            parsedArgs = true,
            isNil = true,
            isIdentifier = true,
            -- Additional safety: filter out keys that look like metadata (start with underscore or "is")
            -- But be careful - some value types might legitimately start with these patterns
        }
        local foundValidType = false
        for valueType, valueData in pairs(valueNode) do
            -- Skip known metadata keys and non-table values
            -- Accept any string key with a table value as a potential value type
            -- This allows schema-defined value types to pass through
            if type(valueType) == "string"
               and not knownMetadataKeys[valueType]
               and type(valueData) == "table" then
                -- Reconstruct full wrapper node from proto structure
                local reconstructedNode = ASTValue.Create(valueType, valueData)
                -- Preserve isFunctionExpression flag if it existed
                if hadFunctionFlag then
                    reconstructedNode.isFunctionExpression = true
                    NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Preserved isFunctionExpression flag in reconstructed node, valueType=%s", tostring(valueType))
                end
                valueNode = reconstructedNode
                foundValidType = true
                break
            end
        end
        -- If we didn't find a valid value type, this is an error - the node is malformed
        if not foundValidType then
            local foundKeys = {}
            for key, val in pairs(valueNode) do
                foundKeys[#foundKeys + 1] = string.format("%s (type=%s, valType=%s)", tostring(key), type(key), type(val))
            end
            NAG:Error("[ASTSchemaEmitter] EmitValueNode: Proto structure reconstruction failed - no valid value type found. Found keys: %s. This indicates a malformed node or incorrect path.", table.concat(foundKeys, ", "))
            -- Don't try to continue - return error immediately
            return "/* ERROR: Malformed proto structure - no value type found */"
        end
    end

    -- Prioritize synthesis from structured data - only use originalText as fallback
    local valueType = ASTValue.GetValueType(valueNode)
    local valueData = ASTValue.GetValueData(valueNode) or {}

    -- If GetValueType returned nil, this is an error - the node is malformed
    if not valueType then
        local nodeType = valueNode and valueNode.type or "nil"
        local valueKeys = {}
        if valueNode and valueNode.value then
            for k in pairs(valueNode.value) do
                valueKeys[#valueKeys + 1] = tostring(k)
            end
        end
        NAG:Error("[ASTSchemaEmitter] EmitValueNode: GetValueType returned nil. Node type='%s', value keys: %s. This indicates a malformed node.",
            nodeType, table.concat(valueKeys, ", ") or "none")
        return "/* ERROR: Malformed value node - GetValueType returned nil */"
    end


    if valueType == ASTValue.ValueType.CONST then
        -- Debug logging for CONST nodes (especially function expressions and WoW API calls)
        local valStr = tostring(valueData.val):sub(1, 100)
        if valueNode and valueNode.isFunctionExpression then
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Processing CONST node with isFunctionExpression flag, val='%s'", valStr)
        elseif valueNode and valueNode.isWoWAPICall then
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Processing CONST node with isWoWAPICall flag, funcName='%s', val='%s'",
                tostring(valueNode.funcName or "nil"), valStr)
        elseif valStr:match("function") then
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Processing CONST node that contains 'function' (checking if flag missing), val='%s', hasFlag=%s",
                valStr, tostring(valueNode and valueNode.isFunctionExpression or false))
        end
        local literal = EmitScalarLiteral(valueData.val, valueNode)
        if valueNode and valueNode.isFunctionExpression then
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: CONST node emitted as: '%s'", literal:sub(1, 100))
        elseif valueNode and valueNode.isWoWAPICall then
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: WoW API call CONST node emitted as: '%s'", literal:sub(1, 100))
        end
        return literal
    end

    if valueType == ASTValue.ValueType.NOT then
        -- NOT operand is not top-level, so pass context with isTopLevel=false
        local operandContext = context and { isTopLevel = false } or { isTopLevel = false }
        local operand = EmitValueNode(valueData.val, operandContext)
        if operand == "" then
            operand = "nil"
        end

        -- CRITICAL: Check if operand is a logical expression (AND/OR), comparison, or math
        -- If so, wrap it in parentheses to preserve correct evaluation order
        -- Example: not ((A and B) and C) needs parentheses, not (A and B) and C is wrong
        local operandType = ASTValue.GetValueType(valueData.val)
        local needsParentheses = false

        if operandType then
            -- Check if operand is a logical operator (AND/OR) - always needs parentheses
            if LOGICAL_OPERATORS[operandType] then
                needsParentheses = true
            -- Check if operand is a comparison - needs parentheses when used in complex expressions
            elseif operandType == ASTValue.ValueType.CMP then
                needsParentheses = true
            -- Check if operand is a math expression - needs parentheses
            elseif operandType == ASTValue.ValueType.MATH then
                needsParentheses = true
            end
        end

        -- If operand needs parentheses and isn't already wrapped, wrap it
        if needsParentheses and not operand:match("^%s*%(") then
            return string.format("not (%s)", operand)
        else
            -- Already parenthesized or doesn't need parentheses
            return string.format("not %s", operand)
        end
    end

    if valueType == ASTValue.ValueType.CMP then
        local opSymbol = ASTValue.ComparisonOpToSymbol(valueData.op) or COMPARISON_SYMBOL_DEFAULT
        -- CMP operands are not top-level, so pass context with isTopLevel=false
        local operandContext = context and { isTopLevel = false } or { isTopLevel = false }
        local lhs = EmitValueNode(valueData.lhs, operandContext)
        local rhs = EmitValueNode(valueData.rhs, operandContext)
        return string.format("(%s %s %s)", lhs, opSymbol, rhs)
    end

    if valueType == ASTValue.ValueType.MATH then
        local mathSymbol = ASTValue.MathOpToSymbol(valueData.op) or "+"
        -- MATH operands are not top-level, so pass context with isTopLevel=false
        local operandContext = context and { isTopLevel = false } or { isTopLevel = false }
        local lhs = EmitValueNode(valueData.lhs, operandContext)
        local rhs = EmitValueNode(valueData.rhs, operandContext)
        return string.format("(%s %s %s)", lhs, mathSymbol, rhs)
    end

    if LOGICAL_OPERATORS[valueType] then
        -- Always synthesize recursively from structured data - only use originalText as fallback if synthesis fails
        local operatorText = LOGICAL_OPERATORS[valueType]


        -- Synthesize all child values recursively
        local operands = {}
        local synthesisFailed = false
        local failedChildCount = 0

        -- When emitting children, they are operands (not top-level), so pass context with isTopLevel=false
        local childContext = { isTopLevel = false }
        local valsArray = valueData.vals or {}

        for i, child in ipairs(valsArray) do
            -- DIAGNOSTIC: Only log errors, not normal operation
            local childType = child and child.type or "nil"
            local childValueType = ASTValue.GetValueType(child)
            local childValueData = ASTValue.GetValueData(child)

            if not childType or childType ~= "value" then
                -- Child is missing type field - log full structure
                local childKeys = {}
                for k, v in pairs(child or {}) do
                    childKeys[#childKeys + 1] = string.format("%s (type=%s)", tostring(k), type(v))
                end
                NAG:Error("[ASTSchemaEmitter] Child %d/%d is missing type='value' field! Keys: %s",
                    i, #valsArray, table.concat(childKeys, ", "))

                -- Also check if it's a proto structure
                if type(child) == "table" then
                    local protoKeys = {}
                    for k, v in pairs(child) do
                        if type(k) == "string" and type(v) == "table" then
                            protoKeys[#protoKeys + 1] = string.format("%s = {...}", tostring(k))
                        end
                    end
                    if #protoKeys > 0 then
                        NAG:Error("[ASTSchemaEmitter] Child %d/%d appears to be proto structure: %s",
                            i, #valsArray, table.concat(protoKeys, ", "))
                    end
                end
            end

            if not childValueType then
                -- GetValueType failed - log why
                if childType == "value" then
                    -- Has type but GetValueType failed - check value structure
                    local valueKeys = {}
                    if child and child.value then
                        for k in pairs(child.value) do
                            valueKeys[#valueKeys + 1] = tostring(k)
                        end
                    end
                    NAG:Error("[ASTSchemaEmitter] Child %d/%d has type='value' but GetValueType() returned nil! value keys: %s",
                        i, #valsArray, table.concat(valueKeys, ", "))
                end
            else
                -- Recursively check nested AND/OR children (only log errors)
                if (childValueType == ASTValue.ValueType.AND or childValueType == ASTValue.ValueType.OR) and childValueData then
                    local nestedVals = childValueData.vals or {}
                    for j, nestedChild in ipairs(nestedVals) do
                        local nestedType = nestedChild and nestedChild.type or "nil"
                        if nestedType ~= "value" then
                            NAG:Error("[ASTSchemaEmitter] Nested child %d/%d in child %d/%d is missing type='value' field!",
                                j, #nestedVals, i, #valsArray)
                        end
                    end
                end
            end

            local emitted = EmitValueNode(child, childContext)
            if emitted ~= "" then
                operands[#operands + 1] = emitted
                NAG:Debug("[ASTSchemaEmitter] Child %d emitted successfully: '%s' (first 100 chars)",
                    i, emitted:sub(1, 100))
            else
                -- Child synthesis failed - track for fallback decision
                synthesisFailed = true
                failedChildCount = failedChildCount + 1
                NAG:Error("[ASTSchemaEmitter] Child %d synthesis failed - returned empty string", i)
            end
        end

        -- If synthesis succeeded (we have operands), combine them with operator and wrap in parentheses
        if #operands > 0 then
            -- DIAGNOSTIC: Log detailed information about OR/AND node emission (Debug only to avoid chat flood)
            if valueType == ASTValue.ValueType.OR then
                NAG:Debug("[DIAGNOSTIC] ASTSchemaEmitter: Emitting OR node with %d operands", #operands)
                for i, operand in ipairs(operands) do
                    NAG:Debug("[DIAGNOSTIC] ASTSchemaEmitter: OR operand %d: '%s' (first 100 chars)",
                        i, operand:sub(1, 100) .. (operand:len() > 100 and "..." or ""))
                end
            end

            local result
            if #operands == 1 then
                result = operands[1]
                if valueType == ASTValue.ValueType.OR then
                    NAG:Debug("[DIAGNOSTIC] ASTSchemaEmitter: OR node has single operand, returning directly: '%s'",
                        result:sub(1, 100))
                end
            else
                -- Combine operands with operator
                local combined = table.concat(operands, string.format(" %s ", operatorText))
                -- Only wrap in parentheses if this is NOT a top-level condition
                -- Top-level conditions don't need parentheses (matches original format)
                if isTopLevel then
                    result = combined
                else
                    -- Wrap in parentheses to preserve structure when used as operand
                    result = string.format("(%s)", combined)
                end
                if valueType == ASTValue.ValueType.OR then
                    NAG:Debug("[DIAGNOSTIC] ASTSchemaEmitter: OR node emitted as: '%s' (first 200 chars)",
                        result:sub(1, 200) .. (result:len() > 200 and "..." or ""))
                end
            end


            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Successfully constructed logical operator: %s (operandCount=%d)", operatorText, #operands)
            return result
        end

        -- Synthesis failed (no valid operands) - log error and return placeholder
        NAG:Warn("[ASTSchemaEmitter] EmitValueNode: Logical operator synthesis failed - no valid operands (operator='%s')", operatorText)

        return string.format("/* ERROR: %s operator synthesis failed - no valid operands */", operatorText)
    end

    if MATH_FUNCTIONS[valueType] then
        -- Emit as math.min(...) or math.max(...) with comma-separated arguments
        local functionName = MATH_FUNCTIONS[valueType]
        local args = {}

        -- Synthesize all child values recursively
        -- MATH function children are not top-level, so pass context with isTopLevel=false
        local childContext = context and { isTopLevel = false } or { isTopLevel = false }
        for _, child in ipairs(valueData.vals or {}) do
            local emitted = EmitValueNode(child, childContext)
            if emitted ~= "" then
                args[#args + 1] = emitted
            end
        end

        if #args > 0 then
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Successfully constructed math function: %s (argCount=%d)", functionName, #args)
            return string.format("%s(%s)", functionName, table.concat(args, ", "))
        else
            NAG:Warn("[ASTSchemaEmitter] EmitValueNode: Math function synthesis failed - no valid arguments (function='%s')", functionName)
            return string.format("/* ERROR: %s synthesis failed - no valid arguments */", functionName)
        end
    end

    -- Try to synthesize function call values (similar to actions)
    if valueType and valueType ~= "" then

        EnsureSchemaModules()

        local metadata
        -- Use SchemaAccessor with strict snake_case lookup
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        if valueType then
            local snakeName = valueType
            if not snakeName:match("^[a-z][a-z0-9_]*$") then
                local converted = ns.SchemaUtils:CamelToSnake(valueType)
                if not converted then
                    converted = valueType:lower()
                end
                snakeName = converted
            end
            if snakeName:match("^[a-z][a-z0-9_]*$") and SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
                metadata = SchemaAccessor:GetMetadataByIdentifier(snakeName, nil)
            end
        end

        local functionName
        if metadata then
            functionName = metadata.nagFunctionName or metadata.nagName or metadata.identifier
        end

        if not functionName and valueType then
            functionName = ns.SchemaUtils:SnakeToPascal(valueType)
            if not functionName then
                functionName = valueType
            else
            end
        end

        if functionName and functionName ~= "" then
            -- Build arguments from valueData using metadata
            local arguments = {}
            local argumentSource = "none"


            if metadata and metadata.messageSchema and metadata.messageSchema.field_order and metadata.messageSchema.fields then
                argumentSource = "metadata"
                local fieldOrder = CloneArgumentsArray(metadata.messageSchema.field_order)
                local fields = metadata.messageSchema.fields

                NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Using metadata path for valueType='%s', fieldCount=%d",
                    tostring(valueType), #fieldOrder)

                for _, fieldName in ipairs(fieldOrder) do
                    local fieldInfo = fields[fieldName]
                    local fieldValue = valueData[fieldName]

                    if fieldValue ~= nil then
                        -- Debug logging for stat_type fields to diagnose emission issues
                        if fieldName and (fieldName:find("stat_type") or fieldName:find("statType")) then
                            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Processing stat_type field '%s' - fieldInfo.type=%s, fieldValue type=%s, fieldValue=%s",
                                fieldName,
                                fieldInfo and fieldInfo.type or "nil",
                                type(fieldValue),
                                tostring(fieldValue))
                        end

                        if fieldInfo and fieldInfo.type == "enum" then
                            arguments[#arguments + 1] = EmitEnumValue(fieldInfo.enum_type, fieldValue)
                        elseif fieldInfo and fieldInfo.type == "message" then
                            if fieldInfo.message_type == "APLValue" then
                                NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Emitting APLValue field '%s' via EmitValueNode", fieldName)
                                -- APLValue fields are not top-level, so pass context with isTopLevel=false
                                local fieldContext = context and { isTopLevel = false } or { isTopLevel = false }
                                arguments[#arguments + 1] = EmitValueNode(fieldValue, fieldContext)
                            elseif fieldInfo.message_type == "UnitReference" then
                                arguments[#arguments + 1] = EmitUnitReference(fieldValue)
                            elseif fieldInfo.message_type == "ActionID" then
                                local emitted = EmitActionID(fieldValue)
                                if emitted then
                                    arguments[#arguments + 1] = emitted
                                end
                            else
                                -- Generic message type - emit as table literal
                                local emitted = EmitMessageType(fieldValue, fieldInfo.message_type)
                                if emitted then
                                    arguments[#arguments + 1] = emitted
                                else
                                    arguments[#arguments + 1] = EmitScalarLiteral(fieldValue)
                                end
                            end
                        elseif fieldInfo and (fieldInfo.type == "int32" or fieldInfo.type == "int64" or fieldInfo.type == "double" or fieldInfo.type == "float") then
                            -- For numeric fields, emit as number directly (don't convert to enum names)
                            -- Special case: stat_type fields should always emit as numbers, not enum names
                            -- CRITICAL: Ensure we emit the numeric value, not an enum name
                            local numericValue = fieldValue
                            if type(fieldValue) == "string" then
                                -- If somehow we got a string, try to convert it back to number
                                numericValue = tonumber(fieldValue) or fieldValue
                            end
                            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Emitting numeric field '%s' (type=%s) as number: %s (original type=%s)",
                                fieldName, fieldInfo.type, tostring(numericValue), type(fieldValue))
                            arguments[#arguments + 1] = tostring(numericValue)
                        elseif fieldInfo == nil then
                            -- No fieldInfo - emit as scalar literal (shouldn't happen but handle gracefully)
                            NAG:Warn("[ASTSchemaEmitter] EmitValueNode: fieldInfo is nil for field '%s', using EmitScalarLiteral", fieldName)
                            arguments[#arguments + 1] = EmitScalarLiteral(fieldValue)
                        else
                            -- Other field types - use EmitScalarLiteral
                            arguments[#arguments + 1] = EmitScalarLiteral(fieldValue)
                        end
                    end
                end
            else
                -- Fallback: try to extract common patterns from valueData
                NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using pattern matching fallback in EmitValueNode() for valueType='%s' (schema metadata unavailable)", tostring(valueType))
                argumentSource = "pattern_matching"

                NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Using pattern matching path for valueType='%s' (reason: %s)",
                    tostring(valueType),
                    not metadata and "no_metadata" or (not metadata.messageSchema and "no_messageSchema") or (not metadata.messageSchema.field_order and "no_fieldOrder") or (not metadata.messageSchema.fields and "no_fields") or "unknown")

                -- Use FieldFormatConverter for consistent ActionID extraction
                local FieldFormatConverter = ns.FieldFormatConverter
                if valueData.spell_id then
                    if FieldFormatConverter then
                        local extractedID = FieldFormatConverter:ExtractActionID(valueData.spell_id)
                        arguments[#arguments + 1] = EmitScalarLiteral(extractedID)
                    else
                        -- Fallback to manual extraction
                        NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using manual extraction fallback for spell_id in pattern matching (FieldFormatConverter unavailable)")
                        arguments[#arguments + 1] = EmitScalarLiteral(valueData.spell_id.spell_id or valueData.spell_id.id or valueData.spell_id)
                    end
                end
                if valueData.source_unit then
                    arguments[#arguments + 1] = EmitUnitReference(valueData.source_unit)
                end
                if valueData.aura_id then
                    if FieldFormatConverter then
                        local extractedID = FieldFormatConverter:ExtractActionID(valueData.aura_id)
                        arguments[#arguments + 1] = EmitScalarLiteral(extractedID)
                    else
                        -- Fallback to manual extraction
                        NAG:Warn("[ASTSchemaEmitter] FALLBACK TRACKING: Using manual extraction fallback for aura_id in pattern matching (FieldFormatConverter unavailable)")
                        arguments[#arguments + 1] = EmitScalarLiteral(valueData.aura_id.spell_id or valueData.aura_id.id or valueData.aura_id)
                    end
                end
                -- Add threshold to pattern matching fallback for IsExecutePhase
                if (tostring(valueType) == "is_execute_phase") and valueData.threshold ~= nil then
                    arguments[#arguments + 1] = EmitEnumValue("ExecutePhaseThreshold", valueData.threshold)
                end
            end

            local argsString = table.concat(arguments, ", ")
            local callText = string.format("NAG:%s(%s)", functionName, argsString)

            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Constructed value call: %s (argumentSource=%s, argCount=%d)",
                callText:sub(1, 150), argumentSource, #arguments)

            -- Debug: Check if argsString contains "or" that shouldn't be there
            if argsString:find(" or ") or argsString:find("^or ") or argsString:find(" or$") then
                NAG:Warn("[ASTSchemaEmitter] EmitValueNode: WARNING - argsString contains 'or' operator: '%s'", argsString:sub(1, 300))
            end

            return callText
        else
            -- functionName is nil or empty - log why we're skipping construction
            NAG:Debug("[ASTSchemaEmitter] EmitValueNode: Skipping construction for valueType='%s' (functionName empty, hasMetadata=%s)",
                tostring(valueType), tostring(metadata ~= nil))
            NAG:Warn("[ASTSchemaEmitter] EmitValueNode: Skipping construction for valueType='%s' (functionName empty)", tostring(valueType))
        end
    end

    -- Unknown value type or synthesis failed - log error and return placeholder
    if not valueType or valueType == "" then
        NAG:Warn("[ASTSchemaEmitter] EmitValueNode: Unknown value type - synthesis failed")
        return "/* ERROR: Unknown value type - synthesis failed */"
    end

    -- Synthesis attempted but failed - log error and return placeholder
    NAG:Warn("[ASTSchemaEmitter] EmitValueNode: Value synthesis failed for type: %s", tostring(valueType or "unknown"))

    return string.format("/* ERROR: Value synthesis failed for type: %s */", tostring(valueType or "unknown"))
end

-- ============================ ACTION EMISSION ============================

local function EmitActionArguments(actionType, actionData, metadata)
    if not actionData then
        return {}
    end

    local arguments = {}

    -- Use metadata-aware emission when available (handles schema modifications like position_override)
    if metadata and metadata.messageSchema and metadata.messageSchema.field_order and metadata.messageSchema.fields then
        local fieldCount = #(metadata.messageSchema.field_order or {})
        NAG:Debug("[ASTSchemaEmitter] EmitActionArguments: Using metadata path for actionType='%s', fieldCount=%d",
            tostring(actionType), fieldCount)

        local fieldOrder = CloneArgumentsArray(metadata.messageSchema.field_order)
        local fields = metadata.messageSchema.fields

        -- First pass: Find the last non-nil field index
        -- This ensures we emit nil placeholders for optional parameters that come before a set parameter
        local lastNonNilIndex = 0
        for i, fieldName in ipairs(fieldOrder) do
            local fieldValue = actionData[fieldName]
            local fieldInfo = fields[fieldName]
            -- Check if field has a value (for repeated fields, check if array has elements)
            local hasValue = false
            if fieldValue ~= nil then
                if fieldInfo and fieldInfo.label == "repeated" then
                    -- For repeated fields, check if array has elements
                    hasValue = type(fieldValue) == "table" and #fieldValue > 0
                else
                    hasValue = true
                end
            end
            if hasValue then
                lastNonNilIndex = i
            end
        end

        -- Second pass: Emit all fields up to and including lastNonNilIndex
        -- Emit nil for missing fields that come before a set field (positional parameter requirement)
        for i, fieldName in ipairs(fieldOrder) do
            if i <= lastNonNilIndex then
                local fieldInfo = fields[fieldName]
                local fieldValue = actionData[fieldName]

                if fieldValue ~= nil then
                    -- Handle repeated fields - emit each element separately
                    if fieldInfo and fieldInfo.label == "repeated" then
                        -- fieldValue is an array, emit each element
                        if type(fieldValue) == "table" then
                            for _, elementValue in ipairs(fieldValue) do
                                if fieldInfo.type == "message" and fieldInfo.message_type == "ActionID" then
                                    local emitted = EmitActionID(elementValue)
                                    if emitted then
                                        arguments[#arguments + 1] = emitted
                                    end
                                elseif fieldInfo.type == "enum" then
                                    arguments[#arguments + 1] = EmitEnumValue(fieldInfo.enum_type, elementValue)
                                elseif fieldInfo.type == "message" and fieldInfo.message_type == "UnitReference" then
                                    arguments[#arguments + 1] = EmitUnitReference(elementValue)
                                elseif fieldInfo.type == "message" and fieldInfo.message_type == "APLValue" then
                                    -- APLValue array elements are not top-level, so pass context with isTopLevel=false
                                    local elementContext = { isTopLevel = false }
                                    local emitted = EmitValueNode(elementValue, elementContext)
                                    if emitted then
                                        arguments[#arguments + 1] = emitted
                                    end
                                else
                                    arguments[#arguments + 1] = EmitScalarLiteral(elementValue)
                                end
                            end
                        end
                    else
                        -- Non-repeated field - existing logic
                    -- Special debug logging for interrupt_if field (function expressions)
                    if fieldName == "interrupt_if" or fieldName == "interruptIf" then
                        NAG:Debug("[ASTSchemaEmitter] EmitActionArguments: *** FOUND interrupt_if field *** type=%s, message_type=%s, fieldValue type=%s",
                            fieldInfo and fieldInfo.type or "nil",
                            fieldInfo and fieldInfo.message_type or "nil",
                            type(fieldValue))
                        if type(fieldValue) == "table" then
                            local valueType = ASTValue.GetValueType(fieldValue)
                            local valueData = ASTValue.GetValueData(fieldValue)
                            NAG:Debug("[ASTSchemaEmitter] EmitActionArguments: interrupt_if valueType=%s, has isFunctionExpression=%s, node keys: %s, val='%s'",
                                tostring(valueType),
                                tostring(fieldValue.isFunctionExpression or false),
                                table.concat((function()
                                    local keys = {}
                                    for k in pairs(fieldValue) do
                                        table.insert(keys, tostring(k))
                                    end
                                    return keys
                                end)(), ", "),
                                valueData and tostring(valueData.val):sub(1, 100) or "nil")
                        end
                    end

                    if fieldInfo and fieldInfo.type == "enum" then
                        arguments[#arguments + 1] = EmitEnumValue(fieldInfo.enum_type, fieldValue)
                    elseif fieldInfo and fieldInfo.type == "message" then
                        if fieldInfo.message_type == "APLValue" then
                            NAG:Debug("[ASTSchemaEmitter] EmitActionArguments: Emitting APLValue field '%s' via EmitValueNode", fieldName)
                            -- APLValue fields in actions are not top-level, so pass context with isTopLevel=false
                            local fieldContext = { isTopLevel = false }
                            local emitted = EmitValueNode(fieldValue, fieldContext)
                            NAG:Debug("[ASTSchemaEmitter] EmitActionArguments: APLValue field '%s' emitted as: '%s'", fieldName, emitted:sub(1, 150))
                            arguments[#arguments + 1] = emitted
                        elseif fieldInfo.message_type == "UnitReference" then
                            arguments[#arguments + 1] = EmitUnitReference(fieldValue)
                        elseif fieldInfo.message_type == "ActionID" then
                            local emitted = EmitActionID(fieldValue)
                            if emitted then
                                arguments[#arguments + 1] = emitted
                            end
                        else
                            -- Generic message type (e.g., OverlayTextOptions, FontColor, BackgroundConfig)
                            -- Emit as table literal
                            local emitted = EmitMessageType(fieldValue, fieldInfo.message_type)
                            if emitted then
                                NAG:Debug("[ASTSchemaEmitter] EmitActionArguments: Emitting message field '%s' (type=%s) as table literal",
                                    fieldName, fieldInfo.message_type or "unknown")
                                arguments[#arguments + 1] = emitted
                            else
                                NAG:Warn("[ASTSchemaEmitter] EmitActionArguments: Failed to emit message field '%s' (type=%s)",
                                    fieldName, fieldInfo.message_type or "unknown")
                                arguments[#arguments + 1] = EmitScalarLiteral(fieldValue)
                            end
                        end
                    elseif fieldInfo and fieldInfo.type == "string" then
                        -- String fields that might contain enum identifiers (like position_override)
                        -- EmitScalarLiteral will detect and emit identifiers unquoted
                        -- Exception: overlay text fields should always be quoted
                        local isOverlayTextField = (fieldName == "text" and actionType == "overlay_text")
                            or (fieldName == "overlay_text" and (
                                actionType == "cast_with_overlay"
                                or actionType == "cast_with_swing_overlay"
                                or actionType == "show_custom_overlay"
                            ))
                        arguments[#arguments + 1] = EmitScalarLiteral(fieldValue, nil, isOverlayTextField)
                    elseif fieldInfo and (fieldInfo.type == "int32" or fieldInfo.type == "int64" or fieldInfo.type == "double" or fieldInfo.type == "float") then
                        -- For numeric fields, emit as number directly (don't convert to enum names)
                        -- Special case: stat_type fields should always emit as numbers, not enum names
                        NAG:Debug("[ASTSchemaEmitter] EmitActionArguments: Emitting numeric field '%s' (type=%s) as number: %s",
                            fieldName, fieldInfo.type, tostring(fieldValue))
                        arguments[#arguments + 1] = tostring(fieldValue)
                    else
                        arguments[#arguments + 1] = EmitScalarLiteral(fieldValue)
                        end
                    end
                else
                    -- Emit nil for missing optional parameters that come before a set parameter
                    -- This is required for positional parameter functions (e.g., CastSpell(id, tolerance, position, hideWhileCasting))
                    -- where position must be in 3rd position even if tolerance is nil
                    -- Skip nil emission for repeated fields (empty arrays are handled by not being included in lastNonNilIndex)
                    -- Omit optional force_main when nil for StrictSequence/Sequence so we emit
                    -- NAG:StrictSequence("name", id1, id2) instead of NAG:StrictSequence("name", nil, id1, id2)
                    local omitNil = (actionType == "strict_sequence" or actionType == "sequence") and fieldName == "force_main"
                    if not (fieldInfo and fieldInfo.label == "repeated") and not omitNil then
                        arguments[#arguments + 1] = "nil"
                    end
                end
            end
            -- Skip fields after lastNonNilIndex (trailing nil values don't need to be emitted)
        end
    else
        -- Metadata should always be available - log warning if missing
        if not metadata then
            NAG:Warn("[ASTSchemaEmitter] EmitActionArguments: Metadata unavailable for actionType='%s' - no arguments will be emitted", tostring(actionType))
        elseif not metadata.messageSchema then
            NAG:Warn("[ASTSchemaEmitter] EmitActionArguments: Metadata missing messageSchema for actionType='%s' - no arguments will be emitted", tostring(actionType))
        elseif not metadata.messageSchema.field_order or not metadata.messageSchema.fields then
            NAG:Warn("[ASTSchemaEmitter] EmitActionArguments: Metadata missing field_order or fields for actionType='%s' - no arguments will be emitted", tostring(actionType))
        end
    end

    return arguments
end

local function EmitActionNode(actionNode)
    if not actionNode then
        return ""
    end

    -- Prioritize synthesis from structured data - only use originalText as fallback
    local actionType = ASTAction.GetActionType(actionNode)
    local actionData = ASTAction.GetActionData(actionNode)

    -- Compound expression: re-emit the stored expression verbatim (round-trip for clauses with nested conditions+actions)
    if actionType == "compound_expression" and actionData and actionData.expression then
        return (actionData.expression:match("^%s*(.-)%s*$") or actionData.expression)
    end

    EnsureSchemaModules()

    local metadata
    if actionType then
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        local snakeName = actionType
        if not snakeName:match("^[a-z][a-z0-9_]*$") then
            local converted = ns.SchemaUtils:CamelToSnake(actionType)
            if not converted then
                converted = actionType:lower()
            end
            snakeName = converted
        end
        if snakeName:match("^[a-z][a-z0-9_]*$") and SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
            metadata = SchemaAccessor:GetMetadataByIdentifier(snakeName, nil)
        end
    end

    local functionName
    if metadata then
        functionName = metadata.nagFunctionName or metadata.nagName
    end

    if not functionName and actionType then
        functionName = ns.SchemaUtils:SnakeToPascal(actionType)
        if not functionName then
            functionName = actionType
        else
        end
    end

    if not functionName and actionType and SchemaValidator and SchemaValidator.GenerateNAGNameFromProto then
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        local pascalType = ns.SchemaUtils:SnakeToPascal(actionType)
        if not pascalType then
            pascalType = actionType
        end
        functionName = SchemaValidator:GenerateNAGNameFromProto("APLAction" .. pascalType)
    end

    if not functionName then
        functionName = "UnknownAction"
    end

    local args = EmitActionArguments(actionType, actionData, metadata)
    local argsString = table.concat(args, ", ")
    local callText = string.format("NAG:%s(%s)", functionName, argsString)

    NAG:Debug("[ASTSchemaEmitter] EmitActionNode: Successfully emitted action: %s (actionType='%s', argCount=%d)",
        callText:sub(1, 150), tostring(actionType), #args)

    -- Debug: Log each argument separately to see if any contain "or"
    for i, arg in ipairs(args) do
        if arg:find(" or ") or arg:find("^or ") or arg:find(" or$") then
            NAG:Warn("[ASTSchemaEmitter] EmitActionNode: WARNING - Argument [%d] contains 'or' operator: '%s'", i, arg:sub(1, 200))
        end
        NAG:Debug("[ASTSchemaEmitter] EmitActionNode: Argument [%d]: '%s'", i, arg:sub(1, 200))
    end

    -- Debug: Check if final callText contains "or" that shouldn't be there
    if callText:find(" or ") or callText:find("^or ") or callText:find(" or$") then
        NAG:Warn("[ASTSchemaEmitter] EmitActionNode: WARNING - callText contains 'or' operator: '%s'", callText:sub(1, 300))
    end

    -- Validate synthesized output - log error if synthesis produced invalid result
    if functionName == "UnknownAction" and not actionType then
        NAG:Warn("[ASTSchemaEmitter] EmitActionNode: Unknown action type - synthesis failed")
        return "/* ERROR: Unknown action type - synthesis failed */"
    end

    return callText
end

-- ============================ ROTATION EMISSION ============================

local function EmitClause(listItem, index)
    local segments = {}

    if listItem.notes and listItem.notes ~= "" then
        local noteText = listItem.notes
        if not noteText:match("^%-%-") then
            noteText = "-- " .. noteText
        end
        segments[#segments + 1] = noteText
    end

    local lineParts = {}

    -- Add "or " prefix based on index position
    -- Never add "or " for the first clause (index 1), always add it for subsequent clauses (index > 1)
    -- This ensures correct syntax when clauses are deleted/reordered
    if index > 1 then
        lineParts[#lineParts + 1] = "or "
    end
    --TODO: this should probably be false?
    if listItem.hide then
        lineParts[#lineParts + 1] = "NAG:Hidden() and "
    end

    local actionNode = listItem.action
    local conditionNode = actionNode and actionNode.condition
    if conditionNode then
        -- Top-level conditions don't need parentheses, so pass isTopLevel=true
        local conditionContext = { isTopLevel = true }
        local conditionText = EmitValueNode(conditionNode, conditionContext)
        if conditionText ~= "" then
            lineParts[#lineParts + 1] = conditionText
            lineParts[#lineParts + 1] = " and "
        end
    end

    local actionText = EmitActionNode(actionNode)
    lineParts[#lineParts + 1] = actionText

    segments[#segments + 1] = table.concat(lineParts)

    return table.concat(segments, "\n")
end

local function EmitRotationNode(rotationNode)
    if not rotationNode or rotationNode.type ~= ASTCore.NodeType.ROTATION then
        return nil, "Emitter requires a proto rotation node"
    end

    local lines = {}
    local initialCount = #(rotationNode.priority_list or {})
    local actuallyEmittedCount = 0

    for index, listItem in ipairs(rotationNode.priority_list or {}) do
        local emitted = EmitClause(listItem, index)
        if emitted and emitted ~= "" then
            lines[#lines + 1] = emitted
            actuallyEmittedCount = actuallyEmittedCount + 1
        else
            -- Empty emission - this shouldn't happen for valid clauses
            NAG:Warn("[ASTSchemaEmitter] EmitRotationNode: Clause %d emitted empty string (action may be invalid)", index)
        end
    end

    -- Validate that we emitted the expected number of clauses
    if actuallyEmittedCount ~= initialCount then
        NAG:Error("[ASTSchemaEmitter] EmitRotationNode: Clause count mismatch - expected %d clauses, actually emitted %d (some clauses may have failed to emit)",
            initialCount, actuallyEmittedCount)
    end

    -- Store the count in the return string metadata (will be checked by caller)
    return table.concat(lines, "\n")
end

-- ============================ PUBLIC API ============================

--- Emit a rotation string from a proto AST node
--- @param protoAst table Proto AST rotation node
--- @param options table|nil Optional emission options
--- @param diagnostics table|nil Optional diagnostics sink
--- @return string|nil rotationString
--- @return string|nil errorReason
function ASTSchemaEmitter.EmitRotationString(protoAst, options, diagnostics)
    local initialClauseCount = protoAst and protoAst.priority_list and #protoAst.priority_list or 0
    NAG:Debug("[ASTSchemaEmitter] EmitRotationString: Emitting rotation string (%d clauses)", initialClauseCount)

    if not protoAst then
        NAG:Error("[ASTSchemaEmitter] EmitRotationString: Emitter received nil AST")
        return nil, "Emitter received nil AST"
    end

    if protoAst.type ~= ASTCore.NodeType.ROTATION then
        NAG:Error("[ASTSchemaEmitter] EmitRotationString: Emitter requires a rotation AST node (got type='%s')",
            tostring(protoAst.type))
        return nil, "Emitter requires a rotation AST node"
    end

    -- Store initial count before emission (in case priority_list is mutated)
    local initialCount = #(protoAst.priority_list or {})
    local rotationString, err = EmitRotationNode(protoAst)
    if not rotationString then
        if diagnostics then
            diagnostics.errors = diagnostics.errors or {}
            diagnostics.errors[#diagnostics.errors + 1] = err or "Failed to emit rotation string"
        end
        NAG:Error("[ASTSchemaEmitter] EmitRotationString: Failed to emit rotation string: %s", tostring(err))
        return nil, err
    end

    -- Validate that priority_list wasn't mutated during emission
    local finalCount = #(protoAst.priority_list or {})
    if finalCount ~= initialCount then
        NAG:Error("[ASTSchemaEmitter] EmitRotationString: priority_list was mutated during emission (initial=%d, final=%d) - this should not happen",
            initialCount, finalCount)
    end

    -- Note: EmitRotationNode already validates and logs errors if clause count mismatch occurs internally
    -- The validation happens inside EmitRotationNode where we can accurately track which clauses were emitted

    if diagnostics then
        diagnostics.metadata = diagnostics.metadata or {}
        diagnostics.metadata.emittedClauses = initialCount  -- Should match if EmitRotationNode validation passed
        diagnostics.metadata.expectedClauses = initialCount
    end

    NAG:Debug("[ASTSchemaEmitter] EmitRotationString: Successfully emitted rotation string (%d clauses)", initialCount)
    return rotationString, nil
end

--- Emit a value node to string (for editor use)
--- @param valueNode table Proto AST value node
--- @param context table|nil Optional context
--- @return string|nil
function ASTSchemaEmitter.EmitValueNode(valueNode, context)
    return EmitValueNode(valueNode, context)
end

--- Emit an action node to string (for editor use)
--- @param actionNode table Proto AST action node
--- @return string|nil
function ASTSchemaEmitter.EmitActionNode(actionNode)
    return EmitActionNode(actionNode)
end

--- Emit a clause (list item) to string (for editor use)
--- @param listItem table Proto AST list item (APLListItem)
--- @param index number|nil Optional index (adds "or " prefix if index > 1)
--- @param includeOrPrefix boolean|nil If false, never add "or " prefix (default: true if index > 1)
--- @return string|nil
function ASTSchemaEmitter.EmitClause(listItem, index, includeOrPrefix)
    if not listItem then
        return nil
    end

    local segments = {}

    -- Notes as comment
    if listItem.notes and listItem.notes ~= "" then
        local noteText = listItem.notes
        if not noteText:match("^%-%-") then
            noteText = "-- " .. noteText
        end
        segments[#segments + 1] = noteText
    end

    local lineParts = {}

    -- Add "or " prefix based on index position (unless disabled)
    -- For rotation clauses: add "or " for index > 1
    -- For group actions: don't add "or " (they're sequential, not priority-based)
    if includeOrPrefix ~= false and index and index > 1 then
        lineParts[#lineParts + 1] = "or "
    end

    -- NAG:Hidden() prefix
    if listItem.hide then
        lineParts[#lineParts + 1] = "NAG:Hidden() and "
    end

    -- Condition (from action.condition)
    -- Top-level conditions don't need parentheses, so pass isTopLevel=true
    local actionNode = listItem.action
    local conditionNode = actionNode and actionNode.condition
    if conditionNode then
        local conditionContext = { isTopLevel = true }
        local conditionText = EmitValueNode(conditionNode, conditionContext)
        if conditionText ~= "" then
            lineParts[#lineParts + 1] = conditionText
            lineParts[#lineParts + 1] = " and "
        end
    end

    -- Action
    local actionText = EmitActionNode(actionNode)
    lineParts[#lineParts + 1] = actionText

    segments[#segments + 1] = table.concat(lineParts)

    return table.concat(segments, "\n")
end

return ASTSchemaEmitter

