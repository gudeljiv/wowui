--- @module 'APICompat'
--- Handles API compatibility for the NAG addon.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Discord: https://discord.gg/ebonhold

--
-- ============================================================================
-- API VALIDATION COVERAGE SUMMARY
-- Last Updated: 2025-01-XX
-- ============================================================================
-- Total API Functions in Use: 14
-- Unified Wrappers: 14 (functions with cross-version compatibility wrappers)
-- All functions are handled via unified wrappers or direct local declarations
-- ============================================================================

-- GetSpellCooldown, GetSpellInfo, GetItemInfo(cache), GetSpellCharges,
-- UnitAura,
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
---@type Version
local Version = ns.Version

local AssertUtils = ns.AssertUtils

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format


local strmatch = strmatch


local setmetatable = setmetatable
local next = next
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitLevel = _G.UnitLevel
local CreateFrame = _G.CreateFrame

local pcall = ns.pcall

-- ~~~~~~~~~~ HELPER FUNCTIONS ~~~~~~~~~~
-- No-op functions for missing APIs
local function nop() end
local function nopz() return 0 end
local function nopt() return {} end
local function nopfalse() return false end

-- ~~~~~~~~~~ TYPE DEFINITIONS ~~~~~~~~~~

--- @class SpellBookItemNameInfo
--- @field name string The spell name
--- @field spellType string The spell type (e.g., "SPELL", "Passive", "Racial", "Guild Perk")
--- @field spellID number The spell ID

-- ~~~~~~~~~~ SIMPLE API WRAPPERS (ONE-LINER PATTERN) ~~~~~~~~--
-- Only keeping wrappers that are actually used in the codebase

-- AddOn APIs
--- @param name number
--- @return boolean loadedOrLoading
--- @return boolean loaded
-- API_VALIDATION: Compatible
-- Modern: C_AddOns.IsAddOnLoaded(name: number) → (loadedOrLoading: boolean, loaded: boolean)
-- Classic: IsAddOnLoaded(name: number) → (loaded: boolean, finished: boolean)
ns.IsAddOnLoadedUnified                  = C_AddOns and C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

-- Threat APIs
--- Unified function to get detailed threat situation (returns positional values in Classic).
--- @param unit string The unit to check threat for (e.g., "player")
--- @param target string The unit to check threat against (e.g., "target")
--- @return boolean|nil isTanking
--- @return number|nil status
--- @return number|nil threatPct
--- @return number|nil rawThreatPct
--- @return number|nil threatValue
-- API_VALIDATION: TBC Classic via in-game /dump
-- Classic: UnitDetailedThreatSituation(unit, target) → (isTanking, status, threatPct, rawThreatPct, threatValue)
function ns.UnitDetailedThreatSituationUnified(unit, target)
    if _G.UnitDetailedThreatSituation then
        return _G.UnitDetailedThreatSituation(unit, target)
    end
    return nil
end

-- CreatureInfo APIs (Retail-only, return tables on Retail, nil on Classic)
--- @deprecated INTERNAL USE ONLY
-- API_VALIDATION: NOP Fallback (Classic compatibility)
-- Modern: C_CreatureInfo.GetClassInfo() → void
-- Classic: nop (intentional fallback for Classic)
ns.GetClassInfoUnified                   = C_CreatureInfo and C_CreatureInfo.GetClassInfo or nop

-- ~~~~~~~~~~ COMPLEX API WRAPPERS (REQUIRE RETURN VALUE TRANSFORMATION) ~~~~~~~~~~
-- These APIs return different formats between Retail (tables) and Classic (multi-return)
-- They need custom wrapper functions to normalize the return values

-- ~~~~~~~~~~ TABLE RETURN STRUCTURES ~~~~~~~~~~

--- @class SpellCooldownInfo
--- @field startTime number If cooldown is active, time started; 0 if no cooldown; Current time if isEnabled is false
--- @field duration number Cooldown duration in seconds if active; 0 if cooldown is inactive
--- @field isEnabled boolean False if cooldown is on hold; True otherwise
--- @field modRate number Rate at which cooldown UI should update
--- @field activeCategory number|nil Indicates which category is responsible for determining the duration (VALIDATED: WoW-UI-Source)

--- @class SpellInfo
--- @field name string The name of the spell (VALIDATED: WoW-UI-Source)
--- @field iconID number Icon for this spell; If overridden, may be icon for overriding spell (VALIDATED: WoW-UI-Source)
--- @field originalIconID number Spell's non-overridden icon (VALIDATED: WoW-UI-Source)
--- @field castTime number Cast time in milliseconds (VALIDATED: WoW-UI-Source)
--- @field minRange number Minimum range in yards (VALIDATED: WoW-UI-Source)
--- @field maxRange number Maximum range in yards (VALIDATED: WoW-UI-Source)
--- @field spellID number The spell ID (VALIDATED: WoW-UI-Source)
--- @field rank string|nil The rank of the spell (Classic only, nil in modern versions)

--- @class SpellChargeInfo
--- @field currentCharges number Number of charges currently available (VALIDATED: WoW-UI-Source)
--- @field maxCharges number Max number of charges that can be accumulated (VALIDATED: WoW-UI-Source)
--- @field cooldownStartTime number If charge cooldown is active, time at which the most recent charge cooldown began; 0 if not active (VALIDATED: WoW-UI-Source)
--- @field cooldownDuration number Cooldown duration in seconds required to generate a charge (VALIDATED: WoW-UI-Source)
--- @field chargeModRate number Rate at which cooldown UI should update (VALIDATED: WoW-UI-Source)

--- @class ItemInfo
--- @field itemName string The name of the item
--- @field itemLink string The item link
--- @field itemQuality number The item quality (rarity)
--- @field itemLevel number The item level
--- @field itemMinLevel number The minimum level required
--- @field itemType string The item type
--- @field itemSubType string The item subtype
--- @field itemStackCount number The stack count
--- @field itemEquipLoc string The equipment location
--- @field itemTexture number The item texture file ID
--- @field sellPrice number The sell price
--- @field classID number The class ID
--- @field subclassID number The subclass ID
--- @field bindType number The bind type
--- @field expacID number The expansion ID
--- @field setID number The item set ID
--- @field isCraftingReagent boolean Whether it's a crafting reagent

--- @class SpellTabInfo
--- @field name string The name of the spell tab
--- @field iconID number The icon file ID (Classic: texture)
--- @field itemIndexOffset number The item index offset (VERIFIED: Retail C_SpellBook API)
--- @field numSpellBookItems number The number of spellbook items (VERIFIED: Retail C_SpellBook API)
--- @field isGuild boolean Whether it's a guild tab
--- @field offSpecID number The off-spec ID
--- @field shouldHide boolean Whether the tab should be hidden
--- @field specID number The specialization ID
--- TODO: Partial validation - iconID mapping from Classic needs verification (see docs/migrations/APICompat-WoW-API-Validation.md)

--- @class SpellBookItemInfo
--- @field itemType number The item type (Enum.SpellBookType)
--- @field actionID number The action ID (spell ID or id)
--- @field spellID number The spell ID
--- @field name string The name
--- @field iconID number The icon file ID
--- @field isPassive boolean Whether the spell is passive

--- @class StablePetInfo
--- @field icon number The pet icon file ID
--- @field name string The pet name
--- @field level number The pet level
--- @field familyName string The pet family name
--- @field specialization string The pet specialization

--- @class SpecializationInfo
--- @field specID number The specialization ID
--- @field specName string The specialization name
--- @field description string The specialization description
--- @field iconTexture number The specialization icon texture
--- @field role string The specialization role
--- @field primaryStat number The primary stat




--- Unified function to get addon metadata.
--- @param name string|number The name or index of the addon to check (case insensitive).
--- @param variable string The metadata field to retrieve (Title, Notes, Author, Version, or X-*) (case insensitive).
--- @return string|nil value The metadata value, or nil if not defined or addon doesn't exist.
function ns.GetAddOnMetadataUnified(name, variable)
    if not name or not variable then return nil end

    -- First check if addon exists using IsAddOnLoaded to prevent errors
    -- We don't care about the loaded state, just if it exists
    local exists = pcall(function()
        if C_AddOns and C_AddOns.IsAddOnLoaded then
            C_AddOns.IsAddOnLoaded(name)
        else
            _G.IsAddOnLoaded(name)
        end
    end)

    if not exists then return nil end

    local success, result = pcall(function()
        if C_AddOns and C_AddOns.GetAddOnMetadata then
            -- Retail version
            return C_AddOns.GetAddOnMetadata(name, variable)
        else
            -- Classic version
            return GetAddOnMetadata(name, variable)
        end
    end)

    if not success then return nil end

    -- Ensure we're returning a string or nil
    -- Some metadata fields might return non-string values which should be converted to nil
    return type(result) == "string" and result or nil
end

-- GetItemInfo: Both C_Item and _G versions return positional values (17 values), not tables
-- No conversion needed - use simple namespace wrapper
--- @param item number
--- @return string 1. itemName
--- @return string 2. itemLink
--- @return number 3. itemQuality
--- @return number 4. itemLevel
--- @return number 5. itemMinLevel
--- @return string 6. itemType
--- @return string 7. itemSubType
--- @return number 8. itemStackCount
--- @return string 9. itemEquipLoc
--- @return number 10. itemTexture
--- @return number 11. sellPrice
--- @return number 12. classID
--- @return number 13. subclassID
--- @return number 14. bindType
--- @return number 15. expansionID
--- @return number 16. setID
--- @return boolean 17. isCraftingReagent
-- API_VALIDATION: Compatible
-- Modern: C_Item.GetItemInfo(item: number) → (1. itemName: string, 2. itemLink: string, 3. itemQuality: number, 4. itemLevel: number, 5. itemMinLevel: number, 6. itemType: string, 7. itemSubType: string, 8. itemStackCount: number, 9. itemEquipLoc: string, 10. itemTexture: number, 11. sellPrice: number, 12. classID: number, 13. subclassID: number, 14. bindType: number, 15. expansionID: number, 16. setID: number, 17. isCraftingReagent: boolean)
-- Classic: GetItemInfo(item: number) → (1. itemName: string, 2. itemLink: string, 3. itemQuality: number, 4. itemLevel: number, 5. itemMinLevel: number, 6. itemType: string, 7. itemSubType: string, 8. itemStackCount: number, 9. itemEquipLoc: string, 10. itemTexture: number, 11. sellPrice: number, 12. classID: number, 13. subclassID: number, 14. bindType: number, 15. expansionID: number, 16. setID: unknown, 17. isCraftingReagent: boolean)
ns.GetItemInfoUnified = C_Item and C_Item.GetItemInfo or _G.GetItemInfo

--- Unified function to get stable pet information.
-- Retrieves stable pet information for hunters across both Retail and Classic.
-- TODO: VALIDATION REQUIRED - Cannot verify C_StableInfo.GetStablePetInfo return structure from available sources
-- TODO: Verify if modern API returns table or positional values
-- TODO: If both return positional, change to one-liner wrapper
--- @param index number The index of the stable pet.
--- @return StablePetInfo|nil petInfo The stable pet information table, or nil if pet not found
function ns.GetStablePetInfoUnified(index)
    if not index then return nil end
    if C_StableInfo and C_StableInfo.GetStablePetInfo then
        -- Retail version - ASSUMPTION: returns table directly (needs verification)
        local petInfo = C_StableInfo.GetStablePetInfo(index)
        if petInfo then
            return petInfo
        else
            return nil
        end
    else
        -- Classic version - convert positional returns to table
        local icon, name, level, family, specialization = _G.GetStablePetInfo(index)
        if not name then
            return nil
        end
        return {
            icon = icon,
            name = name,
            level = level,
            familyName = family,
            specialization = specialization
        }
    end
end

--- Unified function to get spell cooldown information.
-- Retrieves spell cooldown information across both Retail and Classic.
--- @param spellID number The ID of the spell to check the cooldown for.
--- @return SpellCooldownInfo|nil spellCooldownInfo The cooldown information table, or nil if spell not found
--- NOTE: Retail table includes activeCategory field. Classic conversion omits it (defaults to nil per structure definition).
function ns.GetSpellCooldownUnified(spellID)
    if type(spellID) == "table" then
        for k, v in pairs(spellID) do print("  key:", k, "val:", v) end
        error("GetSpellCooldownUnified received a table!")
    end
    if not spellID then return nil end

    -- Check for Retail API first
    if C_Spell and C_Spell.GetSpellCooldown then
        -- Retail: Use C_Spell.GetSpellCooldown (returns table)
        local cdInfo = C_Spell.GetSpellCooldown(spellID)
        if cdInfo then
            return cdInfo
        else
            -- Fallback to classic API if retail API returns nil
            local startTime, duration, isEnabled, modRate = _G.GetSpellCooldown(spellID)
            return {
                startTime = startTime,
                duration = duration,
                isEnabled = isEnabled,
                modRate = modRate or 1
            }
        end
    else
        -- Classic: Use GetSpellCooldown (returns individual values) and convert to table
        local startTime, duration, isEnabled, modRate = _G.GetSpellCooldown(spellID)
        return {
            startTime = startTime,
            duration = duration,
            isEnabled = isEnabled,
            modRate = modRate or 1
        }
    end
end

--- Unified function to get spell charge information.
--- Returns information about the charges of a charge-accumulating player ability.
--- @param spell number|string The spell ID/name OR spellbook index (when bookType is provided)
--- @param bookType? string Optional - "spell" or "pet" for spellbook index queries (legacy API only)
--- @return SpellChargeInfo|nil chargeInfo The charge information table, or nil if spell not found or has no charges
function ns.GetSpellChargesUnified(spell, bookType)
    if not spell then return nil end

    -- If bookType is provided, we're querying by spellbook index, not spell ID
    -- C_Spell.GetSpellCharges does NOT support bookType parameter, so skip it
    if not bookType then
        -- Try the new C_Spell API first if available (returns table)
        -- Only use this when querying by spell ID/name (no bookType)
        if C_Spell and C_Spell.GetSpellCharges then
            -- For retail/modern versions
            local chargeInfo = C_Spell.GetSpellCharges(spell)
            if chargeInfo then
                return chargeInfo
            end
        end
    end

    -- Fallback to classic/deprecated version (returns individual values) and convert to table
    -- This version supports both spell ID/name AND spellbook index with bookType
    if _G.GetSpellCharges then
        local currentCharges, maxCharges, cooldownStartTime, cooldownDuration, chargeModRate
        if bookType then
            -- If bookType is provided, use spellbook version (index, bookType)
            currentCharges, maxCharges, cooldownStartTime, cooldownDuration, chargeModRate = _G.GetSpellCharges(spell, bookType)
        else
            -- Otherwise use direct spell version (spell ID/name)
            currentCharges, maxCharges, cooldownStartTime, cooldownDuration, chargeModRate = _G.GetSpellCharges(spell)
        end

        if currentCharges then
            return {
                currentCharges = currentCharges,
                maxCharges = maxCharges,
                cooldownStartTime = cooldownStartTime,
                cooldownDuration = cooldownDuration,
                chargeModRate = chargeModRate
            }
        end
    end

    -- If neither API is available, return nil
    return nil
end

--- Unified function to get spell information.
--- Retrieves spell information, working across both Retail and Classic.
--- @param spellID number The ID of the spell to retrieve information for.
--- @return SpellInfo|nil spellInfo The spell information table, or nil if spell not found
function ns.GetSpellInfoUnified(spellID)
    if not spellID then return nil end

    -- Check for Retail API functions (returns table)
    if C_Spell and C_Spell.GetSpellInfo then
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        if spellInfo then
            return spellInfo
        else
            return nil
        end
    end

    -- Fallback to Classic API (returns individual values) and convert to table
    local name, rank, iconID, castTime, minRange, maxRange, ID, originalIconID = _G.GetSpellInfo(spellID)
    if not name then
        return nil
    end
    return {
        name = name,
        rank = rank,
        iconID = iconID,
        castTime = castTime,
        minRange = minRange,
        maxRange = maxRange,
        spellID = ID,
        originalIconID = originalIconID or iconID
    }
end

--- Unified function to get spell tab information.
-- Retrieves spell tab information across both Retail and Classic.
--- @param tabIndex number The index of the spell tab.
--- @return SpellTabInfo|nil tabInfo The spell tab information table, or nil if tab not found
function ns.GetSpellTabInfoUnified(tabIndex)
    if not tabIndex then return nil end
    if C_SpellBook and C_SpellBook.GetSpellBookSkillLineInfo then
        -- Retail version
        local tabInfo = C_SpellBook.GetSpellBookSkillLineInfo(tabIndex)
        if tabInfo then
            return tabInfo
        else
            return nil
        end
    else
        -- Classic version - convert positional returns to table
        local name, texture, offset, numSlots, isGuild, offSpecID, shouldHide, specID = _G.GetSpellTabInfo(tabIndex)
        if not name then
            return nil
        end
        return {
            name = name,
            iconID = texture,
            itemIndexOffset = offset,
            numSpellBookItems = numSlots,
            isGuild = isGuild,
            offSpecID = offSpecID,
            shouldHide = shouldHide,
            specID = specID
        }
    end
end

--- Unified function to get spellbook item name.
-- Retrieves the name, type, and ID of a spellbook item by index, working across both Retail and Classic.
--- @param index number The spellbook index.
--- @param bookType string The book type (e.g., "spell" or BOOKTYPE_SPELL).
--- @return SpellBookItemNameInfo|nil itemNameInfo The spellbook item name information table, or nil if item not found
function ns.GetSpellBookItemNameUnified(index, bookType)
    if not index or not bookType then return nil end

    -- Try Retail API first (though GetSpellBookItemName was removed in 11.0.0)
    if C_SpellBook and C_SpellBook.GetSpellBookItemName then
        local itemInfo = C_SpellBook.GetSpellBookItemName(index, bookType)
        if itemInfo then
            -- If Retail returns a table, return it as-is
            if type(itemInfo) == "table" then
                return itemInfo
            end
            -- If Retail returns positional values, convert to table
            return {
                name = itemInfo,
                spellType = select(2, C_SpellBook.GetSpellBookItemName(index, bookType)),
                spellID = select(3, C_SpellBook.GetSpellBookItemName(index, bookType))
            }
        end
        return nil
    else
        -- Classic version - convert positional returns to table
        local name, spellType, spellID = _G.GetSpellBookItemName(index, bookType)
        if not name then
            return nil
        end
        return {
            name = name,
            spellType = spellType,
            spellID = spellID
        }
    end
end

--- Unified function to get spellbook item info.
-- Retrieves information about a spellbook item by index, working across both Retail and Classic.
--- @param index number The spellbook index.
--- @param bookType string The book type (e.g., "spell").
--- @return SpellBookItemInfo|nil itemInfo The spellbook item information table, or nil if item not found
function ns.GetSpellBookItemInfoUnified(index, bookType)
    if not index or not bookType then return nil end
    if C_SpellBook and C_SpellBook.GetSpellBookItemInfo then
        -- Retail version - returns table directly
        return C_SpellBook.GetSpellBookItemInfo(index, bookType)
    else
        -- Classic version - convert positional returns to table
        local itemType, id = _G.GetSpellBookItemInfo(index, bookType)
        if not itemType then
            return nil
        end
        local iconID = _G.GetSpellBookItemTexture(index, bookType)
        local name = _G.GetSpellBookItemName(index, bookType)
        local isPassive = _G.IsPassiveSpell(index, bookType)
        local spellID = select(7, _G.GetSpellInfo(index, bookType))
        return {
            itemType = itemType,
            actionID = spellID or id,
            spellID = spellID,
            name = name,
            iconID = iconID,
            isPassive = isPassive
        }
    end
end

--- Unified GetSpecializationInfo function.
-- Retrieves information about the player's specialization across both Retail and Classic.
-- NOTE: Both C_SpecializationInfo and _G.GetSpecializationInfo return POSITIONAL values
-- Modern returns 10 values, Legacy returns 6 values - but BOTH are positional!
-- No conversion needed - use simple namespace wrapper
--- @param specIndex number The index of the specialization to retrieve.
--- @return number specID The specialization ID
--- @return string specName The specialization name
--- @return string description The specialization description
--- @return number iconTexture The specialization icon texture
--- @return string role The specialization role
--- @return number primaryStat The primary stat
--- @deprecated INTERNAL USE ONLY - Use SpecCompat:GetSpecInfo() instead
ns.GetSpecializationInfoUnified = C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo or _G.GetSpecializationInfo

--- Unified function to get the number of spell tabs.
--- @return number numSpellBookSkillLines The number of spell tabs.
function ns.GetNumSpellTabsUnified()
    if C_SpellBook and C_SpellBook.GetNumSpellBookSkillLines then
        return C_SpellBook.GetNumSpellBookSkillLines()
    else
        return _G.GetNumSpellTabs()
    end
end

--- Unified function to check if a spell is known.
--- @param spellId number The spell ID to check.
--- @param isPet boolean|nil Whether to check pet spells.
--- @param includeOverrides boolean|nil Whether to include spell overrides.
--- @return boolean isKnown Whether the spell is known.
function ns.IsSpellKnownUnified(spellId, isPet, includeOverrides)
    if not spellId then return false end

    -- Default isPet to false (player spells) and includeOverrides to true to match WoW API behavior
    if isPet == nil then
        isPet = false
    end
    if includeOverrides == nil then
        includeOverrides = true     --RAKIZI CHECK THIS SHIT
    end

    -- Modern API (11.2+)
    if C_SpellBook and C_SpellBook.IsSpellInSpellBook then
        local spellBank = isPet and Enum.SpellBookSpellBank.Pet or Enum.SpellBookSpellBank.Player
        return C_SpellBook.IsSpellInSpellBook(spellId, spellBank, includeOverrides)
    end  -- RAKIZI CHECK THIS SHIT

    -- Fallback to legacy API
    if includeOverrides and _G.IsSpellKnownOrOverridesKnown then
        return _G.IsSpellKnownOrOverridesKnown(spellId, isPet) or false
    else
        return _G.IsSpellKnown(spellId, isPet)
    end
end



--- Centralized WoW API Registry System
--- Provides unified access to all WoW API functions with automatic version detection
--- Priority: Cached > Unified > Native API
--- Falls back to native _G API if no cached or unified version exists
--- Usage: local WoWAPI = ns.WoWAPI; WoWAPI.GetSpellInfo(spellID)
-- Build the WoWAPI registry at load time so lookups do not re-check sources
-- on every access. Cached APIs override unified wrappers when both exist.
local function BuildWoWAPIRegistry()
    local registry = {}

    -- Prefer cached functions when present
    for name, func in pairs(ns) do
        local baseName = strmatch(name, "^Cached(.+)$")
        if baseName and func ~= nil then
            registry[baseName] = func
        end
    end

    -- Populate unified wrappers, but keep cached overrides intact
    for name, func in pairs(ns) do
        local baseName = strmatch(name, "^(.*)Unified$")
        if baseName and type(func) == "function" and registry[baseName] == nil then
            registry[baseName] = func
        end
    end

    return registry
end

--- Register a cached API function and inject it into the WoWAPI registry.
--- @param apiName string Base API name (e.g., "GetSpellInfo")
--- @param func function Cached function matching the API signature
function ns.RegisterCachedAPI(apiName, func)
    if type(apiName) ~= "string" or type(func) ~= "function" then
        return
    end

    -- If WoWAPI is not built yet, store on namespace for BuildWoWAPIRegistry to pick up
    if not ns.WoWAPI then
        ns["Cached" .. apiName] = func
        return
    end

    -- Inject directly, bypassing __newindex protections
    rawset(ns.WoWAPI, apiName, func)
end

ns.WoWAPI = setmetatable(BuildWoWAPIRegistry(), {
    __index = function(t, key)
        -- Fallback: cache native _G APIs on first access
        local nativeValue = _G[key]
        if nativeValue ~= nil and type(nativeValue) == "function" then
            rawset(t, key, nativeValue)
            return nativeValue
        end

        error(format(
            "WoW API '%s' not found in ns.WoWAPI registry or native _G. " ..
            "Check the API name for typos. " ..
            "For version-specific APIs, add a unified wrapper in APICompat.lua.",
            tostring(key)
        ), 2)
    end,
    __newindex = function()
        error("Cannot modify ns.WoWAPI registry. APIs are read-only.", 2)
    end
})

--[[ MODERN USAGE (Recommended):
-- At start of each file, use the centralized registry:
local WoWAPI = ns.WoWAPI

-- Then call APIs directly:
local spellInfo = WoWAPI.GetSpellInfo(spellID)         -- Uses unified version (cross-version compat)
local name, icon = spellInfo.name, spellInfo.iconID
local cdInfo = WoWAPI.GetSpellCooldown(spellID)  -- Uses unified version
local startTime, duration = cdInfo.startTime, cdInfo.duration
local health = UnitHealth("player")             -- Falls back to native _G.UnitHealth

-- How it works:
-- 1. If a unified wrapper exists (e.g., GetSpellInfoUnified), it uses that
-- 2. If no unified wrapper exists, it falls back to native _G API
-- 3. This means you can use WoWAPI for ALL APIs, not just unified ones!

-- ACTIVE API FUNCTIONS (14 total - all actually used in codebase):
-- Unified Wrappers (14):
--   Spell APIs: GetSpellInfo, GetSpellCooldown, GetSpellCharges
--   Item APIs: GetItemInfo
--   Spellbook APIs: GetNumSpellTabs, GetSpellTabInfo, GetSpellBookItemInfo, GetSpellBookItemName
--   Utility APIs: GetAddOnMetadata, IsSpellKnown, IsAddOnLoaded
--   Pet APIs: GetStablePetInfo
--   Specialization APIs: GetSpecializationInfo (deprecated - use SpecCompat)
--   CreatureInfo APIs: GetClassInfo

-- Native APIs (auto-fallback to _G):
-- Unit APIs: UnitHealth, UnitPower, UnitExists, UnitClass, UnitLevel, etc.
-- Combat APIs: InCombatLockdown, UnitAffectingCombat, etc.
-- Frame APIs: CreateFrame, GetFramerate, etc.
-- And any other native WoW API!

-- LEGACY USAGE (Deprecated but still supported):
-- Old pattern still works for backward compatibility:
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
-- ... etc
]]
