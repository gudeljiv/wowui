--- @module "Common"
--- Handles common functionality for the NAG addon.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local UnitCastingInfo = _G.UnitCastingInfo
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon

local EMPTY_TABLE = {}

--- Set NAG.suggestedHealTargetLabel for heal-target overlay (P1, R5, Self) when healing priority is active.
--- Wrapped in pcall so a throw in HealingPriorityManager cannot stall the rotation.
local function updateSuggestedHealTargetLabel()
    local ok, err = pcall(function()
        NAG.suggestedHealTargetLabel = nil
        local HPM = NAG:GetModule("HealingPriorityManager", true)
        if not HPM or not HPM.GetBestHealingTarget or not HPM.IsEnabled or not HPM:IsEnabled() then return end
        local best = HPM:GetBestHealingTarget()
        if not best or best == "" then return end
        local label
        if best == "player" then
            label = "Self"
        elseif best:match("^party(%d+)$") then
            label = "P" .. best:match("^party(%d+)$")
        elseif best:match("^raid(%d+)$") then
            label = "R" .. best:match("^raid(%d+)$")
        else
            label = best
        end
        NAG.suggestedHealTargetLabel = label
    end)
    if not ok and NAG.Error then
        NAG:Error("updateSuggestedHealTargetLabel: " .. tostring(err))
    end
end

local OG_RET_SHADOW_COMPARE_LOG_VERSION = "ogret_shadow_cmp_v1_2026-02-13"

--- Normalize action identity into canonical table shape: { spellId = number|nil, itemId = number|nil, position = string|nil }.
--- Required for the creation path (number → table via DataManager:GetIdentity) and when input may be non-canonical.
--- Read hot path: GetActionResolveId/GetActionDisplayId use a fast path when identity is already this shape and skip this.
--- @param entryOrId any
--- @param opts table|nil
--- @return table|nil
local function normalizeActionIdentity(entryOrId, opts)
    if entryOrId == nil then
        return nil
    end
    opts = opts or {}

    local spellId = nil
    local itemId = nil
    local position = opts.position
    local numericInput = nil

    if type(entryOrId) == "table" then
        spellId = tonumber(entryOrId.spellId) or nil
        itemId = tonumber(entryOrId.itemId) or nil
        if position == nil then
            position = entryOrId.position
        end
    elseif type(entryOrId) == "number" then
        numericInput = entryOrId
    else
        return nil
    end

    if numericInput ~= nil then
        local DataManager = NAG:GetModule("DataManager", true)
        local identity = nil
        local preferItemFirst = nil
        if opts.preferItemFirst ~= nil then
            preferItemFirst = opts.preferItemFirst == true
        end
        if DataManager and DataManager.GetIdentity then
            identity = DataManager:GetIdentity(numericInput, opts.context or "action_identity", {
                preferItemFirst = preferItemFirst,
                itemId = opts.itemId,
                spellId = opts.spellId,
            })
        end

        if identity then
            spellId = identity.spellId
            itemId = identity.itemId
            if identity.kind == "item" and opts.itemOnlyWhenItem == true then
                spellId = nil
            end
        else
            spellId = numericInput
        end
    end

    if opts.itemId and tonumber(opts.itemId) then
        itemId = tonumber(opts.itemId)
    end
    if opts.spellId and tonumber(opts.spellId) then
        spellId = tonumber(opts.spellId)
    end

    if not spellId and not itemId then
        return nil
    end

    return {
        spellId = spellId,
        itemId = itemId,
        position = position,
    }
end

--- Canonical secondary entry normalizer with backward compatibility for numeric entries.
--- @param entry any
--- @return table|nil
local function normalizeSecondarySpellEntry(entry)
    if entry == nil then
        return nil
    end
    if type(entry) == "number" then
        return normalizeActionIdentity(entry, {
            context = "secondary_normalize",
            itemOnlyWhenItem = true,
        })
    end
    if type(entry) == "table" and (entry.spellId or entry.itemId) then
        return normalizeActionIdentity(entry, {
            context = "secondary_normalize",
            itemOnlyWhenItem = true,
        })
    end
    return nil
end

--- Returns true when `secondarySpells` already contains a spell id (or itemId match).
--- @param secondarySpells table|nil
--- @param spellId number
--- @return boolean
local function hasSecondarySpell(secondarySpells, spellId)
    if not secondarySpells or type(secondarySpells) ~= "table" or not spellId then
        return false
    end
    for i = 1, #secondarySpells do
        local norm = normalizeSecondarySpellEntry(secondarySpells[i])
        if norm and (norm.spellId == spellId or (norm.itemId and norm.itemId == spellId)) then
            return true
        end
    end
    return false
end

--- Builds compact live-decision snapshot fields for OG-vs-live comparison.
--- @param self NAG
--- @return table
local function buildRetLiveDecisionSnapshot(self)
    local socId = self.RetTwistGetSoCSealId and self:RetTwistGetSoCSealId() or nil
    local sobId = self.RetTwistGetSoBSealId and self:RetTwistGetSoBSealId() or nil
    local primaryAction = normalizeActionIdentity(self.nextSpell, { context = "ret_shadow_primary" })
    local primarySpell = primaryAction and (primaryAction.spellId or primaryAction.itemId) or nil
    local hasSoCSecondary = hasSecondarySpell(self.secondarySpells, socId)
    local hasJudgePrimary = (primarySpell == 20271)
    local overlayText = (self.castOverlayTexts and self.castOverlayTexts[20271]) or ""
    local holdOverlay = (type(overlayText) == "string" and string.find(overlayText, "HOLD", 1, true) ~= nil) or false
    local judgeSocPair = hasJudgePrimary and hasSoCSecondary

    local nextAction = "none"
    if primarySpell == 35395 then
        nextAction = "CS"
    elseif primarySpell == sobId then
        nextAction = "sob"
    elseif primarySpell == socId or hasSoCSecondary then
        nextAction = "soc"
    end

    return {
        nextAction = nextAction,
        primarySpell = primarySpell,
        hasSoCSecondary = hasSoCSecondary,
        holdFlag = holdOverlay,
        judgeCall = judgeSocPair,
    }
end

--- Executes OG Ret shadow logic and optionally logs compact mismatches.
--- This is strictly side-effect free for live recommendations.
--- @param self NAG
--- @return nil
local function runOGRetShadowCompare(self)
    if not (self and self.IsOGRetShadowEnabled and self:IsOGRetShadowEnabled()) then
        return
    end
    if not (self and self.OGRetLogic) then
        return
    end

    local safeCall = ns.pcall or pcall
    local ok, payload = safeCall(function()
        return self:OGRetLogic()
    end)

    local runtimeState = (self and self.state) or (_G.NAG and _G.NAG.state) or nil
    if runtimeState then
        runtimeState.ogRetShadow = {
            ok = false,
            error = nil,
            version = OG_RET_SHADOW_COMPARE_LOG_VERSION,
        }
    end

    if not ok or type(payload) ~= "table" then
        if runtimeState then
            runtimeState.ogRetShadow.ok = false
            runtimeState.ogRetShadow.error = tostring(payload)
        end
        return
    end

    payload.version = payload.version or OG_RET_SHADOW_COMPARE_LOG_VERSION
    if runtimeState then
        runtimeState.ogRetShadow = payload
    end

    if not (self.IsDevModeEnabled and self:IsDevModeEnabled()) then
        return
    end
    if not payload.ok then
        return
    end

    local live = buildRetLiveDecisionSnapshot(self)
    local ogAction = payload.nextAction or "none"
    local ogHold = payload.holdFlag == true
    local ogJudge = payload.judgeCall == true
    local holdMismatch = ogHold ~= live.holdFlag
    local judgeMismatch = ogJudge ~= live.judgeCall
    local actionMismatch = ogAction ~= (live.nextAction or "none")
    local importantMismatch = (ogJudge and (not live.judgeCall))
        or (ogAction == "CS" and live.nextAction ~= "CS")
    local mismatch = actionMismatch or holdMismatch or judgeMismatch

    local mismatchKey = string.format(
        "%s|%s|%s|%s|%s|%s|%s|%s",
        tostring(mismatch),
        tostring(importantMismatch),
        tostring(ogAction),
        tostring(live.nextAction),
        tostring(ogHold),
        tostring(live.holdFlag),
        tostring(ogJudge),
        tostring(live.judgeCall)
    )

    local now = GetTime()
    local lastLogAt = self._ogRetShadowLastLogAt or 0
    local changed = self._ogRetShadowLastMismatchKey ~= mismatchKey
    local shouldLog = (importantMismatch and (now - lastLogAt) >= 0.10)
        or (changed and mismatch and (now - lastLogAt) >= 0.10)

    -- Temporarily muted noisy OG shadow comparator print spam.
    -- Re-enable by removing `false and`.
    if false and shouldLog then
        local metrics = payload.metrics or {}
        print(string.format(
            "[RET_OG_SHADOW][ver=%s] mismatch=%s important=%s ogNextAction=%s nagPrimarySpell=%s nagHasSoCSecondary=%s holdFlagMismatch=%s judgeCallMismatch=%s bucket=%s predictionHold=%.3f csDelay=%.3f divWhen=%.3f twistGap=%.3f",
            tostring(payload.version or OG_RET_SHADOW_COMPARE_LOG_VERSION),
            tostring(mismatch),
            tostring(importantMismatch),
            tostring(ogAction),
            tostring(live.primarySpell),
            tostring(live.hasSoCSecondary),
            tostring(holdMismatch),
            tostring(judgeMismatch),
            tostring(payload.timingBucket or "unknown"),
            tonumber(payload.predictionHold) or 0,
            tonumber(payload.csDelay) or 0,
            tonumber(metrics.divWhen) or 0,
            tonumber(metrics.twistGap) or 0
        ))
        self._ogRetShadowLastLogAt = now
        self._ogRetShadowLastMismatchKey = mismatchKey
    end
end

-- Reusable icon data table pool (10 should be enough for most rotations)
local ICON_DATA_POOL = {}
for i = 1, 12 do
    ICON_DATA_POOL[i] = { texture = nil, spellId = nil, itemId = nil }
end
local iconDataPoolIndex = 0

-- Helper to get next icon data from pool with overflow protection
local function getNextIconData()
    iconDataPoolIndex = iconDataPoolIndex + 1
    if iconDataPoolIndex > #ICON_DATA_POOL then
        -- Create additional objects if needed instead of wrapping
        local newObj = { texture = nil, spellId = nil, itemId = nil }
        table.insert(ICON_DATA_POOL, newObj)
        iconDataPoolIndex = #ICON_DATA_POOL
    end
    local iconData = ICON_DATA_POOL[iconDataPoolIndex]
    iconData.texture = nil
    iconData.spellId = nil
    iconData.itemId = nil
    return iconData
end

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local WoWAPI = ns.WoWAPI
local Version = ns.Version

-- ============================ GCD PROBE (VERSION-AWARE) ============================
-- We use a "probe spell" to query the global cooldown via GetSpellCooldown().
-- Different clients expose different probe spell IDs reliably.
-- - Retail / Cata / Mists: 61304 (global cooldown spell)
-- - Vanilla / SoD / TBC / Wrath: 29515 (TEST Scorch, used as probe in this project)
local function getGcdProbeSpellId()
    if Version:IsRetail() or Version:IsCata() or Version:IsMists() then
        return 61304
    end
    return 29515
end

-- AST system for visitor pattern execution
-- NOTE: ASTVisitor is accessed via ns.ASTVisitor at runtime to avoid initialization order issues

local AceConfigDialog = ns.AceConfigDialog

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local GetGlyphSocketInfo = _G.GetGlyphSocketInfo
local format = string.format
local debugprofilestop = _G.debugprofilestop

-- Threshold (ms) above which a single rotation run is logged as slow (may cause timer lag / heartbeat stalls)
local ROTATION_EXECUTION_WARN_MS = 500
local max = math.max


local strfind = strfind
local wipe = wipe


-- Enhanced error handling
local pcall = ns.pcall
local xpcall = xpcall
local ExtractErrorMessage = ns.ExtractErrorMessage

-- Rotation error handling context (avoids per-call closure allocation)
local rotationErrorContext = {}

-- Rotation execution guard flag (prevents concurrent execution)
local isRotationExecuting = false
local rotationCycleId = 0

local function ensureRotationCycleDiagnostics()
    if not NAG.rotationCycleDiagnostics then
        NAG.rotationCycleDiagnostics = {
            cycleId = 0,
            cycleStartTime = 0,
            cyclePhase = "idle",
            lastPhaseAt = 0,
            lastError = nil,
            lastErrorAt = 0,
        }
    end
    return NAG.rotationCycleDiagnostics
end

-- Expose for diagnostics (PrintRotationFreezeStatus); mirror all assignments
local function setRotationExecuting(val)
    isRotationExecuting = val
    NAG._rotationExecuting = val
    if val then
        NAG.lastRotationGuardSetTime = GetTime()
    else
        NAG.lastRotationGuardClearedTime = GetTime()
        NAG.lastRotationGuardSetTime = nil
        NAG._numberTargetsCache = nil
    end
end
NAG._rotationExecuting = false -- Initial value for diagnostics

local function markRotationCycle(phase, err)
    local diagnostics = ensureRotationCycleDiagnostics()
    local now = GetTime()
    if phase == "start" then
        rotationCycleId = rotationCycleId + 1
        diagnostics.cycleId = rotationCycleId
        diagnostics.cycleStartTime = now
        diagnostics.lastError = nil
    end
    diagnostics.cyclePhase = phase
    diagnostics.lastPhaseAt = now
    if err then
        diagnostics.lastError = tostring(err)
        diagnostics.lastErrorAt = now
    end
end

--- Returns the last known rotation cycle diagnostics snapshot.
--- @return table
function NAG:GetRotationCycleDiagnostics()
    return ensureRotationCycleDiagnostics()
end

--- Force-resets the rotation execution guard when external watchdog detects a stuck cycle.
--- @param source string|nil
function NAG:ForceResetRotationExecutionGuard(source)
    if not isRotationExecuting then
        return
    end
    setRotationExecuting(false)
    markRotationCycle("force_reset", source or "unknown")
    self:Warn("Rotation execution guard force-reset by %s", tostring(source or "unknown"))
end

local function touchUIElementsGate()
    if not NAG.CallUIElements then
        return
    end
    NAG:CallUIElements()
end

-- Helper to classify and handle rotation errors consistently
local function HandleRotationError(self, useVisitorPattern, err)
    -- Use ExtractErrorMessage to properly handle both string and enhanced error table formats
    local errorMsg = ExtractErrorMessage(err)

    -- Use DevTools_Dump to inspect the error table if available
    if type(err) == "table" and DevTools_Dump then
        self:Error("Error executing rotation: Table error detected. Dumping error table:")
        DevTools_Dump(err, "error")
    end

    -- Always log the error - this is critical for debugging silent failures
    self:Error(format("Error executing rotation: %s (useVisitorPattern=%s, hasAST=%s, hasFunc=%s)",
        errorMsg, tostring(useVisitorPattern), tostring(self.cachedRotationAST ~= nil), tostring(self.cachedRotationFunc ~= nil)))

    -- Log enhanced error details if available (for debugging)
    if type(err) == "table" and err.stack then
        self:Debug("Rotation error stack trace:\n%s", err.stack)
    end

    local isDisplayError = errorMsg and (
        strfind(errorMsg, "DisplayManager") or
        strfind(errorMsg, "UpdateIcons") or
        strfind(errorMsg, "UpdateGroupIcons") or
        strfind(errorMsg, "UpdateSequenceGroupIcons") or
        strfind(errorMsg, "SetTexture") or
        strfind(errorMsg, "Show()") or
        strfind(errorMsg, "Hide()") or
        strfind(errorMsg, "ShowOverlay") or
        strfind(errorMsg, "UpdateBorder")
    )

    if isDisplayError then
        self:Warn("Display error detected, preserving rotation cache")
        return true
    end

    -- Clear cache only on non-display errors so rotation can reload; avoid clearing on transient display errors to prevent repeated recompile in same combat
    if useVisitorPattern then
        self:Warn("Clearing cached rotation AST due to error in ExecuteRotationBody - rotation will attempt to reload on next execution")
        self.cachedRotationAST = nil
    else
        self:Warn("Clearing cached rotation function due to error in ExecuteRotationBody - rotation will attempt to reload on next execution")
        self.cachedRotationFunc = nil
    end
    return false
end

-- Core rotation execution without per-call closure allocation
local function ExecuteRotationBody(self, useVisitorPattern)
    local rotationExecuted = false
    -- Per-tick cache for NumberTargets() to avoid redundant TTDManager work within one rotation run
    NAG._numberTargetsCache = {}

    if useVisitorPattern then
        if self.cachedRotationAST then
            local updateSuccess = self:Update(self.cachedRotationAST)
            if updateSuccess then
                rotationExecuted = true
            end
        else
            self:Error("Rotation: Visitor pattern enabled but no cached AST available - rotation will not execute")
        end
    elseif self.cachedRotationFunc then
        local updateSuccess = self:Update(self.cachedRotationFunc)
        if updateSuccess then
            rotationExecuted = true
        end
    else
        self:Error("Rotation: No cached rotation available - rotation will not execute")
    end

    return rotationExecuted
end

local function RotationErrorHandler(err)
    -- Use captured context to preserve logging and cache semantics
    return HandleRotationError(rotationErrorContext.self, rotationErrorContext.useVisitorPattern, err)
end

--File

-- ======= GLOBALIZE =======

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ PRE-PULL/ROTATION/THROTTLER FUNCTIONS ============================

-- Throttled Warn when rotation early-returns (so users see why rotation stopped; Debug-only was invisible)
local EARLY_RETURN_MESSAGES = {
    load_screen_recent = "Rotation not updating: load screen recent (wait a few seconds after zone change)",
    check_false = "Rotation not updating: ns.check() returned false (license/capital or invalid state)",
    should_show_display_false = "Rotation not updating: ShouldShowDisplay() returned false (display hidden or disabled)",
    gcd_probe_nil = "Rotation not updating: GetSpellCooldown returned nil (check secondsSinceLastCallback in /nag freeze)",
    has_enabled_module_false = "Rotation not updating: class module disabled (hasEnabledModule false)",
    spec_or_data_not_ready = "Rotation not updating: spec or startup/data not ready (check /nag freeze)",
}

do
    local EARLY_RETURN_SUPPRESS = {
        options_dialog_open = true,
        edit_mode_active = true,
    }

    -- Reasons that are informational (expected after zone change, etc.) rather than warnings
    local EARLY_RETURN_INFO_LEVEL = {
        load_screen_recent = true,
        check_false = true,
    }

    --- Logs a throttled Warn when rotation early-returns for a given reason (once per 10s per reason).
    --- @param self NAG The addon object
    --- @param reason string Key from EARLY_RETURN_MESSAGES
    function NAG:WarnEarlyReturn(reason)
        local now = GetTime()
        local msg = EARLY_RETURN_MESSAGES[reason] or ("Rotation not updating: " .. tostring(reason))
        local suppressed = EARLY_RETURN_SUPPRESS[reason] == true
        local infoLevel = EARLY_RETURN_INFO_LEVEL[reason] == true

        -- Always persist the most recent early-return gate for freeze diagnostics,
        -- even when warn output is suppressed or throttled.
        self.lastEarlyReturnReason = reason
        self.lastEarlyReturnMessage = msg
        self.lastEarlyReturnAt = now
        self.lastEarlyReturnSuppressed = suppressed
        self.lastEarlyReturnInfoLevel = infoLevel

        if EARLY_RETURN_SUPPRESS[reason] then
            return
        end
        self._lastEarlyReturnWarn = self._lastEarlyReturnWarn or {}
        local last = self._lastEarlyReturnWarn[reason] or 0
        if now - last > 10 then
            self._lastEarlyReturnWarn[reason] = now
            if EARLY_RETURN_INFO_LEVEL[reason] then
                self:Info(msg)
            else
                self:Warn(msg)
            end
        end
    end

    --- Generic Rotation Function that handles the rotation logic.
    --- @param self NAG The NAG addon object
    --- @return boolean success Returns false if rotation setup fails
    --- @usage NAG:Rotation() -- Handles the main rotation logic and spell suggestions
    function NAG:Rotation()
        -- Prevent concurrent execution - if a previous rotation is still running, skip this call
        if isRotationExecuting then
            markRotationCycle("guard_blocked")
            return false
        end

        -- Set execution guard flag
        setRotationExecuting(true)
        markRotationCycle("start")
        markRotationCycle("precheck")

        if self.isLoadScreenRecent then
            markRotationCycle("early_return_load_screen")
            setRotationExecuting(false)
            self:WarnEarlyReturn("load_screen_recent")
            return false
        end
        if self:IsAnyEditMode() then
            markRotationCycle("early_return_edit_mode")
            setRotationExecuting(false)
            self:WarnEarlyReturn("edit_mode_active")
            return false
        end
        if not self.hasEnabledModule then
            markRotationCycle("early_return_module_disabled")
            setRotationExecuting(false)
            self:WarnEarlyReturn("has_enabled_module_false")
            return false
        end
        -- Check schema availability to determine which cache to check
        local APLExecutor = NAG:GetModule("APLExecutor", true)
        local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()

        -- Only get/initialize rotation if we don't have cached data
        local hasCachedRotation = (useVisitorPattern and self.cachedRotationAST) or
                                  (not useVisitorPattern and self.cachedRotationFunc)
        if not hasCachedRotation then
            local rotationManager = NAG:GetModule("RotationManager")
            if not rotationManager then
                self:Error("Rotation: RotationManager module not available - rotation will not execute and display may become stuck")
                markRotationCycle("error_missing_rotation_manager")
                setRotationExecuting(false)
                return false
            end

            -- Suppress noisy warnings when spec/data not ready (e.g., fresh low-level toon, no spec)
            local SpecCompat = NAG:GetModule("SpecCompat", true)
            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            local EventManager = ns.EventManager
            local DataManager = NAG:GetModule("DataManager", true)
            local startupIncomplete = EventManager and EventManager.currentPhase and EventManager.currentPhase < ns.StartupPhase.COMPLETE
            local dataNotReady = DataManager and (not DataManager:IsDataReady())

            if not specIndex or startupIncomplete or dataNotReady then
                markRotationCycle("early_return_spec_or_data_not_ready")
                setRotationExecuting(false)
                self:WarnEarlyReturn("spec_or_data_not_ready")
                return false
            end

            -- CRITICAL: EnsureRotationReady may error (e.g., during combat/encounter transitions)
            -- Always guard it so we never leave isRotationExecuting stuck true, which would freeze rotations until /reload.
            markRotationCycle("ensure_ready")
            local okEnsure, ensureResultOrErr = pcall(function()
                return rotationManager:EnsureRotationReady()
            end)
            if not okEnsure then
                -- Only surface during combat and only if we had a valid rotation at combat start
                if UnitAffectingCombat("player") and rotationManager.hadValidRotationAtCombatStart then
                    self:Error("Rotation: EnsureRotationReady threw an error - rotation will not execute and display may become stuck: %s",
                        tostring(ensureResultOrErr))
                end
                markRotationCycle("error_ensure_ready", ensureResultOrErr)
                setRotationExecuting(false)
                return false
            end
            if not ensureResultOrErr then
                local now = GetTime()
                self._lastEnsureWarn = self._lastEnsureWarn or 0
                if UnitAffectingCombat("player") and rotationManager.hadValidRotationAtCombatStart and (now - self._lastEnsureWarn) > 10 then
                    self._lastEnsureWarn = now
                    self:Error("Rotation: EnsureRotationReady failed - rotation will not execute and display may become stuck")
                end
                markRotationCycle("ensure_ready_failed")
                setRotationExecuting(false)
                return false
            end
        end

        -- NOTE: Automatic rotation switching now handled via event-driven messages
        -- See ClassBase message handlers: OnMobCountChanged, OnCombatStateChanged,
        -- OnGroupRosterUpdated, and OnEquipmentChanged

        -- TRACK ROTATION EXECUTION TIME for smart throttling
        local currentTime = GetTime()
        self.lastRotationTime = currentTime

        -- Execute rotation with centralized error handler (no per-call closures)
        markRotationCycle("execute")
        rotationErrorContext.self = self
        rotationErrorContext.useVisitorPattern = useVisitorPattern
        local success, result = xpcall(ExecuteRotationBody, RotationErrorHandler, self, useVisitorPattern)
        rotationErrorContext.self = nil
        rotationErrorContext.useVisitorPattern = nil

        -- Always clear execution guard flag before returning
        setRotationExecuting(false)

        if not success then
            -- RotationErrorHandler already logged and returned appropriate status
            markRotationCycle("execute_failed", result)
            return result
        end

        local rotationExecuted = result

        -- Return false if no rotation was actually executed
        if not rotationExecuted then
            -- CRITICAL: Rotation execution returned false - could be early return (expected) or execution failure (problem)
            -- This happens when Update() returns false despite having cached rotation (options dialog, load screen, shouldReturn check, etc.)
            -- If this persists, it could indicate rotation is stuck
            markRotationCycle("execute_returned_false")
            return false
        end

        -- Set finish time so rotation_watchdog stall detection can trigger recovery
        self.lastRotationFinishTime = GetTime()
        markRotationCycle("done")

        return true
    end

    --- Updates the rotation logic based on the current time and input delay.
    --- Routes to appropriate execution path based on schema availability
    --- @param self NAG The NAG addon object
    --- @param rotation function|table The rotation function (legacy) or AST (visitor pattern)
    --- @return boolean|nil Returns true if rotation executed successfully, false/nil if early return
    function NAG:Update(rotation)
        markRotationCycle("update_dispatch")
        -- Determine execution mode
        local APLExecutor = NAG:GetModule("APLExecutor", true)
        local useVisitorPattern = APLExecutor and APLExecutor:ShouldUseVisitorPattern()

        if useVisitorPattern then
            -- Schema-aware visitor pattern execution
            -- Use passed rotation parameter if it's a table (AST), otherwise fall back to cached
            local rotationAST = (rotation and type(rotation) == "table") and rotation or self.cachedRotationAST
            if rotationAST then
                return self:UpdateWithVisitor(rotationAST)
            end
        end

        -- Legacy function-based execution
        if rotation and type(rotation) == "function" then
            return self:UpdateWithFunction(rotation)
        end

        self:Error("Update: No valid rotation available - display may become stuck (useVisitorPattern=%s, hasAST=%s, hasFunc=%s)",
            tostring(useVisitorPattern), tostring(self.cachedRotationAST ~= nil), tostring(type(rotation) == "function"))
        markRotationCycle("update_invalid_rotation")
        return false
    end

    --- Updates rotation using visitor pattern execution (schema-aware)
    --- TODO: This is not functional yet
    --- @param self NAG The NAG addon object
    --- @param rotationAST table The proto AST rotation node
    --- @return boolean Returns true if rotation executed successfully, false if early return
    function NAG:UpdateWithVisitor(rotationAST)
        self:Debug("[UpdateWithVisitor] Starting execution")
        if not rotationAST or type(rotationAST) ~= "table" then
            self:Error("UpdateWithVisitor: Invalid rotation AST - expected table, got %s - display may become stuck", type(rotationAST))
            self.cachedRotationAST = nil
            return false
        end

        -- Ensure proto AST has type field for ASTVisitor.Walk
        -- Proto AST from RotationConversionService should have priority_list/groups structure
        -- but might not have explicit type field - ASTVisitor.Walk needs it to route correctly
        -- NOTE: We set the type on the AST directly since it's cached and will be reused
        -- This is safe because the type field is only used for routing, not data integrity
        if not rotationAST.type then
            -- Proto AST rotations have priority_list or groups, so set type to ROTATION
            if rotationAST.priority_list or rotationAST.groups then
                local ASTCore = ns.ASTCore
                if ASTCore and ASTCore.NodeType then
                    rotationAST.type = ASTCore.NodeType.ROTATION
                else
                    rotationAST.type = "rotation"
                end
                -- Mark that we've set the type to avoid redundant checks
                rotationAST._typeSetByNAG = true
            else
                self:Error("UpdateWithVisitor: Proto AST missing type field and no priority_list/groups found - display may become stuck")
                self.cachedRotationAST = nil
                return false
            end
        end

        -- Pause updates if options are open
        if AceConfigDialog and AceConfigDialog.OpenFrames and AceConfigDialog.OpenFrames["NAG"] then
            self:WarnEarlyReturn("options_dialog_open")
            return false
        end
        if self.isLoadScreenRecent then
            self:WarnEarlyReturn("load_screen_recent")
            return false
        end

        local chk = ns.check()
        local DisplayManager = NAG:GetModule("DisplayManager")
        local shouldShowDisplayResult = DisplayManager:ShouldShowDisplay()
        local shouldReturn = not chk or not shouldShowDisplayResult

        self:Debug("[UpdateWithVisitor] chk=%s, ShouldShowDisplay=%s, shouldReturn=%s",
            tostring(chk), tostring(shouldShowDisplayResult), tostring(shouldReturn))

        if shouldReturn then
            if not chk then
                self:WarnEarlyReturn("check_false")
            else
                self:WarnEarlyReturn("should_show_display_false")
            end

            local showGroup = DisplayManager.IsGroupDisplayMode and DisplayManager:IsGroupDisplayMode()
            local showLegacy = DisplayManager.IsLegacyFrameEnabled and DisplayManager:IsLegacyFrameEnabled()
            if showGroup then
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.MAIN, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.AOE, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.COOLDOWNS, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.INTERRUPTS, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.DEFENSIVES, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.SEQUENCE, EMPTY_TABLE)
            end
            if showLegacy then
                DisplayManager:UpdateIcons(nil, EMPTY_TABLE)
            end
            -- Sync anchor visibility so NAG.Frame/GroupDisplayFrame hide when we are not updating icons
            if DisplayManager.UpdateFrameVisibility then
                DisplayManager:UpdateFrameVisibility()
            end
            return false
        end

        touchUIElementsGate()

        local StateManager = NAG:GetModule("StateManager")
        if not StateManager then
            self:Error("[UpdateWithVisitor] Early return: StateManager not available")
            return false
        end

        -- Validate StateManager state structure exists
        if not StateManager.state or not StateManager.state.next then
            self:Error("[UpdateWithVisitor] Early return: StateManager.state.next not initialized")
            return false
        end

        local timeNow = GetTime()
        local gcdProbeSpellId = getGcdProbeSpellId()
        local cdInfo, cdInfoDur = WoWAPI.GetSpellCooldown(gcdProbeSpellId)
        if not cdInfo then
            StateManager.state.next.nextTime = timeNow + NAG.db.global.inputDelay
            self:WarnEarlyReturn("gcd_probe_nil")
            return false
        end

        -- Defensive: handle raw multi-return API (number) when WoWAPI wrapper is missing
        local gcdStart, gcdDuration
        if type(cdInfo) == "table" then
            gcdStart = cdInfo.startTime or 0
            gcdDuration = cdInfo.duration or 0
        else
            gcdStart = cdInfo or 0
            gcdDuration = cdInfoDur or 0
        end

        local spell, _, _, _, endTime = UnitCastingInfo("player")
        if not spell then endTime = 0 end
        StateManager.state.next.nextTime = max(timeNow + NAG.db.global.inputDelay, gcdStart + gcdDuration,
            (endTime / 1000))

        -- Clear overlay text for old nextSpell and all secondaries (by normalized display ID) before clearing
        if self.nextSpell then
            local oldPrimaryId = (self.GetActionResolveId and self:GetActionResolveId(self.nextSpell))
                or (self.GetActionDisplayId and self:GetActionDisplayId(self.nextSpell))
            if oldPrimaryId then
                self:ClearCastOverlayText(oldPrimaryId)
            end
        end
        self:ClearSecondarySpellOverlays(self.secondarySpells)

        self.nextSpell = nil
        wipe(self.secondarySpells)
        self:Debug("[UpdateWithVisitor] Cleared nextSpell, secondarySpells, and position overrides before execution")

        -- Update sequence displays
        local showGroup = DisplayManager.IsGroupDisplayMode and DisplayManager:IsGroupDisplayMode()
        local showLegacy = DisplayManager.IsLegacyFrameEnabled and DisplayManager:IsLegacyFrameEnabled()
        self:Debug("[UpdateWithVisitor] Display modes: showGroup=%s, showLegacy=%s", tostring(showGroup), tostring(showLegacy))

        -- Update sequence displays with error protection
        local seqSuccess, seqErr = pcall(function()
            NAG:UpdateActiveSequenceDisplay()

            if showGroup and DisplayManager.UpdateSequenceGroupIcons then
                DisplayManager:UpdateSequenceGroupIcons()
            end
        end)

        if not seqSuccess then
            self:Error("Error updating sequence display: %s", tostring(seqErr))
        end

        local APLEvaluationCache = NAG:GetModule("APLEvaluationCache", true)
        -- Check if module exists and cache is enabled (direct db access for hotpath performance)
        if APLEvaluationCache and APLEvaluationCache.db.global.enableCache then
            local cacheIterations = APLEvaluationCache.db.global.cacheIterations or 1
            if cacheIterations == 1 then
                APLEvaluationCache:StartEvaluation(true)
            else
                self.cacheIterationCount = (self.cacheIterationCount or 0) + 1
                local shouldClearCache = (self.cacheIterationCount % cacheIterations == 1)
                APLEvaluationCache:StartEvaluation(shouldClearCache)
            end
        end

        -- Execute rotation using visitor pattern
        local APLExecutor = NAG:GetModule("APLExecutor", true)
        if not APLExecutor then
            NAG:Error("[UpdateWithVisitor] Early return: APLExecutor module not available")
            return false
        end

        -- Access ASTVisitor at runtime to avoid initialization order issues
        local ASTVisitor = ns.ASTVisitor
        if not ASTVisitor then
            NAG:Error("[UpdateWithVisitor] Early return: ASTVisitor not available")
            return false
        end

        self:Debug("[UpdateWithVisitor] About to execute rotation AST")
        local executorVisitor = APLExecutor:CreateExecutionVisitor()

        -- Use ns.pcall for enhanced error reporting (consistent with UpdateWithFunction)
        local rotationStartMs = debugprofilestop()
        local success, result = pcall(function()
            ASTVisitor.Walk(executorVisitor, rotationAST, {
                executionContext = {
                    stateManager = StateManager,
                    displayManager = DisplayManager,
                }
            })
        end)
        local rotationElapsedMs = debugprofilestop() - rotationStartMs
        if rotationElapsedMs > ROTATION_EXECUTION_WARN_MS then
            self:Warn("Rotation run exceeded %d ms (%.0f ms) - may cause timer lag or heartbeat stalls. Run /nag freeze and report if this persists.", ROTATION_EXECUTION_WARN_MS, rotationElapsedMs)
        end
        NAG.lastRotationExecutionMs = rotationElapsedMs

        self:Debug("[UpdateWithVisitor] Rotation execution completed: success=%s, nextSpell=%s, secondarySpells count=%d",
            tostring(success), tostring(self.nextSpell), #self.secondarySpells)

        if not success then
            -- Use ExtractErrorMessage to properly handle both string and enhanced error table formats
            local errorMsg = ExtractErrorMessage(result)

            -- Use DevTools_Dump to inspect the error table if available
            if type(result) == "table" and DevTools_Dump then
                self:Error("Error executing rotation AST: Table error detected. Dumping error table:")
                DevTools_Dump(result, "error")
            end

            -- Always log the error - this is critical for debugging silent failures
            self:Error(format("Error executing rotation AST: %s", errorMsg))

            -- Log enhanced error details if available (for debugging)
            if type(result) == "table" and result.stack then
                self:Debug("Rotation AST error stack trace:\n%s", result.stack)
            end

            -- CRITICAL FIX: Check if error is display-related before clearing cache
            local isDisplayError = errorMsg and (
                strfind(errorMsg, "DisplayManager") or
                strfind(errorMsg, "UpdateIcons") or
                strfind(errorMsg, "UpdateGroupIcons") or
                strfind(errorMsg, "UpdateSequenceGroupIcons") or
                strfind(errorMsg, "SetTexture") or
                strfind(errorMsg, "Show()") or
                strfind(errorMsg, "Hide()") or
                strfind(errorMsg, "ShowOverlay") or
                strfind(errorMsg, "UpdateBorder")
            )

            if not isDisplayError then
                -- Only clear cache for non-display errors
                self:Warn("Clearing cached rotation AST due to error - rotation will attempt to reload on next execution")
                self.cachedRotationAST = nil
            else
                -- Display error - log but preserve cache
                self:Error("Display error in UpdateWithVisitor, preserving cache - this may cause stuck display: %s", errorMsg)
            end
        end

        -- Always end evaluation
        if APLEvaluationCache and APLEvaluationCache.db.global.enableCache then
            APLEvaluationCache:EndEvaluation()
        end

        self:Debug("[UpdateWithVisitor] About to update display: nextSpell=%s, secondarySpells count=%d",
            tostring(self.nextSpell), #self.secondarySpells)

        -- When Enable Autocast Other Cooldowns is on, add racials/trinkets/potions to secondarySpells this cycle
        local classModule = NAG:GetClassModule()
        if classModule and classModule.db.char.enableAutocastOtherCooldowns then
            local autocastOk, autocastErr = pcall(function()
                NAG:AutocastOtherCooldowns()
            end)
            if not autocastOk then
                self:Warn("[UpdateWithVisitor] AutocastOtherCooldowns failed: %s", tostring(autocastErr))
            end
        end

        -- Update display (reuse existing display update code) with error protection; project once per cycle
        local projectedSecondaries = self:BuildProjectedSecondaries(self.secondarySpells)
        local displaySuccess, displayErr = pcall(function()
            if showGroup then
                self:Debug("[UpdateWithVisitor] Updating group display")
                local groupIconData = self:GetDisplayGroupIconData(projectedSecondaries)
                self:Debug("[UpdateWithVisitor] Group icon data: MAIN=%d, AOE=%d, COOLDOWNS=%d, INTERRUPTS=%d, DEFENSIVES=%d",
                    #(groupIconData[ns.FRAME_GROUPS.MAIN] or {}),
                    #(groupIconData[ns.FRAME_GROUPS.AOE] or {}),
                    #(groupIconData[ns.FRAME_GROUPS.COOLDOWNS] or {}),
                    #(groupIconData[ns.FRAME_GROUPS.INTERRUPTS] or {}),
                    #(groupIconData[ns.FRAME_GROUPS.DEFENSIVES] or {}))
                -- MAIN group is updated by UpdateMainGroupWithPredictions below (current + predictions only)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.AOE, groupIconData[ns.FRAME_GROUPS.AOE])
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.COOLDOWNS, groupIconData[ns.FRAME_GROUPS.COOLDOWNS])
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.INTERRUPTS, groupIconData[ns.FRAME_GROUPS.INTERRUPTS])
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.DEFENSIVES, groupIconData[ns.FRAME_GROUPS.DEFENSIVES])
            end
            if showLegacy then
                self:Debug("[UpdateWithVisitor] Updating legacy display: nextSpell=%s", tostring(self.nextSpell))
                DisplayManager:UpdateIcons(self.nextSpell, projectedSecondaries)
            end
        end)

        if not displaySuccess then
            self:Error("[UpdateWithVisitor] Critical error updating display icons - display may become stuck: %s", tostring(displayErr))
        end

        -- Prediction queue integration (reuse existing code)
        local predictionSettings = NAG.db.char.predictionQueue
        local RotationManager = NAG:GetModule("RotationManager")

        self:Debug("[UpdateWithVisitor] Prediction queue: RotationManager=%s, predictionSettings=%s, IsGroupDisplayMode=%s",
            tostring(RotationManager ~= nil), tostring(predictionSettings ~= nil), tostring(DisplayManager:IsGroupDisplayMode()))

        -- Skip prediction queue if RotationManager not available
        if not RotationManager then
            self:Debug("[UpdateWithVisitor] Returning early: RotationManager not available (skipping prediction queue)")
            return true  -- Rotation executed successfully, just skipping prediction queue
        end

        -- Update prediction queue with error protection
        local predSuccess, predErr = pcall(function()
            if DisplayManager:IsGroupDisplayMode() then
                self:Debug("[UpdateWithVisitor] Updating MAIN group with predictions")
                if predictionSettings and predictionSettings.enabled then
                    local numPredictions = predictionSettings.numPredictions or 2
                    local predictions = RotationManager:GeneratePredictionQueue(numPredictions)
                    updateSuggestedHealTargetLabel()
                    if predictions and #predictions > 0 then
                        if DisplayManager:IsLegacyFrameEnabled() then
                            DisplayManager:UpdatePredictionQueue(predictions)
                        end
                        DisplayManager:UpdateMainGroupWithPredictions(NAG.nextSpell, predictions)
                    else
                        if DisplayManager:IsLegacyFrameEnabled() then
                            DisplayManager:HidePredictionQueue()
                        end
                        DisplayManager:UpdateMainGroupWithPredictions(NAG.nextSpell, nil)
                    end
                else
                    self:Debug("[UpdateWithVisitor] Predictions disabled, updating MAIN group with current spell only: nextSpell=%s", tostring(NAG.nextSpell))
                    updateSuggestedHealTargetLabel()
                    DisplayManager:UpdateMainGroupWithPredictions(NAG.nextSpell, nil)
                end
            elseif DisplayManager:IsLegacyFrameEnabled() then
                self:Debug("[UpdateWithVisitor] Legacy frame enabled, updating prediction queue")
                if predictionSettings and predictionSettings.enabled then
                    local numPredictions = predictionSettings.numPredictions or 2
                    local predictions = RotationManager:GeneratePredictionQueue(numPredictions)
                    if predictions and #predictions > 0 then
                        DisplayManager:UpdatePredictionQueue(predictions)
                    else
                        DisplayManager:HidePredictionQueue()
                    end
                end
            end
        end)

        if not predSuccess then
            self:Error("[UpdateWithVisitor] Critical error updating prediction queue - MAIN group display may become stuck: %s", tostring(predErr))
        end

        self:Debug("[UpdateWithVisitor] Execution completed successfully, returning true")
        return true  -- Rotation executed successfully
    end

    --- Updates rotation using function-based execution (legacy/TBC)
    --- @param self NAG The NAG addon object
    --- @param rotation function The rotation function that determines the next spell
    --- @return boolean Returns true if rotation executed successfully, false if early return
    function NAG:UpdateWithFunction(rotation)
        -- Safety check: ensure rotation is a valid function
        if not rotation or type(rotation) ~= "function" then
            self:Error("UpdateWithFunction: Invalid rotation parameter - expected function, got %s - display may become stuck", type(rotation))
            self.cachedRotationFunc = nil
            return false
        end

        -- Pause updates if options are open
        if AceConfigDialog and AceConfigDialog.OpenFrames and AceConfigDialog.OpenFrames["NAG"] then
            self:WarnEarlyReturn("options_dialog_open")
            return false
        end
        if self.isLoadScreenRecent then
            self:WarnEarlyReturn("load_screen_recent")
            return false
        end
        --if PullTimer:GetTimeToZero() then return end
        local chk = ns.check()
        local DisplayManager = NAG:GetModule("DisplayManager")
        if not DisplayManager then
            -- CRITICAL: DisplayManager missing would cause errors on all DisplayManager calls
            self:Error(format("UpdateWithFunction: CRITICAL - DisplayManager module not available - rotation execution will fail and display may become stuck"))
            return false
        end
        local shouldShowDisplayResult = DisplayManager:ShouldShowDisplay()
        local shouldReturn = not chk or not shouldShowDisplayResult

        if shouldReturn then
            -- Surface throttled Warn so users see why rotation stopped (Debug-only was invisible)
            if not chk then
                self:WarnEarlyReturn("check_false")
            else
                self:WarnEarlyReturn("should_show_display_false")
            end

            local showGroup = DisplayManager.IsGroupDisplayMode and DisplayManager:IsGroupDisplayMode()
            local showLegacy = DisplayManager.IsLegacyFrameEnabled and DisplayManager:IsLegacyFrameEnabled()
            if showGroup then
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.MAIN, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.AOE, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.COOLDOWNS, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.INTERRUPTS, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.DEFENSIVES, EMPTY_TABLE)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.SEQUENCE, EMPTY_TABLE)
            end
            if showLegacy then
                DisplayManager:UpdateIcons(nil, EMPTY_TABLE)
            end
            -- Sync anchor visibility so NAG.Frame/GroupDisplayFrame hide when we are not updating icons
            if DisplayManager.UpdateFrameVisibility then
                DisplayManager:UpdateFrameVisibility()
            end
            return false
        end

        touchUIElementsGate()

        local StateManager = NAG:GetModule("StateManager")
        if not StateManager then
            -- CRITICAL: StateManager missing would cause errors on state access
            self:Error(format("UpdateWithFunction: CRITICAL - StateManager module not available - rotation execution will fail and display may become stuck"))
            return false
        end
        if not StateManager.state or not StateManager.state.next then
            -- CRITICAL: State structure missing would cause errors on state.next access
            self:Error(format("UpdateWithFunction: CRITICAL - StateManager.state.next not initialized - rotation execution will fail and display may become stuck"))
            return false
        end
        local timeNow = GetTime()
        local gcdProbeSpellId = getGcdProbeSpellId()
        local cdInfo, cdInfoDur = WoWAPI.GetSpellCooldown(gcdProbeSpellId)
        if not cdInfo then
            StateManager.state.next.nextTime = timeNow + NAG.db.global.inputDelay
            self:WarnEarlyReturn("gcd_probe_nil")
            return false
        end

        -- Defensive: handle raw multi-return API (number) when WoWAPI wrapper is missing
        local gcdStart, gcdDuration
        if type(cdInfo) == "table" then
            gcdStart = cdInfo.startTime or 0
            gcdDuration = cdInfo.duration or 0
        else
            gcdStart = cdInfo or 0
            gcdDuration = cdInfoDur or 0
        end

        local spell, _, _, _, endTime = UnitCastingInfo("player")
        if not spell then endTime = 0 end
        -- Get input delay setting with direct database access
        StateManager.state.next.nextTime = max(timeNow + NAG.db.global.inputDelay, gcdStart + gcdDuration,
            (endTime / 1000))

        self.nextSpell = nil
        --self.secondarySpells = {}
        wipe(self.secondarySpells)

        -- Update sequence displays based on active display system(s)
        -- NOTE: Sequences are updated separately from the main group icon update cycle
        -- because they use NAG.RightSlots.sequence data directly (from APLSequences.lua)
        -- rather than going through GetDisplayGroupIconData() mapping
        local showGroup = DisplayManager.IsGroupDisplayMode and DisplayManager:IsGroupDisplayMode()
        local showLegacy = DisplayManager.IsLegacyFrameEnabled and DisplayManager:IsLegacyFrameEnabled()

        -- Update sequence displays with error protection
        local seqSuccess, seqErr = pcall(function()
            NAG:UpdateActiveSequenceDisplay()

            -- UpdateSequenceGroupIcons is only used by group system
            if showGroup and DisplayManager.UpdateSequenceGroupIcons then
                DisplayManager:UpdateSequenceGroupIcons()
            end
        end)

        if not seqSuccess then
            self:Error("Error updating sequence display: %s", tostring(seqErr))
        end
        local APLEvaluationCache = NAG:GetModule("APLEvaluationCache", true)
        -- APL evaluation cache (function-based path; direct db access for hotpath performance)
        if APLEvaluationCache and APLEvaluationCache.db.global.enableCache then
            local cacheIterations = APLEvaluationCache.db.global.cacheIterations or 1

            -- CRITICAL: Wrap StartEvaluation in pcall to prevent errors from breaking rotation execution
            local cacheStartSuccess, cacheStartErr = pcall(function()
                if cacheIterations == 1 then
                    -- Fast path: clear every iteration (no tracking overhead)
                    APLEvaluationCache:StartEvaluation(true)
                else
                    -- Multi-iteration caching: track and cycle
                    self.cacheIterationCount = (self.cacheIterationCount or 0) + 1
                    local shouldClearCache = (self.cacheIterationCount % cacheIterations == 1)
                    APLEvaluationCache:StartEvaluation(shouldClearCache)
                end
            end)
            if not cacheStartSuccess then
                self:Error(format("UpdateWithFunction: CRITICAL - APLEvaluationCache:StartEvaluation() failed: %s - rotation execution may be affected", tostring(cacheStartErr)))
            end
        end

        -- Execute rotation with error handling
        local rotationStartMs = debugprofilestop()
        local success, foundSpell = pcall(rotation)
        local rotationElapsedMs = debugprofilestop() - rotationStartMs
        if rotationElapsedMs > ROTATION_EXECUTION_WARN_MS then
            self:Warn("Rotation run exceeded %d ms (%.0f ms) - may cause timer lag or heartbeat stalls. Run /nag freeze and report if this persists.", ROTATION_EXECUTION_WARN_MS, rotationElapsedMs)
        end
        NAG.lastRotationExecutionMs = rotationElapsedMs
        if not success then
            -- Use ExtractErrorMessage to properly handle both string and enhanced error table formats
            local errorMsg = ExtractErrorMessage(foundSpell)
            -- Always log the error - this is critical for debugging silent failures
            self:Error(format("Error executing rotation: %s", errorMsg))

            -- Log enhanced error details if available (for debugging)
            if type(foundSpell) == "table" and foundSpell.stack then
                self:Debug("Rotation error stack trace:\n%s", foundSpell.stack)
            end

            -- CRITICAL FIX: Check if error is display-related before clearing cache
            local isDisplayError = errorMsg and (
                strfind(errorMsg, "DisplayManager") or
                strfind(errorMsg, "UpdateIcons") or
                strfind(errorMsg, "UpdateGroupIcons") or
                strfind(errorMsg, "UpdateSequenceGroupIcons") or
                strfind(errorMsg, "SetTexture") or
                strfind(errorMsg, "Show()") or
                strfind(errorMsg, "Hide()") or
                strfind(errorMsg, "ShowOverlay") or
                strfind(errorMsg, "UpdateBorder")
            )

            if not isDisplayError then
                -- Only clear cache for non-display errors
                self:Warn("Clearing cached rotation function due to error - rotation will attempt to reload on next execution")
                self.cachedRotationFunc = nil
            else
                -- Display error - log but preserve cache
                self:Error("Display error in UpdateWithFunction, preserving cache - this may cause stuck display: %s", errorMsg)
            end
        end

        -- Shadow-only OG Ret helper: compute + compare after rotation evaluation.
        -- This must never affect live recommendation selection.
        if success then
            local shadowSuccess, shadowErr = pcall(function()
                runOGRetShadowCompare(self)
            end)
            if not shadowSuccess and self:IsDevModeEnabled() then
                self:Warn("UpdateWithFunction: OGRet shadow compare failed: %s", tostring(shadowErr))
            end
        end

        -- Always end evaluation (but cache persists unless cycling)
        if APLEvaluationCache and APLEvaluationCache.db.global.enableCache then
            -- CRITICAL: Wrap EndEvaluation in pcall to prevent errors from breaking rotation execution
            local cacheEndSuccess, cacheEndErr = pcall(function()
                APLEvaluationCache:EndEvaluation()
            end)
            if not cacheEndSuccess then
                self:Error(format("UpdateWithFunction: CRITICAL - APLEvaluationCache:EndEvaluation() failed: %s - rotation execution may be affected", tostring(cacheEndErr)))
            end
        end

        -- When Enable Autocast Other Cooldowns is on, add racials/trinkets/potions to secondarySpells this cycle
        local classModule = NAG:GetClassModule()
        if classModule and classModule.db.char.enableAutocastOtherCooldowns then
            local autocastOk, autocastErr = pcall(function()
                NAG:AutocastOtherCooldowns()
            end)
            if not autocastOk then
                self:Warn("UpdateWithFunction: AutocastOtherCooldowns failed: %s", tostring(autocastErr))
            end
        end

        -- Update display icons with error protection; project once per cycle
        local projectedSecondaries = self:BuildProjectedSecondaries(self.secondarySpells)
        markRotationCycle("display")
        local displaySuccess, displayErr = pcall(function()
            if showGroup then
                local groupIconData = self:GetDisplayGroupIconData(projectedSecondaries)
                -- MAIN group is updated by UpdateMainGroupWithPredictions below (current + predictions only)
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.AOE, groupIconData[ns.FRAME_GROUPS.AOE])
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.COOLDOWNS, groupIconData[ns.FRAME_GROUPS.COOLDOWNS])
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.INTERRUPTS, groupIconData[ns.FRAME_GROUPS.INTERRUPTS])
                DisplayManager:UpdateGroupIcons(ns.FRAME_GROUPS.DEFENSIVES, groupIconData[ns.FRAME_GROUPS.DEFENSIVES])

                -- NOTE: SEQUENCE group is updated separately by UpdateSequenceGroupIcons() above
            end
            if showLegacy then
                DisplayManager:UpdateIcons(self.nextSpell, projectedSecondaries)
            end
        end)

        if not displaySuccess then
            -- CRITICAL: Display update pcall failure causes permanent freeze
            self:Error(format("UpdateWithFunction: Critical error updating display icons - display may become stuck: %s (nextSpell=%s, secondarySpells count=%d)",
                tostring(displayErr), tostring(self.nextSpell), #self.secondarySpells))
            markRotationCycle("display_error", displayErr)
        elseif success and not showGroup and not showLegacy then
            -- CRITICAL: Rotation executed but UpdateIcons() was never called (would cause permanent freeze)
            self:Error(format("UpdateWithFunction: Rotation executed successfully but UpdateIcons() was not called - display may become stuck (showGroup=%s, showLegacy=%s, nextSpell=%s, secondarySpells count=%d)",
                tostring(showGroup), tostring(showLegacy), tostring(self.nextSpell), #self.secondarySpells))
            markRotationCycle("display_skipped")
        end

        -- ============================ PREDICTION QUEUE SYSTEM INTEGRATION ============================
        -- Update prediction queue and GroupDisplay main container
        local predictionSettings = NAG.db.char.predictionQueue
        local RotationManager = NAG:GetModule("RotationManager")

        -- Skip prediction queue if RotationManager not available
        if not RotationManager then
            self:Debug("UpdateWithFunction: RotationManager not available - skipping prediction queue (rotation executed successfully)")
            return true  -- Rotation executed successfully, just skipping prediction queue
        end

        -- Update prediction queue with error protection
        local predSuccess, predErr = pcall(function()
            if DisplayManager:IsGroupDisplayMode() then
                -- Always update MAIN group: with predictions if enabled, or just current spell if disabled
                if predictionSettings and predictionSettings.enabled then
                    -- Generate prediction queue
                    local numPredictions = predictionSettings.numPredictions or 2
                    local predictions = RotationManager:GeneratePredictionQueue(numPredictions)
                    updateSuggestedHealTargetLabel()
                    -- Update prediction queue display
                    if predictions and #predictions > 0 then
                        -- Update standalone prediction queue frames only if legacy display is enabled
                        if DisplayManager:IsLegacyFrameEnabled() then
                            DisplayManager:UpdatePredictionQueue(predictions)
                        end
                        -- Update GroupDisplay main container with predictions
                        DisplayManager:UpdateMainGroupWithPredictions(NAG.nextSpell, predictions)
                    else
                        -- Hide standalone prediction queue frames only if legacy display is enabled
                        if DisplayManager:IsLegacyFrameEnabled() then
                            DisplayManager:HidePredictionQueue()
                        end
                        -- Still show current spell in main group frame 1
                        DisplayManager:UpdateMainGroupWithPredictions(NAG.nextSpell, nil)
                    end
                else
                    -- Predictions disabled: show current spell only
                    updateSuggestedHealTargetLabel()
                    DisplayManager:UpdateMainGroupWithPredictions(NAG.nextSpell, nil)
                end
            elseif DisplayManager:IsLegacyFrameEnabled() then
                -- Legacy-only: update standalone prediction queue if enabled
                if predictionSettings and predictionSettings.enabled then
                    local numPredictions = predictionSettings.numPredictions or 2
                    local predictions = RotationManager:GeneratePredictionQueue(numPredictions)
                    if predictions and #predictions > 0 then
                        DisplayManager:UpdatePredictionQueue(predictions)
                    else
                        DisplayManager:HidePredictionQueue()
                    end
                end
            end
        end)

        if not predSuccess then
            self:Error("UpdateWithFunction: Critical error updating prediction queue - MAIN group display may become stuck: %s", tostring(predErr))
        end

        return true  -- Rotation executed successfully
    end
end

function NAG:HasGlyph(glyphId)
    local StateManager = NAG:GetModule("StateManager")
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    return StateManager:HasGlyph(glyphId)
end

function NAG:HasPrimeGlyph(glyphId)
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    -- Check prime glyph slots (type 0)
    for i = 1, GetNumGlyphSockets() do
        local enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
        if enabled and glyphType == 3 and glyphSpellId == glyphId then
            return true
        end
    end

    return false
end

function NAG:HasMajorGlyph(glyphId)
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    -- Check major glyph slots (type 1)
    for i = 1, GetNumGlyphSockets() do
        local enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
        if enabled and glyphType == 1 and glyphSpellId == glyphId then
            return true
        end
    end

    return false
end

function NAG:HasMinorGlyph(glyphId)
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    -- Check minor glyph slots (type 2)
    for i = 1, GetNumGlyphSockets() do
        local enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
        if enabled and glyphType == 2 and glyphSpellId == glyphId then
            return true
        end
    end

    return false
end

local CACHED_GROUP_ICON_DATA = {
    [ns.FRAME_GROUPS.MAIN] = {},
    [ns.FRAME_GROUPS.AOE] = {},
    [ns.FRAME_GROUPS.COOLDOWNS] = {},
    [ns.FRAME_GROUPS.INTERRUPTS] = {},
    [ns.FRAME_GROUPS.DEFENSIVES] = {},
    [ns.FRAME_GROUPS.SEQUENCE] = {},
}
local CACHED_INSERT_TO_GROUP_FUNC

--- Build display-relevant fields once per entry (no persistent cache). Used by group and legacy display.
--- @param secondarySpells table
--- @return table Array of { norm, resolveId, displayId, preferItemFirst, position }
local function buildProjectedSecondaries(secondarySpells)
    local out = {}
    if not secondarySpells or type(secondarySpells) ~= "table" then
        return out
    end
    local SpellbookManager = NAG:GetModule("SpellbookManager", true)
    for i = 1, #secondarySpells do
        local norm = normalizeSecondarySpellEntry(secondarySpells[i])
        if norm then
            local resolveId = NAG.GetActionResolveId and NAG:GetActionResolveId(norm)
                or ((norm.itemId and norm.spellId) or norm.spellId or norm.itemId)
            local displayId = NAG.GetActionDisplayId and NAG:GetActionDisplayId(norm)
                or (norm.itemId or norm.spellId)
            if resolveId and displayId then
                local preferItemFirst = (norm.itemId ~= nil)
                local position = norm.position
                if not position and SpellbookManager and SpellbookManager.GetSpellPosition then
                    position = SpellbookManager:GetSpellPosition(resolveId) or SpellbookManager:GetSpellPosition(displayId)
                end
                out[#out + 1] = { norm = norm, resolveId = resolveId, displayId = displayId, preferItemFirst = preferItemFirst, position = position }
            end
        end
    end
    return out
end

--- Resolve an icon + classify whether the id should be treated as an item.
--- Delegates to DisplayManager:ResolveDisplayIcon (shared with legacy GetCachedEntity path).
--- @param id number
--- @param dataManager DataManager|nil
--- @param preferItemFirst boolean|nil When nil, resolved via canonical identity normalization.
--- @return number|nil texture
--- @return boolean isItem
--- @return number|nil cooldownItemId When set (e.g. tinker), use this for GetItemCooldown instead of spell cooldown
local function ResolveGroupDisplayIcon(id, dataManager, preferItemFirst)
    local DisplayManager = NAG:GetModule("DisplayManager", true)
    if not DisplayManager or not DisplayManager.ResolveDisplayIcon then
        return nil, false, nil
    end
    if preferItemFirst == nil and NAG.NormalizeActionIdentity then
        local normalized = NAG:NormalizeActionIdentity(id, { context = "group_display_icon" })
        preferItemFirst = normalized and normalized.itemId ~= nil or false
    end
    return DisplayManager:ResolveDisplayIcon(id, dataManager, preferItemFirst)
end

--- @param projectedSecondaries table|nil Optional pre-built from BuildProjectedSecondaries; when nil, built from self.secondarySpells
function NAG:GetDisplayGroupIconData(projectedSecondaries)
    for _, groupTable in pairs(CACHED_GROUP_ICON_DATA) do
        wipe(groupTable)
    end

    -- Reset icon data pool index
    iconDataPoolIndex = 0

    -- Create cached insert function if not exists
    if not CACHED_INSERT_TO_GROUP_FUNC then
        CACHED_INSERT_TO_GROUP_FUNC = function(groupKey, icon)
            if CACHED_GROUP_ICON_DATA[groupKey] then
                table.insert(CACHED_GROUP_ICON_DATA[groupKey], icon)
            end
        end
    end

    -- Main: nextSpell (PRIMARY position → main group) using canonical action identity.
    local primaryIdentity = self.NormalizePrimaryAction and self:NormalizePrimaryAction(self.nextSpell) or nil
    if primaryIdentity then
        local mainResolveId = self.GetActionResolveId and self:GetActionResolveId(primaryIdentity) or nil
        local mainDisplayId = self.GetActionDisplayId and self:GetActionDisplayId(primaryIdentity) or nil
        local DataManager = NAG:GetModule("DataManager")
        local preferItemFirst = primaryIdentity.itemId ~= nil
        local texture, isItem, cooldownItemId = ResolveGroupDisplayIcon(mainResolveId, DataManager, preferItemFirst)
        local iconData = getNextIconData()
        iconData.texture = texture
        if cooldownItemId and primaryIdentity.spellId then
            iconData.itemId = cooldownItemId
            iconData.spellId = primaryIdentity.spellId
        elseif primaryIdentity.itemId and not primaryIdentity.spellId then
            iconData.itemId = primaryIdentity.itemId
        elseif primaryIdentity.itemId and primaryIdentity.spellId then
            iconData.itemId = primaryIdentity.itemId
            iconData.spellId = primaryIdentity.spellId
        elseif cooldownItemId then
            iconData.itemId = cooldownItemId
            iconData.spellId = primaryIdentity.spellId or mainDisplayId
        elseif isItem then
            iconData.itemId = mainDisplayId
        else
            iconData.spellId = primaryIdentity.spellId or mainDisplayId
        end
        CACHED_INSERT_TO_GROUP_FUNC(ns.FRAME_GROUPS.MAIN, iconData)
    end

    -- Secondary spells: use projected list when provided so resolution runs once per cycle
    local list = projectedSecondaries
    if not list or type(list) ~= "table" then
        list = buildProjectedSecondaries(self.secondarySpells or {})
    end
    if #list > 0 then
        local DataManager = NAG:GetModule("DataManager")
        local SpellbookManager = NAG:GetModule("SpellbookManager")
        local DisplayManager = NAG:GetModule("DisplayManager")
        local StateManager = NAG:GetModule("StateManager", true)
        local seenTinkerItemIds = {}
        for _, proj in ipairs(list) do
            local norm = proj.norm
            local resolveId = proj.resolveId
            local displayId = proj.displayId
            local preferItem = proj.preferItemFirst
            local id = displayId
            if not norm or not resolveId or not id then
                -- skip invalid
            else
                local tinkerItemId = norm.itemId or (norm.spellId and StateManager and StateManager:GetTinkerItemIdForDisplay(norm.spellId))
                if tinkerItemId and seenTinkerItemIds[tinkerItemId] then
                    -- already showing this tinker (one icon per item)
                else
                    if tinkerItemId then
                        seenTinkerItemIds[tinkerItemId] = true
                    end
                    local icon, isItem, cooldownItemId = ResolveGroupDisplayIcon(resolveId, DataManager, preferItem)
                    if not icon then
                        icon = GetSpellTexture(resolveId) or GetItemIcon(id)
                    end
                    if icon then
                        local iconData = getNextIconData()
                        iconData.texture = icon
                        -- Preserve both IDs for overlay text lookup parity with legacy path.
                        -- Some actions (e.g. Auto Attack 6603) can be stored under resolved/display variants.
                        iconData.overlayResolveId = resolveId
                        iconData.overlayDisplayId = displayId
                        if norm.itemId then
                            iconData.itemId = norm.itemId
                            iconData.spellId = norm.spellId
                        elseif cooldownItemId then
                            iconData.itemId = cooldownItemId
                            iconData.spellId = norm.spellId or id
                        elseif isItem then
                            iconData.itemId = id
                        else
                            iconData.spellId = id
                        end
                        local normalizedPosition = DisplayManager.NormalizeSpellPosition and DisplayManager:NormalizeSpellPosition(proj.position) or nil
                        local spellPosition = normalizedPosition
                            or (proj.position and ns.VALID_SPELL_POSITIONS[proj.position] and proj.position)
                            or (SpellbookManager and SpellbookManager.GetSpellPosition and SpellbookManager:GetSpellPosition(resolveId))
                            or ns.SPELL_POSITIONS.PRIMARY

                        -- Secondaries go to non-main/primary slots only; MAIN is for nextSpell (and predictions) only.
                        -- SEQUENCE is driven only by UpdateSequenceGroupIcons (NAG.RightSlots.sequence), so we never call UpdateGroupIcons(SEQUENCE, ...). Right-positioned secondaries would otherwise go to SEQUENCE and never show.
                        local targetGroup = DisplayManager:PositionToGroup(spellPosition)
                        if targetGroup == ns.FRAME_GROUPS.MAIN then
                            targetGroup = ns.FRAME_GROUPS.COOLDOWNS
                        elseif targetGroup == ns.FRAME_GROUPS.SEQUENCE then
                            targetGroup = ns.FRAME_GROUPS.COOLDOWNS
                        end
                        -- If the target group is full, overflow to COOLDOWNS so the icon still shows.
                        local maxIcons = DisplayManager:GetGroupNumIcons(targetGroup)
                        if (CACHED_GROUP_ICON_DATA[targetGroup] and #CACHED_GROUP_ICON_DATA[targetGroup] >= maxIcons) then
                            targetGroup = ns.FRAME_GROUPS.COOLDOWNS
                        end
                        -- If the group is disabled (hidden), put the icon in an enabled group so it still shows.
                        if not DisplayManager:IsGroupEnabled(targetGroup) then
                            local fallbackOrder = {
                                ns.FRAME_GROUPS.COOLDOWNS,
                                ns.FRAME_GROUPS.DEFENSIVES,
                                ns.FRAME_GROUPS.AOE,
                                ns.FRAME_GROUPS.INTERRUPTS,
                                ns.FRAME_GROUPS.SEQUENCE,
                            }
                            for _, g in ipairs(fallbackOrder) do
                                if DisplayManager:IsGroupEnabled(g) then
                                    targetGroup = g
                                    break
                                end
                            end
                        end
                        CACHED_INSERT_TO_GROUP_FUNC(targetGroup, iconData)
                    end
                end
            end
        end
    end

    return CACHED_GROUP_ICON_DATA
end

--- Ensures the UI is ready for display
--- @param self NAG
function NAG:EnsureUIIsReady()
    local DisplayManager = NAG:GetModule("DisplayManager")
    --TODO add new frame support GroupFrame
    if not self.Frame.iconFrames then
        self:Info("Frame not initialized, initializing...")
        DisplayManager:InitializeParentFrame()
    end
end

--- Single pipeline normalizer for secondary spell entries. Canonical shape: { spellId, itemId?, position? }.
--- @param entry any
--- @return table|nil
function NAG:NormalizeSecondarySpellEntry(entry)
    return normalizeSecondarySpellEntry(entry)
end

--- Normalize any action identity for primary/secondary pipelines.
--- Canonical shape: { spellId = number|nil, itemId = number|nil, position = string|nil }.
--- @param entryOrId any
--- @param opts table|nil
--- @return table|nil
function NAG:NormalizeActionIdentity(entryOrId, opts)
    return normalizeActionIdentity(entryOrId, opts)
end

--- Normalize primary action identity (position intentionally omitted).
--- @param entryOrId any
--- @param opts table|nil
--- @return table|nil
function NAG:NormalizePrimaryAction(entryOrId, opts)
    local normalized = normalizeActionIdentity(entryOrId, opts or {})
    if not normalized then
        return nil
    end
    normalized.position = nil
    return normalized
end

--- Normalize secondary action identity and apply optional position override.
--- @param entryOrId any
--- @param position string|nil
--- @param opts table|nil
--- @return table|nil
function NAG:NormalizeSecondaryAction(entryOrId, position, opts)
    local normalized = normalizeActionIdentity(entryOrId, opts or {})
    if not normalized then
        return nil
    end
    if position ~= nil then
        normalized.position = position
    end
    return normalized
end

--- Resolve canonical id used for lookups/casting checks.
--- If both IDs exist (tinker), resolves by spell first.
--- Fast path when identity is already a canonical table (no normalization).
--- @param identity any
--- @return number|nil
function NAG:GetActionResolveId(identity)
    if type(identity) == "table" and (identity.spellId or identity.itemId) then
        return (identity.itemId and identity.spellId) or identity.spellId or identity.itemId
    end
    local norm = normalizeActionIdentity(identity, { context = "action_resolve_id" })
    if not norm then
        return nil
    end
    return (norm.itemId and norm.spellId) or norm.spellId or norm.itemId
end

--- Resolve canonical id used for display identity.
--- For item-backed identities, prefer itemId for icon/cooldown routing.
--- Fast path when identity is already a canonical table (no normalization).
--- @param identity any
--- @return number|nil
function NAG:GetActionDisplayId(identity)
    if type(identity) == "table" and (identity.spellId or identity.itemId) then
        return identity.itemId or identity.spellId
    end
    local norm = normalizeActionIdentity(identity, { context = "action_display_id" })
    if not norm then
        return nil
    end
    return norm.itemId or norm.spellId
end

--- Build display-relevant fields once per cycle (no persistent cache). Share result with GetDisplayGroupIconData and UpdateIcons.
--- @param secondarySpells table
--- @return table Array of { norm, resolveId, displayId, preferItemFirst, position }
function NAG:BuildProjectedSecondaries(secondarySpells)
    return buildProjectedSecondaries(secondarySpells or {})
end
