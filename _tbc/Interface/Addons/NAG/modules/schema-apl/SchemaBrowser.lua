--- @module "NAG.SchemaBrowser"
--- Provides a UI module for browsing and exploring the APL schema for NAG.
---
--- This module provides a user interface for viewing the APL schema, message types,
--- and field definitions. For metadata API access, use SchemaAccessor instead.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
--- @type Types
local StateManager, Types

--- @type OptionsFactory
--- @type SchemaAccessor
--- @type SchemaUtils
local OptionsFactory, SchemaAccessor, SchemaUtils

--- @type SpecCompat
local SpecCompat


local TableUtils = ns.TableUtils

local L = LibStub("AceLocale-3.0"):GetLocale("NAG")
local Version = ns.Version
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format -- WoW's optimized version if available

local tinsert = tinsert
local wipe = wipe

local sort = table.sort

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class SchemaBrowser: CoreModule
local SchemaBrowser = NAG:CreateModule("SchemaBrowser", nil, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 10,
    hidden = function(self) return not NAG:IsDevModeEnabled() end,
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.DATA
    }
})

local module = SchemaBrowser
ns.SchemaBrowser = SchemaBrowser

-- Initialize module properties
SchemaBrowser.SchemaCache = {}
-- Added toggle settings for schema viewing filtering
SchemaBrowser.ViewSettings = {
    filterBySpec = false,          -- Default to showing all elements (false = show all)
    filterByPrepull = false,       -- Default to showing all elements (false = show all)
    currentPrepullContext = false, -- Current context - true if we're in prepull editor
}
-- Track if schema has been loaded to avoid reloading
SchemaBrowser.schemaLoaded = false

-- ============================ DEBUG HELPERS ============================
-- Enhanced debugging utilities for SchemaBrowser
--
-- USAGE:
--   - Use self:DebugWithCaller() instead of self:Debug() to see caller function and line number
--   - Use self:DebugWithStack() for full stack traces when debugging complex call chains
--   - Use self:DebugWithLocals() to see local variables (only works in error handlers)
--   - All methods respect self.debug flag (only log when debug is enabled)
--
-- EXAMPLE OUTPUT:
--   Regular: "ShouldShowMessageType called for: APLActionCastSpell"
--   Enhanced: "[GetMessageTypesOptions:390] ShouldShowMessageType called for: APLActionCastSpell"
--
-- WoW Lua 5.1 Protected Environment:
--   - Uses debugstack() for caller information and stack traces (WoW-specific function)
--   - Uses debuglocals() for variable inspection (WoW-specific, limited contexts)
--   - Note: debug.getinfo() is NOT available in WoW's protected environment

--- Extract caller info from debugstack string (WoW-specific)
--- @param stackLevel number Stack level to extract (default: 2)
--- @return string|nil Function name or nil
--- @return string|nil File name or nil
--- @return number|nil Line number or nil
local function GetCallerFromStack(stackLevel)
    stackLevel = stackLevel or 2
    -- Get stack trace starting from the caller (level 2)
    -- Format: "file.lua:123: in function 'FunctionName'\n..." or "file.lua:123\n..."
    local stack = debugstack(stackLevel, 1, 0)
    if stack and stack ~= "" then
        -- Parse first line: "file.lua:123: in function 'FunctionName'" or "file.lua:123"
        local file, line, func = stack:match("([^:]+):(%d+):.*function ['\"]?([^'\"]+)['\"]?")
        if not func then
            -- Try without function name: "file.lua:123"
            file, line = stack:match("([^:]+):(%d+)")
        end
        if file and line then
            -- Extract just filename from path
            local fileName = file:match("([^/\\]+)$") or file
            return func or "?", fileName, tonumber(line)
        end
    end
    return nil, nil, nil
end

--- Enhanced debug logging with caller information
--- Uses WoW's debugstack() to extract caller information
--- @param self SchemaBrowser
--- @param msg string The message to log
--- @param ... any Additional arguments to format
function SchemaBrowser:DebugWithCaller(msg, ...)
    if not self.debug then return end

    local formattedMsg = format(msg, ...)

    -- Extract caller info from debugstack (WoW-specific)
    local callerName, callerSource, callerLine = GetCallerFromStack(2)

    if callerName and callerLine then
        local displayName = callerName ~= "?" and callerName or (callerSource or "?")
        self:Debug("[%s:%d] %s", displayName, callerLine, formattedMsg)
    else
        -- Fallback to simple debug if we can't get caller info
        self:Debug(formattedMsg)
    end
end

--- Enhanced debug logging with full stack trace (for complex debugging)
--- Uses WoW's debugstack() function
--- @param self SchemaBrowser
--- @param msg string The message to log
--- @param options table|nil Optional table with {start, count1, count2} or nil for defaults
--- @param ... any Additional arguments to format the message
function SchemaBrowser:DebugWithStack(msg, options, ...)
    if not self.debug then return end

    local formattedMsg = format(msg, ...)

    -- Handle options parameter - can be nil, table, or if it's a number, treat as start
    local start, count1, count2
    if type(options) == "table" then
        start = options.start or 2
        count1 = options.count1 or 5
        count2 = options.count2 or 0
    elseif type(options) == "number" then
        -- Backward compatibility: if second arg is number, treat as start
        start = options
        count1 = 5
        count2 = 0
    else
        -- Defaults
        start = 2  -- Start from caller
        count1 = 5  -- Show 5 top frames
        count2 = 0  -- Don't show bottom frames by default
    end

    -- Get stack trace using WoW's debugstack
    -- Signature: debugstack([coroutine,] [start [, count1 [, count2]]])
    local stack = debugstack(start, count1, count2)

    if stack and stack ~= "" then
        self:Debug("%s\nStack trace:\n%s", formattedMsg, stack)
    else
        self:Debug("%s\n(Stack trace unavailable)", formattedMsg)
    end
end

--- Enhanced debug logging with local variables (WoW-specific)
--- Note: debuglocals() only works in error handlers or certain contexts
--- @param self SchemaBrowser
--- @param msg string The message to log
--- @param level number Stack level to inspect (default: 1)
--- @param ... any Additional arguments to format
function SchemaBrowser:DebugWithLocals(msg, level, ...)
    if not self.debug then return end

    local formattedMsg = format(msg, ...)
    level = level or 1

    -- Try to get locals (may return nil if not in valid context)
    local locals = debuglocals(level)

    if locals and locals ~= "" then
        self:Debug("%s\nLocal variables (level %d):\n%s", formattedMsg, level, locals)
    else
        self:Debug("%s\n(Local variables unavailable - debuglocals only works in error handlers)", formattedMsg)
    end
end

-- Core initialization
function SchemaBrowser:ModuleInitialize()
    local startTime = debugprofilestop()

    SchemaAccessor = NAG:GetModule("SchemaAccessor")
    SchemaUtils = NAG:GetModule("SchemaUtils")
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Set initial selections for UI to nil
    -- They will be initialized on first access
    self.selectedMessageType = nil
    self.selectedActionType = nil
    self.selectedValueType = nil
    self.selectedEnumType = nil

    -- Mark schema as loaded when SchemaAccessor is available
    if SchemaAccessor:GetSchemaData() then
        self.schemaLoaded = true
        self:Debug("Schema loaded successfully")
    else
        self:Debug("Schema not yet available, will be loaded on first access")
    end

    local endTime = debugprofilestop()
    if self.debug then self:Debug("SchemaBrowser initialized in %.2f ms", endTime - startTime) end
end

function SchemaBrowser:ModuleEnable()
    StateManager = NAG:GetModule("StateManager")
    Types = NAG:GetModule("Types")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    SchemaAccessor = NAG:GetModule("SchemaAccessor")
    SchemaUtils = NAG:GetModule("SchemaUtils")
end

--- Called when the module is disabled - proper cache cleanup
--- @param self SchemaBrowser
function SchemaBrowser:ModuleDisable()
    self:Info("Disabling SchemaBrowser - cleaning up caches")

    -- Clear schema cache
    wipe(SchemaBrowser.SchemaCache)

    -- Reset state
    SchemaBrowser.schemaLoaded = false
    SchemaBrowser.ViewSettings = {
        filterBySpec = false,
        filterByPrepull = false,
        currentPrepullContext = false,
    }

    -- Clear selections
    self.selectedMessageType = nil
    self.selectedActionType = nil
    self.selectedValueType = nil
    self.selectedEnumType = nil
end

-- String case conversion handled by SchemaUtils
-- Field name conversion handled by SchemaUtils
-- Field formatting handled by SchemaUtils

-- Get schema data (uses SchemaAccessor)
function SchemaBrowser:GetSchema()
    return SchemaAccessor:GetSchemaData()
end


-- Get all action types (now uses SchemaAccessor)
function SchemaBrowser:GetAllActionTypes()
    return SchemaAccessor:GetActionTypes()
end

-- Get all value types (now uses SchemaAccessor)
function SchemaBrowser:GetAllValueTypes()
    return SchemaAccessor:GetValueTypes()
end

-- Field type formatting now handled by SchemaUtils
-- Use SchemaUtils:FormatFieldType() instead

-- Enum values formatting now handled by SchemaUtils
-- Use SchemaUtils:FormatEnumValues() instead

-- Generate options table for AceConfig
function SchemaBrowser:GetOptions()
    local schema = SchemaAccessor:GetSchemaData()
    if not schema then
        return {
            type = "group",
            name = L["aplSchemaViewer"] or "APL Schema Viewer",
            order = 1,
            args = {
                noSchema = OptionsFactory:CreateDescription(
                    L["schemaNotLoaded"] or "Schema not loaded. Please load the game before accessing this panel.",
                    nil,
                    { order = 1 }
                )
            }
        }
    end

    -- Ensure we have initial selections
    if not self.selectedMessageType then
        local messageTypes = SchemaAccessor:GetAllMessageTypes()
        if #messageTypes > 0 then
            self.selectedMessageType = messageTypes[1]
            self:Debug("Initial message type selected: " .. self.selectedMessageType)
        end
    end

    if not self.selectedActionType then
        local actionTypes = self:GetAllActionTypes()
        if #actionTypes > 0 then
            self.selectedActionType = actionTypes[1]
            self:Debug("Initial action type selected: " .. self.selectedActionType)
        end
    end

    if not self.selectedValueType then
        local valueTypes = self:GetAllValueTypes()
        if #valueTypes > 0 then
            self.selectedValueType = valueTypes[1]
            self:Debug("Initial value type selected: " .. self.selectedValueType)
        end
    end

    if not self.selectedEnumType then
        local enumNames = {}
        for enumName in pairs(schema.enums or {}) do
            table.insert(enumNames, enumName)
        end
        if #enumNames > 0 then
            table.sort(enumNames)
            self.selectedEnumType = enumNames[1]
            self:Debug("Initial enum type selected: " .. self.selectedEnumType)
        end
    end

    return {
        type = "group",
        name = L["aplSchemaViewer"] or "APL Schema Viewer",
        order = 5,
        args = {
            header = OptionsFactory:CreateHeader(
                function() return L["aplSchemaViewer"] or "APL Schema Viewer" end,
                { order = 1 }
            ),
            description = OptionsFactory:CreateDescription(
                L["aplSchemaViewerDesc"] or "Browse the APL schema structure, message types, and field definitions.",
                nil,
                { order = 2 }
            ),
            messageTypes = self:GetMessageTypesOptions(),
            actions = self:GetActionsOptions(),
            values = self:GetValuesOptions(),
            enums = self:GetEnumsOptions(),
            diagnostics = self:GetDiagnosticsOptions(),
        }
    }
end

-- Generate options for message types
function SchemaBrowser:GetMessageTypesOptions()
    local messageTypes = SchemaAccessor:GetAllMessageTypes()
    local args = {
        header = OptionsFactory:CreateHeader(
            function() return L["messageTypes"] or "Message Types" end,
            { order = 1 }
        ),
        description = OptionsFactory:CreateDescription(
            L["messageTypesDesc"] or "Select a message type to view its fields and structure.",
            nil,
            { order = 2 }
        ),
        filterSettings = {
            type = "group",
            name = L["filterSettings"] or "Filter Settings",
            inline = true,
            order = 5,
            args = {
                filterBySpec = OptionsFactory:CreateToggle(
                    function() return L["filterBySpec"] or "Filter by Spec" end,
                    function()
                        return L["filterBySpecDesc"] or
                            "When enabled, only shows elements applicable to your current spec"
                    end,
                    function() return self.ViewSettings.filterBySpec end,
                    function(_, value)
                        self.ViewSettings.filterBySpec = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    { order = 1, width = "full" }
                ),
                filterByPrepull = OptionsFactory:CreateToggle(
                    function() return L["filterByContext"] or "Filter by Context" end,
                    function()
                        return L["filterByContextDesc"] or
                            "When enabled, only shows elements applicable to current context (prepull or combat)"
                    end,
                    function() return self.ViewSettings.filterByPrepull end,
                    function(_, value)
                        self.ViewSettings.filterByPrepull = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    { order = 2, width = "full" }
                ),
                contextSelect = OptionsFactory:CreateSelect(
                    function() return L["currentContext"] or "Current Context" end,
                    function() return L["currentContextDesc"] or "Select the current context for filtering" end,
                    function() return self.ViewSettings.currentPrepullContext end,
                    function(_, value)
                        self.ViewSettings.currentPrepullContext = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    {
                        values = {
                            [false] = L["contextCombat"] or "Combat",
                            [true] = L["contextPrepull"] or "Prepull"
                        },
                        disabled = function() return not self.ViewSettings.filterByPrepull end,
                        order = 3
                    }
                ),
                currentSpecInfo = OptionsFactory:CreateDescription(
                    function()
                        if not self.ViewSettings.filterBySpec then
                            return "Filtering by spec is disabled"
                        end
                        local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0
                        local specName = (SpecCompat and SpecCompat:GetSpecName()) or "Unknown"
                        return string.format("Currently filtering for Spec: %s (Index: %d)", specName, specIndex)
                    end,
                    nil,
                    { order = 4 }
                ),
            }
        },
        messageTypeSelect = OptionsFactory:CreateSelect(
            function() return L["messageType"] or "Message Type" end,
            function() return L["messageTypeDesc"] or "Select a message type to view its fields" end,
            function()
                if not self.selectedMessageType and #messageTypes > 0 then
                    self.selectedMessageType = messageTypes[1]
                    self:Debug("Default message type selected: " .. self.selectedMessageType)
                end
                -- If filtering is enabled and current selection doesn't pass filter, find a valid one
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    if self.selectedMessageType and not self:ShouldShowMessageType(self.selectedMessageType) then
                        for _, messageType in ipairs(messageTypes) do
                            if self:ShouldShowMessageType(messageType) then
                                self.selectedMessageType = messageType
                                break
                            end
                        end
                    end
                end
                return self.selectedMessageType
            end,
            function(_, value)
                self:Debug("Message type selected: " .. value)
                self.selectedMessageType = value
                self.selectedField = nil
            end,
            {
                values = function()
                    self:DebugWithCaller("=== Message Types values function called ===")
                    self:DebugWithCaller("  filterBySpec=%s, filterByPrepull=%s, currentPrepullContext=%s",
                        tostring(self.ViewSettings.filterBySpec),
                        tostring(self.ViewSettings.filterByPrepull),
                        tostring(self.ViewSettings.currentPrepullContext))
                    self:DebugWithCaller("  Total message types: %d", #messageTypes)

                    local values = {}
                    local filteredTypes = {}
                    if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                        self:Debug("  Filtering enabled, checking each message type...")
                        local checked = 0
                        local shown = 0
                        for _, messageType in ipairs(messageTypes) do
                            checked = checked + 1
                            local shouldShow = self:ShouldShowMessageType(messageType)
                            if shouldShow then
                                table.insert(filteredTypes, messageType)
                                shown = shown + 1
                            end
                            if checked <= 5 then
                                self:Debug("    [%d/%d] %s -> %s", checked, #messageTypes, messageType, tostring(shouldShow))
                            end
                        end
                        self:Debug("  Filtered %d message types from %d total (checked %d)", #filteredTypes, #messageTypes, checked)
                    else
                        self:Debug("  No filtering enabled, showing all %d message types", #messageTypes)
                        filteredTypes = messageTypes
                    end
                    for _, messageType in ipairs(filteredTypes) do
                        values[messageType] = messageType
                    end
                    self:Debug("  Returning %d values", #filteredTypes)
                    return values
                end,
                order = 10
            }
        )
    }
    -- ... existing code for fieldsGroup, fieldListGroup, etc. ...
    if self.selectedMessageType then
        self:Debug("Showing fields for message type: " .. self.selectedMessageType)
        -- ... existing code ...
        -- (copy all logic for fieldsGroup, fieldListGroup, etc. into args)
        -- ...
        -- (for brevity, not repeating unchanged code here)
        -- ...
        args.fieldsGroup = {
            type = "group",
            name = L["fields"] or "Fields",
            inline = true,
            order = 20,
            args = {}
        }

        local fields, fieldOrder = SchemaAccessor:GetFields(self.selectedMessageType)

        if not fields then
            self:Debug("No fields found for message type: " .. self.selectedMessageType)
            args.fieldsGroup.args.noFields = OptionsFactory:CreateDescription(
                L["noFieldsFound"] or "No fields found for this message type.",
                nil,
                { order = 1 }
            )
        elseif not next(fields) then
            self:Debug("Empty fields table for message type: " .. self.selectedMessageType)
            args.fieldsGroup.args.noFields = OptionsFactory:CreateDescription(
                L["noFieldsEmpty"] or "This message type exists but has no fields.",
                nil,
                { order = 1 }
            )
        else
            self:Debug("Found " .. SchemaUtils:TableCount(fields) .. " fields for " .. self.selectedMessageType)

            -- Add the field order information
            args.fieldsGroup.args.fieldOrderHeader = OptionsFactory:CreateHeader(
                function() return L["fieldOrder"] or "Field Order" end,
                { order = 1 }
            )

            args.fieldsGroup.args.fieldOrder = OptionsFactory:CreateDescription(
                fieldOrder and #fieldOrder > 0 and table.concat(fieldOrder, ", ") or
                (L["noFieldOrder"] or "No field order specified"),
                nil,
                { order = 2 }
            )

            -- Add each field
            args.fieldsGroup.args.fieldsHeader = OptionsFactory:CreateHeader(
                function() return L["fieldDefinitions"] or "Field Definitions" end,
                { order = 10 }
            )

            -- Process field list with priority for order fields
            local processedFields = {}
            local currentOrder = 11

            -- First process fields in order
            if fieldOrder and #fieldOrder > 0 then
                for _, fieldName in ipairs(fieldOrder) do
                    if fields[fieldName] and not processedFields[fieldName] and fieldName ~= "field_order" then
                        args.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName,
                            fields[fieldName], currentOrder)
                        currentOrder = currentOrder + 1
                        processedFields[fieldName] = true
                    end
                end
            end

            -- Then process any remaining fields
            for fieldName, fieldInfo in pairs(fields) do
                if not processedFields[fieldName] and fieldName ~= "field_order" then
                    args.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fieldInfo,
                        currentOrder)
                    currentOrder = currentOrder + 1
                end
            end

            -- Field details section for selected field
            if self.selectedField and fields[self.selectedField] then
                args.fieldDetails = {
                    type = "group",
                    name = function() return (L["fieldDetails"] or "Field Details: ") .. self.selectedField end,
                    inline = true,
                    order = 30,
                    args = self:CreateFieldDetailsOptions(self.selectedField, fields[self.selectedField])
                }
            end
        end

        -- Add a field list as a separate section for better visibility
        args.fieldListGroup = {
            type = "group",
            name = L["fieldList"] or "Field List",
            inline = true,
            order = 15,
            args = {
                fieldList = OptionsFactory:CreateDescription(
                    function()
                        if not fields or not next(fields) then
                            return L["noFieldsAvailable"] or "No fields available"
                        end

                        local result = ""
                        for fieldName, fieldInfo in pairs(fields) do
                            if fieldName ~= "field_order" then
                                result = result ..
                                    "|cFFFFD100" .. fieldName .. "|r: " .. SchemaUtils:FormatFieldType(fieldInfo) .. "\n"
                            end
                        end
                        return result
                    end,
                    nil,
                    { order = 1, fontSize = "medium" }
                )
            }
        }

        -- Add message type metadata section (dynamic)
        local messageSchema = SchemaAccessor:GetMessageSchema(self.selectedMessageType)
        if messageSchema and messageSchema._metadata then
            local metadataGroup = self:CreateMetadataGroup(
                messageSchema._metadata,
                L["messageTypeMetadata"] or "Message Type Metadata",
                5,
                true,
                { messageSchema = messageSchema },
                {
                    dumpMetadata = {
                        type = "execute",
                        name = L["dumpMetadata"] or "Dump Metadata to Chat",
                        desc = L["dumpMetadataDesc"] or "Print full metadata structure to chat for debugging",
                        order = 1000,
                        func = function()
                            self:DumpMessageTypeMetadata(self.selectedMessageType)
                        end
                    }
                }
            )
            if metadataGroup then
                args.messageTypeMetadata = metadataGroup
            end
        end
    end
    return {
        type = "group",
        name = L["messageTypes"] or "Message Types",
        order = 10,
        childGroups = "tab",
        args = args
    }
end

-- Table counting now handled by SchemaUtils
-- Use SchemaUtils:TableCount() instead

-- ============================ DYNAMIC METADATA DISPLAY ============================

--- Format a metadata key name for display (snake_case to Title Case)
--- @param key string The metadata key (e.g., "ui_label", "short_description")
--- @return string Formatted display name (e.g., "UI Label", "Short Description")
local function FormatMetadataKeyName(key)
    -- Handle common special cases
    local keyMap = {
        ui_label = "UI Label",
        short_description = "Short Description",
        full_description = "Full Description",
        include_if = "Include If",
        submenu = "Submenu",
        defaults = "Defaults",
        default = "Default",
        deprecated = "Deprecated"
    }

    if keyMap[key] then
        return keyMap[key]
    end

    -- Convert snake_case to Title Case
    local parts = {}
    for part in key:gmatch("[^_]+") do
        local first = part:sub(1, 1):upper()
        local rest = part:sub(2):lower()
        tinsert(parts, first .. rest)
    end
    return table.concat(parts, " ")
end

--- Format a metadata value for display based on its type
--- @param key string The metadata key
--- @param value any The metadata value
--- @param context table|nil Optional context (messageSchema, fieldName, etc.)
--- @return string Formatted value string
function SchemaBrowser:FormatMetadataValue(key, value, context)
    if value == nil then
        return "nil"
    end

    local valueType = type(value)

    -- Handle special metadata keys
    if key == "include_if" and valueType == "table" then
        local parts = {}
        if value.condition then
            tinsert(parts, "Condition: " .. tostring(value.condition))
        end
        if value.prepull_only ~= nil then
            tinsert(parts, "Prepull Only: " .. tostring(value.prepull_only))
        end
        if value.combat_only ~= nil then
            tinsert(parts, "Combat Only: " .. tostring(value.combat_only))
        end
        if value.spec_specific ~= nil then
            tinsert(parts, "Spec Specific: " .. tostring(value.spec_specific))
        end
        if value.class_specific ~= nil then
            tinsert(parts, "Class Specific: " .. tostring(value.class_specific))
        end
        if value.classes and next(value.classes) then
            tinsert(parts, "Classes: " .. table.concat(value.classes, ", "))
        end
        if value.excluded_classes and next(value.excluded_classes) then
            tinsert(parts, "Excluded Classes: " .. table.concat(value.excluded_classes, ", "))
        end
        if value.specs and next(value.specs) then
            tinsert(parts, "Specs: " .. table.concat(value.specs, ", "))
        end
        if value.excluded_specs and next(value.excluded_specs) then
            tinsert(parts, "Excluded Specs: " .. table.concat(value.excluded_specs, ", "))
        end
        return #parts > 0 and table.concat(parts, ", ") or "No conditions"
    elseif key == "submenu" and valueType == "table" then
        if #value > 0 then
            return table.concat(value, " > ")
        else
            return "Empty submenu"
        end
    elseif key == "defaults" and valueType == "table" then
        -- Use TableUtils for better formatting
        if TableUtils and TableUtils.ToString then
            return TableUtils.ToString(value)
        else
            -- Fallback to simple table representation
            local count = 0
            for _ in pairs(value) do count = count + 1 end
            return format("[table with %d entries]", count)
        end
    elseif key == "default" then
        -- Handle field-specific default value (singular)
        -- Try to resolve enum values for both string and number types
        if context and context.fieldInfo and context.messageSchema and context.fieldName then
            local enumType = SchemaAccessor:GetFieldEnumType(context.messageSchema, context.fieldName)
            if enumType and Types then
                local typeObj = Types:GetType(enumType)
                if typeObj then
                    if valueType == "number" then
                        -- Number enum value: resolve to name
                        local enumName = typeObj:GetNameByValue(value)
                        if enumName then
                            return format("%s (%d)", enumName, value)
                        end
                    elseif valueType == "string" then
                        -- String enum value: try to match and resolve
                        -- Handle formats like "ItemSwapSet.Main" or "Main"
                        local enumName = value:match("^[^%.]+%.(.+)$") or value  -- Extract "Main" from "ItemSwapSet.Main"
                        local enumValue = typeObj[enumName] or typeObj[value]  -- Try both clean and full name
                        if enumValue ~= nil then
                            return format("%s (%s = %d)", value, enumName, enumValue)
                        end
                    end
                end
            end
        end
        return tostring(value)
    elseif key == "deprecated" then
        return value and "Yes" or "No"
    elseif valueType == "boolean" then
        return value and "Yes" or "No"
    elseif valueType == "number" then
        -- Check if this might be an enum value
        if context and context.messageSchema and context.fieldName then
            local enumType = SchemaAccessor:GetFieldEnumType(context.messageSchema, context.fieldName)
            if Types then
                local typeObj = Types:GetType(enumType)
                if typeObj then
                    local enumName = typeObj:GetNameByValue(value)
                    if enumName then
                        return format("%s (%d)", enumName, value)
                    end
                end
            end
        end
        return tostring(value)
    elseif valueType == "string" then
        -- Check if this string might be an enum value reference
        if context and context.messageSchema and context.fieldName then
            local enumType = SchemaAccessor:GetFieldEnumType(context.messageSchema, context.fieldName)
            if enumType and Types then
                local typeObj = Types:GetType(enumType)
                if typeObj then
                    -- Handle formats like "ItemSwapSet.Main" or "Main"
                    local enumName = value:match("^[^%.]+%.(.+)$") or value  -- Extract "Main" from "ItemSwapSet.Main"
                    local enumValue = typeObj[enumName] or typeObj[value]  -- Try both clean and full name
                    if enumValue ~= nil then
                        return format("%s (%s = %d)", value, enumName, enumValue)
                    end
                end
            end
        end
        return tostring(value)
    elseif valueType == "table" then
        -- Check if it's an array
        if #value > 0 then
            local items = {}
            for i, item in ipairs(value) do
                tinsert(items, tostring(item))
            end
            return format("[%s]", table.concat(items, ", "))
        else
            -- Check if it's an enum value map
            local hasStringKeys = false
            local hasNumericValues = false
            for k, v in pairs(value) do
                if type(k) == "string" then hasStringKeys = true end
                if type(v) == "number" then hasNumericValues = true end
            end

            if hasStringKeys and hasNumericValues then
                -- Likely an enum value map, format nicely
                local items = {}
                for k, v in pairs(value) do
                    tinsert(items, format("%s = %d", k, v))
                end
                sort(items)
                return table.concat(items, ", ")
            else
                -- Generic table
                local count = 0
                for _ in pairs(value) do count = count + 1 end
                return format("[table with %d entries]", count)
            end
        end
    else
        return tostring(value)
    end
end

--- Create options args for metadata display dynamically
--- @param metadata table The metadata table to display
--- @param startOrder number Starting order number for options
--- @param context table|nil Optional context (messageSchema, fieldName, fieldInfo, etc.)
--- @return table Options args table
function SchemaBrowser:CreateMetadataOptionsArgs(metadata, startOrder, context)
    if not metadata or type(metadata) ~= "table" or not next(metadata) then
        return {}
    end

    local args = {}
    local order = startOrder or 1

    -- Collect and sort metadata keys for consistent display
    local keys = {}
    for key in pairs(metadata) do
        tinsert(keys, key)
    end
    sort(keys)

    -- Define display priority for common keys (display these first)
    local priorityKeys = {
        "ui_label",
        "short_description",
        "full_description",
        "submenu",
        "include_if",
        "defaults",
        "deprecated"
    }

    -- Separate priority and other keys
    local priorityList = {}
    local otherList = {}
    local prioritySet = {}
    for _, key in ipairs(priorityKeys) do
        prioritySet[key] = true
    end

    for _, key in ipairs(keys) do
        if prioritySet[key] then
            tinsert(priorityList, key)
        else
            tinsert(otherList, key)
        end
    end

    -- Display priority keys first, then others
    local displayOrder = {}
    for _, key in ipairs(priorityList) do
        tinsert(displayOrder, key)
    end
    for _, key in ipairs(otherList) do
        tinsert(displayOrder, key)
    end

    -- Create options for each metadata field
    for _, key in ipairs(displayOrder) do
        local value = metadata[key]
        if value ~= nil then
            -- Skip empty strings and empty tables (unless they're special cases)
            local shouldSkip = false
            if type(value) == "string" and value == "" then
                shouldSkip = true
            elseif type(value) == "table" and not next(value) then
                -- Don't skip include_if or defaults even if empty
                if key ~= "include_if" and key ~= "defaults" then
                    shouldSkip = true
                end
            end

            if not shouldSkip then
                local displayName = FormatMetadataKeyName(key)
                local formattedValue = self:FormatMetadataValue(key, value, context)

                -- Special handling for long text fields
                if key == "full_description" then
                    args[key] = OptionsFactory:CreateDescription(
                        format("|cFFFFD100%s:|r %s", displayName, formattedValue),
                        nil,
                        { order = order }
                    )
                elseif key == "include_if" then
                    args[key] = OptionsFactory:CreateDescription(
                        format("|cFFFFD100%s:|r %s", displayName, formattedValue),
                        nil,
                        { order = order }
                    )
                elseif key == "defaults" then
                    args[key] = OptionsFactory:CreateDescription(
                        format("|cFFFFD100%s:|r\n%s", displayName, formattedValue),
                        nil,
                        { order = order }
                    )
                else
                    args[key] = OptionsFactory:CreateDescription(
                        format("|cFFFFD100%s:|r %s", displayName, formattedValue),
                        nil,
                        { order = order }
                    )
                end

                order = order + 1
            end
        end
    end

    return args
end

--- Create a metadata group option dynamically
--- @param metadata table The metadata table to display
--- @param groupName string|function Name for the metadata group
--- @param order number Order number for the group
--- @param inline boolean Whether the group should be inline
--- @param context table|nil Optional context (messageSchema, fieldName, fieldInfo, etc.)
--- @param extraArgs table|nil Extra args to add to the group (e.g., dump button)
--- @return table|nil Options group table or nil if no metadata
function SchemaBrowser:CreateMetadataGroup(metadata, groupName, order, inline, context, extraArgs)
    if not metadata or type(metadata) ~= "table" or not next(metadata) then
        return nil
    end

    local args = self:CreateMetadataOptionsArgs(metadata, 1, context)

    -- Add extra args if provided
    if extraArgs then
        for key, value in pairs(extraArgs) do
            args[key] = value
        end
    end

    -- If no args after processing, return nil
    if not next(args) then
        return nil
    end

    return {
        type = "group",
        name = type(groupName) == "function" and groupName() or groupName,
        inline = inline ~= false, -- Default to inline
        order = order,
        args = args
    }
end

-- ============================ FIELD OPTIONS ============================

-- Create an option for a field
function SchemaBrowser:CreateFieldOption(fieldName, fieldInfo, order, selectionVar)
    if fieldName == "field_order" then return nil end

    -- Default to selectedField if no selection variable specified
    selectionVar = selectionVar or "selectedField"
    local currentSelection = self[selectionVar]

    local option = {
        type = "toggle",
        name = fieldName .. " (" .. SchemaUtils:FormatFieldType(fieldInfo) .. ")",
        desc = L["Click to view field details"] or "Click to view field details",
        get = function() return currentSelection == fieldName end,
        set = function(info, value)
            if value then
                self[selectionVar] = fieldName
            else
                self[selectionVar] = nil
            end
        end,
        order = order or 1
    }

    return option
end

-- Create detailed options for a field
function SchemaBrowser:CreateFieldDetailsOptions(fieldName, fieldInfo)
    local options = {
        basicInfo = {
            type = "group",
            name = L["basicInfo"] or "Basic Information",
            inline = true,
            order = 1,
            args = {
                name = {
                    type = "description",
                    name = "|cFFFFD100Name:|r " .. fieldName,
                    order = 1
                },
                type = {
                    type = "description",
                    name = "|cFFFFD100Type:|r " .. SchemaUtils:FormatFieldType(fieldInfo),
                    order = 2
                },
                label = {
                    type = "description",
                    name = "|cFFFFD100Label:|r " .. (SchemaAccessor:GetFieldLabel(messageSchema, fieldName) or "none"),
                    order = 3
                },
                id = {
                    type = "description",
                    name = "|cFFFFD100ID:|r " .. (tostring(SchemaAccessor:GetFieldId(messageSchema, fieldName) or "none")),
                    order = 4
                }
            }
        }
    }

    -- Add metadata if available (dynamic)
    -- Get message schema to access field metadata
    local messageSchema = self.selectedMessageType and SchemaAccessor:GetMessageSchema(self.selectedMessageType) or nil
    local fieldMetadata = {}
    local fieldDefault = nil  -- Extract default separately for dedicated group

    -- Step 1: Check for field-specific metadata first (highest priority)
    if messageSchema and fieldName then
        local fieldSpecificMetadata = SchemaAccessor:GetFieldMetadata(messageSchema, fieldName)
        if fieldSpecificMetadata and next(fieldSpecificMetadata) then
            -- Copy field-specific metadata (but handle defaults specially)
            for key, value in pairs(fieldSpecificMetadata) do
                if key ~= "defaults" and key ~= "default" then  -- Don't copy defaults table, we'll extract the field-specific default
                    fieldMetadata[key] = value
                end
            end
            -- Extract field-specific default (singular) if it exists
            if fieldSpecificMetadata.default ~= nil then
                fieldDefault = fieldSpecificMetadata.default
            end
        end
    end

    -- Step 2: FOLLOW THE PROTO CHAIN - If field points to a message type, get its metadata
    local referencedMessageSchema = nil
    if messageSchema and fieldName then
        local messageType = SchemaAccessor:GetFieldMessageType(messageSchema, fieldName)
        if messageType then
            referencedMessageSchema = SchemaAccessor:GetMessageSchema(messageType)
            if referencedMessageSchema then
                -- Merge referenced message type metadata (field-specific takes precedence)
                -- Use message-level getters (pass nil for fieldName to get message-level metadata)
                if not fieldMetadata.ui_label then
                    fieldMetadata.ui_label = SchemaAccessor:GetFieldUILabel(referencedMessageSchema, nil)
                end
                if not fieldMetadata.short_description then
                    fieldMetadata.short_description = SchemaAccessor:GetFieldShortDescription(referencedMessageSchema, nil)
                end
                if not fieldMetadata.full_description then
                    fieldMetadata.full_description = SchemaAccessor:GetFieldFullDescription(referencedMessageSchema, nil)
                end
                if not fieldMetadata.submenu then
                    fieldMetadata.submenu = SchemaAccessor:GetFieldSubmenu(referencedMessageSchema, nil)
                end
            end
        end
    end

    -- Step 3: Fallback to parent message-level metadata (lowest priority)
    if messageSchema and fieldName then
        -- Extract field-specific default from message-level defaults if not already set
        if fieldDefault == nil then
            -- GetFieldDefaults now returns the field-specific default value directly
            -- It checks _metadata.fields[fieldName].default first, then _metadata.defaults[fieldName]
            local fieldDefaultValue = SchemaAccessor:GetFieldDefaults(messageSchema, fieldName)
            if fieldDefaultValue ~= nil then
                fieldDefault = fieldDefaultValue
            end
        end

        -- Copy other message-level metadata (excluding defaults table and fields)
        -- Use individual getters for message-level metadata
        if not fieldMetadata.ui_label then
            fieldMetadata.ui_label = SchemaAccessor:GetFieldUILabel(messageSchema, nil)
        end
        if not fieldMetadata.short_description then
            fieldMetadata.short_description = SchemaAccessor:GetFieldShortDescription(messageSchema, nil)
        end
        if not fieldMetadata.full_description then
            fieldMetadata.full_description = SchemaAccessor:GetFieldFullDescription(messageSchema, nil)
        end
        if not fieldMetadata.submenu then
            fieldMetadata.submenu = SchemaAccessor:GetFieldSubmenu(messageSchema, nil)
        end
    end

    -- Add Default group (above UI Mapping for visibility)
    if fieldDefault ~= nil then
        -- Format the default value with enum resolution if applicable
        local defaultDisplay = self:FormatMetadataValue("default", fieldDefault, {
            messageSchema = messageSchema,
            fieldName = fieldName,
            fieldInfo = fieldInfo,
            referencedMessageSchema = referencedMessageSchema
        })

        options.default = {
            type = "group",
            name = L["default"] or "Default",
            inline = true,
            order = 1.5,
            args = {
                value = {
                    type = "description",
                    name = "|cFFFFD100Default:|r " .. defaultDisplay,
                    order = 1
                }
            }
        }
    end

    -- Add proto field name information
    -- Schema structure is definitive: proto field names are snake_case
    -- camelCase format is only used at WoWSims import/export boundaries (ASTProto.lua)
    options.uiMapping = {
        type = "group",
        name = L["uiMapping"] or "Proto Field Name",
        inline = true,
        order = 2,
        args = {
            protoName = {
                type = "description",
                name = "|cFFFFD100Proto Name:|r " .. fieldName,
                order = 1
            }
        }
    }

    -- Show metadata if we have any (excluding default, which is shown in its own group above)
    -- Remove default from metadata since it has its own dedicated group
    if fieldMetadata.default then
        fieldMetadata.default = nil
    end

    if next(fieldMetadata) then
        local metadataGroup = self:CreateMetadataGroup(
            fieldMetadata,
            L["metadata"] or "Metadata",
            3,
            true,
            {
                messageSchema = messageSchema,
                fieldName = fieldName,
                fieldInfo = fieldInfo,
                referencedMessageSchema = referencedMessageSchema  -- Add context for enum resolution
            }
        )
        if metadataGroup then
            options.metadata = metadataGroup
        end
    end

    -- Add fieldInfo.default_value if present (schema-level default, separate from _metadata.defaults)
    -- This is the proto schema default value, shown separately for clarity
    if fieldInfo.default_value then
        options.defaultValue = {
            type = "group",
            name = L["defaultValue"] or "Schema Default Value",
            inline = true,
            order = 6,
            args = {
                value = {
                    type = "description",
                    name = TableUtils and TableUtils.ToString(fieldInfo.default_value) or
                        tostring(fieldInfo.default_value),
                    order = 1,
                },
                note = {
                    type = "description",
                    name = "|cFF808080Note: This is the schema-level default. Metadata defaults (if any) are shown above in Metadata section.|r",
                    order = 2,
                    fontSize = "small"
                }
            }
        }
    end

    -- IncludeIf is now handled by the dynamic metadata display above
    -- This section is kept for backward compatibility but should be removed if metadata display works correctly

    -- Show enum values if this is an enum field
    local fieldType = messageSchema and SchemaAccessor:GetFieldType(messageSchema, fieldName) or fieldInfo.type
    local enumType = messageSchema and SchemaAccessor:GetFieldEnumType(messageSchema, fieldName) or fieldInfo.enum_type
    if fieldType == "enum" and enumType then
        options.enumValues = {
            type = "group",
            name = L["enumValues"] or "Enum Values",
            inline = true,
            order = 4,
            args = {
                values = {
                    type = "description",
                    name = SchemaUtils:FormatEnumValues(enumType),
                    order = 1
                }
            }
        }
    end

    -- Show nested fields if this is a message type
    local fieldType = messageSchema and SchemaAccessor:GetFieldType(messageSchema, fieldName) or fieldInfo.type
    if fieldType == "message" and fieldInfo.fields and next(fieldInfo.fields) then
        options.nestedFields = {
            type = "group",
            name = L["nestedFields"] or "Nested Fields",
            inline = true,
            order = 5,
            args = {}
        }

        local nestedOrder = 1

        for nestedFieldName, nestedFieldInfo in pairs(fieldInfo.fields) do
            options.nestedFields.args["nested_" .. nestedFieldName] = {
                type = "description",
                name = "|cFFFFD100" .. nestedFieldName .. ":|r " .. SchemaUtils:FormatFieldType(nestedFieldInfo),
                order = nestedOrder
            }
            nestedOrder = nestedOrder + 1
        end
    end

    -- Add Go Backend Metadata if available (check both spell and aura metadata)
    local spellMetadata = SchemaAccessor:GetFieldSpellMetadata(fieldInfo)
    local auraMetadata = SchemaAccessor:GetFieldAuraMetadata(fieldInfo)
    local goMetadataEntries = {}

    -- Collect spell metadata entries (helpers already return arrays)
    if spellMetadata and #spellMetadata > 0 then
        for _, entry in ipairs(spellMetadata) do
            tinsert(goMetadataEntries, entry)
        end
    end

    -- Collect aura metadata entries (helpers already return arrays)
    if auraMetadata and #auraMetadata > 0 then
        for _, entry in ipairs(auraMetadata) do
            tinsert(goMetadataEntries, entry)
        end
    end

    if #goMetadataEntries > 0 then
        options.goMetadataGroup = {
            type = "group",
            name = L["goMetadataGroup"] or "Go Backend Registrations",
            inline = false, -- Display as a full-width section
            order = 8,      -- After includeIf, before enums/nested
            args = {}
        }

        for i, regData in ipairs(goMetadataEntries) do
            local regName = regData.label or regData.function_name or ("Registration " .. i)
            local regOrder = i * 10

            options.goMetadataGroup.args["reg_header_" .. i] = {
                type = "header",
                name = regName,
                order = regOrder
            }

            local regArgs = {}
            local argOrder = 1

            local simpleTextFields = {
                { key = 'source_file',               label = 'Source File' },
                { key = 'registration_type',         label = 'Registration Type' },
                { key = 'function_name',             label = 'Function Name' },
                { key = 'spell_id',                  label = 'Spell ID' },
                { key = 'tag',                       label = 'Tag' },
                { key = 'flags',                     label = 'Flags' },
                { key = 'class_spell_mask',          label = 'ClassSpellMask' },
                { key = 'spell_school',              label = 'SpellSchool' },
                { key = 'proc_mask',                 label = 'ProcMask' },
                { key = 'damage_multiplier',         label = 'DamageMultiplier' },
                { key = 'damage_multiplier_additive', label = 'DamageMultiplierAdditive' },
                { key = 'crit_multiplier',           label = 'CritMultiplier' },
                { key = 'threat_multiplier',         label = 'ThreatMultiplier' },
                { key = 'related_self_buff',          label = 'RelatedSelfBuff' },
                { key = 'ignore_haste',              label = 'IgnoreHaste' }
            }

            for _, field in ipairs(simpleTextFields) do
                -- The key in regData is snake_case, e.g., 'source_file'
                if regData[field.key] then
                    regArgs[field.key .. "_" .. i] = {
                        type = "description",
                        name = "|cFFFFD100" ..
                            field.label .. ":|r " .. tostring(regData[field.key]),
                        order = argOrder
                    }
                    argOrder = argOrder + 1
                end
            end

            -- Durations/Cooldowns
            if regData.cooldown then
                regArgs["cd_" .. i] = {
                    type = "description",
                    name = "|cFFFFD100Cooldown:|r " ..
                        regData.cooldown.raw .. " (" .. (regData.cooldown.seconds or "?") .. "s)",
                    order = argOrder
                }
                argOrder = argOrder + 1
            end
            if regData.aura_duration then
                regArgs["auraDur_" .. i] = {
                    type = "description",
                    name = "|cFFFFD100Aura Duration:|r " ..
                        regData.aura_duration.raw .. " (" .. (regData.aura_duration.seconds or "?") .. "s)",
                    order = argOrder
                }
                argOrder = argOrder + 1
            end

            -- Handlers (OnGain, OnExpire, etc.)
            local handlerFields = { 'OnGain', 'OnExpire', 'ApplyEffects', 'OnReset', 'OnSpellHitDealt', 'OnSpellHitTaken' }
            for _, handlerName in ipairs(handlerFields) do
                if regData[handlerName] then
                    regArgs[handlerName .. "_group_" .. i] = {
                        type = "group",
                        name = "|cFFFFD100" .. handlerName .. " Handler:|r",
                        inline = true,
                        order = argOrder,
                        args = {
                            code = {
                                type = "description",
                                name = regData[handlerName],
                                fontSize = "small",
                                width = "full"
                            }
                        }
                    }
                    argOrder = argOrder + 1
                end
            end

            options.goMetadataGroup.args["reg_group_" .. i] = {
                type = "group",
                name = "",
                inline = true,
                order = regOrder + 1,
                args = regArgs
            }
        end
    end

    return options
end

-- Generate options for actions
function SchemaBrowser:GetActionsOptions()
    local actionTypes = self:GetAllActionTypes()
    local args = {
        header = {
            type = "header",
            name = L["Action Types"] or "Action Types",
            order = 1
        },
        description = {
            type = "description",
            name = L["Browse available action types and their fields."] or "Browse available action types and their fields.",
            order = 2
        },
        filterSettings = {
            type = "group",
            name = L["filterSettings"] or "Filter Settings",
            inline = true,
            order = 5,
            args = {
                filterBySpec = {
                    type = "toggle",
                    name = L["filterBySpec"] or "Filter by Spec",
                    desc = L["filterBySpecDesc"] or "When enabled, only shows actions applicable to your current spec",
                    width = "full",
                    get = function() return self.ViewSettings.filterBySpec end,
                    set = function(_, value)
                        self.ViewSettings.filterBySpec = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    order = 1,
                },
                filterByPrepull = {
                    type = "toggle",
                    name = L["filterByPrepull"] or "Filter by Prepull",
                    desc = L["filterByPrepullDesc"] or "When enabled, only shows actions applicable to current prepull context",
                    width = "full",
                    get = function() return self.ViewSettings.filterByPrepull end,
                    set = function(_, value)
                        self.ViewSettings.filterByPrepull = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    order = 2,
                },
                contextSelect = {
                    type = "select",
                    name = L["contextSelect"] or "Current Context",
                    desc = L["contextSelectDesc"] or "Select the current context for filtering",
                    values = {
                        [false] = L["contextCombat"] or "Combat",
                        [true] = L["contextPrepull"] or "Prepull"
                    },
                    get = function() return self.ViewSettings.currentPrepullContext end,
                    set = function(_, value)
                        self.ViewSettings.currentPrepullContext = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    disabled = function() return not self.ViewSettings.filterByPrepull end,
                    order = 3,
                },
                currentSpecInfo = {
                    type = "description",
                    name = function()
                        if not self.ViewSettings.filterBySpec then
                            return "Filtering by spec is disabled"
                        end
                        local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0
                        local specName = (SpecCompat and SpecCompat:GetSpecName()) or "Unknown"
                        return string.format("Currently filtering for Spec: %s (Index: %d)", specName, specIndex)
                    end,
                    order = 4,
                },
            }
        },
        actionTypeSelect = {
            type = "select",
            name = L["actionTypeSelect"] or "Action Type",
            desc = L["actionTypeSelectDesc"] or "Select an action type to view its fields",
            values = function()
                local values = {}
                local filteredTypes = {}
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    for _, actionType in ipairs(actionTypes) do
                        if self:ShouldShowInSchemaViewer("Actions", actionType) then
                            table.insert(filteredTypes, actionType)
                        end
                    end
                else
                    filteredTypes = actionTypes
                end
                for _, actionType in ipairs(filteredTypes) do
                    values[actionType] = actionType
                end
                return values
            end,
            get = function(info)
                if not self.selectedActionType and #actionTypes > 0 then
                    self.selectedActionType = actionTypes[1]
                    self:Debug("Default action type selected: " .. self.selectedActionType)
                end
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    if not self:ShouldShowInSchemaViewer("Actions", self.selectedActionType) then
                        for _, actionType in ipairs(actionTypes) do
                            if self:ShouldShowInSchemaViewer("Actions", actionType) then
                                self.selectedActionType = actionType
                                break
                            end
                        end
                    end
                end
                return self.selectedActionType
            end,
            set = function(info, value)
                self:Debug("Action type selected: " .. value)
                self.selectedActionType = value
                self.selectedActionField = nil
            end,
            order = 10
        }
    }
    -- ... existing code for metadataGroup, fieldListGroup, fieldsGroup, etc. ...
    if self.selectedActionType then
        self:Debug("Showing fields for action type: " .. self.selectedActionType)
        -- Get action metadata dynamically
        local metadata = SchemaAccessor:GetMetadataByIdentifier(self.selectedActionType, nil)
        if metadata then
            -- Convert metadata record to _metadata format for display
            -- SchemaAccessor returns snake_case keys, so we can copy directly
            local displayMetadata = {}
            if metadata.ui_label then
                displayMetadata.ui_label = metadata.ui_label
            end
            if metadata.short_description then
                displayMetadata.short_description = metadata.short_description
            end
            if metadata.full_description then
                displayMetadata.full_description = metadata.full_description
            end
            if metadata.submenu then
                displayMetadata.submenu = metadata.submenu
            end
            if metadata.include_if then
                displayMetadata.include_if = metadata.include_if
            end
            if metadata.defaults then
                displayMetadata.defaults = metadata.defaults
            end
            if metadata.deprecated ~= nil then
                displayMetadata.deprecated = metadata.deprecated
            end

            -- Get message schema for context
            local protoName = metadata.protoName
            local messageSchema = protoName and SchemaAccessor:GetMessageSchema(protoName) or nil

            local metadataGroup = self:CreateMetadataGroup(
                displayMetadata,
                L["metadataGroup"] or "Metadata",
                15,
                true,
                { messageSchema = messageSchema, actionType = self.selectedActionType }
            )
            if metadataGroup then
                args.metadataGroup = metadataGroup
            end
        end
        -- ... rest of the logic for fieldListGroup, fieldsGroup, etc. ...
        -- Add a field list as a separate section for better visibility
        local fields, fieldOrder = SchemaAccessor:GetFields("APLAction", self.selectedActionType)

        args.fieldListGroup = {
            type = "group",
            name = L["fieldListGroup"] or "Field List",
            inline = true,
            order = 16,
            args = {
                fieldList = {
                    type = "description",
                    name = function()
                        if not fields or not next(fields) then
                            return "No fields available"
                        end

                        local result = ""
                        for fieldName, fieldInfo in pairs(fields) do
                            if fieldName ~= "field_order" then
                                result = result ..
                                    "|cFFFFD100" .. fieldName .. "|r: " .. SchemaUtils:FormatFieldType(fieldInfo) .. "\n"
                            end
                        end
                        return result
                    end,
                    order = 1,
                    fontSize = "medium",
                }
            }
        }

        args.fieldsGroup = {
            type = "group",
            name = L["fieldsGroup"] or "Fields",
            inline = true,
            order = 20,
            args = {}
        }

        if not fields then
            self:Debug("No fields found for action type: " .. self.selectedActionType)
            args.fieldsGroup.args.noFields = {
                type = "description",
                name = L["noFields"] or "No fields found for this action type.",
                order = 1
            }
        elseif not next(fields) then
            self:Debug("Empty fields table for action type: " .. self.selectedActionType)
            args.fieldsGroup.args.noFields = {
                type = "description",
                name = L["noFields"] or "This action type exists but has no fields.",
                order = 1
            }
        else
            self:Debug("Found " .. SchemaUtils:TableCount(fields) .. " fields for " .. self.selectedActionType)

            -- Add the field order information
            args.fieldsGroup.args.fieldOrderHeader = {
                type = "header",
                name = L["fieldOrderHeader"] or "Field Order",
                order = 1
            }

            args.fieldsGroup.args.fieldOrder = {
                type = "description",
                name = fieldOrder and #fieldOrder > 0 and table.concat(fieldOrder, ", ") or "No field order specified",
                order = 2
            }

            -- Add each field
            args.fieldsGroup.args.fieldsHeader = {
                type = "header",
                name = L["fieldsHeader"] or "Field Definitions",
                order = 10
            }

            -- Process field list with priority for order fields
            local processedFields = {}
            local currentOrder = 11

            -- First process fields in order
            if fieldOrder and #fieldOrder > 0 then
                for _, fieldName in ipairs(fieldOrder) do
                    if fields[fieldName] and not processedFields[fieldName] and fieldName ~= "field_order" then
                        args.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName,
                            fields[fieldName], currentOrder, "selectedActionField")
                        currentOrder = currentOrder + 1
                        processedFields[fieldName] = true
                    end
                end
            end

            -- Then process any remaining fields
            for fieldName, fieldInfo in pairs(fields) do
                if not processedFields[fieldName] and fieldName ~= "field_order" then
                    args.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fieldInfo,
                        currentOrder, "selectedActionField")
                    currentOrder = currentOrder + 1
                end
            end

            -- Field details section for selected field
            if self.selectedActionField and fields[self.selectedActionField] then
                args.fieldDetails = {
                    type = "group",
                    name = "Field Details: " .. self.selectedActionField,
                    inline = true,
                    order = 30,
                    args = self:CreateFieldDetailsOptions(self.selectedActionField, fields[self.selectedActionField])
                }
            end
        end
    end
    return {
        type = "group",
        name = L["Actions"] or "Actions",
        order = 20,
        childGroups = "tab",
        args = args
    }
end

-- Generate options for values
function SchemaBrowser:GetValuesOptions()
    local valueTypes = self:GetAllValueTypes()
    local args = {
        header = {
            type = "header",
            name = L["Value Types"] or "Value Types",
            order = 1
        },
        description = {
            type = "description",
            name = L["Browse available value types and their fields."] or "Browse available value types and their fields.",
            order = 2
        },
        filterSettings = {
            type = "group",
            name = L["filterSettings"] or "Filter Settings",
            inline = true,
            order = 5,
            args = {
                filterBySpec = {
                    type = "toggle",
                    name = L["filterBySpec"] or "Filter by Spec",
                    desc = L["When enabled, only shows values applicable to your current spec"] or "When enabled, only shows values applicable to your current spec",
                    width = "full",
                    get = function() return self.ViewSettings.filterBySpec end,
                    set = function(_, value)
                        self.ViewSettings.filterBySpec = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    order = 1,
                },
                filterByPrepull = {
                    type = "toggle",
                    name = L["filterByPrepull"] or "Filter by Context",
                    desc = L["filterByPrepullDesc"] or "When enabled, only shows values applicable to current context (prepull or combat)",
                    width = "full",
                    get = function() return self.ViewSettings.filterByPrepull end,
                    set = function(_, value)
                        self.ViewSettings.filterByPrepull = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    order = 2,
                },
                contextSelect = {
                    type = "select",
                    name = L["currentContext"] or "Current Context",
                    desc = L["contextSelectDesc"] or "Select the current context for filtering",
                    values = {
                        [false] = L["contextCombat"] or "Combat",
                        [true] = L["contextPrepull"] or "Prepull"
                    },
                    get = function() return self.ViewSettings.currentPrepullContext end,
                    set = function(_, value)
                        self.ViewSettings.currentPrepullContext = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    disabled = function() return not self.ViewSettings.filterByPrepull end,
                    order = 3,
                },
                currentSpecInfo = {
                    type = "description",
                    name = function()
                        if not self.ViewSettings.filterBySpec then
                            return "Filtering by spec is disabled"
                        end
                        local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0
                        local specName = (SpecCompat and SpecCompat:GetSpecName()) or "Unknown"
                        return string.format("Currently filtering for Spec: %s (Index: %d)", specName, specIndex)
                    end,
                    order = 4,
                },
            }
        },
        valueTypeSelect = {
            type = "select",
            name = L["valueTypeSelect"] or "Value Type",
            desc = L["valueTypeSelectDesc"] or "Select a value type to view its fields",
            values = function()
                local values = {}
                local filteredTypes = {}
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    for _, valueType in ipairs(valueTypes) do
                        if self:ShouldShowInSchemaViewer("Values", valueType) then
                            table.insert(filteredTypes, valueType)
                        end
                    end
                else
                    filteredTypes = valueTypes
                end
                for _, valueType in ipairs(filteredTypes) do
                    values[valueType] = valueType
                end
                return values
            end,
            get = function(info)
                if not self.selectedValueType and #valueTypes > 0 then
                    self.selectedValueType = valueTypes[1]
                    self:Debug("Default value type selected: " .. self.selectedValueType)
                end
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    if not self:ShouldShowInSchemaViewer("Values", self.selectedValueType) then
                        for _, valueType in ipairs(valueTypes) do
                            if self:ShouldShowInSchemaViewer("Values", valueType) then
                                self.selectedValueType = valueType
                                break
                            end
                        end
                    end
                end
                return self.selectedValueType
            end,
            set = function(info, value)
                self:Debug("Value type selected: " .. value)
                self.selectedValueType = value
                self.selectedValueField = nil
            end,
            order = 10
        }
    }
    -- ... existing code for metadataGroup, fieldListGroup, fieldsGroup, etc. ...
    if self.selectedValueType then
        self:Debug("Showing fields for value type: " .. self.selectedValueType)
        -- Get value metadata dynamically
        local metadata = SchemaAccessor:GetMetadataByIdentifier(self.selectedValueType, nil)
        if metadata then
            -- Convert metadata record to _metadata format for display
            -- SchemaAccessor returns snake_case keys, so we can copy directly
            local displayMetadata = {}
            if metadata.ui_label then
                displayMetadata.ui_label = metadata.ui_label
            end
            if metadata.short_description then
                displayMetadata.short_description = metadata.short_description
            end
            if metadata.full_description then
                displayMetadata.full_description = metadata.full_description
            end
            if metadata.submenu then
                displayMetadata.submenu = metadata.submenu
            end
            if metadata.include_if then
                displayMetadata.include_if = metadata.include_if
            end
            if metadata.defaults then
                displayMetadata.defaults = metadata.defaults
            end
            if metadata.deprecated ~= nil then
                displayMetadata.deprecated = metadata.deprecated
            end

            -- Get message schema for context
            local protoName = metadata.protoName
            local messageSchema = protoName and SchemaAccessor:GetMessageSchema(protoName) or nil

            local metadataGroup = self:CreateMetadataGroup(
                displayMetadata,
                L["metadataGroup"] or "Metadata",
                15,
                true,
                { messageSchema = messageSchema, valueType = self.selectedValueType }
            )
            if metadataGroup then
                args.metadataGroup = metadataGroup
            end
        end
        -- ... rest of the logic for fieldListGroup, fieldsGroup, etc. ...
        -- Add a field list as a separate section for better visibility
        local fields, fieldOrder = SchemaAccessor:GetFields("APLValue", self.selectedValueType)

        args.fieldListGroup = {
            type = "group",
            name = L["fieldListGroup"] or "Field List",
            inline = true,
            order = 16,
            args = {
                fieldList = {
                    type = "description",
                    name = function()
                        if not fields or not next(fields) then
                            return "No fields available"
                        end

                        local result = ""
                        for fieldName, fieldInfo in pairs(fields) do
                            if fieldName ~= "field_order" then
                                result = result ..
                                    "|cFFFFD100" .. fieldName .. "|r: " .. SchemaUtils:FormatFieldType(fieldInfo) .. "\n"
                            end
                        end
                        return result
                    end,
                    order = 1,
                    fontSize = "medium",
                }
            }
        }

        args.fieldsGroup = {
            type = "group",
            name = L["fieldsGroup"] or "Fields",
            inline = true,
            order = 20,
            args = {}
        }

        if not fields then
            self:Debug("No fields found for value type: " .. self.selectedValueType)
            args.fieldsGroup.args.noFields = {
                type = "description",
                name = L["No fields found for this value type."] or "No fields found for this value type.",
                order = 1
            }
        elseif not next(fields) then
            self:Debug("Empty fields table for value type: " .. self.selectedValueType)
            args.fieldsGroup.args.noFields = {
                type = "description",
                name = L["This value type exists but has no fields."] or "This value type exists but has no fields.",
                order = 1
            }
        else
            self:Debug("Found " .. SchemaUtils:TableCount(fields) .. " fields for " .. self.selectedValueType)

            -- Add the field order information
            args.fieldsGroup.args.fieldOrderHeader = {
                type = "header",
                name = L["fieldOrderHeader"] or "Field Order",
                order = 1
            }

            args.fieldsGroup.args.fieldOrder = {
                type = "description",
                name = fieldOrder and #fieldOrder > 0 and table.concat(fieldOrder, ", ") or "No field order specified",
                order = 2
            }

            -- Add each field
            args.fieldsGroup.args.fieldsHeader = {
                type = "header",
                name = L["fieldsHeader"] or "Field Definitions",
                order = 10
            }

            -- Process field list with priority for order fields
            local processedFields = {}
            local currentOrder = 11

            -- First process fields in order
            if fieldOrder and #fieldOrder > 0 then
                for _, fieldName in ipairs(fieldOrder) do
                    if fields[fieldName] and not processedFields[fieldName] and fieldName ~= "field_order" then
                        args.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName,
                            fields[fieldName], currentOrder, "selectedValueField")
                        currentOrder = currentOrder + 1
                        processedFields[fieldName] = true
                    end
                end
            end

            -- Then process any remaining fields
            for fieldName, fieldInfo in pairs(fields) do
                if not processedFields[fieldName] and fieldName ~= "field_order" then
                    args.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fieldInfo,
                        currentOrder, "selectedValueField")
                    currentOrder = currentOrder + 1
                end
            end

            -- Field details section for selected field
            if self.selectedValueField and fields[self.selectedValueField] then
                args.fieldDetails = {
                    type = "group",
                    name = "Field Details: " .. self.selectedValueField,
                    inline = true,
                    order = 30,
                    args = self:CreateFieldDetailsOptions(self.selectedValueField, fields[self.selectedValueField])
                }
            end
        end
    end
    return {
        type = "group",
        name = L["Values"] or "Values",
        order = 30,
        childGroups = "tab",
        args = args
    }
end

-- Get options for enums
function SchemaBrowser:GetEnumsOptions()
    local schema = SchemaAccessor:GetSchemaData()
    if not schema or not schema.enums then
        return {
            type = "group",
            name = L["Enums"] or "Enums",
            order = 40,
            args = {
                noEnums = {
                    type = "description",
                    name = L["noEnums"] or "No enums found in schema.",
                    order = 1
                }
            }
        }
    end

    local enumNames = {}
    local nestedEnums = {}
    local standaloneEnums = {}

    -- Categorize enums
    for enumName in pairs(schema.enums) do
        if enumName:find("%.") then
            table.insert(nestedEnums, enumName)
        else
            table.insert(standaloneEnums, enumName)
        end
        table.insert(enumNames, enumName)
    end

    table.sort(enumNames)
    table.sort(nestedEnums)
    table.sort(standaloneEnums)

    local args = {
        header = {
            type = "header",
            name = L["Enum Types"] or "Enum Types",
            order = 1
        },
        description = {
            type = "description",
            name = L["Browse available enum types and their values."] or "Browse available enum types and their values.",
            order = 2
        },
        searchGroup = {
            type = "group",
            name = L["searchGroup"] or "Search Enum Values",
            inline = true,
            order = 5,
            args = {
                searchTerm = {
                    type = "input",
                    name = L["searchTerm"] or "Search Term",
                    desc = L["searchTermDesc"] or "Search for values across all enum types",
                    get = function() return self.enumSearchTerm or "" end,
                    set = function(_, value)
                        self.enumSearchTerm = value
                    end,
                    order = 1,
                    width = "full"
                },
                searchResults = {
                    type = "description",
                    name = function()
                        if not self.enumSearchTerm or self.enumSearchTerm == "" then
                            return "Enter a search term above to find enum values"
                        end

                        local results = Types:SearchEnumValues(self.enumSearchTerm)
                        if not next(results) then
                            return "No matches found for: " .. self.enumSearchTerm
                        end
                        local output = "Search Results for: " .. self.enumSearchTerm .. "\n\n"
                        for typeName, values in pairs(results) do
                            output = output .. "|cFFFFD100" .. typeName .. ":|r\n"
                            for valueName, valueId in pairs(values) do
                                output = output .. "  " .. valueName .. " = " .. valueId .. "\n"
                            end
                            output = output .. "\n"
                        end
                        return output
                    end,
                    order = 2,
                    fontSize = "medium",
                    width = "full"
                }
            }
        },
        enumTypeSelect = {
            type = "select",
            name = L["enumTypeSelect"] or "Enum Type",
            desc = L["enumTypeSelectDesc"] or "Select an enum type to view its values",
            values = function()
                local values = {}
                for _, enumName in ipairs(enumNames) do
                    values[enumName] = enumName
                end
                return values
            end,
            get = function(info)
                if not self.selectedEnumType and #enumNames > 0 then
                    self.selectedEnumType = enumNames[1]
                    self:Debug("Default enum type selected: " .. self.selectedEnumType)
                end
                return self.selectedEnumType
            end,
            set = function(info, value)
                self:Debug("Enum type selected: " .. value)
                self.selectedEnumType = value
            end,
            order = 10
        }
    }

    -- Add enum categorization info
    if #nestedEnums > 0 or #standaloneEnums > 0 then
        args.enumCategories = {
            type = "group",
            name = L["enumCategories"] or "Enum Categories",
            inline = true,
            order = 15,
            args = {
                standaloneHeader = {
                    type = "header",
                    name = L["standaloneHeader"] or "Standalone Enums",
                    order = 1
                },
                standaloneCount = {
                    type = "description",
                    name = format("Count: %d", #standaloneEnums),
                    order = 2
                },
                nestedHeader = {
                    type = "header",
                    name = L["nestedHeader"] or "Nested Enums",
                    order = 10
                },
                nestedCount = {
                    type = "description",
                    name = format("Count: %d", #nestedEnums),
                    order = 11
                }
            }
        }
    end

    -- ... existing code for schemaValuesGroup, typesModuleGroup, aplModuleGroup, etc. ...
    if self.selectedEnumType and schema.enums[self.selectedEnumType] then
        -- ... existing code ...
        -- (copy all logic for schemaValuesGroup, typesModuleGroup, aplModuleGroup, etc. into args)
        -- ...
        args.schemaValuesGroup = {
            type = "group",
            name = L["schemaValuesGroup"] or "Schema Values",
            inline = true,
            order = 20,
            args = {
                values = {
                    type = "description",
                    name = SchemaUtils:FormatEnumValues(self.selectedEnumType),
                    order = 1
                }
            }
        }

        local aliasInfo = ""
        local typesMatchType, typesMatchKind = nil, nil
        local aplMatchType, aplMatchKind = nil, nil
        if Types then
            -- Try direct, alias, and auto-match
            local Aliases = Types.Aliases or {}
            local Normalize = Types.NormalizeTypeName or function(x) return x end
            local requested = self.selectedEnumType
            local direct = Types.Registry and Types.Registry._types and Types.Registry._types[requested] or nil
            local alias = Aliases[requested] and Types.Registry and Types.Registry._types[Aliases[requested]] or nil
            local auto = nil
            local norm = Normalize(requested)
            for regName, _ in pairs(Types.Registry and Types.Registry._types or {}) do
                if Normalize(regName) == norm then
                    auto = Types.Registry._types[regName]
                    break
                end
            end
            if direct then
                typesMatchType = direct
                typesMatchKind = "Direct"
            elseif alias then
                typesMatchType = alias
                typesMatchKind = "Alias ('" .. Aliases[requested] .. "')"
            elseif auto then
                typesMatchType = auto
                typesMatchKind = "Auto-Match ('" .. auto._name .. "')"
            end
        end
        -- Check Types module directly (no need to go through APL)
        if Types then
            local aplType = Types.Registry and Types.Registry._types and Types.Registry._types[self.selectedEnumType] or nil
            if aplType then
                aplMatchType = aplType
                aplMatchKind = "Direct"
            end
        end
        -- Types module values
        if typesMatchType then
            args.typesModuleGroup = {
                type = "group",
                name = "Types.lua Enum (" .. (typesMatchKind or "?") .. ")",
                inline = true,
                order = 30,
                args = {
                    name = {
                        type = "description",
                        name = "|cFFFFD100Name:|r " .. (typesMatchType.GetName and typesMatchType:GetName() or "?"),
                        order = 1
                    },
                    category = {
                        type = "description",
                        name = "|cFFFFD100Category:|r " ..
                            (typesMatchType.GetCategory and typesMatchType:GetCategory() or "?"),
                        order = 2
                    },
                    description = {
                        type = "description",
                        name = "|cFFFFD100Description:|r " ..
                            (typesMatchType.GetDescription and typesMatchType:GetDescription() or "?"),
                        order = 3
                    },
                    values = {
                        type = "description",
                        name = function()
                            local values = typesMatchType.GetValues and typesMatchType:GetValues() or {}
                            local result = "|cFFFFD100Values:|r\n"
                            for name, value in pairs(values) do
                                result = result .. format("%s = %s\n", name, tostring(value))
                            end
                            return result
                        end,
                        order = 4
                    }
                }
            }
        end
        -- APL module values
        if aplMatchType then
            args.aplModuleGroup = {
                type = "group",
                name = "APL Module Enum (" .. (aplMatchKind or "?") .. ")",
                inline = true,
                order = 40,
                args = {
                    name = {
                        type = "description",
                        name = "|cFFFFD100Name:|r " .. (aplMatchType.GetName and aplMatchType:GetName() or "?"),
                        order = 1
                    },
                    category = {
                        type = "description",
                        name = "|cFFFFD100Category:|r " ..
                            (aplMatchType.GetCategory and aplMatchType:GetCategory() or "?"),
                        order = 2
                    },
                    description = {
                        type = "description",
                        name = "|cFFFFD100Description:|r " ..
                            (aplMatchType.GetDescription and aplMatchType:GetDescription() or "?"),
                        order = 3
                    },
                    values = {
                        type = "description",
                        name = function()
                            local values = aplMatchType.GetValues and aplMatchType:GetValues() or {}
                            local result = "|cFFFFD100Values:|r\n"
                            for name, value in pairs(values) do
                                result = result .. format("%s = %s\n", name, tostring(value))
                            end
                            return result
                        end,
                        order = 4
                    }
                }
            }
        end
        -- Validation status
        args.validationGroup = {
            type = "group",
            name = L["validationGroup"] or "Validation Status",
            inline = true,
            order = 50,
            args = {
                status = {
                    type = "description",
                    name = function()
                        local status = "|cFFFFD100Validation Status:|r\n"
                        if typesMatchType then
                            status = status ..
                                "|cFF00FF00✓|r Types.lua: Registered (" .. (typesMatchKind or "?") .. ")\n"
                        else
                            status = status .. "|cFFFF0000✗|r Types.lua: Not Registered\n"
                        end
                        if aplMatchType then
                            status = status .. "|cFF00FF00✓|r APL Module: Registered\n"
                        else
                            status = status .. "|cFFFF0000✗|r APL Module: Not Registered\n"
                        end
                        -- Check value consistency
                        if typesMatchType and aplMatchType then
                            local typesValues = typesMatchType.GetValues and typesMatchType:GetValues() or {}
                            local aplValues = aplMatchType.GetValues and aplMatchType:GetValues() or {}
                            local consistent = true
                            for name, value in pairs(typesValues) do
                                if aplValues[name] ~= value then
                                    consistent = false
                                    break
                                end
                            end
                            if consistent then
                                status = status .. "|cFF00FF00✓|r Values: Consistent between modules\n"
                            else
                                status = status .. "|cFFFF0000✗|r Values: Inconsistent between modules\n"
                            end
                        end
                        return status
                    end,
                    order = 1
                }
            }
        }
        -- Diagnostic section for ambiguous/missing matches
        args.diagnosticsGroup = {
            type = "group",
            name = L["diagnosticsGroup"] or "Diagnostics",
            inline = true,
            order = 60,
            args = {
                info = {
                    type = "description",
                    name = function()
                        local msg = ""
                        if Types then
                            local Aliases = Types.Aliases or {}
                            local Normalize = Types.NormalizeTypeName or function(x) return x end
                            local requested = self.selectedEnumType
                            local norm = Normalize(requested)
                            local found = {}
                            for regName, _ in pairs(Types.Registry and Types.Registry._types or {}) do
                                if Normalize(regName) == norm then
                                    table.insert(found, regName)
                                end
                            end
                            if #found > 1 then
                                msg = msg ..
                                    "|cFFFFFF00Warning: Multiple auto-matches found: " ..
                                    table.concat(found, ", ") .. "|r\n"
                            elseif #found == 0 and not typesMatchType then
                                msg = msg ..
                                    "|cFFFFFF00No Types.lua match found for this enum (by direct, alias, or auto-match).|r\n"
                            end
                            if Aliases[requested] then
                                msg = msg .. "Alias used: '" .. Aliases[requested] .. "'\n"
                            end
                        end
                        return msg ~= "" and msg or "No issues detected."
                    end,
                    order = 1
                }
            }
        }
    end
    return {
        type = "group",
        name = L["Enums"] or "Enums",
        order = 40,
        childGroups = "tab",
        args = args
    }
end


-- Enum access now handled by SchemaAccessor (which delegates to Types registry)
-- Use SchemaAccessor:GetEnumValues(), SchemaAccessor:ValidateEnumValue(), SchemaAccessor:GetEnumLabel()
-- Enum metadata access: Types:GetTypeMetadata(enumName) or Types:GetType(enumName) for full type object



-- New helper method to determine if an item should be shown in schema viewer based on filter settings
--- Check if a message type should be shown based on its metadata
--- @param messageType string The message type name (e.g., "APLActionActivateAllStatBuffProcAuras")
--- @return boolean True if message type should be shown
function SchemaBrowser:ShouldShowMessageType(messageType)
    self:DebugWithCaller("ShouldShowMessageType called for: %s", messageType)
    self:DebugWithCaller("  filterBySpec=%s, filterByPrepull=%s",
        tostring(self.ViewSettings.filterBySpec),
        tostring(self.ViewSettings.filterByPrepull))

    -- If filtering is disabled, show everything
    if not self.ViewSettings.filterBySpec and not self.ViewSettings.filterByPrepull then
        self:DebugWithCaller("  No filtering enabled, returning true")
        return true
    end

    -- Get message schema and check its metadata
    local messageSchema = SchemaAccessor:GetMessageSchema(messageType)
    if not messageSchema then
        self:DebugWithCaller("  No schema found, returning true")
        return true
    end
    self:DebugWithCaller("  Schema found, has _metadata=%s", tostring((messageSchema and messageSchema._metadata) ~= nil))

    -- Get current spec and prepull context
    local specIndex = nil
    if self.ViewSettings.filterBySpec then
        if SpecCompat then
            specIndex = SpecCompat:GetCurrentSpecIndex()
        end
        self:DebugWithCaller("  Spec filtering enabled, specIndex=%s", tostring(specIndex))
        -- If spec filtering is enabled but we don't have a valid spec, show everything
        if not specIndex or specIndex == 0 then
            self:DebugWithCaller("  Invalid specIndex, returning true")
            return true
        end
    end

    local isPrepull = self.ViewSettings.filterByPrepull and self.ViewSettings.currentPrepullContext or nil
    self:DebugWithCaller("  isPrepull=%s", tostring(isPrepull))

    -- Check if it's an action or value message type and find the identifier
    local identifier = nil
    local category = nil

    if messageType:match("^APLAction") then
        category = "Actions"
        self:DebugWithCaller("  Message type is APLAction*, searching for identifier")
        -- Find the action identifier from APLAction.fields
        local schema = SchemaAccessor:GetSchemaData()
        if schema and schema.messages and schema.messages.APLAction and schema.messages.APLAction.fields then
            for actionName, fieldInfo in pairs(schema.messages.APLAction.fields) do
                if fieldInfo.message_type == messageType then
                    identifier = actionName
                    self:DebugWithCaller("  Found identifier: %s", identifier)
                    break
                end
            end
        end
        if not identifier then
            self:DebugWithCaller("  WARNING: Could not find action identifier for message type %s", messageType)
        end
    elseif messageType:match("^APLValue") then
        category = "Values"
        self:DebugWithCaller("  Message type is APLValue*, searching for identifier")
        -- Find the value identifier from APLValue.fields
        local schema = SchemaAccessor:GetSchemaData()
        if schema and schema.messages and schema.messages.APLValue and schema.messages.APLValue.fields then
            for valueName, fieldInfo in pairs(schema.messages.APLValue.fields) do
                if fieldInfo.message_type == messageType then
                    identifier = valueName
                    self:DebugWithCaller("  Found identifier: %s", identifier)
                    break
                end
            end
        end
        if not identifier then
            self:DebugWithCaller("  WARNING: Could not find value identifier for message type %s", messageType)
        end
    else
        self:DebugWithCaller("  Message type is neither APLAction* nor APLValue*")
    end

    -- If we found an identifier, use ShouldIncludeItem (which handles all the new includeIf format)
    if identifier and category then
        self:DebugWithCaller("  Calling ShouldIncludeItem(%s, %s, %s, %s)", category, identifier, tostring(isPrepull), tostring(specIndex))
        local result = SchemaAccessor:ShouldIncludeItem(category, identifier, isPrepull, specIndex)
        self:DebugWithCaller("  ShouldIncludeItem returned: %s", tostring(result))
        return result
    end

    -- For other message types or if we couldn't find identifier, check metadata directly
    local includeIf = SchemaAccessor:GetFieldIncludeIf(messageSchema, nil)
    if not includeIf then
        self:DebugWithCaller("  No _metadata or include_if, returning true (no restrictions)")
        return true
    end
    self:DebugWithCaller("  Has includeIf metadata, checking prepull/combat context")

    -- Check prepull/combat context
    if isPrepull ~= nil then
        if isPrepull and includeIf.combat_only then
            self:DebugWithCaller("  Prepull context but combat_only=true, returning false")
            return false
        end
        if not isPrepull and includeIf.prepull_only then
            self:DebugWithCaller("  Combat context but prepull_only=true, returning false")
            return false
        end
    end

    self:DebugWithCaller("  No identifier found and basic checks passed, returning true (limitation)")
    -- Default to showing if we're not sure
    return true
end

function SchemaBrowser:ShouldShowInSchemaViewer(category, typeName)
    -- If filtering is disabled, show everything
    if not self.ViewSettings.filterBySpec and not self.ViewSettings.filterByPrepull then
        return true
    end

    -- Get current spec and prepull context
    local specIndex = nil
    if self.ViewSettings.filterBySpec then
        if SpecCompat then
            specIndex = SpecCompat:GetCurrentSpecIndex()
        end
        -- If spec filtering is enabled but we don't have a valid spec, show everything
        if not specIndex or specIndex == 0 then
            self:Debug("Spec filtering enabled but no valid spec, showing all items")
            return true
        end
    end

    local isPrepull = self.ViewSettings.filterByPrepull and self.ViewSettings.currentPrepullContext or nil

    -- Check if the item should be included based on current filters (delegates to SchemaAccessor)
    if category == "Actions" then
        return SchemaAccessor:ShouldIncludeItem("Actions", typeName, isPrepull, specIndex)
    elseif category == "Values" then
        return SchemaAccessor:ShouldIncludeItem("Values", typeName, isPrepull, specIndex)
    end

    -- Default to showing if we're not sure
    return true
end


-- Public API method to set the context for filtering
function SchemaBrowser:SetFilterContext(prepullContext)
    self.ViewSettings.currentPrepullContext = prepullContext
end

-- Public API method to enable/disable filtering by spec
function SchemaBrowser:SetFilterBySpec(enabled)
    self.ViewSettings.filterBySpec = enabled
end

-- Public API method to enable/disable filtering by prepull/combat context
function SchemaBrowser:SetFilterByContext(enabled)
    self.ViewSettings.filterByPrepull = enabled
end

--- Dump message type metadata to chat for debugging
--- @param messageType string The message type name
function SchemaBrowser:DumpMessageTypeMetadata(messageType)
    if not messageType then
        self:Print("No message type specified")
        return
    end

    local messageSchema = SchemaAccessor:GetMessageSchema(messageType)
    if not messageSchema then
        self:Print(format("Message type '%s' not found", messageType))
        return
    end

    self:Print(format("=== Metadata for %s ===", messageType))

    if not messageSchema._metadata or not next(messageSchema._metadata) then
        self:Print("No metadata found for this message type")
        return
    end

    local metadata = messageSchema._metadata

    -- Collect and sort keys for consistent display
    local keys = {}
    for key in pairs(metadata) do
        tinsert(keys, key)
    end
    sort(keys)

    -- Print metadata fields using dynamic formatting
    for _, key in ipairs(keys) do
        local value = metadata[key]
        local displayName = FormatMetadataKeyName(key)
        local formattedValue = self:FormatMetadataValue(key, value, { messageSchema = messageSchema })
        self:Print(format("  %s: %s", displayName, formattedValue))
    end

    -- Also dump the full structure using /dump format
    self:Print(format("=== Full /dump format ==="))
    self:Print(format("/dump NAG:GetModule('SchemaAccessor'):GetMessageSchema('%s')._metadata", messageType))
end

-- ============================ DIAGNOSTICS ============================

--- Run diagnostics on the schema
--- Walks through all entries and validates them, collecting any issues
--- @return table Diagnostic results with counts and issues
function SchemaBrowser:RunDiagnostics()
    local results = {
        messageTypes = { checked = 0, issues = {} },
        actions = { checked = 0, issues = {} },
        values = { checked = 0, issues = {} },
        enums = { checked = 0, issues = {} },
        metadataIssues = { checked = 0, issues = {} },
        startTime = debugprofilestop(),
        endTime = nil
    }

    -- Capture warnings by temporarily overriding Warn method
    local originalWarn = SchemaAccessor.Warn
    local capturedWarnings = {}
    local categorizedWarnings = {
        actions = {
            missing_deprecated = {},
            missing_ui_label = {},
            missing_short_description = {},
            missing_full_description = {},
            other = {}
        },
        values = {
            missing_deprecated = {},
            missing_ui_label = {},
            missing_short_description = {},
            missing_full_description = {},
            no_metadata = {},
            other = {}
        },
        other = {}
    }

    SchemaAccessor.Warn = function(self, msg, ...)
        local formattedMsg = format(msg, ...)
        tinsert(capturedWarnings, formattedMsg)

        -- Parse and categorize warnings
        local category = "other"
        local warningType = "other"
        local identifier = nil
        local protoName = nil

        -- Parse action warnings: "GetMetadataByIdentifier: Missing <field> field for action 'X' (protoName: Y)"
        -- Note: deprecated field warnings are no longer generated (deprecated comes from schema directly)
        if formattedMsg:match("GetMetadataByIdentifier:") and formattedMsg:match("action") then
            category = "actions"
            identifier = formattedMsg:match("action '([^']+)'")
            protoName = formattedMsg:match("protoName: ([^)]+)")
            warningType = formattedMsg:match("Missing (%w+) field")
            if warningType then
                warningType = warningType:gsub("_", "_"):lower()
            else
                warningType = "other"
            end
        -- Parse value warnings: "GetMetadataByIdentifier: Missing <field> field for value 'X' (protoName: Y)"
        -- Note: deprecated field warnings are no longer generated (deprecated comes from schema directly)
        elseif formattedMsg:match("GetMetadataByIdentifier:") and formattedMsg:match("value") then
            category = "values"
            identifier = formattedMsg:match("value '([^']+)'")
            protoName = formattedMsg:match("protoName: ([^)]+)")

            -- Check for specific warning types
            if formattedMsg:match("Message schema '([^']+)' has no _metadata") then
                warningType = "no_metadata"
                protoName = formattedMsg:match("Message schema '([^']+)' has no _metadata")
            elseif formattedMsg:match("No _metadata found") then
                warningType = "no_metadata"
            else
                warningType = formattedMsg:match("Missing (%w+) field")
                if warningType then
                    warningType = warningType:gsub("_", "_"):lower()
                else
                    warningType = "other"
                end
            end
        end

        -- Store categorized warning
        if category ~= "other" and warningType and categorizedWarnings[category] and categorizedWarnings[category][warningType] then
            tinsert(categorizedWarnings[category][warningType], {
                identifier = identifier,
                protoName = protoName,
                message = formattedMsg
            })
        else
            tinsert(categorizedWarnings.other, {
                message = formattedMsg
            })
        end

        -- Also call original to see warnings in chat
        if originalWarn then
            originalWarn(self, msg, ...)
        end
    end

    -- Walk through all message types
    local messageTypes = SchemaAccessor:GetAllMessageTypes()
    for _, messageType in ipairs(messageTypes) do
        results.messageTypes.checked = results.messageTypes.checked + 1
        local success, err = pcall(function()
            local messageSchema = SchemaAccessor:GetMessageSchema(messageType)
            if not messageSchema then
                tinsert(results.messageTypes.issues, {
                    type = messageType,
                    issue = "Message schema not found"
                })
                return
            end

            -- Check metadata structure
            -- Use getters to access metadata (for consistency, even in diagnostics)
            local uiLabel = SchemaAccessor:GetFieldUILabel(messageSchema, nil)
            local shortDesc = SchemaAccessor:GetFieldShortDescription(messageSchema, nil)
            local fullDesc = SchemaAccessor:GetFieldFullDescription(messageSchema, nil)
            local submenu = SchemaAccessor:GetFieldSubmenu(messageSchema, nil)
            local includeIf = SchemaAccessor:GetFieldIncludeIf(messageSchema, nil)
            local defaults = SchemaAccessor:GetFieldDefaults(messageSchema, nil)

            -- Try accessing all metadata fields (using getters)
            if uiLabel then
                -- Valid
            end
            if shortDesc then
                -- Valid
            end
            if fullDesc then
                -- Valid
            end
            if submenu then
                if type(submenu) ~= "table" then
                    tinsert(results.metadataIssues.issues, {
                        type = messageType,
                        category = "messageType",
                        issue = format("submenu is not a table (type: %s)", type(submenu))
                    })
                end
            end
            if includeIf then
                if type(includeIf) ~= "table" then
                    tinsert(results.metadataIssues.issues, {
                        type = messageType,
                        category = "messageType",
                        issue = format("include_if is not a table (type: %s)", type(includeIf))
                    })
                end
            end

            -- Try to get fields
            local fields, fieldOrder = SchemaAccessor:GetFields(messageType)
            if not fields then
                tinsert(results.messageTypes.issues, {
                    type = messageType,
                    issue = "Failed to get fields"
                })
            end
        end)

        if not success then
            tinsert(results.messageTypes.issues, {
                type = messageType,
                issue = format("Error: %s", tostring(err))
            })
        end
    end

    -- Walk through all actions
    local actions = SchemaAccessor:GetAllActionsWithMetadata()
    for _, action in ipairs(actions) do
        results.actions.checked = results.actions.checked + 1
        local success, err = pcall(function()
            local metadata = SchemaAccessor:GetMetadataByIdentifier(action.name, nil)
            if not metadata then
                tinsert(results.actions.issues, {
                    type = action.name,
                    issue = "Failed to get action metadata"
                })
                return
            end

            -- Note: long_description doesn't exist in source schema - only full_description exists
        end)

        if not success then
            tinsert(results.actions.issues, {
                type = action.name,
                issue = format("Error: %s", tostring(err))
            })
        end
    end

    -- Walk through all values
    local values = SchemaAccessor:GetAllValuesWithMetadata()
    for _, value in ipairs(values) do
        results.values.checked = results.values.checked + 1
        local success, err = pcall(function()
            local metadata = SchemaAccessor:GetMetadataByIdentifier(value.name, nil)
            if not metadata then
                tinsert(results.values.issues, {
                    type = value.name,
                    issue = "Failed to get value metadata"
                })
                return
            end

            -- Note: long_description doesn't exist in source schema - only full_description exists
        end)

        if not success then
            tinsert(results.values.issues, {
                type = value.name,
                issue = format("Error: %s", tostring(err))
            })
        end
    end

    -- Walk through all enums
    local schema = SchemaAccessor:GetSchemaData()
    if schema and schema.enums then
        for enumName in pairs(schema.enums) do
            results.enums.checked = results.enums.checked + 1
            local success, err = pcall(function()
                local enumValues = SchemaAccessor:GetEnumValues(enumName)
                if not enumValues or not next(enumValues) then
                    tinsert(results.enums.issues, {
                        type = enumName,
                        issue = "No enum values found"
                    })
                end
            end)

            if not success then
                tinsert(results.enums.issues, {
                    type = enumName,
                    issue = format("Error: %s", tostring(err))
                })
            end
        end
    end

    -- Restore original Warn method
    SchemaAccessor.Warn = originalWarn

    -- Count captured warnings
    results.capturedWarnings = capturedWarnings
    results.categorizedWarnings = categorizedWarnings
    results.warningCount = #capturedWarnings

    results.endTime = debugprofilestop()
    results.duration = results.endTime - results.startTime

    return results
end

--- Generate options for diagnostics tab
function SchemaBrowser:GetDiagnosticsOptions()
    -- Initialize diagnostic results if not exists
    if not self.diagnosticResults then
        self.diagnosticResults = nil
    end

    local args = {
        header = OptionsFactory:CreateHeader(
            function() return L["diagnostics"] or "Diagnostics" end,
            { order = 1 }
        ),
        description = OptionsFactory:CreateDescription(
            L["diagnosticsDesc"] or "Run diagnostics to validate schema structure and detect malformed entries. This walks through all message types, actions, values, and enums.",
            nil,
            { order = 2 }
        ),
        runButton = {
            type = "execute",
            name = L["runDiagnostics"] or "Run Diagnostics",
            desc = L["runDiagnosticsDesc"] or "Walk through all schema entries and validate them",
            order = 10,
            func = function()
                self:Print("Running diagnostics...")
                self.diagnosticResults = self:RunDiagnostics()
                self:Print(format("Diagnostics complete in %.2f ms", self.diagnosticResults.duration))
                AceConfigRegistry:NotifyChange("NAG")
            end
        }
    }

    -- Show results if available
    if self.diagnosticResults then
        local results = self.diagnosticResults

        -- Summary
        args.summary = {
            type = "group",
            name = L["summary"] or "Summary",
            inline = true,
            order = 20,
            args = {
                duration = OptionsFactory:CreateDescription(
                    format("|cFFFFD100Duration:|r %.2f ms", results.duration),
                    nil,
                    { order = 1 }
                ),
                messageTypesChecked = OptionsFactory:CreateDescription(
                    format("|cFFFFD100Message Types:|r %d checked, %d issues", results.messageTypes.checked, #results.messageTypes.issues),
                    nil,
                    { order = 2 }
                ),
                actionsChecked = OptionsFactory:CreateDescription(
                    format("|cFFFFD100Actions:|r %d checked, %d issues", results.actions.checked, #results.actions.issues),
                    nil,
                    { order = 3 }
                ),
                valuesChecked = OptionsFactory:CreateDescription(
                    format("|cFFFFD100Values:|r %d checked, %d issues", results.values.checked, #results.values.issues),
                    nil,
                    { order = 4 }
                ),
                enumsChecked = OptionsFactory:CreateDescription(
                    format("|cFFFFD100Enums:|r %d checked, %d issues", results.enums.checked, #results.enums.issues),
                    nil,
                    { order = 5 }
                ),
                metadataIssues = OptionsFactory:CreateDescription(
                    format("|cFFFFD100Metadata Issues:|r %d found", #results.metadataIssues.issues),
                    nil,
                    { order = 6 }
                ),
                warnings = OptionsFactory:CreateDescription(
                    format("|cFFFFD100Warnings Captured:|r %d", results.warningCount),
                    nil,
                    { order = 7 }
                )
            }
        }

        -- Message Type Issues
        if #results.messageTypes.issues > 0 then
            args.messageTypeIssues = {
                type = "group",
                name = format("Message Type Issues (%d)", #results.messageTypes.issues),
                inline = false,
                order = 30,
                args = {}
            }

            for i, issue in ipairs(results.messageTypes.issues) do
                args.messageTypeIssues.args["issue_" .. i] = OptionsFactory:CreateDescription(
                    format("|cFFFF0000%s:|r %s", issue.type, issue.issue),
                    nil,
                    { order = i }
                )
            end
        end

        -- Action Issues
        if #results.actions.issues > 0 then
            args.actionIssues = {
                type = "group",
                name = format("Action Issues (%d)", #results.actions.issues),
                inline = false,
                order = 40,
                args = {}
            }

            for i, issue in ipairs(results.actions.issues) do
                args.actionIssues.args["issue_" .. i] = OptionsFactory:CreateDescription(
                    format("|cFFFF0000%s:|r %s", issue.type, issue.issue),
                    nil,
                    { order = i }
                )
            end
        end

        -- Value Issues
        if #results.values.issues > 0 then
            args.valueIssues = {
                type = "group",
                name = format("Value Issues (%d)", #results.values.issues),
                inline = false,
                order = 50,
                args = {}
            }

            for i, issue in ipairs(results.values.issues) do
                args.valueIssues.args["issue_" .. i] = OptionsFactory:CreateDescription(
                    format("|cFFFF0000%s:|r %s", issue.type, issue.issue),
                    nil,
                    { order = i }
                )
            end
        end

        -- Enum Issues
        if #results.enums.issues > 0 then
            args.enumIssues = {
                type = "group",
                name = format("Enum Issues (%d)", #results.enums.issues),
                inline = false,
                order = 60,
                args = {}
            }

            for i, issue in ipairs(results.enums.issues) do
                args.enumIssues.args["issue_" .. i] = OptionsFactory:CreateDescription(
                    format("|cFFFF0000%s:|r %s", issue.type, issue.issue),
                    nil,
                    { order = i }
                )
            end
        end

        -- Metadata Issues
        if #results.metadataIssues.issues > 0 then
            args.metadataIssuesGroup = {
                type = "group",
                name = format("Metadata Issues (%d)", #results.metadataIssues.issues),
                inline = false,
                order = 70,
                args = {}
            }

            for i, issue in ipairs(results.metadataIssues.issues) do
                args.metadataIssuesGroup.args["issue_" .. i] = OptionsFactory:CreateDescription(
                    format("|cFFFFFF00[%s] %s:|r %s", issue.category, issue.type, issue.issue),
                    nil,
                    { order = i }
                )
            end
        end

        -- Categorized Warnings (better organized display)
        if results.categorizedWarnings then
            local orderCounter = 80

            -- Action Warnings
            local actionWarnings = results.categorizedWarnings.actions
            local actionWarningCount = 0
            for _, warnings in pairs(actionWarnings) do
                actionWarningCount = actionWarningCount + #warnings
            end

            if actionWarningCount > 0 then
                args.actionWarningsGroup = {
                    type = "group",
                    name = format("Action Warnings (%d)", actionWarningCount),
                    inline = false,
                    order = orderCounter,
                    args = {}
                }
                orderCounter = orderCounter + 1

                local subOrder = 1
                for warningType, warnings in pairs(actionWarnings) do
                    if #warnings > 0 then
                        local typeLabel = warningType:gsub("_", " "):gsub("(%a)([%w_']*)", function(first, rest) return first:upper()..rest:lower() end)
                        args.actionWarningsGroup.args[warningType .. "_header"] = OptionsFactory:CreateHeader(
                            format("|cFFFFFF00%s (%d)|r", typeLabel, #warnings),
                            { order = subOrder }
                        )
                        subOrder = subOrder + 1

                        for i, warning in ipairs(warnings) do
                            local displayText = warning.identifier or warning.protoName or "Unknown"
                            if warning.protoName and warning.identifier ~= warning.protoName then
                                displayText = format("%s |cFF888888(%s)|r", warning.identifier, warning.protoName)
                            end
                            args.actionWarningsGroup.args[warningType .. "_" .. i] = OptionsFactory:CreateDescription(
                                format("  |cFFFFFF00%d.|r %s", i, displayText),
                                nil,
                                { order = subOrder, fontSize = "small" }
                            )
                            subOrder = subOrder + 1
                        end
                    end
                end
            end

            -- Value Warnings
            local valueWarnings = results.categorizedWarnings.values
            local valueWarningCount = 0
            for _, warnings in pairs(valueWarnings) do
                valueWarningCount = valueWarningCount + #warnings
            end

            if valueWarningCount > 0 then
                args.valueWarningsGroup = {
                    type = "group",
                    name = format("Value Warnings (%d)", valueWarningCount),
                    inline = false,
                    order = orderCounter,
                    args = {}
                }
                orderCounter = orderCounter + 1

                local subOrder = 1
                for warningType, warnings in pairs(valueWarnings) do
                    if #warnings > 0 then
                        local typeLabel = warningType:gsub("_", " "):gsub("(%a)([%w_']*)", function(first, rest) return first:upper()..rest:lower() end)
                        args.valueWarningsGroup.args[warningType .. "_header"] = OptionsFactory:CreateHeader(
                            format("|cFFFFFF00%s (%d)|r", typeLabel, #warnings),
                            { order = subOrder }
                        )
                        subOrder = subOrder + 1

                        for i, warning in ipairs(warnings) do
                            local displayText = warning.identifier or warning.protoName or "Unknown"
                            if warning.protoName and warning.identifier and warning.identifier ~= warning.protoName then
                                displayText = format("%s |cFF888888(%s)|r", warning.identifier, warning.protoName)
                            elseif warning.protoName and not warning.identifier then
                                displayText = format("|cFF888888%s|r", warning.protoName)
                            end
                            args.valueWarningsGroup.args[warningType .. "_" .. i] = OptionsFactory:CreateDescription(
                                format("  |cFFFFFF00%d.|r %s", i, displayText),
                                nil,
                                { order = subOrder, fontSize = "small" }
                            )
                            subOrder = subOrder + 1
                        end
                    end
                end
            end

            -- Other Warnings (fallback for unparsed warnings)
            if #results.categorizedWarnings.other > 0 then
                args.otherWarningsGroup = {
                    type = "group",
                    name = format("Other Warnings (%d)", #results.categorizedWarnings.other),
                    inline = false,
                    order = orderCounter,
                    args = {}
                }

                for i, warning in ipairs(results.categorizedWarnings.other) do
                    args.otherWarningsGroup.args["warning_" .. i] = OptionsFactory:CreateDescription(
                        format("|cFFFFFF00%d.|r %s", i, warning.message or tostring(warning)),
                        nil,
                        { order = i, fontSize = "small" }
                    )
                end
            end
        end

        -- Raw Captured Warnings (fallback, collapsed by default)
        if #results.capturedWarnings > 0 then
            args.rawWarningsGroup = {
                type = "group",
                name = format("Raw Warnings (%d)", #results.capturedWarnings),
                inline = false,
                order = 100,
                args = {}
            }

            for i, warning in ipairs(results.capturedWarnings) do
                args.rawWarningsGroup.args["warning_" .. i] = OptionsFactory:CreateDescription(
                    format("|cFF888888%d.|r %s", i, warning),
                    nil,
                    { order = i, fontSize = "small" }
                )
            end
        end
    end

    return {
        type = "group",
        name = L["diagnostics"] or "Diagnostics",
        order = 50,
        childGroups = "tab",
        args = args
    }
end



