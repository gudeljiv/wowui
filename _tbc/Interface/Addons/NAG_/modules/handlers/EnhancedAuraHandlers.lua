--- @module "NAG.EnhancedAuraHandlers"
--- Enhanced aura detection system with performance tiers and WoW API standard filters
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

--- @class AuraData
--- @field name string|boolean Aura name, or false if not found
--- @field icon string|nil Icon texture path
--- @field count number|nil Applications/stacks (Modern: applications, Classic: count)
--- @field dispelType string|nil Dispel type (Modern: dispelName, Classic: dispelType)
--- @field duration number|nil Duration in seconds
--- @field expirationTime number|nil Expiration timestamp
--- @field sourceUnit string|nil Unit that cast the aura (Modern: sourceUnit, Classic: unitCaster)
--- @field isStealable boolean|nil Whether aura is stealable
--- @field nameplateShowPersonal boolean|nil Show on personal nameplate
--- @field spellId number|nil Spell ID of the aura
--- @field canApplyAura boolean|nil Whether player can apply
--- @field isBossAura boolean|nil Boss aura flag (Modern: isBossAura, Classic: isBossDebuff)
--- @field isFromPlayerOrPlayerPet boolean|nil Cast by player/pet (Modern: isFromPlayerOrPlayerPet, Classic: castByPlayer)
--- @field nameplateShowAll boolean|nil Show on all nameplates
--- @field timeMod number|nil Time modifier
--- @field shouldConsolidate boolean|nil Should consolidate (Classic only)
--- @field points table|nil Array of custom values [1-12] for effects like Stagger

-- ============================ LOCALIZE ============================

local _, ns = ...
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local IsInRaid = _G.IsInRaid
local UnitIsUnit = _G.UnitIsUnit
local GetTotemInfo = _G.GetTotemInfo
local L = ns.AceLocale:GetLocale("NAG")

-- ============================ ADDON ACCESS ============================

--- @type NAG|AceAddon Main addon reference
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type Types
local Types
--- @type DataManager
local DataManager
--- @type SpellTrackingManager
local SpellTrackingManager
--- @type StateManager
local StateManager

--- @type CacheRefreshManager
local CacheRefreshManager

-- ============================ LUA API LOCALIZATION ============================
local WoWAPI = ns.WoWAPI

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local strfind = strfind

-- ============================ WOW API LOCALIZATION ============================

-- Use raw WoW APIs directly for maximum control (no APICompat layer)
-- Use modern API when available, fallback to classic API
local UnitAura = C_UnitAuras and C_UnitAuras.GetAuraDataByIndex or _G.UnitAura
local GetPlayerAuraBySpellID = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID
local GetAuraDataBySpellName = C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName
local hasModernAPIs = C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName and true


-- ============================ CONSTANTS ============================

local CONSTANTS = {
    AURA_CACHE_TIME = 0.1, -- 100ms cache
    MAX_ITERATIONS = 60,   -- Maximum aura iterations
}

-- Smart detection configuration
local SMART_DETECTION_CONFIG = {
    overrideList = {
        -- Override list for edge cases where spell appears in both HELPFUL/HARMFUL
        -- Format: [spellId] = "HELPFUL" or "HARMFUL" or "HARMFUL|PLAYER"
        -- Example: [12345] = "HARMFUL", -- Force this spell to be treated as debuff

        -- Global debuff overrides (use HARMFUL filter to check any harmful debuff, not just player-cast)
        -- These are typically non-stacking debuffs where you want to know if someone else already applied it
        [772] = "HARMFUL",   -- Rend (Warrior) - check any harmful debuff (Override HARMFUL|PLAYER)
        [115768] = "HARMFUL", -- Rend (Warrior MoP) - check any harmful debuff (Override HARMFUL|PLAYER)
        [770] = "HARMFUL",   -- Faerie Fire (Druid) - check any harmful debuff (Override HARMFUL|PLAYER)

        [99] = "HARMFUL",    -- Demoralizing Roar (Druid) - check any harmful debuff (Override HARMFUL|PLAYER)
        [702] = "HARMFUL",   -- Curse of Tongues (Warlock) - check any harmful debuff (Override HARMFUL|PLAYER)
        [1160] = "HARMFUL",  -- Demoralizing Shout (Warrior) - check any harmful debuff (Override HARMFUL|PLAYER)
        [16511] = "HARMFUL", -- Curse of Agony (Warlock) - check any harmful debuff (Override HARMFUL|PLAYER)
        [26016] = "HARMFUL", -- Vindication (Paladin) - check any harmful debuff (Override HARMFUL|PLAYER)
        [29859] = "HARMFUL", -- Blood Frenzy (Warrior) - check any harmful debuff (Override HARMFUL|PLAYER)
        [35387] = "HARMFUL", -- Corrosive Spit (Hunter pet) - check any harmful debuff (Override HARMFUL|PLAYER)
        [57386] = "HARMFUL", -- Curse of Doom (Warlock) - check any harmful debuff (Override HARMFUL|PLAYER)
        [81132] = "HARMFUL", -- Demoralizing Roar (Druid) - check any harmful debuff (Override HARMFUL|PLAYER)
        [113746] = "HARMFUL", -- Weakened Armor/Sunder Armor - check any harmful debuff (Override HARMFUL|PLAYER)
        [7386] = "HARMFUL",   -- Sunder Armor (Warrior) - check any harmful debuff (Override HARMFUL|PLAYER)
        [33876] = "HARMFUL", -- Sunder Armor (Druid) - check any harmful debuff (Override HARMFUL|PLAYER)
        [33878] = "HARMFUL", -- Sunder Armor (Druid) - check any harmful debuff (Override HARMFUL|PLAYER)
        [8647] = "HARMFUL", -- Expose Armor (Rogue) - check any harmful debuff (Override HARMFUL|PLAYER)

        -- Debuff overrides (spells that should be treated as HARMFUL debuffs on player)
        [36032] = "HARMFUL", -- Arcane Charges (Mage) - check harmful debuff (AuraNumStacks defaults to HELPFUL for player)

        -- Warlock debuff overrides (use HARMFUL filter to check any harmful debuff)
        [36831] = "HARMFUL", -- Warlock debuff - check any harmful debuff (Override HARMFUL|PLAYER)
        [58410] = "HARMFUL", -- Warlock debuff - check any harmful debuff (Override HARMFUL|PLAYER)
        [24844] = "HARMFUL", -- Warlock debuff - check any harmful debuff (Override HARMFUL|PLAYER)
        [34889] = "HARMFUL", -- Warlock debuff - check any harmful debuff (Override HARMFUL|PLAYER)
        [1490] = "HARMFUL",  -- Warlock debuff - check any harmful debuff (Override HARMFUL|PLAYER)

        -- Physical damage reduction debuffs (PhysDamageReduction category)
        [115798] = "HARMFUL", -- Weakened Blows - check any harmful debuff (Override HARMFUL|PLAYER)

        -- Physical damage taken debuffs (PhysicalDmg category)
        [81326] = "HARMFUL", -- Physical Vulnerability - check any harmful debuff (Override HARMFUL|PLAYER)

        -- Healing reduction debuffs (HealingReduction category)
        [115804] = "HARMFUL", -- Mortal Wounds - check any harmful debuff (Override HARMFUL|PLAYER)

        -- Cast speed reduction debuffs (CastSpdReduction category)
        [73975] = "HARMFUL", -- Necrotic Strike - check any harmful debuff (Override HARMFUL|PLAYER)
        [58604] = "HARMFUL", -- Lava Breath - check any harmful debuff (Override HARMFUL|PLAYER)
        [50274] = "HARMFUL", -- Spore Cloud - check any harmful debuff (Override HARMFUL|PLAYER)
        [5761] = "HARMFUL",  -- Mind-numbing Poison - check any harmful debuff (Override HARMFUL|PLAYER)
        [109466] = "HARMFUL", -- Curse of Enfeeblement - check any harmful debuff (Override HARMFUL|PLAYER)
        [31589] = "HARMFUL", -- Slow - check any harmful debuff (Override HARMFUL|PLAYER)
    }
}

-- Custom damage handlers registry for O(1) lookup
local CUSTOM_DAMAGE_HANDLERS = {
    [12846] = "ignite", -- Ignite uses custom damage calculation
    -- Add other spells that need custom damage calculation here
}

-- Comprehensive spell ID mapping system with multi-mapping support
local SPELL_MAPPINGS = {
    -- Direct ID mappings (WoWSims ID -> Internal ID)
    direct = {
        -- Existing mappings
        [138228] = 137639, -- Storm, Earth and Fire -> Storm, Earth, and Fire
        [128938] = 128939, -- Another mapping example

        -- Mappings from APL_Spells.lua (17 mappings)
        [12846] = 413841, -- ignite (spell ID to aura ID mapping)
        [3599] = 77661,   -- searing totem applies searing flames

        -- Mappings from ResourceHandlers.lua (1 mapping)
        [100787] = 125359, -- chi brew

        -- Mappings from handlers directory analysis
        -- Savage Roar (52610 -> 127538) only applies in MoP; set to nil in other versions
        [52610] = (ns.Version and ns.Version:IsMoP() and 127538) or nil,

    },

    -- Item to spell ID mappings
    items = {
        -- [itemId] = spellId
    },


    -- Multi-aura mappings (one spell ID maps to multiple auras)
    multi = {
        -- Haste spells - check for ANY of these haste buffs
        [80353] = {
            type = "any",                  -- "any", "all", "none"
            auras = { 80353, 2825, 32182 } -- Bloodlust, Heroism, Time Warp
        },
        [2825] = {
            type = "any",
            auras = { 80353, 2825, 32182 } -- Bloodlust, Heroism, Time Warp
        },
        [32182] = {
            type = "any",
            auras = { 80353, 2825, 32182 } -- Bloodlust, Heroism, Time Warp
        },

        -- Demon Soul spells - check for ANY of these Demon Soul variants
        [77801] = {
            type = "any",
            auras = { 79460, 79463, 79462, 79459, 79464 } -- All Demon Soul: variants
        },
        [79460] = {
            type = "any",
            auras = { 79460, 79463, 79462, 79459, 79464 } -- All Demon Soul: variants
        },
        [79463] = {
            type = "any",
            auras = { 79460, 79463, 79462, 79459, 79464 } -- All Demon Soul: variants
        },
        [79462] = {
            type = "any",
            auras = { 79460, 79463, 79462, 79459, 79464 } -- All Demon Soul: variants
        },
        [79459] = {
            type = "any",
            auras = { 79460, 79463, 79462, 79459, 79464 } -- All Demon Soul: variants
        },
        [79464] = {
            type = "any",
            auras = { 79460, 79463, 79462, 79459, 79464 } -- All Demon Soul: variants
        },
    },

    -- Conditional mappings (complex logic with OR/AND/NOT)
    conditional = {
        -- Example: Spell ID 99999 needs aura A OR aura B, but not both
        -- [99999] = {
        --     type = "conditional",
        --     logic = "or", -- "or", "and", "not"
        --     conditions = {
        --         { aura = 12346, required = true },
        --         { aura = 12347, required = true }
        --     }
        -- },
    },

    -- Custom handler mappings (for special cases)
    custom = {
        -- Migrated from special case handlers
        [88747] = {
            handler = "totem",
            params = {}
        },
        [120267] = {
            handler = "vengeance",
            params = {}
        },
        -- Mappings from AuraHandlers.lua special cases
        [138228] = {
            handler = "storm_earth_fire",
            params = {}
        },
        [128938] = {
            handler = "storm_earth_fire",
            params = {}
        },
        -- Mappings from ResourceHandlers.lua special cases
        [100787] = {
            handler = "chi_brew",
            params = {}
        },
        -- Dark Transformation in MoP should check pet unit
        [63560] = {
            handler = "dark_transformation",
            params = {}
        },
        -- Monk aura name conflicts - force exact ID matching, skip name matching
        [1247279] = { -- Tigereye Brew
            exactIdMatch = true,
            spellId = 1247279
        },
        [1247275] = {
            exactIdMatch = true,
            spellId = 1247275
        },
        [115308] = { -- Elusive Brew (buff)
            exactIdMatch = true,
            spellId = 115308
        },
        [128939] = { -- Elusive Brew (stacks)
            exactIdMatch = true,
            spellId = 128939
        },
        -- Unholy Death Knight Gargoyle in MoP - cooldown-based simulation
        [49206] = {
            handler = "gargoyle",
            params = {}
        },
        -- Ignite special case - uses SpellTrackingManager for damage calculation
        -- Note: This is only used by DotNumStacks, not for normal aura detection
        -- [12846] = {
        --     handler = "ignite",
        --     params = {}
        -- },
        -- Example: Spell ID 88888 needs custom totem logic
        -- [88888] = {
        --     handler = "totem",
        --     params = { totemType = "fire" }
        -- },
    },

    -- Priority mappings for debuff systems
    priority = {
        [ns.Types:GetType("DebuffType").ARMOR] = {
            [8647] = 100, -- Expose Armor (Rogue) - highest priority
            [770] = 90,   -- Faerie Fire (Druid) - high priority
            [35387] = 80, -- Corrosive Spit (Hunter pet) - medium-high priority
            [7386] = 70,  -- Sunder Armor (Warrior) - medium priority
            [99] = 60,    -- Demoralizing Roar (Druid) - lower priority
        },
        [ns.Types:GetType("DebuffType").SPELL_DAMAGE] = {
            [1490] = 100, -- Curse of Elements (Warlock) - highest priority
            [55749] = 90, -- Acid Spit (Hunter pet) - high priority
            [770] = 80,   -- Faerie Fire (Druid) - medium priority
        },
        [ns.Types:GetType("DebuffType").PHYSICAL_DAMAGE] = {
            [55749] = 100, -- Acid Spit (Hunter pet) - highest priority
            [29859] = 90,  -- Blood Frenzy (Warrior) - high priority
            [58413] = 80,  -- Savage Combat (Rogue) - medium priority
        }
    },

    -- Known stackable debuffs and their max stacks
    maxStacks = {
        [113746] = 3, -- Sunder Armor (Weakened Armor) - 3 stacks
    }
}
local defaults = {
    global = {
        smartDetectionEnabled = true, -- Enable smart detection by default
        cacheDuration = CONSTANTS.AURA_CACHE_TIME,
    },
    char = {},
    class = {}
}
-- ============================ MODULE CREATION ============================
--- @class EnhancedAuraHandlers: CoreModule
local EnhancedAuraHandlers = NAG:CreateModule("EnhancedAuraHandlers", defaults, {
    moduleType = ns.MODULE_TYPES.HANDLER,
})


-- ============================ MODULE INITIALIZATION ============================
function EnhancedAuraHandlers:ModuleEnable()
    -- Update cache duration from database (if valid)
    local dbCacheDuration = self.db.global.cacheDuration
    if dbCacheDuration and dbCacheDuration > 0 then
        self.AURA_CACHE_TIME = dbCacheDuration
        self:Debug("Cache duration set from database: %.2f seconds", self.AURA_CACHE_TIME)
    else
        -- Fallback to default if database value is invalid
        self.AURA_CACHE_TIME = CONSTANTS.AURA_CACHE_TIME
        self:Warn("Invalid cache duration in database (%.2f), using default: %.2f seconds",
            tostring(dbCacheDuration), self.AURA_CACHE_TIME)
    end
end

function EnhancedAuraHandlers:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    Types = NAG:GetModule("Types")
    DataManager = NAG:GetModule("DataManager")
    SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    StateManager = NAG:GetModule("StateManager")
    CacheRefreshManager = NAG:GetModule("CacheRefreshManager")

    -- Initialize cache duration with default value (CRITICAL for cache to work!)
    -- This will be overridden by database value in ModuleEnable, but we need a default
    -- to prevent nil cache duration which causes 0% hit rate
    self.AURA_CACHE_TIME = CONSTANTS.AURA_CACHE_TIME

    -- Initialize caching
    self.auraCache = {}

    -- Performance counters
    self.cacheHits = 0
    self.cacheMisses = 0

    self:Debug("EnhancedAuraHandlers initialized with cache duration: %.2f seconds", self.AURA_CACHE_TIME)
end

function EnhancedAuraHandlers:ModuleDisable()
end

--- Get options for the module
--- @return table Options table
function EnhancedAuraHandlers:GetOptions()
    return {
        type = "group",
        name = L["Enhanced Aura Handlers"] or "Enhanced Aura Handlers",
        desc = L["Configure enhanced aura detection settings"] or "Configure enhanced aura detection settings",
        args = {
            smartDetection = {
                type = "toggle",
                name = L["smartDetection"] or "Smart Detection",
                desc = L["smartDetectionDesc"] or "Automatically determine if auras are buffs or debuffs",
                get = function() return self:GetSetting("global", "smartDetectionEnabled", true) end,
                set = function(_, value)
                    self:SetSetting("global", "smartDetectionEnabled", value)
                    self:ClearCache()
                end,
                order = 1
            },
            cacheStats = {
                type = "execute",
                name = L["cacheStats"] or "Show Cache Stats",
                desc = L["cacheStatsDesc"] or "Display cache hit/miss statistics",
                func = function()
                    local stats = self:GetCacheStats()
                    self:Print(string.format("Cache Stats: Hits: %d, Misses: %d, Hit Rate: %.1f%%",
                        stats.hits, stats.misses, stats.hitRate))
                end,
                order = 2
            },
            cacheDuration = {
                type = "range",
                name = L["cacheDuration"] or "Cache Duration",
                desc = L["cacheDurationDesc"] or "How long to cache aura data (in seconds)",
                min = 0.1,
                max = 10.0,
                step = 0.1,
                get = function() return self:GetSetting("global", "cacheDuration", 0.1) end,
                set = function(_, value)
                    self:SetSetting("global", "cacheDuration", value)
                    self.AURA_CACHE_TIME = value
                    self:ClearCache()
                    self:Print(string.format("Cache duration set to %.1f seconds", value))
                end,
                order = 3
            },
            clearCache = {
                type = "execute",
                name = L["clearCache"] or "Clear Cache",
                desc = L["EnhancedAuraHandlersClearCacheDesc"] or "Clear the aura cache",
                func = function()
                    self:ClearCache()
                    self:Print("Aura cache cleared")
                end,
                order = 4
            }
        }
    }
end

-- ============================ SPELL MAPPING SYSTEM ============================

--- Unified spell resolution system - handles all mapping types with clear priority order
--- @param spellId number|string The spell ID or name to resolve
--- @return string|nil Resolution type ("direct", "multi", "conditional", "custom", or nil)
--- @return any|nil Resolved data (new spell ID or mapping configuration)
function EnhancedAuraHandlers:ResolveSpell(spellId)
    if not spellId then
        self:Warn("ResolveSpell: spellId is nil")
        return nil
    end

    -- If it's already a string (spell name), return it as-is for normal processing
    if type(spellId) == "string" then
        return nil -- No mapping needed for spell names
    end

    -- Check cache first (only for numeric spell IDs)
    -- OPTIMIZATION: Use format() to avoid temporary string allocations
    local cacheKey = format("resolve_%s", tostring(spellId))
    local currentTime = GetTime()
    local cacheEntry = self.auraCache[cacheKey]
    if cacheEntry and currentTime < cacheEntry.nextUpdate then
        -- Return cached data (even if it's false/nil) - check for existence, not truthiness
        if cacheEntry.data ~= nil then
            return unpack(cacheEntry.data, 1, 28)
        end
    end

    local resultType, resultData = nil, nil

    -- Check all mapping types in priority order
    if SPELL_MAPPINGS.direct[spellId] then
        resultType, resultData = "direct", SPELL_MAPPINGS.direct[spellId]
    elseif SPELL_MAPPINGS.items[spellId] then
        resultType, resultData = "direct", SPELL_MAPPINGS.items[spellId]
    elseif SPELL_MAPPINGS.multi[spellId] then
        resultType, resultData = "multi", SPELL_MAPPINGS.multi[spellId]
    elseif SPELL_MAPPINGS.conditional[spellId] then
        resultType, resultData = "conditional", SPELL_MAPPINGS.conditional[spellId]
    elseif SPELL_MAPPINGS.custom[spellId] then
        resultType, resultData = "custom", SPELL_MAPPINGS.custom[spellId]
    end

    -- Cache the result
    self:CacheResult(cacheKey, { resultType, resultData })
    return resultType, resultData
end

--- Legacy function for backward compatibility - resolves only direct mappings
--- @param spellId number|string The spell ID or name to resolve
--- @return number|string|nil Resolved spell ID or original spell name
function EnhancedAuraHandlers:ResolveSpellId(spellId)
    local resultType, resultData = self:ResolveSpell(spellId)
    if resultType == "direct" then
        return resultData
    end
    return spellId -- Return original if no direct mapping
end

--- Resolves multi-aura mappings (ANY, ALL, NONE logic)
--- @param unit string The unit to check
--- @param mapping table The multi-mapping configuration
--- @param filter string|nil Optional filter for aura checking
--- @return AuraData|boolean AuraData table if found, true for "none" type, false if not found
function EnhancedAuraHandlers:ResolveMultiAura(unit, mapping, filter)
    if not mapping or not mapping.auras or not mapping.type then
        return false
    end

    local auras = mapping.auras
    local type = mapping.type

    if type == "any" then
        -- Check if ANY of the auras exist - return the first found aura's data
        for _, auraId in ipairs(auras) do
            local result = self:FindAuraBySpellId(unit, auraId, filter or "HELPFUL")
            if result and result.name and result.spellId == auraId then
                return result
            end
        end
        return false
    elseif type == "all" then
        -- Check if ALL of the auras exist, return first found's values
        local firstFound = nil
        for _, auraId in ipairs(auras) do
            local result = self:FindAuraBySpellId(unit, auraId, filter or "HELPFUL")
            if not result or not result.name or result.spellId ~= auraId then
                return false  -- Missing aura, fail
            end
            -- Store the first found aura's values (only once)
            if not firstFound then
                firstFound = result
            end
        end
        return firstFound
    elseif type == "none" then
        -- Check if NONE of the auras exist
        for _, auraId in ipairs(auras) do
            local result = self:FindAuraBySpellId(unit, auraId, filter or "HELPFUL")
            if result and result.name and result.spellId == auraId then
                return false
            end
        end
        return true
    end

    return false
end
local cachedResults = {}

--- Resolves conditional mappings (OR, AND, NOT logic)
--- @param unit string The unit to check
--- @param mapping table The conditional mapping configuration
--- @param filter string|nil Optional filter for aura checking
--- @return AuraData|boolean AuraData table if found, true for pass conditions, false if not found
function EnhancedAuraHandlers:ResolveConditional(unit, mapping, filter)
    if not mapping or not mapping.conditions or not mapping.logic then
        return false
    end

    local conditions = mapping.conditions
    local logic = mapping.logic

    -- Reuse cached table to avoid allocation
    wipe(cachedResults)
    local results = cachedResults

    -- Check all conditions
    for _, condition in ipairs(conditions) do
        local auraId = condition.aura
        local required = condition.required
        local result = self:FindAuraBySpellId(unit, auraId, filter or "HELPFUL")
        local exists = result and result.name and result.spellId == auraId

        table.insert(results, {
            aura = auraId,
            required = required,
            exists = exists,
            data = exists and result or nil
        })
    end

    -- Apply logic
    if logic == "or" then
        -- At least one required condition must be true
        for _, result in ipairs(results) do
            if result.required and result.exists then
                return result.data
            end
        end
        return false
    elseif logic == "and" then
        -- All required conditions must be true
        for _, result in ipairs(results) do
            if result.required and not result.exists then
                return false
            end
        end
        -- Return data from the first required condition
        for _, result in ipairs(results) do
            if result.required and result.exists then
                return result.data
            end
        end
        return true
    elseif logic == "not" then
        -- Required conditions must NOT be true
        for _, result in ipairs(results) do
            if result.required and result.exists then
                return false
            end
        end
        return true
    end

    return false
end

--- Resolves custom handler mappings
--- @param unit string The unit to check
--- @param mapping table The custom mapping configuration
--- @param filter string|nil Optional filter for aura checking
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:ResolveCustom(unit, mapping, filter)
    if not mapping then
        return false
    end

    -- Handle exactIdMatch flag (simplest case)
    if mapping.exactIdMatch then
        return self:FindAuraBySpellId(unit, mapping.spellId, filter, true)
    end

    -- Handle traditional handler-based mappings
    if not mapping.handler then
        return false
    end

    local handler = mapping.handler
    local params = mapping.params or {}

    -- Dispatch to custom handler
    if handler == "totem" then
        return self:HandleTotemCase(params.totemType or 0, unit, filter)
    elseif handler == "vengeance" then
        return self:HandleVengeanceCase(params.spellId or 0, unit, filter)
    elseif handler == "storm_earth_fire" then
        return self:HandleStormEarthFireCase(params.spellId or 0, unit, filter)
    elseif handler == "chi_brew" then
        return self:HandleChiBrewCase(params.spellId or 0, unit, filter)
    elseif handler == "dark_transformation" then
        return self:HandleDarkTransformationCase(params.spellId or 0, unit, filter)
    elseif handler == "gargoyle" then
        return self:HandleGargoyleCase(params.spellId or 0, unit, filter)
    elseif handler == "ignite" then
        return self:HandleIgniteCase(params.spellId or 0, unit, filter)
    end

    return false
end

--- Handles totem special case (spell ID 88747)
--- @param spellId number The spell ID
--- @param unit string The unit to check
--- @param ... any Additional parameters
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:HandleTotemCase(spellId, unit, ...)
    if spellId == 88747 then
        local totemSlot
        if GetTotemInfo(3) then
            totemSlot = 3
        elseif GetTotemInfo(2) then
            totemSlot = 2
        elseif GetTotemInfo(1) then
            totemSlot = 1
        else
            return false
        end

        return {
            name = "Totem",
            icon = "Interface\\Icons\\Spell_Nature_StoneSkinTotem",
            count = totemSlot,
            spellId = spellId
        }
    end
    return false
end

--- Handles vengeance special case (spell ID 120267)
--- @param spellId number The spell ID
--- @param unit string The unit to check
--- @param ... any Additional parameters
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:HandleVengeanceCase(spellId, unit, ...)
    if spellId == 120267 then
        local vengeanceAP = NAG:GetVengeanceAP()
        return {
            name = "Vengeance",
            icon = "Interface\\Icons\\Spell_Nature_Reincarnation",
            count = vengeanceAP,
            spellId = spellId
        }
    end
    return false
end


--- Handles Storm, Earth and Fire special case
--- @param spellId number The spell ID
--- @param unit string The unit to check
--- @param ... any Additional parameters
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:HandleStormEarthFireCase(spellId, unit, ...)
    if spellId == 138228 then
        -- Check for Storm, Earth, and Fire buff
        local aura = self:FindAuraBySpellId(unit, 137639, "HELPFUL", true)
        if aura and aura.spellId == 137639 then
            return aura
        end
        return false
    elseif spellId == 128938 then
        -- Check for Storm, Earth, and Fire buff (alternative ID)
        local aura = self:FindAuraBySpellId(unit, 128939, "HELPFUL", true)
        if aura and aura.spellId == 128939 then
            return aura
        end
        return false
    end
    return false
end

--- Handles Chi Brew special case
--- @param spellId number The spell ID
--- @param unit string The unit to check
--- @param ... any Additional parameters
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:HandleChiBrewCase(spellId, unit, ...)
    if spellId == 100787 then
        -- Check for Chi Brew buff
        local aura = self:FindAuraBySpellId(unit, 125359, "HELPFUL", true)
        if aura and aura.spellId == 125359 then
            return aura
        end
        return false
    end
    return false
end

--- Handles Dark Transformation special case (MoP version checks pet unit)
--- @param spellId number The spell ID
--- @param unit string The unit to check
--- @param ... any Additional parameters
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:HandleDarkTransformationCase(spellId, unit, ...)
    if spellId == 63560 then
        -- In MoP, Dark Transformation should check pet unit
        if ns.Version:IsMoP() then
            local spellTable = UnitAura("pet", spellId, "HELPFUL")
            if spellTable then
                local aura = self:FormatAuraResult(spellTable)
                if aura and aura.spellId == spellId then
                    return aura
                end
            end
            return false
        else
            -- In other versions, check the specified unit
            local aura = self:FindAuraBySpellId(unit, spellId, "HELPFUL", true)
            if aura and aura.spellId == spellId then
                return aura
            end
            return false
        end
    end
    return false
end

--- Handles Unholy Death Knight Gargoyle special case (MoP cooldown-based simulation)
--- TODO: gargoyle attacking puts a debuff on the target?
--- @param spellId number The spell ID
--- @param unit string The unit to check
--- @param ... any Additional parameters
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:HandleGargoyleCase(spellId, unit, ...)
    -- Only handle in MoP (simplified - only Unholy DKs can cast this spell)
    if ns.Version:IsMoP() then
        local timeToReady = NAG:SpellTimeToReady(49206)

        if timeToReady > 150 then
            -- Aura is active, calculate remaining time based on cooldown
            -- Gargoyle has 180s cooldown, aura lasts 30s, so aura is active until 150s into cooldown
            local remainingTime = timeToReady - 150
            local duration = 30 -- Gargoyle duration
            local expirationTime = GetTime() + remainingTime

            self:Debug("Gargoyle active! remainingTime=%s", tostring(remainingTime))
            return {
                name = "Gargoyle",
                icon = "Interface\\Icons\\Ability_DeathKnight_SummonGargoyle",
                count = 1,
                duration = duration,
                expirationTime = expirationTime,
                spellId = spellId
            }
        end
    end

    return false
end

--- Handles Ignite special case (spell ID 12846) - uses SpellTrackingManager for damage calculation
--- This handler is only used when we specifically need damage calculation, not normal aura detection
--- @param spellId number The spell ID
--- @param unit string The unit to check
--- @param ... any Additional parameters
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:HandleIgniteCase(spellId, unit, ...)
    if spellId == 12846 then
        -- Register Ignite if not already tracked
        if not SpellTrackingManager:GetPeriodicEffectInfo(413843) then
            SpellTrackingManager:RegisterPeriodicDamage({ 413843 }, {
                targets = {},
                spellId = 413843,
                auraId = 12846 -- Track the Ignite aura ID
            })
        end

        local effect = SpellTrackingManager:GetPeriodicEffectInfo(413843)
        if effect and effect.tickDamage then
            local classModule = NAG:GetModule("MAGE")
            local multiplier = classModule.db.char.igniteMultiplier or 1
            local damage = effect.tickDamage * multiplier

            -- Return damage as "count" for DotNumStacks compatibility
            return {
                name = "Ignite",
                icon = "Interface\\Icons\\Spell_Fire_Incinerate",
                count = damage,
                spellId = spellId
            }
        end
        return false
    end
    return false
end

--- Checks if a spell ID has a custom damage handler
--- @param spellId number The spell ID to check
--- @return boolean True if the spell has a custom damage handler
function EnhancedAuraHandlers:HasCustomDamageHandler(spellId)
    return CUSTOM_DAMAGE_HANDLERS[spellId] ~= nil
end

--- Gets the custom damage handler name for a spell ID
--- @param spellId number The spell ID to check
--- @return string|nil The handler name, or nil if not found
function EnhancedAuraHandlers:GetCustomDamageHandler(spellId)
    return CUSTOM_DAMAGE_HANDLERS[spellId]
end

--- Gets custom damage for a spell ID using the appropriate handler
--- @param spellId number The spell ID to check
--- @param unit string The unit to check
--- @return number The damage value, or 0 if no custom handler or no damage
function EnhancedAuraHandlers:GetCustomDamage(spellId, unit)
    local handlerName = CUSTOM_DAMAGE_HANDLERS[spellId]
    if not handlerName then
        return 0
    end

    -- Dispatch to the appropriate handler
    if handlerName == "ignite" then
        local aura = self:HandleIgniteCase(spellId, unit)
        return aura and aura.count or 0
    end

    -- Add other handlers here as needed
    -- elseif handlerName == "other_handler" then
    --     local aura = self:HandleOtherCase(spellId, unit)
    --     return aura and aura.count or 0

    return 0
end

--- Adds a custom damage handler for a spell ID
--- @param spellId number The spell ID to add
--- @param handlerName string The handler name
--- @return boolean success True if handler was added successfully
function EnhancedAuraHandlers:AddCustomDamageHandler(spellId, handlerName)
    if not spellId or type(spellId) ~= "number" then
        self:Error("AddCustomDamageHandler: spellId must be a number")
        return false
    end

    if not handlerName or type(handlerName) ~= "string" then
        self:Error("AddCustomDamageHandler: handlerName must be a string")
        return false
    end

    CUSTOM_DAMAGE_HANDLERS[spellId] = handlerName
    self:Debug("Added custom damage handler: %d -> %s", spellId, handlerName)
    return true
end

--- Removes a custom damage handler for a spell ID
--- @param spellId number The spell ID to remove
--- @return boolean success True if handler was removed successfully
function EnhancedAuraHandlers:RemoveCustomDamageHandler(spellId)
    if not spellId or type(spellId) ~= "number" then
        self:Error("RemoveCustomDamageHandler: spellId must be a number")
        return false
    end

    CUSTOM_DAMAGE_HANDLERS[spellId] = nil
    self:Debug("Removed custom damage handler: %d", spellId)
    return true
end

--- Gets the maximum stacks for a spell ID
--- @param spellId number The spell ID to check
--- @return number The maximum stacks for the spell, or 1 if not stackable
function EnhancedAuraHandlers:GetMaxStacks(spellId)
    return SPELL_MAPPINGS.maxStacks[spellId] or 1
end

--- Gets the number of stacks for a spell ID (centralized version of AuraNumStacks)
--- @param spellId number The spell ID to check
--- @param sourceUnit string|nil The unit to check (defaults to "player")
--- @return number The number of stacks of the aura, or 0 if not found
function EnhancedAuraHandlers:AuraNumStacks(spellId, sourceUnit)
    if not spellId then
        self:Warn("AuraNumStacks: spellId is nil")
        return 0
    end
    sourceUnit = sourceUnit or "player"

    -- Determine the filter to use (same logic as UnitAura)
    local actualFilter = nil
    if self.db.global.smartDetectionEnabled ~= false then
        -- Smart detection: auto-detect aura type
        actualFilter = self:AutoDetectAuraType(sourceUnit, spellId)
    else
        -- Default behavior: HELPFUL for player, HARMFUL for others
        actualFilter = UnitIsUnit(sourceUnit, "player") and "HELPFUL" or "HARMFUL"
    end

    -- Check for custom handlers first (like totem case)
    if SPELL_MAPPINGS.custom[spellId] then
        local mapping = SPELL_MAPPINGS.custom[spellId]
        if mapping.handler == "totem" then
            -- Special case for totem (88747) - return totem count
            if GetTotemInfo(3) then
                return 3
            elseif GetTotemInfo(2) then
                return 2
            elseif GetTotemInfo(1) then
                return 1
            else
                return 0
            end
        elseif mapping.handler == "vengeance" then
            -- Special case for vengeance (120267) - return vengeance AP
            local vengeanceAP = NAG:GetVengeanceAP()
            return vengeanceAP or 0
        end
    end

    -- Check for multi-mappings that might affect stack count
    if SPELL_MAPPINGS.multi[spellId] then
        local mapping = SPELL_MAPPINGS.multi[spellId]
        if mapping.type == "any" then
            -- For multi-aura spells, check if any exist and return count from the first one found
            for _, auraId in ipairs(mapping.auras) do
                local aura = self:FindAuraBySpellId(sourceUnit, auraId, actualFilter)
                if aura and aura.name then
                    return aura.count or 0
                end
            end
            return 0
        end
    end

    -- Resolve spell ID through unified mapping system
    local resolutionType, resolutionData = self:ResolveSpell(spellId)
    local actualSpellId = (resolutionType == "direct") and resolutionData or spellId

    -- Check if aura exists and get its count
    local aura = self:FindAuraBySpellId(sourceUnit, actualSpellId, actualFilter)
    if aura == false then
        return 0      -- Aura doesn't exist
    end
    return aura and aura.count or 0 -- Return 0 if count is nil, otherwise return the actual count
end

--- Gets the priority for a spell ID in a debuff type
--- @param spellId number The spell ID to check
--- @param debuffType number The debuff type
--- @return number The priority value, or 0 if not found
function EnhancedAuraHandlers:GetSpellPriority(spellId, debuffType)
    local priorityMapping = SPELL_MAPPINGS.priority[debuffType]
    if priorityMapping then
        return priorityMapping[spellId] or 0
    end
    return 0
end

--- Checks if one spell has higher priority than another in a debuff type
--- @param competingSpellId number The competing spell ID
--- @param originalSpellId number The original spell ID
--- @param debuffType number The debuff type
--- @return boolean True if competing spell has higher priority
function EnhancedAuraHandlers:HasHigherPriority(competingSpellId, originalSpellId, debuffType)
    local competingPriority = self:GetSpellPriority(competingSpellId, debuffType)
    local originalPriority = self:GetSpellPriority(originalSpellId, debuffType)
    return competingPriority > originalPriority
end

--- Adds a spell mapping
--- @param spellId number The spell ID to map
--- @param mappedId number The mapped spell ID
--- @param mappingType string The type of mapping ("direct", "items")
--- @return boolean success True if mapping was added successfully
function EnhancedAuraHandlers:AddSpellMapping(spellId, mappedId, mappingType)
    if SPELL_MAPPINGS[mappingType] then
        SPELL_MAPPINGS[mappingType][spellId] = mappedId
        self:ClearCache() -- Clear cache when adding mappings
        self:Debug("Added spell mapping: %d -> %s (%s)", spellId, tostring(mappedId), mappingType)
        return true
    end
    return false
end

--- Removes a spell mapping
--- @param spellId number The spell ID to remove
--- @param mappingType string The type of mapping
--- @return boolean success True if mapping was removed successfully
function EnhancedAuraHandlers:RemoveSpellMapping(spellId, mappingType)
    if SPELL_MAPPINGS[mappingType] then
        SPELL_MAPPINGS[mappingType][spellId] = nil
        self:ClearCache() -- Clear cache when removing mappings
        self:Debug("Removed spell mapping: %d (%s)", spellId, mappingType)
        return true
    end
    return false
end

-- ============================ SMART DETECTION ============================


--- Auto-detects aura type by trying both filters and returning the one that exists
--- @param unit string The unit to check
--- @param spellId number The spell ID to check
--- @return string "HELPFUL" or "HARMFUL" based on which one exists
function EnhancedAuraHandlers:AutoDetectAuraType(unit, spellId)
    -- Check cache first
    -- OPTIMIZATION: Use format() to avoid temporary string allocations
    if not spellId then
        return "HELPFUL"  -- Default to helpful if spellId is nil
    end
    local cacheKey = format("smart_%s_%s", unit, tostring(spellId))
    local currentTime = GetTime()
    local cacheEntry = self.auraCache[cacheKey]
    if cacheEntry and currentTime < cacheEntry.nextUpdate then
        -- Return cached data (even if it's false/nil) - don't check truthiness!
        if cacheEntry.data ~= nil then
            return cacheEntry.data[1]
        end
    end

    -- Check override list first (fastest path)
    if SMART_DETECTION_CONFIG.overrideList[spellId] then
        local result = SMART_DETECTION_CONFIG.overrideList[spellId]
        self:CacheResult(cacheKey, { result })
        return result
    end

    -- Fallback: try both filters and see which one returns a result
    local buffName = self:FindAuraBySpellId(unit, spellId, "HELPFUL")
    local debuffName = self:FindAuraBySpellId(unit, spellId, "HARMFUL")

    local result
    if buffName and buffName ~= false then
        result = "HELPFUL"
    elseif debuffName and debuffName ~= false then
        result = "HARMFUL"
    else
        -- Default to HELPFUL for player, HARMFUL for others
        result = UnitIsUnit(unit, "player") and "HELPFUL" or "HARMFUL"
    end

    self:CacheResult(cacheKey, { result })
    return result
end

--- Add spell to override list
--- @param spellId number The spell ID to override
--- @param auraType string "HELPFUL" or "HARMFUL"
function EnhancedAuraHandlers:AddOverride(spellId, auraType)
    SMART_DETECTION_CONFIG.overrideList[spellId] = auraType
    self:ClearCache() -- Clear cache when adding overrides
    self:Debug("Added override for spell %d: %s", spellId, auraType)
end

--- Remove spell from override list
--- @param spellId number The spell ID to remove
function EnhancedAuraHandlers:RemoveOverride(spellId)
    SMART_DETECTION_CONFIG.overrideList[spellId] = nil
    self:ClearCache() -- Clear cache when removing overrides
    self:Debug("Removed override for spell %d", spellId)
end

-- ============================ CORE AURA DETECTION ============================

--- Internal function for pure aura detection (no spell resolution)
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @param filter string The filter to use
--- @param exactIdMatch boolean|nil If true, forces exact spell ID matching and skips name-based matching
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:FindAuraBySpellId(unit, spellId, filter, exactIdMatch)
    if not unit or not spellId then
        self:Warn("FindAuraBySpellId: unit or spellId is nil")
        return false
    end

    -- Use spell ID for normal processing
    local actualSpellId = spellId

    -- Get spell name from DataManager for name-based matching (like old AuraUtils.lua)
    -- Skip name-based matching if exactIdMatch is true
    local spellName = nil
    if type(actualSpellId) == "number" and not exactIdMatch then
        if DataManager then
            local spell = DataManager:Get(actualSpellId, DataManager.EntityTypes.SPELL)
            if spell then
                spellName = spell.name
            end
        end
        if not spellName then
            -- Use GetSpellInfo when DataManager not ready or spell not in DataManager
            local spellInfo = WoWAPI.GetSpellInfo(actualSpellId)
            if spellInfo then
                if type(spellInfo) == "table" then
                    spellName = spellInfo.name
                else
                    -- Classic API returns name as first value
                    spellName = spellInfo
                end
            end
        end
    end

    -- OPTIMIZATION: Build cache keys using format() to avoid temporary string allocations
    -- format() creates the final string directly, avoiding intermediate allocations from concatenation
    local cacheKey = format("aura_%s_%s_%s", unit, tostring(actualSpellId), filter or "")
    local nameCacheKey = spellName and format("aura_name_%s_%s_%s", unit, spellName, filter or "") or nil
    local currentTime = GetTime()

    -- Check ID-based cache first
    local cacheEntry = self.auraCache[cacheKey]
    if cacheEntry and currentTime < cacheEntry.nextUpdate then
        self.cacheHits = self.cacheHits + 1
        return cacheEntry.data
    end

    -- Check name-based cache if we have a spell name
    if nameCacheKey then
        local nameCacheEntry = self.auraCache[nameCacheKey]
        if nameCacheEntry and currentTime < nameCacheEntry.nextUpdate then
            self.cacheHits = self.cacheHits + 1
            return nameCacheEntry.data
        end
    end

    self.cacheMisses = self.cacheMisses + 1

    -- Optimized path for single spell ID on player (DBM pattern)
    if UnitIsUnit(unit, "player") and type(actualSpellId) == "number" and GetPlayerAuraBySpellID then
        local spellTable = GetPlayerAuraBySpellID(actualSpellId)
        if spellTable then
            local result = self:FormatAuraResult(spellTable)
            self:CacheResult(cacheKey, result)
            return result
        else
            -- Try name-based lookup if we have a spell name
            if spellName and hasModernAPIs and C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName then
                local spellTable = C_UnitAuras.GetAuraDataBySpellName(unit, spellName, filter)
                if spellTable then
                    local result = self:FormatAuraResult(spellTable)
                    self:CacheResult(cacheKey, result)
                    if nameCacheKey then
                        self:CacheResult(nameCacheKey, result)
                    end
                    return result
                end
            end
            -- Fall through to iteration loop for name-based matching
        end
    end

    -- Optimized path for single spell name (DBM pattern)
    if type(actualSpellId) == "string" and hasModernAPIs and C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName then
        local spellTable = C_UnitAuras.GetAuraDataBySpellName(unit, actualSpellId, filter)
        if not spellTable then
            -- Cache the "not found" result
            self:CacheResult(cacheKey, false)
            return false
        end

        local result = self:FormatAuraResult(spellTable)
        self:CacheResult(cacheKey, result)
        return result
    end

    -- Fallback to iteration (DBM pattern)
    local maxIterations = CONSTANTS.MAX_ITERATIONS
    for i = 1, maxIterations do
        local spellTable, name, icon, count, dispelType, duration, expirationTime,
        unitCaster, isStealable, shouldConsolidate, spellIdFound,
        canApplyAura, isBossDebuff, castByPlayer, nameplateShowPersonal,
        timeMod, value1, value2, value3

        if hasModernAPIs then
            -- Modern API returns table
            spellTable = UnitAura(unit, i, filter)
            if not spellTable then break end

            name = spellTable.name
            icon = spellTable.icon
            count = spellTable.applications
            dispelType = spellTable.dispelName
            duration = spellTable.duration
            expirationTime = spellTable.expirationTime
            unitCaster = spellTable.sourceUnit
            isStealable = spellTable.isStealable
            nameplateShowPersonal = spellTable.nameplateShowPersonal
            spellIdFound = spellTable.spellId
            canApplyAura = spellTable.canApplyAura
            isBossDebuff = spellTable.isBossAura
            castByPlayer = spellTable.isFromPlayerOrPlayerPet
            nameplateShowAll = spellTable.nameplateShowAll
            timeMod = spellTable.timeMod
            shouldConsolidate = nil  -- Not available in Modern API
            value1 = spellTable.points and spellTable.points[1]
            value2 = spellTable.points and spellTable.points[2]
            value3 = spellTable.points and spellTable.points[3]
            -- Capture additional values for world buffs (up to 28)
            value4 = spellTable.points and spellTable.points[4]
            value5 = spellTable.points and spellTable.points[5]
            value6 = spellTable.points and spellTable.points[6]
            value7 = spellTable.points and spellTable.points[7]
            value8 = spellTable.points and spellTable.points[8]
            value9 = spellTable.points and spellTable.points[9]
            value10 = spellTable.points and spellTable.points[10]
            value11 = spellTable.points and spellTable.points[11]
            value12 = spellTable.points and spellTable.points[12]
        else
            -- Classic API returns individual values
            name, icon, count, dispelType, duration, expirationTime,
            unitCaster, isStealable, nameplateShowPersonal, spellIdFound,
            canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll,
            timeMod, shouldConsolidate, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10,
            value11, value12 = UnitAura(unit, i, filter)
        end

        if not name then break end

        -- Match by spell ID first (fastest path)
        if actualSpellId == spellIdFound then
            -- Create AuraData table with modern field names
            local result = {
                name = name,
                icon = icon,
                count = count,
                dispelType = dispelType,
                duration = duration,
                expirationTime = expirationTime,
                sourceUnit = unitCaster,
                isStealable = isStealable,
                nameplateShowPersonal = nameplateShowPersonal,
                spellId = spellIdFound,
                canApplyAura = canApplyAura,
                isBossAura = isBossDebuff,
                isFromPlayerOrPlayerPet = castByPlayer,
                nameplateShowAll = nameplateShowAll,
                timeMod = timeMod,
                shouldConsolidate = shouldConsolidate,
                points = {value1, value2, value3, value4, value5, value6,
                         value7, value8, value9, value10, value11, value12}
            }

            self:CacheResult(cacheKey, result)
            if nameCacheKey then
                self:CacheResult(nameCacheKey, result)
            end
            return result
        end

        -- Fallback to name-based matching if spell IDs don't match
        -- If exactIdMatch is true, skip name matching
        if not exactIdMatch and type(actualSpellId) == "number" then
            -- Try name from DataManager first
            local nameMatches = false
            if spellName and name == spellName then
                nameMatches = true
            else
                -- Fallback: use GetSpellInfo to get spell name and compare
                -- Handle both table (Modern) and multi-value (Classic) returns
                local spellInfo = WoWAPI.GetSpellInfo(actualSpellId)
                if spellInfo then
                    local spellInfoName = nil
                    if type(spellInfo) == "table" then
                        spellInfoName = spellInfo.name
                    else
                        -- Classic API returns name as first value
                        spellInfoName = spellInfo
                    end
                    if spellInfoName and name == spellInfoName then
                        nameMatches = true
                        -- Cache the spell name for future iterations
                        if not spellName then
                            spellName = spellInfoName
                        end
                    end
                end
            end

            if nameMatches then
                -- Create AuraData table with modern field names
                local result = {
                    name = name,
                    icon = icon,
                    count = count,
                    dispelType = dispelType,
                    duration = duration,
                    expirationTime = expirationTime,
                    sourceUnit = unitCaster,
                    isStealable = isStealable,
                    nameplateShowPersonal = nameplateShowPersonal,
                    spellId = spellIdFound,
                    canApplyAura = canApplyAura,
                    isBossAura = isBossDebuff,
                    isFromPlayerOrPlayerPet = castByPlayer,
                    nameplateShowAll = nameplateShowAll,
                    timeMod = timeMod,
                    shouldConsolidate = shouldConsolidate,
                    points = {value1, value2, value3, value4, value5, value6,
                             value7, value8, value9, value10, value11, value12}
                }

                self:CacheResult(cacheKey, result)
                if nameCacheKey then
                    self:CacheResult(nameCacheKey, result)
                end
                return result
            end
        end
    end

    -- Cache the "not found" result to prevent repeated lookups
    self:CacheResult(cacheKey, false)
    if nameCacheKey then
        self:CacheResult(nameCacheKey, false)
    end
    return false
end

--- Core function that handles all aura detection logic with integrated smart detection
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (e.g., "HELPFUL", "HARMFUL", "HARMFUL|PLAYER")
---   If nil and smart detection enabled, will auto-detect aura type
---   If nil and smart detection disabled, uses default based on unit
--- @param exactIdMatch boolean|nil If true, forces exact spell ID matching and skips name-based matching
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:UnitAura(unit, spellId, filter, exactIdMatch)
    if not unit or not spellId then
        self:Warn("UnitAura: unit or spellId is nil")
        return false
    end


    -- Handle spell resolution for numeric spell IDs FIRST
    if type(spellId) == "number" then
        local resolutionType, resolutionData = self:ResolveSpell(spellId)
        if resolutionType then

            if resolutionType == "multi" then
                -- Determine filter for multi-aura resolution
                local actualFilter = filter or (UnitIsUnit(unit, "player") and "HELPFUL" or "HARMFUL")
                return self:ResolveMultiAura(unit, resolutionData, actualFilter)
            elseif resolutionType == "conditional" then
                -- Determine filter for conditional resolution
                local actualFilter = filter or (UnitIsUnit(unit, "player") and "HELPFUL" or "HARMFUL")
                return self:ResolveConditional(unit, resolutionData, actualFilter)
            elseif resolutionType == "custom" then
                -- For custom resolution with exactIdMatch, don't use smart detection
                local actualFilter = filter or (UnitIsUnit(unit, "player") and "HELPFUL" or "HARMFUL")
                return self:ResolveCustom(unit, resolutionData, actualFilter)
            elseif resolutionType == "direct" then
                -- Use resolved spell ID for normal processing
                spellId = resolutionData
            end
        else
            -- Fallback to ResolveSpellId for backward compatibility (like old AuraUtils.lua)
            spellId = self:ResolveSpellId(spellId)
        end
    end

    -- Determine the filter to use (only for non-custom resolutions)
    local actualFilter = filter
    if not actualFilter then
        -- No filter provided - use smart detection or default
        if self.db.global.smartDetectionEnabled ~= false then
            -- Smart detection: auto-detect aura type
            actualFilter = self:AutoDetectAuraType(unit, spellId)
        else
            -- Default behavior: HELPFUL for player, HARMFUL for others
            actualFilter = UnitIsUnit(unit, "player") and "HELPFUL" or "HARMFUL"
        end
    end

    -- Use internal function for pure aura detection
    return self:FindAuraBySpellId(unit, spellId, actualFilter, exactIdMatch)
end

-- ============================ CONVENIENCE FUNCTIONS ============================

--- Check for buffs on a unit
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HELPFUL")
--- @param exactIdMatch boolean|nil If true, forces exact spell ID matching and skips name-based matching
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:UnitBuff(unit, spellId, filter, exactIdMatch)
    -- Call UnitAura directly and return results (no redundant pack/unpack)
    return self:UnitAura(unit, spellId, filter or "HELPFUL", exactIdMatch)
end

--- Check for debuffs on a unit
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HARMFUL|PLAYER")
--- @param exactIdMatch boolean|nil If true, forces exact spell ID matching and skips name-based matching
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:UnitDebuff(unit, spellId, filter, exactIdMatch)
    -- Call UnitAura directly and return results (no redundant pack/unpack)
    return self:UnitAura(unit, spellId, filter or "HARMFUL|PLAYER", exactIdMatch)
end

--- Check for any debuff on a unit (global scope)
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:UnitDebuffGlobal(unit, spellId)
    -- Call UnitAura directly and return results (no redundant pack/unpack)
    return self:UnitAura(unit, spellId, "HARMFUL")
end

-- ============================ MULTI-SPELL FUNCTIONS ============================

local cachedSpellInputs = {}
-- Cached spell match table for MatchesAnySpell
local cachedSpellMatch = { name = nil, spellId = nil }

--- Check for multiple spells on a unit
--- @param unit string The unit to check
--- @param ... number|string|boolean Variable arguments: spell IDs/names to check, and optional filter parameter
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:UnitAuraMulti(unit, ...)
    -- Process variable arguments to separate spells from filter
    -- Reuse cached table to avoid allocation
    wipe(cachedSpellInputs)
    local spellInputs = cachedSpellInputs
    local filter = "HELPFUL" -- default


    for i = 1, select('#', ...) do
        local arg = select(i, ...)
        if type(arg) == "string" and (strfind(arg, "|") or arg == "HELPFUL" or arg == "HARMFUL") then
            -- This looks like a filter (e.g., "HARMFUL|PLAYER", "HELPFUL", "HARMFUL")
            filter = arg
        else
            table.insert(spellInputs, arg)
        end
    end

    if not unit or not spellInputs[1] then return false end

    -- Check cache first for single spell case
    if #spellInputs == 1 and type(spellInputs[1]) == "number" then
        -- OPTIMIZATION: Use format() to avoid temporary string allocations
        local cacheKey = format("aura_multi_%s_%s_%s", unit, tostring(spellInputs[1]), filter or "")
        local currentTime = GetTime()
        local cacheEntry = self.auraCache[cacheKey]
        if cacheEntry and currentTime < cacheEntry.nextUpdate then
            return cacheEntry.data
        end
    end

    -- Use existing APICompat functions (already localized at top of file)

    -- Optimized path for multiple spell IDs on player
    -- Try fast path for each numeric spell ID first (O(N) vs O(M*N) for iteration)
    if UnitIsUnit(unit, "player") and GetPlayerAuraBySpellID then
        -- Check if all inputs are numeric spell IDs
        local allNumeric = true
        for _, input in ipairs(spellInputs) do
            if type(input) ~= "number" then
                allNumeric = false
                break
            end
        end
        if allNumeric then
            -- Try fast path for each spell ID using NATIVE API (returns table)
            for _, spellId in ipairs(spellInputs) do
                local spellTable = GetPlayerAuraBySpellID(spellId)
                if spellTable then
                    local result = self:FormatAuraResult(spellTable)
                    -- Cache with the specific spell ID that was found
                    -- OPTIMIZATION: Use format() to avoid temporary string allocations
                    self:CacheResult(format("aura_multi_%s_%s_%s", unit, tostring(spellId), filter or ""), result)
                    return result
                else
                    -- Cache each "not found" result individually for future queries
                    self:CacheResult(format("aura_multi_%s_%s_%s", unit, tostring(spellId), filter or ""), false)
                end
            end
            -- None found via fast path - all individual results already cached
            return false
        end
    end

    -- Optimized path for single spell name
    if type(spellInputs[1]) == "string" and #spellInputs == 1 and GetAuraDataBySpellName then
        local spellTable = GetAuraDataBySpellName(unit, spellInputs[1], filter)
        local cacheKey = format("aura_multi_%s_%s_%s", unit, tostring(spellInputs[1]), filter or "")
        if not spellTable then
            -- Cache the "not found" result
            self:CacheResult(cacheKey, false)
            return false
        end

        local result = self:FormatAuraResult(spellTable)
        -- OPTIMIZATION: Inline cache key to avoid function call
        self:CacheResult(cacheKey, result)
        return result
    end

    -- Multi-spell iteration (DBM pattern)
    local maxIterations = CONSTANTS.MAX_ITERATIONS
    for i = 1, maxIterations do
        local spellTable, name, icon, count, dispelType, duration, expirationTime,
        unitCaster, isStealable, shouldConsolidate, spellIdFound,
        canApplyAura, isBossDebuff, castByPlayer, nameplateShowPersonal,
        timeMod, value1, value2, value3

        if hasModernAPIs then
            -- Modern API returns table
            spellTable = UnitAura(unit, i, filter)
            if not spellTable then break end
            name = spellTable.name
            icon = spellTable.icon
            count = spellTable.applications
            dispelType = spellTable.dispelName
            duration = spellTable.duration
            expirationTime = spellTable.expirationTime
            unitCaster = spellTable.sourceUnit
            isStealable = spellTable.isStealable
            nameplateShowPersonal = spellTable.nameplateShowPersonal
            spellIdFound = spellTable.spellId
            canApplyAura = spellTable.canApplyAura
            isBossDebuff = spellTable.isBossAura
            castByPlayer = spellTable.isFromPlayerOrPlayerPet
            nameplateShowAll = spellTable.nameplateShowAll
            timeMod = spellTable.timeMod
            shouldConsolidate = nil  -- Not available in Modern API
            value1 = spellTable.points and spellTable.points[1]
            value2 = spellTable.points and spellTable.points[2]
            value3 = spellTable.points and spellTable.points[3]
            value4 = spellTable.points and spellTable.points[4]
            value5 = spellTable.points and spellTable.points[5]
            value6 = spellTable.points and spellTable.points[6]
            value7 = spellTable.points and spellTable.points[7]
            value8 = spellTable.points and spellTable.points[8]
            value9 = spellTable.points and spellTable.points[9]
            value10 = spellTable.points and spellTable.points[10]
            value11 = spellTable.points and spellTable.points[11]
            value12 = spellTable.points and spellTable.points[12]
        else
            -- Classic API returns individual values
            name, icon, count, dispelType, duration, expirationTime,
            unitCaster, isStealable, nameplateShowPersonal, spellIdFound,
            canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll,
            timeMod, shouldConsolidate, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10,
            value11, value12 = UnitAura(unit, i, filter)
        end

        if not name then break end

        -- Check if this aura matches any of the spell inputs
        cachedSpellMatch.name = name
        cachedSpellMatch.spellId = spellIdFound
        if self:MatchesAnySpell(cachedSpellMatch, unpack(spellInputs)) then
            -- Create AuraData table with modern field names
            return {
                name = name,
                icon = icon,
                count = count,
                dispelType = dispelType,
                duration = duration,
                expirationTime = expirationTime,
                sourceUnit = unitCaster,
                isStealable = isStealable,
                nameplateShowPersonal = nameplateShowPersonal,
                spellId = spellIdFound,
                canApplyAura = canApplyAura,
                isBossAura = isBossDebuff,
                isFromPlayerOrPlayerPet = castByPlayer,
                nameplateShowAll = nameplateShowAll,
                timeMod = timeMod,
                shouldConsolidate = shouldConsolidate,
                points = {value1, value2, value3, value4, value5, value6,
                         value7, value8, value9, value10, value11, value12}
            }
        end
    end

    -- Cache the "not found" result for single spell queries
    if #spellInputs == 1 and type(spellInputs[1]) == "number" then
        local cacheKey = format("aura_multi_%s_%s_%s", unit, tostring(spellInputs[1]), filter or "")
        self:CacheResult(cacheKey, false)
    end

    return false
end

--- Check for multiple buffs on a unit
--- @param unit string The unit to check
--- @param ... number|string|boolean Variable arguments: spell IDs/names to check, and optional filter parameter
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:UnitBuffMulti(unit, ...)
    -- Call UnitAuraMulti directly and return results (properly expand varargs)
    local args = {...}
    table.insert(args, "HELPFUL")
    return self:UnitAuraMulti(unit, unpack(args))
end

--- Check for multiple debuffs on a unit
--- @param unit string The unit to check
--- @param ... number|string|boolean Variable arguments: spell IDs/names to check, and optional filter parameter
--- @return AuraData|boolean AuraData table if found, false if not found
function EnhancedAuraHandlers:UnitDebuffMulti(unit, ...)
    -- Call UnitAuraMulti directly and return results (properly expand varargs)
    local args = {...}
    table.insert(args, "HARMFUL")
    return self:UnitAuraMulti(unit, unpack(args))
end

-- ============================ RAID/GROUP FUNCTIONS ============================

--- Check if anyone in raid has an aura
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HELPFUL")
--- @return boolean hasAura True if anyone in raid has the aura
function EnhancedAuraHandlers:RaidUnitAura(spellId, filter)
    for _, unitId in self:GetGroupMembers() do
        local aura = self:UnitAura(unitId, spellId, filter)
        if aura then return true end
    end
    return false
end

--- Check if anyone in raid has a buff
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HELPFUL")
--- @return boolean hasBuff True if anyone in raid has the buff
function EnhancedAuraHandlers:RaidUnitBuff(spellId, filter)
    return self:RaidUnitAura(spellId, filter or "HELPFUL")
end

--- Check if anyone in raid has a debuff
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HARMFUL")
--- @return boolean hasDebuff True if anyone in raid has the debuff
function EnhancedAuraHandlers:RaidUnitDebuff(spellId, filter)
    return self:RaidUnitAura(spellId, filter or "HARMFUL")
end

--- Check if anyone in raid has the player's buff
--- @param spellId number|string The spell ID or name to check
--- @return boolean hasBuff True if anyone in raid has the player's buff
function EnhancedAuraHandlers:RaidUnitBuffPlayer(spellId)
    return self:RaidUnitAura(spellId, "HELPFUL|PLAYER")
end

--- Check if anyone in raid has the player's debuff
--- @param spellId number|string The spell ID or name to check
--- @return boolean hasDebuff True if anyone in raid has the player's debuff
function EnhancedAuraHandlers:RaidUnitDebuffPlayer(spellId)
    return self:RaidUnitAura(spellId, "HARMFUL|PLAYER")
end

-- ============================ MULTI-MAPPING API ============================

--- Add a multi-mapping (one spell ID maps to multiple auras)
--- @param spellId number The spell ID to map
--- @param auras table Array of aura IDs to check
--- @param mappingType string Type of mapping ("any", "all", "none")
--- @return boolean success True if mapping was added successfully
function EnhancedAuraHandlers:AddMultiMapping(spellId, auras, mappingType)
    if not spellId or type(spellId) ~= "number" then
        self:Error("AddMultiMapping: spellId must be a number")
        return false
    end

    if not auras or type(auras) ~= "table" or #auras == 0 then
        self:Error("AddMultiMapping: auras must be a non-empty table")
        return false
    end

    if not mappingType or not (mappingType == "any" or mappingType == "all" or mappingType == "none") then
        self:Error("AddMultiMapping: mappingType must be 'any', 'all', or 'none'")
        return false
    end

    SPELL_MAPPINGS.multi[spellId] = {
        type = mappingType,
        auras = auras
    }

    self:Debug("Added multi-mapping: %d -> %s (%s)", spellId, table.concat(auras, ", "), mappingType)
    return true
end

--- Add a conditional mapping (complex logic with OR/AND/NOT)
--- @param spellId number The spell ID to map
--- @param conditions table Array of condition objects
--- @param logic string Logic type ("or", "and", "not")
--- @return boolean success True if mapping was added successfully
function EnhancedAuraHandlers:AddConditionalMapping(spellId, conditions, logic)
    if not spellId or type(spellId) ~= "number" then
        self:Error("AddConditionalMapping: spellId must be a number")
        return false
    end

    if not conditions or type(conditions) ~= "table" or #conditions == 0 then
        self:Error("AddConditionalMapping: conditions must be a non-empty table")
        return false
    end

    if not logic or not (logic == "or" or logic == "and" or logic == "not") then
        self:Error("AddConditionalMapping: logic must be 'or', 'and', or 'not'")
        return false
    end

    -- Validate conditions
    for i, condition in ipairs(conditions) do
        if not condition.aura or type(condition.aura) ~= "number" then
            self:Error("AddConditionalMapping: condition %d must have a numeric aura ID", i)
            return false
        end
        if condition.required == nil then
            condition.required = true -- Default to required
        end
    end

    SPELL_MAPPINGS.conditional[spellId] = {
        type = "conditional",
        logic = logic,
        conditions = conditions
    }

    self:Debug("Added conditional mapping: %d -> %s logic with %d conditions", spellId, logic, #conditions)
    return true
end

--- Add a custom mapping (custom handler for special cases)
--- @param spellId number The spell ID to map
--- @param handler string The handler name ("totem", "vengeance")
--- @param params table|nil Optional parameters for the handler
--- @return boolean success True if mapping was added successfully
function EnhancedAuraHandlers:AddCustomMapping(spellId, handler, params)
    if not spellId or type(spellId) ~= "number" then
        self:Error("AddCustomMapping: spellId must be a number")
        return false
    end

    if not handler or type(handler) ~= "string" then
        self:Error("AddCustomMapping: handler must be a string")
        return false
    end

    SPELL_MAPPINGS.custom[spellId] = {
        type = "custom",
        handler = handler,
        params = params or {}
    }

    self:Debug("Added custom mapping: %d -> %s handler", spellId, handler)
    return true
end

--- Remove a multi-mapping
--- @param spellId number The spell ID to remove
--- @param mappingType string The type of mapping to remove ("multi", "conditional", "custom")
--- @return boolean success True if mapping was removed successfully
function EnhancedAuraHandlers:RemoveMultiMapping(spellId, mappingType)
    if not spellId or type(spellId) ~= "number" then
        self:Error("RemoveMultiMapping: spellId must be a number")
        return false
    end

    if mappingType == "multi" then
        SPELL_MAPPINGS.multi[spellId] = nil
    elseif mappingType == "conditional" then
        SPELL_MAPPINGS.conditional[spellId] = nil
    elseif mappingType == "custom" then
        SPELL_MAPPINGS.custom[spellId] = nil
    else
        self:Error("RemoveMultiMapping: mappingType must be 'multi', 'conditional', or 'custom'")
        return false
    end

    self:Debug("Removed %s mapping: %d", mappingType, spellId)
    return true
end

--- Get all multi-mappings of a specific type
--- @param mappingType string|nil The type of mappings to get ("multi", "conditional", "custom", or nil for all)
--- @return table mappings Table of mappings
function EnhancedAuraHandlers:GetMultiMappings(mappingType)
    if mappingType == "multi" then
        return SPELL_MAPPINGS.multi
    elseif mappingType == "conditional" then
        return SPELL_MAPPINGS.conditional
    elseif mappingType == "custom" then
        return SPELL_MAPPINGS.custom
    elseif mappingType == nil then
        return {
            multi = SPELL_MAPPINGS.multi,
            conditional = SPELL_MAPPINGS.conditional,
            custom = SPELL_MAPPINGS.custom
        }
    else
        self:Error("GetMultiMappings: mappingType must be 'multi', 'conditional', 'custom', or nil")
        return {}
    end
end

--- Clear all multi-mappings of a specific type
--- @param mappingType string|nil The type of mappings to clear ("multi", "conditional", "custom", or nil for all)
--- @return boolean success True if mappings were cleared successfully
function EnhancedAuraHandlers:ClearMultiMappings(mappingType)
    if mappingType == "multi" then
        SPELL_MAPPINGS.multi = {}
    elseif mappingType == "conditional" then
        SPELL_MAPPINGS.conditional = {}
    elseif mappingType == "custom" then
        SPELL_MAPPINGS.custom = {}
    elseif mappingType == nil then
        SPELL_MAPPINGS.multi = {}
        SPELL_MAPPINGS.conditional = {}
        SPELL_MAPPINGS.custom = {}
    else
        self:Error("ClearMultiMappings: mappingType must be 'multi', 'conditional', 'custom', or nil")
        return false
    end

    self:Debug("Cleared %s multi-mappings", mappingType or "all")
    return true
end

-- ============================ COUNTING FUNCTIONS ============================
local cachedSeenGUIDs = {}

--- Counts unique group/raid members who have a player-cast aura active.
--- Uses battle-tested logic from APL_Class.lua with performance optimizations.
--- Deduplicates by GUID and caches results to reduce scanning overhead.
--- If not in a group, returns 1 if the player has the aura, else 0.
--- RESPECTS GROUP/RAID OVERRIDES for testing purposes.
--- @param spellId number|string The spell ID or name of the aura to count
--- @param filter string|nil Optional filter (defaults to "HELPFUL|PLAYER" for player-cast buffs)
--- @return number count The count of unique party/raid members with the aura (1 if solo)
function EnhancedAuraHandlers:CountRaidMembersWithAura(spellId, filter)
    if not spellId then return 0 end

    local actualFilter = filter or "HELPFUL|PLAYER"
    local now = GetTime()

    -- Check cache first
    -- OPTIMIZATION: Use format() to avoid temporary string allocations
    local cacheKey = format("count_raid_%s_%s", tostring(spellId), actualFilter)
    local cacheEntry = self.auraCache[cacheKey]
    if cacheEntry and now < cacheEntry.nextUpdate then
        return cacheEntry.data or 0
    end

    -- Avoid overlapping heavy group scans: use CacheRefreshManager mutex if available.
    CacheRefreshManager = CacheRefreshManager or NAG:GetModule("CacheRefreshManager", true)
    local lockKey = "aura:" .. cacheKey
    local lockAcquired = false
    if CacheRefreshManager then
        lockAcquired = CacheRefreshManager:AcquireMutex(lockKey)
        if not lockAcquired then
            -- Return stale value (if any) while another scan is in progress.
            return cacheEntry and cacheEntry.data or 0
        end
    end
    local function releaseLock()
        if CacheRefreshManager and lockAcquired then
            CacheRefreshManager:ReleaseMutex(lockKey)
        end
    end

    -- Helper: check if a unit has the specified aura (optimized for performance)
    local function hasAuraOnUnit(unit)
        -- Prefer modern API if available and using player-cast filter
        if actualFilter == "HELPFUL|PLAYER" and GetPlayerAuraBySpellID and UnitIsUnit(unit, "player") then
            local aura = GetPlayerAuraBySpellID(spellId)
            return aura ~= nil
        end

        -- Use our unified aura detection for other cases
        local name = self:UnitAura(unit, spellId, actualFilter)
        return name and name ~= false
    end

    -- Check for group/raid overrides first (StateManager is preloaded)
    local effectiveMemberCount = StateManager:GetEffectiveGroupMemberCount()
    local isEffectivelyInRaid = StateManager:IsEffectivelyInRaid()
    local isEffectivelyInParty = StateManager:IsEffectivelyInParty()

    -- If we have overrides active, simulate realistic raid/group behavior
    if (isEffectivelyInRaid and effectiveMemberCount > 0) or (isEffectivelyInParty and effectiveMemberCount > 0) then
        -- Check if the PLAYER has the aura first
        local playerHasAura = hasAuraOnUnit("player")

        if playerHasAura then
            -- Player has the aura - simulate all raid/group members having it
            local simulatedCount = effectiveMemberCount
            -- Reuse existing cache wrapper or create new one (memory optimization)
            local wrapper = self.auraCache[cacheKey]
            if not wrapper then
                wrapper = {}
                self.auraCache[cacheKey] = wrapper
            end
            wrapper.data = simulatedCount
            wrapper.nextUpdate = now + 0.5 -- Cache for 0.5 seconds
            releaseLock()
            return simulatedCount
        else
            -- Player doesn't have the aura - simulate nobody having it
            -- Reuse existing cache wrapper or create new one (memory optimization)
            local wrapper = self.auraCache[cacheKey]
            if not wrapper then
                wrapper = {}
                self.auraCache[cacheKey] = wrapper
            end
            wrapper.data = 0
            wrapper.nextUpdate = now + 0.5 -- Cache for 0.5 seconds
            releaseLock()
            return 0
        end
    end

    local count = 0

    -- Helper: count 1 if unit has aura and hasn't been seen yet (dedupe by GUID)
    -- Reuse cached table to avoid allocation
    wipe(cachedSeenGUIDs)
    local seenGUIDs = cachedSeenGUIDs

    local function tryCountUnitAura(unit)
        if not UnitExists(unit) then return 0 end
        local guid = UnitGUID(unit)
        if not guid or seenGUIDs[guid] then return 0 end
        seenGUIDs[guid] = true
        return hasAuraOnUnit(unit) and 1 or 0
    end

    -- Use unified group API (respects overrides)
    for _, unit in self:GetGroupMembers() do
        count = count + tryCountUnitAura(unit)
    end

    -- Cache the result for 0.5 seconds
    self:CacheResult(cacheKey, count)
    releaseLock()
    return count
end

-- ============================ HELPER FUNCTIONS ============================


--- Format aura result from spell table (handles both modern and classic APIs)
--- @param spellTable table The spell table from API
--- @return AuraData result Formatted result table with modern field names
function EnhancedAuraHandlers:FormatAuraResult(spellTable)
    if hasModernAPIs then
        -- Modern API - return table with minimal normalization
        return {
            name = spellTable.name,
            icon = spellTable.icon,
            count = spellTable.applications,
            dispelType = spellTable.dispelName,
            duration = spellTable.duration,
            expirationTime = spellTable.expirationTime,
            sourceUnit = spellTable.sourceUnit,
            isStealable = spellTable.isStealable,
            nameplateShowPersonal = spellTable.nameplateShowPersonal,
            spellId = spellTable.spellId,
            canApplyAura = spellTable.canApplyAura,
            isBossAura = spellTable.isBossAura,
            isFromPlayerOrPlayerPet = spellTable.isFromPlayerOrPlayerPet,
            nameplateShowAll = spellTable.nameplateShowAll,
            timeMod = spellTable.timeMod,
            shouldConsolidate = nil,
            points = spellTable.points
        }
    else
        -- Classic API - normalize to modern structure
        return {
            name = spellTable.name,
            icon = spellTable.icon,
            count = spellTable.count,
            dispelType = spellTable.dispelType,
            duration = spellTable.duration,
            expirationTime = spellTable.expirationTime,
            sourceUnit = spellTable.unitCaster,
            isStealable = spellTable.isStealable,
            nameplateShowPersonal = spellTable.nameplateShowPersonal,
            spellId = spellTable.spellId,
            canApplyAura = spellTable.canApplyAura,
            isBossAura = spellTable.isBossDebuff,
            isFromPlayerOrPlayerPet = spellTable.castByPlayer,
            nameplateShowAll = spellTable.nameplateShowAll,
            timeMod = spellTable.timeMod,
            shouldConsolidate = spellTable.shouldConsolidate,
            points = {spellTable.value1, spellTable.value2, spellTable.value3,
                     spellTable.value4, spellTable.value5, spellTable.value6,
                     spellTable.value7, spellTable.value8, spellTable.value9,
                     spellTable.value10, spellTable.value11, spellTable.value12}
        }
    end
end

--- Cache aura result
--- @param cacheKey string The cache key
--- @param result AuraData|boolean The result to cache (AuraData table or false)
function EnhancedAuraHandlers:CacheResult(cacheKey, result)
    -- Safety check: ensure cache duration is valid
    if not self.AURA_CACHE_TIME or self.AURA_CACHE_TIME <= 0 then
        self:Warn("CacheResult: Invalid cache duration (%.2f), using default 0.1s",
            tostring(self.AURA_CACHE_TIME))
        self.AURA_CACHE_TIME = CONSTANTS.AURA_CACHE_TIME
    end

    -- Reuse existing cache wrapper or create new one (memory optimization)
    local wrapper = self.auraCache[cacheKey]
    if not wrapper then
        wrapper = {}
        self.auraCache[cacheKey] = wrapper
    end
    wrapper.data = result
    wrapper.nextUpdate = GetTime() + self.AURA_CACHE_TIME
end

--- Check if aura matches any of the provided spell inputs
--- OPTIMIZATION: Inlined for performance - no table creation
--- @param aura table The aura to check (expects {name=..., spellId=...})
--- @param ... number|string Variable arguments: spell IDs/names to check
--- @return boolean matches True if aura matches any spell input
function EnhancedAuraHandlers:MatchesAnySpell(aura, ...)
    if not aura then return false end
    local auraName = aura.name
    local auraSpellId = aura.spellId
    for i = 1, select('#', ...) do
        local input = select(i, ...)
        if input and (input == auraName or input == auraSpellId) then
            return true
        end
    end
    return false
end


--- Get group members iterator (delegates to StateManager group API).
--- RESPECTS GROUP/RAID OVERRIDES for testing purposes.
--- @return function iterator Iterator function for group members
--- @return table members Table of group member unit IDs
--- @return number index Starting index for iteration
function EnhancedAuraHandlers:GetGroupMembers()
    local members = StateManager:GetGroupMemberUnits()
    return ipairs(members)
end

-- ============================ DEBUG FUNCTIONS ============================

--- Get cache statistics
--- @return table stats Cache hit/miss statistics
function EnhancedAuraHandlers:GetCacheStats()
    local total = self.cacheHits + self.cacheMisses
    local hitRate = total > 0 and (self.cacheHits / total * 100) or 0

    return {
        hits = self.cacheHits,
        misses = self.cacheMisses,
        hitRate = hitRate
    }
end

--- Clear aura cache
function EnhancedAuraHandlers:ClearCache()
    self.auraCache = {}
    self.cacheHits = 0
    self.cacheMisses = 0
    self:Debug("Aura cache cleared")
end

-- ============================ SPELL ID RESOLUTION ============================

--- Centralized spell ID resolution for casting
--- @param spellId number The original spell ID
--- @return number The resolved spell ID for casting
function EnhancedAuraHandlers:ResolveSpellIdForCasting(spellId)
    if not spellId then return spellId end

    -- Storm, Earth and Fire mapping (138228 -> 137639)
    if spellId == 138228 then
        return 137639
    end

    -- Savage Roar mapping (52610 -> 127538) in MoP
    -- 52610 is unglyphed, 127538 is glyphed
    if ns.Version:IsMoP() and spellId == 52610 then
        return 127538
    end

    return spellId
end

-- ============================ MODULE EXPOSURE ============================

-- Expose functions on NAG namespace for easy access

--- Core function that handles all aura detection logic with integrated smart detection.
--- @function NAG:UnitAura
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (e.g., "HELPFUL", "HARMFUL", "HARMFUL|PLAYER")
--- @param exactIdMatch boolean|nil If true, forces exact spell ID matching and skips name-based matching
--- @return AuraData|boolean AuraData table if found, false if not found
--- @usage local aura = NAG:UnitAura("player", 12345, "HELPFUL")
--- @usage if aura then local name, icon = aura.name, aura.icon end
NAG.UnitAura = function(self, unit, spellId, filter, exactIdMatch)
    if not unit or type(unit) ~= "string" then
        error("NAG:UnitAura() - 'unit' parameter is required and must be a string", 2)
    end
    if not spellId then
        error("NAG:UnitAura() - 'spellId' parameter is required", 2)
    end
    return EnhancedAuraHandlers:UnitAura(unit, spellId, filter, exactIdMatch)
end

--- Check for buffs on a unit.
--- @function NAG:UnitBuff
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HELPFUL")
--- @param exactIdMatch boolean|nil If true, forces exact spell ID matching and skips name-based matching
--- @return AuraData|boolean AuraData table if found, false if not found
--- @usage local aura = NAG:UnitBuff("player", 12345)
NAG.UnitBuff = function(self, unit, spellId, filter, exactIdMatch)
    if not unit or type(unit) ~= "string" then
        error("NAG:UnitBuff() - 'unit' parameter is required and must be a string", 2)
    end
    if not spellId then
        error("NAG:UnitBuff() - 'spellId' parameter is required", 2)
    end
    return EnhancedAuraHandlers:UnitBuff(unit, spellId, filter, exactIdMatch)
end

--- Check for debuffs on a unit.
--- @function NAG:UnitDebuff
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HARMFUL")
--- @param exactIdMatch boolean|nil If true, forces exact spell ID matching and skips name-based matching
--- @return AuraData|boolean AuraData table if found, false if not found
--- @usage local aura = NAG:UnitDebuff("target", 12345)
NAG.UnitDebuff = function(self, unit, spellId, filter, exactIdMatch)
    if not unit or type(unit) ~= "string" then
        error("NAG:UnitDebuff() - 'unit' parameter is required and must be a string", 2)
    end
    if not spellId then
        error("NAG:UnitDebuff() - 'spellId' parameter is required", 2)
    end
    return EnhancedAuraHandlers:UnitDebuff(unit, spellId, filter, exactIdMatch)
end

--- Check for any debuff on a unit (global scope).
--- @function NAG:UnitDebuffGlobal
--- @param unit string The unit to check
--- @param spellId number|string The spell ID or name to check
--- @return AuraData|boolean AuraData table if found, false if not found
--- @usage local aura = NAG:UnitDebuffGlobal("target", 12345)
NAG.UnitDebuffGlobal = function(self, unit, spellId)
    if not unit or type(unit) ~= "string" then
        error("NAG:UnitDebuffGlobal() - 'unit' parameter is required and must be a string", 2)
    end
    if not spellId then
        error("NAG:UnitDebuffGlobal() - 'spellId' parameter is required", 2)
    end
    return EnhancedAuraHandlers:UnitDebuffGlobal(unit, spellId)
end


--- Check for multiple spells on a unit.
--- @function NAG:UnitAuraMulti
--- @param unit string The unit to check
--- @param ... number|string|boolean Variable arguments: spell IDs/names to check, and optional filter parameter
--- @return AuraData|boolean AuraData table if found, false if not found
--- @usage local aura = NAG:UnitAuraMulti("player", 12345, 67890, "HELPFUL")
NAG.UnitAuraMulti = function(self, unit, ...)
    return EnhancedAuraHandlers:UnitAuraMulti(unit, ...)
end

--- Check for multiple buffs on a unit.
--- @function NAG:UnitBuffMulti
--- @param unit string The unit to check
--- @param ... number|string|boolean Variable arguments: spell IDs/names to check, and optional filter parameter
--- @return AuraData|boolean AuraData table if found, false if not found
--- @usage local aura = NAG:UnitBuffMulti("player", 12345, 67890)
NAG.UnitBuffMulti = function(self, unit, ...)
    return EnhancedAuraHandlers:UnitBuffMulti(unit, ...)
end

--- Check for multiple debuffs on a unit.
--- @function NAG:UnitDebuffMulti
--- @param unit string The unit to check
--- @param ... number|string|boolean Variable arguments: spell IDs/names to check, and optional filter parameter
--- @return AuraData|boolean AuraData table if found, false if not found
--- @usage local aura = NAG:UnitDebuffMulti("target", 12345, 67890)
NAG.UnitDebuffMulti = function(self, unit, ...)
    return EnhancedAuraHandlers:UnitDebuffMulti(unit, ...)
end

--- Check if anyone in raid has an aura.
--- @function NAG:RaidUnitAura
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HELPFUL")
--- @return boolean hasAura True if anyone in raid has the aura
--- @usage local hasAura = NAG:RaidUnitAura(12345, "HELPFUL")
NAG.RaidUnitAura = function(self, spellId, filter)
    return EnhancedAuraHandlers:RaidUnitAura(spellId, filter)
end

--- Check if anyone in raid has a buff.
--- @function NAG:RaidUnitBuff
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HELPFUL")
--- @return boolean hasBuff True if anyone in raid has the buff
--- @usage local hasBuff = NAG:RaidUnitBuff(12345)
NAG.RaidUnitBuff = function(self, spellId, filter)
    return EnhancedAuraHandlers:RaidUnitBuff(spellId, filter)
end

--- Check if anyone in raid has a debuff.
--- @function NAG:RaidUnitDebuff
--- @param spellId number|string The spell ID or name to check
--- @param filter string|nil Optional filter (defaults to "HARMFUL")
--- @return boolean hasDebuff True if anyone in raid has the debuff
--- @usage local hasDebuff = NAG:RaidUnitDebuff(12345)
NAG.RaidUnitDebuff = function(self, spellId, filter)
    return EnhancedAuraHandlers:RaidUnitDebuff(spellId, filter)
end

--- Check if anyone in raid has the player's buff.
--- @function NAG:RaidUnitBuffPlayer
--- @param spellId number|string The spell ID or name to check
--- @return boolean hasBuff True if anyone in raid has the player's buff
--- @usage local hasBuff = NAG:RaidUnitBuffPlayer(12345)
NAG.RaidUnitBuffPlayer = function(self, spellId)
    return EnhancedAuraHandlers:RaidUnitBuffPlayer(spellId)
end

--- Check if anyone in raid has the player's debuff.
--- @function NAG:RaidUnitDebuffPlayer
--- @param spellId number|string The spell ID or name to check
--- @return boolean hasDebuff True if anyone in raid has the player's debuff
--- @usage local hasDebuff = NAG:RaidUnitDebuffPlayer(12345)
NAG.RaidUnitDebuffPlayer = function(self, spellId)
    return EnhancedAuraHandlers:RaidUnitDebuffPlayer(spellId)
end

--- Counts unique group/raid members who have a player-cast aura active.
--- @function NAG:CountRaidMembersWithAura
--- @param spellId number|string The spell ID or name of the aura to count
--- @param filter string|nil Optional filter (defaults to "HELPFUL|PLAYER" for player-cast buffs)
--- @return number count The count of unique party/raid members with the aura (1 if solo)
--- @usage local count = NAG:CountRaidMembersWithAura(12345) -- Count player-cast buffs
--- @usage local count = NAG:CountRaidMembersWithAura(12345, "HARMFUL|PLAYER") -- Count player-cast debuffs
NAG.CountRaidMembersWithAura = function(self, spellId, filter)
    return EnhancedAuraHandlers:CountRaidMembersWithAura(spellId, filter)
end

-- Spell mapping functions

--- Resolves a spell ID through the unified mapping system (legacy compatibility).
--- @function NAG:ResolveSpellId
--- @param spellId number|string The spell ID or name to resolve
--- @param mappingType string|nil Optional mapping type filter
--- @return number|string|nil Resolved spell ID or original spell name
--- @usage local resolvedId = NAG:ResolveSpellId(138228) -- Returns 137639
NAG.ResolveSpellId = function(self, spellId, mappingType)
    return EnhancedAuraHandlers:ResolveSpellId(spellId, mappingType)
end

--- Gets the maximum stacks for a spell ID.
--- @function NAG:GetMaxStacks
--- @param spellId number The spell ID to check
--- @return number The maximum stacks for the spell, or 1 if not stackable
--- @usage local maxStacks = NAG:GetMaxStacks(113746) -- Returns 3 for Sunder Armor
NAG.GetMaxStacks = function(self, spellId)
    return EnhancedAuraHandlers:GetMaxStacks(spellId)
end

--- Gets the priority for a spell ID in a debuff type.
--- @function NAG:GetSpellPriority
--- @param spellId number The spell ID to check
--- @param debuffType number The debuff type
--- @return number The priority value, or 0 if not found
--- @usage local priority = NAG:GetSpellPriority(8647, Types:GetType("DebuffType").ARMOR) -- Returns 100
NAG.GetSpellPriority = function(self, spellId, debuffType)
    return EnhancedAuraHandlers:GetSpellPriority(spellId, debuffType)
end

--- Checks if one spell has higher priority than another in a debuff type.
--- @function NAG:HasHigherPriority
--- @param competingSpellId number The competing spell ID
--- @param originalSpellId number The original spell ID
--- @param debuffType number The debuff type
--- @return boolean True if competing spell has higher priority
--- @usage local hasHigher = NAG:HasHigherPriority(8647, 7386, Types:GetType("DebuffType").ARMOR) -- Returns true
NAG.HasHigherPriority = function(self, competingSpellId, originalSpellId, debuffType)
    return EnhancedAuraHandlers:HasHigherPriority(competingSpellId, originalSpellId, debuffType)
end

--- Adds a spell mapping to the unified mapping system.
--- @function NAG:AddSpellMapping
--- @param spellId number The spell ID to map
--- @param mappedId number The mapped spell ID
--- @param mappingType string The type of mapping ("direct", "items")
--- @return boolean success True if mapping was added successfully
--- @usage NAG:AddSpellMapping(12345, 54321, "direct")
NAG.AddSpellMapping = function(self, spellId, mappedId, mappingType)
    return EnhancedAuraHandlers:AddSpellMapping(spellId, mappedId, mappingType)
end

--- Removes a spell mapping from the unified mapping system.
--- @function NAG:RemoveSpellMapping
--- @param spellId number The spell ID to remove
--- @param mappingType string The type of mapping
--- @return boolean success True if mapping was removed successfully
--- @usage NAG:RemoveSpellMapping(12345, "direct")
NAG.RemoveSpellMapping = function(self, spellId, mappingType)
    return EnhancedAuraHandlers:RemoveSpellMapping(spellId, mappingType)
end

-- Multi-mapping functions

--- Adds a multi-mapping (one spell ID maps to multiple auras).
--- @function NAG:AddMultiMapping
--- @param spellId number The spell ID to map
--- @param auras table Array of aura IDs to check
--- @param mappingType string Type of mapping ("any", "all", "none")
--- @return boolean success True if mapping was added successfully
--- @usage NAG:AddMultiMapping(80353, {80353, 2825, 32182}, "any") -- Bloodlust variants
NAG.AddMultiMapping = function(self, spellId, auras, mappingType)
    return EnhancedAuraHandlers:AddMultiMapping(spellId, auras, mappingType)
end

--- Adds a conditional mapping (complex logic with OR/AND/NOT).
--- @function NAG:AddConditionalMapping
--- @param spellId number The spell ID to map
--- @param conditions table Array of condition objects
--- @param logic string Logic type ("or", "and", "not")
--- @return boolean success True if mapping was added successfully
--- @usage NAG:AddConditionalMapping(99999, {{aura = 12346, required = true}}, "or")
NAG.AddConditionalMapping = function(self, spellId, conditions, logic)
    return EnhancedAuraHandlers:AddConditionalMapping(spellId, conditions, logic)
end

--- Adds a custom mapping (custom handler for special cases).
--- @function NAG:AddCustomMapping
--- @param spellId number The spell ID to map
--- @param handler string The handler name ("totem", "vengeance")
--- @param params table|nil Optional parameters for the handler
--- @return boolean success True if mapping was added successfully
--- @usage NAG:AddCustomMapping(88747, "totem", {})
NAG.AddCustomMapping = function(self, spellId, handler, params)
    return EnhancedAuraHandlers:AddCustomMapping(spellId, handler, params)
end

--- Removes a multi-mapping from the unified mapping system.
--- @function NAG:RemoveMultiMapping
--- @param spellId number The spell ID to remove
--- @param mappingType string The type of mapping to remove ("multi", "conditional", "custom")
--- @return boolean success True if mapping was removed successfully
--- @usage NAG:RemoveMultiMapping(80353, "multi")
NAG.RemoveMultiMapping = function(self, spellId, mappingType)
    return EnhancedAuraHandlers:RemoveMultiMapping(spellId, mappingType)
end

--- Gets all multi-mappings of a specific type.
--- @function NAG:GetMultiMappings
--- @param mappingType string|nil The type of mappings to get ("multi", "conditional", "custom", or nil for all)
--- @return table mappings Table of mappings
--- @usage local mappings = NAG:GetMultiMappings("multi")
NAG.GetMultiMappings = function(self, mappingType)
    return EnhancedAuraHandlers:GetMultiMappings(mappingType)
end

--- Clear all multi-mappings of a specific type.
--- @function NAG:ClearMultiMappings
--- @param mappingType string|nil The type of mappings to clear ("multi", "conditional", "custom", or nil for all)
--- @return boolean success True if mappings were cleared successfully
--- @usage NAG:ClearMultiMappings("multi")
NAG.ClearMultiMappings = function(self, mappingType)
    return EnhancedAuraHandlers:ClearMultiMappings(mappingType)
end

-- Custom damage handler functions

--- Checks if a spell ID has a custom damage handler.
--- @function NAG:HasCustomDamageHandler
--- @param spellId number The spell ID to check
--- @return boolean True if the spell has a custom damage handler
--- @usage local hasCustom = NAG:HasCustomDamageHandler(12846) -- Returns true for Ignite
NAG.HasCustomDamageHandler = function(self, spellId)
    return EnhancedAuraHandlers:HasCustomDamageHandler(spellId)
end

--- Gets custom damage for a spell ID using the appropriate handler.
--- @function NAG:GetCustomDamage
--- @param spellId number The spell ID to check
--- @param unit string The unit to check
--- @return number The damage value, or 0 if no custom handler or no damage
--- @usage local damage = NAG:GetCustomDamage(12846, "target") -- Returns Ignite damage
NAG.GetCustomDamage = function(self, spellId, unit)
    return EnhancedAuraHandlers:GetCustomDamage(spellId, unit)
end

--- Adds a custom damage handler for a spell ID.
--- @function NAG:AddCustomDamageHandler
--- @param spellId number The spell ID to add
--- @param handlerName string The handler name
--- @return boolean success True if handler was added successfully
--- @usage NAG:AddCustomDamageHandler(12345, "my_handler")
NAG.AddCustomDamageHandler = function(self, spellId, handlerName)
    return EnhancedAuraHandlers:AddCustomDamageHandler(spellId, handlerName)
end

--- Removes a custom damage handler for a spell ID.
--- @function NAG:RemoveCustomDamageHandler
--- @param spellId number The spell ID to remove
--- @return boolean success True if handler was removed successfully
--- @usage NAG:RemoveCustomDamageHandler(12345)
NAG.RemoveCustomDamageHandler = function(self, spellId)
    return EnhancedAuraHandlers:RemoveCustomDamageHandler(spellId)
end


--- Centralized spell ID resolution for casting.
--- @function NAG:ResolveSpellIdForCasting
--- @param spellId number The original spell ID
--- @return number The resolved spell ID for casting
--- @usage local resolvedId = NAG:ResolveSpellIdForCasting(138228) -- Returns 137639
NAG.ResolveSpellIdForCasting = function(self, spellId)
    return EnhancedAuraHandlers:ResolveSpellIdForCasting(spellId)
end

-- Expose module on namespace for performance
ns.EnhancedAuraHandlers = EnhancedAuraHandlers
