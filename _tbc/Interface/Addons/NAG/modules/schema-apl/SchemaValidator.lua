--- @module "NAG.SchemaValidator"
--- Provides schema-based validation for APL functions and arguments using the modified schema.
---
--- This module validates APL function calls against the modified schema (provided by SchemaAccessor),
--- which includes modifications applied by SchemaModifier. Provides both strict schema validation
--- and backward compatibility with existing systems.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

-- Addon references
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type SchemaAccessor
local SchemaAccessor

--- @type SchemaUtils
local SchemaUtils

--- @type DataManager
local DataManager


local TableUtils = ns.TableUtils

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs (WoW optimized where available)
local format = string.format
local floor = math.floor
local min = math.min



local strlower = strlower

local tinsert = tinsert

local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class SchemaValidator:CoreModule
local SchemaValidator = NAG:CreateModule("SchemaValidator", {
    char = {
        disableValidation = false
    }
}, {
    debug = false,
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.FEATURES
    },

    -- Automatic message registration
    messageHandlers = {
        ["NAG_VERSION_DATA_SELECTED"] = true,
        ["NAG_SCHEMA_MODIFICATIONS_COMPLETE"] = true
    },

    -- Automatic options injection
    optionsComposers = {
        ["debugOptions"] = true  -- Calls SchemaValidator:debugOptions(options, context)
    },

    -- Automatic slash command registration
    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["schema_validator"] = {
            handler = "nagschema",
            help = "Test and explore the SchemaValidator system",
            root = "nagdebug",
            path = {"schema", "validator"},
            category = "Debug"
        },
        ["schema_aliases"] = {
            handler = "ShowFunctionAliases",
            help = "Show all generated function aliases",
            root = "nagdebug",
            path = {"schema", "aliases"},
            category = "Debug"
        },
        ["schema_mappings"] = {
            handler = "ShowNAGFunctionMappings",
            help = "Show NAG function name mappings",
            root = "nagdebug",
            path = {"schema", "mappings"},
            category = "Debug"
        },
        ["schema_test"] = {
            handler = "TestValidation",
            help = "Test validation for a specific function",
            root = "nagdebug",
            path = {"schema", "test"},
            category = "Debug"
        }
    }
})
local module = SchemaValidator
ns.SchemaValidator = SchemaValidator

-- Initialize module properties
SchemaValidator.initialized = false
SchemaValidator.valueAliasOverrides = {
    const = { "constant" },
    cmp = { "compare", "comparison" }
}

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~

function SchemaValidator:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    SchemaAccessor = NAG:GetModule("SchemaAccessor")
    SchemaUtils = NAG:GetModule("SchemaUtils")
    DataManager = NAG:GetModule("DataManager")

    -- Message registration is handled automatically via messageHandlers table
    -- This avoids circular dependencies by using the message bus instead of direct callbacks
    -- SchemaModifier will send NAG_SCHEMA_MODIFICATIONS_COMPLETE message when done
    if self.debug then
        self:Debug("SchemaValidator initialized - will receive schema modification notifications via message system")
    end
end

function SchemaValidator:ModuleEnable()
end

function SchemaValidator:ModuleDisable()
end

--function SchemaValidator:ModuleInitialize()
--    local startTime = debugprofilestop()
--
--    -- Initialize immediately if SchemaAccessor is available
--    -- Don't wait for NAG_VERSION_DATA_SELECTED message to avoid race conditions
--    if self:InitializeSchemaData() then
--        self:InitializeValidationSystem()
--        self.initialized = true
--        self:Debug("SchemaValidator initialized immediately during ModuleInitialize")
--        self:Debug("Schema initialized with %d proto-to-NAG mappings", TableUtils.Size(SchemaAccessor:GetAllProtoToNagMappings()))
--        self:Debug("Schema has %d message types", self.schemaData and TableUtils.Size(self.schemaData.messages or {}) or 0)
--
--        -- Log some sample aliases for debugging
--        local aliases = self:GetAvailableAliases()
--        if #aliases > 0 then
--            self:Debug("Sample aliases generated:")
--            for i = 1, math.min(5, #aliases) do
--                local alias = aliases[i]
--                self:Debug("  %s -> %s", alias.protoName, alias.nagName)
--            end
--        end
--    else
--        self:Debug("SchemaAccessor not ready yet, will initialize when available")
--    end
--
--    local endTime = debugprofilestop()
--    if self.debug then self:Debug("SchemaValidator initialization took %.2f ms", endTime - startTime) end
--end

--- Called when DataLoader has finished processing version data
--- This ensures we load custom handlers after DataLoader has flattened the structure
function SchemaValidator:NAG_VERSION_DATA_SELECTED(message)
    if self.debug then
        self:Debug("DataLoader complete; waiting for NAG_SCHEMA_MODIFICATIONS_COMPLETE before SchemaValidator initialization")
    end
end

--- Called when schema modifications are complete (via message system)
--- SchemaModifier sends NAG_SCHEMA_MODIFICATIONS_COMPLETE message after applying modifications
--- @param message string The message name
--- @param modifiedSchema table The modified schema data
function SchemaValidator:NAG_SCHEMA_MODIFICATIONS_COMPLETE(message, modifiedSchema)
    if self.debug then
        self:Debug("Schema modifications complete, initializing SchemaValidator (authoritative path)")
    end

    local schemaData = (SchemaAccessor and SchemaAccessor:GetSchemaData()) or modifiedSchema
    if not schemaData then
        self:Error("NAG_SCHEMA_MODIFICATIONS_COMPLETE received, but schema data is not available")
        return
    end

    -- Authoritative initialization path: always refresh validator state when schema is rebuilt.
    self:InitializeValidationSystem()
    self.initialized = true
    NAG:SendMessage("NAG_SCHEMA_VALIDATOR_READY")

    if self.debug then
        self:Debug("SchemaValidator fully initialized after schema modifications; emitted NAG_SCHEMA_VALIDATOR_READY")
    end
end

--- Fallback initialization when SchemaModifier is already done
function SchemaValidator:FallbackInitialization()
    if self.initialized then
        return
    end

    if self.debug then
        self:Debug("Using fallback initialization - getting schema from SchemaAccessor")
    end

    if SchemaAccessor then
        local schemaData = SchemaAccessor:GetSchemaData()
        if schemaData then
            self:InitializeValidationSystem()
            self.initialized = true
            if self.debug then
                self:Debug("SchemaValidator initialized via fallback method")
            end
        else
            self:Error("Fallback initialization failed - no schema data available")
        end
    else
        self:Error("Fallback initialization failed - SchemaAccessor not available")
    end
end

-- ~~~~~~~~~~ SCHEMA INITIALIZATION ~~~~~~~~~~

-- Note: InitializeSchemaData removed - use OnSchemaModificationsComplete instead

--- Initialize the validation system
function SchemaValidator:InitializeValidationSystem()
    -- Reset cached metadata derived from schema
end


--- Return the NAG function name for a given proto message name.
--- @param protoName string
--- @return string|nil
function SchemaValidator:GetNagName(protoName)
    return SchemaAccessor:GetNagNameFromProtoName(protoName)
end

-- Note: GetArgumentMapping removed - field_order modifications are now used instead

-- ============================ SCHEMA-BASED VALIDATION ============================


--- Validate a NAG function call against the schema
--- @param functionName string The name of the function to validate
--- @param args table The arguments to validate
--- @param callIndex number|nil Optional call index for context (1-based)
--- @return boolean valid Whether the function call is valid
--- @return string|nil error Error message if validation failed
--- @return table|nil validationInfo Additional validation information
function SchemaValidator:ValidateFunctionCall(functionName, args, callIndex)
    --self:Info("ValidateFunctionCall: Validating function call (functionName='%s', argsCount=%d)",
    --    functionName or "nil", args and #args or 0)

    if not self.initialized then
        self:Warn("ValidateFunctionCall: SchemaValidator not initialized, cannot validate functionName='%s'", functionName or "nil")
        if self.debug then
            self:Debug("Not initialized: fn='%s'", functionName)
        end
        return false, "SchemaValidator not initialized"
    end

    if not functionName or type(functionName) ~= "string" then
        self:Warn("ValidateFunctionCall: Invalid function name provided (type=%s, value=%s)",
            type(functionName), tostring(functionName))
        if self.debug then
            self:Debug("Invalid function name: fn='%s', type=%s", functionName, type(functionName))
        end
        return false, "Invalid function name"
    end

    if self.debug then
        self:Debug("ValidateFunctionCall('%s'): init=%s",
            functionName, tostring(self.initialized))
    end

    -- Get protoName using direct schema structure check (O(1) instead of O(n) alias iteration)
    local protoName = SchemaAccessor:GetProtoNameFromNagName(functionName)
    local messageInfo = protoName and SchemaAccessor:GetMessageSchema(protoName) or nil
    local originalName = functionName
    local aliasUsed = protoName
    local nagMappingUsed = protoName and SchemaAccessor.nagFunctionMappings[functionName] and protoName or nil

    if self.debug then
        if protoName then
            self:Debug("Found via schema check: fn='%s' -> proto='%s'", functionName, protoName)
        else
            self:Debug("Schema check failed: fn='%s' not found in schema", functionName)
        end
    end

    if not messageInfo then
        self:Warn("ValidateFunctionCall: Function '%s' not found in schema (protoName=%s)",
            functionName, protoName and tostring(protoName) or "nil")
        return false, format("Function '%s' not found in schema", functionName)
    end

    if self.debug then
        local msgKeys = messageInfo and table.concat(TableUtils.Keys(messageInfo), ",") or "nil"
        self:Debug("ValidateFunctionCall('%s'): Found, msgInfo(type=%s,keys=[%s])", functionName, type(messageInfo), msgKeys)
        self:Debug("ValidateArguments: fn='%s', proto='%s', nagMap=%s, alias=%s, orig='%s', args(type=%s,count=%d)",
            protoName, protoName, tostring(nagMappingUsed), tostring(aliasUsed), originalName, type(args), args and #args or 0)
    end

    -- Store call index for context in validation warnings
    self._currentCallIndex = callIndex

    -- Validate arguments against schema (protoName already found via GetProtoNameFromNagName)
    local valid, error, validationInfo = self:ValidateArguments(protoName, args or {})
    if not valid then
        self:Warn("ValidateFunctionCall: Argument validation failed for functionName='%s' (protoName='%s', error=%s)",
            functionName, protoName or "nil", error or "unknown error")
        if self.debug then
            self:Debug("Argument validation failed: fn='%s', error=%s", functionName, error or "unknown error")
        end
        self._currentCallIndex = nil
        return false, error, validationInfo
    end

    self._currentCallIndex = nil

    --self:Info("ValidateFunctionCall: Successfully validated functionName='%s' (protoName='%s')",
     --   functionName, protoName or "nil")
    if self.debug then
        self:Debug("Validation completed: fn='%s'", functionName)
    end

    return true, nil, validationInfo
end

--- Validate function arguments against schema definition using positional validation
--- @param functionName string The name of the function
--- @param args table The arguments to validate (positional array)
--- @return boolean valid Whether the arguments are valid
--- @return string|nil error Error message if validation failed
--- @return table|nil validationInfo Additional validation information
function SchemaValidator:ValidateArguments(functionName, args)
    -- Check if this is a recursive call for nested message validation
    local isNestedValidation = debugstack(2, 1, 0):find("ValidateFieldValue")

    --if not isNestedValidation then
    --    self:Info("ValidateArguments: Validating arguments (functionName='%s', argsCount=%d)",
    --        functionName or "nil", args and #args or 0)
    --end

    if self.debug then
        local validationType = isNestedValidation and "NESTED_MSG" or "FUNCTION"
        self:Debug("ValidateArguments('%s'): %s, fn='%s'(%s), args(type=%s,count=%d)",
            functionName, validationType, functionName, type(functionName), type(args), args and #args or 0)
    end

    local messageInfo = SchemaAccessor:GetMessageSchema(functionName)
    if self.debug then
        self:Debug("Schema lookup: fn='%s', found=%s",
            functionName, tostring(messageInfo ~= nil))
    end

    if not messageInfo then
        self:Warn("ValidateArguments: Message type '%s' not found in schema (wrong name or lookup failed)",
            functionName or "nil")
        if self.debug then
            self:Debug("No message info: fn='%s'(%s,len=%d) - wrong name or lookup failed",
                functionName, type(functionName), functionName and #functionName or 0)
        end
        return false, format("Function '%s' not found in schema", functionName)
    end

    if not messageInfo.fields then
        self:Warn("ValidateArguments: Message type '%s' has no fields table - validation may be incomplete",
            functionName or "nil")
    end
    if not messageInfo.field_order then
        self:Warn("ValidateArguments: Message type '%s' has no field_order table", functionName)
    end

    local fields = messageInfo.fields
    local fieldOrder = messageInfo.field_order

    if not fields then fields = {} end
    if not fieldOrder then fieldOrder = {} end

    -- Debug: Check if any fields are missing message_type when they should have it
    if fields then
        for fieldName, fieldDef in pairs(fields) do
            if fieldDef and fieldDef.type == "message" and not fieldDef.message_type then
                local fieldDefKeys = {}
                for k, v in pairs(fieldDef) do
                    if k ~= "_metadata" then
                        table.insert(fieldDefKeys, string.format("%s=%s", k, tostring(v)))
                    end
                end
                self:Warn("ValidateArguments: Message type '%s', field '%s' has type='message' but message_type is nil! fieldDef keys: %s",
                    functionName, fieldName, table.concat(fieldDefKeys, ", "))
            end
        end
    end

    -- Warn if argument_mapping is referenced (deprecated - field_order should match handler signature)
    if messageInfo._metadata and messageInfo._metadata.argument_mapping then
        self:Warn("ValidateArguments: argument_mapping is deprecated for %s - field_order should match handler signature", functionName)
    end

    if self.debug then
        local msgKeys = messageInfo and table.concat(TableUtils.Keys(messageInfo), ",") or "nil"
        local fieldOrderStr = fieldOrder and concat(fieldOrder, ",") or "none"
        self:Debug("Message info: fn='%s', type=%s, keys=[%s], fieldOrder=[%s], args(type=%s,count=%d)",
            functionName, type(messageInfo), msgKeys, fieldOrderStr, type(args), args and #args or 0)

        -- Show RAW argument values BEFORE any conversion
        if type(args) == "table" and #args > 0 then
            for i, rawValue in ipairs(args) do
                local rawType = type(rawValue)
                if rawType == "table" then
                    local keys = TableUtils.Keys(rawValue)
                    local keyStr = table.concat(keys, ",")
                    -- Build compact table representation
                    local tableRep = {}
                    local repCount = 0
                    for k, v in pairs(rawValue) do
                        if repCount < 3 then
                            tinsert(tableRep, format("%s=%s", tostring(k), tostring(v)))
                            repCount = repCount + 1
                        end
                    end
                    local tableStr = #tableRep > 0 and format("{%s}", table.concat(tableRep, ",")) or "{}"
                    self:Debug("Raw args[%d]: %s, keys=[%s]%s", i, rawType, keyStr, tableStr)
                else
                    self:Debug("Raw args[%d]: %s, value=%s", i, rawType, tostring(rawValue))
                end
            end
        end
    end

    local validationInfo = {
        functionName = functionName,
        expectedFields = fieldOrder,
        providedArgs = args,
        fieldValidations = {},
        missingRequired = {},
        invalidFields = {},
        extraFields = {}
    }

    -- Handle positional arguments using field_order
    if type(args) == "table" and #args >= 0 then
        if self.debug then
            self:Debug("Processing positional args: fn='%s', count=%d", functionName, #args)
        end

        -- This is a positional array (e.g., {"value1", "value2"})
        -- Map positional args to field names using field_order (which matches NAG handler signature)
        -- Use manual loop instead of ipairs to handle nil values (ipairs stops at first nil)
        -- Get actual max index (handles arrays with nil values)
        local maxIndex = args._maxIndex or #args
        for i = 1, maxIndex do
            local value = args[i]
            local fieldName = fieldOrder[i]
            local fieldInfo = fieldName and fields[fieldName] or nil

            -- Handle nil values - skip optional fields with nil, but preserve position for required fields
            if value == nil then
                if fieldInfo and fieldInfo.label == "optional" then
                    if self.debug then
                        self:Debug("ValidateArguments: Skipping optional field '%s' at position %d with nil value", fieldName or "none", i)
                    end
                    -- Don't validate nil for optional fields, but continue to next position
                    -- This preserves positional information for later arguments
                elseif fieldInfo and fieldInfo.label == "required" then
                    -- Required field with nil value - this is an error
                    tinsert(validationInfo.missingRequired, { name = fieldName, index = i })
                    if self.debug then
                        self:Debug("ValidateArguments: Required field '%s' at position %d has nil value", fieldName, i)
                    end
                end
                -- Continue to next position regardless
            else

            -- Debug: Log what fieldInfo looks like when retrieved
            if fieldInfo and fieldInfo.type == "message" then
                if not fieldInfo.message_type then
                    local fieldInfoKeys = {}
                    for k, v in pairs(fieldInfo) do
                        if k ~= "_metadata" then
                            table.insert(fieldInfoKeys, string.format("%s=%s", k, tostring(v)))
                        end
                    end
                    self:Warn("ValidateArguments: CRITICAL - fieldType='message' but message_type is nil! functionName=%s, fieldName=%s, position=%d, fieldInfo keys: %s",
                        functionName, fieldName or "nil", i, table.concat(fieldInfoKeys, ", "))

                    -- Also check what the raw field looks like in the schema
                    if fields[fieldName] then
                        local rawFieldKeys = {}
                        for k, v in pairs(fields[fieldName]) do
                            if k ~= "_metadata" then
                                table.insert(rawFieldKeys, string.format("%s=%s", k, tostring(v)))
                            end
                        end
                        self:Warn("ValidateArguments: Raw field in fields[%s] keys: %s", fieldName, table.concat(rawFieldKeys, ", "))
                    end
                else
                    if self.debug then
                        self:Debug("ValidateArguments: functionName=%s, fieldName=%s, position=%d, fieldType=%s, message_type=%s",
                            functionName, fieldName, i, fieldInfo.type, fieldInfo.message_type)
                    end
                end
            end

            -- Parse table strings for message type fields
            if fieldInfo and fieldInfo.type == "message" and type(value) == "string" then
                -- Check if the string looks like a table literal
                local trimmed = value:match("^%s*(.-)%s*$")
                if trimmed:match("^{") and trimmed:match("}$") then
                    -- Try to parse the table string
                    local chunkText = "return " .. trimmed
                    local func, err = loadstring(chunkText)
                    if func then
                        local success, result = pcall(func)
                        if success and type(result) == "table" then
                            value = result  -- Replace string with parsed table
                            if self.debug then
                                self:Debug("ValidateArguments: Parsed table string for field '%s' at position %d", fieldName, i)
                            end
                        end
                    end
                end
            end

            if self.debug then
                local valueType = type(value)
                local valueStr = tostring(value)
                local fieldLabel = fieldInfo and fieldInfo.label or "none"
                local fieldType = fieldInfo and fieldInfo.type or "none"
                if valueType == "table" then
                    local keys = TableUtils.Keys(value)
                    local keyStr = table.concat(keys, ",")
                    -- Build compact table representation
                    local tableRep = {}
                    local repCount = 0
                    for k, v in pairs(value) do
                        if repCount < 3 then
                            tinsert(tableRep, format("%s=%s", tostring(k), tostring(v)))
                            repCount = repCount + 1
                        end
                    end
                    local tableStr = #tableRep > 0 and format("{%s}", table.concat(tableRep, ",")) or "{}"
                    self:Debug("Arg[%d]->'%s': %s(%s), keys=[%s]%s [field: label=%s, type=%s]",
                        i, fieldName or "none", valueType, valueStr, keyStr, tableStr, fieldLabel, fieldType)
                else
                    self:Debug("Arg[%d]->'%s': %s(%s) [field: label=%s, type=%s]",
                        i, fieldName or "none", valueType, valueStr, fieldLabel, fieldType)
                end
            end

            if fieldName then
                -- Validate this field
                local fieldInfo = fields[fieldName]
                if fieldInfo then
                    -- CRITICAL: Skip positional validation for repeated fields
                    -- Repeated fields consume multiple arguments and are validated differently
                    if fieldInfo.label == "repeated" then
                        -- Validate that the first argument can be normalized to the repeated field's type
                        -- This catches early type mismatches while still allowing the field to consume remaining args
                        local canNormalize, normalizedValue = self:CanNormalizeToFieldType(value, fieldInfo)
                        if not canNormalize then
                            if self.debug then
                                self:Warn("Repeated field '%s' at position %d: first argument cannot be normalized to expected type (message_type=%s, type=%s) - parser will handle",
                                    fieldName, i, fieldInfo.message_type or "nil", fieldInfo.type or "nil")
                            end
                            -- Still mark as valid to skip, but log the type mismatch
                            -- The parser will handle this more gracefully
                        else
                            if self.debug then
                                self:Info("Repeated field '%s' at position %d: first argument normalized successfully, will consume remaining args",
                                    fieldName, i)
                            end
                        end
                        -- Skip validation for repeated fields in positional phase
                        -- They will be validated after parsing when they're collected into arrays
                        if self.debug then
                            self:Debug("Skipping positional validation for repeated field '%s' at position %d (will be validated after parsing)",
                                fieldName, i)
                        end
                        -- Mark as skipped, don't add to invalid fields
                        validationInfo.fieldValidations[fieldName] = {
                            valid = true,  -- Mark as valid to skip
                            error = nil,
                            fieldInfo = fieldInfo,
                            positionalIndex = i,
                            skipped = true  -- Mark as skipped for tracking
                        }
                    else
                        -- CRITICAL: For optional fields, allow type mismatches - they may be skipped
                        -- If there's a repeated field later, arguments might go to the repeated field instead
                        if self.debug then
                            local valueType = type(value)
                            local valueStr = tostring(value)
                            self:Debug("ValidateArguments: Validating field '%s' at position %d: value=%s (type=%s), fieldLabel=%s, fieldType=%s",
                                fieldName, i, valueStr, valueType, fieldInfo.label or "none", fieldInfo.type or "none")
                        end

                        local fieldValid, fieldError = self:ValidateFieldValue(fieldName, value, fieldInfo)

                        if not fieldValid and fieldError then
                            -- Validation failure - log as Warn with rotation context
                            local contextParts = {}
                            if self._currentRotationName then
                                tinsert(contextParts, format("rotation='%s'", self._currentRotationName))
                            end
                            if self._currentCallIndex then
                                tinsert(contextParts, format("entry #%d", self._currentCallIndex))
                            end
                            local contextStr = #contextParts > 0 and format(" [%s]", table.concat(contextParts, ", ")) or ""
                            self:Warn("ValidateArguments: Field '%s' at position %d validation failed: %s%s", fieldName, i, fieldError, contextStr)
                        end

                        if self.debug then
                            self:Debug("ValidateArguments: Field '%s' at position %d validation result: valid=%s, error=%s",
                                fieldName, i, tostring(fieldValid), fieldError or "none")
                        end

                        -- Check if there's a repeated field later in field_order that could consume remaining arguments
                        local hasRepeatedFieldLater = false
                        if not fieldValid and fieldInfo.label == "optional" then
                            for j = i + 1, #fieldOrder do
                                local laterFieldName = fieldOrder[j]
                                local laterFieldInfo = fields[laterFieldName]
                                if laterFieldInfo and laterFieldInfo.label == "repeated" then
                                    -- Validate that current argument can be normalized to repeated field's type
                                    local canNormalize, normalizedValue = self:CanNormalizeToFieldType(value, laterFieldInfo)
                                    if canNormalize then
                                    hasRepeatedFieldLater = true
                                    if self.debug then
                                            self:Info("Optional field '%s' at position %d skipped: argument matches repeated field '%s' at position %d",
                                            fieldName, i, laterFieldName, j)
                                    end
                                    break
                                    elseif self.debug then
                                        self:Debug("Optional field '%s' at position %d: repeated field '%s' at position %d cannot normalize value, continuing search",
                                            fieldName, i, laterFieldName, j)
                                    end
                                end
                            end
                        end

                        validationInfo.fieldValidations[fieldName] = {
                            valid = fieldValid or hasRepeatedFieldLater,  -- Allow if repeated field later
                            error = hasRepeatedFieldLater and nil or fieldError,
                            fieldInfo = fieldInfo,
                            positionalIndex = i,
                            skipped = hasRepeatedFieldLater
                        }

                        -- Only add to invalid fields if it's required or there's no repeated field to consume it
                        if not fieldValid and not hasRepeatedFieldLater then
                            if fieldInfo.label == "required" then
                                if self.debug then
                                    self:Debug("ValidateArguments: Required field '%s' at position %d validation failed - adding to invalid fields: %s",
                                        fieldName, i, fieldError or "unknown error")
                                end
                                tinsert(validationInfo.invalidFields, { name = fieldName, error = fieldError, index = i })
                            else
                                -- CRITICAL: Don't add optional fields to invalidFields even if validation fails
                                -- They will be skipped in parsing and handled by the parser's type-based matching
                                if self.debug then
                                    self:Debug("ValidateArguments: Optional field '%s' at position %d validation failed (type mismatch), but NOT adding to invalidFields - will be skipped in parsing: %s",
                                        fieldName, i, fieldError or "unknown error")
                                end
                            end
                        elseif hasRepeatedFieldLater then
                            if self.debug then
                                self:Info("Optional field '%s' at position %d skipped: repeated field will consume argument",
                                    fieldName, i)
                            end
                        end
                    end
                else
                    if self.debug then
                        self:Debug("Field not found: fn='%s', field='%s', pos=%d", functionName, fieldName, i)
                    end
                end
            else
                -- Extra positional argument - might be part of a repeated field
                -- Check if the LAST field in field_order is repeated (since we're past field_order)
                local isPartOfRepeatedField = false

                if #fieldOrder > 0 then
                    local lastFieldName = fieldOrder[#fieldOrder]
                    local lastFieldInfo = fields[lastFieldName]
                    if lastFieldInfo and lastFieldInfo.label == "repeated" then
                        -- Validate that this argument can be normalized to the repeated field's type
                        local canNormalize, normalizedValue = self:CanNormalizeToFieldType(value, lastFieldInfo)
                        if canNormalize then
                        isPartOfRepeatedField = true
                            if self.debug then
                                self:Info("Extra arg at position %d consumed by repeated field '%s': fn='%s', value=%s",
                                    i, lastFieldName, functionName, tostring(value))
                            end
                        else
                            if self.debug then
                                self:Warn("Extra arg at position %d cannot be normalized to repeated field '%s' type (message_type=%s, type=%s): fn='%s', value=%s",
                                    i, lastFieldName, lastFieldInfo.message_type or "nil", lastFieldInfo.type or "nil", functionName, tostring(value))
                            end
                        end
                    end
                end

                if isPartOfRepeatedField then
                    -- This extra argument is part of the last repeated field
                    -- Don't add to extra fields if it's part of a repeated field
                else
                    -- Truly extra positional argument
                    tinsert(validationInfo.extraFields, { index = i, value = value })
                    if self.debug then
                        self:Debug("Extra arg: fn='%s', pos=%d, value=%s", functionName, i, tostring(value))
                    end
                end
            end  -- Close else block for fieldName == nil (extra args)
            end  -- Close else block for value ~= nil
        end  -- Close for loop

        -- Check for missing required fields
        for i, fieldName in ipairs(fieldOrder) do
            local fieldInfo = fields[fieldName]
            if fieldInfo and fieldInfo.label == "required" and not args[i] then
                tinsert(validationInfo.missingRequired, fieldName)
                if self.debug then
                    self:Debug("Missing required: fn='%s', field='%s', pos=%d", functionName, fieldName, i)
                end
            end
        end
    else
        -- Handle non-array arguments (single values)
        if #fieldOrder > 0 then
            local fieldName = fieldOrder[1]
            local fieldInfo = fields[fieldName]
            if fieldInfo then
                local fieldValid, fieldError = self:ValidateFieldValue(fieldName, args, fieldInfo)
                validationInfo.fieldValidations[fieldName] = {
                    valid = fieldValid,
                    error = fieldError,
                    fieldInfo = fieldInfo,
                    positionalIndex = 1
                }

                if not fieldValid then
                    tinsert(validationInfo.invalidFields, { name = fieldName, error = fieldError, index = 1 })
                end

                -- Check if required field is missing
                if fieldInfo.label == "required" and not args then
                    tinsert(validationInfo.missingRequired, fieldName)
                end
            end
        end
    end

    -- Determine overall validity
    local hasErrors = #validationInfo.missingRequired > 0 or #validationInfo.invalidFields > 0 or
        #validationInfo.extraFields > 0

    if hasErrors then
        local errorMessages = {}

        if #validationInfo.missingRequired > 0 then
            local missingFieldMessages = {}
            for _, missingField in ipairs(validationInfo.missingRequired) do
                -- Find the position for this field
                local position = nil
                for i, fieldName in ipairs(validationInfo.expectedFields) do
                    if fieldName == missingField then
                        position = i
                        break
                    end
                end
                local positionInfo = position and format(" (position %d)", position) or ""
                tinsert(missingFieldMessages, format("%s%s", missingField, positionInfo))
            end
            tinsert(errorMessages, format("Missing required fields: %s", concat(missingFieldMessages, ", ")))
        end

        if #validationInfo.invalidFields > 0 then
            local invalidFieldMessages = {}
            for _, invalidField in ipairs(validationInfo.invalidFields) do
                local indexInfo = invalidField.index and format(" (position %d)", invalidField.index) or ""
                tinsert(invalidFieldMessages, format("%s%s: %s", invalidField.name, indexInfo, invalidField.error))
            end
            tinsert(errorMessages, format("Invalid fields: %s", concat(invalidFieldMessages, "; ")))
        end

        if #validationInfo.extraFields > 0 then
            local extraFieldMessages = {}
            for _, extraField in ipairs(validationInfo.extraFields) do
                if extraField.index then
                    tinsert(extraFieldMessages, format("position %d: %s", extraField.index, tostring(extraField.value)))
                else
                    tinsert(extraFieldMessages, tostring(extraField))
                end
            end
            tinsert(errorMessages, format("Extra fields: %s", concat(extraFieldMessages, ", ")))
        end

        return false, table.concat(errorMessages, ". "), validationInfo
    end

    return true, nil, validationInfo
end

--- Check if a value can be normalized to match a field's expected type
--- @param value any The value to check
--- @param fieldInfo table The field schema information
--- @return boolean True if value can be normalized to field type
--- @return any|nil The normalized value if successful, nil otherwise
function SchemaValidator:CanNormalizeToFieldType(value, fieldInfo)
    local FieldFormatConverter = ns.FieldFormatConverter

    -- Debug: Check if fieldInfo is missing message_type when it should have it
    if fieldInfo and fieldInfo.type == "message" and not fieldInfo.message_type then
        local fieldInfoKeys = {}
        for k, v in pairs(fieldInfo) do
            if k ~= "_metadata" then
                table.insert(fieldInfoKeys, string.format("%s=%s", k, tostring(v)))
            end
        end
        self:Warn("CanNormalizeToFieldType: fieldType='message' but message_type is nil! fieldInfo keys: %s, value type=%s, value=%s",
            table.concat(fieldInfoKeys, ", "), type(value), tostring(value))
    end

    if fieldInfo.type == "message" and fieldInfo.message_type then
        -- Use schema-aware ToProto() for message types
        local normalized = FieldFormatConverter:ToProto(value, fieldInfo)
        return normalized ~= nil, normalized
    elseif fieldInfo.type == "int32" or fieldInfo.type == "int64" or fieldInfo.type == "double" then
        return type(value) == "number", value
    elseif fieldInfo.type == "string" then
        return type(value) == "string", value
    elseif fieldInfo.type == "bool" then
        return type(value) == "boolean", value
    elseif fieldInfo.type == "enum" then
        if self.debug then NAG:Debug("[SchemaValidator] Normalizing enum value using schema-aware NormalizeEnumValue() in CanNormalizeToFieldType() for enumType='%s'", tostring(fieldInfo.enum_type)) end
        local normalized = FieldFormatConverter:NormalizeEnumValue(value, fieldInfo.enum_type)
        return normalized ~= nil, normalized
    end

    return false, nil
end

--- Validate a single field value against its schema definition
--- @param fieldName string The name of the field
--- @param fieldValue any The value to validate
--- @param fieldInfo table The field schema information
--- @return boolean valid Whether the field value is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateFieldValue(fieldName, fieldValue, fieldInfo)
    local fieldType = fieldInfo.type
    local fieldLabel = fieldInfo.label

    -- Handle nil values for optional fields
    if fieldValue == nil then
        if fieldLabel == "required" then
            return false, "Required field cannot be nil"
        end
        return true, nil -- Optional field can be nil
    end

    -- Validate based on field type
    if fieldType == "int32" or fieldType == "int64" then
        return self:ValidateIntegerField(fieldName, fieldValue, fieldInfo)
    elseif fieldType == "float" or fieldType == "double" then
        return self:ValidateFloatField(fieldName, fieldValue, fieldInfo)
    elseif fieldType == "bool" then
        return self:ValidateBoolField(fieldName, fieldValue, fieldInfo)
    elseif fieldType == "string" then
        return self:ValidateStringField(fieldName, fieldValue, fieldInfo)
    elseif fieldType == "enum" then
        return self:ValidateEnumField(fieldName, fieldValue, fieldInfo)
    elseif fieldType == "message" then
        return self:ValidateMessageField(fieldName, fieldValue, fieldInfo)
    else
        -- Unknown type - allow it for now
        if self.debug then
            self:Debug("Unknown field type '%s' for field '%s', allowing value", fieldType, fieldName)
        end
        return true, nil
    end
end

--- Validate integer field values
--- @param fieldName string The name of the field
--- @param fieldValue any The value to validate
--- @param fieldInfo table The field schema information
--- @return boolean valid Whether the field value is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateIntegerField(fieldName, fieldValue, fieldInfo)
    local numValue = tonumber(fieldValue)
    if not numValue then
        return false, format("Field '%s' must be a number, got %s", fieldName, type(fieldValue))
    end

    -- Check if it's actually an integer
    if floor(numValue) ~= numValue then
        return false, format("Field '%s' must be an integer, got %f", fieldName, numValue)
    end

    return true, nil
end

--- Validate float field values
--- @param fieldName string The name of the field
--- @param fieldValue any The value to validate
--- @param fieldInfo table The field schema information
--- @return boolean valid Whether the field value is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateFloatField(fieldName, fieldValue, fieldInfo)
    local numValue = tonumber(fieldValue)
    if not numValue then
        return false, format("Field '%s' must be a number, got %s", fieldName, type(fieldValue))
    end

    return true, nil
end

--- Validate boolean field values
--- @param fieldName string The name of the field
--- @param fieldValue any The value to validate
--- @param fieldInfo table The field schema information
--- @return boolean valid Whether the field value is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateBoolField(fieldName, fieldValue, fieldInfo)
    if type(fieldValue) == "boolean" then
        return true, nil
    end

    -- Allow string representations
    if type(fieldValue) == "string" then
        local lowerValue = strlower(fieldValue)
        if lowerValue == "true" or lowerValue == "false" then
            return true, nil
        end
    end

    return false, format("Field '%s' must be a boolean, got %s", fieldName, type(fieldValue))
end

--- Validate string field values
--- @param fieldName string The name of the field
--- @param fieldValue any The value to validate
--- @param fieldInfo table The field schema information
--- @return boolean valid Whether the field value is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateStringField(fieldName, fieldValue, fieldInfo)
    if type(fieldValue) == "string" then
        return true, nil
    end

    return false, format("Field '%s' must be a string, got %s", fieldName, type(fieldValue))
end

--- Validate enum field values
--- @param fieldName string The name of the field
--- @param fieldValue any The value to validate
--- @param fieldInfo table The field schema information
--- @return boolean valid Whether the field value is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateEnumField(fieldName, fieldValue, fieldInfo)
    local enumType = fieldInfo.enum_type
    if not enumType then
        return false, format("Field '%s' has enum type but no enum_type specified", fieldName)
    end

    -- Normalize primitive values to enum values
    local normalizedValue = fieldValue
    if type(fieldValue) ~= "number" and type(fieldValue) ~= "string" then
        -- Try to extract value from table structures
        if type(fieldValue) == "table" and fieldValue.value ~= nil then
            normalizedValue = fieldValue.value
        end
    end

    -- Map enum type names (schema uses singular, Types uses plural)
    -- This matches the mapping used in FieldFormatConverter
    local enumTypeMapped = enumType
    if enumType == "SpellPosition" then
        enumTypeMapped = "SpellPositions"
    end

    -- Check for enum normalization metadata (similar to message type normalization)
    local schemaData = SchemaAccessor:GetSchemaData()
    local enumData = schemaData and schemaData.enums and schemaData.enums[enumType]
    -- Try mapped enum name if original not found
    if not enumData and enumTypeMapped ~= enumType then
        enumData = schemaData and schemaData.enums and schemaData.enums[enumTypeMapped]
    end
    local FieldFormatConverter = ns.FieldFormatConverter

    if FieldFormatConverter then
        -- Use FieldFormatConverter for enum normalization
        if self.debug then NAG:Debug("[SchemaValidator] Normalizing enum value using schema-aware NormalizeEnumValue() in ValidateEnumField() for enumType='%s'", tostring(enumType)) end
        local enumValue = FieldFormatConverter:NormalizeEnumValue(normalizedValue, enumType)
        if enumValue ~= nil then
            normalizedValue = enumValue
        end
    end

    -- Get enum values from schema (enumData may have normalization metadata mixed in)
    if not enumData then
        -- Use GetEnumValues() instead of GetMessageSchema() for enums
        local enumValues = SchemaAccessor:GetEnumValues(enumTypeMapped)
        if enumValues then
            enumData = enumValues
        else
            -- Fallback: Check Types registry for addon-defined enums (like SpellPositions)
            local Types = NAG:GetModule("Types")
            if Types then
                local typeData = Types:GetType(enumTypeMapped)
                if typeData and typeData._values then
                    enumData = typeData._values
                    if self.debug then
                        self:Debug("Using Types registry for enum type '%s' (mapped: '%s') for field '%s'", enumType, enumTypeMapped, fieldName)
                    end
                else
                    if self.debug then
                        self:Debug("Enum type '%s' (mapped: '%s') not found in schema or Types registry for field '%s'", enumType, enumTypeMapped, fieldName)
                    end
                    return true, nil -- Allow unknown enum types for now
                end
            else
                if self.debug then
                    self:Debug("Enum type '%s' (mapped: '%s') not found in schema for field '%s'", enumType, enumTypeMapped, fieldName)
                end
                return true, nil -- Allow unknown enum types for now
            end
        end
    end

    -- Extract actual enum values
    local enumValues = {}
    for key, value in pairs(enumData) do
        enumValues[key] = value
    end

    -- Special handling for StatType enum: accept -1 as valid value (used for "any stat" or invalid stat)
    if enumType and (enumType == "Stat" or enumType:find("^Stat")) then
        if type(normalizedValue) == "number" and normalizedValue == -1 then
            return true, nil
        end
    end

    -- Check if normalized value is valid
    if type(normalizedValue) == "number" then
        -- Check numeric enum value
        for _, enumValue in pairs(enumValues) do
            if enumValue == normalizedValue then
                return true, nil
            end
        end
    elseif type(normalizedValue) == "string" then
        -- Check string enum value - compare against enum VALUES (not keys)
        -- For string enums like SpellPositions: keys are LEFT/RIGHT/etc, values are "left"/"right"/etc
        for enumName, enumValue in pairs(enumValues) do
            -- Check if normalized value matches the enum value (e.g., "above" matches "above")
            if enumValue == normalizedValue then
                return true, nil
            end
            -- Also check case-insensitive match for enum value
            if type(enumValue) == "string" and enumValue:lower() == normalizedValue:lower() then
                return true, nil
            end
            -- Also allow matching by enum key name (case-insensitive) for convenience
            if type(enumName) == "string" and enumName:lower() == normalizedValue:lower() then
                return true, nil
            end
        end
    end

    return false,
        format("Field '%s' value '%s' is not a valid enum value for type '%s'", fieldName, tostring(normalizedValue), enumType)
end

--- Validate message field values
--- @param fieldName string The name of the field
--- @param fieldValue any The value to validate
--- @param fieldInfo table The field schema information
--- @return boolean valid Whether the field value is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateMessageField(fieldName, fieldValue, fieldInfo)
    local messageType = fieldInfo.message_type
    if not messageType then
        return false, format("Field '%s' has message type but no message_type specified", fieldName)
    end

    -- CRITICAL: Handle repeated fields - iterate over array and validate each element
    if fieldInfo.label == "repeated" then
        if type(fieldValue) ~= "table" then
            return false, format("Field '%s' must be a table for repeated message type '%s', got %s", fieldName, messageType, type(fieldValue))
        end

        -- Validate each element in the array as a message
        if self.debug then
            self:Debug("ValidateMessageField: Repeated field '%s' with %d elements (type='%s')", fieldName, #fieldValue, messageType)
        end

        for i, elementValue in ipairs(fieldValue) do
            if self.debug then
                local elementType = type(elementValue)
                local elementKeys = {}
                if elementType == "table" then
                    for k in pairs(elementValue) do
                        table.insert(elementKeys, tostring(k))
                    end
                end
                self:Debug("ValidateMessageField: Validating repeated field '%s' element[%d]: type=%s, keys=[%s]",
                    fieldName, i, elementType, table.concat(elementKeys, ", "))
            end

            -- Recursively validate each element as a message (handle normalization first)
            local normalizedValue = elementValue
            local FieldFormatConverter = ns.FieldFormatConverter
            if FieldFormatConverter and type(elementValue) ~= "table" then
                -- Use schema-aware ToProto() for message type normalization
                -- fieldInfo is available from function parameter, so use ToProto() directly
                normalizedValue = FieldFormatConverter:ToProto(elementValue, fieldInfo)

                if normalizedValue == nil then
                    self:Warn("ValidateMessageField: Normalization failed for repeated field '%s' element[%d] (messageType='%s', value=%s)",
                        fieldName, i, messageType or "nil", tostring(elementValue))
                    return false,
                        format("Field '%s' element[%d] normalization failed for message type '%s' (value: %s)",
                            fieldName, i, messageType, tostring(elementValue))
                end
            end

            if type(normalizedValue) ~= "table" then
                return false,
                    format("Field '%s' element[%d] must be a table for message type '%s', got %s",
                        fieldName, i, messageType, type(normalizedValue))
            end

            local valid, error = self:ValidateMessageStructure(messageType, normalizedValue)
            if not valid then
                return false, format("Field '%s' element[%d] message validation failed: %s", fieldName, i, error)
            end
        end

        return true, nil
    end

    -- Handle single message field (non-repeated)
    -- Auto-normalize primitive values for ActionID and UnitReference
    if type(fieldValue) ~= "table" then
        local FieldFormatConverter = ns.FieldFormatConverter
        if FieldFormatConverter then
            local originalValue = fieldValue
            -- Use schema-aware ToProto() for message type normalization
            -- fieldInfo is available from function parameter, so use ToProto() directly
            fieldValue = FieldFormatConverter:ToProto(fieldValue, fieldInfo)

            -- If normalization failed (returned nil), report error
            if fieldValue == nil then
                self:Warn("ValidateMessageField: Normalization failed for field '%s' (messageType='%s', originalValue=%s, fieldInfo.type=%s, fieldInfo.message_type=%s)",
                    fieldName, messageType or "nil", tostring(originalValue), tostring(fieldInfo.type), tostring(fieldInfo.message_type))
                -- Special case: NAG.SPELL_POSITIONS.* strings should not convert to UnitReference
                -- This is handled by ConvertUnitReference returning nil for position strings
                return false,
                    format("Field '%s' normalization failed for message type '%s' (value: %s)",
                        fieldName, messageType, tostring(originalValue))
            end
        end
    end

    if type(fieldValue) ~= "table" then
        return false,
            format("Field '%s' must be a table for message type '%s', got %s", fieldName, messageType, type(fieldValue))
    end

    -- Validate nested message structure (not as positional arguments, but as a structured table)
    if self.debug then
        local valueKeys = type(fieldValue) == "table" and table.concat(TableUtils.Keys(fieldValue), ",") or "none"
        self:Debug("ValidateMessageField: type='%s', field='%s', value(type=%s,keys=[%s])",
            messageType, fieldName, type(fieldValue), valueKeys)
    end
    local valid, error = self:ValidateMessageStructure(messageType, fieldValue)
    if not valid then
        return false, format("Field '%s' message validation failed: %s", fieldName, error)
    end

    return true, nil
end

--- Validate a message structure (for nested messages like ActionID, UnitReference)
--- This validates a structured table against a message schema by field names
--- @param messageType string The message type to validate against
--- @param messageData table The structured table data (field names as keys)
--- @return boolean valid Whether the message structure is valid
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateMessageStructure(messageType, messageData)
    if not messageType or type(messageType) ~= "string" then
        return false, "Invalid message type"
    end

    if type(messageData) ~= "table" then
        return false, format("Message data must be a table, got %s", type(messageData))
    end

    local messageInfo = SchemaAccessor:GetMessageSchema(messageType)
    if not messageInfo then
        if self.debug then
            self:Debug("Message type not found: type='%s'", messageType)
        end
        return false, format("Message type '%s' not found in schema", messageType)
    end

    if not messageInfo.fields then
        self:Warn("ValidateMessageStructure: Message type '%s' has no fields table", messageType)
    end
    if not messageInfo.field_order then
        self:Warn("ValidateMessageStructure: Message type '%s' has no field_order table", messageType)
    end

    if self.debug then
        local dataKeys = table.concat(TableUtils.Keys(messageData), ",")
        local schemaFields = messageInfo.fields and table.concat(TableUtils.Keys(messageInfo.fields), ",") or "none"
        local fieldOrderStr = messageInfo.field_order and table.concat(messageInfo.field_order, ",") or "none"
        self:Debug("ValidateMessageStructure('%s'): dataKeys=[%s], schemaFields=[%s], fieldOrder=[%s]",
            messageType, dataKeys, schemaFields, fieldOrderStr)
    end

    local fields = messageInfo.fields
    local fieldOrder = messageInfo.field_order

    if not fields then fields = {} end
    if not fieldOrder then fieldOrder = {} end

    -- Validate each field in the message data
    for fieldName, fieldValue in pairs(messageData) do
        if self.debug then
            self:Debug("Field '%s'=%s(%s): type=%s, label=%s",
                fieldName, tostring(fieldValue), type(fieldValue),
                fields[fieldName] and fields[fieldName].type or "unknown",
                fields[fieldName] and (fields[fieldName].label or "none") or "none")
        end

        local fieldInfo = fields[fieldName]
        if not fieldInfo then
            if self.debug then
                self:Debug("Unknown field: type='%s', field='%s' (allowing)", messageType, fieldName)
            end
            -- Allow unknown fields (they might be metadata or optional extensions)
            -- return false, format("Unknown field '%s' in message type '%s'", fieldName, messageType)
        else
            -- Validate field type
            local fieldType = fieldInfo.type
            if fieldType == "message" then
                local nestedMessageType = fieldInfo.message_type
                -- Recursively validate nested message
                if nestedMessageType then
                    if type(fieldValue) == "table" then
                        if self.debug then
                            self:Debug("Nested msg: type='%s', field='%s', nestedType='%s'", messageType, fieldName, nestedMessageType)
                        end
                        local nestedValid, nestedError = self:ValidateMessageStructure(nestedMessageType, fieldValue)
                        if not nestedValid then
                            return false, format("Field '%s' nested message validation failed: %s", fieldName, nestedError)
                        end
                    else
                        return false, format("Field '%s' must be a table for message type '%s'", fieldName, nestedMessageType)
                    end
                end
            elseif fieldType == "enum" then
                if self.debug then
                    self:Debug("Enum field: type='%s', field='%s', enumType='%s'", messageType, fieldName, fieldInfo.enum_type or "none")
                end
                -- Validate enum value (basic check - value exists in enum)
                -- More detailed validation could be added here
            elseif fieldType == "int32" or fieldType == "int64" then
                if type(fieldValue) ~= "number" then
                    return false, format("Field '%s' must be a number, got %s", fieldName, type(fieldValue))
                end
                if self.debug then
                    self:Debug("Number validated: type='%s', field='%s', value=%s", messageType, fieldName, tostring(fieldValue))
                end
            elseif fieldType == "bool" then
                if type(fieldValue) ~= "boolean" then
                    return false, format("Field '%s' must be a boolean, got %s", fieldName, type(fieldValue))
                end
                if self.debug then
                    self:Debug("Bool validated: type='%s', field='%s', value=%s", messageType, fieldName, tostring(fieldValue))
                end
            elseif fieldType == "string" then
                if type(fieldValue) ~= "string" then
                    return false, format("Field '%s' must be a string, got %s", fieldName, type(fieldValue))
                end
                if self.debug then
                    self:Debug("String validated: type='%s', field='%s', value='%s'", messageType, fieldName, fieldValue)
                end
            else
                if self.debug then
                    self:Debug("Unhandled type: type='%s', field='%s', fieldType='%s'", messageType, fieldName, fieldType)
                end
            end
        end
    end

    -- Check required fields
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo and fieldInfo.label == "required" and messageData[fieldName] == nil then
            return false, format("Required field '%s' is missing in message type '%s'", fieldName, messageType)
        end
    end

    if self.debug then
        self:Debug("Message structure valid: type='%s'", messageType)
    end

    return true, nil
end

--- Validate a proto AST node by field names (for polymorphic argument handling)
--- This validates a structured table (field names as keys) against a message schema
--- @param protoName string The proto message type name (e.g., "APLActionCastSpell")
--- @param fieldData table The structured field data (field names as keys)
--- @return boolean valid Whether the field data is valid
--- @return string|nil error Error message if validation failed
--- @return table|nil validationInfo Additional validation information
function SchemaValidator:ValidateByFieldNames(protoName, fieldData)
    if not protoName or type(protoName) ~= "string" then
        return false, "Invalid proto name"
    end

    if type(fieldData) ~= "table" then
        return false, format("Field data must be a table, got %s", type(fieldData))
    end

    local messageInfo = SchemaAccessor:GetMessageSchema(protoName)
    if not messageInfo then
        if self.debug then
            self:Debug("ValidateByFieldNames: Message type '%s' not found in schema", protoName)
        end
        return false, format("Message type '%s' not found in schema", protoName)
    end

    local fields = messageInfo.fields or {}
    local fieldOrder = messageInfo.field_order or {}

    if self.debug then
        local dataKeys = table.concat(TableUtils.Keys(fieldData), ",")
        local schemaFields = table.concat(TableUtils.Keys(fields), ",")
        local fieldOrderStr = table.concat(fieldOrder, ",")
        self:Debug("ValidateByFieldNames('%s'): dataKeys=[%s], schemaFields=[%s], fieldOrder=[%s]",
            protoName, dataKeys, schemaFields, fieldOrderStr)
    end

    local validationInfo = {
        functionName = protoName,
        expectedFields = fieldOrder,
        providedFields = TableUtils.Keys(fieldData),
        fieldValidations = {},
        missingRequired = {},
        invalidFields = {},
        extraFields = {}
    }

    -- Validate each field in fieldData by name
    for fieldName, fieldValue in pairs(fieldData) do
        -- Skip metadata fields
        if fieldName == "field_order" or fieldName == "_metadata" then
            -- Allow metadata fields
        else
            local fieldInfo = fields[fieldName]
            if fieldInfo then
                -- Validate this field
                local fieldValid, fieldError = self:ValidateFieldValue(fieldName, fieldValue, fieldInfo)
                validationInfo.fieldValidations[fieldName] = {
                    valid = fieldValid,
                    error = fieldError,
                    fieldInfo = fieldInfo
                }

                if not fieldValid then
                    -- Validation failure - log as Warn
                    self:Warn("ValidateByFieldNames: Field '%s' validation failed in '%s': %s", fieldName, protoName, fieldError or "unknown error")
                    tinsert(validationInfo.invalidFields, {
                        name = fieldName,
                        error = fieldError
                    })
                end
            else
                -- Unknown field - report as extra field
                tinsert(validationInfo.extraFields, {
                    name = fieldName,
                    value = fieldValue
                })
                if self.debug then
                    self:Debug("ValidateByFieldNames: Unknown field '%s' in '%s'", fieldName, protoName)
                end
            end
        end
    end

    -- Check for missing required fields
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo and fieldInfo.label == "required" then
            -- Check if field is missing (nil or not present)
            if fieldData[fieldName] == nil then
                -- Missing required field - log as Warn
                self:Warn("ValidateByFieldNames: Missing required field '%s' in '%s'", fieldName, protoName)
                tinsert(validationInfo.missingRequired, fieldName)
            end
        end
    end

    -- Determine overall validity
    local hasErrors = #validationInfo.missingRequired > 0 or #validationInfo.invalidFields > 0 or
        #validationInfo.extraFields > 0

    if hasErrors then
        local errorMessages = {}

        if #validationInfo.missingRequired > 0 then
            local missingFieldMessages = {}
            for _, missingField in ipairs(validationInfo.missingRequired) do
                tinsert(missingFieldMessages, missingField)
            end
            tinsert(errorMessages, format("Missing required fields: %s", concat(missingFieldMessages, ", ")))
        end

        if #validationInfo.invalidFields > 0 then
            local invalidFieldMessages = {}
            for _, invalidField in ipairs(validationInfo.invalidFields) do
                tinsert(invalidFieldMessages, format("%s: %s", invalidField.name, invalidField.error))
            end
            tinsert(errorMessages, format("Invalid fields: %s", concat(invalidFieldMessages, "; ")))
        end

        if #validationInfo.extraFields > 0 then
            local extraFieldMessages = {}
            for _, extraField in ipairs(validationInfo.extraFields) do
                tinsert(extraFieldMessages, format("%s", extraField.name))
            end
            tinsert(errorMessages, format("Unknown fields: %s", concat(extraFieldMessages, ", ")))
        end

        return false, table.concat(errorMessages, ". "), validationInfo
    end

    return true, nil, validationInfo
end

-- ~~~~~~~~~~ APL STRING VALIDATION ~~~~~~~~~~

--- Validates that all NAG function calls in a rotation string exist
--- This is a wrapper around ValidateAPLString() for backward compatibility
--- @param rotationString string The rotation string to validate
--- @param forceValidation boolean|string Optional: force validation flag OR rotation name (for backward compatibility)
--- @param rotationName string|nil Optional rotation name for context in error messages
--- @return boolean valid Whether all NAG functions exist
--- @return string|nil error Error message if validation failed
function SchemaValidator:ValidateNAGFunctionsExist(rotationString, forceValidation, rotationName)
    -- Handle backward compatibility: second param might be rotationName (string) or forceValidation (boolean)
    local actualForceValidation = false
    local actualRotationName = rotationName

    if type(forceValidation) == "string" then
        -- Second param is rotation name, not forceValidation
        actualRotationName = forceValidation
        actualForceValidation = false
    elseif type(forceValidation) == "boolean" then
        actualForceValidation = forceValidation
    end

    -- Check if validation is disabled (unless forced)
    if not actualForceValidation and self:IsValidationDisabled() then
        if self.debug then
            self:Debug("APL validation is disabled, skipping ValidateNAGFunctionsExist")
        end
        return true, nil
    end

    -- Use ValidateAPLString for the actual validation
    local valid, error = self:ValidateAPLString(rotationString, actualRotationName)
    return valid, error
end

--- Validate NAG function calls in an APL rotation string using schema
--- @param rotationString string The rotation string to validate
--- @param rotationName string|nil Optional rotation name for context in error messages
--- @return boolean valid Whether all NAG functions are valid
--- @return string|nil error Error message if validation failed
--- @return table|nil validationResults Detailed validation results
function SchemaValidator:ValidateAPLString(rotationString, rotationName)
    self:Info("ValidateAPLString: Validating rotation string (rotationName='%s', length=%d)",
        rotationName or "unknown", rotationString and #rotationString or 0)

    if not self.initialized then
        self:Warn("ValidateAPLString: SchemaValidator not initialized, cannot validate rotation (rotationName='%s')",
            rotationName or "unknown")
        return false, "SchemaValidator not initialized"
    end

    if not rotationString or type(rotationString) ~= "string" then
        self:Warn("ValidateAPLString: Invalid rotation string provided (type=%s, rotationName='%s')",
            type(rotationString), rotationName or "unknown")
        return false, "Invalid rotation string"
    end

    -- Store rotation name for context in validation warnings
    self._currentRotationName = rotationName

    -- Extract and pre-register spell IDs before validation (DataManager owns this so TBC can use it without loading SchemaValidator)
    if DataManager and DataManager.RegisterSpellIDsFromRotationString then
        DataManager:RegisterSpellIDsFromRotationString(rotationString)
    end

    -- Find all NAG: function calls
    local nagCalls = self:ExtractNAGFunctionCalls(rotationString)
    if #nagCalls == 0 then
        self:Info("ValidateAPLString: No NAG function calls found in rotation (rotationName='%s')",
            rotationName or "unknown")
        self._currentRotationName = nil
        return true, nil, { message = "No NAG function calls found" }
    end

    self:Info("ValidateAPLString: Found %d NAG function calls to validate (rotationName='%s')",
        #nagCalls, rotationName or "unknown")

    local validationResults = {
        totalCalls = #nagCalls,
        validCalls = 0,
        invalidCalls = 0,
        callResults = {},
        errors = {}
    }

    -- Validate each function call
    for callIndex, call in ipairs(nagCalls) do
        local valid, error, validationInfo = self:ValidateFunctionCall(call.name, call.args, callIndex)

        local callResult = {
            functionName = call.name,
            args = call.args,
            valid = valid,
            error = error,
            validationInfo = validationInfo
        }

        tinsert(validationResults.callResults, callResult)

        if valid then
            validationResults.validCalls = validationResults.validCalls + 1
        else
            validationResults.invalidCalls = validationResults.invalidCalls + 1
            tinsert(validationResults.errors, format("NAG:%s(%s): %s", call.name, call.argsString, error))
        end
    end

    -- Determine overall validity
    local isValid = validationResults.invalidCalls == 0
    local errorMessage = nil

    if not isValid then
        self:Warn("ValidateAPLString: Validation completed with %d invalid calls out of %d total (rotationName='%s')",
            validationResults.invalidCalls, validationResults.totalCalls, rotationName or "unknown")
        errorMessage = table.concat(validationResults.errors, "\n")
    else
        self:Info("ValidateAPLString: Successfully validated all %d function calls (rotationName='%s')",
            validationResults.totalCalls, rotationName or "unknown")
    end

    -- Clear rotation context
    self._currentRotationName = nil

    return isValid, errorMessage, validationResults
end

--- Extract NAG function calls from a rotation string
--- @param rotationString string The rotation string to parse
--- @return table Array of function call objects
function SchemaValidator:ExtractNAGFunctionCalls(rotationString)
    local calls = {}

    -- Find all NAG: function calls; capture is name + parens e.g. "Cast(33357, nil, ...)"
    for fullCall in rotationString:gmatch("NAG:([%w_.]+%s*%b())") do
        local funcName = fullCall:match("([%w_.]+)%b()")
        local argsString = fullCall:match("%b()")
        argsString = argsString:sub(2, -2) -- Remove parentheses

        -- Parse arguments with better handling of nested structures
        local args = self:ParseFunctionArguments(argsString)

        tinsert(calls, {
            name = funcName,
            argsString = argsString or "",
            args = args
        })
    end

    return calls
end

--- Parse function arguments with better handling of nested structures
--- @param argsString string The arguments string to parse
--- @return table Parsed arguments
function SchemaValidator:ParseFunctionArguments(argsString)
    if not argsString or argsString == "" then
        return {}
    end

    local args = {}
    local maxIndex = 0  -- Track actual maximum index (to handle nil values)
    local currentArg = ""
    local parenDepth = 0
    local braceDepth = 0  -- Track curly braces for tables
    local inQuotes = false
    local quoteChar = nil

    for i = 1, #argsString do
        local char = argsString:sub(i, i)

        -- Handle quotes
        if char == '"' or char == "'" then
            if not inQuotes then
                inQuotes = true
                quoteChar = char
            elseif char == quoteChar then
                inQuotes = false
                quoteChar = nil
            end
        end

        -- Handle parentheses and braces (only count when not in quotes)
        if not inQuotes then
            if char == '(' then
                parenDepth = parenDepth + 1
            elseif char == ')' then
                parenDepth = parenDepth - 1
            elseif char == '{' then
                braceDepth = braceDepth + 1
            elseif char == '}' then
                braceDepth = braceDepth - 1
            end
        end

        -- Split on commas only at top level (no nested parens or braces) and when not in quotes
        if char == ',' and parenDepth == 0 and braceDepth == 0 and not inQuotes then
            local trimmedArg = currentArg:match("^%s*(.-)%s*$")
            if trimmedArg and trimmedArg ~= "" then
                maxIndex = maxIndex + 1
                -- Convert literal string "nil" to actual nil (case-insensitive)
                if trimmedArg:lower() == "nil" then
                    args[maxIndex] = nil
                else
                    args[maxIndex] = trimmedArg
                end
            elseif trimmedArg == "" then
                -- Empty argument between commas means nil (e.g., "func(arg1,,arg3)")
                maxIndex = maxIndex + 1
                args[maxIndex] = nil
            end
            currentArg = ""
        else
            currentArg = currentArg .. char
        end
    end

    -- Add the last argument
    local trimmedArg = currentArg:match("^%s*(.-)%s*$")
    if trimmedArg and trimmedArg ~= "" then
        maxIndex = maxIndex + 1
        -- Convert literal string "nil" to actual nil (case-insensitive)
        if trimmedArg:lower() == "nil" then
            args[maxIndex] = nil
        else
            args[maxIndex] = trimmedArg
        end
    elseif trimmedArg == "" then
        -- Empty last argument means nil
        maxIndex = maxIndex + 1
        args[maxIndex] = nil
    end

    -- Set maxIndex metadata so ValidateArguments knows the actual length
    args._maxIndex = maxIndex
    return args
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~

--- Get validation statistics
--- @return table Validation statistics
function SchemaValidator:GetValidationStats()
    if not self.initialized then
        return { initialized = false }
    end

    local schemaData = SchemaAccessor:GetSchemaData()
    return {
        initialized = self.initialized,
        schemaData = schemaData ~= nil,
        schemaMessages = schemaData and TableUtils.Size(schemaData.messages or {}) or 0,
        nagFunctionMappings = TableUtils.Size(SchemaAccessor.nagFunctionMappings)
    }
end

--- Check if a function exists in the schema
--- @param functionName string The name of the function to check
--- @return boolean exists Whether the function exists
function SchemaValidator:FunctionExists(functionName)
    local schemaData = SchemaAccessor:GetSchemaData()
    if not self.initialized or not schemaData then
        return false
    end

    -- Use schema structure check instead of O(n) alias iteration
    local protoName = SchemaAccessor:GetProtoNameFromNagName(functionName)
    if protoName and SchemaAccessor:GetMessageSchema(protoName) then
        if self.debug then
            self:Debug("FunctionExists('%s'): Found via schema structure check '%s'", functionName, protoName)
        end
        return true
    end

    return false
end

--- Get the schema definition for a function
--- @param functionName string The name of the function
--- @return table|nil schema The function schema or nil if not found
function SchemaValidator:GetFunctionSchema(functionName)
    local schemaData = SchemaAccessor:GetSchemaData()
    if not self.initialized or not schemaData then
        return nil
    end

    -- Use schema structure check instead of O(n) alias iteration
    local protoName = SchemaAccessor:GetProtoNameFromNagName(functionName)
    if protoName then
        return SchemaAccessor:GetMessageSchema(protoName)
    end

    return nil
end

--- Get all available function names (including aliases)
--- @return table Array of function names
function SchemaValidator:GetAvailableFunctions()
    local schemaData = SchemaAccessor:GetSchemaData()
    if not self.initialized or not schemaData then
        return {}
    end

    local functions = {}
    local seenFunctions = {}

    -- Add direct schema functions
    if schemaData.messages then
        for funcName, _ in pairs(schemaData.messages) do
            tinsert(functions, funcName)
            seenFunctions[funcName] = true
        end
    end

    -- Add NAG function names from aliases
    for protoName, nagName in pairs(SchemaAccessor:GetAllProtoToNagMappings()) do
        if not seenFunctions[nagName] then
            tinsert(functions, nagName)
            seenFunctions[nagName] = true
        end
    end

    sort(functions)
    return functions
end

--- Get all available aliases
--- @return table Array of alias mappings
function SchemaValidator:GetAvailableAliases()
    if not self.initialized then
        return {}
    end

    local aliases = {}
    for protoName, nagName in pairs(SchemaAccessor:GetAllProtoToNagMappings()) do
        tinsert(aliases, {
            protoName = protoName,
            nagName = nagName
        })
    end

    -- Sort by NAG name for consistency
    sort(aliases, function(a, b) return a.nagName < b.nagName end)
    return aliases
end

--- Force initialization if SchemaAccessor becomes available
--- @return boolean success Whether initialization succeeded
function SchemaValidator:ForceInitialization()
    if self.initialized then
        return true
    end

    -- Note: InitializeSchemaData removed - initialization handled by OnSchemaModificationsComplete
    self:InitializeValidationSystem()
    self.initialized = true
    if self.debug then
        self:Debug("SchemaValidator force-initialized successfully")
    end
    return true
end

--- Check if SchemaValidator can be initialized now
--- @return boolean canInitialize Whether initialization is possible
function SchemaValidator:CanInitialize()
    return SchemaAccessor ~= nil
end

-- ~~~~~~~~~~ VALIDATION CONTROL ~~~~~~~~~~

--- Check if APL validation is disabled via debug setting or for expansions without schema support
--- @return boolean True if validation is disabled
function SchemaValidator:IsValidationDisabled()
    -- TBC and Wrath don't have full APL schema support - skip validation
    local Version = ns.Version
    if Version and (Version:IsTBC() or Version:IsWrath()) then
        return true
    end
    return self.db.char.disableValidation or false
end

-- ~~~~~~~~~~ ARGUMENT TYPE DETECTION (UI RENDERING) ~~~~~~~~~~

--- Check if a specific argument for a function is an ID type (spell/item)
--- Uses proto schema as the source of truth via message_type = "ActionID"
--- This is used by tree rendering to determine if icon/name lookups should be performed
--- @param functionName string The function name (can be an alias via nagFunctionMappings)
--- @param argumentIndex number The 1-based argument index
--- @return boolean True if the argument is an ID type
function SchemaValidator:IsArgumentIDType(functionName, argumentIndex)
    if not functionName then
        return false
    end

    if not self.initialized then
        if self.debug then
            self:Debug("IsArgumentIDType: SchemaValidator not initialized, cannot determine ID type for '%s' argument %d", functionName, argumentIndex)
        end
        -- Fallback to functionArgs table if available
        return self:IsArgumentIDTypeFromFallback(functionName, argumentIndex)
    end

    -- Try schema-based check first (authoritative)
    local isIDType = self:IsArgumentIDTypeFromSchema(functionName, argumentIndex)
    if isIDType ~= nil then
        return isIDType
    end

    -- Schema lookup failed - warn before falling back
    if self.debug then
        self:Debug("IsArgumentIDType: Schema lookup failed for '%s' argument %d, falling back to functionArgs", functionName, argumentIndex)
    end

    -- Fallback to manual functionArgs table if schema check fails
    return self:IsArgumentIDTypeFromFallback(functionName, argumentIndex)
end

--- Check argument type using proto schema (primary method)
--- @param functionName string The function name
--- @param argumentIndex number The 1-based argument index
--- @return boolean|nil True if ID type, false if not, nil if cannot determine
function SchemaValidator:IsArgumentIDTypeFromSchema(functionName, argumentIndex)
    if not SchemaAccessor then
        return nil
    end

    -- Try to find the proto message type for this function
    -- GetProtoNameFromNagName already handles nagFunctionMappings (aliases)
    local protoName = SchemaAccessor:GetProtoNameFromNagName(functionName)

    if not protoName then
        return nil -- Cannot find proto message type
    end

    -- Get the message definition using getter
    local message = SchemaAccessor:GetMessageSchema(protoName)
    if not message or not message.fields or not message.field_order then
        return nil
    end

    -- Check if argument index is valid
    if argumentIndex < 1 or argumentIndex > #message.field_order then
        return false -- Out of bounds
    end

    -- Get the field name at this position
    local fieldName = message.field_order[argumentIndex]
    local fieldInfo = message.fields[fieldName]

    if not fieldInfo then
        return false
    end

    -- Check if this field has message_type = "ActionID"
    return fieldInfo.message_type == "ActionID"
end

--- Check argument type using fallback functionArgs table (fallback method)
--- @param functionName string The function name
--- @param argumentIndex number The 1-based argument index
--- @return boolean True if the argument is an ID type
function SchemaValidator:IsArgumentIDTypeFromFallback(functionName, argumentIndex)
    -- Check if fallback data is available
    local fallbackData = ns.APLValidatorFallback
    if not fallbackData or not fallbackData.functionArgs then
        return false
    end

    local funcDef = fallbackData.functionArgs[functionName]
    if not funcDef then
        return false
    end

    local isIDType = false

    -- Check required arguments first
    if funcDef.required and argumentIndex <= #funcDef.required then
        local argType = funcDef.required[argumentIndex]
        -- Handle array format (for multiple allowed types)
        if type(argType) == "table" then
            for _, t in ipairs(argType) do
                if t == "id" or t == "primarySpellId" or t == "secondarySpellId" or t == "spellOrItemOrExpression" then
                    isIDType = true
                    break
                end
            end
        elseif argType == "id" or argType == "primarySpellId" or argType == "secondarySpellId" or argType == "spellOrItemOrExpression" then
            isIDType = true
        end
    end

    -- Check optional arguments
    if not isIDType then
        local optionalIndex = argumentIndex - (funcDef.required and #funcDef.required or 0)
        if funcDef.optional and optionalIndex > 0 and optionalIndex <= #funcDef.optional then
            local argType = funcDef.optional[optionalIndex]
            if type(argType) == "table" then
                for _, t in ipairs(argType) do
                    if t == "id" or t == "primarySpellId" or t == "secondarySpellId" or t == "spellOrItemOrExpression" then
                        isIDType = true
                        break
                    end
                end
            elseif argType == "id" or argType == "primarySpellId" or argType == "secondarySpellId" or argType == "spellOrItemOrExpression" then
                isIDType = true
            end
        end
    end

    return isIDType
end

-- ~~~~~~~~~~ OPTIONS COMPOSITION ~~~~~~~~~~

--- Compose debug options for SchemaValidator
--- @param options table The options table to compose
--- @param context table The context for options composition
--- @return table The modified options table
function SchemaValidator:debugOptions(options, context)
    if not options.args then
        return options
    end

    -- Add SchemaValidator debug options to debugTools section
    if options.args.debugTools and options.args.debugTools.args then
        -- Create a dedicated tree item for Schema Validator debugging
        options.args.debugTools.args.schemaValidatorDebug = {
            type = "group",
            name = "Schema Validator",
            desc = "Debug tools for schema-based APL validation system",
            order = 2,
            args = {
                disableValidation = {
                    type = "toggle",
                    name = "Disable APL Validation",
                    desc = "Completely disable APL validation for rotation strings. This bypasses all validation checks during save, import, export, and preload operations. The manual 'Validate' button in rotation editor will still work. Use with caution as invalid rotations may cause runtime errors.",
                    order = 1,
                    width = "full",
                    get = function()
                        return self:GetSetting("char", "disableValidation", false)
                    end,
                    set = function(_, value)
                        self:SetSetting("char", "disableValidation", value)
                        if value then
                            self:Warn("APL validation has been DISABLED. Invalid rotations may cause runtime errors. Manual validation via 'Validate' button still works.")
                        else
                            self:Info("APL validation has been ENABLED.")
                        end
                    end
                },
                validationStatus = {
                    type = "description",
                    name = function()
                        local disabled = self:GetSetting("char", "disableValidation", false)
                        local status = disabled and "DISABLED" or "ENABLED"
                        local color = disabled and "|cffff0000" or "|cff00ff00"
                        return color .. "Current Status: " .. status .. "|r"
                    end,
                    order = 2,
                    width = "full",
                    fontSize = "medium"
                },
                validationInfo = {
                    type = "description",
                    name = function()
                        local disabled = self:GetSetting("char", "disableValidation", false)
                        if disabled then
                            return "|cffff8000Warning: Validation is disabled for save/import/export. Manual 'Validate' button still works.|r"
                        else
                            return "|cff00ff00Validation is active. All rotation strings will be validated before use.|r"
                        end
                    end,
                    order = 3,
                    width = "full",
                    fontSize = "small"
                },
                showDebugInfo = {
                    type = "execute",
                    name = "Show Debug Info",
                    desc = "Print detailed SchemaValidator debug information",
                    func = function()
                        self:PrintDebugInfo()
                    end,
                    order = 4
                }
            }
        }
    end

    return options
end

-- ~~~~~~~~~~ DEBUG AND UTILITY ~~~~~~~~~~

--- Print debug information about the schema validator
function SchemaValidator:PrintDebugInfo()
    local stats = self:GetValidationStats()

    self:Print("=== SchemaValidator Debug Info ===")
    self:Print(format("Initialized: %s", tostring(stats.initialized)))
    self:Print(format("Schema Messages: %d", stats.schemaMessages))
    self:Print(format("NAG Function Mappings: %d", stats.nagFunctionMappings))

    if stats.initialized then
        local availableFunctions = self:GetAvailableFunctions()
        self:Print(format("Available Functions: %d", #availableFunctions))

        if #availableFunctions > 0 then
            self:Print("Sample Functions: " .. concat(availableFunctions, ", ", 1, min(5, #availableFunctions)))
        end

        -- Show some sample aliases
        local aliases = self:GetAvailableAliases()
        if #aliases > 0 then
            self:Print("Sample Aliases:")
            for i = 1, min(3, #aliases) do
                local alias = aliases[i]
                self:Print(format("  %s -> %s", alias.protoName, alias.nagName))
            end
            if #aliases > 3 then
                self:Print(format("  ... and %d more", #aliases - 3))
            end
        end
    end

    self:Print("=== NAG Function Mappings ===")
    local nagMappings = SchemaAccessor.nagFunctionMappings
    self:Print(format("Total Mappings: %d", TableUtils.Size(nagMappings)))

    if TableUtils.Size(nagMappings) > 0 then
        self:Print("Showing first 20 mappings:")
        local count = 0
        for nagName, protoName in pairs(nagMappings) do
            if count < 20 then
                self:Print(format("  %s -> %s", nagName, protoName))
                count = count + 1
            else
                break
            end
        end
        if count >= 20 then
            self:Print(format("  ... and %d more", TableUtils.Size(nagMappings) - 20))
        end
    end
end

--- Get detailed validation information for a function
--- @param functionName string The name of the function
--- @return table|nil Detailed validation information
function SchemaValidator:GetFunctionValidationInfo(functionName)
    if not self.initialized then
        return nil
    end

    local schema = self:GetFunctionSchema(functionName)
    if not schema then
        return nil
    end

    return {
        name = functionName,
        fields = schema.fields or {},
        fieldOrder = schema.field_order or {},
        requiredFields = {},
        optionalFields = {},
        repeatedFields = {}
    }
end

--- Test the validation system with a sample function call
--- @param functionName string The name of the function to test
--- @param testArgs table The arguments to test
--- @return table Test results
function SchemaValidator:TestValidation(functionName, testArgs)
    if not self.initialized then
        return {
            success = false,
            error = "SchemaValidator not initialized",
            testType = "validation_test"
        }
    end

    if self.debug then
        local mappings = SchemaAccessor:GetAllProtoToNagMappings()
        local aliasCount = TableUtils.Size(mappings)

        -- Show some relevant aliases for debugging
        local relevantAliases = {}
        for protoName, nagName in pairs(mappings) do
            if nagName == functionName then
                tinsert(relevantAliases, format("%s->%s", protoName, nagName))
            end
        end

        local aliasInfo = ""
        if #relevantAliases > 0 then
            aliasInfo = format(", relevant=[%s]", table.concat(relevantAliases, ","))
        else
            -- Show some sample aliases to help debug
            local samples = {}
            local sampleCount = 0
            for protoName, nagName in pairs(mappings) do
                if sampleCount < 3 then
                    tinsert(samples, format("%s->%s", protoName, nagName))
                    sampleCount = sampleCount + 1
                end
            end
            if #samples > 0 then
                aliasInfo = format(", samples=[%s]", table.concat(samples, ","))
            end
        end

        self:Debug("TestValidation('%s'): type=%s, len=%d, aliases=%d%s",
            functionName, type(functionName), functionName and #functionName or 0, aliasCount, aliasInfo)
    end

    local testResults = {
        functionName = functionName,
        testArgs = testArgs,
        testType = "validation_test",
        timestamp = time(),
        results = {}
    }

    -- Test function existence
    local functionExists = self:FunctionExists(functionName)
    testResults.results.functionExists = {
        result = functionExists,
        message = functionExists and "Function found in schema" or "Function not found in schema"
    }

    if self.debug then
        self:Debug("FunctionExists: fn='%s', result=%s", functionName, tostring(functionExists))
    end

    if not functionExists then
        testResults.success = false
        testResults.error = "Function not found in schema"
        return testResults
    end

    -- Test argument validation
    if self.debug then
        self:Debug("Proceeding to argument validation: fn='%s'", functionName)
    end

    local valid, error, validationInfo = self:ValidateFunctionCall(functionName, testArgs)
    testResults.results.argumentValidation = {
        result = valid,
        error = error,
        validationInfo = validationInfo
    }

    if self.debug then
        self:Debug("ValidateFunctionCall result: fn='%s', valid=%s, error=%s",
            functionName, tostring(valid), tostring(error))
    end

    -- Test field-by-field validation
    if testArgs then
        testResults.results.fieldValidation = {}
        local schema = self:GetFunctionSchema(functionName)
        if schema and schema.fields then
            for fieldName, fieldValue in pairs(testArgs) do
                local fieldInfo = schema.fields[fieldName]
                if fieldInfo then
                    local fieldValid, fieldError = self:ValidateFieldValue(fieldName, fieldValue, fieldInfo)
                    testResults.results.fieldValidation[fieldName] = {
                        valid = fieldValid,
                        error = fieldError,
                        fieldInfo = fieldInfo
                    }
                else
                    testResults.results.fieldValidation[fieldName] = {
                        valid = false,
                        error = "Field not defined in schema",
                        fieldInfo = nil
                    }
                end
            end
        end
    end

    testResults.success = valid
    testResults.error = error

    return testResults
end

--- Get a summary of validation capabilities
--- @return table Capability summary
function SchemaValidator:GetCapabilitySummary()
    if not self.initialized then
        return { initialized = false }
    end

    local schemaData = SchemaAccessor:GetSchemaData()
    local summary = {
        initialized = true,
        schemaData = schemaData ~= nil,
        messageTypes = {},
        fieldTypes = {},
        validationFeatures = {}
    }

    -- Count message types
    if schemaData and schemaData.messages then
        for messageType, messageInfo in pairs(schemaData.messages) do
            local fieldCount = messageInfo.fields and TableUtils.Size(messageInfo.fields) or 0
            summary.messageTypes[messageType] = {
                fieldCount = fieldCount,
                hasFieldOrder = messageInfo.field_order ~= nil
            }
        end
    end

    -- Count field types
    local fieldTypeCounts = {}
    if schemaData and schemaData.messages then
        for _, messageInfo in pairs(schemaData.messages) do
            if messageInfo.fields then
                for _, fieldInfo in pairs(messageInfo.fields) do
                    local fieldType = fieldInfo.type or "unknown"
                    fieldTypeCounts[fieldType] = (fieldTypeCounts[fieldType] or 0) + 1
                end
            end
        end
    end
    summary.fieldTypes = fieldTypeCounts

    -- List validation features
    summary.validationFeatures = {
        "Function existence checking",
        "Field type validation",
        "Required field validation",
        "Enum value validation",
        "Nested message validation",
        "Field order validation",
        "Argument count validation",
        "Dynamic function aliasing"
    }

    -- Add alias information
    local mappings = SchemaAccessor:GetAllProtoToNagMappings()
    summary.aliases = {
        total = TableUtils.Size(mappings),
        examples = {}
    }

    -- Add some example aliases
    local aliases = self:GetAvailableAliases()
    for i = 1, min(3, #aliases) do
        tinsert(summary.aliases.examples, {
            proto = aliases[i].protoName,
            nag = aliases[i].nagName
        })
    end

    return summary
end

--- Slash command handler for /nagschema
--- @param msg string The command message
function SchemaValidator:nagschema(msg)
    if not msg or msg == "" then
        self:Print("=== SchemaValidator Commands ===")
        self:Print("Usage: /nagschema <command> [options]")
        self:Print("")
        self:Print("Commands:")
        self:Print("  /nagschema status - Show system status")
        self:Print("  /nagschema test <function> [positional_values] - Test function validation")
        self:Print("  /nagschema functions - List available functions")
        self:Print("  /nagschema aliases - List function aliases")
        self:Print("  /nagschema capabilities - Show validation capabilities")
        self:Print("  /nagschema debug - Show debug information")
        self:Print("  /nagschema force-init - Force initialize if not ready")
        return
    end

    local args = {}
    for arg in msg:gmatch("([^%s]+)") do
        tinsert(args, arg)
    end

    local command = args[1] or ""

    if command == "status" then
        local stats = self:GetValidationStats()
        self:Print("=== SchemaValidator Status ===")
        self:Print("Initialized: " .. tostring(stats.initialized))
        self:Print("Schema Data: " .. tostring(stats.schemaData))
        self:Print("Schema Messages: " .. tostring(stats.schemaMessages))
        self:Print("NAG Function Mappings: " .. tostring(TableUtils.Size(SchemaAccessor.nagFunctionMappings)))
    elseif command == "test" then
        if #args < 2 then
            self:Print("Usage: /nagschema test <function_name> [positional_value1] [positional_value2] ...")
            self:Print("Example: /nagschema test SelectRotation 'Frost 2H'")
            self:Print("Example: /nagschema test TimeToPercent 45")
            return
        end

        local functionName = args[2]
        local testArgs = {}

        -- Parse positional arguments (no more field=value parsing)
        for i = 3, #args do
            local value = args[i]
            -- Try to convert value to appropriate type
            if value == "true" then
                tinsert(testArgs, true)
            elseif value == "false" then
                tinsert(testArgs, false)
            elseif tonumber(value) then
                tinsert(testArgs, tonumber(value))
            else
                tinsert(testArgs, value)
            end
        end

        self:Print("=== Testing Function: " .. functionName .. " ===")
        self:Print("Test Arguments: " .. #testArgs .. " positional values")
        if #testArgs > 0 then
            self:Print("Arguments: " .. concat(testArgs, ", "))
        end

        local testResults = self:TestValidation(functionName, testArgs)

        if testResults.success then
            self:Print("Test Result: PASS")
        else
            self:Print("Test Result: FAIL")
            self:Print("Error: " .. (testResults.error or "Unknown error"))
        end

        -- Show detailed results
        if testResults.results.functionExists then
            self:Print("Function Exists: " .. tostring(testResults.results.functionExists.result))
        end

        if testResults.results.argumentValidation then
            local argValidation = testResults.results.argumentValidation
            self:Print("Argument Validation: " .. tostring(argValidation.result))
            if not argValidation.result then
                self:Print("  Error: " .. (argValidation.error or "Unknown error"))
            end
        end
    elseif command == "functions" then
        local functions = self:GetAvailableFunctions()
        self:Print("=== Available Functions ===")
        self:Print("Total Functions: " .. #functions)

        if #functions > 0 then
            local displayCount = min(20, #functions)
            self:Print("Showing first " .. displayCount .. " functions:")
            for i = 1, displayCount do
                self:Print("  " .. functions[i])
            end
            if #functions > displayCount then
                self:Print("  ... and " .. (#functions - displayCount) .. " more")
            end
        end
    elseif command == "aliases" then
        local aliases = self:GetAvailableAliases()
        self:Print("=== Function Aliases ===")
        local mappings = SchemaAccessor:GetAllProtoToNagMappings()
        self:Print(format("Total Aliases: %d", TableUtils.Size(mappings)))

        if TableUtils.Size(mappings) > 0 then
            self:Print("Showing first 20 aliases:")
            local count = 0
            for protoName, nagName in pairs(mappings) do
                if count < 20 then
                    self:Print(format("  %s -> %s", protoName, nagName))
                    count = count + 1
                else
                    break
                end
            end
            if count >= 20 then
                self:Print(format("  ... and %d more", TableUtils.Size(mappings) - 20))
            end
        end
    elseif command == "capabilities" then
        local capabilities = self:GetCapabilitySummary()
        self:Print("=== Validation Capabilities ===")
        self:Print("Initialized: " .. tostring(capabilities.initialized))
        self:Print("Schema Data: " .. tostring(capabilities.schemaData))
        self:Print("Message Types: " .. tostring(TableUtils.Size(capabilities.messageTypes)))
        self:Print("Field Types: " .. tostring(TableUtils.Size(capabilities.fieldTypes)))

        self:Print("")
        self:Print("Validation Features:")
        for _, feature in ipairs(capabilities.validationFeatures) do
            self:Print("  - " .. feature)
        end

        -- Show alias information
        if capabilities.aliases and capabilities.aliases.total > 0 then
            self:Print("")
            self:Print("Aliases:")
            self:Print("  Total: " .. capabilities.aliases.total)
            if #capabilities.aliases.examples > 0 then
                self:Print("  Examples:")
                for _, example in ipairs(capabilities.aliases.examples) do
                    self:Print("    " .. example.proto .. " -> " .. example.nag)
                end
            end
        end
    elseif command == "debug" then
        self:PrintDebugInfo()
    elseif command == "force-init" then
        if self.initialized then
            self:Print("SchemaValidator is already initialized")
        else
            self:Print("Attempting to force initialize SchemaValidator...")
            if self:ForceInitialization() then
                self:Print("✓ SchemaValidator force-initialized successfully")
                local mappings = SchemaAccessor:GetAllProtoToNagMappings()
                self:Print("Generated " .. TableUtils.Size(mappings) .. " aliases")
            else
                self:Print("✗ Failed to force initialize SchemaValidator")
                self:Print("SchemaAccessor available: " .. tostring(self:CanInitialize()))
            end
        end
    else
        self:Print("Unknown command: " .. command)
        self:Print("Use /nagschema for help")
    end
end

--- Show NAG function name mappings
function SchemaValidator:ShowFunctionAliases()
    if not self.initialized then
        self:Print("SchemaValidator not initialized")
        return
    end

    self:Print("=== Function Aliases ===")
    local mappings = SchemaAccessor:GetAllProtoToNagMappings()
    self:Print(format("Total Aliases: %d", TableUtils.Size(mappings)))

    if TableUtils.Size(mappings) > 0 then
        local count = 0
        for protoName, nagName in pairs(mappings) do
            self:Print(format("  %s → %s", protoName, nagName))
            count = count + 1
            if count >= 20 then
                self:Print(format("  ... and %d more", TableUtils.Size(mappings) - 20))
                break
            end
        end
    else
        self:Print("  No aliases generated yet")
    end
end

function SchemaValidator:ShowNAGFunctionMappings()
    if not self.initialized then
        self:Print("SchemaValidator not initialized")
        return
    end

    self:Print("=== NAG Function Mappings ===")
    local nagMappings = SchemaAccessor.nagFunctionMappings
    self:Print(format("Total Mappings: %d", TableUtils.Size(nagMappings)))

    -- Group mappings by category
    local categories = {
        ["Core Casting"] = { "CastSpell" },
        ["Utility"] = { "TimeToPercent", "IsDualWield", "SelectRotation" },
        ["Auras"] = { "AuraIsActive", "DotIsActive" },
        ["Combat"] = { "InCombat", "TargetExists", "TargetHealth", "PlayerHealth" },
        ["Cooldowns"] = { "SpellCooldown", "SpellCharges", "ItemCooldown" },
        ["Resources"] = { "Power", "Rage", "Energy", "Mana", "Runes" },
        ["Movement"] = { "Moving", "Speed", "Position" }
    }

    for category, functions in pairs(categories) do
        self:Print(format("--- %s ---", category))
        for _, funcName in ipairs(functions) do
            local mapping = nagMappings[funcName]
            if mapping then
                self:Print(format("  %s -> %s", funcName, mapping))
            end
        end
    end

    self:Print("=== End Mappings ===")
end
