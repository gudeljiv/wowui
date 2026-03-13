--- @module "NAG.SchemaAccessor"
--- Provides efficient, lazy access to protobuf schema data without excessive memory usage.
---
--- This module implements a lightweight accessor pattern that:
--- - Loads schema data on-demand only
--- - Caches minimal information (names, types, order)
--- - Avoids deep copying of schema structures
--- - Provides fast lookups for runtime use
---
--- ARCHITECTURE:
--- - SchemaAccessor loads the base schema from ns.protoSchema
--- - SchemaModifier applies modifications and updates SchemaAccessor's schema data
--- - SchemaAccessor provides access to the final (potentially modified) schema
--- - Clean separation: SchemaAccessor = access, SchemaModifier = modifications
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type SchemaUtils
local SchemaUtils

local TableUtils = ns.TableUtils
local Version = ns.Version
local Types = ns.Types
local WoWAPI = ns.WoWAPI
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local IsInRaid = _G.IsInRaid
local GetSpellLink = C_Spell and C_Spell.GetSpellLink or _G.GetSpellLink

local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local tinsert = tinsert
local wipe = wipe

-- Standard Lua functions
local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class SchemaAccessor:CoreModule
local SchemaAccessor = NAG:CreateModule("SchemaAccessor", nil, {
    messageHandlers = {
        -- NAG_VERSION_DATA_SELECTED = true,
    },
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.PROCESSORS
    },
    -- Automatic slash command registration
    slashCommands = {
        ["schema_validate"] = {
            handler = true,
            help = "Validate schema structure (metadata in _metadata, proto fields in correct locations)",
            root = "nagdebug",
            path = {"schema", "validate"},
            category = "Debug"
        },
        ["schema_metadata"] = {
            handler = true,
            help = "Dump metadata for a message type: /nagdebug schema metadata <MessageType>",
            root = "nagdebug",
            path = {"schema", "metadata"},
            category = "Debug"
        }
    }
})
local module = SchemaAccessor
ns.SchemaAccessor = SchemaAccessor

-- Initialize module properties
SchemaAccessor.schemaData = nil
SchemaAccessor.expansionKey = nil
SchemaAccessor.loaded = false

-- Minimal caches for frequently accessed data
SchemaAccessor.fieldCache = {}   -- Cache field information by message type
SchemaAccessor.actionTypes = nil -- Cached action types
SchemaAccessor.valueTypes = nil  -- Cached value types
SchemaAccessor.majorCooldownCache = nil
SchemaAccessor.protoToNagCache = nil -- Cached protoName -> nagName mappings

-- Generated functions storage (populated by APLFunctionGenerator if auto-generation enabled)
SchemaAccessor.generatedFunctions = nil -- Initialized on-demand by APLFunctionGenerator

-- NAG function name mappings (NAG function names -> proto names)
-- These mappings handle runtime aliases and naming inconsistencies
-- Runtime aliases are defined in APL_Aliases.lua
-- This table maps NAG function names (including runtime aliases) to their proto message types
SchemaAccessor.nagFunctionMappings = {
    -- Core casting actions
    ["Cast"] = "APLActionCastSpell",  -- Alias for backward compatibility (will be removed eventually)
    ["Channel"] = "APLActionChannelSpell",

    -- Aura compatibility alias
    ["IsActive"] = "APLValueAuraIsActive",
    ["HasGlyph"] = "APLValueHasGlyph",

    -- Spell-related runtime aliases
    -- APL_Aliases.lua defines: NAG.SpellIsReady = NAG.IsReady

    -- Movement-related runtime aliases
    -- Note: MoveToRange may be handled by schema field name conversion
    -- ["MoveToRange"] = "APLActionMoveToRange",  -- Uncomment if needed

    -- Operator runtime aliases
    -- APL_Aliases.lua defines: NAG.Compare = NAG.Cmp
    ["Cmp"] = "APLValueCompare",

    -- Tank-specific damage taken aliases (all map to same proto)
    -- APL_Aliases.lua defines these as runtime aliases to DamageTakenLastGlobal
    ["ProtectionPaladinDamageTakenLastGlobal"] = "APLValueDamageTakenLastGlobal",
    ["ProtectionWarriorDamageTakenLastGlobal"] = "APLValueDamageTakenLastGlobal",
    ["GuardianDruidDamageTakenLastGlobal"] = "APLValueDamageTakenLastGlobal",
    ["BrewmasterMonkDamageTakenLastGlobal"] = "APLValueDamageTakenLastGlobal",
    ["BloodDeathKnightDamageTakenLastGlobal"] = "APLValueDamageTakenLastGlobal",

    -- Druid eclipse: CurrentEclipsePhase is canonical name; schema field is druid_current_eclipse_phase
    -- APL_Aliases.lua validates CurrentEclipsePhase; runtime may alias to CurrentEclipseEnergy -> CurrentGenericResource
    ["CurrentEclipsePhase"] = "APLValueDruidCurrentEclipsePhase",
}

-- Merge NAG function mappings from SchemaModifications (e.g. SpellCanCastResolved, AuraIsActiveResolved)
do
    local SchemaModifications = NAG:GetModule("SchemaModifications", true)
    if SchemaModifications and SchemaModifications.nagFunctionMappingsAdditions then
        for k, v in pairs(SchemaModifications.nagFunctionMappingsAdditions) do
            SchemaAccessor.nagFunctionMappings[k] = v
        end
    end
end

--[[---------------------------------------------------------------------------
_METADATA CONTRACT

Each proto field may optionally expose a `_metadata` table with the following
shape (new AST pipeline - all metadata flattened directly into _metadata):

{
    -- UI Metadata (flat, direct keys)
    uiLabel = "...",
    shortDescription = "...",
    fullDescription = "...",
    submenu = {...},
    include_if = {...},
    defaults = {...},

    -- Go Metadata (flat, direct keys - no .go wrapper)
    spell = { ... }, -- Array of normalized Go spell registrations
    aura = { ... },  -- Array of normalized Go aura registrations

    -- TypeScript Metadata (for diagnostic builds only)
    ts_raw = {
        {
            source = "...",        -- Source TypeScript file
            export = "StatsBuff",  -- Export/constructor that produced this field
            fieldAlias = "hornOfWinter",
            ids = { spell = {19506}, item = {...} },
            label = "Horn of Winter",
            showWhen = "player.isRaid()",
            values = { "hornOfWinter", ... },
        },
        ...
    },
    diagnostics = {
        -- Reserved for generator diagnostics (ambiguous matches, etc.)
    }
}

SchemaAccessor now reads `_metadata` exclusively instead of the legacy
`schema.go_metadata` tables.
---------------------------------------------------------------------------]]

-- ============================ CLASS INFERENCE HELPERS ============================
local KNOWN_CLASS_TOKENS = {
    ["death_knight"] = true,
    ["demon_hunter"] = true,
    ["druid"] = true,
    ["hunter"] = true,
    ["mage"] = true,
    ["monk"] = true,
    ["paladin"] = true,
    ["priest"] = true,
    ["rogue"] = true,
    ["shaman"] = true,
    ["warlock"] = true,
    ["warrior"] = true
}

local CLASS_ALIASES = {
    ["dk"] = "death_knight",
    ["deathknight"] = "death_knight",
    ["death_knight"] = "death_knight",
    ["demonhunter"] = "demon_hunter",
    ["demon_hunter"] = "demon_hunter",
    ["dh"] = "demon_hunter",
    ["mage"] = "mage",
    ["priest"] = "priest",
    ["warrior"] = "warrior",
    ["warlock"] = "warlock",
    ["paladin"] = "paladin",
    ["hunter"] = "hunter",
    ["rogue"] = "rogue",
    ["shaman"] = "shaman",
    ["druid"] = "druid",
    ["monk"] = "monk"
}

local COOLDOWN_TYPE_ALIASES = {
    ["unknown"] = "Unknown",
    ["mana"] = "Mana",
    ["dps"] = "DPS",
    ["explosive"] = "Explosive",
    ["survival"] = "Survival"
}

local function normalizeClassToken(token)
    if type(token) ~= "string" then
        return nil
    end

    local lowered = token:lower()
    lowered = lowered:gsub("[^%a_]", "_")
    lowered = lowered:gsub("_+", "_")
    lowered = lowered:gsub("^_", "")
    lowered = lowered:gsub("_$", "")

    if lowered == "" then
        return nil
    end

    if CLASS_ALIASES[lowered] then
        return CLASS_ALIASES[lowered]
    end

    if KNOWN_CLASS_TOKENS[lowered] then
        return lowered
    end

    return nil
end

local function normalizeSpecToken(token)
    if type(token) ~= "string" then
        return nil
    end

    local lowered = token:lower()
    lowered = lowered:gsub("[^%a_]", "_")
    lowered = lowered:gsub("_+", "_")
    lowered = lowered:gsub("^_", "")
    lowered = lowered:gsub("_$", "")

    if lowered == "" then
        return nil
    end

    return lowered
end

local function detectClassFromText(text)
    if type(text) ~= "string" then
        return nil
    end

    local lowered = text:lower()

    for alias, canonical in pairs(CLASS_ALIASES) do
        local pattern = "%f[%w]" .. alias .. "%f[%W]"
        if lowered:find(pattern) then
            return canonical
        end
    end

    for classToken in pairs(KNOWN_CLASS_TOKENS) do
        local pattern = "%f[%w]" .. classToken .. "%f[%W]"
        if lowered:find(pattern) then
            return classToken
        end
    end

    return nil
end

local function inferClassFromSource(sourceFile)
    if type(sourceFile) ~= "string" then
        return nil
    end

    local lowered = sourceFile:lower()

    for classToken in pairs(KNOWN_CLASS_TOKENS) do
        local identifier = classToken:gsub("_", "")
        local pattern = "/" .. identifier .. "/"
        if lowered:find(pattern, 1, true) then
            return classToken
        end
    end

    for alias, canonical in pairs(CLASS_ALIASES) do
        local pattern = "/" .. alias .. "/"
        if lowered:find(pattern, 1, true) then
            return canonical
        end
    end

    return nil
end

local function inferClassForEntry(entry, fallbackClass)
    if type(entry) ~= "table" then
        return fallbackClass
    end

    local classToken = inferClassFromSource(entry.source_file)
    if not classToken and entry.ClassSpellMask then
        classToken = detectClassFromText(entry.ClassSpellMask)
    end
    if not classToken and entry.function_name then
        classToken = detectClassFromText(entry.function_name)
    end
    if not classToken and entry.registration_type then
        classToken = detectClassFromText(entry.registration_type)
    end
    if not classToken and entry.label then
        classToken = detectClassFromText(entry.label)
    end

    return classToken or fallbackClass
end

local function resolveCooldownCategory(category)
    if category == nil then
        return nil, nil
    end

    if type(category) == "number" then
        return nil, category
    end

    if type(category) ~= "string" then
        return nil, nil
    end

    local cleaned = category:gsub("^core%.", "")
    cleaned = cleaned:gsub("^CooldownType", "")
    cleaned = cleaned:gsub("^cooldown_type_", "")
    cleaned = cleaned:gsub("^cooldown_", "")
    cleaned = cleaned:gsub("^type_", "")
    cleaned = cleaned:gsub("^_", "")

    if cleaned == "" then
        return nil, nil
    end

    local lowered = cleaned:lower()
    local canonical = COOLDOWN_TYPE_ALIASES[lowered] or cleaned
    if canonical ~= canonical:upper() and canonical ~= canonical:lower() then
        -- Already mixed case, keep as-is
    elseif canonical == canonical:lower() then
        canonical = canonical:sub(1, 1):upper() .. canonical:sub(2):lower()
    end

    local cooldownType = Types and Types:GetType("CooldownType")
    local id = nil
    if cooldownType then
        id = cooldownType[canonical] or cooldownType[canonical:upper()]
    end

    return canonical, id
end

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
function SchemaAccessor:ModuleEnable()
end

--- Called when the module is disabled - proper cache cleanup
--- @param self SchemaAccessor
function SchemaAccessor:ModuleDisable()
    self:Info("Disabling SchemaAccessor - cleaning up caches")

    -- Reset state completely
    self:ResetState()
end

function SchemaAccessor:ModuleInitialize()
    SchemaUtils = NAG:GetModule("SchemaUtils", true)
        local startTime = debugprofilestop()

    -- Ensure clean state before initialization
    if self.loaded then
        self:ResetState()
    end

    self.majorCooldownCache = nil

    -- Get expansion key
    self.expansionKey = Version:GetExpansion()
    if not self.expansionKey then
        self:Error("Could not determine expansion key during initialization")
        return
    end

    if self.debug then self:Debug("SchemaAccessor initialized for expansion: %s", self.expansionKey) end

    local endTime = debugprofilestop()
    if self.debug then self:Debug("SchemaAccessor initialization took %.2f ms", endTime - startTime) end
end

-- ~~~~~~~~~~ CORE SCHEMA ACCESS ~~~~~~~~~~

--- Get the raw schema data (lazy loaded)
--- Returns the modified schema if SchemaModifier has applied modifications via SetSchema(),
--- otherwise returns the base schema loaded from ns.protoSchema
--- @return table|nil The schema data
function SchemaAccessor:GetSchemaData()
    if not self.loaded then
        self:LoadSchema()
    end

    -- Return self.schemaData which will be:
    -- - Modified schema if SchemaModifier called SetSchema() with modifications
    -- - Base schema if no modifications were applied
    return self.schemaData
end

--- Load schema data on-demand
function SchemaAccessor:LoadSchema()
    if self.loaded then return end

    local startTime = debugprofilestop()

    -- Ensure expansion key is set
    if not self.expansionKey then
        self.expansionKey = Version:GetExpansion()
        if not self.expansionKey then
            self:Error("Could not determine expansion key during schema loading")
            return
        end
    end

    -- Always create a copy of ns.protoSchema (never use direct reference)
    -- This ensures SchemaAccessor.schemaData is always a working copy
    if ns.protoSchema and ns.protoSchema[self.expansionKey] then
        -- Get SchemaModifier for DeepCopySchema function
        local SchemaModifier = NAG:GetModule("SchemaModifier", true)
        if SchemaModifier and SchemaModifier.DeepCopySchema then
            self.schemaData = SchemaModifier:DeepCopySchema(ns.protoSchema[self.expansionKey])
        else
            -- Fallback: simple table copy (not deep, but better than direct reference)
            self:Warn("SchemaModifier not available for deep copy, using shallow copy")
            self.schemaData = {}
            for k, v in pairs(ns.protoSchema[self.expansionKey]) do
                self.schemaData[k] = v
            end
        end

        -- Custom handlers are now handled entirely by SchemaModifier
        -- No need to integrate them here

        -- Schema modifications are now handled entirely by SchemaModifier
        -- No need to call ApplySchemaModifications here

        self.loaded = true

        if self.debug then self:Debug("Loaded schema for %s (%.2f KB)", self.expansionKey, collectgarbage("count")) end
    else
        self:Error(format("No schema found for expansion: %s", self.expansionKey or "unknown"))
        return
    end

    local endTime = debugprofilestop()
    if self.debug then self:Debug("Schema loading took %.2f ms", endTime - startTime) end
end

-- SchemaModifier now handles all schema modifications

-- ============================ SCHEMA UPDATE API ============================
--- Set the active schema and refresh all internal caches.
--- This is the only supported way to replace the schema at runtime.
--- @param modifiedSchema table
function SchemaAccessor:SetSchema(modifiedSchema)
    if not modifiedSchema or type(modifiedSchema) ~= "table" then
        self:Error("SetSchema: invalid schema provided (expected table)")
        return
    end
    self.schemaData = modifiedSchema
    self.loaded = true

    -- Then clear caches
    self:OnSchemaUpdated()
end

--- Called whenever the active schema changes.
--- Clears caches and rebuilds light-weight indices on next access.
function SchemaAccessor:OnSchemaUpdated()
    -- Clear internal caches
    self:ClearCaches()
    -- Reset major cooldown cache
    self.majorCooldownCache = nil
    -- Clear translation cache
    self.protoToNagCache = nil
    if self.debug then
        self:Debug("Schema updated; caches cleared and will rebuild lazily")
    end
end

-- SchemaModifier integration: SchemaModifier calls SetSchema() directly to update the schema
-- No callback needed - the modified schema is stored in self.schemaData via SetSchema()

--- Get all action types (cached)
--- @return table Array of action type names
function SchemaAccessor:GetActionTypes()
    if not self.actionTypes then
        self.actionTypes = {}
        local schema = self:GetSchemaData()
        if schema and schema.messages and schema.messages.APLAction and
            schema.messages.APLAction.fields then
            for actionType, _ in pairs(schema.messages.APLAction.fields) do
                tinsert(self.actionTypes, actionType)
            end
            sort(self.actionTypes)
        end
    end
    return self.actionTypes
end

--- Get all value types (cached)
--- @return table Array of value type names
function SchemaAccessor:GetValueTypes()
    if not self.valueTypes then
        self.valueTypes = {}
        local schema = self:GetSchemaData()
        if schema and schema.messages and schema.messages.APLValue and
            schema.messages.APLValue.fields then
            for valueType, _ in pairs(schema.messages.APLValue.fields) do
                tinsert(self.valueTypes, valueType)
            end
            sort(self.valueTypes)
        end
    end
    return self.valueTypes
end

--- Get field information for a message type (cached)
--- @param messageType string The message type name
--- @param subType string|nil The subtype (for APLAction/APLValue)
--- @return table, table Field definitions and field order
function SchemaAccessor:GetFields(messageType, subType)
    local cacheKey = messageType .. (subType and "_" .. subType or "")

    if not self.fieldCache[cacheKey] then
        local fields, fieldOrder = self:LoadFields(messageType, subType)
        self.fieldCache[cacheKey] = {
            fields = fields,
            fieldOrder = fieldOrder
        }
    end

    return self.fieldCache[cacheKey].fields, self.fieldCache[cacheKey].fieldOrder
end

--- Get message schema by message type name
--- @param messageType string The message type name (e.g., "UnitReference", "ActionID")
--- @return table|nil The message schema or nil if not found
function SchemaAccessor:GetMessageSchema(messageType)

    if not self.schemaData or not self.schemaData.messages then
        self:Warn("GetMessageSchema: Schema not loaded or messages missing - cannot retrieve messageType='%s'",
            messageType or "nil")
        return nil
    end

    local messageSchema = self.schemaData.messages[messageType]
    if not messageSchema then
        self:Warn("GetMessageSchema: Message type '%s' not found in schema",
            messageType or "nil")
        return nil
    end

    --self:Info("GetMessageSchema: Successfully retrieved message schema for messageType='%s'", messageType)
    return messageSchema
end

--- Get message schema directly from an APLValue/APLAction field name
--- No conversion needed - looks up directly from schema structure
--- @param fieldName string The field name (snake_case, e.g., "max_energy")
--- @param container string "APLValue" or "APLAction" (default: "APLValue")
--- @return table|nil The full message schema or nil if not found
function SchemaAccessor:GetMessageSchemaFromFieldName(fieldName, container)
    if not fieldName or type(fieldName) ~= "string" then
        return nil
    end

    container = container or "APLValue"

    local schema = self:GetSchemaData()
    if not schema or not schema.messages or not schema.messages[container] then
        return nil
    end

    local fieldInfo = schema.messages[container].fields[fieldName]
    if not fieldInfo or not fieldInfo.message_type then
        return nil
    end

    -- Direct lookup - no conversion needed
    return schema.messages[fieldInfo.message_type]
end

--- Load field information on-demand
--- @param messageType string The message type name
--- @param subType string|nil The subtype
--- @return table, table Field definitions and field order
function SchemaAccessor:LoadFields(messageType, subType)
    local schema = self:GetSchemaData()
    if not schema or not schema.messages then
        self:Warn("LoadFields: Schema not loaded or messages missing for messageType '%s'", messageType or "nil")
        return {}, {}
    end

    -- Handle APLAction and APLValue subtypes
    if (messageType == "APLAction" or messageType == "APLValue") and subType then
        local aplMessage = schema.messages[messageType]
        if not aplMessage then
            self:Warn("LoadFields: Message type '%s' not found in schema", messageType)
            return {}, {}
        end

        if not aplMessage.fields then
            self:Warn("LoadFields: Message type '%s' has no fields table", messageType)
            return {}, {}
        end

        if not aplMessage.fields[subType] then
            self:Warn("LoadFields: SubType '%s' not found in %s.fields", subType, messageType)
            return {}, {}
        end

        local subTypeInfo = aplMessage.fields[subType]
        local subMessageTypeName = subTypeInfo.message_type
        if not subMessageTypeName then
            self:Warn("LoadFields: SubType '%s' in %s has no message_type", subType, messageType)
            return {}, {}
        end

        local subMessage = schema.messages[subMessageTypeName]
        if not subMessage then
            self:Warn("LoadFields: SubMessage type '%s' (from %s.%s) not found in schema", subMessageTypeName, messageType, subType)
            return {}, {}
        end

        if not subMessage.fields then
            self:Warn("LoadFields: SubMessage type '%s' has no fields table", subMessageTypeName)
            return {}, {}
        end

        if not subMessage.field_order then
            self:Warn("LoadFields: SubMessage type '%s' has no field_order table", subMessageTypeName)
            return {}, {}
        end

        -- Debug: Check if any subMessage fields are missing message_type
        if subMessage.fields then
            for fieldName, fieldDef in pairs(subMessage.fields) do
                if fieldDef and fieldDef.type == "message" and not fieldDef.message_type then
                    local fieldDefKeys = {}
                    for k, v in pairs(fieldDef) do
                        if k ~= "_metadata" then
                            table.insert(fieldDefKeys, string.format("%s=%s", k, tostring(v)))
                        end
                    end
                    self:Warn("LoadFields: SubMessage type '%s' (from %s.%s), field '%s' has type='message' but message_type is nil! fieldDef keys: %s",
                        subMessageTypeName, messageType, subType, fieldName, table.concat(fieldDefKeys, ", "))
                end
            end
        end

        return subMessage.fields, subMessage.field_order
    end

    -- Handle regular message types
    local message = schema.messages[messageType]
    if not message then
        self:Warn("LoadFields: Message type '%s' not found in schema", messageType)
        return {}, {}
    end

    if not message.fields then
        self:Warn("LoadFields: Message type '%s' has no fields table", messageType)
        return {}, {}
    end

    if not message.field_order then
        self:Warn("LoadFields: Message type '%s' has no field_order table", messageType)
        return {}, {}
    end

    -- Debug: Check if any message fields are missing message_type
    if message.fields then
        for fieldName, fieldDef in pairs(message.fields) do
            if fieldDef and fieldDef.type == "message" and not fieldDef.message_type then
                local fieldDefKeys = {}
                for k, v in pairs(fieldDef) do
                    if k ~= "_metadata" then
                        table.insert(fieldDefKeys, string.format("%s=%s", k, tostring(v)))
                    end
                end
                self:Warn("LoadFields: Message type '%s', field '%s' has type='message' but message_type is nil! fieldDef keys: %s",
                    messageType, fieldName, table.concat(fieldDefKeys, ", "))
            end
        end
    end

    return message.fields, message.field_order
end

--- Get field names for a type (minimal data)
--- @param category string "Actions" or "Values"
--- @param typeKey string The type key
--- @return table Array of field names
function SchemaAccessor:GetFieldNames(category, typeKey)
    local metadata = nil
    if category == "Actions" then
        metadata = self:GetMetadataByIdentifier(typeKey, nil)
    elseif category == "Values" then
        metadata = self:GetMetadataByIdentifier(typeKey, nil)
    end

    if not metadata or not metadata.protoName then
        self:Warn("GetFieldNames: No metadata found for category '%s', typeKey '%s'", category, typeKey or "nil")
        return {}
    end

    local fields, _ = self:GetFields(metadata.protoName)
    if not fields then
        self:Warn("GetFieldNames: No fields found for protoName '%s' (category '%s', typeKey '%s')", metadata.protoName, category, typeKey)
        return {}
    end

    local fieldNames = {}
    for fieldName, _ in pairs(fields) do
        if fieldName ~= "field_order" then
            tinsert(fieldNames, fieldName)
        end
    end

    return fieldNames
end

-- ============================ METADATA ACCESS HELPERS ============================
-- These helpers provide a single source of truth for accessing metadata from _metadata
-- All metadata is stored in messageType._metadata with snake_case keys
-- Field-specific metadata is located at messageType._metadata.fields[fieldName]

--- Get the field metadata from a message schema
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return table The field metadata table or empty table
function SchemaAccessor:GetFieldMetadata(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        if fieldName then
            self:Warn("GetFieldMetadata: Invalid messageSchema for field '%s' (expected table, got %s)", fieldName, type(messageSchema))
        end
        return {}
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldMetadata: Missing _metadata for field '%s'", fieldName)
        end
        return {}
    end

    -- Field-specific metadata is at messageSchema._metadata.fields[fieldName]
    if messageSchema._metadata.fields and messageSchema._metadata.fields[fieldName] then
        return messageSchema._metadata.fields[fieldName]
    end

    -- Field metadata not found - warn but return empty table for backward compatibility
    if fieldName then
        self:Trace("GetFieldMetadata: Field-specific metadata not found for field '%s' in messageSchema (no _metadata.fields[%s])", fieldName, fieldName)
    end
    return {}
end

--- Get the UI label from field metadata
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The UI label or nil if missing
function SchemaAccessor:GetFieldUILabel(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        if fieldName then
            self:Warn("GetFieldUILabel: Invalid messageSchema for field '%s' (expected table, got %s)", fieldName, type(messageSchema))
        end
        return nil
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldUILabel: No _metadata found for field '%s'", fieldName)
        end
        return nil
    end

    -- First check field-specific metadata
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)
    if fieldMetadata and fieldMetadata.ui_label then
        return fieldMetadata.ui_label
    end

    -- Check message-level metadata
    if messageSchema._metadata.ui_label then
        return messageSchema._metadata.ui_label
    end

    -- ui_label not found - warn
    if fieldName then
        self:Warn("GetFieldUILabel: ui_label not found for field '%s' (checked field-specific and message-level metadata)", fieldName)
    else
        self:Warn("GetFieldUILabel: ui_label not found (checked message-level metadata)")
    end
    return nil
end

--- Get the short description from field metadata
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The short description or nil if missing
function SchemaAccessor:GetFieldShortDescription(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        self:Warn("GetFieldShortDescription: Invalid messageSchema (expected table, got %s)", type(messageSchema))
        return nil
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldShortDescription: No _metadata found for field '%s'", fieldName)
        else
            self:Warn("GetFieldShortDescription: No _metadata found")
        end
        return nil
    end

    -- First check field-specific metadata
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)
    if fieldMetadata and fieldMetadata.short_description then
        return fieldMetadata.short_description
    end

    -- Check message-level metadata
    if messageSchema._metadata.short_description then
        return messageSchema._metadata.short_description
    end

    -- short_description not found - warn
    if fieldName then
        self:Warn("GetFieldShortDescription: short_description not found for field '%s' (checked field-specific and message-level metadata)", fieldName)
    else
        self:Warn("GetFieldShortDescription: short_description not found (checked message-level metadata)")
    end
    return nil
end


--- Get the full description from field metadata
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The full description or nil
function SchemaAccessor:GetFieldFullDescription(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        return nil
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldFullDescription: No _metadata found for field '%s'", fieldName)
        end
        return nil
    end

    -- First check field-specific metadata
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)
    if fieldMetadata and fieldMetadata.full_description then
        return fieldMetadata.full_description
    end

    -- Check message-level metadata
    if messageSchema._metadata.full_description then
        return messageSchema._metadata.full_description
    end

    return nil
end

--- Get the submenu from field metadata
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return table|nil The submenu array or nil if missing
function SchemaAccessor:GetFieldSubmenu(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        self:Warn("GetFieldSubmenu: Invalid messageSchema (expected table, got %s)", type(messageSchema))
        return nil
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldSubmenu: No _metadata found for field '%s'", fieldName)
        else
            self:Warn("GetFieldSubmenu: No _metadata found")
        end
        return nil
    end

    -- First check field-specific metadata
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)
    if fieldMetadata and fieldMetadata.submenu then
        return fieldMetadata.submenu
    end

    -- Check message-level metadata
    if messageSchema._metadata.submenu then
        return messageSchema._metadata.submenu
    end

    -- submenu not found - warn
    if fieldName then
        self:Warn("GetFieldSubmenu: submenu not found for field '%s' (checked field-specific and message-level metadata)", fieldName)
    else
        self:Warn("GetFieldSubmenu: submenu not found (checked message-level metadata)")
    end
    return nil
end

--- Get the category from field metadata
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The category string or nil if missing
function SchemaAccessor:GetFieldCategory(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        self:Warn("GetFieldCategory: Invalid messageSchema (expected table, got %s)", type(messageSchema))
        return nil
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldCategory: No _metadata found for field '%s'", fieldName)
        else
            self:Warn("GetFieldCategory: No _metadata found")
        end
        return nil
    end

    -- First check field-specific metadata
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)
    if fieldMetadata and fieldMetadata.category then
        return fieldMetadata.category
    end

    -- Check message-level metadata
    if messageSchema._metadata.category then
        return messageSchema._metadata.category
    end

    -- category not found - return nil silently (category is optional, primarily for buff/debuff)
    return nil
end

--- Get the include_if metadata from field metadata
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return table|nil The include_if metadata table or nil
function SchemaAccessor:GetFieldIncludeIf(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        return nil
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldIncludeIf: No _metadata found for field '%s'", fieldName)
        end
        return nil
    end

    -- First check field-specific metadata
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)
    if fieldMetadata and fieldMetadata.include_if then
        return fieldMetadata.include_if
    end

    -- Check message-level metadata
    if messageSchema._metadata.include_if then
        return messageSchema._metadata.include_if
    end

    return nil
end

--- Get the default value from field metadata
--- @param messageSchema table The message schema (message type)
--- @param fieldName string|nil The field name (nil for message-level defaults table)
--- @return any|table|nil The default value, message-level defaults table, or nil
function SchemaAccessor:GetFieldDefaults(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        return nil
    end

    if not messageSchema._metadata or type(messageSchema._metadata) ~= "table" then
        if fieldName then
            self:Warn("GetFieldDefaults: No _metadata found for field '%s'", fieldName)
        end
        return nil
    end

    -- If fieldName is nil, return message-level defaults table
    if not fieldName then
        return messageSchema._metadata.defaults
    end

    -- First check field-specific metadata (highest priority)
    -- Field-specific defaults are stored in _metadata.fields[fieldName].default (singular)
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)
    if fieldMetadata and fieldMetadata.default ~= nil then
        return fieldMetadata.default
    end

    -- Check message-level defaults table (field name as key)
    -- Message-level defaults are stored in _metadata.defaults[fieldName]
    if messageSchema._metadata.defaults and type(messageSchema._metadata.defaults) == "table" then
        if messageSchema._metadata.defaults[fieldName] ~= nil then
            return messageSchema._metadata.defaults[fieldName]
        end
    end

    return nil
end

--- Get proto3 default value for a field type (from proto3 specification)
--- @param fieldType string Field type (int32, string, bool, enum, message, etc.)
--- @param messageType string|nil Message type if fieldType is "message"
--- @return any Proto3 default value
function SchemaAccessor:GetProto3Default(fieldType, messageType)
    if fieldType == "int32" or fieldType == "int64" or fieldType == "uint32" or fieldType == "uint64" then
        return 0
    elseif fieldType == "float" or fieldType == "double" then
        return 0.0
    elseif fieldType == "bool" or fieldType == "boolean" then
        return false
    elseif fieldType == "string" then
        return ""
    elseif fieldType == "enum" then
        return 0  -- First enum value (typically Unknown)
    elseif fieldType == "message" then
        -- Message fields default to nil in proto3 (not set)
        return nil
    end
    return nil
end

--- Get effective default value (schema default if available, otherwise proto3 default)
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return any Effective default value (schema default or proto3 default)
function SchemaAccessor:GetEffectiveDefault(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        return nil
    end

    if not fieldName then
        return nil
    end

    -- Try schema default first (highest priority)
    local schemaDefault = self:GetFieldDefaults(messageSchema, fieldName)
    if schemaDefault ~= nil then
        return schemaDefault
    end

    -- Fall back to proto3 default based on field type
    local fieldType = self:GetFieldType(messageSchema, fieldName)
    if not fieldType then
        return nil
    end

    local messageType = nil
    if fieldType == "message" then
        messageType = self:GetFieldMessageType(messageSchema, fieldName)
    end

    return self:GetProto3Default(fieldType, messageType)
end

--- Get enum values for a field (via Types module)
--- @param messageSchema table The message schema
--- @param fieldName string The field name
--- @return table|nil Enum values table (key -> value mapping) or nil
--- @return table|nil Enum type object or nil
function SchemaAccessor:GetFieldEnumValues(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        return nil, nil
    end

    if not fieldName then
        return nil, nil
    end

    local enumTypeName = self:GetFieldEnumType(messageSchema, fieldName)
    if not enumTypeName then
        return nil, nil
    end

    if not Types then
        return nil, nil
    end

    local enumType = Types:GetType(enumTypeName)
    if not enumType and Types.GetEnumShortName then
        local shortName = Types:GetEnumShortName(enumTypeName)
        if shortName then
            enumType = Types:GetType(shortName)
        end
    end

    if enumType and enumType.GetValues then
        return enumType:GetValues(), enumType
    end

    return nil, nil
end

--- Get the proto field type from a message schema
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The proto field type (e.g., "int32", "string", "bool", "enum", "message") or nil if not found
function SchemaAccessor:GetFieldType(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        if fieldName then
            self:Warn("GetFieldType: Invalid messageSchema for field '%s' (expected table, got %s)", fieldName, type(messageSchema))
        end
        return nil
    end

    if not messageSchema.fields or type(messageSchema.fields) ~= "table" then
        if fieldName then
            self:Warn("GetFieldType: Message schema has no fields table for field '%s'", fieldName)
        end
        return nil
    end

    local fieldDef = messageSchema.fields[fieldName]
    if not fieldDef or type(fieldDef) ~= "table" then
        if fieldName then
            self:Warn("GetFieldType: Field '%s' not found in message schema", fieldName)
        end
        return nil
    end

    return fieldDef.type
end

--- Get the enum type from a field definition (if field is an enum)
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The enum type name or nil if field is not an enum
function SchemaAccessor:GetFieldEnumType(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        if fieldName then
            self:Warn("GetFieldEnumType: Invalid messageSchema for field '%s' (expected table, got %s)", fieldName, type(messageSchema))
        end
        return nil
    end

    if not messageSchema.fields or type(messageSchema.fields) ~= "table" then
        if fieldName then
            self:Warn("GetFieldEnumType: Message schema has no fields table for field '%s'", fieldName)
        end
        return nil
    end

    local fieldDef = messageSchema.fields[fieldName]
    if not fieldDef or type(fieldDef) ~= "table" then
        if fieldName then
            self:Warn("GetFieldEnumType: Field '%s' not found in message schema", fieldName)
        end
        return nil
    end

    if fieldDef.type ~= "enum" then
        return nil
    end

    return fieldDef.enum_type
end

--- Get the message type from a field definition (if field is a message)
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The message type name or nil if field is not a message
function SchemaAccessor:GetFieldMessageType(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        if fieldName then
            self:Warn("GetFieldMessageType: Invalid messageSchema for field '%s' (expected table, got %s)", fieldName, type(messageSchema))
        end
        return nil
    end

    if not messageSchema.fields or type(messageSchema.fields) ~= "table" then
        if fieldName then
            self:Warn("GetFieldMessageType: Message schema has no fields table for field '%s'", fieldName)
        end
        return nil
    end

    local fieldDef = messageSchema.fields[fieldName]
    if not fieldDef or type(fieldDef) ~= "table" then
        if fieldName then
            self:Warn("GetFieldMessageType: Field '%s' not found in message schema", fieldName)
        end
        return nil
    end

    if fieldDef.type ~= "message" then
        return nil
    end

    return fieldDef.message_type
end

--- Get the proto field label (optional/repeated/required)
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return string|nil The proto field label or nil if not found
function SchemaAccessor:GetFieldLabel(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        if fieldName then
            self:Warn("GetFieldLabel: Invalid messageSchema for field '%s' (expected table, got %s)", fieldName, type(messageSchema))
        end
        return nil
    end

    if not messageSchema.fields or type(messageSchema.fields) ~= "table" then
        if fieldName then
            self:Warn("GetFieldLabel: Message schema has no fields table for field '%s'", fieldName)
        end
        return nil
    end

    local fieldDef = messageSchema.fields[fieldName]
    if not fieldDef or type(fieldDef) ~= "table" then
        if fieldName then
            self:Warn("GetFieldLabel: Field '%s' not found in message schema", fieldName)
        end
        return nil
    end

    return fieldDef.label
end

--- Get the proto field ID
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return number|nil The proto field ID or nil if not found
function SchemaAccessor:GetFieldId(messageSchema, fieldName)
    if not messageSchema or type(messageSchema) ~= "table" then
        if fieldName then
            self:Warn("GetFieldId: Invalid messageSchema for field '%s' (expected table, got %s)", fieldName, type(messageSchema))
        end
        return nil
    end

    if not messageSchema.fields or type(messageSchema.fields) ~= "table" then
        if fieldName then
            self:Warn("GetFieldId: Message schema has no fields table for field '%s'", fieldName)
        end
        return nil
    end

    local fieldDef = messageSchema.fields[fieldName]
    if not fieldDef or type(fieldDef) ~= "table" then
        if fieldName then
            self:Warn("GetFieldId: Field '%s' not found in message schema", fieldName)
        end
        return nil
    end

    return fieldDef.id
end

--- Get complete field information (field definition + metadata)
--- @param messageSchema table The message schema (message type)
--- @param fieldName string The field name
--- @return table|nil Complete field info with proto definition and metadata, or nil if field not found
function SchemaAccessor:GetFieldInfo(messageSchema, fieldName)

    if not messageSchema or type(messageSchema) ~= "table" then
        self:Warn("GetFieldInfo: Invalid messageSchema for field '%s' (expected table, got %s)",
            fieldName or "nil", type(messageSchema))
        return nil
    end

    if not messageSchema.fields or type(messageSchema.fields) ~= "table" then
        self:Warn("GetFieldInfo: Message schema has no fields table for field '%s'",
            fieldName or "nil")
        return nil
    end

    local fieldDef = messageSchema.fields[fieldName]
    if not fieldDef or type(fieldDef) ~= "table" then
        self:Warn("GetFieldInfo: Field '%s' not found in message schema",
            fieldName or "nil")
        return nil
    end

    self:Info("GetFieldInfo: Successfully retrieved field info for fieldName='%s'", fieldName)

    -- Get field metadata
    local fieldMetadata = self:GetFieldMetadata(messageSchema, fieldName)

    -- Combine field definition with metadata
    local fieldInfo = TableUtils.Copy(fieldDef)
    fieldInfo._metadata = fieldMetadata

    return fieldInfo
end

--- Get argument mapping from message metadata (DEPRECATED)
--- This function is deprecated - field_order modifications are now used instead
--- @param messageType string The message type name
--- @return nil Always returns nil with warning
function SchemaAccessor:GetMessageArgumentMapping(messageType)
    self:Warn("GetMessageArgumentMapping() is deprecated - field_order modifications are now used instead (called for %s)", messageType or "nil")
    return nil
end

-- ============================ ENUM ACCESS METHODS ============================
-- All enums are imported into Types registry by SchemaModifier, so we delegate to Types
-- Types registry provides alias resolution, normalization, and caching

--- Get enum values with nested enum support (via Types registry)
--- @param enumName string The enum name
--- @return table|nil Enum values (from Types registry)
function SchemaAccessor:GetEnumValues(enumName)
    if not enumName then return {} end

    -- Delegate to Types registry (handles aliases, normalization, caching, etc.)
    local typeObj = Types:GetType(enumName)
    if typeObj then
        return typeObj:GetValues()
    end

    return {}
end

--- Validate an enum value (via Types registry)
--- @param enumName string The enum name
--- @param value number The value to validate
--- @return boolean True if valid
function SchemaAccessor:ValidateEnumValue(enumName, value)
    if not enumName or value == nil then return false end

    -- Delegate to Types registry (handles aliases, normalization, etc.)
    local typeObj = Types:GetType(enumName)
    if typeObj then
        return typeObj:IsValid(value)
    end

    return false
end

--- Get enum label for a value (via Types registry)
--- @param enumName string The enum name
--- @param value number|string The enum value
--- @return string|nil The enum label or nil if not found
function SchemaAccessor:GetEnumLabel(enumName, value)
    if not enumName or value == nil then return nil end

    -- Delegate to Types registry (handles aliases, normalization, etc.)
    local typeObj = Types:GetType(enumName)
    if typeObj and typeObj.GetNameByValue then
        return typeObj:GetNameByValue(value)
    end

    return nil
end

-- ============================ ID EXTRACTION METHODS ============================
-- Extract ActionID objects from AST nodes for DataManager registration and display

--- Helper: Extract ActionID structure from a field value
--- @param fieldValue table|number|any The field value (may be ActionID message or primitive)
--- @param fieldInfo table|nil Optional field info from schema
--- @return table|nil ActionID object {spell_id, item_id, other_id, tag} or nil
local function ExtractActionIDFromField(fieldValue, fieldInfo)
    if not fieldValue then return nil end

    local FieldFormatConverter = ns.FieldFormatConverter
    local actionID = {}

    if type(fieldValue) == "table" then
        -- Use FieldFormatConverter for consistent ActionID extraction
        if FieldFormatConverter then
            -- Extract spell_id
            if fieldValue.spell_id then
                local extractedID = FieldFormatConverter:ExtractActionID(fieldValue.spell_id)
                if extractedID then
                    actionID.spell_id = extractedID
                end
            end
            -- Extract item_id
            if fieldValue.item_id then
                local extractedID = FieldFormatConverter:ExtractActionID(fieldValue.item_id)
                if extractedID then
                    actionID.item_id = extractedID
                end
            end
            -- Handle other_id (enum, typically flat)
            if fieldValue.other_id then
                actionID.other_id = fieldValue.other_id
            end
        else
            -- Fallback to manual extraction if FieldFormatConverter unavailable
            if fieldValue.spell_id then
                if type(fieldValue.spell_id) == "table" then
                    actionID.spell_id = fieldValue.spell_id.spell_id or fieldValue.spell_id.id
                else
                    actionID.spell_id = fieldValue.spell_id
                end
            end
            if fieldValue.item_id then
                actionID.item_id = fieldValue.item_id
            end
            if fieldValue.other_id then
                actionID.other_id = fieldValue.other_id
            end
        end
        -- Handle tag
        if fieldValue.tag then
            actionID.tag = fieldValue.tag
        end
    elseif type(fieldValue) == "number" then
        -- Primitive number - assume it's a spell_id
        actionID.spell_id = fieldValue
    end

    -- Only return if we extracted at least one ID
    if actionID.spell_id or actionID.item_id or actionID.other_id then
        return actionID
    end

    return nil
end

--- Extract ActionID objects from an action node
--- @param actionNode table AST action node (must have node.type == ASTCore.NodeType.ACTION)
--- @return table Array of ActionID objects {spell_id, item_id, other_id, tag}
function SchemaAccessor:ExtractIDsFromActionNode(actionNode)
    if not actionNode then
        return {}
    end

    local ASTCore = ns.ASTCore
    local ASTAction = ns.ASTAction

    -- Verify it's an action node
    if actionNode.type ~= ASTCore.NodeType.ACTION then
        self:Warn("ExtractIDsFromActionNode: Node is not an ACTION node (type='%s')",
            actionNode.type or "nil")
        return {}
    end

    -- Get action type and data
    local actionType = ASTAction.GetActionType(actionNode)
    local actionData = ASTAction.GetActionData(actionNode)

    if not actionType or not actionData then
        return {}
    end

    -- Get action metadata to find ActionID fields
    local actionMetadata = self:GetMetadataByIdentifier(actionType, nil)
    if not actionMetadata or not actionMetadata.messageSchema then
        return {}
    end

    local actionIDs = {}
    local messageSchema = actionMetadata.messageSchema

    -- Find all fields with message_type = "ActionID" in the schema
    if messageSchema.fields then
        for fieldName, fieldInfo in pairs(messageSchema.fields) do
            if fieldInfo.type == "message" and fieldInfo.message_type == "ActionID" then
                -- Extract ActionID from action data at this field path
                local actionIDValue = actionData[fieldName]
                if actionIDValue then
                    local actionID = ExtractActionIDFromField(actionIDValue, fieldInfo)
                    if actionID then
                        tinsert(actionIDs, actionID)
                    end
                end
            end
        end
    end

    -- Recursively process sequence/strict_sequence actions
    if actionType == "sequence" or actionType == "strict_sequence" then
        if actionData.actions and type(actionData.actions) == "table" then
            for _, subAction in ipairs(actionData.actions) do
                if subAction and subAction.type == ASTCore.NodeType.ACTION then
                    local subActionIDs = self:ExtractIDsFromActionNode(subAction)
                    for _, actionID in ipairs(subActionIDs) do
                        tinsert(actionIDs, actionID)
                    end
                end
            end
        end
    end

    return actionIDs
end

--- Extract ActionID objects from a value node
--- @param valueNode table AST value node (must have node.type == ASTCore.NodeType.VALUE)
--- @return table Array of ActionID objects {spell_id, item_id, other_id, tag}
function SchemaAccessor:ExtractIDsFromValueNode(valueNode)
    if not valueNode then
        return {}
    end

    local ASTCore = ns.ASTCore
    local ASTValue = ns.ASTValue

    -- Verify it's a value node
    if valueNode.type ~= ASTCore.NodeType.VALUE then
        self:Warn("ExtractIDsFromValueNode: Node is not a VALUE node (type='%s')",
            valueNode.type or "nil")
        return {}
    end

    -- Get value type and data
    local valueType = ASTValue.GetValueType(valueNode)
    local valueData = ASTValue.GetValueData(valueNode)

    if not valueType or not valueData then
        return {}
    end

    local actionIDs = {}

    -- Skip operators (const, and, or, not, cmp, math) - they don't have ActionID fields directly
    -- But we need to recursively process nested value nodes in operators
    if valueType == ASTValue.ValueType.CONST then
        -- Constants don't have ActionID fields
        return {}
    elseif valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR then
        -- Recursively process nested value nodes in logical operators
        if valueData.vals and type(valueData.vals) == "table" then
            for _, val in ipairs(valueData.vals) do
                if val and val.type == ASTCore.NodeType.VALUE then
                    local subValueIDs = self:ExtractIDsFromValueNode(val)
                    for _, actionID in ipairs(subValueIDs) do
                        tinsert(actionIDs, actionID)
                    end
                end
            end
        end
        return actionIDs
    elseif valueType == ASTValue.ValueType.NOT then
        -- Recursively process nested value node in NOT operator
        if valueData.val and valueData.val.type == ASTCore.NodeType.VALUE then
            local subValueIDs = self:ExtractIDsFromValueNode(valueData.val)
            for _, actionID in ipairs(subValueIDs) do
                tinsert(actionIDs, actionID)
            end
        end
        return actionIDs
    elseif valueType == ASTValue.ValueType.CMP or valueType == ASTValue.ValueType.MATH then
        -- Recursively process lhs and rhs in comparison/math operators
        if valueData.lhs and valueData.lhs.type == ASTCore.NodeType.VALUE then
            local subValueIDs = self:ExtractIDsFromValueNode(valueData.lhs)
            for _, actionID in ipairs(subValueIDs) do
                tinsert(actionIDs, actionID)
            end
        end
        if valueData.rhs and valueData.rhs.type == ASTCore.NodeType.VALUE then
            local subValueIDs = self:ExtractIDsFromValueNode(valueData.rhs)
            for _, actionID in ipairs(subValueIDs) do
                tinsert(actionIDs, actionID)
            end
        end
        return actionIDs
    end

    -- Get value metadata to find ActionID fields
    local valueMetadata = self:GetMetadataByIdentifier(valueType, nil)
    if not valueMetadata or not valueMetadata.messageSchema then
        return {}
    end

    local messageSchema = valueMetadata.messageSchema

    -- Find all fields with message_type = "ActionID" in the schema
    if messageSchema.fields then
        for fieldName, fieldInfo in pairs(messageSchema.fields) do
            if fieldInfo.type == "message" and fieldInfo.message_type == "ActionID" then
                -- Extract ActionID from value data at this field path
                local actionIDValue = valueData[fieldName]
                if actionIDValue then
                    local actionID = ExtractActionIDFromField(actionIDValue, fieldInfo)
                    if actionID then
                        tinsert(actionIDs, actionID)
                    end
                end
            end
        end
    end

    return actionIDs
end

--- Extract ActionID objects from a node (auto-detects node type)
--- @param node table AST node (action or value)
--- @param options table|nil Options: {actionsOnly=true}, {valuesOnly=true}, or {} for both
--- @return table Array of ActionID objects {spell_id, item_id, other_id, tag}
function SchemaAccessor:ExtractIDsFromNode(node, options)
    if not node then
        return {}
    end

    options = options or {}
    local ASTCore = ns.ASTCore

    local actionIDs = {}

    -- Auto-detect node type
    if node.type == ASTCore.NodeType.ACTION then
        if not options.valuesOnly then
            local actionNodeIDs = self:ExtractIDsFromActionNode(node)
            for _, actionID in ipairs(actionNodeIDs) do
                tinsert(actionIDs, actionID)
            end
        end
        -- Also extract from action condition if present
        if not options.actionsOnly then
            local ASTAction = ns.ASTAction
            local condition = ASTAction and ASTAction.GetCondition(node)
            if condition and condition.type == ASTCore.NodeType.VALUE then
                local conditionIDs = self:ExtractIDsFromValueNode(condition)
                for _, actionID in ipairs(conditionIDs) do
                    tinsert(actionIDs, actionID)
                end
            end
        end
    elseif node.type == ASTCore.NodeType.VALUE then
        if not options.actionsOnly then
            local valueNodeIDs = self:ExtractIDsFromValueNode(node)
            for _, actionID in ipairs(valueNodeIDs) do
                tinsert(actionIDs, actionID)
            end
        end
    end

    return actionIDs
end

--- Extract ActionID objects from a rotation AST node
--- @param rotationNode table AST rotation node (must have node.type == ASTCore.NodeType.ROTATION)
--- @param options table|nil Options: {actionsOnly=true}, {valuesOnly=true}, or {} for both
--- @return table Array of ActionID objects {spell_id, item_id, other_id, tag}
function SchemaAccessor:ExtractIDsFromRotationNode(rotationNode, options)
    if not rotationNode then
        return {}
    end

    local ASTCore = ns.ASTCore
    local ASTRotation = ns.ASTRotation

    -- Verify it's a rotation node
    if rotationNode.type ~= ASTCore.NodeType.ROTATION then
        self:Warn("ExtractIDsFromRotationNode: Node is not a ROTATION node (type='%s')",
            rotationNode.type or "nil")
        return {}
    end

    options = options or {}
    local allActionIDs = {}
    local seenIDs = {} -- For deduplication: key = "spell_id:item_id:other_id"

    -- Helper function to add ActionID with deduplication
    local function addActionID(actionID)
        if not actionID then return end

        -- Create unique key for deduplication
        local key = format("%s:%s:%s",
            tostring(actionID.spell_id or ""),
            tostring(actionID.item_id or ""),
            tostring(actionID.other_id or ""))

        if not seenIDs[key] then
            seenIDs[key] = true
            tinsert(allActionIDs, actionID)
        end
    end

    -- Extract from priority_list
    local priorityList = ASTRotation.GetPriorityList(rotationNode)
    if priorityList then
        for _, listItem in ipairs(priorityList) do
            if listItem.action then
                local nodeIDs = self:ExtractIDsFromNode(listItem.action, options)
                for _, actionID in ipairs(nodeIDs) do
                    addActionID(actionID)
                end
            end
        end
    end

    -- Extract from prepull_actions
    local prepullActions = ASTRotation.GetPrepullActions(rotationNode)
    if prepullActions then
        for _, prepullAction in ipairs(prepullActions) do
            -- Extract from action
            if prepullAction.action then
                local nodeIDs = self:ExtractIDsFromNode(prepullAction.action, options)
                for _, actionID in ipairs(nodeIDs) do
                    addActionID(actionID)
                end
            end
            -- Extract from do_at_value if it's a value node
            if prepullAction.do_at_value and not options.actionsOnly then
                if prepullAction.do_at_value.type == ASTCore.NodeType.VALUE then
                    local valueIDs = self:ExtractIDsFromValueNode(prepullAction.do_at_value)
                    for _, actionID in ipairs(valueIDs) do
                        addActionID(actionID)
                    end
                end
            end
        end
    end

    -- Extract from groups
    local groups = ASTRotation.GetGroups(rotationNode)
    if groups then
        for _, group in ipairs(groups) do
            -- Extract from group actions
            if group.actions then
                for _, listItem in ipairs(group.actions) do
                    if listItem.action then
                        local nodeIDs = self:ExtractIDsFromNode(listItem.action, options)
                        for _, actionID in ipairs(nodeIDs) do
                            addActionID(actionID)
                        end
                    end
                end
            end
            -- Extract from group variables
            if group.variables and not options.actionsOnly then
                for _, variable in ipairs(group.variables) do
                    if variable.value and variable.value.type == ASTCore.NodeType.VALUE then
                        local valueIDs = self:ExtractIDsFromValueNode(variable.value)
                        for _, actionID in ipairs(valueIDs) do
                            addActionID(actionID)
                        end
                    end
                end
            end
        end
    end

    -- Extract from value_variables
    local variables = ASTRotation.GetVariables(rotationNode)
    if variables and not options.actionsOnly then
        for _, variable in ipairs(variables) do
            if variable.value and variable.value.type == ASTCore.NodeType.VALUE then
                local valueIDs = self:ExtractIDsFromValueNode(variable.value)
                for _, actionID in ipairs(valueIDs) do
                    addActionID(actionID)
                end
            end
        end
    end

    return allActionIDs
end

--- Format ActionID objects for display
--- @param actionIDs table Array of ActionID objects
--- @param formatOption string|nil "full" (default) returns detailed objects with chat links, "icons" returns icon strings, "short" returns icon strings
--- @return table Array of {name=string, value=number, type=string, displayText, icon, chatLink} or array of icon strings
function SchemaAccessor:FormatSpellList(actionIDs, formatOption)
    if not actionIDs or type(actionIDs) ~= "table" then
        return {}
    end

    local useIconsFormat = (formatOption == "icons" or formatOption == "short")
    local UNKNOWN_ICON = 134400 -- Interface\\Icons\\INV_Misc_QuestionMark

    local formatted = {}
    local seenIDs = {} -- For deduplication

    for _, actionID in ipairs(actionIDs) do
        if actionID then
            local id, name, icon, itemType, chatLink
            local displayType = "unknown"

            -- Determine ID and type
            if actionID.spell_id then
                id = actionID.spell_id
                displayType = "spell"
                local spellInfo = WoWAPI.GetSpellInfo(id)
                if spellInfo then
                    name = spellInfo.name
                    icon = spellInfo.iconID
                end
                -- Get spell chat link (clickable with tooltip)
                if GetSpellLink then
                    chatLink = GetSpellLink(id)
                end
            elseif actionID.item_id then
                id = actionID.item_id
                displayType = "item"
                local itemInfo = WoWAPI.GetItemInfo(id)
                if itemInfo then
                    name = itemInfo.name
                    icon = itemInfo.icon
                end
                -- Get item chat link (clickable with tooltip)
                if C_Item and C_Item.GetItemLinkByID then
                    chatLink = C_Item.GetItemLinkByID(id)
                elseif GetItemInfo then
                    local itemLink = select(2, GetItemInfo(id))
                    chatLink = itemLink
                end
            elseif actionID.other_id then
                id = actionID.other_id
                displayType = "other"
                -- Try to get name from spell first, then item
                local spellInfo = WoWAPI.GetSpellInfo(id)
                if spellInfo then
                    name = spellInfo.name
                    icon = spellInfo.iconID
                    displayType = "spell"
                    -- Get spell chat link
                    if GetSpellLink then
                        chatLink = GetSpellLink(id)
                    end
                else
                    local itemInfo = WoWAPI.GetItemInfo(id)
                    if itemInfo then
                        name = itemInfo.name
                        icon = itemInfo.icon
                        displayType = "item"
                        -- Get item chat link
                        if C_Item and C_Item.GetItemLinkByID then
                            chatLink = C_Item.GetItemLinkByID(id)
                        elseif GetItemInfo then
                            local itemLink = select(2, GetItemInfo(id))
                            chatLink = itemLink
                        end
                    end
                end
            end

            -- Only process if we have an ID and haven't seen it before
            if id and not seenIDs[id] then
                seenIDs[id] = true

                if useIconsFormat then
                    -- Return icon string directly for short format
                    local iconID = icon or UNKNOWN_ICON
                    local iconSize = (formatOption == "short") and 14 or 16
                    local iconString = format("|T%d:%d:%d:0:0:64:64:4:60:4:60|t", iconID, iconSize, iconSize)
                    tinsert(formatted, iconString)
                else
                    -- Full format: return detailed object with chat link
                    local displayText = name or format("Unknown %s (%d)", displayType, id)
                    if actionID.tag then
                        displayText = format("%s [%s]", displayText, tostring(actionID.tag))
                    end

                    -- Use chat link if available, otherwise use plain text
                    local displayLink = chatLink or displayText

                    tinsert(formatted, {
                        name = name or format("Unknown %s", displayType),
                        value = id,
                        type = displayType,
                        displayText = displayText,
                        icon = icon or UNKNOWN_ICON,
                        chatLink = chatLink  -- Clickable link with tooltip support
                    })
                end
            end
        end
    end

    return formatted
end

--- Get memory usage statistics
--- @return table Memory usage info
function SchemaAccessor:GetMemoryStats()
    local stats = {
        schemaLoaded = self.loaded,
        expansionKey = self.expansionKey,
        cacheSizes = {
            fieldCache = TableUtils.Size(self.fieldCache),
            actionTypes = self.actionTypes and #self.actionTypes or 0,
            valueTypes = self.valueTypes and #self.valueTypes or 0
        },
        totalMemory = collectgarbage("count")
    }

    return stats
end

--- Clear caches to free memory
function SchemaAccessor:ClearCaches()
    wipe(self.fieldCache)
    self.actionTypes = nil
    self.valueTypes = nil
    self.protoToNagCache = nil
    collectgarbage("collect")
    self:Debug("Cleared all caches")
end

--- Reset module state completely
function SchemaAccessor:ResetState()
    self:ClearCaches()
    self.loaded = false
    self.schemaData = nil
    self.expansionKey = nil
    self.majorCooldownCache = nil
    self.protoToNagCache = nil
    self:Debug("Reset module state completely")
end

-- ============================ GO METADATA ACCESS ============================

--- Get spell metadata entries from field metadata.
--- @param fieldDef table The field definition
--- @return table Array of spell metadata entries (may be empty)
function SchemaAccessor:GetFieldSpellMetadata(fieldDef)
    local metadata = self:GetFieldMetadata(fieldDef)
    local spellMeta = metadata and metadata.spell
    if not spellMeta then
        return {}
    end
    -- Handle both single entry and array cases
    if type(spellMeta) == "table" and spellMeta[1] then
        return spellMeta  -- Array
    elseif type(spellMeta) == "table" and spellMeta.spell_id then
        return { spellMeta }  -- Single entry, wrap in array
    end
    return {}
end

--- Get aura metadata entries from field metadata.
--- @param fieldDef table The field definition
--- @return table Array of aura metadata entries (may be empty)
function SchemaAccessor:GetFieldAuraMetadata(fieldDef)
    local metadata = self:GetFieldMetadata(fieldDef)
    local auraMeta = metadata and metadata.aura
    if not auraMeta then
        return {}
    end
    -- Handle both single entry and array cases
    if type(auraMeta) == "table" and auraMeta[1] then
        return auraMeta  -- Array
    elseif type(auraMeta) == "table" and auraMeta.spell_id then
        return { auraMeta }  -- Single entry, wrap in array
    end
    return {}
end

--- Iterate over every go metadata entry exposed through `_metadata`.
--- Iterates over `_metadata.spell` and `_metadata.aura` entries directly.
--- @param handler fun(messageName:string, fieldName:string, group:string, entry:table)
function SchemaAccessor:ForEachGoMetadataEntry(handler)
    if type(handler) ~= "function" then
        return
    end

    local schema = self:GetSchemaData()
    if not schema or not schema.messages then
        return
    end

    local function emitEntry(messageName, fieldName, group, entry)
        if SchemaUtils and SchemaUtils.AnnotateMaskFields then
            SchemaUtils:AnnotateMaskFields(entry)
        end
        handler(messageName, fieldName, group, entry)
    end

    local function buildVariantEntry(baseEntry, variant)
        local variantEntry = TableUtils.Copy(baseEntry)
        variantEntry.variants = nil
        variantEntry.variant = variant
        if type(variant) == "table" then
            for key, value in pairs(variant) do
                variantEntry[key] = value
            end
            if variant.rank then
                variantEntry.variantRank = variant.rank
            end
        end
        return variantEntry
    end

    -- Known Go metadata groups (spell, aura, etc.)
    local GO_METADATA_GROUPS = { "spell", "aura" }

    for messageName, message in pairs(schema.messages) do
        local fields = message and message.fields
        if type(fields) == "table" then
            for fieldName, fieldDef in pairs(fields) do
                local metadata = fieldDef and fieldDef._metadata
                if type(metadata) == "table" then
                    -- Iterate over known Go metadata groups (spell, aura)
                    for _, group in ipairs(GO_METADATA_GROUPS) do
                        local entries = metadata[group]
                        if type(entries) == "table" then
                            -- Handle both single entry and array cases
                            local entryList = {}
                            if entries[1] then
                                -- Array of entries
                                entryList = entries
                            elseif entries.spell_id or entries.class then
                                -- Single entry, wrap in array
                                entryList = { entries }
                            end
                            -- Process each entry
                            for _, entry in ipairs(entryList) do
                                local variants = entry and entry.variants
                                if type(variants) == "table" and #variants > 0 then
                                    for _, variant in ipairs(variants) do
                                        local variantEntry = buildVariantEntry(entry, variant)
                                        emitEntry(messageName, fieldName, group, variantEntry)
                                    end
                                else
                                    emitEntry(messageName, fieldName, group, entry)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- ============================ MAJOR COOLDOWN CACHE ============================

local function normalizeToken(s)
    if type(s) ~= "string" then return nil end
    local x = s:lower():gsub("[^%a_]", "_"):gsub("_+", "_"):gsub("^_", ""):gsub("_$", "")
    return x ~= "" and x or nil
end

local function ensureMajorCooldownCache(self)
    if self.majorCooldownCache then
        return self.majorCooldownCache
    end

    self.majorCooldownCache = {
        entries = {},
        byClass = {},
        byClassAndSpec = {},
        bySpellId = {},
        lookup = {}
    }

    local cache = self.majorCooldownCache
    local COMMON_SPEC_KEY = "__common"

    local function addRecord(record)
        tinsert(cache.entries, record)
        if record.class then
            cache.byClass[record.class] = cache.byClass[record.class] or {}
            tinsert(cache.byClass[record.class], record)
            cache.byClassAndSpec[record.class] = cache.byClassAndSpec[record.class] or {}
            local specKey = record.specToken or COMMON_SPEC_KEY
            cache.byClassAndSpec[record.class][specKey] = cache.byClassAndSpec[record.class][specKey] or {}
            tinsert(cache.byClassAndSpec[record.class][specKey], record)
        end
        if record.spellId then
            cache.bySpellId[record.spellId] = cache.bySpellId[record.spellId] or {}
            tinsert(cache.bySpellId[record.spellId], record)
            local spellLookup = cache.lookup[record.spellId]
            if not spellLookup then
                spellLookup = {
                    any = { any = false, categoryNames = {}, categoryIds = {} },
                    classes = {}
                }
                cache.lookup[record.spellId] = spellLookup
            end
            local function applyBucket(bucket)
                bucket.any = true
                if record.categoryName then bucket.categoryNames[record.categoryName] = true end
                if record.categoryId then bucket.categoryIds[record.categoryId] = true end
            end
            applyBucket(spellLookup.any)
            if record.class then
                local classBucket = spellLookup.classes[record.class]
                if not classBucket then
                    classBucket = { any = { any = false, categoryNames = {}, categoryIds = {} }, specs = {} }
                    spellLookup.classes[record.class] = classBucket
                end
                applyBucket(classBucket.any)
                if record.specToken then
                    local specBucket = classBucket.specs[record.specToken]
                    if not specBucket then
                        specBucket = { any = false, categoryNames = {}, categoryIds = {} }
                        classBucket.specs[record.specToken] = specBucket
                    end
                    applyBucket(specBucket)
                end
            end
        end
    end

    self:ForEachGoMetadataEntry(function(_, fieldName, entityType, entry)
        if type(entry) ~= "table" or not entry.major_cooldown then
            return
        end
        local spellId = entry.spell_id
        if not spellId then return end
        local classFilename = entry["class"] or entry.class_name
        local classToken = classFilename and normalizeToken(classFilename)
        local specToken = entry.spec or entry.spec_name
        specToken = specToken and normalizeToken(specToken)
        local categoryName, categoryId = (function(category)
            if category == nil then return nil, nil end
            if type(category) == "number" then return nil, category end
            local c = tostring(category or ""):gsub("^core%.", ""):gsub("^CooldownType", "")
            c = c:gsub("^cooldown_type_", ""):gsub("^cooldown_", ""):gsub("^type_", ""):gsub("^_", "")
            if c == "" then return nil, nil end
            local lowered = c:lower()
            if lowered == "mana" then c = "Mana"
            elseif lowered == "dps" then c = "DPS"
            elseif lowered == "explosive" then c = "Explosive"
            elseif lowered == "survival" then c = "Survival"
            end
            local cooldownType = Types and Types:GetType("CooldownType")
            local id = cooldownType and (cooldownType[c] or cooldownType[c:upper()]) or nil
            return c, id
        end)(entry.major_cooldown and entry.major_cooldown.type)
        addRecord({
            class = classToken,
            specToken = specToken,
            specLabel = entry.spec or entry.spec_name,
            spellName = entry.label or fieldName,
            entityType = entityType,
            spellId = spellId,
            categoryRaw = entry.major_cooldown.type,
            categoryName = categoryName,
            categoryId = categoryId,
            priority = entry.major_cooldown.priority
        })
    end)

    return cache
end

--- Retrieve cached major cooldowns with optional filters.
--- @param options table|nil {class=string, spec=string, spellId=number, spellName=string, category=string|number}
--- @return table
function SchemaAccessor:GetMajorCooldowns(options)
    local cache = ensureMajorCooldownCache(self)
    if not options or next(options) == nil then
        return cache.entries
    end

    local classFilter = normalizeToken(options.class)
    local specFilter = normalizeToken(options.spec)
    local spellIdFilter = options.spellId
    local spellNameFilter = options.spellName

    local categoryNameFilter, categoryIdFilter
    if options.category ~= nil then
        if type(options.category) == "number" then
            categoryIdFilter = options.category
        else
            local lowered = tostring(options.category):lower()
            if lowered == "mana" then categoryNameFilter = "Mana"
            elseif lowered == "dps" then categoryNameFilter = "DPS"
            elseif lowered == "explosive" then categoryNameFilter = "Explosive"
            elseif lowered == "survival" then categoryNameFilter = "Survival"
            else categoryNameFilter = options.category end
        end
    end

    local candidates = {}
    local COMMON_SPEC_KEY = "__common"
    if classFilter then
        local classSpecMap = cache.byClassAndSpec[classFilter]
        if classSpecMap then
            if specFilter then
                if classSpecMap[specFilter] then tinsert(candidates, classSpecMap[specFilter]) end
                if classSpecMap[COMMON_SPEC_KEY] then tinsert(candidates, classSpecMap[COMMON_SPEC_KEY]) end
            else
                if cache.byClass[classFilter] then tinsert(candidates, cache.byClass[classFilter]) end
            end
        end
    else
        if specFilter then
            local specMatches = {}
            for _, record in ipairs(cache.entries) do
                if record.specToken == specFilter then tinsert(specMatches, record) end
            end
            if #specMatches > 0 then tinsert(candidates, specMatches) end
        else
            return cache.entries
        end
    end

    local function matches(record)
        if spellIdFilter and record.spellId ~= spellIdFilter then return false end
        if spellNameFilter and record.spellName ~= spellNameFilter then return false end
        if categoryIdFilter and record.categoryId ~= categoryIdFilter then return false end
        if categoryNameFilter and record.categoryName ~= categoryNameFilter then return false end
        return true
    end

    local results, seen = {}, {}
    for _, list in ipairs(candidates) do
        for _, record in ipairs(list) do
            if not seen[record] and matches(record) then
                seen[record] = true
                tinsert(results, record)
            end
        end
    end
    return results
end

--- Get the normalized class token for the current player.
--- @return string|nil
function SchemaAccessor:GetPlayerClassToken()
    if not WoWAPI or not UnitClass then
        return nil
    end

    local _, classFilename = UnitClass("player")
    if not classFilename then
        return nil
    end

    return normalizeClassToken(classFilename)
end

--- Get the normalized specialization token for the current player.
--- @return string|nil
function SchemaAccessor:GetPlayerSpecToken()
    local SpecCompat = NAG:GetModule("SpecCompat")
    if SpecCompat then
        local specName = SpecCompat:GetSpecName()
        if specName then
            return normalizeSpecToken(specName)
        end
    end

    return nil
end

--- Check whether a spell is a major cooldown for the current player.
--- @param spellId number
--- @param category string|number|nil
--- @return boolean
function SchemaAccessor:IsMajorCooldown(spellId, category)
    if not spellId then return false end
    local cache = ensureMajorCooldownCache(self)
    local lookup = cache.lookup[spellId]
    if not lookup then return false end

    local classFilename = (WoWAPI and UnitClass) and select(2, UnitClass("player")) or nil
    local classToken = normalizeToken(classFilename)
    local SpecCompat = NAG:GetModule("SpecCompat")
    local specName = SpecCompat and SpecCompat:GetSpecName()
    local specToken = specName and normalizeToken(specName) or nil

    local categoryNameFilter, categoryIdFilter
    if category ~= nil then
        if type(category) == "number" then
            categoryIdFilter = category
        else
            local lowered = tostring(category):lower()
            if lowered == "mana" then categoryNameFilter = "Mana"
            elseif lowered == "dps" then categoryNameFilter = "DPS"
            elseif lowered == "explosive" then categoryNameFilter = "Explosive"
            elseif lowered == "survival" then categoryNameFilter = "Survival"
            else categoryNameFilter = category end
        end
    end

    local function bucketMatches(bucket)
        if not bucket then return false end
        if categoryIdFilter and bucket.categoryIds[categoryIdFilter] then return true end
        if categoryNameFilter and bucket.categoryNames[categoryNameFilter] then return true end
        if not categoryIdFilter and not categoryNameFilter then return bucket.any end
        return false
    end

    if classToken then
        local classBucket = lookup.classes[classToken]
        if classBucket then
            if specToken and classBucket.specs and bucketMatches(classBucket.specs[specToken]) then return true end
            if bucketMatches(classBucket.any) then return true end
            if specToken and classBucket.specs then
                for _, bucket in pairs(classBucket.specs) do
                    if bucketMatches(bucket) then return true end
                end
            end
        end
    end
    if bucketMatches(lookup.any) then return true end
    if not classToken then
        for _, classBucket in pairs(lookup.classes) do
            if bucketMatches(classBucket.any) then return true end
            if classBucket.specs then
                for _, bucket in pairs(classBucket.specs) do
                    if bucketMatches(bucket) then return true end
                end
            end
        end
    end
    return false
end

-- ============================ METADATA API METHODS ============================
-- These methods provide UI metadata and filtering for actions and values.
-- Moved from APLSchema to SchemaAccessor to provide proper API access.

--- Get all message types in the schema
--- @return table Array of message type names
function SchemaAccessor:GetAllMessageTypes()
    local schema = self:GetSchemaData()
    if not schema or not schema.messages then
        return {}
    end

    local messageTypes = {}
    for messageType in pairs(schema.messages) do
        tinsert(messageTypes, messageType)
    end

    sort(messageTypes)
    return messageTypes
end

-- ============================ UNIFIED METADATA ACCESSOR HELPERS ============================

--- Auto-detect metadata type by checking which schema container contains the identifier
--- Resolves aliases first (e.g., "Cast" -> "cast_spell") before checking containers
--- @param identifier string The identifier (may be alias like "Cast" or snake_case like "cast_spell")
--- @return string|nil "action" if found in APLAction.fields, "value" if found in APLValue.fields, nil if not found
function SchemaAccessor:DetectMetadataType(identifier)
    if not identifier or type(identifier) ~= "string" then
        return nil
    end

    local schema = self:GetSchemaData()
    if not schema or not schema.messages then
        return nil
    end

    -- First, try to resolve identifier from aliases (handles "Cast" -> "cast_spell")
    -- Try both "action" and "value" type resolution to find the correct alias
    local resolvedIdentifier = identifier

    -- Try resolving as action first
    local actionResolved = self:ResolveIdentifierFromMapping(identifier, "action")
    if actionResolved ~= identifier then
        resolvedIdentifier = actionResolved
    else
        -- Try resolving as value
        local valueResolved = self:ResolveIdentifierFromMapping(identifier, "value")
        if valueResolved ~= identifier then
            resolvedIdentifier = valueResolved
        end
    end

    -- Check APLAction container first
    if schema.messages.APLAction and schema.messages.APLAction.fields and schema.messages.APLAction.fields[resolvedIdentifier] then
        return "action"
    end

    -- Check APLValue container
    if schema.messages.APLValue and schema.messages.APLValue.fields and schema.messages.APLValue.fields[resolvedIdentifier] then
        return "value"
    end

    return nil
end

--- Resolve identifier from nagFunctionMappings (handles runtime aliases)
--- @param identifier string The identifier to resolve (may be alias like "Cast" or "cast")
--- @param expectedType string|nil "action" or "value" - helps determine which proto pattern to match
--- @return string The resolved identifier in snake_case, or original if no mapping found
function SchemaAccessor:ResolveIdentifierFromMapping(identifier, expectedType)
    if not identifier or type(identifier) ~= "string" or not self.nagFunctionMappings then
        return identifier
    end

    -- Check nagFunctionMappings first for runtime aliases (e.g., "Cast" or "cast" -> "APLActionCastSpell")
    -- Try both exact match and PascalCase version (e.g., "cast" -> "Cast")
    local mappedProtoName = self.nagFunctionMappings[identifier]
    if not mappedProtoName and identifier:match("^[a-z][a-z0-9_]*$") then
        -- Try PascalCase version (e.g., "cast" -> "Cast" for actions, "is_active" -> "IsActive" for values)
        local pascalCase
        if expectedType == "action" then
            pascalCase = identifier:gsub("^%l", function(c) return c:upper() end)
        else
            -- For values, convert snake_case to PascalCase properly
            pascalCase = identifier:gsub("_(%l)", function(c) return c:upper() end):gsub("^%l", function(c) return c:upper() end)
        end
        mappedProtoName = self.nagFunctionMappings[pascalCase]
    end

    if mappedProtoName then
        -- Extract name from proto name based on expected type
        local namePattern = (expectedType == "action") and "^APLAction(.+)$" or "^APLValue(.+)$"
        local extractedName = mappedProtoName:match(namePattern)
        if extractedName then
            local SchemaUtils = NAG:GetModule("SchemaUtils")
            if SchemaUtils then
                return SchemaUtils:CamelToSnake(extractedName)
            else
                -- Fallback: convert manually
                return extractedName:gsub("(%u)", "_%1"):lower():gsub("^_", "")
            end
        end
    end

    return identifier
end

--- Build standardized metadata record from field info and message schema
--- @param identifier string The identifier in snake_case
--- @param fieldInfo table The field info from schema container
--- @param messageSchema table The message schema (proto message type)
--- @param metadataType string "action" or "value"
--- @return table|nil The standardized metadata record, or nil if invalid
function SchemaAccessor:BuildMetadataRecord(identifier, fieldInfo, messageSchema, metadataType)
    if not identifier or not fieldInfo or not messageSchema or not metadataType then
        return nil
    end

    local protoName = fieldInfo.message_type
    if not protoName then
        self:Warn("BuildMetadataRecord: Field '%s' missing message_type", identifier)
        return nil
    end

    -- Read metadata from messageSchema._metadata (snake_case keys)
    if not messageSchema._metadata then
        self:Warn("BuildMetadataRecord: Message schema '%s' has no _metadata", protoName)
    end

    local metadata = messageSchema._metadata or {}

    -- Validate required metadata fields
    local typeLabel = (metadataType == "action") and "action" or "value"
    if not metadata.ui_label then
        self:Warn("BuildMetadataRecord: Missing ui_label for %s '%s' (protoName: %s)", typeLabel, identifier, protoName)
    end
    if not metadata.short_description then
        self:Warn("BuildMetadataRecord: Missing short_description for %s '%s' (protoName: %s)", typeLabel, identifier, protoName)
    end

    -- Build base record with type-specific field
    local record = {
        name = identifier,
        protoName = protoName,
        fieldId = fieldInfo.id,
        ui_label = metadata.ui_label,
        short_description = metadata.short_description,
        full_description = metadata.full_description,
        submenu = metadata.submenu,
        include_if = metadata.include_if,
        defaults = metadata.defaults,
        deprecated = metadata.deprecated,
        messageSchema = messageSchema  -- Reference, not copy
    }

    -- Add type-specific field (actionType or valueType)
    if metadataType == "action" then
        record.actionType = identifier
    else
        record.valueType = identifier
    end

    -- Compute nagName on-demand
    local nagName = self:GetNagNameFromProtoName(protoName)
    if nagName then
        record.nagName = nagName
    else
        if ns.DevDebugUtils and ns.DevDebugUtils.IsDebugEnabled(NAG, "SchemaAccessor") then
            self:Warn("BuildMetadataRecord: GetNagNameFromProtoName failed for protoName '%s' (%s: %s). Schema may be missing proper proto name mapping.", protoName, typeLabel, identifier)
        end
        record.nagName = nil
    end

    -- Compute nagFunctionName on-demand
    if metadataType == "action" then
        -- Actions: check nagFunctionMappings for special function names
        if self.nagFunctionMappings then
            for nagFunctionName, mappedProtoName in pairs(self.nagFunctionMappings) do
                if mappedProtoName == protoName then
                    record.nagFunctionName = nagFunctionName
                    break
                end
            end
        end
        if not record.nagFunctionName then
            record.nagFunctionName = record.nagName
        end
    else
        -- Values: nagFunctionName is same as nagName
        record.nagFunctionName = record.nagName
    end

    return record
end

-- ============================ UNIFIED METADATA ACCESSOR CORE FUNCTIONS ============================

--- Get metadata by identifier (unified for actions and values)
--- @param identifier string The identifier in snake_case (e.g., "cast_spell", "spell_cooldown")
--- @param metadataType string|nil "action" | "value" | nil (auto-detect if nil, or fallback to auto-detect if forced type fails)
--- @return table|nil Metadata record with actionType|valueType, name, protoName, nagName, nagFunctionName, and messageSchema reference
function SchemaAccessor:GetMetadataByIdentifier(identifier, metadataType)
    if not identifier or type(identifier) ~= "string" then
        return nil
    end

    local originalIdentifier = identifier
    local forcedType = metadataType  -- Remember if type was explicitly specified

    -- Auto-detect metadata type if not specified
    if not metadataType then
        metadataType = self:DetectMetadataType(identifier)
        if not metadataType then
            self:Warn("GetMetadataByIdentifier: Could not detect metadata type for identifier: %s", identifier)
            return nil
        end
    end

    -- Resolve identifier from mappings (handles runtime aliases)
    identifier = self:ResolveIdentifierFromMapping(identifier, metadataType)

    -- Validate snake_case format
    if not identifier:match("^[a-z][a-z0-9_]*$") then
        local typeLabel = (metadataType == "action") and "Action" or "Value"
        self:Warn("GetMetadataByIdentifier: Identifier '%s' does not match snake_case format", identifier)
        return nil
    end

    -- Get schema and appropriate container
    local schema = self:GetSchemaData()
    if not schema or not schema.messages then
        local typeLabel = (metadataType == "action") and "Action" or "Value"
        self:Warn("GetMetadataByIdentifier: Schema not loaded or %s container missing", typeLabel)
        return nil
    end

    local container = (metadataType == "action") and "APLAction" or "APLValue"
    if not schema.messages[container] or not schema.messages[container].fields then
        local typeLabel = (metadataType == "action") and "Action" or "Value"
        self:Warn("GetMetadataByIdentifier: Schema not loaded or %s.fields missing", container)
        return nil
    end

    -- DIRECT snake_case lookup ONLY (no fallbacks, no multi-path)
    local fieldInfo = schema.messages[container].fields[identifier]
    if not fieldInfo then
        -- If type was forced but not found, try auto-detection as fallback
        if forcedType then
            local detectedType = self:DetectMetadataType(originalIdentifier)
            if detectedType and detectedType ~= forcedType then
                -- Found in different container - use auto-detected type
                self:Info("GetMetadataByIdentifier: Forced type '%s' not found for '%s', but found in '%s' container - using auto-detected type", forcedType, originalIdentifier, detectedType)
                return self:GetMetadataByIdentifier(originalIdentifier, nil)  -- Recurse with auto-detection
            end
        end
        local typeLabel = (metadataType == "action") and "action" or "value"
        self:Warn("GetMetadataByIdentifier: %s metadata not found for identifier: %s", typeLabel, identifier)
        return nil
    end

    -- Get message schema reference (not copy)
    local protoName = fieldInfo.message_type
    if not protoName then
        self:Warn("GetMetadataByIdentifier: Field '%s' missing message_type", identifier)
        return nil
    end

    local messageSchema = self:GetMessageSchema(protoName)
    if not messageSchema then
        self:Warn("GetMetadataByIdentifier: Message schema not found for protoName: %s", protoName)
        return nil
    end

    -- Build and return metadata record
    return self:BuildMetadataRecord(identifier, fieldInfo, messageSchema, metadataType)
end

--- Get all metadata for a type (unified for actions and values)
--- @param metadataType string "action" | "value" (required)
--- @return table Array of metadata records with standardized structure
function SchemaAccessor:GetAllMetadata(metadataType)
    if not metadataType or (metadataType ~= "action" and metadataType ~= "value") then
        self:Error("GetAllMetadata: Invalid metadataType '%s' (must be 'action' or 'value')", tostring(metadataType))
        return {}
    end

    local schema = self:GetSchemaData()
    if not schema or not schema.messages then
        self:Error("GetAllMetadata: Schema not loaded")
        return {}
    end

    local results = {}
    local types = (metadataType == "action") and self:GetActionTypes() or self:GetValueTypes()
    local container = (metadataType == "action") and "APLAction" or "APLValue"

    for _, identifier in ipairs(types) do
        -- For actions, filter to only include APLAction* message types
        local shouldSkip = false
        if metadataType == "action" then
            local fieldInfo = schema.messages[container].fields[identifier]
            if fieldInfo and fieldInfo.message_type then
                local protoName = fieldInfo.message_type
                -- FILTER: Skip non-action types (APLValue, UnitReference, ActionID, etc.)
                if not protoName:match("^APLAction") then
                    -- Skip non-action types
                    shouldSkip = true
                end
            end
        end

        if not shouldSkip then
            -- Get metadata using unified function
            local metadata = self:GetMetadataByIdentifier(identifier, metadataType)
            if metadata then
                -- Add fields/field_order from messageSchema for backward compatibility
                if metadata.messageSchema then
                    metadata.fields = metadata.messageSchema.fields
                    metadata.field_order = metadata.messageSchema.field_order
                end
                tinsert(results, metadata)
            end
        end
    end

    -- Sort by name
    sort(results, function(a, b)
        return a.name < b.name
    end)

    return results
end


--- Detect if a clause string is an action or value based on schema metadata
--- Extracts the first NAG function call and checks schema to determine type
--- @param clause string The clause string to analyze (e.g., "NAG:CastSpell(123)" or "NAG:NumberTargets() <= 2")
--- @return string|nil "action" if it's an action, "value" if it's a value, nil if unknown/expression
function SchemaAccessor:DetectActionOrValue(clause)
    if not clause or type(clause) ~= "string" or clause == "" then
        return nil
    end

    -- Extract first NAG function call (e.g., "NAG:CastSpell(123)" -> "CastSpell")
    local functionName = clause:match("^NAG:(%w+)%(")
    if not functionName then
        -- No NAG function call - must be a value expression (comparison, math, logical operators, etc.)
        return "value"
    end

    -- Convert to snake_case for schema lookup
    if not SchemaUtils then
        SchemaUtils = NAG:GetModule("SchemaUtils", true)
    end
    if not SchemaUtils then
        return nil
    end

    local snakeIdentifier = SchemaUtils:CamelToSnake(functionName)
    if not snakeIdentifier then
        return nil
    end

    -- Use unified DetectMetadataType helper
    local detectedType = self:DetectMetadataType(snakeIdentifier)
    if detectedType then
        return detectedType
    end

    -- Not found in either schema - default to value (comparison, math, etc.)
    return "value"
end

--- Get a list of all actions with their UI metadata
--- @return table A list of actions with their UI metadata
function SchemaAccessor:GetAllActionsWithMetadata()
    return self:GetAllMetadata("action")
end

--- Get a list of all values with their UI metadata
--- @return table A list of values with their UI metadata
function SchemaAccessor:GetAllValuesWithMetadata()
    return self:GetAllMetadata("value")
end

--- Get autocomplete data for APLAction or APLValue types
--- @param category string "Actions" or "Values"
--- @return table Array of autocomplete entries {name, label, description, parameterHint, fields}
function SchemaAccessor:GetAutocompleteData(category)
    local results = {}
    local items = {}

    if category == "Actions" then
        items = self:GetAllActionsWithMetadata()
    elseif category == "Values" then
        items = self:GetAllValuesWithMetadata()
    else
        self:Error("Invalid category for autocomplete: " .. tostring(category))
        return results
    end

    for _, item in ipairs(items) do
        -- APL operators that should be lowercase Lua keywords, not NAG handlers
        local APL_OPERATORS = {
            ["not"] = true,
            ["and"] = true,
            ["or"] = true,
            ["cmp"] = true,
            ["math"] = true,
            ["max"] = true,
            ["min"] = true,
        }

        -- Convert schema field name (snake_case) to NAG handler format (NAG:PascalCase)
        -- Special case: APL operators stay as lowercase
        local nagHandler
        local isOperator = APL_OPERATORS[item.name]

        if isOperator then
            -- APL operators: keep as lowercase
            nagHandler = item.name
        else
            -- Regular handlers: convert to NAG:PascalCase
            local SchemaUtils = NAG:GetModule("SchemaUtils")
            local pascalName = SchemaUtils and SchemaUtils:SnakeToPascal(item.name) or nil
            if not pascalName then
                self:Warn("GetAutocompleteData: SnakeToPascal conversion failed for item '%s' (category: %s)", item.name, category)
            end
            nagHandler = pascalName and ("NAG:" .. pascalName) or nil
            if not nagHandler then
                self:Warn("GetAutocompleteData: Could not generate nagHandler for item '%s' (category: %s)", item.name, category)
            end
        end

        -- Build parameter hint from fields
        local paramHints = {}
        if item.fields and next(item.fields) then
            if not item.field_order then
                self:Warn("GetAutocompleteData: Item '%s' (category: %s) has fields but no field_order", item.name, category)
            end

            -- Get message schema for field metadata access
            local messageSchema = item.messageSchema
            if item.field_order then
                for _, fieldName in ipairs(item.field_order) do
                local fieldInfo = item.fields[fieldName]
                if fieldInfo then
                    -- Use UI label from metadata, not proto cardinality label
                        local fieldLabel = nil
                        if messageSchema then
                            fieldLabel = self:GetFieldUILabel(messageSchema, fieldName)
                        end
                        if not fieldLabel then
                            self:Warn("GetAutocompleteData: Could not get UI label for field '%s' in item '%s' (category: %s). Using field name as fallback.", fieldName, item.name, category)
                            fieldLabel = fieldName
                        end

                        local fieldType = fieldInfo.configType or fieldInfo.type
                        if not fieldType then
                            self:Warn("GetAutocompleteData: Field '%s' in item '%s' (category: %s) has no type or configType", fieldName, item.name, category)
                            fieldType = "?"
                        end
                    tinsert(paramHints, fieldLabel .. ": " .. fieldType)
                    end
                end
            end
        end

        local parameterHint = (#paramHints > 0) and concat(paramHints, ", ") or "no parameters"

        if not item.ui_label then
            self:Trace("GetAutocompleteData: Item '%s' (category: %s) has no ui_label", item.name, category)
        end
        if not item.short_description then
            self:Trace("GetAutocompleteData: Item '%s' (category: %s) has no short_description", item.name, category)
        end
        if not item.submenu then
            self:Trace("GetAutocompleteData: Item '%s' (category: %s) has no submenu", item.name, category)
        end

        tinsert(results, {
            name = nagHandler,  -- Display as "NAG:StrictSequence" in autocomplete
            protoName = item.name,  -- Keep original schema name for reference
            label = item.ui_label,
            description = item.short_description,
            fullDescription = item.full_description,
            parameterHint = parameterHint,
            submenu = item.submenu and item.submenu[1] or nil,
            fields = item.fields,
            field_order = item.field_order,
            defaults = item.defaults
        })
    end

    return results
end

--- Check if an item should be included based on its metadata and filter criteria
--- @param category string "Actions" or "Values"
--- @param itemName string The item name
--- @param isPrepull boolean|nil Prepull context (true) or combat (false/nil)
--- @param playerSpec number|nil Player specialization ID
--- @return boolean True if item should be included
function SchemaAccessor:ShouldIncludeItem(category, itemName, isPrepull, playerSpec)
    -- Get the appropriate metadata based on category
    local metadata = nil
    if category == "Actions" then
        metadata = self:GetMetadataByIdentifier(itemName, nil)
    elseif category == "Values" then
        metadata = self:GetMetadataByIdentifier(itemName, nil)
    end

    if not metadata then
        return true -- Default to including if metadata isn't available
    end

    -- No include_if means always include
    local includeIf = metadata.include_if
    if not includeIf then
        return true
    end

    -- ============================ PREPULL/COMBAT CONTEXT ============================
    if isPrepull ~= nil then
        -- If we're in prepull mode and this is combat-only, exclude it
        if isPrepull and includeIf.combat_only then
            return false
        end

        -- If we're in combat mode and this is prepull-only, exclude it
        if not isPrepull and includeIf.prepull_only then
            return false
        end
    end

    -- ============================ NEW FORMAT: CLASS/SPEC FILTERING ============================
    -- Get player info if needed for filtering
    local playerClassToken = nil
    local playerSpecIndex = playerSpec
    local playerSpecToken = nil
    local isInGroup = false
    local isInRaid = false
    local SpecCompat = NAG:GetModule("SpecCompat")
    -- Only get player info if we need it for filtering
    if includeIf.class_specific or includeIf.spec_specific or
       (includeIf.classes and next(includeIf.classes)) or
       (includeIf.specs and next(includeIf.specs)) or
       (includeIf.excluded_classes and next(includeIf.excluded_classes)) or
       (includeIf.excluded_specs and next(includeIf.excluded_specs)) or
       includeIf.requires_group or includeIf.requires_healer_spec or includeIf.requires_tank_spec then

        playerClassToken = self:GetPlayerClassToken()
        if not playerSpecIndex then
            if SpecCompat then
                playerSpecIndex = SpecCompat:GetCurrentSpecIndex()
            end
        end
        if playerSpecIndex then
            playerSpecToken = self:GetPlayerSpecToken()
        end

        -- Check group/raid status
        if includeIf.requires_group then
            isInGroup = (WoWAPI and IsInGroup) and IsInGroup() or false
            isInRaid = (WoWAPI and IsInRaid) and IsInRaid() or false
            if includeIf.requires_group and not isInGroup and not isInRaid then
                return false
            end
        end
    end

    -- ============================ CLASS FILTERING ============================
    if includeIf.class_specific or (includeIf.classes and next(includeIf.classes)) or
       (includeIf.excluded_classes and next(includeIf.excluded_classes)) then

        if not playerClassToken then
            playerClassToken = self:GetPlayerClassToken()
        end

        if playerClassToken then
            -- Check excluded classes first
            if includeIf.excluded_classes and next(includeIf.excluded_classes) then
                for _, excludedClass in ipairs(includeIf.excluded_classes) do
                    local excludedToken = normalizeClassToken(excludedClass)
                    if excludedToken and excludedToken == playerClassToken then
                        return false
                    end
                end
            end

            -- Check allowed classes
            if includeIf.classes and next(includeIf.classes) then
                local isAllowed = false
                for _, allowedClass in ipairs(includeIf.classes) do
                    local allowedToken = normalizeClassToken(allowedClass)
                    if allowedToken and allowedToken == playerClassToken then
                        isAllowed = true
                        break
                    end
                end
                if not isAllowed then
                    return false
                end
            end

            -- Legacy: class_specific flag without classes array
            -- Note: Everything should be parsed now (classes/excluded_classes arrays)
            -- This fallback is only for edge cases where class_specific=true but no classes array
            if includeIf.class_specific and not includeIf.classes then
                -- Can't determine class-specific filtering without classes array
                    -- Default to allowing it if we can't determine
            end
        end
    end

    -- ============================ SPEC FILTERING ============================
    if includeIf.spec_specific or (includeIf.specs and next(includeIf.specs)) or
       (includeIf.excluded_specs and next(includeIf.excluded_specs)) or
       includeIf.requires_healer_spec or includeIf.requires_tank_spec then

        if not playerSpecIndex then
            local SpecCompat = NAG:GetModule("SpecCompat")
            if SpecCompat then
                playerSpecIndex = SpecCompat:GetCurrentSpecIndex()
            end
        end

        if playerSpecIndex then
            -- Check excluded specs
            if includeIf.excluded_specs and next(includeIf.excluded_specs) then
                for _, excludedSpec in ipairs(includeIf.excluded_specs) do
                    if type(excludedSpec) == "number" and excludedSpec == playerSpecIndex then
                        return false
                    elseif type(excludedSpec) == "string" then
                        local excludedToken = normalizeSpecToken(excludedSpec)
                        if excludedToken and playerSpecToken and excludedToken == playerSpecToken then
                            return false
                        end
                    end
                end
            end

            -- Check allowed specs
            if includeIf.specs and next(includeIf.specs) then
                local isAllowed = false
                for _, allowedSpec in ipairs(includeIf.specs) do
                    if type(allowedSpec) == "number" and allowedSpec == playerSpecIndex then
                        isAllowed = true
                        break
                    elseif type(allowedSpec) == "string" then
                        local allowedToken = normalizeSpecToken(allowedSpec)
                        if allowedToken and playerSpecToken and allowedToken == playerSpecToken then
                            isAllowed = true
                            break
                        end
                    end
                end
                if not isAllowed then
                    return false
                end
            end

            -- Check healer/tank spec requirements (using SpecCompat for role checks)
            if includeIf.requires_healer_spec or includeIf.requires_tank_spec then
                local specRole = SpecCompat and SpecCompat:GetSpecRole(playerSpecIndex)

                if includeIf.requires_healer_spec and specRole ~= "HEALER" then
                    return false
                end

                if includeIf.requires_tank_spec and specRole ~= "TANK" then
                    return false
                end
            end

            -- Legacy: spec_specific flag without specs arrays
            -- Note: Everything should be parsed now (specs/excluded_specs arrays)
            -- This fallback is only for edge cases where spec_specific=true but no specs arrays
            if includeIf.spec_specific and not includeIf.specs and not includeIf.excluded_specs then
                -- Can't determine spec-specific filtering without specs arrays
                -- Default to allowing it if we can't determine
            end
        end
    end

    -- ============================ REQUIREMENT CHECKS ============================
    -- Check requiresItemSwap (skip for now - would need rotation config access)
    if includeIf.requires_item_swap then
        -- TODO: Check if item swap is enabled in rotation config
        -- For now, default to allowing (can't check without rotation access)
    end

    -- Check requiresTargetDummies (skip for now - would need encounter config)
    if includeIf.requires_target_dummies then
        -- TODO: Check if target dummies are configured
        -- For now, default to allowing
    end

    -- Check requiresSecondaryResource (skip for now - would need class-specific checks)
    if includeIf.requires_secondary_resource then
        -- TODO: Check if class has secondary resource
        -- For now, default to allowing
    end

    return true
end

--- Get a list of actions grouped by submenu with optional filtering
--- @param filterBySpec boolean|nil Filter by current spec
--- @param filterByPrepull boolean|nil Filter by prepull context
--- @param isPrepull boolean|nil Current prepull context (if filtering)
--- @param playerSpec number|nil Player specialization ID (if filtering)
--- @return table Actions grouped by submenu
function SchemaAccessor:GetActionsGroupedBySubmenu(filterBySpec, filterByPrepull, isPrepull, playerSpec)
    local actions = self:GetAllActionsWithMetadata()
    local grouped = {}

    for _, action in ipairs(actions) do
        -- Apply filtering if requested
        local shouldInclude = true
        if filterBySpec or filterByPrepull then
            shouldInclude = self:ShouldIncludeItem("Actions", action.name, isPrepull, playerSpec)
        end

        if shouldInclude then
            local submenu = action.submenu and action.submenu[1] or "Other"
            grouped[submenu] = grouped[submenu] or {}
            tinsert(grouped[submenu], action)
        end
    end

    -- Sort actions within each submenu
    for submenu, submenuActions in pairs(grouped) do
        sort(submenuActions, function(a, b)
            local labelA = a.ui_label or a.name or ""
            local labelB = b.ui_label or b.name or ""
            return labelA:lower() < labelB:lower()
        end)
    end

    return grouped
end

--- Get a list of values grouped by submenu with optional filtering
--- @param filterBySpec boolean|nil Filter by current spec
--- @param filterByPrepull boolean|nil Filter by prepull context
--- @param isPrepull boolean|nil Current prepull context (if filtering)
--- @param playerSpec number|nil Player specialization ID (if filtering)
--- @return table Values grouped by submenu
function SchemaAccessor:GetValuesGroupedBySubmenu(filterBySpec, filterByPrepull, isPrepull, playerSpec)
    local values = self:GetAllValuesWithMetadata()
    local grouped = {}

    for _, value in ipairs(values) do
        -- Apply filtering if requested
        local shouldInclude = true
        if filterBySpec or filterByPrepull then
            shouldInclude = self:ShouldIncludeItem("Values", value.name, isPrepull, playerSpec)
        end

        if shouldInclude then
            local submenu = value.submenu and value.submenu[1] or "Other"
            grouped[submenu] = grouped[submenu] or {}
            tinsert(grouped[submenu], value)
        end
    end

    -- Sort values within each submenu
    for submenu, submenuValues in pairs(grouped) do
        sort(submenuValues, function(a, b)
            local labelA = a.ui_label or a.name or ""
            local labelB = b.ui_label or b.name or ""
            return labelA:lower() < labelB:lower()
        end)
    end

    return grouped
end

--- Get consumable enum to ID mapping
--- Extracts consumables from ConsumesSpec message fields (new schema structure)
--- @return table Mapping of consumable enum names to IDs in old format for compatibility
function SchemaAccessor:GetConsumableEnumToId()
    local schema = self:GetSchemaData()
    if not schema or not schema.messages or not schema.messages.ConsumesSpec then
        return {}
    end

    local consumableMap = {}
    local consumesSpec = schema.messages.ConsumesSpec

    if consumesSpec.fields then
        for fieldName, fieldDef in pairs(consumesSpec.fields) do
            if fieldDef._metadata then
                -- Each entry in _metadata is a consumable option
                for exportKey, entry in pairs(fieldDef._metadata) do
                    if entry.ids then
                        -- Determine the type (item or spell)
                        local idType = nil
                        local idValue = nil

                        if entry.ids.item then
                            idType = "item"
                            -- Handle both single ID and array
                            if type(entry.ids.item) == "table" then
                                idValue = entry.ids.item
                            else
                                idValue = { entry.ids.item }
                            end
                        elseif entry.ids.spell then
                            idType = "spell"
                            if type(entry.ids.spell) == "table" then
                                idValue = entry.ids.spell
                            else
                                idValue = { entry.ids.spell }
                            end
                        end

                        if idType and idValue then
                            -- Use export name as the key (matches old enum key pattern)
                            local enumKey = entry.export or exportKey

                            -- Build entry in old format for compatibility
                            consumableMap[enumKey] = {
                                Simple = {
                                    id = #idValue == 1 and idValue[1] or idValue,
                                    type = idType,
                                    name = entry.export or exportKey,
                                    value = entry.value -- Enum value if present
                                }
                            }
                        end
                    end
                end
            end
        end
    end

    return consumableMap
end

-- ============================ TRANSLATION METHODS ============================
-- Methods for translating between proto names (APLAction*, APLValue*) and NAG handler names

--- Get NAG function name from proto message name
--- @param protoName string The proto message name (e.g., "APLActionCastSpell")
--- @return string|nil The NAG handler name (e.g., "Cast") or nil if no mapping found
function SchemaAccessor:GetNagNameFromProtoName(protoName)
    if not protoName or type(protoName) ~= "string" then
        return nil
    end

    -- Handle APLAction* -> Action name mapping
    if protoName:match("^APLAction(.+)$") then
        local actionName = protoName:match("^APLAction(.+)$")
        if actionName then
            -- Convert CamelCase to function name
            -- APLActionCastSpell -> Cast
            -- APLActionMultidot -> Multidot
            return actionName
        end
    end

    -- Handle APLValue* -> Value name mapping
    if protoName:match("^APLValue(.+)$") then
        local valueName = protoName:match("^APLValue(.+)$")
        if valueName then
            -- NOTE: Aura* pattern swapping is DISABLED - use nagFunctionMappings instead
            -- This was causing issues because runtime aliases (APL_Aliases.lua) don't match
            -- the swapped names. For example:
            -- - Runtime alias: NAG.AuraIsActive = NAG.IsActive
            -- - Swapped name would be: IsActiveAura (doesn't exist as runtime alias)
            -- - Users call: AuraIsActive (which works via runtime alias)
            -- - Solution: Use explicit nagFunctionMappings for these cases
            --
            -- If you need to handle Aura* -> *Aura pattern, add explicit mappings:
            -- self.nagFunctionMappings["AuraIsActive"] = "APLValueAuraIsActive"

            -- Convert CamelCase to function name
            -- APLValueDotIsActive -> DotIsActive
            -- APLValueCurrentRuneCount -> CurrentRuneCount
            return valueName
        end
    end

    -- Handle other common patterns
    if protoName:match("^APL(.+)$") then
        local baseName = protoName:match("^APL(.+)$")
        if baseName then
            return baseName
        end
    end

    -- Common message types that don't need NAG handler names (used as field types only)
    local commonMessageTypes = {
        UnitReference = true,
        ActionID = true,
        SpellReference = true,
        Duration = true,
        UUID = true,
    }

    if commonMessageTypes[protoName] then
        -- These are common message types used as field types, not NAG handlers
        -- Return nil silently (no warning needed)
        return nil
    end

    -- Only warn for proto names that look like handler types (APLAction*, APLValue*, APL*)
    -- but still have no mapping. Other message types (e.g. MageArcaneSpells, UIDatabase,
    -- RestorationDruid, CharacterStatsTestResult) are schema structures, not NAG handlers.
    if protoName:match("^APL") and ns.DevDebugUtils and ns.DevDebugUtils.IsDebugEnabled(NAG, "SchemaAccessor") then
        self:Warn("GetNagNameFromProtoName: No mapping found for protoName '%s'. Schema may be missing proper proto name pattern.", protoName)
    end
    return nil
end

--- Get proto message name from NAG handler name
--- @param nagName string The NAG handler name (e.g., "Cast")
--- @return string|nil The proto message name (e.g., "APLActionCastSpell") or nil if not found
function SchemaAccessor:GetProtoNameFromNagName(nagName)
    if not nagName or type(nagName) ~= "string" then
        return nil
    end

    -- Check exceptions first (nagFunctionMappings for special cases like "Cast" and "AuraIsActive")
    local protoName = self.nagFunctionMappings[nagName]
    if protoName then
        return protoName
    end

    -- Convert nagName to snake_case for schema field lookup
    -- "RuneSlotCooldown" → "rune_slot_cooldown"
    if not SchemaUtils then
        SchemaUtils = NAG:GetModule("SchemaUtils", true)
    end
    if not SchemaUtils then
        return nil
    end

    local snakeName = SchemaUtils:CamelToSnake(nagName)
    if not snakeName then
        return nil
    end

    -- Check schema structure directly - this is where the function is actually defined
    local schemaData = self:GetSchemaData()
    if not schemaData or not schemaData.messages then
        return nil
    end

    -- Check APLAction.fields first (actions are defined here)
    local aplAction = schemaData.messages.APLAction
    if aplAction and aplAction.fields and aplAction.fields[snakeName] then
        local fieldInfo = aplAction.fields[snakeName]
        if fieldInfo and fieldInfo.message_type then
            return fieldInfo.message_type  -- Returns "APLActionRuneSlotCooldown"
        end
    end

    -- Check APLValue.fields if not found in actions (values are defined here)
    local aplValue = schemaData.messages.APLValue
    if aplValue and aplValue.fields and aplValue.fields[snakeName] then
        local fieldInfo = aplValue.fields[snakeName]
        if fieldInfo and fieldInfo.message_type then
            return fieldInfo.message_type  -- Returns "APLValueRuneSlotCooldown"
        end
    end

    return nil
end

--- Get all protoName -> nagName mappings (cached)
--- Returns a table mapping proto message names to NAG handler names
--- @return table Table of protoName -> nagName mappings
function SchemaAccessor:GetAllProtoToNagMappings()
    -- Return cached table if available
    if self.protoToNagCache then
        return self.protoToNagCache
    end

    -- Build cache on first call
    self.protoToNagCache = {}
    local schemaData = self:GetSchemaData()
    if not schemaData or not schemaData.messages then
        return self.protoToNagCache
    end

    for protoName, messageInfo in pairs(schemaData.messages) do
        local nagName = self:GetNagNameFromProtoName(protoName)
        if nagName and nagName ~= protoName then
            self.protoToNagCache[protoName] = nagName
        end
    end

    if self.debug then
        self:Debug("Generated %d protoName -> nagName mappings", TableUtils.Size(self.protoToNagCache))
    end

    return self.protoToNagCache
end

--- Get all argument mappings (cached)
--- Returns a table mapping proto message names to their argument mappings
--- Get all argument mappings (DEPRECATED)
--- This function is deprecated - field_order modifications are now used instead

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~

-- String case conversion now handled by SchemaUtils
-- Use SchemaUtils:SnakeToCamel() and SchemaUtils:CamelToSnake() instead

-- ============================ SCHEMA STRUCTURE VALIDATION ============================

--- Known metadata fields that should ONLY be in _metadata
local METADATA_FIELDS = {
    uiLabel = true,
    submenu = true,
    shortDescription = true,
    fullDescription = true,  -- Only fullDescription exists in source schema (no longDescription)
    category = true,
    function_type = true,
    include_if = true,
    defaults = true
}

--- Known proto structural fields (should be on message, not in _metadata)
local PROTO_STRUCTURAL_FIELDS = {
    fields = true,
    field_order = true,
    oneofs = true,
    _metadata = true  -- _metadata itself is structural
}

--- Validate schema structure
--- Checks that metadata is only in _metadata and proto fields are in correct locations
--- @param verbose boolean|nil Show detailed information for each message
--- @return boolean valid Whether the schema structure is valid
--- @return table|nil issues Table of issues found (if any)
function SchemaAccessor:ValidateSchemaStructure(verbose)
    local schema = self:GetSchemaData()
    if not schema or not schema.messages then
        return false, { { type = "error", message = "Schema not loaded" } }
    end

    local issues = {}
    local messageCount = 0
    local validCount = 0
    local invalidCount = 0

    -- Check each message in the schema
    for messageType, message in pairs(schema.messages) do
        messageCount = messageCount + 1
        local messageIssues = {}
        local isValid = true

        -- Check for metadata fields directly on message (should be in _metadata)
        for fieldName, _ in pairs(METADATA_FIELDS) do
            if message[fieldName] ~= nil then
                isValid = false
                tinsert(messageIssues, {
                    type = "metadata_duplicate",
                    field = fieldName,
                    message = format("Metadata field '%s' found directly on message (should be in _metadata)", fieldName)
                })
            end
        end

        -- Check _metadata structure
        if message._metadata then
            -- Verify _metadata is a table
            if type(message._metadata) ~= "table" then
                isValid = false
                tinsert(messageIssues, {
                    type = "metadata_invalid",
                    message = "_metadata is not a table"
                })
            else
                -- Check for proto structural fields in _metadata (shouldn't be there)
                for fieldName, _ in pairs(PROTO_STRUCTURAL_FIELDS) do
                    if message._metadata[fieldName] ~= nil then
                        isValid = false
                        tinsert(messageIssues, {
                            type = "metadata_proto_field",
                            field = fieldName,
                            message = format("Proto structural field '%s' found in _metadata (should be on message)", fieldName)
                        })
                    end
                end
            end
        end

        -- Check for required proto fields
        if not message.fields then
            -- Some messages might not have fields (enums, etc.), so this is a warning
            if verbose then
                tinsert(messageIssues, {
                    type = "warning",
                    message = "Message has no 'fields' property"
                })
            end
        end

        -- Check field definitions for metadata in wrong place
        if message.fields then
            for fieldName, fieldDef in pairs(message.fields) do
                if type(fieldDef) == "table" then
                    -- Check for metadata fields directly on field definition
                    for metaField, _ in pairs(METADATA_FIELDS) do
                        if fieldDef[metaField] ~= nil and not fieldDef._metadata then
                            isValid = false
                            tinsert(messageIssues, {
                                type = "field_metadata_duplicate",
                                field = fieldName,
                                metaField = metaField,
                                message = format("Field '%s' has metadata '%s' directly on field (should be in field._metadata)", fieldName, metaField)
                            })
                        end
                    end
                end
            end
        end

        -- Validate required metadata for action/value message types
        if messageType:match("^APLAction") or messageType:match("^APLValue") then
            if not message._metadata then
                isValid = false
                tinsert(messageIssues, {
                    type = "missing_metadata",
                    message = format("Action/Value message type '%s' has no _metadata (required for actions/values)", messageType)
                })
            else
                -- Check for required metadata fields
                if not message._metadata.ui_label then
                    isValid = false
                    tinsert(messageIssues, {
                        type = "missing_required_metadata",
                        field = "ui_label",
                        message = format("Action/Value message type '%s' missing required ui_label in _metadata", messageType)
                    })
                end
                if not message._metadata.short_description then
                    isValid = false
                    tinsert(messageIssues, {
                        type = "missing_required_metadata",
                        field = "short_description",
                        message = format("Action/Value message type '%s' missing required short_description in _metadata", messageType)
                    })
                end
            end
        end

        -- Validate APLAction and APLValue container messages
        if messageType == "APLAction" or messageType == "APLValue" then
            if message.fields then
                for fieldName, fieldDef in pairs(message.fields) do
                    if type(fieldDef) == "table" and fieldDef.message_type then
                        local referencedMessageType = fieldDef.message_type
                        local referencedMessage = schema.messages[referencedMessageType]
                        if referencedMessage then
                            -- Check that referenced message type has required metadata
                            if not referencedMessage._metadata then
                                isValid = false
                                tinsert(messageIssues, {
                                    type = "referenced_message_missing_metadata",
                                    field = fieldName,
                                    referencedType = referencedMessageType,
                                    message = format("Referenced message type '%s' (from %s.%s) has no _metadata", referencedMessageType, messageType, fieldName)
                                })
                            else
                                if not referencedMessage._metadata.ui_label then
                                    isValid = false
                                    tinsert(messageIssues, {
                                        type = "referenced_message_missing_metadata",
                                        field = fieldName,
                                        referencedType = referencedMessageType,
                                        message = format("Referenced message type '%s' (from %s.%s) missing required ui_label", referencedMessageType, messageType, fieldName)
                                    })
                                end
                                if not referencedMessage._metadata.short_description then
                                    isValid = false
                                    tinsert(messageIssues, {
                                        type = "referenced_message_missing_metadata",
                                        field = fieldName,
                                        referencedType = referencedMessageType,
                                        message = format("Referenced message type '%s' (from %s.%s) missing required short_description", referencedMessageType, messageType, fieldName)
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end

        if #messageIssues > 0 then
            invalidCount = invalidCount + 1
            tinsert(issues, {
                messageType = messageType,
                issues = messageIssues
            })
        else
            validCount = validCount + 1
        end
    end

    local allValid = #issues == 0

    -- Print summary
    self:Print("=== Schema Structure Validation ===")
    self:Print(format("Total messages: %d", messageCount))
    self:Print(format("Valid: %d", validCount))
    self:Print(format("Invalid: %d", invalidCount))

    if allValid then
        self:Print("✓ All messages have valid structure")
    else
        self:Print(format("✗ Found %d message(s) with structure issues:", #issues))
        for _, issueGroup in ipairs(issues) do
            self:Print(format("  %s:", issueGroup.messageType))
            for _, issue in ipairs(issueGroup.issues) do
                local prefix = issue.type == "error" and "    ERROR:" or
                              issue.type == "warning" and "    WARN:" or
                              "    ISSUE:"
                self:Print(format("%s %s", prefix, issue.message))
            end
        end
    end

    if verbose and allValid then
        self:Print("\nDetailed validation (all messages valid):")
        for messageType, message in pairs(schema.messages) do
            local metadataCount = message._metadata and TableUtils.Size(message._metadata) or 0
            local fieldsCount = message.fields and TableUtils.Size(message.fields) or 0
            self:Print(format("  %s: %d fields, %d metadata entries", messageType, fieldsCount, metadataCount))
        end
    end

    return allValid, #issues > 0 and issues or nil
end

--- Slash command handler for schema validation
--- Usage: /nagdebug schema validate [verbose]
function SchemaAccessor:schema_validate(input)
    local args = {}
    for word in input:gmatch("%S+") do
        tinsert(args, word)
    end

    local verbose = args[1] == "verbose" or args[1] == "v"
    self:ValidateSchemaStructure(verbose)
end

--- Slash command handler for dumping message type metadata
--- Usage: /nagdebug schema metadata <MessageType>
function SchemaAccessor:schema_metadata(input)
    local args = {}
    for word in input:gmatch("%S+") do
        tinsert(args, word)
    end

    local messageType = args[1]
    if not messageType then
        self:Print("Usage: /nagdebug schema metadata <MessageType>")
        self:Print("Example: /nagdebug schema metadata APLValueDotTickFrequency")
        return
    end

    local messageSchema = self:GetMessageSchema(messageType)
    if not messageSchema then
        self:Print(format("Message type '%s' not found", messageType))
        return
    end

    self:Print(format("=== Metadata for %s ===", messageType))

    if not messageSchema._metadata or not next(messageSchema._metadata) then
        self:Print("No metadata found for this message type")
        self:Print(format("Use /dump NAG:GetModule('SchemaAccessor'):GetMessageSchema('%s')._metadata", messageType))
        return
    end

    local metadata = messageSchema._metadata

    -- Print metadata fields
    for key, value in pairs(metadata) do
        if type(value) == "table" then
            self:Print(format("  %s:", key))
            if key == "submenu" and type(value) == "table" and #value > 0 then
                self:Print(format("    %s", table.concat(value, " > ")))
            elseif key == "include_if" then
                -- condition field removed - use structured fields (classes, specs, flags) instead
                if value.prepull_only ~= nil then
                    self:Print(format("    prepull_only: %s", tostring(value.prepull_only)))
                end
                if value.combat_only ~= nil then
                    self:Print(format("    combat_only: %s", tostring(value.combat_only)))
                end
                if value.spec_specific ~= nil then
                    self:Print(format("    spec_specific: %s", tostring(value.spec_specific)))
                end
            elseif key == "defaults" then
                self:Print(format("    %s", tostring(value)))
            else
                -- For other tables, print a summary
                local count = 0
                for _ in pairs(value) do count = count + 1 end
                self:Print(format("    [table with %d entries]", count))
            end
        else
            self:Print(format("  %s: %s", key, tostring(value)))
        end
    end

    -- Also provide /dump command
    self:Print(format("=== Full /dump format ==="))
    self:Print(format("/dump NAG:GetModule('SchemaAccessor'):GetMessageSchema('%s')._metadata", messageType))
end


