--- @module "NAG.TrinketTrackingManager"
--- Manages trinket proc tracking and ICD learning.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- Debug Frame Improvements:
--- - Converted static data sections to dataFn functions for real-time updates
--- - Added comprehensive error handling to all custom renderer functions
--- - Enhanced input validation and graceful error display
--- - Improved data structure validation for robust rendering

-- ======= LOCALIZE =======
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
local WoWAPI = ns.WoWAPI
local GetItemSpell = C_Item and C_Item.GetItemSpell or _G.GetItemSpell
local GetItemCooldown = C_Container and C_Container.GetItemCooldown or _G.GetItemCooldown

-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DataManager
--- @type Types
--- @type StateManager
local DataManager, Types, StateManager

--- @type SpellTrackingManager
--- @type TrinketCommunicationManager
--- @type TooltipParser
local SpellTrackingManager, TrinketCommunicationManager, TooltipParser


--WoW API
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local GetInventoryItemID = _G.GetInventoryItemID

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame

local strlower = strlower
local tinsert = tinsert
local wipe = wipe


-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Trinket category constants
local TRINKET_CATEGORIES = {
    PURE_STATS = "PURE_STATS",     -- Stats only, no proc
    DEFENSIVE = "DEFENSIVE",       -- Defensive stats (Stamina, Dodge, Parry, etc.)
    HEALING = "HEALING",           -- Healing stats (Spirit, MP5)
    COMBAT = "COMBAT",             -- Combat stats (Str, Agi, Crit, Haste, etc.)
    UNKNOWN = "UNKNOWN"            -- Could not categorize
}

local defaults = {
}
--- @class TrinketTrackingManager: CoreModule
local TrinketTrackingManager = NAG:CreateModule("TrinketTrackingManager", defaults, {
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    defaultState = {
        trinketProcs = {}, -- Track trinket proc states
        trinketInfo = {}   -- Cache for analyzed trinket info
    },
    eventHandlers = {
        PLAYER_EQUIPMENT_CHANGED = true,
    },
    cleuHandlers = {
        SPELL_AURA_APPLIED = "HandleCLEUAuraApplied",
        SPELL_AURA_REMOVED = "HandleCLEUAuraRemoved",
    },
    messageHandlers = {
        NAG_STARTUP_COMPLETE = true,
    },

    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.TRACKERS
    }
})
local module = TrinketTrackingManager
ns.TrinketTrackingManager = TrinketTrackingManager -- Primary export
ns.TrinketTracker = TrinketTrackingManager         -- Backwards compatibility alias
ns.TRINKET_CATEGORIES = TRINKET_CATEGORIES         -- Export categories for external use


do -- Core functionality
    --- Initialize the TrinketTrackingManager module
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        DataManager = NAG:GetModule("DataManager")
        Types = NAG:GetModule("Types")
        SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        TrinketCommunicationManager = NAG:GetModule("TrinketCommunicationManager")
        TooltipParser = NAG:GetModule("TooltipParser")
        StateManager = NAG:GetModule("StateManager")

        -- Initialize static trinket stat mappings

        -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns

        -- Trinket info will be initialized in ModuleEnable when game data is available
    end

    --- Called when the module is enabled - now safe to access game data
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:ModuleEnable()
        -- Initialize trinket info for currently equipped trinkets
        -- This is safe to do here as the game is fully loaded

        -- ============================ MODULE INITIALIZATION ============================
        --self:InitializeEquippedTrinkets()
    end

    --- Called when the module is disabled - proper cache cleanup
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:ModuleDisable()
        -- Clear all caches

        if self.state then
            if self.state.trinketInfo then wipe(self.state.trinketInfo) end
            if self.state.units then wipe(self.state.units) end
            if self.state.cache then wipe(self.state.cache) end
        end

        -- Reset state
        self.state = {
            trinketInfo = {},
            units = {},
            cache = {},
            mobCount = 0,
            meleeMobCount = 0
        }
    end

    --- Called when startup is complete
    --- @param message string The message name
    function TrinketTrackingManager:NAG_STARTUP_COMPLETE(message)
        self:Debug("Startup complete - trinket tracking fully initialized")
    end

    --- Initialize trinket info for currently equipped trinkets
    function TrinketTrackingManager:InitializeEquippedTrinkets()
        local trinket1 = GetInventoryItemID("player", 13)
        local trinket2 = GetInventoryItemID("player", 14)

        -- Clear old trinket data that's no longer equipped
        for cachedItemId in pairs(self.state.trinketInfo) do
            if cachedItemId ~= trinket1 and cachedItemId ~= trinket2 then
                self.state.trinketInfo[cachedItemId] = nil
            end
        end

        -- Update info for currently equipped trinkets
        if trinket1 then
            self:AnalyzeTrinket(trinket1)
        end
        if trinket2 then
            self:AnalyzeTrinket(trinket2)
        end
    end
end


do -- Event Handlers
    --- Handle aura application
    --- @param self TrinketTrackingManager
    --- @param timestamp number
    --- @param subEvent string
    --- @param hideCaster boolean
    --- @param sourceGUID string|nil
    --- @param sourceName string|nil
    --- @param sourceFlags number|nil
    --- @param sourceRaidFlags number|nil
    --- @param destGUID string|nil
    --- @param destName string|nil
    --- @param destFlags number|nil
    --- @param destRaidFlags number|nil
    --- @param spellId number|nil
    function TrinketTrackingManager:HandleCLEUAuraApplied(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
        sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, arg13, arg14, arg15, arg16, arg17,
        arg18, arg19, arg20, arg21, arg22, arg23, arg24)
        if type(spellId) ~= "number" then
            return
        end
        -- Check if this is a trinket proc
        local trinket = self:GetTrinketByProcId(spellId)
        if trinket then
            self:UpdateTrinketProc(spellId, trinket.itemId, GetTime(), true)
        end
    end

    --- Handle aura removal
    --- @param self TrinketTrackingManager
    --- @param timestamp number
    --- @param subEvent string
    --- @param hideCaster boolean
    --- @param sourceGUID string|nil
    --- @param sourceName string|nil
    --- @param sourceFlags number|nil
    --- @param sourceRaidFlags number|nil
    --- @param destGUID string|nil
    --- @param destName string|nil
    --- @param destFlags number|nil
    --- @param destRaidFlags number|nil
    --- @param spellId number|nil
    function TrinketTrackingManager:HandleCLEUAuraRemoved(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
        sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, arg13, arg14, arg15, arg16, arg17,
        arg18, arg19, arg20, arg21, arg22, arg23, arg24)
        if type(spellId) ~= "number" then
            return
        end
        -- Update trinket proc duration if needed
        local procState = self.state.trinketProcs[spellId]
        if procState and not procState.duration then
            if procState.lastProcTime then
                local procDuration = GetTime() - procState.lastProcTime
                -- Round to nearest second for likely duration values
                procState.learnedDuration = math.floor(procDuration + 0.5)
                if self.debug then
                    self:Debug("Learned duration for trinket %d proc %d: %.1f seconds", procState.itemId,
                        spellId, procState.learnedDuration)
                end
            end
        end
    end
end

do -- State Management
    --- Get use cooldown info for a trinket slot (13 or 14)
    --- @param self TrinketTrackingManager
    --- @param slot number 13 or 14
    --- @return table|nil { itemId, remaining, ready, usable }
    function TrinketTrackingManager:GetUseCooldownForSlot(slot)
        if slot ~= 13 and slot ~= 14 then return nil end
        if type(GetInventoryItemID) ~= "function" or type(GetTime) ~= "function" then return nil end
        local itemId = GetInventoryItemID("player", slot)
        if not itemId then return nil end
        -- Prefer slot-based cooldown API for equipped items
        local start, duration, enable = nil, nil, nil
        if type(GetInventoryItemCooldown) == "function" then
            start, duration, enable = GetInventoryItemCooldown("player", slot)
        else
            -- Fallback to item-based cooldown if slot API unavailable
            start, duration = GetItemCooldown and GetItemCooldown(itemId)
            enable = 1
        end
        local remaining = 0
        if start and duration and duration > 0 then
            remaining = math.max(0, (start + duration) - GetTime())
        end
        -- For trinkets: ready iff duration == 0 (off cooldown). 'enable' is not a usable gate here.
        local ready = (duration == 0)
        local usable = ready
        return {
            itemId = itemId,
            remaining = remaining,
            ready = ready,
            usable = usable
        }
    end

    --- Get cached use cooldowns for both trinket slots
    --- @return table { [13]=info|nil, [14]=info|nil }
    function TrinketTrackingManager:GetUseCooldownsForEquipped()
        if type(GetTime) ~= "function" then return { [13] = nil, [14] = nil } end
        local now = GetTime()
        if not self._cooldownCache or (now - (self._cooldownCache.ts or 0)) > 0.2 then
            self._cooldownCache = {
                ts = now,
                data = {
                    [13] = self:GetUseCooldownForSlot(13),
                    [14] = self:GetUseCooldownForSlot(14)
                }
            }
        end
        return self._cooldownCache.data
    end

    --- Get trinket data by proc spell ID
    --- @param spellId number The proc spell ID to look up
    --- @return table|nil The trinket data if found
    function TrinketTrackingManager:GetTrinketByProcId(spellId)
        -- First check user-registered trinkets
        local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
        if TrinketRegistrationManager then
            local customTrinkets = TrinketRegistrationManager.db.global.customTrinkets
            if customTrinkets then
                for itemId, data in pairs(customTrinkets) do
                    if data.buffId == spellId then
                        -- Create a compatible trinket data structure
                        return {
                            itemId = itemId,
                            ICD = data.icd,
                            flags = { trinket = true },
                            spellId = data.buffId
                        }
                    end
                end
            end
        end

        -- Then check DataManager
        local relatedItems = DataManager:GetRelated(spellId, DataManager.EntityTypes.SPELL, DataManager.EntityTypes.ITEM)
        if not relatedItems then return nil end

        -- Find trinket that matches this proc
        for itemId, item in pairs(relatedItems) do
            if item.flags.trinket then
                return item
            end
        end
        return nil
    end

    --- Initialize proc state for a trinket if it doesn't exist
    --- @param spellId number The proc spell ID
    --- @return table The proc state
    function TrinketTrackingManager:InitializeProcState(spellId)
        if self.debug then self:Debug("Initializing proc state for trinket %d", spellId) end
        if not self.state.trinketProcs[spellId] then
            -- Create new proc state
            self.state.trinketProcs[spellId] = {
                procCount = 0,
                icd = nil,
                lastProcTime = nil
            }

            -- Try to get ICD from multiple sources
            local icdFound = false

            -- 1. Check DataManager first
            local trinket = self:GetTrinketByProcId(spellId)
            if trinket and trinket.ICD then
                self.state.trinketProcs[spellId].icd = trinket.ICD
                icdFound = true
            end

            -- 2. Check SpellTrackingManager (where StateManager registers ICDs via TooltipParser)
            if not icdFound then
                if SpellTrackingManager then
                    -- Get ICD data directly from SpellTrackingManager's state
                    local icdData = SpellTrackingManager.state.icdTracking[spellId]
                    if icdData and icdData.duration then
                        self.state.trinketProcs[spellId].icd = icdData.duration
                        icdFound = true
                        if self.debug then self:Debug("Found ICD in SpellTrackingManager for spell %d: %.1f seconds",
                                spellId, icdData.duration) end
                    end
                end
            end

            -- 3. Check user-registered trinkets as fallback
            if not icdFound then
                local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
                if TrinketRegistrationManager then
                    local customTrinkets = TrinketRegistrationManager:GetSetting("global", "customTrinkets")
                    if customTrinkets then
                        -- Search through custom trinkets to find one matching this buff ID
                        for _, data in pairs(customTrinkets) do
                            if data.buffId == spellId and data.icd then
                                self.state.trinketProcs[spellId].icd = data.icd
                                icdFound = true
                                break
                            end
                        end
                    end
                end
            end
        end
        return self.state.trinketProcs[spellId]
    end

    --- Update trinket proc state
    --- @param spellId number The proc spell ID
    --- @param itemId number The trinket item ID
    --- @param timestamp number Current timestamp
    --- @param isProc boolean Whether this is a new proc
    function TrinketTrackingManager:UpdateTrinketProc(spellId, itemId, timestamp, isProc)
        -- Initialize or get proc state
        local procState = self:InitializeProcState(spellId)

        if isProc then
            -- Update proc count and last proc time
            procState.procCount = procState.procCount + 1
            procState.lastProcTime = timestamp

            -- Debug output
            if self.debug then
                self:Debug("Trinket proc detected - Spell: %d, Item: %d, ICD: %.1f seconds", spellId,
                    itemId, procState.icd or 0)
            end
        end
    end

    --- Get trinket proc info
    --- @param spellId number The proc spell ID
    --- @return table|nil The proc state if found
    function TrinketTrackingManager:GetTrinketProcInfo(spellId)
        return self.state.trinketProcs[spellId]
    end

    --- Clean up old data
    --- @param self TrinketTrackingManager
    --- @param maxAge number
    function TrinketTrackingManager:CleanupOldData(maxAge)
        local currentTime = GetTime()
        maxAge = maxAge or 300 -- Default to 5 minutes

        -- Clean up trinket proc data
        for spellId, data in pairs(self.state.trinketProcs) do
            if data.lastProcTime and (currentTime - data.lastProcTime) > maxAge then
                self.state.trinketProcs[spellId] = nil
            end
        end
    end
end

do -- Trinket Analysis Functions
    --- Helper function to check if trinket has defensive stats
    --- @param trinketInfo table The trinket info to check
    --- @return boolean True if trinket has defensive stats
    local function isDefensiveEffect(trinketInfo)
        if not trinketInfo then return false end

        local Stat = Types:GetType("Stat")
        if not Stat then return false end

        -- Define defensive stats
        local defensiveStats = {
            [Stat.STAMINA] = true,
            [Stat.DODGE] = true,
            [Stat.PARRY] = true,
            [Stat.RESILIENCE] = true,
            [Stat.ARMOR] = true,
            [Stat.BONUS_ARMOR] = true
        }

        -- Check if any stat type matches defensive stats
        return defensiveStats[trinketInfo.statType1] or
               defensiveStats[trinketInfo.statType2] or
               defensiveStats[trinketInfo.statType3]
    end

    --- Helper function to check if trinket has healing stats
    --- @param trinketInfo table The trinket info to check
    --- @return boolean True if trinket has healing stats
    local function isHealingEffect(trinketInfo)
        if not trinketInfo then return false end

        local Stat = Types:GetType("Stat")
        if not Stat then return false end

        -- Define healing stats
        local healingStats = {
            [Stat.SPIRIT] = true,
            [Stat.MP5] = true
        }

        -- Check if any stat type matches healing stats
        return healingStats[trinketInfo.statType1] or
               healingStats[trinketInfo.statType2] or
               healingStats[trinketInfo.statType3]
    end

    --- Categorize trinket based on its stats and proc type
    --- @param trinketInfo table The trinket info to categorize
    --- @return string The trinket category
    local function categorizeTrinket(trinketInfo)
        if not trinketInfo then return TRINKET_CATEGORIES.UNKNOWN end

        -- Check if it's a pure stats trinket (no proc)
        if not trinketInfo.procType and
           (trinketInfo.statType1 ~= -1 or trinketInfo.statType2 ~= -1 or trinketInfo.statType3 ~= -1) then
            return TRINKET_CATEGORIES.PURE_STATS
        end

        -- If it has a proc, categorize by stat type
        if trinketInfo.procType then
            if isDefensiveEffect(trinketInfo) then
                return TRINKET_CATEGORIES.DEFENSIVE
            elseif isHealingEffect(trinketInfo) then
                return TRINKET_CATEGORIES.HEALING
            else
                return TRINKET_CATEGORIES.COMBAT
            end
        end

        return TRINKET_CATEGORIES.UNKNOWN
    end

    --- Analyzes a trinket and returns its information
    --- @param self TrinketTrackingManager
    --- @param itemId number The ID of the trinket to analyze
    --- @return table|nil Information about the trinket, or nil if analysis failed
    function TrinketTrackingManager:AnalyzeTrinket(itemId)
        if not itemId then return nil end

        if self.debug then self:Debug("Analyzing trinket %d", itemId) end

        local trinketInfo = {
            statType1 = -1,
            statType2 = -1,
            statType3 = -1,
            icd = 0,
            duration = 0,
            procChance = 0,
            procType = nil,
            buffId = nil,
            excludeICD = false,
            stacks = 0,
            excludeSwapping = false,
            isProc = false,
            isUse = false
        }

        -- First check if we have a TooltipParser to use
        --- @type TooltipParser
        if TooltipParser then
            if self.debug then self:Debug("TooltipParser available, analyzing trinket %d", itemId) end
            local tooltipInfo = TooltipParser:AnalyzeTrinket(itemId)
            if tooltipInfo then
                if self.debug then self:Debug("TooltipParser analysis successful for trinket %d", itemId) end
                -- Use tooltip parser data (only if we have complete data)
                if tooltipInfo.buffId and tooltipInfo.icd and tooltipInfo.duration then
                    trinketInfo.statType1 = tooltipInfo.statType1 or -1
                    trinketInfo.statType2 = tooltipInfo.statType2 or -1
                    trinketInfo.statType3 = tooltipInfo.statType3 or -1
                    trinketInfo.icd = tooltipInfo.icd
                    trinketInfo.duration = tooltipInfo.duration
                    trinketInfo.procChance = tooltipInfo.procChance or 0
                    trinketInfo.procType = tooltipInfo.procType
                    trinketInfo.buffId = tooltipInfo.buffId
                    trinketInfo.stacks = tooltipInfo.stacks or 0
                    trinketInfo.isProc = tooltipInfo.isProc or false
                    trinketInfo.isUse = tooltipInfo.isUse or false

                    -- Cache and return early only with complete data
                    self.state.trinketInfo[itemId] = trinketInfo
                    return {
                        trinketInfo = trinketInfo,
                        needsRegistration = false,
                        pendingData = false,
                        category = categorizeTrinket(trinketInfo)
                    }
                else
                    if self.debug then self:Debug(
                        "TooltipParser analysis incomplete for trinket %d, continuing to other sources", itemId) end
                end
            else
                if self.debug then self:Debug("TooltipParser analysis failed for trinket %d", itemId) end
            end
        else
            if self.debug then self:Debug("TooltipParser not available for trinket %d", itemId) end
        end

        -- First check for user-registered trinkets
        local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
        if TrinketRegistrationManager then
            if self.debug then self:Debug("Checking user-registered trinkets for item %d", itemId) end
            local customTrinkets = TrinketRegistrationManager:GetSetting("global", "customTrinkets")
            if customTrinkets and customTrinkets[itemId] then
                if self.debug then self:Debug("Found user-registered trinket %d", itemId) end
                local customData = customTrinkets[itemId]
                -- User-registered trinkets are considered complete data by definition
                trinketInfo.statType1 = customData.statType1 or -1
                trinketInfo.statType2 = customData.statType2 or -1
                trinketInfo.statType3 = customData.statType3 or -1
                trinketInfo.icd = customData.icd or 0
                trinketInfo.duration = customData.duration or 0
                trinketInfo.procChance = customData.procChance or 0
                trinketInfo.procType = customData.procType
                trinketInfo.buffId = customData.buffId
                trinketInfo.stacks = customData.maxStacks or 0
                trinketInfo.isProc = customData.procType == "proc"
                trinketInfo.isUse = customData.procType == "use"

                -- Cache and return
                self.state.trinketInfo[itemId] = trinketInfo
                return {
                    trinketInfo = trinketInfo,
                    needsRegistration = false,
                    pendingData = false,
                    category = categorizeTrinket(trinketInfo)
                }
            else
                if self.debug then self:Debug("Item %d not found in user-registered trinkets", itemId) end
            end
        else
            if self.debug then self:Debug("TrinketRegistrationManager not available for item %d", itemId) end
        end

        -- Note: Static database check removed - now using complete data from other sources
        -- Note: Structured data check moved to TooltipParser:AnalyzeTrinket() to avoid duplication

        -- Check DataManager for trinket with proc relationships (fallback)
        if DataManager then
            if self.debug then self:Debug("Checking DataManager for item %d", itemId) end
            local dmItem = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
            if dmItem and dmItem.flags and dmItem.flags.trinket then
                if self.debug then self:Debug("Found trinket %d in DataManager", itemId) end

                -- Get related spells and find the proc one
                local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM,
                    DataManager.EntityTypes.SPELL)
                if relatedSpells then
                    for spellId, spellData in pairs(relatedSpells) do
                        -- Look for proc relationship (this should be the procId)
                        if spellData.relationshipType == "proc" or (spellData.flags and spellData.flags.proc) then
                            trinketInfo.buffId = spellId -- This is actually the procId from the relationship
                            if spellData.ICD then
                                trinketInfo.icd = spellData.ICD
                            end
                            if spellData.duration then
                                trinketInfo.duration = spellData.duration
                            end
                            if spellData.stacks then
                                trinketInfo.stacks = spellData.stacks
                            end
                            trinketInfo.procType = "proc"
                            trinketInfo.isProc = true
                            trinketInfo.isUse = false

                            if self.debug then self:Debug("Using procId %d from DataManager for item %d", spellId, itemId) end
                            break
                        end
                    end
                end

                -- Try to get stat types from DataManager
                if dmItem.Stats then
                    local statCount = 0
                    for statType, _ in pairs(dmItem.Stats) do
                        statCount = statCount + 1
                        if statCount == 1 then
                            trinketInfo.statType1 = statType
                        elseif statCount == 2 then
                            trinketInfo.statType2 = statType
                        elseif statCount == 3 then
                            trinketInfo.statType3 = statType
                            break
                        end
                    end
                end

                -- Only return if we have complete data (buffId, icd, duration)
                if trinketInfo.buffId and trinketInfo.icd and trinketInfo.duration then
                    -- Cache and return
                    self.state.trinketInfo[itemId] = trinketInfo
                    return {
                        trinketInfo = trinketInfo,
                        needsRegistration = false,
                        pendingData = false,
                        category = categorizeTrinket(trinketInfo)
                    }
                else
                    if self.debug then self:Debug("DataManager data incomplete for item %d, continuing to other sources",
                            itemId) end
                end
            else
                if self.debug then self:Debug("Item %d not found in DataManager or not marked as trinket", itemId) end
            end
        else
            if self.debug then self:Debug("DataManager not available for item %d", itemId) end
        end


        --[[ Fallback: Try to analyze using legacy tooltip scanning
        if self.debug then self:Debug("Attempting legacy tooltip analysis for item %d", itemId) end
        local legacyInfo = self:AnalyzeTrinketLegacy(itemId)
        if legacyInfo then
            if self.debug then self:Debug("Legacy analysis successful for item %d", itemId) end
            -- Merge legacy info with our base structure
            for key, value in pairs(legacyInfo) do
                if value and value ~= 0 then
                    trinketInfo[key] = value
                end
            end

            -- If legacy parsing provided both spellId and procId information in
            -- its structure (via DataManager relationships), prefer using the
            -- procId as the active buff to track, since that is the aura the
            -- player receives when the trinket procs.
            if not trinketInfo.buffId and legacyInfo.procId then
                trinketInfo.buffId = legacyInfo.procId  -- Use procId as buffId (the aura applied to player)
            end

            -- Cache and return
            self.state.trinketInfo[itemId] = trinketInfo
            return trinketInfo
        else
            if self.debug then self:Debug("All analysis methods failed for item %d", itemId) end
        end
]]
        -- Final fallback: Only return data if we have BOTH buffId AND valid stat data
        -- Don't return partial data with only buffId but statType1=-1 (failed tooltip parsing)
        -- This prevents storing incomplete data that will need to be retried anyway
        if trinketInfo.buffId and trinketInfo.statType1 ~= -1 then
            if self.debug then self:Debug("Returning complete data for trinket %d", itemId) end
            -- Cache and return complete data
            self.state.trinketInfo[itemId] = trinketInfo
            return {
                trinketInfo = trinketInfo,
                needsRegistration = false,
                pendingData = false,
                category = categorizeTrinket(trinketInfo)
            }
        end

        -- If we get here, we couldn't analyze the trinket at all
        if self.debug then self:Debug("Failed to analyze trinket %d - no data sources available", itemId) end

        -- Return result indicating registration is needed
        return {
            trinketInfo = nil,
            needsRegistration = true,
            pendingData = false,
            category = TRINKET_CATEGORIES.UNKNOWN
        }
    end

    --- Legacy trinket analysis using tooltip scanning (fallback method)
    --- @param self TrinketTrackingManager
    --- @param itemId number The ID of the trinket to analyze
    --- @return table|nil Trinket information if analysis successful
    function TrinketTrackingManager:AnalyzeTrinketLegacy(itemId)
        if not itemId then return nil end

        if self.debug then self:Debug("Performing legacy tooltip analysis for item %d", itemId) end

        local data = {
            stats = {},
            procType = nil,
            buffId = nil,
            icd = 0,
            duration = 0,
            procChance = 0,
            stacks = 0
        }

        -- Check DataManager first for structured trinket data (like TooltipParsingManager)
        if DataManager then
            local trinketData = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
            if trinketData and trinketData.flags and trinketData.flags.trinket then
                -- Get related spells and find the proc one
                local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM,
                    DataManager.EntityTypes.SPELL)
                if relatedSpells then
                    for spellId, spellData in pairs(relatedSpells) do
                        -- Look for proc relationship (this should be the procId)
                        if spellData.relationshipType == "proc" or (spellData.flags and spellData.flags.proc) then
                            data.buffId = spellId -- This is actually the procId from the relationship
                            if spellData.ICD then
                                data.icd = spellData.ICD
                            end
                            if spellData.duration then
                                data.duration = spellData.duration
                            end
                            if spellData.stacks then
                                data.stacks = spellData.stacks
                            end
                            data.procType = "proc"

                            if self.debug then self:Debug("Legacy: Using procId %d from DataManager for item %d", spellId,
                                    itemId) end
                            break
                        end
                    end
                end

                -- Try to get stat types from DataManager
                if trinketData.Stats then
                    local statCount = 0
                    for statType, _ in pairs(trinketData.Stats) do
                        statCount = statCount + 1
                        if statCount == 1 then
                            data.statType1 = statType
                        elseif statCount == 2 then
                            data.statType2 = statType
                        elseif statCount == 3 then
                            data.statType3 = statType
                            break
                        end
                    end
                end
            end
        end

        -- Fallback: Check if this is a use trinket
        if not data.buffId then
            local itemSpellId = GetItemSpell(itemId)
            if itemSpellId then
                local spellInfo = WoWAPI.GetSpellInfo(itemSpellId)
                local itemSpellName = spellInfo and spellInfo.name
                if itemSpellName then
                    if self.debug then self:Debug("Found use trinket: %s (SpellID: %d)", itemSpellName, itemSpellId) end
                    data.procType = "use"
                    data.buffId = itemSpellId
                end
            end
        end

        -- Create scanning tooltip
        local scanningTooltip = CreateFrame("GameTooltip", "NAGScanningTooltip", nil, "GameTooltipTemplate")
        scanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

        -- Map of global strings to stat types using Types:GetType("Stat")
        local statKeywords = {}
        if Types then
            local statType = Types:GetType("Stat")
            if statType then
                statKeywords = {
                    [ITEM_MOD_STRENGTH_SHORT] = statType.STRENGTH,
                    [ITEM_MOD_AGILITY_SHORT] = statType.AGILITY,
                    [ITEM_MOD_STAMINA_SHORT] = statType.STAMINA,
                    [ITEM_MOD_INTELLECT_SHORT] = statType.INTELLECT,
                    [ITEM_MOD_SPIRIT_SHORT] = statType.SPIRIT,
                    [ITEM_MOD_HIT_RATING_SHORT] = statType.HIT,
                    [ITEM_MOD_CRIT_RATING_SHORT] = statType.CRIT,
                    [ITEM_MOD_HASTE_RATING_SHORT] = statType.HASTE,
                    [ITEM_MOD_EXPERTISE_RATING_SHORT] = statType.EXPERTISE,
                    [ITEM_MOD_DODGE_RATING_SHORT] = statType.DODGE,
                    [ITEM_MOD_PARRY_RATING_SHORT] = statType.PARRY,
                    [ITEM_MOD_MASTERY_RATING_SHORT] = statType.MASTERY,
                    [ITEM_MOD_ATTACK_POWER_SHORT] = statType.ATTACK_POWER,
                    [ITEM_MOD_RANGED_ATTACK_POWER_SHORT] = statType.RANGED_ATTACK_POWER,
                    [ITEM_MOD_SPELL_POWER_SHORT] = statType.SPELL_POWER,
                    [ITEM_MOD_SPELL_PENETRATION_SHORT] = statType.SPELL_PENETRATION,
                    [ITEM_MOD_RESILIENCE_RATING_SHORT] = statType.RESILIENCE,
                    [RESISTANCE6_NAME] = statType.ARCANE_RESISTANCE,
                    [RESISTANCE2_NAME] = statType.FIRE_RESISTANCE,
                    [RESISTANCE4_NAME] = statType.FROST_RESISTANCE,
                    [RESISTANCE3_NAME] = statType.NATURE_RESISTANCE,
                    [RESISTANCE5_NAME] = statType.SHADOW_RESISTANCE,
                    [ITEM_MOD_HEALTH] = statType.HEALTH,
                    [ITEM_MOD_MANA] = statType.MANA,
                    [ITEM_MOD_MANA_REGENERATION] = statType.MP5
                }
            end
        end

        -- Scan tooltip
        scanningTooltip:ClearLines()
        scanningTooltip:SetHyperlink("item:" .. itemId)

        for i = 1, scanningTooltip:NumLines() do
            local line = _G["NAGScanningTooltipTextLeft" .. i]:GetText()
            if not line then break end
            line = line:lower()

            -- Check for proc triggers and equip procs
            local isProcLine = line:match("^" .. ITEM_SPELL_TRIGGER_ONPROC:lower()) or
                (line:match("^" .. ITEM_SPELL_TRIGGER_ONEQUIP:lower()) and
                    (line:find("chance") or
                        line:find("proc") or
                        line:match("when you") or
                        line:match("each time")))

            if isProcLine then
                data.procType = line:match("^" .. ITEM_SPELL_TRIGGER_ONPROC:lower()) and "proc" or "equip"

                -- Look for proc chance
                local chance = line:match("(%d+)%%%s*" .. GARRISON_MISSION_CHANCE:lower())
                if chance then
                    data.procChance = tonumber(chance)
                end

                -- Look for stacks
                local stacks = self:FindStacks(line)
                if stacks then
                    data.stacks = tonumber(stacks)
                end

                -- Look for cooldown
                local cooldown = self:FindCooldown(line)
                if cooldown > 0 then
                    data.icd = cooldown
                end

                -- Look for duration
                local durValue, durUnit = self:FindDuration(line)
                if durValue then
                    data.duration = self:ParseTimeToSeconds(durValue, durUnit)
                end
            end

            -- Scan for stats (only if not a static equip effect)
            if not line:match("^" .. ITEM_SPELL_TRIGGER_ONEQUIP:lower()) or isProcLine then
                for keyword, statType in pairs(statKeywords) do
                    local pattern = keyword:lower():gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1")
                    if line:find(pattern) then
                        table.insert(data.stats, statType)
                    end
                end
            end
        end

        -- Clean up tooltip
        scanningTooltip:Hide()
        scanningTooltip:SetOwner(nil, "ANCHOR_NONE")

        -- Check if we found any useful information
        if data.procType or #data.stats > 0 or data.buffId then
            if self.debug then self:Debug("Legacy analysis successful for item %d", itemId) end
            return data
        else
            if self.debug then self:Debug("Legacy analysis failed for item %d - no useful information found", itemId) end
            return nil
        end
    end

    --- Updates information for equipped trinkets
    --- @param self TrinketTrackingManager
    --- @param event string The event name
    --- @param equipmentSlot number The equipment slot that changed
    --- @param hasCurrent boolean Whether the slot has a current item
    function TrinketTrackingManager:PLAYER_EQUIPMENT_CHANGED(event, equipmentSlot, hasCurrent)
        local trinket1 = GetInventoryItemID("player", 13)
        local trinket2 = GetInventoryItemID("player", 14)

        -- Clear old trinket data that's no longer equipped
        for cachedItemId in pairs(self.state.trinketInfo) do
            if cachedItemId ~= trinket1 and cachedItemId ~= trinket2 then
                self.state.trinketInfo[cachedItemId] = nil
            end
        end

        -- Update info for currently equipped trinkets
        if trinket1 then
            self:AnalyzeTrinket(trinket1)
        end
        if trinket2 then
            self:AnalyzeTrinket(trinket2)
        end
    end

    --- Gets cached trinket information
    --- @param self TrinketTrackingManager
    --- @param itemId number The ID of the trinket
    --- @return table|nil The trinket information if found
    function TrinketTrackingManager:GetTrinketInfo(itemId)
        return self.state.trinketInfo[itemId]
    end

end

--- Get remaining internal cooldown for a trinket proc
--- @param spellId number The proc spell ID
--- @return number|nil The remaining ICD time in seconds, or nil if no ICD is active
function TrinketTrackingManager:GetInternalCooldownRemaining(spellId)
    -- Initialize or get proc state
    local procState = self:InitializeProcState(spellId)

    -- If we have a last proc time and an ICD, calculate remaining time
    if procState.lastProcTime and procState.icd then
        local currentTime = GetTime()
        local timeSinceLastProc = currentTime - procState.lastProcTime
        local remaining = procState.icd - timeSinceLastProc
        return remaining > 0 and remaining or 0
    end

    -- If we have an ICD but no proc yet, return 0
    if procState.icd then
        return 0
    end

    return nil
end

do -- Legacy Tooltip Scanning Functions - Kept for backward compatibility
    --- Helper function to convert time text to seconds
    local function parseTimeToSeconds(value, unit)
        if not value or not unit then return 0 end
        unit = unit:lower()
        if unit:find("min") then
            return value * 60
        end
        return value
    end

    --- Helper function to find stacks in text
    --- @param self TrinketTrackingManager
    --- @param text string The text to search for stacks
    --- @return number|nil The number of stacks found
    function TrinketTrackingManager:FindStacks(text)
        if not text then return nil end
        local stacks = text:match("(%d+)%s*stacks?") or text:match("stacking%s+.*?(%d+)")
        if stacks then
            return tonumber(stacks)
        end
        return nil
    end

    --- Helper function to find duration in text
    --- @param self TrinketTrackingManager
    --- @param text string The text to search for duration
    --- @return number, string|nil The duration value and unit
    function TrinketTrackingManager:FindDuration(text)
        if not text then return 0, nil end
        -- Remove percent-bearing numbers first so we don't confuse proc chance
        -- (e.g., "20% chance") with time values
        text = string.lower(text)
        text = string.gsub(text, "%d+%%%s*", "")
        -- Look for standard duration patterns using global strings
        local durationPatterns = {
            SPELL_DURATION:gsub("%%s", "%((%d+%.?%d*)%s*([^%)]+)%)"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"), -- "Duration: %s"
            "(%d+%.?%d*)%s*([^%s]+)%s*" ..
            SPELL_DURATION:gsub("%%s", ""):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"),                           -- "X sec duration"
            "for%s*(%d+%.?%d*)%s*([^%s']+)"                                                                          -- "for X sec"
        }

        for i, pattern in ipairs(durationPatterns) do
            local value, unit = text:match(pattern)
            if value then
                return tonumber(value), unit
            end
        end

        return 0, nil
    end

    --- Helper function to parse time text to seconds
    --- @param self TrinketTrackingManager
    --- @param value number The time value
    --- @param unit string The time unit
    --- @return number The time in seconds
    function TrinketTrackingManager:ParseTimeToSeconds(value, unit)
        if not value or not unit then return 0 end
        unit = unit:lower()
        if unit:find("min") then
            return value * 60
        end
        return value
    end

    --- Helper function to find cooldown text using global strings
    --- @param self TrinketTrackingManager
    --- @param text string The text to search for cooldown
    --- @return number The cooldown in seconds
    function TrinketTrackingManager:FindCooldown(text)
        if not text then return 0 end

        -- Normalize and remove percent-bearing numbers so only time values remain
        text = string.lower(text)
        text = string.gsub(text, "%d+%%%s*", "")

        -- Create patterns from global strings, escaping special characters
        local cooldownPatterns = {}

        -- Add minute pattern
        if ITEM_COOLDOWN_TOTAL_MIN then
            local minPattern = ITEM_COOLDOWN_TOTAL_MIN:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"):gsub("%%d",
                "(%%d+)")
            table.insert(cooldownPatterns, minPattern)
        end

        -- Add second pattern
        if ITEM_COOLDOWN_TOTAL_SEC then
            local secPattern = ITEM_COOLDOWN_TOTAL_SEC:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"):gsub("%%d",
                "(%%d+)")
            table.insert(cooldownPatterns, secPattern)
        end

        -- Try each pattern
        for i, pattern in ipairs(cooldownPatterns) do
            if pattern then
                if type(pattern) == "string" then
                    local value = text:match(strlower(pattern))
                    if value then
                        local number = tonumber(value)
                        if number then
                            if i == 1 then
                                return number * 60
                            end
                            return number
                        end
                    end
                end
            end
        end

        -- Fallback for generic cooldown pattern
        if ITEM_COOLDOWN_TOTAL then
            local genericPattern = ITEM_COOLDOWN_TOTAL:gsub("%%s", "(.*)"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])",
                "%%%1")
            local cooldownText = text:match(genericPattern:lower())
            if cooldownText then
                local value, unit = cooldownText:match("(%d+%.?%d*)%s*([^%)]+)")
                if value and unit then
                    return self:ParseTimeToSeconds(tonumber(value), unit)
                end
            end
        end

        return 0
    end

    --- Scans an item's tooltip for proc effects and stats (legacy method)
    --- @param self TrinketTrackingManager
    --- @param itemId number The ID of the item to scan
    --- @return table|nil Information about procs and stats found
    function TrinketTrackingManager:ScanTooltipData(itemId)
        if not itemId then return nil end
        if TooltipParser then
            return TooltipParser:ParseItemTooltip(itemId)
        end

        -- Legacy implementation for backward compatibility
        local data = {
            stats = {},
            procType = nil,
            icd = 0,
            duration = 0,
            procChance = 0,
            stacks = 0,
            multipliers = {}
        }

        -- First check if it's a use trinket
        -- GetItemSpell returns multiple values: (spellName, spellID)
        local itemSpellName, itemSpellId = GetItemSpell(itemId)
        if itemSpellName then
            if self.debug then
                self:Debug("Found use trinket: " .. itemSpellName .. " (SpellID: " .. tostring(itemSpellId) .. ")")
            end
            data.procType = "use"
            data.buffId = itemSpellId
        end

        -- Create scanning tooltip
        local scanningTooltip = CreateFrame("GameTooltip", "NAGScanningTooltip", nil, "GameTooltipTemplate")
        scanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

        -- Map of global strings to stat types using Types:GetType("Stat")
        local statKeywords = {
            [ITEM_MOD_STRENGTH_SHORT] = Types:GetType("Stat").STRENGTH,
            [ITEM_MOD_AGILITY_SHORT] = Types:GetType("Stat").AGILITY,
            [ITEM_MOD_STAMINA_SHORT] = Types:GetType("Stat").STAMINA,
            [ITEM_MOD_INTELLECT_SHORT] = Types:GetType("Stat").INTELLECT,
            [ITEM_MOD_SPIRIT_SHORT] = Types:GetType("Stat").SPIRIT,
            [ITEM_MOD_HIT_RATING_SHORT] = Types:GetType("Stat").HIT,
            [ITEM_MOD_CRIT_RATING_SHORT] = Types:GetType("Stat").CRIT,
            [ITEM_MOD_HASTE_RATING_SHORT] = Types:GetType("Stat").HASTE,
            [ITEM_MOD_EXPERTISE_RATING_SHORT] = Types:GetType("Stat").EXPERTISE,
            [ITEM_MOD_DODGE_RATING_SHORT] = Types:GetType("Stat").DODGE,
            [ITEM_MOD_PARRY_RATING_SHORT] = Types:GetType("Stat").PARRY,
            [ITEM_MOD_MASTERY_RATING_SHORT] = Types:GetType("Stat").MASTERY,
            [ITEM_MOD_ATTACK_POWER_SHORT] = Types:GetType("Stat").ATTACK_POWER,
            [ITEM_MOD_RANGED_ATTACK_POWER_SHORT] = Types:GetType("Stat").RANGED_ATTACK_POWER,
            [ITEM_MOD_SPELL_POWER_SHORT] = Types:GetType("Stat").SPELL_POWER,
            [ITEM_MOD_SPELL_PENETRATION_SHORT] = Types:GetType("Stat").SPELL_PENETRATION,
            [ITEM_MOD_RESILIENCE_RATING_SHORT] = Types:GetType("Stat").RESILIENCE,
            [RESISTANCE6_NAME] = Types:GetType("Stat").ARCANE_RESISTANCE,
            [RESISTANCE2_NAME] = Types:GetType("Stat").FIRE_RESISTANCE,
            [RESISTANCE4_NAME] = Types:GetType("Stat").FROST_RESISTANCE,
            [RESISTANCE3_NAME] = Types:GetType("Stat").NATURE_RESISTANCE,
            [RESISTANCE5_NAME] = Types:GetType("Stat").SHADOW_RESISTANCE,
            [ITEM_MOD_HEALTH] = Types:GetType("Stat").HEALTH,
            [ITEM_MOD_MANA] = Types:GetType("Stat").MANA,
            [ITEM_MOD_MANA_REGENERATION] = Types:GetType("Stat").MP5
        }

        -- Scan tooltip
        scanningTooltip:ClearLines()
        scanningTooltip:SetHyperlink("item:" .. itemId)

        for i = 1, scanningTooltip:NumLines() do
            local line = _G["NAGScanningTooltipTextLeft" .. i]:GetText()
            if not line then break end
            line = line:lower()

            -- Check for proc triggers and equip procs
            local isProcLine = line:match("^" .. ITEM_SPELL_TRIGGER_ONPROC:lower()) or
                (line:match("^" .. ITEM_SPELL_TRIGGER_ONEQUIP:lower()) and
                    (line:find("chance") or
                        line:find("proc") or
                        line:match("when you") or
                        line:match("each time")))

            if isProcLine then
                data.procType = line:match("^" .. ITEM_SPELL_TRIGGER_ONPROC:lower()) and "proc" or "equip"

                -- Look for proc chance
                local chance = line:match("(%d+)%%%s*" .. GARRISON_MISSION_CHANCE:lower())
                if chance then
                    data.procChance = tonumber(chance)
                end

                -- Look for stacks
                local stacks = findStacks(line)
                if stacks then
                    data.stacks = tonumber(stacks)
                end

                -- Look for cooldown
                local cooldown = findCooldown(line)
                if cooldown > 0 then
                    data.icd = cooldown
                end

                -- Look for duration
                local durValue, durUnit = findDuration(line)
                if durValue then
                    data.duration = parseTimeToSeconds(durValue, durUnit)
                end
            end

            -- Scan for stats (only if not a static equip effect)
            if not line:match("^" .. ITEM_SPELL_TRIGGER_ONEQUIP:lower()) or isProcLine then
                for keyword, statType in pairs(statKeywords) do
                    local pattern = keyword:lower():gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1")
                    if line:find(pattern) then
                        tinsert(data.stats, statType)
                    end
                end
            end
        end

        return data
    end
end

-- ============================ DEBUG FUNCTIONS ============================
--- Show the trinket tracking debug frame for debugging trinket proc handling
--- @param self TrinketTrackingManager
function TrinketTrackingManager:ShowDebugFrame()
    local DebugFrameUtil = ns.DebugFrameUtil
    if DebugFrameUtil then
        DebugFrameUtil:ShowDebugFrame(self, {
            title = "Trinket Tracking Debug - Item Proc System",
            width = 1000,
            height = 800,
            refreshInterval = 1.0,
            autoRefresh = true,
            showTimerControls = true,

            -- Enhanced custom controls
            customControls = self:GetTrinketDebugControls(),

            -- Custom section type renderers
            customSectionTypes = self:GetTrinketDebugSectionTypes(),

            -- Enhanced sections
            sections = self:GetTrinketDebugSections()
        })
    else
        self:Error("DebugFrameUtil not available - cannot show debug frame")
    end
end

--- Get custom controls for trinket debug frame
--- @return table Array of custom control configurations
function TrinketTrackingManager:GetTrinketDebugControls()
    return {
        {
            type = "button",
            text = "Test Trinket Functions",
            width = 200,
            onClick = function() self:TestTrinketFunctions() end
        },
        {
            type = "button",
            text = "Simulate Trinket Proc",
            width = 200,
            onClick = function() self:SimulateTrinketProc() end
        }
    }
end

--- Get custom section type renderers for trinket debug frame
--- @return table Map of custom section types to renderer functions
function TrinketTrackingManager:GetTrinketDebugSectionTypes()
    return {
        ["trinket_analysis"] = function(section, scroll, module)
            -- Get the data for this section (support both static data and dataFn)
            local sectionData = section.dataFn and section.dataFn(module) or section.data
            return module:RenderTrinketAnalysis(sectionData, scroll)
        end,
        ["proc_states"] = function(section, scroll, module)
            -- Get the data for this section (support both static data and dataFn)
            local sectionData = section.dataFn and section.dataFn(module) or section.data
            return module:RenderProcStates(sectionData, scroll)
        end,
        ["active_auras"] = function(section, scroll, module)
            -- Get the data for this section (support both static data and dataFn)
            local sectionData = section.dataFn and section.dataFn(module) or section.data
            return module:RenderActiveAuras(sectionData, scroll)
        end,
        ["custom_trinkets"] = function(section, scroll, module)
            -- Get the data for this section (support both static data and dataFn)
            local sectionData = section.dataFn and section.dataFn(module) or section.data
            return module:RenderCustomTrinkets(sectionData, scroll)
        end
    }
end

--- Get enhanced debug sections for trinket debug frame
--- @return table Array of debug section configurations
function TrinketTrackingManager:GetTrinketDebugSections()
    return {
        {
            header = "Equipped Trinkets",
            dataFn = function()
                local lines = {}
                local trinket1 = GetInventoryItemID("player", 13)
                local trinket2 = GetInventoryItemID("player", 14)

                table.insert(lines, "Trinket Slot 1 (13): " .. (trinket1 or "None"))
                table.insert(lines, "Trinket Slot 2 (14): " .. (trinket2 or "None"))
                return lines
            end
        },
        {
            header = "Trinket Analysis",
            type = "custom",
            customType = "trinket_analysis",
            dataFn = function()
                return { trinket1 = GetInventoryItemID("player", 13), trinket2 = GetInventoryItemID("player", 14) }
            end
        },
        {
            header = "Custom Trinket Registrations",
            type = "custom",
            customType = "custom_trinkets",
            dataFn = function()
                return self:GetCustomTrinketData()
            end
        },
        {
            header = "Trinket Proc States",
            type = "custom",
            customType = "proc_states",
            dataFn = function()
                return self.state and self.state.trinketProcs
            end
        },
        {
            header = "Active Trinket Auras",
            type = "custom",
            customType = "active_auras",
            dataFn = function()
                return self:GetActiveAuraData()
            end
        },
        {
            header = "Trinket Function Testing",
            dataFn = function()
                local lines = {}

                -- Test AllTrinketStatProcsActive
                if NAG.AllTrinketStatProcsActive then
                    local anyStatActive = NAG:AllTrinketStatProcsActive(-1)
                    table.insert(lines, "AllTrinketStatProcsActive(ANY): " .. tostring(anyStatActive))
                else
                    table.insert(lines, "AllTrinketStatProcsActive: Function not available")
                end

                -- Test AnyTrinketStatProcsActive
                if NAG.AnyTrinketStatProcsActive then
                    local anyStatActive = NAG:AnyTrinketStatProcsActive(-1)
                    table.insert(lines, "AnyTrinketStatProcsActive(ANY): " .. tostring(anyStatActive))
                else
                    table.insert(lines, "AnyTrinketStatProcsActive: Function not available")
                end

                -- Test TrinketProcsMinRemainingTime
                if NAG.TrinketProcsMinRemainingTime then
                    local anyStatTime = NAG:TrinketProcsMinRemainingTime(-1)
                    table.insert(lines, "TrinketProcsMinRemainingTime(ANY): " .. string.format("%.1fs", anyStatTime))
                else
                    table.insert(lines, "TrinketProcsMinRemainingTime: Function not available")
                end

                -- Test TrinketProcsMaxRemainingICD
                if NAG.TrinketProcsMaxRemainingICD then
                    local anyStatIcd = NAG:TrinketProcsMaxRemainingICD(-1)
                    table.insert(lines, "TrinketProcsMaxRemainingICD(ANY): " .. string.format("%.1fs", anyStatIcd))
                else
                    table.insert(lines, "TrinketProcsMaxRemainingICD: Function not available")
                end

                -- Test NumEquippedStatProcTrinkets
                if NAG.NumEquippedStatProcTrinkets then
                    local anyStatCount = NAG:NumEquippedStatProcTrinkets(-1)
                    table.insert(lines, "NumEquippedStatProcTrinkets(ANY): " .. tostring(anyStatCount))
                else
                    table.insert(lines, "NumEquippedStatProcTrinkets: Function not available")
                end

                return lines
            end
        },
        {
            header = "System Status",
            dataFn = function()

                local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
                return {
                    "TrinketTrackingManager Loaded: Yes",
                    "TrinketRegistrationManager Loaded: " .. ("Yes" or "No"),
                    "TrinketCommunicationManager Loaded: " .. ("Yes" or "No"),
                    "StateManager Loaded: " .. ("Yes" or "No"),
                    "Types Module Loaded: " .. ("Yes" or "No")
                }
            end
        }
    }
end

--- Get custom trinket data for debug display
--- @return table Custom trinket data
function TrinketTrackingManager:GetCustomTrinketData()
    if TrinketCommunicationManager then
        return TrinketCommunicationManager.db.global.customTrinkets
    end
    return {}
end

--- Get active aura data for debug display
--- @return table Active aura data
function TrinketTrackingManager:GetActiveAuraData()
    local activeAuras = {}
    local trinket1 = GetInventoryItemID("player", 13)
    local trinket2 = GetInventoryItemID("player", 14)

    -- Check equipped trinket auras
    if trinket1 then
        local trinketInfo = self:GetTrinketInfo(trinket1)
        if trinketInfo and trinketInfo.buffId then
            local aura = NAG:UnitAura("player", trinketInfo.buffId)
            if aura and aura.expirationTime then
                local remainingTime = aura.expirationTime - GetTime()
                if remainingTime > 0 then
                    table.insert(activeAuras, {
                        source = string.format("Trinket 1 (%d)", trinket1),
                        name = aura.name,
                        stacks = aura.count or 1,
                        remaining = string.format("%.1fs", remainingTime),
                        status = "Active"
                    })
                end
            end
        end
    end

    if trinket2 then
        local trinketInfo = self:GetTrinketInfo(trinket2)
        if trinketInfo and trinketInfo.buffId then
            local aura = NAG:UnitAura("player", trinketInfo.buffId)
            if aura and aura.expirationTime then
                local remainingTime = aura.expirationTime - GetTime()
                if remainingTime > 0 then
                    table.insert(activeAuras, {
                        source = string.format("Trinket 2 (%d)", trinket2),
                        name = aura.name,
                        stacks = aura.count or 1,
                        remaining = string.format("%.1fs", remainingTime),
                        status = "Active"
                    })
                end
            end
        end
    end

    -- Check custom trinket auras
    if TrinketCommunicationManager then
        local customTrinkets = TrinketCommunicationManager.db.global.customTrinkets
        if customTrinkets then
            for itemId, data in pairs(customTrinkets) do
                if data.buffId then
                    local aura = NAG:UnitAura("player", data.buffId)
                    if aura and aura.expirationTime then
                        local remainingTime = aura.expirationTime - GetTime()
                        if remainingTime > 0 then
                            table.insert(activeAuras, {
                                source = string.format("Custom (%d)", itemId),
                                name = aura.name,
                                stacks = aura.count or 1,
                                remaining = string.format("%.1fs", remainingTime),
                                status = "Active"
                            })
                        end
                    end
                end
            end
        end
    end

    return activeAuras
end

--- Render trinket analysis section
--- @param data table Trinket data to analyze
--- @param scroll table The scroll frame to add widgets to
--- @return table|nil The created widget or nil
function TrinketTrackingManager:RenderTrinketAnalysis(data, scroll)
    -- Validate inputs
    if not scroll then
        self:Warn("RenderTrinketAnalysis: scroll parameter is nil")
        return nil
    end

    if not data then
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No trinket data available")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    -- Validate data structure
    if type(data) ~= "table" then
        local errorLabel = ns.AceGUI:Create("Label")
        errorLabel:SetText("Invalid trinket data format")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return errorLabel
    end

    -- Analyze trinket 1
    if data.trinket1 then
        local trinket1Header = ns.AceGUI:Create("Heading")
        trinket1Header:SetText("Trinket 1 Analysis")
        trinket1Header:SetFullWidth(true)
        scroll:AddChild(trinket1Header)

        local trinketInfo = self:GetTrinketInfo(data.trinket1)
        if trinketInfo then
            local infoGroup = ns.AceGUI:Create("SimpleGroup")
            infoGroup:SetLayout("Flow")
            infoGroup:SetFullWidth(true)

            local statType1Label = ns.AceGUI:Create("Label")
            statType1Label:SetText("Stat Type 1: " .. tostring(trinketInfo.statType1 or "None"))
            statType1Label:SetWidth(200)
            infoGroup:AddChild(statType1Label)

            local statType2Label = ns.AceGUI:Create("Label")
            statType2Label:SetText("Stat Type 2: " .. tostring(trinketInfo.statType2 or "None"))
            statType2Label:SetWidth(200)
            infoGroup:AddChild(statType2Label)

            local statType3Label = ns.AceGUI:Create("Label")
            statType3Label:SetText("Stat Type 3: " .. tostring(trinketInfo.statType3 or "None"))
            statType3Label:SetWidth(200)
            infoGroup:AddChild(statType3Label)

            local icdLabel = ns.AceGUI:Create("Label")
            icdLabel:SetText("ICD: " .. string.format("%.1fs", trinketInfo.icd or 0))
            icdLabel:SetWidth(200)
            infoGroup:AddChild(icdLabel)

            local durationLabel = ns.AceGUI:Create("Label")
            durationLabel:SetText("Duration: " .. string.format("%.1fs", trinketInfo.duration or 0))
            durationLabel:SetWidth(200)
            infoGroup:AddChild(durationLabel)

            local procTypeLabel = ns.AceGUI:Create("Label")
            procTypeLabel:SetText("Proc Type: " .. tostring(trinketInfo.procType or "None"))
            procTypeLabel:SetWidth(200)
            infoGroup:AddChild(procTypeLabel)

            local buffIdLabel = ns.AceGUI:Create("Label")
            buffIdLabel:SetText("Buff ID: " .. tostring(trinketInfo.buffId or "None"))
            buffIdLabel:SetWidth(200)
            infoGroup:AddChild(buffIdLabel)

            local stacksLabel = ns.AceGUI:Create("Label")
            stacksLabel:SetText("Max Stacks: " .. tostring(trinketInfo.stacks or "None"))
            stacksLabel:SetWidth(200)
            infoGroup:AddChild(stacksLabel)

            scroll:AddChild(infoGroup)
        else
            local errorLabel = ns.AceGUI:Create("Label")
            errorLabel:SetText("Failed to analyze trinket")
            errorLabel:SetFullWidth(true)
            scroll:AddChild(errorLabel)
        end
    end

    -- Analyze trinket 2
    if data.trinket2 then
        local trinket2Header = ns.AceGUI:Create("Heading")
        trinket2Header:SetText("Trinket 2 Analysis")
        trinket2Header:SetFullWidth(true)
        scroll:AddChild(trinket2Header)

        local trinketInfo = self:GetTrinketInfo(data.trinket2)
        if trinketInfo then
            local infoGroup = ns.AceGUI:Create("SimpleGroup")
            infoGroup:SetLayout("Flow")
            infoGroup:SetFullWidth(true)

            local statType1Label = ns.AceGUI:Create("Label")
            statType1Label:SetText("Stat Type 1: " .. tostring(trinketInfo.statType1 or "None"))
            statType1Label:SetWidth(200)
            infoGroup:AddChild(statType1Label)

            local statType2Label = ns.AceGUI:Create("Label")
            statType2Label:SetText("Stat Type 2: " .. tostring(trinketInfo.statType2 or "None"))
            statType2Label:SetWidth(200)
            infoGroup:AddChild(statType2Label)

            local statType3Label = ns.AceGUI:Create("Label")
            statType3Label:SetText("Stat Type 3: " .. tostring(trinketInfo.statType3 or "None"))
            statType3Label:SetWidth(200)
            infoGroup:AddChild(statType3Label)

            local icdLabel = ns.AceGUI:Create("Label")
            icdLabel:SetText("ICD: " .. string.format("%.1fs", trinketInfo.icd or 0))
            icdLabel:SetWidth(200)
            infoGroup:AddChild(icdLabel)

            local durationLabel = ns.AceGUI:Create("Label")
            durationLabel:SetText("Duration: " .. string.format("%.1fs", trinketInfo.duration or 0))
            durationLabel:SetWidth(200)
            infoGroup:AddChild(durationLabel)

            local procTypeLabel = ns.AceGUI:Create("Label")
            procTypeLabel:SetText("Proc Type: " .. tostring(trinketInfo.procType or "None"))
            procTypeLabel:SetWidth(200)
            infoGroup:AddChild(procTypeLabel)

            local buffIdLabel = ns.AceGUI:Create("Label")
            buffIdLabel:SetText("Buff ID: " .. tostring(trinketInfo.buffId or "None"))
            buffIdLabel:SetWidth(200)
            infoGroup:AddChild(buffIdLabel)

            local stacksLabel = ns.AceGUI:Create("Label")
            stacksLabel:SetText("Max Stacks: " .. tostring(trinketInfo.stacks or "None"))
            stacksLabel:SetWidth(200)
            infoGroup:AddChild(stacksLabel)

            scroll:AddChild(infoGroup)
        else
            local errorLabel = ns.AceGUI:Create("Label")
            errorLabel:SetText("Failed to analyze trinket")
            errorLabel:SetFullWidth(true)
            scroll:AddChild(errorLabel)
        end
    end

    -- If no trinkets are equipped, show a message
    if not data.trinket1 and not data.trinket2 then
        local noTrinketsLabel = ns.AceGUI:Create("Label")
        noTrinketsLabel:SetText("No trinkets equipped")
        noTrinketsLabel:SetFullWidth(true)
        scroll:AddChild(noTrinketsLabel)
    end

    return nil     -- No single widget to return
end

--- Render proc states section
--- @param data table Proc state data to render
--- @param scroll table The scroll frame to add widgets to
--- @return table|nil The created widget or nil
function TrinketTrackingManager:RenderProcStates(data, scroll)
    -- Validate inputs
    if not scroll then
        self:Warn("RenderProcStates: scroll parameter is nil")
        return nil
    end

    if not data or not next(data) then
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No proc states tracked")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    -- Validate data structure
    if type(data) ~= "table" then
        local errorLabel = ns.AceGUI:Create("Label")
        errorLabel:SetText("Invalid proc state data format")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return errorLabel
    end

    local procCount = 0
    for spellId, procState in pairs(data) do
        -- Validate proc state structure
        if type(procState) ~= "table" then
            self:Warn("RenderProcStates: Invalid proc state for spell %d", spellId)
            -- Skip this proc state and continue with the next one
        else
            procCount = procCount + 1

            local procHeader = ns.AceGUI:Create("Heading")
            procHeader:SetText(string.format("Proc %d (Spell %d)", procCount, spellId))
            procHeader:SetFullWidth(true)
            scroll:AddChild(procHeader)

            local procGroup = ns.AceGUI:Create("SimpleGroup")
            procGroup:SetLayout("Flow")
            procGroup:SetFullWidth(true)

            local procCountLabel = ns.AceGUI:Create("Label")
            procCountLabel:SetText("Proc Count: " .. tostring(procState.procCount or 0))
            procCountLabel:SetWidth(200)
            procGroup:AddChild(procCountLabel)

            local lastProcLabel = ns.AceGUI:Create("Label")
            local lastProcText = procState.lastProcTime and
                string.format("%.1fs ago", GetTime() - procState.lastProcTime) or "Never"
            lastProcLabel:SetText("Last Proc Time: " .. lastProcText)
            lastProcLabel:SetWidth(200)
            procGroup:AddChild(lastProcLabel)

            local icdLabel = ns.AceGUI:Create("Label")
            icdLabel:SetText("ICD: " .. string.format("%.1fs", procState.icd or 0))
            icdLabel:SetWidth(200)
            procGroup:AddChild(icdLabel)

            -- Check if ICD is active
            if procState.lastProcTime and procState.icd then
                local timeSinceLastProc = GetTime() - procState.lastProcTime
                local remaining = procState.icd - timeSinceLastProc
                if remaining > 0 then
                    local remainingLabel = ns.AceGUI:Create("Label")
                    remainingLabel:SetText("ICD Remaining: " .. string.format("%.1fs", remaining))
                    remainingLabel:SetWidth(200)
                    procGroup:AddChild(remainingLabel)
                else
                    local readyLabel = ns.AceGUI:Create("Label")
                    readyLabel:SetText("ICD Status: Ready")
                    readyLabel:SetWidth(200)
                    procGroup:AddChild(readyLabel)
                end
            end

            scroll:AddChild(procGroup)

            -- Add spacer between procs
            if procCount < self:CountTableEntries(data) then
                local spacer = ns.AceGUI:Create("Label")
                spacer:SetText("")
                spacer:SetFullWidth(true)
                spacer:SetHeight(8)
                scroll:AddChild(spacer)
            end
        end
    end

    return nil     -- No single widget to return
end

--- Render active auras section
--- @param data table Active aura data to render
--- @param scroll table The scroll frame to add widgets to
--- @return table|nil The created widget or nil
function TrinketTrackingManager:RenderActiveAuras(data, scroll)
    -- Validate inputs
    if not scroll then
        self:Warn("RenderActiveAuras: scroll parameter is nil")
        return nil
    end

    if not data or #data == 0 then
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No active trinket auras")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    -- Validate data structure
    if type(data) ~= "table" then
        local errorLabel = ns.AceGUI:Create("Label")
        errorLabel:SetText("Invalid active aura data format")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return errorLabel
    end

    -- Create table structure
    local tableGroup = ns.AceGUI:Create("SimpleGroup")
    tableGroup:SetLayout("List")
    tableGroup:SetFullWidth(true)

    -- Table header
    local headerRow = ns.AceGUI:Create("SimpleGroup")
    headerRow:SetLayout("Flow")
    headerRow:SetFullWidth(true)

    local sourceHeader = ns.AceGUI:Create("Label")
    sourceHeader:SetText("Source")
    sourceHeader:SetWidth(120)
    sourceHeader:SetFontObject(GameFontHighlightSmall)
    headerRow:AddChild(sourceHeader)

    local nameHeader = ns.AceGUI:Create("Label")
    nameHeader:SetText("Aura Name")
    nameHeader:SetWidth(150)
    nameHeader:SetFontObject(GameFontHighlightSmall)
    headerRow:AddChild(nameHeader)

    local stacksHeader = ns.AceGUI:Create("Label")
    stacksHeader:SetText("Stacks")
    stacksHeader:SetWidth(80)
    stacksHeader:SetFontObject(GameFontHighlightSmall)
    headerRow:AddChild(stacksHeader)

    local remainingHeader = ns.AceGUI:Create("Label")
    remainingHeader:SetText("Remaining")
    remainingHeader:SetWidth(100)
    remainingHeader:SetFontObject(GameFontHighlightSmall)
    headerRow:AddChild(remainingHeader)

    local statusHeader = ns.AceGUI:Create("Label")
    statusHeader:SetText("Status")
    statusHeader:SetWidth(80)
    statusHeader:SetFontObject(GameFontHighlightSmall)
    headerRow:AddChild(statusHeader)

    tableGroup:AddChild(headerRow)

    -- Table rows
    for i, aura in ipairs(data) do
        -- Validate aura structure
        if type(aura) == "table" then
            local rowGroup = ns.AceGUI:Create("SimpleGroup")
            rowGroup:SetLayout("Flow")
            rowGroup:SetFullWidth(true)

            local sourceLabel = ns.AceGUI:Create("Label")
            sourceLabel:SetText(aura.source or "Unknown")
            sourceLabel:SetWidth(120)
            rowGroup:AddChild(sourceLabel)

            local nameLabel = ns.AceGUI:Create("Label")
            nameLabel:SetText(aura.name or "Unknown")
            nameLabel:SetWidth(150)
            rowGroup:AddChild(nameLabel)

            local stacksLabel = ns.AceGUI:Create("Label")
            stacksLabel:SetText(tostring(aura.stacks or 0))
            stacksLabel:SetWidth(80)
            rowGroup:AddChild(stacksLabel)

            local remainingLabel = ns.AceGUI:Create("Label")
            remainingLabel:SetText(aura.remaining or "Unknown")
            remainingLabel:SetWidth(100)
            rowGroup:AddChild(remainingLabel)

            local statusLabel = ns.AceGUI:Create("Label")
            statusLabel:SetText(aura.status or "Unknown")
            statusLabel:SetWidth(80)
            rowGroup:AddChild(statusLabel)

            tableGroup:AddChild(rowGroup)
        else
            self:Warn("RenderActiveAuras: Invalid aura data at index %d", i)
        end
    end

    scroll:AddChild(tableGroup)
    return tableGroup
end

--- Render custom trinkets section
--- @param data table Custom trinket data to render
--- @param scroll table The scroll frame to add widgets to
--- @return table|nil The created widget or nil
function TrinketTrackingManager:RenderCustomTrinkets(data, scroll)
    -- Validate inputs
    if not scroll then
        self:Warn("RenderCustomTrinkets: scroll parameter is nil")
        return nil
    end

    if not data or not next(data) then
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No custom trinkets registered")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    -- Validate data structure
    if type(data) ~= "table" then
        local errorLabel = ns.AceGUI:Create("Label")
        errorLabel:SetText("Invalid custom trinket data format")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return errorLabel
    end

    for itemId, trinketData in pairs(data) do
        -- Validate trinket data structure
        if type(trinketData) == "table" then
            local itemHeader = ns.AceGUI:Create("Heading")
            itemHeader:SetText(string.format("Item %d", itemId))
            itemHeader:SetFullWidth(true)
            scroll:AddChild(itemHeader)

            local itemGroup = ns.AceGUI:Create("SimpleGroup")
            itemGroup:SetLayout("Flow")
            itemGroup:SetFullWidth(true)

            local buffIdLabel = ns.AceGUI:Create("Label")
            buffIdLabel:SetText("Buff ID: " .. tostring(trinketData.buffId or "None"))
            buffIdLabel:SetWidth(200)
            itemGroup:AddChild(buffIdLabel)

            local durationLabel = ns.AceGUI:Create("Label")
            durationLabel:SetText("Duration: " .. string.format("%.1fs", trinketData.duration or 0))
            durationLabel:SetWidth(200)
            itemGroup:AddChild(durationLabel)

            local icdLabel = ns.AceGUI:Create("Label")
            icdLabel:SetText("ICD: " .. string.format("%.1fs", trinketData.icd or 0))
            icdLabel:SetWidth(200)
            itemGroup:AddChild(icdLabel)

            local procTypeLabel = ns.AceGUI:Create("Label")
            procTypeLabel:SetText("Proc Type: " .. tostring(trinketData.procType or "None"))
            procTypeLabel:SetWidth(200)
            itemGroup:AddChild(procTypeLabel)

            if trinketData.stats then
                local statNames = {}
                for _, statId in ipairs(trinketData.stats) do
                    if Types then
                        local statType = Types:GetType("Stat")
                        if statType then
                            local statName = statType:GetNameByValue(statId)
                            table.insert(statNames, statName or tostring(statId))
                        else
                            table.insert(statNames, tostring(statId))
                        end
                    else
                        table.insert(statNames, tostring(statId))
                    end
                end

                local statsLabel = ns.AceGUI:Create("Label")
                statsLabel:SetText("Stats: " .. table.concat(statNames, ", "))
                statsLabel:SetWidth(400)
                itemGroup:AddChild(statsLabel)
            end

            local maxStacksLabel = ns.AceGUI:Create("Label")
            maxStacksLabel:SetText("Max Stacks: " .. tostring(trinketData.maxStacks or "None"))
            maxStacksLabel:SetWidth(200)
            itemGroup:AddChild(maxStacksLabel)

            scroll:AddChild(itemGroup)

            -- Add spacer between items
            local spacer = ns.AceGUI:Create("Label")
            spacer:SetText("")
            spacer:SetFullWidth(true)
            spacer:SetHeight(8)
            scroll:AddChild(spacer)
        else
            self:Warn("RenderCustomTrinkets: Invalid trinket data for item %d", itemId)
        end
    end

    return nil     -- No single widget to return
end

--- Count entries in a table
--- @param t table The table to count
--- @return number Number of entries
function TrinketTrackingManager:CountTableEntries(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

--- Test trinket functions (placeholder for enhanced functionality)
function TrinketTrackingManager:TestTrinketFunctions()
    self:Info("Trinket function testing - use the enhanced debug frame for full functionality")
end

--- Simulate trinket proc (placeholder for enhanced functionality)
function TrinketTrackingManager:SimulateTrinketProc()
    self:Info("Trinket proc simulation - use the enhanced debug frame for full functionality")
end
