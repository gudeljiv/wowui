--- @module "NAG.Types"
--- Manages type registry and enum system for NAG modules, including schema integration and type normalization utilities.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Table utilities
local TableUtils = ns.TableUtils

local L = ns.AceLocale:GetLocale("NAG", true)
local AceConfigRegistry = ns.AceConfigRegistry

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format -- WoW's optimized version if available

local tinsert = tinsert
local wipe = wipe


local sort = table.sort
local pairs = pairs
local setmetatable = setmetatable
local ipairs = ipairs
local tostring = tostring

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Cache for type lookups to avoid repetitive searching
local TypeLookupCache = {}

--- @class Types: CoreModule
local Types = NAG:CreateModule("Types", nil, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    hidden = function() return not NAG:IsDevModeEnabled() end
})
local module = Types
ns.Types = Types

-- Locals for the options UI viewer
local searchQuery = ""
local searchResults = {}

-- Manual alias table for type name resolution
-- Direction: [Alternative Name] = "Canonical Type Name"
-- When someone calls Types:GetType("Alternative Name"), it returns the "Canonical Type Name"
--
-- Examples:
--   Types:GetType("APLValueRuneSlot") -> returns RuneSlot type
--   Types:GetType("rotation") -> would return RotationType (if uncommented)
--   Types:GetType("Spells") -> returns spells type
local Aliases = {
    -- Schema-derived aliases (map schema names to our canonical names)
    ["APLValueRuneSlot"] = "RuneSlot",         -- Schema name -> Our canonical name
    ["APLValueRuneType"] = "RuneType",         -- Schema name -> Our canonical name
    ["APLValueEclipsePhase"] = "EclipsePhase", -- Schema name -> Our canonical name

    -- Addon-defined type aliases (map schema names to our canonical names)
    ["SpellPosition"] = "SpellPositions",       -- Schema uses singular, we use plural

    -- Uncomment these when RotationType is available:
    ["Rotation"] = "RotationType", -- Common name -> Schema canonical
    ["rotation"] = "RotationType", -- Lowercase -> Schema canonical
}

-- Future type mapping configuration for value conversions
-- This will be used when we need to convert between different value systems
-- Format: [SourceTypeName] = { [SourceValueName] = "TargetValueName" }
local TYPE_MAPPINGS = {
    -- Example for future use:
    -- ["APLValueRuneSlot"] = {
    --     ["SlotLeftFrost"] = "SlotLeftFrost",  -- Same name, different value
    --     ["SlotRightUnholy"] = "SlotRightUnholy", -- Different value mapping
    -- }
}

-- Types where we want to preserve the full value names during schema import
-- Normally, the import process removes type prefixes from enum values:
--   MobTypeBeast -> Beast, MobTypeHumanoid -> Humanoid
-- But for certain types like Flask, we want to keep the full names:
--   FlaskOfTheWinds -> FlaskOfTheWinds, FlaskOfTitanicStrength -> FlaskOfTitanicStrength
local PRESERVE_PREFIX_TYPES = {
    ["Flask"] = true, -- Keep "FlaskOf..." prefix in value names
}

-- Cache for normalized type names to avoid redundant processing
local NormalizedNameCache = {}

-- Utility: Normalize type names for auto-matching
local function NormalizeTypeName(name)
    -- Check cache first
    if NormalizedNameCache[name] then
        return NormalizedNameCache[name]
    end
    -- Remove common APL* prefixes/suffixes and underscores, lowercase
    local norm = name
    norm = norm:gsub("^APLValue", "")
    norm = norm:gsub("^APLAction", "")
    norm = norm:gsub("^APL", "")
    norm = norm:gsub("^NAG", "")
    norm = norm:gsub("^Value", "")
    norm = norm:gsub("^Action", "")
    norm = norm:gsub("Enum$", "")
    norm = norm:gsub("^_+", "")
    norm = norm:gsub("_+", "")
    norm = norm:lower()
    -- Cache the result
    NormalizedNameCache[name] = norm
    return norm
end

-- Utility: Compare two types and detect mismatches
local function CompareTypes(sourceType, targetType, sourceTypeName, targetTypeName)
    if not sourceType or not targetType then
        return { hasMismatch = false, reason = "One or both types are nil" }
    end

    local sourceValues = sourceType._values or {}
    local targetValues = targetType._values or {}

    local mismatches = {}
    local missingInTarget = {}
    local missingInSource = {}
    local valueMismatches = {}

    -- Check for values in source that are missing or different in target
    for sourceName, sourceValue in pairs(sourceValues) do
        if targetValues[sourceName] == nil then
            table.insert(missingInTarget, sourceName)
        elseif targetValues[sourceName] ~= sourceValue then
            table.insert(valueMismatches, {
                name = sourceName,
                sourceValue = sourceValue,
                targetValue = targetValues[sourceName]
            })
        end
    end

    -- Check for values in target that are missing in source
    for targetName, _ in pairs(targetValues) do
        if sourceValues[targetName] == nil then
            table.insert(missingInSource, targetName)
        end
    end

    local hasMismatch = #missingInTarget > 0 or #missingInSource > 0 or #valueMismatches > 0

    return {
        hasMismatch = hasMismatch,
        missingInTarget = missingInTarget,
        missingInSource = missingInSource,
        valueMismatches = valueMismatches,
        sourceTypeName = sourceTypeName,
        targetTypeName = targetTypeName
    }
end

-- Utility: Log type mismatch information
local function LogTypeMismatch(comparison)
    if not comparison.hasMismatch then
        return
    end

    local parts = {}
    table.insert(parts, format("Type mismatch detected between '%s' and '%s':",
        comparison.sourceTypeName, comparison.targetTypeName))

    if #comparison.missingInTarget > 0 then
        table.insert(parts, format("  Values missing in target: %s",
            table.concat(comparison.missingInTarget, ", ")))
    end

    if #comparison.missingInSource > 0 then
        table.insert(parts, format("  Values missing in source: %s",
            table.concat(comparison.missingInSource, ", ")))
    end

    if #comparison.valueMismatches > 0 then
        local valueParts = {}
        for _, mismatch in ipairs(comparison.valueMismatches) do
            table.insert(valueParts, format("%s (%s vs %s)",
                mismatch.name, mismatch.sourceValue, mismatch.targetValue))
        end
        table.insert(parts, format("  Value mismatches: %s", table.concat(valueParts, ", ")))
    end

    module:Info(table.concat(parts, "\n"))
end


-- Constants
local TYPE_CATEGORIES = {
    CHARACTER = "Character",
    BUFFS = "Buffs",
    DEBUFFS = "Debuffs",
    COMBAT = "Combat",
    CLASS = "Class",
    SCHEMA = "Schema" -- New category for schema-derived types
}

-- Type Registry System
local TypeRegistry = {
    _types = {},
    _metadata = {},
    _normalizedLookup = {}, -- Add this new field
    -- Register a new type
    Register = function(self, name, values, metadata)
        if self._types[name] then
            error(format("Type %s already registered", name))
            return nil
        end
        -- Create the type table with metadata
        local typeTable = {
            _name = name,
            _category = metadata.category or "Uncategorized",
            _description = metadata.description or "",
            _values = values,
            _allowMultiple = metadata.allowMultiple or false,
            _reverseValues = {},  -- Add reverse lookup table here
            _prefixedValues = {}, -- Add prefixed values lookup table
        }
        -- Create the actual enum values and build lookup tables
        for key, value in pairs(values) do
            -- Store the clean name version
            typeTable[key] = value
            typeTable._reverseValues[value] = key
            -- Create prefixed version with exact type name
            local prefixedKey = name .. key -- e.g., MobTypeBeast
            typeTable[prefixedKey] = value
            typeTable._prefixedValues[prefixedKey] = value
        end
        -- Add methods
        typeTable.GetName = function() return name end
        typeTable.GetCategory = function() return typeTable._category end
        typeTable.GetDescription = function() return typeTable._description end
        typeTable.GetValues = function() return typeTable._values end
        typeTable.GetNameByValue = function(self, value)
            return self._reverseValues[value]
        end
        typeTable.IsValid = function(self, value)
            -- Check both clean and prefixed values
            for _, v in pairs(self._values) do
                if v == value then return true end
            end
            return false
        end
        typeTable.GetPrefixedValues = function(self)
            return self._prefixedValues
        end
        -- Make it read-only
        setmetatable(typeTable, {
            __index = function(t, k)
                -- First check normal values
                if rawget(t, k) ~= nil then
                    return rawget(t, k)
                end
                -- Then check if it's a prefixed version we don't have yet
                if type(k) == "string" then
                    -- Try to match TypeNameKey pattern (exact type name only)
                    local cleanKey = k:match("^" .. name .. "(.+)$")
                    if cleanKey and t._values[cleanKey] then
                        return t._values[cleanKey]
                    end
                end
                return nil
            end,
            __newindex = function()
                error("Attempt to modify read-only type definition")
            end
        })
        -- Store in registry
        self._types[name] = typeTable
        self._metadata[name] = metadata
        -- Update normalized lookup table if it exists
        if self._normalizedLookup then
            local normalizedName = NormalizeTypeName(name)
            self._normalizedLookup[normalizedName] = name
        end
        -- Clear the type lookup cache when adding a new type
        wipe(TypeLookupCache)
        -- Convenience: also set as direct property on Types module (can be removed/disabled if needed)
        Types[name] = typeTable
        -- Also expose any aliases that point to this type as direct properties
        for aliasName, canonicalName in pairs(Aliases) do
            if canonicalName == name then
                Types[aliasName] = typeTable
            end
        end
        return typeTable
    end,
    -- Get a registered type
    Get = function(self, name)
        local result = self._types[name]
        if not result then
            -- Debug: Log when a type is not found
            local availableTypes = {}
            for typeName, _ in pairs(self._types) do
                table.insert(availableTypes, typeName)
            end
        end
        return result
    end,
    -- Get all types in a category
    GetByCategory = function(self, category)
        local result = {}
        for name, typeInfo in pairs(self._types) do
            if typeInfo._category == category then
                result[name] = typeInfo
            end
        end
        return result
    end,
    -- List all registered types
    List = function(self)
        local result = {}
        for name, _ in pairs(self._types) do
            table.insert(result, name)
        end
        return result
    end,

    -- Debug function to list all registered types with their categories
    DebugList = function(self)
        local result = {}
        for name, typeInfo in pairs(self._types) do
            result[name] = {
                category = typeInfo._category,
                description = typeInfo._description,
                valueCount = typeInfo._values and #typeInfo._values or 0
            }
        end
        return result
    end,
    -- Search for a value across all registered types
    SearchValues = function(self, searchTerm)
        if not searchTerm or type(searchTerm) ~= "string" then return {} end
        local results = {}
        searchTerm = searchTerm:lower()
        for typeName, typeInfo in pairs(self._types) do
            -- Search in clean values
            for valueName, valueId in pairs(typeInfo._values) do
                if valueName:lower():find(searchTerm) then
                    results[typeName] = results[typeName] or {}
                    results[typeName][valueName] = valueId
                end
            end
            -- Search in prefixed values
            for valueName, valueId in pairs(typeInfo._prefixedValues) do
                if valueName:lower():find(searchTerm) then
                    results[typeName] = results[typeName] or {}
                    results[typeName][valueName] = valueId
                end
            end
        end
        return results
    end,
}

-- Register base types
Types.Stat = TypeRegistry:Register("Stat", {
    STRENGTH = 1,
    AGILITY = 2,
    STAMINA = 3,
    INTELLECT = 4,
    SPIRIT = 5,
    HIT = 6,
    CRIT = 7,
    HASTE = 8,
    EXPERTISE = 9,
    DODGE = 10,
    PARRY = 11,
    MASTERY = 12,
    ATTACK_POWER = 13,
    RANGED_ATTACK_POWER = 14,
    SPELL_POWER = 15,
    SPELL_PENETRATION = 16,
    RESILIENCE = 17,
    ARCANE_RESISTANCE = 18,
    FIRE_RESISTANCE = 19,
    FROST_RESISTANCE = 20,
    NATURE_RESISTANCE = 21,
    SHADOW_RESISTANCE = 22,
    ARMOR = 23,
    BONUS_ARMOR = 24,
    HEALTH = 25,
    MANA = 26,
    MP5 = 27
}, {
    category = TYPE_CATEGORIES.CHARACTER,
    description = L["resultsDescription"] or "Primary and secondary character statistics"
})

-- Class ID to SpellClassSet mapping
Types.ClassInfo = TypeRegistry:Register("ClassInfo", {
    WARRIOR = { id = 1, spellClassSet = 4 },
    PALADIN = { id = 2, spellClassSet = 10 },
    HUNTER = { id = 3, spellClassSet = 9 },
    ROGUE = { id = 4, spellClassSet = 8 },
    PRIEST = { id = 5, spellClassSet = 6 },
    DEATHKNIGHT = { id = 6, spellClassSet = 15 },
    SHAMAN = { id = 7, spellClassSet = 11 },
    MAGE = { id = 8, spellClassSet = 3 },
    WARLOCK = { id = 9, spellClassSet = 5 },
    DRUID = { id = 11, spellClassSet = 7 },
    MONK = { id = 10, spellClassSet = 12 }
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = L["MONKDescription"] or "Maps class names to their IDs and SpellClassSet values"
})


Types.BuffType = TypeRegistry:Register("BuffType", {
    STATS = 1,
    SPELL_RESISTANCE = 2,
    STAMINA = 3,
    STRENGTH_AGILITY = 4,
    ATTACK_POWER = 5,
    ATTACK_SPEED = 6,
    MANA = 7,
    MP5 = 8,
    SPELL_POWER = 9,
    SPELL_HASTE = 10,
    DAMAGE = 11,
    CRIT = 12,
    HASTE = 13,
    MAJOR_MANA = 14,
    ARMOR = 15,
    HEROISM = 16,
    MASTERY = 17
}, {
    category = TYPE_CATEGORIES.BUFFS,
    description = L["TypesMONKDescription"] or "Types of raid and group buffs",
    allowMultiple = true
})

Types.DebuffType = TypeRegistry:Register("DebuffType", {
    SPELL_DAMAGE = 1,
    SPELL_CRIT = 2,
    BLEED = 3,
    ARMOR = 4,
    PHYSICAL_DAMAGE = 5,
    PHYSICAL_DAMAGE_REDUCTION = 6,
    ATTACK_SPEED = 7,
    HEALING_REDUCTION = 8,
    CAST_SPEED = 9
}, {
    category = TYPE_CATEGORIES.DEBUFFS,
    description = L["Types of raid and target debuffs"] or "Types of raid and target debuffs",
    allowMultiple = true
})

-- Wowsims has Unknown 0, Earth 1, Air 2, Fire 3, Water 4
Types.TotemType = TypeRegistry:Register("TotemType", {
    Fire = 1,
    Earth = 2,
    Water = 3,
    Air = 4
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = L["Types of shaman totems"] or "Types of shaman totems"
})

Types.StanceType = TypeRegistry:Register("StanceType", {
    Humanoid = 0,
    GhostWolf = 1,
    Shadowform = 1,
    Battle = 1,
    Defensive = 2,
    Berserker = 3,
    Bear = 1,
    Aquatic = 2,
    Cat = 3,
    Travel = 4,
    Moonkin = 5,
    Flight = 6,
    Blood = 1,
    Frost = 2,
    Unholy = 3
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = L["Class stances and forms"] or "Class stances and forms"
})

-- These do not coincide with the wowsims schema, for some reason frost/unholy are swapped
Types.RuneSlot = TypeRegistry:Register("RuneSlot", {
    SlotUnknown = 0,
    SlotLeftBlood = 1,
    SlotRightBlood = 2,
    SlotLeftFrost = 5,
    SlotRightFrost = 6,
    SlotLeftUnholy = 3,
    SlotRightUnholy = 4,
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = L["Death Knight rune slots"] or "Death Knight rune slots"
})


Types.AttackType = TypeRegistry:Register("AttackType", {
    Unknown = 0,
    Any = 1,
    Melee = 2,
    MainHand = 3,
    OffHand = 4,
    Ranged = 5
}, {
    category = TYPE_CATEGORIES.COMBAT,
    description = L["Types of attacks"] or "Types of attacks"
})

Types.CooldownType = TypeRegistry:Register("CooldownType", {
    Unknown = 0,
    Mana = 1,
    DPS = 2,
    Explosive = 4,
    Survival = 8,
}, {
    category = TYPE_CATEGORIES.COMBAT,
    description = "Major cooldown categories (matches sim/core/major_cooldown.go)",
})

-- I do not see these in cata, but are in sod so may need to add if ppl try to use?

Types.SwingType = TypeRegistry:Register("SwingType", {
    MainHand = 3,
    OffHand = 4,
    Ranged = 5
}, {
    category = TYPE_CATEGORIES.COMBAT,
    description = L["Types of weapon swings"] or "Types of weapon swings"
})



Types.RuneType = TypeRegistry:Register("RuneType", {
    RuneUnknown = 0,
    RuneBlood = 1,
    RuneFrost = 2,
    RuneUnholy = 3,
    RuneDeath = 4
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = L["Death Knight rune types"] or "Death Knight rune types"
})



Types.EclipsePhase = TypeRegistry:Register("EclipsePhase", {
    UnknownPhase = 0,
    NeutralPhase = 1,
    SolarPhase = 2,
    LunarPhase = 3,
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = L["Druid Eclipse phases"] or "Druid Eclipse phases"
})



Types.SwapSet = TypeRegistry:Register("SwapSet", {
    Unknown = 0,
    Main = 1,
    Swap1 = 2,
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "SwapSet"
})

-- Spell position constants (addon-defined, not schema-derived)
-- These define where spells appear in the display system
Types.SpellPositions = TypeRegistry:Register("SpellPositions", {
    LEFT = "left",                       -- Left side positions (cooldowns)
    RIGHT = "right",                     -- Right side positions (sequences)
    ABOVE = "above",                     -- Above primary (defensives)
    BELOW = "below",                     -- Below primary (interrupts)
    AOE = "aoe",                         -- AOE position
    PRIMARY = "primary",                 -- Primary/center position (main spell)
    SEQUENCE = "sequence",               -- Sequence system spells
}, {
    category = TYPE_CATEGORIES.CHARACTER,
    description = "Spell position constants for display system"
})


-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function Types:ModuleInitialize()
        self.Registry = TypeRegistry
        -- Schema types will be loaded by APL module when needed
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
-- Helper functions for class validation
function Types:GetSpellClassSet(className)
    local classInfo = self:GetType("ClassInfo")
    if classInfo and classInfo[className] then
        return classInfo[className].spellClassSet
    end
    return nil
end

function Types:GetSpellClassSetById(classId)
    local classInfo = self:GetType("ClassInfo")
    if classInfo then
        for _, info in pairs(classInfo._values) do
            if info.id == classId then
                return info.spellClassSet
            end
        end
    end
    return nil
end

function Types:IsValidSpellClassSet(spellClassSet)
    local classInfo = self:GetType("ClassInfo")
    if classInfo then
        for _, info in pairs(classInfo._values) do
            if info.spellClassSet == spellClassSet then
                return true
            end
        end
    end
    return false
end

function Types:GetClassBySpellClassSet(spellClassSet)
    local classInfo = self:GetType("ClassInfo")
    if classInfo then
        for className, info in pairs(classInfo._values) do
            if info.spellClassSet == spellClassSet then
                return className
            end
        end
    end
    return nil
end

-- Schema integration functions
-- Schema integration functions
function Types:ImportTypesFromSchema(schema, skipExisting)
    if not schema or not schema.enums then
        self:Info("No schema or no enums found in schema")
        return 0
    end

    local count = 0
    local nestedEnumCount = 0

    for enumName, enumValues in pairs(schema.enums) do
        -- Handle nested enums (e.g., "UnitReference.Type")
        local isNested = enumName:find("%.")
        local baseMessageName, shortEnumName

        if isNested then
            baseMessageName, shortEnumName = enumName:match("^(.+)%.(.+)$")
            if not baseMessageName or not shortEnumName then
                self:Warn("Invalid nested enum format: %s", enumName)
                -- Skip this iteration
            else
                -- Process nested enum
                if skipExisting and TypeRegistry:Get(enumName) then
                    if self.debug then
                        self:Debug("Skipping already registered nested enum %s (skipExisting=true)", enumName)
                    end
                else
                    -- Check if this type has an alias and if the aliased type exists
                    local aliasedTypeName = Aliases[enumName]
                    local aliasedType = aliasedTypeName and TypeRegistry:Get(aliasedTypeName)

                    -- Convert incoming enum to the same format for comparison
                    local incomingValues = {}
                    for valueName, valueId in pairs(enumValues) do
                        local cleanName = valueName
                        if not PRESERVE_PREFIX_TYPES[shortEnumName] then
                            local prefix = shortEnumName .. "Type"
                            if cleanName:find("^" .. prefix) then
                                cleanName = cleanName:sub(#prefix + 1)
                            elseif cleanName:find("^" .. shortEnumName) then
                                cleanName = cleanName:sub(#shortEnumName + 1)
                            end
                            if cleanName:sub(1, 1) == "_" then
                                cleanName = cleanName:sub(2)
                            end
                        end
                        incomingValues[cleanName] = valueId
                    end

                    -- Skip if already registered
                    local existingType = TypeRegistry:Get(enumName)
                    if existingType then
                        -- Compare existing vs incoming values
                        local existingKeys = TableUtils.Keys(existingType._values)
                        local incomingKeys = TableUtils.Keys(incomingValues)

                        self:Info("Nested enum %s already registered, skipping", enumName)
                        if self.debug then
                            self:Debug("  Existing values (%d): %s", TableUtils.Size(existingType._values),
                                table.concat(existingKeys, ", "))
                            self:Debug("  Incoming values (%d): %s", TableUtils.Size(incomingValues),
                                table.concat(incomingKeys, ", "))
                            self:Debug("  Stacktrace: %s", debugstack(2, 5, 0))
                        end
                    else
                        -- Check for type mismatches if this type has an alias
                        if aliasedType then
                            -- Create a temporary type object for comparison
                            local tempType = { _values = incomingValues }
                            local comparison = CompareTypes(tempType, aliasedType, enumName, aliasedTypeName)
                            if comparison.hasMismatch then
                                LogTypeMismatch(comparison)
                                self:Info(format(
                                    "Both '%s' and '%s' will be available - use TYPE_MAPPINGS for value conversions if needed",
                                    enumName, aliasedTypeName))
                            end
                        end

                        -- Convert schema enum format to TypeRegistry format
                        local values = {}
                        for valueName, valueId in pairs(enumValues) do
                            -- Only clean up the name if the type isn't in the preserve list
                            local cleanName = valueName
                            if not PRESERVE_PREFIX_TYPES[shortEnumName] then
                                local prefix = shortEnumName .. "Type" -- e.g., "MobType" for "MobTypeBeast"
                                if cleanName:find("^" .. prefix) then
                                    cleanName = cleanName:sub(#prefix + 1)
                                elseif cleanName:find("^" .. shortEnumName) then
                                    cleanName = cleanName:sub(#shortEnumName + 1)
                                end
                                -- If the cleaned name starts with an underscore, remove it
                                if cleanName:sub(1, 1) == "_" then
                                    cleanName = cleanName:sub(2)
                                end
                            end
                            if self.debug then
                                self:Trace("  - Processing nested enum value: %s -> %s (clean: %s)", tostring(valueName),
                                    tostring(valueId), tostring(cleanName))
                            end
                            values[cleanName] = valueId
                        end

                        -- Register the nested enum
                        local metadata = {
                            category = TYPE_CATEGORIES.SCHEMA,
                            description = format("Imported from schema nested enum %s", enumName),
                            source = "schema",
                            isNested = true,
                            baseMessage = baseMessageName,
                            shortName = shortEnumName
                        }

                        TypeRegistry:Register(enumName, values, metadata)
                        count = count + 1
                        nestedEnumCount = nestedEnumCount + 1

                        if self.debug then
                            self:Debug("Registered nested enum %s (base: %s, short: %s) with %d values",
                                enumName, baseMessageName, shortEnumName, TableUtils.Size(values))
                        end
                    end
                end
            end
        else
            -- Handle standalone enums (existing logic)
            shortEnumName = enumName

            -- Skip if already registered and skipExisting is true
            if skipExisting and TypeRegistry:Get(enumName) then
                if self.debug then
                    self:Debug("Skipping already registered type %s (skipExisting=true)", enumName)
                end
            else
                -- Check if this type has an alias and if the aliased type exists
                local aliasedTypeName = Aliases[enumName]
                local aliasedType = aliasedTypeName and TypeRegistry:Get(aliasedTypeName)

                -- Convert incoming enum to the same format for comparison
                local incomingValues = {}
                for valueName, valueId in pairs(enumValues) do
                    local cleanName = valueName
                    if not PRESERVE_PREFIX_TYPES[shortEnumName] then
                        local prefix = shortEnumName .. "Type"
                        if cleanName:find("^" .. prefix) then
                            cleanName = cleanName:sub(#prefix + 1)
                        elseif cleanName:find("^" .. shortEnumName) then
                            cleanName = cleanName:sub(#shortEnumName + 1)
                        end
                        if cleanName:sub(1, 1) == "_" then
                            cleanName = cleanName:sub(2)
                        end
                    end
                    incomingValues[cleanName] = valueId
                end

                -- Skip if already registered
                local existingType = TypeRegistry:Get(enumName)
                if existingType then
                    -- Compare existing vs incoming values
                    local existingKeys = TableUtils.Keys(existingType._values)
                    local incomingKeys = TableUtils.Keys(incomingValues)

                    self:Info("Type %s already registered, skipping", enumName)
                    if self.debug then
                        self:Debug("  Existing values (%d): %s", TableUtils.Size(existingType._values),
                            table.concat(existingKeys, ", "))
                        self:Debug("  Incoming values (%d): %s", table.concat(incomingKeys, ", "))
                        self:Debug("  Stacktrace: %s", debugstack(2, 5, 0))
                    end
                else
                    -- Check for type mismatches if this type has an alias
                    if aliasedType then
                        -- Create a temporary type object for comparison
                        local tempType = { _values = incomingValues }
                        local comparison = CompareTypes(tempType, aliasedType, enumName, aliasedTypeName)
                        if comparison.hasMismatch then
                            LogTypeMismatch(comparison)
                            self:Info(format(
                                "Both '%s' and '%s' will be available - use TYPE_MAPPINGS for value conversions if needed",
                                enumName, aliasedTypeName))
                        end
                    end

                    -- Convert schema enum format to TypeRegistry format
                    local values = {}
                    for valueName, valueId in pairs(enumValues) do
                        -- Only clean up the name if the type isn't in the preserve list
                        local cleanName = valueName
                        if not PRESERVE_PREFIX_TYPES[shortEnumName] then
                            local prefix = shortEnumName .. "Type" -- e.g., "MobType" for "MobTypeBeast"
                            if cleanName:find("^" .. prefix) then
                                cleanName = cleanName:sub(#prefix + 1)
                            elseif cleanName:find("^" .. shortEnumName) then
                                cleanName = cleanName:sub(#shortEnumName + 1)
                            end
                            -- If the cleaned name starts with an underscore, remove it
                            if cleanName:sub(1, 1) == "_" then
                                cleanName = cleanName:sub(2)
                            end
                        end
                        if self.debug then
                            self:Trace("  - Processing enum value: %s -> %s (clean: %s)", tostring(valueName),
                                tostring(valueId), tostring(cleanName))
                        end
                        values[cleanName] = valueId
                    end

                    -- Register the standalone enum
                    local metadata = {
                        category = TYPE_CATEGORIES.SCHEMA,
                        description = format("Imported from schema enum %s", enumName),
                        source = "schema",
                        isNested = false,
                        shortName = shortEnumName
                    }

                    TypeRegistry:Register(enumName, values, metadata)
                    count = count + 1

                    if self.debug then
                        self:Trace("Registered schema type %s with %d values (%s prefix cleaning)",
                            enumName, TableUtils.Size(values),
                            PRESERVE_PREFIX_TYPES[shortEnumName] and "without" or "with")
                    end
                end
            end
        end
    end

    self:Info(format("Imported %d types from schema (%d nested enums)", count, nestedEnumCount))
    return count
end

-- New helper methods for nested enum handling
function Types:GetNestedEnumByShortName(shortName)
    -- Find a nested enum by its short name (e.g., "Type" -> "UnitReference.Type")
    if not shortName then return nil end

    for typeName, typeObj in pairs(TypeRegistry._types) do
        if typeName:find("%.") then
            local _, enumShortName = typeName:match("^(.+)%.(.+)$")
            if enumShortName == shortName then
                return typeObj
            end
        end
    end

    return nil
end

function Types:GetNestedEnumsByMessage(messageName)
    -- Get all nested enums for a specific message type
    if not messageName then return {} end

    local nestedEnums = {}
    for typeName, typeObj in pairs(TypeRegistry._types) do
        if typeName:find("%.") then
            local baseMessage, _ = typeName:match("^(.+)%.(.+)$")
            if baseMessage == messageName then
                nestedEnums[typeName] = typeObj
            end
        end
    end

    return nestedEnums
end

function Types:IsNestedEnum(enumName)
    -- Check if an enum name represents a nested enum
    return enumName and enumName:find("%.") ~= nil
end

function Types:GetEnumShortName(enumName)
    -- Extract the short name from a nested enum (e.g., "UnitReference.Type" -> "Type")
    if not enumName then return nil end

    if enumName:find("%.") then
        return enumName:match("^.+%.(.+)$")
    end

    return enumName
end

function Types:GetEnumBaseMessage(enumName)
    -- Extract the base message name from a nested enum (e.g., "UnitReference.Type" -> "UnitReference")
    if not enumName then return nil end

    if enumName:find("%.") then
        return enumName:match("^(.+)%..+$")
    end

    return nil
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
-- (Schema types are now loaded by APL module during initialization)

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
function Types:GetType(name)
    -- Quick return for nil input
    if not name then return nil end
    -- Check lookup cache first
    if TypeLookupCache[name] then
        return TypeLookupCache[name]
    end
    -- 1. Manual alias
    local canonical = Aliases[name] or name
    if TypeRegistry:Get(canonical) then
        local result = TypeRegistry:Get(canonical)
        TypeLookupCache[name] = result
        return result
    end
    -- 2. Auto-match by normalization
    local norm = NormalizeTypeName(name)
    -- Only perform the expensive loop if we haven't cached normalized lookups
    if not TypeRegistry._normalizedLookup then
        -- Build normalized lookup table once
        TypeRegistry._normalizedLookup = {}
        for regName, typeObj in pairs(TypeRegistry._types) do
            local normalizedName = NormalizeTypeName(regName)
            TypeRegistry._normalizedLookup[normalizedName] = regName
        end
    end
    -- Direct lookup in normalized table
    local matchedName = TypeRegistry._normalizedLookup[norm]
    if matchedName then
        local result = TypeRegistry:Get(matchedName)
        TypeLookupCache[name] = result
        return result
    end
    -- Cache the nil result too
    TypeLookupCache[name] = nil
    return nil
end

function Types:GetTypesByCategory(category)
    return TypeRegistry:GetByCategory(category)
end

function Types:ListTypes()
    return TypeRegistry:List()
end

function Types:IsValidType(typeName, value)
    local typeObj = self:GetType(typeName)
    return typeObj and typeObj:IsValid(value) or false
end

function Types:GetTypeMetadata(typeName)
    local typeObj = self:GetType(typeName)
    if not typeObj then return nil end
    return {
        name = typeObj:GetName(),
        category = typeObj:GetCategory(),
        description = typeObj:GetDescription(),
        values = typeObj:GetValues()
    }
end

-- Expose Aliases for external use (e.g., schema viewer diagnostics)
Types.Aliases = Aliases
Types.NormalizeTypeName = NormalizeTypeName
Types.TYPE_MAPPINGS = TYPE_MAPPINGS

-- Add search method to Types module
function Types:SearchEnumValues(searchTerm)
    return TypeRegistry:SearchValues(searchTerm)
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
function Types:GetOptions()
    -- Helper function to build dynamic search results
    local function GetSearchResults()
        local args = {}
        local results = TypeRegistry:SearchValues(searchQuery)
        if not next(results) then
            args.noresults = {
                type = "description",
                name = format(L["No results found for '%s'"], searchQuery),
            }
        else
            for typeName, values in pairs(results) do
                args[typeName] = {
                    type = "group",
                    name = typeName,
                    args = {}
                }
                local sortedValueNames = {}
                for valueName in pairs(values) do tinsert(sortedValueNames, valueName) end
                sort(sortedValueNames)

                for _, valueName in ipairs(sortedValueNames) do
                    local valueId = values[valueName]
                    args[typeName].args[valueName] = {
                        type = "description",
                        name = format("%s = %s", valueName, tostring(valueId)),
                    }
                end
            end
        end
        return args
    end

    -- Helper function to build the tree of all types
    local function GetAllTypes()
        local args = {}
        local categories = {} -- { categoryName = {typeObj1, typeObj2}, ... }

        -- Group types by category
        for _, typeObj in pairs(TypeRegistry._types) do
            local categoryName = typeObj:GetCategory()
            if not categories[categoryName] then
                categories[categoryName] = {}
            end
            tinsert(categories[categoryName], typeObj)
        end

        -- Get sorted category names
        local sortedCategoryNames = {}
        for catName in pairs(categories) do
            tinsert(sortedCategoryNames, catName)
        end
        sort(sortedCategoryNames)

        -- Build the args table
        for _, categoryName in ipairs(sortedCategoryNames) do
            local typeList = categories[categoryName]
            sort(typeList, function(a, b) return a:GetName() < b:GetName() end)

            args[categoryName] = { type = "group", name = categoryName, childGroups = "tab", args = {} }

            for _, typeObj in ipairs(typeList) do
                local typeName = typeObj:GetName()
                local typeValues = typeObj:GetValues()

                args[categoryName].args[typeName] = {
                    type = "group",
                    name = typeName,
                    desc = typeObj:GetDescription(),
                    args = {}
                }

                local sortedValueNames = {}
                for valueName in pairs(typeValues) do
                    tinsert(sortedValueNames, valueName)
                end
                sort(sortedValueNames)

                for _, valueName in ipairs(sortedValueNames) do
                    local valueId = typeValues[valueName]
                    args[categoryName].args[typeName].args[valueName] = {
                        type = "description",
                        name = format("%s = %s", valueName, tostring(valueId))
                    }
                end
            end
        end
        return args
    end

    -- Options table definition
    return {
        type = "group",
        name = L["Types Viewer"] or "Types Viewer",
        args = {
            viewerHeader = {
                order = 1,
                type = "header",
                name = L["viewerHeader"] or "Type and Enum Viewer",
            },
            viewerDescription = {
                order = 2,
                type = "description",
                name =
                "Browse or search all registered enum types and their values, including those imported from the schema.",
            },
            search = {
                order = 3,
                type = "input",
                name = function() return L["Search"] end,
                desc = function() return L["Search for an enum value across all types."] end,
                get = function() return searchQuery end,
                set = function(info, value)
                    searchQuery = value or ""
                    -- Refresh the options UI to show/hide results
                    AceConfigRegistry:NotifyChange("NAG")
                end,
                width = "full",
            },
            searchResults = {
                order = 4,
                type = "group",
                name = function() return L["Search Results"] end,
                hidden = function() return #searchQuery < 2 end,
                --                args = function() return GetSearchResults() end,
                args = GetSearchResults(),
            },
            allTypes = {
                order = 5,
                type = "group",
                name = function() return L["All Registered Types"] end,
                childGroups = "tab",
                --                hidden = function() return #searchQuery >= 2 end,
                --                args = function() return GetAllTypes() end,
                args = GetAllTypes(),
            },
        }
    }
end
