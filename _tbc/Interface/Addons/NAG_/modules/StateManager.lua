--- @module "NAG.StateManager"
--- Manages the state of the NAG addon.
---
--- This module provides functions for checking and managing the state of the NAG addon.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
--
-- luacheck: ignore GetSpellInfo
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

-- Addon
local _, ns = ...
local IsUsableItem = C_Item and C_Item.IsUsableItem or _G.IsUsableItem
local GetItemSpell = C_Item and C_Item.GetItemSpell or _G.GetItemSpell
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon
local GetActiveSpecGroup = C_SpecializationInfo and C_SpecializationInfo.GetActiveSpecGroup or _G.GetActiveSpecGroup

local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local WoWAPI = ns.WoWAPI
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DataManager
--- @type Types
--- @type OverlayManager
local DataManager, Types, OverlayManager

--- @type SpellTrackingManager
--- @type TooltipParser
--- @type TrinketTrackingManager
local SpellTrackingManager, TooltipParser, TrinketTrackingManager

--- @type any
local TTDManager

--- @type SpecCompat
local SpecCompat

--- @type CacheRefreshManager
local CacheRefreshManager

-- WoW API localizations
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitStat = _G.UnitStat
local UnitSpellHaste = _G.UnitSpellHaste
local UnitAffectingCombat = _G.UnitAffectingCombat
local GetMasteryEffect = _G.GetMasteryEffect
local UnitLevel = _G.UnitLevel
local UnitCreatureFamily = _G.UnitCreatureFamily
local GetCritChance = _G.GetCritChance
local UnitPowerType = _G.UnitPowerType
local GetComboPoints = _G.GetComboPoints
local GetExpertise = _G.GetExpertise
local GetMeleeHaste = _G.GetMeleeHaste
local GetHitModifier = _G.GetHitModifier
local GetHaste = _G.GetHaste
local GetSpellBonusDamage = _G.GetSpellBonusDamage
local GetSpellHitModifier = _G.GetSpellHitModifier
local GetSpellCritChance = _G.GetSpellCritChance
local GetShapeshiftForm = _G.GetShapeshiftForm
local GetRuneType = _G.GetRuneType
local InCombatLockdown = _G.InCombatLockdown
local GetInventoryItemID = _G.GetInventoryItemID
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetNumGroupMembers = _G.GetNumGroupMembers
local GetRaidRosterInfo = _G.GetRaidRosterInfo
local UnitIsUnit = _G.UnitIsUnit
local UnitIsConnected = _G.UnitIsConnected
local IsInInstance = _G.IsInInstance
local HasPetUI = _G.HasPetUI
local GetName = _G.GetName
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local GetInstanceInfo = _G.GetInstanceInfo
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local GetShapeshiftFormID = _G.GetShapeshiftFormID
local UnitInRaid = _G.UnitInRaid
local UnitInParty = _G.UnitInParty
local UnitRace = _G.UnitRace
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff
local GetTalentLink = _G.GetTalentLink
local GetGlyphSocketInfo = _G.GetGlyphSocketInfo


--- @type Version
local Version = ns.Version

--Libs
local L = ns.AceLocale:GetLocale("NAG", true)

-- Utils (memory optimization)
local TablePool = ns.TablePool

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local min = math.min
local max = math.max

local strmatch = strmatch
local strlower = strlower
local strsplit = strsplit
local wipe = wipe
local tContains = tContains


-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


local ITEM_SWAP_SLOT_BY_PROTO = {
    [12] = 13,
    [13] = 14,
    [6] = 10,
    [15] = 17,
}
local ITEM_SWAP_PROTO_KEYS = {
    [12] = true,
    [13] = true,
    [6] = true,
    [15] = true,
}

local function cloneTableShallow(src)
    local dest = {}
    for k, v in pairs(src) do
        dest[k] = v
    end
    return dest
end

--- Safe DataManager entity fetch that avoids startup-time "data not ready" warnings.
--- @param id number
--- @param entityType string
--- @return table|nil
local function getDataEntity(id, entityType)
    if not DataManager or not DataManager.Get then
        return nil
    end
    if DataManager.IsDataReady and not DataManager:IsDataReady() then
        return nil
    end
    return DataManager:Get(id, entityType)
end

local function cloneTableDeep(src)
    local dest = {}
    for k, v in pairs(src) do
        if type(v) == "table" then
            dest[k] = cloneTableDeep(v)
        else
            dest[k] = v
        end
    end
    return dest
end

local function canonicalSwapSetName(name)
    if type(name) ~= "string" then
        name = tostring(name or "")
    end
    name = strlower(name)
    if name == "" then
        return nil
    end
    return name
end

local function normalizeItemSwapConfig(itemSwap)
    if type(itemSwap) ~= "table" then
        return nil
    end

    local sets = {}

    local function addSet(name, data)
        if type(data) ~= "table" then
            return
        end
        local map = {}
        for key, value in pairs(data) do
            local slot = key
            local itemId = value
            if type(slot) == "string" then
                slot = tonumber(slot)
            end
            if type(itemId) == "table" then
                itemId = itemId.id or itemId.itemId
                slot = itemId and (value.slot or slot)
            end
            if type(slot) == "number" and itemId and itemId > 0 then
                map[slot] = itemId
            end
        end
        if next(map) then
            local canonicalName = canonicalSwapSetName(name)
            if canonicalName then
                sets[canonicalName] = map
            end
        end
    end

    if itemSwap.main then
        addSet("main", itemSwap.main)
    end

    if itemSwap.swaps then
        for name, data in pairs(itemSwap.swaps) do
            if type(name) == "string" then
                addSet(name, data)
            end
        end
    end

    if itemSwap.items then
        local legacy = {}
        for protoIndex, inventorySlot in pairs(ITEM_SWAP_SLOT_BY_PROTO) do
            local entryIndex = protoIndex + 1
            local entry = itemSwap.items[entryIndex]
            local itemId
            if type(entry) == "table" then
                itemId = entry.id or entry.itemId
            elseif type(entry) == "number" then
                itemId = entry
            end
            if itemId and itemId > 0 then
                legacy[inventorySlot] = itemId
            end
        end
    local legacyKey = canonicalSwapSetName("Swap1")
    if next(legacy) and legacyKey and not sets[legacyKey] then
        sets[legacyKey] = legacy
        end
    end

    if next(sets) == nil then
        return nil
    end

    local defaultSetName = "main"
    if not sets[defaultSetName] then
        defaultSetName = nil
        for name in pairs(sets) do
            defaultSetName = name
            break
        end
    end

    defaultSetName = canonicalSwapSetName(defaultSetName or "")

    local normalized = {
        sets = {},
        defaultSet = defaultSetName,
        prepullBonusStats = nil
    }

    for name, map in pairs(sets) do
        local canonicalName = canonicalSwapSetName(name)
        if canonicalName then
            normalized.sets[canonicalName] = cloneTableShallow(map)
        end
    end

    if type(itemSwap.prepullBonusStats) == "table" then
        normalized.prepullBonusStats = cloneTableDeep(itemSwap.prepullBonusStats)
    end

    return normalized
end


local TRINKET_SLOTS = { 13, 14 }
local TRINKET_SLOT_SET = {
    [13] = true,
    [14] = true
}

local function doesEquipmentMatchExpected(expectedMap)
    if type(expectedMap) ~= "table" or next(expectedMap) == nil then
        return true
    end

    local reservedTrinketSlots = {}

    local function matchTrinket(expectedId)
        for _, slotId in ipairs(TRINKET_SLOTS) do
            if not reservedTrinketSlots[slotId] then
                local equippedId = GetInventoryItemID("player", slotId)
                if equippedId == expectedId then
                    reservedTrinketSlots[slotId] = true
                    return true
                end
            end
        end
        return false
    end

    for slot, expectedId in pairs(expectedMap) do
        if expectedId and expectedId > 0 then
            if TRINKET_SLOT_SET[slot] then
                if not matchTrinket(expectedId) then
                    return false
                end
            else
                local equippedId = GetInventoryItemID("player", slot)
                if equippedId ~= expectedId then
                    return false
                end
            end
        end
    end

    return true
end


local function refreshItemSwapActiveSet(self)
    local equipmentState = self.state and self.state.player and self.state.player.equipment
    if not equipmentState then
        return
    end

    local swapState = equipmentState.itemSwap
    if not swapState or not swapState.enabled or not swapState.expectedSets then
        return
    end

    local canonicalDefault = canonicalSwapSetName(swapState.defaultSet or "main") or "main"
    swapState.defaultSet = canonicalDefault

    local currentActive = canonicalSwapSetName(swapState.activeSet)
    local matchedSet = nil

    if currentActive and swapState.expectedSets[currentActive] and
        doesEquipmentMatchExpected(swapState.expectedSets[currentActive]) then
        matchedSet = currentActive
    else
        for name, expectedMap in pairs(swapState.expectedSets) do
            if doesEquipmentMatchExpected(expectedMap) then
                matchedSet = name
                break
            end
        end
    end

    if not matchedSet then
        matchedSet = canonicalDefault
    end

    swapState.activeSet = matchedSet
end


-- Initialize default state structure
local function CreateDefaultState()
    return {
        next = {
            nextTime = 0,
        },
        player = {
            guid = nil,
            -- Basic player state
            inCombat = false,
            isMoving = false,
            form = nil,
            lastCast = 0,
            lastCastId = nil,
            shapeshiftForm = {
                id = nil,
                active = false,
                spellId = nil,
            },

            -- Talent state
            talents = {
                active = {},  -- Currently active talents {[talentId] = rank}
                specs = {},   -- Talent specs {[specIndex] = {[talentId] = rank}}
                current = nil -- Current active spec index
            },

            -- Pet state
            pet = {
                active = false,
                npcId = nil,
                guid = nil,
                name = nil,
                familyName = nil,
            },

            -- Equipment state
            equipment = {
                tierSets = {}, -- Will be populated dynamically with tiersetId = count
                tiers = {},    -- Will be populated dynamically with tier = { tiersetId = count }
                trinketData = {
                    [13] = nil, -- { itemId, trinketInfo, lastUpdate }
                    [14] = nil,  -- { itemId, trinketInfo, lastUpdate }
                },
                tinkers = {
                    [6] = nil,  -- Waist
                    [10] = nil, -- Hands
                    [15] = nil, -- Back (cloak)
                },
                itemSwap = {
                    enabled = false,
                    expectedSets = {},
                    defaultSet = nil,
                    activeSet = nil,
                    prepullBonusStats = nil
                },
                runes = {},     -- Will be populated with slotId = runeInfo for SoD
                enchants = {},  -- Will be populated with slotId = enchantId for all enchanted items
                -- Item Level tracking
                ilvl = {
                    total = 0,
                    average = 0,
                    weighted = 0,
                    items = {},     -- ilvl by slot
                    gemmed = {},    -- ilvl including gems by slot
                    effective = {}, -- ilvl including all modifications (WoWSims style)
                    effectiveTotal = 0,
                    effectiveAverage = 0,
                    gemmedTotal = 0,
                    gemmedAverage = 0,
                    lastUpdate = 0
                }
            },

            -- Glyph state
            glyphs = {
                prime = {}, -- Type 3
                major = {}, -- Type 1
                minor = {}, -- Type 2
                all = {}    -- All glyphs regardless of type
            },

            -- Class and Specialization
            classInfo = {
                id = nil,
                name = nil,
                fileName = nil,
            },
            raceInfo = {
                name = nil,
                id = nil,
            },
            specInfo = {
                -- Specialization status (from SpecCompat:GetSpecializationStatus())
                available = false,              -- Whether specs are available
                canHaveSpecs = false,           -- Whether player can have specs (level >= 10)
                playerLevel = 0,                -- Current player level
                requiredLevel = 10,             -- Required level for specs
                specIndex = nil,                -- Current spec index (1-4)
                specName = nil,                 -- Current spec name
                lastCheck = 0,                  -- Last availability check timestamp
            },

            -- Rogue-specific state
            -- storedComboPoints = 0, -- Stored combo points for redirect functionality
        },

        target = {
            guid = nil,
            exists = false,
            startTime = nil, -- Add startTime to track when we start targeting
        },

        combat = {
            time = 0,
            startTime = nil,
            encounterTimer = nil,   -- Timer for encounter duration
            encounterEndTime = nil, -- When the encounter will end
            currentTimeRemaining = nil
        },

        -- Group/Raid state
        group = {
            inRaid = false,
            inParty = false,
            memberCount = 0,
            lastUpdate = 0,
            -- Testing overrides
            overrideRaidCount = nil,
            overridePartyCount = nil,
            overrideInRaid = nil,
            overrideInParty = nil
        }
    }
end

local defaults = {
    global = {
        interruptHistory = {
            encounters = {}, -- [encounterId] = true
            mobs = {}        -- [mobName] = true
        }
    },
    char = {
        -- Elemental Shaman rotation switching now handled by NAG:SmartRotationSwitch() system
        -- Frost DK rotation switching now handled by NAG:SmartRotationSwitch() system
    },
}


--- @class StateManager: CoreModule
local StateManager = NAG:CreateModule("StateManager", defaults, {
    defaultState = CreateDefaultState(),
    -- Event handlers with version-specific conditionals
    eventHandlers = {
        -- World events (these will fire when module is enabled)
        PLAYER_ENTERING_WORLD = true,

        -- Combat events
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,

        -- Target events
        PLAYER_TARGET_CHANGED = true,
        COMBO_TARGET_CHANGED = true,

        -- Equipment events
        PLAYER_EQUIPMENT_CHANGED = true,

        -- Item data events (tier set detection depends on GetItemInfo being available)
        ITEM_DATA_LOAD_RESULT = true,
        GET_ITEM_INFO_RECEIVED = true,

        -- Form events
        UPDATE_SHAPESHIFT_FORM = true,

        -- Encounter events (raid/instance boss tracking)
        ENCOUNTER_START = true,
        ENCOUNTER_END = true,

        -- Spell cast events (complex processing with state tracking)
        UNIT_SPELLCAST_SUCCEEDED = true,

        -- Pet events
        UNIT_PET = true,
        PET_STABLE_UPDATE = "UNIT_PET",

        -- Spec events handled by SpecCompat and broadcast via NAG_SPEC_UPDATED message
        -- PLAYER_SPECIALIZATION_CHANGED and ACTIVE_TALENT_GROUP_CHANGED are handled by SpecCompat

        -- Talent events handled by SpecCompat and broadcast via NAG_TALENTS_UPDATED message
        -- CHARACTER_POINTS_CHANGED and PLAYER_TALENT_UPDATE are handled by SpecCompat
        -- Level events handled by SpecCompat and broadcast via NAG_SPEC_UPDATED message

        -- Group/Raid events
        GROUP_ROSTER_UPDATE = true,

        -- Version-specific handlers
        -- Glyph system (Wrath, Cata, Mists)
        GLYPH_ADDED = (Version:IsWrath() or Version:IsCata() or Version:IsMists()) and true or nil,
        -- SoD (Season of Discovery)
        RUNE_UPDATED = Version:IsSoD() and true or nil,
    },

    -- Message handlers for rotation changes
    messageHandlers = {
        NAG_EXPANSION_DATA_LOADED = true,
        NAG_ROTATION_CHANGED = true,           -- Unified rotation change message
        NAG_STARTUP_COMPLETE = true,
        NAG_SPEC_UPDATED = true,               -- Spec changed (broadcast by SpecCompat)
        NAG_TALENTS_UPDATED = true,            -- Talents updated (broadcast by SpecCompat)
    },
    cleuHandlers = {
        SPELL_INTERRUPT = "HandleCLEUInterruptEvent",
    },

    -- Slash commands for group/raid overrides
    slashCommands = {
        -- HIERARCHICAL FORMAT (testing overrides):
        ["state_group_override"] = {
            handler = "GroupOverrideCommand",
            help = "Group/Raid override commands for testing",
            root = "nagdebug",
            path = {"testing", "state", "group", "override"},
            category = "Debug"
        },
        ["state_raid_override"] = {
            handler = "RaidOverrideCommand",
            help = "Quick raid override commands for testing",
            root = "nagdebug",
            path = {"testing", "state", "raid", "override"},
            category = "Debug"
        },
        ["state_party_override"] = {
            handler = "PartyOverrideCommand",
            help = "Quick party override commands for testing",
            root = "nagdebug",
            path = {"testing", "state", "party", "override"},
            category = "Debug"
        }
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.STATE,
        ns.DEBUG_CATEGORIES.MANAGERS
    }
})
local module = StateManager
ns.StateManager = StateManager

function StateManager:RefreshItemSwapActiveSet()
    refreshItemSwapActiveSet(self)
end

--- Updates item swap state from rotation configuration
--- Extracts item swap config from rotation and transforms it into equipment.itemSwap state
--- @param rotation table|nil The rotation configuration, or nil to disable item swap
function StateManager:UpdateItemSwapFromRotation(rotation)
    local equipmentState = self.state.player.equipment
    if not equipmentState then
        return
    end

    equipmentState.itemSwap = equipmentState.itemSwap or { expectedSets = {}, defaultSet = nil, activeSet = nil }
    local swapState = equipmentState.itemSwap

    if rotation and rotation.enableItemSwap and rotation.itemSwap then
        local normalizedSwap = normalizeItemSwapConfig(rotation.itemSwap)

        if normalizedSwap then
            swapState.enabled = true
            swapState.expectedSets = swapState.expectedSets or {}
            wipe(swapState.expectedSets)
            local expectedCount = 0
            for name, setMap in pairs(normalizedSwap.sets) do
                local canonicalName = canonicalSwapSetName(name)
                if canonicalName then
                    swapState.expectedSets[canonicalName] = cloneTableShallow(setMap)
                    expectedCount = expectedCount + 1
                end
            end
            local newDefault = canonicalSwapSetName(normalizedSwap.defaultSet or "main")
            local previousActive = canonicalSwapSetName(swapState.activeSet)
            swapState.defaultSet = newDefault
            if not previousActive or not normalizedSwap.sets[previousActive] then
                swapState.activeSet = newDefault
            else
                swapState.activeSet = previousActive
            end
            swapState.prepullBonusStats = normalizedSwap.prepullBonusStats
            self:RefreshItemSwapActiveSet()
        else
            -- Normalization failed, disable item swap
            swapState.enabled = false
            if swapState.expectedSets then
                wipe(swapState.expectedSets)
            end
            swapState.prepullBonusStats = nil
            swapState.defaultSet = nil
            swapState.activeSet = nil
        end
    else
        -- No item swap config in rotation, disable it
        swapState.enabled = false
        if swapState.expectedSets then
            wipe(swapState.expectedSets)
        end
        swapState.prepullBonusStats = nil
        swapState.defaultSet = nil
        swapState.activeSet = nil
    end
end

function StateManager:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    TooltipParser = NAG:GetModule("TooltipParser")
    TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
    DataManager = NAG:GetModule("DataManager")
    Types = NAG:GetModule("Types")
    OverlayManager = NAG:GetModule("OverlayManager")
    TTDManager = NAG:GetModule("TTDManager")
    SpecCompat = NAG:GetModule("SpecCompat")
    CacheRefreshManager = NAG:GetModule("CacheRefreshManager")

    -- Initialize state
    self.state = self.state or CreateDefaultState()
    NAG.state = self.state -- Keep a local reference

    -- Initialize combat state
    self.state.combat = self.state.combat or {
        time = 0,
        startTime = nil,
        encounterTimer = nil,
        encounterEndTime = nil,
        currentTimeRemaining = nil
    }

    -- Initialize player state
    self.state.player = self.state.player or {
        inCombat = UnitAffectingCombat("player"),
        lastCast = 0,
        lastCastId = nil
    }

    -- Initialize next state
    self.state.next = self.state.next or {
        nextTime = GetTime()
    }

    -- Encounter tracking runtime vars
    self.currentEncounterId = nil
    self.currentEncounterName = nil

    -- Initialize caches
    self.auraCache = setmetatable({}, { __mode = "kv" })
    self.itemBuffCache = setmetatable({}, { __mode = "kv" })

    -- Initialize trinket retry counters (limit retries to prevent infinite loops)
    self.trinketRetryCounts = self.trinketRetryCounts or {}

    -- Clear rotation switching cache when combat ends
    -- This ensures fresh evaluation of rotation switching conditions on next combat
    NAG:GetModule("RotationManager"):ClearRotationSwitchingCache()
end

function StateManager:ModuleEnable()
    -- ============================ MODULE INITIALIZATION ============================

    -- CRITICAL: Initialize all state immediately when module is enabled
    -- This replaces the old event-based initialization that no longer works

    -- Use standardized state update methods
    --self:UpdateAllState()

    -- Combat state (separate from other state)
    self:ResetCombat()

    -- Schedule delayed updates to ensure all data is loaded, shouldn't be needed though?
    self:ScheduleTimer(function()
        if self.debug then
            self:Debug("Delayed state update after ModuleEnable")
        end
        self:RequestEquipmentChangeStateRefresh("delayed_enable")
    end, 15.0)

    -- Note: NAG_EXPANSION_DATA_LOADED will handle data-dependent initialization when data is actually ready
end

function StateManager:ModuleDisable()
    -- Clear caches (weak tables, but explicit cleanup is good)

    if self.auraCache then
        wipe(self.auraCache)
    end

    if self.itemBuffCache then
        wipe(self.itemBuffCache)
    end




    -- Reset state
    if self.state then
        self.state.combat = {
            time = 0,
            startTime = nil,
            encounterTimer = nil,
            encounterEndTime = nil
        }
    end

    -- Clear temporary storage

    self.preservedSettings = {}

    -- Stop rogue CP tracker
    -- if self._cpTimer then
    --     self:CancelTimer(self._cpTimer)
    --     self._cpTimer = nil
    -- end
end

--- Called when expansion data is loaded and ready for use
function StateManager:NAG_EXPANSION_DATA_LOADED(message)
    if self.debug then
        self:Debug("StateManager: Expansion data loaded, data ready for access")
    end

    -- Don't update state here - glyph/talent APIs may not be available yet
    -- State will be updated in NAG_STARTUP_COMPLETE when game APIs are stable
end

--- Called when startup is complete - all game APIs are stable and ready
function StateManager:NAG_STARTUP_COMPLETE(message)
    if self.debug then
        self:Debug("StateManager: Startup complete - initializing all gameplay state")
    end

    -- Initialize spec status from SpecCompat (if available)
    if SpecCompat then
        local status = SpecCompat:GetSpecializationStatus()
        if status then
            local spec = self.state.player.specInfo
            spec.available = status.available
            spec.canHaveSpecs = status.canHaveSpecs
            spec.playerLevel = status.playerLevel
            spec.requiredLevel = status.requiredLevel
            spec.specIndex = status.specIndex
            spec.specName = status.specName
            spec.lastCheck = status.lastCheck
        end
    end

    -- Now that game APIs are stable, update all state
    -- This includes glyphs, talents, equipment, etc. that require game APIs
    self:UpdateAllState()

    -- System is now ready for gameplay (rotations, timers, etc.)
    if self.debug then
        self:Debug("StateManager: All gameplay state initialized - system ready")
    end
end

--- Now safe to access DataManager and other services (kept for compatibility)

-- ============================ STANDARDIZED STATE UPDATE METHODS ============================

--- Update all core player state (basic info, class, race, GUID)

--- Update all gameplay state (forms, pet, glyphs)
--- @param self StateManager
function StateManager:UpdateAllGameplayState()
    self:UpdateFormsState()
    self:UpdatePetState()

    -- Update version-specific gameplay state
    -- Glyph system (Wrath, Cata, Mists) - UpdateGlyphState handles API availability
    if Version:IsWrath() or Version:IsCata() or Version:IsMists() then
        self:UpdateGlyphState()
    end
    if Version:IsSoD() then
        self:UpdateRuneState()
    end
end

--- Update all specialization and talent state
--- @param self StateManager
function StateManager:UpdateAllSpecializationState()
    -- SpecCompat handles spec change detection and broadcasting via events
    -- No need to manually trigger spec change processing
    self:UpdateTalentState()
end

--- Update all state (full refresh)
--- @param self StateManager
function StateManager:UpdateAllState()
    self:UpdatePlayerState()
    self:UpdateEquipmentChangeState()
    self:UpdateAllGameplayState()
    self:UpdateAllSpecializationState()
end

--- Update state for entering world (lightweight refresh)
--- @param self StateManager
function StateManager:UpdateEnteringWorldState()
    -- SpecCompat handles spec change detection via PLAYER_ENTERING_WORLD event
    -- No need to manually trigger spec change processing
    -- CRITICAL: Update player state (including GUID) when entering world
    -- Player GUID can change when switching characters or reloading UI
    self:UpdatePlayerState()
    self:UpdateEquipmentChangeState()
    self:UpdateGroupState()
end

-- ============================ CACHE REFRESH SCHEDULING ============================

--- Request an equipment-related state refresh via CacheRefreshManager.
--- This prevents overlapping equipment refresh computations under heavy load.
--- @param source string|nil
function StateManager:RequestEquipmentChangeStateRefresh(source)
    CacheRefreshManager = CacheRefreshManager or NAG:GetModule("CacheRefreshManager", true)
    if not CacheRefreshManager then
        -- Fallback to immediate behavior if service isn't available
        self:UpdateEquipmentChangeState()
        return
    end

    local pr = CacheRefreshManager.PRIORITY and CacheRefreshManager.PRIORITY.COMBAT_NORMAL or 3
    if UnitAffectingCombat and UnitAffectingCombat("player") then
        pr = CacheRefreshManager.PRIORITY and CacheRefreshManager.PRIORITY.COMBAT_HIGH or 2
    end

    CacheRefreshManager:RequestRefresh("state:equipment", {
        priority = pr,
        minIntervalSec = 0.25,
    }, function()
        self:UpdateEquipmentChangeState()
        return true
    end)
end

--- Update group/raid state
--- @param self StateManager
function StateManager:UpdateGroupState()
    local state = self.state.group
    local now = GetTime()

    -- Prevent excessive updates (max once every 0.5 seconds)
    if state.lastUpdate and (now - state.lastUpdate) < 0.5 then
        return
    end

    -- Update actual group state
    state.inRaid = UnitInRaid("player") and true or false
    state.inParty = UnitInParty("player") and true or false
    state.memberCount = GetNumGroupMembers()
    state.lastUpdate = now

    if self.debug then
        self:Debug("UpdateGroupState: raid=%s, party=%s, members=%d",
            tostring(state.inRaid), tostring(state.inParty), state.memberCount)
    end
end

--- Update state for equipment changes (targeted refresh)
--- This is the primary function for updating all equipment-related state
--- @param self StateManager
function StateManager:UpdateEquipmentChangeState()
    if self.debug then self:Debug("UpdateEquipmentChangeState: Updating equipment state") end
    self:UpdateEquipmentState()
    self:UpdateTierSetState()
    self:UpdateTrinketState()
    self:UpdateTinkerState()
    self:UpdateIlvlState()

    -- Update version-specific equipment state
    if Version:IsSoD() then
        self:UpdateRuneState()
    end
end

function StateManager:UpdatePlayerState()
    local state = self.state.player
    -- Update class info
    local classFileName = NAG.CLASS_FILENAME
    --state.classInfo.id = classId
    state.classInfo.name = classFileName     -- NAG.CLASS_FILENAME
    state.classInfo.fileName = classFileName -- NAG.CLASSFILE

    state.guid = UnitGUID("player")          -- NAG.GUID
    local _, raceName, raceId = UnitRace("player")
    state.raceInfo.name = raceName
    state.raceInfo.id = raceId -- NAG.RACEID
    NAG.GUID = state.guid
end

-- Spec change events are handled by SpecCompat module
-- SpecCompat handles version differences and broadcasts NAG_SPEC_UPDATED message
-- StateManager responds to NAG_SPEC_UPDATED message instead of raw events

-- Helper function to check Death Knight rune conversion
function StateManager:CheckDeathKnightRuneConversion()
    if not (Version:IsCata() or Version:IsMists()) then return end
    if UnitClassBase('player') ~= "DEATHKNIGHT" then return end

    -- Get current spec index from SpecCompat (source of truth)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not specIndex then return end

    -- Check if we're in Frost spec (specIndex 2 for Death Knight)
    if specIndex == 2 then -- Frost spec
        -- Check blood runes (slots 1 and 2)
        for slot = Types:GetType("RuneSlot").SlotLeftBlood, Types:GetType("RuneSlot").SlotRightBlood do
            local runeType = GetRuneType(slot)
            if runeType ~= Types:GetType("RuneType").RuneDeath then
                -- If we have blood runes in Frost spec, they should be death runes
                self:Print(format(
                    "Warning: Blood rune in slot %d should be a death rune in Frost spec. You should reload your UI.",
                    slot))
            end
        end
    end
end


--- Handle NAG_SPEC_UPDATED message from SpecCompat
--- Handles rotation state invalidation and Death Knight rune conversion when spec changes
--- SpecCompat is the single source of truth for spec data and notifications
--- @param message string The message name
--- @param payload table The message payload
function StateManager:NAG_SPEC_UPDATED(message, payload)
    if self.debug then
        self:Debug("NAG_SPEC_UPDATED: Spec changed (trigger: %s, specIndex: %s, available: %s)",
            payload and payload.triggerEvent or "unknown",
            payload and payload.specIndex or "nil",
            payload and tostring(payload.available) or "nil")
    end

    -- Update specInfo with full specialization status from SpecCompat
    if SpecCompat then
        local status = SpecCompat:GetSpecializationStatus()
        if status then
            local spec = self.state.player.specInfo
            spec.available = status.available
            spec.canHaveSpecs = status.canHaveSpecs
            spec.playerLevel = status.playerLevel
            spec.requiredLevel = status.requiredLevel
            spec.specIndex = status.specIndex
            spec.specName = status.specName
            spec.lastCheck = status.lastCheck

            if self.debug then
                self:Debug("NAG_SPEC_UPDATED: Updated specInfo (specIndex: %s, specName: %s, available: %s)",
                    tostring(spec.specIndex), tostring(spec.specName), tostring(spec.available))
            end
        end
    end

    -- Note: Talent state is updated via NAG_TALENTS_UPDATED message (also sent by SpecCompat on spec change)
    -- This prevents duplicate talent processing when spec changes

    -- Check Death Knight rune conversion if spec changed
    if payload and payload.specIndex then
        self:CheckDeathKnightRuneConversion()
    end

    -- Specialization changed - rotations are spec-specific
    -- Note: Rotation selection happens in OnSpecChange() which triggers NAG_ROTATION_CHANGED
    -- Item swap will be updated when rotation changes via NAG_ROTATION_CHANGED
end


function StateManager:UpdateEquipmentState()
    local state = self.state.player.equipment

    -- Reset enchant cache
    wipe(state.enchants)

    -- Define slot categories for better organization
    local slotCategories = {
        weapons = { 16, 17 },  -- Main hand and off hand
        trinkets = { 13, 14 }, -- Trinket slots (for equipment processing, not state storage)
        tinkers = { 6, 10, 15 },   -- Belt, gloves, cloak
        armor = {}             --{ 1, 2, 3, 4, 5, 7, 8, 9, 11, 12, 15, 18, 19 }, -- All armor slots
    }

    -- Track equipped items by checking each equipment slot
    for slot = 1, 19 do
        local itemId = GetInventoryItemID("player", slot)
        if itemId then
            -- Add or update the item in DataManager with appropriate flags based on slot
            local flags = { equipped = true }
            local path = { "Items" }

            -- Determine slot category and add appropriate flags
            if tContains(slotCategories.weapons, slot) then
                flags.weapon = true
                table.insert(path, "Weapons")
            elseif tContains(slotCategories.trinkets, slot) then
                flags.trinket = true
                table.insert(path, "Trinket")
            elseif tContains(slotCategories.tinkers, slot) then
                flags.tinker = true
                table.insert(path, "Engineering")
            elseif tContains(slotCategories.armor, slot) then
                flags.armor = true
                table.insert(path, "Armor")
            end

            -- Add item to DataManager (now safe to call)
            DataManager:AddItem(itemId, path, {
                slot = slot,
                flags = flags
            })

            -- Cache enchant data for this slot
            local itemLink = GetInventoryItemLink("player", slot)
            if itemLink then
                local enchantId = self:GetEnchantIdFromItemLink(itemLink)
                if enchantId and enchantId > 0 then
                    state.enchants[slot] = enchantId
                end
            end
        end
    end

    -- Track weapon configuration changes for potential future use
    local oldWeaponConfig = state.weaponConfig
    local newWeaponConfig = self:DetectWeaponConfiguration()

    if oldWeaponConfig ~= newWeaponConfig then
        state.weaponConfig = newWeaponConfig
    end

    -- Update ilvl calculations
    self:UpdateIlvlState()

    -- Note: Dependent states are updated by calling functions, not here
    -- This prevents double calling and ensures proper update order
    self:RefreshItemSwapActiveSet()
end

--- Detect the current weapon configuration (dual-wield vs two-hand)
--- @return string|nil The weapon configuration: "dualWield", "twoHand", or nil if unknown
function StateManager:DetectWeaponConfiguration()
    local mainHand = GetInventoryItemID("player", 16)
    local offHand = GetInventoryItemID("player", 17)

    if not mainHand then
        return nil -- No main hand weapon
    end

    if offHand then
        return "dualWield"
    else
        return "twoHand"
    end
end

--- Helper function to extract enchant ID from item link
--- @param itemLink string The item link to extract enchant ID from
--- @return number|nil The enchant ID if found, nil otherwise
function StateManager:GetEnchantIdFromItemLink(itemLink)
    if not itemLink then return nil end

    local itemString = itemLink:match("item:([%-?%d:]+)")
    if not itemString then return nil end

    local enchantID = itemString:match("^%d+:(%d+)")
    return tonumber(enchantID)
end

-- ~~~~~~~~~~ Item Level Calculation System ~~~~~~~~~~

--- Calculate the base item level for a given item
--- @param itemId number The item ID to calculate ilvl for
--- @param slot number The equipment slot (for context)
--- @return number|nil The base item level, or nil if not found
function StateManager:CalculateItemIlvl(itemId, slot)
    if not itemId then return nil end

    -- Get item info - ilvl is typically field 4 in GetItemInfo
    local ilvl = select(4, WoWAPI.GetItemInfo(itemId))

    if not ilvl or ilvl <= 0 then
        if self.debug then
            self:Debug("CalculateItemIlvl: Invalid ilvl %s for item %d in slot %d", tostring(ilvl), itemId,
                slot)
        end
        return nil
    end

    return ilvl
end

--- Calculate the effective item level including all modifications (gems, enchants, reforging, tinkers)
--- This matches the WoWSims approach of calculating modified ilvl
--- @param itemId number The item ID to calculate ilvl for
--- @param slot number The equipment slot (for context)
--- @return number|nil The effective item level, or nil if not found
function StateManager:CalculateEffectiveIlvl(itemId, slot)
    if not itemId then return nil end

    local baseIlvl = self:CalculateItemIlvl(itemId, slot)
    if not baseIlvl then return nil end

    local effectiveIlvl = baseIlvl
    local itemLink = GetInventoryItemLink("player", slot)

    if not itemLink then return baseIlvl end

    -- Calculate gem contributions
    local gemIlvl = self:CalculateGemIlvlContribution(itemId, slot, itemLink)
    effectiveIlvl = effectiveIlvl + gemIlvl

    -- Calculate enchant contributions
    local enchantIlvl = self:CalculateEnchantIlvlContribution(itemId, slot, itemLink)
    effectiveIlvl = effectiveIlvl + enchantIlvl

    -- Calculate tinker contributions (for SoD)
    if Version:IsSoD() then
        local tinkerIlvl = self:CalculateTinkerIlvlContribution(itemId, slot)
        effectiveIlvl = effectiveIlvl + tinkerIlvl
    end

    -- Calculate reforging contributions (stat-based approach)
    local reforgeIlvl = self:CalculateReforgeIlvlContribution(itemId, slot)
    effectiveIlvl = effectiveIlvl + reforgeIlvl

    return effectiveIlvl
end

--- Calculate gem ilvl contribution for an item
--- @param itemId number The item ID
--- @param slot number The equipment slot
--- @param itemLink string The item link
--- @return number The ilvl contribution from gems
function StateManager:CalculateGemIlvlContribution(itemId, slot, itemLink)
    local totalGemIlvl = 0

    -- Parse the item link for gems
    local gemData = strmatch(itemLink, "item:%d+:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:([^:]*):")
    if gemData and gemData ~= "" then
        local gems = { strsplit(":", gemData) }
        for _, gemId in ipairs(gems) do
            if gemId and gemId ~= "0" then
                local gemIlvl = self:GetGemIlvlBonus(tonumber(gemId))
                if gemIlvl then
                    totalGemIlvl = totalGemIlvl + gemIlvl
                end
            end
        end
    end

    -- Alternative method: Use GetItemGem API if available
    if totalGemIlvl == 0 and GetItemGem then
        for gemSlot = 1, 3 do
            local gemId = GetItemGem(itemId, gemSlot)
            if gemId and gemId > 0 then
                local gemIlvl = self:GetGemIlvlBonus(gemId)
                if gemIlvl then
                    totalGemIlvl = totalGemIlvl + gemIlvl
                end
            end
        end
    end

    return totalGemIlvl
end

--- Calculate enchant ilvl contribution for an item
--- @param itemId number The item ID
--- @param slot number The equipment slot
--- @param itemLink string The item link
--- @return number The ilvl contribution from enchants
function StateManager:CalculateEnchantIlvlContribution(itemId, slot, itemLink)
    -- Parse item link for enchant data
    local enchantData = strmatch(itemLink, "item:%d+:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:([^:]*):")
    if enchantData and enchantData ~= "" then
        local enchantId = tonumber(enchantData)
        if enchantId and enchantId > 0 then
            return self:GetEnchantIlvlBonus(enchantId, slot)
        end
    end

    return 0
end

--- Calculate tinker ilvl contribution for an item (SoD)
--- @param itemId number The item ID
--- @param slot number The equipment slot
--- @return number The ilvl contribution from tinkers
function StateManager:CalculateTinkerIlvlContribution(itemId, slot)
    -- Check if this slot has a tinker
    local tinkerInfo = self:GetTinkerInfo(slot)
    if tinkerInfo and tinkerInfo.spellId then
        return self:GetTinkerIlvlBonus(tinkerInfo.spellId, slot)
    end

    return 0
end

--- Calculate reforging ilvl contribution using stat-based approach
--- @param itemId number The item ID
--- @param slot number The equipment slot
--- @return number The ilvl contribution from reforging
function StateManager:CalculateReforgeIlvlContribution(itemId, slot)
    -- This is a simplified approach - in practice, you'd need to track reforging changes
    -- For now, we'll use a small bonus to represent the stat optimization
    return 2 -- Approximate ilvl bonus from reforging optimization
end

--- Get enchant ilvl bonus
--- @param enchantId number The enchant ID
--- @param slot number The equipment slot
--- @return number The ilvl bonus from the enchant
function StateManager:GetEnchantIlvlBonus(enchantId, slot)
    -- Get enchant info from DataManager first
    local enchant = getDataEntity(enchantId, DataManager.EntityTypes.ENCHANT)
    if enchant and enchant.ilvlBonus then
        return enchant.ilvlBonus
    end

    -- Fallback: Estimate based on slot type
    local slotBonus = 0
    if slot == 16 or slot == 17 then     -- Weapons
        slotBonus = 8
    elseif slot == 13 or slot == 14 then -- Trinkets
        slotBonus = 0                    -- Trinkets typically don't have enchants
    else                                 -- Armor slots
        slotBonus = 4
    end

    return slotBonus
end

--- Get tinker ilvl bonus (SoD)
--- @param spellId number The tinker spell ID
--- @param slot number The equipment slot
--- @return number The ilvl bonus from the tinker
function StateManager:GetTinkerIlvlBonus(spellId, slot)
    -- Get tinker info from DataManager first
    local tinker = getDataEntity(spellId, DataManager.EntityTypes.SPELL)
    if tinker and tinker.ilvlBonus then
        return tinker.ilvlBonus
    end

    -- Fallback: Standard tinker bonus
    return 3
end

--- Calculate the gemmed item level for a given item (legacy method)
--- @param itemId number The item ID to calculate ilvl for
--- @param slot number The equipment slot (for context)
--- @return number|nil The gemmed item level, or nil if not found
function StateManager:CalculateGemmedIlvl(itemId, slot)
    if not itemId then return nil end

    local baseIlvl = self:CalculateItemIlvl(itemId, slot)
    if not baseIlvl then return nil end

    local gemmedIlvl = baseIlvl
    local itemLink = GetInventoryItemLink("player", slot)

    if not itemLink then return baseIlvl end

    -- Check for gems in the item
    local gemCount = 0
    local totalGemIlvl = 0

    -- Parse the item link for gems
    -- Item links typically have gem data embedded
    local gemData = strmatch(itemLink, "item:%d+:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:([^:]*):")
    if gemData and gemData ~= "" then
        -- Parse gem data (this is a simplified approach)
        -- In practice, you might need more sophisticated parsing based on the WoW version
        local gems = { strsplit(":", gemData) }
        for _, gemId in ipairs(gems) do
            if gemId and gemId ~= "0" then
                local gemIlvl = self:GetGemIlvlBonus(tonumber(gemId))
                if gemIlvl then
                    totalGemIlvl = totalGemIlvl + gemIlvl
                    gemCount = gemCount + 1
                end
            end
        end
    end

    -- Alternative method: Use GetItemGem API if available
    if gemCount == 0 then
        gemmedIlvl = self:CalculateGemmedIlvlViaAPI(itemId, slot, baseIlvl)
    else
        gemmedIlvl = baseIlvl + totalGemIlvl
    end

    return gemmedIlvl
end

--- Calculate gemmed ilvl using WoW API methods
--- @param itemId number The item ID
--- @param slot number The equipment slot
--- @param baseIlvl number The base item level
--- @return number The gemmed item level
function StateManager:CalculateGemmedIlvlViaAPI(itemId, slot, baseIlvl)
    local gemmedIlvl = baseIlvl

    -- Try to get gem information using available APIs
    -- This approach varies by WoW version
    if GetItemGem then
        -- Check each gem slot
        for gemSlot = 1, 3 do -- Most items have max 3 gem slots
            local gemId = GetItemGem(itemId, gemSlot)
            if gemId and gemId > 0 then
                local gemIlvl = self:GetGemIlvlBonus(gemId)
                if gemIlvl then
                    gemmedIlvl = gemmedIlvl + gemIlvl
                end
            end
        end
    end

    return gemmedIlvl
end

--- Get the ilvl bonus provided by a gem
--- @param gemId number The gem item ID
--- @return number|nil The ilvl bonus, or nil if not found
function StateManager:GetGemIlvlBonus(gemId)
    if not gemId then return nil end

    -- Get gem info from DataManager first
    local gem = getDataEntity(gemId, DataManager.EntityTypes.ITEM)
    if gem and gem.ilvlBonus then
        return gem.ilvlBonus
    end

    -- Fallback: Use hardcoded gem ilvl bonuses based on gem quality/type
    -- This is a simplified approach - in practice you'd want this data in DataManager
    local quality = select(3, WoWAPI.GetItemInfo(gemId))
    if not quality then return nil end

    -- Approximate ilvl bonuses by gem quality (this varies by expansion)
    local ilvlBonus = 0
    if quality == 2 then     -- Uncommon
        ilvlBonus = 2
    elseif quality == 3 then -- Rare
        ilvlBonus = 3
    elseif quality == 4 then -- Epic
        ilvlBonus = 4
    elseif quality == 5 then -- Legendary
        ilvlBonus = 5
    end

    return ilvlBonus
end

--- Update the overall ilvl state for all equipped items
function StateManager:UpdateIlvlState()
    local state = self.state.player.equipment.ilvl
    local now = GetTime()

    -- Prevent excessive updates
    if state.lastUpdate and (now - state.lastUpdate) < 1.0 then
        return
    end

    -- Reset ilvl tracking
    wipe(state.items)
    wipe(state.gemmed)
    wipe(state.effective)

    local totalIlvl = 0
    local gemmedTotalIlvl = 0
    local effectiveTotalIlvl = 0
    local itemCount = 0
    local weightedTotal = 0
    local totalWeight = 0

    -- Define slot weights for weighted average calculation
    local slotWeights = {
        [16] = 2.0, -- Main hand weapon (double weight)
        [17] = 1.5, -- Off hand weapon (1.5x weight)
        [13] = 1.2, -- Trinket 1 (slight bonus)
        [14] = 1.2, -- Trinket 2 (slight bonus)
        -- All other slots default to 1.0 weight
    }

    -- Calculate ilvl for each equipped slot
    for slot = 1, 19 do
        local itemId = GetInventoryItemID("player", slot)
        if itemId then
            local baseIlvl = self:CalculateItemIlvl(itemId, slot)
            local gemmedIlvl = self:CalculateGemmedIlvl(itemId, slot)
            local effectiveIlvl = self:CalculateEffectiveIlvl(itemId, slot)

            if baseIlvl then
                state.items[slot] = baseIlvl
                state.gemmed[slot] = gemmedIlvl or baseIlvl
                state.effective[slot] = effectiveIlvl or baseIlvl

                totalIlvl = totalIlvl + baseIlvl
                gemmedTotalIlvl = gemmedTotalIlvl + (gemmedIlvl or baseIlvl)
                effectiveTotalIlvl = effectiveTotalIlvl + (effectiveIlvl or baseIlvl)
                itemCount = itemCount + 1

                -- Calculate weighted total
                local weight = slotWeights[slot] or 1.0
                weightedTotal = weightedTotal + (baseIlvl * weight)
                totalWeight = totalWeight + weight

                if self.debug then
                    self:Trace("Slot %d: Base ilvl %d, Gemmed ilvl %d, Effective ilvl %d", slot, baseIlvl,
                        gemmedIlvl or baseIlvl, effectiveIlvl or baseIlvl)
                end
            end
        end
    end

    -- Update state values
    state.total = totalIlvl
    state.gemmedTotal = gemmedTotalIlvl
    state.effectiveTotal = effectiveTotalIlvl
    state.average = itemCount > 0 and (totalIlvl / itemCount) or 0
    state.gemmedAverage = itemCount > 0 and (gemmedTotalIlvl / itemCount) or 0
    state.effectiveAverage = itemCount > 0 and (effectiveTotalIlvl / itemCount) or 0
    state.weighted = totalWeight > 0 and (weightedTotal / totalWeight) or 0
    state.lastUpdate = now

    if self.debug then
        self:Trace(
            "Ilvl Update: Total=%d, Average=%.1f, GemmedTotal=%d, GemmedAverage=%.1f, EffectiveTotal=%d, EffectiveAverage=%.1f, Weighted=%.1f",
            totalIlvl, state.average, gemmedTotalIlvl, state.gemmedAverage, effectiveTotalIlvl, state.effectiveAverage,
            state.weighted)
    end
end

-- ~~~~~~~~~~ External Helper Methods for Ilvl Access ~~~~~~~~~~

--- Get the total base item level
--- @return number The total base item level
function StateManager:GetTotalIlvl()
    return self.state.player.equipment.ilvl.total
end

--- Get the average base item level
--- @return number The average base item level
function StateManager:GetAverageIlvl()
    return self.state.player.equipment.ilvl.average
end

--- Get the weighted average item level
--- @return number The weighted average item level
function StateManager:GetWeightedIlvl()
    return self.state.player.equipment.ilvl.weighted
end

--- Get the total gemmed item level
--- @return number The total gemmed item level
function StateManager:GetTotalGemmedIlvl()
    return self.state.player.equipment.ilvl.gemmedTotal
end

--- Get the average gemmed item level
--- @return number The average gemmed item level
function StateManager:GetAverageGemmedIlvl()
    return self.state.player.equipment.ilvl.gemmedAverage
end

--- Get the total effective item level (including all modifications)
--- @return number The total effective item level
function StateManager:GetTotalEffectiveIlvl()
    return self.state.player.equipment.ilvl.effectiveTotal
end

--- Get the average effective item level (including all modifications)
--- @return number The average effective item level
function StateManager:GetAverageEffectiveIlvl()
    return self.state.player.equipment.ilvl.effectiveAverage
end

--- Get the item level for a specific slot
--- @param slot number The equipment slot (1-19)
--- @param includeGems? boolean Whether to include gem bonuses (default: false)
--- @return number|nil The item level for the slot, or nil if no item equipped
function StateManager:GetItemIlvl(slot, includeGems)
    local state = self.state.player.equipment.ilvl
    if includeGems then
        return state.gemmed[slot]
    else
        return state.items[slot]
    end
end

--- Get the effective item level for a specific slot (including all modifications)
--- @param slot number The equipment slot (1-19)
--- @return number|nil The effective item level for the slot, or nil if no item equipped
function StateManager:GetEffectiveItemIlvl(slot)
    return self.state.player.equipment.ilvl.effective[slot]
end

--- Get all item levels as a table
--- @param includeGems? boolean Whether to include gem bonuses (default: false)
--- @return table Table of slot -> ilvl mappings
function StateManager:GetAllItemIlvls(includeGems)
    local state = self.state.player.equipment.ilvl
    if includeGems then
        return state.gemmed
    else
        return state.items
    end
end

--- Get all effective item levels as a table (WoWSims style)
--- @return table Table of slot -> effective ilvl mappings
function StateManager:GetAllEffectiveItemIlvls()
    return self.state.player.equipment.ilvl.effective
end

--- Force refresh of ilvl calculations
function StateManager:RefreshIlvlCalculations()
    self.state.player.equipment.ilvl.lastUpdate = 0
    self:UpdateIlvlState()
end

--- Get comprehensive ilvl information for scaling calculations
--- This method provides all ilvl data needed for external modules like mage combustion calculations
--- @param includeGems? boolean Whether to include gem bonuses (default: true for scaling calculations)
--- @return table Comprehensive ilvl information
function StateManager:GetIlvlInfo(includeGems)
    includeGems = includeGems ~= false -- Default to true for scaling calculations

    local state = self.state.player.equipment.ilvl

    -- Ensure ilvl is up to date
    if not state.lastUpdate or (GetTime() - state.lastUpdate) > 5.0 then
        self:UpdateIlvlState()
    end

    return {
        -- Basic ilvl values
        total = includeGems and state.gemmedTotal or state.total,
        average = includeGems and state.gemmedAverage or state.average,
        weighted = state.weighted,

        -- Individual slot ilvls
        items = includeGems and state.gemmed or state.items,

        -- Scaling factors (normalized to a reasonable range)
        scalingFactor = self:CalculateIlvlScalingFactor(includeGems),

        -- Quality indicators
        quality = self:CalculateIlvlQuality(includeGems),

        -- Last update time
        lastUpdate = state.lastUpdate
    }
end

--- Calculate an ilvl scaling factor for damage calculations
--- This provides a normalized value that can be used to scale damage estimates
--- @param includeGems? boolean Whether to include gem bonuses
--- @return number Scaling factor (typically 0.5 to 2.0 range)
function StateManager:CalculateIlvlScalingFactor(includeGems)
    local avgIlvl = includeGems and self:GetAverageGemmedIlvl() or self:GetAverageIlvl()

    -- Base scaling calculation - this can be adjusted based on expansion/balance
    -- For MoP, typical ilvl ranges are 400-600, so we normalize to a reasonable scaling factor
    local baseIlvl = 400 -- Base ilvl for scaling calculations
    local scalingFactor = avgIlvl / baseIlvl

    -- Clamp to reasonable range to prevent extreme values
    scalingFactor = max(0.5, min(2.0, scalingFactor))

    return scalingFactor
end

--- Calculate ilvl quality indicator for UI/feedback purposes
--- @param includeGems? boolean Whether to include gem bonuses
--- @return string Quality indicator ("Low", "Medium", "High", "Max")
function StateManager:CalculateIlvlQuality(includeGems)
    local avgIlvl = includeGems and self:GetAverageGemmedIlvl() or self:GetAverageIlvl()

    -- Quality thresholds (adjust based on expansion)
    if avgIlvl >= 580 then
        return "Max"
    elseif avgIlvl >= 540 then
        return "High"
    elseif avgIlvl >= 500 then
        return "Medium"
    else
        return "Low"
    end
end

--- Get ilvl scaling factor specifically for mage combustion calculations
--- This method provides a pre-calculated scaling factor optimized for mage dot damage
--- @return number Scaling factor for mage combustion calculations
function StateManager:GetMageCombustionScalingFactor()
    local ilvlInfo = self:GetIlvlInfo(true) -- Include gems for mage calculations

    -- Mage-specific scaling adjustments
    -- Combustion benefits more from higher ilvl, so we can use a slightly higher scaling
    local baseScaling = ilvlInfo.scalingFactor

    -- Apply mage-specific modifiers if needed
    -- For now, return the base scaling - this can be enhanced with spec-specific logic
    return baseScaling
end

--- Debug method to display current ilvl information
--- This can be called via slash command for testing
function StateManager:DebugIlvlInfo()
    self:RefreshIlvlCalculations()

    local woWSimsInfo = self:GetWoWSimsStyleIlvlInfo(true)
    local baseIlvlInfo = self:GetIlvlInfo(false)

    self:Print("=== WoWSims-Style Item Level Information ===")
    self:Print(format("Base Average Ilvl: %.1f", baseIlvlInfo.average))
    self:Print(format("Gemmed Average Ilvl: %.1f", woWSimsInfo.gemmedAverage))
    self:Print(format("Effective Average Ilvl: %.1f", woWSimsInfo.effectiveAverage))
    self:Print(format("Weighted Ilvl: %.1f", woWSimsInfo.weighted))
    self:Print(format("Ilvl Scaling Factor: %.3f", woWSimsInfo.ilvlScalingFactor))
    self:Print(format("Stat-Based Scaling Factor: %.3f", woWSimsInfo.statBasedScalingFactor))
    self:Print(format("Mage Combustion Scaling: %.3f", woWSimsInfo.mageCombustionScalingFactor))
    self:Print(format("Quality: %s", woWSimsInfo.quality))

    -- Show individual slot ilvls with effective ilvl
    self:Print("=== Slot Breakdown (WoWSims Style) ===")
    for slot = 1, 19 do
        local baseIlvl = self:GetItemIlvl(slot, false)
        local gemmedIlvl = self:GetItemIlvl(slot, true)
        local effectiveIlvl = self:GetEffectiveItemIlvl(slot)
        if baseIlvl then
            local slotName = self:GetSlotName(slot)
            self:Print(format("Slot %d (%s): Base=%d, Gemmed=%d, Effective=%d",
                slot, slotName, baseIlvl, gemmedIlvl or baseIlvl, effectiveIlvl or baseIlvl))
        end
    end

    -- Show character stats for stat-based scaling
    local stats = self:GetCharacterStats()
    self:Print("=== Character Stats for Scaling ===")
    self:Print(format("Spell Power: %d", stats.spellPower))
    self:Print(format("Spell Crit: %.2f%%", stats.spellCrit))
    self:Print(format("Spell Haste: %.2f%%", stats.spellHaste))
    self:Print(format("Mastery: %.2f%%", stats.mastery))
end

--- Get slot name for display purposes
--- @param slot number The equipment slot
--- @return string The slot name
function StateManager:GetSlotName(slot)
    local slotNames = {
        [1] = "Head",
        [2] = "Neck",
        [3] = "Shoulder",
        [4] = "Shirt",
        [5] = "Chest",
        [6] = "Waist",
        [7] = "Legs",
        [8] = "Boots",
        [9] = "Wrist",
        [10] = "Hands",
        [11] = "Ring1",
        [12] = "Ring2",
        [13] = "Trinket1",
        [14] = "Trinket2",
        [15] = "Back",
        [16] = "MainHand",
        [17] = "OffHand",
        [18] = "Ranged",
        [19] = "Tabard"
    }
    return slotNames[slot] or "Unknown"
end

function StateManager:UpdateTierSetState()
    local state = self.state.player.equipment

    -- Reset tier set counts
    wipe(state.tierSets)
    wipe(state.tiers or {})
    state.tiers = state.tiers or {}

    -- Track tier sets by checking each equipment slot
    for slot = 1, 19 do
        local itemId = GetInventoryItemID("player", slot)
        if itemId and itemId > 0 then
            -- GetItemInfo can be nil briefly (fresh caches / uncached item data)
            local itemName, _, _, _, _, _, _, _, _, _, _, _, _, _, _, tiersetId = WoWAPI.GetItemInfo(itemId)
            if not itemName then
                -- Request item data and retry once it arrives (events handled below)
                if C_Item and C_Item.RequestLoadItemDataByID then
                    C_Item.RequestLoadItemDataByID(itemId)
                end
                self._pendingTierSetItemInfo = self._pendingTierSetItemInfo or {}
                self._pendingTierSetItemInfo[itemId] = true
            elseif tiersetId and tiersetId > 0 then
                state.tierSets[tiersetId] = (state.tierSets[tiersetId] or 0) + 1

                -- Get tierset info from DataManager (used to index by tier number)
                local tierset = getDataEntity(tiersetId, DataManager.EntityTypes.TIERSET)
                if tierset and tierset.tier then
                    state.tiers[tostring(tierset.tier)] = state.tiers[tostring(tierset.tier)] or {}
                    state.tiers[tostring(tierset.tier)][tiersetId] = state.tierSets[tiersetId]
                end
            end
        end
    end

    -- If any equipped items were uncached, schedule a single retry shortly.
    if self._pendingTierSetItemInfo and next(self._pendingTierSetItemInfo) ~= nil and not self._tierSetRetryScheduled then
        self._tierSetRetryScheduled = true
        if C_Timer and C_Timer.After then
            C_Timer.After(0.5, function()
                self._tierSetRetryScheduled = nil
                self:UpdateTierSetState()
            end)
        else
            self._tierSetRetryScheduled = nil
        end
    end
end

--- Get current tierset state for debugging or external access
--- @param self StateManager
--- @return table Current tierset state
function StateManager:GetTierSetState()
    return {
        tierSets = self.state.player.equipment.tierSets,
        tiers = self.state.player.equipment.tiers
    }
end

function StateManager:UpdateTrinketState()
    local state = self.state.player.equipment

    -- Don't process trinkets until startup is complete
    local EventManager = ns.EventManager
    if EventManager and EventManager.currentPhase < ns.StartupPhase.COMPLETE then
        self:Debug("UpdateTrinketState: Startup in progress, deferring trinket processing")
        return
    end

    -- Track equipped trinkets and their procs
    -- Note: AnalyzeTrinket() has its own readiness checks internally
    for slot = 13, 14 do
        local itemId = GetInventoryItemID("player", slot)
        local oldItemId = state.trinketData[slot] and state.trinketData[slot].itemId or nil

        -- Check if we need to process this trinket
        -- Since we now only process when data sources are ready, we can use simpler logic
        local needsProcessing = (itemId ~= oldItemId) or                    -- Trinket changed
                               (itemId and not state.trinketData[slot])      -- Have trinket but no data

        self:Debug("UpdateTrinketState: Slot %d - itemId=%s, oldItemId=%s, hasData=%s, needsProcessing=%s",
                  slot, tostring(itemId), tostring(oldItemId),
                  tostring(state.trinketData[slot] ~= nil), tostring(needsProcessing))

        if needsProcessing then
            -- Unregister old trinket's procs
            if oldItemId then
                local oldTrinket = getDataEntity(oldItemId, DataManager.EntityTypes.ITEM)
                if oldTrinket and oldTrinket.procId then
                    -- Unregister by clearing ICD tracking for this proc
                    SpellTrackingManager:UnregisterICD(oldTrinket.procId)
                end
                -- Clear retry counter for old item when trinket changes
                local oldRetryKey = slot .. "_" .. oldItemId
                self.trinketRetryCounts[oldRetryKey] = nil
            end

            -- Register new trinket
            if itemId then
                -- Analyze trinket using TrinketTrackingManager
                local result = TrinketTrackingManager:AnalyzeTrinket(itemId)

                -- CRITICAL FIX: Handle incomplete/pending trinket data with retry
                -- On initial load, tooltip may not have proc lines loaded yet
                -- Valid complete trinket must have: buffId AND (icd > 0 OR duration > 0)
                -- Note: statType1=-1 is VALID for trinkets without stat buffs (healing/damage trinkets)
                -- Schedule a single retry after 15 seconds to allow tooltip data to fully load
                local hasValidData = result and result.trinketInfo and
                                     result.trinketInfo.buffId and
                                     (result.trinketInfo.icd > 0 or result.trinketInfo.duration > 0)

                if not hasValidData then
                    -- Track retry count per slot+itemId combination
                    -- This ensures each unique item gets its own retry counter
                    local retryKey = slot .. "_" .. itemId
                    local retryCount = self.trinketRetryCounts[retryKey] or 0
                    local maxRetries = 2  -- Initial attempt + 2 retries = 3 total attempts

                    if retryCount < maxRetries then
                        if self.debug then
                            self:Debug("UpdateTrinketState: Trinket %d analysis incomplete, scheduling retry (%d/%d)", itemId, retryCount + 1, maxRetries)
                        end

                        -- Increment retry counter for this specific item
                        self.trinketRetryCounts[retryKey] = retryCount + 1

                        -- Schedule ONE retry (similar to tooltipCacheWaitTimer pattern)
                        local timerKey = "trinketRetry_" .. slot
                        if not self[timerKey] then
                            self[timerKey] = self:ScheduleTimer(function()
                                -- Check if we should still retry (item might have changed or max retries reached)
                                local currentItemId = GetInventoryItemID("player", slot)
                                local currentRetryKey = slot .. "_" .. currentItemId
                                local currentRetryCount = self.trinketRetryCounts[currentRetryKey] or 0

                                if currentItemId == itemId and currentRetryCount < maxRetries then
                                    if self.debug then
                                        self:Debug("UpdateTrinketState: Retrying trinket analysis for slot %d", slot)
                                    end
                                    self[timerKey] = nil
                                    -- Clear the slot data to force re-analysis
                                    state.trinketData[slot] = nil
                                    self:UpdateTrinketState()
                                else
                                    if self.debug then
                                        self:Debug("UpdateTrinketState: Skipping retry for slot %d (item changed or max retries reached)", slot)
                                    end
                                    self[timerKey] = nil
                                end
                            end, 15.0)  -- 15 seconds for tooltip data to fully load
                        end
                    else
                        if self.debug then
                            self:Debug("UpdateTrinketState: Trinket %d analysis incomplete, max retries (%d) reached, giving up", itemId, maxRetries)
                        end
                        -- Cancel any pending retry timer for this slot
                        local timerKey = "trinketRetry_" .. slot
                        if self[timerKey] then
                            self:CancelTimer(self[timerKey])
                            self[timerKey] = nil
                        end
                    end

                    -- Don't store incomplete data - leave slot empty
                    state.trinketData[slot] = nil
                    -- Continue to next slot instead of returning (we have 2 trinket slots)
                elseif result and result.trinketInfo then
                    -- Clear retry counter on successful analysis
                    local retryKey = slot .. "_" .. itemId
                    self.trinketRetryCounts[retryKey] = nil

                    -- Store analyzed trinket data in StateManager for efficient access
                    local trinketInfo = result.trinketInfo
                    state.trinketData[slot] = {
                        itemId = itemId,
                        trinketInfo = trinketInfo,
                        lastUpdate = GetTime()
                    }
                    self:Debug(
                        "UpdateTrinketState: Stored trinket data for slot %d: statType1=%s, statType2=%s, statType3=%s",
                        slot, tostring(trinketInfo.statType1), tostring(trinketInfo.statType2),
                        tostring(trinketInfo.statType3))

                    -- If we got valid info from tooltip parsing
                    if trinketInfo.buffId then
                    -- Create item data for DataManager
                    local itemData = {
                        slot = slot,
                        procId = trinketInfo.buffId,
                        spellId = trinketInfo.buffId,
                        duration = trinketInfo.duration,
                        ICD = trinketInfo.icd,
                        flags = {
                            equipped = true,
                            trinket = true,
                            proc = trinketInfo.isProc,
                            use = trinketInfo.isUse
                        }
                    }

                    -- Add to DataManager
                    local trinket = DataManager:AddItem(itemId, { "Items", "Trinket" }, itemData)

                    -- Create spell data for the proc/buff
                    local spellData = {
                        duration = trinketInfo.duration,
                        parentId = itemId,
                        parentType = DataManager.EntityTypes.ITEM,
                        ICD = trinketInfo.icd,
                        flags = {
                            proc = trinketInfo.isProc,
                            trinket = true
                        }
                    }

                    -- Add spell to DataManager (only if buffId is valid)
                    if trinketInfo.buffId and trinketInfo.buffId > 0 then
                        DataManager:AddSpell(trinketInfo.buffId, { "Spells", "Trinket" }, spellData)
                    end

                    -- Register ICD with SpellTrackingManager if it has one
                    if trinketInfo.icd and trinketInfo.icd > 0 then
                        SpellTrackingManager:RegisterICD(trinketInfo.buffId, trinketInfo.icd)
                    end
                else
                    -- Fallback to basic registration
                    local trinket = DataManager:AddItem(itemId, { "Items", "Trinket" }, {
                        slot = slot,
                        flags = {
                            equipped = true,
                            trinket = true
                        }
                    })

                    -- Register proc with SpellTrackingManager if trinket has one
                    if trinket and trinket.procId and trinket.ICD then
                        SpellTrackingManager:RegisterICD(trinket.procId, trinket.ICD)
                    end
                end
                elseif result and result.needsRegistration then
                    -- Trigger registration for this trinket
                    local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
                    if TrinketRegistrationManager then
                        if self.debug then
                            self:Debug("Trinket %d needs registration, triggering registration workflow", itemId)
                        end
                        -- Check if trinket actually needs registration before triggering
                        if TrinketRegistrationManager:CheckTrinketRegistration(itemId) then
                            TrinketRegistrationManager:StartRegistration(itemId)
                        end
                    end
                    state.trinketData[slot] = nil
                else
                    state.trinketData[slot] = nil
                end
            end
        end
    end
end

function StateManager:UpdateTinkerState()
    local state = self.state.player.equipment

    -- Reset tinker slots
    state.tinkers[6] = nil  -- Reset waist
    state.tinkers[10] = nil -- Reset hands
    state.tinkers[15] = nil -- Reset cloak

    -- Check all tinker slots
    self:CheckTinkerSlot(6)  -- Waist
    self:CheckTinkerSlot(10) -- Hands
    self:CheckTinkerSlot(15) -- Cloak
end

-- Helper function to check and update a single tinker slot
function StateManager:CheckTinkerSlot(slot)
    local state = self.state.player.equipment
    local itemId = GetInventoryItemID("player", slot)

    if not itemId then return end

    local isUsable = IsUsableItem(itemId)
    if not isUsable then
        return
    end

    -- GetItemSpell returns multiple values: (spellName, spellID)
    local tinkerName, spellId = GetItemSpell(itemId)
    if not tinkerName then return end
    if not spellId or spellId <= 0 then return end

    -- Create or update item entry in DataManager
    local itemPath = { "Items", "Engineering", "tinker" }
    local itemData = {
        spellId = spellId,
        slot = slot,
        flags = {
            tinker = true,
            hasSpell = true
        },
    }
    DataManager:AddItem(itemId, itemPath, itemData)

    -- Create or update spell entry in DataManager
    local spellPath = { "Spells" }
    local spellData = {
        name = tinkerName,
        itemId = itemId,
        slot = slot,
        flags = {
            tinker = true,
        },
        parentId = itemId,
        parentType = DataManager.EntityTypes.ITEM
    }
    DataManager:AddSpell(spellId, spellPath, spellData)

    -- Update state for immediate use
    state.tinkers[slot] = {
        itemId = itemId,
        spellId = spellId,
        name = tinkerName,
        icon = GetItemIcon(itemId),
    }
end

function StateManager:ResetCombat()
    local state = self.state
    state.combat.time = 0
    state.combat.startTime = nil
    state.player.lastCast = 0

    -- Reset combat-related variables
    NAG.waitUntilTime = 0
    NAG.isSequenceActive = false

    -- Clear all sequence arrows
    OverlayManager:ClearAllSequenceArrows()
    -- Clear all active overlays (this includes notifications)
    -- Since OverlayManager manages all overlays, we can clear them all
    if OverlayManager.state and OverlayManager.state.activeOverlays then
        for overlayKey, overlayData in pairs(OverlayManager.state.activeOverlays) do
            if overlayData.overlay then
                overlayData.overlay:Hide()
            end
        end
        wipe(OverlayManager.state.activeOverlays)
    end

    NAG:ResetSequences()
    NAG:ResetStrictSequences()

    -- Reset TTD data

    TTDManager:ResetTTD()

    -- Reset caches
    self.auraCache = setmetatable({}, { __mode = "kv" })
    self.itemBuffCache = setmetatable({}, { __mode = "kv" })

    -- Clear rotation switching cache when combat ends
    -- This ensures fresh evaluation of rotation switching conditions on next combat
    NAG:GetModule("RotationManager"):ClearRotationSwitchingCache()
end

-- Helper function to check if a slot has a tinker
function StateManager:HasTinker(slot)
    local state = self.state.player.equipment
    return state.tinkers[slot] ~= nil
end

-- Helper function to get tinker info for a slot
function StateManager:GetTinkerInfo(slot)
    local state = self.state.player.equipment
    return state.tinkers[slot]
end

--- Get tinker info by spell ID (for icon/cooldown resolution).
--- Returns the tinker's itemId and icon (gloves) when the spellId matches an equipped tinker.
--- @param spellId number The tinker spell ID
--- @return table|nil { itemId, icon } or nil if not a tinker
function StateManager:GetTinkerInfoBySpellId(spellId)
    if not spellId then return nil end
    local state = self.state.player.equipment
    for _, slot in ipairs({ 6, 10, 15 }) do
        local info = state.tinkers[slot]
        if info and info.spellId == spellId then
            return info
        end
    end
    return nil
end

--- Returns the single item ID to use for display/cooldown when id is a tinker (spell or item).
--- Used to deduplicate so we show one icon per tinker and always use item cooldown.
--- @param id number Tinker spell ID or tinker item (gloves) ID
--- @return number|nil itemId if id is a tinker, nil otherwise
function StateManager:GetTinkerItemIdForDisplay(id)
    if not id then return nil end
    local info = self:GetTinkerInfoBySpellId(id)
    if info and info.itemId then
        return info.itemId
    end
    local spellId = GetItemSpell and select(2, GetItemSpell(id)) or nil
    if spellId and spellId > 0 then
        info = self:GetTinkerInfoBySpellId(spellId)
        if info and info.itemId == id then
            return id
        end
    end
    return nil
end

function StateManager:UpdateGlyphState()
    -- Check if glyph API is available (Wrath, Cata, Mists)
    if not _G.GetNumGlyphSockets then
        if self.debug then
            self:Debug("UpdateGlyphState: GetNumGlyphSockets API not available yet")
        end
        return
    end

    local state = self.state.player.glyphs
    -- Reset glyph state
    wipe(state.prime)
    wipe(state.major)
    wipe(state.minor)
    wipe(state.all)

    -- Check all glyph slots
    local numSockets = GetNumGlyphSockets()
    if numSockets and numSockets > 0 then
        -- For Cataclysm, GetGlyphSocketInfo requires a talentGroup parameter
        -- Get active talent group/spec group (defaults to 1 if not available)
        local talentGroup = 1
        if Version:IsCata() or Version:IsMists() then
            talentGroup = GetActiveSpecGroup() or 1
        end

        for i = 1, numSockets do
            -- Cataclysm/Mists: GetGlyphSocketInfo(slot, talentGroup)
            -- MoP+: GetGlyphSocketInfo(slot) - no talentGroup needed
            local enabled, glyphType, _, glyphSpellId
            if Version:IsCata() or Version:IsMists() then
                enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i, talentGroup)
            else
                enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
            end

            if enabled and glyphSpellId then
                -- Add to type-specific table
                if glyphType == 3 then
                    state.prime[glyphSpellId] = true
                elseif glyphType == 1 then
                    state.major[glyphSpellId] = true
                elseif glyphType == 2 then
                    state.minor[glyphSpellId] = true
                end
                -- Add to all glyphs table
                state.all[glyphSpellId] = glyphType
            end
        end
    end

    if self.debug then
        local primeCount = 0
        local majorCount = 0
        local minorCount = 0
        for _ in pairs(state.prime) do primeCount = primeCount + 1 end
        for _ in pairs(state.major) do majorCount = majorCount + 1 end
        for _ in pairs(state.minor) do minorCount = minorCount + 1 end
        self:Debug("UpdateGlyphState: Updated - %d prime, %d major, %d minor glyphs",
            primeCount, majorCount, minorCount)
    end
end

function StateManager:UpdateRuneState()
    if not Version:IsSoD() then return end

    -- Skip if we've updated recently
    local now = GetTime()
    if self.lastRuneUpdate and (now - self.lastRuneUpdate) < 0.5 then
        return
    end
    self.lastRuneUpdate = now

    local state = self.state.player.equipment
    -- Reset rune state
    wipe(state.runes)

    -- Check each equipment slot for runes
    for slotID = 0, 19 do
        if C_Engraving.IsEquipmentSlotEngravable(slotID) then
            local runeData = C_Engraving.GetRuneForEquipmentSlot(slotID)
            if runeData then
                state.runes[slotID] = {
                    equipmentSlot = runeData.equipmentSlot,
                    learnedAbilitySpellIDs = runeData.learnedAbilitySpellIDs,
                    name = runeData.name,
                    level = runeData.level,
                    skillLineAbilityID = runeData.skillLineAbilityID,
                    iconTexture = runeData.iconTexture,
                    itemEnchantmentID = runeData.itemEnchantmentID
                }
            end
        end
    end
end

do     -- External Helper methods
    function StateManager:GetNextTime()
        return self.state.next.nextTime
    end

    -- Helper function to get the count of pieces for a WoW tier number
    --- @param self StateManager
    --- @param tier string|number The WoW tier number to check
    --- @return number The total number of pieces equipped for this tier
    function StateManager:GetTierCount(tier)
        local state = self.state.player.equipment
        if not state then return 0 end

        local tierSets = state.tiers and state.tiers[tostring(tier)]
        if not tierSets then
            -- Fallback: if tier indexing wasn't built (e.g., DataManager not ready at initial scan),
            -- compute max count by resolving tiersetId -> tier via DataManager on demand.
            local maxCountFallback = 0
            if state.tierSets and DataManager then
                for tiersetId, count in pairs(state.tierSets) do
                    local tierset = getDataEntity(tiersetId, DataManager.EntityTypes.TIERSET)
                    if tierset and tostring(tierset.tier) == tostring(tier) then
                        maxCountFallback = max(maxCountFallback, count)
                    end
                end
            end
            return maxCountFallback
        end

        -- Return highest count from any matching tierset
        local maxCount = 0
        for _, count in pairs(tierSets) do
            maxCount = max(maxCount, count)
        end
        return maxCount
    end

    -- Helper function to check if we have enough pieces of a WoW tier
    --- @param self StateManager
    --- @param tier string|number The WoW tier number to check
    --- @param count number The number of pieces needed
    --- @return boolean True if we have enough pieces equipped
    function StateManager:HasTierCount(tier, count)
        return self:GetTierCount(tier) >= count
    end

    --- Get equipped piece count for a specific tiersetId
    --- @param self StateManager
    --- @param tiersetId number The item set ID (setID from GetItemInfo return #16)
    --- @return number count
    function StateManager:GetTierSetPieceCount(tiersetId)
        local state = self.state.player.equipment
        if not state or not state.tierSets or not tiersetId then return 0 end
        return state.tierSets[tiersetId] or 0
    end

    --- Check if player has at least `count` pieces of a specific tiersetId
    --- @param self StateManager
    --- @param tiersetId number The item set ID (setID from GetItemInfo return #16)
    --- @param count number The number of pieces needed
    --- @return boolean hasEnough
    function StateManager:HasTierSetPieceCount(tiersetId, count)
        return self:GetTierSetPieceCount(tiersetId) >= count
    end

    -- Helper function to check if a glyph is active
    function StateManager:HasGlyph(glyphId)
        local state = self.state.player.glyphs
        return state.all[glyphId] ~= nil
    end

    -- Helper function to check if a rune is equipped in a specific slot
    function StateManager:HasRuneInSlot(slotID)
        local state = self.state.player.equipment
        return state.runes[slotID] ~= nil
    end

    -- Helper function to get rune info for a specific slot
    function StateManager:GetRuneInfoForSlot(slotID)
        local state = self.state.player.equipment
        return state.runes[slotID]
    end

    -- Helper function to check if a specific rune spell is active
    function StateManager:HasRuneSpell(spellID)
        local state = self.state.player.equipment
        for _, runeInfo in pairs(state.runes) do
            if runeInfo.spellIDs then
                for _, learnedSpellID in ipairs(runeInfo.spellIDs) do
                    if learnedSpellID == spellID then
                        return true
                    end
                end
            end
        end
        return false
    end

    --- Check if a spell is a known enchant using cached enchant data
    --- @param self StateManager
    --- @param spellId number The spell ID to check
    --- @return boolean True if the spell is a known enchant, false otherwise
    function StateManager:IsKnownEnchant(spellId)
        if not spellId then return false end

        -- Check if the spell has the enchant flag set
        local entity = getDataEntity(spellId, DataManager.EntityTypes.SPELL)
        if not entity or not entity.flags or not entity.flags.enchant then
            return false
        end

        -- Check cached enchant data for this spell
        local state = self.state.player.equipment
        for slot, enchantId in pairs(state.enchants) do
            -- Check if this enchant has the spell as an effect
            local enchantData = getDataEntity(enchantId, DataManager.EntityTypes.ENCHANT)
            if enchantData and enchantData.effects then
                for _, effect in ipairs(enchantData.effects) do
                    -- Check if this effect is a spell effect (types 1, 3, 7) and matches our spell ID
                    if (effect.effectType == 1 or effect.effectType == 3 or effect.effectType == 7) and
                        effect.effectArg == spellId then
                        return true
                    end
                end
            end
        end

        -- Item-use spells (e.g. 82174 from Reaping Gauntlets): spell is known if a related item is equipped in the spell's slot
        if entity.slot and entity.relationships and entity.relationships.item then
            for itemId in pairs(entity.relationships.item) do
                if GetInventoryItemID("player", entity.slot) == itemId then
                    return true
                end
            end
        end

        return false
    end

    --- Get trinket data for a specific slot
    --- @param self StateManager
    --- @param slot number The trinket slot (13 or 14)
    --- @return table|nil The trinket data or nil if no trinket equipped
    function StateManager:GetTrinketData(slot)
        local state = self.state.player.equipment
        return state.trinketData[slot]
    end

    --- Get all trinket data
    --- @param self StateManager
    --- @return table Table of trinket data by slot
    function StateManager:GetAllTrinketData()
        return self.state.player.equipment.trinketData
    end

    --- Check if a trinket has specific stat types
    --- @param self StateManager
    --- @param slot number The trinket slot (13 or 14)
    --- @param statType1? number First stat type to check
    --- @param statType2? number Second stat type to check
    --- @param statType3? number Third stat type to check
    --- @return boolean True if trinket matches any of the specified stat types
    function StateManager:TrinketMatchesStats(slot, statType1, statType2, statType3)
        local trinketData = self:GetTrinketData(slot)
        if not trinketData or not trinketData.trinketInfo then
            return false
        end

        local info = trinketData.trinketInfo

        -- If no stat types specified, match any trinket
        if not statType1 and not statType2 and not statType3 then
            return true
        end

        -- Check if any of the requested stat types match the trinket's stat types
        -- Wrap in not not to ensure boolean return (fix linter warning)
        return not not ((statType1 and info.statType1 == statType1) or
            (statType2 and info.statType2 == statType2) or
            (statType3 and info.statType3 == statType3) or
            (statType1 and info.statType2 == statType1) or
            (statType1 and info.statType3 == statType1) or
            (statType2 and info.statType1 == statType2) or
            (statType2 and info.statType3 == statType2) or
            (statType3 and info.statType1 == statType3) or
            (statType3 and info.statType2 == statType3))
    end
end

do     -- ~~~~~~~~~~ Form/Stance Processing
--- Updates the shapeshift form state and returns whether it actually changed
--- This optimization prevents unnecessary message broadcasts when forms haven't changed
--- @return boolean? True if the form state changed, false if unchanged, nil if error
function StateManager:UpdateFormsState()
        local state = self.state.player.shapeshiftForm
        local formIndex = GetShapeshiftForm()
        local formID = GetShapeshiftFormID() -- May be nil for Paladins

        -- Store previous values for comparison
        local previousId = state.id
        local previousSpellId = state.spellId
        local previousActive = state.active

        if formIndex and formIndex > 0 then
            local _, active, _, spellID = GetShapeshiftFormInfo(formIndex)
            state.id = formID or formIndex -- Use formIndex as fallback if formID is nil
            state.spellId = spellID
            state.active = active
        else
            -- Reset state when no form is active
            state.id = nil
            state.spellId = nil
            state.active = false
        end

        -- Return whether the state actually changed
        return previousId ~= state.id or
            previousSpellId ~= state.spellId or
            previousActive ~= state.active
    end

    --- Gets the current shapeshift form ID
    --- @return number|nil The current shapeshift form ID or nil if no form is active
    function StateManager:GetShapeshiftFormID()
        return self.state.player.shapeshiftForm.id
    end
end

do     -- ~~~~~~~~~~ Pet State GTG
    --- Check if a spell belongs to the current pet
    --- @param spellId number Spell ID to check
    --- @return boolean True if spell belongs to current pet
    function StateManager:IsActivePet(spellId)
        local state = self.state.player.pet
        if not state.active or not state.npcId then return false end

        -- Get related NPCs and check if our current pet's NPC ID exists in the relationships
        local relatedNPCs = DataManager:GetRelated(spellId, DataManager.EntityTypes.SPELL, DataManager.EntityTypes.NPC)
        return relatedNPCs[state.npcId] ~= nil
    end

    function StateManager:UpdatePetState()
        local state = self.state.player.pet

        -- Store previous pet state for comparison
        local previousActive = state.active
        local previousNpcId = state.npcId

        -- Reset pet state
        state.active = HasPetUI()
        state.guid = UnitGUID("pet")

        if state.guid then
            -- Extract NPC ID from GUID (format: "Creature-0-XXXX-XXXX-XXXX-NPCID")
            local npcId = select(6, strsplit("-", state.guid))
            state.npcId = tonumber(npcId)
            state.name = UnitName("pet")
            state.familyName = UnitCreatureFamily("pet")
        else
            state.npcId = nil
            state.name = nil
            state.familyName = nil
        end

        -- Send message if pet state actually changed
        if previousActive ~= state.active or previousNpcId ~= state.npcId then
            self:SendMessage("NAG_PET_STATE_CHANGED", state.active, state.npcId, state.name)
            if self.debug then
                self:Debug("Pet state changed: active=%s, npcId=%s, name=%s",
                    tostring(state.active), tostring(state.npcId), tostring(state.name))
            end
        end
    end
end


--- Updates the talent state for all specs
function StateManager:UpdateTalentState()
    local state = self.state.player.talents
    wipe(state.active)

    if Version:IsMists() then
        -- MoP: 6 tiers, 3 columns per tier
        -- Convert tier/column to talentIndex for our unified API
        for tier = 1, MAX_NUM_TALENT_TIERS do
            for column = 1, NUM_TALENT_COLUMNS or 3 do
                -- Convert tier/column to linear index (1-18)
                local talentIndex = (tier - 1) * 3 + column

                -- Use SpecCompat API
                local talentInfo = SpecCompat:GetTalentInfo(nil, talentIndex, false, false, nil)

                if talentInfo and talentInfo.name then
                    local name = talentInfo.name
                    local rank = talentInfo.rank
                    local talentId = talentInfo.talentID
                    local selected = talentInfo.selected

                    self:Debug("Talent tier=" .. tier .. " column=" .. column .. " index=" .. talentIndex ..
                              " name=" .. tostring(name) .. " rank=" .. tostring(rank) .. " talentId=" .. tostring(talentId) .. " selected=" .. tostring(selected))

                    -- Only add talent if it's actually selected and has rank > 0
                    if talentId and selected and rank and rank > 0 then
                        state.active[talentId] = rank
                        self:Debug("MoP Talent " .. tostring(talentId) .. " (" .. tostring(name) .. ") selected with rank " .. tostring(rank))
                    end
                end
            end
        end
    else
        -- cata/Classic: Use GetTalentLink and GetTalentInfo
        local numTabs = SpecCompat:GetNumTalentTabs()
        for tabIndex = 1, numTabs do
            local numTalents = SpecCompat:GetNumTalents(tabIndex)
            for talentIndex = 1, numTalents do
                self:Debug("Talent Index: " .. talentIndex)
                local link = GetTalentLink and GetTalentLink(tabIndex, talentIndex)
                if link then
                    local talentId = tonumber(link:match("talent:(%d+)"))
                    self:Debug("Talent ID: " .. tostring(talentId))
                    local talentInfo = SpecCompat:GetTalentInfo(tabIndex, talentIndex)
                    if talentInfo and talentInfo.name then
                        local currentRank = talentInfo.rank or 0
                        if talentId and currentRank and currentRank > 0 then
                            state.active[talentId] = currentRank
                            self:Debug("Talent " .. talentId .. " set to rank " .. currentRank)
                        end
                    end
                end
            end
        end
    end
end

--- Checks if the player has a specific talent and optionally at a specific rank
--- Verify cata 5/21
--- @param talentId number The ID of the talent to check
--- @param rank? number Optional rank to check for
--- @return boolean hastalent True if the player has the talent at the specified rank (or any rank if not specified)
function StateManager:HasTalent(talentId, rank)
    -- First verify this is a valid talent from our data
    local talent = DataManager:GetTalent(talentId)
    if not talent then return false end

    -- Then check if we have it active and at what rank
    local state = self.state.player.talents
    local currentRank = state.active[talentId]
    if not currentRank or currentRank == 0 then return false end

    if rank then
        return currentRank >= rank
    end
    return true
end

--- Gets the rank of a specific talent
--- Verify cata 5/21
--- @param talentId number The ID of the talent to check
--- @return number rank The rank of the talent (0 if not learned)
function StateManager:GetTalentRank(talentId)
    -- First verify this is a valid talent from our data
    local talent = DataManager:GetTalent(talentId)
    if not talent then return 0 end

    local state = self.state.player.talents
    return state.active[talentId] or 0
end

--- Gets the current rank's spell ID for a talent
--- Verify cata 5/21
--- @param talentId number The ID of the talent to check
--- @return number|nil spellId The spell ID for the current rank, or nil if not found
function StateManager:GetCurrentTalentSpellId(talentId)
    -- Get talent data from DataManager
    local talent = DataManager:GetTalent(talentId)
    if not talent then return nil end

    -- Get current rank from our state
    local currentRank = self:GetTalentRank(talentId)
    if currentRank == 0 then return nil end

    -- Get spell ID for current rank from talent data
    return talent["rank" .. currentRank]
end

function StateManager:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
    NAG.lastEclipsePhase = "NeutralPhase"
    NAG.isLoadScreenRecent = true
    C_Timer.After(3, function()
        NAG.isLoadScreenRecent = false
    end)
    if isInitialLogin then return end

    self:Debug("PLAYER_ENTERING_WORLD: Zone change, updating lightweight state")
    self:UpdateEnteringWorldState()
end

function StateManager:PLAYER_TARGET_CHANGED(event)
    --- We add newGuid to standard payload
    local state = self.state.target
    local newGuid = UnitGUID("target")

    -- If target changed (different GUID), reset the start time
    if newGuid ~= state.guid then
        state.guid = newGuid
        state.exists = UnitExists("target")
        -- Set start time only if we have a valid target
        if state.exists then
            state.startTime = GetTime()
        else
            state.startTime = nil
        end
    end

    if UnitClassBase("player") == "ROGUE" then
        -- Primary: use tracker.prevCP captured at the moment of target change
        local storedFromTracker = self._cpTracker and self._cpTracker.prevCP or 0

        if (storedFromTracker or 0) > 0 then
            self.state.player.storedComboPoints = storedFromTracker
            if self.debug then
                self:Debug("PLAYER_TARGET_CHANGED: stored %d CP from previous target (tracker)", storedFromTracker)
            end
        else
            -- Legacy fallback: detect player-held CP vs zero on target (works on modern where CP are on player)
            local targetCP = GetComboPoints("player", "target") or 0
            local playerCP = UnitPower("player", Enum.PowerType.ComboPoints) or 0
            if playerCP > 0 and targetCP == 0 then
                self.state.player.storedComboPoints = playerCP
                if self.debug then
                    self:Debug("PLAYER_TARGET_CHANGED: stored %d CP from player (fallback)", playerCP)
                end
            else
                self.state.player.storedComboPoints = 0
            end
        end

        -- Update tracker baseline for the new target
        if not self._cpTracker then self._cpTracker = { lastGuid = nil, lastCP = 0, prevCP = 0 } end
        self._cpTracker.lastGuid = newGuid
        self._cpTracker.lastCP = GetComboPoints("player", "target") or 0
        self._cpTracker.prevCP = 0
    end
end

function StateManager:PLAYER_EQUIPMENT_CHANGED(event, equipmentSlot, hasCurrent)
    -- Handle all equipment-related state updates using standardized method
    self:RequestEquipmentChangeStateRefresh("PLAYER_EQUIPMENT_CHANGED")

    -- Handle rune changes for SoD
    if Version:IsSoD() then
        self:UpdateRuneState()
    end

    -- Equipment changes may affect item swap active set detection
    -- Refresh active set detection since equipment changed (rotation config hasn't changed)
    self:RefreshItemSwapActiveSet()

    -- Send equipment change message for event-driven rotation switching
    -- Use TablePool for message payload
    local payload = TablePool:Acquire("small")
    payload.slot = equipmentSlot
    payload.hasCurrent = hasCurrent
    payload.timestamp = GetTime()
    self:SendMessage("NAG_EQUIPMENT_CHANGED", payload)
    TablePool:Release("small", payload)
end

-- ============================ ITEM DATA EVENT HANDLERS ============================

--- Triggered when item data finishes loading (Cata+/Modern API)
--- @param event string
--- @param itemId number
--- @param success boolean
function StateManager:ITEM_DATA_LOAD_RESULT(event, itemId, success)
    if not itemId then return end
    if self._pendingTierSetItemInfo and self._pendingTierSetItemInfo[itemId] then
        self._pendingTierSetItemInfo[itemId] = nil
        self:UpdateTierSetState()
    end
end

--- Triggered when item info becomes available (Classic API)
--- @param event string
--- @param itemId number
--- @param success boolean
function StateManager:GET_ITEM_INFO_RECEIVED(event, itemId, success)
    if not itemId then return end
    if self._pendingTierSetItemInfo and self._pendingTierSetItemInfo[itemId] then
        self._pendingTierSetItemInfo[itemId] = nil
        self:UpdateTierSetState()
    end
end
-- Handle CLEU interrupt events (persist history)
function StateManager:HandleCLEUInterruptEvent(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)

    if sourceGUID ~= NAG.state.player.guid then return end
    if NAG.CLASS_FILENAME ~= "WARRIOR" then return end
    if not NAG.GetClassSetting or not NAG:GetClassSetting("enableSmartInterrupts", true) then return end

    local history = self.db and self.db.global and self.db.global.interruptHistory
    if history then
        if self.currentEncounterId then
            history.encounters[self.currentEncounterId] = true
        else
            local targetName = destName or "Unknown"
            if targetName and targetName ~= "" then
                history.mobs[targetName] = true
            end
        end
    end
end

function StateManager:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellId)
    --- We add spellName to standard payload
    -- Only process player spell casts
    if unit ~= "player" then return end

    -- This event only fires for actual spell casts, not DOT ticks
    -- Use this for more accurate sequence tracking
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name or "Unknown"
    if self.debug then self:Debug("UNIT_SPELLCAST_SUCCEEDED: %d (%s)", spellId, spellName) end
    self:UpdateLastCast(spellId)

    -- Clear stored CP after Redirect (support both known IDs)
    -- if self.state.player.classInfo.name == "ROGUE" then
    --     if spellId == 73981 or spellId == 110730 then
    --         self.state.player.storedComboPoints = 0
    --         if self.debug then
    --             self:Debug("Redirect cast detected (%d) -> clearing stored CP", spellId)
    --         end
    --     end
    -- end

    -- Send message to other modules about spell cast with ALL parameters
    self:SendMessage("NAG_SPELL_CAST_SUCCEEDED", unit, castGUID, spellId, spellName)

    -- Send state snapshots to SpellLearner v2 modules (if enabled)
    self:SendSpellLearnerStateSnapshot(spellId)
end

function StateManager:UNIT_PET(event, unitTarget)
    if unitTarget == "player" then
        if NAG.CLASS_FILENAME == "HUNTER" and ns.HUNTER_UpdateStablePets then
            ns.HUNTER_UpdateStablePets()
        end

        -- First process pet abilities to ensure entities exist
        DataManager:ProcessPetAbilities()
        -- Then update our state
        self:UpdatePetState()
    end
end

function StateManager:UPDATE_SHAPESHIFT_FORM()
    -- Only send message if the form actually changed
    if self:UpdateFormsState() then
        if self.debug then
            local currentForm = self.state.player.shapeshiftForm
            self:Debug("UPDATE_SHAPESHIFT_FORM: Form changed to %s (active: %s, spell: %s)",
                tostring(currentForm.id), tostring(currentForm.active), tostring(currentForm.spellId))
        end
    end

    -- Update the last update timestamp
    self.lastShapeshiftFormUpdate = currentTime
end

function StateManager:GLYPH_ADDED()
    self:UpdateGlyphState()
end

function StateManager:RUNE_UPDATED(event, rune)
    if self.debug then self:Debug("RUNE_UPDATED: rune=%s", rune and "present" or "nil") end

    -- Update rune state when a rune is updated
    self:UpdateRuneState()

    -- If we have rune data, we could process it here
    -- The rune parameter contains EngravingData with fields:
    -- skillLineAbilityID, itemEnchantmentID, name, iconTexture, equipmentSlot, level, learnedAbilitySpellIDs
    if rune then
        if self.debug then
            self:Debug("RUNE_UPDATED: Processing rune '%s' for slot %d", rune.name or "Unknown",
                rune.equipmentSlot or -1)
        end
    end
end

function StateManager:COMBO_TARGET_CHANGED(event)
    -- This event fires when combo points are removed from the target
    -- Do NOT clear stored combo points here; we preserve last target CP for Redirect
    if self.debug and self.state.player.classInfo.name == "ROGUE" then
        self:Debug("COMBO_TARGET_CHANGED: observed, stored CP preserved (%d)", self.state.player.storedComboPoints or 0)
    end
end

--- Update stored combo points based on difference between GetComboPoints and UnitPower
--- This is called when target changes to detect "stored" combo points
function StateManager:UpdateStoredComboPoints()
    if self.state.player.classInfo.name ~= "ROGUE" then
        return
    end

    -- Get combo points using both APIs
    local targetComboPoints = GetComboPoints("player", "target") or 0
    local playerComboPoints = UnitPower("player", Enum.PowerType.ComboPoints) or 0

    -- If player has combo points but target shows 0, those are "stored" combo points
    if playerComboPoints > 0 and targetComboPoints == 0 then
        self.state.player.storedComboPoints = playerComboPoints
        if self.debug then
            self:Debug("Detected %d stored combo points (player: %d, target: %d)", playerComboPoints, playerComboPoints, targetComboPoints)
        end
    else
        self.state.player.storedComboPoints = 0
    end
end

--- Get stored combo points (for rogue redirect functionality)
--- @return number The number of stored combo points
function StateManager:GetStoredComboPoints()
    if self.state.player.classInfo.name ~= "ROGUE" then
        return 0
    end

    return self.state.player.storedComboPoints or 0
end

function StateManager:PLAYER_REGEN_DISABLED(event)
    -- This event fires when entering combat (regen disabled)
    local state = self.state

    if SpecCompat then
        state.combat.specIndexLock = SpecCompat:GetCurrentSpecIndex()
    end

    -- Only set start time if we're entering combat (not already in combat)
    if not state.combat.startTime then
        state.combat.startTime = GetTime()
        state.combat.time = 0
    end
    state.player.lastCast = 0
    state.player.lastCastId = nil

    -- Handle encounter timer
    if NAG.db.global.enableEncounterTimer then
        -- Cancel any existing timer
        if state.combat.encounterTimer then
            self:CancelTimer(state.combat.encounterTimer)
        end

        -- Set the end time based on encounter duration
        local encounterDuration = NAG.db.global.encounterDuration
        state.combat.encounterEndTime = state.combat.startTime + encounterDuration
        -- Store runtime value in state, not database
        state.combat.currentTimeRemaining = encounterDuration

        -- Create a repeating timer to update runtime state (not database)
        state.combat.encounterTimer = self:ScheduleRepeatingTimer(function()
            local currentTime = GetTime()
            local remainingTime = state.combat.encounterEndTime - currentTime

            if remainingTime <= 0 then
                -- Timer finished
                state.combat.currentTimeRemaining = 0
                self:CancelTimer(state.combat.encounterTimer)
                state.combat.encounterTimer = nil
            else
                -- Update remaining time in state only
                state.combat.currentTimeRemaining = remainingTime
            end
        end, 0.1) -- Update every 0.1 seconds
    end

    -- Clear rotation switching cache when entering combat
    -- This ensures fresh evaluation of rotation switching conditions at combat start
    NAG:GetModule("RotationManager"):ClearRotationSwitchingCache()

    -- Send combat state change message for event-driven rotation switching
    -- Use TablePool for message payload
    local payload = TablePool:Acquire("small")
    payload.inCombat = true
    payload.timestamp = GetTime()
    self:SendMessage("NAG_COMBAT_STATE_CHANGED", payload)
    TablePool:Release("small", payload)

    -- Warm-up rotation cache at combat start to avoid first-swing stalls
    local RotationManager = NAG:GetModule("RotationManager", true)
    if RotationManager then
        local ok, ready = pcall(function()
            return RotationManager:EnsureRotationReady()
        end)
        if ok then
            RotationManager:MarkCombatStartReady(ready)
        else
            RotationManager:MarkCombatStartReady(false)
        end
    end
end

function StateManager:PLAYER_REGEN_ENABLED(event)
    -- This event fires when leaving combat (regen enabled)
    local state = self.state

    -- Clean up encounter timer
    if state.combat.encounterTimer then
        self:CancelTimer(state.combat.encounterTimer)
        state.combat.encounterTimer = nil
    end
    state.combat.encounterEndTime = nil
    state.combat.startTime = nil
    state.combat.currentTimeRemaining = nil

    -- Update combat state
    state.player.inCombat = false
    NAG.inCombat = false

    -- ============================ POOLING CLEANUP ============================
    -- Pooling overlays are driven by SpellCanCast() hotpaths setting NAG.isPooling.
    -- When leaving combat, rotations often stop evaluating immediately, so StopPooling() may never be called.
    -- Ensure pooling visuals (and the isPooling flag) never persist out of combat.
    if NAG and NAG.StopPooling then
        NAG:StopPooling()
    elseif NAG then
        NAG.isPooling = false
    end

    -- Reset swing tracking
    NAG.lastMainHandSwing = 0
    NAG.lastOffHandSwing = 0
    NAG.lastSwingDelta = nil
    NAG.lastSwingTime = 0
    NAG.lastSwingTimestamp = 0
    NAG.lastSwingTimeOH = 0
    NAG.lastSwingTimestampOH = 0

    -- Auto-reset regular sequences when leaving combat
    if NAG.sequencePosition and NAG.sequenceSpells then
        local resetCount = 0
        for name, _ in pairs(NAG.sequenceSpells) do
            if NAG.sequencePosition[name] then
                --self:Debug(format("Auto-resetting regular sequence '%s' on combat exit", name))
                NAG.sequencePosition[name] = 1 -- Reset to start
                resetCount = resetCount + 1
            end
        end

        if resetCount > 0 then
            --self:Debug(format("Auto-reset %d regular sequences on combat exit", resetCount))
        end
    end

    -- Auto-reset strict sequences when leaving combat
    if NAG.strictSequencePosition and NAG.strictSequenceSpells then
        local strictResetCount = 0
        for name, _ in pairs(NAG.strictSequenceSpells) do
            if NAG.strictSequencePosition[name] then
                --self:Debug(format("Auto-resetting strict sequence '%s' on combat exit", name))
                NAG.strictSequencePosition[name] = 1 -- Reset to start
                strictResetCount = strictResetCount + 1
            end
        end

        if strictResetCount > 0 then
            --self:Debug(format("Auto-reset %d strict sequences on combat exit", strictResetCount))
        end
    end

    -- Clear completed sequences tracking
    if NAG.RightSlots.completedSequences then
        local completedCount = 0
        for name, _ in pairs(NAG.RightSlots.completedSequences) do
            completedCount = completedCount + 1
        end

        if completedCount > 0 then
            wipe(NAG.RightSlots.completedSequences)
            --self:Debug(format("Cleared %d completed sequences on combat exit", completedCount))
        end
    end

    -- Reset RightSlots sequence state and clear UI overlays
    if NAG.RightSlots.activeSequence then
        --self:Debug(format("Clearing active sequence '%s' on combat exit", NAG.RightSlots.activeSequence))
        NAG.RightSlots:resetSequence()
    end

    -- Clear any remaining sequence state
    if NAG.RightSlots.originalSequence then
        wipe(NAG.RightSlots.originalSequence)
        NAG.RightSlots.originalSequenceCount = nil
        --self:Debug("Cleared original sequence tracking on combat exit")
    end

    -- Reset sequence flags
    NAG.RightSlots.forceMainActive = false
    NAG.RightSlots._lockSequence = false
    NAG.RightSlots.sequenceProgress = 1
    NAG.RightSlots.unrelatedCastCount = 0

    -- Clear all sequence-related UI overlays and arrows

    OverlayManager:ClearAllSequenceArrows()

    --self:Debug("Combat exit sequence reset complete")

    -- Send combat state change message for event-driven rotation switching
    -- Use TablePool for message payload
    local payload = TablePool:Acquire("small")
    payload.inCombat = false
    payload.timestamp = GetTime()
    self:SendMessage("NAG_COMBAT_STATE_CHANGED", payload)
    TablePool:Release("small", payload)

    local RotationManager = NAG:GetModule("RotationManager", true)
    if RotationManager then
        RotationManager:MarkCombatEnd()
    end

    -- Clear spec lock after combat
    state.combat.specIndexLock = nil
end

function StateManager:ENCOUNTER_START(event, encounterID, encounterName, difficultyID, raidSize)
    self.currentEncounterId = encounterID
    self.currentEncounterName = encounterName
end

function StateManager:ENCOUNTER_END(event, encounterID, encounterName, difficultyID, raidSize, success)
    -- Clear encounter state only if matching end
    if self.currentEncounterId == encounterID then
        self.currentEncounterId = nil
        self.currentEncounterName = nil
    end
end

--- Update the last cast spell information
--- @param spellId number The ID of the spell that was cast
function StateManager:UpdateLastCast(spellId)
    if not spellId then return end

    self.state.player.lastCast = GetTime()
    self.state.player.lastCastId = spellId
    NAG:SpellCastSucceeded(spellId)

    -- Track sequence progress
    NAG:TrackSequenceCast(spellId)
end

--- Get the last cast spell ID
--- @return number|nil The ID of the last cast spell, or nil if no spell has been cast
function StateManager:GetLastCastId()
    return self.state.player.lastCastId
end

--- Handle NAG_TALENTS_UPDATED message from SpecCompat
--- SpecCompat handles version differences and broadcasts unified NAG_TALENTS_UPDATED message
--- @param message string The message name
--- @param payload table|nil Optional payload with event details
function StateManager:NAG_TALENTS_UPDATED(message, payload)
    if self.debug then
        self:Debug("NAG_TALENTS_UPDATED: Talents updated (trigger: %s)",
            payload and payload.triggerEvent or "unknown")
    end

    -- Update talent state when talents change
    self:UpdateTalentState()

    -- Talent changes may affect rotation availability (new talents, removed talents, etc.)
    -- Note: Rotation config doesn't change from talent changes - rotation selection happens separately
    -- Item swap will be updated when rotation changes via NAG_ROTATION_CHANGED
end

function StateManager:GROUP_ROSTER_UPDATE(event)
    if self.debug then self:Debug("GROUP_ROSTER_UPDATE: Group roster changed") end

    -- Update group state when roster changes
    self:UpdateGroupState()

    -- Send message to other modules about group change
    -- Use TablePool for message payload
    local payload = TablePool:Acquire("small")
    payload.inRaid = self.state.group.inRaid
    payload.inParty = self.state.group.inParty
    payload.memberCount = self.state.group.memberCount
    payload.timestamp = GetTime()
    self:SendMessage("NAG_GROUP_ROSTER_UPDATED", payload)
    TablePool:Release("small", payload)
end


-- ~~~~~~~~~~ Stat-Based Scaling Methods ~~~~~~~~~~

--- Get current character stats for scaling calculations
--- @return table Character stats table
function StateManager:GetCharacterStats()
    local stats = {}

    -- Get base stats
    stats.strength = UnitStat("player", 1)
    stats.agility = UnitStat("player", 2)
    stats.stamina = UnitStat("player", 3)
    stats.intellect = UnitStat("player", 4)
    stats.spirit = UnitStat("player", 5)

    -- Get spell stats
    stats.spellPower = GetSpellBonusDamage(2) -- Holy school for general spell power
    stats.spellHit = GetSpellHitModifier()
    stats.spellCrit = GetSpellCritChance(2)
    stats.spellHaste = GetHaste() -- Use GetHaste() for MoP compatibility

    -- Get melee stats
    stats.meleeHit = GetHitModifier()
    stats.meleeCrit = GetCritChance()
    stats.meleeHaste = GetMeleeHaste()

    -- Get secondary stats
    stats.mastery = GetMasteryEffect()
    stats.expertise = GetExpertise()

    return stats
end

--- Calculate stat-based scaling factor using current character stats
--- This provides an alternative to ilvl-based scaling that adapts to actual character power
--- @return number Stat-based scaling factor
function StateManager:CalculateStatBasedScalingFactor()
    local stats = self:GetCharacterStats()
    local effectiveIlvl = self:GetAverageEffectiveIlvl()

    -- Base scaling from effective ilvl
    local baseScaling = effectiveIlvl / 400 -- Normalize to base ilvl

    -- Stat-based modifiers
    local statModifier = 1.0

    -- Spell power contribution (for casters)
    if stats.spellPower > 0 then
        statModifier = statModifier + (stats.spellPower / 30000) * 0.1
    end

    -- Crit contribution
    if stats.spellCrit > 0 then
        statModifier = statModifier + (stats.spellCrit / 100) * 0.05
    end

    -- Haste contribution
    if stats.spellHaste > 0 then
        statModifier = statModifier + (stats.spellHaste / 100) * 0.03
    end

    -- Mastery contribution
    if stats.mastery > 0 then
        statModifier = statModifier + (stats.mastery / 100) * 0.02
    end

    -- Combine base scaling with stat modifier
    local finalScaling = baseScaling * statModifier

    -- Clamp to reasonable range
    finalScaling = max(0.5, min(2.5, finalScaling))

    return finalScaling
end

--- Get WoWSims-style ilvl information for external modules
--- This provides comprehensive ilvl data that matches the WoWSims approach
--- @param includeModifications? boolean Whether to include all modifications (default: true)
--- @return table WoWSims-style ilvl information
function StateManager:GetWoWSimsStyleIlvlInfo(includeModifications)
    includeModifications = includeModifications ~= false -- Default to true

    local state = self.state.player.equipment.ilvl

    -- Ensure ilvl is up to date
    if not state.lastUpdate or (GetTime() - state.lastUpdate) > 5.0 then
        self:UpdateIlvlState()
    end

    local baseInfo = {
        total = state.total,
        average = state.average,
        weighted = state.weighted,
        items = state.items,
        quality = self:CalculateIlvlQuality(false)
    }

    if includeModifications then
        baseInfo.gemmedTotal = state.gemmedTotal
        baseInfo.gemmedAverage = state.gemmedAverage
        baseInfo.gemmedItems = state.gemmed
        baseInfo.effectiveTotal = state.effectiveTotal
        baseInfo.effectiveAverage = state.effectiveAverage
        baseInfo.effectiveItems = state.effective
        baseInfo.quality = self:CalculateIlvlQuality(true)
    end

    -- Add scaling factors
    baseInfo.ilvlScalingFactor = self:CalculateIlvlScalingFactor(includeModifications)
    baseInfo.statBasedScalingFactor = self:CalculateStatBasedScalingFactor()
    baseInfo.mageCombustionScalingFactor = self:GetMageCombustionScalingFactor()

    -- Add last update time
    baseInfo.lastUpdate = state.lastUpdate

    return baseInfo
end

-- ============================ ROTATION MESSAGE HANDLERS ============================

--- Handles rotation updates (rotation configuration changed)
--- @param message string The message name
--- @param payload table|nil Optional payload with rotation details
function StateManager:NAG_ROTATION_CHANGED(message, payload)
    self:Debug("NAG_ROTATION_CHANGED: Rotation changed (action: %s, dataChanged: %s, selectionChanged: %s), updating item swap state",
        payload and payload.action or "unknown",
        payload and tostring(payload.dataChanged) or "unknown",
        payload and tostring(payload.selectionChanged) or "unknown")

    -- Update item swap state from current rotation
    local classModule = NAG:GetClassModule()
    if classModule then
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if specIndex then
            local rotation = select(1, classModule:GetCurrentRotation(specIndex))
            self:UpdateItemSwapFromRotation(rotation)
        end
    end
end


-- ============================ GROUP/RAID OVERRIDE SYSTEM ============================

--- Set a group/raid override for testing purposes
--- @param overrideType string The type of override ("raid_count", "party_count", "in_raid", "in_party")
--- @param value number|boolean|nil The override value (nil to disable)
--- @param persistent boolean|nil Whether to save this setting persistently (default: false)
--- @return boolean True if override is active
function StateManager:SetGroupOverride(overrideType, value, persistent)
    local state = self.state.group

    -- Clear override if value is nil
    if value == nil then
        if overrideType == "raid_count" then
            state.overrideRaidCount = nil
            -- Also clear the in_raid override that was automatically set
            state.overrideInRaid = nil
            if persistent then
                self.db.global.groupOverride_in_raid = nil
            end
        elseif overrideType == "party_count" then
            state.overridePartyCount = nil
            -- Also clear the in_party override that was automatically set
            state.overrideInParty = nil
            if persistent then
                self.db.global.groupOverride_in_party = nil
            end
        elseif overrideType == "in_raid" then
            state.overrideInRaid = nil
        elseif overrideType == "in_party" then
            state.overrideInParty = nil
        end

        -- Clear persistent setting if requested
        if persistent then
            self.db.global["groupOverride_" .. overrideType] = nil
        end

        self:Info("Group Override: DISABLED - " .. overrideType)
        return false
    end

    -- Set override
    if overrideType == "raid_count" then
        local clampedCount = math.max(1, math.min(40, value)) -- Clamp between 1-40
        state.overrideRaidCount = clampedCount
        -- Automatically set in_raid to true when setting raid count
        state.overrideInRaid = true
        if persistent then
            self.db.global.groupOverride_raid_count = clampedCount
            self.db.global.groupOverride_in_raid = true
        end
        self:Info("Group/Raid Override: ENABLED - Simulating " .. clampedCount .. "-man raid")
    elseif overrideType == "party_count" then
        local clampedCount = math.max(1, math.min(5, value)) -- Clamp between 1-5
        state.overridePartyCount = clampedCount
        -- Automatically set in_party to true when setting party count
        state.overrideInParty = true
        if persistent then
            self.db.global.groupOverride_party_count = clampedCount
            self.db.global.groupOverride_in_party = true
        end
        self:Info("Group/Party Override: ENABLED - Simulating " .. clampedCount .. "-man party")
    elseif overrideType == "in_raid" then
        state.overrideInRaid = value and true or false
        if persistent then
            self.db.global.groupOverride_in_raid = state.overrideInRaid
        end
        self:Info("In-Raid Override: " .. (state.overrideInRaid and "ENABLED" or "DISABLED"))
    elseif overrideType == "in_party" then
        state.overrideInParty = value and true or false
        if persistent then
            self.db.global.groupOverride_in_party = state.overrideInParty
        end
        self:Info("In-Party Override: " .. (state.overrideInParty and "ENABLED" or "DISABLED"))
    end

    return true
end

--- Get the effective group member count (with overrides applied).
--- Returns 0 when solo (no overrides), or the override/actual count when in group.
--- @return number The effective member count (0 when solo, N when in group/raid or overridden)
function StateManager:GetEffectiveGroupMemberCount()
    local state = self.state.group

    -- Check for overrides first
    if state.overrideInRaid and state.overrideRaidCount then
        return state.overrideRaidCount
    elseif state.overrideInParty and state.overridePartyCount then
        return state.overridePartyCount
    end

    -- Return actual count (0 when solo, N when in group)
    return state.memberCount or 0
end

--- Check if player is effectively in a raid (with overrides applied)
--- @return boolean True if effectively in raid
function StateManager:IsEffectivelyInRaid()
    local state = self.state.group

    -- Check override first
    if state.overrideInRaid ~= nil then
        return state.overrideInRaid
    end

    -- Return actual state
    return state.inRaid
end

--- Check if player is effectively in a party (with overrides applied)
--- @return boolean True if effectively in party
function StateManager:IsEffectivelyInParty()
    local state = self.state.group

    -- Check override first
    if state.overrideInParty ~= nil then
        return state.overrideInParty
    end

    -- Return actual state
    return state.inParty
end

-- ============================ GROUP COMPOSITION API ============================
-- Scope: "group" = full raid or full party; "subgroup" = in raid player's subgroup only, else same as group; solo = player only.
-- Class: When classToken is nil or omitted, APIs use UnitClassBase("player") (player's class).

-- Cached table for GetGroupMemberUnits (reused to avoid allocation; callers must not keep reference)
local cachedGroupMemberUnits = {}

--- Return the list of unit IDs for current group members (respects overrides).
--- Solo returns {"player"}. In raid/party returns raid1..raidN or party1..partyN.
--- Callers should iterate immediately; do not store the returned table long-term.
--- @return table Table of unit ID strings (e.g. {"player"} or {"raid1", "raid2", ...})
function StateManager:GetGroupMemberUnits()
    wipe(cachedGroupMemberUnits)
    local state = self.state.group
    local effectiveMemberCount = self:GetEffectiveGroupMemberCount()
    local isEffectivelyInRaid = self:IsEffectivelyInRaid()
    local isEffectivelyInParty = self:IsEffectivelyInParty()

    if (isEffectivelyInRaid and effectiveMemberCount > 0) or (isEffectivelyInParty and effectiveMemberCount > 0) then
        for i = 1, effectiveMemberCount do
            cachedGroupMemberUnits[#cachedGroupMemberUnits + 1] = isEffectivelyInRaid and ("raid" .. i) or ("party" .. i)
        end
    elseif state.memberCount == 0 then
        cachedGroupMemberUnits[#cachedGroupMemberUnits + 1] = "player"
    else
        for i = 1, state.memberCount do
            cachedGroupMemberUnits[#cachedGroupMemberUnits + 1] = state.inRaid and ("raid" .. i) or ("party" .. i)
        end
    end

    return cachedGroupMemberUnits
end

-- Cached table for GetSubgroupMemberUnits (reused to avoid allocation; callers must not keep reference)
local cachedSubgroupMemberUnits = {}

--- Return the list of unit IDs for the player's subgroup (raid = player's subgroup only; party = full party; solo = player only).
--- Callers should iterate immediately; do not store the returned table long-term.
--- @return table Table of unit ID strings (e.g. {"player"} or {"player", "raid1", "raid2", ...})
function StateManager:GetSubgroupMemberUnits()
    wipe(cachedSubgroupMemberUnits)
    local state = self.state.group
    local effectiveMemberCount = self:GetEffectiveGroupMemberCount()
    local isEffectivelyInRaid = self:IsEffectivelyInRaid()
    local isEffectivelyInParty = self:IsEffectivelyInParty()

    if state.memberCount == 0 or (not isEffectivelyInRaid and not isEffectivelyInParty) then
        cachedSubgroupMemberUnits[#cachedSubgroupMemberUnits + 1] = "player"
        return cachedSubgroupMemberUnits
    end

    if isEffectivelyInRaid and state.memberCount > 0 then
        local playerName = UnitName("player")
        local myGroup = nil
        for i = 1, state.memberCount do
            local name, _, subgroup = GetRaidRosterInfo(i)
            if name and playerName and name == playerName then
                myGroup = subgroup
                break
            end
        end
        cachedSubgroupMemberUnits[#cachedSubgroupMemberUnits + 1] = "player"
        if myGroup then
            for i = 1, state.memberCount do
                local name, _, subgroup = GetRaidRosterInfo(i)
                if name and subgroup == myGroup then
                    local unit = "raid" .. i
                    if UnitExists(unit) then
                        cachedSubgroupMemberUnits[#cachedSubgroupMemberUnits + 1] = unit
                    end
                end
            end
        end
        return cachedSubgroupMemberUnits
    end

    -- Party or fallback: player + party1..partyN
    cachedSubgroupMemberUnits[#cachedSubgroupMemberUnits + 1] = "player"
    local count = effectiveMemberCount > 0 and effectiveMemberCount or state.memberCount
    for i = 1, count do
        local unit = "party" .. i
        if UnitExists(unit) then
            cachedSubgroupMemberUnits[#cachedSubgroupMemberUnits + 1] = unit
        end
    end
    return cachedSubgroupMemberUnits
end

--- Return the number of units of the given class in the group or subgroup (includes player when they match).
--- @param classToken string|nil Class token (e.g. "HUNTER"); when nil, uses UnitClassBase("player")
--- @param scope string|nil "group" (default) or "subgroup"
--- @return number
function StateManager:GetClassCountInGroup(classToken, scope)
    local class = (classToken and classToken ~= "") and classToken or UnitClassBase("player")
    local units = (scope == "subgroup") and self:GetSubgroupMemberUnits() or self:GetGroupMemberUnits()
    local count = 0
    local listIncludesPlayer = false
    for i = 1, #units do
        local unit = units[i]
        if unit == "player" then listIncludesPlayer = true end
        if UnitExists(unit) then
            if UnitIsConnected and not UnitIsConnected(unit) then
                -- skip
            else
                if UnitClassBase(unit) == class then
                    count = count + 1
                end
            end
        end
    end
    if not listIncludesPlayer and UnitClassBase("player") == class then
        count = count + 1
    end
    return count
end

--- Return true when at most one unit of the given class is in the group/subgroup.
--- @param classToken string|nil Class token; when nil, uses UnitClassBase("player")
--- @param scope string|nil "group" (default) or "subgroup"
--- @return boolean
function StateManager:IsOnlyClassInGroup(classToken, scope)
    return self:GetClassCountInGroup(classToken, scope or "group") <= 1
end

--- Return true when at least one unit of the given class (other than the player) is in the group/subgroup.
--- @param classToken string|nil Class token; when nil, uses UnitClassBase("player")
--- @param scope string|nil "subgroup" (default) or "group"
--- @return boolean
function StateManager:HasOtherClassInGroup(classToken, scope)
    local class = (classToken and classToken ~= "") and classToken or UnitClassBase("player")
    local units = (scope == "group") and self:GetGroupMemberUnits() or self:GetSubgroupMemberUnits()
    for i = 1, #units do
        local unit = units[i]
        if UnitExists(unit) and (not UnitIsUnit or not UnitIsUnit(unit, "player")) then
            if UnitIsConnected and not UnitIsConnected(unit) then
                -- skip
            else
                if UnitClassBase(unit) == class then
                    return true
                end
            end
        end
    end
    return false
end

--- Clear all group/raid overrides
--- @param persistent boolean|nil Whether to clear persistent settings too (default: false)
function StateManager:ClearGroupOverrides(persistent)
    local state = self.state.group

    state.overrideRaidCount = nil
    state.overridePartyCount = nil
    state.overrideInRaid = nil
    state.overrideInParty = nil

    if persistent then
        self.db.global.groupOverride_raid_count = nil
        self.db.global.groupOverride_party_count = nil
        self.db.global.groupOverride_in_raid = nil
        self.db.global.groupOverride_in_party = nil
    end

    self:Debug("All group/raid overrides cleared")
end

--- Debug method to show current group state and overrides
function StateManager:DebugGroupState()
    local state = self.state.group

    self:Print("=== Group/Raid State ===")
    self:Print(format("Actual - In Raid: %s, In Party: %s, Members: %d",
        tostring(state.inRaid), tostring(state.inParty), state.memberCount))

    self:Print("=== Group/Raid Overrides ===")
    self:Print(format("Override In Raid: %s", tostring(state.overrideInRaid or "none")))
    self:Print(format("Override In Party: %s", tostring(state.overrideInParty or "none")))
    self:Print(format("Override Raid Count: %s", tostring(state.overrideRaidCount or "none")))
    self:Print(format("Override Party Count: %s", tostring(state.overridePartyCount or "none")))

    self:Print("=== Effective State ===")
    self:Print(format("Effective In Raid: %s", tostring(self:IsEffectivelyInRaid())))
    self:Print(format("Effective In Party: %s", tostring(self:IsEffectivelyInParty())))
    self:Print(format("Effective Member Count: %d", self:GetEffectiveGroupMemberCount()))
end

-- ============================ DEBUG UI CONTROLS ============================

--- Get debug sections for group/raid overrides
--- @return table Debug sections table
function StateManager:GetGroupDebugSections()
    return {
        {
            title = "Group/Raid State",
            content = function()
                local state = self.state.group
                local lines = {}

                table.insert(lines, "Actual State:")
                table.insert(lines, string.format("  In Raid: %s", tostring(state.inRaid)))
                table.insert(lines, string.format("  In Party: %s", tostring(state.inParty)))
                table.insert(lines, string.format("  Member Count: %d", state.memberCount))
                table.insert(lines, string.format("  Last Update: %.2f", state.lastUpdate or 0))

                table.insert(lines, "")
                table.insert(lines, "Overrides:")
                table.insert(lines, string.format("  Override In Raid: %s", tostring(state.overrideInRaid or "none")))
                table.insert(lines, string.format("  Override In Party: %s", tostring(state.overrideInParty or "none")))
                table.insert(lines, string.format("  Override Raid Count: %s", tostring(state.overrideRaidCount or "none")))
                table.insert(lines, string.format("  Override Party Count: %s", tostring(state.overridePartyCount or "none")))

                table.insert(lines, "")
                table.insert(lines, "Effective State:")
                table.insert(lines, string.format("  Effective In Raid: %s", tostring(self:IsEffectivelyInRaid())))
                table.insert(lines, string.format("  Effective In Party: %s", tostring(self:IsEffectivelyInParty())))
                table.insert(lines, string.format("  Effective Member Count: %d", self:GetEffectiveGroupMemberCount()))

                return table.concat(lines, "\n")
            end
        }
    }
end

--- Get debug controls for group/raid overrides
--- @return table Debug controls table
function StateManager:GetGroupDebugControls()
    return {
        {
            name = L["Set Raid Count Override"] or "Set Raid Count Override",
            type = "button",
            func = function()
                local input = self:GetDebugInput("Enter raid count (1-40, or 0 to disable):")
                if input then
                    local count = tonumber(input)
                    if count and count >= 0 then
                        if count == 0 then
                            self:SetGroupOverride("raid_count", nil, false)
                        else
                            self:SetGroupOverride("raid_count", count, false)
                        end
                    else
                        self:Print("Invalid input. Please enter a number between 0-40.")
                    end
                end
            end
        },
        {
            name = L["Set Party Count Override"] or "Set Party Count Override",
            type = "button",
            func = function()
                local input = self:GetDebugInput("Enter party count (1-5, or 0 to disable):")
                if input then
                    local count = tonumber(input)
                    if count and count >= 0 then
                        if count == 0 then
                            self:SetGroupOverride("party_count", nil, false)
                        else
                            self:SetGroupOverride("party_count", count, false)
                        end
                    else
                        self:Print("Invalid input. Please enter a number between 0-5.")
                    end
                end
            end
        },
        {
            name = L["Toggle In Raid Override"] or "Toggle In Raid Override",
            type = "button",
            func = function()
                local state = self.state.group
                local newValue = not state.overrideInRaid
                self:SetGroupOverride("in_raid", newValue, false)
            end
        },
        {
            name = L["Toggle In Party Override"] or "Toggle In Party Override",
            type = "button",
            func = function()
                local state = self.state.group
                local newValue = not state.overrideInParty
                self:SetGroupOverride("in_party", newValue, false)
            end
        },
        {
            name = L["Clear All Overrides"] or "Clear All Overrides",
            type = "button",
            func = function()
                self:ClearGroupOverrides(false)
            end
        }
    }
end

-- ============================ SLASH COMMAND HANDLERS ============================

--- Handle group override slash commands
--- @param input string The command input
function StateManager:GroupOverrideCommand(input)
    if not input or input == "" then
        self:Print("Group Override Commands:")
        self:Print("  /nag groupoverride raid <count> - Set raid member count override (1-40, or 0 to disable)")
        self:Print("  /nag groupoverride party <count> - Set party member count override (1-5, or 0 to disable)")
        self:Print("  /nag groupoverride inraid <true|false> - Override in-raid status")
        self:Print("  /nag groupoverride inparty <true|false> - Override in-party status")
        self:Print("  /nag groupoverride clear - Clear all overrides")
        self:Print("  /nag groupoverride status - Show current state")
        return
    end

    local args = { strsplit(" ", input) }
    local command = strlower(args[1] or "")

    if command == "raid" then
        local count = tonumber(args[2])
        if count and count >= 0 then
            if count == 0 then
                self:SetGroupOverride("raid_count", nil, false)
                self:Print("Raid count override disabled")
            else
                self:SetGroupOverride("raid_count", count, false)
                self:Print(format("Raid count override set to %d", count))
            end
        else
            self:Print("Invalid count. Use: /nag groupoverride raid <count> (0-40)")
        end
    elseif command == "party" then
        local count = tonumber(args[2])
        if count and count >= 0 then
            if count == 0 then
                self:SetGroupOverride("party_count", nil, false)
                self:Print("Party count override disabled")
            else
                self:SetGroupOverride("party_count", count, false)
                self:Print(format("Party count override set to %d", count))
            end
        else
            self:Print("Invalid count. Use: /nag groupoverride party <count> (0-5)")
        end
    elseif command == "inraid" then
        local value = strlower(args[2] or "")
        if value == "true" or value == "1" then
            self:SetGroupOverride("in_raid", true, false)
            self:Print("In-raid override set to true")
        elseif value == "false" or value == "0" then
            self:SetGroupOverride("in_raid", false, false)
            self:Print("In-raid override set to false")
        elseif value == "clear" or value == "none" then
            self:SetGroupOverride("in_raid", nil, false)
            self:Print("In-raid override disabled")
        else
            self:Print("Invalid value. Use: /nag groupoverride inraid <true|false|clear>")
        end
    elseif command == "inparty" then
        local value = strlower(args[2] or "")
        if value == "true" or value == "1" then
            self:SetGroupOverride("in_party", true, false)
            self:Print("In-party override set to true")
        elseif value == "false" or value == "0" then
            self:SetGroupOverride("in_party", false, false)
            self:Print("In-party override set to false")
        elseif value == "clear" or value == "none" then
            self:SetGroupOverride("in_party", nil, false)
            self:Print("In-party override disabled")
        else
            self:Print("Invalid value. Use: /nag groupoverride inparty <true|false|clear>")
        end
    elseif command == "clear" then
        self:ClearGroupOverrides(false)
        self:Print("All group overrides cleared")
    elseif command == "status" then
        self:DebugGroupState()
    else
        self:Print("Unknown command. Use /nag groupoverride for help.")
    end
end

--- Handle quick raid override commands
--- @param input string The command input
function StateManager:RaidOverrideCommand(input)
    if not input or input == "" then
        self:Print("Raid Override Commands:")
        self:Print("  /nag raidoverride <count> - Set raid member count (1-40, or 0 to disable)")
        self:Print("  /nag raidoverride on - Enable in-raid override")
        self:Print("  /nag raidoverride off - Disable in-raid override")
        self:Print("  /nag raidoverride status - Show current state")
        return
    end

    local count = tonumber(input)
    if count and count >= 0 then
        if count == 0 then
            self:SetGroupOverride("raid_count", nil, false)
            self:Print("Raid count override disabled")
        else
            self:SetGroupOverride("raid_count", count, false)
            self:Print(format("Raid count override set to %d", count))
        end
    elseif strlower(input) == "on" then
        self:SetGroupOverride("in_raid", true, false)
        self:Print("In-raid override enabled")
    elseif strlower(input) == "off" then
        self:SetGroupOverride("in_raid", false, false)
        self:Print("In-raid override disabled")
    elseif strlower(input) == "status" then
        self:DebugGroupState()
    else
        self:Print("Invalid input. Use /nag raidoverride for help.")
    end
end

--- Handle quick party override commands
--- @param input string The command input
function StateManager:PartyOverrideCommand(input)
    if not input or input == "" then
        self:Print("Party Override Commands:")
        self:Print("  /nag partyoverride <count> - Set party member count (1-5, or 0 to disable)")
        self:Print("  /nag partyoverride on - Enable in-party override")
        self:Print("  /nag partyoverride off - Disable in-party override")
        self:Print("  /nag partyoverride status - Show current state")
        return
    end

    local count = tonumber(input)
    if count and count >= 0 then
        if count == 0 then
            self:SetGroupOverride("party_count", nil, false)
            self:Print("Party count override disabled")
        else
            self:SetGroupOverride("party_count", count, false)
            self:Print(format("Party count override set to %d", count))
        end
    elseif strlower(input) == "on" then
        self:SetGroupOverride("in_party", true, false)
        self:Print("In-party override enabled")
    elseif strlower(input) == "off" then
        self:SetGroupOverride("in_party", false, false)
        self:Print("In-party override disabled")
    elseif strlower(input) == "status" then
        self:DebugGroupState()
    else
        self:Print("Invalid input. Use /nag partyoverride for help.")
    end
end

-- ============================ PREDICTION QUEUE STATE MANAGEMENT ============================

-- State snapshot storage for prediction
local stateSnapshot = nil
local simulationMode = false
local simulatedSpellCooldowns = {}

--- Save current state for prediction lookahead
--- @return table Saved state snapshot
function StateManager:SaveState()
    -- Save actual game state for simulation
    local snapshot = {
        time = GetTime(),
        simulationMode = simulationMode,
        -- Player state
        health = UnitHealth("player"),
        healthMax = UnitHealthMax("player"),
        power = UnitPower("player"),
        powerMax = UnitPowerMax("player"),

        -- Target state
        targetHealth = UnitHealth("target") or 0,
        targetHealthMax = UnitHealthMax("target") or 1,

        -- Copy current buffs
        buffs = {},
        debuffs = {},

        -- Copy current cooldowns
        cooldowns = {},
    }

    -- Store current buffs
    for i = 1, 40 do
        local aura = UnitBuff("player", i)
        if not aura then break end
        snapshot.buffs[i] = {
            spellId = aura.spellId,
            expirationTime = aura.expirationTime,
            duration = aura.duration,
            applications = aura.applications,
        }
    end

    -- Store current debuffs on target
    if UnitExists("target") then
        for i = 1, 40 do
            local aura = UnitDebuff("target", i)
            if not aura then break end
            snapshot.debuffs[i] = {
                spellId = aura.spellId,
                expirationTime = aura.expirationTime,
                duration = aura.duration,
                applications = aura.applications,
            }
        end
    end

    stateSnapshot = snapshot
    simulationMode = true
    wipe(simulatedSpellCooldowns)
    return snapshot
end

--- Restore saved state after prediction lookahead
--- @param savedState table The saved state to restore
function StateManager:RestoreState(savedState)
    if not savedState then return end

    -- Restore simulation mode flag
    simulationMode = savedState.simulationMode or false
    stateSnapshot = nil
    wipe(simulatedSpellCooldowns)
end

--- Force-reset all simulation state (safety valve)
--- Use when pcall catches an error during prediction generation to ensure
--- simulationMode never gets stuck as true.
function StateManager:ForceResetSimulation()
    simulationMode = false
    stateSnapshot = nil
    wipe(simulatedSpellCooldowns)
    self.simulatedCastedSpells = nil
end

--- Check if we're in simulation mode
--- @return boolean True if in simulation mode
function StateManager:IsSimulating()
    return simulationMode
end

--- Get simulated spell cooldown (for predictions)
--- @param spellID number Spell ID
--- @return table|nil Cooldown info or nil if not on cooldown
function StateManager:GetSimulatedSpellCooldown(spellID)
    if not simulationMode then return nil end
    return simulatedSpellCooldowns[spellID]
end

--- Get simulated power (for predictions)
--- @return number Current simulated power
function StateManager:GetSimulatedPower()
    if not simulationMode or not stateSnapshot then
        return UnitPower("player")
    end
    return stateSnapshot.power or 0
end

-- ============================ SPELLLEARNER V2 INTEGRATION ============================

--- Send state snapshots to SpellLearner v2 modules
--- @param spellId number The spell ID that was just cast
function StateManager:SendSpellLearnerStateSnapshot(spellId)
    -- Capture current state as "post-cast"
    local postState = self:CreateStateSnapshot()

    -- Use stored pre-cast state if available, otherwise use current state as fallback
    local preState = self.learningPreState or postState

    -- Send message to v2 SpellLearner modules
    self:SendMessage("NAG_SPELL_LEARNED", spellId, preState, postState)

    -- Store current state as next pre-cast state
    self.learningPreState = postState
end

--- Create a lightweight state snapshot for SpellLearner analysis
--- @return table State snapshot with resources, buffs, debuffs, cooldowns
function StateManager:CreateStateSnapshot()
    local function GetResourceTable()
        local powerType = UnitPowerType("player")
        local power = UnitPower("player", powerType)
        local maxPower = UnitPowerMax("player", powerType) or 0
        local secondaryPowerType = self:GetSecondaryPowerType()
        local secondaryPower = UnitPower("player", secondaryPowerType)
        local secondaryMaxPower = UnitPowerMax("player", secondaryPowerType) or 0

        return {
            [powerType] = {
                current = power,
                max = maxPower,
                percent = maxPower > 0 and (power / maxPower) or 0
            },
            [secondaryPowerType] = {
                current = secondaryPower,
                max = secondaryMaxPower,
                percent = secondaryMaxPower > 0 and (secondaryPower / secondaryMaxPower) or 0
            }
        }
    end

    local function GetBuffsTable()
        local buffs = {}
        local index = 1
        while true do
            local auraData = UnitAura("player", index, "HELPFUL")
            if not auraData then break end

            local spellId = auraData.spellId or auraData.id
            if spellId then
                buffs[spellId] = {
                    name = auraData.name,
                    stacks = auraData.applications or 1,
                    expirationTime = auraData.expirationTime or 0
                }
            end
            index = index + 1
        end
        return buffs
    end

    local function GetDebuffsTable()
        local debuffs = {}
        if not UnitExists("target") then
            return debuffs
        end

        local index = 1
        while true do
            local auraData = UnitAura("target", index, "HARMFUL")
            if not auraData then break end

            local spellId = auraData.spellId or auraData.id
            if spellId then
                debuffs[spellId] = {
                    name = auraData.name,
                    stacks = auraData.applications or 1,
                    expirationTime = auraData.expirationTime or 0
                }
            end
            index = index + 1
        end
        return debuffs
    end

    local function GetContextTable()
        local inCombat = InCombatLockdown() or false

        -- Target health percent
        local targetHealthPercent = nil
        if UnitExists("target") then
            local targetHealth = UnitHealth("target")
            local targetMaxHealth = UnitHealthMax("target")
            if targetMaxHealth > 0 then
                targetHealthPercent = (targetHealth / targetMaxHealth) * 100
            end
        end

        -- Player health percent
        local playerHealth = UnitHealth("player")
        local playerMaxHealth = UnitHealthMax("player")
        local playerHealthPercent = playerMaxHealth > 0 and (playerHealth / playerMaxHealth) * 100 or 100

        -- Active buffs (simple boolean map for context)
        local activeBuffs = {}
        local buffs = GetBuffsTable()
        for spellId, _ in pairs(buffs) do
            activeBuffs[spellId] = true
        end

        -- Active debuffs on target (simple boolean map)
        local activeDebuffs = {}
        local debuffs = GetDebuffsTable()
        for spellId, _ in pairs(debuffs) do
            activeDebuffs[spellId] = true
        end

        -- Resource levels (percentages)
        local resourceLevels = {}
        local resources = GetResourceTable()
        for powerType, powerData in pairs(resources) do
            if powerData.percent then
                resourceLevels[powerType] = powerData.percent
            end
        end

        -- Combat state (simple heuristic: dungeon/raid/pvp/solo)
        local combatState = "solo"
        if IsInInstance() then
            local instanceType = GetInstanceInfo()
            if instanceType == "party" then
                combatState = "dungeon"
            elseif instanceType == "raid" then
                combatState = "raid"
            elseif instanceType == "pvp" or instanceType == "arena" then
                combatState = "pvp"
            end
        end

        return {
            inCombat = inCombat,
            targetHealthPercent = targetHealthPercent,
            playerHealthPercent = playerHealthPercent,
            activeBuffs = activeBuffs,
            activeDebuffs = activeDebuffs,
            resourceLevels = resourceLevels,
            combatState = combatState
        }
    end

    return {
        resources = GetResourceTable(),
        buffs = {player = GetBuffsTable()},
        debuffs = {target = GetDebuffsTable()},
        cooldowns = {},
        timestamp = GetTime(),
        context = GetContextTable()
    }
end

--- Get secondary power type for current class
--- @return number Power type ID
function StateManager:GetSecondaryPowerType()
    local class = NAG.CLASS_FILENAME or UnitClassBase("player")
    if not class then return 0 end

    local secondaryPowerTypes = {
        ROGUE = 4,      -- Combo Points
        PALADIN = 9,    -- Holy Power
        WARLOCK = 7,    -- Soul Shards
        PRIEST = 13,    -- Insanity
        MONK = 12,      -- Chi
        MAGE = 16,      -- Arcane Charges
        DRUID = 4,      -- Combo Points (Cat Form)
        DEATHKNIGHT = 5, -- Death Knight runes (handled separately)
    }

    return secondaryPowerTypes[class] or 0
end

--- Advance state as if spell was cast
--- @param spell table Spell info {id, castTime, gcd, cooldown, cost}
function StateManager:AdvanceState(spell)
    if not spell or not stateSnapshot then return end

    -- Advance time by cast time + GCD
    local timeAdvance = spell.castTime or 0
    if timeAdvance == 0 and spell.gcd ~= "off" then
        timeAdvance = self:GetGCDDuration()
    end

    stateSnapshot.time = stateSnapshot.time + timeAdvance

    -- Get learned predictions if available
    local LPP = ns.LearnedPredictionProvider
    local powerType = UnitPowerType("player")
    local resourceTypeName = nil
    if Version:IsRetail() then
        if powerType == Enum.PowerType.Mana then
            resourceTypeName = "MANA"
        elseif powerType == Enum.PowerType.Energy then
            resourceTypeName = "ENERGY"
        elseif powerType == Enum.PowerType.Rage then
            resourceTypeName = "RAGE"
        elseif powerType == Enum.PowerType.RunicPower then
            resourceTypeName = "RUNIC_POWER"
        elseif powerType == Enum.PowerType.Focus then
            resourceTypeName = "FOCUS"
        end
    else
        if powerType == 0 then
            resourceTypeName = "MANA"
        elseif powerType == 1 then
            resourceTypeName = "RAGE"
        elseif powerType == 3 then
            resourceTypeName = "ENERGY"
        elseif powerType == 2 then
            resourceTypeName = "FOCUS"
        elseif powerType == 6 then
            resourceTypeName = "RUNIC_POWER"
        end
    end

    local costTelemetry = spell.id and LPP and LPP.GetCostTelemetry and LPP:GetCostTelemetry(spell.id) or nil
    local generationTelemetry = spell.id and LPP and LPP.GetGenerationTelemetry and resourceTypeName and LPP:GetGenerationTelemetry(spell.id, resourceTypeName) or nil

    if spell then
        spell.learnedCostTelemetry = costTelemetry
        spell.learnedGenerationTelemetry = generationTelemetry
    end

    local learnedCost = 0
    if costTelemetry and costTelemetry.value then
        local costData = costTelemetry.value
        if type(costData) == "number" then
            learnedCost = costData
        elseif type(costData) == "table" then
            if resourceTypeName and costData[resourceTypeName] then
                learnedCost = costData[resourceTypeName]
            elseif costData.DEFAULT then
                learnedCost = costData.DEFAULT
            elseif costData[powerType] then
                learnedCost = costData[powerType]
            elseif costData.MANA then
                learnedCost = costData.MANA
            elseif costData.ENERGY then
                learnedCost = costData.ENERGY
            elseif costData.RAGE then
                learnedCost = costData.RAGE
            elseif costData.RUNIC_POWER then
                learnedCost = costData.RUNIC_POWER
            end
        end
    end

    if (not learnedCost or learnedCost <= 0) and spell.cost then
        learnedCost = spell.cost
    end

    local learnedGeneration = 0
    if generationTelemetry and generationTelemetry.value then
        local genData = generationTelemetry.value
        if type(genData) == "number" then
            learnedGeneration = genData
        elseif type(genData) == "table" and resourceTypeName and genData[resourceTypeName] then
            learnedGeneration = genData[resourceTypeName]
        end
    end

    -- Spend resources (using learned cost if available)
    if learnedCost > 0 and stateSnapshot.power then
        stateSnapshot.power = math.max(0, stateSnapshot.power - learnedCost)
    end

    -- Apply resource generation (if spell generates resources)
    if learnedGeneration > 0 and stateSnapshot.power and stateSnapshot.powerMax then
        stateSnapshot.power = math.min(stateSnapshot.powerMax, stateSnapshot.power + learnedGeneration)
    end

    -- Simulate buff/debuff application using learned spell→aura mappings
    if spell.id and LPP then
        if LPP.GetExpectedAppliedBuffs then
            local buffIds = LPP:GetExpectedAppliedBuffs(spell.id)
            if buffIds then
                for _, buffId in ipairs(buffIds) do
                    self:ApplyBuff(buffId, 30)
                end
            end
        end
        if LPP.GetExpectedAppliedDebuffs then
            local debuffIds = LPP:GetExpectedAppliedDebuffs(spell.id)
            if debuffIds then
                for _, debuffId in ipairs(debuffIds) do
                    self:ApplyDebuff(debuffId, 30)
                end
            end
        end
    end

    -- Mark spell on cooldown in simulation
    if spell.id then
        local cooldownInfo = WoWAPI.GetSpellCooldown(spell.id)
        if cooldownInfo and cooldownInfo.duration and cooldownInfo.duration > 0 then
            simulatedSpellCooldowns[spell.id] = {
                startTime = stateSnapshot.time,
                duration = cooldownInfo.duration,
                expiresAt = stateSnapshot.time + cooldownInfo.duration
            }
        end
    end

    -- Regenerate resources over the time period
    self:RegenerateResources(timeAdvance)

    -- Update cooldowns and buffs
    self:UpdateCooldowns(timeAdvance)
    self:UpdateBuffs(timeAdvance)
end

--- Advance time and update all timers
--- @param seconds number Seconds to advance
function StateManager:AdvanceTime(seconds)
    if not stateSnapshot then return end

    -- Advance cooldowns, buffs, debuffs by time
    stateSnapshot.time = stateSnapshot.time + seconds
    self:UpdateCooldowns(seconds)
    self:UpdateBuffs(seconds)
    self:RegenerateResources(seconds)
end

--- Get current resources (simulation-aware)
--- @return table Current resource values {power, powerMax}
function StateManager:GetCurrentResources()
    if simulationMode and stateSnapshot then
        return {
            power = stateSnapshot.power or 0,
            powerMax = stateSnapshot.powerMax or 0,
        }
    end
    return {
        power = UnitPower("player"),
        powerMax = UnitPowerMax("player"),
    }
end

--- Get current cooldowns (simulation-aware)
--- @return table Current cooldown state (spellID → cooldown info)
function StateManager:GetCurrentCooldowns()
    if simulationMode and stateSnapshot then
        local cooldowns = {}
        for spellID, cdInfo in pairs(simulatedSpellCooldowns) do
            cooldowns[spellID] = {
                startTime = cdInfo.startTime,
                duration = cdInfo.duration,
                expiresAt = cdInfo.expiresAt,
            }
        end
        return cooldowns
    end
    return {}
end

--- Get current buffs (simulation-aware)
--- @return table Current buff state (array of buff entries)
function StateManager:GetCurrentBuffs()
    if simulationMode and stateSnapshot and stateSnapshot.buffs then
        return stateSnapshot.buffs
    end
    -- Live: query WoW API
    local buffs = {}
    for i = 1, 40 do
        local aura = UnitBuff("player", i)
        if not aura then break end
        buffs[i] = {
            spellId = aura.spellId,
            expirationTime = aura.expirationTime,
            duration = aura.duration,
            applications = aura.applications,
        }
    end
    return buffs
end

--- Get current debuffs (simulation-aware)
--- @return table Current debuff state (array of debuff entries)
function StateManager:GetCurrentDebuffs()
    if simulationMode and stateSnapshot and stateSnapshot.debuffs then
        return stateSnapshot.debuffs
    end
    -- Live: query WoW API
    local debuffs = {}
    if UnitExists("target") then
        for i = 1, 40 do
            local aura = UnitDebuff("target", i)
            if not aura then break end
            debuffs[i] = {
                spellId = aura.spellId,
                expirationTime = aura.expirationTime,
                duration = aura.duration,
                applications = aura.applications,
            }
        end
    end
    return debuffs
end

--- Get GCD duration
--- @return number GCD duration in seconds
function StateManager:GetGCDDuration()
    -- Default GCD duration - would need to be calculated based on haste
    return 1.5
end

--- Set spell cooldown
--- @param spellID number Spell ID
--- @param duration number Cooldown duration in seconds
function StateManager:SetSpellCooldown(spellID, duration)
    -- Placeholder - would need actual cooldown tracking implementation
end

--- Spend resources
--- @param cost table Resource costs {resource = amount}
function StateManager:SpendResources(cost)
    -- Placeholder - would need actual resource tracking implementation
end

--- Apply buff in simulation state (refreshes if already present)
--- @param buffID number Buff spell ID
--- @param duration number Buff duration in seconds (default 30)
function StateManager:ApplyBuff(buffID, duration)
    if not stateSnapshot or not stateSnapshot.buffs then return end
    duration = duration or 30
    local simTime = stateSnapshot.time or GetTime()

    -- Refresh if already present
    for _, buff in pairs(stateSnapshot.buffs) do
        if buff.spellId == buffID then
            buff.expirationTime = simTime + duration
            buff.duration = duration
            return
        end
    end

    -- New entry
    stateSnapshot.buffs[#stateSnapshot.buffs + 1] = {
        spellId = buffID,
        expirationTime = simTime + duration,
        duration = duration,
        applications = 1,
    }
end

--- Apply debuff in simulation state (refreshes if already present)
--- @param debuffID number Debuff spell ID
--- @param duration number Debuff duration in seconds (default 30)
function StateManager:ApplyDebuff(debuffID, duration)
    if not stateSnapshot or not stateSnapshot.debuffs then return end
    duration = duration or 30
    local simTime = stateSnapshot.time or GetTime()

    -- Refresh if already present
    for _, debuff in pairs(stateSnapshot.debuffs) do
        if debuff.spellId == debuffID then
            debuff.expirationTime = simTime + duration
            debuff.duration = duration
            return
        end
    end

    -- New entry
    stateSnapshot.debuffs[#stateSnapshot.debuffs + 1] = {
        spellId = debuffID,
        expirationTime = simTime + duration,
        duration = duration,
        applications = 1,
    }
end

--- Regenerate resources over time
--- @param seconds number Time to regenerate over
function StateManager:RegenerateResources(seconds)
    if not stateSnapshot then return end

    -- Simplified resource regeneration
    -- Focus regenerates at ~4 per second for hunters (base rate)
    -- This is a simplified model - actual rates vary by class/spec
    local regenRate = 4 -- Focus per second for hunters
    local regenAmount = regenRate * seconds

    if stateSnapshot.power and stateSnapshot.powerMax then
        stateSnapshot.power = math.min(stateSnapshot.powerMax, stateSnapshot.power + regenAmount)
    end
end

--- Update cooldowns
--- @param seconds number Time to advance cooldowns
function StateManager:UpdateCooldowns(seconds)
    if not self.state or not self.state.player then return end

    -- Update buff/debuff expirations in snapshot
    if stateSnapshot and stateSnapshot.buffs then
        for i, buff in pairs(stateSnapshot.buffs) do
            if buff.expirationTime and buff.expirationTime > 0 then
                buff.expirationTime = buff.expirationTime - seconds
                if buff.expirationTime <= 0 then
                    stateSnapshot.buffs[i] = nil
                end
            end
        end
    end

    if stateSnapshot and stateSnapshot.debuffs then
        for i, debuff in pairs(stateSnapshot.debuffs) do
            if debuff.expirationTime and debuff.expirationTime > 0 then
                debuff.expirationTime = debuff.expirationTime - seconds
                if debuff.expirationTime <= 0 then
                    stateSnapshot.debuffs[i] = nil
                end
            end
        end
    end
end

--- Update buffs (alias for UpdateCooldowns for now)
--- @param seconds number Time to advance buffs
function StateManager:UpdateBuffs(seconds)
    self:UpdateCooldowns(seconds)
end

-- ============================ END PREDICTION QUEUE STATE MANAGEMENT ============================

-- Lightweight polling to keep per-target combo points updated (MoP stores CP on target)
function StateManager:UpdateCPTracker()
    if UnitClassBase("player") ~= "ROGUE" then return end
    if not self._cpTracker then self._cpTracker = { lastGuid = nil, lastCP = 0, prevCP = 0 } end

    local guid = UnitGUID("target")
    local cp = GetComboPoints("player", "target") or 0

    if self._cpTracker.lastGuid and guid ~= self._cpTracker.lastGuid then
        -- Preserve last target CP for storage on redirect usage
        self._cpTracker.prevCP = self._cpTracker.lastCP or 0
    end

    -- If we gain CP on current target, clear any stored CP (we're committing to this target)
    if cp > (self._cpTracker.lastCP or 0) and (self.state.player.storedComboPoints or 0) > 0 then
        self.state.player.storedComboPoints = 0
        if self.debug then self:Debug("CP tracker: CP increased -> clearing stored CP") end
    end

    self._cpTracker.lastGuid = guid
    self._cpTracker.lastCP = cp
end
