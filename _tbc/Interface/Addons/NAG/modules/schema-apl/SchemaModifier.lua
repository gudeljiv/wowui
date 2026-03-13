--- @module "NAG.SchemaModifier"
--- Provides a system for modifying and validating the NAG schema at load time.
---
--- This module allows NAG to augment, map, and modify WoWSims defaults that would
--- be in the Schema, providing a flexible way to customize APL functionality while
--- maintaining compatibility.
---
--- ARCHITECTURE:
--- - SchemaModifier is the SINGLE source of truth for schema modifications
--- - SchemaAccessor loads the base schema and provides access to the final schema
--- - SchemaModifier applies modifications and updates SchemaAccessor's schema data
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

--- @type SchemaUtils
--- @type SchemaAccessor
--- @type SchemaModifications
--- @type Types
local SchemaUtils, SchemaAccessor, SchemaModifications, Types


local Version = ns.Version
local TableUtils = ns.TableUtils

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs (WoW optimized where available)
local format = string.format



local strmatch = strmatch
local strsplit = strsplit

local tinsert = tinsert
local tremove = tremove
local tContains = tContains

local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring

local function IsStatTypeField(fieldName)
    if not fieldName then
        return false
    end
    if fieldName == "stat_type" or fieldName == "statType" then
        return true
    end
    if strmatch(fieldName, "^stat_type%d+$") or strmatch(fieldName, "^statType%d+$") then
        return true
    end
    return false
end

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class SchemaModifier:CoreModule
local SchemaModifier = NAG:CreateModule("SchemaModifier", nil, {
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.FEATURES
    },

    -- Automatic message registration
    messageHandlers = {
        ["NAG_VERSION_DATA_SELECTED"] = true
    }
})
local module = SchemaModifier
ns.SchemaModifier = SchemaModifier

-- Initialize module properties
SchemaModifier.modifications = {}
SchemaModifier.initialized = false
SchemaModifier.schemaModifications = {} -- Will be loaded from SchemaModifications


-- ~~~~~~~~~~ SCHEMA MODIFICATIONS CONFIGURATION ~~~~~~~~~~

--- Load schema modifications from SchemaModifications module
--- This ensures we have access to both global and version-specific modifications
function SchemaModifier:LoadSchemaModifications()
    local SchemaModifications = NAG:GetModule("SchemaModifications")
        -- Load all modifications (global + version-specific for current expansion)
    self.schemaModifications = SchemaModifications:GetAllModifications()

    if self.debug then
        local debugInfo = SchemaModifications:GetDebugInfo()
        self:Debug("Loaded schema modifications:")
        self:Debug("  Current Expansion: %s", debugInfo.currentExpansion)
        self:Debug("  Global Modifications: %d", debugInfo.globalCount)
        self:Debug("  Version-Specific Modifications: %d", debugInfo.versionSpecificCount)
        self:Debug("  Total Modifications: %d", debugInfo.totalCount)
    end

    return true
end

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~

function SchemaModifier:ModuleInitialize()
    SchemaUtils = NAG:GetModule("SchemaUtils")
    SchemaAccessor = NAG:GetModule("SchemaAccessor")
    SchemaModifications = NAG:GetModule("SchemaModifications")
    Types = NAG:GetModule("Types")
    local startTime = debugprofilestop()

    -- Load schema modifications from SchemaModifications
    if not self:LoadSchemaModifications() then
        self:Error("Failed to load schema modifications")
        return
    end

        -- Wait for DataLoader to process custom handlers first
    -- Message registration is now handled automatically via messageHandlers

    local endTime = debugprofilestop()
    if self.debug then self:Debug("SchemaModifier initialization took %.2f ms", endTime - startTime) end
end

--- Called when DataLoader has finished processing version data
--- This ensures we load custom handlers after DataLoader has flattened the structure
function SchemaModifier:NAG_VERSION_DATA_SELECTED(message)
    self:Debug("DataLoader complete, now applying schema modifications")

    -- Wait a frame to ensure SchemaAccessor is fully loaded
    self:ApplySchemaModifications()

    -- Initialize validation system
    self:InitializeValidationSystem()

    self.initialized = true

    self:Debug("SchemaModifier fully initialized")
end

-- ~~~~~~~~~~ SCHEMA MODIFICATION ENGINE ~~~~~~~~~~

--- Apply all configured schema modifications
--- Works directly on SchemaAccessor.schemaData (single source of truth)
--- Creates working copy if needed, then applies all modifications in-place
function SchemaModifier:ApplySchemaModifications()
    self:Info("ApplySchemaModifications: Applying schema modifications")

    -- Get the BASE schema data directly from ns.protoSchema (not from SchemaAccessor which may be modified)
    -- This ensures we always start with the original, unmodified schema
    local expansionKey = Version:GetExpansion()
    if not expansionKey then
        self:Warn("ApplySchemaModifications: Could not determine expansion key for schema modifications")
        self:Error("Could not determine expansion key for schema modifications")
        return false
    end

    if not ns.protoSchema or not ns.protoSchema[expansionKey] then
        self:Warn("ApplySchemaModifications: No base schema found for expansion '%s'",
            expansionKey or "nil")
        self:Error("No base schema found for expansion: %s", expansionKey)
        return false
    end

    self:Info("ApplySchemaModifications: Base schema loaded for expansion '%s'", expansionKey)

    -- Get the original base schema directly from ns.protoSchema (before any modifications)
    local baseSchemaData = ns.protoSchema[expansionKey]

    -- Ensure SchemaAccessor has a working copy (never direct reference to ns.protoSchema)
    -- Create working copy if SchemaAccessor doesn't have one or has direct reference
    if not SchemaAccessor or not SchemaAccessor.schemaData or
       SchemaAccessor.schemaData == ns.protoSchema[expansionKey] then
        if not SchemaAccessor then
            self:Error("SchemaAccessor module not available")
            return false
        end
        SchemaAccessor.schemaData = self:DeepCopySchema(baseSchemaData)
        SchemaAccessor.loaded = true
    end

    -- Work directly on SchemaAccessor.schemaData (single source of truth)
    local workingSchema = SchemaAccessor.schemaData

    -- Apply each modification
    -- Pass the original base schema so incremental/field removal modifications can access it
    for messageType, modification in pairs(self.schemaModifications) do
        -- Check if this is an enum modification (enums are stored separately from messages)
        if workingSchema.enums and workingSchema.enums[messageType] then
            -- Apply enum normalization metadata
            self:ApplyEnumModification(messageType, modification)
        else
            -- Apply message type modification (pass base schema for incremental/field removal)
            self:ApplyModification(messageType, modification, baseSchemaData)
        end
    end

    self:NormalizeStatTypeFields()

    -- Update field_order arrays to include new custom handlers
    self:UpdateFieldOrderArrays()

    self:Info("ApplySchemaModifications: Applied %d schema modifications successfully",
        TableUtils.Size(self.schemaModifications))

    -- Canonical schema handoff: replace active schema through accessor API before broadcasting readiness.
    if SchemaAccessor and SchemaAccessor.SetSchema then
        SchemaAccessor:SetSchema(workingSchema)
    else
        self:Warn("ApplySchemaModifications: SchemaAccessor:SetSchema unavailable, using direct schema reference")
    end

    -- Notify any listeners (like SchemaValidator) that modifications are complete
    -- Use message system to avoid circular dependencies
    NAG:SendMessage("NAG_SCHEMA_MODIFICATIONS_COMPLETE", workingSchema)

    -- Import enum types from working schema immediately after schema update
    if Types and Types.ImportTypesFromSchema then
        local typesStart = debugprofilestop()
        local count = Types:ImportTypesFromSchema(workingSchema, true) -- Skip already registered types
        local typesEnd = debugprofilestop()
        if self.debug then
            self:Debug("Imported %d enum types from working schema in %.2f ms", count or 0, typesEnd - typesStart)
        end
    else
        if self.debug then
            self:Debug("Types module not available or missing ImportTypesFromSchema method")
        end
    end

    self:Debug("Applied %d schema modifications", TableUtils.Size(self.schemaModifications))
    return true
end

function SchemaModifier:NormalizeStatTypeFields()
    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema or not workingSchema.messages then
        return
    end

    for messageName, messageData in pairs(workingSchema.messages) do
        if messageData and messageData.fields then
            for fieldName, fieldData in pairs(messageData.fields) do
                if IsStatTypeField(fieldName) and fieldData then
                    if fieldData.type ~= "enum" or fieldData.enum_type ~= "Stat" then
                        fieldData.type = "enum"
                        fieldData.enum_type = "Stat"
                    end
                end
            end
        end
    end
end

--- Update field_order arrays to include new custom handlers
function SchemaModifier:UpdateFieldOrderArrays()
    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema or not workingSchema.messages then
        return
    end

    -- Update APLValue field_order
    if workingSchema.messages.APLValue then
        local aplValue = workingSchema.messages.APLValue
        if not aplValue.field_order then
            aplValue.field_order = {}
        end

        -- Add new custom value handlers to field_order using snake_case
        for messageType, modification in pairs(self.schemaModifications) do
            if modification.function_type == "APLValue" then
                self:Trace("Conversion APLValue: %s", messageType)
                local prefixRemoved = messageType:gsub("^APLValue", "")
                local fieldName = ns.SchemaUtils:CamelToSnake(prefixRemoved)
                if not fieldName then
                    self:Warn("SchemaModifier: CamelToSnake conversion failed for field name", {
                        prefixRemoved = prefixRemoved,
                        messageType = messageType
                    })
                end
                if self.debug then
                    self:Trace("Value field conversion: %s -> %s -> %s",
                        messageType,
                        prefixRemoved,
                        fieldName)
                end
                if not tContains(aplValue.field_order, fieldName) then
                    tinsert(aplValue.field_order, fieldName)
                    if self.debug then
                        self:Debug("Added %s to APLValue.field_order as %s", messageType, fieldName)
                    end
                end
            end
        end
    end

    -- Update APLAction field_order
    if workingSchema.messages.APLAction then
        local aplAction = workingSchema.messages.APLAction
        if not aplAction.field_order then
            aplAction.field_order = {}
        end

        -- Add new custom action handlers to field_order using snake_case
        for messageType, modification in pairs(self.schemaModifications) do
            if modification.function_type == "APLAction" then
                self:Trace("Conversion APLAction: %s", messageType)
                local prefixRemoved = messageType:gsub("^APLAction", "")
                local fieldName = ns.SchemaUtils:CamelToSnake(prefixRemoved)
                if not fieldName then
                    self:Warn("SchemaModifier: CamelToSnake conversion failed for field name", {
                        prefixRemoved = prefixRemoved,
                        messageType = messageType
                    })
                end
                if self.debug then
                    self:Trace("Action field conversion: %s -> %s -> %s",
                        messageType,
                        prefixRemoved,
                        fieldName)
                end
                if not tContains(aplAction.field_order, fieldName) then
                    tinsert(aplAction.field_order, fieldName)
                    if self.debug then
                        self:Debug("Added %s to APLAction.field_order as %s", messageType, fieldName)
                    end
                end
            end
        end
    end
end

--- Apply a single schema modification
--- @param messageType string The message type to modify
--- @param modification table The modification to apply
--- @param baseSchema table|nil Optional base schema to use (for incremental/field removal modifications)
function SchemaModifier:ApplyModification(messageType, modification, baseSchema)

    -- Validate modification structure
    if not self:ValidateModificationStructure(messageType, modification) then
        self:Warn("ApplyModification: Invalid modification structure for messageType='%s'",
            messageType or "nil")
        self:Error("Invalid modification structure for %s", messageType)
        return false
    end

    -- Get working schema from SchemaAccessor (single source of truth)
    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema then
        self:Error("SchemaAccessor.schemaData not available")
        return false
    end

    if not workingSchema.messages then
        workingSchema.messages = {}
    end

    -- Get or create the message type
    -- Note: workingSchema is a deep copy of base schema, so messageType should already exist
    -- But we check anyway in case it's a new custom handler
    local message = workingSchema.messages[messageType]
    if not message then
        -- Only create new structure if it doesn't exist (for new custom handlers)
        message = {
            fields = {},
            oneofs = {},
            field_order = {},
            _metadata = {}
        }
        workingSchema.messages[messageType] = message
    end

    -- Ensure _metadata exists on the message
    -- For incremental modifications, we'll copy base metadata, so don't wipe existing _metadata
    -- IMPORTANT: message already has _metadata from deep copy of base schema, so preserve it
    if not message._metadata then
        message._metadata = {}
    end

    -- Check if this is a field removal modification
    if modification.modification_type == "field_removal" then
        -- Field removal modification: remove specified fields
        self:ApplyFieldRemovalModification(messageType, message, modification, baseSchema)
    else
        -- Check if this is an incremental modification
        local isIncremental = modification.modification_type == "incremental"

        if isIncremental then
            -- Incremental modification: preserve existing fields and append new ones
            self:ApplyIncrementalModification(messageType, message, modification, baseSchema)
        else
            -- Full modification: replace entire structure (original behavior)
            self:ApplyFullModification(messageType, message, modification, baseSchema)
        end
    end

    -- If this is a custom APL handler, integrate it into the appropriate fields structure
    if modification.function_type then
        self:IntegrateCustomFunction(messageType, modification)
    end

    -- ============================ MERGE METADATA FROM SCHEMAMODIFICATIONS ============================
    -- Use unified MergeMetadata() function to merge modification metadata with existing metadata
    -- This preserves base metadata and applies modification overrides

    -- Get base metadata from base schema if available
    local baseMetadata = nil
    if baseSchema and baseSchema.messages and baseSchema.messages[messageType] then
        baseMetadata = baseSchema.messages[messageType]._metadata
    end

    -- Build modification metadata from both nested _metadata and top-level fields
    local modificationMetadata = {}

    -- First: Copy nested _metadata table if it exists (primary source)
    if modification._metadata and type(modification._metadata) == "table" then
        for key, value in pairs(modification._metadata) do
            modificationMetadata[key] = value
        end
    end

    -- Second: Also handle top-level metadata fields for backward compatibility
    local metadataFieldMap = {
        uiLabel = true,
        ui_label = true,
        submenu = true,
        shortDescription = true,
        short_description = true,
        fullDescription = true,
        full_description = true,
        include_if = true,
        defaults = true
    }

    -- Warn if argument_mapping is detected (deprecated - use field_order instead)
    if modification.argument_mapping or (modification._metadata and modification._metadata.argument_mapping) then
        self:Warn("argument_mapping detected in modification for %s - use field_order instead", messageType)
    end

    for fieldName, value in pairs(modification) do
        if metadataFieldMap[fieldName] and value ~= nil then
            -- Map camelCase input keys to snake_case storage keys
            local storageKey = fieldName
            if fieldName == "uiLabel" then
                storageKey = "ui_label"
            elseif fieldName == "shortDescription" then
                storageKey = "short_description"
            elseif fieldName == "fullDescription" then
                storageKey = "full_description"
            end

            -- Only add if not already in modificationMetadata (nested _metadata takes precedence)
            if not modificationMetadata[storageKey] then
                modificationMetadata[storageKey] = value
            end
        end
    end

    -- Merge metadata: start with current message._metadata (which may have base metadata from deep copy)
    -- then merge with baseMetadata if available, then apply modification overrides
    local currentMetadata = message._metadata or {}
    local mergedBase = baseMetadata and self:MergeMetadata(baseMetadata, {}) or currentMetadata
    message._metadata = self:MergeMetadata(mergedBase, modificationMetadata)

    -- Clean up: Remove any metadata fields that were copied directly to message
    -- (they should only exist in _metadata)
    for fieldName, _ in pairs(metadataFieldMap) do
        if message[fieldName] ~= nil then
            message[fieldName] = nil
        end
    end

    if self.debug then
        self:Debug("Applied %s modification to %s",
            modification.modification_type == "field_removal" and "field_removal" or
            (modification.modification_type == "incremental" and "incremental" or "full"),
            messageType)
    end
end

--- Apply enum normalization metadata
--- @param enumType string The enum type name
--- @param modification table The modification to apply
function SchemaModifier:ApplyEnumModification(enumType, modification)
    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema then
        self:Error("SchemaAccessor.schemaData not available")
        return
    end

    if not workingSchema.enums then
        workingSchema.enums = {}
    end

    if not workingSchema.enums[enumType] then
        -- Enum doesn't exist, skip (shouldn't happen but be safe)
        self:Warn("Enum type '%s' not found in schema for normalization metadata", enumType)
        return
    end

    local enum = workingSchema.enums[enumType]

    -- Apply metadata properties to enum
    for key, value in pairs(modification) do
        if key ~= "fields" and key ~= "field_order" and key ~= "oneofs" and key ~= "modification_type" then
            enum[key] = value
        end
    end

    self:Debug("Applied normalization metadata to enum %s", enumType)
end

--- Apply incremental modification (preserve existing, append new)
--- @param messageType string The message type being modified
--- @param message table The message structure to modify
--- @param modification table The incremental modification to apply
--- @param baseSchema table|nil The original base schema (before modifications)
function SchemaModifier:ApplyIncrementalModification(messageType, message, modification, baseSchema)

    -- Preserve existing fields from base schema
    -- Use provided baseSchema (original) instead of SchemaAccessor:GetSchemaData() which may be modified
    if baseSchema and baseSchema.messages and baseSchema.messages[messageType] then
        local baseMessage = baseSchema.messages[messageType]

        -- Copy existing fields
        if baseMessage.fields then
            for fieldName, fieldData in pairs(baseMessage.fields) do
                if not message.fields[fieldName] then
                    message.fields[fieldName] = self:DeepCopySchema(fieldData)
                end
            end
        end

        -- Copy existing field_order
        if baseMessage.field_order then
            message.field_order = self:DeepCopySchema(baseMessage.field_order)
        end

        -- Copy existing oneofs
        if baseMessage.oneofs then
            message.oneofs = self:DeepCopySchema(baseMessage.oneofs)
        end

        -- CRITICAL: Copy _metadata from baseMessage if message._metadata is missing or empty
        -- This is a safety net in case the deep copy didn't work correctly
        -- We check if message._metadata is empty/nil AND baseMessage._metadata exists
        if baseMessage._metadata then
            if not message._metadata or (next(message._metadata) == nil) then
                -- message._metadata is missing or empty, but baseMessage has it - copy it!
                self:Warn("ApplyIncrementalModification: message._metadata is empty but baseMessage has metadata! Copying from baseMessage for %s", messageType)
                message._metadata = {}
                for key, value in pairs(baseMessage._metadata) do
                    message._metadata[key] = self:DeepCopySchema(value)
                end
            end
        else
            if self.debug or NAG.debug then
                self:Info("ApplyIncrementalModification: baseMessage._metadata is nil for %s (normal for structural types like UUID)", messageType)
            end
        end

        -- Copy other non-metadata properties (but allow modification to override)
        -- Skip anything that will be in _metadata (metadata is handled separately above)
        -- Known metadata fields should never be copied directly to message
        local metadataFieldMap = {
            uiLabel = true,
            ui_label = true,
            submenu = true,  -- Keep as-is (already snake_case)
            shortDescription = true,
            short_description = true,
            full_description = true,  -- Only full_description exists in source schema (no longDescription)
            includeIf = true,
            include_if = true,
            defaults = true  -- Keep as-is (already snake_case)
        }

        for key, value in pairs(baseMessage) do
            if key ~= "fields" and key ~= "field_order" and key ~= "oneofs" and
               key ~= "_metadata" and not modification[key] and
               not metadataFieldMap[key] and
               not (message._metadata and message._metadata[key]) then
                message[key] = self:DeepCopySchema(value)
            end
        end
    end

    -- Find the highest existing field ID
    local maxId = 0
    for fieldName, fieldData in pairs(message.fields) do
        if fieldData.id and fieldData.id > maxId then
            maxId = fieldData.id
        end
    end

    -- Apply new fields with auto-incremented IDs
    if modification.fields then
        for fieldName, fieldData in pairs(modification.fields) do
            -- Ensure field has required structure
            local field = {
                id = fieldData.id or (maxId + 1), -- Auto-increment if no ID provided
                type = fieldData.type,
                label = fieldData.label
            }

            -- Add type-specific fields
            if fieldData.type == "enum" and fieldData.enum_type then
                field.enum_type = fieldData.enum_type
            elseif fieldData.type == "message" and fieldData.message_type then
                field.message_type = fieldData.message_type
            end

            -- Add description if available
            if fieldData.description then
                field.description = fieldData.description
            end

            -- Sync field-level metadata if it exists
            if fieldData._metadata and type(fieldData._metadata) == "table" then
                if not field._metadata then
                    field._metadata = {}
                end
                -- Copy all field-level metadata
                for key, value in pairs(fieldData._metadata) do
                    field._metadata[key] = self:DeepCopySchema(value)
                end
            end

            message.fields[fieldName] = field
            maxId = field.id -- Update max ID for next field
        end
    end

    -- CRITICAL: Preserve _metadata reference before field_order assignment
    -- Store a backup to detect if it gets wiped
    local metadataBackup = nil
    local hadMetadataBefore = false
    if message._metadata then
        hadMetadataBefore = (next(message._metadata) ~= nil)
        if hadMetadataBefore then
            metadataBackup = {}
            for key, value in pairs(message._metadata) do
                metadataBackup[key] = value
            end
        end
    end

    -- Handle field_order: if explicitly provided, use it (override); otherwise append new fields
    if modification.field_order then
        -- Explicit field_order provided - use it to override the base field_order
        message.field_order = self:DeepCopySchema(modification.field_order)
    else
        -- No explicit field_order - append new fields to existing field_order
        if modification.fields then
            for fieldName, _ in pairs(modification.fields) do
                if not tContains(message.field_order, fieldName) then
                    tinsert(message.field_order, fieldName)
                end
            end
        end
    end

    -- CRITICAL: Restore _metadata if it was wiped (defensive check)
    if metadataBackup and (not message._metadata or next(message._metadata) == nil) then
        self:Warn("ApplyIncrementalModification: message._metadata was wiped after field_order handling! Restoring from backup. [messageType=%s]",
            messageType)
        message._metadata = metadataBackup
    end

    -- CRITICAL: Preserve _metadata reference before other props loop
    -- Store a backup to detect if it gets wiped
    local metadataBackup2 = nil
    local hadMetadataBefore2 = false
    if message._metadata then
        hadMetadataBefore2 = (next(message._metadata) ~= nil)
        if hadMetadataBefore2 then
            metadataBackup2 = {}
            for key, value in pairs(message._metadata) do
                metadataBackup2[key] = value
            end
        end
    end

    -- Apply other non-metadata properties (excluding fields, field_order, oneofs, _metadata)
    -- Skip anything already stored in _metadata (single source of truth)
    -- CRITICAL: Exclude _metadata from this loop - it's handled separately in ApplyModification
    for key, value in pairs(modification) do
        if key ~= "fields" and key ~= "field_order" and key ~= "oneofs" and
           key ~= "modification_type" and key ~= "_metadata" and
           not message._metadata[key] then
            message[key] = value
        end
    end

    -- CRITICAL: Restore _metadata if it was wiped (defensive check)
    if metadataBackup2 and (not message._metadata or next(message._metadata) == nil) then
        self:Warn("ApplyIncrementalModification: message._metadata was wiped after other props loop! Restoring from backup. [messageType=%s]",
            messageType)
        message._metadata = metadataBackup2
    end
end

--- Apply field removal modification (remove specified fields)
--- @param messageType string The message type being modified
--- @param message table The message structure to modify
--- @param modification table The field removal modification to apply
--- @param baseSchema table|nil The original base schema (before modifications)
function SchemaModifier:ApplyFieldRemovalModification(messageType, message, modification, baseSchema)
    -- Preserve existing fields from base schema first
    -- Use provided baseSchema (original) instead of SchemaAccessor:GetSchemaData() which may be modified
    if baseSchema and baseSchema.messages and baseSchema.messages[messageType] then
        local baseMessage = baseSchema.messages[messageType]

        -- Copy existing fields
        if baseMessage.fields then
            for fieldName, fieldData in pairs(baseMessage.fields) do
                if not message.fields[fieldName] then
                    message.fields[fieldName] = self:DeepCopySchema(fieldData)
                end
            end
        end

        -- Copy existing field_order
        if baseMessage.field_order then
            message.field_order = self:DeepCopySchema(baseMessage.field_order)
        end

        -- Copy existing oneofs
        if baseMessage.oneofs then
            message.oneofs = self:DeepCopySchema(baseMessage.oneofs)
        end

        -- Copy _metadata from base message if it exists (will be merged with modification._metadata later)
        if baseMessage._metadata then
            if not message._metadata then
                message._metadata = {}
            end
            -- Deep copy all base _metadata - modification._metadata will override later in ApplyModification
            for key, value in pairs(baseMessage._metadata) do
                message._metadata[key] = self:DeepCopySchema(value)
            end
        end

        -- Copy other non-metadata properties (but allow modification to override)
        -- Skip anything that will be in _metadata (metadata is handled separately above)
        local metadataFieldMap = {
            uiLabel = true,
            ui_label = true,
            submenu = true,
            shortDescription = true,
            short_description = true,
            full_description = true,
            includeIf = true,
            include_if = true,
            defaults = true
        }

        for key, value in pairs(baseMessage) do
            if key ~= "fields" and key ~= "field_order" and key ~= "oneofs" and
               key ~= "_metadata" and not modification[key] and
               not metadataFieldMap[key] and
               not (message._metadata and message._metadata[key]) then
                message[key] = self:DeepCopySchema(value)
            end
        end
    end

    -- Remove specified fields
    if modification.fields_to_remove then
        for _, fieldName in ipairs(modification.fields_to_remove) do
            if message.fields[fieldName] then
                message.fields[fieldName] = nil
                self:Debug("Removed field %s from %s", fieldName, messageType)
            else
                self:Warn("Field %s not found in %s for removal", fieldName, messageType)
            end
        end
    end

    -- Remove fields from field_order array
    if modification.fields_to_remove then
        for _, fieldName in ipairs(modification.fields_to_remove) do
            local index = nil
            for i, name in ipairs(message.field_order) do
                if name == fieldName then
                    index = i
                    break
                end
            end
            if index then
                tremove(message.field_order, index)
                self:Debug("Removed %s from field_order for %s", fieldName, messageType)
            end
        end
    end

    -- Apply other non-metadata properties (excluding fields, field_order, oneofs, _metadata)
    -- Skip anything already stored in _metadata (single source of truth)
    -- CRITICAL: Exclude _metadata from this loop - it's handled separately in ApplyModification
    for key, value in pairs(modification) do
        if key ~= "fields" and key ~= "field_order" and key ~= "oneofs" and
           key ~= "modification_type" and key ~= "fields_to_remove" and
           key ~= "_metadata" and not message._metadata[key] then
            message[key] = value
        end
    end
end

--- Apply full modification (replace entire structure - original behavior)
--- @param messageType string The message type being modified
--- @param message table The message structure to modify
--- @param modification table The full modification to apply
--- @param baseSchema table|nil Optional base schema to preserve base metadata
function SchemaModifier:ApplyFullModification(messageType, message, modification, baseSchema)
    -- ============================ PRESERVE BASE METADATA FIRST ============================
    -- Preserve base metadata BEFORE applying any modifications
    -- This ensures metadata is available throughout the modification process

    -- Get base metadata from base schema if available
    local baseMetadata = nil
    if baseSchema and baseSchema.messages and baseSchema.messages[messageType] then
        baseMetadata = baseSchema.messages[messageType]._metadata
    end

    -- Preserve base metadata: start with base metadata if available
    if baseMetadata and type(baseMetadata) == "table" then
        -- Copy base metadata to message._metadata
        if not message._metadata then
            message._metadata = {}
        end
        -- Merge base metadata (base takes precedence for full modifications)
        for key, value in pairs(baseMetadata) do
            if not message._metadata[key] then
                message._metadata[key] = self:DeepCopySchema(value)
            end
        end
    elseif not message._metadata then
        -- Ensure _metadata exists even if no base metadata
        message._metadata = {}
    end

    -- Apply field modifications with proper structure
    if modification.fields then
        for fieldName, fieldData in pairs(modification.fields) do
            -- Ensure field has required structure
            local field = {
                id = fieldData.id,
                type = fieldData.type,
                label = fieldData.label
            }

            -- Add type-specific fields
            if fieldData.type == "enum" and fieldData.enum_type then
                field.enum_type = fieldData.enum_type
            elseif fieldData.type == "message" and fieldData.message_type then
                field.message_type = fieldData.message_type
            end

            -- Add description if available
            if fieldData.description then
                field.description = fieldData.description
            end

            -- Sync field-level metadata if it exists
            if fieldData._metadata and type(fieldData._metadata) == "table" then
                if not field._metadata then
                    field._metadata = {}
                end
                -- Copy all field-level metadata
                for key, value in pairs(fieldData._metadata) do
                    field._metadata[key] = self:DeepCopySchema(value)
                end
            end

            message.fields[fieldName] = field
        end
    end

    -- Apply field order modifications
    if modification.field_order then
        message.field_order = modification.field_order
    end

    -- Apply oneofs field
    if modification.oneofs then
        message.oneofs = modification.oneofs
    end

    -- Apply other non-metadata properties (excluding fields, field_order, oneofs, _metadata)
    -- Skip anything already stored in _metadata (single source of truth)
    for key, value in pairs(modification) do
        if key ~= "fields" and key ~= "field_order" and key ~= "oneofs" and
           key ~= "_metadata" and key ~= "modification_type" and not message._metadata[key] then
            message[key] = value
        end
    end
end

--- Validate that a modification follows the proper schema structure
--- @param messageType string The message type being modified
--- @param modification table The modification to validate
--- @return boolean True if the modification is valid
function SchemaModifier:ValidateModificationStructure(messageType, modification)
    if not modification or type(modification) ~= "table" then
        self:Error("Modification must be a table")
        return false
    end

    -- Check modification type
    local isIncremental = modification.modification_type == "incremental"
    local isFieldRemoval = modification.modification_type == "field_removal"

    if isFieldRemoval then
        -- For field removal modifications, fields_to_remove is required
        if not modification.fields_to_remove or type(modification.fields_to_remove) ~= "table" then
            self:Error("Field removal modification must have a 'fields_to_remove' table")
            return false
        end

        -- Validate that fields_to_remove contains only strings
        for i, fieldName in ipairs(modification.fields_to_remove) do
            if type(fieldName) ~= "string" then
                self:Error("Field removal list item %d must be a string, got %s", i, type(fieldName))
                return false
            end
        end
    elseif isIncremental then
        -- For incremental modifications, only fields are required
        if not modification.fields or type(modification.fields) ~= "table" then
            self:Error("Incremental modification must have a 'fields' table")
            return false
        end
    else
        -- For full modifications, all fields are required (original behavior)
        if not modification.fields or type(modification.fields) ~= "table" then
            self:Error("Modification must have a 'fields' table")
            return false
        end

        if not modification.field_order or type(modification.field_order) ~= "table" then
            self:Error("Modification must have a 'field_order' table")
            return false
        end

        if not modification.oneofs or type(modification.oneofs) ~= "table" then
            self:Error("Modification must have a 'oneofs' table")
            return false
        end
    end

    -- Validate fields (only for non-field-removal modifications)
    if not isFieldRemoval and modification.fields then
        local fieldIds = {}
        for fieldName, fieldData in pairs(modification.fields) do
            -- For incremental modifications, ID is optional (will be auto-incremented)
            if not isIncremental and (not fieldData.id or type(fieldData.id) ~= "number") then
                self:Error("Field %s must have a numeric 'id'", fieldName)
                return false
            end

            -- For incremental modifications, allow auto-increment
            if isIncremental and fieldData.id and type(fieldData.id) ~= "number" then
                self:Error("Field %s must have a numeric 'id' or omit it for auto-increment", fieldName)
                return false
            end

            if not fieldData.type or type(fieldData.type) ~= "string" then
                self:Error("Field %s must have a 'type' string", fieldName)
                return false
            end

            if not fieldData.label or type(fieldData.label) ~= "string" then
                self:Error("Field %s must have a 'label' string", fieldName)
                return false
            end

            -- Check for duplicate IDs (only if ID is provided)
            if fieldData.id then
                if fieldIds[fieldData.id] then
                    self:Error("Duplicate field ID %d for field %s", fieldData.id, fieldName)
                    return false
                end
                fieldIds[fieldData.id] = fieldName
            end

            -- Validate type-specific fields
            if fieldData.type == "enum" and not fieldData.enum_type then
                self:Error("Enum field %s must have 'enum_type'", fieldName)
                return false
            elseif fieldData.type == "message" and not fieldData.message_type then
                self:Error("Message field %s must have 'message_type'", fieldName)
                return false
            end
        end
    end

    -- Validate include_if structure if present
    if modification.include_if then
        if type(modification.include_if) ~= "table" then
            self:Error("include_if must be a table")
            return false
        end

        -- Validate boolean fields if present
        if modification.include_if.prepull_only ~= nil and type(modification.include_if.prepull_only) ~= "boolean" then
            self:Error("include_if.prepull_only must be boolean or nil")
            return false
        end

        if modification.include_if.combat_only ~= nil and type(modification.include_if.combat_only) ~= "boolean" then
            self:Error("include_if.combat_only must be boolean or nil")
            return false
        end

        if modification.include_if.spec_specific ~= nil and type(modification.include_if.spec_specific) ~= "boolean" then
            self:Error("include_if.spec_specific must be boolean or nil")
            return false
        end
    end

    -- Validate field_order matches fields (only for full modifications)
    if not isIncremental and not isFieldRemoval and modification.field_order then
        for _, fieldName in ipairs(modification.field_order) do
            if not modification.fields[fieldName] then
                self:Error("Field order references non-existent field: %s", fieldName)
                return false
            end
        end

        -- Check that all fields are in field_order
        for fieldName, _ in pairs(modification.fields) do
            if not tContains(modification.field_order, fieldName) then
                self:Error("Field %s is not in field_order", fieldName)
                return false
            end
        end
    end

    self:Trace("Modification structure validation passed for %s", messageType)
    return true
end

--- Integrate a custom handler into the schema structure
--- @param functionName string The name of the custom handler
--- @param functionData table The handler metadata
function SchemaModifier:IntegrateCustomFunction(functionName, functionData)
    if not functionName or not functionData then
        return
    end

    -- Determine if this is an APLValue or APLAction
    local functionType = functionData.function_type
    if not functionType then
        self:Error(format("Custom handler %s missing function_type", functionName))
        return
    end

    -- Convert camelCase to snake_case for field names
    -- First remove the APL prefix, then convert to snake_case
    self:Trace("Conversion2: %s", functionName)
    local prefixRemoved = functionName:gsub("^APLValue", ""):gsub("^APLAction", "")
    self:Trace("Conversion3: %s", prefixRemoved)
    local fieldName = ns.SchemaUtils:CamelToSnake(prefixRemoved)
    if not fieldName then
        self:Warn("SchemaModifier: CamelToSnake conversion failed for field name", {
            prefixRemoved = prefixRemoved,
            functionName = functionName
        })
    end

    if self.debug then
        self:Trace("Field name conversion: %s -> %s -> %s",
            functionName,
            prefixRemoved,
            fieldName)
    end

    -- Get working schema from SchemaAccessor (single source of truth)
    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema then
        self:Error("SchemaAccessor.schemaData not available in IntegrateCustomFunction")
        return
    end

    if not workingSchema.messages then
        workingSchema.messages = {}
    end

    -- Add to the appropriate fields structure (APLValue or APLAction)
    if functionType == "APLValue" then
        if not workingSchema.messages.APLValue then
            workingSchema.messages.APLValue = { fields = {}, field_order = {} }
        elseif not workingSchema.messages.APLValue.fields then
            workingSchema.messages.APLValue.fields = {}
        end
        if not workingSchema.messages.APLValue.field_order then
            workingSchema.messages.APLValue.field_order = {}
        end

        -- Add the custom handler to APLValue.fields using snake_case
        if not workingSchema.messages.APLValue.fields[fieldName] then
            local fieldDef = {
                id = #workingSchema.messages.APLValue.field_order + 1, -- Assign next available ID
                type = "message",
                label = "optional",                                          -- Custom handlers are typically optional (structural)
                message_type = functionName
            }
            -- Store metadata on message type, not field definition
            -- Metadata should be on messageType._metadata with snake_case keys
            local messageTypeSchema = workingSchema.messages[functionName]
            if messageTypeSchema then
                if not messageTypeSchema._metadata then
                    messageTypeSchema._metadata = {}
                end
                -- Store metadata in snake_case (definitive format)
                if functionData.ui_label then
                    messageTypeSchema._metadata.ui_label = functionData.ui_label
                end
                if functionData.short_description then
                    messageTypeSchema._metadata.short_description = functionData.short_description
                end
                if functionData.full_description then
                    messageTypeSchema._metadata.full_description = functionData.full_description
                end
                if functionData.submenu then
                    messageTypeSchema._metadata.submenu = functionData.submenu
                end
                if functionData.include_if then
                    messageTypeSchema._metadata.include_if = functionData.include_if
                end
                if functionData.defaults then
                    messageTypeSchema._metadata.defaults = functionData.defaults
                end
            end
            workingSchema.messages.APLValue.fields[fieldName] = fieldDef
            if self.debug then
                self:Debug("Added custom value handler %s to APLValue.fields as %s", functionName, fieldName)
            end
        end
    elseif functionType == "APLAction" then
        if not workingSchema.messages.APLAction then
            workingSchema.messages.APLAction = { fields = {}, field_order = {} }
        elseif not workingSchema.messages.APLAction.fields then
            workingSchema.messages.APLAction.fields = {}
        end
        if not workingSchema.messages.APLAction.field_order then
            workingSchema.messages.APLAction.field_order = {}
        end

        -- Add the custom handler to APLAction.fields using snake_case
        if not workingSchema.messages.APLAction.fields[fieldName] then
            local fieldDef = {
                id = #workingSchema.messages.APLAction.field_order + 1, -- Assign next available ID
                type = "message",
                label = "optional",                                           -- Custom handlers are typically optional (structural)
                message_type = functionName
            }
            -- Store metadata on message type, not field definition
            -- Metadata should be on messageType._metadata with snake_case keys
            local messageTypeSchema = workingSchema.messages[functionName]
            if messageTypeSchema then
                if not messageTypeSchema._metadata then
                    messageTypeSchema._metadata = {}
                end
                -- Store metadata in snake_case (definitive format)
                if functionData.ui_label then
                    messageTypeSchema._metadata.ui_label = functionData.ui_label
                end
                if functionData.short_description then
                    messageTypeSchema._metadata.short_description = functionData.short_description
                end
                if functionData.full_description then
                    messageTypeSchema._metadata.full_description = functionData.full_description
                end
                if functionData.submenu then
                    messageTypeSchema._metadata.submenu = functionData.submenu
                end
                if functionData.include_if then
                    messageTypeSchema._metadata.include_if = functionData.include_if
                end
                if functionData.defaults then
                    messageTypeSchema._metadata.defaults = functionData.defaults
                end
            end
            workingSchema.messages.APLAction.fields[fieldName] = fieldDef
            if self.debug then
                self:Debug("Added custom action handler %s to APLAction.fields as %s", functionName, fieldName)
            end
        end
    end
end

--- Create include_if configuration for class-specific handlers
--- @param className string The class name (e.g., "Hunter", "DeathKnight")
--- @param options table|nil Additional options (prepullOnly, combatOnly, specSpecific)
--- @return table The include_if configuration
function SchemaModifier:CreateClassIncludeIf(className, options)
    options = options or {}

    return {
        class_specific = true,
        classes = { className },
        prepull_only = options.prepullOnly,
        combat_only = options.combatOnly,
        spec_specific = options.specSpecific or true
    }
end

--- Create includeIf configuration for spec-specific handlers
--- @param specName string The spec name (e.g., "BalanceDruid", "FeralDruid")
--- @param options table|nil Additional options (prepullOnly, combatOnly, specSpecific)
--- @return table The include_if configuration
function SchemaModifier:CreateSpecIncludeIf(specName, options)
    options = options or {}

    return {
        spec_specific = true,
        specs = { specName },
        prepull_only = options.prepullOnly,
        combat_only = options.combatOnly
    }
end

--- Create includeIf configuration for prepull-only handlers
--- @param options table|nil Additional options (combatOnly, specSpecific)
--- @return table The include_if configuration
function SchemaModifier:CreatePrepullOnlyIncludeIf(options)
    options = options or {}

    return {
        prepull_only = true,
        combat_only = false,
        spec_specific = options.specSpecific or false
    }
end

--- Create includeIf configuration for combat-only handlers
--- @param options table|nil Additional options (prepullOnly, specSpecific)
--- @return table The include_if configuration
function SchemaModifier:CreateCombatOnlyIncludeIf(options)
    options = options or {}

    return {
        prepull_only = false,
        combat_only = true,
        spec_specific = options.specSpecific or false
    }
end

--- Create includeIf configuration for healing specs only
--- @param options table|nil Additional options (prepullOnly, combatOnly)
--- @return table The include_if configuration
function SchemaModifier:CreateHealingSpecIncludeIf(options)
    options = options or {}

    return {
        requires_healer_spec = true,
        spec_specific = true,
        prepull_only = options.prepullOnly or false,
        combat_only = options.combatOnly or true
    }
end

--- Create includeIf configuration for raid-only handlers
--- @param options table|nil Additional options (prepullOnly, combatOnly, specSpecific)
--- @return table The include_if configuration
function SchemaModifier:CreateRaidOnlyIncludeIf(options)
    options = options or {}

    return {
        requires_group = true,
        prepull_only = options.prepullOnly,
        combat_only = options.combatOnly,
        spec_specific = options.specSpecific or false
    }
end

--- Create custom includeIf configuration
--- @param options table|nil Additional options (prepullOnly, combatOnly, specSpecific, classes, specs, etc.)
--- @return table The include_if configuration
function SchemaModifier:CreateCustomIncludeIf(options)
    options = options or {}

    return {
        prepull_only = options.prepullOnly or options.prepull_only,
        combat_only = options.combatOnly or options.combat_only,
        spec_specific = options.specSpecific or options.spec_specific,
        class_specific = options.classSpecific or options.class_specific,
        classes = options.classes,
        specs = options.specs,
        excluded_classes = options.excludedClasses or options.excluded_classes,
        excluded_specs = options.excludedSpecs or options.excluded_specs,
        requires_group = options.requiresGroup or options.requires_group,
        requires_target_dummies = options.requiresTargetDummies or options.requires_target_dummies,
        requires_item_swap = options.requiresItemSwap or options.requires_item_swap,
        requires_secondary_resource = options.requiresSecondaryResource or options.requires_secondary_resource,
        requires_healer_spec = options.requiresHealerSpec or options.requires_healer_spec,
        requires_tank_spec = options.requiresTankSpec or options.requires_tank_spec
    }
end

-- String case conversion now handled by SchemaUtils
-- Use SchemaUtils:CamelToSnake() instead

-- ============================ METADATA MERGING ============================

--- Merge base metadata with modification metadata
--- Preserves all base metadata, then applies modification overrides
--- @param baseMetadata table|nil The base metadata from original schema
--- @param modificationMetadata table|nil The modification metadata
--- @return table Merged metadata table
function SchemaModifier:MergeMetadata(baseMetadata, modificationMetadata)
    -- Start with base metadata (deep copy to avoid modifying original)
    local merged = self:DeepCopySchema(baseMetadata or {})

    -- Apply modification overrides (modification takes precedence)
    if modificationMetadata and type(modificationMetadata) == "table" then
        for key, value in pairs(modificationMetadata) do
            -- Handle include_if with proper structure conversion (camelCase to snake_case)
            if key == "include_if" and type(value) == "table" then
                merged.include_if = {
                    prepull_only = value.prepull_only or value.prepullOnly,
                    combat_only = value.combat_only or value.combatOnly,
                    spec_specific = value.spec_specific or value.specSpecific,
                    class_specific = value.class_specific or value.classSpecific,
                    classes = value.classes,
                    specs = value.specs,
                    excluded_classes = value.excluded_classes or value.excludedClasses,
                    excluded_specs = value.excluded_specs or value.excludedSpecs,
                    requires_group = value.requires_group or value.requiresGroup,
                    requires_target_dummies = value.requires_target_dummies or value.requiresTargetDummies,
                    requires_item_swap = value.requires_item_swap or value.requiresItemSwap,
                    requires_secondary_resource = value.requires_secondary_resource or value.requiresSecondaryResource,
                    requires_healer_spec = value.requires_healer_spec or value.requiresHealerSpec,
                    requires_tank_spec = value.requires_tank_spec or value.requiresTankSpec,
                    unparsed = value.unparsed
                }
            else
                -- Copy all other metadata fields as-is (already in snake_case from SchemaModifications)
                merged[key] = self:DeepCopySchema(value)
            end
        end
    end

    return merged
end

--- Create a deep copy of the schema for modification
--- @param schema table The schema to copy
--- @return table A deep copy of the schema
function SchemaModifier:DeepCopySchema(schema)
    if type(schema) ~= "table" then
        return schema
    end

    local copy = {}
    for key, value in pairs(schema) do
        if type(value) == "table" then
            copy[key] = self:DeepCopySchema(value)
        else
            copy[key] = value
        end
    end

    return copy
end

-- ~~~~~~~~~~ VALIDATION SYSTEM ~~~~~~~~--

--- Initialize the validation system
function SchemaModifier:InitializeValidationSystem()
    -- Register validation commands
    self:RegisterValidationCommands()
end

--- Register validation commands
function SchemaModifier:RegisterValidationCommands()
    -- Add debug command to test the system
    SLASH_NAGSCHEMA1 = "/nagschema"
    SLASH_NAGSCHEMA2 = "/nagsch"

    SlashCmdList["NAGSCHEMA"] = function(msg)
        if not SchemaModifier then
            print("SchemaModifier module not found")
            return
        end

        local args = { strsplit(" ", msg) }

        local command = args[1] or "help"

        if command == "validate" or command == "diff" then
            SchemaModifier:RunValidation()
        elseif command == "list" then
            SchemaModifier:ListModifications()
        elseif command == "test" then
            SchemaModifier:TestCustomHandlerIntegration()
        elseif command == "rebuild" then
            SchemaModifier:TestAliasRebuilding()
        elseif command == "schema" then
            SchemaModifier:ShowSchemaStructure()
        elseif command == "includeif" then
            SchemaModifier:TestIncludeIfConditions()
        elseif command == "version" then
            SchemaModifier:ShowVersionSpecificInfo()
        elseif command == "remove" then
            SchemaModifier:TestFieldRemoval()
        elseif command == "debug" then
            SchemaModifier:DebugModificationCounts()
        elseif command == "modify" then
            if #args >= 3 then
                SchemaModifier:ApplyCustomModification(args[2], args[3])
            else
                print("Usage: /nagschema modify <type> <name>")
            end
        elseif command == "help" or command == "" then
            SchemaModifier:ShowHelp()
        else
            print("Unknown command: " .. command)
            SchemaModifier:ShowHelp()
        end
    end
end

--- Run the validation system
function SchemaModifier:RunValidation()
    self:Debug("Running validation system")

    -- Discover NAG: namespace functions
    local nagFunctions = self:DiscoverNAGFunctions()

    -- Get current schema
    local schemaData = self:GetCurrentSchema()

    -- Compare and generate report
    local report = self:GenerateValidationReport(nagFunctions, schemaData)

    -- Display report
    self:DisplayValidationReport(report)
end

--- Discover all functions in the NAG: namespace
--- @return table Table of discovered functions with parameter information
function SchemaModifier:DiscoverNAGFunctions()
    local functions = {}

    -- Iterate through the NAG namespace to find functions
    for key, value in pairs(NAG) do
        if type(value) == "function" then
            -- Try to get function info (this is limited in WoW Lua)
            local funcInfo = {
                name = key,
                parameters = self:AnalyzeFunctionParameters(value),
                source = "NAG:"
            }
            functions[key] = funcInfo
        end
    end

    self:Debug("Discovered %d NAG: namespace functions", TableUtils.Size(functions))
    return functions
end

--- Analyze function parameters (limited in WoW Lua)
--- @param func function The function to analyze
--- @return table Parameter information
function SchemaModifier:AnalyzeFunctionParameters(func)
    -- WoW Lua doesn't provide easy access to function parameters
    -- We'll use a heuristic approach based on function calls
    local params = {}

    -- For now, we'll use a simple approach - this could be enhanced
    -- with more sophisticated analysis in the future
    params.count = "unknown" -- We can't easily determine this in WoW Lua
    params.types = "unknown"

    return params
end

-- ~~~~~~~~~~ SCHEMA ACCESSOR INTEGRATION ~~~~~~~~~~

--- Notify SchemaAccessor that modifications are complete
--- This allows SchemaAccessor to refresh its data if needed
function SchemaModifier:NotifySchemaAccessorModificationsComplete()
    if SchemaAccessor then
        -- Rebuild all aliases and caches
        self:RebuildSchemaAccessorAliases(SchemaAccessor)

        -- Notify SchemaAccessor that modifications are complete
        if SchemaAccessor.OnSchemaModificationsComplete then
            local workingSchema = SchemaAccessor.schemaData
            if workingSchema then
                SchemaAccessor:OnSchemaModificationsComplete(workingSchema)
            end
        end

        self:Debug("Rebuilt SchemaAccessor aliases and caches")
    end
end

--- Rebuild all SchemaAccessor aliases and caches after schema modifications
--- @param SchemaAccessor SchemaAccessor The SchemaAccessor module instance
function SchemaModifier:RebuildSchemaAccessorAliases(SchemaAccessor)
        -- Clear all caches so they get regenerated with modifications
    SchemaAccessor:ClearCaches()

    -- Force regeneration of action and value type arrays
    SchemaAccessor.actionTypes = nil
    SchemaAccessor.valueTypes = nil

    -- Rebuild the action types array
    if SchemaAccessor.GetActionTypes then
        local actionTypes = SchemaAccessor:GetActionTypes()
        if self.debug then
            self:Debug("Rebuilt action types: %d types", #actionTypes)
        end
    end

    -- Rebuild the value types array
    if SchemaAccessor.GetValueTypes then
        local valueTypes = SchemaAccessor:GetValueTypes()
        if self.debug then
            self:Debug("Rebuilt value types: %d types", #valueTypes)
        end
    end

    -- Force regeneration of field cache by accessing a few fields
    local workingSchema = SchemaAccessor.schemaData
    if workingSchema and workingSchema.messages then
        -- Test field access for custom handlers to populate cache
        for messageType, modification in pairs(self.schemaModifications) do
            if modification.function_type then
                local category = (modification.function_type == "APLAction") and "Actions" or "Values"
                local prefixRemoved = messageType:gsub("^APLValue", ""):gsub("^APLAction", "")
                local fieldName = ns.SchemaUtils:CamelToSnake(prefixRemoved)
                if not fieldName then
                    self:Warn("SchemaModifier: CamelToSnake conversion failed for field name", {
                        prefixRemoved = prefixRemoved,
                        messageType = messageType
                    })
                end

                if SchemaAccessor.GetFields then
                    SchemaAccessor:GetFields(
                        category == "Actions" and "APLAction" or "APLValue", fieldName)
                end
            end
        end
    end
end

--- Get the current schema (modified or original)
--- @return table The current schema data
function SchemaModifier:GetCurrentSchema()
    -- Return modified schema if available, otherwise get from SchemaAccessor
    local workingSchema = SchemaAccessor.schemaData
    if workingSchema then
        return workingSchema
    end

    if SchemaAccessor then
        return SchemaAccessor:GetSchemaData()
    end

    return {}
end

--- Generate a validation report
--- @param nagFunctions table Functions discovered in NAG: namespace
--- @param schemaData table Current schema data
--- @return table Validation report
function SchemaModifier:GenerateValidationReport(nagFunctions, schemaData)
    local report = {
        nagFunctionCount = TableUtils.Size(nagFunctions),
        schemaFunctionCount = 0,
        missingFromSchema = {},
        schemaOnlyFunctions = {},
        parameterMismatches = {},
        modifications = TableUtils.Size(self.schemaModifications)
    }

    -- Count schema functions
    if schemaData.messages then
        for name, _ in pairs(schemaData.messages) do
            report.schemaFunctionCount = report.schemaFunctionCount + 1
        end
    end

    -- Find functions missing from schema
    for funcName, _ in pairs(nagFunctions) do
        if not schemaData.messages or not schemaData.messages[funcName] then
            tinsert(report.missingFromSchema, funcName)
        end
    end

    -- Find schema-only functions
    if schemaData.messages then
        for funcName, _ in pairs(schemaData.messages) do
            if not nagFunctions[funcName] then
                tinsert(report.schemaOnlyFunctions, funcName)
            end
        end
    end

    return report
end

--- Display the validation report
--- @param report table The validation report to display
function SchemaModifier:DisplayValidationReport(report)
    self:Print("=== Schema Validation Report ===")
    self:Print(format("Functions in NAG: namespace: %d", report.nagFunctionCount))
    self:Print(format("Functions in schema: %d", report.schemaFunctionCount))
    self:Print(format("Active modifications: %d", report.modifications))

    if #report.missingFromSchema > 0 then
        self:Print("")
        self:Print("Missing from schema:")
        for _, funcName in ipairs(report.missingFromSchema) do
            self:Print("- " .. funcName)
        end
    end

    if #report.schemaOnlyFunctions > 0 then
        self:Print("")
        self:Print("Schema-only functions:")
        for _, funcName in ipairs(report.schemaOnlyFunctions) do
            self:Print("- " .. funcName)
        end
    end

    if #report.parameterMismatches > 0 then
        self:Print("")
        self:Print("Parameter mismatches:")
        for _, mismatch in ipairs(report.parameterMismatches) do
            self:Print("- " .. mismatch)
        end
    end
end

--- List all active modifications
function SchemaModifier:ListModifications()
    self:Print("=== Active Schema Modifications ===")

    if TableUtils.Size(self.schemaModifications) == 0 then
        self:Print("No active modifications")
        return
    end

    for messageType, modification in pairs(self.schemaModifications) do
        self:Print(format("- %s:", messageType))

        if modification.fields then
            for fieldName, fieldData in pairs(modification.fields) do
                local fieldType = fieldData.type or "unknown"
                local label = fieldData.label or "unknown"
                self:Print(format("  %s: %s (%s)", fieldName, fieldType, label))
            end
        end

        if modification.uiLabel then
            self:Print(format("  UI Label: %s", modification.uiLabel))
        end

        if modification.function_type then
            self:Print(format("  Function Type: %s", modification.function_type))
        end

        if modification.submenu then
            local submenuStr = concat(modification.submenu, " > ")
            self:Print(format("  Submenu: %s", submenuStr))
        end
    end
end

--- Apply a custom modification at runtime
--- @param messageType string The message type to modify
--- @param modificationName string The name of the modification
function SchemaModifier:ApplyCustomModification(messageType, modificationName)
    self:Print(format("Applying custom modification: %s to %s", modificationName, messageType))

    -- This is a placeholder for runtime modification application
    -- In a full implementation, you could load modifications from files or user input
    self:Print("Runtime modifications not yet implemented")
end

--- Show help for schema commands
function SchemaModifier:ShowHelp()
    self:Print("=== SchemaModifier Commands ===")
    self:Print("/nagschema validate - Run full validation")
    self:Print("/nagschema diff - Show differences only")
    self:Print("/nagschema list - List all modifications")
    self:Print("/nagschema test - Test custom handler integration (CommonHandlers)")
    self:Print("/nagschema rebuild - Test alias rebuilding functionality")
    self:Print("/nagschema schema - Show schema structure for custom handlers")
    self:Print("/nagschema includeif - Test include_if conditions")
    self:Print("/nagschema version - Show version-specific modification info")
    self:Print("/nagschema remove - Test field removal functionality")
    self:Print("/nagschema debug - Debug modification counts")
    self:Print("/nagschema modify <type> <name> - Apply modification")
    self:Print("/nagschema help - Show this help")
end

--- Test custom handler integration functionality
function SchemaModifier:TestCustomHandlerIntegration()
    local SchemaModifications = NAG:GetModule("SchemaModifications")

    self:Print("=== Testing Custom Handler Integration ===")

    -- Check if we have a modified schema
    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema then
        self:Print("No modified schema available. Run validation first.")
        return
    end

    -- Check APLValue.fields for custom handlers
        if workingSchema.messages and workingSchema.messages.APLValue and workingSchema.messages.APLValue.fields then
        self:Print("APLValue.fields contains:")
        for handlerName, handlerData in pairs(workingSchema.messages.APLValue.fields) do
            if handlerName:find("custom") or handlerName:find("spell_is_casting") or handlerName:find("distance_to_target") or handlerName:find("time_to_percent") then
                local uiLabel = SchemaAccessor:GetFieldUILabel(handlerData, handlerName) or handlerName
                self:Print(format("  ✓ %s: %s", handlerName, uiLabel))
            end
        end
    else
        self:Print("APLValue.fields not found or empty")
    end

    -- Check APLAction.fields for custom handlers
        if workingSchema.messages and workingSchema.messages.APLAction and workingSchema.messages.APLAction.fields then
        self:Print("APLAction.fields contains:")
        for handlerName, handlerData in pairs(workingSchema.messages.APLAction.fields) do
            if handlerName:find("custom") or handlerName:find("select_rotation") then
                local uiLabel = SchemaAccessor:GetFieldUILabel(handlerData, handlerName) or handlerName
                self:Print(format("  ✓ %s: %s", handlerName, uiLabel))
            end
        end
    else
        self:Print("APLAction.fields not found or empty")
    end

    -- Check field_order arrays
        if workingSchema.messages and workingSchema.messages.APLValue and workingSchema.messages.APLValue.field_order then
        self:Print("APLValue.field_order contains custom handlers:")
        for _, handlerName in ipairs(workingSchema.messages.APLValue.field_order) do
            if handlerName:find("custom") or handlerName:find("spell_is_casting") or handlerName:find("distance_to_target") or handlerName:find("time_to_percent") then
                self:Print(format("  ✓ %s", handlerName))
            end
        end
    end

        if workingSchema.messages and workingSchema.messages.APLAction and workingSchema.messages.APLAction.field_order then
        self:Print("APLAction.field_order contains custom handlers:")
        for _, handlerName in ipairs(workingSchema.messages.APLAction.field_order) do
            if handlerName:find("custom") or handlerName:find("select_rotation") then
                self:Print(format("  ✓ %s", handlerName))
            end
        end
    end

    -- Check message types from SchemaModifications
    self:Print("Custom message types created:")
    for messageType, modification in pairs(self.schemaModifications) do
        if modification.function_type then
            self:Print(format("  ✓ %s (%s)", messageType, modification.function_type))
        end
    end

    -- Show version-specific information
    self:Print("")
    self:Print("Version Information:")

    local debugInfo = SchemaModifications:GetDebugInfo()
    self:Print(format("  Current Expansion: %s", debugInfo.currentExpansion))
    self:Print(format("  Global Modifications: %d", debugInfo.globalCount))
    self:Print(format("  Version-Specific Modifications: %d", debugInfo.versionSpecificCount))
    self:Print(format("  Total Active Modifications: %d", debugInfo.totalCount))
end

--- Test alias rebuilding functionality
function SchemaModifier:TestAliasRebuilding()
    self:Print("=== Testing Alias Rebuilding ===")

        -- Check current state
    self:Print("Current SchemaAccessor state:")
    self:Print(format("  Action Types: %s", SchemaAccessor.actionTypes and #SchemaAccessor.actionTypes or "nil"))
    self:Print(format("  Value Types: %s", SchemaAccessor.valueTypes and #SchemaAccessor.valueTypes or "nil"))
    self:Print(format("  Field Cache Size: %d", TableUtils.Size(SchemaAccessor.fieldCache or {})))

    -- Test rebuilding aliases
    self:Print("")
    self:Print("Rebuilding aliases...")
    self:RebuildSchemaAccessorAliases(SchemaAccessor)

    -- Check state after rebuilding
    self:Print("")
    self:Print("After rebuilding:")
    self:Print(format("  Action Types: %s", SchemaAccessor.actionTypes and #SchemaAccessor.actionTypes or "nil"))
    self:Print(format("  Value Types: %s", SchemaAccessor.valueTypes and #SchemaAccessor.valueTypes or "nil"))
    self:Print(format("  Field Cache Size: %d", TableUtils.Size(SchemaAccessor.fieldCache or {})))

    -- Show custom handlers in rebuilt arrays
    if SchemaAccessor.actionTypes then
        self:Print("")
        self:Print("Custom action types found:")
        for _, actionType in ipairs(SchemaAccessor.actionTypes) do
            if actionType:find("custom") or actionType:find("select_rotation") then
                self:Print(format("  ✓ %s", actionType))
            end
        end
    end

    if SchemaAccessor.valueTypes then
        self:Print("")
        self:Print("Custom value types found:")
        for _, valueType in ipairs(SchemaAccessor.valueTypes) do
            if valueType:find("custom") or valueType:find("spell_is_casting") or valueType:find("distance_to_target") or valueType:find("time_to_percent") then
                self:Print(format("  ✓ %s", valueType))
            end
        end
    end
end

--- Show the current schema structure for custom handlers
function SchemaModifier:ShowSchemaStructure()
    self:Print("=== Custom Handler Schema Structure ===")

    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema then
        self:Print("No modified schema available. Run validation first.")
        return
    end

    -- Show custom message types
    self:Print("Custom Message Types:")
    for messageType, modification in pairs(self.schemaModifications) do
        if modification.function_type then
            self:Print(format("  %s (%s):", messageType, modification.function_type))

            -- Show fields
            if modification.fields then
                for fieldName, fieldData in pairs(modification.fields) do
                    local typeInfo = fieldData.type
                    if fieldData.type == "enum" and fieldData.enum_type then
                        typeInfo = format("enum(%s)", fieldData.enum_type)
                    elseif fieldData.type == "message" and fieldData.message_type then
                        typeInfo = format("message(%s)", fieldData.message_type)
                    end

                    self:Print(format("    %s: %s (%s) - %s",
                        fieldName, typeInfo, fieldData.label, fieldData.description or "No description"))
                end
            end

            -- Show field order
            if modification.field_order then
                self:Print(format("    Field Order: %s", concat(modification.field_order, ", ")))
            end

            -- Show include_if information
            if modification.include_if then
                local includeInfo = "    Include If: "
                if modification.include_if.class_specific then
                    includeInfo = includeInfo .. format("Class: %s", tostring(modification.include_if.class_specific))
                end
                if modification.include_if.prepull_only ~= nil then
                    includeInfo = includeInfo .. format(", Prepull: %s", tostring(modification.include_if.prepull_only))
                end
                if modification.include_if.combat_only ~= nil then
                    includeInfo = includeInfo .. format(", Combat: %s", tostring(modification.include_if.combat_only))
                end
                if modification.include_if.spec_specific ~= nil then
                    includeInfo = includeInfo .. format(", Spec: %s", tostring(modification.include_if.spec_specific))
                end
                self:Print(includeInfo)
            end
        end
    end

    -- Show integration into APLValue/APLAction
        if workingSchema.messages and workingSchema.messages.APLValue then
        self:Print("")
        self:Print("APLValue Integration:")
        local aplValue = workingSchema.messages.APLValue
        if aplValue.fields then
            for fieldName, fieldData in pairs(aplValue.fields) do
                if fieldName:find("custom") or fieldName:find("spell_is_casting") or fieldName:find("distance_to_target") or fieldName:find("time_to_percent") then
                    self:Print(format("  ✓ %s: %s", fieldName, fieldData.message_type or "Unknown"))
                end
            end
        end

        if aplValue.field_order then
            self:Print(format("  Field Order: %s", concat(aplValue.field_order, ", ")))
        end
    end

        if workingSchema.messages and workingSchema.messages.APLAction then
        self:Print("")
        self:Print("APLAction Integration:")
        local aplAction = workingSchema.messages.APLAction
        if aplAction.fields then
            for fieldName, fieldData in pairs(aplAction.fields) do
                if fieldName:find("custom") or fieldName:find("select_rotation") then
                    self:Print(format("  ✓ %s: %s", fieldName, fieldData.message_type or "Unknown"))
                end
            end
        end

        if aplAction.field_order then
            self:Print(format("  Field Order: %s", concat(aplAction.field_order, ", ")))
        end
    end
end

--- Test include_if conditions and show examples
function SchemaModifier:TestIncludeIfConditions()
    self:Print("=== Testing IncludeIf Conditions ===")

    -- Test class-specific conditions
    self:Print("Class-specific conditions:")
    local hunterCondition = self:CreateClassIncludeIf("Hunter")
    self:Print(format("  Hunter: class_specific=%s, classes=%s",
        tostring(hunterCondition.class_specific),
        hunterCondition.classes and concat(hunterCondition.classes, ", ") or "none"))

    local dkCondition = self:CreateClassIncludeIf("DeathKnight")
    self:Print(format("  DeathKnight: class_specific=%s, classes=%s",
        tostring(dkCondition.class_specific),
        dkCondition.classes and concat(dkCondition.classes, ", ") or "none"))

    -- Test spec-specific conditions
    self:Print("Spec-specific conditions:")
    local balanceCondition = self:CreateSpecIncludeIf("BalanceDruid")
    self:Print(format("  BalanceDruid: spec_specific=%s, specs=%s",
        tostring(balanceCondition.spec_specific),
        balanceCondition.specs and concat(balanceCondition.specs, ", ") or "none"))

    local feralCondition = self:CreateSpecIncludeIf("FeralDruid")
    self:Print(format("  FeralDruid: spec_specific=%s, specs=%s",
        tostring(feralCondition.spec_specific),
        feralCondition.specs and concat(feralCondition.specs, ", ") or "none"))

    -- Test context-specific conditions
    self:Print("Context-specific conditions:")
    local prepullCondition = self:CreatePrepullOnlyIncludeIf()
    self:Print(format("  Prepull-only: prepull_only=%s, combat_only=%s",
        tostring(prepullCondition.prepull_only), tostring(prepullCondition.combat_only)))

    local combatCondition = self:CreateCombatOnlyIncludeIf()
    self:Print(format("  Combat-only: prepull_only=%s, combat_only=%s",
        tostring(combatCondition.prepull_only), tostring(combatCondition.combat_only)))

    -- Test healing spec condition
    self:Print("Healing spec condition:")
    local healingCondition = self:CreateHealingSpecIncludeIf()
    self:Print(format("  Healing specs: requires_healer_spec=%s, spec_specific=%s",
        tostring(healingCondition.requires_healer_spec), tostring(healingCondition.spec_specific)))

    -- Test raid-only condition
    self:Print("Raid-only condition:")
    local raidCondition = self:CreateRaidOnlyIncludeIf()
    self:Print(format("  Raid-only: requires_group=%s",
        tostring(raidCondition.requires_group)))

    -- Test custom condition
    self:Print("Custom condition:")
    local customCondition = self:CreateCustomIncludeIf({
        prepull_only = false,
        combat_only = false,
        spec_specific = false
    })
    self:Print(format("  Custom: prepull_only=%s, combat_only=%s, spec_specific=%s",
        tostring(customCondition.prepull_only),
        tostring(customCondition.combat_only),
        tostring(customCondition.spec_specific)))

    self:Print("=== IncludeIf Test Complete ===")
end

--- Show version-specific modification information
function SchemaModifier:ShowVersionSpecificInfo()
    local SchemaModifications = NAG:GetModule("SchemaModifications")
    self:Print("=== Version-Specific Modification Info ===")

        -- Get debug info from SchemaModifications
    SchemaModifications:PrintDebugInfo()

    -- Show current modifications
    self:Print("")
    self:Print("Current Active Modifications:")
    local count = 0
    for messageType, modification in pairs(self.schemaModifications) do
        count = count + 1
        local source = "Global"

        -- Check if this is version-specific
        local currentExpansion = ns.Version:GetExpansion()
        local versionMods = SchemaModifications.versionSpecificModifications[currentExpansion]
        if versionMods and versionMods[messageType] then
            source = "Version-Specific (" .. currentExpansion .. ")"
        end

        self:Print(format("  %d. %s (%s)", count, messageType, source))
    end

    self:Print("")
    self:Print("Total Active Modifications: " .. count)
end

--- Test field removal functionality
function SchemaModifier:TestFieldRemoval()
    self:Print("=== Testing Field Removal Functionality ===")

    local workingSchema = SchemaAccessor.schemaData
    if not workingSchema then
        self:Print("No modified schema available. Run validation first.")
        return
    end

    -- Check if DotPercentIncrease field removal was applied
        if workingSchema.messages and workingSchema.messages.APLValueDotPercentIncrease then
        local dotPercentIncrease = workingSchema.messages.APLValueDotPercentIncrease

        self:Print("APLValueDotPercentIncrease fields:")
        if dotPercentIncrease.fields then
            for fieldName, fieldData in pairs(dotPercentIncrease.fields) do
                self:Print(format("  %s: %s (%s)", fieldName, fieldData.type or "unknown", fieldData.label or "unknown"))
            end
        else
            self:Print("  No fields found")
        end

        -- Check if target_unit was removed
        if dotPercentIncrease.fields and dotPercentIncrease.fields.target_unit then
            self:Print("  ❌ ERROR: target_unit field still exists (should have been removed)")
        else
            self:Print("  ✅ SUCCESS: target_unit field was removed")
        end

        -- Check field_order
        if dotPercentIncrease.field_order then
            self:Print("Field order: " .. concat(dotPercentIncrease.field_order, ", "))

            local hasTargetUnit = false
            for _, fieldName in ipairs(dotPercentIncrease.field_order) do
                if fieldName == "target_unit" then
                    hasTargetUnit = true
                    break
                end
            end

            if hasTargetUnit then
                self:Print("  ❌ ERROR: target_unit still in field_order (should have been removed)")
            else
                self:Print("  ✅ SUCCESS: target_unit removed from field_order")
            end
        end
    else
        self:Print("APLValueDotPercentIncrease not found in modified schema")
    end

    -- Show field removal modifications
    self:Print("")
    self:Print("Field Removal Modifications:")
    local removalCount = 0
    for messageType, modification in pairs(self.schemaModifications) do
        if modification.modification_type == "field_removal" then
            removalCount = removalCount + 1
            self:Print(format("  %d. %s:", removalCount, messageType))
            if modification.fields_to_remove then
                self:Print(format("    Fields to remove: %s", concat(modification.fields_to_remove, ", ")))
            end
            if modification.description then
                self:Print(format("    Description: %s", modification.description))
            end
        end
    end

    if removalCount == 0 then
        self:Print("  No field removal modifications found")
    else
        self:Print(format("  Total field removal modifications: %d", removalCount))
    end

    self:Print("=== Field Removal Test Complete ===")
end

--- Debug modification counts to understand why MOD: 0 is showing
function SchemaModifier:DebugModificationCounts()
    local SchemaModifications = NAG:GetModule("SchemaModifications")
    self:Print("=== Debug Modification Counts ===")

    -- Check SchemaModifications module
        -- Get counts from SchemaModifications
    local globalCount = SchemaModifications:GetGlobalModificationCount()
    local versionCount = SchemaModifications:GetVersionSpecificModificationCount()
    local totalCount = SchemaModifications:GetModificationCount()

    self:Print(format("SchemaModifications counts:"))
    self:Print(format("  Global modifications: %d", globalCount))
    self:Print(format("  Version-specific modifications: %d", versionCount))
    self:Print(format("  Total modifications: %d", totalCount))

    -- Check SchemaModifier's loaded modifications
    local loadedCount = TableUtils.Size(self.schemaModifications)
    self:Print(format("SchemaModifier loaded modifications: %d", loadedCount))

    -- List all loaded modifications
    self:Print("")
    self:Print("Loaded modifications:")
    local count = 0
    for messageType, modification in pairs(self.schemaModifications) do
        count = count + 1
        local modType = modification.modification_type or "full"
        self:Print(format("  %d. %s (%s)", count, messageType, modType))

        if modification.modification_type == "field_removal" then
            self:Print(format("    Fields to remove: %s", concat(modification.fields_to_remove or {}, ", ")))
        end
    end

    -- Check if DotPercentIncrease field removal is loaded
    local dotPercentMod = self.schemaModifications["APLValueDotPercentIncrease"]
    if dotPercentMod then
        self:Print("")
        self:Print("✅ APLValueDotPercentIncrease modification found:")
        self:Print(format("  Type: %s", dotPercentMod.modification_type or "unknown"))
        if dotPercentMod.fields_to_remove then
            self:Print(format("  Fields to remove: %s", concat(dotPercentMod.fields_to_remove, ", ")))
        end
    else
        self:Print("")
        self:Print("❌ APLValueDotPercentIncrease modification NOT found")
    end

    -- Check validation report generation
    self:Print("")
    self:Print("Validation report would show:")
    self:Print(format("  modifications = %d (from self.schemaModifications)", loadedCount))

    self:Print("=== Debug Complete ===")
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~

--- Get the modified schema
--- @return table|nil The modified schema or nil if not available
function SchemaModifier:GetModifiedSchema()
    return SchemaAccessor.schemaData
end

--- Check if schema has been modified
--- @return boolean True if schema has been modified
function SchemaModifier:IsSchemaModified()
    return SchemaAccessor.schemaData ~= nil
end

--- Get all active modifications
--- @return table Table of active modifications
function SchemaModifier:GetActiveModifications()
    return self.schemaModifications
end

--- Add a new modification at runtime
--- @param messageType string The message type to modify
--- @param modification table The modification to apply
--- @return boolean True if modification was added successfully
function SchemaModifier:AddModification(messageType, modification)
    if not messageType or type(messageType) ~= "string" then
        self:Error("Invalid message type provided to AddModification")
        return false
    end

    if not modification or type(modification) ~= "table" then
        self:Error("Invalid modification data provided to AddModification")
        return false
    end

    -- Add the modification
    self.schemaModifications[messageType] = modification

    -- Reapply modifications if schema is already loaded
    if self.initialized then
        self:ApplySchemaModifications()
    end

    self:Debug("Added modification for %s", messageType)
    return true
end

--- Remove a modification
--- @param messageType string The message type to remove modification from
--- @return boolean True if modification was removed successfully
function SchemaModifier:RemoveModification(messageType)
    if not messageType then
        return false
    end

    if self.schemaModifications[messageType] then
        self.schemaModifications[messageType] = nil

        -- Reapply modifications if schema is already loaded
        if self.initialized then
            self:ApplySchemaModifications()
        end

        self:Debug("Removed modification for %s", messageType)
        return true
    end

    return false
end

-- ~~~~~~~~~~ DEBUG AND UTILITY ~~~~~~~~~~

--- Get debug information about the schema modifier
--- @return table Debug information
function SchemaModifier:GetDebugInfo()
    local info = {
        initialized = self.initialized,
        modificationCount = TableUtils.Size(self.schemaModifications),
        schemaModified = self:IsSchemaModified(),
        activeModifications = {}
    }

    -- List active modifications
    for name, _ in pairs(self.schemaModifications) do
        tinsert(info.activeModifications, name)
    end

    -- Sort modification list for readability
    sort(info.activeModifications)

    return info
end

--- Print debug information to chat
function SchemaModifier:PrintDebugInfo()
    local info = self:GetDebugInfo()

    self:Print("=== SchemaModifier Debug Info ===")
    self:Print(format("Initialized: %s", tostring(info.initialized)))
    self:Print(format("Modifications: %d", info.modificationCount))
    self:Print(format("Schema Modified: %s", tostring(info.schemaModified)))

    if info.modificationCount > 0 then
        self:Print("Active Modifications: " .. concat(info.activeModifications, ", "))
    end
end
