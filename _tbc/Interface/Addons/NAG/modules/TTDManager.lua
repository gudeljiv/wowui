--- @module "NAG.TTDManager"
--- Manages time-to-death (TTD) predictions for units using health sampling and linear regression analysis.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local L = ns.AceLocale:GetLocale("NAG")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
local StateManager

--- @type SpecCompat
local SpecCompat

--- @type OptionsFactory
--- @type TimerManager
local OptionsFactory, TimerManager

--- @type CacheRefreshManager
local CacheRefreshManager

-- Utils (memory optimization)
local TablePool = ns.TablePool
local TableUtils = ns.TableUtils
-- Libraries
local RC = ns.RC

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitName = _G.UnitName
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateFrame = _G.CreateFrame
local CheckInteractDistance = _G.CheckInteractDistance
local format = string.format -- WoW's optimized version if available
local min = math.min
local max = math.max

local strfind = strfind
local strlower = strlower
local strsplit = strsplit
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

local sort = table.sort
local concat = table.concat

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Constants
local MIN_SAMPLE_INTERVAL = 0.1
local HISTORY_COUNT = 100
local HISTORY_TIME = 10

local TRAINING_DUMMY_AURAS = {
    [61573] = true, -- Alliance Banner Aura
    [61574] = true  -- Horde Banner Aura
}

-- Class and specIndex-based ranged detection table
-- Maps class name + specIndex (1-4) to whether the spec is considered ranged
-- This preserves the old hardcoded spec ID logic (Mage 62/63/64, Hunter 253/254/255, etc.)
-- Based on old spec IDs: Mage (62/63/64), Hunter (253/254/255), Priest (256/257/258),
-- Warlock (265/266/267), Shaman Elemental/Restoration (262/264), Druid Balance/Restoration (102/105)
local CLASS_SPEC_RANGED_TABLE = {
    -- MAGE specs - all are ranged
    MAGE = {
        [1] = true,    -- Arcane (old specID 62)
        [2] = true,    -- Fire (old specID 63)
        [3] = true,    -- Frost (old specID 64)
    },
    -- WARRIOR specs - none are ranged
    WARRIOR = {},
    -- PALADIN specs - none are ranged
    PALADIN = {},
    -- HUNTER specs - all are ranged
    HUNTER = {
        [1] = true,    -- Beast Mastery (old specID 253)
        [2] = true,    -- Marksmanship (old specID 254)
        [3] = true,    -- Survival (old specID 255)
    },
    -- ROGUE specs - none are ranged
    ROGUE = {},
    -- PRIEST specs - all are ranged
    PRIEST = {
        [1] = true,    -- Discipline (old specID 256)
        [2] = true,    -- Holy (old specID 257)
        [3] = true,    -- Shadow (old specID 258)
    },
    -- DEATHKNIGHT specs - none are ranged
    DEATHKNIGHT = {},
    -- SHAMAN specs - Elemental and Restoration are ranged
    SHAMAN = {
        [1] = true,    -- Elemental (old specID 262)
        [3] = true,    -- Restoration (old specID 264)
        -- Enhancement (specIndex 2, old specID 263) is NOT ranged
    },
    -- WARLOCK specs - all are ranged
    WARLOCK = {
        [1] = true,    -- Affliction (old specID 265)
        [2] = true,    -- Demonology (old specID 266)
        [3] = true,    -- Destruction (old specID 267)
    },
    -- MONK specs - none are ranged
    MONK = {},
    -- DRUID specs - Balance and Restoration are ranged
    DRUID = {
        [1] = true,    -- Balance (old specID 102)
        [4] = true,    -- Restoration (old specID 105)
        -- Feral (specIndex 2) and Guardian (specIndex 3) are NOT ranged
    },
}

-- Class and specIndex-based range defaults table
-- Maps class name + specIndex (1-4) to default melee/ranged ranges
-- This replaces the old hardcoded spec ID values with a simpler table-based approach
local CLASS_SPEC_RANGE_DEFAULTS = {
    -- MAGE specs (Arcane, Fire, Frost)
    MAGE = {
        [1] = { melee = 5, ranged = 40 },    -- Arcane
        [2] = { melee = 5, ranged = 40 },    -- Fire
        [3] = { melee = 5, ranged = 40 },    -- Frost
    },
    -- WARRIOR specs (Arms, Fury, Protection)
    WARRIOR = {
        [1] = { melee = 5, ranged = 30 },    -- Arms
        [2] = { melee = 5, ranged = 30 },    -- Fury
        [3] = { melee = 5, ranged = 30 },    -- Protection
    },
    -- PALADIN specs (Holy, Protection, Retribution)
    PALADIN = {
        [1] = { melee = 5, ranged = 40 },    -- Holy
        [2] = { melee = 10, ranged = 30 },   -- Protection
        [3] = { melee = 10, ranged = 30 },   -- Retribution
    },
    -- HUNTER specs (Beast Mastery, Marksmanship, Survival)
    HUNTER = {
        [1] = { melee = 5, ranged = 40 },    -- Beast Mastery
        [2] = { melee = 5, ranged = 40 },    -- Marksmanship
        [3] = { melee = 5, ranged = 40 },    -- Survival
    },
    -- ROGUE specs (Assassination, Combat, Subtlety)
    ROGUE = {
        [1] = { melee = 5, ranged = 30 },    -- Assassination
        [2] = { melee = 5, ranged = 30 },    -- Combat
        [3] = { melee = 5, ranged = 30 },    -- Subtlety
    },
    -- PRIEST specs (Discipline, Holy, Shadow)
    PRIEST = {
        [1] = { melee = 5, ranged = 40 },    -- Discipline
        [2] = { melee = 5, ranged = 40 },    -- Holy
        [3] = { melee = 5, ranged = 40 },    -- Shadow
    },
    -- DEATHKNIGHT specs (Blood, Frost, Unholy)
    DEATHKNIGHT = {
        [1] = { melee = 5, ranged = 30 },    -- Blood
        [2] = { melee = 5, ranged = 30 },    -- Frost
        [3] = { melee = 5, ranged = 30 },    -- Unholy
    },
    -- SHAMAN specs (Elemental, Enhancement, Restoration)
    SHAMAN = {
        [1] = { melee = 5, ranged = 30 },    -- Elemental
        [2] = { melee = 10, ranged = 30 },   -- Enhancement
        [3] = { melee = 5, ranged = 40 },    -- Restoration
    },
    -- WARLOCK specs (Affliction, Demonology, Destruction)
    WARLOCK = {
        [1] = { melee = 5, ranged = 40 },    -- Affliction
        [2] = { melee = 5, ranged = 40 },    -- Demonology
        [3] = { melee = 5, ranged = 40 },    -- Destruction
    },
    -- MONK specs (Brewmaster, Windwalker, Mistweaver)
    MONK = {
        [1] = { melee = 5, ranged = 30 },    -- Brewmaster
        [2] = { melee = 5, ranged = 30 },    -- Windwalker
        [3] = { melee = 5, ranged = 30 },    -- Mistweaver
    },
    -- DRUID specs (Balance, Feral, Guardian, Restoration)
    DRUID = {
        [1] = { melee = 5, ranged = 30 },    -- Balance
        [2] = { melee = 5, ranged = 30 },    -- Feral
        [3] = { melee = 5, ranged = 30 },    -- Guardian
        [4] = { melee = 5, ranged = 30 },    -- Restoration
    },
}

--- Build specRangeSettings defaults from CLASS_SPEC_RANGE_DEFAULTS table
--- This creates a specIndex-based lookup structure for all classes
--- @return table specRangeSettings defaults structure
local function BuildSpecRangeDefaults()
    local defaults = {
        -- Class-level defaults (specIndex 0) - used when no spec is selected
        [0] = { melee = 5, ranged = 30 },    -- Fallback (overridden by IsRangedClass() logic)
    }

    -- Build defaults for all specIndex values (1-4) across all classes
    -- If a class doesn't have a specific specIndex, use general defaults
    for specIndex = 1, 4 do
        local meleeDefault = 5
        local rangedDefault = 30

        -- Use the most common values as defaults, but class-specific lookups will override
        defaults[specIndex] = { melee = meleeDefault, ranged = rangedDefault }
    end

    return defaults
end

-- Module defaults
local defaults = {
    global = {
        -- Range calculation method
        useInteractionDistance = false, -- Use CheckInteractDistance instead of LibRangeCheck

        -- TTD update interval (TTDManager owns this setting and its timer)
        intervals = {
            TTD_UPDATE = 0.75
        },

        -- Encounter timer settings
        enableEncounterTimer = false,
        encounterDuration = nil,

        -- Melee fallback settings
        meleeFallback = true,

        -- Target count override settings
        targetCountOverride = nil, -- Persistent target count override (nil = disabled)

        -- Range settings for all classes and specs (system defaults)
        -- Uses specIndex keys (1, 2, 3, 4)
        -- Note: Class-specific defaults are stored in CLASS_SPEC_RANGE_DEFAULTS and
        -- can be looked up via GetClassSpecRangeDefaults() helper function
        specRangeSettings = BuildSpecRangeDefaults()
    }
}

--- @class TTDManager: CoreModule
local TTDManager = NAG:CreateModule("TTDManager", defaults, {
    defaultState = {
        units = {},             -- TTD data per unit
        cache = {},             -- Cache for recycling tables
        mobCount = 0,           -- Current number of tracked mobs
        meleeMobCount = 0,      -- Current number of melee-range mobs
        checkedUnits = {},      -- Temporary table for tracking checked units
        activeTargetGUID = nil, -- Track currently active target GUID
        boostActive = false,    -- Adaptive sampling boost mode active
        boostUntil = 0,         -- Time until which boost mode should remain active
        boostGuid = nil,        -- GUID for which boost mode is currently active

        -- Smart caching system
        calculationCache = {},   -- Cache for TTD calculation results
        lastCalculationTime = 0, -- Last time any calculation was performed
        lastRefreshTime = 0,     -- Last time RefreshTTD was run (prevents double execution)
        userInterval = 0.75      -- User's TTD_UPDATE interval (default 0.75s)
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.ANALYZERS
    },

    -- Options composers for dynamic options integration
    optionsComposers = {
        ["class"] = true -- Calls TTDManager:class(options, context)
    },

    -- Automatic slash command registration
    slashCommands = {
        -- Main AoE command (user-facing, common command)
        ["aoe"] = {
            handler = "HandleAoECommand",
            help = "Toggle single target mode or set target count override. Usage: /nag aoe [toggle|number|off|reset|status] - Use 'save' to persist",
            aliases = {"nagaoe"},
            root = "nag",  -- Register as /nag aoe (user-facing command)
            category = "Combat"
        },
        -- NEW HIERARCHICAL FORMAT:
        ["ttd_aoe"] = {
            handler = "HandleAoECommand",
            help = "Toggle single target mode or set target count override. Usage: /nagdebug ttd aoe [toggle|number|off|reset|status] - Use 'save' to persist",
            root = "nagdebug",
            path = {"ttd", "aoe"},
            category = "Combat"
        },
        ["ttd_debug"] = {
            handler = "ShowDebugFrame",
            help = "Show TTDManager debug frame with TTD state and sample data",
            root = "nagdebug",
            path = {"ttd", "debug"},
            category = "Debug"
        },
        ["ttd_stats"] = {
            handler = "PrintCacheStats",
            help = "Print TTD cache statistics (units, samples, cache size)",
            root = "nagdebug",
            path = {"ttd", "stats"},
            category = "Data"
        }
    }
})
local module = TTDManager
ns.TTDManager = TTDManager

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
function TTDManager:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    StateManager = NAG:GetModule("StateManager")
    SpecCompat = NAG:GetModule("SpecCompat")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = NAG:GetModule("TimerManager")
    CacheRefreshManager = NAG:GetModule("CacheRefreshManager")

    -- Options composers are now handled automatically by the mixin system
end

-- ============================ CACHE REFRESH SCHEDULING ============================

--- Request a TTD refresh via CacheRefreshManager (deduped, budgeted).
--- Callers should continue using current state values while refresh is in-flight.
--- @param source string|nil
--- @param minIntervalSec number|nil Optional override interval for refresh throttling (e.g. boost mode)
function TTDManager:RequestTTDRefresh(source, minIntervalSec)
    CacheRefreshManager = CacheRefreshManager or NAG:GetModule("CacheRefreshManager", true)
    if not CacheRefreshManager then
        return false
    end

    local interval = minIntervalSec or (self.state and self.state.userInterval) or 0.75
    local pr = CacheRefreshManager.PRIORITY and CacheRefreshManager.PRIORITY.COMBAT_HIGH or 2
    return CacheRefreshManager:RequestRefresh("ttd:refresh", {
        priority = pr,
        minIntervalSec = interval,
    }, function()
        self:RefreshTTD()
        self.state.lastRefreshTime = GetTime()
        return true
    end)
end

function TTDManager:ModuleEnable()

    -- ============================ MODULE INITIALIZATION ============================

    -- Initialize settings now that the addon is fully loaded
    -- TTDManager owns its own timer and interval setting
    local userInterval = self.db.global.intervals.TTD_UPDATE
    self.state.userInterval = userInterval or 0.75 -- Fallback to default if setting is nil
    if self.debug then
        self:Debug("TTDManager: Initialized userInterval to %.3f seconds", self.state.userInterval)
    end


    -- Re-enable the periodic timer for health sample collection
    -- This is necessary for accurate TTD calculations
    TimerManager:Create(
        TimerManager.Categories.CORE,
        "TTDRefresh",
        function()
            -- Request refresh; do not compute directly inside timer to avoid sync spikes.
            self:RequestTTDRefresh("timer")
        end,
        self.state.userInterval,
        true
    )

    -- Kick one initial refresh request so we have data quickly without forcing it inline.
    self:RequestTTDRefresh("enable")

    -- Register events
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled")
    self:RegisterEvent("PLAYER_DEAD", "OnPlayerDead")
    self:RegisterEvent("UNIT_HEALTH", "OnUnitHealth")

    -- Slash commands are now handled via zero-boilerplate slashCommands table

    -- Initialize temporary override state
    self.tempForceSingleTarget = false

    -- Notify user if persistent target count override is active
    if self.db.global.targetCountOverride then
        C_Timer.After(2, function()
            NAG:Print(string.format("|cffff9900Persistent Target Count Override Active: %d targets|r", self.db.global.targetCountOverride))
            NAG:Print("|cffff9900Use '/nagaoe reset' to clear this setting|r")
        end)
    end
end

function TTDManager:ModuleDisable()
    TimerManager:Cancel(TimerManager.Categories.CORE, "TTDRefresh")
    -- Unregister events
    self:UnregisterEvent("PLAYER_TARGET_CHANGED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    self:UnregisterEvent("PLAYER_DEAD")
    self:UnregisterEvent("UNIT_HEALTH")
    self:ResetTTD()
end

-- ~~~~~~~~~~ OPTIONS COMPOSERS ~~~~~~~~~~

--- Options composer for class-specific options integration
--- @param options table The options table to modify
--- @param context table The context object
--- @return table The modified options table
function TTDManager:class(options, context)
    -- Navigate to the class-specific section and add range settings options
    if options.args and options.args[NAG.CLASS_FILENAME] and options.args[NAG.CLASS_FILENAME].args then
        options.args[NAG.CLASS_FILENAME].args.rangeSettings = {
            type = "group",
            inline = true,
            order = 20,
            name = L["rangeSettings"] or "Range Settings",
            desc = L["rangeSettingsDesc"] or "Configure combat ranges for your current specialization",
            args = {
                meleeRange = OptionsFactory:CreateRange(L["meleeRange"] or "Melee Range", L["meleeRangeDesc"] or "Range for melee abilities and close combat (yards)",
                    function()
                        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

                        local specRangeSettings = self:GetSetting("global", "specRangeSettings")
                        local specRanges = specRangeSettings[specIndex]
                        return specRanges and specRanges.melee or 5
                    end,
                    function(info, value)
                        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

                        local specRangeSettings = self:GetSetting("global", "specRangeSettings")
                        if not specRangeSettings[specIndex] then
                            specRangeSettings[specIndex] = {}
                        end
                        specRangeSettings[specIndex].melee = value
                        self:SetSetting("global", "specRangeSettings", specRangeSettings)
                    end,
                    {
                        order = 1,
                        min = 1,
                        max = 15,
                        step = 1
                    }
                ),
                rangedRange = OptionsFactory:CreateRange(L["rangedRange"] or "Ranged Range", L["rangedRangeDesc"] or "Range for ranged abilities and distance calculations (yards)",
                    function()
                        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

                        local specRangeSettings = self:GetSetting("global", "specRangeSettings")
                        local specRanges = specRangeSettings[specIndex]
                        return specRanges and specRanges.ranged or 30
                    end,
                    function(info, value)
                        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

                        local specRangeSettings = self:GetSetting("global", "specRangeSettings")
                        if not specRangeSettings[specIndex] then
                            specRangeSettings[specIndex] = {}
                        end
                        specRangeSettings[specIndex].ranged = value
                        self:SetSetting("global", "specRangeSettings", specRangeSettings)
                    end,
                    {
                        order = 2,
                        min = 10,
                        max = 50,
                        step = 1
                    }
                ),
                useInteractionDistance = OptionsFactory:CreateToggle(L["useInteractionDistance"] or "Use Interaction Distance", L["useInteractionDistanceDesc"] or "Use CheckInteractDistance instead of LibRangeCheck for range calculations. This can be more reliable for training dummies but less precise for other units.",
                    function()
                        return self:GetSetting("global", "useInteractionDistance")
                    end,
                    function(info, value)
                        self:SetSetting("global", "useInteractionDistance", value)
                        self:ClearCalculationCache() -- Clear cache when method changes
                    end,
                    { order = 3 }
                ),
                meleeFallback = OptionsFactory:CreateToggle(L["meleeFallback"] or "Melee Fallback to Ranged", L["meleeFallbackDesc"] or "When enabled, melee classes will count enemies at ranged distance if no enemies are found in melee range. When disabled, only enemies in melee range are counted.",
                    function()
                        return self:GetSetting("global", "meleeFallback")
                    end,
                    function(info, value)
                        self:SetSetting("global", "meleeFallback", value)
                        self:ClearCalculationCache() -- Clear cache when setting changes
                    end,
                    { order = 4 }
                ),
                resetRanges = OptionsFactory:CreateExecute(L["resetRanges"] or "Reset to Defaults", L["resetRangesDesc"] or "Reset range settings to default values for your current specialization",
                    function()
                        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

                        local specRangeSettings = self:GetSetting("global", "specRangeSettings")
                        specRangeSettings[specIndex] = nil
                        self:SetSetting("global", "specRangeSettings", specRangeSettings)
                    end,
                    { order = 5 }
                ),
            },
        }
    end

    return options
end

-- ~~~~~~~~~~ SMART CACHING HELPERS ~~~~~~~~~~

--- Check if a cached calculation is still valid
--- @param cacheKey string The cache key to check
--- @return boolean True if cache is valid, false if recalculation needed
function TTDManager:IsCacheValid(cacheKey)
    local cache = self.state.calculationCache[cacheKey]
    if not cache then return false end

    -- Safety check: ensure userInterval is valid
    if not self.state.userInterval or type(self.state.userInterval) ~= "number" then
        if self.debug then
            self:Debug("TTDManager:IsCacheValid - userInterval is invalid, using fallback")
        end
        self.state.userInterval = 0.75 -- Fallback to default
    end

    -- Invalidate if a newer health sample exists than when the cache was stored
    local unitData = cache.guid and self.state.units[cache.guid] or nil
    local currentLastSampleStamp
    if unitData then
        if unitData.isSimulated and unitData.simulatedData then
            currentLastSampleStamp = GetTime()
        else
            local latestSampleTime = (unitData.samples and unitData.samples[1] and unitData.samples[1].time) or 0
            currentLastSampleStamp = (unitData.startTime or 0) + latestSampleTime
        end
    else
        -- No unit data available; treat as changing to force recompute when appropriate
        currentLastSampleStamp = GetTime()
    end
    if cache.lastSampleStamp and currentLastSampleStamp and cache.lastSampleStamp ~= currentLastSampleStamp then
        return false
    end

    local currentTime = GetTime()
    local timeSinceCalculation = currentTime - cache.timestamp

    -- Check if user interval has passed
    if timeSinceCalculation < self.state.userInterval then
        return true
    end

    -- Check if health data is stale (use user interval as staleness threshold)
    unitData = self.state.units[cache.guid]
    if unitData and unitData.samples and #unitData.samples > 0 then
        local lastHealthSampleTime = unitData.samples[1].time + unitData.startTime
        local timeSinceHealthSample = currentTime - lastHealthSampleTime

        if timeSinceHealthSample < self.state.userInterval then
            return true
        end
    end

    return false
end

--- Get cached value or return nil if cache is invalid
--- @param cacheKey string The cache key to retrieve
--- @return any|nil The cached value or nil if invalid
function TTDManager:GetCachedValue(cacheKey)
    if self:IsCacheValid(cacheKey) then
        return self.state.calculationCache[cacheKey].value
    end
    return nil
end

--- Store a value in the cache with current timestamp
--- @param cacheKey string The cache key
--- @param value any The value to cache
--- @param guid string|nil Optional GUID for health data staleness checking
function TTDManager:SetCachedValue(cacheKey, value, guid)
    local currentTime = GetTime()
    local lastSampleStamp = currentTime
    if guid then
        local unitData = self.state.units[guid]
        if unitData then
            if unitData.isSimulated and unitData.simulatedData then
                lastSampleStamp = currentTime
            else
                local latestSampleTime = (unitData.samples and unitData.samples[1] and unitData.samples[1].time) or 0
                lastSampleStamp = (unitData.startTime or 0) + latestSampleTime
            end
        end
    end
    self.state.calculationCache[cacheKey] = {
        value = value,
        timestamp = currentTime,
        guid = guid,
        lastSampleStamp = lastSampleStamp
    }
    -- Only update lastCalculationTime when we actually perform a new calculation
    -- This prevents the throttling issue where caching blocks new calculations
end

--- Check if calculations are needed based on user interval
--- @return boolean True if calculations should be performed
function TTDManager:ShouldCalculate()
    -- Safety check: ensure userInterval is valid
    if not self.state.userInterval or type(self.state.userInterval) ~= "number" then
        if self.debug then
            self:Debug("TTDManager:ShouldCalculate - userInterval is invalid, using fallback")
        end
        self.state.userInterval = 0.75 -- Fallback to default
    end

    local currentTime = GetTime()
    local timeSinceLastCalculation = currentTime - self.state.lastCalculationTime
    local shouldCalculate = timeSinceLastCalculation >= self.state.userInterval

    return shouldCalculate
end

--- Update the user interval from settings (called when settings change)
function TTDManager:UpdateUserInterval()
    -- TTDManager owns its own interval setting
    local newInterval = self.db.global.intervals.TTD_UPDATE
    if newInterval ~= self.state.userInterval then
        self.state.userInterval = newInterval
        if self.debug then
            self:Debug("TTD user interval updated to %.3f seconds", newInterval)
        end
        -- Clear cache when interval changes to ensure fresh calculations
        self:ClearCalculationCache()
    end
end

--- Clear the calculation cache
function TTDManager:ClearCalculationCache()
    wipe(self.state.calculationCache)
    if self.debug then
        self:Debug("TTD calculation cache cleared")
    end
end

--- Print lightweight cache statistics to chat for quick monitoring
function TTDManager:PrintCacheStats()
    local unitCount = 0
    local totalSamples = 0
    for guid, unitData in pairs(self.state.units) do
        unitCount = unitCount + 1
        if unitData and unitData.samples then
            totalSamples = totalSamples + #unitData.samples
        end
    end

    local cacheEntries = 0
    for _ in pairs(self.state.calculationCache) do
        cacheEntries = cacheEntries + 1
    end

    local avgSamples = unitCount > 0 and (totalSamples / unitCount) or 0
    self:Info("[TTD] Units=%d, Samples(total)=%d, Samples(avg)=%.1f, CalcCache=%d", unitCount, totalSamples, avgSamples,
        cacheEntries)
end

--- Clean up old cache entries to prevent memory bloat
function TTDManager:CleanupCache()
    local currentTime = GetTime()
    local maxAge = self.state.userInterval * 3 -- Keep cache for 3x the user interval

    for cacheKey, cacheData in pairs(self.state.calculationCache) do
        if (currentTime - cacheData.timestamp) > maxAge then
            self.state.calculationCache[cacheKey] = nil
        end
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
-- (timer driven updates remain, but we now listen to key player/unit events)

--- Purge a GUID: removes unit data and prunes any cache entries referencing the guid
--- @param guid string
function TTDManager:PurgeGUID(guid)
    if not guid then return end
    -- Remove unit data
    self.state.units[guid] = nil
    -- Prune cache entries that include this guid in their key or reference field
    for key, data in pairs(self.state.calculationCache) do
        if (type(key) == "string" and strfind(key, guid, 1, true)) or (data and data.guid == guid) then
            self.state.calculationCache[key] = nil
        end
    end
end

--- Handle player target changes
function TTDManager:OnPlayerTargetChanged()
    -- Purge previous target data if tracked
    if self.state.activeTargetGUID then
        self:PurgeGUID(self.state.activeTargetGUID)
    end
    -- Update active target guid
    local newGUID = UnitGUID("target")
    self.state.activeTargetGUID = newGUID
    if StateManager.state and StateManager.state.target then
        StateManager.state.target.guid   = self.state.activeTargetGUID
        StateManager.state.target.ttd    = nil
        StateManager.state.target.ttd_ts = 0
        StateManager.state.target.ttd_guid = nil
        StateManager.state.target.ttx    = nil
        StateManager.state.target.ttx_p  = nil
        StateManager.state.target.ttx_ts = 0
        StateManager.state.target.ttx_guid = nil
    end
    -- Clear cached calculations and allow immediate recompute
    self:ClearCalculationCache()
    self.state.lastCalculationTime = 0

    -- If in combat and we have a new valid target, activate boost mode
    if self:IsInCombat() and newGUID then
        self:ActivateBoost(newGUID)
    end
end

--- Handle leaving combat (regen enabled)
function TTDManager:OnPlayerRegenEnabled()
    self:ResetTTD()
    self.state.lastCalculationTime = 0
    -- End boost mode if active
    self.state.boostActive = false
    self.state.boostGuid = nil
    self.state.boostUntil = 0
    -- Reschedule back to user interval
    TimerManager:Cancel(TimerManager.Categories.CORE, "TTDRefresh")
    TimerManager:Create(
        TimerManager.Categories.CORE,
        "TTDRefresh",
        function()
            self:RequestTTDRefresh("timer_userInterval", self.state.userInterval)
        end,
        self.state.userInterval,
        true
    )
end

--- Handle player death
function TTDManager:OnPlayerDead()
    self:ResetTTD()
    self.state.lastCalculationTime = 0
    -- End boost mode if active
    self.state.boostActive = false
    self.state.boostGuid = nil
    self.state.boostUntil = 0
    -- Reschedule back to user interval
    TimerManager:Cancel(TimerManager.Categories.CORE, "TTDRefresh")
    TimerManager:Create(
        TimerManager.Categories.CORE,
        "TTDRefresh",
        function()
            self:RequestTTDRefresh("timer_userInterval", self.state.userInterval)
        end,
        self.state.userInterval,
        true
    )
end

--- Handle unit health events, filtered to target only
--- @param event string
--- @param unit string
function TTDManager:OnUnitHealth(event, unit)
    if unit ~= "target" then return end
    if not UnitExists("target") then
        if self.state.activeTargetGUID then
            self:PurgeGUID(self.state.activeTargetGUID)
            self.state.activeTargetGUID = nil
        end
        self:ClearCalculationCache()
        self.state.lastCalculationTime = 0
        return
    end
    local health = UnitHealth("target") or 0
    if health <= 0 then
        local guid = UnitGUID("target")
        if guid then
            self:PurgeGUID(guid)
        end
        self:ClearCalculationCache()
        self.state.lastCalculationTime = 0
        -- Also clear StateManager target snapshot on target death
        if StateManager.state and StateManager.state.target then
            StateManager.state.target.ttd    = nil
            StateManager.state.target.ttd_ts = 0
            StateManager.state.target.ttx    = nil
            StateManager.state.target.ttx_p  = nil
            StateManager.state.target.ttx_ts = 0
        end
        -- End boost mode if target died
        if self.state.boostActive then
            self.state.boostActive = false
            self.state.boostGuid = nil
            self.state.boostUntil = 0
            TimerManager:Cancel(TimerManager.Categories.CORE, "TTDRefresh")
            TimerManager:Create(
                TimerManager.Categories.CORE,
                "TTDRefresh",
                function()
                    self:RequestTTDRefresh("timer_userInterval", self.state.userInterval)
                end,
                self.state.userInterval,
                true
            )
        end
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

--- Check if the player is currently in combat
--- @return boolean True if in combat, false otherwise
function TTDManager:IsInCombat()
    return UnitAffectingCombat("player") == true
end

function TTDManager:IsTrainingDummy(unit)
    if not UnitExists(unit) then return false end
    if not ns.IsTrainingDummy() then return false end
    return true
end

--- Check if the current target is a training dummy with simulated encounter data
--- @return boolean True if target is a training dummy with simulated encounter, false otherwise
function TTDManager:IsTrainingDummyWithSimulation()
    if not UnitExists("target") then return false end

    -- Check if target is a training dummy
    if not self:IsTrainingDummy("target") then return false end

    -- Check if encounter timer is enabled and we have simulated data
    return NAG.db.global.enableEncounterTimer and NAG.db.global.encounterDuration and NAG.db.global.encounterDuration > 0
end

--- Get simulated encounter data for training dummies
--- @return table|nil Simulated encounter data or nil if not available
function TTDManager:GetSimulatedEncounterData()
    if not self:IsTrainingDummyWithSimulation() then return nil end

    -- Internal accessors that must NOT call into TTD or APL timing that references TTD
    local function GetEncounterRemainingTime()
        if StateManager.state and StateManager.state.combat then
            local combat = StateManager.state.combat
            if combat.currentTimeRemaining ~= nil then
                return combat.currentTimeRemaining
            end
            if combat.encounterEndTime then
                local rt = combat.encounterEndTime - GetTime()
                if rt < 0 then rt = 0 end
                return rt
            end
        end
        return nil
    end

    local function GetEncounterRemainingPercent(encounterDuration)
        local rt = GetEncounterRemainingTime()
        if not rt then return nil end
        if not encounterDuration or encounterDuration <= 0 then return nil end
        local pct = (rt / encounterDuration) * 100
        if pct < 0 then pct = 0 end
        if pct > 100 then pct = 100 end
        return pct
    end

    local startTime = StateManager.state and StateManager.state.combat and StateManager.state.combat.startTime or nil
    local currentTime = startTime and (GetTime() - startTime) or 0
    local encounterDuration = NAG.db.global.encounterDuration
    local remainingTime = GetEncounterRemainingTime()
    local remainingPercent = GetEncounterRemainingPercent(encounterDuration)

    -- If either accessor failed, fall back to normal sampling (no simulated data)
    if remainingTime == nil or remainingPercent == nil then
        return nil
    end

    -- Calculate simulated health based on remaining time
    local simulatedHealth = remainingPercent

    return {
        currentTime = currentTime,
        remainingTime = remainingTime,
        remainingPercent = remainingPercent,
        encounterDuration = encounterDuration,
        simulatedHealth = simulatedHealth,
        isSimulated = true
    }
end

--- Update TTD data for a unit
--- @param unit string
--- @param guid string
--- @param currentTime number
function TTDManager:UpdateTTDData(unit, guid, currentTime)
    -- Special handling for training dummies with simulated encounter data
    if unit == "target" and self:IsTrainingDummyWithSimulation() then
        local simulatedData = self:GetSimulatedEncounterData()
        if simulatedData then
            if self.debug then
                self:Trace("Using simulated encounter data for training dummy - health: %.1f%%, remaining: %.1fs",
                    simulatedData.simulatedHealth, simulatedData.remainingTime)
            end

            -- Create or update unit data with simulated values
            local unitData = self.state.units[guid]
            if not unitData then
                unitData = {
                    samples = {},
                    startTime = currentTime,
                    isSimulated = true,
                    simulatedData = simulatedData
                }
                self.state.units[guid] = unitData
            else
                unitData.isSimulated = true
                unitData.simulatedData = simulatedData
            end

            -- For simulated encounters, we don't need to collect health samples
            -- The TTD calculation will use the simulated data instead
            unitData.lastUpdate = currentTime
            return
        end
    end

    local health = UnitHealth(unit)
    local maxHealth = UnitHealthMax(unit)

    if health <= 0 or maxHealth <= 0 then
        return
    end

    local healthPercent = health / maxHealth * 100
    if healthPercent >= 100 then
        return
    end

    local unitData = self.state.units[guid]
    if not unitData then
        unitData = {
            samples = {},
            startTime = currentTime
        }
        self.state.units[guid] = unitData
    else
        -- Reset only if health increased by threshold (>= 3.0 percentage points)
        local previousHealth = (unitData.samples and unitData.samples[1] and unitData.samples[1].health) or healthPercent
        local delta = healthPercent - previousHealth
        if delta >= 3.0 then
            unitData = {
                samples = {},
                startTime = currentTime
            }
            self.state.units[guid] = unitData
        end
    end

    -- Check sample interval
    if currentTime - (unitData.lastUpdate or 0) < MIN_SAMPLE_INTERVAL then
        return
    end

    -- Add new sample if health changed
    local samples = unitData.samples
    if #samples == 0 or healthPercent ~= samples[1].health then
        -- Reuse or create new sample table
        local newSample = self.state.cache[#self.state.cache] or {}
        if #self.state.cache > 0 then
            self.state.cache[#self.state.cache] = nil
        end

        newSample.time = currentTime - unitData.startTime
        newSample.health = healthPercent
        tinsert(samples, 1, newSample)

        -- Cleanup old samples
        local time = currentTime - unitData.startTime
        while #samples > HISTORY_COUNT or (time - samples[#samples].time > HISTORY_TIME) do
            local oldSample = tremove(samples)
            tinsert(self.state.cache, oldSample)
        end
    end

    unitData.lastUpdate = currentTime
end

--- Calculate time to reach specific health percentage
--- @param guid string
--- @param targetPercent number
--- @param minSamples number
--- @return number Time in seconds
function TTDManager:CalculateTimeToX(guid, targetPercent, minSamples)
    local unitData = self.state.units[guid]

    -- Special handling for simulated training dummy encounters
    if unitData and unitData.isSimulated and unitData.simulatedData then
        local simulatedData = unitData.simulatedData
        local currentHealth = simulatedData.simulatedHealth
        local remainingTime = simulatedData.remainingTime

        -- For simulated encounters, TTD is simply the remaining time
        -- since the "target" health decreases linearly with time
        if targetPercent == 0 then
            -- Time to death (0% health) = remaining time
            return remainingTime
        else
            -- Time to reach specific health percentage
            -- Calculate based on current simulated health vs target
            if currentHealth <= targetPercent then
                -- Already at or below target health
                return 0
            else
                -- Calculate time based on health difference and total encounter duration
                local healthDifference = currentHealth - targetPercent
                local totalHealth = 100 -- Training dummies start at 100% health
                local timeRatio = healthDifference / totalHealth
                local timeToTarget = timeRatio * simulatedData.encounterDuration

                -- Clamp to remaining time
                return min(timeToTarget, remainingTime)
            end
        end
    end

    if not unitData or #unitData.samples < minSamples then
        return 8888
    end

    local samples = unitData.samples
    local n = #samples

    -- If current health is already at or below target percentage, time is zero
    local currentPercent = samples[1] and samples[1].health or nil
    if currentPercent and currentPercent <= targetPercent then
        return 0
    end

    -- Linear regression calculation
    local Ex2, Ex, Exy, Ey = 0, 0, 0, 0
    for _, sample in ipairs(samples) do
        local x, y = sample.time, sample.health
        Ex2 = Ex2 + x * x
        Ex = Ex + x
        Exy = Exy + x * y
        Ey = Ey + y
    end

    -- Calculate regression coefficients
    local invariant = 1 / (Ex2 * n - Ex * Ex)
    local a = (-Ex * Exy * invariant) + (Ex2 * Ey * invariant)
    local b = (n * Exy * invariant) - (Ex * Ey * invariant)

    -- Guard against near-zero or upward slopes (insufficient downward trend)
    if b >= -0.01 then
        return 8888
    end

    -- Calculate time to target percentage
    local seconds = (targetPercent - a) / b
    -- Adjust for elapsed time
    seconds = seconds - (GetTime() - unitData.startTime)

    -- Debug: Print final calculation details when in combat
    if self:IsInCombat() then
        self:Debug("TTD DEBUG: Raw calculation: seconds = (%.1f - %.4f) / %.4f = %.2f", targetPercent, a, b,
            (targetPercent - a) / b)
        self:Debug("TTD DEBUG: Time adjustment: %.2f - %.2f = %.2f", (targetPercent - a) / b,
            (GetTime() - unitData.startTime), seconds)
    end

    -- Handle edge cases
    if seconds < 0 then
        if self:IsInCombat() then
            self:Debug("TTD DEBUG: Returning 9999 - Negative time (%.2f) for GUID: %s", seconds, guid)
            self:Debug("TTD DEBUG: This means target health would be reached in the past")
        end
        return 9999
    end

    local finalResult = min(7777, seconds)
    if self:IsInCombat() and finalResult == 7777 then
        self:Debug("TTD DEBUG: Capped result to 7777 (was %.2f) for GUID: %s", seconds, guid)
    end

    return finalResult
end

--- Create a training dummy fallback function for LibRangeCheck SmartChecker
--- @return function A fallback function that handles training dummies with interaction distance
function TTDManager:CreateTrainingDummyFallback()
    return function(fallbackUnit)
        -- Custom fallback function for training dummies
        if not UnitExists(fallbackUnit) then return nil end

        local fallbackUnitName = UnitName(fallbackUnit) or "unknown"
        local isFallbackTrainingDummy = fallbackUnitName:find("Training Dummy") or fallbackUnitName:find("Dummy")

        if isFallbackTrainingDummy then
            -- Use interaction distance for training dummies
            return CheckInteractDistance(fallbackUnit, self:GetInteractionDistance())
        end

        return nil -- Let LibRangeCheck handle other units
    end
end

--- Get class-specific default ranges for a specIndex
--- Looks up the default ranges from CLASS_SPEC_RANGE_DEFAULTS table
--- @param specIndex number The specIndex (1-4) to look up
--- @return table|nil Table with {melee, ranged} or nil if no class-specific default exists
function TTDManager:GetClassSpecRangeDefaults(specIndex)
    if not specIndex or specIndex < 1 or specIndex > 4 then
        return nil
    end

    local englishClass = NAG.CLASS_FILENAME
    if not englishClass then
        return nil
    end

    local classDefaults = CLASS_SPEC_RANGE_DEFAULTS[englishClass]
    if classDefaults and classDefaults[specIndex] then
        return classDefaults[specIndex]
    end

    return nil
end

--- Check if the player's class is considered ranged
--- Uses CLASS_SPEC_RANGED_TABLE to preserve the old hardcoded spec ID logic
--- @return boolean True if the player's class is ranged
function TTDManager:IsRangedClass()
    -- Prefer spec-aware detection using specIndex
    local specIndex = StateManager and SpecCompat and SpecCompat:GetCurrentSpecIndex() or nil

    if specIndex and type(specIndex) == "number" and specIndex > 0 then
        -- Look up in CLASS_SPEC_RANGED_TABLE for precise spec-based detection
        local englishClass = NAG.CLASS_FILENAME
        if englishClass then
            local classRangedTable = CLASS_SPEC_RANGED_TABLE[englishClass]
            if classRangedTable and classRangedTable[specIndex] == true then
                return true
            end
        end
        return false
    end

    -- Fallback to class-level heuristic if spec unknown
    -- Preserves exact old behavior: explicit check for the 4 pure ranged classes
    local englishClass = NAG.CLASS_FILENAME
    return englishClass == "HUNTER" or englishClass == "MAGE" or
        englishClass == "WARLOCK" or englishClass == "PRIEST"
end

--- Get the appropriate range for the current class and spec
---
--- This function returns spec-specific ranges for different range types from the database.
--- It uses the current player's specialization index to determine the appropriate range, using reasonable combat
--- ranges (not interaction distances). Values are stored in the database and can be modified by users.
---
--- Range types:
--- - "melee": Range for melee abilities and close combat (standard: 5 yards)
--- - "ranged": Range for ranged abilities and distance calculations (default: 30 yards)
---
--- Spec-specific examples:
--- - Enhancement Shaman (specIndex 2): 10-yard melee range for abilities like Unleash Elements
--- - Retribution Paladin (specIndex 3): 10-yard melee range for abilities like Hammer of Wrath
--- - Most specs: 5-yard melee range for standard combat abilities
--- - Ranged specs: 5-yard melee range for standard combat abilities
---
--- Performance: O(1) lookup from database with Ace3 defaults management
---
--- @param rangeType string Optional range type ("melee", "ranged") - defaults to "melee"
--- @param specIndex number|nil Optional specIndex (1-4), uses current spec if not provided
--- @return number The appropriate range in yards for the current spec and range type
function TTDManager:GetSpecRange(rangeType, specIndex)
    rangeType = rangeType or "melee"

    -- Default ranges (fallback if no database value)
    local defaultMelee = 5 -- Standard melee combat range
    local defaultRanged = 30

    -- Get specIndex for current spec using cached data
    local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

    -- Use provided specIndex if available, otherwise use currentSpecIndex
    local targetSpecIndex = specIndex or currentSpecIndex

    -- Get range settings from database (Ace3 handles defaults + user changes)
    local specRangeSettings = self.db.global.specRangeSettings

    -- Try to get spec-specific range from database (user overrides take precedence)
    if targetSpecIndex and specRangeSettings[targetSpecIndex] then
        return specRangeSettings[targetSpecIndex][rangeType] or defaultMelee
    end

    -- If no database value, check class-specific defaults from CLASS_SPEC_RANGE_DEFAULTS table
    if targetSpecIndex and targetSpecIndex > 0 then
        local classDefaults = self:GetClassSpecRangeDefaults(targetSpecIndex)
        if classDefaults and classDefaults[rangeType] then
            return classDefaults[rangeType]
        end
    end

    -- Fallback to general defaults if no class-specific default exists
    local isRangedClass = self:IsRangedClass()

    if rangeType == "melee" then
        return defaultMelee
    elseif rangeType == "ranged" then
        return defaultRanged
    else
        -- For unknown range types, use class-appropriate default
        if isRangedClass then
            return defaultRanged -- Ranged classes default to ranged behavior
        else
            return defaultMelee  -- Melee classes default to melee behavior
        end
    end
end

--- Get the appropriate interaction distance based on player class and spec
--- @return number The interaction distance to use
function TTDManager:GetInteractionDistance()
    -- Use the same logic as IsRangedClass for consistency
    if self:IsRangedClass() then
        return 1
    else
        return 3
    end
end

--- Check if a unit is in melee range using spec-appropriate range
--- @param unit string The unit to check
--- @return boolean True if the unit is in melee range
function TTDManager:IsInMeleeRange(unit)
    if not UnitExists(unit) then return false end
    if not UnitCanAttack("player", unit) then return false end

    -- Use spec-appropriate melee range for consistency with other functions
    local meleeRange = self:GetSpecRange("melee")

    -- Check if unit is in combat and in range
    if UnitAffectingCombat(unit) then
        return true
    end

    -- Check if user wants to use interaction distance method
    if self.db.global.useInteractionDistance then
        -- Use interaction distance check (simpler, more reliable for some cases)
        return CheckInteractDistance(unit, self:GetInteractionDistance())
    end

    -- Use SmartChecker with custom fallback for training dummies
    local checker = RC:GetSmartChecker(meleeRange, self:CreateTrainingDummyFallback())

    if checker then
        return checker(unit)
    else
        -- Fallback if no checker available
        return CheckInteractDistance(unit, self:GetInteractionDistance())
    end
end

--- Refresh TTD data for all relevant units
function TTDManager:RefreshTTD()
    local currentTime = GetTime()

    wipe(self.state.checkedUnits)
    local mobCount = 0
    local meleeMobCount = 0

    -- Check if target is a training dummy and update encounter timer state
    if UnitExists("target") then
        local isTrainingDummy = self:IsTrainingDummy("target")

        if isTrainingDummy and not NAG.db.global.enableEncounterTimer then
            -- Enable encounter timer for training dummy
            NAG:SetSetting("global", "enableEncounterTimer", true)
            if not NAG.db.global.encounterDuration then
                NAG:SetSetting("global", "encounterDuration", 300) -- Default to 5 minutes if not set
            end
            if self.debug then
                self:Debug("Training dummy detected - enabling encounter timer")
            end
        elseif not isTrainingDummy and NAG.db.global.enableEncounterTimer then
            -- Disable encounter timer when target is not a training dummy
            NAG:SetSetting("global", "enableEncounterTimer", false)
            if self.debug then
                self:Debug("Non-training dummy target - disabling encounter timer")
            end
        end
    end

    -- Update data for all valid units
    local iterableUnits = ns.GetIterableUnits()

    for _, unit in ipairs(iterableUnits) do
        if UnitExists(unit) then
            -- Special handling for training dummies - they might not register as attackable
            local unitName = UnitName(unit) or "unknown"
            local isTrainingDummy = unitName:find("Training Dummy") or unitName:find("Dummy")

            if UnitCanAttack("player", unit) or isTrainingDummy then
                local guid = UnitGUID(unit)
                if guid and not self.state.checkedUnits[guid] then
                    self.state.checkedUnits[guid] = true


                    self:UpdateTTDData(unit, guid, currentTime)
                    mobCount = mobCount + 1
                    -- self:Trace("RefreshTTD: Counted unit %s (mobCount=%d)", unit, mobCount)

                    -- Check if unit is in melee range
                    if self:IsInMeleeRange(unit) then
                        meleeMobCount = meleeMobCount + 1
                        -- self:Trace("RefreshTTD: Unit %s in melee range (meleeMobCount=%d)", unit, meleeMobCount)
                    end
                end
            end
        end
    end


    -- Check if mob counts have changed and send messages for rotation switching
    local oldMobCount = self.state.mobCount
    local oldMeleeMobCount = self.state.meleeMobCount

    self.state.mobCount = mobCount
    self.state.meleeMobCount = meleeMobCount

    -- Send consolidated mob count message when either count changes (for automatic rotation switching)
    if oldMobCount ~= mobCount or oldMeleeMobCount ~= meleeMobCount then
        -- Use TablePool for message payload (released after message sent)
        local payload = TablePool:Acquire("small")
        payload.total = mobCount
        payload.melee = meleeMobCount
        payload.oldTotal = oldMobCount
        payload.oldMelee = oldMeleeMobCount
        self:SendMessage("NAG_MOB_COUNT_CHANGED", payload)
        TablePool:Release("small", payload)
        if self.debug then
            self:Trace("Mob counts changed (total: %d -> %d, melee: %d -> %d) - sent NAG_MOB_COUNT_CHANGED message",
                oldMobCount, mobCount, oldMeleeMobCount, meleeMobCount)
        end
    end

    -- Evaluate whether to deactivate boost mode after refresh
    self:MaybeDeactivateBoost()
end

function TTDManager:GetTTD(guid, minSamples)
    -- Memory optimization: format() avoids creating intermediate temporary strings during concatenation
    local cacheKey = format("GetTTD:%s:%d", guid or "none", minSamples or 3)

    -- Check cache first
    local cachedValue = self:GetCachedValue(cacheKey)
    if cachedValue then
        return cachedValue
    end

    -- No cached value: compute immediately (do not gate on ShouldCalculate)
    local result = self:CalculateTimeToX(guid, 0, minSamples or 3)
    self:SetCachedValue(cacheKey, result, guid)
    -- Update lastCalculationTime only when we actually perform a new calculation
    self.state.lastCalculationTime = GetTime()
    return result
end

function TTDManager:GetTimeToPercent(guid, percent, minSamples)
    -- Memory optimization: format() avoids creating intermediate temporary strings during concatenation
    local cacheKey = format("GetTimeToPercent:%s:%s:%d", guid or "none", percent, minSamples or 3)

    -- Check cache first
    local cachedValue = self:GetCachedValue(cacheKey)
    if cachedValue then
        return cachedValue
    end

    -- No cached value: compute immediately (do not gate on ShouldCalculate)
    local result = self:CalculateTimeToX(guid, percent, minSamples or 3)
    self:SetCachedValue(cacheKey, result, guid)
    -- Update lastCalculationTime only when we actually perform a new calculation
    self.state.lastCalculationTime = GetTime()
    return result
end

--- Get total number of tracked mobs
--- @return number The total number of tracked mobs
function TTDManager:GetMobCount()
    local cacheKey = "GetMobCount"

    -- Check cache first
    local cachedValue = self:GetCachedValue(cacheKey)
    if cachedValue then
        return cachedValue
    end

    -- Calculate if needed
    if self:ShouldCalculate() then
        -- Request refresh and return current state (stale-while-refreshing).
        self:RequestTTDRefresh("GetMobCount")

        if self.debug then
            self:Trace("GetMobCount: returned mobCount=%d", self.state.mobCount)
        end
        self:SetCachedValue(cacheKey, self.state.mobCount)
        -- Update lastCalculationTime only when we actually perform a new calculation
        self.state.lastCalculationTime = GetTime()
        return self.state.mobCount
    end

    -- Return cached value even if stale
    return cachedValue or 0
end

--- Get number of mobs in melee range
--- @return number The number of mobs in melee range
function TTDManager:GetMeleeMobCount()
    local cacheKey = "GetMeleeMobCount"

    -- Check cache first
    local cachedValue = self:GetCachedValue(cacheKey)
    if cachedValue then
        return cachedValue
    end

    -- Calculate if needed
    if self:ShouldCalculate() then
        -- Request refresh and return current state (stale-while-refreshing).
        self:RequestTTDRefresh("GetMeleeMobCount")

        if self.debug then
            self:Trace("GetMeleeMobCount: returned meleeMobCount=%d", self.state.meleeMobCount)
        end
        self:SetCachedValue(cacheKey, self.state.meleeMobCount)
        -- Update lastCalculationTime only when we actually perform a new calculation
        self.state.lastCalculationTime = GetTime()
        return self.state.meleeMobCount
    end

    -- Return cached value even if stale
    return cachedValue or 0
end

--- Get appropriate number of targets based on class type, spec, and distance
---
--- This function counts enemies within appropriate ranges based on the player's class and specialization.
--- It uses spec-specific ranges when available, falling back to provided parameters or class defaults.
---
--- Behavior:
--- - If meleeRange is provided: Uses that specific range for melee calculations
--- - If meleeRange is nil: Uses spec-appropriate melee range (e.g., 10 yards for Enhancement Shaman)
--- - If rangedRange is provided: Uses that specific range for ranged calculations
--- - If rangedRange is nil: Uses spec-appropriate ranged range for general enemy counting
---
--- For melee classes: First checks spec-appropriate melee range around player, falls back to ranged range if no enemies found in melee range
--- For ranged classes: Uses spec-appropriate ranged range for all calculations
---
--- Special targeting logic: If no enemies are in melee range but a target exists, returns 1 (can charge to get in range)
---
--- @param meleeRange number|nil Optional melee range override (overrides spec-appropriate melee range)
--- @param rangedRange number|nil Optional ranged range override (overrides spec-appropriate ranged range)
--- @param useMeleeFallback boolean|nil Optional: Whether melee classes should fallback to ranged range when no enemies found in melee range. Overrides user setting if provided.
--- @return number The appropriate number of targets for the player's class and spec
function TTDManager:GetTargetCount(meleeRange, rangedRange, useMeleeFallback)
    -- Check if temporary target count override is active
    if self.tempTargetCount then
        return self.tempTargetCount -- Return custom target count
    end

    -- Check if persistent target count override is active
    if self.db.global.targetCountOverride then
        return self.db.global.targetCountOverride -- Return persistent custom target count
    end

    -- Check if temporary AoE override is active - force single target mode
    if self.tempForceSingleTarget then
        return 1 -- Always return 1 target when temporary override is active
    end

    -- Get user's melee fallback setting (default to true for backward compatibility)
    local userMeleeFallback = self.db.global.meleeFallback

    -- Use provided parameter if available, otherwise use user setting
    useMeleeFallback = useMeleeFallback ~= nil and useMeleeFallback or userMeleeFallback

    -- Memory optimization: format() avoids creating intermediate temporary strings during concatenation
    -- For Frost/typical NumberTargets() with no args: meleeRange=7, rangedRange=-1, useMeleeFallback=0 or 1 → key "GetTargetCount:7:-1:0" or "GetTargetCount:7:-1:1"
    local cacheKey = format("GetTargetCount:%d:%d:%d", meleeRange or 7, rangedRange or -1, useMeleeFallback and 1 or 0)

    -- Check cache first (validity is time-based: IsCacheValid uses userInterval; no guid so no health-sample invalidation)
    local cachedValue = self:GetCachedValue(cacheKey)
    if cachedValue then
        return cachedValue
    end

    -- Check if we should calculate based on time interval
    -- But also force calculation if parameters have changed significantly
    local shouldCalculate = self:ShouldCalculate()

    -- Force calculation if this is a new parameter combination (different cache key)
    if not shouldCalculate and not cachedValue then
        shouldCalculate = true
    end

    if shouldCalculate then
        if self.debug then
            self:Trace("GetTargetCount: cache miss, recalculating (key=%s)", cacheKey)
        end
        -- Use existing class determination logic
        local isRangedClass = self:IsRangedClass()

        -- Get distance from player to target (if target exists)
        local targetDistance = 0
        if UnitExists("target") then
            local minRange, maxDist = RC:GetRange("target", true)
            targetDistance = minRange or maxDist or 0
        end

        -- Use spec-appropriate ranges
        local meleeRangeToUse = meleeRange or self:GetSpecRange("melee")
        local rangedRangeToUse

        if rangedRange then
            -- If a specific ranged range is provided, use it
            rangedRangeToUse = rangedRange
        else
            -- Use spec-appropriate ranged range for general enemy counting
            rangedRangeToUse = self:GetSpecRange("ranged")
        end

        local result
        if isRangedClass then
            -- Ranged classes: use the calculated ranged range
            result = self:CountEnemiesInRange(rangedRangeToUse)
            --self:Trace("Ranged class logic: using range %s, result=%s", tostring(rangedRangeToUse), tostring(result))
        else
            -- Melee classes: first try the spec-appropriate melee range around player
            local meleeCount = self:CountEnemiesInRange(meleeRangeToUse)
            --self:Trace("Melee class logic: meleeCount=%s at range %s", tostring(meleeCount), tostring(meleeRangeToUse))

            -- If we have enemies in melee range, return that count (for AoE decisions)
            if meleeCount > 0 then
                result = meleeCount
            else
                -- No enemies in melee range - check if we have a target for charge logic
                local hasTarget = UnitExists("target")

                if hasTarget then
                    -- We have a target but no enemies in melee range - we can charge to get in range
                    result = 1
                elseif useMeleeFallback then
                    -- No target and no enemies in melee - try ranged fallback
                    result = self:CountEnemiesInRange(rangedRangeToUse)
                    --self:Trace("Melee class fallback: using ranged range %s, result=%s", tostring(rangedRangeToUse), tostring(result))
                else
                    -- No target, no enemies in melee, and no fallback - return 0
                    result = 0
                    if self.debug then
                        self:Trace("Melee class: no enemies in melee, no target, no fallback - returning 0")
                    end
                end
            end
        end

        self:SetCachedValue(cacheKey, result)
        -- Update lastCalculationTime only when we actually calculate
        self.state.lastCalculationTime = GetTime()
        return result
    else
        -- Return cached value if available, otherwise force calculation
        if cachedValue then
            return cachedValue
        else
            -- Force calculation if no cached value exists
            return self:GetTargetCount(meleeRange, rangedRange, useMeleeFallback)
        end
    end
end

--- Count enemies within a specific range using basic distance calculation (no advanced features)
--- @param maxRange number The maximum range to check
--- @return number The number of enemies in range
function TTDManager:CountEnemiesInRangeBasic(maxRange)
    -- Validate inputs
    if not maxRange then return 0 end

    -- Validate and clamp maxRange
    maxRange = min(max(1, maxRange), 100)

    local count = 0

    -- Check nameplates (enemy units) - start from index 5
    local iterableUnits = ns.GetIterableUnits()
    if iterableUnits then
        for i = 5, #iterableUnits do
            local unit = iterableUnits[i]

            if UnitExists(unit) then
                if UnitCanAttack("player", unit) then
                    -- Get range info using SmartChecker
                    local distance
                    local useInteractionDistance = self.db.global.useInteractionDistance

                    if useInteractionDistance then
                        -- Use interaction distance method
                        distance = CheckInteractDistance(unit, self:GetInteractionDistance()) and 0 or 993
                    else
                        -- Use SmartChecker
                        local checker = RC:GetSmartChecker(maxRange)

                        if checker then
                            local inRange = checker(unit)
                            distance = inRange and 0 or 999
                        else
                            -- Fallback if no checker available
                            distance = 999
                        end
                    end

                    if distance and distance <= maxRange then
                        count = count + 1
                    end
                end
            end
        end
    end

    return count
end

--- Count enemies within a specific range using advanced features (debug logging, training dummy detection, target handling)
--- @param maxRange number The maximum range to check
--- @param useCaching boolean|nil Optional: Use caching. Default: true
--- @return number The number of enemies in range
function TTDManager:CountEnemiesInRangeAdvanced(maxRange, useCaching)
    -- Set defaults for backward compatibility
    useCaching = useCaching ~= false -- Default to true

    -- Validate inputs
    if not maxRange then return 0 end

    -- Validate and clamp maxRange
    maxRange = min(max(1, maxRange), 100)

    local count = 0
    local targetCounted = false -- Track if we've counted the target

    -- Check target separately first (most important unit)
    if UnitExists("target") then
        local targetName = UnitName("target") or "unknown"

        -- Special case for training dummies - they might not register as attackable
        -- but we can still check if they're in range
        local isTrainingDummy = targetName:find("Training Dummy") or targetName:find("Dummy")

        if UnitCanAttack("player", "target") or isTrainingDummy then
            -- Get target distance based on user preference
            local distance
            local useInteractionDistance = self.db.global.useInteractionDistance

            if useInteractionDistance then
                -- Use interaction distance method
                distance = CheckInteractDistance("target", self:GetInteractionDistance()) and 0 or 991
            else
                -- Use SmartChecker with custom fallback for training dummies
                local checker = RC:GetSmartChecker(maxRange, self:CreateTrainingDummyFallback())

                if checker then
                    local inRange = checker("target")
                    distance = inRange and 0 or 999
                else
                    -- Fallback if no checker available
                    distance = 999
                end
            end

            if distance and distance <= maxRange then
                count = count + 1
                targetCounted = true
            end
        end
    end

    -- Check nameplates (enemy units) - start from index 5
    local iterableUnits = ns.GetIterableUnits()
    if iterableUnits then
        for i = 5, #iterableUnits do
            local unit = iterableUnits[i]

            if UnitExists(unit) then
                -- Skip if this nameplate is the same as our target (avoid double-counting)
                if targetCounted and UnitGUID(unit) == UnitGUID("target") then
                    -- Skip this unit (already counted as target)
                else
                    local unitName = UnitName(unit) or "unknown"
                    local isTrainingDummy = unitName:find("Training Dummy") or unitName:find("Dummy")

                    if UnitCanAttack("player", unit) or isTrainingDummy then
                        -- Get range info using SmartChecker with training dummy fallback
                        local distance
                        local useInteractionDistance = self.db.global.useInteractionDistance

                        if useInteractionDistance then
                            -- Use interaction distance method
                            distance = CheckInteractDistance(unit, self:GetInteractionDistance()) and 0 or 993
                        else
                            -- Use SmartChecker with custom fallback for training dummies
                            local checker = RC:GetSmartChecker(maxRange, self:CreateTrainingDummyFallback())

                            if checker then
                                local inRange = checker(unit)
                                distance = inRange and 0 or 999
                            else
                                -- Fallback if no checker available
                                distance = 999
                            end
                        end

                        if distance and distance <= maxRange then
                            count = count + 1
                        end
                    end
                end
            end
        end
    end

    return count
end

--- Count enemies within a specific range using distance-based calculation
--- @param maxRange number The maximum range to check
--- @param useAdvancedFeatures boolean|nil Optional: Use advanced features (training dummy detection, target handling, caching). Default: true
--- @param useCaching boolean|nil Optional: Use caching (only applies if useAdvancedFeatures is true). Default: true
--- @return number The number of enemies in range
function TTDManager:CountEnemiesInRange(maxRange, useAdvancedFeatures, useCaching)
    -- Check if temporary AoE override is active - force single target mode
    if self.tempForceSingleTarget then
        -- Return 1 if there's a valid target, 0 otherwise
        if UnitExists("target") and UnitCanAttack("player", "target") then
            return 1
        end
        return 0
    end

    -- Set defaults for backward compatibility
    useAdvancedFeatures = useAdvancedFeatures ~= false -- Default to true

    -- Dispatch to appropriate function based on useAdvancedFeatures
    if useAdvancedFeatures then
        return self:CountEnemiesInRangeAdvanced(maxRange, useCaching)
    else
        return self:CountEnemiesInRangeBasic(maxRange)
    end
end

--- Reset all TTD data
--- @function TTDManager:ResetTTD
function TTDManager:ResetTTD()
    -- Clean up all unit data
    wipe(self.state.units)

    -- Reset mob counts
    self.state.mobCount = 0
    self.state.meleeMobCount = 0

    -- Clean up cache but keep the table
    wipe(self.state.cache)

    -- Clear calculation cache
    self:ClearCalculationCache()

    -- Reset last cleanup time
    self.state.lastCleanup = GetTime()
end

-- ~~~~~~~~~~ BOOST MODE HELPERS ~~~~~~~~~~

--- Activate adaptive sampling boost mode for a GUID
--- @param guid string
function TTDManager:ActivateBoost(guid)
    local now = GetTime()
    -- If boost already active, just retarget/extend timeframe
    if self.state.boostActive then
        self.state.boostGuid = guid
        self.state.boostUntil = now + 3.0
        return
    end

    self.state.boostActive = true
    self.state.boostGuid = guid
    self.state.boostUntil = now + 3.0

    local desiredInterval = 0.3
    TimerManager:Cancel(TimerManager.Categories.CORE, "TTDRefresh")
    TimerManager:Create(
        TimerManager.Categories.CORE,
        "TTDRefresh",
        function()
            self:RequestTTDRefresh("timer_boost", desiredInterval)
        end,
        desiredInterval,
        true
    )
end

--- Maybe deactivate boost mode based on time, sample sufficiency, combat status, or target change
function TTDManager:MaybeDeactivateBoost()
    if not self.state.boostActive then return end

    local now = GetTime()
    local reasonToEnd = false

    -- Time-based end
    if now >= (self.state.boostUntil or 0) then
        reasonToEnd = true
    end

    -- Target changed
    if self.state.boostGuid and self.state.activeTargetGUID and self.state.boostGuid ~= self.state.activeTargetGUID then
        reasonToEnd = true
    end

    -- Left combat
    if not self:IsInCombat() then
        reasonToEnd = true
    end

    -- Enough distinct samples
    if self.state.boostGuid then
        local unitData = self.state.units[self.state.boostGuid]
        if unitData and unitData.samples and #unitData.samples > 0 then
            -- Use TablePool for temporary seen tracking
            local seen = TablePool:Acquire("small")
            local distinct = 0
            for i = 1, #unitData.samples do
                local h = unitData.samples[i].health
                if not seen[h] then
                    seen[h] = true
                    distinct = distinct + 1
                    if distinct >= 10 then
                        reasonToEnd = true
                        break
                    end
                end
            end
            TablePool:Release("small", seen)
        end
    end

    if reasonToEnd then
        self.state.boostActive = false
        self.state.boostGuid = nil
        self.state.boostUntil = 0

        -- Reschedule back to normal cadence
        TimerManager:Cancel(TimerManager.Categories.CORE, "TTDRefresh")
        TimerManager:Create(
            TimerManager.Categories.CORE,
            "TTDRefresh",
            function()
                self:RequestTTDRefresh("timer_userInterval", self.state.userInterval)
            end,
            self.state.userInterval,
            true
        )
    end
end

-- ============================ DEBUG FRAME ============================

--- Get debug sections for the debug frame
--- @return table Array of debug sections
function TTDManager:GetDebugSections()
    return {
        {
            header = "TTD System Status",
            dataFn = function()
                local currentTime = GetTime()
                local unitCount = TableUtils.Size(self.state.units)
                local cacheSize = 0
                for _ in pairs(self.state.calculationCache) do
                    cacheSize = cacheSize + 1
                end

                return {
                    string.format("Current Time: %.2f", currentTime),
                    string.format("In Combat: %s", tostring(self:IsInCombat())),
                    string.format("User Interval: %.3f seconds", self.state.userInterval or 0),
                    string.format("Last Calculation: %.2f", self.state.lastCalculationTime or 0),
                    string.format("Last Refresh: %.2f", self.state.lastRefreshTime or 0),
                    string.format("Should Calculate: %s", tostring(self:ShouldCalculate())),
                    "",
                    string.format("Tracked Units: %d", unitCount),
                    string.format("Mob Count: %d", self.state.mobCount or 0),
                    string.format("Melee Mob Count: %d", self.state.meleeMobCount or 0),
                    string.format("Cache Entries: %d", cacheSize),
                    "",
                    "TTD Return Values:",
                    "- 8888: Insufficient samples or calculation failed",
                    "- 9999: Target health would be reached in the past",
                    "- 7777: Result capped at maximum value",
                    "- Other: Valid TTD in seconds"
                }
            end
        },
        {
            header = "Current Target",
            dataFn = function()
                if not UnitExists("target") then
                    return { "No target selected" }
                end

                local targetGUID = UnitGUID("target")
                local targetName = UnitName("target")
                local targetHealth = UnitHealth("target")
                local targetMaxHealth = UnitHealthMax("target")
                local targetHealthPercent = targetMaxHealth > 0 and (targetHealth / targetMaxHealth * 100) or 0

                local lines = {
                    string.format("Name: %s", targetName or "Unknown"),
                    string.format("GUID: %s", targetGUID or "None"),
                    string.format("Health: %d/%d (%.1f%%)", targetHealth, targetMaxHealth, targetHealthPercent),
                    ""
                }

                if targetGUID then
                    local ttd = self:GetTTD(targetGUID, 3)
                    local ttdPercent = self:GetTimeToPercent(targetGUID, 50, 3)

                    lines[#lines + 1] = string.format("TTD (0%%): %.2f", ttd)
                    lines[#lines + 1] = string.format("Time to 50%%: %.2f", ttdPercent)

                    if ttd == 8888 then
                        lines[#lines + 1] = "*** TTD 8888 - INSUFFICIENT SAMPLES ***"
                    elseif ttd == 9999 then
                        lines[#lines + 1] = "*** TTD 9999 - HEALTH WOULD BE REACHED IN PAST ***"
                    elseif ttd == 7777 then
                        lines[#lines + 1] = "*** TTD 7777 - RESULT CAPPED ***"
                    end

                    -- Check if we have unit data for this target
                    local unitData = self.state.units[targetGUID]
                    if unitData then
                        lines[#lines + 1] = ""
                        lines[#lines + 1] = "Unit Data:"
                        lines[#lines + 1] = string.format("  Start Time: %.2f", unitData.startTime or 0)
                        lines[#lines + 1] = string.format("  Last Update: %.2f", unitData.lastUpdate or 0)
                        lines[#lines + 1] = string.format("  Sample Count: %d", #(unitData.samples or {}))

                        -- Check if this is simulated data
                        if unitData.isSimulated and unitData.simulatedData then
                            lines[#lines + 1] = ""
                            lines[#lines + 1] = "*** SIMULATED ENCOUNTER DATA ***"
                            lines[#lines + 1] = string.format("  Simulated Health: %.1f%%",
                                unitData.simulatedData.simulatedHealth)
                            lines[#lines + 1] = string.format("  Remaining Time: %.1fs",
                                unitData.simulatedData.remainingTime)
                            lines[#lines + 1] = string.format("  Encounter Duration: %.1fs",
                                unitData.simulatedData.encounterDuration)
                            lines[#lines + 1] = string.format("  Current Time: %.1fs", unitData.simulatedData
                                .currentTime)
                        end
                    else
                        lines[#lines + 1] = ""
                        lines[#lines + 1] = "*** NO UNIT DATA FOR TARGET ***"

                        -- Check if this should be using simulated data
                        if self:IsTrainingDummyWithSimulation() then
                            lines[#lines + 1] = "*** TRAINING DUMMY WITH SIMULATION AVAILABLE ***"
                            lines[#lines + 1] = "*** TTD SHOULD USE SIMULATED ENCOUNTER DATA ***"
                        end
                    end
                end

                return lines
            end
        },
        {
            header = "Tracked Units & Samples",
            dataFn = function()
                local unitCount = TableUtils.Size(self.state.units)
                if unitCount == 0 then
                    return { "No units currently tracked" }
                end

                local lines = {}
                local count = 0

                for guid, unitData in pairs(self.state.units) do
                    if count < 5 then -- Limit to first 5 units to avoid overwhelming the UI
                        lines[#lines + 1] = string.format("=== Unit %d ===", count + 1)
                        lines[#lines + 1] = string.format("GUID: %s", string.sub(guid or "nil", 1, 8) .. "...")
                        lines[#lines + 1] = string.format("Start Time: %.2f", unitData.startTime or 0)
                        lines[#lines + 1] = string.format("Last Update: %.2f", unitData.lastUpdate or 0)
                        lines[#lines + 1] = string.format("Sample Count: %d", #(unitData.samples or {}))

                        -- Check if this is simulated data
                        if unitData.isSimulated and unitData.simulatedData then
                            lines[#lines + 1] = "*** SIMULATED ENCOUNTER DATA ***"
                            lines[#lines + 1] = string.format("  Simulated Health: %.1f%%",
                                unitData.simulatedData.simulatedHealth)
                            lines[#lines + 1] = string.format("  Remaining Time: %.1fs",
                                unitData.simulatedData.remainingTime)
                        end

                        if unitData.samples and #unitData.samples > 0 then
                            lines[#lines + 1] = "Sample Details:"
                            local sampleCount = math.min(#unitData.samples, 3) -- Show first 3 samples
                            for i = 1, sampleCount do
                                local sample = unitData.samples[i]
                                lines[#lines + 1] = string.format("  %d: time=%.2f, health=%.1f%%", i, sample.time,
                                    sample.health)
                            end
                            if #unitData.samples > 3 then
                                lines[#lines + 1] = string.format("  ... and %d more samples", #unitData.samples - 3)
                            end

                            -- Test TTD calculation
                            local ttd = self:GetTTD(guid, 3)
                            lines[#lines + 1] = string.format("TTD (0%%): %.2f", ttd)

                            if ttd == 8888 then
                                lines[#lines + 1] = "*** TTD 8888 - PROBLEM DETECTED ***"
                            end
                        else
                            lines[#lines + 1] = "*** NO SAMPLES AVAILABLE ***"
                        end

                        lines[#lines + 1] = ""
                        count = count + 1
                    else
                        lines[#lines + 1] = string.format("... and %d more units", unitCount - 5)
                        break
                    end
                end

                return lines
            end
        },
        {
            header = "Range & Combat Settings",
            dataFn = function()
                local englishClass = NAG.CLASS_FILENAME
                local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0
                local specInfo = SpecCompat and SpecCompat:GetSpecInfo(SpecCompat:GetCurrentSpecIndex())
                local specName = (specInfo and specInfo.name) or "None"
                local meleeRange = self:GetSpecRange("melee")
                local rangedRange = self:GetSpecRange("ranged")
                local interactionDistance = self:GetInteractionDistance()

                return {
                    string.format("Class: %s", englishClass or "Unknown"),
                    string.format("Spec Index: %s", tostring(specIndex)),
                    string.format("Spec Name: %s", specName),
                    string.format("Is Ranged Class: %s", tostring(self:IsRangedClass())),
                    "",
                    string.format("Melee Range: %d yards", meleeRange),
                    string.format("Ranged Range: %d yards", rangedRange),
                    string.format("Interaction Distance: %d yards", interactionDistance),
                    "",
                    string.format("Use Interaction Distance: %s", tostring(self.db.global.useInteractionDistance)),
                    string.format("Melee Fallback to Ranged: %s", tostring(self.db.global.meleeFallback)),
                    "",
                    "Range Type Explanations:",
                    "- Melee: Range for melee abilities and close combat",
                    "- Ranged: Range for ranged abilities and distance calculations",
                    "- Interaction: Distance for targeting/looting (legacy)",
                    "- Use Interaction Distance: When enabled, uses CheckInteractDistance instead of LibRangeCheck",
                    "- Melee Fallback: When enabled, melee classes count enemies at ranged distance if none in melee"
                }
            end
        },
        {
            header = "Cache & Performance",
            dataFn = function()
                local cacheSize = 0
                local recentEntries = 0
                local currentTime = GetTime()

                for key, data in pairs(self.state.calculationCache) do
                    cacheSize = cacheSize + 1
                    if (currentTime - (data.timestamp or 0)) < 5 then -- Entries from last 5 seconds
                        recentEntries = recentEntries + 1
                    end
                end

                local lines = {
                    string.format("Cache Size: %d entries", cacheSize),
                    string.format("Recent Entries (<5s): %d", recentEntries),
                    string.format("Last Calculation Time: %.2f", self.state.lastCalculationTime or 0),
                    string.format("User Interval: %.2f seconds", self.state.userInterval or 0),
                    string.format("Should Calculate: %s", tostring(self:ShouldCalculate())),
                    ""
                }

                if cacheSize > 0 then
                    lines[#lines + 1] = "Recent Cache Keys:"
                    local count = 0
                    for key, data in pairs(self.state.calculationCache) do
                        if count < 8 then -- Limit to first 8 entries
                            local age = currentTime - (data.timestamp or 0)
                            lines[#lines + 1] = string.format("  %s: %.2fs ago", string.sub(key, 1, 30), age)
                            count = count + 1
                        else
                            lines[#lines + 1] = string.format("  ... and %d more", cacheSize - 8)
                            break
                        end
                    end
                else
                    lines[#lines + 1] = "No cached entries"
                end

                return lines
            end
        },
        {
            header = "Spec Range Mappings",
            dataFn = function()
                local englishClass = NAG.CLASS_FILENAME
                local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

                local lines = {
                    string.format("Current Spec Index: %s", tostring(specIndex)),
                    string.format("Current Class: %s", englishClass or "Unknown"),
                    ""
                }

                -- Get all spec indices for current class
                local specIndices = {}
                if englishClass then
                    local classID = select(3, UnitClass("player"))
                    local classMap = {
                        WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
                        DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, MONK = 10, DRUID = 11
                    }
                    if not classID then
                        classID = classMap[englishClass]
                    end
                    if classID then
                        local numSpecs = SpecCompat:GetNumSpecsForClass(classID) or 4
                        for specIdx = 1, numSpecs do
                            local specInfo = SpecCompat:GetSpecInfo(specIdx)
                            if specInfo then
                                table.insert(specIndices, specIdx)
                            end
                        end
                    end
                end

                if #specIndices > 0 then
                    lines[#lines + 1] = "All Spec Ranges (for current class):"
                    for _, idx in ipairs(specIndices) do
                        local melee = self:GetSpecRange("melee", idx)
                        local ranged = self:GetSpecRange("ranged", idx)
                        local isCurrent = (idx == specIndex)
                        local marker = isCurrent and " [CURRENT]" or ""

                        lines[#lines + 1] = string.format("  Spec Index %d%s: %d/%d yards", idx, marker, melee, ranged)
                    end
                end

                -- Show class defaults
                lines[#lines + 1] = ""
                lines[#lines + 1] = "Class Defaults (when no spec):"
                local classMelee = self:GetSpecRange("melee")
                local classRanged = self:GetSpecRange("ranged")
                lines[#lines + 1] = string.format("  %s: %d/%d yards", englishClass or "Unknown", classMelee, classRanged)

                return lines
            end
        }
    }
end

--- Get debug controls for the debug frame
--- @return table Array of custom control configurations
function TTDManager:GetDebugControls()
    return {
        {
            type = "button",
            text = "Clear Cache",
            width = 100,
            onClick = function()
                self:ClearCalculationCache()
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Refresh TTD",
            width = 100,
            onClick = function()
                self:RefreshTTD()
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Test TTD",
            width = 100,
            onClick = function()
                if UnitExists("target") then
                    local targetGUID = UnitGUID("target")
                    if targetGUID then
                        local ttd = self:GetTTD(targetGUID, 3)
                        local ttdPercent = self:GetTimeToPercent(targetGUID, 50, 3)
                        self:Info("TTD Test Results:")
                        self:Info("  TTD (0%%): %.2f", ttd)
                        self:Info("  Time to 50%%: %.2f", ttdPercent)

                        if ttd == 8888 then
                            self:Warn("*** TTD returned 8888 - checking unit data ***")
                            local unitData = self.state.units[targetGUID]
                            if unitData then
                                self:Info("Unit data exists with %d samples", #(unitData.samples or {}))
                                if unitData.samples and #unitData.samples > 0 then
                                    for i, sample in ipairs(unitData.samples) do
                                        self:Info("  Sample %d: time=%.2f, health=%.1f%%", i, sample.time, sample.health)
                                    end
                                end
                            else
                                self:Warn("No unit data found for target GUID: %s", targetGUID)
                            end
                        end
                    end
                else
                    self:Warn("No target selected for TTD test")
                end
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "slider",
            label = "TTD Interval",
            min = 0.1,
            max = 2.0,
            step = 0.1,
            getValue = function() return self.state.userInterval or 0.75 end,
            setValue = function(value)
                self:UpdateUserInterval()
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end,
            width = 150
        },
        {
            type = "toggle",
            label = "Use Interaction Distance",
            getValue = function() return self.db.global.useInteractionDistance end,
            setValue = function(value)
                self.db.global.useInteractionDistance = value
                self:ClearCalculationCache() -- Clear cache when method changes
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end,
            width = 200
        },
        {
            type = "toggle",
            label = "Melee Fallback to Ranged",
            getValue = function() return self.db.global.meleeFallback end,
            setValue = function(value)
                self.db.global.meleeFallback = value
                self:ClearCalculationCache() -- Clear cache when setting changes
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end,
            width = 200
        },
        {
            type = "button",
            text = "Force Refresh",
            width = 100,
            onClick = function()
                -- Force a refresh by clearing cache and running RefreshTTD
                self:ClearCalculationCache()
                self.state.lastCalculationTime = 0 -- Force calculation
                self:RefreshTTD()
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        }
    }
end

--- Show the debug frame
function TTDManager:ShowDebugFrame()
    ns.DebugFrameUtil:ShowDebugFrame(self, {
        title = "TTDManager Debug - TTD System & Sample Analysis",
        sections = self:GetDebugSections(),
        customControls = self:GetDebugControls(),
        refreshInterval = 0.5, -- Update every 0.5 seconds for real-time monitoring
        width = 800,
        height = 700,
        savePosition = true,
        position = {
            point = "CENTER",
            relativePoint = "CENTER",
            x = 0,
            y = 0
        }
    })
end

-- ============================ TEMPORARY AOE OVERRIDE SYSTEM ============================

--- Toggle the temporary single target override
--- This forces all target counting to return 1, making rotations act as single target
--- @return boolean The new state of the override
function TTDManager:ToggleSingleTargetOverride()
    self.tempForceSingleTarget = not self.tempForceSingleTarget

    if self.tempForceSingleTarget then
        NAG:Print("|cff00ff00AoE Override: ENABLED|r - All rotations will act as single target")
        self:ShowOverrideIndicator()
    else
        NAG:Print("|cffff0000AoE Override: DISABLED|r - Rotations will use normal target counting")
        self:HideOverrideIndicator()
    end

    return self.tempForceSingleTarget
end

--- Set a custom target count override for testing
--- This forces all target counting to return the specified number
--- @param count number|nil The number of targets to simulate (nil to disable)
--- @param persistent boolean|nil Whether to save this setting persistently (default: false)
--- @return boolean True if override is active
function TTDManager:SetTargetCountOverride(count, persistent)
    if count == nil or count <= 0 then
        -- Disable override
        self.tempTargetCount = nil
        self.tempForceSingleTarget = false

        -- Clear persistent setting if requested
        if persistent then
            self.db.global.targetCountOverride = nil
        end

        NAG:Print("|cffff0000Target Count Override: DISABLED|r - Rotations will use normal target counting")
        self:HideOverrideIndicator()
        return false
    else
        -- Enable custom count override
        local clampedCount = math.max(1, math.min(20, count)) -- Clamp between 1-20
        self.tempTargetCount = clampedCount
        self.tempForceSingleTarget = false -- Disable single target override

        -- Save persistent setting if requested
        if persistent then
            self.db.global.targetCountOverride = clampedCount
        end

        NAG:Print(string.format("|cff00ff00Target Count Override: ENABLED|r - All rotations will act as %d targets", clampedCount))
        self:ShowOverrideIndicator()
        return true
    end
end

--- Get the current target count override value
--- @return number|nil The override count or nil if not active
function TTDManager:GetTargetCountOverride()
    return self.tempTargetCount
end

--- Check if any target count override is active
--- @return boolean True if any override is active
function TTDManager:IsTargetCountOverrideActive()
    return self.tempForceSingleTarget or (self.tempTargetCount ~= nil) or (self.db.global.targetCountOverride ~= nil)
end

--- Enable the temporary single target override
function TTDManager:EnableSingleTargetOverride()
    if not self.tempForceSingleTarget then
        self:ToggleSingleTargetOverride()
    end
end

--- Disable the temporary single target override
function TTDManager:DisableSingleTargetOverride()
    if self.tempForceSingleTarget then
        self:ToggleSingleTargetOverride()
    end
end

--- Check if the temporary single target override is active
--- @return boolean True if override is active
function TTDManager:IsSingleTargetOverrideActive()
    return self.tempForceSingleTarget or false
end

-- Cached table for GetEnemyUnitsInRange GUID dedupe (reused to avoid allocation)
local _enemyUnitsSeenGUIDs = {}

--- Count enemy units in range that pass optional predicates (unified enemy iteration).
--- Respects target count override and single-target override.
--- @param maxRange number Maximum range in yards (1-100)
--- @param options table|nil Optional: { debuffId = number, minTTD = number, customCheck = function(unit) }
--- @return number Count of enemy units in range passing all specified predicates
function TTDManager:GetEnemyUnitsInRange(maxRange, options)
    if not maxRange then return 0 end
    maxRange = min(max(1, maxRange), 100)
    options = options or {}

    -- Overrides
    if self:IsTargetCountOverrideActive() then
        local overrideCount = self.tempTargetCount or self.db.global.targetCountOverride
        if overrideCount then
            return overrideCount
        end
        if self:IsSingleTargetOverrideActive() then
            if UnitExists("target") and UnitCanAttack("player", "target") then
                local dist = RC and RC:GetRange("target", true)
                dist = dist or 999
                if dist <= maxRange then
                    if options.debuffId then
                        if not NAG.UnitDebuff or not NAG:UnitDebuff("target", options.debuffId) then
                            return 0
                        end
                    end
                    if options.minTTD then
                        local guid = UnitGUID("target")
                        if guid then
                            local ttd = self:GetTTD(guid, 3)
                            if not ttd or ttd <= options.minTTD then return 0 end
                        end
                    end
                    if options.customCheck and type(options.customCheck) == "function" then
                        if not options.customCheck("target") then return 0 end
                    end
                    return 1
                end
            end
            return 0
        end
    end

    wipe(_enemyUnitsSeenGUIDs)
    local count = 0
    local iterableUnits = ns.GetIterableUnits()
    if not iterableUnits then return 0 end

    local function passesPredicates(unit)
        if options.debuffId and NAG.UnitDebuff and not NAG:UnitDebuff(unit, options.debuffId) then
            return false
        end
        if options.minTTD then
            local guid = UnitGUID(unit)
            if guid then
                local ttd = self:GetTTD(guid, 3)
                if not ttd or ttd <= options.minTTD then return false end
            else
                return false
            end
        end
        if options.customCheck and type(options.customCheck) == "function" then
            if not options.customCheck(unit) then return false end
        end
        return true
    end

    for i = 1, #iterableUnits do
        local unit = iterableUnits[i]
        if UnitExists(unit) and (UnitCanAttack("player", unit) or (UnitName(unit) or ""):find("Training Dummy") or (UnitName(unit) or ""):find("Dummy")) then
            local guid = UnitGUID(unit)
            if guid and not _enemyUnitsSeenGUIDs[guid] then
                local distance = RC and RC:GetRange(unit, true)
                distance = distance or 999
                if distance <= maxRange then
                    _enemyUnitsSeenGUIDs[guid] = true
                    if passesPredicates(unit) then
                        count = count + 1
                    end
                end
            end
        end
    end

    return count
end

--- Show the visual override indicator
function TTDManager:ShowOverrideIndicator()
    if not self.overrideFrame then
        self:CreateOverrideIndicator()
    end
    if self.overrideFrame then
        -- Update text based on override type
        local overrideCount = self.tempTargetCount or self.db.global.targetCountOverride
        if overrideCount then
            self.overrideFrame.text:SetText(string.format("|cff00ff00TARGET COUNT: %d|r", overrideCount))
        else
            self.overrideFrame.text:SetText("|cffff0000AoE OVERRIDE ACTIVE|r")
        end

        self.overrideFrame:Show()
        -- Start auto-hide timer
        C_Timer.After(1, function()
            if self.overrideFrame and self.overrideFrame:IsShown() then
                self.overrideFrame:Hide()
            end
        end)
    end
end

--- Hide the visual override indicator
function TTDManager:HideOverrideIndicator()
    if self.overrideFrame then
        self.overrideFrame:Hide()
    end
end

--- Create the visual override indicator frame
function TTDManager:CreateOverrideIndicator()
    local frame = CreateFrame("Frame", "NAGAoEOverrideIndicator", UIParent)
    frame:SetSize(150, 30)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
    frame:SetFrameStrata("TOOLTIP")
    frame:SetFrameLevel(1000)

    -- Background
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0, 0, 0, 0.8)
    bg:SetVertexColor(1, 0, 0, 0.3) -- Red tint

    -- Border
    local border = frame:CreateTexture(nil, "BORDER")
    border:SetAllPoints()
    border:SetColorTexture(1, 0, 0, 1) -- Red border
    border:SetVertexColor(1, 0, 0, 1)

    -- Text
    local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("CENTER")
    text:SetText("|cffff0000AoE OVERRIDE ACTIVE|r")
    text:SetTextColor(1, 0, 0, 1)

    -- Store reference to text for dynamic updates
    frame.text = text

    -- Make it draggable
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    self.overrideFrame = frame
end

-- ============================ SLASH COMMAND HANDLERS ============================

--- Handle the /nagaoe slash command
--- @param input string The command input
function TTDManager:HandleAoECommand(input)
    if not input or input == "" then
        -- Toggle single target override when no arguments provided
        return self:ToggleSingleTargetOverride()
    end

    local trimmed = strlower(strtrim(input))

    -- Explicit toggle/on/off support (keeps compatibility with /nag aoe help)
    if trimmed == "toggle" then
        return self:ToggleSingleTargetOverride()
    elseif trimmed == "on" then
        -- Enable AoE (normal target counting)
        self:DisableSingleTargetOverride()
        NAG:Print("|cff00ff00AoE Mode: ENABLED|r - Using normal target counting")
        return
    elseif trimmed == "off" then
        -- Force single target
        self:EnableSingleTargetOverride()
        NAG:Print("|cffff0000AoE Mode: DISABLED|r - Forcing single target")
        return
    end

    -- Handle status command
    if trimmed == "status" then
        NAG:Print("|cff00ff00=== Target Count Override Status ===|r")

        -- Check temporary single target override
        if self.tempForceSingleTarget then
            NAG:Print("|cffff9900Temporary Single Target Override: ACTIVE|r")
        else
            NAG:Print("Temporary Single Target Override: inactive")
        end

        -- Check temporary target count override
        if self.tempTargetCount then
            NAG:Print(string.format("|cffff9900Temporary Target Count: %d|r", self.tempTargetCount))
        else
            NAG:Print("Temporary Target Count: none")
        end

        -- Check persistent target count override
        if self.db.global.targetCountOverride then
            NAG:Print(string.format("|cffff0000Persistent Target Count (SAVED): %d|r", self.db.global.targetCountOverride))
        else
            NAG:Print("Persistent Target Count: none")
        end

        -- Show what NAG:NumberTargets() would return
        local currentCount = self:GetTargetCount()
        NAG:Print(string.format("|cff00ff00Current Effective Target Count: %d|r", currentCount))

        return
    end

    if trimmed == "0" or trimmed == "reset" then
        -- Disable all overrides (including persistent saved ones)
        self:SetTargetCountOverride(nil, true) -- Pass true to clear persistent setting
        self:DisableSingleTargetOverride()

        if trimmed == "reset" then
            NAG:Print("|cff00ff00Target Count System: RESET|r - All overrides cleared (including saved settings)")
        end
    else
        -- Check for "save" parameter
        local parts = {strsplit(" ", trimmed)}
        local countStr = parts[1]
        local saveFlag = parts[2] == "save"

        -- Parse number
        local count = tonumber(countStr)
        if count and count > 0 then
            -- Disable single target override when setting custom count
            self:DisableSingleTargetOverride()
            self:SetTargetCountOverride(count, saveFlag)
        else
            NAG:Print("|cffff0000Invalid number. Use 1-20, 'off', 'reset', or 'status'.|r")
            NAG:Print("Usage: /nagaoe - Toggle single target override")
            NAG:Print("Usage: /nagaoe [number] - Set temporary target count override (1-20)")
            NAG:Print("Usage: /nagaoe [number] save - Set persistent target count override (saved across sessions)")
            NAG:Print("Usage: /nagaoe off - Disable all overrides")
            NAG:Print("Usage: /nagaoe reset - Reset system (clear all overrides including saved)")
            NAG:Print("Usage: /nagaoe status - Show current override status")
        end
    end
end
