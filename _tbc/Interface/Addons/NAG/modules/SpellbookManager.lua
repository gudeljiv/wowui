--- @module "NAG.SpellbookManager"
--- Centralized spellbook management and scanning for the NAG addon
---
--- Provides unified spellbook access, caching, and change detection across all WoW versions.
--- Handles spell ID mapping, spell location tracking, and automatic updates when spells change.
---
--- PERFORMANCE OPTIMIZATIONS (v2.0):
--- - O(1) cache lookups for spell resolution and position queries
--- - Aggressive caching of spell names and resolution results
--- - Reduced frequency of cache cleanup operations
--- - Smart cache validation to prevent unnecessary rebuilds
--- - Optimized IsSpellKnown to check caches before expensive API calls
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ============================
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local WoWAPI
local TablePool = ns.TablePool

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in ModuleInitialize to avoid expensive metatable access

--- @type DataManager
--- @type StateManager
local DataManager, StateManager

--- @type TimerManager
local TimerManager

--- @type CacheRefreshManager
local CacheRefreshManager

--- @type SpecCompat
local SpecCompat


-- Version and API compatibility
local Version = ns.Version

local DebugFrameUtil = ns.DebugFrameUtil
local AceGUI = ns.AceGUI
local IsPlayerSpell = C_Spellbook and C_Spellbook.IsSpellKnown or _G.IsPlayerSpell

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local format = string.format



local strfind = strfind
local strlower = strlower

local tinsert = tinsert
local tremove = tremove
local wipe = wipe

-- Standard Lua functions
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local next = next

-- Enhanced error handling
local pcall = ns.pcall

-- WoW API functions (unified through APICompat)
-- WoW API (using unified versions for cross-version compatibility)
local GetFlyoutInfo = _G.GetFlyoutInfo
local GetFlyoutSlotInfo = _G.GetFlyoutSlotInfo

-- ~~~~~~~~~~ PRIVATE HELPER FUNCTIONS ============================

--- Validates if a spell ID is valid
--- @param spellID number The spell ID to validate
--- @return boolean isValid Whether the spell ID is valid
local function IsValidSpellID(spellID)
    return spellID and type(spellID) == "number" and spellID > 0
end

--- Validates if a spell name is valid
--- @param spellName string The spell name to validate
--- @return boolean isValid Whether the spell name is valid
local function IsValidSpellName(spellName)
    return spellName and type(spellName) == "string" and spellName ~= ""
end

--- Checks if a spell is castable (not passive)
--- @param spellName string The spell name to check
--- @param spellType string The spell type from GetSpellBookItemName
--- @return boolean isCastable Whether the spell is castable
local function IsCastableSpell(spellName, spellType)
    -- Define non-castable spell types (language-agnostic)
    -- These are the English spell types that indicate non-castable spells
    local nonCastableTypes = {

        ["Passive"] = true,
        ["Racial Passive"] = true,
        ["Guild Perk"] = true,
        ["Profession"] = true,
        ["Tradeskill"] = true,
    }

    -- Check if spell type is in the non-castable list
    if spellType and nonCastableTypes[spellType] then
        return false
    end

    -- Accept empty string (normal spells) and any other types not in the blacklist
    return true
end

--- Creates a spell entry with consistent structure
--- @param spellID number The spell ID
--- @param spellName string The spell name
--- @param icon number The spell icon
--- @param spellType string The spell type
--- @param bookIndex number The spellbook index
--- @param tabIndex number The tab index
--- @param rank string|nil The spell rank text
--- @return table spellEntry The spell entry
local function CreateSpellEntry(spellID, spellName, icon, spellType, bookIndex, tabIndex, rank)
    return {
        id = spellID,
        name = spellName,
        icon = icon,
        rank = rank,
        type = spellType,
        bookIndex = bookIndex,
        tabIndex = tabIndex,
        lastUpdated = GetTime()
    }
end

--- Compares two spell entries for equality
--- @param entry1 table First spell entry
--- @param entry2 table Second spell entry
--- @return boolean isEqual Whether the entries are equal
local function AreSpellEntriesEqual(entry1, entry2)
    if not entry1 or not entry2 then
        return false
    end
    return entry1.id == entry2.id and
        entry1.name == entry2.name and
        entry1.type == entry2.type and
        entry1.bookIndex == entry2.bookIndex and
        entry1.tabIndex == entry2.tabIndex
end

-- ~~~~~~~~~~ MODULE ACCESS ============================

-- ~~~~~~~~~~ CONTENT ============================

--- @class SpellbookManager : CoreModule
local SpellbookManager = NAG:CreateModule("SpellbookManager", {
    -- Only configuration settings (no persistent cache data)
    global = {
        -- Spell cache settings
        spellCacheEnabled = true,
        spellCacheDuration = 300, -- 5 minutes (for in-memory cache expiry)
        maxSpellCacheSize = 1000,

        -- Scanning settings
        autoScanOnSpellChanges = true,
        autoScanOnTalentChanges = true,
        autoScanOnEquipmentChanges = true,

        -- Cache rebuild settings
        cacheRebuildThrottle = 0.5 -- Increased from 0.1 to reduce excessive cache rebuilding
    },
}, {
    messageHandlers = {
        NAG_ROTATION_CHANGED = true,           -- Unified rotation change message
        NAG_SPEC_UPDATED = true,
        NAG_SPELL_CAST_SUCCEEDED = true,
        NAG_PET_STATE_CHANGED = true,
        NAG_TALENTS_UPDATED = true,  -- NEW: Handle talent updates
        NAG_EXPANSION_DATA_LOADED = true,
        NAG_STARTUP_COMPLETE = true,
    },
    eventHandlers = {
        PLAYER_EQUIPMENT_CHANGED = true,
        SPELLS_CHANGED = "HandleSpellAffectingEvent",
        -- Spec/talent events handled by SpecCompat and broadcast via NAG_SPEC_UPDATED/NAG_TALENTS_UPDATED messages
        -- PLAYER_SPECIALIZATION_CHANGED, ACTIVE_TALENT_GROUP_CHANGED, PLAYER_TALENT_UPDATE, CHARACTER_POINTS_CHANGED removed
        -- PLAYER_LEVEL_UP removed - handled via SPELLS_CHANGED (new spells) and NAG_SPEC_UPDATED (spec changes)
        GLYPH_ADDED = "HandleSpellAffectingEvent",
        GLYPH_REMOVED = "HandleSpellAffectingEvent",
        GLYPH_UPDATED = "HandleSpellAffectingEvent",
        PLAYER_LOGIN = "HandleSpellAffectingEvent",
        PLAYER_ENTERING_WORLD = "HandleSpellAffectingEvent",
    },

    -- Automatic slash command registration
    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["spellbook_dedup"] = {
            handler = "HandleDeduplicationCommand",
            help = "Auto-deduplicate duplicate spell entries in spellLocations. Usage: /nagdebug spellbook dedup [spellname]. If no spell name is provided, processes all duplicates.",
            root = "nagdebug",
            path = {"spellbook", "dedup"},
            category = "System"
        }
    },

    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    debugCategories = { ns.DEBUG_CATEGORIES.SPELLBOOK },
})
local module = SpellbookManager
ns.SpellbookManager = SpellbookManager

-- ~~~~~~~~~~ PRIVATE STATE ============================

-- Memory-only caches (no database persistence)
local spellbookCache = {}
local spellNameToID = {}
local spellNameToIDs = {}
local spellIDToName = {}
local spellIDToBookIndex = {}
local spellIDToTabIndex = {}

-- Known spell cache - caches IsPlayerSpell results for O(1) lookups
local knownSpellCache = {}
local spellNameToRank = {}

-- Flyout ID -> name (for blacklist dropdown and display when flyout is blacklisted)
local flyoutIDToName = {}

local function IsFlyoutItem(itemInfo)
    if not itemInfo then
        return false
    end

    local itemType = itemInfo.itemType or itemInfo.spellType or itemInfo.type
    if not itemType then
        return false
    end

    if type(itemType) == "string" then
        return itemType == "FLYOUT"
    end

    if type(itemType) == "number" and Enum and Enum.SpellBookItemType and Enum.SpellBookItemType.Flyout then
        return itemType == Enum.SpellBookItemType.Flyout
    end

    return false
end

--- Extracts a numeric rank from spell rank text, if present
--- @param rankText string|nil The spell rank text (localized)
--- @return number|nil rankNumber The extracted rank number or nil if not found
local function GetSpellRankNumber(rankText)
    if type(rankText) ~= "string" or rankText == "" then
        return nil
    end
    local numberMatch = rankText:match("(%d+)")
    return numberMatch and tonumber(numberMatch) or nil
end

--- Updates the spell name -> ID map to prefer the highest known rank
--- @param spellEntry table The spell entry
local function UpdateSpellNameMapping(spellEntry)
    if not spellEntry or not spellEntry.name then
        return
    end

    local spellName = spellEntry.name
    local currentRank = GetSpellRankNumber(spellEntry.rank)
    local existingRank = spellNameToRank[spellName]

    if not spellNameToIDs[spellName] then
        spellNameToIDs[spellName] = {}
    end
    spellNameToIDs[spellName][spellEntry.id] = true

    -- First entry wins unless we can prove a higher rank exists
    if not spellNameToID[spellName] then
        spellNameToID[spellName] = spellEntry.id
        if currentRank then
            spellNameToRank[spellName] = currentRank
        end
        return
    end

    -- Prefer higher-ranked spells when rank info is available
    if currentRank and (not existingRank or currentRank > existingRank) then
        spellNameToID[spellName] = spellEntry.id
        spellNameToRank[spellName] = currentRank
    end
end

local function ProcessFlyoutEntries(self, itemInfo, spellIndex, tabIndex)
    if not itemInfo then
        return 0
    end

    local flyoutID = itemInfo.flyoutID or itemInfo.actionID or itemInfo.spellID or itemInfo.id
    if not flyoutID then
        return 0
    end

    local flyoutInfo = { GetFlyoutInfo(flyoutID) }
    local flyoutName
    local numSlots
    if type(flyoutInfo[1]) == "table" then
        flyoutName = flyoutInfo[1].name
        numSlots = flyoutInfo[1].numSlots
    else
        flyoutName = flyoutInfo[1]
        numSlots = flyoutInfo[3]
    end

    if not numSlots or numSlots <= 0 then
        return 0
    end

    flyoutIDToName[flyoutID] = flyoutName or tostring(flyoutID)

    local added = 0
    for slot = 1, numSlots do
        local slotInfo = { GetFlyoutSlotInfo(flyoutID, slot) }
        local slotSpellID = slotInfo[1]
        local slotIsKnown = slotInfo[3]
        local slotName = slotInfo[4]
        local slotIcon = slotInfo[5]

        if slotSpellID and slotIsKnown then
            -- CRITICAL: Double-check spell is actually known (flyout API can sometimes be wrong)
            local isActuallyKnown = WoWAPI.IsSpellKnown(slotSpellID) or (IsPlayerSpell and IsPlayerSpell(slotSpellID))
            if not isActuallyKnown then
                if self.debug then
                    self:Debug("Skipping flyout spell %d - slotIsKnown=true but IsSpellKnown=false", slotSpellID)
                end
            else
                local detailedSpellInfo = WoWAPI.GetSpellInfo(slotSpellID)
                local spellName = detailedSpellInfo and detailedSpellInfo.name or slotName or tostring(slotSpellID)
                local spellIcon = detailedSpellInfo and detailedSpellInfo.iconID or slotIcon or itemInfo.iconID

                if spellName then
                    local spellEntry = CreateSpellEntry(slotSpellID, spellName, spellIcon, "SPELL", spellIndex, tabIndex,
                        detailedSpellInfo and detailedSpellInfo.rank or nil)
                    spellEntry.isFlyoutSpell = true
                    spellEntry.flyoutID = flyoutID
                    spellEntry.flyoutSlot = slot
                    spellEntry.flyoutName = flyoutName

                    spellbookCache[slotSpellID] = spellEntry
                    UpdateSpellNameMapping(spellEntry)
                    spellIDToName[slotSpellID] = spellName
                    spellIDToBookIndex[slotSpellID] = spellIndex
                    spellIDToTabIndex[slotSpellID] = tabIndex

                    added = added + 1

                    if self.debug then
                        self:Trace("ScanSpellbook: Added flyout spell %d ('%s') from flyout %d slot %d", slotSpellID, spellName, flyoutID, slot)
                    end
                end
            end
        end
    end

    return added
end

-- Spell position caches (consolidated from CacheManager)
local spellPositionCache = {}
local lastPositionCacheRebuild = 0

-- Rotation cache removed - now using StateManager as single source of truth

-- Cache management state
local spellbookCacheExpiry = 0
local isScanning = false
local scanQueue = {}
local pendingSpellUpdates = {}

-- Event deduplication to prevent excessive cache rebuilding
local lastEventTime = {}
local eventDeduplicationWindow = 0.5 -- 500ms window to deduplicate events

-- Spell ID resolution cache for O(1) lookups after first resolution
-- Maps APL spell IDs to their current effective spellbook IDs
local resolutionCache = {}
local lastResolutionCacheCleanup = 0
local resolutionCacheCleanupInterval = 300 -- Clean up every 5 minutes

-- Reusable table for cleanup operations (prevents GC pressure)
local keysToRemoveReusable = {}

-- ~~~~~~~~~~ PRIVATE METHODS ============================

-- Rotation cache helper functions removed - now using StateManager

--- Cleans up old resolution cache entries to prevent memory bloat
--- @param self table The module instance
local function CleanupResolutionCache(self)
    local currentTime = GetTime()
    if currentTime - lastResolutionCacheCleanup < resolutionCacheCleanupInterval then
        return
    end

    -- PERFORMANCE FIX: Use next() to check if cache has entries instead of counting
    -- This avoids unnecessary iteration when cache is empty
    if not next(resolutionCache) then
        -- Cache is empty, nothing to clean up
        lastResolutionCacheCleanup = currentTime
        return
    end

    -- PERFORMANCE FIX: Only count if we need to check memory pressure
    -- For now, we're keeping all entries since we don't have timestamp tracking
    -- In the future, we could implement LRU or usage-based cleanup
    local beforeCount = 0
    for _ in pairs(resolutionCache) do
        beforeCount = beforeCount + 1
        -- Early exit if we exceed threshold
        if beforeCount > 1000 then
            break
        end
    end

    local cleanedCount = 0

    -- Only clear if we have too many entries (memory pressure)
    if beforeCount > 1000 then
        wipe(resolutionCache)
        cleanedCount = beforeCount
        if self.debug then self:Debug("Resolution cache cleanup: removed %d entries due to memory pressure", cleanedCount) end
    end

    lastResolutionCacheCleanup = currentTime
end


--- Scans the spellbook and updates memory caches
--- @param force boolean Whether to force a scan even if cache is valid
--- @return boolean success Whether the scan was successful
function SpellbookManager:ScanSpellbook(force)
    if isScanning then
        -- Queue the scan request
        tinsert(scanQueue, force)
        return false
    end

    local currentTime = GetTime()
    local cacheDuration = self.db.global.spellCacheDuration

    -- Check if cache is still valid
    if not force and currentTime < spellbookCacheExpiry then
        return true
    end

    isScanning = true
    self:Debug("Starting spellbook scan (force: " .. tostring(force) .. ")")

    -- Clear all memory caches
    wipe(spellbookCache)
    wipe(spellNameToID)
    wipe(spellNameToIDs)
    wipe(spellNameToRank)
    wipe(spellIDToName)
    wipe(spellIDToBookIndex)
    wipe(spellIDToTabIndex)
    wipe(flyoutIDToName)
    wipe(resolutionCache)
    lastResolutionCacheCleanup = 0

    local scanStartTime = debugprofilestop() -- High-precision timing in milliseconds
    local spellCount = 0
    local errorCount = 0

    -- Get number of spell tabs
    local numTabs = WoWAPI.GetNumSpellTabs()

    if not numTabs or numTabs <= 0 then
        self:Error("Failed to get number of spell tabs")
        isScanning = false
        return false
    end

    -- Scan each spell tab
    for tabIndex = 1, numTabs do
        local tabInfo = WoWAPI.GetSpellTabInfo(tabIndex)

        if not tabInfo then
            if self.debug then
                self:Debug(format("GetSpellTabInfo returned nil for tab %d (tab may not exist or be available)", tabIndex))
            end
        else
            local tabName, tabIcon, offset, numSpells = tabInfo.name, tabInfo.iconID, tabInfo.itemIndexOffset, tabInfo.numSpellBookItems

            if tabName and offset and numSpells then
                -- Scan spells in this tab
                for spellIndex = offset + 1, offset + numSpells do
                    local success, spellEntry = pcall(function()
                        local itemInfo = WoWAPI.GetSpellBookItemInfo(spellIndex, BOOKTYPE_SPELL)
                        if IsFlyoutItem(itemInfo) then
                            local added = ProcessFlyoutEntries(self, itemInfo, spellIndex, tabIndex)
                            if added > 0 then
                                spellCount = spellCount + added
                            end
                            return nil
                        end

                        return self:GetSpellEntryByIndex(spellIndex, tabIndex)
                    end)

                    if success and spellEntry then
                        -- CRITICAL: Validate spell is actually known before adding to cache
                        -- The spellbook can contain spells from items/temporary effects that aren't actually known
                        local isActuallyKnown = WoWAPI.IsSpellKnown(spellEntry.id) or (IsPlayerSpell and IsPlayerSpell(spellEntry.id))
                        if not isActuallyKnown then
                            if self.debug then
                                self:Debug("Skipping spell %d ('%s') - appears in spellbook but not actually known", spellEntry.id, spellEntry.name)
                            end
                            -- Don't add to cache if not actually known
                        else
                            -- Store in memory caches
                            spellbookCache[spellEntry.id] = spellEntry
                            UpdateSpellNameMapping(spellEntry)
                            spellIDToName[spellEntry.id] = spellEntry.name
                            spellIDToBookIndex[spellEntry.id] = spellEntry.bookIndex
                            spellIDToTabIndex[spellEntry.id] = spellEntry.tabIndex
                            spellCount = spellCount + 1
                        end
                    elseif not success then
                        errorCount = errorCount + 1
                        if errorCount <= 5 then -- Limit debug logging
                            if self.debug then self:Debug("Failed to get spell at index %d in tab %d", spellIndex, tabIndex) end
                        end
                    end
                end
            else
                if self.debug then
                    self:Debug(format("Incomplete tab info for tab %d: name=%s, offset=%s, numSpells=%s",
                        tabIndex, tostring(tabName), tostring(offset), tostring(numSpells)))
                end
            end
        end
    end

    -- Update cache expiry
    spellbookCacheExpiry = currentTime + cacheDuration

    local scanEndTime = debugprofilestop()
    local scanDurationMs = scanEndTime - scanStartTime

    if self.debug then self:Info("Spellbook scan completed: %d spells in %.3fms", spellCount, scanDurationMs) end
    if errorCount > 0 then
        self:Warn("Scan completed with %d errors", errorCount)
    end

    isScanning = false

    -- Process any queued scans
    if #scanQueue > 0 then
        local nextForce = tremove(scanQueue, 1)
        self:ScanSpellbook(nextForce)
    end

    return true
end

--- Gets a spell entry by spellbook index and tab
--- @param spellIndex number The spellbook index
--- @param tabIndex number The tab index
--- @return table|nil spellEntry The spell entry or nil if not found
function SpellbookManager:GetSpellEntryByIndex(spellIndex, tabIndex)
    if not spellIndex or not tabIndex then
        return nil
    end

    -- Get spell name from spellbook (using unified API)
    local spellBookItemInfo = WoWAPI.GetSpellBookItemName(spellIndex, BOOKTYPE_SPELL)
    if not spellBookItemInfo then
        return nil
    end
    local spellName, spellType, spellID = spellBookItemInfo.name, spellBookItemInfo.spellType, spellBookItemInfo.spellID

    -- Get spell info from spellbook (using unified API)
    local spellInfo = WoWAPI.GetSpellBookItemInfo(spellIndex, BOOKTYPE_SPELL)
    if not spellInfo then
        return nil
    end

    -- Filter out non-castable spells (passives, etc.)
    if not IsCastableSpell(spellName, spellType) then
        return nil
    end

    -- Get additional spell info
    local detailedSpellInfo = WoWAPI.GetSpellInfo(spellID)
    if not detailedSpellInfo then
        return nil
    end
    local name, icon, rank = detailedSpellInfo.name, detailedSpellInfo.iconID, detailedSpellInfo.rank
    if not name then
        return nil
    end

    return CreateSpellEntry(spellID, name, icon, spellType, spellIndex, tabIndex, rank)
end

--- Detects changes in the spellbook by comparing with previous scan
--- @return table changes Table of changes detected
function SpellbookManager:DetectSpellChanges()
    local changes = {
        added = {},
        removed = {},
        modified = {},
        totalChanges = 0
    }

    -- This would compare current scan with previous scan
    -- For now, just return empty changes since we're not tracking history
    return changes
end

--- Updates character cache (no-op since we're memory-only)
--- @param self SpellbookManager
function SpellbookManager:UpdateCharacterCache()
    -- No-op: we don't store cache data in database
end

--- Checks if an event should be processed (deduplication)
--- @param eventName string The event name
--- @return boolean Whether the event should be processed
local function ShouldProcessEvent(eventName)
    local currentTime = GetTime()
    local lastTime = lastEventTime[eventName] or 0

    if currentTime - lastTime < eventDeduplicationWindow then
        return false -- Skip this event, it's too soon after the last one
    end

    lastEventTime[eventName] = currentTime
    return true
end

--- Schedules a spellbook scan with batching and deduplication
--- @param force boolean Whether to force the scan
--- @param eventName string|nil Optional event name for deduplication
function SpellbookManager:ScheduleSpellbookScan(force, eventName)
    if not self.db.global.autoScanOnSpellChanges then
        return
    end

    -- Check deduplication if event name provided
    if eventName and not ShouldProcessEvent(eventName) then
        if self.debug then self:Debug("Skipping spellbook scan for %s (deduplicated)", eventName) end
        return
    end

    -- Use a short delay to batch multiple rapid changes
    TimerManager:Cancel(TimerManager.Categories.CORE, "spellbookScan")

    TimerManager:Create(TimerManager.Categories.CORE, "spellbookScan", function()
        self:ScanSpellbook(force)
    end, 0.1, false)
end

--- Gets a spell by ID
--- @param spellID number The spell ID
--- @return table|nil spellEntry The spell entry or nil if not found
function SpellbookManager:GetSpell(spellID)
    if not IsValidSpellID(spellID) then
        return nil
    end

    -- Check memory cache first
    if spellbookCache[spellID] then
        return spellbookCache[spellID]
    end

    -- Fallback to API
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    if spellInfo then
        local name, icon = spellInfo.name, spellInfo.iconID
        if name then
            return CreateSpellEntry(spellID, name, icon, "SPELL", nil, nil, spellInfo.rank)
        end
    end

    return nil
end

--- Gets a spell by name
--- @param spellName string The spell name
--- @return table|nil spellEntry The spell entry or nil if not found
function SpellbookManager:GetSpellByName(spellName)
    if not IsValidSpellName(spellName) then
        return nil
    end

    -- Check memory cache first
    local spellID = spellNameToID[spellName]
    if spellID then
        return self:GetSpell(spellID)
    end

    -- Fallback to API
    local spellInfo = WoWAPI.GetSpellInfo(spellName)
    if spellInfo and spellInfo.name then
        local spellID = spellInfo.spellID
        if spellID then
            return self:GetSpell(spellID)
        end
    end

    return nil
end

--- Gets the spell ID for a spell name
--- @param spellName string The spell name
--- @return number|nil spellID The spell ID or nil if not found
function SpellbookManager:GetSpellID(spellName)
    if not IsValidSpellName(spellName) then
        return nil
    end

    -- Check memory cache first
    local spellID = spellNameToID[spellName]
    if spellID then
        return spellID
    end

    -- Fallback to API
    local spellInfo = WoWAPI.GetSpellInfo(spellName)
    return spellInfo and spellInfo.spellID or nil
end

--- Gets the spell name for a spell ID
--- @param spellID number The spell ID
--- @return string|nil spellName The spell name or nil if not found
function SpellbookManager:GetSpellName(spellID)
    if not IsValidSpellID(spellID) then
        return nil
    end

    -- Check memory cache first
    local spellName = spellIDToName[spellID]
    if spellName then
        return spellName
    end

    -- Fallback to API
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    return spellInfo and spellInfo.name or nil
end

--- Resolves a spell name from a spell ID with robust fallbacks.
--- @param spellID number The spell ID
--- @return string|nil spellName The resolved spell name or nil if not found
function SpellbookManager:ResolveSpellName(spellID)
    if not IsValidSpellID(spellID) then
        return nil
    end

    local cachedName = spellIDToName[spellID]
    if cachedName then
        return cachedName
    end

    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    if spellInfo and spellInfo.name then
        spellIDToName[spellID] = spellInfo.name
        return spellInfo.name
    end

    if DataManager and DataManager.Get then
        local entity = DataManager:Get(spellID, DataManager.EntityTypes.SPELL)
        local entityName = entity and entity.name or nil
        if entityName then
            spellIDToName[spellID] = entityName
            return entityName
        end
    end

    return nil
end

--- Initializes data-dependent spell position caches once the data-ready barrier is open.
--- @param source string|nil Source identifier for logging.
--- @return boolean initialized True if startup cache initialization ran.
function SpellbookManager:InitializeDataDependentCaches(source)
    if self._startupPositionCacheInitialized then
        return true
    end

    if not (DataManager and DataManager.IsDataReady and DataManager:IsDataReady()) then
        return false
    end

    self._startupPositionCacheInitialized = true
    self:RequestSpellPositionCacheRebuild(true, nil, source or "NAG_EXPANSION_DATA_LOADED")
    return true
end

--- Resolves a spell ID from APL to the current effective spell ID in the spellbook
--- This handles cases where spell IDs change due to ranks, patches, or version differences
--- @param aplSpellID number The spell ID from the APL
--- @return number|nil effectiveSpellID The current effective spell ID, or nil if not found
function SpellbookManager:ResolveEffectiveSpellID(aplSpellID)
    if not IsValidSpellID(aplSpellID) then
        return nil
    end

    -- CRITICAL PERFORMANCE FIX: Check resolution cache first (O(1) lookup)
    if resolutionCache[aplSpellID] then
        return resolutionCache[aplSpellID]
    end

    -- Step 1: Canonicalize by spell name to ensure all ranks resolve consistently.
    local spellName = self:ResolveSpellName(aplSpellID)
    if spellName then
        local canonicalSpellID = spellNameToID[spellName] or self:GetSpellID(spellName)
        if canonicalSpellID then
            resolutionCache[aplSpellID] = canonicalSpellID
            return canonicalSpellID
        end
    end

    -- Step 2: Preserve fallback behavior for IDs present in the current spellbook.
    if spellbookCache[aplSpellID] then
        resolutionCache[aplSpellID] = aplSpellID
        return aplSpellID
    end

    -- Step 3: APL ID not in our spellbook - keep existing fallback flow.
    if not spellName then
        return nil
    end

    -- Step 4: Find the current spell ID in spellbook by name
    local effectiveSpellID = self:GetSpellID(spellName)

    if effectiveSpellID then
        -- CRITICAL: Cache the resolution result for O(1) future lookups
        resolutionCache[aplSpellID] = effectiveSpellID
        return effectiveSpellID
    end

    -- Step 5: Fallback - try direct API lookup (only if absolutely necessary)
    local spellInfo = WoWAPI.GetSpellInfo(spellName)
    if spellInfo and spellInfo.name then
        local apiSpellID = spellInfo.spellID
        if apiSpellID then
            -- Cache the fallback resolution result
            resolutionCache[aplSpellID] = apiSpellID
            return apiSpellID
        end
    end

    return nil
end

--- Checks if a spell is known (cached results with comprehensive fallbacks)
--- @param spellID number The spell ID
--- @return boolean isKnown Whether the spell is known
function SpellbookManager:IsSpellKnown(spellID)
    if not IsValidSpellID(spellID) then
        return false
    end

    -- PERFORMANCE: Check cache first (O(1) lookup)
    if knownSpellCache[spellID] ~= nil then
        -- Safety: if cached true for a talent-mapped spell, revalidate against current state to avoid sticky positives
        if knownSpellCache[spellID] == true then
            local talentForSpell = DataManager:GetTalentBySpellId(spellID)
            if talentForSpell then
                local hasTalent = StateManager.HasTalent and StateManager:HasTalent(talentForSpell.talentId) or false
                local inLocalCache = spellbookCache[spellID] ~= nil
                if not hasTalent and not inLocalCache then
                    -- Invalidate stale cache
                    knownSpellCache[spellID] = false
                    return false
                end
            end
        end
        return knownSpellCache[spellID]
    end

    -- Step 0: Check if this spell is overridden by an active talent
    if DataManager:IsSpellOverriddenByActiveTalent(spellID) then
        knownSpellCache[spellID] = false
        return false
    end

    -- Step 1: Talent-gated spells check
    local talent = DataManager:GetTalentBySpellId(spellID)
    if talent then
        local hasTalent = StateManager.HasTalent and StateManager:HasTalent(talent.talentId) or false
        if hasTalent then
            knownSpellCache[spellID] = true
            return true
        end
        -- Fall through to local spellbook checks only
    end

    -- Step 2: Check if our local spellbook scan already contains this ID
    if spellbookCache[spellID] ~= nil then
        knownSpellCache[spellID] = true
        return true
    end

    -- Step 3: Direct player spell lookup via WoW API (covers spells hidden from spellbook scan)
    local apiIsKnown = WoWAPI.IsSpellKnown(spellID) or IsPlayerSpell and IsPlayerSpell(spellID)
    if apiIsKnown then
        knownSpellCache[spellID] = true
        return true
    end

    -- Step 4: Pet spells (keep positive trust via API for pet book)
    if IsPetActive() and WoWAPI.IsSpellKnown(spellID, true, true) then
        knownSpellCache[spellID] = true
        return true
    end

    -- Step 5: Spell ID resolution fallback (handles APL old IDs) -> local cache only
    local effectiveSpellID = self:ResolveEffectiveSpellID(spellID)
    if effectiveSpellID and effectiveSpellID ~= spellID then
        if spellbookCache[effectiveSpellID] ~= nil then
            knownSpellCache[spellID] = true
            return true
        end
    end

    -- Step 6: Final fallback - spell name resolution (local cache only)
    local spellName = self:ResolveSpellName(spellID)
    if spellName then
        local byName = self:GetSpellID(spellName)
        if byName and spellbookCache[byName] ~= nil then
            knownSpellCache[spellID] = true
            return true
        end
    end

    -- Step 7: Cache negative result only after all checks
    knownSpellCache[spellID] = false
    return false
end

--- Gets all known spells
--- @return table spells Table of all known spells
function SpellbookManager:GetAllSpells()
    return spellbookCache
end

--- Gets all castable spells (filters out passives, auras, etc.)
--- @return table spells Table of all castable spells
function SpellbookManager:GetCastableSpells()
    local castableSpells = {}

    for spellID, entry in pairs(spellbookCache) do
        if IsCastableSpell(entry.name, entry.type) then
            castableSpells[spellID] = entry
        end
    end

    return castableSpells
end

--- Returns the flyout ID for a spell if it is a flyout slot spell (e.g. Instant Poison from Poison flyout).
--- Used so blacklisting a flyout (e.g. "Poison") blacklists all its child spells.
--- @param spellID number The spell ID to look up (may be APL or resolved)
--- @return number|nil flyoutID The flyout ID if this spell is a flyout slot spell, nil otherwise
function SpellbookManager:GetFlyoutIDForSpell(spellID)
    if not IsValidSpellID(spellID) then
        return nil
    end
    local entry = spellbookCache[spellID]
    if entry and entry.flyoutID then
        return entry.flyoutID
    end
    local resolved = self:ResolveEffectiveSpellID(spellID)
    if resolved and resolved ~= spellID then
        entry = spellbookCache[resolved]
        if entry and entry.flyoutID then
            return entry.flyoutID
        end
    end
    return nil
end

--- Returns the display name for a flyout ID (e.g. "Poison"). Used when showing blacklisted flyouts in UI.
--- @param flyoutID number The flyout ID from GetFlyoutInfo / spellbook
--- @return string|nil name The flyout name or nil if unknown
function SpellbookManager:GetFlyoutName(flyoutID)
    if not flyoutID or type(flyoutID) ~= "number" then
        return nil
    end
    return flyoutIDToName[flyoutID]
end

--- Returns the icon for a flyout (first slot spell's icon). Used when showing blacklisted flyouts in UI.
--- @param flyoutID number The flyout ID from GetFlyoutInfo / spellbook
--- @return number|nil iconID The icon texture file ID or nil if no slot spell has an icon
function SpellbookManager:GetFlyoutIcon(flyoutID)
    if not flyoutID or type(flyoutID) ~= "number" then
        return nil
    end
    for spellID, entry in pairs(spellbookCache) do
        if entry.flyoutID == flyoutID and entry.icon then
            return entry.icon
        end
    end
    return nil
end

--- Returns flyout entries for the spell blacklist dropdown (so user can blacklist "Poison (all)").
--- Each entry has value = flyoutID, name, displayText with " (all)" suffix.
--- @return table list Array of { value = flyoutID, name = string, displayText = string, type = "flyout" }
function SpellbookManager:GetFlyoutsForBlacklist()
    local list = {}
    for fid, flyoutName in pairs(flyoutIDToName) do
        local icon = ""
        for spellID, entry in pairs(spellbookCache) do
            if entry.flyoutID == fid and entry.icon then
                icon = format("|T%s:20:20:0:0|t ", entry.icon)
                break
            end
        end
        tinsert(list, {
            value = fid,
            name = flyoutName,
            type = "flyout",
            displayText = icon .. (flyoutName or tostring(fid)) .. " (all)"
        })
    end
    return list
end

--- Gets spells by tab
--- @param tabIndex number The tab index
--- @return table spells Table of spells in the specified tab
function SpellbookManager:GetSpellsByTab(tabIndex)
    if not tabIndex then
        return {}
    end

    local spells = {}
    for spellID, entry in pairs(spellbookCache) do
        if entry.tabIndex == tabIndex then
            spells[spellID] = entry
        end
    end

    return spells
end

--- Searches for spells by name pattern
--- @param pattern string The search pattern
--- @return table spells Table of matching spells
function SpellbookManager:SearchSpells(pattern)
    if not pattern or pattern == "" then
        return {}
    end

    local spells = {}
    local lowerPattern = strlower(pattern)

    for spellID, entry in pairs(spellbookCache) do
        if strfind(strlower(entry.name), lowerPattern) then
            spells[spellID] = entry
        end
    end

    return spells
end

-- ~~~~~~~~~~ SPELL POSITION MANAGEMENT (CONSOLIDATED FROM CACHEMANAGER) ============================

--- Gets the effective position for a spell with O(1) lookup performance
--- @param spellId number The spell ID to get position for
--- @return string The effective position using REAL constants (LEFT, RIGHT, ABOVE, BELOW, AOE, PRIMARY, SEQUENCE, IGNORE)
function SpellbookManager:GetSpellPosition(spellId)
    if not spellId then
        self:Warn("GetSpellPosition called with nil spellId, returning PRIMARY")
        return ns.SPELL_POSITIONS.PRIMARY
    end

    -- Validate spellId is a number
    if type(spellId) ~= "number" then
        if self.debug then
            self:Warn("GetSpellPosition: Invalid spellId type %s for value %s, returning PRIMARY",
                type(spellId), tostring(spellId))
        end
        return ns.SPELL_POSITIONS.PRIMARY
    end

    -- Position is now stored directly with spells in secondarySpells array
    -- No need for override map system

    -- Cache module lookups (done once at top)
    local classModule = NAG:GetClassModule()
    local currentRotation = classModule and classModule:GetCurrentRotation() or nil
    local useCustomSpellLocations = currentRotation and currentRotation.useCustomSpellLocations or false
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()

    -- Helper function to check if source data exists (DRY)
    local function HasSourceData()
        if useCustomSpellLocations then
            return currentRotation and currentRotation.spellLocations and
                next(currentRotation.spellLocations) ~= nil
        else
            return specIndex and classModule and classModule.db.class.specSpellLocations[specIndex] and
                next(classModule.db.class.specSpellLocations[specIndex]) ~= nil
        end
    end

    -- Validate cache source matches current toggle state
    local cacheSourceValid = HasSourceData()

    -- If cache source is invalid (no data available), return default
    -- This prevents infinite loops when no rotation exists (like healing specs)
    if not cacheSourceValid then
        -- No source data available, return default
        return ns.SPELL_POSITIONS.PRIMARY
    end

    local resolvedSpellId = self:ResolveEffectiveSpellID(spellId)

    -- Fast O(1) cache lookup with canonical ID preference
    if resolvedSpellId then
        local resolvedPosition = spellPositionCache[resolvedSpellId]
        if resolvedPosition then
            return resolvedPosition
        end
    end

    local cachedPosition = spellPositionCache[spellId]
    if cachedPosition then
        return cachedPosition
    end

    -- CRITICAL FIX: Check if cache is empty but source data exists
    -- This handles the race condition where rotation runs before spellLocations are set
    local cacheIsEmpty = next(spellPositionCache) == nil
    if cacheIsEmpty and HasSourceData() then
        self:Debug("GetSpellPosition: Cache empty; requesting rebuild")
        self:RequestSpellPositionCacheRebuild(true, nil, "GetSpellPosition_cache_empty")

        -- Preserve accuracy while rebuild is async/budgeted:
        -- do a cheap direct lookup in the active spellLocations source.
        local function lookupPosition(id)
            if not id then
                return nil
            end
            if useCustomSpellLocations then
                local loc = currentRotation and currentRotation.spellLocations
                return loc and loc[id] or nil
            end
            local specLoc = specIndex and classModule and classModule.db and classModule.db.class
                and classModule.db.class.specSpellLocations and classModule.db.class.specSpellLocations[specIndex]
            return specLoc and specLoc[id] or nil
        end

        local pos = nil
        if resolvedSpellId then
            pos = lookupPosition(resolvedSpellId)
        end
        if not pos then
            pos = lookupPosition(spellId)
        end
        if pos then
            return pos
        end
    end

    return ns.SPELL_POSITIONS.PRIMARY
end


--- Rebuilds the spell position cache from current rotation data


--- Gets the number of entries in the spell position cache
--- @return number The number of cached position entries
function SpellbookManager:GetSpellPositionCacheCount()
    local count = 0
    for _ in pairs(spellPositionCache) do
        count = count + 1
    end
    return count
end

-- ============================ CACHE REFRESH SCHEDULING ============================

--- Request a spell position cache rebuild via CacheRefreshManager.
--- Prevents rebuild overlap and allows rebuild cost to be budgeted across frames.
--- @param force boolean
--- @param specIndex number|nil
--- @param source string|nil
function SpellbookManager:RequestSpellPositionCacheRebuild(force, specIndex, source)
    CacheRefreshManager = CacheRefreshManager or NAG:GetModule("CacheRefreshManager", true)
    if not CacheRefreshManager then
        self:RebuildSpellPositionCache(force, specIndex)
        return
    end

    local throttle = self.db and self.db.global and self.db.global.cacheRebuildThrottle or 0.5
    local pr = CacheRefreshManager.PRIORITY and CacheRefreshManager.PRIORITY.COMBAT_LOW or 4
    if UnitAffectingCombat and UnitAffectingCombat("player") then
        pr = CacheRefreshManager.PRIORITY and CacheRefreshManager.PRIORITY.COMBAT_NORMAL or 3
    end

    CacheRefreshManager:RequestRefresh("spellbook:positionCache", {
        priority = pr,
        minIntervalSec = throttle,
    }, function()
        self:RebuildSpellPositionCache(force, specIndex)
        return true
    end)
end

--- Rebuilds the spell position cache from current rotation data and spec defaults
--- This is the core functionality that was previously in CacheManager
---
--- ARCHITECTURE NOTE: Deduplication now happens during rotation validation
--- in RotationManager:ValidateRotationConfig(), not during cache rebuilds.
--- This ensures data is clean when it enters the system rather than
--- cleaning it every time it's used.
---
--- @param force boolean Force rebuild even if throttled
--- @param specIndex number|nil Optional specIndex to use (uses current if not provided)
function SpellbookManager:RebuildSpellPositionCache(force, specIndex)
    -- Throttle rebuilds to prevent excessive cache rebuilding
    local currentTime = GetTime()
    local throttleTime = self.db.global.cacheRebuildThrottle

    if not force and (currentTime - lastPositionCacheRebuild) < throttleTime then
        return
    end

    self:Debug("Starting spell position cache rebuild (force: " .. tostring(force) .. ")")

    -- Clear existing cache
    wipe(spellPositionCache)
    local classModule = NAG:GetClassModule()
    local currentRotation = classModule and classModule:GetCurrentRotation() or nil

    -- Use provided specIndex or get current one
    local targetSpecIndex = specIndex or (SpecCompat and SpecCompat:GetCurrentSpecIndex())

    -- Check if we should use custom or default spell locations
    -- Use the rotation's toggle to determine which source to use
    local useCustomSpellLocations = currentRotation and currentRotation.useCustomSpellLocations or false

    --- Cache position for a source spell ID and all known rank variants.
    --- @param sourceSpellId number
    --- @param normalizedPosition string
    local function CachePositionForSpellVariants(sourceSpellId, normalizedPosition)
        spellPositionCache[sourceSpellId] = normalizedPosition

        local effectiveSpellId = self:ResolveEffectiveSpellID(sourceSpellId)
        if effectiveSpellId then
            spellPositionCache[effectiveSpellId] = normalizedPosition
        end

        local spellName = self:ResolveSpellName(sourceSpellId)
        if spellName then
            local nameVariants = spellNameToIDs[spellName]
            if nameVariants then
                for variantSpellId in pairs(nameVariants) do
                    spellPositionCache[variantSpellId] = normalizedPosition
                end
            end

            local canonicalSpellId = spellNameToID[spellName]
            if canonicalSpellId then
                spellPositionCache[canonicalSpellId] = normalizedPosition
            end
        end
    end

    if currentRotation then
        if currentRotation.spellLocations then
            local count = 0
            for k, v in pairs(currentRotation.spellLocations) do
                count = count + 1
            end
            if self.debug then self:Debug("Found %d spell location entries in rotation", count) end
        end
    end

    if useCustomSpellLocations and currentRotation and currentRotation.spellLocations then
        -- Using custom mode - cache from rotation's spellLocations only
        self:Debug("Using custom spell locations from rotation")

        -- REMOVED: Deduplication now happens during rotation validation
        -- Data should already be clean when it reaches this point
        local workingSpellLocations = currentRotation.spellLocations

        -- The UI saves spellLocations in NEW FORMAT: spellId → position
        -- This is the CORRECT format based on the actual UI code
        for spellId, position in pairs(workingSpellLocations) do
            if type(spellId) == "number" and type(position) == "string" then
                -- NEW FORMAT: spellId → position (this is what the UI actually saves)
                local normalizedPosition = position or ns.SPELL_POSITIONS.PRIMARY
                CachePositionForSpellVariants(spellId, normalizedPosition)
            else
                -- Skip invalid entries
            end
        end
    elseif targetSpecIndex then
        -- Using default mode - cache from specSpellLocations only
        self:Debug("Using default spell locations from specSpellLocations")

        local classModule = NAG:GetClassModule()

        if classModule then
            local specDefaults = classModule.db.class.specSpellLocations[targetSpecIndex]

            if specDefaults then
                -- REMOVED: Deduplication now happens during rotation validation
                -- Data should already be clean when it reaches this point
                local workingSpecDefaults = specDefaults

                -- Handle new format (spellId → position) only
                for key, value in pairs(workingSpecDefaults) do
                    if type(key) == "number" and type(value) == "string" then
                        -- New format: spellId → position (this is what the class defaults actually use)
                        local spellId = key
                        local position = value
                        -- CRITICAL: Cache BOTH the original APL spell ID AND the resolved ID
                        local normalizedPosition = position or ns.SPELL_POSITIONS.PRIMARY
                        CachePositionForSpellVariants(spellId, normalizedPosition)
                    else
                        -- Skip invalid entries
                    end
                end
            end
        end
    end

    lastPositionCacheRebuild = currentTime

    -- Log completion summary
    local cacheCount = 0
    for spellId, position in pairs(spellPositionCache) do
        cacheCount = cacheCount + 1
    end
    if self.debug then self:Debug("Spell position cache rebuild completed: %d entries", cacheCount) end
end


--- Gets the number of entries in the resolution cache
--- @return number The number of cached resolution entries
function SpellbookManager:GetResolutionCacheCount()
    local count = 0
    for _ in pairs(resolutionCache) do
        count = count + 1
    end
    return count
end

--- Forces a spellbook scan
--- @return boolean success Whether the scan was successful
function SpellbookManager:ForceScan()
    return self:ScanSpellbook(true)
end

--- Gets spellbook statistics
--- @return table stats Table of spellbook statistics
function SpellbookManager:GetStats()
    local currentTime = GetTime()
    return {
        totalSpells = self:GetSpellCount(),
        cacheValid = currentTime < spellbookCacheExpiry,
        isScanning = isScanning,
        cacheExpiry = spellbookCacheExpiry,
        currentTime = currentTime,
        scanQueueSize = #scanQueue,
        pendingUpdates = #pendingSpellUpdates,
        -- Position cache stats
        positionCacheEntries = self:GetSpellPositionCacheCount(),
        lastPositionRebuild = lastPositionCacheRebuild,
        -- Resolution cache stats
        resolutionCacheEntries = self:GetResolutionCacheCount(),
    }
end

--- Gets the total number of spells
--- @return number count The total number of spells
function SpellbookManager:GetSpellCount()
    local count = 0
    for _ in pairs(spellbookCache) do
        count = count + 1
    end
    return count
end

--- Invalidates the spell cache
function SpellbookManager:InvalidateCache()
    spellbookCacheExpiry = 0
    self:Debug("Spell cache invalidated")
end

--- Invalidates the spell position cache
function SpellbookManager:InvalidateSpellPositionCache()
    wipe(spellPositionCache)
    lastPositionCacheRebuild = 0
end

--- Invalidates the spell ID resolution cache
function SpellbookManager:InvalidateResolutionCache()
    wipe(resolutionCache)
    lastResolutionCacheCleanup = 0
end

--- Clears all caches
function SpellbookManager:ClearCaches()
    wipe(spellbookCache)
    wipe(spellNameToID)
    wipe(spellNameToIDs)
    wipe(spellNameToRank)
    wipe(spellIDToName)
    wipe(spellIDToBookIndex)
    wipe(spellIDToTabIndex)
    wipe(spellPositionCache)
    wipe(resolutionCache)
    wipe(knownSpellCache) -- CRITICAL: Clear known spell cache
    spellbookCacheExpiry = 0
    lastPositionCacheRebuild = 0
    lastResolutionCacheCleanup = 0

    -- StateManager handles its own rotation state invalidation
    -- No need to call StateManager methods from here

    self:Debug("All spell caches and resolution cache cleared")
end

-- ~~~~~~~~~~ EVENT HANDLERS ============================

--- Generic handler for spell-affecting events
--- @param event string The event name
function SpellbookManager:HandleSpellAffectingEvent(event)
    if self.debug then self:Debug("%s - invalidating caches and rescanning", event) end

    -- On login/entering world, fully clear caches to avoid stale state
    if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
        self:ClearCaches()
        wipe(knownSpellCache)
        self:ScheduleSpellbookScan(true, event)
        return
    end

    self:InvalidateSpellPositionCache()
    self:InvalidateResolutionCache()
    wipe(knownSpellCache) -- CRITICAL: Clear known spell cache when spells change
    self:ScheduleSpellbookScan(true, event)

    -- Note: Don't rebuild here - spell changes don't change rotation config
    -- Rebuild will happen when rotation changes via NAG_ROTATION_CHANGED
end

-- All spell-affecting events now handled by HandleSpellAffectingEvent via eventHandlers mixin

--- Handles rotation changes (message handler)
--- Unified handler for both data and selection changes
function SpellbookManager:NAG_ROTATION_CHANGED(message, payload)
    -- Rotation changed - rebuild spell position cache
    self:Debug("NAG_ROTATION_CHANGED: Rebuilding spell position cache (action: %s, dataChanged: %s, selectionChanged: %s)",
        payload and payload.action or "unknown",
        payload and tostring(payload.dataChanged) or "unknown",
        payload and tostring(payload.selectionChanged) or "unknown")
    self:RequestSpellPositionCacheRebuild(true, nil, "NAG_ROTATION_CHANGED")
end

--- Handles equipment changes (migrated from StateManager)
--- @param event string The event name
--- @param equipmentSlot number The equipment slot that changed
--- @param hasCurrent boolean Whether the slot has a current item
function SpellbookManager:PLAYER_EQUIPMENT_CHANGED(event, equipmentSlot, hasCurrent)
    if self.db.global.autoScanOnEquipmentChanges then
        self:Debug("Equipment changed in slot %d - invalidating caches and rescanning", equipmentSlot)
        -- Equipment changed - may affect spell availability
        self:InvalidateSpellPositionCache()
        self:InvalidateResolutionCache()
        wipe(knownSpellCache) -- CRITICAL: Clear known spell cache when equipment changes
        self:ScheduleSpellbookScan(true, "PLAYER_EQUIPMENT_CHANGED")
        -- Also rebuild position cache since equipment may affect spell availability
        self:RequestSpellPositionCacheRebuild(true, nil, "PLAYER_EQUIPMENT_CHANGED")
    end
end

--- Handles specialization changes from StateManager
--- @param message string The message name
function SpellbookManager:NAG_SPEC_UPDATED(message)
    -- Only process if spec change was successful
    -- Specialization changed - StateManager handles its own rotation state invalidation
    self:InvalidateSpellPositionCache()
    self:InvalidateResolutionCache()
    self:ScheduleSpellbookScan(true)
    -- Note: Don't rebuild here - rotation selection happens in OnSpecChange() which triggers NAG_ROTATION_CHANGED
    -- Rebuild will happen when rotation changes via NAG_ROTATION_CHANGED
end

--- Called when startup is complete - do initial cache build
--- @param message string The message name
function SpellbookManager:NAG_STARTUP_COMPLETE(message)
    self:Info("Startup complete - building initial spell position cache")
    self:RequestSpellPositionCacheRebuild(true, nil, "NAG_STARTUP_COMPLETE")
end

--- Runs data-dependent startup initialization after expansion data is ready.
--- @param message string The message name.
function SpellbookManager:NAG_EXPANSION_DATA_LOADED(message)
    self:InitializeDataDependentCaches("NAG_EXPANSION_DATA_LOADED")
end

-- CHARACTER_POINTS_CHANGED and PLAYER_LEVEL_UP removed - handled via SPELLS_CHANGED (new spells) and NAG_SPEC_UPDATED/NAG_TALENTS_UPDATED (spec/talent changes)

--- Handles spell cast events from StateManager
--- @param message string The message name
--- @param unit string The unit that cast the spell
--- @param castGUID string The cast GUID
--- @param spellId number The spell ID that was cast
--- @param spellName string The spell name that was cast
function SpellbookManager:NAG_SPELL_CAST_SUCCEEDED(message, unit, castGUID, spellId, spellName)
    -- Update last cast time in cache if spell exists
    local spellEntry = spellbookCache[spellId]
    if spellEntry then
        spellEntry.lastCast = GetTime()
    end
end

--- Handles pet state changes from StateManager
--- @param message string The message name
--- @param petActive boolean Whether the pet is now active
--- @param npcId number|nil The NPC ID of the pet (nil if no pet)
--- @param petName string|nil The name of the pet (nil if no pet)
function SpellbookManager:NAG_PET_STATE_CHANGED(message, petActive, npcId, petName)
    if self.debug then
        self:Debug("Pet state changed: active=%s, npcId=%s, name=%s",
            tostring(petActive), tostring(npcId), tostring(petName))
    end

    -- CRITICAL: Invalidate the known spell cache when pet state changes
    -- This ensures that pet spells are re-evaluated with the new pet state
    wipe(knownSpellCache)

    if self.debug then
        self:Debug("Invalidated known spell cache due to pet state change")
    end
end

--- Handles talent updates from StateManager
--- @param message string The message name
function SpellbookManager:NAG_TALENTS_UPDATED(message)
    if self.debug then
        self:Debug("NAG_TALENTS_UPDATED: Clearing known spell cache after talent update")
    end

    -- Invalidate caches affected by talent changes
    self:InvalidateSpellPositionCache()
    self:InvalidateResolutionCache()

    -- Clear known spell cache so knowledge checks re-evaluate
    wipe(knownSpellCache)

    -- Schedule an immediate spellbook rescan (forced)
    self:ScheduleSpellbookScan(true, "NAG_TALENTS_UPDATED")
end

-- ~~~~~~~~~~ MODULE LIFECYCLE ============================

--- Initializes the SpellbookManager
function SpellbookManager:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    DataManager = NAG:GetModule("DataManager")
    TimerManager = NAG:GetModule("TimerManager")
    CacheRefreshManager = NAG:GetModule("CacheRefreshManager")
    StateManager = NAG:GetModule("StateManager")
    SpecCompat = NAG:GetModule("SpecCompat")
    WoWAPI = ns.WoWAPI

    if not WoWAPI then
        self:Error("WoWAPI registry unavailable during SpellbookManager initialization")
        return
    end

    local success, err = pcall(function()
        TimerManager:Create(TimerManager.Categories.CORE, "spellbookInitialScan", function()
            self:ScanSpellbook(true)
            self:InitializeDataDependentCaches("spellbookInitialScan")
        end, 5, false)

        -- Set up periodic cleanup of resolution cache
        TimerManager:Create(TimerManager.Categories.CORE, "resolutionCacheCleanup", function()
            CleanupResolutionCache(self)
        end, 300, true) -- Every 5 minutes instead of every minute to reduce overhead
    end)

    if not success then
        self:Error("Failed to schedule initial spellbook scan with TimerManager: " .. tostring(err))
        -- Fallback to C_Timer
        C_Timer.After(3.0, function()
            self:ScanSpellbook(true)
            self:InitializeDataDependentCaches("startup_rescan")
        end)
    end
end

--- Enables the SpellbookManager
function SpellbookManager:ModuleEnable()
    -- ============================ MODULE INITIALIZATION ============================
    self:InitializeDataDependentCaches("ModuleEnable")
    -- No database restoration needed - everything is memory-only
    -- Cache will be rebuilt on first scan
end

--- Disables the SpellbookManager
function SpellbookManager:ModuleDisable()
    -- No database saving needed - everything is memory-only
    -- Cache will be cleared when addon is disabled

    -- Cancel any pending timers
    TimerManager:Cancel(TimerManager.Categories.CORE, "spellbookScan")
    TimerManager:Cancel(TimerManager.Categories.CORE, "spellbookInitialScan")
    TimerManager:Cancel(TimerManager.Categories.CORE, "resolutionCacheCleanup")
    self._startupPositionCacheInitialized = false
end

--- Automatically detect and resolve duplicate spell entries in spellLocations
--- @param spellLocations table The spellLocations table to deduplicate
--- @return table result The deduplication results
function SpellbookManager:DeduplicateSpellLocations(spellLocations)
    local result = {
        duplicates = {},
        fixes = {},
        issues = {},
        recommendations = {}
    }

    if not spellLocations or type(spellLocations) ~= "table" then
        tinsert(result.issues, "Invalid spellLocations table")
        return result
    end

    self:Info("🔧 SPELL_DEDUPLICATION: Starting automatic deduplication of spellLocations")

    -- Work on a COPY to avoid modifying the original data
    local workingCopy = {}
    for spellId, position in pairs(spellLocations) do
        workingCopy[spellId] = position
    end

    -- Group spell IDs by spell name
    local spellNameGroups = {}
    local spellIDToName = {}

    for spellId, position in pairs(workingCopy) do
        if type(spellId) == "number" and type(position) == "string" then
            local spellInfo = WoWAPI.GetSpellInfo(spellId)
            if spellInfo then
                spellName = spellInfo.name
                if spellName then
                    spellIDToName[spellId] = spellName

                    if not spellNameGroups[spellName] then
                        spellNameGroups[spellName] = {}
                    end

                    table.insert(spellNameGroups[spellName], {
                        spellId = spellId,
                        position = position,
                        spellName = spellName
                    })
                end
            end
        end
    end

    -- Find duplicates (spells with multiple IDs)
    local duplicateCount = 0
    for spellName, entries in pairs(spellNameGroups) do
        if #entries > 1 then
            duplicateCount = duplicateCount + 1
            tinsert(result.duplicates, {
                spellName = spellName,
                entries = entries
            })

            if self.debug then self:Warn("🔧 SPELL_DEDUPLICATION: Found %d IDs for spell '%s':", #entries, spellName) end
            for _, entry in ipairs(entries) do
                if self.debug then self:Warn("  ID %d: position %s", entry.spellId, entry.position) end
            end
        end
    end

    if duplicateCount == 0 then
        tinsert(result.recommendations, "No duplicates found - spellLocations is clean")
        return result
    end

    tinsert(result.fixes, format("Found %d spells with duplicate IDs", duplicateCount))

    -- Smart resolution: Keep the APL spell ID, remove duplicates
    for _, duplicateGroup in ipairs(result.duplicates) do
        local spellName = duplicateGroup.spellName
        local entries = duplicateGroup.entries

        -- Strategy 1: Check which spell ID is actually used in the current APL
        local classModule = NAG:GetClassModule()
        local currentRotation = classModule and classModule:GetCurrentRotation() or nil
        local aplSpellID = nil
        local aplPosition = nil

        if currentRotation and currentRotation.rotationString then
            -- Look for the spell ID in the rotation string
            for _, entry in ipairs(entries) do
                local pattern = format("Cast%%((%d+)%%)", entry.spellId)
                if currentRotation.rotationString:match(pattern) then
                    aplSpellID = entry.spellId
                    aplPosition = entry.position
                    if self.debug then
                        self:Info("🔧 SPELL_DEDUPLICATION: Found APL spell ID %d for '%s' (position: %s)",
                            aplSpellID, spellName, aplPosition)
                    end
                    break
                end
            end
        end

        -- Strategy 2: If no APL match, keep the one with the most specific position
        if not aplSpellID then
            local bestEntry = entries[1]
            local bestPosition = entries[1].position

            for _, entry in ipairs(entries) do
                -- Prefer non-default positions over PRIMARY
                if entry.position ~= ns.SPELL_POSITIONS.PRIMARY and bestPosition == ns.SPELL_POSITIONS.PRIMARY then
                    bestEntry = entry
                    bestPosition = entry.position
                end
            end

            aplSpellID = bestEntry.spellId
            aplPosition = bestEntry.position
            if self.debug then
                self:Info(
                    "🔧 SPELL_DEDUPLICATION: No APL match, keeping best position for '%s': ID %d (position: %s)",
                    spellName,
                    aplSpellID, aplPosition)
            end
        end

        -- Remove duplicates from the working copy, keep only the APL spell ID
        if aplSpellID then
            for _, entry in ipairs(entries) do
                if entry.spellId ~= aplSpellID then
                    workingCopy[entry.spellId] = nil
                    if self.debug then
                        self:Info("🔧 SPELL_DEDUPLICATION: Removed duplicate ID %d for '%s' (kept ID %d)",
                            entry.spellId, spellName, aplSpellID)
                    end
                    tinsert(result.fixes, format("Removed duplicate ID %d for '%s'", entry.spellId, spellName))
                end
            end
        end
    end

    -- Return the deduplicated copy (don't modify the original)
    result.deduplicatedData = workingCopy

    -- Summary
    local finalCount = 0
    for _ in pairs(workingCopy) do
        finalCount = finalCount + 1
    end

    tinsert(result.fixes, format("Deduplication complete: %d → %d entries",
        finalCount + duplicateCount, finalCount))

    if self.debug then self:Info("🔧 SPELL_DEDUPLICATION: Completed - removed %d duplicate entries", duplicateCount) end

    return result
end

-- Export the module


-- ============================ SLASH COMMANDS ============================

--- Handle the deduplication slash command
--- @param args table Command arguments
function SpellbookManager:HandleDeduplicationCommand(args)
    local spellName = args[1]

    if spellName then
        -- Deduplicate specific spell
        if self.debug then self:Info("🔧 SLASH_DEDUP: Processing deduplication for '%s'", spellName) end

        local classModule = NAG:GetClassModule()
        local currentRotation = classModule and classModule:GetCurrentRotation() or nil
        local useCustomSpellLocations = currentRotation and currentRotation.useCustomSpellLocations or false

        if useCustomSpellLocations and currentRotation and currentRotation.spellLocations then
            -- Custom mode: deduplicate spellLocations
            local dedupResult = self:DeduplicateSpellLocations(currentRotation.spellLocations)

            if dedupResult.duplicates and #dedupResult.duplicates > 0 then
                -- Apply deduplication to the database
                wipe(currentRotation.spellLocations)
                for spellId, position in pairs(dedupResult.deduplicatedData) do
                    currentRotation.spellLocations[spellId] = position
                end

                self:Print(format("🔧 Auto-deduplication completed: %d duplicate spells cleaned up",
                    #dedupResult.duplicates))
                for _, fix in ipairs(dedupResult.fixes) do
                    self:Print("  ✅ " .. fix)
                end

                -- Force cache rebuild to apply the deduplication
                self:RequestSpellPositionCacheRebuild(true, nil, "slash_dedup_single_custom")
                self:Print("Position cache rebuilt to apply deduplication")
            else
                self:Print("✅ No duplicates found - spellLocations is already clean")
            end
        else
            -- Default mode: deduplicate specSpellLocations
            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            if specIndex then
                local classModule = NAG:GetClassModule()

                if classModule then
                    local specDefaults = classModule.db.class.specSpellLocations[specIndex]
                    if specDefaults then
                        local dedupResult = self:DeduplicateSpellLocations(specDefaults)

                        if dedupResult.duplicates and #dedupResult.duplicates > 0 then
                            -- Apply deduplication to the database
                            classModule:SetSetting("class", "specSpellLocations." .. specIndex, dedupResult
                                .deduplicatedData)

                            self:Print(format(
                                "🔧 Auto-deduplication completed: %d duplicate spells cleaned up in specSpellLocations",
                                #dedupResult.duplicates))
                            for _, fix in ipairs(dedupResult.fixes) do
                                self:Print("  ✅ " .. fix)
                            end

                            -- Force cache rebuild to apply the deduplication
                            self:RequestSpellPositionCacheRebuild(true, nil, "slash_dedup_single_default")
                            self:Print("Position cache rebuilt to apply deduplication")
                        else
                            self:Print("✅ No duplicates found - specSpellLocations is already clean")
                        end
                    else
                        self:Print("❌ No specSpellLocations found to deduplicate")
                    end
                else
                    self:Print("❌ No class module found")
                end
            else
                self:Print("❌ No specialization found")
            end
        end
    else
        -- Deduplicate all spells
        self:Info("🔧 SLASH_DEDUP: Processing deduplication for all spells")

        local classModule = NAG:GetClassModule()
        local currentRotation = classModule and classModule:GetCurrentRotation() or nil
        local useCustomSpellLocations = currentRotation and currentRotation.useCustomSpellLocations or false

        if useCustomSpellLocations and currentRotation and currentRotation.spellLocations then
            -- Custom mode: deduplicate spellLocations
            local dedupResult = self:DeduplicateSpellLocations(currentRotation.spellLocations)

            if dedupResult.duplicates and #dedupResult.duplicates > 0 then
                -- Apply deduplication to the database
                wipe(currentRotation.spellLocations)
                for spellId, position in pairs(dedupResult.deduplicatedData) do
                    currentRotation.spellLocations[spellId] = position
                end

                self:Print(format("🔧 Auto-deduplication completed: %d duplicate spells cleaned up",
                    #dedupResult.duplicates))
                for _, fix in ipairs(dedupResult.fixes) do
                    self:Print("  ✅ " .. fix)
                end

                -- Force cache rebuild to apply the deduplication
                self:RequestSpellPositionCacheRebuild(true, nil, "slash_dedup_all_custom")
                self:Print("Position cache rebuilt to apply deduplication")
            else
                self:Print("✅ No duplicates found - spellLocations is already clean")
            end
        else
            -- Default mode: deduplicate specSpellLocations
            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            if specIndex then
                local classModule = NAG:GetClassModule()

                if classModule then
                    local specDefaults = classModule.db.class.specSpellLocations[specIndex]
                    if specDefaults then
                        local dedupResult = self:DeduplicateSpellLocations(specDefaults)

                        if dedupResult.duplicates and #dedupResult.duplicates > 0 then
                            -- Apply deduplication to the database
                            classModule:SetSetting("class", "specSpellLocations." .. specIndex, dedupResult
                                .deduplicatedData)

                            self:Print(format(
                                "🔧 Auto-deduplication completed: %d duplicate spells cleaned up in specSpellLocations",
                                #dedupResult.duplicates))
                            for _, fix in ipairs(dedupResult.fixes) do
                                self:Print("  ✅ " .. fix)
                            end

                            -- Force cache rebuild to apply the deduplication
                            self:RequestSpellPositionCacheRebuild(true, nil, "slash_dedup_all_default")
                            self:Print("Position cache rebuilt to apply deduplication")
                        else
                            self:Print("✅ No duplicates found - specSpellLocations is already clean")
                        end
                    else
                        self:Print("❌ No specSpellLocations found to deduplicate")
                    end
                else
                    self:Print("❌ No class module found")
                end
            else
                self:Print("❌ No specialization found")
            end
        end
    end
end
