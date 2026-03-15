--- @module "NAG.TBCHunterAPI"
--- Stateful TBC hunter timing engine for SS/filler prediction.
---
--- This module provides a rolling state-machine timeline where each state
--- represents one predicted Auto Shot cycle and carries SS/filler viability.
---
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ============================ LOCALIZE ============================
local _, ns = ...
local GetTime = _G.GetTime
local UnitClassBase = _G.UnitClassBase
local UnitCastingInfo = _G.UnitCastingInfo
local UnitRangedDamage = _G.UnitRangedDamage

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local Version = ns.Version
local StateMachine = ns.StateMachine
local swingTimerLib = ns.LibClassicSwingTimerAPI

-- ============================ CONSTANTS ============================
local DEFAULT_WINDUP_SECONDS = 0.5
local DEFAULT_STEADY_CAST_SECONDS = 1.2  -- base when no observed cast yet; observed cast overrides
local EARLY_GAP_MIN_SECONDS = 0.1
local FILLER_CLIP_TOLERANCE_DEFAULT_SECONDS = 0.2
local FILLER_MIN_SWING_SECONDS = 1.7
local DEFAULT_HORIZON_SECONDS = 8.0
local MAX_STATE_CYCLES = 32
local STATE_RING_SIZE = 9

local SS_SHORT_GAP_MIN_SECONDS = 0.150
local SS_PREFERRED_PRESS_OFFSET_SECONDS = 0.050
local GCD_SECONDS = 1.5

local MULTI_SHOT_TBC_ID = 27021
local ARCANE_SHOT_TBC_ID = 27019
local STEADY_SHOT_TBC_ID = 34120
local MULTI_SHOT_COOLDOWN_SECONDS = 10.0
local ARCANE_SHOT_COOLDOWN_SECONDS = 6.0
local ACTION_NONE = "none"
local ACTION_SS = "SS"
local ACTION_MS = "MS"
local ACTION_AR = "AR"

local SWING_SNAPSHOT_MAX_AGE_SECONDS = 1.0
local CYCLE_TRACKER_RESET_IDLE_SECONDS = 3.0
local CYCLE_TRACKER_SPEED_CHANGE_THRESHOLD_SECONDS = 0.05
local CYCLE_TRACKER_AUTO_OFFSET_TOLERANCE_CYCLES = 0.20

local STATE_TIMELINE_DEBUG_PRINT_VERSION = "2026.02.18-2"

local defaults = {
    class = {
        enabled = true,
        fillerClipToleranceSeconds = 0.2,
    }
}

--- @class TBCHunterAPI:CoreModule
local TBCHunterAPI = NAG:CreateModule("TBCHunterAPI", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function()
        return UnitClassBase("player") ~= "HUNTER"
    end,
})

ns.TBCHunterAPI = TBCHunterAPI

-- ============================ STATE MACHINE OVERVIEW ============================
--[[
Prediction pipeline overview:
1) ResolveTimingInputs(snap) normalizes now/readiness/swing/cast inputs.
2) EvaluateStateTimeline(...) builds static run inputs (horizon, earlyGapDuration, firstAutoAt).
3) StateMachine.CreateTimelinePredictor(...) runs BuildHunterCycleStep repeatedly.
4) BuildHunterCycleStep(...) computes one state window and delegates the per-state decision.
5) DecideHunterStateAction(...) selects SS/MS/AR (or none) and returns timing/carry-forward mutations.
6) Step context is advanced and fed into the next state to create a chained forecast.

Carry-forward values between states:
- stateStartAt/stateEndAt (autoshot cycle boundaries)
- actionableAt/gcdReadyAt (when actions are legal)
- ssQueuedLastState (queued SS hand-off)
- msReadyAt/arReadyAt (cooldown readiness timestamps)
]]

local lastValidRangedSnapshot = nil
local cycleTracker = {
    initialized = false,
    anchorAutoAt = 0,
    anchorAbsoluteCycle = 1,
    anchorSpeed = 0,
    lastGoodNow = 0,
}

-- ============================ INTERNAL HELPERS ============================
--- @return boolean
local function IsDevModeEnabled()
    return NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() or false
end

--- Resolve base (unhasted) ranged speed when available.
--- Prefers source/swinglib base speed and falls back to current ranged speed.
--- @param source table|nil
--- @param rangedSpeed number
--- @return number
local function ResolveBaseRangedSpeed(source, rangedSpeed)
    local baseRangedSpeed = tonumber(source and source.rangedBaseSpeed or 0) or 0
    if baseRangedSpeed <= 0 and swingTimerLib and swingTimerLib.player and swingTimerLib.player.rangedBaseSpeed then
        baseRangedSpeed = tonumber(swingTimerLib.player.rangedBaseSpeed) or 0
    end
    if baseRangedSpeed <= 0 and UnitRangedDamage then
        baseRangedSpeed = tonumber(UnitRangedDamage("player") or 0) or 0
    end
    if baseRangedSpeed <= 0 then
        baseRangedSpeed = tonumber(rangedSpeed or 0) or 0
    end
    return baseRangedSpeed > 0 and baseRangedSpeed or 0
end

--- Compute hunter auto-shot windup seconds using sim-equivalent haste scaling.
--- Sim equivalent: 0.5 / hasteMultiplier == 0.5 * currentSpeed / baseSpeed.
--- @param rangedSpeed number
--- @param baseRangedSpeed number
--- @param fallbackSeconds number|nil
--- @return number
local function ComputeWindupSeconds(rangedSpeed, baseRangedSpeed, fallbackSeconds)
    local fallback = tonumber(fallbackSeconds or DEFAULT_WINDUP_SECONDS) or DEFAULT_WINDUP_SECONDS
    local speed = tonumber(rangedSpeed or 0) or 0
    if speed <= 0 then
        return fallback
    end

    local base = tonumber(baseRangedSpeed or 0) or 0
    local windup = fallback
    if base > 0 then
        windup = DEFAULT_WINDUP_SECONDS * (speed / base)
    end

    if windup < 0 then
        windup = 0
    end
    if windup > speed then
        windup = speed
    end
    return windup
end

ns.HunterComputeWindupSeconds = ComputeWindupSeconds

--- @return table|nil
local function BuildRangedSwingSnapshot()
    if not swingTimerLib or not swingTimerLib.UnitSwingTimerInfo then
        return nil
    end

    local speed, expiration = swingTimerLib:UnitSwingTimerInfo("player", "ranged")
    if not speed or not expiration or speed <= 0 then
        return nil
    end

    local now = GetTime()
    local timeToNext = expiration - now
    if timeToNext < 0 then
        timeToNext = 0
    end

    local baseRangedSpeed = ResolveBaseRangedSpeed(nil, speed)
    return {
        now = now,
        rangedSpeed = speed,
        rangedBaseSpeed = baseRangedSpeed,
        windupSeconds = ComputeWindupSeconds(speed, baseRangedSpeed, DEFAULT_WINDUP_SECONDS),
        rangedTimeToNext = timeToNext,
        expirationAt = expiration,
    }
end

--- @param value number
--- @return number
local function Round(value)
    if value >= 0 then
        return math.floor(value + 0.5)
    end
    return math.ceil(value - 0.5)
end

local function ResetCycleTracker()
    cycleTracker.initialized = false
    cycleTracker.anchorAutoAt = 0
    cycleTracker.anchorAbsoluteCycle = 1
    cycleTracker.anchorSpeed = 0
    cycleTracker.lastGoodNow = 0
end

--- @param firstAutoAt number
--- @param rangedSpeed number
--- @param now number
--- @return number
local function ResolveAbsoluteCycleBase(firstAutoAt, rangedSpeed, now)
    if not cycleTracker.initialized then
        cycleTracker.initialized = true
        cycleTracker.anchorAutoAt = firstAutoAt
        cycleTracker.anchorAbsoluteCycle = 1
        cycleTracker.anchorSpeed = rangedSpeed
        cycleTracker.lastGoodNow = now
        return 1
    end

    local idleFor = now - (tonumber(cycleTracker.lastGoodNow or 0) or 0)
    local speedDiff = math.abs((tonumber(cycleTracker.anchorSpeed or 0) or 0) - rangedSpeed)
    if idleFor > CYCLE_TRACKER_RESET_IDLE_SECONDS or speedDiff > CYCLE_TRACKER_SPEED_CHANGE_THRESHOLD_SECONDS then
        cycleTracker.anchorAutoAt = firstAutoAt
        cycleTracker.anchorAbsoluteCycle = 1
        cycleTracker.anchorSpeed = rangedSpeed
        cycleTracker.lastGoodNow = now
        return 1
    end

    local cycleOffsetFloat = (firstAutoAt - cycleTracker.anchorAutoAt) / rangedSpeed
    local cycleOffsetRounded = Round(cycleOffsetFloat)
    if math.abs(cycleOffsetFloat - cycleOffsetRounded) > CYCLE_TRACKER_AUTO_OFFSET_TOLERANCE_CYCLES then
        local estimatedAbs = cycleTracker.anchorAbsoluteCycle + cycleOffsetRounded
        if estimatedAbs < 1 then
            estimatedAbs = 1
        end
        cycleTracker.anchorAutoAt = firstAutoAt
        cycleTracker.anchorAbsoluteCycle = estimatedAbs
        cycleTracker.anchorSpeed = rangedSpeed
        cycleTracker.lastGoodNow = now
        return estimatedAbs
    end

    local absoluteBase = cycleTracker.anchorAbsoluteCycle + cycleOffsetRounded
    if absoluteBase < 1 then
        absoluteBase = 1
    end
    cycleTracker.lastGoodNow = now
    cycleTracker.anchorSpeed = rangedSpeed
    return absoluteBase
end

--- Builds the best available snapshot for state timeline calls.
--- @return table|nil
local function BuildBestSnapshot()
    local hunterWeaveModule = NAG and NAG.GetModule and NAG:GetModule("HunterWeaveModule", true) or nil
    if hunterWeaveModule and hunterWeaveModule.GetWeaveSnapshot then
        local snap = hunterWeaveModule:GetWeaveSnapshot()
        if snap and snap.ok then
            return snap
        end
    end
    return nil
end

--- Build an observed "state 0" timing snapshot.
--- Prefers HunterWeaveModule snapshot; falls back to direct NAG/WoW APIs.
--- @param snap table|nil
--- @return table observed
local function BuildObservedState0(snap)
    local source = snap
    if not (source and source.ok) then
        source = BuildBestSnapshot()
    end

    local observed = {
        ok = false,
        now = 0,
        readyInBase = 0,
        readyInEffective = 0,
        queuedEndIn = 0,
        gcdLeft = 0,
        gcdFullSeconds = GCD_SECONDS,
        steadyQueued = false,
        inWarmUp = false,
        rangedTimeToNext = 0,
        rangedSpeed = 0,
        rangedBaseSpeed = 0,
        windupSeconds = DEFAULT_WINDUP_SECONDS,
        steadyCastSeconds = DEFAULT_STEADY_CAST_SECONDS,
        multiCastSeconds = DEFAULT_WINDUP_SECONDS,
        queuedSteadyEndAt = nil,
        queuedSteadyStartAt = nil,
        castingSpellId = 0,
        castRemaining = 0,
        usedFallbackSnapshot = false,
    }

    local now = tonumber(source and source.now or 0) or 0
    if now <= 0 then
        now = GetTime()
    end
    observed.now = now

    local steadyCastSeconds = tonumber(source and source.steadyCast or DEFAULT_STEADY_CAST_SECONDS) or DEFAULT_STEADY_CAST_SECONDS
    if steadyCastSeconds < 0 then
        steadyCastSeconds = 0
    end
    observed.steadyCastSeconds = steadyCastSeconds

    local gcdLeft = tonumber(source and source.gcdLeft or 0) or 0
    if (not source) and NAG and NAG.GCDTimeToReady then
        gcdLeft = tonumber(NAG:GCDTimeToReady() or 0) or 0
    end
    if gcdLeft < 0 then
        gcdLeft = 0
    end
    observed.gcdLeft = gcdLeft
    local gcdFullSeconds = (NAG and NAG.GCDTimeValue and tonumber(NAG:GCDTimeValue() or GCD_SECONDS)) or GCD_SECONDS
    if not gcdFullSeconds or gcdFullSeconds <= 0 then
        gcdFullSeconds = GCD_SECONDS
    end
    observed.gcdFullSeconds = gcdFullSeconds

    local castRemaining = tonumber(source and source.castRemaining or 0) or 0
    local castingSpellId = tonumber(source and source.castingSpellId or 0) or 0
    if (not source) and UnitCastingInfo then
        local _, _, _, _, endTimeMS, _, _, _, spellId = UnitCastingInfo("player")
        castingSpellId = tonumber(spellId or 0) or 0
        if endTimeMS and endTimeMS > 0 then
            castRemaining = (endTimeMS / 1000) - now
            if castRemaining < 0 then
                castRemaining = 0
            end
        end
    end
    if castRemaining < 0 then
        castRemaining = 0
    end
    observed.castRemaining = castRemaining
    observed.castingSpellId = castingSpellId

    local readyInBase = tonumber(source and source.nextActionDelay or 0) or 0
    if readyInBase < 0 then
        readyInBase = 0
    end
    if (not source) and readyInBase <= 0 then
        readyInBase = gcdLeft
        if castRemaining > readyInBase then
            readyInBase = castRemaining
        end
    end
    observed.readyInBase = readyInBase

    local steadyQueued = source and source.steadyQueued == true or false
    if not source then
        if NAG and NAG.HunterSSQueued then
            steadyQueued = NAG:HunterSSQueued() == true
        elseif NAG and NAG.IsQueued then
            steadyQueued = NAG:IsQueued(STEADY_SHOT_TBC_ID) == true
        end
    end
    observed.steadyQueued = steadyQueued

    local rangedTimeToNext = tonumber(source and source.rangedTimeToNext or 0) or 0
    local rangedSpeed = tonumber(source and source.rangedSpeed or 0) or 0
    if rangedSpeed > 0 and rangedTimeToNext > 0 then
        lastValidRangedSnapshot = {
            now = now,
            rangedSpeed = rangedSpeed,
            rangedTimeToNext = rangedTimeToNext,
            expirationAt = now + rangedTimeToNext,
        }
    end

    if rangedSpeed <= 0 or rangedTimeToNext <= 0 then
        local live = BuildRangedSwingSnapshot()
        if live then
            now = tonumber(live.now or now) or now
            rangedTimeToNext = tonumber(live.rangedTimeToNext or 0) or 0
            rangedSpeed = tonumber(live.rangedSpeed or 0) or 0
            lastValidRangedSnapshot = {
                now = now,
                rangedSpeed = rangedSpeed,
                rangedTimeToNext = rangedTimeToNext,
                expirationAt = tonumber(live.expirationAt or (now + rangedTimeToNext)) or (now + rangedTimeToNext),
            }
        elseif lastValidRangedSnapshot then
            local snapshotNow = tonumber(lastValidRangedSnapshot.now or 0) or 0
            local snapshotSpeed = tonumber(lastValidRangedSnapshot.rangedSpeed or 0) or 0
            local snapshotExpiration = tonumber(lastValidRangedSnapshot.expirationAt or 0) or 0
            local snapshotAge = now - snapshotNow
            if snapshotSpeed > 0 and snapshotExpiration > 0 and snapshotAge >= 0 and snapshotAge <= SWING_SNAPSHOT_MAX_AGE_SECONDS then
                rangedSpeed = snapshotSpeed
                rangedTimeToNext = snapshotExpiration - now
                if rangedTimeToNext < 0 then
                    rangedTimeToNext = 0
                end
                observed.usedFallbackSnapshot = true
            end
        end
    end

    observed.now = now
    observed.rangedTimeToNext = rangedTimeToNext
    observed.rangedSpeed = rangedSpeed
    local sourceWindupSeconds = tonumber(source and (source.rangedWindupSeconds or source.windupSeconds) or 0) or 0
    local baseRangedSpeed = ResolveBaseRangedSpeed(source, rangedSpeed)
    observed.rangedBaseSpeed = baseRangedSpeed
    observed.windupSeconds = ComputeWindupSeconds(
        rangedSpeed,
        baseRangedSpeed,
        (sourceWindupSeconds > 0) and sourceWindupSeconds or DEFAULT_WINDUP_SECONDS
    )
    local inWarmUp = rangedTimeToNext > 0 and rangedTimeToNext <= observed.windupSeconds
    if NAG and NAG.HunterInWarmUp then
        inWarmUp = NAG:HunterInWarmUp() == true
    end
    observed.inWarmUp = inWarmUp == true

    -- MS cast time = wind-up duration (0.5 base, haste-scaled). Use snapshot multiCast or windup as fallback.
    local multiCastSeconds = tonumber(source and source.multiCast or 0) or 0
    if multiCastSeconds <= 0 then
        multiCastSeconds = observed.windupSeconds
    end
    observed.multiCastSeconds = multiCastSeconds

    local queuedSteadyEndAt = tonumber(source and source.queuedSteadyEndAt or 0) or 0
    local queuedSteadyStartAt = tonumber(source and source.queuedSteadyStartAt or 0) or 0
    if queuedSteadyEndAt <= 0 and steadyQueued and observed.inWarmUp == true and rangedTimeToNext > 0 then
        queuedSteadyStartAt = now + rangedTimeToNext
        queuedSteadyEndAt = queuedSteadyStartAt + steadyCastSeconds
    end
    if queuedSteadyEndAt > 0 then
        observed.queuedSteadyEndAt = queuedSteadyEndAt
    end
    if queuedSteadyStartAt > 0 then
        observed.queuedSteadyStartAt = queuedSteadyStartAt
    end

    local queuedEndIn = 0
    if steadyQueued and observed.queuedSteadyEndAt and now > 0 then
        queuedEndIn = observed.queuedSteadyEndAt - now
        if queuedEndIn < 0 then
            queuedEndIn = 0
        end
    end
    observed.queuedEndIn = queuedEndIn

    local readyInEffective = readyInBase
    if queuedEndIn > readyInEffective then
        readyInEffective = queuedEndIn
    end
    observed.readyInEffective = readyInEffective
    observed.ok = rangedSpeed > 0 and rangedTimeToNext > 0
    return observed
end

--- @param horizonSeconds number|nil
--- @return number
local function NormalizeHorizon(horizonSeconds)
    local horizon = tonumber(horizonSeconds or DEFAULT_HORIZON_SECONDS) or DEFAULT_HORIZON_SECONDS
    if horizon <= 0 then
        horizon = DEFAULT_HORIZON_SECONDS
    end
    return horizon
end

--- @param cycleIndex number
--- @return number
local function GetStateId(cycleIndex)
    if cycleIndex <= 0 then
        return 1
    end
    return ((cycleIndex - 1) % STATE_RING_SIZE) + 1
end

--- @param spellId number
--- @return number|nil Seconds until ready, or nil if unknown/invalid (do not treat as ready).
local function GetSpellReadyIn(spellId)
    if NAG and NAG.SpellTimeToReady then
        local readyIn = tonumber(NAG:SpellTimeToReady(spellId) or -1)
        if readyIn == nil or readyIn < 0 then
            return nil
        end
        return readyIn
    end
    if NAG and NAG.SpellIsReady then
        if NAG:SpellIsReady(spellId) then
            return 0
        end
    end
    return nil
end

--- @param snap table|nil
--- @param options table|nil
--- @return number now
--- @return number readyInEffective
--- @return number readyInBase
--- @return number queuedEndIn
--- @return boolean steadyQueued
--- @return number rangedTimeToNext
--- @return number rangedSpeed
--- @return number windupSeconds
--- @return number steadyCastSeconds
--- @return number gcdLeft
--- @return boolean usedFallbackSnapshot
--- @return boolean ok
local function ResolveTimingInputs(snap, options)
    local observed = BuildObservedState0(snap)
    local now = tonumber(observed.now or 0) or 0
    local readyInEffective = tonumber(observed.readyInEffective or 0) or 0
    local readyInBase = tonumber(observed.readyInBase or 0) or 0
    local queuedEndIn = tonumber(observed.queuedEndIn or 0) or 0
    local steadyQueued = observed.steadyQueued == true
    local rangedTimeToNext = tonumber(observed.rangedTimeToNext or 0) or 0
    local rangedSpeed = tonumber(observed.rangedSpeed or 0) or 0
    local windupSeconds = tonumber(observed.windupSeconds or DEFAULT_WINDUP_SECONDS) or DEFAULT_WINDUP_SECONDS
    local steadyCastSeconds = tonumber(observed.steadyCastSeconds or DEFAULT_STEADY_CAST_SECONDS) or DEFAULT_STEADY_CAST_SECONDS
    local gcdLeft = tonumber(observed.gcdLeft or 0) or 0

    if windupSeconds < 0 then
        windupSeconds = 0
    end
    if windupSeconds > rangedSpeed and rangedSpeed > 0 then
        windupSeconds = rangedSpeed
    end

    local overrideNow = tonumber(options and options.overrideNow or 0) or 0
    local overrideRangedTimeToNext = tonumber(options and options.overrideRangedTimeToNext or 0) or 0
    local overrideRangedSpeed = tonumber(options and options.overrideRangedSpeed or 0) or 0
    if overrideNow > 0 and overrideRangedTimeToNext > 0 then
        now = overrideNow
        rangedTimeToNext = overrideRangedTimeToNext
        if overrideRangedSpeed > 0 then
            rangedSpeed = overrideRangedSpeed
        elseif rangedSpeed <= 0 then
            rangedSpeed = max(1.0, overrideRangedTimeToNext + windupSeconds)
        end
        readyInBase = 0
        readyInEffective = 0
        queuedEndIn = 0
        steadyQueued = false
        gcdLeft = 0
    end

    if windupSeconds > rangedSpeed and rangedSpeed > 0 then
        windupSeconds = rangedSpeed
    end

    local multiCastSeconds = tonumber(observed.multiCastSeconds or observed.windupSeconds or DEFAULT_WINDUP_SECONDS) or DEFAULT_WINDUP_SECONDS
    if multiCastSeconds <= 0 then
        multiCastSeconds = windupSeconds
    end

    local usingOverrides = overrideNow > 0 and overrideRangedTimeToNext > 0
    local ok = rangedSpeed > 0 and rangedTimeToNext > 0 and (usingOverrides or observed.ok == true)
    return now, readyInEffective, readyInBase, queuedEndIn, steadyQueued, rangedTimeToNext, rangedSpeed, windupSeconds, steadyCastSeconds, multiCastSeconds, gcdLeft, observed.usedFallbackSnapshot == true, ok
end

--- @param result table
--- @param expectedPrintVersion string|nil
local function PrintStateTimelineDebug(result, expectedPrintVersion)
    if not IsDevModeEnabled() then
        return
    end

    local expected = tostring(expectedPrintVersion or STATE_TIMELINE_DEBUG_PRINT_VERSION)
    local versionMatches = expected == STATE_TIMELINE_DEBUG_PRINT_VERSION
    local states = result.states or {}
    local s1 = states[1] or {}
    local s2 = states[2] or {}
    local s3 = states[3] or {}
    local s4 = states[4] or {}
    local now = tonumber(result.now or 0) or 0

    local function SafeIn(at)
        local value = tonumber(at or 0) or 0
        value = value - now
        if value < 0 then
            value = 0
        end
        return value
    end

    print(string.format(
        "[TBCHUNTER_API][STATE_TIMELINE_DEBUG][v=%s][versionMatch=%s][expected=%s] meaning=\"state-machine timeline with persistent absolute cycle indexing and stable state progression\" ok=%s reason=%s now=%.3f horizon=%.3f activeState=%d activeCycle=%d states=%d speed=%.3f windup=%.3f earlyGap=%.3f readyInBase=%.3f queuedEndIn=%.3f readyInEffective=%.3f speedOk=%s fallbackUsed=%s s1_id=%d s1_cycle=%d s1_autoIn=%.3f s1_effStartIn=%.3f s1_effEndIn=%.3f s1_effValid=%s s1_ssFits=%s s1_filler=%s s2_id=%d s2_cycle=%d s2_effStartIn=%.3f s2_effEndIn=%.3f s2_effValid=%s s2_ssFits=%s s2_filler=%s s3_id=%d s3_cycle=%d s3_ssFits=%s s3_filler=%s s4_id=%d s4_cycle=%d s4_ssFits=%s s4_filler=%s nextMS_found=%s nextMS_cycle=%d nextMS_in=%.3f nextAR_found=%s nextAR_cycle=%d nextAR_in=%.3f",
        STATE_TIMELINE_DEBUG_PRINT_VERSION,
        tostring(versionMatches),
        expected,
        tostring(result.ok == true),
        tostring(result.reason or "none"),
        now,
        tonumber(result.horizonSeconds or 0) or 0,
        tonumber(result.activeStateId or 0) or 0,
        tonumber(result.activeCycleIndex or 0) or 0,
        #states,
        tonumber(result.rangedSpeed or 0) or 0,
        tonumber(result.windupSeconds or 0) or 0,
        tonumber(result.earlyGapDuration or 0) or 0,
        tonumber(result.readyInBase or 0) or 0,
        tonumber(result.queuedEndIn or 0) or 0,
        tonumber(result.readyInEffective or 0) or 0,
        tostring(result.speedOk == true),
        tostring(result.usedSnapshotFallback == true),
        tonumber(s1.stateId or 0) or 0,
        tonumber(s1.absoluteCycleIndex or s1.cycleIndex or 0) or 0,
        SafeIn(s1.autoAt),
        SafeIn(s1.effectiveGapStartAt),
        SafeIn(s1.effectiveGapEndAt),
        tostring(s1.effectiveWindowValid == true),
        tostring(s1.ssFits == true),
        tostring(s1.fillerSpell or "none"),
        tonumber(s2.stateId or 0) or 0,
        tonumber(s2.absoluteCycleIndex or s2.cycleIndex or 0) or 0,
        SafeIn(s2.effectiveGapStartAt),
        SafeIn(s2.effectiveGapEndAt),
        tostring(s2.effectiveWindowValid == true),
        tostring(s2.ssFits == true),
        tostring(s2.fillerSpell or "none"),
        tonumber(s3.stateId or 0) or 0,
        tonumber(s3.absoluteCycleIndex or s3.cycleIndex or 0) or 0,
        tostring(s3.ssFits == true),
        tostring(s3.fillerSpell or "none"),
        tonumber(s4.stateId or 0) or 0,
        tonumber(s4.absoluteCycleIndex or s4.cycleIndex or 0) or 0,
        tostring(s4.ssFits == true),
        tostring(s4.fillerSpell or "none"),
        tostring(result.nextMS and result.nextMS.found == true),
        tonumber(result.nextMS and result.nextMS.absoluteCycleIndex or 0) or 0,
        tonumber(result.nextMS and result.nextMS.timeFromNow or 0) or 0,
        tostring(result.nextAR and result.nextAR.found == true),
        tonumber(result.nextAR and result.nextAR.absoluteCycleIndex or 0) or 0,
        tonumber(result.nextAR and result.nextAR.timeFromNow or 0) or 0
    ))

    local maxCascadeStates = 3
    local stateCount = #states
    if stateCount < maxCascadeStates then
        maxCascadeStates = stateCount
    end

    for stateIndex = 1, maxCascadeStates do
        local state = states[stateIndex] or {}
        local stateStartAt = tonumber(state.stateStartAt or 0) or 0
        local stateEndAt = tonumber(state.stateEndAt or 0) or 0
        local gcdBeforeAt = tonumber(state.gcdStartAt or state.actionableAt or 0) or 0
        local gcdAfterAt = tonumber(state.gcdEndAt or 0) or 0
        local nextActionAt = tonumber(state.postFillerActionableAt or state.nextActionableAt or 0) or 0
        local carryMsBeforeAt = tonumber(state.msReadyAtBefore or 0) or 0
        local carryArBeforeAt = tonumber(state.arReadyAtBefore or 0) or 0
        local carryMsAfterAt = tonumber(state.msReadyAtAfter or 0) or 0
        local carryArAfterAt = tonumber(state.arReadyAtAfter or 0) or 0
        local fillerCastAt = tonumber(state.fillerCastAt or 0) or 0
        local ssPressAt = tonumber(state.ssPressAt or 0) or 0
        local ssCastStartAt = tonumber(state.ssCastStartAt or 0) or 0
        local ssCastEndAt = tonumber(state.ssCastEndAt or 0) or 0
        local fillerCastAt2 = tonumber(state.fillerCastAt2 or 0) or 0
        local ssPressAt2 = tonumber(state.ssPressAt2 or 0) or 0
        local ssCastStartAt2 = tonumber(state.ssCastStartAt2 or 0) or 0
        local ssCastEndAt2 = tonumber(state.ssCastEndAt2 or 0) or 0

        print(string.format(
            "[TBCHUNTER_API][STATE_CASCADE][v=%s] idx=%d stateId=%d cycle=%d stateStartAt=%.3f stateStartIn=%.3f stateEndAt=%.3f stateEndIn=%.3f carry_ssQueuedLast=%s carry_msReadyIn=%.3f carry_arReadyIn=%.3f carry_actionableIn=%.3f carry_gcdReadyIn=%.3f chosen=%s reason=%s ssPressIn=%.3f ssCastStartIn=%.3f ssCastEndIn=%.3f filler=%s fillerAtIn=%.3f chosen2=%s reason2=%s ssPress2In=%.3f ssCastStart2In=%.3f ssCastEnd2In=%.3f filler2=%s filler2AtIn=%.3f out_ssQueued=%s out_msReadyIn=%.3f out_arReadyIn=%.3f out_nextActionableIn=%.3f out_gcdReadyIn=%.3f earlyGapExists=%s earlyGapLhs=%.3f earlyGapRhs=%.3f fillerEval=%s fillerLhs=%.3f fillerRhs=%.3f fillerSafe=%s",
            STATE_TIMELINE_DEBUG_PRINT_VERSION,
            stateIndex,
            tonumber(state.stateId or 0) or 0,
            tonumber(state.absoluteCycleIndex or state.cycleIndex or 0) or 0,
            stateStartAt,
            SafeIn(stateStartAt),
            stateEndAt,
            SafeIn(stateEndAt),
            tostring(state.ssQueuedLastState == true),
            SafeIn(carryMsBeforeAt),
            SafeIn(carryArBeforeAt),
            SafeIn(gcdBeforeAt),
            SafeIn(tonumber(state.gcdEndAt or 0) or 0),
            tostring(state.chosenAction or ACTION_NONE),
            tostring(state.stateReason or "none"),
            SafeIn(ssPressAt),
            SafeIn(ssCastStartAt),
            SafeIn(ssCastEndAt),
            tostring(state.fillerSpell or ACTION_NONE),
            SafeIn(fillerCastAt),
            tostring(state.chosenAction2 or ACTION_NONE),
            tostring(state.stateReason2 or "none"),
            SafeIn(ssPressAt2),
            SafeIn(ssCastStartAt2),
            SafeIn(ssCastEndAt2),
            tostring(state.fillerSpell2 or ACTION_NONE),
            SafeIn(fillerCastAt2),
            tostring(state.ssQueuedThisState == true),
            SafeIn(carryMsAfterAt),
            SafeIn(carryArAfterAt),
            SafeIn(nextActionAt),
            SafeIn(gcdAfterAt),
            tostring(state.earlyGapExists == true),
            tonumber(state.earlyGapLhs or 0) or 0,
            tonumber(state.earlyGapRhs or 0) or 0,
            tostring(state.fillerSafetyEvaluated == true),
            tonumber(state.fillerLhs or 0) or 0,
            tonumber(state.fillerRhs or 0) or 0,
            tostring(state.fillerSafe == true)
        ))
    end
end

--- Decides the action to perform in one hunter state.
--- @param context table
--- @param stepInput table
--- @param stateWindow table
--- @return table decision
local function DecideHunterStateAction(context, stepInput, stateWindow)
    local function ApplyExpectedClip(decisionTable, windupStartAtSeconds)
        local castBoundaryAt = nil
        if decisionTable.chosenAction == ACTION_SS then
            castBoundaryAt = tonumber(decisionTable.ssCastEndAt or 0) or 0
        elseif decisionTable.chosenAction == ACTION_MS then
            castBoundaryAt = tonumber(decisionTable.fillerCastEndAt or 0) or 0
        elseif decisionTable.chosenAction == ACTION_AR then
            castBoundaryAt = tonumber(decisionTable.fillerCastAt or 0) or 0
        end
        if not castBoundaryAt then
            decisionTable.expectedClipSeconds = 0
            decisionTable.clipped = false
            return
        end

        local expectedClip = castBoundaryAt - (tonumber(windupStartAtSeconds or 0) or 0)
        if expectedClip < 0 then
            expectedClip = 0
        end
        decisionTable.expectedClipSeconds = expectedClip
        decisionTable.clipped = expectedClip > 0
    end

    local decision = {
        chosenAction = ACTION_NONE,
        stateReason = "no_action_selected",
        ssPressAt = 0,
        ssCastStartAt = 0,
        ssCastEndAt = 0,
        gcdStartAt = 0,
        gcdEndAt = tonumber(context.gcdReadyAt or 0) or 0,
        nextActionableAt = tonumber(context.actionableAt or 0) or 0,
        fillerSpellId = 0,
        fillerSpell = ACTION_NONE,
        fillerCastAt = 0,
        fillerCastEndAt = 0,
        fillerGcdEndAt = 0,
        fillerSafetyLhs = 0,
        fillerSafetyRhs = 0,
        fillerSafetyEvaluated = false,
        fillerSafetyPassed = false,
        fillerReason = "filler: not evaluated",
        msReadyAtAfter = tonumber(context.msReadyAt or 0) or 0,
        arReadyAtAfter = tonumber(context.arReadyAt or 0) or 0,
        ssQueuedThisState = false,
        stateEndAtAdjusted = stateWindow.stateEndAt,
        clipped = false,
        expectedClipSeconds = 0,
    }

    local actionableAt = tonumber(context.actionableAt or 0) or 0
    local gcdReadyAt = tonumber(context.gcdReadyAt or 0) or 0
    if gcdReadyAt > actionableAt then
        actionableAt = gcdReadyAt
    end

    local stateStartAt = stateWindow.stateStartAt
    local stateEndAt = stateWindow.stateEndAt
    local windupStartAt = stateWindow.windupStartAt
    local steadyCastSeconds = stepInput.steadyCastSeconds
    local multiCastSeconds = tonumber(stepInput.multiCastSeconds or 0) or 0
    if multiCastSeconds <= 0 then
        multiCastSeconds = DEFAULT_WINDUP_SECONDS
    end
    local rangedSpeed = stepInput.rangedSpeed
    local earlyGapDuration = stepInput.earlyGapDuration
    local speedOk = stepInput.speedOk == true
    local fillerBoundary = math.max(GCD_SECONDS, steadyCastSeconds)

    -- Execute queued SS from previous state. Cast starts at state start; GCD started when they queued (last state).
    if context.ssQueuedLastState == true then
        decision.chosenAction = ACTION_SS
        decision.stateReason = "queued_ss_execute_at_state_start"
        decision.ssPressAt = stateStartAt
        decision.ssCastStartAt = stateStartAt
        decision.ssCastEndAt = stateStartAt + steadyCastSeconds
        -- GCD started when queue happened (previous state), not when cast starts.
        local gcdEndFromQueue = tonumber(context.gcdReadyAt or 0) or 0
        if gcdEndFromQueue > stateStartAt then
            decision.gcdStartAt = gcdEndFromQueue - GCD_SECONDS
            decision.gcdEndAt = gcdEndFromQueue
        else
            decision.gcdStartAt = stateStartAt
            decision.gcdEndAt = stateStartAt + GCD_SECONDS
        end
        decision.nextActionableAt = decision.ssCastEndAt
        if decision.gcdEndAt > decision.nextActionableAt then
            decision.nextActionableAt = decision.gcdEndAt
        end
        decision.fillerReason = "filler: not evaluated (queued SS execute)"
        ApplyExpectedClip(decision, windupStartAt)
        return decision
    end

    if actionableAt >= stateEndAt then
        decision.stateReason = "actionable_after_state_end"
        decision.gcdStartAt = actionableAt
        decision.nextActionableAt = actionableAt
        decision.gcdEndAt = actionableAt
        decision.fillerReason = "filler: not evaluated (actionable at or after state end)"
        ApplyExpectedClip(decision, windupStartAt)
        return decision
    end

    -- Unprepared-state rule: when we enter state0 before windup with GCD ready (gcdLeft <= 0.05) and
    -- nothing queued, we cannot reliably fit SS in the early gap (latency/reaction) and fillers are
    -- not appropriate. Only action: wait for windup. Applies when: autoshot (natural timing) or
    -- ms_zero_backup (we missed a filler gap; windup ~500ms ahead is next action).
    -- spell_sent_ms/ar: we just cast, show SS in gap or fillers.
    local triggerSource = tostring(stepInput.triggerSource or "unknown")
    local gcdLeftVal = stepInput.gcdLeft ~= nil and tonumber(stepInput.gcdLeft)
    local waitForWindupTrigger = (triggerSource == "autoshot" or triggerSource == "ms_zero_backup")
    local isState0Unprepared = waitForWindupTrigger and (type(gcdLeftVal) == "number" and gcdLeftVal <= 0.05) and context.ssQueuedLastState ~= true
    if actionableAt < windupStartAt and isState0Unprepared then
        decision.chosenAction = ACTION_SS
        decision.stateReason = "ss_wait_for_windup_unprepared"
        decision.ssQueuedThisState = true
        decision.ssPressAt = windupStartAt
        decision.ssCastStartAt = stateEndAt
        decision.ssCastEndAt = decision.ssCastStartAt + steadyCastSeconds
        decision.gcdStartAt = decision.ssPressAt
        decision.gcdEndAt = decision.ssPressAt + GCD_SECONDS
        decision.nextActionableAt = decision.ssCastEndAt
        if decision.gcdEndAt > decision.nextActionableAt then
            decision.nextActionableAt = decision.gcdEndAt
        end
        decision.fillerReason = "filler: not evaluated (unprepared state, wait for windup)"
        ApplyExpectedClip(decision, windupStartAt)
        return decision
    end

    -- Clip = SS cast finishes during wind-up [windupStartAt, stateEndAt]. Cast must finish BEFORE wind-up starts.
    if (actionableAt + steadyCastSeconds) <= windupStartAt then
        decision.chosenAction = ACTION_SS
        decision.stateReason = "ss_cast_without_clip"
        decision.ssPressAt = actionableAt
        decision.ssCastStartAt = actionableAt
        decision.ssCastEndAt = decision.ssCastStartAt + steadyCastSeconds
        decision.gcdStartAt = decision.ssPressAt
        decision.gcdEndAt = decision.ssPressAt + GCD_SECONDS
        decision.nextActionableAt = decision.ssCastEndAt
        if decision.gcdEndAt > decision.nextActionableAt then
            decision.nextActionableAt = decision.gcdEndAt
        end
        decision.fillerReason = "filler: not evaluated (full SS in state)"
        ApplyExpectedClip(decision, windupStartAt)
        return decision
    end

    if actionableAt < windupStartAt and speedOk and earlyGapDuration > EARLY_GAP_MIN_SECONDS then
        -- Action free time must be relative to state start so LHS and RHS are in same units (seconds).
        -- RHS: must finish before next Auto's wind-up start. Clipping boundary = wind-up start.
        -- MS has cast time = wind-up duration; must finish before Auto wind-up starts.
        local fillerClipTolerance = stepInput.fillerClipToleranceSeconds
        if type(fillerClipTolerance) ~= "number" or fillerClipTolerance < 0 or fillerClipTolerance > 0.5 then
            fillerClipTolerance = FILLER_CLIP_TOLERANCE_DEFAULT_SECONDS
        end
        local stateEnd = tonumber(stateWindow.stateEndAt or 0) or 0
        local windupStart = tonumber(stateWindow.windupStartAt or 0) or 0
        local windupSeconds = (stateEnd > windupStart) and (stateEnd - windupStart) or DEFAULT_WINDUP_SECONDS
        local actionFreeRelative = actionableAt - stateStartAt

        -- MS: LHS = actionFreeRelative + max(multiCast, GCD) + steadyCast (MS has cast time).
        -- AR: LHS = actionFreeRelative + GCD + steadyCast (instant).
        local msFillerLhs = actionFreeRelative + math.max(multiCastSeconds, GCD_SECONDS) + steadyCastSeconds
        local arFillerLhs = actionFreeRelative + GCD_SECONDS + steadyCastSeconds
        local fillerSafetyRhs = (2 * rangedSpeed) - windupSeconds + fillerClipTolerance

        decision.fillerSafetyRhs = fillerSafetyRhs
        decision.fillerSafetyEvaluated = true

        local msFits = msFillerLhs < fillerSafetyRhs
        local arFits = arFillerLhs < fillerSafetyRhs
        if msFits then
            decision.fillerSafetyLhs = msFillerLhs
        else
            decision.fillerSafetyLhs = arFillerLhs
        end

        if msFits or arFits then
            decision.fillerSafetyPassed = true
            local msReadyAt = tonumber(context.msReadyAt or 0) or 0
            local arReadyAt = tonumber(context.arReadyAt or 0) or 0
            local canMs = actionableAt >= msReadyAt
            local canAr = actionableAt >= arReadyAt
            -- MS must finish before wind-up: actionableAt + multiCastSeconds <= windupStartAt
            local msFitsInGap = (actionableAt + multiCastSeconds) <= (windupStartAt + fillerClipTolerance)

            if canMs and msFitsInGap and msFits then
                decision.chosenAction = ACTION_MS
                decision.stateReason = "filler_ms_safe"
                decision.fillerSpellId = MULTI_SHOT_TBC_ID
                decision.fillerSpell = ACTION_MS
                decision.msReadyAtAfter = actionableAt + MULTI_SHOT_COOLDOWN_SECONDS
            elseif canAr and arFits then
                decision.chosenAction = ACTION_AR
                decision.stateReason = "filler_ar_safe"
                decision.fillerSpellId = ARCANE_SHOT_TBC_ID
                decision.fillerSpell = ACTION_AR
                decision.arReadyAtAfter = actionableAt + ARCANE_SHOT_COOLDOWN_SECONDS
            end

            if decision.fillerSpellId > 0 then
                decision.fillerCastAt = actionableAt
                if decision.fillerSpell == ACTION_MS then
                    decision.fillerCastEndAt = actionableAt + multiCastSeconds
                    decision.gcdStartAt = actionableAt
                    decision.fillerGcdEndAt = actionableAt + GCD_SECONDS
                    decision.gcdEndAt = decision.fillerGcdEndAt
                    decision.nextActionableAt = math.max(decision.fillerCastEndAt, decision.fillerGcdEndAt)
                else
                    decision.fillerCastEndAt = actionableAt
                    decision.gcdStartAt = actionableAt
                    decision.fillerGcdEndAt = actionableAt + GCD_SECONDS
                    decision.gcdEndAt = decision.fillerGcdEndAt
                    decision.nextActionableAt = decision.fillerGcdEndAt
                end
                decision.fillerReason = "filler: taken (" .. tostring(decision.fillerSpell or ACTION_NONE) .. ")"
                ApplyExpectedClip(decision, windupStartAt)
                return decision
            end
            if canMs and not msFitsInGap then
                decision.fillerReason = "filler: not taken (MS cast would clip wind-up)"
            elseif canMs and not msFits then
                decision.fillerReason = "filler: not taken (MS safety LHS >= RHS)"
            elseif canAr and not arFits then
                decision.fillerReason = "filler: not taken (AR safety LHS >= RHS)"
            else
                decision.fillerReason = "filler: not taken (MS/AR on cooldown)"
            end
        else
            decision.fillerReason = string.format(
                "filler: not taken (unsafe: lhs %.3f >= rhs %.3f)",
                decision.fillerSafetyLhs or 0,
                fillerSafetyRhs or 0
            )
        end
    end

    if actionableAt >= windupStartAt and actionableAt <= stateEndAt then
        decision.chosenAction = ACTION_SS
        decision.stateReason = "ss_press_inside_windup"
        decision.ssQueuedThisState = true
        decision.ssPressAt = actionableAt
        decision.ssCastStartAt = stateEndAt
        decision.ssCastEndAt = decision.ssCastStartAt + steadyCastSeconds
        decision.gcdStartAt = decision.ssPressAt
        decision.gcdEndAt = decision.ssPressAt + GCD_SECONDS
        decision.nextActionableAt = decision.ssCastEndAt
        if decision.gcdEndAt > decision.nextActionableAt then
            decision.nextActionableAt = decision.gcdEndAt
        end
        if not decision.fillerSafetyEvaluated then
            decision.fillerReason = "filler: not evaluated (actionable in or past windup)"
        end
        ApplyExpectedClip(decision, windupStartAt)
        return decision
    end

    if not slot1WasSS and actionableAt < windupStartAt then
        decision.chosenAction = ACTION_SS
        decision.stateReason = "ss_wait_for_windup_queue"
        decision.ssQueuedThisState = true
        decision.ssPressAt = windupStartAt
        decision.ssCastStartAt = stateEndAt
        decision.ssCastEndAt = decision.ssCastStartAt + steadyCastSeconds
        decision.gcdStartAt = decision.ssPressAt
        decision.gcdEndAt = decision.ssPressAt + GCD_SECONDS
        decision.nextActionableAt = decision.ssCastEndAt
        if decision.gcdEndAt > decision.nextActionableAt then
            decision.nextActionableAt = decision.gcdEndAt
        end
        if not decision.fillerSafetyEvaluated then
            if not speedOk or earlyGapDuration <= EARLY_GAP_MIN_SECONDS then
                decision.fillerReason = "filler: not evaluated (no early gap or speed too low)"
            else
                decision.fillerReason = "filler: not evaluated (waiting for windup queue)"
            end
        end
        ApplyExpectedClip(decision, windupStartAt)
        return decision
    end

    decision.stateReason = "no_valid_action_path"
    decision.gcdStartAt = actionableAt
    decision.gcdEndAt = actionableAt
    decision.nextActionableAt = actionableAt
    if not decision.fillerSafetyEvaluated then
        decision.fillerReason = "filler: not evaluated (no valid path)"
    end
    ApplyExpectedClip(decision, windupStartAt)
    return decision
end

--- Applies one decision to timeline result/context and computes post-action carry values.
--- @param decision table
--- @param context table
--- @param result table
--- @param stateMeta table
--- @return table applyResult
local function ApplyHunterDecision(decision, context, result, stateMeta)
    local postActionableAt = tonumber(decision.nextActionableAt or 0) or 0
    local fillerSlotStartAt = postActionableAt
    local nextAutoBoundaryAt = (tonumber(stateMeta.autoAt or 0) or 0) + (tonumber(stateMeta.rangedSpeed or 0) or 0)
    local fillerSlotEndAt = nextAutoBoundaryAt - (tonumber(stateMeta.windupSeconds or 0) or 0)
    local fillerSlotDuration = fillerSlotEndAt - fillerSlotStartAt
    if fillerSlotDuration < 0 then
        fillerSlotDuration = 0
    end

    context.msReadyAt = tonumber(decision.msReadyAtAfter or context.msReadyAt or 0) or 0
    context.arReadyAt = tonumber(decision.arReadyAtAfter or context.arReadyAt or 0) or 0

    local fillerSpellId = tonumber(decision.fillerSpellId or 0) or 0
    local fillerSpell = tostring(decision.fillerSpell or ACTION_NONE)
    local fillerCastAt = tonumber(decision.fillerCastAt or 0) or 0
    local fillerCastEndAt = tonumber(decision.fillerCastEndAt or 0) or 0
    local fillerGcdEndAt = tonumber(decision.fillerGcdEndAt or 0) or 0
    if fillerSpellId > 0 then
        if fillerGcdEndAt > postActionableAt then
            postActionableAt = fillerGcdEndAt
        end
        if fillerCastEndAt > postActionableAt then
            postActionableAt = fillerCastEndAt
        end

        local fillerEvent = {
            stateId = tonumber(stateMeta.stateId or 0) or 0,
            cycleIndex = tonumber(stateMeta.cycleIndex or 0) or 0,
            absoluteCycleIndex = tonumber(stateMeta.absoluteCycleIndex or 0) or 0,
            spellId = fillerSpellId,
            spell = fillerSpell,
            at = fillerCastAt,
            timeFromNow = fillerCastAt - (tonumber(stateMeta.now or 0) or 0),
            slotStartAt = fillerSlotStartAt,
            slotEndAt = fillerSlotEndAt,
            expectedClipSeconds = tonumber(decision.expectedClipSeconds or 0) or 0,
        }
        if fillerEvent.timeFromNow < 0 then
            fillerEvent.timeFromNow = 0
        end
        result.fillerEvents[#result.fillerEvents + 1] = fillerEvent

        if fillerSpellId == MULTI_SHOT_TBC_ID and not result.nextMS.found then
            result.nextMS.found = true
            result.nextMS.at = fillerCastAt
            result.nextMS.timeFromNow = fillerEvent.timeFromNow
            result.nextMS.stateId = fillerEvent.stateId
            result.nextMS.cycleIndex = fillerEvent.cycleIndex
            result.nextMS.absoluteCycleIndex = fillerEvent.absoluteCycleIndex
            result.nextMS.reason = "state_timeline"
        elseif fillerSpellId == ARCANE_SHOT_TBC_ID and not result.nextAR.found then
            result.nextAR.found = true
            result.nextAR.at = fillerCastAt
            result.nextAR.timeFromNow = fillerEvent.timeFromNow
            result.nextAR.stateId = fillerEvent.stateId
            result.nextAR.cycleIndex = fillerEvent.cycleIndex
            result.nextAR.absoluteCycleIndex = fillerEvent.absoluteCycleIndex
            result.nextAR.reason = "state_timeline"
        end
    end

    return {
        postActionableAt = postActionableAt,
        fillerSlotStartAt = fillerSlotStartAt,
        fillerSlotEndAt = fillerSlotEndAt,
        fillerSlotDuration = fillerSlotDuration,
    }
end

--- Builds one hunter cycle state and advances timeline context.
--- @param context table
--- @param stepInput table
--- @param result table
--- @return table stepResult
local function BuildHunterCycleStep(context, stepInput, result)
    local now = stepInput.now
    local horizonAt = stepInput.horizonAt
    local rangedSpeed = stepInput.rangedSpeed
    local windupSeconds = stepInput.windupSeconds
    local steadyCastSeconds = stepInput.steadyCastSeconds
    local multiCastSeconds = tonumber(stepInput.multiCastSeconds or stepInput.windupSeconds or 0) or 0
    if multiCastSeconds <= 0 then
        multiCastSeconds = windupSeconds
    end
    local earlyGapDuration = stepInput.earlyGapDuration
    local absoluteCycleBase = stepInput.absoluteCycleBase

    if context.cycleIndex >= MAX_STATE_CYCLES then
        return { done = true, context = context }
    end

    local stateStartAt = tonumber(context.stateStartAt or 0) or 0
    local stateEndAt = tonumber(context.stateEndAt or 0) or 0
    if stateStartAt <= 0 or stateEndAt <= stateStartAt then
        local fallbackEndAt = tonumber(context.autoAt or 0) or 0
        if fallbackEndAt <= 0 then
            fallbackEndAt = now + rangedSpeed
        end
        stateEndAt = fallbackEndAt
        stateStartAt = stateEndAt - rangedSpeed
        if stateStartAt < now - rangedSpeed then
            stateStartAt = now
            stateEndAt = stateStartAt + rangedSpeed
        end
    end

    local autoAt = stateEndAt
    local gapStartAt = stateEndAt - windupSeconds
    local gapTolerance = stepInput.fillerClipToleranceSeconds
    if type(gapTolerance) ~= "number" or gapTolerance < 0 or gapTolerance > 0.5 then
        gapTolerance = FILLER_CLIP_TOLERANCE_DEFAULT_SECONDS
    end
    -- Early gap end = when filler window ends (for step loop advance). SS safe window ends at gapStartAt (wind-up start).
    -- earlyGapDuration already includes fillerClipTolerance.
    local gapEndAt = stateStartAt + earlyGapDuration
    if gapStartAt > horizonAt then
        return { done = true, context = context }
    end

    if gapEndAt < now then
        local nextStateStartAt = stateEndAt
        local nextStateEndAt = nextStateStartAt + rangedSpeed
        context.stateStartAt = nextStateStartAt
        context.stateEndAt = nextStateEndAt
        context.autoAt = nextStateEndAt
        return { context = context }
    end

    context.cycleIndex = context.cycleIndex + 1
    local cycleIndex = context.cycleIndex
    local absoluteCycleIndex = absoluteCycleBase + cycleIndex - 1
    if absoluteCycleIndex < 1 then
        absoluteCycleIndex = 1
    end

    local stateId = GetStateId(absoluteCycleIndex)
    local earlyGapLhs = rangedSpeed - windupSeconds - steadyCastSeconds + (gapTolerance or 0)
    local earlyGapRhs = EARLY_GAP_MIN_SECONDS
    local earlyGapExists = earlyGapLhs > earlyGapRhs
    -- SS safe window = [stateStartAt, gapStartAt]; raw duration = time before wind-up starts
    local rawGapDuration = gapStartAt - stateStartAt
    if rawGapDuration < 0 then
        rawGapDuration = 0
    end

    local actionableAt = context.actionableAt
    local effectiveGapStartAt = stateStartAt
    if actionableAt > effectiveGapStartAt then
        effectiveGapStartAt = actionableAt
    end
    local effectiveGapEndAt = gapStartAt
    local effectiveGapDuration = effectiveGapEndAt - effectiveGapStartAt
    if effectiveGapDuration < 0 then
        effectiveGapDuration = 0
    end

    local shortGapAllowed = (actionableAt >= stateStartAt) and ((gapStartAt - actionableAt) >= SS_PREFERRED_PRESS_OFFSET_SECONDS)
    local isPreferredGap = rawGapDuration > SS_SHORT_GAP_MIN_SECONDS
    local ssFits = effectiveGapDuration > 0 and (isPreferredGap or shortGapAllowed)

    local msReadyAtBefore = context.msReadyAt
    local arReadyAtBefore = context.arReadyAt
    local ssQueuedLastStateIn = context.ssQueuedLastState == true
    -- Pending GCD at state start (GCD can span more than one state; carry time left to ready).
    local gcdReadyAtCarry = tonumber(context.gcdReadyAt or 0) or 0
    local gcdRemainingSecondsAtStateStart = (gcdReadyAtCarry > stateStartAt) and (gcdReadyAtCarry - stateStartAt) or 0
    local stateWindow = {
        stateStartAt = stateStartAt,
        stateEndAt = stateEndAt,
        windupStartAt = gapStartAt,
    }
    local stateMeta = {
        now = now,
        stateId = stateId,
        cycleIndex = cycleIndex,
        absoluteCycleIndex = absoluteCycleIndex,
        autoAt = autoAt,
        rangedSpeed = rangedSpeed,
        windupSeconds = windupSeconds,
    }
    local fillerClipTolerance = stepInput.fillerClipToleranceSeconds or FILLER_CLIP_TOLERANCE_DEFAULT_SECONDS
    local decision = DecideHunterStateAction(context, {
        now = stepInput.now,
        gcdLeft = stepInput.gcdLeft,
        triggerSource = stepInput.triggerSource,
        steadyCastSeconds = steadyCastSeconds,
        multiCastSeconds = multiCastSeconds,
        rangedSpeed = rangedSpeed,
        earlyGapDuration = earlyGapDuration,
        speedOk = result.speedOk,
        fillerClipToleranceSeconds = fillerClipTolerance,
    }, stateWindow)

    local ssPressAt = decision.ssPressAt
    local ssCastStartAt = decision.ssCastStartAt
    local ssCastEndAt = decision.ssCastEndAt
    local gcdEndAt = decision.gcdEndAt
    local nextActionableAt = decision.nextActionableAt
    local stateReason = decision.stateReason

    local fillerSpellId = decision.fillerSpellId
    local fillerSpell = decision.fillerSpell
    local fillerCastAt = decision.fillerCastAt
    local fillerCastEndAt = decision.fillerCastEndAt
    local fillerGcdEndAt = decision.fillerGcdEndAt
    local applyFirst = ApplyHunterDecision(decision, context, result, stateMeta)
    local fillerSlotStartAt = applyFirst.fillerSlotStartAt
    local fillerSlotEndAt = applyFirst.fillerSlotEndAt
    local fillerSlotDuration = applyFirst.fillerSlotDuration
    local postFillerActionableAt = applyFirst.postActionableAt
    -- CD state after slot 1 only (for value-based slot 2 math that must not see slot 2's CD).
    local msReadyAtAfterSlot1 = context.msReadyAt
    local arReadyAtAfterSlot1 = context.arReadyAt

    local secondDecision = nil
    if decision.chosenAction ~= ACTION_NONE and postFillerActionableAt < stateEndAt then
        local contextSecond = {
            actionableAt = postFillerActionableAt,
            gcdReadyAt = gcdEndAt,
            ssQueuedLastState = false,
            msReadyAt = context.msReadyAt,
            arReadyAt = context.arReadyAt,
        }
        local candidateDecision = DecideHunterStateAction(contextSecond, {
            triggerSource = stepInput.triggerSource,
            steadyCastSeconds = steadyCastSeconds,
            multiCastSeconds = multiCastSeconds,
            rangedSpeed = rangedSpeed,
            earlyGapDuration = earlyGapDuration,
            speedOk = result.speedOk,
            fillerClipToleranceSeconds = fillerClipTolerance,
        }, stateWindow)

        if candidateDecision.chosenAction ~= ACTION_NONE then
            secondDecision = candidateDecision
            local applySecond = ApplyHunterDecision(secondDecision, context, result, stateMeta)
            postFillerActionableAt = applySecond.postActionableAt
            gcdEndAt = secondDecision.gcdEndAt
        end
    end

    local finalDecision = secondDecision or decision
    local secondChosenAction = secondDecision and secondDecision.chosenAction or nil
    local secondGcdStartAt = secondDecision and secondDecision.gcdStartAt or 0

    local state = {
        stateId = stateId,
        cycleIndex = cycleIndex,
        absoluteCycleIndex = absoluteCycleIndex,
        stateStartAt = stateStartAt,
        stateEndAt = stateEndAt,
        stateEndAtAdjusted = stateEndAt,
        gcdPendingEndAtStateStart = (gcdReadyAtCarry > stateStartAt) and gcdReadyAtCarry or nil,
        gcdRemainingSecondsAtStateStart = gcdRemainingSecondsAtStateStart,
        autoAt = autoAt,
        gapStartAt = gapStartAt,
        gapEndAt = gapEndAt,
        gapDuration = rawGapDuration,
        earlyGapExists = earlyGapExists,
        earlyGapLhs = earlyGapLhs,
        earlyGapRhs = earlyGapRhs,
        ssQueuedLastState = ssQueuedLastStateIn,
        ssQueuedThisState = finalDecision.ssQueuedThisState == true,
        chosenAction = decision.chosenAction,
        chosenAction2 = secondChosenAction,
        actionableAt = actionableAt,
        effectiveGapStartAt = effectiveGapStartAt,
        effectiveGapEndAt = effectiveGapEndAt,
        effectiveGapDuration = effectiveGapDuration,
        effectiveWindowValid = effectiveGapDuration > 0,
        ssFits = ssFits,
        ssPressAt = ssPressAt,
        ssCastStartAt = ssCastStartAt,
        ssCastEndAt = ssCastEndAt,
        gcdStartAt1 = decision.gcdStartAt,
        gcdEndAt1 = decision.gcdEndAt,
        gcdStartAt = finalDecision.gcdStartAt,
        gcdEndAt = gcdEndAt,
        nextActionableAt = nextActionableAt,
        fillerSlotStartAt = fillerSlotStartAt,
        fillerSlotEndAt = fillerSlotEndAt,
        fillerSlotDuration = fillerSlotDuration,
        fillerSpellId = fillerSpellId,
        fillerSpell = fillerSpell,
        fillerCastAt = fillerCastAt,
        fillerCastEndAt = fillerCastEndAt,
        fillerGcdEndAt = fillerGcdEndAt,
        fillerLhs = finalDecision.fillerSafetyLhs,
        fillerRhs = finalDecision.fillerSafetyRhs,
        fillerSafe = finalDecision.fillerSafetyPassed == true,
        fillerSafetyEvaluated = finalDecision.fillerSafetyEvaluated == true,
        fillerReason = tostring(finalDecision.fillerReason or "filler: unknown"),
        expectedClipSeconds = tonumber(finalDecision.expectedClipSeconds or 0) or 0,
        expectedClipSeconds1 = tonumber(decision.expectedClipSeconds or 0) or 0,
        expectedClipSeconds2 = secondDecision and (tonumber(secondDecision.expectedClipSeconds or 0) or 0) or 0,
        clipped = finalDecision.clipped == true,
        postFillerActionableAt = postFillerActionableAt,
        msReadyAtBefore = msReadyAtBefore,
        arReadyAtBefore = arReadyAtBefore,
        msReadyAtAfter = context.msReadyAt,
        arReadyAtAfter = context.arReadyAt,
        msReadyAtAfterSlot1 = msReadyAtAfterSlot1,
        arReadyAtAfterSlot1 = arReadyAtAfterSlot1,
        stateReason = stateReason,
        stateReason2 = secondDecision and secondDecision.stateReason or nil,
        ssPressAt2 = secondDecision and secondDecision.ssPressAt or 0,
        ssCastStartAt2 = secondDecision and secondDecision.ssCastStartAt or 0,
        ssCastEndAt2 = secondDecision and secondDecision.ssCastEndAt or 0,
        fillerSpellId2 = secondDecision and secondDecision.fillerSpellId or 0,
        fillerSpell2 = secondDecision and secondDecision.fillerSpell or ACTION_NONE,
        fillerCastAt2 = secondDecision and secondDecision.fillerCastAt or 0,
        fillerCastEndAt2 = secondDecision and secondDecision.fillerCastEndAt or 0,
        fillerGcdEndAt2 = secondDecision and secondDecision.fillerGcdEndAt or 0,
        gcdStartAt2 = secondGcdStartAt,
        gcdEndAt2 = secondDecision and secondDecision.gcdEndAt or 0,
        nextActionableAt2 = secondDecision and secondDecision.nextActionableAt or 0,
    }
    state.timeToGapStart = gapStartAt - now
    state.timeToGapEnd = gapEndAt - now
    state.timeToEffectiveGapStart = effectiveGapStartAt - now
    state.timeToEffectiveGapEnd = effectiveGapEndAt - now
    if state.timeToGapStart < 0 then
        state.timeToGapStart = 0
    end
    if state.timeToGapEnd < 0 then
        state.timeToGapEnd = 0
    end
    if state.timeToEffectiveGapStart < 0 then
        state.timeToEffectiveGapStart = 0
    end
    if state.timeToEffectiveGapEnd < 0 then
        state.timeToEffectiveGapEnd = 0
    end
    if not state.effectiveWindowValid then
        state.timeToEffectiveGapStart = 0
        state.timeToEffectiveGapEnd = 0
    end

    context.actionableAt = postFillerActionableAt
    context.gcdReadyAt = gcdEndAt
    context.ssQueuedLastState = finalDecision.ssQueuedThisState == true
    local nextStateStartAt = stateEndAt
    context.stateStartAt = nextStateStartAt
    context.stateEndAt = nextStateStartAt + rangedSpeed
    context.autoAt = context.stateEndAt

    return {
        context = context,
        state = state,
    }
end

--- @param snap table|nil
--- @param horizonSeconds number|nil
--- @param options table|nil
--- @return table result
local function EvaluateStateTimeline(snap, horizonSeconds, options)
    local result = {
        ok = false,
        reason = "not_ready",
        classOk = UnitClassBase("player") == "HUNTER",
        versionOk = Version:IsTBC(),
        moduleEnabled = false,
        inputsOk = false,
        now = 0,
        horizonSeconds = NormalizeHorizon(horizonSeconds),
        readyInBase = 0,
        queuedEndIn = 0,
        readyInEffective = 0,
        gcdLeft = 0,
        gcdReadyAtInitial = 0,
        steadyQueued = false,
        rangedTimeToNext = 0,
        rangedSpeed = 0,
        usedSnapshotFallback = false,
        windupSeconds = DEFAULT_WINDUP_SECONDS,
        steadyCastSeconds = DEFAULT_STEADY_CAST_SECONDS,
        earlyGapDuration = 0,
        speedOk = false,
        activeStateId = 0,
        activeCycleIndex = 0,
        msReadyAtInitial = 0,
        arReadyAtInitial = 0,
        msReadyAt = 0,
        arReadyAt = 0,
        state0 = nil,
        states = {},
        fillerEvents = {},
        nextMS = { found = false, at = 0, timeFromNow = 0, stateId = 0, cycleIndex = 0, absoluteCycleIndex = 0, reason = "not_found" },
        nextAR = { found = false, at = 0, timeFromNow = 0, stateId = 0, cycleIndex = 0, absoluteCycleIndex = 0, reason = "not_found" },
    }

    if not result.classOk then
        result.reason = "not_hunter"
        return result
    end
    if not result.versionOk then
        result.reason = "not_tbc"
        return result
    end

    result.moduleEnabled = (TBCHunterAPI.db and TBCHunterAPI.db.class and TBCHunterAPI.db.class.enabled) and true or false
    if not result.moduleEnabled then
        result.reason = "module_disabled"
        return result
    end

    local now, readyInEffective, readyInBase, queuedEndIn, steadyQueued, rangedTimeToNext, rangedSpeed, windupSeconds, steadyCastSeconds, multiCastSeconds, gcdLeft, usedFallbackSnapshot, ok = ResolveTimingInputs(snap, options)
    local computeTrigger = tostring(options and options.triggerSource or "unknown")
    -- For explicit cast/backup refreshes, queued SS execution is not valid signal.
    -- These triggers happen after an action boundary where stale queue flags can linger.
    if computeTrigger == "ms_zero_backup" or computeTrigger == "spell_sent_ms" or computeTrigger == "spell_sent_ar" then
        steadyQueued = false
        queuedEndIn = 0
    end
    result.now = now
    result.readyInBase = readyInBase
    result.queuedEndIn = queuedEndIn
    result.readyInEffective = readyInEffective
    result.gcdLeft = gcdLeft
    result.steadyQueued = steadyQueued
    result.rangedTimeToNext = rangedTimeToNext
    result.rangedSpeed = rangedSpeed
    result.usedSnapshotFallback = usedFallbackSnapshot == true
    result.windupSeconds = windupSeconds
    result.steadyCastSeconds = steadyCastSeconds
    result.multiCastSeconds = multiCastSeconds
    result.inputsOk = ok
    result.speedOk = rangedSpeed > FILLER_MIN_SWING_SECONDS

    if not ok then
        result.reason = "invalid_inputs"
        return result
    end

    -- When SpellTimeToReady returns -1 (invalid), GetSpellReadyIn returns nil; treat as "not ready" (large delay).
    local UNKNOWN_READY_SECONDS = 999
    local msReadyIn = GetSpellReadyIn(MULTI_SHOT_TBC_ID)
    local arReadyIn = GetSpellReadyIn(ARCANE_SHOT_TBC_ID)
    result.msReadyAtInitial = now + (msReadyIn or UNKNOWN_READY_SECONDS)
    result.arReadyAtInitial = now + (arReadyIn or UNKNOWN_READY_SECONDS)
    result.msReadyAt = result.msReadyAtInitial
    result.arReadyAt = result.arReadyAtInitial

    local fillerClipTolerance = FILLER_CLIP_TOLERANCE_DEFAULT_SECONDS
    if TBCHunterAPI.db and TBCHunterAPI.db.class then
        local v = TBCHunterAPI.db.class.fillerClipToleranceSeconds
        if type(v) == "number" and v >= 0 and v <= 0.5 then
            fillerClipTolerance = v
        end
    end

    -- Early gap = time before wind-up when we can fit filler + Steady. Clip tolerance extends the window.
    local earlyGapDuration = rangedSpeed - windupSeconds - steadyCastSeconds + fillerClipTolerance
    if earlyGapDuration < 0 then
        earlyGapDuration = 0
    end
    result.earlyGapDuration = earlyGapDuration

    local actionableAt = now + readyInEffective
    local gcdReadyAt = now + gcdLeft
    result.gcdReadyAtInitial = gcdReadyAt
    local nextAutoAt = now + rangedTimeToNext
    local previousAutoAt = nextAutoAt - rangedSpeed
    local firstAutoAt = nextAutoAt
    if now <= (previousAutoAt + earlyGapDuration) then
        firstAutoAt = previousAutoAt
    end
    local state0StartAt = firstAutoAt - rangedSpeed
    local state0EndAt = firstAutoAt
    local state0WindupStartAt = state0EndAt - windupSeconds
    local state0EarlyGapEndAt = state0StartAt + earlyGapDuration
    local state0Context = {
        actionableAt = actionableAt,
        gcdReadyAt = gcdReadyAt,
        ssQueuedLastState = steadyQueued == true,
        msReadyAt = result.msReadyAt,
        arReadyAt = result.arReadyAt,
    }
    local state0Decision = DecideHunterStateAction(state0Context, {
        now = now,
        gcdLeft = gcdLeft,
        triggerSource = computeTrigger,
        steadyCastSeconds = steadyCastSeconds,
        multiCastSeconds = multiCastSeconds,
        rangedSpeed = rangedSpeed,
        earlyGapDuration = earlyGapDuration,
        speedOk = result.speedOk,
        fillerClipToleranceSeconds = fillerClipTolerance,
    }, {
        stateStartAt = state0StartAt,
        stateEndAt = state0EndAt,
        windupStartAt = state0WindupStartAt,
    })

    -- Debug: print next action and why it was picked (gated behind dev mode).
    if IsDevModeEnabled() then
        local chosen = tostring(state0Decision.chosenAction or ACTION_NONE)
        local reason = tostring(state0Decision.stateReason or "none")
        local fillerReason = tostring(state0Decision.fillerReason or "none")
        local expClip = tonumber(state0Decision.expectedClipSeconds or 0) or 0
        local msReadyAt = tonumber(state0Context.msReadyAt or 0) or 0
        local arReadyAt = tonumber(state0Context.arReadyAt or 0) or 0
        local canMs = actionableAt >= msReadyAt
        local canAr = actionableAt >= arReadyAt
        local msReadyIn = msReadyAt > now and (msReadyAt - now) or 0
        local arReadyIn = arReadyAt > now and (arReadyAt - now) or 0
        local actionIn = actionableAt > now and (actionableAt - now) or 0
        local windupStartIn = state0WindupStartAt > now and (state0WindupStartAt - now) or 0
        local gapEndIn = state0EarlyGapEndAt > now and (state0EarlyGapEndAt - now) or 0
        local ssCastEndIn = (tonumber(state0Decision.ssCastEndAt or 0) or 0) > now and ((tonumber(state0Decision.ssCastEndAt or 0) or 0) - now) or 0
        NAG:Print(string.format(
            "[STATE0] t=%.3f chosen=%s reason=%s fillerReason=%s expClip=%.3f | actionIn=%.3f windupStartIn=%.3f gapEndIn=%.3f | canMs=%s canAr=%s msReadyIn=%.3f arReadyIn=%.3f | earlyGap=%.3f speedOk=%s ssCastEndIn=%.3f",
            now,
            chosen,
            reason,
            fillerReason,
            expClip,
            actionIn,
            windupStartIn,
            gapEndIn,
            tostring(canMs),
            tostring(canAr),
            msReadyIn,
            arReadyIn,
            earlyGapDuration,
            tostring(result.speedOk == true),
            ssCastEndIn
        ))
        if computeTrigger == "ms_zero_backup" or computeTrigger == "spell_sent_ms" or computeTrigger == "spell_sent_ar" then
            NAG:Print(string.format(
                "[STATE0_TRIGGER_GUARD] trigger=%s steadyQueuedForced=false queuedEndForced=0",
                computeTrigger
            ))
        end
    end

    -- Apply NOW recommendation cooldown consequences before predicting future states.
    local seedMsReadyAt = tonumber(state0Decision.msReadyAtAfter or result.msReadyAt) or result.msReadyAt
    local seedArReadyAt = tonumber(state0Decision.arReadyAtAfter or result.arReadyAt) or result.arReadyAt
    result.msReadyAt = seedMsReadyAt
    result.arReadyAt = seedArReadyAt

    result.state0 = {
        stateId = 0,
        stateStartAt = state0StartAt,
        stateEndAt = state0EndAt,
        gapStartAt = state0WindupStartAt,
        gapEndAt = state0EarlyGapEndAt,
        now = now,
        actionableAt = actionableAt,
        effectiveGapStartAt = math.max(state0WindupStartAt, actionableAt),
        effectiveGapEndAt = state0EarlyGapEndAt,
        gcdReadyAt = gcdReadyAt,
        gcdRemainingSecondsAtStateStart = gcdLeft,
        gcdFullSeconds = (NAG and NAG.GCDTimeValue and tonumber(NAG:GCDTimeValue() or GCD_SECONDS)) or GCD_SECONDS,
        steadyQueued = steadyQueued == true,
        inWarmUp = (NAG and NAG.HunterInWarmUp and NAG:HunterInWarmUp() == true) or (rangedTimeToNext > 0 and rangedTimeToNext <= windupSeconds),
        queuedSteadyEndAt = queuedEndIn > 0 and (now + queuedEndIn) or nil,
        rangedSpeed = rangedSpeed,
        rangedTimeToNext = rangedTimeToNext,
        -- NOW recommendation from the same state machine decision logic.
        chosenAction = state0Decision.chosenAction,
        chosenAction2 = nil,
        stateReason = state0Decision.stateReason,
        stateReason2 = nil,
        ssQueuedLastState = state0Context.ssQueuedLastState == true,
        ssQueuedThisState = state0Decision.ssQueuedThisState == true,
        ssPressAt = state0Decision.ssPressAt,
        ssCastStartAt = state0Decision.ssCastStartAt,
        ssCastEndAt = state0Decision.ssCastEndAt,
        ssPressAt2 = 0,
        ssCastStartAt2 = 0,
        ssCastEndAt2 = 0,
        gcdStartAt1 = state0Decision.gcdStartAt,
        gcdEndAt1 = state0Decision.gcdEndAt,
        gcdStartAt2 = 0,
        gcdEndAt2 = 0,
        gcdStartAt = state0Decision.gcdStartAt,
        gcdEndAt = state0Decision.gcdEndAt,
        nextActionableAt = state0Decision.nextActionableAt,
        postFillerActionableAt = state0Decision.nextActionableAt,
        fillerSpellId = state0Decision.fillerSpellId,
        fillerSpell = state0Decision.fillerSpell,
        fillerCastAt = state0Decision.fillerCastAt,
        fillerCastEndAt = state0Decision.fillerCastEndAt,
        fillerGcdEndAt = state0Decision.fillerGcdEndAt,
        fillerLhs = state0Decision.fillerSafetyLhs,
        fillerRhs = state0Decision.fillerSafetyRhs,
        fillerSafe = state0Decision.fillerSafetyPassed == true,
        fillerSafetyEvaluated = state0Decision.fillerSafetyEvaluated == true,
        fillerReason = tostring(state0Decision.fillerReason or "filler: unknown"),
        expectedClipSeconds = tonumber(state0Decision.expectedClipSeconds or 0) or 0,
        clipped = state0Decision.clipped == true,
        earlyGapExists = earlyGapDuration > EARLY_GAP_MIN_SECONDS,
        earlyGapLhs = earlyGapDuration,
        earlyGapRhs = EARLY_GAP_MIN_SECONDS,
        absoluteCycleIndex = 0,
        cycleIndex = 0,
    }

    local horizonAt = now + result.horizonSeconds
    local absoluteCycleBase = ResolveAbsoluteCycleBase(firstAutoAt, rangedSpeed, now)
    result.absoluteCycleBase = absoluteCycleBase

    if not StateMachine then
        StateMachine = ns.StateMachine
    end
    if not StateMachine or type(StateMachine.CreateTimelinePredictor) ~= "function" then
        result.reason = "state_machine_unavailable"
        return result
    end

    local predictor = StateMachine.CreateTimelinePredictor({
        maxSteps = MAX_STATE_CYCLES * 2,
        shouldContinue = function(context)
            return context.cycleIndex < MAX_STATE_CYCLES
        end,
        step = function(context)
            -- Pass gcdLeft and triggerSource; unprepared rule in DecideHunterStateAction only fires
            -- when triggerSource=="autoshot", so predictor state1 shows SS during windup for autoshot
            -- but SS in gap/fillers for other triggers.
            return BuildHunterCycleStep(context, {
                now = now,
                gcdLeft = gcdLeft,
                triggerSource = computeTrigger,
                horizonAt = horizonAt,
                rangedSpeed = rangedSpeed,
                windupSeconds = windupSeconds,
                steadyCastSeconds = steadyCastSeconds,
                multiCastSeconds = multiCastSeconds,
                earlyGapDuration = earlyGapDuration,
                absoluteCycleBase = absoluteCycleBase,
                fillerClipToleranceSeconds = fillerClipTolerance,
            }, result)
        end,
    })

    local predictorSeedActionableAt = tonumber(state0Decision.nextActionableAt or actionableAt) or actionableAt
    local predictorSeedSsQueued = state0Decision.ssQueuedThisState == true
    local predictorStateStartAt = firstAutoAt
    local predictorStateEndAt = firstAutoAt + rangedSpeed
    local predictorSeedResyncedToCurrentSwing = false
    if state0Decision.stateReason == "actionable_after_state_end" and firstAutoAt == nextAutoAt then
        local reseedLeadSeconds = 0.05
        if now < (nextAutoAt - reseedLeadSeconds) then
            predictorStateStartAt = previousAutoAt
            predictorStateEndAt = nextAutoAt
            predictorSeedResyncedToCurrentSwing = true
        end
    end
    if IsDevModeEnabled() and state0Decision.stateReason == "actionable_after_state_end" then
        NAG:Print(string.format(
            "[PREDICTOR_SEED] t=%.3f reason=%s firstAutoIn=%.3f prevAutoIn=%.3f nextAutoIn=%.3f earlyGap=%.3f resynced=%s seedStartIn=%.3f seedEndIn=%.3f",
            now,
            tostring(state0Decision.stateReason or "none"),
            max(0, firstAutoAt - now),
            max(0, previousAutoAt - now),
            max(0, nextAutoAt - now),
            earlyGapDuration,
            tostring(predictorSeedResyncedToCurrentSwing),
            max(0, predictorStateStartAt - now),
            max(0, predictorStateEndAt - now)
        ))
    end
    local timelinePrediction = predictor:predict({
        autoAt = predictorStateEndAt,
        cycleIndex = 0,
        stateStartAt = predictorStateStartAt,
        stateEndAt = predictorStateEndAt,
        actionableAt = predictorSeedActionableAt,
        gcdReadyAt = tonumber(state0Decision.gcdEndAt or gcdReadyAt) or gcdReadyAt,
        ssQueuedLastState = predictorSeedSsQueued,
        msReadyAt = seedMsReadyAt,
        arReadyAt = seedArReadyAt,
    })

    result.states = timelinePrediction.states or {}
    -- Debug: print predictor seed and first predicted state (gated behind dev mode).
    if IsDevModeEnabled() then
        local s1 = result.states[1]
        local slot1Action = s1 and tostring(s1.chosenAction or "none") or "none"
        local slot2Action = s1 and tostring(s1.chosenAction2 or "none") or "none"
        local reason1 = s1 and tostring(s1.stateReason or "none") or "none"
        local reason2 = s1 and tostring(s1.stateReason2 or "none") or "none"
        local msReadyIn = seedMsReadyAt > now and (seedMsReadyAt - now) or 0
        local actionIn = predictorSeedActionableAt > now and (predictorSeedActionableAt - now) or 0
        NAG:Print(string.format(
            "[PREDICTOR] t=%.3f steadyQueued=%s ssQueuedSeed=%s actionIn=%.3f msReadyIn=%.3f | s1_slot1=%s reason1=%s | s1_slot2=%s reason2=%s",
            now,
            tostring(steadyQueued == true),
            tostring(predictorSeedSsQueued),
            actionIn,
            msReadyIn,
            slot1Action,
            reason1,
            slot2Action,
            reason2
        ))
    end
    if timelinePrediction.context then
        result.msReadyAt = tonumber(timelinePrediction.context.msReadyAt or result.msReadyAt) or result.msReadyAt
        result.arReadyAt = tonumber(timelinePrediction.context.arReadyAt or result.arReadyAt) or result.arReadyAt
    end

    if #result.states == 0 then
        result.reason = "no_states_in_horizon"
        return result
    end

    result.activeStateId = tonumber(result.states[1].stateId or 0) or 0
    result.activeCycleIndex = tonumber(result.states[1].absoluteCycleIndex or result.states[1].cycleIndex or 0) or 0
    if not result.nextMS.found then
        result.nextMS.reason = "not_ready_within_horizon"
    end
    if not result.nextAR.found then
        result.nextAR.reason = "not_ready_within_horizon"
    end
    result.reason = "ok"
    result.ok = true
    return result
end

-- ============================ PUBLIC API ============================
--- Returns full state timeline prediction (state-machine model).
--- @param snap table|nil Optional hunter snapshot
--- @param horizonSeconds number|nil Optional prediction horizon
--- @return table result
function TBCHunterAPI:PredictStateTimeline(snap, horizonSeconds)
    return EvaluateStateTimeline(snap, horizonSeconds)
end

--- Convenience predictor using best available snapshot.
--- @param horizonSeconds number|nil Optional prediction horizon
--- @param options table|nil Optional overrides (`overrideNow`, `overrideRangedTimeToNext`)
--- @return table result
function TBCHunterAPI:PredictStateTimelineLive(horizonSeconds, options)
    local snap = BuildBestSnapshot()
    return EvaluateStateTimeline(snap, horizonSeconds, options)
end

--- Returns next expected Multi-Shot and Arcane Shot from state timeline.
--- @param snap table|nil Optional hunter snapshot
--- @param horizonSeconds number|nil Optional prediction horizon
--- @return table result
function TBCHunterAPI:PredictNextMSAndARByState(snap, horizonSeconds)
    local timeline = EvaluateStateTimeline(snap, horizonSeconds)
    return {
        ok = timeline.ok == true,
        reason = timeline.reason,
        now = timeline.now,
        horizonSeconds = timeline.horizonSeconds,
        activeStateId = timeline.activeStateId,
        nextMS = timeline.nextMS,
        nextAR = timeline.nextAR,
        stateCount = #(timeline.states or {}),
        timeline = timeline,
    }
end

--- Prints one packed state-timeline debug line and returns structured timeline.
--- @param snap table|nil Optional hunter snapshot
--- @param horizonSeconds number|nil Optional prediction horizon
--- @param expectedPrintVersion string|nil Optional expected version marker
--- @return table result
function TBCHunterAPI:DebugPredictStateTimeline(snap, horizonSeconds, expectedPrintVersion)
    local result = EvaluateStateTimeline(snap, horizonSeconds)
    PrintStateTimelineDebug(result, expectedPrintVersion)
    return result
end

--- Prints one packed state-timeline debug line from live snapshot.
--- @param horizonSeconds number|nil Optional prediction horizon
--- @param expectedPrintVersion string|nil Optional expected version marker
--- @return table result
function TBCHunterAPI:DebugPredictStateTimelineLive(horizonSeconds, expectedPrintVersion)
    local snap = BuildBestSnapshot()
    local result = EvaluateStateTimeline(snap, horizonSeconds)
    PrintStateTimelineDebug(result, expectedPrintVersion)
    return result
end

--- Returns current state timeline debug print contract version.
--- @return string
function TBCHunterAPI:GetStateTimelineDebugPrintVersion()
    return STATE_TIMELINE_DEBUG_PRINT_VERSION
end

-- ============================ LIFECYCLE ============================
function TBCHunterAPI:ModuleEnable()
    lastValidRangedSnapshot = nil
    ResetCycleTracker()
    NAG.TBCHunterPredictStateTimeline = function(_, snap, horizonSeconds)
        return self:PredictStateTimeline(snap, horizonSeconds)
    end
    NAG.TBCHunterPredictStateTimelineLive = function(_, horizonSeconds)
        return self:PredictStateTimelineLive(horizonSeconds)
    end
    NAG.TBCHunterPredictNextMSAndARByState = function(_, snap, horizonSeconds)
        return self:PredictNextMSAndARByState(snap, horizonSeconds)
    end
    NAG.TBCHunterDebugPredictStateTimeline = function(_, snap, horizonSeconds, expectedPrintVersion)
        return self:DebugPredictStateTimeline(snap, horizonSeconds, expectedPrintVersion)
    end
    NAG.TBCHunterDebugPredictStateTimelineLive = function(_, horizonSeconds, expectedPrintVersion)
        return self:DebugPredictStateTimelineLive(horizonSeconds, expectedPrintVersion)
    end
    NAG.TBCHunterStateTimelineDebugVersion = function()
        return self:GetStateTimelineDebugPrintVersion()
    end
end

function TBCHunterAPI:ModuleDisable()
    lastValidRangedSnapshot = nil
    ResetCycleTracker()
    NAG.TBCHunterPredictStateTimeline = nil
    NAG.TBCHunterPredictStateTimelineLive = nil
    NAG.TBCHunterPredictNextMSAndARByState = nil
    NAG.TBCHunterDebugPredictStateTimeline = nil
    NAG.TBCHunterDebugPredictStateTimelineLive = nil
    NAG.TBCHunterStateTimelineDebugVersion = nil
end

return TBCHunterAPI
