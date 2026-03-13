--- @module "NAG.LocaleManager"
--- Centralized localization management for NAG addon
---
--- Provides a consistent API for all modules to access localized strings with proper fallbacks,
--- development tools for missing key detection, and automated maintenance capabilities.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local AceLocale = ns.AceLocale

-- ============================ PRIVATE HELPER FUNCTIONS ============================


local function LogMissingKey(key, module)
    if NAG:IsDevModeEnabled() then
        print(string.format("|cffff0000[NAG] Missing locale key:|r '%s' in module '%s'", key, module or "unknown"))
    end
end

--- Convert a constant value to proper English display text
--- @param value string The constant value (e.g., "left", "cooldowns", "spellLearner")
--- @return string The display text (e.g., "Left", "Cooldowns", "Spell Learner")
local function GenerateDisplayText(value)
    if not value or type(value) ~= "string" then
        return tostring(value or "")
    end

    -- Handle special cases first
    if value:upper() == value then
        -- All uppercase (like "AOE") - keep as-is
        return value
    end

    local result = value

    -- Handle camelCase - insert spaces before capital letters
    result = result:gsub("([a-z])([A-Z])", "%1 %2")

    -- Capitalize first letter of each word
    result = result:gsub("(%a)([%w_]*)", function(first, rest)
        return first:upper() .. rest:lower()
    end)

    return result
end

--- Generate auto-locale entries from ns constants
--- @param excludeExisting boolean If true, exclude keys that already exist in the manual locale table
--- @return table Auto-generated locale entries
local function GenerateAutoLocaleEntries(excludeExisting)
    local entries = {}

    if not ns.AUTO_LOCALE_CONSTANTS then
        return entries
    end

    -- Get existing manual locale entries if excluding
    local existingLocale = nil
    if excludeExisting then
        existingLocale = AceLocale:GetLocale("NAG", true)
    end

    for _, constantTableName in pairs(ns.AUTO_LOCALE_CONSTANTS) do
        local constantTable = ns[constantTableName]
        if constantTable and type(constantTable) == "table" then
            for _, value in pairs(constantTable) do
                if type(value) == "string" then
                    -- Check if already exists in manual locale
                    local skipMain = excludeExisting and existingLocale and existingLocale[value] and
                    existingLocale[value] ~= value
                    local descKey = value .. "Desc"
                    local skipDesc = excludeExisting and existingLocale and existingLocale[descKey] and
                    existingLocale[descKey] ~= descKey

                    -- Generate main entry: "left" -> "Left"
                    if not skipMain then
                        entries[value] = GenerateDisplayText(value)
                    end

                    -- Generate description entry: "leftDesc" -> "Left option"
                    if not skipDesc and not entries[descKey] then
                        entries[descKey] = GenerateDisplayText(value) .. " option"
                    end
                end
            end
        end
    end

    return entries
end

--- Generate template entries for translation with metadata
--- @param locale string The locale code (e.g., "enUS", "deDE")
--- @param englishValues table English values for reference
--- @return table Template entries with metadata
local function GenerateTranslationTemplate(locale, englishValues)
    local template = {}
    local isEnglish = (locale == "enUS")

    -- Group by constant table for organization
    local grouped = {}

    if not ns.AUTO_LOCALE_CONSTANTS then
        return template
    end

    for _, constantTableName in pairs(ns.AUTO_LOCALE_CONSTANTS) do
        local constantTable = ns[constantTableName]
        if constantTable and type(constantTable) == "table" then
            grouped[constantTableName] = {}

            for _, value in pairs(constantTable) do
                if type(value) == "string" then
                    local englishValue = englishValues[value]
                    local englishDesc = englishValues[value .. "Desc"]

                    if englishValue then
                        table.insert(grouped[constantTableName], {
                            key = value,
                            englishValue = englishValue,
                            templateValue = isEnglish and englishValue or "",
                            comment = not isEnglish and ("English: \"" .. englishValue .. "\"") or nil
                        })
                    end

                    if englishDesc then
                        table.insert(grouped[constantTableName], {
                            key = value .. "Desc",
                            englishValue = englishDesc,
                            templateValue = isEnglish and englishDesc or "",
                            comment = not isEnglish and ("English: \"" .. englishDesc .. "\"") or nil
                        })
                    end
                end
            end
        end
    end

    return grouped
end

-- ============================ MODULE ACCESS ============================
-- Module access and API localization

-- ============================ CONTENT ============================

--- @class LocaleManager
local LocaleManager = NAG:NewModule("LocaleManager", "AceEvent-3.0")

-- Private state
LocaleManager.private = {
    localeTable = nil,
    autoLocaleEntries = {},
    missingKeys = {},
    developmentMode = false,
    keyUsage = {}
}

function LocaleManager:OnInitialize()
    self.private.developmentMode = NAG:IsDevModeEnabled()

    -- Initialize the locale table with proper fallback handling
    self:InitializeLocale()

    -- Register development commands
    self:RegisterCommands()
end

function LocaleManager:InitializeLocale()
    -- Get the locale table with silent=true to match the locale files
    -- We'll handle warnings ourselves in development mode
    local localeTable = AceLocale:GetLocale("NAG", true)

    if not localeTable then
        error("Failed to initialize locale table for NAG")
    end

    -- Generate auto-locale entries from constants (exclude existing manual entries)
    self.private.autoLocaleEntries = GenerateAutoLocaleEntries(true)

    -- Create a proxy table with enhanced fallback handling
    local proxy = setmetatable({}, {
        __index = function(_, key)
            -- First try to get the value from the actual locale table
            local value = localeTable[key]

            if value and value ~= key then
                -- Track key usage for development
                if LocaleManager.private.developmentMode then
                    LocaleManager.private.keyUsage[key] = (LocaleManager.private.keyUsage[key] or 0) + 1
                end
                return value
            end

            -- Second, try auto-generated entries from constants
            local autoValue = LocaleManager.private.autoLocaleEntries[key]
            if autoValue then
                if LocaleManager.private.developmentMode then
                    LocaleManager.private.keyUsage[key] = (LocaleManager.private.keyUsage[key] or 0) + 1
                end
                return autoValue
            end

            -- Key is missing - log it and return the key as fallback
            if LocaleManager.private.developmentMode then
                LogMissingKey(key, LocaleManager.private.currentModule)
                LocaleManager.private.missingKeys[key] = true
            end

            return key
        end,

        __newindex = function(_, key, value)
            -- Prevent accidental writes to the locale table
            error("Cannot write to locale table - use locale files instead")
        end
    })

    -- Store the proxy
    self.private.localeTable = proxy
end

-- ============================ PUBLIC API ============================

--- Get the locale table for the current module
--- @param moduleName string The name of the requesting module (for debugging)
--- @return table The locale table with enhanced fallback handling
function LocaleManager:GetLocale(moduleName)
    self.private.currentModule = moduleName
    return self.private.localeTable
end

--- Get a localized string with fallback
--- @param key string The localization key
--- @param fallback string Optional fallback string if key is missing
--- @param moduleName string The name of the requesting module (for debugging)
--- @return string The localized string or fallback
function LocaleManager:GetString(key, fallback, moduleName)
    local localeTable = self:GetLocale(moduleName)
    local value = localeTable[key]

    if value and value ~= key then
        return value
    end

    -- Return fallback if provided, otherwise return the key
    return fallback or key
end

--- Check if a key exists in the current locale
--- @param key string The localization key to check
--- @return boolean True if the key exists and has a value
function LocaleManager:HasKey(key)
    if not self.private.localeTable then
        return false
    end

    local value = self.private.localeTable[key]
    return value and value ~= key
end

--- Get all missing keys (development only)
--- @return table Table of missing keys
function LocaleManager:GetMissingKeys()
    if not self.private.developmentMode then
        return {}
    end

    return self.private.missingKeys
end

--- Get key usage statistics (development only)
--- @return table Table of key usage counts
function LocaleManager:GetKeyUsage()
    if not self.private.developmentMode then
        return {}
    end

    return self.private.keyUsage
end

--- Get auto-generated locale entries (development only)
--- @return table Table of auto-generated entries
function LocaleManager:GetAutoLocaleEntries()
    if not self.private.developmentMode then
        return {}
    end

    return self.private.autoLocaleEntries
end

--- Export auto-generated entries to chat (development only)
function LocaleManager:ExportAutoGeneratedEntries()
    if not self.private.developmentMode then
        return
    end

    local autoEntries = self:GetAutoLocaleEntries()
    local count = 0

    print("|cff00ffff[NAG] Auto-generated locale entries:|r")
    for key, value in pairs(autoEntries) do
        print(string.format("  L[\"%s\"] = \"%s\"", key, value))
        count = count + 1
    end

    if count == 0 then
        print("  No auto-generated entries found!")
    else
        print(string.format("  Total auto-generated entries: %d", count))
    end
end

--- Generate translation template for a specific locale
--- @param locale string The locale code (e.g., "enUS", "deDE")
function LocaleManager:ExportTranslationTemplate(locale)
    if not self.private.developmentMode then
        return
    end

    -- Get English values as reference (include all auto-generated entries, not just missing ones)
    local englishEntries = GenerateAutoLocaleEntries(false)

    -- Generate template organized by constant groups
    local template = GenerateTranslationTemplate(locale or "enUS", englishEntries)

    print(string.format("|cff00ffff[NAG] Translation template for %s:|r", locale or "enUS"))
    print("|cffadd8e6Copy the following entries to your locale file:|r")
    print("")

    local totalCount = 0

    for constantTableName, entries in pairs(template) do
        if #entries > 0 then
            print(string.format("        -- Auto-generated from %s", constantTableName))

            for _, entry in pairs(entries) do
                if entry.comment then
                    print(string.format("        L[\"%s\"] = \"%s\" -- %s", entry.key, entry.templateValue, entry
                    .comment))
                else
                    print(string.format("        L[\"%s\"] = \"%s\"", entry.key, entry.templateValue))
                end
                totalCount = totalCount + 1
            end
            print("")
        end
    end

    if totalCount == 0 then
        print("  No template entries needed - all constants already have manual locale entries!")
    else
        print(string.format("  Total template entries: %d", totalCount))
        print("|cffadd8e6Translators: Replace empty strings with translations, keeping English comments for reference|r")
    end
end

--- List available locale codes for template generation
function LocaleManager:ListAvailableLocales()
    if not self.private.developmentMode then
        return
    end

    print("|cff00ffff[NAG] Available locale codes for template generation:|r")
    local locales = {
        "enUS", "enGB", "deDE", "esES", "esMX", "frFR", "itIT", "koKR",
        "ptBR", "ruRU", "zhCN", "zhTW", "jaJP"
    }

    for _, locale in pairs(locales) do
        print(string.format("  %s", locale))
    end

    print("")
    print("Usage: /naglocale template <locale>")
    print("Example: /naglocale template deDE")
end

--- Clear missing keys cache (development only)
function LocaleManager:ClearMissingKeys()
    if self.private.developmentMode then
        wipe(self.private.missingKeys)
    end
end

--- Export missing keys to chat (development only)
function LocaleManager:ExportMissingKeys()
    if not self.private.developmentMode then
        return
    end

    local missingKeys = self:GetMissingKeys()
    local count = 0

    print("|cff00ffff[NAG] Missing locale keys:|r")
    for key, _ in pairs(missingKeys) do
        print(string.format("  L[\"%s\"] = \"%s\"", key, key))
        count = count + 1
    end

    if count == 0 then
        print("  No missing keys found!")
    else
        print(string.format("  Total missing keys: %d", count))
    end
end

--- Scan code for L["key"] patterns and report missing keys
--- @param moduleName string Optional module name to scan
function LocaleManager:ScanForMissingKeys(moduleName)
    if not self.private.developmentMode then
        return
    end

    -- This would require additional implementation to scan files
    -- For now, we'll use the existing missing keys tracking
    self:ExportMissingKeys()
end

--- Test the locale system
function LocaleManager:TestLocaleSystem()
    print("|cff00ffff[NAG] Testing locale system...|r")

    local L = self:GetLocale("test")

    -- Test existing manual key
    local testKey = "aplEditor"
    local value = L[testKey]
    print(string.format("  Manual key '%s': '%s'", testKey, value))

    -- Test auto-generated keys from constants
    print("  |cffadd8e6Auto-generated constant keys:|r")
    local testConstants = { ns.FRAME_GROUPS.PRIMARY, ns.FRAME_GROUPS.AOE, ns.FRAME_GROUPS.MAIN, ns.FRAME_GROUPS
        .COOLDOWNS, ns.FRAME_GROUPS.GENERAL, ns.FRAME_GROUPS.FEATURES }
    for _, key in pairs(testConstants) do
        local autoValue = L[key]
        print(string.format("    '%s': '%s'", key, autoValue))
    end

    -- Test keys that exist in manual locale (should use manual, not auto)
    print("  |cffedd760Manual override test (should use manual values):|r")
    local manualKeys = { ns.SPELL_POSITIONS.LEFT, ns.SPELL_POSITIONS.RIGHT, ns.SPELL_POSITIONS.ABOVE, ns.SPELL_POSITIONS
        .BELOW }
    for _, key in pairs(manualKeys) do
        local manualValue = L[key]
        print(string.format("    '%s': '%s' (manual)", key, manualValue))
    end

    -- Test missing key
    local missingKey = "thisKeyDoesNotExist"
    local missingValue = L[missingKey]
    print(string.format("  Missing key '%s': '%s'", missingKey, missingValue))

    -- Test with fallback
    local fallbackValue = L["anotherMissingKey"] or "Fallback Text"
    print(string.format("  Fallback test: '%s'", fallbackValue))

    print("")
    print("|cffadd8e6Try these commands:|r")
    print("  /naglocale template enUS - Get English template")
    print("  /naglocale template deDE - Get German template")
    print("  /naglocale auto - See current auto-generated entries")

    print("|cff00ffff[NAG] Locale system test complete|r")
end

--- Register development commands
function LocaleManager:RegisterCommands()
    if not self.private.developmentMode then
        return
    end

    -- Register slash commands for locale debugging
    NAG:RegisterChatCommand("naglocale", function(input)
        self:HandleLocaleCommand(input)
    end, "NAG locale debugging commands")
end

--- Handle locale debugging commands
--- @param input string The command input
function LocaleManager:HandleLocaleCommand(input)
    local args = {}
    for arg in string.gmatch(input, "%S+") do
        table.insert(args, arg)
    end

    local command = args[1] or "help"

    if command == "help" then
        print("|cff00ffff[NAG] Locale Commands:|r")
        print("  /naglocale missing - Show missing keys")
        print("  /naglocale usage - Show key usage statistics")
        print("  /naglocale auto - Show auto-generated entries")
        print("  /naglocale template <locale> - Generate translation template")
        print("  /naglocale locales - List available locale codes")
        print("  /naglocale clear - Clear missing keys cache")
        print("  /naglocale test <key> - Test a specific key")
        print("  /naglocale scan - Scan for missing keys")
        print("  /naglocale system - Test the locale system")
    elseif command == "missing" then
        self:ExportMissingKeys()
    elseif command == "usage" then
        local usage = self:GetKeyUsage()
        local count = 0

        print("|cff00ffff[NAG] Key usage statistics:|r")
        for key, uses in pairs(usage) do
            print(string.format("  %s: %d uses", key, uses))
            count = count + 1
        end

        if count == 0 then
            print("  No key usage data available")
        else
            print(string.format("  Total keys used: %d", count))
        end
    elseif command == "auto" then
        self:ExportAutoGeneratedEntries()
    elseif command == "template" then
        local locale = args[2]
        if not locale then
            print("|cffff0000[NAG] Usage: /naglocale template <locale>")
            print("Use '/naglocale locales' to see available locale codes")
            return
        end
        self:ExportTranslationTemplate(locale)
    elseif command == "locales" then
        self:ListAvailableLocales()
    elseif command == "clear" then
        self:ClearMissingKeys()
        print("|cff00ffff[NAG] Missing keys cache cleared")
    elseif command == "test" then
        local key = args[2]
        if not key then
            print("|cffff0000[NAG] Usage: /naglocale test <key>")
            return
        end

        local value = self:GetString(key, nil, "command")
        print(string.format("|cff00ffff[NAG] Key '%s':|r '%s'", key, value))
    elseif command == "scan" then
        print("|cff00ffff[NAG] Scanning for missing keys...|r")
        self:ScanForMissingKeys()
    elseif command == "system" then
        self:TestLocaleSystem()
    else
        print(string.format("|cffff0000[NAG] Unknown command: %s|r", command))
        print("Use /naglocale help for available commands")
    end
end

-- ============================ EXPORT ============================

-- Expose the module on the namespace for easy access
ns.LocaleManager = LocaleManager
