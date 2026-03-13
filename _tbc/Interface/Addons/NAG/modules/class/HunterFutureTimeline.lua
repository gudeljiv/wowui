--- @module "NAG.HunterFutureTimeline"
--- SIM-style forward prediction (TBC Hunter) for next 3 actions.
---
--- This is a NEW system. It intentionally does not reuse any legacy hunter timeline/bar logic.
--- Phase 1 scope: Steady Shot / Multi-Shot / Arcane Shot only. No melee weave decisions (scaffold only).
---
--- Core idea:
--- 1) Snapshot live timings (GCD, current cast, ranged swing expiration, spell cooldowns).
--- 2) Simulate forward in time using sim-style rules and cast-time formulas (from extern/TBC-sim/hunter).
--- 3) Repeat for A1/A2/A3 while advancing the simulated state each step.
--- 4) Stabilize output with a small hold window to avoid UI flicker/reshuffles.
---
--- References (sim rules):
--- - `extern/TBC-sim/hunter/steady_shot.go` (cast time)
--- - `extern/TBC-sim/hunter/multi_shot.go` (cast time)
--- - `extern/TBC-sim/hunter/arcane_shot.go` (CD base)
--- - `extern/TBC-sim/hunter/rotation.go` (clip check + lazy selection)
---
--- License: CC BY-NC 4.0

-- ============================ LOCALIZE ============================

local _, ns = ...

-- ============================ ADDON ACCESS ============================

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ MODULE ACCESS ============================

-- ============================ LIBRARY ACCESS ============================

local Version = ns.Version
local WoWAPI = ns.WoWAPI
local swingTimerLib = ns.LibClassicSwingTimerAPI

-- ============================ LUA API LOCALIZATION ============================

local max = math.max
local min = math.min
local abs = math.abs

-- ============================ WOW API LOCALIZATION ============================

local GetTime = _G.GetTime
local UnitClassBase = _G.UnitClassBase
local UnitCastingInfo = _G.UnitCastingInfo
local UnitRangedDamage = _G.UnitRangedDamage
local UnitExists = _G.UnitExists
local UnitIsDead = _G.UnitIsDead
local CheckInteractDistance = _G.CheckInteractDistance
local GetInventoryItemID = _G.GetInventoryItemID

-- ============================ CONSTANTS ============================

local SPELL_IDS = {
    STEADY_SHOT = 34120, -- Steady Shot (TBC)
    MULTI_SHOT = 27021,  -- Multi-Shot (TBC)
    ARCANE_SHOT = 27019, -- Arcane Shot (TBC)
    AIMED_SHOT = 27065,  -- Aimed Shot (Rank 7, TBC) - see HunterWeaveModule.lua
}

local TIMING = {
    REACTION_SECONDS = 0.10, -- Human reaction / execution buffer used for safety checks
    FILLER_MIN_SWING_SECONDS = 1.7, -- Non-weave rule: only use fillers when swing is slow enough
    STEADY_CAST_BASE_SECONDS = 1.5, -- TBC base steady cast time (scaled by haste)
    MULTI_CAST_SECONDS = 0.5, -- TBC multi cast time (kept fixed per project policy)
    AIMED_CAST_SECONDS = 3.0, -- Aimed Shot cast time (TBC)
}

local INVENTORY_SLOTS = {
    MAINHAND = 16,
    OFFHAND = 17,
}

local ACTION_KINDS = {
    STEADY = "STEADY",
    MULTI = "MULTI",
    ARCANE = "ARCANE",
    AIMED = "AIMED",
    WEAVE = "WEAVE",
    WAIT = "WAIT",
    NONE = "NONE",
}

-- Sim-derived constants (TBC-sim)
local SIM_CONSTANTS = {
    MULTI_COOLDOWN_SECONDS = 10.0,
    ARCANE_COOLDOWN_BASE_SECONDS = 6.0,
    AIMED_COOLDOWN_SECONDS = 6.0,
}

-- GCD is haste-aware: clamp(1.5 / (1 + haste), 1.0, 1.5)
local function GetHastedGCDSeconds()
    local base = 1.5
    local hasteFactor = NAG.GetHasteFactor and NAG:GetHasteFactor() or 1
    if type(hasteFactor) ~= "number" or hasteFactor <= 0 then
        hasteFactor = 1
    end
    local hasted = base / hasteFactor
    return max(1.0, min(1.5, hasted))
end

-- Output stability
local EPSILON_TIME = 0.001
-- Press-time tolerance: allow for frame/latency jitter so we don't invalidate actions
-- when pressAt is only a few hundredths behind nowEff/gcdReadyAt/castEndAt.
local PRESS_EPS = 0.10
local DEBUG_THROTTLE_SECONDS = 0.10
local WEAVE_DURATION_SECONDS = 0.36

-- ============================ DEFAULTS (SETTINGS ONLY) ============================

local defaults = {
    char = {
        enabled = true,
    },
    class = {
        -- User-configurable latency buffer used by sim cast formulas and GCD scheduling.
        latencyMs = 80,

        -- Recompute throttle for stable prediction cache.
        updateIntervalSeconds = 0.05,

        -- Hold time before promoting a changed prediction (prevents flicker).
        stabilizeHoldSeconds = 0.10,

        -- Windup/queue modeling:
        -- If LibClassicSwingTimerAPI provides a per-player `autoShotCastTime`, prefer that; otherwise fall back.
        windupFallbackSeconds = 0.50,

        -- Weave scaffolding (disabled by default; rules are implemented conservatively).
        enableWeaving = false,

        -- Prediction debug: print one compact line per tick with full planner state.
        debugPrediction = false,
    }
}

-- ============================ MODULE CREATION ============================

--- @class HunterFutureTimeline:CoreModule
local HunterFutureTimeline = NAG:CreateModule("HunterFutureTimeline", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function()
        return not (Version and Version:IsTBC()) or UnitClassBase("player") ~= "HUNTER"
    end,
    slashCommands = {
        ["hunter-timeline-validate"] = {
            handler = "RunTimelineValidate",
            help = "Simulate 6s forward and print event list for validation (debug).",
        },
    },
    eventHandlers = {
        UNIT_SPELLCAST_START = true,
        UNIT_SPELLCAST_SENT = true,
    },
})

ns.HunterFutureTimeline = HunterFutureTimeline

-- ============================ MODULE STATE (RUNTIME ONLY) ============================

HunterFutureTimeline.state = HunterFutureTimeline.state or {}
HunterFutureTimeline.state.lastComputeAt = 0
HunterFutureTimeline.state.stableActions = nil
HunterFutureTimeline.state.pendingActions = nil
HunterFutureTimeline.state.pendingSince = 0
HunterFutureTimeline.state.lastSnapshot = nil
HunterFutureTimeline.state.lockedA1 = nil
HunterFutureTimeline.state.lockedA1WindupStartAt = nil
HunterFutureTimeline.state.autoShotWasOn = nil
HunterFutureTimeline.state.spellcastStartUnlock = false
HunterFutureTimeline.state.castStartSpellId = nil -- Spell ID when UNIT_SPELLCAST_START fired (for commit+shift)
HunterFutureTimeline.state.castStartAt = nil
HunterFutureTimeline.state.planId = 0
HunterFutureTimeline.state.pendingCast = nil
HunterFutureTimeline.state.lastCastAttemptSpellId = nil
HunterFutureTimeline.state.lastCastAttemptAt = 0
HunterFutureTimeline.state.shiftHold = nil

-- ============================ PRIVATE HELPERS ============================

--- @param a table|nil
--- @param b table|nil
--- @return boolean
local function ActionsEqual(a, b)
    if a == b then
        return true
    end
    if not a or not b then
        return false
    end
    if #a ~= #b then
        return false
    end
    for i = 1, #a do
        local ai = a[i]
        local bi = b[i]
        if (ai and bi) then
            if ai.spellId ~= bi.spellId then
                return false
            end
            if ai.kind ~= bi.kind then
                return false
            end
        else
            return false
        end
    end
    return true
end

--- @param actions table|nil
--- @return table|nil
local function ShallowCopyActions(actions)
    if not actions then
        return nil
    end
    local copy = {}
    for i = 1, #actions do
        local a = actions[i]
        if a then
            copy[i] = {
                spellId = a.spellId,
                kind = a.kind,
                pressAt = a.pressAt,
                earliestPressAt = a.earliestPressAt or a.pressAt,
                latestSafePressAt = a.latestSafePressAt or a.pressAt,
                castStartAt = a.castStartAt,
                endAt = a.endAt,
                queued = a.queued and true or false,
                gcdReadyAt = a.gcdReadyAt,
                notes = a.notes,
                shootAt = a.shootAt,
                isCastableNow = a.isCastableNow,
                blockedBy = a.blockedBy,
                blockedNow = a.blockedNow,
                blockedAtPress = a.blockedAtPress,
                cdReadyAt = a.cdReadyAt,
                cdRem = a.cdRem,
                invalidated = a.invalidated,
            }
        end
    end
    return copy
end

--- @param cdInfo table|nil
--- @param now number
--- @return number readyAt
local function CooldownReadyAt(cdInfo, now)
    if not cdInfo or not cdInfo.startTime or not cdInfo.duration then
        return now
    end
    if cdInfo.duration <= 0 then
        return now
    end
    return cdInfo.startTime + cdInfo.duration
end

--- Extract spell cooldown (start,duration,enabled) from WoWAPI, supporting table or tuple returns.
--- @param spellId number
--- @return number startTime
--- @return number duration
--- @return number enabled
local function GetSpellCooldownParts(spellId)
    if not WoWAPI or not WoWAPI.GetSpellCooldown then
        return 0, 0, 0
    end

    local a, b, c = WoWAPI.GetSpellCooldown(spellId)
    if type(a) == "table" then
        return tonumber(a.startTime) or 0, tonumber(a.duration) or 0, tonumber(a.isEnabled or a.enabled) or 1
    end
    return tonumber(a) or 0, tonumber(b) or 0, tonumber(c) or 1
end

--- Compute CD ready time ignoring GCD "fake cooldown".
--- In Classic/TBC, GetSpellCooldown returns GCD for many spells; treat durations <= gcd+epsilon as ready.
--- @param spellId number
--- @param now number
--- @param gcdSeconds number
--- @param epsilon number|nil
--- @return number readyAt
local function CooldownReadyAtIgnoringGCD(spellId, now, gcdSeconds, epsilon)
    local startTime, duration, enabled = GetSpellCooldownParts(spellId)
    if enabled == 0 then
        return now
    end
    if not duration or duration <= 0 or not startTime or startTime <= 0 then
        return now
    end
    local eps = epsilon or 0.05
    if gcdSeconds and duration <= (gcdSeconds + eps) then
        return now
    end
    return startTime + duration
end

--- Compute spell CD ready timestamp using NAG:SpellTimeToReady when available.
--- Ensures MS/AR suggestions use live cooldown so we only suggest when spell will be off CD at predicted time.
--- @param spellId number
--- @param now number
--- @param gcdSeconds number
--- @return number readyAt
local function SpellCdReadyAt(spellId, now, gcdSeconds)
    if NAG and NAG.SpellTimeToReady then
        local ttr = tonumber(NAG:SpellTimeToReady(spellId) or -1)
        if ttr and ttr >= 0 then
            return now + ttr
        end
    end
    return CooldownReadyAtIgnoringGCD(spellId, now, gcdSeconds, 0.05)
end

-- ============================ DERIVED TIMING UPDATES ============================

--- Normalize swing schedule so `rangedSwingAt` is always at/after now and windupStart stays consistent.
--- @param state table
local function NormalizeRangedSchedule(state)
    local now = state.now or 0
    local speed = state.rangedSwingSpeed or 0
    if not speed or speed <= 0 then
        return
    end

    if state.rangedSwingAt and state.rangedSwingAt < now then
        local swingAt = state.rangedSwingAt
        local guard = 0
        while swingAt < now and guard < 10 do
            swingAt = swingAt + speed
            guard = guard + 1
        end
        state.rangedSwingAt = swingAt
    end

    local windupSeconds = state.rangedWindupSeconds or 0.5
    if not windupSeconds or windupSeconds <= 0 then
        windupSeconds = 0.5
    end
    state.nextAutoAt = state.rangedSwingAt
    -- Keep the true windup boundary (can be < now).
    state.rangedWindupStartAt = (state.rangedSwingAt or now) - windupSeconds
end

--- @return boolean
local function PlayerHasTwoHandMeleeEquipped()
    -- Conservative heuristic: only allow weaving when the offhand slot is empty.
    -- Hunters can dual wield; using a 2H melee implies no offhand weapon.
    if not GetInventoryItemID then
        return false
    end
    local mh = GetInventoryItemID("player", INVENTORY_SLOTS.MAINHAND)
    local oh = GetInventoryItemID("player", INVENTORY_SLOTS.OFFHAND)
    if not mh then
        return false
    end
    return not oh
end

--- @return boolean
local function PlayerInMeleeRange()
    -- Scaffolding: target-only check. (Mouseover weave workflow is intentionally not implemented yet.)
    if not UnitExists or not UnitExists("target") then
        return false
    end
    if UnitIsDead and UnitIsDead("target") then
        return false
    end
    if not CheckInteractDistance then
        return false
    end
    return CheckInteractDistance("target", 3) and true or false
end

--- @param now number
--- @return boolean ok, table|nil snapshot
local function BuildMeleeSwingSnapshot(now)
    if not swingTimerLib or not swingTimerLib.UnitSwingTimerInfo then
        return false, nil
    end
    local speed, expiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    if not speed or not expiration or speed <= 0 then
        return false, nil
    end
    return true, {
        meleeSpeed = speed,
        meleeSwingAt = expiration,
    }
end

--- @param now number
--- @param speed number|nil
--- @param expiration number|nil
--- @return boolean ok, table|nil snapshot
local function BuildSwingSnapshot(now, speed, expiration)
    if not speed or speed <= 0 or not expiration then
        return false, nil
    end

    -- LibClassicSwingTimerAPI can momentarily report an expired expiration (or nil) at the swing edge.
    -- Clamp to now+epsilon to keep monotonic simulation inputs.
    local clampedExpiration = expiration
    if clampedExpiration < now then
        -- If we're only barely past, project forward by one full cycle (prevents 1-tick holes).
        local over = now - clampedExpiration
        if over >= 0 and over <= 0.05 then
            clampedExpiration = clampedExpiration + speed
        else
            clampedExpiration = now + EPSILON_TIME
        end
    end

    return true, {
        rangedSpeed = speed,
        rangedSwingAt = clampedExpiration,
    }
end

local AUTO_SHOT_SPELL_ID = 75

--- Check if we have a valid ranged timeline (auto on, expiration exists and not stale).
--- @return boolean autoOn, boolean hasRangedTimer, number|nil rangedSpeed, number|nil rangedExpiration
local function GetTimelineState()
    local autoOn = false
    local HunterWeaveModule = NAG:GetModule("HunterWeaveModule", true)
    if HunterWeaveModule and HunterWeaveModule.HunterIsAutoShooting then
        autoOn = HunterWeaveModule:HunterIsAutoShooting()
    else
        if _G.IsAutoRepeatSpell and _G.IsAutoRepeatSpell(AUTO_SHOT_SPELL_ID) then
            autoOn = true
        end
    end

    local rangedSpeed, rangedExpiration = nil, nil
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        rangedSpeed, rangedExpiration = swingTimerLib:UnitSwingTimerInfo("player", "ranged")
    end
    local now = GetTime()
    local hasRangedTimer = (rangedExpiration ~= nil) and rangedExpiration > 0 and (rangedExpiration >= now - 0.2) or false

    return autoOn, hasRangedTimer, rangedSpeed, rangedExpiration
end

-- ============================ TWO-SPARK TIMING PREDICTOR ============================

--- @param self HunterFutureTimeline
--- @param rangedSpeed number|nil
--- @return number windupSeconds
local function GetWindupSecondsForWarmup(self, rangedSpeed)
    local windupFallback = (self.db and self.db.class and self.db.class.windupFallbackSeconds) or 0.50
    local speed = tonumber(rangedSpeed or 0) or 0
    local baseSpeed = 0
    if swingTimerLib and swingTimerLib.player and swingTimerLib.player.rangedBaseSpeed then
        baseSpeed = tonumber(swingTimerLib.player.rangedBaseSpeed) or 0
    end
    if baseSpeed <= 0 then
        baseSpeed = speed
    end

    local windupSeconds = windupFallback
    local computeWindup = ns and ns.HunterComputeWindupSeconds
    if type(computeWindup) == "function" then
        windupSeconds = tonumber(computeWindup(speed, baseSpeed, windupFallback) or windupFallback) or windupFallback
    elseif speed > 0 and baseSpeed > 0 then
        windupSeconds = 0.5 * (speed / baseSpeed)
    elseif swingTimerLib and swingTimerLib.player and type(swingTimerLib.player.autoShotCastTime) == "number" and swingTimerLib.player.autoShotCastTime > 0 then
        windupSeconds = swingTimerLib.player.autoShotCastTime
    end
    if type(windupSeconds) ~= "number" or windupSeconds <= 0 then
        windupSeconds = 0.50
    end
    if speed > 0 and windupSeconds > speed then
        windupSeconds = speed
    end
    return windupSeconds
end

--- Resolve ranged speed and (optional) expiration.
--- @param now number
--- @return number|nil rangedSpeed, number|nil rangedExpiration
local function GetRangedSpeedAndExpiration(now)
    local rangedSpeed, rangedExpiration = nil, nil
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        rangedSpeed, rangedExpiration = swingTimerLib:UnitSwingTimerInfo("player", "ranged")
    end
    if (not rangedSpeed or rangedSpeed <= 0) and UnitRangedDamage then
        rangedSpeed = UnitRangedDamage("player")
    end
    return rangedSpeed, rangedExpiration
end

--- Determine shootAt with explicit Auto Shot warm-up handling.
--- @param self HunterFutureTimeline
--- @param now number
--- @param autoShotOn boolean
--- @param windupSeconds number
--- @return number|nil shootAt, string source
local function ComputeShootAt(self, now, autoShotOn, windupSeconds)
    if not autoShotOn then
        self.state.autoWarmupUntilAt = nil
        self.state.autoWasOn = false
        return nil, "AUTO_OFF"
    end

    -- Transition into auto: establish warm-up deadline.
    if not self.state.autoWasOn then
        self.state.autoWarmupUntilAt = now + (windupSeconds or 0.50)
    end
    self.state.autoWasOn = true

    local _, rangedExpiration = GetRangedSpeedAndExpiration(now)
    local hasExpiration = rangedExpiration and rangedExpiration > 0 and rangedExpiration >= (now - 0.2)
    if hasExpiration then
        return rangedExpiration, "LIB_EXPIRATION"
    end

    if self.state.autoWarmupUntilAt and self.state.autoWarmupUntilAt > now then
        return self.state.autoWarmupUntilAt, "WARMUP"
    end

    return now + (windupSeconds or 0.50), "FRESH_ESTIMATE"
end

--- @param now number
--- @param gcdReadyAt number
--- @param castEndAt number
--- @return number nowEff
local function ComputeNowEffective(now, gcdReadyAt, castEndAt)
    return max(now, gcdReadyAt or now, castEndAt or now)
end

--- Compute cast/gcd anchors from live APIs.
--- @param now number
--- @param latencySeconds number
--- @return number gcdValue, number gcdReadyAt, boolean hasRealCast, number castEndAt
local function ComputeGCDAndCastAnchors(now, latencySeconds)
    local gcdTimeToReady = NAG:GCDTimeToReady()
    local gcdValue = GetHastedGCDSeconds()
    local gcdReadyAt = now + max(0, gcdTimeToReady or 0)

    local castName, _, _, _, castEndMs = UnitCastingInfo("player")
    local castEndAt = 0
    local hasRealCast = false
    if castName and castEndMs and castEndMs > 0 then
        castEndAt = castEndMs / 1000
        hasRealCast = true
    end

    return gcdValue, gcdReadyAt, hasRealCast, castEndAt
end

--- @param self HunterFutureTimeline
--- @param now number
--- @param gcdValue number
--- @return number multiCdReadyAt, number arcaneCdReadyAt
local function ComputeFillerCooldowns(self, now, gcdValue)
    local multiCdReadyAt = SpellCdReadyAt(SPELL_IDS.MULTI_SHOT, now, gcdValue)
    local arcaneCdReadyAt = SpellCdReadyAt(SPELL_IDS.ARCANE_SHOT, now, gcdValue)
    return multiCdReadyAt, arcaneCdReadyAt
end

--- @param rangedSpeed number
--- @return number steadyCastSeconds
local function ComputeSteadyCastSeconds(rangedSpeed)
    local baseSpeed = nil
    if swingTimerLib and swingTimerLib.player and swingTimerLib.player.rangedBaseSpeed then
        baseSpeed = tonumber(swingTimerLib.player.rangedBaseSpeed)
    end
    if not baseSpeed or baseSpeed <= 0 then
        baseSpeed = rangedSpeed
    end
    return TIMING.STEADY_CAST_BASE_SECONDS * (rangedSpeed / baseSpeed)
end

--- @param now number
--- @param nowEff number
--- @param gcdReadyAt number
--- @param castEndAt number
--- @param cdReadyAt number|nil
--- @return number actionableAt
local function ComputeActionableAt(now, nowEff, gcdReadyAt, castEndAt, cdReadyAt)
    return max(nowEff or now, gcdReadyAt or now, castEndAt or now, cdReadyAt or 0)
end

--- @param self HunterFutureTimeline
--- @param now number
--- @param line string
local function PrintTimingDebug(self, now, line)
    if not (self and self.db and self.db.class and self.db.class.debugPrediction) then
        return
    end
    if not self._lastTimingDebugAt then
        self._lastTimingDebugAt = 0
    end
    if (now - self._lastTimingDebugAt) < DEBUG_THROTTLE_SECONDS then
        return
    end
    self._lastTimingDebugAt = now
    print(line)
end

--- Resolve current cast name to a known spell ID used by planner.
--- @param castName string|nil
--- @return number|string
local function ResolveCastingSpellId(castName)
    if not castName or castName == "" then
        return "-"
    end
    local function spellNameById(spellId)
        if WoWAPI and WoWAPI.GetSpellInfo then
            local infoOrName = WoWAPI.GetSpellInfo(spellId)
            if type(infoOrName) == "table" then
                return infoOrName.name
            end
            return infoOrName
        end
        return nil
    end
    if castName == spellNameById(SPELL_IDS.STEADY_SHOT) then
        return SPELL_IDS.STEADY_SHOT
    end
    if castName == spellNameById(SPELL_IDS.MULTI_SHOT) then
        return SPELL_IDS.MULTI_SHOT
    end
    if castName == spellNameById(SPELL_IDS.ARCANE_SHOT) then
        return SPELL_IDS.ARCANE_SHOT
    end
    return castName
end

--- Build the live snapshot used as the simulation starting point.
--- Returns nil when idle (auto off or no valid ranged timer).
--- @return table|nil snapshot
local function BuildLiveSnapshot(self)
    local now = GetTime()
    local autoOn, hasRangedTimer = GetTimelineState()

    if not autoOn or not hasRangedTimer then
        return nil
    end

    if not swingTimerLib or not swingTimerLib.UnitSwingTimerInfo then
        return nil
    end

    -- Ranged swing timing (event-based, combat-log only):
    -- - lastAutoAt = when last Auto Shot actually fired (from combat log, via LibClassicSwingTimerAPI)
    -- - nextAutoAt = lastAutoAt + rangedSpeed (never advanced by cast-end heuristics)
    local rangedSpeed, rangedExpiration, lastRangedSwing = swingTimerLib:UnitSwingTimerInfo("player", "ranged")
    if (not rangedSpeed or rangedSpeed <= 0) and UnitRangedDamage then
        rangedSpeed = UnitRangedDamage("player")
    end
    if not rangedSpeed or rangedSpeed <= 0 then
        return nil
    end

    -- Windup (time just before the auto where queuing SS/MS is ideal), haste-scaled.
    local windupSeconds = GetWindupSecondsForWarmup(self, rangedSpeed)

    local lastAutoAt, nextAutoAt, swingAt
    if lastRangedSwing and lastRangedSwing > 0 then
        lastAutoAt = lastRangedSwing
        nextAutoAt = lastAutoAt + rangedSpeed
        -- Clamp nextAutoAt to now+epsilon if it's in the past (library can report briefly stale at swing edge)
        if nextAutoAt < now then
            local guard = 0
            while nextAutoAt < now and guard < 10 do
                lastAutoAt = nextAutoAt
                nextAutoAt = nextAutoAt + rangedSpeed
                guard = guard + 1
            end
        end
        swingAt = nextAutoAt
    elseif rangedExpiration and rangedExpiration > 0 then
        -- Fallback: no combat log yet (fresh pull), use expiration from library
        lastAutoAt = rangedExpiration - rangedSpeed
        nextAutoAt = rangedExpiration
        if nextAutoAt < now then
            local guard = 0
            while nextAutoAt < now and guard < 10 do
                lastAutoAt = nextAutoAt
                nextAutoAt = nextAutoAt + rangedSpeed
                guard = guard + 1
            end
        end
        swingAt = nextAutoAt
    else
        -- Fresh start: first auto fires after windup once auto is engaged.
        swingAt = now + windupSeconds
        lastAutoAt = nil
        nextAutoAt = swingAt
    end
    -- IMPORTANT: keep windupStartAt as the *true* boundary (can be in the past).
    -- Clamping to `now` makes windupStartAt drift every tick, which destabilizes
    -- shiftHold/tail-freeze and can collapse filler windows into unrealistic slivers.
    local windupStartAt = nextAutoAt - windupSeconds

    local gcdTimeToReady = NAG:GCDTimeToReady()
    local gcdValue = GetHastedGCDSeconds()
    local gcdReadyAt = now + max(0, gcdTimeToReady or 0)

    local castName, _, _, castStartMs, castEndMs = UnitCastingInfo("player")
    local castEndAt = 0
    local hasRealCast = false
    if castName and castEndMs and castEndMs > 0 then
        castEndAt = castEndMs / 1000
        hasRealCast = true
    end

    local latencySeconds = (self.db and self.db.class and (self.db.class.latencyMs or 0) or 0) / 1000

    -- IMPORTANT: use NAG:SpellTimeToReady for MS/AR so suggestions respect live cooldown.
    local multiCdReadyAt = SpellCdReadyAt(SPELL_IDS.MULTI_SHOT, now, gcdValue)
    local arcaneCdReadyAt = SpellCdReadyAt(SPELL_IDS.ARCANE_SHOT, now, gcdValue)
    local aimedCdReadyAt = CooldownReadyAtIgnoringGCD(SPELL_IDS.AIMED_SHOT, now, gcdValue)

    -- Cast times (TBC semantics):
    -- - Steady: base 1.5s, scaled by ranged haste (can drop well below 1.0s).
    --   We derive haste from current ranged speed vs ranged base speed (tooltip speed) via LibClassicSwingTimerAPI.
    -- - Multi: same as wind-up (0.5 base, haste-scaled); MS has its own wind-up animation.
    -- - Arcane: instant (latency buffer only).
    local baseSpeed = nil
    if swingTimerLib.player and swingTimerLib.player.rangedBaseSpeed then
        baseSpeed = tonumber(swingTimerLib.player.rangedBaseSpeed)
    end
    if not baseSpeed or baseSpeed <= 0 then
        baseSpeed = rangedSpeed
    end

    local steadyCastSeconds = TIMING.STEADY_CAST_BASE_SECONDS * (rangedSpeed / baseSpeed)
    local multiCastSeconds = windupSeconds
    local arcaneCastSeconds = latencySeconds
    local aimedCastSeconds = TIMING.AIMED_CAST_SECONDS

    local meleeOk, melee = BuildMeleeSwingSnapshot(now)
    local enableWeaving = self.db and self.db.class and self.db.class.enableWeaving or false

    local snap = {
        now = now,
        gcdValue = gcdValue,
        gcdReadyAt = gcdReadyAt,
        castEndAt = castEndAt,
        hasRealCast = hasRealCast,
        rangedSwingSpeed = rangedSpeed,
        rangedSwingAt = swingAt,
        lastAutoAt = lastAutoAt,
        nextAutoAt = nextAutoAt,
        rangedWindupSeconds = windupSeconds,
        rangedWindupStartAt = windupStartAt,
        latencySeconds = latencySeconds,
        steadyCastSeconds = steadyCastSeconds,
        multiCastSeconds = multiCastSeconds,
        arcaneCastSeconds = arcaneCastSeconds,
        multiCdReadyAt = multiCdReadyAt,
        arcaneCdReadyAt = arcaneCdReadyAt,
        aimedCastSeconds = aimedCastSeconds,
        aimedCdReadyAt = aimedCdReadyAt,

        -- Weave inputs (scaffold)
        enableWeaving = enableWeaving,
        meleeOk = meleeOk,
        meleeSwingSpeed = melee and melee.meleeSpeed or nil,
        meleeSwingAt = melee and melee.meleeSwingAt or nil,
    }
    self.state.lastSnapshot = snap
    return snap
end

--- @param state table
--- @param t number
local function AdvanceTo(state, t)
    state.now = t
    NormalizeRangedSchedule(state)
end

--- @param state table
--- @return number gcdAt
--- @return number shootAt
--- @return number windupStartAt
local function GetKeyTimes(state)
    local now = state.now
    local gcdAt = max(now, state.gcdReadyAt or now, state.castEndAt or now)
    local shootAt = max(now, state.rangedSwingAt or now)
    -- IMPORTANT: do NOT clamp windup start to `now`.
    -- This boundary must remain stable (swingAt - windupSeconds) even if it's in the past,
    -- otherwise it "drifts forward" each tick and destabilizes planning/stabilization.
    local windupStartAt = state.rangedWindupStartAt or now
    return gcdAt, shootAt, windupStartAt
end

--- Compute delay (clip) against a boundary (wind-up start or next auto).
--- Clipping = delaying wind-up start; boundary is typically windupStartAt.
--- @param doneAt number
--- @param autoAt number Boundary time (wind-up start for non-queued, next auto for queued)
--- @return number delaySeconds
local function ComputeShootDelay(doneAt, autoAt)
    return max(0, doneAt - autoAt)
end

-- ============================ CASTABILITY / FILLER VALIDATION ============================

--- Compute blockedBy at an action's planned press time.
--- blockedBy ∈ {CD, GCD, CASTING} or nil
--- @param pressAt number
--- @param gcdReadyAt number
--- @param castEndAt number
--- @param cdReadyAt number|nil
--- @return string|nil
local function ComputeBlockedByAtPress(pressAt, gcdReadyAt, castEndAt, cdReadyAt)
    if castEndAt and castEndAt > pressAt then
        return "CASTING"
    end
    if gcdReadyAt and gcdReadyAt > pressAt then
        return "GCD"
    end
    if cdReadyAt and cdReadyAt > pressAt then
        return "CD"
    end
    return nil
end

--- Build a candidate action timing with explicit queued vs non-queued semantics.
--- Queued: pressTime in [windupStartAt, nextAutoAt) -> castStartAt = nextAutoAt
--- Non-queued: castStartAt = max(pressTime, gcdReadyAt, castEndAt)
---
--- No-clip:
--- - Queued: safe iff (castStartAt + castTime + latencyPad) <= followingAutoAt
--- - Non-queued: safe iff (castStartAt + castTime + latencyPad) <= windupStartAt
--- @param state table
--- @param kind string
--- @param spellId number|nil
--- @param castSeconds number
--- @param cdReadyAt number|nil
--- @param allowWindupQueue boolean
--- @return table candidate
local function BuildCandidate(state, kind, spellId, castSeconds, cdReadyAt, allowWindupQueue)
    local gcdAt, shootAt, windupStartAt = GetKeyTimes(state)
    local now = state.now
    local nextAutoAt = state.nextAutoAt or shootAt
    local speed = state.rangedSwingSpeed or 0
    local latencyPad = state.latencySeconds or 0

    local readyAt = cdReadyAt or now
    local earliestPressAt = max(now, gcdAt, readyAt)

    local queued = false
    local castStartAt

    if allowWindupQueue then
        -- Press during windup: must be in [windupStartAt, nextAutoAt)
        local pressAt = max(now, readyAt, windupStartAt, state.castEndAt or now, state.gcdReadyAt or now)

        if pressAt >= windupStartAt and pressAt < nextAutoAt then
            queued = true
            castStartAt = nextAutoAt
        else
            queued = false
            castStartAt = max(pressAt, state.gcdReadyAt or now, state.castEndAt or now)
        end
    else
        queued = false
        castStartAt = max(earliestPressAt, state.gcdReadyAt or now, state.castEndAt or now)
    end

    local doneAt = castStartAt + (castSeconds or 0)

    -- No-clip evaluation:
    -- - Queued: followingAutoAt = nextAutoAt + speed; safe iff (doneAt + latencyPad) <= followingAutoAt
    -- - Non-queued: safe iff (doneAt + latencyPad) <= windupStartAt
    local clipAutoAt
    local clipDelay
    if queued then
        clipAutoAt = nextAutoAt + speed
        clipDelay = ComputeShootDelay(doneAt + latencyPad, clipAutoAt)
    else
        clipAutoAt = windupStartAt
        clipDelay = ComputeShootDelay(doneAt + latencyPad, windupStartAt)
    end

    -- Latest safe press:
    -- - Queued: nextAutoAt - epsilon (must be in windup before auto)
    -- - Non-queued: windupStartAt - (castSeconds + latencyPad)
    local latestSafePressAt
    if queued then
        latestSafePressAt = nextAutoAt - EPSILON_TIME
    else
        latestSafePressAt = windupStartAt - ((castSeconds or 0) + latencyPad)
    end
    if latestSafePressAt < earliestPressAt then
        latestSafePressAt = earliestPressAt
    end

    local pressAt = earliestPressAt
    if allowWindupQueue and queued then
        pressAt = max(earliestPressAt, windupStartAt)
    end

    return {
        kind = kind,
        spellId = spellId,
        pressAt = pressAt,
        earliestPressAt = earliestPressAt,
        latestSafePressAt = latestSafePressAt,
        castStartAt = castStartAt,
        endAt = doneAt,
        queued = queued,
        clipDelay = clipDelay,
        clipAutoAt = clipAutoAt,
        shootAt = shootAt,
        notes = nil,
    }
end

--- Build an off-GCD melee weave candidate.
---
--- This is intentionally conservative scaffolding:
--- - Only considered while GCD is on cooldown (off-GCD filler time).
--- - Never starts while casting.
--- - Requires melee swing ready, 2H melee equipped, and target in melee range.
--- - Must finish before the next ranged auto so it never clips.
---
--- WF/RS/eWS priority nuances are NOT fully implemented yet (follow-up work).
--- @param state table
--- @return table|nil candidate
local function BuildWeaveCandidate(state)
    local now = state.now

    if not state.enableWeaving then
        return nil
    end

    -- Never weave while casting.
    if (state.castEndAt or 0) > now then
        return nil
    end

    -- Only suggest weave during GCD downtime.
    if (state.gcdReadyAt or 0) <= now then
        return nil
    end

    if not state.meleeOk or not state.meleeSwingAt then
        return nil
    end
    -- Only weave when a melee swing is ready now.
    if state.meleeSwingAt > now then
        return nil
    end

    if not PlayerHasTwoHandMeleeEquipped() then
        return nil
    end
    if not PlayerInMeleeRange() then
        return nil
    end

    local shootAt = max(now, state.rangedSwingAt or now)
    local endAt = now + WEAVE_DURATION_SECONDS

    -- Must not delay autoshot.
    if endAt > (shootAt - EPSILON_TIME) then
        return nil
    end

    return {
        kind = ACTION_KINDS.WEAVE,
        spellId = nil,
        pressAt = now,
        earliestPressAt = now,
        latestSafePressAt = now,
        castStartAt = now,
        endAt = endAt,
        queued = false,
        clipDelay = 0,
        clipAutoAt = shootAt,
        shootAt = shootAt,
        notes = "weave_scaffold",
    }
end

--- For queued (windup) actions, we keep the earliest queue time but choose a later "intended press"
--- time for display so the bar reaches 0 when the player should press (not immediately at windup start).
--- @param action table
--- @param inputBufferSeconds number
local function ApplyQueuedPressDisplayTiming(action, inputBufferSeconds)
    if not action or not action.queued then
        return
    end
    local winStart = action.earliestPressAt or action.pressAt or action.castStartAt
    local winEnd = action.latestSafePressAt or action.pressAt or action.castStartAt
    if not winStart or not winEnd then
        return
    end

    -- Save earliest queue moment for UI (optional).
    action.queueAt = action.pressAt

    local buffer = inputBufferSeconds or 0
    local target = winEnd - buffer
    -- Intended press is late in the window, but never before start/after end.
    action.pressAt = max(winStart, min(target, winEnd))

    -- For debugging/UI clarity.
    action.windowStartAt = winStart
    action.windowEndAt = winEnd
end

--- Build a non-clipping filler candidate (MS/AR) that ignores auto/windup clipping rules.
--- This matches the "no-weaving" design: fillers do not interact with windup and never delay autos.
--- @param state table
--- @param kind string
--- @param spellId number
--- @param castSeconds number
--- @param cdReadyAt number|nil
--- @return table candidate
local function BuildNonClippingFillerCandidate(state, kind, spellId, castSeconds, cdReadyAt)
    local gcdAt, shootAt = GetKeyTimes(state)
    local now = state.now
    local latencyPad = state.latencySeconds or 0

    local readyAt = cdReadyAt or now
    local actionableAt = max(now, gcdAt, readyAt)

    local pressAt = actionableAt
    local castStartAt = pressAt
    local doneAt = castStartAt + (castSeconds or 0)

    -- Window: can press any time after actionableAt, but must press before the next auto fires
    -- (pure gating; does not model clipping).
    local earliestPressAt = actionableAt
    local latestSafePressAt = (shootAt or now) - EPSILON_TIME
    if latestSafePressAt < earliestPressAt then
        latestSafePressAt = earliestPressAt
    end

    return {
        kind = kind,
        spellId = spellId,
        pressAt = pressAt,
        earliestPressAt = earliestPressAt,
        latestSafePressAt = latestSafePressAt,
        castStartAt = castStartAt,
        endAt = doneAt,
        queued = false,
        -- Non-clipping: never reject because doneAt exceeds shootAt/windupStartAt.
        clipDelay = 0,
        clipAutoAt = shootAt,
        shootAt = shootAt,
        notes = nil,
        latencySeconds = latencyPad,
    }
end

--- Choose next action using sim-style rules (SS/MS/AR only).
--- @param state table
--- @param rejectReasons table|nil If provided, populated with rejection reasons for debugging
--- @param a1Locked boolean|nil If true, skip choosing (A1 locked)
--- @return table|nil action
local function ChooseNextAction(state, rejectReasons, a1Locked)
    local function reject(kind, reason)
        if rejectReasons then
            rejectReasons[kind] = reason
        end
    end

    if a1Locked then
        reject("A1", "REJECT_DUE_TO_LOCK")
        return nil
    end

    local weave = BuildWeaveCandidate(state)
    if weave then
        return weave
    end

    local ss = BuildCandidate(
        state,
        ACTION_KINDS.STEADY,
        SPELL_IDS.STEADY_SHOT,
        state.steadyCastSeconds or 0,
        state.now,
        (not state.disableWindupQueue) -- allow windup queue only when not casting
    )

    -- Fillers (no-weaving design): non-clipping and do not use windup queue rules.
    local ms = BuildNonClippingFillerCandidate(
        state,
        ACTION_KINDS.MULTI,
        SPELL_IDS.MULTI_SHOT,
        state.multiCastSeconds or 0,
        state.multiCdReadyAt
    )

    local ar = BuildNonClippingFillerCandidate(
        state,
        ACTION_KINDS.ARCANE,
        SPELL_IDS.ARCANE_SHOT,
        state.arcaneCastSeconds or 0,
        state.arcaneCdReadyAt
    )

    local ssOk = ss.clipDelay <= 0

    local fillerSpeedOk = (state.rangedSwingSpeed or 0) > TIMING.FILLER_MIN_SWING_SECONDS
    local fillerAfterSSOk = state.lastActionKind == ACTION_KINDS.STEADY
    local gcdAt, shootAt = GetKeyTimes(state)
    local minGap = TIMING.REACTION_SECONDS
    local fillerGapOk = (gcdAt + minGap) < (shootAt or state.now)

    local msOk =
        fillerSpeedOk
        and fillerAfterSSOk
        and fillerGapOk
        and (state.multiCdReadyAt or 0) <= (ms.pressAt or state.now)

    local arOk =
        fillerSpeedOk
        and fillerAfterSSOk
        and fillerGapOk
        and (state.arcaneCdReadyAt or 0) <= (ar.pressAt or state.now)

    -- Debug: one line per A1 selection call explaining why fillers are/aren't allowed.
    if rejectReasons then
        local speedStr = fillerSpeedOk and "1" or "0"
        local afterStr = fillerAfterSSOk and "1" or "0"
        local gapStr = fillerGapOk and "1" or "0"
        print(string.format(
            "FILLER_GATE speedOk=%s afterSS=%s gapOk=%s gcdAt=%.2f shootAt=%.2f now=%.2f",
            speedStr,
            afterStr,
            gapStr,
            tonumber(gcdAt) or 0,
            tonumber(shootAt) or 0,
            tonumber(state.now) or 0
        ))
    end

    -- Filler validity: do not allow fillers whose CD completes after their latestSafePressAt.
    local msLatestSafe = ms and (ms.latestSafePressAt or ms.pressAt) or state.now
    local arLatestSafe = ar and (ar.latestSafePressAt or ar.pressAt) or state.now
    if (state.multiCdReadyAt or 0) > msLatestSafe then
        msOk = false
        reject("MS", "REJECT_MS: cd after latestSafe")
    end
    if (state.arcaneCdReadyAt or 0) > arLatestSafe then
        arOk = false
        reject("AR", "REJECT_AR: cd after latestSafe")
    end

    if not ssOk then
        reject("SS", ss.clipDelay > 0 and "REJECT_SS: would cross windupStartAt (non-queued)" or "REJECT_SS: clip")
    end
    if not msOk then
        reject("MS", (state.multiCdReadyAt or 0) > (ms.pressAt or state.now) and "REJECT_MS: cd not ready" or "REJECT_MS: gate")
    end
    if not arOk then
        reject("AR", "REJECT_AR: gate/cd")
    end

    if ssOk then
        -- Fillers are used in the gap BEFORE the next SS windup press.
        -- I.e., if a filler can be executed earlier than SS.pressAt and doesn't clip the next auto.
        -- Also: do not chain fillers (must follow a Steady).
        if fillerSpeedOk and fillerAfterSSOk and fillerGapOk then
            -- MS > AR priority.
            if msOk and (ms.pressAt or state.now) < (shootAt or state.now) then
                ms.notes = "ms_gap_filler"
                return ms
            end

            if (not msOk) and arOk and (ar.pressAt or state.now) < (shootAt or state.now) then
                ar.notes = "ar_gap_filler"
                return ar
            end
        elseif fillerSpeedOk and (not fillerAfterSSOk) and (msOk or arOk) then
            reject("FILLER", "REJECT_FILLER: violates no-filler-after-filler")
        end

        ss.notes = ss.queued and "queue_ss" or "ss"
        return ss
    end

    -- No room for SS: try fillers (MS > AR), but only if they also do not clip.
    if msOk then
        ms.notes = "ms"
        return ms
    end
    if arOk then
        ar.notes = "ar"
        return ar
    end

    -- Fillers on CD: still return MS/AR as "coming up" so UI can show "MS in X.Xs" instead of hard-blocking.
    if fillerSpeedOk and fillerAfterSSOk then
        local msCdAt = state.multiCdReadyAt or 0
        local arCdAt = state.arcaneCdReadyAt or 0
        local now = state.now
        if msCdAt > now and (arCdAt <= now or msCdAt <= arCdAt) then
            ms.pressAt = msCdAt
            ms.earliestPressAt = msCdAt
            ms.latestSafePressAt = msCdAt
            ms.notes = "ms_on_cd"
            return ms
        end
        if arCdAt > now then
            ar.pressAt = arCdAt
            ar.earliestPressAt = arCdAt
            ar.latestSafePressAt = arCdAt
            ar.notes = "ar_on_cd"
            return ar
        end
    end

    -- Nothing fits right now without clipping.
    -- Instead of returning a standalone WAIT action, schedule the next SS press at the next windup
    -- and return SS as the planned action (press later).
    local _, shootAt, _ = GetKeyTimes(state)
    local windupSeconds = state.rangedWindupSeconds or 0.5
    local speed = state.rangedSwingSpeed or 0
    local nextAutoAt = shootAt + speed
    local nextWindupStartAt = max(state.now, nextAutoAt - windupSeconds)

    local planned = BuildCandidate(
        state,
        ACTION_KINDS.STEADY,
        SPELL_IDS.STEADY_SHOT,
        state.steadyCastSeconds or 0,
        state.now,
        true
    )
    planned.pressAt = nextWindupStartAt
    -- IMPORTANT: overwrite timing fields to match the planned press.
    -- Using `or` here can leave stale values from BuildCandidate(), producing:
    -- - winEnd far in the past (degenerate window)
    -- - pressAt far in the future
    -- - UNREACHABLE spam + "stuttery" bars
    planned.earliestPressAt = nextWindupStartAt
    planned.latestSafePressAt = nextAutoAt - EPSILON_TIME
    planned.castStartAt = nextAutoAt
    planned.endAt = nextAutoAt + (state.steadyCastSeconds or 0)
    planned.queued = true
    planned.clipAutoAt = nextAutoAt + speed
    planned.clipDelay = ComputeShootDelay(planned.endAt + (state.latencySeconds or 0), planned.clipAutoAt)
    planned.notes = "planned_ss"
    return planned
end

--- Advance simulated state after choosing an action.
--- @param state table
--- @param action table
local function ApplyAction(state, action)
    local pressAt = action.pressAt or state.now
    local castStartAt = action.castStartAt or pressAt
    local endAt = action.endAt or castStartAt
    local shootAt = action.shootAt or state.rangedSwingAt or state.now

    -- Advance time to the button press moment.
    AdvanceTo(state, pressAt)

    if action.kind == ACTION_KINDS.WAIT or action.kind == ACTION_KINDS.NONE then
        return
    end

    if action.kind == ACTION_KINDS.WEAVE then
        -- Off-GCD busy time: block other actions until weave completes, but do not change GCD or ranged swing state.
        state.castEndAt = endAt
        return
    end

    -- Update cast/gcd locks.
    -- For queued SS (pressed during windup), player expectation is: GCD starts on press, not on cast start.
    state.castEndAt = endAt
    state.gcdReadyAt = pressAt + (state.gcdValue or GetHastedGCDSeconds()) + (state.latencySeconds or 0)

    -- Update spell cooldowns (sim constants). For the 3-action horizon this mostly prevents repeats.
    if action.kind == ACTION_KINDS.MULTI then
        state.multiCdReadyAt = castStartAt + SIM_CONSTANTS.MULTI_COOLDOWN_SECONDS
    elseif action.kind == ACTION_KINDS.ARCANE then
        state.arcaneCdReadyAt = castStartAt + SIM_CONSTANTS.ARCANE_COOLDOWN_BASE_SECONDS
    end

    -- Update ranged swing timing: fixed schedule only. nextAutoAt changes only when an auto actually fires.
    -- Advance to next scheduled auto: shootAt + speed (no cast-end heuristic).
    local speed = state.rangedSwingSpeed or 0
    state.rangedSwingAt = shootAt + speed
    state.nextAutoAt = state.rangedSwingAt

    NormalizeRangedSchedule(state)
    state.lastActionKind = action.kind
end

--- Simulate the next N actions, advancing state each step.
--- @param baseState table
--- @param count number
--- @param rejectReasons table|nil Optional out-param for A1 rejection reasons
--- @return table actions
local function SimulateNextActions(baseState, count, rejectReasons)
    local actions = {}

    local state = {
        -- IMPORTANT: simulate on raw time so it flows linearly (smooth UI + stable horizon).
        -- Constraints (GCD/cast) are handled via gcdReadyAt/castEndAt, not by jumping "now".
        now = baseState.now,
        gcdValue = baseState.gcdValue,
        gcdReadyAt = baseState.gcdReadyAt,
        castEndAt = baseState.castEndAt,
        rangedSwingSpeed = baseState.rangedSwingSpeed,
        rangedSwingAt = baseState.rangedSwingAt,
        nextAutoAt = baseState.nextAutoAt or baseState.rangedSwingAt,
        rangedWindupSeconds = baseState.rangedWindupSeconds,
        rangedWindupStartAt = baseState.rangedWindupStartAt,
        latencySeconds = baseState.latencySeconds,
        steadyCastSeconds = baseState.steadyCastSeconds,
        multiCastSeconds = baseState.multiCastSeconds,
        arcaneCastSeconds = baseState.arcaneCastSeconds,
        multiCdReadyAt = baseState.multiCdReadyAt,
        arcaneCdReadyAt = baseState.arcaneCdReadyAt,

        enableWeaving = baseState.enableWeaving,
        meleeOk = baseState.meleeOk,
        meleeSwingSpeed = baseState.meleeSwingSpeed,
        meleeSwingAt = baseState.meleeSwingAt,

        lastActionKind = nil,
        disableWindupQueue = baseState.disableWindupQueue and true or false,
    }
    NormalizeRangedSchedule(state)

    for i = 1, count do
        local chosen = ChooseNextAction(state, (i == 1) and rejectReasons or nil, false)
        if not chosen then
            -- Fail-safe: never hard-error the UI/update loop. If selection fails for any reason,
            -- fall back to a planned Steady Shot at the next windup.
            local _, shootAt, _ = GetKeyTimes(state)
            local windupSeconds = state.rangedWindupSeconds or 0.5
            local speed = state.rangedSwingSpeed or 0
            local nextAutoAt = shootAt + speed
            local nextWindupStartAt = max(state.now, nextAutoAt - windupSeconds)

            chosen = BuildCandidate(
                state,
                ACTION_KINDS.STEADY,
                SPELL_IDS.STEADY_SHOT,
                state.steadyCastSeconds or 0,
                state.now,
                true
            )
            chosen.pressAt = nextWindupStartAt
            chosen.earliestPressAt = nextWindupStartAt
            chosen.latestSafePressAt = nextAutoAt - EPSILON_TIME
            chosen.castStartAt = nextAutoAt
            chosen.endAt = nextAutoAt + (state.steadyCastSeconds or 0)
            chosen.queued = true
            chosen.notes = "fallback_nil_chosen"
        end

        -- Compute castability/cooldown fields for this planned action.
        local cdReadyAt = nil
        if chosen.kind == ACTION_KINDS.MULTI then
            cdReadyAt = state.multiCdReadyAt
        elseif chosen.kind == ACTION_KINDS.ARCANE then
            cdReadyAt = state.arcaneCdReadyAt
        end

        -- Fillers (MULTI/ARCANE): when CD finishes after latestSafePressAt, spell won't be castable
        -- in this slot's window. We still SHOW it with cdRem so the UI can display "MS in X.Xs"
        -- instead of hard-blocking (nothing until ready).
        local onCooldownForSlot = false
        if (chosen.kind == ACTION_KINDS.MULTI or chosen.kind == ACTION_KINDS.ARCANE) and cdReadyAt then
            local latestSafe = chosen.latestSafePressAt or chosen.pressAt or state.now
            if cdReadyAt > latestSafe then
                onCooldownForSlot = true
            else
                -- If CD becomes ready inside the window, shift earliest/pressAt forward.
                if cdReadyAt > state.now then
                    chosen.earliestPressAt = max(chosen.earliestPressAt or state.now, cdReadyAt)
                    chosen.pressAt = max(chosen.pressAt or state.now, cdReadyAt)
                    chosen.castStartAt = max(chosen.castStartAt or chosen.pressAt or state.now, cdReadyAt)
                    local castSeconds = (chosen.kind == ACTION_KINDS.MULTI) and (state.multiCastSeconds or 0) or (state.arcaneCastSeconds or 0)
                    chosen.endAt = (chosen.castStartAt or state.now) + castSeconds
                end
            end
        end

        if onCooldownForSlot then
            -- Show the action anyway with cdRem so UI can display "MS in X.Xs" (predict ahead of time).
            local pressAt = cdReadyAt or (chosen.pressAt or state.now)
            local blockedAtPress = "CD"
            local blockedNow = ComputeBlockedByAtPress(
                baseState.now or state.now,
                baseState.gcdReadyAt or (baseState.now or state.now),
                baseState.castEndAt or (baseState.now or state.now),
                cdReadyAt
            )
            local cdRem = cdReadyAt and max(0, cdReadyAt - (baseState.now or state.now)) or nil

            actions[i] = {
                kind = chosen.kind,
                spellId = chosen.spellId,
                pressAt = pressAt,
                earliestPressAt = cdReadyAt or chosen.earliestPressAt,
                latestSafePressAt = chosen.latestSafePressAt or pressAt,
                castStartAt = pressAt,
                endAt = pressAt + ((chosen.kind == ACTION_KINDS.MULTI) and (state.multiCastSeconds or 0) or (state.arcaneCastSeconds or 0)),
                queued = false,
                gcdReadyAt = pressAt + (state.gcdValue or GetHastedGCDSeconds()) + (state.latencySeconds or 0),
                notes = chosen.notes,
                shootAt = chosen.shootAt,
                cdReadyAt = cdReadyAt,
                cdRem = cdRem,
                blockedBy = blockedAtPress,
                blockedNow = blockedNow,
                blockedAtPress = blockedAtPress,
                isCastableNow = false,
                invalidated = true,
                onCooldown = true,
            }
            if rejectReasons then
                rejectReasons["NIL_A" .. tostring(i)] = "ON_CD_SHOWN"
            end
            -- Advance state as if player will press at cdReadyAt, so next slot is chosen correctly.
            local castSeconds = (chosen.kind == ACTION_KINDS.MULTI) and (state.multiCastSeconds or 0) or (state.arcaneCastSeconds or 0)
            local endAt = pressAt + castSeconds
            AdvanceTo(state, pressAt)
            state.castEndAt = endAt
            state.gcdReadyAt = pressAt + (state.gcdValue or GetHastedGCDSeconds()) + (state.latencySeconds or 0)
            if chosen.kind == ACTION_KINDS.MULTI then
                state.multiCdReadyAt = pressAt + SIM_CONSTANTS.MULTI_COOLDOWN_SECONDS
            elseif chosen.kind == ACTION_KINDS.ARCANE then
                state.arcaneCdReadyAt = pressAt + SIM_CONSTANTS.ARCANE_COOLDOWN_BASE_SECONDS
            end
            state.lastActionKind = chosen.kind
        else
            local pressAt = chosen.pressAt or state.now
            local blockedAtPress = ComputeBlockedByAtPress(pressAt, state.gcdReadyAt or state.now, state.castEndAt or state.now, cdReadyAt)
            -- blockedNow must reflect LIVE snapshot anchors (not simulated state),
            -- otherwise A2/A3 can show CASTING/GCD churn even when castRem==0.
            local blockedNow = ComputeBlockedByAtPress(
                baseState.now or state.now,
                baseState.gcdReadyAt or (baseState.now or state.now),
                baseState.castEndAt or (baseState.now or state.now),
                cdReadyAt
            )
            local cdRem = cdReadyAt and max(0, cdReadyAt - (baseState.now or state.now)) or nil

            actions[i] = {
                kind = chosen.kind,
                spellId = chosen.spellId,
                pressAt = chosen.pressAt,
                earliestPressAt = chosen.earliestPressAt or chosen.pressAt,
                latestSafePressAt = chosen.latestSafePressAt or chosen.pressAt,
                castStartAt = chosen.castStartAt,
                endAt = chosen.endAt,
                queued = chosen.queued and true or false,
                gcdReadyAt = (chosen.castStartAt or chosen.pressAt or state.now) + (state.gcdValue or GetHastedGCDSeconds()) + (state.latencySeconds or 0),
                notes = chosen.notes,
                shootAt = chosen.shootAt,
                cdReadyAt = cdReadyAt,
                cdRem = cdRem,
                blockedBy = blockedAtPress,
                blockedNow = blockedNow,
                blockedAtPress = blockedAtPress,
                isCastableNow = blockedAtPress == nil,
                invalidated = false,
            }
            ApplyAction(state, chosen)
        end
    end

    return actions
end

-- ============================ STABILIZATION ============================

--- Mark timeline state dirty so next update recomputes immediately.
--- @param reason string|nil
--- @param force boolean|nil
function HunterFutureTimeline:MarkDirty(reason, force)
    self.state.lastComputeAt = 0
    self.state.dirtyReason = reason or "unknown"
    self.state.forceDirty = force and true or false
end

--- Event handler: player cast start should consume/shift plan on next tick.
--- Accepts both AceEvent-style and direct arg variants for debugging safety.
--- @param event string|nil
--- @param unit string|nil
--- @param castGUID string|nil
--- @param spellId number|nil
function HunterFutureTimeline:UNIT_SPELLCAST_START(event, unit, castGUID, spellId)
    local rawEvent, rawUnit, rawCastGUID, rawSpellId = event, unit, castGUID, spellId

    -- Some dispatchers pass args without event name.
    if rawEvent == "player" and rawUnit ~= "player" then
        event = "UNIT_SPELLCAST_START"
        unit = rawEvent
        castGUID = rawUnit
        spellId = rawCastGUID
    end

    if unit == "player" then
        self.state.castStartSpellId = spellId
        self.state.castStartAt = GetTime()
        self.state.spellcastStartUnlock = true
        self:MarkDirty("cast_start", true)

        -- Minimal rotation state for the two-spark predictor.
        if spellId == SPELL_IDS.STEADY_SHOT then
            self.state.lastSSAt = self.state.castStartAt
            self.state.fillerUsedSinceLastSS = false
        elseif spellId == SPELL_IDS.MULTI_SHOT or spellId == SPELL_IDS.ARCANE_SHOT then
            self.state.fillerUsedSinceLastSS = true
        end

        print(("NAG TL EVENT | %s unit=%s spellId=%s raw=(%s,%s,%s,%s)"):format(
            tostring(event),
            tostring(unit),
            tostring(spellId),
            tostring(rawEvent),
            tostring(rawUnit),
            tostring(rawCastGUID),
            tostring(rawSpellId)
        ))
    end
end

--- Track explicit cast attempts to gate pendingCast creation.
--- @param event string|nil
--- @param unit string|nil
--- @param target string|nil
--- @param castGUID string|nil
--- @param spellIdOrName any
function HunterFutureTimeline:UNIT_SPELLCAST_SENT(event, unit, target, castGUID, spellIdOrName)
    if unit ~= "player" then
        return
    end
    local spellId = (type(spellIdOrName) == "number") and spellIdOrName or nil
    self.state.lastCastAttemptSpellId = spellId
    self.state.lastCastAttemptAt = GetTime()
    if spellId == SPELL_IDS.MULTI_SHOT or spellId == SPELL_IDS.ARCANE_SHOT then
        self.state.fillerUsedSinceLastSS = true
    end
    print(("NAG TL EVENT | %s unit=%s spellId=%s"):format(tostring(event), tostring(unit), tostring(spellIdOrName)))
end

--- Check if A1 should be unlocked per plan: spellcast start, latestSafePressAt expiry, Auto toggle change, haste > 80ms.
local function ShouldUnlockA1(self, now, newActions, context)
    if self.state.spellcastStartUnlock then
        self.state.spellcastStartUnlock = false
        return true
    end
    local a1 = self.state.stableActions and self.state.stableActions[1]
    if not a1 then
        return true
    end
    local latestSafe = a1.latestSafePressAt or a1.pressAt
    if latestSafe and now > latestSafe then
        return true
    end
    local autoShotOn = context and context.autoShotOn
    if autoShotOn ~= nil and self.state.autoShotWasOn ~= nil and autoShotOn ~= self.state.autoShotWasOn then
        return true
    end
    local windupStartAt = context and context.windupStartAt
    if windupStartAt and self.state.lockedA1WindupStartAt and abs(windupStartAt - self.state.lockedA1WindupStartAt) > 0.08 then
        return true
    end
    return false
end

--- Promote/hide pending changes so the UI doesn't flicker.
--- A1 is locked once its safe window has opened; unlock on spellcast start, latestSafePressAt expiry, Auto toggle change, or haste > 80ms.
--- @param now number
--- @param newActions table
--- @param context table|nil Optional { windupStartAt, autoShotOn } for unlock checks
--- @return table stableActions
function HunterFutureTimeline:StabilizeActions(now, newActions, context)
    local stable = self.state.stableActions

    -- First time: accept immediately.
    if not stable then
        self.state.stableActions = ShallowCopyActions(newActions)
        self.state.pendingActions = nil
        self.state.pendingSince = 0
        self.state.lockedA1 = newActions and newActions[1]
        self.state.lockedA1WindupStartAt = context and context.windupStartAt
        if context and context.autoShotOn ~= nil then
            self.state.autoShotWasOn = context.autoShotOn
        end
        return self.state.stableActions
    end

    -- No change: keep stable.
    if ActionsEqual(stable, newActions) then
        self.state.pendingActions = nil
        self.state.pendingSince = 0
        return stable
    end

    -- Preserve SHIFTed A1 until it can actually be acted on (or expires).
    if self.state.shiftHold and stable and stable[1] and stable[1].spellId == self.state.shiftHold.spellId then
        local untilAt = self.state.shiftHold.untilAt or 0
        if now <= untilAt then
            if not ShouldUnlockA1(self, now, newActions, context) then
                return stable
            end
        else
            self.state.shiftHold = nil
        end
    end

    -- Check unlock conditions for A1
    if ShouldUnlockA1(self, now, newActions, context) then
        self.state.stableActions = ShallowCopyActions(newActions)
        self.state.pendingActions = nil
        self.state.pendingSince = 0
        self.state.lockedA1 = newActions and newActions[1]
        self.state.lockedA1WindupStartAt = context and context.windupStartAt
        if context and context.autoShotOn ~= nil then
            self.state.autoShotWasOn = context.autoShotOn
        end
        return self.state.stableActions
    end

    -- A1 is locked: has window opened and no unlock condition?
    local a1 = stable[1]
    local earliestPress = a1 and (a1.earliestPressAt or a1.pressAt)
    local windowOpened = earliestPress and now >= earliestPress

    if windowOpened and self.state.lockedA1 then
        -- Keep locked A1; preserve full stable output until unlock
        return stable
    end

    -- Window not yet opened or no lock: accept new
    self.state.stableActions = ShallowCopyActions(newActions)
    self.state.pendingActions = nil
    self.state.pendingSince = 0
    self.state.lockedA1 = newActions and newActions[1]
    self.state.lockedA1WindupStartAt = context and context.windupStartAt
    if context and context.autoShotOn ~= nil then
        self.state.autoShotWasOn = context.autoShotOn
    end
    return self.state.stableActions
end

-- ============================ COMMIT + SHIFT ============================

--- Convert stored action to chosen format for ApplyAction.
--- @param action table Stored action {kind, spellId, pressAt, castStartAt, endAt, queued, shootAt}
--- @param state table Current sim state
--- @return table chosen
local function StoredActionToChosen(action, state)
    local shootAt = action.shootAt or (action.queued and action.castStartAt) or (state.rangedSwingAt or state.nextAutoAt)
    return {
        kind = action.kind,
        spellId = action.spellId,
        pressAt = action.pressAt,
        castStartAt = action.castStartAt,
        endAt = action.endAt,
        shootAt = shootAt,
    }
end

--- Build shifted actions from current snapshot: A2->A1, A3->A2, compute only new A3.
--- @param baseState table
--- @param oldA2 table
--- @param oldA3 table|nil
--- @return table|nil {A1', A2', A3'} or nil on failure
local function BuildShiftedActionsFromSnapshot(baseState, oldA2, oldA3)
    local effectiveNow = baseState.nowEffective or baseState.now
    local state = {
        -- IMPORTANT: use the same effective planning anchor as the main simulator.
        -- Using raw snapshot time here can create actions with pressAt behind nowEff.
        now = effectiveNow,
        gcdValue = baseState.gcdValue,
        gcdReadyAt = baseState.gcdReadyAt,
        castEndAt = baseState.castEndAt,
        rangedSwingSpeed = baseState.rangedSwingSpeed,
        rangedSwingAt = baseState.rangedSwingAt,
        nextAutoAt = baseState.nextAutoAt or baseState.rangedSwingAt,
        rangedWindupSeconds = baseState.rangedWindupSeconds,
        rangedWindupStartAt = baseState.rangedWindupStartAt,
        latencySeconds = baseState.latencySeconds,
        steadyCastSeconds = baseState.steadyCastSeconds,
        multiCastSeconds = baseState.multiCastSeconds,
        arcaneCastSeconds = baseState.arcaneCastSeconds,
        multiCdReadyAt = baseState.multiCdReadyAt,
        arcaneCdReadyAt = baseState.arcaneCdReadyAt,
        enableWeaving = baseState.enableWeaving,
        meleeOk = baseState.meleeOk,
        meleeSwingSpeed = baseState.meleeSwingSpeed,
        meleeSwingAt = baseState.meleeSwingAt,
        lastActionKind = nil,
    }
    NormalizeRangedSchedule(state)

    if not oldA2 then
        return nil
    end

    local chosen2 = StoredActionToChosen(oldA2, state)
    ApplyAction(state, chosen2)

    local a1New = {
        kind = oldA2.kind,
        spellId = oldA2.spellId,
        pressAt = oldA2.pressAt,
        earliestPressAt = oldA2.earliestPressAt or oldA2.pressAt,
        latestSafePressAt = oldA2.latestSafePressAt or oldA2.pressAt,
        castStartAt = oldA2.castStartAt,
        endAt = oldA2.endAt,
        queued = oldA2.queued and true or false,
        gcdReadyAt = oldA2.gcdReadyAt,
        notes = oldA2.notes,
    }

    local a2New = nil
    if oldA3 then
        local chosen3 = StoredActionToChosen(oldA3, state)
        ApplyAction(state, chosen3)
        a2New = {
            kind = oldA3.kind,
            spellId = oldA3.spellId,
            pressAt = oldA3.pressAt,
            earliestPressAt = oldA3.earliestPressAt or oldA3.pressAt,
            latestSafePressAt = oldA3.latestSafePressAt or oldA3.pressAt,
            castStartAt = oldA3.castStartAt,
            endAt = oldA3.endAt,
            queued = oldA3.queued and true or false,
            gcdReadyAt = oldA3.gcdReadyAt,
            notes = oldA3.notes,
        }
    else
        local chosenA2 = ChooseNextAction(state, nil, false)
        if chosenA2 then
            a2New = {
                kind = chosenA2.kind,
                spellId = chosenA2.spellId,
                pressAt = chosenA2.pressAt,
                earliestPressAt = chosenA2.earliestPressAt or chosenA2.pressAt,
                latestSafePressAt = chosenA2.latestSafePressAt or chosenA2.pressAt,
                castStartAt = chosenA2.castStartAt,
                endAt = chosenA2.endAt,
                queued = chosenA2.queued and true or false,
                gcdReadyAt = (chosenA2.castStartAt or chosenA2.pressAt or state.now) + (state.gcdValue or GetHastedGCDSeconds()) + (state.latencySeconds or 0),
                notes = chosenA2.notes,
            }
            ApplyAction(state, chosenA2)
        end
    end

    local chosenA3 = ChooseNextAction(state, nil, false)
    if not chosenA3 then
        local _, shootAt, _ = GetKeyTimes(state)
        local windupSeconds = state.rangedWindupSeconds or 0.5
        local speed = state.rangedSwingSpeed or 0
        local nextAutoAt = shootAt + speed
        local nextWindupStartAt = max(state.now, nextAutoAt - windupSeconds)
        chosenA3 = BuildCandidate(
            state,
            ACTION_KINDS.STEADY,
            SPELL_IDS.STEADY_SHOT,
            state.steadyCastSeconds or 0,
            state.now,
            true
        )
        chosenA3.pressAt = nextWindupStartAt
        chosenA3.earliestPressAt = nextWindupStartAt
        chosenA3.latestSafePressAt = nextAutoAt - EPSILON_TIME
        chosenA3.castStartAt = nextAutoAt
        chosenA3.endAt = nextAutoAt + (state.steadyCastSeconds or 0)
        chosenA3.queued = true
        chosenA3.notes = "shift_fallback"
    end

    local a3New = {
        kind = chosenA3.kind,
        spellId = chosenA3.spellId,
        pressAt = chosenA3.pressAt,
        earliestPressAt = chosenA3.earliestPressAt or chosenA3.pressAt,
        latestSafePressAt = chosenA3.latestSafePressAt or chosenA3.pressAt,
        castStartAt = chosenA3.castStartAt,
        endAt = chosenA3.endAt,
        queued = chosenA3.queued and true or false,
        gcdReadyAt = (chosenA3.castStartAt or chosenA3.pressAt or state.now) + (state.gcdValue or GetHastedGCDSeconds()) + (state.latencySeconds or 0),
        notes = chosenA3.notes,
    }

    return { a1New, a2New, a3New }
end

--- Try to consume and shift stable plan on cast start.
--- @param self table
--- @param now number
--- @param baseState table|nil
--- @param prevStable table|nil
--- @return table|nil shiftedActions
local function TryShiftOnCastStart(self, now, baseState, prevStable)
    local stable = prevStable
    local castSpellId = self.state.castStartSpellId
    local pendingCast = self.state.pendingCast

    if not baseState or not stable or not stable[1] or not castSpellId then
        return nil
    end

    local oldA1 = stable[1]
    local castMatchesA1 = oldA1.spellId == castSpellId
    local castMatchesPending = pendingCast and pendingCast.spellId == castSpellId
    if not castMatchesA1 and not castMatchesPending then
        return nil
    end

    local shifted = BuildShiftedActionsFromSnapshot(baseState, stable[2], stable[3])
    if not shifted then
        return nil
    end

    self.state.planId = (self.state.planId or 0) + 1
    self.state.stableActions = ShallowCopyActions(shifted)
    self.state.lockedA1 = nil
    self.state.lockedA1WindupStartAt = nil
    local newA1 = self.state.stableActions and self.state.stableActions[1]
    if newA1 then
        self.state.shiftHold = {
            spellId = newA1.spellId,
            untilAt = newA1.latestSafePressAt or newA1.pressAt or now,
            windupStartAt = baseState.rangedWindupStartAt,
            nextAutoAt = baseState.nextAutoAt or baseState.rangedSwingAt,
        }

        local nowEff = baseState.nowEffective or now
        local untilAt = self.state.shiftHold.untilAt or 0
        print(string.format(
            "SHIFT_SET holdSpell=%s now=%.2f nowEff=%.2f untilAt=%.2f inPastVsNowEff=%s windupStartAt=%.2f nextAutoAt=%.2f",
            tostring(self.state.shiftHold.spellId or "-"),
            tonumber(now) or 0,
            tonumber(nowEff) or 0,
            tonumber(untilAt) or 0,
            (untilAt < nowEff) and "1" or "0",
            tonumber(self.state.shiftHold.windupStartAt) or 0,
            tonumber(self.state.shiftHold.nextAutoAt) or 0
        ))
    else
        self.state.shiftHold = nil
    end

    local oldA1Id = oldA1 and oldA1.spellId or "-"
    local newA1Id = shifted[1] and shifted[1].spellId or "-"
    local oldA2Id = stable[2] and stable[2].spellId or "-"
    local oldA3Id = stable[3] and stable[3].spellId or "-"
    local newA2Id = shifted[2] and shifted[2].spellId or "-"
    print(string.format(
        "SHIFT_ON_CAST_START spell=%s oldA1=%s newA1=%s planId=%d",
        tostring(castSpellId or "-"),
        tostring(oldA1Id),
        tostring(newA1Id),
        self.state.planId or 0
    ))
    print(string.format(
        "SHIFT_DETAILS oldA2=%s oldA3=%s newA2=%s (A2 becomes oldA3 on shift)",
        tostring(oldA2Id),
        tostring(oldA3Id),
        tostring(newA2Id)
    ))

    self.state.castStartSpellId = nil
    if castMatchesPending then
        self.state.pendingCast = nil
    end

    return self.state.stableActions
end

-- ============================ PREDICTION DEBUG ============================

--- Print UNREACHABLE debug lines when an action press time is before planning anchors.
--- This is intentionally unthrottled (fires only on the problematic condition).
--- @param self table
--- @param now number
--- @param baseState table|nil
--- @param actions table|nil
local function PrintUnreachableActions(self, now, baseState, actions)
    if not baseState or not actions then
        return
    end

    local nowEff = baseState.nowEffective or baseState.now or now
    local gcdReadyAt = baseState.gcdReadyAt or now
    local castEndAt = baseState.castEndAt or now
    local gcdRem = max(0, gcdReadyAt - now)
    local castRem = max(0, castEndAt - now)

    local nextAutoAt = baseState.nextAutoAt or baseState.rangedSwingAt
    local windupStartAt = baseState.rangedWindupStartAt
    local shiftHold = self.state.shiftHold
    local lockedA1WindupStartAt = self.state.lockedA1WindupStartAt

    for i = 1, 3 do
        local a = actions[i]
        if a and (a.pressAt or a.castStartAt) then
            local pressAt = a.pressAt or a.castStartAt
            local earliest = a.earliestPressAt or pressAt
            local latest = a.latestSafePressAt or pressAt

            -- Validity is based on the window END, not on pressAt.
            -- If pressAt slipped slightly into the past but we are still within the safe window,
            -- treat it as "late inside window" instead of unreachable (prevents flicker).
            local winEnd = latest
            local deltaNowEff = (nowEff or 0) - (pressAt or 0)
            local deltaWinEnd = (nowEff or 0) - (winEnd or 0)

            local isUnreachable = (winEnd or 0) > 0 and (nowEff > (winEnd + PRESS_EPS))
            local isLateInsideWindow = (not isUnreachable) and (pressAt < (nowEff - PRESS_EPS)) and (nowEff <= (winEnd + PRESS_EPS))

            if isUnreachable or isLateInsideWindow then
                local kindLabel = isUnreachable and "UNREACHABLE" or "LATE_INSIDE_WINDOW"
                print(string.format(
                    "%s slot=A%d spell=%s kind=%s pressAt=%.2f win=%.2f..%.2f nowEff=%.2f gcdRA=%.2f gcdRem=%.2f castEA=%.2f castRem=%.2f delta[nowEff=%.3f winEnd=%.3f] WIN_SRC[gcdRA=%.2f castEA=%.2f nextAutoAt=%.2f windupStartAt=%.2f shiftHoldUntil=%.2f lockedA1Windup=%.2f]",
                    kindLabel,
                    i,
                    tostring(a.spellId or "-"),
                    tostring(a.kind or "-"),
                    tonumber(pressAt) or 0,
                    tonumber(earliest) or 0,
                    tonumber(latest) or 0,
                    tonumber(nowEff) or 0,
                    tonumber(gcdReadyAt) or 0,
                    tonumber(gcdRem) or 0,
                    tonumber(castEndAt) or 0,
                    tonumber(castRem) or 0,
                    tonumber(deltaNowEff) or 0,
                    tonumber(deltaWinEnd) or 0,
                    tonumber(gcdReadyAt) or 0,
                    tonumber(castEndAt) or 0,
                    tonumber(nextAutoAt) or 0,
                    tonumber(windupStartAt) or 0,
                    tonumber(shiftHold and shiftHold.untilAt) or 0,
                    tonumber(lockedA1WindupStartAt) or 0
                ))
            end
        end
    end
end

--- Ensure action objects have stable timing/cd/block fields (used by bars + debug).
--- This is intentionally conservative: it never overwrites simulation-derived blockedAtPress
--- if it already exists, but it will always refresh blockedNow from LIVE snapshot anchors.
--- @param baseState table
--- @param now number
--- @param actions table|nil
local function FinalizeActionsForDisplayAndDebug(baseState, now, actions)
    if not baseState or not actions then
        return
    end

    for i = 1, 3 do
        local a = actions[i]
        if a then
            a.pressAt = a.pressAt or a.castStartAt or now
            a.castStartAt = a.castStartAt or a.pressAt
            a.endAt = a.endAt or a.castStartAt
            a.earliestPressAt = a.earliestPressAt or a.pressAt
            a.latestSafePressAt = a.latestSafePressAt or a.pressAt
            -- Never recommend pressing before the window starts.
            if a.pressAt and a.earliestPressAt then
                a.pressAt = max(a.pressAt, a.earliestPressAt)
            end

            if a.kind == ACTION_KINDS.MULTI then
                a.cdReadyAt = a.cdReadyAt or baseState.multiCdReadyAt
            elseif a.kind == ACTION_KINDS.ARCANE then
                a.cdReadyAt = a.cdReadyAt or baseState.arcaneCdReadyAt
            end

            a.cdRem = a.cdReadyAt and max(0, (a.cdReadyAt or now) - now) or nil

            -- Display-only timing: include actionable anchors (GCD/cast/CD) without mutating planner time.
            -- IMPORTANT: use raw time for smooth countdowns; gcdReadyAt/castEndAt already encode locks.
            local nowRaw = baseState.now or now
            local actionableAt = max(
                nowRaw,
                baseState.gcdReadyAt or nowRaw,
                baseState.castEndAt or nowRaw,
                a.cdReadyAt or 0
            )
            a.actionableAt = actionableAt
            a.displayPressAt = max(a.pressAt or nowRaw, actionableAt)

            -- blockedNow must always be computed from LIVE anchors.
            a.blockedNow = ComputeBlockedByAtPress(
                now,
                baseState.gcdReadyAt or now,
                baseState.castEndAt or now,
                a.cdReadyAt
            )

            -- If a plan source didn't set blockedAtPress (e.g. tail recompute/shifted-only rebuild),
            -- compute a best-effort value from current anchors and the action window.
            if a.blockedAtPress == nil and (a.displayPressAt or a.pressAt) then
                a.blockedAtPress = ComputeBlockedByAtPress(
                    a.displayPressAt or a.pressAt,
                    baseState.gcdReadyAt or now,
                    baseState.castEndAt or now,
                    a.cdReadyAt
                )
                a.blockedBy = a.blockedBy or a.blockedAtPress
            end
        end
    end
end

--- Print compact timeline debug line (always on during debugging).
--- @param self table
--- @param now number
--- @param baseState table|nil
local function PrintDebugLine(self, now, baseState)
    if not self._lastDebugPrintAt then
        self._lastDebugPrintAt = 0
    end
    if (now - self._lastDebugPrintAt) < DEBUG_THROTTLE_SECONDS then
        return
    end
    self._lastDebugPrintAt = now

    local stable = self.state.stableActions
    if baseState and stable then
        FinalizeActionsForDisplayAndDebug(baseState, now, stable)
    end

    local a1 = stable and stable[1] or nil
    local a2 = stable and stable[2] or nil
    local a3 = stable and stable[3] or nil

    local pendingCast = self.state.pendingCast
    local castStartSpellId = self.state.castStartSpellId
    local nilReasons = self.state._lastNilReasons or {}

    local nextAutoAt = baseState and (baseState.nextAutoAt or baseState.rangedSwingAt) or nil
    local windupStartAt = baseState and (baseState.rangedWindupStartAt or (nextAutoAt and (nextAutoAt - (baseState.rangedWindupSeconds or 0.5)))) or nil
    local inWindup = (nextAutoAt and windupStartAt) and (now >= windupStartAt and now < nextAutoAt) or false

    local nowEffective = baseState and baseState.nowEffective or now
    local gcdReadyAt = baseState and (baseState.gcdReadyAt or now) or now
    local castEndAt = baseState and (baseState.castEndAt or now) or now
    local gcdRem = max(0, gcdReadyAt - now)
    local castRem = max(0, castEndAt - now)
    local hasRealCast = baseState and (baseState.hasRealCast and true or false) or false

    local tailInfo = self.state._tailFreezeInfo or {}
    local shiftHold = self.state.shiftHold
    local lockedA1 = self.state.lockedA1

    local function fmtNum(x)
        if x == nil then return "-" end
        return string.format("%.2f", tonumber(x) or 0)
    end

    local function fmtSlot(i, a)
        if not a then
            return string.format("A%d=- nil=%s", i, tostring(nilReasons[i] or "NO_PLAN"))
        end

        local kind = tostring(a.kind or "-")
        local sid = tostring(a.spellId or "-")
        local winLo = fmtNum(a.earliestPressAt)
        local winHi = fmtNum(a.latestSafePressAt)
        local pressAt = fmtNum(a.pressAt)
        local cdReadyAt = fmtNum(a.cdReadyAt)
        local cdRem = a.cdRem and fmtNum(a.cdRem) or "-"
        local blkP = tostring(a.blockedAtPress or a.blockedBy or "-")
        local blkN = tostring(a.blockedNow or "-")

        return string.format(
            "A%d=%s/%s win=%s..%s press=%s cdRA=%s cdRem=%s blkP=%s blkN=%s",
            i,
            kind,
            sid,
            winLo,
            winHi,
            pressAt,
            cdReadyAt,
            cdRem,
            blkP,
            blkN
        )
    end

    local pendingStr = "-"
    if pendingCast then
        pendingStr = string.format("%s@%s", tostring(pendingCast.spellId or "-"), fmtNum(pendingCast.endAt))
    end

    local shiftHoldStr = "-"
    if shiftHold then
        shiftHoldStr = string.format(
            "%s@%s",
            tostring(shiftHold.spellId or "-"),
            fmtNum(shiftHold.untilAt)
        )
    end

    local lockedStr = lockedA1 and tostring(lockedA1) or "-"

    local line = string.format(
        "NAG TL | planId=%d now=%.2f nowEff=%.2f hasRealCast=%s gcdRA=%s gcdRem=%.2f castEA=%s castRem=%.2f nextAutoAt=%s windupStartAt=%s castStartSpellId=%s pendingCast=%s inWindup=%s shiftHold=%s lockedA1=%s tailFreeze=%s keptA2=%s keptA3=%s | %s | %s | %s",
        tonumber(self.state.planId) or 0,
        now,
        tonumber(nowEffective) or now,
        hasRealCast and "1" or "0",
        fmtNum(gcdReadyAt),
        tonumber(gcdRem) or 0,
        fmtNum(castEndAt),
        tonumber(castRem) or 0,
        fmtNum(nextAutoAt),
        fmtNum(windupStartAt),
        tostring(castStartSpellId or "-"),
        pendingStr,
        inWindup and "1" or "0",
        shiftHoldStr,
        lockedStr,
        (tailInfo.active and "1" or "0"),
        (tailInfo.keptA2 and "1" or "0"),
        (tailInfo.keptA3 and "1" or "0"),
        fmtSlot(1, a1),
        fmtSlot(2, a2),
        fmtSlot(3, a3)
    )
    print(line)
end

-- ============================ VALIDATION HARNESS ============================

--- Slash command handler for /nag hunter-timeline-validate
function HunterFutureTimeline:RunTimelineValidate()
    self:SimulateAndPrintEvents(nil, 6)
end

--- Simulate forward and print event list for validation.
--- Events: AUTO, WINDUP_START, PRESS Spell, CAST_START, CAST_END
--- Validates: no non-queued cast crosses windupStartAt; no queued cast delays followingAutoAt
--- @param snapshot table|nil Optional; if nil, builds from current state
--- @param durationSeconds number Seconds to simulate (default 6)
function HunterFutureTimeline:SimulateAndPrintEvents(snapshot, durationSeconds)
    durationSeconds = durationSeconds or 6
    local baseState = snapshot or BuildLiveSnapshot(self)
    if not baseState then
        self:Print("HunterTimeline: SimulateAndPrintEvents - no snapshot available")
        return
    end

    local events = {}
    local function addEvent(t, kind, detail)
        events[#events + 1] = { t = t, kind = kind, detail = detail or "" }
    end

    local state = {
        now = baseState.now,
        gcdValue = baseState.gcdValue,
        gcdReadyAt = baseState.gcdReadyAt,
        castEndAt = baseState.castEndAt,
        rangedSwingSpeed = baseState.rangedSwingSpeed,
        rangedSwingAt = baseState.rangedSwingAt,
        nextAutoAt = baseState.nextAutoAt or baseState.rangedSwingAt,
        rangedWindupSeconds = baseState.rangedWindupSeconds,
        rangedWindupStartAt = baseState.rangedWindupStartAt,
        latencySeconds = baseState.latencySeconds,
        steadyCastSeconds = baseState.steadyCastSeconds,
        multiCastSeconds = baseState.multiCastSeconds,
        arcaneCastSeconds = baseState.arcaneCastSeconds,
        multiCdReadyAt = baseState.multiCdReadyAt,
        arcaneCdReadyAt = baseState.arcaneCdReadyAt,
        enableWeaving = baseState.enableWeaving,
        meleeOk = baseState.meleeOk,
        meleeSwingSpeed = baseState.meleeSwingSpeed,
        meleeSwingAt = baseState.meleeSwingAt,
        lastActionKind = nil,
    }
    NormalizeRangedSchedule(state)

    local endTime = state.now + durationSeconds
    local speed = state.rangedSwingSpeed or 0
    local violations = {}

    -- Collect auto/windup events from fixed schedule
    local t = state.nextAutoAt or state.rangedSwingAt or state.now
    while t <= endTime and speed > 0 do
        local windupStart = t - (state.rangedWindupSeconds or 0.5)
        if windupStart >= state.now then
            addEvent(windupStart, "WINDUP_START", "")
        end
        addEvent(t, "AUTO", "")
        t = t + speed
    end

    -- Simulate actions and collect PRESS/CAST_START/CAST_END
    for i = 1, 20 do
        if state.now >= endTime then
            break
        end
        local chosen = ChooseNextAction(state)
        if not chosen then
            break
        end

        local spellName = chosen.spellId and tostring(chosen.spellId) or chosen.kind or "?"
        addEvent(chosen.pressAt or state.now, "PRESS", spellName)
        addEvent(chosen.castStartAt or chosen.pressAt, "CAST_START", spellName)
        addEvent(chosen.endAt or chosen.castStartAt, "CAST_END", spellName)

        local windupStartAt = state.rangedWindupStartAt or (state.nextAutoAt or state.rangedSwingAt) - (state.rangedWindupSeconds or 0.5)
        local nextAutoAt = state.nextAutoAt or state.rangedSwingAt
        local followingAutoAt = nextAutoAt + speed

        if chosen.queued then
            if chosen.endAt > followingAutoAt then
                violations[#violations + 1] = string.format("QUEUED cast %s endAt %.3f > followingAutoAt %.3f", spellName, chosen.endAt, followingAutoAt)
            end
        else
            if chosen.endAt > windupStartAt then
                violations[#violations + 1] = string.format("NON-QUEUED cast %s endAt %.3f > windupStartAt %.3f", spellName, chosen.endAt, windupStartAt)
            end
        end

        ApplyAction(state, chosen)
    end

    -- Sort by time
    table.sort(events, function(a, b) return a.t < b.t end)

    self:Print("=== HunterTimeline SimulateAndPrintEvents (%.1fs) ===", durationSeconds)
    for _, ev in ipairs(events) do
        if ev.t >= baseState.now and ev.t <= endTime then
            self:Print("[%.3f] %s %s", ev.t - baseState.now, ev.kind, ev.detail)
        end
    end
    if #violations > 0 then
        self:Print("VIOLATIONS:")
        for _, v in ipairs(violations) do
            self:Print("  %s", v)
        end
    else
        self:Print("Validation OK")
    end
end

-- ============================ PUBLIC API ============================

--- Two-spark timing API: computes next SS and next filler actionable press moments.
--- This is a simplified no-weaving predictor whose only invariant is: never clip Auto Shot.
--- @param opts table|nil Optional {force:boolean}
--- @return table|nil timing
function HunterFutureTimeline:GetNextTiming(opts)
    if not self.db or not self.db.char.enabled then
        return nil
    end

    local now = GetTime()
    local interval = (self.db.class and self.db.class.updateIntervalSeconds) or 0.05
    local force = opts and opts.force or false
    if not force and self.state.lastTimingAt and (now - self.state.lastTimingAt) < interval then
        return self.state.lastTiming
    end
    self.state.lastTimingAt = now

    local latencySeconds = (self.db and self.db.class and (self.db.class.latencyMs or 0) or 0) / 1000

    local autoShotOn = false
    local HunterWeaveModule = NAG:GetModule("HunterWeaveModule", true)
    if HunterWeaveModule and HunterWeaveModule.HunterIsAutoShooting then
        autoShotOn = HunterWeaveModule:HunterIsAutoShooting()
    elseif _G.IsAutoRepeatSpell and _G.IsAutoRepeatSpell(AUTO_SHOT_SPELL_ID) then
        autoShotOn = true
    end

    local rangedSpeed = nil
    local shootAt, shootSrc = nil, "AUTO_OFF"
    local rangedExpiration = nil
    rangedSpeed, rangedExpiration = GetRangedSpeedAndExpiration(now)
    local windupSeconds = GetWindupSecondsForWarmup(self, rangedSpeed)
    if autoShotOn then
        shootAt, shootSrc = ComputeShootAt(self, now, autoShotOn, windupSeconds)
    end

    -- If we cannot resolve a speed, we cannot make meaningful timing promises.
    if not rangedSpeed or rangedSpeed <= 0 then
        local timingNil = {
            now = now,
            autoShotOn = autoShotOn,
            shootAt = shootAt,
            windupStartAt = shootAt and (shootAt - windupSeconds) or nil,
            ss = { spellId = autoShotOn and SPELL_IDS.STEADY_SHOT or AUTO_SHOT_SPELL_ID, allowed = false, rejectReason = "NO_RANGED_SPEED" },
            filler = { allowed = false, rejectReason = "NO_RANGED_SPEED" },
        }
        self.state.lastTiming = timingNil
        return timingNil
    end

    local gcdValue, gcdReadyAt, hasRealCast, castEndAt = ComputeGCDAndCastAnchors(now, latencySeconds)
    local nowEff = ComputeNowEffective(now, gcdReadyAt, castEndAt)

    local multiCdReadyAt, arcaneCdReadyAt = ComputeFillerCooldowns(self, now, gcdValue)
    local steadyCastSeconds = ComputeSteadyCastSeconds(rangedSpeed)
    local multiCastSeconds = TIMING.MULTI_CAST_SECONDS
    local arcaneCastSeconds = 0.0

    local windupStartAt = shootAt and (shootAt - windupSeconds) or nil

    -- Warm-up rule: if Auto Shot is off, prompt enabling it and do nothing else.
    if not autoShotOn then
        local t = {
            now = now,
            nowEff = nowEff,
            autoShotOn = false,
            shootAt = nil,
            windupStartAt = nil,
            gcdReadyAt = gcdReadyAt,
            castEndAt = castEndAt,
            rangedSpeed = rangedSpeed,
            ss = {
                spellId = AUTO_SHOT_SPELL_ID,
                kind = "AUTO",
                actionableAt = nowEff,
                pressAt = nowEff,
                displayPressAt = nowEff,
                allowed = true,
                rejectReason = nil,
            },
            filler = { allowed = false, rejectReason = "AUTO_OFF" },
        }
        PrintTimingDebug(self, now, string.format("NAG TL2 | auto=0 ss=AUTO pressIn=%.2f filler=-", max(0, (t.ss.displayPressAt or now) - now)))
        self.state.lastTiming = t
        return t
    end

    -- If shootAt is missing for any reason, treat as idle.
    if not shootAt or shootAt <= 0 then
        local t = {
            now = now,
            nowEff = nowEff,
            autoShotOn = true,
            shootAt = nil,
            windupStartAt = nil,
            gcdReadyAt = gcdReadyAt,
            castEndAt = castEndAt,
            rangedSpeed = rangedSpeed,
            ss = { allowed = false, rejectReason = "NO_SHOOTAT" },
            filler = { allowed = false, rejectReason = "NO_SHOOTAT" },
        }
        self.state.lastTiming = t
        return t
    end

    local pressEps = PRESS_EPS
    local reaction = TIMING.REACTION_SECONDS

    -- Minimal state: whether we are allowed to suggest a filler before the next SS.
    local afterSSOk = (self.state.lastSSAt ~= nil) and (not self.state.fillerUsedSinceLastSS)
    local speedOk = rangedSpeed > TIMING.FILLER_MIN_SWING_SECONDS

    -- Phase choice: if we are in the "after SS" gap, filler is the next opportunity; otherwise SS is.
    local preferFillerFirst = afterSSOk and true or false

    local function ssCandidate(stateNow, stateNowEff, stateGcdAt, stateCastEndAt, stateShootAt, stateWindupSeconds, stateSwingSpeed)
        local actionableAt = ComputeActionableAt(stateNow, stateNowEff, stateGcdAt, stateCastEndAt, nil)
        local doneAt = actionableAt + steadyCastSeconds
        local ok = (doneAt + reaction + latencySeconds) <= (stateShootAt + pressEps)
        local pressAt = actionableAt
        local displayPressAt = max(pressAt, actionableAt)
        local reason = nil
        if not ok then
            -- Defer to next cycle windup when we cannot safely fit this cycle.
            local nextCycleWindupAt = (stateShootAt + (stateSwingSpeed or rangedSpeed or 0)) - (stateWindupSeconds or windupSeconds or 0.50)
            if nextCycleWindupAt and nextCycleWindupAt > displayPressAt then
                displayPressAt = nextCycleWindupAt
                pressAt = nextCycleWindupAt
            end
            reason = "NO_CLIP_FAIL"
        end
        return {
            spellId = SPELL_IDS.STEADY_SHOT,
            kind = ACTION_KINDS.STEADY,
            actionableAt = actionableAt,
            pressAt = pressAt,
            displayPressAt = displayPressAt,
            allowed = ok,
            rejectReason = reason,
        }
    end

    local function fillerCandidate(stateNow, stateNowEff, stateGcdAt, stateCastEndAt, stateShootAt)
        local gateReason = nil
        if not speedOk then
            gateReason = "REJECT_SPEED"
        elseif not afterSSOk then
            gateReason = "REJECT_AFTER_SS"
        end

        if gateReason then
            return { allowed = false, rejectReason = gateReason }
        end

        local msCdReady = (multiCdReadyAt or 0) <= stateNow
        local kind, spellId, castSeconds, cdReadyAt
        if msCdReady then
            kind, spellId, castSeconds, cdReadyAt = ACTION_KINDS.MULTI, SPELL_IDS.MULTI_SHOT, multiCastSeconds, multiCdReadyAt
        else
            -- AR only when MS is on cooldown.
            kind, spellId, castSeconds, cdReadyAt = ACTION_KINDS.ARCANE, SPELL_IDS.ARCANE_SHOT, arcaneCastSeconds, arcaneCdReadyAt
        end
        if cdReadyAt and cdReadyAt > stateNow and kind == ACTION_KINDS.ARCANE then
            return { allowed = false, rejectReason = "REJECT_CD" }
        end

        local actionableAt = ComputeActionableAt(stateNow, stateNowEff, stateGcdAt, stateCastEndAt, cdReadyAt)
        if actionableAt + reaction > (stateShootAt + pressEps) then
            return {
                spellId = spellId,
                kind = kind,
                actionableAt = actionableAt,
                pressAt = actionableAt,
                displayPressAt = actionableAt,
                allowed = false,
                rejectReason = "REJECT_GAP",
            }
        end
        local doneAt = actionableAt + (castSeconds or 0)
        local ok = (doneAt + reaction + latencySeconds) <= (stateShootAt + pressEps)
        return {
            spellId = spellId,
            kind = kind,
            actionableAt = actionableAt,
            pressAt = actionableAt,
            displayPressAt = actionableAt,
            allowed = ok,
            rejectReason = ok and nil or "REJECT_NOCLIP",
        }
    end

    -- Schedule in two steps (SS/filler order depends on whether we are already after an SS).
    local ss = nil
    local filler = nil

    if preferFillerFirst then
        filler = fillerCandidate(now, nowEff, gcdReadyAt, castEndAt, shootAt)
        -- Next SS is after the upcoming auto (we assume filler occupies the remainder of this swing).
        local ssAfterAt = max(nowEff, shootAt)
        ss = ssCandidate(now, ssAfterAt, max(gcdReadyAt, ssAfterAt), castEndAt, (shootAt + rangedSpeed), windupSeconds, rangedSpeed)
        ss.rejectReason = ss.allowed and nil or (ss.rejectReason or "NO_CLIP")
    else
        ss = ssCandidate(now, nowEff, gcdReadyAt, castEndAt, shootAt, windupSeconds, rangedSpeed)
        if ss.allowed then
            -- Simulate SS consuming cast + GCD to see if a filler fits before the same shootAt.
            local ssPressAt = ss.pressAt or nowEff
            local ssCastEndAt = ssPressAt + steadyCastSeconds
            local ssGcdReadyAt = ssPressAt + gcdValue + latencySeconds
            local postNowEff = ComputeNowEffective(now, ssGcdReadyAt, ssCastEndAt)

            -- During the SS window, fillers are not considered; after SS, fillers become eligible.
            local savedAfter = afterSSOk
            afterSSOk = true
            filler = fillerCandidate(now, postNowEff, ssGcdReadyAt, ssCastEndAt, shootAt)
            afterSSOk = savedAfter
        else
            filler = { allowed = false, rejectReason = "SS_BLOCKS" }
        end
    end

    -- Single gating debug line (why filler is blocked).
    local gcdAt = max(nowEff, gcdReadyAt or nowEff, castEndAt or nowEff)
    local gapOk = (gcdAt + reaction) < shootAt
    local fillerReject = (filler and filler.rejectReason) or "OK"
    PrintTimingDebug(self, now, string.format(
        "FILLER_GATE reason=%s speedOk=%d afterSS=%d gapOk=%d gcdAt=%.2f shootAt=%.2f now=%.2f",
        tostring(fillerReject),
        speedOk and 1 or 0,
        ((self.state.lastSSAt ~= nil) and (not self.state.fillerUsedSinceLastSS)) and 1 or 0,
        gapOk and 1 or 0,
        tonumber(gcdAt) or 0,
        tonumber(shootAt) or 0,
        tonumber(now) or 0
    ))

    PrintTimingDebug(self, now, string.format(
        "NAG TL2 | shootAt=%.2f ssAt=%.2f ssReject=%s fillerAt=%.2f fillerReject=%s",
        tonumber(shootAt) or -1,
        tonumber(ss and ss.displayPressAt or -1) or -1,
        tostring(ss and ss.rejectReason or "OK"),
        tonumber(filler and filler.displayPressAt or -1) or -1,
        tostring(filler and filler.rejectReason or "OK")
    ))

    local t = {
        now = now,
        nowEff = nowEff,
        autoShotOn = true,
        shootAt = shootAt,
        shootSrc = shootSrc,
        windupSeconds = windupSeconds,
        windupStartAt = windupStartAt,
        gcdValue = gcdValue,
        gcdReadyAt = gcdReadyAt,
        castEndAt = castEndAt,
        hasRealCast = hasRealCast,
        rangedSpeed = rangedSpeed,
        multiCdReadyAt = multiCdReadyAt,
        arcaneCdReadyAt = arcaneCdReadyAt,
        ss = ss,
        filler = filler,
    }

    -- Stable SS countdown anchor for UI:
    -- Start from next windup gap, then delay it if a valid filler should be sent first.
    local ssGapAt = shootAt - (windupSeconds or 0.50)
    if rangedSpeed and rangedSpeed > 0 then
        local guard = 0
        while ssGapAt <= now and guard < 10 do
            ssGapAt = ssGapAt + rangedSpeed
            guard = guard + 1
        end
    end
    if filler and filler.allowed and filler.displayPressAt then
        local fillerCast = 0.0
        if filler.kind == ACTION_KINDS.MULTI then
            fillerCast = multiCastSeconds or TIMING.MULTI_CAST_SECONDS
        end
        local fillerDoneAt = filler.displayPressAt + fillerCast + reaction + latencySeconds
        if fillerDoneAt > ssGapAt then
            ssGapAt = fillerDoneAt
        end
    end
    t.ssGapAt = ssGapAt

    self.state.lastTiming = t
    return t
end

--- Get the next actions (A1..An) using SIM-style forward timing.
--- Returns a stabilized (anti-flicker) list by default.
--- @param count number|nil Number of actions to simulate (default 3)
--- @param opts table|nil Optional flags
--- @return table|nil actions Array of {spellId, kind, pressAt, castStartAt, endAt, queued, gcdReadyAt, notes}
function HunterFutureTimeline:GetNextActions(count, opts)
    if not self.db or not self.db.char.enabled then
        return nil
    end

    count = count or 3
    if not count or count <= 0 then
        return nil
    end

    local now = GetTime()
    local interval = (self.db.class and self.db.class.updateIntervalSeconds) or 0.05
    local force = opts and opts.force or false
    if not force and self.state.lastComputeAt and (now - self.state.lastComputeAt) < interval then
        return self.state.stableActions
    end

    self.state.lastComputeAt = now

    local baseState = BuildLiveSnapshot(self)
    self.state.baseStateForTick = baseState
    if not baseState then
        -- B1: Idle (auto off or no valid ranged timer) - return nil, clear stale state.
        self.state.stableActions = nil
        self.state.lockedA1 = nil
        self.state.lockedA1WindupStartAt = nil
        self.state.pendingCast = nil
        self.state._lastNilReasons = { "NO_PLAN", "NO_PLAN", "NO_PLAN" }
        self.state._tailFreezeInfo = { active = false, keptA2 = false, keptA3 = false }
        PrintDebugLine(self, now, nil)
        return nil
    end

    -- Compute effective planning anchor while casting/GCD-locked.
    -- This prevents "snap back" selection churn during an active cast.
    local gcdRemNow = max(0, (baseState.gcdReadyAt or now) - now)
    if baseState.hasRealCast or gcdRemNow > 0 then
        baseState.nowEffective = max(now, baseState.castEndAt or now, baseState.gcdReadyAt or now)
    else
        baseState.nowEffective = now
    end
    local nowEff = baseState.nowEffective or now
    self.state.lastNowEffective = nowEff

    -- Queued-windup logic is disabled while a real cast is active.
    baseState.disableWindupQueue = baseState.hasRealCast and true or false

    -- Freeze plan before any recompute/mutation; shift must consume this exact plan.
    local prevStable = ShallowCopyActions(self.state.stableActions)

    -- Clear stale pending cast before any pending-cast based decisions.
    if self.state.pendingCast and now >= (self.state.pendingCast.endAt or 0) then
        self.state.pendingCast = nil
    end
    -- Pending cast should keep cast lock alive only if we do NOT already have a real cast.
    if (not baseState.hasRealCast) and self.state.pendingCast and (self.state.pendingCast.endAt or 0) > (baseState.castEndAt or 0) then
        baseState.castEndAt = self.state.pendingCast.endAt
        print(("PENDINGCAST_APPLIED spell=%s endAt=%.2f"):format(
            tostring(self.state.pendingCast.spellId or "-"),
            tonumber(self.state.pendingCast.endAt) or 0
        ))
    end

    -- Preserve SHIFTed plan until it is actionable or expired (prevents immediate snap-back).
    if self.state.shiftHold and self.state.stableActions and self.state.stableActions[1] then
        local a1Hold = self.state.stableActions[1]
        local holdSpellId = self.state.shiftHold.spellId
        local holdUntilAt = self.state.shiftHold.untilAt or 0
        local windupDelta = self.state.shiftHold.windupStartAt and baseState.rangedWindupStartAt and abs(baseState.rangedWindupStartAt - self.state.shiftHold.windupStartAt) or 0
        local autoDelta = self.state.shiftHold.nextAutoAt and baseState.nextAutoAt and abs(baseState.nextAutoAt - self.state.shiftHold.nextAutoAt) or 0

        local sameA1 = holdSpellId and a1Hold.spellId == holdSpellId
        -- Expiry must be checked against effective anchors, not raw now.
        -- Otherwise shiftHold can be preserved even when it is already in the past vs nowEff.
        local notExpired = nowEff <= holdUntilAt
        local timelineStable = (windupDelta <= 0.08) and (autoDelta <= 0.08)
        local differentCastStarted = self.state.castStartSpellId and (self.state.castStartSpellId ~= a1Hold.spellId)

        if sameA1 and notExpired and timelineStable and (not differentCastStarted) then
            FinalizeActionsForDisplayAndDebug(baseState, now, self.state.stableActions)
            PrintUnreachableActions(self, now, baseState, self.state.stableActions)
            local untilAt = self.state.shiftHold and self.state.shiftHold.untilAt or 0
            print(string.format(
                "SHIFT_APPLY holdSpell=%s now=%.2f nowEff=%.2f untilAt=%.2f inPastVsNowEff=%s notExpired=%s timelineStable=%s",
                tostring(holdSpellId or "-"),
                tonumber(now) or 0,
                tonumber(nowEff) or 0,
                tonumber(untilAt) or 0,
                (untilAt < nowEff) and "1" or "0",
                notExpired and "1" or "0",
                timelineStable and "1" or "0"
            ))
            PrintDebugLine(self, now, baseState)
            return self.state.stableActions
        end

        if not notExpired or not timelineStable or differentCastStarted or (not sameA1) then
            self.state.shiftHold = nil
        end
    end

    local HunterWeaveModule = NAG:GetModule("HunterWeaveModule", true)
    local autoShotOn = HunterWeaveModule and HunterWeaveModule.HunterIsAutoShooting and HunterWeaveModule:HunterIsAutoShooting()
    local context = {
        windupStartAt = baseState.rangedWindupStartAt or (baseState.nextAutoAt or baseState.rangedSwingAt) - (baseState.rangedWindupSeconds or 0.5),
        autoShotOn = autoShotOn,
    }

    local shifted = TryShiftOnCastStart(self, now, baseState, prevStable)
    if shifted then
        FinalizeActionsForDisplayAndDebug(baseState, now, shifted)
        PrintUnreachableActions(self, now, baseState, shifted)
        PrintDebugLine(self, now, baseState)
        return shifted
    end

    local rejectReasons = {}
    local rawActions = SimulateNextActions(baseState, count, rejectReasons)
    self.state.planId = (self.state.planId or 0) + 1
    self.state._lastNilReasons = { rejectReasons.NIL_A1, rejectReasons.NIL_A2, rejectReasons.NIL_A3 }
    self.state._tailFreezeInfo = { active = false, keptA2 = false, keptA3 = false }

    -- Stabilization/locking decisions must use the same effective anchor as planning.
    local stabilized = self:StabilizeActions(nowEff, rawActions, context)
    local a1 = stabilized and stabilized[1]
    -- Strict pendingCast gating:
    -- pendingCast must NEVER be synthesized just because A1 is queued.
    -- Only create it when we have evidence the player actually attempted the cast (UNIT_SPELLCAST_SENT).
    self.state.pendingCast = nil
    if a1 and a1.queued and a1.spellId and (not baseState.hasRealCast) then
        local attemptedSpellId = self.state.lastCastAttemptSpellId
        local attemptedAt = self.state.lastCastAttemptAt or 0
        local attemptedRecently = attemptedSpellId and attemptedSpellId == a1.spellId and (now - attemptedAt) <= 0.50

        local inQueuedGap = (now >= (a1.pressAt or 0)) and (now < (a1.castStartAt or now))
        if attemptedRecently and inQueuedGap then
            local pendingEndAt = a1.endAt or now
            if a1.spellId == SPELL_IDS.STEADY_SHOT then
                pendingEndAt = (a1.castStartAt or now) + (baseState.steadyCastSeconds or 0)
            end
            self.state.pendingCast = { spellId = a1.spellId, endAt = pendingEndAt }
        end
    end

    -- Secondary stabilization for A2/A3 while A1 is locked or while casting/GCD-locked.
    -- Invariant: when freezeTail is active, keep previous A2/A3 unless they are truly invalid/expired.
    local freezeTail = baseState.hasRealCast or ((baseState.gcdReadyAt or 0) > now) or (self.state.lockedA1 ~= nil)
    if freezeTail and prevStable and stabilized then
        local function tailKeepRefuseReason(a)
            if not a then
                return "NO_PREV"
            end
            local nowEff = baseState.nowEffective or now
            local latest = a.latestSafePressAt or a.pressAt or 0
            if latest > 0 and nowEff > (latest + PRESS_EPS) then
                return "EXPIRED"
            end
            if (a.kind == ACTION_KINDS.MULTI or a.kind == ACTION_KINDS.ARCANE) and a.cdReadyAt and latest > 0 and a.cdReadyAt > latest then
                return "INVALID_CD"
            end
            if not a.spellId then
                return "NO_SPELL"
            end
            return nil
        end

        -- Track freezeTail transitions (throttled to only print on change).
        local freezeReason = baseState.hasRealCast and "CASTING" or (((baseState.gcdReadyAt or 0) > now) and "GCD" or "LOCKED_A1")
        if self.state._lastFreezeTail ~= freezeTail then
            self.state._lastFreezeTail = freezeTail
            print(string.format("TAILFREEZE_%s reason=%s planId=%d", freezeTail and "ON" or "OFF", tostring(freezeReason), tonumber(self.state.planId) or 0))
        end

        local prevA2 = prevStable[2]
        local prevA3 = prevStable[3]
        local refuseA2 = tailKeepRefuseReason(prevA2)
        local refuseA3 = tailKeepRefuseReason(prevA3)
        local keptA2 = (refuseA2 == nil) and prevA2 or nil
        local keptA3 = (refuseA3 == nil) and prevA3 or nil

        -- If we refused keeping a previous tail slot, print why (throttled).
        if refuseA2 and prevA2 then
            local key = string.format("A2:%s@%d", tostring(refuseA2), tonumber(self.state.planId) or 0)
            if self.state._lastTailRefuseA2 ~= key then
                self.state._lastTailRefuseA2 = key
                print(string.format(
                    "TAILKEEP_REFUSED slot=A2 reason=%s prev=%s new=%s planId=%d",
                    tostring(refuseA2),
                    tostring(prevA2.spellId or "-"),
                    tostring((stabilized[2] and stabilized[2].spellId) or "-"),
                    tonumber(self.state.planId) or 0
                ))
            end
        end
        if refuseA3 and prevA3 then
            local key = string.format("A3:%s@%d", tostring(refuseA3), tonumber(self.state.planId) or 0)
            if self.state._lastTailRefuseA3 ~= key then
                self.state._lastTailRefuseA3 = key
                print(string.format(
                    "TAILKEEP_REFUSED slot=A3 reason=%s prev=%s new=%s planId=%d",
                    tostring(refuseA3),
                    tostring(prevA3.spellId or "-"),
                    tostring((stabilized[3] and stabilized[3].spellId) or "-"),
                    tonumber(self.state.planId) or 0
                ))
            end
        end

        if keptA2 then
            stabilized[2] = keptA2
            if keptA3 then
                stabilized[3] = keptA3
            else
                -- Recompute only tail (A3) from snapshot using A1 + kept A2.
                local tail = BuildShiftedActionsFromSnapshot(baseState, stabilized[1], stabilized[2])
                if tail and tail[3] then
                    stabilized[3] = tail[3]
                end
            end
            self.state.stableActions = ShallowCopyActions(stabilized)
        elseif keptA3 then
            -- We can keep A3 only if A2 is stable; otherwise keep neither.
            keptA3 = nil
        end

        self.state._tailFreezeInfo = { active = true, keptA2 = keptA2 ~= nil, keptA3 = keptA3 ~= nil }
    else
        self.state._lastFreezeTail = freezeTail and true or false
        if freezeTail then
            self.state._tailFreezeInfo = { active = true, keptA2 = false, keptA3 = false }
        end
    end

    FinalizeActionsForDisplayAndDebug(baseState, now, stabilized)
    PrintUnreachableActions(self, now, baseState, stabilized)
    PrintDebugLine(self, now, baseState)

    return stabilized
end

-- ============================ LIFECYCLE ============================

function HunterFutureTimeline:ModuleInitialize()
    if not self.state._revPrinted then
        self.state._revPrinted = true
        print("NAG HunterFutureTimeline.lua REV=2026-02-11-BLOCKEDNOW_LIVE_ANCHORS_DEBUGV2 path=NAG/modules/class/HunterFutureTimeline.lua")
    end
    -- No heavy work here; runtime logic is pull-based via GetNextActions().
    self.state.lastComputeAt = 0
    self.state.stableActions = nil
    self.state.pendingActions = nil
    self.state.pendingSince = 0
    self.state.pendingCast = nil
    self.state.planId = self.state.planId or 0
end

function HunterFutureTimeline:ModuleEnable()
    -- Pull-based module; nothing to register yet.
end

function HunterFutureTimeline:ModuleDisable()
    self.state.stableActions = nil
    self.state.pendingActions = nil
    self.state.pendingSince = 0
    self.state.lockedA1 = nil
    self.state.lockedA1WindupStartAt = nil
    self.state.autoShotWasOn = nil
    self.state.spellcastStartUnlock = false
    self.state.castStartSpellId = nil
    self.state.pendingCast = nil
end

