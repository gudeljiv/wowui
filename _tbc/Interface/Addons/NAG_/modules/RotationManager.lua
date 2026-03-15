--- @module "NAG.RotationManager"
--- Module for managing user rotations in NAG
---
--- NOTE: Minimap icon and selector UI logic is being migrated to NAG/modules/MinimapSelector.lua.
--- Please make future changes to minimap/selector UI in the new module to avoid duplication.
---
--- IMPORTANT: During profile system migration, users should export their custom rotations
--- using the export functionality (export icon) and re-import them after migration to preserve
--- their custom rotation configurations.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
local GetTime = _G.GetTime
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitPowerType = _G.UnitPowerType
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsShiftKeyDown = _G.IsShiftKeyDown
local CreateFrame = _G.CreateFrame
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local WoWAPI = ns.WoWAPI
local Version = ns.Version
local StringUtil = ns.StringUtil

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
local StateManager

--- @type ImportExport
--- @type ShareInGame
--- @type SpellbookManager
--- @type TimerManager
local ImportExport, ShareInGame, SpellbookManager, TimerManager

--- @type CacheRefreshManager
local CacheRefreshManager

--- @type table SchemaAccessor
local SchemaAccessor

--- @type SpecCompat
local SpecCompat

--- @type TableUtils|AceModule|CoreModule
local TableUtils = ns.TableUtils
local LearnedPredictionProvider = ns.LearnedPredictionProvider


local pcall = ns.pcall
local L = ns.AceLocale:GetLocale("NAG", true)
local AceGUI = ns.AceGUI

local AceConfigRegistry = ns.AceConfigRegistry

--Libs
local LSM = ns.LibSharedMedia
local StaticPopup_OnClick = StaticPopup_OnClick


-- Lua APIs (using WoW's optimized versions where available)
local format = string.format -- WoW's optimized version if available

local strsub = strsub
local strlower = strlower
local tinsert = tinsert
local wipe = wipe
local tContains = tContains

local sort = table.sort
local pairs = pairs
local ipairs = ipairs
local select = select
local date = date
local tsort = table.sort
local loadstring = loadstring
local debugprofilestop = debugprofilestop

-- ============================ AGGRESSIVE RECOVERY CONSTANTS ============================
-- Independent from AceTimer: detects/recovers stalls within <= 500ms.
-- Soft threshold classifies degraded/stalled states; hard threshold enables forceful recovery.
local ROTATION_SOFT_STALL_THRESHOLD_SEC = 0.65
local ROTATION_HARD_STALL_THRESHOLD_SEC = 1.25
local ROTATION_HEARTBEAT_CHECK_INTERVAL_SEC = 0.05
local ROTATION_HEARTBEAT_IDLE_CHECK_INTERVAL_SEC = 0.25
local ROTATION_RECOVERY_MIN_INTERVAL_SEC = 0.2
local ROTATION_TIMER_RESTART_COOLDOWN_SEC = 5.0
local ROTATION_RECOVERY_FAILURE_BACKOFF_SEC = 1.0
local ROTATION_RECOVERY_FAILURE_BACKOFF_AFTER = 5
local ROTATION_STALL_WINDOWS_BEFORE_RECOVERY = 2
local ROTATION_LIVENESS_RECOVERY_RING_SIZE = 20
local ROTATION_EXECUTION_GUARD_TIMEOUT_SEC = 3.0

-- Helper function to convert various date formats to a display string
local function formatDate(dateValue)
    if not dateValue then
        return L["rotationUnknown"] or "Unknown"
    end
    -- If it's already a string, return it formatted nicely
    if type(dateValue) == "string" then
        -- Try to parse common date formats
        local month, day, year = dateValue:match("(%d+)/(%d+)/(%d+)")
        if month and day and year then
            return format("%s-%s-%s", year, month, day)
        end
        return dateValue
    end
    -- If it's a number (timestamp), format it
    if type(dateValue) == "number" then
        return date("%Y-%m-%d", dateValue)
    end
    return L["rotationUnknown"] or "Unknown"
end

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
local defaults = {
    global = {
        rotationTimerInterval = 0.15,      -- 150ms rotation timer interval
    },
    char = {
        framePosition = {
            point = "CENTER",
            relativePoint = "CENTER",
            x = 0,
            y = 0
        },
        frameSize = {
            width = 1000,
            height = 400
        },
        frameStatus = {},
        showOnlyCurrentSpec = true  -- Default to showing only current spec
    }
}

local DEFAULT_FRAME_ANCHOR = {
    point = "CENTER",
    relativePoint = "CENTER",
    x = 0,
    y = 0
}

local DEFAULT_FRAME_SIZE = {
    width = 1000,
    height = 400
}

---@class RotationManager : CoreModule
--- @class RotationManager
local RotationManager = NAG:CreateModule("RotationManager", defaults, {

    messageHandlers = {
        NAG_ROTATION_CHANGED = true,           -- unified rotation change message
        NAG_DB_RESET = true,               -- database reset events
        NAG_TALENTS_UPDATED = true,        -- talents changed; refresh current spec cache
        NAG_EXPANSION_DATA_LOADED = true,  -- expansion data loaded, safe to precompile rotations
        NAG_SCHEMA_VALIDATOR_READY = true, -- schema validator initialized after schema modifications
        NAG_STARTUP_COMPLETE = true,
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.MANAGERS
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        -- OLD FORMAT (backward compatibility):
        ["rot"] = {
            handler = "Toggle",
            help = "Toggle the rotation manager UI. Use export functionality to save custom rotations before profile migration.",
            root = "nag",
            category = "Rotation"
        },
        ["validateall"] = {
            handler = "ValidateAllRotations",
            help = "Validate all registered rotations and print a summary.",
            root = "nagdebug",
            category = "Rotation"
        },

        -- NEW HIERARCHICAL FORMAT:
        ["rotation_toggle"] = {
            handler = "Toggle",
            help = "Toggle the rotation manager UI. Use export functionality to save custom rotations before profile migration.",
            root = "nag",
            path = {"rotation", "toggle"},
            category = "Rotation"
        },
        ["rotation_validate"] = {
            handler = "ValidateAllRotations",
            help = "Validate all registered rotations and print a summary.",
            root = "nagdebug",
            path = {"rotation", "validate"},
            category = "Rotation"
        },
        ["rotation_spells"] = {
            handler = "FormatAllRotationSpells",
            help = "Display all spells/items extracted from all rotations. Usage: /nagdebug rotation spells [short|full]",
            root = "nagdebug",
            path = {"rotation", "spells"},
            category = "Rotation"
        },
        ["rotation_edit"] = {
            handler = "EditCurrentRotation",
            help = "Open the rotation editor for the currently selected rotation.",
            root = "nag",
            path = {"rotation", "edit"},
            category = "Rotation"
        },
        ["rotation_export"] = {
            handler = "OpenStandaloneExport",
            help = "Open the standalone rotation export browser.",
            root = "nag",
            path = {"rotation", "export"},
            category = "Rotation"
        },
        ["stresstest"] = {
            handler = "RunStressTest",
            help = "Run a controlled stress test. Usage: /nag stresstest [iterations=N] [time=S]",
            root = "nag",
            category = "Debug"
        },
        ["rotation_freeze"] = {
            handler = "PrintRotationFreezeStatus",
            help = "Print rotation freeze diagnostic (run when display stops updating)",
            root = "nag",
            path = {"freeze"},
            category = "Debug"
        },
        ["rotation_freeze_dump"] = {
            handler = "PrintRotationFreezeDump",
            help = "Print extended rotation freeze diagnostic snapshot",
            root = "nag",
            path = {"freeze", "dump"},
            category = "Debug"
        },
    }
})
local module = RotationManager
ns.RotationManager = RotationManager

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function RotationManager:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        StateManager = NAG:GetModule("StateManager")
        ImportExport = NAG:GetModule("ImportExport")
        ShareInGame = NAG:GetModule("ShareInGame")
        SpellbookManager = NAG:GetModule("SpellbookManager")
        TimerManager = NAG:GetModule("TimerManager")
        CacheRefreshManager = NAG:GetModule("CacheRefreshManager")
        SchemaAccessor = NAG:GetModule("SchemaAccessor")
        SpecCompat = NAG:GetModule("SpecCompat")
        self.frame = nil
        self.freezeDebugEnabled = true
        self.freezeLastWarn = 0
        self.freezeWarnCooldown = 3
        self.hadValidRotationAtCombatStart = false
        self.freezeWarnedThisCombat = false
        self.combatRotationSnapshot = nil
        self.combatRecoveryEvents = nil
        self.combatRecoveryCooldown = 2
        self.combatRecoveryLastAttempt = 0
        self.combatRecoveryLastWarn = 0
        self.pendingSelectionClears = {}
        self.pendingRotationDisables = {}
        self.pendingRecoveryTimers = {}
        self.lastKnownRotationBySpec = {}
        self.combatWatchdogRecoveries = 0
        self.watchdogStallRecoveryAttempts = 0   -- count of "attempted recovery" / "recovery failed" this combat
        self.freezeReminderShownThisCombat = false -- one-time reminder to run /nag freeze after several stalls
        -- ============================ AGGRESSIVE RECOVERY (HEARTBEAT) ============================
        self.rotationHeartbeatFrame = nil
        self.rotationHeartbeatEnabled = true
        self.rotationHeartbeatCheckInterval = ROTATION_HEARTBEAT_CHECK_INTERVAL_SEC
        self.rotationSoftStallThreshold = ROTATION_SOFT_STALL_THRESHOLD_SEC
        self.rotationHardStallThreshold = ROTATION_HARD_STALL_THRESHOLD_SEC
        self.rotationStallWindowsBeforeRecovery = ROTATION_STALL_WINDOWS_BEFORE_RECOVERY
        self._rotationHeartbeatAccum = 0
        self._rotationRecoveryLastAttempt = 0
        self._rotationRecoveryRestartLastAttempt = 0
        self._rotationRecoveryConsecutiveFailures = 0
        self._rotationRecoveryBackoffUntil = 0
        self._rotationExpectedCallbackAt = 0
        self._lastTimerRestartAttempt = 0
        self._rotationHeartbeatPerf = {
            ticks = 0,
            combatTicks = 0,
            idleTicks = 0,
            lastReportAt = 0,
        }
        self.rotationExecutingGuardTimeout = ROTATION_EXECUTION_GUARD_TIMEOUT_SEC
        self.rotationLiveness = {
            state = "healthy",
            reason = "module_initialize",
            lastTransitionAt = 0,
            lastHeartbeatTickAt = 0,
            lastCallbackAt = 0,
            lastFinishAt = 0,
            lastEffectiveTickAt = 0,
            consecutiveStallWindows = 0,
            consecutiveRecoveries = 0,
            consecutiveMutexLocks = 0,
            lastRecoveryAt = 0,
            lastSuccessfulPostRecoveryFinish = 0,
            timerRestartCount = 0,
            lastTimerRestartAt = 0,
            lastTimerRestartReason = nil,
            schedulerLastDrift = 0,
            schedulerMaxDrift = 0,
            lastClassification = "healthy",
            lastClassificationReason = "module_initialize",
            lastClassificationSource = "none",
            recoveryEvents = {},
        }
        -- ============================ ROTATION CACHING SYSTEM ============================
        -- Per-rotation caching to eliminate recompilation overhead
        self.rotationCache = {}         -- Cache for compiled rotation functions (TBC/legacy)
        self.rotationASTCache = {}      -- Cache for proto AST (Retail/schema-aware)
        self.rotationCacheMetadata = {} -- Metadata for cache management
        -- Validation behavior: default to on-demand only (no validation on cache-miss)
        self.validateOnCacheMiss = false
        self._hasPrecompiled = false
        self._expansionDataReady = false
        self._schemaValidatorReady = false
        self._precompileState = nil
        self._precompileInProgress = false
        self._precompileDeferred = false
        self._precompileCancelled = false
        self._precompileDeferredOptions = nil
        self.precompileBatchSize = 4
        self.precompileMaxMs = 8

        -- ============================ SPELL EXTRACTION CACHING SYSTEM ============================
        -- Cache for spell IDs extracted from rotation strings to avoid re-extraction
        self.spellExtractionCache = {} -- Cache for extracted spell data by rotation
        self.spellCacheMetadata = {}   -- Metadata for spell cache management

        -- Initialize ShareInGame integration
        self:InitializeShareInGame()
        -- Slash commands are now handled via zero-boilerplate slashCommands table
    end

    function RotationManager:ModuleEnable()
        -- Prevalidate and precompile all rotations once on enable
        -- NOTE: Data-dependent precompile starts from the data-ready startup barrier.

        -- ============================ MODULE INITIALIZATION ============================
        self:StartRotationHeartbeat()
        self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
        self:RegisterEvent("PLAYER_TARGET_CHANGED", "InvalidatePredictionCache")

        -- Late-enable path: initialize immediately if expansion data is already ready.
        self._schemaValidatorReady = self:IsSchemaValidatorReadyForPrecompile()
        if not self:InitializeDataDependentPrecompile("ModuleEnable") then
            self:Debug("ModuleEnable: Startup gates not ready, deferring rotation precompilation")
        end
    end

    function RotationManager:ModuleDisable()
        if self.frame then
            self.frame:Hide()
        end
        self:StopRotationHeartbeat()
        self._precompileCancelled = true
        self._precompileInProgress = false
        self._precompileState = nil
        self._precompileDeferred = false
        self._precompileDeferredOptions = nil
        self.pendingRecoveryTimers = {}
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
        if TimerManager and TimerManager.IsTimerActive and
            TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation_selection_watchdog") then
            TimerManager:Cancel(TimerManager.Categories.ROTATION, "rotation_selection_watchdog")
        end
    end
end

--- Check whether schema validation must block precompile startup.
--- @return boolean ready True if precompile can continue with schema state.
function RotationManager:IsSchemaValidatorReadyForPrecompile()
    local SchemaValidator = NAG:GetModule("SchemaValidator", true)
    if not SchemaValidator then
        return true
    end

    if SchemaValidator.IsValidationDisabled then
        local ok, disabled = pcall(function()
            return SchemaValidator:IsValidationDisabled()
        end)
        if ok and disabled then
            return true
        end
    end

    return SchemaValidator.initialized == true
end

--- Try to start precompilation only when all startup gates are open.
--- @param options table|nil Optional precompile options
--- @return boolean started True if precompile started/completed
function RotationManager:TryStartPrecompile(options)
    if self._hasPrecompiled then
        return true
    end

    self._schemaValidatorReady = self:IsSchemaValidatorReadyForPrecompile()
    if not self._expansionDataReady then
        self:Debug("TryStartPrecompile: Waiting for NAG_EXPANSION_DATA_LOADED")
        return false
    end

    if not self._schemaValidatorReady then
        self:Debug("TryStartPrecompile: Waiting for NAG_SCHEMA_VALIDATOR_READY")
        return false
    end

    local ok = self:StartPrecompileAllRotations(options)
    self._hasPrecompiled = ok and true or false
    return self._hasPrecompiled
end

--- Attempt to start precompile from the data-ready startup boundary.
--- @param source string|nil Source label for debug logging.
--- @return boolean started True if precompile started/completed.
function RotationManager:InitializeDataDependentPrecompile(source)
    local DataManager = NAG:GetModule("DataManager", true)
    if not self._expansionDataReady and DataManager and DataManager.IsDataReady and DataManager:IsDataReady() then
        self._expansionDataReady = true
    end

    local started = self:TryStartPrecompile()
    if self.debug then
        self:Debug("InitializeDataDependentPrecompile: source=%s started=%s dataReady=%s schemaReady=%s",
            tostring(source or "unknown"),
            tostring(started),
            tostring(self._expansionDataReady),
            tostring(self._schemaValidatorReady))
    end
    return started
end

function RotationManager:WarnFreeze(reason, force)
    if not self.freezeDebugEnabled then return end
    if not (UnitAffectingCombat and UnitAffectingCombat("player")) then return end
    if not self.hadValidRotationAtCombatStart and not force then return end
    local now = GetTime()
    if (now - (self.freezeLastWarn or 0)) < self.freezeWarnCooldown then
        return
    end
    self.freezeLastWarn = now
    self.freezeWarnedThisCombat = true
    local message = format("|cFFFF3333[NAG Rotation]|r %s", tostring(reason))
    self:Error(message)
end

--- Appends a compact recovery event to the liveness ring buffer.
--- @param event table
function RotationManager:AppendRecoveryEvent(event)
    local liveness = self.rotationLiveness
    if not liveness then
        return
    end
    if not liveness.recoveryEvents then
        liveness.recoveryEvents = {}
    end
    tinsert(liveness.recoveryEvents, event)
    while #liveness.recoveryEvents > ROTATION_LIVENESS_RECOVERY_RING_SIZE do
        table.remove(liveness.recoveryEvents, 1)
    end
end

--- Updates liveness state and transition metadata.
--- @param now number
--- @param newState string
--- @param reason string
function RotationManager:UpdateLivenessState(now, newState, reason)
    local liveness = self.rotationLiveness
    if not liveness then
        return
    end
    liveness.reason = reason or liveness.reason
    if liveness.state ~= newState then
        liveness.state = newState
        liveness.lastTransitionAt = now
    end
end

--- Computes stall classification using soft/hard thresholds.
--- @param secsSinceEffective number|nil
--- @param secsSinceFinish number|nil
--- @param softThreshold number
--- @param hardThreshold number
--- @return string classification
--- @return string reason
--- @return string source
function RotationManager:ComputeLivenessClassification(secsSinceEffective, secsSinceFinish, softThreshold, hardThreshold)
    local eff = secsSinceEffective or 0
    local fin = secsSinceFinish or 0

    -- Callback/effective gap is the primary freeze signal (timer not firing / no heartbeat kick).
    -- Finish gap alone can happen when callbacks keep firing through a gate; classify that separately.
    if eff >= hardThreshold then
        return "hard_stalled", "callback_gap_hard", "callback"
    end
    if eff >= softThreshold then
        return "stalled", "callback_gap_soft", "callback"
    end

    -- Finish-only stale should not be treated as hard_stalled when callbacks are alive.
    if fin >= hardThreshold then
        return "stalled", "finish_gap_hard", "finish_only"
    end
    if fin >= softThreshold then
        return "degraded", "finish_gap_soft", "finish_only"
    end

    local degradedThreshold = softThreshold * 0.6
    if eff >= degradedThreshold then
        return "degraded", "callback_gap_degraded", "callback"
    end
    if fin >= degradedThreshold then
        return "degraded", "finish_gap_degraded", "finish_only"
    end
    return "healthy", "healthy", "none"
end

--- Determines if recovery should run for current stall evidence.
--- @param classification string
--- @param reason string|nil
--- @param consecutiveWindows number
--- @param requiredWindows number
--- @return boolean
function RotationManager:ShouldAttemptRecoveryForClassification(classification, reason, consecutiveWindows, requiredWindows)
    -- Finish-only staleness usually means callback is alive but rotation completion timestamp lagged.
    -- Keep this as degraded/stalled signal for diagnostics, but avoid hard recovery spam.
    if reason == "finish_gap_hard" or reason == "finish_gap_soft" then
        return false
    end
    if classification == "hard_stalled" then
        return true
    end
    if classification == "stalled" and consecutiveWindows >= (requiredWindows or 2) then
        return true
    end
    return false
end

--- Tracks scheduler drift for rotation callback timing.
--- @param now number
--- @param expectedTime number
function RotationManager:TrackRotationCallbackDrift(now, expectedTime)
    local liveness = self.rotationLiveness
    if not liveness then
        return
    end
    local drift = 0
    if expectedTime and expectedTime > 0 then
        drift = now - expectedTime
        if drift < 0 then
            drift = 0
        end
    end
    liveness.schedulerLastDrift = drift
    if drift > (liveness.schedulerMaxDrift or 0) then
        liveness.schedulerMaxDrift = drift
    end
    NAG.lastRotationCallbackExpectedTime = expectedTime
    NAG.lastRotationCallbackDrift = drift
end

--- Performs deduplicated, throttled rotation timer restart.
--- @param reason string
--- @param now number
--- @return boolean didRestart
function RotationManager:MaybeRestartRotationTimer(reason, now)
    local restartNow = now or GetTime()
    if (restartNow - (self._lastTimerRestartAttempt or 0)) < ROTATION_TIMER_RESTART_COOLDOWN_SEC then
        return false
    end
    self._lastTimerRestartAttempt = restartNow
    if TimerManager then
        TimerManager:Cancel(TimerManager.Categories.ROTATION, "rotation")
    end
    self:StartRotationTimer()
    local liveness = self.rotationLiveness
    if liveness then
        liveness.timerRestartCount = (liveness.timerRestartCount or 0) + 1
        liveness.lastTimerRestartAt = restartNow
        liveness.lastTimerRestartReason = reason
    end
    NAG.lastRotationHeartbeatTimerRestartTime = restartNow
    NAG.lastRotationHeartbeatTimerRestartReason = reason
    return true
end

--- Resets a stale rotation execution guard if it exceeds timeout.
--- @param now number
--- @param source string
--- @return boolean didReset
function RotationManager:CheckRotationExecutionGuardTimeout(now, source)
    if not NAG._rotationExecuting then
        return false
    end
    local startedAt = NAG.lastRotationGuardSetTime or 0
    if startedAt <= 0 then
        return false
    end
    local timeout = self.rotationExecutingGuardTimeout or ROTATION_EXECUTION_GUARD_TIMEOUT_SEC
    if (now - startedAt) < timeout then
        return false
    end
    if NAG.ForceResetRotationExecutionGuard then
        NAG:ForceResetRotationExecutionGuard(source or "rotation_manager")
        self:UpdateLivenessState(now, "hard_stalled", "execution_guard_timeout")
        self:WarnFreeze(format("Execution guard exceeded %.1fs and was reset (%s)", timeout, tostring(source)))
        return true
    end
    return false
end

-- ============================ AGGRESSIVE RECOVERY (HEARTBEAT) ============================

--- Starts the OnUpdate heartbeat used for aggressive stall recovery.
--- This is independent of AceTimer and can recover within <= 500ms even if repeating timers stop firing.
function RotationManager:StartRotationHeartbeat()
    if self.rotationHeartbeatFrame then
        self.rotationHeartbeatFrame:Show()
        return
    end

    local frame = CreateFrame("Frame")
    frame:Hide()
    frame:SetScript("OnUpdate", function(_, elapsed)
        self:OnRotationHeartbeatUpdate(elapsed)
    end)
    self.rotationHeartbeatFrame = frame
    frame:Show()
end

--- Stops the OnUpdate heartbeat.
function RotationManager:StopRotationHeartbeat()
    if not self.rotationHeartbeatFrame then
        return
    end
    self.rotationHeartbeatFrame:SetScript("OnUpdate", nil)
    self.rotationHeartbeatFrame:Hide()
    self.rotationHeartbeatFrame = nil
end

--- Returns current stall information for timer callback and rotation completion.
--- @param now number Current GetTime() value
--- @return number lastCallbackTime
--- @return number lastHeartbeatKickTime
--- @return number lastEffectiveTickTime
--- @return number|nil secsSinceCallback
--- @return number|nil secsSinceEffective
--- @return number|nil secsSinceFinish
function RotationManager:GetRotationStallInfo(now)
    local lastCallbackTime = NAG.lastRotationCallbackTime or 0
    local lastHeartbeatKickTime = NAG.lastRotationHeartbeatKickTime or 0
    local lastEffectiveTickTime = lastCallbackTime
    if lastHeartbeatKickTime > lastEffectiveTickTime then
        lastEffectiveTickTime = lastHeartbeatKickTime
    end
    local lastFinishTime = NAG.lastRotationFinishTime or 0

    local secsSinceCallback = lastCallbackTime > 0 and (now - lastCallbackTime) or nil
    local secsSinceEffective = lastEffectiveTickTime > 0 and (now - lastEffectiveTickTime) or nil
    local secsSinceFinish = lastFinishTime > 0 and (now - lastFinishTime) or nil

    local liveness = self.rotationLiveness
    if liveness then
        liveness.lastCallbackAt = lastCallbackTime
        liveness.lastFinishAt = lastFinishTime
        liveness.lastEffectiveTickAt = lastEffectiveTickTime
    end

    return lastCallbackTime, lastHeartbeatKickTime, lastEffectiveTickTime, secsSinceCallback, secsSinceEffective, secsSinceFinish
end

--- Determines whether aggressive recovery should run (very fast guards).
--- @return boolean
function RotationManager:ShouldRunAggressiveRecovery()
    if not self.rotationHeartbeatEnabled then
        return false
    end
    if not (UnitAffectingCombat and UnitAffectingCombat("player")) then
        return false
    end
    if NAG._rotationExecuting then
        return false
    end
    -- Avoid aggressive recovery unless we had a valid rotation at combat start.
    -- This prevents expensive retries during startup/spec not ready states.
    if not self.hadValidRotationAtCombatStart then
        return false
    end
    return true
end

--- Attempts to recover rotation aggressively (<=500ms) when stalled.
--- Performs a soft kick (NAG:Rotation) and best-effort timer restart.
--- @param reason string
--- @param now number
--- @param secsSinceCallback number|nil
--- @param secsSinceFinish number|nil
function RotationManager:AttemptAggressiveRecovery(reason, now, secsSinceCallback, secsSinceFinish)
    if not self:ShouldRunAggressiveRecovery() then
        return
    end

    -- Re-check just before doing any work; rotation may have started since the earlier guard.
    if NAG._rotationExecuting then
        return
    end

    -- Avoid stacked kicks from multiple recovery sources (heartbeat/event/watchdog).
    if (now - (self._rotationRecoveryLastKickAt or 0)) < 0.05 then
        return
    end
    self._rotationRecoveryLastKickAt = now

    if now < (self._rotationRecoveryBackoffUntil or 0) then
        return
    end

    local minInterval = ROTATION_RECOVERY_MIN_INTERVAL_SEC
    if (now - (self._rotationRecoveryLastAttempt or 0)) < minInterval then
        return
    end
    self._rotationRecoveryLastAttempt = now
    self:UpdateLivenessState(now, "recovering", tostring(reason))

    -- Track that heartbeat is actively kicking rotation (diagnostics only; do not modify lastRotationCallbackTime).
    NAG.lastRotationHeartbeatKickTime = now
    NAG.lastRotationHeartbeatKickCount = (NAG.lastRotationHeartbeatKickCount or 0) + 1

    local okKick, kickErr = pcall(function()
        NAG:Rotation()
    end)

    if not okKick then
        self._rotationRecoveryConsecutiveFailures = (self._rotationRecoveryConsecutiveFailures or 0) + 1
        NAG.lastRotationHeartbeatKickError = tostring(kickErr)
    else
        self._rotationRecoveryConsecutiveFailures = 0
        NAG.lastRotationHeartbeatKickError = nil
        if self.rotationLiveness then
            self.rotationLiveness.lastSuccessfulPostRecoveryFinish = NAG.lastRotationFinishTime or now
        end
    end

    if self._rotationRecoveryConsecutiveFailures >= ROTATION_RECOVERY_FAILURE_BACKOFF_AFTER then
        self._rotationRecoveryBackoffUntil = now + ROTATION_RECOVERY_FAILURE_BACKOFF_SEC
    end

    -- Best-effort: only force timer restart for hard callback stalls.
    local hardThreshold = self.rotationHardStallThreshold or ROTATION_HARD_STALL_THRESHOLD_SEC
    local didRestartTimer = false
    if secsSinceCallback and secsSinceCallback > hardThreshold then
        didRestartTimer = self:MaybeRestartRotationTimer(reason, now)
    end

    -- Tiered logging: Error only for heavy recovery (timer restart or failed kick); Warn for soft kick so
    -- "rotation ran long" under load is visible but not reported as a critical failure.
    local softThreshold = self.rotationSoftStallThreshold or ROTATION_SOFT_STALL_THRESHOLD_SEC
    if secsSinceFinish and secsSinceFinish > softThreshold then
        if not okKick or didRestartTimer then
            -- Real problem: kick failed or we had to restart the timer.
            self:WarnFreeze(format("Aggressive recovery: %s (sinceFinish=%.2fs, sinceCallback=%s)%s",
                tostring(reason),
                secsSinceFinish,
                secsSinceCallback and format("%.2f", secsSinceCallback) or "n/a",
                didRestartTimer and " [timer restarted]" or " [kick failed]"
            ))
        else
            -- Soft kick succeeded: rotation was slow, we nudged it. Likely load/raid, not a bug.
            if (now - (self.freezeLastWarn or 0)) >= self.freezeWarnCooldown then
                self.freezeLastWarn = now
                self:Warn("Rotation was slow (sinceFinish=%.2fs); gave it a nudge. If rare, ignore. If frequent, run |cFF00FF00/nag freeze|r and report.",
                    secsSinceFinish)
            end
        end
    end

    local liveness = self.rotationLiveness
    if liveness then
        liveness.consecutiveRecoveries = (liveness.consecutiveRecoveries or 0) + 1
        liveness.lastRecoveryAt = now
        self:AppendRecoveryEvent({
            timestamp = now,
            reason = tostring(reason),
            classification = liveness.lastClassification or "unknown",
            secsSinceCallback = secsSinceCallback,
            secsSinceFinish = secsSinceFinish,
            state = liveness.state,
            kickError = okKick and nil or tostring(kickErr),
        })
    end
end

--- Heartbeat update handler. Runs extremely lightweight checks and triggers recovery within <= 500ms.
--- @param elapsed number
function RotationManager:OnRotationHeartbeatUpdate(elapsed)
    self._rotationHeartbeatAccum = (self._rotationHeartbeatAccum or 0) + (elapsed or 0)
    local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
    local checkInterval = self.rotationHeartbeatCheckInterval or ROTATION_HEARTBEAT_CHECK_INTERVAL_SEC
    if not inCombat then
        checkInterval = ROTATION_HEARTBEAT_IDLE_CHECK_INTERVAL_SEC
    end
    if self._rotationHeartbeatAccum < checkInterval then
        return
    end
    self._rotationHeartbeatAccum = 0

    local now = GetTime()
    local perf = self._rotationHeartbeatPerf
    if perf then
        perf.ticks = (perf.ticks or 0) + 1
        if inCombat then
            perf.combatTicks = (perf.combatTicks or 0) + 1
        else
            perf.idleTicks = (perf.idleTicks or 0) + 1
        end
        if (now - (perf.lastReportAt or 0)) >= 10 then
            self:Debug("Heartbeat ticks: total=%d combat=%d idle=%d interval=%.3f", perf.ticks, perf.combatTicks,
                perf.idleTicks, checkInterval)
            perf.ticks = 0
            perf.combatTicks = 0
            perf.idleTicks = 0
            perf.lastReportAt = now
        end
    end
    if self.rotationLiveness then
        self.rotationLiveness.lastHeartbeatTickAt = now
    end

    self:CheckRotationExecutionGuardTimeout(now, "heartbeat")
    if not self:ShouldRunAggressiveRecovery() then
        return
    end

    local _, _, _, secsSinceCallback, secsSinceEffective, secsSinceFinish = self:GetRotationStallInfo(now)
    local softThreshold = self.rotationSoftStallThreshold or ROTATION_SOFT_STALL_THRESHOLD_SEC
    local hardThreshold = self.rotationHardStallThreshold or ROTATION_HARD_STALL_THRESHOLD_SEC
    local classification, reason, source = self:ComputeLivenessClassification(secsSinceEffective, secsSinceFinish, softThreshold, hardThreshold)
    local liveness = self.rotationLiveness
    if liveness then
        liveness.lastClassification = classification
        liveness.lastClassificationReason = reason
        liveness.lastClassificationSource = source or "none"
    end

    if classification == "healthy" then
        if liveness then
            liveness.consecutiveStallWindows = 0
            self:UpdateLivenessState(now, "healthy", "healthy")
        end
        return
    end

    if liveness then
        liveness.consecutiveStallWindows = (liveness.consecutiveStallWindows or 0) + 1
        self:UpdateLivenessState(now, classification == "degraded" and "degraded" or "stalled", reason)
    end

    local windows = liveness and liveness.consecutiveStallWindows or 0
    local requiredWindows = self.rotationStallWindowsBeforeRecovery or ROTATION_STALL_WINDOWS_BEFORE_RECOVERY
    if self:ShouldAttemptRecoveryForClassification(classification, reason, windows, requiredWindows) then
        local recoveryReason = classification == "hard_stalled" and "heartbeat_hard_stall" or "heartbeat_stall"
        self:AttemptAggressiveRecovery(recoveryReason, now, secsSinceCallback, secsSinceFinish)
    end
end

--- Event-based kick: on successful player spell casts, attempt recovery if stalled.
--- @param event string
--- @param unit string
function RotationManager:UNIT_SPELLCAST_SUCCEEDED(event, unit)
    if unit ~= "player" then
        return
    end
    if not self:ShouldRunAggressiveRecovery() then
        return
    end
    -- Defer to next frame to avoid heavy work directly in event context.
    C_Timer.After(0, function()
        if not self:ShouldRunAggressiveRecovery() then
            return
        end
        local now = GetTime()
        self:CheckRotationExecutionGuardTimeout(now, "spellcast_event")
        local _, _, _, secsSinceCallback, secsSinceEffective, secsSinceFinish = self:GetRotationStallInfo(now)
        local softThreshold = self.rotationSoftStallThreshold or ROTATION_SOFT_STALL_THRESHOLD_SEC
        local hardThreshold = self.rotationHardStallThreshold or ROTATION_HARD_STALL_THRESHOLD_SEC
        local classification = self:ComputeLivenessClassification(secsSinceEffective, secsSinceFinish, softThreshold, hardThreshold)
        if classification == "hard_stalled" then
            self:AttemptAggressiveRecovery("spellcast_succeeded", now, secsSinceCallback, secsSinceFinish)
        end
    end)
end

--- Print compact rotation freeze diagnostic for in-game troubleshooting.
--- Run /nag freeze when display stops updating to capture state for bug reports.
--- @param verbose boolean|nil Include extended diagnostic snapshot fields.
function RotationManager:PrintRotationFreezeStatus(verbose)
    -- Only use "(error)" when pcall fails; nil/false are valid returns
    local safe = function(f)
        local ok, v = pcall(f)
        if not ok then return "(error)" end
        return v
    end
    local trunc = function(s, len)
        if s == nil then return "nil" end
        local str = tostring(s)
        return #str > (len or 40) and strsub(str, 1, len or 40) .. "..." or str
    end

    local DisplayManager = NAG:GetModule("DisplayManager", true)
    local DataManager = NAG:GetModule("DataManager", true)
    local EventManager = ns.EventManager
    local AceConfigDialog = ns.AceConfigDialog

    local rotExec = safe(function() return NAG._rotationExecuting end)
    local hasMod = safe(function() return NAG.hasEnabledModule end)
    local loadRecent = safe(function() return NAG.isLoadScreenRecent end)
    local editMode = safe(function() return NAG:IsAnyEditMode() end)
    local APLExecutor = NAG:GetModule("APLExecutor", true)
    local useVisitor = APLExecutor and APLExecutor:ShouldUseVisitorPattern()
    local hasCache = (useVisitor and NAG.cachedRotationAST) or (not useVisitor and NAG.cachedRotationFunc)
    local chk = safe(function() local r = ns.check(); return (r == true or r == false) and r or nil end)
    local chkVal = tostring(chk)
    local showDisp = safe(function()
        return DisplayManager and DisplayManager:ShouldShowDisplay() or false
    end)
    local suppressed = safe(function()
        return DisplayManager and DisplayManager:IsDisplaySuppressed() or false
    end)
    local specIdx = safe(function() return SpecCompat and SpecCompat:GetCurrentSpecIndex() end)
    local classMod = NAG:GetClassModule()
    local selRot = safe(function()
        return classMod and SpecCompat and classMod:GetSelectedRotation(SpecCompat:GetCurrentSpecIndex()) or nil
    end)
    local phase = safe(function()
        return EventManager and EventManager.currentPhase or "nil"
    end)
    local phaseComplete = ns.StartupPhase and ns.StartupPhase.COMPLETE or 4
    local dataReady = safe(function() return DataManager and DataManager:IsDataReady() or false end)
    local optsOpen = safe(function()
        local frames = AceConfigDialog and AceConfigDialog.OpenFrames
        return not not (frames and frames["NAG"])
    end)
    local isGroupMode = safe(function()
        return DisplayManager and DisplayManager:IsGroupDisplayMode() or false
    end)
    local isLegacyEnabled = safe(function()
        return DisplayManager and DisplayManager:IsLegacyFrameEnabled() or false
    end)
    local displayedPrimary = safe(function()
        if DisplayManager and DisplayManager:IsLegacyFrameEnabled() and NAG.Frame and NAG.Frame.iconFrames then
            local primaryFrame = NAG.Frame.iconFrames["primary"] or NAG.Frame.iconFrames[ns.SPELL_POSITIONS.PRIMARY]
            return primaryFrame and primaryFrame.spellId or nil
        end
        if DisplayManager and DisplayManager:IsGroupDisplayMode() and DisplayManager.groupFrames then
            local mainGroup = DisplayManager.groupFrames[ns.FRAME_GROUPS.MAIN]
            if mainGroup and mainGroup.iconFrames and mainGroup.iconFrames[1] then
                return mainGroup.iconFrames[1].spellId or nil
            end
        end
        return nil
    end)
    local predQueueEnabled = safe(function()
        local pq = NAG.db and NAG.db.char and NAG.db.char.predictionQueue
        return pq and pq.enabled or false
    end)
    local secsSinceRotation = safe(function()
        local last = NAG.lastRotationFinishTime or 0
        return last > 0 and (GetTime() - last) or nil
    end)
    local lastCallbackTime = safe(function()
        return NAG.lastRotationCallbackTime or nil
    end)
    local secsSinceCallback = safe(function()
        local last = NAG.lastRotationCallbackTime or 0
        return last > 0 and (GetTime() - last) or nil
    end)
    local lastEarlyReturnReason = safe(function()
        return NAG.lastEarlyReturnReason or nil
    end)
    local lastEarlyReturnMessage = safe(function()
        return NAG.lastEarlyReturnMessage or nil
    end)
    local lastEarlyReturnAt = safe(function()
        return NAG.lastEarlyReturnAt or nil
    end)
    local secsSinceEarlyReturn = safe(function()
        local last = NAG.lastEarlyReturnAt or 0
        return last > 0 and (GetTime() - last) or nil
    end)
    local lastEarlyReturnSuppressed = safe(function()
        return NAG.lastEarlyReturnSuppressed == true
    end)
    local lastHeartbeatKickTime = safe(function()
        return NAG.lastRotationHeartbeatKickTime or nil
    end)
    local secsSinceHeartbeatKick = safe(function()
        local last = NAG.lastRotationHeartbeatKickTime or 0
        return last > 0 and (GetTime() - last) or nil
    end)
    local heartbeatKickCount = safe(function()
        return NAG.lastRotationHeartbeatKickCount or 0
    end)
    local callbackDrift = safe(function()
        return NAG.lastRotationCallbackDrift or 0
    end)
    local callbackExpectedTime = safe(function()
        return NAG.lastRotationCallbackExpectedTime or nil
    end)
    local hadValidAtCombatStart = safe(function()
        return self.hadValidRotationAtCombatStart or false
    end)
    local ensureReadyResult = (hasCache == false or hasCache == "(error)") and safe(function()
        return self:EnsureRotationReady()
    end) or nil
    local combatSnapshotSpec = safe(function()
        return self.combatRotationSnapshot and self.combatRotationSnapshot.specIndex or nil
    end)
    local combatSnapshotName = safe(function()
        return self.combatRotationSnapshot and self.combatRotationSnapshot.rotationName or nil
    end)
    local currentRotationName = safe(function()
        return self.currentRotation and self.currentRotation.name or nil
    end)
    local cycleDiagnostics = safe(function()
        return NAG.GetRotationCycleDiagnostics and NAG:GetRotationCycleDiagnostics() or nil
    end)
    local inVehicle = safe(function()
        return DisplayManager and DisplayManager:IsInVehicleState() or false
    end)
    local inPetBattle = safe(function()
        return DisplayManager and DisplayManager.isInPetBattle or false
    end)
    local displayBlockedReason = safe(function()
        if DisplayManager and DisplayManager.GetDisplayBlockedReason then
            return DisplayManager:GetDisplayBlockedReason()
        end
        return nil
    end)
    local liveness = self.rotationLiveness or {}
    local rotationTimerMetrics = safe(function()
        return TimerManager and TimerManager.GetTimerMetrics and TimerManager:GetTimerMetrics(TimerManager.Categories.ROTATION, "rotation") or nil
    end)

    local sep = " | "
    local addonVersion = (WoWAPI and WoWAPI.GetAddOnMetadata and WoWAPI.GetAddOnMetadata("NAG", "Version")) or GetAddOnMetadata("NAG", "Version") or "?"
    NAG:Print("|cFF00FF00=== NAG ROTATION FREEZE DIAGNOSTIC ===|r")
    NAG:Print(format("Version: %s%sTime: %s", tostring(addonVersion), sep, date()))
    NAG:Print("|cFFAAAAAASend the full output below to the NAG team (Discord) if reporting a freeze.|r")
    NAG:Print("")
    NAG:Print("--- Timers ---")
    local timerInterval = (self.db and self.db.global and self.db.global.rotationTimerInterval) or 0.1
    NAG:Print(format("rotation: %s%srotation_watchdog: %s%srotation_selection_watchdog: %s%srotationTimerInterval: %.2fs",
        TimerManager and TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation") and "active" or "inactive", sep,
        TimerManager and TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation_watchdog") and "active" or "inactive", sep,
        TimerManager and TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation_selection_watchdog") and "active" or "inactive", sep,
        timerInterval))
    NAG:Print(format("callbackDrift: %.3fs%slastExpectedCallback: %s",
        tonumber(callbackDrift) or 0, sep, tostring(callbackExpectedTime)))
    if rotationTimerMetrics and rotationTimerMetrics ~= "(error)" then
        NAG:Print(format("timerLag.last: %.3fs%stimerLag.max: %.3fs%stimerCallbacks: %s",
            tonumber(rotationTimerMetrics.lastLag) or 0, sep,
            tonumber(rotationTimerMetrics.maxLag) or 0, sep,
            tostring(rotationTimerMetrics.callbacks or 0)))
    end
    NAG:Print("|cFFAAAAAAtimerLag.max: high values mean one rotation run or other addon blocked the main thread. Causes: NAG rotation slow, other addons, or (rarely) Lua GC. Reproduce with minimal addons and share this output.|r")
    NAG:Print("--- Rotation Gates ---")
    NAG:Print(format("isRotationExecuting: %s%s%s hasEnabledModule: %s%s isLoadScreenRecent: %s%s IsAnyEditMode: %s%s hasCachedRotation: %s",
        tostring(rotExec), rotExec == true and " [STUCK]" or "", sep, tostring(hasMod), sep, tostring(loadRecent), sep, tostring(editMode), sep, tostring(hasCache and true or false)))
    NAG:Print("--- Cache ---")
    NAG:Print(format("cachedRotationFunc: %s%scachedRotationAST: %s",
        NAG.cachedRotationFunc and "present" or "nil", sep,
        NAG.cachedRotationAST and "present" or "nil"))
    NAG:Print("--- Display Gates ---")
    NAG:Print(format("ns.check(): %s%sShouldShowDisplay: %s%sIsDisplaySuppressed: %s%sIsGroupDisplayMode: %s%sIsLegacyFrameEnabled: %s",
        tostring(chkVal), sep, tostring(showDisp), sep, tostring(suppressed), sep, tostring(isGroupMode), sep, tostring(isLegacyEnabled)))
    NAG:Print(format("displayBlockedReason: %s", tostring(displayBlockedReason or "none")))
    NAG:Print("--- Spec/Rotation ---")
    local classFileName = safe(function() return NAG.CLASS_FILENAME or "nil" end)
    NAG:Print(format("class: %s%sspecIndex: %s%sselectedRotation: %s", tostring(classFileName), sep, tostring(specIdx), sep, trunc(selRot, 30)))
    NAG:Print("--- State ---")
    NAG:Print(format("nextSpell: %s%sdisplayedPrimary: %s%ssecondarySpells: %s%slastRotationTime: %s%slastRotationFinishTime: %s",
        tostring(NAG.nextSpell), sep, tostring(displayedPrimary), sep, tostring(NAG.secondarySpells and #NAG.secondarySpells or 0), sep,
        tostring(NAG.lastRotationTime), sep, tostring(NAG.lastRotationFinishTime)))
    local lastRotationExecutionMs = safe(function() return NAG.lastRotationExecutionMs or nil end)
    NAG:Print(format("lastRotationExecutionMs: %s",
        type(lastRotationExecutionMs) == "number" and format("%.0f", lastRotationExecutionMs) or tostring(lastRotationExecutionMs)))
    NAG:Print(format("secondsSinceLastRotation: %s%slastRotationCallbackTime: %s%ssecondsSinceLastCallback: %s",
        secsSinceRotation ~= nil and format("%.2f", secsSinceRotation) or "n/a", sep,
        tostring(lastCallbackTime), sep,
        secsSinceCallback ~= nil and format("%.2f", secsSinceCallback) or "n/a"))
    NAG:Print(format("lastEarlyReturnReason: %s%slastEarlyReturnAt: %s%ssecondsSinceEarlyReturn: %s%ssuppressed: %s",
        tostring(lastEarlyReturnReason or "none"), sep,
        tostring(lastEarlyReturnAt or "nil"), sep,
        secsSinceEarlyReturn ~= nil and format("%.2f", secsSinceEarlyReturn) or "n/a", sep,
        tostring(lastEarlyReturnSuppressed)))
    if lastEarlyReturnMessage and lastEarlyReturnMessage ~= "(error)" then
        NAG:Print(format("lastEarlyReturnMessage: %s", trunc(lastEarlyReturnMessage, 100)))
    end
    NAG:Print(format("lastRotationHeartbeatKickTime: %s%ssecondsSinceLastHeartbeatKick: %s%sheartbeatKickCount: %s",
        tostring(lastHeartbeatKickTime), sep,
        secsSinceHeartbeatKick ~= nil and format("%.2f", secsSinceHeartbeatKick) or "n/a", sep,
        tostring(heartbeatKickCount)))
    NAG:Print("--- Liveness ---")
    NAG:Print(format("state: %s%sreason: %s%slastTransitionAt: %s%sclassification: %s%sclassificationSource: %s",
        tostring(liveness.state or "unknown"), sep,
        tostring(liveness.reason or "unknown"), sep,
        tostring(liveness.lastTransitionAt or 0), sep,
        tostring(liveness.lastClassification or "unknown"), sep,
        tostring(liveness.lastClassificationSource or "none")))
    NAG:Print(format("consecutiveStallWindows: %s%sconsecutiveRecoveries: %s%sconsecutiveMutexLocks: %s",
        tostring(liveness.consecutiveStallWindows or 0), sep,
        tostring(liveness.consecutiveRecoveries or 0), sep,
        tostring(liveness.consecutiveMutexLocks or 0)))
    NAG:Print(format("timerRestartCount: %s%slastTimerRestartAt: %s%slastTimerRestartReason: %s",
        tostring(liveness.timerRestartCount or 0), sep,
        tostring(liveness.lastTimerRestartAt or 0), sep,
        tostring(liveness.lastTimerRestartReason or "nil")))
    NAG:Print(format("schedulerLastDrift: %.3fs%sschedulerMaxDrift: %.3fs",
        tonumber(liveness.schedulerLastDrift) or 0, sep,
        tonumber(liveness.schedulerMaxDrift) or 0))
    NAG:Print("--- Startup ---")
    NAG:Print(format("EventManager phase: %s (COMPLETE=%s)%sDataManager ready: %s", tostring(phase), tostring(phaseComplete), sep, tostring(dataReady)))
    NAG:Print("--- Options ---")
    NAG:Print(format("AceConfigDialog open: %s%spredictionQueue.enabled: %s", tostring(optsOpen), sep, tostring(predQueueEnabled)))
    NAG:Print("--- Combat ---")
    local watchdogAttempts = safe(function() return self.watchdogStallRecoveryAttempts or 0 end)
    NAG:Print(format("inCombat: %s%shadValidRotationAtCombatStart: %s%swatchdogStallRecoveryAttempts: %s%scombatSnapshot: specIndex=%s rotationName=%s%sinVehicle: %s%sisInPetBattle: %s",
        UnitAffectingCombat and tostring(UnitAffectingCombat("player")) or "n/a", sep, tostring(hadValidAtCombatStart), sep, tostring(watchdogAttempts), sep,
        tostring(combatSnapshotSpec), trunc(combatSnapshotName, 25), sep, tostring(inVehicle), sep, tostring(inPetBattle)))
    NAG:Print("--- RotationManager state ---")
    if ensureReadyResult ~= nil then
        NAG:Print(format("currentRotation.name: %s%sEnsureRotationReady(): %s", trunc(currentRotationName, 30), sep, tostring(ensureReadyResult)))
    else
        NAG:Print(format("currentRotation.name: %s", trunc(currentRotationName, 30)))
    end
    if cycleDiagnostics and cycleDiagnostics ~= "(error)" then
        NAG:Print(format("cycleId: %s%scyclePhase: %s%scycleStartTime: %s%slastPhaseAt: %s%slastError: %s",
            tostring(cycleDiagnostics.cycleId or 0), sep,
            tostring(cycleDiagnostics.cyclePhase or "unknown"), sep,
            tostring(cycleDiagnostics.cycleStartTime or 0), sep,
            tostring(cycleDiagnostics.lastPhaseAt or 0), sep,
            trunc(cycleDiagnostics.lastError, 80)))
    end
    NAG:Print("")

    -- Recommendation
    local rec = nil
    if rotExec == true then
        rec = "|cFFFF0000[STUCK] isRotationExecuting=true - /reload required|r"
    elseif hasMod == false then
        rec = "|cFFFF0000[GATE] hasEnabledModule=false - class module may be disabled|r"
    elseif loadRecent == true then
        rec = "|cFFFFAA00[GATE] isLoadScreenRecent - wait a few seconds after zone change|r"
    elseif editMode == true then
        rec = "|cFFFFAA00[GATE] Edit mode active - exit editor|r"
    elseif hasCache == false or hasCache == "(error)" then
        rec = "|cFFFF0000[GATE] No cached rotation - EnsureRotationReady may be failing|r"
    elseif displayBlockedReason and displayBlockedReason ~= "none" then
        rec = format("|cFFFFAA00[GATE] Display blocked: %s|r", tostring(displayBlockedReason))
    elseif showDisp == false then
        rec = "|cFFFFAA00[GATE] ShouldShowDisplay=false - check display/visibility settings|r"
    elseif suppressed == true then
        rec = "|cFFFFAA00[GATE] Display suppressed (e.g. FloatingSelector) - unsuppress to see icons|r"
    elseif chkVal == "false" then
        rec = "|cFFFFAA00[GATE] ns.check() false - license/capital check failing|r"
    end
    -- When all gates pass but rotation hasn't run in a long time: distinguish timer not firing vs rotation not completing
    if not rec and secsSinceRotation and secsSinceRotation > 2 then
        local recentEarlyReturn = secsSinceEarlyReturn and secsSinceEarlyReturn <= 2.0
        local callbackFresh = secsSinceCallback and secsSinceCallback <= 2.0
        if recentEarlyReturn and callbackFresh then
            rec = format("|cFFFFAA00[GATE] Recent early return: %s (%s ago)|r",
                tostring(lastEarlyReturnReason or "unknown"),
                format("%.2fs", secsSinceEarlyReturn))
        end
    end
    if not rec and secsSinceRotation and secsSinceRotation > 2 then
        if secsSinceCallback and secsSinceCallback > 2 then
            if secsSinceHeartbeatKick and secsSinceHeartbeatKick < 1 then
                rec = "|cFFFFAA00[TIMER] timer callback stale, but heartbeat is kicking - possible AceTimer/C_Timer stall|r"
            else
                rec = "|cFFFF0000[TIMER] secondsSinceLastCallback also high - timer callback may not be firing (game/addon load)|r"
            end
        else
            rec = "|cFFFFAA00[CALLBACK] Callback firing but rotation not completing - check for transient gate or error in rotation path|r"
        end
    end
    if rec then
        NAG:Print("")
        NAG:Print("--- Recommendation ---")
        NAG:Print(rec)
        if secsSinceRotation and secsSinceRotation > 2 then
            NAG:Print("|cFFAAAAAATry reproducing with minimal addons to see if another addon is blocking. Share this full output with the NAG team (Discord) to help fix this.|r")
        end
    end
    if verbose and liveness.recoveryEvents and #liveness.recoveryEvents > 0 then
        NAG:Print("")
        NAG:Print("--- Recovery Events (last 5) ---")
        local startIdx = #liveness.recoveryEvents - 4
        if startIdx < 1 then
            startIdx = 1
        end
        local idx = startIdx
        while idx <= #liveness.recoveryEvents do
            local ev = liveness.recoveryEvents[idx]
            NAG:Print(format("[%d] t=%.3f reason=%s class=%s sinceCallback=%s sinceFinish=%s kickError=%s",
                idx,
                tonumber(ev.timestamp) or 0,
                tostring(ev.reason or "unknown"),
                tostring(ev.classification or "unknown"),
                ev.secsSinceCallback and format("%.2f", ev.secsSinceCallback) or "n/a",
                ev.secsSinceFinish and format("%.2f", ev.secsSinceFinish) or "n/a",
                tostring(ev.kickError or "none")))
            idx = idx + 1
        end
    end
    -- Hint when nextSpell nil but display shows something (Legacy AOE fallback)
    if not NAG.nextSpell and NAG.secondarySpells and #NAG.secondarySpells > 0 and isLegacyEnabled == true then
        NAG:Print("")
        NAG:Print("--- Note ---")
        NAG:Print("|cFFAAAAAAnextSpell nil + secondaries: Legacy AOE fallback may show AOE secondary in center|r")
    end
end

--- Print extended freeze diagnostics with recovery history.
function RotationManager:PrintRotationFreezeDump()
    self:PrintRotationFreezeStatus(true)
end

function RotationManager:MarkCombatStartReady(isReady)
    self.hadValidRotationAtCombatStart = isReady and true or false
    self.freezeWarnedThisCombat = false
    self.combatWatchdogRecoveries = 0
    if self.rotationLiveness then
        self.rotationLiveness.consecutiveRecoveries = 0
        self.rotationLiveness.consecutiveStallWindows = 0
        self.rotationLiveness.consecutiveMutexLocks = 0
        self.rotationLiveness.schedulerMaxDrift = 0
        self.rotationLiveness.recoveryEvents = {}
        self:UpdateLivenessState(GetTime(), isReady and "healthy" or "degraded", isReady and "combat_start_ready" or "combat_start_not_ready")
    end
    self:CaptureCombatRotationSnapshot("combat_start")
end

function RotationManager:MarkCombatEnd()
    self.hadValidRotationAtCombatStart = false
    self.freezeWarnedThisCombat = false
    self.freezeReminderShownThisCombat = false
    if self.rotationLiveness then
        self.rotationLiveness.consecutiveStallWindows = 0
        self.rotationLiveness.consecutiveMutexLocks = 0
        self:UpdateLivenessState(GetTime(), "healthy", "combat_end")
    end
    self.watchdogStallRecoveryAttempts = 0
    self:ApplyPendingSelectionClears()
    self:ApplyPendingRotationDisables()
    self:ReportCombatRotationRecovery()
    self.combatRotationSnapshot = nil
    self.combatRecoveryEvents = nil
    self.combatWatchdogRecoveries = 0
end

function RotationManager:CaptureCombatRotationSnapshot(reason)
    local classModule = NAG:GetClassModule()
    if not classModule then
        return
    end

    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not specIndex then
        return
    end

    local selectedRotation = classModule:GetSelectedRotation(specIndex)
    if not selectedRotation then
        return
    end
    self.lastKnownRotationBySpec[specIndex] = selectedRotation

    self.combatRotationSnapshot = {
        specIndex = specIndex,
        rotationName = selectedRotation,
        capturedAt = GetTime(),
        reason = reason or "unknown"
    }
end

function RotationManager:RecordCombatRecovery(event)
    if not event or not event.reason then
        return
    end

    self.combatRecoveryEvents = self.combatRecoveryEvents or {}
    event.timestamp = event.timestamp or GetTime()
    self.combatRecoveryEvents[#self.combatRecoveryEvents + 1] = event
end

function RotationManager:RecordLastSelectedRotation(specIndex, rotationName, source)
    if not specIndex or not rotationName then
        return
    end

    self.lastKnownRotationBySpec[specIndex] = rotationName
    if source then
        -- Keep this lightweight and in-memory only for diagnostics
        self.lastKnownRotationSource = source
    end
end

function RotationManager:QueueSelectionClear(specIndex, reason, source)
    if not specIndex then
        return false
    end

    self.pendingSelectionClears[specIndex] = {
        specIndex = specIndex,
        reason = reason or "unknown",
        source = source or "unknown",
        timestamp = GetTime()
    }

    self:RecordCombatRecovery({
        reason = "selection_clear_deferred",
        fromRotation = self.lastKnownRotationBySpec[specIndex],
        toRotation = nil,
        specIndex = specIndex,
        error = reason
    })

    return true
end

function RotationManager:QueueRotationDisable(specIndex, rotationName, configCopy, reason)
    if not specIndex or not rotationName or not configCopy then
        return false
    end

    self.pendingRotationDisables[specIndex] = self.pendingRotationDisables[specIndex] or {}
    self.pendingRotationDisables[specIndex][rotationName] = {
        specIndex = specIndex,
        rotationName = rotationName,
        config = configCopy,
        reason = reason or "unknown",
        timestamp = GetTime()
    }

    self:RecordCombatRecovery({
        reason = "rotation_disable_deferred",
        fromRotation = rotationName,
        toRotation = nil,
        specIndex = specIndex,
        error = reason
    })

    return true
end

function RotationManager:ApplyPendingSelectionClears()
    if UnitAffectingCombat and UnitAffectingCombat("player") then
        return
    end

    if not self.pendingSelectionClears or not next(self.pendingSelectionClears) then
        return
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        return
    end

    for specIndex, entry in pairs(self.pendingSelectionClears) do
        classModule:SetSelectedRotation(specIndex, nil)
        self:Debug("ApplyPendingSelectionClears: Cleared selection for specIndex %s (reason=%s, source=%s)",
            tostring(specIndex), tostring(entry.reason), tostring(entry.source))
    end

    self.pendingSelectionClears = {}
end

function RotationManager:ApplyPendingRotationDisables()
    if UnitAffectingCombat and UnitAffectingCombat("player") then
        return
    end

    if not self.pendingRotationDisables or not next(self.pendingRotationDisables) then
        return
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        return
    end

    for specIndex, rotations in pairs(self.pendingRotationDisables) do
        for rotationName, entry in pairs(rotations) do
            classModule:SaveRotation(specIndex, rotationName, entry.config)
            local selectedRotation = classModule:GetSelectedRotation(specIndex)
            if selectedRotation == rotationName then
                classModule:SetSelectedRotation(specIndex, nil)
                self:Debug("ApplyPendingRotationDisables: Cleared selection for disabled rotation '%s'", rotationName)
            end
            self:Debug("ApplyPendingRotationDisables: Applied disable for '%s' (spec=%s, reason=%s)",
                rotationName, tostring(specIndex), tostring(entry.reason))
        end
    end

    self.pendingRotationDisables = {}
end

function RotationManager:ScheduleRecoveryAttempt(specIndex, rotationName, reason, fromRotation)
    if not specIndex or not rotationName then
        return false
    end

    self.pendingRecoveryTimers = self.pendingRecoveryTimers or {}
    if self.pendingRecoveryTimers[specIndex] then
        return false
    end

    self.pendingRecoveryTimers[specIndex] = true
    local selfRef = self
    C_Timer.After(0.02, function()
        selfRef.pendingRecoveryTimers[specIndex] = nil

        if not (UnitAffectingCombat and UnitAffectingCombat("player")) then
            return
        end

        local classModule = NAG:GetClassModule()
        if not classModule then
            return
        end

        local success, err = selfRef:SetActiveRotation(specIndex, rotationName)
        if success then
            classModule:SetSelectedRotation(specIndex, rotationName)
            selfRef:RecordCombatRecovery({
                reason = reason or "scheduled_recovery",
                fromRotation = fromRotation,
                toRotation = rotationName,
                specIndex = specIndex
            })
        else
            selfRef:RecordCombatRecovery({
                reason = reason or "scheduled_recovery",
                fromRotation = fromRotation,
                toRotation = rotationName,
                specIndex = specIndex,
                error = err
            })
        end
    end)

    return true
end

function RotationManager:ShouldAttemptCombatRecovery()
    local now = GetTime()
    local cooldown = self.combatRecoveryCooldown or 2
    if (now - (self.combatRecoveryLastAttempt or 0)) < cooldown then
        return false
    end
    self.combatRecoveryLastAttempt = now
    return true
end


function RotationManager:ReportCombatRotationRecovery()
    if not self.combatRecoveryEvents or #self.combatRecoveryEvents == 0 then
        return
    end

    local reasonCounts = {}
    for _, event in ipairs(self.combatRecoveryEvents) do
        local key = tostring(event.reason or "unknown")
        reasonCounts[key] = (reasonCounts[key] or 0) + 1
    end

    local summaryParts = {}
    for reason, count in pairs(reasonCounts) do
        summaryParts[#summaryParts + 1] = string.format("%s=%s", reason, count)
    end
    if self.combatWatchdogRecoveries and self.combatWatchdogRecoveries > 0 then
        summaryParts[#summaryParts + 1] = string.format("watchdog_recoveries=%s", self.combatWatchdogRecoveries)
    end

    self:Warn("Rotation recovery occurred during combat. Please report this to the NAG team: discord.gg/ebonhold")
    if #summaryParts > 0 then
        self:Warn("Rotation recovery summary: %s", table.concat(summaryParts, ", "))
    end
    for _, event in ipairs(self.combatRecoveryEvents) do
        self:Warn("Rotation recovery details: reason=%s, from=%s, to=%s, spec=%s, error=%s",
            tostring(event.reason),
            tostring(event.fromRotation or "none"),
            tostring(event.toRotation or "none"),
            tostring(event.specIndex or "unknown"),
            tostring(event.error or "none"))
    end
end

function RotationManager:EnsureRotationWatchdog()
    if not TimerManager then return end
    if TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation_watchdog") then
        return
    end

    TimerManager:Create(
        TimerManager.Categories.ROTATION,
        "rotation_watchdog",
        function()
            local now = GetTime()
            self:CheckRotationExecutionGuardTimeout(now, "watchdog")
            -- Avoid false positives while rotation is executing but slow under load.
            if NAG._rotationExecuting then
                return
            end

            local function ensureRotationReadyWithMutex()
                CacheRefreshManager = CacheRefreshManager or NAG:GetModule("CacheRefreshManager", true)
                local lockKey = "rotation:EnsureRotationReady"
                local acquired = false
                local lockStartAt = GetTime()
                if CacheRefreshManager then
                    if not CacheRefreshManager:AcquireMutex(lockKey) then
                        if self.rotationLiveness then
                            self.rotationLiveness.consecutiveMutexLocks = (self.rotationLiveness.consecutiveMutexLocks or 0) + 1
                        end
                        return false, "mutex_locked"
                    end
                    acquired = true
                end
                local mutexHoldStart = GetTime()
                local ok, ready = pcall(function()
                    return self:EnsureRotationReady()
                end)
                if CacheRefreshManager and acquired then
                    CacheRefreshManager:ReleaseMutex(lockKey)
                end
                local holdDuration = GetTime() - mutexHoldStart
                NAG.lastRotationWatchdogMutexWaitDuration = mutexHoldStart - lockStartAt
                NAG.lastRotationWatchdogMutexHoldDuration = holdDuration
                if self.rotationLiveness then
                    self.rotationLiveness.consecutiveMutexLocks = 0
                end
                if not ok then
                    return false, "error"
                end
                return ready and true or false, nil
            end

            local rotationTimerActive = TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation")
            local lastCallback = NAG.lastRotationCallbackTime or 0
            local secsSinceCallback = lastCallback > 0 and (now - lastCallback) or nil
            local rotationInterval = self.db.global.rotationTimerInterval or 0.1
            local callbackStallThreshold = math.max(1.0, rotationInterval * 10)
            local APLExecutor = NAG:GetModule("APLExecutor", true)
            local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()
            local hasCache = useVisitorPattern and NAG.cachedRotationAST or NAG.cachedRotationFunc
            local DisplayManager = NAG:GetModule("DisplayManager", true)
            local displayAllowed = true
            if DisplayManager and DisplayManager.ShouldShowDisplay then
                local okShow, showResult = pcall(function()
                    return DisplayManager:ShouldShowDisplay()
                end)
                displayAllowed = okShow and showResult ~= false
            end
            local displayUnlocked = false
            if NAG.IsAnyEditMode and NAG.IsAnyEditMode then
                local okEdit, editResult = pcall(function() return NAG:IsAnyEditMode() end)
                displayUnlocked = okEdit and editResult == true
            end
            local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")

            if secsSinceCallback and secsSinceCallback > callbackStallThreshold then
                local restarted = self:MaybeRestartRotationTimer("watchdog_callback_stall", now)
                if restarted then
                    self:UpdateLivenessState(now, "hard_stalled", "watchdog_callback_stall")
                    if not displayUnlocked then
                        self:WarnFreeze(format("Watchdog: rotation callback stalled for %.1fs, forcing timer restart", secsSinceCallback))
                    end
                    return
                end
            end

            if not rotationTimerActive then
                self:UpdateLivenessState(now, "stalled", "watchdog_timer_inactive")
                if not displayUnlocked then
                    self:WarnFreeze("Watchdog: rotation timer was stopped, restarting")
                end
                self:MaybeRestartRotationTimer("watchdog_timer_inactive", now)
                return
            end

            if not hasCache then
                local ready, why = ensureRotationReadyWithMutex()
                if not ready then
                    if not displayUnlocked then
                        self:WarnFreeze("Watchdog: missing rotation cache in combat, attempted recovery")
                    end
                    self.watchdogStallRecoveryAttempts = (self.watchdogStallRecoveryAttempts or 0) + 1
                    if self.watchdogStallRecoveryAttempts >= 3 and not self.freezeReminderShownThisCombat then
                        self.freezeReminderShownThisCombat = true
                        self:Print("Rotation has stalled repeatedly. Please run |cFF00FF00/nag freeze|r and send the output to the NAG team (Discord) so we can fix this.")
                    end
                    if why == "mutex_locked" then
                        NAG.lastRotationWatchdogMutexLockedAt = now
                        NAG.lastRotationWatchdogMutexLockedCount = (NAG.lastRotationWatchdogMutexLockedCount or 0) + 1
                        self:UpdateLivenessState(now, "degraded", "mutex_locked")
                        return
                    end
                else
                    -- Cache repopulated: fire one rotation tick so display updates without waiting for next timer interval
                    pcall(function()
                        NAG:Rotation()
                    end)
                    -- Force-restart rotation timer so if AceTimer dropped the repeating callback we get a fresh schedule
                    self:MaybeRestartRotationTimer("watchdog_cache_repopulated", now)
                end
            else
                local lastFinish = NAG.lastRotationFinishTime or 0
                local stallThreshold = math.max(1.0, rotationInterval * 10)
                if inCombat and self.hadValidRotationAtCombatStart and lastFinish > 0 and
                    (now - lastFinish) > stallThreshold then
                    local ready, why = ensureRotationReadyWithMutex()
                    if ready then
                        if not displayUnlocked then
                            self:WarnFreeze(format("Watchdog: rotation stalled for %.1fs, attempted recovery",
                                now - lastFinish))
                        end
                        self.watchdogStallRecoveryAttempts = (self.watchdogStallRecoveryAttempts or 0) + 1
                        if self.watchdogStallRecoveryAttempts >= 3 and not self.freezeReminderShownThisCombat then
                            self.freezeReminderShownThisCombat = true
                            self:Print("Rotation has stalled repeatedly. Please run |cFF00FF00/nag freeze|r and send the output to the NAG team (Discord) so we can fix this.")
                        end
                        -- Fire one rotation tick immediately so display updates without waiting for next timer interval
                        pcall(function()
                            NAG:Rotation()
                        end)
                        -- Force-restart rotation timer so if AceTimer dropped the repeating callback we get a fresh schedule
                        self:MaybeRestartRotationTimer("watchdog_finish_stall", now)
                    else
                        if why == "mutex_locked" then
                            NAG.lastRotationWatchdogMutexLockedAt = now
                            NAG.lastRotationWatchdogMutexLockedCount = (NAG.lastRotationWatchdogMutexLockedCount or 0) + 1
                            self:UpdateLivenessState(now, "degraded", "mutex_locked")
                            return
                        end
                        if not displayUnlocked then
                            self:WarnFreeze(format("Watchdog: rotation stalled for %.1fs, recovery failed",
                                now - lastFinish))
                        end
                        self.watchdogStallRecoveryAttempts = (self.watchdogStallRecoveryAttempts or 0) + 1
                        if self.watchdogStallRecoveryAttempts >= 3 and not self.freezeReminderShownThisCombat then
                            self.freezeReminderShownThisCombat = true
                            self:Print("Rotation has stalled repeatedly. Please run |cFF00FF00/nag freeze|r and send the output to the NAG team (Discord) so we can fix this.")
                        end
                    end
                end
            end

            if inCombat and not displayAllowed and not displayUnlocked then
                self:WarnFreeze("Display hidden or blocked (license/visibility); suggestions may not show")
            end
        end,
        1.0,
        true
    )
end

function RotationManager:EnsureRotationSelectionWatchdog()
    if not TimerManager then return end
    if TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation_selection_watchdog") then
        return
    end

    TimerManager:Create(
        TimerManager.Categories.ROTATION,
        "rotation_selection_watchdog",
        function()
            if not (UnitAffectingCombat and UnitAffectingCombat("player")) then
                return
            end

            local classModule = NAG:GetClassModule()
            if not classModule then
                return
            end

            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            if not specIndex then
                return
            end

            local selectedRotation = classModule:GetSelectedRotation(specIndex)
            if selectedRotation then
                self.lastKnownRotationBySpec[specIndex] = selectedRotation
                return
            end

            local fallbackRotation = self.lastKnownRotationBySpec[specIndex]
            if not fallbackRotation and self.combatRotationSnapshot and
                self.combatRotationSnapshot.specIndex == specIndex then
                fallbackRotation = self.combatRotationSnapshot.rotationName
            end

            if not fallbackRotation then
                return
            end

            if not self:ShouldAttemptCombatRecovery() then
                return
            end

            local scheduled = self:ScheduleRecoveryAttempt(
                specIndex,
                fallbackRotation,
                "watchdog_selection_missing",
                nil
            )
            if scheduled then
                self.combatWatchdogRecoveries = (self.combatWatchdogRecoveries or 0) + 1
            end
        end,
        0.2,
        true
    )
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~


function RotationManager:NAG_ROTATION_CHANGED(message, payload)
    self:Debug("NAG_ROTATION_CHANGED: Starting (action: %s, dataChanged: %s, selectionChanged: %s)",
        payload and payload.action or "unknown",
        payload and tostring(payload.dataChanged) or "unknown",
        payload and tostring(payload.selectionChanged) or "unknown")

    if not self.frame or not self.frame:IsShown() then
        return
    end

    -- Handle auto-rotation toggle change
    if payload and payload.autoRotationToggled then
        self:Debug("NAG_ROTATION_CHANGED: Auto rotation toggled")
        self:RefreshAutoRotationToggle()
        return
    end

    -- Full refresh if data changed, lightweight refresh if only selection changed
    if payload and payload.dataChanged then
        self:Debug("NAG_ROTATION_CHANGED: Data changed, full refresh")
        self:RefreshRotationList()
    elseif payload and payload.selectionChanged then
        self:Debug("NAG_ROTATION_CHANGED: Selection only, lightweight refresh")
        self:RefreshRotationHighlight()
    else
        -- Fallback: full refresh if neither flag is set
        self:Debug("NAG_ROTATION_CHANGED: No flags set, full refresh")
        self:RefreshRotationList()
    end
end

function RotationManager:NAG_EXPANSION_DATA_LOADED(message)
    self:Info("Expansion data loaded - precompiling rotations")
    self._expansionDataReady = true
    self:InitializeDataDependentPrecompile("NAG_EXPANSION_DATA_LOADED")
end

function RotationManager:NAG_SCHEMA_VALIDATOR_READY(message)
    self:Debug("Schema validator ready - checking precompile gate")
    self._schemaValidatorReady = true
    self:TryStartPrecompile()
end

function RotationManager:PLAYER_REGEN_ENABLED()
    if not self._precompileDeferred then
        return
    end

    self._precompileDeferred = false
    local deferredOptions = self._precompileDeferredOptions
    self._precompileDeferredOptions = nil
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    self:Debug("PrecompileAllRotations: Combat ended, resuming deferred precompile")
    self:StartPrecompileAllRotations(deferredOptions)
end

function RotationManager:NAG_STARTUP_COMPLETE(message)
    self:Info("Startup complete - starting rotation timer")
    self:StartRotationTimer()
end

function RotationManager:NAG_DB_RESET(message, resetType)
    self:Debug("NAG_DB_RESET: Starting reset type: " .. tostring(resetType))

    -- Handle different reset types
    if resetType == "all" then
        -- Complete reset: clear all caches
        self:ClearRotationCache()
        self:InvalidateSpellExtractionCache()
        self:ClearRotationSwitchingCache()

        -- Stop rotation timer and clear active rotation
        self:StopRotationTimer()
        NAG.cachedRotationFunc = nil
        NAG.cachedRotationAST = nil

        -- Reset precompilation flag to force recompilation on next load
        self._hasPrecompiled = false

        -- Re-run precompilation to ensure all rotations are properly validated and compiled
        C_Timer.After(0.1, function()
            self:StartPrecompileAllRotations({force = true})
        end)

        self:Debug("NAG_DB_RESET: Cleared all rotation caches for complete reset")

    elseif resetType == "class" then
        -- Class reset: clear class-related caches
        local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if currentSpecIndex then
            -- Clear caches for current spec
            self:ClearRotationCache(currentSpecIndex)
            self:InvalidateSpellExtractionCache(currentSpecIndex)
        else
            -- If no spec available, clear all caches to be safe
            self:ClearRotationCache()
            self:InvalidateSpellExtractionCache()
        end

        -- Clear rotation switching cache
        self:ClearRotationSwitchingCache()

        -- Stop rotation timer and clear active rotation
        self:StopRotationTimer()
        NAG.cachedRotationFunc = nil
        NAG.cachedRotationAST = nil

        -- Reset precompilation flag to force recompilation
        self._hasPrecompiled = false

        -- Re-run precompilation to ensure all rotations are properly validated and compiled
        C_Timer.After(0.1, function()
            self:StartPrecompileAllRotations({force = true})
        end)

        self:Debug("NAG_DB_RESET: Cleared rotation caches for class reset")

    elseif resetType == "char" then
        -- Character reset: clear character-specific caches
        -- Note: Character resets don't typically affect rotation data,
        -- but we'll clear switching cache as it may contain character-specific state
        self:ClearRotationSwitchingCache()

        self:Debug("NAG_DB_RESET: Cleared rotation switching cache for character reset")

    elseif resetType == "global" then
        -- Global reset: clear all caches as global settings may affect rotations
        self:ClearRotationCache()
        self:InvalidateSpellExtractionCache()
        self:ClearRotationSwitchingCache()

        -- Stop rotation timer and clear active rotation
        self:StopRotationTimer()
        NAG.cachedRotationFunc = nil
        NAG.cachedRotationAST = nil

        -- Reset precompilation flag to force recompilation
        self._hasPrecompiled = false

        -- Re-run precompilation to ensure all rotations are properly validated and compiled
        C_Timer.After(0.1, function()
            self:StartPrecompileAllRotations({force = true})
        end)

        self:Debug("NAG_DB_RESET: Cleared all rotation caches for global reset")
    end
end

function RotationManager:NAG_TALENTS_UPDATED(message)
    self:Debug("NAG_TALENTS_UPDATED: Talents updated")
    -- Note: Talents changing doesn't invalidate the compiled rotation cache
    -- The rotation string itself hasn't changed, only runtime spell availability might change
    -- Spell availability is checked at runtime, not compilation time
    -- Only invalidate spell extraction cache as talents may affect which spells are available
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if specIndex then
        self:InvalidateSpellExtractionCache(specIndex)
    else
        self:InvalidateSpellExtractionCache()
    end
    -- No need to call EnsureRotationReady() - the cached rotation function is still valid
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~


function RotationManager:Toggle()
    self:Debug("Toggle: Starting")
    if not self.frame then
        self:CreateFrame()
    end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self:RefreshRotationList()
        self.frame:Show()
    end
end

function RotationManager:EditCurrentRotation()
    self:Debug("EditCurrentRotation: Starting")

    -- Get current spec using cached data
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not specIndex then
        self:Error("No specialization selected")
        return
    end

    -- Get class module
    --- @type ClassBase|AceModule|CoreModule
    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Error("Class module not found")
        return
    end

    -- Get current rotation
    local rotationName = classModule:GetSelectedRotation(specIndex)
    if not rotationName then
        self:Error("No rotation currently selected")
        return
    end

    -- Get rotation config
    local rotationConfig = classModule:GetRotation(specIndex, rotationName)
    if not rotationConfig then
        self:Error("Failed to load rotation: " .. tostring(rotationName))
        return
    end

    -- TBC uses no aplProto, so only allow basic editor
    local isTBC = Version:IsTBC()

    local rotation = {
        name = rotationName,
        config = rotationConfig
    }

    -- Basic editor is default, Shift+click for advanced (unless TBC)
    local useAdvancedEditor = not isTBC and (IsShiftKeyDown and IsShiftKeyDown())

    if useAdvancedEditor then
        -- Use advanced editor (Shift+click)
        local RotationEditor = ns.RotationEditor
        if not RotationEditor then
            self:Error("RotationEditor not available")
            return
        end
        -- Editors use specIndex
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        RotationEditor:ShowEditor(specIndex, rotation, classModule, nil)
        self:Debug("EditCurrentRotation: Opened advanced editor for rotation: " .. rotationName)
    else
        -- Use basic editor (default)
        local BasicRotationStringEditor = ns.BasicRotationStringEditor
        if not BasicRotationStringEditor then
            self:Error("BasicRotationStringEditor not available")
            return
        end
        -- Editors use specIndex
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        BasicRotationStringEditor:ShowEditor(specIndex, rotation, classModule)
        self:Debug("EditCurrentRotation: Opened basic editor for rotation: " .. rotationName)
    end
end

function RotationManager:OpenStandaloneExport()
    local RotationEditorExport = ns.RotationEditorExport
    self:Debug("OpenStandaloneExport: Starting")
    if not RotationEditorExport or not RotationEditorExport.ShowStandaloneExportUI then
        self:Error("Standalone export UI is not available.")
        return
    end
    RotationEditorExport:ShowStandaloneExportUI()
end

function RotationManager:RunStressTest(input)
    local iterations = 200000
    local duration = nil
    local showHelp = false

    for token in string.gmatch(input or "", "%S+") do
        local key, value = token:match("^(%w+)=([%d%.]+)$")
        if key and value then
            key = strlower(key)
            if key == "iterations" or key == "iter" or key == "i" then
                iterations = tonumber(value) or iterations
            elseif key == "time" or key == "duration" or key == "t" then
                duration = tonumber(value)
            end
        elseif token == "help" or token == "?" then
            showHelp = true
        else
            local asNumber = tonumber(token)
            if asNumber then
                iterations = asNumber
            end
        end
    end

    if showHelp then
        self:Info("StressTest usage: /nag stresstest [iterations=N] [time=S]")
        self:Info("Example: /nag stresstest iterations=500000 time=0.05")
        return
    end

    if iterations < 1 then iterations = 1 end
    if duration and duration <= 0 then duration = nil end

    local startTime = GetTime()
    local count = 0
    local acc = 0
    if duration then
        while (GetTime() - startTime) < duration do
            acc = acc + (count % 7) * 0.001
            count = count + 1
        end
    else
        for i = 1, iterations do
            acc = acc + (i % 7) * 0.001
        end
        count = iterations
    end

    local elapsed = GetTime() - startTime
    self.lastStressTest = {
        iterations = count,
        duration = duration,
        elapsed = elapsed,
        accumulator = acc
    }
    self:Info("StressTest: iterations=%d, elapsed=%.3fs", count, elapsed)
end

function RotationManager:GetAvailableRotationsCount()
    local classModule = NAG:GetClassModule()
    if not classModule then
        return 0
    end

    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0
    local rotations = classModule:GetAvailableRotations(specIndex)

    if not rotations then
        return 0
    end

    local count = 0
    for name, config in pairs(rotations) do
        if config.enabled then
            count = count + 1
        end
    end
    return count
end

-- Remove UpdateSelectorVisibility function and all calls to it

-- ~~~~~~~~~~ ROTATION SELECTOR UI ~~~~~~~~~~

-- Remove SaveSelectorPosition, RestoreSelectorPosition, ApplySelectorSize, and all their references

-- ~~~~~~~~~~ ROTATION SELECTOR MENUS ~~~~~~~~~~



function RotationManager:CreateFrame()
    self:Debug("CreateFrame: Starting")
    -- Create the main frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle(L["rotationManager"] or "Rotation Manager")
    frame:SetLayout("Flow")
    frame:SetCallback("OnClose", function(widget)
        widget:Hide()
    end)

    -- Use AceGUI status table for position/size persistence
    self:EnsureFrameStatus(frame)

    -- Add search box
    local searchBox = AceGUI:Create("EditBox")
    searchBox:SetLabel(L["Search"] or "Search")
    searchBox:SetFullWidth(true)
    searchBox:SetCallback("OnTextChanged", function(widget, event, text)
        self.searchText = text:lower()
        self:RefreshRotationList()
    end)
    frame:AddChild(searchBox)
    self.searchText = ""


    -- Add import and new rotation buttons at the bottom
    local importGroup = AceGUI:Create("SimpleGroup")
    importGroup:SetFullWidth(true)
    importGroup:SetLayout("Flow")

    local importBtn = AceGUI:Create("Button")
    importBtn:SetText(L["rotationImport"] or "Import Rotation")
    importBtn:SetWidth(150)
    importBtn:SetCallback("OnClick", function()
        StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")
    end)
    importBtn:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["rotationImport"] or "Import Rotation")
        GameTooltip:AddLine(
            "Import a rotation from export string. Use this to restore custom rotations after profile migration.", 1, 1,
            1,
            true)
        GameTooltip:Show()
    end)
    importBtn:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)
    importGroup:AddChild(importBtn)

    local newRotationBtn = AceGUI:Create("Button")
    newRotationBtn:SetText(L["rotationNew"] or "New Rotation")
    newRotationBtn:SetWidth(150)
    newRotationBtn:SetCallback("OnClick", function()
        -- Get current spec using cached data
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if not specIndex then
            self:Error("No specialization selected")
            return
        end

        -- Get class module
        --- @type ClassBase|AceModule|CoreModule
        local classModule = NAG:GetClassModule()
        if not classModule then
            self:Error("Class module not found")
            return
        end

        StaticPopupDialogs["NAG_NEW_ROTATION"] = {
            text = L["newRotationName"] or "Enter name for new rotation:",
            button1 = ACCEPT,
            button2 = CANCEL,
            hasEditBox = true,
            editBoxWidth = 250,
            maxLetters = 100,
            enterClicksFirstButton = true,
            OnShow = function(dialog)
                dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                dialog:SetFrameLevel(200)
                local editBox = dialog:GetEditBox()
                if editBox then
                    editBox:SetFocus()
                end
            end,
            EditBoxOnEnterPressed = function(dialog)
                StaticPopup_OnClick(dialog:GetParent(), 1)
            end,
            OnAccept = function(dialog)
                local editBox = dialog:GetEditBox()
                if not editBox then return end
                local name = editBox:GetText()
                if not name or name:trim() == "" then
                    self:Error(L["invalidRotationName"])
                    return
                end

                -- Get specIndex for internal operations
                local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
                if not specIndex then
                    self:Error("No specialization selected")
                    return
                end

                -- Create empty rotation config
                local newConfig = classModule:GetEmptyRotation()
                newConfig.name = name
                newConfig.specIndex = specIndex
                newConfig.enabled = true
                newConfig.userModified = true

                -- Save as user rotation
                local success = classModule:SaveRotation(specIndex, name, newConfig)
                if success then
                    -- Switch to the new rotation
                    classModule:SelectRotation(specIndex, name)
                    -- Cache is automatically managed by SelectRotation now
                    AceConfigRegistry:NotifyChange("NAG")
                    self:RefreshRotationList()
                end
            end,
            EditBoxOnEscapePressed = function(editBox)
                editBox:GetParent():Hide()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("NAG_NEW_ROTATION")
    end)
    importGroup:AddChild(newRotationBtn)



    frame:AddChild(importGroup)

    -- Add toggles side by side
    local togglesGroup = AceGUI:Create("SimpleGroup")
    togglesGroup:SetFullWidth(true)
    togglesGroup:SetLayout("Flow")

    -- Automatic rotation switching toggle
    local autoRotationToggle = AceGUI:Create("CheckBox")
    autoRotationToggle:SetLabel("Enable Automatic Rotation Switching")
    autoRotationToggle:SetWidth(275)

    -- Set initial value
    local classModule = NAG:GetClassModule()
    if classModule then
        autoRotationToggle:SetValue(classModule:IsAutomaticRotationSwitchingEnabled())
    end

    -- Add tooltip
    autoRotationToggle:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
        GameTooltip:SetText("Enable Automatic Rotation Switching")
        GameTooltip:AddLine("Automatically switch rotations based on target count, weapon type, and other context changes", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    autoRotationToggle:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)

    autoRotationToggle:SetCallback("OnValueChanged", function(_, _, value)
        local classModule = NAG:GetClassModule()
        if classModule then
            classModule:SetSetting("char", "enableAutomaticRotationSwitching", value)
            -- Send message to notify other components that the setting changed
            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            local rotationName = nil
            if specIndex then
                local currentRotation = select(1, classModule:GetCurrentRotation(specIndex))
                rotationName = currentRotation and currentRotation.name
            end
            NAG:SendMessage(ns.Messages.ROTATION_CHANGED, {
                specIndex = specIndex,
                rotationName = rotationName,
                dataChanged = false,
                selectionChanged = true,
                autoRotationToggled = true,
                action = "auto_rotation_toggle"
            })
            -- Show feedback to user
            if value then
                self:Info("Automatic rotation switching enabled")
            else
                self:Info("Automatic rotation switching disabled")
            end

            local floatingSelector = NAG:GetModule("FloatingSelector", true)
            if floatingSelector and floatingSelector.SetAutoRotationSpamEnabled then
                floatingSelector:SetAutoRotationSpamEnabled(false)
            end
        end
    end)
    togglesGroup:AddChild(autoRotationToggle)

    -- Show only current spec toggle
    local specFilterToggle = AceGUI:Create("CheckBox")
    specFilterToggle:SetLabel("Show Only Current Spec Rotations")
    specFilterToggle:SetWidth(400)

    -- Set initial value
    specFilterToggle:SetValue(self.db.char.showOnlyCurrentSpec)

    -- Add tooltip
    specFilterToggle:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
        GameTooltip:SetText("Show Only Current Spec Rotations")
        GameTooltip:AddLine("Filter rotations to show only those for your current specialization. Uncheck to see all class rotations.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    specFilterToggle:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)

    specFilterToggle:SetCallback("OnValueChanged", function(_, _, value)
        self.db.char.showOnlyCurrentSpec = value
        self:RefreshRotationList()
    end)
    togglesGroup:AddChild(specFilterToggle)

    frame:AddChild(togglesGroup)

    -- Store references for potential future updates
    self.autoRotationToggle = autoRotationToggle
    self.showOnlyCurrentSpecToggle = specFilterToggle

    -- Add header
    local header = AceGUI:Create("SimpleGroup")
    header:SetFullWidth(true)
    header:SetLayout("Table")
    header:SetUserData("table", {
        columns = {
            { width = 105 }, -- Actions (icon column, slightly wider for 4 icons)
            { width = 190 }, -- Name (reduced for better spacing)
            { width = 140 }, -- Author (increased for co-authors)
            { width = 70 },  -- Last Modified (increased for better spacing)
            { width = 80 },  -- Modified By (reduced)
            { width = 60 }   -- Enabled
        },
        space = 5,
        align = "LEFT"
    })

    -- Add header labels (first column is blank for actions)
    local headers = {
        { text = "",                                           align = "CENTER" },
        { text = L["rotationName"] or "Name",                  align = "LEFT" },
        { text = L["rotationAuthor"] or "Author",              align = "LEFT" },
        { text = L["rotationLastModified"] or "Last Modified", align = "LEFT" },
        { text = L["rotationModifiedBy"] or "Modified By",     align = "LEFT" },
        { text = L["rotationEnabled"] or "Enabled",            align = "LEFT" }
    }

    for _, headerInfo in ipairs(headers) do
        local label = AceGUI:Create("InteractiveLabel")
        label:SetText(headerInfo.text)
        label:SetJustifyH(headerInfo.align)
        label:SetFullWidth(true)
        header:AddChild(label)
    end

    frame:AddChild(header)

    -- Add scrolling container for rotation list
    local scrollContainer = AceGUI:Create("SimpleGroup")
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetFullHeight(true)
    scrollContainer:SetLayout("Fill")

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Table")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetUserData("table", {
        columns = {
            { width = 105 }, -- Actions (icon column, slightly wider for 4 icons)
            { width = 190 }, -- Name (reduced for better spacing)
            { width = 140 }, -- Author (increased for co-authors)
            { width = 70 },  -- Last Modified (increased for better spacing)
            { width = 80 },  -- Modified By (reduced)
            { width = 80 }   -- Enabled
        },
        space = 5,
        align = "LEFT"
    })

    scrollContainer:AddChild(scroll)
    frame:AddChild(scrollContainer)


    -- Store references
    self.frame = frame
    self.scroll = scroll
    self.autoRotationToggle = autoRotationToggle

    -- Set up frame status
    frame:SetStatusText("")
    frame:Hide()
end

-- ============================ WINDOW STATE ============================
--- Ensure the AceGUI Frame has a valid status table seeded from defaults or legacy fields.
--- @param frame table AceGUI Frame widget
function RotationManager:EnsureFrameStatus(frame)
    local status = self.db.char.frameStatus or {}

    -- Seed from legacy framePosition/frameSize if status empty
    if not status.left or not status.top or not status.width or not status.height then
        frame.frame:ClearAllPoints()
        frame.frame:SetPoint(
            self.db.char.framePosition.point or DEFAULT_FRAME_ANCHOR.point,
            UIParent,
            self.db.char.framePosition.relativePoint or DEFAULT_FRAME_ANCHOR.relativePoint,
            self.db.char.framePosition.x or DEFAULT_FRAME_ANCHOR.x,
            self.db.char.framePosition.y or DEFAULT_FRAME_ANCHOR.y
        )
        status.left = frame.frame:GetLeft()
        status.top = frame.frame:GetTop()
        status.width = self.db.char.frameSize.width or DEFAULT_FRAME_SIZE.width
        status.height = self.db.char.frameSize.height or DEFAULT_FRAME_SIZE.height
    end

    self.db.char.frameStatus = status
    frame:SetStatusTable(status)
end

--- Refresh the automatic rotation switching toggle state
function RotationManager:RefreshAutoRotationToggle()
    if self.autoRotationToggle then
        local classModule = NAG:GetClassModule()
        if classModule then
            local currentState = classModule:IsAutomaticRotationSwitchingEnabled()
            self.autoRotationToggle:SetValue(currentState)
        end
    end
end

--- Lightweight refresh that only updates selection highlights without revalidating rotations
--- Used when only the rotation selection changed, not the rotation data itself
function RotationManager:RefreshRotationHighlight()
    if not self.scroll then return end

    -- For now, just call full refresh since the UI is already optimized with cache
    -- In the future, we could implement a more targeted highlight update
    self:RefreshRotationList()
end

function RotationManager:RefreshRotationList()
    if self.debug then self:Debug("RefreshRotationList: Starting") end

    -- Refresh the automatic rotation switching toggle state
    self:RefreshAutoRotationToggle()

    if not self.scroll then return end
    self.scroll:ReleaseChildren()

    -- Get current spec using cached data
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0

    -- Get class module
    --- @type ClassBase|AceModule|CoreModule
    local classModule = NAG:GetClassModule()
    if not classModule then
        return
    end

    -- Get rotations and current selection
    local showAllSpecs = not self.db.char.showOnlyCurrentSpec
    local rotations, displayNames = classModule:GetAvailableRotations(specIndex, showAllSpecs)
    local currentRotation = select(2, classModule:GetCurrentRotation())
    if not rotations then
        return
    end

    -- Convert to sorted array and use cached validation results
    local rotationList = {}
    for name, config in pairs(rotations) do
        -- Debug: Check if specIndex is missing from config
        if not config.specIndex then
            self:Warn("RefreshRotationList: Rotation '%s' missing specIndex in config, using fallback 0", name)
        end
        -- Check cache first to avoid revalidation
        local cacheKey = string.format("%d:%s", config.specIndex or 0, name)
        local metadata = self.rotationCacheMetadata[cacheKey]

        local isValid, validationError
        if metadata then
            -- Use cached validation result
            isValid = metadata.isValid
            validationError = metadata.validationError
            self:Trace("RefreshRotationList: Using cached validation for: " .. cacheKey)
        else
            -- Not in cache (shouldn't happen after PrecompileAllRotations)
            self:Debug("RefreshRotationList: Cache miss for rotation: " .. cacheKey .. ", validating...")
            isValid, validationError = self:ValidateRotation(config)
        end

        tinsert(rotationList, {
            name = name,
            displayName = displayNames[name],
            config = config,
            isSelected = (name == currentRotation),
            isValid = isValid,
            validationError = validationError
        })
    end

    -- Sort by name
    tsort(rotationList, function(a, b) return a.name < b.name end)

    -- Filter by search text if present
    local filteredList = {}
    local search = self.searchText or ""
    for _, rotation in ipairs(rotationList) do
        if search == "" or (rotation.displayName and rotation.displayName:lower():find(search, 1, true)) or (rotation.name and rotation.name:lower():find(search, 1, true)) then
            tinsert(filteredList, rotation)
        end
    end

    -- Check for rotation errors and show status message
    local errorCount = 0
    local validCount = 0
    for _, rotation in ipairs(filteredList) do
        if not rotation.isValid then
            errorCount = errorCount + 1
        else
            validCount = validCount + 1
        end
    end

    -- Check for rotation switching conflicts
    local conflicts = self:DetectRotationSwitchingConflicts(classModule, rotations)
    local conflictCount = #conflicts

    -- Build a set of rotation names that are in conflict for quick lookup
    local conflictingRotations = {}
    for _, conflict in ipairs(conflicts) do
        for _, rotationName in ipairs(conflict.rotations) do
            conflictingRotations[rotationName] = true
        end
    end

    -- Update frame status text
    if self.frame then
        local statusText = ""
        if errorCount > 0 then
            statusText = format("|cFFFF0000Warning: %d rotation(s) have compilation errors|r", errorCount)
            if validCount > 0 then
                statusText = statusText .. format(" |cFF00FF00(%d valid rotation(s) available)|r", validCount)
            end
        elseif conflictCount > 0 then
            -- Show conflicts in RED when no compilation errors
            statusText = format("|cFFFF0000Warning: %d rotation switching conflict(s) detected!|r", conflictCount)
        else
            statusText = format("|cFF00FF00All %d rotation(s) are valid|r", validCount)
        end
        self.frame:SetStatusText(statusText)
        self.frame:ApplyStatus()
    end

    -- Use filteredList instead of rotationList in the for loop
    for _, rotation in ipairs(filteredList) do
        -- Actions as icons before the name
        local actionsGroup = AceGUI:Create("SimpleGroup")
        actionsGroup:SetLayout("Flow")
        actionsGroup:SetFullWidth(true)
        actionsGroup:SetWidth(120)

        -- Select icon
        local selectIcon = AceGUI:Create("Icon")
        selectIcon:SetImage("Interface\\Buttons\\UI-CheckBox-Check")
        selectIcon:SetImageSize(18, 18)
        selectIcon:SetWidth(20)
        selectIcon:SetHeight(20)
        selectIcon:SetDisabled(rotation.isSelected or not rotation.isValid)

        -- Apply color tinting based on selection and error state
        if rotation.isSelected then
            selectIcon.image:SetVertexColor(1, 1, 1, 1)       -- Full color for selected rotation
        elseif not rotation.isValid then
            selectIcon.image:SetVertexColor(1, 0, 0, 1)       -- Red for error rotations
        else
            selectIcon.image:SetVertexColor(0.5, 0.5, 0.5, 1) -- Gray for unselected rotations
        end

        -- Add tooltip
        selectIcon:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            if not rotation.isValid then
                GameTooltip:SetText("|cFFFF0000Cannot Select|r", 1, 0, 0)
                GameTooltip:AddLine("This rotation has compilation errors:", 1, 1, 1)
                GameTooltip:AddLine("|cFFFFAAAA" .. tostring(rotation.validationError) .. "|r", 1, 1, 1, true)
            else
                GameTooltip:SetText(L["rotationSelect"] or "Select")
            end
            GameTooltip:Show()
        end)
        selectIcon:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)

        selectIcon:SetCallback("OnClick", function()
            -- Skip if rotation has errors (already validated above)
            if not rotation.isValid then
                self:Error("Cannot select rotation with compilation errors: " .. tostring(rotation.validationError))
                return
            end
            -- Get specIndex from rotation config or use current spec
            local rotationSpecIndex = (rotation.config and rotation.config.specIndex) or specIndex
            classModule:SelectRotation(rotationSpecIndex, rotation.name)
            self:RefreshRotationList()
        end)
        actionsGroup:AddChild(selectIcon)

        -- Edit/Copy icon - different behavior for default vs custom rotations
        local editIcon = AceGUI:Create("Icon")
        local isDefaultRotation = not rotation.config.userModified

        if isDefaultRotation then
            -- For default rotations: Show copy icon
            editIcon:SetImage("Interface\\Buttons\\UI-RefreshButton")
            editIcon:SetCallback("OnEnter", function(widget)
                GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                GameTooltip:SetText(L["rotationCopyToCustom"] or "Copy to Custom")
                GameTooltip:AddLine(L["rotationCopyToCustomDesc"] or "Create an editable copy of this default rotation",
                    1, 1, 1, true)
                if Version:IsTBC() then
                    GameTooltip:AddLine("TBC: Basic editor only (no aplProto support)",
                        0.6, 0.8, 1, true)
                else
                    GameTooltip:AddLine(L["rotationShiftOpensAdvancedEditor"] or "Hold Shift to open the advanced editor",
                        0.6, 0.8, 1, true)
                end
                GameTooltip:Show()
            end)
            editIcon:SetCallback("OnClick", function()
                -- Copy default rotation to custom
                -- Use the rotation's specIndex, not the current UI specIndex
                local rotationSpecIndex = rotation.config.specIndex or specIndex
                -- TBC uses no aplProto, so only allow basic editor
                -- Basic editor is default, Shift+click for advanced
                local isTBC = Version:IsTBC()
                local openAdvancedEditor = not isTBC and (IsShiftKeyDown and IsShiftKeyDown())
                self:CopyDefaultToCustom(rotationSpecIndex, rotation, classModule, openAdvancedEditor)
            end)
        else
            -- For custom rotations: Show edit icon
            editIcon:SetImage("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
            editIcon:SetCallback("OnEnter", function(widget)
                GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                GameTooltip:SetText(L["rotationEdit"] or "Edit")
                if Version:IsTBC() then
                    GameTooltip:AddLine("TBC: Basic editor only (no aplProto support)",
                        0.6, 0.8, 1, true)
                else
                    GameTooltip:AddLine(L["rotationShiftOpensAdvancedEditor"] or "Hold Shift to open the advanced editor",
                        0.6, 0.8, 1, true)
                end
                GameTooltip:Show()
            end)
            editIcon:SetCallback("OnClick", function()
                -- Edit custom rotation
                -- Use the rotation's specIndex, not the current UI specIndex
                local rotationSpecIndex = rotation.config.specIndex or specIndex
                -- TBC uses no aplProto, so only allow basic editor
                -- Basic editor is default, Shift+click for advanced
                local isTBC = Version:IsTBC()
                local useAdvancedEditor = not isTBC and (IsShiftKeyDown and IsShiftKeyDown())
                if useAdvancedEditor then
                    self:EditCustomRotation(rotationSpecIndex, rotation, classModule)
                else
                    self:EditCustomRotationBasic(rotationSpecIndex, rotation, classModule)
                end
            end)
        end

        editIcon:SetImageSize(18, 18)
        editIcon:SetWidth(20)
        editIcon:SetHeight(20)
        editIcon:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)
        actionsGroup:AddChild(editIcon)

        -- Visual Editor icon (devmode only, for custom rotations, disabled for TBC)
        if NAG:IsDevModeEnabled() and not isDefaultRotation and not Version:IsTBC() then
            local visualEditorIcon = AceGUI:Create("Icon")
            visualEditorIcon:SetImage("Interface\\Icons\\INV_Misc_Book_09")
            visualEditorIcon:SetImageSize(18, 18)
            visualEditorIcon:SetWidth(20)
            visualEditorIcon:SetHeight(20)
            visualEditorIcon:SetCallback("OnEnter", function(widget)
                GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                GameTooltip:SetText(L["visualEditorAdvanced"] or "Advanced Editor")
                GameTooltip:AddLine(L["visualEditorAdvancedDesc"] or "Open the advanced tabbed editor for this rotation", 1, 1, 1, true)
                GameTooltip:Show()
            end)
            visualEditorIcon:SetCallback("OnLeave", function()
                GameTooltip:Hide()
            end)
            visualEditorIcon:SetCallback("OnClick", function()
                -- Open advanced (RotationEditor)
                local rotationSpecIndex = rotation.config.specIndex or specIndex
                local advancedRotation = {
                    name = rotation.name,
                    config = rotation.config
                }
                if ns.RotationEditor then
                    ns.RotationEditor:ShowEditor(rotationSpecIndex, advancedRotation, classModule, nil)
                else
                    self:Error("RotationEditor not available")
                end
            end)
            actionsGroup:AddChild(visualEditorIcon)
        end

        -- Export icon
        local exportIcon = AceGUI:Create("Icon")
        exportIcon:SetImage("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
        exportIcon:SetImageSize(18, 18)
        exportIcon:SetWidth(20)
        exportIcon:SetHeight(20)

        -- Add tooltip
        exportIcon:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["rotationExport"] or "Export")
            GameTooltip:AddLine(
                "Export rotation for backup or sharing. Use this before profile migration to preserve custom rotations.",
                1,
                1, 1, true)
            GameTooltip:Show()
        end)
        exportIcon:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)

        exportIcon:SetCallback("OnClick", function()
            if ImportExport then
                local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or 0
                local exportString, err = ImportExport:ExportRotation(specIndex, rotation.name)
                if not exportString then
                    self:Error("Failed to export rotation: " .. tostring(err))
                    return
                end
                StaticPopup_Show("NAG_EXPORT_ROTATION_STRING", nil, nil, exportString)
            end
        end)
        actionsGroup:AddChild(exportIcon)

        -- Delete/Reset icon (context-dependent)
        local deleteIcon = AceGUI:Create("Icon")
        local isDefault = not rotation.config.userModified

        -- If rotation has errors, always show delete (even for defaults)
        -- Resetting a broken rotation won't help, so deletion is more appropriate
        local showDelete = not rotation.isValid or not isDefault

        -- Set different icon for defaults vs customs
        if showDelete then
            deleteIcon:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Up") -- Delete icon
        else
            deleteIcon:SetImage("Interface\\Buttons\\UI-RefreshButton") -- Refresh/reset icon
        end

        deleteIcon:SetImageSize(18, 18)
        deleteIcon:SetWidth(20)
        deleteIcon:SetHeight(20)

        -- Add tooltip
        deleteIcon:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            if showDelete then
                if not rotation.isValid then
                    GameTooltip:SetText(L["rotationDelete"] or "Delete")
                    GameTooltip:AddLine("Delete this rotation with compilation errors", 1, 1, 1, true)
                else
                    GameTooltip:SetText(L["rotationDelete"] or "Delete")
                    GameTooltip:AddLine(L["rotationDeleteDesc"] or "Permanently remove this custom rotation", 1, 1, 1, true)
                end
            else
                GameTooltip:SetText(L["rotationResetToDefaults"] or "Reset to Defaults")
                GameTooltip:AddLine(L["rotationResetToDefaultsDesc"] or "Remove any customizations and restore addon defaults", 1, 1, 1, true)
            end
            GameTooltip:Show()
        end)
        deleteIcon:SetCallback("OnLeave", function()
            GameTooltip:Hide()
        end)

        deleteIcon:SetCallback("OnClick", function()
            local rotationSpecIndex = rotation.config.specIndex or specIndex
            self:Debug("DeleteIcon OnClick: rotation='%s', config.specIndex=%s, fallback specIndex=%s, using rotationSpecIndex=%s",
                rotation.name,
                tostring(rotation.config.specIndex),
                tostring(specIndex),
                tostring(rotationSpecIndex))

            if showDelete then
                -- Delete rotation (either custom or default with errors)
                -- Capture rotationSpecIndex in closure for OnAccept callback
                local deleteSpecIndex = rotationSpecIndex
                StaticPopupDialogs["NAG_DELETE_ROTATION_CONFIRM"] = {
                    text = format(
                        L["rotationDeleteConfirm"] or "Are you sure you want to delete '%s'?\nThis cannot be undone.",
                        rotation.name),
                    button1 = YES,
                    button2 = NO,
                    OnShow = function(dialog)
                        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                        dialog:SetFrameLevel(200)
                    end,
                    OnAccept = function()
                        self:Debug("DeleteRotation OnAccept: rotation='%s', deleteSpecIndex=%s", rotation.name, tostring(deleteSpecIndex))
                        if not classModule:HasRotation(deleteSpecIndex, rotation.name) then
                            self:Warn("DeleteRotation: Rotation '%s' not found for specIndex %s", rotation.name, tostring(deleteSpecIndex))
                            return
                        end
                        classModule:DeleteRotation(deleteSpecIndex, rotation.name)
                        if classModule:GetSelectedRotation(deleteSpecIndex) == rotation.name then
                            -- Clear the cached function first
                            NAG.cachedRotationFunc = nil
                            classModule:SetSelectedRotation(deleteSpecIndex, nil)
                            classModule:EnsureDefaultRotation()

                            -- Check if we found a new rotation, if not then stop the timer
                            local newRotation = classModule:GetSelectedRotation(deleteSpecIndex)
                            if not newRotation then
                                if TimerManager.Cancel then
                                    TimerManager:Cancel(TimerManager.Categories.ROTATION, "rotation")
                                end
                            end
                        end
                        self:ClearRotationCache(deleteSpecIndex)
                        -- Also clear rotation switching cache for complete cleanup
                        self:ClearRotationSwitchingCache()
                        AceConfigRegistry:NotifyChange("NAG")
                        self:RefreshRotationList()
                        self:Info(format(L["rotationDeleteSuccess"] or "Successfully deleted rotation '%s'", rotation.name))
                    end,
                    timeout = 0,
                    whileDead = true,
                    hideOnEscape = true,
                    preferredIndex = 3,
                }
                StaticPopup_Show("NAG_DELETE_ROTATION_CONFIRM")
            else
                -- Reset default rotation to addon defaults (only for valid default rotations)
                self:ResetRotationToDefaults(rotationSpecIndex, rotation.name, classModule)
            end
        end)
        actionsGroup:AddChild(deleteIcon)

        -- Name with selection indicator, rotation type, and error status
        local nameLabel = AceGUI:Create("InteractiveLabel")
        local displayName = rotation.displayName

        -- Add rotation type indicator
        if not rotation.config.userModified then
            -- Default rotation
            displayName = displayName .. " |cFF808080(Default)|r"
        else
            -- Custom rotation
            displayName = displayName .. " |cFF00AA00(Custom)|r"
        end

        -- Add error status indicator
        if not rotation.isValid then
            displayName = displayName .. " |cFFFF0000[ERROR]|r"
        end

        -- Add selection indicator
        if rotation.isSelected then
            displayName = format("|cFF00FF00%s|r", displayName)
        end

        nameLabel:SetText(displayName)
        nameLabel:SetFullWidth(true)

        -- Add tooltip for error details
        if not rotation.isValid then
            nameLabel:SetCallback("OnEnter", function(widget)
                GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                GameTooltip:SetText("|cFFFF0000Rotation Error|r", 1, 0, 0)
                GameTooltip:AddLine("This rotation has compilation errors and cannot be used:", 1, 1, 1)
                GameTooltip:AddLine("|cFFFFAAAA" .. tostring(rotation.validationError) .. "|r", 1, 1, 1, true)
                GameTooltip:Show()
            end)
            nameLabel:SetCallback("OnLeave", function()
                GameTooltip:Hide()
            end)
        end

        -- Author
        local authorLabel = AceGUI:Create("InteractiveLabel")
        local authorText
        if type(rotation.config.authors) == "table" then
            authorText = table.concat(rotation.config.authors, ", ")
        else
            authorText = rotation.config.author or "@APLParser"
        end
        authorLabel:SetText(authorText)
        authorLabel:SetFullWidth(true)

        -- Last Modified
        local lastModifiedLabel = AceGUI:Create("InteractiveLabel")
        lastModifiedLabel:SetText(formatDate(rotation.config.lastModified))
        lastModifiedLabel:SetFullWidth(true)

        -- Modified By
        local modifiedByLabel = AceGUI:Create("InteractiveLabel")
        modifiedByLabel:SetText(rotation.config.lastModifiedBy or L["rotationUnknown"])
        modifiedByLabel:SetFullWidth(true)

        -- Enabled Toggle
        local enabledToggle = AceGUI:Create("CheckBox")
        enabledToggle:SetValue(rotation.config.enabled)
        enabledToggle:SetLabel("")

        -- Highlight in RED if this rotation is in conflict, otherwise use default color
        if conflictingRotations[rotation.name] then
            -- Color the checkbox red to indicate conflict
            if enabledToggle.checkbg then
                enabledToggle.checkbg:SetVertexColor(1.0, 0.2, 0.2)
            end
            if enabledToggle.check then
                enabledToggle.check:SetVertexColor(1.0, 0.2, 0.2)
            end

            -- Add tooltip to explain the conflict
            enabledToggle:SetCallback("OnEnter", function(widget)
                GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                GameTooltip:SetText("|cFFFF0000Rotation Conflict Detected!|r", 1, 0, 0)
                GameTooltip:AddLine("This rotation has conflicting conditions with another enabled rotation.", 1, 1, 1, true)
                GameTooltip:AddLine("Both rotations may match the same context, causing unpredictable behavior.", 1, 1, 1, true)
                GameTooltip:Show()
            end)
            enabledToggle:SetCallback("OnLeave", function()
                GameTooltip:Hide()
            end)
        else
            -- Reset to default white color when no conflict
            if enabledToggle.checkbg then
                enabledToggle.checkbg:SetVertexColor(1.0, 1.0, 1.0)
            end
            if enabledToggle.check then
                enabledToggle.check:SetVertexColor(1.0, 1.0, 1.0)
            end
        end

        enabledToggle:SetCallback("OnValueChanged", function(_, _, value)
            local rotationSpecIndex = rotation.config.specIndex or specIndex
            local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            self:Debug("EnabledToggle OnValueChanged: rotation='%s', config.specIndex=%s, fallback specIndex=%s, using rotationSpecIndex=%s, currentSpecIndex=%s",
                rotation.name,
                tostring(rotation.config.specIndex),
                tostring(specIndex),
                tostring(rotationSpecIndex),
                tostring(currentSpecIndex))

            -- Only allow changing enabled state if we're in the correct spec
            if currentSpecIndex and rotationSpecIndex ~= currentSpecIndex then
                -- Revert the toggle
                enabledToggle:SetValue(rotation.config.enabled)
                self:Warn("Cannot change enabled state for rotations from a different spec")
                return
            end

            rotation.config.enabled = value
            -- Save the change to the database
            classModule:SaveRotation(rotationSpecIndex, rotation.name, rotation.config)
            self:Debug("EnabledToggle: Saved rotation '%s' with specIndex=%s, enabled=%s", rotation.name, tostring(rotationSpecIndex), tostring(value))
            -- Refresh the rotation list to update conflict detection
            self:RefreshRotationList()
        end)

        -- Add all columns in order for a single row
        self.scroll:AddChild(actionsGroup)
        self.scroll:AddChild(nameLabel)
        self.scroll:AddChild(authorLabel)
        self.scroll:AddChild(lastModifiedLabel)
        self.scroll:AddChild(modifiedByLabel)
        self.scroll:AddChild(enabledToggle)
    end
end

-- ~~~~~~~~~~ VALIDATION ~~~~~~~~~~

--- Copy a default rotation to create a custom editable copy
--- @param sourceSpecIndex number The specialization index (1,2,3) of the source rotation
--- @param rotation table The rotation data
--- @param classModule ClassBase The class module
--- @param openAdvancedEditor boolean|nil Whether to open the advanced editor after copying
function RotationManager:CopyDefaultToCustom(sourceSpecIndex, rotation, classModule, openAdvancedEditor)
    if not sourceSpecIndex then
        self:Error("No specialization available for copying")
        return false, "No specialization available for copying"
    end

    -- Create a copy of the default rotation
    local newConfig = CopyTable(rotation.config)
    -- If source lacked prePull/macros (e.g. old saved rotation), backfill from class default
    if classModule.defaults and classModule.defaults.class and classModule.defaults.class.rotations then
        local defaultRot = classModule.defaults.class.rotations[sourceSpecIndex] and classModule.defaults.class.rotations[sourceSpecIndex][rotation.name]
        if defaultRot then
            if (not newConfig.prePull or type(newConfig.prePull) ~= "table" or #newConfig.prePull == 0) and defaultRot.prePull and #defaultRot.prePull > 0 then
                newConfig.prePull = CopyTable(defaultRot.prePull)
            end
            if (not newConfig.macros or type(newConfig.macros) ~= "table" or #newConfig.macros == 0) and defaultRot.macros and #defaultRot.macros > 0 then
                newConfig.macros = CopyTable(defaultRot.macros)
            end
        end
    end
    newConfig.userModified = true
    newConfig.isBaseRotation = false
    newConfig.lastModified = time()
    newConfig.lastModifiedBy = StringUtil.GetBattleTagName(StringUtil.GetBattleTag())

    -- Keep the rotation in its original spec (use specIndex)
    -- This allows editing rotations for any spec without moving them
    newConfig.specIndex = sourceSpecIndex

    -- Generate a unique name for the custom copy
    local baseName = rotation.name
    local customName = baseName .. " (Custom)"

    -- Check if name already exists and generate unique name
    local counter = 1
    while classModule:HasRotation(sourceSpecIndex, customName) do
        counter = counter + 1
        customName = format("%s (Custom %d)", baseName, counter)
    end

    -- Save as custom rotation in the source spec (keeps rotation where it belongs)
    local success = classModule:SaveRotation(sourceSpecIndex, customName, newConfig)
    if success then
        -- Disable the original base rotation to prevent smart switching back to it
        -- Only disable if the original rotation is a base rotation (not already custom)
        if not rotation.config.userModified then
            local originalRotation = classModule:GetRotation(sourceSpecIndex, rotation.name)
            if originalRotation then
                local disabledConfig = CopyTable(originalRotation)
                disabledConfig.enabled = false
                disabledConfig.isBaseRotation = true  -- Preserve base rotation flag to prevent userModified=true
                classModule:SaveRotation(sourceSpecIndex, rotation.name, disabledConfig)
                self:Debug("Disabled original base rotation '%s' after creating custom copy '%s'",
                    rotation.name, customName)
            end
        end

        -- Only activate the rotation if we're currently in the same spec
        -- Otherwise, just save it and let the user switch to it later
        local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if currentSpecIndex and sourceSpecIndex == currentSpecIndex then
            local selectSuccess, err = classModule:SelectRotation(sourceSpecIndex, customName)
            if not selectSuccess then
                self:Warn("Failed to activate copied rotation: " .. tostring(err))
            end
        end

        -- Cache is automatically managed by SelectRotation now
        AceConfigRegistry:NotifyChange("NAG")
        self:RefreshRotationList()

        -- Show success message
        self:Info(format(L["rotationCopiedToCustom"] or "Successfully copied '%s' to custom rotation '%s'",
            rotation.name, customName))

        -- Open the editor for the new custom rotation (stays in source spec)
        local newRotation = {
            name = customName,
            config = newConfig
        }
        if openAdvancedEditor then
            self:EditCustomRotation(sourceSpecIndex, newRotation, classModule)
        else
            self:EditCustomRotationBasic(sourceSpecIndex, newRotation, classModule)
        end
    else
        self:Error(L["rotationCopyFailed"] or "Failed to copy rotation to custom")
    end
end

--- Edit a custom rotation
--- @param specIndex number The specialization index (1, 2, 3)
--- @param rotation table The rotation data
--- @param classModule ClassBase The class module
function RotationManager:EditCustomRotation(specIndex, rotation, classModule)
    -- RotationEditor is required - fail fast if not available
    if not ns.RotationEditor then
        self:Error("RotationEditor module not available - required for rotation editing")
        return
    end

    ns.RotationEditor:ShowEditor(specIndex, rotation, classModule, nil)
end

--- Edit a custom rotation using the basic editor
--- @param specIndex number The specialization index (1,2,3)
--- @param rotation table The rotation data
--- @param classModule ClassBase The class module
function RotationManager:EditCustomRotationBasic(specIndex, rotation, classModule)
    local BasicRotationStringEditor = ns.BasicRotationStringEditor
    if not BasicRotationStringEditor then
        self:Error("BasicRotationStringEditor module not available")
        return
    end

    BasicRotationStringEditor:ShowEditor(specIndex, rotation, classModule)
end

--- Reset a default rotation to addon defaults (remove user customizations)
--- @param specIndex number The specialization index (1,2,3)
--- @param rotationName string The rotation name
--- @param classModule ClassBase The class module
function RotationManager:ResetRotationToDefaults(specIndex, rotationName, classModule)
    StaticPopupDialogs["NAG_RESET_ROTATION_CONFIRM"] = {
        text = format(
            L["rotationResetConfirm"] or "Reset '%s' to addon defaults?\n\nThis will:\n- Re-enable the rotation\n- Remove any customizations\n- Restore original addon defaults",
            rotationName),
        button1 = YES,
        button2 = NO,
        OnShow = function(dialog)
            dialog:SetFrameStrata("FULLSCREEN_DIALOG")
            dialog:SetFrameLevel(200)
        end,
        OnAccept = function()
            -- Get the default rotation from self.defaults (addon defaults)
            local defaultRotation = nil
            if classModule.defaults and
               classModule.defaults.class and
               classModule.defaults.class.rotations and
               classModule.defaults.class.rotations[specIndex] then
                defaultRotation = classModule.defaults.class.rotations[specIndex][rotationName]
            end

            if defaultRotation then
                -- Clone the default and restore it to the database
                local resetConfig = CopyTable(defaultRotation)
                resetConfig.isBaseRotation = true  -- Mark as base rotation
                resetConfig.userModified = false    -- Not user-modified
                resetConfig.enabled = true          -- Re-enable it

                -- Save the reset rotation back to the database
                classModule:SaveRotation(specIndex, rotationName, resetConfig)

                self:Debug("ResetRotationToDefaults: Restored '%s' from addon defaults", rotationName)
            else
                -- If no default exists, just delete from database
                self:Warn("ResetRotationToDefaults: No default found for '%s', deleting from database", rotationName)
                classModule:DeleteRotation(specIndex, rotationName)
            end

            -- Clear caches to ensure fresh rotation is loaded
            self:ClearRotationCache(specIndex, rotationName)
            self:InvalidateSpellExtractionCache(specIndex, rotationName)

            -- If this was the currently selected rotation, re-select it to pick up the reset version
            if classModule:GetSelectedRotation(specIndex) == rotationName and defaultRotation then
                -- Clear cached function to force reload
                NAG.cachedRotationFunc = nil
                -- Re-select the same rotation name - will now get the reset version
                classModule:SelectRotation(specIndex, rotationName)
            end

            -- Refresh UI
            AceConfigRegistry:NotifyChange("NAG")
            self:RefreshRotationList()

            self:Info(format(L["rotationResetSuccess"] or "Reset '%s' to addon defaults", rotationName))
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("NAG_RESET_ROTATION_CONFIRM")
end

--- Multi-validator sync check - tests all appropriate validation methods and reports discrepancies
--- @param msg string Optional flags: "detailed" (verbose), "schema" (include SchemaValidator), "no-schema" (exclude SchemaValidator), "ast-only", "schema-only"
function RotationManager:ValidateAllRotationsMultiValidator(msg)
    -- Parse command options
    local detailedMode = false
    -- Consolidated default: use SchemaValidator only unless overridden by flags
    local includeASTValidator = false
    local includeSchemaValidator = true -- authoritative by default

    if msg then
        local msgLower = msg:lower()
        local options = {}
        for option in msgLower:gmatch("%S+") do
            options[option] = true
        end

        detailedMode = options["detailed"] or false

        -- Handle exclusive options first (only one can be active)
        if options["schema-only"] then
            includeASTValidator = false
            includeSchemaValidator = true
        elseif options["ast-only"] then
            includeASTValidator = true
            includeSchemaValidator = false
        else
            -- Keep consolidated defaults unless caller explicitly opts back in
            if options["ast"] or options["ast-based"] then
                includeASTValidator = true
            end
            if options["no-schema"] then
                includeSchemaValidator = false
            elseif options["schema"] then
                includeSchemaValidator = true
            end
        end
    end

    -- Get validator modules
    local NAGStringParser = NAG:GetModule("NAGStringParser", true)
    local EditorValidation = ns.RotationEditorValidation
    local SchemaBrowser = NAG:GetModule("SchemaBrowser")
    local SchemaValidator = NAG:GetModule("SchemaValidator", true)

    -- Check validator availability
    local validatorsAvailable = {
        astValidator = NAGStringParser ~= nil and EditorValidation ~= nil and SchemaBrowser ~= nil,
        schemaValidator = SchemaValidator ~= nil and SchemaValidator.initialized
    }

    -- Determine which validators are actually active
    local activeValidators = {
        astValidator = includeASTValidator and validatorsAvailable.astValidator,
        schemaValidator = includeSchemaValidator and validatorsAvailable.schemaValidator
    }

    local activeCount = 0
    if activeValidators.astValidator then activeCount = activeCount + 1 end
    if activeValidators.schemaValidator then activeCount = activeCount + 1 end

    NAG:Print("|cFFFFFF00=== Multi-Validator Sync Check ===|r")
    NAG:Print("Testing NAG rotation string validation methods:")
    NAG:Print(format("  AST-based (Schema + EditorValidation): %s %s",
        validatorsAvailable.astValidator and "|cFF00FF00✓ Available|r" or "|cFFFF0000✗ Not Available|r",
        activeValidators.astValidator and "|cFF00FF00[ACTIVE]|r" or "|cFF888888[SKIPPED]|r"
    ))
    NAG:Print(format("  Schema-based (SchemaValidator): %s %s",
        validatorsAvailable.schemaValidator and "|cFF00FF00✓ Available|r" or "|cFFFF0000✗ Not Available|r",
        activeValidators.schemaValidator and "|cFF00FF00[ACTIVE]|r" or "|cFF888888[SKIPPED]|r"
    ))

    if not validatorsAvailable.astValidator and activeValidators.astValidator then
        if not EditorValidation then
            NAG:Print("|cFFFFAA00  Missing: RotationEditorValidation|r")
        end
    end

    if includeSchemaValidator and not validatorsAvailable.schemaValidator then
        if SchemaValidator == nil then
            NAG:Print("|cFFFFAA00  Missing: SchemaValidator module|r")
        elseif not SchemaValidator.initialized then
            NAG:Print("|cFFFFAA00  SchemaValidator not initialized|r")
        end
    end

    NAG:Print(format("|cFFAAAAFFActive validators: %d-way validation|r", activeCount))
    NAG:Print(" ")

    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Error("Class module not found")
        return
    end

    -- Get all rotations for all specs
    local rotations, displayNames = classModule:GetAvailableRotations(nil, true)

    -- Get spec names for better display
    local specNames = {}
    local rotationsBySpec = {}
    for name, config in pairs(rotations) do
        local specIndex = config.specIndex or 0
        if not rotationsBySpec[specIndex] then
            rotationsBySpec[specIndex] = {}
            -- Get spec name
            if specIndex > 0 then
                local specName = SpecCompat and SpecCompat:GetSpecName(specIndex)
                specNames[specIndex] = specName or ("Spec " .. specIndex)
            else
                specNames[specIndex] = "Unknown Spec"
            end
        end
        table.insert(rotationsBySpec[specIndex], {
            name = name,
            config = config,
            displayName = displayNames[name] or name
        })
    end

    NAG:Print(format("Class: %s (%d specs, %d rotations)",
        NAG.CLASS_FILENAME or "Unknown",
        TableUtils.Size(specNames),
        TableUtils.Size(rotations)
    ))
    NAG:Print(" ")

    -- Track overall statistics
    local stats = {
        totalRotations = 0,
        allAgreePass = 0,
        allAgreeFail = 0,
        discrepancies = 0,
        parsingErrors = 0,
        allThreeAgreePass = 0,
        allThreeAgreeFail = 0,
        twoAgree = 0,
        allDisagree = 0
    }

    local discrepancyDetails = {}

    -- Process each spec
    for specIndex, specRotations in pairs(rotationsBySpec) do
        NAG:Print(format("|cFF00CCFF[%s]|r", specNames[specIndex]))

        -- Sort rotations by display name for consistent output
        table.sort(specRotations, function(a, b) return a.displayName < b.displayName end)

        for _, rotation in ipairs(specRotations) do
            stats.totalRotations = stats.totalRotations + 1

            -- Run validation through all active systems
            local results = {
                astValidator = { valid = false, error = nil, method = "AST-based", skipped = false },
                schemaValidator = { valid = false, error = nil, method = "Schema-based", skipped = false }
            }

            -- AST Validator: Parse to AST then validate each clause
            if activeValidators.astValidator then
                -- Parse rotation string to AST
                local conversionService = NAG:GetModule("RotationConversionService", true)
                local ast, diagnostics = conversionService:ParseToProtoAST(rotation.config.rotationString, {
                    useCache = true,
                    validate = false,
                })

                if not ast then
                    local parseError = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "Parse failed"
                    results.astValidator.valid = false
                    results.astValidator.error = "Parse failed: " .. tostring(parseError)

                    -- Track rotation errors for SystemDiagnostics warnings
                    if ns.TrackRotationError then
                        local rotationName = rotation.displayName or rotation.name or "unknown"
                        ns.TrackRotationError(rotationName, "Parse failed: " .. tostring(parseError), { validator = "AST" })
                    end
                else
                    -- Validate each clause AST
                    local allClausesValid = true
                    local clauseErrors = {}

                    for i, listItem in ipairs(ast.priority_list or {}) do
                        local valid, err = EditorValidation:ValidateClauseAST(listItem)
                        if not valid then
                            allClausesValid = false
                            table.insert(clauseErrors, format("Clause #%d: %s", i, err))
                            -- Only collect first 3 errors to avoid spam
                            if #clauseErrors >= 3 then
                                table.insert(clauseErrors, "... (more errors)")
                                break
                            end
                        end
                    end

                    results.astValidator.valid = allClausesValid
                    if not allClausesValid then
                        local errorMsg = table.concat(clauseErrors, "; ")
                        results.astValidator.error = errorMsg

                        -- Track rotation errors for SystemDiagnostics warnings
                        if ns.TrackRotationError then
                            local rotationName = rotation.displayName or rotation.name or "unknown"
                            ns.TrackRotationError(rotationName, errorMsg, { validator = "AST" })
                        end
                    end
                end
            else
                results.astValidator.skipped = true
            end

            -- SchemaValidator: Full schema-based validation
            if activeValidators.schemaValidator then
                local rotationName = rotation.displayName or rotation.name or "unknown"
                local schemaValid, schemaError, schemaResults = SchemaValidator:ValidateAPLString(rotation.config.rotationString, rotationName)
                results.schemaValidator.valid = schemaValid
                results.schemaValidator.error = schemaError
                results.schemaValidator.validationInfo = schemaResults

                -- Track rotation errors for SystemDiagnostics warnings
                if not schemaValid and schemaError and ns.TrackRotationError then
                    ns.TrackRotationError(rotationName, schemaError, { validator = "Schema" })
                end
            else
                results.schemaValidator.skipped = true
            end

            -- Determine which validators are active and their results
            local activeResults = {}
            if activeValidators.astValidator then
                table.insert(activeResults, { name = "AST", valid = results.astValidator.valid, error = results.astValidator.error })
            end
            if activeValidators.schemaValidator then
                table.insert(activeResults, { name = "Schema", valid = results.schemaValidator.valid, error = results.schemaValidator.error })
            end

            -- Determine agreement status
            local allValid = true
            local allInvalid = true
            local hasDiscrepancy = false

            for _, result in ipairs(activeResults) do
                if result.valid then
                    allInvalid = false
                else
                    allValid = false
                end
            end

            -- Check for discrepancies (not all agree)
            if #activeResults > 1 then
                local firstValid = activeResults[1].valid
                for i = 2, #activeResults do
                    if activeResults[i].valid ~= firstValid then
                        hasDiscrepancy = true
                        break
                    end
                end
            end

            -- Build result string for display
            local resultParts = {}
            if activeValidators.astValidator then
                table.insert(resultParts, format("AST:%s", results.astValidator.valid and "PASS" or "FAIL"))
            end
            if activeValidators.schemaValidator then
                table.insert(resultParts, format("Schema:%s", results.schemaValidator.valid and "PASS" or "FAIL"))
            end
            local resultString = table.concat(resultParts, " ")

            -- Print result with appropriate color
            if hasDiscrepancy then
                stats.discrepancies = stats.discrepancies + 1
                if activeCount == 3 then
                    stats.twoAgree = stats.twoAgree + 1
                end
                NAG:Print(format("  |cFFFF0000✗ DISCREPANCY|r - %s - %s",
                    rotation.displayName, resultString
                ))

                -- Store for detailed output
                table.insert(discrepancyDetails, {
                    spec = specNames[specIndex],
                    rotation = rotation.displayName,
                    results = results,
                    validatorsAvailable = validatorsAvailable,
                    activeValidators = activeValidators
                })

                -- Show errors in detailed mode
                if detailedMode then
                    if activeValidators.astValidator and results.astValidator.error then
                        NAG:Print(format("     AST-based Error: %s", results.astValidator.error))
                    end
                    if activeValidators.schemaValidator and results.schemaValidator.error then
                        NAG:Print(format("     Schema-based Error: %s", results.schemaValidator.error))
                    end
                end
            elseif allValid then
                if activeCount == 3 then
                    stats.allThreeAgreePass = stats.allThreeAgreePass + 1
                else
                    stats.allAgreePass = stats.allAgreePass + 1
                end
                local agreeText = activeCount == 3 and "ALL AGREE" or "BOTH AGREE"
                NAG:Print(format("  |cFF00FF00✓|r %s - %s (PASS)", rotation.displayName, agreeText))
            elseif allInvalid then
                if activeCount == 3 then
                    stats.allThreeAgreeFail = stats.allThreeAgreeFail + 1
                else
                    stats.allAgreeFail = stats.allAgreeFail + 1
                end
                local errorMsg = results.astValidator.error or results.schemaValidator.error or "Unknown error"
                -- Truncate long error messages for summary view
                if #errorMsg > 80 and not detailedMode then
                    errorMsg = errorMsg:sub(1, 77) .. "..."
                end
                local agreeText = activeCount == 3 and "ALL AGREE" or "BOTH AGREE"
                NAG:Print(format("  |cFFFFAA00⚠|r %s - %s (FAIL): %s", rotation.displayName, agreeText, errorMsg))

                if detailedMode then
                    local errors = {}
                    if activeValidators.astValidator and results.astValidator.error then
                        table.insert(errors, format("AST-based: %s", results.astValidator.error))
                    end
                    if activeValidators.schemaValidator and results.schemaValidator.error then
                        table.insert(errors, format("Schema-based: %s", results.schemaValidator.error))
                    end
                    if #errors > 1 then
                        for _, errMsg in ipairs(errors) do
                            NAG:Print(format("     %s", errMsg))
                        end
                    end
                end
            end
        end

        NAG:Print(" ")
    end

    -- Print summary
    NAG:Print("|cFFFFFF00=== Summary ===|r")
    if activeCount == 3 then
        NAG:Print(format("- %d/%d rotations: All three validators agree (PASS) |cFF00FF00✓|r",
            stats.allThreeAgreePass, stats.totalRotations))
        NAG:Print(format("- %d/%d rotations: All three validators agree (FAIL) |cFFFFAA00⚠|r",
            stats.allThreeAgreeFail, stats.totalRotations))
        if stats.twoAgree > 0 then
            NAG:Print(format("- %d/%d rotations: Two validators agree (partial agreement) |cFFFFAA00⚠|r",
                stats.twoAgree, stats.totalRotations))
        end
    else
        NAG:Print(format("- %d/%d rotations: All validators agree (PASS) |cFF00FF00✓|r",
            stats.allAgreePass, stats.totalRotations))
        NAG:Print(format("- %d/%d rotations: All validators agree (FAIL) |cFFFFAA00⚠|r",
            stats.allAgreeFail, stats.totalRotations))
    end
    NAG:Print(format("- %d/%d rotations: DISCREPANCIES DETECTED |cFFFF0000✗|r",
        stats.discrepancies, stats.totalRotations))

    -- Print detailed discrepancy report if any exist
    if #discrepancyDetails > 0 then
        NAG:Print(" ")
        NAG:Print("|cFFFF0000=== Discrepancy Details ===|r")
        for _, detail in ipairs(discrepancyDetails) do
            NAG:Print(format("Rotation: %s/%s", detail.spec, detail.rotation))

            if detail.activeValidators.astValidator then
                NAG:Print(format("  AST-based (Schema + EditorValidation): %s",
                    detail.results.astValidator.valid and "|cFF00FF00PASS|r" or "|cFFFF0000FAIL|r"
                ))
                if detail.results.astValidator.error then
                    NAG:Print(format("    Error: %s", detail.results.astValidator.error))
                end
            end

            if detail.activeValidators.schemaValidator then
                NAG:Print(format("  Schema-based (SchemaValidator): %s",
                    detail.results.schemaValidator.valid and "|cFF00FF00PASS|r" or "|cFFFF0000FAIL|r"
                ))
                if detail.results.schemaValidator.error then
                    NAG:Print(format("    Error: %s", detail.results.schemaValidator.error))
                end
            end

            local validatorCount = 0
            if detail.activeValidators.astValidator then validatorCount = validatorCount + 1 end
            if detail.activeValidators.schemaValidator then validatorCount = validatorCount + 1 end

            NAG:Print("  |cFFFFAA00→ These validators should produce identical results|r")
            NAG:Print(" ")
        end
    end

    -- Final conclusion
    NAG:Print("|cFFFFFF00=== Analysis ===|r")
    local totalAgreeFail = activeCount == 3 and stats.allThreeAgreeFail or stats.allAgreeFail

    if stats.discrepancies == 0 and totalAgreeFail == 0 then
        NAG:Print("|cFF00FF00✓ Perfect sync! All active validators agree on all rotations.|r")
        NAG:Print("|cFF00FF00  Safe to consolidate validators.|r 🎯")
    elseif stats.discrepancies == 0 then
        NAG:Print("|cFFFFAA00✓ Validators are in sync, but found %d rotation(s) with consistent validation failures.|r", totalAgreeFail)
        NAG:Print("|cFFFFAA00  These rotations need fixing, but validators agree on the problems.|r")
        NAG:Print("|cFF00FF00  Safe to consolidate validators.|r 🎯")
    else
        NAG:Print("|cFFFF0000⚠ Validators are NOT in sync! Found %d discrepancies.|r", stats.discrepancies)
        NAG:Print("|cFFFF0000  Active validators disagree on these rotations.|r")
        NAG:Print("|cFFFF0000  DO NOT consolidate until discrepancies are resolved!|r")
    end

    NAG:Print(" ")
    NAG:Print("|cFF888888Usage: /nagdebug rotation validate-sync [detailed] [schema|no-schema|ast-only|schema-only]|r")
    NAG:Print("|cFF888888  Options: 'detailed' (verbose), 'schema' (include SchemaValidator), 'no-schema' (exclude SchemaValidator)|r")
    NAG:Print("|cFF888888  Use '/nagdebug rotation validate-sync detailed' for verbose error messages|r")
end

function RotationManager:ValidateAllRotations()
    local results = {}
    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Error("Class module not found")
        return results
    end

    -- Get all rotations for all specs
    local rotations, displayNames = classModule:GetAvailableRotations(nil, true)

    -- Validate each rotation (existing logic)
    for name, config in pairs(rotations) do
        local valid, err = self:ValidateRotation(config)
        local specIndex = config.specIndex or 0
        table.insert(results, {
            name = name,
            specIndex = specIndex,
            valid = valid,
            error = err,
            displayName = displayNames[name] or name
        })
    end

    -- NEW: Check for rotation switching conflicts per spec
    local conflicts = self:DetectRotationSwitchingConflicts(classModule, rotations)

    -- Print summary
    local numErrors = 0
    local numConflicts = 0

    -- Print compilation errors
    for _, result in ipairs(results) do
        if not result.valid then
            numErrors = numErrors + 1
            NAG:Print("|cFFFF0000[Rotation Error]|r " ..
                result.displayName .. " (SpecIndex: " .. tostring(result.specIndex) .. ") - " .. tostring(result.error))
        end
    end

    -- Print conflicts in RED
    for _, conflict in ipairs(conflicts) do
        numConflicts = numConflicts + 1
        NAG:Print("|cFFFF0000[Rotation Conflict]|r " .. conflict.message)
    end

    -- Final summary
    if numErrors == 0 and numConflicts == 0 then
        NAG:Print("|cFF00FF00All registered rotations validated successfully!|r")
    else
        if numErrors > 0 then
            NAG:Print("|cFFFF0000Found " .. numErrors .. " invalid rotation(s).|r")
        end
        if numConflicts > 0 then
            NAG:Print("|cFFFF0000Found " .. numConflicts .. " rotation switching conflict(s). Adjust conditions or disable smart switching on conflicting rotations.|r")
        end
    end

    return results, conflicts
end

--- Formats and displays all spells/items from all rotations
--- Uses AST-based extraction when aplProto is available, falls back to string-based extraction
--- @param formatArg string|nil "short" for icon-only display, "full" for detailed list (default: "short")
function RotationManager:FormatAllRotationSpells(formatArg)
    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Error("Class module not found")
        return
    end

    -- Parse format argument
    local useShortFormat = true
    if formatArg then
        local formatLower = strlower(formatArg)
        if formatLower == "full" then
            useShortFormat = false
        elseif formatLower == "short" then
            useShortFormat = true
        end
    end

    -- Get all rotations for all specs
    local rotations, displayNames = classModule:GetAvailableRotations(nil, true)
    if not rotations or next(rotations) == nil then
        NAG:Print("|cFFFFAA00No rotations found|r")
        return
    end

    if useShortFormat then
        NAG:Print("|cFFFFFF00=== Rotation Spells/Items (Short Format) ===|r")
    else
        NAG:Print("|cFFFFFF00=== Rotation Spells/Items Report (Full Format) ===|r")
    end
    NAG:Print(" ")

    local totalRotations = 0
    local totalSpells = 0
    local totalItems = 0
    local rotationsWithSpells = 0

    -- Group rotations by spec for better organization
    local rotationsBySpec = {}
    for name, config in pairs(rotations) do
        local specIndex = config.specIndex or 0
        if not rotationsBySpec[specIndex] then
            rotationsBySpec[specIndex] = {}
        end
        table.insert(rotationsBySpec[specIndex], {
            name = name,
            config = config,
            displayName = displayNames[name] or name
        })
    end

    -- Process each spec
    for specIndex, specRotations in pairs(rotationsBySpec) do
        -- Get spec name for display
        local specName = "Unknown Spec"
        if specIndex > 0 then
            specName = (SpecCompat and SpecCompat:GetSpecName(specIndex)) or ("Spec " .. specIndex)
        else
            specName = "All Specs"
        end

        if not useShortFormat then
            NAG:Print(format("|cFF00CCFF[%s]|r", specName))
        end

        -- Sort rotations by display name
        table.sort(specRotations, function(a, b) return a.displayName < b.displayName end)

        for _, rotation in ipairs(specRotations) do
            totalRotations = totalRotations + 1
            local actionIDs = {}
            local extractionMethod = "none"

            -- Try AST-based extraction first (if aplProto exists)
            if rotation.config.aplProto then
                local ASTCore = ns.ASTCore
                if ASTCore and rotation.config.aplProto.type == ASTCore.NodeType.ROTATION then
                    actionIDs = SchemaAccessor:ExtractIDsFromRotationNode(rotation.config.aplProto)
                    extractionMethod = "AST"
                end
            end

            -- Fallback to string-based extraction if AST extraction found nothing
            if #actionIDs == 0 and rotation.config.rotationString then
                -- Use existing spell extraction from rotation string
                local spellsByName = self:GetCachedSpellExtraction(rotation.config.specIndex or specIndex, rotation.name)
                if not spellsByName then
                    spellsByName = self:ExtractSpellsFromRotation(rotation.config.rotationString, rotation.name, rotation.config.specIndex or specIndex)
                end

                -- Convert spell extraction format to ActionID format for consistency
                if spellsByName then
                    for spellName, spellData in pairs(spellsByName) do
                        if spellData and spellData.spellIds then
                            for _, spellId in ipairs(spellData.spellIds) do
                                table.insert(actionIDs, { spell_id = spellId })
                            end
                        end
                    end
                end
                extractionMethod = "string"
            end

            -- Format the ActionIDs (use "short" format for icon-only display)
            local formatType = useShortFormat and "short" or "full"
            local formatted = SchemaAccessor:FormatSpellList(actionIDs, formatType)

            if #formatted > 0 then
                rotationsWithSpells = rotationsWithSpells + 1

                if useShortFormat then
                    -- Short format: formatted is already an array of icon strings
                    local iconRow = table.concat(formatted, " ")
                    NAG:Print(format("|cFF00FF00%s|r: %s |cFF888888(%s, %d)|r",
                        rotation.displayName, iconRow, extractionMethod, #formatted))

                    -- Count types for summary (count from actionIDs directly - no API calls needed)
                    local seenIDs = {}
                    local spellCount = 0
                    local itemCount = 0
                    for _, actionID in ipairs(actionIDs) do
                        if actionID then
                            local id = actionID.spell_id or actionID.item_id or actionID.other_id
                            if id and not seenIDs[id] then
                                seenIDs[id] = true
                                if actionID.spell_id then
                                    spellCount = spellCount + 1
                                elseif actionID.item_id then
                                    itemCount = itemCount + 1
                                elseif actionID.other_id then
                                    -- For other_id, we can't determine type without API call
                                    -- Just count as spell for now (most other_ids are spells)
                                    spellCount = spellCount + 1
                                end
                            end
                        end
                    end
                    totalSpells = totalSpells + spellCount
                    totalItems = totalItems + itemCount
                else
                    -- Full format: formatted is array of detailed objects
                    local spellCount = 0
                    local itemCount = 0
                    for _, item in ipairs(formatted) do
                        if item.type == "spell" then
                            spellCount = spellCount + 1
                        elseif item.type == "item" then
                            itemCount = itemCount + 1
                        end
                    end
                    totalSpells = totalSpells + spellCount
                    totalItems = totalItems + itemCount

                    -- Full format: detailed list with names
                    NAG:Print(format("  |cFF00FF00%s|r (%s extraction, %d spell(s), %d item(s))",
                        rotation.displayName, extractionMethod, spellCount, itemCount))

                    -- Show first 10 items (to avoid spam)
                    local showCount = math.min(#formatted, 10)
                    for i = 1, showCount do
                        local item = formatted[i]
                        local iconText = format("|T%d:16:16:0:0:64:64:4:60:4:60|t ", item.icon)
                        -- Use chat link if available (clickable with tooltip), otherwise use plain text
                        local displayText = item.chatLink or item.displayText
                        NAG:Print(format("    %s%s |cFFAAAAAA(%d)|r",
                            iconText, displayText, item.value))
                    end

                    if #formatted > 10 then
                        NAG:Print(format("    |cFF888888... and %d more|r", #formatted - 10))
                    end
                end
            else
                if useShortFormat then
                    NAG:Print(format("|cFF888888%s|r: (no spells/items)", rotation.displayName))
                else
                    NAG:Print(format("  |cFF888888%s|r (no spells/items found)", rotation.displayName))
                end
            end
        end

        if not useShortFormat then
            NAG:Print(" ")
        end
    end

    -- Print summary
    NAG:Print(" ")
    NAG:Print("|cFFFFFF00=== Summary ===|r")
    NAG:Print(format("- Total rotations: %d", totalRotations))
    NAG:Print(format("- Rotations with spells/items: %d", rotationsWithSpells))
    NAG:Print(format("- Total unique spells: %d", totalSpells))
    NAG:Print(format("- Total unique items: %d", totalItems))
    NAG:Print(" ")
    NAG:Print("|cFF888888Usage: /nagdebug rotation spells [short|full]|r")
end

--- Detects conflicts in rotation switching conditions
--- Checks if multiple rotations with smart switching enabled would match the same game context
--- @param classModule ClassBase The class module
--- @param rotations table All rotations (from GetAvailableRotations)
--- @return table Array of conflict descriptions
function RotationManager:DetectRotationSwitchingConflicts(classModule, rotations)
    local conflicts = {}

    -- Group rotations by specIndex
    local rotationsBySpec = {}
    for name, config in pairs(rotations) do
        local specIndex = config.specIndex or 0
        if not rotationsBySpec[specIndex] then
            rotationsBySpec[specIndex] = {}
        end
        rotationsBySpec[specIndex][name] = config
    end

    -- Check each spec for conflicts
    for specIndex, specRotations in pairs(rotationsBySpec) do
        -- Get only rotations with smart switching enabled
        local switchableRotations = {}
        for name, config in pairs(specRotations) do
            if config.enabled and
               config.enableSmartSwitching and
               config.customConditions and
               next(config.customConditions) then
                table.insert(switchableRotations, {name = name, config = config})
            end
        end

        -- Need at least 2 rotations to have a conflict
        if #switchableRotations >= 2 then
            -- Generate test contexts
            local testContexts = self:GenerateTestContexts()

            -- Track conflicts per context to avoid duplicates
            local seenConflicts = {}

            -- For each test context, check which rotations match
            for _, context in ipairs(testContexts) do
                local matchingRotations = {}

                for _, rotation in ipairs(switchableRotations) do
                    if classModule:IsRotationOptimalForContext(rotation.config, context) then
                        table.insert(matchingRotations, rotation.name)
                    end
                end

                -- If multiple rotations match, we have a conflict
                if #matchingRotations > 1 then
                    -- Create a unique key for this conflict (sorted rotation names)
                    table.sort(matchingRotations)
                    local conflictKey = table.concat(matchingRotations, "|")

                    -- Only report each unique conflict once
                    if not seenConflicts[conflictKey] then
                        seenConflicts[conflictKey] = true
                        local contextDesc = self:FormatContext(context)
                        local message = format(
                            "SpecIndex %d: Rotations match same context (%s): %s",
                            specIndex,
                            contextDesc,
                            table.concat(matchingRotations, ", ")
                        )
                        table.insert(conflicts, {
                            specIndex = specIndex,
                            context = context,
                            rotations = matchingRotations,
                            message = message
                        })
                    end
                end
            end
        end
    end

    return conflicts
end

--- Generates test contexts for conflict detection
--- Tests various combinations of target counts, weapon types, and group contexts
--- @return table Array of test contexts
function RotationManager:GenerateTestContexts()
    local contexts = {}

    -- Test various target counts (1-10)
    for targetCount = 1, 10 do
        table.insert(contexts, {
            targetCount = targetCount,
            meleeTargetCount = targetCount,
            inCombat = true,
            weaponConfig = "2H", -- Test with 2H
            groupType = "solo"
        })
    end

    -- Test weapon configurations
    local weaponConfigs = {"2H", "DW", "1H+Shield"}
    for _, weaponType in ipairs(weaponConfigs) do
        table.insert(contexts, {
            targetCount = 1,
            meleeTargetCount = 1,
            inCombat = true,
            weaponConfig = weaponType,
            groupType = "solo"
        })
    end

    -- Test group contexts
    local groupTypes = {"solo", "group", "raid"}
    for _, groupType in ipairs(groupTypes) do
        table.insert(contexts, {
            targetCount = 1,
            meleeTargetCount = 1,
            inCombat = true,
            weaponConfig = "2H",
            groupType = groupType
        })
    end

    return contexts
end

--- Formats a context for display in conflict messages
--- @param context table The context to format
--- @return string Formatted context description
function RotationManager:FormatContext(context)
    local parts = {}

    if context.targetCount then
        table.insert(parts, format("targets=%d", context.targetCount))
    end

    if context.weaponConfig then
        table.insert(parts, format("weapon=%s", context.weaponConfig))
    end

    if context.groupType then
        table.insert(parts, format("group=%s", context.groupType))
    end

    return table.concat(parts, ", ")
end

-- Slash command to validate all rotations and print summary

-- ~~~~~~~~~~ SHAREINGAME INTEGRATION ~~~~~~~~~~

function RotationManager:InitializeShareInGame()
    -- Register handler for rotation data
    ShareInGame:RegisterHandler("rotation", function(sender, data)
        self:OnRotationReceived(sender, data)
    end)
end

--- Handle received rotation data from ShareInGame
--- @param sender string The sender's name
--- @param data table The received rotation data
function RotationManager:OnRotationReceived(sender, data)
    self:Info("Received rotation '%s' from %s", data.name or "Unknown", sender)

    -- Validate the received data
    if not data.rotation or not data.name then
        self:Warn("Invalid rotation data received from %s", sender)
        return
    end

    -- Convert the data to import format
    local importData = {
        name = data.name,
        specIndex = data.specIndex or 0, -- Support both for backward compatibility
        class = data.class or "UNKNOWN",
        rotationString = data.rotationString,
        apl = data.apl,
        prePull = data.prePull or {},
        macros = data.macros or {},
        burstTrackers = data.burstTrackers or {},
        resourceBar = data.resourceBar or {},
        enabled = data.enabled or true,
        userModified = data.userModified or true,
        gameType = data.gameType or "UNKNOWN",
        authors = data.authors or { sender },
        lastModified = data.lastModified or time(),
        exportTime = data.exportTime or time(),
        imported = true,
        importTime = time()
    }

    -- Import the rotation
    local success, result = ImportExport:ImportRotation(importData)
    if success then
        self:Info("Successfully imported rotation '%s' from %s", data.name, sender)
        -- Invalidate cache for the imported rotation if we can infer spec/name
        -- Import data uses specIndex
        local rotationName = importData.name
        if rotationName then
            -- Try to get specIndex from rotation config or current spec
            local classModule = NAG:GetClassModule()
            local specIndex = nil
            if classModule then
                -- Try to find the rotation to get its specIndex
                local allRotations = classModule:GetAvailableRotations(nil, true)
                if allRotations and allRotations[rotationName] then
                    specIndex = allRotations[rotationName].specIndex
                end
                -- Fall back to current spec if not found
                if not specIndex then
                    specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
                end
            end

            if specIndex ~= nil then
                self:InvalidateRotation(specIndex, rotationName)
                -- If this rotation is currently selected, re-activate to pick up new code
                if classModule then
                    local selectedName = classModule:GetSelectedRotation(specIndex)
                    if selectedName == rotationName then
                        self:SetActiveRotation(specIndex, rotationName)
                    end
                end
            end
        end
        -- Notify other modules that rotation data changed
        NAG:SendMessage(ns.Messages.ROTATION_CHANGED, {
            specIndex = specIndex,
            rotationName = rotationName,
            dataChanged = true,
            selectionChanged = false,
            action = "import_shared"
        })
    else
        self:Error("Failed to import rotation from %s: %s", sender, result or "Unknown error")
    end
end

--- Share a rotation with another player
--- @param rotationName string The name of the rotation to share
--- @param targetPlayer string The target player name
function RotationManager:ShareRotation(rotationName, targetPlayer)
    if not rotationName or not targetPlayer then
        self:Error("ShareRotation: Invalid parameters")
        return false
    end

    -- Get the ShareInGame module

    -- Get the rotation data
    local classModule = NAG:GetClassModule()
    local rotation = classModule and classModule.GetRotationByName and classModule:GetRotationByName(rotationName)
    if not rotation then
        self:Error("Rotation '%s' not found", rotationName)
        return false
    end

    -- Prepare the data for sharing
    local shareData = {
        name = rotation.name,
        specIndex = rotation.specIndex,
        class = rotation.class,
        rotationString = rotation.rotationString,
        apl = rotation.apl,
        prePull = rotation.prePull,
        macros = rotation.macros,
        burstTrackers = rotation.burstTrackers,
        resourceBar = rotation.resourceBar,
        enabled = rotation.enabled,
        userModified = rotation.userModified,
        gameType = rotation.gameType,
        authors = rotation.authors,
        lastModified = rotation.lastModified,
        lastModifiedBy = rotation.lastModifiedBy,
        exportTime = time()
    }

    -- Send the rotation data
    local success = ShareInGame:Send(rotationName, shareData, targetPlayer, "rotation")
    if success then
        self:Info("Sent rotation '%s' to %s", rotationName, targetPlayer)
    else
        self:Error("Failed to send rotation '%s' to %s", rotationName, targetPlayer)
    end

    return success
end

-- ============================ CORE ROTATION FUNCTIONS ============================
-- These functions consolidate all rotation business logic from NAG.lua, config.lua, and ClassBase.lua



--- Validates a rotation configuration (core APL validation)
--- @param config table The rotation configuration to validate
--- @param forceValidation boolean Whether to force validation even if disabled (default: false)
--- @return boolean valid Whether the configuration is valid
--- @return string|nil error Error message if validation failed
function RotationManager:ValidateRotation(config, forceValidation)
    if not config then
        return false, "No config provided"
    end

    if not config.rotationString then
        self:Error("Missing rotationString")
        return false, "Missing rotationString"
    end

    -- Check cache before validating (unless forced)
    if not forceValidation then
        local cacheKey = string.format("%d:%s", config.specIndex or 0, config.name or "unknown")
        local metadata = self.rotationCacheMetadata and self.rotationCacheMetadata[cacheKey]

        if metadata then
            -- Return cached validation result
            self:Debug("ValidateRotation: Using cached validation result for: " .. cacheKey)
            return metadata.isValid, metadata.validationError
        end
    end

    -- Check if APL validation is disabled (unless forced)
    local SchemaValidator = NAG:GetModule("SchemaValidator", true)
    if not forceValidation and SchemaValidator and SchemaValidator:IsValidationDisabled() then
        self:Debug("APL validation is disabled, skipping ValidateRotation")
        return true, nil
    end

    if SchemaValidator then
        local rotationName = config.name or config.displayName or "unknown"
        local functionsValid, funcError = SchemaValidator:ValidateNAGFunctionsExist(config.rotationString, forceValidation, rotationName)
        if not functionsValid then
            self:Error("ValidateRotation: NAG functions validation failed: " .. tostring(funcError))
            return false, funcError
        end
    else
        if ns.DevDebugUtils and ns.DevDebugUtils.IsDebugEnabled(NAG, "RotationManager") then
            self:Warn("SchemaValidator not available, skipping function validation")
        end
    end

    -- Try to compile to catch syntax errors (only if not cached)
    local func, err = self:CompileRotation(config.rotationString)
    if not func then
        self:Error("ValidateRotation: Compilation failed: " .. tostring(err))
        return false, format("Failed to compile: %s", err)
    end

    return true, nil
end

--- Validates rotation configuration including business logic and SpellbookManager integration
--- @param rotationConfig table The rotation configuration to validate
--- @return boolean valid Whether the configuration is valid
--- @return string|nil error Error message if validation failed
function RotationManager:ValidateRotationConfig(rotationConfig)
    if not rotationConfig then
        return false, "No rotation configuration provided"
    end

    if not rotationConfig.rotationString then
        return false, "Missing rotation string"
    end

    -- First validate the core APL (syntax, functions, compilation)
    local valid, err = self:ValidateRotation(rotationConfig)
    if not valid then
        return false, "Core validation failed: " .. tostring(err)
    end

    -- Perform SpellbookManager deduplication (preserving EXACT logic from ClassBase)
    self:PerformSpellLocationDeduplication(rotationConfig)

    self:Debug("ValidateRotationConfig: Successfully validated rotation configuration")
    return true, nil
end

--- Performs spell location deduplication using SpellbookManager (preserving exact logic from ClassBase)
--- @param rotationConfig table The rotation configuration to deduplicate
function RotationManager:PerformSpellLocationDeduplication(rotationConfig)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    local classModule = NAG:GetClassModule()
    local currentRotation = classModule and select(1, classModule:GetCurrentRotation(specIndex)) or nil
    local useCustomSpellLocations = currentRotation and currentRotation.useCustomSpellLocations or false

    if useCustomSpellLocations and rotationConfig.spellLocations then
        -- Custom mode: deduplicate rotation.spellLocations
        local dedupResult = SpellbookManager:DeduplicateSpellLocations(rotationConfig.spellLocations)
        if dedupResult.duplicates and #dedupResult.duplicates > 0 then
            -- Apply deduplication to the rotation data
            wipe(rotationConfig.spellLocations)
            for spellId, position in pairs(dedupResult.deduplicatedData) do
                rotationConfig.spellLocations[spellId] = position
            end

            -- Save the deduplicated data back to the database
            if specIndex then
                local classModule = NAG:GetClassModule()
                if classModule then
                    -- specIndex is already available from above
                    local allRotations = classModule.db.class.rotations
                    if allRotations and allRotations[specIndex] then
                        for name, config in pairs(allRotations[specIndex]) do
                            if config == rotationConfig then
                                --TODO: RAKIZI: ??
                                classModule:SetSetting("class",
                                    "rotations." .. specIndex .. "." .. name .. ".spellLocations",
                                    rotationConfig.spellLocations)
                                self:Info(
                                    "Cleaned up duplicate spell entries in rotation.spellLocations and saved to database")
                                break
                            end
                        end
                    end
                end
            end
        end
    elseif not useCustomSpellLocations and specIndex then
        -- Default mode: deduplicate specSpellLocations
        local classModule = NAG:GetClassModule()
        if classModule then
            local specDefaults = classModule.db.class.specSpellLocations and classModule.db.class.specSpellLocations[specIndex] or {}
            if specDefaults then
                local dedupResult = SpellbookManager:DeduplicateSpellLocations(specDefaults)
                if dedupResult.duplicates and #dedupResult.duplicates > 0 then
                    -- Save the deduplicated data back to the database
                    classModule:SetSetting("class", "specSpellLocations." .. specIndex, dedupResult.deduplicatedData)
                    self:Info("Cleaned up duplicate spell entries in specSpellLocations and saved to database")
                end
            end
        end
    end
end

--- Starts the rotation timer for continuous rotation execution
function RotationManager:StartRotationTimer()
    -- Don't start rotation timer until startup is complete
    local EventManager = ns.EventManager
    if EventManager and EventManager.currentPhase < ns.StartupPhase.COMPLETE then
        self:Debug("StartRotationTimer: Startup in progress, deferring timer start")
        return
    end

    -- Cancel existing rotation timer if it exists
    if TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation") then
        TimerManager:Cancel(TimerManager.Categories.ROTATION, "rotation")
    end

    local timerInterval = self.db.global.rotationTimerInterval or 0.1
    self._rotationExpectedCallbackAt = GetTime() + timerInterval

    TimerManager:Create(
        TimerManager.Categories.ROTATION,
        "rotation",
        function()
            -- Track last callback time so freeze diagnostic can tell if timer is actually firing
            local callbackNow = GetTime()
            local expectedAt = self._rotationExpectedCallbackAt or callbackNow
            NAG.lastRotationCallbackTime = callbackNow
            self:TrackRotationCallbackDrift(callbackNow, expectedAt)
            local nextExpected = expectedAt + timerInterval
            if nextExpected <= callbackNow then
                nextExpected = callbackNow + timerInterval
            end
            self._rotationExpectedCallbackAt = nextExpected
            -- Clear stale "stalled"/"recovering" state when timer is firing again (heartbeat only sets healthy in combat).
            local liv = self.rotationLiveness
            if liv and (liv.state == "stalled" or liv.state == "recovering") then
                self:UpdateLivenessState(callbackNow, "healthy", "callback_fired")
            end
            -- Simple timer-based rotation updates
            -- Timer interval itself provides throttling (default 100ms = max 10 updates/sec)
            NAG:Rotation()
        end,
        timerInterval, -- Configurable timer interval from RotationManager settings
        true -- Repeating
    )

    self:Debug("StartRotationTimer: Rotation timer started (%dms interval)", timerInterval * 1000)
    self:EnsureRotationWatchdog()
    self:EnsureRotationSelectionWatchdog()
end

--- Stops the rotation timer if running
function RotationManager:StopRotationTimer()
    if TimerManager.IsTimerActive and TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation") then
        TimerManager:Cancel(TimerManager.Categories.ROTATION, "rotation")
        self:Debug("StopRotationTimer: Rotation timer stopped")

        -- CRITICAL FIX: Trigger border visibility refresh when rotation stops
        -- Borders depend on cachedRotationFunc/AST being set (IsDisplayAllowed check)
        local DisplayManager = NAG:GetModule("DisplayManager", true)
        if DisplayManager and DisplayManager.UpdateFrameVisibility then
            DisplayManager:UpdateFrameVisibility()
        end
    end
end

--- Gets rotation config with guaranteed aplProto (generates if missing)
--- @param specIndex number The specialization index (1, 2, 3)
--- @param rotationName string The rotation name
--- @return table|nil config Rotation config with aplProto
--- @return string|nil error Error message if failed
function RotationManager:GetRotationWithProto(specIndex, rotationName)
    local classModule = NAG:GetClassModule()
    if not classModule then
        return nil, "Class module not available"
    end

    local rotation = classModule:GetRotation(specIndex, rotationName)
    if not rotation then
        return nil, "Rotation not found"
    end

    -- Check aplProto version and migrate if needed
    if rotation.aplProto then
        local savedVersion = rotation.aplProtoVersion or 0
        local currentVersion = ns.APL_PROTO_VERSION or 1

        if savedVersion < currentVersion then
            -- Version mismatch - try migration first
            local migratedProto, migrateErr = self:MigrateAplProto(rotation, savedVersion, currentVersion)

            if migratedProto then
                -- Migration succeeded - update rotation
                local rotationCopy = CopyTable(rotation)
                rotationCopy.aplProto = migratedProto
                rotationCopy.aplProtoVersion = currentVersion
                classModule:SaveRotation(specIndex, rotationName, rotationCopy)
                self:Info("Migrated aplProto (v%d -> v%d) for rotation: %s",
                    savedVersion, currentVersion, rotationName)
                return rotationCopy, nil
            elseif rotation.rotationString then
                -- Migration failed or not implemented - regenerate from rotationString
                if ns.DevDebugUtils and ns.DevDebugUtils.IsDebugEnabled(NAG, "RotationManager") then
                    self:Warn("Migration failed for rotation '%s' (v%d -> v%d): %s. Regenerating from rotationString...",
                        rotationName, savedVersion, currentVersion, migrateErr or "unknown error")
                end

                local conversionService = NAG:GetModule("RotationConversionService", true)
                local protoAST, diagnostics = conversionService:ParseToProtoAST(rotation.rotationString, {
                    useCache = true,
                    validate = false
                })

                if protoAST then
                    local rotationCopy = CopyTable(rotation)
                    rotationCopy.aplProto = protoAST
                    rotationCopy.aplProtoVersion = currentVersion
                    classModule:SaveRotation(specIndex, rotationName, rotationCopy)
                    self:Info("Regenerated aplProto (v%d) from rotationString for rotation: %s",
                        currentVersion, rotationName)
                    return rotationCopy, nil
                else
                    local err = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "unknown error"
                    return nil, "Failed to regenerate aplProto: " .. tostring(err)
                end
            else
                -- No rotationString to regenerate from
                return nil, string.format("Cannot migrate rotation '%s': missing rotationString", rotationName)
            end
        end
    end

    -- Ensure aplProto exists
    if not rotation.aplProto then
        if not rotation.rotationString then
            return nil, "Rotation has no rotationString or aplProto"
        end

        -- Generate aplProto from rotationString
        local conversionService = NAG:GetModule("RotationConversionService", true)
        local protoAST, diagnostics = conversionService:ParseToProtoAST(rotation.rotationString, {
            useCache = true,
            validate = false
        })

        if not protoAST then
            local err = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "unknown error"
            return nil, "Failed to generate aplProto: " .. tostring(err)
        end

        -- Fix: Copy before modifying to avoid mutating DB directly
        local rotationCopy = CopyTable(rotation)
        rotationCopy.aplProto = protoAST
        classModule:SaveRotation(specIndex, rotationName, rotationCopy)
        self:Info("Generated missing aplProto for rotation: %s", rotationName)

        -- Return the copy instead of original
        return rotationCopy, nil
    end

    -- When USE_SYNC_ROTATION_STRING=false, rotationString is source of truth
    -- Regenerate aplProto from rotationString in-memory (don't save) to ensure they match
    if not ns.USE_SYNC_ROTATION_STRING and rotation.rotationString and rotation.aplProto then
        local conversionService = NAG:GetModule("RotationConversionService", true)
        if conversionService then
            local protoAST, diagnostics = conversionService:ParseToProtoAST(rotation.rotationString, {
                useCache = true,
                validate = false
            })
            if protoAST then
                -- Return copy with regenerated aplProto (in-memory only, don't save)
                local rotationCopy = CopyTable(rotation)
                rotationCopy.aplProto = protoAST
                self:Debug("GetRotationWithProto: Regenerated aplProto from rotationString (source of truth, USE_SYNC_ROTATION_STRING=false)")
                return rotationCopy, nil
            else
                self:Warn("GetRotationWithProto: Failed to regenerate aplProto from rotationString")
            end
        end
    end

    return rotation, nil
end

--- Migrates aplProto from old version to current version
--- @param rotation table The rotation config to migrate
--- @param fromVersion number The version the rotation is currently at
--- @param toVersion number The target version to migrate to
--- @return table|nil migratedProto The migrated proto, or nil if migration failed
--- @return string|nil error Error message if migration failed
function RotationManager:MigrateAplProto(rotation, fromVersion, toVersion)
    if not rotation then
        return nil, "Rotation is nil"
    end

    local currentVersion = ns.APL_PROTO_VERSION or 1
    toVersion = toVersion or currentVersion

    -- No migration needed
    if fromVersion >= toVersion then
        return rotation.aplProto, nil
    end

    -- Migration chain: migrate step by step through each version
    local proto = rotation.aplProto
    local version = fromVersion

    while version < toVersion do
        local nextVersion = version + 1
        self:Debug("MigrateAplProto: Migrating from v%d to v%d", version, nextVersion)

        -- Version-specific migration logic
        if nextVersion == 1 then
            -- v0 -> v1: Initial version (no-op, just regenerate from rotationString)
            -- This is handled by the caller regenerating from rotationString
            proto = nil  -- Force regeneration
        elseif nextVersion == 2 then
            -- v1 -> v2: Future migration (no-op for now)
            -- TODO: Add v1->v2 migration logic when proto format changes
            -- Example: proto = self:MigrateV1ToV2(proto)
        elseif nextVersion == 3 then
            -- v2 -> v3: Future migration (no-op for now)
            -- TODO: Add v2->v3 migration logic when proto format changes
            -- Example: proto = self:MigrateV2ToV3(proto)
        else
            -- Unknown version - cannot migrate
            return nil, string.format("Unknown target version: %d", nextVersion)
        end

        version = nextVersion
    end

    return proto, nil
end

--- Gets a cached rotation function, compiling it if not already cached
--- @param specIndex number The specialization index (1, 2, 3)
--- @param rotationName string The rotation name
--- @return function|nil func The cached rotation function, or nil on failure
--- @return string|nil error Error message if retrieval failed
function RotationManager:GetCachedRotation(specIndex, rotationName)
    if not specIndex or not rotationName then
        return nil, "Invalid parameters: specIndex and rotationName required"
    end

    local cacheKey = string.format("%d:%s", specIndex, rotationName)

    -- Check schema availability to determine execution path
    local APLExecutor = NAG:GetModule("APLExecutor", true)
    local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()

    -- Fast path: return cached data immediately
    -- Note: PrecompileAllRotations precompiles functions into rotationCache,
    -- so we check the appropriate cache based on execution path
    if useVisitorPattern then
        -- Schema-aware path: check AST cache first
        if self.rotationASTCache[cacheKey] then
            self:Debug("GetCachedRotation: Found cached AST: " .. cacheKey)
            return self.rotationASTCache[cacheKey], nil
        end
        -- Fallback: check if function exists (from PrecompileAllRotations) but we need AST
        -- This shouldn't happen after PrecompileAllRotations, but handle gracefully
        if self.rotationCache[cacheKey] then
            self:Trace("GetCachedRotation: Found cached function but visitor pattern enabled, will parse AST")
        end
    else
        -- Function-based path: check function cache (precompiled by PrecompileAllRotations)
        if self.rotationCache[cacheKey] then
            self:Debug("GetCachedRotation: Found cached function: " .. cacheKey)
            return self.rotationCache[cacheKey], nil
        end
    end

    -- Get the rotation from ClassBase
    local classModule = NAG:GetClassModule()
    if not classModule then
        return nil, "Class module not available"
    end

    -- Debug: Log what we're trying to get
    self:Debug("GetCachedRotation: Attempting to get rotation specIndex=%s, name='%s' (useVisitorPattern=%s)",
        tostring(specIndex), tostring(rotationName), tostring(useVisitorPattern))

    local rotation = classModule:GetRotation(specIndex, rotationName)

    -- Debug: Log what we received
    if rotation then
        self:Debug("GetCachedRotation: Received rotation object, type: %s, has rotationString: %s",
            type(rotation), tostring(rotation.rotationString ~= nil))
    else
        self:Warn("GetCachedRotation: GetRotation returned nil for specIndex=%s, name='%s'", tostring(specIndex),
            tostring(rotationName))
    end

    if not rotation or not rotation.rotationString then
        return nil, "Rotation not found or invalid"
    end

    -- Validate before compiling/parsing only if explicitly enabled
    if self.validateOnCacheMiss then
        self:Debug("GetCachedRotation: Validating rotation before caching: " .. cacheKey)
        local valid, validationErr = self:ValidateRotationConfig(rotation)
        if not valid then
            self:Warn("GetCachedRotation: Validation failed for " .. cacheKey .. ": " .. tostring(validationErr))
            return nil, "Validation failed: " .. tostring(validationErr)
        end
        self:Debug("GetCachedRotation: Validation passed for " .. cacheKey)
    else
        self:Trace("GetCachedRotation: Skipping validation on cache-miss (prevalidated at startup)")
    end

    -- Route to appropriate path based on schema availability
    if useVisitorPattern then
        -- Schema-aware path: Parse rotationString to proto AST
        self:Debug("GetCachedRotation: Parsing rotation to proto AST: " .. cacheKey)
        local RotationConversionService = NAG:GetModule("RotationConversionService", true)
        if not RotationConversionService then
            return nil, "RotationConversionService not available"
        end

        local Format = RotationConversionService.FORMATS
        local protoAST, diagnostics = RotationConversionService:Convert(
            Format.ROTATION_STRING,
            Format.PROTO_AST,
            rotation.rotationString,
            { useCache = true, validate = false }
        )

        if protoAST then
            self.rotationASTCache[cacheKey] = protoAST
            self.rotationCacheMetadata[cacheKey] = {
                specIndex = specIndex,
                rotationName = rotationName,
                lastUsed = GetTime(),
                compileTime = GetTime(),
                rotationString = rotation.rotationString,
                isValid = true,
                validationError = nil,
                isAST = true
            }

            local spellsByName = self:GetCachedSpellExtraction(specIndex, rotationName)
            if not spellsByName then
                spellsByName = self:ExtractSpellsFromRotation(rotation.rotationString, rotationName, specIndex)
            end
            local unusedMajorCooldowns = self:ComputeUnusedMajorCooldownSpellIds(rotation, spellsByName)
            self.rotationCacheMetadata[cacheKey].unusedMajorCooldownSpellIds = unusedMajorCooldowns
            self:Debug("GetCachedRotation: Successfully cached AST: " .. cacheKey)
            return protoAST, nil
        else
            local err = diagnostics and (diagnostics.errors and diagnostics.errors[1]) or "Parse failed"
            self:Error("GetCachedRotation: AST parsing failed for " .. cacheKey .. ": " .. tostring(err))
            self.rotationCacheMetadata[cacheKey] = {
                specIndex = specIndex,
                rotationName = rotationName,
                compileTime = GetTime(),
                isValid = false,
                validationError = err,
                isAST = true
            }
            return nil, "AST parsing failed: " .. tostring(err)
        end
    else
        -- Function-based path: Compile rotationString to function
        self:Debug("GetCachedRotation: Compiling rotation to function: " .. cacheKey)
        local func, err = self:CompileRotation(rotation.rotationString)
        if func then
            self.rotationCache[cacheKey] = func
            self.rotationCacheMetadata[cacheKey] = {
                specIndex = specIndex,
                rotationName = rotationName,
                lastUsed = GetTime(),
                compileTime = GetTime(),
                rotationString = rotation.rotationString,
                isValid = true,
                validationError = nil,
                isAST = false
            }

            local spellsByName = self:GetCachedSpellExtraction(specIndex, rotationName)
            if not spellsByName then
                spellsByName = self:ExtractSpellsFromRotation(rotation.rotationString, rotationName, specIndex)
            end
            local unusedMajorCooldowns = self:ComputeUnusedMajorCooldownSpellIds(rotation, spellsByName)
            self.rotationCacheMetadata[cacheKey].unusedMajorCooldownSpellIds = unusedMajorCooldowns
            self:Debug("GetCachedRotation: Successfully cached function: " .. cacheKey)
            return func, nil
        else
            self:Error("GetCachedRotation: Compilation failed for " .. cacheKey .. ": " .. tostring(err))
            self.rotationCacheMetadata[cacheKey] = {
                specIndex = specIndex,
                rotationName = rotationName,
                compileTime = GetTime(),
                isValid = false,
                validationError = err,
                isAST = false
            }
            return nil, "Compilation failed: " .. tostring(err)
        end
    end
end

--- Sets the current active rotation function from cache
--- @param specIndex number The specialization index (1, 2, 3)
--- @param rotationName string The rotation name
--- @return boolean success Whether the rotation was successfully activated
--- @return string|nil error Error message if activation failed
function RotationManager:SetActiveRotation(specIndex, rotationName)
    if not specIndex or not rotationName then
        return false, "Invalid parameters"
    end

    -- Validate that we're not trying to activate a rotation for a different spec
    local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not currentSpecIndex then
        return false, "No current specialization available"
    end

    -- Lightweight short-circuit if rotation is already active and cache is valid
    if self.currentRotation and self.currentRotation.name == rotationName and currentSpecIndex == specIndex then
        local APLExecutor = NAG:GetModule("APLExecutor", true)
        local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()
        if useVisitorPattern then
            if NAG.cachedRotationAST then
                return true, nil
            end
        else
            if type(NAG.cachedRotationFunc) == "function" then
                return true, nil
            end
        end
    end

    -- Get the rotation to check its specIndex
    local classModule = NAG:GetClassModule()
    if not classModule then
        return false, "Class module not available"
    end

    local rotation = classModule:GetRotation(specIndex, rotationName)
    if not rotation then
        return false, "Rotation not found"
    end

    -- CRITICAL: Validate rotation belongs to current spec
    if rotation.specIndex and rotation.specIndex ~= currentSpecIndex then
        return false, format("Cannot activate rotation from different spec (rotation spec: %d, current spec: %d)",
            rotation.specIndex, currentSpecIndex)
    end

    -- Additional safety: validate provided specIndex matches current spec
    if specIndex ~= currentSpecIndex then
        self:Warn("SetActiveRotation: Provided specIndex (%d) doesn't match current spec (%d), using current spec",
            specIndex, currentSpecIndex)
        specIndex = currentSpecIndex
    end

    -- Get cached rotation (will compile/parse if not cached)
    local rotationData, err = self:GetCachedRotation(specIndex, rotationName)
    if not rotationData then
        return false, err
    end

    -- Check schema availability to determine which cache to use
    local APLExecutor = NAG:GetModule("APLExecutor", true)
    local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()

    -- Set as active rotation based on execution path
    if useVisitorPattern then
        -- Schema-aware path: store AST
        NAG.cachedRotationAST = rotationData
        NAG.cachedRotationFunc = nil -- Clear function cache
    else
        -- Function-based path: store function
        NAG.cachedRotationFunc = rotationData
        NAG.cachedRotationAST = nil -- Clear AST cache
    end

    -- Store current rotation for variable/group evaluation
    local classModule = NAG:GetClassModule()
    if classModule then
        self.currentRotation = classModule:GetRotation(specIndex, rotationName)

        -- Build group lookup table for O(1) access
        if self.currentRotation and self.currentRotation.groups then
            self.currentRotation.groupLookup = {}
            for _, group in ipairs(self.currentRotation.groups) do
                if group.name then
                    self.currentRotation.groupLookup[group.name] = group
                end
            end

            -- Precompile group actions and variables for performance
            self:PrecompileGroups(self.currentRotation)
        end
        -- Precompile rotation-level variables
        if self.currentRotation and self.currentRotation.variables then
            self:PrecompileRotationVariables(self.currentRotation)
        end
    end

    -- Update metadata
    local cacheKey = string.format("%d:%s", specIndex, rotationName)
    if self.rotationCacheMetadata[cacheKey] then
        self.rotationCacheMetadata[cacheKey].lastUsed = GetTime()
    end

    -- Start the rotation timer for continuous execution
    self:StartRotationTimer()

    -- CRITICAL FIX: Trigger border visibility refresh when rotation becomes ready
    -- Borders depend on cachedRotationFunc/AST being set (IsDisplayAllowed check)
    local DisplayManager = NAG:GetModule("DisplayManager", true)
    if DisplayManager and DisplayManager.UpdateFrameVisibility then
        DisplayManager:UpdateFrameVisibility()
    end

    self:Debug("SetActiveRotation: Activated rotation: " .. cacheKey)
    return true
end

--- Clears the rotation cache for a specific rotation or all rotations
--- @param specIndex? number The specialization index (optional, clears all if not provided)
--- @param rotationName? string The rotation name (optional, clears all for spec if not provided)
function RotationManager:ClearRotationCache(specIndex, rotationName)
    if not specIndex then
        -- Clear entire cache
        wipe(self.rotationCache)
        wipe(self.rotationASTCache)
        wipe(self.rotationCacheMetadata)
        -- Clear active rotation since we're clearing everything
        NAG.cachedRotationFunc = nil
        NAG.cachedRotationAST = nil
        self:StopRotationTimer()
        self:Debug("ClearRotationCache: Cleared entire rotation cache and active rotation")
        return
    end

    if not rotationName then
        -- Clear all rotations for a spec
        local keysToRemove = {}
        for key, metadata in pairs(self.rotationCacheMetadata) do
            if metadata.specIndex == specIndex then
                table.insert(keysToRemove, key)
            end
        end

        for _, key in ipairs(keysToRemove) do
            self.rotationCache[key] = nil
            self.rotationASTCache[key] = nil
            self.rotationCacheMetadata[key] = nil
        end

        -- Clear active rotation if it's for this spec
        local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if currentSpecIndex == specIndex then
            NAG.cachedRotationFunc = nil
            NAG.cachedRotationAST = nil
            self:StopRotationTimer()
        end

        self:Debug("ClearRotationCache: Cleared rotation cache for specIndex: " .. tostring(specIndex))
        return
    end

    -- Clear specific rotation
    local cacheKey = string.format("%d:%s", specIndex, rotationName)
    self.rotationCache[cacheKey] = nil
    self.rotationASTCache[cacheKey] = nil
    self.rotationCacheMetadata[cacheKey] = nil

    -- Clear active rotation if it matches the cleared rotation
    local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if currentSpecIndex == specIndex and self.currentRotation then
        local currentRotationName = self.currentRotation.name
        if currentRotationName == rotationName then
            NAG.cachedRotationFunc = nil
            NAG.cachedRotationAST = nil
            self:StopRotationTimer()
        end
    end

    self:Debug("ClearRotationCache: Cleared rotation cache for: " .. cacheKey)
end

--- Gets cache statistics for debugging
--- @return table stats Cache statistics
function RotationManager:GetRotationCacheStats()
    local stats = {
        totalCached = 0,
        totalMemory = 0,
        oldestCache = math.huge,
        newestCache = 0
    }

    for key, metadata in pairs(self.rotationCacheMetadata) do
        stats.totalCached = stats.totalCached + 1
        stats.oldestCache = math.min(stats.oldestCache, metadata.compileTime)
        stats.newestCache = math.max(stats.newestCache, metadata.compileTime)
    end

    return stats
end

--- Get a list of all cached rotations with their metadata
--- @return table Array of rotation info {name, specIndex, compileTime, lastUsed, isValid}
function RotationManager:GetCachedRotationsList()
    local list = {}

    for cacheKey, metadata in pairs(self.rotationCacheMetadata) do
        table.insert(list, {
            name = metadata.rotationName,
            specIndex = metadata.specIndex,
            compileTime = metadata.compileTime,
            lastUsed = metadata.lastUsed,
            isValid = metadata.isValid
        })
    end

    -- Sort by most recently compiled first
    table.sort(list, function(a, b)
        return a.compileTime > b.compileTime
    end)

    return list
end

--- Ensures the rotation system is ready for execution
--- @return boolean ready Whether the rotation system is ready
function RotationManager:EnsureRotationReady()
    -- Check which execution path we're using
    local APLExecutor = NAG:GetModule("APLExecutor", true)
    local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()

    -- If we already have an active rotation (function or AST), ensure the timer is running
    if useVisitorPattern then
        -- Visitor pattern: check for AST
        if NAG.cachedRotationAST then
            if not (TimerManager.IsTimerActive and TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation")) then
                self:StartRotationTimer()
            end
            return true
        end
    else
        -- Function-based: check for function
        if NAG.cachedRotationFunc then
            -- Validate the cached function is actually callable
            if type(NAG.cachedRotationFunc) ~= "function" then
                self:Error("EnsureRotationReady: cachedRotationFunc is not a function: " ..
                    tostring(type(NAG.cachedRotationFunc)))
                NAG.cachedRotationFunc = nil
                self:StopRotationTimer()
                return false
            end

            if not (TimerManager.IsTimerActive and TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "rotation")) then
                self:StartRotationTimer()
            end
            return true
        end
    end

    -- Try to get current rotation from cache
    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Error("EnsureRotationReady: Class module not available")
        return false
    end

    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    local combatSpecLock = StateManager and StateManager.state and StateManager.state.combat and StateManager.state.combat.specIndexLock
    if combatSpecLock and UnitAffectingCombat and UnitAffectingCombat("player") then
        if specIndex and specIndex ~= combatSpecLock then
            self:WarnFreeze(format("Spec lock active in combat: locked %s, observed %s - keeping locked spec", tostring(combatSpecLock), tostring(specIndex)))
        end
        specIndex = combatSpecLock
    end
    local selectedRotation = classModule:GetSelectedRotation(specIndex)

    if specIndex and selectedRotation then
        -- CRITICAL: Check if the selected rotation is enabled before trying to activate it
        local rotation = classModule:GetRotation(specIndex, selectedRotation)
        if not rotation or not rotation.enabled then
            local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
            self:Warn("EnsureRotationReady: Selected rotation '%s' is disabled", selectedRotation)
            if inCombat and self.combatRotationSnapshot and
                self.combatRotationSnapshot.specIndex == specIndex and
                self.combatRotationSnapshot.rotationName then
                if not self:ShouldAttemptCombatRecovery() then
                    return false
                end
                local snapshotName = self.combatRotationSnapshot.rotationName
                self:ScheduleRecoveryAttempt(
                    specIndex,
                    snapshotName,
                    "selected_disabled_recovered_snapshot",
                    selectedRotation
                )
                return false
            else
                -- Clear the invalid selection out of combat
                classModule:SetSelectedRotation(specIndex, nil)
                selectedRotation = nil
            end
        end
    end

    if specIndex and selectedRotation then
        -- Try to activate from cache (compile/load can be slow; log if it takes long)
        local activationStartMs = debugprofilestop and debugprofilestop() or 0
        local success, err = self:SetActiveRotation(specIndex, selectedRotation)
        if debugprofilestop and activationStartMs > 0 then
            local elapsedMs = debugprofilestop() - activationStartMs
            if elapsedMs > 500 then
                self:Warn("EnsureRotationReady: SetActiveRotation took %.0f ms (spec=%s rotation=%s) - if this happens often, report with /nag freeze", elapsedMs, tostring(specIndex), tostring(selectedRotation))
            end
        end
        if success then
            -- CRITICAL: Validate the newly set rotation data based on execution path
            if useVisitorPattern then
                -- Visitor pattern: validate AST
                if not NAG.cachedRotationAST or type(NAG.cachedRotationAST) ~= "table" then
                    self:Error("EnsureRotationReady: SetActiveRotation succeeded but cachedRotationAST is not valid")
                    NAG.cachedRotationAST = nil
                    self:StopRotationTimer()
                    return false
                end
            else
                -- Function-based: validate function
                if type(NAG.cachedRotationFunc) ~= "function" then
                    self:Error("EnsureRotationReady: SetActiveRotation succeeded but cachedRotationFunc is not a function")
                    NAG.cachedRotationFunc = nil
                    self:StopRotationTimer()
                    return false
                end
            end

            self:Debug("EnsureRotationReady: Activated rotation from cache")
            if UnitAffectingCombat and UnitAffectingCombat("player") then
                self.hadValidRotationAtCombatStart = true
            end
            return true
        else
            self:Error("EnsureRotationReady: Failed to activate rotation: " .. tostring(err))
            -- Ensure no orphan timer keeps running
            if UnitAffectingCombat and UnitAffectingCombat("player") then
                self:WarnFreeze("Activation failed in combat: " .. tostring(err))
            else
                if useVisitorPattern then
                    NAG.cachedRotationAST = nil
                else
                    NAG.cachedRotationFunc = nil
                end
                self:StopRotationTimer()
            end
            return false
        end
    else
        self:Debug("EnsureRotationReady: No rotation selected for specIndex " .. tostring(specIndex))
        local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
        local recovered = false

        if inCombat and self.combatRotationSnapshot and
            self.combatRotationSnapshot.specIndex == specIndex and
            self.combatRotationSnapshot.rotationName then
            if not self:ShouldAttemptCombatRecovery() then
                return false
            end
            local snapshotName = self.combatRotationSnapshot.rotationName
            self:ScheduleRecoveryAttempt(
                specIndex,
                snapshotName,
                "selection_missing_recovered_snapshot",
                nil
            )
            return false
        end

        -- Try to find and select a valid rotation
        local allRotations = classModule:GetAllRotations(specIndex)
        if allRotations then
            for rotationName, rotationConfig in pairs(allRotations) do
                if rotationConfig and rotationConfig.enabled then
                    self:Debug("EnsureRotationReady: Auto-selecting valid rotation: " .. rotationName)
                    local success, err = self:SetActiveRotation(specIndex, rotationName)
                    if success then
                        classModule:SetSelectedRotation(specIndex, rotationName)
                        if inCombat then
                            self:RecordCombatRecovery({
                                reason = "selection_missing_fallback_rotation",
                                fromRotation = nil,
                                toRotation = rotationName,
                                specIndex = specIndex
                            })
                        end
                        return true
                    else
                        self:Warn("EnsureRotationReady: Failed to activate valid rotation '%s': %s", rotationName, tostring(err))
                    end
                end
            end
        end

        -- Ensure no orphan timer keeps running
        if useVisitorPattern then
            NAG.cachedRotationAST = nil
        else
            NAG.cachedRotationFunc = nil
        end
        if UnitAffectingCombat and UnitAffectingCombat("player") then
            self:WarnFreeze("No valid rotation selected in combat; keeping timer running")
            self:RecordCombatRecovery({
                reason = "selection_missing_no_valid_rotation",
                fromRotation = nil,
                toRotation = nil,
                specIndex = specIndex
            })
        else
            self:StopRotationTimer()
        end
        return false
    end
end

--- Selects and activates a rotation for a specific spec
--- @param specIndex number The specialization index (1,2,3)
--- @param rotationName string The rotation name
--- @return boolean success Whether the rotation was successfully selected
--- @return string|nil error Error message if selection failed
function RotationManager:SelectRotation(specIndex, rotationName)
    if not specIndex or not rotationName then
        return false, "Invalid parameters: specIndex and rotationName required"
    end

    -- Get the rotation configuration
    local classModule = NAG:GetClassModule()
    if not classModule then
        return false, "Class module not available"
    end

    local rotation = classModule:GetRotation(specIndex, rotationName)
    if not rotation then
        return false, "Rotation not found"
    end

    -- CRITICAL: Validate rotation belongs to the spec we're trying to select it for
    if rotation.specIndex and rotation.specIndex ~= specIndex then
        return false, format("Rotation belongs to different spec (rotation spec: %d, requested spec: %d)",
            rotation.specIndex, specIndex)
    end

    -- Validate against current player spec
    local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if currentSpecIndex and specIndex ~= currentSpecIndex then
        return false, format("Cannot activate rotation for different spec (requested: %d, current: %d)",
            specIndex, currentSpecIndex)
    end

    -- Use caching system for instant rotation switching
    local success, err = self:SetActiveRotation(specIndex, rotationName)
    if not success then
        self:Error("SelectRotation: Failed to activate rotation: " .. tostring(err))
        return false, "Failed to activate rotation: " .. tostring(err)
    else
        self:Debug("SelectRotation: Successfully activated cached rotation")
    end

    -- Selection event and options notify are emitted by ClassBase:SelectRotation.
    -- Avoid duplicate broadcasts from RotationManager to prevent event loops.

    return true
end

local function ReportPrecompileFailure(self, name, specIndex, cacheKey, step, err)
    self:Error("PrecompileAllRotations: Failed (%s) for '%s' [spec=%s, key=%s]: %s", tostring(step), tostring(name),
        tostring(specIndex), tostring(cacheKey), tostring(err))
end

--- Precompiles all rotations for all specs on addon load
--- @param options table|nil
--- @return boolean success Whether precompilation was successful
--- @return string|nil error Error message if precompilation failed
function RotationManager:PrecompileAllRotations(options)
    options = options or {}

    if self._precompileCancelled then
        return false, "Precompile cancelled"
    end

    local state = self._precompileState
    if not state then
        self:Info("PrecompileAllRotations: Starting precompilation of all rotations")

        -- Check which execution path we're using
        local APLExecutor = NAG:GetModule("APLExecutor", true)
        local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()
        self:Debug("PrecompileAllRotations: useVisitorPattern=%s", tostring(useVisitorPattern))

        local classModule = NAG:GetClassModule()
        if not classModule then
            return false, "Class module not available"
        end

        -- Get all rotations for all specs
        local rotations, displayNames = classModule:GetAvailableRotations(nil, true)

        state = {
            classModule = classModule,
            useVisitorPattern = useVisitorPattern,
            rotations = rotations or {},
            displayNames = displayNames,
            totalRotations = 0,
            successfulCompilations = 0,
            failedCompilations = 0,
            nextKey = nil,
            batchSize = options.batchSize or self.precompileBatchSize or 4,
            maxMs = options.maxMs or self.precompileMaxMs or 8
        }
        self._precompileState = state
        self._precompileInProgress = true
        self._precompileCancelled = false
        self._hasPrecompiled = false

    -- MIGRATION: Ensure all rotations have aplProto
    local migratedCount = 0
    if classModule.db and classModule.db.class and classModule.db.class.rotations then
        for specIndex, specRotations in pairs(classModule.db.class.rotations) do
            if specRotations and type(specRotations) == "table" then
                for name, config in pairs(specRotations) do
                    if config and type(config) == "table" and config.rotationString then
                        local needsMigration = false
                        local migrationReason = ""

                        if not config.aplProto then
                            needsMigration = true
                            migrationReason = "missing aplProto"
                        elseif (config.aplProtoVersion or 0) < (ns.APL_PROTO_VERSION or 1) then
                            needsMigration = true
                            migrationReason = string.format("version mismatch (v%d -> v%d)",
                                config.aplProtoVersion or 0, ns.APL_PROTO_VERSION or 1)
                        end

                        if needsMigration then
                            self:Info("Migrating rotation '%s' to proto AST format (%s)...", name, migrationReason)
                            local conversionService = NAG:GetModule("RotationConversionService", true)
                            if conversionService then
                                local protoAST, diagnostics = conversionService:ParseToProtoAST(config.rotationString, {
                                    useCache = true,
                                    validate = false,
                                    cacheReadOnly = true
                                })

                                if protoAST then
                                    config.aplProto = protoAST
                                    config.aplProtoVersion = ns.APL_PROTO_VERSION or 1

                                    -- Also migrate groups and variables (same version/format system)
                                    local NAGStringParser = NAG:GetModule("NAGStringParser", true)
                                    local ASTCore = ns.ASTCore
                                    local ASTAction = ns.ASTAction

                                    if NAGStringParser and ASTCore then
                                        -- Initialize groups and value_variables arrays if missing
                                        if not protoAST.groups then
                                            protoAST.groups = {}
                                        end
                                        if not protoAST.value_variables then
                                            protoAST.value_variables = {}
                                        end

                                        -- Migrate groups if strings exist but AST is missing/mismatched
                                        if config.groups and #config.groups > 0 then
                                            local needsGroupMigration = not protoAST.groups or #protoAST.groups == 0
                                            if needsGroupMigration then
                                                protoAST.groups = {}
                                                for i, group in ipairs(config.groups) do
                                                    local protoGroup = {
                                                        type = ASTCore.NodeType.GROUP,
                                                        name = group.name or "",
                                                        description = nil,
                                                        hide = false,
                                                        actions = {},
                                                        variables = {}
                                                    }

                                                    -- Parse each action string to AST
                                                    for j, actionString in ipairs(group.actions or {}) do
                                                        if actionString and actionString ~= "" then
                                                            -- Use ParseClause to support conditions, NAG:Hidden(), and notes
                                                            local clauseResult = NAGStringParser:ParseClause(actionString, nil, nil)
                                                            if clauseResult and clauseResult.action then
                                                                -- Set condition on action if present
                                                                if clauseResult.condition and ASTAction then
                                                                    ASTAction.SetCondition(clauseResult.action, clauseResult.condition)
                                                                end

                                                                tinsert(protoGroup.actions, {
                                                                    type = ASTCore.NodeType.LIST_ITEM,
                                                                    hide = clauseResult.hidden or false,  -- Support NAG:Hidden()
                                                                    notes = clauseResult.notes or nil,     -- Support notes from comments
                                                                    action = clauseResult.action,
                                                                    -- condition is on action.condition, not here (proto structure)
                                                                })
                                                            else
                                                                self:Warn("PrecompileAllRotations: Failed to parse group %d action %d for rotation '%s'", i, j, name)
                                                            end
                                                        end
                                                    end

                                                    tinsert(protoAST.groups, protoGroup)
                                                end
                                            end
                                        end

                                        -- Migrate variables if strings exist but AST is missing/mismatched
                                        if config.variables and #config.variables > 0 then
                                            local needsVariableMigration = not protoAST.value_variables or #protoAST.value_variables == 0
                                            if needsVariableMigration then
                                                protoAST.value_variables = {}
                                                for i, variable in ipairs(config.variables) do
                                                    local valueAST = nil
                                                    if variable.value and variable.value ~= "" then
                                                        -- Use ParseClause to handle value-only parsing
                                                        -- ParseClause internally routes to ParseValue/ParseCondition as needed
                                                        local clauseResult = NAGStringParser:ParseClause(variable.value, nil, nil)
                                                        if clauseResult then
                                                            -- Extract value from clause result (could be in value or condition field)
                                                            valueAST = clauseResult.value or clauseResult.condition
                                                        end
                                                    end

                                                    -- Fallback to empty constant if parsing fails
                                                    if not valueAST then
                                                        self:Warn("PrecompileAllRotations: Failed to parse variable %d value for rotation '%s', using empty constant", i, name)
                                                        local ASTValue = ns.ASTValue
                                                        if ASTValue then
                                                            valueAST = ASTValue.CreateConst("")
                                                        end
                                                    end

                                                    tinsert(protoAST.value_variables, {
                                                        name = variable.name or "",
                                                        hide = false,
                                                        value = valueAST
                                                    })
                                                end
                                            end
                                        end
                                    end

                                    classModule:SaveRotation(specIndex, name, config)
                                    migratedCount = migratedCount + 1
                                else
                                    if ns.DevDebugUtils and ns.DevDebugUtils.IsDebugEnabled(NAG, "RotationManager") then
                                        local err = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "unknown error"
                                        self:Warn("Migration failed for '%s': %s", name, tostring(err))
                                    end
                                end
                            else
                                if ns.DevDebugUtils and ns.DevDebugUtils.IsDebugEnabled(NAG, "RotationManager") then
                                    self:Warn("Migration failed for '%s': RotationConversionService not available", name)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if migratedCount > 0 then
        self:Info("Migrated %d rotations to proto AST format", migratedCount)
    end

    -- NOTE: We use the rotation data directly from GetAvailableRotations instead of calling GetRotation
    -- because there's a data structure mismatch: GetAvailableRotations returns a flattened table
    -- where keys are rotation names, but GetRotation expects a nested structure rotations[specIndex][rotationName]

    -- Debug: Log the structure of what we received
    if self.debug then
        self:Info("PrecompileAllRotations: Received rotations table with " ..
            (rotations and TableUtils.Size(rotations) or 0) .. " entries")
    end
    if rotations then
        for name, config in pairs(rotations) do
            if self.debug then
                self:Trace("PrecompileAllRotations: Rotation key: '%s', config type: %s, specIndex: %s",
                    tostring(name), type(config), tostring(config and config.specIndex))
            end
            if config and type(config) == "table" then
                -- Test direct access to see if the data is actually there
                if config.rotationString then
                    if self.debug then
                        self:Trace("PrecompileAllRotations: Found rotationString for '%s': %s", name,
                            string.sub(config.rotationString, 1, 50) .. "...")
                    end
                else
                    self:Warn("PrecompileAllRotations: NO rotationString found for '%s'", name)
                end
            end
        end
    end

    if displayNames then
        if self.debug then
            self:Debug("PrecompileAllRotations: Received displayNames table with " ..
                TableUtils.Size(displayNames) .. " entries")
        end
        for name, displayName in pairs(displayNames) do
            if self.debug then
                self:Trace("PrecompileAllRotations: DisplayName key: '%s', value: '%s'", tostring(name),
                    tostring(displayName))
            end
        end
    end
    end

    local classModule = state.classModule
    local useVisitorPattern = state.useVisitorPattern
    local rotations = state.rotations

    local processed = 0
    local batchStartMs = debugprofilestop()
    local batchSize = state.batchSize or 4
    local maxMs = state.maxMs or 8

    while true do
        local name, config = next(rotations, state.nextKey)
        state.nextKey = name
        if not name then
            break
        end

        state.totalRotations = state.totalRotations + 1
        -- Use specIndex from config
        local specIndex = config.specIndex or 0

        -- Ensure specIndex is a number (coerce string IDs); fall back to 0 only if coercion fails
        if type(specIndex) ~= "number" then
            local coerced = tonumber(specIndex)
            if coerced then
                specIndex = coerced
            else
                self:Warn("PrecompileAllRotations: Invalid specIndex type for '%s': %s (converting to 0)",
                    tostring(name), type(specIndex))
                specIndex = 0
            end
        end

        -- Unconditional log so we can see which path each rotation takes (rotationString vs aplProto only)
        local hasRS = config.rotationString and type(config.rotationString) == "string"
        self:Info("PrecompileAllRotations: rotation '%s' (spec=%s) has rotationString=%s (len=%s)",
            name, tostring(specIndex), hasRS and "yes" or "no", hasRS and tostring(#config.rotationString) or "0")

        -- Since GetAvailableRotations already gives us the rotation data, use it directly
        -- instead of calling GetRotation which expects a different data structure
        if config and config.rotationString then
            if self.debug then
                self:Trace(
                    "PrecompileAllRotations: Using config directly from GetAvailableRotations for '%s'", name)
            end

            -- Validate the config structure
            if type(config.rotationString) ~= "string" then
                self:Warn("PrecompileAllRotations: Invalid rotationString type for '%s': %s", name,
                    type(config.rotationString))
                -- Disable the rotation so it cannot be selected
                -- Fix: Copy before modifying to avoid mutating DB directly
                local configCopy = CopyTable(config)
                configCopy.enabled = false
                configCopy.disabledReason = "Invalid rotationString type: " .. type(config.rotationString)
                -- Save the disabled state to database
                local classModule = NAG:GetClassModule()
                if classModule then
                    if UnitAffectingCombat and UnitAffectingCombat("player") then
                        self:QueueRotationDisable(specIndex, name, configCopy, configCopy.disabledReason)
                    else
                        classModule:SaveRotation(specIndex, name, configCopy)
                        -- Clear selection if this was the selected rotation
                        local selectedRotation = classModule:GetSelectedRotation(specIndex)
                        if selectedRotation == name then
                            classModule:SetSelectedRotation(specIndex, nil)
                            self:Debug("PrecompileAllRotations: Cleared selection for disabled rotation: " .. name)
                        end
                    end
                end
                -- Store validation failure in cache metadata for fast lookups
                local cacheKey = string.format("%d:%s", specIndex, name)
                self.rotationCacheMetadata[cacheKey] = {
                    specIndex = specIndex,
                    rotationName = name,
                    compileTime = GetTime(),
                    isValid = false,
                    validationError = "Invalid rotationString type: " .. type(config.rotationString)
                }
                state.failedCompilations = state.failedCompilations + 1
                ReportPrecompileFailure(self, name, specIndex, cacheKey, "invalid_rotation_string_type",
                    type(config.rotationString))
            else
                -- Check if rotationString is empty (manual trim check for Lua 5.1 compatibility)
                local trimmedString = config.rotationString:match("^%s*(.-)%s*$")
                if trimmedString == "" then
                    self:Warn("PrecompileAllRotations: Empty rotationString for '%s'", name)
                    -- Disable the rotation so it cannot be selected
                    -- Fix: Copy before modifying to avoid mutating DB directly
                    local configCopy = CopyTable(config)
                    configCopy.enabled = false
                    configCopy.disabledReason = "Empty rotationString"
                    -- Save the disabled state to database
                    local classModule = NAG:GetClassModule()
                    if classModule then
                        if UnitAffectingCombat and UnitAffectingCombat("player") then
                            self:QueueRotationDisable(specIndex, name, configCopy, configCopy.disabledReason)
                        else
                            classModule:SaveRotation(specIndex, name, configCopy)
                            -- Clear selection if this was the selected rotation
                            local selectedRotation = classModule:GetSelectedRotation(specIndex)
                            if selectedRotation == name then
                                classModule:SetSelectedRotation(specIndex, nil)
                                self:Debug("PrecompileAllRotations: Cleared selection for disabled rotation: " .. name)
                            end
                        end
                    end
                    -- Store validation failure in cache metadata for fast lookups
                    local cacheKey = string.format("%d:%s", specIndex, name)
                    self.rotationCacheMetadata[cacheKey] = {
                        specIndex = specIndex,
                        rotationName = name,
                        compileTime = GetTime(),
                        isValid = false,
                        validationError = "Empty rotationString"
                    }
                    state.failedCompilations = state.failedCompilations + 1
                    ReportPrecompileFailure(self, name, specIndex, cacheKey, "empty_rotation_string", "empty string")
                else
                    -- Register all spell IDs from rotation string with DataManager so Cast can resolve them (e.g. Dash 33357)
                    local DM = NAG:GetModule("DataManager") or ns.DataManager
                    if DM and DM.RegisterSpellIDsFromRotationString then
                        self:Info("PrecompileAllRotations: PreRegisterSpellIDs for '%s' (spec=%s) [calling]", name, tostring(specIndex))
                        DM:RegisterSpellIDsFromRotationString(config.rotationString)
                    end

                    -- Perform full validation once during precompile
                    local isValid, vErr = self:ValidateRotationConfig(config)
                    if not isValid then
                        self:Warn("PrecompileAllRotations: Validation failed for '%s': %s", name, tostring(vErr))
                        -- Disable the rotation so it cannot be selected
                        -- Fix: Copy before modifying to avoid mutating DB directly
                        local configCopy = CopyTable(config)
                        configCopy.enabled = false
                        configCopy.disabledReason = "Compilation error: " .. tostring(vErr)
                        -- Save the disabled state to database
                        local classModule = NAG:GetClassModule()
                        if classModule then
                            if UnitAffectingCombat and UnitAffectingCombat("player") then
                                self:QueueRotationDisable(specIndex, name, configCopy, configCopy.disabledReason)
                            else
                                classModule:SaveRotation(specIndex, name, configCopy)
                                -- Clear selection if this was the selected rotation
                                local selectedRotation = classModule:GetSelectedRotation(specIndex)
                                if selectedRotation == name then
                                    classModule:SetSelectedRotation(specIndex, nil)
                                    self:Debug("PrecompileAllRotations: Cleared selection for disabled rotation: " .. name)
                                end
                            end
                        end
                        -- Store validation failure in cache metadata for fast lookups
                        local cacheKey = string.format("%d:%s", specIndex, name)
                        self.rotationCacheMetadata[cacheKey] = {
                            specIndex = specIndex,
                            rotationName = name,
                            compileTime = GetTime(),
                            isValid = false,
                            validationError = vErr
                        }
                        state.failedCompilations = state.failedCompilations + 1
                        ReportPrecompileFailure(self, name, specIndex, cacheKey, "validation_failed", vErr)
                    else
                        -- Precompile based on execution path
                        local cacheKey = string.format("%d:%s", specIndex, name)

                        -- When USE_SYNC_ROTATION_STRING=false, rotationString is source of truth
                        -- Regenerate aplProto from rotationString in-memory (don't save) before precompiling
                        if not ns.USE_SYNC_ROTATION_STRING and config.rotationString and config.aplProto then
                            local conversionService = NAG:GetModule("RotationConversionService", true)
                            if conversionService then
                                local protoAST, diagnostics = conversionService:ParseToProtoAST(config.rotationString, {
                                    useCache = true,
                                    validate = false,
                                    cacheReadOnly = true
                                })
                                if protoAST then
                                    -- Regenerate aplProto in-memory (don't save to DB)
                                    config.aplProto = protoAST
                                    self:Debug("PrecompileAllRotations: Regenerated aplProto from rotationString for '%s' (source of truth, USE_SYNC_ROTATION_STRING=false, in-memory)", name)
                                else
                                    self:Warn("PrecompileAllRotations: Failed to regenerate aplProto from rotationString for '%s'", name)
                                end
                            end
                        end

                        if useVisitorPattern then
                            -- Visitor pattern: Parse rotationString to proto AST
                            local RotationConversionService = NAG:GetModule("RotationConversionService", true)
                            if RotationConversionService then
                                local Format = RotationConversionService.FORMATS
                                local protoAST, diagnostics = RotationConversionService:Convert(
                                    Format.ROTATION_STRING,
                                    Format.PROTO_AST,
                                    config.rotationString,
                                    { useCache = true, validate = false, cacheReadOnly = true }
                                )

                                if protoAST then
                                    if self.debug then
                                        self:Trace("PrecompileAllRotations: AST parsing SUCCESS for '%s'", name)
                                    end
                                    self.rotationASTCache[cacheKey] = protoAST
                                    self.rotationCacheMetadata[cacheKey] = {
                                        specIndex = specIndex,
                                        rotationName = name,
                                        lastUsed = GetTime(),
                                        compileTime = GetTime(),
                                        rotationString = config.rotationString,
                                        isValid = true,
                                        validationError = nil,
                                        isAST = true
                                    }

                                    -- Extract and cache spells during precompilation
                                    local spellsByName = self:GetCachedSpellExtraction(specIndex, name)
                                    if not spellsByName then
                                        if self.debug then self:Trace("PrecompileAllRotations: Extracting spells for '%s'", name) end
                                        spellsByName = self:ExtractSpellsFromRotation(config.rotationString, name, specIndex)
                                        if self.debug then
                                            local spellCount = 0
                                            local spellMetadata = self.spellCacheMetadata[cacheKey]
                                            if spellMetadata and spellMetadata.spellCount then
                                                spellCount = spellMetadata.spellCount
                                            elseif spellsByName then
                                                for _ in pairs(spellsByName) do
                                                    spellCount = spellCount + 1
                                                end
                                            end
                                            self:Debug("PrecompileAllRotations: Extracted %d spells for '%s'", spellCount, name)
                                        end
                                    end

                                    local unusedMajorCooldowns = self:ComputeUnusedMajorCooldownSpellIds(config, spellsByName)
                                    self.rotationCacheMetadata[cacheKey].unusedMajorCooldownSpellIds = unusedMajorCooldowns

                                    -- Precompile groups and variables for this rotation
                                    if config.groups and #config.groups > 0 then
                                        self:PrecompileGroups(config)
                                    end
                                    if config.variables and #config.variables > 0 then
                                        self:PrecompileRotationVariables(config)
                                    end

                                    if self.debug then
                                        self:Debug("PrecompileAllRotations: Cached AST key " ..
                                            cacheKey .. " for rotation '" .. name .. "'")
                                    end

                                    state.successfulCompilations = state.successfulCompilations + 1
                                else
                                    local err = diagnostics and (diagnostics.errors and diagnostics.errors[1]) or "Parse failed"
                                    self:Warn("PrecompileAllRotations: AST parsing failed for '%s': %s", name, tostring(err))
                                    self.rotationCacheMetadata[cacheKey] = {
                                        specIndex = specIndex,
                                        rotationName = name,
                                        compileTime = GetTime(),
                                        isValid = false,
                                        validationError = err,
                                        isAST = true
                                    }
                                    state.failedCompilations = state.failedCompilations + 1
                                    ReportPrecompileFailure(self, name, specIndex, cacheKey, "ast_parse_failed", err)
                                end
                            else
                                if ns.DevDebugUtils and ns.DevDebugUtils.IsDebugEnabled(NAG, "RotationManager") then
                                    self:Warn("PrecompileAllRotations: RotationConversionService not available for '%s'", name)
                                end
                                state.failedCompilations = state.failedCompilations + 1
                                ReportPrecompileFailure(self, name, specIndex, cacheKey,
                                    "rotation_conversion_service_missing", "service unavailable")
                            end
                        else
                            -- Function-based: Compile rotationString to function
                            local func, err = self:CompileRotation(config.rotationString)
                            if func then
                                if self.debug then
                                    self:Trace("PrecompileAllRotations: Direct compilation SUCCESS for '%s'",
                                        name)
                                end
                                -- Cache it manually using the same cache key format as GetCachedRotation
                                self.rotationCache[cacheKey] = func
                                self.rotationCacheMetadata[cacheKey] = {
                                    specIndex = specIndex,
                                    rotationName = name,
                                    lastUsed = GetTime(),
                                    compileTime = GetTime(),
                                    rotationString = config.rotationString,
                                    isValid = true,
                                    validationError = nil,
                                    isAST = false
                                }
                                -- Extract and cache spells during precompilation (for both paths)
                                local spellsByName = self:GetCachedSpellExtraction(specIndex, name)
                                if not spellsByName then
                                    if self.debug then self:Trace("PrecompileAllRotations: Extracting spells for '%s'", name) end
                                    spellsByName = self:ExtractSpellsFromRotation(config.rotationString, name, specIndex)
                                    if self.debug then
                                        -- Try to get count from cached metadata first, fall back to counting the table
                                        local spellCount = 0
                                        local spellMetadata = self.spellCacheMetadata[cacheKey]
                                        if spellMetadata and spellMetadata.spellCount then
                                            spellCount = spellMetadata.spellCount
                                        elseif spellsByName then
                                            -- Fallback: count spells in the returned table
                                            for _ in pairs(spellsByName) do
                                                spellCount = spellCount + 1
                                            end
                                        end
                                        self:Debug("PrecompileAllRotations: Extracted %d spells for '%s'", spellCount, name)
                                    end
                                end

                                local unusedMajorCooldowns = self:ComputeUnusedMajorCooldownSpellIds(config, spellsByName)
                                self.rotationCacheMetadata[cacheKey].unusedMajorCooldownSpellIds = unusedMajorCooldowns

                                -- Precompile groups and variables for this rotation
                                if config.groups and #config.groups > 0 then
                                    self:PrecompileGroups(config)
                                end
                                if config.variables and #config.variables > 0 then
                                    self:PrecompileRotationVariables(config)
                                end

                                -- Count each rotation's success once (compilation/parsing implies spell extraction succeeded)
                                if self.debug then
                                    self:Debug("PrecompileAllRotations: Cached key " ..
                                        cacheKey .. " for rotation '" .. name .. "' (isAST=%s)", tostring(useVisitorPattern))
                                end

                                state.successfulCompilations = state.successfulCompilations + 1
                            else
                                if self.debug then
                                    self:Debug(
                                        "PrecompileAllRotations: Direct compilation FAILED for '%s': %s", name, tostring(err))
                                end
                                -- Disable the rotation so it cannot be selected
                                -- Fix: Copy before modifying to avoid mutating DB directly
                                local configCopy = CopyTable(config)
                                configCopy.enabled = false
                                configCopy.disabledReason = "Compilation error: " .. tostring(err)
                                -- Save the disabled state to database
                                local classModule = NAG:GetClassModule()
                                if classModule then
                                    if UnitAffectingCombat and UnitAffectingCombat("player") then
                                        self:QueueRotationDisable(specIndex, name, configCopy, configCopy.disabledReason)
                                    else
                                        classModule:SaveRotation(specIndex, name, configCopy)
                                        -- Clear selection if this was the selected rotation
                                        local selectedRotation = classModule:GetSelectedRotation(specIndex)
                                        if selectedRotation == name then
                                            classModule:SetSelectedRotation(specIndex, nil)
                                            self:Debug("PrecompileAllRotations: Cleared selection for disabled rotation: " .. name)
                                        end
                                    end
                                end
                                -- Store validation failure in cache metadata for fast lookups
                                local cacheKey = string.format("%d:%s", specIndex, name)
                                self.rotationCacheMetadata[cacheKey] = {
                                    specIndex = specIndex,
                                    rotationName = name,
                                    compileTime = GetTime(),
                                    isValid = false,
                                    validationError = err
                                }
                                state.failedCompilations = state.failedCompilations + 1
                                ReportPrecompileFailure(self, name, specIndex, cacheKey, "direct_compile_failed", err)
                                self:Warn("PrecompileAllRotations: Failed to precompile: " .. name .. " - " .. tostring(err))
                            end
                        end
                    end
                end
            end
        else
            -- No rotationString in config: use aplProto-only path; still try to pre-register spells from proto
            self:Info("PrecompileAllRotations: no rotationString for '%s', using aplProto path", name)
            local cacheKey = string.format("%d:%s", specIndex, name)
            local usedProtoFallback = false

            if useVisitorPattern and config and config.aplProto then
                -- Pre-register spells from proto (convert proto -> rotation string, then extract spell IDs)
                local conversionService = NAG:GetModule("RotationConversionService", true)
                local DM = NAG:GetModule("DataManager") or ns.DataManager
                if conversionService and DM and DM.RegisterSpellIDsFromRotationString then
                    local Format = conversionService.FORMATS
                    local rsFromProto = conversionService:Convert(Format.PROTO_AST, Format.ROTATION_STRING,
                        config.aplProto, { useCache = true, validate = false })
                    if rsFromProto and type(rsFromProto) == "string" and rsFromProto ~= "" then
                        self:Info("PrecompileAllRotations: calling PreRegisterSpellIDs for '%s' (from aplProto)", name)
                        DM:RegisterSpellIDsFromRotationString(rsFromProto)
                    end
                end

                local ASTCore = ns.ASTCore
                local protoNode = config.aplProto
                if ASTCore and not ASTCore.IsNode(protoNode) then
                    local ok, converted = pcall(ASTCore.FromProto, protoNode)
                    if ok and converted then
                        protoNode = converted
                    else
                        protoNode = nil
                    end
                end

                if protoNode and (not ASTCore or protoNode.type == ASTCore.NodeType.ROTATION) then
                    self.rotationASTCache[cacheKey] = protoNode
                    self.rotationCacheMetadata[cacheKey] = {
                        specIndex = specIndex,
                        rotationName = name,
                        lastUsed = GetTime(),
                        compileTime = GetTime(),
                        rotationString = nil,
                        isValid = true,
                        validationError = nil,
                        isAST = true
                    }
                    usedProtoFallback = true
                    state.successfulCompilations = state.successfulCompilations + 1
                    if self.debug then
                        self:Debug("PrecompileAllRotations: Using aplProto for '%s' (no rotationString)", name)
                    end
                end
            end

            if not usedProtoFallback then
                -- Disable the rotation so it cannot be selected
                -- Fix: Copy before modifying to avoid mutating DB directly
                local configCopy = CopyTable(config)
                configCopy.enabled = false
                configCopy.disabledReason = "No rotationString found"
                -- Save the disabled state to database
                local classModule = NAG:GetClassModule()
                if classModule then
                    if UnitAffectingCombat and UnitAffectingCombat("player") then
                        self:QueueRotationDisable(specIndex, name, configCopy, configCopy.disabledReason)
                    else
                        classModule:SaveRotation(specIndex, name, configCopy)
                        -- Clear selection if this was the selected rotation
                        local selectedRotation = classModule:GetSelectedRotation(specIndex)
                        if selectedRotation == name then
                            classModule:SetSelectedRotation(specIndex, nil)
                            self:Debug("PrecompileAllRotations: Cleared selection for disabled rotation: " .. name)
                        end
                    end
                end
                -- Store validation failure in cache metadata for fast lookups
                self.rotationCacheMetadata[cacheKey] = {
                    specIndex = specIndex,
                    rotationName = name,
                    compileTime = GetTime(),
                    isValid = false,
                    validationError = "No rotationString found"
                }
                state.failedCompilations = state.failedCompilations + 1
                self:Warn("PrecompileAllRotations: Failed to precompile: " .. name .. " - No rotationString found")
                ReportPrecompileFailure(self, name, specIndex, cacheKey, "missing_rotation_string", "No rotationString found")
            end
        end
        processed = processed + 1
        if processed >= batchSize or (debugprofilestop() - batchStartMs) >= maxMs then
            C_Timer.After(0, function()
                self:PrecompileAllRotations(options)
            end)
            return true, nil
        end
    end

    self:Info("PrecompileAllRotations: Completed. Total: %d, Success: %d, Failed: %d",
        state.totalRotations, state.successfulCompilations, state.failedCompilations)

    self._hasPrecompiled = true
    self._precompileState = nil
    self._precompileInProgress = false
    self._precompileCancelled = false
    return true, nil
end

--- Start batched precompilation of all rotations (with combat deferral)
--- @param options table|nil
--- @return boolean
--- @return string|nil
function RotationManager:StartPrecompileAllRotations(options)
    options = options or {}

    if self._precompileInProgress then
        self:Debug("PrecompileAllRotations: Already running, skipping new request")
        return true, nil
    end

    if self._hasPrecompiled and not options.force then
        self:Debug("PrecompileAllRotations: Already completed, skipping")
        return true, nil
    end

    if UnitAffectingCombat and UnitAffectingCombat("player") then
        self._precompileDeferred = true
        self._precompileDeferredOptions = options
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        self:Info("PrecompileAllRotations: In combat, deferring precompile until combat ends")
        return true, nil
    end

    self._precompileDeferredOptions = nil
    return self:PrecompileAllRotations(options)
end

--- Invalidates a specific rotation, spec-wide, or all rotations
--- @param specIndex? number The specialization index (1,2,3) (optional, invalidates all if not provided)
--- @param rotationName? string The rotation name (optional, invalidates all for spec if not provided)
function RotationManager:InvalidateRotation(specIndex, rotationName)
    if not specIndex then
        -- Invalidate all rotations
        self:ClearRotationCache()
        self:InvalidateSpellExtractionCache()
        self:Debug("InvalidateRotation: Invalidated all rotations")
        return
    end

    if not rotationName then
        -- Invalidate all rotations for a spec
        self:ClearRotationCache(specIndex)
        self:InvalidateSpellExtractionCache(specIndex)
        self:Debug("InvalidateRotation: Invalidated all rotations for specIndex: " .. tostring(specIndex))
        return
    end

    -- Invalidate specific rotation
    local cacheKey = string.format("%d:%s", specIndex, rotationName)
    self.rotationCache[cacheKey] = nil
    self.rotationASTCache[cacheKey] = nil
    self.rotationCacheMetadata[cacheKey] = nil
    self:InvalidateSpellExtractionCache(specIndex, rotationName)

    -- Clear group compilation and rotation variables if rotation is currently active
    if self.currentRotation then
        local currentKey = string.format("%d:%s",
            self.currentRotation.specIndex or 0,
            self.currentRotation.name or "")
        if currentKey == cacheKey then
            -- Clear compiled groups
            if self.currentRotation.groups then
                for _, group in ipairs(self.currentRotation.groups) do
                    group.compiledVariables = nil
                    group.compiledActions = nil
                end
            end
            -- Clear compiled rotation variables
            if self.currentRotation.compiledVariables then
                self.currentRotation.compiledVariables = nil
            end
            self:Debug("InvalidateRotation: Cleared group and variable compilation cache for: " .. cacheKey)
        end
    end

    self:Debug("InvalidateRotation: Invalidated rotation: " .. cacheKey)
end

--- Compiles a rotation string into a function
--- @param rotationString string The rotation string to compile
--- @return function|nil The compiled function, or nil if compilation failed
--- @return string|nil Error message if compilation failed
function RotationManager:CompileRotation(rotationString)
    if not rotationString then
        return nil, "No rotation string provided"
    end

    -- Sanitize the rotation string by commenting out problematic Sequence/StrictSequence calls
    local sanitizedRotationString = self:SanitizeRotationString(rotationString)

    -- Create a function that will have access to NAG constants
    local funcString = format([[
        return function()
            return %s
        end
        ]], sanitizedRotationString)


    -- Call loadstring directly (not wrapped in pcall) to get proper error messages
    self:Debug("CompileRotation: Calling loadstring...")
    local funcOrErr, loadErr = loadstring(funcString)

    -- Check if loadstring returned a function
    if not funcOrErr or type(funcOrErr) ~= "function" then
        -- loadstring returns (nil, error_message) on syntax errors
        local errorMsg = loadErr or "loadstring returned " .. type(funcOrErr)
        self:Error("CompileRotation: loadstring failed: " .. tostring(errorMsg))

        -- Log first 500 chars of problematic code for debugging
        self:Error("CompileRotation: Problematic function string (first 500 chars): " .. strsub(funcString, 1, 500) .. "...")

        return nil, errorMsg
    end

    self:Debug("CompileRotation: loadstring succeeded, executing function...")

    -- Add pcall around function execution
    local success, rotation = pcall(funcOrErr)
    if not success then
        self:Warn("CompileRotation: Function execution failed: " .. tostring(rotation))
        return nil, rotation
    end

    self:Debug("CompileRotation: Function execution succeeded, returning rotation")
    return rotation
end

--- Precompile group actions and variables for performance
--- Eliminates 3-10ms loadstring() overhead per group reference by compiling once at load time
--- @param rotation table The rotation containing groups to precompile
function RotationManager:PrecompileGroups(rotation)
    if not rotation or not rotation.groups then return end

    local compiledCount = 0
    local failedCount = 0

    for _, group in ipairs(rotation.groups) do
        -- Precompile group variables
        if group.variables then
            group.compiledVariables = {}
            for _, var in ipairs(group.variables) do
                -- Compile variable expression to function (evaluated every call for dynamic values)
                local funcString = "return " .. var.value
                local func, err = loadstring(funcString)
                if func then
                    group.compiledVariables[var.name] = func
                    compiledCount = compiledCount + 1
                else
                    self:Warn("Failed to precompile group variable '%s': %s", var.name, tostring(err))
                    failedCount = failedCount + 1
                end
            end
        end

        -- Precompile group actions
        group.compiledActions = {}
        for i, action in ipairs(group.actions) do
            -- Handle table actions (from parser tuple returns: {comment, actionString})
            local actionString = action
            if type(action) == "table" then
                -- Extract the actual action string from the table
                -- If it's a tuple-like table, the action is usually the last element
                if #action >= 2 then
                    -- Tuple format: {comment, actionString}
                    actionString = action[#action]  -- Get the last element (action string)
                    self:Debug("PrecompileGroups: Extracted action string from table for group '%s' action #%d",
                        group.name or "unknown", i)
                elseif #action == 1 then
                    -- Single element table
                    actionString = action[1]
                else
                    self:Warn("PrecompileGroups: Invalid table action format for group '%s' action #%d (table has %d elements)",
                        group.name or "unknown", i, #action)
                    failedCount = failedCount + 1
                end
            end

            if type(actionString) == "string" then
                -- Strip leading Lua comment lines from action string before compilation
                -- Parser format: "-- comment\naction" - we need to remove the comment line(s)
                -- Comments are fine for display but should be removed for compilation
                local cleanedAction = actionString
                -- Split into lines, preserving newlines
                local lines = {}
                local skipLeadingComments = true
                for line in string.gmatch(actionString .. "\n", "(.-)\n") do
                    -- Check if line is a comment (starts with -- after optional whitespace)
                    local trimmed = string.match(line, "^%s*(.-)%s*$")  -- Trim whitespace
                    if trimmed and string.match(trimmed, "^%-%-") then
                        -- Comment line - skip if we're still in leading comments
                        if not skipLeadingComments then
                            -- Comment after code has started, keep it (might be inline comment)
                            table.insert(lines, line)
                        end
                        -- Otherwise skip this leading comment
                    else
                        -- Not a comment line (or empty line), keep it
                        if trimmed and trimmed ~= "" then
                            skipLeadingComments = false  -- Found non-comment code, stop skipping comments
                        end
                        table.insert(lines, line)
                    end
                end
                if #lines > 0 then
                    cleanedAction = table.concat(lines, "\n")
                    -- Trim trailing whitespace/newlines
                    cleanedAction = string.match(cleanedAction, "^(.-)%s*$")
                else
                    -- All lines were comments, use original (shouldn't happen but be safe)
                    cleanedAction = actionString
                end

                local funcString = "return " .. cleanedAction
                local func, err = loadstring(funcString)
                if func then
                    group.compiledActions[i] = func
                    compiledCount = compiledCount + 1
                else
                    self:Warn("Failed to precompile group action #%d: %s (Action: '%s')", i, tostring(err), string.sub(cleanedAction, 1, 100))
                    failedCount = failedCount + 1
                end
            else
                self:Warn("PrecompileGroups: Action #%d in group '%s' is not a string (type: %s)",
                    i, group.name or "unknown", type(actionString))
                failedCount = failedCount + 1
            end
        end
    end

    if compiledCount > 0 then
        self:Debug("PrecompileGroups: Compiled %d group actions/variables (%d failed)",
            compiledCount, failedCount)
    end
end

--- Precompile rotation-level variables for performance
--- Eliminates 3-10ms loadstring() overhead per variable reference by compiling once at load time
--- Precompilation is required - variables must be precompiled before use
--- @param rotation table The rotation containing variables to precompile
function RotationManager:PrecompileRotationVariables(rotation)
    if not rotation or not rotation.variables then return end

    rotation.compiledVariables = {}
    local compiledCount = 0
    local failedCount = 0

    for _, var in ipairs(rotation.variables) do
        -- Compile variable expression to function (evaluated every call for dynamic values)
        local funcString = "return " .. var.value
        local func, err = loadstring(funcString)
        if func then
            rotation.compiledVariables[var.name] = func
            compiledCount = compiledCount + 1
        else
            self:Warn("Failed to precompile rotation variable '%s': %s", var.name, tostring(err))
            failedCount = failedCount + 1
        end
    end

    if compiledCount > 0 then
        self:Debug("PrecompileRotationVariables: Compiled %d variables (%d failed)", compiledCount, failedCount)
    end
end

--- Sanitizes a rotation string by commenting out problematic Sequence/StrictSequence calls
--- @param rotationString string The rotation string to sanitize
--- @return string The sanitized rotation string
function RotationManager:SanitizeRotationString(rotationString)
    if not rotationString then
        return ""
    end

    local sanitized = rotationString

    -- Process line by line to avoid complex regex issues with nested parentheses
    local lines = {}
    for line in sanitized:gmatch("[^\r\n]+") do
        -- Check if this line contains problematic Sequence/StrictSequence calls
        if line:match("NAG:Sequence%([^)]*,%s*%)") or line:match("NAG:StrictSequence%([^)]*,%s*%)") then
            -- Comment out the entire line
            line = "-- [SANITIZED] " .. line
        end
        table.insert(lines, line)
    end

    -- Join lines back together
    sanitized = table.concat(lines, "\n")

    -- Log what was sanitized for debugging
    if sanitized ~= rotationString then
        self:Debug("SanitizeRotationString: Sanitized problematic Sequence/StrictSequence calls")
    end

    return sanitized
end

-- ============================ SPELL EXTRACTION CACHING SYSTEM ============================

--- Gets the spell extraction patterns for APL parsing
--- @return table Array of regex patterns
function RotationManager:GetSpellExtractionPatterns()
    return {
        -- APL Casting actions
        "Cast%((%d+)",
        "NotSpamCast%((%d+)",
        "Channel%((%d+)",
        "ChannelSpell%((%d+)",
        "PaladinCastWithMacro%((%d+)",
        "CastPlaceholder%((%d+)",

        -- APL Multidot actions
        "Multidot%((%d+)",
        "StrictMultidot%((%d+)",
        "Multishield%((%d+)",

        -- APL Sequence functions
        "StrictSequence%([^,]+,%s*(?:true|false)?%s*,%s*(%d+)",
        "Sequence%([^,]+,%s*(?:true|false)?%s*,%s*(%d+)",

        -- APL Aura actions
        "ActivateAura%((%d+)",
        "ActivateAuraWithStacks%((%d+)",
        "CancelAura%((%d+)",
        "TriggerICD%((%d+)",

        -- Legacy patterns
        "CastSpell%((%d+)",
        "CastAbility%((%d+)"
    }
end

--- Extracts spells from rotation string using APL patterns and caches the result
--- @param rotationString string The rotation string to extract spells from
--- @param rotationName string The name of the rotation (for caching)
--- @param specIndex number The specialization index (for caching)
--- @return table Spells organized by name
function RotationManager:ExtractSpellsFromRotation(rotationString, rotationName, specIndex)
    if not rotationString then
        return {}
    end

    -- Create cache key
    local cacheKey = string.format("%d:%s", specIndex or 0, rotationName or "unknown")

    -- Check cache first
    if self.spellExtractionCache[cacheKey] then
        self:Trace("ExtractSpellsFromRotation: Using cached spell data for: " .. cacheKey)
        return self.spellExtractionCache[cacheKey]
    end

    self:Debug("ExtractSpellsFromRotation: Extracting spells for: " .. cacheKey)

    local spellsByName = {}
    local spellPatterns = self:GetSpellExtractionPatterns()

    -- Scan rotation string for spell IDs
    for _, pattern in ipairs(spellPatterns) do
        for spellId in rotationString:gmatch(pattern) do
            spellId = tonumber(spellId)
            if spellId then
                local spellEntry = SpellbookManager:GetSpell(spellId)
                if spellEntry then
                    self:AddSpellToCollection(spellsByName, spellEntry, spellId)
                end
            end
        end
    end

    -- Cache the result
    self.spellExtractionCache[cacheKey] = spellsByName

    -- Count spells for metadata
    local spellCount = 0
    for spellName, spellData in pairs(spellsByName) do
        spellCount = spellCount + 1
    end

    self.spellCacheMetadata[cacheKey] = {
        specIndex = specIndex,
        rotationName = rotationName,
        extractTime = GetTime(),
        spellCount = spellCount
    }

    self:Debug("ExtractSpellsFromRotation: Cached %d spells for: %s",
        self.spellCacheMetadata[cacheKey].spellCount, cacheKey)

    return spellsByName
end

--- Adds a spell to the collection, handling duplicates
--- @param spellsByName table Collection to add to
--- @param spellEntry table Spell entry from SpellbookManager
--- @param spellId number Spell ID
function RotationManager:AddSpellToCollection(spellsByName, spellEntry, spellId)
    local spellName = spellEntry.name

    if not spellsByName[spellName] then
        spellsByName[spellName] = {
            name = spellName,
            icon = spellEntry.icon,
            spellIds = {}
        }
    end

    if not tContains(spellsByName[spellName].spellIds, spellId) then
        tinsert(spellsByName[spellName].spellIds, spellId)
    end
end

--- Gets cached spell extraction data for a rotation
--- @param specIndex number The specialization index (1,2,3)
--- @param rotationName string The rotation name
--- @return table|nil Cached spell data or nil if not cached
function RotationManager:GetCachedSpellExtraction(specIndex, rotationName)
    if not specIndex or not rotationName then
        return nil
    end

    local cacheKey = string.format("%d:%s", specIndex, rotationName)
    return self.spellExtractionCache[cacheKey]
end

--- Invalidates spell extraction cache for a specific rotation or all rotations
--- @param specIndex? number The specialization index (1,2,3) (optional, invalidates all if not provided)
--- @param rotationName? string The rotation name (optional, invalidates all for spec if not provided)
function RotationManager:InvalidateSpellExtractionCache(specIndex, rotationName)
    if not specIndex then
        -- Invalidate all spell extraction caches
        wipe(self.spellExtractionCache)
        wipe(self.spellCacheMetadata)
        self:Debug("InvalidateSpellExtractionCache: Cleared entire spell extraction cache")
        return
    end

    if not rotationName then
        -- Invalidate all spell extraction caches for a spec
        local keysToRemove = {}
        for key, metadata in pairs(self.spellCacheMetadata) do
            if metadata.specIndex == specIndex then
                table.insert(keysToRemove, key)
            end
        end

        for _, key in ipairs(keysToRemove) do
            self.spellExtractionCache[key] = nil
            self.spellCacheMetadata[key] = nil
        end

        self:Debug("InvalidateSpellExtractionCache: Cleared spell extraction cache for specIndex: " .. tostring(specIndex))
        return
    end

    -- Invalidate specific rotation's spell extraction cache
    local cacheKey = string.format("%d:%s", specIndex, rotationName)
    self.spellExtractionCache[cacheKey] = nil
    self.spellCacheMetadata[cacheKey] = nil
    self:Debug("InvalidateSpellExtractionCache: Cleared spell extraction cache for: " .. cacheKey)
end

--- Gets spell extraction cache statistics for debugging
--- @return table stats Spell extraction cache statistics
function RotationManager:GetSpellExtractionCacheStats()
    local stats = {
        totalCached = 0,
        totalSpells = 0,
        oldestCache = math.huge,
        newestCache = 0
    }

    for key, metadata in pairs(self.spellCacheMetadata) do
        stats.totalCached = stats.totalCached + 1
        stats.totalSpells = stats.totalSpells + (metadata.spellCount or 0)
        stats.oldestCache = math.min(stats.oldestCache, metadata.extractTime or 0)
        stats.newestCache = math.max(stats.newestCache, metadata.extractTime or 0)
    end

    return stats
end

--- Compute major cooldown spell IDs not referenced in the rotation
--- @param rotationConfig table Rotation configuration
--- @param spellsByName table|nil Extracted spells grouped by name
--- @return table List of spell IDs
function RotationManager:ComputeUnusedMajorCooldownSpellIds(rotationConfig, spellsByName)
    if not rotationConfig then
        return {}
    end

    SchemaAccessor = SchemaAccessor or NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor or not SchemaAccessor.GetMajorCooldowns then
        return {}
    end

    local DataManager = NAG:GetModule("DataManager", true)
    if DataManager and not DataManager:IsDataReady() then
        return {}
    end

    local rotationSpellIds = {}
    if spellsByName then
        for _, spellData in pairs(spellsByName) do
            if spellData and spellData.spellIds then
                for _, spellId in ipairs(spellData.spellIds) do
                    rotationSpellIds[spellId] = true
                end
            end
        end
    end

    local options = {}
    local classValue = rotationConfig.class or NAG.CLASS_FILENAME
    if classValue then
        options.class = classValue
    end

    local specName = nil
    -- Try to get spec name from API using specIndex
    if rotationConfig.specIndex and SpecCompat then
        specName = SpecCompat:GetSpecName(rotationConfig.specIndex)
    end
    if not specName and rotationConfig.specName then
        specName = rotationConfig.specName
    end

    if specName then
        options.spec = specName
    end

    if not next(options) then
        options = nil
    end

    local majorCooldowns = SchemaAccessor:GetMajorCooldowns(options)
    if not majorCooldowns or #majorCooldowns == 0 then
        return {}
    end

    local unused = {}
    local added = {}
    local entityTypes = DataManager and DataManager.EntityTypes or nil

    for _, record in ipairs(majorCooldowns) do
        local spellId = record.spellId
        if spellId and not rotationSpellIds[spellId] and not added[spellId] then
            local include = true
            if record.entityType and record.entityType ~= "spell" then
                include = false
            end

            if include and DataManager and entityTypes and entityTypes.SPELL then
                local entity = DataManager:Get(spellId, entityTypes.SPELL)
                if not entity then
                    include = false
                end
            end

            if include then
                added[spellId] = true
                -- Store spell ID with its cooldown type (categoryId from schema)
                tinsert(unused, {
                    spellId = spellId,
                    cooldownType = record.categoryId or 0
                })
            end
        end
    end

    -- Sort by spellId for consistency
    sort(unused, function(a, b) return a.spellId < b.spellId end)

    return unused
end

--- Retrieves all major cooldown spell IDs for the current player class/spec
--- Uses SchemaAccessor to query class/spec-scoped major cooldowns
--- @return table List of tables with {spellId=number, cooldownType=number}
function RotationManager:GetAllMajorCooldownSpellIds()
    SchemaAccessor = SchemaAccessor or NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor or not SchemaAccessor.GetMajorCooldowns then
        return {}
    end

    local options = {}
    if SchemaAccessor.GetPlayerClassToken then
        options.class = SchemaAccessor:GetPlayerClassToken()
    end
    if SchemaAccessor.GetPlayerSpecToken then
        options.spec = SchemaAccessor:GetPlayerSpecToken()
    end

    local records = SchemaAccessor:GetMajorCooldowns(options) or {}
    if not records or #records == 0 then
        return {}
    end

    local results = {}
    local seen = {}
    for _, record in ipairs(records) do
        local spellId = record.spellId
        if spellId and not seen[spellId] then
            seen[spellId] = true
            table.insert(results, {
                spellId = spellId,
                cooldownType = record.categoryId or 0
            })
        end
    end

    table.sort(results, function(a, b) return a.spellId < b.spellId end)
    return results
end

--- Retrieves unused major cooldown spell IDs with their cooldown types for a rotation
--- @param specIndex number Specialization index (1,2,3)
--- @param rotationName string Rotation name
--- @return table List of tables with {spellId=number, cooldownType=number}
function RotationManager:GetUnusedMajorCooldownSpellIds(specIndex, rotationName)
    if not specIndex or not rotationName then
        return {}
    end

    local cacheKey = string.format("%d:%s", specIndex, rotationName)
    local metadata = self.rotationCacheMetadata[cacheKey]
    if metadata and metadata.unusedMajorCooldownSpellIds then
        local copy = {}
        for index, cooldownData in ipairs(metadata.unusedMajorCooldownSpellIds) do
            copy[index] = {
                spellId = cooldownData.spellId,
                cooldownType = cooldownData.cooldownType
            }
        end
        return copy
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        return {}
    end

    local rotation = classModule:GetRotation(specIndex, rotationName)
    if not rotation or not rotation.rotationString then
        return {}
    end

    -- Ensure specIndex is set (for consistency)
    if not rotation.specIndex then
        rotation.specIndex = specIndex
    end
    rotation.class = rotation.class or classModule.className or NAG.CLASS_FILENAME

    local spellsByName = self:GetCachedSpellExtraction(specIndex, rotationName)
    if not spellsByName then
        spellsByName = self:ExtractSpellsFromRotation(rotation.rotationString, rotationName, specIndex)
    end

    local unused = self:ComputeUnusedMajorCooldownSpellIds(rotation, spellsByName)

    metadata = self.rotationCacheMetadata[cacheKey]
    if metadata then
        metadata.unusedMajorCooldownSpellIds = unused
    end

    local copy = {}
    for index, cooldownData in ipairs(unused) do
        copy[index] = {
            spellId = cooldownData.spellId,
            cooldownType = cooldownData.cooldownType
        }
    end

    return copy
end

--- Clears the rotation switching cache (useful for addon reloads or when settings change)
--- This function clears cached rotation switching state
function RotationManager:ClearRotationSwitchingCache()
    -- Clear cached rotation switching state
    self.cachedClassModule = nil
    self.cachedAutoSwitchEnabled = nil
    self.lastAutoSwitchCheck = 0
    self:Debug("Rotation switching cache cleared")
end

-- ============================ PREDICTION QUEUE SYSTEM (SIMULATED) ============================

-- Prediction cache for performance optimization
local predictionCache = {}
local predictionCacheTime = 0
local PREDICTION_CACHE_TTL = 0.1 -- Cache for 100ms

--- Internal body of prediction generation (called via pcall for safety)
--- Declared before GeneratePredictionQueue per Lua 5.1 forward-reference rules.
--- @param self table RotationManager instance
--- @param primarySpell number The primary spell ID already recommended
--- @param numPredictions number Number of predictions to generate
--- @param rotationFunc function The cached rotation function
--- @param debugEnabled boolean Whether debug logging is active
--- @return table Array of prediction objects
local function generatePredictionBody(self, primarySpell, numPredictions, rotationFunc, debugEnabled)
    local predictions = {}
    local KeybindManager = NAG:GetModule("KeybindManager")

    -- Track which spells we've "cast" in simulation to avoid recommending them again
    local castedSpells = {}
    castedSpells[primarySpell] = true

    -- First, simulate casting the primary spell to advance state
    local primarySpellInfo = WoWAPI.GetSpellInfo(primarySpell)
    if primarySpellInfo then
        local primarySpellData = {
            id = primarySpell,
            castTime = primarySpellInfo.castTime and (primarySpellInfo.castTime / 1000) or 0,
            gcd = "on",
            cooldown = 0,
            cost = primarySpellInfo.costValue or 0
        }

        if debugEnabled and LearnedPredictionProvider and LearnedPredictionProvider.GetCostTelemetry then
            local telemetry = LearnedPredictionProvider:GetCostTelemetry(primarySpell)
            if telemetry then
                local rawValue = telemetry.value or telemetry.learnedValue
                local costStr = type(rawValue) == "table" and "table" or tostring(rawValue or "nil")
                self:Trace("Primary cost source=%s value=%s (static: %d) conf=%.2f samples=%d",
                    telemetry.source or "n/a",
                    costStr,
                    primarySpellData.cost or 0,
                    telemetry.confidence or 0,
                    telemetry.bucketSamples or 0)
            end
        end

        StateManager:AdvanceState(primarySpellData)
    end

    -- Store casted spells in StateManager for Cast() to check
    StateManager.simulatedCastedSpells = castedSpells

    -- Now simulate future rotation steps
    for i = 1, numPredictions do
        -- Clear current recommendation
        NAG.nextSpell = nil
        NAG.nextSpellName = nil

        if debugEnabled then
            self:Debug("Prediction #" .. i .. " - Starting iteration (casted spells: " .. (next(castedSpells) and "yes" or "none") .. ")")
            local castedList = {}
            for spellID in pairs(castedSpells) do
                local spellInfo = WoWAPI.GetSpellInfo(spellID)
                table.insert(castedList, (spellInfo and spellInfo.name or "???") .. "(" .. spellID .. ")")
            end
            self:Trace("  Already casted: " .. table.concat(castedList, ", "))
            self:Trace("  Current power: " .. tostring(UnitPower("player")))
        end

        -- Execute rotation in simulation mode
        local success, result = pcall(rotationFunc)
        if not success then
            if debugEnabled then
                self:Warn("Prediction #" .. i .. " failed (error): " .. tostring(result))
            end
            break
        end

        -- Get the recommended spell
        local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
        local spellID = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
        if not spellID or spellID == 0 then
            if debugEnabled then
                self:Trace("Prediction #" .. i .. " stopped: No more spells (rotation returned nil)")
            end
            break
        end

        -- Get spell info
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        if spellInfo then
            if debugEnabled then
                self:Trace("Prediction #" .. i .. " - Got spell: " .. spellInfo.name .. " (" .. spellID .. ")")
            end

            -- Skip if it's the same as primary spell (shouldn't happen but safety check)
            if spellID ~= primarySpell or i ~= 1 then
                local keybind = ""
                if KeybindManager.GetSpellKeybind then
                    keybind = KeybindManager:GetSpellKeybind(spellID) or ""
                end

                local cooldownInfo = WoWAPI.GetSpellCooldown(spellID)
                local cooldown = 0
                local cooldownStart = GetTime()
                if cooldownInfo then
                    cooldown = cooldownInfo.duration or 0
                    cooldownStart = cooldownInfo.startTime or GetTime()
                end

                -- Attach confidence metadata from LearnedPredictionProvider
                local predictionConfidence = 1.0
                local predictionSource = "learned"
                if LearnedPredictionProvider and LearnedPredictionProvider.GetCostTelemetry then
                    local telemetry = LearnedPredictionProvider:GetCostTelemetry(spellID)
                    if telemetry then
                        predictionConfidence = telemetry.confidence or 0
                        predictionSource = telemetry.source or "static"
                    end
                end

                local prediction = {
                    spell = {
                        id = spellID,
                        name = spellInfo.name or "Unknown Spell",
                        icon = spellInfo.iconID or "Interface\\Icons\\INV_Misc_QuestionMark",
                        cooldown = cooldown,
                        cooldownStart = cooldownStart,
                        keybind = keybind
                    },
                    priority = i,
                    reason = "Predicted Spell " .. i,
                    confidence = predictionConfidence,
                    source = predictionSource,
                }

                table.insert(predictions, prediction)

                if debugEnabled then
                    self:Trace("Prediction #" .. i .. " ✓ Added: " .. spellInfo.name .. " (" .. spellID .. ") [" .. predictionSource .. " conf=" .. format("%.2f", predictionConfidence) .. "]")
                end
            else
                if debugEnabled then
                    self:Trace("Prediction #" .. i .. " ⊗ Skipped: Same as primary spell")
                end
            end

            -- Always advance state (even if we skipped adding it to predictions)
            local spell = {
                id = spellID,
                castTime = spellInfo.castTime and (spellInfo.castTime / 1000) or 0,
                gcd = "on",
                cooldown = 0,
                cost = spellInfo.costValue or 0
            }

            if debugEnabled and LearnedPredictionProvider then
                if LearnedPredictionProvider.GetCostTelemetry then
                    local telemetry = LearnedPredictionProvider:GetCostTelemetry(spellID)
                    if telemetry then
                        local rawValue = telemetry.value or telemetry.learnedValue
                        local costStr = type(rawValue) == "table" and "table" or tostring(rawValue or "nil")
                        self:Trace("  Cost source=%s value=%s (static: %d) conf=%.2f samples=%d",
                            telemetry.source or "n/a",
                            costStr,
                            spell.cost or 0,
                            telemetry.confidence or 0,
                            telemetry.bucketSamples or 0)
                    end
                end
                if LearnedPredictionProvider.GetGenerationTelemetry then
                    local powerType = UnitPowerType("player")
                    local resourceTypeName
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
                    if resourceTypeName then
                        local telemetry = LearnedPredictionProvider:GetGenerationTelemetry(spellID, resourceTypeName)
                        local genValue = telemetry and (telemetry.value or telemetry.learnedValue)
                        if genValue and genValue > 0 then
                            self:Trace("  Generation source=%s value=%.2f %s conf=%.2f",
                                telemetry.source or "n/a",
                                genValue,
                                resourceTypeName,
                                telemetry.confidence or 0)
                        end
                    end
                end
            end

            StateManager:AdvanceState(spell)

            -- Mark this spell as casted in simulation
            castedSpells[spellID] = true
            StateManager.simulatedCastedSpells = castedSpells
        else
            if debugEnabled then
                self:Trace("Prediction #" .. i .. " failed: Could not get spell info for " .. spellID)
            end
            break
        end
    end

    return predictions
end

--- Generate prediction queue by simulating rotation execution
--- @param numPredictions number Number of predictions to generate (default: 2)
--- @return table Array of spell recommendations for the queue
function RotationManager:GeneratePredictionQueue(numPredictions)
    if not numPredictions or numPredictions < 1 then
        numPredictions = 2 -- Default to 2 predictions
    end

    local predictions = {}

    -- Get the currently cached rotation function (same one Common.lua uses)
    local rotationFunc = NAG.cachedRotationFunc
    if not rotationFunc then
        return predictions
    end

    -- Save the original primary spell that was just recommended
    local primarySpellIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell, {
        context = "prediction_queue_primary",
    }) or nil
    local primarySpell = (NAG.GetActionResolveId and NAG:GetActionResolveId(primarySpellIdentity)) or nil
    if not primarySpell or primarySpell == 0 then
        return predictions
    end

    -- Check cache (optimization) - include target GUID and count for invalidation on target switch
    local currentTime = GetTime()
    local targetGUID = _G.UnitGUID("target") or "none"
    local currentTargetCount = NAG.targetCount or 1
    local cacheKey = format("%s_%s_%s_%d",
        tostring(primarySpell),
        tostring(UnitPower("player")),
        targetGUID,
        currentTargetCount)
    if predictionCache[cacheKey] and (currentTime - predictionCacheTime) < PREDICTION_CACHE_TTL then
        return predictionCache[cacheKey]
    end

    -- Save current state
    local savedState = StateManager:SaveState()
    if not savedState then return predictions end

    -- Debug logging
    local debugEnabled = NAG.db and NAG.db.char and NAG.db.char.predictionQueue and NAG.db.char.predictionQueue.debug
    if debugEnabled then
        self:Debug("Generating " .. numPredictions .. " predictions (primary: " .. primarySpell .. ")")
    end

    -- pcall: If ANYTHING throws inside the simulation loop, it's caught here
    local ok, result = pcall(generatePredictionBody, self, primarySpell, numPredictions, rotationFunc, debugEnabled)

    -- ALWAYS runs (finally-block): restore state regardless of success/failure
    StateManager:RestoreState(savedState)
    NAG.nextSpell = NAG:NormalizePrimaryAction(primarySpell, { context = "prediction_restore_primary" })
    StateManager.simulatedCastedSpells = nil

    -- Safety validation: if simulationMode is still true after RestoreState, force reset
    if StateManager:IsSimulating() then
        self:Error("simulationMode still true after RestoreState - forcing reset")
        StateManager:ForceResetSimulation()
    end

    if not ok then
        self:Error("Prediction queue generation failed: %s", tostring(result))
        return {}
    end

    predictions = result or {}

    -- Cache results
    predictionCache[cacheKey] = predictions
    predictionCacheTime = currentTime

    if debugEnabled then
        self:Trace("Generated " .. #predictions .. " predictions")
    end

    return predictions
end

--- Invalidate the prediction cache (e.g. on target switch)
function RotationManager:InvalidatePredictionCache()
    wipe(predictionCache)
    predictionCacheTime = 0
end

-- Expose in private namespace
