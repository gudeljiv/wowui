--- @module "FieldFormatConverter"
--- Unified field format conversion layer (Schema-Aware Bidirectional Converter)
--- Handles conversions between proto format (schema-compliant message structures), handler format (primitives), and WoWSims format (camelCase)
--- All conversions are schema-driven using fieldInfo metadata from schema
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local SchemaAccessor = NAG:GetModule("SchemaAccessor")
local SchemaUtils = NAG:GetModule("SchemaUtils")
local TableUtils = ns.TableUtils

local FieldFormatConverter = {}
ns.FieldFormatConverter = FieldFormatConverter

-- ============================ HELPER FUNCTIONS ============================

--- Extract actual value from a value node or wrapped structure
--- @param valueNode any The value node (table) or raw value
--- @return any The extracted value
local function ExtractValue(valueNode)
    if type(valueNode) == "table" then
        if valueNode._protoAST then
            return valueNode._protoAST
        elseif valueNode.value ~= nil then
            return valueNode.value
        elseif valueNode.type and valueNode.type == "constant" then
            return valueNode.value
        end
    end
    return valueNode
end

local function NormalizeString(value)
    if type(value) ~= "string" then
        return value
    end
    return value:gsub("^%s*", ""):gsub("%s*$", ""):lower()
end

local function ToNumber(value)
    if value == nil then
        return nil
    end
    if type(value) == "number" then
        return value
    end
    if type(value) == "string" then
        local trimmed = value:match("^%s*(.-)%s*$")
        local numeric = tonumber(trimmed)
        if numeric ~= nil then
            return numeric
        end
    end
    return nil
end

--- Resolve NAG:ResolveEffectiveSpellId(n) string to numeric spell ID for proto conversion
--- @param value string String like "NAG:ResolveEffectiveSpellId(7302)"
--- @return number|nil Resolved spell ID or nil if not applicable
local function ResolveSpellIdString(value)
    if type(value) ~= "string" or value == "" then
        return nil
    end
    local spellIdArg = value:match("^NAG:ResolveEffectiveSpellId%((%d+)%)$")
    if not spellIdArg then
        return nil
    end
    local id = tonumber(spellIdArg)
    if not id then
        return nil
    end
    if NAG and NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(id)
        return type(resolved) == "number" and resolved or id
    end
    return id
end

local function NormalizeEnumKey(key)
    if type(key) ~= "string" then
        return key
    end
    return key:gsub("^.*%.", ""):gsub("_", ""):lower()
end

--- Check if a string is an identifier reference (e.g., NAG.SPELL_POSITIONS.LEFT, NAG.Types.RuneType.RuneBlood)
--- @param value string String value to check
--- @return boolean isIdentifier True if value is an identifier reference
--- @return string|nil identifierType Type of identifier if detected
local function IsIdentifierReference(value)
    if type(value) ~= "string" then
        return false, nil
    end

    -- Pattern: NAG.SPELL_POSITIONS.*
    if value:match("^NAG%.SPELL_POSITIONS%.") or value:match("^ns%.SPELL_POSITIONS%.") then
        return true, "SpellPosition"
    end

    -- Pattern: NAG.Types.*
    if value:match("^NAG%.Types%.") or value:match("^ns%.Types%.") then
        return true, "TypeReference"
    end

    return false, nil
end

-- ============================ SCHEMA-AWARE BIDIRECTIONAL CONVERSION ============================

--- Convert handler/primitive value to proto format (Schema-Aware)
--- This is the primary normalization method - fully schema-driven
--- @param value any Primitive value from handler/user input
--- @param fieldInfo table Schema field information (from SchemaAccessor:GetFieldInfo)
--- @return any Normalized proto format value
function FieldFormatConverter:ToProto(value, fieldInfo)
    if not fieldInfo then
        -- No schema info - return as-is
        return value
    end

    local fieldType = fieldInfo.type
    local messageType = fieldInfo.message_type
    local enumType = fieldInfo.enum_type

    -- Handle message types - lookup message schema recursively
    if fieldType == "message" and messageType then
        -- Get message schema to convert nested messages
        if SchemaAccessor then
            local messageSchema = SchemaAccessor:GetMessageSchema(messageType)
            if messageSchema then
                -- Recursively convert message fields using schema
                return self:ToProtoMessage(value, messageType, messageSchema)
            end
        end

        -- Fallback to hardcoded message types for backward compatibility
        if messageType == "ActionID" then
            -- FALLBACK TRACKING: Using deprecated NormalizeActionID() - schema lookup failed
            NAG:Error("[FieldFormatConverter] FALLBACK PATTERN DETECTED: Using NormalizeActionID() fallback in ToProto() - schema lookup failed for messageType='%s'. SchemaAccessor=%s", tostring(messageType), tostring(SchemaAccessor ~= nil))
            return self:NormalizeActionID(value)
        elseif messageType == "UnitReference" then
            -- FALLBACK TRACKING: Using deprecated NormalizeUnitReference() - schema lookup failed
            NAG:Error("[FieldFormatConverter] FALLBACK PATTERN DETECTED: Using NormalizeUnitReference() fallback in ToProto() - schema lookup failed for messageType='%s'. SchemaAccessor=%s", tostring(messageType), tostring(SchemaAccessor ~= nil))
            return self:NormalizeUnitReference(value)
        elseif messageType == "APLValue" or (messageType and messageType:find("^APLValue")) then
            -- FALLBACK TRACKING: Using deprecated NormalizeAPLValue() - schema lookup failed
            NAG:Error("[FieldFormatConverter] FALLBACK PATTERN DETECTED: Using NormalizeAPLValue() fallback in ToProto() - schema lookup failed for messageType='%s'. SchemaAccessor=%s", tostring(messageType), tostring(SchemaAccessor ~= nil))
            return self:NormalizeAPLValue(value)
        else
            -- Generic message type - return as-is if already table
            if type(value) == "table" then
                return value
            end
        end
    end

    -- Handle enum types
    if fieldType == "enum" and enumType then
        if NAG.debug then NAG:Debug("[FieldFormatConverter] Normalizing enum value using schema-aware NormalizeEnumValue() for enumType='%s'", tostring(enumType)) end
        return self:NormalizeEnumValue(value, enumType)
    end

    -- Handle repeated fields
    if fieldInfo.label == "repeated" and type(value) == "table" then
        local result = {}
        for i, item in ipairs(value) do
            result[i] = self:ToProto(item, fieldInfo)  -- Remove label for item conversion
        end
        return result
    end

    -- Handle primitive types with type conversion
    if fieldType == "int32" or fieldType == "int64" or fieldType == "sint32" or fieldType == "sint64" or fieldType == "fixed32" or fieldType == "fixed64" or fieldType == "sfixed32" or fieldType == "sfixed64" then
        -- Convert string to number for integer types
        if type(value) == "string" and value ~= "" then
            local asNumber = tonumber(value)
            if asNumber then
                -- Convert to integer (floor for positive, ceil for negative)
                return math.floor(asNumber)
            end
            -- Handle NAG:ResolveEffectiveSpellId(n) - resolve at convert time for spell_id fields
            local resolved = ResolveSpellIdString(value)
            if resolved then
                return math.floor(resolved)
            end
            NAG:Warn("[FieldFormatConverter] ToProto: Failed to convert string '%s' to integer for fieldType '%s'", value, fieldType)
        end
        return value
    elseif fieldType == "double" or fieldType == "float" then
        -- Convert string to number for floating point types
        if type(value) == "string" and value ~= "" then
            local asNumber = tonumber(value)
            if asNumber then
                return asNumber
            end
            NAG:Warn("[FieldFormatConverter] ToProto: Failed to convert string '%s' to number for fieldType '%s'", value, fieldType)
        end
        return value
    elseif fieldType == "bool" or fieldType == "boolean" then
        -- Convert string to boolean
        if type(value) == "string" then
            local lower = value:lower()
            if lower == "true" or lower == "1" or lower == "yes" then
                return true
            elseif lower == "false" or lower == "0" or lower == "no" or lower == "" then
                return false
            end
        end
        return value
    end

    -- For other primitive types (string, bytes, etc.), return as-is
    return value
end

--- Convert proto format value to handler/primitive format (Schema-Aware)
--- This is the primary extraction method - fully schema-driven
--- @param protoValue any Field value in proto format
--- @param fieldInfo table Schema field information (from SchemaAccessor:GetFieldInfo)
--- @return any Extracted primitive value for handler use
function FieldFormatConverter:FromProto(protoValue, fieldInfo)
    if not fieldInfo then
        return protoValue
    end

    local fieldType = fieldInfo.type
    local messageType = fieldInfo.message_type
    local enumType = fieldInfo.enum_type

    -- Handle message types - lookup message schema recursively
    if fieldType == "message" and messageType then
        -- Get message schema to extract nested messages
        if SchemaAccessor then
            local messageSchema = SchemaAccessor:GetMessageSchema(messageType)
            if messageSchema then
                -- Recursively extract message fields using schema
                return self:FromProtoMessage(protoValue, messageType, messageSchema)
            end
        end

        -- Fallback to hardcoded message types for backward compatibility
        if messageType == "ActionID" then
            return self:ExtractActionID(protoValue)
        elseif messageType == "UnitReference" then
            return self:ExtractUnitReference(protoValue)
        elseif messageType == "APLValue" or messageType:find("^APLValue") then
            local extracted = ExtractValue(protoValue)
            if type(extracted) == "string" and extracted:match("^function%s*%(") then
                local func, err = loadstring("return " .. extracted)
                if func then
                    local success, result = pcall(func)
                    if success and type(result) == "function" then
                        return result
                    end
                end
                return extracted
            end
            return extracted
        else
            -- Generic message type - return as-is
            return protoValue
        end
    end

    -- Handle enum types
    if fieldType == "enum" and enumType then
        return self:ExtractEnumValue(protoValue)
    end

    -- Handle repeated fields
    if fieldInfo.label == "repeated" and type(protoValue) == "table" then
        local result = {}
        for i, item in ipairs(protoValue) do
            result[i] = self:FromProto(item, fieldInfo)  -- Remove label for item conversion
        end
        return result
    end

    -- For primitive types, extract from table wrapper if needed
    if type(protoValue) == "table" then
        if protoValue.val ~= nil then
            return protoValue.val
        end
    end

    return ExtractValue(protoValue)
end

--- Convert message value to proto format (recursive schema-aware conversion)
--- Handles both primitive values (numbers/strings) and table values using schema field_order
--- @param value any Input value (primitive or table)
--- @param messageType string Message type name
--- @param messageSchema table Message schema with fields and field_order
--- @return table|nil Converted message structure
function FieldFormatConverter:ToProtoMessage(value, messageType, messageSchema)
    if not messageSchema or not messageSchema.fields then
        return value
    end

    -- Handle primitive values (number/string) that need conversion to message structure
    if type(value) ~= "table" then
        -- Use field_order to determine which field this primitive should map to
        local fieldOrder = messageSchema.field_order or {}

        if #fieldOrder > 0 then
            -- Try first field in field_order
            local firstFieldName = fieldOrder[1]
            local firstFieldDef = messageSchema.fields[firstFieldName]

            if firstFieldDef then
                -- Convert primitive using first field's type definition
                local result = {}
                result[firstFieldName] = self:ToProto(value, firstFieldDef)
                return result
            end
        end

        -- If no field_order or field conversion failed, return value as-is
        return value
    end

    -- Handle table values - recursively convert all fields using schema
    local result = {}
    for fieldName, fieldDef in pairs(messageSchema.fields) do
        if value[fieldName] ~= nil then
            result[fieldName] = self:ToProto(value[fieldName], fieldDef)
        end
    end

    return result
end

--- Extract primitive value from message (recursive schema-aware extraction)
--- @param protoValue any Proto message value
--- @param messageType string Message type name
--- @param messageSchema table Message schema
--- @return any Extracted value
function FieldFormatConverter:FromProtoMessage(protoValue, messageType, messageSchema)
    -- Handle ActionID message type (common case - extract spell_id/item_id/other_id)
    if messageType == "ActionID" then
        return self:ExtractActionID(protoValue)
    end

    -- Handle UnitReference message type (extract type enum)
    if messageType == "UnitReference" then
        return self:ExtractUnitReference(protoValue)
    end

    -- For other message types, extract first meaningful field
    if type(protoValue) == "table" and messageSchema and messageSchema.field_order then
        -- Try fields in order
        for _, fieldName in ipairs(messageSchema.field_order) do
            local fieldValue = protoValue[fieldName]
            if fieldValue ~= nil then
                local fieldInfo = messageSchema.fields[fieldName]
                if fieldInfo then
                    return self:FromProto(fieldValue, fieldInfo)
                end
            end
        end
    end

    return protoValue
end

-- ============================ PROTO → HANDLER FORMAT (Extraction) ============================

--- Extract primitive value from proto ActionID message structure
--- Schema-aware: ActionID is FLAT in schema { spell_id: int32, item_id: int32, other_id: enum, tag: int32 }
--- Supports all ActionID field variations: spell_id, item_id, other_id
--- @param actionIDMessage table|any ActionID message structure or primitive
--- @return number|nil Extracted spell/item ID
function FieldFormatConverter:ExtractActionID(actionIDMessage)
    if not actionIDMessage then
        return nil
    end

    -- Already a primitive number
    if type(actionIDMessage) == "number" then
        return actionIDMessage
    end

    if type(actionIDMessage) == "table" then
        -- Schema-compliant flat format: { spell_id: 12345 }
        -- According to schema, ActionID has flat fields: spell_id, item_id, other_id, tag
        if actionIDMessage.spell_id then
            -- Handle flat format (schema-compliant)
            if type(actionIDMessage.spell_id) == "number" then
                return actionIDMessage.spell_id
            end
            -- Handle string spell_id (should be converted to number)
            if type(actionIDMessage.spell_id) == "string" then
                local asNumber = tonumber(actionIDMessage.spell_id)
                if asNumber then
                    NAG:Warn("[FieldFormatConverter] ExtractActionID: Converting string spell_id to number: '%s' -> %d", actionIDMessage.spell_id, asNumber)
                    return asNumber
                end
                -- Handle NAG:ResolveEffectiveSpellId(n)
                local resolved = ResolveSpellIdString(actionIDMessage.spell_id)
                if resolved then
                    return resolved
                end
            end
            -- Handle legacy nested format (compatibility only)
            if type(actionIDMessage.spell_id) == "table" then
                local result = actionIDMessage.spell_id.spell_id or actionIDMessage.spell_id.id
                if result then
                    NAG:Warn("[FieldFormatConverter] ExtractActionID: Detected legacy nested ActionID format - schema defines flat format")
                    return result
                end
            end
        end

        -- Handle item_id (flat in schema)
        if actionIDMessage.item_id then
            if type(actionIDMessage.item_id) == "number" then
                return actionIDMessage.item_id
            end
        end

        -- Handle other_id (enum value, flat in schema)
        if actionIDMessage.other_id then
            return actionIDMessage.other_id
        end

        -- Common parser output for StrictSequence/Sequence action IDs (repeated ActionID args as numbers)
        -- Parser often stores these as { id = number } or { value = number }; treat as spell_id for emission
        if actionIDMessage.id ~= nil and type(actionIDMessage.id) == "number" then
            return actionIDMessage.id
        end
        if actionIDMessage.value ~= nil and type(actionIDMessage.value) == "number" then
            return actionIDMessage.value
        end

        -- Handle camelCase variations (WoWSims format compatibility)
        if actionIDMessage.spellId then
            if type(actionIDMessage.spellId) == "number" then
                return actionIDMessage.spellId
            end
            -- WoWSims JSON may nest ActionID: { spellId: { spellId: 12345 } }
            if type(actionIDMessage.spellId) == "table" then
                return actionIDMessage.spellId.spellId or actionIDMessage.spellId.id
            end
        end

        if actionIDMessage.itemId then
            if type(actionIDMessage.itemId) == "number" then
                return actionIDMessage.itemId
            end
        end

        -- Handle legacy field names for compatibility
        if actionIDMessage.aura_id then
            -- aura_id is not in ActionID schema - this might be legacy
            if type(actionIDMessage.aura_id) == "number" then
                return actionIDMessage.aura_id
            end
            if type(actionIDMessage.aura_id) == "table" then
                return self:ExtractActionID(actionIDMessage.aura_id)
            end
        end

        if actionIDMessage.primary_spell_id then
            -- primary_spell_id is not in ActionID schema - might be legacy
            if type(actionIDMessage.primary_spell_id) == "number" then
                return actionIDMessage.primary_spell_id
            end
            if type(actionIDMessage.primary_spell_id) == "table" then
                return self:ExtractActionID(actionIDMessage.primary_spell_id)
            end
        end

        if actionIDMessage.secondary_spell_id then
            -- secondary_spell_id is not in ActionID schema - might be legacy
            if type(actionIDMessage.secondary_spell_id) == "number" then
                return actionIDMessage.secondary_spell_id
            end
            if type(actionIDMessage.secondary_spell_id) == "table" then
                return self:ExtractActionID(actionIDMessage.secondary_spell_id)
            end
        end
    end

    -- Try to extract from wrapped value structure
    local numeric = ToNumber(ExtractValue(actionIDMessage))
    return numeric
end

--- Extract unit enum value or string from proto UnitReference message structure
--- @param unitRefMessage table|any UnitReference message structure or primitive
--- @return number|string|nil Extracted unit enum value or string
function FieldFormatConverter:ExtractUnitReference(unitRefMessage)
    if not unitRefMessage then
        return nil
    end

    if type(unitRefMessage) == "table" then
        -- Extract type enum value
        if unitRefMessage.type then
            NAG:Info("[FieldFormatConverter] ExtractUnitReference: Extracted type enum: %s", tostring(unitRefMessage.type))
            return unitRefMessage.type
        end
        -- Extract unit string if present
        if unitRefMessage.unit then
            NAG:Info("[FieldFormatConverter] ExtractUnitReference: Extracted unit string: %s", tostring(unitRefMessage.unit))
            return unitRefMessage.unit
        end
    end

    -- Already a primitive
    local result = ExtractValue(unitRefMessage)
    if result then
        NAG:Info("[FieldFormatConverter] ExtractUnitReference: Extracted primitive value: %s", tostring(result))
    end
    return result
end

--- Extract ActionID from a field by name (generic helper)
--- Handles field name variations (snake_case, camelCase) and extracts ActionID value
--- @param fieldValue table|any Field value that may contain ActionID structure
--- @param fieldName string|nil Optional field name (for logging/debugging)
--- @return number|nil Extracted ActionID value
function FieldFormatConverter:ExtractActionIDField(fieldValue, fieldName)
    if not fieldValue then
        return nil
    end

    -- If fieldValue is already a primitive number, return it
    if type(fieldValue) == "number" then
        return fieldValue
    end

    -- Use ExtractActionID to handle all ActionID structures
    return self:ExtractActionID(fieldValue)
end

--- Extract UnitReference for UI display (converts enum to string)
--- Extracts UnitReference and converts enum number to string enum name for UI display
--- @param unitRefMessage table|any UnitReference message structure or primitive
--- @return string|number|nil Extracted unit enum name (string) or value (number)
function FieldFormatConverter:ExtractUnitReferenceForDisplay(unitRefMessage)
    if not unitRefMessage then
        return nil
    end

    -- Extract unit reference using existing method
    local extractedUnit = self:ExtractUnitReference(unitRefMessage)

    if extractedUnit == nil then
        return nil
    end

    -- If result is a number (enum value), convert to string enum name for UI display
    if type(extractedUnit) == "number" then
        if SchemaAccessor then
            local unitRefSchema = SchemaAccessor:GetMessageSchema("UnitReference")
            if unitRefSchema then
                local enumValues, enumType = SchemaAccessor:GetFieldEnumValues(unitRefSchema, "type")
                if enumType and enumType.GetNameByValue then
                    local enumKey = enumType:GetNameByValue(extractedUnit)
                    if enumKey then
                        return enumKey
                    end
                end
            end
        end
        -- If conversion failed, return number as-is
        return extractedUnit
    end

    -- If result is already a string, return as-is
    return extractedUnit
end

--- Extract enum numeric value from enum message structure
--- @param enumValue any Enum value (number, string, or table)
--- @return number|nil Extracted enum numeric value
function FieldFormatConverter:ExtractEnumValue(enumValue)
    if enumValue == nil then
        return nil
    end

    if type(enumValue) == "number" then
        return enumValue
    end

    if type(enumValue) == "table" then
        -- Extract from nested structure if present
        if enumValue.value ~= nil then
            return ToNumber(enumValue.value)
        end
    end

    -- Try to convert string to number
    return ToNumber(ExtractValue(enumValue))
end

--- Convert enum numeric value to string representation for emission
--- Handles special cases like Stat enum (emits numbers), ExecutePhaseThreshold (emits numbers), identifier strings
--- @param enumValue any Enum value (number or string identifier)
--- @param enumType string Enum type name
--- @return string String representation for emission
function FieldFormatConverter:EnumValueToString(enumValue, enumType)
    if enumValue == nil or not enumType then
        return tostring(enumValue or "")
    end

    -- Preserve identifier strings as-is (e.g., NAG.SPELL_POSITIONS.LEFT, NAG.Types.RuneType.RuneBlood)
    if type(enumValue) == "string" and (enumValue:match("^NAG%.") or enumValue:match("^ns%.")) then
        return enumValue
    end

    -- Special handling for Stat enum: emit numeric value, not enum name
    if enumType == "Stat" or enumType:find("^Stat") then
        if type(enumValue) == "number" then
            return tostring(enumValue)
        elseif type(enumValue) == "string" then
            -- Try to convert enum name back to number for emission
            if SchemaAccessor then
                local enumValues = SchemaAccessor:GetEnumValues(enumType)
                if enumValues then
                    for name, value in pairs(enumValues) do
                        if name == enumValue or name:upper() == enumValue:upper() then
                            return tostring(value)
                        end
                    end
                end
            end
        end
        return tostring(enumValue)
    end

    -- Special handling for TotemType: emit numeric slot (1-4) for round-trip (NAG:TotemRemainingTime(3) not Water)
    if enumType == "TotemType" or (enumType and enumType:find("TotemType")) then
        if type(enumValue) == "number" and enumValue >= 1 and enumValue <= 4 then
            return tostring(enumValue)
        end
    end

    -- Special handling for ExecutePhaseThreshold: emit numeric percentage, not enum name
    if enumType == "ExecutePhaseThreshold" or enumType:find("ExecutePhaseThreshold") then
        if type(enumValue) == "number" then
            -- Try to get enum label and extract numeric part (e.g., "E25" -> "25")
            if SchemaAccessor then
                local label = SchemaAccessor:GetEnumLabel(enumType, enumValue)
                if label then
                    local numericStr = label:match("^E(%d+)$")
                    if numericStr then
                        return numericStr
                    end
                    return label
                end
            end
            -- Fallback: reverse lookup in enum values
            if SchemaAccessor then
                local enumValues = SchemaAccessor:GetEnumValues(enumType)
                if enumValues then
                    for name, value in pairs(enumValues) do
                        if value == enumValue then
                            local numericStr = name:match("^E(%d+)$")
                            if numericStr then
                                return numericStr
                            end
                            return name
                        end
                    end
                end
            end
        elseif type(enumValue) == "string" then
            -- Extract numeric part from "E25" format
            local numericStr = enumValue:match("^E(%d+)$")
            if numericStr then
                return numericStr
            end
        end
    end

    -- RuneType / RuneSlot: emit NAG.Types.RuneType.X or NAG.Types.RuneSlot.X for round-trip (match DeathKnight.lua and Types.lua)
    if type(enumValue) == "number" and (enumType == "RuneType" or enumType == "RuneSlot"
        or (enumType and (enumType:find("RuneType") or enumType:find("RuneSlot")))) then
        local Types = NAG:GetModule("Types")
        if Types then
            local typeObj = Types:GetType(enumType)
            if typeObj and typeObj.GetNameByValue and typeObj.GetName then
                local memberName = typeObj:GetNameByValue(enumValue)
                if memberName then
                    return "NAG.Types." .. typeObj:GetName() .. "." .. memberName
                end
            end
        end
    end

    -- Standard enum emission: convert numeric value to enum label/name
    if type(enumValue) == "number" then
        if SchemaAccessor then
            local label = SchemaAccessor:GetEnumLabel(enumType, enumValue)
            if label then
                -- SpellPosition: emit NAG.SPELL_POSITIONS.X for round-trip (match source style)
                if enumType == "SpellPosition" or (enumType and enumType:find("SpellPosition")) then
                    local key = (label:match("^[A-Z_]+$") and label) or label:upper()
                    return "NAG.SPELL_POSITIONS." .. key
                end
                return label
            end
        end
        -- Fallback: emit numeric value
        return tostring(enumValue)
    end

    -- SpellPosition string value (e.g. "primary" after resolution): emit NAG.SPELL_POSITIONS.X for round-trip
    if type(enumValue) == "string" and (enumType == "SpellPosition" or (enumType and enumType:find("SpellPosition"))) then
        if enumValue:match("^NAG%.") or enumValue:match("^ns%.") then
            return enumValue
        end
        local key = enumValue:match("^[A-Z_]+$") and enumValue or enumValue:upper()
        if key and key ~= "" then
            return "NAG.SPELL_POSITIONS." .. key
        end
    end

    -- RuneType / RuneSlot string value (e.g. label "Rune Frost" or already "NAG.Types.RuneType.RuneFrost"): normalize to NAG.Types.*
    if type(enumValue) == "string" and (enumType == "RuneType" or enumType == "RuneSlot"
        or (enumType and (enumType:find("RuneType") or enumType:find("RuneSlot")))) then
        if enumValue:match("^NAG%.Types%.(RuneType|RuneSlot)%.") or enumValue:match("^ns%.Types%.") then
            return enumValue
        end
        local Types = NAG:GetModule("Types")
        if Types then
            local typeObj = Types:GetType(enumType)
            if typeObj and typeObj.GetName and typeObj._values then
                local canonicalName = typeObj:GetName()
                local normalizedInput = enumValue:gsub("%s", ""):lower()
                for memberName, numVal in pairs(typeObj._values) do
                    if memberName == enumValue or memberName:lower() == normalizedInput then
                        return "NAG.Types." .. canonicalName .. "." .. memberName
                    end
                end
            end
        end
    end

    -- Already a string - return as-is
    return tostring(enumValue)
end

--- Generic extraction based on field type (DEPRECATED - Use FromProto() instead)
--- @deprecated Use FieldFormatConverter:FromProto(protoValue, fieldInfo) for schema-aware extraction
--- @param fieldValue any Field value in proto format
--- @param fieldInfo table Schema field information
--- @return any Extracted primitive value for handler use
function FieldFormatConverter:ExtractValue(fieldValue, fieldInfo)
    -- Delegate to new schema-aware method
    return self:FromProto(fieldValue, fieldInfo)
end

-- ============================ HANDLER → PROTO FORMAT (Normalization) ============================

--- Normalize primitive value to proto ActionID message structure
--- @param value number|string|any Primitive value (spell/item ID)
--- @return table|nil ActionID message structure { spell_id: number }
function FieldFormatConverter:NormalizeActionID(value)
    NAG:Info("[FieldFormatConverter] Normalizing ActionID: %s (type=%s)", tostring(value), type(value))

    if not value then
        NAG:Warn("[FieldFormatConverter] NormalizeActionID: nil value provided")
        return nil
    end

    -- Already normalized
    if type(value) == "table" then
        if value._protoAST then
            NAG:Info("[FieldFormatConverter] NormalizeActionID: Already normalized (has _protoAST)")
            return value._protoAST
        end
        -- Check if already has ActionID structure
        if value.spell_id or value.item_id or value.other_id then
            NAG:Info("[FieldFormatConverter] NormalizeActionID: Already normalized (has ActionID structure)")
            return value
        end
        -- Try to extract from nested structure
        if value.value ~= nil then
            value = value.value
        end
    end

    local extracted = ExtractValue(value)
    local numeric = ToNumber(extracted)
    if numeric then
        local result = { spell_id = numeric }
        NAG:Info("[FieldFormatConverter] Normalized ActionID: %d", numeric)
        return result
    end

    -- Try string to number conversion
    if type(extracted) == "string" and extracted ~= "" then
        local asNumber = tonumber(extracted)
        if asNumber then
            local result = { spell_id = asNumber }
            NAG:Info("[FieldFormatConverter] Normalized ActionID from string: %d", asNumber)
            return result
        end
        -- Handle NAG:ResolveEffectiveSpellId(n)
        local resolved = ResolveSpellIdString(extracted)
        if resolved then
            local result = { spell_id = resolved }
            NAG:Info("[FieldFormatConverter] Normalized ActionID from ResolveEffectiveSpellId: %d", resolved)
            return result
        end
    end

    NAG:Warn("[FieldFormatConverter] NormalizeActionID: Failed to normalize value %s (type=%s)", tostring(value), type(value))
    return nil
end

--- Normalize primitive value to proto UnitReference message structure
--- @param value string|number|any Primitive value (unit name or enum)
--- @return table|nil UnitReference message structure { type: enum }
function FieldFormatConverter:NormalizeUnitReference(value)
    NAG:Info("[FieldFormatConverter] Normalizing UnitReference: %s (type=%s)", tostring(value), type(value))

    if value == nil then
        NAG:Warn("[FieldFormatConverter] NormalizeUnitReference: nil value provided")
        return nil
    end

    -- Already normalized
    if type(value) == "table" then
        if value._protoAST then
            NAG:Info("[FieldFormatConverter] NormalizeUnitReference: Already normalized (has _protoAST)")
            return value._protoAST
        end
        -- Already-normalized UnitReference tables use numeric type/index/owner fields
        if (type(value.type) == "number") or value.index or value.owner then
            NAG:Info("[FieldFormatConverter] NormalizeUnitReference: Already normalized (has UnitReference structure)")
            return value
        end
        if value.value ~= nil then
            value = value.value
        end
    end

    if type(value) == "string" then
        -- Detect position identifiers (NAG.SPELL_POSITIONS.*) - these should NOT be converted to UnitReference
        if value:match("^NAG%.SPELL_POSITIONS%.") or value:match("^ns%.SPELL_POSITIONS%.") then
            -- This is a position identifier, not a unit reference - return nil to prevent incorrect conversion
            NAG:Warn("[FieldFormatConverter] NormalizeUnitReference: Rejected position identifier as UnitReference: %s", value)
            return nil
        end

        -- CRITICAL: Reject numeric strings that look like spell IDs (typically > 1000)
        -- These should be normalized as ActionID, not UnitReference
        local asNumber = tonumber(value)
        if asNumber and asNumber > 20 then
            -- This looks like a spell ID or other large number, not a unit reference - reject it
            NAG:Warn("[FieldFormatConverter] NormalizeUnitReference: Rejected numeric string as UnitReference (likely spell ID): %s", value)
            return nil
        end

        local normalized = NormalizeString(value)

        -- Use Types registry for UnitReference.Type enum (imported from schema)
        -- NormalizeEnumValue handles case-insensitive matching and schema/Types registry lookup
        local enumValue = self:NormalizeEnumValue(normalized, "UnitReference.Type")
        if enumValue ~= nil then
            local result = { type = enumValue }
            NAG:Info("[FieldFormatConverter] Normalized UnitReference: %s -> %d", value, enumValue)
            return result
        end

        -- Fallback: store as owner->unit for backward compatibility
        NAG:Warn("[FieldFormatConverter] NormalizeUnitReference: Could not resolve enum for '%s', storing as unit string", value)
        return { type = nil, unit = value }
    end

    if type(value) == "number" then
        -- UnitReference types are small enum values (typically 1-10)
        -- Spell IDs are typically > 1000, so reject large numbers to prevent incorrect conversion
        if value > 20 then
            -- This looks like a spell ID or other large number, not a unit type - reject it
            NAG:Warn("[FieldFormatConverter] NormalizeUnitReference: Rejected large number as UnitReference (likely spell ID): %d", value)
            return nil
        end
        local result = { type = value }
        NAG:Info("[FieldFormatConverter] Normalized UnitReference from number: %d", value)
        return result
    end

    NAG:Warn("[FieldFormatConverter] NormalizeUnitReference: Failed to normalize value %s (type=%s)", tostring(value), type(value))
    return nil
end

--- Normalize primitive value to proto APLValue message structure
--- @param value string|table|any Primitive value (string like "NAG:MaxEnergy()" or AST node)
--- @return table|nil APLValue message structure { [valueType] = valueData }
function FieldFormatConverter:NormalizeAPLValue(value)
    NAG:Info("[FieldFormatConverter] Normalizing APLValue: %s (type=%s)", tostring(value), type(value))

    if not value then
        NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: nil value provided")
        return nil
    end

    -- Already normalized - check if it's proto-compatible structure
    if type(value) == "table" then
        -- Check if already proto-compatible (has a valueType key like { max_energy = {} })
        -- Proto APLValue structure: { [valueType] = valueData }
        local hasValueTypeKey = false
        for key, _ in pairs(value) do
            -- Check if key looks like a value type (snake_case, not metadata keys)
            if type(key) == "string" and not key:match("^_") and key ~= "type" and key ~= "value" then
                hasValueTypeKey = true
                break
            end
        end
        if hasValueTypeKey then
            NAG:Info("[FieldFormatConverter] NormalizeAPLValue: Already normalized (has proto-compatible structure)")
            return value
        end

        -- Check if it's an AST node (has type == ASTCore.NodeType.VALUE)
        local ASTCore = ns.ASTCore
        local ASTValue = ns.ASTValue
        if ASTCore and ASTValue and value.type == ASTCore.NodeType.VALUE then
            -- Convert AST node to proto structure
            local valueType = ASTValue.GetValueType(value)
            local valueData = ASTValue.GetValueData(value)

            -- Special handling: If this is a CONST node containing a function call string (e.g., "NAG:MaxEnergy()"),
            -- re-parse it to try to resolve it as a proper APLValue. This handles cases where metadata lookup
            -- failed during initial parsing and the function was stored as a constant.
            if valueType == ASTValue.ValueType.CONST and valueData and valueData.val and type(valueData.val) == "string" then
                local constValue = valueData.val
                -- Check if it looks like a function call that should be re-parsed
                if constValue:match("^NAG:%w+%s*%(") or constValue:match("^%w+%s*%(") then
                    NAG:Info("[FieldFormatConverter] NormalizeAPLValue: CONST node contains function call string, re-parsing: %s", constValue)
                    -- Re-parse the string to try to resolve it properly
                    local NAGStringParser = NAG:GetModule("NAGStringParser")
                    if NAGStringParser then
                        local reparsedNode = NAGStringParser:ParseValue(constValue)
                        if reparsedNode and reparsedNode.type == ASTCore.NodeType.VALUE then
                            local reparsedValueType = ASTValue.GetValueType(reparsedNode)
                            -- Only use re-parsed result if it's not another CONST (successful resolution)
                            if reparsedValueType ~= ASTValue.ValueType.CONST then
                                NAG:Info("[FieldFormatConverter] NormalizeAPLValue: Successfully re-parsed CONST function call: %s -> %s", constValue, reparsedValueType)
                                -- Recursively normalize the re-parsed node
                                return self:NormalizeAPLValue(reparsedNode)
                            else
                                NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: Re-parsing CONST function call failed (still CONST): %s", constValue)
                            end
                        end
                    end
                end
            end

            if valueType and valueData then
                local protoStructure = {}
                protoStructure[valueType] = valueData

                -- CRITICAL: Recursively normalize nested APLValue fields within valueData
                -- Get schema for this valueType to normalize nested fields
                if SchemaAccessor then
                    local messageSchema = nil

                    -- Check if valueType is already a message type name (starts with "APL")
                    if valueType:match("^APL") then
                        -- Already a message type name, use directly
                        messageSchema = SchemaAccessor:GetMessageSchema(valueType)
                    else
                        -- valueType is a snake_case field name - look up schema directly
                        -- Try APLValue container first (most common)
                        messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(valueType, "APLValue")

                        -- If not found in APLValue, try APLAction container
                        if not messageSchema then
                            messageSchema = SchemaAccessor:GetMessageSchemaFromFieldName(valueType, "APLAction")
                        end
                    end
                    if messageSchema and messageSchema.fields and type(valueData) == "table" then
                        -- Recursively normalize nested APLValue fields using schema
                        for fieldName, fieldDef in pairs(messageSchema.fields) do
                            if valueData[fieldName] ~= nil then
                                if fieldDef.type == "message" and
                                   (fieldDef.message_type == "APLValue" or (fieldDef.message_type and fieldDef.message_type:find("^APLValue"))) then
                                    -- This is a nested APLValue field - recursively normalize it
                                    local nestedValue = valueData[fieldName]
                                    -- Handle repeated fields (arrays of APLValue)
                                    if fieldDef.label == "repeated" and type(nestedValue) == "table" then
                                        for i, item in ipairs(nestedValue) do
                                            -- Check if item is an AST node that needs normalization
                                            if type(item) == "table" and item.type == ASTCore.NodeType.VALUE then
                                                nestedValue[i] = self:NormalizeAPLValue(item)
                                            end
                                        end
                                        valueData[fieldName] = nestedValue
                                    elseif type(nestedValue) == "table" then
                                        -- Check if it's already a proto structure (already normalized)
                                        local isAlreadyNormalized = false
                                        for key, _ in pairs(nestedValue) do
                                            if type(key) == "string" and not key:match("^_") and key ~= "type" and key ~= "value" then
                                                isAlreadyNormalized = true
                                                break
                                            end
                                        end
                                        if not isAlreadyNormalized and nestedValue.type == ASTCore.NodeType.VALUE then
                                            -- Single APLValue field AST node - normalize it
                                            local normalized = self:NormalizeAPLValue(nestedValue)
                                            if normalized then
                                                valueData[fieldName] = normalized
                                            else
                                                NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: Recursive normalization failed for field '%s'", fieldName)
                                            end
                                        end
                                        -- If already normalized or not an AST node, keep as-is
                                    end
                                end
                            end
                        end
                    end
                end

                NAG:Info("[FieldFormatConverter] Normalized APLValue from AST node: %s", valueType)
                return protoStructure
            end
            -- Fallback: return raw node if conversion fails
            NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: Failed to extract valueType/valueData from AST node, returning raw node")
            return value
        end

        -- Try to extract from nested structure
        if value.value ~= nil then
            value = value.value
        end
    end

    -- If string, parse it using NAGStringParser
    if type(value) == "string" then
        local NAGStringParser = NAG:GetModule("NAGStringParser")
        if not NAGStringParser then
            NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: NAGStringParser module not available")
            return nil
        end

        -- Parse string to AST node
        local astNode = NAGStringParser:ParseValue(value)
        if not astNode then
            NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: Failed to parse string to AST node: %s", value)
            return nil
        end

        -- Convert AST node to proto structure
        local ASTCore = ns.ASTCore
        local ASTValue = ns.ASTValue
        if ASTCore and ASTValue and astNode.type == ASTCore.NodeType.VALUE then
            local valueType = ASTValue.GetValueType(astNode)
            local valueData = ASTValue.GetValueData(astNode)
            if valueType and valueData then
                local protoStructure = {}
                protoStructure[valueType] = valueData
                NAG:Info("[FieldFormatConverter] Normalized APLValue from string: %s -> %s", value, valueType)
                return protoStructure
            end
            NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: Failed to extract valueType/valueData from parsed AST node: %s", value)
        else
            NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: Parsed AST node is not a VALUE node: %s", value)
        end

        return nil
    end

    NAG:Warn("[FieldFormatConverter] NormalizeAPLValue: Unexpected value type %s, returning nil", type(value))
    return nil
end

--- Normalize primitive value to enum numeric value
--- Handles identifier strings (NAG.SPELL_POSITIONS.*, NAG.Types.*) - preserves them as strings when appropriate
--- @param value any Primitive value (number, string, etc.)
--- @param enumType string Enum type name
--- @param options table|nil Optional: { preserveIdentifiers = boolean } - preserve identifier strings instead of resolving
--- @return number|string|nil Normalized enum numeric value, or identifier string if preserved
function FieldFormatConverter:NormalizeEnumValue(value, enumType, options)
    if value == nil or not enumType then
        if not enumType then
            NAG:Warn("[FieldFormatConverter] NormalizeEnumValue: enumType is nil")
        end
        return nil
    end

    -- Map enum type names (schema uses singular, Types uses plural)
    local enumTypeMapped = enumType
    if enumType == "SpellPosition" then
        enumTypeMapped = "SpellPositions"
    end

    local extracted = ExtractValue(value)

    -- Strip quotes from string values (e.g., '"player"' -> 'player')
    if type(extracted) == "string" then
        -- Remove surrounding quotes if present
        local unquoted = extracted:match('^"(.*)"$') or extracted:match("^'(.*)'$")
        if unquoted then
            extracted = unquoted
        end
    end

    local numeric = ToNumber(extracted)

    -- Special handling for ExecutePhaseThreshold: convert numeric percentages to enum names
    if numeric ~= nil and enumType and (enumType == "ExecutePhaseThreshold" or enumType:find("ExecutePhaseThreshold")) then
        if SchemaAccessor then
            local enumValues = SchemaAccessor:GetEnumValues(enumType)
            if enumValues then
                -- Convert numeric percentage to enum name (e.g., 20 -> "E20")
                local enumNameStr = "E" .. tostring(numeric)
                if enumValues[enumNameStr] ~= nil then
                    return enumValues[enumNameStr]
                end
            end
        end
    end

    if numeric ~= nil then
        return numeric
    end

    local normalized = NormalizeString(extracted)
    if not normalized or normalized == "" then
        NAG:Warn("[FieldFormatConverter] NormalizeEnumValue: Empty or invalid normalized string for enumType '%s': %s", enumType, tostring(extracted))
        return nil
    end

    -- Check if extracted is an identifier reference (NAG.SPELL_POSITIONS.*, NAG.Types.*)
    if type(extracted) == "string" then
        local isIdentifier, identifierType = IsIdentifierReference(extracted)
        if isIdentifier then
            -- Check if identifier matches enum type patterns - ALWAYS try to resolve first
            if enumType then
                -- SpellPosition: Try to resolve NAG.SPELL_POSITIONS.* identifiers
                if enumType == "SpellPosition" or enumType:find("SpellPosition") then
                    if extracted:match("^NAG%.SPELL_POSITIONS%.") or extracted:match("^ns%.SPELL_POSITIONS%.") then
                        -- Try to resolve first
                        local identifierMatch = extracted:match("^NAG%.SPELL_POSITIONS%.(%w+)$") or extracted:match("^ns%.SPELL_POSITIONS%.(%w+)$")
                        if identifierMatch then
                            local Types = NAG:GetModule("Types")
                            if Types then
                                local spellPositionsType = Types:GetType("SpellPositions")
                                if spellPositionsType then
                                    local enumKey = identifierMatch:upper()
                                    local enumValue = spellPositionsType[enumKey] or (spellPositionsType._values and spellPositionsType._values[enumKey])
                                    if enumValue ~= nil then
                                        -- Resolution succeeded - return resolved value
                                        return enumValue
                                    end
                                end
                            end
                        end
                        -- Resolution failed - check if we should preserve the identifier string
                        local preserveIdentifiers = options and options.preserveIdentifiers
                        if preserveIdentifiers then
                            -- Preserve identifier string for execution-time resolution
                            return extracted
                        end
                        -- No resolution and no preservation requested - fall through to normal enum value lookup below
                    end
                end

                -- RuneType / APLValueRuneType: resolve NAG.Types.RuneType.* to numeric value for schema validation
                if enumType == "RuneType" or enumType:find("RuneType") then
                    if extracted:match("^NAG%.Types%.RuneType%.") or extracted:match("^ns%.Types%.RuneType%.") then
                        local suffix = extracted:match("^NAG%.Types%.RuneType%.(%w+)$") or extracted:match("^ns%.Types%.RuneType%.(%w+)$")
                        if suffix then
                            local Types = NAG:GetModule("Types")
                            if Types then
                                local typeObj = Types:GetType(enumType)
                                if typeObj then
                                    local v = typeObj[suffix] or (typeObj._values and typeObj._values[suffix])
                                    if v ~= nil then
                                        return v
                                    end
                                end
                            end
                        end
                        -- Unresolvable: preserve string so validation error is explicit
                        return extracted
                    end
                end

                -- RuneSlot / APLValueRuneSlot: resolve NAG.Types.RuneSlot.* to numeric value for schema validation
                if enumType == "RuneSlot" or enumType:find("RuneSlot") then
                    if extracted:match("^NAG%.Types%.RuneSlot%.") or extracted:match("^ns%.Types%.RuneSlot%.") then
                        local suffix = extracted:match("^NAG%.Types%.RuneSlot%.(%w+)$") or extracted:match("^ns%.Types%.RuneSlot%.(%w+)$")
                        if suffix then
                            local Types = NAG:GetModule("Types")
                            if Types then
                                local typeObj = Types:GetType(enumType)
                                if typeObj then
                                    local v = typeObj[suffix] or (typeObj._values and typeObj._values[suffix])
                                    if v ~= nil then
                                        return v
                                    end
                                end
                            end
                        end
                        -- Unresolvable: preserve string so validation error is explicit
                        return extracted
                    end
                end

                if enumType == "MobType" or enumType:find("MobType") then
                    if extracted:match("^NAG%.Types%.MobType%.") or extracted:match("^ns%.Types%.MobType%.") then
                        return extracted
                    end
                end

                if enumType == "TotemType" or enumType:find("TotemType") then
                    if extracted:match("^NAG%.Types%.TotemType%.") or extracted:match("^ns%.Types%.TotemType%.") then
                        return extracted
                    end
                end
            end

            -- Handle NAG.Types.* identifiers (try to resolve, delegate to existing logic below)
        end
    end

    -- Get enum values from schema
    local enumValues = nil
    if SchemaAccessor then
        enumValues = SchemaAccessor:GetEnumValues(enumTypeMapped)
    end

    if enumValues then
        -- Direct match
        if extracted and enumValues[extracted] ~= nil then
            return enumValues[extracted]
        end

        -- Case-insensitive match
        if type(extracted) == "string" then
            local upper = enumValues[extracted:upper()]
            if upper ~= nil then
                return upper
            end

            local lower = enumValues[extracted:lower()]
            if lower ~= nil then
                return lower
            end
        end

        -- Normalized key match
        for name, enumValue in pairs(enumValues) do
            if type(name) == "string" then
                local short = NormalizeEnumKey(name)
                if short == normalized or name:lower() == normalized then
                    return enumValue
                end
            end
        end
    end

    -- Try NAG.Types registry
    local Types = NAG:GetModule("Types")
    if Types then
        local candidates = {}
        if enumTypeMapped then
            table.insert(candidates, enumTypeMapped)
            local short = enumTypeMapped:match("([^.]+)$")
            if short then
                table.insert(candidates, short)
            end
        end
        -- Also try original enumType in case it's different
        if enumType and enumType ~= enumTypeMapped then
            table.insert(candidates, enumType)
            local short = enumType:match("([^.]+)$")
            if short then
                table.insert(candidates, short)
            end
        end

        local enumValueName = extracted
        if type(extracted) == "string" and extracted:match("^NAG%.Types%.") then
            enumValueName = extracted:match("([^.]+)$") or extracted
        end

        for _, candidate in ipairs(candidates) do
            local typeObj = Types:GetType(candidate)
            if typeObj then
                -- Helper function to create title case (first letter uppercase, rest lowercase)
                local function toTitleCase(str)
                    if not str or type(str) ~= "string" or str == "" then
                        return nil
                    end
                    return str:sub(1, 1):upper() .. str:sub(2):lower()
                end

                local payloads = {
                    extracted,
                    enumValueName,
                    type(extracted) == "string" and extracted:upper() or nil,
                    type(extracted) == "string" and extracted:lower() or nil,
                    toTitleCase(extracted),
                    type(enumValueName) == "string" and enumValueName:upper() or nil,
                    type(enumValueName) == "string" and enumValueName:lower() or nil,
                    toTitleCase(enumValueName),
                }

                for _, key in ipairs(payloads) do
                    if key ~= nil then
                        local val = typeObj[key] or (typeObj._values and typeObj._values[key])
                        if val ~= nil then
                            if NAG.debug then NAG:Debug("[FieldFormatConverter] NormalizeEnumValue: Found enum value '%s' -> %d for enumType '%s' (matched key: '%s')",
                                tostring(extracted), val, enumType, tostring(key)) end
                            return val
                        end
                    end
                end
            end
        end
    end

    -- Stat enum: resolve common abbreviations (e.g. str -> STRENGTH, agi -> AGILITY) used in APL strings
    if type(extracted) == "string" and (enumType == "Stat" or (type(enumType) == "string" and enumType:find("Stat"))) then
        local statAliases = {
            str = 1, strength = 1,
            agi = 2, agility = 2,
            sta = 3, stamina = 3,
            int = 4, intellect = 4,
            spi = 5, spirit = 5,
            hit = 6, crit = 7, haste = 8,
            expert = 9, expertise = 9,
            dodge = 10, parry = 11, mastery = 12,
            ap = 13, attack_power = 13,
            rap = 14, ranged_attack_power = 14,
            sp = 15, spell_power = 15,
            spellpen = 16, spell_penetration = 16,
            res = 17, resilience = 17,
            arcane_resistance = 18, fire_resistance = 19, frost_resistance = 20,
            nature_resistance = 21, shadow_resistance = 22,
            armor = 23, bonus_armor = 24,
            health = 25, mana = 26, mp5 = 27,
        }
        local key = extracted:lower():gsub("[%s%-]", "_")
        if statAliases[key] ~= nil then
            if NAG.debug then NAG:Debug("[FieldFormatConverter] NormalizeEnumValue: Stat alias '%s' -> %d for enumType '%s'",
                tostring(extracted), statAliases[key], enumType) end
            return statAliases[key]
        end
    end

    NAG:Warn("[FieldFormatConverter] NormalizeEnumValue: Failed to find enum value '%s' for enumType '%s'", tostring(extracted), enumType)
    return nil
end

--- Generic normalization based on field type (DEPRECATED - Use ToProto() instead)
--- @deprecated Use FieldFormatConverter:ToProto(value, fieldInfo) for schema-aware conversion
--- @param value any Primitive value from handler
--- @param fieldInfo table Schema field information
--- @return any Normalized proto format value
function FieldFormatConverter:NormalizeToProto(value, fieldInfo)
    -- Delegate to new schema-aware method
    return self:ToProto(value, fieldInfo)
end

-- ============================ PROTO ↔ WOWSIMS FORMAT ============================

--- Transform proto data to WoWSims JSON format
--- Converts snake_case fields to camelCase and flattens nested structures where appropriate
--- @param protoData table Proto data (snake_case, nested)
--- @return table WoWSims data (camelCase, flattened)
function FieldFormatConverter:ProtoToWoWSims(protoData)
    if not protoData or type(protoData) ~= "table" then
        return protoData
    end

    if not SchemaUtils then
        return protoData
    end

    -- Convert keys to camelCase
    local wowsimsData = SchemaUtils:ConvertKeysToCamelCase(protoData)

    -- Note: ActionID is flat in schema { spell_id: 12345 }, so no flattening needed
    -- WoWSims JSON may show nested structures like { spellId: { spellId: 12345 } }
    -- but that's WoWSims format, not our proto format

    return wowsimsData
end

--- Transform WoWSims data to proto format
--- Converts camelCase fields to snake_case and nests structures where appropriate
--- @param wowsimsData table WoWSims data (camelCase, flattened)
--- @return table Proto data (snake_case, nested)
function FieldFormatConverter:WoWSimsToProto(wowsimsData)
    if not wowsimsData or type(wowsimsData) ~= "table" then
        return wowsimsData
    end

    if not SchemaUtils then
        return wowsimsData
    end

    -- Convert keys to snake_case
    local protoData = SchemaUtils:ConvertKeysToSnakeCase(wowsimsData)

    -- Note: ActionID is flat in schema { spell_id: 12345 }, so no nesting needed
    -- WoWSims JSON may have nested ActionID like { spellId: { spellId: 12345 } }
    -- Handle this by extracting the inner value when converting
    if protoData.spell_id and type(protoData.spell_id) == "table" and protoData.spell_id.spell_id then
        -- Handle nested WoWSims format: extract inner value to flat format
        protoData.spell_id = protoData.spell_id.spell_id
    end

    return protoData
end

return FieldFormatConverter

