--- @module "NAG.DataManager"
--- Handles data management and processing for the NAG addon.
---
--- This module provides functions for managing, processing, and indexing all versioned and runtime data entities (spells, items, sets, etc) in NAG. Handles entity relationships, type/flag indexing, and provides high-level data access APIs.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
-- ISSUES: Clean it all up
-- 1. big issue is only first item added gives the behavior, the rest are just added as flags.

-- ~~~~~~~~~~ BEHAVIOR ATTACHMENT TOGGLE ~~~~~~~~~~
-- Toggle between old direct copying approach (true) and new metatable approach (false)
local USE_DIRECT_BEHAVIOR_COPYING = true

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local UnitGUID = _G.UnitGUID
local UnitName = _G.UnitName
local UnitCreatureFamily = _G.UnitCreatureFamily
local WoWAPI = ns.WoWAPI
local GetItemInfoInstant = C_Item and C_Item.GetItemInfoInstant or _G.GetItemInfoInstant
local GetItemSpell = C_Item and C_Item.GetItemSpell or _G.GetItemSpell
-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type Types
local Types

--- @type DataWalker
--- @type any
local DataWalker, SchemaAccessor


-- Add GetItemInfoInstant to the localizations at the top


-- Lua APIs (using WoW's optimized versions where available)
local format = string.format

-- Bitwise operations (Lua 5.1 / WoW)
local band = bit.band

local strsplit = strsplit
local wipe = wipe
local tContains = tContains


-- Use TableUtils for table operations
local TableUtils = ns.TableUtils

-- Enhanced error handling
local pcall = ns.pcall

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- ======= FORWARD DECLARATIONS =======
--- Helper functions
local initializeStorage
local getEntityStorage
local createBaseEntry
local transformPath
local updateNameIndex
local getRelationshipType

--- Forward declarations for processors
local ProcessorV2
local ItemProcessorV2
local SpellProcessorV2
local TierSetProcessorV2
local ProcessorsV2 = {}

--- @class DataManager: CoreModule, AceConsole-3.0
local DataManager = NAG:CreateModule("DataManager", {}, {
    debug = false,
    logInitialData = false,
    eventHandlers = {
        ITEM_DATA_LOAD_RESULT = true,
        PLAYER_ENTERING_WORLD = true,
        SPELLS_CHANGED = true,
        LEARNED_SPELL_IN_TAB = true,
        PLAYER_TALENT_UPDATE = true,
        ACTIVE_TALENT_GROUP_CHANGED = true,
        PLAYER_EQUIPMENT_CHANGED = true,
    },
    messageHandlers = {
        NAG_VERSION_DATA_SELECTED = true,
        NAG_SPEC_UPDATED = true,
        NAG_TALENTS_UPDATED = true,
    },

    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.SERVICES
    },
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,

    -- Zero-boilerplate slash command registration
    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["data_debug"] = {
            handler = "HandleDataDebugCommand",
            help = "Data manager debug commands",
            root = "nagdebug",
            path = {"data", "debug"},
            category = "Data"
        },
        ["data_errors"] = {
            handler = "HandleErrorsCommand",
            help = "Show recent data manager errors",
            root = "nagdebug",
            path = {"data", "errors"},
            category = "Data"
        },
        ["data_enhanced"] = {
            handler = "HandleEnhancedDebugCommand",
            help = "Enhanced data debugging (talent, spell, item, etc.)",
            root = "nagdebug",
            path = {"data", "enhanced"},
            category = "Data"
        }
    },
})
local module = DataManager
ns.DataManager = DataManager

-- ============================ DEVELOPER DEBUG HELPERS ============================

-- Developer debug helper functions for processor classes

local PET_CLASSES = {
    HUNTER = true,
    WARLOCK = true,
    DEATHKNIGHT = true
}
-- Constants and Types
DataManager.EntityTypes = {
    SPELL = "spell",
    ITEM = "item",
    TIERSET = "tierset",
    ENCHANT = "enchant",
    NPC = "npc",
    AURA = "aura",
    DOT = "dot",
    PET = "pet",
    TOTEM = "totem",
    TALENT = "talent",
    BATTLEPET = "battlepet",
}

--- Enum for spell positions (using standardized constants)
DataManager.SpellPosition = {
    LEFT = ns.SPELL_POSITIONS.LEFT,
    RIGHT = ns.SPELL_POSITIONS.RIGHT,
    ABOVE = ns.SPELL_POSITIONS.ABOVE,
    BELOW = ns.SPELL_POSITIONS.BELOW,
    AOE = ns.SPELL_POSITIONS.AOE,
    PRIMARY = ns.SPELL_POSITIONS.PRIMARY,
    SEQUENCE = ns.SPELL_POSITIONS.SEQUENCE
}


-- Path components to ignore when creating flags
-- Performance optimization:
-- 1. First 3 nodes (ns, data, flavor) are always skipped in processTypes/processFlags
-- 2. Type processing starts after entity type markers (Items, Spells, Consumable, etc.)
local IGNORED_PATH_COMPONENTS = {
    -- Namespace/structural components (always ignored)
    ["ns"] = true,
    ["data"] = true,
    ["mists"] = true,
    ["vanilla"] = true,
    ["tbc"] = true,
    ["wrath"] = true,
    ["cata"] = true,
    ["sod"] = true,

    -- API type markers (flags added automatically)
    ["Items"] = true,
    ["Spells"] = true,
    ["Talents"] = true,
    ["TierSets"] = true,
    ["Enchants"] = true,
    ["Buffs"] = true,
    ["ClassSpells"] = true,
    ["SpellRequirements"] = true, -- SpellRequirements is a data organization marker

    -- Entity type markers (these are data organization, not flags)
    ["Consumable"] = true,

    -- Data organization markers (not types)
    ["flags"] = true,
    ["slot"] = true,
    -- Version/expansion markers - we shouldn't ever see these w/dataloader

    -- Data organization markers
    ["Data"] = true,
    ["Common"] = true,
    ['uncategorized'] = true,
    ["individualBuff"] = true,
    ["worldBuff"] = true,
    ["trinketBuffs"] = true,
    ['utility'] = true,
    ['other'] = true,
    ['OtherItems'] = true,
    -- Path components that shouldn't be flags
    ["BloodElf"] = true,
    ["Dwarf"] = true,
    ["Tauren"] = true,
    ["Worgen"] = true,
    ["Human"] = true,
    ["Troll"] = true,
    ["Goblin"] = true,
    ["Orc"] = true,
    ["NightElf"] = true,
    ["Gnome"] = true,
    ["Draenei"] = true,
    ["Undead"] = true,

    -- Class/spec specific markers that shouldn't be flags
    ["WARRIOR"] = true,
    ["PALADIN"] = true,
    ["HUNTER"] = true,
    ["ROGUE"] = true,
    ["PRIEST"] = true,
    ["SHAMAN"] = true,
    ["MAGE"] = true,
    ["WARLOCK"] = true,
    ["MONK"] = true,
    ["DRUID"] = true,
    ["DEMONHUNTER"] = true,
    ["DEATHKNIGHT"] = true,
    ["EVOKER"] = true,
}

-- Fields to exclude from direct entry copying (these are handled by the processing logic)
local EXCLUDED_ENTRY_FIELDS = {
    ["itemId"] = true,        -- Used for initial lookup
    ["spellId"] = true,       -- Used for initial lookup
    ["tiersetId"] = true,     -- Used for initial lookup
    ["flags"] = true,         -- System managed
    ["parentId"] = true,      -- System managed
    ["relationships"] = true, -- System managed
    -- Data organization and effect type fields that shouldn't be flags
    ["requirements"] = true,  -- Data organization marker
    ["effects"] = true,       -- Data structure, not a flag
    ["ranks"] = true,         -- Data structure, not a flag
    ["spells"] = true,        -- Data structure, not a flag
}

-- Map ID fields to their entity types
local ID_TYPE_MAPPINGS = {
    ["itemId"] = DataManager.EntityTypes.ITEM,
    ["spellId"] = DataManager.EntityTypes.SPELL,
    ["buffId"] = DataManager.EntityTypes.SPELL,      -- Buffs are actually spells
    ["dotId"] = DataManager.EntityTypes.SPELL,       -- DoTs are spells that deal periodic damage
    ["auraId"] = DataManager.EntityTypes.SPELL,      -- Auras are spells that apply a buff
    ["enchantId"] = DataManager.EntityTypes.ENCHANT, -- Enchants are actually spells
    ["tiersetId"] = DataManager.EntityTypes.TIERSET,
    ["npcId"] = DataManager.EntityTypes.NPC,
    ["totemId"] = DataManager.EntityTypes.NPC,     -- Totems are technically NPCs
    ["procId"] = DataManager.EntityTypes.SPELL,    -- Procs are spells
    ["talentId"] = DataManager.EntityTypes.TALENT, -- T
}

-- Default position mappings
local DEFAULT_POSITIONS = {
    -- Entries that go above
    ABOVE = {
        flags = {
            "stance" -- Stances always go above
        }
    },
    -- Entries that go below
    BELOW = {
        flags = {
            "pet",  -- Pet abilities go below
            "totem" -- Totems go below
        }
    },
    -- Entries that go left
    LEFT = {
        flags = {
            "racial",   -- Racials go left
            "battlepet" -- Battlepets go left
        },
        --    types = {
        --        "item" -- Items always go left (by type)
        --    }
    }
    -- RIGHT and AOE positions are typically class/spec specific and set later
}
--- @class ProcessorV2
ProcessorV2 = {

    Debug = function(self, msg, ...)
        if DataManager.debug then
            DataManager:Debug(msg, ...)
        end
    end,

    Trace = function(self, msg, ...)
        if DataManager.debug then
            DataManager:Trace(msg, ...)
        end
    end,

    Warn = function(self, msg, ...)
        if DataManager.debug then
            DataManager:Warn(msg, ...)
        end
    end,

    Error = function(self, msg, ...)
        if DataManager.debug then
            DataManager:Error(msg, ...)
        end
    end,

    Info = function(self, msg, ...)
        if DataManager.debug then
            DataManager:Info(msg, ...)
        end
    end,

    -- Data readiness check (override in specific processors)
    isDataReady = function(self, id)
        return true
    end,

    -- Queue data loading (override in specific processors)
    queueDataLoad = function(self, id, entry)
        -- Default implementation does nothing
    end,

    -- Core processing method
    process = function(self, id, path, rawEntry)
        -- Wrap entire processing in pcall for safety
        local success, result = pcall(function()
            -- Validate inputs
            if not id or type(id) ~= "number" then
                if DataManager.debug then
                    DataManager:Warn(format("[%s] Invalid ID provided to process: %s (type: %s)",
                        tostring(self.entityType or "unknown"), tostring(id or "nil"), type(id or "nil")))
                end
                return false
            end

            -- Validate ID value - 0 is not a valid ID for any entity type
            if id == 0 then
                if DataManager.debug then
                    DataManager:Debug(format("[%s] Skipping processing for invalid ID: 0 (likely placeholder or missing data)",
                        tostring(self.entityType or "unknown")))
                end
                return false
            end

            -- Skip dummy trigger IDs that are not actual spells (for spell entities)
            if self.entityType == DataManager.EntityTypes.SPELL and id == 18350 then
                return false
            end

            if not path or type(path) ~= "table" then
                if DataManager.debug then
                    DataManager:Warn(format("[%s] Invalid path provided to process for ID %d: %s (type: %s)",
                        tostring(self.entityType or "unknown"), tostring(id or "nil"), tostring(path or "nil"),
                        type(path or "nil")))
                end
                path = { self.entityType } -- Provide default path
            end

            -- Create base entry with all necessary fields
            local entry = createBaseEntry(self.entityType, id, path)

            -- Validate the entry type and data
            local valid, err = self:validateType(entry, rawEntry)
            if not valid then
                --TODO: This should be a warn/error, but the tiersets having multi id's for some still an 'issue'
                if DataManager.debug then
                    DataManager:Debug(format("[%s] Invalid data - %s (ID: %d)",
                        tostring(self.entityType or "unknown"), tostring(err or "unknown error"), tostring(id or "nil")))
                end
                return false
            end

            -- Process types from both path and raw data
            self:processTypes(entry, rawEntry)

            -- Process raw data if we have it
            if rawEntry then
                -- Process raw data (handles relationships)
                if not self:processRawData(entry, rawEntry) then
                    if DataManager.debug then
                        DataManager:Warn(format("[%s] Failed to process raw data for ID: %d",
                            tostring(self.entityType or "unknown"), tostring(id or "nil")))
                    end
                    return false
                end
            end

            -- Process core data (API calls etc)
            if not self:processData(entry, id) then
                -- Check if this is a permanently failed item
                if entry.permanentlyFailed then
                    if DataManager.debug then
                        DataManager:Debug(format(
                            "[%s] Item %d: Permanently failed - item likely doesn't exist in current game version",
                            tostring(self.entityType or "unknown"), tostring(id or "nil")))
                    end
                    return false
                end

                -- If data isn't ready, queue loading and return existing if we have it
                local existing = self:read(id)
                if not self:isDataReady(id) then
                    self:queueDataLoad(id, existing or entry)
                    if DataManager.debug then
                        DataManager:Debug(format("[%s] Queued ID %d for data loading (expected behavior for uncached items)",
                            tostring(self.entityType or "unknown"), tostring(id or "nil")))
                    end
                    return existing or entry
                end

                -- This is a real failure - log with more details
                if DataManager.debug then
                    DataManager:Warn(format("[%s] Failed to process data for ID: %d (path: %s, failedAttempts: %d)",
                        tostring(self.entityType or "unknown"), tostring(id or "nil"),
                        path and table.concat(path, ".") or "unknown",
                        tostring(entry and entry.failedAttempts or 0)))
                end
                return false
            end

            -- Process flags from path components
            self:processFlags(entry, path)

            -- Attach behaviors
            self:attachBehaviors(entry)

            -- Create/merge entry (create now handles merging with existing entries)
            entry = self:create(id, entry)
            if not entry then
                if DataManager.debug then
                    DataManager:Warn(format("[%s] Failed to create/merge ID: %d",
                        tostring(self.entityType or "unknown"), tostring(id or "nil")))
                end
                return false
            end

            self:processRelationships(entry)

            -- Only process position for original entries (not trinket effects etc)
            self:processPosition(entry)

            -- Allow type-specific post-processing
            self:postProcess(entry, id)

            -- Clear path and raw data after ALL processing is done (including processRawData)
            -- This ensures processRawData has access to the path for creating relationships
            -- Memory optimization: Clear path and raw data references as they're no longer needed
            if not entry.pendingData then
                if entry.path then
                    entry.path = nil
                end
                if entry.raw then
                    entry.raw = nil
                end
            end

            return entry
        end)

        if not success then
            -- Log the error with context
            local pathStr = path and table.concat(path, ".") or "unknown"

            -- Enhanced error reporting - handle different error types
            local errorDetails = "Unknown error"
            if type(result) == "string" then
                errorDetails = result
            elseif type(result) == "table" then
                -- Try to extract useful information from table errors
                if result.message then
                    errorDetails = result.message
                elseif result.error then
                    errorDetails = result.error
                elseif result.reason then
                    errorDetails = result.reason
                else
                    -- Show table structure for debugging
                    local keys = {}
                    for k, v in pairs(result) do
                        if type(v) == "string" and #v < 100 then
                            table.insert(keys, format("%s=%s", tostring(k), tostring(v)))
                        elseif type(v) == "number" or type(v) == "boolean" then
                            table.insert(keys, format("%s=%s", tostring(k), tostring(v)))
                        else
                            table.insert(keys, format("%s=[%s]", tostring(k), type(v)))
                        end
                    end
                    errorDetails = format("Table error with keys: %s", table.concat(keys, ", "))
                end
            else
                errorDetails = tostring(result)
            end

            local errorMsg = format("[%s] Processing failed for ID %d (path: %s) - %s",
                self.entityType, id, pathStr, errorDetails)
            module:Error(errorMsg)

            -- Return false to indicate processing failed
            return false
        end

        return result
    end,

    -- Updated processTypes to handle both path and raw data types
    processTypes = function(self, entry, rawData)
        -- Wrap type processing in pcall for safety
        local success, result = pcall(function()
            -- Get existing entry if any
            local storage = getEntityStorage(self.entityType)
            local existing = storage and storage[entry.id]

            -- Initialize or preserve existing types
            if existing and existing.types then
                entry.types = entry.types or existing.types
                -- Copy over direct type references
                for category, value in pairs(existing.types) do
                    entry[category] = value
                end
            else
                entry.types = entry.types or {}
            end

            -- Process path-based types
            if entry.path then
                if DataManager.debug then
                    DataManager:Debug(format(
                        "[%s] processTypes: Processing path-based types for entry %s (path: %s, path length: %d)",
                        tostring(self.entityType or "unknown"), tostring(entry and entry.id or "unknown"),
                        entry and entry.path and table.concat(entry.path, ".") or "unknown",
                        entry and entry.path and #entry.path or 0))
                end

                -- Find the entity type position (after namespace and data organization)
                local entityTypeIndex = nil
                for i = 4, #entry.path do -- Start after ns, data, flavor
                    local node = entry.path[i]
                    -- Look for common entity type markers
                    if node == "Items" or node == "Spells" or node == "Talents" or node == "Enchants" or
                        node == "Buffs" or node == "ClassSpells" or node == "TierSets" or node == "Consumable" then
                        entityTypeIndex = i
                        break
                    end
                end

                -- Start looking for types after the entity type (or after namespace if no entity type found)
                local startIndex = entityTypeIndex and (entityTypeIndex + 1) or 4
                startIndex = math.min(startIndex, #entry.path - 1) -- Ensure we don't go past the end

                for i = startIndex, #entry.path - 1 do
                    local node = entry.path[i]
                    -- Skip ignored path components
                    if not IGNORED_PATH_COMPONENTS[node] then
                        -- If this node is a type category
                        if Types:GetType(node) then
                            -- Next node is the value
                            local value = entry.path[i + 1]
                            if DataManager.debug then
                                DataManager:Debug(format(
                                    "[%s] processTypes: Found type category '%s' with value '%s' at path position %d/%d",
                                    tostring(self.entityType or "unknown"), tostring(node or "unknown"),
                                    tostring(value or "nil"),
                                    tostring(i or 0), tostring(entry.path and (#entry.path - 1) or 0)))
                            end
                            self:addTypeToEntry(entry, node, value)
                        else
                            if DataManager.debug then
                                DataManager:Trace(format(
                                    "[%s] processTypes: Path node '%s' is not a type category (position %d)",
                                    tostring(self.entityType or "unknown"), tostring(node or "unknown"), tostring(i or 0)))
                            end
                        end
                    else
                        if DataManager.debug then
                            DataManager:Trace(format(
                                "[%s] processTypes: Skipping ignored path component '%s' (position %d)",
                                tostring(self.entityType or "unknown"), tostring(node or "unknown"), tostring(i or 0)))
                        end
                    end
                end
            end

            -- Process explicit types from raw data
            if rawData and rawData.types then
                if DataManager.debug then
                    DataManager:Debug(format("[%s] processTypes: Found explicit types in rawData",
                        tostring(self.entityType or "unknown")))
                end
                for category, value in pairs(rawData.types) do
                    if type(value) == "table" then
                        -- Handle array of values
                        for _, v in ipairs(value) do
                            self:addTypeToEntry(entry, category, v)
                        end
                    else
                        self:addTypeToEntry(entry, category, value)
                    end
                end
            end

            -- Process reverse type mappings (where spells are listed under types)
            if rawData then
                for category, typeTable in pairs(rawData) do
                    -- Skip ignored categories
                    if not IGNORED_PATH_COMPONENTS[category] then
                        local typeRegistry = Types:GetType(category)
                        if typeRegistry and typeRegistry._allowMultiple then
                            for typeName, spellIds in pairs(typeTable) do
                                if type(spellIds) == "table" then
                                    -- If this spell is in the array, add the type
                                    for _, spellId in ipairs(spellIds) do
                                        if spellId == entry.id then
                                            self:addTypeToEntry(entry, category, typeName)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)

        if not success then
            -- Log the error with context
            local entryId = entry and entry.id or "unknown"
            local errorMsg = format("[%s] Type processing failed for entry %s - %s",
                tostring(self.entityType or "unknown"), tostring(entryId or "unknown"), tostring(result or "nil"))
            DataManager:Warn(errorMsg)

            -- Mark as failed but continue processing
            entry._typeProcessingFailed = true
            return false
        end

        return result
    end,

    -- Internal CRUD Operations
    create = function(self, id, entry)
        local storage = getEntityStorage(self.entityType)
        if not storage then
            module:Warn("[CRUD:create] Storage not initialized! entityType=%s, id=%s\n%s", tostring(self.entityType),
                tostring(id), debugstack())
            return false
        end

        -- If entry exists, merge new data and return existing
        if storage[id] then
            local existing = storage[id]

            -- Process flags from the new path before discarding it
            if entry.path then
                self:processFlags(existing, entry.path)
                -- Don't clear path here - it will be cleared after postProcess
            end

            -- Merge flags
            for flag, value in pairs(entry.flags or {}) do
                existing.flags[flag] = value
                -- Update flag index
                self:updateFlagIndex(existing, flag, value)
            end

            -- Merge types
            if entry.types then
                existing.types = existing.types or {}
                for category, value in pairs(entry.types) do
                    local typeRegistry = Types:GetType(category)
                    if typeRegistry then
                        if typeRegistry._allowMultiple then
                            -- For multi-value types, ensure array exists and merge values
                            existing.types[category] = existing.types[category] or {}
                            if type(value) == "table" then
                                for _, v in ipairs(value) do
                                    if not tContains(existing.types[category], v) then
                                        table.insert(existing.types[category], v)
                                    end
                                end
                            elseif not tContains(existing.types[category], value) then
                                table.insert(existing.types[category], value)
                            end
                        else
                            -- For single-value types, just overwrite
                            existing.types[category] = value
                        end
                        -- Update direct reference
                        existing[category] = existing.types[category]
                    end
                end
            end

            -- Update name index if name changed
            if entry.name and entry.name ~= existing.name then
                -- Remove from old name index if needed
                if existing.name and DataManager.storage.byName[existing.name] then
                    for i = #DataManager.storage.byName[existing.name], 1, -1 do
                        if DataManager.storage.byName[existing.name][i] == existing then
                            table.remove(DataManager.storage.byName[existing.name], i)
                            break
                        end
                    end
                end
                -- Add to new name index
                DataManager.storage.byName[entry.name] = DataManager.storage.byName[entry.name] or {}
                table.insert(DataManager.storage.byName[entry.name], existing)
                existing.name = entry.name
            end

            -- Use unified merge helper for all other fields
            -- Skip fields that are handled separately above
            self:mergeEntry(existing, entry, {
                skipFields = {"flags", "types", "name", "path", "raw", entry.entryType .. "Id"}
            })

            return existing
        end

        -- Process flags from path before storing
        if entry.path then
            self:processFlags(entry, entry.path)
            -- Don't clear path here - it will be cleared after postProcess
        end

        -- Store new entry in storage
        storage[id] = entry

        -- Add to name index if we have a name
        if entry.name then
            DataManager.storage.byName[entry.name] = DataManager.storage.byName[entry.name] or {}
            table.insert(DataManager.storage.byName[entry.name], entry)
        end

        -- Update flag indices
        for flag in pairs(entry.flags) do
            self:updateFlagIndex(entry, flag, true)
        end

        return entry
    end,

    read = function(self, id)
        local storage = getEntityStorage(self.entityType)
        if not storage then
            module:Warn("[CRUD:read] Storage not initialized! entityType=%s, id=%s\n%s", tostring(self.entityType),
                tostring(id), debugstack())
            return nil
        end
        return storage and storage[id]
    end,

    update = function(self, id, data)
        if not data then
            module:Error(format("No data provided for update: %s:%d", self.entityType, id))
            return false
        end

        local entry = self:read(id)
        if not entry then
            module:Error(format("Entity not found: %s:%d", self.entityType, id))
            return false
        end

        -- Process raw data if present
        if data.raw then
            self:processRawData(entry, data.raw)
        end

        -- Handle path updates
        if data.path then
            entry.path = data.path
            -- Update flags based on new path
            self:processFlags(entry, data.path)
        end

        -- Merge flags if provided
        if data.flags then
            for flag, value in pairs(data.flags) do
                entry.flags[flag] = value
                -- Update flag index
                self:updateFlagIndex(entry, flag, value)
            end
        end

        -- Merge types if provided
        if data.types then
            entry.types = entry.types or {}
            for category, value in pairs(data.types) do
                local typeRegistry = Types:GetType(category)
                if typeRegistry then
                    if typeRegistry._allowMultiple then
                        -- For multi-value types, ensure array exists and merge values
                        entry.types[category] = entry.types[category] or {}
                        if type(value) == "table" then
                            for _, v in ipairs(value) do
                                if not tContains(entry.types[category], v) then
                                    table.insert(entry.types[category], v)
                                end
                            end
                        elseif not tContains(entry.types[category], value) then
                            table.insert(entry.types[category], value)
                        end
                    else
                        -- For single-value types, just overwrite
                        entry.types[category] = value
                    end
                    -- Update direct reference
                    entry[category] = entry.types[category]
                end
            end
        end

        -- Update name index if name changed
        if data.name and data.name ~= entry.name then
            -- Remove from old name index if needed
            if entry.name and DataManager.storage.byName[entry.name] then
                for i = #DataManager.storage.byName[entry.name], 1, -1 do
                    if DataManager.storage.byName[entry.name][i] == entry then
                        table.remove(DataManager.storage.byName[entry.name], i)
                        break
                    end
                end
            end
            -- Add to new name index
            DataManager.storage.byName[data.name] = DataManager.storage.byName[data.name] or {}
            table.insert(DataManager.storage.byName[data.name], entry)
            entry.name = data.name
        end

        -- Use unified merge helper for all other fields
        -- Skip fields that are handled separately above
        self:mergeEntry(entry, data, {
            skipFields = {"raw", "path", "flags", "types", "name"}
        })

        return entry
    end,

    -- Flag Management
    updateFlags = function(self, entry, newFlags, changes)
        -- Track old flags for index cleanup
        local oldFlags = type(entry.flags) == "table" and entry.flags or {}

        -- Create new flags table preserving ALL existing flags
        local newFlagsTable = {}
        for flag, value in pairs(oldFlags) do
            newFlagsTable[flag] = value
        end

        -- Process boolean flags from raw data if present
        if entry.raw then
            for key, value in pairs(entry.raw) do
                if type(value) == "boolean" and value == true then
                    local flagName = key:lower()
                    newFlagsTable[flagName] = true
                end
            end
        end

        -- If newFlags is a table, process each flag
        if type(newFlags) == "table" then
            for flag, value in pairs(newFlags) do
                if oldFlags[flag] ~= value then
                    changes.flags = changes.flags or {}
                    changes.flags[flag] = { old = oldFlags[flag], new = value }
                    newFlagsTable[flag] = value

                    -- Update flag index
                    self:updateFlagIndex(entry, flag, value)
                end
            end
        end

        -- Update the flags table
        entry.flags = newFlagsTable

        -- Handle flags that were removed entirely
        for oldFlag in pairs(oldFlags) do
            -- Don't remove base type flag
            if oldFlag ~= self.entityType and newFlags[oldFlag] == nil then
                self:updateFlagIndex(entry, oldFlag, false)
            end
        end
    end,

    updateFlagIndex = function(self, entry, flag, value)
        -- Since we're not removing flags in practice, just handle additions
        if value then
            -- Initialize flag array if needed
            DataManager.storage.byFlag[flag] = DataManager.storage.byFlag[flag] or {}
            -- Add entry to flag index
            table.insert(DataManager.storage.byFlag[flag], entry)
        end
    end,

    -- Validation method - override in type-specific processors for stricter validation
    validateType = function(self, entry, rawData)
        if not entry then
            return false, "No entry provided"
        end

        if not entry[self.entityType .. "Id"] then
            return false, format("Missing %sId", self.entityType)
        end

        -- Basic validation that can be extended by specific processors
        if rawData then
            -- Validate raw data exists if provided
            if type(rawData) ~= "table" then
                return false, "Raw data must be a table"
            end
        end

        return true
    end,

    -- Flag processing with specialized handlers
    processFlags = function(self, entry, path)
        -- Wrap flag processing in pcall for safety
        local success, result = pcall(function()
            if not path then return end

            -- Find the entity type position (after namespace and data organization)
            local entityTypeIndex = nil
            for i = 4, #path do -- Start after ns, data, flavor
                local node = path[i]
                -- Look for common entity type markers
                if node == "Items" or node == "Spells" or node == "Talents" or node == "Enchants" or
                    node == "Buffs" or node == "ClassSpells" or node == "TierSets" or node == "Consumable" then
                    entityTypeIndex = i
                    break
                end
            end

            -- Start looking for flags after the entity type (or after namespace if no entity type found)
            local startIndex = entityTypeIndex and (entityTypeIndex + 1) or 4
            startIndex = math.min(startIndex, #path) -- Ensure we don't go past the end

            for i = startIndex, #path do
                local pathPart = path[i]
                -- Only create flags for non-ignored components
                if not IGNORED_PATH_COMPONENTS[pathPart] then
                    local flagName = pathPart:lower()
                    -- Don't overwrite existing flags
                    if not entry.flags[flagName] then
                        entry.flags[flagName] = true
                    end
                end
            end

            -- Process specialized flags based on entry type and flags
            self:processSpecializedFlags(entry)
        end)

        if not success then
            -- Log the error with context
            local entryId = entry and entry.id or "unknown"
            local pathStr = path and table.concat(path, ".") or "unknown"
            local errorMsg = format("[%s] Flag processing failed for entry %s (path: %s) - %s",
                self.entityType, tostring(entryId), pathStr, tostring(result))
            DataManager:Warn(errorMsg)

            -- Mark as failed but continue processing
            entry._flagProcessingFailed = true
            return false
        end

        return result
    end,

    -- Process relationships from raw data
    processRelationships = function(self, entry)
        -- Wrap relationship processing in pcall for safety
        local success, result = pcall(function()
            -- Skip if we've already processed relationships for this entry
            if entry._processedRelationships then return end
            entry._processedRelationships = true

            -- Look through all fields in the entry for ID fields
            for key, value in pairs(entry) do
                -- Check if this is an ID field (ends with 'Id')
                local baseType = key:match("^(%l+)Id$")
                if baseType and value and key ~= entry.entryType .. "Id" then
                    -- Get mapped type or use base type
                    local targetType = ID_TYPE_MAPPINGS[key] or baseType

                    -- If we have a processor for this type, create the relationship
                    if ProcessorsV2[targetType] then
                        -- Create target path
                        local targetPath = transformPath(entry.path, entry.entryType, targetType)

                        -- Process target entity first
                        local targetProcessor = ProcessorsV2[targetType]
                        local targetEntry = targetProcessor:process(value, targetPath)

                        -- Create relationship if target exists and it hasn't been created yet
                        if targetEntry then
                            local relationType = getRelationshipType(entry.entryType, targetType)
                            if not (DataManager.storage.relationships[relationType] and
                                    DataManager.storage.relationships[relationType][entry[entry.entryType .. "Id"]] and
                                    DataManager.storage.relationships[relationType][entry[entry.entryType .. "Id"]][value]) then
                                self:addRelationshipComplex(
                                    entry[entry.entryType .. "Id"],
                                    self.entityType,
                                    value,
                                    targetType
                                )
                            end
                        end
                    end
                end
            end
        end)

        if not success then
            -- Log the error with context
            local entryId = entry and entry[entry.entryType .. "Id"] or "unknown"
            local errorMsg = format("[%s] Relationship processing failed for entry %s - %s",
                self.entityType, tostring(entryId), tostring(result))
            DataManager:Warn(errorMsg)

            -- Mark as failed but continue processing
            entry._relationshipProcessingFailed = true
            return false
        end

        return result
    end,

    processRawData = function(self, entry, rawData)
        -- Wrap raw data processing in pcall for safety
        local success, result = pcall(function()
            if not rawData then return nil end

            -- Track processed IDs to prevent loops
            local processedIds = rawData._processedIds or {}
            processedIds[entry[entry.entryType .. "Id"]] = true

            -- Process all fields in raw data
            for key, value in pairs(rawData) do
                -- Skip internal tracking fields and types (already processed)
                if key:sub(1, 1) ~= "_" and key ~= "types" then
                    -- Check if this is an ID field (ends with 'Id')
                    local baseType = key:match("^(%l+)Id$")
                    if baseType then
                        -- Skip if this is our own ID field or if we've already processed this ID
                        if key ~= entry.entryType .. "Id" and not processedIds[value] then
                            -- Get mapped type or use base type
                            local targetType = ID_TYPE_MAPPINGS[key] or baseType

                            -- Add flag for non-base entity types (e.g., 'buff' from 'buffId')
                            entry.flags[baseType] = true
                            entry[key] = value
                            -- Get processor for this type
                            local processor = ProcessorsV2[targetType]
                            if processor then
                                -- Transform path for target type
                                local targetPath = transformPath(entry.path, entry.entryType, targetType)

                                -- Mark this ID as processed
                                processedIds[value] = true

                                -- Create minimal raw data for the target
                                local targetRawData = {
                                    _processedIds = processedIds, -- Pass the processed IDs tracker
                                    [targetType .. "Id"] = value  -- Set the ID field
                                }

                                -- Create the target entry
                                local targetEntry = processor:process(value, targetPath, targetRawData)
                                if targetEntry then
                                    -- Create relationship directly
                                    self:addRelationshipComplex(
                                        entry[entry.entryType .. "Id"],
                                        self.entityType,
                                        value,
                                        targetType
                                    )
                                end
                            end
                        end
                    elseif not EXCLUDED_ENTRY_FIELDS[key] then
                        -- Handle boolean flags and true value flags
                        if type(value) == "boolean" then
                            -- Add as a flag directly
                            local flagName = key:lower()
                            entry.flags[flagName] = value
                            -- Debug: Log flag creation for unwanted flags
                            if flagName == "requirements" then
                                if DataManager.debug then
                                    DataManager:Debug(format("[%s] Created flag '%s' from boolean field '%s' (value: %s)",
                                        self.entityType, flagName, key, tostring(value)))
                                end
                            end
                        elseif value == true then
                            -- Handle cases where value is explicitly true
                            local flagName = key:lower()
                            entry.flags[flagName] = true
                            -- Debug: Log flag creation for unwanted flags
                            if flagName == "requirements" then
                                if DataManager.debug then
                                    DataManager:Debug(format("[%s] Created flag '%s' from true field '%s'",
                                        self.entityType, flagName, key))
                                end
                            end
                        else
                            -- Copy other non-excluded fields directly to entry
                            entry[key] = value
                        end
                    end
                end
            end

            return true
        end)

        if not success then
            -- Log the error with context
            local entryId = entry and entry[entry.entryType .. "Id"] or "unknown"
            local errorMsg = format("[%s] Raw data processing failed for entry %s - %s",
                self.entityType, tostring(entryId), tostring(result))
            DataManager:Warn(errorMsg)

            -- Mark as failed but continue processing
            entry._rawDataProcessingFailed = true
            return false
        end

        return result
    end,

    --- Unified entry merge helper with smart merge strategy
    --- Merges new entry data into existing entry, handling all field types properly
    --- @param existing table The existing entry to merge into
    --- @param new table The new entry data to merge
    --- @param options table|nil Optional merge options (skipFields: array of field names to skip)
    --- @return table The merged existing entry
    mergeEntry = function(self, existing, new, options)
        if not existing or not new or type(existing) ~= "table" or type(new) ~= "table" then
            return existing
        end

        options = options or {}
        local skipFields = {}
        if options.skipFields then
            for _, field in ipairs(options.skipFields) do
                skipFields[field] = true
            end
        end

        -- System-managed fields that should always be skipped
        local systemFields = {
            ["flags"] = true,
            ["types"] = true,
            ["path"] = true,
            ["raw"] = true,
            ["id"] = true,
            ["entryType"] = true,
            ["relationships"] = true,
        }

        -- Helper to check if a table is an array (sequential numeric keys starting at 1)
        local function isArray(t)
            if type(t) ~= "table" or #t == 0 then
                return false
            end
            -- Check if all keys from 1 to #t exist
            for i = 1, #t do
                if t[i] == nil then
                    return false
                end
            end
            -- Check if there are any non-numeric keys
            for k in pairs(t) do
                if type(k) ~= "number" or k < 1 or k > #t or (k % 1) ~= 0 then
                    return false
                end
            end
            return true
        end

        -- Merge each field from new entry
        for key, newValue in pairs(new) do
            -- Skip if in skipFields
            if skipFields[key] then
                if DataManager.debug then
                    DataManager:Trace(format("[%s] mergeEntry: Skipping field '%s' (in skipFields)",
                        self.entityType, key))
                end
            -- Skip if system-managed field
            elseif systemFields[key] then
                if DataManager.debug then
                    DataManager:Trace(format("[%s] mergeEntry: Skipping field '%s' (system-managed)",
                        self.entityType, key))
                end
            -- Skip if in EXCLUDED_ENTRY_FIELDS
            elseif EXCLUDED_ENTRY_FIELDS[key] then
                if DataManager.debug then
                    DataManager:Trace(format("[%s] mergeEntry: Skipping field '%s' (excluded)",
                        self.entityType, key))
                end
            -- Skip if it's the entry type ID field (e.g., spellId, itemId)
            elseif key == existing.entryType .. "Id" then
                if DataManager.debug then
                    DataManager:Trace(format("[%s] mergeEntry: Skipping field '%s' (entry type ID)",
                        self.entityType, key))
                end
            else
                local existingValue = existing[key]

                -- Handle nil new value: preserve existing
                if newValue == nil then
                    if DataManager.debug then
                        DataManager:Trace(format("[%s] mergeEntry: Preserving existing value for '%s' (new is nil)",
                            self.entityType, key))
                    end
                    -- Keep existing value, do nothing
                -- Handle both are tables: smart merge
                elseif type(newValue) == "table" and type(existingValue) == "table" then
                    local newIsArray = isArray(newValue)
                    local existingIsArray = isArray(existingValue)

                    if newIsArray and existingIsArray then
                        -- Both are arrays: merge by appending new values (avoid duplicates)
                        if DataManager.debug then
                            DataManager:Trace(format("[%s] mergeEntry: Merging arrays for '%s'",
                                self.entityType, key))
                        end
                        for _, newItem in ipairs(newValue) do
                            if not tContains(existingValue, newItem) then
                                table.insert(existingValue, newItem)
                            end
                        end
                    elseif not newIsArray and not existingIsArray then
                        -- Both are key-value tables: use SmartMerge
                        if DataManager.debug then
                            DataManager:Trace(format("[%s] mergeEntry: Smart merging tables for '%s'",
                                self.entityType, key))
                        end
                        TableUtils.SmartMerge(existingValue, newValue, {
                            mergeStrategy = "smart",
                            conflictResolution = "merge"
                        })
                    else
                        -- Mixed types: overwrite with new (array vs table conflict)
                        if DataManager.debug then
                            DataManager:Trace(format("[%s] mergeEntry: Overwriting '%s' (array/table conflict)",
                                self.entityType, key))
                        end
                        existing[key] = TableUtils.FastDeepClone(newValue)
                    end
                -- Handle existing is nil: set new value
                elseif existingValue == nil then
                    if DataManager.debug then
                        DataManager:Trace(format("[%s] mergeEntry: Setting new field '%s'",
                            self.entityType, key))
                    end
                    if type(newValue) == "table" then
                        existing[key] = TableUtils.FastDeepClone(newValue)
                    else
                        existing[key] = newValue
                    end
                -- Handle both exist (primitives): overwrite with new
                else
                    if DataManager.debug then
                        DataManager:Trace(format("[%s] mergeEntry: Overwriting '%s' (existing: %s, new: %s)",
                            self.entityType, key, tostring(existingValue), tostring(newValue)))
                    end
                    if type(newValue) == "table" then
                        existing[key] = TableUtils.FastDeepClone(newValue)
                    else
                        existing[key] = newValue
                    end
                end
            end
        end

        return existing
    end,

    -- Add type validation helper
    validateTypeValue = function(self, category, value)
        return Types:IsValidType(category, value)
    end,

    -- Specialized flag processing - override in type-specific processors
    processSpecializedFlags = function(self, entry)
        -- Default implementation does nothing
        -- Override in type-specific processors
    end,

    processPosition = function(self, entry)
        -- Wrap position processing in pcall for safety
        local success, result = pcall(function()
            -- Apply default positions based on flags and entry type
            for position, criteria in pairs(DEFAULT_POSITIONS) do
                local shouldPosition = false

                -- Check flags
                if criteria.flags then
                    for _, flag in ipairs(criteria.flags) do
                        if entry.flags[flag] then
                            shouldPosition = true
                            break
                        end
                    end
                end

                -- Check types
                if not shouldPosition and criteria.types then
                    for _, entryType in ipairs(criteria.types) do
                        if entry.entryType == entryType then
                            shouldPosition = true
                            break
                        end
                    end
                end

                if shouldPosition then
                    DataManager:SetSpellPosition(entry.spellId or entry.itemId, position)
                    break -- Stop once we've found a position
                end
            end
        end)

        if not success then
            -- Log the error with context
            local entryId = entry and entry.id or "unknown"
            local errorMsg = format("[%s] Position processing failed for entry %s - %s",
                self.entityType, tostring(entryId), tostring(result))
            DataManager:Warn(errorMsg)

            -- Mark as failed but continue processing
            entry._positionProcessingFailed = true
            return false
        end

        return result
    end,

    -- Required hooks - must be implemented by type processors
    processData = function(self, entry, id)
        error(self.entityType .. " processor must implement processData")
    end,

    postProcess = function(self, entry, id)
        -- Default implementation does nothing
    end,
    -- Helper function to ensure entity exists
    ensureEntityExists = function(self, entityType, id, path, rawData)
        local processor = ProcessorsV2[entityType]
        if not processor then return nil end

        local entity = processor:read(id)
        if not entity then
            -- Create basic entity if it doesn't exist
            entity = processor:process(id, path or { entityType }, rawData)
        end
        return entity
    end,
    -- Relationship Management (Complex Version - for debugging)
    addRelationshipComplex = function(self, sourceId, sourceType, targetId, targetType)
        -- Debug: Log relationship creation
        local relationType = getRelationshipType(sourceType, targetType)
        if DataManager.debug then
            DataManager:Debug(format("[%s] addRelationshipComplex: %s %d -> %s %d = %s",
                self.entityType, sourceType, sourceId, targetType, targetId, relationType))
        end

        -- Check if relationship already exists
        if DataManager.storage.relationships[relationType] and
            DataManager.storage.relationships[relationType][sourceId] and
            DataManager.storage.relationships[relationType][sourceId][targetId] then
            if DataManager.debug then
                DataManager:Debug(format("[%s] addRelationshipComplex: Relationship already exists, skipping",
                    tostring(self.entityType or "unknown")))
            end
            return true -- Already linked
        end

        -- Get target processor
        local targetProcessor = ProcessorsV2[targetType]
        if not targetProcessor then
            if DataManager.debug then
                DataManager:Warn(format("No processor found for target type %s",
                    tostring(targetType)))
            end
            return false
        end

        -- Ensure both entities exist
        local sourceEntity = self:ensureEntityExists(sourceType, sourceId)
        local targetEntity = self:ensureEntityExists(targetType, targetId)

        if not sourceEntity or not targetEntity then
            if DataManager.debug then
                DataManager:Debug(format("[%s] Failed to create relationship: source=%s, target=%s (%s->%s)",
                    self.entityType,
                    tostring(sourceId),
                    tostring(targetId),
                    tostring(self.entityType),
                    tostring(targetType)))
            end
            return false
        end

        -- Create forward relationship storage
        DataManager.storage.relationships[relationType] = DataManager.storage.relationships[relationType] or {}
        DataManager.storage.relationships[relationType][sourceId] = DataManager.storage.relationships[relationType]
            [sourceId] or {}

        -- Create reverse relationship type (e.g. if SPELL_TO_ITEM, create ITEM_TO_SPELL)
        local reverseRelationType = getRelationshipType(targetType, self.entityType)
        DataManager.storage.relationships[reverseRelationType] = DataManager.storage.relationships
            [reverseRelationType] or {}
        DataManager.storage.relationships[reverseRelationType][targetId] = DataManager.storage.relationships
            [reverseRelationType][targetId] or {}

        -- Check if relationships already exist
        if DataManager.storage.relationships[relationType][sourceId][targetId] or
            DataManager.storage.relationships[reverseRelationType][targetId][sourceId] then
            return true -- Already linked
        end

        -- Create forward relationship in storage
        DataManager.storage.relationships[relationType][sourceId][targetId] = targetEntity
        -- Create reverse relationship in storage
        DataManager.storage.relationships[reverseRelationType][targetId][sourceId] = sourceEntity

        -- Update source entity references
        sourceEntity.relationships = sourceEntity.relationships or {}
        sourceEntity.relationships[targetType] = sourceEntity.relationships[targetType] or {}
        sourceEntity.relationships[targetType][targetId] = sourceEntity.relationships[targetType][targetId] or {}
        sourceEntity.relationships[targetType][targetId][relationType] = true

        -- Update target entity references
        targetEntity.relationships = targetEntity.relationships or {}
        targetEntity.relationships[self.entityType] = targetEntity.relationships[self.entityType] or {}
        targetEntity.relationships[self.entityType][sourceId] = targetEntity.relationships[self.entityType]
            [sourceId] or {}
        targetEntity.relationships[self.entityType][sourceId][reverseRelationType] = true

        -- Notify processors
        self:onRelationshipAdded(sourceEntity, targetType, targetId, relationType)
        targetProcessor:onRelationshipAdded(targetEntity, sourceType, sourceId, reverseRelationType)

        return true
    end,

    -- Relationship Management (Simple Version - calls self:addRelationshipComplex)

    -- Relationship notification hook
    onRelationshipAdded = function(self, entity, targetType, targetId, relationType)
        -- Default implementation does nothing
        -- Override in type-specific processors if needed
    end,

    addTypeToEntry = function(self, entry, category, value)
        -- Wrap type addition in pcall for safety
        local success, result = pcall(function()
            -- Validate entry object
            if not entry or type(entry) ~= "table" then
                error(format("Invalid entry object: expected table, got %s", type(entry)))
            end

            if DataManager.debug then
                DataManager:Debug(format(
                    "[%s] addTypeToEntry: Processing entry ID %s, category '%s', value '%s' (entry type: %s)",
                    tostring(self.entityType or "unknown"), tostring(entry and entry.id or "unknown"),
                    tostring(category or "unknown"), tostring(value or "nil"), type(entry or "nil")))
            end

            -- Initialize types table if it doesn't exist
            entry.types = entry.types or {}

            if DataManager.debug then
                DataManager:Debug("[%s] Adding type '%s' = '%s' to entry %s", self.entityType, category,
                    tostring(value), entry.id or "unknown")
            end

            -- Get the type registry for validation
            if DataManager.debug then
                DataManager:Debug(format("[%s] addTypeToEntry: Looking up type registry for category: '%s' (entry ID: %s)",
                    tostring(self.entityType or "unknown"), tostring(category or "unknown"),
                    tostring(entry and entry.id or "unknown")))
            end

            local typeRegistry = Types:GetType(category)
            if not typeRegistry then
                if DataManager.debug then
                    DataManager:Debug(format(
                        "[%s] addTypeToEntry: No type registry found for category: %s (entry ID: %s, path: %s, value: %s)",
                        self.entityType, category, tostring(entry.id or "unknown"),
                        entry.path and table.concat(entry.path, ".") or "unknown", tostring(value)))
                end
                return
            end

            if DataManager.debug then
                DataManager:Debug(format(
                    "[%s] addTypeToEntry: Found type registry for category '%s' (type: %s, allowMultiple: %s)",
                    tostring(self.entityType or "unknown"), tostring(category or "unknown"), type(typeRegistry or "nil"),
                    tostring(typeRegistry and typeRegistry._allowMultiple or false)))
            end

            -- Handle string values by looking up in registry
            if type(value) == "string" then
                local upperValue = value:upper()
                if DataManager.debug then
                    DataManager:Debug(format("[%s] addTypeToEntry: Processing string value '%s' -> '%s'",
                        tostring(self.entityType or "unknown"), tostring(value or "nil"), tostring(upperValue or "nil")))
                end

                value = typeRegistry._values[upperValue]
                if DataManager.debug then
                    DataManager:Debug(format("[%s] addTypeToEntry: Resolved string value '%s' to %s (type: %s)",
                        tostring(self.entityType or "unknown"), tostring(upperValue or "nil"), tostring(value or "nil"),
                        type(value or "nil")))
                end
            end

            -- Skip if we couldn't resolve the value
            if not value then
                -- Check if this is a known type category and provide available values
                local availableValues = {}
                if typeRegistry and typeRegistry._values then
                    local count = 0
                    for k, v in pairs(typeRegistry._values) do
                        if count < 5 then -- Limit to first 5 values to avoid spam
                            table.insert(availableValues, format("%s=%s", k, tostring(v)))
                        end
                        count = count + 1
                    end
                    if count > 5 then
                        table.insert(availableValues, format("... and %d more", count - 5))
                    end
                end

                return
            end

            -- Initialize type index structures
            if DataManager.debug then
                DataManager:Debug(format("[%s] addTypeToEntry: Initializing type index for category '%s', value '%s'",
                    tostring(self.entityType or "unknown"), tostring(category or "unknown"), tostring(value or "nil")))
            end

            DataManager.storage.byType[category] = DataManager.storage.byType[category] or {}
            DataManager.storage.byType[category][value] = DataManager.storage.byType[category][value] or {}

            if typeRegistry._allowMultiple then
                entry.types[category] = entry.types[category] or {}
                -- Add if not already present
                if not tContains(entry.types[category], value) then
                    table.insert(entry.types[category], value)
                    -- Add to type index
                    DataManager.storage.byType[category][value][entry.id] = entry
                end
            else
                -- Single value categories just get overwritten
                -- Remove from old type index if value changed
                if entry.types[category] and entry.types[category] ~= value then
                    DataManager.storage.byType[category][entry.types[category]][entry.id] = nil
                end
                entry.types[category] = value
                -- Add to type index
                DataManager.storage.byType[category][value][entry.id] = entry
            end

            -- Add direct reference for easier comparison
            if typeRegistry._allowMultiple then
                entry[category] = entry.types[category]
            else
                entry[category] = value
            end
        end)

        if not success then
            -- Log the error with context
            local entryId = entry and entry.id or "unknown"

            -- Enhanced error reporting - handle different error types
            local errorDetails = "Unknown error"
            if type(result) == "string" then
                errorDetails = result
            elseif type(result) == "table" then
                -- Try to extract useful information from table errors
                if result.message then
                    errorDetails = result.message
                elseif result.error then
                    errorDetails = result.error
                elseif result.reason then
                    errorDetails = result.reason
                else
                    -- Show table structure for debugging
                    local keys = {}
                    for k, v in pairs(result) do
                        if type(v) == "string" and #v < 100 then
                            table.insert(keys, format("%s=%s", tostring(k), tostring(v)))
                        elseif type(v) == "number" or type(v) == "boolean" then
                            table.insert(keys, format("%s=%s", tostring(k), tostring(v)))
                        else
                            table.insert(keys, format("%s=[%s]", tostring(k), type(v)))
                        end
                    end
                    errorDetails = format("Table error with keys: %s", table.concat(keys, ", "))
                end
            else
                errorDetails = tostring(result)
            end

            local errorMsg = format("[%s] Type addition failed for entry %s (category: %s, value: %s) - %s",
                self.entityType, tostring(entryId), tostring(category), tostring(value), errorDetails)
            DataManager:Warn(errorMsg)

            -- Mark as failed but continue processing
            if entry then
                entry._typeAdditionFailed = entry._typeAdditionFailed or {}
                entry._typeAdditionFailed[category] = errorDetails
            end
            return false
        end

        return result
    end,
    -- Add behavior attachment method to ProcessorV2
    attachBehaviors = function(self, entry)
        -- Wrap behavior attachment in pcall for safety
        local success, result = pcall(function()
            -- Validate entry object
            if not entry or type(entry) ~= "table" then
                error(format("Invalid entry object: expected table, got %s", type(entry)))
            end

            -- Map entity types to behavior sets (in order from least to most specific)
            local behaviorSets = {
                [DataManager.EntityTypes.SPELL] = { "Base", "Spell" },
                [DataManager.EntityTypes.ITEM] = { "Base", "Item" },
                [DataManager.EntityTypes.AURA] = { "Base", "Spell", "Aura" },
                [DataManager.EntityTypes.DOT] = { "Base", "Spell", "Dot" },
                [DataManager.EntityTypes.NPC] = { "Base", "Unit" },
                [DataManager.EntityTypes.TIERSET] = { "Base", "Set" },
                [DataManager.EntityTypes.ENCHANT] = { "Base", "Spell", "Enchant" },
                [DataManager.EntityTypes.TALENT] = { "Base", "Talent" },
            }
            -- Map flags to behavior sets (in order from least to most specific)
            local flagBehaviorSets = {
                ["pet"] = { "Base", "Unit", "Spell", "Pet" },
                ["totem"] = { "Base", "Spell", "Totem" },
                ["dot"] = { "Base", "Spell", "Dot" },
                ["glyph"] = { "Base", "Spell", "Glyph" },
                ["battlepet"] = { "Base", "Spell", "BattlePet" },
            }

            -- Determine which behavior set to use (only one set is applied)
            local behaviorSet

            -- Check for special cases first (highest precedence)
            if entry.entryType == DataManager.EntityTypes.ITEM and entry.flags.trinket then
                -- Trinkets are items with trinket behavior
                behaviorSet = { "Base", "Item", "Trinket" }
            elseif entry.entryType == DataManager.EntityTypes.SPELL and entry.flags.glyph then
                behaviorSet = flagBehaviorSets["glyph"]
            else
                -- Check flag-based behaviors next (medium precedence)
                for flag, flagSet in pairs(flagBehaviorSets) do
                    if entry.flags[flag] then
                        behaviorSet = flagSet
                        break
                    end
                end

                -- If no flag behaviors found, use entity type behaviors (lowest precedence)
                if not behaviorSet then
                    behaviorSet = behaviorSets[entry.entryType]
                end
            end

            -- Apply behaviors using selected approach
            if behaviorSet then
                if DataManager.debug then
                    DataManager:Debug(format("[%s] attachBehaviors: Applying behavior set: %s",
                        tostring(self.entityType or "unknown"), table.concat(behaviorSet or {}, ", ")))
                end

                if USE_DIRECT_BEHAVIOR_COPYING then
                    -- OLD APPROACH: Direct method copying (faster, more memory)
                    for i = 1, #behaviorSet, 1 do
                        local behaviorType = behaviorSet[i]

                        if ns.EntityBehaviors[behaviorType] then
                            local behaviorCount = 0
                            for name, func in pairs(ns.EntityBehaviors[behaviorType]) do
                                entry[name] = func
                                behaviorCount = behaviorCount + 1
                            end

                            if DataManager.debug then
                                DataManager:Trace(format("[%s] attachBehaviors: Attached %d behaviors from %s",
                                    tostring(self.entityType or "unknown"), behaviorCount, behaviorType))
                            end
                        else
                            if DataManager.debug then
                                DataManager:Warn(format("[%s] attachBehaviors: Behavior type '%s' not found in ns.EntityBehaviors",
                                    tostring(self.entityType or "unknown"), behaviorType))
                            end
                        end
                    end
                else
                    -- NEW APPROACH: Metatable with __index (slower, less memory, more features)
                    local metatable = {
                        __index = function(t, key)
                            -- Check for custom override first
                            if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride(self.entityType, entry.id, key) then
                                return function(ent, ...)
                                    return ns.EntityBehaviors.ExecuteBehavior(self.entityType, entry.id, key, ent, ...)
                                end
                            end

                            -- Search through behavior types in reverse order (most specific first)
                            for i = 1, #behaviorSet, 1 do
                                local behaviorType = behaviorSet[i]
                                if ns.EntityBehaviors[behaviorType] and ns.EntityBehaviors[behaviorType][key] then
                                    return ns.EntityBehaviors[behaviorType][key]
                                end
                            end

                            -- Fall back to base behavior
                            if ns.EntityBehaviors.Base and ns.EntityBehaviors.Base[key] then
                                return ns.EntityBehaviors.Base[key]
                            end

                            return nil
                        end
                    }

                    -- Apply the metatable to the entry
                    setmetatable(entry, metatable)

                    if DataManager.debug then
                        DataManager:Trace(format("[%s] attachBehaviors: Applied metatable with behavior set: %s",
                            tostring(self.entityType or "unknown"), table.concat(behaviorSet or {}, ", ")))
                    end
                end
            else
                if DataManager.debug then DataManager:Debug("[%s] WARNING: No behavior set selected", self.entityType) end
            end
        end)

        if not success then
            -- Log the error with context
            local entryId = entry and entry.id or "unknown"

            -- Enhanced error reporting - handle different error types
            local errorDetails = "Unknown error"
            if type(result) == "string" then
                errorDetails = result
            elseif type(result) == "table" then
                -- Try to extract useful information from table errors
                if result.message then
                    errorDetails = result.message
                elseif result.error then
                    errorDetails = result.error
                elseif result.reason then
                    errorDetails = result.reason
                else
                    -- Show table structure for debugging
                    local keys = {}
                    for k, v in pairs(result) do
                        if type(v) == "string" and #v < 100 then
                            table.insert(keys, format("%s=%s", tostring(k), tostring(v)))
                        elseif type(v) == "number" or type(v) == "boolean" then
                            table.insert(keys, format("%s=%s", tostring(k), tostring(v)))
                        else
                            table.insert(keys, format("%s=[%s]", tostring(k), type(v)))
                        end
                    end
                    errorDetails = format("Table error with keys: %s", table.concat(keys, ", "))
                end
            else
                errorDetails = tostring(result)
            end

            local errorMsg = format("[%s] Behavior attachment failed for entry %s - %s",
                self.entityType, tostring(entryId), errorDetails)
            DataManager:Warn(errorMsg)

            -- Mark as failed but continue processing
            entry._behaviorAttachmentFailed = true
            return false
        end

        return result
    end,
}

--- @class ItemProcessorV2: ProcessorV2
ItemProcessorV2 = setmetatable({
    entityType = DataManager.EntityTypes.ITEM,

    isDataReady = function(self, id)
        return C_Item.IsItemDataCachedByID(id)
    end,

    queueDataLoad = function(self, id, entry)
        C_Item.RequestLoadItemDataByID(id)
    end,

    --- Overridden to handle rich trinket data from the template.
    processRawData = function(self, entry, rawData)
        if not rawData then return true end

        -- First, call the base processor to handle generic fields
        ProcessorV2.processRawData(self, entry, rawData)

        -- If this is trinket data from our template, it will have useEffects/procEffects arrays.
        -- We use the presence of 'useEffects' or 'procEffects' as indicators.
        if rawData.useEffects or rawData.procEffects then
            -- This is a trinket entry from our Jinja template.
            -- Add the crucial 'trinket' flag so the system recognizes it.
            entry.flags.trinket = true

            -- Validate path before proceeding with spell creation
            if not entry.path then
                DataManager:Warn(format("[%s] Item %d has no path for spell creation - skipping spell processing",
                    self.entityType, entry.id))
                return true
            end

            -- Track processed spellIds to prevent duplicates
            local processedSpellIds = processedSpellIds or {}
            local processedRelationships = processedRelationships or {}

            -- Helper function to process spell with duplicate detection
            local function processSpellWithDedup(spellId, spellPath, effectData, context)
                if not spellId or spellId <= 0 then return false end

                -- Skip dummy trigger IDs that are not actual spells
                if spellId == 18350 then
                    if DataManager.debug then
                        DataManager:Debug(format(
                            "[%s] Item %d -> Skipping dummy trigger ID: %d (proc effect reference, not a real spell)",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(spellId or "nil")))
                    end
                    return true -- Treat as successful to avoid relationship creation errors
                end

                -- Check if spell has already been processed
                if processedSpellIds[spellId] then
                    if DataManager.debug then
                        DataManager:Debug(format("[%s] Item %d -> Skipping duplicate Spell %d (already processed)",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(spellId or "nil")))
                    end
                    return true -- Spell already exists, consider it successful
                end

                local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                if not spellProcessor then
                    DataManager:Warn(format("[%s] Item %d -> No spell processor available for Spell %d", self.entityType,
                        entry.id, spellId))
                    return false
                end

                local spellEntry = spellProcessor:process(spellId, spellPath, effectData)
                if spellEntry then
                    processedSpellIds[spellId] = true
                    if DataManager.debug then
                        DataManager:Debug(format("[%s] Item %d -> Created %s Spell %d",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(context or "unknown"), tostring(spellId or "nil")))
                    end
                    return true
                else
                    if DataManager.debug then
                        DataManager:Warn(format("[%s] Item %d -> Failed to create %s Spell %d",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(context or "unknown"), tostring(spellId or "nil")))
                    end
                    return false
                end
            end

            -- Helper function to create relationship with duplicate detection
            local function createRelationshipWithDedup(itemId, spellId, context)
                if not itemId or not spellId then return false end

                local relationshipKey = tostring(itemId) .. "_" .. tostring(spellId) .. "_" .. context
                if processedRelationships[relationshipKey] then
                    if DataManager.debug then
                        DataManager:Debug(format("[%s] Item %d -> Skipping duplicate relationship to Spell %d (%s)",
                            tostring(self.entityType or "unknown"), tostring(itemId or "nil"),
                            tostring(spellId or "nil"), tostring(context or "unknown")))
                    end
                    return true
                end

                -- Debug: Check what entity types we're working with
                local relationshipType = getRelationshipType(self.entityType, DataManager.EntityTypes.SPELL)
                if DataManager.debug then
                    DataManager:Debug(format("[%s] Creating relationship: Item %d (%s) -> Spell %d (%s) = %s",
                        self.entityType, itemId, self.entityType, spellId, DataManager.EntityTypes.SPELL,
                        relationshipType))
                end

                local success = self:addRelationshipComplex(itemId, self.entityType, spellId,
                    DataManager.EntityTypes.SPELL)

                processedRelationships[relationshipKey] = true
                return true
            end

            -- Process use effects (TriggerType 0 - on-use effects with cooldowns)
            if rawData.useEffects and type(rawData.useEffects) == "table" then
                for _, effect in ipairs(rawData.useEffects) do
                    if effect.spellId and effect.spellId > 0 then
                        local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)

                        if processSpellWithDedup(effect.spellId, spellPath, effect, "use") then
                            createRelationshipWithDedup(entry.id, effect.spellId, "use")
                        end
                    end

                    -- Process proc spell from use effect if present
                    if effect.procId and effect.procId > 0 then
                        local procPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                        table.insert(procPath, "proc") -- Add 'proc' to the path for clarity

                        if processSpellWithDedup(effect.procId, procPath, effect, "use proc") then
                            createRelationshipWithDedup(entry.id, effect.procId, "use proc")
                        end
                    end
                end
            end

            -- Process proc effects (TriggerType 1 - proc effects)
            if rawData.procEffects and type(rawData.procEffects) == "table" then
                for i, effect in ipairs(rawData.procEffects) do
                    if effect.spellId and effect.spellId > 0 then
                        local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                        table.insert(spellPath, "proc") -- Add 'proc' to the path for clarity

                        if processSpellWithDedup(effect.spellId, spellPath, effect, "proc") then
                            createRelationshipWithDedup(entry.id, effect.spellId, "proc")
                        end
                    end

                    -- Process proc spell from proc effect if present
                    if effect.procId and effect.procId > 0 then
                        local procPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                        table.insert(procPath, "proc") -- Add 'proc' to the path for clarity

                        if processSpellWithDedup(effect.procId, procPath, effect, "proc proc") then
                            createRelationshipWithDedup(entry.id, effect.procId, "proc proc")
                        end
                    end
                end
            end

            -- Handle legacy single-value format for backward compatibility
            if rawData.spellId and rawData.spellId > 0 then
                local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)

                if processSpellWithDedup(rawData.spellId, spellPath, rawData, "legacy single") then
                    createRelationshipWithDedup(entry.id, rawData.spellId, "legacy single")
                end
            end

            if rawData.procSpellId and rawData.procSpellId > 0 then
                local procPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                table.insert(procPath, "proc")

                if processSpellWithDedup(rawData.procSpellId, procPath, rawData, "legacy single proc") then
                    createRelationshipWithDedup(entry.id, rawData.procSpellId, "legacy single proc")
                end
            end

            -- Handle legacy array format for backward compatibility
            if rawData.spellIds and type(rawData.spellIds) == "table" then
                for _, spellId in ipairs(rawData.spellIds) do
                    if spellId and spellId > 0 then
                        local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)

                        if processSpellWithDedup(spellId, spellPath, rawData, "legacy array") then
                            createRelationshipWithDedup(entry.id, spellId, "legacy array")
                        end
                    end
                end
            end

            if rawData.procIds and type(rawData.procIds) == "table" then
                for _, procId in ipairs(rawData.procIds) do
                    if procId and procId > 0 then
                        local procPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                        table.insert(procPath, "proc")

                        if processSpellWithDedup(procId, procPath, rawData, "legacy array proc") then
                            createRelationshipWithDedup(entry.id, procId, "legacy array proc")
                        end
                    end
                end
            end
        end

        return true
    end,

    processData = function(self, entry, id)
        -- Stage 1: Try to get basic info immediately with GetItemInfoInstant
        local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = GetItemInfoInstant(id)

        if itemID then
            -- Basic info is available immediately - populate what we can
            entry.icon = icon
            entry.itemType = itemType
            entry.itemSubType = itemSubType
            entry.itemEquipLoc = itemEquipLoc
            entry.classID = classID
            entry.subclassID = subclassID
        else
            if DataManager.debug then
                DataManager:Debug(format("[%s] Item %d: GetItemInfoInstant returned nil - item may not exist",
                    self.entityType, id))
            end
        end

        -- Stage 2: Check if full data is ready
        if not self:isDataReady(id) then
            entry.pendingData = true
            self:queueDataLoad(id, entry)
            return true
        end

        -- Full data is available - get complete information
        local name, link, quality, level, minLevel, itemType, itemSubType, stackCount, equipLoc, texture, sellPrice, classID, subclassID, bindType, expansionID, setId, isCraftingReagent = WoWAPI.GetItemInfo(id)
        if not name then
            -- Try to get the item name using GetItemInfoInstant to see if it's available
            local instantItemID, instantItemType, instantItemSubType, instantItemEquipLoc, instantIcon, instantClassID, instantSubclassID =
                GetItemInfoInstant(id)
            local itemNameFromInstant = instantItemID and "Available via GetItemInfoInstant" or
                "Not available via GetItemInfoInstant"

            -- Try direct API calls to see if the item is available
            local directName, directLink
            if C_Item and C_Item.GetItemInfo then
                directName, directLink = C_Item.GetItemInfo(id)
            else
                directName, directLink = _G.GetItemInfo(id)
            end
            local directStatus = directName and ("Direct API: " .. directName) or "Direct API: nil"

            -- Add detailed debugging for failed items
            if DataManager.debug then
                DataManager:Debug(format(
                    "[%s] Item %d: GetItemInfo returned nil name (attempt %d/3) - path: %s, flags: %s, hasBasicInfo: %s, instantStatus: %s, %s",
                    self.entityType, id, (entry.failedAttempts or 0) + 1,
                    entry.path and table.concat(entry.path, ".") or "NO_PATH",
                    entry.flags and next(entry.flags) and "HAS_FLAGS" or "NO_FLAGS",
                    entry.icon and "YES" or "NO",
                    itemNameFromInstant,
                    directStatus))
            end
            -- Check if this is a permanent failure (item doesn't exist)
            if entry.failedAttempts and entry.failedAttempts >= 3 then
                if DataManager.debug then
                    DataManager:Debug(format(
                        "[%s] Item %d: Permanent failure after %d attempts - item likely doesn't exist in current game version",
                        self.entityType, id, entry.failedAttempts))
                end
                -- Mark as permanently failed to avoid retrying
                entry.permanentlyFailed = true
                entry.pendingData = nil
                return false
            end

            -- Increment failure count and retry later
            entry.failedAttempts = (entry.failedAttempts or 0) + 1
            entry.pendingData = true
            self:queueDataLoad(id, entry)
            if DataManager.debug then
                DataManager:Debug(format("[%s] Item %d: Queued for retry (attempt %d/3)",
                    tostring(self.entityType or "unknown"), tostring(id or "nil"),
                    tostring(entry and entry.failedAttempts or 0)))
            end
            return true
        end

        -- Successfully got full data - populate all fields
        entry.name = name
        entry.link = link
        entry.quality = quality
        entry.level = level
        entry.minLevel = minLevel
        entry.stackCount = stackCount
        entry.sellPrice = sellPrice
        entry.bindType = bindType
        entry.expansionID = expansionID
        entry.setId = setId
        entry.isCraftingReagent = isCraftingReagent

        -- Update icon if not already set from GetItemInfoInstant
        if not entry.icon then
            entry.icon = icon
        end

        -- Mark as fully loaded
        entry.pendingData = nil
        entry.failedAttempts = nil

        return true
    end,

    postProcess = function(self, entry, id)
        -- Skip processing for permanently failed items
        if entry.permanentlyFailed then
            if DataManager.debug then
                DataManager:Debug(format("[%s] Item %d: Skipping postProcess for permanently failed item",
                    tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil")))
            end
            return
        end

        -- The default behavior is to use GetItemSpell. We only do this if our
        -- more detailed raw data didn't already provide a spellId.
        if not entry.pendingData and not entry.spellId then
            local spellId = select(2, GetItemSpell(id))
            if spellId and spellId > 0 then
                -- Skip dummy trigger IDs that are not actual spells
                if spellId == 18350 then
                    if DataManager.debug then
                        DataManager:Debug(format(
                            "[%s] Item %d -> Skipping dummy trigger ID: %d (proc effect reference, not a real spell)",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(spellId or "nil")))
                    end
                    return -- Skip processing this dummy trigger
                end
                -- Validate path before proceeding with spell creation
                if not entry.path then
                    -- Extra debug info for missing path
                    if DevTools_Dump then
                        print("=== [postProcess][NO_PATH] Item " .. entry.id .. " ===")
                        print("Name: " .. tostring(entry.name))
                        print("Flags:")
                        DevTools_Dump(entry.flags)
                        if entry.raw then
                            print("Raw data:")
                            DevTools_Dump(entry.raw)
                        end
                        print("=== End Item " .. entry.id .. " ===")
                    end
                    if debugstack then
                        if DataManager.debug then DataManager:Debug("[postProcess][NO_PATH] stack: %s", debugstack(2, 10, 10)) end
                    end
                    DataManager:Warn(format("[%s] Item %d has no path for postProcess spell creation - skipping",
                        self.entityType, entry.id))
                    return
                end

                local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]

                if spellProcessor then
                    local spellEntry = spellProcessor:process(spellId, spellPath,
                        { parentId = entry.id, parentType = self.entityType })
                    if spellEntry then
                        -- This handles basic "On Use" spells for items that weren't in our Jinja export
                        self:addRelationshipComplex(entry.id, self.entityType, spellId, DataManager.EntityTypes.SPELL)
                        entry.spellId = spellId
                        if DataManager.debug then
                            DataManager:Trace(format("[%s] Item %d -> Created postProcess Spell %d",
                                tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                                tostring(spellId or "nil")))
                        end
                    else
                        if DataManager.debug then
                            DataManager:Warn(format("[%s] Item %d -> Failed to create postProcess Spell %d",
                                tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                                tostring(spellId or "nil")))
                        end
                    end
                else
                    DataManager:Warn(format("[%s] Item %d -> No spell processor available for postProcess Spell %d",
                        self.entityType, entry.id, spellId))
                end
            end
        end
    end

}, { __index = ProcessorV2 })

--- @class SpellProcessorV2: ProcessorV2
SpellProcessorV2 = setmetatable({
    entityType = DataManager.EntityTypes.SPELL,

    -- This new map defines bitmasks for the main Attributes field.
    -- You can expand this with mappings for AttributesEx1-14 as needed.
    SPELL_ATTRIBUTES = {
        [0x00000002] = "onNextSwing",
        [0x00000008] = "notStealable",
        [0x00000020] = "channeled",
        [0x00000040] = "passive",
        [0x00000200] = "notBreakStealth",
        [0x00004000] = "cannotBeCancelled",
        [0x00010000] = "notEvade",
        [0x00200000] = "mainHandRequired",
        [0x04000000] = "startPeriodicAtApply",
        [0x08000000] = "hideInCombatLog"
    },

    --- Overridden processRawData to handle rich spell data.
    processRawData = function(self, entry, rawData)
        if not rawData then return true end

        -- First, call the base processor to handle generic fields and simple relationships
        ProcessorV2.processRawData(self, entry, rawData)

        -- Copy all direct properties from our new template
        entry.powerType = rawData.powerType
        entry.powerCost = rawData.powerCost
        entry.castTime = rawData.castTime
        entry.cooldown = rawData.cooldown
        entry.categoryCooldown = rawData.categoryCooldown
        entry.charges = rawData.charges
        entry.procChance = rawData.procChance
        entry.internalCooldown = rawData.internalCooldown
        entry.dispelType = rawData.dispelType
        entry.mechanic = rawData.mechanic
        entry.scalingType = rawData.scalingType
        entry.projectileSpeed = rawData.projectileSpeed
        entry.duration = rawData.duration
        entry.range = rawData.range

        -- Copy spell-level properties from template
        entry.schoolMask = rawData.schoolMask
        entry.attributes = rawData.attributes
        entry.launchDelay = rawData.launchDelay
        entry.maxScalingLevel = rawData.maxScalingLevel
        entry.minScalingLevel = rawData.minScalingLevel
        entry.scalesFromItemLevel = rawData.scalesFromItemLevel
        entry.procCharges = rawData.procCharges
        entry.procTypeMask = rawData.procTypeMask
        entry.cumulativeAura = rawData.cumulativeAura
        entry.recoveryTime = rawData.recoveryTime

        -- Directly store the effects table for the simulator to use
        -- All effect fields (coefficient, variance, bonusCoefficientFromAP, etc.) are included
        entry.effects = rawData.effects

        -- Process the main Attributes bitmask to create boolean flags
        if rawData.attributes and type(rawData.attributes) == "string" and rawData.attributes ~= "" then
            -- Attributes is a comma-separated string, parse it
            local attrValue = tonumber(rawData.attributes:match("([^,]+)") or rawData.attributes) or 0
            if attrValue > 0 then
                for bit, flagName in pairs(self.SPELL_ATTRIBUTES) do
                    if (band(attrValue, bit) == bit) then
                        entry.flags[flagName] = true
                    end
                end
            end
        elseif rawData.attributes and type(rawData.attributes) == "number" and rawData.attributes > 0 then
            for bit, flagName in pairs(self.SPELL_ATTRIBUTES) do
                if (band(rawData.attributes, bit) == bit) then
                    entry.flags[flagName] = true
                end
            end
        end

        -- Process relationships found within the effects table
        -- Effects can be either array (old format) or table keyed by EffectIndex (new format)
        if rawData.effects then
            if type(rawData.effects) == "table" then
                -- Check if it's array-style (old format) or table-style (new format)
                local isArray = false
                local maxIndex = 0
                for k, v in pairs(rawData.effects) do
                    if type(k) == "number" then
                        maxIndex = math.max(maxIndex, k)
                        isArray = true
                    end
                end

                if isArray then
                    -- New format: effects table keyed by EffectIndex
                    for effectIndex, effectData in pairs(rawData.effects) do
                        if type(effectData) == "table" then
                            self:ProcessEffect(entry, effectData, effectIndex)
                        end
                    end
                else
                    -- Old format: effects array
                    for _, effectData in ipairs(rawData.effects) do
                        if type(effectData) == "table" then
                            self:ProcessEffect(entry, effectData, effectData.effectIndex or 0)
                        end
                    end
                end
            end
        end

        return true
    end,

    --- Process a single effect from the effects table
    --- @param entry table The spell entry being processed
    --- @param effectData table The effect data to process
    --- @param effectIndex number The effect index (0, 1, or 2)
    ProcessEffect = function(self, entry, effectData, effectIndex)
        if not effectData or type(effectData) ~= "table" then
            return
        end

        -- Process spell overrides (EffectAura 332)
        self:ProcessEffectOverrides(entry, effectData, effectIndex)

        -- Process triggered spells (EffectTriggerSpell)
        self:ProcessEffectTriggers(entry, effectData, effectIndex)

        -- Process stat modifications (EffectAura 29)
        self:ProcessStatModifications(entry, effectData, effectIndex)

        -- Process periodic effects (DoT/HoT)
        self:ProcessPeriodicEffects(entry, effectData, effectIndex)

        -- Process damage/healing modifications
        self:ProcessDamageModifications(entry, effectData, effectIndex)
    end,

    --- Detect and process spell overrides (Aura 332)
    --- @param entry table The spell entry
    --- @param effectData table The effect data
    --- @param effectIndex number The effect index
    ProcessEffectOverrides = function(self, entry, effectData, effectIndex)
        -- EffectAura 332 = A_OVERRIDE_ACTIONBAR_SPELLS
        if effectData.aura == 332 and effectData.effect == 6 and effectData.basePoints and effectData.basePoints > 0 then
            local replacementSpellId = effectData.basePoints
            local overrideCategory = effectData.miscValue1 or 0

            if DataManager.debug then
                DataManager:Debug(format("[%s] Spell %d overrides spell %d (category %d) via effect index %d",
                    tostring(self.entityType or "unknown"), tostring(entry.id or "nil"),
                    tostring(replacementSpellId or "nil"), tostring(overrideCategory or "nil"), tostring(effectIndex or "nil")))
            end

            -- Initialize overrides array from raw data if present (handles template-generated arrays)
            if not entry.overrides and entry.raw and entry.raw.overrides then
                if type(entry.raw.overrides) == "table" then
                    -- Already an array from template
                    entry.overrides = {}
                    for _, id in ipairs(entry.raw.overrides) do
                        table.insert(entry.overrides, id)
                    end
                else
                    -- Single value from old data
                    entry.overrides = { entry.raw.overrides }
                end
            end

            -- Store override information (support both single value and array)
            if not entry.overrides then
                entry.overrides = {}
            elseif type(entry.overrides) ~= "table" then
                -- Convert existing single value to array
                local existingOverride = entry.overrides
                entry.overrides = { existingOverride }
            end

            -- Add new override to array if not already present
            local alreadyPresent = false
            for _, existingId in ipairs(entry.overrides) do
                if existingId == replacementSpellId then
                    alreadyPresent = true
                    break
                end
            end

            if not alreadyPresent then
                table.insert(entry.overrides, replacementSpellId)
            end

            -- Store category (should be same for all overrides, use from raw data if available)
            if entry.raw and entry.raw.overrideCategory then
                entry.overrideCategory = entry.raw.overrideCategory
            else
                entry.overrideCategory = overrideCategory
            end

            -- Create relationship
            local targetType = DataManager.EntityTypes.SPELL
            local targetPath = transformPath(entry.path, self.entityType, targetType)
            table.insert(targetPath, "Override")

            local processor = ProcessorsV2[targetType]
            if processor then
                processor:process(replacementSpellId, targetPath)
                self:addRelationshipComplex(entry.id, self.entityType, replacementSpellId, targetType)
            end
        end
    end,

    --- Process triggered spells (EffectTriggerSpell)
    --- @param entry table The spell entry
    --- @param effectData table The effect data
    --- @param effectIndex number The effect index
    ProcessEffectTriggers = function(self, entry, effectData, effectIndex)
        if effectData.triggerSpell and effectData.triggerSpell > 0 then
            local targetType = DataManager.EntityTypes.SPELL
            local targetId = effectData.triggerSpell
            local targetPath = transformPath(entry.path, self.entityType, targetType)

            -- Determine relationship type based on aura
            local relationshipType = "Triggered"
            if effectData.aura == 42 then
                relationshipType = "Proc"
            elseif effectData.aura == 23 then
                relationshipType = "PeriodicTrigger"
            end

            table.insert(targetPath, relationshipType)

            local processor = ProcessorsV2[targetType]
            if processor then
                processor:process(targetId, targetPath)
                self:addRelationshipComplex(entry.id, self.entityType, targetId, targetType)

                if DataManager.debug then
                    DataManager:Debug(format("[%s] Spell %d triggers spell %d (%s) via effect index %d",
                        tostring(self.entityType or "unknown"), tostring(entry.id or "nil"),
                        tostring(targetId or "nil"), relationshipType, tostring(effectIndex or "nil")))
                end
            end
        end
    end,

    --- Process stat modifications (EffectAura 29)
    --- @param entry table The spell entry
    --- @param effectData table The effect data
    --- @param effectIndex number The effect index
    ProcessStatModifications = function(self, entry, effectData, effectIndex)
        -- EffectAura 29 = A_MOD_STAT
        if effectData.aura == 29 and effectData.miscValue0 then
            local statType = effectData.miscValue0
            local statBonus = effectData.basePoints or 0

            -- Stat type mapping: 0=Strength, 1=Agility, 2=Stamina, 3=Intellect, 4=Spirit, 5=All Stats
            local statNames = {
                [0] = "strength",
                [1] = "agility",
                [2] = "stamina",
                [3] = "intellect",
                [4] = "spirit",
                [5] = "allStats"
            }

            local statName = statNames[statType]
            if statName then
                entry.statModifications = entry.statModifications or {}
                entry.statModifications[statName] = statBonus

                if DataManager.debug then
                    DataManager:Debug(format("[%s] Spell %d modifies %s by %d via effect index %d",
                        tostring(self.entityType or "unknown"), tostring(entry.id or "nil"),
                        statName, tostring(statBonus or "nil"), tostring(effectIndex or "nil")))
                end
            end
        end
    end,

    --- Process periodic effects (DoT/HoT)
    --- @param entry table The spell entry
    --- @param effectData table The effect data
    --- @param effectIndex number The effect index
    ProcessPeriodicEffects = function(self, entry, effectData, effectIndex)
        -- EffectAura 3 = A_PERIODIC_DAMAGE (DoT)
        -- EffectAura 8 = A_PERIODIC_HEAL (HoT)
        if effectData.aura == 3 or effectData.aura == 8 then
            local isDoT = (effectData.aura == 3)
            local damagePerTick = effectData.basePoints or 0
            local tickInterval = effectData.auraPeriod or 0

            entry.periodicEffects = entry.periodicEffects or {}
            table.insert(entry.periodicEffects, {
                type = isDoT and "damage" or "heal",
                damagePerTick = damagePerTick,
                tickInterval = tickInterval,
                effectIndex = effectIndex
            })

            if DataManager.debug then
                DataManager:Debug(format("[%s] Spell %d has %s: %d per tick, %dms interval via effect index %d",
                    tostring(self.entityType or "unknown"), tostring(entry.id or "nil"),
                    isDoT and "DoT" or "HoT", tostring(damagePerTick or "nil"),
                    tostring(tickInterval or "nil"), tostring(effectIndex or "nil")))
            end
        end
    end,

    --- Process damage/healing modifications
    --- @param entry table The spell entry
    --- @param effectData table The effect data
    --- @param effectIndex number The effect index
    ProcessDamageModifications = function(self, entry, effectData, effectIndex)
        -- EffectAura 13 = A_MOD_DAMAGE_DONE
        -- EffectAura 79 = A_MOD_DAMAGE_PERCENT_DONE
        -- EffectAura 115 = A_MOD_HEALING
        -- EffectAura 118 = A_MOD_HEALING_PCT
        local damageModAuras = {
            [13] = "damageDone",
            [79] = "damagePercentDone",
            [115] = "healingDone",
            [118] = "healingPercentDone"
        }

        local modType = damageModAuras[effectData.aura]
        if modType and effectData.basePoints then
            entry.damageModifications = entry.damageModifications or {}
            entry.damageModifications[modType] = effectData.basePoints

            if DataManager.debug then
                DataManager:Debug(format("[%s] Spell %d modifies %s by %d via effect index %d",
                    tostring(self.entityType or "unknown"), tostring(entry.id or "nil"),
                    modType, tostring(effectData.basePoints or "nil"), tostring(effectIndex or "nil")))
            end
        end
    end,

    --- Get human-readable EffectAura type name
    --- @param effectAura number The EffectAura ID
    --- @return string|nil The aura type name
    GetEffectAuraType = function(self, effectAura)
        local auraTypes = {
            [0] = "NONE",
            [3] = "PERIODIC_DAMAGE",
            [8] = "PERIODIC_HEAL",
            [13] = "MOD_DAMAGE_DONE",
            [29] = "MOD_STAT",
            [42] = "PROC_TRIGGER_SPELL",
            [79] = "MOD_DAMAGE_PERCENT_DONE",
            [99] = "MOD_ATTACK_POWER",
            [115] = "MOD_HEALING",
            [118] = "MOD_HEALING_PCT",
            [332] = "OVERRIDE_ACTIONBAR_SPELLS"
        }
        return auraTypes[effectAura]
    end,

    --- processData now acts as a fallback or to supplement missing info
    processData = function(self, entry, id)
        -- Validate spell ID - spell ID 0 is not valid in WoW
        if id == 0 then
            if DataManager.debug then
                DataManager:Debug(format(
                    "[%s] Skipping processing for invalid spell ID: 0 (likely from battle pet data or placeholder)",
                    tostring(self.entityType or "unknown")))
            end
            return false
        end

        -- Skip dummy trigger IDs that are not actual spells
        if id == 18350 then
            if DataManager.debug then
                DataManager:Debug(format(
                    "[%s] Skipping processing for dummy trigger ID: %d (proc effect reference, not a real spell)",
                    tostring(self.entityType or "unknown"), tostring(id or "nil")))
            end
            return false
        end

        -- The raw data is now the primary source.
        -- We only use GetSpellInfo if the name/icon is missing.
        if not entry.name or not entry.icon then
            local spellInfo = WoWAPI.GetSpellInfo(id)
            if not spellInfo then
                if DataManager.debug then
                    DataManager:Debug(format(
                        "[%s] GetSpellInfo returned nil for spell ID: %d - spell may not exist in current game version",
                        tostring(self.entityType or "unknown"), tostring(id or "nil")))
                end
                return false
            end

            local name, rank, icon = spellInfo.name, spellInfo.rank, spellInfo.iconID
            entry.name = entry.name or name
            entry.rank = entry.rank or rank
            entry.icon = entry.icon or icon
        end

        return true
    end,

    processSpecializedFlags = function(self, entry)
        -- Most flags are now handled automatically:
        -- 1. Base 'spell' flag from createBaseEntry
        -- 2. Path-based flags from processFlags
        -- 3. *Id based flags from processFlags
        -- 4. Relationship flags added during relationship creation
    end,

    -- Add talent flag when spell receives relationship from talent
    onRelationshipAdded = function(self, entity, sourceType, sourceId, relationType)
        -- When a spell receives a relationship from a talent, add the talent flag
        if sourceType == DataManager.EntityTypes.TALENT then
            -- Only add flag if it doesn't already exist to avoid duplicate index entries
            if not entity.flags.talent then
                entity.flags.talent = true
                -- Update flag index for consistency
                self:updateFlagIndex(entity, "talent", true)
                if DataManager.debug then
                    DataManager:Debug(format("[%s] Spell %d: Added talent flag (relationship from talent %d)",
                        self.entityType, entity.id, sourceId))
                end
            end
        end
    end,

    postProcess = function(self, entry, id)
        -- Process relationships if this is from a parent item
        --if entry.parentId and entry.parentType then
        --    -- Use standard relationship based on parent type
        --    self:addRelationshipComplex(entry[entry.entryType .. "Id"], entry.entryType, entry.parentId, entry.parentType)
        --end
    end
}, { __index = ProcessorV2 })

TierSetProcessorV2 = setmetatable({
    entityType = DataManager.EntityTypes.TIERSET,

    validateType = function(self, entry, rawData)
        -- First call base validation
        local valid, err = ProcessorV2.validateType(self, entry, rawData)
        if not valid then
            return false, err
        end

        -- If we have no raw data but have an ID, allow it to proceed
        -- This lets us create a basic entry that can be updated later
        if not rawData then
            return true
        end

        -- Only validate bonus structure if we have raw data
        if rawData.bonuses then
            if type(rawData.bonuses) ~= "table" then
                return false, "Bonuses must be a table"
            end
            for count, bonus in pairs(rawData.bonuses) do
                if type(count) ~= "number" or count < 1 then
                    return false, format("Invalid bonus count: %s", tostring(count))
                end
                if not bonus.spellId then
                    return false, format("Missing spellId for %d piece bonus", count)
                end
            end
        end

        return true
    end,

    processData = function(self, entry, id)
        -- Allow creation of basic entries without raw data
        -- They will be updated when raw data arrives
        return true
    end,

    processRawData = function(self, entry, rawData)
        if not rawData then return true end

        -- Copy basic fields
        for key, value in pairs(rawData) do
            if not EXCLUDED_ENTRY_FIELDS[key] and key ~= "bonuses" then
                entry[key] = value
            end
        end

        -- Special handling for set bonuses
        if rawData.bonuses then
            entry.bonuses = entry.bonuses or {}
            for count, bonus in pairs(rawData.bonuses) do
                if bonus.spellId then
                    entry.bonuses[count] = entry.bonuses[count] or {}
                    -- Support multiple spellIds (table) or single value
                    if type(bonus.spellId) == "table" then
                        entry.bonuses[count].spellIds = {}
                        -- Validate that spellId table is properly structured
                        if #bonus.spellId > 0 then
                            for i, spellId in ipairs(bonus.spellId) do
                                if type(spellId) == "number" and spellId > 0 then
                                    table.insert(entry.bonuses[count].spellIds, spellId)
                                    -- Transform path for set bonus spell
                                    local spellPath = transformPath(entry.path, entry.entryType,
                                        DataManager.EntityTypes.SPELL)
                                    table.insert(spellPath, format("%dpc", count))
                                    -- Create spell entry
                                    local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                                    local spellEntry = spellProcessor:process(spellId, spellPath, bonus)
                                    if spellEntry then
                                        spellEntry.setBonusCount = count
                                        -- Add tierset flag for easy identification
                                        spellEntry.flags.tierset = true
                                        -- Create relationship
                                        self:addRelationshipComplex(
                                            entry[entry.entryType .. "Id"],
                                            entry.entryType,
                                            spellId,
                                            DataManager.EntityTypes.SPELL
                                        )
                                    end
                                else
                                    DataManager:Warn(format(
                                        "TierSetProcessorV2: Invalid spellId at index %d in tierset %s: %s",
                                        i, tostring(entry[entry.entryType .. "Id"]), tostring(spellId)))
                                end
                            end
                        else
                            DataManager:Warn(format(
                                "TierSetProcessorV2: Empty spellId table for tierset %s bonus count %d",
                                tostring(entry[entry.entryType .. "Id"]), count))
                        end
                    else
                        entry.bonuses[count].spellId = bonus.spellId
                        local spellId = bonus.spellId
                        local spellPath = transformPath(entry.path, entry.entryType, DataManager.EntityTypes.SPELL)
                        table.insert(spellPath, format("%dpc", count))
                        local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                        local spellEntry = spellProcessor:process(spellId, spellPath, bonus)
                        if spellEntry then
                            spellEntry.setBonusCount = count
                            -- Add tierset flag for easy identification
                            spellEntry.flags.tierset = true
                            self:addRelationshipComplex(
                                entry[entry.entryType .. "Id"],
                                entry.entryType,
                                spellId,
                                DataManager.EntityTypes.SPELL
                            )
                        end
                    end
                end
            end
        end

        return true
    end,

    processSpecializedFlags = function(self, entry)
        -- Most flags are now handled automatically:
        -- 1. Base 'tierset' flag from createBaseEntry
        -- 2. Path-based flags from processFlags
        -- 3. *Id based flags from processFlags
        -- 4. Relationship flags added during relationship creation
    end
}, { __index = ProcessorV2 })

-- Add new processors after existing ones
NPCProcessorV2 = setmetatable({
    entityType = DataManager.EntityTypes.NPC,

    processData = function(self, entry, id)
        if entry.flags and entry.flags.totem then
            -- Add totem type if provided
            --    if entry.totemType then
            --       entry.types = entry.types or {}
            --       entry.types.TotemType = entry.totemType
            --       entry.TotemType = entry.totemType
            --   end
        end

        return true -- Always allow creation even without data
    end,

    processSpecializedFlags = function(self, entry)
        -- Add totem type flag if we have totemType
        if entry.totemType then
            local totemTypes = {
                [Types:GetType("TotemType").Fire] = "totem.fire",
                [Types:GetType("TotemType").Earth] = "totem.earth",
                [Types:GetType("TotemType").Water] = "totem.water",
                [Types:GetType("TotemType").Air] = "totem.air"
            }

            local totemFlag = totemTypes[entry.totemType]
            if totemFlag then
                entry.flags[totemFlag] = true
            end
        end
    end
}, { __index = ProcessorV2 })

EnchantProcessorV2 = setmetatable({
    entityType = DataManager.EntityTypes.ENCHANT,
    -- This map translates the enchant effect type into something human-readable.
    -- Based on WoW documentation: https://wowpedia.fandom.com/wiki/Spell_aura
    ENCHANT_EFFECT_TYPES = {
        [1] = "PROC",            -- Proc (EffectArg_x = SpellID)
        [2] = "DAMAGE",          -- Damage (EffectArg_x = DamageType or None)
        [3] = "BUFF",            -- Buff (EffectArg_x = SpellID)
        [4] = "ARMOR",           -- Armor (EffectArg_x = Amount)
        [5] = "STAT",            -- Stat (EffectArg_x = StatType)
        [6] = "UNKNOWN",         -- Unused/Unknown
        [7] = "USE_SPELL",       -- Use Spell (EffectArg_x = SpellID)
        [8] = "PRISMATIC_SOCKET" -- Prismatic Socket (EffectArg_x = None)
    },

    -- Map for stat IDs used in 'APPLY_STAT' effects.
    STAT_MAP = {
        [0] = "mana",
        [1] = "health",
        [3] = "agility",
        [4] = "strength",
        [5] = "intellect",
        [6] = "spirit",
        [7] = "stamina",
        [32] = "mastery",
        [36] = "haste",
        [38] = "attack_power",
        [40] = "ranged_attack_power",
        [45] = "spell_power",
        [49] = "crit"
    },

    --- processRawData is now the primary driver for processing enchants.
    processRawData = function(self, entry, rawData)
        if not rawData then return true end

        -- Call base processor for any generic handling
        ProcessorV2.processRawData(self, entry, rawData)

        -- Copy top-level properties from the template
        entry.name = rawData.name

        -- Store the raw effects table directly on the entry for the simulator to access
        entry.effects = rawData.effects

        -- Now, iterate through the effects to create relationships and flags
        if rawData.effects then
            for _, effectData in ipairs(rawData.effects) do
                local effectType = self.ENCHANT_EFFECT_TYPES[effectData.effectType]
                if not effectType then
                    if DataManager.debug then
                        DataManager:Debug("Unknown enchant effect type %d for enchant %d",
                            effectData.effectType, entry.id)
                    end
                elseif effectType == "PROC" or effectType == "BUFF" or effectType == "USE_SPELL" then
                    -- These effect types have EffectArg_x as SpellID
                    local spellId = effectData.effectArg
                    if spellId and spellId > 0 then
                        if DataManager.debug then
                            DataManager:Debug(format("[%s] Enchant %d (%s) -> %s Spell %d",
                                tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                                tostring(entry and entry.name or "unknown"), effectType, tostring(spellId or "nil")))
                        end

                        -- Set the enchant's spellId for easy access
                        entry.spellId = spellId
                        -- Create the spell entity if it doesn't exist
                        local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                        local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                        table.insert(spellPath, effectType) -- Add effect type as descriptor
                        table.insert(spellPath, "Proc")
                        local spellEntity = spellProcessor:process(spellId, spellPath)

                        -- Set the enchant flag on the related spell so IsKnownEnchant works

                        if spellEntity then
                            spellEntity.flags.enchant = true
                            spellEntity.enchantId = entry.id
                            if DataManager.debug then
                                DataManager:Debug(format("[%s] Set enchant flag on spell %d for enchant %d",
                                    tostring(self.entityType or "unknown"), tostring(spellId or "nil"),
                                    tostring(entry and entry.id or "nil")))
                            end
                        end

                        -- Create the formal relationship
                        self:addRelationshipComplex(entry.id, self.entityType, spellId, DataManager.EntityTypes.SPELL)
                    end
                elseif effectType == "STAT" then
                    -- This is a direct stat modification.
                    local statName = self.STAT_MAP[effectData.effectArg]
                    if statName then
                        local statValue = effectData.effectValue
                        if DataManager.debug then
                            DataManager:Debug(format("[%s] Enchant %d (%s) -> Applies Stat: %s (+%d)",
                                tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                                tostring(entry and entry.name or "unknown"), tostring(statName or "unknown"),
                                tostring(statValue or 0)))
                        end

                        -- Create a specific flag and a direct property for the stat
                        entry.flags["stat_" .. statName] = true
                        entry["stat_" .. statName] = statValue
                    end
                elseif effectType == "ARMOR" then
                    -- This is an armor modification
                    local armorValue = effectData.effectValue
                    if DataManager.debug then
                        DataManager:Debug(format("[%s] Enchant %d (%s) -> Applies Armor: +%d",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(entry and entry.name or "unknown"), tostring(armorValue or 0)))
                    end
                    entry.flags.armor = true
                    entry.armor = armorValue
                elseif effectType == "DAMAGE" then
                    -- This is a damage modification
                    local damageValue = effectData.effectValue
                    if DataManager.debug then
                        DataManager:Debug(format("[%s] Enchant %d (%s) -> Applies Damage: +%d",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(entry and entry.name or "unknown"), tostring(damageValue or 0)))
                    end
                    entry.flags.damage = true
                    entry.damage = damageValue
                elseif effectType == "PRISMATIC_SOCKET" then
                    -- This adds a prismatic socket
                    if DataManager.debug then
                        DataManager:Debug(format("[%s] Enchant %d (%s) -> Adds Prismatic Socket",
                            tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil"),
                            tostring(entry and entry.name or "unknown")))
                    end
                    entry.flags.prismatic_socket = true
                end
            end
        end

        return true
    end,

    --- processData is now simplified. An enchant's data comes entirely from our
    --- template, not from a WoW API call like GetSpellInfo.
    processData = function(self, entry, id)
        -- All necessary data (name, effects, etc.) is provided by processRawData.
        -- The old logic using GetSpellInfo was incorrect because an enchantId is not a spellId.
        -- We simply return true to allow the entry to be created.
        return true
    end,

}, { __index = ProcessorV2 })







--- @class TalentProcessorV2: ProcessorV2
TalentProcessorV2 = setmetatable({
    entityType = DataManager.EntityTypes.TALENT,

    --- This function is now "bilingual" and can parse MoP or modern talent data.
    processRawData = function(self, entry, rawData)
        if not rawData then return true end

        if DataManager.debug then
            DataManager:Debug("[%s] processRawData: Processing talent %s with rawData keys: %s",
                self.entityType, tostring(entry.id or "unknown"),
                rawData and table.concat(TableUtils.Keys(rawData), ", ") or "none")
        end

        -- Call base processor for any generic handling
        ProcessorV2.processRawData(self, entry, rawData)

        -- <<<< LOGIC FOR MoP-ERA TALENTS >>>>
        -- We detect this format by looking for the `ranks` table OR direct `spellId`.
        if rawData.ranks then
            if DataManager.debug then
                DataManager:Debug(format("[%s] Processing MoP-era talent data (ranks format) for ID: %d",
                    tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil")))
            end
            -- Copy data specific to the MoP talent system
            entry.tabId = rawData.tabId
            entry.row = rawData.row
            entry.column = rawData.column
            entry.flagsValue = rawData.flags -- Store raw flags value
            entry.maxRank = #rawData.ranks

            -- Store the raw ranks table for the simulator
            entry.ranks = rawData.ranks

            -- Iterate through the ranks to create spell relationships
            for i, spellId in ipairs(rawData.ranks) do
                if spellId and spellId > 0 then
                    -- Create the spell entity if it doesn't exist
                    local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                    local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                    spellProcessor:process(spellId, spellPath)

                    -- Create the TALENT_TO_SPELL relationship
                    self:addRelationshipComplex(entry.id, self.entityType, spellId, DataManager.EntityTypes.SPELL)

                    -- CRITICAL: Update the reverse lookup map for this spell rank
                    DataManager.storage.spellToTalent[spellId] = entry.id

                    -- For convenience, set the main 'spellId' of the talent entry
                    -- to the first rank's spell ID.
                    if i == 1 then
                        entry.spellId = spellId
                    end
                end
            end

        -- Handle MoP format with direct spellId (single-rank talents)
        elseif rawData.spellId then
            if DataManager.debug then
                DataManager:Debug(format("[%s] Processing MoP-era talent data (direct spellId format) for ID: %d",
                    tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil")))
            end
            -- Copy data specific to the MoP talent system
            entry.tabId = rawData.tabId
            entry.row = rawData.row
            entry.column = rawData.column
            entry.flagsValue = rawData.flags -- Store raw flags value
            entry.maxRank = 1 -- Single rank talent
            entry.spellId = rawData.spellId

            -- Create the spell entity if it doesn't exist
            local spellId = rawData.spellId
            if spellId and spellId > 0 then
                local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                spellProcessor:process(spellId, spellPath)

                -- Create the TALENT_TO_SPELL relationship
                self:addRelationshipComplex(entry.id, self.entityType, spellId, DataManager.EntityTypes.SPELL)

                -- CRITICAL: Update the reverse lookup map for this spell
                DataManager.storage.spellToTalent[spellId] = entry.id
            end

            -- CRITICAL: Track spell override relationships for IsKnownSpell filtering
            if rawData.overridesSpellId and rawData.overridesSpellId > 0 then
                local overriddenSpellId = rawData.overridesSpellId
                DataManager.storage.spellToOverridingTalent[overriddenSpellId] = {
                    talentId = entry.id,
                    overrideSpellId = spellId
                }

                if DataManager.debug then
                    DataManager:Debug(format("[%s] Talent %d overrides spell %d with %d",
                        self.entityType, entry.id, overriddenSpellId, spellId))
                end
            end

            -- <<<< LOGIC FOR MODERN NODE-BASED TALENTS >>>>
            -- We detect this format by looking for `nodeType`.
        elseif rawData.nodeType then
            if DataManager.debug then
                DataManager:Debug(format("[%s] Processing modern node-based talent data for ID: %d",
                    tostring(self.entityType or "unknown"), tostring(entry and entry.id or "nil")))
            end
            -- Copy node-level data
            entry.nodeType = rawData.nodeType
            entry.posX = rawData.posX
            entry.posY = rawData.posY
            entry.maxRanks = rawData.maxRanks
            entry.spells = rawData.spells -- Store raw spells for simulator

            -- Iterate through the spells to create relationships
            if rawData.spells then
                for i, spellData in ipairs(rawData.spells) do
                    local spellId = spellData.spellId
                    if spellId and spellId > 0 then
                        local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                        local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                        spellProcessor:process(spellId, spellPath)
                        self:addRelationshipComplex(entry.id, self.entityType, spellId, DataManager.EntityTypes.SPELL)
                        DataManager.storage.spellToTalent[spellId] = entry.id
                        if i == 1 then
                            entry.spellId = spellId
                        end
                    end
                end
            end
        end

        return true
    end,

    --- This function now works as a perfect fallback for BOTH formats.
    processData = function(self, entry, id)
        -- If the entry has a primary spellId (set from either format in rawData)
        -- and we don't have a name/icon yet, fetch it from the API.
        if entry.spellId and not entry.name then
            local spellInfo = WoWAPI.GetSpellInfo(entry.spellId)
            if spellInfo and spellInfo.name then
                entry.name = spellInfo.name
                entry.icon = spellInfo.iconID
            end
        end
        return true
    end
}, { __index = ProcessorV2 })

--- @class BattlePetProcessorV2: ProcessorV2
BattlePetProcessorV2 = setmetatable({
    entityType = DataManager.EntityTypes.BATTLEPET,

    --- Process battle pet data with relationships to creatures and spells
    processRawData = function(self, entry, rawData)
        if not rawData then return true end

        -- Call base processor for any generic handling
        ProcessorV2.processRawData(self, entry, rawData)

        -- Copy all direct properties from the template
        entry.speciesId = rawData.speciesId
        entry.creatureId = rawData.creatureId
        entry.summonSpellId = rawData.summonSpellId
        entry.iconFileDataId = rawData.iconFileDataId
        entry.petTypeEnum = rawData.petTypeEnum
        entry.sourceTypeEnum = rawData.sourceTypeEnum
        entry.description = rawData.description
        entry.sourceText = rawData.sourceText
        entry.effect = rawData.effect
        entry.effectAura = rawData.effectAura
        entry.effectBasePoints = rawData.effectBasePoints
        entry.effectTriggerSpell = rawData.effectTriggerSpell

        -- Store battlepet flags value and add the crucial 'battlepet' flag
        if rawData.battlepetFlags then
            entry.battlepetFlags = rawData.battlepetFlags -- Store battlepet flags value
        elseif rawData.flags then
            entry.battlepetFlags = rawData.flags          -- Store legacy flags value
        end
        entry.flags.battlepet = true

        -- Create relationships to creature and spell if they exist
        if rawData.creatureId and rawData.creatureId > 0 then
            -- Create creature relationship
            local creatureProcessor = ProcessorsV2[DataManager.EntityTypes.NPC]
            if creatureProcessor then
                local creaturePath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.NPC)
                creatureProcessor:process(rawData.creatureId, creaturePath)
                self:addRelationshipComplex(entry.id, self.entityType, rawData.creatureId, DataManager.EntityTypes.NPC)
            end
        end

        if rawData.summonSpellId and rawData.summonSpellId > 0 then
            -- Create spell relationship
            local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
            if spellProcessor then
                local spellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                spellProcessor:process(rawData.summonSpellId, spellPath)
                self:addRelationshipComplex(entry.id, self.entityType, rawData.summonSpellId,
                    DataManager.EntityTypes.SPELL)
            end
        end

        if rawData.effectTriggerSpell and rawData.effectTriggerSpell > 0 then
            -- Create trigger spell relationship
            local triggerSpellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
            if triggerSpellProcessor then
                local triggerSpellPath = transformPath(entry.path, self.entityType, DataManager.EntityTypes.SPELL)
                table.insert(triggerSpellPath, "trigger")
                triggerSpellProcessor:process(rawData.effectTriggerSpell, triggerSpellPath)
                self:addRelationshipComplex(entry.id, self.entityType, rawData.effectTriggerSpell,
                    DataManager.EntityTypes.SPELL)
            end
        end

        return true
    end,

    --- Process data - battle pets don't need API calls since all data comes from template
    processData = function(self, entry, id)
        -- All necessary data is provided by processRawData from the template
        -- No additional API calls needed
        return true
    end,

    processSpecializedFlags = function(self, entry)
        -- Add pet type flag if we have petTypeEnum
        if entry.petTypeEnum then
            local petTypes = {
                [0] = "pet.humanoid",
                [1] = "pet.dragonkin",
                [2] = "pet.flying",
                [3] = "pet.undead",
                [4] = "pet.critter",
                [5] = "pet.magical",
                [6] = "pet.elemental",
                [7] = "pet.beast",
                [8] = "pet.aquatic",
                [9] = "pet.mechanical"
            }

            local petTypeFlag = petTypes[entry.petTypeEnum]
            if petTypeFlag then
                entry.flags[petTypeFlag] = true
            end
        end
    end
}, { __index = ProcessorV2 })

-- Update processor registry
ProcessorsV2 = {
    [DataManager.EntityTypes.ITEM] = ItemProcessorV2,
    [DataManager.EntityTypes.SPELL] = SpellProcessorV2,
    [DataManager.EntityTypes.TIERSET] = TierSetProcessorV2,
    [DataManager.EntityTypes.NPC] = NPCProcessorV2,
    [DataManager.EntityTypes.ENCHANT] = EnchantProcessorV2,
    [DataManager.EntityTypes.TALENT] = TalentProcessorV2,
    [DataManager.EntityTypes.BATTLEPET] = BattlePetProcessorV2
}

initializeStorage = function()
    -- Create storage structure
    DataManager.storage = {
        -- Primary storage for each entity type
        entities = {},

        -- Relationship maps
        relationships = {},

        -- Lookup tables
        byName = {},
        byType = {},        -- Add type index
        byFlag = {},
        spellToTalent = {}, -- Add spell-to-talent index
        spellToOverridingTalent = {}, -- Maps overridden spell ID to {talentId, overrideSpellId}
    }

    -- Initialize storage for each entity type
    for _, storageKey in pairs(DataManager.EntityTypes) do
        DataManager.storage.entities[storageKey] = {}
    end
end



getEntityStorage = function(entityType)
    if not DataManager.storage then
        DataManager:Warn("Storage " .. entityType .. " not initialized")
        return nil
    end
    if not DataManager.storage.entities then
        DataManager:Warn("Entities storage not initialized")
        return nil
    end

    -- Convert enum key to storage key if needed
    local storageKey = type(entityType) == "string" and entityType:lower() or DataManager.EntityTypes[entityType]
    if not storageKey then
        DataManager:Warn(format("Invalid entity type: %s", tostring(entityType)))
        return nil
    end

    local storage = DataManager.storage.entities[storageKey]
    if not storage then
        DataManager:Warn(format("No storage found for type %s (key: %s)", entityType, storageKey))
        return nil
    end
    return storage
end

createBaseEntry = function(entityType, id, path, rawEntry)
    -- Create basic entry structure with only our properties
    local entry = {
        -- Add consistent id field
        id = id,
        -- Keep type-specific ID field
        [entityType .. "Id"] = id,
        -- Common fields
        flags = {
            -- Set base type flag with proper case
            [entityType] = true
        },
        raw = rawEntry,
        path = path,
        entryType = entityType,
        -- Set base type boolean with proper case
        ["Is" .. entityType:gsub("^%l", string.upper)] = true,
        -- Add relationships table
        relationships = {},
        -- Add types table
        types = {}
    }
    return entry
end

transformPath = function(sourcePath, sourceType, targetType)
    if not sourcePath then return { targetType } end

    -- Always start with target type
    local newPath = { targetType }

    -- Copy path components that would create flags, excluding blacklisted ones
    for _, component in ipairs(sourcePath) do
        -- Skip entity type markers and ignored components
        if component ~= sourceType and component ~= targetType and not IGNORED_PATH_COMPONENTS[component] then
            -- Check if this flag is blacklisted for the target type
            table.insert(newPath, component)
        end
    end

    return newPath
end

-- Helper function to generate relationship type string
getRelationshipType = function(sourceType, targetType)
    return string.upper(sourceType) .. "_TO_" .. string.upper(targetType)
end

--- Clean up permanently failed items from storage
--- @param self DataManager
function DataManager:CleanupFailedItems()
    local itemStorage = getEntityStorage(self.EntityTypes.ITEM)
    if not itemStorage then return end

    local failedCount = 0
    local cleanedCount = 0
    local pendingCount = 0
    local successCount = 0

    for itemId, entry in pairs(itemStorage) do
        if entry.permanentlyFailed then
            failedCount = failedCount + 1
            -- Remove from storage
            itemStorage[itemId] = nil
            cleanedCount = cleanedCount + 1

            -- Remove from name index if present
            if entry.name and self.storage.byName[entry.name] then
                for i = #self.storage.byName[entry.name], 1, -1 do
                    if self.storage.byName[entry.name][i] == entry then
                        table.remove(self.storage.byName[entry.name], i)
                        break
                    end
                end
            end

            -- Remove from flag indices
            if entry.flags then
                for flag in pairs(entry.flags) do
                    if self.storage.byFlag[flag] then
                        for i = #self.storage.byFlag[flag], 1, -1 do
                            if self.storage.byFlag[flag][i] == entry then
                                table.remove(self.storage.byFlag[flag], i)
                                break
                            end
                        end
                    end
                end
            end
        elseif entry.pendingData then
            pendingCount = pendingCount + 1
        else
            successCount = successCount + 1
        end
    end

    if cleanedCount > 0 then
        self:Info(format("Item Processing Summary: %d successful, %d pending, %d permanently failed (cleaned up %d)",
            successCount, pendingCount, failedCount, cleanedCount))
    else
        self:Info(format("Item Processing Summary: %d successful, %d pending, %d failed",
            successCount, pendingCount, failedCount))
    end
end

--- @param self DataManager
function DataManager:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    DataWalker = NAG:GetModule("DataWalker")
    Types = NAG:GetModule("Types")
    SchemaAccessor = NAG:GetModule("SchemaAccessor")


    -- Initialize storage first
    initializeStorage()

    -- Initialize processors with ALL processor types
    ProcessorsV2 = {
        [self.EntityTypes.ITEM] = ItemProcessorV2,
        [self.EntityTypes.SPELL] = SpellProcessorV2,
        [self.EntityTypes.TIERSET] = TierSetProcessorV2,
        [self.EntityTypes.NPC] = NPCProcessorV2,
        [self.EntityTypes.ENCHANT] = EnchantProcessorV2,
        [self.EntityTypes.TALENT] = TalentProcessorV2,
        [self.EntityTypes.BATTLEPET] = BattlePetProcessorV2
    }

    -- Initialize data processing state
    self.dataProcessed = false

    -- Action identity caches (spell/item disambiguation)
    self._identityCache = self._identityCache or {}
    self._spellInfoCache = self._spellInfoCache or {}
end

function DataManager:ModuleEnable()
    -- ============================ MODULE INITIALIZATION ============================
    self:ProcessPetAbilities()
    self:ImportConsumableEnumToId()

    -- Clean up permanently failed items after a delay
    self:ScheduleTimer(function()
        self:CleanupFailedItems()
    end, 10) -- Wait 10 seconds for initial data loading to complete

    -- Schedule error reporting if dev mode is enabled
    if NAG:IsDevModeEnabled() then
        self:ScheduleTimer(function()
            self:ReportProcessingErrors()
        end, 15) -- Wait 15 seconds for data processing to complete
    end

    if self.logInitialData then
        self:LogData()
    end

    -- Slash commands now handled by zero-boilerplate slashCommands table
end

--- Check if data processing is complete and data is ready for access
--- @param self DataManager
--- @return boolean True if data is ready, false otherwise
function DataManager:IsDataReady()
    -- Single startup barrier contract:
    -- this flag only flips after DataWalker processing completes and right
    -- before NAG_EXPANSION_DATA_LOADED is broadcast.
    return self.dataProcessed == true
end

--- Called when the module is disabled - proper cleanup for timers and state
--- @param self DataManager
function DataManager:ModuleDisable()
    self:Info("Disabling DataManager - cleaning up timers and state")

    -- Cancel any pending timers
    self:CancelAllTimers()

    -- Clear any cached data that might be memory-intensive
    if self.cachedData then wipe(self.cachedData) end

    -- Reset processing state
    self.isProcessing = false
    self.processingQueue = {}
end

--- Handle debug commands for DataManager
function DataManager:HandleErrorsCommand()
    if NAG:IsDevModeEnabled() then
        self:Print("Manual error report triggered")
        self:ReportProcessingErrors()
    else
        self:Print("Error reporting only available in dev mode")
    end
end

function DataManager:HandleDataDebugCommand(input)
    local cmd, arg = input:match("^(%S+)%s*(.*)$")
    if not cmd or cmd == "" then
        self:Print("DataManager Debug Commands:")
        self:Print("  /nagdatadebug types                    -- List all registered types")
        self:Print("  /nagdatadebug type <name>              -- Show details for a specific type")
        self:Print("  /nagdatadebug talent <id>              -- Show talent details")
        self:Print("  /nagdatadebug spell <id>               -- Show spell details")
        self:Print("  /nagdatadebug path <path>              -- Show what would be processed for a path")
        self:Print("  /nagdatadebug stats                    -- Show data processing statistics")
        self:Print("  /nagdatadebug errors                   -- Show processing error report")
        self:Print("  /nagdatadebug errorstats               -- Show error statistics summary")
        return
    end

    cmd = cmd:lower()
    if cmd == "types" then
        local types = NAG.Types:DebugList()
        self:Print("Registered Types:")
        for name, info in pairs(types) do
            self:Print(format("  %s: %s (%d values)", name, info.description or "No description", info.valueCount))
        end
    elseif cmd == "type" and arg ~= "" then
        local typeInfo = NAG.Types:GetType(arg)
        if typeInfo then
            self:Print(format("Type '%s':", arg))
            self:Print(format("  Category: %s", typeInfo._category or "Unknown"))
            self:Print(format("  Description: %s", typeInfo._description or "No description"))
            self:Print(format("  Allow Multiple: %s", tostring(typeInfo._allowMultiple or false)))
            self:Print("  Values:")
            local count = 0
            for name, value in pairs(typeInfo._values or {}) do
                if count < 10 then
                    self:Print(format("    %s = %s", name, tostring(value)))
                else
                    self:Print(format("    ... and %d more", #typeInfo._values - 10))
                    break
                end
                count = count + 1
            end
        else
            self:Print(format("Type '%s' not found", arg))
        end
    elseif cmd == "talent" and arg ~= "" then
        local talentId = tonumber(arg)
        if talentId then
            local talent = self:Get(talentId, self.EntityTypes.TALENT)
            if talent then
                self:Print(format("Talent %d:", talentId))
                self:Print(format("  Name: %s", talent.name or "Unknown"))
                self:Print(format("  Path: %s", talent.path and table.concat(talent.path, ".") or "None"))
                self:Print(format("  Types: %s",
                    talent.types and table.concat(TableUtils.Keys(talent.types), ", ") or "None"))
                self:Print(format("  Flags: %s",
                    talent.flags and table.concat(TableUtils.Keys(talent.flags), ", ") or "None"))
            else
                self:Print(format("Talent %d not found", talentId))
            end
        else
            self:Print("Invalid talent ID")
        end
    elseif cmd == "spell" and arg ~= "" then
        local spellId = tonumber(arg)
        if spellId then
            local spell = self:Get(spellId, self.EntityTypes.SPELL)
            if spell then
                self:Print(format("Spell %d:", spellId))
                self:Print(format("  Name: %s", spell.name or "Unknown"))
                self:Print(format("  Path: %s", spell.path and table.concat(spell.path, ".") or "None"))
                self:Print(format("  Types: %s",
                    spell.types and table.concat(TableUtils.Keys(spell.types), ", ") or "None"))
                self:Print(format("  Flags: %s",
                    spell.flags and table.concat(TableUtils.Keys(spell.flags), ", ") or "None"))
            else
                self:Print(format("Spell %d not found", spellId))
            end
        else
            self:Print("Invalid spell ID")
        end
    elseif cmd == "path" and arg ~= "" then
        local pathParts = {}
        for part in arg:gmatch("[^%.]+") do
            table.insert(pathParts, part)
        end

        if DataWalker then
            local entryType = DataWalker:DetermineEntryType(pathParts)
            self:Print(format("Path '%s':", arg))
            self:Print(format("  Determined Type: %s", entryType or "Unknown"))
            self:Print(format("  Path Parts: %s", table.concat(pathParts, ", ")))
        else
            self:Print("DataWalker not available")
        end
    elseif cmd == "stats" then
        self:Print("Data Processing Statistics:")
        for entityType, storageKey in pairs(self.EntityTypes) do
            local storage = self.storage.entities[storageKey]
            if storage then
                local count = 0
                count = TableUtils.Size(storage)
                self:Print(format("  %s: %d entries", entityType:upper(), count))
            end
        end
    elseif cmd == "errors" then
        self:TriggerErrorReport()
    elseif cmd == "errorstats" then
        local stats = self:GetProcessingStats()
        self:Print("=== Processing Error Statistics ===")
        self:Print(format("Total Entities: %d", stats.totalEntities))
        self:Print(format("Failed Entities: %d", stats.failedEntities))
        self:Print(format("Pending Entities: %d", stats.pendingEntities))
        self:Print(format("Success Rate: %.2f%%", stats.successRate))
        if stats.permanentlyFailed > 0 then
            self:Print(format("Permanently Failed: %d", stats.permanentlyFailed))
        end
        if stats.processingErrors > 0 then
            self:Print(format("Processing Errors: %d", stats.processingErrors))
        end
    else
        self:Print("Unknown command. Use /nagdatadebug for help.")
    end
end

--- Handle enhanced debug commands for DataManager
--- @param input string The command input
function DataManager:HandleEnhancedDebugCommand(input)
    local cmd, arg = input:match("^(%S+)%s*(.*)$")
    if not cmd or cmd == "" then
        self:Print("NAG Data Debug Commands:")
        self:Print("  /nagdata help                        -- Show this help")
        self:Print("  /nagdata talent <id>                 -- Debug specific talent")
        self:Print("  /nagdata spell <id>                  -- Debug specific spell")
        self:Print("  /nagdata item <id>                   -- Debug specific item")
        self:Print("  /nagdata tierset <id>                -- Debug specific tier set")
        self:Print("  /nagdata battlepet <id>              -- Debug specific battle pet")
        self:Print("  /nagdata path <path>                 -- Debug data at specific path")
        self:Print("  /nagdata resolve <category> <value>  -- Debug type resolution")
        self:Print("  /nagdata types                       -- Show all type registries")
        self:Print("  /nagdata errors                      -- Show recent error patterns")
        self:Print("  /nagdata stats                       -- Show processing statistics")
        return
    end

    cmd = cmd:lower()
    if cmd == "talent" and arg ~= "" then
        self:DebugTalent(tonumber(arg))
    elseif cmd == "spell" and arg ~= "" then
        self:DebugSpell(tonumber(arg))
    elseif cmd == "item" and arg ~= "" then
        self:DebugItem(tonumber(arg))
    elseif cmd == "tierset" and arg ~= "" then
        self:DebugTierSet(tonumber(arg))
    elseif cmd == "battlepet" and arg ~= "" then
        self:DebugBattlePet(tonumber(arg))
    elseif cmd == "path" and arg ~= "" then
        self:DebugPath(arg)
    elseif cmd == "resolve" and arg ~= "" then
        local category, value = arg:match("^(%S+)%s+(.+)$")
        if category and value then
            self:DebugTypeResolution(category, value)
        else
            self:Print("Usage: /nagdata resolve <category> <value>")
        end
    elseif cmd == "types" then
        self:DebugTypeRegistries()
    elseif cmd == "errors" then
        self:DebugErrorPatterns()
    elseif cmd == "stats" then
        self:DebugProcessingStats()
    else
        self:Print("Unknown command. Use '/nagdata help' for help.")
    end
end

function DataManager:NAG_VERSION_DATA_SELECTED(message)
    DataManager:Debug("NAG_VERSION_DATA_SELECTED: RECEIVED! Starting data processing...")
    -- Keep readiness semantics strict across reload/re-init paths.
    -- Data is not ready until onComplete sets dataProcessed=true.
    self.dataProcessed = false

    if ns.data then
        local startTime = debugprofilestop()

        DataManager:Debug("NAG_VERSION_DATA_SELECTED: DataWalker processing started")
        -- Use completion callback to handle post-processing tasks
        DataWalker:Walk(ns.data, ProcessorsV2, {
            onComplete = function(stats)
                local endTime = debugprofilestop()
                local elapsedMs = endTime - startTime

                -- Format time nicely (ms if < 1000, seconds if >= 1000)
                local timeStr
                if elapsedMs < 1000 then
                    timeStr = format("%dms", elapsedMs)
                else
                    local seconds = elapsedMs / 1000
                    timeStr = format("%.2fs", seconds)
                end

                -- Build statistics summary
                local processedCount = stats and stats.processed or 0
                local errorCount = stats and stats.errors and stats.errors.count or 0
                local skippedCount = stats and stats.skipped and stats.skipped.count or 0

                -- Always log processing time at Info level
                local summary = format("DataManager: Data processing complete in %s", timeStr)
                if processedCount > 0 then
                    summary = summary .. format(" | Processed: %d", processedCount)
                end
                if errorCount > 0 then
                    summary = summary .. format(" | Errors: %d", errorCount)
                end
                if skippedCount > 0 then
                    summary = summary .. format(" | Skipped: %d", skippedCount)
                end

                DataManager:Info(summary)

                -- Additional debug details if debug is enabled
                if DataManager.debug then
                    DataManager:Debug(format("NAG_VERSION_DATA_SELECTED: DataWalker took %dms (detailed)", elapsedMs))
                    if stats and stats.entities then
                        local entityCounts = {}
                        for entityType, count in pairs(stats.entities) do
                            table.insert(entityCounts, format("%s: %d", entityType, count))
                        end
                        if #entityCounts > 0 then
                            DataManager:Debug(format("Entity breakdown: %s", table.concat(entityCounts, ", ")))
                        end
                    end
                end

                -- Auto-disable DataWalker after processing is complete
                -- The module has served its purpose and can be safely disabled
                DataManager:Debug("NAG_VERSION_DATA_SELECTED: DataWalker processing complete - disabling module")
                DataWalker:Disable()

                -- Startup lifecycle contract:
                -- set readiness before broadcasting NAG_EXPANSION_DATA_LOADED so every
                -- data-dependent listener observes a consistent ready state.
                module.dataProcessed = true
                DataManager:Debug("NAG_VERSION_DATA_SELECTED: Data is now ready for access")
                DataManager:Debug("NAG_VERSION_DATA_SELECTED: Sending NAG_EXPANSION_DATA_LOADED message")
                NAG:SendMessage("NAG_EXPANSION_DATA_LOADED")

                -- Memory optimization: Clear merged ns.data after processing complete
                -- All data has been extracted into DataManager.storage, so ns.data is no longer needed
                -- This saves ~30-50% memory by removing the original data structure
                if ns.data then
                    DataManager:Debug("NAG_VERSION_DATA_SELECTED: Clearing ns.data to free memory")
                    ns.data = nil
                end
                -- NOTE: ns.overrides is NOT cleared because RequirementsChecker uses it at runtime
                -- to check spell requirements and apply overrides

                -- NOTE: ns.customHandlers is planned/future infrastructure with no current data or usage
                -- It piggybacks on DataLoader's merge process but isn't connected to DataManager
                -- Clearing it anyway for consistency (saves ~0 bytes since no data exists)
                if ns.customHandlers then
                    DataManager:Debug("NAG_VERSION_DATA_SELECTED: Clearing ns.customHandlers (unused infrastructure)")
                    ns.customHandlers = nil
                end

                -- Schedule delayed summary print
                if NAG:IsDevModeEnabled() then module:ScheduleTimer(function() module:PrintSummary() end, 3) end
            end
        })
    else
        self:Warn("NAG_VERSION_DATA_SELECTED: No data available after version selection")
    end
end

function DataManager:ITEM_DATA_LOAD_RESULT(_, itemID, success)
    if success then
        local entry = self:Get(itemID, self.EntityTypes.ITEM, true) -- Internal call during processing

        if entry and entry.pendingData then
            local processor = ProcessorsV2[self.EntityTypes.ITEM]

            if processor then
                -- Reprocess the data with existing path and raw data
                local processSuccess = processor:processData(entry, itemID)
                if processSuccess then
                    -- Only log success if debug is enabled
                    -- Removed verbose success logging to improve performance

                    if self.debug then
                        DataManager:Debug(format("ITEM_DATA_LOAD_RESULT: Item %d data loaded successfully", itemID))
                    end

                    -- Run post-processing now that item data is available (e.g., GetItemSpell relationships)
                    if processor.postProcess then
                        processor:postProcess(entry, itemID)
                    end

                    -- Clean up path/raw if processing is complete
                    if not entry.pendingData then
                        if entry.path then
                            entry.path = nil
                        end
                        if entry.raw then
                            entry.raw = nil
                        end
                    end
                else
                    DataManager:Debug(format("🔍 ITEM_DATA_LOAD_RESULT: itemID=%d, FAILED: Item data processing failed", itemID))
                end
            else
                DataManager:Debug(format("🔍 ITEM_DATA_LOAD_RESULT: itemID=%d, ERROR: No processor found for EntityTypes.ITEM",
                    itemID))
            end
        end
    else
        -- Only log as debug level since these are likely just invalid items
        DataManager:Debug(format("Failed to load item data for ID: %d", itemID))
        -- Additional failure context
        local entry = self:Get(itemID, self.EntityTypes.ITEM, true) -- Internal call during processing
        if entry then
            -- Only log detailed context for retry attempts or permanent failures
            if entry.failedAttempts and entry.failedAttempts < 3 then
                DataManager:Debug(format("🔍 ITEM_DATA_LOAD_RESULT: itemID=%d, retry attempt %d/3", itemID, entry.failedAttempts))
            elseif entry.permanentlyFailed then
                DataManager:Debug(format("🔍 ITEM_DATA_LOAD_RESULT: itemID=%d, permanently failed - skipping", itemID))
            end
        end
    end
end

--- Sets a spell's position
--- @param self DataManager
--- @param id number The spell ID
--- @param position string|nil The position to set (use DataManager.SpellPosition enum), or nil to reset
function DataManager:SetSpellPosition(id, position)
    -- Validate position if one is provided
    if position and not self.SpellPosition[position] then
        error("Invalid position: " .. tostring(position))
        return
    end

    local entry = self:Get(id, self.EntityTypes.SPELL, true) -- Internal call during processing
    if not entry then
        -- DataManager:Debug(format("🔍 DATAMANAGER_POSITION_DEBUG: Spell %d - No entry found in DataManager", id))
        return
    end

    -- Log the position change
    local oldPosition = entry.position
    --DataManager:Debug(format("🔍 DATAMANAGER_POSITION_DEBUG: Spell %d - Setting position from '%s' to '%s'", id, tostring(oldPosition), tostring(position)))

    -- Remove all position flags first
    for _, pos in pairs(self.SpellPosition) do
        entry.flags[pos] = nil
        entry["Is" .. pos:gsub("^%l", string.upper)] = nil
    end

    -- Only set new position if one was provided
    if position then
        local flag = self.SpellPosition[position]
        entry.flags[flag] = true
        entry["Is" .. flag:gsub("^%l", string.upper)] = true
        entry.position = flag
        --DataManager:Debug(format("🔍 DATAMANAGER_POSITION_DEBUG: Spell %d - Position set successfully to '%s' (flag: '%s')", id, position, flag))
    else
        entry.position = nil -- Clear the position field when resetting
        --DataManager:Debug(format("🔍 DATAMANAGER_POSITION_DEBUG: Spell %d - Position cleared", id))
    end
end

--- @param self DataManager
--- @param setId number The set ID
--- @param count number The piece count
--- @return table|nil The set bonus spells (table of spells or nil)
function DataManager:GetSetBonus(setId, count)
    local bonuses = self:GetRelated(setId, self.EntityTypes.TIERSET, self.EntityTypes.SPELL)
    local result = {}
    if bonuses then
        for spellId, spell in pairs(bonuses) do
            if spell.setBonusCount == count then
                table.insert(result, spell)
            end
        end
    end
    return #result > 0 and result or nil
end

--- @param self DataManager
function DataManager:ProcessPetAbilities()
    -- Skip if not a pet class
    if not PET_CLASSES[NAG.CLASS_FILENAME] then return end

    -- Get current pet info
    local petGUID = UnitGUID("pet")
    if not petGUID then return end

    -- Extract NPC ID from GUID (format: "Creature-0-XXXX-XXXX-XXXX-NPCID")
    local npcId = select(6, strsplit("-", petGUID))
    if not npcId then return end
    npcId = tonumber(npcId)
    if not npcId then return end

    -- Get pet type and family info
    local petType = UnitCreatureFamily("pet")
    if not petType then return end

    -- Process current pet abilities
    local numPetSpells = HasPetSpells()
    if numPetSpells then
        -- Create or update the NPC entry first
        self:Add(npcId, self.EntityTypes.NPC, { "NPCs", "Pet", "Summon" }, {
            raw = {
                name = UnitName("pet"),
                familyName = petType,
                flags = {
                    pet = true,
                    summonable = true
                }
            }
        })

        -- Process pet abilities
        for i = 1, numPetSpells do
            local spellInfo = WoWAPI.GetSpellInfo(i, "pet")
            if spellInfo and spellInfo.spellID then
                local spellId = spellInfo.spellID
                -- Add the spell through the processor with links to NPC
                self:AddSpell(spellId, { "Spells", "Pet", "Action" }, {
                    familyName = petType,
                    npcId = npcId,
                    flags = {
                        pet = true,
                        action = true
                    }
                })
            end
        end
    end
end

--- @param self DataManager
function DataManager:ImportConsumableEnumToId()
    local CATEGORY_KEYWORDS = {
        tinker = "tinker",
        explosive = "explosive",
        conjured = "conjured",
        food = "food",
        potion = "potion",
        elixir = "elixir",
        flask = "flask",
        hands = "hands",
        -- Add more as needed
    }
    local function getCategoryPathFromName(name)
        local path = {}
        if not name then return path end
        local nameLower = name:lower()
        for keyword, flag in pairs(CATEGORY_KEYWORDS) do
            if nameLower:find(keyword) then
                table.insert(path, flag)
            end
        end
        if #path == 0 then
            table.insert(path, "consumable")
        end
        return path
    end

    -- NEW: Extract consumables from ConsumesSpec message fields
    -- Consumables are now stored in field _metadata instead of a separate consumable_enum_to_id table
    local consumableMap = {}
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local consumesSpec = SchemaAccessor and SchemaAccessor:GetMessageSchema("ConsumesSpec") or nil
    if consumesSpec then
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
                                local consumableEntry = {
                                    Simple = {
                                        id = #idValue == 1 and idValue[1] or idValue,
                                        type = idType,
                                        name = entry.export or exportKey,
                                        value = entry.value -- Enum value if present
                                    }
                                }

                                consumableMap[enumKey] = consumableEntry
                            end
                        end
                    end
                end
            end
        end
    end

    -- Process the extracted consumables (same as before)
    for enumKey, entry in pairs(consumableMap) do
        local data = entry.Simple or entry
        if type(data) == "table" and data.id and data.type then
            local idType = type(data.id)
            local schemaName = data.name or enumKey -- Prefer schema name if present
            if idType == "string" or idType == "number" then
                -- Single id
                local path = getCategoryPathFromName(schemaName)
                self:DebugLog("ImportConsumableEnumToId",
                    format("Importing: enumKey=%s, schemaName=%s, id=%s, path=%s", tostring(enumKey),
                        tostring(schemaName), tostring(data.id), table.concat(path, ".")))
                if data.type == "item" then
                    self:AddItem(data.id, path, { flags = { consumable = true } })
                elseif data.type == "spell" then
                    self:AddSpell(data.id, path, { flags = { consumable = true } })
                end
            elseif idType == "table" then
                -- Multiple ids
                for _, singleId in ipairs(data.id) do
                    local path = getCategoryPathFromName(schemaName)
                    self:DebugLog("ImportConsumableEnumToId",
                        format("Importing: enumKey=%s, schemaName=%s, id=%s, path=%s", tostring(enumKey),
                            tostring(schemaName), tostring(singleId), table.concat(path, ".")))
                    if data.type == "item" then
                        self:AddItem(singleId, path, { flags = { consumable = true } })
                    elseif data.type == "spell" then
                        self:AddSpell(singleId, path, { flags = { consumable = true } })
                    end
                end
            else
                DataManager:Warn(format(
                    "Malformed consumable_enum_to_id entry for %s: id is not string/number/table (got %s)",
                    tostring(enumKey), idType))
            end
        else
            DataManager:Warn(format(
                "Malformed consumable_enum_to_id entry for %s: data is not a table or missing id/type", tostring(enumKey)))
        end
    end
    self:Info(format("Imported %d consumable enum entries", TableUtils.Size(consumableMap)))
end

--- Adds an entity to the data store
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type (from DataManager.EntityTypes)
--- @param path table|nil The path components for the entity
--- @param data table|nil Additional data for the entity
--- @return table|boolean|nil The processed entity if successful, false on error
function DataManager:Add(id, entityType, path, data)
    -- Use enhanced pcall to get better error information
    local success, result = ns.pcall(function()
        -- Handle nil id gracefully
        if not id then
            self:Warn("Add called with nil id")
            return false
        end

        -- Handle nil entityType gracefully
        if not entityType then
            self:Warn("Add called with nil entityType")
            return false
        end

        local processor = ProcessorsV2[entityType]
        if not processor then
            DataManager:Warn(format("No processor found for %s", entityType))
            return false
        end
        return processor:process(id, path or { entityType }, data)
    end)

    if not success then
        -- Log the enhanced error information
        self:Error(format("[Add] Enhanced error: %s", result.message or "Unknown error"))
        if result.stack then
            self:Error(format("[Add] Stack trace:\n%s", result.stack))
        end
        if result.arguments then
            self:Error(format("[Add] Arguments: %s", result.arguments))
        end
        return false
    end

    return result
end

function DataManager:AddSpell(id, path, data)
    return self:Add(id, self.EntityTypes.SPELL, path, data)
end

function DataManager:AddItem(id, path, data)
    return self:Add(id, self.EntityTypes.ITEM, path, data)
end

--- Gets an entity by its ID and type
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type (from DataManager.EntityTypes)
--- @param internal boolean|nil If true, bypasses dataReady check for internal processing calls
--- @return table|nil The entity if found
function DataManager:Get(id, entityType, internal)
    -- Safety check: ensure data is ready (unless this is an internal processing call)
    if not internal and not self:IsDataReady() then
        local callStack = debugstack(2, 3, 0) -- Get call stack without this function
        self:Warn(format("[CRUD:read] Data not ready yet! entityType=%s, id=%s\nCall stack:\n%s",
            tostring(entityType), tostring(id), callStack))
        return nil
    end

    -- Safety check: ensure storage is initialized
    if not self.storage then
        local callStack = debugstack(2, 3, 0) -- Get call stack without this function
        self:Warn(format("[CRUD:read] Storage not initialized! entityType=%s, id=%s\nCall stack:\n%s",
            tostring(entityType), tostring(id), callStack))
        return nil
    end

    local processor = ProcessorsV2[entityType]
    if not processor then
        self:Warn(format("[CRUD:read] No processor found for entityType=%s, id=%s",
            tostring(entityType), tostring(id)))
        return nil
    end

    local result = processor:read(id)

    -- Register-on-miss for spells: add rotation/dynamic spell so any Get/GetSpell caller gets it (single place for all paths)
    if not result and entityType == self.EntityTypes.SPELL and type(id) == "number" and id > 0 then
        self._getRegisteringSpell = self._getRegisteringSpell or {}
        if not self._getRegisteringSpell[id] then
            self._getRegisteringSpell[id] = true
            self:AddSpell(id, { "Spells", "Rotation", "Dynamic" })
            result = processor:read(id)
            self._getRegisteringSpell[id] = nil
        end
    end

    -- Normalize spell icon: numeric fileDataID -> texture path for SetTexture (e.g. MoP; item-use spells like 82174)
    if result and entityType == self.EntityTypes.SPELL and type(result.icon) == "number" then
        local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
        local path = GetSpellTexture and GetSpellTexture(id)
        if not path and result.relationships and result.relationships.item then
            for itemId in pairs(result.relationships.item) do
                path = _G.GetItemIcon and _G.GetItemIcon(itemId)
                if path then break end
            end
        end
        if path then
            result.icon = path
        end
    end

    return result
end

--- Gets an item by its ID
--- @param self DataManager
--- @param id number The item ID
--- @return table|nil The item if found
function DataManager:GetItem(id)
    return self:Get(id, self.EntityTypes.ITEM)
end

--- Gets a spell by its ID
--- @param self DataManager
--- @param id number The spell ID
--- @return table|nil The spell if found
function DataManager:GetSpell(id)
    return self:Get(id, self.EntityTypes.SPELL)
end

-- ============================ ACTION IDENTITY (SPELL/ITEM DISAMBIGUATION) ============================
-- Single source for "what is this ID?" and cache keys so spell vs item are not conflated.

--- Whether the item is consumable (used when same ID exists as spell and item).
--- @param itemId number
--- @return boolean
function DataManager:IsItemConsumable(itemId)
    if not itemId or not WoWAPI or not WoWAPI.GetItemInfo then
        return false
    end
    local _, _, _, _, _, itemType = WoWAPI.GetItemInfo(itemId)
    return itemType == "Consumable"
end

--- Prefer item over spell for this ID in the given context (e.g. potions).
--- @param id number
--- @param opts table|nil { preferItemFirst = boolean|nil }
--- @return boolean
function DataManager:GetPreferItemFirst(id, opts)
    if not id then
        return false
    end
    opts = opts or {}
    if opts.preferItemFirst ~= nil then
        return opts.preferItemFirst == true
    end
    local entityItem = self:Get(id, self.EntityTypes.ITEM)
    local entitySpell = self:Get(id, self.EntityTypes.SPELL)
    if entityItem and entitySpell then
        return self:IsItemConsumable(id)
    end
    return entityItem ~= nil
end

--- Build a cache key that includes identity kind so spell and item do not share a slot.
--- @param id number
--- @param context string|nil
--- @param preferItemFirst boolean
--- @return string
function DataManager:BuildIdentityCacheKey(id, context, preferItemFirst)
    local ctx = context or "default"
    local kind = preferItemFirst and "item" or "spell"
    return format("%s:%s:%s", tostring(ctx), kind, tostring(id))
end

--- Resolve canonical action identity for a spell/item ID in a context (cached).
--- @param id number
--- @param context string|nil
--- @param opts table|nil
--- @return table|nil identity { kind, entity, spellId, itemId, displayId, cooldownId, cacheKey, ... }
function DataManager:GetIdentity(id, context, opts)
    if not id then
        return nil
    end
    opts = opts or {}
    local preferItemFirst = self:GetPreferItemFirst(id, opts)
    local cacheKey = self:BuildIdentityCacheKey(id, context, preferItemFirst)
    if self._identityCache[cacheKey] ~= nil then
        return self._identityCache[cacheKey]
    end

    local SpellbookManager = NAG:GetModule("SpellbookManager", true)
    local entityItem = self:Get(id, self.EntityTypes.ITEM)
    local entitySpell = self:Get(id, self.EntityTypes.SPELL)
    local entity
    if preferItemFirst then
        entity = entityItem or entitySpell
    else
        entity = entitySpell or entityItem
    end

    local kind = "unknown"
    local spellId = nil
    local itemId = nil
    local displayId = id
    local cooldownId = nil

    if entity and entity.IsItem then
        kind = "item"
        itemId = (opts.itemId and opts.itemId > 0) and opts.itemId or id
        spellId = (opts.spellId and opts.spellId > 0) and opts.spellId or (entity.spellId or id)
        displayId = itemId
        cooldownId = itemId
        if entity.flags and entity.flags.tinker and entity.itemId then
            cooldownId = entity.itemId
            displayId = entity.itemId
        end
    elseif entity and entity.IsSpell then
        kind = "spell"
        spellId = entity.spellId or id
        if SpellbookManager and SpellbookManager.ResolveEffectiveSpellID then
            spellId = SpellbookManager:ResolveEffectiveSpellID(spellId) or spellId
        end
        itemId = (opts.itemId and opts.itemId > 0) and opts.itemId or nil
        displayId = spellId
        cooldownId = spellId
        if entity.flags and entity.flags.tinker and entity.itemId then
            itemId = entity.itemId
            cooldownId = entity.itemId
        end
    else
        kind = preferItemFirst and "item" or "spell"
        if kind == "item" then
            itemId = id
            spellId = id
            displayId = id
            cooldownId = id
        else
            spellId = id
            if SpellbookManager and SpellbookManager.ResolveEffectiveSpellID then
                spellId = SpellbookManager:ResolveEffectiveSpellID(spellId) or spellId
            end
            displayId = spellId
            cooldownId = spellId
        end
    end

    local identity = {
        rawId = id,
        context = context or "default",
        cacheKey = cacheKey,
        preferItemFirst = preferItemFirst,
        kind = kind,
        entity = entity,
        entitySpell = entitySpell,
        entityItem = entityItem,
        spellId = spellId,
        itemId = itemId,
        displayId = displayId,
        cooldownId = cooldownId,
        canonicalId = (kind == "item" and itemId) or spellId or id,
    }
    self._identityCache[cacheKey] = identity
    return identity
end

--- Cached spell info (WoWAPI.GetSpellInfo) for readiness/snapshot use.
--- @param spellId number
--- @return table|nil
function DataManager:GetCachedSpellInfo(spellId)
    if not spellId then
        return nil
    end
    if self._spellInfoCache[spellId] ~= nil then
        return self._spellInfoCache[spellId]
    end
    local spellInfo = WoWAPI and WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId) or nil
    self._spellInfoCache[spellId] = spellInfo or false
    return spellInfo
end

--- Clear identity and spell-info caches and notify dependent systems.
--- @param reason string|nil
function DataManager:ClearIdentityCaches(reason)
    if self._identityCache then
        wipe(self._identityCache)
    end
    if self._spellInfoCache then
        wipe(self._spellInfoCache)
    end
    if self.debug and reason then
        self:Debug("DataManager: cleared identity caches (%s)", tostring(reason))
    end
    local displayManager = NAG:GetModule("DisplayManager", true)
    if displayManager and displayManager.ClearEntityCache then
        displayManager:ClearEntityCache()
    end
    if NAG.ClearSecondarySpellCache then
        NAG:ClearSecondarySpellCache()
    end
    if NAG.SendMessage then
        NAG:SendMessage("NAG_ACTION_IDENTITY_INVALIDATED", reason)
    end
end

function DataManager:PLAYER_ENTERING_WORLD()
    self:ClearIdentityCaches("PLAYER_ENTERING_WORLD")
end

function DataManager:SPELLS_CHANGED()
    self:ClearIdentityCaches("SPELLS_CHANGED")
end

function DataManager:LEARNED_SPELL_IN_TAB()
    self:ClearIdentityCaches("LEARNED_SPELL_IN_TAB")
end

function DataManager:PLAYER_TALENT_UPDATE()
    self:ClearIdentityCaches("PLAYER_TALENT_UPDATE")
end

function DataManager:ACTIVE_TALENT_GROUP_CHANGED()
    self:ClearIdentityCaches("ACTIVE_TALENT_GROUP_CHANGED")
end

function DataManager:PLAYER_EQUIPMENT_CHANGED()
    self:ClearIdentityCaches("PLAYER_EQUIPMENT_CHANGED")
end

function DataManager:NAG_SPEC_UPDATED()
    self:ClearIdentityCaches("NAG_SPEC_UPDATED")
end

function DataManager:NAG_TALENTS_UPDATED()
    self:ClearIdentityCaches("NAG_TALENTS_UPDATED")
end

-- ============================ END ACTION IDENTITY ============================

--- Pre-register spell IDs found in a rotation string so Cast/GetSpell can resolve them (e.g. Dash 33357).
--- Extracts numeric IDs from NAG:...() call arguments and adds missing ones with path Spells/Rotation/Dynamic.
--- @param self DataManager
--- @param rotationString string The rotation string to scan for spell IDs
function DataManager:RegisterSpellIDsFromRotationString(rotationString)
    if not self:IsDataReady() then
        self:Info("RegisterSpellIDsFromRotationString: early return - DataManager not ready")
        return
    end

    if not rotationString or type(rotationString) ~= "string" then
        self:Info("RegisterSpellIDsFromRotationString: early return - no/invalid rotationString")
        return
    end

    -- Capture must include name AND %b() so we have the args (e.g. "Cast(33357, nil, ...)")
    local spellIds = {}
    local matchCount = 0
    local firstMatches = {}
    for fullCall in rotationString:gmatch("NAG:([%w_.]+%s*%b())") do
        matchCount = matchCount + 1
        if matchCount <= 3 then
            firstMatches[matchCount] = fullCall
        end
        local args = fullCall:match("%b()")
        if args then
            args = args:sub(2, -2) -- Remove parentheses
            for spellId in args:gmatch("(%d+)") do
                local id = tonumber(spellId)
                if id then
                    spellIds[id] = true
                end
            end
        end
    end

    local added = 0
    local alreadyPresent = 0
    for spellId in pairs(spellIds) do
        if not self:GetSpell(spellId) then
            self:AddSpell(spellId, { "Spells", "Rotation", "Dynamic" })
            added = added + 1
            if self.debug then
                self:Debug("RegisterSpellIDsFromRotationString: pre-registered spell ID %d", spellId)
            end
        else
            alreadyPresent = alreadyPresent + 1
        end
    end

    local total = added + alreadyPresent
    self:Info("RegisterSpellIDsFromRotationString: matched %d NAG() calls, %d spell IDs in args, pre-registered %d (already in DataManager: %d)",
        matchCount, total, added, alreadyPresent)
    if matchCount > 0 and #firstMatches > 0 then
        self:Info("RegisterSpellIDsFromRotationString: sample matches: %s", table.concat(firstMatches, " | "))
    end
end

--- Gets a tier set by its ID
--- @param self DataManager
--- @param id number The tier set ID
--- @return table|nil The tier set if found
function DataManager:GetTierSet(id)
    return self:Get(id, self.EntityTypes.TIERSET)
end

--- Gets a talent by its ID
--- @param self DataManager
--- @param id number The talent ID
--- @return table|nil The talent if found
function DataManager:GetTalent(id)
    return self:Get(id, self.EntityTypes.TALENT)
end

--- Gets the spell ID for a specific rank of a talent
--- @param self DataManager
--- @param talentId number The talent ID
--- @param rank number The rank to get (1-3)
--- @return number|nil The spell ID for the requested rank, or nil if not found/invalid
function DataManager:GetTalentSpellId(talentId, rank)
    local talent = self:GetTalent(talentId)
    if not talent then return nil end

    -- Validate rank
    if rank < 1 or rank > (talent.maxRank or 1) then return nil end

    -- Return the spell ID for the requested rank
    return talent["rank" .. rank]
end

--- Gets the maximum rank available for a talent
--- @param self DataManager
--- @param talentId number The talent ID
--- @return number The maximum rank (1-3), or 0 if talent not found
function DataManager:GetTalentMaxRank(talentId)
    local talent = self:GetTalent(talentId)
    return talent and talent.maxRank or 0
end

--- Gets all spell IDs associated with a talent
--- @param self DataManager
--- @param talentId number The talent ID
--- @return table Array of spell IDs for each rank, empty if talent not found
function DataManager:GetTalentSpellIds(talentId)
    local talent = self:GetTalent(talentId)
    if not talent then return {} end

    local spellIds = {}
    for i = 1, talent.maxRank do
        table.insert(spellIds, talent["rank" .. i])
    end
    return spellIds
end

--- Gets talent override information for a spell
--- @param self DataManager
--- @param spellId number The spell ID to check for overrides
--- @return table|nil Override info {talentId, overrideSpellId} or nil if not overridden
function DataManager:GetTalentOverridesForSpell(spellId)
    if not spellId or not DataManager.storage or not DataManager.storage.spellToOverridingTalent then
        return nil
    end

    return DataManager.storage.spellToOverridingTalent[spellId]
end

--- Checks if a spell is currently overridden by an active talent
--- @param self DataManager
--- @param spellId number The spell ID to check
--- @return boolean True if the spell is overridden by an active talent
function DataManager:IsSpellOverriddenByActiveTalent(spellId)
    local overrideInfo = self:GetTalentOverridesForSpell(spellId)
    if not overrideInfo then
        return false
    end

    -- Check if the overriding talent is currently active
    local StateManager = NAG:GetModule("StateManager")
    return StateManager:HasTalent(overrideInfo.talentId)
end

--- Gets all related entities of a specific relationship type
--- @param self DataManager
--- @param id number The source entity ID
--- @param sourceType string The source entity type
--- @param targetType string The target entity type
--- @return table Map of related entities keyed by their IDs
function DataManager:GetRelated(id, sourceType, targetType)
    -- Validate inputs
    if not id or not sourceType or not targetType then
        return {}
    end

    local relationType = getRelationshipType(sourceType, targetType)

    -- Ensure relationships storage is initialized for this relationship type
    if not self.storage.relationships[relationType] then
        return {}
    end

    local relationships = self.storage.relationships[relationType]
    if not relationships or not relationships[id] then return {} end

    -- Return the relationships map directly, which is already keyed by ID
    return relationships[id]
end

--- Checks if two entities have a specific relationship
--- @param self DataManager
--- @param sourceId number The source entity ID
--- @param sourceType string The source entity type
--- @param targetId number The target entity ID
--- @param targetType string The target entity type
--- @return boolean True if the entities have a relationship
function DataManager:HasRelationship(sourceId, sourceType, targetId, targetType)
    -- Use enhanced pcall to get better error information
    local success, result = ns.pcall(function()
        -- Validate inputs
        if not sourceId or not sourceType or not targetId or not targetType then
            return false
        end

        local relationType = getRelationshipType(sourceType, targetType)

        -- Ensure relationships storage is initialized for this relationship type
        if not self.storage.relationships[relationType] then
            return false
        end

        local relationships = self.storage.relationships[relationType]
        local result = false
        if relationships and relationships[sourceId] and relationships[sourceId][targetId] then
            result = true
        end

        -- Debug output to see what's happening
        if self.debug then
            DataManager:Debug(format(
                "[HasRelationship] sourceId=%s, sourceType=%s, targetId=%s, targetType=%s, relationType=%s, result=%s",
                tostring(sourceId), tostring(sourceType), tostring(targetId), tostring(targetType),
                tostring(relationType), tostring(result)))
        end

        return result
    end)

    if not success then
        -- Log the enhanced error information
        self:Error(format("[HasRelationship] Enhanced error: %s", result.message or "Unknown error"))
        if result.stack then
            self:Error(format("[HasRelationship] Stack trace:\n%s", result.stack))
        end
        if result.arguments then
            self:Error(format("[HasRelationship] Arguments: %s", result.arguments))
        end
        return false
    end

    return result
end

--- Gets all relationships of a specific type
--- @param self DataManager
--- @param sourceType string The source entity type
--- @param targetType string The target entity type
--- @return table Map of all relationships of the specified type
function DataManager:GetAllRelationships(sourceType, targetType)
    -- Validate inputs
    if not sourceType or not targetType then
        return {}
    end

    local relationType = getRelationshipType(sourceType, targetType)

    -- Ensure relationships storage is initialized for this relationship type
    if not self.storage.relationships[relationType] then
        return {}
    end

    return self.storage.relationships[relationType] or {}
end

--- Gets an entity by its name with optional flag filtering
--- @param self DataManager
--- @param name string The name to look up
--- @param flags? string|table Optional flag or array of flags to filter by
--- @param matchAll? boolean If true, entry must match all flags (default: true)
--- @return table|nil The entity if found
function DataManager:GetByName(name, flags, matchAll)
    if not name then return nil end

    local entries = self.storage.byName[name]
    if not entries then return nil end

    if not flags then return entries[1] end

    if type(flags) == "string" then
        flags = { flags }
    end

    local matches = {}
    for _, entry in ipairs(entries) do
        local flagMatches = 0
        for _, flag in ipairs(flags) do
            if entry.flags[flag] then
                flagMatches = flagMatches + 1
                if not matchAll then break end
            end
        end

        if (matchAll and flagMatches == #flags) or
            (not matchAll and flagMatches > 0) then
            table.insert(matches, entry)
        end
    end

    return matches[1]
end

--- Gets all entities by name with optional flag filtering
--- @param self DataManager
--- @param name string The name to look up
--- @param flags? string|table Optional flag or array of flags to filter by
--- @param matchAll? boolean If true, entries must match all flags (default: true)
--- @return table Array of matching entities (empty if none found)
function DataManager:GetAllByName(name, flags, matchAll)
    if not name then return {} end

    local entries = self.storage.byName[name]
    if not entries then return {} end

    if not flags then return entries end

    if type(flags) == "string" then
        flags = { flags }
    end

    local result = {}
    for _, entry in ipairs(entries) do
        local matches = 0
        for _, flag in ipairs(flags) do
            if entry.flags[flag] then
                matches = matches + 1
                if not matchAll then break end
            end
        end

        if (matchAll and matches == #flags) or
            (not matchAll and matches > 0) then
            table.insert(result, entry)
        end
    end

    return result
end

--- Checks if an entity has a specific flag
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param flag string The flag to check
--- @return boolean True if the entity has the flag
function DataManager:HasFlag(id, entityType, flag)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    return entity and entity.flags[flag] or false
end

--- Gets all flags for an entity
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @return table Array of flags (empty if none found)
function DataManager:GetFlags(id, entityType)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity then return {} end

    local result = {}
    for flag in pairs(entity.flags) do
        table.insert(result, flag)
    end
    return result
end

--- Gets all entities that have a specific flag
--- @param self DataManager
--- @param flag string The flag to search for
--- @param entityType? string Optional entity type to filter by (from DataManager.EntityTypes)
--- @return table Map of entities that have the specified flag (indexed by ID)
function DataManager:GetAllByFlag(flag, entityType)
    if not flag then return {} end

    -- Get from flag index
    local flagEntries = self.storage.byFlag[flag]
    if not flagEntries then return {} end

    -- If no entity type filter, return all
    if not entityType then
        local result = {}
        for _, entity in ipairs(flagEntries) do
            result[entity.id] = entity
        end
        return result
    end

    -- Filter by entity type
    local result = {}
    for _, entity in ipairs(flagEntries) do
        if entity.entryType == entityType then
            result[entity.id] = entity
        end
    end
    return result
end

--- Gets all entities that have all specified flags
--- @param self DataManager
--- @param flags table Array of flags that entities must have
--- @param entityType? string Optional entity type to filter by (from DataManager.EntityTypes)
--- @return table Map of entities that have all specified flags (indexed by ID)
function DataManager:GetAllByFlags(flags, entityType)
    if not flags or #flags == 0 then return {} end

    -- Start with entities having the first flag
    local result = self:GetAllByFlag(flags[1], entityType)
    if #flags == 1 then return result end

    -- Filter out entities that don't have all other flags
    local toRemove = {}
    for id, entity in pairs(result) do
        for i = 2, #flags do
            if not entity.flags[flags[i]] then
                toRemove[id] = true
                break
            end
        end
    end

    -- Remove entities that didn't match all flags
    for id in pairs(toRemove) do
        result[id] = nil
    end

    return result
end

--- Adds a flag to an entity
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param flag string The flag to add
--- @return boolean True if the flag was added, false otherwise
function DataManager:AddFlag(id, entityType, flag)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity or not flag then return false end
    if entity.flags[flag] then return true end    -- Already present
    entity.flags[flag] = true
    -- Update flag index
    self.storage.byFlag[flag] = self.storage.byFlag[flag] or {}
    table.insert(self.storage.byFlag[flag], entity)
    return true
end

--- Removes a flag from an entity
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param flag string The flag to remove
--- @return boolean True if the flag was removed, false otherwise
function DataManager:RemoveFlag(id, entityType, flag)
    local entity = self:Get(id, entityType, true)  -- Internal call during processing
    if not entity or not flag then return false end
    if not entity.flags[flag] then return true end -- Already absent
    entity.flags[flag] = nil
    -- Remove from flag index
    local flagList = self.storage.byFlag[flag]
    if flagList then
        for i = #flagList, 1, -1 do
            if flagList[i] == entity then
                table.remove(flagList, i)
            end
        end
        if #flagList == 0 then self.storage.byFlag[flag] = nil end
    end
    return true
end

--- Sets the full flag set for an entity (replaces all flags)
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param flags table Table of flags to set (keys = flag names, values = true)
--- @return boolean True if the flags were set, false otherwise
function DataManager:SetFlags(id, entityType, flags)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity or type(flags) ~= "table" then return false end
    -- Remove all current flags from index
    for flag in pairs(entity.flags) do
        self:RemoveFlag(id, entityType, flag)
    end
    -- Add new flags
    for flag, value in pairs(flags) do
        if value then self:AddFlag(id, entityType, flag) end
    end
    return true
end

--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param category string The type category
--- @param value any The type value
--- @return boolean True if the entity has the type
function DataManager:HasType(id, entityType, category, value)
    local entry = self:Get(id, entityType, true) -- Internal call during processing
    if not entry or not entry.types or not entry.types[category] then
        return false
    end

    local typeRegistry = Types:GetType(category)
    if not typeRegistry then return false end

    if typeRegistry._allowMultiple then
        return tContains(entry.types[category], value)
    else
        return entry.types[category] == value
    end
end

--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param category string The type category
--- @return any The type value
function DataManager:GetTypes(id, entityType, category)
    local entry = self:Get(id, entityType, true) -- Internal call during processing
    if not entry or not entry.types then return nil end

    if category then
        return entry.types[category]
    end
    return entry.types
end

--- Gets all entities that have a specific type value
--- @param self DataManager
--- @param category string The type category (e.g., "BuffType", "DebuffType")
--- @param value any The type value to look for
--- @param entityType? string Optional entity type to filter by (from DataManager.EntityTypes)
--- @return table Map of entities that have the specified type value (indexed by ID)
function DataManager:GetAllByType(category, value, entityType)
    if not category then return {} end

    -- Get type registry to validate and normalize value
    local typeRegistry = Types:GetType(category)
    if not typeRegistry then
        DataManager:Debug(format("GetAllByType: Invalid type category: %s", tostring(category)))
        return {}
    end

    -- Handle string values by looking up in registry
    if type(value) == "string" then
        value = typeRegistry._values[value:upper()]
    end

    if not value then
        DataManager:Debug(format("GetAllByType: Could not resolve type value: %s", tostring(value)))
        return {}
    end

    -- Get from type index
    local typeIndex = self.storage.byType[category]
    if not typeIndex or not typeIndex[value] then
        return {}
    end

    -- If no entity type filter, return all
    if not entityType then
        return typeIndex[value]
    end

    -- Filter by entity type
    local result = {}
    for id, entity in pairs(typeIndex[value]) do
        if entity.entryType == entityType then
            result[id] = entity
        end
    end
    return result
end

local function formatEntryInfo(entry)
    local info = {
        format("ID: %d", entry[entry.entryType .. "Id"]),
        format("Name: %s", entry.name or "Unknown"),
        format("Type: %s", entry.entryType)
    }

    -- Add position info prominently using enum keys directly
    local position = "none"
    for enumKey, flagValue in pairs(DataManager.SpellPosition) do
        if entry.flags[flagValue] then
            position = enumKey -- Use enum key directly, already in correct case
            break
        end
    end
    table.insert(info, format("Position: %s", position))

    -- Add type info
    if entry.types then
        for category, typeValue in pairs(entry.types) do
            table.insert(info, format("%s: %s", category, typeValue))
        end
    end

    -- Add flags (excluding basic item/spell flags and position flags)
    local flags = {}
    for flag in pairs(entry.flags) do
        -- Skip item/spell flags and position flags
        if flag ~= "item" and flag ~= "spell" and
            not tContains(DataManager.SpellPosition, flag) then
            table.insert(flags, flag)
        end
    end
    if #flags > 0 then
        table.sort(flags)
        table.insert(info, format("Flags: %s", table.concat(flags, ", ")))
    end

    return table.concat(info, " | ")
end

--- Log a summary of processed data and categories
--- @param self DataManager
function DataManager:LogData()
    -- Keep existing summary logging
    self:DebugLog("DataManager", "\n=== DataManager Storage Summary ===")

    -- Verify storage exists
    if not self.storage then
        self:DebugLog("DataManager", "ERROR: Storage not initialized")
        return
    end

    if not self.storage.entities then
        self:DebugLog("DataManager", "ERROR: Entities storage not initialized")
        return
    end

    -- Entity Type Summary
    self:DebugLog("DataManager", "\n=== Entity Counts ===")
    for entityType, storageKey in pairs(self.EntityTypes) do
        local storage = self.storage.entities[storageKey]
        local count = 0
        local pendingCount = 0
        if storage then
            for _, entry in pairs(storage) do
                count = count + 1
                if entry.pendingData then
                    pendingCount = pendingCount + 1
                end
            end
        end
        self:DebugLog("DataManager",
            format("%s: %d entries (%d pending)", entityType:upper(), count, pendingCount))
    end

    -- Relationship Summary
    self:DebugLog("DataManager", "\n=== Relationship Summary ===")
    local relationshipTotal = 0
    for relationType, relationships in pairs(self.storage.relationships) do
        local sourceCount, totalRelationships = 0, 0
        local targetTypes, uniqueTargets = {}, {}

        for sourceId, targets in pairs(relationships) do
            sourceCount = sourceCount + 1
            for targetId, targetEntry in pairs(targets) do
                totalRelationships = totalRelationships + 1
                targetTypes[targetEntry.entryType] = (targetTypes[targetEntry.entryType] or 0) + 1
                uniqueTargets[targetEntry.entryType] = uniqueTargets[targetEntry.entryType] or {}
                uniqueTargets[targetEntry.entryType][targetId] = true
            end
        end

        -- Build target summary string
        local targetSummary = {}
        for type, targets in pairs(uniqueTargets) do
            local count = TableUtils.Size(targets)
            table.insert(targetSummary, format("%s: %d", type:upper(), count))
        end

        -- Print consolidated summary
        print(format("%s: %d total (%d sources) -> %s",
            relationType,
            totalRelationships,
            sourceCount,
            table.concat(targetSummary, ", ")
        ))

        relationshipTotal = relationshipTotal + totalRelationships
    end
    print(format("\nTotal Relationships: %d", relationshipTotal))

    -- Flag Index Summary and Detailed Category Logging
    self:DebugLog("DataManager", "\n=== Flag Index Summary ===")
    local flagCategories = {}
    if self.storage.byFlag then
        -- First pass: Organize flags by category
        for flagPath, entries in pairs(self.storage.byFlag) do
            if entries then
                local category = flagPath:match("^([^%.]+)")
                if category then
                    flagCategories[category] = flagCategories[category] or {}
                    table.insert(flagCategories[category], {
                        path = flagPath,
                        entries = entries,
                        count = #entries
                    })
                end
            end
        end

        -- Second pass: Log summary in DataManager category
        for category, flags in pairs(flagCategories) do
            self:DebugLog("DataManager", format("\n-- %s --", category:upper()))
            table.sort(flags, function(a, b) return a.count > b.count end)
            for _, flag in ipairs(flags) do
                self:DebugLog("DataManager", format("%s: %d entries", flag.path, flag.count))
            end
        end

        -- Third pass: Detailed logging by category
        for category, flags in pairs(flagCategories) do
            -- Use category name as the debug log category
            local categoryName = category:gsub("^%l", string.upper)
            self:DebugLog(categoryName, format("=== %s ===", categoryName))

            -- Sort flags by count
            table.sort(flags, function(a, b) return a.count > b.count end)

            -- Log entries for each flag in this category
            for _, flag in ipairs(flags) do
                if flag.entries and #flag.entries > 0 then
                    self:DebugLog(categoryName,
                        format("\n-- %s (%d entries) --", flag.path, #flag.entries))
                    -- Sort entries by ID for consistent output
                    table.sort(flag.entries, function(a, b)
                        return (a[a.entryType .. "Id"] or 0) < (b[b.entryType .. "Id"] or 0)
                    end)
                    for _, entry in ipairs(flag.entries) do
                        -- Format each field with consistent spacing
                        local fields = {
                            format("[%s:%d]", entry.entryType:upper(), entry[entry.entryType .. "Id"]),
                            format("%-30s", entry.name or "Unknown"),
                            entry.position and format("%-8s", entry.position) or "",
                        }

                        -- Get flags (excluding basic type flags and position flags)
                        local entryFlags = {}
                        for flagName in pairs(entry.flags or {}) do
                            if flagName ~= "item" and flagName ~= "spell" and
                                not tContains(self.SpellPosition, flagName) then
                                table.insert(entryFlags, flagName)
                            end
                        end
                        if #entryFlags > 0 then
                            table.sort(entryFlags)
                            fields[#fields + 1] = format("Flags: %s", table.concat(entryFlags, ", "))
                        end

                        -- Get relationships if any exist
                        if entry.relationships then
                            local rels = {}
                            for targetType, targets in pairs(entry.relationships) do
                                for targetId, relationTypes in pairs(targets) do
                                    local targetEntry = self:Get(targetId, targetType)
                                    if targetEntry then
                                        table.insert(rels, format("%s[%d](%s)",
                                            targetType:upper(),
                                            targetId,
                                            targetEntry.name or "Unknown"))
                                    end
                                end
                            end
                            if #rels > 0 then
                                fields[#fields + 1] = format("Related: %s", table.concat(rels, ", "))
                            end
                        end

                        -- Log the entry with all its details on one line
                        self:DebugLog(categoryName, table.concat(fields, "  "))
                    end
                end
            end
        end
    else
        self:DebugLog("DataManager", "WARNING: Flag index not initialized")
    end

    -- Keep existing name index summary
    self:DebugLog("DataManager", "\n=== Name Index Summary ===")
    local nameCount = 0
    local duplicateNames = 0
    if self.storage.byName then
        for name, entries in pairs(self.storage.byName) do
            nameCount = nameCount + 1
            if #entries > 1 then
                duplicateNames = duplicateNames + 1
                self:DebugLog("DataManager", format("'%s' has %d entries:", name, #entries))
                for _, entry in ipairs(entries) do
                    self:DebugLog("DataManager", format("  - [%s] ID: %d",
                        entry.entryType:upper(),
                        entry[entry.entryType .. "Id"]))
                end
            end
        end
    end
    self:DebugLog("DataManager", format("\nTotal named entries: %d", nameCount))
    self:DebugLog("DataManager", format("Entries with duplicate names: %d", duplicateNames))

    -- Keep existing sample entries
    self:DebugLog("DataManager", "\n=== Sample Entries ===")
    for entityType, storageKey in pairs(self.EntityTypes) do
        local storage = self.storage.entities[storageKey]
        if storage then
            -- Get first non-pending entry as example
            for id, entry in pairs(storage) do
                if not entry.pendingData then
                    self:DebugLog("DataManager", format("\n%s Example (ID: %d):", entityType:upper(), id))
                    self:DebugLog("DataManager", format("Name: %s", entry.name or "N/A"))
                    self:DebugLog("DataManager", format("Path: %s",
                        entry.path and table.concat(entry.path, ".") or "N/A"))

                    -- Log flags
                    local flags = {}
                    for flag in pairs(entry.flags or {}) do
                        table.insert(flags, flag)
                    end
                    if #flags > 0 then
                        table.sort(flags)
                        self:DebugLog("DataManager", format("Flags: %s", table.concat(flags, ", ")))
                    end

                    -- Log relationships
                    if entry.relationships then
                        self:DebugLog("DataManager", "Relationships:")
                        for targetType, targets in pairs(entry.relationships) do
                            for targetId, relationTypes in pairs(targets) do
                                if type(relationTypes) == "table" then
                                    for relationType in pairs(relationTypes) do
                                        self:DebugLog("DataManager", format("  - %s to %s[%d] (%s)",
                                            entry.entryType:upper(),
                                            targetType:upper(),
                                            targetId,
                                            relationType))
                                    end
                                else
                                    -- Handle case where relationTypes is a boolean
                                    self:DebugLog("DataManager", format("  - %s to %s[%d] (direct)",
                                        entry.entryType:upper(),
                                        targetType:upper(),
                                        targetId))
                                end
                            end
                        end
                    end
                    break -- Only show one example per type
                end
            end
        end
    end

    self:DebugLog("DataManager", "\n=== End DataManager Summary ===\n")
end

--- @param self DataManager
function DataManager:PrintRelationships()
    print("\n=== Relationship Storage Summary ===")
    for relationType, relationships in pairs(self.storage.relationships) do
        local count = 0
        local details = {}

        for sourceId, targets in pairs(relationships) do
            local sourceEntry = nil
            -- Find the source entry by checking all entity types
            for _, entityType in pairs(self.EntityTypes) do
                sourceEntry = self:Get(sourceId, entityType)
                if sourceEntry then break end
            end

            if sourceEntry then
                local targetCount = 0
                for targetId, targetEntry in pairs(targets) do
                    targetCount = targetCount + 1
                    table.insert(details, format("  %s[%d](%s) -> %s[%d](%s)",
                        sourceEntry.entryType, sourceId, sourceEntry.name or "Unknown",
                        targetEntry.entryType, targetId, targetEntry.name or "Unknown"))
                end
                count = count + targetCount
            end
        end

        print(format("\n%s Relationships (%d total):", relationType, count))
        table.sort(details)
        for _, detail in ipairs(details) do
            print(detail)
        end
    end
    print("\n=== End Relationship Summary ===\n")
end

--- @param self DataManager
function DataManager:PrintSummary()
    -- Entity Summary
    local grandTotal = 0
    print("\n=== Entity Summary ===")
    for entityType, storageKey in pairs(self.EntityTypes) do
        local storage = self.storage.entities[storageKey]
        local count = 0
        if storage then
            for _ in pairs(storage) do
                count = count + 1
            end
        end
        print(format("%s: %d entries", entityType:upper(), count))
        grandTotal = grandTotal + count
    end
    print(format("Total Entities: %d\n", grandTotal))

    -- Relationship Summary
    print("=== Relationship Summary ===")
    local relationshipTotal = 0
    for relationType, relationships in pairs(self.storage.relationships) do
        local sourceCount, totalRelationships = 0, 0
        local targetTypes, uniqueTargets = {}, {}

        for sourceId, targets in pairs(relationships) do
            sourceCount = sourceCount + 1
            for targetId, targetEntry in pairs(targets) do
                totalRelationships = totalRelationships + 1
                targetTypes[targetEntry.entryType] = (targetTypes[targetEntry.entryType] or 0) + 1
                uniqueTargets[targetEntry.entryType] = uniqueTargets[targetEntry.entryType] or {}
                uniqueTargets[targetEntry.entryType][targetId] = true
            end
        end

        -- Build target summary string
        local targetSummary = {}
        for type, targets in pairs(uniqueTargets) do
            local count = TableUtils.Size(targets)
            table.insert(targetSummary, format("%s: %d", type:upper(), count))
        end

        -- Print consolidated summary
        print(format("%s: %d total (%d sources) -> %s",
            relationType,
            totalRelationships,
            sourceCount,
            table.concat(targetSummary, ", ")
        ))

        relationshipTotal = relationshipTotal + totalRelationships
    end
    print(format("\nTotal Relationships: %d", relationshipTotal))

    -- Type Summary
    print("\n=== Type Summary ===")
    for category, typeValues in pairs(self.storage.byType) do
        local categoryTotal = 0
        local valueStats = {}

        for value, entries in pairs(typeValues) do
            local count = TableUtils.Size(entries)
            categoryTotal = categoryTotal + count
            valueStats[value] = count
        end

        -- Print category summary
        print(format("\n%s (%d total entries):", category, categoryTotal))
        -- Print values directly
        for value, count in pairs(valueStats) do
            print(format("%d: %d entries", value, count))
        end
    end

    -- Flag Summary
    print("\n=== Flag Summary ===")
    local flagTotal = 0
    local flagCounts = {}
    for flag, entries in pairs(self.storage.byFlag) do
        local count = #entries
        flagCounts[flag] = count
        flagTotal = flagTotal + count
    end

    -- Sort flags by count
    local sortedFlags = {}
    for flag, count in pairs(flagCounts) do
        table.insert(sortedFlags, { flag = flag, count = count })
    end
    table.sort(sortedFlags, function(a, b) return a.count > b.count end)

    -- Print top 10 flags
    for i = 1, math.min(10, #sortedFlags) do
        local data = sortedFlags[i]
        print(format("%s: %d entries", data.flag, data.count))
    end
    print(format("\nTotal Flag References: %d\n", flagTotal))
end

--- Gets a talent by its spell ID
--- @param self DataManager
--- @param spellId number The spell ID to look up
--- @return table|nil The talent if found
function DataManager:GetTalentBySpellId(spellId)
    local talentId = self.storage.spellToTalent[spellId]
    if not talentId then return nil end
    return self:GetTalent(talentId)
end

function DataManager:RegisterStaticData(sourceName, dataTables)
    self.staticData = self.staticData or {}
    self.staticData[sourceName] = dataTables
end

--- Deletes an entity from all storage and indices
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @return boolean True if deleted, false otherwise
function DataManager:Delete(id, entityType)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity then return false end
    -- Remove from main storage
    local storage = self.storage.entities[entityType]
    if storage then storage[id] = nil end
    -- Remove from byName
    if entity.name and self.storage.byName[entity.name] then
        for i = #self.storage.byName[entity.name], 1, -1 do
            if self.storage.byName[entity.name][i] == entity then
                table.remove(self.storage.byName[entity.name], i)
            end
        end
        if #self.storage.byName[entity.name] == 0 then self.storage.byName[entity.name] = nil end
    end
    -- Remove from byFlag
    for flag in pairs(entity.flags or {}) do
        self:RemoveFlag(id, entityType, flag)
    end
    -- Remove from byType
    for category, value in pairs(entity.types or {}) do
        if type(value) == "table" then
            for _, v in ipairs(value) do
                self:RemoveType(id, entityType, category, v)
            end
        else
            self:RemoveType(id, entityType, category, value)
        end
    end
    -- Remove all relationships
    for targetType, targets in pairs(entity.relationships or {}) do
        for targetId in pairs(targets) do
            self:RemoveRelationship(id, entityType, targetId, targetType)
        end
    end
    -- Remove reverse relationships
    for relationType, rels in pairs(self.storage.relationships) do
        if rels[id] then
            for targetId, target in pairs(rels[id]) do
                self:RemoveRelationship(id, entityType, targetId, target.entryType)
            end
            rels[id] = nil
        end
    end
    return true
end

--- Updates an entity's fields (shallow merge, does not create if missing)
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param data table Table of fields to update
--- @return boolean True if updated, false otherwise
function DataManager:Update(id, entityType, data)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity or type(data) ~= "table" then return false end
    for k, v in pairs(data) do
        entity[k] = v
    end
    return true
end

--- Adds a type value to an entity
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param category string The type category
--- @param value any The type value
--- @return boolean True if added, false otherwise
function DataManager:AddType(id, entityType, category, value)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity or not category or value == nil then return false end
    entity.types = entity.types or {}
    local typeRegistry = Types:GetType(category)
    if not typeRegistry then return false end
    self.storage.byType[category] = self.storage.byType[category] or {}
    self.storage.byType[category][value] = self.storage.byType[category][value] or {}
    if typeRegistry._allowMultiple then
        entity.types[category] = entity.types[category] or {}
        for _, v in ipairs(entity.types[category]) do if v == value then return true end end
        table.insert(entity.types[category], value)
    else
        if entity.types[category] == value then return true end
        entity.types[category] = value
    end
    self.storage.byType[category][value][id] = entity
    return true
end

--- Removes a type value from an entity
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param category string The type category
--- @param value any The type value
--- @return boolean True if removed, false otherwise
function DataManager:RemoveType(id, entityType, category, value)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity or not category or value == nil then return false end
    local typeRegistry = Types:GetType(category)
    if not typeRegistry then return false end
    if typeRegistry._allowMultiple and entity.types[category] then
        for i = #entity.types[category], 1, -1 do
            if entity.types[category][i] == value then
                table.remove(entity.types[category], i)
            end
        end
        if #entity.types[category] == 0 then entity.types[category] = nil end
    elseif entity.types[category] == value then
        entity.types[category] = nil
    end
    if self.storage.byType[category] and self.storage.byType[category][value] then
        self.storage.byType[category][value][id] = nil
        if next(self.storage.byType[category][value]) == nil then
            self.storage.byType[category][value] = nil
        end
    end
    return true
end

--- Sets all types for an entity (replaces all types)
--- @param self DataManager
--- @param id number The entity ID
--- @param entityType string The entity type
--- @param types table Table of types (category -> value(s))
--- @return boolean True if set, false otherwise
function DataManager:SetTypes(id, entityType, types)
    local entity = self:Get(id, entityType, true) -- Internal call during processing
    if not entity or type(types) ~= "table" then return false end
    -- Remove all current types
    for category, value in pairs(entity.types or {}) do
        if type(value) == "table" then
            for _, v in ipairs(value) do
                self:RemoveType(id, entityType, category, v)
            end
        else
            self:RemoveType(id, entityType, category, value)
        end
    end
    -- Add new types
    for category, value in pairs(types) do
        if type(value) == "table" then
            for _, v in ipairs(value) do
                self:AddType(id, entityType, category, v)
            end
        else
            self:AddType(id, entityType, category, value)
        end
    end
    return true
end

--- Adds a relationship between two entities
--- @param self DataManager
--- @param sourceId number The source entity ID
--- @param sourceType string The source entity type
--- @param targetId number The target entity ID
--- @param targetType string The target entity type
--- @return boolean True if added, false otherwise
function DataManager:AddRelationship(sourceId, sourceType, targetId, targetType)
    local source = self:Get(sourceId, sourceType, true) -- Internal call during processing
    local target = self:Get(targetId, targetType, true) -- Internal call during processing

    if DataManager.debug then
        DataManager:Debug(format("DataManager:AddRelationship - source: %s, target: %s",
            source and "found" or "NOT FOUND", target and "found" or "NOT FOUND"))
    end

    if not source then
        if DataManager.debug then
            DataManager:Debug(format(
                "DataManager:AddRelationship FAILED - source entity not found: %s %d", sourceType, sourceId))
        end
        return false
    end
    if not target then
        if DataManager.debug then
            DataManager:Debug(format(
                "DataManager:AddRelationship FAILED - target entity not found: %s %d", targetType, targetId))
        end
        return false
    end
    local relationType = getRelationshipType(sourceType, targetType)

    self.storage.relationships[relationType] = self.storage.relationships[relationType] or {}
    self.storage.relationships[relationType][sourceId] = self.storage.relationships[relationType][sourceId] or {}

    if self.storage.relationships[relationType][sourceId][targetId] then
        if DataManager.debug then
            DataManager:Debug(format(
                "DataManager:AddRelationship - relationship already exists, returning true"))
        end
        return true
    end


    self.storage.relationships[relationType][sourceId][targetId] = target
    -- Add to source entity
    source.relationships = source.relationships or {}
    source.relationships[targetType] = source.relationships[targetType] or {}
    source.relationships[targetType][targetId] = true
    -- Add reverse
    local reverseType = getRelationshipType(targetType, sourceType)
    self.storage.relationships[reverseType] = self.storage.relationships[reverseType] or {}
    self.storage.relationships[reverseType][targetId] = self.storage.relationships[reverseType][targetId] or {}
    self.storage.relationships[reverseType][targetId][sourceId] = source
    target.relationships = target.relationships or {}
    target.relationships[sourceType] = target.relationships[sourceType] or {}
    target.relationships[sourceType][sourceId] = true

    return true
end

--- Removes a relationship between two entities
--- @param self DataManager
--- @param sourceId number The source entity ID
--- @param sourceType string The source entity type
--- @param targetId number The target entity ID
--- @param targetType string The target entity type
--- @return boolean True if removed, false otherwise
function DataManager:RemoveRelationship(sourceId, sourceType, targetId, targetType)
    local source = self:Get(sourceId, sourceType, true) -- Internal call during processing
    local target = self:Get(targetId, targetType, true) -- Internal call during processing
    if not source or not target then return false end
    local relationType = getRelationshipType(sourceType, targetType)
    if self.storage.relationships[relationType] and self.storage.relationships[relationType][sourceId] then
        self.storage.relationships[relationType][sourceId][targetId] = nil
        if next(self.storage.relationships[relationType][sourceId]) == nil then
            self.storage.relationships[relationType][sourceId] = nil
        end
    end
    if source.relationships and source.relationships[targetType] then
        source.relationships[targetType][targetId] = nil
        if next(source.relationships[targetType]) == nil then
            source.relationships[targetType] = nil
        end
    end
    -- Remove reverse
    local reverseType = getRelationshipType(targetType, sourceType)
    if self.storage.relationships[reverseType] and self.storage.relationships[reverseType][targetId] then
        self.storage.relationships[reverseType][targetId][sourceId] = nil
        if next(self.storage.relationships[reverseType][targetId]) == nil then
            self.storage.relationships[reverseType][targetId] = nil
        end
    end
    if target.relationships and target.relationships[sourceType] then
        target.relationships[sourceType][sourceId] = nil
        if next(target.relationships[sourceType]) == nil then
            target.relationships[sourceType] = nil
        end
    end
    return true
end

function DataManager:GetEnchant(id)
    return self:Get(id, self.EntityTypes.ENCHANT)
end

function DataManager:GetNPC(id)
    return self:Get(id, self.EntityTypes.NPC)
end

function DataManager:GetAura(id)
    return self:Get(id, self.EntityTypes.AURA)
end

function DataManager:GetDot(id)
    return self:Get(id, self.EntityTypes.DOT)
end

function DataManager:GetPet(id)
    return self:Get(id, self.EntityTypes.PET)
end

function DataManager:GetTotem(id)
    return self:Get(id, self.EntityTypes.TOTEM)
end

function DataManager:GetBattlePet(id)
    return self:Get(id, self.EntityTypes.BATTLEPET)
end

--- Debug function to show battle pet details
--- @param self DataManager
--- @param id number The battle pet species ID
function DataManager:DebugBattlePet(id)
    if not id then
        self:Print("Usage: /nagdata battlepet <speciesId>")
        return
    end

    local battlePet = self:GetBattlePet(id)
    if battlePet then
        self:Print(format("Battle Pet %d:", id))
        self:Print(format("  Species ID: %s", tostring(battlePet.speciesId or "N/A")))
        self:Print(format("  Creature ID: %s", tostring(battlePet.creatureId or "N/A")))
        self:Print(format("  Summon Spell ID: %s", tostring(battlePet.summonSpellId or "N/A")))
        self:Print(format("  Pet Type: %s", tostring(battlePet.petTypeEnum or "N/A")))
        self:Print(format("  Description: %s", tostring(battlePet.description or "N/A")))
        self:Print(format("  Source Text: %s", tostring(battlePet.sourceText or "N/A")))
        self:Print(format("  Flags: %s",
            battlePet.flags and table.concat(TableUtils.Keys(battlePet.flags), ", ") or "None"))
        self:Print(format("  Relationships: %s",
            battlePet.relationships and table.concat(TableUtils.Keys(battlePet.relationships), ", ") or "None"))
    else
        self:Print(format("Battle Pet %d not found", id))
    end
end

--- Debug function to show tier set details
--- @param self DataManager
--- @param id number The tier set ID
function DataManager:DebugTierSet(id)
    if not id then
        self:Print("Usage: /nagdata tierset <tiersetId>")
        return
    end

    local tierSet = self:Get(id, self.EntityTypes.TIERSET)
    if tierSet then
        self:Print(format("Tier Set %d:", id))
        self:Print(format("  Name: %s", tostring(tierSet.name or "N/A")))
        self:Print(format("  Tier: %s", tostring(tierSet.tier or "N/A")))
        self:Print(format("  Flags: %s", tierSet.flags and table.concat(TableUtils.Keys(tierSet.flags), ", ") or "None"))
        self:Print(format("  Relationships: %s",
            tierSet.relationships and table.concat(TableUtils.Keys(tierSet.relationships), ", ") or "None"))

        if tierSet.bonuses then
            self:Print("  Bonuses:")
            for count, bonus in pairs(tierSet.bonuses) do
                if bonus.spellId then
                    if type(bonus.spellId) == "table" then
                        self:Print(format("    %dpc: Multiple spells %s", count, table.concat(bonus.spellId, ", ")))
                    else
                        self:Print(format("    %dpc: Spell %d", count, bonus.spellId))
                    end
                elseif bonus.spellIds then
                    self:Print(format("    %dpc: Spells %s", count, table.concat(bonus.spellIds, ", ")))
                end
            end
        else
            self:Print("  Bonuses: None")
        end
    else
        self:Print(format("Tier Set %d not found", id))
    end
end

--- Get storage for a specific entity type
--- @param entityType string The entity type to get storage for
--- @return table|nil The storage table for the entity type, or nil if not found
function DataManager:GetStorage(entityType)
    if not self.storage or not self.storage.entities then
        return nil
    end

    -- Convert enum key to storage key if needed
    local storageKey = type(entityType) == "string" and entityType:lower() or self.EntityTypes[entityType]
    if not storageKey then
        return nil
    end

    return self.storage.entities[storageKey]
end

--- Report processing errors and statistics for DataManager
--- @param self DataManager
function DataManager:ReportProcessingErrors()
    if not self.storage then
        return
    end

    -- Collect error statistics from storage
    local errorStats = {
        totalEntities = 0,
        failedEntities = 0,
        pendingEntities = 0,
        permanentlyFailed = 0,
        processingErrors = 0,
        errorDetails = {}
    }

    -- Analyze each entity type for errors
    for entityType, storageKey in pairs(self.EntityTypes) do
        local storage = self.storage.entities[storageKey]
        if storage then
            for id, entry in pairs(storage) do
                errorStats.totalEntities = errorStats.totalEntities + 1

                -- Check for various failure states
                if entry.permanentlyFailed then
                    errorStats.permanentlyFailed = errorStats.permanentlyFailed + 1
                    table.insert(errorStats.errorDetails, {
                        type = entityType,
                        id = id,
                        error = "Permanently failed",
                        name = entry.name or "Unknown"
                    })
                elseif entry.pendingData then
                    errorStats.pendingEntities = errorStats.pendingEntities + 1
                end

                -- Check for processing failure flags
                if entry._typeProcessingFailed then
                    errorStats.processingErrors = errorStats.processingErrors + 1
                    table.insert(errorStats.errorDetails, {
                        type = entityType,
                        id = id,
                        error = "Type processing failed",
                        name = entry.name or "Unknown"
                    })
                end

                if entry._flagProcessingFailed then
                    errorStats.processingErrors = errorStats.processingErrors + 1
                    table.insert(errorStats.errorDetails, {
                        type = entityType,
                        id = id,
                        error = "Flag processing failed",
                        name = entry.name or "Unknown"
                    })
                end

                if entry._rawDataProcessingFailed then
                    errorStats.processingErrors = errorStats.processingErrors + 1
                    table.insert(errorStats.errorDetails, {
                        type = entityType,
                        id = id,
                        error = "Raw data processing failed",
                        name = entry.name or "Unknown"
                    })
                end

                if entry._relationshipProcessingFailed then
                    errorStats.processingErrors = errorStats.processingErrors + 1
                    table.insert(errorStats.errorDetails, {
                        type = entityType,
                        id = id,
                        error = "Relationship processing failed",
                        name = entry.name or "Unknown"
                    })
                end

                if entry._behaviorAttachmentFailed then
                    errorStats.processingErrors = errorStats.processingErrors + 1
                    table.insert(errorStats.errorDetails, {
                        type = entityType,
                        id = id,
                        error = "Behavior attachment failed",
                        name = entry.name or "Unknown"
                    })
                end

                if entry._positionProcessingFailed then
                    errorStats.processingErrors = errorStats.processingErrors + 1
                    table.insert(errorStats.errorDetails, {
                        type = entityType,
                        id = id,
                        error = "Position processing failed",
                        name = entry.name or "Unknown"
                    })
                end
            end
        end
    end

    -- Calculate total failures
    errorStats.failedEntities = errorStats.permanentlyFailed + errorStats.processingErrors

    -- Only report if there are actual errors
    if errorStats.failedEntities == 0 then
        self:Info("DataManager: No processing errors encountered")
        return
    end

    -- Print error summary header
    self:Info("=== DataManager Processing Error Report ===")
    self:Info(format("Total Entities: %d", errorStats.totalEntities))
    self:Info(format("Failed Entities: %d", errorStats.failedEntities))
    self:Info(format("Pending Entities: %d", errorStats.pendingEntities))
    self:Info(format("Success Rate: %.2f%%",
        ((errorStats.totalEntities - errorStats.failedEntities) / errorStats.totalEntities) * 100))

    -- Break down by failure type
    if errorStats.permanentlyFailed > 0 then
        self:Info(format("Permanently Failed: %d", errorStats.permanentlyFailed))
    end

    if errorStats.processingErrors > 0 then
        self:Info(format("Processing Errors: %d", errorStats.processingErrors))
    end

    -- Show sample error details
    if #errorStats.errorDetails > 0 then
        self:Info("Sample Error Details:")
        for i = 1, math.min(10, #errorStats.errorDetails) do
            local detail = errorStats.errorDetails[i]
            self:Info(format("  %s ID %s (%s): %s",
                detail.type:upper(),
                tostring(detail.id),
                detail.name,
                detail.error))
        end

        if #errorStats.errorDetails > 10 then
            self:Info(format("  ... and %d more errors", #errorStats.errorDetails - 10))
        end
    end

    self:Info("=== End Processing Error Report ===")
end

--- Manually trigger processing error report (useful for debugging)
--- @param self DataManager
function DataManager:TriggerErrorReport()
    if NAG:IsDevModeEnabled() then
        self:Info("Manual processing error report triggered")
        self:ReportProcessingErrors()
    else
        self:Info("Error reporting only available in dev mode")
    end
end

--- Get processing statistics summary
--- @param self DataManager
function DataManager:GetProcessingStats()
    if not self.storage then
        return {
            totalEntities = 0,
            failedEntities = 0,
            pendingEntities = 0,
            successRate = 0
        }
    end

    local stats = {
        totalEntities = 0,
        failedEntities = 0,
        pendingEntities = 0,
        permanentlyFailed = 0,
        processingErrors = 0
    }

    -- Count entities and failures
    for entityType, storageKey in pairs(self.EntityTypes) do
        local storage = self.storage.entities[storageKey]
        if storage then
            for id, entry in pairs(storage) do
                stats.totalEntities = stats.totalEntities + 1

                if entry.permanentlyFailed then
                    stats.permanentlyFailed = stats.permanentlyFailed + 1
                elseif entry.pendingData then
                    stats.pendingEntities = stats.pendingEntities + 1
                end

                -- Check for processing failure flags
                if entry._typeProcessingFailed or entry._flagProcessingFailed or
                    entry._rawDataProcessingFailed or entry._relationshipProcessingFailed or
                    entry._behaviorAttachmentFailed or entry._positionProcessingFailed then
                    stats.processingErrors = stats.processingErrors + 1
                end
            end
        end
    end

    stats.failedEntities = stats.permanentlyFailed + stats.processingErrors
    stats.successRate = stats.totalEntities > 0 and
        ((stats.totalEntities - stats.failedEntities) / stats.totalEntities) * 100 or 0

    return stats
end

-- ============================ TIER SET SPELL VALIDATION ============================

--- Checks if a spell ID is from a tier set
--- @param self DataManager
--- @param spellId number The spell ID to check
--- @return boolean True if the spell is from a tier set
function DataManager:IsTierSetSpell(spellId)
    local spell = self:GetSpell(spellId)
    if not spell then return false end

    -- Check if spell has tierset flag (primary check)
    if spell.flags and spell.flags.tierset then
        return true
    end

    -- Fallback: Check if spell has setBonusCount property (indicates it's from a tier set)
    return spell.setBonusCount ~= nil
end

--- Gets all spells that are from tier sets
--- @param self DataManager
--- @return table Map of tier set spells indexed by spell ID
function DataManager:GetTierSetSpells()
    local result = {}
    local spellStorage = self:GetStorage(self.EntityTypes.SPELL)

    if spellStorage then
        for spellId, spell in pairs(spellStorage) do
            -- Check for tierset flag first (primary check)
            if spell.flags and spell.flags.tierset then
                result[spellId] = spell
                -- Fallback: Check for setBonusCount property
            elseif spell.setBonusCount then
                result[spellId] = spell
            end
        end
    end

    return result
end

--- Gets the tier set that contains a specific spell
--- @param self DataManager
--- @param spellId number The spell ID to look up
--- @return table|nil The tier set entry if found
function DataManager:GetTierSetForSpell(spellId)
    local spell = self:GetSpell(spellId)
    if not spell or not spell.setBonusCount then return nil end

    -- Get tier sets that have relationships to this spell
    local tierSets = self:GetRelated(spellId, self.EntityTypes.SPELL, self.EntityTypes.TIERSET)

    -- Return the first tier set found (there should only be one)
    for tierSetId, tierSet in pairs(tierSets) do
        return tierSet
    end

    return nil
end

--- Gets all tier set spells for a specific piece count
--- @param self DataManager
--- @param pieceCount number The piece count (2, 4, etc.)
--- @return table Array of spells for the specified piece count
function DataManager:GetTierSetSpellsByPieceCount(pieceCount)
    local result = {}
    local tierSetSpells = self:GetTierSetSpells()

    for spellId, spell in pairs(tierSetSpells) do
        if spell.setBonusCount == pieceCount then
            table.insert(result, spell)
        end
    end

    return result
end
