--- @module "NAG.SchemaUtils"
--- Provides consolidated utility functions for schema operations across NAG modules.
---
--- This module consolidates duplicate utility functions that were previously scattered
--- across APL, SchemaBrowser, SchemaAccessor, and SchemaModifier modules, providing a
--- single source of truth for all schema-related utilities.
---
--- ARCHITECTURE:
--- - Single module containing all schema utility functions
--- - Consistent error handling and validation patterns
--- - Optimized implementations with proper caching
--- - Used by all schema-related modules
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

--- @type Types
local Types

--- @type SchemaAccessor
local SchemaAccessor

--- @type SchemaValidator
local SchemaValidator


local TableUtils = ns.TableUtils
local WoWMaskUtils = ns.WoWMaskUtils
local Version = ns.Version

local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs (using WoW's optimized versions where available)
local tinsert = tinsert

-- Standard Lua functions
local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring

local function isArrayTable(tbl)
    if type(tbl) ~= "table" then
        return false
    end

    local entryCount = 0
    local maxIndex = 0

    for key in pairs(tbl) do
        if type(key) ~= "number" or key < 1 or key % 1 ~= 0 then
            return false
        end
        entryCount = entryCount + 1
        if key > maxIndex then
            maxIndex = key
        end
    end

    return entryCount > 0 and maxIndex == entryCount
end

local function convertTableKeys(self, value, transformer)
    if type(value) ~= "table" then
        return value
    end

    if isArrayTable(value) then
        local result = {}
        for index = 1, #value do
            result[index] = convertTableKeys(self, value[index], transformer)
        end
        return result
    end

    local result = {}
    for key, child in pairs(value) do
        local newKey = key
        if type(key) == "string" then
            local transformed = transformer(self, key)
            if transformed and transformed ~= "" then
                newKey = transformed
            end
        end
        result[newKey] = convertTableKeys(self, child, transformer)
    end

    return result
end

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class SchemaUtils:CoreModule
local SchemaUtils = NAG:CreateModule("SchemaUtils", nil, {
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.PROCESSORS
    }
})
local module = SchemaUtils
ns.SchemaUtils = SchemaUtils

-- Initialize module properties
-- No caches needed - SchemaAccessor handles field caching, Types registry handles enum caching

-- ~~~~~~~~~~ STRING CASE CONVERSION UTILITIES ~~~~~~~~~~

--- Convert snake_case to camelCase
--- @param snake_str string Snake case string
--- @return string|nil Camel case string
function SchemaUtils:SnakeToCamel(snake_str)
    if not snake_str then return nil end

    local components = {}
    for component in snake_str:gmatch("[^_]+") do
        tinsert(components, component)
    end

    local result = components[1]
    for i = 2, #components do
        result = result .. components[i]:gsub("^%l", string.upper)
    end

    return result
end

--- Convert snake_case to PascalCase with acronym handling
--- @param snake_str string Snake case string (e.g., "gcd_is_ready")
--- @return string|nil Pascal case string (e.g., "GCDIsReady")
function SchemaUtils:SnakeToPascal(snake_str)
    if not snake_str then return nil end

    -- First convert to camelCase
    local camelCase = self:SnakeToCamel(snake_str)
    if not camelCase then return nil end

    -- Capitalize first letter to get PascalCase
    local pascalCase = camelCase:gsub("^%l", string.upper)

    -- Apply acronym mappings (Gcd → GCD, Icd → ICD, etc.)
    -- This ensures proper casing for common gaming/WoW acronyms
    local acronymMap = {
        Pvp = "PvP",
        Pve = "PvE",
        Gcd = "GCD",   -- Global Cooldown
        Cpm = "CPM",   -- Casts Per Minute
        Icd = "ICD",   -- Internal Cooldown
        Id = "ID",     -- Identifier
        Hp = "HP",     -- Health Points
        Mp = "MP",     -- Mana Points
        Ttd = "TTD",   -- Time To Die
        Drw = "DRW",   -- Dancing Rune Weapon
--        Ap = "AP",     -- Attack Power
        Cd = "CD",     -- Cooldown
        Aoe = "AOE",   -- Area of Effect
    }

    for pattern, replacement in pairs(acronymMap) do
        pascalCase = pascalCase:gsub(pattern, replacement)
    end

    return pascalCase
end

--- Convert PascalCase to snake_case (alias for CamelToSnake to make intent explicit)
--- @param pascal_str string Pascal case string
--- @return string|nil Snake case string
function SchemaUtils:PascalToSnake(pascal_str)
    if not pascal_str then return nil end
    return self:CamelToSnake(pascal_str)
end

--- Known acronyms for smart snake_case conversion
--- @type table<string, boolean>
local KNOWN_ACRONYMS = {
    -- WoW/Gaming specific acronyms
    ["TTD"] = true,    -- Time To Die
    ["DRW"] = true,    -- Dancing Rune Weapon
    ["HP"] = true,     -- Health Points
    ["MP"] = true,     -- Mana Points
    ["AP"] = true,     -- Attack Power (context-aware)
    ["SP"] = true,     -- Spell Power
    ["CD"] = true,     -- Cooldown
    ["ICD"] = true,    -- Internal Cooldown
    ["GCD"] = true,    -- Global Cooldown
    ["DOT"] = true,    -- Damage Over Time
    ["HOT"] = true,    -- Heal Over Time
    ["AOE"] = true,    -- Area of Effect
    ["DPS"] = true,    -- Damage Per Second
    ["HPS"] = true,    -- Heal Per Second
    ["BUFF"] = true,   -- Buff
    ["DEBUFF"] = true, -- Debuff
    ["UI"] = true,     -- User Interface
    ["API"] = true,    -- Application Programming Interface
    ["JSON"] = true,   -- JavaScript Object Notation
    ["DB"] = true,     -- Database
    ["ID"] = true,     -- Identifier
    ["UUID"] = true,   -- Universally Unique Identifier
    ["GUID"] = true,   -- Globally Unique Identifier
    ["URI"] = true,    -- Uniform Resource Identifier
}

--- Known prefixes that should not be split by acronyms
--- @type table<string, boolean>
local PROTECTED_PREFIXES = {
    ["APL"] = true,    -- APL prefix should be preserved
    ["APLValue"] = true,
    ["APLAction"] = true,
}

local MASK_FIELD_TYPES = {
    procMask = "procMask",
    spellSchool = "spellSchool",
    flags = "spellFlag",
}

--- Convert camelCase to snake_case, intelligently handling acronyms
--- @param camel_str string Camel case string
--- @return string|nil Snake case string
function SchemaUtils:CamelToSnake(camel_str)
    if not camel_str then return nil end

    local result = ""
    local i = 1
    local len = #camel_str

    while i <= len do
        local char = camel_str:sub(i, i)
        local nextChar = i < len and camel_str:sub(i + 1, i + 1) or ""
        local prevChar = i > 1 and camel_str:sub(i - 1, i - 1) or ""

        -- Check if we're at the start of a potential acronym
        if char:match("%u") then
            -- Collect consecutive uppercase letters
            local acronym = ""
            local startPos = i
            while i <= len and camel_str:sub(i, i):match("%u") do
                acronym = acronym .. camel_str:sub(i, i)
                i = i + 1
            end

            -- Check if this matches a protected prefix first
            local isProtected = false
            for prefix, _ in pairs(PROTECTED_PREFIXES) do
                if camel_str:sub(startPos):match("^" .. prefix) then
                    -- This is a protected prefix - don't split it
                    if result ~= "" then
                        result = result .. "_"
                    end
                    result = result .. acronym:lower()
                    isProtected = true
                    break
                end
            end

            if not isProtected then
                -- Check if this is a known acronym (with context awareness for AP)
                local isKnownAcronym = KNOWN_ACRONYMS[acronym]

                -- Special handling for AP acronym - don't treat as acronym if it's part of APL
                if acronym == "AP" and camel_str:sub(startPos):match("^APL") then
                    isKnownAcronym = false
                end

                if isKnownAcronym then
                    -- It's a known acronym - add it as a single unit
                    if result ~= "" then
                        result = result .. "_"
                    end
                    result = result .. acronym:lower()
                else
                    -- Not a known acronym - treat each letter separately
                    -- But first, check if it might be an acronym followed by a word
                    local remaining = camel_str:sub(i)
                    if remaining:match("^%l") then
                        -- There's a lowercase letter after - this might be acronym + word
                        -- Try to find the best split point
                        local bestSplit = self:FindBestAcronymSplit(acronym, remaining)
                        if bestSplit > 0 then
                            -- Found a good split - add the acronym part
                            local acronymPart = acronym:sub(1, bestSplit)
                            if result ~= "" then
                                result = result .. "_"
                            end
                            result = result .. acronymPart:lower()

                            -- Add the remaining part as a word
                            result = result .. "_" .. acronym:sub(bestSplit + 1):lower()
                        else
                            -- No good split found - treat as separate letters
                            for j = 1, #acronym do
                                if result ~= "" then
                                    result = result .. "_"
                                end
                                result = result .. acronym:sub(j, j):lower()
                            end
                        end
                    else
                        -- No lowercase after - treat as separate letters
                        for j = 1, #acronym do
                            if result ~= "" then
                                result = result .. "_"
                            end
                            result = result .. acronym:sub(j, j):lower()
                        end
                    end
                end
            end
        else
            -- Regular camelCase handling
            if char:match("%u") and prevChar:match("%l") then
                -- Transition from lowercase to uppercase
                result = result .. "_" .. char:lower()
            else
                result = result .. char:lower()
            end
            i = i + 1
        end
    end

    -- Clean up any double underscores
    result = result:gsub("__+", "_")
    -- Remove leading underscore if present
    result = result:gsub("^_", "")

    return result
end


--- Recursively convert table keys from snake_case to camelCase
--- @param value any Table (or other type) to convert
--- @return any Converted value with camelCase keys
function SchemaUtils:ConvertKeysToCamelCase(value)
    if value == nil then
        return nil
    end
    return convertTableKeys(self, value, self.SnakeToCamel)
end

--- Recursively convert table keys from camelCase/PascalCase to snake_case
--- @param value any Table (or other type) to convert
--- @return any Converted value with snake_case keys
function SchemaUtils:ConvertKeysToSnakeCase(value)
    if value == nil then
        return nil
    end
    return convertTableKeys(self, value, self.CamelToSnake)
end

-- ============================ ACTION METADATA HELPERS ============================

-- NOTE: ResolveActionMetadata and ResolveValueMetadata have been removed.
-- Use SchemaAccessor:GetMetadataByIdentifier(identifier, nil) for auto-detection.
-- These functions were only used for legacy clause format conversion, which is no longer needed
-- since rotations are stored as rotationString and parsed fresh.

--- Find the best split point for an acronym followed by a word
--- @param acronym string The acronym part
--- @param remaining string The remaining part of the string
--- @return number The best split position (0 if no good split found)
function SchemaUtils:FindBestAcronymSplit(acronym, remaining)
    -- Try to find known acronyms at the beginning of the acronym
    for i = 1, #acronym do
        local prefix = acronym:sub(1, i)
        if KNOWN_ACRONYMS[prefix] then
            return i
        end
    end

    -- If no known acronym found, try common patterns
    -- Look for 2-4 letter prefixes that might be acronyms
    for i = 2, math.min(4, #acronym) do
        local prefix = acronym:sub(1, i)
        -- Check if it looks like an acronym (all uppercase, reasonable length)
        if #prefix >= 2 and #prefix <= 4 then
            return i
        end
    end

    return 0
end

-- ~~~~~~~~~~ ENUM UTILITIES ~~~~~~~~~~
-- Enum access is now handled by SchemaAccessor (which delegates to Types registry)
-- Use SchemaAccessor:GetEnumValues(), SchemaAccessor:ValidateEnumValue()
-- For full enum metadata: Types:GetTypeMetadata(enumName) or Types:GetType(enumName)

-- GetEnumLabel moved to SchemaAccessor:GetEnumLabel() - use that instead

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~
-- Note: Memory management functions (GetMemoryStats, ClearCaches, ResetState) are not needed
-- in SchemaUtils since it has no caches. Use SchemaAccessor for schema-related memory management.

--- Format field type for display
--- @param field table Field information
--- @return string Formatted field type
function SchemaUtils:FormatFieldType(field)
    if not field then return "unknown" end

    local typeStr = field.type or "unknown"

    if field.type == "message" and field.message_type then
        typeStr = field.message_type
    elseif field.type == "enum" and field.enum_type then
        typeStr = field.enum_type
    end

    if field.label == "repeated" then
        typeStr = "array<" .. typeStr .. ">"
    end

    return typeStr
end

--- Format enum values for display
--- @param enumType string The enum type name
--- @param schema table|nil Optional schema data
--- @return string Formatted enum values
function SchemaUtils:FormatEnumValues(enumType, schema)
    if not enumType then return "Enum not found" end

    -- First try to get from registered Types (handles aliases automatically)
    local enumValues = nil
    if Types then
        local typeObj = Types:GetType(enumType)
        if typeObj then
            enumValues = typeObj:GetValues()
        end
    end

    -- Fallback to SchemaAccessor if not found in Types
    if not enumValues or next(enumValues) == nil then
        NAG:Warn("[SchemaUtils] FALLBACK TRACKING: Using SchemaAccessor fallback in GetEnumValuesForUI() (Types registry lookup failed) for enumType='%s'", tostring(enumType))
        if SchemaAccessor then
            enumValues = SchemaAccessor:GetEnumValues(enumType)
        end
    end

    if not enumValues or next(enumValues) == nil then
        return "Enum not found"
    end

    -- Build array of {name, numericValue} pairs for proper numeric sorting
    -- enumValues is {name = numericValue} like {STRENGTH = 1, AGILITY = 2} or {LEFT = "left", RIGHT = "right"}
    local entries = {}
    for name, value in pairs(enumValues) do
        -- Handle both numeric and string enum values
        local numericValue = type(value) == "number" and value or nil
        tinsert(entries, { name = name, value = value, numericValue = numericValue })
    end

    -- Sort by numeric value if available, otherwise by name
    sort(entries, function(a, b)
        if a.numericValue ~= nil and b.numericValue ~= nil then
            return a.numericValue < b.numericValue
        elseif a.numericValue ~= nil then
            return true  -- Numeric values come first
        elseif b.numericValue ~= nil then
            return false
        else
            -- Both are strings, sort alphabetically
            return a.name < b.name
        end
    end)

    -- Format as "value = name" or "numericValue = name" strings
    local result = {}
    for _, entry in ipairs(entries) do
        if entry.numericValue ~= nil then
            tinsert(result, entry.numericValue .. " = " .. entry.name)
        else
            -- String enum value: show as "name = value"
            tinsert(result, entry.name .. " = " .. tostring(entry.value))
        end
    end

    return concat(result, ", ")
end

--- Helper function to count table entries (excluding field_order)
--- @param t table The table to count
--- @return number Count of entries
function SchemaUtils:TableCount(t)
    if not t then return 0 end
    local count = 0
    for k, v in pairs(t) do
        if k ~= "field_order" then
            count = count + 1
        end
    end
    return count
end

--- Decorate metadata tables with human-readable mask information.
--- @param entry table|nil Metadata entry to annotate
--- @return table|nil Annotated entry
function SchemaUtils:AnnotateMaskFields(entry)
    if type(entry) ~= "table" or not WoWMaskUtils then
        return entry
    end

    for field, maskType in pairs(MASK_FIELD_TYPES) do
        local value = entry[field]
        if value ~= nil then
            local tokens, numeric = WoWMaskUtils:GetMaskTokens(maskType, value)
            if numeric ~= nil then
                entry[field .. "Numeric"] = numeric
            end
            if tokens and #tokens > 0 then
                entry[field .. "Tokens"] = tokens
                entry[field .. "Pretty"] = concat(tokens, " | ")
            end
        end
    end

    return entry
end

-- ~~~~~~~~~~ ID EXTRACTION UTILITIES ~~~~~~~~~~
-- ID extraction has been moved to SchemaAccessor for better schema integration
-- Use SchemaAccessor:ExtractIDsFromActionNode(), ExtractIDsFromValueNode(),
-- ExtractIDsFromNode(), ExtractIDsFromRotationNode(), and FormatSpellList()

-- ~~~~~~~~~~ MODULE LIFECYCLE ~~~~~~~~~~
function SchemaUtils:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    Types = NAG:GetModule("Types")
    SchemaAccessor = NAG:GetModule("SchemaAccessor")
    SchemaValidator = NAG:GetModule("SchemaValidator", true)
end

function SchemaUtils:ModuleEnable()
end

--- Called when the module is disabled
--- @param self SchemaUtils
function SchemaUtils:ModuleDisable()
    self:Info("Disabling SchemaUtils")
    -- No cleanup needed - SchemaUtils has no caches or state to reset
end
