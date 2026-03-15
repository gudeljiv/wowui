--- @module "NAG.ShamanWeaveModule"
--- Module for Shaman weave optimization
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
local UnitAttackSpeed = _G.UnitAttackSpeed
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitLevel = _G.UnitLevel
local GetNumCompanions = _G.GetNumCompanions
local GetCompanionInfo = _G.GetCompanionInfo
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
--- @type DataManager
local StateManager, DataManager
local WoWAPI = ns.WoWAPI
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID

--- @type OptionsFactory
--- @type TimerManager
local OptionsFactory, TimerManager

--- @type SpecCompat
local SpecCompat



local L = LibStub("AceLocale-3.0"):GetLocale("NAG")


-- Initialize swing timer library
local swingTimerLib = LibStub("LibClassicSwingTimerAPI")

-- Constants
local LIGHTNING_BOLT_ID = 403
local CHAIN_LIGHTNING_ID = 421        -- Chain Lightning spell ID
local MAX_WEAVE_TIME = 3.0
local SNAKE_SPELL_ID = 10713          -- Snake companion spell ID
local PET_SYNC_CHECK_INTERVAL = 4.0   -- Check every 4 seconds
local PET_SYNC_ATTEMPT_COOLDOWN = 1.0 -- Minimum time between sync attempts
local PET_SYNC_GRACE_PERIOD = 0.5     -- Grace period after summoning/dismissing
local MIN_SWINGS_FOR_GRACE = 3        -- Minimum number of swings before checking sync again
local MIN_TTD_FOR_SYNC = 15.0         -- Minimum time to death for sync to be worth it
local MIN_ENEMIES_FOR_CL = 2          -- Minimum number of enemies to switch to Chain Lightning
local MAX_SNAKE_SUMMON_ATTEMPTS = 4   -- Maximum number of snake summon attempts before warning
local WARNING_COOLDOWN = 300          -- 5 minutes in seconds
local WEAPON_SPEED_THRESHOLD = 0.1    -- Maximum difference in weapon speeds to allow sync
local MIN_OFFHAND_SPEED = 0.5         -- Minimum offhand weapon speed
local MAX_OFFHAND_SPEED = 5.0         -- Maximum offhand weapon speed

-- Specialization constants
local ENHANCEMENT_SPEC_INDEX = 2 -- Enhancement spec index (specIndex 2 for Shaman)

-- Default settings
local defaults = {
    class = {
        enabled = true,
        enablePetSync = true,
        petSyncThreshold = 0.1, -- Default threshold for sync
        petSyncCooldown = 5.0,  -- Configurable cooldown
        minTTDForSync = 15.0,
        graceSwingCount = 3,
        syncOnTargetChange = true,
        syncInCombatOnly = true,
        debugSync = false,

        barScale = 1.0,
    }
}

--- @class ShamanWeaveModule:CoreModule
local ShamanWeaveModule = NAG:CreateModule("ShamanWeaveModule", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "SHAMAN",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.CLASS,
        ns.DEBUG_CATEGORIES.FEATURES
    },
    -- ZERO-BOILERPLATE: Declarative event and message handlers
    eventHandlers = {
        -- PLAYER_LEVEL_UP removed - handled via NAG_SPEC_UPDATED from SpecCompat
        PLAYER_REGEN_DISABLED = "OnCombatStateChanged", -- Combat start
        PLAYER_REGEN_ENABLED = "OnCombatStateChanged",  -- Combat end
        PLAYER_TARGET_CHANGED = true,
    },
    cleuHandlers = {
        SWING_DAMAGE = "HandleCLEU",
        SWING_MISSED = "HandleCLEU",
    },
    messageHandlers = {
        NAG_SPEC_UPDATED = true,
    },
    defaultState = {
        -- Pet sync state
        currentSwingDifference = 0,                  -- Current measured swing difference
        needsSync = false,                           -- Flag indicating if we need to sync
        lastSyncTime = 0,                            -- When we last performed a sync
        graceSwingCount = 0,                         -- Number of swings since last sync
        lastSwingTime = 0,                           -- Time of last swing
        isInGracePeriod = false,                     -- Whether we're in the grace period
        snakeSummonAttempts = 0,                     -- Number of snake summon attempts in current combat
        lastSnakeWarningTime = -WARNING_COOLDOWN,    -- Time of last snake warning
        lastTargetChangeTime = -WARNING_COOLDOWN,    -- Time of last target change
        lastMissingSnakeWarning = -WARNING_COOLDOWN, -- Time of last missing snake warning
        lastDesyncWarning = -WARNING_COOLDOWN,       -- Time of last desync warning
        snakeAvailable = nil,                        -- nil = unknown, true = available, false = not available
        lastSnakeAvailabilityCheck = 0               -- When we last checked for snake availability
    }
})
-- Add module to namespace
ns.ShamanWeaveModule = ShamanWeaveModule
local module = ShamanWeaveModule

-- Runtime (non-DB) state: keep module enabled so it can react to spec swaps via NAG_SPEC_UPDATED.
-- When not Enhancement, we simply no-op all behavior.
module.isEnhancementSpec = false

function ShamanWeaveModule:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    StateManager = NAG:GetModule("StateManager")
    DataManager = NAG:GetModule("DataManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = NAG:GetModule("TimerManager")
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Check game version - only works in Wrath, Cata, and Mists
    local Version = ns.Version
    if not Version:IsWrath() and not Version:IsCata() and not Version:IsMists() then
        self:Debug("ShamanWeaveModule only works in Wrath, Cata, and Mists - current version not supported")
        self:SetEnabledState(false)
        return
    end

    -- Double check class on initialization
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping initialization")
        -- Disable the module immediately to prevent it from being enabled
        self:SetEnabledState(false)
        return
    end

    -- Check if player is high enough level to have specs
    local playerLevel = UnitLevel("player")
    if playerLevel < 10 then
        self:Debug("Player level too low for specs, skipping initialization")
        self:SetEnabledState(false)
        return
    end


    -- Initialize last known states for change detection
    self.lastKnownStates = {
        difference = 0,
        pendingPetSync = false,
        lastMainHandSwing = 0,
        lastPetSync = 0,
        isReady = false
    }

    -- ZERO-BOILERPLATE: Events and messages are automatically registered via declarative patterns

    -- Initial spec check
    self:CheckSpecialization()
end

function ShamanWeaveModule:NAG_SPEC_UPDATED(message)
    -- Only process if spec change was successful
    self:CheckSpecialization()
end

function ShamanWeaveModule:CheckSpecialization()
    -- Check if player is high enough level to have specs
    local playerLevel = UnitLevel("player")
    if playerLevel < 10 then
        -- Keep module enabled so it can react once specs become available (e.g. level-up to 10).
        self.isEnhancementSpec = false
        return
    end

    -- Check if specialization is available using SpecCompat
    if not SpecCompat then
        -- Keep module enabled so it can recover when SpecCompat becomes available.
        self.isEnhancementSpec = false
        return
    end
    local specStatus = SpecCompat:GetSpecializationStatus()
    if not specStatus or not specStatus.available then
        -- Keep module enabled so it can react when specs become available (login/spec swap timing).
        self.isEnhancementSpec = false
        return
    end

    local specIndex = specStatus.specIndex
    if not specIndex then
        -- Spec unknown right now (can happen briefly). Keep behavior disabled until known.
        self.isEnhancementSpec = false
        return
    end
    local isEnh = (specIndex == ENHANCEMENT_SPEC_INDEX)
    if self.isEnhancementSpec ~= isEnh then
        self.isEnhancementSpec = isEnh
        self:Debug("Spec state changed: Enhancement=%s", tostring(isEnh))
        -- Reset runtime sync state on spec transitions (both directions) to avoid stale behavior.
        self:ResetPetSyncState()
        if isEnh then
            -- Warm cache so the first desync can trigger immediately after swap.
            self:CheckSnakeAvailability()
        end
    end
end

function ShamanWeaveModule:ResetPetSyncState()
    self.defaultState.pendingPetSync = false
    self.defaultState.lastPetSync = 0
    self.defaultState.lastDismissalTime = 0
    self.defaultState.lastSyncAttempt = 0
    self.defaultState.isSummoning = false
    self.defaultState.currentTarget = nil
    self.defaultState.lastStateChangeTime = 0
    self.defaultState.syncCheckActive = false
    self.defaultState.snakeAvailable = nil  -- Reset snake availability check
    self.defaultState.lastSnakeAvailabilityCheck = 0

    -- Reset last known states
    self.lastKnownStates.difference = 0
    self.lastKnownStates.pendingPetSync = false
    self.lastKnownStates.lastMainHandSwing = self.defaultState.lastMainHandSwing
    self.lastKnownStates.lastPetSync = self.defaultState.lastPetSync
    self.lastKnownStates.isReady = false

    -- Cancel existing timer if any
    if self.defaultState.syncCheckTimer then
        TimerManager:Cancel(self.defaultState.syncCheckTimer)
        self.defaultState.syncCheckTimer = nil
    end

    self:Debug("[ResetPetSyncState] Pet sync state reset")
end

function ShamanWeaveModule:StartSyncCheckTimer()
    -- Cancel existing timer if any
    if self.defaultState.syncCheckTimer then
        TimerManager:Cancel(self.defaultState.syncCheckTimer)
        self.defaultState.syncCheckTimer = nil
    end

    -- Set the current time as the reference point
    local now = GetTime()
    self.defaultState.lastStateChangeTime = now
    self.defaultState.syncCheckActive = false

    -- Start a new timer for periodic sync checks
    self.defaultState.syncCheckTimer = TimerManager:Create(
        TimerManager.Categories.COMBAT,
        "PetSyncCheck",
        function()
            self:CheckWeaponSync()
        end,
        PET_SYNC_CHECK_INTERVAL, -- Check exactly every 4 seconds
        true                     -- Repeating
    )

    if self.debug then
        self:Debug("[StartSyncCheckTimer] Started sync timer - first check at %.1f",
            now + PET_SYNC_CHECK_INTERVAL)
    end
end

function ShamanWeaveModule:IsSyncOperationAllowed()
    local now = GetTime()
    local timeSinceLastAttempt = now - self.defaultState.lastSyncAttempt

    if timeSinceLastAttempt < PET_SYNC_ATTEMPT_COOLDOWN then
        if self.debug then
            self:Debug("[IsSyncOperationAllowed] Too soon since last attempt (%.2f seconds ago)",
                timeSinceLastAttempt)
        end
        return false
    end

    if self.defaultState.isSummoning then
        self:Debug("[IsSyncOperationAllowed] Summon already in progress")
        return false
    end

    return true
end

function ShamanWeaveModule:GetWeaponSpeeds()
    local mhSpeed = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed = swingTimerLib:UnitSwingTimerInfo("player", "offhand")
    return mhSpeed, ohSpeed
end

function ShamanWeaveModule:CheckWeaponSpeeds()
    local mhSpeed, ohSpeed = self:GetWeaponSpeeds()

    if not mhSpeed or not ohSpeed then
        return false
    end

    -- If offhand is a shield (speed = 0), don't sync but allow weaving
    if ohSpeed == 0 then
        return false
    end

    local speedDifference = math.abs(mhSpeed - ohSpeed)
    return speedDifference <= WEAPON_SPEED_THRESHOLD
end

function ShamanWeaveModule:CheckSnakeAvailability()
    local now = GetTime()
    local timeSinceLastCheck = now - self.defaultState.lastSnakeAvailabilityCheck

    -- Only check availability every 30 seconds to avoid excessive API calls
    if timeSinceLastCheck < 30 then
        return self.defaultState.snakeAvailable
    end

    self.defaultState.lastSnakeAvailabilityCheck = now

    local spellInfo = WoWAPI.GetSpellInfo(SNAKE_SPELL_ID)
    local snakeName = spellInfo and spellInfo.name
    if not snakeName then
        self.defaultState.snakeAvailable = false
        self:Debug("[CheckSnakeAvailability] Snake spell not found")
        return false
    end

    -- Check if snake is in companion list
    local numCompanions = GetNumCompanions("CRITTER")
    if numCompanions and type(numCompanions) == "number" and numCompanions > 0 then
        for i = 1, numCompanions do
            local name = select(2, GetCompanionInfo("CRITTER", i))
            if name == snakeName then
                self.defaultState.snakeAvailable = true
                self:Debug("[CheckSnakeAvailability] Snake companion found")
                return true
            end
        end
    end

    self.defaultState.snakeAvailable = false
    self:Debug("[CheckSnakeAvailability] Snake companion not found in list")
    return false
end

function ShamanWeaveModule:ShouldSkipSyncChecks()
    -- Smart early exit: if snake is not available and not time to recheck, skip all sync logic
    if self.defaultState.snakeAvailable == false then
        local now = GetTime()
        local timeSinceLastCheck = now - self.defaultState.lastSnakeAvailabilityCheck
        -- Only skip if we've checked recently (within 30 seconds)
        if timeSinceLastCheck < 30 then
            return true
        end
    end
    return false
end

function ShamanWeaveModule:CheckWeaponSync()
    if not self.isEnhancementSpec then
        return
    end
    if not self.db.class.enablePetSync then
        return
    end

    if not UnitAffectingCombat("player") then
        return
    end


    -- Check if weapons have different speeds
    if not self:CheckWeaponSpeeds() then
        self:Debug("[CheckWeaponSync] Weapons have different speeds, disabling auto-sync")
        return
    end

    local now = GetTime()
    local timeSinceStateChange = now - self.defaultState.lastStateChangeTime
    local timeSinceLastDismissal = now - self.defaultState.lastDismissalTime

    -- Only check for sync if it's been at least 4 seconds since combat entry or target change
    if timeSinceStateChange < PET_SYNC_CHECK_INTERVAL then
        if self.debug then
            self:Debug("[CheckWeaponSync] Waiting for initial delay (%.1f seconds remaining)",
                PET_SYNC_CHECK_INTERVAL - timeSinceStateChange)
        end
        return
    end

    -- Don't check if we recently dismissed the pet
    if timeSinceLastDismissal < PET_SYNC_CHECK_INTERVAL then
        if self.debug then
            self:Debug("[CheckWeaponSync] Recently dismissed pet (%.1f seconds ago), skipping check",
                timeSinceLastDismissal)
        end
        return
    end

    -- Check if we're allowed to perform sync operations
    if not self:IsSyncOperationAllowed() then
        return
    end

    -- If this is the first check after the delay, note that checks are now active
    if not self.defaultState.syncCheckActive then
        self:Debug("[CheckWeaponSync] Initial delay complete, beginning sync checks")
        self.defaultState.syncCheckActive = true
    end

    local difference = NAG:SwingTimeDifference()
    local absDifference = math.abs(difference)

    if self.debug then
        self:Debug(
            "[CheckWeaponSync] Checking weapon sync: difference = %.3f, abs difference = %.3f, threshold = %.3f, pendingPetSync = %s",
            difference, absDifference, self.db.class.petSyncThreshold, tostring(self.defaultState.pendingPetSync))
    end

    -- Set the flag first before any operations
    if absDifference > self.db.class.petSyncThreshold and not self.defaultState.pendingPetSync then
        -- Set the flag before dismissing to prevent race conditions
        self.defaultState.pendingPetSync = true
        if self.debug then
            self:Debug("[CheckWeaponSync] Weapons out of sync (abs diff: %.3f) - Set pendingPetSync flag",
                absDifference)
        end

        -- Update tracking times
        self.defaultState.lastDismissalTime = now
        self.defaultState.lastSyncAttempt = now

        -- Dismiss current companion if any
        DismissCompanion("CRITTER")
        self:Debug("[CheckWeaponSync] Dismissed current companion")
    end
end

function ShamanWeaveModule:ModuleEnable()
    -- Double check class on enable

    -- Check game version - only works in Wrath, Cata, and Mists
    local Version = ns.Version
    if not Version:IsWrath() and not Version:IsCata() and not Version:IsMists() then
        self:Debug("ShamanWeaveModule only works in Wrath, Cata, and Mists - current version not supported")
        self:SetEnabledState(false)
        return
    end

    -- ============================ MODULE INITIALIZATION ============================
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping enable")
        -- Disable the module to prevent further enable attempts
        self:SetEnabledState(false)
        return
    end

    -- Keep module enabled across specs so it continues receiving NAG_SPEC_UPDATED.
    -- Actual behavior is gated by self.isEnhancementSpec.
    self:CheckSpecialization()

    -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns

    -- Only initialize runtime behavior if Enhancement is active.
    if self.isEnhancementSpec then
        self:ResetPetSyncState()
        self:CheckSnakeAvailability()
    end
end

function ShamanWeaveModule:ModuleDisable()
    self:Debug("Disabling ShamanWeaveModule")

    -- ZERO-BOILERPLATE: Events are automatically unregistered via declarative patterns

    -- Reset pet sync state on disable
    self:ResetPetSyncState()
end

--- Returns the universal scale for all Shaman bar UIs.
--- @return number Scale factor (default 1)
function ShamanWeaveModule:GetShamanBarScale()
    return self.db.class.barScale or 1
end

function ShamanWeaveModule:GetOptions()
    return {
        type = "group",
        name = L["Auto Weapon Sync"] or "Auto Weapon Sync",
        order = 25,
        childGroups = "tab",
        width = "full",
        args = {
            barScale = {
                type = "range",
                name = L["Shaman bars scale"] or "Shaman bars scale",
                desc = L["Scale all Shaman UI bars (weave bar, weapon sync bar)."] or
                    "Scale all Shaman UI bars (weave bar, weapon sync bar).",
                min = 0.5,
                max = 2.0,
                step = 0.05,
                get = function() return self.db.class.barScale or 1 end,
                set = function(_, v)
                    self.db.class.barScale = v
                    NAG:SendMessage("NAG_SHAMAN_BAR_SCALE_UPDATED")
                end,
                order = 0,
            },
            generalTab = {
                type = "group",
                name = L["Auto-Sync"] or "Auto-Sync",
                order = 1,
                args = {
                    petSync = {
                        name = L["Pet Sync"],
                        type = "group",
                        inline = true,
                        order = 0,
                        args = {
                            enablePetSync = OptionsFactory:CreateToggle(
                                L["Enable Pet Sync"] or "Enable Pet Sync",
                                L["Automatically summon pet to help sync weapon swings"] or "Automatically summon pet to help sync weapon swings",
                                function(info) return self:GetSetting("class", "enablePetSync") end,
                                function(info, value) self:SetSetting("class", "enablePetSync", value) end,
                                { width = "full", order = 1 }
                            ),
                            petSyncThreshold = OptionsFactory:CreateRange(
                                L["Sync Threshold"] or "Sync Threshold",
                                L["Minimum weapon desync time to trigger pet summon"] or "Minimum weapon desync time to trigger pet summon",
                                function(info) return self:GetSetting("class", "petSyncThreshold") end,
                                function(info, value) self:SetSetting("class", "petSyncThreshold", value) end,
                                { min = 0.05, max = 0.5, step = 0.01, order = 2 }
                            ),
                            petSyncCooldown = OptionsFactory:CreateRange(
                                L["Sync Cooldown"] or "Sync Cooldown",
                                L["Minimum time between pet syncs (seconds)"] or "Minimum time between pet syncs (seconds)",
                                function(info) return self:GetSetting("class", "petSyncCooldown") end,
                                function(info, value) self:SetSetting("class", "petSyncCooldown", value) end,
                                { min = 1, max = 30, step = 1, order = 3 }
                            ),
                            minTTDForSync = OptionsFactory:CreateRange(
                                L["Minimum TTD"] or "Minimum TTD",
                                L["Minimum time to death required to attempt sync"] or "Minimum time to death required to attempt sync",
                                function(info) return self:GetSetting("class", "minTTDForSync") end,
                                function(info, value) self:SetSetting("class", "minTTDForSync", value) end,
                                { min = 5, max = 30, step = 1, order = 4 }
                            ),
                            graceSwingCount = OptionsFactory:CreateRange(
                                L["Grace Swings"] or "Grace Swings",
                                L["Number of swings to wait after sync or target change"] or "Number of swings to wait after sync or target change",
                                function(info) return self:GetSetting("class", "graceSwingCount") end,
                                function(info, value) self:SetSetting("class", "graceSwingCount", value) end,
                                { min = 1, max = 10, step = 1, order = 5 }
                            ),
                            syncHeader = OptionsFactory:CreateHeader(
                                L["Sync Behavior"],
                                { order = 6 }
                            ),
                            syncOnTargetChange = OptionsFactory:CreateToggle(
                                L["Sync on Target Change"] or "Sync on Target Change",
                                L["Reset sync state when changing targets"] or "Reset sync state when changing targets",
                                function(info) return self:GetSetting("class", "syncOnTargetChange") end,
                                function(info, value) self:SetSetting("class", "syncOnTargetChange", value) end,
                                { order = 7 }
                            ),
                            syncInCombatOnly = OptionsFactory:CreateToggle(
                                L["Combat Only"] or "Combat Only",
                                L["Only attempt sync while in combat"] or "Only attempt sync while in combat",
                                function(info) return self:GetSetting("class", "syncInCombatOnly") end,
                                function(info, value) self:SetSetting("class", "syncInCombatOnly", value) end,
                                { order = 8 }
                            ),
                            debugHeader = OptionsFactory:CreateHeader(
                                L["Debug Options"],
                                { order = 9 }
                            ),
                            debugSync = OptionsFactory:CreateToggle(
                                L["Debug Sync"] or "Debug Sync",
                                L["Show detailed debug messages for sync operations"] or "Show detailed debug messages for sync operations",
                                function(info) return self:GetSetting("class", "debugSync") end,
                                function(info, value) self:SetSetting("class", "debugSync", value) end,
                                { order = 10 }
                            )
                        }
                    }
                }
            }
        }
    }
end

function ShamanWeaveModule:ShouldUseChainLightning()
    -- Only check in combat and with a target
    if not UnitAffectingCombat("player") or not UnitExists("target") then
        return false
    end

    -- Count enemies in range (using 10 yards as default range for Chain Lightning)
    local enemies = NAG:CountEnemiesInRange(10)

    -- Get weapon speed and cast times
    local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
    local lbCastTime = NAG:SpellCastTime(LIGHTNING_BOLT_ID)
    local clCastTime = NAG:SpellCastTime(CHAIN_LIGHTNING_ID)

    -- Check if we should use CL based on enemy count
    local shouldUseCLForEnemies = enemies >= MIN_ENEMIES_FOR_CL

    -- Check if we should use CL based on cast times
    local shouldUseCLForCastTime = lbCastTime + 0.1 > weaponSpeed and clCastTime < weaponSpeed

    -- Return true if either condition is met
    return shouldUseCLForEnemies or shouldUseCLForCastTime
end

function ShamanWeaveModule:IsOffhandSpeedValid()
    local ohSpeed = swingTimerLib:UnitSwingTimerInfo("player", "offhand")
    if not ohSpeed then return false end

    -- If offhand is a shield (speed = 0), it's valid for weaving but not for sync
    if ohSpeed == 0 then return true end

    return ohSpeed >= MIN_OFFHAND_SPEED and ohSpeed <= MAX_OFFHAND_SPEED
end

function ShamanWeaveModule:OnCombatStateChanged(event)
    if not self.isEnhancementSpec then
        return
    end
    if UnitAffectingCombat("player") then
        -- Entered combat
        -- Reset sync state
        self.defaultState.currentSwingDifference = 0
        self.defaultState.needsSync = false
        self.defaultState.lastSyncTime = 0
        self.defaultState.graceSwingCount = 0
        self.defaultState.lastSwingTime = GetTime()
        self.defaultState.isInGracePeriod = false

        self:Debug("[OnCombatStateChanged] Combat started, reset sync state")
    else
        -- Left combat
        -- Reset sync state
        self.defaultState.currentSwingDifference = 0
        self.defaultState.needsSync = false
        self.defaultState.lastSyncTime = 0
        self.defaultState.graceSwingCount = 0
        self.defaultState.lastSwingTime = 0
        self.defaultState.isInGracePeriod = false
    end
end

--- Handle centralized CLEU events from EventManager.
--- EventManager already reads CombatLogGetCurrentEventInfo() and forwards payload args.
function ShamanWeaveModule:HandleCLEU(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18,
    arg19, arg20, arg21, arg22, arg23, arg24)
    if not self.isEnhancementSpec then
        return
    end
    -- Only process events from the player
    if sourceGUID ~= NAG.state.player.guid then return end

    -- Only handle swing events
    if subEvent ~= "SWING_DAMAGE" and subEvent ~= "SWING_MISSED" then return end

    local currentTime = GetTime()

    -- Smart early exit: skip all sync logic if snake is unavailable and not time to recheck
    if self:ShouldSkipSyncChecks() then
        return
    end

    -- Debug weapon speeds only when debug is enabled
    if self.db.class.debugSync and self.debug then
        local mhSpeed, ohSpeed = self:GetWeaponSpeeds()
        self:Trace("[Swing] Main Hand: %.2f, Off Hand: %.2f, Difference: %.2f",
            mhSpeed or 0, ohSpeed or 0,
            mhSpeed and ohSpeed and math.abs(mhSpeed - ohSpeed) or 0)
    end

    -- Check if weapons have compatible speeds for sync
    if not self:CheckWeaponSpeeds() then
        if self.db.class.debugSync and self.debug then
            self:Debug("[COMBAT_LOG] Weapons have different speeds, disabling sync operations")
        end
        -- Reset sync state since we can't sync different speed weapons
        self.defaultState.needsSync = false
        self.defaultState.isInGracePeriod = false
        self.defaultState.graceSwingCount = 0
        return
    end

    if self.db.class.debugSync and self.debug then
        self:Trace("[COMBAT_LOG] Swing detected! needsSync = %s, graceSwingCount = %d",
            tostring(self.defaultState.needsSync), self.defaultState.graceSwingCount)
    end

    -- Update swing time
    self.defaultState.lastSwingTime = currentTime

    -- Handle grace period
    if self.defaultState.isInGracePeriod then
        self.defaultState.graceSwingCount = self.defaultState.graceSwingCount + 1
        if self.defaultState.graceSwingCount >= self.db.class.graceSwingCount then
            if self.db.class.debugSync and self.debug then
                self:Debug("[COMBAT_LOG] Grace period ended")
            end
            self.defaultState.isInGracePeriod = false
            self.defaultState.graceSwingCount = 0
        end
        return
    end

    local ttd = NAG:RemainingTime()

    -- Handle sync attempt if needed
    if self.defaultState.needsSync and
       (currentTime - self.defaultState.lastSyncTime) >= self.db.class.petSyncCooldown then

        if ttd >= self.db.class.minTTDForSync then
            if self.db.class.debugSync and self.debug then
                self:Debug("[COMBAT_LOG] Target TTD (%.1f) sufficient for sync", ttd)
            end
            self:TrySummonPet()
        else
            if self.db.class.debugSync and self.debug then
                self:Debug("[COMBAT_LOG] Target TTD (%.1f) too low for sync", ttd)
            end
            self.defaultState.needsSync = false
        end
        return
    end

    -- Check for new sync need if not in grace period and not already needing sync
    if not self.defaultState.isInGracePeriod and not self.defaultState.needsSync then
        if ttd < self.db.class.minTTDForSync then
            if self.db.class.debugSync and self.debug then
                self:Debug("[COMBAT_LOG] Target TTD (%.1f) too low for sync check", ttd)
            end
            return
        end

        local difference = NAG:SwingTimeDifference()
        self.defaultState.currentSwingDifference = difference

        if self.db.class.debugSync and self.debug then
            self:Trace("[COMBAT_LOG] Current swing difference: %.3f, threshold: %.3f",
                difference, self.db.class.petSyncThreshold)
        end

        if math.abs(difference) > self.db.class.petSyncThreshold then
            if self.db.class.debugSync and self.debug then
                self:Debug("[COMBAT_LOG] Weapons out of sync, dismissing pet")
            end
            self.defaultState.needsSync = true
            DismissCompanion("CRITTER")
        end
    end
end

function ShamanWeaveModule:TrySummonPet()
    if not self.isEnhancementSpec then
        return
    end
    if not self.db.class.enablePetSync then
        self:Debug("[TrySummonPet] Pet sync disabled")
        return
    end

    if not self.defaultState.needsSync then
        self:Debug("[TrySummonPet] No sync needed")
        return
    end

    -- Only try to summon if we're in combat and have a target
    if not UnitAffectingCombat("player") or not UnitExists("target") then
        self:Debug("[TrySummonPet] Not in combat or no target")
        return
    end

    -- Check TTD before attempting summon
    local ttd = NAG:RemainingTime()
    if ttd < self.db.class.minTTDForSync then
        if self.debug then self:Debug("[TrySummonPet] Target TTD (%.1f) too low for sync", ttd) end
        self.defaultState.needsSync = false
        return
    end

    -- Check snake availability first
    if not self:CheckSnakeAvailability() then
        -- Snake not available, disable sync and show warning
        self.defaultState.needsSync = false
        self.defaultState.snakeAvailable = false  -- Mark as definitively unavailable

        local now = GetTime()
        if now - self.defaultState.lastMissingSnakeWarning > WARNING_COOLDOWN then
            self.defaultState.lastMissingSnakeWarning = now
            -- Production: avoid chat spam prints. Keep as debug log for investigation.
            self:Debug("Missing Albino Snake companion: pet sync disabled (each character needs its own snake).")
        end
        return
    end

    self:Debug("[TrySummonPet] Attempting to summon pet")

    local spellInfo = WoWAPI.GetSpellInfo(SNAKE_SPELL_ID)
    local snakeName = spellInfo and spellInfo.name
    if not snakeName then
        self:Debug("[TrySummonPet] Failed to find snake spell name")
        self.defaultState.needsSync = false
        return
    end

    -- Find the snake in companion list and summon it
    local foundSnake = false
    local numCompanions = GetNumCompanions("CRITTER")
    if numCompanions and type(numCompanions) == "number" and numCompanions > 0 then
        for i = 1, numCompanions do
            local _, name, _, _, active = GetCompanionInfo("CRITTER", i)
            if name == snakeName then
                foundSnake = true
                self:Debug("[TrySummonPet] Summoning snake")
                CallCompanion("CRITTER", i)

                -- Update state
                self.defaultState.needsSync = false
                self.defaultState.currentSwingDifference = 0
                self.defaultState.lastSyncTime = GetTime()
                self.defaultState.isInGracePeriod = true
                self.defaultState.graceSwingCount = 0
                self.defaultState.snakeSummonAttempts = self.defaultState.snakeSummonAttempts + 1

                self:Debug("[TrySummonPet] Pet summoned, entering grace period")
                break
            end
        end
    end

    -- This should not happen if CheckSnakeAvailability worked correctly, but handle it anyway
    if not foundSnake then
        self:Debug("[TrySummonPet] Snake companion not found in list (this should not happen)")
        self.defaultState.needsSync = false
        self.defaultState.snakeAvailable = false  -- Mark as definitively unavailable
    elseif self.defaultState.snakeSummonAttempts >= MAX_SNAKE_SUMMON_ATTEMPTS then
        -- Check if we've had too many summon attempts without target changes
        local now = GetTime()
        if now - self.defaultState.lastTargetChangeTime > 35 and now - self.defaultState.lastDesyncWarning > WARNING_COOLDOWN then
            self.defaultState.lastDesyncWarning = now
            self.defaultState.snakeSummonAttempts = 0 -- Reset counter after warning
        end
    end
end

function ShamanWeaveModule:PLAYER_TARGET_CHANGED(event, ...)
    if not self.isEnhancementSpec then
        return
    end
    if not UnitAffectingCombat("player") then return end

    local newGuid = select(1, ...)
    local newTarget = newGuid or UnitGUID("target")
    if newTarget ~= self.defaultState.currentTarget then
        if self.debug then
            self:Debug("[PLAYER_TARGET_CHANGED] Target changed from %s to %s",
                tostring(self.defaultState.currentTarget), tostring(newTarget))
        end

        -- Store the new target
        self.defaultState.currentTarget = newTarget
        self.defaultState.lastTargetChangeTime = GetTime()

        -- Reset sync state and enter grace period
        self.defaultState.currentSwingDifference = 0
        self.defaultState.needsSync = false
        self.defaultState.isInGracePeriod = true
        self.defaultState.graceSwingCount = 0
        self.defaultState.snakeSummonAttempts = 0 -- Reset summon attempts on target change

        self:Debug("[PLAYER_TARGET_CHANGED] Entering grace period after target change")
    end
end
