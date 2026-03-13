--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

    STATUS: Development
    NOTES: State manager for SpellLearner module that tracks state changes during spell casts

    IMPORTANT NOTE (2025-05-18): Added DebugFormatted helper function to fix string formatting issues
    when passing formatted strings to Debug function. This prevents "invalid option in `format`" and
    "bad argument #2 to 'format'" errors caused by double formatting.
]]

-- ======= LOCALIZE =======
--Addon
local _, ns = ...
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitCanAttack = _G.UnitCanAttack
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitPowerType = _G.UnitPowerType
local GetRuneType = _G.GetRuneType
local GetRuneCooldown = _G.GetRuneCooldown
local CheckInteractDistance = _G.CheckInteractDistance
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff

-- The legacy SpellLearner state manager is intentionally quarantined while
-- the streamlined v2 pipeline is restored. Keep the module inert if this file
-- is loaded accidentally (for example via stale user overrides).
if not (ns and ns.SpellLearnerEnableLegacy) then
    if ns then
        ns.SpellLearnerLegacyDisabled = true
    end
    return
end

local WoWAPI = ns.WoWAPI
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
local StateManager

--- @type TimerManager
local TimerManager

--- @type SpecCompat
local SpecCompat


local L = ns.AceLocale:GetLocale("NAG", true)

--Libs
local LSM = ns.LibSharedMedia
local AceConfigRegistry = ns.AceConfigRegistry
local Version = ns.Version

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local max = math.max
local wipe = wipe
local tinsert = tinsert
local tremove = tremove

-- Table utilities
local TableUtils = ns.TableUtils

-- Add these imports at the top, after the similar imports
local GetRuneCount = GetRuneCount or function() return 0 end -- Compatibility for different WoW versions

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Constants
local CONSTANTS = {
    MAX_RESOURCE_TYPES = 10,
    STATE_HISTORY_SIZE = 4,      -- Keep 1 second of history (4 * 0.25s)
    PRECAST_WINDOW = 0.5,        -- Time window to associate cooldown update with cast
    PRECAST_COOLDOWN = 0.5,      -- Minimum time between pre-cast snapshots
    POST_CAST_DELAY = 0.15,      -- Delay for post-cast state capture
    MIN_REFRESH_THRESHOLD = 0.6, -- Minimum duration increase to consider as refresh
    MAX_RUNES = 6,               -- Maximum number of runes
    MAX_STATE_CHANGES = 40,      -- Maximum number of state changes to store per spell
    RUNE_TYPE = {                -- Rune types
        BLOOD = 1,
        FROST = 2,
        UNHOLY = 3,
        DEATH = 4
    },
    DISTANCE_INDEX = {               -- Distance check indices
        INSPECT = 1,                 -- 28 yards
        TRADE = 2,                   -- 11.11 yards
        DUEL = 3,                    -- 9.9 yards
        FOLLOW = 4                   -- 28 yards
    },
    MIN_NATURAL_CHANGE_WINDOW = 0.0, -- Minimum time window to consider a change as natural
    NATURAL_CHANGE_WINDOW = 0.5,     -- Maximum time window to consider a change as natural
    RESOURCE_DETECTION_WINDOW = 0.3, -- Time window for resource change detection (seconds)
    BUFF_DETECTION_WINDOW = 0.5,     -- Time window for buff/debuff detection (seconds)
    RUNE_DETECTION_WINDOW = 0.5,     -- Time window for rune change detection (seconds)
    MAX_OBSERVATIONS = 10,           -- Maximum number of observations to store per spell effect (ring-cap)
    MIN_CONFIDENCE_THRESHOLD = 0.6,  -- Minimum confidence threshold to consider an effect reliable
}

-- Default settings
local defaults = {
    global = {
        version = 1,
    },
    char = {
        enabled = false, -- Disabled by default - use commands to enable
        trackResources = true,
        trackBuffs = true,
        trackDebuffs = true,
        trackCooldowns = true,
        -- Add these new storage tables for character-specific data
        spellCosts = {},
        runeCosts = {},
        spellEffects = {},
        resourceGeneration = {},
        runeProfiles = {},
        runeUsageSummary = {},
        spellChanges = {},
        -- Add spec-specific storage
        specStorage = {
            -- This will be indexed by specIndex (1, 2, 3, 4)
            -- [0] = {}, -- Default/unknown spec
            -- [1] = {}, -- Example: First spec
        },
        lastSpecIndex = nil -- Track last used spec for migrations
    }
}

--- @class SpellLearnerStateManager: CoreModule
local SpellLearnerStateManager = NAG:CreateModule("SpellLearnerStateManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,

    -- Event handlers using eventHandlers table
    eventHandlers = {
        UNIT_SPELLCAST_SENT = true,
        UNIT_SPELLCAST_SUCCEEDED = true,
        UNIT_POWER_UPDATE = true,
        UNIT_AURA = true,
        SPELL_UPDATE_COOLDOWN = true,
        PLAYER_ENTERING_WORLD = true,
        ACTIONBAR_UPDATE_COOLDOWN = true, -- Add new event handler

        RUNE_POWER_UPDATE = true,         -- Add the Death Knight rune event
        ["PLAYER_TARGET_CHANGED"] = true,
        -- Talent events handled by SpecCompat and broadcast via NAG_TALENTS_UPDATED message
        -- PLAYER_TALENT_UPDATE removed
    },
    cleuHandlers = {
        SPELL_CAST_START = "HandleCLEUSpellCastStart",
        SPELL_CAST_SUCCESS = "HandleCLEUSpellCastSuccess",
        SPELL_AURA_APPLIED = "HandleCLEUAuraApplied",
        SPELL_AURA_APPLIED_DOSE = "HandleCLEUAuraAppliedDose",
    },
    -- Message handlers using messageHandlers table
    messageHandlers = {
        ["NAG_DB_RESET"] = true,
        ["NAG_SPEC_UPDATED"] = true,
        ["NAG_TALENTS_UPDATED"] = true,  -- Talent updates (broadcast by SpecCompat)
    },

    -- Default state
    defaultState = {
        currentState = {
            resources = {},
            buffs = {},
            debuffs = {},
            cooldowns = {},
            gcd = {
                remaining = 0,
                startTime = 0,
            },
            casting = {
                spellID = nil,
                startTime = 0,
                endTime = 0,
            },
        },
        stateHistory = {},           -- Initialize empty state history
        activeCasts = {},            -- Track casts in progress
        knownSpells = {},
        spellEffects = {},           -- Track spell -> buff relationships
        activeBuffs = {},            -- Track active buffs and their sources
        lastCastGUID = nil,
        pendingCooldownUpdate = nil, -- Add this to track pre-cast state
        lastCooldownUpdateTime = 0,  -- Add this to track when cooldown updates happen
        lastPreCastSnapshotTime = 0, -- Add this to track pre-cast snapshot timing
        trackedNextSpells = {},      -- Track last 2 unique NAG.nextSpell IDs (numeric). If ever populated from NAG.nextSpell, resolve via GetActionResolveId(NAG.nextSpell) first.
        trackedNextSpellsCount = 0,  -- Count of unique spells being tracked
        activeCast = nil,            -- Currently active cast for direct tracking
        spellCosts = {},             -- Track resource costs
        runeCosts = {},              -- Track rune costs (for Death Knights)
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        ["states"] = {
            handler = "HandleStatesCommand",
            help = "Inspect stored spell changes. Usage: /nagdebug states [spellID]",
            root = "nagdebug",
            category = "Data"
        },
        ["buffs"] = {
            handler = "HandleBuffsCommand",
            help = "Debug buff tracking information",
            root = "nagdebug",
            category = "Debug"
        },
        ["spelldata"] = {
            handler = "HandleSpellDataCommand",
            help = "View learned spell data. Usage: /nagdebug spelldata [spellID]",
            root = "nagdebug",
            category = "Data"
        },
        ["runes"] = {
            handler = "HandleRunesCommand",
            help = "View rune usage data. Usage: /nagdebug runes [spellID]",
            root = "nagdebug",
            category = "Data"
        },
        ["storage"] = {
            handler = "HandleStorageCommand",
            help = "Manage storage settings. Usage: /nagdebug storage [global|char|clearspec|listspecs]",
            root = "nagdebug",
            category = "System"
        },
        ["specdata"] = {
            handler = "HandleSpecDataCommand",
            help = "View spec-specific spell data. Usage: /nagdebug specdata [spellID] [specIndex|all]",
            root = "nagdebug",
            category = "Data"
        }
    }
})
local module = SpellLearnerStateManager
ns.SpellLearnerStateManager = SpellLearnerStateManager



-- Define the InitializeSpellTracking function before it's called
function SpellLearnerStateManager:InitializeSpellTracking()
    -- Debug output

    -- Initialize the knownSpells table if needed
    if not self.state.knownSpells then
        self.state.knownSpells = {}
    end

    -- Scan spellbook for known spells
    local spellCount = 0
    for i = 1, WoWAPI.GetNumSpellTabs() do
        local tabInfo = WoWAPI.GetSpellTabInfo(i)
        if tabInfo then
            local offset = tabInfo.itemIndexOffset
            local numSpells = tabInfo.numSpellBookItems
            if offset and numSpells then
                for j = offset + 1, offset + numSpells do
                    local spellInfo = WoWAPI.GetSpellInfo(j, BOOKTYPE_SPELL)
                    if spellInfo and spellInfo.spellID then
                        self.state.knownSpells[spellInfo.spellID] = true
                        spellCount = spellCount + 1
                    end
                end
            end
        end
    end

    if self.debug then self:Debug("Found %d spells in spellbook", spellCount) end
end

do -- Ace3 lifecyle methods
    --- Initialize the module
    function SpellLearnerStateManager:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        StateManager = NAG:GetModule("StateManager")
        TimerManager = NAG:GetModule("TimerManager")
        SpecCompat = NAG:GetModule("SpecCompat")

        -- Initialize state from defaultState
        self.state = CopyTable(self.defaultState)

        -- Initialize character storage
        self:InitializeCharacterStorage()

        -- Initialize aura cache FIRST
        self.auraCache = {
            player = {},
            target = {},
            lastTargetGUID = nil
        }

        -- Initialize spell tracking
        self:InitializeSpellTracking()

        -- Initialize resource tracking
        self:InitializeResourceTracking()

        -- Initialize improved spell cost and effect tracking
        self:InitializeImprovedTracking()

        -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns

        -- Periodic state ticker removed: event-driven only

        -- Perform the spec check at initialization
        self:CheckSpecChange()

        -- Slash commands are now handled via zero-boilerplate slashCommands table

        -- ZERO-BOILERPLATE: Messages are automatically registered via declarative patterns

        self:Debug("Module initialized")
    end

    --- Enable the module
    function SpellLearnerStateManager:ModuleEnable()
        -- Check if module is enabled

        -- ============================ MODULE INITIALIZATION ============================
        if not self.db.char.enabled then
            self:Debug("SpellLearnerStateManager is disabled by default. Use a command to enable it.")
            return
        end

        -- Start tracking state changes
        -- Disable noisy periodic updates on enable; capture will run around casts only
        -- self:UpdatePlayerBuffs()
        -- self:UpdateTargetDebuffs()
        -- self:UpdateCooldowns()

        -- CRITICAL FIX: Don't re-register events here - they are already registered in OnInitialize
        -- This was causing double registrations which could interfere with buff tracking

        -- ZERO-BOILERPLATE: Messages are automatically registered via declarative patterns

        -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns
        -- Classic talent events are handled via declarative patterns

        -- Check for spec changes on startup
        self:CheckSpecChange()

        self:Debug("Module enabled - events already registered in OnInitialize")
        self:Debug("Registered for spec change events")
    end

    --- Disable the module
    function SpellLearnerStateManager:ModuleDisable()
        -- Debug output for cleanup start

        self:Debug("Starting SpellLearner state manager cleanup")

        -- Release all states in history
        if self.state.stateHistory then
            for _, entry in ipairs(self.state.stateHistory) do
                if entry.state then
                    self:ReleaseStateObject(entry.state)
                end
            end
            wipe(self.state.stateHistory)
        end

        -- Clean up active casts
        wipe(self.state.activeCasts)

        -- Complete cache cleanup
        if self.auraCache then
            wipe(self.auraCache)
            self.auraCache = {
                target = {},
                lastTargetGUID = nil
            }
        end

        -- Clean up current state
        if self.state.currentState then
            self:ReleaseStateObject(self.state.currentState)
            self.state.currentState = nil
        end

        -- State ticker removed; nothing to cancel

        -- Unregister events
        self:UnregisterAllEvents()
        self:Debug("Events unregistered")

        -- Final cleanup message
        self:Debug("SpellLearner state manager cleanup complete")
    end
end

--- Initialize per-character storage tables
function SpellLearnerStateManager:InitializeCharacterStorage()
    -- Make sure all character storage tables exist
    if not self.db.char.spellCosts then self.db.char.spellCosts = {} end
    if not self.db.char.runeCosts then self.db.char.runeCosts = {} end
    if not self.db.char.spellEffects then self.db.char.spellEffects = {} end
    if not self.db.char.resourceGeneration then self.db.char.resourceGeneration = {} end
    if not self.db.char.runeProfiles then self.db.char.runeProfiles = {} end
    if not self.db.char.runeUsageSummary then self.db.char.runeUsageSummary = {} end
    if not self.db.char.spellChanges then self.db.char.spellChanges = {} end

    self:Debug("Initialized character-specific storage tables")
end

--- Initialize resource tracking
function SpellLearnerStateManager:InitializeResourceTracking()
    -- Initialize resource tracking tables with generic power entries
    -- This will automatically map to the primary resource of the class (mana/energy/rage/etc)
    -- and secondary resource (combo points/holy power/etc)
    self.state.currentState.resources = {
        power = UnitPower("player"),                                   -- Primary resource (mana, energy, rage, etc)
        secondary = UnitPower("player", self:GetSecondaryPowerType()), -- Secondary resource if any
    }
end

--- Helper to get the correct secondary power type for the current class/spec
function SpellLearnerStateManager:GetSecondaryPowerType()
    local class = NAG.CLASS_FILENAME
    -- Default to 0 (mana) if we can't determine
    if not class then return 0 end

    -- Map classes to their secondary resource type
    local secondaryPowerTypes = {
        ROGUE = 4,   -- Combo Points
        PALADIN = 9, -- Holy Power
        WARLOCK = 7, -- Soul Shards
        PRIEST = 13, -- Insanity
        MONK = 12,   -- Chi
        MAGE = 16,   -- Arcane Charges
        DRUID = 4,   -- Combo Points (Cat Form)
    }

    return secondaryPowerTypes[class] or 0
end

-- Table pool for state objects
local statePool = {
    states = {},
    resources = {},
    buffs = {},
    debuffs = {}
}

-- Get a table from the pool or create a new one
local function AcquireTable(pool)
    local tbl = tremove(pool) or {}
    wipe(tbl)
    return tbl
end

-- Release a table back to the pool
local function ReleaseTable(pool, tbl)
    if tbl then
        wipe(tbl)
        tinsert(pool, tbl)
    end
end

-- Release a state object and all its sub-tables
function SpellLearnerStateManager:ReleaseStateObject(state)
    if not state then return end

    -- Release resources tables
    if state.resources then
        ReleaseTable(statePool.resources, state.resources.power)
        ReleaseTable(statePool.resources, state.resources.secondary)
        ReleaseTable(statePool.resources, state.resources)
    end

    -- Release buffs/debuffs tables
    if state.buffs then
        ReleaseTable(statePool.buffs, state.buffs.player)
        ReleaseTable(statePool.buffs, state.buffs.target)
        ReleaseTable(statePool.buffs, state.buffs)
    end

    if state.debuffs then
        ReleaseTable(statePool.debuffs, state.debuffs.player)
        ReleaseTable(statePool.debuffs, state.debuffs.target)
        ReleaseTable(statePool.debuffs, state.debuffs)
    end

    -- Release the main state table
    ReleaseTable(statePool.states, state)
end

--- Capture current game state
function SpellLearnerStateManager:CaptureCurrentState()
    local currentTime = GetTime()
    local powerType = UnitPowerType("player")
    local class = NAG.CLASS_FILENAME


    -- CRITICAL FIX: Force refresh aura cache before capturing state
    -- This ensures we have the most up-to-date buff/debuff information
    self:UpdateAuraCache("player")
    if UnitExists("target") then
        self:UpdateAuraCache("target")
    end

    -- Acquire tables from pools
    local state = AcquireTable(statePool.states)
    state.timestamp = currentTime

    -- Resources
    state.resources = AcquireTable(statePool.resources)
    state.resources.power = AcquireTable(statePool.resources)
    state.resources.power.type = powerType
    state.resources.power.current = UnitPower("player")
    state.resources.power.max = UnitPowerMax("player")

    state.resources.secondary = AcquireTable(statePool.resources)
    state.resources.secondary.type = self:GetSecondaryPowerType()
    state.resources.secondary.current = UnitPower("player", self:GetSecondaryPowerType())
    state.resources.secondary.max = UnitPowerMax("player", self:GetSecondaryPowerType())

    -- Death Knight Runes
    if class == "DEATHKNIGHT" then
        state.runes = {}
        for i = 1, CONSTANTS.MAX_RUNES do
            local start, duration, runeReady = GetRuneCooldown(i)
            local runeType = GetRuneType(i)
            local timeLeft = start and duration and (start + duration - currentTime) or 0

            state.runes[i] = {
                type = runeType,
                start = start or 0,
                duration = duration or 0,
                ready = runeReady == 1,
                timeLeft = timeLeft,
                willRefresh = not (runeReady == 1) and timeLeft <= CONSTANTS.PRECAST_WINDOW
            }

            if NAG:IsDevModeEnabled() then
                local currentRune = state.runes[i]
                local typeStr = currentRune.type == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                    or currentRune.type == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                    or currentRune.type == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                    or currentRune.type == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                    or "Unknown"
                if self.debug then
                    self:Debug("Rune %d: Type=%s, Ready=%s, TimeLeft=%.1f, WillRefresh=%s", i, typeStr,
                        tostring(currentRune.ready), timeLeft, tostring(currentRune.willRefresh))
                end
            end
        end
    end

    -- Druid Eclipse State
    if class == "DRUID" then
        state.resources.balance = {
            solar = UnitPower("player", Enum.PowerType.Balance),
            lunar = UnitPower("player", Enum.PowerType.Balance),
            phase = NAG:DruidCurrentEclipsePhase(),
            direction = "none" -- Will be determined during comparison
        }

        if NAG:IsDevModeEnabled() then
            self:Debug("Captured Druid eclipse state:")
            if self.debug then self:Debug("  Phase: %s", state.resources.balance.phase) end
            if self.debug then self:Debug("  Solar Energy: %d", state.resources.balance.solar) end
            if self.debug then self:Debug("  Lunar Energy: %d", state.resources.balance.lunar) end
        end
    end

    -- Initialize buff/debuff containers
    state.buffs = AcquireTable(statePool.buffs)
    state.buffs.player = AcquireTable(statePool.buffs)
    state.buffs.target = AcquireTable(statePool.buffs)

    state.debuffs = AcquireTable(statePool.debuffs)
    state.debuffs.player = AcquireTable(statePool.debuffs)
    state.debuffs.target = AcquireTable(statePool.debuffs)

    -- DEBUG: Log aura cache contents before copying
    if NAG:IsDevModeEnabled() then
        local playerBuffCount = 0
        for spellId, auraInfo in pairs(self.auraCache.player) do
            if auraInfo.isHelpful then
                playerBuffCount = playerBuffCount + 1
                -- if self.debug then self:Debug("Player aura cache BUFF: %s (ID: %d) - Helpful: %s", --auraInfo.name, spellId, tostring(auraInfo.isHelpful)) end
            end
        end
        if self.debug then self:Debug("Aura cache has %d player buffs before copying to state", playerBuffCount) end
    end

    -- Use aura cache for player buffs/debuffs
    for spellId, auraInfo in pairs(self.auraCache.player) do
        if auraInfo.isHelpful then
            state.buffs.player[spellId] = {
                name = auraInfo.name,
                count = auraInfo.count,
                duration = auraInfo.duration,
                expirationTime = auraInfo.expirationTime,
                source = auraInfo.sourceUnit
            }
        else
            state.debuffs.player[spellId] = {
                name = auraInfo.name,
                count = auraInfo.count,
                debuffType = auraInfo.debuffType,
                duration = auraInfo.duration,
                expirationTime = auraInfo.expirationTime,
                source = auraInfo.sourceUnit
            }
        end
    end

    -- Capture target buffs/debuffs if target exists
    if UnitExists("target") then
        for spellId, auraInfo in pairs(self.auraCache.target) do
            if auraInfo.isHelpful then
                state.buffs.target[spellId] = {
                    name = auraInfo.name,
                    count = auraInfo.count,
                    duration = auraInfo.duration,
                    expirationTime = auraInfo.expirationTime,
                    source = auraInfo.sourceUnit
                }
            else
                state.debuffs.target[spellId] = {
                    name = auraInfo.name,
                    count = auraInfo.count,
                    debuffType = auraInfo.debuffType,
                    duration = auraInfo.duration,
                    expirationTime = auraInfo.expirationTime,
                    source = auraInfo.sourceUnit
                }
            end
        end
    end

    -- DEBUG: Show captured buff counts and specifically look for Blood Shield
    if NAG:IsDevModeEnabled() then
        local capturedBuffCount = TableUtils.Size(state.buffs.player)
        -- if self.debug then self:Debug("Captured state at %.3f with %d player buffs, %d player debuffs, %d target buffs, %d target debuffs", --currentTime, --capturedBuffCount, --TableUtils.Size(state.debuffs.player), --TableUtils.Size(state.buffs.target), --TableUtils.Size(state.debuffs.target)) end

        -- Specifically check for Blood Shield (spell ID 77535)
        if state.buffs.player[77535] then
            local bloodShield = state.buffs.player[77535]
            if self.debug then
                self:Debug(
                    "✅ FOUND Blood Shield in captured state: %s (ID: 77535), Count: %d, Duration: %.1f", bloodShield
                    .name,
                    bloodShield.count or 1, bloodShield.duration or 0)
            end
        else
            self:Debug("❌ Blood Shield (ID: 77535) NOT found in captured player buffs")
            -- Debug: Show what buffs we DID capture
            if capturedBuffCount > 0 then
                self:Debug("Captured buffs instead:")
                for spellId, buff in pairs(state.buffs.player) do
                    if self.debug then self:Debug("  - %s (ID: %d)", buff.name, spellId) end
                end
            end
        end
    end

    return state
end

--- Format a state snapshot for readable output
function SpellLearnerStateManager:FormatStateSnapshot(state)
    local output = {}

    -- Header
    tinsert(output, "=== STATE SNAPSHOT ===")
    tinsert(output, format("Timestamp: %.2f", state.timestamp))

    -- Resources
    tinsert(output, "\n=== RESOURCES ===")
    -- Primary Power
    local powerTypes = {
        [0] = "Mana",
        [1] = "Rage",
        [2] = "Focus",
        [3] = "Energy",
        [6] = "Runic Power"
    }
    local primaryType = powerTypes[state.resources.power.type] or state.resources.power.type
    tinsert(output, format("Primary (%s): %d / %d",
        primaryType,
        state.resources.power.current,
        state.resources.power.max
    ))

    -- Secondary Power
    local secondaryTypes = {
        [4] = "Combo Points",
        [7] = "Soul Shards",
        [9] = "Holy Power",
        [12] = "Chi",
        [13] = "Insanity"
    }
    local secondaryType = secondaryTypes[state.resources.secondary.type] or state.resources.secondary.type
    tinsert(output, format("Secondary (%s): %d / %d",
        secondaryType,
        state.resources.secondary.current,
        state.resources.secondary.max
    ))

    -- Player Buffs
    tinsert(output, "\n=== PLAYER BUFFS ===")
    local playerBuffCount = 0
    for spellId, buff in pairs(state.buffs.player) do
        playerBuffCount = playerBuffCount + 1
        local timeLeft = buff.expirationTime > 0 and (buff.expirationTime - GetTime()) or 0
        tinsert(output, format("%s (ID: %d) - Stacks: %d, Time Left: %.1fs",
            buff.name,
            spellId,
            buff.count or 1,
            timeLeft
        ))
    end
    if playerBuffCount == 0 then
        tinsert(output, "No active buffs")
    end

    -- Player Debuffs
    tinsert(output, "\n=== PLAYER DEBUFFS ===")
    local playerDebuffCount = 0
    for spellId, debuff in pairs(state.debuffs.player) do
        playerDebuffCount = playerDebuffCount + 1
        local timeLeft = debuff.expirationTime > 0 and (debuff.expirationTime - GetTime()) or 0
        tinsert(output, format("%s (ID: %d) - Stacks: %d, Time Left: %.1fs, Type: %s",
            debuff.name,
            spellId,
            debuff.count or 1,
            timeLeft,
            debuff.debuffType or "None"
        ))
    end
    if playerDebuffCount == 0 then
        tinsert(output, "No active debuffs")
    end

    -- Target Buffs (if target exists)
    if UnitExists("target") then
        tinsert(output, format("\n=== TARGET (%s) BUFFS ===", UnitName("target") or "Unknown"))
        local targetBuffCount = 0
        for spellId, buff in pairs(state.buffs.target) do
            targetBuffCount = targetBuffCount + 1
            local timeLeft = buff.expirationTime > 0 and (buff.expirationTime - GetTime()) or 0
            tinsert(output, format("%s (ID: %d) - Stacks: %d, Time Left: %.1fs",
                buff.name,
                spellId,
                buff.count or 1,
                timeLeft
            ))
        end
        if targetBuffCount == 0 then
            tinsert(output, "No active buffs")
        end

        -- Target Debuffs
        tinsert(output, format("\n=== TARGET (%s) DEBUFFS ===", UnitName("target") or "Unknown"))
        local targetDebuffCount = 0
        for spellId, debuff in pairs(state.debuffs.target) do
            targetDebuffCount = targetDebuffCount + 1
            local timeLeft = debuff.expirationTime > 0 and (debuff.expirationTime - GetTime()) or 0
            tinsert(output, format("%s (ID: %d) - Stacks: %d, Time Left: %.1fs, Type: %s",
                debuff.name,
                spellId,
                debuff.count or 1,
                timeLeft,
                debuff.debuffType or "None"
            ))
        end
        if targetDebuffCount == 0 then
            tinsert(output, "No active debuffs")
        end
    end

    tinsert(output, "=====================")
    return table.concat(output, "\n")
end

--- Event handler for UNIT_SPELLCAST_SENT
function SpellLearnerStateManager:UNIT_SPELLCAST_SENT(event, unit, target, castGUID, spellID)
    -- Check if module is enabled
    if not self.db.char.enabled then
        return
    end

    if unit ~= "player" then return end

    local currentTime = GetTime()
    --self:Debug("|cFFFFFF00UNIT_SPELLCAST_SENT fired at " .. format("%.3f", currentTime) .. " for spell " .. tostring(spellID) .. "|r")

    -- Clean up any old casts that might not have been processed
    for guid, data in pairs(self.state.activeCasts) do
        if currentTime - data.timestamp > 2 then -- Clear any stale casts older than 2 seconds
            self.state.activeCasts[guid] = nil
        end
    end

    -- Get the pre-cast state from ACTIONBAR_UPDATE_COOLDOWN
    local preState = nil
    if self.state.pendingCooldownUpdate then
        local timeSinceCooldownUpdate = currentTime - self.state.pendingCooldownUpdate.timestamp

        if timeSinceCooldownUpdate < CONSTANTS.PRECAST_WINDOW then
            -- Use the state captured during cooldown update
            preState = self.state.pendingCooldownUpdate.state
            self.state.pendingCooldownUpdate = nil -- Clear it after use

            --self:Debug("|cFFFFFF00Using pre-cast state from %.3f seconds ago|r", timeSinceCooldownUpdate)
            --else
            -- Cooldown update state is too old
            --self:Debug("|cFFFF0000WARNING: Pre-cast state too old (%.3f seconds) for %s (ID: %d)|r",
            --    timeSinceCooldownUpdate,
            --    WoWAPI.GetSpellInfo(spellID) or "Unknown",
            --    spellID)
        end
        --else
        -- No cooldown update state available
        -- self:Debug("|cFFFF0000WARNING: No pre-cast state available for %s (ID: %d)|r",
        --     WoWAPI.GetSpellInfo(spellID) or "Unknown",
        --     spellID)
    end

    -- Store cast info if we have a valid pre-state
    if preState then
        self.state.activeCasts[castGUID] = {
            spellID = spellID,
            timestamp = currentTime,
            preState = preState,
            target = target,
            targetGUID = target and UnitGUID(target) or nil
        }

        -- Store this as the last cast GUID
        self.state.lastCastGUID = castGUID
    end
end

--- Calculate state changes between two states with improved efficiency
function SpellLearnerStateManager:CalculateStateChanges(preState, postState)
    if not preState or not postState then return nil end

    local changes = {
        resources = {},
        buffs = {
            gained = {},
            lost = {},
            consumed = {},
            refreshed = {},
        },
        dots = {
            applied = {},
            removed = {},
            refreshed = {},
            consumed = {},
        }
    }

    -- Debug header for state comparison
    self:Debug("Calculating state changes:")
    self:Debug("Pre-state timestamp: " .. (tostring(preState.timestamp) or "unknown"))
    self:Debug("Post-state timestamp: " .. (postState.timestamp or "unknown"))

    -- Check resource changes first (most important)
    local powerDelta = postState.resources.power.current - preState.resources.power.current
    if math.abs(powerDelta) > 0 then
        changes.resources.power = {
            delta = powerDelta,
            preValue = preState.resources.power.current,
            postValue = postState.resources.power.current,
            powerType = preState.resources.power.type
        }
        if self.debug then
            self:Debug("Power change: %d -> %d (Δ%d) [%s]", preState.resources.power.current,
                postState.resources.power.current, powerDelta, preState.resources.power.type or "unknown")
        end
    end

    -- Check secondary resource only if it changed
    local secondaryDelta = postState.resources.secondary.current - preState.resources.secondary.current
    if math.abs(secondaryDelta) > 0 then
        changes.resources.secondary = {
            delta = secondaryDelta,
            preValue = preState.resources.secondary.current,
            postValue = postState.resources.secondary.current,
            powerType = preState.resources.secondary.type
        }
        if self.debug then
            self:Debug("Secondary resource change: %d -> %d (Δ%d) [%s]",
                preState.resources.secondary.current, postState.resources.secondary.current, secondaryDelta,
                preState.resources.secondary.type or "unknown")
        end
    end

    -- Debug buff changes
    self:Debug("Checking buff changes:")

    -- Optimize buff checking by using direct table lookups
    local preBuffs = preState.buffs.player
    local postBuffs = postState.buffs.player

    -- Track gained/refreshed buffs
    for spellId, postBuff in pairs(postBuffs) do
        local preBuff = preBuffs[spellId]
        if not preBuff then
            -- New buff gained
            tinsert(changes.buffs.gained, {
                id = spellId,
                name = postBuff.name,
                count = postBuff.count
            })
            if self.debug then
                self:Debug("Buff gained: %s (id: %d, count: %d)", postBuff.name or "unknown", spellId,
                    postBuff.count or 1)
            end
        elseif postBuff.expirationTime > preBuff.expirationTime then
            -- Buff was refreshed
            tinsert(changes.buffs.refreshed, {
                id = spellId,
                name = postBuff.name,
                oldExpiration = preBuff.expirationTime,
                newExpiration = postBuff.expirationTime
            })
            if self.debug then
                self:Debug("Buff refreshed: %s (id: %d, duration extended by %.1f seconds)",
                    postBuff.name or "unknown", spellId, postBuff.expirationTime - preBuff.expirationTime)
            end
        end
    end

    -- Track lost buffs
    for spellId, preBuff in pairs(preBuffs) do
        if not postBuffs[spellId] then
            -- Check if buff was consumed (still had significant duration)
            local remainingTime = preBuff.expirationTime - GetTime()
            if remainingTime > 0.1 then
                tinsert(changes.buffs.consumed, {
                    id = spellId,
                    name = preBuff.name,
                    remainingTime = remainingTime
                })
                if self.debug then
                    self:Debug("Buff consumed: %s (id: %d, %.1f seconds remaining)",
                        preBuff.name or "unknown", spellId, remainingTime)
                end
            else
                tinsert(changes.buffs.lost, {
                    id = spellId,
                    name = preBuff.name
                })
                if self.debug then self:Debug("Buff expired: %s (id: %d)", preBuff.name or "unknown", spellId) end
            end
        end
    end

    -- Debug DoT changes
    self:Debug("Checking DoT changes:")

    -- Handle DoTs similarly to buffs but with target-specific logic
    if UnitExists("target") then
        local preDebuffs = preState.debuffs.target
        local postDebuffs = postState.debuffs.target

        -- Track gained/refreshed DoTs
        for spellId, postDebuff in pairs(postDebuffs) do
            local preDebuff = preDebuffs[spellId]

            -- Calculate timing info if the debuff existed before
            local oldTimeLeft, newTimeLeft, timeDiff = 0, 0, 0
            if preDebuff then
                oldTimeLeft = preDebuff.expirationTime > 0 and (preDebuff.expirationTime - GetTime()) or 0
                newTimeLeft = postDebuff.expirationTime > 0 and (postDebuff.expirationTime - GetTime()) or 0
                timeDiff = newTimeLeft - oldTimeLeft
            end

            -- Only consider it a refresh if the duration increased significantly
            local isRefresh = preDebuff and timeDiff >= CONSTANTS.MIN_REFRESH_THRESHOLD

            -- Debug output for comparison
            --if preDebuff then
            --if self.debug then self:Debug("|cFF00FFFF[TARGET] Comparing Debuff: %s (ID: %d)|r", postDebuff.name, spellId) end
            --if self.debug then self:Debug("  Old Time Left: %.1f, New Time Left: %.1f, Difference: %.1f%s|r", --    oldTimeLeft, --    newTimeLeft, --    timeDiff, --    isRefresh and " (REFRESH)" or " (NO REFRESH)") end
            --end

            -- Only store in state changes if it's actually new or refreshed
            if not preDebuff or isRefresh then
                changes.dots.applied[spellId] = {
                    id = spellId,
                    name = postDebuff.name,
                    duration = postDebuff.duration,
                    expirationTime = postDebuff.expirationTime,
                    count = postDebuff.count or 1,
                    isRefresh = isRefresh,
                    -- Include refresh-specific info if it is a refresh
                    oldTimeLeft = isRefresh and oldTimeLeft or nil,
                    newTimeLeft = isRefresh and newTimeLeft or nil,
                    timeDiff = isRefresh and timeDiff or nil,
                    oldDuration = isRefresh and preDebuff.duration or nil,
                    oldExpirationTime = isRefresh and preDebuff.expirationTime or nil
                }

                -- Debug output for actual changes
                --if isRefresh then
                --if self.debug then self:Debug("|cFF00FFFF[TARGET] Refreshed Debuff: %s (ID: %d) - Extended by %.1f seconds (%.1f -> %.1f)|r", --    postDebuff.name, --    spellId, --    timeDiff, --    oldTimeLeft, --    newTimeLeft) end
                --else
                --if self.debug then self:Debug("|cFF00FFFF[TARGET] New Debuff: %s (ID: %d) - Duration: %.1f|r", --    postDebuff.name, --    spellId, --    postDebuff.duration or 0) end
                --end
            end
        end

        -- Track removed/consumed DoTs
        for spellId, preDebuff in pairs(preDebuffs) do
            if not postDebuffs[spellId] then
                local remainingTime = preDebuff.expirationTime - GetTime()
                if remainingTime > 0.1 then
                    tinsert(changes.dots.consumed, {
                        id = spellId,
                        name = preDebuff.name,
                        remainingTime = remainingTime
                    })
                    --if self.debug then self:Debug("DoT consumed: %s (id: %d, %.1f seconds remaining)", --    preDebuff.name or "unknown", --    spellId, --    remainingTime
                    --) end
                else
                    tinsert(changes.dots.removed, {
                        id = spellId,
                        name = preDebuff.name
                    })
                    --if self.debug then self:Debug("DoT expired: %s (id: %d)", --    preDebuff.name or "unknown", --    spellId
                    --) end
                end
            end
        end
    end

    return changes
end

--- Print state changes with improved resource reporting
function SpellLearnerStateManager:PrintStateChanges(changes, spellID)
    if not NAG:IsDevModeEnabled() then return end

    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local spellName = spellInfo and spellInfo.name or "Unknown"

    -- Single line summary of spell cast and its effects
    local msg = format("Cast %s (ID: %d)", spellName, spellID)

    -- Add resource changes
    for resourceType, change in pairs(changes.resources) do
        if change.delta ~= 0 then
            local powerTypeName = _G[format("POWER_TYPE_%s", strupper(resourceType))] or resourceType
            if change.delta < 0 then
                msg = msg .. format(" - Used %d %s", math.abs(change.delta), powerTypeName)
            else
                msg = msg .. format(" - Gained %d %s", change.delta, powerTypeName)
            end
        end
    end

    -- Add DoT effects if any were applied/consumed
    if #changes.dots.applied > 0 then
        for _, dot in ipairs(changes.dots.applied) do
            if self:IsEffectFromSpell(dot.id, spellID) then
                local spellInfo = WoWAPI.GetSpellInfo(dot.id)
                local dotName = spellInfo and spellInfo.name or "Unknown"
                msg = msg .. format(" - Applied %s", dotName)
            end
        end
    end

    if #changes.dots.consumed > 0 then
        for _, dot in ipairs(changes.dots.consumed) do
            if self:IsEffectConsumedBySpell(dot.id, spellID) then
                local spellInfo = WoWAPI.GetSpellInfo(dot.id)
                local dotName = spellInfo and spellInfo.name or "Unknown"
                msg = msg .. format(" - Consumed %s", dotName)
            end
        end
    end

    self:Debug(msg)
end

--- Calculate expected resource regeneration between timestamps
function SpellLearnerStateManager:CalculateResourceRegen(resourceType, preValue, postValue)
    local regenRates = {
        power = 0,   -- Will be calculated based on spirit/mp5
        energy = 10, -- Energy regenerates at 10 per second
        focus = 4,   -- Focus regenerates at 4 per second
        -- Add other resource types as needed
    }

    local timeDiff = self.state.lastUpdate and (GetTime() - self.state.lastUpdate) or 0
    local expectedRegen = (regenRates[resourceType] or 0) * timeDiff

    return expectedRegen
end

--- Verify if an effect is actually from a specific spell
function SpellLearnerStateManager:IsEffectFromSpell(effectID, spellID)
    -- Check our known spell effects database
    local spellEffects = self.db.global["spellEffects." .. spellID]
    if spellEffects and spellEffects[effectID] then
        return true
    end

    -- Check timing - effect must have appeared within our cast window
    local castData = self.state.activeCasts[self.state.lastCastGUID]
    if castData then
        local timeSinceCast = GetTime() - castData.timestamp
        -- Effect must appear within 0.1s of cast completion
        return timeSinceCast <= 0.1
    end

    return false
end

--- Check if an effect was consumed by a specific spell
function SpellLearnerStateManager:IsEffectConsumedBySpell(effectID, spellID)
    -- Similar to IsEffectFromSpell but for consumption
    local castData = self.state.activeCasts[self.state.lastCastGUID]
    if not castData then return false end

    -- Check if the effect disappeared within our cast window
    local timeSinceCast = GetTime() - castData.timestamp
    -- Effect must be consumed within 0.1s of cast completion
    if timeSinceCast > 0.1 then return false end

    -- Check if this spell is known to consume this effect
    local spellEffects = self.db.global["spellEffects." .. spellID]
    return spellEffects and spellEffects.consumes and spellEffects.consumes[effectID]
end

--- Helper function to compare aura states and detect changes
function SpellLearnerStateManager:CompareAuraStates(preAuras, postAuras, auraType, unitType)
    local changes = {
        gained = {},
        lost = {}
    }

    -- Track gained/refreshed auras
    for spellId, postAura in pairs(postAuras) do
        local preAura = preAuras[spellId]

        -- Calculate timing info if the aura existed before
        local oldTimeLeft, newTimeLeft, timeDiff = 0, 0, 0
        if preAura then
            oldTimeLeft = preAura.expirationTime > 0 and (preAura.expirationTime - GetTime()) or 0
            newTimeLeft = postAura.expirationTime > 0 and (postAura.expirationTime - GetTime()) or 0
            timeDiff = newTimeLeft - oldTimeLeft
        end

        -- Only consider it a refresh if the duration increased significantly
        local isRefresh = preAura and timeDiff >= CONSTANTS.MIN_REFRESH_THRESHOLD

        -- Debug output for comparison
        --if preAura then
        --if self.debug then self:Debug("|cFF00FFFF[%s] Comparing %s: %s (ID: %d)|r", --    unitType, auraType, postAura.name, spellId) end
        --if self.debug then self:Debug("  Old Time Left: %.1f, New Time Left: %.1f, Difference: %.1f%s|r", --    oldTimeLeft, --    newTimeLeft, --    timeDiff, --    isRefresh and " (REFRESH)" or " (NO REFRESH)") end
        --end

        -- Only store if it's actually new or refreshed
        if not preAura or isRefresh then
            changes.gained[spellId] = {
                name = postAura.name,
                duration = postAura.duration,
                expirationTime = postAura.expirationTime,
                count = postAura.count or 1,
                isRefresh = isRefresh,
                -- Include refresh-specific info if it is a refresh
                oldTimeLeft = isRefresh and oldTimeLeft or nil,
                newTimeLeft = isRefresh and newTimeLeft or nil,
                timeDiff = isRefresh and timeDiff or nil,
                oldDuration = isRefresh and preAura.duration or nil,
                oldExpirationTime = isRefresh and preAura.expirationTime or nil
            }

            -- Debug output for actual changes
            --if isRefresh then
            --if self.debug then self:Debug("|cFF00FFFF[%s] Refreshed %s: %s (ID: %d) - Extended by %.1f seconds (%.1f -> %.1f)|r", --    unitType, auraType, postAura.name, spellId, timeDiff, oldTimeLeft, newTimeLeft) end
            --else
            --if self.debug then self:Debug("|cFF00FFFF[%s] New %s: %s (ID: %d) - Duration: %.1f|r", --    unitType, auraType, postAura.name, spellId, postAura.duration or 0) end
            --end
        end
    end

    -- Track lost auras
    for spellId, preAura in pairs(preAuras) do
        if not postAuras[spellId] then
            changes.lost[spellId] = {
                name = preAura.name,
                remainingDuration = preAura.expirationTime > 0 and (preAura.expirationTime - GetTime()) or 0
            }

            --if self.debug then self:Debug("|cFF00FFFF[%s] Lost %s: %s (ID: %d)|r", --    unitType, auraType, preAura.name, spellId) end
        end
    end

    return changes
end

-- Enhance CompareCastStates with improved rune detection
function SpellLearnerStateManager:CompareCastStates(preState, postState, spellID)
    -- Check if module is enabled
    if not self.db.char.enabled then
        return
    end

    if not preState or not postState then
        self:Debug("|cFFFF0000Cannot compare states - missing pre or post state|r")
        return
    end
local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local stateChanges = {
        timestamp = GetTime(),
        spellID = spellID,
        spellName = spellInfo and spellInfo.name or "Unknown",
        resources = {
            power = nil,    -- Will be set if there's a change
            secondary = nil -- Will be set if there's a change
        },
        eclipse = {
            phase = nil,       -- Will be set if phase changed
            solarEnergy = nil, -- Will be set if solar energy changed
            lunarEnergy = nil, -- Will be set if lunar energy changed
            direction = nil    -- Will be set if direction changed
        },
        runes = {
            spent = {},
            converted = {},
            cooldownChanged = {}
        },
        buffs = {
            player = {},
            target = {}
        },
        debuffs = {
            player = {},
            target = {}
        },
        activePlayerBuffs = {},   -- Player-sourced buffs
        activePlayerAllBuffs = {} -- All active buffs on player
    }

    -- Compare resources
    local powerDelta = postState.resources.power.current - preState.resources.power.current
    if powerDelta ~= 0 then
        stateChanges.resources.power = {
            type = preState.resources.power.type,
            oldValue = preState.resources.power.current,
            newValue = postState.resources.power.current,
            delta = powerDelta,
            powerType = preState.resources.power.type
        }
    end

    local secondaryDelta = postState.resources.secondary.current - preState.resources.secondary.current
    if secondaryDelta ~= 0 then
        stateChanges.resources.secondary = {
            type = preState.resources.secondary.type,
            oldValue = preState.resources.secondary.current,
            newValue = postState.resources.secondary.current,
            delta = secondaryDelta,
            powerType = preState.resources.secondary.type
        }
    end

    -- Compare eclipse state if player is a druid
    local class = NAG.CLASS_FILENAME
    if class == "DRUID" then
        -- Get current eclipse phase
        local currentPhase = NAG:DruidCurrentEclipsePhase()
        local prePhase = NAG:DruidCurrentEclipsePhase(preState)

        -- Always store the current phase
        stateChanges.eclipse.phase = {
            oldPhase = prePhase,
            newPhase = currentPhase,
            changed = currentPhase ~= prePhase
        }

        -- Get current solar and lunar energy
        local currentSolar = UnitPower("player", Enum.PowerType.Balance)
        local currentLunar = UnitPower("player", Enum.PowerType.Balance)
        local preSolar = preState.resources.balance and preState.resources.balance.solar or 0
        local preLunar = preState.resources.balance and preState.resources.balance.lunar or 0

        -- Always store solar energy values
        stateChanges.eclipse.solarEnergy = {
            oldValue = preSolar,
            newValue = currentSolar,
            delta = currentSolar - preSolar,
            changed = currentSolar ~= preSolar
        }

        -- Always store lunar energy values
        stateChanges.eclipse.lunarEnergy = {
            oldValue = preLunar,
            newValue = currentLunar,
            delta = currentLunar - preLunar,
            changed = currentLunar ~= preLunar
        }

        -- Determine eclipse direction
        local preDirection = preState.resources.balance and preState.resources.balance.direction or "none"
        local currentDirection = "none"
        if currentSolar > preSolar then
            currentDirection = "solar"
        elseif currentLunar > preLunar then
            currentDirection = "lunar"
        end

        -- Always store direction values
        stateChanges.eclipse.direction = {
            oldDirection = preDirection,
            newDirection = currentDirection,
            changed = currentDirection ~= preDirection
        }
    end

    -- Compare player buffs and track active player-sourced buffs
    stateChanges.buffs.player = self:CompareAuraStates(
        preState.buffs.player or {},
        postState.buffs.player or {},
        "Buff",
        "PLAYER"
    )

    -- Store active player-sourced buffs from post-cast state
    for spellId, buff in pairs(postState.buffs.player) do
        -- Check if the buff source is the player
        if buff.sourceUnit == "player" then
            stateChanges.activePlayerBuffs[spellId] = {
                name = buff.name,
                count = buff.count or 1,
                duration = buff.duration or 0,
                expirationTime = buff.expirationTime or 0
            }
        end
    end

    -- Store all active buffs on player
    for spellId, buff in pairs(postState.buffs.player) do
        stateChanges.activePlayerAllBuffs[spellId] = {
            name = buff.name,
            count = buff.count or 1,
            duration = buff.duration or 0,
            expirationTime = buff.expirationTime or 0,
            sourceUnit = buff.sourceUnit
        }
    end

    -- Compare player debuffs
    stateChanges.debuffs.player = self:CompareAuraStates(
        preState.debuffs.player or {},
        postState.debuffs.player or {},
        "Debuff",
        "PLAYER"
    )

    -- Compare target buffs and debuffs if target exists
    if UnitExists("target") then
        stateChanges.buffs.target = self:CompareAuraStates(
            preState.buffs.target or {},
            postState.buffs.target or {},
            "Buff",
            "TARGET"
        )

        stateChanges.debuffs.target = self:CompareAuraStates(
            preState.debuffs.target or {},
            postState.debuffs.target or {},
            "Debuff",
            "TARGET"
        )
    end

    -- ENHANCED RUNE DETECTION: Compare Death Knight Runes if they exist
    if preState.runes and postState.runes then
        -- Debug header for rune comparison
        self:Debug("\n|cFF00FFFF===== RUNE COMPARISON FOR SPELL " .. tostring(stateChanges.spellName) .. " =====|r")

        -- Calculate time between snapshots for accurate cooldown comparison
        local timeDelta = postState.timestamp - preState.timestamp
        if self.debug then self:Debug("|cFF00FFFFTime between snapshots: %.3f seconds|r", timeDelta) end

        -- Track how many of each rune type were used
        local runeTypesUsed = {
            [CONSTANTS.RUNE_TYPE.BLOOD] = 0,
            [CONSTANTS.RUNE_TYPE.FROST] = 0,
            [CONSTANTS.RUNE_TYPE.UNHOLY] = 0,
            [CONSTANTS.RUNE_TYPE.DEATH] = 0
        }

        for i = 1, CONSTANTS.MAX_RUNES do
            local preRune = preState.runes[i]
            local postRune = postState.runes[i]

            if preRune and postRune then
                -- Debug each rune separately
                if self.debug then self:Debug("|cFF00FFFFRune %d: Type: %s|r", i, self:GetRuneTypeName(preRune.type)) end
                if self.debug then
                    self:Debug("  Pre: Ready=%s, TimeLeft=%.2f", tostring(preRune.ready), preRune
                        .timeLeft)
                end
                if self.debug then
                    self:Debug("  Post: Ready=%s, TimeLeft=%.2f", tostring(postRune.ready),
                        postRune.timeLeft)
                end

                -- Calculate expected time left after time delta
                local expectedTimeLeft = math.max(0, preRune.timeLeft - timeDelta)
                local timeLeftDelta = postRune.timeLeft - expectedTimeLeft
                if self.debug then
                    self:Debug("  Expected TimeLeft: %.2f, Actual: %.2f, Delta: %.2f", expectedTimeLeft,
                        postRune.timeLeft, timeLeftDelta)
                end

                -- IMPROVED DETECTION LOGIC:
                -- A rune was used if ANY of these conditions are true:
                -- 1. It was ready and now it's not
                -- 2. Its cooldown is significantly longer than expected after time adjustment
                -- 3. It was about to refresh and now has a much longer cooldown

                local wasUsed = false
                local detectionMethod = ""

                -- 1. Ready state changed
                if preRune.ready and not postRune.ready then
                    wasUsed = true
                    detectionMethod = "ready state changed"
                    -- 2. Cooldown increased significantly
                elseif timeLeftDelta > 1.0 then
                    wasUsed = true
                    detectionMethod = "cooldown increased by " .. tostring(format("%.2f", timeLeftDelta)) .. "s"
                    -- 3. Was about to refresh but now has a long cooldown
                elseif preRune.willRefresh and postRune.timeLeft > 3.0 then
                    wasUsed = true
                    detectionMethod = "refresh interrupted, new CD: " ..
                        tostring(format("%.2f", postRune.timeLeft)) .. "s"
                end

                if wasUsed then
                    if self.debug then
                        self:Debug("|cFF00FF00RUNE USED: Rune %d (Type: %s) - %s|r", i,
                            self:GetRuneTypeName(preRune.type), detectionMethod)
                    end

                    -- Add to state changes
                    stateChanges.runes.spent[i] = {
                        type = preRune.type,
                        newCooldown = postRune.timeLeft,
                        wasRefreshing = preRune.willRefresh,
                        fromReady = preRune.ready,
                        detectionMethod = detectionMethod
                    }

                    -- Count this rune type
                    runeTypesUsed[preRune.type] = runeTypesUsed[preRune.type] + 1

                    -- Record this rune cost
                    self:RecordRuneCost(spellID, i, preRune.type)
                else
                    if self.debug then self:Debug("|cFFFFFFFFRune %d was NOT used|r", i) end
                end

                -- Check for type conversions
                if preRune.type ~= postRune.type then
                    if self.debug then
                        self:Debug("|cFF00FFFFRUNE CONVERTED: Rune %d changed from %s to %s|r", i,
                            self:GetRuneTypeName(preRune.type), self:GetRuneTypeName(postRune.type))
                    end

                    stateChanges.runes.converted[i] = {
                        oldType = preRune.type,
                        newType = postRune.type
                    }
                end
            end
        end

        -- Summarize rune usage by type
        self:Debug("|cFF00FFFF===== RUNE USAGE SUMMARY =====|r")
        for runeType, count in pairs(runeTypesUsed) do
            if count > 0 then
                if self.debug then self:Debug("|cFF00FF00%s Runes Used: %d|r", self:GetRuneTypeName(runeType), count) end
            end
        end

        -- If no runes were detected but this is a Death Knight, do one more check
        local totalRunesUsed = runeTypesUsed[CONSTANTS.RUNE_TYPE.BLOOD] +
            runeTypesUsed[CONSTANTS.RUNE_TYPE.FROST] +
            runeTypesUsed[CONSTANTS.RUNE_TYPE.UNHOLY] +
            runeTypesUsed[CONSTANTS.RUNE_TYPE.DEATH]

        if class == "DEATHKNIGHT" and totalRunesUsed == 0 then
            self:Debug("|cFFFF0000WARNING: No runes detected for Death Knight spell! Performing additional checks...|r")

            -- Check if any runes were on low cooldown in pre-state but high cooldown in post-state
            for i = 1, CONSTANTS.MAX_RUNES do
                local preRune = preState.runes[i]
                local postRune = postState.runes[i]

                if preRune and postRune and preRune.timeLeft < 2.0 and postRune.timeLeft > 5.0 then
                    if self.debug then
                        self:Debug(
                            "|cFFFF9900POTENTIAL RUNE USE MISSED: Rune %d (Type: %s) - TimeLeft %.2f -> %.2f|r", i,
                            self:GetRuneTypeName(preRune.type), preRune.timeLeft, postRune.timeLeft)
                    end

                    -- Add as a potential spent rune since we might have missed it in normal detection
                    stateChanges.runes.spent[i] = {
                        type = preRune.type,
                        newCooldown = postRune.timeLeft,
                        wasRefreshing = false,
                        fromReady = false,
                        detectionMethod = "fallback detection"
                    }

                    -- Record this rune cost with lower confidence
                    self:RecordRuneCost(spellID, i, preRune.type, 0.5) -- 0.5 = lower confidence
                end
            end
        end

        self:Debug("|cFF00FFFF===== END RUNE COMPARISON =====|r")
    end

    -- Print structured state changes
    self:Debug("\n|cFFFFFF00========== STRUCTURED STATE CHANGES ==========|r")
    if self.debug then self:Debug("Spell: %s (ID: %d)", stateChanges.spellName, stateChanges.spellID) end

    -- Print resource changes
    if stateChanges.resources.power or stateChanges.resources.secondary then
        self:Debug("\nResources:")
        if stateChanges.resources.power then
            local powerTypeName = _G[format("POWER_TYPE_%d", stateChanges.resources.power.powerType)] or "Power"
            if self.debug then
                self:Debug("  %s: %d -> %d (Δ%d)", powerTypeName, stateChanges.resources.power.oldValue,
                    stateChanges.resources.power.newValue, stateChanges.resources.power.delta)
            end
        end
        if stateChanges.resources.secondary then
            local secondaryTypeName = _G[format("POWER_TYPE_%d", stateChanges.resources.secondary.powerType)] or
                "Secondary"
            if self.debug then
                self:Debug("  %s: %d -> %d (Δ%d)", secondaryTypeName,
                    stateChanges.resources.secondary.oldValue, stateChanges.resources.secondary.newValue,
                    stateChanges.resources.secondary.delta)
            end
        end
    end

    -- Print newly gained buffs section
    if stateChanges.buffs and stateChanges.buffs.player and stateChanges.buffs.player.gained then
        self:Debug("\nGained Buffs:")
        local gainedCount = 0
        for spellId, buff in pairs(stateChanges.buffs.player.gained) do
            gainedCount = gainedCount + 1
            local timeLeft = buff.expirationTime > 0 and (buff.expirationTime - GetTime()) or 0
            if self.debug then
                self:Debug("  %s (ID: %d) - Stacks: %d, Duration: %.1fs", buff.name, spellId,
                    buff.count or 1, timeLeft)
            end
        end
        if gainedCount == 0 then
            self:Debug("  No buffs gained")
        end
    end

    -- Print eclipse information if player is a druid
    if class == "DRUID" then
        self:Debug("\nEclipse State:")
        -- Print phase
        if self.debug then
            self:Debug("  Phase: %s -> %s%s", stateChanges.eclipse.phase.oldPhase,
                stateChanges.eclipse.phase.newPhase, stateChanges.eclipse.phase.changed and " (CHANGED)" or "")
        end

        -- Print solar energy
        if self.debug then
            self:Debug("  Solar Energy: %d -> %d (Δ%d)%s", stateChanges.eclipse.solarEnergy.oldValue,
                stateChanges.eclipse.solarEnergy.newValue, stateChanges.eclipse.solarEnergy.delta,
                stateChanges.eclipse.solarEnergy.changed and " (CHANGED)" or "")
        end

        -- Print lunar energy
        if self.debug then
            self:Debug("  Lunar Energy: %d -> %d (Δ%d)%s", stateChanges.eclipse.lunarEnergy.oldValue,
                stateChanges.eclipse.lunarEnergy.newValue, stateChanges.eclipse.lunarEnergy.delta,
                stateChanges.eclipse.lunarEnergy.changed and " (CHANGED)" or "")
        end

        -- Print direction
        if self.debug then
            self:Debug("  Direction: %s -> %s%s", stateChanges.eclipse.direction.oldDirection,
                stateChanges.eclipse.direction.newDirection,
                stateChanges.eclipse.direction.changed and " (CHANGED)" or "")
        end
    end

    -- Print active player-sourced buffs
    if next(stateChanges.activePlayerBuffs) then
        self:Debug("\nActive Player-Sourced Buffs:")
        for spellId, buff in pairs(stateChanges.activePlayerBuffs) do
            local timeLeft = buff.expirationTime > 0 and (buff.expirationTime - GetTime()) or 0
            if self.debug then
                self:Debug("  %s (ID: %d) - Stacks: %d, Time Left: %.1fs", buff.name, spellId, buff.count,
                    timeLeft)
            end
        end
    end

    -- Print all active buffs on player
    self:Debug("\nActive Player Buffs:")
    local buffCount = 0
    for spellId, buff in pairs(stateChanges.activePlayerAllBuffs) do
        buffCount = buffCount + 1
        local timeLeft = buff.expirationTime > 0 and (buff.expirationTime - GetTime()) or 0
        local sourceInfo = buff.sourceUnit and format(" (Source: %s)", buff.sourceUnit) or ""
        if self.debug then
            self:Debug("  %s (ID: %d) - Stacks: %d, Time Left: %.1fs%s", buff.name, spellId,
                buff.count or 1, timeLeft, sourceInfo)
        end
    end
    if buffCount == 0 then
        self:Debug("  No active buffs")
    end

    -- Print target debuffs section
    if UnitExists("target") then
        self:Debug("\nTarget Debuffs:")
        local debuffCount = 0
        if stateChanges.debuffs and stateChanges.debuffs.target then
            for spellId, debuff in pairs(stateChanges.debuffs.target.gained or {}) do
                debuffCount = debuffCount + 1
                local timeLeft = debuff.expirationTime > 0 and (debuff.expirationTime - GetTime()) or 0
                if self.debug then
                    self:Debug("  %s (ID: %d) - Stacks: %d, Duration: %.1fs", debuff.name, spellId,
                        debuff.count or 1, timeLeft)
                end
            end
        end
        if debuffCount == 0 then
            self:Debug("  No debuffs applied")
        end
    end

    -- Print rune changes in structured output
    if next(stateChanges.runes.spent) or next(stateChanges.runes.converted) then
        self:Debug("\nRune Changes:")
        if next(stateChanges.runes.spent) then
            self:Debug("  Spent Runes:")
            for runeId, data in pairs(stateChanges.runes.spent) do
                local typeStr = self:GetRuneTypeName(data.type)
                if self.debug then
                    self:Debug("    Rune %d (%s) - Cooldown: %.1fs, Method: %s", runeId, typeStr,
                        data.newCooldown, data.detectionMethod or "standard")
                end
            end
        end
        if next(stateChanges.runes.converted) then
            self:Debug("  Converted Runes:")
            for runeId, data in pairs(stateChanges.runes.converted) do
                if self.debug then
                    self:Debug("    Rune %d: %s -> %s", runeId, self:GetRuneTypeName(data.oldType),
                        self:GetRuneTypeName(data.newType))
                end
            end
        end
    end

    self:Debug("|cFFFFFF00==============================================|r")

    -- Store the state changes for analysis
    self:StoreStateChanges(spellID, stateChanges)

    -- 🔍 SPELL LEARNING PIPELINE: Send message to PredictionManager
    -- Only trigger if player is in combat and within 12 yards of target
    if self:ShouldTriggerSpellLearning() then
        self:Debug("|cFF00FF00[SPELL LEARNING] Triggering NAG_SPELL_LEARNED for spell " .. spellID .. "|r")

        -- Get the pre and post states from the active cast data
        local castData = self.state.activeCasts[self.state.lastCastGUID]
        if castData and castData.preState and castData.postState then
            -- Send the message to PredictionManager
            NAG:SendMessage("NAG_SPELL_LEARNED", spellID, castData.preState, castData.postState)
            self:Trace("|cFF00FF00[SPELL LEARNING] Message sent successfully|r")
        else
            self:Trace("|cFFFF0000[SPELL LEARNING] Missing pre/post state data for spell " .. spellID .. "|r")
        end
    else
        self:Trace("|cFFFFFF00[SPELL LEARNING] Skipping - conditions not met for spell " .. spellID .. "|r")
    end

    return stateChanges
end

--- Handle target changes (migrated from StateManager)
function SpellLearnerStateManager:PLAYER_TARGET_CHANGED(event, newGuid)
    local currentTargetGUID = newGuid or UnitGUID("target")
    if currentTargetGUID ~= self.auraCache.lastTargetGUID then
        if self.debug then
            self:Debug("Target changed from %s to %s", self.auraCache.lastTargetGUID or "none",
                currentTargetGUID or "none")
        end

        -- Clear target cache
        wipe(self.auraCache.target)
        self.auraCache.lastTargetGUID = currentTargetGUID

        -- Update cache for new target if it exists
        if UnitExists("target") then
            self:UpdateAuraCache("target")
        end
    end
end

--- Update the aura cache for a unit
--- @param unit string The unit to update the cache for
function SpellLearnerStateManager:UpdateAuraCache(unit)
    if not unit or (unit ~= "player" and unit ~= "target") then
        self:Debug("Invalid unit for aura cache update: " .. tostring(unit))
        return
    end

    -- Ensure unit exists
    if not UnitExists(unit) then
        self:Debug("Unit does not exist: " .. tostring(unit))
        return
    end

    local cache = self.auraCache[unit]
    if cache then
        wipe(cache)
    else
        -- Initialize cache for this unit if it doesn't exist
        self.auraCache[unit] = {}
        cache = self.auraCache[unit]
    end

    -- Helper function to scan auras with a specific filter
    local function scanAuras(filter)
        local i = 1
        local foundAuras = {}
        while true do
            --TODO: Change to NAG:UnitAura?
            local spellTable = UnitAura(unit, i, filter)
            if not spellTable then break end

            -- Only store if we have a valid spell ID
            if spellTable.spellId and spellTable.spellId > 0 then
                cache[spellTable.spellId] = {
                    name = spellTable.name,
                    count = (spellTable.applications or spellTable.count) or 1,
                    debuffType = spellTable.dispelName or spellTable.dispelType,
                    duration = spellTable.duration or 0,
                    expirationTime = spellTable.expirationTime or 0,
                    sourceUnit = spellTable.sourceUnit or spellTable.unitCaster,
                    isStealable = spellTable.isStealable and 1 or 0,
                    shouldConsolidate = spellTable.shouldConsolidate and 1 or 0,
                    isHelpful = filter == "HELPFUL",
                    lastUpdate = GetTime()
                }

                -- Store for debug output
                foundAuras[spellTable.spellId] = spellTable.name
            end

            i = i + 1
        end

        -- Debug output for important auras
        if unit == "player" and filter == "HELPFUL" and NAG:IsDevModeEnabled() then
            -- Specifically check for Blood Shield
            if cache[77535] then
                if self.debug then self:Debug("✅ UpdateAuraCache: Found Blood Shield (77535) in player buffs") end
            end

            -- if self.debug then self:Debug("UpdateAuraCache: %s has %d %s auras", unit, i - 1, filter:lower()) end
            for spellId, name in pairs(foundAuras) do
                if self.debug then self:Debug("  - %s (ID: %d)", name, spellId) end
            end
        end

        return i - 1
    end

    -- Scan both beneficial and harmful auras
    local buffCount = scanAuras("HELPFUL")
    local debuffCount = scanAuras("HARMFUL")

    -- Update target GUID if needed
    if unit == "target" then
        self.auraCache.lastTargetGUID = UnitGUID("target")
    end

    if NAG:IsDevModeEnabled() then
        if self.debug then
            self:Debug("Updated aura cache for %s with %d buffs and %d debuffs", unit, buffCount,
                debuffCount)
        end
    end
end

-- Add new helper function to manage tracked spells list
function SpellLearnerStateManager:UpdateTrackedNextSpells(spellID)
    if not spellID then return end

    -- Check if spell is already tracked
    for _, trackedID in pairs(self.state.trackedNextSpells) do
        if trackedID == spellID then
            return -- Already tracking this spell
        end
    end

    -- If we have less than 2 spells, just add it
    if self.state.trackedNextSpellsCount < 2 then
        self.state.trackedNextSpellsCount = self.state.trackedNextSpellsCount + 1
        self.state.trackedNextSpells[self.state.trackedNextSpellsCount] = spellID
        if self.debug then
            self:Debug("Added spell ID %d to tracked spells (slot %d)", spellID,
                self.state.trackedNextSpellsCount)
        end
    else
        -- Shift existing spells and add new one
        self.state.trackedNextSpells[1] = self.state.trackedNextSpells[2]
        self.state.trackedNextSpells[2] = spellID
        if self.debug then self:Debug("Updated tracked spells: [%d, %d]", self.state.trackedNextSpells[1], spellID) end
    end
end

-- Add new helper function to check if a spell is being tracked
function SpellLearnerStateManager:IsSpellTracked(spellID)
    if not spellID then return false end

    for _, trackedID in pairs(self.state.trackedNextSpells) do
        if trackedID == spellID then
            return true
        end
    end
    return false
end

-- Add new function to clear spell changes data
function SpellLearnerStateManager:ClearSpellChanges()
    local spellChanges = self.db.char.spellChanges
    if spellChanges then
        wipe(spellChanges)
        self.db.char.spellChanges = spellChanges
        self:Debug("|cFF00FF00Successfully cleared all spell changes data|r")
    else
        self:Debug("|cFFFF0000No spell changes data to clear|r")
    end
end

--- Helper function to determine if a state change was natural or spell-caused
function SpellLearnerStateManager:IsNaturalChange(preState, postState, changeType, changeData)
    local currentTime = GetTime()

    -- For buffs/debuffs
    if changeType == "buff" or changeType == "debuff" then
        -- If the buff was about to expire (between 0.2s and 0.5s remaining), consider it natural
        if changeData.oldExpirationTime and
            (changeData.oldExpirationTime - preState.timestamp) <= CONSTANTS.NATURAL_CHANGE_WINDOW and
            (changeData.oldExpirationTime - preState.timestamp) >= CONSTANTS.MIN_NATURAL_CHANGE_WINDOW then
            return true
        end

        -- If the buff was refreshed with a significant duration increase, consider it spell-caused
        if changeData.newExpirationTime and changeData.oldExpirationTime and
            (changeData.newExpirationTime - changeData.oldExpirationTime) > CONSTANTS.MIN_REFRESH_THRESHOLD then
            return false
        end
    end

    -- For runes
    if changeType == "rune" then
        -- If the rune was about to come off cooldown (between 0.2s and 0.5s remaining), consider it natural
        if changeData.oldTimeLeft and
            changeData.oldTimeLeft <= CONSTANTS.NATURAL_CHANGE_WINDOW and
            changeData.oldTimeLeft >= CONSTANTS.MIN_NATURAL_CHANGE_WINDOW then
            return true
        end

        -- If the rune was spent and another one came off cooldown, consider it spell-caused
        if changeData.spent and changeData.newTimeLeft and changeData.newTimeLeft > 0 then
            return false
        end
    end

    -- For resources
    if changeType == "resource" then
        -- If the resource was at max and regenerated, consider it natural
        if changeData.oldValue and changeData.oldValue >= changeData.maxValue then
            return true
        end

        -- If the resource change happened between 0.2s and 0.5s of the state capture, consider it natural
        if changeData.timeDiff and
            changeData.timeDiff <= CONSTANTS.NATURAL_CHANGE_WINDOW and
            changeData.timeDiff >= CONSTANTS.MIN_NATURAL_CHANGE_WINDOW then
            return true
        end

        -- If the resource was consumed, consider it spell-caused
        if changeData.delta and changeData.delta < 0 then
            return false
        end
    end

    -- Default to considering it spell-caused if we can't determine
    return false
end

-- Add helper function for rune type names
function SpellLearnerStateManager:GetRuneTypeName(runeType)
    return runeType == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
        or runeType == CONSTANTS.RUNE_TYPE.FROST and "Frost"
        or runeType == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
        or runeType == CONSTANTS.RUNE_TYPE.DEATH and "Death"
        or "Unknown"
end

--- Debug function to check buff tracking status
function SpellLearnerStateManager:DebugBuffTracking()
    self:Debug("=== BUFF TRACKING DEBUG ===")

    -- 1. Check if aura cache is initialized
    if not self.auraCache then
        self:Debug("❌ CRITICAL: auraCache is not initialized!")
        return
    end

    if not self.auraCache.player then
        self:Debug("❌ CRITICAL: auraCache.player is not initialized!")
        return
    end

    self:Debug("✅ auraCache is properly initialized")

    -- 2. Force refresh aura cache and show contents
    self:Debug("Forcing aura cache refresh...")
    self:UpdateAuraCache("player")

    -- 3. Show current player buffs in cache
    local cacheBuffCount = 0
    self:Debug("Current player buffs in aura cache:")
    for spellId, auraInfo in pairs(self.auraCache.player) do
        if auraInfo.isHelpful then
            cacheBuffCount = cacheBuffCount + 1
            local timeLeft = auraInfo.expirationTime > 0 and (auraInfo.expirationTime - GetTime()) or -1
            if self.debug then
                self:Debug("  - %s (ID: %d) - Duration: %.1f, Time Left: %.1f, Source: %s", auraInfo.name,
                    spellId, auraInfo.duration or 0, timeLeft, auraInfo.sourceUnit or "unknown")
            end
        end
    end

    if cacheBuffCount == 0 then
        self:Debug("❌ No player buffs found in aura cache")
    else
        if self.debug then self:Debug("✅ Found %d player buffs in aura cache", cacheBuffCount) end
    end

    -- 4. Specifically check for Blood Shield
    if self.auraCache.player[77535] then
        local bloodShield = self.auraCache.player[77535]
        if self.debug then
            self:Debug("✅ Blood Shield (77535) found: %s - Count: %d, Duration: %.1f", bloodShield.name,
                bloodShield.count or 1, bloodShield.duration or 0)
        end
    else
        self:Debug("❌ Blood Shield (77535) not found in aura cache")
    end

    -- 5. Test state capture
    self:Debug("Testing state capture...")
    local testState = self:CaptureCurrentState()

    local stateBuffCount = TableUtils.Size(testState.buffs.player)
    if stateBuffCount == 0 then
        self:Debug("❌ No player buffs captured in test state")
    else
        if self.debug then self:Debug("✅ Captured %d player buffs in test state", stateBuffCount) end
    end

    -- Clean up test state
    self:ReleaseStateObject(testState)

    self:Debug("=== BUFF TRACKING DEBUG COMPLETE ===")
end

--- Initialize improved spell cost and effect tracking
function SpellLearnerStateManager:InitializeImprovedTracking()
    self:Debug("Initializing improved spell cost and effect tracking")

    -- Create storage tables if they don't exist - use character-specific storage
    if not self.db.char.spellCosts then self.db.char.spellCosts = {} end
    if not self.db.char.runeCosts then self.db.char.runeCosts = {} end
    if not self.db.char.spellEffects then self.db.char.spellEffects = {} end

    -- Reset the active cast state
    self.state.activeCast = nil

    -- No need to re-register UNIT_POWER_UPDATE as it's already in eventHandlers table

    -- Death Knight specific rune tracking setup
    local class = NAG.CLASS_FILENAME
    if class == "DEATHKNIGHT" then
        -- ZERO-BOILERPLATE: RUNE_POWER_UPDATE is automatically registered via declarative patterns
        self:Debug("RUNE_POWER_UPDATE registered via declarative patterns for Death Knight rune tracking")
    end

    -- Replace the existing combat log handler with improved functionality
    self:Debug("Enhanced combat log tracking enabled")
end

-- Add RUNE_POWER_UPDATE handler
function SpellLearnerStateManager:RUNE_POWER_UPDATE(event, runeIndex)
    if not self.state.activeCast then return end
    local now = GetTime()
    local elapsed = now - (self.state.activeCast.startTime or 0)
    if elapsed > CONSTANTS.RUNE_DETECTION_WINDOW then return end

    local preCastRune = self.state.activeCast.runes and self.state.activeCast.runes[runeIndex]
    if not preCastRune then return end

    -- de-dupe per rune index
    if self.state.activeCast.recorded and self.state.activeCast.recorded.rune[runeIndex] then return end

    local runeReady = select(3, GetRuneCooldown(runeIndex))
    if preCastRune.ready and not (runeReady == 1) then
        local runeType = GetRuneType(runeIndex)
        self:RecordRuneCost(self.state.activeCast.spellID, runeIndex, runeType)
        if self.state.activeCast.recorded then
            self.state.activeCast.recorded.rune[runeIndex] = true
        end
    end
end

-- Record resource cost with confidence tracking
--- Track observation buffer occupancy for freeze diagnostics.
--- @param bucketName string
--- @param size number
function SpellLearnerStateManager:TrackObservationBuffer(bucketName, size)
    self._observationPerf = self._observationPerf or {
        maxSeen = 0,
        samples = 0,
        lastReportAt = 0
    }
    local perf = self._observationPerf
    perf.samples = (perf.samples or 0) + 1
    if size > (perf.maxSeen or 0) then
        perf.maxSeen = size
    end

    local now = GetTime()
    if (now - (perf.lastReportAt or 0)) >= 60 then
        self:Debug(
            "Observation buffers: maxSeen=%d latestBucket=%s latestSize=%d maxLimit=%d samples=%d",
            perf.maxSeen or 0,
            tostring(bucketName),
            size or 0,
            CONSTANTS.MAX_OBSERVATIONS,
            perf.samples or 0
        )
        perf.samples = 0
        perf.maxSeen = size
        perf.lastReportAt = now
    end
end

function SpellLearnerStateManager:RecordResourceCost(spellID, powerType, amount)
    -- Get spec-specific storage
    local spellCosts = self:GetSpecDataTable("spellCosts")

    -- Initialize storage if needed
    if not spellCosts[spellID] then spellCosts[spellID] = {} end
    if not spellCosts[spellID][powerType] then
        spellCosts[spellID][powerType] = {
            observations = {},
            confidence = 0,
            consistentValue = nil
        }
    end

    -- Store detailed info about this observation
    local newObservation = {
        timestamp = GetTime(),
        powerType = powerType,
        amount = amount
    }

    -- Add to our history of observations
    local powerData = spellCosts[spellID][powerType]
    table.insert(powerData.observations, newObservation)

    -- Limit history size
    if #powerData.observations > CONSTANTS.MAX_OBSERVATIONS then
        table.remove(powerData.observations, 1)
    end
    self:TrackObservationBuffer("spellCosts", #powerData.observations)

    -- Update confidence and consistent value
    self:UpdateResourceConfidence(spellID, powerType)

    -- Debug output
    if self.debug then
        self:Debug("Recorded resource cost for spell %d, power %s: %d (spec: %d)", spellID, powerType,
            amount, self:GetCurrentSpecIndex())
    end
end

-- Update confidence based on consistency of observations
function SpellLearnerStateManager:UpdateResourceConfidence(spellID, powerType)
    local spellCosts = self:GetSpecDataTable("spellCosts")
    if not spellCosts[spellID] or not spellCosts[spellID][powerType] then return end

    local powerData = spellCosts[spellID][powerType]
    if not powerData or #powerData.observations < 3 then return end

    -- Count occurrences of each cost amount
    local costCounts = {}
    local totalObservations = #powerData.observations

    for _, observation in ipairs(powerData.observations) do
        costCounts[observation.amount] = (costCounts[observation.amount] or 0) + 1
    end

    -- Find the most common value
    local mostCommonValue = nil
    local highestCount = 0

    for value, count in pairs(costCounts) do
        if count > highestCount then
            mostCommonValue = value
            highestCount = count
        end
    end

    -- Calculate confidence as percentage of observations matching most common value
    local confidence = highestCount / totalObservations

    -- Update stored values
    powerData.confidence = confidence
    powerData.consistentValue = mostCommonValue

    if self.debug then
        self:Debug(
            "Updated cost confidence for spell %d, power %s: %.1f%% confident of %d cost (spec: %d)", spellID, powerType,
            confidence * 100, mostCommonValue, self:GetCurrentSpecIndex())
    end
end

-- Update the RecordRuneCost function to handle confidence levels
function SpellLearnerStateManager:RecordRuneCost(spellID, runeIndex, runeType, confidence)
    -- Default confidence to 1.0 if not specified
    confidence = confidence or 1.0

    -- Get spec-specific storage
    local runeCosts = self:GetSpecDataTable("runeCosts")

    -- Initialize storage
    if not runeCosts[spellID] then runeCosts[spellID] = {} end

    local newObservation = {
        timestamp = GetTime(),
        runeIndex = runeIndex,
        runeType = runeType,
        confidence = confidence
    }

    -- Add to history
    table.insert(runeCosts[spellID], newObservation)

    -- Enhanced debug output with proper parameter validation
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local spellName = spellInfo and spellInfo.name or "Unknown"
    local runeTypeName = self:GetRuneTypeName(runeType or 0)

    if self.debug then
        self:Debug(
            "|cFF00FF00RECORDING RUNE COST: Spell %d (%s) - Rune %d (Type: %s), Confidence: %.2f (spec: %d)|r", spellID,
            spellName, runeIndex or 0, runeTypeName, confidence, self:GetCurrentSpecIndex())
    end

    -- Limit history size
    if #runeCosts[spellID] > CONSTANTS.MAX_OBSERVATIONS then
        tremove(runeCosts[spellID], 1)
    end
    self:TrackObservationBuffer("runeCosts", #runeCosts[spellID])

    -- Calculate rune type distribution
    self:UpdateRuneConfidence(spellID)

    -- UPDATE: Add immediate logging to see if we're detecting
    if NAG.CLASS_FILENAME == "DEATHKNIGHT" then
        self:Debug("|cFF00FF00DEATH KNIGHT RUNE USAGE DETECTED AND RECORDED|r")
    end
end

-- Update UpdateRuneConfidence to consider confidence values
function SpellLearnerStateManager:UpdateRuneConfidence(spellID)
    local runeCosts = self:GetSpecDataTable("runeCosts")
    if not runeCosts or not runeCosts[spellID] then return end

    local observations = runeCosts[spellID]
    if #observations < 2 then return end

    -- Count rune types with confidence weighting
    local runeTypeCounts = {}
    local totalConfidence = 0

    for _, observation in ipairs(observations) do
        runeTypeCounts[observation.runeType] = (runeTypeCounts[observation.runeType] or 0) +
            (observation.confidence or 1.0)
        totalConfidence = totalConfidence + (observation.confidence or 1.0)
    end

    -- Calculate average rune consumption by type
    local runeProfile = {}
    for runeType, count in pairs(runeTypeCounts) do
        runeProfile[runeType] = {
            percentage = count / totalConfidence,
            count = count,
            rawCount = 0 -- Will count actual observations below
        }
    end

    -- Also count raw observations for reporting
    for _, observation in ipairs(observations) do
        if runeProfile[observation.runeType] then
            runeProfile[observation.runeType].rawCount = runeProfile[observation.runeType].rawCount + 1
        end
    end

    -- Log findings with enhanced output
    for runeType, profile in pairs(runeProfile) do
        -- Fix: Ensure all arguments are properly formatted and handle nil values
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local spellName = spellInfo and spellInfo.name or "Unknown"
        local runeTypeName = self:GetRuneTypeName(runeType or 0)
        local percentage = profile.percentage or 0
        local count = profile.count or 0
        local rawCount = profile.rawCount or 0

        -- Handle potential nil values and special characters in the debug message
        local safeMsg = "Rune usage for spell " .. tostring(spellID or 0) ..
            " (" .. tostring(spellName or "Unknown") .. ") - Type: " .. tostring(runeTypeName or "Unknown") ..
            ", Percentage: " .. tostring(string.format("%.1f", (percentage or 0) * 100)) ..
            "%, Weighted Count: " .. tostring(string.format("%.1f", count or 0)) ..
            ", Raw Count: " .. tostring(rawCount or 0) ..
            " (spec: " .. tostring(self:GetCurrentSpecIndex()) .. ")"
        self:Debug(safeMsg)
    end

    -- Store the rune profile in spec-specific storage
    local runeProfiles = self:GetSpecDataTable("runeProfiles")
    runeProfiles[spellID] = runeProfile

    -- Update rune usage summary in spec-specific database
    local runeUsageSummary = self:GetSpecDataTable("runeUsageSummary")
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local summary = {
        spellName = spellInfo and spellInfo.name or "Unknown",
        spellID = spellID,
        lastUpdated = GetTime(),
        observations = #observations,
        runeTypes = {}
    }

    for runeType, profile in pairs(runeProfile) do
        summary.runeTypes[runeType] = {
            typeName = self:GetRuneTypeName(runeType),
            percentage = profile.percentage,
            count = profile.count,
            rawCount = profile.rawCount
        }
    end

    runeUsageSummary[spellID] = summary
end

-- Record buff applications
function SpellLearnerStateManager:RecordBuffApplication(sourceSpellID, buffSpellID, buffType, targetGUID, effectType)
    -- Get spec-specific storage
    local spellEffects = self:GetSpecDataTable("spellEffects")

    -- Initialize storage
    if not spellEffects[sourceSpellID] then spellEffects[sourceSpellID] = {} end

    local newObservation = {
        timestamp = GetTime(),
        buffSpellID = buffSpellID,
        buffType = buffType,
        targetGUID = targetGUID
    }

    -- Store by effect type
    if not spellEffects[sourceSpellID][effectType] then
        spellEffects[sourceSpellID][effectType] = {}
    end

    if not spellEffects[sourceSpellID][effectType][buffSpellID] then
        spellEffects[sourceSpellID][effectType][buffSpellID] = {
            observations = {},
            confidence = 0
        }
    end

    -- Add observation
    local buffData = spellEffects[sourceSpellID][effectType][buffSpellID]
    table.insert(buffData.observations, newObservation)

    -- Limit history
    if #buffData.observations > CONSTANTS.MAX_OBSERVATIONS then
        table.remove(buffData.observations, 1)
    end
    self:TrackObservationBuffer("spellEffects", #buffData.observations)

    -- Update confidence
    buffData.confidence = #buffData.observations / CONSTANTS.MAX_OBSERVATIONS

    -- Debug output
    if self.debug then
        self:Debug("Recorded buff application for spell %d, buff %d, type %s (spec: %d)", sourceSpellID,
            buffSpellID, effectType, self:GetCurrentSpecIndex())
    end
end

-- Record resource generation
function SpellLearnerStateManager:RecordResourceGeneration(spellID, amount, powerType)
    -- Validate parameters
    if not spellID or not amount then
        self:Debug("RecordResourceGeneration called with invalid parameters")
        return
    end

    -- Ensure powerType is valid
    powerType = powerType or "GENERIC"

    -- Get spec-specific storage
    local resourceGeneration = self:GetSpecDataTable("resourceGeneration")

    -- Initialize storage
    if not resourceGeneration[spellID] then resourceGeneration[spellID] = {} end

    -- Store this observation
    local newObservation = {
        timestamp = GetTime(),
        amount = amount,
        powerType = powerType
    }

    if not resourceGeneration[spellID][powerType] then
        resourceGeneration[spellID][powerType] = {
            observations = {},
            confidence = 0,
            consistentValue = nil
        }
    end

    local generationData = resourceGeneration[spellID][powerType]
    table.insert(generationData.observations, newObservation)

    -- Limit history
    if #generationData.observations > CONSTANTS.MAX_OBSERVATIONS then
        table.remove(generationData.observations, 1)
    end
    self:TrackObservationBuffer("resourceGeneration", #generationData.observations)

    -- Update confidence
    self:UpdateGenerationConfidence(spellID, powerType)

    -- Debug output
    if self.debug then
        self:Debug("Recorded resource generation for spell %d, power %s: %d (spec: %d)", spellID,
            powerType, amount, self:GetCurrentSpecIndex())
    end
end

-- Update resource generation confidence
function SpellLearnerStateManager:UpdateGenerationConfidence(spellID, powerType)
    -- Ensure we have a valid powerType to avoid indexing errors
    if not powerType or powerType == "" then
        self:Debug("UpdateGenerationConfidence called with invalid powerType")
        return
    end

    -- Get spec-specific storage
    local resourceGeneration = self:GetSpecDataTable("resourceGeneration")

    -- Ensure we have valid data
    if not resourceGeneration or not resourceGeneration[spellID] or
        not resourceGeneration[spellID][powerType] then
        return
    end

    local generationData = resourceGeneration[spellID][powerType]
    if not generationData or #generationData.observations < 3 then return end

    -- Count occurrences of each generation amount
    local amountCounts = {}
    local totalObservations = #generationData.observations

    for _, observation in ipairs(generationData.observations) do
        amountCounts[observation.amount] = (amountCounts[observation.amount] or 0) + 1
    end

    -- Find the most common value
    local mostCommonValue = nil
    local highestCount = 0

    for value, count in pairs(amountCounts) do
        if count > highestCount then
            mostCommonValue = value
            highestCount = count
        end
    end

    -- Calculate confidence
    local confidence = highestCount / totalObservations

    -- Update stored values
    generationData.confidence = confidence
    generationData.consistentValue = mostCommonValue

    -- Create a simple debug message without using format
    local message = "Updated generation confidence for spell " .. tostring(spellID) ..
        ", power " .. tostring(powerType) .. ": " ..
        tostring(math.floor(confidence * 100)) ..
        "% confident of " .. tostring(mostCommonValue) ..
        " generation (spec: " .. tostring(self:GetCurrentSpecIndex()) .. ")"

    self:Debug(message)
end

-- Note: ModuleInitialize functionality has been integrated into the main ModuleInitialize method above

-- Add handler for database reset
function SpellLearnerStateManager:ModuleResetDB(event, resetType)
    self:Debug("SpellLearnerStateManager received reset event: " .. tostring(resetType))

    -- Only process 'all' and 'char' reset types
    if resetType == "all" or resetType == "char" then
        -- Clear character-specific data
        self:ClearCharacterData()
        self:Debug("SpellLearner user-specific databases have been reset")
    end
end

-- Add function to clear all character-specific data
function SpellLearnerStateManager:ClearCharacterData()
    -- Reset all char-specific data tables
    -- Clear main data tables
    self.db.char.spellCosts = {}
    self.db.char.runeCosts = {}
    self.db.char.spellEffects = {}
    self.db.char.resourceGeneration = {}
    self.db.char.runeProfiles = {}
    self.db.char.runeUsageSummary = {}
    self.db.char.spellChanges = {}

    -- Clear spec-specific data
    self.db.char.specStorage = {}

    -- Reset last spec index
    self.db.char.lastSpecIndex = nil

    -- Re-initialize storage
    self:InitializeCharacterStorage()
end

-- Function to show learned data for a specific spell
function SpellLearnerStateManager:ShowSpellData(spellID, specIndex)
    -- Use provided specIndex or current
    specIndex = specIndex or self:GetCurrentSpecIndex()

    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local spellName = spellInfo and spellInfo.name or "Unknown"
    -- Get spec name using our safe function
    local specName = self:SafeGetSpecName(specIndex)

    if self.debug then self:Debug("|cFF00FF00===== Data for %s (ID: %d) [Spec: %s] =====|r", spellName, spellID, specName) end

    -- Use spec-specific storage
    local specStorage = self:GetSpecStorage(specIndex)

    -- Show resource costs
    if specStorage.spellCosts and specStorage.spellCosts[spellID] then
        self:Debug("Resource Costs:")
        for powerType, data in pairs(specStorage.spellCosts[spellID]) do
            if data.confidence and data.confidence > 0 then
                if self.debug then
                    self:Debug("  %s: %d (Confidence: %.1f%%)", powerType, data.consistentValue or 0,
                        (data.confidence or 0) * 100)
                end
            end
        end
    else
        self:Debug("No resource cost data found")
    end

    -- Show rune costs
    if specStorage.runeProfiles and specStorage.runeProfiles[spellID] then
        self:Debug("Rune Costs:")
        for runeType, data in pairs(specStorage.runeProfiles[spellID]) do
            if self.debug then
                self:Debug("  %s: %.1f%% (%d runes)", self:GetRuneTypeName(runeType),
                    data.percentage * 100, data.count)
            end
        end
    end

    -- Show applied buffs
    if specStorage.spellEffects and specStorage.spellEffects[spellID] then
        if specStorage.spellEffects[spellID].selfBuff then
            self:Debug("Self Buffs:")
            for buffID, data in pairs(specStorage.spellEffects[spellID].selfBuff) do
                local spellInfo = WoWAPI.GetSpellInfo(buffID)
                local buffName = spellInfo and spellInfo.name or "Unknown"
                if self.debug then
                    self:Debug("  %s (ID: %d) - Confidence: %.1f%%", buffName, buffID,
                        (data.confidence or 0) * 100)
                end
            end
        end

        if specStorage.spellEffects[spellID].targetDebuff then
            self:Debug("Target Debuffs:")
            for debuffID, data in pairs(specStorage.spellEffects[spellID].targetDebuff) do
                local spellInfo = WoWAPI.GetSpellInfo(debuffID)
                local debuffName = spellInfo and spellInfo.name or "Unknown"
                if self.debug then
                    self:Debug("  %s (ID: %d) - Confidence: %.1f%%", debuffName, debuffID,
                        (data.confidence or 0) * 100)
                end
            end
        end
    end

    -- Show resource generation
    if specStorage.resourceGeneration and specStorage.resourceGeneration[spellID] then
        self:Debug("Resource Generation:")
        for powerType, data in pairs(specStorage.resourceGeneration[spellID]) do
            if data.confidence and data.confidence > 0 then
                if self.debug then
                    self:Debug("  %s: %d (Confidence: %.1f%%)", powerType, data.consistentValue or 0,
                        (data.confidence or 0) * 100)
                end
            end
        end
    end

    -- Show spell changes
    if specStorage.spellChanges and specStorage.spellChanges[spellID] then
        local changeCount = #specStorage.spellChanges[spellID]
        if self.debug then self:Debug("State Change Observations: %d", changeCount) end
    end

    -- Add a command to show data from all specs
    self:Debug("\nUse '/nagspelldata " .. spellID .. " all' to see data from all specs")
end

-- Function to show summary of all learned data
function SpellLearnerStateManager:ShowLearnedDataSummary()
    self:Debug("|cFF00FF00===== Learned Spell Data Summary =====|r")

    -- Count learned spells by category
    local costCount = 0
    local runeCount = 0
    local effectCount = 0
    local generationCount = 0

    local spellCosts = self.db.char.spellCosts
    for _ in pairs(spellCosts) do
        costCount = costCount + 1
    end

    local runeProfiles = self.db.char.runeProfiles
    for _ in pairs(runeProfiles) do
        runeCount = runeCount + 1
    end

    local spellEffects = self.db.char.spellEffects
    for _ in pairs(spellEffects) do
        effectCount = effectCount + 1
    end

    local resourceGeneration = self.db.char.resourceGeneration
    for _ in pairs(resourceGeneration) do
        generationCount = generationCount + 1
    end

    if self.debug then self:Debug("Total spells with learned costs: %d", costCount) end
    if self.debug then self:Debug("Total spells with learned rune costs: %d", runeCount) end
    if self.debug then self:Debug("Total spells with learned effects: %d", effectCount) end
    if self.debug then self:Debug("Total spells with learned resource generation: %d", generationCount) end

    -- Show a few examples of high-confidence spells
    self:Debug("\nHigh confidence spell examples:")

    local highConfidenceFound = false
    local spellCosts = self.db.char.spellCosts
    for spellID, costData in pairs(spellCosts) do
        for powerType, data in pairs(costData) do
            if data.confidence and data.confidence > CONSTANTS.MIN_CONFIDENCE_THRESHOLD then
                local spellInfo = WoWAPI.GetSpellInfo(spellID)
                local spellName = spellInfo and spellInfo.name or "Unknown"
                if self.debug then
                    self:Debug("  %s (ID: %d) - %s cost: %d (%.1f%%)", spellName, spellID, powerType,
                        data.consistentValue, data.confidence * 100)
                end
                highConfidenceFound = true
                break -- Just show one cost per spell
            end
        end

        -- Limit to 5 examples
        if highConfidenceFound and costCount > 5 then
            if self.debug then self:Debug("  ...and %d more", costCount - 5) end
            break
        end
    end

    if not highConfidenceFound then
        self:Debug("  No high confidence data found yet")
    end

    self:Debug("\nUse /nagspelldata <spellID> to see detailed data for a specific spell")
end

-- Add a function to show rune usage summary
function SpellLearnerStateManager:ShowRuneUsageSummary(spellID)
    local runeUsageSummary = self.db.char.runeUsageSummary
    if not next(runeUsageSummary) then
        self:Debug("|cFFFF0000No rune usage data found. Cast some Death Knight spells first.|r")
        return
    end

    if spellID then
        -- Show details for a specific spell
        local data = self.db.char.runeUsageSummary[spellID]
        if not data then
            if self.debug then self:Debug("|cFFFF0000No rune usage data found for spell %d.|r", spellID) end
            return
        end

        if self.debug then self:Debug("|cFF00FF00===== Rune Usage for %s (ID: %d) =====|r", data.spellName, spellID) end
        if self.debug then
            self:Debug("Observations: %d, Last Updated: %s", data.observations,
                date("%Y-%m-%d %H:%M:%S", data.lastUpdated))
        end

        self:Debug("Rune Types Used:")
        for runeType, typeData in pairs(data.runeTypes) do
            if self.debug then
                self:Debug("  %s: %.1f%% (%.1f runes per cast, %d observations)", typeData.typeName,
                    typeData.percentage * 100, typeData.count / data.observations, typeData.rawCount)
            end
        end
    else
        -- Show summary of all spells
        self:Debug("|cFF00FF00===== Death Knight Rune Usage Summary =====|r")

        local spellCount = 0
        for spellID, data in pairs(runeUsageSummary) do
            spellCount = spellCount + 1

            -- Count total runes used
            local totalRunes = 0
            local runeTypeCounts = {}

            for runeType, typeData in pairs(data.runeTypes) do
                totalRunes = totalRunes + typeData.count
                runeTypeCounts[runeType] = typeData.percentage
            end

            -- Format the rune types used
            local runeTypesText = ""
            for runeType, percentage in pairs(runeTypeCounts) do
                if runeTypesText ~= "" then runeTypesText = runeTypesText .. ", " end
                runeTypesText = tostring(runeTypesText) .. tostring(format("%s: %.0f%%",
                    self:GetRuneTypeName(runeType), percentage * 100))
            end

            if self.debug then
                self:Debug("%s (ID: %d) - %d observations, %.1f runes/cast (%s)", data.spellName, spellID,
                    data.observations, totalRunes / data.observations, runeTypesText)
            end
        end

        if spellCount == 0 then
            self:Debug("No Death Knight spells with rune usage data found.")
        end

        self:Debug("\nUse /nagrunes <spellID> to see detailed data for a specific spell")
    end
end

-- Enhanced spell cast tracking to capture pre-cast state
function SpellLearnerStateManager:StartTrackingCast(spellID)
    local currentTime = GetTime()

    -- Don't start a new tracking if we're already tracking this spell
    if self.state.activeCast and self.state.activeCast.spellID == spellID then
        return
    end

    -- Capture pre-cast state
    local preCastState = {
        startTime = currentTime,
        spellID = spellID,
        resources = {},
        runes = {},
        buffs = {},
        debuffs = {}
    }

    -- Capture resource baselines for all power types
    for i = 0, 18 do     -- Check all power types
        local amount = UnitPower("player", i)
        preCastState.resources[i] = amount
    end

    -- Capture detailed rune states for Death Knights
    if NAG.CLASS_FILENAME == "DEATHKNIGHT" then
        -- Enhanced debug output
        self:Debug("|cFFFFFF00Capturing Death Knight rune state for spell: " ..
            tostring(spellID) .. " (ID: " .. tostring(spellID) .. ")|r")

        for i = 1, 6 do
            local start, duration, runeReady = GetRuneCooldown(i)
            local runeType = GetRuneType(i)
            local timeLeft = start and duration and (start + duration - GetTime()) or 0

            preCastState.runes[i] = {
                ready = runeReady == 1,
                type = runeType,
                start = start or 0,
                duration = duration or 0,
                timeLeft = timeLeft
            }

            -- Enhanced debug output
            local typeStr = self:GetRuneTypeName(runeType)
            if self.debug then
                self:Debug("|cFFFFFF00Rune %d: Type=%s, Ready=%s, TimeLeft=%.1f|r", i, typeStr,
                    tostring(runeReady == 1), timeLeft)
            end
        end
    end

    -- Accumulators to avoid double counting within the detection window
    preCastState.recorded = {
        cost = {},                          -- [powerType] = totalCostAlreadyRecorded
        gen = {},                           -- [powerType] = totalGenAlreadyRecorded
        rune = {},                          -- [runeIndex] = true if recorded
        buffs = { self = {}, target = {} }, -- de-duplication sets
    }

    -- Store the active cast
    self.state.activeCast = preCastState

    -- Schedule end of detection window

    if TimerManager then
        TimerManager:ScheduleTimer(function()
            if self.state.activeCast and self.state.activeCast.spellID == spellID then
                self.state.activeCast = nil
            end
        end, 1.0)
    end

    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    if self.debug then self:Debug("Started tracking cast: %s (ID: %d)", spellInfo and spellInfo.name or "Unknown", spellID) end
end

-- Add a new function for active rune monitoring
-- (Removed) StartActiveRuneMonitoring: replaced by event-driven RUNE_POWER_UPDATE
function SpellLearnerStateManager:StartActiveRuneMonitoring(spellID)
    -- Deprecated: no-op to avoid nil global calls from any legacy references
    return
end

--- Compares two game states and detects changes in resources, buffs, and runes
--- This function uses TablePool for the returned table. Callers MUST release the table after use.
--- @param oldState table The previous game state snapshot
--- @param newState table The current game state snapshot
--- @return table|nil A pooled table containing detected changes, or nil if states are invalid
--- @usage local changes = self:CompareStates(oldState, newState)
---        -- Use changes...
---        ns.TablePool:Release("small", changes)
function SpellLearnerStateManager:CompareStates(oldState, newState)
    if not oldState or not newState then
        self:Debug("Invalid states for comparison")
        return nil
    end

    local changes = ns.TablePool:Acquire()
    changes.timestamp = {
        old = oldState.timestamp,
        new = newState.timestamp,
        delta = newState.timestamp - oldState.timestamp
    }

    -- Compare resources with timing consideration
    changes.resources = {
        power = {},
        secondary = {}
    }

    -- Power changes
    for powerType, newValue in pairs(newState.resources.power) do
        local oldValue = oldState.resources.power[powerType]
        if oldValue ~= newValue then
            local changeData = {
                old = oldValue,
                new = newValue,
                delta = newValue - (oldValue or 0),
                maxValue = newState.resources.power.max or 100
            }

            -- Determine if change was natural
            if not self:IsNaturalChange(oldState, newState, "resource", changeData) then
                changes.resources.power[powerType] = changeData
                if self.debug then
                    self:Debug("Power change (spell-caused) - Type: %s, Old: %s, New: %s, Delta: %s",
                        powerType, oldValue or "nil", newValue, changeData.delta)
                end
            else
                if self.debug then
                    self:Debug("Power change (natural) - Type: %s, Old: %s, New: %s, Delta: %s", powerType,
                        oldValue or "nil", newValue, changeData.delta)
                end
            end
        end
    end

    -- Secondary resource changes with timing consideration
    for resourceType, newValue in pairs(newState.resources.secondary) do
        local oldValue = oldState.resources.secondary[resourceType]
        if oldValue ~= newValue then
            local changeData = {
                old = oldValue,
                new = newValue,
                delta = newValue - (oldValue or 0),
                maxValue = newState.resources.secondary.max or 100
            }

            -- Determine if change was natural
            if not self:IsNaturalChange(oldState, newState, "resource", changeData) then
                changes.resources.secondary[resourceType] = changeData
                if self.debug then
                    self:Debug(
                        "Secondary resource change (spell-caused) - Type: %s, Old: %s, New: %s, Delta: %s", resourceType,
                        oldValue or "nil", newValue, changeData.delta)
                end
            else
                if self.debug then
                    self:Debug(
                        "Secondary resource change (natural) - Type: %s, Old: %s, New: %s, Delta: %s", resourceType,
                        oldValue or "nil", newValue, changeData.delta)
                end
            end
        end
    end

    -- Compare buffs with timing consideration
    changes.buffs = {
        gained = {},
        lost = {},
        refreshed = {},
        consumed = {}
    }

    -- Track buff changes
    for buffId, newBuff in pairs(newState.buffs.player) do
        local oldBuff = oldState.buffs.player[buffId]
        if not oldBuff then
            changes.buffs.gained[buffId] = newBuff
            if self.debug then
                self:Debug("Buff gained - ID: %s, Duration: %s, Stacks: %s", buffId,
                    newBuff.duration or "nil", newBuff.stacks or 1)
            end
        else
            local changeData = {
                oldExpirationTime = oldBuff.expirationTime,
                newExpirationTime = newBuff.expirationTime,
                oldStacks = oldBuff.stacks,
                newStacks = newBuff.stacks
            }

            if newBuff.expirationTime > oldBuff.expirationTime then
                -- Determine if refresh was natural or spell-caused
                if not self:IsNaturalChange(oldState, newState, "buff", changeData) then
                    changes.buffs.refreshed[buffId] = {
                        old = oldBuff,
                        new = newBuff
                    }
                    if self.debug then
                        self:Debug(
                            "Buff refreshed (spell-caused) - ID: %s, Old expiration: %s, New expiration: %s", buffId,
                            oldBuff.expirationTime, newBuff.expirationTime)
                    end
                else
                    if self.debug then
                        self:Debug(
                            "Buff refreshed (natural) - ID: %s, Old expiration: %s, New expiration: %s", buffId,
                            oldBuff.expirationTime, newBuff.expirationTime)
                    end
                end
            elseif newBuff.stacks and oldBuff.stacks and newBuff.stacks < oldBuff.stacks then
                changes.buffs.consumed[buffId] = {
                    old = oldBuff,
                    new = newBuff
                }
                if self.debug then
                    self:Debug("Buff consumed - ID: %s, Old stacks: %s, New stacks: %s", buffId,
                        oldBuff.stacks, newBuff.stacks)
                end
            end
        end
    end

    -- Track lost buffs with timing consideration
    for buffId, oldBuff in pairs(oldState.buffs.player) do
        if not newState.buffs.player[buffId] then
            local changeData = {
                oldExpirationTime = oldBuff.expirationTime,
                oldStacks = oldBuff.stacks
            }

            -- Determine if loss was natural or spell-caused
            if not self:IsNaturalChange(oldState, newState, "buff", changeData) then
                changes.buffs.lost[buffId] = oldBuff
                if self.debug then self:Debug("Buff lost (spell-caused) - ID: %s", buffId) end
            else
                if self.debug then self:Debug("Buff lost (natural) - ID: %s", buffId) end
            end
        end
    end

    -- IMPROVED RUNE DETECTION: Compare runes with enhanced logic
    if oldState.runes and newState.runes then
        changes.runes = {
            spent = {},
            converted = {},
            cooldownChanged = {}
        }

        -- Debug start of rune comparison
        self:Debug("===== RUNE COMPARISON START =====")
        if self.debug then self:Debug("Time delta between states: %.3f seconds", changes.timestamp.delta) end

        -- First, output all rune states for debugging
        for i = 1, CONSTANTS.MAX_RUNES do
            local oldRune = oldState.runes[i]
            local newRune = newState.runes[i]

            if oldRune and newRune then
                -- Enhanced debug output
                if self.debug then self:Debug("Rune %d: Type: %s", i, self:GetRuneTypeName(oldRune.type)) end
                if self.debug then
                    self:Debug("  Old: Ready=%s, TimeLeft=%.2f, WillRefresh=%s", tostring(oldRune.ready),
                        oldRune.timeLeft, tostring(oldRune.willRefresh))
                end
                if self.debug then
                    self:Debug("  New: Ready=%s, TimeLeft=%.2f, WillRefresh=%s", tostring(newRune.ready),
                        newRune.timeLeft, tostring(newRune.willRefresh))
                end

                -- More detailed condition checking for rune usage detection
                -- A rune is considered used if ANY of the following are true:
                -- 1. It was ready before and not ready after
                -- 2. It was about to refresh and now has a longer cooldown
                -- 3. Its cooldown increased significantly (accounting for time passing)
                local timePassedAdjustment = changes.timestamp.delta
                local adjustedOldTimeLeft = math.max(0, oldRune.timeLeft - timePassedAdjustment)
                local cooldownIncreased = (newRune.timeLeft > adjustedOldTimeLeft + 0.5) -- 0.5s threshold

                local wasUsed = (oldRune.ready and not newRune.ready) or
                    (oldRune.willRefresh and newRune.timeLeft > 2.0) or
                    cooldownIncreased

                if wasUsed then
                    changes.runes.spent[i] = {
                        type = oldRune.type,
                        newCooldown = newRune.timeLeft,
                        wasRefreshing = oldRune.willRefresh,
                        fromReady = oldRune.ready,
                        cooldownIncreased = cooldownIncreased,
                        adjustedOldTimeLeft = adjustedOldTimeLeft
                    }

                    -- Enhanced debug output for rune usage
                    if self.debug then
                        self:Debug(
                            "|cFF00FF00Rune %d USED|r - Type: %s, Ready changed: %s, Refresh changed: %s, CD increased: %s",
                            i, self:GetRuneTypeName(oldRune.type), tostring(oldRune.ready and not newRune.ready),
                            tostring(oldRune.willRefresh and newRune.timeLeft > 2.0), tostring(cooldownIncreased))
                    end

                    -- Record this rune cost immediately while we have the data
                    local spellID = self.state.activeCast and self.state.activeCast.spellID
                    if spellID then
                        self:RecordRuneCost(spellID, i, oldRune.type)
                        if self.debug then
                            self:Debug("Recorded rune cost for spell %d: Rune %d (Type: %s)", spellID, i,
                                self:GetRuneTypeName(oldRune.type))
                        end
                    end
                else
                    -- Debug output for unchanged runes
                    if self.debug then self:Debug("Rune %d NOT USED - Type: %s", i, self:GetRuneTypeName(oldRune.type)) end
                end

                -- Track rune type conversions
                if oldRune.type ~= newRune.type then
                    changes.runes.converted[i] = {
                        oldType = oldRune.type,
                        newType = newRune.type
                    }
                    if self.debug then
                        self:Debug("Rune %d CONVERTED - %s -> %s", i, self:GetRuneTypeName(oldRune.type),
                            self:GetRuneTypeName(newRune.type))
                    end
                end
            end
        end

        self:Debug("===== RUNE COMPARISON END =====")

        -- Post-processing for Death Knight class verification
        local class = NAG.CLASS_FILENAME
        if class == "DEATHKNIGHT" and next(changes.runes.spent) == nil then
            self:Debug(
                "|cFFFF0000WARNING: No runes detected as spent for DK spell! This may indicate a state capture timing issue or a logic bug.|r")

            -- Check if activeCast has a spellID that is known to use runes
            local spellID = self.state.activeCast and self.state.activeCast.spellID
            if spellID then
                if self.debug then
                    local spellInfo = WoWAPI.GetSpellInfo(spellID)
                    self:Debug("Active spell being cast: %s (ID: %d)", spellInfo and spellInfo.name or "Unknown",
                        spellID)
                end

                -- TODO: We could add known DK spell -> rune usage mappings here
                -- For now, we'll just log this information
            end
        end
    end

    -- IMPORTANT: Caller must release this table: ns.TablePool:Release("small", changes)
    return changes
end

-- Also improve how post-cast state is captured in OnSpellCastSucceeded
-- by making it more tolerant of timing issues

function SpellLearnerStateManager:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellID)
    -- Check if module is enabled
    if not self.db.char.enabled then
        return
    end

    if unit ~= "player" then return end

    local currentTime = GetTime()

    -- Get the cast data
    local castData = self.state.activeCasts[castGUID]
    if not castData then
        self:Debug("|cFFFFFF00No cast data found for GUID: " .. tostring(castGUID) .. "|r")

        -- IMPROVEMENT: Try to use activeCast as fallback
        if self.state.activeCast and self.state.activeCast.spellID == spellID then
            local spellInfo = WoWAPI.GetSpellInfo(spellID)
            local spellName = spellInfo and spellInfo.name or "Unknown"
            self:Debug("|cFFFFFF00Using activeCast as fallback for spell " .. spellName .. "|r")
            castData = {
                spellID = spellID,
                timestamp = self.state.activeCast.startTime,
                preState = self:CreatePreStateFromActiveCast(self.state.activeCast)
            }
        else
            return
        end
    end

    -- Check if this spell was in our tracked list
    if not self:IsSpellTracked(spellID) then
        -- IMPROVEMENT: Always track Death Knight abilities for better detection
        local class = NAG.CLASS_FILENAME
        if class == "DEATHKNIGHT" then
            if self.debug then
                local spellInfo = WoWAPI.GetSpellInfo(spellID)
                self:Debug("|cFFFFFF00Auto-tracking Death Knight spell: %s (ID: %d)|r",
                    spellInfo and spellInfo.name or "Unknown", spellID)
            end
            self:UpdateTrackedNextSpells(spellID)
        else
            if self.debug then
                self:Debug("|cFFFF0000Spell %d was not in tracked spells list, skipping snapshot|r",
                    spellID)
            end
            return
        end
    end

    -- 🔍 SPELL LEARNING: Store the cast GUID for later reference
    self.state.lastCastGUID = castGUID
    self:Debug("|cFF00FF00[SPELL LEARNING] Stored cast GUID: " .. tostring(castGUID) .. " for spell " .. spellID .. "|r")

    -- IMPROVEMENT: For Death Knights, always use a fixed delay that's optimized for rune detection
    local delay = CONSTANTS.POST_CAST_DELAY
    local class = NAG.CLASS_FILENAME
    if class == "DEATHKNIGHT" then
        delay = 0.25 -- Slightly longer delay for DK abilities to ensure runes update
        self:Debug("|cFFFFFF00Using Death Knight specific delay: " .. tostring(delay) .. "|r")
    else
        -- Normal distance-based delay calculation
        delay = self:GetDistanceBasedDelay("target")
        if not delay then
            self:Debug("|cFFFF0000Target too far away, using default delay for spell " ..
                tostring(spellID) .. "|r")
            delay = CONSTANTS.POST_CAST_DELAY
        end
    end

    self:Debug("|cFF00FFFFScheduling post-cast state capture with delay: " .. tostring(delay) .. "|r")

    -- Schedule post-cast state capture with distance-based delay

    if TimerManager then
        TimerManager:ScheduleTimer(function()
            -- Capture post-cast state
            local postState = self:CaptureCurrentState()
            local currentTime = GetTime()

            -- Clean up old casts
            for guid, data in pairs(self.state.activeCasts) do
                if currentTime - data.timestamp > 2 then
                    self.state.activeCasts[guid] = nil
                end
            end

            -- Store this cast with enhanced metadata
            self.state.activeCasts[castGUID] = {
                spellID = spellID,
                timestamp = currentTime,
                isWeaponEnchant = self:IsWeaponEnchant(spellID),
                preState = castData.preState,
                postState = postState,
                distanceBasedDelay = delay
            }

            -- 🔍 SPELL LEARNING: Debug output for state capture
            self:Debug("|cFF00FF00[SPELL LEARNING] Captured post-state for spell " .. spellID .. "|r")
            self:Debug("|cFF00FF00[SPELL LEARNING] Pre-state exists: " .. tostring(castData.preState ~= nil) .. "|r")
            self:Debug("|cFF00FF00[SPELL LEARNING] Post-state exists: " .. tostring(postState ~= nil) .. "|r")

            -- Compare states if we have a valid pre-cast state
            if castData.preState then
                self:Debug("|cFF00FFFFCalling CompareCastStates for spell ID: " .. tostring(spellID) .. "|r")
                self:CompareCastStates(castData.preState, postState, spellID)
            else
                self:Debug("|cFFFF0000Skipping CompareCastStates - invalid pre-state|r")
            end
        end, delay)
    end
end

-- Add helper function to create a pre-state from activeCast data
function SpellLearnerStateManager:CreatePreStateFromActiveCast(activeCast)
    if not activeCast then return nil end

    local state = {
        timestamp = activeCast.startTime,
        resources = {
            power = {
                type = UnitPowerType("player"),
                current = 0,
                max = UnitPowerMax("player")
            },
            secondary = {
                type = self:GetSecondaryPowerType(),
                current = 0,
                max = UnitPowerMax("player", self:GetSecondaryPowerType())
            }
        },
        buffs = {
            player = {},
            target = {}
        },
        debuffs = {
            player = {},
            target = {}
        }
    }

    -- Convert activeCast resources to state format
    for powerType, amount in pairs(activeCast.resources) do
        if tonumber(powerType) == UnitPowerType("player") then
            state.resources.power.current = amount
        elseif tonumber(powerType) == self:GetSecondaryPowerType() then
            state.resources.secondary.current = amount
        end
    end

    -- Convert activeCast runes if available
    if activeCast.runes then
        state.runes = {}
        for i = 1, CONSTANTS.MAX_RUNES do
            if activeCast.runes[i] then
                state.runes[i] = CopyTable(activeCast.runes[i])
            end
        end
    end

    return state
end

-- Define the IsWeaponEnchant function
function SpellLearnerStateManager:IsWeaponEnchant(spellID)
    -- List of known weapon enchant spells
    local weaponEnchants = {
        -- Rogue poisons
        [8679] = true,   -- Instant Poison
        [2823] = true,   -- Deadly Poison
        [3408] = true,   -- Crippling Poison
        [5761] = true,   -- Mind-numbing Poison
        [108211] = true, -- Leeching Poison
        [315584] = true, -- Instant Poison

        -- Shaman weapon enchants
        [8232] = true,  -- Windfury Weapon
        [8024] = true,  -- Flametongue Weapon
        [8033] = true,  -- Frostbrand Weapon
        [51730] = true, -- Earthliving Weapon

        -- Death Knight Rune enchants
        [53341] = true, -- Rune of Cinderglacier
        [53343] = true, -- Rune of Razorice
        [54446] = true, -- Rune of Swordshattering
        [54447] = true, -- Rune of Spellshattering
        [62158] = true, -- Rune of the Stoneskin Gargoyle
        [70164] = true, -- Rune of the Fallen Crusader

        -- Warlock Spellstone & Firestone
        [47878] = true, -- Create Spellstone
        [47886] = true, -- Create Firestone
    }

    return weaponEnchants[spellID] or false
end

-- Define the GetDistanceBasedDelay function
function SpellLearnerStateManager:GetDistanceBasedDelay(unit)
    if not unit or not UnitExists(unit) then
        return CONSTANTS.POST_CAST_DELAY
    end

    -- Use CONSTANTS.DISTANCE_INDEX to check distances
    local delayTable = {
        [CONSTANTS.DISTANCE_INDEX.INSPECT] = 0.15, -- Far
        [CONSTANTS.DISTANCE_INDEX.TRADE] = 0.10,   -- Medium
        [CONSTANTS.DISTANCE_INDEX.DUEL] = 0.08,    -- Close
        [CONSTANTS.DISTANCE_INDEX.FOLLOW] = 0.15   -- Far
    }

    -- Try all distance checks from closest to farthest
    local checkOrder = {
        CONSTANTS.DISTANCE_INDEX.DUEL,
        CONSTANTS.DISTANCE_INDEX.TRADE,
        CONSTANTS.DISTANCE_INDEX.INSPECT,
        CONSTANTS.DISTANCE_INDEX.FOLLOW
    }

    for _, index in ipairs(checkOrder) do
        if CheckInteractDistance(unit, index) then
            return delayTable[index]
        end
    end

    -- Default to the standard delay if target is out of range
    return CONSTANTS.POST_CAST_DELAY
end

-- Removed CreateStateUpdateTimer: periodic polling eliminated in favor of event-only processing

-- Define the InspectStoredChanges function
function SpellLearnerStateManager:InspectStoredChanges(spellID)
    local spellChanges = self.db.char.spellChanges
    if not next(spellChanges) then
        self:Debug("|cFFFF0000No spell changes data found|r")
        return
    end

    if spellID then
        -- Show changes for a specific spell
        local changes = self.db.char.spellChanges[spellID]
        if not changes then
            if self.debug then self:Debug("|cFFFF0000No changes found for spell ID %d|r", spellID) end
            return
        end

        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        local spellName = spellInfo and spellInfo.name or "Unknown"
        if self.debug then self:Debug("|cFF00FF00Changes for %s (ID: %d):|r", spellName, spellID) end

        -- Display the most recent changes first
        local count = #changes
        for i = count, max(1, count - 5), -1 do
            local change = changes[i]
            local timestamp = change.timestamp
            local timeFormatted = date("%H:%M:%S", timestamp)

            if self.debug then self:Debug("|cFFFFFF00Change #%d at %s:|r", i, timeFormatted) end

            -- Resource changes
            if change.resources then
                self:Debug("Resources:")
                if change.resources.power then
                    for powerType, data in pairs(change.resources.power) do
                        if self.debug then
                            self:Debug("  Power %s: %d -> %d (Δ%d)", powerType, data.old or 0,
                                data.new or 0, data.delta or 0)
                        end
                    end
                end
                if change.resources.secondary then
                    for resourceType, data in pairs(change.resources.secondary) do
                        if self.debug then
                            self:Debug("  Secondary %s: %d -> %d (Δ%d)", resourceType, data.old or 0,
                                data.new or 0, data.delta or 0)
                        end
                    end
                end
            end

            -- Buff changes
            if change.buffs and change.buffs.gained and #change.buffs.gained > 0 then
                self:Debug("Gained buffs:")
                for _, buff in ipairs(change.buffs.gained) do
                    local spellInfo = WoWAPI.GetSpellInfo(buff.id)
                    local buffName = spellInfo and spellInfo.name or "Unknown"
                    if self.debug then self:Debug("  %s (ID: %d) - Stacks: %d", buffName, buff.id, buff.count or 1) end
                end
            end

            if change.buffs and change.buffs.lost and #change.buffs.lost > 0 then
                self:Debug("Lost buffs:")
                for _, buff in ipairs(change.buffs.lost) do
                    local spellInfo = WoWAPI.GetSpellInfo(buff.id)
                    local buffName = spellInfo and spellInfo.name or "Unknown"
                    if self.debug then self:Debug("  %s (ID: %d)", buffName, buff.id) end
                end
            end

            -- DoT changes
            if change.dots and change.dots.applied and next(change.dots.applied) then
                self:Debug("Applied DoTs:")
                for dotID, dot in pairs(change.dots.applied) do
                    local spellInfo = WoWAPI.GetSpellInfo(dotID)
                    local dotName = spellInfo and spellInfo.name or "Unknown"
                    if dot.isRefresh then
                        if self.debug then
                            self:Debug("  %s (ID: %d) - REFRESHED - Extended by %.1f seconds", dotName,
                                dotID, dot.timeDiff or 0)
                        end
                    else
                        if self.debug then
                            self:Debug("  %s (ID: %d) - NEW - Duration: %.1f seconds", dotName, dotID,
                                dot.duration or 0)
                        end
                    end
                end
            end

            -- Rune changes
            if change.runes and change.runes.spent and next(change.runes.spent) then
                self:Debug("Spent runes:")
                for runeID, rune in pairs(change.runes.spent) do
                    if self.debug then self:Debug("  Rune %d: Type=%s", runeID, self:GetRuneTypeName(rune.type)) end
                end
            end
        end
    else
        -- Show summary of all spells with changes
        self:Debug("|cFF00FF00Spell Change Summary:|r")

        local spellCount = 0
        local spellWithMostChanges = nil
        local maxChanges = 0

        -- Count changes by spell
        for spellID, changes in pairs(spellChanges) do
            spellCount = spellCount + 1
            local changeCount = #changes

            local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local spellName = spellInfo and spellInfo.name or "Unknown"
            if self.debug then self:Debug("%s (ID: %d): %d changes", spellName, spellID, changeCount) end

            if changeCount > maxChanges then
                maxChanges = changeCount
                spellWithMostChanges = spellID
            end
        end

        if self.debug then self:Debug("|cFFFFFF00Total spells with changes: %d|r", spellCount) end

        if spellWithMostChanges then
            local spellInfo = WoWAPI.GetSpellInfo(spellWithMostChanges)
            local spellName = spellInfo and spellInfo.name or "Unknown"
            if self.debug then
                self:Debug("|cFFFFFF00Spell with most changes: %s (ID: %d) - %d changes|r", spellName,
                    spellWithMostChanges, maxChanges)
            end

            -- Show tip for viewing details
            self:Debug("\nUse /nagstates <spellID> to view detailed changes for a specific spell")
        end
    end
end

-- Define the StoreStateChanges function to go with InspectStoredChanges
function SpellLearnerStateManager:StoreStateChanges(spellID, changes)
    -- Get spec-specific storage
    local spellChanges = self:GetSpecDataTable("spellChanges")

    -- Initialize storage if needed
    if not spellChanges[spellID] then
        spellChanges[spellID] = {}
    end

    -- Store the changes
    table.insert(spellChanges[spellID], changes)

    -- Limit storage per spell
    if #spellChanges[spellID] > CONSTANTS.MAX_STATE_CHANGES then
        table.remove(spellChanges[spellID], 1)
    end

    if self.debug then
        self:Debug("Stored state changes for spell %d (%s) (spec: %d)", spellID,
            changes.spellName or "Unknown", self:GetCurrentSpecIndex())
    end
end

-- Define the UpdatePlayerBuffs function
function SpellLearnerStateManager:UpdatePlayerBuffs()
    if not self.auraCache then
        self.auraCache = {
            player = {},
            target = {},
            lastTargetGUID = nil
        }
    end

    self:UpdateAuraCache("player")
    self:Debug("Updated player buffs cache")
end

-- Define the UpdateTargetDebuffs function
function SpellLearnerStateManager:UpdateTargetDebuffs()
    if not self.auraCache then
        self.auraCache = {
            player = {},
            target = {},
            lastTargetGUID = nil
        }
    end

    if UnitExists("target") then
        self:UpdateAuraCache("target")
        self:Debug("Updated target debuffs cache for " .. (UnitName("target") or "Unknown"))
    else
        self:Debug("No target for debuff update")
    end
end

-- Define the UpdateCooldowns function
function SpellLearnerStateManager:UpdateCooldowns()
    -- Update cooldowns for the current player
    if not self.state.currentState.cooldowns then
        self.state.currentState.cooldowns = {}
    end

    -- Scan spellbook for cooldowns
    for i = 1, WoWAPI.GetNumSpellTabs() do
        local tabInfo = WoWAPI.GetSpellTabInfo(i)
        if tabInfo then
            local offset = tabInfo.itemIndexOffset
            local numSpells = tabInfo.numSpellBookItems
            if offset and numSpells then
                for j = offset + 1, offset + numSpells do
                    local spellInfo = WoWAPI.GetSpellInfo(j, BOOKTYPE_SPELL)
                    if spellInfo and spellInfo.spellID then
                        local spellID = spellInfo.spellID
                        local cdInfo = WoWAPI.GetSpellCooldown(spellID)
                        if cdInfo then
                            local start = cdInfo.startTime
                            local duration = cdInfo.duration
                            if start and duration and duration > 0 then
                                local remaining = start + duration - GetTime()
                                if remaining > 0 then
                                    self.state.currentState.cooldowns[spellID] = remaining
                                else
                                    self.state.currentState.cooldowns[spellID] = nil
                                end
                            else
                                self.state.currentState.cooldowns[spellID] = nil
                            end
                        end
                    end
                end
            end
        end
    end

    self:Debug("Updated cooldowns cache")
end

-- Define OnPowerUpdate, OnAuraUpdate, OnCooldownUpdate, and OnEnteringWorld handlers

-- Define the OnPowerUpdate handler
function SpellLearnerStateManager:UNIT_POWER_UPDATE(event, unit, powerType)
    if unit ~= "player" then return end
    if not self.state.activeCast then return end

    local now = GetTime()
    local elapsed = now - (self.state.activeCast.startTime or 0)
    if elapsed > CONSTANTS.RESOURCE_DETECTION_WINDOW then return end

    -- Normalize powerType to numeric
    local pt = powerType
    if type(pt) == "string" then
        local map = {
            MANA = 0,
            RAGE = 1,
            FOCUS = 2,
            ENERGY = 3,
            COMBO_POINTS = 4,
            RUNES = 5,
            RUNIC_POWER = 6,
            SOUL_SHARDS = 7,
            LUNAR_POWER = 8,
            HOLY_POWER = 9,
            ALTERNATE = 10,
            MAELSTROM = 11,
            CHI = 12,
            INSANITY = 13,
            BURNING_EMBERS = 14,
            DEMONIC_FURY = 15,
            ARCANE_CHARGES = 16,
            FURY = 17,
            PAIN = 18
        }
        pt = map[pt]
    end
    if type(pt) ~= "number" then return end

    local base = self.state.activeCast.resources[pt]
    if base == nil then
        base = UnitPower("player", pt)
        self.state.activeCast.resources[pt] = base
    end

    local current = UnitPower("player", pt)
    local net = current - base

    local rec = self.state.activeCast.recorded
    rec.cost[pt] = rec.cost[pt] or 0
    rec.gen[pt] = rec.gen[pt] or 0

    local wantCost = math.max(0, -(net))
    local addCost = wantCost - rec.cost[pt]
    if addCost > 0 then
        self:RecordResourceCost(self.state.activeCast.spellID, pt, addCost)
        rec.cost[pt] = rec.cost[pt] + addCost
    end

    local wantGen = math.max(0, net)
    local addGen = wantGen - rec.gen[pt]
    if addGen > 0 then
        self:RecordResourceGeneration(self.state.activeCast.spellID, addGen, pt)
        rec.gen[pt] = rec.gen[pt] + addGen
    end
end

-- Define the OnAuraUpdate handler
function SpellLearnerStateManager:UNIT_AURA(event, unit)
    -- Only handle auras for player and target
    if unit ~= "player" and unit ~= "target" then
        return
    end

    local currentTime = GetTime()

    -- Update our aura cache
    self:UpdateAuraCache(unit)

    -- If there's an active cast, check for buff/debuff applications caused by the spell
    if self.state.activeCast then
        local spellID = self.state.activeCast.spellID
        local startTime = self.state.activeCast.startTime
        local elapsedSinceCast = currentTime - startTime

        -- Only consider aura changes within our detection window
        if elapsedSinceCast <= CONSTANTS.BUFF_DETECTION_WINDOW then
            if unit == "player" then
                local seen = self.state.activeCast.recorded.buffs.self
                for buffID, buffInfo in pairs(self.auraCache.player) do
                    if buffInfo.sourceUnit == "player" and not seen[buffID] then
                        self:Debug("|cFF00FF00DETECTED SELF BUFF: " .. tostring(buffInfo.name) ..
                            " (ID: " .. tostring(buffID) .. ") from spell " .. tostring(spellID) ..
                            " (" .. tostring(math.floor(elapsedSinceCast * 100) / 100) .. "s after cast)|r")
                        self:RecordBuffApplication(spellID, buffID, "selfBuff", "player", "applies")
                        seen[buffID] = true
                    end
                end
            elseif unit == "target" and UnitExists("target") then
                local seenT = self.state.activeCast.recorded.buffs.target
                for debuffID, debuffInfo in pairs(self.auraCache.target) do
                    if debuffInfo.sourceUnit == "player" and not debuffInfo.isHelpful and not seenT[debuffID] then
                        self:Debug("|cFF00FF00DETECTED TARGET DEBUFF: " .. tostring(debuffInfo.name) ..
                            " (ID: " .. tostring(debuffID) .. ") from spell " .. tostring(spellID) ..
                            " (" .. tostring(math.floor(elapsedSinceCast * 100) / 100) .. "s after cast)|r")
                        self:RecordBuffApplication(spellID, debuffID, "targetDebuff", UnitGUID("target"), "applies")
                        seenT[debuffID] = true
                    end
                end
            end
        end
    end
end

-- Shared cooldown update handler
function SpellLearnerStateManager:OnCooldownUpdate()
    local currentTime = GetTime()
    local timeSinceLastCooldownUpdate = currentTime - self.state.lastCooldownUpdateTime

    -- Always capture a lightweight pre-cast state (overwrite any pending)
    if not self.CaptureCurrentStateLight then
        function self:CaptureCurrentStateLight()
            local s = { timestamp = GetTime(), resources = { power = {}, secondary = {} }, runes = {} }
            for i = 0, 18 do s.resources.power[i] = UnitPower("player", i) end
            s.resources.secondary.type = self:GetSecondaryPowerType()
            s.resources.secondary.current = UnitPower("player", s.resources.secondary.type)
            s.resources.secondary.max = UnitPowerMax("player", s.resources.secondary.type)
            if NAG.CLASS_FILENAME == "DEATHKNIGHT" then
                for i = 1, CONSTANTS.MAX_RUNES do
                    local start, duration, ready = GetRuneCooldown(i)
                    s.runes[i] = {
                        ready = (ready == 1),
                        type = GetRuneType(i),
                        start = start or 0,
                        duration = duration or 0,
                        timeLeft = start and duration and (start + duration - GetTime()) or 0
                    }
                end
            end
            return s
        end
    end

    self.state.pendingCooldownUpdate = {
        timestamp = currentTime,
        state = self:CaptureCurrentStateLight()
    }

    self.state.lastCooldownUpdateTime = currentTime
    self:Debug("|cFFFFFF00Captured lightweight pre-cast state from cooldown update at " ..
        format("%.3f", currentTime) .. "|r")
end

-- Define the SPELL_UPDATE_COOLDOWN handler
function SpellLearnerStateManager:SPELL_UPDATE_COOLDOWN()
    self:OnCooldownUpdate()
end

-- Define the ACTIONBAR_UPDATE_COOLDOWN handler
function SpellLearnerStateManager:ACTIONBAR_UPDATE_COOLDOWN()
    self:OnCooldownUpdate()
end

-- Define the OnEnteringWorld handler
function SpellLearnerStateManager:PLAYER_ENTERING_WORLD()
    self:Debug("Player entering world - initializing state tracking")

    -- Update aura caches
    self:UpdatePlayerBuffs()
    self:UpdateTargetDebuffs()

    -- Update cooldowns
    self:UpdateCooldowns()

    -- Reset any tracking state
    self.state.activeCast = nil
    self.state.activeCasts = {}
    self.state.trackedNextSpells = {}
    self.state.trackedNextSpellsCount = 0

    self:Debug("State tracking initialized")
end

-- CLEU handlers split per subevent for clarity
function SpellLearnerStateManager:HandleCLEUSpellCastStart(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, arg14, arg15, arg16, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if sourceGUID ~= NAG.state.player.guid then return end

    if self.debug then self:Debug("|cFFFFFF00COMBAT_LOG: %s - %s (ID: %d)|r", subEvent, spellName, spellID) end
    self:StartTrackingCast(spellID)
end

function SpellLearnerStateManager:HandleCLEUSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, arg14, arg15, arg16, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if sourceGUID ~= NAG.state.player.guid then return end

    if self.debug then self:Debug("|cFFFFFF00COMBAT_LOG: %s - %s (ID: %d)|r", subEvent, spellName, spellID) end
    if not self.state.activeCast or self.state.activeCast.spellID ~= spellID then
        self:StartTrackingCast(spellID)
    end
end

local function handleAuraApplication(self, subEvent, timestamp, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType)

    if sourceGUID ~= NAG.state.player.guid then return end
    if not self.state.activeCast then return end

    local currentTime = GetTime()
    local elapsedSinceCast = currentTime - self.state.activeCast.startTime
    if elapsedSinceCast > CONSTANTS.BUFF_DETECTION_WINDOW then return end

    local isPlayerBuff = destGUID == NAG.state.player.guid and auraType == "BUFF"
    local isTargetDebuff = destGUID == UnitGUID("target") and auraType == "DEBUFF"

    if isPlayerBuff then
        if self.debug then
            self:Debug(
                "|cFF00FF00DETECTED SELF BUFF FROM COMBAT LOG: %s (ID: %d) from spell %d (%.2fs after cast)|r",
                spellName, spellID, self.state.activeCast.spellID, elapsedSinceCast)
        end
        self:RecordBuffApplication(self.state.activeCast.spellID, spellID, "selfBuff", destGUID, "applies")
    elseif isTargetDebuff then
        if self.debug then
            self:Debug(
                "|cFF00FF00DETECTED TARGET DEBUFF FROM COMBAT LOG: %s (ID: %d) from spell %d (%.2fs after cast)|r",
                spellName, spellID, self.state.activeCast.spellID, elapsedSinceCast)
        end
        self:RecordBuffApplication(self.state.activeCast.spellID, spellID, "targetDebuff", destGUID, "applies")
    end
end

function SpellLearnerStateManager:HandleCLEUAuraApplied(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    handleAuraApplication(self, subEvent, timestamp, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
        destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType)
end

function SpellLearnerStateManager:HandleCLEUAuraAppliedDose(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    handleAuraApplication(self, subEvent, timestamp, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
        destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType)
end

local debugFormatter

--
-- IMPORTANT: The Debug function in CoreModule.lua uses format() internally, which causes issues
-- with certain strings. This helper function simply passes a plain string directly to Debug
-- to avoid any formatting issues. It no longer tries to format the string at all - just use
-- it to pass already-formatted or plain strings to Debug.
--
function SpellLearnerStateManager:DebugFormatted(message)
    -- Ensure the message is a string
    local safeMessage = tostring(message or "")
    -- Pass the string directly to Debug without any formatting
    self:Debug(safeMessage)
end

-- Add these functions after InitializeCharacterStorage

-- Get the current specialization index
function SpellLearnerStateManager:GetCurrentSpecIndex()
    -- Use the cached StateManager API for current specialization data
    local SpecCompat = NAG:GetModule("SpecCompat")
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    return specIndex or 0
end

-- Get the storage table for the current spec
function SpellLearnerStateManager:GetSpecStorage(specIndex)
    -- Use provided specIndex or current spec
    specIndex = specIndex or self:GetCurrentSpecIndex()

    -- Initialize spec storage if needed
    local specStorage = self.db.char.specStorage[specIndex] or {
        spellCosts = {},
        runeCosts = {},
        spellEffects = {},
        resourceGeneration = {},
        runeProfiles = {},
        runeUsageSummary = {},
        spellChanges = {}
    }

    return specStorage
end

-- Get a specific data table for the current spec
function SpellLearnerStateManager:GetSpecDataTable(dataType, specIndex)
    local specStorage = self:GetSpecStorage(specIndex)
    return specStorage[dataType]
end

-- Check if the spec has changed and handle migration if needed
function SpellLearnerStateManager:CheckSpecChange()
    local currentSpecIndex = self:GetCurrentSpecIndex()
    local lastSpecIndex = self.db.char.lastSpecIndex

    -- If this is first run or spec changed, handle it
    if lastSpecIndex ~= currentSpecIndex then
        if self.debug then self:Debug("Spec changed from %s to %s", tostring(lastSpecIndex), tostring(currentSpecIndex)) end

        -- If this is the first time seeing this spec, check if we need to migrate data
        if currentSpecIndex > 0 then
            -- Ensure specStorage exists before accessing it
            local specStorage = self.db.char.specStorage[currentSpecIndex]
            if not specStorage then
                self:MigrateDataToSpec(currentSpecIndex)
            end
        end

        -- Update last spec index
        self.db.char.lastSpecIndex = currentSpecIndex
    end
end

-- Migrate non-spec character data to spec-specific storage
function SpellLearnerStateManager:MigrateDataToSpec(specIndex)
    -- Skip if we have no data or spec storage already exists
    if not specIndex or specIndex == 0 then
        return
    end

    -- Ensure specStorage exists before accessing it
    local specStorage = self.db.char.specStorage[specIndex]
    if specStorage then
        return
    end

    if self.debug then self:Debug("Migrating character data to spec %d storage", specIndex) end

    -- Initialize spec storage
    local specStorage = self:GetSpecStorage(specIndex)

    -- List of data types to migrate
    local dataTypes = {
        "spellCosts", "runeCosts", "spellEffects", "resourceGeneration",
        "runeProfiles", "runeUsageSummary", "spellChanges"
    }

    -- Copy data from character storage to spec storage
    local hasMigratedData = false
    for _, dataType in ipairs(dataTypes) do
        local data = self.db.char[dataType]
        if data and next(data) then
            for key, value in pairs(data) do
                specStorage[dataType][key] = CopyTable(value)
                hasMigratedData = true
            end
        end
    end

    if hasMigratedData then
        self:Debug("Successfully migrated character data to spec-specific storage")
    else
        self:Debug("No character data to migrate to spec-specific storage")
    end
end

-- Handle talent changes for Classic
function SpellLearnerStateManager:OnTalentPointsChanged()
    self:Debug("Talent points changed, checking for spec changes")
    self:CheckSpecChange()
end

-- Handle dual-spec changes in Wrath
function SpellLearnerStateManager:OnTalentGroupChanged()
    self:Debug("Talent group changed, checking for spec changes")
    self:CheckSpecChange()
end

-- Handle talent updates (broadcast by SpecCompat)
function SpellLearnerStateManager:NAG_TALENTS_UPDATED(message, payload)
    self:Debug("Talent updated, checking for spec changes")
    self:CheckSpecChange()
end

-- Handle spec change events
function SpellLearnerStateManager:NAG_SPEC_UPDATED(message, payload)
    self:CheckSpecChange()
end

-- Handle database reset events
function SpellLearnerStateManager:NAG_DB_RESET(message)
    self:Debug("Database reset event received - clearing all cached data")
    -- Clear all cached data
    if self.auraCache then
        wipe(self.auraCache)
        self.auraCache = {
            target = {},
            lastTargetGUID = nil
        }
    end
    if self.state and self.state.stateHistory then
        wipe(self.state.stateHistory)
    end
    if self.state and self.state.activeCasts then
        wipe(self.state.activeCasts)
    end
    self:Debug("Database reset cleanup complete")
end

-- Slash command handlers (extracted from inline functions for better maintainability)

--- Handle /nagstates command
--- @param self SpellLearnerStateManager
--- @param input string The command input
function SpellLearnerStateManager:HandleStatesCommand(input)
    if input and input ~= "" then
        -- Try to convert input to number for spell ID
        local spellID = tonumber(input)
        if spellID then
            self:InspectStoredChanges(spellID)
        else
            self:Debug("Please provide a valid spell ID")
        end
    else
        -- Show summary of all stored data
        self:InspectStoredChanges()
    end
end

--- Handle /nagbuffs command
--- @param self SpellLearnerStateManager
function SpellLearnerStateManager:HandleBuffsCommand()
    self:DebugBuffTracking()
end

--- Handle /nagspelldata command
--- @param self SpellLearnerStateManager
--- @param input string The command input
function SpellLearnerStateManager:HandleSpellDataCommand(input)
    if input and input ~= "" then
        -- Try to convert input to number for spell ID
        local spellID = tonumber(input)
        if spellID then
            self:ShowSpellData(spellID)
        else
            self:Debug("Please provide a valid spell ID")
        end
    else
        -- Show summary of learned data
        self:ShowLearnedDataSummary()
    end
end

--- Handle /nagrunes command
--- @param self SpellLearnerStateManager
--- @param input string The command input
function SpellLearnerStateManager:HandleRunesCommand(input)
    self:ShowRuneUsageSummary(tonumber(input))
end

--- Handle /nagstorage command
--- @param self SpellLearnerStateManager
--- @param input string The command input
function SpellLearnerStateManager:HandleStorageCommand(input)
    if input and input:lower() == "clearspec" then
        local currentSpec = self:GetCurrentSpecIndex()
        if currentSpec > 0 then
            -- Clear current spec data
            self:SetSetting("char", "specStorage." .. currentSpec, nil)
            if self.debug then self:Debug("Cleared all data for spec %d", currentSpec) end
        else
            self:Debug("No valid spec selected")
        end
    elseif input and input:lower() == "listspecs" then
        -- List all specs with data
        self:ShowSpecDataSummary()
    elseif input and input:lower() == "global" then
        -- Implement a switch back to global storage if needed
        self:Debug("Switched to global storage (not implemented)")
    elseif input and input:lower() == "char" then
        self:Debug("Already using character-specific storage")
    else
        -- Show storage information
        self:Debug("Current storage mode: character-specific with spec separation")
        self:Debug("Current spec Index: " .. tostring(self:GetCurrentSpecIndex()))
        self:Debug("Use '/nagstorage clearspec' to clear current spec data")
        self:Debug("Use '/nagstorage listspecs' to list all specs with data")
        self:Debug("Use '/nagstorage global' to switch to global (not implemented)")
        self:Debug("Use '/nagstorage char' to switch to character-specific")
        self:Debug("Use '/nagspecdata' to view spec-specific spell data")
    end
end

--- Handle /nagspecdata command
--- @param self SpellLearnerStateManager
--- @param input string The command input
function SpellLearnerStateManager:HandleSpecDataCommand(input)
    if not input or input == "" then
        -- Show summary of specs with data
        self:ShowSpecDataSummary()
    else
        -- Parse input for spell ID and optional spec index
        local args = { strsplit(" ", input) }
        local spellID = tonumber(args[1])
        local specIndex = args[2] and args[2]:lower() == "all" and "all" or tonumber(args[2])

        if spellID then
            if specIndex == "all" then
                -- Show data from all specs
                self:ShowSpellDataAllSpecs(spellID)
            else
                -- Show data for specific spell and spec
                self:ShowSpellData(spellID, specIndex)
            end
        else
            self:Debug("Please provide a valid spell ID")
        end
    end
end

-- Add function to show spec data summary
function SpellLearnerStateManager:ShowSpecDataSummary()
    self:Debug("|cFF00FF00===== Spec Data Summary =====|r")

    local specStorage = self.db.char.specStorage
    if not next(specStorage) then
        self:Debug("No spec-specific data found")
        return
    end

    local specCount = 0
    for specIndex, storage in pairs(specStorage) do
        specCount = specCount + 1

        -- Get spec name using our safe function
        local specName = self:SafeGetSpecName(specIndex)

        -- Count data entries
        local spellCount = 0
        if storage.spellCosts then
            for _ in pairs(storage.spellCosts) do
                spellCount = spellCount + 1
            end
        end

        local runeCount = 0
        if storage.runeCosts then
            for _ in pairs(storage.runeCosts) do
                runeCount = runeCount + 1
            end
        end

        local effectCount = 0
        if storage.spellEffects then
            for _ in pairs(storage.spellEffects) do
                effectCount = effectCount + 1
            end
        end

        -- Show spec summary
        if self.debug then
            self:Debug("Spec %d (%s): %d spells, %d rune profiles, %d effects", specIndex, specName,
                spellCount, runeCount, effectCount)
        end
    end

    if specCount == 0 then
        self:Debug("No spec-specific data found")
    end

    self:Debug("\nUse '/nagspecdata <spellID>' to see data for a specific spell in current spec")
    self:Debug("Use '/nagspecdata <spellID> all' to see data for a specific spell in all specs")
end

-- Add function to show spell data from all specs
function SpellLearnerStateManager:ShowSpellDataAllSpecs(spellID)
    if not spellID then
        self:Debug("Please provide a valid spell ID")
        return
    end

    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local spellName = spellInfo and spellInfo.name or "Unknown"
    if self.debug then self:Debug("|cFF00FF00===== Data for %s (ID: %d) [All Specs] =====|r", spellName, spellID) end

    local specStorage = self.db.char.specStorage
    if not next(specStorage) then
        self:Debug("No spec-specific data found")
        return
    end

    local foundData = false
    for specIndex, storage in pairs(specStorage) do
        -- Get spec name using our safe function
        local specName = self:SafeGetSpecName(specIndex)

        -- Check if this spec has data for this spell
        local hasData = false
        if storage.spellCosts and storage.spellCosts[spellID] then hasData = true end
        if storage.runeCosts and storage.runeCosts[spellID] then hasData = true end
        if storage.spellEffects and storage.spellEffects[spellID] then hasData = true end
        if storage.resourceGeneration and storage.resourceGeneration[spellID] then hasData = true end

        if hasData then
            foundData = true
            if self.debug then self:Debug("\n|cFFFFFF00Spec: %s (Index: %d)|r", specName, specIndex) end

            -- Show resource costs
            if storage.spellCosts and storage.spellCosts[spellID] then
                self:Debug("Resource Costs:")
                for powerType, data in pairs(storage.spellCosts[spellID]) do
                    if data.confidence and data.confidence > 0 then
                        if self.debug then
                            self:Debug("  %s: %d (Confidence: %.1f%%)", powerType,
                                data.consistentValue or 0, (data.confidence or 0) * 100)
                        end
                    end
                end
            end

            -- Show rune costs (brief summary)
            if storage.runeProfiles and storage.runeProfiles[spellID] then
                self:Debug("Rune Costs: Available")
            end

            -- Show effects (brief summary)
            if storage.spellEffects and storage.spellEffects[spellID] then
                self:Debug("Effects: Available")
            end

            -- Show resource generation (brief summary)
            if storage.resourceGeneration and storage.resourceGeneration[spellID] then
                self:Debug("Resource Generation: Available")
            end
        end
    end

    if not foundData then
        self:Debug("No data found for this spell in any spec")
    end

    self:Debug("\nUse '/nagspecdata <spellID> <specIndex>' to see detailed data for a specific spec")
end

-- Add this helper function after GetCurrentSpecIndex
function SpellLearnerStateManager:SafeGetSpecName(specIndex)
    if not specIndex or specIndex <= 0 then
        return "Unknown"
    end
    -- Use SpecCompat to get spec name from specIndex
    local specName = SpecCompat and SpecCompat:GetSpecName(specIndex)
    if specName and specName ~= "" then
        return specName
    end
    return "Spec " .. specIndex
end

-- Add this helper function to check if we should trigger spell learning
function SpellLearnerStateManager:ShouldTriggerSpellLearning()
    -- Check if player is in combat
    if not UnitAffectingCombat("player") then
        self:Debug("|cFFFFFF00[SPELL LEARNING] Skipping - player not in combat|r")
        return false
    end

    -- Check if player has a target
    if not UnitExists("target") then
        self:Debug("|cFFFFFF00[SPELL LEARNING] Skipping - no target|r")
        return false
    end

    -- Check if target is hostile
    if not UnitCanAttack("player", "target") then
        self:Debug("|cFFFFFF00[SPELL LEARNING] Skipping - target not hostile|r")
        return false
    end

    -- Check distance using CheckInteractDistance (more reliable than map position)
    -- CheckInteractDistance with index 2 (TRADE) is approximately 11.11 yards
    -- We want within 12 yards, so this should work
    if not CheckInteractDistance("target", 2) then
        self:Debug("|cFFFFFF00[SPELL LEARNING] Skipping - target too far (>12 yards)|r")
        return false
    end

    return true
end

-- Add helper function to get spellChanges database for testing (character-specific)
function SpellLearnerStateManager:GetSpellChanges()
    local spellChanges = self.db.char.spellChanges
    if spellChanges == nil then
        -- Database not ready, return nil to signal inaccessibility
        return nil
    end
    -- Database ready, return the table (empty or with data)
    return spellChanges
end
