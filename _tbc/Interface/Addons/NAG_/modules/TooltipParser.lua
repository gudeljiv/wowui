--[[
    TooltipParser Module
    Clean, robust, and fully localized tooltip parsing system for NAG addon
    Based on StatLogic methodology with proper WoW global string integration

    License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
    Authors: @Rakizi, @Fonsas
    Discord: https://discord.gg/ebonhold
]]

-- ============================ LOCALIZE ============================

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local GetTime = _G.GetTime
local GetLocale = _G.GetLocale
local CreateFrame = _G.CreateFrame
local WoWAPI = ns.WoWAPI
local GetItemInfoInstant = C_Item and C_Item.GetItemInfoInstant or _G.GetItemInfoInstant
local GetItemSpell = C_Item and C_Item.GetItemSpell or _G.GetItemSpell
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff

--- @type DataManager
--- @type Types
local DataManager, Types

-- Utility modules
local StringUtil = ns.StringUtil

-- Standard Lua functions (always available in Lua 5.1, no fallbacks needed)
local format = string.format
local gsub = string.gsub
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- WoW-optimized string functions (always available in WoW)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strsplit = strsplit
local strlenutf8 = strlenutf8

-- WoW-optimized table functions (always available in WoW)
local tinsert = tinsert

-- ============================ PURE HELPER FUNCTIONS ============================
-- String utilities now consolidated in ns.StringUtil
-- Local aliases for backward compatibility with existing code in this module

--- Trim leading and trailing whitespace from a string
--- @param str string String to trim
--- @return string Trimmed string
local function trim(str)
    -- Use StringUtil but keep local function for this module's internal usage
    return StringUtil.Trim(str)
end

--- Clean and parse numeric value (remove thousands separators: commas, spaces, periods)
--- @param str string Numeric string to clean
--- @return number|nil Parsed number or nil if invalid
local function cleanNumber(str)
    -- Use StringUtil.CleanNumber
    return StringUtil.CleanNumber(str)
end

--- Escape pattern characters for regex matching
--- @param pattern string Pattern to escape
--- @return string Escaped pattern
local function escapePattern(pattern)
    -- Use StringUtil.EscapePattern
    return StringUtil.EscapePattern(pattern)
end

--- UTF8-safe string length (uses WoW's built-in strlenutf8)
--- @param str string String to measure
--- @return number Length
local function safeUtf8Len(str)
    if not str then return 0 end
    return strlenutf8(str)
end

--- UTF8-safe substring (WoW has no built-in, use with caution on multi-byte chars)
--- @param str string String to extract from
--- @param start number Start position
--- @param stop number End position
--- @return string Substring
--- @note This uses strsub which may split multi-byte UTF-8 characters incorrectly
local function safeUtf8Sub(str, start, stop)
    if not str then return "" end
    return strsub(str, start, stop)
end

-- ============================ CONSTANTS ============================

-- Cache configuration
local CACHE_MAX_SIZE = 1000
local CACHE_TTL = 300 -- 5 minutes

-- ============================ DEFAULTS ============================

local defaults = {
    global = {
        enabled = true,
        debug = false,
        cacheEnabled = true,
        cacheMaxSize = CACHE_MAX_SIZE,
        cacheTTL = CACHE_TTL
    }
}

-- ============================ MODULE CREATION ============================

--- @class TooltipParser : CoreModule
--- @field cache table Cache for parsed results
--- @field cacheStats table Cache statistics
--- @field statPatterns table Compiled stat patterns
--- @field exclusionPatterns table Exclusion patterns
--- @field wholeTextLookup table Whole text lookup table
--- @field prefixExclusions table Prefix exclusions
local TooltipParser = NAG:CreateModule("TooltipParser", defaults, {
    defaultState = {
        cache = {},
        cacheStats = {
            size = 0,
            maxSize = CACHE_MAX_SIZE,
            enabled = true,
            hits = 0,
            misses = 0
        }
    },
    -- Slash commands for testing
    slashCommands = {
        ["ttparse"] = {
            handler = "TestAuraStatParsing",
            help = "Test spell/buff parsing: /nagdebug ttparse <spellID>",
            root = "nagdebug",
            category = "Data"
        },
        ["ttitem"] = {
            handler = "TestItemParsing",
            help = "Test trinket parsing: /nagdebug ttitem [itemID] (defaults to equipped trinkets)",
            root = "nagdebug",
            category = "Data"
        },
        ["ttclear"] = {
            handler = "ClearCacheCommand",
            help = "Clear tooltip parser cache: /nagdebug ttclear",
            root = "nagdebug",
            category = "Data"
        }
    },
    -- Debug categories
    debugCategories = {ns.DEBUG_CATEGORIES.UTILITIES}
})
ns.TooltipParser = TooltipParser
local module = TooltipParser

-- ============================ PATTERN CONSTANTS ============================
-- These are defined AFTER CreateModule to respect Lua 5.1 ordering

-- Proc trigger patterns (localized via WoW constants)
local PROC_TRIGGER_PATTERNS = {
    ITEM_SPELL_TRIGGER_ONEQUIP or "Equip:",
    ITEM_SPELL_TRIGGER_ONUSE or "Use:",
    ITEM_SPELL_TRIGGER_ONPROC or "Chance on hit:",
}

-- Proc style text patterns (English-only - see .cursor/analysis/CRITICAL-localization-pattern-problem.md)
-- NOTE: These are hardcoded English patterns and will NOT work in other locales
-- FALLBACK: ProximitySearchStatLine() is used as a fallback for non-English locales
--           It searches for numbers near localized stat names (ITEM_MOD_*_SHORT constants)
local PROC_STYLE_PATTERNS = {
    -- Pattern: "increasing your STAT by VALUE" or "increases your STAT by VALUE"
    {pattern = "[Ii]ncreas[ei][sn]g? your ([%w ]+) by ([%d,%.]+)", statPos = 1, valuePos = 2},
    -- Pattern: "gain VALUE STAT"
    {pattern = "[Gg]ain ([%d,%.]+) ([%w ]+)", statPos = 2, valuePos = 1},
    -- Pattern: "your STAT is increased by VALUE"
    {pattern = "[Yy]our ([%w ]+) is increased by ([%d,%.]+)", statPos = 1, valuePos = 2},
    -- Pattern: "grants VALUE STAT" (plural)
    {pattern = "[Gg]rants ([%d,%.]+) ([%w ]+)", statPos = 2, valuePos = 1},
    -- Pattern: "grant VALUE STAT" (singular)
    {pattern = "[Gg]rant ([%d,%.]+) ([%w ]+)", statPos = 2, valuePos = 1},
}

-- ============================ STAT PATTERN SYSTEM ============================

--- Initialize the stat pattern system using WoW global strings
--- Case-sensitive matching: WoW tooltips are generated from locale-specific constants
--- with consistent casing, so we store patterns in their original case for performance.
function TooltipParser:InitializeStatPatterns()
    if self.statIDLookup then
        return -- Already initialized
    end

    if self.debug then
        self:Debug("Initializing stat patterns...")
    end

    -- Direct storage in original case (no lowercasing needed)
    -- WoW tooltip text is consistently cased within each locale
    self.wholeTextLookup = {}
    local W = self.wholeTextLookup

    -- Build exclusion list
    local exclusions = {
        "",
        " \n",
        ITEM_BIND_ON_EQUIP,
        ITEM_BIND_ON_PICKUP,
        ITEM_BIND_ON_USE,
        ITEM_BIND_QUEST,
        ITEM_SOULBOUND,
        ITEM_BIND_TO_ACCOUNT,
        ITEM_BIND_TO_BNETACCOUNT,
        ITEM_STARTS_QUEST,
        ITEM_CANT_BE_DESTROYED,
        ITEM_CONJURED,
        ITEM_DISENCHANT_NOT_DISENCHANTABLE,
        ITEM_REQ_HORDE,
        ITEM_REQ_ALLIANCE,
        INVTYPE_AMMO,
        INVTYPE_HEAD,
        INVTYPE_NECK,
        INVTYPE_SHOULDER,
        INVTYPE_BODY,
        INVTYPE_CHEST,
        INVTYPE_ROBE,
        INVTYPE_WAIST,
        INVTYPE_LEGS,
        INVTYPE_FEET,
        INVTYPE_WRIST,
        INVTYPE_HAND,
        INVTYPE_FINGER,
        INVTYPE_TRINKET,
        INVTYPE_CLOAK,
        INVTYPE_WEAPON,
        INVTYPE_SHIELD,
        INVTYPE_2HWEAPON,
        INVTYPE_WEAPONMAINHAND,
        INVTYPE_WEAPONOFFHAND,
        INVTYPE_HOLDABLE,
        INVTYPE_RANGED,
        INVTYPE_RELIC,
        INVTYPE_TABARD,
        INVTYPE_BAG,
        REFORGED,
        ITEM_HEROIC,
        ITEM_HEROIC_EPIC,
        ITEM_QUALITY0_DESC,
        ITEM_QUALITY1_DESC,
        ITEM_QUALITY2_DESC,
        ITEM_QUALITY3_DESC,
        ITEM_QUALITY4_DESC,
        ITEM_QUALITY5_DESC,
        ITEM_QUALITY6_DESC,
        ITEM_QUALITY7_DESC,
    }

    -- Add exclusions to whole text lookup
    for _, exclusion in pairs(exclusions) do
        if exclusion then
            W[exclusion] = false
        end
    end

    -- Pattern unescaping function
    local function unescape(pattern)
        return pattern:gsub("%%%d?%$?c", ""):gsub("%%%d?%$?[sd]", "%%s"):gsub("%.$", "")
    end

    -- Stat ID lookup - direct storage in original case
    self.statIDLookup = {}
    local L = self.statIDLookup

    -- Short stat patterns (most common)
    local short = {
        [HP] = {"HEALTH"},
        [MP] = {"MANA"},
        [ITEM_MOD_AGILITY_SHORT] = {"AGILITY"},
        [ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT] = {"ARMOR_PENETRATION_RATING"},
        [ITEM_MOD_ATTACK_POWER_SHORT] = {"ATTACK_POWER"},
        [ITEM_MOD_BLOCK_RATING_SHORT] = {"BLOCK_RATING"},
        [ITEM_MOD_BLOCK_VALUE_SHORT] = {"BLOCK_VALUE"},
        [ITEM_MOD_CRIT_MELEE_RATING_SHORT] = {"CRIT_RATING"},
        [ITEM_MOD_CRIT_RANGED_RATING_SHORT] = {"CRIT_RATING"},
        [ITEM_MOD_CRIT_RATING_SHORT] = {"CRIT_RATING"},
        [ITEM_MOD_CRIT_SPELL_RATING_SHORT] = {"CRIT_RATING"},
        [ITEM_MOD_DEFENSE_SKILL_RATING_SHORT] = {"DEFENSE_RATING"},
        [ITEM_MOD_DODGE_RATING_SHORT] = {"DODGE_RATING"},
        [ITEM_MOD_EXPERTISE_RATING_SHORT] = {"EXPERTISE_RATING"},
        [ITEM_MOD_EXTRA_ARMOR_SHORT] = {"BONUS_ARMOR"},
        [ITEM_MOD_FERAL_ATTACK_POWER_SHORT] = {"FERAL_ATTACK_POWER"},
        [ITEM_MOD_HASTE_RATING_SHORT] = {"HASTE_RATING"},
        [ITEM_MOD_HEALTH_REGEN_SHORT] = {"HEALTH_REGEN"},
        [ITEM_MOD_HEALTH_REGENERATION_SHORT] = {"HEALTH_REGEN"},
        [ITEM_MOD_HEALTH_SHORT] = {"HEALTH"},
        [ITEM_MOD_HIT_MELEE_RATING_SHORT] = {"HIT_RATING"},
        [ITEM_MOD_HIT_RANGED_RATING_SHORT] = {"HIT_RATING"},
        [ITEM_MOD_HIT_RATING_SHORT] = {"HIT_RATING"},
        [ITEM_MOD_HIT_SPELL_RATING_SHORT] = {"HIT_RATING"},
        [ITEM_MOD_INTELLECT_SHORT] = {"INTELLECT"},
        [ITEM_MOD_MANA_REGENERATION_SHORT] = {"MANA_REGEN"},
        [ITEM_MOD_MANA_SHORT] = {"MANA"},
        [ITEM_MOD_MASTERY_RATING_SHORT] = {"MASTERY_RATING"},
        [ITEM_MOD_MELEE_ATTACK_POWER_SHORT] = {"ATTACK_POWER"},
        [ITEM_MOD_PARRY_RATING_SHORT] = {"PARRY_RATING"},
        [ITEM_MOD_RANGED_ATTACK_POWER_SHORT] = {"RANGED_ATTACK_POWER"},
        [ITEM_MOD_RESILIENCE_RATING_SHORT] = {"RESILIENCE_RATING"},
        [RESILIENCE] = {"RESILIENCE_RATING"},
        [ITEM_MOD_PVP_POWER_SHORT] = {"PVP_POWER_RATING"},
        [STAT_PVP_POWER] = {"PVP_POWER_RATING"},
        [ITEM_MOD_SPELL_DAMAGE_DONE_SHORT] = {"SPELL_POWER"},
        [ITEM_MOD_SPELL_HEALING_DONE_SHORT] = {"HEALING_POWER"},
        [ITEM_MOD_SPELL_PENETRATION_SHORT] = {"SPELL_PENETRATION"},
        [ITEM_MOD_SPELL_POWER_SHORT] = {"SPELL_POWER"},
        [ITEM_MOD_SPIRIT_SHORT] = {"SPIRIT"},
        [ITEM_MOD_STAMINA_SHORT] = {"STAMINA"},
        [ITEM_MOD_STRENGTH_SHORT] = {"STRENGTH"},
        [SPELL_STATALL] = {"ALL_STATS"},
        [STAT_ATTACK_POWER] = {"ATTACK_POWER"},
        [COMBAT_RATING_NAME9] = {"CRIT_RATING"},
    }

    -- Build patterns for short stats (with pre-compiled Lua patterns)
    for pattern, statTypes in pairs(short) do
        if pattern then
            local pattern1 = "%s " .. pattern
            local pattern2 = pattern .. " %s"
            -- Pre-compile Lua patterns for performance
            L[pattern1] = {
                statTypes = statTypes,
                luaPattern = self:ConvertWoWPatternToLua(pattern1)
            }
            L[pattern2] = {
                statTypes = statTypes,
                luaPattern = self:ConvertWoWPatternToLua(pattern2)
            }
            if self.debug then
                self:Trace("Added short patterns: '%s' and '%s' for stat %s", pattern1, pattern2, statTypes[1])
            end
        end
    end

    -- Long stat patterns
    local long = {
        [ITEM_MOD_AGILITY] = {"AGILITY"},
        [ITEM_MOD_ARMOR_PENETRATION_RATING] = {"ARMOR_PENETRATION_RATING"},
        [ITEM_MOD_ATTACK_POWER] = {"ATTACK_POWER"},
        [ITEM_MOD_BLOCK_RATING] = {"BLOCK_RATING"},
        [ITEM_MOD_BLOCK_VALUE] = {"BLOCK_VALUE"},
        [ITEM_MOD_CRIT_MELEE_RATING] = {"CRIT_RATING"},
        [ITEM_MOD_CRIT_RANGED_RATING] = {"CRIT_RATING"},
        [ITEM_MOD_CRIT_RATING] = {"CRIT_RATING"},
        [ITEM_MOD_CRIT_SPELL_RATING] = {"CRIT_RATING"},
        [ITEM_MOD_DEFENSE_SKILL_RATING] = {"DEFENSE_RATING"},
        [ITEM_MOD_DODGE_RATING] = {"DODGE_RATING"},
        [ITEM_MOD_EXPERTISE_RATING] = {"EXPERTISE_RATING"},
        [ITEM_MOD_EXTRA_ARMOR] = {"BONUS_ARMOR"},
        [ITEM_MOD_FERAL_ATTACK_POWER] = {"FERAL_ATTACK_POWER"},
        [ITEM_MOD_HASTE_RATING] = {"HASTE_RATING"},
        [ITEM_MOD_HEALTH] = {"HEALTH"},
        [ITEM_MOD_HIT_MELEE_RATING] = {"HIT_RATING"},
        [ITEM_MOD_HIT_RANGED_RATING] = {"HIT_RATING"},
        [ITEM_MOD_HIT_RATING] = {"HIT_RATING"},
        [ITEM_MOD_HIT_SPELL_RATING] = {"HIT_RATING"},
        [ITEM_MOD_INTELLECT] = {"INTELLECT"},
        [ITEM_MOD_MANA] = {"MANA"},
        [ITEM_MOD_MASTERY_RATING] = {"MASTERY_RATING"},
        [ITEM_MOD_PARRY_RATING] = {"PARRY_RATING"},
        [ITEM_MOD_RANGED_ATTACK_POWER] = {"RANGED_ATTACK_POWER"},
        [ITEM_MOD_RESILIENCE_RATING] = {"RESILIENCE_RATING"},
        [ITEM_MOD_PVP_POWER] = {"PVP_POWER_RATING"},
        [ITEM_MOD_SPELL_DAMAGE_DONE] = {"SPELL_POWER"},
        [ITEM_MOD_SPELL_HEALING_DONE] = {"HEALING_POWER"},
        [ITEM_MOD_SPELL_PENETRATION] = {"SPELL_PENETRATION"},
        [ITEM_MOD_SPELL_POWER] = {"SPELL_POWER"},
        [ITEM_MOD_SPIRIT] = {"SPIRIT"},
        [ITEM_MOD_STAMINA] = {"STAMINA"},
        [ITEM_MOD_STRENGTH] = {"STRENGTH"},
        [DPS_TEMPLATE] = {"WEAPON_DPS"},
        [ARMOR_TEMPLATE] = {"ARMOR"},
        [SHIELD_BLOCK_TEMPLATE] = {"BLOCK_VALUE"},
        [PLUS_DAMAGE_TEMPLATE] = {"MIN_WEAPON_DAMAGE", "MAX_WEAPON_DAMAGE"},
        [DAMAGE_TEMPLATE] = {"MIN_WEAPON_DAMAGE", "MAX_WEAPON_DAMAGE"},
        [AMMO_DAMAGE_TEMPLATE] = {"WEAPON_DPS"},
    }

    -- Build patterns for long stats (with pre-compiled Lua patterns)
    for pattern, statTypes in pairs(long) do
        if pattern then
            local unescapedPattern = unescape(pattern)
            -- Pre-compile Lua patterns for performance
            L[unescapedPattern] = {
                statTypes = statTypes,
                luaPattern = self:ConvertWoWPatternToLua(unescapedPattern)
            }
        end
    end

    -- Prefix exclusions
    self.prefixExclusions = {}
    local prefixExclusions = {
        SPEED,
        ITEM_DISENCHANT_ANY_SKILL,
        ITEM_DISENCHANT_MIN_SKILL,
        ITEM_DURATION_DAYS,
        ITEM_CREATED_BY,
        ITEM_COOLDOWN_TIME_DAYS,
        ITEM_UNIQUE,
        ITEM_MIN_LEVEL,
        ITEM_MIN_SKILL,
        ITEM_CLASSES_ALLOWED,
        ITEM_RACES_ALLOWED,
        -- NOTE: ITEM_SPELL_TRIGGER_ONUSE and ITEM_SPELL_TRIGGER_ONPROC removed
        -- These should be handled by ClassifyLine() and ParseProcLine(), not excluded
        ITEM_SET_BONUS,
    }

    local excludeLen = 5
    local locale = GetLocale()
    if locale == "koKR" or locale == "zhCN" or locale == "zhTW" then
        excludeLen = 3
    end

    for _, exclusion in pairs(prefixExclusions) do
        if exclusion then
            local len = safeUtf8Len(exclusion)
            if len > excludeLen then
                exclusion = safeUtf8Sub(exclusion, 1, excludeLen)
            elseif len < excludeLen then
                exclusion = exclusion .. (" "):rep(excludeLen - len)
            end
            self.prefixExclusions[exclusion] = true
        end
    end

    -- Count and verify patterns
    local count = 0
    local samplePattern = nil
    for pattern, data in pairs(self.statIDLookup) do
        count = count + 1
        if not samplePattern then
            samplePattern = {pattern = pattern, data = data}
        end
    end

    self:Info("Stat patterns initialized successfully - Total patterns: %d", count)
    if samplePattern then
        self:Info("Sample pattern: '%s' -> statTypes=%s, luaPattern='%s'",
            samplePattern.pattern,
            samplePattern.data.statTypes and samplePattern.data.statTypes[1] or "nil",
            samplePattern.data.luaPattern or "nil")
    end
end

--- Convert WoW GlobalString to Lua pattern with comprehensive format specifier support
--- Handles %d (numbers), %s (strings), and positional args (%1$d, %2$s, etc.)
--- @param globalString string WoW global string like "(%d sec Cooldown)" or "%1$c%2$s %3$s"
--- @return string|nil Lua pattern or nil if invalid
function TooltipParser:ConvertGlobalStringToPattern(globalString)
    if not globalString or type(globalString) ~= "string" then
        return nil
    end

    local pattern = globalString

    -- Use placeholder tokens to protect format specifiers during escaping
    local placeholders = {}
    local placeholderIndex = 0

    local function createPlaceholder(replacement)
        placeholderIndex = placeholderIndex + 1
        local token = "\001PLACEHOLDER" .. placeholderIndex .. "\001"
        placeholders[token] = replacement
        return token
    end

    -- Replace format specifiers with placeholders
    -- Handle positional arguments first (%1$d, %2$s, etc.)
    pattern = pattern:gsub("%%(%d+)%$c", function() return createPlaceholder("") end)
    pattern = pattern:gsub("%%(%d+)%$s", function() return createPlaceholder("([%a%s]+)") end)
    pattern = pattern:gsub("%%(%d+)%$d", function() return createPlaceholder("([%d%., ]+)") end)
    pattern = pattern:gsub("%%(%d+)%$%.(%d+)f", function() return createPlaceholder("([%d%., ]+)") end)

    -- Handle regular format specifiers
    pattern = pattern:gsub("%%s", function() return createPlaceholder("([%a%s]+)") end)
    pattern = pattern:gsub("%%d", function() return createPlaceholder("([%d%., ]+)") end)
    pattern = pattern:gsub("%%%.(%d+)f", function() return createPlaceholder("([%d%., ]+)") end)
    pattern = pattern:gsub("%%c", function() return createPlaceholder("") end)

    -- Strip WoW plural syntax |4singular:plural; for pattern matching
    pattern = pattern:gsub("|4[^;]+;", "")

    -- Escape special regex characters (now safe - format specifiers are protected)
    pattern = pattern:gsub("([%(%)%.%+%-%*%?%[%]%^%$])", "%%%1")

    -- Restore placeholders with actual patterns
    -- NOTE: Use plain text replacement to avoid % in replacement being treated as escape character
    for token, replacement in pairs(placeholders) do
        local startPos, endPos = strfind(pattern, token, 1, true)
        if startPos then
            pattern = pattern:sub(1, startPos - 1) .. replacement .. pattern:sub(endPos + 1)
        end
    end

    -- Lowercase for case-insensitive matching
    pattern = strlower(pattern)

    return pattern
end

--- Extract meaningful keywords from a GlobalString for proximity search
--- Tokenizes the string and filters out common/generic words
--- @param globalString string WoW GlobalString to extract keywords from
--- @return table Array of unique keywords (lowercased)
function TooltipParser:ExtractKeywordsFromGlobalString(globalString)
    if not globalString or type(globalString) ~= "string" then
        return {}
    end

    -- Common words to exclude (articles, pronouns, prepositions, etc.)
    local excludeWords = {
        ["a"] = true, ["an"] = true, ["the"] = true, ["of"] = true, ["to"] = true,
        ["in"] = true, ["on"] = true, ["at"] = true, ["by"] = true, ["for"] = true,
        ["with"] = true, ["from"] = true, ["and"] = true, ["or"] = true, ["but"] = true,
        ["is"] = true, ["are"] = true, ["was"] = true, ["were"] = true, ["be"] = true,
        ["have"] = true, ["has"] = true, ["had"] = true, ["do"] = true, ["does"] = true,
        ["your"] = true, ["you"] = true, ["this"] = true, ["that"] = true, ["it"] = true,
        ["when"] = true, ["if"] = true, ["as"] = true, ["up"] = true,
    }

    -- Extract all words (filter out format specifiers and special chars)
    local cleaned = globalString
    -- Remove format specifiers
    cleaned = cleaned:gsub("%%[%d%.%$]*[csdif]", "")
    -- Remove WoW plural syntax but keep both singular and plural
    local pluralWords = {}
    cleaned = cleaned:gsub("|4([^:]+):([^;]+);", function(singular, plural)
        tinsert(pluralWords, strlower(singular))
        tinsert(pluralWords, strlower(plural))
        return ""
    end)
    -- Remove punctuation and numbers
    cleaned = cleaned:gsub("[%d%p]", " ")

    -- Tokenize into words
    local keywords = {}
    local seen = {}

    -- Add words from cleaned string
    for word in cleaned:gmatch("%S+") do
        word = strlower(trim(word))
        if word ~= "" and not excludeWords[word] and not seen[word] then
            tinsert(keywords, word)
            seen[word] = true
        end
    end

    -- Add plural form words
    for _, word in ipairs(pluralWords) do
        if not seen[word] then
            tinsert(keywords, word)
            seen[word] = true
        end
    end

    return keywords
end

--- Initialize duration, cooldown, and stack patterns from WoW GlobalStrings
--- These patterns work for ALL locales automatically
function TooltipParser:InitializeDurationPatterns()
    self.durationPatterns = {}
    self.cooldownPatterns = {}
    self.stackPatterns = {}
    self.durationKeywords = {}
    self.cooldownKeywords = {}
    self.stackKeywords = {}

    -- Duration patterns from WoW GlobalStrings (auto-localized)
    -- ITEM_DURATION_* patterns (for item tooltips)
    if ITEM_DURATION_SEC then
        self.durationPatterns.itemSec = self:ConvertGlobalStringToPattern(ITEM_DURATION_SEC)
    end
    if ITEM_DURATION_MIN then
        self.durationPatterns.itemMin = self:ConvertGlobalStringToPattern(ITEM_DURATION_MIN)
    end

    -- INT_SPELL_DURATION_* patterns (for spell tooltips)
    if INT_SPELL_DURATION_SEC then
        self.durationPatterns.intSpellSec = self:ConvertGlobalStringToPattern(INT_SPELL_DURATION_SEC)
    end
    if INT_SPELL_DURATION_MIN then
        self.durationPatterns.intSpellMin = self:ConvertGlobalStringToPattern(INT_SPELL_DURATION_MIN)
    end

    -- SPELL_DURATION_* patterns (for proc/buff text like "20 sec" or "2.5 min")
    -- NOTE: Don't use SPELL_DURATION ("Lasts %s") - too generic, %s could be anything
    -- Use specific time unit patterns instead
    if SPELL_DURATION_SEC then
        self.durationPatterns.spellSec = self:ConvertGlobalStringToPattern(SPELL_DURATION_SEC)
    end
    if SPELL_DURATION_MIN then
        self.durationPatterns.spellMin = self:ConvertGlobalStringToPattern(SPELL_DURATION_MIN)
    end
    -- DISABLED: spellHours and spellDays patterns are too greedy and match ANY number
    -- These patterns match random stat values (e.g., "1,710 Strength" matches as "1710 days")
    -- Since buff durations in hours/days are extremely rare, we disable these patterns
    -- to prevent false positives. Fallback patterns (forSec/forMin) handle common cases.
    --[[
    if SPELL_DURATION_HOURS then
        self.durationPatterns.spellHours = self:ConvertGlobalStringToPattern(SPELL_DURATION_HOURS)
    end
    if SPELL_DURATION_DAYS then
        self.durationPatterns.spellDays = self:ConvertGlobalStringToPattern(SPELL_DURATION_DAYS)
    end
    ]]

    -- Extract keywords from SPELL_DURATION for proximity fallback
    if SPELL_DURATION then
        local keywords = self:ExtractKeywordsFromGlobalString(SPELL_DURATION)
        for _, keyword in ipairs(keywords) do
            if keyword == "lasts" or keyword == "last" then
                self.durationKeywords.lasts = keyword
                break
            end
        end
    end

    -- Cooldown patterns from WoW GlobalStrings (auto-localized)
    if ITEM_COOLDOWN_TOTAL_SEC then
        self.cooldownPatterns.totalSec = self:ConvertGlobalStringToPattern(ITEM_COOLDOWN_TOTAL_SEC)
    end
    if ITEM_COOLDOWN_TOTAL_MIN then
        self.cooldownPatterns.totalMin = self:ConvertGlobalStringToPattern(ITEM_COOLDOWN_TOTAL_MIN)
    end
    if ITEM_COOLDOWN_TOTAL_HOURS then
        self.cooldownPatterns.totalHours = self:ConvertGlobalStringToPattern(ITEM_COOLDOWN_TOTAL_HOURS)
    end
    if ITEM_COOLDOWN_TOTAL_DAYS then
        self.cooldownPatterns.totalDays = self:ConvertGlobalStringToPattern(ITEM_COOLDOWN_TOTAL_DAYS)
    end

    -- Stack patterns from WoW GlobalStrings (auto-localized)
    -- NOTE: STACKS GlobalString format is "%d |4Stack:Stacks;" (number BEFORE word)
    -- But real tooltip text is "Stacks up to 5" (word BEFORE number)
    -- So we DON'T create a pattern from STACKS - it won't match real tooltips
    -- Instead, we extract keywords for proximity search and use generic patterns

    -- Extract stack keywords from STACKS GlobalString and generic patterns
    self.stackKeywordsList = {}
    if STACKS then
        local keywords = self:ExtractKeywordsFromGlobalString(STACKS)
        for _, keyword in ipairs(keywords) do
            self.stackKeywordsList[keyword] = true
        end
    end

    -- Add keywords from our generic stack patterns (extract meaningful words)
    local stackPatternStrings = {
        "up to stacks",           -- from "up to X stacks"
        "maximum stacks",         -- from "maximum X stacks"
        "stacking up to",         -- from "stacking up to X"
        "times",                  -- from "X times"
    }

    for _, patternStr in ipairs(stackPatternStrings) do
        local keywords = self:ExtractKeywordsFromGlobalString(patternStr)
        for _, keyword in ipairs(keywords) do
            self.stackKeywordsList[keyword] = true
        end
    end

    -- Convert to individual fields for backward compatibility
    self.stackKeywords.singular = "stack"
    self.stackKeywords.plural = "stacks"
    self.stackKeywords.stacking = "stacking"
    self.stackKeywords.maximum = "maximum"
    self.stackKeywords.times = "times"

    -- Duration keywords (extract from patterns like "Lasts %s sec." or "%s min remaining")
    if ITEM_DURATION_SEC then
        local keyword = strmatch(ITEM_DURATION_SEC, "([%a]+)[%s%.]?$") -- Extract trailing word like "sec"
        if keyword then
            self.durationKeywords.sec = strlower(keyword)
        end
    end
    if ITEM_DURATION_MIN then
        local keyword = strmatch(ITEM_DURATION_MIN, "([%a]+)[%s%.]?$")
        if keyword then
            self.durationKeywords.min = strlower(keyword)
        end
    end

    -- Cooldown keywords (extract from patterns)
    if ITEM_COOLDOWN_TOTAL_SEC then
        -- Try to extract "cooldown" or "sec" from pattern
        local cooldownWord = strmatch(ITEM_COOLDOWN_TOTAL_SEC, "([%a]+)[%s%.]?$")
        if cooldownWord then
            self.cooldownKeywords.sec = strlower(cooldownWord)
        end
    end
    if ITEM_COOLDOWN_TOTAL_MIN then
        local cooldownWord = strmatch(ITEM_COOLDOWN_TOTAL_MIN, "([%a]+)[%s%.]?$")
        if cooldownWord then
            self.cooldownKeywords.min = strlower(cooldownWord)
        end
    end

    -- Add fallback context-aware patterns (for cases where GlobalStrings don't cover)
    -- These provide additional matching for "for X sec" style text
    self.durationPatterns.forSec = "for%s+([%d%., ]+)%s*sec"             -- "for 15 sec"
    self.durationPatterns.forMin = "for%s+([%d%., ]+)%s*min"             -- "for 2 min"

    -- Add generic cooldown fallback patterns (in case GlobalStrings don't exist)
    -- These match formats like "(45 sec cooldown)" or "(10% chance, 2 min cooldown)"
    -- Pattern allows text before cooldown value (e.g., "10% chance, ")
    self.cooldownPatterns.genericMin = "([%d%., ]+)%s*min%s+cooldown"     -- "2 min cooldown"
    self.cooldownPatterns.genericSec = "([%d%., ]+)%s*sec%s+cooldown"     -- "45 sec cooldown"
    self.cooldownPatterns.genericHours = "([%d%., ]+)%s*hour%s+cooldown"  -- "2 hour cooldown"
    self.cooldownPatterns.genericDays = "([%d%., ]+)%s*day%s+cooldown"    -- "1 day cooldown"

    -- Add generic stack patterns (locale-independent structure)
    self.stackPatterns.upTo = "up to%s*([%d%., ]+)"           -- "up to 5 stacks"
    self.stackPatterns.maximum = "maximum%s*([%d%., ]+)"      -- "maximum 10 stacks"
    self.stackPatterns.stacking = "stacking%s+.*?([%d%., ]+)" -- "stacking up to 5"
    self.stackPatterns.times = "([%d%., ]+)%s*times?"         -- "5 times"

    -- Validate all patterns for errors
    if self.debug then
        local function validatePattern(name, pattern)
            if not pattern then return end
            local success, err = pcall(function()
                local test = "test text 123"
                strmatch(test, pattern)
            end)
            if not success then
                self:Error("INVALID PATTERN '%s': %s - Error: %s", name, tostring(pattern), tostring(err))
            end
        end

        for name, pattern in pairs(self.durationPatterns) do
            validatePattern("duration." .. name, pattern)
        end
        for name, pattern in pairs(self.cooldownPatterns) do
            validatePattern("cooldown." .. name, pattern)
        end
        for name, pattern in pairs(self.stackPatterns) do
            validatePattern("stack." .. name, pattern)
        end
    end
end

-- ============================ CORE PARSING FUNCTIONS ============================

--- Convert WoW global string pattern to Lua pattern (StatLogic approach)
--- @param pattern string WoW global string pattern
--- @return string Lua pattern
function TooltipParser:ConvertWoWPatternToLua(pattern)
    if not pattern or type(pattern) ~= "string" then
        return ""
    end

    -- StatLogic pattern conversion approach
    -- Convert %s to proper Lua number pattern that handles various number formats
    -- French uses spaces as thousands separators: "1 218" instead of "1,218"
    -- English uses commas: "1,218"
    -- Some locales use periods: "1.218"
    local luaPattern = pattern:gsub("%%s", "([+-]?%%d+[%%s,%%%.]?%%d*)")

    return luaPattern
end

--- Parse tooltip text and extract stats, procs, and cooldowns
--- @param text string Tooltip text to parse
--- @param options table|nil Optional parsing options
--- @return table Parsed result with stats, procs, and cooldowns
--- @usage ParseTooltip("+964 Strength", {parseAllStats = true}) -- Parse all stats
--- @usage ParseTooltip("+964 Strength", {parseAllStats = false}) -- Only parse proc stats
function TooltipParser:ParseTooltip(text, options)
    if not text or type(text) ~= "string" then
        return self:GetEmptyResult()
    end

    -- Default options
    local parseAllStats = true
    if options and options.parseAllStats ~= nil then
        parseAllStats = options.parseAllStats
    end

    -- Check cache first
    if self.db.global.cacheEnabled then
        local cached = self:GetCachedResult(text)
        if cached then
            self:Info("ParseTooltip: Using cached result for tooltip (stats=%d, procs=%d, cooldowns=%d)",
                cached.stats and #cached.stats or 0,
                cached.procs and #cached.procs or 0,
                cached.cooldowns and #cached.cooldowns or 0)
            self.state.cacheStats.hits = self.state.cacheStats.hits + 1
            return cached
        end
    end

    -- Initialize patterns if needed
    self:InitializeStatPatterns()

    local result = self:GetEmptyResult()

    -- Parse tooltip text into lines
    local lines = {strsplit("\n", text)}

    -- CRITICAL: Skip first 2 lines of tooltips to avoid false positives
    -- Line 1: Always spell/item name
    -- Line 2: Always cast time/cost (spells) or item level (items)
    -- This prevents detecting "100 Mana" costs as MANA stat buffs
    for i, line in ipairs(lines) do
        -- Skip first 2 lines (name + metadata)
        if i > 2 then
            line = trim(line)
            if line and line ~= "" then
                local success, err = pcall(function() self:ParseLine(line, result, parseAllStats) end)
                if not success then
                    self:Error("ParseTooltip: ParseLine failed for line %d '%s': %s", i, line, tostring(err))
                end
            end
        end
    end

    -- Proximity-based fallback: If no stats found, try proximity search
    -- For spells (parseAllStats=true): Check ALL lines to find stats like "Increases attack power by 1,344"
    -- For trinkets (parseAllStats=false): Only check proc lines to avoid base stats
    if #result.stats == 0 then
        for i, line in ipairs(lines) do
            -- Skip first 2 lines (name + metadata) here too
            if i > 2 then
                local trimmedLine = trim(line)
                if trimmedLine and trimmedLine ~= "" then
                    -- Trinkets: Only check proc effect lines (existing safe behavior)
                    -- Spells: Check all lines (new behavior to find spell description stats)
                    local shouldCheckLine = parseAllStats or self:IsProcEffectLine(trimmedLine)

                    if shouldCheckLine then
                        local fallbackStats = self:ProximitySearchStatLine(trimmedLine)
                        if fallbackStats then
                            -- Add found stats to result
                            if fallbackStats.type then
                                -- Single stat
                                tinsert(result.stats, fallbackStats)
                            else
                                -- Array of stats
                                for _, stat in ipairs(fallbackStats) do
                                    tinsert(result.stats, stat)
                                end
                            end
                        end
                    end
                end
            end
        end

        if #result.stats > 0 then
            self:Info("ParseTooltip: Proximity fallback found %d stats", #result.stats)
        end
    end

    self:Info("ParseTooltip: Parse complete - %d stats, %d procs, %d cooldowns",
        #result.stats, #result.procs, #result.cooldowns)

    -- Cache result
    if self.db.global.cacheEnabled then
        self:CacheResult(text, result)
    end

    self.state.cacheStats.misses = self.state.cacheStats.misses + 1
    return result
end

--- Parse a single line of tooltip text
--- @param line string Line to parse
--- @param result table Result table to populate
--- @param parseAllStats boolean|nil If true, parse stats from all lines. If false, only parse stats from proc/effect lines
function TooltipParser:ParseLine(line, result, parseAllStats)
    -- Check if line should be excluded
    if self:IsExcludedLine(line) then
        return
    end

    -- Classify the line to optimize parsing
    local success, lineType = pcall(function() return self:ClassifyLine(line) end)
    if not success then
        self:Error("ParseLine: ClassifyLine failed for line '%s': %s", line, tostring(lineType))
        return
    end

    -- Skip metadata lines entirely (no parsing needed)
    if lineType == "skip" then
        return
    end

    -- Handle proc lines (Equip:, Use:, Chance on hit:)
    if lineType == "proc" then
        -- Parse stats from proc/effect lines (use proc-style parsing only)
        -- May return multiple stats for compound procs like "Strength or Agility"
        local stats = self:ParseStatLine(line, true) -- true = isProcLine, skip standard patterns
        if stats then
            -- ParseStatLine can return a single stat or an array of stats
            if stats.type then
                -- Single stat returned
                self:Trace("ParseLine: Found proc stat: %s = %d%s", stats.type, stats.value, stats.isPercent and "%" or "")
                tinsert(result.stats, stats)
            else
                -- Multiple stats returned (compound proc)
                for _, stat in ipairs(stats) do
                    self:Trace("ParseLine: Found proc stat: %s = %d%s", stat.type, stat.value, stat.isPercent and "%" or "")
                    tinsert(result.stats, stat)
                end
            end
        end

        -- Parse proc information (includes duration, cooldown, chance, and stacks)
        local proc = self:ParseProcLine(line)
        if proc then
            self:Trace("ParseLine: Found proc: duration=%d, cooldown=%d, chance=%d, stacks=%d",
                proc.duration or 0, proc.cooldown or 0, proc.chance or 0, proc.stacks or 0)
            tinsert(result.procs, proc)

            -- Add cooldown to cooldowns array if present (no need to reparse - we already have it!)
            if proc.cooldown and proc.cooldown > 0 then
                tinsert(result.cooldowns, {
                    type = proc.procType or "use",
                    duration = proc.cooldown,
                    source = "proc"
                })
            end
        end

        -- Note: No separate ParseCooldownLine call for proc lines - cooldown already extracted in ParseProcLine

    -- Handle cooldown lines (standalone cooldown information)
    elseif lineType == "cooldown" then
        -- Parse cooldown information only (optimized - no stat parsing)
        local cooldown = self:ParseCooldownLine(line)
        if cooldown then
            self:Trace("ParseLine: Found cooldown: duration=%d", cooldown.duration or 0)
            tinsert(result.cooldowns, cooldown)
        end

    -- Handle stat lines (potential stat information)
    elseif lineType == "stat" then
        -- For stat lines, conditionally parse based on parseAllStats option
        if parseAllStats then
            local stat = self:ParseStatLine(line)
            if stat then
                self:Trace("ParseLine: Found stat: %s = %d%s", stat.type, stat.value, stat.isPercent and "%" or "")
                tinsert(result.stats, stat)
            end
        end
    end
end

--- Check if a line is a proc/effect line (Equip:, Use:, Chance on hit:, etc.)
--- Case-sensitive matching - WoW constants have consistent casing per locale
--- @param line string Line to check
--- @return boolean True if line is a proc/effect line
function TooltipParser:IsProcEffectLine(line)
    if not line then return false end

    -- Check for proc/effect triggers using constant pattern list
    for _, pattern in ipairs(PROC_TRIGGER_PATTERNS) do
        if pattern and strfind(line, pattern, 1, true) then
            -- Check if the proc pattern is at the start of the line (after trimming)
            -- This ensures we only match actual proc effects, not item descriptions
            local trimmedLine = trim(line)
            -- Escape pattern for regex matching
            local escapedPattern = escapePattern(pattern)
            if strfind(trimmedLine, "^" .. escapedPattern) then
                if self.debug then
                    self:Trace("IsProcEffectLine: Found proc pattern '%s' at start of line: '%s'", pattern, line)
                end
                return true
            else
                if self.debug then
                    self:Trace("IsProcEffectLine: Proc pattern '%s' found but not at start of line: '%s'", pattern, line)
                end
            end
        end
    end

    -- No proc patterns matched (not logging - too verbose)
    return false
end

--- Check if a line should be excluded from parsing
--- Case-sensitive matching against WoW constants
--- @param line string Line to check
--- @return boolean True if line should be excluded
function TooltipParser:IsExcludedLine(line)
    -- Check whole text exclusions - direct case-sensitive lookup
    if self.wholeTextLookup[line] == false then
        return true
    end

    -- Check prefix exclusions - use original case
    local prefix = safeUtf8Sub(line, 1, self.prefixExclusions and 5 or 0)
    if self.prefixExclusions and self.prefixExclusions[prefix] then
        return true
    end

    return false
end

--- Classify a tooltip line to optimize parsing
--- Case-sensitive matching for optimal performance
--- @param line string Line to classify
--- @return string Line type: "skip", "proc", "stat", or "cooldown"
function TooltipParser:ClassifyLine(line)
    if not line or line == "" then
        return "skip"
    end

    -- Check for metadata lines that should be skipped entirely
    -- These patterns match common tooltip metadata (case-insensitive for metadata)
    local skipPatterns = {
        "^[Ii]tem [Ll]evel",          -- "Item Level 200"
        "^[Bb]inds [Ww]hen",          -- "Binds when equipped", "Binds when picked up"
        "^[Rr]equires [Ll]evel",      -- "Requires Level 80"
        "^[Uu]nique%-[Ee]quipped",    -- "Unique-Equipped"
        "^[Tt]rinket$",                -- Just the word "Trinket"
        "^[Uu]nique$",                 -- Just the word "Unique"
        "^[Cc]onjured [Ii]tem",        -- "Conjured Item"
        "^[Qq]uest [Ii]tem",           -- "Quest Item"
        "^%.$",                        -- "." (single period, item quality separator)
    }

    for _, skipPattern in ipairs(skipPatterns) do
        if strmatch(line, skipPattern) then
            return "skip"
        end
    end

    -- Check for proc/equip/use lines (highest priority for parsing)
    -- Use constant pattern list
    for _, procPattern in ipairs(PROC_TRIGGER_PATTERNS) do
        if procPattern and strfind(line, procPattern, 1, true) then
            -- Verify it's at the start of the line (after trimming)
            local trimmedLine = trim(line)
            local escapedPattern = escapePattern(procPattern)
            if strfind(trimmedLine, "^" .. escapedPattern) then
                return "proc"
            end
        end
    end

    -- Check for lines that might contain cooldown information
    -- Case-insensitive for natural language detection
    if strmatch(line, "[Cc]ooldown") or strmatch(line, "[Mm]in") or strmatch(line, "[Ss]ec") then
        return "cooldown"
    end

    -- Check for lines that might contain stat information
    -- Lines with numbers are potential stat lines
    if strmatch(line, "%d+") then
        return "stat"
    end

    -- Default: might be a stat line, parse it
    return "stat"
end

--- Parse a stat line using StatLogic approach
--- Case-sensitive matching for item stats, case-insensitive for proc descriptions
--- @param line string Line to parse
--- @param isProcLine boolean|nil If true, skip standard patterns and use only proc-style patterns (optimization)
--- @return table|nil Parsed stat or nil
function TooltipParser:ParseStatLine(line, isProcLine)
    -- For proc lines, skip standard item stat patterns and go straight to proc-style patterns
    -- This avoids checking 100+ patterns that won't match proc text like "increasing your Strength by 510"
    if not isProcLine then
        -- Look for standard item stat patterns using pre-compiled Lua patterns
        -- These match formats like "+510 Strength" or "510 Strength" (case-sensitive)
        for pattern, patternData in pairs(self.statIDLookup) do
            -- Use pre-compiled Lua pattern (no conversion needed!)
            local luaPattern = patternData.luaPattern
            local statTypes = patternData.statTypes

            -- Direct pattern matching - no lowercasing
            local value = strmatch(line, luaPattern)
            if value then
                -- Clean up the value (remove thousands separators: commas, spaces, periods)
                local cleanedValue = cleanNumber(value)
                if cleanedValue then
                    -- Check if "%" immediately follows the number for percentage detection
                    local isPercent = false
                    local percentPos = strfind(line, value, 1, true) -- Find the original value text
                    if percentPos then
                        local afterNumberPos = percentPos + #value
                        local charAfter = line:sub(afterNumberPos, afterNumberPos)
                        isPercent = (charAfter == "%")
                    end

                    -- Early return - no need to check remaining patterns
                    return {
                        type = statTypes[1],
                        value = cleanedValue,
                        isPercent = isPercent,
                        duration = nil,
                        source = "proc_stat"
                    }
                end
            end
        end
    end

    -- If no standard patterns matched, try proc-style text patterns
    -- These handle phrases like "increasing your Strength by 510" or "gain 510 Agility"
    -- Use constant pattern list (English-only - see localization notes)
    for _, procPattern in ipairs(PROC_STYLE_PATTERNS) do
        local match1, match2 = strmatch(line, procPattern.pattern)
        if match1 and match2 then
            local statName = procPattern.statPos == 1 and match1 or match2
            local valueStr = procPattern.valuePos == 1 and match1 or match2

            -- Clean up stat name and value
            statName = trim(statName)

            -- Remove common trailing words that shouldn't be part of the stat name
            -- e.g., "Strength for 10" -> "Strength"
            statName = statName:gsub("%s+for%s.*$", "")   -- Remove "for X sec"
            statName = statName:gsub("%s+when%s.*$", "")  -- Remove "when ..."
            statName = statName:gsub("%s+while%s.*$", "") -- Remove "while ..."
            statName = statName:gsub("%s+during%s.*$", "") -- Remove "during ..."
            statName = trim(statName) -- trim again after removal
            local value = cleanNumber(valueStr)

            if value then
                -- Handle compound stats like "Strength or Agility"
                -- Return all stats from compound procs so we can track all possibilities
                if strfind(statName, " or ") then
                    -- Manual split on " or " (strsplit splits on each char, not the whole string!)
                    local statParts = {}
                    local remaining = statName
                    while remaining do
                        local orPos = strfind(remaining, " or ", 1, true) -- plain text search
                        if orPos then
                            local part = remaining:sub(1, orPos - 1)
                            tinsert(statParts, part)
                            remaining = remaining:sub(orPos + 4) -- skip " or "
                        else
                            tinsert(statParts, remaining)
                            break
                        end
                    end

                    -- Check if "%" immediately follows the number for percentage detection
                    local isPercent = false
                    local percentPos = strfind(line, valueStr, 1, true) -- Find the original value text
                    if percentPos then
                        local afterNumberPos = percentPos + #valueStr
                        local charAfter = line:sub(afterNumberPos, afterNumberPos)
                        isPercent = (charAfter == "%")
                    end

                    -- Try to match each stat part
                    local foundStats = {}
                    for i, statPart in ipairs(statParts) do
                        local trimmed = trim(statPart)
                        if trimmed and trimmed ~= "" then
                            local matchedStatType = self:MatchStatNameToType(trimmed)
                            if matchedStatType then
                                tinsert(foundStats, {
                                    type = matchedStatType,
                                    value = value,
                                    isPercent = isPercent,
                                    duration = nil,
                                    source = "proc_stat"
                                })
                            end
                        end
                    end

                    if #foundStats > 0 then
                        return foundStats -- Return array of stats
                    end
                else
                    -- Single stat (no "or")
                    local matchedStatType = self:MatchStatNameToType(statName)
                    if matchedStatType then
                        -- Check if "%" immediately follows the number for percentage detection
                        local isPercent = false
                        local percentPos = strfind(line, valueStr, 1, true) -- Find the original value text
                        if percentPos then
                            local afterNumberPos = percentPos + #valueStr
                            local charAfter = line:sub(afterNumberPos, afterNumberPos)
                            isPercent = (charAfter == "%")
                        end

                        return {
                            type = matchedStatType,
                            value = value,
                            isPercent = isPercent,
                            duration = nil,
                            source = "proc_stat"
                        }
                    end
                end
            end
        end
    end

    return nil
end

--- Generic proximity search for a number near a keyword
--- Searches for numbers within maxDistance characters of the keyword
--- @param text string Text to search
--- @param keyword string Keyword to search for (case-insensitive)
--- @param maxDistance number Maximum distance between keyword and number (default: 50)
--- @return number|nil Number value if found, nil otherwise
function TooltipParser:ProximitySearchForKeyword(text, keyword, maxDistance)
    if not text or not keyword or text == "" or keyword == "" then return nil end

    maxDistance = maxDistance or 50

    -- Helper: Extract full number from text at a position (handles separators)
    local function extractNumberAtPosition(str, pos)
        if not str or pos < 1 or pos > #str then return nil end

        local char = str:sub(pos, pos)
        if not strmatch(char, "%d") then return nil end

        -- Find the start of the number (scan backwards)
        local startPos = pos
        while startPos > 1 do
            local prevChar = str:sub(startPos - 1, startPos - 1)
            if strmatch(prevChar, "[%d,%. ]") then
                startPos = startPos - 1
            else
                break
            end
        end

        -- Find the end of the number (scan forwards)
        local endPos = pos
        while endPos < #str do
            local nextChar = str:sub(endPos + 1, endPos + 1)
            if strmatch(nextChar, "[%d,%. ]") then
                endPos = endPos + 1
            else
                break
            end
        end

        -- Trim leading/trailing spaces
        while startPos <= endPos and strmatch(str:sub(startPos, startPos), "%s") do
            startPos = startPos + 1
        end
        while endPos >= startPos and strmatch(str:sub(endPos, endPos), "%s") do
            endPos = endPos - 1
        end

        if startPos > endPos then return nil end

        local numStr = str:sub(startPos, endPos)
        return cleanNumber(numStr), startPos, endPos
    end

    -- Helper: Find closest number to a position
    local function findClosestNumber(str, keywordPos, keywordEndPos, maxDist)
        if not str or not keywordPos then return nil end

        local leftNum, leftDist = nil, math.huge
        local rightNum, rightDist = nil, math.huge

        -- Search left
        local leftSearchStart = math.max(1, keywordPos - maxDist)
        for i = keywordPos - 1, leftSearchStart, -1 do
            local char = str:sub(i, i)
            if strmatch(char, "%d") then
                local value, startPos, endPos = extractNumberAtPosition(str, i)
                if value and value > 0 then
                    local beforeChar = startPos > 1 and str:sub(startPos - 1, startPos - 1) or " "
                    if strmatch(beforeChar, "[%s%p]") or startPos == 1 then
                        leftNum = value
                        leftDist = keywordPos - endPos
                        break
                    end
                end
            end
        end

        -- Search right
        local rightSearchEnd = math.min(#str, keywordEndPos + maxDist)
        for i = keywordEndPos + 1, rightSearchEnd do
            local char = str:sub(i, i)
            if strmatch(char, "%d") then
                local value, startPos, endPos = extractNumberAtPosition(str, i)
                if value and value > 0 then
                    local beforeChar = startPos > 1 and str:sub(startPos - 1, startPos - 1) or " "
                    if strmatch(beforeChar, "[%s%p]") or startPos == 1 then
                        rightNum = value
                        rightDist = startPos - keywordEndPos
                        break
                    end
                end
            end
        end

        -- Return closest (prefer left if equal)
        if leftNum and (not rightNum or leftDist <= rightDist) then
            return leftNum, leftDist, "left"
        elseif rightNum then
            return rightNum, rightDist, "right"
        end

        return nil
    end

    -- Search for keyword in text (case-insensitive)
    local lowerText = strlower(text)
    local lowerKeyword = strlower(keyword)
    local keywordPos = strfind(lowerText, lowerKeyword, 1, true) -- plain text search

    if not keywordPos then return nil end

    local keywordEndPos = keywordPos + #keyword - 1
    local value, distance, direction = findClosestNumber(text, keywordPos, keywordEndPos, maxDistance)

    if value and self.debug then
        self:Debug("ProximitySearchForKeyword: Found '%s' with value %d (distance=%d, direction=%s)",
            keyword, value, distance or 0, direction or "unknown")
    end

    return value
end

--- Proximity-based stat extraction fallback (localized via WoW constants)
--- This method is used as a fallback when standard pattern matching fails (e.g., non-English locales)
--- Searches for numbers near known stat names using ITEM_MOD_*_SHORT WoW constants
--- @param line string Line to search (should be a proc line)
--- @return table|nil Single stat, array of stats, or nil if no stats found
function TooltipParser:ProximitySearchStatLine(line)
    if not line or line == "" then return nil end

    -- Helper: Extract full number from text at a position (handles separators)
    -- Returns: number value, start position, end position
    local function extractNumberAtPosition(text, pos)
        if not text or pos < 1 or pos > #text then return nil end

        -- Check if we're at a digit
        local char = text:sub(pos, pos)
        if not strmatch(char, "%d") then return nil end

        -- Find the start of the number (scan backwards)
        local startPos = pos
        while startPos > 1 do
            local prevChar = text:sub(startPos - 1, startPos - 1)
            -- Allow digits, commas, spaces, and periods (thousands separators)
            if strmatch(prevChar, "[%d,%. ]") then
                startPos = startPos - 1
            else
                break
            end
        end

        -- Find the end of the number (scan forwards)
        local endPos = pos
        while endPos < #text do
            local nextChar = text:sub(endPos + 1, endPos + 1)
            -- Allow digits, commas, spaces, and periods (thousands separators)
            if strmatch(nextChar, "[%d,%. ]") then
                endPos = endPos + 1
            else
                break
            end
        end

        -- Extract the number string
        local numStr = text:sub(startPos, endPos)

        -- Trim leading/trailing spaces from the range
        -- (spaces are allowed WITHIN numbers for thousands separators, but not at edges)
        while startPos <= endPos and strmatch(text:sub(startPos, startPos), "%s") do
            startPos = startPos + 1
        end
        while endPos >= startPos and strmatch(text:sub(endPos, endPos), "%s") do
            endPos = endPos - 1
        end

        -- Re-extract after trimming
        if startPos <= endPos then
            numStr = text:sub(startPos, endPos)
        else
            return nil -- All spaces, no valid number
        end

        -- Clean and parse the number using existing helper
        local value = cleanNumber(numStr)

        return value, startPos, endPos
    end

    -- Helper: Find closest number to a position in text
    -- Returns: number value, distance, direction ("left"|"right"), endPos
    local function findClosestNumber(text, statPos, statEndPos, maxDistance)
        if not text or not statPos then return nil end

        local leftNum, leftDist, leftEndPos = nil, math.huge, nil
        local rightNum, rightDist, rightEndPos = nil, math.huge, nil

        -- Search left from stat position
        local leftSearchStart = math.max(1, statPos - maxDistance)
        for i = statPos - 1, leftSearchStart, -1 do
            local char = text:sub(i, i)
            if strmatch(char, "%d") then
                local value, startPos, endPos = extractNumberAtPosition(text, i)
                if value and value > 0 then
                    -- Check for word boundary (space or punctuation before number)
                    local beforeChar = startPos > 1 and text:sub(startPos - 1, startPos - 1) or " "
                    if strmatch(beforeChar, "[%s%p]") or startPos == 1 then
                        leftNum = value
                        leftDist = statPos - endPos
                        leftEndPos = endPos
                        break
                    end
                end
            end
        end

        -- Search right from stat position
        local rightSearchEnd = math.min(#text, (statEndPos or statPos) + maxDistance)
        for i = (statEndPos or statPos) + 1, rightSearchEnd do
            local char = text:sub(i, i)
            if strmatch(char, "%d") then
                local value, startPos, endPos = extractNumberAtPosition(text, i)
                if value and value > 0 then
                    -- Check for word boundary (space or punctuation before number)
                    local beforeChar = startPos > 1 and text:sub(startPos - 1, startPos - 1) or " "
                    if strmatch(beforeChar, "[%s%p]") or startPos == 1 then
                        rightNum = value
                        rightDist = startPos - (statEndPos or statPos)
                        rightEndPos = endPos
                        break
                    end
                end
            end
        end

        -- Return closest number (prefer left if equal distance)
        if leftNum and (not rightNum or leftDist <= rightDist) then
            return leftNum, leftDist, "left", leftEndPos
        elseif rightNum then
            return rightNum, rightDist, "right", rightEndPos
        end

        return nil
    end

    -- Build stat name map from WoW constants (localized via ITEM_MOD_*_SHORT)
    -- These constants are already used in InitializeStatPatterns, so they're available
    local statNameToType = {
        [ITEM_MOD_STRENGTH_SHORT] = "STRENGTH",
        [ITEM_MOD_AGILITY_SHORT] = "AGILITY",
        [ITEM_MOD_STAMINA_SHORT] = "STAMINA",
        [ITEM_MOD_INTELLECT_SHORT] = "INTELLECT",
        [ITEM_MOD_SPIRIT_SHORT] = "SPIRIT",
        [ITEM_MOD_CRIT_RATING_SHORT] = "CRIT_RATING",
        [ITEM_MOD_HASTE_RATING_SHORT] = "HASTE_RATING",
        [ITEM_MOD_MASTERY_RATING_SHORT] = "MASTERY_RATING",
        [ITEM_MOD_HIT_RATING_SHORT] = "HIT_RATING",
        [ITEM_MOD_EXPERTISE_RATING_SHORT] = "EXPERTISE_RATING",
        [ITEM_MOD_DODGE_RATING_SHORT] = "DODGE_RATING",
        [ITEM_MOD_PARRY_RATING_SHORT] = "PARRY_RATING",
        [ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER",
        [ITEM_MOD_RANGED_ATTACK_POWER_SHORT] = "RANGED_ATTACK_POWER",
        [ITEM_MOD_SPELL_POWER_SHORT] = "SPELL_POWER",
        [ITEM_MOD_SPELL_PENETRATION_SHORT] = "SPELL_PENETRATION",
        [ITEM_MOD_RESILIENCE_RATING_SHORT] = "RESILIENCE_RATING",
        [ITEM_MOD_EXTRA_ARMOR_SHORT] = "BONUS_ARMOR",
        [HP] = "HEALTH",
        [MP] = "MANA",
    }

    -- Lowercase the line for case-insensitive stat name matching
    local lowerLine = line:lower()

    -- Track found stats to avoid duplicates
    local foundStats = {}
    local foundStatTypes = {}

    -- Search for each stat name in the line
    for statName, statType in pairs(statNameToType) do
        if statName and statName ~= "" then
            local lowerStatName = statName:lower()
            local statPos = strfind(lowerLine, lowerStatName, 1, true) -- plain text search

            if statPos then
                local statEndPos = statPos + #statName - 1

                -- Find closest number to this stat name (within 50 characters)
                local value, distance, direction, numEndPos = findClosestNumber(line, statPos, statEndPos, 50)

                if value and not foundStatTypes[statType] then
                    -- Check if "%" immediately follows the number for percentage detection
                    local isPercent = false
                    if numEndPos then
                        local charAfter = line:sub(numEndPos + 1, numEndPos + 1)
                        isPercent = (charAfter == "%")
                    end

                    -- Found a stat!
                    tinsert(foundStats, {
                        type = statType,
                        value = value,
                        isPercent = isPercent,
                        duration = nil,
                        source = "proximity_fallback"
                    })
                    foundStatTypes[statType] = true

                    self:Debug("ProximitySearch: Found %s = %d%s (distance=%d, direction=%s)",
                        statType, value, isPercent and "%" or "", distance or 0, direction or "unknown")
                end
            end
        end
    end

    -- Return results
    if #foundStats == 0 then
        return nil
    elseif #foundStats == 1 then
        return foundStats[1] -- Single stat
    else
        return foundStats -- Array of stats
    end
end

--- Match a stat name (from proc text) to a stat type constant
--- Uses WoW global strings for localization support
--- Case-insensitive matching for natural language stat names
--- @param statName string The stat name to match (e.g., "Strength", "agility")
--- @return string|nil The matched stat type or nil
function TooltipParser:MatchStatNameToType(statName)
    if not statName then return nil end

    -- Build map from WoW global strings for localization support
    -- These are the stat names that appear in proc text (localized by WoW)
    -- Note: Some globals might be nil in different WoW versions
    local statGlobalToType = {
        -- Primary stats
        {global = _G.SPELL_STAT1_NAME, type = "STRENGTH"},      -- "Strength"
        {global = _G.SPELL_STAT2_NAME, type = "AGILITY"},       -- "Agility"
        {global = _G.SPELL_STAT3_NAME, type = "STAMINA"},       -- "Stamina"
        {global = _G.SPELL_STAT4_NAME, type = "INTELLECT"},     -- "Intellect"
        {global = _G.SPELL_STAT5_NAME, type = "SPIRIT"},        -- "Spirit"

        -- Secondary stats (using combat rating names where available)
        {global = _G.STAT_ATTACK_POWER, type = "ATTACK_POWER"},         -- "Attack Power"
        {global = _G.STAT_CRITICAL_STRIKE, type = "CRIT_RATING"},       -- "Critical Strike"
        {global = _G.STAT_HASTE, type = "HASTE_RATING"},                -- "Haste"
        {global = _G.STAT_MASTERY, type = "MASTERY_RATING"},            -- "Mastery"
        {global = _G.STAT_DODGE, type = "DODGE_RATING"},                -- "Dodge"
        {global = _G.STAT_PARRY, type = "PARRY_RATING"},                -- "Parry"

        -- Power stats
        {global = _G.STAT_SPELLPOWER, type = "SPELL_POWER"},            -- "Spell Power"

        -- Resources
        {global = _G.HEALTH, type = "HEALTH"},                          -- "Health"
        {global = _G.MANA, type = "MANA"},                              -- "Mana"
    }

    -- First try exact match with WoW globals (properly localized)
    -- Case-insensitive comparison for natural language
    for _, entry in ipairs(statGlobalToType) do
        if entry.global and entry.global:lower() == statName:lower() then
            if self.debug then
                self:Debug("MatchStatNameToType: Matched '%s' to %s via WoW global", statName, entry.type)
            end
            return entry.type
        end
    end

    -- Fallback: hardcoded English names for when globals don't match
    -- (some stats might not have global string constants)
    -- Lowercase for case-insensitive matching
    local lowerStatName = statName:lower()
    local fallbackMap = {
        ["strength"] = "STRENGTH",
        ["agility"] = "AGILITY",
        ["stamina"] = "STAMINA",
        ["intellect"] = "INTELLECT",
        ["spirit"] = "SPIRIT",
        ["attack power"] = "ATTACK_POWER",
        ["spell power"] = "SPELL_POWER",
        ["spellpower"] = "SPELL_POWER",
        ["critical strike"] = "CRIT_RATING",
        ["crit"] = "CRIT_RATING",
        ["haste"] = "HASTE_RATING",
        ["mastery"] = "MASTERY_RATING",
        ["hit"] = "HIT_RATING",
        ["expertise"] = "EXPERTISE_RATING",
        ["dodge"] = "DODGE_RATING",
        ["parry"] = "PARRY_RATING",
        ["armor"] = "ARMOR",
        ["health"] = "HEALTH",
        ["mana"] = "MANA",
    }

    local result = fallbackMap[lowerStatName]
    if result and self.debug then
        self:Debug("MatchStatNameToType: Matched '%s' to %s via fallback", statName, result)
    end

    return result
end

--- Convert string stat type to Types enum value
--- @param statType string|number|nil Stat type to convert
--- @return number Enum value or -1 if invalid
function TooltipParser:ConvertStatTypeToEnum(statType)
    if not statType or statType == -1 then return -1 end
    if type(statType) == "number" then return statType end
    if type(statType) == "string" then
        if Types then
            local statEnum = Types:GetType("Stat")
            if statEnum then
                -- Map stat detection strings to enum keys
                local statMapping = {
                    ["MASTERY_RATING"] = "MASTERY",
                    ["STRENGTH"] = "STRENGTH",
                    ["AGILITY"] = "AGILITY",
                    ["STAMINA"] = "STAMINA",
                    ["INTELLECT"] = "INTELLECT",
                    ["SPIRIT"] = "SPIRIT",
                    ["HIT_RATING"] = "HIT",
                    ["CRIT_RATING"] = "CRIT",
                    ["HASTE_RATING"] = "HASTE",
                    ["EXPERTISE_RATING"] = "EXPERTISE",
                    ["DODGE_RATING"] = "DODGE",
                    ["PARRY_RATING"] = "PARRY",
                    ["ATTACK_POWER"] = "ATTACK_POWER",
                    ["RANGED_ATTACK_POWER"] = "RANGED_ATTACK_POWER",
                    ["SPELL_POWER"] = "SPELL_POWER",
                    ["SPELL_PENETRATION"] = "SPELL_PENETRATION",
                    ["RESILIENCE_RATING"] = "RESILIENCE",
                    ["ARMOR"] = "ARMOR",
                    ["BONUS_ARMOR"] = "BONUS_ARMOR",
                    ["HEALTH"] = "HEALTH",
                    ["MANA"] = "MANA",
                    ["MANA_REGEN"] = "MP5"
                }
                local enumKey = statMapping[statType] or statType
                if statEnum[enumKey] then
                    return statEnum[enumKey]
                end
            end
        end
    end
    return -1
end

--- Parse a proc line
--- Case-sensitive matching against WoW constants
--- @param line string Line to parse
--- @return table|nil Parsed proc or nil
function TooltipParser:ParseProcLine(line)
    -- Look for proc patterns using constant pattern list
    for i, pattern in ipairs(PROC_TRIGGER_PATTERNS) do
        if strfind(line, pattern, 1, true) then
            if self.debug then
                self:Trace("ParseProcLine: Processing proc line: '%s'", line)
            end

            -- CRITICAL: Split line on parentheses for accurate parsing
            -- Tooltip format is consistent across all locales:
            -- OUTSIDE ( ): Duration, stat values, effect description
            -- INSIDE ( ):  Proc chance, ICD/cooldown
            local outsideParens = line
            local insideParens = ""

            -- Extract text inside parentheses (may have multiple sets)
            local parenStart = strfind(line, "%(")
            if parenStart then
                outsideParens = line:sub(1, parenStart - 1)
                -- Find matching closing paren
                local parenEnd = strfind(line, "%)", parenStart)
                if parenEnd then
                    insideParens = line:sub(parenStart + 1, parenEnd - 1)
                end
            end

            if self.debug then
                self:Trace("ParseProcLine: Split - outside='%s', inside='%s'", outsideParens, insideParens)
            end

            -- Parse duration and stacks ONLY from text outside parentheses
            local duration = self:FindDuration(outsideParens)
            local stacks = self:FindStacks(outsideParens)

            -- Parse cooldown/ICD ONLY from text inside parentheses
            local cooldown = self:FindCooldown(insideParens)

            -- Parse chance from FULL line (can appear inside OR outside parentheses)
            -- Examples: "(15% chance, 115 sec cooldown)" OR "4% chance to gain mastery"
            local chance = self:FindProcChance(line)

            if self.debug then
                self:Debug("ParseProcLine: Parsed values - duration=%d, cooldown=%d, chance=%d, stacks=%d",
                    duration, cooldown, chance, stacks)
            end

            -- Determine proc type based on trigger
            local procType = "proc"
            local useTrigger = ITEM_SPELL_TRIGGER_ONUSE or "Use:"
            if strfind(line, useTrigger, 1, true) then
                procType = "use"
            end

            return {
                spellId = nil, -- Would need spell ID extraction
                chance = chance,
                cooldown = cooldown,
                duration = duration,
                stacks = stacks,
                procType = procType,
                source = procType
            }
        end
    end

    return nil
end

--- Parse a cooldown line
--- @param line string Line to parse
--- @return table|nil Parsed cooldown or nil
function TooltipParser:ParseCooldownLine(line)
    -- Use the same cooldown parsing as TooltipParsingManager
    local cooldown = self:FindCooldown(line)
    if cooldown > 0 then
        if self.debug then
            self:Debug("ParseCooldownLine: Found cooldown: %d seconds", cooldown)
        end
        return {
            type = "use",
            duration = cooldown,
            source = "cooldown"
        }
    end

    return nil
end

--- Parse item tooltip by item ID
--- @param itemId number Item ID to parse
--- @return table Parsed result
function TooltipParser:ParseItemTooltip(itemId)
    if not itemId or type(itemId) ~= "number" then
        return self:GetEmptyResult()
    end

    if self.debug then
        self:Debug("ParseItemTooltip: Starting parse for item %d", itemId)
    end

    -- Stage 1: Check if item is cached using GetItemInfoInstant (like DataManager does)
    -- This returns immediately available data without triggering server queries
    local instantItemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = GetItemInfoInstant(itemId)

    -- If GetItemInfoInstant returns nil, item is NOT in cache - mark as pending
    if not instantItemID then
        if self.debug then
            self:Debug("ParseItemTooltip: Item %d - GetItemInfoInstant returned nil (NOT in cache) - marking as pending", itemId)
        end
        return {
            stats = {},
            procs = {},
            cooldowns = {},
            pendingData = true,  -- Flag indicating incomplete data
            itemId = itemId
        }
    end

    if self.debug then
        self:Trace("ParseItemTooltip: Item %d - GetItemInfoInstant SUCCESS (item in cache)", itemId)
    end

    -- Stage 2: Item is cached, get full data
    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID = WoWAPI.GetItemInfo(itemId)

    if not itemName then
        -- This shouldn't happen if GetItemInfoInstant succeeded, but handle it anyway
        if self.debug then
            self:Debug("ParseItemTooltip: Item %d - GetItemInfo returned nil (inconsistent cache state) - marking as pending", itemId)
        end
        return {
            stats = {},
            procs = {},
            cooldowns = {},
            pendingData = true,
            itemId = itemId
        }
    end

    if self.debug then
        self:Trace("ParseItemTooltip: Item %d - GetItemInfo SUCCESS, name='%s'", itemId, itemName)
    end

    -- Stage 3: Create and populate tooltip
    -- Create a dedicated tooltip for item parsing (separate from scanningTooltip used by GetStatFromAura)
    -- Using a unique name to avoid conflicts with other tooltip operations
    local tooltipName = "NAGTooltipParserItemTooltip" .. itemId
    local tooltip = _G[tooltipName]
    if not tooltip then
        tooltip = CreateFrame("GameTooltip", tooltipName, nil, "GameTooltipTemplate")
    end
    tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    tooltip:ClearLines()
    tooltip:SetHyperlink(itemLink)

    if self.debug then
        self:Trace("ParseItemTooltip: Item %d - Tooltip created, checking line count...", itemId)
    end

    -- Check if tooltip has content
    -- For cached items, tooltip should populate immediately
    -- If we still get 0 lines for a cached item, item data may not be fully loaded yet
    local numLines = tooltip:NumLines()

    if self.debug then
        self:Trace("ParseItemTooltip: Item %d - Tooltip has %d lines", itemId, numLines)
    end

    if numLines == 0 then
        tooltip:Hide()
        if self.debug then
            self:Trace("ParseItemTooltip: Item %d - Tooltip has 0 lines - marking as pending", itemId)
        end
        return {
            stats = {},
            procs = {},
            cooldowns = {},
            pendingData = true,
            itemId = itemId
        }
    end

    -- Extract tooltip text
    local tooltipText = ""
    for i = 1, tooltip:NumLines() do
        local line = _G[tooltipName .. "TextLeft" .. i]
        if line and line:GetText() then
            tooltipText = tooltipText .. line:GetText() .. "\n"
        end
    end

    -- DEBUG: Print raw tooltip text to diagnose incomplete loading
    if self.debug then
        self:Trace("ParseItemTooltip: Item %d tooltip has %d lines - RAW CONTENT:", itemId, tooltip:NumLines())
        for i = 1, tooltip:NumLines() do
            local line = _G[tooltipName .. "TextLeft" .. i]
            if line and line:GetText() then
                self:Trace("  Line %d: '%s'", i, line:GetText())
            end
        end
    end

    -- Clean up tooltip
    tooltip:Hide()

    -- Parse the tooltip text
    -- For trinkets, only parse stats from proc/effect lines to avoid capturing base stats
    -- Check multiple ways to detect trinkets
    local isTrinket = (itemSubType and itemSubType == "Trinket") or
                     (itemType and itemType == "Trinket") or
                     (itemEquipLoc and itemEquipLoc == "INVTYPE_TRINKET") or
                     (classID and subclassID and classID == 4 and subclassID == 0) -- Trinket class/subclass
    local options = { parseAllStats = not isTrinket }
    local result = self:ParseTooltip(tooltipText, options)

    -- CRITICAL FIX: Check if trinket has no proc lines (incomplete tooltip data)
    -- On initial load, tooltip proc lines like "Use:" or "Equip:" may not be loaded yet
    -- Returning pendingData=true prevents storing incomplete trinket data with -1 stat values
    if isTrinket and result and not result.pendingData then
        if #result.procs == 0 and #result.stats == 0 then
            -- Trinket tooltip has no proc/stat lines - mark as pending
            if self.debug then
                self:Debug("ParseItemTooltip: Trinket %d has no proc lines - marking as pending", itemId)
            end
            return {
                stats = {},
                procs = {},
                cooldowns = {},
                pendingData = true,
                itemId = itemId
            }
        end
    end

    return result
end

-- ============================ CACHING SYSTEM ============================

--- Get cached result for text
--- @param text string Text to look up
--- @return table|nil Cached result or nil
function TooltipParser:GetCachedResult(text)
    local cache = self.state.cache
    local entry = cache[text]

    if entry and (GetTime() - entry.timestamp) < self.db.global.cacheTTL then
        return entry.result
    end

    return nil
end

--- Cache result for text
--- @param text string Text to cache
--- @param result table Result to cache
function TooltipParser:CacheResult(text, result)
    local cache = self.state.cache

    -- Check cache size limit
    if self.state.cacheStats.size >= self.db.global.cacheMaxSize then
        -- Remove oldest entry
        local oldestKey = nil
        local oldestTime = GetTime()
        for key, entry in pairs(cache) do
            if entry.timestamp < oldestTime then
                oldestTime = entry.timestamp
                oldestKey = key
            end
        end
        if oldestKey then
            cache[oldestKey] = nil
            self.state.cacheStats.size = self.state.cacheStats.size - 1
        end
    end

    -- Add new entry
    cache[text] = {
        result = result,
        timestamp = GetTime()
    }
    self.state.cacheStats.size = self.state.cacheStats.size + 1
end

--- Clear the cache
function TooltipParser:ClearCache()
    wipe(self.state.cache)
    self.state.cacheStats.size = 0
    self.state.cacheStats.hits = 0
    self.state.cacheStats.misses = 0
end

--- Get cache statistics
--- @return table Cache statistics
function TooltipParser:GetCacheStats()
    return {
        size = self.state.cacheStats.size,
        maxSize = self.db.global.cacheMaxSize,
        enabled = self.db.global.cacheEnabled,
        hits = self.state.cacheStats.hits,
        misses = self.state.cacheStats.misses
    }
end

-- ============================ UTILITY FUNCTIONS ============================

--- Find duration in text using WoW GlobalString patterns (locale-agnostic)
--- @param text string Text to search
--- @return number Duration in seconds
function TooltipParser:FindDuration(text)
    if not text then return 0 end

    -- Remove percent-bearing numbers (e.g., "20% chance") to avoid
    -- mis-detecting them as time values when duration/cooldown also appear
    local cleanText = gsub(text, "%d+%%%s*", "")
    local lowerText = strlower(cleanText)

    -- Try WoW GlobalString patterns (work for all locales)
    if self.durationPatterns then
        -- Try SPELL_DURATION_* time unit patterns (most specific)
        -- DISABLED: spellDays and spellHours are too greedy (see InitializeDurationPatterns)
        --[[
        if self.durationPatterns.spellDays then
            local value = strmatch(lowerText, self.durationPatterns.spellDays)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 86400
                if result > 0 then
                    if self.debug then
                        self:Debug("FindDuration: Matched spellDays pattern, value=%d, result=%d", tonumber(cleanNumber(value)) or 0, result)
                    end
                    return result
                end
            end
        end

        if self.durationPatterns.spellHours then
            local value = strmatch(lowerText, self.durationPatterns.spellHours)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 3600
                if result > 0 then
                    if self.debug then
                        self:Debug("FindDuration: Matched spellHours pattern, value=%d, result=%d", tonumber(cleanNumber(value)) or 0, result)
                    end
                    return result
                end
            end
        end
        ]]

        if self.durationPatterns.spellMin then
            local value = strmatch(lowerText, self.durationPatterns.spellMin)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 60
                if result > 0 then
                    if self.debug then
                        self:Debug("FindDuration: Matched spellMin pattern, value=%d, result=%d", tonumber(cleanNumber(value)) or 0, result)
                    end
                    return result
                end
            end
        end

        if self.durationPatterns.spellSec then
            local value = strmatch(lowerText, self.durationPatterns.spellSec)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    if self.debug then
                        self:Debug("FindDuration: Matched spellSec pattern, value=%d, result=%d", tonumber(cleanNumber(value)) or 0, result)
                    end
                    return result
                end
            end
        end

        -- Try INT_SPELL_DURATION_* patterns
        if self.durationPatterns.intSpellSec then
            local value = strmatch(lowerText, self.durationPatterns.intSpellSec)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end

        if self.durationPatterns.intSpellMin then
            local value = strmatch(lowerText, self.durationPatterns.intSpellMin)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 60
                if result > 0 then
                    return result
                end
            end
        end

        -- Try ITEM_DURATION_* patterns
        if self.durationPatterns.itemSec then
            local value = strmatch(lowerText, self.durationPatterns.itemSec)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end

        if self.durationPatterns.itemMin then
            local value = strmatch(lowerText, self.durationPatterns.itemMin)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 60
                if result > 0 then
                    return result
                end
            end
        end

        -- Try fallback "for X sec/min" patterns
        if self.durationPatterns.forSec then
            local value = strmatch(lowerText, self.durationPatterns.forSec)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end

        if self.durationPatterns.forMin then
            local value = strmatch(lowerText, self.durationPatterns.forMin)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 60
                if result > 0 then
                    return result
                end
            end
        end
    end

    -- Proximity fallback: Search for numbers near duration keywords (sec/min)
    if self.durationKeywords then
        -- Try seconds keyword first
        if self.durationKeywords.sec then
            local value = self:ProximitySearchForKeyword(text, self.durationKeywords.sec, 30)
            if value then
                if self.debug then
                    self:Debug("FindDuration: Proximity fallback found %d seconds", value)
                end
                return value
            end
        end

        -- Try minutes keyword
        if self.durationKeywords.min then
            local value = self:ProximitySearchForKeyword(text, self.durationKeywords.min, 30)
            if value then
                if self.debug then
                    self:Debug("FindDuration: Proximity fallback found %d minutes", value)
                end
                return value * 60
            end
        end
    end

    return 0
end

--- Find cooldown in text using WoW GlobalString patterns (locale-agnostic)
--- @param text string Text to search
--- @return number Cooldown in seconds
function TooltipParser:FindCooldown(text)
    if not text then return 0 end

    -- Remove percent-bearing numbers (e.g., "15% chance") so only real
    -- time values (sec/min) are considered for cooldown parsing
    local cleanText = gsub(text, "%d+%%%s*", "")
    local lowerText = strlower(cleanText)

    -- Try WoW GlobalString patterns first (work for all locales)
    if self.cooldownPatterns then
        if self.cooldownPatterns.totalDays then
            local value = strmatch(lowerText, self.cooldownPatterns.totalDays)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 86400
                if result > 0 then
                    return result
                end
            end
        end

        if self.cooldownPatterns.totalHours then
            local value = strmatch(lowerText, self.cooldownPatterns.totalHours)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 3600
                if result > 0 then
                    return result
                end
            end
        end

        if self.cooldownPatterns.totalMin then
            local value = strmatch(lowerText, self.cooldownPatterns.totalMin)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 60
                if result > 0 then
                    return result
                end
            end
        end

        if self.cooldownPatterns.totalSec then
            local value = strmatch(lowerText, self.cooldownPatterns.totalSec)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end

        -- Try generic fallback patterns (in case GlobalStrings don't exist)
        if self.cooldownPatterns.genericDays then
            local value = strmatch(lowerText, self.cooldownPatterns.genericDays)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 86400
                if result > 0 then
                    return result
                end
            end
        end

        if self.cooldownPatterns.genericHours then
            local value = strmatch(lowerText, self.cooldownPatterns.genericHours)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 3600
                if result > 0 then
                    return result
                end
            end
        end

        if self.cooldownPatterns.genericMin then
            local value = strmatch(lowerText, self.cooldownPatterns.genericMin)
            if value then
                local result = (tonumber(cleanNumber(value)) or 0) * 60
                if result > 0 then
                    return result
                end
            end
        end

        if self.cooldownPatterns.genericSec then
            local value = strmatch(lowerText, self.cooldownPatterns.genericSec)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end
    end

    -- Proximity fallback: Search for numbers near cooldown keywords (sec/min)
    if self.cooldownKeywords then
        -- Try minutes keyword first (cooldowns are typically in minutes)
        if self.cooldownKeywords.min then
            local value = self:ProximitySearchForKeyword(text, self.cooldownKeywords.min, 30)
            if value then
                if self.debug then
                    self:Debug("FindCooldown: Proximity fallback found %d minutes", value)
                end
                return value * 60
            end
        end

        -- Try seconds keyword
        if self.cooldownKeywords.sec then
            local value = self:ProximitySearchForKeyword(text, self.cooldownKeywords.sec, 30)
            if value then
                if self.debug then
                    self:Debug("FindCooldown: Proximity fallback found %d seconds", value)
                end
                return value
            end
        end
    end

    return 0
end

--- Find stacks in text using WoW GlobalString patterns (locale-agnostic)
--- @param text string Text to search
--- @return number Number of stacks
function TooltipParser:FindStacks(text)
    if not text then return 0 end

    -- Normalize text to lowercase for pattern matching
    local lowerText = strlower(text)

    -- Try generic stack patterns (locale-independent structure)
    if self.stackPatterns then
        -- Try "up to X" pattern
        if self.stackPatterns.upTo then
            local value = strmatch(lowerText, self.stackPatterns.upTo)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end

        -- Try "maximum X" pattern
        if self.stackPatterns.maximum then
            local value = strmatch(lowerText, self.stackPatterns.maximum)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end

        -- Try "stacking" pattern
        if self.stackPatterns.stacking then
            local value = strmatch(lowerText, self.stackPatterns.stacking)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end

        -- Try "X times" pattern
        if self.stackPatterns.times then
            local value = strmatch(lowerText, self.stackPatterns.times)
            if value then
                local result = tonumber(cleanNumber(value)) or 0
                if result > 0 then
                    return result
                end
            end
        end
    end

    -- Proximity fallback: Search for numbers near stack-related keywords
    if self.stackKeywordsList then
        -- Try each keyword in priority order
        local priorityKeywords = {"stacks", "stack", "stacking", "maximum", "times"}
        for _, keyword in ipairs(priorityKeywords) do
            if self.stackKeywordsList[keyword] then
                local value = self:ProximitySearchForKeyword(text, keyword, 50)
                if value and value > 0 then
                    return value
                end
            end
        end
    end

    return 0
end

--- Find proc chance in text using WoW GlobalString patterns (locale-agnostic)
--- Handles both formats: inside parentheses "(15% chance)" and outside "4% chance to"
--- @param text string Text to search
--- @return number Chance percentage
function TooltipParser:FindProcChance(text)
    if not text then return 0 end

    -- Lowercase for case-insensitive matching (like duration/cooldown patterns)
    local lowerText = strlower(text)

    -- Try GARRISON_MISSION_PERCENT_CHANCE first (localized, works in all locales)
    -- Format: "%d%% Chance" - handles both inside/outside parentheses
    -- Available in: Mists, Cata (check via conditional)
    if GARRISON_MISSION_PERCENT_CHANCE then
        local pattern = self:ConvertGlobalStringToPattern(GARRISON_MISSION_PERCENT_CHANCE)
        if pattern then
            local value = strmatch(lowerText, pattern)
            if value then
                local result = tonumber(cleanNumber(value))
                if result and result > 0 then
                    if self.debug then
                        self:Debug("FindProcChance: Found %d%% via GARRISON_MISSION_PERCENT_CHANCE", result)
                    end
                    return result
                end
            end
        end
    end

    -- Fallback to English patterns for Classic era (Wrath/TBC/Vanilla) or if GlobalString fails
    local chancePatterns = {
        "(%d+)%%%s*chance",              -- "15% chance" or "4% chance"
        "chance to[^:]*:%s*(%d+)%%",     -- "chance to proc: 15%"
        "chance[^:]*:%s*(%d+)%%",        -- "chance on hit: 15%"
    }

    for _, pattern in ipairs(chancePatterns) do
        local chance = strmatch(lowerText, pattern)
        if chance then
            chance = tonumber(chance, 10)
            if chance then
                if self.debug then
                    self:Debug("FindProcChance: Found %d%% via English fallback pattern", chance)
                end
                return chance
            end
        end
    end

    return 0
end

--- Get empty result structure
--- @return table Empty result
function TooltipParser:GetEmptyResult()
    return {
        stats = {},
        procs = {},
        cooldowns = {}
    }
end

-- ============================ COMPATIBILITY API ============================
-- These methods provide compatibility with TooltipParsingManager

--- Analyze a trinket item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to analyze
--- @return table|nil Trinket analysis results
function TooltipParser:AnalyzeTrinket(itemId)
    if not itemId then return nil end

    -- Get item info
    local itemName, _, _, _, _, _, _, _, _, itemIcon = WoWAPI.GetItemInfo(itemId)
    if not itemName then
        if self.debug then
            self:Debug("AnalyzeTrinket: Item %d not cached yet", itemId)
        end
        return nil
    end

    -- Get DataManager entry for structured trinket data (used later for overrides)
    local trinketData = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)

    -- Parse the trinket's tooltip
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData or tooltipData.pendingData then
        if self.debug then
            self:Debug("AnalyzeTrinket: Failed to parse tooltip for trinket %d", itemId)
        end
        return nil
    end

    -- Extract buffId from multiple sources (like old TooltipParsingManager)
    local buffId = nil

    -- 1. Try structured trinket data (procEffects) first - this has the correct procId
    if trinketData and trinketData.procEffects and #trinketData.procEffects > 0 then
        local procEffect = trinketData.procEffects[1]
        if procEffect.procId then
            buffId = procEffect.procId  -- Use procId as buffId (the aura applied to player)
            self:Debug("Found buffId from structured trinket data (procId): %d", buffId)
        end
    end

    -- 2. Try DataManager related spells as fallback
    if not buffId then
        local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM, DataManager.EntityTypes.SPELL)
        if relatedSpells then
            local firstSpellId = next(relatedSpells)
            if firstSpellId then
                buffId = firstSpellId
                self:Debug("Found buffId from DataManager related spells: %d", buffId)
            end
        end
    end

    -- 3. Try GetItemSpell as fallback
    -- GetItemSpell returns multiple values: (spellName, spellID)
    if not buffId then
        local itemSpellName, itemSpellId = GetItemSpell(itemId)
        if itemSpellName and itemSpellId then
            buffId = itemSpellId
            self:Debug("Found buffId from GetItemSpell: %d (%s)", buffId, itemSpellName)
        end
    end

    -- 4. Try to extract from tooltip text (spell links)
    if not buffId and tooltipData.procs and #tooltipData.procs > 0 then
        for _, proc in ipairs(tooltipData.procs) do
            if proc.text then
                local spellId = self:ExtractSpellIdFromText(proc.text)
                if spellId then
                    buffId = spellId
                    self:Debug("Found buffId from tooltip text: %d", buffId)
                    break
                end
            end
        end
    end

    -- CRITICAL: Prioritize DataManager structured data for duration/ICD (most reliable)
    -- This overrides tooltip parsing when we have curated data
    if trinketData then
        -- Check procEffects for proc trinkets
        if trinketData.procEffects and #trinketData.procEffects > 0 then
            local procEffect = trinketData.procEffects[1]

            -- Override tooltip-parsed duration if DataManager has it
            if procEffect.duration and procEffect.duration > 0 then
                -- Update the procs array duration
                if tooltipData.procs and #tooltipData.procs > 0 then
                    for _, proc in ipairs(tooltipData.procs) do
                        proc.duration = procEffect.duration
                    end
                end
                self:Debug("AnalyzeTrinket: Using procEffect.duration from DataManager: %d", procEffect.duration)
            end

            -- Override tooltip-parsed ICD if DataManager has it
            if procEffect.icd and procEffect.icd > 0 then
                -- Update the procs array cooldown
                if tooltipData.procs and #tooltipData.procs > 0 then
                    for _, proc in ipairs(tooltipData.procs) do
                        proc.cooldown = procEffect.icd
                    end
                end
                self:Debug("AnalyzeTrinket: Using procEffect.icd from DataManager: %d", procEffect.icd)
            end
        end

        -- Check useEffects for use trinkets
        if trinketData.useEffects and #trinketData.useEffects > 0 then
            local useEffect = trinketData.useEffects[1]

            -- Override tooltip-parsed duration if DataManager has it
            if useEffect.duration and useEffect.duration > 0 then
                if tooltipData.procs and #tooltipData.procs > 0 then
                    for _, proc in ipairs(tooltipData.procs) do
                        proc.duration = useEffect.duration
                    end
                end
                self:Debug("AnalyzeTrinket: Using useEffect.duration from DataManager: %d", useEffect.duration)
            end

            -- Override tooltip-parsed ICD if DataManager has it
            if useEffect.icd and useEffect.icd > 0 then
                if tooltipData.procs and #tooltipData.procs > 0 then
                    for _, proc in ipairs(tooltipData.procs) do
                        proc.cooldown = useEffect.icd
                    end
                end
                self:Debug("AnalyzeTrinket: Using useEffect.icd from DataManager: %d", useEffect.icd)
            end
        end
    end

    -- Create a standardized trinket info structure (compatible with TooltipParsingManager)
    local trinketInfo = {
        itemId = itemId,
        name = itemName or "Unknown",
        icon = itemIcon,
        procStats = tooltipData.stats or {},
        procType = self:GetProcTypeFromProcs(tooltipData.procs),
        buffId = buffId,
        icd = self:GetCooldownFromProcs(tooltipData.procs),
        duration = self:GetDurationFromProcs(tooltipData.procs),
        procChance = self:GetChanceFromProcs(tooltipData.procs),
        stacks = self:GetStacksFromProcs(tooltipData.procs),
        isProc = self:GetProcTypeFromProcs(tooltipData.procs) == "proc",
        isUse = self:GetProcTypeFromProcs(tooltipData.procs) == "use",
        -- Stat type fields for Aura Sets tracking (convert string names to enum values)
        statType1 = self:ConvertStatTypeToEnum(tooltipData.stats and tooltipData.stats[1] and tooltipData.stats[1].type),
        statType2 = self:ConvertStatTypeToEnum(tooltipData.stats and tooltipData.stats[2] and tooltipData.stats[2].type),
        statType3 = self:ConvertStatTypeToEnum(tooltipData.stats and tooltipData.stats[3] and tooltipData.stats[3].type),
    }

    -- Summary info for successful analysis
    self:Info("AnalyzeTrinket(%d): %d stats, procType=%s, chance=%d%%, duration=%d, icd=%d, stacks=%d, statTypes=[%s,%s,%s]",
        itemId, #(tooltipData.stats or {}), tostring(trinketInfo.procType),
        trinketInfo.procChance or 0, trinketInfo.duration or 0, trinketInfo.icd or 0, trinketInfo.stacks or 0,
        tostring(trinketInfo.statType1), tostring(trinketInfo.statType2), tostring(trinketInfo.statType3))

    return trinketInfo
end

--- Get stat from aura (compatibility with TooltipParsingManager)
--- @param unit string The unit to scan (e.g., "player")
--- @param auraIdentifier number|string The spell ID (number) or name (string) of the aura to find
--- @param statType number The stat type constant from the Types module to parse
--- @return number The value of the stat found, or 0 if not found
function TooltipParser:GetStatFromAura(unit, auraIdentifier, statType)
    local scanningTooltip = self.state.scanningTooltip
    if not scanningTooltip then
        self:Debug("GetStatFromAura: No scanning tooltip available")
        return 0
    end

    self:Debug("GetStatFromAura: Looking for aura %s (type: %s) on unit %s for stat type %d",
        tostring(auraIdentifier), type(auraIdentifier), unit, statType)

    local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3, value4

    -- Find the aura and get its index for tooltip scanning
    local auraIndex = nil

    if type(auraIdentifier) == "number" then
        local aura = NAG:UnitAura(unit, auraIdentifier, "HELPFUL")

        if not aura then
            self:Debug("GetStatFromAura: Aura with spell ID %d not found on unit %s", auraIdentifier, unit)
            return 0
        end

        name = aura.name
        spellId = aura.spellId
        self:Debug("GetStatFromAura: Found aura by spell ID: name='%s', spellId=%d", name, spellId or 0)

        -- Find the index for SetUnitAura using the aura name (more reliable)
        local i = 1
        while true do
            --TODO: Change to NAG:UnitAura?
            local checkName, checkSpellId = UnitAura(unit, i, "HELPFUL")
            if not checkName then break end
            --self:Debug("GetStatFromAura: Checking index %d: name='%s', spellId=%d (looking for name '%s' or spellId %d)", i, checkName, checkSpellId or 0, name, auraIdentifier)
            if checkName == name or checkSpellId == auraIdentifier then
                auraIndex = i
                --self:Debug("GetStatFromAura: Found aura index %d for name '%s' (spellId %d)", i, name, checkSpellId or 0)
                break
            end
            i = i + 1
        end
    else
        -- Fall back to iteration for string-based lookup
        local i = 1
        while true do
            -- NAG: version doesn't support index, so we use the global UnitAura
            --TODO: Change to NAG:UnitAura?
            name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3, value4 = UnitAura(unit, i, "HELPFUL")
            if not name then break end

            self:Debug("GetStatFromAura: Checking aura %d: name='%s', spellId=%d", i, name, spellId or 0)

            -- Case-insensitive name comparison for aura lookup
            if name:lower() == auraIdentifier:lower() then
                self:Debug("GetStatFromAura: Found matching aura by name: name='%s', spellId=%d", name, spellId or 0)
                auraIndex = i
                break
            end
            i = i + 1
        end

        if not name then
            self:Debug("GetStatFromAura: Aura with name '%s' not found on unit %s", auraIdentifier, unit)
            return 0
        end
    end

    -- Set up tooltip to scan the aura
    scanningTooltip:SetOwner(UIParent, "ANCHOR_NONE")
    if auraIndex then
        self:Debug("GetStatFromAura: Setting tooltip for aura index %d", auraIndex)
        scanningTooltip:SetUnitAura(unit, auraIndex, "HELPFUL")
    else
        self:Debug("GetStatFromAura: Could not find aura index for tooltip scanning")
        return 0
    end

    -- Parse tooltip lines for stat values
    for j = 2, scanningTooltip:NumLines() do
        local tooltipTextWidget = _G[scanningTooltip:GetName() .. "TextLeft" .. j]
        if tooltipTextWidget then
            local text = tooltipTextWidget:GetText()
            if text then
                self:Debug("GetStatFromAura: Checking tooltip line %d: '%s'", j, text)
                local value = self:ParseStatValueFromLine(text, statType)
                if value and value > 0 then
                    self:Debug("GetStatFromAura: Found stat value %d in line: '%s'", value, text)
                    scanningTooltip:Hide()
                    return value
                end
            end
        end
    end
    self:Debug("GetStatFromAura: No stat value found in aura tooltip")
    scanningTooltip:Hide()
    return 0
end

--- Check if item has a specific stat (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @param statType number Stat type to look for
--- @return boolean True if item has the stat
function TooltipParser:ItemHasStat(itemId, statType)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return false end

    for _, stat in ipairs(tooltipData.stats or {}) do
        if stat.type == statType then
            return true
        end
    end
    return false
end

--- Get all stats from an item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @return table Array of stat types
function TooltipParser:GetItemStats(itemId)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return {} end

    local stats = {}
    for _, stat in ipairs(tooltipData.stats or {}) do
        tinsert(stats, stat.type)
    end
    return stats
end

--- Get proc type from an item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @return string|nil Proc type ("proc", "use", or nil)
function TooltipParser:GetItemProcType(itemId)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return nil end

    return self:GetProcTypeFromProcs(tooltipData.procs)
end

--- Get effect duration from an item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @return number Duration in seconds
function TooltipParser:GetItemEffectDuration(itemId)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return 0 end

    return self:GetDurationFromProcs(tooltipData.procs)
end

--- Get internal cooldown from an item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @return number ICD in seconds
function TooltipParser:GetItemInternalCooldown(itemId)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return 0 end

    return self:GetCooldownFromProcs(tooltipData.procs)
end

--- Check if item is a stat item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @return boolean True if item has proc effects
function TooltipParser:IsStatItem(itemId)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return false end

    return #(tooltipData.procs or {}) > 0
end

--- Check if item is a proc item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @return boolean True if item has proc effects
function TooltipParser:IsProcItem(itemId)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return false end

    return self:GetProcTypeFromProcs(tooltipData.procs) == "proc"
end

--- Check if item is a use item (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to check
--- @return boolean True if item has use effects
function TooltipParser:IsUseItem(itemId)
    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return false end

    return self:GetProcTypeFromProcs(tooltipData.procs) == "use"
end

--- Dump item data for debugging (compatibility with TooltipParsingManager)
--- @param itemId number Item ID to dump
--- @return string Debug information
function TooltipParser:DumpItemData(itemId)
    -- Check if item exists first
    local itemName = WoWAPI.GetItemInfo(itemId)
    if not itemName then
        return "No data found for item " .. tostring(itemId)
    end

    local tooltipData = self:ParseItemTooltip(itemId)
    if not tooltipData then return "No data found for item " .. tostring(itemId) end
    local output = format("Item: %s (ID: %d)\n", itemName, itemId)

    -- Add stats
    output = output .. "Stats:\n"
    if #(tooltipData.stats or {}) == 0 then
        output = output .. "  None detected\n"
    else
        for _, stat in ipairs(tooltipData.stats) do
            output = output .. format("  %s: %d%s\n", stat.type, stat.value, stat.isPercent and "%" or "")
        end
    end

    -- Add procs
    output = output .. "Procs:\n"
    if #(tooltipData.procs or {}) == 0 then
        output = output .. "  None detected\n"
    else
        for i, proc in ipairs(tooltipData.procs) do
            output = output .. format("  %d: duration=%d, cooldown=%d, chance=%d\n",
                i, proc.duration or 0, proc.cooldown or 0, proc.chance or 0)
        end
    end

    -- Add cooldowns
    output = output .. "Cooldowns:\n"
    if #(tooltipData.cooldowns or {}) == 0 then
        output = output .. "  None detected\n"
    else
        for i, cooldown in ipairs(tooltipData.cooldowns) do
            output = output .. format("  %d: duration=%d\n", i, cooldown.duration or 0)
        end
    end

    return output
end

--- Get weapon damage from an item (compatibility with TooltipParsingManager)
--- @param itemLinkOrId string|number The item link (preferred) or item ID to scan
--- @return table|nil Table with fields: itemId, min, max, name
function TooltipParser:GetWeaponDamage(itemLinkOrId)
    if not itemLinkOrId then return nil end
    local scanningTooltip = self.state.scanningTooltip
    if not scanningTooltip then return nil end

    scanningTooltip:ClearLines()
    if type(itemLinkOrId) == "string" and strfind(itemLinkOrId, "item:") then
        scanningTooltip:SetHyperlink(itemLinkOrId)
    else
        scanningTooltip:SetHyperlink("item:" .. tostring(itemLinkOrId))
    end

    local minDmg, maxDmg
    for i = 2, math.min(10, scanningTooltip:NumLines()) do
        local lineObj = _G[scanningTooltip:GetName() .. "TextLeft" .. i]
        if lineObj then
            local line = lineObj:GetText()
            if line then
                -- Look for a pattern like '9,462 - 14,194 Damage' or '123 - 456 Damage'
                local min, max = strmatch(line, "([%d,]+)%s*%-%s*([%d,]+)")
                if min and max then
                    minDmg = tonumber(gsub(min, ',', ''), 10)
                    maxDmg = tonumber(gsub(max, ',', ''), 10)
                    break
                end
            end
        end
    end

    local itemId = nil
    local name = nil
    if type(itemLinkOrId) == "string" and strfind(itemLinkOrId, "item:") then
        itemId = tonumber(strmatch(itemLinkOrId, "item:(%d+)") or "", 10)
        name = select(1, WoWAPI.GetItemInfo(itemLinkOrId))
    else
        itemId = itemLinkOrId
        name = select(1, WoWAPI.GetItemInfo(itemId))
    end

    if minDmg and maxDmg then
        return {
            itemId = itemId,
            min = minDmg,
            max = maxDmg,
            name = name
        }
    end

    return nil
end

-- ============================ HELPER FUNCTIONS ============================

--- Extract spell ID from tooltip text (spell links)
--- @param text string Text to search for spell links
--- @return number|nil Spell ID if found
function TooltipParser:ExtractSpellIdFromText(text)
    if not text then return nil end

    -- Look for spell links like |cff71d5ff|Hspell:12345|h[Spell Name]|h|r
    local spellId = strmatch(text, "|Hspell:(%d+)")
    if spellId then
        return tonumber(spellId, 10)
    end

    return nil
end

--- Get proc type from procs array
--- @param procs table Array of proc data
--- @return string|nil Proc type
function TooltipParser:GetProcTypeFromProcs(procs)
    if not procs or #procs == 0 then return nil end

    -- Check if any proc has "use" source
    for _, proc in ipairs(procs) do
        if proc.source == "use" then
            return "use"
        end
    end

    -- Check if any proc has "proc" source
    for _, proc in ipairs(procs) do
        if proc.source == "proc" then
            return "proc"
        end
    end

    return nil
end

--- Get cooldown from procs array
--- @param procs table Array of proc data
--- @return number Cooldown in seconds
function TooltipParser:GetCooldownFromProcs(procs)
    if not procs or #procs == 0 then return 0 end

    -- Return the highest cooldown found
    local maxCooldown = 0
    for _, proc in ipairs(procs) do
        if proc.cooldown and proc.cooldown > maxCooldown then
            maxCooldown = proc.cooldown
        end
    end

    return maxCooldown
end

--- Get duration from procs array
--- @param procs table Array of proc data
--- @return number Duration in seconds
function TooltipParser:GetDurationFromProcs(procs)
    if not procs or #procs == 0 then return 0 end

    -- Return the highest duration found
    local maxDuration = 0
    for _, proc in ipairs(procs) do
        if proc.duration and proc.duration > maxDuration then
            maxDuration = proc.duration
        end
    end

    return maxDuration
end

--- Get chance from procs array
--- @param procs table Array of proc data
--- @return number Chance percentage
function TooltipParser:GetChanceFromProcs(procs)
    if not procs or #procs == 0 then return 0 end

    -- Return the highest chance found
    local maxChance = 0
    for _, proc in ipairs(procs) do
        if proc.chance and proc.chance > maxChance then
            maxChance = proc.chance
        end
    end

    return maxChance
end

--- Get stacks from procs array
--- @param procs table Array of proc data
--- @return number Number of stacks
function TooltipParser:GetStacksFromProcs(procs)
    if not procs or #procs == 0 then return 0 end

    -- Return the highest stack count found
    local maxStacks = 0
    for _, proc in ipairs(procs) do
        if proc.stacks and proc.stacks > maxStacks then
            maxStacks = proc.stacks
        end
    end

    return maxStacks
end

--- Parse stat value from a line (used by GetStatFromAura)
--- @param line string Line to parse
--- @param statType number|string Stat type to look for (number from Types module or string name)
--- @return number|nil Stat value found
function TooltipParser:ParseStatValueFromLine(line, statType)
    if not line or not statType then return nil end

    local foundValue

    -- Convert numeric stat type to string name if needed
    local statTypeString = statType
    if type(statType) == "number" then
        -- Get the string name from Types module
        if Types then
            local statEnum = Types:GetType("Stat")
            if statEnum and statEnum._values then
                self:Debug("ParseStatValueFromLine: Converting numeric stat type %d to string", statType)
                -- Find the string name for this numeric value using _values (clean keys)
                for name, value in pairs(statEnum._values) do
                    if value == statType then
                        statTypeString = name
                        self:Debug("ParseStatValueFromLine: Found matching stat name: '%s' for value %d", name, statType)
                        break
                    end
                end
            else
                self:Debug("ParseStatValueFromLine: Could not access statEnum._values")
            end
        else
            self:Debug("ParseStatValueFromLine: Could not get Types module")
        end
    end

    self:Debug("ParseStatValueFromLine: Looking for stat type '%s' in line: '%s'", tostring(statTypeString), line)

    -- Look for stat patterns in the line using pre-compiled patterns
    for pattern, patternData in pairs(self.statIDLookup) do
        local statTypes = patternData.statTypes
        local luaPattern = patternData.luaPattern

        for _, targetStatType in ipairs(statTypes) do
            if targetStatType == statTypeString then
                self:Debug("ParseStatValueFromLine: Found matching pattern '%s' for stat type '%s'", pattern, statTypeString)
                -- Direct pattern matching - no lowercasing
                local value = strmatch(line, luaPattern)
                if value then
                    value = tonumber(gsub(value, ",", ""), 10)
                    if value and (not foundValue or value > foundValue) then
                        foundValue = value
                        self:Debug("ParseStatValueFromLine: Found value %d for stat type '%s'", value, statTypeString)
                    end
                end
            end
        end
    end

    return foundValue
end

-- ============================ TESTING FUNCTIONS ============================

--- Test function to verify stat type conversion works correctly
--- @usage /run NAG:GetModule("TooltipParser"):TestStatTypeConversion()
function TooltipParser:TestStatTypeConversion()
    self:Info("Testing stat type conversion...")

    local statEnum = Types:GetType("Stat")
    if not statEnum or not statEnum._values then
        self:Error("Could not get Stat enum or _values")
        return
    end

    self:Info("Stat enum _values contains:")
    for name, value in pairs(statEnum._values) do
        self:Info("  %s = %d", name, value)
    end

    -- Test ATTACK_POWER conversion
    local testValue = 13 -- ATTACK_POWER
    local foundName = nil
    for name, value in pairs(statEnum._values) do
        if value == testValue then
            foundName = name
            break
        end
    end

    if foundName then
        self:Info("SUCCESS: Found stat name '%s' for value %d", foundName, testValue)
    else
        self:Error("FAILED: Could not find stat name for value %d", testValue)
    end
end

--- Parse spell tooltip by spell ID (works without active aura)
--- @param spellId number Spell ID to parse
--- @return table Parsed result with stats detected
function TooltipParser:ParseSpellTooltip(spellId)
    if not spellId or type(spellId) ~= "number" then
        return self:GetEmptyResult()
    end

    local scanningTooltip = self.state.scanningTooltip
    if not scanningTooltip then
        self:Error("ParseSpellTooltip: No scanning tooltip available")
        return self:GetEmptyResult()
    end

    -- Set tooltip to the spell (no active aura needed!)
    scanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    scanningTooltip:ClearLines()
    scanningTooltip:SetSpellByID(spellId)

    -- Extract tooltip text
    local tooltipText = ""
    for i = 1, scanningTooltip:NumLines() do
        local line = _G[scanningTooltip:GetName() .. "TextLeft" .. i]
        if line and line:GetText() then
            tooltipText = tooltipText .. line:GetText() .. "\n"
        end
    end

    scanningTooltip:Hide()

    -- Parse the tooltip text (parse all stats, not just proc stats)
    return self:ParseTooltip(tooltipText, {parseAllStats = true})
end

--- Clear tooltip parser cache (slash command handler)
--- @usage /nag ttclear
function TooltipParser:ClearCacheCommand()
    self:ClearCache()
    self:Info("Tooltip parser cache cleared! Next parse will be fresh.")
end

--- Test aura stat parsing - scans player buffs and shows detected stats
--- @param args string Optional spell ID to test specific buff/spell
--- @usage /nag ttparse
--- @usage /nag ttparse 67771  (Death's Choice buff - works without buff active!)
function TooltipParser:TestAuraStatParsing(args)
    local statEnum = Types:GetType("Stat")
    if not statEnum then
        self:Error("Could not get Stat enum")
        return
    end

    -- If args provided, test specific spell/buff (no active aura required!)
    if args and args ~= "" then
        local spellId = tonumber(args)
        if not spellId then
            self:Error("Invalid spell ID: %s", args)
            return
        end

        self:Info("=== Parsing Spell Tooltip for Spell ID %d ===", spellId)

        -- Parse spell tooltip (works without buff being active!)
        local result = self:ParseSpellTooltip(spellId)

        -- GetSpellInfo returns a table via ns.WoWAPI registry
        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local spellName = spellInfo and spellInfo.name or "Unknown"
        self:Info("Spell: %s (ID: %d)", spellName, spellId)

        -- Show detected stats
        if result.stats and #result.stats > 0 then
            self:Info("Stats detected:")
            for _, stat in ipairs(result.stats) do
                self:Info("  %s: %d%s", stat.type, stat.value, stat.isPercent and "%" or "")
            end
        else
            self:Info("No stats detected")
        end

        -- Show detected procs
        if result.procs and #result.procs > 0 then
            self:Info("Procs detected:")
            for i, proc in ipairs(result.procs) do
                self:Info("  Proc %d: duration=%d, cooldown=%d, chance=%d, stacks=%d",
                    i, proc.duration or 0, proc.cooldown or 0, proc.chance or 0, proc.stacks or 0)
            end
        else
            self:Info("No procs detected")
        end

        return
    end

    -- No args - scan ALL player buffs
    self:Info("=== Scanning All Player Buffs ===")

    local i = 1
    local foundAuras = 0
    while true do
        local aura = NAG:UnitAura("player", i, "HELPFUL")
        if not aura then break end

        -- Scan this aura for stats
        local auraStats = {}
        for statName, statValue in pairs(statEnum._values) do
            local value = self:GetStatFromAura("player", aura.spellId, statValue)
            if value > 0 then
                auraStats[statName] = value
            end
        end

        -- Print if any stats found
        if next(auraStats) then
            foundAuras = foundAuras + 1
            self:Info("Aura %d: %s (spellId: %d)", i, aura.name, aura.spellId)
            for statName, value in pairs(auraStats) do
                self:Info("  %s: %d", statName, value)
            end
        end

        i = i + 1
    end

    if foundAuras == 0 then
        self:Info("No stat-buffing auras found on player")
    else
        self:Info("=== Found %d stat-buffing auras ===", foundAuras)
    end
end

--- Test item/trinket parsing - shows all detected stats, procs, and stacks
--- @param args string Optional item ID to test (defaults to equipped trinkets)
--- @usage /nag ttitem           (test equipped trinkets)
--- @usage /nag ttitem 48021  (Eitrigg's Oath)
--- @usage /nag ttitem 47464  (Death's Choice)
function TooltipParser:TestItemParsing(args)
    -- If no arguments, test equipped trinkets
    if not args or args == "" then
        self:Info("=== Testing Equipped Trinkets ===")

        -- Trinket slots are 13 and 14
        local trinket1Link = GetInventoryItemLink("player", 13)
        local trinket2Link = GetInventoryItemLink("player", 14)

        if not trinket1Link and not trinket2Link then
            self:Warn("No trinkets equipped!")
            self:Info("Usage: /nag ttitem <itemID> to test a specific item")
            return
        end

        -- Test trinket 1
        if trinket1Link then
            local itemId = tonumber(strmatch(trinket1Link, "item:(%d+)"))
            if itemId then
                self:Info("") -- Blank line for readability
                self:Info("=== TRINKET SLOT 1 ===")
                self:TestSingleItem(itemId)
            end
        else
            self:Info("Trinket slot 1: Empty")
        end

        -- Test trinket 2
        if trinket2Link then
            local itemId = tonumber(strmatch(trinket2Link, "item:(%d+)"))
            if itemId then
                self:Info("") -- Blank line for readability
                self:Info("=== TRINKET SLOT 2 ===")
                self:TestSingleItem(itemId)
            end
        else
            self:Info("Trinket slot 2: Empty")
        end

        return
    end

    -- If arguments provided, test specific item
    local itemId = tonumber(args)
    if not itemId then
        self:Error("Invalid item ID: %s", args)
        return
    end

    self:TestSingleItem(itemId)
end

--- Test a single item by ID (helper for TestItemParsing)
--- @param itemId number Item ID to test
function TooltipParser:TestSingleItem(itemId)

    self:Info("=== Analyzing Item %d ===", itemId)

    -- ALWAYS clear cache for testing to get fresh debug output
    self:ClearCache()
    self:Debug("Cache cleared for fresh parse with debug output")

    -- Get item info
    local itemName, itemLink = WoWAPI.GetItemInfo(itemId)
    if not itemName then
        self:Warn("Item %d not in cache - trying to load...", itemId)
        return
    end

    self:Info("Item: %s", itemName)

    -- DUMP THE TOOLTIP TEXT FIRST
    if self.debug then
        local tooltipName = "NAGTooltipParserItemTooltip" .. itemId
        local tooltip = _G[tooltipName]
        if not tooltip then
            tooltip = CreateFrame("GameTooltip", tooltipName, nil, "GameTooltipTemplate")
        end
        tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        tooltip:ClearLines()
        tooltip:SetHyperlink(itemLink)

        self:Debug("=== RAW TOOLTIP TEXT ===")
        for i = 1, tooltip:NumLines() do
            local line = _G[tooltipName .. "TextLeft" .. i]
            if line and line:GetText() then
                self:Debug("Line %d: '%s'", i, line:GetText())
            end
        end
        self:Debug("=== END TOOLTIP TEXT ===")
        tooltip:Hide()
    end

    -- Analyze the trinket
    local result = self:AnalyzeTrinket(itemId)

    if not result then
        self:Error("Failed to analyze item")
        return
    end

    if result.pendingData then
        self:Warn("Item data pending - try again in a moment")
        return
    end

    -- Show results
    self:Info("Results:")
    self:Info("  Proc Type: %s", tostring(result.procType))
    self:Info("  Proc Chance: %d%%", result.procChance or 0)
    self:Info("  Duration: %d sec", result.duration or 0)
    self:Info("  ICD: %d sec", result.icd or 0)
    self:Info("  Stacks: %d", result.stacks or 0)
    self:Info("  BuffID: %s", tostring(result.buffId))

    if result.procStats and #result.procStats > 0 then
        self:Info("  Stats:")
        for _, stat in ipairs(result.procStats) do
            self:Info("    %s: %d%s", stat.type, stat.value, stat.isPercent and "%" or "")
        end
    end
end

-- ============================ MODULE LIFECYCLE ============================

function TooltipParser:ModuleInitialize()
    DataManager = NAG:GetModule("DataManager")
    Types = NAG:GetModule("Types")
    -- Initialize state
    self.state.cache = {}
    self.state.cacheStats = {
        size = 0,
        maxSize = self.db.global.cacheMaxSize,
        enabled = self.db.global.cacheEnabled,
        hits = 0,
        misses = 0
    }
    self.state.scanningTooltip = nil

    -- Create scanning tooltip frame if it doesn't exist
    if not self.state.scanningTooltip then
        self.state.scanningTooltip = CreateFrame("GameTooltip", "NAGTooltipParserScanningTooltip", nil, "GameTooltipTemplate")
        self.state.scanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    end

    -- Initialize patterns
    self:InitializeStatPatterns()

    -- Initialize duration/cooldown patterns from WoW GlobalStrings
    self:InitializeDurationPatterns()
end

function TooltipParser:ModuleEnable()
    -- Initialize patterns during module enable (not on first parse)
    -- This prevents potential stutter on first tooltip parse
    self:InitializeStatPatterns()
    self:InitializeDurationPatterns()

    -- CRITICAL: Clear cache on enable to invalidate stale results from previous sessions
    -- This ensures fresh parses with latest patterns after code changes (e.g., adding stack detection)
    self:ClearCache()

    self:Info("TooltipParser enabled - patterns initialized, cache cleared")
end

--- Handle GET_ITEM_INFO_RECEIVED event for async item loading
--- @param event string Event name
--- @param itemID number Item ID that was loaded
--- @param success boolean Whether the item data was successfully loaded
function TooltipParser:GET_ITEM_INFO_RECEIVED(event, itemID, success)
    if not success then
        if self.debug then
            self:Debug("GET_ITEM_INFO_RECEIVED: Failed to load item %d", itemID)
        end
        return
    end

    if self.debug then
        self:Debug("GET_ITEM_INFO_RECEIVED: Item %d data loaded", itemID)
    end
end

