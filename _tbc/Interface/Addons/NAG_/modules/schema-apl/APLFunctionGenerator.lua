--- @module "NAG.APLFunctionGenerator"
--- Generates APL functions from schema metadata and handler implementations.
--- This module coordinates between SchemaAccessor (schema metadata) and actual handler
--- implementations to generate wrapper functions with validation and defaults.
---
--- Can be disabled via NAG_AUTO_FUNCTION_GENERATION flag (defaults to false).
--- When enabled, generates functions in SchemaAccessor.generatedFunctions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local addonName, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS ~~~~~~~~~~
--- @type SchemaAccessor
local SchemaAccessor

--- @type SchemaUtils
local SchemaUtils

local TableUtils = ns.TableUtils

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format

-- ~~~~~~~~~~ CONTENT ~~~~~~~~--
-- Global flag to control auto function generation (disabled by default)
NAG_AUTO_FUNCTION_GENERATION = NAG_AUTO_FUNCTION_GENERATION or false

--- @class APLFunctionGenerator:CoreModule
local APLFunctionGenerator = NAG:CreateModule("APLFunctionGenerator", nil, {
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.PROCESSORS
    }
})
local module = APLFunctionGenerator
ns.APLFunctionGenerator = APLFunctionGenerator

-- Initialize implementations storage (for auto-generation if enabled)
APLFunctionGenerator.implementations = {
    Values = {},
    Actions = {}
}

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
function APLFunctionGenerator:ModuleInitialize()
    -- Get required modules
    SchemaAccessor = NAG:GetModule("SchemaAccessor")
    SchemaUtils = NAG:GetModule("SchemaUtils")
end

function APLFunctionGenerator:ModuleEnable()
end

function APLFunctionGenerator:ModuleDisable()
end

-- ~~~~~~~~~~ IMPLEMENTATION REGISTRATION ~~~~~~~~~~
-- These methods allow registration of APL implementations for auto-generation
-- (Currently unused - handlers define functions directly on NAG, but kept for future use)

--- Register a value implementation
--- @param valueType string The value type key
--- @param implementation table The implementation table with code, defaults, etc.
function APLFunctionGenerator:RegisterValueImplementation(valueType, implementation)
    if not valueType or type(valueType) ~= "string" then
        self:Error("RegisterValueImplementation: invalid valueType provided")
        return
    end
    if not implementation or type(implementation) ~= "table" then
        self:Error("RegisterValueImplementation: invalid implementation provided")
        return
    end
    self.implementations.Values[valueType] = implementation
    if self.debug then self:Debug("Registered Value implementation for type: %s", tostring(valueType)) end
end

--- Register an action implementation
--- @param actionType string The action type key
--- @param implementation table The implementation table with code, defaults, etc.
function APLFunctionGenerator:RegisterActionImplementation(actionType, implementation)
    if not actionType or type(actionType) ~= "string" then
        self:Error("RegisterActionImplementation: invalid actionType provided")
        return
    end
    if not implementation or type(implementation) ~= "table" then
        self:Error("RegisterActionImplementation: invalid implementation provided")
        return
    end
    self.implementations.Actions[actionType] = implementation
    if self.debug then self:Debug("Registered Action implementation for type: %s", tostring(actionType)) end
end

--- Register multiple implementations for a category
--- @param category string "Values" or "Actions"
--- @param entries table Table of typeKey -> implementation mappings
function APLFunctionGenerator:RegisterImplementations(category, entries)
    if not category or type(category) ~= "string" then
        self:Error("RegisterImplementations: invalid category provided")
        return
    end
    if not entries or type(entries) ~= "table" then
        self:Error("RegisterImplementations: invalid entries provided")
        return
    end
    if category == "Values" then
        for k, v in pairs(entries) do
            self:RegisterValueImplementation(k, v)
        end
    elseif category == "Actions" then
        for k, v in pairs(entries) do
            self:RegisterActionImplementation(k, v)
        end
    else
        self:Error("RegisterImplementations: invalid category (must be 'Values' or 'Actions')")
    end
end

--- Get implementation for a type
--- @param category string "Values" or "Actions"
--- @param typeKey string The type key
--- @return table|nil The implementation or nil if not found
function APLFunctionGenerator:GetImplementation(category, typeKey)
    if not category or not typeKey then
        return nil
    end
    if category == "Values" then
        return self.implementations.Values[typeKey]
    elseif category == "Actions" then
        return self.implementations.Actions[typeKey]
    end
    return nil
end

-- ~~~~~~~~~~ FUNCTION GENERATION ~~~~~~~~~~

--- Generate implementation from metadata and registered implementations
--- @param metadata table Metadata for the type (from SchemaAccessor)
--- @param typeKey string The type key (e.g., "cast_spell", "number_targets")
--- @param category string The category ("Values" or "Actions")
--- @return table|nil Implementation table with func, args, defaults, code
function APLFunctionGenerator:GenerateImplementationFromMetadata(metadata, typeKey, category)
    self:Trace("[GEN] Enter GenerateImplementationFromMetadata for %s in category %s", tostring(typeKey), tostring(category))

    -- Get implementation if available from our implementations storage
    local implementation = self:GetImplementation(category, typeKey)
    if not implementation then
        self:Trace("[GEN] No implementation found for %s, using default", tostring(typeKey))
        implementation = {}
    end

    -- Get field info from SchemaAccessor
    local fields = {}
    local fieldOrder = {}
    local messageType = metadata.message_type or metadata.protoName
    if messageType then
        fields, fieldOrder = SchemaAccessor:GetFields(messageType)
    end

    -- Generate args list from field order
    -- Use snake_case (proto format) directly - camelCase is only for WoWSims import/export boundaries
    local args = {}
    for _, fieldName in ipairs(fieldOrder) do
        table.insert(args, fieldName)
    end
    -- If no field order, use field names in any order (not ideal)
    if #args == 0 then
        for fieldName, _ in pairs(fields) do
            table.insert(args, fieldName)
        end
    end

    -- Check if we have defaults in implementation
    local defaults = implementation.defaults or {}
    -- Get the function name (CamelCase the key)
    local funcName = typeKey:gsub("^%l", string.upper):gsub("_(%l)", function(c) return c:upper() end)
    -- Get implementation code function or generate placeholder
    local codeFunc = implementation.code
    if type(codeFunc) ~= "function" then
        if self.debug then self:Debug("[GEN] No code function for %s in category %s. Using placeholder.", tostring(typeKey), tostring(category)) end
        codeFunc = function(...)
            if self.debug then self:Debug("Auto-generated %s called with %d args", funcName, select('#', ...)) end
            return true
        end
    end
    -- Generate complete implementation
    local result = {
        func = funcName,
        args = args,
        defaults = defaults,
        code = codeFunc,
    }
    self:Trace("[GEN] Generated implementation for %s: %s", tostring(typeKey), tostring(result.func))
    return result
end

--- Generate all APL functions from schema metadata and implementations
--- This is the main entry point for function generation
--- Generated functions are stored in SchemaAccessor.generatedFunctions
function APLFunctionGenerator:GenerateAPLFunctions()
    -- Check if generation is enabled
    if not NAG_AUTO_FUNCTION_GENERATION then
        self:Debug("Auto function generation disabled - skipping function generation")
        return
    end

    if not SchemaAccessor then
        self:Error("SchemaAccessor not available for function generation")
        return
    end

    -- Initialize generated functions storage in SchemaAccessor
    if not SchemaAccessor.generatedFunctions then
        SchemaAccessor.generatedFunctions = {
            Values = {},
            Actions = {}
        }
    end

    local startTime = debugprofilestop()
    self:Info("Starting APL function generation")

    -- Generate values functions
    local valuesStart = debugprofilestop()
    local valuesCount = 0
    local valueTypes = SchemaAccessor:GetValueTypes()

    for _, valueType in ipairs(valueTypes) do
        if self.debug then self:Trace("Processing Value type: %s", tostring(valueType)) end

        -- Get metadata from SchemaAccessor
        local metadata = SchemaAccessor:GetMetadataByIdentifier(valueType, nil)
        if metadata then
            -- Generate implementation
            local impl = self:GenerateImplementationFromMetadata(metadata, valueType, "Values")
            if impl and impl.code then
                -- Create the function with type validation
                SchemaAccessor.generatedFunctions.Values[impl.func] = function(...)
                    if self.debug then self:Debug("Executing Value function: %s", impl.func) end
                    -- Input validation
                    local args = { ... }
                    if #args < 1 and #impl.args > 0 then
                        local errMsg = format("%s: No %s provided", impl.func, impl.args[1])
                        self:Error(errMsg)
                        error(errMsg)
                    end
                    -- Apply defaults safely
                    for argName, defaultValue in pairs(impl.defaults or {}) do
                        local argIndex = TableUtils.IndexOf(impl.args, argName)
                        if argIndex and args[argIndex] == nil then
                            args[argIndex] = defaultValue
                            if self.debug then self:Trace("%s: Applied default value for %s: %s", impl.func, argName, tostring(defaultValue)) end
                        end
                    end
                    -- Validate enum values if applicable
                    for i, arg in ipairs(args) do
                        local fieldName = impl.args[i]
                        -- Get field info from SchemaAccessor if available
                        local fieldInfo = nil
                        if SchemaAccessor then
                            local fields, _ = SchemaAccessor:GetFields(metadata.message_type)
                            fieldInfo = fields and fields[fieldName]
                        end
                        if fieldInfo and fieldInfo.type == "enum" and fieldInfo.enum_type then
                            if not SchemaAccessor:ValidateEnumValue(fieldInfo.enum_type, arg) then
                                local errMsg = format("%s: Invalid value for %s: %s", impl.func, fieldName, tostring(arg))
                                self:Error(errMsg)
                                error(errMsg)
                            end
                        end
                    end
                    -- Call implementation with pcall for safety
                    local success, result = ns.pcall(impl.code, unpack(args))
                    if not success then
                        local errMsg = format("Error in %s: %s", impl.func, result)
                        self:Error(errMsg)
                        error(errMsg)
                    end
                    return result
                end
                valuesCount = valuesCount + 1
            else
                self:Error("[GEN] Implementation missing or missing code for %s", tostring(valueType))
            end
        else
            self:Warn("[GEN] No metadata found for Value type: %s", tostring(valueType))
        end
    end
    local valuesEnd = debugprofilestop()
    self:Info(format("Generated %d Value functions in %.2f ms", valuesCount, valuesEnd - valuesStart))

    -- Generate action functions
    local actionsStart = debugprofilestop()
    local actionsCount = 0
    local actionTypes = SchemaAccessor:GetActionTypes()

    for _, actionType in ipairs(actionTypes) do
        if self.debug then self:Trace("Processing Action type: %s", tostring(actionType)) end

        -- Get metadata from SchemaAccessor
        local metadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
        if metadata then
            -- Generate implementation
            local impl = self:GenerateImplementationFromMetadata(metadata, actionType, "Actions")
            if impl and impl.code then
                -- Create the function with type validation
                SchemaAccessor.generatedFunctions.Actions[impl.func] = function(...)
                    if self.debug then self:Debug("Executing Action function: %s", impl.func) end
                    -- Input validation
                    local args = { ... }
                    if #args < 1 and #impl.args > 0 then
                        local errMsg = format("%s: No %s provided", impl.func, impl.args[1])
                        self:Error(errMsg)
                        error(errMsg)
                    end
                    -- Apply defaults safely
                    for argName, defaultValue in pairs(impl.defaults or {}) do
                        local argIndex = TableUtils.IndexOf(impl.args, argName)
                        if argIndex and args[argIndex] == nil then
                            args[argIndex] = defaultValue
                            if self.debug then self:Trace("%s: Applied default value for %s: %s", impl.func, argName, tostring(defaultValue)) end
                        end
                    end
                    -- Validate enum values if applicable
                    for i, arg in ipairs(args) do
                        local fieldName = impl.args[i]
                        -- Get field info from SchemaAccessor if available
                        local fieldInfo = nil
                        if SchemaAccessor then
                            local fields, _ = SchemaAccessor:GetFields(metadata.message_type)
                            fieldInfo = fields and fields[fieldName]
                        end
                        if fieldInfo and fieldInfo.type == "enum" and fieldInfo.enum_type then
                            if not SchemaAccessor:ValidateEnumValue(fieldInfo.enum_type, arg) then
                                local errMsg = format("%s: Invalid value for %s: %s", impl.func, fieldName, tostring(arg))
                                self:Error(errMsg)
                                error(errMsg)
                            end
                        end
                    end
                    -- Call implementation
                    return impl.code(unpack(args))
                end
                actionsCount = actionsCount + 1
            else
                self:Error("[GEN] Implementation missing or missing code for %s", tostring(actionType))
            end
        else
            self:Warn("[GEN] No metadata found for Action type: %s", tostring(actionType))
        end
    end
    local actionsEnd = debugprofilestop()
    self:Info(format("Generated %d Action functions in %.2f ms", actionsCount, actionsEnd - actionsStart))

    local endTime = debugprofilestop()
    if self.debug then self:Debug("Total function generation took %.2f ms", endTime - startTime) end
end

